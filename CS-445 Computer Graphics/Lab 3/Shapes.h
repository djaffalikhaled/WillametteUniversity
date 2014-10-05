#ifndef SHAPES_H
#define SHAPES_H

#include "Cube.h"
#include "WiredCube.h"
#include "Disk.h"
#include "WiredDisk.h"
#include "Cylinder.h"
#include "WiredCylinder.h"
#include "Cone.h"
#include "WiredCone.h"

class Shapes
{
public:
    Shapes();
    virtual ~Shapes();

    Cube myCube;
    WiredCube myWiredCube;
    Cylinder myCylinder;
    WiredCylinder myWiredCylinder;
    Disk myDisk;
    WiredDisk myWiredDisk;
    Cone myCone;
    WiredCone myWiredCone;

    void createBuffers(GLint program);

    void drawCube(vec4 color=vec4(0,0,0,1));
    void drawCylinder(vec4 color=vec4(0,0,0,1));
    void drawDisk(vec4 color=vec4(0,0,0,1));
    void drawCone(vec4 color=vec4(0,0,0,1));


protected:
private:
};

#endif // SHAPES_H
