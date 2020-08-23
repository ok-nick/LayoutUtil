-- Variables --


local List = {}
List.__index = List


-- Private --


local function GetAxis(FillDirection)
	return FillDirection == Enum.FillDirection.Horizontal and 'X' or 'Y'
end


-- Public --


function List:AddObject(Object)
	if Object:IsA('GuiObject') then
		local Size = Object.Size
		table.insert(self.Children, {Object = Object, DefaultSize = Vector2.new(Size.X.Scale, Size.Y.Scale)})
	end
end


function List:ResizeCanvas()
	local ContentSize = self.Layout.AbsoluteContentSize
	self.ScrollingFrame.CanvasSize = UDim2.new(0, ContentSize.X, 0, ContentSize.Y)
end


function List:ResizeContent()
	for i = 1, #self.Children do
		local Info = self.Children[i]
		
		local NewSize = Info.DefaultSize * self.ScrollingFrame.AbsoluteSize
		Info.Object.Size = UDim2.new(0, NewSize.X, 0, NewSize.Y)
	end
	
	self.Layout.Padding = UDim.new(0, self.Padding * self.ScrollingFrame.AbsoluteSize[self.Axis])
	
	self:ResizeCanvas()
end


function List:Bind()
	if self.Binded then return end
	self.Binded = true
	
	self.OnResize = self.ScrollingFrame:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()
		self:ResizeContent()
	end)
	
	self.AxisChanged = self.Layout:GetPropertyChangedSignal('FillDirection'):Connect(function()
		self.Axis = GetAxis(self.Layout.FillDirection)
		self:ResizeContent()
	end)
	
	self.ChildRemoved = self.ScrollingFrame.ChildRemoved:Connect(function(Object)
		local Index = table.find(self.Children, Object)
		if Index then
			table.remove(self.Children, Index)
		end
		
		self:ResizeCanvas()
	end)
	
	self.ChildAdded = self.ScrollingFrame.ChildAdded:Connect(function(Object)
		self:AddObject(Object)
		self:ResizeCanvas()
	end)
end


function List:Unbind()
	if not self.Binded then return end
	self.Binded = false
	
	self.OnResize:Disconnect()
	self.ChildAdded:Disconnect()
	self.AxisChanged:Disconnect()
	self.ChildRemoved:Disconnect()
end


function List:SetDefault(Padding)
	self.Padding = (Padding.Offset / self.ScrollingFrame.AbsoluteSize[self.Axis]) + Padding.Scale
end


-- Library --


function List.new(Layout)
	local self = setmetatable({}, List)
	
	self.Axis = GetAxis(Layout.FillDirection)
	self.ScrollingFrame = Layout.Parent
	self.Layout = Layout
	self.Children = {}
	
	for _, Object in next, self.ScrollingFrame:GetChildren() do
		self:AddObject(Object)
	end
	
	self:SetDefault(Layout.Padding)
	self:ResizeContent()
	self:Bind()
	
	return self
end


-- Setup --


return List