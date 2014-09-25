// RenderEngine.h
// Renderengine is where the main ray tracing algorithm is implemented.

#ifndef RENDERENGINE_H
#define RENDERENGINE_H

#include <vector>
#include <iostream>
using std::cout;

#include "Ray.h"
#include "Vector3D.h"
#include "RGBColor.h"
#include "ShadeRec.h"
#include "World.h"
#include "Camera.h"
//#include "PointLight.h"
#include "GeometricObject.h"

class RenderEngine
{
    public:
        World* world_ptr;

    public:
        RenderEngine();
        RenderEngine(World* w_ptr);
        RenderEngine(const RenderEngine& other);
        ~RenderEngine();
        RenderEngine& operator=(const RenderEngine& other);

        void set_world(World* w_ptr);
        void render_scene();            // starting point for rendering algorithm
        RGBColor trace_ray(const Ray& ray, int rayDepth);
        RGBColor calc_reflected(const Ray& ray, ShadeRec& sr, int rayDepth);
        RGBColor calc_shade(const Ray& ray, ShadeRec& sr);
        RGBColor max_to_one(const RGBColor& c) const;
		RGBColor clamp_to_color(const RGBColor& c) const;
		bool inShadow(Vector3D hit_point, PointLight* light) const;
};

#endif // RENDERENGINE_H
