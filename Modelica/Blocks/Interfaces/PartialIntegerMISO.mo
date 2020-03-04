within Modelica.Blocks.Interfaces;
partial block PartialIntegerMISO
  "Partial block with an IntegerVectorInput and an IntegerOutput signal"

  parameter Integer nu(min=0) = 0 "Number of input connections"
    annotation (Dialog(connectorSizing=true), HideResult=true);
  Modelica.Blocks.Interfaces.IntegerVectorInput u[nu]
    "Vector of Integer input signals"
    annotation (Placement(transformation(extent={{-120,70},{-80,-70}})));
  Modelica.Blocks.Interfaces.IntegerOutput y "Integer output signal"
    annotation (Placement(transformation(extent={{100,-15},{130,15}})));
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.06), graphics={
        Text(
          extent={{110,-50},{250,-70}},
          textString=DynamicSelect(" ", String(
                y,
                minimumLength=1,
                significantDigits=0))),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={255,137,0},
          fillColor={255,213,170},
          borderPattern=BorderPattern.Raised,
          fillPattern=FillPattern.Solid)}));
end PartialIntegerMISO;
