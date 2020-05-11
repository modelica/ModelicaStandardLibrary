within Modelica.Mechanics.MultiBody.Types;
type ShapeType = Modelica.Icons.TypeString
  "Type of shape (box, sphere, cylinder, pipecylinder, cone, pipe, beam, gearwheel, spring, <external shape>)"
   annotation ( choices(
    choice="box" "\"box\"",
    choice="sphere" "\"sphere\"",
    choice="cylinder" "\"cylinder\"",
    choice="pipecylinder" "\"pipecylinder\"",
    choice="cone" "\"cone\"",
    choice="pipe" "\"pipe\"",
    choice="beam" "\"beam\"",
    choice="gearwheel" "\"gearwheel\"",
    choice="spring" "\"spring\"",
    choice="modelica://PackageName/PathName.dxf"),
  Documentation(info="<html>
<p>
Type <strong>ShapeType</strong> is used to define the shape of the
visual object as parameter String. Usually, \"shapeType\" is used
as instance name. The following
values for shapeType are possible, e.g., shapeType=\"box\":
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Shape.png\" alt=\"model Visualizers.FixedShape\">
</div>

<p>
The dark blue arrows in the figure above are directed along
variable <strong>lengthDirection</strong>. The light blue arrows are directed
along variable <strong>widthDirection</strong>. The <strong>coordinate systems</strong>
in the figure represent frame_a of the Shape component.
</p>

<p>
Additionally, external shapes can be specified as (not all options might be supported by all tools):
</p>

<ul>
<li> <strong>\"1\", \"2\",&nbsp;&hellip;</strong><br>
     define external shapes specified in DXF format in files \"1.dxf\", \"2.dxf\",&nbsp;&hellip;
     The DXF-files must be found either in the current directory or in the directory where
     the Shape instance is stored that references the DXF file.
     This (very limited) option should not be used for new models. Example:<br>
    shapeType=\"1\".<br></li>

<li> \"<strong>modelica:</strong>//&lt;Modelica-name&gt;/&lt;relative-path-file-name&gt;\"<br>
     characterizes the file that is stored under the location of the
     &lt;Modelica-name&gt; library path with the given relative file name.
     Example:<br> shapeType = \"modelica://Modelica/Resources/Data/Shapes/Engine/piston.dxf\".<br></li>

<li> \"<strong>file:</strong>//&lt;absolute-file-name&gt;\"<br>
     characterizes an absolute file name in the file system. Example:<br>
     shapeType=\"file://C:/users/myname/shapes/piston.dxf\".</li>
</ul>

<p>
The supported file formats are tool dependent. Most tools support
at least DXF-files (a tool might support 3-dim. Face of the DXF format only),
but may support other format as well (such as stl, obj, 3ds).
Since visualization files contain color and other data, the corresponding
information in the model is usually ignored.
</p>
</html>"));
