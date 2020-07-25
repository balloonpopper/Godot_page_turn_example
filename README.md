Book with turning pages example for Godot.

Summary
=======
Includes both 2D and 3D examples of a book with turning pages. A dynamic number of pages is supported by adding images for as many pages as you like, and updating a 'number of pages' variable.

Tested in Godot 3.2.2

This demo is free to use in any way you like (a shoutout in your project would be nice though!)

The demo uses 3 scenes, a loading scene, and both a 2D and 3D demo.

Keys
====
When in the demo, use the following keys : 
Left and Right cursor to change pages
ESC to quit

How it works
============
The 2D Demo uses mesh deformations to simulate turning pages. You will notice that the page content "bends" as the page turns due to the way Godot has stored the page polygon as 2 triangles. I haven't worked out a way to get it to deform the polygon as a square, regardless of the number of points used on the polygon. Every other technique I tried changed the zoom ratio on the whole image rather than just one side, so this is the best compromise I've found to date.

The 3D demo uses CSG meshes for each of the 6 pages (ie. 3 pages, front and back). 3 pages are required to be loaded as when a page is being turned you'll also be able to see the previous and next pages. Page turns are achieved by loading the image of the page and setting it as the albedo of the relevant mesh before rotating the meshes as appropriate.

Both the 2D and 3D Demos run an "idle" animation at on _ready to ensure that the animations are reset and the book starts at the front with the cover closed.

Setting your own graphics (page content)
========================================
The graphics used are 480x640 for each page as I found this worked well with a 1080p resolution. If you want to change this you'll need to change the polygons/UV (2D scene) or CSGMeshes (3D scene) accordingly. You'll also need to update the animation frames for each animation frame for the polygons/translations as necessary.

For both demos, the contents of the pages are loaded dynamically from image files as the pages are turned. To put your own page contents, add images called "pageX.png" (where X is a sequential number) into the appropriate directory and set the total number of pages at the top of the script. 

Page Turning Speed
==================
The turning speed variable in the example scenes is a ratio. 0.5 is half the current speed, 2 is double the current speed.
