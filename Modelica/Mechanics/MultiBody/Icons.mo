within Modelica.Mechanics.MultiBody;
package Icons "Icons for MultiBody package"
  extends Modelica.Icons.IconsPackage;
  model Surface "Surface icon"
    annotation (Icon(graphics={Polygon(
            points={{-102,40},{-98,92},{28,-8},{96,146},{104,-118},{-18,-34},{-52,
                -130},{-102,40}},
            lineColor={0,0,255},
            smooth=Smooth.Bezier,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,140},{150,100}},
            lineColor={0,0,255},
            textString="%name")}), Documentation(info="<html>
<p>
Model <b>Surface</b> defines a moveable, parametrized surface in 3-dim. space
that is used for animation. This object is specified by:
</p>

<ul>
<li> The surface frame (orientation object \"R\" and origin \"r_0\")
     in which the data is specified.</li>
<li> A set of two parameters, one in u- and one in v-direction,
     that defines the control points. </li>
<li> A time-varying position of each control point with respect to
     the surface frame.</li>
</ul>

<p>
The parameter values (u,v) are given by the ordinal numbers of the
corresponding control point in u- or in v-direction, respectively.
The surface is then defined by the replaceable function \"surfaceCharacteristic\" with the
interface <a href=\"modelica://Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic\">partialSurfaceCharacteristic</a>
that returns the x-, y-, z- coordinate of every control point in form of 3 positional
arrays and an optional color array, if every control point shall have a different
color:
</p>

<pre>
  Real X[nu,nv], Y[nu,nv], Z[nu,nv], colorArray[nu,nv];
</pre>

<p>
Models <a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Torus\">Torus</a>
and <a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.VoluminousWheel\">VoluminousWheel</a>
demonstrate how new visualizer objects can be constructed with the Surface model.<br>
The direct usage of the Surface model, as well as of the Torus and the VoluminousWheel models, are demonstrated with example
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.Surfaces\">Examples.Elementary.Surfaces</a>.
</p>
</html>"));
  end Surface;

  partial class MotorIcon "Icon of an electrical motor."

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            lineColor={82,0,2},
            fillColor={252,37,57},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100.0,-50.0},{30.0,50.0}},
            radius=10.0),
          Polygon(
            fillColor={64,64,64},
            fillPattern=FillPattern.Solid,
            points={{-100.0,-90.0},{-90.0,-90.0},{-60.0,-20.0},{-10.0,-20.0},{20.0,-90.0},{30.0,-90.0},{30.0,-100.0},{-100.0,-100.0},{-100.0,-90.0}}),
          Rectangle(
            lineColor={64,64,64},
            fillColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{30.0,-10.0},{90.0,10.0}})}),
      Documentation(info="<html>
<p>
Icon of an <b>electrical motor</b> model.
</p>
</html>"));
  end MotorIcon;
  annotation (Documentation(info="<html>
<p>This package contains definitions for the graphical layout of components used in the MultiBody library.
These icons might also be used in other libraries using &quot;extends&quot; or by directly copying the &quot;icon&quot; layer.
</p>
</html>"));
end Icons;
