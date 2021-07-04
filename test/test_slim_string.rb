# -*- encoding: utf-8 -*-

# @author Masa Sakano (Wise Babel Ltd)

#require 'open3'
require 'slim_string'

$stdout.sync=true
$stderr.sync=true
# print '$LOAD_PATH=';p $LOAD_PATH

#################################################
# Unit Test
#################################################

gem "minitest"
# require 'minitest/unit'
require 'minitest/autorun'

SlimString.slim_string("a\nb\f\vc\r\n d")

include SlimString

class String
  include SlimString
end

class TestSlimStringClass < MiniTest::Test
  T = true
  F = false
  SCFNAME = File.basename(__FILE__)
  # EXE = "%s/../bin/%s" % [File.dirname(__FILE__), File.basename(__FILE__).sub(/^test_(.+)\.rb/, '\1')]

  def setup
  end

  def teardown
  end

  def test_slim_string
    z = "\u3000"
    s  = "   a\nb\f\vc\r\n "+z*3+"d \r\n\r\n"
    ex = "   abc "+z*3+"d "
    assert_equal ex, slim_string(s, delete_newlines: true, convert_blanks: false, truncate_blanks: false, strip: false, trim: false)
    ex = "   abc    d "
    assert_equal ex, slim_string(s, delete_newlines: true,                        truncate_blanks: false, strip: false, trim: false)
    ex =   " abc"+ z+  "d "
    assert_equal ex, slim_string(s, delete_newlines: true, convert_blanks: false,                         strip: false, trim: false)
    ex =    "abc "+z*3+"d"
    assert_equal ex, slim_string(s, delete_newlines: true, convert_blanks: false, truncate_blanks: false,               trim: false)
    ex = "   abc "+z*3+"d"
    assert_equal ex, slim_string(s, delete_newlines: true, convert_blanks: false, truncate_blanks: false, strip: false)
    ex = "   a\nb\f\vc\r\n "+z*3+"d"
    assert_equal ex, slim_string(s,                        convert_blanks: false, truncate_blanks: false, strip: false)
    ex =   " a\nb\f\vc\r\n"+ z+  "d"
    assert_equal ex, slim_string(s,                        convert_blanks: false,                         strip: false)
    ex =   " a\nb\f\vc\r\n d"
    assert_equal ex, slim_string(s,                                                                       strip: false)
    ex =    "a\nb\f\vc\r\n d"
    assert_equal ex, slim_string(s)
    ex =    "a b c d"
    assert_equal ex, slim_string(s, convert_spaces: true)
    ex =    "a\nb\vc"+       z+  "d"
    assert_equal ex, slim_string(s,                        convert_blanks: false, truncate_spaces: true)
    ex = "   a\nb\f\vc\r\n "+z*3+"d \n\n"
    assert_equal ex, slim_string(s,                        convert_blanks: false, truncate_blanks: false, truncate_triple_newlines: true, strip: false, trim: false), "inspect="+slim_string(s, convert_blanks: false, truncate_blanks: false, truncate_triple_newlines: true, strip: false, trim: false).inspect
    ex =    "a\nb\f\vc\r\n"+     "d"
    assert_equal ex, slim_string(s,                        convert_blanks: false, truncate_blanks: false, delete_blanks: true, strip: false)
    ex = "   a\nb\f\vc\r\n "+z*3+"d \r\n\r\n"
    assert_equal ex, slim_string(s,                        convert_blanks: false, truncate_blanks: false, strip: false, trim_blanks: true, trim: false)

    assert_equal s,  slim_string(s, **(DEF_SLIM_OPTIONS.map{|k,v| [k, false]}).to_h)
    assert_equal s.strip, slim_string(s, **(DEF_SLIM_OPTIONS.map{|k,v| [k, false]}).to_h.merge({strip: true}))

    assert_raises(ArgumentError){ slim_string(s, dummy: true) }

    assert_equal "a\nb\f\vc\r\n d", s.slim_string()
    assert_equal "a\nb\f\vc\r\n d", SlimString.slim_string(s)
    assert_raises(ArgumentError){   SlimString.slim_string() }
  end

  def test_slim_string_in_doc
    s = " \tA  B \n"
    assert_equal s.strip, slim_string(s, **(DEF_SLIM_OPTIONS.map{|k,v| [k, false]}).to_h.merge({strip: true}))
    assert_equal "A  B",  slim_string(s, **(DEF_SLIM_OPTIONS.map{|k,v| [k, false]}).to_h.merge({strip: true}))

    to_cancel = DEF_SLIM_OPTIONS.map{|k,v| [k, false]}.to_h
    assert_equal s.strip, slim_string(s, **(to_cancel.merge({strip: true})))

    s  = "\nab  cd\n ef \t gh \n\n"
    ex =   "ab cd\n ef gh"
    assert_equal ex, slim_string(s)
    ex =   "ab cd ef gh"
    assert_equal ex, slim_string(s, convert_spaces: true)
    ex =   "ab  cd\n ef   gh"
    assert_equal ex, slim_string(s, truncate_blanks: false)
  end
end # class TestUnitSlimString < MiniTest::Test

