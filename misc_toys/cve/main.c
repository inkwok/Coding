#include <stdio.h>
#include <string.h>

void unreachable(void) {
    printf("You should not be seeing this...\n");
}

void vulnerable(char* source_buffer) {
    char destination_buffer[5];
    char would_be_kernel_memory[32];

    strcpy(destination_buffer, source_buffer);

    printf("\nYou entered: %s\n", destination_buffer);
}

int main(int argc, char** argv) {
    vulnerable(argv[1]);
    return 0;
}
