#not fast who cares
import os
import std/sequtils
var data =  newSeq[int]()
var width = 0
var startpos = 0
var endpos = 0
for i in countup(0, paramStr(1).len-1):
    if ord(paramStr(1)[i]) == 32:
        if width == 0:
            width = i
    elif ord(paramStr(1)[i]) == 69:
        endpos = data.len
        data.add(97)
    elif ord(paramStr(1)[i]) == 83:
        startpos = data.len
        data.add(122)
    else: data.add(ord(paramStr(1)[i]))
var outp = data.len
for j in countup(0,data.len div width - 1):
    var points = newSeq[int]()
    points.add(j * width)
    var done = false
    var steps = 0
    while not done:
        steps = steps + 1
        var oglength = points.len 
        for i in countup(0, oglength-1):
            if points[0] == endpos:
                done = true
                echo points
            if (points[0] - width) > 0:
                if (data[points[0] - width] - 1) <= data[points[0]]:
                    points.add(points[0] - width)
            if (points[0] + width) < data.len:
                if (data[points[0] + width] - 1) <= data[points[0]]:
                    points.add(points[0] + width)
            if (points[0] mod width) != 0:
                if (data[points[0] - 1] - 1) <= data[points[0]]:
                    points.add(points[0] - 1)
            if (points[0] mod width) !=  width - 1:
                if (data[points[0] + 1] - 1) <= data[points[0]]:
                    points.add(points[0] + 1)
            points.delete(0)
        points = deduplicate(points)
    outp = min(outp, steps - 1)
    echo endpos
echo "~"
echo outp
