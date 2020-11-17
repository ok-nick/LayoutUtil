export declare abstract class Layout<T> {
	/**
	 * A reference to the UILayout
	 */
	readonly Ref: T;

	/**
	 * Boolean describing if the class is paused
	 */
	readonly Paused: boolean;

	/**
	 * Boolean describing if the class has been destroyed
	 */
	readonly Destroyed: boolean;

	/**
	 * Whether or not the padding should be updated
	 */
	DoUpdatePadding: boolean;

	/**
	 * Whether or not the size should be updated
	 */
	DoUpdateSize: boolean;

	/**
	 * Whether or not the canvas should be updated
	 */
	DoUpdateCanvas: boolean;

	/**
	 * Constructs a new class with the specified parameters
	 * @param layout The UILayout to be wrapped
	 * @param noStartup Whether or not it will automatically Play when created
	 */
	constructor(layout: T, noStartup: boolean);

	/**
	 * Manually updates the padding
	 */
	UpdatePadding(): void;

	/**
	 * Manually updates the size
	 */
	UpdateSize(): void;

	/**
	 * Manually updates the canvas
	 */
	UpdateCanvas(): void;

	/**
	 * Manually updates the everything
	 */
	Update(): void;

	/**
	 * Starts up the task to run
	 */
	Play(): void;

	/**
	 * Pauses the class from running
	 */
	Pause(): void;

	/**
	 * Destroys the class completely
	 */
	Destroy(): void;
}