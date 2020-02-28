within Modelica.Electrical.Analog.Sources;
model SignalVoltage
  "Generic voltage source using the input signal as source voltage"
  extends Modelica.Electrical.Analog.Icons.VoltageSource;
  Interfaces.PositivePin p annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}})));
  Interfaces.NegativePin n annotation (Placement(transformation(extent={{110,
            -10},{90,10}})));
  Modelica.Blocks.Interfaces.RealInput v(unit="V")
    "Voltage between pin p and n (= p.v - n.v) as input signal" annotation (
      Placement(transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  SI.Current i "Current flowing from pin p to pin n";
equation
  v = p.v - n.v;
  0 = p.i + n.i;
  i = p.i;
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
                            Line(points={{-109,20},{-84,
          20}}, color={160,160,164}),Polygon(
            points={{-94,23},{-84,20},{-94,17},{-94,23}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),Line(points={{91,20},{116,20}},
          color={160,160,164}),Text(
            extent={{-109,25},{-89,45}},
            textColor={160,160,164},
            textString="i"),Polygon(
            points={{106,23},{116,20},{106,17},{106,23}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),Text(
            extent={{91,45},{111,25}},
            textColor={160,160,164},
            textString="i"),Line(points={{-119,-5},{-119,5}}, color={160,160,164}),
          Line(points={{-124,0},{-114,0}}, color={160,160,164}),Line(
          points={{116,0},{126,0}}, color={160,160,164})}),
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Martin Otter<br> initially implemented<br>
       </li>
</ul>
</html>",
        info="<html>
<p>The signal voltage source is a parameterless converter of real valued signals into a the source voltage. No further effects are modeled. The real valued signal has to be provided by components of the blocks library. It can be regarded as the &quot;Opposite&quot; of a voltage sensor.</p>
</html>"));
end SignalVoltage;
