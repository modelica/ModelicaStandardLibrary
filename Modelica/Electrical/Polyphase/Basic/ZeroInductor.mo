within Modelica.Electrical.Polyphase.Basic;
model ZeroInductor "Linear zero sequence inductor"
  extends Polyphase.Interfaces.OnePort;
  parameter SI.Inductance Lzero "Zero sequence inductance";
  parameter Boolean useZeroSystem=true "Suppresses zero current, if false";
  SI.Current i0;
  SI.Voltage v0;
equation
  m*i0 = sum(i);
  if useZeroSystem then
    v0 = Lzero*der(i0);
  else
    i0 = 0;
  end if;
  v = fill(v0, m);
  annotation (defaultComponentName="inductor", Documentation(info="<html>
<p>
Model of a polyphase zero sequence inductor.
For a short explanation of the zero system see <a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.ZeroSystem\">the User&apos;s Guide of the FundamentalWave library</a>.
</p>
<h4>Implementation</h4>
<blockquote><pre>
v = Lzero*sum(der(i)) = Lzero*der(sum(i))
</pre></blockquote>

</html>"),
       Icon(graphics={
        Line(points={{-90,0},{-50,0}}, color={0,0,255}),
        Line(points={{52,0},{90,0}}, color={0,0,255}),
        Ellipse(extent={{-50,30},{-8,-32}}, lineColor={0,0,255}),
        Ellipse(extent={{-20,30},{22,-32}}, lineColor={0,0,255}),
        Ellipse(extent={{10,30},{52,-32}}, lineColor={0,0,255}),
        Text(
          extent={{-150,50},{150,90}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-80},{150,-40}},
          textString="m=%m"),
        Rectangle(extent={{-60,30},{-50,-32}}, lineColor={28,108,200}),
        Rectangle(extent={{52,30},{62,-32}},   lineColor={28,108,200})}));
end ZeroInductor;
