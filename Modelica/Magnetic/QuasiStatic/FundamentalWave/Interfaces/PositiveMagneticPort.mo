within Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces;
connector PositiveMagneticPort "Positive quasi-static magnetic port of fundamental wave machines"
  extends FundamentalWave.Interfaces.MagneticPort;
  Modelica.Electrical.QuasiStatic.Types.Reference reference "Reference";
  annotation (
    defaultComponentName="port_p",
    Diagram(graphics={Text(
          extent={{-100,100},{100,60}},
          textColor={255,170,85},
          textString="%name"), Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={255,170,85},
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid)}),
    Icon(graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={255,170,85},
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>

<p>
The positive port is based on
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.MagneticPort\">MagneticPort</a>.
Additionally the reference angle is specified in the connector. The time derivative of the reference angle is the actual angular velocity of the quasi-static voltage and current. The symbol is also designed such way to look different than the
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.MagneticPort\">MagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>
</p>
</html>"));
end PositiveMagneticPort;
