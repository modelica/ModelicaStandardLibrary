within Modelica.Blocks;
package Logical "Library of components with Boolean input and output signals"
  extends Modelica.Icons.Package;

  block And "Logical 'and': y = u1 and u2"
    extends Blocks.Interfaces.partialBooleanSI2SO;
  equation
    y = u1 and u2;
    annotation (
      defaultComponentName="and1",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            textString="and")}),
      Documentation(info="<html>
<p>
The output is <strong>true</strong> if all inputs are <strong>true</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
  end And;

  block Or "Logical 'or': y = u1 or u2"
    extends Blocks.Interfaces.partialBooleanSI2SO;
  equation
    y = u1 or u2;
    annotation (
      defaultComponentName="or1",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            textString="or")}),
      Documentation(info="<html>
<p>
The output is <strong>true</strong> if at least one input is <strong>true</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
  end Or;

  block Xor "Logical 'xor': y = u1 xor u2"
    extends Blocks.Interfaces.partialBooleanSI2SO;
  equation
    y = not ((u1 and u2) or (not u1 and not u2));
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            textString="xor")}), Documentation(info="<html>
<p>
The output is <strong>true</strong> if exactly one input is <strong>true</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
  end Xor;

  block Nor "Logical 'nor': y = not (u1 or u2)"
    extends Blocks.Interfaces.partialBooleanSI2SO;
  equation
    y = not (u1 or u2);
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            textString="nor")}), Documentation(info="<html>
<p>
The output is <strong>true</strong> if none of the inputs is <strong>true</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
  end Nor;

  block Nand "Logical 'nand': y = not (u1 and u2)"
    extends Blocks.Interfaces.partialBooleanSI2SO;
  equation
    y = not (u1 and u2);
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            textString="nand")}), Documentation(info="<html>
<p>
The output is <strong>true</strong> if at least one input is <strong>false</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
  end Nand;

  block Not "Logical 'not': y = not u"
    extends Blocks.Interfaces.partialBooleanSISO;

  equation
    y = not u;
    annotation (
      defaultComponentName="not1",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            textString="not")}),
      Documentation(info="<html>
<p>
The output is <strong>true</strong> if the input is <strong>false</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
  end Not;

  block Pre
    "Breaks algebraic loops by an infinitesimal small time delay (y = pre(u): event iteration continues until u = pre(u))"

    parameter Boolean pre_u_start=false "Start value of pre(u) at initial time";
    extends Blocks.Interfaces.partialBooleanSISO;

  initial equation
    pre(u) = pre_u_start;
  equation
    y = pre(u);
    annotation (
      defaultComponentName="pre1",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            textString="pre")}),
      Documentation(info="<html>
<p>
This block delays the Boolean input by an infinitesimal small time delay and
therefore breaks algebraic loops. In a network of logical blocks, in every
\"closed connection loop\" at least one logical block must have a delay,
since algebraic systems of Boolean equations are not solvable.
</p>

<p>
The \"Pre\" block returns the value of the \"input\" signal from the
last \"event iteration\". The \"event iteration\" stops, once both
values are identical (u = pre(u)).
</p>
</html>"));
  end Pre;

  block Edge "Output y is true, if the input u has a rising edge (y = edge(u))"

    parameter Boolean pre_u_start=false "Start value of pre(u) at initial time";
    extends Blocks.Interfaces.partialBooleanSISO;

  initial equation
    pre(u) = pre_u_start;
  equation
    y = edge(u);
    annotation (
      defaultComponentName="edge1",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            textString="edge")}),
      Documentation(info="<html>
<p>
The output is <strong>true</strong> if the Boolean input has a rising edge
from <strong>false</strong> to <strong>true</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
  end Edge;

  block FallingEdge
    "Output y is true, if the input u has a falling edge (y = edge(not u))"

    parameter Boolean pre_u_start=false "Start value of pre(u) at initial time";
    extends Blocks.Interfaces.partialBooleanSISO;

  protected
    Boolean not_u=not u;
  initial equation
    pre(not_u) = not pre_u_start;
  equation
    y = edge(not_u);
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            textString="falling")}), Documentation(info="<html>
<p>
The output is <strong>true</strong> if the Boolean input has a falling edge
from <strong>true</strong> to <strong>false</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
  end FallingEdge;

  block Change
    "Output y is true, if the input u has a rising or falling edge (y = change(u))"

    parameter Boolean pre_u_start=false "Start value of pre(u) at initial time";
    extends Blocks.Interfaces.partialBooleanSISO;

  initial equation
    pre(u) = pre_u_start;
  equation
    y = change(u);
    annotation (
      defaultComponentName="change1",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            textString="change")}),
      Documentation(info="<html>
<p>
The output is <strong>true</strong> if the Boolean input has either a rising edge
from <strong>false</strong> to <strong>true</strong> or a falling edge from
<strong>true</strong> to <strong>false</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
  end Change;

  block GreaterThreshold
    "Output y is true, if input u is greater than threshold"
    extends Blocks.Interfaces.partialBooleanThresholdComparison;
  equation
    y = u > threshold;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Line(
            points={{-54,20},{-8,0},{-54,-20}},
            thickness=0.5)}), Documentation(info="<html>
<p>
The output is <strong>true</strong> if the Real input is greater than
parameter <strong>threshold</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
  end GreaterThreshold;

  block GreaterEqualThreshold
    "Output y is true, if input u is greater or equal than threshold"

    extends Blocks.Interfaces.partialBooleanThresholdComparison;
  equation
    y = u >= threshold;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Line(
            points={{-54,20},{-8,0},{-54,-20}},
            thickness=0.5),
          Line(points={{-54,-30},{-8,-30}}, thickness=0.5)}),
      Documentation(info="<html>
<p>
The output is <strong>true</strong> if the Real input is greater than or equal to
parameter <strong>threshold</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
  end GreaterEqualThreshold;

  block LessThreshold "Output y is true, if input u is less than threshold"

    extends Blocks.Interfaces.partialBooleanThresholdComparison;
  equation
    y = u < threshold;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Line(points={{-8,20},{-54,0},{-8,-20}}, thickness=0.5)}), Documentation(info="<html>
<p>
The output is <strong>true</strong> if the Real input is less than
parameter <strong>threshold</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
  end LessThreshold;

  block LessEqualThreshold
    "Output y is true, if input u is less or equal than threshold"
    extends Blocks.Interfaces.partialBooleanThresholdComparison;
  equation
    y = u <= threshold;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Line(points={{-8,20},{-54,0},{-8,-20}}, thickness=0.5),
          Line(points={{-54,-30},{-8,-30}}, thickness=0.5)}),
      Documentation(info="<html>
<p>
The output is <strong>true</strong> if the Real input is less than or equal to
parameter <strong>threshold</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
  end LessEqualThreshold;

  block Greater "Output y is true, if input u1 is greater than input u2"
    extends Blocks.Interfaces.partialBooleanComparison;

  equation
    y = u1 > u2;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false,extent={{-100,
              -100},{100,100}}), graphics={
          Ellipse(extent={{32,10},{52,-10}}, lineColor={0,0,127}),
          Line(points={{-100,-80},{42,-80},{42,0}}, color={0,0,127}),
          Line(
            points={{-54,20},{-8,0},{-54,-20}},
            thickness=0.5)}), Documentation(info="<html>
<p>
The output is <strong>true</strong> if Real input u1 is greater than
Real input u2, otherwise the output is <strong>false</strong>.
</p>
</html>"));
  end Greater;

  block GreaterEqual
    "Output y is true, if input u1 is greater or equal than input u2"
    extends Blocks.Interfaces.partialBooleanComparison;

  equation
    y = u1 >= u2;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false,extent={{-100,
              -100},{100,100}}), graphics={
          Ellipse(extent={{32,10},{52,-10}}, lineColor={0,0,127}),
          Line(points={{-100,-80},{42,-80},{42,0}}, color={0,0,127}),
          Line(
            points={{-54,20},{-8,0},{-54,-20}},
            thickness=0.5),
          Line(points={{-54,-30},{-8,-30}}, thickness=0.5)}),
      Documentation(info="<html>
<p>
The output is <strong>true</strong> if Real input u1 is greater than or equal to
Real input u2, otherwise the output is <strong>false</strong>.
</p>
</html>"));
  end GreaterEqual;

  block Less "Output y is true, if input u1 is less than input u2"
    extends Blocks.Interfaces.partialBooleanComparison;

  equation
    y = u1 < u2;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false,extent={{-100,
              -100},{100,100}}), graphics={
          Ellipse(extent={{32,10},{52,-10}}, lineColor={0,0,127}),
          Line(points={{-100,-80},{42,-80},{42,0}}, color={0,0,127}),
          Line(points={{-8,20},{-54,0},{-8,-20}}, thickness=0.5)}), Documentation(info="<html>
<p>
The output is <strong>true</strong> if Real input u1 is less than
Real input u2, otherwise the output is <strong>false</strong>.
</p>
</html>"));
  end Less;

  block LessEqual "Output y is true, if input u1 is less or equal than input u2"
    extends Blocks.Interfaces.partialBooleanComparison;

  equation
    y = u1 <= u2;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false,extent={{-100,
              -100},{100,100}}), graphics={
          Ellipse(extent={{32,10},{52,-10}}, lineColor={0,0,127}),
          Line(points={{-100,-80},{42,-80},{42,0}}, color={0,0,127}),
          Line(points={{-8,20},{-54,0},{-8,-20}}, thickness=0.5),
          Line(points={{-54,-30},{-8,-30}}, thickness=0.5)}),
      Documentation(info="<html>
<p>
The output is <strong>true</strong> if Real input u1 is less than or equal to
Real input u2, otherwise the output is <strong>false</strong>.
</p>
</html>"));
  end LessEqual;

  block ZeroCrossing "Trigger zero crossing of input u"
    extends Blocks.Interfaces.partialBooleanSO;
    Blocks.Interfaces.RealInput u annotation (Placement(transformation(extent={
              {-140,-20},{-100,20}})));
    Blocks.Interfaces.BooleanInput enable
      "Zero input crossing is triggered if the enable input signal is true"
      annotation (Placement(transformation(
          origin={0,-120},
          extent={{-20,-20},{20,20}},
          rotation=90)));

  protected
    Boolean disable=not enable;
    Boolean u_pos;
  initial equation
    pre(u_pos) = false;
    pre(enable) = false;
    pre(disable) = not pre(enable);
  equation
    u_pos = enable and u >= 0;
    y = change(u_pos) and not edge(enable) and not edge(disable);
    annotation (Documentation(info="<html>
<p>
The output \"y\" is <strong>true</strong> at the
time instant when the input \"u\" becomes
zero, provided the input \"enable\" is
<strong>true</strong>. At all other time instants, the output \"y\" is <strong>false</strong>.
If the input \"u\" is zero at a time instant when the \"enable\"
input changes its value, then the output y is <strong>false</strong>.
</p>
<p>
Note, that in the plot window of a Modelica simulator, the output of
this block is usually identically to <strong>false</strong>, because the output
may only be <strong>true</strong> at an event instant, but not during
continuous integration. In order to check that this component is
actually working as expected, one should connect its output to, e.g.,
component <em><a href=\"modelica://Modelica.Blocks.Discrete.TriggeredSampler\">Modelica.Blocks.Discrete.TriggeredSampler</a></em>.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Line(points={{-78,68},{-78,-80}}, color={192,192,192}),
          Polygon(
            points={{-78,90},{-86,68},{-70,68},{-78,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-88,0},{70,0}}, color={192,192,192}),
          Line(points={{-78,0},{-73.2,32.3},{-70,50.3},{-66.7,64.5},{-63.5,74.2},
                {-60.3,79.3},{-57.1,79.6},{-53.9,75.3},{-50.7,67.1},{-46.6,52.2},
                {-41,25.8},{-33,-13.9},{-28.2,-33.7},{-24.1,-45.9},{-20.1,-53.2},
                {-16.1,-55.3},{-12.1,-52.5},{-8.1,-45.3},{-3.23,-32.1},{10.44,
                13.7},{15.3,26.4},{20.1,34.8},{24.1,38},{28.9,37.2},{33.8,31.8},
                {40.2,19.4},{53.1,-10.5},{59.5,-21.2},{65.1,-25.9},{70.7,-25.9},
                {77.2,-20.5},{82,-13.8}}, color={192,192,192}, smooth = Smooth.Bezier),
          Polygon(
            points={{92,0},{70,8},{70,-8},{92,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-36,-59},{-36,81}}, color={255,0,255}),
          Line(points={{6,-59},{6,81}}, color={255,0,255}),
          Line(points={{49,-59},{49,81}}, color={255,0,255}),
          Line(points={{-78,0},{70,0}}, color={255,0,255})}));
  end ZeroCrossing;

  block LogicalSwitch "Logical Switch"
    extends Blocks.Interfaces.partialBooleanSI3SO;

  equation
    y = if u2 then u1 else u3;
    annotation (Documentation(info="<html>
<p>The LogicalSwitch switches, depending on the
Boolean u2 connector (the middle connector),
between the two possible input signals
u1 (upper connector) and u3 (lower connector).</p>
<p>If u2 is true, connector y is set equal to
u1, else it is set equal to u3.</p>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}),
            graphics={
          Line(
            points={{12,0},{100,0}},
            color={255,0,255}),
          Line(
            points={{-100,0},{-40,0}},
            color={255,0,255}),
          Line(
            points={{-100,-80},{-40,-80},{-40,-80}},
            color={255,0,255}),
          Line(points={{-40,12},{-40,-10}}, color={255,0,255}),
          Line(points={{-100,80},{-40,80}}, color={255,0,255}),
          Line(
            points=DynamicSelect({{-40,80},{8,2}}, if u2 then {{-40,80},{8,2}} else {{-40,-80},{8,2}}),
            color={255,0,255},
            thickness=1),
          Ellipse(lineColor={0,0,127},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{2,-6},{18,8}})}));
  end LogicalSwitch;

  block Switch "Switch between two Real signals"
    extends Modelica.Blocks.Icons.PartialBooleanBlock;
    Blocks.Interfaces.RealInput u1 "Connector of first Real input signal"
      annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
    Blocks.Interfaces.BooleanInput u2 "Connector of Boolean input signal"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Blocks.Interfaces.RealInput u3 "Connector of second Real input signal"
      annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
    Blocks.Interfaces.RealOutput y "Connector of Real output signal"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  equation
    y = if u2 then u1 else u3;
    annotation (
      defaultComponentName="switch1",
      Documentation(info="<html>
<p>The Logical.Switch switches, depending on the
logical connector u2 (the middle connector)
between the two possible input signals
u1 (upper connector) and u3 (lower connector).</p>
<p>If u2 is <strong>true</strong>, the output signal y is set equal to
u1, else it is set equal to u3.</p>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{12,0},{100,0}},
            color={0,0,127}),
          Line(points={{-100,0},{-40,0}},
            color={255,0,255}),
          Line(points={{-100,-80},{-40,-80},{-40,-80}},
            color={0,0,127}),
          Line(points={{-40,12},{-40,-12}},
            color={255,0,255}),
          Line(points={{-100,80},{-38,80}},
            color={0,0,127}),
          Line(points=DynamicSelect({{-38,80},{6,2}}, if u2 then {{-38,80},{6,2}} else {{-38,-80},{6,2}}),
            color={0,0,127},
            thickness=1),
          Ellipse(lineColor={0,0,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{2,-8},{18,8}})}));
  end Switch;

  block Hysteresis "Transform Real to Boolean signal with Hysteresis"

    extends Modelica.Blocks.Icons.PartialBooleanBlock;
    parameter Real uLow(start=0) "If y=true and u<uLow, switch to y=false";
    parameter Real uHigh(start=1) "If y=false and u>uHigh, switch to y=true";
    parameter Boolean pre_y_start=false "Value of pre(y) at initial time";

    Blocks.Interfaces.RealInput u annotation (Placement(transformation(extent={
              {-140,-20},{-100,20}})));
    Blocks.Interfaces.BooleanOutput y annotation (Placement(transformation(
            extent={{100,-10},{120,10}})));

  initial equation
    pre(y) = pre_y_start;
  equation
    assert(uHigh > uLow,"Hysteresis limits wrong (uHigh <= uLow)");
    y = not pre(y) and u > uHigh or pre(y) and u >= uLow;
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Polygon(
              points={{-65,89},{-73,67},{-57,67},{-65,89}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-65,67},{-65,-81}},
            color={192,192,192}),Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{70,-80},{94,-100}},
              textColor={160,160,164},
              textString="u"),Text(
              extent={{-65,93},{-12,75}},
              textColor={160,160,164},
              textString="y"),Line(
              points={{-80,-70},{30,-70}},
              thickness=0.5),Line(
              points={{-50,10},{80,10}},
              thickness=0.5),Line(
              points={{-50,10},{-50,-70}},
              thickness=0.5),Line(
              points={{30,10},{30,-70}},
              thickness=0.5),Line(
              points={{-10,-65},{0,-70},{-10,-75}},
              thickness=0.5),Line(
              points={{-10,15},{-20,10},{-10,5}},
              thickness=0.5),Line(
              points={{-55,-20},{-50,-30},{-44,-20}},
              thickness=0.5),Line(
              points={{25,-30},{30,-19},{35,-30}},
              thickness=0.5),Text(
              extent={{-99,2},{-70,18}},
              textColor={160,160,164},
              textString="true"),Text(
              extent={{-98,-87},{-66,-73}},
              textColor={160,160,164},
              textString="false"),Text(
              extent={{19,-87},{44,-70}},
              textString="uHigh"),Text(
              extent={{-63,-88},{-38,-71}},
              textString="uLow"),Line(points={{-69,10},{-60,10}}, color={160,
            160,164})}),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,68},{-80,-29}}, color={192,192,192}),
          Polygon(
            points={{92,-29},{70,-21},{70,-37},{92,-29}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-79,-29},{84,-29}}, color={192,192,192}),
          Line(points={{-79,-29},{41,-29}}),
          Line(points={{-15,-21},{1,-29},{-15,-36}}),
          Line(points={{41,51},{41,-29}}),
          Line(points={{33,3},{41,22},{50,3}}),
          Line(points={{-49,51},{81,51}}),
          Line(points={{-4,59},{-19,51},{-4,43}}),
          Line(points={{-59,29},{-49,11},{-39,29}}),
          Line(points={{-49,51},{-49,-29}}),
          Text(
            extent={{-92,-49},{-9,-92}},
            textColor={192,192,192},
            textString="%uLow"),
          Text(
            extent={{2,-49},{91,-92}},
            textColor={192,192,192},
            textString="%uHigh"),
          Rectangle(extent={{-91,-49},{-8,-92}}, lineColor={192,192,192}),
          Line(points={{-49,-29},{-49,-49}}, color={192,192,192}),
          Rectangle(extent={{2,-49},{91,-92}}, lineColor={192,192,192}),
          Line(points={{41,-29},{41,-49}}, color={192,192,192})}),
      Documentation(info="<html>
<p>
This block transforms a <strong>Real</strong> input signal <strong>u</strong> into a <strong>Boolean</strong>
output signal <strong>y</strong>:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Logical/Hysteresis.png\"
     alt=\"Hysteresis.png\">
</div>

<ul>
<li> When the output was <strong>false</strong> and the input becomes
     <strong>greater</strong> than parameter <strong>uHigh</strong>, the output
     switches to <strong>true</strong>.</li>
<li> When the output was <strong>true</strong> and the input becomes
     <strong>less</strong> than parameter <strong>uLow</strong>, the output
     switches to <strong>false</strong>.</li>
</ul>
<p>
The start value of the output is defined via parameter
<strong>pre_y_start</strong> (= value of pre(y) at initial time).
The default value of this parameter is <strong>false</strong>.
</p>
</html>"));
  end Hysteresis;

  block OnOffController "On-off controller"
    extends Modelica.Blocks.Icons.PartialBooleanBlock;
    Blocks.Interfaces.RealInput reference
      "Connector of Real input signal used as reference signal" annotation (
        Placement(transformation(extent={{-140,80},{-100,40}})));
    Blocks.Interfaces.RealInput u
      "Connector of Real input signal used as measurement signal" annotation (
        Placement(transformation(extent={{-140,-40},{-100,-80}})));
    Blocks.Interfaces.BooleanOutput y
      "Connector of Real output signal used as actuator signal" annotation (
        Placement(transformation(extent={{100,-10},{120,10}})));

    parameter Real bandwidth(start=0.1) "Bandwidth around reference signal";
    parameter Boolean pre_y_start=false "Value of pre(y) at initial time";

  initial equation
    pre(y) = pre_y_start;
  equation
    y = pre(y) and (u < reference + bandwidth/2) or (u < reference - bandwidth/
      2);
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={
          Text(
            extent={{-92,74},{44,44}},
            textString="reference"),
          Text(
            extent={{-94,-52},{-34,-74}},
            textString="u"),
          Line(points={{-76,-32},{-68,-6},{-50,26},{-24,40},{-2,42},{16,36},{32,28},{48,12},{58,-6},{68,-28}},
            color={0,0,127}),
          Line(points={{-78,-2},{-6,18},{82,-12}},
            color={255,0,0}),
          Line(points={{-78,12},{-6,30},{82,0}}),
          Line(points={{-78,-16},{-6,4},{82,-26}}),
          Line(points={{-82,-18},{-56,-18},{-56,-40},{64,-40},{64,-20},{90,-20}},
            color={255,0,255})}), Documentation(info="<html>
<p>The block OnOffController sets the output signal <strong>y</strong> to <strong>true</strong> when
the input signal <strong>u</strong> falls below the <strong>reference</strong> signal minus half of
the bandwidth and sets the output signal <strong>y</strong> to <strong>false</strong> when the input
signal <strong>u</strong> exceeds the <strong>reference</strong> signal plus half of the bandwidth.</p>
</html>"));
  end OnOffController;

  block TriggeredTrapezoid "Triggered trapezoid generator"
    extends Modelica.Blocks.Icons.PartialBooleanBlock;

    parameter Real amplitude=1 "Amplitude of trapezoid";
    parameter SI.Time rising(final min=0) = 0
      "Rising duration of trapezoid";
    parameter SI.Time falling(final min=0) = rising
      "Falling duration of trapezoid";
    parameter Real offset=0 "Offset of output signal";

    Blocks.Interfaces.BooleanInput u "Connector of Boolean input signal"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Blocks.Interfaces.RealOutput y "Connector of Real output signal"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  protected
    discrete Real endValue "Value of y at time of recent edge";
    discrete Real rate "Current rising/falling rate";
    discrete SI.Time T
      "Predicted time of output reaching endValue";
  equation
    y = if time < T then endValue - (T - time)*rate else endValue;

    when {initial(),u,not u} then
      endValue = if u then offset + amplitude else offset;
      rate = if u and (rising > 0) then amplitude/rising else if not u and (
        falling > 0) then -amplitude/falling else 0;
      T = if u and not (rising > 0) or not u and not (falling > 0) or not abs(
        amplitude) > 0 or initial() then time else time + (endValue - pre(y))/
        rate;
    end when;
    annotation (
      Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}),
          graphics={
        Line(points={{-60,-70},{-60,-70},{-30,40},{8,40},{40,-70},{40,-70}},
          color={0,0,127}),
        Line(points={{-90,-70},{82,-70}},
          color={192,192,192}),
        Line(points={{-80,68},{-80,-80}},
          color={192,192,192}),
        Polygon(lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{90,-70},{68,-62},{68,-78},{90,-70}}),
        Polygon(lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{-80,90},{-88,68},{-72,68},{-80,90}}),
        Line(points={{-80,-70},{-60,-70},{-60,24},{8,24},{8,-70},{60,-70}},
          color={255,0,255})}),
      Documentation(info="<html>
<p>The block TriggeredTrapezoid has a Boolean input and a real
output signal and requires the parameters <em>amplitude</em>,
<em>rising</em>, <em>falling</em> and <em>offset</em>. The
output signal <strong>y</strong> represents a trapezoidal signal dependent on the
input signal <strong>u</strong>.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Logical/TriggeredTrapezoid.png\"
     alt=\"TriggeredTrapezoid.png\">
</div>

<p>The behaviour is as follows: Assume the initial input to be false. In this
case, the output will be <em>offset</em>. After a rising edge (i.e., the input
changes from false to true), the output is rising during <em>rising</em> to the
sum of <em>offset</em> and <em>amplitude</em>. In contrast, after a falling
edge (i.e., the input changes from true to false), the output is falling
during <em>falling</em> to a value of <em>offset</em>.
</p>
<p>Note, that the case of edges before expiration of rising or falling is
handled properly.</p>
</html>"));
  end TriggeredTrapezoid;

  block Timer
    "Timer measuring the time from the time instant where the Boolean input became true"

    extends Modelica.Blocks.Icons.PartialBooleanBlock;
    Blocks.Interfaces.BooleanInput u "Connector of Boolean input signal"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Blocks.Interfaces.RealOutput y "Connector of Real output signal"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  protected
    discrete SI.Time entryTime "Time instant when u became true";
  initial equation
    pre(entryTime) = 0;
  equation
    when u then
      entryTime = time;
    end when;
    y = if u then time - entryTime else 0.0;
    annotation (
      Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}),
          graphics={
        Line(points={{-90,-70},{82,-70}},
          color={192,192,192}),
        Line(points={{-80,68},{-80,-80}},
          color={192,192,192}),
        Polygon(lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{90,-70},{68,-62},{68,-78},{90,-70}}),
        Polygon(lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{-80,90},{-88,68},{-72,68},{-80,90}}),
        Line(points={{-80,-70},{-60,-70},{-60,-26},{38,-26},{38,-70},{66,-70}},
          color={255,0,255}),
        Line(points={{-80,0},{-62,0},{40,90},{40,0},{68,0}},
          color={0,0,127})}),
      Documentation(info="<html>
<p>When the Boolean input <strong>u</strong> becomes <strong>true</strong>, the timer starts
and the output <strong>y</strong> is the time that has elapsed since <strong>u</strong> became <strong>true</strong>.
When the input becomes <strong>false</strong>, the timer stops and the output is reset to zero.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Logical/Timer.png\"
     alt=\"Timer.png\">
</div>

</html>"));
  end Timer;

  block LogicalDelay "Delay boolean signal"
    extends Blocks.Icons.PartialBooleanBlock;
    parameter SI.Time delayTime(final min=0)=0 "Time delay";
    Blocks.Interfaces.BooleanInput u
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Blocks.Interfaces.BooleanOutput y1
      annotation (Placement(transformation(extent={{100,50},{120,70}})));
    Blocks.Interfaces.BooleanOutput y2
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  protected
    discrete SI.Time tSwitch;
  initial equation
    tSwitch = time - 2*delayTime;
  equation
    when {u, not u} then
      tSwitch = time;
    end when;
    y1 = if u then true else not (time >= tSwitch + delayTime);
    y2 = if not u then false else (time >= tSwitch + delayTime);
    annotation (Documentation(info="<html>
<p>
When input <code>u</code> gets true, output <code>y1</code> gets immediately true, whereas output <code>y2</code> gets true after <code>delayTime</code>.
</p>
<p>
When input <code>u</code> gets false, output <code>y1</code> gets false after <code>delayTime</code>, whereas output <code>y2</code> gets immediately false.
</p>
</html>"), Icon(graphics={
        Polygon(lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{-80,90},{-88,68},{-72,68},{-80,90}}),
        Line(points={{-80,68},{-80,-80}},
          color={192,192,192}),
        Line(points={{-90,-70},{82,-70}},
          color={192,192,192}),
        Polygon(lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{90,-70},{68,-62},{68,-78},{90,-70}}),
          Line(points={{-80,-10},{-60,-10},{-60,10},{40,10},{40,-10},{80,-10}},
              color={255,0,255}),
          Line(points={{-80,50},{-60,50},{-60,70},{50,70},{50,50},{80,50}},
              color={255,0,255}),
          Line(points={{-80,-70},{-50,-70},{-50,-50},{40,-50},{40,-70},{80,-70}},
              color={255,0,255}),
          Line(
            points={{-60,70},{-60,-70}},
            color={192,192,192},
            pattern=LinePattern.Dot),
          Line(
            points={{40,70},{40,-70}},
            color={192,192,192},
            pattern=LinePattern.Dot)}));
  end LogicalDelay;

  block RSFlipFlop "A basic RS Flip Flop"
    extends Modelica.Blocks.Icons.PartialBooleanBlock;
    parameter Boolean Qini=false "Start value of Q at initial time";
    Modelica.Blocks.Interfaces.BooleanOutput Q annotation (Placement(
          transformation(extent={{100,50},{120,70}})));
    Modelica.Blocks.Interfaces.BooleanOutput QI annotation (Placement(
          transformation(extent={{100,-70},{120,-50}})));
    Modelica.Blocks.Logical.Nor nor annotation (Placement(transformation(extent=
             {{-20,20},{0,40}})));
    Modelica.Blocks.Logical.Nor nor1 annotation (Placement(transformation(
            extent={{-20,-20},{0,0}})));
    Modelica.Blocks.Logical.Pre pre(pre_u_start=not (Qini)) annotation (
        Placement(transformation(extent={{10,20},{30,40}})));
    Modelica.Blocks.Interfaces.BooleanInput S
      annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
    Modelica.Blocks.Interfaces.BooleanInput R
      annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  equation
    connect(nor1.y, nor.u2) annotation (Line(points={{1,-10},{40,-10},{40,-40},
            {-60,-40},{-60,22},{-22,22}}, color={255,0,255}));
    connect(nor1.y, Q) annotation (Line(points={{1,-10},{60,-10},{60,60},{110,
            60}}, color={255,0,255}));
    connect(nor.y, pre.u)
      annotation (Line(points={{1,30},{8,30}}, color={255,0,255}));
    connect(pre.y, nor1.u1) annotation (Line(points={{31,30},{40,30},{40,10},{-40,
            10},{-40,-10},{-22,-10}}, color={255,0,255}));
    connect(pre.y, QI) annotation (Line(points={{31,30},{80,30},{80,-60},{110,-60}}, color={255,0,255}));
    connect(S, nor.u1) annotation (Line(
        points={{-120,60},{-40,60},{-40,30},{-22,30}}, color={255,0,255}));
    connect(R, nor1.u2) annotation (Line(
        points={{-120,-60},{-40,-60},{-40,-18},{-22,-18}}, color={255,0,255}));
  annotation (
    Icon(graphics={
        Text(
          extent={{-60,-30},{-20,-90}},
          textString="R"),
        Text(
          extent={{-62,90},{-22,30}},
          textString="S"),
        Text(
          extent={{20,90},{60,30}},
          textString="Q"),
        Text(
          extent={{6,-30},{66,-90}},
          textString="Q!"),
        Ellipse(
          extent={{-73,54},{-87,68}},
          lineColor=DynamicSelect({235,235,235}, if S then {0,255,0} else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if S then {0,255,0} else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{83,-53},{69,-67}},
          lineColor=DynamicSelect({235,235,235}, if QI then {0,255,0} else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if QI then {0,255,0} else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-71,-52},{-85,-66}},
          lineColor=DynamicSelect({235,235,235}, if R then {0,255,0} else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if R then {0,255,0} else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{71,67},{85,53}},
          lineColor=DynamicSelect({235,235,235}, if Q then {0,255,0} else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if Q then {0,255,0} else {235,235,235}),
          fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>
The output <code>Q</code> is set by the input <code>S</code>, is reset by the input <code>R</code>, and keeps its value in between. <code>QI</code> is the inverse of <code>Q</code>.
</p>
</html>"));
  end RSFlipFlop;

  block TerminateSimulation "Terminate simulation if condition is fulfilled"

    Modelica.Blocks.Interfaces.BooleanOutput condition=false
      "Terminate simulation when condition becomes true" annotation (Dialog,
        Placement(transformation(extent={{200,-10},{220,10}})));
    parameter String terminationText="... End condition reached"
      "Text that will be displayed when simulation is terminated";

  equation
    when condition then
      terminate(terminationText);
    end when;
    annotation (Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-200,-20},{200,20}},
          initialScale=0.2),
          graphics={
        Rectangle(fillColor={235,235,235},
          fillPattern=FillPattern.Solid,
          lineThickness=5,
          borderPattern=BorderPattern.Raised,
          extent={{-200,-20},{200,20}}),
        Text(extent={{-166,-15},{194,15}},
          textString="%condition"),
        Rectangle(fillColor={161,35,41},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised,
          extent={{-194,-14},{-168,14}}),
        Text(textColor={0,0,255},
          extent={{-200,22},{200,46}},
          textString="%name")}), Documentation(info="<html>
<p>
In the parameter menu, a <strong>time varying</strong> expression can be defined
via variable <strong>condition</strong>, for example \"condition = x &lt; 0\",
where \"x\" is a variable that is declared in the model in which the
\"TerminateSimulation\" block is present.
If this expression becomes <strong>true</strong>,
the simulation is (successfully) terminated. A termination message
explaining the reason for the termination can be given via
parameter \"terminationText\".
</p>

</html>"));
  end TerminateSimulation;
  annotation (Documentation(info="<html>
<p>
This package provides blocks with Boolean input and output signals
to describe logical networks. A typical example for a logical
network built with package Logical is shown in the next figure:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Logical/LogicalNetwork1.png\"
     alt=\"LogicalNetwork1.png\">
</div>

<p>
The actual value of Boolean input and/or output signals is displayed
in the respective block icon as \"circle\", where \"white\" color means
value <strong>false</strong> and \"green\" color means value <strong>true</strong>. These
values are visualized in a diagram animation.
</p>
</html>"), Icon(graphics={Line(
          points={{-86,-22},{-50,-22},{-50,22},{48,22},{48,-22},{88,-24}},
          color={255,0,255})}));
end Logical;
