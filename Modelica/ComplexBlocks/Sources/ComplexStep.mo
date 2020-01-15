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
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Polygon(
              points={{-80,90},{-86,68},{-74,68},{-80,90}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),Line(points={{-80,68},{-80,-80}},
          color={95,95,95}),Line(
              points={{-80,-18},{0,-18},{0,50},{80,50}},
              color={0,0,255},
              thickness=0.5),Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
          Polygon(
              points={{90,-70},{68,-64},{68,-76},{90,-70}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),Text(
              extent={{70,-80},{94,-100}},
              textString="time"),Text(
              extent={{-21,-72},{25,-90}},
              textString="startTime"),Line(points={{0,-17},{0,-71}}, color=
          {95,95,95}),Text(
              extent={{-68,-36},{-22,-54}},
              textString="offset"),Line(points={{-13,50},{-13,-17}}, color=
          {95,95,95}),Polygon(
              points={{2,50},{-19,50},{2,50}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-13,-17},{-16,-4},{-10,-4},{-13,-17},{-13,-17}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-13,50},{-16,37},{-9,37},{-13,50}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),Text(
              extent={{-68,26},{-22,8}},
              textString="height"),Polygon(
              points={{-13,-69},{-16,-56},{-10,-56},{-13,-69},{-13,-69}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),Line(points={{-13,-18},{-13,-70}},
          color={95,95,95}),Polygon(
              points={{-13,-18},{-16,-31},{-9,-31},{-13,-18}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),Text(
              extent={{-72,100},{-31,80}},
              textString="y")}),
    Documentation(info="<html>
<p>
The Complex output y is a step signal (of real and imaginary part):
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Step.png\"
     alt=\"Step.png\">
</p>

</html>"));
end ComplexStep;
