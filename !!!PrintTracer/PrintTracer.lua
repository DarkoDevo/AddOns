local oldprint = print
print = function(text, ...)
	text = tostring(text)
	for n=1,select('#', ...) do
		local e = select(n, ...)
		text = text.." "..tostring(e)
	end
	local patterns = {"\n", "^.-AddOns\\", ": in function.*$"}
	local source = debugstack(2,1,0)
	for i = 1, #patterns do source = gsub(source, patterns[i], "") end
	text = "PT: print(\""..text.."\") called from "..source
	return oldprint(text)
end