#ifndef DISK_H
#define DISK_H

#include "Angel.h"
#include "GeometryBase.h"

class Disk: public GeometryBase
{
    public:
        Disk(int numSections=8);
        int radius;
        int height;
        double angle;

    protected:
    private:
        void tri(int &index, vec4 center, vec4 v1, vec4 v2, vec4 col, vec4 norm);
};

#endif // DISK_H
