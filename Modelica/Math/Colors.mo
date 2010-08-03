within Modelica.Math;
package Colors "Library of functions operating on color"
  extends Modelica.Icons.Package;
  package ColorMaps "Library of functions returning color maps"
    extends Modelica.Icons.Package;

    function jet "Returns the \"jet\" color map"
    extends Modelica.Math.Interfaces.partialColorMap;
    protected
       Real a=ceil(n_colors/4);
       Real d=1/a;
       Real v1[:]=if d >= 0.5 then {1} else if d >= 0.25 then  1-d:d:1 else 0.5+d:d:1;
       Real v2[:]=0+d:d:1;
       Real v3[:]=1-d:-d:0;
       Real v4[:]=1-d:-d:0.5;
       Real cm[integer(a)*4,3];
    algorithm
       cm:=255*[zeros(size(v1,1)),zeros(size(v1,1)),  v1;
                zeros(size(v2,1)), v2,  fill(1., size(v2,1));
                v2,              fill(1, size(v2,1)), v3;
                fill(1, size(v3,1)),v3, fill(0.,size(v3,1));
                v4, fill(0,size(v4,1)),fill(0.,size(v4,1))];
       colorMap:=cm[1:n_colors,:];

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
ColorMaps.<b>jet</b>();
ColorMaps.<b>jet</b>(n_colors=64);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the color map \"jet.\" A color map
is a Real[:,3] array where every row represents a color.
With the optional argument \"n_colors\" the number of rows
of the returned array can be defined. The default value is
\"n_colors=64\" (it is usually best if n_colors is a multiple of 4).
Image of the \"jet\" color map:
</p>

<blockquote>
<img src=\"modelica://Modelica/Images/Math/Colors/jet.png\">
</blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Colors.ColorMaps\">Math.Colors.ColorMaps</a>,
<a href=\"modelica://Modelica.Math.Colors.colorMapToSvg\">Math.Colors.colorMapToSvg</a>,
<a href=\"modelica://Modelica.Math.Colors.scalarToColor\">Math.Colors.scalarToColor</a>.
</html>"));
    end jet;

    function hot "Returns the \"hot\" color map"
    extends Modelica.Math.Interfaces.partialColorMap;
    protected
       Real a=ceil(n_colors/3);
       Real d=1/a;
       Real v1[:]=0+d:d:1;
       Real cm[integer(a)*3,3];
    algorithm
     cm := 255*[v1, zeros(size(v1, 1)),zeros(size(v1, 1));
                              fill(1., size(v1, 1)), v1,zeros(size(v1, 1));
                              fill(1., size(v1, 1)),fill(1., size(v1, 1)),v1];
     colorMap:=cm[1:n_colors,:];

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
ColorMaps.<b>hot</b>();
ColorMaps.<b>hot</b>(n_colors=64);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the color map \"hot.\" A color map
is a Real[:,3] array where every row represents a color.
With the optional argument \"n_colors\" the number of rows
of the returned array can be defined. The default value is
\"n_colors=64\" (it is usually best if n_colors is a multiple of 4).
Image of the \"hot\" color map:
</p>

<blockquote>
<img src=\"modelica://Modelica/Images/Math/Colors/hot.png\">
</blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Colors.ColorMaps\">Math.Colors.ColorMaps</a>,
<a href=\"modelica://Modelica.Math.Colors.colorMapToSvg\">Math.Colors.colorMapToSvg</a>,
<a href=\"modelica://Modelica.Math.Colors.scalarToColor\">Math.Colors.scalarToColor</a>.
</html>"));
    end hot;

    function gray "Returns the \"gray\" color map"
    extends Modelica.Math.Interfaces.partialColorMap;
    algorithm
      if n_colors > 1 then
        colorMap := 255*[linspace(0,1.,n_colors),linspace(0,1.,n_colors),linspace(0,1.,n_colors)];
      else
        colorMap:=[0,0,0];
       end if;

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
ColorMaps.<b>gray</b>();
ColorMaps.<b>gray</b>(n_colors=64);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the color map \"gray.\" A color map
is a Real[:,3] array where every row represents a color.
With the optional argument \"n_colors\" the number of rows
of the returned array can be defined. The default value is
\"n_colors=64\" (it is usually best if n_colors is a multiple of 4).
Image of the \"gray\" color map:
</p>

<blockquote>
<img src=\"modelica://Modelica/Images/Math/Colors/gray.png\">
</blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Colors.ColorMaps\">Math.Colors.ColorMaps</a>,
<a href=\"modelica://Modelica.Math.Colors.colorMapToSvg\">Math.Colors.colorMapToSvg</a>,
<a href=\"modelica://Modelica.Math.Colors.scalarToColor\">Math.Colors.scalarToColor</a>.
</html>"));
    end gray;

    function spring "Returns the \"spring\" color map"
    extends Modelica.Math.Interfaces.partialColorMap;
    algorithm
      if n_colors > 1 then
         colorMap := 255*[fill(1,n_colors),linspace(0,1.,n_colors),linspace(1,0,n_colors)];
       else
        colorMap:=255*[1,0,1];
       end if;

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
ColorMaps.<b>spring</b>();
ColorMaps.<b>spring</b>(n_colors=64);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the color map \"spring.\" A color map
is a Real[:,3] array where every row represents a color.
With the optional argument \"n_colors\" the number of rows
of the returned array can be defined. The default value is
\"n_colors=64\" (it is usually best if n_colors is a multiple of 4).
Image of the \"spring\" color map:
</p>

<blockquote>
<img src=\"modelica://Modelica/Images/Math/Colors/spring.png\">
</blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Colors.ColorMaps\">Math.Colors.ColorMaps</a>,
<a href=\"modelica://Modelica.Math.Colors.colorMapToSvg\">Math.Colors.colorMapToSvg</a>,
<a href=\"modelica://Modelica.Math.Colors.scalarToColor\">Math.Colors.scalarToColor</a>.
</html>"));
    end spring;

    function summer "Returns the \"summer\" color map"
    extends Modelica.Math.Interfaces.partialColorMap;
    algorithm
      if n_colors > 1 then
         colorMap := 255*[linspace(0,1.,n_colors),linspace(0.5,1.,n_colors),fill(0.4,n_colors)];
       else
        colorMap:=255*[0,0.5,0.4];
       end if;

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
ColorMaps.<b>summer</b>();
ColorMaps.<b>summer</b>(n_colors=64);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the color map \"summer.\" A color map
is a Real[:,3] array where every row represents a color.
With the optional argument \"n_colors\" the number of rows
of the returned array can be defined. The default value is
\"n_colors=64\" (it is usually best if n_colors is a multiple of 4).
Image of the \"summer\" color map:
</p>

<blockquote>
<img src=\"modelica://Modelica/Images/Math/Colors/summer.png\">
</blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Colors.ColorMaps\">Math.Colors.ColorMaps</a>,
<a href=\"modelica://Modelica.Math.Colors.colorMapToSvg\">Math.Colors.colorMapToSvg</a>,
<a href=\"modelica://Modelica.Math.Colors.scalarToColor\">Math.Colors.scalarToColor</a>.
</html>"));
    end summer;

    function autumn "Returns the \"autumn\" color map"
    extends Modelica.Math.Interfaces.partialColorMap;
    algorithm
      if n_colors > 1 then
         colorMap := 255*[fill(1,n_colors),linspace(0,1.,n_colors),zeros(n_colors)];
       else
        colorMap:=255*[1,0,0];
       end if;

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
ColorMaps.<b>autumn</b>();
ColorMaps.<b>autumn</b>(n_colors=64);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the color map \"autumn.\" A color map
is a Real[:,3] array where every row represents a color.
With the optional argument \"n_colors\" the number of rows
of the returned array can be defined. The default value is
\"n_colors=64\" (it is usually best if n_colors is a multiple of 4).
Image of the \"autumn\" color map:
</p>

<blockquote>
<img src=\"modelica://Modelica/Images/Math/Colors/autumn.png\">
</blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Colors.ColorMaps\">Math.Colors.ColorMaps</a>,
<a href=\"modelica://Modelica.Math.Colors.colorMapToSvg\">Math.Colors.colorMapToSvg</a>,
<a href=\"modelica://Modelica.Math.Colors.scalarToColor\">Math.Colors.scalarToColor</a>.
</html>"));
    end autumn;

    function winter "Returns the \"winter\" color map"
    extends Modelica.Math.Interfaces.partialColorMap;
    algorithm
      if n_colors > 1 then
         colorMap := 255*[zeros(n_colors),linspace(0,1,n_colors),linspace(1,0.5,n_colors)];
       else
        colorMap:=[0,0,255];
       end if;

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
ColorMaps.<b>winter</b>();
ColorMaps.<b>winter</b>(n_colors=64);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the color map \"winter.\" A color map
is a Real[:,3] array where every row represents a color.
With the optional argument \"n_colors\" the number of rows
of the returned array can be defined. The default value is
\"n_colors=64\" (it is usually best if n_colors is a multiple of 4).
Image of the \"winter\" color map:
</p>

<blockquote>
<img src=\"modelica://Modelica/Images/Math/Colors/winter.png\">
</blockquote>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Colors.ColorMaps\">Math.Colors.ColorMaps</a>,
<a href=\"modelica://Modelica.Math.Colors.colorMapToSvg\">Math.Colors.colorMapToSvg</a>,
<a href=\"modelica://Modelica.Math.Colors.scalarToColor\">Math.Colors.scalarToColor</a>.
</html>"));
    end winter;

    annotation (Documentation(info="<html>
<p>
This package contains functions that return color maps.
A color map is a Real[:,3] array where every row represents a color. 
Currently the following color maps are returned from the 
respective function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Images/Math/Colors/ColorMaps.png\">
</blockquote>
</html>"));
  end ColorMaps;

  function colorMapToSvg
    "Save a color map on file in svg (scalable vector graphics) format"
   encapsulated type HeaderType = enumeration(
        svgBeginAndEnd,
        svgBegin,
        svgEnd,
        noHeader);
    import Modelica.Utilities.Streams.print;
    input Real colorMap[:,3] "Color map to be stored in svg format"
      annotation(choices( choice=Modelica.Math.Colors.ColorMaps.jet(),
                          choice=Modelica.Math.Colors.ColorMaps.hot(),
                          choice=Modelica.Math.Colors.ColorMaps.gray(),
                          choice=Modelica.Math.Colors.ColorMaps.spring(),
                          choice=Modelica.Math.Colors.ColorMaps.summer(),
                          choice=Modelica.Math.Colors.ColorMaps.autumn(),
                          choice=Modelica.Math.Colors.ColorMaps.winter()));
    input String fileName="colorMap.svg"
      "File where the svg representation shall be stored";
    input Real width(unit="mm")=10 "Width in svg-figure";
    input Real height(unit="mm")=100 "Height in svg-figure";
    input Real x(unit="mm")=20 "X-Coordinate of left upper corner";
    input Real y(unit="mm")=10 "Y-Coordinate of left upper corner";
    input Real T_min=0 "Value of scalar corresponding to colorMap[1,:]";
    input Real T_max=100 "Value of scalar corresponding to colorMap[end,:]";
    input Integer nScalars=11
      "Number of scalars to be displayed at the right side";
    input String format=".3g" "Format of the numbers";
    input Real fontSize=11 "Font size in [pt]";
    input Real textWidth(unit="mm")=8
      "Numbers are right justified starting at x+width+textWidth";
    input String heading="" "Heading above the map";
    input HeaderType headerType=Colors.colorMapToSvg.HeaderType.svgBeginAndEnd
      "Type of header";
  protected
    Integer nc = size(colorMap,1);
    Real dy=height/nc;
    Real yy=y-dy;
    String strWidth=String(width);
    String strHeight=String(dy);
    Real T;
    Integer ni;
    constant Real ptToMm=127/360 "1 Point = ptToMm mm";
    Real fontHeight(unit="mm") = fontSize*ptToMm;
    Real xx=x+width+textWidth;
    String strXX=String(xx);
    Real xHeading=x+width/2;
    Real yHeading=y-1.2*fontHeight;
  algorithm
    if headerType==HeaderType.svgBeginAndEnd or
       headerType==HeaderType.svgBegin then
       Modelica.Utilities.Files.remove(fileName);
       print("... generating svg-file: " + Modelica.Utilities.Files.fullPathName(fileName));
    end if;
    if heading<>"" then
       print("... " + heading);
    end if;

    if headerType==HeaderType.svgBeginAndEnd or
       headerType==HeaderType.svgBegin then
       print("<svg xmlns=\"http://www.w3.org/2000/svg\">", fileName);
    end if;

    print("  <g>", fileName);

    // Print colors
    for i in nc:-1:1 loop
       // print:  <rect x="XXmm" y="XXmm" width="YYmm" height="ZZmm" style="fill:rgb(100,128,255);stroke:none"/>
       yy :=yy + dy;
       print("    <rect x=\"" + String(x) +
             "mm\" y=\"" + String(yy) +
             "mm\" width=\"" + strWidth +
             "mm\" height=\"" + strHeight +
             "mm\" style=\"fill:rgb(" + String(integer(colorMap[i,1])) + ","
                                      + String(integer(colorMap[i,2])) + ","
                                      + String(integer(colorMap[i,3])) +
             ");stroke:none\"/>", fileName);
    end for;

    // Print numbers
    ni :=if nScalars == 1 then 2 else if nScalars < 1
                          then 0 else nScalars;
    dy:=height/(ni-1);
    yy:=y - dy+0.3*fontHeight;
    for i in ni:-1:1 loop
      // print: <text x="22mm" y="12mm" font-family="Arial,sans-serif" font-size="11pt">1.2345</text>
      yy :=yy + dy;
      T := T_min + (T_max - T_min)*(i-1)/(ni-1);
      print("    <text x=\"" + strXX +
            "mm\" y=\"" + String(yy) +
            "mm\" font-family=\"Fixedsys\" font-size=\"" + String(fontSize) +
            "pt\" text-anchor=\"end\">" + String(T,format=format) +
            "</text>", fileName);
    end for;

    if heading <> "" then
       print("   <text x=\"" + String(xHeading) +
             "mm\" y=\"" + String(yHeading) +
             "mm\" font-family=\"Fixedsys\" font-size=\"" + String(fontSize) +
             "pt\" text-anchor=\"middle\">" + heading +
             "</text>", fileName);
    end if;

    print("  </g>", fileName);

    if headerType==HeaderType.svgBeginAndEnd or
       headerType==HeaderType.svgEnd then
       print("</svg>",fileName);
    end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Colors.<b>colorMapToSvg</b>(colorMap);
Colors.<b>colorMapToSvg</b>(colorMap, 
                     fileName   = \"colorMap.svg\",
                     width      =  10,  // [mm]
                     height     = 100,  // [mm]
                     x          =  20,  // [mm]
                     y          =  10,  // [mm]
                     T_min      =   0, 
                     T_max      = 100, 
                     nScalars   =  11, 
                     format     = \".3g\", 
                     fontSize   =  11,  // [pt] 
                     textWidth  =   8,  // [mm] 
                     heading    = \"\", 
                     headerType = Colors.colorMapToSvg.Header.svgBeginAndEnd)
                                                           // svgBegin
                                                           // svgEnd
                                                           // svgNoHeader
</pre></blockquote>
<h4>Description</h4>
<p>
This function saves the color map \"Real colorMap[:,3]\" on file \"fileName\"
in svg format. The color map has a width of \"width\" and a height of \"height\" and
the upper left corner is placed at coordinates \"(x,y)\".
Over the color map, a heading \"heading\" is placed.
On the right side of the color map, a set of scalar field values T is
displayed where \"T_min\" is placed at colorMap[1,:], 
\"T_max\" is placed at colorMap[end,:] and \"nScalars\" values between
\"T_min\" and \"T_max\" (including T_min and T_max) are shown.
The printing format of the numbers is defined with \"format\" using
printing definitions from format \"String(.., format=\"xx\")\" that
are based on the C-formatting attributes of strings.
With argument \"headerType\" it is defined whether \"svg\" begin and end
lines are printed. If the \"begin\" svg tag shall be printed, file \"fileName\"
is deleted, if it already exists. Otherwise, all output is appended to the
file \"fileName\".
</p>

<p>
A \"svg\" file can be displayed by a web browser, such as 
<a href=\"http://www.mozilla.org/firefox\">Firefox</a> by dragging the
file in the browser window.
Alternatively, an svg-file can be loaded in a graphics program,
such as the free <a href=\"http://inkscape.org\">Incscape</a>,
can be manipulated and can be exported in other graphics formats.
The following image was generated with a call to \"colorMapToSvg\", the
generated file was loaded in Incscape and exported in \"png\" format:
</p>

<blockquote>
<img src=\"modelica://Modelica/Images/Math/Colors/jet.png\">
</blockquote>
</html>"));
  end colorMapToSvg;

  function scalarToColor "Map a scalar to a color using a color map"
    input Real T "Scalar value" annotation(Dialog);
    input Real T_min "T <= T_min is mapped to colorMap[1,:]" annotation(Dialog);
    input Real T_max "T >= T_max is mapped to colorMap[end,:]" annotation(Dialog);
    input Real colorMap[:,3] "Color map" annotation(Dialog);
    output Real color[3] "Color of scalar value T";
  algorithm
    color :=colorMap[integer((size(colorMap, 1) - 1)/(T_max - T_min)*
                              min((max(T,T_min) - T_min), T_max) + 1), :];
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
//Real T, T_min, T_max, colorMap[:,3];
Colors.<b>scalarToColor</b>(T, T_min, T_max, colorMap); 
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns an rgb color Real[3] that corresponds to the value of \"T\".
The color is selected from the colorMap by interpolation so that 
\"T_min\" corresponds to \"colorMap[1,:]\" and 
\"T_max\" corresponds to \"colorMap[end,:]\".
</p>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Colors.ColorMaps\">Math.Colors.ColorMaps</a>,
<a href=\"modelica://Modelica.Math.Colors.colorMapToSvg\">Math.Colors.colorMapToSvg</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField\">Mechanics.MultiBody.Visualizers.PipeWithScalarField</a>.

</html>"));
  end scalarToColor;
  annotation (Documentation(info="<html>
<p>
This package contains functions to operate on colors.
Note, a color is represented as a Real array with 3 elements where
the elements are the red, green, blue values of the RGB color model.
Every element must be in the range 0..255.
The type of a color is Real and not Integer in order that a color
can be used with less problems in a model, since in a model an Integer
type could only be used in a when-clause. Typical declaration of a color value:
</p>

<blockquote>
<pre>
  Real color[3](each min=0, each max=255);
</pre>
</blockquote>

<p>
This definition is also available as type
<a href=\"modelica://Modelica.Mechanics.MultiBody.Types.RealColor\">Modelica.Mechanics.MultiBody.Types.RealColor</a>.
</p>
</html>"));
end Colors;
