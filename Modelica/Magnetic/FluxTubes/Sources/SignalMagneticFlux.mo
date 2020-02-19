within Modelica.Magnetic.FluxTubes.Sources;
model SignalMagneticFlux "Signal-controlled magnetic flux source"

  extends Interfaces.TwoPortElementary;
  Modelica.Blocks.Interfaces.RealInput Phi(unit="Wb") "Magnetic flux" annotation (
      Placement(transformation(
        origin={0,110},
        extent={{10,-10},{-10,10}},
        rotation=90), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,110})));
  SI.MagneticPotentialDifference V_m
    "Magnetic potential difference between both ports";

equation
  V_m = port_p.V_m - port_n.V_m;
  Phi = port_p.Phi;
  0 = port_p.Phi + port_n.Phi;
  annotation (
    defaultComponentName="magFluxSource",
    Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
      Polygon(
        points={{80,0},{60,6},{60,-6},{80,0}},
        lineColor={255,128,0},
        fillColor={255,128,0},
        fillPattern=FillPattern.Solid),
      Text(
        extent={{-150,50},{150,90}},
        textString="%name",
        textColor={0,0,255}),
      Line(points={{-100,0},{-50,0}}, color={255,127,0}),
      Line(points={{50,0},{100,0}}, color={255,127,0}),
      Ellipse(
        extent={{-50,-50},{50,50}},
        lineColor={255,127,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Line(points={{0,50},{0,-50}}, color={255,127,0})}),
    Documentation(info="<html>
<p>
This source of a magnetic flux is intended for test purposes, e.g., for simulation and subsequent plotting of a softmagnetic material's magnetisation characteristics if used together with a non-linear reluctance element.
</p>
</html>"));
end SignalMagneticFlux;
