#include <iostream>
#include <string>
using namespace std;

int addFive(int a);

int main() {
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
	cout << "Can I print an integer?\n";
	int number = 5;
	cout << number;
	cout << "\n";
	cout << "I can! Let's add 5 to that!\n";
	number = addFive(number);
	cout << number;
        cout << "\n";
	cout << "Hey that worked!\n";
	cout << "Lets do floats...\n";
	float number2 = 2.5;
	cout << number2;
	cout << "\n";
	cout << "But what about adding 5 to that?\n";
	number2 += 5;
	cout << number2;
	cout << "\n";
	cout << "Yep, I can change floats too!\n";
	cout << "I can apparently print strings, too...\n";
	return 0;
}

int addFive(int a){
	return a+5;
}
