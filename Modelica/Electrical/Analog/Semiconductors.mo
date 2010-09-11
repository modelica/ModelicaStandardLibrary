within Modelica.Electrical.Analog;
package Semiconductors
  "Semiconductor devices such as diode, MOS and bipolar transistor"
  extends Modelica.Icons.Package;
  import Modelica.SIunits;

  model Diode "Simple diode"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter SIunits.Current Ids=1.e-6 "Saturation current";
    parameter SIunits.Voltage Vt=0.04
      "Voltage equivalent of temperature (kT/qn)";
    parameter Real Maxexp(final min=Modelica.Constants.small) = 15
      "Max. exponent for linear continuation";
    parameter SIunits.Resistance R=1.e8 "Parallel ohmic resistance";
    extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(
       T=293.15);
  equation
    i = smooth(1,(if (v/Vt > Maxexp) then Ids*(exp(Maxexp)*(1 + v/Vt - Maxexp) - 1) +
      v/R else Ids*(exp(v/Vt) - 1) + v/R));
    LossPower = v*i;
    annotation (
      Documentation(info="<html>
<p>The simple diode is a one port. It consists of the diode itself and an parallel ohmic resistance <i>R</i>. The diode formula is:</p>
<pre>                v/vt
  i  =  ids ( e      - 1).</pre>
<p><br/>If the exponent <i>v/vt</i> reaches the limit <i>maxex</i>, the diode characterisic is linearly continued to avoid overflow.</p><p><br/><b>Please note:</b> In case of useHeatPort=true the temperature dependence of the electrical behavior is <b>not </b>modelled yet. The parameters are not temperature dependent.</p>
</html>",
   revisions="<html>
<ul>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><i> November 15, 2005   </i>
       by Christoph Clauss<br> smooth function added<br>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Polygon(
            points={{30,0},{-30,40},{-30,-40},{30,0}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{40,0}}, color={0,0,255}),
          Line(points={{40,0},{90,0}}, color={0,0,255}),
          Line(points={{30,40},{30,-40}}, color={0,0,255}),
          Text(
            extent={{-150,-49},{149,-77}},
            lineColor={0,0,0},
            textString="Vt=%Vt"),
          Text(
            extent={{-154,100},{146,60}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,-20}},
            color={127,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dot)}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Polygon(
            points={{30,0},{-30,40},{-30,-40},{30,0}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.None),
          Line(points={{-96,0},{40,0}}, color={0,0,255}),
          Line(points={{40,0},{96,0}}, color={0,0,255}),
          Line(points={{30,40},{30,-40}}, color={0,0,255})}));
  end Diode;

 model ZDiode "Zener diode with 3 working areas"
   extends Modelica.Electrical.Analog.Interfaces.OnePort;
   parameter Modelica.SIunits.Current Ids=1.e-6 "Saturation current";
   parameter Modelica.SIunits.Voltage Vt=0.04
      "Voltage equivalent of temperature (kT/qn)";
   parameter Real Maxexp(final min=Modelica.Constants.small) = 30
      "Max. exponent for linear continuation";
   parameter Modelica.SIunits.Resistance R=1.e8 "Parallel ohmic resistance";
   parameter Modelica.SIunits.Voltage Bv=5.1
      "Breakthrough voltage = Zener- or Z-voltage";
   parameter Modelica.SIunits.Current Ibv=0.7 "Breakthrough knee current";
   parameter Real Nbv=0.74 "Breakthrough emission coefficient";
   extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(
      T=293.15);

   Real maxexp=exp(Maxexp);
 equation
    i = smooth(1, if (v>Maxexp*Vt) then
              Ids*( exp(Maxexp)*(1 + v/Vt - Maxexp)-1) + v/R else
           if ( (v+Bv)<-Maxexp*(Nbv*Vt)) then
              -Ids -Ibv* exp(Maxexp)*(1 - (v+Bv)/(Nbv*Vt) - Maxexp) +v/R else
              Ids*(exp(v/Vt)-1) - Ibv*exp(-(v+Bv)/(Nbv*Vt)) + v/R);
    LossPower = v*i;
          annotation (__Dymola_structurallyIncomplete=true,
            Documentation(info="<html>
<p>The simple zener diode is a one port. It consists of the diode itself and an parallel ohmic resistance <i>R</i>. The diode formula is:</p>
<pre>                v/Vt                -(v+Bv)/(Nbv*Vt)
  i  =  Ids ( e      - 1) - Ibv ( e                  ).</pre>
<p>If the exponent in one of the two branches reaches the limit <i>Maxexp</i>, the diode characterisic is linearly continued to avoid overflow.</p>
<p><br/>The zener diode model permits (in contrast to the simple diode model) current in reverse direction if the breakdown voltage Bv (also known zener knee voltage) is exceeded.</p>
<p>The thermal power is calculated by <i>i*v</i>.</p><p><b>Please note:</b> In case of useHeatPort=true the temperature dependence of the electrical behavior is <b>not </b>modelled yet. The parameters are not temperature dependent.</p>
</html>",  revisions="<html>
<ul>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><i>April 5, 2004   </i>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"),  Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Polygon(
            points={{30,0},{-30,40},{-30,-40},{30,0}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{40,0}}, color={0,0,255}),
          Line(points={{40,0},{90,0}}, color={0,0,255}),
          Line(points={{30,40},{30,-40}}, color={0,0,255}),
          Text(
            extent={{-152,114},{148,74}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-101},{0,-20}},
            color={127,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dot)}),
            Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Polygon(
            points={{30,0},{-30,40},{-30,-40},{30,0}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.None),
          Line(points={{-99,0},{39,0}}, color={0,0,255}),
          Line(points={{40,0},{96,0}}, color={0,0,255}),
          Line(points={{30,40},{30,-40}}, color={0,0,255})}));
 end ZDiode;

model PMOS "Simple MOS Transistor"

  Interfaces.Pin D "Drain" annotation (Placement(transformation(extent={{90,
            40},{110,60}}, rotation=0)));
  Interfaces.Pin G "Gate" annotation (Placement(transformation(extent={{-90,
            -40},{-110,-60}}, rotation=0)));
  Interfaces.Pin S "Source" annotation (Placement(transformation(extent={{90,
            -40},{110,-60}}, rotation=0)));
  Interfaces.Pin B "Bulk" annotation (Placement(transformation(extent={{90,
            -10},{110,10}}, rotation=0)));
  parameter SIunits.Length W=20.0e-6 "Width";
  parameter SIunits.Length L=6.0e-6 "Length";
  parameter SIunits.Transconductance Beta=0.0105e-3
      "Transconductance parameter";
  parameter SIunits.Voltage Vt=-1.0 "Zero bias threshold voltage";
  parameter Real K2=0.41 "Bulk threshold parameter";
  parameter Real K5=0.839 "Reduction of pinch-off region";
  parameter SIunits.Length dW=-2.5e-6 "Narrowing of channel";
  parameter SIunits.Length dL=-2.1e-6 "Shortening of channel";
  parameter SIunits.Resistance RDS=1.e+7 "Drain-Source-Resistance";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(
     T=293.15);
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
  assert( L + dL > 0, "PMOS: Effective length must be positive");
  assert( W + dW > 0, "PMOS: Effective width  must be positive");
  gds = if (RDS < 1.e-20 and RDS > -1.e-20) then 1.e20 else 1/RDS;
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
    Documentation(info="
<HTML>
<P>
The PMOS model is a simple model of a p-channel metal-oxide semiconductor
FET. It differs slightly from the device used in the SPICE simulator.
For more details please care for H. Spiro.
</P>
<P>
The model does not consider capacitances. A high drain-source resistance RDS
is included to avoid numerical difficulties.
<br> <br>
<b>Please note:</b>
In case of useHeatPort=true the temperature dependence of the electrical
behavior is <b> not </b> modelled yet. The parameters are not temperature dependent.
</P>
<DL>
<DT><b>References:</b>
<DD>Spiro, H.: Simulation integrierter Schaltungen. R. Oldenbourg Verlag
  Muenchen Wien 1990.
</DL>
<P>
Some typical parameter sets are:
</P>
<PRE>
  W       L      Beta        Vt       K2       K5       DW         DL
  m       m      A/V^2       V        -        -        m          m
  50.e-6  8.e-6  0.0085e-3   -.15     0.41      0.839    -3.8e-6    -4.0e-6
  20.e-6  6.e-6  0.0105e-3  -1.0      0.41      0.839    -2.5e-6    -2.1e-6
  30.e-6  5.e-6  0.0059e-3   -.3      0.98     1.01      0         -3.9e-6
  30.e-6  5.e-6  0.0152e-3   -.69     0.104    1.1       -.8e-6     -.4e-6
  30.e-6  5.e-6  0.0163e-3   -.69     0.104    1.1       -.8e-6     -.4e-6
  30.e-6  5.e-6  0.0182e-3   -.69     0.086    1.06      -.1e-6     -.6e-6
  20.e-6  6.e-6  0.0074e-3  -1.       0.4       0.59      0          0
</PRE>

</HTML>
",
 revisions="<html>
<ul>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><i>December 7, 2005   </i>
       by Christoph Clauss<br>
       error in RDS calculation deleted</li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
          Line(points={{-90,-50},{-10,-50}}, color={0,0,255}),
          Line(points={{-10,-50},{-10,50}}, color={0,0,255}),
          Line(points={{10,70},{10,29}}, color={0,0,255}),
          Line(points={{10,20},{10,-21}}, color={0,0,255}),
          Line(points={{10,-30},{10,-71}}, color={0,0,255}),
          Line(points={{10,50},{91,50}}, color={0,0,255}),
          Line(points={{10,0},{90,0}}, color={0,0,255}),
          Line(points={{10,-50},{90,-50}}, color={0,0,255}),
          Polygon(
            points={{60,0},{40,5},{40,-5},{60,0}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{-149,117},{151,77}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-90},{0,0}},
            color={127,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dot)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
          Line(points={{-96,-50},{-10,-50}}, color={0,0,255}),
          Line(points={{-10,-50},{-10,50}}, color={0,0,255}),
          Line(points={{10,70},{10,29}}, color={0,0,255}),
          Line(points={{10,20},{10,-21}}, color={0,0,255}),
          Line(points={{10,-30},{10,-71}}, color={0,0,255}),
          Line(points={{10,50},{96,50}}, color={0,0,255}),
          Line(points={{10,0},{96,0}}, color={0,0,255}),
          Line(points={{10,-50},{96,-50}}, color={0,0,255}),
          Polygon(
            points={{60,0},{40,5},{40,-5},{60,0}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255})}));
end PMOS;

model NMOS "Simple MOS Transistor"

  Interfaces.Pin D "Drain" annotation (Placement(transformation(extent={{90,
            40},{110,60}}, rotation=0)));
  Interfaces.Pin G "Gate" annotation (Placement(transformation(extent={{-90,
            -40},{-110,-60}}, rotation=0)));
  Interfaces.Pin S "Source" annotation (Placement(transformation(extent={{90,
            -40},{110,-60}}, rotation=0)));
  Interfaces.Pin B "Bulk" annotation (Placement(transformation(extent={{90,
            -10},{110,10}}, rotation=0)));
  parameter SIunits.Length W=20.e-6 "Width";
  parameter SIunits.Length L=6.e-6 "Length";
  parameter SIunits.Transconductance Beta=0.041e-3 "Transconductance parameter";
  parameter SIunits.Voltage Vt=0.8 "Zero bias threshold voltage";
  parameter Real K2=1.144 "Bulk threshold parameter";
  parameter Real K5=0.7311 "Reduction of pinch-off region";
  parameter SIunits.Length dW=-2.5e-6 "narrowing of channel";
  parameter SIunits.Length dL=-1.5e-6 "shortening of channel";
  parameter SIunits.Resistance RDS=1.e+7 "Drain-Source-Resistance";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(                    T=293.15);
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
  assert( L + dL > 0, "NMOS: Effective length must be positive");
  assert( W + dW > 0, "NMOS: Effective width  must be positive");
  gds = if (RDS < 1.e-20 and RDS > -1.e-20) then 1.e20 else 1/RDS;
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
    Documentation(info="
<HTML>
<P>
The NMos model is a simple model of a n-channel metal-oxide semiconductor
FET. It differs slightly from the device used in the SPICE simulator.
For more details please care for H. Spiro.
</P>
<P>
The model does not consider capacitances. A high drain-source resistance RDS
is included to avoid numerical difficulties.
<br> <br>
<b>Please note:</b>
In case of useHeatPort=true the temperature dependence of the electrical
behavior is <b> not </b> modelled yet. The parameters are not temperature dependent.
</P>
<P>
<PRE>
  W       L      Beta        Vt       K2      K5       DW         DL
  m       m      A/V^2       V        -       -        m          m
  12.e-6  4.e-6  0.062e-3   -4.5      0.24     0.61     -1.2e-6     -.9e-6      depletion
  60.e-6  3.e-6  0.048e-3     0.1      0.08     0.68     -1.2e-6     -.9e-6      enhancement
  12.e-6  4.e-6  0.0625e-3   -.8      0.21     0.78     -1.2e-6     -.9e-6      zero
  50.e-6  8.e-6  0.0299e-3    0.24    1.144    0.7311   -5.4e-6    -4.e-6
  20.e-6  6.e-6  0.041e-3     0.8     1.144    0.7311   -2.5e-6    -1.5e-6
  30.e-6  9.e-6  0.025e-3   -4.       0.861    0.878    -3.4e-6    -1.74e-6
  30.e-6  5.e-6  0.031e-3     0.6     1.5      0.72      0         -3.9e-6
  50.e-6  6.e-6  0.0414e-3  -3.8      0.34     0.8      -1.6e-6    -2.e-6       depletion
  50.e-6  5.e-6  0.03e-3      0.37     0.23     0.86     -1.6e-6    -2.e-6       enhancement
  50.e-6  6.e-6  0.038e-3    -.9      0.23     0.707    -1.6e-6    -2.e-6       zero
  20.e-6  4.e-6  0.06776e-3   0.5409   0.065    0.71      -.8e-6     -.2e-6
  20.e-6  4.e-6  0.06505e-3   0.6209   0.065    0.71      -.8e-6     -.2e-6
  20.e-6  4.e-6  0.05365e-3   0.6909   0.03     0.8       -.3e-6     -.2e-6
  20.e-6  4.e-6  0.05365e-3   0.4909   0.03     0.8       -.3e-6     -.2e-6
  12.e-6  4.e-6  0.023e-3   -4.5      0.29     0.6       0          0           depletion
  60.e-6  3.e-6  0.022e-3     0.1      0.11     0.65      0          0           enhancement
  12.e-6  4.e-6  0.038e-3    -.8      0.33     0.6       0          0           zero
  20.e-6  6.e-6  0.022e-3     0.8     1        0.66      0          0
</PRE>

<P>
<DL>
<DT><b>References:</b>
<DD>Spiro, H.: Simulation integrierter Schaltungen. R. Oldenbourg Verlag
Muenchen Wien 1990.
</DL>
</HTML>
",
 revisions="<html>
<ul>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><i>December 7, 2005   </i>
       by Christoph Clauss<br>
       error in RDS calculation deleted</li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
          Line(points={{-90,-50},{-10,-50}}, color={0,0,255}),
          Line(points={{-10,-50},{-10,50}}, color={0,0,255}),
          Line(points={{10,70},{10,29}}, color={0,0,255}),
          Line(points={{10,20},{10,-21}}, color={0,0,255}),
          Line(points={{10,-30},{10,-71}}, color={0,0,255}),
          Line(points={{10,50},{91,50}}, color={0,0,255}),
          Line(points={{10,0},{90,0}}, color={0,0,255}),
          Line(points={{10,-50},{90,-50}}, color={0,0,255}),
          Polygon(
            points={{40,0},{60,5},{60,-5},{40,0}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{-155,119},{145,79}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,0}},
            color={127,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dot)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
          Line(points={{-96,-50},{-10,-50}}, color={0,0,255}),
          Line(points={{-10,-50},{-10,50}}, color={0,0,255}),
          Line(points={{10,70},{10,29}}, color={0,0,255}),
          Line(points={{10,20},{10,-21}}, color={0,0,255}),
          Line(points={{10,-30},{10,-71}}, color={0,0,255}),
          Line(points={{10,50},{96,50}}, color={0,0,255}),
          Line(points={{10,0},{96,0}}, color={0,0,255}),
          Line(points={{10,-50},{96,-50}}, color={0,0,255}),
          Polygon(
            points={{40,0},{60,5},{60,-5},{40,0}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255})}));
end NMOS;

model NPN "Simple BJT according to Ebers-Moll"
  parameter Real Bf=50 "Forward beta";
  parameter Real Br=0.1 "Reverse beta";
  parameter SIunits.Current Is=1.e-16 "Transport saturation current";
  parameter SIunits.InversePotential Vak=0.02 "Early voltage (inverse), 1/Volt";
  parameter SIunits.Time Tauf=0.12e-9 "Ideal forward transit time";
  parameter SIunits.Time Taur=5e-9 "Ideal reverse transit time";
  parameter SIunits.Capacitance Ccs=1e-12 "Collector-substrat(ground) cap.";
  parameter SIunits.Capacitance Cje=0.4e-12
      "Base-emitter zero bias depletion cap.";
  parameter SIunits.Capacitance Cjc=0.5e-12
      "Base-coll. zero bias depletion cap.";
  parameter SIunits.Voltage Phie=0.8 "Base-emitter diffusion voltage";
  parameter Real Me=0.4 "Base-emitter gradation exponent";
  parameter SIunits.Voltage Phic=0.8 "Base-collector diffusion voltage";
  parameter Real Mc=0.333 "Base-collector gradation exponent";
  parameter SIunits.Conductance Gbc=1e-15 "Base-collector conductance";
  parameter SIunits.Conductance Gbe=1e-15 "Base-emitter conductance";
  parameter SIunits.Voltage Vt=0.02585 "Voltage equivalent of temperature";
  parameter Real EMin=-100 "if x < EMin, the exp(x) function is linearized";
  parameter Real EMax=40 "if x > EMax, the exp(x) function is linearized";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(
     T=293.15);
  protected
  Real vbc;
  Real vbe;
  Real qbk;
  Real ibc;
  Real ibe;
  Real cbc;
  Real cbe;
  Real ExMin;
  Real ExMax;
  Real Capcje;
  Real Capcjc;
  function pow "Just a helper function for x^y"
    input Real x;
    input Real y;
    output Real z;
  algorithm
    z:=x^y;
  end pow;
  public
  Modelica.Electrical.Analog.Interfaces.Pin C "Collector" annotation (Placement(
        transformation(extent={{90,40},{110,60}}, rotation=0)));
  Modelica.Electrical.Analog.Interfaces.Pin B "Base" annotation (Placement(
        transformation(extent={{-90,-10},{-110,10}}, rotation=0)));
  Modelica.Electrical.Analog.Interfaces.Pin E "Emitter" annotation (Placement(
        transformation(extent={{90,-40},{110,-60}}, rotation=0)));

equation
  ExMin = exp(EMin);
  ExMax = exp(EMax);
  vbc = B.v - C.v;
  vbe = B.v - E.v;
  qbk = 1 - vbc*Vak;

  ibc = smooth(1,if (vbc/Vt < EMin) then Is*(ExMin*(vbc/Vt - EMin + 1) - 1) + vbc*Gbc else
          if (vbc/Vt > EMax) then Is*(ExMax*(vbc/Vt - EMax + 1) - 1) + vbc*
    Gbc else Is*(exp(vbc/Vt) - 1) + vbc*Gbc);
  ibe = smooth(1,if (vbe/Vt < EMin) then Is*(ExMin*(vbe/Vt - EMin + 1) - 1) + vbe*Gbe else
          if (vbe/Vt > EMax) then Is*(ExMax*(vbe/Vt - EMax + 1) - 1) + vbe*
    Gbe else Is*(exp(vbe/Vt) - 1) + vbe*Gbe);
  Capcjc = smooth(1,(if (vbc/Phic > 0) then Cjc*(1 + Mc*vbc/Phic) else Cjc*pow(1 - vbc
    /Phic, -Mc)));
  Capcje = smooth(1,(if (vbe/Phie > 0) then Cje*(1 + Me*vbe/Phie) else Cje*pow(1 - vbe
    /Phie, -Me)));
  cbc = smooth(1,(if (vbc/Vt < EMin) then Taur*Is/Vt*ExMin*(vbc/Vt - EMin + 1) +
    Capcjc else if (vbc/Vt > EMax) then Taur*Is/Vt*ExMax*(vbc/Vt - EMax + 1)
     + Capcjc else Taur*Is/Vt*exp(vbc/Vt) + Capcjc));
  cbe = smooth(1,(if (vbe/Vt < EMin) then Tauf*Is/Vt*ExMin*(vbe/Vt - EMin + 1) +
    Capcje else if (vbe/Vt > EMax) then Tauf*Is/Vt*ExMax*(vbe/Vt - EMax + 1)
     + Capcje else Tauf*Is/Vt*exp(vbe/Vt) + Capcje));
  C.i = (ibe - ibc)*qbk - ibc/Br - cbc*der(vbc) + Ccs*der(C.v);
  B.i = ibe/Bf + ibc/Br + cbc*der(vbc) + cbe*der(vbe);
  E.i = -B.i - C.i + Ccs*der(C.v);

  LossPower = (C.v-E.v)*(ibe-ibc)*qbk + vbc*ibc/Br + vbe*ibe/Bf;
  annotation (
    Documentation(info="
<HTML>
<P>
This model is a simple model of a bipolar npn junction transistor according
to Ebers-Moll.
<br> <br>
<b>Please note:</b>
In case of useHeatPort=true the temperature dependence of the electrical
behavior is <b> not </b> modelled yet. The parameters are not temperature dependent.
</P>
<P>
A typical parameter set is:
</P>
<PRE>
  Bf  Br  Is     Vak  Tauf    Taur  Ccs   Cje     Cjc     Phie  Me   PHic   Mc     Gbc    Gbe    Vt
  -   -   A      V    s       s     F     F       F       V     -    V      -      mS     mS     V
  50  0.1 1e-16  0.02 0.12e-9 5e-9  1e-12 0.4e-12 0.5e-12 0.8   0.4  0.8    0.333  1e-15  1e-15  0.02585
</PRE>

<P>
<DL>
<DT><b>References:</b>
<DD>Vlach, J.; Singal, K.: Computer methods for circuit analysis and design.
Van Nostrand Reinhold, New York 1983
on page 317 ff.
</DL>
<P>
</HTML>
",
 revisions="<html>
<ul>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>

<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
          Line(points={{-10,40},{-10,-40}}, color={0,0,255}),
          Line(points={{-10,0},{-90,0}}, color={0,0,255}),
          Line(points={{91,50},{30,50}}, color={0,0,255}),
          Line(points={{30,50},{-10,10}}, color={0,0,255}),
          Line(points={{-10,-10},{30,-50}}, color={0,0,255}),
          Line(points={{30,-50},{91,-50}}, color={0,0,255}),
          Polygon(
            points={{30,-50},{24,-36},{16,-44},{30,-50}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{-152,117},{148,77}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,-20}},
            color={127,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dot)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
          Line(points={{-10,40},{-10,-40}}, color={0,0,255}),
          Line(points={{-10,0},{-100,0}}, color={0,0,255}),
          Line(points={{30,50},{-10,10}}, color={0,0,255}),
          Line(points={{-10,-10},{30,-50}}, color={0,0,255}),
          Line(points={{30,-50},{100,-50}}, color={0,0,255}),
          Line(points={{100,50},{30,50}}, color={0,0,255}),
          Polygon(
            points={{30,-50},{24,-36},{16,-44},{30,-50}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255})}));
end NPN;

model PNP "Simple BJT according to Ebers-Moll"
  parameter Real Bf=50 "Forward beta";
  parameter Real Br=0.1 "Reverse beta";
  parameter SIunits.Current Is=1.e-16 "Transport saturation current";
  parameter SIunits.InversePotential Vak=0.02 "Early voltage (inverse), 1/Volt";
  parameter SIunits.Time Tauf=0.12e-9 "Ideal forward transit time";
  parameter SIunits.Time Taur=5e-9 "Ideal reverse transit time";
  parameter SIunits.Capacitance Ccs=1e-12 "Collector-substrat(ground) cap.";
  parameter SIunits.Capacitance Cje=0.4e-12
      "Base-emitter zero bias depletion cap.";
  parameter SIunits.Capacitance Cjc=0.5e-12
      "Base-coll. zero bias depletion cap.";
  parameter SIunits.Voltage Phie=0.8 "Base-emitter diffusion voltage";
  parameter Real Me=0.4 "Base-emitter gradation exponent";
  parameter SIunits.Voltage Phic=0.8 "Base-collector diffusion voltage";
  parameter Real Mc=0.333 "Base-collector gradation exponent";
  parameter SIunits.Conductance Gbc=1e-15 "Base-collector conductance";
  parameter SIunits.Conductance Gbe=1e-15 "Base-emitter conductance";
  parameter SIunits.Voltage Vt=0.02585 "Voltage equivalent of temperature";
  parameter Real EMin=-100 "if x < EMin, the exp(x) function is linearized";
  parameter Real EMax=40 "if x > EMax, the exp(x) function is linearized";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(                     T=293.15);
  protected
  Real vbc;
  Real vbe;
  Real qbk;
  Real ibc;
  Real ibe;
  Real cbc;
  Real cbe;
  Real ExMin;
  Real ExMax;
  Real Capcje;
  Real Capcjc;
  function pow "Just a helper function for x^y"
    input Real x;
    input Real y;
    output Real z;
  algorithm
    z:=x^y;
  end pow;
  public
  Modelica.Electrical.Analog.Interfaces.Pin C "Collector" annotation (Placement(
        transformation(extent={{90,40},{110,60}}, rotation=0)));
  Modelica.Electrical.Analog.Interfaces.Pin B "Base" annotation (Placement(
        transformation(extent={{-90,-10},{-110,10}}, rotation=0)));
  Modelica.Electrical.Analog.Interfaces.Pin E "Emitter" annotation (Placement(
        transformation(extent={{90,-40},{110,-60}}, rotation=0)));
equation
  ExMin = exp(EMin);
  ExMax = exp(EMax);
  vbc = C.v - B.v;
  vbe = E.v - B.v;
  qbk = 1 - vbc*Vak;

  ibc = smooth(1,(if (vbc/Vt < EMin) then Is*(ExMin*(vbc/Vt - EMin + 1) - 1) + vbc*Gbc else
          if (vbc/Vt > EMax) then Is*(ExMax*(vbc/Vt - EMax + 1) - 1) + vbc*
    Gbc else Is*(exp(vbc/Vt) - 1) + vbc*Gbc));

  ibe = smooth(1,(if (vbe/Vt < EMin) then Is*(ExMin*(vbe/Vt - EMin + 1) - 1) + vbe*Gbe else
          if (vbe/Vt > EMax) then Is*(ExMax*(vbe/Vt - EMax + 1) - 1) + vbe*
    Gbe else Is*(exp(vbe/Vt) - 1) + vbe*Gbe));

  Capcjc = smooth(1,(if (vbc/Phic > 0) then Cjc*(1 + Mc*vbc/Phic) else Cjc*pow(1 - vbc
    /Phic, -Mc)));
  Capcje = smooth(1,if (vbe/Phie > 0) then Cje*(1 + Me*vbe/Phie) else Cje*pow(1 - vbe
    /Phie, -Me));
  cbc = smooth(1,(if (vbc/Vt < EMin) then Taur*Is/Vt*ExMin*(vbc/Vt - EMin + 1) +
    Capcjc else if (vbc/Vt > EMax) then Taur*Is/Vt*ExMax*(vbc/Vt - EMax + 1)
     + Capcjc else Taur*Is/Vt*exp(vbc/Vt) + Capcjc));
  cbe = smooth(1,(if (vbe/Vt < EMin) then Tauf*Is/Vt*ExMin*(vbe/Vt - EMin + 1) +
    Capcje else if (vbe/Vt > EMax) then Tauf*Is/Vt*ExMax*(vbe/Vt - EMax + 1)
     + Capcje else Tauf*Is/Vt*exp(vbe/Vt) + Capcje));
  C.i = -((ibe - ibc)*qbk - ibc/Br - cbc*der(vbc) - Ccs*der(C.v));
  B.i = -(ibe/Bf + ibc/Br + cbe*der(vbe) + cbc*der(vbc));
  E.i = -B.i - C.i + Ccs*der(C.v);

  LossPower = (E.v-C.v)*(ibe-ibc)*qbk + vbc*ibc/Br + vbe*ibe/Bf;
                                                                    annotation (
    Documentation(info="
<HTML>
<P>
This model is a simple model of a bipolar pnp junction transistor according
to Ebers-Moll.
<br> <br>
<b>Please note:</b>
In case of useHeatPort=true the temperature dependence of the electrical
behavior is <b> not </b> modelled yet. The parameters are not temperature dependent.
<P>
A typical parameter set is:
</P>
<PRE>
  Bf  Br  Is     Vak  Tauf    Taur  Ccs   Cje     Cjc     Phie  Me   PHic   Mc     Gbc    Gbe    Vt
  -   -   A      V    s       s     F     F       F       V     -    V      -      mS     mS     V
  50  0.1 1e-16  0.02 0.12e-9 5e-9  1e-12 0.4e-12 0.5e-12 0.8   0.4  0.8    0.333  1e-15  1e-15  0.02585
</PRE>

<P>
<DL>
<DT><b>References:</b>
<DD>Vlach, J.; Singal, K.: Computer methods for circuit analysis and design.
Van Nostrand Reinhold, New York 1983
on page 317 ff.
</DL>
<P>
</HTML>
",
 revisions="<html>
<ul>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>

<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
          Line(points={{-10,40},{-10,-40}}, color={0,0,255}),
          Line(points={{-10,0},{-90,0}}, color={0,0,255}),
          Line(points={{91,50},{30,50}}, color={0,0,255}),
          Line(points={{30,50},{-10,10}}, color={0,0,255}),
          Line(points={{-10,-10},{30,-50}}, color={0,0,255}),
          Line(points={{30,-50},{91,-50}}, color={0,0,255}),
          Polygon(
            points={{-10,-10},{5,-17},{-3,-25},{-10,-10}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{-158,119},{142,79}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,-20}},
            color={127,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dot)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
          Line(points={{-10,40},{-10,-40}}, color={0,0,255}),
          Line(points={{-10,0},{-99,0}}, color={0,0,255}),
          Line(points={{100,50},{30,50}}, color={0,0,255}),
          Line(points={{30,50},{-10,10}}, color={0,0,255}),
          Line(points={{-10,-10},{30,-50}}, color={0,0,255}),
          Line(points={{30,-50},{99,-50}}, color={0,0,255}),
          Polygon(
            points={{-10,-10},{5,-17},{-3,-25},{-10,-10}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255})}));
end PNP;

model HeatingDiode "Simple diode with heating port"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter Modelica.SIunits.Current Ids=1.e-6 "Saturation current";
  /* parameter Modelica.SIunits.Voltage Vt=0.04 "Voltage equivalent of temperature (kT/qn)"; */
  parameter Real Maxexp(final min=Modelica.Constants.small) = 15
      "Max. exponent for linear continuation";
  parameter Modelica.SIunits.Resistance R=1.e8 "Parallel ohmic resistance";
  parameter Real EG=1.11 "activation energy";
  parameter Real N=1 "Emission coefficient";
  parameter Modelica.SIunits.Temperature TNOM=300.15
      "Parameter measurement temperature";
  parameter Real XTI=3 "Temperature exponent of saturation current";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(                    useHeatPort=true);

  Modelica.SIunits.Temperature vt_t "Temperature voltage";
  Modelica.SIunits.Current id "diode current";
  protected
  Real k=1.380662e-23 "Boltzmann's constant, J/K";
  Real q=1.6021892e-19 "Electron charge, As";
  Modelica.SIunits.Temperature htemp "auxiliary temperature";
  Real aux;
  Real auxp;
  Real maxexp=exp(Maxexp);
equation
  assert( T_heatPort > 0,"temperature must be positive");
  htemp = T_heatPort;
  vt_t = k*htemp/q;

  id = exlin((v/(N*vt_t)), Maxexp) - 1;

  aux = (htemp/TNOM - 1)*EG/(N*vt_t);
  auxp = exp(aux);

  i = Ids*id*pow(htemp/TNOM, XTI/N)*auxp + v/R;

  LossPower = i*v;
  annotation (__Dymola_structurallyIncomplete=true,
    Documentation(info="
<HTML>
<P>
The simple diode is an electrical one port, where a heat port is added, which is
defined in the Modelica.Thermal library. It consists of the diode itself and an parallel ohmic
resistance <i>R</i>. The diode formula is:
</P>
<PRE>
                v/vt_t
  i  =  ids ( e        - 1).
</PRE>
where vt_t depends on the temperature of the heat port:
<PRE>
  vt_t = k*temp/q
</PRE>
<P>
If the exponent <i>v/vt_t</i> reaches the limit <i>maxex</i>, the diode characterisic is linearly
continued to avoid overflow.<br>
The thermal power is calculated by <i>i*v</i>.
</P>
</HTML>
", revisions="<html>
<ul>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><i>April 5, 2004   </i>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(
  preserveAspectRatio=true,
  extent={{-100,-100},{100,100}},
  grid={1,1}), graphics={
          Polygon(
            points={{30,0},{-30,40},{-30,-40},{30,0}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{40,0}}, color={0,0,255}),
          Line(points={{40,0},{90,0}}, color={0,0,255}),
          Line(points={{30,40},{30,-40}}, color={0,0,255}),
          Text(
            extent={{-152,114},{148,74}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-101},{0,-20}},
            color={127,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dot)}),
    Diagram(coordinateSystem(
  preserveAspectRatio=true,
  extent={{-100,-100},{100,100}},
  grid={1,1}), graphics={
        Polygon(
          points={{30,0},{-30,40},{-30,-40},{30,0}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.None),
        Line(points={{-99,0},{39,0}}, color={0,0,255}),
        Line(points={{40,0},{96,0}}, color={0,0,255}),
        Line(points={{30,40},{30,-40}}, color={0,0,255})}));
end HeatingDiode;

        model HeatingNMOS "Simple MOS Transistor with heating port"

          Modelica.Electrical.Analog.Interfaces.Pin D "Drain"
            annotation (Placement(transformation(extent={{90,40},{110,60}},
            rotation=0)));
          Modelica.Electrical.Analog.Interfaces.Pin G "Gate"
            annotation (Placement(transformation(extent={{-90,-40},{-110,-60}},
            rotation=0)));
          Modelica.Electrical.Analog.Interfaces.Pin S "Source"
            annotation (Placement(transformation(extent={{90,-40},{110,-60}},
            rotation=0)));
          Modelica.Electrical.Analog.Interfaces.Pin B "Bulk"
            annotation (Placement(transformation(extent={{90,-10},{110,10}},
            rotation=0)));
          parameter Modelica.SIunits.Length W=20.e-6 "Width";
          parameter Modelica.SIunits.Length L=6.e-6 "Length";
          parameter Modelica.SIunits.Transconductance Beta=0.041e-3
      "Transconductance parameter";
          parameter Modelica.SIunits.Voltage Vt=0.8
      "Zero bias threshold voltage";
          parameter Real K2=1.144 "Bulk threshold parameter";
          parameter Real K5=0.7311 "Reduction of pinch-off region";
          parameter Modelica.SIunits.Length dW=-2.5e-6 "narrowing of channel";
          parameter Modelica.SIunits.Length dL=-1.5e-6 "shortening of channel";
          parameter Modelica.SIunits.Resistance RDS=1.e+7
      "Drain-Source-Resistance";
          parameter Modelica.SIunits.Temperature Tnom=300.15
      "Parameter measurement temperature";
          parameter Real kvt=-6.96e-3 "fitting parameter for Vt";
          parameter Real kk2=6.0e-4 "fitting parameter for K22";
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
          gds = if (RDS < 1.e-20 and RDS > -1.e-20) then 1.e20 else 1/RDS;
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
          annotation (__Dymola_structurallyIncomplete=true,
            Documentation(info="<html>
<p>The NMos model is a simple model of a n-channel metal-oxide semiconductor FET. It differs slightly from the device used in the SPICE simulator. For more details please care for H. Spiro.</p>
<p>A heating port is added for thermal electric simulation. The heating port is defined in the Modelica.Thermal library.</p>
<p>The model does not consider capacitances. A high drain-source resistance RDS is included to avoid numerical difficulties.</p>
<p>
<pre>  W       L      Beta        Vt       K2      K5       DW         DL
  m       m      A/V^2       V        -       -        m          m
  12.e-6  4.e-6  0.062e-3    -4.5     0.24    0.61     -1.2e-6    -0.9e-6    depletion
  60.e-6  3.e-6  0.048e-3     0.1     0.08    0.68     -1.2e-6    -0.9e-6    enhancement
  12.e-6  4.e-6  0.0625e-3   -0.8     0.21    0.78     -1.2e-6    -0.9e-6    zero
  50.e-6  8.e-6  0.0299e-3    0.24    1.144   0.7311   -5.4e-6    -4.e-6
  20.e-6  6.e-6  0.041e-3     0.8     1.144   0.7311   -2.5e-6    -1.5e-6
  30.e-6  9.e-6  0.025e-3    -4.0     0.861   0.878    -3.4e-6    -1.74e-6
  30.e-6  5.e-6  0.031e-3     0.6     1.5     0.72      0         -3.9e-6
  50.e-6  6.e-6  0.0414e-3   -3.8     0.34    0.8      -1.6e-6    -2.e-6     depletion
  50.e-6  5.e-6  0.03e-3      0.37    0.23    0.86     -1.6e-6    -2.e-6     enhancement
  50.e-6  6.e-6  0.038e-3    -0.9     0.23    0.707    -1.6e-6    -2.e-6     zero
  20.e-6  4.e-6  0.06776e-3   0.5409  0.065   0.71     -0.8e-6    -0.2e-6
  20.e-6  4.e-6  0.06505e-3   0.6209  0.065   0.71     -0.8e-6    -0.2e-6
  20.e-6  4.e-6  0.05365e-3   0.6909  0.03    0.8      -0.3e-6    -0.2e-6
  20.e-6  4.e-6  0.05365e-3   0.4909  0.03    0.8      -0.3e-6    -0.2e-6
  12.e-6  4.e-6  0.023e-3    -4.5     0.29    0.6       0          0         depletion
  60.e-6  3.e-6  0.022e-3     0.1     0.11    0.65      0          0         enhancement
  12.e-6  4.e-6  0.038e-3    -0.8     0.33    0.6       0          0         zero
  20.e-6  6.e-6  0.022e-3     0.8     1       0.66      0          0</pre></p>
<p><b>References:</b></p>
<p>Spiro, H.: Simulation integrierter Schaltungen. R. Oldenbourg Verlag Muenchen Wien 1990.</p>
</html>",  revisions="<html>
<ul>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><i>December 7, 2005   </i>
       by Christoph Clauss<br>
       error in RDS calculation deleted</li>
<li><i>March 31, 2004   </i>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"),  Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-90,-50},{-10,-50}}, color={0,0,255}),
          Line(points={{-10,-50},{-10,50}}, color={0,0,255}),
          Line(points={{10,70},{10,29}}, color={0,0,255}),
          Line(points={{10,20},{10,-21}}, color={0,0,255}),
          Line(points={{10,-30},{10,-71}}, color={0,0,255}),
          Line(points={{10,50},{91,50}}, color={0,0,255}),
          Line(points={{10,0},{90,0}}, color={0,0,255}),
          Line(points={{10,-50},{90,-50}}, color={0,0,255}),
          Polygon(
            points={{40,0},{60,5},{60,-5},{40,0}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{-152,118},{148,78}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,0}},
            color={127,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dot)}),
            Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-96,-50},{-10,-50}}, color={0,0,255}),
          Line(points={{-10,-50},{-10,50}}, color={0,0,255}),
          Line(points={{10,70},{10,29}}, color={0,0,255}),
          Line(points={{10,20},{10,-21}}, color={0,0,255}),
          Line(points={{10,-30},{10,-71}}, color={0,0,255}),
          Line(points={{10,50},{96,50}}, color={0,0,255}),
          Line(points={{10,0},{96,0}}, color={0,0,255}),
          Line(points={{10,-50},{96,-50}}, color={0,0,255}),
          Polygon(
            points={{40,0},{60,5},{60,-5},{40,0}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255})}));
        end HeatingNMOS;

        model HeatingPMOS "Simple PMOS Transistor with heating port"

          Modelica.Electrical.Analog.Interfaces.Pin D "Drain"
            annotation (Placement(transformation(extent={{90,40},{110,60}},
            rotation=0)));
          Modelica.Electrical.Analog.Interfaces.Pin G "Gate"
            annotation (Placement(transformation(extent={{-90,-40},{-110,-60}},
            rotation=0)));
          Modelica.Electrical.Analog.Interfaces.Pin S "Source"
            annotation (Placement(transformation(extent={{90,-40},{110,-60}},
            rotation=0)));
          Modelica.Electrical.Analog.Interfaces.Pin B "Bulk"
            annotation (Placement(transformation(extent={{90,-10},{110,10}},
            rotation=0)));
          parameter Modelica.SIunits.Length W=20.0e-6 "Width";
          parameter Modelica.SIunits.Length L=6.0e-6 "Length";
          parameter Modelica.SIunits.Transconductance Beta=0.0105e-3
      "Transconductance parameter";
          parameter Modelica.SIunits.Voltage Vt=-1.0
      "Zero bias threshold voltage";
          parameter Real K2=0.41 "Bulk threshold parameter";
          parameter Real K5=0.839 "Reduction of pinch-off region";
          parameter Modelica.SIunits.Length dW=-2.5e-6 "Narrowing of channel";
          parameter Modelica.SIunits.Length dL=-2.1e-6 "Shortening of channel";
          parameter Modelica.SIunits.Resistance RDS=1.e+7
      "Drain-Source-Resistance";
          parameter Modelica.SIunits.Temperature Tnom=300.15
      "Parameter measurement temperature";
          parameter Real kvt=-2.9e-3 "fitting parameter for Vt";
          parameter Real kk2=6.2e-4 "fitting parameter for Kk2";
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
          assert( T_heatPort > 0,"HeatingPMOS: Temperature must be positive");
          gds = if (RDS < 1.e-20 and RDS > -1.e-20) then 1.e20 else 1/RDS;
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
          annotation (__Dymola_structurallyIncomplete=true,
            Documentation(info="<html>
<p>The PMOS model is a simple model of a p-channel metal-oxide semiconductor FET. It differs slightly from the device used in the SPICE simulator. For more details please care for H. Spiro.</p>
<p>A heating port is added for thermal electric simulation. The heating port is defined in the Modelica.Thermal library.</p>
<p>The model does not consider capacitances. A high drain-source resistance RDS is included to avoid numerical difficulties.</p>
<dl><dt><b>References:</b> </dt>
<dd>Spiro, H.: Simulation integrierter Schaltungen. R. Oldenbourg Verlag Muenchen Wien 1990. </dd>
</dl><p>Some typical parameter sets are:</p>
<pre>  W       L      Beta        Vt       K2       K5       DW         DL
  m       m      A/V^2       V        -        -        m          m
  50.e-6  8.e-6  0.0085e-3   -.15     0.41      0.839    -3.8e-6    -4.0e-6
  20.e-6  6.e-6  0.0105e-3  -1.0      0.41      0.839    -2.5e-6    -2.1e-6
  30.e-6  5.e-6  0.0059e-3   -.3      0.98     1.01      0         -3.9e-6
  30.e-6  5.e-6  0.0152e-3   -.69     0.104    1.1       -.8e-6     -.4e-6
  30.e-6  5.e-6  0.0163e-3   -.69     0.104    1.1       -.8e-6     -.4e-6
  30.e-6  5.e-6  0.0182e-3   -.69     0.086    1.06      -.1e-6     -.6e-6
  20.e-6  6.e-6  0.0074e-3  -1.       0.4       0.59      0          0 </pre>
</html>",  revisions="<html>
<ul>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><i>December 7, 2005   </i>
       by Christoph Clauss<br>
       error in RDS calculation deleted</li>
<li><i>March 31, 2004   </i>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"),  Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-90,-50},{-10,-50}}, color={0,0,255}),
          Line(points={{-10,-50},{-10,50}}, color={0,0,255}),
          Line(points={{10,70},{10,29}}, color={0,0,255}),
          Line(points={{10,20},{10,-21}}, color={0,0,255}),
          Line(points={{10,-30},{10,-71}}, color={0,0,255}),
          Line(points={{10,50},{91,50}}, color={0,0,255}),
          Line(points={{10,0},{90,0}}, color={0,0,255}),
          Line(points={{10,-50},{90,-50}}, color={0,0,255}),
          Polygon(
            points={{60,0},{40,5},{40,-5},{60,0}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{-155,120},{145,80}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,0}},
            color={127,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dot)}),
            Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-100,-50},{-10,-50}}, color={0,0,255}),
          Line(points={{-10,-50},{-10,50}}, color={0,0,255}),
          Line(points={{10,70},{10,29}}, color={0,0,255}),
          Line(points={{10,20},{10,-21}}, color={0,0,255}),
          Line(points={{10,-30},{10,-71}}, color={0,0,255}),
          Line(points={{10,50},{96,50}}, color={0,0,255}),
          Line(points={{10,0},{101,0}}, color={0,0,255}),
          Line(points={{10,-50},{100,-50}}, color={0,0,255}),
          Polygon(
            points={{60,0},{40,5},{40,-5},{60,0}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255})}));
        end HeatingPMOS;

        model HeatingNPN
    "Simple NPN BJT according to Ebers-Moll with heating port"
          parameter Real Bf=50 "Forward beta";
          parameter Real Br=0.1 "Reverse beta";
          parameter Modelica.SIunits.Current Is=1.e-16
      "Transport saturation current";
          parameter Modelica.SIunits.InversePotential Vak=0.02
      "Early voltage (inverse), 1/Volt";
          parameter Modelica.SIunits.Time Tauf=0.12e-9
      "Ideal forward transit time";
          parameter Modelica.SIunits.Time Taur=5e-9
      "Ideal reverse transit time";
          parameter Modelica.SIunits.Capacitance Ccs=1e-12
      "Collector-substrat(ground) cap.";
          parameter Modelica.SIunits.Capacitance Cje=0.4e-12
      "Base-emitter zero bias depletion cap.";
          parameter Modelica.SIunits.Capacitance Cjc=0.5e-12
      "Base-coll. zero bias depletion cap.";
          parameter Modelica.SIunits.Voltage Phie=0.8
      "Base-emitter diffusion voltage";
          parameter Real Me=0.4 "Base-emitter gradation exponent";
          parameter Modelica.SIunits.Voltage Phic=0.8
      "Base-collector diffusion voltage";
          parameter Real Mc=0.333 "Base-collector gradation exponent";
          parameter Modelica.SIunits.Conductance Gbc=1e-15
      "Base-collector conductance";
          parameter Modelica.SIunits.Conductance Gbe=1e-15
      "Base-emitter conductance";
          parameter Real EMin=-100
      "if x < EMin, the exp(x) function is linearized";
          parameter Real EMax=40
      "if x > EMax, the exp(x) function is linearized";
          parameter Modelica.SIunits.Temperature Tnom=300.15
      "Parameter measurement temperature";
          parameter Real XTI=3 "Temperature exponent for effect on Is";
          parameter Real XTB=0 "Forward and reverse beta temperature exponent";
          parameter Real EG=1.11 "Energy gap for temperature effect on Is";
          parameter Real NF=1.0 "Forward current emission coefficient";
          parameter Real NR=1.0 "Reverse current emission coefficient";
          parameter Real K=1.3806226e-23 "Boltzmann's constant";
          parameter Real q=1.6021918e-19 "Elementary electronic charge";
          extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(
             useHeatPort=true);
          /*protected*/
          Real vbc;
          Real vbe;
          Real qbk;
          Real ibc;
          Real ibe;
          Real cbc;
          Real cbe;
          Real ExMin;
          Real ExMax;
          Real Capcje;
          Real Capcjc;
          Real is_t;
          Real br_t;
          Real bf_t;
          Real vt_t;
          Real hexp;
          Real htempexp;
  public
          Modelica.Electrical.Analog.Interfaces.Pin C "Collector"
            annotation (Placement(transformation(extent={{90,40},{110,60}},
            rotation=0)));
          Modelica.Electrical.Analog.Interfaces.Pin B "Base"
            annotation (Placement(transformation(extent={{-90,-10},{-110,10}},
            rotation=0)));
          Modelica.Electrical.Analog.Interfaces.Pin E "Emitter"
            annotation (Placement(transformation(extent={{90,-40},{110,-60}},
            rotation=0)));
        equation
          assert( T_heatPort > 0,"temperature must be positive");
          ExMin = exp(EMin);
          ExMax = exp(EMax);
          vbc = B.v - C.v;
          vbe = B.v - E.v;
          qbk = 1 - vbc*Vak;

          hexp = (T_heatPort/Tnom - 1)*EG/vt_t;
          htempexp = smooth(1,if (hexp < EMin) then ExMin*(hexp - EMin + 1) else if (
            hexp > EMax) then ExMax*(hexp - EMax + 1) else exp(hexp));

          is_t = Is*pow((T_heatPort/Tnom), XTI)*htempexp;
          br_t = Br*pow((T_heatPort/Tnom), XTB);
          bf_t = Bf*pow((T_heatPort/Tnom), XTB);
          vt_t = (K/q)*T_heatPort;

          ibc = smooth(1,(if (vbc/(NR*vt_t) < EMin) then is_t*(ExMin*(vbc/(NR*vt_t) -
            EMin + 1) - 1) + vbc*Gbc else if (vbc/(NR*vt_t) > EMax) then is_t*(
            ExMax*(vbc/(NR*vt_t) - EMax + 1) - 1) + vbc*Gbc else is_t*(exp(vbc/
            (NR*vt_t)) - 1) + vbc*Gbc));
          ibe = smooth(1,(if (vbe/(NF*vt_t) < EMin) then is_t*(ExMin*(vbe/(NF*vt_t) -
            EMin + 1) - 1) + vbe*Gbe else if (vbe/(NF*vt_t) > EMax) then is_t*(
            ExMax*(vbe/(NF*vt_t) - EMax + 1) - 1) + vbe*Gbe else is_t*(exp(vbe/
            (NF*vt_t)) - 1) + vbe*Gbe));
          Capcjc = smooth(1,(if (vbc/Phic > 0) then Cjc*(1 + Mc*vbc/Phic) else Cjc*pow(1
             - vbc/Phic, -Mc)));
          Capcje = smooth(1,(if (vbe/Phie > 0) then Cje*(1 + Me*vbe/Phie) else Cje*pow(1
             - vbe/Phie, -Me)));
          cbc = smooth(1,(if (vbc/(NR*vt_t) < EMin) then Taur*is_t/(NR*vt_t)*ExMin*(vbc/(
            NR*vt_t) - EMin + 1) + Capcjc else if (vbc/(NR*vt_t) > EMax) then
            Taur*is_t/(NR*vt_t)*ExMax*(vbc/(NR*vt_t) - EMax + 1) + Capcjc else
            Taur*is_t/(NR*vt_t)*exp(vbc/(NR*vt_t)) + Capcjc));
          cbe = smooth(1,(if (vbe/(NF*vt_t) < EMin) then Tauf*is_t/(NF*vt_t)*ExMin*(vbe/(
            NF*vt_t) - EMin + 1) + Capcje else if (vbe/(NF*vt_t) > EMax) then
            Tauf*is_t/(NF*vt_t)*ExMax*(vbe/(NF*vt_t) - EMax + 1) + Capcje else
            Tauf*is_t/(NF*vt_t)*exp(vbe/(NF*vt_t)) + Capcje));
          C.i = (ibe - ibc)*qbk - ibc/br_t - cbc*der(vbc) + Ccs*der(C.v);
          B.i = ibe/bf_t + ibc/br_t + cbc*der(vbc) + cbe*der(vbe);
          E.i = -B.i - C.i + Ccs*der(C.v);

          LossPower = (vbc*ibc/br_t + vbe*ibe/bf_t + (ibe - ibc)*qbk*(C.v - E.v));
          annotation (__Dymola_structurallyIncomplete=true,
            Documentation(info="<html>
<p>This model is a simple model of a bipolar npn junction transistor according to Ebers-Moll.</p>
<p>A heating port is added for thermal electric simulation. The heating port is defined in the Modelica.Thermal library.</p>
<p>A typical parameter set is (the parameter Vt is no longer used):</p>
<pre>  Bf  Br  Is     Vak  Tauf    Taur  Ccs   Cje     Cjc     Phie  Me   PHic   Mc     Gbc    Gbe
  -   -   A      V    s       s     F     F       F       V     -    V      -      mS     mS
  50  0.1 1e-16  0.02 0.12e-9 5e-9  1e-12 0.4e-12 0.5e-12 0.8   0.4  0.8    0.333  1e-15  1e-15</pre>
<p><b>References:</b></p>
<p>Vlach, J.; Singal, K.: Computer methods for circuit analysis and design. Van Nostrand Reinhold, New York 1983 on page 317 ff.</p>
</html>",  revisions="<html>
<ul>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><i>March 20, 2004   </i>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"),  Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-10,40},{-10,-40}}, color={0,0,255}),
          Line(points={{-10,0},{-90,0}}, color={0,0,255}),
          Line(points={{91,50},{30,50}}, color={0,0,255}),
          Line(points={{30,50},{-10,10}}, color={0,0,255}),
          Line(points={{-10,-10},{30,-50}}, color={0,0,255}),
          Line(points={{30,-50},{91,-50}}, color={0,0,255}),
          Polygon(
            points={{30,-50},{24,-36},{16,-44},{30,-50}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{-162,125},{138,85}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,-20}},
            color={127,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dot)}),
            Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-10,40},{-10,-40}}, color={0,0,255}),
          Line(points={{-10,0},{-100,0}}, color={0,0,255}),
          Line(points={{30,50},{-10,10}}, color={0,0,255}),
          Line(points={{-10,-10},{30,-50}}, color={0,0,255}),
          Line(points={{30,-50},{100,-50}}, color={0,0,255}),
          Line(points={{100,50},{30,50}}, color={0,0,255}),
          Polygon(
            points={{30,-50},{24,-36},{16,-44},{30,-50}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255})}));
        end HeatingNPN;

        model HeatingPNP
    "Simple PNP BJT according to Ebers-Moll with heating port"
          parameter Real Bf=50 "Forward beta";
          parameter Real Br=0.1 "Reverse beta";
          parameter Modelica.SIunits.Current Is=1.e-16
      "Transport saturation current";
          parameter Modelica.SIunits.InversePotential Vak=0.02
      "Early voltage (inverse), 1/Volt";
          parameter Modelica.SIunits.Time Tauf=0.12e-9
      "Ideal forward transit time";
          parameter Modelica.SIunits.Time Taur=5e-9
      "Ideal reverse transit time";
          parameter Modelica.SIunits.Capacitance Ccs=1e-12
      "Collector-substrat(ground) cap.";
          parameter Modelica.SIunits.Capacitance Cje=0.4e-12
      "Base-emitter zero bias depletion cap.";
          parameter Modelica.SIunits.Capacitance Cjc=0.5e-12
      "Base-coll. zero bias depletion cap.";
          parameter Modelica.SIunits.Voltage Phie=0.8
      "Base-emitter diffusion voltage";
          parameter Real Me=0.4 "Base-emitter gradation exponent";
          parameter Modelica.SIunits.Voltage Phic=0.8
      "Base-collector diffusion voltage";
          parameter Real Mc=0.333 "Base-collector gradation exponent";
          parameter Modelica.SIunits.Conductance Gbc=1e-15
      "Base-collector conductance";
          parameter Modelica.SIunits.Conductance Gbe=1e-15
      "Base-emitter conductance";
          parameter Real EMin=-100
      "if x < EMin, the exp(x) function is linearized";
          parameter Real EMax=40
      "if x > EMax, the exp(x) function is linearized";
          parameter Modelica.SIunits.Temperature Tnom=300.15
      "Parameter measurement temperature";
          parameter Real XTI=3 "Temperature exponent for effect on Is";
          parameter Real XTB=0 "Forward and reverse beta temperature exponent";
          parameter Real EG=1.11 "Energy gap for temperature effect on Is";
          parameter Real NF=1.0 "Forward current emission coefficient";
          parameter Real NR=1.0 "Reverse current emission coefficient";
          parameter Real K=1.3806226e-23 "Boltzmann's constant";
          parameter Real q=1.6021918e-19 "Elementary electronic charge";
          extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(
             useHeatPort=true);
  protected
          Real vcb;
          Real veb;
          Real qbk;
          Real icb;
          Real ieb;
          Real ccb;
          Real ceb;
          Real ExMin;
          Real ExMax;
          Real Capcje;
          Real Capcjc;
          Real is_t;
          Real br_t;
          Real bf_t;
          Real vt_t;
          Real hexp;
          Real htempexp;
  public
          Modelica.Electrical.Analog.Interfaces.Pin C "Collector"
            annotation (Placement(transformation(extent={{90,40},{110,60}},
            rotation=0)));
          Modelica.Electrical.Analog.Interfaces.Pin B "Base"
            annotation (Placement(transformation(extent={{-90,-10},{-110,10}},
            rotation=0)));
          Modelica.Electrical.Analog.Interfaces.Pin E "Emitter"
            annotation (Placement(transformation(extent={{90,-40},{110,-60}},
            rotation=0)));
        equation
          assert( T_heatPort > 0,"temperature must be positive");
          ExMin = exp(EMin);
          ExMax = exp(EMax);
          vcb = C.v - B.v;
          veb = E.v - B.v;
          qbk = 1 - vcb*Vak;

          hexp = (T_heatPort/Tnom - 1)*EG/vt_t;
          htempexp = smooth(1,if (hexp < EMin) then ExMin*(hexp - EMin + 1) else if (
            hexp > EMax) then ExMax*(hexp - EMax + 1) else exp(hexp));

          is_t = Is*pow((T_heatPort/Tnom), XTI)*htempexp;
          br_t = Br*pow((T_heatPort/Tnom), XTB);
          bf_t = Bf*pow((T_heatPort/Tnom), XTB);
          vt_t = (K/q)*T_heatPort;

          icb = smooth(1,(if (vcb/(NR*vt_t) < EMin) then is_t*(ExMin*(vcb/(NR*vt_t) -
            EMin + 1) - 1) + vcb*Gbc else if (vcb/(NR*vt_t) > EMax) then is_t*(
            ExMax*(vcb/(NR*vt_t) - EMax + 1) - 1) + vcb*Gbc else is_t*(exp(vcb/
            (NR*vt_t)) - 1) + vcb*Gbc));

          ieb = smooth(1,(if (veb/(NF*vt_t) < EMin) then is_t*(ExMin*(veb/(NF*vt_t) -
            EMin + 1) - 1) + veb*Gbe else if (veb/(NF*vt_t) > EMax) then is_t*(
            ExMax*(veb/(NF*vt_t) - EMax + 1) - 1) + veb*Gbe else is_t*(exp(veb/
            (NF*vt_t)) - 1) + veb*Gbe));

          Capcjc = smooth(1,(if (vcb/Phic > 0) then Cjc*(1 + Mc*vcb/Phic) else Cjc*pow(1
             - vcb/Phic, -Mc)));
          Capcje = smooth(1,(if (veb/Phie > 0) then Cje*(1 + Me*veb/Phie) else Cje*pow(1
             - veb/Phie, -Me)));
          ccb = smooth(1,(if (vcb/(NR*vt_t) < EMin) then Taur*is_t/(NR*vt_t)*ExMin*(vcb/(
            NR*vt_t) - EMin + 1) + Capcjc else if (vcb/(NR*vt_t) > EMax) then
            Taur*is_t/(NR*vt_t)*ExMax*(vcb/(NR*vt_t) - EMax + 1) + Capcjc else
            Taur*is_t/(NR*vt_t)*exp(vcb/(NR*vt_t)) + Capcjc));
          ceb = smooth(1,(if (veb/(NF*vt_t) < EMin) then Tauf*is_t/(NF*vt_t)*ExMin*(veb/(
            NF*vt_t) - EMin + 1) + Capcje else if (veb/(NF*vt_t) > EMax) then
            Tauf*is_t/(NF*vt_t)*ExMax*(veb/(NF*vt_t) - EMax + 1) + Capcje else
            Tauf*is_t/(NF*vt_t)*exp(veb/(NF*vt_t)) + Capcje));
          C.i = icb/br_t + ccb*der(vcb) + Ccs*der(C.v) + (icb - ieb)*qbk;
          B.i = -ieb/bf_t - icb/br_t - ceb*der(veb) - ccb*der(vcb);
          E.i = -B.i - C.i + Ccs*der(C.v);

          LossPower = (vcb*icb/br_t + veb*ieb/bf_t + (icb - ieb)*qbk*(C.v- E.v));
          annotation (__Dymola_structurallyIncomplete=true,
            Documentation(info="<html>
<p>This model is a simple model of a bipolar pnp junction transistor according to Ebers-Moll.</p>
<p>A heating port is added for thermal electric simulation. The heating port is defined in the Modelica.Thermal library.</p>
<p>A typical parameter set is (the parameter Vt is no longer used):</p>
<pre>  Bf  Br  Is     Vak  Tauf    Taur  Ccs   Cje     Cjc     Phie  Me   PHic   Mc     Gbc    Gbe
  -   -   A      V    s       s     F     F       F       V     -    V      -      mS     mS
  50  0.1 1e-16  0.02 0.12e-9 5e-9  1e-12 0.4e-12 0.5e-12 0.8   0.4  0.8    0.333  1e-15  1e-15</pre>
<p><b>References:</b></p>
<p>Vlach, J.; Singal, K.: Computer methods for circuit analysis and design. Van Nostrand Reinhold, New York 1983 on page 317 ff.</p>
</html>",  revisions="<html>
<ul>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><i>March 20, 2004   </i>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"),  Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-10,40},{-10,-40}}, color={0,0,255}),
          Line(points={{-10,0},{-90,0}}, color={0,0,255}),
          Line(points={{91,50},{30,50}}, color={0,0,255}),
          Line(points={{30,50},{-10,10}}, color={0,0,255}),
          Line(points={{-10,-10},{30,-50}}, color={0,0,255}),
          Line(points={{30,-50},{91,-50}}, color={0,0,255}),
          Polygon(
            points={{-10,-10},{5,-17},{-3,-25},{-10,-10}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{-155,117},{145,77}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,-20}},
            color={127,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dot)}),
            Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-10,40},{-10,-40}}, color={0,0,255}),
          Line(points={{-10,0},{-99,0}}, color={0,0,255}),
          Line(points={{96,50},{30,50}}, color={0,0,255}),
          Line(points={{30,50},{-10,10}}, color={0,0,255}),
          Line(points={{-10,-10},{30,-50}}, color={0,0,255}),
          Line(points={{30,-50},{96,-50}}, color={0,0,255}),
          Polygon(
            points={{-10,-10},{5,-17},{-3,-25},{-10,-10}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255})}));
        end HeatingPNP;

protected
        function pow
    "Just a helper function for x^y in order that a symbolic engine can apply some transformations more easily"

          input Real x;
          input Real y;
          output Real z;
        algorithm
          z := x^y;
        end pow;

        function exlin "Exponential function linearly continued for x > Maxexp"

          input Real x;
          input Real Maxexp;
          output Real z;
        algorithm
          z := if x > Maxexp then exp(Maxexp)*(1 + x - Maxexp) else exp(x);
        end exlin;

public
  model Thyristor "Simple Thyristor Model"
    parameter Modelica.SIunits.Voltage VDRM(final min=0) = 100
      "Forward breakthrough voltage";
    parameter Modelica.SIunits.Voltage VRRM(final min=0) = 100
      "Reverse breakthrough voltage";
    parameter Modelica.SIunits.Current IDRM=0.1 "Saturation current";
    parameter Modelica.SIunits.Voltage VTM= 1.7 "Conducting voltage";
    parameter Modelica.SIunits.Current IH=6e-3 "Holding current";
    parameter Modelica.SIunits.Current ITM= 25 "Conducting current";

    parameter Modelica.SIunits.Voltage VGT= 0.7 "Gate trigger voltage";
    parameter Modelica.SIunits.Current IGT= 5e-3 "Gate trigger current";

    parameter Modelica.SIunits.Time TON = 1e-6 "Switch on time";
    parameter Modelica.SIunits.Time TOFF = 15e-6 "Switch off time";
    parameter Modelica.SIunits.Voltage Vt=0.04
      "Voltage equivalent of temperature (kT/qn)";
    parameter Real Nbv=0.74 "Reverse Breakthrough emission coefficient";

    Real iGK "gate current";
    Real vGK "voltage between gate and cathode";
    Real vAK "voltage between anode and cathode";
    Real vControl(start=0);
    Real vContot;
    Real vConmain;

  public
    Modelica.Electrical.Analog.Interfaces.PositivePin Anode annotation (Placement(
          transformation(extent={{-95,-12},{-75,8}}),
                                                    iconTransformation(extent={{
              -100,-10},{-80,10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin Cathode annotation (Placement(
          transformation(extent={{80,-10},{100,10}}), iconTransformation(extent={
              {80,-10},{100,10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin Gate annotation (Placement(
          transformation(extent={{60,80},{80,100}}), iconTransformation(extent={{60,80},
              {80,100}})));

  protected
    parameter Modelica.SIunits.Voltage Von=5;
    parameter Modelica.SIunits.Voltage Voff= 1.5;
    parameter Modelica.SIunits.Resistance Ron=(VTM-0.7)/ITM
      "Forward conducting mode resistance";
    parameter Modelica.SIunits.Resistance Roff=(VDRM^2)/VTM/IH
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

   annotation (
     Documentation(info="<html>
<p><br/>This is a simple thyristor model with three pins: Anode, Cathode and Gate. There are three operating modes:</p><p><br/>conducting, blocking and reverse breakthrough.</p>
<p><br/>As long as the thyristor is in blocking mode it behaves like a linear resistance Roff=VDRM^2/(VTM*IH).</p><p><br/>But if the voltage between anode and cathode exceeds VDRM or a positive gate current flows for a sufficient time the mode changes to conducting mode.</p><p><br/>The model stays in conducting mode until the anode current falls below the holding current IH. There is no way to switch off the thyristor via the gate.</p><p><br/>If the voltage between anode and cathode is negative, the model represents a diode (parameters Vt, Nbv) with reverse breakthrough voltage VRRM. </p>
<p>The dV/dt switch on is not taken into account in this model. The gate circuit is not influenced by the main circuit.</p>
</html>",
    revisions=
      "<html>
<ul>
<li><i>May 12, 2009   </i>
       by Matthias Franke
       </li>
</ul>
</html>"),
     Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Polygon(
            points={{30,0},{-30,40},{-30,-40},{30,0}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{40,0}}, color={0,0,255}),
          Line(points={{40,0},{90,0}}, color={0,0,255}),
          Line(points={{30,40},{30,-40}}, color={0,0,255}),
          Line(points={{30,20},{70,60},{70,90}}, color={0,0,255}),
          Line(points={{40,50},{60,30}}, color={0,0,255}),
          Text(
            extent={{-142,-59},{158,-99}},
            textString="%name",
            lineColor={0,0,255})}),
     Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
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
            pattern=LinePattern.Dot,
            textString="Ron"),
          Line(
            points={{14,20},{25,73}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{-57,-11},{55,9}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=0.5),
          Line(
            points={{-57,-11},{-59,-13},{-60,-18},{-63,-65}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.None),
          Text(
            extent={{-67,11},{-47,1}},
            lineColor={128,128,128},
            pattern=LinePattern.Dot,
            textString="VRRM"),
          Text(
            extent={{44,-2},{64,-12}},
            lineColor={128,128,128},
            pattern=LinePattern.Dot,
            textString="VDRM"),
          Line(
            points={{-57,1},{-57,-1}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{54,1},{54,-1}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{55,9},{54,11},{50,13},{17,17},{15,18},{14,20}},
            color={0,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dot),
          Text(
            extent={{-28,-9},{-8,-19}},
            lineColor={128,128,128},
            pattern=LinePattern.Dot,
            textString="Roff"),
          Line(
            points={{2,20},{-2,20}},
            color={0,0,0},
            smooth=Smooth.None),
          Text(
            extent={{-14,23},{-2,16}},
            lineColor={128,128,128},
            pattern=LinePattern.Dot,
            textString="IH")}));
  end Thyristor;

  model SimpleTriac "Simple triac, based on Semiconductors.Thyristor model"

    parameter Modelica.SIunits.Voltage VDRM(final min=0) = 100
      "Forward breakthrough voltage";
    parameter Modelica.SIunits.Voltage VRRM(final min=0) = 100
      "Reverse breakthrough voltage";
    parameter Modelica.SIunits.Current IDRM=0.1 "Saturation current";
    parameter Modelica.SIunits.Voltage VTM= 1.7 "Conducting voltage";
    parameter Modelica.SIunits.Current IH=6e-3 "Holding current";
    parameter Modelica.SIunits.Current ITM= 25 "Conducting current";

    parameter Modelica.SIunits.Voltage VGT= 0.7 "Gate trigger voltage";
    parameter Modelica.SIunits.Current IGT= 5e-3 "Gate trigger current";

    parameter Modelica.SIunits.Time TON = 1e-6 "Switch on time";
    parameter Modelica.SIunits.Time TOFF = 15e-6 "Switch off time";
    parameter Modelica.SIunits.Voltage Vt=0.04
      "Voltage equivalent of temperature (kT/qn)";
    parameter Real Nbv=0.74 "Reverse Breakthrough emission coefficient";

    Modelica.Electrical.Analog.Interfaces.NegativePin n "Cathode"
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin p "Anode"
      annotation (Placement(transformation(extent={{94,-10},{114,10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin g "Gate"
      annotation (Placement(transformation(extent={{-72,-106},{-52,-86}})));
    Modelica.Electrical.Analog.Semiconductors.Thyristor thyristor(VDRM=VDRM, VRRM=VRRM)
      annotation (Placement(transformation(extent={{-20,30},{0,50}})));
    Modelica.Electrical.Analog.Semiconductors.Thyristor thyristor1(VDRM=VDRM, VRRM=VRRM)
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
  equation
    connect(thyristor.Anode, n) annotation (Line(
        points={{-19,40},{-18,40},{-18,48},{-70,48},{-70,0},{-100,0}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(thyristor1.Anode, p) annotation (Line(
        points={{-3,-40},{-2,-40},{-2,-60},{80,-60},{80,0},{104,0}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(thyristor1.Anode, thyristor.Cathode) annotation (Line(
        points={{-3,-40},{-2,-40},{-2,40},{-1,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(thyristor1.Cathode, thyristor.Anode) annotation (Line(
        points={{-21,-40},{-22,-40},{-22,40},{-19,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(thyristor.Gate, idealDiode.n) annotation (Line(
        points={{-3,49},{-3,59.5},{-20,59.5},{-20,68}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(idealDiode.p, g) annotation (Line(
        points={{-40,68},{-82,68},{-82,-96},{-62,-96}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(idealDiode1.n, thyristor1.Gate) annotation (Line(
        points={{-20,-62},{-20,-49},{-19,-49}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(idealDiode1.p, g) annotation (Line(
        points={{-20,-82},{-42,-82},{-42,-96},{-62,-96}},
        color={0,0,255},
        smooth=Smooth.None));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Polygon(
            points={{-30,0},{-30,-100},{70,-50},{-30,0}},
            lineColor={0,0,0},
            smooth=Smooth.None),
          Polygon(
            points={{70,100},{70,0},{-30,50},{70,100}},
            lineColor={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{70,0},{70,-100}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-30,0},{-30,100}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-30,0},{-90,0}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{70,0},{110,0}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-62,-86},{-62,-56},{-30,-44}},
            color={0,0,0},
            smooth=Smooth.None),
          Text(
            extent={{-102,130},{98,100}},
            textString="%name",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics),
      DymolaStoredErrors,
      Documentation(info="<html>
<p>This is a simple TRIAC model based on the extended thyristor model Modelica.Electrical.Analog.Semiconductors.Thyristor.</p>
<p>Two thyristors are contrarily connected in parallel, whereas each transistor is connected with a diode.</p>
<p>Further information regarding the electrical component TRIAC can be detected in documentation of the ideal TRIAC model.</p>
<p>As an additional information: this model is based on the Modelica.Electrical.Analog.Semiconductors.Thyristor.</p>
<p><b>Attention:</b> The model seems to be very sensitive with respect to the choice of some parameters (e.g., VDRM, VRRM). This is caused by the thyristor model. Further investigations are necessary.</p>
</html>",
     revisions="<html>
<ul>
<li><i>November 25, 2009   </i> <br>

       by Susann Wolf <br><br>
       </li>
</ul>
</html>"));
  end SimpleTriac;
  annotation (
    Documentation(info="<html>
<p>This package contains semiconductor devices:</p>
<p><ul>
<li>diode</li>
<li>MOS transistors</li>
<li>bipolar transistors</li>
</ul></p>
<p>All semiconductor devices contain a conditional heat port, which is not active by default. If it is active the loss power is calculated to be used in a thermal net. The heating variants of the semiconductor devices are provided to use the thermal pot temperature in the electric calculation. That means that for a true thermal electric interaction the heating device models have to be used.</p>
</html>",
   revisions="<html>
<dl>
<dt>
<b>Main Authors:</b>
<dd>
Christoph Clau&szlig;
    &lt;<a href=\"mailto:Christoph.Clauss@eas.iis.fraunhofer.de\">Christoph.Clauss@eas.iis.fraunhofer.de</a>&gt;<br>
    Andr&eacute; Schneider
    &lt;<a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden<br>
<p>
<dt>
</dl>
</html>"));
end Semiconductors;
