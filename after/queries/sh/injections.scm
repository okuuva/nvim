; extends

; ============================================================================
; #USAGE comments - KDL injection
; ============================================================================
; This injection captures consecutive comment lines starting with "#USAGE " or
; "# [USAGE]" and treats them as a single KDL code block for syntax
; highlighting.
;
; #USAGE format
((comment) @injection.content
  (#lua-match? @injection.content "^#USAGE ")
  ; Extend the range one byte to the right, to include the trailing newline.
  ; see https://github.com/neovim/neovim/discussions/36669#discussioncomment-15054154
  (#offset! @injection.content 0 7 0 1)
  (#set! injection.combined)
  (#set! injection.language "kdl"))

; #[USAGE] format
((comment) @injection.content
  (#lua-match? @injection.content "^#%[USAGE%] ")
  (#offset! @injection.content 0 9 0 1)
  (#set! injection.combined)
  (#set! injection.language "kdl"))

; # [USAGE] format
((comment) @injection.content
  (#lua-match? @injection.content "^# %[USAGE%] ")
  (#offset! @injection.content 0 10 0 1)
  (#set! injection.combined)
  (#set! injection.language "kdl"))

; NOTE: on neovim >= 0.12, you can use the multi node pattern instead of
; combining injections:
;
; ((comment)+ @injection.content
;   (#lua-match? @injection.content "^#USAGE ")
;   (#offset! @injection.content 0 7 0 1)
;   (#set! injection.language "kdl"))
;
; this is the preferred way as combined injections have multiple
; limitations:
; https://github.com/neovim/neovim/issues/32635
