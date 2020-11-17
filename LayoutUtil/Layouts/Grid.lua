--!strict

-- Variables


local libs = script.Parent.Parent
local Utility = require(libs.Utility)
local Typings = require(libs.Typings)
local Layout = require(script.Parent.Layout)

local Grid = {}


-- Internal


function Grid:__index(key)
	return rawget(self, key) or Grid[key] or Layout[key]
end


function Grid:__tostring()
	return ('Grid(%s)'):format(self.Ref.Name)
end


function Grid:_isValid(T, bool)
	return bool or (self['DoUpdate'..T] and not self.Paused and not self.Destroyed)
end


function Grid:_updateSize(bypass)
	if not self:_isValid('Size', bypass) then return end

	local absSize = self._scrollFrame.AbsoluteSize
	local new = self._cellSize * absSize

	self._cellSizeQueue[Utility.ser(new.X, new.Y)] = true
	self.Ref.CellSize = UDim2.fromOffset(new.X, new.Y)
end


function Grid:_updatePadding(bypass)
	if not self:_isValid('Padding', bypass) then return end

	local absSize = self._scrollFrame.AbsoluteSize
	local new = self._cellPadding * absSize

	self._cellPaddingQueue[Utility.ser(new.X, new.Y)] = true
	self.Ref.CellPadding = UDim2.fromOffset(new.X, new.Y)
end


function Grid:_updateCanvas(bypass)
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


function Grid:_update(bypass)
	self:_updateSize(bypass)
	self:_updatePadding(bypass)
	self:_updateCanvas(bypass)
end


-- Constructor


function Grid.new(layout: UIGridLayout, noStartup: boolean?): Typings.Grid
	local self = setmetatable(Layout.new(layout), Grid)

	local function getCell(T)
		local converted = Utility.convert(layout, 'Cell'..T, 'Scale')
		return Vector2.new(converted.X.Scale, converted.Y.Scale)
	end

	self._cellPaddingQueue = {}
	self._cellPadding = getCell('Padding')

	self._cellSizeQueue = {}
	self._cellSize = getCell('Size')

	self._maid:GiveTasks(
		layout:GetPropertyChangedSignal('Parent'):Connect(function()
			self:Destroy()

			if layout.Parent and layout.Parent:IsA('ScrollingFrame') then
				setmetatable(self, Grid.new(layout))
			end
		end),

		layout:GetPropertyChangedSignal('CellSize'):Connect(function()
			local p = layout.CellSize
			local key = Utility.ser(p.X.Offset, p.Y.Offset)

			if not self._cellSizeQueue[key] then
				self._cellSize = getCell('Size')
				self:_updateSize()
			else
				self._cellSizeQueue[key] = nil
			end
		end),

		layout:GetPropertyChangedSignal('CellPadding'):Connect(function()
			local p = layout.CellPadding
			local key = Utility.ser(p.X.Offset, p.Y.Offset)

			if not self._cellPaddingQueue[key] then
				self._cellPadding = getCell('Padding')
				self:_updatePadding()
			else
				self._cellPaddingQueue[key] = nil
			end
		end),

		layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			self:_updateCanvas()
		end),

		layout:GetPropertyChangedSignal('FillDirection'):Connect(function()
			self._scrollFrame.CanvasSize = UDim2.new()
			self:_updateCanvas()
		end),

		self._scrollFrame:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()
			self:_update()
		end)
	)

	if not noStartup then
		self:Play()
	end

	return self
end


-- Export


return Grid