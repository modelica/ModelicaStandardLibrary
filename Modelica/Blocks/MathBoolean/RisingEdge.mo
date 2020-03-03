within Modelica.Blocks.MathBoolean;
block RisingEdge
  "Output y is true, if the input u has a rising edge, otherwise it is false (y = edge(u))"
   parameter Boolean pre_u_start = false "Value of pre(u) at initial time";
   extends Modelica.Blocks.Interfaces.PartialBooleanSISO_small;
initial equation
  pre(u) = pre_u_start;
equation
  y = edge(u);
      annotation (defaultComponentName="rising1", Icon(graphics={Line(points=
                {{-80,-68},{-36,-68},{-36,-24},{22,-24},{22,-68},{66,-68}}), Line(points={{-80,32},{-36,32},{-36,76},{-36,76},
                {-36,32},{66,32}}, color={255,0,255})}),
                                 Documentation(info="<html>
<p>
A rising edge of the Boolean input u results in y = <strong>true</strong> at this
time instant. At all other time instants, y = <strong>false</strong>.
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>

</html>"));
end RisingEdge;
