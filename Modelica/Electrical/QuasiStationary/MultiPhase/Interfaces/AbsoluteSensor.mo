within Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces;
partial model AbsoluteSensor "Partial potential sensor"
  extends Modelica.Icons.RotationalSensor;
  parameter Integer m(min=1) = 3 "number of phases";
  Modelica.SIunits.AngularVelocity omega = der(plug_p.reference.gamma);
  PositivePlug plug_p(final m=m)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput y[m]
    annotation (Placement(transformation(extent={{100,-10},{120,10}}, rotation=
            0)));
  Basic.PlugToPins_p plugToPins_p(final m=m)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}}, rotation=
            0)));
equation
  connect(plug_p, plugToPins_p.plug_p)
      annotation (Line(
      points={{-100,0},{-93,0},{-93,1.16573e-015},{-86,1.16573e-015},{-86,0},{-72,
          0}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
                       Icon(graphics={
        Line(points={{-70,0},{-94,0}}, color={0,0,0}),
        Text(
          extent={{-100,100},{100,70}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={170,85,255},
          fillPattern=FillPattern.Solid,
          textString=
               "%name"),
        Line(points={{70,0},{80,0},{90,0},{100,0}}, color={85,170,255}),
        Text(
          extent={{100,-100},{-100,-70}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString=
               "m=%m")}),
  Documentation(info="<html>

<p>
The absolute sensor partial model relies on the a
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">positive plug</a> to measure the complex potential. Additionally this model contains a proper icon and a definition of the angular velocity.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.RelativeSensor\">RelativeSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.AbsoluteSensor\">SinglePhase.Interfaces.AbsoluteSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.RelativeSensor\">SinglePhase.Interfaces.RelativeSensor</a>
</p>

</html>"));
end AbsoluteSensor;
