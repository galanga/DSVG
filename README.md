# DSVG

Human-friendly SVG.

DSVG is a superset of SVG syntax allowing SVG path segments to be defined 
inside of their own tags for when clarity and maintainability are more important
than brevity.

DSVG is an xsl preprocessor for SVG that allows the SVG path object to
be represented in a more verbose format, easier for humans to understand
and modify.  

    &lt;path d="M100,200 C100,100 250,100 250,200H200V250"
        fill="none" stroke="red" stroke-width="5"/&gt;

can be represented by:

    &lt;path&gt;
        &lt;moveto x="100" y="200"/&gt;
        &lt;curveto x1="100" y1="100" x2="250" y2="100" x="250" y="200"/&gt;
        &lt;lineto x=200/&gt;
        &lt;lineto y=250/&gt;
        &lt;lineto x="150" y="150"/&gt;
        &lt;closepath/&gt;
    &lt;/path&gt;

Polygon and polyline elements can be represented as containers with their
points as child ojbects.

    &lt;polygon&gt;
      &lt;point x="50" y="150" /&gt;
      &lt;point x="50" y="200" /&gt;
      &lt;point x="200" y="200" /&gt;
      &lt;point x="200" y="100" /&gt;
    &lt;/polygon&gt;

Is equivalent to

    &lt;polygon points="50,150 50,200 200,200 200,100"/&gt;

Goals:

* Expand terse native representation of SVG path elements.
* gzip representation not appreciably longer than native SVG.
