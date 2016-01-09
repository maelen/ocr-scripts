(define
   (ocr-book-script  pattern
                     width
                     height
                     offsetX
                     offsetY
                     xposition
                     lowThreshold
   )
   (let* ((filelist (cadr (file-glob pattern 1))))
      (while (not (null? filelist))
         (let*
            (
               (filenameIN (car filelist))
               (filenameOUT (car (strbreakup filenameIN ".")))
               (image    (car (gimp-file-load RUN-NONINTERACTIVE filenameIN filenameIN)))
               (drawable (car (gimp-image-get-active-layer image)))
               (images 0)
               (imageIDs 0)
               (image1st 0)
               (image2nd 0)
               (drawable1st 0)
               (drawable2nd 0)
            )
            (gimp-image-rotate image ROTATE-270)
            (gimp-image-crop image width height offsetX offsetY)
            (plug-in-gauss RUN-NONINTERACTIVE image drawable 2 2 1)
            (gimp-threshold drawable lowThreshold 255)
            (gimp-image-add-vguide image xposition)
            (set! images (cdr(plug-in-guillotine RUN-NONINTERACTIVE image drawable)))
            (set! imageIDs (car images))
            (set! image1st (vector-ref imageIDs 0))
            (set! image2nd (vector-ref imageIDs 1))
            (set! drawable1st (car (gimp-image-get-active-layer image1st)))
            (set! drawable2nd (car (gimp-image-get-active-layer image2nd)))            
            (gimp-deskew-plugin 0 image1st drawable1st 0 0 0 0 0)
            (gimp-deskew-plugin 0 image2nd drawable2nd 0 0 0 0 0)
            (gimp-file-save RUN-NONINTERACTIVE image1st drawable1st (string-append filenameOUT "-1.jpg") (string-append filenameOUT "-1.jpg"))
            (gimp-file-save RUN-NONINTERACTIVE image2nd drawable2nd (string-append filenameOUT "-2.jpg") (string-append filenameOUT "-2.jpg"))
            (gimp-image-delete image)
            (gimp-image-delete image1st)
            (gimp-image-delete image2nd)
         )
         (set! filelist (cdr filelist))
      )
   )
)