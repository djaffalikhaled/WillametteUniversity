#include "Camera.h"
#include "Angel.h"

//---------------------------------------------------------------------------- constructor

Camera::Camera() :  fovy(45.0), aspect(1), zNear(0.5), zFar(100.0), eye(vec4( 0.0 ,0.0, 4.0 ,1.0)), at(vec4( 0.0 ,0.0, 0.0 ,0.0)),
                     VUP(vec4(0,1,0,0))
{
}

//---------------------------------------------------------------------------- destructor
Camera::~Camera()
{}

//---------------------------------------------------------------------------- calcPerspective
// Computes the perpective matrix transform based on camera characteristics.
mat4 Camera::calcPerspective() {
   return Perspective( fovy, aspect, zNear, zFar );
}

// Computes the perpective matrix transform based on camera characteristics.
mat4 Camera::calcLookAt() {
   return LookAt( eye, at, VUP );
}




