within Modelica.Blocks.Interfaces;
partial block partialBooleanSI2SO
  "Partial block with 2 input and 1 output Boolean signal"
  extends Modelica.Blocks.Icons.PartialBooleanBlock;
  Blocks.Interfaces.BooleanInput u1 "Connector of first Boolean input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Blocks.Interfaces.BooleanInput u2
    "Connector of second Boolean input signal" annotation (Placement(
        transformation(extent={{-140,-100},{-100,-60}})));
  Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  annotation (Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-71,7},{-85,-7}},
          lineColor=DynamicSelect({235,235,235}, if u1 then {0,255,0} else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u1 then {0,255,0} else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-71,-74},{-85,-88}},
          lineColor=DynamicSelect({235,235,235}, if u2 then {0,255,0} else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u2 then {0,255,0} else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{71,7},{85,-7}},
          lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
Block has two continuous Boolean input and one continuous Boolean output signal
with a 3D icon (e.g., used in Blocks.Logical library).
</p>
</html>"));

end partialBooleanSI2SO;
