import zerocstringtostring

proc test() =
  let cstr = cstring"zero copy test when transforming cstring to string"

  zeroToString(cstr, fakestring) # Defines `fakestring` with `let`.

  echo len(fakestring)
  echo fakestring

test()
