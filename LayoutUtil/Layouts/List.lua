--!strict

-- Variables


local libs = script.Parent.Parent
local Utility = require(libs.Utility)
local Maid = require(libs.Maid)
local Typings = require(libs.Typings)
local Layout = require(script.Parent.Layout)

local List = {}


-- Internal

function List:__index(key)
	return rawget(self, key) or List[key] or Layout[key]
end


function List:__tostring()
	return ('List(%s)'):format(self.Ref.Name)
end


function List:_isValid(T, bool)
	return bool or (self['DoUpdate'..T] and not self.Paused and not self.Destroyed)
end


function List:_updateObject(object)
	local s = object.size
	local size = Vector2.new(s.X.Scale, s.Y.Scale) * self._scrollFrame.AbsoluteSize

	object.queue[Utility.ser(size.X, size.Y)] = true
	object.ref.Size = UDim2.fromOffset(size.X, size.Y)
end


function List:_addObject(object, noUpdate)
	local tbl = {
		ref = object,
		size = Utility.convert(object, 'Size', 'Scale'),
		queue = {}
	}
	table.insert(self._children, tbl)

	local maid = Maid.new()
	self._maid:GiveTask(maid)

	maid:GiveTasks(
		object:GetPropertyChangedSignal('Size'):Connect(function()
			local size = object.Size
			local key = Utility.ser(size.X.Offset, size.Y.Offset)

			if size.X.Scale ~= 0 or size.Y.Scale ~= 0 or not tbl.queue[key] then
				tbl.size = Utility.convert(object, 'Size', 'Scale')

				if not self:_isValid('Size') then return end
				self:_updateObject(tbl)
			else
				tbl.queue[key] = nil
			end
		end),

		object:GetPropertyChangedSignal('Parent'):Connect(function()
			if not object.Parent then
				maid:DoCleaning()

				local index = table.find(self._children, tbl)
				if index then
					Utility.fastRemove(self._children, index)
				end
			end
		end)
	)

	if not noUpdate and self:_isValid('Size') then
		self:_updateObject(tbl)
	end
end


function List:_updateCanvas(bypass)
	if not self:_isValid('Canvas', bypass) then return end

	local contentSize = self.Ref.AbsoluteContentSize
	local canvas = {X = contentSize.X, Y = contentSize.Y}
	for axis, _ in next, canvas do
		if math.floor(contentSize[axis]) == math.floor(self._scrollFrame.AbsoluteSize[axis]) then
			canvas[axis] = 0
		end
	end

	self._scrollFrame.CanvasSize = UDim2.fromOffset(canvas.X, canvas.Y)
end


function List:_updatePadding(bypass)
	if not self:_isValid('Padding', bypass) then return end

	local axis = self.Ref.FillDirection == Enum.FillDirection.Horizontal and 'X' or 'Y'
	local offset = self._padding * self._scrollFrame.AbsoluteSize[axis]

	self._paddingQueue[Utility.ser(offset)] = true
	self.Ref.Padding = UDim.new(0, offset)
end


function List:_updateSize(bypass)
	if not self:_isValid('Size', bypass) then return end

	for _, object in next, self._children do
		self:_updateObject(object)
	end
end


function List:_update(bypass)
	self:_updatePadding(bypass)
	self:_updateSize(bypass)
	self:_updateCanvas(bypass)
end


-- Constructor


function List.new(layout: UIListLayout, noStartup: boolean?): Typings.List
	local self = setmetatable(Layout.new(layout), List)

	self._children = {}

	self._paddingQueue = {}
	self._padding = Utility.convert(layout, 'Padding', 'Scale').Scale

	self._maid:GiveTasks(
		layout:GetPropertyChangedSignal('Parent'):Connect(function()
			self:Destroy()

			if layout.Parent and layout.Parent:IsA('ScrollingFrame') then
				setmetatable(self, List.new(layout))
			end
		end),

		layout:GetPropertyChangedSignal('Padding'):Connect(function()
			local p = layout.Padding
			if not self._paddingQueue[p.Offset] then
				self._padding = Utility.convert(layout, 'Padding', 'Scale').Scale
				self:_updatePadding()
			else
				self._paddingQueue[p.Offset] = nil
			end
		end),

		layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			self:_updateCanvas()
		end),

		layout:GetPropertyChangedSignal('FillDirection'):Connect(function()
			self:_updateCanvas()
		end),

		self._scrollFrame.ChildAdded:Connect(function(object)
			if object:IsA('GuiObject') then
				self:_addObject(object, self.Paused)
			end
		end),

		self._scrollFrame:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()
			self:_update()
		end)
	)

	for _, object in next, self._scrollFrame:GetChildren() do
		if object:IsA('GuiObject') then
			self:_addObject(object, noStartup)
		end
	end

	if not noStartup then
		self:Play()
	end

	return self
end


-- Export


return List