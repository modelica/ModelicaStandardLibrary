within ;
package ModelicaServices "Standard models and functions that require a tool dependent implementation"
annotation (version="0.9", versionDate="2009-06-11", uses(Modelica(version="3.0.1")));


package Plot "Functions for generation of 2D-plots"
  function plotDiagram "Plot one diagram"
     input ModelicaServices.Plot.Records.FigureDiagram figure
      "Properties of figure with one diagram" annotation(Dialog);
     input ModelicaServices.Plot.Records.Device device=
        ModelicaServices.Plot.Records.Device()
      "Properties of device where figure is shown" annotation(Dialog);

  algorithm
    annotation (Documentation(info="<html>
<p>
This function plots a set of 2-dimensional curves in a diagram.
For an overview, see the documentation of package
<a href=\"Modelica://ModelicaServices.Plot\">ModelicaServices.Plot</a>.
</p>
 
</html>"));
  end plotDiagram;

  function plotVectorDiagrams "Plot several diagrams in vector layout"
     input ModelicaServices.Plot.Records.FigureVectorDiagrams figure
      "Properties of figure" annotation(Dialog);
     input ModelicaServices.Plot.Records.Device device=
        ModelicaServices.Plot.Records.Device()
      "Properties of device where figure is shown" annotation(Dialog);

  algorithm
    annotation (Documentation(info="<html>

<p>
This function plots a set of 2-dimensional curves in a set of diagrams
in a figure. For an overview, see the documentation of package
<a href=\"Modelica://ModelicaServices.Plot\">ModelicaServices.Plot</a>.
</p>
 
</html>"));
  end plotVectorDiagrams;

  package Types "Types used for the plotting functions"

    type DrawingUnit_mm "Drawing unit specifing the nominal size in [mm]"
       extends Modelica.Icons.TypeReal(final quantity="Length", final unit="mm");
      annotation (Documentation(info="<html>
<p>
All size information for plotting, such as width or height
of a window or the thickness of a line, are defined by type <b>DrawingUnit_mm</b>. The 
recommended interpretation is that the DrawingUnit is the unscaled size in a document or
on printer in [mm]. For example, if the width of a diagram is 120,
and the diagram is pasted into a Word or PowerPoint document, 
then the width of the diagram in the document is 120 mm.
</p>
 
</html>"));
    end DrawingUnit_mm;

  type ImageResolution_dpi
      "Resolution of image in pixel per inch (screen) or dots per inch (printer)"
     extends Modelica.Icons.TypeReal(final quantity="ImageResolution");
    annotation (Documentation(info="<html>
<p>\"ImageResolution_dpi\" defines the mapping of a length coordinate to the resolution of the output device. The resolution [dpi] is defined as \"dots-per-inch\" and therefore a length L_mm defined in [mm] is mapped to a length L_dot in dots (or pixel) with the formula: </p>
<pre>  L_dot = round(ImageResolution_dpi/0.0254 * L_mm) </pre>
<p>where function round(..) rounds to the nearest integer. Typical values are \"96 dpi\" (for screen) or \"600 dpi\" for printer. For example if an \"ImageResolution = 96 dpi\" shall be used for a screen, then 1 mm is mapped to 4 pixel. </p>
</html>"));
  end ImageResolution_dpi;

  type LinePattern = enumeration(
        None,
        Solid) "Choices for line pattern";

  type PointSymbol = enumeration(
        None "no symbol",
        Cross "x",
        Circle "o",
        Square "square") "Choices for point symbol";

  type LegendLocation = enumeration(
        Above "Above diagram",
        Right "Right of diagram",
        Below "Below of diagram",
        TopLeft "Top left corner of diagram",
        TopRight "Top right corner of diagram",
        BottomLeft "Bottom left corner of diagram",
        BottomRight "Bottom right corner of diagram")
      "Choices for legend location";

  end Types;

  package Records "Records used to define the function interfaces"
    record FigureDiagram "Properties of a figure containing one diagram"
      extends Modelica.Icons.Record;

      ModelicaServices.Plot.Records.Diagram diagram=
                                  ModelicaServices.Plot.Records.Diagram()
        "Properties of the diagram";

      ModelicaServices.Plot.Types.DrawingUnit_mm diagramWidth=150
        "Width of diagram" annotation(Dialog);

    end FigureDiagram;

    record FigureVectorDiagrams
      "Properties of a figure containing a vector of diagrams"
      extends Modelica.Icons.Record;

      ModelicaServices.Plot.Records.Diagram diagram[:]=
           fill(ModelicaServices.Plot.Records.Diagram(), 1)
        "Properties of the diagrams in one figure";

      ModelicaServices.Plot.Types.DrawingUnit_mm diagramWidth=150
        "Width of a diagram in the figure" annotation(Dialog);

    end FigureVectorDiagrams;

    record Diagram
      "Properties of a diagram in a figure containing one or more curves and/or text"
      extends Modelica.Icons.Record;

      ModelicaServices.Plot.Records.Curve curve[
                            :]=fill(ModelicaServices.Plot.Records.Curve(),          1)
        "Properties of the curves in one diagram of the figure"    annotation(Dialog);

      Real heightRatio = 0.5 "Height of diagram = heightRatio*diagramWidth" annotation(Dialog);
      String heading="" "Heading displayed above diagram" annotation(Dialog);
      String xLabel="" "String displayed at horizontal axis" annotation(Dialog);
      String yLabel="" "String displayed at vertical axis" annotation(Dialog);

      Boolean grid=true "= true, if grid is shown" annotation(Dialog,  choices(__Dymola_checkBox=true));
      Boolean autoProperties = true
        "= true, if automatic line properties of curves" 
         annotation(Dialog,  choices(__Dymola_checkBox=true));
      Boolean autoColor = true
        "if autoProperties: distinguish curves by color otherwise by line style"
           annotation(Dialog,choices(__Dymola_checkBox=true));
      Boolean logX = false "= true, if logarithmic scale of x-axis" annotation(Dialog,choices(__Dymola_checkBox=true));
      Boolean logY = false "= true, if logarithmic scale of y-axis" annotation(Dialog,choices(__Dymola_checkBox=true));
      Boolean uniformScaling = false
        "= true, if same vertical and horizontal axis increment"                              annotation(Dialog,choices(__Dymola_checkBox=true));

      Boolean legend = true "= true, if legend is shown" annotation(Dialog,choices(__Dymola_checkBox=true));
      Boolean legendFrame=true "= true, if frame around legend" 
            annotation(Dialog,   choices(__Dymola_checkBox=true));

      ModelicaServices.Plot.Types.LegendLocation legendLocation=
                                                    ModelicaServices.Plot.Types.LegendLocation.Above
        "Legend placement if legend = true" annotation(Dialog(enable=legend));

    end Diagram;

  record Axis "Properties of an axis in a subdiagram"
    extends Modelica.Icons.Record;

    String label="" "String displayed at axis" annotation(Dialog);
    Boolean log = false "= true, if logarithmic scale of axis" annotation(Dialog,choices(__Dymola_checkBox=true));
    Boolean autoScale = true "= true, if automatic scaling of axis" annotation(Dialog,choices(__Dymola_checkBox=true));
    Real min = 0 "Minimum value of axis, if not autoScale" annotation(Dialog(enable=not autoScale));
    Real max = 1 "Maximum value of axis, if not autoScale" annotation(Dialog(enable=not autoScale));

  /*
  Boolean autoTicks = true "= true, if automatic ticks" annotation(Dialog,choices(__Dymola_checkBox=true));
  Real ticks[:] = fill(0.0,0) "If autoTicks = false, ticks along axis" annotation(Dialog(enable=not autoTicks));
*/
  end Axis;

    record Curve "Properties of a curve (displayed in a diagram)"
      extends Modelica.Icons.Record;

       Real x[:]=fill(0.0,0) "x-values of curve" annotation(Dialog);
       Real y[:]=fill(0.0,0) "y-values of curve" annotation(Dialog);
       String legend="" "Legend text of curve" annotation(Dialog);

        ModelicaServices.Plot.Records.Line properties=
                                 ModelicaServices.Plot.Records.Line()
        "Properties of line, if autoProperties = false"  annotation(Dialog(__Dymola_treeView=false));
    end Curve;

  record Line "Properties of a line"
    extends Modelica.Icons.Record;

     Integer color[3]={0,0,255} "Color of curve as rgb values" 
                                     annotation(Dialog(group="If autoProperties = false (otherwise ignored)", __Dymola_colorSelector, __Dymola_treeView=false));

     ModelicaServices.Plot.Types.LinePattern linePattern=ModelicaServices.Plot.Types.LinePattern.Solid
        "Line pattern of curve" 
                              annotation(Dialog(group="If autoProperties = false (otherwise ignored)"));
     ModelicaServices.Plot.Types.PointSymbol symbol=ModelicaServices.Plot.Types.PointSymbol.None
        "Symbol for points on curve" 
                                   annotation(Dialog(group="If autoProperties = false (otherwise ignored)"));

  /*
   ModelicaServices.Plot.Types.LineThickness_mm lineThickness=0.25 
    "Line thickness of curve" annotation(Dialog(group="If autoProperties = false (otherwise ignored)"));
   ModelicaServices.Plot.Types.LineThickness_mm symbolThickness=lineThickness 
    "Symbol thickness of curve" annotation(Dialog(group="If autoProperties = false (otherwise ignored)"));
*/

    annotation (Documentation(info="<html>
<p>
This record defines how a line shall be drawn. If \"autoProperties = <b>true</b>\" for a curve,
the line properties are automatically selected. Otherwise, the properties from this record
are used.
</p>
</html>"));
  end Line;

    record Device "Properties of a device"
      extends Modelica.Icons.Record;

      ModelicaServices.Plot.Types.DrawingUnit_mm xTopLeft=0
        "Horizontal position of top left figure corner if applicable (e.g. window)"
        annotation(Dialog);
      ModelicaServices.Plot.Types.DrawingUnit_mm yTopLeft=0
        "Vertical position of top left figure corner if applicable (e.g. window)"
        annotation(Dialog);
      ModelicaServices.Plot.Types.ImageResolution_dpi windowResolution=96
        "[dpi] Image resolution in window if applicable (e.g. unscaled window)"
                                                                                  annotation(Dialog);
    end Device;
  end Records;
  annotation (Documentation(info="<html>
<p>
This package provides functions to plot curves in two dimensions. Here is a short overview:
</p>

<p>
A figure consists of a <u>set of diagrams</u>. Different functions are provided
to either plot one diagram (plotDiagram) pr to plot several diagrams under each other
(plotVectorDiagrams).
</p>

<p>
Every diagram can have a set of <u>curves</u>. Every diagram has the same
width, defined by <u>diagramWidth</u>. The height of a diagram is defined
by variable <u>heightRatio</u> 
(diagram height in row j = diagram[j].heightRatio*diagramWidth). 
Several curves can be displayed in one diagram.
</p>
 
</html>"));
end Plot;


package Animation "Models and functions for 3-dim. animation"

  model Shape
    "Different visual shapes with variable size; all data have to be set as modifiers (see info layer)"

    import SI = Modelica.SIunits;

    parameter Modelica.Mechanics.MultiBody.Types.ShapeType shapeType="box"
      "Type of shape (box, sphere, cylinder, pipecylinder, cone, pipe, beam, gearwheel, spring)";
    input Modelica.Mechanics.MultiBody.Frames.Orientation R=Modelica.Mechanics.MultiBody.Frames.nullRotation()
      "Orientation object to rotate the world frame into the object frame"  annotation(Dialog);
    input SI.Position r[3]={0,0,0}
      "Position vector from origin of world frame to origin of object frame, resolved in world frame"
                                                                                                      annotation(Dialog);
    input SI.Position r_shape[3]={0,0,0}
      "Position vector from origin of object frame to shape origin, resolved in object frame"
                                                                                              annotation(Dialog);
    input Real lengthDirection[3](each final unit="1")={1,0,0}
      "Vector in length direction, resolved in object frame"  annotation(Dialog);
    input Real widthDirection[3](each final unit="1")={0,1,0}
      "Vector in width direction, resolved in object frame"  annotation(Dialog);
    input SI.Length length=0 "Length of visual object"  annotation(Dialog);
    input SI.Length width=0 "Width of visual object"  annotation(Dialog);
    input SI.Length height=0 "Height of visual object"  annotation(Dialog);
    input Modelica.Mechanics.MultiBody.Types.ShapeExtra extra=0.0
      "Additional size data for some of the shape types"                                 annotation(Dialog);
    input Real color[3]={255,0,0} "Color of shape"               annotation(Dialog);
    input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient
      specularCoefficient =                                                            0.7
      "Reflection of ambient light (= 0: light is completely absorbed)" annotation(Dialog);

    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-100,-100},{80,60}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-100,60},{-80,100},{100,100},{80,60},{-100,60}},
            lineColor={0,0,255},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{100,100},{100,-60},{80,-100},{80,60},{100,100}},
            lineColor={0,0,255},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-100,-100},{80,60}},
            lineColor={0,0,0},
            textString="%shapeType"),
          Text(
            extent={{-132,160},{128,100}},
            textString="%name",
            lineColor={0,0,255})}),
      Documentation(info="<HTML>
<p>
Model <b>Shape</b> defines a visual shape that is
shown at the location of its reference coordinate system, called
'object frame' below. All describing variables such
as size and color can vary dynamically (with the only exception
of parameter shapeType). The default equations in the
declarations should be modified by providing appropriate equations.
Model <b>Shape</b> is usually used as a basic building block to
implement simpler to use graphical components.
</p>
<p>
The following shapes are supported via
parameter <b>shapeType</b> (e.g., shapeType=\"box\"):<br>&nbsp;
</p>
<IMG SRC=\"../Images/MultiBody/Shape.png\" ALT=\"model Visualizers.FixedShape\">
<p>&nbsp;<br>
The dark blue arrows in the figure above are directed along
variable <b>lengthDirection</b>. The light blue arrows are directed
along variable <b>widthDirection</b>. The <b>coordinate systems</b> 
in the figure represent frame_a of the Shape component.
</p>
<p>
Additionally, external shapes are specified as DXF-files
(only 3-dim.Face is supported). External shapes must be named \"1\", \"2\"
etc.. The corresponding definitions should be in files \"1.dxf\",
\"2.dxf\" etc.Since the DXF-files contain color and dimensions for
the individual faces, the corresponding information in the model
is currently ignored. The DXF-files must be found either in the current 
directory or in the directory where the Shape instance is stored
that references the DXF file.
</p>
 
<p>
Via input variable <b>extra</b> additional sizing data is defined
according to:
</p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>shapeType</b></th><th>Meaning of variable <b>extra</b></th></tr>
<tr>
  <td valign=\"top\">\"cylinder\"</td>
  <td valign=\"top\">if extra &gt; 0, a black line is included in the
      cylinder to show the rotation of it.</td>
</tr>
<tr>
  <td valign=\"top\">\"cone\"</td>
  <td valign=\"top\">extra = diameter-left-side / diameter-right-side, i.e.,<br>
      extra = 1: cylinder<br>
      extra = 0: \"real\" cone.</td>
</tr>
<tr>
  <td valign=\"top\">\"pipe\"</td>
  <td valign=\"top\">extra = outer-diameter / inner-diameter, i.e, <br>
      extra = 1: cylinder that is completely hollow<br>
      extra = 0: cylinder without a hole.</td>
</tr>
<tr>
  <td valign=\"top\">\"gearwheel\"</td>
  <td valign=\"top\">extra is the number of teeth of the gear.</td>
</tr>
<tr>
  <td valign=\"top\">\"spring\"</td>
  <td valign=\"top\">extra is the number of windings of the spring.
      Additionally, \"height\" is <b>not</b> the \"height\" but
      2*coil-width.</td>
</tr>
</table>
 
<p>
Parameter <b>color</b> is an Integer vector with 3 elements,
{r, g, b}, and specifies the color of the shape.
{r,g,b} are the \"red\", \"green\" and \"blue\" color parts.
Note, r g, b are given in the range 0 .. 255.
The predefined type <b>MultiBody.Types.Color</b> contains
a menu definition of the colors used in the MultiBody
library (will be replaced by a color editor).
</p>
 
<p>
The variables under heading <b>Parameters</b> below
are declared as (time varying) <b>input</b> variables.
If the default equation is not appropriate, a corresponding
modifier equation has to be provided in the
model where a <b>Shape</b> instance is used, e.g., in the form
</p>
<pre>
    Visualizers.Advanced.Shape shape(length = sin(time));
</pre>
</HTML>
"));

  end Shape;
end Animation;


package Import "Functions to import data in a Modelica environment"

  function linearizeModel
    "Linearize a model after simulation up to a given time"

    input String modelName "Name of the Modelica model" annotation(Dialog(__Dymola_translatedModel));
    input Modelica.SIunits.Time t_linearize= 0
      "Simulate until T_linearize and then linearize";
    output Real A[:,size(A,1)] "A-matrix";
    output Real B[size(A, 1),:] "B-matrix";
    output Real C[:,size(A, 1)] "C-matrix";
    output Real D[size(C, 1),size(B, 2)] "D-matrix";
    output String InputNames[size(B, 2)]=fill("", size(B, 2))
      "Modelica names of inputs";
    output String OutputNames[size(C, 1)]=fill("", size(C, 1))
      "Modelica names of outputs";
    output String StateNames[size(A, 2)]=fill("", size(A, 2))
      "Modelica names of states";
  algorithm

    annotation (Documentation(info="<html>
<p>This function initializes a Modelica model and then simulates the model with its default experiment options until time instant \"t_linearize\". If t_linearize=0, no simulation takes place (only initialization). At the simulation stop time, the model is linearized in such a form that </p>
<p><ul>
<li>all top-level signals with prefix \"input\" are treated as inputs <b>u</b>(t) of the model ,</li>
<li>all top-level signals with prefix \"output\" are treated as outputs <b>y</b>(t) of the model,</li>
<li>all variables that appear differentiated and that are selected as states at this time instant are treated as states <b>x</b> of the model.</li>
</ul></p>
<p>Formally, the non-linear hybrid differential-algebraic equation system is therefore treated as the following ordinary equation system at time instant t_linearize: </p>
<pre>    der(<b>x</b>) = <b>f</b>(<b>x</b>,<b>u</b>)</pre>
<pre>         <b>y</b> = <b>g</b>(<b>x</b>,<b>u</b>) </pre>
<p>Taylor series expansion (linearization) of this model around the simulation stop time t_linearize: </p>
<pre>   <b>u</b>0 = <b>u</b>(t_linearize)</pre>
<pre>   <b>y</b>0 = <b>y</b>(t_linearize)</pre>
<pre>   <b>x</b>0 = <b>x</b>(t_linearize) </pre>
<p>and neglecting higher order terms results in the following system: </p>
<pre>   der(<b>x</b>0+d<b>x</b>) = <b>f</b>(<b>x</b>0,<b>u</b>0) + der(<b>f</b>,<b>x</b>)*d<b>x</b> + der(<b>f</b>,<b>u</b>)*d<b>u</b></pre>
<pre>      <b>y</b>0 + d<b>y</b> = <b>g</b>(<b>x</b>0,<b>u</b>0) + der(<b>g</b>,<b>x</b>)*d<b>x</b> + der(<b>g</b>,<b>u</b>)*d<b>u</b></pre>
<p>where der(<b>f</b>,<b>x</b>) is the partial derivative of <b>f</b> with respect to <b>x</b>, and the partial derivatives are computed at the linearization point t_linearize. Re-ordering of terms gives (note <b>der</b>(<b>x</b>0) = <b>0</b>): </p>
<pre>   der(d<b>x</b>) = der(<b>f</b>,<b>x</b>)*d<b>x</b> + der(<b>f</b>,<b>u</b>)*d<b>u</b> + <b>f</b>(<b>x</b>0,<b>u</b>0)</pre>
<pre>        d<b>y</b> = der(<b>g</b>,<b>x</b>)*d<b>x</b> + der(<b>g</b>,<b>u</b>)*d<b>u</b> + (<b>g</b>(<b>x</b>0,<b>u</b>0) - <b>y</b>0)</pre>
<p>or </p>
<pre>   der(d<b>x</b>) = <b>A</b>*d<b>x</b> + <b>B</b>*d<b>u</b> + <b>f</b>0</pre>
<pre>        d<b>y</b> = <b>C</b>*d<b>x</b> + <b>D</b>*d<b>u</b></pre>
<p>This function returns the matrices <b>A</b>, <b>B</b>, <b>C</b>, <b>D</b> and assumes that the linearization point is a steady-state point of the simulation (i.e., <b>f</b>(<b>x</b>0,<b>u</b>0) = 0). Additionally, the full Modelica names of all inputs, outputs and states shall be returned if possible (default is to return empty name strings).</p>
</html>"));
  end linearizeModel;
end Import;

end ModelicaServices;
