// Vector3D.h
//
// modified from
// 	Copyright (C) Kevin Suffern 2000-2007.

#ifndef __VECTOR_3D__
#define __VECTOR_3D__

#include <math.h>    // for sqrt

//----------------------------------------- class Vector3D
class Vector3D {
	public:
		double	x, y, z;
	public:
		Vector3D(void);											// default constructor
		Vector3D(double a);										// constructor
		Vector3D(double _x, double _y, double _z);				// constructor
		Vector3D(const Vector3D& v);							// copy constructor
		~Vector3D (void);										// destructor
		Vector3D& operator= (const Vector3D& rhs);				// assignment operator
		Vector3D	operator- (void) const;						// unary minus
		double length(void);					                // length
		double len_squared(void);							    // square of the length
		Vector3D operator* (const double a) const;				// multiplication by a double on the right
		Vector3D operator/ (const double a) const;				// division by a double
		Vector3D operator+ (const Vector3D& v) const;			// addition
		Vector3D& operator+= (const Vector3D& v);				// compound addition
		Vector3D operator- (const Vector3D& v) const;			// subtraction
		double operator* (const Vector3D& b) const;             // dot product
		Vector3D operator^ (const Vector3D& v) const;			// cross product
		void normalize(void);								    // convert vector to a unit vector
		Vector3D& hat(void);									// return a unit vector, and normalize the vector
};


// inlined member functions
// ------------------------------------------------------------------------ unary minus
// this does not change the current vector
// this allows ShadeRec objects to be declared as constant arguments in many shading
// functions that reverse the direction of a ray that's stored in the ShadeRec object

inline Vector3D
Vector3D::operator- (void) const {
	return (Vector3D(-x, -y, -z));
}


// ---------------------------------------------------------------------  len_squared
// the square of the length

inline double
Vector3D::len_squared(void) {
	return (x * x + y * y + z * z);
}

// ----------------------------------------------------------------------- operator*
// multiplication by a double on the right

inline Vector3D
Vector3D::operator* (const double a) const {
	return (Vector3D(x*a, y*a, z*a));
}

// ----------------------------------------------------------------------- operator/
// division by a double

inline Vector3D
Vector3D::operator/ (const double a) const {
	return (Vector3D(x/a, y/a, z/a));
}

// ----------------------------------------------------------------------- operator+
// addition

inline Vector3D
Vector3D::operator+ (const Vector3D& v) const {
	return (Vector3D(x + v.x, y + v.y, z + v.z));
}

// ----------------------------------------------------------------------- operator-
// subtraction

inline Vector3D
Vector3D::operator- (const Vector3D& v) const {
	return (Vector3D(x - v.x, y - v.y, z - v.z));
}

// ----------------------------------------------------------------------- operator*
// dot product

inline double
Vector3D::operator* (const Vector3D& b) const {
	return (x*b.x+y*b.y+z*b.z);
}

// ----------------------------------------------------------------------- operator^
// cross product

inline Vector3D
Vector3D::operator^ (const Vector3D& v) const {
	return Vector3D(((y*v.z)-(v.y*z)),
					((z*v.x)-(v.z*x)),
					((x*v.y)-(v.x*y)));
}

// ---------------------------------------------------------------------  operator+=
// compound addition

inline Vector3D&
Vector3D::operator+= (const Vector3D& v) {
	x += v.x; y += v.y; z += v.z;
	return (*this);
}

// inlined non-member function
// ----------------------------------------------------------------------- operator*
// multiplication by a double on the left

Vector3D 											// prototype
operator* (const double a, const Vector3D& v);

inline Vector3D
operator* (const double a, const Vector3D& v) {
	return (Vector3D(a * v.x, a * v.y, a * v.z));
}

#endif



