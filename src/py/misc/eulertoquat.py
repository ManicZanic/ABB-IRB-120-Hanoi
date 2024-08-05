#!/usr/bin/python

from scipy.spatial.transform import Rotation
import numpy as np

x=input("X angle: ")
y=input("Y angle: ")
z=input("Z angle: ")


rot = Rotation.from_euler('xyz', [x,y,z], degrees=True)

rot_quot=rot.as_quat()
print (rot_quot)

