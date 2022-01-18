within Modelica.Electrical.Analog.Sources;
model DCPowerSupply "Simple model of a DC power supply cv - cp - cc"
  import Modelica.Constants.eps;
  parameter SI.Voltage V0(final min = eps) = 60 "No-load voltage";
  parameter SI.Current I0(final min = eps) = 50 "Short-circuit current";
  parameter SI.Power   P0(final min = eps) = 1200 "Maximum power";
  parameter SI.Resistance  Rcv(final min = eps) = 1e-3 "Inner resistance in constant voltage region" annotation (
    Dialog(group = "Advanced"));
  parameter SI.Conductance Gcc(final min = eps) = 1e-3 "Inner conductance in constant current region" annotation (
    Dialog(group = "Advanced"));
  parameter SI.Current iBack = 1e-3 "Allowed back current" annotation (
    Dialog(group = "Advanced"));
  SI.Voltage v(start=V0) = p.v - n.v "Terminal voltage";
  SI.Current i = p.i "Current (delivered < 0)";
  SI.Power P = v * i "Power (delivered < 0)";
  Modelica.Electrical.Analog.Interfaces.PositivePin p annotation (
    Placement(transformation(extent={{90,-110},{110,-90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n annotation (
    Placement(transformation(extent={{-110,-110},{-90,-90}})));
protected
  parameter SI.Voltage vLim(fixed=false) "Voltage limit for cc";
  parameter SI.Current iLim(fixed=false) "Current limit for cv";
  parameter Boolean cp(fixed=false) "Is cp present?";
  Boolean cv(start=true)  "Operation in cv, otherwise cc (or cp)";
  Boolean cc(start=false) "Operation in cc, otherwise cv (or cp)";
initial algorithm
  assert(Rcv < (V0/I0), "Rcv too high!");
  assert(Gcc < (I0/V0), "Gcc too high!");
  vLim:=(V0 - Rcv * I0) / (1 - Rcv * Gcc);
  iLim:=(I0 - Gcc * V0) / (1 - Gcc * Rcv);
  cp:=false;
  if vLim*iLim > P0 then
    cp:=true;
    assert(Rcv < (V0^2/(4*P0)), "Rcv too high!");
    assert(Gcc < (I0^2/(4*P0)), "Gcc too high!");
    vLim:=(I0 - sqrt(I0^2 - 4*Gcc*P0)) / (2*Gcc);
    iLim:=(V0 - sqrt(V0^2 - 4*Rcv*P0)) / (2*Rcv);
  end if;
equation
  p.i + n.i = 0;
  assert(v >= 0, "Only voltage >= 0 allowed");
  assert(i <= iBack, "Back current exceeded!");
  cv = (-i) <= iLim;
  cc =   v  <= vLim;
  if cp then
    if cv then
       v = V0 - Rcv*(-i);
    elseif cc then
      -i = I0 - Gcc*v;
    else// cp
      P0 = v*(-i);
    end if;
  else
    if cv then
       v = V0 - Rcv*(-i);
    else//cc
      -i = I0 - Gcc*v;
    end if;
  end if;
  annotation (
    defaultComponentName = "dcPowerSupply",
    Icon(graphics={
      Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,255},
        fillColor={255,255,255}, fillPattern=FillPattern.Solid, radius=10),
      Rectangle(extent={{-94,94},{94,6}}, lineColor={0,0,255},
        fillColor={215,215,215}, fillPattern=FillPattern.Solid),
      Ellipse(extent={{-80,-10},{-20,-70}}, lineColor={0,0,255},
        fillColor={215,215,215}, fillPattern=FillPattern.Sphere),
      Ellipse(extent={{20,-10},{80,-70}}, lineColor={0,0,255},
        fillColor={215,215,215}, fillPattern=FillPattern.Sphere),
      Text(extent={{-140,140},{140,100}}, textColor={0,0,255},
        textString="%name"),
      Text(extent={{-80,60},{80,40}}, textColor={0,0,0},
        textString="%V0", horizontalAlignment=TextAlignment.Left),
      Text(extent={{-80,30},{80,10}}, textColor={0,0,0},
        textString="%I0", horizontalAlignment=TextAlignment.Right),
      Text(extent={{-60,-30},{-40,-50}}, textColor={0,0,0},
        textString="V"),
      Text(extent={{40,-30},{60,-50}}, textColor={0,0,0},
        textString="A"),
      Text(extent={{-90,90},{90,70}}, textColor={0,0,0},
        textString="%P0")}),
    Documentation(info="<html>
<p>
This is a simple model of a DC power supply, as used in laboratories. 
It can only work in one quadrant, i.e., positive voltage, delivering current. 
It has three limitations:
</p>
<ul>
<li>ConstantVoltage: <code> v = V0 - Rcv*(-i);</code></li>
<li>Constant Power:  <code>P0 = v*(-i);</code></li>
<li>ConstantCurrent: <code>-i = I0 - Gcc*v;</code></li>
</ul>
<p>
Remember that current delivered by the power supply is negative.
</p>
</html>"));
end DCPowerSupply;
