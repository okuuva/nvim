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

; ============================================================================
; #MISE comments - TOML injection
; ============================================================================
; This injection captures consecutive comment lines starting with "#MISE "
; or "# [MISE]" or "#[MISE]" and treats them as a single TOML code block for syntax highlighting.
;
; Example:
;   #MISE [tools]
;   #MISE node = "20"
;   #MISE python = "3.11"
;
; The above will be highlighted as TOML syntax.

; Match #MISE comments - each line is treated as a separate TOML fragment
; The (#offset!) directive skips the "#MISE " prefix (6 characters) from the source
((comment) @injection.content
  (#lua-match? @injection.content "^#MISE ")
  (#offset! @injection.content 0 6 0 0)
  (#set! injection.language "toml"))

; Also support # [MISE] format
; The (#offset!) directive skips the "# [MISE] " prefix (9 characters)
((comment) @injection.content
  (#lua-match? @injection.content "^# %[MISE%] ")
  (#offset! @injection.content 0 9 0 0)
  (#set! injection.language "toml"))

; Also support #[MISE] format (no space)
; The (#offset!) directive skips the "#[MISE] " prefix (8 characters)
((comment) @injection.content
  (#lua-match? @injection.content "^#%[MISE%] ")
  (#offset! @injection.content 0 8 0 0)
  (#set! injection.language "toml"))

