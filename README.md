# nim-zerocstringtostring
Turns `cstring` into a `string` without allocating and copying. The result must be a "read-only" `string`, that is, defined with `let`.

# Install
Run the Nimble install command

`nimble install https://github.com/rockcavera/nim-zerocstringtostring.git`

# Basic usage

```nim
import zerocstringtostring

let cstr = cstring"zero copy test when transforming cstring to string"

let fakestring = zeroToString(cstr) # Define, whenever possible, with `let`, to
                                    # avoid performing a disastrous operation.

echo len(fakestring)
echo fakestring

zeroNullify(fakestring) # After using the read-only `string`, use
                        # `zeroNullify()` to prevent memory from being
                        # deallocated by destructors. Otherwise you will receive
                        # this error: "SIGSEGV: Illegal storage access. (Attempt
                        # to read from nil?)"
```

In scopes other than global, you can use the template `zeroToString(cstr: cstring, identifier: untyped)`, which adds a `defer` statement to automatically perform `zeroNullify()`.
```nim
import zerocstringtostring

proc test() =
  let cstr = cstring"zero copy test when transforming cstring to string"

  zeroToString(cstr, fakestring) # Defines `fakestring` with `let`.

  echo len(fakestring)
  echo fakestring

test()
```