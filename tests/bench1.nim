import std/[os, osproc, strscans, strutils]

proc repeat(c: char, times: int): string =
  if times > 0:
    result = strutils.repeat(c, times)

proc media(exe: string, str: string, x: int): tuple[average: float, sum, better, worse: int64, times: int] =
  var sum = 0'i64
  var times = 0
  var better = high(int64)
  var worse = low(int64)

  for _ in 1 .. x:
    let (output, exitCode) = execCmdEx(exe & " " & str)

    if exitCode == 0:
      var ticks: int

      for line in splitLines(output):
        if scanf(line, "ticks: $i", ticks):
          inc(times)

          sum = sum + ticks.int64

          better = min(better, ticks.int64)
          worse = max(worse, ticks.int64)

  result = (sum / times, sum, better, worse, times)

var len = 1

if paramCount() == 1:
  len = parseInt(paramStr(1))

var s: string

if len == 0:
  s = "0"
  len = 0
else:
  s = repeat('a', len)
  len = len(s)

let fake = media("./case1", s, 100)
let str = media("./case2", s, 100)
echo "len: ", len
echo fake
echo str
echo str.average / fake.average, "x"
