--[[
	LayoutUtil
	v2.0.0

	Roblox: iiNemo
	Discord: nickk#9163
]]


local INVALID_ARG = [[bad argument #%d to 'LayoutUtil' (%s expected, got %s)]]


local camera = workspace.CurrentCamera


local function toOffset(udim, parentOffset)
	return (udim.Scale * parentOffset) + udim.Offset
end

local function absoluteSizeFromUDim2(childUDim2, parentAbsoluteSize)
	return Vector2.new(
		toOffset(childUDim2.X, parentAbsoluteSize.X),
		toOffset(childUDim2.Y, parentAbsoluteSize.Y)
	)
end

local function addConstraint(object, absoluteSize)
	local constraint = object:FindFirstChildOfClass('UIAspectRatioConstraint') or Instance.new('UIAspectRatioConstraint')
	constraint.AspectRatio = absoluteSize.X / absoluteSize.Y
	constraint.Parent = object
end


--[=[
	Automatically inserts and calculates UIAspectRatioConstraints into the corresponding UIGridLayout/UIListLayout. The
	parent parameter is optional, but should be explicitly provided if the layout hasn't been parented. In order to
	calculate the AspectRatio, I need the size of the UILayout (or children of a UIListLayout) in offset. Therefor if the
	parent isn't a GuiObject or a Vector2, it will assume the parent size is the screens resolution.

	@param {UIGridLayout | UIListLayout} layout The UILayout to be applied.
	@param {GuiObject | Instance | Vector2} [parentObjectOrSize] The object (or Vector2) to be recognized as the parent
		in order to retrieve the AbsoluteSize (non-GuiObjects or nil, defaults to the screens resolution).
]=]
return function(layout, parentObjectOrSize)
	local className = typeof(layout) == 'Instance' and layout.ClassName
	assert(
		className == 'UIGridLayout' or className == 'UIListLayout',
		INVALID_ARG:format(1, 'UIGridLayout or UIListLayout', className)
	)

	local parent = parentObjectOrSize or layout.Parent
	local parentAbsoluteSize
	if parent:IsA('GuiObject') then
		parentAbsoluteSize = parent.AbsoluteSize
	elseif typeof(parentObjectOrSize) == 'Vector2' then
		parentAbsoluteSize = parentObjectOrSize
	else
		parentAbsoluteSize = camera.ViewportSize
	end

	if layout.ClassName == 'UIGridLayout' then
		addConstraint(
			layout,
			absoluteSizeFromUDim2(layout.CellSize, parentAbsoluteSize)
		)
	else -- UIListLayout
		for _, child in ipairs(parent:GetChildren()) do
			if child:IsA('GuiObject') then
				addConstraint(
					child,
					absoluteSizeFromUDim2(child.Size, parentAbsoluteSize)
				)
			end
		end
	end
end
