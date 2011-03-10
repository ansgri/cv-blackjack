;;; Part of the Blackjack library by Anton Grigoryev
;;; OpenCV foreign function interface

(c-declare #<<c-declare-end

#pragma warning( disable : 4101 4102 )
#include <opencv/cv.h>
#include <opencv/highgui.h>

#include "cv-helpers.h"

c-declare-end
)

(include "cv.sch")

(define-c-struct-accessors cv:rect "CvRect" ((x int)
                                             (y int)
                                             (width int)
                                             (height int)))

(define c-free
  (c-lambda ((pointer void #f)) void "free"))

(define cv:load-image
  (c-lambda (nonnull-char-string) (pointer "IplImage") 
            "___result = cvLoadImage(___arg1, CV_LOAD_IMAGE_UNCHANGED);"))

(define cv:show-image
  (c-lambda (nonnull-char-string (pointer "CvArr" #f)) void "cvShowImage"))

(define cv:wait-key
  (c-lambda (int) int "cvWaitKey"))

(define cv:capture-from-cam
  (c-lambda (int) (pointer "CvCapture" #f) "cvCaptureFromCAM"))

(define cv:release-capture
  (c-lambda ((pointer "CvCapture" #f)) void 
            "CvCapture *cap = ___arg1; cvReleaseCapture(&cap);"))

(define cv:query-frame
  (c-lambda ((pointer "CvCapture" #f)) (pointer "IplImage") "cvQueryFrame"))

(define cv:create-mat
  (c-lambda (int int int) (pointer "CvMat") "cvCreateMat"))

(define cv:clone-mat
  (c-lambda ((pointer "CvMat")) (pointer "CvMat") "cvCloneMat"))

(define cv:clone-image
  (c-lambda ((pointer "IplImage")) (pointer "IplImage") "cvCloneImage"))

(define cv:new-image-based-on-impl
  (c-lambda ((pointer "IplImage") int int int int) (pointer "IplImage") 
            "cvbjNewImageBasedOn"))

(define cv:IPL_DEPTH_1U 1)
(define cv:IPL_DEPTH_8U 8)
(define cv:IPL_DEPTH_16U 16)
(define cv:IPL_DEPTH_32F 32)
(define cv:BGR2RGB 4)
(define cv:BGR2GRAY 6)
(define cv:RGB2GRAY 7)
(define cv:GRAY2BGR 8)
(define cv:GRAY2RGB cv:GRAY2BGR)


(define (cv:new-image-based-on img #!key (depth 0) (channels 0) (width 0) (height 0))
  (cv:new-image-based-on-impl img depth channels width height))

(define cv:cvt-color
  (c-lambda ((pointer "CvArr" #f) (pointer "CvArr" #f) int) 
            void
            "cvCvtColor"))

(define cv:release-mat
  (c-lambda ((pointer "CvMat")) void 
            "CvMat *mat = ___arg1; cvReleaseMat(&mat);"))

(define cv:release-image
  (c-lambda ((pointer "IplImage")) void 
            "IplImage *img = ___arg1; cvReleaseImage(&img);"))

(define cv:flip
  (c-lambda ((pointer "CvArr" #f) (pointer "CvArr" #f) int) void "cvFlip"))

(define cv:add-weighted
  (c-lambda ((pointer "CvArr" #f) float64 (pointer "CvArr" #f) float64 float64 (pointer "CvArr" #f))
            void
            "cvAddWeighted"))

(define cv:abs-diff
  (c-lambda ((pointer "CvArr" #f) (pointer "CvArr" #f) (pointer "CvArr" #f))
            void
            "cvAbsDiff"))

(define cv:dilate
  (c-lambda ((pointer "CvArr" #f) (pointer "CvArr" #f) (pointer "IplConvKernel") int)
            void
            "cvDilate"))

(define cv:erode
  (c-lambda ((pointer "CvArr" #f) (pointer "CvArr" #f) (pointer "IplConvKernel") int)
            void
            "cvErode"))

(define cv:rect-structuring-element
  (c-lambda (int int) (pointer "IplConvKernel")
#<<endp
___result = cvCreateStructuringElementEx(___arg1 * 2 + 1, ___arg2 * 2 + 1, ___arg1, ___arg2, CV_SHAPE_RECT, NULL);
endp
))

(define cv:release-structuring-element
  (c-lambda ((pointer "IplConvKernel")) void "IplConvKernel *k = ___arg1; cvReleaseStructuringElement(&k);"))

