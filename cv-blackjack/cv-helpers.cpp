#include <opencv/cv.h>
#include "cv-helpers.h"

IplImage * cvbjNewImageBasedOn
(
  const IplImage *prototype, 
  int depth, 
  int channels, 
  int width, 
  int height
)
{
  return cvCreateImage(
    cvSize(width  <= 0 ? prototype->width  : width,
           height <= 0 ? prototype->height : height),
    depth    == 0 ? prototype->depth     : depth,
    channels <= 0 ? prototype->nChannels : channels);
}

