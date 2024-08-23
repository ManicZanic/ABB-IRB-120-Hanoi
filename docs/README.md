# Tower of Hanoi with ABB IRB 120
Re: Chris Boden @Physicsduck


## Project Description
- Get “Topsy” / “Turvy”, two ABB IRB 120 M2004 robots working and solve the Tower of Hanoi problem.\
- The problem involves moving 10 rings from one pole to another, one at a time.\
- The smallest ring is ~¾” in diameter. 
- The largest ring is ~1 ⅞”  in diameter. 
- The rings are all ¼” thick.
- The diameter of the posts is ~¼”. 
- Post A is ~2 ⅜” from Post B on center. 
- Post B is ~3 7/16” from Post C on center. 

## Project Documentation
### Robot Documentation
RobotStudio Download : https://campaign-ra.abb.com/l/961042/2023-07-28/5qrllq \
ABB to ROS Drivers : https://github.com/ros-industrial/abb_driver (need legacy 5.13 drivers) \
Product Manual : https://library.e.abb.com/public/e6617595547fc6c2c1257cc5004451bd/Operating%20manual_Trouble%20shooting_3HAC020738-001_revK_en.pdf 
ABB Library : https://library.abb.com/r?cid=9AAC190651
### Code Documentation
RobotStudio Docs : https://library.e.abb.com/public/244a8a5c10ef8875c1257b4b0052193c/3HAC032104-001_revD_en.pdf \
RobotStudio API Reference : https://developercenter.robotstudio.com/api/robotstudio/api/index.html \
ROS Documentation : https://docs.ros.org/ \
Jazzy Jalisco (Latest ROS with LTS Support) : https://docs.ros.org/en/jazzy/ \
Github Markdown : README.md


## Algorithms, Programs & Models
Tower of Hanoi \
Hanoi Tower Dimensions \
Spacing Rod to Rod (~50-55mm center) \
Smallest Ring Width (~20mm) \
Largest Ring Width (~50mm) \
Ring Height (~7.5mm) \

### Tower of Hanoi Algorithm Explanation:
- https://youtu.be/2SUvWfNJSsM?si=iz1iWLj1UrOylzw0 
- https://www.geeksforgeeks.org/c-program-for-tower-of-hanoi/ 
- https://www.geeksforgeeks.org/python-program-for-tower-of-hanoi/
- https://www.sanfoundry.com/csharp-program-tower-of-hanoi/ 


### Hanoi Algorithm Python Code
Requires Python 3.10+, run by executing python hanoi_algorithm.py

```
hanoi_algorithm.py
rod1 = [4, 3, 2, 1]
rod2 = []
rod3 = []

def move_disk(src: int, tgt: int):
    if src == 1:
        disk = rod1.pop()
    elif src == 2:
        disk = rod2.pop()
    else:
        disk = rod3.pop()

    if tgt == 1:
        rod1.append(disk)
    elif tgt == 2:
        rod2.append(disk)
    else:
        rod3.append(disk)


def print_rod_vert():
    maxs = max(len(rod1), len(rod2), len(rod3))

    for i in range(maxs)[::-1]:
        if i < len(rod1):
            print(rod1[i], end=" ")
        else:
            print(" ", end=" ")
        if i < len(rod2):
            print(rod2[i], end=" ")
        else:
            print(" ", end=" ")
        if i < len(rod3):
            print(rod3[i], end=" ")
        else:
            print(" ", end=" ")
        print()
    print()

def hanoi(level: int, src: int, tgt: int, aux: int):
    if level == 1:
        move_disk(src, tgt)
        print_rod_vert()
        return
    hanoi(level - 1, src, aux, tgt)
    move_disk(src, tgt)
    print_rod_vert()
    hanoi(level - 1, aux, tgt, src)

def main():
    print_rod_vert()
    hanoi(4, 1, 3, 2)

main()
```

Facial Tracking (Machine Learning) \
OpenFace Facial Tracking : https://cmusatyalab.github.io/openface/ \
DeepFace Deep Learning Algorithm : https://github.com/serengil/deepface \
List of awesome machine learning libraries : https://github.com/josephmisiti/awesome-machine-learning?tab=readme-ov-file#python-computer-vision  


### 3D Models
- Motor Specifications - https://statics3.seeedstudio.com/images/opl/datasheet/316030062.pdf 
- 3D Gripper Model V1 (Developed by Leonhard)  - https://discord.com/channels/535160602608533525/653087890599051276/1268969889977073724 
- 3D Gripper Model V2 (Developed by Leonhard)  - https://discord.com/channels/535160602608533525/653087890599051276/1269336419298447481 

