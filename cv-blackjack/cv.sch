;;; Part of the Blackjack library by Anton Grigoryev
;;; OpenCV interop header (macro definitions)

(define-macro (using-1 binding . body)
  `(let (,(list (car binding) (cadr binding)))
     ,@body
     (,(caddr binding) ,(car binding))))

(define-macro (using bindings . body)
    (if (pair? bindings)
      (if (pair? (cdr bindings))
          `(using-1 ,(car bindings) 
                     (using ,(cdr bindings) ,@body))
          `(using-1 ,(car bindings)
                     ,@body))
      `(let () ,@body)))

(define-macro (using-homogen release bindings . body)
    (if (pair? bindings)
      (if (pair? (cdr bindings))
          `(using-1 ,(append (car bindings) (list release))
                     (using-homogen ,release ,(cdr bindings) ,@body))
          `(using-1 ,(append (car bindings) (list release))
                     ,@body))
      `(let () ,@body)))

(define-macro (using-cv:images bindings . body)
  `(using-homogen cv:release-image ,bindings ,@body))

(define-macro (cv:with-capture cap . body)
  `(using ((,cap (cv:capture-from-cam 0) cv:release-capture))
     ,@body))

(define-macro (cv:run-videostream-transformer cap frame . body)
  (let ((display-frames (gensym)))
    `(let ()
       (define (,display-frames)
         (let ((,frame (cv:query-frame ,cap)))
           (cv:show-image "frame" (let () ,@body))
           (if (not (= (cv:wait-key 20) 27))
               (,display-frames))))
       (,display-frames))))

(define-macro (define-c-struct-field symbol ctype fname ftype)
  `(begin
     (define ,(string->symbol (string-append (symbol->string symbol)
                                             ".get-"
                                             (symbol->string fname)))
       (c-lambda ((pointer ,ctype)) ,ftype
                 ,(string-append "___result = ___arg1->" (symbol->string fname) ";")))
     (define ,(string->symbol (string-append (symbol->string symbol)
                                             ".set-"
                                             (symbol->string fname)))
       (c-lambda ((pointer ,ctype) ,ftype) void
                 ,(string-append "___arg1->" (symbol->string fname) " = ___arg2;")))))

(define-macro (define-c-struct-accessors symbol ctype fields)
  `(begin
     (define ,(string->symbol (string-append (symbol->string symbol) ".new"))
       (c-lambda () (pointer ,ctype)
                 ,(string-append "___result = (" ctype " *)malloc(sizeof(" ctype "));")))
     (define ,(string->symbol (string-append (symbol->string symbol) ".delete"))
       (c-lambda ((pointer ,ctype)) void "free"))
     ,@(map (lambda (f) 
             `(define-c-struct-field ,symbol ,ctype ,(car f) ,(cadr f)))
           fields)))

