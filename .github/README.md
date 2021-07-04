
# SlimString - Ruby method to slim down UTF-8 character strings

## Summary

Module {SlimString} contains a single method of the same (but snake-case) name
`SlimString#slim_string`, which offers functionality to "slim down" character
String, such as truncating extra spaces, with many options you can specify. It
fully takes into account *UTF8 characters* like CJK Zenkaku spaces (U+3000).

The full package of this module is found in [SlimString Ruby Gems page](http://rubygems.org/gems/slim_string) (with document created from source
annotation with yard) and in
[Github](https://github.com/masasakano/slim_string)

## Description

The main (and only) method `slim_string` accepts a String (either as the
receiver or first argument) and returns a slimmed-down String.

In default, the returned String is processed as:

1.  all the "weird" spaces like TAB characters are converted into ASCII white
    spaces (U+0020),
2.  all the consecutive white spaces but new-line characters are truncated
    into a single white space,
3.  all the consecutive white spaces and new-line characters at the beginning
    and tail are stripped.


You can specify more **aggressive** or **tamer** processing, specifying
suitable options (see below).

### How to use it?

First,

```ruby
require 'slim_string'
```

Then,

1.  Simply call it in a full path (it is extended and so you can call it in
    this way.

    ```ruby
    SlimString.slim_string("\nabc\n\n", strip: false)
      # => "\nabc"
    ```

2.  "include" it in your class/module (or top level), and you can use it
    without the module name.

    ```ruby
    include SlimString
    slim_string("\nabc\n\n", strip: false)
      # => "\nabc"
    ```

3.  "include" it in `String` class like and you can use it as an instance
    method.

    ```ruby
    class String
      include SlimString
    end

    "\nabc\n\n".slim_string(strip: false)
      # => "\nabc"
    ```


### Class constant

<dl>
<dt>DEF_SLIM_OPTIONS</dt>
<dd>   Hash containing the default option values. The processing order in
    &lt;tt&gt;slim_string&lt;/tt&gt; follows that of the keys of this constant</dd>
</dl>



### Options (keyword options)

All options (aka, arguments) are Boolean. The given string is processed in
this order regardless how you do or do not specify them.

Here, the terms **space** and **blank** follows the Ruby Regexp convention,
i.e., **spaces** are non-visible characters including newlines, whereas
**blanks** are **spaces** minus new-line characters (\\f\\n\\r\\v; ASCII Formfeed
(FF), Linefeed (LF), Carriage Return (CR), Vertical Tab (VT)).

<dl>
<dt>delete_newlines</dt>
<dd>   (Def: false) Delete all new lines (\\f\\n\\r\\v) (maybe useful for Japanese
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
    and &quot;atop&quot; are regarded identical).</dd>
<dt>strip</dt>
<dd>   (Def: true) Ruby strip; strip spaces including new lines at the head and
    tail.</dd>
<dt>trim_blanks</dt>
<dd>   (Def: false) strip blanks (but new lines) at the tail.</dd>
<dt>trim</dt>
<dd>   (Def: true) Trim the tail to strip any spaces including new lines at the
    tail</dd>
</dl>



## Examples

Suppose you include `SlimString` (see "How to use it?" above for detail).

In default (see the beginning of Description):

```ruby
s  = "\nab  cd\n ef \t gh \n\n"
slim_string(s)
  # => "ab cd\n ef gh"
```

To preserve consecutive white spaces, but otherwise as in the default, do:

```ruby
slim_string(s, truncate_blanks: false)
  # => "ab  cd\n ef   gh"
```

To convert all the newlines into white spaces, but otherwise as in the
default, do:

```ruby
slim_string(s, convert_spaces: true)
  # => "ab cd ef gh"
```

To cancel all the default options and specify your own (n.b., here, Hash#map
is available in Ruby 2.1 (released in 2013) and above), do as follows, for
example. In this case, it is identical to Ruby's `String#strip`

```ruby
s = " \tA  B \n"
to_cancel = DEF_SLIM_OPTIONS.map{|k,v| [k, false]}.to_h
slim_string(s, **(to_cancel.merge({strip: true})))
  # => "A  B"  (== s.strip)
```

where `DEF_SLIM_OPTIONS` is a class constant `SlimString::DEF_SLIM_OPTIONS` 

The test suite under `test/` directory contains many more examples.

## Install

This library requires [Ruby](http://www.ruby-lang.org) Version 2.0 or above.

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
<dd>   MIT</dd>
</dl>



---

