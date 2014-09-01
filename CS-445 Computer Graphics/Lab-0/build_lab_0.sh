#!/bin/bash

g++ -c -o main.o main.cpp
g++ -c -o RGBColor.o RGBColor.cpp
g++ -c -o Vector3D.o Vector3D.cpp
g++ -o main main.o RGBColor.o Vector3D.o
