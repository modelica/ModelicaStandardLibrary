within Modelica.Magnetic.FluxTubes.Interfaces;
partial model TwoPortElementary "Interface component with two magnetic ports for textual programming"

  FluxTubes.Interfaces.PositiveMagneticPort port_p "Positive magnetic port"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  FluxTubes.Interfaces.NegativeMagneticPort port_n "Negative magnetic port"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  annotation (Documentation(info="<html>
<p>
Partial model of a flux tube component with two magnetic ports:
the positive port connector port_p, and the negative port
connector port_n.
</p>
</html>"));
end TwoPortElementary;
