// A class for storing primitive objects: cylinder, cube, disk, Steiner surface

#include "Shapes.h"
#include "Globals.h"

 Shapes::Shapes()
      // :  mySteiner(40,40),myWireSteiner(20,20)
{}

Shapes::~Shapes()
{}

void
Shapes::createBuffers(GLint program) {

    myCube.createBuffers(program);
    myWiredCube.createBuffers(program);

    myDisk.createBuffers(program);
    myWiredDisk.createBuffers(program);

    myCylinder.createBuffers(program);
    myWiredCylinder.createBuffers(program);

    myCone.createBuffers(program);
    myWiredCone.createBuffers(program);
}
// draws solid cube and wire cube together. The wire color is always black
void
Shapes::drawCube(vec4 color)
{
    myCube.draw();
    myWiredCube.draw();
}

// draws solid Cylinder and wire Cylinder together. The wire color is always black
void
Shapes::drawCylinder(vec4 color)
{
    myCylinder.draw();
    myWiredCylinder.draw();
}

// draws solid Disk and wire Disk together. The wire color is always black
void
Shapes::drawDisk(vec4 color)
{
    myDisk.draw();
    myWiredDisk.draw();
}

void
Shapes::drawCone(vec4 color)
{
    myCone.draw();
    myWiredCone.draw();
}
