within Modelica.Blocks;
package Nonlinear
  "Library of discontinuous or non-differentiable algebraic control blocks"
  import Modelica.Blocks.Interfaces;
  extends Modelica.Icons.Package;

      block Limiter "Limit the range of a signal"
        parameter Real uMax(start=1) "Upper limits of input signals";
        parameter Real uMin= -uMax "Lower limits of input signals";
        parameter Boolean strict=false "= true, if strict limits with noEvent(..)"
          annotation (Evaluate=true, choices(checkBox=true), Dialog(tab="Advanced"));
        parameter Types.LimiterHomotopy homotopyType = Modelica.Blocks.Types.LimiterHomotopy.Linear "Simplified model for homotopy-based initialization"
          annotation (Evaluate=true, Dialog(group="Initialization"));
        parameter Boolean limitsAtInit=true
          "Has no longer an effect and is only kept for backwards compatibility (the implementation uses now the homotopy operator)"
          annotation (Dialog(tab="Dummy"),Evaluate=true, choices(checkBox=true));
        extends Interfaces.SISO;
  protected
        Real simplifiedExpr "Simplified expression for homotopy-based initialization";

      equation
        assert(uMax >= uMin, "Limiter: Limits must be consistent. However, uMax (=" + String(uMax) +
                             ") < uMin (=" + String(uMin) + ")");
        simplifiedExpr = (if homotopyType == Types.LimiterHomotopy.Linear then u
                          else if homotopyType == Types.LimiterHomotopy.UpperLimit then uMax
                          else if homotopyType == Types.LimiterHomotopy.LowerLimit then uMin
                          else 0);
        if strict then
          if homotopyType == Types.LimiterHomotopy.NoHomotopy then
            y = smooth(0, noEvent(if u > uMax then uMax else if u < uMin then uMin else u));
          else
            y = homotopy(actual = smooth(0, noEvent(if u > uMax then uMax else if u < uMin then uMin else u)),
                         simplified=simplifiedExpr);
          end if;
        else
          if homotopyType == Types.LimiterHomotopy.NoHomotopy then
            y = smooth(0,if u > uMax then uMax else if u < uMin then uMin else u);
          else
            y = homotopy(actual = smooth(0,if u > uMax then uMax else if u < uMin then uMin else u),
                         simplified=simplifiedExpr);
          end if;
        end if;
        annotation (
          Documentation(info="<html>
<p>
The Limiter block passes its input signal as output signal
as long as the input is within the specified upper and lower
limits. If this is not the case, the corresponding limits are passed
as output.
</p>
<p>
The parameter <code>homotopyType</code> in the Advanced tab specifies the
simplified behaviour if homotopy-based initialization is used:
</p>
<ul>
<li><code>NoHomotopy</code>: the actual expression with limits is used</li>
<li><code>Linear</code>: a linear behaviour y = u is assumed (default option)</li>
<li><code>UpperLimit</code>: it is assumed that the output is stuck at the upper limit u = uMax</li>
<li><code>LowerLimit</code>: it is assumed that the output is stuck at the lower limit u = uMin</li>
</ul>
<p>
If it is known a priori in which region the input signal will be located, this option can help
a lot by removing one strong nonlinearity from the initialization problem.
</p>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{0,-90},{0,68}}, color={192,192,192}),
          Polygon(
            points={{0,90},{-8,68},{8,68},{0,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,-8},{68,8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-70},{-50,-70},{50,70},{80,70}}),
          Text(
            extent={{-150,-150},{150,-110}},
            textString="uMax=%uMax"),
          Line(
            visible=strict,
            points={{50,70},{80,70}},
            color={255,0,0}),
          Line(
            visible=strict,
            points={{-80,-70},{-50,-70}},
            color={255,0,0})}),
          Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{0,-60},{0,50}}, color={192,192,192}),
          Polygon(
            points={{0,60},{-5,50},{5,50},{0,60}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-60,0},{50,0}}, color={192,192,192}),
          Polygon(
            points={{60,0},{50,-5},{50,5},{60,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-50,-40},{-30,-40},{30,40},{50,40}}),
          Text(
            extent={{46,-6},{68,-18}},
            lineColor={128,128,128},
            textString="u"),
          Text(
            extent={{-30,70},{-5,50}},
            lineColor={128,128,128},
            textString="y"),
          Text(
            extent={{-58,-54},{-28,-42}},
            lineColor={128,128,128},
            textString="uMin"),
          Text(
            extent={{26,40},{66,56}},
            lineColor={128,128,128},
            textString="uMax")}));
      end Limiter;

  block VariableLimiter "Limit the range of a signal with variable limits"
    extends Interfaces.SISO;
    parameter Boolean strict=false "= true, if strict limits with noEvent(..)"
      annotation (Evaluate=true, choices(checkBox=true), Dialog(tab="Advanced"));
    parameter Types.VariableLimiterHomotopy homotopyType = Modelica.Blocks.Types.VariableLimiterHomotopy.Linear "Simplified model for homotopy-based initialization"
      annotation (Evaluate=true, Dialog(group="Initialization"));
    parameter Real ySimplified = 0 "Fixed value of output in simplified model"
      annotation (Dialog(tab="Advanced", enable=homotopyType == Modelica.Blocks.Types.VariableLimiterHomotopy.Fixed));
    parameter Boolean limitsAtInit=true
      "Has no longer an effect and is only kept for backwards compatibility (the implementation uses now the homotopy operator)"
      annotation (Dialog(tab="Dummy"),Evaluate=true, choices(checkBox=true));
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
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
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
            color={255,0,0})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
          Line(points={{0,-60},{0,50}}, color={192,192,192}),
          Polygon(
            points={{0,60},{-5,50},{5,50},{0,60}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-60,0},{50,0}}, color={192,192,192}),
          Polygon(
            points={{60,0},{50,-5},{50,5},{60,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-50,-40},{-30,-40},{30,40},{50,40}}),
          Text(
            extent={{46,-6},{68,-18}},
            lineColor={128,128,128},
            textString="input"),
          Text(
            extent={{-30,70},{-5,50}},
            lineColor={128,128,128},
            textString="output"),
          Text(
            extent={{-66,-40},{-26,-20}},
            lineColor={128,128,128},
            textString="uMin"),
          Text(
            extent={{30,20},{70,40}},
            lineColor={128,128,128},
            textString="uMax"),
          Line(points={{-100,80},{40,80},{40,40}}, color={0,0,127}),
          Line(points={{-100,-80},{-40,-80},{-40,-40}}, color={0,0,127}),
          Polygon(points={{40,40},{35,50},{45,50},{40,40}}, lineColor={0,0,127}),
          Polygon(points={{-40,-40},{-45,-50},{-35,-50},{-40,-40}}, lineColor={
                0,0,127})}));
  end VariableLimiter;

  block SlewRateLimiter "Limits the slew rate of a signal"
    extends Modelica.Blocks.Interfaces.SISO;
    import Modelica.Constants.small;
    parameter Real Rising( min= small) = 1
      "Maximum rising slew rate [+small..+inf) [1/s]";
    parameter Real Falling(max=-small) = -Rising
      "Maximum falling slew rate (-inf..-small] [1/s]";
    parameter Modelica.SIunits.Time Td(min=small) = 0.001
      "Derivative time constant";
    parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.SteadyState
      "Type of initialization (SteadyState implies y = u)"
      annotation (Evaluate=true, Dialog(group="Initialization"));
    parameter Real y_start=0 "Initial or guess value of output (= state)"
      annotation (Dialog(group="Initialization"));
    parameter Boolean strict=false "= true, if strict limits with noEvent(..)"
      annotation (Evaluate=true, choices(checkBox=true), Dialog(tab="Advanced"));
  protected
    Real val=(u-y)/Td;
  initial equation
    if initType == Modelica.Blocks.Types.Init.SteadyState then
      y = u;
    elseif initType == Modelica.Blocks.Types.Init.InitialState
        or initType == Modelica.Blocks.Types.Init.InitialOutput then
      y = y_start;
    end if;
  equation
    if strict then
      der(y) = smooth(1, (if noEvent(val<Falling) then Falling else if noEvent(val>Rising) then Rising else val));
    else
      der(y) = if val<Falling then Falling else if val>Rising then Rising else val;
    end if;
    annotation (Icon(graphics={
      Line(points={{-90,0},{68,0}}, color={192,192,192}),
      Line(points={{0,-90},{0,68}}, color={192,192,192}),
      Polygon(
        points={{0,90},{-8,68},{8,68},{0,90}},
        lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid),
      Polygon(
        points={{90,0},{68,-8},{68,8},{90,0}},
        lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid),
      Line(
        points={{-50,-70},{50,70}}),
      Line(
        visible=strict,
        points={{50,70},{-50,-70}},
        color={255,0,0})}),
  Documentation(info="<html>
<p>The <code>SlewRateLimiter</code> block limits the slew rate of its input signal in the range of <code>[Falling, Rising]</code>.</p>
<p>To ensure this for arbitrary inputs and in order to produce a differential output, the input is numerically differentiated
with derivative time constant <code>Td</code>. Smaller time constant <code>Td</code> means nearer ideal derivative.</p>
<p><em>Note: The user has to choose the derivative time constant according to the nature of the input signal.</em></p>
</html>",
  revisions="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<th>Revision</th>
<th>Date</th>
<th>Author</th>
<th>Comment</th>
</tr>
<tr>
<td>4954</td>
<td>2012-03-02</td>
<td>A. Haumer &amp; D. Winkler</td>
<td><p>Initial version based on discussion in ticket <a href=\"https://trac.modelica.org/Modelica/ticket/529\">#529</a></p></td>
</tr>
</table>
</html>"));
  end SlewRateLimiter;

      block DeadZone "Provide a region of zero output"
        parameter Real uMax(start=1) "Upper limits of dead zones";
        parameter Real uMin=-uMax "Lower limits of dead zones";
        parameter Boolean deadZoneAtInit = true
          "Has no longer an effect and is only kept for backwards compatibility (the implementation uses now the homotopy operator)"
          annotation (Dialog(tab="Dummy"),Evaluate=true, choices(checkBox=true));

        extends Interfaces.SISO;

      equation
        assert(uMax >= uMin, "DeadZone: Limits must be consistent. However, uMax (=" + String(uMax) +
                             ") < uMin (=" + String(uMin) + ")");

        y = homotopy(actual=smooth(0,if u > uMax then u - uMax else if u < uMin then u - uMin else 0), simplified=u);

        annotation (
          Documentation(info="<html>
<p>
The DeadZone block defines a region of zero output.
</p>
<p>
If the input is within uMin ... uMax, the output
is zero. Outside of this zone, the output is a linear
function of the input with a slope of 1.
</p>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{0,-90},{0,68}}, color={192,192,192}),
          Polygon(
            points={{0,90},{-8,68},{8,68},{0,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,-8},{68,8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-60},{-20,0},{20,0},{80,60}}),
          Text(
            extent={{-150,-150},{150,-110}},
            lineColor={160,160,164},
            textString="uMax=%uMax")}),
          Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{0,-60},{0,50}}, color={192,192,192}),
          Polygon(
            points={{0,60},{-5,50},{5,50},{0,60}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-76,0},{74,0}}, color={192,192,192}),
          Polygon(
            points={{84,0},{74,-5},{74,5},{84,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-81,-40},{-38,0},{40,0},{80,40}}),
          Text(
            extent={{62,-7},{88,-25}},
            lineColor={128,128,128},
            textString="u"),
          Text(
            extent={{-36,72},{-5,50}},
            lineColor={128,128,128},
            textString="y"),
          Text(
            extent={{-51,1},{-28,19}},
            lineColor={128,128,128},
            textString="uMin"),
          Text(
            extent={{27,21},{52,5}},
            lineColor={128,128,128},
            textString="uMax")}));
      end DeadZone;

  block FixedDelay "Delay block with fixed DelayTime"
    extends Modelica.Blocks.Interfaces.SISO;
    parameter Modelica.SIunits.Time delayTime(start=1)
      "Delay time of output with respect to input signal";

  equation
    y = delay(u, delayTime);
    annotation (
      Documentation(info="<html>
<p>
The Input signal is delayed by a given time instant, or more precisely:
</p>
<pre>
   y = u(time - delayTime) for time &gt; time.start + delayTime
     = u(time.start)       for time &le; time.start + delayTime
</pre>
</html>"), Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Text(
        extent={{8.0,-142.0},{8.0,-102.0}},
        textString="delayTime=%delayTime"),
      Line(
        points={{-92.0,0.0},{-80.7,34.2},{-73.5,53.1},{-67.1,66.4},{-61.4,74.6},{-55.8,79.1},{-50.2,79.8},{-44.6,76.6},{-38.9,69.7},{-33.3,59.4},{-26.9,44.1},{-18.83,21.2},{-1.9,-30.8},{5.3,-50.2},{11.7,-64.2},{17.3,-73.1},{23.0,-78.4},{28.6,-80.0},{34.2,-77.6},{39.9,-71.5},{45.5,-61.9},{51.9,-47.2},{60.0,-24.8},{68.0,0.0}},
        color={0,0,127},
        smooth=Smooth.Bezier),
      Line(
        points={{-62.0,0.0},{-50.7,34.2},{-43.5,53.1},{-37.1,66.4},{-31.4,74.6},{-25.8,79.1},{-20.2,79.8},{-14.6,76.6},{-8.9,69.7},{-3.3,59.4},{3.1,44.1},{11.17,21.2},{28.1,-30.8},{35.3,-50.2},{41.7,-64.2},{47.3,-73.1},{53.0,-78.4},{58.6,-80.0},{64.2,-77.6},{69.9,-71.5},{75.5,-61.9},{81.9,-47.2},{90.0,-24.8},{98.0,0.0}},
        color={160,160,164},
        smooth=Smooth.Bezier)}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,80},{-88,80}}, color={192,192,192}),
          Line(points={{-80,-80},{-88,-80}}, color={192,192,192}),
          Line(points={{-80,-88},{-80,86}}, color={192,192,192}),
          Text(
            extent={{-75,98},{-46,78}},
            lineColor={0,0,255},
            textString="output"),
          Polygon(
            points={{-80,96},{-86,80},{-74,80},{-80,96}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-100,0},{84,0}}, color={192,192,192}),
          Polygon(
            points={{100,0},{84,6},{84,-6},{100,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,
                74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,
                59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7,
                -64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},
                {57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, color={0,0,127},
                smooth=Smooth.Bezier),
          Text(
            extent={{-24,98},{-2,78}},
            textString="input"),
          Line(points={{-64,0},{-52.7,34.2},{-45.5,53.1},{-39.1,66.4},{-33.4,
                74.6},{-27.8,79.1},{-22.2,79.8},{-16.6,76.6},{-10.9,69.7},{-5.3,
                59.4},{1.1,44.1},{9.17,21.2},{26.1,-30.8},{33.3,-50.2},{39.7,-64.2},
                {45.3,-73.1},{51,-78.4},{56.6,-80},{62.2,-77.6},{67.9,-71.5},{
                73.5,-61.9},{79.9,-47.2},{88,-24.8},{96,0}}, smooth=Smooth.Bezier),
          Text(
            extent={{67,22},{96,6}},
            lineColor={160,160,164},
            textString="time"),
          Line(points={{-64,-30},{-64,0}}, color={192,192,192}),
          Text(
            extent={{-58,-42},{-58,-32}},
            textString="delayTime",
            lineColor={0,0,255}),
          Line(points={{-94,-26},{-80,-26}}, color={192,192,192}),
          Line(points={{-64,-26},{-50,-26}}, color={192,192,192}),
          Polygon(
            points={{-80,-26},{-88,-24},{-88,-28},{-80,-26}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-56,-24},{-64,-26},{-56,-28},{-56,-24}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid)}));
  end FixedDelay;

  block PadeDelay
    "Pade approximation of delay block with fixed delayTime (use balance=true; this is not the default to be backwards compatible)"
    extends Modelica.Blocks.Interfaces.SISO;
    parameter Modelica.SIunits.Time delayTime(start=1)
      "Delay time of output with respect to input signal";
    parameter Integer n(min=1) = 1 "Order of Pade delay";
    parameter Integer m(min=1,max=n) = n
      "Order of numerator (usually m=n, or m=n-1)";
    parameter Boolean balance=false
      "= true, if state space system is balanced (highly recommended), otherwise textbook version"
      annotation(choices(checkBox=true));
    final output Real x[n]
      "State of transfer function from controller canonical form (balance=false), or balanced controller canonical form (balance=true)";

  protected
    parameter Real a1[n]( each fixed=false) "First row of A";
    parameter Real b11(        fixed=false) "= B[1,1]";
    parameter Real c[n](  each fixed=false) "C row matrix";
    parameter Real d(          fixed=false) "D matrix";
    parameter Real s[n-1](each fixed=false) "State scaling";

  function padeCoefficients2
    extends Modelica.Icons.Function;
    input Real T "delay time";
    input Integer n "order of denominator";
    input Integer m "order of numerator";
    input Boolean balance=false;
    output Real a1[n] "First row of A";
    output Real b11 "= B[1,1]";
    output Real c[n] "C row matrix";
    output Real d "D matrix";
    output Real s[n-1] "Scaling such that x[i] = s[i-1]*x[i-1], i > 1";
    protected
    Real b[m + 1] "numerator coefficients of transfer function";
    Real a[n + 1] "denominator coefficients of transfer function";
    Real nm;
    Real bb[n + 1];
    Real A[n,n];
    Real B[n,1];
    Real C[1,n];
    Real A2[n,n] = zeros(n,n);
    Real B2[n,1] = zeros(n,1);
    Real C2[1,n] "C matrix";
    Integer nb = m+1;
    Integer na = n+1;
    Real sx[n];
  algorithm
    a[1] := 1;
    b[1] := 1;
    nm := n + m;

    for i in 1:n loop
      a[i + 1] := a[i]*(T*((n - i + 1)/(nm - i + 1))/i);
      if i <= m then
        b[i + 1] := -b[i]*(T*((m - i + 1)/(nm - i + 1))/i);
      end if;
    end for;

    b  := b[m + 1:-1:1];
    a  := a[n + 1:-1:1];
    bb := vector([zeros(n-m, 1); b]);
    d  := bb[1]/a[1];

    if balance then
      A2[1,:] := -a[2:na]/a[1];
      B2[1,1] := 1/a[1];
      for i in 1:n-1 loop
         A2[i+1,i] :=1;
      end for;
      C2[1,:] := bb[2:na] - d*a[2:na];
      (sx,A,B,C) :=Modelica.Math.Matrices.balanceABC(A2,B2,C2);
      for i in 1:n-1 loop
         s[i] := sx[i]/sx[i+1];
      end for;
      a1  := A[1,:];
      b11 := B[1,1];
      c   := vector(C);
    else
       s  := ones(n-1);
      a1  := -a[2:na]/a[1];
      b11 :=  1/a[1];
      c   := bb[2:na] - d*a[2:na];
    end if;
  end padeCoefficients2;

  equation
    der(x[1]) = a1*x + b11*u;
    if n > 1 then
       der(x[2:n]) = s.*x[1:n-1];
    end if;
    y = c*x + d*u;

  initial equation
    (a1,b11,c,d,s) = padeCoefficients2(delayTime, n, m, balance);

    if balance then
       der(x) = zeros(n);
    else
       // In order to be backwards compatible
       x[n] = u;
    end if;
    annotation (
      Documentation(info="<html>
<p>
The Input signal is delayed by a given time instant, or more precisely:
</p>
<pre>
   y = u(time - delayTime) for time &gt; time.start + delayTime
     = u(time.start)       for time &le; time.start + delayTime
</pre>
<p>
The delay is approximated by a Pade approximation, i.e., by
a transfer function
</p>
<pre>
           b[1]*s^m + b[2]*s^[m-1] + ... + b[m+1]
   y(s) = --------------------------------------------- * u(s)
           a[1]*s^n + a[2]*s^[n-1] + ... + a[n+1]
</pre>
<p>
where the coefficients b[:] and a[:] are calculated such that the
coefficients of the Taylor expansion of the delay exp(-T*s) around s=0
are identical up to order n+m.
</p>
<p>
The main advantage of this approach is that the delay is
approximated by a linear differential equation system, which
is continuous and continuously differentiable. For example, it
is uncritical to linearize a system containing a Pade-approximated
delay.
</p>
<p>
The standard text book version uses order \"m=n\", which is
also the default setting of this block. The setting
\"m=n-1\" may yield a better approximation in certain cases.
</p>

<p>
It is strongly recommended to always set parameter <strong>balance</strong> = true,
in order to arrive at a much better reliable numerical computation.
This is not the default, in order to be backwards compatible, so you have
to explicitly set it. Besides better numerics, also all states are initialized
with <strong>balance</strong> = true (in steady-state, so der(x)=0). Longer explanation:
</p>

<p>
By default the transfer function of the Pade approximation is implemented
in controller canonical form. This results in coefficients of the A-matrix in
the order of 1 up to the order of O(1/delayTime)^n. For already modest values
of delayTime and n, this gives largely varying coefficients (for example delayTime=0.001 and n=4
results in coefficients between 1 and 1e12). In turn, this results
in a large norm of the system matrix [A,B;C,D] and therefore in unreliable
numerical computations. When setting parameter <strong>balance</strong> = true, a state
transformation is performed that considerably reduces the norm of the system matrix.
This is performed without introducing round-off errors. For details see
function <a href=\"modelica://Modelica.Math.Matrices.balanceABC\">balanceABC</a>.
As a result, both the simulation of the PadeDelay block, and especially
its linearization becomes more reliable.
</p>

<h5>Literature:</h5>
<p>Otto Foellinger: Regelungstechnik, 8. Auflage,
chapter 11.9, page 412-414, Huethig Verlag Heidelberg, 1994
</p>
</html>",   revisions="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<th>Date</th>
<th>Author</th>
<th>Comment</th>
</tr>
<tr>
<td>2015-01-05</td>
<td>Martin Otter (DLR-SR)</td>
<td>Introduced parameter balance=true and a new implementation
 of the PadeDelay block with an optional, more reliable numerics</td>
</tr>
</table>
</html>"), Icon(
      coordinateSystem(preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}),
        graphics={
      Text(extent={{8.0,-142.0},{8.0,-102.0}},
        textString="delayTime=%delayTime"),
      Line(points={{-94.0,0.0},{-82.7,34.2},{-75.5,53.1},{-69.1,66.4},{-63.4,74.6},{-57.8,79.1},{-52.2,79.8},{-46.6,76.6},{-40.9,69.7},{-35.3,59.4},{-28.9,44.1},{-20.83,21.2},{-3.9,-30.8},{3.3,-50.2},{9.7,-64.2},{15.3,-73.1},{21.0,-78.4},{26.6,-80.0},{32.2,-77.6},{37.9,-71.5},{43.5,-61.9},{49.9,-47.2},{58.0,-24.8},{66.0,0.0}},
        color={0,0,127},
        smooth=Smooth.Bezier),
      Line(points={{-72.0,0.0},{-60.7,34.2},{-53.5,53.1},{-47.1,66.4},{-41.4,74.6},{-35.8,79.1},{-30.2,79.8},{-24.6,76.6},{-18.9,69.7},{-13.3,59.4},{-6.9,44.1},{1.17,21.2},{18.1,-30.8},{25.3,-50.2},{31.7,-64.2},{37.3,-73.1},{43.0,-78.4},{48.6,-80.0},{54.2,-77.6},{59.9,-71.5},{65.5,-61.9},{71.9,-47.2},{80.0,-24.8},{88.0,0.0}},
        color={160,160,164},
        smooth=Smooth.Bezier),
      Text(lineColor={160,160,164},
        extent={{-10.0,38.0},{100.0,100.0}},
        textString="m=%m"),
      Text(lineColor={160,160,164},
        extent={{-98.0,-96.0},{6.0,-34.0}},
        textString="n=%n"),
      Text(visible=balance, lineColor={160,160,164},
        extent={{-96,-20},{98,22}},
            textString="balanced")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,80},{-88,80}}, color={192,192,192}),
          Line(points={{-80,-80},{-88,-80}}, color={192,192,192}),
          Line(points={{-80,-88},{-80,86}}, color={192,192,192}),
          Text(
            extent={{-75,98},{-46,78}},
            lineColor={0,0,255},
            textString="output"),
          Polygon(
            points={{-80,96},{-86,80},{-74,80},{-80,96}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-100,0},{84,0}}, color={192,192,192}),
          Polygon(
            points={{100,0},{84,6},{84,-6},{100,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,
                74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,
                59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7,
                -64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},
                {57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, color={0,0,127},
                smooth=Smooth.Bezier),
          Text(
            extent={{-24,98},{-2,78}},
            textString="input"),
          Line(points={{-64,0},{-52.7,34.2},{-45.5,53.1},{-39.1,66.4},{-33.4,
                74.6},{-27.8,79.1},{-22.2,79.8},{-16.6,76.6},{-10.9,69.7},{-5.3,
                59.4},{1.1,44.1},{9.17,21.2},{26.1,-30.8},{33.3,-50.2},{39.7,-64.2},
                {45.3,-73.1},{51,-78.4},{56.6,-80},{62.2,-77.6},{67.9,-71.5},{
                73.5,-61.9},{79.9,-47.2},{88,-24.8},{96,0}}, smooth=Smooth.Bezier),
          Text(
            extent={{67,22},{96,6}},
            lineColor={160,160,164},
            textString="time"),
          Line(points={{-64,-30},{-64,0}}, color={192,192,192}),
          Text(
            extent={{-58,-42},{-58,-32}},
            textString="delayTime",
            lineColor={0,0,255}),
          Line(points={{-94,-26},{-80,-26}}, color={192,192,192}),
          Line(points={{-64,-26},{-50,-26}}, color={192,192,192}),
          Polygon(
            points={{-80,-26},{-88,-24},{-88,-28},{-80,-26}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-56,-24},{-64,-26},{-56,-28},{-56,-24}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid)}));
  end PadeDelay;

  block VariableDelay "Delay block with variable DelayTime"
    extends Modelica.Blocks.Interfaces.SISO;
    parameter Modelica.SIunits.Duration delayMax(min=0, start=1) "Maximum delay time";

    Modelica.Blocks.Interfaces.RealInput delayTime annotation (Placement(
          transformation(extent={{-140,-80},{-100,-40}})));
  equation
    y = delay(u, delayTime, delayMax);
    annotation (
      Documentation(info="<html>
<p>
The Input signal is delayed by a given time instant, or more precisely:
</p>
<pre>
   y = u(time - delayTime) for time &gt; time.start + delayTime
     = u(time.start)       for time &le; time.start + delayTime
</pre>
<p>
where delayTime is an additional input signal which must follow
the following relationship:
</p>
<pre>  0 &le; delayTime &le; delayMax
</pre>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
      Text(extent={{-100.0,-148.0},{100.0,-108.0}},
        textString="delayMax=%delayMax"),
      Line(points={{-92.0,0.0},{-80.7,34.2},{-73.5,53.1},{-67.1,66.4},{-61.4,74.6},{-55.8,79.1},{-50.2,79.8},{-44.6,76.6},{-38.9,69.7},{-33.3,59.4},{-26.9,44.1},{-18.83,21.2},{-1.9,-30.8},{5.3,-50.2},{11.7,-64.2},{17.3,-73.1},{23.0,-78.4},{28.6,-80.0},{34.2,-77.6},{39.9,-71.5},{45.5,-61.9},{51.9,-47.2},{60.0,-24.8},{68.0,0.0}},
        color={0,0,127},
        smooth=Smooth.Bezier),
      Line(points={{-64.0,0.0},{-52.7,34.2},{-45.5,53.1},{-39.1,66.4},{-33.4,74.6},{-27.8,79.1},{-22.2,79.8},{-16.6,76.6},{-10.9,69.7},{-5.3,59.4},{1.1,44.1},{9.17,21.2},{26.1,-30.8},{33.3,-50.2},{39.7,-64.2},{45.3,-73.1},{51.0,-78.4},{56.6,-80.0},{62.2,-77.6},{67.9,-71.5},{73.5,-61.9},{79.9,-47.2},{88.0,-24.8},{96.0,0.0}},
        smooth=Smooth.Bezier),
      Polygon(fillPattern=FillPattern.Solid,
        lineColor={0,0,127},
        fillColor={0,0,127},
        points={{6.0,4.0},{-14.0,-2.0},{-6.0,-12.0},{6.0,4.0}}),
      Line(color={0,0,127},
        points={{-100.0,-60.0},{-76.0,-60.0},{-8.0,-6.0}})}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
      Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Polygon(
        points={{-80,96},{-86,80},{-74,80},{-80,96}},
        lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid),
      Text(
        extent={{-69,98},{-40,78}},
        lineColor={0,0,255},
        textString="output"),
      Line(points={{-64,0},{-52.7,34.2},{-45.5,53.1},{-39.1,66.4},{-33.4,
            74.6},{-27.8,79.1},{-22.2,79.8},{-16.6,76.6},{-10.9,69.7},{-5.3,
            59.4},{1.1,44.1},{9.17,21.2},{26.1,-30.8},{33.3,-50.2},{39.7,-64.2},
            {45.3,-73.1},{51,-78.4},{56.6,-80},{62.2,-77.6},{67.9,-71.5},{
            73.5,-61.9},{79.9,-47.2},{88,-24.8},{96,0}}, smooth=Smooth.Bezier),
      Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,
            74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,
            59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7,
            -64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},
            {57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, color={0,0,127},
            smooth=Smooth.Bezier),
      Line(points={{-100,0},{84,0}}, color={192,192,192}),
      Polygon(
        points={{100,0},{84,6},{84,-6},{100,0}},
        lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid),
      Text(
        extent={{67,22},{96,6}},
        lineColor={160,160,164},
        textString="time"),
      Text(
        extent={{-58,-42},{-58,-32}},
        textString="delayTime",
        lineColor={0,0,255}),
      Line(points={{-80,-88},{-80,86}}, color={192,192,192}),
      Text(
        extent={{-24,98},{-2,78}},
        textString="input"),
      Polygon(
        points={{-80,-26},{-88,-24},{-88,-28},{-80,-26}},
        lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid),
      Polygon(
        points={{-56,-24},{-64,-26},{-56,-28},{-56,-24}},
        lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid),
      Line(points={{-64,-26},{-50,-26}}, color={192,192,192}),
      Line(points={{-94,-26},{-80,-26}}, color={192,192,192}),
      Line(
        points={{-100,-60},{-70,-60},{-64,-44}},
        arrow={Arrow.None,Arrow.Filled},
        color={0,0,127}),
      Line(points={{-64,-30},{-64,0}}, color={192,192,192})}));
  end VariableDelay;

      annotation (
        Documentation(info="<html>
<p>
This package contains <strong>discontinuous</strong> and
<strong>non-differentiable, algebraic</strong> input/output blocks.
</p>
</html>", revisions="<html>
<ul>
<li><em>October 21, 2002</em>
       by Christian Schweiger:<br>
       New block VariableLimiter added.</li>
<li><em>August 22, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.
</li>
</ul>
</html>"), Icon(graphics={Line(points={{-80,-66},{-26,-66},{28,52},{88,52}},
            color={95,95,95})}));
end Nonlinear;
