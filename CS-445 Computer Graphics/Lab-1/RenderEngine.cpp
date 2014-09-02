// RenderEngine.cpp
// Renderengine is where the main ray tracing algorithm is implemented.

#include "RenderEngine.h"

//------------------------------------------------------------------  Constructors
RenderEngine::RenderEngine() : world_ptr(NULL)
{}

RenderEngine::RenderEngine(World* w_ptr)
{
    world_ptr = w_ptr;
}


RenderEngine::RenderEngine(const RenderEngine& other)
{
    world_ptr = other.world_ptr;
}

//------------------------------------------------------------------  Destructor
RenderEngine::~RenderEngine()
{}

//------------------------------------------------------------------  Operators
RenderEngine& RenderEngine::operator=(const RenderEngine& rhs)
{
    if (this == &rhs) return *this;
    world_ptr = rhs.world_ptr;
    return *this;
}

//------------------------------------------------------------------ Setter
void
RenderEngine::set_world(World* w_ptr)
{
    world_ptr = w_ptr;
}

//------------------------------------------------------------------ render_scene
// This is the main ray tracing loop over pixels!! Start here.
void
RenderEngine::render_scene()
{
    Camera *camera = world_ptr->camera_ptr;
    RGBColor pixel_color;

    // PART 1:
    // Loop over rows and columns of images (pixels)
        // Compute the ray from camera to the given pixel (see function in Camera class)
        // trace the ray to get pixel_color (i.e. call trace_ray)
        //       (Do you remember which class stores the depth? If not, find out.)
        // make sure color is in range (1,0)  - see max_to_one() function
        // set image pixel to this color as follows:
            //int index = row * 3 * camera->xres + col*3 ;
            //camera->image[index]   = pixel_color.r;
            //camera->image[index+1] = pixel_color.g;
            //camera->image[index+2] = pixel_color.b;

}

// ----------------------------------------------------------------------------- trace_ray
//  Given a ray, loop over objects in scene to determine the closest object (if any) that
//  intersects the ray.

RGBColor
RenderEngine::trace_ray(const Ray& ray, int rayDepth)
{

    Vector3D normal; // don't need until lighting and shading is added
    Vector3D local_hit_point;
    float	tmin 			= kHugeValue;
    int 	num_objects 	= world_ptr->objects.size();
    RGBColor pixel_color(0,0,0);

    ShadeRec sr;  // stores information about the closest object (so far) that has been it. Look at sphere.cpp to see what is stored.
    sr.t = 100000;   //  need to initialize to a value larger than any expected hit so that this value of t is rejected.

    // PART 1:  JUST NEED TO IMPLEMENT THE LOOP OVER OBJECTS:
    // loop over objects in the scene
    //   Remember, the objects are stored in the World in a vector object (look up vector class) and also use
    //        the variable above num_objects
    // For each object, check to see if the ray intersects it:
            // ShadeRec srObject = world_ptr->objects[j]->hit(ray); // compare with sr
            // if this is closer than anything else previously seen, update  sr
            // and set pixel color:
            //        pixel_color = world_ptr->objects[j]->color; // only used until lights and materials are implemented


    // Now, check to see if there has been a hit.  If so, sr should contain the information
    // about the closest hit. Use the pixel_color above and sr to determine the final pixel color.
    //  (Nothing to do below here for PART 1 since we aren't implementing shading yet.
    if (sr.hit_an_object)
    {
        // PART 1:Nothing to do here

        // PART 2:
        //    Need to implement calc_shade
        //    pixel_color =  calc_shade(ray, sr);
        // PART 3:   need to implement reflected color here
    }
    else
    {
        // If nothing is hit, use the background color.
        pixel_color = world_ptr->background_color;
    }

    return pixel_color;
}

//------------------------------------------------------------------ calc shading

RGBColor
RenderEngine::calc_shade(const Ray& ray, ShadeRec& sr)
{
    RGBColor pixel_color(0,0,0);
    Material *m_ptr =  sr.material_ptr;

   // Nothing to do here for PART 1.
   //   Implement below for PART 2 (except for shadows which are done in PART 3).
   // int num_lights = world_ptr->lights.size();

   // will need to loop over lights

       // RGBColor ambient = m_ptr->ka * m_ptr->ca * light.intensity * light.color;
       // pixel_color 	+=  ambient;

        //NEED TO IMPLEMENT:
        // Check if in shadow (the check for shadows is done in PART 3.)
        // if not   (do this below for PART 2 without the shadow check)
        //      calculate the light direction L
        //      calculate the camera direction V
        //      check to see if viewer and/or camera are below surface
        //      if not
        //          Calculate diffuse light
        //          calculate  reflection direction R
        //          Calculate specular light
        //      return accumulation  of ambient, diffuse, specular
    // end loop over lights

    return pixel_color;
}

// ----------------------------------------------------------------------------- calculate reflected color

RGBColor
RenderEngine::calc_reflected(const Ray& ray, ShadeRec& sr, int rayDepth)
{
    RGBColor reflected_color;

    //  PART 3:  NEED TO IMPLEMENT REFLECTION VIA RECURSION
    //   first calculate the direction of the reflected ray (not the same as the reflection direction in calc_shade!)
    //   then recurse on this direction

    return reflected_color;

}

// ----------------------------------------------------------------------------- check for shadows

// PART 3:
//bool
//RenderEngine::inShadow(Vector3D hit_point, PointLight* light) const


// ------------------------------------------------------------------ clamp

RGBColor
RenderEngine::max_to_one(const RGBColor& c) const
{
    float max_value = max(c.r, max(c.g, c.b));

    if (max_value > 1.0)
        return (c / max_value);
    else
        return (c);
}

// ------------------------------------------------------------------ clamp_to_color
// Set color to red if any component is greater than one

RGBColor
RenderEngine::clamp_to_color(const RGBColor& raw_color) const
{
    RGBColor c(raw_color);

    if (raw_color.r > 1.0 || raw_color.g > 1.0 || raw_color.b > 1.0)
    {
        c.r = 1.0;
        c.g = 0.0;
        c.b = 0.0;
    }

    return (c);
}


