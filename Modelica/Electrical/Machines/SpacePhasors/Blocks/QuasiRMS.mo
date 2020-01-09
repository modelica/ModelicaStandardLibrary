within Modelica.Electrical.Machines.SpacePhasors.Blocks;
block QuasiRMS
  extends Modelica.Blocks.Interfaces.MISO(final nin=2);
  Modelica.Electrical.Machines.SpacePhasors.Blocks.ToPolar toPolar
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Math.Gain gain(final k=1/sqrt(2))
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(u, toPolar.u) annotation (Line(
      points={{-120,0},{-42,0}}, color={0,0,127}));
  connect(toPolar.y[1], gain.u) annotation (Line(
      points={{-19,0},{0,0},{0,0},{18,0}},       color={0,0,127}));
  connect(gain.y, y) annotation (Line(
      points={{41,0},{110,0}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
This model determines the RMS value of the input space phasor <code>u</code>.</p> </html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Text(
                extent={{-60,40},{60,-20}},
                textColor={0,0,255},
                textString="RMS")}));
end QuasiRMS;
