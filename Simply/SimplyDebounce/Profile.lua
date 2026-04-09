local _, SimplyDebouncePrivate = ...;
local NUM_SPECS          = GetNumSpecializationsForClassID(select(3, UnitClass("player")));

local Constants          = SimplyDebouncePrivate.Constants;
local luatype            = type;
local dump               = SimplyDebouncePrivate.dump;
local LayerArray         = {};

local KEYS_TO_SAVE       = {
    type = true,
    value = true,
    key = true,
    name = true,
    icon = true,
    unit = true,
    hover = true,
    reactions = true,
    frameTypes = true,
    groups = true,
    combat = true,
    stealth = true,
    forms = true,
    bonusbars = true,
    specialbar = true,
    extrabar = true,
    pet = true,
    petbattle = true,
    priority = true,
    ignoreHoverUnit = true,
    checkedUnits = true,
    ["$state1"] = true,
    ["$state2"] = true,
    ["$state3"] = true,
    ["$state4"] = true,
    ["$state5"] = true,
};

local LAYER_INFOS        = {
    [1] = { key = "GENERAL" },
    [2] = { key = Constants.PLAYER_CLASS, spec = 0 },
    [3] = { key = Constants.PLAYER_CLASS, spec = 1 },
    [4] = { key = Constants.PLAYER_CLASS, spec = 2 },
    [5] = { key = Constants.PLAYER_CLASS, spec = 3 },
    [6] = { key = Constants.PLAYER_CLASS, spec = 4 },
    [7] = { isCharacterSpecific = true, spec = 0 },
    [8] = { isCharacterSpecific = true, spec = 1 },
    [9] = { isCharacterSpecific = true, spec = 2 },
    [10] = { isCharacterSpecific = true, spec = 3 },
    [11] = { isCharacterSpecific = true, spec = 4 },
};


local ProfileLayerProto = {};

function ProfileLayerProto:Insert(action, insertIndex, keepId)
    if (insertIndex == nil) then
        insertIndex = #self.actions + 1;
    else
        if (luatype(insertIndex) == "table") then
            local before = insertIndex;
            insertIndex = nil;
            for i = 1, #self.actions do
                if (self.actions[i] == before) then
                    insertIndex = i;
                    break;
                end
            end
        elseif (insertIndex < 1) then
            insertIndex = 1;
        elseif (insertIndex > #self.actions + 1) then
            insertIndex = #self.actions + 1;
        end
    end

    tinsert(self.actions, insertIndex, action);
end

function ProfileLayerProto:Remove(action)
    local removed = false;
    for i = 1, #self.actions do
        if (self.actions[i] == action) then
            tremove(self.actions, i);
            removed = true;
            break;
        end
    end
    return removed;
end

function ProfileLayerProto:GetAction(index)
    return self.actions[index];
end

function ProfileLayerProto:GetNumActions()
    return #self.actions;
end

function ProfileLayerProto:Enumerate(indexBegin, indexEnd)
    return CreateTableEnumerator(self.actions, indexBegin, indexEnd);
end

local function MigrateLayer(layerTbl, dbver)
    if (layerTbl == nil) then
        return;
    end

    if (dbver == 1) then
        for i = 1, #layerTbl do
            local action = layerTbl[i];
            if (action.checkUnitExists and (Constants.BASIC_UNITS[action.unit] or Constants.SPECIAL_UNITS[action.unit])) then
                if (action.checkedUnits == nil or action.checkedUnits["@"] == nil) then
                    action.checkedUnits = action.checkedUnits or {};
                    action.checkedUnits["@"] = true;
                    action.checkUnitExists = nil;
                end
            end

            if (action.checkedUnit == true and action.unit ~= nil and action.unit ~= "none" and action.unit ~= "player") then
                if (action.checkedUnits == nil or action.checkedUnits["@"] == nil) then
                    action.checkedUnits = action.checkedUnits or {};
                    action.checkedUnits[action.unit] = action.checkedUnitValue;
                    action.checkedUnit = nil;
                    action.checkedUnitValue = nil;
                end
            end

            if ((Constants.BASIC_UNITS[action.checkedUnit] or Constants.SPECIAL_UNITS[action.checkedUnit]) and action.checkedUnitValue ~= nil) then
                if (action.checkedUnits == nil or action.checkedUnits[action.checkedUnit] == nil) then
                    action.checkedUnits = action.checkedUnits or {};
                    action.checkedUnits[action.checkedUnit] = action.checkedUnitValue;
                    action.checkedUnit = nil;
                    action.checkedUnitValue = nil;
                end
            end

            if (action.checkedUnits) then
                if (action.checkedUnits["pet"] ~= nil) then
                    if (action.checkedUnits["pet"]) then
                        action.pet = true;
                    else
                        action.pet = false;
                    end
                    action.checkedUnits["pet"] = nil;
                end
    
                if (next(action.checkedUnits) == nil) then
                    action.checkedUnits = nil;
                end
            end
        end
        dbver = 2;
    end
end

local function MigrateDB(db, isCharacterSpecific)
    if (db.dbver == 1) then
        if (isCharacterSpecific) then
            for spec = 0, 5 do
                MigrateLayer(db[spec], db.dbver);
            end
        else
            MigrateLayer(db["GENERAL"], db.dbver);
            for classId = 1, 20 do
                local _, class = GetClassInfo(classId);
                local classTbl = class and db[class];
                if (classTbl) then
                    for spec = 0, 5 do
                        MigrateLayer(classTbl[spec], db.dbver);
                    end
                end
            end
        end

        db.dbver = 2;
    end
end

local function LoadLayer(layerID)
    local layerInfo = assert(LAYER_INFOS[layerID]);
    if (layerInfo.spec and layerInfo.spec > NUM_SPECS) then
        return nil;
    end

    local tbl;
    if (layerInfo.isCharacterSpecific) then
        tbl = SimplyDebouncePrivate.db.char
    else
        assert(layerInfo.key);
        tbl = SimplyDebouncePrivate.db.global[layerInfo.key];
        if (not tbl) then
            tbl = {};
            SimplyDebouncePrivate.db.global[layerInfo.key] = tbl;
        end
    end

    if (layerInfo.spec) then
        if (not tbl[layerInfo.spec]) then
            tbl[layerInfo.spec] = {};
        end
        tbl = tbl[layerInfo.spec];
    end

    local layer = setmetatable({ layerID = layerID, spec = layerInfo.spec, isCharacterSpecific = layerInfo.isCharacterSpecific, actions = tbl, }, { __index = ProfileLayerProto });
    return layer;
end

function SimplyDebouncePrivate.LoadProfile()
    wipe(LayerArray);
    for layerID = 1, #LAYER_INFOS do
        LayerArray[layerID] = LoadLayer(layerID);
    end

    dump("LayerArray", LayerArray);
    SimplyDebouncePrivate.callbacks:Fire("OnProfileLoaded");
end

function SimplyDebouncePrivate.InitDB()
    local function initDB(dbKey)
        local dbTbl = _G[dbKey];
        if (not dbTbl) then
            dbTbl = {
                dever = Constants.DB_VERSION
            };
            _G[dbKey] = dbTbl;
        end
        dbTbl.dbver = dbTbl.dbver or 1;
        return dbTbl;
    end

    SimplyDebouncePrivate.db = {
        global = initDB("SimplyDebounceVars"),
        char = initDB("SimplyDebounceVarsPerChar"),
    };

    MigrateDB(SimplyDebouncePrivate.db.global);
    MigrateDB(SimplyDebouncePrivate.db.char, true);

    SimplyDebouncePrivate.db.global.options = SimplyDebouncePrivate.db.global.options or {};
    SimplyDebouncePrivate.db.global.options.blizzframes = SimplyDebouncePrivate.db.global.options.blizzframes or {};
    SimplyDebouncePrivate.Options = SimplyDebouncePrivate.db.global.options;

    -- Add the new auto-generate keybinds option
    SimplyDebouncePrivate.Options.autoGenerateKeybinds = SimplyDebouncePrivate.Options.autoGenerateKeybinds or false;

    SimplyDebouncePrivate.db.global.customStates = SimplyDebouncePrivate.db.global.customStates or {};
    SimplyDebouncePrivate.CustomStates = {};

    for i = 1, Constants.MAX_NUM_CUSTOM_STATES do
        local stateOptions = SimplyDebouncePrivate.db.global.customStates[i];
        if (not stateOptions) then
            stateOptions = {};
            SimplyDebouncePrivate.db.global.customStates[i] = stateOptions;
        end

        stateOptions.mode = stateOptions.mode or Constants.CUSTOM_STATE_MODES.MANUAL;
        if (stateOptions.mode == Constants.CUSTOM_STATE_MODES.MANUAL) then
            if (stateOptions.initialValue ~= nil) then
                stateOptions.value = stateOptions.initialValue;
            else
                stateOptions.value = stateOptions.savedValue and true or false;
            end
        else
            stateOptions.value = stateOptions.value or false;
        end

        SimplyDebouncePrivate.CustomStates[i] = stateOptions;
    end

    SimplyDebouncePrivate.LoadProfile();
    SimplyDebouncePrivate.CleanUpDB()
end

function SimplyDebouncePrivate.GetProfileLayer(layerID)
    return LayerArray[layerID];
end

function SimplyDebouncePrivate.CleanUpDB()
    for _, layer in pairs(LayerArray) do
        for _, action in layer:Enumerate() do
            for k in pairs(action) do
                if (KEYS_TO_SAVE[k] == nil) then
                    if (strsub(k, 1, 1) ~= "$") then
                        action[k] = nil;
                    end
                end
            end
            if (action.priority == Constants.DEFAULT_PRIORITY) then
                action.priority = nil;
            end
        end
    end
end

function SimplyDebouncePrivate.GetLayerID(spec, isCharacterSpecific)
    if (isCharacterSpecific) then
        if (not spec or spec == 0) then
            return 7
        else
            assert(spec > 0 and spec <= NUM_SPECS);
            return 7 + spec;
        end
    else
        if (not spec) then
            return 1;
        elseif (spec == 0) then
            return 2;
        else
            assert(spec > 0 and spec <= NUM_SPECS);
            return 2 + spec;
        end
    end
end

function SimplyDebouncePrivate.EnumerateProfileLayers()
    local spec = GetSpecialization();
    local indexArray = {};

    if (spec > 0 and spec <= NUM_SPECS) then
        tinsert(indexArray, SimplyDebouncePrivate.GetLayerID(spec, true));
    end

    tinsert(indexArray, SimplyDebouncePrivate.GetLayerID(0, true));

    if (spec > 0 and spec <= NUM_SPECS) then
        tinsert(indexArray, SimplyDebouncePrivate.GetLayerID(spec, false));
    end

    tinsert(indexArray, SimplyDebouncePrivate.GetLayerID(0, false));
    tinsert(indexArray, SimplyDebouncePrivate.GetLayerID(nil, false));

    local function Enumerator(tbl, index)
        index = index + 1;
        if (index <= #tbl) then
            local layerIndex = tbl[index];
            local layer = SimplyDebouncePrivate.GetProfileLayer(layerIndex);
            return index, layer;
        end
    end

    return Enumerator, indexArray, 0;
end

function SimplyDebouncePrivate.EnumerateActionsInActiveLayers()
    local spec = GetSpecialization();
    local layerIdArray = {};

    if (spec > 0 and spec <= NUM_SPECS) then
        tinsert(layerIdArray, SimplyDebouncePrivate.GetLayerID(spec, true));
    end

    tinsert(layerIdArray, SimplyDebouncePrivate.GetLayerID(0, true));

    if (spec > 0 and spec <= NUM_SPECS) then
        tinsert(layerIdArray, SimplyDebouncePrivate.GetLayerID(spec, false));
    end

    tinsert(layerIdArray, SimplyDebouncePrivate.GetLayerID(0, false));
    tinsert(layerIdArray, SimplyDebouncePrivate.GetLayerID(nil, false));

    local layerIndex = 1;
    local actionIndex = 0;
    local layer = SimplyDebouncePrivate.GetProfileLayer(layerIdArray[layerIndex]);
    local numActions = layer:GetNumActions();

    local function Enumerator(tbl, index)
        index = index + 1;
        while (actionIndex >= numActions) do
            layerIndex = layerIndex + 1;
            layer = SimplyDebouncePrivate.GetProfileLayer(tbl[layerIndex]);
            if (not layer) then
                return nil, nil;
            end
            numActions = layer:GetNumActions();
            actionIndex = 0;
        end
        actionIndex = actionIndex + 1;
        return index, layer:GetAction(actionIndex);
    end

    return Enumerator, layerIdArray, 0;
end

function SimplyDebouncePrivate.FindLayerID(action)
    -- Implementation for FindLayerID function
end
