within Modelica.Magnetic.FluxTubes.Interfaces;
connector NegativeMagneticPort "Negative magnetic port"
  extends FluxTubes.Interfaces.MagneticPort;

  annotation (
    defaultComponentName="port_n",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={255,127,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Text(
          extent={{100,160},{100,100}},
          textColor={255,127,0},
          textString="%name"), Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={255,127,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}));

end NegativeMagneticPort;
