-- Variables --


local Maid = require(script.Parent.Maid)

local List = {}
List.__index = List


-- Private --


local function GetAxis(FillDirection)
	return FillDirection == Enum.FillDirection.Horizontal and 'X' or 'Y'
end


local function AddObject(Table, Object)
	if Object:IsA('GuiObject') then
		local Size = Object.Size
		table.insert(Table, {Object = Object, DefaultSize = Vector2.new(Size.X.Scale, Size.Y.Scale)})
	end
end


-- Public --


function List:ResizeCanvas()
	if self.Config.ResizeCanvas == false then return end

	local ContentSize = self.Layout.AbsoluteContentSize
	self.ScrollingFrame.CanvasSize = UDim2.fromOffset(ContentSize.X, ContentSize.Y)
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
			self.Axis = GetAxis(self.Layout.FillDirection)
			self:ResizeContent()
		end)
	end

	if C.OnRemove ~= false then
		self._maid.ChildRemoved = self.ScrollingFrame.ChildRemoved:Connect(function(Object)
			local Index = table.find(self.Children, Object)
			if Index then
				table.remove(self.Children, Index)
			end

			self:ResizeCanvas()
		end)
	end

	if C.OnAdd ~= false then
		self._maid.ChildAdded = self.ScrollingFrame.ChildAdded:Connect(function(Object)
			AddObject(self.Children, Object)
			self:ResizeCanvas()
		end)
	end
end


function List:Unbind()
	self._maid:DoCleaning()
end


function List:SetDefault(Padding)
	self.Padding = (Padding.Offset / self.ScrollingFrame.AbsoluteSize[self.Axis]) + Padding.Scale
end


-- Library --


function List.new(Layout, Config)
	local self = setmetatable({}, List)

	self.Config = Config or {}
	self._maid = Maid.new()

	self.Axis = GetAxis(Layout.FillDirection)
	self.ScrollingFrame = Layout.Parent
	self.Layout = Layout
	self.Children = {}

	for _, Object in next, self.ScrollingFrame:GetChildren() do
		AddObject(self.Children, Object)
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