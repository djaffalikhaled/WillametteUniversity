// World.h
// Stores all the items in the world: geometric objects, lights, camera

#ifndef __WORLD__
#define __WORLD__

#include "RGBColor.h"
#include "Ray.h"
#include "Constants.h"
#include "Vector3D.h"
#include "ShadeRec.h"

#include "Camera.h"
#include "Material.h"

#include "Sphere.h"

#include <vector>
#include <iostream>
using std::cout;
using namespace std;

class World
{
public:
    RGBColor					background_color;
    Camera*						camera_ptr;
    vector<GeometricObject*>	objects;
  //  need to add vector of light objects
    int                         depth;        // levels of reflection. Set to 0 if no reflections are allowed.
public:
    World(void);
    ~World();
    void add_object(GeometricObject* object_ptr);
    void set_camera(Camera* c_ptr);
    void set_depth(int d);
    void build(void);

private:
    void delete_objects(void);
};


// ------------------------------------------------------------------ add_object

inline void
World::add_object(GeometricObject* object_ptr)
{
    objects.push_back(object_ptr);
}

// ------------------------------------------------------------------ set_camera

inline void
World::set_camera(Camera* c_ptr)
{
    camera_ptr = c_ptr;
}

inline void
World::set_depth(int d)
{
    depth = d;
}

#endif
