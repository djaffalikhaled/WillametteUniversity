// Cylinder.h

#ifndef CYLINDER
#define CYLINDER

// This file contains the declaration of the class Cylinder

#include "GeometricObject.h"
#include "math.h"

//-------------------------------------------------------------------------------- class Cylinder
// Inherits from GeometricObject

class Cylinder: public GeometricObject {

	public:
		Cylinder(void);   									// Default constructor
		Cylinder(Vector3D center, double r, double h);					// Constructor
		Cylinder(const Cylinder& cylinder); 						// Copy constructor
		virtual GeometricObject* clone(void) const;			// Virtual copy constructor
		virtual	~Cylinder(void);					            // Destructor
		Cylinder& operator= (const Cylinder& cylinder);			// assignment operator
		void set_center(const Vector3D& c);
		void set_height(const double h);
		void set_center(const double x, const double y, const double z);
		void set_radius(const double r);
		virtual ShadeRec hit(const Ray& ray) const;         // calc hit point with ray

	private:
		Vector3D 	center;   			// center coordinates as a point
		double 		radius;				// the radius
		double      height;             // the height
};

inline void
Cylinder::set_center(const Vector3D& c) {
	center = c;
}

inline void
Cylinder::set_center(const double x, const double y, const double z) {
	center.x = x;
	center.y = y;
	center.z = z;
}

inline void
Cylinder::set_height(const double h){
    height = h;
}


inline void
Cylinder::set_radius(const double r) {
	radius = r;
}

#endif
