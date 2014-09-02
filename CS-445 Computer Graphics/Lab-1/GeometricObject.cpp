//  GeometricObject.cpp
// 	Copyright (C) Kevin Suffern 2000-2007. Modified by G. Orr
//	This C++ code is for non-commercial purposes only.
//	This C++ code is licensed under the GNU General Public License Version 2.
//	See the file COPYING.txt for the full license.

#include "GeometricObject.h"

// ---------------------------------------------------------------------- default constructor

GeometricObject::GeometricObject(void)
	: 	material_ptr(NULL)//,
{}

// ---------------------------------------------------------------------- copy constructor

GeometricObject::GeometricObject (const GeometricObject& object)
{
    material_ptr = NULL;
}


// ---------------------------------------------------------------------- assignment operator

GeometricObject&
GeometricObject::operator= (const GeometricObject& rhs) {
	if (this == &rhs)
		return (*this);

	if (material_ptr) {
		delete material_ptr;
		material_ptr = NULL;
	}

	if (rhs.material_ptr)
		material_ptr = rhs.material_ptr;

	return (*this);
}

// ---------------------------------------------------------------------- destructor

GeometricObject::~GeometricObject (void) {
	if (material_ptr) {
		delete material_ptr;
		material_ptr = NULL;
	}
}

// ----------------------------------------------------------------------- set_material

void
GeometricObject::set_material(Material* mPtr) {
	material_ptr = mPtr;
}


// ----------------------------------------------------------------------- get_material

Material*
GeometricObject::get_material(void) const {
	return (material_ptr);
}


