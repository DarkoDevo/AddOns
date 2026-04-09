-- Only adding the modified UpdateBindings function at the end of the file
function SimplyDebouncePrivate.UpdateBindings()
    SimplyDebouncePrivate.BuildKeyMap()
    -- ... (rest of the existing UpdateBindings function)
    
    -- Call auto-generate keybinds if enabled
    if SimplyDebouncePrivate.Options.autoGenerateKeybinds then
        SimplyDebouncePrivate.AutoGenerateKeybinds()
    end
end

if (DEBUG) then
	_G.SimplyDebouncePrivate = SimplyDebouncePrivate;
end
