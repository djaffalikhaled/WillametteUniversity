// Contains the implementation of the member functions in Camera.h

#include "Camera.h"

Camera::Camera()
	:  	loc(0,0,0),
        u(1,0,0),
        v(0,1,0),
        n(0,0,1),
        d(10),
        w(4),
        h(3),
        xres(640),
		yres(480)
{
   image = new GLfloat[ xres*yres*3];
}

Camera::Camera(int xr, int yr)
	:  	loc(0,0,0),
        u(1,0,0),
        v(0,1,0),
        n(0,0,1),
        d(10),
        w(4),
        h(3),
        xres(xr),
		yres(yr)
{
    image = new GLfloat[ xres*yres*3];
}


Camera::~Camera()
{
    delete[] image;
}

Camera::Camera(const Camera& cam)
	:  	loc(cam.loc),
        u(cam.u),
        v(cam.v),
        n(cam.n),
        d(cam.d),
        w(cam.w),
        h(cam.h),
        xres(cam.xres),
		yres(cam.yres)
{
    image = new GLfloat[ xres*yres*3];
}

Camera& Camera::operator=(const Camera& rhs)
{
    if (this == &rhs) return *this; // handle self assignment

    loc				= rhs.loc;
	u				= rhs.u;
	v				= rhs.v;
	n				= rhs.n;
	d				= rhs.d;
	w				= rhs.w;
	h				= rhs.h;
	xres			= rhs.xres;
	yres			= rhs.yres;
    return *this;
}

//------------------------  Calculate the camera coordinate basis vectors
void
Camera::calcUVN(const Vector3D &VPN, const Vector3D &VUP) {
     // ************************  PART 3: NEED TO CALCULATE u, v, n

}

//------------------------  Calculate the ray from camera to pixel (i,j) on viewscreen
// i is the index along x (column) and j is the index along y (row)
Ray
Camera::pixRay(int i, int j) const {

     Vector3D P1((-(w/2)+(w*i)/(xres-1)), ((-h/2)+(h*j)/(yres-1)), -d);
     Vector3D dir(P1-loc);
     dir.normalize();
     // ************************ PART 1:  NEED TO CALCULATE dir
     // See formulas in ray tracing notes at the very end of section 2.  dir = P1-P0.
     // For Part 1, we use the default values of loc  and u v n, but make sure this
     // works for any values of loc and u v n (if you don't do it right, it  will become apparent
     // in Part 3 when you write calcUVN and tilt the camera!)


     Ray r(loc,dir);
     return r;
}
