#include <stdio.h>
#include <dlfcn.h>

/**
 * Attempts to load shared libraries
 * @param argc
 * @param argv files to check (pass only shared libs)
 * @return 0 - all shared libs loaded, 1 - error occured (invalid or broken files passed)
 */
int main(int argc, char* argv[])
{
	int i;
	for (i = 1; i < argc; ++i) {
		void* handle = dlopen(argv[i], RTLD_NOW);
		if (!handle) {
			fprintf(stderr, "%s\n", dlerror());
			return 1;
		} else {
			dlclose(handle);
		}
	}
	return 0;
}
