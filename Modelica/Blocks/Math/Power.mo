within Modelica.Blocks.Math;
block Power "Output the power to a base of the input"
  extends Interfaces.SISO;
  parameter Real base = Modelica.Constants.e "Base of power" annotation(Evaluate=true);
  parameter Boolean useExp = true "Use exp function in implementation" annotation(Evaluate=true);
equation
  y = if useExp then Modelica.Math.exp(u*Modelica.Math.log(base)) else base ^ u;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{0,-80},{0,68}}, color={192,192,192}),
        Polygon(
          points={{0,90},{-8,68},{8,68},{0,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-86,50},{-14,2}},
          textColor={192,192,192},
          textString="^"),
        Line(points={{-80,-80},{-31,-77.9},{-6.03,-74},{10.9,-68.4},{23.7,-61},
              {34.2,-51.6},{43,-40.3},{50.3,-27.8},{56.7,-13.5},{62.3,2.23},{
              67.1,18.6},{72,38.2},{76,57.6},{80,80}}),
        Line(
          points={{-90,-80.3976},{68,-80.3976}},
          color={192,192,192},
          smooth=Smooth.Bezier),
        Polygon(
          points={{90,-80.3976},{68,-72.3976},{68,-88.3976},{90,-80.3976}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This blocks computes the output <strong>y</strong> as the
power to the parameter <em>base</em> of the input <strong>u</strong>.
If the boolean parameter <strong>useExp</strong> is true, the output is determined by:
</p>
<blockquote><pre>
y = <strong>exp</strong> ( u * <strong>log</strong> (base) )
</pre></blockquote>
<p>
otherwise:
</p>
<blockquote><pre>
y = base <strong>^</strong> u;
</pre></blockquote>

</html>"));
end Power;
