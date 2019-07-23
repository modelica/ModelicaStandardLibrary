within Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces;
connector NegativeMagneticPort "Negative quasi-static magnetic port"
  extends Magnetic.QuasiStatic.FundamentalWave.Interfaces.MagneticPort;
  Modelica.Electrical.QuasiStatic.Types.Reference reference "Reference";
  annotation (
    defaultComponentName="port_n",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
            graphics={Text(
              extent={{-100,100},{100,60}},
              textColor={255,170,85},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              textString="%name"), Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={255,170,85},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
         graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={255,170,85},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
The negative magnetic port is based on the
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.MagneticPort\">MagneticPort</a>.
Additionally the reference angle is specified in the connector. The time derivative of the
reference angle is the actual angular frequency of the quasi-static magnetic potential and flux.
The symbol is also designed such way to look different than the
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.MagneticPort\">MagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Interfaces.NegativeMagneticPort\">Magnetic.FluxTubes.Interfaces.NegativeMagneticPort</a>
</p>
</html>"));
end NegativeMagneticPort;
