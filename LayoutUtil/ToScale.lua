return function(Size, Parent, Axis)
	return (Size[Axis].Offset / Parent.AbsoluteSize[Axis]) + Size[Axis].Scale
end