import { Layout } from './Layout';

type List = Layout<UIGridLayout>
type Grid = Layout<UIListLayout>

declare abstract class LayoutUtil {
	/**
	 * Returns the Grid class
	 */
	static readonly Grid: Grid;

	/**
	 * Returns the List class
	 */
	static readonly List: List;

	/**
	 * Constructs a new class from the specified object
	 * @param layout Object to construct class from
	 * @param nostartup Set to true to disable it from starting automatically
	 * @return Returns the class associated
	 */
	static new: <T>(
		layout: ScrollingFrame | UIGridLayout | UIListLayout,
		noStartup?: boolean,
	) => T extends ScrollingFrame ? Grid | List
		: T extends UIGridLayout ? Grid
		: T extends UIListLayout ? List
		: never;
}

export { LayoutUtil };