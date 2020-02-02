within Modelica.Electrical.Polyphase.Interfaces;
partial model TwoPlug "Component with one polyphase electrical port"
  parameter Integer m(min=1) = 3 "Number of phases" annotation(Evaluate=true);
  SI.Voltage v[m] "Voltage drops of the two polyphase plugs";
  SI.Current i[m] "Currents flowing into positive polyphase plugs";
  PositivePlug plug_p(final m=m) "Positive polyphase electrical plug with m pins" annotation (Placement(transformation(
          extent={{-110,-10},{-90,10}})));
  NegativePlug plug_n(final m=m) "Negative polyphase electrical plug with m pins" annotation (Placement(transformation(
          extent={{90,-10},{110,10}})));
equation
  v = plug_p.pin.v - plug_n.pin.v;
  i = plug_p.pin.i;
  annotation (Documentation(info="<html>
<p>
Superclass of elements which have <strong>two</strong> electrical plugs:
the positive plug connector <em>plug_p</em>, and the negative plug connector <em>plug_n</em>.
The currents flowing into plug_p are provided explicitly as currents i[m].
</p>
</html>"));
end TwoPlug;
