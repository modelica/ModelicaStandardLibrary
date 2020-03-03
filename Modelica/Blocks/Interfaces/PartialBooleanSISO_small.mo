within Modelica.Blocks.Interfaces;
partial block PartialBooleanSISO_small
  "Partial block with a BooleanInput and a BooleanOutput signal and a small block icon"

  Modelica.Blocks.Interfaces.BooleanInput u "Boolean input signal"
    annotation (Placement(transformation(extent={{-180,-40},{-100,40}})));
  Modelica.Blocks.Interfaces.BooleanOutput y "Boolean output signal"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.04), graphics={
        Text(
          extent={{-300,200},{300,120}},
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
end PartialBooleanSISO_small;
