#lang racket/base
(require web-server/servlet racket/contract )
(provide/contract (start (request? . -> . response?)))
(define (start request)
  (define host (bytes->string/utf-8 (header-value (headers-assq* #"host" (request-headers/raw request)))))

  
  (response/xexpr
   `(html
     (head (title "test")
           (link ((rel "stylesheet")
                  (href "test-static.css")
                  (type "text/css"))))


     
     (body (h1 "Test")
           (p "This host is: ",host)
           (img ((src "abstract.svg") (alt "abstract svg image from https://docs.racket-lang.org/teachpack/2htdpimage.html#%28def._%28%28lib._2htdp%2Fimage..rkt%29._pulled-regular-polygon%29%29") (witdh "200") (height "200") ))))))
(require web-server/servlet-env)
(serve/servlet start
               #:launch-browser? #t
              
               #:quit? #f
               #:listen-ip #f
               #:port 8000
               #:extra-files-paths
               (list (build-path "." "htdocs"))
               #:servlet-path "/main.rkt")