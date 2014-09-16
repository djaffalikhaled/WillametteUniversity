#!/bin/bash

g++ -c Camera.cpp -o Camera.o
g++ -c GeometricObject.cpp -o GeometricObject.o
g++ -c Material.cpp -o Material.o
g++ -c PointLight.cpp -o PointLight.o
g++ -c Ray.cpp -o Ray.o
g++ -c RenderEngine.cpp -o RenderEngine.o
g++ -c RGBColor.cpp -o RGBColor.o
g++ -c ShadeRec.cpp -o ShadeRec.o
g++ -c Sphere.cpp -o Sphere.o
g++ -c Vector3D.cpp -o Vector3D.o
g++ -c World.cpp -o World.o
g++ -c main.cpp -o main.o
g++  Camera.o GeometricObject.o Material.o PointLight.o Ray.o RenderEngine.o RGBColor.o ShadeRec.o Sphere.o Vector3D.o World.o main.o -lGL -lGLU -lglut -o main
