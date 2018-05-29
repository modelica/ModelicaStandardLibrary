within Modelica.Electrical.Analog;
package Semiconductors
  "Semiconductor devices such as diode, MOS and bipolar transistor"
  extends Modelica.Icons.Package;
  import Modelica.Constants.k "Boltzmann's constant, [J/K]";
  import Modelica.Constants.q "Electron charge, [As]";

  model Diode "Simple diode"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter SI.Current Ids=1e-6 "Saturation current";
    parameter SI.Voltage Vt=0.04
      "Voltage equivalent of temperature (kT/qn)";
    parameter Real Maxexp(final min=Modelica.Constants.small) = 15
      "Max. exponent for linear continuation";
    parameter SI.Resistance R=1e8 "Parallel ohmic resistance";
    extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=293.15);
  equation
    i = smooth(1, Ids*(exlin(v/Vt, Maxexp) - 1) + v/R);
    LossPower = v*i;
    annotation (defaultComponentName="diode",
      Documentation(info="<html>
<p>The simple diode is a one port. It consists of the diode itself and an parallel ohmic resistance <em>R</em>. The diode formula is:</p>
<pre>                v/vt
  i  =  ids ( e      - 1).</pre>
<p>If the exponent <em>v/vt</em> reaches the limit <em>maxex</em>, the diode characteristic is linearly continued to avoid overflow.</p><p><strong>Please note:</strong> In case of useHeatPort=true the temperature dependence of the electrical behavior is <strong>not</strong> modelled yet. The parameters are not temperature dependent.</p>
</html>",
   revisions="<html>
<ul>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em> November 15, 2005   </em>
       by Christoph Clauss<br> smooth function added<br>
       </li>
<li><em> 1998   </em>
       by Christoph Clauss<br> implemented<br>
       </li>
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
            extent={{-150,-40},{150,-80}},
            textString="Vt=%Vt"),
          Text(
            extent={{-150,90},{150,50}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,-20}},
            color={127,0,0},
            pattern=LinePattern.Dot)}));
  end Diode;

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
        //Lower half of reverse biased region including breakdown.
        -Ids * (exp(-(vd+Bv)/(N*Vt_applied)) + 1 - 2*exp(-Bv/(2*N*Vt_applied)))
      elseif vd < VdMax then
        //Upper half of reverse biased region, and forward biased region before conduction.
        Ids * (exp(vd/(N*Vt_applied)) - 1)
      else
        //Forward biased region after conduction
        iVdMax + (vd - VdMax) * diVdMax);

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
by Stefan Vorkoetter<br>implemented dynamic temperature dependency</br></li>
<li><em>November 2015</em>
by Kristin Majetta<br> defined parameter Vt based on fixed temperature</br></li>
<li><em>June 2014</em>
by Stefan Vorkoetter, Kristin Majetta, and Christoph Clauss<br>implemented</br></li>
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
            lineColor={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,-20}},
            color={127,0,0},
            pattern=LinePattern.Dot)}));
  end Diode2;

  model ZDiode "Zener diode with 3 working areas"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter SI.Current Ids=1e-6 "Saturation current";
    parameter SI.Voltage Vt=0.04 "Voltage equivalent of temperature (kT/qn)";
    parameter Real Maxexp(final min=Modelica.Constants.small) = 30
      "Max. exponent for linear continuation";
    parameter SI.Resistance R=1e8 "Parallel ohmic resistance";
    parameter SI.Voltage Bv=5.1 "Breakthrough voltage = Zener- or Z-voltage";
    parameter SI.Current Ibv=0.7 "Breakthrough knee current";
    parameter Real Nbv=0.74 "Breakthrough emission coefficient";
    extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=293.15);
  equation
    i = smooth(1, if (v>Maxexp*Vt) then
              Ids*( exp(Maxexp)*(1 + v/Vt - Maxexp)-1) + v/R else
           if ( (v+Bv)<-Maxexp*(Nbv*Vt)) then
              -Ids -Ibv* exp(Maxexp)*(1 - (v+Bv)/(Nbv*Vt) - Maxexp) +v/R else
              Ids*(exp(v/Vt)-1) - Ibv*exp(-(v+Bv)/(Nbv*Vt)) + v/R);
    LossPower = v*i;
          annotation (defaultComponentName="diode",
            Documentation(info="<html>
<p>The simple Zener diode is a one port. It consists of the diode itself and an parallel ohmic resistance <em>R</em>. The diode formula is:</p>
<pre>                v/Vt                -(v+Bv)/(Nbv*Vt)
  i  =  Ids ( e      - 1) - Ibv ( e                  ).</pre>
<p>If the exponent in one of the two branches reaches the limit <em>Maxexp</em>, the diode characteristic is linearly continued to avoid overflow.</p>
<p><br>The Zener diode model permits (in contrast to the simple diode model) current in reverse direction if the breakdown voltage Bv (also known Zener knee voltage) is exceeded.</p>
<p>The thermal power is calculated by <em>i*v</em>.</p><p><strong>Please note:</strong> In case of useHeatPort=true the temperature dependence of the electrical behavior is <strong>not</strong> modelled yet. The parameters are not temperature dependent.</p>
</html>",  revisions="<html>
<ul>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em>April 5, 2004   </em>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"), Icon(coordinateSystem(
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
            lineColor={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-101},{0,-20}},
            color={127,0,0},
            pattern=LinePattern.Dot),
          Line(points={{30,-40},{20,-40}}, color={28,108,200})}));
  end ZDiode;

model PMOS "Simple MOS Transistor"

  Interfaces.Pin D "Drain" annotation (Placement(transformation(extent={{90,50},{110,70}}), iconTransformation(extent={{90,50},{110,70}})));
  Interfaces.Pin G "Gate" annotation (Placement(transformation(extent={{-90,-50},{-110,-70}}), iconTransformation(extent={{-90,-50},{-110,-70}})));
  Interfaces.Pin S "Source" annotation (Placement(transformation(extent={{90,-50},{110,-70}}), iconTransformation(extent={{90,-50},{110,-70}})));
  Interfaces.Pin B "Bulk" annotation (Placement(transformation(extent={{90,
            -10},{110,10}})));
  parameter SI.Length W=20.0e-6 "Width";
  parameter SI.Length L=6.0e-6 "Length";
  parameter SI.Transconductance Beta=0.0105e-3
      "Transconductance parameter";
  parameter SI.Voltage Vt=-1.0 "Zero bias threshold voltage";
  parameter Real K2=0.41 "Bulk threshold parameter";
  parameter Real K5=0.839 "Reduction of pinch-off region";
  parameter SI.Length dW=-2.5e-6 "Narrowing of channel";
  parameter SI.Length dL=-2.1e-6 "Shortening of channel";
  parameter SI.Resistance RDS=1e7 "Drain-Source-Resistance";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=293.15);
  protected
  Real v;
  Real uds;
  Real ubs;
  Real ugst;
  Real ud;
  Real us;
  Real id;
  Real gds;

equation
  assert(L + dL > 0, "PMOS: Effective length must be positive");
  assert(W + dW > 0, "PMOS: Effective width  must be positive");
  gds = if (RDS < 1e-20 and RDS > -1e-20) then 1e20 else 1/RDS;
  v = Beta*(W + dW)/(L + dL);
  ud = smooth(0,if (D.v > S.v) then S.v else D.v);
  us = smooth(0,if (D.v > S.v) then D.v else S.v);
  uds = ud - us;
  ubs = smooth(0,if (B.v < us) then 0 else B.v - us);
  ugst = (G.v - us - Vt + K2*ubs)*K5;
  id = smooth(0,if (ugst >= 0) then uds*gds else if (ugst < uds) then -v*uds*(
    ugst - uds/2) + uds*gds else -v*ugst*ugst/2 + uds*gds);
  G.i = 0;
  D.i = smooth(0,if (D.v > S.v) then -id else id);
  S.i = smooth(0,if (D.v > S.v) then id else -id);
  B.i = 0;
  LossPower = D.i * (D.v - S.v);
  annotation (
    Documentation(info="<html>
<p>
The PMOS model is a simple model of a p-channel metal-oxide semiconductor
FET. It differs slightly from the device used in the SPICE simulator.
For more details please care for H. Spiro.
</p>
<p>
The model does not consider capacitances. A high drain-source resistance RDS
is included to avoid numerical difficulties.
<br><br>
<strong>Please note:</strong>
In case of useHeatPort=true the temperature dependence of the electrical
behavior is <strong>not</strong> modelled yet. The parameters are not temperature dependent.
</p>
<dl>
<dt><strong>References:</strong></dt>
<dd>Spiro, H.: Simulation integrierter Schaltungen. R. Oldenbourg Verlag
  Muenchen Wien 1990.</dd>
</dl>
<p>
Some typical parameter sets are:
</p>
<pre>
  W       L      Beta        Vt    K2     K5      DW       DL
  m       m      A/V^2       V     -      -       m        m
  50.e-6  8.e-6  0.0085e-3  -0.15  0.41   0.839  -3.8e-6  -4.0e-6
  20.e-6  6.e-6  0.0105e-3  -1.0   0.41   0.839  -2.5e-6  -2.1e-6
  30.e-6  5.e-6  0.0059e-3  -0.3   0.98   1.01    0       -3.9e-6
  30.e-6  5.e-6  0.0152e-3  -0.69  0.104  1.1    -0.8e-6  -0.4e-6
  30.e-6  5.e-6  0.0163e-3  -0.69  0.104  1.1    -0.8e-6  -0.4e-6
  30.e-6  5.e-6  0.0182e-3  -0.69  0.086  1.06   -0.1e-6  -0.6e-6
  20.e-6  6.e-6  0.0074e-3  -1.    0.4    0.59    0        0
</pre>

</html>",
 revisions="<html>
<ul>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em>December 7, 2005   </em>
       by Christoph Clauss<br>
       error in RDS calculation deleted</li>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-90,-60},{-10,-60}}, color={0,0,255}),
          Line(points={{-10,-60},{-10,60}}, color={0,0,255}),
          Line(points={{10,80},{10,39}}, color={0,0,255}),
          Line(points={{10,20},{10,-21}}, color={0,0,255}),
          Line(points={{10,-40},{10,-81}}, color={0,0,255}),
          Line(points={{10,60},{91,60}}, color={0,0,255}),
          Line(points={{10,0},{90,0}}, color={0,0,255}),
          Line(points={{10,-60},{90,-60}}, color={0,0,255}),
          Polygon(
            points={{60,0},{40,5},{40,-5},{60,0}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{-150,130},{150,90}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-90},{0,0}},
            color={127,0,0},
            pattern=LinePattern.Dot)}));
end PMOS;

model NMOS "Simple MOS Transistor"

  Interfaces.Pin D "Drain" annotation (Placement(transformation(extent={{90,50},{110,70}}), iconTransformation(extent={{90,50},{110,70}})));
  Interfaces.Pin G "Gate" annotation (Placement(transformation(extent={{-90,-50},{-110,-70}}), iconTransformation(extent={{-90,-50},{-110,-70}})));
  Interfaces.Pin S "Source" annotation (Placement(transformation(extent={{90,-50},{110,-70}}), iconTransformation(extent={{90,-50},{110,-70}})));
  Interfaces.Pin B "Bulk" annotation (Placement(transformation(extent={{90,
            -10},{110,10}})));
  parameter SI.Length W=20.e-6 "Width";
  parameter SI.Length L=6.e-6 "Length";
  parameter SI.Transconductance Beta=0.041e-3 "Transconductance parameter";
  parameter SI.Voltage Vt=0.8 "Zero bias threshold voltage";
  parameter Real K2=1.144 "Bulk threshold parameter";
  parameter Real K5=0.7311 "Reduction of pinch-off region";
  parameter SI.Length dW=-2.5e-6 "Narrowing of channel";
  parameter SI.Length dL=-1.5e-6 "Shortening of channel";
  parameter SI.Resistance RDS=1e7 "Drain-Source-Resistance";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=293.15);
  protected
  Real v;
  Real uds;
  Real ubs;
  Real ugst;
  Real ud;
  Real us;
  Real id;
  Real gds;

equation
  assert(L + dL > 0, "NMOS: Effective length must be positive");
  assert(W + dW > 0, "NMOS: Effective width  must be positive");
  gds = if (RDS < 1e-20 and RDS > -1e-20) then 1e20 else 1/RDS;
  v = Beta*(W + dW)/(L + dL);
  ud = smooth(0,if (D.v < S.v) then S.v else D.v);
  us = if (D.v < S.v) then D.v else S.v;
  uds = ud - us;
  ubs = smooth(0,if (B.v > us) then 0 else B.v - us);
  ugst = (G.v - us - Vt + K2*ubs)*K5;
  id = smooth(0,if (ugst <= 0) then uds*gds else if (ugst > uds) then v*uds*(ugst
     - uds/2) + uds*gds else v*ugst*ugst/2 + uds*gds);
  G.i = 0;
  D.i = smooth(0,if (D.v < S.v) then -id else id);
  S.i = smooth(0,if (D.v < S.v) then id else -id);
  B.i = 0;
  LossPower = D.i * (D.v - S.v);
  annotation (
    Documentation(info="<html>
<p>
The NMOS model is a simple model of a n-channel metal-oxide semiconductor
FET. It differs slightly from the device used in the SPICE simulator.
For more details please care for H. Spiro.
</p>
<p>
The model does not consider capacitances. A high drain-source resistance RDS
is included to avoid numerical difficulties.
<br><br>
<strong>Please note:</strong>
In case of useHeatPort=true the temperature dependence of the electrical
behavior is <strong>not</strong> modelled yet. The parameters are not temperature dependent.
</p>
<pre>
  W       L      Beta         Vt      K2     K5       DW       DL
  m       m      A/V^2        V       -      -        m        m
  12.e-6  4.e-6  0.062e-3    -4.5     0.24   0.61    -1.2e-6  -0.9e-6      depletion
  60.e-6  3.e-6  0.048e-3     0.1     0.08   0.68    -1.2e-6  -0.9e-6      enhancement
  12.e-6  4.e-6  0.0625e-3   -0.8     0.21   0.78    -1.2e-6  -0.9e-6      zero
  50.e-6  8.e-6  0.0299e-3    0.24    1.144  0.7311  -5.4e-6  -4.e-6
  20.e-6  6.e-6  0.041e-3     0.8     1.144  0.7311  -2.5e-6  -1.5e-6
  30.e-6  9.e-6  0.025e-3    -4.0     0.861  0.878   -3.4e-6  -1.74e-6
  30.e-6  5.e-6  0.031e-3     0.6     1.5    0.72     0       -3.9e-6
  50.e-6  6.e-6  0.0414e-3   -3.8     0.34   0.8     -1.6e-6  -2.e-6       depletion
  50.e-6  5.e-6  0.03e-3      0.37    0.23   0.86    -1.6e-6  -2.e-6       enhancement
  50.e-6  6.e-6  0.038e-3    -0.9     0.23   0.707   -1.6e-6  -2.e-6       zero
  20.e-6  4.e-6  0.06776e-3   0.5409  0.065  0.71    -0.8e-6  -0.2e-6
  20.e-6  4.e-6  0.06505e-3   0.6209  0.065  0.71    -0.8e-6  -0.2e-6
  20.e-6  4.e-6  0.05365e-3   0.6909  0.03   0.8     -0.3e-6  -0.2e-6
  20.e-6  4.e-6  0.05365e-3   0.4909  0.03   0.8     -0.3e-6  -0.2e-6
  12.e-6  4.e-6  0.023e-3    -4.5     0.29   0.6      0        0           depletion
  60.e-6  3.e-6  0.022e-3     0.1     0.11   0.65     0        0           enhancement
  12.e-6  4.e-6  0.038e-3    -0.8     0.33   0.6      0        0           zero
  20.e-6  6.e-6  0.022e-3     0.8     1      0.66     0        0
</pre>

<dl>
<dt><strong>References:</strong></dt>
<dd>Spiro, H.: Simulation integrierter Schaltungen. R. Oldenbourg Verlag
Muenchen Wien 1990.</dd>
</dl>
</html>",
 revisions="<html>
<ul>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em>December 7, 2005   </em>
       by Christoph Clauss<br>
       error in RDS calculation deleted</li>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-90,-60},{-10,-60}}, color={0,0,255}),
          Line(points={{-10,-60},{-10,60}}, color={0,0,255}),
          Line(points={{10,80},{10,39}}, color={0,0,255}),
          Line(points={{10,20},{10,-21}}, color={0,0,255}),
          Line(points={{10,-40},{10,-81}}, color={0,0,255}),
          Line(points={{10,60},{91,60}}, color={0,0,255}),
          Line(points={{10,0},{90,0}}, color={0,0,255}),
          Line(points={{10,-60},{90,-60}}, color={0,0,255}),
          Polygon(
            points={{40,0},{60,5},{60,-5},{40,0}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,0}},
            color={127,0,0},
            pattern=LinePattern.Dot),
          Text(
            extent={{-150,130},{150,90}},
            textString="%name",
            lineColor={0,0,255})}));
end NMOS;

model NPN "Simple BJT according to Ebers-Moll"
  parameter Real Bf=50 "Forward beta";
  parameter Real Br=0.1 "Reverse beta";
  parameter SI.Current Is=1e-16 "Transport saturation current";
  parameter SI.InversePotential Vak=0.02 "Early voltage (inverse), 1/Volt";
  parameter SI.Time Tauf=0.12e-9 "Ideal forward transit time";
  parameter SI.Time Taur=5e-9 "Ideal reverse transit time";
  parameter SI.Capacitance Ccs=1e-12 "Collector-substrate(ground) cap.";
  parameter SI.Capacitance Cje=0.4e-12
      "Base-emitter zero bias depletion cap.";
  parameter SI.Capacitance Cjc=0.5e-12
      "Base-coll. zero bias depletion cap.";
  parameter SI.Voltage Phie=0.8 "Base-emitter diffusion voltage";
  parameter Real Me=0.4 "Base-emitter gradation exponent";
  parameter SI.Voltage Phic=0.8 "Base-collector diffusion voltage";
  parameter Real Mc=0.333 "Base-collector gradation exponent";
  parameter SI.Conductance Gbc=1e-15 "Base-collector conductance";
  parameter SI.Conductance Gbe=1e-15 "Base-emitter conductance";
  parameter SI.Voltage Vt=0.02585 "Voltage equivalent of temperature";
  parameter Real EMin=-100 "if x < EMin, the exp(x) function is linearized";
  parameter Real EMax=40 "if x > EMax, the exp(x) function is linearized";
  parameter SI.Voltage IC=0 "Initial value" annotation(Dialog(enable=UIC));
  parameter Boolean UIC = false "Decision if initial value should be used";

  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=293.15);

  SI.Voltage vbc "Base-collector voltage";
  SI.Voltage vbe "Base-emitter voltage";
  Real qbk "Relative majority carrier charge, inverse";
  SI.Current ibc "Base-collector diode current";
  SI.Current ibe "Base-emitter diode current";
  SI.Capacitance cbc "Total base-collector capacitance";
  SI.Capacitance cbe "Total base-emitter capacitance";
  SI.Capacitance Capcje "Effective base-emitter depletion capacitance";
  SI.Capacitance Capcjc "Effective base-collector depletion capacitance";


  public
  Modelica.Electrical.Analog.Interfaces.Pin C "Collector" annotation (Placement(
        transformation(extent={{90,50},{110,70}}), iconTransformation(extent={{90,50},{110,70}})));
  Modelica.Electrical.Analog.Interfaces.Pin B "Base" annotation (Placement(
        transformation(extent={{-90,-10},{-110,10}})));
  Modelica.Electrical.Analog.Interfaces.Pin E "Emitter" annotation (Placement(
        transformation(extent={{90,-50},{110,-70}}), iconTransformation(extent={{90,-50},{110,-70}})));
initial equation
  if UIC then
    C.v = IC;
  end if;

equation
  vbc = B.v - C.v;
  vbe = B.v - E.v;
  qbk = 1 - vbc*Vak;

  ibc = smooth(1, Is*(exlin2(vbc/Vt, EMin, EMax) - 1) + vbc*Gbc);
  ibe = smooth(1, Is*(exlin2(vbe/Vt, EMin, EMax) - 1) + vbe*Gbe);
  Capcjc = smooth(1, Cjc*powlin(vbc/Phic, Mc));
  Capcje = smooth(1, Cje*powlin(vbe/Phie, Me));
  cbc = smooth(1, Taur*Is/Vt*exlin2(vbc/Vt, EMin, EMax) + Capcjc);
  cbe = smooth(1, Tauf*Is/Vt*exlin2(vbe/Vt, EMin, EMax) + Capcje);
  C.i = (ibe - ibc)*qbk - ibc/Br - cbc*der(vbc) + Ccs*der(C.v);
  B.i = ibe/Bf + ibc/Br + cbc*der(vbc) + cbe*der(vbe);
  E.i = -B.i - C.i + Ccs*der(C.v);

  LossPower = (C.v-E.v)*(ibe-ibc)*qbk + vbc*ibc/Br + vbe*ibe/Bf;
  annotation (
    Documentation(info="<html>
<p>
This model is a simple model of a bipolar NPN junction transistor according
to Ebers-Moll.
<br><br>
<strong>Please note:</strong>
In case of useHeatPort=true the temperature dependence of the electrical
behavior is <strong>not</strong> modelled yet. The parameters are not temperature dependent.
</p>
<p>
A typical parameter set is:
</p>
<pre>
  Bf  Br  Is     Vak  Tauf    Taur  Ccs   Cje     Cjc     Phie  Me   PHic   Mc     Gbc    Gbe    Vt
  -   -   A      V    s       s     F     F       F       V     -    V      -      mS     mS     V
  50  0.1 1e-16  0.02 0.12e-9 5e-9  1e-12 0.4e-12 0.5e-12 0.8   0.4  0.8    0.333  1e-15  1e-15  0.02585
</pre>
<dl>
<dt><strong>References:</strong></dt>
<dd>Vlach, J.; Singal, K.: Computer methods for circuit analysis and design.
Van Nostrand Reinhold, New York 1983
on page 317 ff.</dd>
</dl>
</html>",
 revisions="<html>
<ul>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>

<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-20,40},{-20,-40}}, color={0,0,255}),
          Line(points={{-20,0},{-100,0}}, color={0,0,255}),
          Line(points={{90,60},{30,60}}, color={0,0,255}),
          Line(points={{30,60},{-20,10}}, color={0,0,255}),
          Line(points={{-20,-10},{20,-50}}, color={0,0,255}),
          Line(points={{30,-60},{91,-60}}, color={0,0,255}),
          Polygon(
            points={{30,-60},{24,-46},{16,-54},{30,-60}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,-20}},
            color={127,0,0},
            pattern=LinePattern.Dot),
          Text(
            extent={{-150,130},{150,90}},
            textString="%name",
            lineColor={0,0,255})}));
end NPN;

model PNP "Simple BJT according to Ebers-Moll"
  parameter Real Bf=50 "Forward beta";
  parameter Real Br=0.1 "Reverse beta";
  parameter SI.Current Is=1e-16 "Transport saturation current";
  parameter SI.InversePotential Vak=0.02 "Early voltage (inverse), 1/Volt";
  parameter SI.Time Tauf=0.12e-9 "Ideal forward transit time";
  parameter SI.Time Taur=5e-9 "Ideal reverse transit time";
  parameter SI.Capacitance Ccs=1e-12 "Collector-substrate(ground) cap.";
  parameter SI.Capacitance Cje=0.4e-12
      "Base-emitter zero bias depletion cap.";
  parameter SI.Capacitance Cjc=0.5e-12
      "Base-coll. zero bias depletion cap.";
  parameter SI.Voltage Phie=0.8 "Base-emitter diffusion voltage";
  parameter Real Me=0.4 "Base-emitter gradation exponent";
  parameter SI.Voltage Phic=0.8 "Base-collector diffusion voltage";
  parameter Real Mc=0.333 "Base-collector gradation exponent";
  parameter SI.Conductance Gbc=1e-15 "Base-collector conductance";
  parameter SI.Conductance Gbe=1e-15 "Base-emitter conductance";
  parameter SI.Voltage Vt=0.02585 "Voltage equivalent of temperature";
  parameter Real EMin=-100 "if x < EMin, the exp(x) function is linearized";
  parameter Real EMax=40 "if x > EMax, the exp(x) function is linearized";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=293.15);

  SI.Voltage vbc "Base-collector voltage";
  SI.Voltage vbe "Base-emitter voltage";
  Real qbk "Relative majority carrier charge, inverse";
  SI.Current ibc "Base-collector diode current";
  SI.Current ibe "Base-emitter diode current";
  SI.Capacitance cbc "Total base-collector capacitance";
  SI.Capacitance cbe "Total base-emitter capacitance";
  SI.Capacitance Capcje "Effective base-emitter depletion capacitance";
  SI.Capacitance Capcjc "Effective base-collector depletion capacitance";

  public
  Modelica.Electrical.Analog.Interfaces.Pin C "Collector" annotation (Placement(
        transformation(extent={{90,50},{110,70}}), iconTransformation(extent={{90,50},{110,70}})));
  Modelica.Electrical.Analog.Interfaces.Pin B "Base" annotation (Placement(
        transformation(extent={{-90,-10},{-110,10}})));
  Modelica.Electrical.Analog.Interfaces.Pin E "Emitter" annotation (Placement(
        transformation(extent={{90,-50},{110,-70}}), iconTransformation(extent={{90,-50},{110,-70}})));
equation
  vbc = C.v - B.v;
  vbe = E.v - B.v;
  qbk = 1 - vbc*Vak;

  ibc = smooth(1, Is*(exlin2(vbc/Vt, EMin, EMax) - 1) + vbc*Gbc);
  ibe = smooth(1, Is*(exlin2(vbe/Vt, EMin, EMax) - 1) + vbe*Gbe);
  Capcjc = smooth(1, Cjc*powlin(vbc/Phic, Mc));
  Capcje = smooth(1, Cje*powlin(vbe/Phie, Me));
  cbc = smooth(1, Taur*Is/Vt*exlin2(vbc/Vt, EMin, EMax) + Capcjc);
  cbe = smooth(1, Tauf*Is/Vt*exlin2(vbe/Vt, EMin, EMax) + Capcje);
  C.i = -((ibe - ibc)*qbk - ibc/Br - cbc*der(vbc) - Ccs*der(C.v));
  B.i = -(ibe/Bf + ibc/Br + cbe*der(vbe) + cbc*der(vbc));
  E.i = -B.i - C.i + Ccs*der(C.v);

  LossPower = (E.v-C.v)*(ibe-ibc)*qbk + vbc*ibc/Br + vbe*ibe/Bf;
                                                                    annotation (
    Documentation(info="<html>
<p>
This model is a simple model of a bipolar PNP junction transistor according
to Ebers-Moll.
<br><br>
<strong>Please note:</strong>
In case of useHeatPort=true the temperature dependency of the electrical
behavior is <strong>not</strong> modelled yet. The parameters are not temperature dependent.</p>
<p>
A typical parameter set is:
</p>
<pre>
  Bf  Br  Is     Vak  Tauf    Taur  Ccs   Cje     Cjc     Phie  Me   PHic   Mc     Gbc    Gbe    Vt
  -   -   A      V    s       s     F     F       F       V     -    V      -      mS     mS     V
  50  0.1 1e-16  0.02 0.12e-9 5e-9  1e-12 0.4e-12 0.5e-12 0.8   0.4  0.8    0.333  1e-15  1e-15  0.02585
</pre>
<dl>
<dt><strong>References:</strong></dt>
<dd>Vlach, J.; Singal, K.: Computer methods for circuit analysis and design.
Van Nostrand Reinhold, New York 1983
on page 317 ff.</dd>
</dl>
</html>",
 revisions="<html>
<ul>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>

<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-20,40},{-20,-40}}, color={0,0,255}),
          Line(points={{-20,0},{-100,0}}, color={0,0,255}),
          Line(points={{91,60},{30,60}}, color={0,0,255}),
          Line(points={{30,60},{-20,10}}, color={0,0,255}),
          Line(points={{-20,-10},{30,-60}}, color={0,0,255}),
          Line(points={{30,-60},{100,-60}}, color={0,0,255}),
          Polygon(
            points={{-20,-10},{-5,-17},{-13,-25},{-20,-10}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,-20}},
            color={127,0,0},
            pattern=LinePattern.Dot),
          Text(
            extent={{-150,130},{150,90}},
            textString="%name",
            lineColor={0,0,255})}));
end PNP;

model HeatingDiode "Simple diode with heating port"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter SI.Current Ids=1e-6 "Saturation current";
  /* parameter SI.Voltage Vt=0.04 "Voltage equivalent of temperature (kT/qn)"; */
  parameter Real Maxexp(final min=Modelica.Constants.small) = 15
      "Max. exponent for linear continuation";
  parameter SI.Resistance R=1e8 "Parallel ohmic resistance";
  parameter Real EG=1.11 "Activation energy";
  parameter Real N=1 "Emission coefficient";
  parameter SI.Temperature TNOM=300.15
      "Parameter measurement temperature";
  parameter Real XTI=3 "Temperature exponent of saturation current";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(useHeatPort=true);

  SI.Voltage vt_t "Temperature voltage";
  SI.Current id "Diode current";
  protected
  SI.Temperature htemp "Auxiliary temperature";
  Real aux;
  Real auxp;
equation
  assert(T_heatPort > 0,"Temperature must be positive");
  htemp = T_heatPort;
  vt_t = k*htemp/q;

  id = exlin((v/(N*vt_t)), Maxexp) - 1;

  aux = (htemp/TNOM - 1)*EG/(N*vt_t);
  auxp = exp(aux);

  i = Ids*id*pow(htemp/TNOM, XTI/N)*auxp + v/R;

  LossPower = i*v;
  annotation (defaultComponentName="diode",
    Documentation(info="<html>
<p>
The simple diode is an electrical one port, where a heat port is added, which is
defined in the Modelica.Thermal library. It consists of the diode itself and an parallel ohmic
resistance <em>R</em>. The diode formula is:
</p>
<pre>
                v/vt_t
  i  =  ids ( e        - 1).

</pre>
where vt_t depends on the temperature of the heat port:
<pre>
  vt_t = k*temp/q
</pre>
<p>
If the exponent <em>v/vt_t</em> reaches the limit <em>maxex</em>, the diode characteristic is linearly
continued to avoid overflow.<br>
The thermal power is calculated by <em>i*v</em>.
</p>
</html>", revisions="<html>
<ul>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em>April 5, 2004   </em>
       by Christoph Clauss<br> implemented<br>
       </li>
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
            lineColor={0,0,255})}));
end HeatingDiode;

        model HeatingNMOS "Simple MOS Transistor with heating port"

          Modelica.Electrical.Analog.Interfaces.Pin D "Drain"
            annotation (Placement(transformation(extent={{90,50},{110,70}}), iconTransformation(extent={{90,50},{110,70}})));
          Modelica.Electrical.Analog.Interfaces.Pin G "Gate"
            annotation (Placement(transformation(extent={{-90,-50},{-110,-70}}), iconTransformation(extent={{-90,-50},{-110,-70}})));
          Modelica.Electrical.Analog.Interfaces.Pin S "Source"
            annotation (Placement(transformation(extent={{90,-50},{110,-70}}), iconTransformation(extent={{90,-50},{110,-70}})));
          Modelica.Electrical.Analog.Interfaces.Pin B "Bulk"
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));
          parameter SI.Length W=20.e-6 "Width";
          parameter SI.Length L=6.e-6 "Length";
          parameter SI.Transconductance Beta=0.041e-3 "Transconductance parameter";
          parameter SI.Voltage Vt=0.8 "Zero bias threshold voltage";
          parameter Real K2=1.144 "Bulk threshold parameter";
          parameter Real K5=0.7311 "Reduction of pinch-off region";
          parameter SI.Length dW=-2.5e-6 "Narrowing of channel";
          parameter SI.Length dL=-1.5e-6 "Shortening of channel";
          parameter SI.Resistance RDS=1e7 "Drain-Source-Resistance";
          parameter SI.Temperature Tnom=300.15 "Parameter measurement temperature";
          parameter Real kvt=-6.96e-3 "Fitting parameter for Vt";
          parameter Real kk2=6e-4 "Fitting parameter for K2";
          extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(
             useHeatPort=true);
  protected
          Real v;
          Real uds;
          Real ubs;
          Real ugst;
          Real ud;
          Real us;
          Real id;
          Real gds;
          Real beta_t;
          Real vt_t;
          Real k2_t;
        equation
          assert(L + dL > 0, "Heating NMOS: Effective length must be positive");
          assert(W + dW > 0, "Heating NMOS: Effective width  must be positive");
          assert(T_heatPort > 0,"Heating NMOS: Temperature must be positive");
          gds = if (RDS < 1e-20 and RDS > -1e-20) then 1e20 else 1/RDS;
          v = beta_t*(W + dW)/(L + dL);
          ud = smooth(0,if (D.v < S.v) then S.v else D.v);
          us = smooth(0,if (D.v < S.v) then D.v else S.v);
          uds = ud - us;
          ubs = smooth(0,if (B.v > us) then 0 else B.v - us);
          ugst = (G.v - us - vt_t + k2_t*ubs)*K5;
          id = smooth(0,if (ugst <= 0) then uds*gds else if (ugst > uds) then v*uds*(
            ugst - uds/2) + uds*gds else v*ugst*ugst/2 + uds*gds);

          beta_t = Beta*pow((T_heatPort/Tnom), -1.5);
          vt_t = Vt*(1 + (T_heatPort - Tnom)*kvt);
          k2_t = K2*(1 + (T_heatPort - Tnom)*kk2);

          G.i = 0;
          D.i = smooth(0,if (D.v < S.v) then -id else id);
          S.i = smooth(0,if (D.v < S.v) then id else -id);
          B.i = 0;
          LossPower = D.i*(D.v - S.v);
          annotation (defaultComponentName="nMOS",
            Documentation(info="<html>
<p>The NMOS model is a simple model of a n-channel metal-oxide semiconductor FET. It differs slightly from the device used in the SPICE simulator. For more details please care for H. Spiro.
<br> A heating port is added for thermal electric simulation. The heating port is defined in the Modelica.Thermal library.
<br>The model does not consider capacitances. A high drain-source resistance RDS is included to avoid numerical difficulties.
</p>
<pre>
  W       L      Beta         Vt      K2     K5       DW       DL
  m       m      A/V^2        V       -      -        m        m
  12.e-6  4.e-6  0.062e-3    -4.5     0.24   0.61    -1.2e-6  -0.9e-6      depletion
  60.e-6  3.e-6  0.048e-3     0.1     0.08   0.68    -1.2e-6  -0.9e-6      enhancement
  12.e-6  4.e-6  0.0625e-3   -0.8     0.21   0.78    -1.2e-6  -0.9e-6      zero
  50.e-6  8.e-6  0.0299e-3    0.24    1.144  0.7311  -5.4e-6  -4.e-6
  20.e-6  6.e-6  0.041e-3     0.8     1.144  0.7311  -2.5e-6  -1.5e-6
  30.e-6  9.e-6  0.025e-3    -4.0     0.861  0.878   -3.4e-6  -1.74e-6
  30.e-6  5.e-6  0.031e-3     0.6     1.5    0.72     0       -3.9e-6
  50.e-6  6.e-6  0.0414e-3   -3.8     0.34   0.8     -1.6e-6  -2.e-6       depletion
  50.e-6  5.e-6  0.03e-3      0.37    0.23   0.86    -1.6e-6  -2.e-6       enhancement
  50.e-6  6.e-6  0.038e-3    -0.9     0.23   0.707   -1.6e-6  -2.e-6       zero
  20.e-6  4.e-6  0.06776e-3   0.5409  0.065  0.71    -0.8e-6  -0.2e-6
  20.e-6  4.e-6  0.06505e-3   0.6209  0.065  0.71    -0.8e-6  -0.2e-6
  20.e-6  4.e-6  0.05365e-3   0.6909  0.03   0.8     -0.3e-6  -0.2e-6
  20.e-6  4.e-6  0.05365e-3   0.4909  0.03   0.8     -0.3e-6  -0.2e-6
  12.e-6  4.e-6  0.023e-3    -4.5     0.29   0.6      0        0           depletion
  60.e-6  3.e-6  0.022e-3     0.1     0.11   0.65     0        0           enhancement
  12.e-6  4.e-6  0.038e-3    -0.8     0.33   0.6      0        0           zero
  20.e-6  6.e-6  0.022e-3     0.8     1      0.66     0        0
</pre>
<p><strong>References:</strong></p>
<p>Spiro, H.: Simulation integrierter Schaltungen. R. Oldenbourg Verlag Muenchen Wien 1990.</p>
</html>",  revisions="<html>
<ul>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em>December 7, 2005   </em>
       by Christoph Clauss<br>
       error in RDS calculation deleted</li>
<li><em>March 31, 2004   </em>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-90,-60},{-10,-60}}, color={0,0,255}),
          Line(points={{-10,-60},{-10,60}}, color={0,0,255}),
          Line(points={{10,80},{10,39}}, color={0,0,255}),
          Line(points={{10,20},{10,-21}}, color={0,0,255}),
          Line(points={{10,-40},{10,-81}}, color={0,0,255}),
          Line(points={{10,60},{91,60}}, color={0,0,255}),
          Line(points={{10,0},{90,0}}, color={0,0,255}),
          Line(points={{10,-60},{90,-60}}, color={0,0,255}),
          Polygon(
            points={{40,0},{60,5},{60,-5},{40,0}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(     extent={{-150,130},{150,90}},
            textString="%name",
                    lineColor={0,0,255})}));
        end HeatingNMOS;

        model HeatingPMOS "Simple PMOS Transistor with heating port"

          Modelica.Electrical.Analog.Interfaces.Pin D "Drain"
            annotation (Placement(transformation(extent={{90,50},{110,70}}), iconTransformation(extent={{90,50},{110,70}})));
          Modelica.Electrical.Analog.Interfaces.Pin G "Gate"
            annotation (Placement(transformation(extent={{-90,-50},{-110,-70}}), iconTransformation(extent={{-90,-50},{-110,-70}})));
          Modelica.Electrical.Analog.Interfaces.Pin S "Source"
            annotation (Placement(transformation(extent={{90,-50},{110,-70}}), iconTransformation(extent={{90,-50},{110,-70}})));
          Modelica.Electrical.Analog.Interfaces.Pin B "Bulk"
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));
          parameter SI.Length W=20.0e-6 "Width";
          parameter SI.Length L=6.0e-6 "Length";
          parameter SI.Transconductance Beta=0.0105e-3 "Transconductance parameter";
          parameter SI.Voltage Vt=-1.0 "Zero bias threshold voltage";
          parameter Real K2=0.41 "Bulk threshold parameter";
          parameter Real K5=0.839 "Reduction of pinch-off region";
          parameter SI.Length dW=-2.5e-6 "Narrowing of channel";
          parameter SI.Length dL=-2.1e-6 "Shortening of channel";
          parameter SI.Resistance RDS=1e7 "Drain-Source-Resistance";
          parameter SI.Temperature Tnom=300.15 "Parameter measurement temperature";
          parameter Real kvt=-2.9e-3 "Fitting parameter for Vt";
          parameter Real kk2=6.2e-4 "Fitting parameter for K2";
          extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(
             useHeatPort=true);
  protected
          Real v;
          Real uds;
          Real ubs;
          Real ugst;
          Real ud;
          Real us;
          Real id;
          Real gds;
          Real beta_t;
          Real vt_t;
          Real k2_t;
        equation
          assert(L + dL > 0, "HeatingPMOS: Effective length must be positive");
          assert(W + dW > 0, "HeatingPMOS: Effective width  must be positive");
          assert(T_heatPort > 0,"HeatingPMOS: Temperature must be positive");
          gds = if (RDS < 1e-20 and RDS > -1e-20) then 1e20 else 1/RDS;
          v = beta_t*(W + dW)/(L + dL);
          ud = smooth(0,if (D.v > S.v) then S.v else D.v);
          us = smooth(0,if (D.v > S.v) then D.v else S.v);
          uds = ud - us;
          ubs = smooth(0,if (B.v < us) then 0 else B.v - us);
          ugst = (G.v - us - vt_t + k2_t*ubs)*K5;
          id = smooth(0,if (ugst >= 0) then uds*gds else if (ugst < uds) then -v*uds*(
            ugst - uds/2) + uds*gds else -v*ugst*ugst/2 + uds*gds);

          beta_t = Beta*pow((T_heatPort/Tnom), -1.5);
          vt_t = Vt*(1 + (T_heatPort - Tnom)*kvt);
          k2_t = K2*(1 + (T_heatPort - Tnom)*kk2);

          G.i = 0;
          D.i = smooth(0,if (D.v > S.v) then -id else id);
          S.i = smooth(0,if (D.v > S.v) then id else -id);
          B.i = 0;
          LossPower = D.i*(D.v - S.v);
          annotation (defaultComponentName="pMOS",
            Documentation(info="<html>
<p>The PMOS model is a simple model of a p-channel metal-oxide semiconductor FET. It differs slightly from the device used in the SPICE simulator. For more details please care for H. Spiro.
<br>A heating port is added for thermal electric simulation. The heating port is defined in the Modelica.Thermal library.
<br>The model does not consider capacitances. A high drain-source resistance RDS is included to avoid numerical difficulties.</p>
<dl><dt><strong>References:</strong> </dt>
<dd>Spiro, H.: Simulation integrierter Schaltungen. R. Oldenbourg Verlag Muenchen Wien 1990. </dd>
</dl><p>Some typical parameter sets are:</p>
<pre>
  W       L      Beta        Vt    K2     K5      DW       DL
  m       m      A/V^2       V     -      -       m        m
  50.e-6  8.e-6  0.0085e-3  -0.15  0.41   0.839  -3.8e-6  -4.0e-6
  20.e-6  6.e-6  0.0105e-3  -1.0   0.41   0.839  -2.5e-6  -2.1e-6
  30.e-6  5.e-6  0.0059e-3  -0.3   0.98   1.01    0       -3.9e-6
  30.e-6  5.e-6  0.0152e-3  -0.69  0.104  1.1    -0.8e-6  -0.4e-6
  30.e-6  5.e-6  0.0163e-3  -0.69  0.104  1.1    -0.8e-6  -0.4e-6
  30.e-6  5.e-6  0.0182e-3  -0.69  0.086  1.06   -0.1e-6  -0.6e-6
  20.e-6  6.e-6  0.0074e-3  -1.    0.4    0.59    0        0
</pre>
</html>",  revisions="<html>
<ul>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em>December 7, 2005   </em>
       by Christoph Clauss<br>
       error in RDS calculation deleted</li>
<li><em>March 31, 2004   </em>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-90,-60},{-10,-60}}, color={0,0,255}),
          Line(points={{-10,-60},{-10,60}}, color={0,0,255}),
          Line(points={{10,80},{10,39}}, color={0,0,255}),
          Line(points={{10,20},{10,-21}}, color={0,0,255}),
          Line(points={{10,-40},{10,-81}}, color={0,0,255}),
          Line(points={{10,60},{91,60}}, color={0,0,255}),
          Line(points={{10,0},{90,0}}, color={0,0,255}),
          Line(points={{10,-60},{90,-60}}, color={0,0,255}),
          Polygon(
            points={{60,0},{40,5},{40,-5},{60,0}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(     extent={{-150,130},{150,90}},
            textString="%name",
                    lineColor={0,0,255})}));
        end HeatingPMOS;

        model HeatingNPN "Simple NPN BJT according to Ebers-Moll with heating port"
          parameter Real Bf=50 "Forward beta";
          parameter Real Br=0.1 "Reverse beta";
          parameter SI.Current Is=1e-16 "Transport saturation current";
          parameter SI.InversePotential Vak=0.02 "Early voltage (inverse), 1/Volt";
          parameter SI.Time Tauf=0.12e-9 "Ideal forward transit time";
          parameter SI.Time Taur=5e-9 "Ideal reverse transit time";
          parameter SI.Capacitance Ccs=1e-12 "Collector-substrate(ground) cap.";
          parameter SI.Capacitance Cje=0.4e-12 "Base-emitter zero bias depletion cap.";
          parameter SI.Capacitance Cjc=0.5e-12 "Base-coll. zero bias depletion cap.";
          parameter SI.Voltage Phie=0.8 "Base-emitter diffusion voltage";
          parameter Real Me=0.4 "Base-emitter gradation exponent";
          parameter SI.Voltage Phic=0.8 "Base-collector diffusion voltage";
          parameter Real Mc=0.333 "Base-collector gradation exponent";
          parameter SI.Conductance Gbc=1e-15 "Base-collector conductance";
          parameter SI.Conductance Gbe=1e-15 "Base-emitter conductance";
          parameter Real EMin=-100 "if x < EMin, the exp(x) function is linearized";
          parameter Real EMax=40 "if x > EMax, the exp(x) function is linearized";
          parameter SI.Temperature Tnom=300.15 "Parameter measurement temperature";
          parameter Real XTI=3 "Temperature exponent for effect on Is";
          parameter Real XTB=0 "Forward and reverse beta temperature exponent";
          parameter SI.Voltage EG=1.11 "Energy gap for temperature effect on Is";
          parameter Real NF=1.0 "Forward current emission coefficient";
          parameter Real NR=1.0 "Reverse current emission coefficient";
          extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(
             useHeatPort=true);

          SI.Voltage vbc "Base-collector voltage";
          SI.Voltage vbe "Base-emitter voltage";
          Real qbk "Relative majority carrier charge, inverse";
          SI.Current ibc "Base-collector diode current";
          SI.Current ibe "Base-emitter diode current";
          SI.Capacitance cbc "Total base-collector capacitance";
          SI.Capacitance cbe "Total base-emitter capacitance";
          SI.Capacitance Capcje "Effective base-emitter depletion capacitance";
          SI.Capacitance Capcjc "Effective base-collector depletion capacitance";
          SI.Current is_t "Temperature dependent transport saturation current";
          Real br_t "Temperature dependent forward beta";
          Real bf_t "Temperature dependent reverse beta";
          SI.Voltage vt_t "Voltage equivalent of effective temperature";
          Real hexp "Auxiliary quantity temperature dependent exponent";
          Real htempexp "Auxiliary quantity exp(hexp)";

          Modelica.Electrical.Analog.Interfaces.Pin C "Collector"
            annotation (Placement(transformation(extent={{90,50},{110,70}}), iconTransformation(extent={{90,50},{110,70}})));
          Modelica.Electrical.Analog.Interfaces.Pin B "Base"
            annotation (Placement(transformation(extent={{-90,-10},{-110,10}})));
          Modelica.Electrical.Analog.Interfaces.Pin E "Emitter"
            annotation (Placement(transformation(extent={{90,-50},{110,-70}}), iconTransformation(extent={{90,-50},{110,-70}})));
        equation
          assert(T_heatPort > 0,"Temperature must be positive");
          vbc = B.v - C.v;
          vbe = B.v - E.v;
          qbk = 1 - vbc*Vak;

          hexp = (T_heatPort/Tnom - 1)*EG/vt_t;
          htempexp = smooth(1, exlin2(hexp, EMin, EMax));

          is_t = Is*pow((T_heatPort/Tnom), XTI)*htempexp;
          br_t = Br*pow((T_heatPort/Tnom), XTB);
          bf_t = Bf*pow((T_heatPort/Tnom), XTB);
          vt_t = (k/q)*T_heatPort;

          ibc = smooth(1, is_t*(exlin2(vbc/(NR*vt_t), EMin, EMax) - 1) + vbc*Gbc);
          ibe = smooth(1, is_t*(exlin2(vbe/(NF*vt_t), EMin, EMax) - 1) + vbe*Gbe);
          Capcjc = smooth(1, Cjc*powlin(vbc/Phic, Mc));
          Capcje = smooth(1, Cje*powlin(vbe/Phie, Me));
          cbc = smooth(1, Taur*is_t/(NR*vt_t)*exlin2(vbc/(NR*vt_t), EMin, EMax) + Capcjc);
          cbe = smooth(1, Tauf*is_t/(NF*vt_t)*exlin2(vbe/(NF*vt_t), EMin, EMax) + Capcje);
          C.i = (ibe - ibc)*qbk - ibc/br_t - cbc*der(vbc) + Ccs*der(C.v);
          B.i = ibe/bf_t + ibc/br_t + cbc*der(vbc) + cbe*der(vbe);
          E.i = -B.i - C.i + Ccs*der(C.v);

          LossPower = (vbc*ibc/br_t + vbe*ibe/bf_t + (ibe - ibc)*qbk*(C.v - E.v));
          annotation (defaultComponentName="npn",
            Documentation(info="<html>
<p>This model is a simple model of a bipolar NPN junction transistor according to Ebers-Moll.
<br>A heating port is added for thermal electric simulation. The heating port is defined in the Modelica.Thermal library.
<br>A typical parameter set is (the parameter Vt is no longer used):</p>
<pre>  Bf  Br  Is     Vak  Tauf    Taur  Ccs   Cje     Cjc     Phie  Me   PHic   Mc     Gbc    Gbe
  -   -   A      V    s       s     F     F       F       V     -    V      -      mS     mS
  50  0.1 1e-16  0.02 0.12e-9 5e-9  1e-12 0.4e-12 0.5e-12 0.8   0.4  0.8    0.333  1e-15  1e-15</pre>
<p><strong>References:</strong></p>
<p>Vlach, J.; Singal, K.: Computer methods for circuit analysis and design. Van Nostrand Reinhold, New York 1983 on page 317 ff.</p>
</html>",  revisions="<html>
<ul>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em>March 20, 2004   </em>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-20,40},{-20,-40}}, color={0,0,255}),
          Line(points={{-20,0},{-100,0}}, color={0,0,255}),
          Line(points={{91,60},{30,60}}, color={0,0,255}),
          Line(points={{30,60},{-20,10}}, color={0,0,255}),
          Line(points={{-20,-10},{30,-60}}, color={0,0,255}),
          Line(points={{30,-60},{91,-60}}, color={0,0,255}),
          Polygon(
            points={{30,-60},{24,-46},{16,-54},{30,-60}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(     extent={{-150,130},{150,90}},
            textString="%name",
                    lineColor={0,0,255})}));
        end HeatingNPN;

        model HeatingPNP "Simple PNP BJT according to Ebers-Moll with heating port"
          parameter Real Bf=50 "Forward beta";
          parameter Real Br=0.1 "Reverse beta";
          parameter SI.Current Is=1e-16 "Transport saturation current";
          parameter SI.InversePotential Vak=0.02 "Early voltage (inverse), 1/Volt";
          parameter SI.Time Tauf=0.12e-9 "Ideal forward transit time";
          parameter SI.Time Taur=5e-9 "Ideal reverse transit time";
          parameter SI.Capacitance Ccs=1e-12 "Collector-substrate(ground) cap.";
          parameter SI.Capacitance Cje=0.4e-12 "Base-emitter zero bias depletion cap.";
          parameter SI.Capacitance Cjc=0.5e-12 "Base-coll. zero bias depletion cap.";
          parameter SI.Voltage Phie=0.8 "Base-emitter diffusion voltage";
          parameter Real Me=0.4 "Base-emitter gradation exponent";
          parameter SI.Voltage Phic=0.8 "Base-collector diffusion voltage";
          parameter Real Mc=0.333 "Base-collector gradation exponent";
          parameter SI.Conductance Gbc=1e-15 "Base-collector conductance";
          parameter SI.Conductance Gbe=1e-15 "Base-emitter conductance";
          parameter Real EMin=-100 "if x < EMin, the exp(x) function is linearized";
          parameter Real EMax=40 "if x > EMax, the exp(x) function is linearized";
          parameter SI.Temperature Tnom=300.15 "Parameter measurement temperature";
          parameter Real XTI=3 "Temperature exponent for effect on Is";
          parameter Real XTB=0 "Forward and reverse beta temperature exponent";
          parameter SI.Voltage EG=1.11 "Energy gap for temperature effect on Is";
          parameter Real NF=1.0 "Forward current emission coefficient";
          parameter Real NR=1.0 "Reverse current emission coefficient";
          extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(
             useHeatPort=true);
          SI.Voltage vcb "Collector-base voltage";
          SI.Voltage veb "Emitter-base voltage";
          Real qbk "Relative majority carrier charge, inverse";
          SI.Current icb "Collector-base diode current";
          SI.Current ieb "Emitter-base diode current";
          SI.Capacitance ccb "Total collector-base capacitance";
          SI.Capacitance ceb "Total emitter-base capacitance";
          SI.Capacitance Capcje "Effective emitter-base depletion capacitance";
          SI.Capacitance Capcjc "Effective collector-base depletion capacitance";
          SI.Current is_t "Temperature dependent transport saturation current";
          Real br_t "Temperature dependent forward beta";
          Real bf_t "Temperature dependent reverse beta";
          SI.Voltage vt_t "Voltage equivalent of effective temperature";
          Real hexp "Auxiliary quantity temperature dependent exponent";
          Real htempexp "Auxiliary quantity exp(hexp)";

          Modelica.Electrical.Analog.Interfaces.Pin C "Collector"
            annotation (Placement(transformation(extent={{90,50},{110,70}}), iconTransformation(extent={{90,50},{110,70}})));
          Modelica.Electrical.Analog.Interfaces.Pin B "Base"
            annotation (Placement(transformation(extent={{-90,-10},{-110,10}})));
          Modelica.Electrical.Analog.Interfaces.Pin E "Emitter"
            annotation (Placement(transformation(extent={{90,-50},{110,-70}}), iconTransformation(extent={{90,-50},{110,-70}})));
        equation
          assert(T_heatPort > 0,"Temperature must be positive");
          vcb = C.v - B.v;
          veb = E.v - B.v;
          qbk = 1 - vcb*Vak;

          hexp = (T_heatPort/Tnom - 1)*EG/vt_t;
          htempexp = smooth(1, exlin2(hexp, EMin, EMax));

          is_t = Is*pow((T_heatPort/Tnom), XTI)*htempexp;
          br_t = Br*pow((T_heatPort/Tnom), XTB);
          bf_t = Bf*pow((T_heatPort/Tnom), XTB);
          vt_t = (k/q)*T_heatPort;

          icb = smooth(1, is_t*(exlin2(vcb/(NR*vt_t), EMin, EMax) - 1) + vcb*Gbc);
          ieb = smooth(1, is_t*(exlin2(veb/(NF*vt_t), EMin, EMax) - 1) + veb*Gbe);
          Capcjc = smooth(1, Cjc*powlin(vcb/Phic, Mc));
          Capcje = smooth(1, Cje*powlin(veb/Phie, Me));
          ccb = smooth(1, Taur*is_t/(NR*vt_t)*exlin2(vcb/(NR*vt_t), EMin, EMax) + Capcjc);
          ceb = smooth(1, Tauf*is_t/(NF*vt_t)*exlin2(veb/(NF*vt_t), EMin, EMax) + Capcje);
          C.i = icb/br_t + ccb*der(vcb) + Ccs*der(C.v) + (icb - ieb)*qbk;
          B.i = -ieb/bf_t - icb/br_t - ceb*der(veb) - ccb*der(vcb);
          E.i = -B.i - C.i + Ccs*der(C.v);

          LossPower = (vcb*icb/br_t + veb*ieb/bf_t + (icb - ieb)*qbk*(C.v- E.v));
          annotation (defaultComponentName="pnp",
            Documentation(info="<html>
<p>This model is a simple model of a bipolar PNP junction transistor according to Ebers-Moll.
<br>A heating port is added for thermal electric simulation. The heating port is defined in the Modelica.Thermal library.
<br>A typical parameter set is (the parameter Vt is no longer used):</p>
<pre>  Bf  Br  Is     Vak  Tauf    Taur  Ccs   Cje     Cjc     Phie  Me   PHic   Mc     Gbc    Gbe
  -   -   A      V    s       s     F     F       F       V     -    V      -      mS     mS
  50  0.1 1e-16  0.02 0.12e-9 5e-9  1e-12 0.4e-12 0.5e-12 0.8   0.4  0.8    0.333  1e-15  1e-15</pre>
<p><strong>References:</strong></p>
<p>Vlach, J.; Singal, K.: Computer methods for circuit analysis and design. Van Nostrand Reinhold, New York 1983 on page 317 ff.</p>
</html>",  revisions="<html>
<ul>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em>March 20, 2004   </em>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-20,40},{-20,-40}}, color={0,0,255}),
          Line(points={{-20,0},{-100,0}}, color={0,0,255}),
          Line(points={{91,60},{30,60}}, color={0,0,255}),
          Line(points={{30,60},{-20,10}}, color={0,0,255}),
          Line(points={{-20,-10},{30,-60}}, color={0,0,255}),
          Line(points={{30,-60},{91,-60}}, color={0,0,255}),
          Polygon(
            points={{-20,-10},{-5,-17},{-13,-25},{-20,-10}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(     extent={{-150,130},{150,90}},
            textString="%name",
                    lineColor={0,0,255})}));
        end HeatingPNP;

protected
        function pow "Just a helper function for x^y in order that a symbolic engine can apply some transformations more easily"
          extends Modelica.Icons.Function;
          input Real x;
          input Real y;
          output Real z;
        algorithm
          z := x^y;
        end pow;

        function powlin "Power function (1 - x)^(-y) linearly continued for x > 0 (provided y = const.)"
          extends Modelica.Icons.Function;
          input Real x;
          input Real y;
          output Real z;
        algorithm
          z := if x > 0 then 1 + y*x else pow(1 - x, -y);
        end powlin;

        function exlin "Exponential function linearly continued for x > Maxexp"
          extends Modelica.Icons.Function;
          input Real x;
          input Real Maxexp;
          output Real z;
        algorithm
          z := if x > Maxexp then exp(Maxexp)*(1 + x - Maxexp) else exp(x);
        end exlin;

        function exlin2 "Exponential function linearly continued for x < MinExp and x > Maxexp"
          extends Modelica.Icons.Function;
          input Real x;
          input Real Minexp;
          input Real Maxexp;
          output Real z;
        algorithm
          z := if x < Minexp then exp(Minexp)*(1 + x - Minexp) else exlin(x, Maxexp);
        end exlin2;

public
  model Thyristor "Simple Thyristor Model"
    parameter SI.Voltage VDRM(final min=0) = 100
      "Forward breakthrough voltage";
    parameter SI.Voltage VRRM(final min=0) = 100
      "Reverse breakthrough voltage";
    parameter SI.Current IDRM=0.1 "Saturation current";
    parameter SI.Voltage VTM= 1.7 "Conducting voltage";
    parameter SI.Current IH=6e-3 "Holding current";
    parameter SI.Current ITM= 25 "Conducting current";

    parameter SI.Voltage VGT= 0.7 "Gate trigger voltage";
    parameter SI.Current IGT= 5e-3 "Gate trigger current";

    parameter SI.Time TON = 1e-6 "Switch on time";
    parameter SI.Time TOFF = 15e-6 "Switch off time";
    parameter SI.Voltage Vt=0.04
      "Voltage equivalent of temperature (kT/qn)";
    parameter Real Nbv=0.74 "Reverse Breakthrough emission coefficient";
   extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort;
    SI.Current iGK "Gate current";
    SI.Voltage vGK "Voltage between gate and cathode";
    SI.Voltage vAK "Voltage between anode and cathode";
    SI.Voltage vControl(start=0);
    SI.Voltage vContot;
    SI.Voltage vConmain;

  public
    Modelica.Electrical.Analog.Interfaces.PositivePin Anode annotation (Placement(
          transformation(extent={{-95,-12},{-75,8}}),
                                                    iconTransformation(extent={{
              -100,-10},{-80,10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin Cathode annotation (Placement(
          transformation(extent={{80,-10},{100,10}}), iconTransformation(extent={
              {80,-10},{100,10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin Gate annotation (Placement(
          transformation(extent={{90,90},{110,110}}),iconTransformation(extent={{90,90},{110,110}})));

  protected
    parameter SI.Voltage Von=5;
    parameter SI.Voltage Voff= 1.5;
    parameter SI.Resistance Ron=(VTM-0.7)/ITM
      "Forward conducting mode resistance";
    parameter SI.Resistance Roff=(VDRM^2)/VTM/IH
      "Blocking mode resistance";

  equation
    //Kirchhoff's equations
    Anode.i+Gate.i+Cathode.i=0;
    vGK=Gate.v-Cathode.v;
    vAK=Anode.v-Cathode.v;

    // Gate and Control voltage
    iGK = Gate.i;
    vGK = smooth(0,(if vGK < 0.65 then VGT/IGT*iGK else
          0.65^2/VGT+iGK*(VGT-0.65)/IGT));
    vContot = vConmain + smooth(0, if iGK < 0.95 * IGT then 0 else if iGK < 0.95*IGT + 1e-3 then 10000*(iGK-0.95*IGT)*vAK else 10* vAK);
    der(vControl)= (vContot - vControl) / (if (vContot - vControl) > 0 then 1.87*TON else 0.638*TOFF);

    // Anode-Cathode characteristics
    Anode.i= smooth(1, if vAK < -VRRM then -VRRM/Roff*exp(-(vAK+VRRM)/(Nbv*Vt)) else
           if vControl<Voff then vAK/Roff else
           if vControl<Von then vAK/(sqrt(Ron*Roff)*(Ron/Roff)^((3*((2*vControl-Von-Voff)/(2*(Von-Voff)))-4*((2*vControl-Von-Voff)/(2*(Von-Voff)))^3)/2)) else
            vAK/Ron);

    // holding effect and forward breakthrough
    vConmain = (if Anode.i>IH or vAK>VDRM then Von else 0);
    LossPower = Anode.i*Anode.v + Cathode.i*Cathode.v + Gate.i*Gate.v;
   annotation (
     Documentation(info="<html>
<p>This is a simple thyristor model with three pins: Anode, Cathode and Gate. There are three operating modes:conducting, blocking and reverse breakthrough.
<br>As long as the thyristor is in blocking mode it behaves like a linear resistance Roff=VDRM^2/(VTM*IH). But if the voltage between anode and cathode exceeds VDRM or a positive gate current flows for a sufficient time the mode changes to conducting mode. The model stays in conducting mode until the anode current falls below the holding current IH. There is no way to switch off the thyristor via the gate. If the voltage between anode and cathode is negative, the model represents a diode (parameters Vt, Nbv) with reverse breakthrough voltage VRRM.</p>
<p>The dV/dt switch on is not taken into account in this model. The gate circuit is not influenced by the main circuit.</p>
</html>",
    revisions=
      "<html>
<ul>
<li><em>May 12, 2009   </em>
       by Matthias Franke
       </li>
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
          Line(points={{30,20},{100,90},{100,100}},
                                                 color={0,0,255}),
          Line(points={{40,50},{60,30}}, color={0,0,255}),
          Text(
            extent={{-150,-40},{150,-80}},
            textString="%name",
            lineColor={0,0,255})}),
     Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,0},{80,0}}, color={128,128,128}),
          Polygon(
            points={{70,4},{80,0},{70,-4},{70,4}},
            lineColor={128,128,128},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),
          Line(points={{0,80},{0,-80}}, color={128,128,128}),
          Polygon(
            points={{-4,70},{0,80},{4,70},{-4,70}},
            lineColor={128,128,128},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{5,81},{15,71}},
            lineColor={128,128,128},
            textString="i"),
          Text(
            extent={{70,-10},{80,-20}},
            lineColor={128,128,128},
            textString="v"),
          Line(
            points={{20,9},{20,0}},
            color={128,128,128},
            pattern=LinePattern.Dot),
          Text(
            extent={{25,64},{45,54}},
            lineColor={128,128,128},
            textString="Ron"),
          Line(
            points={{14,20},{25,73}},
            thickness=0.5),
          Line(
            points={{-57,-11},{55,9}},
            thickness=0.5),
          Line(
            points={{-57,-11},{-59,-13},{-60,-18},{-63,-65}},
            thickness=0.5),
          Text(
            extent={{-67,11},{-47,1}},
            lineColor={128,128,128},
            textString="VRRM"),
          Text(
            extent={{44,-2},{64,-12}},
            lineColor={128,128,128},
            textString="VDRM"),
          Line(
            points={{-57,1},{-57,-1}}),
          Line(
            points={{54,1},{54,-1}}),
          Line(
            points={{55,9},{54,11},{50,13},{17,17},{15,18},{14,20}},
            pattern=LinePattern.Dot),
          Text(
            extent={{-28,-9},{-8,-19}},
            lineColor={128,128,128},
            textString="Roff"),
          Line(
            points={{2,20},{-2,20}}),
          Text(
            extent={{-14,23},{-2,16}},
            lineColor={128,128,128},
            textString="IH")}));
  end Thyristor;

  model SimpleTriac "Simple triac, based on Semiconductors.Thyristor model"

    parameter SI.Voltage VDRM(final min=0) = 100
      "Forward breakthrough voltage";
    parameter SI.Voltage VRRM(final min=0) = 100
      "Reverse breakthrough voltage";
    parameter SI.Current IDRM=0.1 "Saturation current";
    parameter SI.Voltage VTM= 1.7 "Conducting voltage";
    parameter SI.Current IH=6e-3 "Holding current";
    parameter SI.Current ITM= 25 "Conducting current";

    parameter SI.Voltage VGT= 0.7 "Gate trigger voltage";
    parameter SI.Current IGT= 5e-3 "Gate trigger current";

    parameter SI.Time TON = 1e-6 "Switch on time";
    parameter SI.Time TOFF = 15e-6 "Switch off time";
    parameter SI.Voltage Vt=0.04
      "Voltage equivalent of temperature (kT/qn)";
    parameter Real Nbv=0.74 "Reverse Breakthrough emission coefficient";

    Modelica.Electrical.Analog.Interfaces.NegativePin n "Cathode"
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin p "Anode"
      annotation (Placement(transformation(extent={{94,-10},{114,10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin g "Gate"
      annotation (Placement(transformation(extent={{-110,-108},{-90,-88}}), iconTransformation(extent={{-110,-108},{-90,-88}})));
    Modelica.Electrical.Analog.Semiconductors.Thyristor thyristor(VDRM=VDRM, VRRM=VRRM, IDRM=IDRM, VTM=VTM, IH=IH, ITM=ITM, VGT=VGT, IGT=IGT, TON=TON, TOFF=TOFF, Vt=Vt, Nbv=Nbv, useHeatPort=useHeatPort, T=T)
      annotation (Placement(transformation(extent={{-20,30},{0,50}})));
    Modelica.Electrical.Analog.Semiconductors.Thyristor thyristor1(VDRM=VDRM, VRRM=VRRM, IDRM=IDRM, VTM=VTM, IH=IH, ITM=ITM, VGT=VGT, IGT=IGT, TON=TON, TOFF=TOFF, Vt=Vt, Nbv=Nbv, useHeatPort=useHeatPort, T=T)
                         annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-12,-40})));

    Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode(Vknee=0)
      annotation (Placement(transformation(extent={{-40,58},{-20,78}})));
    Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode1(Vknee=0) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-20,-72})));

  parameter Boolean useHeatPort = false "=true, if HeatPort is enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Temperature T=293.15
      "Fixed device temperature if useHeatPort = false" annotation(Dialog(enable=not useHeatPort));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort
      annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
          iconTransformation(extent={{-10,-110},{10,-90}})));

  equation
    if useHeatPort then
     connect(heatPort, thyristor.heatPort);
     connect(heatPort, thyristor1.heatPort);
   end if;
    connect(thyristor.Anode, n) annotation (Line(
        points={{-19,40},{-18,40},{-18,48},{-70,48},{-70,0},{-100,0}}, color={0,0,255}));
    connect(thyristor1.Anode, p) annotation (Line(
        points={{-3,-40},{-2,-40},{-2,-60},{80,-60},{80,0},{104,0}}, color={0,0,255}));
    connect(thyristor1.Anode, thyristor.Cathode) annotation (Line(
        points={{-3,-40},{-2,-40},{-2,40},{-1,40}}, color={0,0,255}));
    connect(thyristor1.Cathode, thyristor.Anode) annotation (Line(
        points={{-21,-40},{-22,-40},{-22,40},{-19,40}}, color={0,0,255}));
    connect(thyristor.Gate, idealDiode.n) annotation (Line(
        points={{0,50},{0,59.5},{-20,59.5},{-20,68}}, color={0,0,255}));
    connect(idealDiode.p, g) annotation (Line(
        points={{-40,68},{-82,68},{-82,-98},{-100,-98}}, color={0,0,255}));
    connect(idealDiode1.n, thyristor1.Gate) annotation (Line(
        points={{-20,-62},{-20,-50},{-22,-50}}, color={0,0,255}));
    connect(idealDiode1.p, g) annotation (Line(
        points={{-20,-82},{-42,-82},{-42,-98},{-100,-98}}, color={0,0,255}));
    annotation (defaultComponentName="triac",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Polygon(
            points={{-30,0},{-30,-100},{70,-50},{-30,0}},
            lineColor={0,0,255}),
          Polygon(
            points={{70,100},{70,0},{-30,50},{70,100}},
            lineColor={0,0,255}),
          Line(
            points={{70,0},{70,-100}},
            color={0,0,255}),
          Line(
            points={{-30,0},{-30,100}},
            color={0,0,255}),
          Line(
            points={{-30,0},{-90,0}},
            color={0,0,255}),
          Line(
            points={{70,0},{110,0}},
            color={0,0,255}),
          Line(
            points={{-100,-88},{-100,-80},{-30,-50}},
            color={0,0,255}),
          Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255})}),
      Documentation(info="<html>
<p>This is a simple TRIAC model based on the extended thyristor model Modelica.Electrical.Analog.Semiconductors.Thyristor.
<br>Two thyristors are contrarily connected in parallel, whereas each transistor is connected with a diode.
<br>Further information regarding the electrical component TRIAC can be detected in documentation of the ideal TRIAC model.
<br>As an additional information: this model is based on the Modelica.Electrical.Analog.Semiconductors.Thyristor.</p>
<p><strong>Attention:</strong> The model seems to be very sensitive with respect to the choice of some parameters (e.g., VDRM, VRRM). This is caused by the thyristor model. Further investigations are necessary.</p>
</html>",
     revisions="<html>
<ul>
<li><em>November 25, 2009   </em><br>

       by Susann Wolf<br><br>
       </li>
</ul>
</html>"));
  end SimpleTriac;

  annotation (
    Documentation(info="<html>
<p>This package contains semiconductor devices:</p>
<ul>
<li>diode</li>
<li>MOS transistors</li>
<li>bipolar transistors</li>
<li>thyristor</li>
<li>triac</li>
</ul>
<p>Most of the semiconductor devices contain a conditional heat port, which is not active by default. If it is active the loss power is calculated to be used in a thermal net. The heating variants of the semiconductor devices are provided to use the thermal port temperature in the electric calculation. That means that for a true thermal electric interaction the heating device models have to be used.</p>
</html>",
   revisions="<html>
<dl>
<dt>
<strong>Main Authors:</strong>
</dt>
<dd>
Christoph Clau&szlig;
    &lt;<a href=\"mailto:christoph@clauss-it.com\">christoph@clauss-it.com</a>&gt;<br>
    Andr&eacute; Schneider
    &lt;<a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden
</dl>
</html>"), Icon(graphics={
          Line(points={{-20,0},{-90,0}}),
          Line(points={{-20,60},{-20,-60}}),
          Line(points={{20,68},{-20,28}}),
          Line(points={{80,68},{20,68}}),
          Line(points={{-20,-30},{20,-70}}),
          Line(points={{20,-70},{80,-70}})}));
end Semiconductors;
