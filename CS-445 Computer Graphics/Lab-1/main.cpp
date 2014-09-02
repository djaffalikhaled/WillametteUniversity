// A Simple Recursive Ray Tracer Program.

#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif

#include <stdlib.h>
#include <iostream>
using std::cout;

#include "Camera.h"
#include "World.h"
#include "RenderEngine.h"

RenderEngine engine;  // The renderer
Camera* c_ptr;  // The camera

// Create the World containing various objects and then renders the image.
static void init() {
    World *w_ptr = new World();
    w_ptr->build();
    engine.set_world(w_ptr);
    engine.render_scene();
    c_ptr = engine.world_ptr->camera_ptr;
}

// Set up the window for displaying the ray traced image
static void resize(int width, int height)
{
    glViewport(0, 0, width, height);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluOrtho2D(0, width, 0, height);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity() ;
}

// Displays the ray traced image.
static void display(void)
{
    glClear(GL_COLOR_BUFFER_BIT);
    glDrawPixels(c_ptr->xres,c_ptr->yres,GL_RGB, GL_FLOAT, c_ptr->image);
    glFlush();
}

int main(int argc, char *argv[])
{
    init(); // create engine, world, camera, and then generate the image

    /* Establish GLUT callback Handlers */
    glutInit(&argc, argv);
    glutInitWindowSize(c_ptr->xres,c_ptr->yres);
    glutInitWindowPosition(0,0);
    glutInitDisplayMode(GLUT_RGB);
    glutCreateWindow("Ray Tracer");
    glutReshapeFunc(resize);
    glutDisplayFunc(display);
    glClearColor(1,1,1,1);

    glutMainLoop();

    return EXIT_SUCCESS;
}
