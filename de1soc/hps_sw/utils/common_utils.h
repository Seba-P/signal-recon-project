#ifndef _COMMON_UTILS_H_
#define _COMMON_UTILS_H_

#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>

#include "hps_def.h"
#include "colors.h"

// Logging macros
#ifndef log_printf
  #define log_printf(format, ...)   if (g_log_flag) \
                                      fprintf(g_log_file, format, ##__VA_ARGS__); \
                                    printf(format, ##__VA_ARGS__);
#endif

#ifndef debug_printf
  #define debug_printf(format, ...) if (g_debug_flag) \
                                    { \
                                      fprintf(g_log_file, format, ##__VA_ARGS__); \
                                      printf(format, ##__VA_ARGS__); \
                                    }
#endif

// User defines
#ifndef MAX_FILENAME_CHARS
  #define MAX_FILENAME_CHARS (32)
#endif

// User files
extern FILE* g_input_file;
extern FILE* g_output_file;
extern FILE* g_log_file;

extern char g_input_file_name[MAX_FILENAME_CHARS];
extern char g_output_file_name[MAX_FILENAME_CHARS];
extern char g_log_file_name[MAX_FILENAME_CHARS];

// User flags
extern int g_log_flag;
extern int g_debug_flag;

#ifndef _WEAK_
    #define _WEAK_ __attribute__ ((weak))
#endif

void  _WEAK_ parse_cmdline(int argc, char** argv);
void  _WEAK_ init_files(void);
void  _WEAK_ init_sysbase(void);
void  _WEAK_ init_address_spaces(void);

void* _WEAK_ get_physical_address(void* virt_addr, int virt_ofst);
void  _WEAK_ sig_handler(int signal);
void  _WEAK_ goto_exit(int exit_code);

#endif /* _COMMON_UTILS_H_ */
