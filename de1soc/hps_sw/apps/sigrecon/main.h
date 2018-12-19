#ifndef _MAIN_H_
#define _MAIN_H_

// typedef struct
// {
// 	uint16_t timestamp : 15;
// 	uint16_t cross_dir : 1;
// } sample_t;

typedef uint16_t sample_t;

#define SAMPLE_DURATION(sample) (sample & 0x7FFF);
#define SAMPLE_CROSSDIR(sample) (sample >> 15);

#endif /* _MAIN_H_ */
