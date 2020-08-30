-- Variables --


local Maid = require(script.Parent.Maid)

local Grid = {}
Grid.__index = Grid


-- Public --


function Grid:ResizeCanvas()
	if self.Config.ResizeCanvas == false then return end
	local ContentSize = self.Layout.AbsoluteContentSize

	self.ScrollingFrame.CanvasSize = UDim2.fromOffset(ContentSize.X, ContentSize.Y)
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

	if C.OnRemove ~= false then
		self._maid.ChildRemoved = self.ScrollingFrame.ChildRemoved:Connect(function()
			self:ResizeCanvas()
		end)
	end

	if C.OnAdd ~= false then
		self._maid.ChildAdded = self.ScrollingFrame.ChildAdded:Connect(function()
			self:ResizeCanvas()
		end)
	end
end


function Grid:Unbind()
	self._maid:DoCleaning()
end


function Grid:SetDefault(Padding, Size)
	local function ToScale(Absolute, Axis)
		return (Absolute[Axis].Offset / self.ScrollingFrame.AbsoluteSize[Axis]) + Absolute[Axis].Scale
	end

	self.Padding = Vector2.new(ToScale(Padding, 'X'), ToScale(Padding, 'Y'))
	self.Size = Vector2.new(ToScale(Size, 'X'), ToScale(Size, 'Y'))
end


-- Constructor --


function Grid.new(Layout, Config)
	local self = setmetatable({}, Grid)

	self.Config = Config or {}
	self._maid = Maid.new()

	local SF = Layout.Parent
	self.ScrollingFrame = SF
	self.Layout = Layout

	local function CalcRatio(Axis)
		return (math.abs(((SF.Parent.AbsoluteSize[Axis] * SF.CanvasSize[Axis].Scale) + SF.CanvasSize[Axis].Offset) - SF.AbsoluteSize[Axis]) / SF.AbsoluteSize[Axis]) + SF.Size[Axis].Scale
	end

	local ResizeX, ResizeY = SF.CanvasSize.X ~= UDim.new(), SF.CanvasSize.Y ~= UDim.new()
	Layout.CellSize = UDim2.new(Layout.CellSize.X.Scale * (ResizeX and CalcRatio('X') or 1), 0, Layout.CellSize.Y.Scale * (ResizeY and CalcRatio('Y') or 1), 0)
	SF.CanvasSize = UDim2.new(0,0,0,0) -- don't need

	self:SetDefault(self.Config.CellPadding or Layout.CellPadding, self.Config.CellSize or Layout.CellSize)
	self:ResizeContent()

	if self.Config.Bind ~= false then
		self:Bind()
	end

	return self
end


-- Setup --


return Grid