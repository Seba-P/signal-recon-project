#ifndef _COMMON_H_
#define _COMMON_H_

#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>

#include "common_utils.h"
#include "common_soc.h"

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

#endif /* _COMMON_H_ */
