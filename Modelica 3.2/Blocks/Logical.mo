within Modelica.Blocks;
package Logical "Library of components with Boolean input and output signals"
    extends Modelica.Icons.Package;

  model And "Logical 'and': y = u1 and u2"
    extends Blocks.Interfaces.partialBooleanSI2SO;
  equation
    y = u1 and u2;
    annotation (defaultComponentName="and1",
           Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            lineColor={0,0,0},
            textString="and")}),
                              Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-100,-100},{100,100}}),
                                      graphics),
      Documentation(info="<html>
<p>
The output is <b>true</b> if all inputs are <b>true</b>, otherwise
the output is <b>false</b>.
</p>
</html>"));
  end And;

  model Or "Logical 'or': y = u1 or u2"
    extends Blocks.Interfaces.partialBooleanSI2SO;
  equation
    y = u1 or u2;
    annotation (defaultComponentName="or1",
           Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            lineColor={0,0,0},
            textString="or")}),
                              Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-100,-100},{100,100}}),
                                      graphics),
      Documentation(info="<html>
<p>
The output is <b>true</b> if at least one input is <b>true</b>, otherwise
the output is <b>false</b>.
</p>
</html>"));
  end Or;

  model Xor "Logical 'xor': y = u1 xor u2"
    extends Blocks.Interfaces.partialBooleanSI2SO;
  equation
    y =not  ( (u1 and u2) or (not u1 and not u2));
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            lineColor={0,0,0},
            textString="xor")}),
                              Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-100,-100},{100,100}}),
                                      graphics),
      Documentation(info="<html>
<p>
The output is <b>true</b> if exactly one input is <b>true</b>, otherwise
the output is <b>false</b>.
</p>
</html>"));
  end Xor;

  model Nor "Logical 'nor': y = not (u1 or u2)"
    extends Blocks.Interfaces.partialBooleanSI2SO;
  equation
    y =not  ( u1 or u2);
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            lineColor={0,0,0},
            textString="nor")}),
                              Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-100,-100},{100,100}}),
                                      graphics),
      Documentation(info="<html>
<p>
The output is <b>true</b> if none of the inputs is <b>true</b>, otherwise
the output is <b>false</b>.
</p>
</html>"));
  end Nor;

  model Nand "Logical 'nand': y = not (u1 and u2)"
    extends Blocks.Interfaces.partialBooleanSI2SO;
  equation
    y =not  ( u1 and u2);
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            lineColor={0,0,0},
            textString="nand")}),
                              Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-100,-100},{100,100}}),
                                      graphics),
      Documentation(info="<html>
<p>
The output is <b>true</b> if at least one input is <b>false</b>, otherwise
the output is <b>false</b>.
</p>
</html>"));
  end Nand;

  model Not "Logical 'not': y = not u"
    extends Blocks.Interfaces.partialBooleanSISO;

  equation
    y =not  u;
    annotation (defaultComponentName="not1",
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            lineColor={0,0,0},
            textString="not")}),
                            Diagram(coordinateSystem(preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}),
                                    graphics),
      Documentation(info="<html>
<p>
The output is <b>true</b> if the input is <b>false</b>, otherwise
the output is <b>false</b>.
</p>
</html>"));
  end Not;

  model Pre
    "Breaks algebraic loops by an infinitesimal small time delay (y = pre(u): event iteration continues until u = pre(u))"

    parameter Boolean pre_u_start = false
      "Start value of pre(u) at initial time";
    extends Blocks.Interfaces.partialBooleanSISO;

  initial equation
    pre(u) = pre_u_start;
  equation
    y = pre(u);
    annotation (defaultComponentName="pre1",
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            lineColor={0,0,0},
            textString="pre")}),
                            Diagram(coordinateSystem(preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}),
                                    graphics),
      Documentation(info="<html>
<p>
This block delays the Boolean input by an infinitesimal small time delay and
therefore breaks algebraic loops. In a network of logical blocks, in every
\"closed connection loop\" at least one logical block must have a delay,
since algebraic systems of Boolean equations are not solveable.
</p>

<p>
The \"Pre\" block returns the value of the \"input\" signal from the
last \"event iteration\". The \"event iteration\" stops, once both
values are identical (u = pre(u)).
</p>
</html>"));
  end Pre;

  model Edge "Output y is true, if the input u has a rising edge (y = edge(u))"

    parameter Boolean pre_u_start = false
      "Start value of pre(u) at initial time";
    extends Blocks.Interfaces.partialBooleanSISO;

  initial equation
    pre(u) = pre_u_start;
  equation
    y = edge(u);
    annotation (defaultComponentName="edge1",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            lineColor={0,0,0},
            textString="edge")}),
                            Diagram(coordinateSystem(preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}),
                                    graphics),
      Documentation(info="<html>
<p>
The output is <b>true</b> if the Boolean input has a rising edge
from <b>false</b> to <b>true</b>, otherwise
the output is <b>false</b>.
</p>
</html>"));
  end Edge;

  model FallingEdge
    "Output y is true, if the input u has a falling edge (y = edge(not u))"

    parameter Boolean pre_u_start = false
      "Start value of pre(u) at initial time";
    extends Blocks.Interfaces.partialBooleanSISO;

  protected
   Boolean not_u=not u;
  initial equation
    pre(not_u) =not  pre_u_start;
  equation
    y = edge(not_u);
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            lineColor={0,0,0},
            textString="falling")}),
                            Diagram(coordinateSystem(preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}),
                                    graphics),
      Documentation(info="<html>
<p>
The output is <b>true</b> if the Boolean input has a falling edge
from <b>true</b> to <b>false</b>, otherwise
the output is <b>false</b>.
</p>
</html>"));
  end FallingEdge;

  model Change
    "Output y is true, if the input u has a rising or falling edge (y = change(u))"

    parameter Boolean pre_u_start = false
      "Start value of pre(u) at initial time";
    extends Blocks.Interfaces.partialBooleanSISO;

  initial equation
    pre(u) = pre_u_start;
  equation
    y = change(u);
    annotation (defaultComponentName="change1",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Text(
            extent={{-90,40},{90,-40}},
            lineColor={0,0,0},
            textString="change")}),
                            Diagram(coordinateSystem(preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}),
                                    graphics),
      Documentation(info="<html>
<p>
The output is <b>true</b> if the Boolean input has either a rising edge
from <b>false</b> to <b>true</b> or a falling edge from
<b>true</b> to <b>false</b>, otherwise
the output is <b>false</b>.
</p>
</html>"));
  end Change;

  block GreaterThreshold
    "Output y is true, if input u is greater than threshold"
    extends Blocks.Interfaces.partialBooleanThresholdComparison;
  equation
    y = u > threshold;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Text(
            extent={{-90,-40},{60,40}},
            lineColor={0,0,0},
            textString=">")}),
                        Diagram(coordinateSystem(preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}),
                                graphics),
      Documentation(info="<html>
<p>
The output is <b>true</b> if the Real input is greater than
parameter <b>threshold</b>, otherwise
the output is <b>false</b>.
</p>
</html>"));
  end GreaterThreshold;

  block GreaterEqualThreshold
    "Output y is true, if input u is greater or equal than threshold"

    extends Blocks.Interfaces.partialBooleanThresholdComparison;
  equation
    y = u >= threshold;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Text(
            extent={{-90,-40},{60,40}},
            lineColor={0,0,0},
            textString=">=")}),
                            Diagram(coordinateSystem(preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}),
                                    graphics),
      Documentation(info="<html>
<p>
The output is <b>true</b> if the Real input is greater than or equal to
parameter <b>threshold</b>, otherwise
the output is <b>false</b>.
</p>
</html>"));
  end GreaterEqualThreshold;

  block LessThreshold "Output y is true, if input u is less than threshold"

    extends Blocks.Interfaces.partialBooleanThresholdComparison;
  equation
    y = u < threshold;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Text(
            extent={{-90,-40},{60,40}},
            lineColor={0,0,0},
            textString="<")}),
                            Diagram(coordinateSystem(preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}),
                                    graphics),
      Documentation(info="<html>
<p>
The output is <b>true</b> if the Real input is less than
parameter <b>threshold</b>, otherwise
the output is <b>false</b>.
</p>
</html>"));
  end LessThreshold;

  block LessEqualThreshold
    "Output y is true, if input u is less or equal than threshold"
    extends Blocks.Interfaces.partialBooleanThresholdComparison;
  equation
    y = u <= threshold;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Text(
            extent={{-90,-40},{60,40}},
            lineColor={0,0,0},
            textString="<=")}),
                            Diagram(coordinateSystem(preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}),
                                    graphics),
      Documentation(info="<html>
<p>
The output is <b>true</b> if the Real input is less than or equal to
parameter <b>threshold</b>, otherwise
the output is <b>false</b>.
</p>
</html>"));
  end LessEqualThreshold;

  block Greater "Output y is true, if input u1 is greater as input u2"
    extends Blocks.Interfaces.partialBooleanComparison;

  equation
    y = u1 > u2;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={
          Ellipse(extent={{32,10},{52,-10}}, lineColor={0,0,255}),
          Line(points={{-100,-80},{42,-80},{42,0}}, color={0,0,255}),
          Text(
            extent={{-80,-60},{20,60}},
            lineColor={0,0,0},
            textString=">")}),
        Documentation(info="<html>
<p>
The output is <b>true</b> if Real input u1 is greater than
Real input u2, otherwise the output is <b>false</b>.
</p>
</html>"));
  end Greater;

  block GreaterEqual
    "Output y is true, if input u1 is greater or equal as input u2"
    extends Blocks.Interfaces.partialBooleanComparison;

  equation
    y = u1 >= u2;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={
          Ellipse(extent={{32,10},{52,-10}}, lineColor={0,0,255}),
          Line(points={{-100,-80},{42,-80},{42,0}}, color={0,0,255}),
          Text(
            extent={{-80,-60},{20,60}},
            lineColor={0,0,0},
            textString=">=")}),
        Documentation(info="<html>
<p>
The output is <b>true</b> if Real input u1 is greater than or equal to
Real input u2, otherwise the output is <b>false</b>.
</p>
</html>"));
  end GreaterEqual;

  block Less "Output y is true, if input u1 is less as input u2"
    extends Blocks.Interfaces.partialBooleanComparison;

  equation
    y = u1 < u2;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={
          Ellipse(extent={{32,10},{52,-10}}, lineColor={0,0,255}),
          Line(points={{-100,-80},{42,-80},{42,0}}, color={0,0,255}),
          Text(
            extent={{-80,-60},{20,60}},
            lineColor={0,0,0},
            textString="<")}),
        Documentation(info="<html>
<p>
The output is <b>true</b> if Real input u1 is less than
Real input u2, otherwise the output is <b>false</b>.
</p>
</html>"));
  end Less;

  block LessEqual "Output y is true, if input u1 is less or equal as input u2"
    extends Blocks.Interfaces.partialBooleanComparison;

  equation
    y = u1 <= u2;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={
          Ellipse(extent={{32,10},{52,-10}}, lineColor={0,0,255}),
          Line(points={{-100,-80},{42,-80},{42,0}}, color={0,0,255}),
          Text(
            extent={{-80,-60},{20,60}},
            lineColor={0,0,0},
            textString="<=")}),
        Documentation(info="<html>
<p>
The output is <b>true</b> if Real input u1 is less than or equal to
Real input u2, otherwise the output is <b>false</b>.
</p>
</html>"));
  end LessEqual;

  block ZeroCrossing "Trigger zero crossing of input u"
    extends Blocks.Interfaces.partialBooleanSO;
    Blocks.Interfaces.RealInput u annotation (Placement(transformation(extent={
              {-140,-20},{-100,20}}, rotation=0)));
    Blocks.Interfaces.BooleanInput enable
      "Zero input crossing is triggered if the enable input signal is true"
      annotation (Placement(transformation(
          origin={0,-120},
          extent={{-20,-20},{20,20}},
          rotation=90)));

  protected
    Boolean disable=not   enable;
    Boolean u_pos;
  initial equation
    pre(u_pos)  = false;
    pre(enable) = false;
    pre(disable) =not  pre(enable);
  equation
    u_pos = enable and u >= 0;
    y = change(u_pos) and not edge(enable) and not edge(disable);
    annotation (Documentation(info="<HTML>
<p>
The output \"y\" is <b>true</b> at the
time instant when the input \"u\" becomes
zero, provided the input \"enable\" is
<b>true</b>. At all other time instants, the output \"y\" is <b>false</b>.
If the input \"u\" is zero at a time instant when the \"enable\"
input changes its value, then the output y is <b>false</b>.
</p>
<p>
Note, that in the plot window of a Modelica simulator, the output of
this block is usually identically to <b>false</b>, because the output
may only be <b>true</b> at an event instant, but not during
continuous integration. In order to check that this component is
actually working as expected, one should connect its output to, e.g.,
component <i>ModelicaAdditions.Blocks.Discrete.TriggeredSampler</i>.
</p>
</HTML>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
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
                {77.2,-20.5},{82,-13.8}}, color={192,192,192}),
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
    annotation (
      Documentation(info="<html>
<p>The LogicalSwitch switches, depending on the
Boolean u2 connector (the middle connector),
between the two possible input signals
u1 (upper connector) and u3 (lower connector).</p>
<p>If u2 is true, connector y is set equal to
u1, else it is set equal to u3.</p>
</html>
"),   Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(
            points={{12,0},{100,0}},
            color={255,0,255},
            pattern=LinePattern.Solid,
            thickness=0.25,
            arrow={Arrow.None,Arrow.None}),
          Line(
            points={{-100,0},{-40,0}},
            color={255,0,255},
            pattern=LinePattern.Solid,
            thickness=0.25,
            arrow={Arrow.None,Arrow.None}),
          Line(
            points={{-100,-80},{-40,-80},{-40,-80}},
            color={255,0,255},
            pattern=LinePattern.Solid,
            thickness=0.25,
            arrow={Arrow.None,Arrow.None}),
          Line(points={{-40,12},{-40,-10}}, color={255,0,255}),
          Line(points={{-100,80},{-40,80}}, color={255,0,255}),
          Line(
            points={{-40,80},{8,2}},
            color={255,0,127},
            thickness=1),
          Ellipse(
            extent={{2,8},{18,-6}},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics));
  end LogicalSwitch;

  block Switch "Switch between two Real signals"
    extends Blocks.Interfaces.partialBooleanBlockIcon;
    Blocks.Interfaces.RealInput u1 "Connector of first Real input signal"
                                   annotation (Placement(transformation(extent=
              {{-140,60},{-100,100}}, rotation=0)));
    Blocks.Interfaces.BooleanInput u2 "Connector of Boolean input signal"
                                      annotation (Placement(transformation(
            extent={{-140,-20},{-100,20}}, rotation=0)));
    Blocks.Interfaces.RealInput u3 "Connector of second Real input signal"
                                   annotation (Placement(transformation(extent=
              {{-140,-100},{-100,-60}}, rotation=0)));
    Blocks.Interfaces.RealOutput y "Connector of Real output signal"
                                   annotation (Placement(transformation(extent=
              {{100,-10},{120,10}}, rotation=0)));

  equation
    y = if u2 then u1 else u3;
    annotation (defaultComponentName="switch1",
      Documentation(info="<html>
<p>The Logical.Switch switches, depending on the
logical connector u2 (the middle connector)
between the two possible input signals
u1 (upper connector) and u3 (lower connector).</p>
<p>If u2 is <b>true</b>, the output signal y is set equal to
u1, else it is set equal to u3.</p>
</html>
"),   Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(
            points={{12,0},{100,0}},
            pattern=LinePattern.Solid,
            thickness=0.25,
            arrow={Arrow.None,Arrow.None},
            color={0,0,255}),
          Line(
            points={{-100,0},{-40,0}},
            color={255,0,127},
            pattern=LinePattern.Solid,
            thickness=0.25,
            arrow={Arrow.None,Arrow.None}),
          Line(
            points={{-100,-80},{-40,-80},{-40,-80}},
            pattern=LinePattern.Solid,
            thickness=0.25,
            arrow={Arrow.None,Arrow.None},
            color={0,0,255}),
          Line(points={{-40,12},{-40,-12}}, color={255,0,127}),
          Line(points={{-100,80},{-38,80}}, color={0,0,255}),
          Line(
            points={{-38,80},{6,2}},
            thickness=1,
            color={0,0,255}),
          Ellipse(
            extent={{2,8},{18,-6}},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics));
  end Switch;

  block Hysteresis "Transform Real to Boolean signal with Hysteresis"

    extends Blocks.Interfaces.partialBooleanBlockIcon;
    parameter Real uLow(start=0) "if y=true and u<=uLow, switch to y=false";
    parameter Real uHigh(start=1) "if y=false and u>=uHigh, switch to y=true";
    parameter Boolean pre_y_start = false "Value of pre(y) at initial time";

    Blocks.Interfaces.RealInput u annotation (Placement(transformation(extent={
              {-140,-20},{-100,20}}, rotation=0)));
    Blocks.Interfaces.BooleanOutput y
      annotation (Placement(transformation(extent={{100,-10},{120,10}},
            rotation=0)));

  initial equation
    pre(y) = pre_y_start;
  equation
     y = u > uHigh or pre(y) and u >= uLow;
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
          Polygon(
            points={{-65,89},{-73,67},{-57,67},{-65,89}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-65,67},{-65,-81}}, color={192,192,192}),
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{70,-80},{94,-100}},
            lineColor={160,160,164},
            textString="u"),
          Text(
            extent={{-65,93},{-12,75}},
            lineColor={160,160,164},
            textString="y"),
          Line(
            points={{-80,-70},{30,-70}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{-50,10},{80,10}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{-50,10},{-50,-70}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{30,10},{30,-70}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{-10,-65},{0,-70},{-10,-75}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{-10,15},{-20,10},{-10,5}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{-55,-20},{-50,-30},{-44,-20}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{25,-30},{30,-19},{35,-30}},
            color={0,0,0},
            thickness=0.5),
          Text(
            extent={{-99,2},{-70,18}},
            lineColor={160,160,164},
            textString="true"),
          Text(
            extent={{-98,-87},{-66,-73}},
            lineColor={160,160,164},
            textString="false"),
          Text(
            extent={{19,-87},{44,-70}},
            lineColor={0,0,0},
            textString="uHigh"),
          Text(
            extent={{-63,-88},{-38,-71}},
            lineColor={0,0,0},
            textString="uLow"),
          Line(points={{-69,10},{-60,10}}, color={160,160,164})}),
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
          Line(points={{-79,-29},{41,-29}}, color={0,0,0}),
          Line(points={{-15,-21},{1,-29},{-15,-36}}, color={0,0,0}),
          Line(points={{41,51},{41,-29}}, color={0,0,0}),
          Line(points={{33,3},{41,22},{50,3}}, color={0,0,0}),
          Line(points={{-49,51},{81,51}}, color={0,0,0}),
          Line(points={{-4,59},{-19,51},{-4,43}}, color={0,0,0}),
          Line(points={{-59,29},{-49,11},{-39,29}}, color={0,0,0}),
          Line(points={{-49,51},{-49,-29}}, color={0,0,0}),
          Text(
            extent={{-92,-49},{-9,-92}},
            lineColor={192,192,192},
            textString="%uLow"),
          Text(
            extent={{2,-49},{91,-92}},
            lineColor={192,192,192},
            textString="%uHigh"),
          Rectangle(extent={{-91,-49},{-8,-92}}, lineColor={192,192,192}),
          Line(points={{-49,-29},{-49,-49}}, color={192,192,192}),
          Rectangle(extent={{2,-49},{91,-92}}, lineColor={192,192,192}),
          Line(points={{41,-29},{41,-49}}, color={192,192,192})}),
      Documentation(info="<HTML>
<p>
This block transforms a <b>Real</b> input signal into a <b>Boolean</b>
output signal:
</p>
<ul>
<li> When the output was <b>false</b> and the input becomes
     <b>greater</b> than parameter <b>uHigh</b>, the output
     switches to <b>true</b>.</li>
<li> When the output was <b>true</b> and the input becomes
     <b>less</b> than parameter <b>uLow</b>, the output
     switches to <b>false</b>.</li>
</ul>
<p>
The start value of the output is defined via parameter
<b>pre_y_start</b> (= value of pre(y) at initial time).
The default value of this parameter is <b>false</b>.
</p>
</HTML>
"));
  end Hysteresis;

  block OnOffController "On-off controller"
    extends Interfaces.partialBooleanBlockIcon;
    Blocks.Interfaces.RealInput reference
      "Connector of Real input signal used as reference signal"
                                          annotation (Placement(transformation(
            extent={{-140,80},{-100,40}}, rotation=0)));
    Blocks.Interfaces.RealInput u
      "Connector of Real input signal used as measurement signal"
                                  annotation (Placement(transformation(extent={
              {-140,-40},{-100,-80}}, rotation=0)));
    Blocks.Interfaces.BooleanOutput y
      "Connector of Real output signal used as actuator signal"
                                      annotation (Placement(transformation(
            extent={{100,-10},{120,10}}, rotation=0)));

    parameter Real bandwidth(start=0.1) "Bandwidth around reference signal";
    parameter Boolean pre_y_start = false "Value of pre(y) at initial time";

  initial equation
    pre(y) = pre_y_start;
  equation
    y = pre(y) and (u < reference + bandwidth/2) or (u < reference - bandwidth/2);
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={
          Text(
            extent={{-92,74},{44,44}},
            lineColor={0,0,0},
            lineThickness=0.5,
            textString="reference"),
          Text(
            extent={{-94,-52},{-34,-74}},
            lineColor={0,0,0},
            textString="u"),
          Line(points={{-76,-32},{-68,-6},{-50,26},{-24,40},{-2,42},{16,36},{32,
                28},{48,12},{58,-6},{68,-28}}, color={0,0,255}),
          Line(points={{-78,-2},{-6,18},{82,-12}}, color={255,0,0}),
          Line(points={{-78,12},{-6,30},{82,0}}, color={0,0,0}),
          Line(points={{-78,-16},{-6,4},{82,-26}}, color={0,0,0}),
          Line(points={{-82,-18},{-56,-18},{-56,-40},{64,-40},{64,-20},{90,-20}},
              color={255,0,255})}),         Documentation(info="<html>
<p>The block OnOffController sets the output signal <b>y</b> to <b>true</b> when
the input signal <b>u</b> falls below the <b>reference</b> signal minus half of
the bandwidth and sets the output signal <b>y</b> to <b>false</b> when the input
signal <b>u</b> exceeds the <b>reference</b> signal plus half of the bandwidth.</p>
</html>
"));
  end OnOffController;

  block TriggeredTrapezoid "Triggered trapezoid generator"
    extends Interfaces.partialBooleanBlockIcon;

    parameter Real amplitude=1 "Amplitude of trapezoid";
    parameter Modelica.SIunits.Time rising(final min=0)=0
      "Rising duration of trapezoid";
    parameter Modelica.SIunits.Time falling(final min=0)=rising
      "Falling duration of trapezoid";
    parameter Real offset=0 "Offset of output signal";

    Blocks.Interfaces.BooleanInput u "Connector of Boolean input signal"
                                     annotation (Placement(transformation(
            extent={{-140,-20},{-100,20}}, rotation=0)));
    Blocks.Interfaces.RealOutput y "Connector of Real output signal"
      annotation (Placement(transformation(extent={{100,-10},{120,10}},
            rotation=0)));

  protected
    discrete Real endValue "Value of y at time of recent edge";
    discrete Real rate "Current rising/falling rate";
    discrete Modelica.SIunits.Time T
      "Predicted time of output reaching endValue";
  initial equation
    /* A start value of y is set, because pre(y) is present
     to avoid a warning message from the compiler. However,
     this setting does not have an effect, because y is initialized
     correctly, before pre(y) is used
  */
    pre(y) = 0;
  equation
      y = if time < T then endValue - (T - time)*rate else  endValue;

      when {initial(),u,not u} then
        endValue = if u then offset + amplitude else offset;
        rate = if u and (rising > 0) then amplitude/rising else
          if not u and (falling > 0) then -amplitude/falling else 0;
        T = if u and not (rising > 0) or not u and not (falling
           > 0) or not abs(amplitude) > 0 or initial() then time else time
           + (endValue - pre(y))/rate;
      end when;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{-60,-70},{-60,-70},{-30,40},{8,40},{40,-70},{40,-70}},
              color={0,0,255}),
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-70},{-60,-70},{-60,24},{8,24},{8,-70},{60,-70}},
              color={255,0,255})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
          Line(points={{-80,-20},{-60,-20},{-30,40},{8,40},{40,-20},{60,-20}},
              color={0,0,255}),
          Line(points={{-90,-70},{82,-70}}, color={0,0,0}),
          Line(points={{-80,68},{-80,-80}}, color={0,0,0}),
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-68},{-60,-68},{-60,-42},{8,-42},{8,-68},{60,-68}},
              color={255,0,255}),
          Line(
            points={{-60,40},{-60,-42}},
            color={0,0,0},
            pattern=LinePattern.Dot),
          Line(
            points={{8,-42},{8,40}},
            color={0,0,0},
            pattern=LinePattern.Dot),
          Line(points={{-60,40},{-30,40}}, color={0,0,0}),
          Line(points={{8,-20},{40,-20}}, color={0,0,0}),
          Line(points={{-20,40},{-20,-20}}, color={0,0,0}),
          Line(points={{-20,-20},{-20,-70}}, color={0,0,0}),
          Text(
            extent={{-44,50},{-44,40}},
            lineColor={0,0,0},
            textString="rising"),
          Text(
            extent={{24,-10},{24,-20}},
            lineColor={0,0,0},
            textString="falling"),
          Polygon(
            points={{-60,40},{-56,42},{-56,38},{-60,40}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-30,40},{-34,42},{-34,38},{-30,40}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{8,-20},{12,-18},{12,-22},{8,-20}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{40,-20},{36,-18},{36,-22},{40,-20}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-22,-24},{-20,-20},{-18,-24},{-22,-24}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-18,-66},{-22,-66},{-20,-70},{-18,-66}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-22,36},{-20,40},{-18,36},{-22,36}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-18,-16},{-22,-16},{-20,-20},{-18,-16}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-40,6},{0,-4}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-20,6},{-20,-4}},
            lineColor={0,0,0},
            textString="amplitude"),
          Rectangle(
            extent={{-40,-48},{0,-58}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-20,-48},{-20,-58}},
            lineColor={0,0,0},
            textString="offset"),
          Text(
            extent={{60,-82},{94,-92}},
            lineColor={0,0,0},
            textString="time"),
          Text(
            extent={{-88,-4},{-54,-14}},
            lineColor={0,0,0},
            textString="y"),
          Text(
            extent={{-88,-46},{-54,-56}},
            lineColor={0,0,0},
            textString="u")}),
      Documentation(info="<HTML>
<p>The block TriggeredTrapezoid has a boolean input and a real
output signal and requires the parameters <i>amplitude</i>,
<i>rising</i>, <i>falling</i> and <i>offset</i>. The
output signal <b>y</b> represents a trapezoidal signal dependent on the
input signal <b>u</b>.
</p>
<p>The behaviour is as follows: Assume the initial input to be false. In this
case, the output will be <i>offset</i>. After a rising edge (i.e., the input
changes from false to true), the output is rising during <i>rising</i> to the
sum of <i>offset</i> and <i>amplitude</i>. In contrast, after a falling
edge (i.e., the input changes from true to false), the output is falling
during <i>falling</i> to a value of <i>offset</i>.
</p>
<p>Note, that the case of edges before expiration of rising or falling is
handled properly.</p>
</HTML>
"));
  end TriggeredTrapezoid;

  block Timer
    "Timer measuring the time from the time instant where the Boolean input became true"

    extends Interfaces.partialBooleanBlockIcon;
    Blocks.Interfaces.BooleanInput u "Connector of Boolean input signal"
                                     annotation (Placement(transformation(
            extent={{-140,-20},{-100,20}}, rotation=0)));
    Blocks.Interfaces.RealOutput y "Connector of Real output signal"
      annotation (Placement(transformation(extent={{100,-10},{120,10}},
            rotation=0)));

  protected
    discrete Modelica.SIunits.Time entryTime "Time instant when u became true";
  initial equation
    pre(entryTime) = 0;
  equation
    when u then
      entryTime = time;
    end when;
    y = if u then time - entryTime else 0.0;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-70},{-60,-70},{-60,-26},{38,-26},{38,-70},{66,-70}},
              color={255,0,255}),
          Line(points={{-80,0},{-62,0},{40,90},{40,0},{68,0}}, color={0,0,255})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
          Line(points={{-90,-70},{82,-70}}, color={0,0,0}),
          Line(points={{-80,68},{-80,-80}}, color={0,0,0}),
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-68},{-60,-68},{-60,-40},{20,-40},{20,-68},{60,-68}},
              color={255,0,255}),
          Line(points={{-80,-20},{-60,-20},{20,60},{20,-20},{60,-20},{60,-20}},
              color={0,0,255}),
          Text(
            extent={{-88,6},{-54,-4}},
            lineColor={0,0,0},
            textString="y"),
          Text(
            extent={{48,-80},{84,-88}},
            lineColor={0,0,0},
            textString="time"),
          Text(
            extent={{-88,-36},{-54,-46}},
            lineColor={0,0,0},
            textString="u")}),
      Documentation(info="<HTML>
<p> When the Boolean input \"u\" becomes <b>true</b>, the timer is started
and the output \"y\" is the time from the time instant where u became true.
The timer is stopped and the output is reset to zero, once the
input becomes false.
</p>
</HTML>
"));
  end Timer;

  block TerminateSimulation "Terminate simulation if condition is fullfilled"

    Modelica.Blocks.Interfaces.BooleanOutput condition=false
      "Terminate simulation when condition becomes true"
      annotation (Dialog, Placement(transformation(extent={{200,-10},{220,10}},
            rotation=0)));
    parameter String terminationText = "... End condition reached"
      "Text that will be displayed when simulation is terminated";

  equation
    when condition then
       terminate(terminationText);
    end when;
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-200,-20},{200,20}},
          grid={2,2},
          initialScale=0.2), graphics={
          Rectangle(
            extent={{-200,20},{200,-20}},
            lineColor={0,0,0},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Text(
            extent={{-166,15},{194,-15}},
            lineColor={0,0,0},
            textString="%condition"),
          Rectangle(
            extent={{-194,14},{-168,-14}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Text(
            extent={{-200,46},{200,22}},
            lineColor={0,0,255},
            textString="%name")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-200,-20},{200,20}},
          grid={2,2},
          initialScale=0.2), graphics),
      Documentation(info="<html>
<p>
In the parameter menu, a <b>time varying</b> expression can be defined
via variable <b>condition</b>, for example \"condition = x &lt; 0\",
where \"x\" is a variable that is declared in the model in which the
\"TerminateSimulation\" block is present.
If this expression becomes <b>true</b>,
the simulation is (successfully) terminated. A termination message
explaining the reason for the termination can be given via
parameter \"terminationText\".
</p>

</html>"));
  end TerminateSimulation;
  annotation(Documentation(info="<html>
<p>
This package provides blocks with Boolean input and output signals
to describe logical networks. A typical example for a logical
network built with package Logical is shown in the next figure:
</p>

<img src=\"modelica://Modelica/Resources/Images/Blocks/LogicalNetwork1.png\">

<p>
The actual value of Boolean input and/or output signals is displayed
in the respective block icon as \"circle\", where \"white\" color means
value <b>false</b> and \"green\" color means value <b>true</b>. These
values are visualized in a diagram animation.
</p>
</html>"));
end Logical;
