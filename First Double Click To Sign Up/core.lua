local function OnDoubleClick(self, button)
    LFGListSearchPanel_SignUp(self:GetParent():GetParent():GetParent())
end

for _, button in pairs(LFGListFrame.SearchPanel.ScrollFrame.buttons) do
    button:SetScript("OnDoubleClick", OnDoubleClick)
end