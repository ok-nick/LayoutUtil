--[[
	8/12/20
	Discord - Nickuhhh#0331
	Roblox - iiNemo

LayoutScaler

	A library to easily scale the content of a UIGridLayout or UIListLayout. Automatically resizes the children of the ScrollingFrame and sets the CanvasSize.

	-- IMPORTANT -- IMPORTANT -- IMPORTANT -- IMPORTANT --
	Note that it is still important to be using a UIAspectRatioConstraint in the main frame relative to each ScrollingFrame.
	Also make sure that the default CanvasSize of the ScrollingFrame is set to (0, 0, 0, 0). This is important when you are measuring the default CellPadding and CellSize or Padding.
	-- IMPORTANT -- IMPORTANT -- IMPORTANT -- IMPORTANT --

	:GetLayout(Key <UILayout | ScrollingFrame>)
	  - Returns the layout class corresponding to the key provided.

	:Destroy(Key <UILayout | ScrollingFrame>)
	  - Destroys any remains of the class connected to the specified key.

	new(Layout <UILayout>)
	  - Immediatley sets up the UILayout's auto-scaling features.

		:ResizeCanvas()
		  - Resizes the ScrollingFrame's CanvasSize based off the size of it's children.

		:ResizeContent()
		  -- Resizes the ScrollingFrame's children based off the size of the ScrollingFrame.

		:Bind()
		  - Subscribes a series of events to handle the scaling.

		:Unbind()
		  - Unsubscribes all events that handle the scaling.

		:SetDefault(Padding <UDim>) - UIListLayout
		:SetDefault(Padding <UDim2>, Size <UDim2>) - UIGridLayout
		  - Changes the default CellPadding and CellSize
]]--


-- Variables --


local GridLayout = require(script.GridLayout)
local ListLayout = require(script.ListLayout)

local LayoutScaler = {}
LayoutScaler.Classes = {}


-- Library --


function LayoutScaler:GetLayout(Key)
	for i = 1, #self.Classes do
		local Class = self.Classes[i]

		if Class.Layout == Key or Class.ScrollingFrame == Key then
			return Class, i
		end
	end
end


function LayoutScaler:Destroy(Key)
	local Layout, Index = self:GetLayout(Key)

	if Layout then
		Layout:Unbind()
		table.remove(self.Classes, Index)
	end
end


function LayoutScaler.new(...)
	local Layout = ...
	local self = Layout.ClassName == 'UIGridLayout' and GridLayout.new(...) or ListLayout.new(...)

	table.insert(LayoutScaler.Classes, self)

	return self
end


-- Setup --


return LayoutScaler