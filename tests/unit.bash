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

@test "absolute moveto d" {
   test_svgpath '<svg><path><moveto d="1,1" /></path></svg>'
   assert_svgpath "M1,1"
}

@test "relative moveto d using 'relative'" {
   test_svgpath '<svg><path><moveto type="relative" d="1,1" /></path></svg>'
   assert_svgpath "m1,1"
}

@test "relative moveto d using 'rel'" {
   test_svgpath '<svg><path><moveto type="rel" d="1,1" /></path></svg>'
   assert_svgpath "m1,1"
}

@test "lineto d" {
   test_svgpath '<svg><path><lineto d="7,1" /></path></svg>'
   assert_svgpath "L7,1"
}

@test "lineto relative d using 'relative'" {
   test_svgpath '<svg><path><lineto type="relative" d="1,1" /></path></svg>'
   assert_svgpath "l1,1"
}

@test "lineto relative d using 'rel'" {
   test_svgpath '<svg><path><lineto type="rel" d="1,1" /></path></svg>'
   assert_svgpath "l1,1"
}

@test "lineto y vertical" {
   test_svgpath '<svg><path><lineto y="-500" /></path></svg>'
   assert_svgpath "V-500"
}

@test "lineto x horizontal" {
   test_svgpath '<svg><path><lineto x="8" /></path></svg>'
   assert_svgpath "H8"
}

@test "lineto x and y " {
   test_svgpath '<svg><path><lineto x="77" y="88" /></path></svg>'
   assert_svgpath "L77,88"
   test_svgpath '<svg><path><lineto y="7" x="5" /></path></svg>'
   assert_svgpath "L5,7"
}

@test "lineto relative y vertical" {
   test_svgpath '<svg><path><lineto type="rel" y="5" /></path></svg>'
   assert_svgpath "v5"
}

@test "lineto relative x horizontal" {
   test_svgpath '<svg><path><lineto type="rel" x="7" /></path></svg>'
   assert_svgpath "h7"
}

@test "lineto relative x and y " {
   test_svgpath '<svg><path><lineto type="rel" y="-10" x="7" /></path></svg>'
   assert_svgpath "l7,-10"
}

@test "moveto x and y " {
   test_svgpath '<svg><path><moveto x="-7" y="-8" /></path></svg>'
   assert_svgpath "M-7,-8"
}

@test "moveto relative x and y " {
   test_svgpath '<svg><path><moveto type="rel" y="20" x="10" /></path></svg>'
   assert_svgpath "m10,20"
}

@test "closepath" {
   test_svgpath '<svg><path><closepath /></path></svg>'
   assert_svgpath "z"
}

