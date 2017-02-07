#!/usr/bin/env bats

load helpers/assertions/all

test_svgpath ()
{
   out=$(echo "$1" | xsltproc dsvg.xsl -)
   output=$(echo "$out" | xmllint --xpath "svg/path" - )
   export output
}

assert_svgpath ()
{
   assert_output "<path d=\"$1\"/>"
}

@test "dsvg.xsl can processes an empty svg" {
   INPUT="<svg></svg>"
   echo $INPUT | xsltproc build/dsvg.xsl -
}

@test "translates absolute moveto with data" {
   test_svgpath '<svg><path><moveto d="1,1" /></path></svg>'
   assert_svgpath "M1,1"
}

@test "translates relative moveto with data" {
   test_svgpath '<svg><path><moveto type="relative" d="1,1" /></path></svg>'
   assert_svgpath "m1,1"
}

@test "translates absolute lineto with data" {
   test_svgpath '<svg><path><lineto d="1,1" /></path></svg>'
   assert_svgpath "L1,1"
}

@test "translates absolute lineto with coordinates" {
   skip "x and y coords not implemented yet"
   test_svgpath '<svg><path><lineto x="1" y="2" /></path></svg>'
   assert_svgpath "L1,2"
   test_svgpath '<svg><path><lineto y="7" x="5" /></path></svg>'
   assert_svgpath "L5,7"
}

@test "translates relative lineto with data" {
   skip "not implemented"
   test_svgpath '<svg><path><lineto type="relative" d="1,1" /></path></svg>'
   assert_svgpath "l1,1"
}

