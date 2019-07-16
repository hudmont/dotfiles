

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Start of xbindkeys guile configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This configuration is guile based.
;;   http://www.gnu.org/software/guile/guile.html
;; any functions that work in guile will work here.
;; see EXTRA FUNCTIONS:

;; Version: 1.8.2

;; If you edit this file, do not forget to uncomment any lines
;; that you change.
;; The semicolon(;) symbol may be used anywhere for comments.

;; To specify a key, you can use 'xbindkeys --key' or
;; 'xbindkeys --multikey' and put one of the two lines in this file.

;; A list of keys is in /usr/include/X11/keysym.h and in
;; /usr/include/X11/keysymdef.h
;; The XK_ is not needed.

;; List of modifier:
;;   Release, Control, Shift, Mod1 (Alt), Mod2 (NumLock),
;;   Shift (CapsLock), Mod4, Mod5 (Scroll).


;; The release modifier is not a standard X modifier, but you can
;; use it if you want to catch release instead of press events

;; By defaults, xbindkeys does not pay attention to modifiers
;; NumLock, CapsLock and ScrollLock.
;; Uncomment the lines below if you want to use them.
;; To dissable them, call the functions with #f


;;;;EXTRA FUNCTIONS: Enable numlock, scrolllock or capslock usage
;;(set-numlock! #t)
;;(set-scrolllock! #t)
;;(set-capslock! #t)

;;;;; Scheme API reference
;;;;
;; Optional modifier state:
;; (set-numlock! #f or #t)
;; (set-scrolllock! #f or #t)
;; (set-capslock! #f or #t)
;; 
;; Shell command key:
;; (xbindkey key "foo-bar-command [args]")
;; (xbindkey '(modifier* key) "foo-bar-command [args]")
;; 
;; Scheme function key:
;; (xbindkey-function key function-name-or-lambda-function)
;; (xbindkey-function '(modifier* key) function-name-or-lambda-function)
;; 
;; Other functions:
;; (remove-xbindkey key)
;; (run-command "foo-bar-command [args]")
;; (grab-all-keys)
;; (ungrab-all-keys)
;; (remove-all-keys)
;; (debug)



;; set directly keycode (here control + f with my keyboard)
;;(xbindkey '("m:0x4" "c:41") "xterm")

;; specify a mouse button
;;(xbindkey '(control "b:2") "xterm")

;;(xbindkey '(shift mod2 alt s) "xterm -geom 50x20+20+20")

;; set directly keycode (control+alt+mod2 + f with my keyboard)
;;(xbindkey '(alt "m:4" mod2 "c:0x29") "xterm")

;; Control+Shift+a  release event starts rxvt
;;(xbindkey '(release control shift a) "rxvt")

;; Control + mouse button 2 release event starts rxvt
;;(xbindkey '(releace control "b:2") "rxvt")


;; Extra features
;;(xbindkey-function '(control a)
;;                   (lambda ()
;;                     (display "Hello from Scheme!")
;;                     (newline)))

;;(xbindkey-function '(shift p)
;;                   (lambda ()
;;                     (run-command "xterm")))


;; Double click test
;;(xbindkey-function '(control w)
;;                   (let ((count 0))
;;                     (lambda ()
;;                       (set! count (+ count 1))
;;                       (if (> count 1)
;;                           (begin
;;                            (set! count 0)
;;                            (run-command "xterm"))))))

;; Time double click test:
;;  - short double click -> run an xterm
;;  - long  double click -> run an rxvt
;;(xbindkey-function '(shift w)
;;                   (let ((time (current-time))
;;                         (count 0))
;;                     (lambda ()
;;                       (set! count (+ count 1))
;;                       (if (> count 1)
;;                           (begin
;;                            (if (< (- (current-time) time) 1)
;;                                (run-command "xterm")
;;                                (run-command "rxvt"))
;;                            (set! count 0)))
;;                       (set! time (current-time)))))


;; Chording keys test: Start differents program if only one key is
;; pressed or another if two keys are pressed.
;; If key1 is pressed start cmd-k1
;; If key2 is pressed start cmd-k2
;; If both are pressed start cmd-k1-k2 or cmd-k2-k1 following the
;;   release order
;; (define (define-chord-keys key1 key2 cmd-k1 cmd-k2 cmd-k1-k2 cmd-k2-k1)
;;     "Define chording keys"
;;   (let ((k1 #f) (k2 #f))
;;     (xbindkey-function key1 (lambda () (set! k1 #t)))
;;     (xbindkey-function key2 (lambda () (set! k2 #t)))
;;     (xbindkey-function (cons 'release key1)
;;                        (lambda ()
;;                          (if (and k1 k2)
;;                              (run-command cmd-k1-k2)
;;                              (if k1 (run-command cmd-k1)))
;;                          (set! k1 #f) (set! k2 #f)))
;;     (xbindkey-function (cons 'release key2)
;;                        (lambda ()
;;                          (if (and k1 k2)
;;                              (run-command cmd-k2-k1)
;;                              (if k2 (run-command cmd-k2)))
;;                          (set! k1 #f) (set! k2 #f)))))

(define global-map '())
(define fall '( ((XF86Mail) . "wmctrl -xa claws-mail || claws-mail")
 ((XF86Calculator) . "mlterm -e racket")
 ((XF86Tools) . "wmctrl -xa gmpc || gmpc")
 ((XF86HomePage) . "wmctrl -xa firefox || firefox")
 ((XF86AudioPrev) . "mpc prev) ((XF86AudioNext) . mpc next")
 ((XF86AudioStop) . "mpc stop) ((XF86AudioPlay) . mpc toggle")
 ((XF86AudioMute) . "pactl set-sink-mute 0 toggle")
 ((XF86AudioLowerVolume) . "pactl set-sink-volume 0 -5%")
 ((XF86AudioRaiseVolume) . "pactl set-sink-volume 0 +5%")
 ((F6) . "wmctrl -c :ACTIVE:")
 ((F4) . "rofi -show window -theme blue")
 ((F12) . "mlterm -e ~/dmenu/setstate")
 ((F10) . "wmctrl -xa emacs || emacs")
 ((F9) . "rofi -show run -theme blue")
 ((F8) . "mlterm")
 ((Mod4 Return) ((Mod4 Return) . "xdotool send mod4+Return")
                ((Shift KP_9) . "qdbus com.ssokolow.QuickTile /com/ssokolow/QuickTile doCommand top-right")
                ((Shift KP_8) . "qdbus com.ssokolow.QuickTile /com/ssokolow/QuickTile doCommand top")
                ((Shift KP_7) . "qdbus com.ssokolow.QuickTile /com/ssokolow/QuickTile doCommand top-left")
                ((Shift KP_6) . "qdbus com.ssokolow.QuickTile /com/ssokolow/QuickTile doCommand right")
                ((Shift KP_5) . "qdbus com.ssokolow.QuickTile /com/ssokolow/QuickTile doCommand middle")
                ((Shift KP_4) . "qdbus com.ssokolow.QuickTile /com/ssokolow/QuickTile doCommand left")
                ((Shift KP_3) . "qdbus com.ssokolow.QuickTile /com/ssokolow/QuickTile doCommand bottom-right")
                ((Shift KP_2) . "qdbus com.ssokolow.QuickTile /com/ssokolow/QuickTile doCommand bottom")
                ((Shift KP_1) . "qdbus com.ssokolow.QuickTile /com/ssokolow/QuickTile doCommand bottom-left")
                ((Mod4 KP_3) . "wmctrl -r :ACTIVE: -t 3")
                ((Mod4 KP_1) . "wmctrl -r :ACTIVE: -t 2")
                ((Mod4 KP_9) . "wmctrl -r :ACTIVE: -t 1")
                ((Mod4 KP_7) . "wmctrl -r :ACTIVE: -t 0")
                ((KP_3) . "wmctrl -s 3")
                ((KP_1) . "wmctrl -s 2")
                ((KP_9) . "wmctrl -s 1")
                ((KP_7) . "wmctrl -s 0"))))


(define (delete-duplicates l)
  (cond ((null? l) '())
        ((memq (car l) (cdr l)) (delete-duplicates (cdr l)))
        (else (cons (car l) (delete-duplicates (cdr l))))))


  
(define (register keys action)
  (define (loop getmap setmap keys)
    (if (null? keys)
        (setmap action)
        (let ((k (car keys)))
          (if (eq? #f (assoc k (getmap)))
              (setmap (assoc-set! (getmap) k '())))
          (loop (lambda () (cdr (assoc k (getmap))))
                (lambda (m) (setmap (assoc-set! (getmap) k m)))
                (cdr keys)))))
  (loop (lambda () global-map) (lambda (m) (set! global-map m)) keys))




(define (grab keymap)
  (define (proc k)
    (define action (cdr (assoc k keymap)))
    (ungrab-all-keys)
    (remove-all-keys)
    (if (string? action)
        (begin
          (run-command action)
          (reset-first-binding))
        (grab action))
    (grab-all-keys))

    (map (lambda (k)
         (xbindkey-function k (lambda () (proc k))))
       (delete-duplicates (map car keymap)))
  (if (not (eq? global-map keymap))
      (xbindkey-function '(Mod4 g) (lambda () (reset-first-binding)))))

(define (first-binding)
  (grab global-map))



(define (reset-first-binding)
  (ungrab-all-keys)
  (remove-all-keys)
  (first-binding)
  (grab-all-keys))
;;(define (simple s)
;;  (string-concatenate `("wmctrl -xa " ,s "||" ,s))
;;  )
(register '((Mod4 Return) (KP_7)) "wmctrl -s 0")
(register '((Mod4 Return) (KP_9)) "wmctrl -s 1")
(register '((Mod4 Return) (KP_1)) "wmctrl -s 2")
(register '((Mod4 Return) (KP_3)) "wmctrl -s 3")
(register '((Mod4 Return) (Mod4 KP_7)) "wmctrl -r :ACTIVE: -t 0")
(register '((Mod4 Return) (Mod4 KP_9)) "wmctrl -r :ACTIVE: -t 1")
(register '((Mod4 Return) (Mod4 KP_1)) "wmctrl -r :ACTIVE: -t 2")
(register '((Mod4 Return) (Mod4 KP_3)) "wmctrl -r :ACTIVE: -t 3")
(register '((Mod4 Return) (Shift KP_1)) "qdbus com.ssokolow.QuickTile /com/ssokolow/QuickTile doCommand  bottom-left")
(register '((Mod4 Return) (Shift KP_2)) "qdbus com.ssokolow.QuickTile /com/ssokolow/QuickTile doCommand bottom")
(register '((Mod4 Return) (Shift KP_3)) "qdbus com.ssokolow.QuickTile /com/ssokolow/QuickTile doCommand bottom-right")
(register '((Mod4 Return) (Shift KP_4)) "qdbus com.ssokolow.QuickTile /com/ssokolow/QuickTile doCommand left")
(register '((Mod4 Return) (Shift KP_5)) "qdbus com.ssokolow.QuickTile /com/ssokolow/QuickTile doCommand middle")
(register '((Mod4 Return) (Shift KP_6)) "qdbus com.ssokolow.QuickTile /com/ssokolow/QuickTile doCommand right")
(register '((Mod4 Return) (Shift KP_7)) "qdbus com.ssokolow.QuickTile /com/ssokolow/QuickTile doCommand top-left")
(register '((Mod4 Return) (Shift KP_8)) "qdbus com.ssokolow.QuickTile /com/ssokolow/QuickTile doCommand top")
(register '((Mod4 Return) (Shift KP_9)) "qdbus com.ssokolow.QuickTile /com/ssokolow/QuickTile doCommand top-right")
(register '((Mod4 Return) (Print)) "import -quality 100 -window root +repage ~/scrots/scrot_$(date +%Y%m%d%H%M%S).png")
;; (register '((Mod4 KP_End) (Mod4 KP_Enter)) (simple "xterm")
;; (register '((control Return) u) "wmctrl tmux || -T tmux -e tmux attach -t default")
;; (register '((control Return) e) "wmctrl -xa Emacs || emacsclient -c -n")
;; (register '((Mod4 Return) v) "wmctrl -s 2")
;; (register '((control Return) f) (in-gui "firefox"))
;; (register '((control Return) i) (in-gui "evince"))
(register '((Mod4 Return ) (Mod4 Return)) "xdotool send mod4+Return")

(define (in-term cmd)
  (string-join (list terminal "-e" cmd)))

(define (in-gui cmd)
  (string-join (list "wmctrl" "-xa" cmd "||" cmd)))


(define terminal "alacritty")
(define runner "rofi -show run -theme blue")
(define editor (in-gui "emacs"))

(register '((F8)) terminal)
(register '((F9)) runner)
(register '((F10)) editor)
(register '((F12)) (in-term "~/dmenu/setstate"))
(register '((F4)) "rofi -show window -theme blue")
(register '((F6)) "wmctrl -c :ACTIVE:")



(define browser (in-gui "firefox"))
(define mail (in-gui "claws-mail"))
(define music (in-gui "gmpc"))
(define calc (in-term "racket"))

;;(define fileman (in-term "mc"))
;;(define pim "taskcoach")
;;(define passwd "keepassxc ~/wazze2.kdbx")
;;(define torrent "transmission-gtk")
;;(define news "gpodder
;;(define keys "setxkbmap $(cat ~/dmenu/keysets | rofi -dmenu -p 'Setting the keyboard layout')")
;;(define mnt "~/dmenu/mnt")
;;(define state (in-term "~/dmenu/setstate"))
;; Examples of commands:
(register '((XF86AudioRaiseVolume)) "pactl set-sink-volume 0 +5%")
(register '((XF86AudioLowerVolume)) "pactl set-sink-volume 0 -5%")
(register '((XF86AudioMute)) "pactl set-sink-mute 0 toggle")

(register '((XF86AudioPlay))	"mpc toggle")
(register '((XF86AudioStop))	"mpc stop")
(register '((XF86AudioNext))	"mpc next")
(register '((XF86AudioPrev))	"mpc prev")
(register '((XF86HomePage))	browser)
(register '((XF86Tools))	music)
(register '((XF86Calculator))	calc)
(register '((XF86Mail))		mail)

(first-binding)

(display global-map)
;;(xbindkey '(F8) terminal)
;;(xbindkey '(F9) runner)
;;(xbindkey '(F10) editor)

;;(xbindkey '(F6) "wmctrl -c :ACTIVE:")
;;(define (gen-from-to from to prefix)
;;  (if (from > to)
;;    #f
;;    (cons
;;      (list
;;        `(mod4 ,from)
;;        (format "wmctrl -r :ACTIVE: -t ~a" from )
;;      (gen-from-to (1+ from) to prefix)
;;)
;;(xbindkey '(mod4 F3) fileman)
;;(xbindkey '(mod4 F4) passwd)
;;(xbindkey '(mod4 F5) akármibazdmeg)
;;(xbindkey '(mod4 F6) torrent)
;;(xbindkey '(mod4
;;(xbindkey '(control shift q) "xbindkeys_show")

;;(xbindkey '(F4) "rofi -show window")

;; (define (define-simple-chord-keys key1 key2 cmd1 cmd2)
;;   (let ((k1 #f)
;;        (k2 #f))
;;     (xbindkey-function key1 (lambda () (set! k1 #t)))
;;     (xbindkey-function key2 (lambda () (set! k2 #t)))
;;     (xbindkey-function (cons 'release key1)
;;                        (lambda ()
;;                          (if (and k1 k2)
;;                              (run-command cmd2)
;;                              (if k1 (run-command cmd1)))
;;                          (set! k1 #f) (set! k2 #f)))))

;; (define (append-at-end l item)
;;   (reverse (cons item (reverse l))))

;; (define (gen-chord-for-keys keys prefix suffix cmd-prefix-only cmd-suffix-only cmd-with-suffix cmd-with-prefix)
;;   (map
;;    (lambda (x)
;;      (let ((key (number->string x)))
;;         (list prefix
;;               (append-at-end suffix key)
;;               (string-join (list cmd-prefix-only key))
;; 	      (string-join (list cmd-suffix-only key))
;;               (string-join (list cmd-with-suffix key))
;; 	      (string-join (list cmd-with-prefix key)))))
;;     keys))

;; ;;(map
;; ;;  (lambda (args)
;; ;;    (apply define-chord-keys args))
;; ;;  (gen-chord-for-keys '(1 2 3) '() '(Alt) "wmctrl -s" "" "wmctrl -r :ACTIVE: -t" "wmctrl -r :ACTIVE: -t"))
;; (define-chord-keys '(Mod4) '(Control+Mod2 2) "xterm" "" "alacritty" "alacritty")


;;(define (gen-from-to from to prefix)
;;    #f
;;    (cons
;;      (list
;;        `(mod4 ,from)
;;        (format "wmctrl -r :ACTIVE: -t ~a" from )
;;      (gen-from-to (1+ from) to prefix)

;; Example:
;;   Shift + b:1                   start an xterm
;;   Shift + b:3                   start an rxvt
;;   Shift + b:1 then Shift + b:3  start gv
;;   Shift + b:3 then Shift + b:1  start xpdf

;;(define-chord-keys '(shift "b:1") '(shift "b:3")
;;  "xterm" "rxvt" "gv" "xpdf")

;; Here the release order have no importance
;; (the same program is started in both case)
;;(define-chord-keys '(alt "b:1") '(alt "b:3")
;;  "gv" "xpdf" "xterm" "xterm")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End of xbindkeys guile configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


