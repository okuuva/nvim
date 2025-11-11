; extends

; ============================================================================
; #USAGE comments - KDL injection
; ============================================================================
; This injection captures consecutive comment lines starting with "#USAGE "
; or "# [USAGE]" and treats them as a single KDL code block for syntax highlighting.
;
; Example:
;   #USAGE arg "<environment>" help="Deployment environment" {
;   #USAGE   choices "dev" "staging" "prod"
;   #USAGE }
;
; The above will be highlighted as KDL syntax.

; Match #USAGE comments - each line is treated as a separate KDL fragment
; NOTE: This won't properly parse multi-line KDL structures (like blocks with {})
; but will at least highlight individual KDL statements correctly
; The (#offset!) directive skips the "#USAGE " prefix (7 characters) from the source
((comment) @injection.content
  (#lua-match? @injection.content "^#USAGE ")
  (#offset! @injection.content 0 7 0 0)
  (#set! injection.language "kdl"))

; Also support # [USAGE] format (used in mise)
; The (#offset!) directive skips the "# [USAGE] " prefix (10 characters)
((comment) @injection.content
  (#lua-match? @injection.content "^# %[USAGE%] ")
  (#offset! @injection.content 0 10 0 0)
  (#set! injection.language "kdl"))

; Also support #[USAGE] format (no space)
((comment) @injection.content
  (#lua-match? @injection.content "^#%[USAGE%] ")
  (#offset! @injection.content 0 9 0 0)
  (#set! injection.language "kdl"))

