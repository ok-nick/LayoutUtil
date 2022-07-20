interface LayoutUtil {
    /**
     * Inserts and calculates the `AspectRatio` of a `UIAspectRatioConstraint`.
     * If a constraint already exists, it will overwrite the `AspectRatio` property.
     *
     * @param {GuiObject} object The object to be handled.
     * @param {Vector2} absoluteSize AbsoluteSize of the object; defaults to manually retrieving the property. If the object isn't a
     *		descendant of `game`, then the AbsoluteSize will be (0, 0), which is why this parameter is necessary.
     */
    constrain: (object: GuiObject, absoluteSize?: Vector2) => void;

    /**
     * Uses the `constrain` function to insert a constraint into the `UIGridLayout`.
     *
     * @param {UIGridLayout} layout The `UIGridLayout` to be constrained.
     * @param {Vector2} parentSize `AbsoluteSize` of the parent of the layout; defaults to manually retrieving the property. If the object isn't a
     *		descendant of `game`, then the `AbsoluteSize` will be (0, 0), which is why this parameter is necessary.
     */
    grid: (layout: UIGridLayout, parentSize?: Vector2) => void;

    /**
     * Uses the `constrain` function to insert a constraint into each child of the parenting `ScrollingFrame`.
     *
     * @param {UIGridLayout} layout The `UIListLayout` to be constrained.
     * @param {Vector2} parentSize `AbsoluteSize` of the parent of the layout; defaults to manually retrieving the property. If the object isn't a
     * 		descendant of `game`, then the `AbsoluteSize` will be (0, 0), which is why this parameter is necessary.
     */
    list: (layout: UIGridLayout, parentSize?: Vector2) => void;

    /**
     * Watches a `UIListLayout` to automatically resize new children. This function is only available for `UIListLayouts` since `UIGridLayouts` do not
     * need any runtime work.
     *
     * @param {UIListLayout} layout The `UIListLayout` to be watched.
     * @returns {RBXScriptConnection} The connection which automatically constrains new children as they are added.
     */
    watch: (layout: UIListLayout) => RBXScriptConnection;

    /**
     * Alternative to the `AutomaticCanvasSize` property, as it is buggy.
     *
     * @param {ScrollingFrame} scrollingFrame The `ScrollingFrame` to be automatically sized.
     * @param {UIListLayout | UIGridLayout} layout The layout within the `ScrollingFrame`.
     * @param {Enum.AutomaticSize} axis The axis of which to automatically scale the `CanvasSize`.
     * @returns {RBXScriptConnection} The connection which automatically resizes the canvas when the content size changes.
     */
    resize: (
        scrollingFrame: ScrollingFrame,
        layout: UIListLayout | UIGridLayout,
        axis: Enum.AutomaticSize
    ) => RBXScriptConnection;
}

declare const LayoutUtil: LayoutUtil;
export = LayoutUtil;
