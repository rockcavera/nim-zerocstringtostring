import std/[os, random, strutils]

import zerocstringtostring

import bench

randomize()

template printAddress(name: static[string], p: pointer) =
  write(stdout, "$2 => $1" % [name, $cast[uint](p)])

proc randomPhrase(): string =
  const words = split("zero copy test when transforming cstring to string", ' ')

  for _ in 1 .. rand(2..10):
    add(result, words[rand(0..high(words))])

proc test(cstr: cstring) =
  when defined(case1):
    let fakeI = startBench()
    zeroToString(cstr, fake)
    let fakeE = endBench()
    echo "ticks: ", fakeE - fakeI
    if len(fake) > 0:
      printAddress("fake[0]", addr fake[0])
      write(stdout, " => ", fake, "\n")

  when defined(case2):
    let strI = startBench()
    let str = $cstr
    let strE = endBench()
    echo "ticks: ", strE - strI
    if len(str) > 0:
      printAddress("str[0]", addr str[0])
      write(stdout, " => ", str, "\n")

proc main() =
  var origin: string

  if paramCount() == 0:
    origin = randomPhrase()
  elif paramStr(1) != "0":
    for i in 1 .. paramCount():
      add(origin, paramStr(i))

  if len(origin) > 0:
    printAddress("origin[0]", addr origin[0])
    write(stdout, " => ", origin, "\n")

  test(cstring(origin))

main()
