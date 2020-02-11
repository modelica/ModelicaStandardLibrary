within Modelica.Mechanics.MultiBody.Visualizers.Colors;
function colorMapToSvg
  "Save a color map on file in svg (scalable vector graphics) format"
  extends Modelica.Icons.Function;
 encapsulated type HeaderType = enumeration(
      svgBeginAndEnd,
      svgBegin,
      svgEnd,
      noHeader);
  import Modelica.Utilities.Streams.print;
  input Real colorMap[:,3] "Color map to be stored in svg format"
    annotation(choices( choice=Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.jet(),
                        choice=Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.hot(),
                        choice=Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.gray(),
                        choice=Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.spring(),
                        choice=Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.summer(),
                        choice=Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.autumn(),
                        choice=Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.winter()));
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
  input String caption="" "Caption above the map";
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
  if caption<>"" then
     print("... " + caption);
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
  ni :=if nScalars == 1 then 2 else if nScalars < 1 then
                             0 else nScalars;
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

  if caption <> "" then
     print("   <text x=\"" + String(xHeading) +
           "mm\" y=\"" + String(yHeading) +
           "mm\" font-family=\"Fixedsys\" font-size=\"" + String(fontSize) +
           "pt\" text-anchor=\"middle\">" + caption +
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
Colors.<strong>colorMapToSvg</strong>(colorMap);
Colors.<strong>colorMapToSvg</strong>(colorMap,
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
                     caption    = \"\",
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
Over the color map, a caption \"caption\" is placed.
On the right side of the color map, a set of scalar field values T is
displayed where \"T_min\" is placed at colorMap[1,:],
\"T_max\" is placed at colorMap[end,:] and \"nScalars\" values between
\"T_min\" and \"T_max\" (including T_min and T_max) are shown.
The printing format of the numbers is defined with \"format\", see definition below.
With argument \"headerType\" it is defined whether \"svg\" begin and end
lines are printed. If the \"begin\" svg tag shall be printed, file \"fileName\"
is deleted, if it already exists. Otherwise, all output is appended to the
file \"fileName\".
</p>

<p>
A \"svg\" file can be displayed by a web browser, such as
<a href=\"http://www.mozilla.org/firefox\">Firefox</a> by dragging the
file in the browser window.
Alternatively, a svg-file can be loaded in a graphics program,
such as the free <a href=\"http://inkscape.org\">Inkscape</a>,
can be manipulated and can be exported in other graphic formats.
The following image was generated with a call to \"colorMapToSvg\", the
generated file was loaded in Inkscape and exported in \"png\" format:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Colors/ColorMaps/jet.png\">
</blockquote>

<p>
The \"format\" argument defines the string formatting according to
ANSI-C without \"%\" and \"*\" character<br>
(e.g., \".6g\", \"14.5e\", \"+6f\"). In particular:
</p>

<p>
format = \"[&lt;flags&gt;] [&lt;width&gt;] [.&lt;precision&gt;] &lt;conversion&gt;\"
with
</p>

<blockquote>
<table>
<tr>
  <td>&lt;flags&gt;</td>
  <td> zero, one or more of<br>
       \"-\": left adjustment of the converted number<br>
       \"+\": number will always be printed with a sign<br>
       \"0\": padding to the field width with leading zeros</td></tr>
<tr>
  <td>&lt;width&gt;</td>
  <td> Minimum field width. The converted number will be printed in a field at<br>
       least this wide and wider if necessary. If the converted number has<br>
       fewer characters it will be padded on the left (or the right depending<br>
       on &lt;flags&gt;) with blanks or 0 (depending on &lt;flags&gt;).</td></tr>
<tr>
  <td>&lt;precision&gt;</td>
  <td> The number of digits to be printed after the decimal point for<br>
       e, E, or f conversions, or the number of significant digits for<br>
       g or G conversions.</td></tr>
<tr>
  <td> &lt;conversion&gt;</td>
  <td> = \"e\": Exponential notation using a  lower case e<br>
       = \"E\": Exponential notation using an upper case E<br>
       = \"f\": Fixed point notation<br>
       = \"g\": Either \"e\" or \"f\"<br>
       = \"G\": Same as \"g\", but with upper case E</td></tr>
</table>
</blockquote>
</html>"));
end colorMapToSvg;
