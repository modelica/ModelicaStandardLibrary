within Modelica.Electrical.Analog.Sources;
model SignalCurrent
  "Generic current source using the input signal as source current"
  extends Modelica.Electrical.Analog.Icons.CurrentSource;
  Interfaces.PositivePin p annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}})));
  Interfaces.NegativePin n annotation (Placement(transformation(extent={{110,
            -10},{90,10}})));
  Modelica.Blocks.Interfaces.RealInput i(unit="A")
    "Current flowing from pin p to pin n as input signal" annotation (
      Placement(transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  SI.Voltage v "Voltage drop between the two pins (= p.v - n.v)";
equation
  v = p.v - n.v;
  0 = p.i + n.i;
  i = p.i;
  annotation (
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Martin Otter<br> initially implemented<br>
       </li>
</ul>
</html>",
        info="<html>
<p>The signal current source is a parameterless converter of real valued signals into a the source current. No further effects are modeled. The real valued signal has to be provided by components of the blocks library. It can be regarded as the &quot;Opposite&quot; of a current sensor.</p>
</html>"));
end SignalCurrent;
