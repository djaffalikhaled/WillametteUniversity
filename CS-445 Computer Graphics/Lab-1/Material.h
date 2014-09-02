// Material.h
// Stores the surface properties of an object

#ifndef __MATERIAL__
#define __MATERIAL__

#include "RGBColor.h"

class ShadeRec;

class Material {
    public:
		RGBColor ca;  // ambient color
	public:
		Material(void);
		Material(const Material& material);
		~Material(void);
		Material& operator= (const Material& rhs);
		void setAmbColor(float r, float g, float b);
		void setAmbColor(const RGBColor& c);
		RGBColor getAmbColor() const;
};

// -------------------------------------------------------------------------------

inline void
Material::setAmbColor(float r, float g, float b) {
	ca.r = r;  ca.g = g;  ca.b = b;
}

inline void
Material::setAmbColor(const RGBColor& c) {
    ca = c;
}

inline RGBColor
Material::getAmbColor() const {
	return ca;
}

#endif
