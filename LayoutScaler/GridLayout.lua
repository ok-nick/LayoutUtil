-- Variables --


local Grid = {}
Grid.__index = Grid


-- Public --


function Grid:ResizeCanvas()
	local ContentSize = self.Layout.AbsoluteContentSize
	self.ScrollingFrame.CanvasSize = UDim2.new(0, ContentSize.X, 0, ContentSize.Y)
end


function Grid:ResizeContent() -- https://devforum.roblox.com/t/dynamically-sized-scrolling-frame-with-scale/210748/3?u=iinemo
	local AbsoluteSize = self.ScrollingFrame.AbsoluteSize

	local NewPadding = self.Padding * AbsoluteSize
	local NewSize = self.Size * AbsoluteSize

	self.Layout.CellPadding = UDim2.new(0, NewPadding.X, 0, NewPadding.Y)
	self.Layout.CellSize = UDim2.new(0, NewSize.X, 0, NewSize.Y)

	self:ResizeCanvas()
end


function Grid:Bind()
	if self.Binded then return end
	self.Binded = true

	self.OnResize = self.ScrollingFrame:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()
		self:ResizeContent()
	end)

	self.ChildRemoved = self.ScrollingFrame.ChildRemoved:Connect(function()
		self:ResizeCanvas()
	end)

	self.ChildAdded = self.ScrollingFrame.ChildAdded:Connect(function()
		self:ResizeCanvas()
	end)
end


function Grid:Unbind()
	if not self.Binded then return end
	self.Binded = false

	self.OnResize:Disconnect()
	self.ChildAdded:Disconnect()
	self.ChildRemoved:Disconnect()
end


function Grid:SetDefault(Padding, Size)
	local function ToScale(Absolute, Axis)
		return (Absolute[Axis].Offset / self.ScrollingFrame.AbsoluteSize[Axis]) + Absolute[Axis].Scale
	end

	self.Padding = Vector2.new(ToScale(Padding, 'X'), ToScale(Padding, 'Y'))
	self.Size = Vector2.new(ToScale(Size, 'X'), ToScale(Size, 'Y'))
end


-- Library --


function Grid.create(Layout)
	local self = setmetatable({}, Grid)

	self.ScrollingFrame = Layout.Parent
	self.Layout = Layout

	self:SetDefault(Layout.CellPadding, Layout.CellSize)
	self:ResizeContent()
	self:Bind()

	return self
end


-- Setup --


return Grid