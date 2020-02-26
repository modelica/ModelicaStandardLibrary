within Modelica.Mechanics.MultiBody.Visualizers;
package Colors "Library of functions operating on color"
  extends Modelica.Icons.FunctionsPackage;

  annotation (Documentation(info="<html>
<p>
This package contains functions to operate on colors.
Note, a color is represented as a Real array with 3 elements where
the elements are the red, green, blue values of the RGB color model.
Every element must be in the range 0&nbsp;&hellip;&nbsp;255.
The type of a color is Real and not Integer in order that a color
can be used with less problems in a model, since in a model an Integer
type could only be used in a when-clause. Typical declaration of a color value:
</p>

<blockquote><pre>
Real color[3](each min=0, each max=255);
</pre></blockquote>

<p>
This definition is also available as type
<a href=\"modelica://Modelica.Mechanics.MultiBody.Types.RealColor\">Modelica.Mechanics.MultiBody.Types.RealColor</a>.
</p>
</html>"));
end Colors;
