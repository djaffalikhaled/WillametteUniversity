#include "Plane.h"

Plane::Plane(void)
    :   GeometricObject(),
        point(0,-1,0),
        normal(0,1,0)
{}

// ---------------------------------------------------------------- constructor

Plane::Plane(Vector3D p, Vector3D n)
	: 	GeometricObject(),
		normal(n),
		point(p)
{}

// ---------------------------------------------------------------- clone

GeometricObject*
Plane::clone(void) const {
	return (new Plane(*this));
}

// ---------------------------------------------------------------- copy constructor

Plane::Plane (const Plane& plane)
	: 	GeometricObject(plane),
		normal(plane.normal),
		point(plane.point)
{}

// ---------------------------------------------------------------- assignment operator

Plane&
Plane::operator= (const Plane& rhs)
{
	if (this == &rhs)
		return (*this);

	GeometricObject::operator= (rhs);

	normal 	= rhs.normal;
	point	= rhs.point;

	return (*this);
}

// ---------------------------------------------------------------- destructor

Plane::~Plane(void) {}

//---------------------------------------------------------------- hit

ShadeRec
Plane::hit(const Ray& ray) const {
	double 		t;
	double      top;
	double      bottom;
	Vector3D    Vector = ray.o;
	double      length = Vector.length();

	top = (point - ray.o)*normal;
	bottom = ray.d*normal;

	ShadeRec sr;
	sr.hit_an_object = false;

	if(bottom != 0)
    {
        t=top/bottom;
        if (t > kEpsilon)
        {
          sr.hit_an_object = true;
            sr.t = t;
            sr.normal = normal;
            sr.local_hit_point = ray.o + t * ray.d;
            sr.material_ptr = material_ptr;
        }

    }

	return sr;
}

