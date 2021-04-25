--[[
	LayoutUtil-Plugin v3.0.0
	https://github.com/ok-nick/LayoutUtil
]]

local CLASSES = {
	UIGridLayout = 'grid',
	UIListLayout = 'list',
}

local ChangeHistoryService = game:GetService('ChangeHistoryService')
local Selection = game:GetService('Selection')

local LayoutUtil = require(script.LayoutUtil)
local Assets = require(script.Assets)

local toolbar = plugin:CreateToolbar('LayoutUtil')
local applyLayout = toolbar:CreateButton('Apply', 'Applies LayoutUtil to the given UILayout', Assets['icon-32'])
applyLayout.ClickableWhenViewportHidden = true

applyLayout.Click:Connect(function()
	applyLayout:SetActive(false)
	ChangeHistoryService:SetWaypoint('Before LayoutUtil')

	local selected = Selection:Get()
	for _, object in ipairs(selected) do
		local layoutType = CLASSES[object.ClassName]
		if layoutType then
			LayoutUtil[layoutType](object)
		elseif object:IsA('GuiBase2d') then
			for className, innerLayoutType in pairs(CLASSES) do
				local layout = object:FindFirstChildOfClass(className)
				if layout then
					LayoutUtil[innerLayoutType](layout)
					break
				end
			end
		end
	end

	ChangeHistoryService:SetWaypoint('After LayoutUtil')
end)
