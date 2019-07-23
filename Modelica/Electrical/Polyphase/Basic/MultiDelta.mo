within Modelica.Electrical.Polyphase.Basic;
model MultiDelta
  "Delta (polygon) connection of polyphase systems consisting of multiple base systems"
  parameter Integer m(final min=2) = 3 "Number of phases";
  final parameter Integer mSystems=
      Polyphase.Functions.numberOfSymmetricBaseSystems(
      m) "Number of base systems";
  final parameter Integer mBasic=integer(m/mSystems)
    "Phase number of base systems";

  Polyphase.Interfaces.PositivePlug plug_p(final m=m)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Polyphase.Interfaces.NegativePlug plug_n(final m=m)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  for k in 1:mSystems loop
    for j in 1:mBasic - 1 loop
      connect(plug_n.pin[(k - 1)*mBasic + j], plug_p.pin[(k - 1)*mBasic + j
         + 1]);
    end for;
    connect(plug_n.pin[k*mBasic], plug_p.pin[(k - 1)*mBasic + 1]);
  end for;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Line(points={{-90,0},{-46,0}}, color={0,0,255}),
        Line(
          points={{-44,62},{-44,-76},{75,-6},{-44,62},{-44,61}},
          thickness=0.5,
          color={0,0,255}),
        Line(points={{80,0},{90,0}}, color={0,0,255}),
        Line(
          points={{-36,74},{-36,-64},{83,6},{-36,74},{-36,73}},
          thickness=0.5,
          color={0,0,255}),
        Text(
          extent={{-150,-110},{150,-70}},
          textString="m=%m"),
        Text(
          extent={{-150,70},{150,110}},
          textString="%name",
          textColor={0,0,255})}),
                              Documentation(info="<html>
<p>
Delta (polygon) connection of a polyphase circuit consisting of multiple base systems (see
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.Polyphase\">polyphase guidelines</a>).
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.Star\">Star</a>,
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.Delta\">Delta</a>,
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MultiStar\">MultiStar</a>
</p>
</html>"));
end MultiDelta;
