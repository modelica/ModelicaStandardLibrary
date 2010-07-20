within Modelica.Blocks;
package MathInteger
  "Library of Integer mathematical functions as input/output blocks"
  extends Modelica.Icons.Package;
  block ShowValue
    "Show Integer value from numberPort or from number input field in diagram layer dynamically"
    parameter Boolean use_numberPort = true "= true, if numberPort enabled"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    input Integer number=0
      "Number to visualize if use_numberPort=false (time varying)"
      annotation(Dialog(enable=not use_numberPort));
    Modelica.Blocks.Interfaces.IntegerInput numberPort if use_numberPort
      "Number to be shown in diagram layer if use_numberPort = true"
      annotation (Placement(transformation(extent={{-130,-15},{-100,15}})));
     Modelica.Blocks.Interfaces.IntegerOutput number2;
  equation
    if use_numberPort then
       connect(numberPort, number2);
    else
       number2 = number;
    end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false,  extent={{-100,
                -100},{100,100}}), graphics={
            Rectangle(
              extent={{100,40},{-100,-40}},
              lineColor={0,0,255},
              fillColor={236,233,216},
              fillPattern=FillPattern.Solid,
              borderPattern=BorderPattern.Raised),
            Text(extent={{-94,-34},{96,34}}, textString=DynamicSelect("0",
                  realString(
                    number2,
                    1,
                    0))),
            Text(
              visible=not use_numberPort,
              extent={{-150,-50},{150,-70}},
              lineColor={0,0,0},
              textString="%number")}), Documentation(info="<html>
<p>
This block viualizes an Integer number in a diagram animation.
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
<img src=\"modelica://Modelica/Images/MathInteger/ShowValue.png\">
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.IntegerNetwork1\">Modelica.Blocks.Examples.IntegerNetwork1</a>.
</p>
</html>"));
  end ShowValue;

  block Sum "Sum of Integers: y = k[1]*u[1] + k[2]*u[2] + ... + k[n]*u[n]"
     extends Modelica.Blocks.Interfaces.PartialIntegerMISO;
     parameter Integer k[nu] = fill(1,nu) "Input gains";
  equation
    y = k*u;

    annotation (Icon(graphics={Text(
              extent={{-200,-110},{200,-140}},
              lineColor={0,0,0},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              textString="%k"), Text(
              extent={{-72,68},{92,-68}},
              lineColor={0,0,0},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              textString="+")}), Documentation(info="<html>
<p>
This blocks computes the scalar Integer output \"y\" as sum of the elements of the
Integer input signal vector u:
</p>
<blockquote><pre>
y = k[1]*u[1] + k[2]*u[2] + ... k[N]*u[N];
</pre></blockquote>

<p>
The input connector is a vector of Integer input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the 
connectorSizing annotation).
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.IntegerNetwork1\">Modelica.Blocks.Examples.IntegerNetwork1</a>.
</p>

</html>"));
  end Sum;

  block Product "Product of Integer: y = u[1]*u[2]* ... *u[n]"
     extends Modelica.Blocks.Interfaces.PartialIntegerMISO;
  equation
    y = product(u);

    annotation (Icon(graphics={Text(
              extent={{-74,50},{94,-94}},
              lineColor={0,0,0},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              textString="*")}), Documentation(info="<html>
<p>
This blocks computes the scalar Integer output \"y\" as product of the elements of the
Integer input signal vector u:
</p>
<blockquote><pre>
y = u[1]*u[2]* ... *u[N];
</pre></blockquote>

<p>
The input connector is a vector of Integer input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the 
connectorSizing annotation).
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.IntegerNetwork1\">Modelica.Blocks.Examples.IntegerNetwork1</a>.
</p>


</html>"));
  end Product;

block MultiSwitch
    "Set Integer expression that is associated with the first active input signal"

  input Integer expr[nu]=fill(0, nu)
      "y = if u[i] then expr[i] elseif use_pre_as_default then pre(y) else y_default"
                                                                                                 annotation(Dialog);
  parameter Integer y_default=0
      "Default value of output y if use_pre_as_default=false, as well as pre(y) at initial time";

  parameter Boolean use_pre_as_default=true
      "= true, y holds its last value if all u[i]=false, otherwise y=y_default"
        annotation(HideResult=true, choices(__Dymola_checkBox=true));
  parameter Integer nu(min=0) = 0 "Number of input connections"
          annotation(Dialog(connectorSizing=true), HideResult=true);

  Modelica.Blocks.Interfaces.BooleanVectorInput u[nu]
      "Set y = expr[i], if u[i] = true"
    annotation (Placement(transformation(extent={{-110,30},{-90,-30}})));
  Modelica.Blocks.Interfaces.IntegerOutput y "Output depending on expression"
    annotation (Placement(transformation(extent={{300,-10},{320,10}})));

  protected
  Integer firstActiveIndex;
initial equation
  pre(y) = y_default;
equation
  firstActiveIndex = Modelica.Math.firstTrueIndex(u);
  y = if firstActiveIndex > 0 then expr[firstActiveIndex] else
      if use_pre_as_default then pre(y) else y_default;
  annotation (defaultComponentName="multiSwitch1",Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{300,100}},
        grid={1,1}),           graphics), Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{300,100}},
        grid={1,1}), graphics={
            Text(
              extent={{310,-25},{410,-45}},
              lineColor={0,0,0},
              textString=realString(
                  y,
                  1,
                  0)),
            Text(
              visible=not use_pre_as_default,
              extent={{-100,-60},{300,-90}},
              lineColor={0,0,0},
              textString="else: %y_default"),
            Text(
              visible=use_pre_as_default,
              extent={{-100,-50},{300,-80}},
              lineColor={0,0,0},
              textString="else: pre(y)"),
            Rectangle(
              extent={{-100,-40},{300,40}},
              lineColor={0,0,0},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              borderPattern=BorderPattern.Raised),
            Text(
              extent={{-100,90},{300,50}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-80,15},{290,-15}},
              lineColor={0,0,0},
              fillColor={255,246,238},
              fillPattern=FillPattern.Solid,
              textString="%expr")}),
    Documentation(info="<html>
<p>
This block has a vector of Boolean input signals u[nu] and a vector of
(time varying) Integer expressions expr[nu]. The output signal y is
set to expr[i], if i is the first element in the input vector u that is true. If all input signals are
false, y is set to parameter \"y_default\" or the last value is kept, if use_pre_as_default = <b>true</b>.
</p>
 
<blockquote><pre>
  // Conceptual equation (not valid Modelica)
  i = 'first element of u[:] that is true';
  y = <b>if</b> i==0 <b>then</b> (<b>if</b> use_pre_as_default <b>then</b> pre(y) 
                                          <b>else</b> y_default) 
      <b>else</b> expr[i];
</pre></blockquote>

<p>
The input connector is a vector of Boolean input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the 
connectorSizing annotation).
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.IntegerNetwork1\">Modelica.Blocks.Examples.IntegerNetwork1</a>.
</p>

</html>"));
end MultiSwitch;

  block TriggeredAdd
    "Add input to previous value of output, if rising edge of trigger port"
    extends Modelica.Blocks.Interfaces.PartialIntegerSISO;

    parameter Boolean use_reset = false "=true, if reset port enabled"
          annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Boolean use_set = false
      "=true, if set port enabled and used as default value when reset"
          annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Integer y_start = 0
      "Initial and reset value of y if set port is not used";

    Modelica.Blocks.Interfaces.BooleanInput trigger annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-60,-120})));
    Modelica.Blocks.Interfaces.BooleanInput reset if use_reset annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={60,-120})));
    Modelica.Blocks.Interfaces.IntegerInput set if use_set annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={60,120}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={28,98})));
  protected
    Modelica.Blocks.Interfaces.BooleanOutput local_reset annotation(HideResult=true);
    Modelica.Blocks.Interfaces.IntegerOutput local_set;
  initial equation
    pre(y) = y_start;
  equation
    if use_reset then
       connect(reset, local_reset);
         if use_set then
           connect(set, local_set);
         else
           local_set = y_start;
         end if;
    else
       local_reset = false;
       local_set = 0;
    end if;

    when {trigger, local_reset} then
       y = if local_reset then local_set else pre(y) + u;
    end when;
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}},
          initialScale=0.06),    graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}},
          initialScale=0.06), graphics={
            Line(
              points={{-100,0},{32,76}},
              color={255,128,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dot),
            Line(
              points={{-100,0},{32,-20}},
              color={255,128,0},
              pattern=LinePattern.Dot,
              smooth=Smooth.None),
            Line(
              points={{-54,-56},{-26,-56},{-26,-20},{32,-20},{32,76}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              points={{-60,-100},{32,-20}},
              color={255,0,255},
              pattern=LinePattern.Dot,
              smooth=Smooth.None),
            Text(
              visible=use_reset,
              extent={{-28,-62},{94,-86}},
              lineColor={0,0,0},
              textString="reset")}),
      Documentation(info="<html>
<p>
Add input to previous value of output, if rising edge of trigger port

<p>
This block has one Integer input \"u\", one Boolean input \"trigger\",
an optional Boolean input \"reset\", an optional Integer input \"set\", and
an Integer output \"y\".
The optional inputs can be activated with the \"use_reset\" and
\"use_set\" flags, respectively.
</p>

<p>
The input \"u\" is added to the previous value of the
output \"y\" if the \"trigger\" port has a rising edge. At the start of the 
simulation \"y = y_start\".
</p>

<p>
If the \"reset\" port is enabled, then the output \"y\" is reset to \"set\" 
or to \"y_start\" (if the \"set\" port is not enabled), whenever the \"reset\"
port has a rising edge.
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.IntegerNetwork1\">Modelica.Blocks.Examples.IntegerNetwork1</a>.
</p>

</html>"));
  end TriggeredAdd;
  annotation (Documentation(info="<html>
<p>
This package contains basic <b>mathematical operations</b>
on <b>Integer</b> signals.
</p>
</html>"));
end MathInteger;
