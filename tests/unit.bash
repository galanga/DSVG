#!/usr/bin/env bats

load helpers/assertions/all

test_svgpath ()
{
   out=$(echo "$1" | xsltproc dsvg.xsl -)
   output=$(echo "$out" | xmllint --xpath "svg/path" - )
   export output
}

invoke_xslt ()
{
   export output=$(echo "$1" | xsltproc dsvg.xsl - )
}

assert_svgpath ()
{
   assert_output "<path d=\"$1\"/>"
}

assert_xpath ()
{
   output=$(echo "$output" | xmllint --xpath "$1" - )
   assert_output "$2"
}

@test "dsvg.xsl can processes an empty svg" {
   INPUT="<svg></svg>"
   echo $INPUT | xsltproc build/dsvg.xsl -
}

@test "path moveto absolute d" {
   test_svgpath '<svg><path><moveto d="1,1" /></path></svg>'
   assert_svgpath "M1,1"
}

@test "path moveto relative d using 'relative'" {
   test_svgpath '<svg><path><moveto type="relative" d="1,1" /></path></svg>'
   assert_svgpath "m1,1"
}

@test "path moveto relative d using 'rel'" {
   test_svgpath '<svg><path><moveto type="rel" d="1,1" /></path></svg>'
   assert_svgpath "m1,1"
}

@test "path lineto d" {
   test_svgpath '<svg><path><lineto d="7,1" /></path></svg>'
   assert_svgpath "L7,1"
}

@test "path lineto relative d using 'relative'" {
   test_svgpath '<svg><path><lineto type="relative" d="1,1" /></path></svg>'
   assert_svgpath "l1,1"
}

@test "path lineto relative d using 'rel'" {
   test_svgpath '<svg><path><lineto type="rel" d="1,1" /></path></svg>'
   assert_svgpath "l1,1"
}

@test "path lineto y vertical" {
   test_svgpath '<svg><path><lineto y="-500" /></path></svg>'
   assert_svgpath "V-500"
}

@test "path lineto x horizontal" {
   test_svgpath '<svg><path><lineto x="8" /></path></svg>'
   assert_svgpath "H8"
}

@test "path lineto x and y " {
   test_svgpath '<svg><path><lineto x="77" y="88" /></path></svg>'
   assert_svgpath "L77,88"
   test_svgpath '<svg><path><lineto y="7" x="5" /></path></svg>'
   assert_svgpath "L5,7"
}

@test "path lineto relative y vertical" {
   test_svgpath '<svg><path><lineto type="rel" y="5" /></path></svg>'
   assert_svgpath "v5"
}

@test "path lineto relative x horizontal" {
   test_svgpath '<svg><path><lineto type="rel" x="7" /></path></svg>'
   assert_svgpath "h7"
}

@test "path lineto relative x and y " {
   test_svgpath '<svg><path><lineto type="rel" y="-10" x="7" /></path></svg>'
   assert_svgpath "l7,-10"
}

@test "path moveto d" {
   test_svgpath '<svg><path><moveto d="123,456" /></path></svg>'
   assert_svgpath "M123,456"
}

@test "path moveto x and y " {
   test_svgpath '<svg><path><moveto x="-7" y="-8" /></path></svg>'
   assert_svgpath "M-7,-8"
}

@test "path moveto relative d" {
   test_svgpath '<svg><path><moveto type="rel" d="123,456" /></path></svg>'
   assert_svgpath "m123,456"
}

@test "path moveto relative x and y " {
   test_svgpath '<svg><path><moveto type="rel" y="20" x="10" /></path></svg>'
   assert_svgpath "m10,20"
}

@test "path closepath" {
   test_svgpath '<svg><path><closepath /></path></svg>'
   assert_svgpath "z"
}

@test "path pathseg concatenate d attributes" {
IN=$(cat <<'EOF'
<svg>
<path>
    <pathseg d="M100,200" />
    <pathseg d="C100,100 250,100 250,200" />
    <pathseg d="S400,300 400,200" />
</path>
</svg>
EOF
)
   test_svgpath "$IN"
   assert_svgpath "M100,200C100,100 250,100 250,200S400,300 400,200"
}

@test "path example orthagonal path" {
IN=$(cat <<'EOF'
<svg>
<path>
<moveto x="50" y="375" />
<lineto x="150" />
<lineto y="325" />
<lineto x="250" />
<lineto y="375" />
<lineto x="350" />
<lineto y="250" />
</path>
</svg>
EOF
)
   test_svgpath "$IN"
   assert_svgpath "M50,375H150V325H250V375H350V250"
}


@test "path curveto" {
IN=$(cat <<'EOF'
<svg>
  <path>
    <curveto x1="10" y1="11" x2="20" y2="21" x="1" y="2"/>
  </path>
</svg>
EOF
)
   invoke_xslt "$IN"
   assert_xpath "svg/path" '<path d="C10,11 20,21 1,2"/>'
}


@test "path curveto shorthand" {
IN=$(cat <<'EOF'
<svg>
  <path>
    <curveto x2="20" y2="21" x="1" y="2"/>
  </path>
</svg>
EOF
)
   invoke_xslt "$IN"
   assert_xpath "svg/path" '<path d="C20,21 1,2"/>'
}


@test "path curveto relative" {
IN=$(cat <<'EOF'
<svg>
  <path>
    <curveto type="rel" x1="10" y1="11" x2="20" y2="21" x="1" y="2"/>
  </path>
</svg>
EOF
)
   invoke_xslt "$IN"
   assert_xpath "svg/path" '<path d="c10,11 20,21 1,2"/>'
}


@test "path curveto relative shorthand" {
IN=$(cat <<'EOF'
<svg>
  <path>
    <curveto type="rel" x2="20" y2="21" x="1" y="2"/>
  </path>
</svg>
EOF
)
   invoke_xslt "$IN"
   assert_xpath "svg/path" '<path d="c20,21 1,2"/>'
}


@test "path quadto" {
IN=$(cat <<'EOF'
<svg>
  <path>
    <quadto x1="10" y1="11" x="1" y="2"/>
  </path>
</svg>
EOF
)
   invoke_xslt "$IN"
   assert_xpath "svg/path" '<path d="Q10,11 1,2"/>'
}


@test "path quadto shorthand" {
IN=$(cat <<'EOF'
<svg>
  <path>
    <quadto x="1" y="2"/>
  </path>
</svg>
EOF
)
   invoke_xslt "$IN"
   assert_xpath "svg/path" '<path d="Q1,2"/>'
}

@test "path quadto data" {
IN=$(cat <<'EOF'
<svg>
  <path>
    <quadto d="11,22"/>
  </path>
</svg>
EOF
)
   invoke_xslt "$IN"
   assert_xpath "svg/path" '<path d="Q11,22"/>'
}

@test "path quadto relative" {
IN=$(cat <<'EOF'
<svg>
  <path>
    <quadto type="rel" x1="10" y1="11"  x="1" y="2"/>
  </path>
</svg>
EOF
)
   invoke_xslt "$IN"
   assert_xpath "svg/path" '<path d="q10,11 1,2"/>'
}

@test "path quadto relative shorthand" {
IN=$(cat <<'EOF'
<svg>
  <path>
    <quadto type="rel" x="1" y="2"/>
  </path>
</svg>
EOF
)
   invoke_xslt "$IN"
   assert_xpath "svg/path" '<path d="q1,2"/>'
}

@test "path quadto relative data" {
IN=$(cat <<'EOF'
<svg>
  <path>
    <quadto type="rel" d="11,22"/>
  </path>
</svg>
EOF
)
   invoke_xslt "$IN"
   assert_xpath "svg/path" '<path d="q11,22"/>'
}

@test "path arcto relative d" {
IN=$(cat <<'EOF'
<svg>
  <path>
    <arcto type="rel" d="25,25 -30 0,1 50,-25"/>
  </path>
</svg>
EOF
)
   invoke_xslt "$IN"
   assert_xpath "svg/path" '<path d="a25,25 -30 0,1 50,-25"/>'
}

@test "path arcto d" {
IN=$(cat <<'EOF'
<svg>
  <path>
    <arcto d="25,25 -30 0,1 50,-25"/>
  </path>
</svg>
EOF
)
   invoke_xslt "$IN"
   assert_xpath "svg/path" '<path d="A25,25 -30 0,1 50,-25"/>'
}

@test "path arcto" {
IN=$(cat <<'EOF'
<svg>
  <path>
    <arcto rx="25" ry="20" x="50" rotation="-30" large-arc="1" sweep="1" y="-25" />
  </path>
</svg>
EOF
)
   invoke_xslt "$IN"
   assert_xpath "svg/path" '<path d="A25,20 -30 1,1 50,-25"/>'
}

@test "path arcto omit large-arc" {
IN=$(cat <<'EOF'
<svg>
  <path>
    <arcto rx="25" ry="20" x="50" rotation="-30" sweep="1" y="-25" />
  </path>
</svg>
EOF
)
   invoke_xslt "$IN"
   assert_xpath "svg/path" '<path d="A25,20 -30 0,1 50,-25"/>'
}

@test "path arcto omit sweep" {
IN=$(cat <<'EOF'
<svg>
  <path>
    <arcto rx="25" ry="20" x="50" rotation="-30" large-arc="1" y="-25" />
  </path>
</svg>
EOF
)
   invoke_xslt "$IN"
   assert_xpath "svg/path" '<path d="A25,20 -30 1,0 50,-25"/>'
}

@test "polyline points x and y" {
IN=$(cat <<'EOF'
<svg>
  <polyline>
  <point x="50" y="150" />
  <point x="50" y="200" />
  <point x="200" y="200" />
  <point x="200" y="100" />
  </polyline>
</svg>
EOF
)
   invoke_xslt "$IN"
   assert_xpath "svg/polyline" '<polyline points="50,150 50,200 200,200 200,100 "/>'
}

@test "polyline points d" {
IN=$(cat <<'EOF'
<svg>
  <polyline>
  <point d="1,2" />
  <point d="3,4" />
  </polyline>
</svg>
EOF
)
   invoke_xslt "$IN"
   assert_xpath "svg/polyline" '<polyline points="1,2 3,4 "/>'
}

