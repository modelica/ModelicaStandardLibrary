within Modelica.Blocks.Interaction.Show;
block BooleanValue
  "Show Boolean value from numberPort or from number input field in diagram layer dynamically"
  parameter Boolean use_activePort = true "= true, if activePort enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  input Boolean active=false
    "Boolean variable to visualize if use_activePort=false (time varying)"
    annotation(Dialog(enable=not use_activePort),HideResult=true);
  Modelica.Blocks.Interfaces.BooleanInput activePort if use_activePort
    "Boolean variable to be shown in diagram layer if use_activePort = true"
    annotation (HideResult=true,Placement(transformation(extent={{-130,-15},{-100,15}})));

   Modelica.Blocks.Interfaces.BooleanOutput showActive;
equation
  if use_activePort then
     connect(activePort, showActive);
  else
     showActive = active;
  end if;

  annotation (Icon(
      coordinateSystem(preserveAspectRatio=false,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Text(visible=not use_activePort,
        extent={{-188.0,-80.0},{62.0,-60.0}},
        textString="%active"),
      Ellipse(lineColor={64,64,64},
        fillColor=DynamicSelect({192,192,192}, if showActive then {0,255,0} else {235,235,235}),
        pattern=LinePattern.None,
        fillPattern=FillPattern.Sphere,
        extent={{-100.0,-40.0},{-20.0,40.0}})}), Documentation(info="<html>
<p>
This block visualizes a Boolean variable in a diagram animation.
The Boolean variable to be visualized can be defined in the following ways:
</p>

<ul>
<li> If useActivePort = <strong>true</strong> (which is the default), a Boolean
     input is present and this input variable is shown.</li>

<li> If useActivePort = <strong>false</strong> no input connector is present.
     Instead, a Boolean input field is activated in the parameter menu
     and the Boolean expression from this input menu is shown.</li>
</ul>

<p>
If the Boolean variable is <strong>false</strong> the block is \"grey\", otherwise, it is \"green\".
The two versions of the block are shown in the following image (in the right variant, the
name of the variable value that is displayed is also shown below the icon):
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Interaction/Show/BooleanValue.png\"
     alt=\"BooleanValue.png\">
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>
</html>"));
end BooleanValue;
