#include <unistd.h>

int main() {
	int a = 0;
	int b = 0;
	write(1, "Hello, World!\n", 14);
	return 0;
}