import std/[os, strutils]

import zerocstringtostring

template printAddress(name: static[string], p: pointer) =
  write(stdout, "$2 => $1" % [name, $cast[uint](p)], "\n")

proc procstrlen(s: string): int =
  printAddress("procstrlen.s", unsafeAddr s[0])

  len(s)

proc procstr(s: string) =
  printAddress("procstr.s", unsafeAddr s[0])

  echo procstrlen(s)

proc main() =
  zeroToString(cstring(paramStr(1)), fake)

  printAddress("fake", unsafeAddr fake[0])

  procstr(fake)

  # fake = "immutable" # Error: 'fake' cannot be assigned to

main()
