within Modelica.Blocks.MathBoolean;
block FallingEdge
  "Output y is true, if the input u has a falling edge, otherwise it is false (y = edge(not u))"
   parameter Boolean pre_u_start = false "Value of pre(u) at initial time";
   extends Modelica.Blocks.Interfaces.PartialBooleanSISO_small;
protected
  Boolean not_u = not u annotation(HideResult=true);
initial equation
  pre(not_u) = not pre_u_start;
equation
  y = edge(not_u);
      annotation (defaultComponentName="falling1", Icon(graphics={Line(points=
               {{-80,-68},{-36,-68},{-36,-24},{22,-24},{22,-68},{66,-68}}), Line(points={{-80,32},{24,32},{24,76},{24,76},{
                24,32},{66,32}}, color={255,0,255})}),
                                 Documentation(info="<html>
<p>
A falling edge of the Boolean input u results in y = <strong>true</strong> at this
time instant. At all other time instants, y = <strong>false</strong>.
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>

</html>"));
end FallingEdge;
