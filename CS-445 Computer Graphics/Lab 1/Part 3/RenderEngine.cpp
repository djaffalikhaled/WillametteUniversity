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
    for (int row=0; row < camera->xres; row++)
    {
        for (int col=0; col< camera->yres; col++)
        {
            Ray curRay = camera->pixRay(row, col);
            pixel_color = trace_ray(curRay, world_ptr->depth); // curRay, 0. The 0 Will denote the bounce amount ()
            int index = col * 3 * camera->xres + row*3 ;
            camera->image[index]   = pixel_color.r;
            camera->image[index+1] = pixel_color.g;
            camera->image[index+2] = pixel_color.b;
        }
    }
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

    for (int i = 0; i<num_objects; i++)
    {
        ShadeRec srObject = world_ptr->objects[i]->hit(ray); // compare with sr
        if (srObject.t < sr.t && srObject.hit_an_object)
        {
            sr = srObject;
            pixel_color = world_ptr->objects[i]->color; // only used until lights and materials are implemented
        }
    }
    // Now, check to see if there has been a hit.  If so, sr should contain the information
    // about the closest hit. Use the pixel_color above and sr to determine the final pixel color.
    //  (Nothing to do below here for PART 1 since we aren't implementing shading yet.
    if (sr.hit_an_object)
    {
        // PART 1:Nothing to do here

        // PART 2:
        //    Need to implement calc_shade
        pixel_color =  calc_shade(ray, sr);
        // PART 3:   need to implement reflected color here
        if (rayDepth > 0) {
            pixel_color += sr.material_ptr->kr*calc_reflected(ray, sr, rayDepth);
	    }
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
    int num_lights = world_ptr->lights.size();


    for (int i=0; i<num_lights; i++)
    {
        PointLight *light = world_ptr->lights[i];
        RGBColor ambient = m_ptr->ka * m_ptr->ca * light->intensity * light->color;
        pixel_color 	 +=  ambient;
        //NEED TO IMPLEMENT:
        if (!inShadow(sr.local_hit_point, light))
        {


            // Check if in shadow (the check for shadows is done in PART 3.)
            // if not   (do this below for PART 2 without the shadow check)
            Vector3D ldir = light->location-sr.local_hit_point;
            //      calculate the light direction L
            ldir.normalize();
            Vector3D vdir = ray.d;
            vdir.normalize();

            Vector3D ndir = sr.normal;
            ndir.normalize();
            //calculate the camera direction V

            if (!(ldir*ndir<0))
            {
                //
                //      check to see if viewer and/or camera are below surface
                //      if not
                //          Calculate diffuse light
                RGBColor diffuse = m_ptr->kd* m_ptr->cd * light->intensity * light->color * (ldir*ndir);
                //          calculate  reflection direction R
                Vector3D reflect = 2*(ldir*ndir)*ndir-ldir;
                if ((reflect*vdir)> 0)
                {
                    //          Calculate specular light
                    RGBColor specular = m_ptr->cs * m_ptr->ks * light->intensity * light->color * pow((vdir*reflect),30);
                    pixel_color+= specular;
                }
                //      return accumulation  of ambient, diffuse, specular
                pixel_color+= diffuse;

            }
        }
    }// end loop over lights

    return pixel_color;
}

// ----------- calculate reflected color

RGBColor
RenderEngine::calc_reflected(const Ray& ray, ShadeRec& sr, int rayDepth)
{
    RGBColor reflected_color;

    //  PART 3:  NEED TO IMPLEMENT REFLECTION VIA RECURSION
    //            Rv=  2(V*N)N-V
    Vector3D V = -ray.d;
    V.normalize();
    Vector3D N = sr.normal;
    N.normalize();
    Vector3D Rv (2*(V*N)*N-V);//(2*V*N*N-V);
    //   first calculate the direction of the reflected ray (not the same as the reflection direction in calc_shade!)
    //   then recurse on this direction
    Ray reflectedRay(sr.local_hit_point, Rv);
    //for (int i = 0; i<rayDepth; i++){
		
        reflected_color = trace_ray(reflectedRay, rayDepth-1);
        
    //}
    return reflected_color;

}

// ----------------------------------------------------------------------------- check for shadows

// PART 3:
bool
RenderEngine::inShadow(Vector3D hit_point, PointLight* light) const
{
    int num_objs = world_ptr->objects.size();
    for (int i = 0; i<num_objs; i++)
    {
        Vector3D dir(light->location - hit_point);
        dir.normalize();
        Ray ray(hit_point, dir);

        ShadeRec sr= world_ptr->objects[i]->hit(ray);
        if (sr.hit_an_object)
        {
            return true;
        }

    }
    return false;
}



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


