# -*- coding: utf-8 -*-

# A module containing a method to slim down a UTF-8 String
#
# It handles UTF8 characters, such as CJK (Zenkaku) spaces
# and offers many choices how to slim down a character string.
#
# There are 3 ways to use the method {SlimString#slim_string}
#
# (1) Simply call it in a full path
#       SlimString.slim_string("abc", trim: false)
# (2) Include in your class/module (or top level), and you can
#     use it like: slim_string("abc", trim: false)
# (3) Include it in String class like and you can used it like
#     an instance method.
#       class String
#         include SlimString
#       end
#       "abc".slim_string(trim: false)
#
module SlimString

  # Default options of operations for {#slim_string}, which processes
  # in this order if specified.
  DEF_SLIM_OPTIONS = {
    :delete_newlines => false,  # Delete all new lines (\f\n\r\v) (useful for Japanese text, unless more than 1 alphabet word are split across 2 lines).
    :convert_spaces  => false,  # Convert any sort of spaces (including new lines) into an ASCII space.
    :convert_blanks  => true,   # Convert all blanks (=spaces except kind of new lines) into an ASCII space.
    :truncate_spaces => false,  # Truncate any consecutive spaces into one.
    :truncate_blanks => true,   # Truncate any consecutive blanks into (the last) one.
    :truncate_triple_newlines => false, # Truncate 3 or more consecutive newlines into 2.
    :delete_blanks   => false,  # Simply delete all blanks excluding new lines (n.b., "a top" and "atop" are regarded identical.
    :strip       => true,   # Ruby strip; strip spaces including new lines at the head and tail.
    :trim_blanks => false,  # strip blanks (but new lines) at the tail.
    :trim        => true,   # Trim the tail to strip any spaces including new lines at the tail.
  }

  # Returns a slimmed down string
  #
  # @option str [String] Mandatory unless you use it as an instance
  #    method of String class.
  # @param delete_newlines: [Boolean] (Def: false) Delete all new lines
  #    (\f\n\r\v) (maybe useful for Japanese text, unless more than 1
  #    alphabet word are split across 2 lines).
  # @param convert_spaces: [Boolean] (Def: false) Convert any sort of
  #    spaces (including new lines) into an ASCII space.
  # @param convert_blanks: [Boolean] (Def: true) Convert all blanks
  #    (=spaces except kind of new lines) into an ASCII space.
  # @param truncate_spaces: [Boolean] (Def: false) Truncate any
  #    consecutive spaces into one.
  # @param truncate_blanks: [Boolean] (Def: true) Truncate any
  #    consecutive blanks into (the last) one.
  # @param truncate_triple_newlines: [Boolean] (Def: false) Truncate
  #    3 or more consecutive newlines into 2.
  # @param delete_blanks: [Boolean] (Def: false) Simply delete all blanks 
  #   excluding new lines (n.b., "a top" and "atop" are regarded identical.
  # @param strip: [Boolean] (Def: true) Ruby strip; strip spaces
  #   including new lines at the head and tail.
  # @param trim_blanks: [Boolean] (Def: false) strip blanks (but new lines)
  #   at the tail.
  # @param trim: [Boolean] (Def: true) Trim the tail to strip any spaces
  #   including new lines at the tail.
  # @return [String]
  # @raise [ArgumentError] Unless you include this module from
  #    String class and use it as an instance method, the first
  #    argument is mandatory.
  def slim_string(str=nil, **opts)
    ret = (str || self).dup
    raise ArgumentError, 'first argument is mandatory and must be String-like.' if !ret.respond_to? :gsub!

    DEF_SLIM_OPTIONS.merge(opts).each_pair do |ek, tf|
      next if !tf
      case ek
      when :delete_newlines
           ret.tr! "\f\n\r\v", "" # ASCII Formfeed (FF), Linefeed (LF), Carriage Return (CR), Vertical Tab (VT)
      when :convert_spaces
           ret.gsub!(/[[:space:]]/,  ' ')
      when :convert_blanks
           ret.gsub!(/[[:blank:]]/,  ' ')
      when :truncate_spaces
           ret.gsub!(/([[:space:]])+/, '\1')
      when :truncate_blanks
           ret.gsub!(/([[:blank:]])+/, '\1')
      when :truncate_triple_newlines 
           ret.gsub!(/([\f\n\r\v]){3,}/, '\1\1')
      when :delete_blanks
           ret.gsub!(/[[:blank:]]+/, "")
      when :strip
           ret.strip!
      when :trim_blanks
           ret.gsub!(/[[:blank:]]+\z/, "")
      when :trim
           ret.gsub!(/([[:space:]])+\z/, "")
      else
        raise ArgumentError, 'Invalid optional argument: '+tf.inspect
      end
    end
    ret
  end
end

module SlimString
  extend self
end

