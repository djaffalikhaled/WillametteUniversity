#ifndef CYLINDER_H
#define CYLINDER_H

#include "Angel.h"
#include "GeometryBase.h"

class Cylinder: public GeometryBase
{
    public:
        Cylinder(int numSections=8);
        int height;
        double angle;
        int radius;

    protected:
    private:
        void cyl(int &index, vec4 v1, vec4 v2, vec4 v3, vec4 v4, vec4 col, vec4 norm);
};

#endif // CYLINDER_H
