// Ray.cpp
// Stores a ray represented by the start point and a direction

// Modified from
// 	Copyright (C) Kevin Suffern 2000-2007.

#include "Ray.h"

// ---------------------------------------------------------------- default constructor

Ray::Ray (void)
	: 	o(0.0),
		d(0.0, 0.0, 1.0)
{}

// ---------------------------------------------------------------- constructor

Ray::Ray (const Vector3D& origin, const Vector3D& dir)
	: 	o(origin),
		d(dir)
{}

// ---------------------------------------------------------------- copy constructor

Ray::Ray (const Ray& ray)
	: 	o(ray.o),
		d(ray.d)
{}

// ---------------------------------------------------------------- assignment operator

Ray&
Ray::operator= (const Ray& rhs) {

	if (this == &rhs)
		return (*this);

	o = rhs.o;
	d = rhs.d;

	return (*this);
}

// ---------------------------------------------------------------- destructor

Ray::~Ray (void) {}




