(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(setq frame-resize-pixelwise t)

(setq inhibit-startup-screen t)
(setq initial-buffer-choice t)


(defun my-simple-macos-ui-theme ()
  (let ((modeline-bg "0c0c0c")  ; Matches macos dark title bar
	(modeline-fg "#ffffff")
        (modeline-inactive-fg "#aaaaaa"))

    ; Title bar
    ;(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))  ; match title bar color to frame background color
    (add-to-list 'default-frame-alist '(ns-appearance . dark))
    (setq frame-title-format nil)
    
    ; Mode line
    (set-face-attribute 'mode-line nil
			:foreground modeline-fg
			:background modeline-bg)
    (set-face-attribute 'mode-line nil
			:box `(:line-width 4
			       :color ,(face-attribute 'mode-line :background)))
    (set-face-attribute 'mode-line-inactive nil
			:foreground modeline-inactive-fg
			:background (face-attribute 'mode-line :background))
    (set-face-attribute 'mode-line-inactive nil
			:box `(:line-width 4
			       :color ,(face-attribute 'mode-line-inactive :background)))
    (column-number-mode 1)

    ; Window border
    (set-face-attribute 'vertical-border nil
			:foreground (face-attribute 'mode-line :background))
    
    ; Fringe
    (set-face-attribute 'fringe nil
			:background nil)

    ; Other junk
    (tool-bar-mode -1)
    (scroll-bar-mode -1)
    (setq ring-bell-function 'ignore)

    ; Text
    (set-face-attribute `default nil :family "Menlo" :height 120 :weight 'normal)
    (setq-default line-spacing 0.45)
    (blink-cursor-mode 0)    
  )
)

(my-simple-macos-ui-theme)


(put 'set-goal-column 'disabled nil)
(setq sentence-end-double-space nil)
(setq completions-format 'vertical)

; Don't recenter point when it moves n (or fewer) lines above/below the window; see Automatic Scrolling in the manual.
(setq scroll-conservatively 1)

(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)



; Install packages manually with M-x package-install RET {pkgname} RET:

; Evil
;(setq evil-want-C-u-scroll t)
;(require 'evil)
;(evil-mode 1)

; - helm
;(require 'helm-config)

; How do I install packages automatically from this file?
; See https://stackoverflow.com/questions/31079204/emacs-package-install-script-in-init-file for
; one approach.


; TODO
; - Stop inserting "." on quick double tap of spacebar? (This seems to not happen in Evil mode...)
; - shell vs term vs eshell?
;   - Is there a way to send lines to a shell?
;   - Is there a way to browse files in a shell buffer and open them in a new window?
; - Read a PDF in a buffer?


; Echo area/minibuffer
; - This area is too small/narrow by default; it's just a thin strip across the bottom of the
;   screen. Ideally, it would be padded by top and bottom margins to make it more readable. As far
;   as I can tell, there is no way to do this :(


; Theme idea:
; I tried setting a dark theme for the title bar, mode line, and minibuffer, with a light theme for
; the buffers. The challenge is that everything, including all buffers and the title bar, inherits
; its background color from the frame. My idea is to use the frame background to control the colors
; of the title bar and the minibuffer, and then set the buffer background independently. This is
; what I came up with:
;
;   (defvar my-frame-foreground "white")
;   (defvar my-frame-background "#232323")
;   (defvar my-window-foreground "black")
;   (defvar my-window-background "white")
;   (defvar my-modeline-foreground "white")
;   (defvar my-modeline-background "#606060")
;   (defvar my-modeline-inactive-background "#373737")
;   (set-face-attribute 'default nil :foreground my-frame-foreground :background my-frame-background)
;   (setq buffer-face-mode-face `(:foreground ,my-window-foreground :background ,my-window-background))
;   (set-face-attribute 'fringe nil :foreground my-window-foreground :background my-window-background)
;   (set-face-attribute 'mode-line nil :foreground my-modeline-foreground :background my-modeline-background)
;   (set-face-attribute 'mode-line nil :box `(:line-width 4 :color ,(face-attribute 'mode-line :background)))
;   (set-face-attribute 'mode-line-inactive nil :foreground my-modeline-foreground :background my-modeline-inactive-background)
;   (set-face-attribute 'mode-line-inactive nil :box `(:line-width 4 :color ,(face-attribute 'mode-line-inactive :background)))
;   (buffer-face-mode 1)
;
; Issues:
; - fringe in minibuffer
; - Have to M-x buffer-face-mode RET in every buffer. As far as I know there is no hook that runs
;   on buffer creation.
; - Emacs think the buffer background is dark, so it chooses a dark color theme which clashes
;   against the light background.
; - This messes with the window divider line color, which turns to white and is indistinguishable
;   against the white buffers.
;
; I still think this is a cool idea, but it very much seems to go against the design of emacs.
;
; Note that [doom](https://github.com/hlissner/emacs-doom-themes/tree/screenshots#doom-one)
; seems to have figured this out. It appears to have a "sidebar" buffer with the same color as
; minibuffer/echo area, and all other buffers are a little lighter.
;
; Also check out https://github.com/vic/color-theme-buffer-local/blob/master/color-theme-buffer-local.el,
; which seems to use face-remap (though it's specially applied to individual buffers).
;
; Actually, it looks like [solaire-mode](https://github.com/hlissner/emacs-solaire-mode) does what I
; want. It's apparently based on face-remap-*. It has a weird configuration system that's
; specialized for doom, so I'd like to implement a simpler version myself, but I don't know enough
; elisp to understand how the code works.

;; which-key
;; modalka? boon?
