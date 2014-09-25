#include "PointLight.h"

// Constructor
PointLight::PointLight(void)

    : color(1,1,1), location(0,0,0), intensity(1)
{}


//-------- Destructor
PointLight::~PointLight(void)
{}



// --------- Assignment operator
PointLight&
PointLight::operator= (const PointLight& pl){
    if (this == &pl)
        return (*this);
    color = pl.color;
    location = pl.location;
    intensity = pl.intensity;
    return (*this);
}

//----------Setters
