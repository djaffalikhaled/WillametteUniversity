#ifndef POINTLIGHT_H
#define POINTLIGHT_H

#include "RGBColor.h"
#include "Vector3D.h"
class PointLight
{
    public:
        RGBColor color;
        Vector3D location;
        float intensity;

        PointLight();
        virtual ~PointLight();

        PointLight& operator= (const PointLight& pl);
        void set_color(float nr, float ng, float nb);
        void set_location(float nx, float ny, float nz);
        void set_intensity(float ints);
    protected:
    private:
};

inline void
PointLight::set_color(float nr, float ng, float nb)
{
    color.r = nr;
    color.g = ng;
    color.b = nb;
}

inline void
PointLight::set_location(float nx, float ny, float nz)
{
    location.x = nx;
    location.y = ny;
    location.z = nz;
}

inline void
PointLight::set_intensity(float ints)
{
    intensity = ints;
}

#endif // POINTLIGHT_H
