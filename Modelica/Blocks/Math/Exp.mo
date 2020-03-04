within Modelica.Blocks.Math;
block Exp "Output the exponential (base e) of the input"
  extends Interfaces.SISO;

equation
  y = Modelica.Math.exp(u);
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
          textString="exp"),
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
<em>exponential</em> (of base e) of the input <strong>u</strong>:
</p>
<blockquote><pre>
y = <strong>exp</strong>( u );
</pre></blockquote>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/exp.png\"
     alt=\"exp.png\">
</p>

</html>"));
end Exp;
