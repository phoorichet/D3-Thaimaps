D3-Thaimaps
===========

A D3 map generator exporting in TopoJSON format

= Admin0

== Ablers Projection
1. Set parallels to the proper one by looking the pair of latitude from http://www.mapsofworld.com/. Thailand is aligned between 5'N to 21'N. (http://www.mapsofworld.com/lat_long/thailand-lat-long.html)


2. Center the map to the latitude between the parallels chosen previously. For Thailand maps, the parallels latitude is [5, 21]. Thus, the latitude would be between 5 and 21, which is 13. The center of the map then is [0, 13]. We ignore longitude for now. At this point, you map will be paralleled and centered.

3. Now the map is tilted a bit because of a wrong longitude. No worry, we're gonna fix that! Rotation fixs this issue. So we have to rotate longitude to the center of the map. For Thailand map, we need the center of the map to be [100.52, 13.75] which is somewhere in Bangkok. D3 has three-axis rotation (http://bl.ocks.org/mbostock/4282586), which we have to call. In our case, we want to rotate longitude. Therefore, only the x axis will be changed. Thailand is located in the eastern side of the world map. We thus have to rotate from east to west so that the center of the map is correctly displayed. This results in [-100.52, 0] as the parameter in .rotate().

4. The effective settings can be check as followed:
* paralles must be in [5, 21]
* center latitude must be in between [5, 21]. We choose [0, 13.7].
* rotate the map to fix longitude. We got [-100.52, 0].
* center and rotation result in [0, 13.7] + [-100.52, 0] = [-100.52, 13.7], which is the center of the map we desire.

5.We now have the Thailand map center in our code. We can change scale and translate the map as we want.

---
