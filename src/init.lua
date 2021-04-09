--[[
	LayoutUtil
	v3.0.0

	Roblox: iiNemo
	Discord: nickk#9163
]]

local NOT_DESCENDANT_OF = [[%s is not a descendant of `%s`]]
local INVALID_PARENT = [[Parent of class, %s, is not a `%s`]]

local camera = workspace.CurrentCamera

local LayoutUtil = {}

local function toOffset(udim: UDim, parentOffset: number): number
	return (udim.Scale * parentOffset) + udim.Offset
end

local function absoluteSizeFromUDim2(childUDim2: UDim2, parentAbsoluteSize: Vector2): Vector2
	return Vector2.new(toOffset(childUDim2.X, parentAbsoluteSize.X), toOffset(childUDim2.Y, parentAbsoluteSize.Y))
end

--[=[

]=]
function LayoutUtil.constraint(object: GuiObject, absoluteSize: Vector2)
	local constraint = object:FindFirstChildOfClass('UIAspectRatioConstraint')
		or Instance.new('UIAspectRatioConstraint')
	constraint.AspectRatio = absoluteSize.X / absoluteSize.Y
	constraint.Parent = object
end

--[=[
	Add parameter to specify parent size

]=]
function LayoutUtil.maintain(layout: UIGridLayout | UIListLayout, parentSize: Vector2)
	local layoutClass = layout.ClassName
	local parent = layout.Parent

	local parentAbsoluteSize
	if not parentSize then
		assert(parent:IsDescendantOf(game), NOT_DESCENDANT_OF:format(layoutClass, 'game')) -- AbsoluteSize isn't set until the "GuiBase2d" is a descendant of the game.
		assert(parent:IsA('GuiObject'), INVALID_PARENT:format(parent.ClassName, 'GuiObject'))

		parentAbsoluteSize = parent.AbsoluteSize
	else
		parentAbsoluteSize = parentSize
	end

	if layoutClass == 'UIGridLayout' then
		LayoutUtil.constraint(layout, absoluteSizeFromUDim2(layout.CellSize, parentAbsoluteSize))
	else -- UIListLayout
		-- TODO: Check if parent exists

		for _, child in ipairs(parent:GetChildren()) do
			if child:IsA('GuiObject') then
				LayoutUtil.constraint(child, absoluteSizeFromUDim2(child.AbsoluteSize, parentAbsoluteSize))
			end
		end
	end
end

--[=[
	AutomaticCanvasSize is very buggy, here is the temp fix

]=]
function LayoutUtil.resize(scrollingFrame: ScrollingFrame, layout: UIGridLayout | UIListLayout, axes: Enum.AutomaticSize): RBXScriptConnection
	return camera:GetPropertyChangedSignal('ViewportSize'):Connect(function()
		local contentSize = layout.AbsoluteContentSize
		local canvasSize
		if axes == Enum.AutomaticSize.Y then
			canvasSize = UDim2.fromOffset(0, contentSize.Y)
		elseif axes == Enum.AutomaticSize.X then
			canvasSize = UDim2.fromOffset(contentSize.X, 0)
		else -- Enum.AutomaticSize.XY or Enum.AutomaticSize.None
			canvasSize = UDim2.fromOffset(contentSize.X, contentSize.Y)
		end

		scrollingFrame.CanvasSize = canvasSize
	end)
end

--[=[
	GridLayouts don't need to be watched since we don't do anything with the children

]=]
function LayoutUtil.watch(layout: UIListLayout): RBXScriptConnection
	local parent = layout.Parent
	-- TODO: Check if parent exists

	return parent.ChildAdded:Connect(function(child)
		if child:IsA('GuiObject') then
			LayoutUtil.constraint(child, parent.AbsoluteSize)
		end
	end)
end

return LayoutUtil
