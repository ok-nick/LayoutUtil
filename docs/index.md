## What is LayoutUtil?
You may encounter a problem where you want your ScrollingFrame to automatically resize itself, but it's too much of a hassle. With problems such as: stretching out UI elements, the amount of elements per row or column, and the padding incosistent across resolutions. Most people resort to leaving a ton of empty space at the bottom of a ScrollingFrame. LayoutUtil is a library that will automatically resize a frame's CanvasSize as well as it's children with the added benefit of padding.

I've come across many games on the platform that disregard this and just create their ScrollingFrames with an incredibly large CanvasSize. This will work and saves a lot of time, but it will seem very careless to the user and overall it just looks like poop. LibraryUtil is very basic to use, after you construct a class with the desired UILayout, it will immediately (or it can be paused/played later) bind itself to changes within the ScrollingFrame to keep everything tidy.

## Without LayoutUtil
![Alt Text](https://media.giphy.com/media/jUVsdqhLYrvU7TwXiO/giphy.gif)


## With LayoutUtil
![Alt Text](https://media.giphy.com/media/dxTYR3M3Y6So4oESTh/giphy.gif)