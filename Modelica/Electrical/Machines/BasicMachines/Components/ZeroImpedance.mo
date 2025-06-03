within Modelica.Electrical.Machines.BasicMachines.Components;
model ZeroImpedance "Zero system impedance"
  extends Analog.Interfaces.OnePort(i(start=0));
  parameter SI.Inductance L "Inductance";
  parameter Boolean useZeroSystem=true "= true, if zero current is explicitely computed";
equation
  if useZeroSystem then
    v = L*der(i);
  else
    i = 0;
  end if;

  annotation (Icon(graphics={
        Line(points={{-90,0},{-60,0}}, color={0,0,255}),
        Line(points={{62,0},{90,0}}, color={0,0,255}),
        Ellipse(extent={{-50,30},{-8,-32}}, lineColor={0,0,255}),
        Ellipse(extent={{-20,30},{22,-32}}, lineColor={0,0,255}),
        Ellipse(extent={{10,30},{52,-32}}, lineColor={0,0,255}),
        Text(
          extent={{-150,50},{150,90}},
          textString="%name",
          textColor={0,0,255}),
        Rectangle(extent={{-60,30},{-50,-32}}, lineColor={28,108,200}),
        Rectangle(extent={{52,30},{62,-32}}, lineColor={28,108,200})}),
      Documentation(info="<html>
<p>
For a short explanation of the zero system see <a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.ZeroSystem\">the User&apos;s Guide of the FundamentalWave library</a>.
</p>
</html>"));
end ZeroImpedance;
