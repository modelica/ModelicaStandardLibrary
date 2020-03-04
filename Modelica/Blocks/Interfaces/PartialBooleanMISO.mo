within Modelica.Blocks.Interfaces;
partial block PartialBooleanMISO
  "Partial block with a BooleanVectorInput and a BooleanOutput signal"

  parameter Integer nu(min=0) = 0 "Number of input connections"
    annotation (Dialog(connectorSizing=true), HideResult=true);
  Modelica.Blocks.Interfaces.BooleanVectorInput u[nu]
    "Vector of Boolean input signals"
    annotation (Placement(transformation(extent={{-120,70},{-80,-70}})));
  Modelica.Blocks.Interfaces.BooleanOutput y "Boolean output signal"
    annotation (Placement(transformation(extent={{100,-15},{130,15}})));
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.06), graphics={
        Text(
          extent={{-250,170},{250,110}},
          textString="%name",
          textColor={0,0,255}),
        Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
        Ellipse(
          extent={{60,10},{80,-10}},
          lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
          fillPattern=FillPattern.Solid)}));
end PartialBooleanMISO;
