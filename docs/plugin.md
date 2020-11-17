# [LayoutUtilPlugin](https://www.roblox.com/library/5965597514/LayoutUtilPlugin)
### The plugin to end the clash between scale and offset. It contains a total of five buttons:
* Scale - *Converts the selected GuiObject to scale.*
* Offset - *Converts the selected GuiObject to offset.*
* RatioConstraint - *Inserts a UIAspectRatioConstraint into the selected objects, automatically calculating the AspectRatio.*
* Remove Canvas - *Sets the CanvasSize to all zeros while maintaining the size of each child, which makes LayoutUtil happy.*
* Import - *Imports the latest version of LayoutUtil into the StarterGui.*

### A few key features include:
* The ability to convert UIGridLayouts, UIListLayouts, UIPaddings, UICorners, UIPageLayouts, and UITableLayouts to scale or offset.
* Selecting a ScreenGui (or BillboardGui, SurfaceGui, &, etc) will convert every descendant.
* Converting elements in a ScrollingFrame will make sure it's size stays consistent.
* Automatically converts the CanvasSize to scale (which shouldn't be too important for LayoutUtil).
* Utilizes ChangeHistoryService so you could easily revert changes.
* Removing the CanvasSize from a ScrollingFrame will keep the size of each child (accounts for UIGridLayouts).
* A lot of edge cases are checked, being if the parent is a type of Gui it will use the screen size, otherwise if it's not a GuiObject it won't resize. If the property is being affected by the X or Y axis (ex: FillDirection & more in-depth ones).