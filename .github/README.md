
# SlimString - Ruby method to slim down UTF-8 character strings

## Summary

Module {SlimString} contains a single method of the same (but snake-case) name
`SlimString#slim_string`, which offers functionality to "slim down" character
String, such as truncating extra spaces with many options you can select. It
fully takes into account *UTF-8 characters* like CJK Zenkaku spaces.

The full package of this class is found in
[Github](https://github.com/masasakano/slim_string)

## Description

### How to use it?

1.  Simply call it in a full path (it is extended and so you can call it in
    this way.


    SlimString.slim_string("\nabc\n\n", strip: false) # => "\nabc"

1.  Include in your class/module (or top level), and you can use it without
    the module name.


    include SlimString
    slim_string("\nabc\n\n", strip: false) # => "\nabc"

1.  Include it in `String` class like and you can use it as an instance
    method.


    class String
      include SlimString
    end

    "\nabc\n\n".slim_string(trim: false) # => "\nabc"

### Options

All options (aka, arguments) are Boolean. The given string is processed in
this order regardless how you do or do not specify them.

<dl>
<dt>delete_newlines</dt>
<dd>   (Def: false) Delete all new lines (f\n\r\v) (maybe useful for Japanese
    text, unless more than 1 alphabet word are split across 2 lines).</dd>
<dt>convert_spaces</dt>
<dd>   (Def: false) Convert any sort of spaces (including new lines) into an
    ASCII space.</dd>
<dt>convert_blanks</dt>
<dd>   (Def: true) Convert all blanks (=spaces except kind of new lines) into an
    ASCII space.</dd>
<dt>truncate_spaces</dt>
<dd>   (Def: false) Truncate any consecutive spaces into one.</dd>
<dt>truncate_blanks</dt>
<dd>   (Def: true) Truncate any consecutive blanks into (the last) one.</dd>
<dt>truncate_triple_newlines</dt>
<dd>   (Def: false) Truncate 3 or more consecutive newlines into 2.</dd>
<dt>delete_blanks</dt>
<dd>   (Def: false) Simply delete all blanks excluding new lines (n.b., &quot;a top&quot;
    and &quot;atop&quot; are regarded identical.</dd>
<dt>strip</dt>
<dd>   (Def: true) Ruby strip; strip spaces including new lines at the head and
    tail.</dd>
<dt>trim_blanks</dt>
<dd>   (Def: false) strip blanks (but new lines) at the tail.</dd>
<dt>trim</dt>
<dd>   (Def: true) Trim the tail to strip any spaces including new lines at the
    tail</dd>
</dl>



## Install

This script requires [Ruby](http://www.ruby-lang.org) Version 2.0 or above. 
Also, all this library depends on [SubObject (sub_object)](https://rubygems.org/gems/sub_object), which you can find in
RubyGems.

## Developer's note

The source code is maintained also in
[Github](https://github.com/masasakano/slim_string) with no intuitive
interface for annotation but with easily-browsable
[ChangeLog](https://github.com/masasakano/slim_string/blob/master/ChangeLog)

### Tests

The Ruby codes under the directory `test/` are the test scripts. You can run
them from the top directory as `ruby test/test_****.rb` or simply run `make
test` or `rake test`.

## Known bugs and Todo items

*   None


## Copyright

<dl>
<dt>Author</dt>
<dd>   Masa Sakano &lt; info a_t wisebabel dot com &gt;</dd>
<dt>Versions</dt>
<dd>   The versions of this package follow Semantic Versioning (2.0.0)
    http://semver.org/</dd>
<dt>License</dt>
<dd>   MI</dd>
</dl>



