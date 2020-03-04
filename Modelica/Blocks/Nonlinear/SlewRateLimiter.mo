within Modelica.Blocks.Nonlinear;
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
