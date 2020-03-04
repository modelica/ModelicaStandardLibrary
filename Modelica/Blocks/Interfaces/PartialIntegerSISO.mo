within Modelica.Blocks.Interfaces;
partial block PartialIntegerSISO
  "Partial block with a IntegerInput and an IntegerOutput signal"

  Modelica.Blocks.Interfaces.IntegerInput u "Integer input signal"
    annotation (Placement(transformation(extent={{-180,-40},{-100,40}})));
  Modelica.Blocks.Interfaces.IntegerOutput y "Integer output signal"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=false,
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
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised)}));
end PartialIntegerSISO;
