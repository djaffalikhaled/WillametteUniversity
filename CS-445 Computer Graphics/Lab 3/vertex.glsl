#version 330 core

in  vec4 vPosition;
in  vec4 vColor;
in  vec4 vNormal;
out vec4 Color;

uniform mat4 model_view;
uniform mat4 projection;

void main()
{
    Color = vColor;
    gl_Position = projection*model_view * vPosition/vPosition.w;
}
