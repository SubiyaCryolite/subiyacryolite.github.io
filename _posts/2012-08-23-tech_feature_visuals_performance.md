---
layout: post
title: "Tech Feature - Visuals and Performance"
tags: [scnd,genesis,legacy,development,bug,bugs,quality,tech,java,opengl,fps,buffer]
---
This is the first entry in my tech feature series, which will help give you a better understanding of the  tech powering Legacy. Legacy is built on top of the <a href="http://www.moddb.com/engines/jenesis-engine" target="_blank">Jenesis Engine</a> (JE) which is written in Java. The Jenesis Engine uses an OpenGL wrapper library called <a href="http://en.wikipedia.org/wiki/Java_OpenGL" target="_blank">JOGL</a> to render 3D graphics.  </span>

The specific version of OpenGL being used is 3.2 Core along with GLSL 1.5. In Windows terms, this is the equivalent of DirectX 10 with Shader Model 4. This spec is fully supported across Linux, Mac OSX and Windows. If you have any GPU from Nvidia or AMD then your machine is probably capable of rendering with OpenGL 3.2. Only the most recent iterations of Intel GPUs fully implement this spec.

The following features of OpenGL are used in Legacy.
- [Vertex Array Objects (VAOs)](http://www.swiftless.com/tutorials/opengl4/4-opengl-4-vao.html "4. OpenGL 4 Vertex Array Objects (VAO) – Swiftless Tutorials - Game Programming and Computer Graphics Tutorials")
- [Pixel Buffer Objects (PBOs)](http://www.songho.ca/opengl/gl_pbo.html "OpenGL Pixel Buffer Object (PBO)")
- [Frame Buffer Objects (FBOs)](http://www.gamedev.net/page/resources/_/technical/opengl/opengl-frame-buffer-object-101-r2331 "OpenGL Frame Buffer Object 101 - OpenGL - Articles - Articles - GameDev.net")
- [Hardware Geometry Instancing](http://en.wikipedia.org/wiki/Geometry_instancing "Geometry instancing - Wikipedia, the free encyclopedia")
- [GLSL Post Effects](http://en.wikipedia.org/wiki/GLSL "GLSL - Wikipedia, the free encyclopedia")

VAOs are used to render all geometry within the game. FBOs and PBOs are used in conjunction with GLSL to implement various 
post effects. Hardware Instancing is used to create believable “particles effects” (fire, flames, smoke).

The game is still in Alpha, and currently has 4 graphics quality presets: Ultra, High, Medium, Low. The screens below show 
their effect in game and their FPS at 1080p. These are the development machines specs, hardly top of the line yet more
 powerful than your average off the shelf PC.

- 1GB GDDR5 AMD Radeon 5670HD
- 4GB DD3 RAM
- AMD Bulldozer 4100FX 3.6GHz Quad Core
- Tested in Ubuntu 12.04 64bit on JRE 1.7_3 platform

The summary of each spec is shown below
<table>
        <tr>
            <th></th>
            <th>Ultra</th>
            <th>High</th>
            <th>Medium</th>
            <th>Low</th>
        </tr>
        <tr>
            <th>Character Sprites</th>
            <td>High</td>
            <td>High</td>
            <td>Medium</td>
            <td>Low</td>
        </tr>
        <tr>
            <th>Environment Sprites</th>
            <td>High</td>
            <td>Medium</td>
            <td>Medium</td>
            <td>Low</td>
        </tr>
        <tr>
            <th>Particle(Instance) Density</th>
            <td>Ultra</td>
            <td>High</td>
            <td>Medium</td>
            <td>Low</td>
        </tr>
        <tr>
            <th>Post Effects</th>
            <td>On</td>
            <td>On</td>
            <td>Off</td>
            <td>Off</td>
        </tr>
        <tr>
            <th>Depth of Field</th>
            <td>On</td>
            <td>Off</td>
            <td>Off</td>
            <td>Off</td>
        </tr>
        <tr>
            <th>Bloom</th>
            <td>On</td>
            <td>Off</td>
            <td>Off</td>
            <td>Off</td>
        </tr>
        <tr>
            <th>Radial Blur</th>
            <td>On</td>
            <td>On</td>
            <td>Off</td>
            <td>Off</td>
        </tr>
        <tr>
            <th>Sketch Painting</th>
            <td>On</td>
            <td>On</td>
            <td>Off</td>
            <td>Off</td>
        </tr>
</table>


Click on the images to load the full-size 1080p shots.

![[Ultra Quality](http://www.scndgen.com/blog/2012_08_23/scndgen_legacy_29_ultra_s.jpg)](http://www.scndgen.com/blog/2012_08_23/scndgen_legacy_29_ultra.jpg)
*Illustration 1: 1080p :: Ultra Spec :: 29 fps average*
    
![[High Quality](http://www.scndgen.com/blog/2012_08_23/scndgen_legacy_60_high_s.jpg)](http://www.scndgen.com/blog/2012_08_23/scndgen_legacy_60_high.jpg)
*Illustration 2: 1080p :: High Spec :: 60 fps average*
    
![[Medium Quality](http://www.scndgen.com/blog/2012_08_23/scndgen_legacy_82_med_s.jpg)](http://www.scndgen.com/blog/2012_08_23/scndgen_legacy_82_med.jpg)
*Illustration 3: 1080p :: Medium Spec :: 82 fps average*
    
![[Low Quality](http://www.scndgen.com/blog/2012_08_23/scndgen_legacy_88_low_s.jpg)](http://www.scndgen.com/blog/2012_08_23/scndgen_legacy_88_low.jpg)
*Illustration 4: 1080p :: Low Spec :: 88 fps average* 

The table below shows a summary of the results, as well as scores for a resolution of 1024 x 768.
<table>
        <tr>
            <th></th>
            <th>Ultra</th>
            <th>High</th>
            <th>Medium</th>
            <th>Low</th>
        </tr>
        <tr>
            <th>1920x1080</th>
            <td>29</td>
            <td>60</td>
            <td>82</td>
            <td>88</td>
        </tr>
        <tr>
            <th>1024x768</th>
            <td>64</td>
            <td>154</td>
            <td>244</td>
            <td>264</td>
        </tr>
</table>


The Ultra Specs Depth of Field effect hammers performance, though it runs at a solid 60fps at lower resolutions. The games 
performance is dependant on your selected resolution and your GPUs raw horsepower.

I suspect most will play this game at 
1366 x 768 up to 1680 x 1050 at High Settings. Legacy wont be released until 2013 but I don't expect drastic changes to 
made to the rendering tech.

I hope this brief feature gave you an idea of what to expect from the final version of Legacy. If you have any comments, 
queries or suggestions please feel free to comment below. Im particularly interested to hear your opinions on the scaling 
of its graphics presets.

Take care.