// World.cpp
// Stores all the items in the world: geometric objects, lights, camera

#include "World.h"

// -------------------------------------------------------------------- build
// This is where we create all the things in the world - camera, objects, lights
void
World::build(void)
{

    background_color = RGBColor(0.1,0.1,0.6);
    depth = 2;  // levels of reflection. 0 for no reflections.

    camera_ptr = new Camera();
    Vector3D vpn(0,0,1);       //  the direction the camera is aimed
    Vector3D vup(0.1,1,0);       //  the up direction
    Vector3D camloc(0,1,25);   //  camera location
    camera_ptr->loc = camloc;  // set camera location
    camera_ptr->calcUVN(vpn, vup); // compute the orthonormal coordinate system

    Material* mat_ptr = new Material();
    mat_ptr->setAllColor(1,0.7,0);

    Material* mat_ptr2 = new Material();
    mat_ptr2->setAllColor(1,1,1);

    Material* mat_ptr3 = new Material();
    mat_ptr3->setAllColor(1,0,1);

    Material* mat_ptr4 = new Material();
    mat_ptr4->setAllColor(.1,.6,.1);

    Material* mat_ptr5 = new Material();
    mat_ptr5->setAllColor(1,0,0);

    Sphere* sphere_ptr = new Sphere;
    sphere_ptr->set_center(2, 2, -170);
    sphere_ptr->set_radius(8.0);
    sphere_ptr->set_material(mat_ptr);
    add_object(sphere_ptr);

    sphere_ptr = new Sphere(Vector3D(-3, 0, -10), 2);
    sphere_ptr->set_material(mat_ptr);
    add_object(sphere_ptr);

    sphere_ptr = new Sphere(Vector3D(4, 0, -20), 1);
    sphere_ptr->set_material(mat_ptr3);
    add_object(sphere_ptr);

    sphere_ptr = new Sphere(Vector3D(0, 5, -15), 1);
    sphere_ptr->set_material(mat_ptr3);
    add_object(sphere_ptr);

    Plane* plane_ptr = new Plane;
    plane_ptr->set_normal(0,1,0);
    plane_ptr->set_point(0,-1,0);
    plane_ptr->set_material(mat_ptr4);
    add_object(plane_ptr);

    Cylinder* cylinder_ptr = new Cylinder();
    cylinder_ptr->set_center(0, 0, -30);
    cylinder_ptr->set_height(5);
    cylinder_ptr->set_radius(.5);
    cylinder_ptr->set_material(mat_ptr5);
    add_object(cylinder_ptr);
    
    cylinder_ptr = new Cylinder();
    cylinder_ptr->set_center(4, 4, -200);
    cylinder_ptr->set_height(7);
    cylinder_ptr->set_radius(3);
    cylinder_ptr->set_material(mat_ptr2);
    add_object(cylinder_ptr);


    PointLight* light_ptr = new PointLight();
    light_ptr->set_color(1,1,1);
    light_ptr->set_intensity(.6);
    light_ptr->set_location(0,15,-20);
    add_light(light_ptr);

     // Create and add a light
    PointLight* light_ptr2 = new PointLight();
    light_ptr2->set_color(1,0.7,0.5);
    light_ptr2->set_intensity(.3);
    light_ptr2->set_location(10,15,-20);
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
