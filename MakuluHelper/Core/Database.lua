--[[
    Makulu Helper - Database Management
    Handles spell and API data storage and retrieval
]]

MakuluHelper.Database = {
    Spells = {},
    API = {},
    Examples = {},
    Initialized = false
}

local DB = MakuluHelper.Database

-- Initialize database
function DB:Initialize()
    if self.Initialized then
        return
    end
    
    -- Load spell data
    if MakuluHelper_SpellData then
        self.Spells = MakuluHelper_SpellData
        MakuluHelper:Debug(string.format("Loaded %d spells", #self.Spells))
    end
    
    -- Load API data
    if MakuluHelper_APIData then
        self.API = MakuluHelper_APIData
        local methodCount = 0
        for _, class in pairs(self.API) do
            if class.methods then
                methodCount = methodCount + #class.methods
            end
        end
        MakuluHelper:Debug(string.format("Loaded %d API methods", methodCount))
    end
    
    -- Build indexes for fast lookup
    self:BuildIndexes()
    
    self.Initialized = true
    MakuluHelper:Debug("Database initialized")
end

-- Build indexes for fast lookup
function DB:BuildIndexes()
    -- Spell ID index
    self.SpellIDIndex = {}
    for _, spell in ipairs(self.Spells) do
        self.SpellIDIndex[spell.id] = spell
    end
    
    -- Spell name index (normalized)
    self.SpellNameIndex = {}
    for _, spell in ipairs(self.Spells) do
        local normalized = MakuluHelper.Utils:NormalizeString(spell.name)
        self.SpellNameIndex[normalized] = spell
    end
    
    -- API method index
    self.APIMethodIndex = {}
    for className, class in pairs(self.API) do
        if class.methods then
            for _, method in ipairs(class.methods) do
                local key = className .. ":" .. method.name
                self.APIMethodIndex[key] = method
            end
        end
    end
    
    MakuluHelper:Debug("Indexes built")
end

-- Get spell by ID
function DB:GetSpellByID(spellID)
    return self.SpellIDIndex[spellID]
end

-- Get spell by name (fuzzy match)
function DB:GetSpellByName(name)
    local normalized = MakuluHelper.Utils:NormalizeString(name)
    return self.SpellNameIndex[normalized]
end

-- Search spells
function DB:SearchSpells(query, maxResults)
    maxResults = maxResults or 10
    local results = {}
    local normalizedQuery = MakuluHelper.Utils:NormalizeString(query)
    
    for _, spell in ipairs(self.Spells) do
        if #results >= maxResults then
            break
        end
        
        local normalizedName = MakuluHelper.Utils:NormalizeString(spell.name)
        if normalizedName:find(normalizedQuery, 1, true) or 
           tostring(spell.id):find(query, 1, true) then
            table.insert(results, spell)
        end
    end
    
    return results
end

-- Get API class
function DB:GetAPIClass(className)
    return self.API[className]
end

-- Get API method
function DB:GetAPIMethod(className, methodName)
    local key = className .. ":" .. methodName
    return self.APIMethodIndex[key]
end

-- Search API methods
function DB:SearchAPI(query, maxResults)
    maxResults = maxResults or 10
    local results = {}
    local normalizedQuery = MakuluHelper.Utils:NormalizeString(query)
    
    for className, class in pairs(self.API) do
        if #results >= maxResults then
            break
        end
        
        if class.methods then
            for _, method in ipairs(class.methods) do
                local normalizedName = MakuluHelper.Utils:NormalizeString(method.name)
                local normalizedDesc = MakuluHelper.Utils:NormalizeString(method.description or "")
                
                if normalizedName:find(normalizedQuery, 1, true) or
                   normalizedDesc:find(normalizedQuery, 1, true) then
                    table.insert(results, {
                        class = className,
                        method = method
                    })
                    
                    if #results >= maxResults then
                        break
                    end
                end
            end
        end
    end
    
    return results
end

-- Get all classes
function DB:GetAllClasses()
    local classes = {}
    for className, _ in pairs(self.API) do
        table.insert(classes, className)
    end
    table.sort(classes)
    return classes
end

-- Get class method count
function DB:GetClassMethodCount(className)
    local class = self.API[className]
    if class and class.methods then
        return #class.methods
    end
    return 0
end

-- Get total method count
function DB:GetTotalMethodCount()
    local count = 0
    for _, class in pairs(self.API) do
        if class.methods then
            count = count + #class.methods
        end
    end
    return count
end

-- Get statistics
function DB:GetStatistics()
    return {
        spells = #self.Spells,
        classes = MakuluHelper.Utils:TableSize(self.API),
        methods = self:GetTotalMethodCount()
    }
end

