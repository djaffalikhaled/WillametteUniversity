// Cylinder.cpp

#include "Cylinder.h"

extern const double kEpsilon;
// ---------------------------------------------------------------- default constructor

Cylinder::Cylinder(void)
    : 	GeometricObject(),
        center(0.0),
        radius(1.0),
        height(2.0)
{}

// ---------------------------------------------------------------- constructor

Cylinder::Cylinder(Vector3D c, double r, double h)
    : 	GeometricObject(),
        center(c),
        radius(r),
        height(h)
{}

// ---------------------------------------------------------------- clone

GeometricObject*
Cylinder::clone(void) const
{
    return (new Cylinder(*this));
}

// ---------------------------------------------------------------- copy constructor

Cylinder::Cylinder (const Cylinder& cylinder)
    : 	GeometricObject(cylinder),
        center(cylinder.center),
        radius(cylinder.radius),
        height(cylinder.height)
{}

// ---------------------------------------------------------------- assignment operator

Cylinder&
Cylinder::operator= (const Cylinder& rhs)
{
    if (this == &rhs)
        return (*this);

    GeometricObject::operator= (rhs);

    center 	= rhs.center;
    radius	= rhs.radius;
    height  = rhs.height;

    return (*this);
}

// ---------------------------------------------------------------- destructor

Cylinder::~Cylinder(void) {}

//---------------------------------------------------------------- hit

ShadeRec
Cylinder::hit(const Ray& ray) const
{
    double 		t;
    Vector3D	myO 	     (ray.o.x, 0,  ray.o.z);
    Vector3D 	myD	     (ray.d.x, 0, ray.d.z);
    Vector3D 	myCenter 	 (center.x, 0, center.z);
    Vector3D 	temp 	=	 myO - myCenter;
    double 		a 		= myD * myD;
    double 		b 		= 2.0 * temp * myD;
    double 		c 		= temp * temp - radius * radius;
    double 		disc	= b * b - 4.0 * a * c;

    ShadeRec sr;
    sr.hit_an_object = false;

    if (disc >= 0.0)
    {
        double e = sqrt(disc);
        double denom = 2.0 * a;
        t = (-b - e) / denom;    // smaller root

        if (t > kEpsilon)
        {
            sr.t = t;
            sr.local_hit_point = ray.o + t * ray.d;
            Vector3D diff_hit_point (sr.local_hit_point.x, 0, sr.local_hit_point.z);
            sr.normal = diff_hit_point - diffCenter;
            if(sr.local_hit_point.y <(radius*height) && sr.local_hit_point.y > (-radius*height)) // -radius*height
            {
                sr.hit_an_object = true;
                sr.material_ptr = material_ptr;
                return sr;
            }
        }

        t = (-b + e) / denom;    // larger root

        if (t > kEpsilon)
        {
            sr.t = t;
            sr.local_hit_point = ray.o + t * ray.d;
            Vector3D diff_hit_point (sr.local_hit_point.x, 0, sr.local_hit_point.z);
            sr.normal = diff_hit_point - diffCenter;
            if(sr.local_hit_point.y <(radius*height) && sr.local_hit_point.y > (-radius*height))
            {
                sr.hit_an_object = true;
                sr.material_ptr = material_ptr;
                return sr;
            }
        }
    }

    return sr;
}
