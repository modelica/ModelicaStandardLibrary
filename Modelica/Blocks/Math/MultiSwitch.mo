within Modelica.Blocks.Math;
block MultiSwitch
  "Set Real expression that is associated with the first active input signal"

  input Real expr[nu]=fill(0.0, nu)
    "y = if u[i] then expr[i] else y_default (time varying)"
    annotation (Dialog);
  parameter Real y_default=0.0
    "Default value of output y if all u[i] = false";

  parameter Integer nu(min=0) = 0 "Number of input connections"
    annotation (Dialog(connectorSizing=true), HideResult=true);
  parameter Integer precision(min=0) = 3
    "Number of significant digits to be shown in dynamic diagram layer for y"
    annotation (Dialog(tab="Advanced"));

  Modelica.Blocks.Interfaces.BooleanVectorInput u[nu]
    "Set y = expr[i], if u[i] = true"
    annotation (Placement(transformation(extent={{-110,30},{-90,-30}})));
  Modelica.Blocks.Interfaces.RealOutput y "Output depending on expression"
    annotation (Placement(transformation(extent={{300,-10},{320,10}})));

protected
  Integer firstActiveIndex;
initial equation
  pre(u) = fill(false, nu);
equation
  firstActiveIndex = Modelica.Math.BooleanVectors.firstTrueIndex(u);
  y = if firstActiveIndex == 0 then y_default else expr[firstActiveIndex];
  annotation (
    defaultComponentName="multiSwitch1",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{300,
            100}}), graphics={
        Rectangle(
          extent={{-100,-51},{300,50}},
          lineThickness=5.0,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
        Text(
          extent={{-86,16},{295,-17}},
          textString="%expr"),
        Text(
          extent={{310,-25},{410,-45}},
          textString=DynamicSelect(" ", String(
                y,
                minimumLength=1,
                significantDigits=precision))),
        Text(
          extent={{-100,-60},{300,-90}},
          textString="else: %y_default"),
        Text(
          extent={{-100,100},{300,60}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
This block has a vector of Boolean input signals u[nu] and a vector of
(time varying) Real expressions expr[nu]. The output signal y is
set to expr[i], if i is the first element in the input vector u that is true. If all input signals are
false, y is set to parameter \"y_default\".
</p>

<blockquote><pre>
// Conceptual equation (not valid Modelica)
i = 'first element of u[:] that is true';
y = <strong>if</strong> i==0 <strong>then</strong> y_default <strong>else</strong> expr[i];
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
<a href=\"modelica://Modelica.Blocks.Examples.RealNetwork1\">Modelica.Blocks.Examples.RealNetwork1</a>.
</p>

</html>"));
end MultiSwitch;
