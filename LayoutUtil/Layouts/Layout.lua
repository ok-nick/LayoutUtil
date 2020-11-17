-- making this strict would blind you with orange

-- Variables


local libs = script.Parent.Parent
local Typings = require(libs.Typings)
local Maid = require(libs.Maid)

local Layout = {}


-- Public


function Layout:UpdatePadding()
	self:_updatePadding(true)
end


function Layout:UpdateSize()
	self:_updateSize(true)
end


function Layout:UpdateCanvas()
	self:_updateCanvas(true)
end


function Layout:Update()
	self._scrollFrame.CanvasSize = UDim2.new()
	self:_update(true)
end


function Layout:Play()
	if not self.Paused then return end
	self.Paused = false

	self._scrollFrame.CanvasSize = UDim2.new()
	self:_update()
end


function Layout:Pause()
	self.Paused = true
end


function Layout:Destroy()
	self.Destroyed = true
	self._maid:DoCleaning()

	setmetatable(self, nil)
end


-- Constructor


function Layout.new(layout: UIGridLayout | UIListLayout) -- would specify return type, but makes the linter funky
	assert(layout.Parent and layout.Parent:IsA('ScrollingFrame'), 'Layout must have parent of type ScrollingFrame')

	return {
		Ref = layout,

		Paused = true,
		Destroyed = false,

		DoUpdatePadding = true,
		DoUpdateSize = true,
		DoUpdateCanvas = true,

		_scrollFrame = layout.Parent,
		_maid = Maid.new()
	}
end


-- Export


return Layout