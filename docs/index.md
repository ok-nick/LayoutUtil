## What is LayoutUtil?
You may've come across a problem where you want your UILayout to automatically resize itself, but it's too much of a hassle. LayoutUtil is a library that will automatically resize a frame's CanvasSize based off it's amount of children. Not only that, but it will make sure that each child maintains the correct aspect ratio so that there is no stretching or missing rows/columns.

I've come across many games on the platform that disregard this and just create their ScrollingFrames with an extremely large CanvasSize. This will work and saves a lot of time, but it will seem very careless to the user and overall it just looks like poop. LibraryUtil is very basic to use, after you construct a class with the desired UILayout, it will immediatley bind itself to changes within the ScrollingFrame to keep everything tidy.

## Without LayoutUtil
![Alt Text](https://media.giphy.com/media/jUVsdqhLYrvU7TwXiO/giphy.gif)


## With LayoutUtil
![Alt Text](https://media.giphy.com/media/dxTYR3M3Y6So4oESTh/giphy.gif)