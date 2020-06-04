within Modelica.Blocks;
package MathBoolean
  "Library of Boolean mathematical functions as input/output blocks"
  extends Modelica.Icons.Package;

block MultiSwitch
    "Set Boolean expression that is associated with the first active input signal"

  input Boolean expr[nu]=fill(false, nu)
      "Sets y = if u[i] then expr[i] else y_default (time varying)" annotation(Dialog);
  parameter Boolean use_pre_as_default=true
      "Set true to hold last value as default (y_default = pre(y))"
        annotation(HideResult=true, choices(checkBox=true));
  parameter Boolean y_default=false
      "Default value of output y if all u[i] = false"
                                                    annotation(Dialog(enable = not use_pre_as_default));

  parameter Integer nu(min=0) = 0 "Number of input connections"
          annotation(Dialog(connectorSizing=true), HideResult=true);

  Modelica.Blocks.Interfaces.BooleanVectorInput u[nu]
      "Set y = expr[i], if u[i] = true"
    annotation (Placement(transformation(extent={{-110,30},{-90,-30}})));
  Modelica.Blocks.Interfaces.BooleanOutput y "Output depending on expression"
    annotation (Placement(transformation(extent={{300,-10},{320,10}})));

  protected
  Integer firstActiveIndex;
initial equation
  pre(y) = y_default;
equation
    firstActiveIndex =
      Modelica.Math.BooleanVectors.firstTrueIndex(
                                   u);
   y = if firstActiveIndex == 0 then (if use_pre_as_default then pre(y) else y_default) else
                                     expr[firstActiveIndex];
  annotation (
    defaultComponentName="set1",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{300,100}}), graphics={
            Text(
              visible=not use_pre_as_default,
              extent={{-100,-60},{300,-90}},
              textString="else: %y_default"),
            Text(
              visible=use_pre_as_default,
              extent={{-100,-60},{300,-90}},
              textString="else: pre(y)"),
            Text(
              extent={{-99,99},{300,59}},
              textString="%name",
              textColor={0,0,255}),
            Rectangle(
              extent={{-100,-51},{300,50}},
              lineColor={255,127,0},
              lineThickness=5.0,
              fillColor={210,210,210},
              fillPattern=FillPattern.Solid,
              borderPattern=BorderPattern.Raised),
            Text(
              extent={{-84,16},{273,-15}},
              textString="%expr"),
            Ellipse(
              extent={{275,8},{289,-6}},
              lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
              fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
              fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
The block has a vector of Boolean input signals u[nu] and a vector of
(time varying) Boolean expressions expr[:]. The output signal y is
set to expr[i], if i is the first element in the input vector u that is true.
If all input signals are false, y is set to parameter \"y_default\" or the
previous value of y is kept if parameter use_pre_as_default = <strong>true</strong>:
</p>

<blockquote><pre>
// Conceptual equation (not valid Modelica)
i = 'first element of u[:] that is true';
y = <strong>if</strong> i==0 <strong>then</strong> (<strong>if</strong> use_pre_as_default <strong>then</strong> pre(y)
                                        <strong>else</strong> y_default)
    <strong>else</strong> expr[i];
</pre></blockquote>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>

</html>"));
end MultiSwitch;

  block And "Logical 'and': y = u[1] and u[2] and ... and u[nu]"
    extends Modelica.Blocks.Interfaces.PartialBooleanMISO;

  equation
    y = Modelica.Math.BooleanVectors.andTrue(
                              u);
    annotation (defaultComponentName="and1", Icon(graphics={Text(
              extent={{-76,40},{60,-40}},
              textString="and")}),
      Documentation(info="<html>
<p>
The output is <strong>true</strong> if all inputs are <strong>true</strong>, otherwise
the output is <strong>false</strong>.
</p>

<p>
The input connector is a vector of Boolean input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the
connectorSizing annotation).
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>

<p>
If no connection to the input connector \"u\" is present,
the output is set to <strong>true</strong>: y=true.
</p>
</html>"));
  end And;

  block Or "Logical 'or': y = u[1] or u[2] or ... or u[nu]"
    extends Modelica.Blocks.Interfaces.PartialBooleanMISO;

  equation
    y = Modelica.Math.BooleanVectors.anyTrue(
                              u);
    annotation (defaultComponentName="or1", Icon(graphics={Text(
              extent={{-80,40},{60,-40}},
              textString="or")}),
      Documentation(info="<html>
<p>
The output is <strong>true</strong> if at least one input is <strong>true</strong>, otherwise
the output is <strong>false</strong>.
</p>

<p>
The input connector is a vector of Boolean input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the
connectorSizing annotation).
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>

<p>
If no connection to the input connector \"u\" is present,
the output is set to <strong>false</strong>: y=false.
</p>

</html>"));
  end Or;

  block Xor
    "Logical 'xor': y = oneTrue(u)  (y is true, if exactly one element of u is true, otherwise it is false)"
    extends Modelica.Blocks.Interfaces.PartialBooleanMISO;

  equation
    y = Modelica.Math.BooleanVectors.oneTrue(
                              u);
    annotation (defaultComponentName="xor1", Icon(graphics={Text(
              extent={{-80,40},{60,-40}},
              textString="xor")}),
      Documentation(info="<html>
<p>
The output is <strong>true</strong> if exactly one input is <strong>true</strong>, otherwise
the output is <strong>false</strong>.
</p>

<p>
The input connector is a vector of Boolean input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the
connectorSizing annotation).
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>

<p>
If no connection to the input connector \"u\" is present,
the output is set to <strong>false</strong>: y=false.
</p>

</html>"));
  end Xor;

  block Nand "Logical 'nand': y = not ( u[1] and u[2] and ... and u[nu] )"
    extends Modelica.Blocks.Interfaces.PartialBooleanMISO;

  equation
    y = not Modelica.Math.BooleanVectors.andTrue(
                                  u);
    annotation (defaultComponentName="nand1", Icon(graphics={Text(
              extent={{-78,36},{64,-30}},
              textString="nand")}),
      Documentation(info="<html>
<p>
The output is <strong>true</strong> if at least one input is <strong>false</strong>, otherwise
the output is <strong>false</strong>.
</p>

<p>
The input connector is a vector of Boolean input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the
connectorSizing annotation).
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>

<p>
If no connection to the input connector \"u\" is present,
the output is set to <strong>false</strong>: y=false.
</p>

</html>"));
  end Nand;

  block Nor "Logical 'nor': y = not ( u[1] or u[2] or ... or u[nu] )"
    extends Modelica.Blocks.Interfaces.PartialBooleanMISO;

  equation
    y = not Modelica.Math.BooleanVectors.anyTrue(
                                  u);
    annotation (defaultComponentName="nor1", Icon(graphics={Text(
              extent={{-80,40},{60,-40}},
              textString="nor")}),
      Documentation(info="<html>
<p>
The output is <strong>false</strong> if at least one input is <strong>true</strong>, otherwise
the output is <strong>true</strong>.
</p>

<p>
The input connector is a vector of Boolean input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the
connectorSizing annotation).
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>

<p>
If no connection to the input connector \"u\" is present,
the output is set to <strong>false</strong>: y=false.
</p>
</html>"));
  end Nor;

  block Not "Logical 'not': y = not u"
    extends Modelica.Blocks.Interfaces.PartialBooleanSISO_small;

  equation
    y = not u;
    annotation (defaultComponentName="not1", Icon(graphics={Text(
              extent={{-98,40},{42,-40}},
              textString="not")}),
      Documentation(info="<html>
<p>
The output is <strong>false</strong> if at least one input is <strong>true</strong>, otherwise
the output is <strong>true</strong>.
</p>

<p>
The input connector is a vector of Boolean input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the
connectorSizing annotation).
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>
</html>"));
  end Not;

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

  block ChangingEdge
    "Output y is true, if the input u has either a rising or a falling edge and otherwise it is false (y=change(u))"
     parameter Boolean pre_u_start = false "Value of pre(u) at initial time";
     extends Modelica.Blocks.Interfaces.PartialBooleanSISO_small;
  initial equation
    pre(u) = pre_u_start;
  equation
    y = change(u);
        annotation (defaultComponentName="changing1", Icon(graphics={
            Line(points={{-80,-68},{-36,-68},{-36,-24},{22,-24},{22,-68},{66,-68}}),
            Line(points={{-80,32},{-36,32},{-36,76},{-36,76},{-36,32},{66,32}},
                color={255,0,255}),
            Line(
              points={{24,32},{24,76}},
              color={255,0,255})}),Documentation(info="<html>
<p>
A changing edge, i.e., either rising or falling,
of the Boolean input u results in y = <strong>true</strong> at this
time instant. At all other time instants, y = <strong>false</strong>.
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>

</html>"));
  end ChangingEdge;

  block OnDelay
    "Delay a rising edge of the input, but do not delay a falling edge."
        extends Modelica.Blocks.Interfaces.PartialBooleanSISO_small;
        parameter SI.Time delayTime "Delay time";

  protected
        Boolean delaySignal(start=false,fixed=true);
        discrete SI.Time t_next;
  initial equation
        pre(u) = false;
        pre(t_next) = time - 1;
  algorithm
        when initial() then
           delaySignal := u;
           t_next := time - 1;
        elsewhen u then
           delaySignal := true;
           t_next := time + delayTime;
        elsewhen not u then
           delaySignal := false;
           t_next := time - 1;
        end when;
  equation
        if delaySignal then
           y = time >= t_next;
        else
           y = false;
        end if;
        annotation (Icon(graphics={
            Text(
              extent={{-250,-120},{250,-150}},
              textString="%delayTime s"),
            Line(points={{-80,-66},{-60,-66},{-60,-22},{38,-22},{38,-66},{66,-66}}),
            Line(points={{-80,32},{-4,32},{-4,76},{38,76},{38,32},{66,32}},
                color={255,0,255})}),
                                   Documentation(info="<html>
<p>
A rising edge of the Boolean input u gives a delayed output.
A falling edge of the input is immediately given to the output.
</p>

<p>
Simulation results of a typical example with a delay time of 0.1 s
is shown in the next figure.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/MathBoolean/OnDelay1.png\"
     alt=\"OnDelay1.png\">
<br>
<img src=\"modelica://Modelica/Resources/Images/Blocks/MathBoolean/OnDelay2.png\"
     alt=\"OnDelay2.png\">
</div>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>

</html>"));
  end OnDelay;

  annotation (Documentation(info="<html>
<p>
This package contains basic <strong>mathematical operations</strong>
on <strong>Boolean</strong> signals.
</p>

<p>
The new features are:
</p>

<ul>
<li> If useful, blocks may have an arbitrary number of inputs (e.g., \"And\" block with 2,3,4,...
     Boolean inputs). This is based on the \"connectorSizing\" annotation which
     allows a tool to conveniently handle vectors of connectors.</li>

<li> The blocks are smaller in size, so that the diagram area is better
     utilized for trivial blocks such as \"And\" or \"Or\".</li>

</ul>

</html>"), Icon(graphics={Line(points={{-80,-16},{-4,-16},{-4,28},{38,28},{38,
              -16},{66,-16}}, color={255,0,255})}));
end MathBoolean;
