--[[
	Discord - Nickuhhh#0331
	Roblox - iiNemo

	Changelog:
		10/7/2020 - v1.0.6
			Fixed bug when the size of a element in a UIListLayout is exactly the size of one of the parent's axis's, it created a scrolling bar

		10/7/2020 - v.1.0.5
			Fixed a bug that was caused by a fix to another bug which was a fix to another bug which was a fix to another bug

		10/5/2020 - v1.0.4
			Reverted a fix from 9/20/2020 that caused more problems

		9/26/2020 - v1.0.3
			Fixed bug relating to Scrolling Frame's with UIListLayouts CanvasSize stretching when it reaches past AbsoluteSize

		9/20/2020 - v1.02
			Fixed bug where if you changed the size of an object in a UIListLayout it wouldn't scale that object based on the new size (reverted)

		8/29/2020 - v1.0.1
			Documentation updates
			Configuration table
			Use of maids
			Many optimizations
			ConvertToScale public function
			GetAxis/AddObject/RemoveObject is now a public function of a UIListLayout class
			Fixed bug where it wouldn't recognize a new item in a new row

		8/12/2020 - v1.0
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
		LayoutUtil:ConvertToScale(UILAYOUT)

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
			OnWindowResize = false, -- Updates when the content size changes.

			-- UIGridLayout Exclusives
			CellPadding = UDim2.new(), -- Default CellPadding.
			CellSize = UDim2.new(), -- Default CellSize.

			-- UIListLayout Exclusives
			Padding = UDim.new(), - Default Padding.
			OnAxisChange = false, -- Updates when FillDirection changes.
			OnAdd = false, -- Adds object to the resize cache.
			OnRemove = false, -- Removes object from the resize cache.
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

		-- UIGridLayout Exclusives
		:SetDefault(Padding: UDim2, Size: UDim2) -> void
		  - Changes the default CellPadding and CellSize.

		-- UIListLayout Exclusives
		:SetDefault(Padding: UDim) -> void
		  - Changes the default CellPadding and CellSize.

		:AddObject(Object: GuiObject) -> void
		  - Adds an object to the resize cache.

		:RemoveObject(Object: GuiObject) -> void
		  - Removes an object from the resize cache.

]]--


-- Variables --


local GridLayout = require(script.GridLayout)
local ListLayout = require(script.ListLayout)
local ToScale = require(script.ToScale)

local LayoutUtil = {}


-- Private --


local function Validate(Layout)
	local IsGrid, IsList = Layout.ClassName == 'UIGridLayout', Layout.ClassName == 'UIListLayout'
	assert(IsGrid or IsList, 'bad argument #1, not a valid UILayout')

	return IsGrid, IsList
end


-- Public --


function LayoutUtil:ConvertToScale(Layout)
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