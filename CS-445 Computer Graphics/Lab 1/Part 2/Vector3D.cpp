// Vector3D.cpp
//
// modified from
// 	Copyright (C) Kevin Suffern 2000-2007.


#include "Vector3D.h"

// ---------------------------------------------------------- default constructor

Vector3D::Vector3D(void)
	 : x(0.0), y(0.0), z(0.0)
{}

// ---------------------------------------------------------- constructor

Vector3D::Vector3D(double a)
	 : x(a), y(a), z(a)
{}

// ---------------------------------------------------------- constructor

Vector3D::Vector3D(double _x, double _y, double _z)
	: x(_x), y(_y), z(_z)
{}

// ---------------------------------------------------------- copy constructor

Vector3D::Vector3D(const Vector3D& vector)
	: x(vector.x), y(vector.y), z(vector.z)
{}

// ---------------------------------------------------------- destructor

Vector3D::~Vector3D (void) {}

// ---------------------------------------------------------- assignment operator

Vector3D&
Vector3D::operator= (const Vector3D& rhs) {
	if (this == &rhs)
		return (*this);

	x = rhs.x; y = rhs.y; z = rhs.z;

	return (*this);
}

// ----------------------------------------------------------  length
// length of the vector

double
Vector3D::length(void) {
	return (sqrt(x * x + y * y + z * z));
}

// ----------------------------------------------------------  normalize
// converts the vector to a unit vector

void
Vector3D::normalize(void) {
	double length = sqrt(x * x + y * y + z * z);
	x /= length; y /= length; z /= length;
}

// ----------------------------------------------------------  hat
// converts the vector to a unit vector and returns the vector

Vector3D&
Vector3D::hat(void) {
	double length = sqrt(x * x + y * y + z * z);
	x /= length; y /= length; z /= length;
	return (*this);
}

// -------------------------------------------------------- for printing with cout
ostream&
operator<<(ostream& os, const Vector3D& v )
{
    return os <<  "(" << v.x << "," << v.y << ","  << v.z << ")" << std::endl;
}


