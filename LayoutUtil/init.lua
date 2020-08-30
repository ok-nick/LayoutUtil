--[[
	Discord - Nickuhhh#0331
	Roblox - iiNemo

	Changelog:
		8/29/20
			Documentation updates
			Configuration table
			Use of maids
			Many optimizations
			ConvertToScale public function
			GetAxis is now a public function

		8/12/20
			Released

LayoutUtil

	A library to automatically scale the content of a UIGridLayout or UIListLayout, as well as the CanvasSize.

	-- IMPORTANT -- IMPORTANT -- IMPORTANT -- IMPORTANT --
	- Note that it is still important to be using a UIAspectRatioConstraint in the main frame relative to each ScrollingFrame to
		maintain proper aspect ratio.
	- Also make sure that the default CanvasSize of the ScrollingFrame in studio is set to (0, 0, 0, 0) otherwise there WILL BE
		UI deformations.
	- Your CellPadding and CellSize / Padding must be set to all scale while in studio, to easily convert it from offset to scale
		you could use the code below inside of your command bar.

		local MODULE_LOCATION = nil
		local UILAYOUT = nil

		UILAYOUT.Parent.CanvasSize = UDim2.new(0, 0, 0, 0)

		local LayoutUtil = require(MODULE_LOCATION)
		LayoutUtil.ConvertToScale(UILAYOUT)

	-- IMPORTANT -- IMPORTANT -- IMPORTANT -- IMPORTANT --

	ConvertToScale(Layout: UILayout) -> void
	  - Converts a UILayout's size and padding to scale.

	new(Layout: UILayout, Config: table) -> class
	  - Immediatley sets up the UILayout's auto-scaling features.
	  	{ -- Configurations
			Bind = false, -- Removes instant binding.
			ResizeCanvas = false, -- Removes canvas resizing.
			ResizeContent = false, -- Removes content resizing.
			OnResize = false, -- Updates when it's resized.
			OnAdd = false, -- Updates when a child is added.
			OnRemove = false, -- Updates when a child is removed.

			-- UIGridLayout Exclusives
			CellPadding = UDim2.new(), -- Default CellPadding.
			CellSize = UDim2.new(), -- Default CellSize.

			-- UIListLayout Exclusives
			Padding = UDim.new(), - Default Padding.
			OnAxisChange = false, -- Updates when FillDirection changes.
		}

		:GetAxis(FillDirection: EnumItem) -> void -- Exclusive to UIListLayout
		  - Returns the axis relative to the EnumItem.

		:ResizeCanvas() -> void
		  - Resizes the ScrollingFrame's CanvasSize based off the size of it's children.

		:ResizeContent() -> void
		  -- Resizes the ScrollingFrame's children based off the size of the CanvasSize.

		:Bind() -> void
		  - Subscribes a series of events to handle the scaling.

		:Unbind() -> void
		  - Destroys all connections that automatically handle the scaling.

		:SetDefault(Padding: UDim) -> void -- UIListLayout
		:SetDefault(Padding: UDim2, Size: UDim2) -> void -- UIGridLayout
		  - Changes the default CellPadding and CellSize
]]--


-- Variables --


local GridLayout = require(script.GridLayout)
local ListLayout = require(script.ListLayout)
local ToScale = require(script.ToScale)

local LayoutUtil = {}


-- Private --


local function Validate(Layout)
	local IsGrid, IsList = Layout.ClassName == 'UIGridLayout', Layout.ClassName == 'UIListLayout'
	assert(IsGrid or IsList, 'Argument #1 is not a valid UILayout')

	return IsGrid, IsList
end


-- Public --


function LayoutUtil.ConvertToScale(Layout)
	local IsGrid, IsList = Validate(Layout)
	local P = Layout.Parent

	if IsGrid then
		local CellSize, CellPadding = Layout.CellSize, Layout.CellPadding

		Layout.CellPadding = UDim2.fromScale(ToScale(CellPadding, P, 'X'), ToScale(CellPadding, P, 'Y'))
		Layout.CellSize = UDim2.fromScale(ToScale(CellSize, P, 'X'), ToScale(CellSize, P, 'Y'))
	elseif IsList then
		local Padding = Layout.Padding
		local Size = {
			X = {
				Offset = Padding.Offset,
				Scale = Padding.Scale
			}
		}
		Size.Y = Size.X

		Layout.Padding = UDim.new(ToScale(Size, P, ListLayout:GetAxis(Layout.FillDirection)), 0)
	end
end


-- Constructor --


function LayoutUtil.new(...)
	local Layout = ...
	local IsGrid, IsList = Validate(Layout)

	return IsGrid and GridLayout.new(...) or IsList and ListLayout.new(...)
end


-- Setup --


return LayoutUtil