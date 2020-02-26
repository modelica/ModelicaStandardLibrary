within Modelica.Clocked.ClockSignals.Interfaces;
partial block ClockedBlockIcon
  "Basic graphical layout of block where at least one input or output is a clocked variable"
  annotation (
    Icon(graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255})}));
end ClockedBlockIcon;
