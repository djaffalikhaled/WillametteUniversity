#ifndef CAMERA_H
#define CAMERA_H

#include "Angel.h"

class Camera
{
public:
    Camera();
    virtual ~Camera();

    // Camera projection transformation parameters
    GLfloat  fovy;      // Field-of-view in Y direction angle (in degrees)
    GLfloat  aspect;    // Viewport aspect ratio
    GLfloat  zNear;     // near plane
    GLfloat  zFar;       // far plane

// Camera location and orientation parameters
    vec4 eye;  // camera location
    vec4 at;   //  camera look-at point
    vec4 VUP;  // used as starting value for setting uvn

    mat4 calcPerspective();
    mat4 calcLookAt();
protected:
private:
};

#endif // CAMERA_H
