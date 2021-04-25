# Changelog

## [Unreleased]

### Added
- `.constraint` function for calculating and inserting UIAspectRatioConstraints.
- `.grid` function for UIGridLayouts.
- `.list` function for UIListLayouts.
- `.watch` function for UIListLayouts to automatically affect new children.
- `.resize` function to temporarily replace the `AutomaticCanvasSize` property, as it's extremely buggy.
- A few unit tests via TestEz.

## [2.0.0] - 2021-02-29
- Complete recreation yet again, utilizing the new `AutomaticCanvasSize` property and the power of
  UIAspectRatioConstraints. The latest update has been described [here](https://devforum.roblox.com/t/layoututil-automatically-sizes-a-scrollingframes-uigridlayout-uilistlayout/720840/46?u=iinemo).

## [1.0.0] - 2020-11-17
- [Complete recode.](https://devforum.roblox.com/t/layoututil-automatically-sizes-a-scrollingframes-uigridlayout-uilistlayout/720840/36?u=iinemo)

## [0.1.6] - 2020-10-07
- Fixed bug when the size of a element in a UIListLayout is exactly the size of one of the parent's axis's, it created a scrolling bar.

## [0.1.5] - 2020-10-06
- Fixed a bug that was caused by a fix to another bug which was a fix to another bug which was a fix to another bug.

## [0.1.4] - 2020-10-05
- Reverted a fix from 9/20/2020 that caused more problems.

## [0.1.3] - 2020-09-27
- Fixed bug relating to Scrolling Frame's with UIListLayouts CanvasSize stretching when it reaches past AbsoluteSize.

## [0.1.2] - 2020-09-20
- Fixed bug where if you changed the size of an object in a UIListLayout it wouldn't scale that object based on the new size.

## [0.1.1] - 2020-08-31
- Fixed bug where if you changed resolutions quickly it would miscalculate the CanvasSize.

## [0.1.0] - 2020-08-30
- Initial release.

<!-- -->
[unreleased]: https://github.com/ok-nick/LayoutUtil/compare/v2.0.0...HEAD
[2.0.0]: https://github.com/ok-nick/LayoutUtil/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/ok-nick/LayoutUtil/compare/v0.1.6...v1.0.0
[0.1.6]: https://github.com/ok-nick/LayoutUtil/compare/v0.1.5...v0.1.6
[0.1.5]: https://github.com/ok-nick/LayoutUtil/compare/v0.1.4...v0.1.5
[0.1.4]: https://github.com/ok-nick/LayoutUtil/compare/v0.1.3...v0.1.4
[0.1.3]: https://github.com/ok-nick/LayoutUtil/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/ok-nick/LayoutUtil/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/ok-nick/LayoutUtil/compare/v0.1...v0.1.1
[0.1.0]: https://github.com/ok-nick/LayoutUtil/releases/tag/v0.1
