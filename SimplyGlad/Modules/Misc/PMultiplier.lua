local _G, error, table, type =
	  _G, error, table, type

local A 							= _G.Action
local CONST							= A.Const
local Player 						= A.Player
local Unit							= A.Unit
local Class 						= A.PlayerClass

local tremove						= table.remove
local UnitGUID 						= _G.UnitGUID
local GetTime						= _G.GetTime
local CreateFrame					= _G.CreateFrame
local issecretvalue					= _G.issecretvalue

local ListenedSpells 				= {}
local ListenedAuras 				= {}
local TimeSinceLastRemovedOnPlayer	= {}
local pendingCast					= {}
local dotAuraIIDs					= {}
local playerBuffIIDs				= {}

function A:RegisterPMultiplier(...)
	local Args = { ... }

	local SpellAura = self.ID
	local FirstArg = Args[1]
	if type(FirstArg) == "table" and FirstArg.ID then
		SpellAura = tremove(Args, 1).ID
	end

	ListenedAuras[SpellAura] = self.ID
	ListenedSpells[self.ID] = { Buffs = Args, Units = {} }
end

local function SpellRegisterError(Spell)
    local SpellName = Spell:Info()
    if SpellName then
        return "You forgot to register the spell: " .. SpellName .. " in PMultiplier handler."
    else
        return "You forgot to register the spell object."
    end
end

local function ComputePMultiplier(ListenedSpell)
	local PMultiplier = 1
	for j = 1, #ListenedSpell.Buffs do
		local Buff = ListenedSpell.Buffs[j]
		if type(Buff) == "function" then
			PMultiplier = PMultiplier * Buff()
		else
			local ThisSpell = Buff[1]
			local Modifier = Buff[2]

			if Unit("player"):HasBuffs(ThisSpell.ID, true) > 0 or (TimeSinceLastRemovedOnPlayer[ThisSpell.ID] and GetTime() - TimeSinceLastRemovedOnPlayer[ThisSpell.ID] < 0.1) then
				local ModifierType = type(Modifier)

				if ModifierType == "number" then
					PMultiplier = PMultiplier * Modifier
				elseif ModifierType == "function" then
					PMultiplier = PMultiplier * Modifier()
				end
			end
		end
	end

	return PMultiplier
end

local pmultFrame = CreateFrame("Frame")
pmultFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
pmultFrame:RegisterEvent("UNIT_AURA")
pmultFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
pmultFrame:SetScript("OnEvent", function(_, event, unit, ...)
	if event == "PLAYER_REGEN_ENABLED" then
		pendingCast = {}
		dotAuraIIDs = {}
		playerBuffIIDs = {}
		TimeSinceLastRemovedOnPlayer = {}
		return
	end

	if event == "UNIT_SPELLCAST_SUCCEEDED" then
		if unit ~= "player" then return end
		local _, spellID = ...
		if not spellID then return end
		if issecretvalue and issecretvalue(spellID) then return end

		local ListenedSpell = ListenedSpells[spellID]
		if not ListenedSpell then return end

		local PMult = ComputePMultiplier(ListenedSpell)
		local targetGUID = UnitGUID("target")

		if targetGUID and not (issecretvalue and issecretvalue(targetGUID)) then
			local Units = ListenedSpell.Units
			local Dot = Units[targetGUID]
			if Dot then
				Dot.PMultiplier = PMult
				Dot.Time = GetTime()
			else
				Units[targetGUID] = { PMultiplier = PMult, Time = GetTime(), Applied = false }
			end
		end

		pendingCast[spellID] = { mult = PMult, time = GetTime() }
		return
	end

	if event == "UNIT_AURA" then
		local updateInfo = ...
		if not unit or not updateInfo then return end

		local unitGUID = UnitGUID(unit)
		if not unitGUID then return end
		if issecretvalue and issecretvalue(unitGUID) then return end

		if updateInfo.addedAuras then
			for _, ad in ipairs(updateInfo.addedAuras) do
				local sid = ad.spellId
				if sid and not (issecretvalue and issecretvalue(sid)) then
					local castSpellID = ListenedAuras[sid]
					if castSpellID then
						local ListenedSpell = ListenedSpells[castSpellID]
						if ListenedSpell then
							local sourceUnit = ad.sourceUnit
							local isFromPlayer = false
							if sourceUnit and not (issecretvalue and issecretvalue(sourceUnit)) then
								isFromPlayer = (sourceUnit == "player")
							else
								local pending = pendingCast[castSpellID]
								if pending and (GetTime() - pending.time) < 1.0 then
									isFromPlayer = true
								end
							end

							if isFromPlayer then
								local Units = ListenedSpell.Units
								local Dot = Units[unitGUID]
								if Dot then
									Dot.Applied = true
								else
									local PMult = 1
									local pending = pendingCast[castSpellID]
									if pending and (GetTime() - pending.time) < 1.0 then
										PMult = pending.mult
									elseif Class == "ROGUE" then
										local S = A[CONST.ROGUE_ASSASSINATION]
										if S and S.ImprovedGarrote and S.Garrote and S.ImprovedGarroteAura and S.ImprovedGarroteBuff
										and S.ImprovedGarrote:IsExists() and sid == S.Garrote.ID
										and (Unit("player"):HasBuffs(S.ImprovedGarroteAura.ID, true) > 0 or Unit("player"):HasBuffs(S.ImprovedGarroteBuff.ID, true) > 0) then
											PMult = 1.5
										else
											PMult = ComputePMultiplier(ListenedSpell)
										end
									else
										PMult = ComputePMultiplier(ListenedSpell)
									end
									Units[unitGUID] = { PMultiplier = PMult, Time = GetTime(), Applied = true }
								end

								local iid = ad.auraInstanceID
								if iid and not (issecretvalue and issecretvalue(iid)) then
									dotAuraIIDs[iid] = { guid = unitGUID, castSpellID = castSpellID }
								end
							end
						end
					end

					if unit == "player" then
						local iid = ad.auraInstanceID
						if iid and not (issecretvalue and issecretvalue(iid)) then
							playerBuffIIDs[iid] = sid
						end
					end
				end
			end
		end

		if updateInfo.removedAuraInstanceIDs then
			for _, iid in ipairs(updateInfo.removedAuraInstanceIDs) do
				if not (issecretvalue and issecretvalue(iid)) then
					local tracked = dotAuraIIDs[iid]
					if tracked then
						local ListenedSpell = ListenedSpells[tracked.castSpellID]
						if ListenedSpell then
							local Dot = ListenedSpell.Units[tracked.guid]
							if Dot then
								Dot.Applied = false
							end
						end
						dotAuraIIDs[iid] = nil
					end

					if unit == "player" then
						local buffSID = playerBuffIIDs[iid]
						if buffSID then
							TimeSinceLastRemovedOnPlayer[buffSID] = GetTime()
							playerBuffIIDs[iid] = nil
						end
					end
				end
			end
		end
	end
end)

function Unit:PMultiplier(ThisSpell)
	local ListenedSpell = ListenedSpells[ThisSpell.ID]
	if not ListenedSpell then error(SpellRegisterError(ThisSpell)) end

	local Units = ListenedSpell.Units
	local guid = UnitGUID(self.UnitID)
	if not guid or (issecretvalue and issecretvalue(guid)) then return 0 end
	local Dot = Units[guid]

	return (Dot and Dot.Applied and Dot.PMultiplier) or 0
end

function Player:PMultiplier(ThisSpell)
	local ListenedSpell = ListenedSpells[ThisSpell.ID]
	if not ListenedSpell then error(SpellRegisterError(ThisSpell)) end

	return ComputePMultiplier(ListenedSpell)
end
