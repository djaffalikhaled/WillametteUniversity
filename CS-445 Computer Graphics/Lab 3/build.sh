#!/bin/bash

g++ -c Camera.cpp -o Camera.o
g++ -c Cone.cpp -o Cone.o
g++ -c Cube.cpp -o Cube.o
g++ -c Cylinder.cpp -o Cylinder.o
g++ -c Disk.cpp -o Disk.o
g++ -c InitShader.cpp -o InitShader.o
g++ -c main.cpp -o main.o
g++ -c MatrixStack.cpp -o MatrixStack.o
g++ -c Shapes.cpp -o Shapes.o
g++ -c WiredCone.cpp -o WiredCone.o
g++ -c WiredCube.cpp -o WiredCube.o
g++ -c WiredCylinder.cpp -o WiredCylinder.o
g++ -c WiredDisk.cpp -o WiredDisk.o
g++ -lGL -lGLU -lGLEW -lglut -c GeometryBase.cpp -o GeometryBase.o
g++ -lGL -lGLU -lGLEW -lglut -c WiredGeometryBase.cpp -o WiredGeometryBase.o

g++ Camera.o  Cone.o  Cube.o  Cylinder.o  Disk.o  InitShader.o  main.o  MatrixStack.o  Shapes.o  WiredCone.o  WiredCube.o  WiredCylinder.o  WiredDisk.o GeometryBase.o WiredGeometryBase.o -lGL -lGLU -lGLEW -lglut -o main
