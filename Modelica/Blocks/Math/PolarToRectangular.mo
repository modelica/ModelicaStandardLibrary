within Modelica.Blocks.Math;
block PolarToRectangular
  "Convert polar coordinates to rectangular coordinates"
  extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Interfaces.RealInput u_abs "Length of polar representation"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput u_arg(unit="rad") "Angle of polar representation"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput y_re
    "Real part of rectangular representation" annotation (Placement(
        transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput y_im
    "Imaginary part of rectangular representation" annotation (Placement(
        transformation(extent={{100,-70},{120,-50}})));

equation
  y_re = u_abs*Modelica.Math.cos(u_arg);
  y_im = u_abs*Modelica.Math.sin(u_arg);
  annotation (Icon(graphics={
        Text(
          extent={{-90,80},{-20,40}},
          textString="abs"),
        Text(
          extent={{-90,-40},{-20,-80}},
          textString="arg"),
        Text(
          extent={{20,80},{90,40}},
          textString="re"),
        Text(
          extent={{20,-40},{90,-80}},
          textString="im")}), Documentation(info="<html>
<p>
The input values of this block are the polar components <code>uabs</code> and <code>uarg</code> of a phasor.
This block calculates the components <code>y_re</code> and <code>y_im</code> of the rectangular representation of this phasor.
</p>
<blockquote><pre>
y_re = u_abs * cos( u_arg )
y_im = u_abs * sin( u_arg )
</pre></blockquote>
</html>"));
end PolarToRectangular;
