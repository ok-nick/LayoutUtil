--[[
	Discord - Nickuhhh#0331
	Roblox - iiNemo

	Changelog:
		8/29/20
			Documentation updates.
			Configuration table.
			Use of maids.
			Small optimizations.

		8/12/20
			Released.

LayoutUtil

	A library to automatically scale the content of a UIGridLayout or UIListLayout, as well as the CanvasSize.

	-- IMPORTANT -- IMPORTANT -- IMPORTANT -- IMPORTANT --
	Note that it is still important to be using a UIAspectRatioConstraint in the main frame relative to each ScrollingFrame to maintain proper size.
	Also make sure that the default CanvasSize of the ScrollingFrame is set to (0, 0, 0, 0). This is important when you are measuring the default CellPadding and CellSize or Padding.
	Your CellPadding and CellSize / Padding must be set to all scale while in studio, to easily convert it from offset to scale you could call the code below in your command bar.

		local MODULE_LOCATION = nil
		local UILAYOUT = nil

		UILayout.CanvasSize = UDim2.new(0, 0, 0, 0)
		require(MODULE_LOCATION).new(UILAYOUT, {Bind = false, ResizeCanvas = false})

	-- IMPORTANT -- IMPORTANT -- IMPORTANT -- IMPORTANT --

	new(Layout: UILayout, Config: table) -> Class
	  - Immediatley sets up the UILayout's auto-scaling features.
	  	{ -- Configurations
			Bind = false, -- Removes instant binding.
			ResizeCanvas = false, -- Removes canvas resizing.
			ResizeContent = false, -- Removes content resizing.
			OnResize = false, -- Updates when it's resized.
			OnAdd = false, -- Updates when a child is added.
			OnRemove = false, -- Updates when a child is removed.

			-- UIGridLayout Exclusives
			CellPadding = UDim2.new(),
			CellSize = UDim2.new(),

			-- UIListLayout Exclusives
			Padding = UDim.new(),
			OnAxisChange = false, -- Updates when FillDirection changes. MAKE THIS NON EXCLUSIVE FOR UIGRIDLAYOUTS AS WELL
		}

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

local LayoutUtil = {}


-- Constructor --


function LayoutUtil.new(...)
	local Layout = ...
	return Layout.ClassName == 'UIGridLayout' and GridLayout.new(...) or ListLayout.new(...)
end


-- Setup --


return LayoutUtil