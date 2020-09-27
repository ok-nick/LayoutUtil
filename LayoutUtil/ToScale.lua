return function(Size, Parent, Axis)
	return Parent and (Size[Axis].Offset / Parent.AbsoluteSize[Axis]) + Size[Axis].Scale
end