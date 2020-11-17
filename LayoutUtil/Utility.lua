--!strict

-- Variables


local Utility = {}


-- Public


function Utility.fastRemove(tbl: {number: any}, index: number) -- would use {any}, but it makes the linter angry
    local n = #tbl
    tbl[index] = tbl[n]
    tbl[n] = nil
end


function Utility.ser(...)
	local str = ''
	for _, num in next, {...} do
		str = str..math.floor(num)
	end

	return tonumber(str)
end


function Utility.toScale(scale: number, offset: number, parentSize: number): number
	return (offset / parentSize) + scale
end


function Utility.toOffset(scale: number, offset: number, parentSize: number): number
	return (scale * parentSize) + offset
end


function Utility.convert(obj: GuiObject | UILayout, prop: string, T: string): UDim2 | UDim
	local parentSize = obj.Parent.AbsoluteSize
	local ud = obj[prop]

	local to = T == 'Scale' and Utility.toScale or Utility.toOffset
	if typeof(obj[prop]) == 'UDim2' then
		return UDim2['from'..T](to(ud.X.Scale, ud.X.Offset, parentSize.X), to(ud.Y.Scale, ud.Y.Offset, parentSize.Y))
	else
		local axis = 'X'
		if obj:IsA('UIListLayout') then
			axis = obj.FillDirection == Enum.FillDirection.Horizontal and 'X' or 'Y'
		end

		local data = {
			[T] = to(ud.Scale, ud.Offset, parentSize[axis])
		}

		return UDim.new(data.Scale, data.Offset)
	end
end


-- Export


return Utility