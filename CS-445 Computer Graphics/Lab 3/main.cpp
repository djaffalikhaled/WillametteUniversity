// Displays a cube, disk and cylinder

#include "Angel.h"
#include <iostream>
using std::cout;

#include "MatrixStack.h"
#include "Shapes.h"
#include "Globals.h"
#include "Camera.h"

//********  These are available as extern variables in Globals.h **************
GLuint  projection; // projection matrix uniform shader variable location
GLuint  model_view;  // model-view matrix uniform shader variable location
GLuint  program;  // shader programs
MatrixStack mvMatrixStack;  // stores the model view matrix stack
Shapes shapes;
//********  End extern variables in Globals.h **************

Camera camera;
// Viewing transformation parameters
GLfloat theta = 0.0;
GLfloat phi = 0.0;
GLfloat alpha = 0.0;

float animateAngle = 0;  // used for animation
//---------------------------------------------------------------------------- printControls

void printControls()
{
    cout << "\n\n************  Controls **************" << "\n";
    cout << "q or Q ............ quit" << "\n";
    cout << "x ................. rotate around x" << "\n";
    cout << "y ................. rotate around y" << "\n";
    cout << "z ................. rotate around z" << "\n";
    cout << "r ................. reset" << "\n";
}

//---------------------------------------------------------------------------- init
// OpenGL initialization
void
init()
{

    program = InitShader( "vertex.glsl", "fragment.glsl" );
    glUseProgram(program );

    // Uniform variables
    model_view = glGetUniformLocation( program, "model_view" );
    projection = glGetUniformLocation( program, "projection" );

    glLineWidth(2);  // sets the thickness of the line for the wired shapes
    shapes.createBuffers(program);

    glEnable( GL_DEPTH_TEST );
    glClearColor( 0.5, 0.5, 0.5, 1.0 );
    printControls();
}


//----------------------------------------------------------- display

void
display( void )
{
    // Clear the color and depth buffers
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );

    // Calculate camera projection parameters (we'll deal with the details in Lab 4):
    mat4  p = camera.calcPerspective();

    // Set the value of the projection matrix uniform variable for current
    // shader program (we'll deal with shaders in Lab 5):
    glUniformMatrix4fv( projection, 1, GL_TRUE, p );

   // cout << p << "\n";  // print out matrix if desired  (good for debugging purposes)

    // The modelview matrix (Model+View) contains transformations for scene objects (Model)
    //  plus  camera orientation & location (View).  We'll deal with the details of the View
    //  in Lab 4.
    //  We store versions of the modelview matrix on the Matrix Stack.
    //  Here, we initialize the model view matrix stack to the identity matrix.
    mvMatrixStack.loadIdentity();

    // Calculate view transformations -  camera location and orientation
    // (Stay tuned for Lab 4 for details)
    mat4 mv = camera.calcLookAt();

    // Append to mv the rotation associated with the animation around y.
    // Note we  multiply on the right.  Matrices applied to a vertex according
    // to a right to left order (the far most right matrix is applied first).
    mv = mv*RotateY(animateAngle);

    // Append to mv the rotations associated with the user keypresses
    mv = mv*RotateZ(alpha);   // rotate about z axis
    mv = mv*RotateY(theta);   // rotate about y axis
    mv = mv*RotateX(phi);     // rotate about x axis

    // Save the current modelview matrix on the stack
    mvMatrixStack.pushMatrix(mv);

    // Set the value of the modelview matrix uniform variable for current shader program:
    glUniformMatrix4fv( model_view, 1, GL_TRUE, mv );

    // Draw the cube - finally!  Can you write down the order or all of the transformations applied
    // to the cube vertices?
    shapes.drawCube();

    // Append a translation (along x) onto the modelview matrix
    mv = mv*Translate(1.1,0,0);

    // Set the value of the modelview matrix uniform variable for current shader program:
    glUniformMatrix4fv( model_view, 1, GL_TRUE, mv );

    // Draw the cylinder! Can you write down the order or all of the transformations applied
    // to the cylinder  vertices?
    shapes.drawCylinder();

    // Retrieve the modelview matrix *previously* stored on the stack.
    mv = mvMatrixStack.popMatrix();

    // Append a translation (along -x) onto the  modelview matrix
    mv = mv*Translate(-1.1,0,0);

    // Append a rotation (about x) onto the  modelview matrix
    mv = mv*RotateX(90);

    // Set the value of the modelview matrix uniform variable for current shader program:
    glUniformMatrix4fv( model_view, 1, GL_TRUE, mv );

     // Draw the disk! Can you write down the order or all of the transformations applied
    // to the disk vertices?
    shapes.drawDisk();

    // Make sure that we unbind any current Vertex Array Object (to be on the safe side)
    glBindVertexArray( 0 );

    // Swap buffers - for double buffering. This avoids flickering.
    glutSwapBuffers();
}


//---------------------------------------------------------------------------- keyboard

void
keyboard( unsigned char key, int x, int y )
{

    float inc = 5.0;
    switch( key )
    {
    case 033: // Escape Key
    case 'q':
    case 'Q':
        exit( EXIT_SUCCESS );
        break;

    case 'y':   // rotate around y
        theta += inc;
        break;
    case 'x':     // rotate around x  (this is always applied second)
        phi += inc;
        break;
    case 'z':     // rotate around z  (this is always applied second)
        alpha += inc;
        break;
    case 'r':     // reset
        phi = 0;
        theta = 0;
        alpha = 0;
        break;
    }

    glutPostRedisplay();
}

//---------------------------------------------------------------------------- reshape

void
reshape( int width, int height )
{
    glViewport( 0, 0, width, height );
    camera.aspect = GLfloat(width)/height;
}

//---------------------------------------------------------------------------- idle
void idle()
{
    animateAngle += .005;
    if (animateAngle <0) animateAngle = 0;

    glutPostRedisplay();
}

//---------------------------------------------------------------------------- main

int
main( int argc, char **argv )
{
    glutInit( &argc, argv );
    glutInitDisplayMode( GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH );
    glutInitWindowSize( 512, 512 );
    glutInitContextVersion( 3, 3 );
    glutInitContextProfile( GLUT_CORE_PROFILE );
    glutCreateWindow( "Transformations" );

    glewInit();

    init();

    glutDisplayFunc( display );
    glutKeyboardFunc( keyboard );
    glutReshapeFunc( reshape );
    glutIdleFunc(idle); //  need for animation but not mouse interaction

    glutMainLoop();
    return 0;
}
