proc sync() {.inline, raises: [].} =
  asm """"cpuid" : : : "%rax", "%rbx", "%rcx", "%rdx""""

proc rdtsc(): uint64 {.inline, noinit, raises: [].} =
  var
    a {.noinit.}: uint32
    d {.noinit.}: uint32

  asm """"rdtsc" : "=a" (`a`), "=d" (`d`)"""

  uint64(a) or (uint64(d) shl 32)


proc rdtscp(): uint64 {.inline, noinit, raises: [].} =
  var
    a {.noinit.}: uint32
    d {.noinit.}: uint32

  asm """"rdtscp" : "=a" (`a`), "=d" (`d`)"""

  uint64(a) or (uint64(d) shl 32)

template startBench*(): uint64 =
  sync()
  rdtsc()

template endBench*(): uint64 =
  let ret = rdtscp()
  sync()
  ret

when isMainModule:
  let i = startBench()

  # CODE HERE

  let e = endBench()

  echo e - i
