within Modelica.Electrical.Analog.Interfaces;
partial model TwoPin "Component with two electrical pins"
  SI.Voltage v "Voltage drop of the two pins (= p.v - n.v)";

  PositivePin p "Positive electrical pin"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  NegativePin n "Negative electrical pin"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  v = p.v - n.v;
  annotation (
    Documentation(revisions = "<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",
        info = "<html>
<p>TwoPin is a partial model with two pins and one internal variable for the voltage over the two pins. Internal currents are not defined. It is intended to be used in cases where the model which inherits TwoPin is composed by combining other components graphically, not by equations.</p>
</html>"));
end TwoPin;
