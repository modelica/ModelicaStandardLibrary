within Modelica.Electrical.Polyphase.Basic;
model SplitToSubsystems "Split m phases to subsystems"
  import Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems;
  parameter Integer m(min=1) = 3 "Number of phases" annotation(Evaluate=true);
  final parameter Integer mSystems=numberOfSymmetricBaseSystems(m)
    "Number of base systems";
  final parameter Integer mBasic=integer(m/mSystems)
    "Phase number of base systems";
  Interfaces.PositivePlug plug_p(final m=m)
    "Positive polyphase electrical plug with m pins" annotation (Placement(transformation(
          extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePlug plugs_n[mSystems](each final m=mBasic)
    "mSystems negative polyphase electrical plugs with mBasic pins each"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  for k in 1:mSystems loop
    for j in 1:mBasic loop
      connect(plug_p.pin[(k - 1)*mBasic + j], plugs_n[k].pin[j]);
    end for;
  end for;
  annotation (Documentation(info="<html>
<p>
Splits the m phases in plug_p into subsystems, i.e., mSystems plugs with mBasic pins according to
<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.PhaseOrientation\">phase orientation</a> described in the users guide.
</p>
</html>"), Icon(graphics={
        Text(
          extent={{-150,60},{150,100}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-110},{150,-70}},
          textString="m=%m"),
        Line(points={{-90,0},{-20,0}}, color={0,0,255}),
        Line(points={{-90,2},{-20,2}}, color={0,0,255}),
        Line(points={{-90,-2},{-20,-2}},
                                       color={0,0,255}),
        Line(points={{-20,0},{90,0}},  color={0,0,255},
          pattern=LinePattern.Dot),
        Line(points={{-20,2},{-0.78125,10},{100,10}},
                                       color={0,0,255}),
        Line(points={{-20,-2},{-0.7812,-10},{100,-10}},
                                       color={0,0,255})}));
end SplitToSubsystems;
