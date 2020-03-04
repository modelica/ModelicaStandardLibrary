within Modelica.Blocks.Interfaces;
partial block partialBooleanSISO
  "Partial block with 1 input and 1 output Boolean signal"
  extends Modelica.Blocks.Icons.PartialBooleanBlock;
  Blocks.Interfaces.BooleanInput u "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Ellipse(
          extent={{-71,7},{-85,-7}},
          lineColor=DynamicSelect({235,235,235}, if u then {0,255,0} else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u then {0,255,0} else {235,235,235}),
          fillPattern=FillPattern.Solid), Ellipse(
          extent={{71,7},{85,-7}},
          lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
Block has one continuous Boolean input and one continuous Boolean output signal
with a 3D icon (e.g., used in Blocks.Logical library).
</p>
</html>"));

end partialBooleanSISO;
