local SimplyDebouncePublic = SimplyDebouncePublic;

_G.Clique = SimplyDebouncePublic;

_G.ClickCastHeader = SimplyDebouncePublic.header;

_G.ClickCastFrames = setmetatable({}, {
    __newindex = function(t, k, v)
        if v == nil or v == false then
            SimplyDebouncePublic:UnregisterFrame(k);
        else
            SimplyDebouncePublic:RegisterFrame(k, v);
        end
    end
});
