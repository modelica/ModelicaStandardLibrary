within Modelica.Blocks.Math;
block RectangularToPolar
  "Convert rectangular coordinates to polar coordinates"
  extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Interfaces.RealInput u_re
    "Real part of rectangular representation" annotation (Placement(
        transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput u_im
    "Imaginary part of rectangular representation" annotation (Placement(
        transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput y_abs
    "Length of polar representation" annotation (Placement(transformation(
          extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput y_arg(unit="rad") "Angle of polar representation"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));

equation
  y_abs = sqrt(u_re*u_re + u_im*u_im);
  y_arg = Modelica.Math.atan2(u_im, u_re);
  annotation (Icon(graphics={
        Text(
          extent={{-90,80},{-20,40}},
          textString="re"),
        Text(
          extent={{-90,-40},{-20,-80}},
          textString="im"),
        Text(
          extent={{20,80},{90,40}},
          textString="abs"),
        Text(
          extent={{20,-40},{90,-80}},
          textString="arg")}), Documentation(info="<html>
<p>
The input values of this block are the rectangular components
<code>u_re</code> and <code>u_im</code> of a phasor in two dimensions.
This block calculates the length <code>y_abs</code> and
the angle <code>y_arg</code> of the polar representation of this phasor.
</p>

<blockquote><pre>
y_abs = abs(u_re + j*u_im) = sqrt( u_re<sup>2</sup> + u_im<sup>2</sup> )
y_arg = arg(u_re + j*u_im) = atan2(u_im, u_re)
</pre></blockquote>
</html>"));
end RectangularToPolar;
