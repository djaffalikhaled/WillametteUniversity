//  ShaderRec.cpp
// 	This code is modified from
//  Copyright (C) Kevin Suffern 2000-2007. Modiefied by G. Orr

// The ShaderRec class is a convenience class for carrying around
//  all of the data associated with a hit-point between a ray and object.

#include "Constants.h"
#include "ShadeRec.h"

// ------------------------------------------------------------------ default constructor

ShadeRec::ShadeRec()  //  (World& wr)
	: 	hit_an_object(false),
		material_ptr(NULL),
		local_hit_point(),
		normal(),
		ray(),
		t(0.0)
{
}

// ------------------------------------------------------------------ copy constructor

ShadeRec::ShadeRec(const ShadeRec& sr)
	: 	hit_an_object(sr.hit_an_object),
		material_ptr(sr.material_ptr),
		local_hit_point(sr.local_hit_point),
		normal(sr.normal),
		ray(sr.ray),
		t(sr.t)
{}


// ------------------------------------------------------------------ destructor

ShadeRec::~ShadeRec(void) {
}

// ---------------------------------------------------------------- assignment operator

ShadeRec&
ShadeRec::operator= (const ShadeRec& rhs)	{

	if (this == &rhs)
		return (*this);

	hit_an_object = rhs.hit_an_object;
	material_ptr = rhs.material_ptr;
	local_hit_point = rhs.local_hit_point;
	normal = rhs.normal;
	ray = rhs.ray;
	t = rhs.t;
	color = rhs.color;

	return (*this);
}
