# movie of flow around obstacle

from __future__ import print_function, absolute_import
from builtins import range

d = dump("dump.flow")
d.map(1, "id", 2, "type", 3, "x", 4, "y", 5, "z", 6, "vx", 7, "vy")
d.set("$ke = sqrt($vx*$vx + $vy*$vy)")
d.spread("vx", 100, "color")
d.atype = "color"

r = raster(d)
r.acol(list(range(100)),
       ["red",
        "red",
        "red",
        "red",
        "yellow",
        "green",
        "blue",
        "purple",
        "purple",
        "purple",
        "purple"])
r.arad(list(range(100)), 0.5)
r.rotate(0, -90)
r.zoom(1.5)
r.file = "flow"

r.all()
