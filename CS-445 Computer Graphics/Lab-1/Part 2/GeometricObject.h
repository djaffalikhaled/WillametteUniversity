// GeometricObhect.h
// Modified from
// 	Copyright (C) Kevin Suffern 2000-2007. Modified by G. Orr

#ifndef __GEOMETRIC_OBJECT__
#define __GEOMETRIC_OBJECT__

#include <math.h>
#include "Constants.h"
#include "RGBColor.h"
#include "Vector3D.h"
#include "Ray.h"
#include "ShadeRec.h"
#include "Material.h"

class Material;

//----------------------------------------------------------------------------------------------------- class GeometricObject

class GeometricObject {
	public:
		GeometricObject(void);
		GeometricObject(const GeometricObject& object);

		virtual GeometricObject* clone(void) const = 0;
		virtual ~GeometricObject(void);
		virtual ShadeRec hit(const Ray& ray) const = 0;
		virtual void set_material(Material* mPtr);
		Material* get_material(void) const;
	public:
        Material*   material_ptr;
        GeometricObject& operator= (const GeometricObject& rhs);
		RGBColor   			color;				// only used before Materials and Lights are implemented
};

#endif
