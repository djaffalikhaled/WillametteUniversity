// Stores variables which need to be shared across files
#ifndef GLOBALS_H
#define GLOBALS_H

#include "MatrixStack.h"
#include "Shapes.h"

extern GLuint  projection;      // projection matrix uniform shader variable location
extern GLuint  model_view;      // model-view matrix uniform shader variable location
extern GLuint  model_color;     // model-view matrix uniform shader variable location
extern GLuint program;          // shader program
extern MatrixStack mvMatrixStack; // the matrix stack
extern Shapes shapes;

#endif // GLOBALS_H
