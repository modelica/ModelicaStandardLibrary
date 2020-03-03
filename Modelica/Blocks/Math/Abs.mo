within Modelica.Blocks.Math;
block Abs "Output the absolute value of the input"
  extends Interfaces.SISO;
  parameter Boolean generateEvent=false
    "Choose whether events shall be generated" annotation (Evaluate=true);
equation
  //y = abs(u);
  y = if generateEvent then (if u >= 0 then u else -u) else (if noEvent(u >=
    0) then u else -u);
  annotation (
    defaultComponentName="abs1",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Polygon(
          points={{92,0},{70,8},{70,-8},{92,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,80},{0,0},{80,80}}),
        Line(points={{0,-14},{0,68}}, color={192,192,192}),
        Polygon(
          points={{0,90},{-8,68},{8,68},{0,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-34,-28},{38,-76}},
          textColor={192,192,192},
          textString="abs"),
        Line(points={{-88,0},{76,0}}, color={192,192,192})}),
    Documentation(info="<html>
<p>
This blocks computes the output <strong>y</strong>
as <em>absolute value</em> of the input <strong>u</strong>:
</p>
<blockquote><pre>
y = <strong>abs</strong>( u );
</pre></blockquote>
<p>
The Boolean parameter generateEvent decides whether Events are generated at zero crossing (Modelica specification before 3) or not.
</p>
</html>"));
end Abs;
