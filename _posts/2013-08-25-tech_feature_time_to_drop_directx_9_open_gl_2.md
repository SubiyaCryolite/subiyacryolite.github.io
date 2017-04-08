---
layout: post
title: "Tech Feature - Time to drop DirectX 9/OpenGL 2"
categories: "scnd" "genesis" "legacy" "development" "update" "opengl" "directx" "api"
---
In case you missed it my current game is being written in OpenGL 3, which is basically the equivalent of DirectX 10. 
When I made this decision in 2011 part of me was  worried that Id come to regret that  decision. Why?
Even the most high budget mainstream games at the time were still shipping in with DirectX 9.
A huge bunch of online OpenGL tutorials were based strictly on version 2.0 to boot. 
I was worried that I wouldn't have an audience, and that my fairly basic 2D game simply would not run on most peoples PCs.

Fast forward 2 years however, and Im glad I made the investment, glad I ported my code to JOGL, glad I wrote those darn matrices all by myself. 
Both the PlayStation 4 and XBox One are launching later this year. 
Both of those systems have DirectX 11 level graphics hardware. 
Even the weaker Wii Us GPU is based on DirectX 10.1 level hardware.

 ![OpenGL 3](http://www.scndgen.com/blog/2013_08_25/opengl3_logo1.png)

In the PC space most peoples machines are more than capable of supporting OpenGL 3.0. 
According to Unitys Web Player stats [link](http://stats.unity3d.com/web/gpu.html) as of 25th 
August 2013, DX10 accounts for 51.8% of users GPUs while DX11 accounts for 23.8%. 
Given that DX11 supersedes DX10, the actual amount of DX10/GL3 capable _hardware_ is 75.6%, assuming their OS supports it.

The same is similar for the Unity Editor [link](http://stats.unity3d.com/editor/gpu.html) as 
well, with DX11 accounting for 49.4% and DX10 for 41.7% for a total of 91% DX10/GL3 ready hardware. 
Steams hardware stats [link](http://store.steampowered.com/hwsurvey)  aren't far off either, 
with 26.47% DX10/GL3 and 62.21% are DX11/GL4, a total of 88.68% DX10 capable _hardware_. 
This will only increase as the rest of the 8th generation gaming consoles finally launch and time goes by.

 ![Powered by OpenGL 3.](http://www.scndgen.com/blog/2013_08_25/scndgen_legacy_1_ultra.png)

So what am I saying? If you plan on, or are already developing a game, I highly recommend using DX10 or GL3 as your rendering API. 
Most systems already support it and you'll be able to take advantage of many optimizations as well as implement several graphical enhancements. 
Furthermore, both APIs can be seamlessly upgraded to DX11/GL4 in a few years time, versus inevitably having to rewrite 
from scratch if you insist on sticking with GL2/DX9.

If you don't plan on making the jump, I'd love to know the reasons why. Please feel free to comment below. Cheers.