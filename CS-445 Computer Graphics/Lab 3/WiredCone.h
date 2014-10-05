#ifndef WIREDCONE_H
#define WIREDCONE_H

#include "Angel.h"
#include "WiredGeometryBase.h"

class WiredCone: public WiredGeometryBase
{
    public:
        WiredCone(int numSections=8);
        int height;
        double angle;
        int radius;

    protected:
    private:
        void tri(int &index, vec4 center, vec4 v1, vec4 v2, vec4 col);
};

#endif // DISK_H
