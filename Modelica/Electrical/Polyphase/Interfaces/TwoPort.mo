within Modelica.Electrical.Polyphase.Interfaces;
partial model TwoPort
  "Component with two polyphase electrical ports, including currents"
  extends FourPlug;
equation
  plug_p1.pin.i + plug_n1.pin.i = zeros(m);
  plug_p2.pin.i + plug_n2.pin.i = zeros(m);
  annotation (Documentation(info="<html>
<p>
Superclass of elements which have <strong>four</strong> electrical plugs.
It is assumed that the currents flowing into plug_p1 are identical to the currents flowing out of plug_n1,
and that the currents flowing into plug_p2 are identical to the currents flowing out of plug_n2.
</p>
</html>"));
end TwoPort;
