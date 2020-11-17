--[[
	Kinda cringe, but intersection types don't seem to work when exporting, hence the repetition.
]]

export type Grid = {
	Ref: UIGridLayout,
	Paused: boolean,
	Destroyed: boolean,

	DoUpdatePadding: boolean,
	DoUpdateSize: boolean,
	DoUpdateCanvas: boolean,

	UpdateSize: (Grid) -> nil,
	UpdatePadding: (Grid) -> nil,
	UpdateCanvas: (Grid) -> nil,
	Update: (Grid) -> nil,

	Play: (Grid) -> nil,
	Pause: (Grid) -> nil,
	Destroy: (Grid) -> nil
}


export type List = {
	Ref: UIListLayout,
	Paused: boolean,
	Destroyed: boolean,

	DoUpdatePadding: boolean,
	DoUpdateSize: boolean,
	DoUpdateCanvas: boolean,

	UpdateSize: (List) -> nil,
	UpdatePadding: (List) -> nil,
	UpdateCanvas: (List) -> nil,
	Update: (List) -> nil,

	Play: (List) -> nil,
	Pause: (List) -> nil,
	Destroy: (List) -> nil
}


return 0