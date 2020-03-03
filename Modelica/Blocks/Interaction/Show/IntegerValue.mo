within Modelica.Blocks.Interaction.Show;
block IntegerValue
  "Show Integer value from numberPort or from number input field in diagram layer dynamically"
  parameter Boolean use_numberPort = true "= true, if numberPort enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  input Integer number=0
    "Number to visualize if use_numberPort=false (time varying)"
    annotation(Dialog(enable=not use_numberPort), HideResult=true);
  Modelica.Blocks.Interfaces.IntegerInput numberPort if use_numberPort
    "Number to be shown in diagram layer if use_numberPort = true"
    annotation (HideResult=true,Placement(transformation(extent={{-130,-15},{-100,15}})));
   Modelica.Blocks.Interfaces.IntegerOutput showNumber;
equation
  if use_numberPort then
     connect(numberPort, showNumber);
  else
     showNumber = number;
  end if;

  annotation (Icon(
      coordinateSystem(preserveAspectRatio=false,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Rectangle(lineColor={0,0,127},
        fillColor={236,233,216},
        fillPattern=FillPattern.Solid,
        lineThickness=5.0,
        borderPattern=BorderPattern.Raised,
        extent={{-100.0,-40.0},{100.0,40.0}}),
      Text(extent={{-94.0,-34.0},{96.0,34.0}},
        textString=DynamicSelect("0", String(showNumber))),
      Text(visible=not use_numberPort,
        extent={{-150.0,-70.0},{150.0,-50.0}},
        textString="%number")}), Documentation(info="<html>
<p>
This block visualizes an Integer number in a diagram animation.
The number to be visualized can be defined in the following ways:
</p>

<ul>
<li> If useNumberPort = <strong>true</strong> (which is the default), an Integer
     input is present and this input variable is shown.</li>

<li> If useNumberPort = <strong>false</strong> no input connector is present.
     Instead, an Integer input field is activated in the parameter menu
     and the Integer expression from this input menu is shown.</li>
</ul>

<p>
The two versions of the block are shown in the following image (in the right variant, the
name of the variable value that is displayed is also shown below the icon):
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Interaction/Show/IntegerValue.png\"
     alt=\"IntegerValue.png\">
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.IntegerNetwork1\">Modelica.Blocks.Examples.IntegerNetwork1</a>.
</p>
</html>"));
end IntegerValue;
