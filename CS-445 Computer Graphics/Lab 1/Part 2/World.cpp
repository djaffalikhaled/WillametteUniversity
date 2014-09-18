// World.cpp
// Stores all the items in the world: geometric objects, lights, camera

#include "World.h"

// -------------------------------------------------------------------- build
// This is where we create all the things in the world - camera, objects, lights
void
World::build(void)
{
    background_color = RGBColor(0.5,0.4,0.3);
    depth = 0;  //  0 for no reflections.
    camera_ptr = new Camera();

	// Materials:
    Material* mat_ptr1 = new Material();
    mat_ptr1->setAllColor(0,1,1); 

	Material* mat_ptr2 = new Material();
    mat_ptr2->setAllColor(1,0,1);

	Material* mat_ptr3 = new Material();
    mat_ptr3->setAllColor(0.6,0.6,0.6);

	Material* mat_ptr4 = new Material();
    mat_ptr4->setAllColor(1,1,1);
    
    // Spheres:
    Sphere* sphere_ptr = new Sphere(Vector3D(3, 0, -40), 3);
    sphere_ptr->set_material(mat_ptr1);
    add_object(sphere_ptr);

    sphere_ptr = new Sphere(Vector3D(-2, 0, -40), 2);
    sphere_ptr->set_material(mat_ptr2);
    add_object(sphere_ptr);
    
    sphere_ptr = new Sphere(Vector3D(-4, 4, -60), 1.5);
    sphere_ptr->set_material(mat_ptr3);
    add_object(sphere_ptr);

    sphere_ptr = new Sphere(Vector3D(0, -3.2, -30), 1.8);
    sphere_ptr->set_material(mat_ptr4);
    add_object(sphere_ptr);

    // Lights:
    PointLight* light_ptr = new PointLight();
    light_ptr->set_color(1,1,1);
    light_ptr->set_intensity(.5);
    light_ptr->set_location(10,10,-30);
    add_light(light_ptr);

    PointLight* light_ptr2 = new PointLight();
    light_ptr2->set_color(1,0.5,0);
    light_ptr2->set_intensity(.9);
    light_ptr2->set_location(-5,-5,-30);
    add_light(light_ptr2);
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
