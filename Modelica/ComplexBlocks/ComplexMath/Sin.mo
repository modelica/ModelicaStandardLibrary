within Modelica.ComplexBlocks.ComplexMath;
block Sin "Output the sine of the input"
  extends Interfaces.ComplexSISO;
equation
  y = Modelica.ComplexMath.sin(uInternal);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-80,68}},
          color={192,192,192}),Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},
          {-49.4,74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},
          {-21.3,59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},
          {23.7,-64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{
          51.9,-71.5},{57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, color={85,
              170,255}),
                  Polygon(
              points={{90,0},{68,8},{68,-8},{90,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{12,84},{84,36}},
              textColor={192,192,192},
              textString="sin")}),
    Documentation(info="<html>
<p>
This blocks computes the output <code>y</code>
as <strong>sine</strong> of the input <code>u</code>. Optionally, the input <code>u</code> can be processed conjugate complex, when parameter <code>useConjugateInput</code> is <code>true</code>. Depending on <code>useConjugateInput</code> the internal signal <code>uInternal</code> represents either the original or the conjugate complex input signal.
</p>
<blockquote><pre>
y = <strong>sin</strong>(uInternal);
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/sin.png\"
     alt=\"sin.png\">
</div>

</html>"));
end Sin;
