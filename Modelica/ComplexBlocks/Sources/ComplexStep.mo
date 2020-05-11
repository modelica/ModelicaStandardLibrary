within Modelica.ComplexBlocks.Sources;
block ComplexStep "Generate step signal of type Complex"
  parameter Complex height=Complex(1) "Height of step";
  extends ComplexBlocks.Interfaces.ComplexSignalSource;

equation
  y = offset + (if time < startTime then Complex(0) else height);
  annotation (defaultComponentName="complexStep",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(points={{-80,68},{-80,-80}}, color={
          192,192,192}),Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-90,-70},{82,-70}},
          color={192,192,192}),Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,-70},{0,-70},
          {0,50},{80,50}}, color={85,170,255}),
                           Text(
              extent={{-150,-150},{150,-110}},
              textString="startTime=%startTime")}),
    Documentation(info="<html>
<p>
The Complex output y is a step signal (of real and imaginary part):
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Step.png\"
     alt=\"Step.png\">
</div>

</html>"));
end ComplexStep;
