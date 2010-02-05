within Modelica.Magnetic.FundamentalWave.Interfaces;
connector PositiveMagneticPort "Positive complex magnetic port"

  extends Modelica.Magnetic.FundamentalWave.Interfaces.MagneticPort;
  annotation (defaultName="port_p",
    Icon(graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid)}),
                            Diagram(graphics={Text(
          extent={{-60,100},{-60,60}},
          lineColor={255,128,0},
          textString=
               "%name"), Ellipse(
          extent={{-50,50},{50,-50}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid)}),
  Documentation(info="<html>
<p>
Positive magnetic <a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Interfaces.MagneticPort\">port</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Interfaces.MagneticPort\">MagneticPort</a>,
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>
</p>

</html>"));
end PositiveMagneticPort;
