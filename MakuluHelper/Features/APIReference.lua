--[[
    Makulu Helper - API Reference Feature
]]

MakuluHelper.APIReference = {}

-- Display API method information
function MakuluHelper.APIReference:DisplayMethod(className, method)
    if not method then
        return
    end
    
    -- Header
    MakuluHelper:Print(string.format("API Method: %s%s:%s%s", 
        MakuluHelper.Colors.PRIMARY, className, method.name, MakuluHelper.Colors.RESET))
    print(" ")
    
    -- Signature
    print(string.format("  %sSignature:%s", 
        MakuluHelper.Colors.INFO, MakuluHelper.Colors.RESET))
    print(string.format("    %s", method.signature))
    print(" ")
    
    -- Description
    if method.description then
        print(string.format("  %sDescription:%s", 
            MakuluHelper.Colors.INFO, MakuluHelper.Colors.RESET))
        print(string.format("    %s", method.description))
        print(" ")
    end
    
    -- Category
    if method.category then
        print(string.format("  %sCategory:%s %s", 
            MakuluHelper.Colors.INFO, MakuluHelper.Colors.RESET, method.category))
        print(" ")
    end
    
    -- Parameters
    if method.parameters and #method.parameters > 0 then
        print(string.format("  %sParameters:%s", 
            MakuluHelper.Colors.INFO, MakuluHelper.Colors.RESET))
        for _, param in ipairs(method.parameters) do
            local optional = param.optional and " (optional)" or ""
            print(string.format("    • %s%s%s (%s)%s", 
                MakuluHelper.Colors.SUCCESS, param.name, MakuluHelper.Colors.RESET,
                param.type, optional))
            print(string.format("      %s", param.description))
        end
        print(" ")
    end
    
    -- Returns
    if method.returns then
        print(string.format("  %sReturns:%s", 
            MakuluHelper.Colors.INFO, MakuluHelper.Colors.RESET))
        print(string.format("    %s - %s", method.returns.type, method.returns.description))
        print(" ")
    end
    
    -- Example
    if method.example then
        print(string.format("  %sExample:%s", 
            MakuluHelper.Colors.INFO, MakuluHelper.Colors.RESET))
        for line in method.example:gmatch("[^\r\n]+") do
            print(string.format("    %s", line))
        end
    end
end

-- Search and display API methods
function MakuluHelper.APIReference:SearchAndDisplay(query, maxResults)
    maxResults = maxResults or 10
    
    local results = MakuluHelper.Database:SearchAPI(query, maxResults)
    
    if #results == 0 then
        MakuluHelper:Error(string.format("No methods found matching: %s", query))
        return
    end
    
    if #results == 1 then
        -- Single result, display full info
        self:DisplayMethod(results[1].class, results[1].method)
    else
        -- Multiple results, show list
        MakuluHelper:Print(string.format("Found %d method(s):", #results))
        for i, result in ipairs(results) do
            print(string.format("  %d. %s%s%s:%s%s%s", 
                i,
                MakuluHelper.Colors.PRIMARY, result.class, MakuluHelper.Colors.RESET,
                MakuluHelper.Colors.INFO, result.method.name, MakuluHelper.Colors.RESET))
            print(string.format("     %s", result.method.signature))
            if result.method.description then
                local shortDesc = result.method.description:sub(1, 60)
                if #result.method.description > 60 then
                    shortDesc = shortDesc .. "..."
                end
                print(string.format("     %s", shortDesc))
            end
        end
        print(" ")
        print(string.format("  Use %s/makulu api <method>%s for details", 
            MakuluHelper.Colors.INFO, MakuluHelper.Colors.RESET))
    end
end

-- Display class overview
function MakuluHelper.APIReference:DisplayClass(className)
    local class = MakuluHelper.Database:GetAPIClass(className)
    
    if not class then
        MakuluHelper:Error(string.format("Class not found: %s", className))
        return
    end
    
    -- Header
    MakuluHelper:Print(string.format("API Class: %s%s%s", 
        MakuluHelper.Colors.PRIMARY, className, MakuluHelper.Colors.RESET))
    print(" ")
    
    -- Description
    if class.description then
        print(string.format("  %s", class.description))
        print(" ")
    end
    
    -- Method count
    print(string.format("  %sMethods:%s %d", 
        MakuluHelper.Colors.INFO, MakuluHelper.Colors.RESET, #class.methods))
    print(" ")
    
    -- Group methods by category
    local categories = {}
    for _, method in ipairs(class.methods) do
        local category = method.category or "Uncategorized"
        if not categories[category] then
            categories[category] = {}
        end
        table.insert(categories[category], method)
    end
    
    -- Display methods by category
    for category, methods in pairs(categories) do
        print(string.format("  %s%s%s (%d methods):", 
            MakuluHelper.Colors.SUCCESS, category, MakuluHelper.Colors.RESET, #methods))
        
        -- Show first 5 methods in each category
        local count = 0
        for _, method in ipairs(methods) do
            if count >= 5 then
                print(string.format("    ... and %d more", #methods - count))
                break
            end
            print(string.format("    • %s", method.name))
            count = count + 1
        end
        print(" ")
    end
    
    print(string.format("  Use %s/makulu api <method>%s to search methods", 
        MakuluHelper.Colors.INFO, MakuluHelper.Colors.RESET))
end

-- Get method usage tip
function MakuluHelper.APIReference:GetMethodTip(className, method)
    if not method then
        return nil
    end
    
    local tip = string.format("💡 Tip: Use %s:%s() in your rotations", 
        className:lower(), method.name)
    
    return tip
end

