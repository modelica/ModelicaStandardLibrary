package Semiconductors 
  extends Modelica.Icons.Library;
  package SIunits = Modelica.SIunits;
  
  annotation (
    Coordsys(
      extent=[0, 0; 400, 500], 
      grid=[1, 1], 
      component=[20, 20]), 
    Window(
      x=0.03, 
      y=0.04, 
      width=0.50, 
      height=0.36, 
      library=1, 
      autolayout=1), 
    Documentation(info="
<HTML>
<p>
This package contains semiconductor devices:
<ul>
<li>diode</li>
<li>bipolar transistors</li>
<li>MOS transistors</li>
</ul>
</p>

<dl>
<dt>
<b>Main Authors:</b>
<dd>
<a href=\"http://www.eas.iis.fhg.de/~clauss/\">Christoph Clau&szlig;</a> 
    &lt;<a href=\"mailto:clauss@eas.iis.fhg.de\">clauss@eas.iis.fhg.de</a>&gt;<br>
    <a href=\"http://www.eas.iis.fhg.de/~schneider/\">Andr&eacute; Schneider</a> 
    &lt;<a href=\"mailto:schneider@eas.iis.fhg.de\">schneider@eas.iis.fhg.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden<br>

<p>
<dt>
<b>Version:</b>
<dd>
$Id$<br>
<p>
<dt>
<b>Copyright:</b>
<dd>
Copyright (C) 1998-1999, Modelica Design Group and Fraunhofer-Gesellschaft.<br>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package 
Modelica in file \"Modelica/package.mo\".</i><br>
<p>
</dl>
</HTML>
"));
  
  model Diode "Simple diode" 
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter SIunits.Current Ids=1 "Saturation current";
    parameter SIunits.Voltage Vt=1 
      "Voltage equivalent of temperature (kT/qn)";
    parameter Real Maxexp(final min=Modelica.Constants.SMALL) = 1 
      "Max. exponent for linear continuation";
    parameter SIunits.Resistance R=1 "Parallel ohmic resistance";
    annotation (
      Documentation(info="
<HTML>
<P>
The simple diode is a two pole. It consists of the diode itself and an parallel ohmic
resistance <i>R</i>. The diode formula is simple:
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
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Polygon(points=[30, 0; -30, 40; -30, -40; 30, 0], style(
            color=3, 
            gradient=0, 
            fillColor=7)), 
        Line(points=[-90, 0; 40, 0]), 
        Line(points=[40, 0; 90, 0]), 
        Line(points=[30, 40; 30, -40], style(color=3)), 
        Text(extent=[-100, 100; 100, 70], string="%name")), 
      Diagram(
        Polygon(points=[30, 0; -30, 40; -30, -40; 30, 0], style(
            color=3, 
            gradient=0, 
            fillColor=1, 
            fillPattern=0)), 
        Line(points=[-90, 0; 40, 0]), 
        Line(points=[40, 0; 90, 0]), 
        Line(points=[30, 40; 30, -40], style(color=3))), 
      Window(
        x=0.13, 
        y=0.09, 
        width=0.75, 
        height=0.63));
  equation 
    //assert (R <> 0, "R must not be zero");
    i = if (v/Vt > Maxexp) then Ids*(exp(Maxexp)*(1 + v/Vt - Maxexp) - 1) + v/
      R else Ids*(exp(v/Vt) - 1) + v/R;
  end Diode;
  model PMOS "Simple MOS Transistor" 
    annotation (
      Documentation(info="
<HTML>
<P>
The PMOS model is a simple model of a p-channel metal-oxide semiconductor
FET. It differs slightly from the device used in the SPICE simulator.
For more details please care for H. Spiro.
</P>
<P>
The model does not consider capacitances. A small fixed drain-source resistance
is included (to avoid numerical difficulties).
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
  W       L      Beta      Vt       K2       K5       DW         DL    
  m       m      A/V^2     V        -        -        m          m    

  50.e-6  8.e-6  .0085     -.15     .41      .839    -3.8e-6    -4.0e-6           
  20.e-6  6.e-6  .0105    -1.0      .41      .839    -2.5e-6    -2.1e-6 
  30.e-6  5.e-6  .0059     -.3      .98     1.01      0         -3.9e-6   
  30.e-6  5.e-6  .0152     -.69     .104    1.1       -.8e-6     -.4e-6         
  30.e-6  5.e-6  .0163     -.69     .104    1.1       -.8e-6     -.4e-6         
  30.e-6  5.e-6  .0182     -.69     .086    1.06      -.1e-6     -.6e-6         
  20.e-6  6.e-6  .0074    -1.       .4       .59      0          0           
</PRE>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.34, 
        y=0.24, 
        width=0.6, 
        height=0.6), 
      Icon(
        Text(extent=[-100, 80; 100, 100], string="%name"), 
        Line(points=[-90, -50; -10, -50]), 
        Line(points=[-10, -50; -10, 50]), 
        Line(points=[10, 70; 10, 29]), 
        Line(points=[10, 20; 10, -21]), 
        Line(points=[10, -30; 10, -71]), 
        Line(points=[10, 50; 91, 50]), 
        Line(points=[10, 0; 90, 0]), 
        Line(points=[10, -50; 90, -50]), 
        Polygon(points=[60, 0; 40, 5; 40, -5; 60, 0], style(fillColor=3, 
              fillPattern=1))), 
      Diagram(
        Line(points=[-90, -50; -10, -50]), 
        Line(points=[-10, -50; -10, 50]), 
        Line(points=[10, 70; 10, 29]), 
        Line(points=[10, 20; 10, -21]), 
        Line(points=[10, -30; 10, -71]), 
        Line(points=[10, 50; 91, 50]), 
        Line(points=[10, 0; 90, 0]), 
        Line(points=[10, -50; 90, -50]), 
        Polygon(points=[60, 0; 40, 5; 40, -5; 60, 0], style(fillColor=3, 
              fillPattern=1))));
    
    Interfaces.Pin D "Drain" annotation (extent=[90, 40; 110, 60]);
    Interfaces.Pin G "Gate" annotation (extent=[-90, -40; -110, -60]);
    Interfaces.Pin S "Source" annotation (extent=[90, -40; 110, -60]);
    Interfaces.Pin B "Bulk" annotation (extent=[90, -10; 110, 10]);
    
    parameter SIunits.Length W=50.0e-6 "Width";
    parameter SIunits.Length L=8.0e-6 "Length";
    parameter SIunits.Transconductance Beta=0.0085 
      "Transconductance parameter";
    parameter SIunits.Voltage Vt=-0.15 "Zero bias threshold voltage";
    parameter Real K2=0.41 "Bulk threshold parameter";
    parameter Real K5=0.839 "Reduction of pinch-off region";
    parameter SIunits.Length dW=-3.8e-6 "Narrowing of channel";
    parameter SIunits.Length dL=-4.0e-6 "Shortening of channel";
  protected 
    Real v;
    Real uds;
    Real ubs;
    Real ugst;
    Real ud;
    Real us;
    Real id;
  equation 
    //assert (L + dL > 0, "Effective length must be positive");
    //assert (W + dW > 0, "Effective width  must be positive");
    v = Beta*(W + dW)/(L + dL);
    ud = if (D.v > S.v) then S.v else D.v;
    us = if (D.v > S.v) then D.v else S.v;
    uds = ud - us;
    ubs = if (B.v < us) then 0 else B.v - us;
    ugst = (G.v - us - Vt + K2*ubs)*K5;
    id = if (ugst >= 0) then v*uds*1.e-7 else if (ugst < uds) then -v*uds*(
      ugst - uds/2 - 1.e-7) else -v*(ugst*ugst/2 - uds*1.e-7);
    G.i = 0;
    D.i = if (D.v > S.v) then -id else id;
    S.i = if (D.v > S.v) then id else -id;
    B.i = 0;
  end PMOS;
  model NMOS "Simple MOS Transistor" 
    
    annotation (
      Documentation(info="
<HTML>
<P>
The NMos model is a simple model of a n-channel metal-oxide semiconductor
FET. It differs slightly from the device used in the SPICE simulator.
For more details please care for H. Spiro.
</P>
<P>
The model does not consider capacitances. A small fixed drain-source resistance
is included (to avoid numerical difficulties).
</P>
<P>
<PRE>
  W       L      Beta      Vt       K2       K5       DW         DL    
  m       m      A/V^2     V        -        -        m          m    

  12.e-6  4.e-6  .062     -4.5      .24      .61     -1.2e-6     -.9e-6         depletion
  60.e-6  3.e-6  .048       .1      .08      .68     -1.2e-6     -.9e-6         enhancement
  12.e-6  4.e-6  .0625     -.8      .21      .78     -1.2e-6     -.9e-6         zero
  50.e-6  8.e-6  .0299      .24    1.144     .7311   -5.4e-6    -4.e-6          
  20.e-6  6.e-6  .041       .8     1.144     .7311   -2.5e-6    -1.5e-6         
  30.e-6  9.e-6  .025     -4.       .861     .878    -3.4e-6    -1.74e-6        
  30.e-6  5.e-6  .031       .6     1.5       .72      0         -3.9e-6         
  50.e-6  6.e-6  .0414    -3.8      .34      .8      -1.6e-6    -2.e-6          depletion
  50.e-6  5.e-6  .03        .37     .23      .86     -1.6e-6    -2.e-6          enhancement
  50.e-6  6.e-6  .038      -.9      .23      .707    -1.6e-6    -2.e-6          zero
  20.e-6  4.e-6  .06776     .5409   .065     .71      -.8e-6     -.2e-6         
  20.e-6  4.e-6  .06505     .6209   .065     .71      -.8e-6     -.2e-6         
  20.e-6  4.e-6  .05365     .6909   .03      .8       -.3e-6     -.2e-6        
  20.e-6  4.e-6  .05365     .4909   .03      .8       -.3e-6     -.2e-6        
  12.e-6  4.e-6  .023     -4.5      .29      .6       0          0              depletion
  60.e-6  3.e-6  .022       .1      .11      .65      0          0              enhancement
  12.e-6  4.e-6  .038      -.8      .33      .6       0          0              zero
  20.e-6  6.e-6  .022       .8     1         .66      0          0            
</PRE>
<P>
<DL>
<DT><b>References:</b>
<DD>Spiro, H.: Simulation integrierter Schaltungen. R. Oldenbourg Verlag 
Muenchen Wien 1990.  
</DL>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Text(extent=[-100, 80; 100, 100], string="%name"), 
        Line(points=[-90, -50; -10, -50]), 
        Line(points=[-10, -50; -10, 50]), 
        Line(points=[10, 70; 10, 29]), 
        Line(points=[10, 20; 10, -21]), 
        Line(points=[10, -30; 10, -71]), 
        Line(points=[10, 50; 91, 50]), 
        Line(points=[10, 0; 90, 0]), 
        Line(points=[10, -50; 90, -50]), 
        Polygon(points=[40, 0; 60, 5; 60, -5; 40, 0], style(fillColor=3, 
              fillPattern=1))), 
      Diagram(
        Line(points=[-90, -50; -10, -50]), 
        Line(points=[-10, -50; -10, 50]), 
        Line(points=[10, 70; 10, 29]), 
        Line(points=[10, 20; 10, -21]), 
        Line(points=[10, -30; 10, -71]), 
        Line(points=[10, 50; 91, 50]), 
        Line(points=[10, 0; 90, 0]), 
        Line(points=[10, -50; 90, -50]), 
        Polygon(points=[40, 0; 60, 5; 60, -5; 40, 0], style(fillColor=3, 
              fillPattern=1))));
    Interfaces.Pin D "Drain" annotation (extent=[90, 40; 110, 60]);
    Interfaces.Pin G "Gate" annotation (extent=[-90, -40; -110, -60]);
    Interfaces.Pin S "Source" annotation (extent=[90, -40; 110, -60]);
    Interfaces.Pin B "Bulk" annotation (extent=[90, -10; 110, 10]);
    parameter SIunits.Length W "Width";
    parameter SIunits.Length L "Length";
    parameter SIunits.Transconductance Beta=2.e-5 
      "Transconductance parameter";
    parameter SIunits.Voltage Vt=0 "Zero bias threshold voltage";
    parameter Real K2=0 "Bulk threshold parameter";
    parameter Real K5=1 "Reduction of pinch-off region";
    parameter SIunits.Length dW=0 "narrowing of channel";
    parameter SIunits.Length dL=0 "shortening of channel";
  protected 
    Real v;
    Real uds;
    Real ubs;
    Real ugst;
    Real ud;
    Real us;
    Real id;
  equation 
    //assert (L + dL > 0, "Effective length must be positive");
    //assert (W + dW > 0, "Effective width  must be positive");
    v = Beta*(W + dW)/(L + dL);
    ud = if (D.v < S.v) then S.v else D.v;
    us = if (D.v < S.v) then D.v else S.v;
    uds = ud - us;
    ubs = if (B.v > us) then 0 else B.v - us;
    ugst = (G.v - us - Vt + K2*ubs)*K5;
    id = if (ugst <= 0) then v*uds*1.e-7 else if (ugst > uds) then v*uds*(ugst
       - uds/2 + 1.e-7) else v*(ugst*ugst/2 + uds*1.e-7);
    G.i = 0;
    D.i = if (D.v < S.v) then -id else id;
    S.i = if (D.v < S.v) then id else -id;
    B.i = 0;
  end NMOS;
  
  model NPN "Simple BJT according to Ebers-Moll" 
    parameter Real Bf=50 "Forward beta";
    parameter Real Br=0.1 "Reverse beta";
    parameter SIunits.Current Is=1.e-16 
      "Transport saturation current";
    parameter SIunits.InversePotential Vak=0.02
      "Early voltage (inverse), 1/Volt";
    parameter SIunits.Time Tauf=0.12e-9 "Ideal forward transit time";
    parameter SIunits.Time Taur=5e-9 "Ideal reverse transit time";
    parameter SIunits.Capacitance Ccs=1e-12 
      "Collector-substrat(ground) cap.";
   parameter SIunits.Capacitance Cje=0.4e-12
      "Base-emitter zero bias depletion cap.";
    parameter SIunits.Capacitance Cjc=0.5e-12 
      "Base-coll. zero bias depletion cap.";
    parameter SIunits.Voltage Phie=0.8 
      "Base-emitter diffusion voltage";
    parameter Real Me=0.4 "Base-emitter gradation exponent";
    parameter SIunits.Voltage Phic=0.8 
      "Base-collector diffusion voltage";
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
<DL>
<DT><b>Note:</b>
<DD>This model is not validated yet. It cannot be used with Dymola 4.0b because of
stability problems within the solver.
</DL>
<P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.22, 
        y=0.28, 
        width=0.6, 
        height=0.6), 
      Icon(
        Text(extent=[-100, 80; 100, 100], string="%name"), 
        Line(points=[-10, 40; -10, -40]), 
        Line(points=[-10, 0; -90, 0]), 
        Line(points=[91, 50; 30, 50]), 
        Line(points=[30, 50; -10, 10]), 
        Line(points=[-10, -10; 30, -50]), 
        Line(points=[30, -50; 91, -50]), 
        Polygon(points=[30, -50; 24, -36; 16, -44; 30, -50], style(fillColor=3
              , fillPattern=1))), 
      Diagram(
        Line(points=[-10, 40; -10, -40]), 
        Line(points=[-10, 0; -90, 0]), 
        Line(points=[30, 50; -10, 10]), 
        Line(points=[-10, -10; 30, -50]), 
        Line(points=[30, -50; 91, -50]), 
        Line(points=[100, 50; 30, 50]), 
        Polygon(points=[30, -50; 24, -36; 16, -44; 30, -50], style(fillColor=3
              , fillPattern=1))));
  public 
    Modelica.Electrical.Analog.Interfaces.Pin C "Collector" annotation (extent
        =[90, 40; 110, 60]);
    Modelica.Electrical.Analog.Interfaces.Pin B "Base" annotation (extent=[-90
          , -10; -110, 10]);
    Modelica.Electrical.Analog.Interfaces.Pin E "Emitter" annotation (extent=[
          90, -40; 110, -60]);
  equation 
    ExMin = exp(EMin);
    ExMax = exp(EMax);
    vbc = B.v - C.v;
    vbe = B.v - E.v;
    qbk = 1 - vbc*Vak;

    ibc = if (vbc/Vt < EMin) then Is*(ExMin*(vbc/Vt - EMin + 1) - 1) + vbc*
      Gbc else if (vbc/Vt > EMax) then Is*(ExMax*(vbc/Vt - EMax + 1) - 1) + vbc
      *Gbc else Is*(exp(vbc/Vt) - 1) + vbc*Gbc;
    ibe = if (vbe/Vt < EMin) then Is*(ExMin*(vbe/Vt - EMin + 1) - 1) + vbe*
      Gbe else if (vbe/Vt > EMax) then Is*(ExMax*(vbe/Vt - EMax + 1) - 1) + vbe
      *Gbe else Is*(exp(vbe/Vt) - 1) + vbe*Gbe;
    Capcjc = if (vbc/Phic > 0) then Cjc*(1 + Mc*vbc/Phic) else Cjc*pow(1 - 
      vbc/Phic, -Mc);
    Capcje = if (vbe/Phie > 0) then Cje*(1 + Me*vbe/Phie) else Cje*pow(1 - 
      vbe/Phie, -Me);
    cbc = if (vbc/Vt < EMin) then Taur*Is/Vt*ExMin*(vbc/Vt - EMin + 1) + 
      Capcjc else if (vbc/Vt > EMax) then Taur*Is/Vt*ExMax*(vbc/Vt - EMax + 1)
       + Capcjc else Taur*Is/Vt*exp(vbc/Vt) + Capcjc;
    cbe = if (vbe/Vt < EMin) then Tauf*Is/Vt*ExMin*(vbe/Vt - EMin + 1) + 
      Capcje else if (vbe/Vt > EMax) then Tauf*Is/Vt*ExMax*(vbe/Vt - EMax + 1)
       + Capcje else Tauf*Is/Vt*exp(vbe/Vt) + Capcje;
    C.i = (ibe - ibc)*qbk - ibc/Br - cbc*der(vbc) + Ccs*der(C.v);
    B.i = ibe/Bf + ibc/Br + cbc*der(vbc) + cbe*der(vbe);
    E.i = -B.i - C.i + Ccs*der(C.v);
  end NPN;
  
  model PNP "Simple BJT according to Ebers-Moll" 
    parameter Real Bf=50 "Forward beta";
    parameter Real Br=0.1 "Reverse beta";
    parameter SIunits.Current Is=1.e-16 
      "Transport saturation current";
    parameter SIunits.InversePotential Vak=0.02
      "Early voltage (inverse), 1/Volt";
    parameter SIunits.Time Tauf=0.12e-9 "Ideal forward transit time";
    parameter SIunits.Time Taur=5e-9 "Ideal reverse transit time";
    parameter SIunits.Capacitance Ccs=1e-12 
      "Collector-substrat(ground) cap.";
   parameter SIunits.Capacitance Cje=0.4e-12
      "Base-emitter zero bias depletion cap.";
    parameter SIunits.Capacitance Cjc=0.5e-12 
      "Base-coll. zero bias depletion cap.";
    parameter SIunits.Voltage Phie=0.8 
      "Base-emitter diffusion voltage";
    parameter Real Me=0.4 "Base-emitter gradation exponent";
    parameter SIunits.Voltage Phic=0.8 
      "Base-collector diffusion voltage";
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
<DL>
<DT><b>Note:</b>
<DD>This model is not validated yet. It cannot be used with Dymola 4.0b because of
stability problems within the solver.
</DL>
<P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Text(extent=[-100, 80; 100, 100], string="%name"), 
        Line(points=[-10, 40; -10, -40]), 
        Line(points=[-10, 0; -90, 0]), 
        Line(points=[91, 50; 30, 50]), 
        Line(points=[30, 50; -10, 10]), 
        Line(points=[-10, -10; 30, -50]), 
        Line(points=[30, -50; 91, -50]), 
        Polygon(points=[-10, -10; 5, -17; -3, -25; -10, -10], style(fillColor=
                3, fillPattern=1))), 
      Diagram(
        Line(points=[-10, 40; -10, -40]), 
        Line(points=[-10, 0; -90, 0]), 
        Line(points=[91, 50; 30, 50]), 
        Line(points=[30, 50; -10, 10]), 
        Line(points=[-10, -10; 30, -50]), 
        Line(points=[30, -50; 91, -50]), 
        Polygon(points=[-10, -10; 5, -17; -3, -25; -10, -10], style(fillColor=
                3, fillPattern=1))));
  public 
    Modelica.Electrical.Analog.Interfaces.Pin C "Collector" annotation (extent
        =[90, 40; 110, 60]);
    Modelica.Electrical.Analog.Interfaces.Pin B "Base" annotation (extent=[-90
          , -10; -110, 10]);
    Modelica.Electrical.Analog.Interfaces.Pin E "Emitter" annotation (extent=[
          90, -40; 110, -60]);
  equation 
    ExMin = exp(EMin);
    ExMax = exp(EMax);
    vbc = C.v - B.v;
    vbe = E.v - B.v;
    qbk = 1 - vbc*Vak;

    ibc = if (vbc/Vt < EMin) then Is*(ExMin*(vbc/Vt - EMin + 1) - 1) + vbc*
      Gbc else if (vbc/Vt > EMax) then Is*(ExMax*(vbc/Vt - EMax + 1) - 1) + vbc
      *Gbc else Is*(exp(vbc/Vt) - 1) + vbc*Gbc;
    
    ibe = if (vbe/Vt < EMin) then Is*(ExMin*(vbe/Vt - EMin + 1) - 1) + vbe*
      Gbe else if (vbe/Vt > EMax) then Is*(ExMax*(vbe/Vt - EMax + 1) - 1) + vbe
      *Gbe else Is*(exp(vbe/Vt) - 1) + vbe*Gbe;
    
    Capcjc = if (vbc/Phic > 0) then Cjc*(1 + Mc*vbc/Phic) else Cjc*pow(1 - 
      vbc/Phic, -Mc);
    Capcje = if (vbe/Phie > 0) then Cje*(1 + Me*vbe/Phie) else Cje*pow(1 - 
      vbe/Phie, -Me);
    cbc = if (vbc/Vt < EMin) then Taur*Is/Vt*ExMin*(vbc/Vt - EMin + 1) + 
      Capcjc else if (vbc/Vt > EMax) then Taur*Is/Vt*ExMax*(vbc/Vt - EMax + 1)
       + Capcjc else Taur*Is/Vt*exp(vbc/Vt) + Capcjc;
    cbe = if (vbe/Vt < EMin) then Tauf*Is/Vt*ExMin*(vbe/Vt - EMin + 1) + 
      Capcje else if (vbe/Vt > EMax) then Tauf*Is/Vt*ExMax*(vbe/Vt - EMax + 1)
       + Capcje else Tauf*Is/Vt*exp(vbe/Vt) + Capcje;
    C.i = -((ibe - ibc)*qbk - ibc/Br - cbc*der(vbc) + Ccs*der(C.v));
    B.i = -(ibe/Bf + ibc/Br + cbe*der(vbe) + cbc*der(vbc));
    E.i = -B.i - C.i - Ccs*der(C.v);
  end PNP;
end Semiconductors;
