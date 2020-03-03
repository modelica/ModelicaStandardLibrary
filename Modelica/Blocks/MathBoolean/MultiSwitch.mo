within Modelica.Blocks.MathBoolean;
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
