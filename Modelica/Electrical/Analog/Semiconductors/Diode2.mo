within Modelica.Electrical.Analog.Semiconductors;
model Diode2 "Improved diode model"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=293.15);
  parameter SI.Voltage Vf = 0.7 "Forward voltage";
  parameter SI.Current Ids = 1e-13 "Reverse saturation current";
  parameter SI.Resistance Rs = 16 "Ohmic resistance";
  parameter SI.Voltage Vt = Modelica.Constants.R * T/Modelica.Constants.F
    "Thermal voltage (kT/q), 0.026 at normal conditions (around 20 degC)"
    annotation(Dialog(enable=not useHeatPort));
  parameter Real N = 1 "Emission coefficient";
  parameter SI.Voltage Bv = 100 "Reverse breakdown voltage";
  parameter SI.Conductance Gp = 1e-6
    "Parallel conductance for numerical stability";
  SI.Voltage vd "Voltage across pure diode part";
  SI.Current id "Diode current";
protected
  SI.Voltage VdMax=Vf + (N*Vt_applied) "Linear continuation threshold";
  SI.Current iVdMax=Ids*(exp(VdMax/(N*Vt_applied)) - 1) "Current at threshold";
  SI.Conductance diVdMax=Ids*exp(VdMax/(N*Vt_applied))/(N*Vt_applied) "Conductance at threshold";
  SI.Voltage Vt_applied;
equation
  Vt_applied = if useHeatPort then Modelica.Constants.R * T_heatPort/Modelica.Constants.F else Vt;
  id = smooth(1,
    if vd < -Bv / 2 then
       -Ids * (exp(-(vd+Bv)/(N*Vt_applied)) + 1 - 2*exp(-Bv/(2*N*Vt_applied)))
    elseif vd < VdMax then
      Ids * (exp(vd/(N*Vt_applied)) - 1)
    else
      iVdMax + (vd - VdMax) * diVdMax);
      //Lower half of reverse biased region including breakdown.
      //Upper half of reverse biased region, and forward biased region before conduction.
      //Forward biased region after conduction

  v = vd + id * Rs;
  i = id + v*Gp;
  LossPower=i*v;

  assert(Bv>0, "Bv must be greater than zero");
  assert(Vf>0, "Vf must be greater than zero");
  assert(Vt>0, "Vt must be greater than zero");
  annotation (defaultComponentName="diode",
    Documentation(info="<html>
<p>This diode model is an improved version of the <a href=\"modelica://Modelica.Electrical.Analog.Semiconductors.Diode\">simple diode</a> model. It includes a series resistance, parallel conductance, and also models reverse breakdown. The model is divided into three parts:</p>
<ul>
<li>lower half of reversed bias region including breakdown: -Ids&middot;(exp(-(vd+Bv)/(N&middot;Vt)) + 1 - 2&middot;exp(-Bv/(2&middot;N&middot;Vt)))</li>
<li>upper half of reverse biased region and forward biased region before conduction: Ids&middot;(exp(vd/(N&middot;Vt)) - 1)</li>
<li>forward biased region after conduction: iVdMax + (vd - VdMax)&middot;diVdMax</li>
</ul>
<p>Temperature dependent behaviour is modelled when useHeatPort=true. In that case, the Vt parameter is ignored, and Vt is computed as k&middot;T/q, where</p>
<ul>
<li>k is Boltzmann&#39;s constant</li>
<li>T is the heat port temperature.</li>
<li>q is the electron charge.</li>
</ul>
</html>",
 revisions="<html>
<ul>
<li><em>November 2015 </em>
by Stefan Vorkoetter<br>implemented dynamic temperature dependency<br></li>
<li><em>November 2015</em>
by Kristin Majetta<br> defined parameter Vt based on fixed temperature<br></li>
<li><em>June 2014</em>
by Stefan Vorkoetter, Kristin Majetta, and Christoph Clauss<br>implemented<br></li>
<li><em>October 2011</em>
Stefan Vorkoetter - new model proposed.</li>
</ul>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{30,0},{-30,40},{-30,-40},{30,0}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{40,0}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Line(points={{30,40},{30,-40}}, color={0,0,255}),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          visible=useHeatPort,
          points={{0,-100},{0,-20}},
          color={127,0,0},
          pattern=LinePattern.Dot)}));
end Diode2;
