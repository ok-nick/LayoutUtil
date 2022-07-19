--[[
	LayoutUtil v3.0.0
	https://github.com/ok-nick/LayoutUtil
]]

local LayoutUtil = {}

local function validateParent(parent)
	assert(typeof(parent) == "Instance", "Parent of layout is not a valid `Instance`")
	assert(parent:IsA("GuiBase2d"), "Parent of layout is not a valid `GuiBase2d` (ScreenGui, Frame, TextLabel, etc...)")
end

local function toOffset(childSize: UDim, parentAbsoluteSize: number): number
	return (childSize.Scale * parentAbsoluteSize) + childSize.Offset
end

local function absoluteSizeFromUDim2(childSize: UDim2, parentAbsoluteSize: Vector2): Vector2
	return Vector2.new(toOffset(childSize.X, parentAbsoluteSize.X), toOffset(childSize.Y, parentAbsoluteSize.Y))
end

--[=[
	Inserts and calculates the `AspectRatio` of a `UIAspectRatioConstraint`.
	If a constraint already exists, it will overwrite the `AspectRatio` property.

	@param {GuiObject} object The object to be handled.
	@param {Vector2} absoluteSize `AbsoluteSize` of the object; defaults to manually retrieving the property. If the object isn't a
		descendant of `game`, then the `AbsoluteSize` will be (0, 0), which is why this parameter is necessary.
]=]
function LayoutUtil.constraint(object: GuiObject, absoluteSize: Vector2?)
	absoluteSize = absoluteSize or object.AbsoluteSize

	local constraint = object:FindFirstChildOfClass("UIAspectRatioConstraint")
		or Instance.new("UIAspectRatioConstraint")
	constraint.AspectRatio = absoluteSize.X / absoluteSize.Y
	constraint.Parent = object
end

--[=[
	Uses the `constraint` function to insert a constraint into the `UIGridLayout`.

	@param {UIGridLayout} layout The `UIGridLayout` to be constrained.
	@param {Vector2} parentSize `AbsoluteSize` of the parent of the layout; defaults to manually retrieving the property. If the object isn't a
		descendant of `game`, then the `AbsoluteSize` will be (0, 0), which is why this parameter is necessary.

]=]
function LayoutUtil.grid(layout: UIGridLayout, parentSize: Vector2)
	if not parentSize then
		local parent = layout.Parent
		validateParent(parent)

		parentSize = parent.AbsoluteSize
	end

	LayoutUtil.constraint(layout, absoluteSizeFromUDim2(layout.CellSize, parentSize))
end

--[=[
	Uses the `constraint` function to insert a constraint into each child of the parenting `ScrollingFrame`.

	@param {UIGridLayout} layout The `UIListLayout` to be constrained.
	@param {Vector2} parentSize `AbsoluteSize` of the parent of the layout; defaults to manually retrieving the property. If the object isn't a
		descendant of `game`, then the `AbsoluteSize` will be (0, 0), which is why this parameter is necessary.
]=]
function LayoutUtil.list(layout: UIListLayout, parentSize: Vector2)
	local parent = layout.Parent
	validateParent(parent)

	parentSize = parentSize or parent.AbsoluteSize

	for _, child in ipairs(parent:GetChildren()) do
		if child:IsA("GuiObject") then
			LayoutUtil.constraint(child, absoluteSizeFromUDim2(child.Size, parentSize))
		end
	end
end

--[=[
	Watches a `UIListLayout` parented to a `ScrollingFrame` to automatically resize new children. This function is only available
	for `UIListLayouts` since `UIGridLayouts` do not need any extra work. The parent of the `UIListLayout` must be a valid
	descendant of `game`.

	@param {UIListLayout} layout The `UIListLayout` to be watched.
	@returns {RBXScriptConnection} The connection which automatically constraints new children as they are added.
]=]
function LayoutUtil.watch(layout: UIListLayout): RBXScriptConnection
	local parent = layout.Parent
	validateParent(parent)

	return parent.ChildAdded:Connect(function(child)
		if child:IsA("GuiObject") then
			LayoutUtil.constraint(child)
		end
	end)
end

--[=[
	Alternative to the `AutomaticCanvasSize` property, as it is buggy.

	@param {ScrollingFrame} scrollingFrame The `ScrollingFrame` to be automatically sized.
	@param {UIListLayout | UIGridLayout} layout The layout within the `ScrollingFrame`.
	@param {Enum.AutomaticSize} axis The axis of which to automatically scale the `CanvasSize`.
	@returns {RBXScriptConnection} The connection which automatically resizes the canvas when the content size changes.
]=]
function LayoutUtil.resize(
	scrollingFrame: ScrollingFrame,
	layout: UIGridLayout | UIListLayout,
	axis: Enum.AutomaticSize
): RBXScriptConnection
	return layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		local contentSize = layout.AbsoluteContentSize
		local canvasSize
		if axis == Enum.AutomaticSize.Y then
			canvasSize = UDim2.fromOffset(0, contentSize.Y)
		elseif axis == Enum.AutomaticSize.X then
			canvasSize = UDim2.fromOffset(contentSize.X, 0)
		else -- Enum.AutomaticSize.XY or Enum.AutomaticSize.None
			canvasSize = UDim2.fromOffset(contentSize.X, contentSize.Y)
		end

		scrollingFrame.CanvasSize = canvasSize
	end)
end

return LayoutUtil
