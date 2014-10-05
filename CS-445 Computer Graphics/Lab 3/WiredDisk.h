#ifndef WIREDDISK_H
#define WIREDDISK_H

#include "Angel.h"
#include "WiredGeometryBase.h"

class WiredDisk: public WiredGeometryBase
{
    public:
        WiredDisk(int numSections=8);
        int radius;
        int height;
        double angle;

    protected:
    private:
        void tri(int &index, vec4 center, vec4 v1, vec4 v2, vec4 col);
};

#endif // WIREDDISK_H
