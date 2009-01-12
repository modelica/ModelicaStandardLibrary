within Modelica.Electrical.Analog;
package Semiconductors
  "Semiconductor devices such as diode, MOS and bipolar transistor"
  extends Modelica.Icons.Library;
  import Modelica.SIunits;

  annotation (
    Documentation(info="
<HTML>
<p>
This package contains semiconductor devices:
<ul>
<li>diode</li>
<li>MOS transistors</li>
<li>bipolar transistors</li>
<li>diode, MOS and bipolar transistors with temperature
    dependent characteristic and a heatPort for connection
    to the thermal domain</li>
</ul>
</p>
</HTML>
", revisions="<html>
<dl>
<dt>
<b>Main Authors:</b>
<dd>
<a href=\"http://people.eas.iis.fhg.de/Christoph.Clauss/\">Christoph Clau&szlig;</a>
    &lt;<a href=\"mailto:clauss@eas.iis.fhg.de\">clauss@eas.iis.fhg.de</a>&gt;<br>
    <a href=\"http://people.eas.iis.fhg.de/Andre.Schneider/\">Andr&eacute; Schneider</a>
    &lt;<a href=\"mailto:schneider@eas.iis.fhg.de\">schneider@eas.iis.fhg.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden<br>
<p>
<dt>
</dl>
</html>"));

  model Diode "Simple diode"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter SIunits.Current Ids=1.e-6 "Saturation current";
    parameter SIunits.Voltage Vt=0.04
      "Voltage equivalent of temperature (kT/qn)";
    parameter Real Maxexp(final min=Modelica.Constants.small) = 15
      "Max. exponent for linear continuation";
    parameter SIunits.Resistance R=1.e8 "Parallel ohmic resistance";
    annotation (
      Documentation(info="
<HTML>
<P>
The simple diode is a one port. It consists of the diode itself and an parallel ohmic
resistance <i>R</i>. The diode formula is:
</P>
<PRE>
                v/vt
  i  =  ids ( e      - 1).
</PRE>
<P>
If the exponent <i>v/vt</i> reaches the limit <i>maxex</i>, the diode characterisic is linearly
continued to avoid overflow.
</P>
</HTML>
", revisions="<html>
<ul>
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
            fillColor={255,255,255}),
          Line(points={{-90,0},{40,0}}, color={0,0,255}),
          Line(points={{40,0},{90,0}}, color={0,0,255}),
          Line(points={{30,40},{30,-40}}, color={0,0,255}),
          Text(
            extent={{-98,-58},{102,-100}},
            lineColor={0,0,0},
            textString="Vt=%Vt"),
          Text(
            extent={{-100,100},{100,70}},
            textString="%name",
            lineColor={0,0,255})}),
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
  equation
    i = smooth(1,(if (v/Vt > Maxexp) then Ids*(exp(Maxexp)*(1 + v/Vt - Maxexp) - 1) +
      v/R else Ids*(exp(v/Vt) - 1) + v/R));
  end Diode;

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
  protected
    Real v;
    Real uds;
    Real ubs;
    Real ugst;
    Real ud;
    Real us;
    Real id;
    Real gds;
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
  50.e-6  8.e-6  .0085e-3   -.15     .41      .839    -3.8e-6    -4.0e-6
  20.e-6  6.e-6  .0105e-3  -1.0      .41      .839    -2.5e-6    -2.1e-6
  30.e-6  5.e-6  .0059e-3   -.3      .98     1.01      0         -3.9e-6
  30.e-6  5.e-6  .0152e-3   -.69     .104    1.1       -.8e-6     -.4e-6
  30.e-6  5.e-6  .0163e-3   -.69     .104    1.1       -.8e-6     -.4e-6
  30.e-6  5.e-6  .0182e-3   -.69     .086    1.06      -.1e-6     -.6e-6
  20.e-6  6.e-6  .0074e-3  -1.       .4       .59      0          0
</PRE>
</HTML>
", revisions="<html>
<ul>
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
          Text(
            extent={{-100,60},{100,100}},
            textString="%name",
            lineColor={0,0,255}),
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
            lineColor={0,0,255})}),
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
  equation
    //assert (L + dL > 0, "Effective length must be positive");
    //assert (W + dW > 0, "Effective width  must be positive");
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
    parameter SIunits.Transconductance Beta=0.041e-3
      "Transconductance parameter";
    parameter SIunits.Voltage Vt=0.8 "Zero bias threshold voltage";
    parameter Real K2=1.144 "Bulk threshold parameter";
    parameter Real K5=0.7311 "Reduction of pinch-off region";
    parameter SIunits.Length dW=-2.5e-6 "narrowing of channel";
    parameter SIunits.Length dL=-1.5e-6 "shortening of channel";
    parameter SIunits.Resistance RDS=1.e+7 "Drain-Source-Resistance";
  protected
    Real v;
    Real uds;
    Real ubs;
    Real ugst;
    Real ud;
    Real us;
    Real id;
    Real gds;
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
</P>
<P>
<PRE>
  W       L      Beta        Vt       K2      K5       DW         DL
  m       m      A/V^2       V        -       -        m          m
  12.e-6  4.e-6  .062e-3   -4.5      .24     .61     -1.2e-6     -.9e-6      depletion
  60.e-6  3.e-6  .048e-3     .1      .08     .68     -1.2e-6     -.9e-6      enhancement
  12.e-6  4.e-6  .0625e-3   -.8      .21     .78     -1.2e-6     -.9e-6      zero
  50.e-6  8.e-6  .0299e-3    .24    1.144    .7311   -5.4e-6    -4.e-6
  20.e-6  6.e-6  .041e-3     .8     1.144    .7311   -2.5e-6    -1.5e-6
  30.e-6  9.e-6  .025e-3   -4.       .861    .878    -3.4e-6    -1.74e-6
  30.e-6  5.e-6  .031e-3     .6     1.5      .72      0         -3.9e-6
  50.e-6  6.e-6  .0414e-3  -3.8      .34     .8      -1.6e-6    -2.e-6       depletion
  50.e-6  5.e-6  .03e-3      .37     .23     .86     -1.6e-6    -2.e-6       enhancement
  50.e-6  6.e-6  .038e-3    -.9      .23     .707    -1.6e-6    -2.e-6       zero
  20.e-6  4.e-6  .06776e-3   .5409   .065    .71      -.8e-6     -.2e-6
  20.e-6  4.e-6  .06505e-3   .6209   .065    .71      -.8e-6     -.2e-6
  20.e-6  4.e-6  .05365e-3   .6909   .03     .8       -.3e-6     -.2e-6
  20.e-6  4.e-6  .05365e-3   .4909   .03     .8       -.3e-6     -.2e-6
  12.e-6  4.e-6  .023e-3   -4.5      .29     .6       0          0           depletion
  60.e-6  3.e-6  .022e-3     .1      .11     .65      0          0           enhancement
  12.e-6  4.e-6  .038e-3    -.8      .33     .6       0          0           zero
  20.e-6  6.e-6  .022e-3     .8     1        .66      0          0
</PRE>
<P>
<DL>
<DT><b>References:</b>
<DD>Spiro, H.: Simulation integrierter Schaltungen. R. Oldenbourg Verlag
Muenchen Wien 1990.
</DL>
</HTML>
", revisions="<html>
<ul>
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
          Text(
            extent={{-100,80},{100,100}},
            textString="%name",
            lineColor={0,0,255}),
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
            lineColor={0,0,255})}),
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
  equation
    //assert (L + dL > 0, "Effective length must be positive");
    //assert (W + dW > 0, "Effective width  must be positive");
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
  end NMOS;

  model NPN "Simple BJT according to Ebers-Moll"
    parameter Real Bf=50 "Forward beta";
    parameter Real Br=0.1 "Reverse beta";
    parameter SIunits.Current Is=1.e-16 "Transport saturation current";
    parameter SIunits.InversePotential Vak=0.02
      "Early voltage (inverse), 1/Volt";
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
    annotation (
      Documentation(info="
<HTML>
<P>
This model is a simple model of a bipolar npn junction transistor according
to Ebers-Moll.
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
", revisions="<html>
<ul>
<li><i>  </i>
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
          Text(
            extent={{-100,80},{100,100}},
            textString="%name",
            lineColor={0,0,255}),
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
            lineColor={0,0,255})}),
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
  end NPN;

  model PNP "Simple BJT according to Ebers-Moll"
    parameter Real Bf=50 "Forward beta";
    parameter Real Br=0.1 "Reverse beta";
    parameter SIunits.Current Is=1.e-16 "Transport saturation current";
    parameter SIunits.InversePotential Vak=0.02
      "Early voltage (inverse), 1/Volt";
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
                                                                      annotation (
      Documentation(info="
<HTML>
<P>
This model is a simple model of a bipolar pnp junction transistor according
to Ebers-Moll.
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
", revisions="<html>
<ul>
<li><i>  </i>
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
          Text(
            extent={{-100,80},{100,100}},
            textString="%name",
            lineColor={0,0,255}),
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
            lineColor={0,0,255})}),
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
  end PNP;

        model HeatingDiode "Simple diode with heating port"
          extends Modelica.Electrical.Analog.Interfaces.OnePort;
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(T(start=
                  300.15)) 
            annotation (Placement(transformation(
          origin={0,-100},
          extent={{10,-10},{-10,10}},
          rotation=270)));
          parameter Modelica.SIunits.Current Ids=1.e-6 "Saturation current";

            /* parameter Modelica.SIunits.Voltage Vt=0.04 "Voltage equivalent of temperature (kT/qn)"; */
          parameter Real Maxexp(final min=Modelica.Constants.small) = 15
      "Max. exponent for linear continuation";
          parameter Modelica.SIunits.Resistance R=1.e8
      "Parallel ohmic resistance";
          parameter Real EG=1.11 "activation energy";
          parameter Real N=1 "Emission coefficient";
          parameter Modelica.SIunits.Temperature TNOM=300.15
      "Parameter measurement temperature";
          parameter Real XTI=3 "Temperature exponent of saturation current";
          Modelica.SIunits.Temperature vt_t "Temperature voltage";
          Modelica.SIunits.Current id "diode current";
  protected
          Real k=1.380662e-23 "Boltzmann's constant, J/K";
          Real q=1.6021892e-19 "Electron charge, As";
          Modelica.SIunits.Temperature htemp "auxiliary temperature";
          Real aux;
          Real auxp;
          Real maxexp=exp(Maxexp);
          annotation (
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
            fillColor={255,255,255}),
          Line(points={{-90,0},{40,0}}, color={0,0,255}),
          Line(points={{40,0},{90,0}}, color={0,0,255}),
          Line(points={{30,40},{30,-40}}, color={0,0,255}),
          Text(
            extent={{-142,101},{143,51}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{0,-20},{0,-91}}, color={191,0,0})}),
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
          Line(points={{30,40},{30,-40}}, color={0,0,255}),
          Line(points={{0,-20},{0,-91}}, color={191,0,0})}));
        equation
          assert( heatPort.T > 0,"temperature must be positive");
          htemp = heatPort.T;
          vt_t = k*htemp/q;

          id = exlin((v/(N*vt_t)), Maxexp) - 1;

          aux = (htemp/TNOM - 1)*EG/(N*vt_t);
          auxp = exp(aux);

          i = Ids*id*pow(htemp/TNOM, XTI/N)*auxp + v/R;

          heatPort.Q_flow = -i*v;
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
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(T(start=
                  300.15)) 
            annotation (Placement(transformation(
          origin={0,-100},
          extent={{10,-10},{-10,10}},
          rotation=270)));
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
          annotation (
            Documentation(info="
<HTML>
<P>
The NMos model is a simple model of a n-channel metal-oxide semiconductor
FET. It differs slightly from the device used in the SPICE simulator.
For more details please care for H. Spiro.
</P>
<P>
A heating port is added for thermal electric simulation. The heating port
is defined in the Modelica.Thermal library.
</P>
<P>
The model does not consider capacitances. A high drain-source resistance RDS
is included to avoid numerical difficulties.
</P>
<P>
<PRE>
  W       L      Beta        Vt       K2      K5       DW         DL
  m       m      A/V^2       V        -       -        m          m
  12.e-6  4.e-6  .062e-3   -4.5      .24     .61     -1.2e-6     -.9e-6      depletion
  60.e-6  3.e-6  .048e-3     .1      .08     .68     -1.2e-6     -.9e-6      enhancement
  12.e-6  4.e-6  .0625e-3   -.8      .21     .78     -1.2e-6     -.9e-6      zero
  50.e-6  8.e-6  .0299e-3    .24    1.144    .7311   -5.4e-6    -4.e-6
  20.e-6  6.e-6  .041e-3     .8     1.144    .7311   -2.5e-6    -1.5e-6
  30.e-6  9.e-6  .025e-3   -4.       .861    .878    -3.4e-6    -1.74e-6
  30.e-6  5.e-6  .031e-3     .6     1.5      .72      0         -3.9e-6
  50.e-6  6.e-6  .0414e-3  -3.8      .34     .8      -1.6e-6    -2.e-6       depletion
  50.e-6  5.e-6  .03e-3      .37     .23     .86     -1.6e-6    -2.e-6       enhancement
  50.e-6  6.e-6  .038e-3    -.9      .23     .707    -1.6e-6    -2.e-6       zero
  20.e-6  4.e-6  .06776e-3   .5409   .065    .71      -.8e-6     -.2e-6
  20.e-6  4.e-6  .06505e-3   .6209   .065    .71      -.8e-6     -.2e-6
  20.e-6  4.e-6  .05365e-3   .6909   .03     .8       -.3e-6     -.2e-6
  20.e-6  4.e-6  .05365e-3   .4909   .03     .8       -.3e-6     -.2e-6
  12.e-6  4.e-6  .023e-3   -4.5      .29     .6       0          0           depletion
  60.e-6  3.e-6  .022e-3     .1      .11     .65      0          0           enhancement
  12.e-6  4.e-6  .038e-3    -.8      .33     .6       0          0           zero
  20.e-6  6.e-6  .022e-3     .8     1        .66      0          0
</PRE>
<P>
<DL>
<DT><b>References:</b>
<DD>Spiro, H.: Simulation integrierter Schaltungen. R. Oldenbourg Verlag
Muenchen Wien 1990.
</DL>
</P>
</HTML>
",         revisions=
             "<html>
<ul>
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
          Text(
            extent={{-100,80},{100,100}},
            textString="%name",
            lineColor={0,0,255}),
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
          Line(points={{0,-91},{0,-50}}, color={191,0,0})}),
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
            lineColor={0,0,255}),
          Line(points={{0,-90},{0,-49}}, color={191,0,0})}));
        equation
          assert(L + dL > 0, "Effective length must be positive");
          assert(W + dW > 0, "Effective width  must be positive");
          assert( heatPort.T > 0,"temperature must be positive");
          gds = if (RDS < 1.e-20 and RDS > -1.e-20) then 1.e20 else 1/RDS;
          v = beta_t*(W + dW)/(L + dL);
          ud = smooth(0,if (D.v < S.v) then S.v else D.v);
          us = smooth(0,if (D.v < S.v) then D.v else S.v);
          uds = ud - us;
          ubs = smooth(0,if (B.v > us) then 0 else B.v - us);
          ugst = (G.v - us - vt_t + k2_t*ubs)*K5;
          id = smooth(0,if (ugst <= 0) then uds*gds else if (ugst > uds) then v*uds*(
            ugst - uds/2) + uds*gds else v*ugst*ugst/2 + uds*gds);

          beta_t = Beta*pow((heatPort.T/Tnom), -1.5);
          vt_t = Vt*(1 + (heatPort.T - Tnom)*kvt);
          k2_t = K2*(1 + (heatPort.T - Tnom)*kk2);

          G.i = 0;
          D.i = smooth(0,if (D.v < S.v) then -id else id);
          S.i = smooth(0,if (D.v < S.v) then id else -id);
          B.i = 0;
          heatPort.Q_flow = -D.i*(D.v - S.v);
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
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(T(start=
                  300.15)) 
            annotation (Placement(transformation(
          origin={0,-100},
          extent={{10,-10},{-10,10}},
          rotation=270)));
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
          annotation (
            Documentation(info="
<HTML>
<P>
The PMOS model is a simple model of a p-channel metal-oxide semiconductor
FET. It differs slightly from the device used in the SPICE simulator.
For more details please care for H. Spiro.
</P>
<P>
A heating port is added for thermal electric simulation. The heating port
is defined in the Modelica.Thermal library.
</P>
<P>
The model does not consider capacitances. A high drain-source resistance RDS
is included to avoid numerical difficulties.
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
  50.e-6  8.e-6  .0085e-3   -.15     .41      .839    -3.8e-6    -4.0e-6
  20.e-6  6.e-6  .0105e-3  -1.0      .41      .839    -2.5e-6    -2.1e-6
  30.e-6  5.e-6  .0059e-3   -.3      .98     1.01      0         -3.9e-6
  30.e-6  5.e-6  .0152e-3   -.69     .104    1.1       -.8e-6     -.4e-6
  30.e-6  5.e-6  .0163e-3   -.69     .104    1.1       -.8e-6     -.4e-6
  30.e-6  5.e-6  .0182e-3   -.69     .086    1.06      -.1e-6     -.6e-6
  20.e-6  6.e-6  .0074e-3  -1.       .4       .59      0          0
</PRE>
</P>
</HTML>
",         revisions=
             "<html>
<ul>
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
          Text(
            extent={{-100,80},{100,100}},
            textString="%name",
            lineColor={0,0,255}),
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
          Line(points={{0,-91},{0,-50}}, color={191,0,0})}),
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
            lineColor={0,0,255}),
          Line(points={{0,-95},{0,-50}}, color={191,0,0})}));
        equation
          assert(L + dL > 0, "Effective length must be positive");
          assert(W + dW > 0, "Effective width  must be positive");
          assert( heatPort.T > 0,"temperature must be positive");
          gds = if (RDS < 1.e-20 and RDS > -1.e-20) then 1.e20 else 1/RDS;
          v = beta_t*(W + dW)/(L + dL);
          ud = smooth(0,if (D.v > S.v) then S.v else D.v);
          us = smooth(0,if (D.v > S.v) then D.v else S.v);
          uds = ud - us;
          ubs = smooth(0,if (B.v < us) then 0 else B.v - us);
          ugst = (G.v - us - vt_t + k2_t*ubs)*K5;
          id = smooth(0,if (ugst >= 0) then uds*gds else if (ugst < uds) then -v*uds*(
            ugst - uds/2) + uds*gds else -v*ugst*ugst/2 + uds*gds);

          beta_t = Beta*pow((heatPort.T/Tnom), -1.5);
          vt_t = Vt*(1 + (heatPort.T - Tnom)*kvt);
          k2_t = K2*(1 + (heatPort.T - Tnom)*kk2);

          G.i = 0;
          D.i = smooth(0,if (D.v > S.v) then -id else id);
          S.i = smooth(0,if (D.v > S.v) then id else -id);
          B.i = 0;
          heatPort.Q_flow = -D.i*(D.v - S.v);
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
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(T(start=
                  300.15)) 
            annotation (Placement(transformation(
          origin={0,-100},
          extent={{10,-10},{-10,10}},
          rotation=270)));
          annotation (
            Documentation(info="
<HTML>
<P>
This model is a simple model of a bipolar npn junction transistor according
to Ebers-Moll.
</P>
<P>
A heating port is added for thermal electric simulation. The heating port
is defined in the Modelica.Thermal library.
</P>
<P>
A typical parameter set is (the parameter Vt is no longer used):
</P>
<PRE>
  Bf  Br  Is     Vak  Tauf    Taur  Ccs   Cje     Cjc     Phie  Me   PHic   Mc     Gbc    Gbe
  -   -   A      V    s       s     F     F       F       V     -    V      -      mS     mS
  50  0.1 1e-16  0.02 0.12e-9 5e-9  1e-12 0.4e-12 0.5e-12 0.8   0.4  0.8    0.333  1e-15  1e-15
</PRE>
<P>
<DL>
<DT><b>References:</b>
<DD>Vlach, J.; Singal, K.: Computer methods for circuit analysis and design.
Van Nostrand Reinhold, New York 1983
on page 317 ff.
</DL>
</P>
</HTML>
",         revisions=
             "<html>
<ul>
<li><i>March 20, 2004   </i>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"),  Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Text(
            extent={{-100,80},{100,100}},
            textString="%name",
            lineColor={0,0,255}),
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
          Line(points={{0,-91},{0,-30}}, color={191,0,0})}),
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
            lineColor={0,0,255}),
          Line(points={{0,-94},{0,-32}}, color={191,0,0})}));
        equation
          assert( heatPort.T > 0,"temperature must be positive");
          ExMin = exp(EMin);
          ExMax = exp(EMax);
          vbc = B.v - C.v;
          vbe = B.v - E.v;
          qbk = 1 - vbc*Vak;

          hexp = (heatPort.T/Tnom - 1)*EG/vt_t;
          htempexp = smooth(1,if (hexp < EMin) then ExMin*(hexp - EMin + 1) else if (
            hexp > EMax) then ExMax*(hexp - EMax + 1) else exp(hexp));

          is_t = Is*pow((heatPort.T/Tnom), XTI)*htempexp;
          br_t = Br*pow((heatPort.T/Tnom), XTB);
          bf_t = Bf*pow((heatPort.T/Tnom), XTB);
          vt_t = (K/q)*heatPort.T;

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

          heatPort.Q_flow = -(vbc*ibc/br_t + vbe*ibe/bf_t + (ibe - ibc)*qbk*(C.v
             - E.v));
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
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(T(start=
                  300.15)) 
            annotation (Placement(transformation(
          origin={0,-100},
          extent={{10,-10},{-10,10}},
          rotation=270)));
          annotation (
            Documentation(info="
<HTML>
<P>
This model is a simple model of a bipolar pnp junction transistor according
to Ebers-Moll.
<P>
A heating port is added for thermal electric simulation. The heating port
is defined in the Modelica.Thermal library.
</P>
<P>
A typical parameter set is  (the parameter Vt is no longer used):
</P>
<PRE>
  Bf  Br  Is     Vak  Tauf    Taur  Ccs   Cje     Cjc     Phie  Me   PHic   Mc     Gbc    Gbe
  -   -   A      V    s       s     F     F       F       V     -    V      -      mS     mS
  50  0.1 1e-16  0.02 0.12e-9 5e-9  1e-12 0.4e-12 0.5e-12 0.8   0.4  0.8    0.333  1e-15  1e-15
</PRE>
<P>
<DL>
<DT><b>References:</b>
<DD>Vlach, J.; Singal, K.: Computer methods for circuit analysis and design.
Van Nostrand Reinhold, New York 1983
on page 317 ff.
</DL>
</HTML>
",         revisions=
             "<html>
<ul>
<li><i>March 20, 2004   </i>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"),  Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Text(
            extent={{-100,80},{100,100}},
            textString="%name",
            lineColor={0,0,255}),
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
          Line(points={{0,-91},{0,-30}}, color={191,0,0})}),
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
            lineColor={0,0,255}),
          Line(points={{0,-91},{0,-30}}, color={191,0,0})}));
        equation
          assert( heatPort.T > 0,"temperature must be positive");
          ExMin = exp(EMin);
          ExMax = exp(EMax);
          vcb = C.v - B.v;
          veb = E.v - B.v;
          qbk = 1 - vcb*Vak;

          hexp = (heatPort.T/Tnom - 1)*EG/vt_t;
          htempexp = smooth(1,if (hexp < EMin) then ExMin*(hexp - EMin + 1) else if (
            hexp > EMax) then ExMax*(hexp - EMax + 1) else exp(hexp));

          is_t = Is*pow((heatPort.T/Tnom), XTI)*htempexp;
          br_t = Br*pow((heatPort.T/Tnom), XTB);
          bf_t = Bf*pow((heatPort.T/Tnom), XTB);
          vt_t = (K/q)*heatPort.T;

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

          heatPort.Q_flow = -(vcb*icb/br_t + veb*ieb/bf_t + (icb - ieb)*qbk*(E.v
             - C.v));
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

end Semiconductors;
