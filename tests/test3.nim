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
