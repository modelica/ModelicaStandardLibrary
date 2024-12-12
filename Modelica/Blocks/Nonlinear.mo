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
            color={255,0,0})}));
      end Limiter;

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
            color={255,0,0})}));
  end VariableLimiter;

  block SlewRateLimiter "Limits the slew rate of a signal"
    extends Modelica.Blocks.Interfaces.SISO;
    import Modelica.Constants.small;
    parameter Real Rising( min= small) = 1
      "Maximum rising slew rate [+small..+inf) [1/s]";
    parameter Real Falling(max=-small) = -Rising
      "Maximum falling slew rate (-inf..-small] [1/s]";
    parameter SI.Time Td(min=small) = 0.001
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
<td><p>Initial version based on discussion in ticket <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/529\">#529</a></p></td>
</tr>
</table>
</html>"));
  end SlewRateLimiter;

  block ZeroProtection "Limit the input to a minimum value around zero"

    // Base model
    extends Modelica.Blocks.Interfaces.SISO;

    // Parameter
    parameter Real threshold(min = 0)
      "Smallest value around zero, which the output can have";

  equation

    y =
      if noEvent(u >= threshold or u <= -threshold) then
        u
      elseif noEvent(u >= 0) then
        threshold
      else
        -threshold;

    annotation (
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
      Icon(
        coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Line(points = {{-78, 0}, {78, 0}}, color = {192, 192, 192}),
          Line(points = {{0, -80}, {0, 68}}, color = {192, 192, 192}),
          Text(
            extent = {{62, 32}, {80, 8}},
            pattern = LinePattern.None,
            lineColor = {0, 0, 0},
            textString = "u"),
          Text(
            extent = {{-24, 84}, {-8, 64}},
            pattern = LinePattern.None,
            lineColor = {0, 0, 0},
            textString = "y"),
          Text(
            extent = {{-82, 22}, {-12, 6}},
            pattern = LinePattern.None,
            lineColor = {0, 0, 0},
            textString = "%threshold",
            horizontalAlignment = TextAlignment.Right),
          Line(points = {{-4, 10}, {2, 10}}, color = {192, 192, 192}),
          Line(
            points = {{-2, -10}, {4, -10}},
            color = {192, 192, 192}),
          Line(
            points = {{60, 60}, {10, 10}, {0, 10}},
            color = {0, 0, 0}),
          Line(
            points = {{-60, -60}, {-10, -10}, {0, -10}},
            color = {0, 0, 0}),
          Polygon(
            points = {{0, 80}, {-6, 64}, {6, 64}, {0, 80}},
            lineColor = {192, 192, 192},
            fillColor = {192, 192, 192},
            fillPattern = FillPattern.Solid),
          Polygon(
            points = {{0, 8}, {-6, -8}, {6, -8}, {0, 8}},
            lineColor = {192, 192, 192},
            fillColor = {192, 192, 192},
            fillPattern = FillPattern.Solid,
            origin = {72, 0},
            rotation = 270),
          Text(
            extent = {{8, -8}, {78, -24}},
            pattern = LinePattern.None,
            lineColor = {0, 0, 0},
            horizontalAlignment = TextAlignment.Left,
            textString = "-%threshold")}),
      Documentation(
        info = "<html>
<p>This block avoids a value of zero and gives +/- <code>threshold</code> as output instead.</p>
</html>"));

  end ZeroProtection;

      block DeadZone "Provide a region of zero output"
        parameter Real uMax(start=1) "Upper limits of dead zones";
        parameter Real uMin=-uMax "Lower limits of dead zones";
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
            textColor={160,160,164},
            textString="uMax=%uMax")}));
      end DeadZone;

  block LinearShifter
    "Shifts y between y1 and y2 linearly depending on x"

    // Base model
    extends Modelica.Blocks.Interfaces.SISO;

    // Parameters
    parameter Real u1(start = -1)
      "Lower boundary of input u, switching from constant value y1 to linear interpolation";
    parameter Real u2(start = 1)
      "Upper boundary of input u, switching from linear interpolation to constant value y2";
    parameter Real y1(start = -1)
      "Minimum value for y";
    parameter Real y2(start = 1)
      "Maximum value for y";

    parameter Boolean strict = false
      "= true, if strict limits with noEvent(..)"
      annotation (Evaluate = true, choices(checkBox = true), Dialog(group = "Discontinuities"));

    final parameter Real k = (y2 - y1) / (u2 - u1)
      "Slope of the resulting line equation";
    final parameter Real y0 = if k > 0 then -k * u1 + y1 else -k * u2 + y2
      "Offset of the resulting line equation";

    // Components
    Modelica.Blocks.Math.Gain gradient(k = k)
      annotation (Placement(transformation(extent = {{-60, -10}, {-40, 10}})));
    Modelica.Blocks.Math.Add add
      annotation (Placement(transformation(extent = {{0, -10}, {20, 10}})));
    Modelica.Blocks.Sources.Constant offset(k = y0)
      annotation (Placement(transformation(extent = {{-60, 30}, {-40, 50}})));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMax = max(y1, y2), uMin = min(y1, y2), strict = strict)
      annotation (Placement(transformation(extent = {{40, -10}, {60, 10}})));

  initial equation

    assert(u1 < u2, "Invalid parameters for " + getInstanceName() + ": Lower point has to be smaller than upper point on the abscissa.");

  equation

    connect(gradient.u, u)
      annotation (Line(points = {{-62, 0}, {-120, 0}}, color = {0, 0, 127}));
    connect(add.u2, gradient.y)
      annotation (Line(points = {{-2, -6}, {-30, -6}, {-30, 0}, {-39, 0}}, color = {0, 0, 127}));
    connect(offset.y, add.u1)
      annotation (Line(points = {{-39, 40}, {-20, 40}, {-20, 6}, {-2, 6}}, color = {0, 0, 127}));
    connect(limiter.u, add.y)
      annotation (Line(points = {{38, 0}, {21, 0}}, color = {0, 0, 127}));
    connect(limiter.y, y)
      annotation (Line(points = {{61, 0}, {110, 0}}, color = {0, 0, 127}));

    annotation (
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
      Documentation(
        info = "<html>
<p>The output <code>y</code> is shifted in between the parameters <code>y1</code> and <code>y2</code> depending on the
    input <code>u</code>. </p>
<p>If the input <code>u&le;u1</code> then <code>y=y1</code>, if <code>u&ge;u2</code> then <code>y=y2</code>. For
    values of <code>u</code> between <code>u1</code> and <code>u2</code> the output <code>y</code> is interpolated
    linearly between <code>y1</code> and <code>y2</code>.</p>
<hr>
<h4>Application</h4>
<p>This block can be useful e.g. to limit the torque (y) of an electric machine if speed (u) gets to high. Usual
    parameters in such a case could be:</p>
<ul>
    <li>Speed at which limiting starts = u1 = 1000rpm</li>
    <li>Relative possible torque if speed is below u1: y2=1</li>
    <li>Speed at which no torque shall be available: u2 = 1050rpm</li>
    <li>Relative possible torque if speed is above u2: y2 = 0</li>
</ul>
</html>"),
      Icon(
        coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Line(points = {{0, -66}, {0, 84}}, color = {192, 192, 192}),
          Line(points = {{-84, 0}, {74, 0}}, color = {192, 192, 192}),
          Polygon(
            points = {{90, 0}, {74, 6}, {74, -6}, {90, 0}},
            lineColor = {192, 192, 192},
            fillColor = {192, 192, 192},
            fillPattern = FillPattern.Solid),
          Polygon(
            points = {{0, 90}, {-6, 74}, {6, 74}, {0, 90}},
            lineColor = {192, 192, 192},
            fillColor = {192, 192, 192},
            fillPattern = FillPattern.Solid),
          Line(points = {{-76, -60}, {-32, -60}, {32, 64}, {78, 64}}, color = {0, 86, 134}),
          Line(points = {{-32, -4}, {-32, 4}}, color = {192, 192, 192}),
          Line(points = {{32, -8}, {32, 64}}, color = {192, 192, 192}),
          Text(
            extent = {{-30, 76}, {-4, 50}},
            textColor = {0, 86, 134},
            textString = "%y2"),
          Text(
            extent = {{6, -48}, {32, -74}},
            textColor = {0, 86, 134},
            textString = "%y1"),
          Text(
            extent = {{18, -6}, {44, -32}},
            textColor = {0, 86, 134},
            textString = "%u2"),
          Text(
            extent = {{-44, -6}, {-20, -32}},
            textColor = {0, 86, 134},
            textString = "%u1"),
          Line(points = {{-4, 64}, {32, 64}}, color = {192, 192, 192}),
          Line(points = {{-32, -60}, {4, -60}}, color = {192, 192, 192}),
          Line(points = {{-32, -60}, {-32, -36}}, color = {192, 192, 192})}));

  end LinearShifter;

  model SinSquareShifter
    "Shifts y between y1 and y2 depending on x"

    import Modelica.Constants.pi;

    // Base model
    extends Modelica.Blocks.Interfaces.SISO;

    // Parameters
    parameter Real u1(start = 1)
      "Lower boundary of input u, switching from constant value y1 to sin^2 interpolation";
    parameter Real u2(start = 2)
      "Upper boundary of input u, switching from sin^2 interpolation to constant value y2";
    parameter Real y1(start = 0)
      "Minimum value for y";
    parameter Real y2(start = 1)
      "Maximum value for y";

  equation

    if noEvent(u <= u1) then
      y = y1;
    elseif noEvent(u > u1 and u < u2) then
      y = y1 + (y2 - y1) * sin((u - u1) / (u2 - u1) * pi / 2) ^ 2;
    else
      y = y2;
    end if;

    annotation (
      Icon(
        graphics = {
          Line(points = {{0, -66}, {0, 84}}, color = {192, 192, 192}),
          Line(points = {{-84, 0}, {74, 0}}, color = {192, 192, 192}),
          Polygon(
            points = {{90, 0}, {74, 6}, {74, -6}, {90, 0}},
            lineColor = {192, 192, 192},
            fillColor = {192, 192, 192},
            fillPattern = FillPattern.Solid),
          Polygon(
            points = {{0, 90}, {-6, 74}, {6, 74}, {0, 90}},
            lineColor = {192, 192, 192},
            fillColor = {192, 192, 192},
            fillPattern = FillPattern.Solid),
          Line(
            points = {{-76, -60}, {-18, -60}, {20, 64}, {78, 64}},
            color = {0, 86, 134},
            smooth = Smooth.Bezier),
          Line(points = {{-46, -4}, {-46, 4}}, color = {192, 192, 192}),
          Line(points = {{48, -8}, {48, 64}}, color = {192, 192, 192}),
          Text(
            extent = {{-30, 76}, {-4, 50}},
            textColor = {0, 86, 134},
            textString = "%y2"),
          Text(
            extent = {{6, -48}, {32, -74}},
            textColor = {0, 86, 134},
            textString = "%y1"),
          Text(
            extent = {{34, -6}, {60, -32}},
            textColor = {0, 86, 134},
            textString = "%u2"),
          Text(
            extent = {{-58, -6}, {-34, -32}},
            textColor = {0, 86, 134},
            textString = "%u1"),
          Line(points = {{-4, 64}, {48, 64}}, color = {192, 192, 192}),
          Line(points = {{-46, -60}, {4, -60}}, color = {192, 192, 192}),
          Line(points = {{-46, -60}, {-46, -36}}, color = {192, 192, 192})}),
      Documentation(
        info = "<html>
<p>The output <code>y</code> is shifted in between the parameters <code>y1</code> and <code>y2</code> depending on the
    input <code>u</code>. </p>
<p>If the input <code>u&le;u1</code> then <code>y=y1</code>, if <code>u&ge;u2</code> then <code>y=y2</code>. For
    values of <code>u</code> between <code>u1</code> and <code>u2</code> the output <code>y</code> is interpolated
    using a sin&#178; function between <code>y1</code> and <code>y2</code>.</p>
<hr>
<h4>Application</h4>
<p>The block has the same applications as the <a href=\"modelica://DymolaModels.Blocks.NonLinear.LinearShifter\">LinearShifter</a>
    with potentially improved stability due to the smoother behavior of the output.
</p>
</html>"));

  end SinSquareShifter;

  block VariableLinearShifter
    "Shifting between u1 and u2 depending on x"

    // Base model
    extends Modelica.Blocks.Interfaces.SISO;

    // Components
    Modelica.Blocks.Interfaces.RealInput u1
      annotation (Placement(transformation(extent = {{-140, 40}, {-100, 80}})));
    Modelica.Blocks.Interfaces.RealInput u2
      annotation (Placement(transformation(extent = {{-140, -80}, {-100, -40}})));
    Modelica.Blocks.Math.Product resultFromFirstInput
      annotation (Placement(transformation(extent = {{20, 30}, {40, 50}})));
    Modelica.Blocks.Math.Product resultFromSecondInput
      annotation (Placement(transformation(extent = {{20, -50}, {40, -30}})));
    Modelica.Blocks.Math.Add valueForInversion(k1 = -1)
      annotation (Placement(transformation(extent = {{-20, -34}, {0, -14}})));
    Modelica.Blocks.Sources.Constant negationValue(k = 1)
      annotation (Placement(transformation(extent = {{-60, -40}, {-40, -20}})));
    Modelica.Blocks.Nonlinear.Limiter limitedShiftingFactor(
      uMax = 1,
      uMin = 0,
      strict = true)
      annotation (Placement(transformation(extent = {{-80, -10}, {-60, 10}})));
    Modelica.Blocks.Math.Add sumOfWheightedInputs
      annotation (Placement(transformation(extent = {{60, -10}, {80, 10}})));

  equation

    connect(u1, resultFromFirstInput.u1)
      annotation (
        Line(
          points = {{-120, 60}, {-30, 60}, {-30, 46}, {18, 46}},
          color = {0, 0, 127},
          smooth = Smooth.None));
    connect(negationValue.y, valueForInversion.u2)
      annotation (
        Line(
          points = {{-39, -30}, {-22, -30}},
          color = {0, 0, 127},
          smooth = Smooth.None));
    connect(limitedShiftingFactor.u, u)
      annotation (
        Line(
          points = {{-82, 0}, {-120, 0}},
          color = {0, 0, 127},
          smooth = Smooth.None));
    connect(limitedShiftingFactor.y, resultFromFirstInput.u2)
      annotation (
        Line(
          points = {{-59, 0}, {-30, 0}, {-30, 34}, {18, 34}},
          color = {0, 0, 127},
          smooth = Smooth.None));
    connect(valueForInversion.u1, resultFromFirstInput.u2)
      annotation (
        Line(
          points = {{-22, -18}, {-30, -18}, {-30, 34}, {18, 34}},
          color = {0, 0, 127},
          smooth = Smooth.None));
    connect(valueForInversion.y, resultFromSecondInput.u1)
      annotation (
        Line(
          points = {{1, -24}, {8, -24}, {8, -34}, {18, -34}},
          color = {0, 0, 127},
          smooth = Smooth.None));
    connect(u2, resultFromSecondInput.u2)
      annotation (
        Line(
          points = {{-120, -60}, {8, -60}, {8, -46}, {18, -46}},
          color = {0, 0, 127},
          smooth = Smooth.None));
    connect(sumOfWheightedInputs.u1, resultFromFirstInput.y)
      annotation (
        Line(
          points = {{58, 6}, {50, 6}, {50, 40}, {41, 40}},
          color = {0, 0, 127},
          smooth = Smooth.None));
    connect(sumOfWheightedInputs.u2, resultFromSecondInput.y)
      annotation (
        Line(
          points = {{58, -6}, {50, -6}, {50, -40}, {41, -40}},
          color = {0, 0, 127},
          smooth = Smooth.None));
    connect(sumOfWheightedInputs.y, y)
      annotation (
        Line(
          points = {{81, 0}, {110, 0}},
          color = {0, 0, 127},
          smooth = Smooth.None));

    annotation (
      Diagram(
        coordinateSystem(
          preserveAspectRatio = false,
          extent = {
            {-100, -100},
            {100, 100}})),
      Documentation(
        info = "<html>
<p>The output <code>y</code> is shifted in between <code>u1</code> and <code>u2</code> depending on the input <code>u</code>.
</p>
<p>If the input <code>u&le;0</code> then <code>y=u2</code>, if <code>u&ge;1</code> then
    <code>y=u1</code>. For values of <code>u</code> between 0 and 1 the output <code>y</code> is interpolated
    linearly between <code>u1</code> and <code>u2</code>.</p>

<hr>
<h4>Application</h4>
<p>This can be useful e.g. to limit the torque(y) of an electric machine if a temperature indicator (u) gets
    too high. Usual parameters in such a case could be:</p>
<ul>
    <li>u2 = maximum possible torque in overload operation</li>
    <li>u1 = maximum possible torque in continuous operation</li>
    <li>u = 0 for machine below the critical temperature and 1 when the temperature is too high</li>
</ul>
</html>"),
      Icon(
        coordinateSystem(
          preserveAspectRatio = false,
          extent = {
            {-100, -100},
            {100, 100}}),
        graphics = {
          Line(
            points = {{-32, -6}, {-32, 84}},
            color = {192, 192, 192}),
          Line(points = {{-84, 0}, {74, 0}}, color = {192, 192, 192}),
          Polygon(
            points = {{90, 0}, {74, 6}, {74, -6}, {90, 0}},
            lineColor = {192, 192, 192},
            fillColor = {192, 192, 192},
            fillPattern = FillPattern.Solid),
          Polygon(
            points = {{-32, 86}, {-38, 70}, {-26, 70}, {-32, 86}},
            lineColor = {192, 192, 192},
            fillColor = {192, 192, 192},
            fillPattern = FillPattern.Solid),
          Line(
            points = {{-76, -64}, {-32, -64}, {32, 60}, {78, 60}},
            color = {0, 86, 134}),
          Line(points = {{32, -6}, {32, 60}}, color = {192, 192, 192}),
          Text(
            extent = {{-68, 74}, {-42, 48}},
            textColor = {0, 86, 134},
            textString = "u1"),
          Text(
            extent = {{8, -50}, {34, -76}},
            textColor = {0, 86, 134},
            textString = "u2"),
          Text(
            extent = {{18, -6}, {44, -32}},
            textColor = {0, 86, 134},
            textString = "1"),
          Text(
            extent = {{-44, -6}, {-20, -32}},
            textColor = {0, 86, 134},
            textString = "0"),
          Line(
            points = {{-36, 60}, {32, 60}},
            color = {192, 192, 192}),
          Line(
            points = {{-32, -64}, {4, -64}},
            color = {192, 192, 192}),
          Line(
            points = {{-32, -64}, {-32, -34}},
            color = {192, 192, 192})}));

  end VariableLinearShifter;

  block FixedDelay "Delay block with fixed DelayTime"
    extends Modelica.Blocks.Interfaces.SISO;
    parameter SI.Time delayTime(start=1)
      "Delay time of output with respect to input signal";

  equation
    y = delay(u, delayTime);
    annotation (
      Documentation(info="<html>
<p>
The Input signal is delayed by a given time instant, or more precisely:
</p>
<blockquote><pre>
y = u(time - delayTime) for time &gt; time.start + delayTime
  = u(time.start)       for time &le; time.start + delayTime
</pre></blockquote>
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
        smooth=Smooth.Bezier)}));
  end FixedDelay;

  block PadeDelay
    "Pade approximation of delay block with fixed delayTime (use balance=true; this is not the default to be backwards compatible)"
    extends Modelica.Blocks.Interfaces.SISO;
    parameter SI.Time delayTime(start=1)
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
    input Real T "Delay time";
    input Integer n "Order of denominator";
    input Integer m "Order of numerator";
    input Boolean balance=false;
    output Real a1[n] "First row of A";
    output Real b11 "= B[1,1]";
    output Real c[n] "C row matrix";
    output Real d "D matrix";
    output Real s[n-1] "Scaling such that x[i] = s[i-1]*x[i-1], i > 1";
    protected
    Real b[m + 1] "Numerator coefficients of transfer function";
    Real a[n + 1] "Denominator coefficients of transfer function";
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
<blockquote><pre>
y = u(time - delayTime) for time &gt; time.start + delayTime
  = u(time.start)       for time &le; time.start + delayTime
</pre></blockquote>
<p>
The delay is approximated by a Pade approximation, i.e., by
a transfer function
</p>
<blockquote><pre>
        b[1]*s^m + b[2]*s^[m-1] + ... + b[m+1]
y(s) = --------------------------------------------- * u(s)
        a[1]*s^n + a[2]*s^[n-1] + ... + a[n+1]
</pre></blockquote>
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

<h5>Literature</h5>
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
      Text(textColor={160,160,164},
        extent={{-10.0,38.0},{100.0,100.0}},
        textString="m=%m"),
      Text(textColor={160,160,164},
        extent={{-98.0,-96.0},{6.0,-34.0}},
        textString="n=%n"),
      Text(visible=balance, textColor={160,160,164},
        extent={{-96,-20},{98,22}},
            textString="balanced")}));
  end PadeDelay;

  block VariableDelay "Delay block with variable DelayTime"
    extends Modelica.Blocks.Interfaces.SISO;
    parameter SI.Duration delayMax(min=0, start=1) "Maximum delay time";

    Modelica.Blocks.Interfaces.RealInput delayTime annotation (Placement(
          transformation(extent={{-140,-80},{-100,-40}})));
  equation
    y = delay(u, delayTime, delayMax);
    annotation (
      Documentation(info="<html>
<p>
The Input signal is delayed by a given time instant, or more precisely:
</p>
<blockquote><pre>
y = u(time - delayTime) for time &gt; time.start + delayTime
  = u(time.start)       for time &le; time.start + delayTime
</pre></blockquote>
<p>
where delayTime is an additional input signal which must follow
the following relationship:
</p>
<blockquote><pre>
0 &le; delayTime &le; delayMax
</pre></blockquote>
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
        points={{-100.0,-60.0},{-76.0,-60.0},{-8.0,-6.0}})}));
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
