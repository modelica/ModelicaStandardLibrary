within Modelica.Blocks.Interfaces;
partial block partialBooleanSI "Partial block with 1 input Boolean signal"
  extends Modelica.Blocks.Icons.PartialBooleanBlock;

  Blocks.Interfaces.BooleanInput u "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Ellipse(
          extent={{-71,7},{-85,-7}},
          lineColor=DynamicSelect({235,235,235}, if u then {0,255,0} else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if u then {0,255,0} else {235,235,235}),
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
Block has one continuous Boolean input signal
with a 3D icon (e.g., used in Blocks.Logical library).
</p>
</html>"));

end partialBooleanSI;
