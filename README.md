# DSVG

Human-friendly SVG.

DSVG is a superset of SVG syntax allowing SVG path segments to be defined 
inside of their own tags for when clarity and maintainability are more important
than brevity.

DSVG is an xsl preprocessor for SVG that allows the SVG path object to
be represented in a more verbose format, easier for humans to understand
and modify.  

    <path d="M100,200 C100,100 250,100 250,200H200V250"
        fill="none" stroke="red" stroke-width="5">

can be represented by:

    <path>
        <moveto x="100" y="200">
        <curveto x1="100" y1="100" x2="250" y2="100" x="250" y="200">
        <lineto x=200>
        <lineto y=250>
        <lineto x="150" y="150">
        <closepath>
    </path>

Polygon and polyline elements can be represented as containers with their
points as child ojbects.

    <polygon>
      <point x="50" y="150" />
      <point x="50" y="200" />
      <point x="200" y="200" />
      <point x="200" y="100" />
    </polygon>

Is equivalent to

    <polygon points="50,150 50,200 200,200 200,100"/>

Goals:

* Expand terse native representation of SVG path elements.
* gzip representation not appreciably longer than native SVG.
