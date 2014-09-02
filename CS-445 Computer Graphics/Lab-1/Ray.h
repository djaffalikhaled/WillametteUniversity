// Ray.h
// Stores a ray represented by the start point and a direction

// 	Copyright (C) Kevin Suffern 2000-2007.
//	This C++ code is for non-commercial purposes only.
//	This C++ code is licensed under the GNU General Public License Version 2.
//	See the file COPYING.txt for the full license.

#ifndef __RAY__
#define __RAY__

#include "Vector3D.h"

class Ray {
	public:
		Vector3D		o;  	// origin
		Vector3D		d; 		// direction
		Ray(void);
		Ray(const Vector3D& origin, const Vector3D& dir);
		Ray(const Ray& ray);
		Ray& operator= (const Ray& rhs);
		~Ray(void);
};

#endif

