within Modelica.Electrical.Polyphase.Interfaces;
partial model OnePort
  "Component with two electrical plugs and currents from plug_p to plug_n"

  extends TwoPlug;
equation
  plug_p.pin.i + plug_n.pin.i = zeros(m);
  annotation (Documentation(info="<html>
<p>
Superclass of elements which have <strong>two</strong> electrical plugs:
the positive plug connector <em>plug_p</em>, and the negative plug connector <em>plug_n</em>.
The currents flowing into plug_p are provided explicitly as currents i[m].
It is assumed that the currents flowing into plug_p are identical to the currents flowing out of plug_n.
</p>
</html>"));
end OnePort;
