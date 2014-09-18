//  ShaderRec.cpp
// 	This code is modified from
// 	Copyright (C) Kevin Suffern 2000-2007.

// The ShaderRec class is a convience class for carrying around
//  all of the data associated with a hit-point.

#ifndef __SHADE_REC__
#define __SHADE_REC__

#include "Ray.h"
#include "Material.h"
#include "RGBColor.h"

class ShadeRec {
	public:

		bool				hit_an_object;		// did the ray hit an object?
		Material* 			material_ptr;		// pointer to the object's material at hit point
		Vector3D			local_hit_point;	// world coordinates of hit point on object (used for texture transformations)
		Vector3D			normal;				// normal at hit point
		Ray					ray;				// the ray involved with the hit. required for specular highlights and area lights
		double				t;					// ray parameter so one knows how far the hit is from the camera
        RGBColor			color;				// used temporarily. Once a material is added, this is not used.

        ShadeRec();	                            // default constructor
		ShadeRec(const ShadeRec& sr);			// copy constructor
		~ShadeRec(void);						// destructor
		ShadeRec& operator= (const ShadeRec& rhs); // assignment operator
};

#endif


