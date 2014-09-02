#ifndef CAMERA_H
#define CAMERA_H

#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif

#include "Vector3D.h"
#include "Ray.h"

class Camera
{
    public:
        Camera();
        Camera(int xr, int yr);
        ~Camera();
        Camera(const Camera& other);  // copy constructor
        Camera& operator=(const Camera& other);  // Assignment operator
        void calcUVN(const Vector3D &VPN, const Vector3D &VUP); // calc u, v, n based on VPN and VUP
		Ray  pixRay(int i, int j) const;  // calc ray that goes from camera to (i,j) pixel

    public:
		Vector3D      loc;          // camera location
		Vector3D        u;          // unit vector, to camera's right
		Vector3D        v;          // unit vector, looking up from camera
		Vector3D        n;          // unit vector pointing opposite camera direction
		float           d;          // distance between camera and view plane
		float           w;          // width of view plane
		float           h;          // height of view plane
		int          xres;   	    // horizontal image resolution
		int          yres;          // vertical image resolution
		GLfloat    *image;          // the final 2D image is stored here. It is stored in a 1D array.
};

#endif // CAMERA_H
