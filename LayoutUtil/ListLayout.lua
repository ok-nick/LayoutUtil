-- Variables --


local ToScale = require(script.Parent.ToScale)
local Maid = require(script.Parent.Maid)

local List = {}
List.__index = List


-- Public --


function List:AddObject(Object)
	if Object:IsA('GuiObject') then
		local Size = Object.Size

		table.insert(self.Children, {
			Object = Object,
			DefaultSize = Vector2.new(
				ToScale(Size, Object.Parent, 'X'),
				ToScale(Size, Object.Parent, 'Y')
			)
		})
	end
end


function List:RemoveObject(Object)
	local Index = table.find(self.Children, Object)

	if Index then
		self.Children[Index].ChangedEvent:Disconnect()

		table.remove(self.Children, Index)
	end
end


function List:GetAxis(FillDirection)
	assert(typeof(FillDirection) == 'EnumItem', 'bad argument #1, not a valid FillDirection enum')

	return FillDirection == Enum.FillDirection.Horizontal and 'X' or 'Y'
end


function List:ResizeCanvas()
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


function List:ResizeContent()
	if self.Config.ResizeContent == false then return end

	for i = 1, #self.Children do
		local Info = self.Children[i]

		local NewSize = Info.DefaultSize * self.ScrollingFrame.AbsoluteSize
		Info.Object.Size = UDim2.fromOffset(NewSize.X, NewSize.Y)
	end

	self.Layout.Padding = UDim.new(0, self.Padding * self.ScrollingFrame.AbsoluteSize[self.Axis])

	self:ResizeCanvas()
end


function List:Bind()
	local C = self.Config

	if C.OnResize ~= false then
		self._maid.Resized = self.ScrollingFrame:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()
			self:ResizeContent()
		end)
	end

	if C.OnAxisChange ~= false then
		self._maid.AxisChanged = self.Layout:GetPropertyChangedSignal('FillDirection'):Connect(function()
			self.Axis = self:GetAxis(self.Layout.FillDirection)
			self:ResizeContent()
		end)
	end

	if C.OnWindowResize ~= false then
		self._maid.OnWindowResize = self.Layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			self:ResizeCanvas()
		end)
	end

	if C.OnRemove ~= false then
		self._maid.ChildRemoved = self.ScrollingFrame.ChildRemoved:Connect(function(Object)
			self:RemoveObject(Object)
		end)
	end

	if C.OnAdd ~= false then
		self._maid.ChildAdded = self.ScrollingFrame.ChildAdded:Connect(function(Object)
			self:AddObject(Object)
		end)
	end
end


function List:Unbind()
	self._maid:DoCleaning()
end


function List:SetDefault(Padding)
	assert(typeof(Padding) == 'UDim', 'bad argument #1, not a valid UDim')

	local Size = {
		X = {
			Offset = Padding.Offset,
			Scale = Padding.Scale
		}
	}
	Size.Y = Size.X

	self.Padding = ToScale(Size, self.ScrollingFrame, self.Axis)
end


-- Library --


function List.new(Layout, Config)
	local self = setmetatable({}, List)

	self.Config = Config or {}
	self._maid = Maid.new()

	self.Axis = self:GetAxis(Layout.FillDirection)
	self.ScrollingFrame = Layout.Parent
	self.Layout = Layout
	self.Children = {}

	for _, Object in next, self.ScrollingFrame:GetChildren() do
		self:AddObject(Object)
	end

	self:SetDefault(self.Config.Padding or Layout.Padding)
	self:ResizeContent()

	if self.Config.Bind ~= false then
		self:Bind()
	end

	return self
end


-- Setup --


return List