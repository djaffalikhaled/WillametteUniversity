#ifndef WIREDCYLINDER_H
#define WIREDCYLINDER_H

#include "Angel.h"
#include "WiredGeometryBase.h"

class WiredCylinder: public WiredGeometryBase
{
    public:
        WiredCylinder(int numSections=8);
        int height;
        double angle;
        int radius;

    protected:
    private:
        void wiredcyl(int &index, vec4 v1, vec4 v2, vec4 v3, vec4 v4, vec4 col);
};

#endif // CYLINDER_H
