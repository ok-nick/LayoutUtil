local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local LayoutUtil = require(ReplicatedStorage.LayoutUtil)

-- Construct the UI
local gui = Instance.new("ScreenGui")

local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollingFrame.Size = UDim2.fromScale(0.2, 0.4)
scrollingFrame.Position = UDim2.fromScale(0.2, 0.2)
scrollingFrame.CanvasSize = UDim2.new()
scrollingFrame.Parent = gui

for _ = 1, 100 do
	local frame = Instance.new("Frame")
	frame.Parent = scrollingFrame
end

local layout = Instance.new("UIGridLayout") -- Could be a UIGridLayout or UIListLayout
layout.CellSize = UDim2.fromScale(0.3, 0.3)

-- Apply LayoutUtil
LayoutUtil(layout, scrollingFrame)

layout.Parent = scrollingFrame
gui.Parent = StarterGui
