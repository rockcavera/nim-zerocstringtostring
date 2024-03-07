when not defined(nimsuggest) and not defined(nimv2):
  {.fatal: "`zerocstringtostring` implementation for nimv2 only".}

type
  FakeNimStrPayloadBase = object
    cap: int

  FakeNimStringV2 = object
    len: int
    p: pointer

const nimStrPayloadBaseSize = sizeof(FakeNimStrPayloadBase).uint

proc zeroToStringImpl(cstr: cstring, len: int, nimstr: var FakeNimStringV2) {.raises: [].} =
  if len <= 0:
    nimstr = FakeNimStringV2(len: 0, p: nil)
  else:
    let
      pucstr = cast[uint](unsafeAddr cstr[0])
      puFakePayload = puCstr - nimStrPayloadBaseSize

    nimstr = FakeNimStringV2(len: len, p: cast[pointer](puFakePayload))

proc zeroToString*(cstr: cstring): string {.noinit, inline, raises: [].} =
  var len = if cstr == nil: 0
            else: len(cstr)

  let str = unsafeAddr result
  zeroToStringImpl(cstr, len, cast[ptr FakeNimStringV2](str)[])

proc zeroNullify*(nimstr: var FakeNimStringV2) {.inline, raises: [].} =
  nimstr = FakeNimStringV2(len: 0, p: nil)

template zeroToString*(cstr: cstring, identifier: untyped) =
  let identifier {.noinit.} = zeroToString(cstr)
  defer:
    zeroNullify(cast[ptr FakeNimStringV2](unsafeAddr identifier)[])
