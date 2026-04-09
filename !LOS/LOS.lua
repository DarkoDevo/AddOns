local tasks = {}
 
local function delays(time, func, ...)
    local t = {...}
    t.func = func
    t.time = GetTime() + time
    table.insert(tasks, t)
end;
 
local function onUpdate()
 
for i = #tasks, 1, -1 do
local val = tasks[i]
if val.time <= GetTime() then
table.remove(tasks, i)
val.func(unpack(val))
end
end
end
local frame = CreateFrame("Frame")
frame:SetScript("OnUpdate", onUpdate)

-- tmw
-- if a1 == 4 then return true end
-- if a2 == 4 then return true end
-- if a3 == 4 then return true end
-- if r1 == 4 then return true end

-- Использование macro
-- /run a1=4
-- /run a2=4
-- /run a3=4
-- /run a4=4
-- /run r1=4

function off_a1() a1=nil end
function off_a2() a2=nil end
function off_a3() a3=nil end
function off_a4() a4=nil end
function off_a5() a5=nil end
function off_a6() a6=nil end

function off_r1() r1=nil end
function off_r2() r2=nil end
function off_r3() r3=nil end
function off_r4() r4=nil end
function off_r5() r5=nil end
function off_r6() r6=nil end
function off_r7() r7=nil end
function off_r8() r8=nil end
function off_r9() r9=nil end
function off_r0() r0=nil end

local delay_sec = 0.5
local function onUpdate2(self, elapsed)

if a1 == 4 then delays(delay_sec, off_a1) end
if a2 == 4 then delays(delay_sec, off_a2) end
if a3 == 4 then delays(delay_sec, off_a3) end
if a4 == 4 then delays(delay_sec, off_a4) end
if a5 == 4 then delays(delay_sec, off_a5) end
if a6 == 4 then delays(delay_sec, off_a6) end

if r1 == 4 then delays(delay_sec, off_r1) end
if r2 == 4 then delays(delay_sec, off_r2) end
if r3 == 4 then delays(delay_sec, off_r3) end
if r4 == 4 then delays(delay_sec, off_r4) end
if r5 == 4 then delays(delay_sec, off_r5) end
if r6 == 4 then delays(delay_sec, off_r6) end
if r7 == 4 then delays(delay_sec, off_r7) end
if r8 == 4 then delays(delay_sec, off_r8) end
if r9 == 4 then delays(delay_sec, off_r9) end
if r0 == 4 then delays(delay_sec, off_r0) end
end;
local f = CreateFrame("Frame");
f:SetScript("OnUpdate", onUpdate2)

