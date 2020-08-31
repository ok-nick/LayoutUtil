## MISTAKES
### **NUMBER 1**
Unfortunatley with all the good, there will be some inconveniencies. If you set everything up with your UILayout in offset, a display with a different resolution wouldn't be able to scale it correctly. Make sure that your UIGridLayout's CellPadding and CellSize are set to scale. With a UIListLayout your Padding and every child must be set to scale. This could be easily done with the [ConvertToScale](api.md) function provided within the main module.
### **NUMBER 2**
You should be still using a UIAspectRatioConstraint within the main frame relative to the ScrollingFrame so that the ScrollingFrame will maintain it's proper aspect ratio. Failure to do this will result in stretching and other inconsistencies.
### **NUMBER 3**
The CanvasSize of your ScrollingFrame must be set to (0, 0, 0, 0) otherwise the GuiObjects inside will stretch. I'm planning on creating a feature that will remove the need for this.