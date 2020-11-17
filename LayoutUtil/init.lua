--[[
	LayoutUtil v1.0.0
	11/17/20

	DevForum Thread: https://devforum.roblox.com/t/layoututil-automatically-sizes-a-scrollingframes-uigridlayout-uilistlayout/720840?u=iinemo
	Documentation: https://nickuhhh.github.io/LayoutUtil/
	Repository: https://github.com/Nickuhhh/LayoutUtil/tree/master
	Releases: https://github.com/Nickuhhh/LayoutUtil/releases/latest

	Roblox: iiNemo
	Discord: nickk#9163
]]

--!strict

local Typings = require(script.Typings)
export type Grid = Typings.Grid
export type List = Typings.List


local Layouts = require(script.Layouts)
local Grid, List = Layouts.Grid, Layouts.List

return {
	Version = 'v1.0.0',

	Grid = Grid,
	List = List,

	new = function (layout: ScrollingFrame | UIGridLayout | UIListLayout, noStartup: boolean?) -- if I specify the return type, the linter gets angry
		if layout:IsA('ScrollingFrame') then
			layout = layout:FindFirstChildOfClass('UIGridLayout') or layout:FindFirstChildOfClass('UIListLayout')

			if not layout then
				error('bad argument #1, ScrollingFrame must contain a UILayout')
			end
		end

		return layout:IsA('UIGridLayout') and Grid.new(layout, noStartup) or List.new(layout, noStartup)
	end
}