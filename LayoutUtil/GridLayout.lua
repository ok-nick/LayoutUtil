-- Variables --


local ToScale = require(script.Parent.ToScale)
local Maid = require(script.Parent.Maid)

local Grid = {}
Grid.__index = Grid


-- Public --


function Grid:ResizeCanvas()
	if self.Config.ResizeCanvas == false then return end
	local ContentSize = self.Layout.AbsoluteContentSize
	local AbsSize = self.ScrollingFrame.AbsoluteSize
	local X, Y = 0, 0

	if ContentSize.X >= AbsSize.X then
		X = ContentSize.X
	end
	if ContentSize.Y >= AbsSize.Y then
		Y = ContentSize.Y
	end

	self.ScrollingFrame.CanvasSize = UDim2.fromOffset(X, Y)
end


function Grid:ResizeContent() -- https://devforum.roblox.com/t/dynamically-sized-scrolling-frame-with-scale/210748/3?u=iinemo
	if self.Config.ResizeContent == false then return end
	local AbsoluteSize = self.ScrollingFrame.AbsoluteSize

	local NewPadding = self.Padding * AbsoluteSize
	local NewSize = self.Size * AbsoluteSize

	self.Layout.CellPadding = UDim2.fromOffset(NewPadding.X, NewPadding.Y)
	self.Layout.CellSize = UDim2.fromOffset(NewSize.X, NewSize.Y)

	self:ResizeCanvas()
end


function Grid:Bind()
	local C = self.Config

	if C.OnResize ~= false then
		self._maid.Resized = self.ScrollingFrame:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()
			self:ResizeContent()
		end)
	end

	if C.OnWindowResize ~= false then
		self._maid.OnWindowResize = self.Layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			self:ResizeCanvas()
		end)
	end
end


function Grid:Unbind()
	self._maid:DoCleaning()
end


function Grid:SetDefault(Padding, Size)
	assert(typeof(Padding) == 'UDim2', 'bad argument #1, not a valid UDim2')
	assert(typeof(Size) == 'UDim2', 'bad argument #2, not a valid UDim2')

	self.Padding = Vector2.new(ToScale(Padding, self.ScrollingFrame, 'X'), ToScale(Padding, self.ScrollingFrame, 'Y'))
	self.Size = Vector2.new(ToScale(Size, self.ScrollingFrame, 'X'), ToScale(Size, self.ScrollingFrame, 'Y'))
end


-- Constructor --


function Grid.new(Layout, Config)
	local self = setmetatable({}, Grid)

	self.Config = Config or {}
	self._maid = Maid.new()

	local SF = Layout.Parent
	self.ScrollingFrame = SF
	self.Layout = Layout

	-- local function CalcRatio(Axis) -- Purpose was to remove the need to set the default CanvasSize to all zeros, but there were too many miscalculations, may resolve in the future.
	-- 	if SF.Parent.AbsoluteSize[Axis] * SF.CanvasSize[Axis].Scale >= SF.AbsoluteSize[Axis] then
	-- 		return (math.abs(((SF.Parent.AbsoluteSize[Axis] * SF.CanvasSize[Axis].Scale) + SF.CanvasSize[Axis].Offset) - SF.AbsoluteSize[Axis]) / SF.AbsoluteSize[Axis]) + SF.Size[Axis].Scale
	-- 	end

	-- 	return 1
	-- end
	-- Layout.CellSize = UDim2.fromScale(Layout.CellSize.X.Scale * CalcRatio('X'), Layout.CellSize.Y.Scale * CalcRatio('Y'))

	self:SetDefault(self.Config.CellPadding or Layout.CellPadding, self.Config.CellSize or Layout.CellSize)
	self:ResizeContent()

	if self.Config.Bind ~= false then
		self:Bind()
	end

	return self
end


-- Setup --


return Grid