within Modelica.Blocks.MathInteger;
block MultiSwitch
    "Set Integer expression that is associated with the first active input signal"

  input Integer expr[nu]=fill(0, nu)
      "y = if u[i] then expr[i] elseif use_pre_as_default then pre(y) else y_default" annotation(Dialog);
  parameter Integer y_default=0
      "Default value of output y if use_pre_as_default=false, as well as pre(y) at initial time";

  parameter Boolean use_pre_as_default=true
      "= true, y holds its last value if all u[i]=false, otherwise y=y_default"
        annotation(HideResult=true, choices(checkBox=true));
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
  firstActiveIndex = Modelica.Math.BooleanVectors.firstTrueIndex(
                                                  u);
  y = if firstActiveIndex > 0 then expr[firstActiveIndex] else
      if use_pre_as_default then pre(y) else y_default;
  annotation (defaultComponentName="multiSwitch1", Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{300,100}}), graphics={
            Text(
              extent={{310,-25},{410,-45}},
              textString=DynamicSelect(" ", String(
                  y,
                  minimumLength=1,
                  significantDigits=0))),
            Text(
              visible=not use_pre_as_default,
              extent={{-100,-60},{300,-90}},
              textString="else: %y_default"),
            Text(
              visible=use_pre_as_default,
              extent={{-100,-50},{300,-80}},
              textString="else: pre(y)"),
            Rectangle(
              extent={{-100,-40},{300,40}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              borderPattern=BorderPattern.Raised),
            Text(
              extent={{-100,90},{300,50}},
              textString="%name",
              textColor={0,0,255}),
            Text(
              extent={{-80,15},{290,-15}},
              textString="%expr")}),
    Documentation(info="<html>
<p>
This block has a vector of Boolean input signals u[nu] and a vector of
(time varying) Integer expressions expr[nu]. The output signal y is
set to expr[i], if i is the first element in the input vector u that is true. If all input signals are
false, y is set to parameter \"y_default\" or the last value is kept, if use_pre_as_default = <strong>true</strong>.
</p>

<blockquote><pre>
// Conceptual equation (not valid Modelica)
i = 'first element of u[:] that is true';
y = <strong>if</strong> i==0 <strong>then</strong> (<strong>if</strong> use_pre_as_default <strong>then</strong> pre(y)
                                        <strong>else</strong> y_default)
    <strong>else</strong> expr[i];
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
