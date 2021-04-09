--[[
	LayoutUtilPlugin
	v2.0.0

	Roblox: iiNemo
	Discord: nickk#9163
]]

local CLASSES = {
	UIGridLayout = true,
	UIListLayout = true,
}

local ChangeHistoryService = game:GetService('ChangeHistoryService')
local Selection = game:GetService('Selection')

local LayoutUtil = require(script.LayoutUtil)
local Assets = require(script.Assets)

local toolbar = plugin:CreateToolbar('LayoutUtil')
local applyLayout =
	toolbar:CreateButton('Apply', 'Applies LayoutUtil to the given UIGridLayout or UIListLayout', Assets['icon-32'])
applyLayout.ClickableWhenViewportHidden = true

applyLayout.Click:Connect(function()
	applyLayout:SetActive(false)
	ChangeHistoryService:SetWaypoint('Before LayoutUtil')

	local selected = Selection:Get()
	for _, object in ipairs(selected) do
		if CLASSES[object.ClassName] then
			LayoutUtil(object)
		elseif object.ClassName == 'ScrollingFrame' then
			for className in pairs(CLASSES) do
				local layout = object:FindFirstChildOfClass(className)
				if layout then
					LayoutUtil(layout)
					break
				end
			end
		end
	end

	ChangeHistoryService:SetWaypoint('After LayoutUtil')
end)
