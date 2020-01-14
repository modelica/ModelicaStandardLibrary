within Modelica.Mechanics.Rotational.Interfaces;
connector Flange_b
  "One-dimensional rotational flange of a shaft (non-filled circle icon)"
  extends Flange;

  annotation (
    defaultComponentName="flange_b",
    Documentation(info="<html>
<p>
This is a connector for 1-dim. rotational mechanical systems and models which represents
a mechanical flange of a shaft. The following variables are defined in this connector:
</p>

<blockquote><pre>
phi: Absolute rotation angle of the shaft flange in [rad].
tau: Cut-torque in the shaft flange in [Nm].
</pre></blockquote>

<p>
There is a second connector for flanges:
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.Flange_a\">Flange_a</a>.
The connectors
Flange_a and Flange_b are completely identical. There is only a difference
in the icons, in order to easier identify a flange variable in a diagram.
For a discussion on the actual direction of the cut-torque tau and
of the rotation angle, see section
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.SignConventions\">Sign Conventions</a>
in the user's guide of Rotational.
</p>

<p>
If needed, the absolute angular velocity w and the
absolute angular acceleration a of the flange can be determined by
differentiation of the flange angle phi:
</p>

<blockquote><pre>
w = der(phi);
a = der(w);
</pre></blockquote>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={Ellipse(
              extent={{-100,100},{100,-100}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={Ellipse(
              extent={{-40,40},{40,-40}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Text(
              extent={{-40,90},{160,50}},
              textString="%name")}));
end Flange_b;
