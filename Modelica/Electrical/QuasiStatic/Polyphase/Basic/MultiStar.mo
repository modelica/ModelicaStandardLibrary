within Modelica.Electrical.QuasiStatic.Polyphase.Basic;
model MultiStar
  "Star connection of polyphase systems consisting of multiple base systems"
  import Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems;
  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  final parameter Integer mSystems=numberOfSymmetricBaseSystems(m) "Number of base systems";
  final parameter Integer mBasic=integer(m/mSystems) "Phase number of base systems";
  QuasiStatic.Polyphase.Interfaces.PositivePlug plug_p(final m=m)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  QuasiStatic.Polyphase.Interfaces.NegativePlug starpoints(final m=mSystems)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  QuasiStatic.Polyphase.Basic.PlugToPins_p plugToPins_p(final m=m)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  QuasiStatic.Polyphase.Basic.PlugToPins_n plugToPins_n(final m=mSystems)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
equation
  for k in 1:mSystems loop
    for j in 1:mBasic loop
      connect(plugToPins_p.pin_p[(k - 1)*mBasic + j], plugToPins_n.pin_n[k]);
    end for;
  end for;
  connect(plug_p, plugToPins_p.plug_p)
    annotation (Line(points={{-100,0},{-72,0}}, color={85,170,255}));
  connect(plugToPins_n.plug_n, starpoints) annotation (Line(
      points={{72,0},{100,0}}, color={85,170,255}));
  annotation (
    Icon(graphics={Line(
              points={{86,4},{6,4}},
              color={85,170,255},
              thickness=0.5),Line(
              points={{6,4},{-33,72}},
              color={85,170,255},
              thickness=0.5),Line(
              points={{6,4},{-32,-65}},
              color={85,170,255},
              thickness=0.5), Line(points={{-90,0},{-40,0}}, color={85,170,255}),
          Line(points={{80,0},{90,0}}, color={85,170,255}),
                                                        Line(
              points={{-6,-4},{-45,64}},
              color={85,170,255},
              thickness=0.5),Line(
              points={{74,-4},{-6,-4}},
              color={85,170,255},
              thickness=0.5),Line(
              points={{-6,-4},{-44,-73}},
              color={85,170,255},
              thickness=0.5),
        Text(
          extent={{-150,70},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-110},{150,-70}},
          textString="m=%m")}),
    Documentation(info="<html>
<p>
Star (wye) connection of a polyphase circuit consisting of multiple base systems (see
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.Polyphase\">polyphase guidelines</a>). The potentials at the star points are all equal.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star\">Star</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Delta\">Delta</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.MultiDelta\">MultiDelta</a>
</p></html>"));
end MultiStar;
