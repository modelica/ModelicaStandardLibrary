within Modelica.Electrical.Polyphase.Interfaces;
partial model FourPlug "Component with two polyphase electrical ports"
  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  SI.Voltage v1[m] "Voltage drops of port 1";
  SI.Voltage v2[m] "Voltage drops of port 2";
  SI.Current i1[m]
    "Currents flowing into positive polyphase plug of port 1";
  SI.Current i2[m]
    "Currents flowing into positive polyphase plug of port 2";
  PositivePlug plug_p1(final m=m) "Positive electrical polyphase plug of port 1 with m pins" annotation (Placement(transformation(
          extent={{-110,90},{-90,110}})));
  PositivePlug plug_p2(final m=m) "Positive electrical polyphase plug of port 2 with m pins" annotation (Placement(transformation(
          extent={{90,90},{110,110}})));
  NegativePlug plug_n1(final m=m) "Negative electrical polyphase plug of port 1 with m pins" annotation (Placement(transformation(
          extent={{-110,-110},{-90,-90}})));
  NegativePlug plug_n2(final m=m) "Negative electrical polyphase plug of port 2 with m pins" annotation (Placement(transformation(
          extent={{90,-110},{110,-90}})));
equation
  v1 = plug_p1.pin.v - plug_n1.pin.v;
  v2 = plug_p2.pin.v - plug_n2.pin.v;
  i1 = plug_p1.pin.i;
  i2 = plug_p2.pin.i;
  annotation (Documentation(info="<html>
<p>
Superclass of elements which have <strong>four</strong> electrical plugs.
</p>
</html>"));
end FourPlug;
