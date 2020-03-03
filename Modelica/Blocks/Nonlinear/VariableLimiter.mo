within Modelica.Blocks.Nonlinear;
block VariableLimiter "Limit the range of a signal with variable limits"
  extends Interfaces.SISO;
  parameter Boolean strict=false "= true, if strict limits with noEvent(..)"
    annotation (Evaluate=true, choices(checkBox=true), Dialog(tab="Advanced"));
  parameter Types.VariableLimiterHomotopy homotopyType = Modelica.Blocks.Types.VariableLimiterHomotopy.Linear "Simplified model for homotopy-based initialization"
    annotation (Evaluate=true, Dialog(group="Initialization"));
  parameter Real ySimplified = 0 "Fixed value of output in simplified model"
    annotation (Dialog(tab="Advanced", enable=homotopyType == Modelica.Blocks.Types.VariableLimiterHomotopy.Fixed));
  Interfaces.RealInput limit1
    "Connector of Real input signal used as maximum of input u"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Interfaces.RealInput limit2
    "Connector of Real input signal used as minimum of input u"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
protected
  Real simplifiedExpr "Simplified expression for homotopy-based initialization";
equation
  assert(limit1 >= limit2, "Input signals are not consistent: limit1 < limit2");
  simplifiedExpr = (if homotopyType == Types.VariableLimiterHomotopy.Linear then u
                    else if homotopyType == Types.VariableLimiterHomotopy.Fixed then ySimplified
                    else 0);
  if strict then
    if homotopyType == Types.VariableLimiterHomotopy.NoHomotopy then
      y = smooth(0, noEvent(if u > limit1 then limit1 else if u < limit2 then limit2 else u));
    else
      y = homotopy(actual = smooth(0, noEvent(if u > limit1 then limit1 else if u < limit2 then limit2 else u)),
                   simplified=simplifiedExpr);
    end if;
  else
    if homotopyType == Types.VariableLimiterHomotopy.NoHomotopy then
      y = smooth(0,if u > limit1 then limit1 else if u < limit2 then limit2 else u);
    else
      y = homotopy(actual = smooth(0,if u > limit1 then limit1 else if u < limit2 then limit2 else u),
                   simplified=simplifiedExpr);
    end if;
  end if;

  annotation (
    Documentation(info="<html>
<p>
The Limiter block passes its input signal as output signal
as long as the input is within the upper and lower
limits specified by the two additional inputs limit1 and
limit2. If this is not the case, the corresponding limit
is passed as output.
</p>
<p>
The parameter <code>homotopyType</code> in the Advanced tab specifies the
simplified behaviour if homotopy-based initialization is used:
</p>
<ul>
<li><code>NoHomotopy</code>: the actual expression with limits is used</li>
<li><code>Linear</code>: a linear behaviour y = u is assumed (default option)</li>
<li><code>Fixed</code>: it is assumed that the output is fixed at the value <code>ySimplified</code></li>
</ul>
<p>
If it is known a priori in which region the input signal will be located, this option can help
a lot by removing one strong nonlinearity from the initialization problem.
</p>
</html>"),
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{0,-90},{0,68}}, color={192,192,192}),
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,-8},{68,8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-70},{-50,-70},{50,70},{80,70}}),
        Line(points={{-100,80},{66,80},{66,70}}, color={0,0,127}),
        Line(points={{-100,-80},{-64,-80},{-64,-70}}, color={0,0,127}),
        Polygon(points={{-64,-70},{-66,-74},{-62,-74},{-64,-70}}, lineColor={
              0,0,127}),
        Polygon(points={{66,70},{64,74},{68,74},{66,70}}, lineColor={0,0,127}),
        Polygon(
          points={{0,90},{-8,68},{8,68},{0,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          visible=strict,
          points={{50,70},{80,70}},
          color={255,0,0}),
        Line(
          visible=strict,
          points={{-80,-70},{-50,-70}},
          color={255,0,0})}));
end VariableLimiter;
