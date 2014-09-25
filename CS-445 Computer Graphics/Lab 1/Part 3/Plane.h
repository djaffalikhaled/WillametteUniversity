#ifndef PLANE_H
#define PLANE_H
// This file contains the declaration of the class Sphere

#include "GeometricObject.h"
#include "math.h"

//-------------------------------------------------------------------------------- class Sphere
// Inherits from GeometricObject

class Plane: public GeometricObject {

	public:
		Plane(void);   									// Default constructor
		Plane(Vector3D p, Vector3D n);					// Constructor
		Plane(const Plane& plane); 						// Copy constructor
		virtual GeometricObject* clone(void) const;			// Virtual copy constructor
		virtual	~Plane(void);					            // Destructor
		Plane& operator= (const Plane& plane);			// assignment operator
		void set_normal(const double x, const double y, const double z);
		void set_point(const double x, const double y, const double z);
		virtual ShadeRec hit(const Ray& ray) const;         // calc hit point with ray

	private:
		Vector3D 	normal;   			// normal
		Vector3D    point;				// the point
};

inline void
Plane::set_normal(const double x, const double y, const double z) {
	normal.x = x;
	normal.y = y;
	normal.z = z;
}

inline void
Plane::set_point(const double x, const double y, const double z) {
	point.x = x;
	point.y = y;
	point.z = z;
}

#endif
