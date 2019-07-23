within Modelica.Magnetic.FundamentalWave.Interfaces;
connector PositiveMagneticPort "Positive magnetic port of fundamental wave machines"
  extends Magnetic.FundamentalWave.Interfaces.MagneticPort;
  annotation (
    defaultComponentName="port_p",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Text(
          extent={{-60,100},{-60,60}},
          textColor={255,128,0},
          textString="%name"), Ellipse(
          extent={{-50,50},{50,-50}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
Positive magnetic <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.MagneticPort\">port</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.MagneticPort\">MagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>
</p>

</html>"));
end PositiveMagneticPort;
