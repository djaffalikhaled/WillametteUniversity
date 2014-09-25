// Material.h
// Stores the surface properties of an object

#ifndef __MATERIAL__
#define __MATERIAL__

#include "RGBColor.h"

class ShadeRec;

class Material {
    public:
		RGBColor ca;  // ambient color
		RGBColor cd;  // color Diffuse
		RGBColor cs;  // color Specular
		float ka = 0.2; // ambient
		float kd = 0.6; // diffuse
		float ks = 0.4; // specular
		float kr = 0.3; //Part 3
		float spec =20; // specular component

	public:
		Material(void);
		Material(const Material& material);
		~Material(void);
		Material& operator= (const Material& rhs);
		void setAmbColor(float r, float g, float b);
		void setAmbColor(const RGBColor& c);
		RGBColor getAmbColor() const;
		void setAllColor(float r, float b, float g);
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
inline void
Material::setAllColor(float r, float g, float b){
    ca.r = r, ca.g = g, ca.b = b;
    cd.r = r, cd.g = g, cd.b = b;
    cs.r = r, cs.g = g, cs.b = b;

}


#endif
