// Sphere.h

#ifndef __SPHERE__
#define __SPHERE__

// This file contains the declaration of the class Sphere

#include "GeometricObject.h"
#include "math.h"

//-------------------------------------------------------------------------------- class Sphere
// Inherits from GeometricObject

class Sphere: public GeometricObject {

	public:
		Sphere(void);   									// Default constructor
		Sphere(Vector3D center, double r);					// Constructor
		Sphere(const Sphere& sphere); 						// Copy constructor
		virtual GeometricObject* clone(void) const;			// Virtual copy constructor
		virtual	~Sphere(void);					            // Destructor
		Sphere& operator= (const Sphere& sphere);			// assignment operator
		void set_center(const Vector3D& c);
		void set_center(const double x, const double y, const double z);
		void set_radius(const double r);
		virtual ShadeRec hit(const Ray& ray) const;         // calc hit point with ray

	private:
		Vector3D 	center;   			// center coordinates as a point
		double 		radius;				// the radius
};

inline void
Sphere::set_center(const Vector3D& c) {
	center = c;
}

inline void
Sphere::set_center(const double x, const double y, const double z) {
	center.x = x;
	center.y = y;
	center.z = z;
}

inline void
Sphere::set_radius(const double r) {
	radius = r;
}

#endif
