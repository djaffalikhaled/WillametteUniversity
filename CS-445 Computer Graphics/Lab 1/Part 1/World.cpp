// World.cpp
// Stores all the items in the world: geometric objects, lights, camera

#include "World.h"

// -------------------------------------------------------------------- build
// This is where we create all the things in the world - camera, objects, lights
void
World::build(void)
{

    background_color = RGBColor(.4);
    depth = 0;  // levels of reflection. 0 for no reflections.

    camera_ptr = new Camera();

    Sphere* sphere_ptr = new Sphere;
    sphere_ptr->set_center(2, 0, -40);
    sphere_ptr->set_radius(3.0);
    sphere_ptr->color = RGBColor(1,1,0);;
    add_object(sphere_ptr);

    sphere_ptr = new Sphere(Vector3D(-2, 0, -40), 2);
    sphere_ptr->color = RGBColor(1,0,1);
    add_object(sphere_ptr);

    sphere_ptr = new Sphere(Vector3D(-2, 5, -70), 5);
    sphere_ptr->color = RGBColor(0.5,0,1);
    add_object(sphere_ptr);

}

// -------------------------------------------------------------------- default constructor

World::World(void)
    :  	background_color(red),
        camera_ptr(NULL), depth(0)
{}

//------------------------------------------------------------------ destructor

World::~World(void)
{
    delete_objects();
}

//------------------------------------------------------------------ delete_objects

// Deletes the objects in the objects array, and erases the array.
// The objects array still exists, because it's an automatic variable, but it's empty

void
World::delete_objects(void)
{
    int num_objects = objects.size();

    for (int j = 0; j < num_objects; j++)
    {
        delete objects[j];
        objects[j] = NULL;
    }
    objects.erase (objects.begin(), objects.end());
}

//------------------------------------------------------------------ delete_lights

// NEED TO IMPLEMENT
