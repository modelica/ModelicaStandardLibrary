within Modelica.Blocks;
package Interaction
  "Library of user interaction blocks to input and to show variables in a diagram animation"
  extends Modelica.Icons.Package;

  package Show "Library of blocks to show variables in a diagram animation"
    extends Modelica.Icons.Package;

    block RealValue
      "Show Real value from numberPort or from number input field in diagram layer dynamically"
      parameter Boolean use_numberPort = true "= true, if numberPort enabled"
        annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
      input Real number = 0.0
        "Number to visualize if use_numberPort=false (time varying)"
        annotation(Dialog(enable=not use_numberPort), HideResult=true);
      parameter Integer significantDigits(min=1) = 2
        "Number of significant digits to be shown";

      Modelica.Blocks.Interfaces.RealInput numberPort if use_numberPort
        "Number to be shown in diagram layer if use_numberPort = true"
        annotation (HideResult=true,Placement(transformation(extent={{-130,-15},{-100,15}})));
       Modelica.Blocks.Interfaces.RealOutput showNumber;
    equation
      if use_numberPort then
         connect(numberPort, showNumber);
      else
         showNumber = number;
      end if;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false,  extent={{-100,
                  -100},{100,100}}), graphics={
              Rectangle(
                extent={{100,40},{-100,-40}},
                lineColor={0,0,255},
                fillColor={236,233,216},
                fillPattern=FillPattern.Solid,
                borderPattern=BorderPattern.Raised),
              Text(extent={{-94,-34},{96,34}}, textString=DynamicSelect("0.0",
                    String(showNumber, significantDigits=significantDigits))),
              Text(
                visible=not use_numberPort,
                extent={{-150,-50},{150,-70}},
                lineColor={0,0,0},
                textString="%number")}), Documentation(info="<html>
<p>
This block visualizes a Real number in a diagram animation.
The number to be visualized can be defined in the following ways:
</p>

<ul>
<li> If useNumberPort = <b>true</b> (which is the default), a Real
     input is present and this input variable is shown.</li>

<li> If useNumberPort = <b>false</b> no input connector is present.
     Instead, a Real input field is activated in the parameter menu
     and the Real expression from this input menu is shown.</li>
</ul>

<p>
The two versions of the block are shown in the following image (in the right variant, the
name of the variable value that is displayed is also shown below the icon):<br>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Interaction/RealValue.png\">
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.RealNetwork1\">Modelica.Blocks.Examples.RealNetwork1</a>.
</p>
</html>"));
    end RealValue;

    block IntegerValue
      "Show Integer value from numberPort or from number input field in diagram layer dynamically"
      parameter Boolean use_numberPort = true "= true, if numberPort enabled"
        annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
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

      annotation (Icon(coordinateSystem(preserveAspectRatio=false,  extent={{-100,
                  -100},{100,100}}), graphics={
              Rectangle(
                extent={{100,40},{-100,-40}},
                lineColor={0,0,255},
                fillColor={236,233,216},
                fillPattern=FillPattern.Solid,
                borderPattern=BorderPattern.Raised),
              Text(extent={{-94,-34},{96,34}}, textString=DynamicSelect("0", String(showNumber))),
              Text(
                visible=not use_numberPort,
                extent={{-150,-50},{150,-70}},
                lineColor={0,0,0},
                textString="%number")}), Documentation(info="<html>
<p>
This block visualizes an Integer number in a diagram animation.
The number to be visualized can be defined in the following ways:
</p>

<ul>
<li> If useNumberPort = <b>true</b> (which is the default), an Integer
     input is present and this input variable is shown.</li>

<li> If useNumberPort = <b>false</b> no input connector is present.
     Instead, an Integer input field is activated in the parameter menu
     and the Integer expression from this input menu is shown.</li>
</ul>

<p>
The two versions of the block are shown in the following image (in the right variant, the
name of the variable value that is displayed is also shown below the icon):<br>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Interaction/IntegerValue.png\">
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.IntegerNetwork1\">Modelica.Blocks.Examples.IntegerNetwork1</a>.
</p>
</html>"));
    end IntegerValue;

    block BooleanValue
      "Show Boolean value from numberPort or from number input field in diagram layer dynamically"
      parameter Boolean use_activePort = true "= true, if activePort enabled"
        annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
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

      annotation (Icon(coordinateSystem(preserveAspectRatio=false,  extent={{-100,
                  -100},{100,100}}), graphics={Text(
                visible=not use_activePort,
                extent={{-188,-60},{62,-80}},
                lineColor={0,0,0},
                textString="%active"), Ellipse(
                extent={{-100,-40},{-20,40}},
                fillColor=DynamicSelect({235,235,235}, if showActive > 0.5 then {0,
                    255,0} else {235,235,235}),
                lineColor={0,0,0},
                pattern=LinePattern.None,
                fillPattern=FillPattern.Sphere)}), Documentation(info="<html>
<p>
This block visualizes a Boolean variable in a diagram animation.
The Boolean variable to be visualized can be defined in the following ways:
</p>

<ul>
<li> If useActivePort = <b>true</b> (which is the default), a Boolean
     input is present and this input variable is shown.</li>

<li> If useActivePort = <b>false</b> no input connector is present.
     Instead, a Boolean input field is activated in the parameter menu
     and the Boolean expression from this input menu is shown.</li>
</ul>

<p>
If the Boolean variable is <b>false</b> the block is \"grey\", otherwise, it is \"green\".
The two versions of the block are shown in the following image (in the right variant, the
name of the variable value that is displayed is also shown below the icon):<br>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Interaction/BooleanValue.png\">
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>
</html>"));
    end BooleanValue;
  end Show;
end Interaction;
