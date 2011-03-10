#ifndef CV_HELPERS_H_INCLUDED
#  define CV_HELPERS_H_INCLUDED

#include <opencv/cv.h>

#ifdef __cplusplus
extern "C" {
#endif

IplImage * cvbjNewImageBasedOn
(
  const IplImage *prototype, 
  int depth, 
  int channels, 
  int width, 
  int height
);


#ifdef __cplusplus
} // extern "C"
#endif


#endif //CV_HELPERS_H_INCLUDED