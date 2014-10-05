#ifndef CONE_H
#define CONE_H

#include "Angel.h"
#include "GeometryBase.h"

class Cone: public GeometryBase
{
    public:
        Cone(int numSections=8);
        int height;
        double angle;
        int radius;

    protected:
    private:
        void tri(int &index, vec4 center, vec4 v1, vec4 v2, vec4 col, vec4 norm);
};

#endif // DISK_H
