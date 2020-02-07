within Modelica.Mechanics.MultiBody.Visualizers.Advanced;
model Surface
  "Visualizing a moveable, parameterized surface; the surface characteristic is provided by a function"
  extends Modelica.Mechanics.MultiBody.Icons.Surface;
  extends Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialSurface;
  extends ModelicaServices.Animation.Surface;
  annotation (Icon(graphics={Polygon(
          points={{-102,40},{-98,92},{28,-8},{96,146},{104,-118},{-18,-34},{-52,
              -130},{-102,40}},
          lineColor={0,0,255},
          smooth=Smooth.Bezier,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,140},{150,100}},
          textColor={0,0,255},
          textString="%name")}), Documentation(info="<html>
<p>
Model <strong>Surface</strong> defines a moveable, parametrized surface in 3-dim. space
that is used for animation. This object is specified by:
</p>

<ul>
<li> The surface frame (orientation object \"R\" and origin \"r_0\")
     in which the data is specified.</li>
<li> A set of two parameters, one in u- and one in v-direction,
     that defines the control points.</li>
<li> A time-varying position of each control point with respect to
     the surface frame.</li>
</ul>

<p>
The parameter values (u,v) are given by the ordinal numbers of the
corresponding control point in u- or in v-direction, respectively.
The surface is then defined by the replaceable function \"surfaceCharacteristic\" with the
interface <a href=\"modelica://Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic\">partialSurfaceCharacteristic</a>
that returns the x-, y-, z- coordinate of every control point in form of 3 arrays X, Y, Z, and an optional color array C, if every control point shall have a different color:
</p>

<blockquote><pre>
Real X[nu,nv], Y[nu,nv], Z[nu,nv], C[nu,nv,3];
</pre></blockquote>

<p>
An example of a parameterized surface with color coding is shown in the next figure:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Advanced/Surface.png\">
</blockquote>

<p>
Models <a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Torus\">Torus</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.VoluminousWheel\">VoluminousWheel</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField\">PipeWithScalarField</a>,
demonstrate how new visualizer objects can be constructed with the Surface model.<br>
The direct usage of the Surface model, as well as of the Torus and the VoluminousWheel models, are demonstrated with example
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.Surfaces\">Examples.Elementary.Surfaces</a>.
</p>
</html>"));
end Surface;
