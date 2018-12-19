#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

#include "common.h"

int main(int argc, char** argv, char** envp)
{
  printf("\nHello Linux!\n");
  printf("\nMy name is '%s' and you have passed me %d parameter%c%s",
      argv[0], argc-1, argc==2 ? '\0':'s', argc>1 ? ":\n":"  ");
  for (int i = 1; i < argc; i++)
  {
    printf("'%s', ", argv[i]);
  }
  printf("\x8\x8.\n"); //replace last comma with a dot

  printf("\nHere are your environment variables:\n");
  system("env");

  return 0;
}
