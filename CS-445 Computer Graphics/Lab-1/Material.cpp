// Material.cpp
// Stores the surface properties of an object

#include "Material.h"

// ---------------------------------------------------------------- default constructor

Material::Material(void)
    : ca(1,1,1)
{}

// ---------------------------------------------------------------- copy constructor

Material::Material(const Material& m) {}

// ---------------------------------------------------------------- assignment operator

Material&
Material::operator= (const Material& rhs) {
	if (this == &rhs)
		return (*this);
    ca = rhs.ca;

	return (*this);
}


// ---------------------------------------------------------------- destructor

Material::~Material(void)
{}



