within Modelica.Mechanics.Rotational.Components;
model Disc
  "1-dim. rotational rigid component without inertia, where right flange is rotated by a fixed angle with respect to left flange"
  extends Rotational.Interfaces.PartialTwoFlanges;
  parameter SI.Angle deltaPhi=0
    "Fixed rotation of left flange with respect to right flange (= flange_b.phi - flange_a.phi)";
  SI.Angle phi "Absolute rotation angle of component";

equation
  flange_a.phi = phi - deltaPhi/2;
  flange_b.phi = phi + deltaPhi/2;
  0 = flange_a.tau + flange_b.tau;
  annotation (Documentation(info="<html>
<p>
Rotational component with two rigidly connected flanges <strong>without inertia</strong>.
The right flange is rotated by the fixed angle \"deltaPhi\" with respect to the left
flange.
</p>
</html>"),
       Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
        Rectangle(lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-30.0,10.0},{-10.0,50.0}}),
        Rectangle(lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{10.0,-50.0},{30.0,-10.0}}),
        Rectangle(
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-10.0},{100.0,10.0}}),
        Rectangle(lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-10.0,-50.0},{10.0,50.0}}),
        Text(extent={{-160.0,-87.0},{160.0,-62.0}},
          textString="deltaPhi = %deltaPhi"),
        Text(textColor={0,0,255},
          extent={{-150.0,60.0},{150.0,100.0}},
          textString="%name")}));
end Disc;
