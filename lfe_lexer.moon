howl.util.lpeg_lexer ->
  comment = capture 'comment', any {
    span ';', eol
    P'#|' * scan_to '|#'
  }

  str = capture 'string', P'#'^-1 * span '"', '"'

  decimal = P('-')^-1 * digit^1

  delimiter = any { space, P'\n', S'()[]' }

  number = capture 'number', word {
    decimal -- decimal
    P'#' * ((S'Bb' * P'*') + S'Bb' + P'*') * P'-'^-1 * S'01'^1 -- binary
    P'#' * S'Oo' * P'-'^-1 * R('07')^1 -- octal
    P'#' * S'Dd' * decimal -- explicit decimal
    P'#' * S'Xx' * P'-'^-1 * R('AF','af','09')^1 -- hexadecimal
    P'#' * (R'09'^1)^-2 * S'Rr' * (1 - delimiter)^1 -- super simplified explicit base
    P'#\\' * S'Xx' * P'-'^-1 * R('AF','af','09')^1 -- hexadecimal character
    P'#\\' * (1 - delimiter) -- character
    S'+-'^-1 * digit^1 * P'.' * digit^1 * (S'eE' * P('-')^-1 * digit^1)^-1
  }

  any {
    number
    comment
    str
  }
