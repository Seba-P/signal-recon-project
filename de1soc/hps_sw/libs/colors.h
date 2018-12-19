#ifndef _COLORS_H_
#define _COLORS_H_

  // Attributes codes
  #define NORMAL      0
  #define BOLD        1
  #define UNDERSCORE  4
  #define BLINK       5
  #define REVERSE     7
  #define CONCEALED   8

  // Foreground color codes
  #define FG_BLACK  "\x1b[0;30m"
  #define FG_RED    "\x1b[0;31m"
  #define FG_GREEN  "\x1b[0;32m"
  #define FG_YELLOW "\x1b[0;33m"
  #define FG_BLUE   "\x1b[0;34m"
  #define FG_PURPLE "\x1b[0;35m"
  #define FG_CYAN   "\x1b[0;36m"
  #define FG_WHITE  "\x1b[0;37m"

  // Background color codes
  #define BG_BLACK  "\x1b[0;40m"
  #define BG_RED    "\x1b[0;41m"
  #define BG_GREEN  "\x1b[0;42m"
  #define BG_YELLOW "\x1b[0;43m"
  #define BG_BLUE   "\x1b[0;44m"
  #define BG_PURPLE "\x1b[0;45m"
  #define BG_CYAN   "\x1b[0;46m"
  #define BG_WHITE  "\x1b[0;47m"

  // 
  #define C_BLACK   0
  #define C_RED     1
  #define C_GREEN   2
  #define C_YELLOW  3
  #define C_BLUE    4
  #define C_PURPLE  5
  #define C_CYAN    6
  #define C_WHITE   7

  #define C_RESET   "\x1b[0m"
  
  #define _CONCAT_NX(a, b)    a ## b
  #define _CONCAT(a, b)       _CONCAT_NX(a, b)
  #define _STRINGIZE_NX(str)  #str
  #define _STRINGIZE(str)     (str, _STRINGIZE_NX(str))
  
  #define _COLOR_ARGS(atr, fg, bg) _CONCAT(_CONCAT(_CONCAT(atr, ;), _CONCAT(fg, ;)), bg)

  #define COLOR(atr, fg, bg) _STRINGIZE(_CONCAT(_CONCAT(\x1b[, _COLOR_ARGS(atr, fg, bg)), m)
  #define printf_color(atr, fg, bg, format, ...) printf("\x1b[%d;%d;%dm" format "\x1b[0m", atr, fg+30, bg+40, __VA_ARGS__)

#endif /* _COLORS_H_ */
