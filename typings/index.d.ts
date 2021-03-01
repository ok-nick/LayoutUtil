/**
 * Automatically inserts and calculates UIAspectRatioConstraints into the corresponding UIGridLayout/UIListLayout. The
 * parent parameter is optional, but should be explicitly provided if the layout hasn't been parented. In order to
 * calculate the AspectRatio, I need the size of the UILayout (or children of a UIListLayout) in offset. Therefor if the
 * parent isn't a GuiObject or a Vector2, it will assume the parent size is the screens resolution.
 *
 * @param {UIGridLayout | UIListLayout} layout The UILayout to be applied.
 * @param {GuiObject | Instance | Vector2} [parentObjectOrSize] The object (or Vector2) to be recognized as the parent
 * 		in order to retrieve the AbsoluteSize (non-GuiObjects or nil, defaults to the screens resolution).
*/
declare const LayoutUtil: (layout: UIGridLayout | UIListLayout, parentObjectOrSize?: GuiObject | Instance | Vector2) => void;
export = LayoutUtil;
