#include <iostream>
#include "RGBColor.h"
#include "Vector3D.h"

using namespace std;


int main()
{
    cout << "   _____                 _     _          \n";
    cout << "  / ____|               | |   (_)         \n";
    cout << " | |  __ _ __ __ _ _ __ | |__  _  ___ ___ \n";
    cout << " | | |_ | '__/ _` | '_ \\| '_ \\| |/ __/ __|\n";
    cout << " | |__| | | | (_| | |_) | | | | | (__\\__ \\\n";
    cout << "  \\_____|_|  \\__,_| .__/|_| |_|_|\\___|___/\n";
    cout << "                  | |                     \n";
    cout << "                  |_|                     \n";
    cout << "Lab 0 demo program! -Hayden Parker\n";
    cout << "\n";
	
    // RGBColor examples
    cout << "Doing RGBColor examples...\n";
    cout << "\tCreating RGBColor with no args...\n";
    RGBColor c1;
    cout << "\tCreating RGBCOlor with one args...\n";
    RGBColor c2(.2);
    cout << "\tCreating RGBColor with three args...\n";
    RGBColor c3(.1, .5, .4);
    cout << "\tAdding two RGBColors...\n";
    c1 = c2 + c3;
    cout << "\tAddition results: " << "c1 = " << c1;
    cout << "\tRunning .powc on c1...\n";
    c1 = c1.powc(2.0);
    cout << "\tResults: " << "c1^2 = " << c1 << "\n";
    
    // Vector examples
    cout << "Doing Vector3D examples...\n";
    cout << "\tCreating Vector3D with no args...\n";
    Vector3D vec1();
    cout << "\tCreating Vector3D with 1 arg...\n";
    Vector3D vec2(1);
    cout << "\tCreating Vector3D with 3 args...\n";
    Vector3D vec3(1,2,3);
    cout << "\tCalling .length on vec3...\n";
    cout << "\tvec3.length(): " << vec3.length() << "\n";
    cout << "\tTesting squared length...\n";
    cout << "\tvec3.len_squared(): " << vec3.len_squared() << "\n";
    cout << "\tCalling normalize on vec3, then .length()\n";
    vec3.normalize();
    cout << "\tvec3.length(): " << vec3.length() << "\n";
    cout << "\tTrying multiplication on vec3 to create vec4...\n";
    Vector3D vec4 = vec3*2;
    cout << "\tCreated vec4: (" << vec4.x << ", " << vec4.y << ", " << vec4.z << ")\n";
    cout << "\tDoing cross product...\n";
    Vector3D vec5 = vec4^vec5;
    cout << "\tCreated vec5: (" << vec5.x << ", " << vec5.y << ", " << vec5.z << ")\n";
    cout << "\tDoing dot product...\n";
    Vector3D vec6 = vec4*vec3;
    cout << "\tCreated vec6: (" << vec6.x << ", " << vec6.y << ", " << vec6.z << ")\n";
    return 0;
}

