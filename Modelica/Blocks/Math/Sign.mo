within Modelica.Blocks.Math;
block Sign "Output the sign of the input"
  extends Interfaces.SISO;
  parameter Boolean generateEvent=false
    "Choose whether events shall be generated" annotation (Evaluate=true);
equation
  //y = sign(u);
  y = if generateEvent then (if u > 0 then 1 elseif u < 0 then -1 else 0)
     else (if noEvent(u > 0) then 1 elseif noEvent(u < 0) then -1 else 0);
  annotation (
    defaultComponentName="sign1",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{0,-80}}),
        Polygon(
          points={{0,90},{-8,68},{8,68},{0,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-80},{0,68}}, color={192,192,192}),
        Text(
          extent={{-90,72},{-18,24}},
          textColor={192,192,192},
          textString="sign"),
        Line(points={{0,80},{80,80}}),
        Rectangle(
          extent={{-2,2},{2,-4}},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This blocks computes the output <strong>y</strong>
as <strong>sign</strong> of the input <strong>u</strong>:
</p>
<blockquote><pre>
     1  <strong>if</strong> u &gt; 0
y =  0  <strong>if</strong> u == 0
    -1  <strong>if</strong> u &lt; 0
</pre></blockquote>
<p>
The Boolean parameter generateEvent decides whether Events are generated at zero crossing (Modelica specification before 3) or not.
</p>
</html>"));
end Sign;
