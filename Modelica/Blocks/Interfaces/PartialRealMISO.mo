within Modelica.Blocks.Interfaces;
partial block PartialRealMISO
  "Partial block with a RealVectorInput and a RealOutput signal"

  parameter Integer significantDigits(min=1) = 3
    "Number of significant digits to be shown in dynamic diagram layer for y"
    annotation (Dialog(tab="Advanced"));
  parameter Integer nu(min=0) = 0 "Number of input connections"
    annotation (Dialog(connectorSizing=true), HideResult=true);
  Modelica.Blocks.Interfaces.RealVectorInput u[nu]
    annotation (Placement(transformation(extent={{-120,70},{-80,-70}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-17},{134,17}})));
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.06), graphics={
        Text(
          extent={{110,-50},{300,-70}},
          textString=DynamicSelect(" ", String(y, significantDigits=
              significantDigits))),
        Text(
          extent={{-250,170},{250,110}},
          textString="%name",
          textColor={0,0,255}),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={255,137,0},
          fillColor={255,255,255},
          borderPattern=BorderPattern.Raised,
          fillPattern=FillPattern.Solid)}));
end PartialRealMISO;
