// Generates the vertices, colors, and normals of a unit disk
// centered at origin, sides aligned with axes.
//
// Inherits from the GeometryBase class where all of the shader setup happens.
//
// Always use the Right Hand Rule to generate vertex sequence. We want outward facing normals.

#include "Disk.h"
#include <iostream>
using std::cout;

// ---------------------------------------------------------------------- default constructor
Disk::Disk(int numSections)
{
    numVertices = numSections*3;  // it is important that we know how many vertices we will need.
    radius = 1;
    angle = (2*M_PI*radius)/numSections;
    mode = GL_TRIANGLES;   // opengl drawing mode

    // These arrays are member variables. We really don't need to keep them permanently after they
    // have been placed in the gpu buffers. However, we will keep them around for the time being.
    points = new vec4[numVertices];
    colors = new vec4[numVertices];
    normals = new vec4[numVertices];

    // These are temporary arrays of the data. Note this data will be placed (with possible duplicates)
    // into the above member variable arrays.  Need to use indexing for more efficient storage.
    // For the meaning of v0, v1, etc, see the diagram at the top of this file.
    vec4 vertices[numVertices];
    vec4 vertex_colors[numVertices];
    vec4 face_normals[numVertices];

    for(int i=0; i<=numSections; i++)
    {
        vertices[i] = vec4(radius*cos(i*angle), 0, radius*sin(i*angle), 1);
        if (i%2 == 0)
        {
            vertex_colors[i]=vec4(0,0,1,1);
        }//Assign color blue
        else
        {
            vertex_colors[i]=vec4(0,1,0,1);
        }//Assign color green
        face_normals[i] = vec4(0,1,0,0);
    }//end of for loop over numSections

    // Generate cube:
    int index = 0;

    for(int j=0; j<numSections; j++)
    {
        tri(index, vec4(0,0,0,1), vertices[j], vertices[j+1] , vertex_colors[j], face_normals[0]);
    }//for loop
}

// ---------------------------------------------------------------------- quad
// This is a helper function which generates the vertex attributes (points, color,
// normals, texture coordinates) for a single face of the cube. We will call
// this 6 times in the constructor above, once for each face.
void
Disk::tri(int &index, vec4 center, vec4 v1, vec4 v2, vec4 col, vec4 norm)
{
    colors[index] = col;
    points[index] = center;
    normals[index] = norm;

    index++;

    colors[index] = col;
    points[index] = v1;
    normals[index] = norm;

    index++;

    colors[index] = col;
    points[index] = v2;
    normals[index] = norm;

    index++;
}







