within Modelica.Electrical;
package Spice3 "Library for components of the Berkeley SPICE3 simulator"
  import SI = Modelica.SIunits;

extends Modelica.Icons.Package;

  package UsersGuide "User's Guide"
    extends Modelica.Icons.Information;
  class Overview "Overview"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<h4>Overview of Spice3 library</h4>
<p>The Spice3 library is a Modelica library that contains some models of the Berkeley SPICE3 analog simulator.</p>
<p><u>General information about the analog simulator SPICE3 </u></p>
<p>SPICE (Simulation Program with Integrated Circuit Emphasis) is a simulator for analog electrical circuits. It was developed as one of the first analog simulators in the university of Berkeley. SPICE netlists, which contain the circuit that shall be simulated, are a de-facto-standard up to now. For nearly every electrical circuit a SPICE netlist exists. Today the current version of SPICE is SPICE3e/SPICE3f. SPICE contains basic elements (resistor, inductor, capacitor), sources and semiconductor devices (diode, bipolar transistors, junction field effect transistors, MOS-field effect transistors) as well as models of lines. Out of this offered pool of elements, the circuits that shall be simulated are build as SPICE netlists.</p>
<p><u>The Spice3-library for Modelica</u></p>
<p>The Spice3 library was extracted from original SPICE3 C++ code. To be sure the Modelica models are correct the simulation results were compared to SPICE3. This way was chosen since SPICE3 is the only open source Spice simulator.</p>
<p>The Spice3-library was built in accordance to the model structure in SPICE. It contains the following packages:</p>
<ul>
<li>Examples</li>
<li>Basic (R, C, L, controlled sources)</li>
<li>Semiconductors (MOS (P, N), BJT(NPN PNP), Diode, semiconductor resistor)</li>
<li>Sources (constant, sinusoidal, exponential, pulse, piece wise linear, single-frequency FM, respectively for V and I)</li>
<li>Additionals (useful features from SPICE2)</li>
<li>Interfaces</li>
<li>Internal (functions and data needed to model the semiconductor devices)<br></li>
</ul>
<p>Since the semiconductor models, especially MOS and BJT, are very complex models, many functions, data and parameters were needed for their description. Therefore a special Package called Internal was created that contains all the functions and records with data and parameters that are needed for the semiconductor models. It is not necessary that a user of the library works inside this package, so it is not for user access. The package Additionals is also a special one. It is not part of the original SPICE3. Nevertheless it contains useful models or features like the polynomial sources of SPICE2 that are often asked for.</p>
<p>There are many commercial SPICE simulators (PSPICE, NgSPICE, HSPICE, ...) which are derived from the Berkeley SPICE or are in some relation to it. Netlists of such SPICE derivatives can differ from Berkeley SPICE3 netlists. This has to be taken into account if netlists (their parameter names) are used with this package.</p>
</html>"));
  end Overview;

  class Useofsemiconductors "Use of Semiconductors"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p>Within the semiconductor devices SPICE3 differentiates between technology parameters and device parameters. Device parameters can be chosen for every single model instance, e.g., the channel length of a transistor. Technology parameters which are specified in a model card (.model) are adjustable for more than one element simultaneously, e.g. the type of transistors. As usually done in Modelica the parameters of the modelcard can be set in a parameter list.</p>
<p>To parametrize more than one model two ways are possible:</p>
<ol>
<li>Apart record:<br>For each transistor in the circuit a record with the technology parameters is made available as an instance of the record modelcardMOS. In the example<br>&quot;inverterApartRecord&quot; this way is explained more in detail.</li>
<li>Extended model:<br>For each set of technology parameters a apart model has to be defined. In the example &quot;inverterExtendedModel&quot; this way is explained more in detail.</li>
</ol>
</html>"));

  end Useofsemiconductors;

  class Spicenetlist "SPICE3 netlists"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<h4>Translation of SPICE3 netlists to Modelica </h4>
<p>Since SPICE3 netlists are available for nearly every electrical circuit a desirable feature would be to translate SPICE3 netlists to Modelica. With the help of the example of an inverter circuits a possible way of the translation will be explained.</p>

<table cellspacing=\"0\" cellpadding=\"0\" border=\"1\">
<caption>Table 1: Translation of the SPICE3 netlist (left side) to Modelica (right side)</caption>
<tr>
<td><pre>
inverter

Mp1 11 1 13 11 MPmos
Mp2 11 13 2 11 MPmos
Mn1 13 1 0 0 MNmos
Mn2 2 13 0 0 MNmos
Vgate 1 0 PULSE(0 5 2s 1s)
Vdrain 11 0 PULSE(0 5 0s 1s)
.model MPmos PMOS (gamma=0.37)
.model MNmos NMOS (gamma=0.37 lambda=0.02)















.tran 0.01 5
.end</pre></td>
<td><pre>
model inverter
  Spice3.Basic.Ground g;
  Spice3&hellip;M Mp1(mtype=true, M(GAMMA=0.37));
  Spice3&hellip;M Mp2(mtype=true, M(GAMMA=0.37));
  Spice3&hellip;M Mn1(M(LAMBDA=0.02, GAMMA=0.37));
  Spice3&hellip;M Mn2(p(LAMBDA=0.02, GAMMA=0.37));
  Spice3&hellip;V_pulse vdrain(V1=0, V2=5, TD=0, TR=1);
  Spice3&hellip;V_pulse vdrain(V1=0, V2=5, TD=0, TR=1);


  Spice3.Interfaces.Pin p_in, p_out;
protected
  Spice3.Interfaces.Pin n0, n1, n2, n11, n13;
equation
  connect(p_in, n1);    connect(p_out, n2);
  connect(g.p, n0);
  connect(vdrain.n,n0); connect(vdrain.p,n11);
  connect(Mp1.B,n11);   connect(Mp1.D, n11);
  connect(Mp1.G, n1);   connect(Mp1.S, n13);
  connect(Mp2.B,n11);   connect(Mp2.D, n11);
  connect(Mp2.G, n13);  connect(Mp2.S, n2);
  connect(Mn1.B,n0);    connect(Mn1.D, n13);
  connect(Mn1.G, n1);   connect(Mn1.S, n0);
  connect(Mn2.B,n0);    connect(Mn2.D, n2);
  connect(Mn2.G, n13);  connect(Mn2.S, n0);

end inverter;
</pre></td>
</tr>
</table>

<p>Given is a SPICE3 netlist that contains two inverter circuits. This netlist should be translated to Modelica in which the input voltage of the first inverter (node number 1) and the output voltage of the second inverter (node number 2) will later be connected with the surrounding circuit.</p>
<p>The following steps are necessary:</p>
<ol>
<li>A name for the Modelica model has to be chosen. It could be taken from the first line of the SPICE3 netlist.</li>
<li>The ground node has to be instantiated (i.e., <code>Spice3.Basic.Ground</code>).</li>
<li>For each component of the netlist an instant has to be created. According to the first letter of the SPICE3 model identifier in the netlist, the needed component has to be chosen, instantiated and according to the given parameters parametrized, e.g., the SPICE lineVdrain 11 0 PULSE(0 5 0 1)becomes the following Modelica line: <code>Spice3&hellip;V_pulse vdrain(V1=0, V2=5, TD=0, TR=1);</code></li>
<li>For all node numbers an internal pin has to be created. For example the node number 2 from the SPICE3 netlist becomes
<pre>
protected Spice3.Interfaces.Pin n2;
</pre>
in Modelica. The code letter (here <code>n</code>) is needed because a single number is no name in Modelica.</li>
<li>According to the netlist the internal pins have to be connected with the components, e.g., <code>connect(Mp1.D, n11)</code>.</li>
<li>In the last step the external pins have to be allocated ant connected to the according internal pin. In Table&nbsp;1 this is done as follows:
<pre>
Spice3.Interfaces.Pin p_in, p_out;
connect(p_in, n1);
connect(p_out, n2);
</pre>
</li>
</ol>
</html>"));
  end Spicenetlist;

  class NamingPrinciple "Naming principle"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p>In SPICE3 we have a predefined model pool. Each model device has got a code letter (e.g., resistor - R). In analogy to the SPICE3 models the models of the Spice3 library also got the according code letter in their names. The following examples shows the relationship:</p>
<p>A typical SPICE3 line could be:</p>
<p><strong>C</strong>1 3 2 1pF</p>
<p>The first letter is the code letter (here <strong>C</strong>). It specifies the type of the model component (here capacitance). To see the analogy to the SPICE3 models in the Spice3 library the transformed capacitance has got the name <strong>C</strong>_Capacitance. According to that naming rule the components of the Spice3 library have the following names (the first letter is the code letter that has to be used in SPICE3):</p>
<ul>
<li>R_Resistor</li>
<li>C_Capacitance</li>
<li>L_Inductor</li>
<li>E_VCV, E_VCV_POLY</li>
<li>G_VCC, G_VCC_POLY</li>
<li>H_CCV, H_CCV_POLY</li>
<li>F_CCC, F_CCC_POLY</li>
<li>M_PMOS</li>
<li>M_NMOS</li>
<li>Q_NPNBJT</li>
<li>Q_PNPBJT</li>
<li>D_Diode</li>
<li>V_constant, I_constant</li>
<li>V_sin, I_sin</li>
<li>V_exp, I_exp</li>
<li>V_pulse, I_pulse</li>
<li>V_pwl, I_pwl</li>
<li>V_sffm, I_sffm<br/><strong><br/></strong></li>
</ul>
</html>"));
  end NamingPrinciple;

  class ParameterHandling "Parameter handling"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p>In SPICE3 it is important to know whether a parameter was set by the user or not because the calculation of some values depends on that information and can be different. Since in Modelica there is no possibility to check that, a circumvention was chosen. The relevant parameters get an unrealistic value (-1e40) as their default value. Within a function it is checked if the parameter has still got this value (the parameter was not set by the user) of if it has a new value (parameter was set by the user).</p>
</html>"));
  end ParameterHandling;

  class Literature "Literature"
    extends Modelica.Icons.References;

    annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\"><tr>
<td><p>[B&ouml;hme2009]</p></td>
<td><p>S. B&ouml;hme, K. Majetta, C. Clauss, P. Schneider, &quot;Spice3 Modelica Library,&quot; <em>7th Modelica Conference</em>, Como, Italy (2009)</p></td>
<td></td>
</tr>
<tr>
<td><p>[Antognetti1988]</p></td>
<td><p>P. Antognetti, G. Massobrio, <em>Semiconductor Device Modeling with SPICE.</em>, McGraw-Hill Book Company, USA, 1988</p></td>
<td></td>
</tr>
<tr>
<td><p>[Connelly1992]</p></td>
<td><p>A. Connelly, A, P. Choi, <em>Macromodeling with SPICE.</em>, Prentice-Hall, New Jersey, USA (1992)</p></td>
<td></td>
</tr>
<tr>
<td><p>[Johnson1991]</p></td>
<td><p>B. Johnson, T. Quarles, A.R. Newton, D. O. Pederson, A. Sangiovanni-Vincentelli, <em>SPICE3 Version 3f User's Manual.</em>, University of Berkeley, Department of Electrical Engineering and Computer Sciences, USA (1991): <a href=\"modelica://Modelica/Resources/Documentation/Electrical/Spice3/Spice_3f3_Users_Manual.pdf\">SPICE3 user's manual</a> (&copy; Regents of the University of California)</p></td>
<td></td>
</tr>
<tr>
<td><p>[Kielkowski1994]</p></td>
<td><p>R. Kielkowski, <em>Inside SPICE - Overcoming the obstacles of circuit simulation.</em>, McGraw-Hill, USA (1994)</p></td>
</tr>
</table>
</html>"));
  end Literature;

  class ReleaseNotes "Release notes"
    extends Modelica.Icons.ReleaseNotes;

    annotation (Documentation(info="<html>
<p>This section summarizes the changes that have been performed on the Spice3 library.</p>
<ul>
<li>Version 1.0 (2010-02-18): first version of the library was released</li>
</ul>
</html>", revisions="<html>
<ul>
<li><em>15th March 2012 by Kristin Majetta</em><br/>SPICE3 benchmark RTL Inverter</li>
<li><em>14th March 2012 by Kristin Majetta</em><br/>SPICE3 benchmark Mosfet characterisation</li>
<li><em>14th March 2012 by Kristin Majetta</em><br/>SPICE3 benchmark Differential Pair added</li>
<li><em>12th March 2012 by Kristin Majetta</em><br/>BJT model improved</li>
<li><em>09th March 2012 by Kristin Majetta</em><br/>MOS Level 2 model added</li>
<li><em>24th February 2012 by Kristin Majetta</em><br/>JFET model added</li>
<li><em>23rd February 2012 by Kristin Majetta</em><br/>Semiconductor Capacitor added</li>
<li><em>21st February 2012</em> by Kristin Majetta<br/>CoupledInductors (K) added</li>
<li><em>March 2010</em> by Kristin Majetta<br/>Guidelines applied, User&#39;s Guide added</li>
<li><em>February 2010</em> by Kristin Majetta<br/>Spice3 library added to MSL and examples revised</li>
<li><em>September 2009</em> by Kristin Majetta <br/>Bipolar transistor implemented</li>
<li><em>August 2009</em> by Jonathan Kress <br/>default values in sources improved</li>
<li><em>August 2009</em> by Kristin Majetta <br/>Bipolar transistor started</li>
<li><em>April 2009</em> by Kristin Majetta <br/>Semiconductor Resistor implemented</li>
<li><em>March 2009</em> by Kristin Majetta <br/>DIODE implemented</li>
<li><em>25th February 2009</em> by Kristin Majetta <br/>MOS Level 2 implemented</li>
<li><em>15th October 2008</em> by Kristin Majetta <br/>minor errors fixed in L_Inductor, I_Pulse and SpiceRoot</li>
<li><em>April, 2008</em> by Sandra Boehme <br/>initially implemented<br/></li>
</ul>
</html>"));

  end ReleaseNotes;

  class Contact "Contact"
    extends Modelica.Icons.Contact;

    annotation (Documentation(info="<html>
<h4>Main Authors</h4>

<dl>
<dt><strong>Kristin Majetta</strong></dt>
<dd>email: <a href=\"mailto:Kristin.Majetta@eas.iis.fraunhofer.de\">Kristin Majetta@eas.iis.fraunhofer.de</a></dd>
<dt><strong>Christoph Clauss</strong></dt>
<dd>email: <a href=\"mailto:christoph@clauss-it.com\">christoph@clauss-it.com</a></dd>
<dt><strong>Sandra Boehme</strong></dt>
<dd>email: <a href=\"mailto:Sandra.Boehme@eas.iis.fraunhofer.de\">Sandra.Boehme@eas.iis.fraunhofer.de</a></dd>
</dl>

<dl>
<dt>Address</dt>
<dd>Fraunhofer Institute Integrated Circuits<br />
Design Automation Division<br />
Zeunerstra&szlig;e 38<br />
01069 Dresden, Germany</dd>
</dl>

<h4>Acknowledgements</h4>

<ul>
<li>The development of this library was done within the European ITEA2 projects EUROSYSLIB and MODELISAR.</li>
<li>For his contribution we thank Mr. Jonathan Gerbet.</li>
</ul>
</html>"));
  end Contact;

  annotation (DocumentationClass=true, Documentation(info="<html>
<p>Package Spice3 is a <strong>free</strong> Modelica package</p>
<p>This is a short <strong>User's Guide</strong> for the overall library.</p>
</html>",   revisions="<html>
<ul>
<li><em>Feb 2010</em> by Kristin Majetta initially written</li>
</ul>
</html>"));
  end UsersGuide;

  package Examples "Example circuits"
  extends Modelica.Icons.ExamplesPackage;

    model Inverter "Simple inverter circuit"
    //--------------------------------------------------------------------------------------------------------------

    //--------------------------------------------------------------------------------------------------------------
      extends Modelica.Icons.Example;

      Semiconductors.M_PMOS mp(modelcard(
          RD=0,
          RS=0,
          CBD=0,
          CBS=0), Sinternal(start=0),IC=-1e40)
        annotation (Placement(transformation(extent={{-14,8},{6,28}})));
      Semiconductors.M_NMOS mn(modelcard(
          RD=0,
          RS=0,
          CBD=0,
          CBS=0), IC=-1e40)
        annotation (Placement(transformation(extent={{-14,-34},{6,-14}})));
      Basic.Ground ground
        annotation (Placement(transformation(extent={{-14,-60},{6,-40}})));
      Sources.V_pulse vin(
        V2=5,
        TD=4e-12,
        TR=0.1e-12,
        TF=0.1e-12,
        PW=1e-12,
        PER=2e-12) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-40,-16})));
      Sources.V_pulse v(V2=5, TR=0.1e-12) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={40,-4})));
    equation
      connect(mn.D,mp. S) annotation (Line(
          points={{-4,-14},{-4,8}}, color={0,0,255}));
      connect(mp.G,mn. G) annotation (Line(
          points={{-14,17.9},{-14,-24.1}}, color={0,0,255}));
      connect(mn.S,mn. B) annotation (Line(
          points={{-4,-34},{6,-34},{6,-24}}));
      connect(mp.B,mp. D) annotation (Line(
          points={{6,18},{6,28},{-4,28}}, color={0,0,255}));
      connect(mn.S, ground.p) annotation (Line(
          points={{-4,-34},{-4,-40}}));
      connect(v.p,mp. D) annotation (Line(
          points={{40,6},{40,28},{-4,28}}, color={0,0,255}));
      connect(v.n, ground.p) annotation (Line(
          points={{40,-14},{40,-40},{-4,-40}}));
      connect(vin.p,mp. G) annotation (Line(
          points={{-40,-6},{-40,17.9},{-14,17.9}}, color={0,0,255}));
      connect(vin.n, ground.p) annotation (Line(
          points={{-40,-26},{-40,-40},{-4,-40}}));
      annotation (experiment(
          StopTime=1e-11,
          Interval=5e-15,
          Tolerance=1e-7),
        Documentation(info="<html>
<p>An inverter is an electrical circuit that consists of a PMOS and a NMOS transistor. Its task is to turn the input voltage from high potential to low potential or the other way round.</p>
<p>Simulate until 1e-11 s. Display the input voltage vin.p.v as well as the output voltage mp.S.v. It shows that the input voltage is inverted.</p>
</html>", revisions="<html>
<ul>
<li><em>March 2009</em> by Kristin Majetta initially implemented</li>
</ul>
</html>"));
    end Inverter;

    model InvertersApartRecord
      "Two inverters where transistor models use different modelcard instances"
      extends Modelica.Icons.Example;

      Basic.Ground ground annotation (Placement(transformation(extent={{-38,-80},
                {-18,-60}})));
    //--------------------------------------------------------------------------------------------------------------
    /*apart record: For each transistor in the circuit a record with the technology parameters is made available
  as an instance of the record modelcardMOS */
      parameter Semiconductors.ModelcardMOS MPmos(GAMMA=0.37, CBD=0, CBS=0)
        "Specified modelcardMOS for MPmos"; //instance of record modelcardMOS
      parameter Semiconductors.ModelcardMOS MNmos(GAMMA=0.37, LAMBDA=0.02, CBD=0, CBS=0)
        "Specified modelcardMOS for MNmos";
                                             //instance of record modelcardMOS
      Semiconductors.M_PMOS mp1(modelcard=MPmos, IC=-1e40)
                annotation (Placement(transformation(extent={{-38,20},{-18,40}})));
      Semiconductors.M_NMOS mn1(modelcard=MNmos, IC=-1e40)
                annotation (Placement(transformation(extent={{-38,-30},{-18,-10}})));
      Semiconductors.M_PMOS mp2(modelcard=MPmos, IC=-1e40)
                annotation (Placement(transformation(extent={{2,20},{22,40}})));
      Semiconductors.M_NMOS mn2(modelcard=MNmos, IC=-1e40)
                annotation (Placement(transformation(extent={{2,-30},{22,-10}})));
    //--------------------------------------------------------------------------------------------------------------

      Basic.C_Capacitor c1(C=1e-5,
        IC=0,
        UIC=true)
        annotation (Placement(transformation(
            origin={-8,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Basic.C_Capacitor c2(C=1e-5,
        IC=0,
        UIC=true)
        annotation (Placement(transformation(
            origin={34,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));

      Sources.V_pulse vin(
        V2=5,
        TD=2,
        TR=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-60,-32})));
      Sources.V_pulse v(V2=5, TR=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={60,-32})));
    equation
      connect(mp1.B, mp1.D) annotation (Line(points={{-18,30},{-18,40},{-28,
              40}}, color={0,0,255}));
      connect(mn1.S, ground.p)
        annotation (Line(points={{-28,-30},{-28,-60}}, color={0,0,255}));
      connect(mp1.S, mn1.D)
        annotation (Line(points={{-28,20},{-28,-10}}, color={0,0,255}));
      connect(mn1.G, mp1.G) annotation (Line(points={{-38,-20.1},{-38,29.9}}, color={0,0,255}));
      connect(mn1.B, mn1.S) annotation (Line(points={{-18,-20},{-18,-30},{-28,
              -30}}, color={0,0,255}));
      connect(mp2.B, mp2.D) annotation (Line(points={{22,30},{22,40},{12,40}}, color={0,0,255}));
      connect(mn2.S, ground.p) annotation (Line(points={{12,-30},{12,-60},{-28,
              -60}}, color={0,0,255}));
      connect(mp2.S, mn2.D)
        annotation (Line(points={{12,20},{12,-10}}, color={0,0,255}));
      connect(mn2.G, mp2.G) annotation (Line(points={{2,-20.1},{2,29.9}}, color={0,0,255}));
      connect(mn2.B, mn2.S) annotation (Line(points={{22,-20},{22,-30},{12,
              -30}}, color={0,0,255}));
      connect(mp2.G, mn1.D) annotation (Line(points={{2,29.9},{2,0},{-28,0},{
              -28,-10}}, color={0,0,255}));
      connect(c1.p, mn1.D) annotation (Line(points={{-8,-20},{-8,0},{-28,0},{
              -28,-10}}, color={0,0,255}));
      connect(mn2.D, c2.p) annotation (Line(points={{12,-10},{12,0},{34,0},{34,
              -20}}, color={0,0,255}));
      connect(c2.n, ground.p) annotation (Line(points={{34,-40},{34,-60},{-28,
              -60}}, color={0,0,255}));
      connect(c1.n, ground.p) annotation (Line(points={{-8,-40},{-8,-60},{-28,
              -60}}, color={0,0,255}));
      connect(mp1.G, vin.p) annotation (Line(
          points={{-38,29.9},{-60,29.9},{-60,-22}}, color={0,0,255}));
      connect(vin.n, ground.p) annotation (Line(
          points={{-60,-42},{-60,-60},{-28,-60}}));
      connect(v.p, mp2.D) annotation (Line(
          points={{60,-22},{60,40},{12,40}}, color={0,0,255}));
      connect(mp1.D, mp2.D) annotation (Line(
          points={{-28,40},{12,40}}, color={0,0,255}));
      connect(v.n, ground.p) annotation (Line(
          points={{60,-42},{60,-60},{-28,-60}}));
      annotation (experiment(StopTime=5),
        Documentation(info="<html>
<p>An inverter is an electrical circuit that consists of a PMOS and a NMOS. Its task is to turn the input voltage from high potential to low potential or the other way round. This circuit <em>InverterApartModel</em> contains two inverters. The input voltage of the first inverter is nearly equal to the output voltage of the second inverter. Capacities cause some differences.</p>
<p>To see the typical behavior of the circuit the input voltages and the output voltages should be plotted. Besides that it can be interesting to watch the output voltage of the first inverter. Simulated until t=5s.</p>
<p>Input voltages: vin.p.v and v.p.v</p>
<p>Output voltage of the first inverter: mn1.D.v</p>
<p>Output voltage of the second Inverter: mn2.D.v</p>
<p>This example shows one possibility to make the record of the technology parameters available for more than one transistor. For each transistor in the circuit a record with the technology parameters is made available as an instance of the record modelcardMOS. In this circuit we need two different records for technology parameters, one for PMOS (MPmos) and one for NMOS (MNmos). This instances of the record for the technology parameters were made available for every transistor as one of theirs parameters (Spice3.Repository.MOS mn1(mtype=0, modelcard=MNmos).</p>
</html>", revisions="<html>
<ul>
<li><em>April 2009</em> by Kristin Majetta initially implemented</li>
</ul>
</html>"));
    end InvertersApartRecord;

    model InvertersExtendedModel
      "Two inverters with MOS models defined by inheritance"
      extends Modelica.Icons.Example;

      Basic.Ground ground annotation (Placement(transformation(extent={{-40,-80},
                {-20,-60}})));
    //--------------------------------------------------------------------------------------------------------------
    /*extended model: For each set of technology parameters an apart model has to be defined. Every transistor extends
  this model. In this process the required technology parameters are specified. */

      model MPmos "PMOS transistor with specified modelcard"
        parameter Semiconductors.ModelcardMOS M(GAMMA=0.37, CBD=0, CBS=0);
        extends Semiconductors.M_PMOS(modelcard=M);
        annotation (Documentation(info="<html>
<p>This model MPmos is inherited by the model <em>InverterExtendedModel</em> to build an inverter circuit. For detailed information</p><p>please see <em>InverterExtendedModel</em>.</p>
</html>"));
      end MPmos;

      model MNmos "NMOS transistor with specified modelcard"
        parameter Semiconductors.ModelcardMOS M(GAMMA=0.37, LAMBDA=0.02, CBD=0, CBS=0);
        extends Semiconductors.M_NMOS(modelcard=M);
        annotation (Documentation(info="<html>
<p>This model MNmos is inherited by the model <em>InverterExtendedModel</em> to build an inverter circuit. For detailed information</p><p>please see <em>InverterExtendedModel</em>.</p>
</html>"));
      end MNmos;

      MPmos mp1(IC=-1e40) annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      MNmos mn1(IC=-1e40) annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
      MPmos mp2(IC=-1e40) annotation (Placement(transformation(extent={{0,20},{20,40}})));
      MNmos mn2(IC=-1e40) annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
    //--------------------------------------------------------------------------------------------------------------

      Basic.C_Capacitor c1(C=1e-5,
        IC=0,
        UIC=true)
        annotation (Placement(transformation(
            origin={-10,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Basic.C_Capacitor c2(C=1e-5,
        IC=0,
        UIC=true)
        annotation (Placement(transformation(
            origin={32,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));

      Sources.V_pulse vin(
        V2=5,
        TD=2,
        TR=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-60,-22})));
      Sources.V_pulse v(V2=5, TR=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={56,-22})));
    equation
      connect(mp1.B, mp1.D) annotation (Line(points={{-20,30},{-20,40},{-30,40}}, color={0,0,255}));
      connect(mn1.S, ground.p)
        annotation (Line(points={{-30,-30},{-30,-60}}, color={0,0,255}));
      connect(mp1.S, mn1.D)
        annotation (Line(points={{-30,20},{-30,-10}}, color={0,0,255}));
      connect(mn1.G, mp1.G) annotation (Line(points={{-40,-20.1},{-40,29.9}}, color={0,0,255}));
      connect(mn1.B, mn1.S) annotation (Line(points={{-20,-20},{-20,-30},{-30,-30}}, color={0,0,255}));
      connect(mp2.B, mp2.D) annotation (Line(points={{20,30},{20,40},{10,40}}, color={0,0,255}));
      connect(mn2.S, ground.p) annotation (Line(points={{10,-30},{10,-60},{-30,-60}}, color={0,0,255}));
      connect(mp2.S, mn2.D)
        annotation (Line(points={{10,20},{10,-10}}, color={0,0,255}));
      connect(mn2.G, mp2.G) annotation (Line(points={{0,-20.1},{0,29.9}}, color={0,0,255}));
      connect(mn2.B, mn2.S) annotation (Line(points={{20,-20},{20,-30},{10,-30}}, color={0,0,255}));
      connect(mp2.G, mn1.D) annotation (Line(points={{0,29.9},{0,0},{-30,0},{-30,-10}}, color={0,0,255}));
      connect(c1.p, mn1.D) annotation (Line(points={{-10,-20},{-10,0},{-30,0},{
              -30,-10}}, color={0,0,255}));
      connect(mn2.D, c2.p) annotation (Line(points={{10,-10},{10,0},{32,0},{32,-20}}, color={0,0,255}));
      connect(c2.n, ground.p) annotation (Line(points={{32,-40},{32,-60},{-30,
              -60}}, color={0,0,255}));
      connect(c1.n, ground.p) annotation (Line(points={{-10,-40},{-10,-60},{-30,
              -60}}, color={0,0,255}));
      connect(vin.p, mp1.G) annotation (Line(
          points={{-60,-12},{-60,26},{-40,26},{-40,29.9}}, color={0,0,255}));
      connect(vin.n, ground.p) annotation (Line(
          points={{-60,-32},{-60,-60},{-30,-60}}));
      connect(v.p, mp2.D) annotation (Line(
          points={{56,-12},{56,40},{10,40}}, color={0,0,255}));
      connect(mp2.D, mp1.D) annotation (Line(
          points={{10,40},{-30,40}}, color={0,0,255}));
      connect(v.n, ground.p) annotation (Line(
          points={{56,-32},{56,-60},{-30,-60}}));
      annotation (experiment(StopTime=5),
        Documentation(info="<html>
<p>An inverter is an electrical circuit that consists of a PMOS and a NMOS. Its task is to turn the input voltage from high potential to low potential or the other way round. This circuit <em>InverterExtendedModel</em> contains two inverters. The input voltage of the first inverter is nearly equal to the output voltage of the second inverter. Capacities cause some differences.</p>
<p>To see the typical behavior of the circuit the input voltages and the output voltages should be plotted. Besides that it can be interesting to watch the output voltage of the first inverter. Simulated until t=5s.</p>
<p>Input voltages: vin.p.v and v.p.v</p>
<p>Output voltage of the first inverter: mn1.D.v</p>
<p>Output voltage of the second Inverter: mn2.D.v</p>
<p>This example shows one possibility to make the record of the technology parameters available for more than one transistor. For each set of technology parameters an apart model has to be defined (in this example: MPmos ans MNmos). Inside the model definition the technology parameters are appointed (Spice3.Semiconductors.modelcardMOS M(GAMMA=0.37, LAMBDA=0.02)). Every model extends a transistor. In this process the required technology parameters are specified (extends Spice3.Repository.MOS(final mtype=1, modelcard=M). To make transistors available in the circuit instances of the defined models are applied (MPmos mp1; MNmos mn1; MPmos mp2; MNmos mn2;).</p>
</html>", revisions="<html>
<ul>
<li><em>April 2009</em> by Kristin Majetta initially implemented</li>
</ul>
</html>"));
    end InvertersExtendedModel;

    model FourInverters
      "Four inverters with MOSFET level 1, using private record as model card"
      extends Modelica.Icons.Example;

      Basic.Ground ground annotation (Placement(transformation(extent={{-74,-80},
                {-54,-60}})));

      parameter Semiconductors.ModelcardMOS modp(CBD=0, CBS=0)
        "Private PMOS modelcard";
      parameter Semiconductors.ModelcardMOS modn(CBD=0, CBS=0)
        "Private NMOS modelcard";

      Semiconductors.M_PMOS mp1(modelcard=modp, IC=-1e40)
                annotation (Placement(transformation(extent={{-74,20},{-54,40}})));
      Semiconductors.M_NMOS mn1(modelcard=modn, IC=-1e40)
                annotation (Placement(transformation(extent={{-74,-30},{-54,-10}})));
      Semiconductors.M_PMOS mp2(modelcard=modp, IC=-1e40)
                annotation (Placement(transformation(extent={{-34,20},{-14,40}})));
      Semiconductors.M_NMOS mn2(modelcard=modn, IC=-1e40)
                annotation (Placement(transformation(extent={{-34,-30},{-14,-10}})));
      Semiconductors.M_PMOS mp3(modelcard=modp, IC=-1e40)
                annotation (Placement(transformation(extent={{6,20},{26,40}})));
      Semiconductors.M_NMOS mn3(modelcard=modp, IC=-1e40)
                annotation (Placement(transformation(extent={{6,-30},{26,-10}})));
      Semiconductors.M_PMOS mp4(modelcard=modn, IC=-1e40)
                annotation (Placement(transformation(extent={{46,20},{66,40}})));
      Semiconductors.M_NMOS mn4(modelcard=modn, IC=-1e40)
                annotation (Placement(transformation(extent={{46,-30},{66,-10}})));
      Basic.C_Capacitor c1(C=10e-6,
        IC=0,
        UIC=true)
        annotation (Placement(transformation(
            origin={-44,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Basic.C_Capacitor c2(C=10e-6,
        IC=0,
        UIC=true)
        annotation (Placement(transformation(
            origin={-2,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Basic.C_Capacitor c3(C=10e-6,
        IC=0,
        UIC=true)
        annotation (Placement(transformation(
            origin={36,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Basic.C_Capacitor c4(C=10e-6,
        IC=0,
        UIC=true)
        annotation (Placement(transformation(
            origin={76,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Sources.V_pulse vin(
        V2=5,
        TD=2,
        TR=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-86,-42})));
      Sources.V_pulse v(V2=5, TR=1) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={92,-48})));
    equation
      connect(mp1.B, mp1.D) annotation (Line(points={{-54,30},{-54,40},{-64,
              40}}, color={0,0,255}));
      connect(mn1.S, ground.p)
        annotation (Line(points={{-64,-30},{-64,-60}}, color={0,0,255}));
      connect(mp1.S, mn1.D)
        annotation (Line(points={{-64,20},{-64,-10}}, color={0,0,255}));
      connect(mn1.G, mp1.G) annotation (Line(points={{-74,-20.1},{-74,29.9}}, color={0,0,255}));
      connect(mn1.B, mn1.S) annotation (Line(points={{-54,-20},{-54,-30},{-64,
              -30}}, color={0,0,255}));
      connect(mp2.B, mp2.D) annotation (Line(points={{-14,30},{-14,40},{-24,
              40}}, color={0,0,255}));
      connect(mn2.S, ground.p) annotation (Line(points={{-24,-30},{-24,-60},{
              -64,-60}}, color={0,0,255}));
      connect(mp2.S, mn2.D)
        annotation (Line(points={{-24,20},{-24,-10}}, color={0,0,255}));
      connect(mn2.G, mp2.G) annotation (Line(points={{-34,-20.1},{-34,29.9}}, color={0,0,255}));
      connect(mn2.B, mn2.S) annotation (Line(points={{-14,-20},{-14,-30},{-24,
              -30}}, color={0,0,255}));
      connect(c1.p, mn1.D) annotation (Line(points={{-44,-20},{-44,0},{-64,0},
              {-64,-10}}, color={0,0,255}));
      connect(mn2.D, c2.p) annotation (Line(points={{-24,-10},{-24,0},{-2,0},{
              -2,-20}}, color={0,0,255}));
      connect(c2.n, ground.p) annotation (Line(points={{-2,-40},{-2,-60},{-64,
              -60}}, color={0,0,255}));
      connect(c1.n, ground.p) annotation (Line(points={{-44,-40},{-44,-60},{-64,
              -60}}, color={0,0,255}));
      connect(c3.n, ground.p) annotation (Line(points={{36,-40},{36,-60},{-64,
              -60}}, color={0,0,255}));
      connect(c4.n, ground.p) annotation (Line(points={{76,-40},{76,-60},{-64,
              -60}}, color={0,0,255}));
      connect(mn4.B, mn4.S) annotation (Line(points={{66,-20},{66,-30},{56,
              -30}}, color={0,0,255}));
      connect(mn3.B, mn3.S) annotation (Line(points={{26,-20},{26,-30},{16,
              -30}}, color={0,0,255}));
      connect(mp3.B, mp3.D) annotation (Line(points={{26,30},{26,40},{16,40}}, color={0,0,255}));
      connect(mp4.B, mp4.D) annotation (Line(points={{66,30},{66,40},{56,40}}, color={0,0,255}));
      connect(mp3.S, mn3.D)
        annotation (Line(points={{16,20},{16,-10}}, color={0,0,255}));
      connect(mp4.S, mn4.D)
        annotation (Line(points={{56,20},{56,-10}}, color={0,0,255}));
      connect(mn3.S, ground.p) annotation (Line(points={{16,-30},{16,-60},{-64,
              -60}}, color={0,0,255}));
      connect(mn4.S, ground.p) annotation (Line(points={{56,-30},{56,-60},{-64,
              -60}}, color={0,0,255}));
      connect(c3.p, mn3.D) annotation (Line(points={{36,-20},{36,0},{16,0},{16,
              -10}}, color={0,0,255}));
      connect(c4.p, mn4.D) annotation (Line(points={{76,-20},{76,0},{56,0},{56,
              -10}}, color={0,0,255}));
      connect(c2.p, mn3.G) annotation (Line(points={{-2,-20},{2,-20},{2,-20.1},
              {6,-20.1}}, color={0,0,255}));
      connect(mn3.G, mp3.G) annotation (Line(points={{6,-20.1},{6,29.9}}, color={0,0,255}));
      connect(c3.p, mn4.G) annotation (Line(points={{36,-20},{41,-20},{41,
              -20.1},{46,-20.1}}, color={0,0,255}));
      connect(mn4.G, mp4.G) annotation (Line(points={{46,-20.1},{46,29.9}}, color={0,0,255}));
      connect(c1.p, mn2.G) annotation (Line(points={{-44,-20},{-39,-20},{-39,
              -20.1},{-34,-20.1}}, color={0,0,255}));
      connect(vin.p, mn1.G) annotation (Line(
          points={{-86,-32},{-86,0},{-74,0},{-74,-20.1}}, color={0,0,255}));
      connect(vin.n, ground.p) annotation (Line(
          points={{-86,-52},{-86,-60},{-64,-60}}));
      connect(v.p, mp4.D) annotation (Line(
          points={{92,-38},{92,40},{56,40}}, color={0,0,255}));
      connect(v.n, ground.p) annotation (Line(
          points={{92,-58},{92,-60},{-64,-60}}));
      connect(mp3.D, mp4.D) annotation (Line(
          points={{16,40},{56,40}}, color={0,0,255}));
      connect(mp2.D, mp3.D) annotation (Line(
          points={{-24,40},{16,40}}, color={0,0,255}));
      connect(mp1.D, mp2.D) annotation (Line(
          points={{-64,40},{-24,40}}, color={0,0,255}));
      annotation (experiment(StopTime=5),
        Documentation(info="<html>
<p>This circuit that contains four inverter was designed to show the functionality of the MOS transistor models. To see the behavior of the circuit the output voltages of each inverter should be displayed (mp1.S.v, mp2.S.v, mp3.S.v, mp4.S.v). The output voltages of the second an fourth inverter and the input voltage of the first inverter have the same potential. The output voltages of the first and third inverter have the opposite potential compared with inverter 2 and 4.</p>
<p>Simulate until t=5s. The output values should be: mp1.S.v, mp2.S.v, mp3.S.v and mp4.S.v</p>
</html>", revisions="<html>
<ul>
<li><em>April 2009</em> by Kristin Majetta initially implemented</li>
</ul>
</html>"));
    end FourInverters;

    model Nand "MOS Nand gate circuit"
      extends Modelica.Icons.Example;

      Semiconductors.M_PMOS mp1(
        L=2e-5,
        W=1e-5,
        modelcard(PHI=0.7, CBD=0, CBS=0), Sinternal(start=0), IC=-1e40) annotation (Placement(transformation(
              extent={{-22,24},{-2,44}})));
      Semiconductors.M_PMOS mp2(modelcard(PHI=0.7,CBD=0, CBS=0), IC=-1e40)
                                           annotation (Placement(transformation(
              extent={{24,24},{44,44}})));
      Semiconductors.M_NMOS mn2(Dinternal(start=0), modelcard(CBD=0, CBS=0), IC=-1e40) annotation (Placement(transformation(
              extent={{-24,-44},{-4,-24}})));
      Semiconductors.M_NMOS mn1(modelcard(CBD=0, CBS=0), IC=-1e40) annotation (Placement(transformation(
              extent={{-24,-10},{-4,10}})));
      Sources.V_constant vconstant(V=5) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}},
                                                     rotation=270,
            origin={62,34})));
      Basic.Ground ground annotation (Placement(transformation(extent={{20,-100},
                {40,-80}})));
      Sources.V_pulse vin1(
        TR=1e-9,
        TF=1e-9,
        V2=5,
        TD=2e-8,
        PW=4e-8,
        PER=8e-8) annotation (Placement(transformation(
            origin={-50,24},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Sources.V_pulse vin2(
        V2=5,
        TR=1e-9,
        TF=1e-9,
        TD=1e-8,
        PW=4e-8,
        PER=8e-8) annotation (Placement(transformation(
            origin={-52,-44},
            extent={{-10,-10},{10,10}},
            rotation=270)));

    equation
      connect(mp1.B, mp1.D) annotation (Line(points={{-2,34},{-2,44},{
              -12,44}}, color={0,0,255}));
      connect(mp2.B, mp2.D) annotation (Line(points={{44,34},{44,44},
              {34,44}}, color={0,0,255}));
      connect(vconstant.p, mp2.D) annotation (Line(points={{62,44},{62,44},
              {34,44}}, color={0,0,255}));
      connect(mp2.D, mp1.D)
        annotation (Line(points={{34,44},{-12,44}}, color={0,0,255}));
      connect(mp1.G, mn1.G) annotation (Line(points={{-22,33.9},{-22,
              16},{-24,16},{-24,-0.1}}, color={0,0,255}));
      connect(mp1.G, vin1.p) annotation (Line(points={{-22,33.9},{-38,33.9},
              {-38,34},{-50,34}}, color={0,0,255}));
      connect(vin1.n, ground.p) annotation (Line(points={{-50,14},{-62,14},{
              -62,-80},{30,-80}}, color={0,0,255}));
      connect(mp2.G, mn2.G) annotation (Line(points={{24,33.9},{24,14},
              {-32,14},{-32,-34.1},{-24,-34.1}}, color={0,0,255}));
      connect(mn2.G, vin2.p) annotation (Line(points={{-24,-34.1},{-38,
              -34.1},{-38,-34},{-52,-34}}, color={0,0,255}));
      connect(vin2.n, ground.p) annotation (Line(points={{-52,-54},{-52,-80},{
              30,-80}}, color={0,0,255}));
      connect(mn2.S, ground.p) annotation (Line(points={{-14,-44},{-14,-80},
              {30,-80}}, color={0,0,255}));
      connect(mn1.B, mn2.B)
        annotation (Line(points={{-4,0},{-4,-34}}, color={0,0,255}));
      connect(mn2.B, mn2.S) annotation (Line(points={{-4,-34},{-4,-44},
              {-14,-44}}, color={0,0,255}));
      connect(mn1.S, mn2.D)
        annotation (Line(points={{-14,-10},{-14,-24}}, color={0,0,255}));
      connect(mp1.S, mn1.D)
        annotation (Line(points={{-12,24},{-12,18},{-14,18},{-14,10}}, color={0,0,255}));
      connect(mp2.S, mn1.D) annotation (Line(points={{34,24},{34,10},
              {-14,10}}, color={0,0,255}));
      connect(vconstant.n, ground.p) annotation (Line(points={{62,24},{62,-80},
              {30,-80}}, color={0,0,255}));
      annotation (Documentation(info="<html>
<p>In nearly every electronic the basic circuit &quot;nand&quot; are used. A nand contains two PMOS and two NMOS. The faulty wiring can be seen in the graphical mode. If and only if the two input voltages have high potential, the output voltage has low potential, otherwise the output voltage has high potential.</p>
<p>Nand truth table (1 means true, it is represented by the 5V voltage):</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"1\"><tr>
<td><p>input voltage vin1</p></td>
<td><p>input voltage vin2</p></td>
<td><p>output voltage mn1.D</p></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
</tr>
</table>
<p>Simulate until t=2e-7s. Display the two input voltages vin1.p.v and vin2.p.v and the output voltage mn1.D.v, which becomes zero only if both input values are high.</p>
</html>", revisions="<html>
<ul>
<li><em>May 2009</em> by Kristin Majetta initially implemented</li>
</ul>
</html>"),
        experiment(StopTime=2e-007));
    end Nand;

    model Nor "MOS NOR gate circuit"
      extends Modelica.Icons.Example;

      Semiconductors.M_PMOS mp1(modelcard(
          RD=1e-4,
          RS=1e-4,
          CBD=1e-5,
          CBS=1e-5,
          CGSO=1e-5,
          CGDO=1e-5,
          CGBO=1e-5), Dinternal(start=0,fixed=true), Sinternal(start=0,fixed=true), IC=-1e40) annotation (Placement(transformation(
              extent={{-16,24},{4,44}})));
      Semiconductors.M_PMOS mp2(modelcard(
          RD=1e-4,
          RS=1e-4,
          CBD=1e-5,
          CBS=1e-5,
          CGSO=1e-5,
          CGDO=1e-5,
          CGBO=1e-5), Dinternal(start=0,fixed=true), Sinternal(start=0,fixed=true), IC=-1e40) annotation (Placement(transformation(
              extent={{-16,-6},{4,14}})));
      Semiconductors.M_NMOS mn1(modelcard(
          RD=1e-4,
          RS=1e-4,
          CBD=1e-5,
          CBS=1e-5,
          CGSO=1e-5,
          CGDO=1e-5,
          CGBO=1e-5), Dinternal(start=0,fixed=true), Sinternal(start=0,fixed=true), IC=-1e40) annotation (Placement(transformation(
              extent={{-16,-44},{4,-24}})));
      Semiconductors.M_NMOS mn2(modelcard(
          RD=1e-4,
          RS=1e-4,
          CBD=1e-5,
          CBS=1e-5,
          CGSO=1e-5,
          CGDO=1e-5,
          CGBO=1e-5), Dinternal(start=0,fixed=true), Sinternal(start=0,fixed=true), IC=-1e40) annotation (Placement(transformation(
              extent={{32,-44},{52,-24}})));
      Basic.Ground ground annotation (Placement(transformation(extent={{28,-100},
                {48,-80}})));
      Sources.V_pulse vin1(
        V2=5,
        TR=0.001,
        TF=0.001,
        PW=2,
        PER=10,
        TD=2) annotation (Placement(transformation(
            origin={-42,24},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Sources.V_pulse vin2(
        V2=5,
        TR=0.001,
        TF=0.001,
        PW=2,
        PER=10,
        TD=1) annotation (Placement(transformation(
            origin={-44,-44},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Sources.V_pulse v(
        TD=0.5,
        TR=0.1,
        V2=5) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={62,34})));
    equation
      connect(mn1.B, mn1.S) annotation (Line(points={{4,-34},{4,-44},{
              -6,-44}}, color={0,0,255}));
      connect(mn2.B, mn2.S) annotation (Line(points={{52,-34},{52,-44},
              {42,-44}}, color={0,0,255}));
      connect(mn2.S, ground.p) annotation (Line(points={{42,-44},{38,-44},
              {38,-80}}, color={0,0,255}));
      connect(mn1.S, ground.p) annotation (Line(points={{-6,-44},{-6,-80},{
              38,-80}}, color={0,0,255}));
      connect(vin2.p, mn1.G) annotation (Line(points={{-44,-34},{-29,
              -34},{-29,-34.1},{-16,-34.1}}, color={0,0,255}));
      connect(vin2.n, ground.p) annotation (Line(points={{-44,-54},{-44,-80},
              {38,-80}}, color={0,0,255}));
      connect(vin1.p, mp1.G) annotation (Line(points={{-42,34},{-29,34},
              {-29,33.9},{-16,33.9}}, color={0,0,255}));
      connect(vin1.n, ground.p) annotation (Line(points={{-42,14},{-64,14},{
              -64,-80},{38,-80}}, color={0,0,255}));
      connect(mp1.S, mp2.D)
        annotation (Line(points={{-6,24},{-6,14}}, color={0,0,255}));
      connect(mp2.S, mn1.D) annotation (Line(points={{-6,-6},{-6,-24}}, color={0,0,255}));
      connect(mn2.D, mn1.D) annotation (Line(points={{42,-24},{-6,-24}}, color={0,0,255}));
      connect(vin2.p, mp2.G) annotation (Line(points={{-44,-34},{-44,4},
              {-16,4},{-16,3.9}}, color={0,0,255}));
      connect(vin1.p, mn2.G) annotation (Line(points={{-42,34},{-28,34},
              {-28,-18},{32,-18},{32,-34.1}}, color={0,0,255}));
      connect(mp1.B, mp1.D) annotation (Line(
          points={{4,34},{4,44},{-6,44}}, color={0,0,255}));
      connect(mp2.B, mp1.B) annotation (Line(
          points={{4,4},{4,34}}, color={0,0,255}));
      connect(v.p, mp1.D) annotation (Line(
          points={{62,44},{-6,44}}, color={0,0,255}));
      connect(v.n, ground.p) annotation (Line(
          points={{62,24},{62,-80},{38,-80}}));
      annotation (Documentation(info="<html>
<p>In nearly every electronic the basic circuit &quot;nor&quot; is used. A nor contains two PMOS and two NMOS. The faulty wiring can be seen in the graphical mode. If and only if the two input voltages have low potential, the output voltage has high potential, otherwise the output voltage has low potential.</p>
<p>Nor truth table (1 means true, it is represented by the 5V voltage):</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"1\"><tr>
<td><p>input voltage vin1</p></td>
<td><p>input voltage vin2</p></td>
<td><p>output voltage mp1.S</p></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
</tr>
</table>
<p>Simulate until t=5s. Display the two input voltages vin1.p.v and vin2.p.v and the output voltage mp1.S.v.</p>
<p>The output value in the example shows a behaviour &quot;near&quot; the one of the truth table, since the capacitances are huge. Therefore loading is not finished before the next input changes.</p>
</html>", revisions="<html>
<ul>
<li><em>March 2009</em> by Kristin Majetta initially implemented</li>
</ul>
</html>"),
        experiment(StopTime=5));
    end Nor;

    model Graetz "Graetz rectifier circuit"
      extends Modelica.Icons.Example;

      Semiconductors.D_DIODE D1(IC=-1e40, SENS_AREA=false,modelcarddiode(CJO=1e-7),pin(start=0, fixed=true))
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={0,14})));
      Semiconductors.D_DIODE D3(IC=-1e40, SENS_AREA=false,modelcarddiode(CJO=1e-7), n(v(start=0, fixed=true)))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={20,-8})));
      Semiconductors.D_DIODE D4(IC=-1e40, SENS_AREA=false,modelcarddiode(CJO=1e-7))
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={1,-30})));
      Semiconductors.D_DIODE D2(IC=-1e40, SENS_AREA=false,modelcarddiode(CJO=1e-7))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-20,-8})));
      Semiconductors.R_Resistor rout(R=10)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={42,-7})));
      Sources.V_sin vsin(VA=10, FREQ=200)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-44,-8})));
      Basic.Ground ground
        annotation (Placement(transformation(extent={{-30,-60},{-10,-40}})));
    equation
      connect(D1.n, D3.p) annotation (Line(
          points={{10,14},{20,14},{20,2}}));
      connect(D2.p, D1.p) annotation (Line(
          points={{-20,2},{-20,14},{-10,14}}, color={0,0,255}));
      connect(D4.n, D3.n) annotation (Line(
          points={{11,-30},{20,-30},{20,-18}}));
      connect(D4.p, D2.n) annotation (Line(
          points={{-9,-30},{-20,-30},{-20,-18}}, color={0,0,255}));
      connect(D4.p, ground.p) annotation (Line(
          points={{-9,-30},{-20,-30},{-20,-40}}, color={0,0,255}));
      connect(vsin.n, ground.p) annotation (Line(
          points={{-44,-18},{-44,-40},{-20,-40}}));
      connect(D4.n, rout.p) annotation (Line(
          points={{11,-30},{42,-30},{42,-17}}));
      connect(rout.n, D1.p) annotation (Line(
          points={{42,3},{42,26},{-20,26},{-20,14},{-10,14}}, color={0,0,255}));
      connect(D3.p, vsin.p) annotation (Line(
          points={{20,2},{20,40},{-44,40},{-44,2}}, color={0,0,255}));
      annotation (
        experiment(StopTime=0.025),
        Documentation(info="<html>
<p>The Graetz rectifier circuit is to show the behaviour of diodes.</p>
<p>Simulator until 0.025 s. Then display the input voltage vsin.p.v. The rout.p.v voltage is the rectified voltage result, which is pulsing mostly in the positive range.</p>
</html>", revisions="<html>
<ul>
<li><em>Jan. 2010</em> by Kristin Majetta initially implemented</li>
</ul>
</html>"));
    end Graetz;

    model Oscillator "Oscillator circuit"
      extends Modelica.Icons.Example;

      Basic.R_Resistor r(R=1000) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-36,20})));
      Basic.C_Capacitor c(C=1e-7)
        annotation (Placement(transformation(extent={{-32,0},{-12,20}})));
      Basic.C_Capacitor c1(C=1e-7)
        annotation (Placement(transformation(extent={{24,0},{44,20}})));
      Basic.R_Resistor r1(R=22000) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-6,20})));
      Basic.R_Resistor r2(R=22000) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={18,20})));
      Basic.R_Resistor r3(R=1000) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,20})));
      Semiconductors.Q_NPNBJT T1(modelcard(CJE=1e-9, CJC=1e-9), vbe(start=0, fixed=true))
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-30,-24})));
      Semiconductors.Q_NPNBJT T2(modelcard(CJE=1e-9, CJC=1e-9), vbe(start=0, fixed=true))
        annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
      Basic.Ground ground1
        annotation (Placement(transformation(extent={{-78,-34},{-58,-14}})));
      Basic.Ground ground2
        annotation (Placement(transformation(extent={{50,-60},{70,-40}})));
      Basic.R_Resistor r4(R=10000) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={64,-2})));
      Sources.V_pulse v(
        V2=8,
        TD=0.0005,
        TR=0.01,
        PW=1000,
        PER=1000,
        TF=0) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-68,20})));

    equation
      connect(r.n,r1. n) annotation (Line(
          points={{-36,30},{-6,30}}));
      connect(r1.n,r2. n) annotation (Line(
          points={{-6,30},{18,30}}));
      connect(r2.n,r3. n) annotation (Line(
          points={{18,30},{50,30}}));
      connect(r.p,c. p) annotation (Line(
          points={{-36,10},{-32,10}}, color={0,0,255}));
      connect(c.n,r1. p) annotation (Line(
          points={{-12,10},{-6,10}}));
      connect(r2.p,c1. p) annotation (Line(
          points={{18,10},{24,10}}, color={0,0,255}));
      connect(c1.n,r3. p) annotation (Line(
          points={{44,10},{50,10}}));
      connect(r1.p, T2.B) annotation (Line(
          points={{-6,10},{-6,-30},{30.4,-30}}, color={0,0,255}));
      connect(r2.p, T1.B) annotation (Line(
          points={{18,10},{18,-24},{-20.4,-24}}, color={0,0,255}));
      connect(T1.C, r.p) annotation (Line(
          points={{-33,-34},{-48,-34},{-48,10},{-36,10}}, color={0,0,255}));
      connect(T1.E, ground1.p) annotation (Line(
          points={{-33,-14},{-68,-14}}));
      connect(T2.E, ground2.p) annotation (Line(
          points={{43,-40},{60,-40}}));
      connect(r3.p, T2.C) annotation (Line(
          points={{50,10},{50,-20},{43,-20}}, color={0,0,255}));
      connect(r3.p, r4.p) annotation (Line(
          points={{50,10},{58,10},{58,8},{64,8}}, color={0,0,255}));
      connect(ground2.p, r4.n) annotation (Line(
          points={{60,-40},{60,-12},{64,-12}}, color={0,0,255}));
      connect(v.p, r.n) annotation (Line(
          points={{-68,30},{-36,30}}, color={0,0,255}));
      connect(v.n, ground1.p) annotation (Line(
          points={{-68,10},{-68,-14}}));
      annotation (
        experiment(StopTime=0.025),
        Documentation(info="<html>
<p>The oscillator circuit demonstrates the usage of BJT transistors.</p>
<p>Simulate until 0.025 s. Display v.p.v, which is rising until 5 V. Furthermore display r4.p.v, which starts oscillating.</p>
</html>", revisions="<html>
<ul>
<li><em>Jan. 2010</em> by Jonathan Gerbet initially implemented</li>
</ul>
</html>"));
    end Oscillator;

    model CoupledInductors
      extends Modelica.Icons.Example;
      Modelica.Electrical.Spice3.Basic.Ground ground
        annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
      Modelica.Electrical.Spice3.Sources.V_sin sineVoltage(VA=220, FREQ=50)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-90,20})));
      Modelica.Electrical.Spice3.Basic.R_Resistor R1(R=1)
        annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
      Modelica.Electrical.Spice3.Basic.L_Inductor L1(L=1, UIC=false)
                           annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-40,40})));
      Modelica.Electrical.Spice3.Basic.L_Inductor L2(L=0.01)
                              annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={20,60})));
      Modelica.Electrical.Spice3.Basic.R_Resistor R2(R=1) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={42,80})));
      Modelica.Electrical.Spice3.Basic.K_CoupledInductors k1(k=0.1)
        annotation (Placement(transformation(extent={{-20,50},{0,70}})));
      Modelica.Electrical.Spice3.Basic.R_Resistor R3(R=1000) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={60,50})));
      Modelica.Electrical.Spice3.Basic.C_Capacitor C1(C=1e-6) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={80,50})));
      Modelica.Electrical.Spice3.Basic.L_Inductor L3(L=0.01)
                              annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={20,-40})));
      Modelica.Electrical.Spice3.Basic.R_Resistor R4(R=1) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={42,-20})));
      Modelica.Electrical.Spice3.Basic.R_Resistor R5(R=1000) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={60,-50})));
      Modelica.Electrical.Spice3.Basic.C_Capacitor C2(C=2.e-3) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={80,-50})));
      Modelica.Electrical.Spice3.Basic.K_CoupledInductors k2(k=0.05)
        annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
      Modelica.Electrical.Spice3.Basic.K_CoupledInductors k3(k=0.05)
                                  annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={6,10})));
    equation
      connect(sineVoltage.n, ground.p) annotation (Line(
          points={{-90,10},{-90,-80}}, color={0,0,255}));
      connect(R1.p, sineVoltage.p) annotation (Line(
          points={{-80,80},{-90,80},{-90,30}}, color={0,0,255}));
      connect(R1.n, L1.p) annotation (Line(
          points={{-60,80},{-40,80},{-40,50}}, color={0,0,255}));
      connect(L1.n, ground.p) annotation (Line(
          points={{-40,30},{-40,-80},{-90,-80}}, color={0,0,255}));
      connect(C1.n, R3.n) annotation (Line(
          points={{80,40},{60,40}}, color={0,0,255}));
      connect(L2.n, R3.n) annotation (Line(
          points={{20,50},{20,40},{60,40}}, color={0,0,255}));
      connect(C1.p, R2.p) annotation (Line(
          points={{80,60},{80,80},{52,80}}, color={0,0,255}));
      connect(R3.p, R2.p) annotation (Line(
          points={{60,60},{60,80},{52,80}}, color={0,0,255}));
      connect(R2.n, L2.p) annotation (Line(
          points={{32,80},{20,80},{20,70}}, color={0,0,255}));
      connect(C2.n, R5.n) annotation (Line(
          points={{80,-60},{60,-60}}, color={0,0,255}));
      connect(L3.n, R5.n) annotation (Line(
          points={{20,-50},{20,-60},{60,-60}}, color={0,0,255}));
      connect(C2.p, R4.p) annotation (Line(
          points={{80,-40},{80,-20},{52,-20}}, color={0,0,255}));
      connect(R5.p, R4.p) annotation (Line(
          points={{60,-40},{60,-20},{52,-20}}, color={0,0,255}));
      connect(R4.n, L3.p) annotation (Line(
          points={{32,-20},{20,-20},{20,-30}}, color={0,0,255}));
      connect(C1.n, ground.p) annotation (Line(
          points={{80,40},{90,40},{90,-80},{-90,-80}}, color={0,0,255}));
      connect(C2.n, ground.p) annotation (Line(
          points={{80,-60},{90,-60},{90,-80},{-90,-80}}, color={0,0,255}));
      connect(L1.ICP, k2.inductiveCouplePin1) annotation (Line(
          points={{-31.6,40},{-28,40},{-28,-40},{-20,-40}}, color={170,85,255}));
      connect(k2.inductiveCouplePin2, L3.ICP) annotation (Line(
          points={{0,-40},{11.6,-40}}, color={170,85,255}));
      connect(L3.ICP, k3.inductiveCouplePin1) annotation (Line(
          points={{11.6,-40},{6,-40},{6,0}}, color={170,85,255}));
      connect(k3.inductiveCouplePin2, L2.ICP) annotation (Line(
          points={{6,20},{6,60},{11.6,60}}, color={170,85,255}));
      connect(L2.ICP, k1.inductiveCouplePin2) annotation (Line(
          points={{11.6,60},{0,60}}, color={170,85,255}));
      connect(L1.ICP, k1.inductiveCouplePin1) annotation (Line(
          points={{-31.6,40},{-28,40},{-28,60},{-20,60}}, color={170,85,255}));
      annotation (
        experiment(StopTime=0.2),
        Documentation(info="<html>
<p>The coupled inductor circuit demonstrates how different inductors can be coupled using the Component K_CoupledInductors from package Basic</p>
<p>Simulate until 0.2s, and display the behaviour of the parts that are coupled via <code>K</code>, such as <code>C1.p.v</code>, and <code>C2.p.v</code>.</p>
</html>"));
    end CoupledInductors;

    model CascodeCircuit
    extends Modelica.Icons.Example;

      Modelica.Electrical.Spice3.Semiconductors.J_NJFJFET
                                  J1(S(
                                     v(  start=0)), modelcard(CGS=0, CGD=0), AREA=1)
        annotation (Placement(transformation(extent={{-54,38},{-34,58}})));
      Modelica.Electrical.Spice3.Semiconductors.J_NJFJFET
                                  J2(modelcard(CGS=0, CGD=0), AREA=1)
        annotation (Placement(transformation(extent={{-54,4},{-34,24}})));
      Modelica.Electrical.Spice3.Basic.R_Resistor RC(R=200, v(start=0))
        annotation (Placement(transformation(extent={{-44,60},{-24,80}})));
      Modelica.Electrical.Spice3.Basic.Ground ground
        annotation (Placement(transformation(extent={{-54,-26},{-34,-6}})));
      Modelica.Electrical.Spice3.Sources.V_constant UDD(V=10)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-10,60})));
      Modelica.Electrical.Spice3.Sources.V_constant U0(V=2)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-72,38})));
      Modelica.Electrical.Spice3.Sources.V_sin v_sin(FREQ=10, VA=2)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-66,4})));
    equation
      connect(J2.D, J1.S) annotation (Line(
          points={{-44,24},{-44,38}}, color={0,0,255}));
      connect(ground.p, J2.S) annotation (Line(
          points={{-44,-6},{-44,4}}, color={0,0,255}));
      connect(v_sin.p, J2.G) annotation (Line(
          points={{-66,14},{-60,14},{-60,13.9},{-54,13.9}}, color={0,0,255}));
      connect(v_sin.n, ground.p) annotation (Line(
          points={{-66,-6},{-44,-6}}, color={0,0,255}));
      connect(U0.p, J1.G) annotation (Line(
          points={{-72,48},{-63,48},{-63,47.9},{-54,47.9}}, color={0,0,255}));
      connect(U0.n, ground.p) annotation (Line(
          points={{-72,28},{-80,28},{-80,-6},{-44,-6}}, color={0,0,255}));
      connect(J1.D, RC.p) annotation (Line(
          points={{-44,58},{-44,70}}, color={0,0,255}));
      connect(UDD.p, RC.n) annotation (Line(
          points={{-10,70},{-24,70}}, color={0,0,255}));
      connect(UDD.n, ground.p) annotation (Line(
          points={{-10,50},{-10,-6},{-44,-6}}, color={0,0,255}));
      annotation (Documentation(info="<html>
<p>This model is a simple JFET cascode circuit. The J2 gate variation (v_sin.p.v) is transformed to the J2 drain variation (J2.D.v).</p>
<p><br/>Simulate until 0.2s, and display the mentioned voltages.</p>
</html>", revisions="<html>
<ul>
<li><em>Aug. 2011</em> by Kristin Majetta initially implemented</li>
</ul>
</html>"),experiment(
          StopTime=0.2,
          Interval=2e-4,
          Tolerance=1e-007));
    end CascodeCircuit;

    model Spice3BenchmarkDifferentialPair "Simple differential pair"
      extends Modelica.Icons.Example;
      Sources.V_pulse VCC( V1=0, V2=12, TD=0, TR=2e-009, TF=2e-009, PW=3);
      Sources.V_pulse VEE( V1=0, V2=-12, TD=0, TR=2e-009, TF=2e-009, PW=3);
      Sources.V_sin VIN( VO=0, VA=0.01, FREQ=5);
      Basic.R_Resistor RS1(R=1000, v(start=0));
      Basic.R_Resistor RS2(R=1000);
      Semiconductors.Q_NPNBJT Q1(modelcard=MOD1, Binternal(start=0), vbe(start=0, fixed=true));
      Semiconductors.Q_NPNBJT Q2(modelcard=MOD1, icapbe(start=0), vbc(start=0), vbe(start=0, fixed=true));
      Basic.R_Resistor RC1(R=10000, v(start=0));
      Basic.R_Resistor RC2(R=10000);
      Basic.R_Resistor RE(R=10000);
      Sources.V_constant VIE(V=0);
      parameter Semiconductors.ModelcardBJT MOD1(BF=50, VAF=50, IS=1e-012, RB=100, CJC=5e-09, TF=6e-010);
      Basic.Ground g;

      Real OutputVoltage;

    protected
      Modelica.Electrical.Analog.Interfaces.Pin n7;
      Modelica.Electrical.Analog.Interfaces.Pin n0;
      Modelica.Electrical.Analog.Interfaces.Pin n8;
      Modelica.Electrical.Analog.Interfaces.Pin n1;
      Modelica.Electrical.Analog.Interfaces.Pin n2;
      Modelica.Electrical.Analog.Interfaces.Pin n6;
      Modelica.Electrical.Analog.Interfaces.Pin n3;
      Modelica.Electrical.Analog.Interfaces.Pin n42;
      Modelica.Electrical.Analog.Interfaces.Pin n5;
      Modelica.Electrical.Analog.Interfaces.Pin n41;
    initial equation
      der(Q1.vbc)=0;
      der(Q2.vbc)=0;
    equation
      OutputVoltage=Q2.C.v - Q1.C.v;
      connect(g.p,n0);
      connect(VCC.p, n7);
      connect(VCC.n, n0);
      connect(VEE.p, n8);
      connect(VEE.n, n0);
      connect(VIN.p, n1);
      connect(VIN.n, n0);
      connect(RS1.p, n1);
      connect(RS1.n, n2);
      connect(RS2.p, n6);
      connect(RS2.n, n0);
      connect(Q1.C, n3);
      connect(Q1.B, n2);
      connect(Q1.E, n42);
      connect(Q2.C, n5);
      connect(Q2.B, n6);
      connect(Q2.E, n42);
      connect(RC1.p, n7);
      connect(RC1.n, n3);
      connect(RC2.p, n7);
      connect(RC2.n, n5);
      connect(RE.p, n41);
      connect(RE.n, n8);
      connect(VIE.p, n41);
      connect(VIE.n, n42);

      annotation (experiment(StopTime=1, Interval=0.001,
          Tolerance=1e-005),
          Documentation(info="<html>
<p>This Differential pair model is one of the five benchmark circuits described in the SPICE3 Version e3 User&#39;s Manual (see information of package Spice3).</p>
<p>The differential pair circuit is operating in the differential mode. This means the input voltage VIN that is only applied at one transistor
is amplified. To comprehend this behavior the user is recommended to simulate from t=0 to t=1s and observe \"VIN.p.v\" which is the input voltage and \"Outputvoltage\" which is the
amplified output voltage.</p>
<p>Original SPICE3 netlist of the Differential pair:</p>
<pre>
SIMPLE DIFFERENTIAL PAIR<br/>
VCC 7 0 12<br/>
VEE 8 0 -12<br/>
VIN 1 0 AC 1<br/>
RS1 1 2 1K<br/>
RS2 6 0 1K<br/>
Q1 3 2 4 MOD1<br/>
Q2 5 6 4 MOD1<br/>
RC1 7 3 10K<br/>
RC2 7 5 10K<br/>
RE 4 8 10K<br/>
.MODEL MOD1 NPN BF=50 VAF=50 IS=1.E-12 RB=100 CJC=.5PF TF=.6NS<br/>
.TF V(5) VIN<br/>
.AC DEC 10 1 100MEG<br/>
.END
</pre>
<p>In the Modelica representation the tiny capacity CJC was set to 1e-9F to get a higher numerical
robustness. In future the numerical behavior will be analysed to be able to apply the original value
CJC=.5PF.</p>
</html>"));
    end Spice3BenchmarkDifferentialPair;

    model Spice3BenchmarkMosfetCharacterization "Mos output characteristics"
      extends Modelica.Icons.Example;

      Sources.V_pulse VDS( V1=0, V2=10, TD=0, TR=1e-008, TF=1e-008, PW=1, PER=1);
      Sources.V_pulse VGS( V1=0, V2=5, TD=4e-008, TR=1e-009, TF=1e-009, PW=1e-008, PER=2e-008);
      Semiconductors.M_NMOS M1(modelcard=MOD1, L=4e-006, W=6e-006, AD=1e-011, AS=1e-011, IC=-1e40);
      // * VIDS MEASURES ID, WE COULD HAVE USED VDS, BUT ID WOULD BE NEGATIVE
      Sources.V_constant VIDS(V=0);
      parameter Semiconductors.ModelcardMOS MOD1(VTO=-2, NSUB=1e+015, UO=550, CBD=0, CBS=0);

    record SpiceConstants
      // NODE
      // NOPAGE
    end SpiceConstants;

      Basic.Ground g;

    protected
      Modelica.Electrical.Analog.Interfaces.Pin n3;
      Modelica.Electrical.Analog.Interfaces.Pin n0;
      Modelica.Electrical.Analog.Interfaces.Pin n2;
      Modelica.Electrical.Analog.Interfaces.Pin n1;

    equation
      connect(g.p,n0);
      connect(VDS.p, n3);
      connect(VDS.n, n0);
      connect(VGS.p, n2);
      connect(VGS.n, n0);
      connect(M1.D, n1);
      connect(M1.G, n2);
      connect(M1.S, n0);
      connect(M1.B, n0);
      connect(VIDS.p, n3);
      connect(VIDS.n, n1);

      annotation (experiment(StopTime=1e-007, Interval=1e-009),
        Documentation(info="<html>
<p>This Mosfet Characterization model is one of the five benchmark circuits described in the SPICE3 Version e3 User&#39;s Manual (see information of package Spice3).</p>
<p>This circuit is a very simple one than consists of an NMOS transistor level 1 that is connected to voltage sources at gate and drain node whereas the drain voltage source supplies the
operating voltage. The user is recommended to simulate from t=0 to t=1e-7s and observe the gate node voltage (\"VGS.p.v\") and the transistor current (\"M1.D.i\").
It can be seen that the current is increasing with increasing gate voltage which means the conductivity of the transistor is increasing. The opposite case occurs for decreasing gate voltage.</p>
<p>Original SPICE3 netlist of the MOSFET characterization circuit:</p>
<pre>
MOS OUTPUT CHARACTERISTICS<br/>
.OPTIONS NODE NOPAGE<br/>
VDS 3 0<br/>
VGS 2 0<br/>
M1 1 2 0 0 MOD1 L=4U W=6U AD=10P AS=10P<br/>
*VIDS MEASURES ID, WE COULD HAVE USED VDS, BUT IT WOULD BE NEGATIVE VIDS 3 1
.MODEL MOD1 NMOS VTO=-2 NSUB=1.0E15 UO=550<br/>
.DC VDS 0 10 .5 VGS 0 5 1<br/>
.END
</pre>
</html>"));
    end Spice3BenchmarkMosfetCharacterization;

    model Spice3BenchmarkRtlInverter "Simple RTL inverter"
      extends Modelica.Icons.Example;
      Sources.V_constant VCC(V=5);
      Sources.V_pulse VIN( V1=0, V2=5, TD=2e-009, TR=2e-009, TF=2e-009, PW=3e-008);
      Basic.R_Resistor RB(R=10000);
      Semiconductors.Q_NPNBJT Q1(modelcard=Q11, vbc(start=0, fixed=true), vbe(start=0, fixed=true));
      Basic.R_Resistor RC(R=1000);
      parameter Semiconductors.ModelcardBJT Q11(BF=20, RB=100, TF=1e-010, CJC=2e-012);
      Basic.Ground g;

    protected
      Modelica.Electrical.Analog.Interfaces.Pin n4;
      Modelica.Electrical.Analog.Interfaces.Pin n0;
      Modelica.Electrical.Analog.Interfaces.Pin n1;
      Modelica.Electrical.Analog.Interfaces.Pin n2;
      Modelica.Electrical.Analog.Interfaces.Pin n3;

    equation
      connect(g.p,n0);
      connect(VCC.p, n4);
      connect(VCC.n, n0);
      connect(VIN.p, n1);
      connect(VIN.n, n0);
      connect(RB.p, n1);
      connect(RB.n, n2);
      connect(Q1.C, n3);
      connect(Q1.B, n2);
      connect(Q1.E, n0);
      connect(RC.p, n3);
      connect(RC.n, n4);

      annotation (experiment(
          StopTime=1e-007,
          Interval=1e-010,
          Tolerance=1e-008),
        Documentation(info="<html>
<p>This RTL Inverter model is one of the five benchmark circuits described in the SPICE3 Version e3 User&#39;s Manual (see information of package Spice3).</p>
<p>This simple RTL inverter (resistor transistor logic) circuits inverts the input voltage which means the output voltage has high potential if the input voltage
has low potential and the other way round. To comprehend this behaviour the user is recommended to simulate from t=0 to t=1e-7s and observe the input voltage (VIN.p.v)
and the output voltage (Q1.C.v)</p>
<p>Original SPICE3 netlist of the RTL inverter:</p>
<pre>
SIMPLE RTL INVERTER<br/>
VCC 4 0 5<br/>
VIN 1 0 PULSE 0 5 2NS 2NS 2NS 30NS<br/>
RB 1 2 10K<br/>
Q1 3 2 0 Q1<br/>
RC 3 4 1K<br/>
.MODEL Q1 NPN BF 20 RB 100 TF .1NS CJC 2PF<br/>
.DC VIN 0 5 0.1<br/>
.TRAN 1NS 100NS<br/>
.END
</pre>
</html>"));
    end Spice3BenchmarkRtlInverter;

    model Spice3BenchmarkFourBitBinaryAdder
      "ADDER - 4 BIT ALL-NAND-GATE BINARY ADDER"
      extends Modelica.Icons.Example;

      output Real X1_p9_v =  X1.p9.v;
      output Real X1_p10_v = X1.p10.v;
      output Real X1_p11_v = X1.p11.v;
      output Real X1_p12_v = X1.p12.v;
      output Real X1_p14_v = X1.p14.v;
      output Real X1_p1_v =  X1.p1.v;
      output Real X1_p2_v =  X1.p2.v;
      output Real X1_p3_v =  X1.p3.v;
      output Real X1_p4_v =  X1.p4.v;
      output Real X1_p5_v =  X1.p5.v;
      output Real X1_p6_v =  X1.p6.v;
      output Real X1_p7_v =  X1.p7.v;
      output Real X1_p8_v =  X1.p8.v;

      // *** SUBCIRCUIT DEFINITIONS

    model NAND ".SUBCKT NAND 1 2 3 4"

      parameter Semiconductors.ModelcardDIODE DMOD;
      parameter Semiconductors.ModelcardBJT QMOD(BF=75, RB=100, CJE=1e-012, CJC=3e-012);

      // *   NODES:  INPUT(2), OUTPUT, VCC
      Modelica.Electrical.Spice3.Semiconductors.Q_NPNBJT Q1(modelcard=QMOD);
      Modelica.Electrical.Spice3.Semiconductors.D_DIODE D1CLAMP(modelcarddiode=DMOD, SENS_AREA=false, IC=-1e40);
      Modelica.Electrical.Spice3.Semiconductors.Q_NPNBJT Q2(modelcard=QMOD);
      Modelica.Electrical.Spice3.Semiconductors.D_DIODE D2CLAMP(modelcarddiode=DMOD, SENS_AREA=false, IC=-1e40);
      Modelica.Electrical.Spice3.Basic.R_Resistor RB(R=4000);
      Modelica.Electrical.Spice3.Basic.R_Resistor R1(R=1600);
      Modelica.Electrical.Spice3.Semiconductors.Q_NPNBJT Q3(modelcard=QMOD);
      Modelica.Electrical.Spice3.Basic.R_Resistor R2(R=1000);
      Modelica.Electrical.Spice3.Basic.R_Resistor RC(R=130);
      Modelica.Electrical.Spice3.Semiconductors.Q_NPNBJT Q4(modelcard=QMOD);
      Modelica.Electrical.Spice3.Semiconductors.D_DIODE DVBEDROP(modelcarddiode=DMOD, SENS_AREA=false, IC=-1e40);
      Modelica.Electrical.Spice3.Semiconductors.Q_NPNBJT Q5(modelcard=QMOD);
      Modelica.Electrical.Spice3.Basic.Ground g;
      Modelica.Electrical.Analog.Interfaces.Pin p1;
      Modelica.Electrical.Analog.Interfaces.Pin p2;
      Modelica.Electrical.Analog.Interfaces.Pin p3;
      Modelica.Electrical.Analog.Interfaces.Pin p4;

      protected
      Modelica.Electrical.Analog.Interfaces.Pin n1;
      Modelica.Electrical.Analog.Interfaces.Pin n2;
      Modelica.Electrical.Analog.Interfaces.Pin n3;
      Modelica.Electrical.Analog.Interfaces.Pin n4;
      Modelica.Electrical.Analog.Interfaces.Pin n9;
      Modelica.Electrical.Analog.Interfaces.Pin n5;
      Modelica.Electrical.Analog.Interfaces.Pin n0;
      Modelica.Electrical.Analog.Interfaces.Pin n6;
      Modelica.Electrical.Analog.Interfaces.Pin n8;
      Modelica.Electrical.Analog.Interfaces.Pin n7;
      Modelica.Electrical.Analog.Interfaces.Pin n10;

    equation
      connect(g.p,n0);
      connect(p1,n1);
      connect(p2,n2);
      connect(p3,n3);
      connect(p4,n4);
      connect(Q1.C, n9);
      connect(Q1.B, n5);
      connect(Q1.E, n1);
      connect(D1CLAMP.p, n0);
      connect(D1CLAMP.n, n1);
      connect(Q2.C, n9);
      connect(Q2.B, n5);
      connect(Q2.E, n2);
      connect(D2CLAMP.p, n0);
      connect(D2CLAMP.n, n2);
      connect(RB.p, n4);
      connect(RB.n, n5);
      connect(R1.p, n4);
      connect(R1.n, n6);
      connect(Q3.C, n6);
      connect(Q3.B, n9);
      connect(Q3.E, n8);
      connect(R2.p, n8);
      connect(R2.n, n0);
      connect(RC.p, n4);
      connect(RC.n, n7);
      connect(Q4.C, n7);
      connect(Q4.B, n6);
      connect(Q4.E, n10);
      connect(DVBEDROP.p, n10);
      connect(DVBEDROP.n, n3);
      connect(Q5.C, n3);
      connect(Q5.B, n8);
      connect(Q5.E, n0);

    end NAND;

    model ONEBIT ".SUBCKT ONEBIT 1 2 3 4 5 6"

      parameter Semiconductors.ModelcardDIODE DMOD;
      parameter Semiconductors.ModelcardBJT QMOD(BF=75, RB=100, CJE=1e-012, CJC=3e-012);

      // *   NODES:  INPUT(2), CARRY-IN, OUTPUT, CARRY-OUT, VCC
      NAND X1;
      NAND X2;
      NAND X3;
      NAND X4;
      NAND X5;
      NAND X6;
      NAND X7;
      NAND X8;
      NAND X9;
      Modelica.Electrical.Analog.Interfaces.Pin p1;
      Modelica.Electrical.Analog.Interfaces.Pin p2;
      Modelica.Electrical.Analog.Interfaces.Pin p3;
      Modelica.Electrical.Analog.Interfaces.Pin p4;
      Modelica.Electrical.Analog.Interfaces.Pin p5;
      Modelica.Electrical.Analog.Interfaces.Pin p6;

      protected
      Modelica.Electrical.Analog.Interfaces.Pin n1;
      Modelica.Electrical.Analog.Interfaces.Pin n2;
      Modelica.Electrical.Analog.Interfaces.Pin n3;
      Modelica.Electrical.Analog.Interfaces.Pin n4;
      Modelica.Electrical.Analog.Interfaces.Pin n5;
      Modelica.Electrical.Analog.Interfaces.Pin n6;
      Modelica.Electrical.Analog.Interfaces.Pin n7;
      Modelica.Electrical.Analog.Interfaces.Pin n8;
      Modelica.Electrical.Analog.Interfaces.Pin n9;
      Modelica.Electrical.Analog.Interfaces.Pin n10;
      Modelica.Electrical.Analog.Interfaces.Pin n11;
      Modelica.Electrical.Analog.Interfaces.Pin n12;
      Modelica.Electrical.Analog.Interfaces.Pin n13;

    equation
      connect(p1,n1);
      connect(p2,n2);
      connect(p3,n3);
      connect(p4,n4);
      connect(p5,n5);
      connect(p6,n6);
      connect(X1.p1, n1);
      connect(X1.p2, n2);
      connect(X1.p3, n7);
      connect(X1.p4, n6);
      connect(X2.p1, n1);
      connect(X2.p2, n7);
      connect(X2.p3, n8);
      connect(X2.p4, n6);
      connect(X3.p1, n2);
      connect(X3.p2, n7);
      connect(X3.p3, n9);
      connect(X3.p4, n6);
      connect(X4.p1, n8);
      connect(X4.p2, n9);
      connect(X4.p3, n10);
      connect(X4.p4, n6);
      connect(X5.p1, n3);
      connect(X5.p2, n10);
      connect(X5.p3, n11);
      connect(X5.p4, n6);
      connect(X6.p1, n3);
      connect(X6.p2, n11);
      connect(X6.p3, n12);
      connect(X6.p4, n6);
      connect(X7.p1, n10);
      connect(X7.p2, n11);
      connect(X7.p3, n13);
      connect(X7.p4, n6);
      connect(X8.p1, n12);
      connect(X8.p2, n13);
      connect(X8.p3, n4);
      connect(X8.p4, n6);
      connect(X9.p1, n11);
      connect(X9.p2, n7);
      connect(X9.p3, n5);
      connect(X9.p4, n6);

    end ONEBIT;

    model TWOBIT ".SUBCKT TWOBIT 1 2 3 4 5 6 7 8 9"

      parameter Semiconductors.ModelcardDIODE DMOD;
      parameter Semiconductors.ModelcardBJT QMOD(BF=75, RB=100, CJE=1e-012, CJC=3e-012);

      // *   NODES:  INPUT - BIT0(2) / BIT1(2), OUTPUT - BIT0 / BIT1,
      // *           CARRY-IN, CARRY-OUT, VCC
      ONEBIT X1;
      ONEBIT X2;
      Modelica.Electrical.Analog.Interfaces.Pin p1;
      Modelica.Electrical.Analog.Interfaces.Pin p2;
      Modelica.Electrical.Analog.Interfaces.Pin p3;
      Modelica.Electrical.Analog.Interfaces.Pin p4;
      Modelica.Electrical.Analog.Interfaces.Pin p5;
      Modelica.Electrical.Analog.Interfaces.Pin p6;
      Modelica.Electrical.Analog.Interfaces.Pin p7;
      Modelica.Electrical.Analog.Interfaces.Pin p8;
      Modelica.Electrical.Analog.Interfaces.Pin p9;

      protected
      Modelica.Electrical.Analog.Interfaces.Pin n1;
      Modelica.Electrical.Analog.Interfaces.Pin n2;
      Modelica.Electrical.Analog.Interfaces.Pin n3;
      Modelica.Electrical.Analog.Interfaces.Pin n4;
      Modelica.Electrical.Analog.Interfaces.Pin n5;
      Modelica.Electrical.Analog.Interfaces.Pin n6;
      Modelica.Electrical.Analog.Interfaces.Pin n7;
      Modelica.Electrical.Analog.Interfaces.Pin n8;
      Modelica.Electrical.Analog.Interfaces.Pin n9;
      Modelica.Electrical.Analog.Interfaces.Pin n10;

    equation
      connect(p1,n1);
      connect(p2,n2);
      connect(p3,n3);
      connect(p4,n4);
      connect(p5,n5);
      connect(p6,n6);
      connect(p7,n7);
      connect(p8,n8);
      connect(p9,n9);
      connect(X1.p1, n1);
      connect(X1.p2, n2);
      connect(X1.p3, n7);
      connect(X1.p4, n5);
      connect(X1.p5, n10);
      connect(X1.p6, n9);
      connect(X2.p1, n3);
      connect(X2.p2, n4);
      connect(X2.p3, n10);
      connect(X2.p4, n6);
      connect(X2.p5, n8);
      connect(X2.p6, n9);

    end TWOBIT;

    model FOURBIT ".SUBCKT FOURBIT 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15"

      parameter Semiconductors.ModelcardDIODE DMOD;
      parameter Semiconductors.ModelcardBJT QMOD(BF=75, RB=100, CJE=1e-012, CJC=3e-012);

      // *   NODES:  INPUT - BIT0(2) / BIT1(2) / BIT2(2) / BIT3(2),
      // *           OUTPUT - BIT0 / BIT1 / BIT2 / BIT3, CARRY-IN, CARRY-OUT, VCC
      TWOBIT X1;
      TWOBIT X2;
      Modelica.Electrical.Analog.Interfaces.Pin p1;
      Modelica.Electrical.Analog.Interfaces.Pin p2;
      Modelica.Electrical.Analog.Interfaces.Pin p3;
      Modelica.Electrical.Analog.Interfaces.Pin p4;
      Modelica.Electrical.Analog.Interfaces.Pin p5;
      Modelica.Electrical.Analog.Interfaces.Pin p6;
      Modelica.Electrical.Analog.Interfaces.Pin p7;
      Modelica.Electrical.Analog.Interfaces.Pin p8;
      Modelica.Electrical.Analog.Interfaces.Pin p9;
      Modelica.Electrical.Analog.Interfaces.Pin p10;
      Modelica.Electrical.Analog.Interfaces.Pin p11;
      Modelica.Electrical.Analog.Interfaces.Pin p12;
      Modelica.Electrical.Analog.Interfaces.Pin p13;
      Modelica.Electrical.Analog.Interfaces.Pin p14;
      Modelica.Electrical.Analog.Interfaces.Pin p15;

      protected
      Modelica.Electrical.Analog.Interfaces.Pin n1;
      Modelica.Electrical.Analog.Interfaces.Pin n2;
      Modelica.Electrical.Analog.Interfaces.Pin n3;
      Modelica.Electrical.Analog.Interfaces.Pin n4;
      Modelica.Electrical.Analog.Interfaces.Pin n5;
      Modelica.Electrical.Analog.Interfaces.Pin n6;
      Modelica.Electrical.Analog.Interfaces.Pin n7;
      Modelica.Electrical.Analog.Interfaces.Pin n8;
      Modelica.Electrical.Analog.Interfaces.Pin n9;
      Modelica.Electrical.Analog.Interfaces.Pin n10;
      Modelica.Electrical.Analog.Interfaces.Pin n11;
      Modelica.Electrical.Analog.Interfaces.Pin n12;
      Modelica.Electrical.Analog.Interfaces.Pin n13;
      Modelica.Electrical.Analog.Interfaces.Pin n14;
      Modelica.Electrical.Analog.Interfaces.Pin n15;
      Modelica.Electrical.Analog.Interfaces.Pin n16;

    equation
      connect(p1,n1);
      connect(p2,n2);
      connect(p3,n3);
      connect(p4,n4);
      connect(p5,n5);
      connect(p6,n6);
      connect(p7,n7);
      connect(p8,n8);
      connect(p9,n9);
      connect(p10,n10);
      connect(p11,n11);
      connect(p12,n12);
      connect(p13,n13);
      connect(p14,n14);
      connect(p15,n15);
      connect(X1.p1, n1);
      connect(X1.p2, n2);
      connect(X1.p3, n3);
      connect(X1.p4, n4);
      connect(X1.p5, n9);
      connect(X1.p6, n10);
      connect(X1.p7, n13);
      connect(X1.p8, n16);
      connect(X1.p9, n15);
      connect(X2.p1, n5);
      connect(X2.p2, n6);
      connect(X2.p3, n7);
      connect(X2.p4, n8);
      connect(X2.p5, n11);
      connect(X2.p6, n12);
      connect(X2.p7, n16);
      connect(X2.p8, n14);
      connect(X2.p9, n15);

    end FOURBIT;

      // *** DEFINE NOMINAL CIRCUIT
      parameter Modelica.Electrical.Spice3.Semiconductors.ModelcardDIODE DMOD;
      parameter Modelica.Electrical.Spice3.Semiconductors.ModelcardBJT QMOD(BF=75, RB=100, CJE=1e-012, CJC=3e-012);
      Modelica.Electrical.Spice3.Sources.V_constant VCC(V=5);
      Modelica.Electrical.Spice3.Sources.V_pulse VIN1A( V1=0, V2=3, TD=0, TR=1e-008, TF=1e-008, PW=1e-008, PER=5e-008);
      Modelica.Electrical.Spice3.Sources.V_pulse VIN1B( V1=0, V2=3, TD=0, TR=1e-008, TF=1e-008, PW=2e-008, PER=1e-007);
      Modelica.Electrical.Spice3.Sources.V_pulse VIN2A( V1=0, V2=3, TD=0, TR=1e-008, TF=1e-008, PW=4e-008, PER=2e-007);
      Modelica.Electrical.Spice3.Sources.V_pulse VIN2B( V1=0, V2=3, TD=0, TR=1e-008, TF=1e-008, PW=8e-008, PER=4e-007);
      Modelica.Electrical.Spice3.Sources.V_pulse VIN3A( V1=0, V2=3, TD=0, TR=1e-008, TF=1e-008, PW=1.6e-007, PER=8e-007);
      Modelica.Electrical.Spice3.Sources.V_pulse VIN3B( V1=0, V2=3, TD=0, TR=1e-008, TF=1e-008, PW=3.2e-007, PER=1.6e-006);
      Modelica.Electrical.Spice3.Sources.V_pulse VIN4A( V1=0, V2=3, TD=0, TR=1e-008, TF=1e-008, PW=6.4e-007, PER=3.2e-006);
      Modelica.Electrical.Spice3.Sources.V_pulse VIN4B( V1=0, V2=3, TD=0, TR=1e-008, TF=1e-008, PW=1.28e-006, PER=6.4e-006);
      FOURBIT X1( X1(   X1( X1( Q1(vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbc(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true),vbe(start=0))),
                            X2( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true))),
                            X3( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbe(start=0, fixed=true))),
                            X4( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbe(start=0, fixed=true))),
                            X5( Q1(vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbc(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbe(start=0, fixed=true))),
                            X6( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true), vbe(start=0))),
                            X7( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbe(start=0, fixed=true), vbc(start=0, fixed=true)),
                                RC(v(start=0))),
                            X8( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbe(start=0),vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true))),
                            X9( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                RC(v(start=0)))),
                         X2(X1( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=false)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbc(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true))),
                            X2( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                RC(v(start=0))),
                            X3( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbe(start=0, fixed=true)),
                                RC(v(start=0))),
                            X4( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true))),
                            X5( Q1(vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbe(start=0, fixed=true))),
                            X6( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbe(start=0, fixed=true))),
                            X7( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                RC(v(start=0))),
                            X8( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true),vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true))),
                            X9( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                RC(v(start=0))))),
                  X2(   X1( X1( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbc(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true))),
                            X2( Q1(vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                RC(v(start=0))),
                            X3( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbe(start=0, fixed=true)),
                                RC(v(start=0))),
                            X4( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true))),
                            X5( Q1(vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbe(start=0, fixed=true))),
                            X6( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbe(start=0, fixed=true))),
                            X7( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                RC(v(start=0))),
                            X8( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true))),
                            X9( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                RC(v(start=0)))),
                        X2( X1( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(icapbc(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true)),
                                RC(v(start=0))),
                            X2( Q1(vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                RC(v(start=0))),
                            X3( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbe(start=0, fixed=true)),
                                RC(v(start=0))),
                            X4( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true))),
                            X5( Q1(vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbe(start=0, fixed=true))),
                            X6( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbe(start=0, fixed=true))),
                            X7( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                RC(v(start=0))),
                            X8( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true))),
                            X9( Q1(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q2(vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q3(Binternal(start=0), icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q4(Binternal(start=0),icapbe(start=0), vbc(start=0, fixed=true), vbe(start=0, fixed=true)),
                                Q5(vbc(start=0, fixed=true), vbe(start=0, fixed=true))))));

      Modelica.Electrical.Spice3.Basic.R_Resistor RBIT0(R=1000);
      Modelica.Electrical.Spice3.Basic.R_Resistor RBIT1(R=1000);
      Modelica.Electrical.Spice3.Basic.R_Resistor RBIT2(R=1000);
      Modelica.Electrical.Spice3.Basic.R_Resistor RBIT3(R=1000);
      Modelica.Electrical.Spice3.Basic.R_Resistor RCOUT(R=1000);
      Modelica.Electrical.Spice3.Basic.Ground g;

    protected
      Modelica.Electrical.Analog.Interfaces.Pin n99;
      Modelica.Electrical.Analog.Interfaces.Pin n0;
      Modelica.Electrical.Analog.Interfaces.Pin n1;
      Modelica.Electrical.Analog.Interfaces.Pin n2;
      Modelica.Electrical.Analog.Interfaces.Pin n3;
      Modelica.Electrical.Analog.Interfaces.Pin n4;
      Modelica.Electrical.Analog.Interfaces.Pin n5;
      Modelica.Electrical.Analog.Interfaces.Pin n6;
      Modelica.Electrical.Analog.Interfaces.Pin n7;
      Modelica.Electrical.Analog.Interfaces.Pin n8;
      Modelica.Electrical.Analog.Interfaces.Pin n9;
      Modelica.Electrical.Analog.Interfaces.Pin n10;
      Modelica.Electrical.Analog.Interfaces.Pin n11;
      Modelica.Electrical.Analog.Interfaces.Pin n12;
      Modelica.Electrical.Analog.Interfaces.Pin n13;

    equation
      connect(g.p,n0);
      connect(VCC.p, n99);
      connect(VCC.n, n0);
      connect(VIN1A.p, n1);
      connect(VIN1A.n, n0);
      connect(VIN1B.p, n2);
      connect(VIN1B.n, n0);
      connect(VIN2A.p, n3);
      connect(VIN2A.n, n0);
      connect(VIN2B.p, n4);
      connect(VIN2B.n, n0);
      connect(VIN3A.p, n5);
      connect(VIN3A.n, n0);
      connect(VIN3B.p, n6);
      connect(VIN3B.n, n0);
      connect(VIN4A.p, n7);
      connect(VIN4A.n, n0);
      connect(VIN4B.p, n8);
      connect(VIN4B.n, n0);
      connect(X1.p1, n1);
      connect(X1.p2, n2);
      connect(X1.p3, n3);
      connect(X1.p4, n4);
      connect(X1.p5, n5);
      connect(X1.p6, n6);
      connect(X1.p7, n7);
      connect(X1.p8, n8);
      connect(X1.p9, n9);
      connect(X1.p10, n10);
      connect(X1.p11, n11);
      connect(X1.p12, n12);
      connect(X1.p13, n0);
      connect(X1.p14, n13);
      connect(X1.p15, n99);
      connect(RBIT0.p, n9);
      connect(RBIT0.n, n0);
      connect(RBIT1.p, n10);
      connect(RBIT1.n, n0);
      connect(RBIT2.p, n11);
      connect(RBIT2.n, n0);
      connect(RBIT3.p, n12);
      connect(RBIT3.n, n0);
      connect(RCOUT.p, n13);
      connect(RCOUT.n, n0);

      annotation (experiment(StopTime=1e-006, Interval=1e-009),
        Documentation(info="<html>
<p>This Four Bit Binary Adder model is one of the five benchmark circuits described in the SPICE3 Version e3 User&#39;s Manual (see information of package Spice3).</p>
<p>The model adds two 4-bit numbers (Number A and Number B). It has eight inputs where the first one is the lowest-order bit of the first number (Number A Bit0), the second is the lowest-order bit of the second number (Number B Bit0), the third one is the second-order bit of the first number (Number A Bit1) and so on. The Four Bit Binary Adder has four outputs where the first one (Sum Bit0) is the lowest-order bit, the second and the third one (Sum Bit1 and Sum Bit2) are the next two bits and the last one (Sum Bit3) is the highest-order bit. The picture illustrates the pin-assignment.</p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Spice3/FourBitBinaryAdder.jpg\"
     alt=\"segment.png\">
</blockquote>

<p>Inside the model the names of the inputs refer to the names in the picture as follows:</p>
<p>X1_p1_v --> Number A Bit0</p>
<p>X1_p2_v --> Number B Bit0</p>
<p>X1_p3_v --> Number A Bit1</p>
<p>X1_p4_v --> Number B Bit1</p>
<p>X1_p5_v --> Number A Bit2</p>
<p>X1_p6_v --> Number B Bit2</p>
<p>X1_p7_v --> Number A Bit3</p>
<p>X1_p8_v --> Number B Bit3</p>
<p>X1_p9_v --> Sum Bit0</p>
<p>X1_p10_v --> Sum Bit1</p>
<p>X1_p11_v --> Sum Bit2</p>
<p>X1_p12_v --> Sum Bit3</p>
<p>X1_p14_v --> Cout</p>
<p>The Four Bit Binary Adder is built out of two two bit adders which respectively are built out of two one bit adders. One one bit adder is build out of nine NAND circuits.</p>
<p>Please note, that the simulation time of the Four Bit Binary Adder can take several hours due to its immense size (e.g. 11387 equations).</p>
<p>The user is recommended to simulate from t=0 to t=1e-6s and observe the eight inputs (X1_p1_v, ..., X1_p8_v) and the four outputs (X1_p9_v, ..., X1_p12_v) and the carryout output (X1_p14_v).</p>
<p><strong>The timing of the single transistors of the adder causes a delay which makes it hard to recognize the adder behaviour. Since the Four Bit Binary Adder is a SPICE3 benchmark, the circuit is not changed in order to see the adder behaviour in a better way.</strong></p>
<p>Original SPICE3 netlist of the Four Bit Binary Adder:</p>
<pre>
ADDER - 4 BIT ALL-NAND-GATE BINARY ADDER

*** SUBCIRCUIT DEFINITIONS
.SUBCKT NAND 1 2 3 4
*   NODES:  INPUT(2), OUTPUT, VCC
Q1        9  5  1 QMOD
D1CLAMP   0  1    DMOD
Q2        9  5  2 QMOD
D2CLAMP   0  2    DMOD
RB        4  5    4K
R1        4  6    1.6K
Q3        6  9  8 QMOD
R2        8  0    1K
RC        4  7    130
Q4        7  6 10 QMOD
DVBEDROP 10  3    DMOD
Q5        3  8  0 QMOD
.ENDS NAND

.SUBCKT ONEBIT 1 2 3 4 5 6
*   NODES:  INPUT(2), CARRY-IN, OUTPUT, CARRY-OUT, VCC
X1   1  2  7  6   NAND
X2   1  7  8  6   NAND
X3   2  7  9  6   NAND
X4   8  9 10  6   NAND
X5   3 10 11  6   NAND
X6   3 11 12  6   NAND
X7  10 11 13  6   NAND
X8  12 13  4  6   NAND
X9  11  7  5  6   NAND
.ENDS ONEBIT

.SUBCKT TWOBIT 1 2 3 4 5 6 7 8 9
*   NODES:  INPUT - BIT0(2) / BIT1(2), OUTPUT - BIT0 / BIT1,
*           CARRY-IN, CARRY-OUT, VCC
X1   1  2  7  5 10  9   ONEBIT
X2   3  4 10  6  8  9   ONEBIT
.ENDS TWOBIT

.SUBCKT FOURBIT 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
*   NODES:  INPUT - BIT0(2) / BIT1(2) / BIT2(2) / BIT3(2),
*           OUTPUT - BIT0 / BIT1 / BIT2 / BIT3, CARRY-IN, CARRY-OUT, VCC
X1   1  2  3  4  9 10 13 16 15   TWOBIT
X2   5  6  7  8 11 12 16 14 15   TWOBIT
.ENDS FOURBIT

*** DEFINE NOMINAL CIRCUIT
.MODEL DMOD D
.MODEL QMOD NPN(BF=75 RB=100 CJE=1PF CJC=3PF)
VCC   99  0   DC 5V
VIN1A  1  0   PULSE(0 3 0 10NS 10NS   10NS   50NS)
VIN1B  2  0   PULSE(0 3 0 10NS 10NS   20NS  100NS)
VIN2A  3  0   PULSE(0 3 0 10NS 10NS   40NS  200NS)
VIN2B  4  0   PULSE(0 3 0 10NS 10NS   80NS  400NS)
VIN3A  5  0   PULSE(0 3 0 10NS 10NS  160NS  800NS)
VIN3B  6  0   PULSE(0 3 0 10NS 10NS  320NS 1600NS)
VIN4A  7  0   PULSE(0 3 0 10NS 10NS  640NS 3200NS)
VIN4B  8  0   PULSE(0 3 0 10NS 10NS 1280NS 6400NS)
X1     1  2  3  4  5  6  7  8  9 10 11 12  0 13 99 FOURBIT
RBIT0  9  0   1K
RBIT1 10  0   1K
RBIT2 11  0   1K
RBIT3 12  0   1K
RCOUT 13  0   1K

*** (FOR THOSE WITH MONEY (AND MEMORY) TO BURN)
.TRAN 1NS 6400NS UIC

.control
run
set options no break

*plot v(1) v(2)
*plot v(3) v(4)
*plot v(5) v(6)
*plot v(7) v(8)
*plot v(9) v(10)
*plot v(11) v(12)
*plot v(13)
*print v(9) v(10)
print v(11) v(12) v(13)

.endc

.END
</pre>
<p>The model is built out of several subcircuits which were described only ones and used several times.</p>
</html>"));
    end Spice3BenchmarkFourBitBinaryAdder;
    annotation (Documentation(info="<html>
<p>This package Example circuits contains some useful examples to demonstrate how the library is working and how the models can be used.</p>
</html>"));
  end Examples;

  package Basic "Basic electrical components"

    extends Modelica.Icons.Package;

    model Ground "Ground node"

      Modelica.Electrical.Analog.Interfaces.Pin p "Ground pin" annotation (Placement(transformation(
            origin={0,100},
            extent={{10,-10},{-10,10}},
            rotation=270)));
    equation
      p.v = 0;
      annotation (
        Documentation(info="<html>
<p>
Ground of an electrical circuit. The potential at the
ground node is zero. Every electrical circuit has to contain
at least one ground object.
</p>
<p>
SPICE does not have an element for the ground node (mass). In SPICE
netlists the ground is specified by the node number 0.
This Modelica SPICE library demands to describe the ground node
by this ground element.
</p>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Line(
              points={{0,100},{0,40}},
              color={0,0,255}),
            Line(
              points={{-60,40},{60,40}},
              color={0,0,255}),
            Line(
              points={{-40,20},{40,20}},
              color={0,0,255}),
            Line(
              points={{-20,0},{20,0}},
              color={0,0,255}),
            Text(
              extent={{-50,-14},{58,-54}},
              lineColor={0,0,255},
              textString="%name")}));
    end Ground;

    model R_Resistor "Ideal linear electrical resistor"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Resistance R(start=1000) "Resistance";
    equation
      R*i = v;
      annotation (
        Documentation(info="<html>
<p>
The linear resistor connects the branch voltage <em>v</em> with the
branch current <em>i</em> by <em>i*R = v</em>.
The Resistance <em>R</em> is allowed to be positive, zero, or negative.
</p>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-70,0}}, color={0,0,255}),
            Line(points={{70,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-136,-46},{140,-62}},
              textString="R=%R"),
            Text(extent={{-136,34},{138,54}}, textString="%name")}));
    end R_Resistor;

    model C_Capacitor "Ideal linear electrical capacitor"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Capacitance C(start=0) "Capacitance";
      parameter SI.Voltage IC=0 "Initial value";
      parameter Boolean UIC=false
        "Use initial conditions: true, if initial condition is used";
    protected
      SI.Voltage vinternal;//(start=IC, fixed=UIC);
    initial equation
      vinternal=IC;
    equation
        vinternal = p.v - n.v;
        i = C*der(vinternal);
      annotation (
        Documentation(info="<html>
<p>
The linear capacitor connects the branch voltage <em>v</em> with the
branch current <em>i</em> by <em>i = C * dv/dt</em>.
The Capacitance <em>C</em> is allowed to be positive, zero, or negative.
</p>
</html>"), Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={
            Line(
              points={{-6,28},{-6,-28}},
              color={0,0,255}),
            Line(
              points={{6,28},{6,-28}},
              color={0,0,255}),
            Line(points={{-90,0},{-6,0}}),
            Line(points={{6,0},{90,0}}),
            Text(
              extent={{-130,-40},{134,-60}},
              textString="C=%C"),
            Text(extent={{-138,42},{136,62}}, textString="%name")}));
    end C_Capacitor;

    model L_Inductor "Ideal linear electrical inductor"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Inductance L(start=0) "Inductance";
      parameter SI.Current IC=0 "Initial value; used, if UIC is true";
      parameter Boolean UIC=false "Use initial conditions";
      SI.Current iinternal;

      Modelica.Electrical.Spice3.Interfaces.InductiveCouplePinOut
                                                               ICP
        "Pin to couple inductances via K"
        annotation (Placement(transformation(extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={0,80}),
            iconTransformation(extent={{-16,-16},{16,16}},
            rotation=270,
            origin={0,84})));

    initial equation
      if UIC then
        iinternal = IC;
      else
        der(iinternal) = 0;
      end if;

    equation
      iinternal = p.i;
      L*der(iinternal) = v + ICP.v;
      ICP.L=L;
      ICP.di = der(iinternal);
      annotation (
        Documentation(info="<html>
<p>The linear inductor connects the branch voltage <em>v</em> with the branch current <em>i</em> by <em>v = L * di/dt</em>. The inductance <em>L</em> is allowed to be positive, zero, or negative.</p>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={
            Ellipse(extent={{-60,-15},{-30,15}}),
            Ellipse(extent={{-30,-15},{0,15}}),
            Ellipse(extent={{0,-15},{30,15}}),
            Ellipse(extent={{30,-15},{60,15}}),
            Rectangle(
              extent={{-60,-30},{60,0}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{60,0},{90,0}}),
            Line(points={{-90,0},{-60,0}}),
            Text(
              extent={{-142,-40},{142,-60}},
              textString="L=%L"),
            Text(extent={{-136,36},{138,56}}, textString="%name")}));
    end L_Inductor;

    model K_CoupledInductors "Inductive coupling via coupling factor K"
      parameter Real k( start=0) "Coupling Factor";
      Modelica.Electrical.Spice3.Interfaces.InductiveCouplePinIn
                                                               inductiveCouplePin1
        "Couple pin for inductances"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Electrical.Spice3.Interfaces.InductiveCouplePinIn
                                                               inductiveCouplePin2
        "Couple pin for inductances"
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=180,
            origin={100,0}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={100,0})));
    SI.Inductance M "mutual inductance";
    equation
      assert(k>=0,"Coupling factor must be not negative");
      assert(k<1,"coupling factor must be less than one");
      M = k*sqrt(inductiveCouplePin1.L*inductiveCouplePin2.L);
      inductiveCouplePin1.v = - M*inductiveCouplePin2.di;
      inductiveCouplePin2.v = - M*inductiveCouplePin1.di;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}),
                       graphics={
            Polygon(
              points={{-60,0},{0,20},{60,0},{0,-20},{-60,0}},
              lineColor={170,85,255}),
            Line(
              points={{-60,0},{-96,0},{-98,0}},
              color={170,85,255}),
            Line(
              points={{60,0},{100,0}},
              color={170,85,255}),
            Text(
              extent={{-74,76},{74,30}},
              lineColor={170,85,255},
              textString="%name"),
            Text(
              extent={{-72,-24},{76,-70}},
              lineColor={170,85,255},
              textString="k=%k")}),
        Documentation(info="<html>
<p>
<code>K_CoupledInductors</code> is a component that allows the coupling of two inductors.
<code>K</code> is the coefficient of coupling which must be greater than or equal to zero and less than one.
</p>
<p>
The usage is demonstrated in the example <a href=\"modelica://Modelica.Electrical.Spice3.Examples.CoupledInductors\">CoupledInductors</a>.
</p>
</html>"));
    end K_CoupledInductors;

    model E_VCV "Linear voltage-controlled voltage source"
      extends Interfaces.TwoPortControlledSources;
      parameter Real gain(start=0) "Voltage gain";
    equation
      v2 = v1*gain;
      i1 = 0;
      annotation (
        Documentation(info="<html>
<p>
The linear voltage-controlled voltage source is a TwoPort.
The right port voltage at pin p2 (=p2.v) is controlled by the left port voltage at pin p1 (=p1.v)
via
</p>
<pre>
    p2.v = p1.v * gain.
</pre>
<p>
The left port current is zero. Any voltage gain can be chosen.
</p>
The corresponding SPICE description
<pre>
    Ename N+ N- NC+ NC- VALUE
</pre>
<p>is translated to Modelica:</p>
<pre>
    Ename -> Spice3.Basic.E_VCV Ename
    (Ename is the name of the Modelica instance)
    N+ -> p2.v
    N- -> n2.v
    NC+ -> p1.v
    NC- -> n1.v
    VALUE -> gain
</pre>
</html>"), Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-70,70},{70,-70}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{-99,-79},{100,-129}}, textString="%name"),
            Line(points={{-90,50},{-30,50}}),
            Line(points={{-30,-50},{-90,-50}}),
            Line(points={{100,50},{30,50},{30,-50},{100,-50}}),
            Ellipse(extent={{10,20},{50,-20}}),
            Line(points={{-20,60},{20,60}}),
            Polygon(
              points={{20,60},{10,63},{10,57},{20,60}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}));
    end E_VCV;

    model G_VCC "Linear voltage-controlled current source"
      extends Interfaces.TwoPortControlledSources;
      parameter SI.Conductance transConductance(start=0) "Transconductance";
    equation
      i2 = v1*transConductance;
      i1 = 0;
      annotation (
        Documentation(info="<html>
<p>
The linear voltage-controlled current source is a TwoPort.
The right port current at pin p2 (=p2.i) is controlled by the left port voltage at pin p1 (p1.v)
via
</p>
<pre>
    p2.i = p1.v * transConductance.
</pre>
<p>
The left port current is zero. Any transConductance can be chosen.
</p>
The corresponding SPICE description
<pre>
    Gname N+ N- NC+ NC- VALUE
</pre>
<p>is translated to Modelica:</p>
<pre>

    Gname -> Spice3.Basic.G_VCC Gname
    (Gname is the name of the Modelica instance)
    N+ -> p2.i
    N- -> n2.i
    NC+ -> p1 .v
    NC- -> n1.v
    VALUE -> transConductance
</pre>
</html>"), Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-71,70},{69,-70}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{-100,-80},{99,-129}}, textString="%name"),
            Line(points={{-91,50},{-31,50}}),
            Line(points={{-31,-50},{-91,-50}}),
            Ellipse(extent={{9,20},{49,-20}}),
            Line(points={{-21,60},{19,60}}),
            Polygon(
              points={{19,60},{9,63},{9,57},{19,60}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Line(points={{89,50},{29,50},{29,20}}),
            Line(points={{90,-50},{29,-50},{29,-20}}),
            Line(points={{9,0},{49,0}})}));
    end G_VCC;

    model H_CCV "Linear current-controlled voltage source"
      extends Interfaces.TwoPortControlledSources;

      parameter SI.Resistance transResistance(start=0) "Transresistance";
    equation
      v2 = i1*transResistance;
      v1 = 0;
      annotation (
        Documentation(info="<html>
<p>The linear current-controlled voltage source is a TwoPort. The &quot;right&quot; port voltage at pin 2 (=p2.v) is controlled by the &quot;left&quot; port current at pin p1(=p1.i) via</p>
<pre>    p2.v = p1.i * transResistance.</pre>
<p>The controlling port voltage is zero. Any transResistance can be chosen.</p>
<p>The corresponding SPICE description</p>
<pre>    Hname N+ N- VNAM VALUE</pre>
<p>is translated to Modelica:</p>
<pre>    Hname -&gt; Spice3.Basic.H_CCV Hname
    (Hname is the name of the Modelica instance)
    N+ -&gt; p2.v
    N- -&gt; n2.v  </pre>
<p>The voltage source VNAM has the two nodes NV+ and NV-:</p>
<pre>                   VNAM VN+ VN- VALUE_V</pre>
<p>The current through VNAM hast to be led through the CCV.</p><p>Therefore VNAM has to be disconnected and an additional</p><p>node NV_AD has to be added.</p>
<pre>    NV_AD -&gt; p1.i
    NV- -&gt; n1.i</pre>
<p>On this way the current, that flows through the voltage source VNAM, flows through the CCV.</p>
<pre>
    VALUE -&gt; transResistance </pre>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-70,70},{70,-70}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{-99,-80},{100,-130}}, textString="%name"),
            Line(points={{100,50},{30,50},{30,-50},{100,-50}}),
            Ellipse(extent={{10,20},{50,-20}}),
            Line(points={{-20,60},{20,60}}),
            Polygon(
              points={{20,60},{10,63},{10,57},{20,60}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,50},{-20,50},{-20,-50},{-90,-50}})}));
    end H_CCV;

    model F_CCC "Linear current-controlled current source"
      extends Interfaces.TwoPortControlledSources;
      parameter Real gain(start=0) "Current gain";
    equation
      i2 = i1*gain;
      v1 = 0;
      annotation (
        Documentation(info="<html>
<p>The linear current-controlled current source is a TwoPort. The &quot;right&quot; port current at pin 2 (=p2.i) is controlled by the &quot;left&quot; port current at pin p1(=p1.i) via</p>
<pre>    p2.i = p1.i * gain.</pre>
<p>The controlling port voltage is zero. Any current gain can be chosen.</p>
<p>The corresponding SPICE description</p>
<pre>    Fname N+ N- VNAM VALUE</pre>
<p>is translated to Modelica:</p>
<pre>    Fname -&gt; Spice3.Basic.F_CCC Fname
    (Fname is the name of the Modelica instance)
    N+ -&gt; p2.i
    N- -&gt; n2.i  </pre>
<p>The voltage source VNAM has the two nodes NV+ and NV-:</p>
<pre>                   VNAM NV+ NV- VALUE_V</pre>
<p>The current through VNAM hast to be led through the CCC.</p>
<p>Therefore VNAM has to be disconnected and an additional</p>
<p>node NV_AD has to be added.</p>
<pre>    NV_AD -&gt; p1.i
    NV- -&gt; n1.i</pre>
<p>On this way the current, that flows through the voltage source VNAM, flows through the CCC.</p>
<pre>    VALUE -&gt; gain </pre>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-70,70},{70,-70}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{-104,-76},{97,-127}}, textString="%name"),
            Line(points={{-100,50},{-30,50},{-30,-50},{-100,-50}}),
            Ellipse(extent={{10,20},{50,-20}}),
            Line(points={{-20,60},{20,60}}),
            Polygon(
              points={{20,60},{10,63},{10,57},{20,60}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Line(points={{90,50},{30,50},{30,20}}),
            Line(points={{91,-50},{30,-50},{30,-20}}),
            Line(points={{10,0},{50,0}})}));
    end F_CCC;

    annotation(preferredView="info",
  Documentation(info="<html>
<p>This Package contains the basic components of the SPICE3 models. The first letter of the</p><p>name of the component shows the SPICE name, e.g., <strong>R</strong>_Resistor: <strong>R</strong> is the SPICE-name of the component</p><p>resistor which is used in SPICE-Netlists.</p>
</html>",
     revisions="<html>
<dl>
<dt>
<strong>Main Authors:</strong>
<dd>
Christoph Clau&szlig;
    &lt;<a href=\"mailto:christoph@clauss-it.com\">christoph@clauss-it.com</a>&gt;<br>

    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden
</dd>
</dl>
</html>"));
  end Basic;

  package Semiconductors "Semiconductor devices and model cards"
    extends Modelica.Icons.Package;

    model M_PMOS "PMOS MOSFET device"
      extends Modelica.Electrical.Spice3.Internal.MOS(
                              final mtype=1);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              points={{60,0},{40,5},{40,-5},{60,0}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>The model M_PMOS is a P channel MOSFET transistor with fixed level 1: Shichman-Hodges model</p>
<p>The models from the package Semiconductors accesses to the package Repository where all functions,</p>
<p>records and data are stored and modeled that are needed for the semiconductor models.</p>
<p>The package Semiconductors is for user access but not the package Repository.</p>
</html>", revisions="<html>
<ul>
<li><em>March 2008</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"));
    end M_PMOS;

    model M_NMOS "NMOS MOSFET device"
      extends Modelica.Electrical.Spice3.Internal.MOS(
                              final mtype=0);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              points={{40,0},{60,5},{60,-5},{40,0}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>The model M_NMOS is a N channel MOSFET transistor with fixed level 1: Shichman-Hodges model</p>
<p>The models from the package Semiconductors accesses to the package Repository where all functions,</p>
<p>records and data are stored and modeled that are needed for the semiconductor models.</p>
<p>The package Semiconductors is for user access but not the package Repository.</p>
</html>", revisions="<html>
<ul>
<li><em>March 2008</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"));
    end M_NMOS;

    record ModelcardMOS "Record for the specification of modelcard parameters"
      extends Modelica.Icons.Record;
      extends Modelica.Electrical.Spice3.Internal.ModelcardMOS;
      annotation (Documentation(info="<html>
<p>Technology model parameters of MOSFET transistor with fixed level 1: Shichman-Hodges model</p>
<p>In modelcards, that are typical for SPICE3, the so called technology parameters are stored. These parameters are usually set for more than one semiconductor device in a circuit, e.g., the temperature of a whole electrical circuit.</p>
</html>"));
    end ModelcardMOS;

    model M_NMOS2 "NMOS MOSFET device"
      extends Modelica.Electrical.Spice3.Internal.MOS2(
                              final mtype=0);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              points={{40,0},{60,5},{60,-5},{40,0}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>The model M_NMOS is a N channel MOSFET transistor with fixed level 2:</p>
<p>The models from the package Semiconductors accesses to the package Internal where all functions,</p>
<p>records and data are stored and modeled that are needed for the semiconductor models.</p>
<p>The package Semiconductors is for user access but not the package Internal.</p>
</html>", revisions="<html>
<ul>
<li><em>March 2008</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"));
    end M_NMOS2;

    model M_PMOS2 "PMOS MOSFET device"
      extends Modelica.Electrical.Spice3.Internal.MOS2(
                              final mtype=1);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              points={{60,0},{40,5},{40,-5},{60,0}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>The model M_PMOS is a P channel MOSFET transistor with fixed level 2:</p>
<p>The models from the package Semiconductors accesses to the package Internal where all functions,</p>
<p>records and data are stored and modeled that are needed for the semiconductor models.</p>
<p>The package Semiconductors is for user access but not the package Internal.</p>
</html>", revisions="<html>
<ul>
<li><em>March 2008</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"));
    end M_PMOS2;

    record ModelcardMOS2 "Record for the specification of modelcard parameters"
      extends Modelica.Icons.Record;
      extends Modelica.Electrical.Spice3.Internal.ModelcardMOS2;
      annotation (Documentation(info="<html>
<p>Technology model parameters of MOSFET transistor with fixed level 1: Shichman-Hodges model</p>
<p>In modelcards, that are typical for SPICE3, the so called technology parameters are stored. These parameters are usually set for more than one semiconductor device in a circuit, e.g., the temperature of a whole electrical circuit.</p>
</html>"));
    end ModelcardMOS2;

    model Q_NPNBJT "Bipolar junction transistor"
     extends Modelica.Electrical.Spice3.Internal.BJT2(
                            final TBJT=1);

      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              points={{8,-68},{2,-55},{-4,-62},{8,-68}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>The model Q_NPNBJT is a NPN bipolar junction transistor model: Modified Gummel-Poon.</p>
<p>The models from the package Semiconductors accesses to the package Internal where all functions,</p>
<p>records and data are stored and modeled that are needed for the semiconductor models.</p>
<p>The package Semiconductors is for user access but not the package Internal.</p>
</html>", revisions="<html>
<ul>
<li><em>August 2009</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"));

    end Q_NPNBJT;

    model Q_PNPBJT "Bipolar junction transistor"
     extends Modelica.Electrical.Spice3.Internal.BJT2(
                            final TBJT=-1);

      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              points={{0,-60},{14,-67},{8,-74},{0,-60}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>The model Q_PNPBJT is a PNP bipolar junction transistor model: Modified Gummel-Poon.</p>
<p>The models from the package Semiconductors accesses to the package Internal where all functions,</p>
<p>records and data are stored and modeled that are needed for the semiconductor models.</p>
<p>The package Semiconductors is for user access but not the package Internal.</p>
</html>", revisions="<html>
<ul>
<li><em>August 2009</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"));

    end Q_PNPBJT;

    record ModelcardBJT "Record for the specification of modelcard parameters"
      extends Modelica.Icons.Record;
      extends Modelica.Electrical.Spice3.Internal.ModelcardBJT2;
      annotation (Documentation(info="<html>
<p>In modelcards, that are typical for SPICE3, the so called technology parameters are stored. These parameters are usually set for more than one semiconductor device in a circuit, e.g., the temperature of a whole electrical circuit.</p>
<p>Technology parameters of the modified Gummel-Poon bipolar junction transistor model</p>
</html>"));
    end ModelcardBJT;

    model J_PJFJFET "P-channel Junction Field-Effect Transistor model (JFET)"
     extends Modelica.Electrical.Spice3.Internal.JFET(final mtype=1);

      annotation (
        Documentation(info="<html>
<p>J_PJFJFET is a P-channel junction field-effect transistor.</p>
<p>The junction field-effect transistor is derived from the FET model of Shichman and Hodges.</p>
<p>The models from the package Semiconductors accesses to the package Internal where all functions, records and data are stored and modeled that are needed for the semiconductor models. The package Semiconductors is for user access, but not the package Internal.</p>
</html>", revisions="<html>
<ul>
<li><em>September 2011 </em>revised by Sandra B&ouml;hme</br/>
<li><em>August 2009</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              points={{8,-68},{2,-55},{-4,-62},{8,-68}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}));

    end J_PJFJFET;

    model J_NJFJFET "N-channel Junction Field-Effect Transistor model (JFET)"
     extends Modelica.Electrical.Spice3.Internal.JFET(final mtype=0);

      annotation (
        Documentation(info="<html>
<p>J_NJFJFET is a N-channel junction field-effect transistor.</p>
<p>The junction field-effect transistor is derived from the FET model of Shichman and Hodges.</p>
<p>The models from the package Semiconductors accesses to the package Internal where all functions, records and data are stored and modeled that are needed for the semiconductor models. The package Semiconductors is for user access, but not the package Internal.</p>
</html>", revisions="<html>
<ul>
<li><em>September 2011 </em>revised by Sandra B&ouml;hme</br/>
<li><em>August 2009</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              points={{8,-68},{2,-55},{-4,-62},{8,-68}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}));

    end J_NJFJFET;

    record ModelcardJFET
      "Record for the specification of modelcard parameters for JFET"
      extends Modelica.Icons.Record;
      extends Modelica.Electrical.Spice3.Internal.ModelcardJFET;
      annotation (Documentation(info="<html>
<p>Technology parameters of the junction field-effect transistor model.</p>
<p>In modelcards, that are typical for SPICE3, the so called technology parameters are stored. These parameters are usually set for more than one semiconductor device in a circuit, e.g., the temperature of a whole electrical circuit.</p>
</html>"));
    end ModelcardJFET;

   model D_DIODE "Diode model"
     extends Modelica.Electrical.Spice3.Internal.DIODE;

     annotation (
        Documentation(info="<html>
<p>The model D_DIODE is a Junction diode model</p>
<p>The models from the package Semiconductors accesses to the package Repository where all functions,</p>
<p>records and data are stored and modeled that are needed for the semiconductor models.</p>
<p>The package Semiconductors is for user access but not the package Repository.</p>
</html>", revisions="<html>
<ul>
<li><em>Nov. 2008</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"));

   end D_DIODE;

   record ModelcardDIODE "Record for the specification of modelcard parameters"
     extends Modelica.Icons.Record;
     extends Modelica.Electrical.Spice3.Internal.ModelcardDIODE;
      annotation (Documentation(info="<html>
<p>In modelcards, that are typical for SPICE3, the so called technology parameters are stored. These parameters are usually set for more than one semiconductor device in a circuit, e.g., the temperature of a whole electrical circuit.</p>
<p>Technology parameters of the junction diode model</p>
</html>"));
   end ModelcardDIODE;

    model R_Resistor "Semiconductor resistor from SPICE3"
    extends Modelica.Electrical.Spice3.Internal.R_SEMI;
                    annotation (Documentation(info="<html>
<p>The model R_Resistor is a Semiconductor resistor model.</p>
<p>The models from the package Semiconductors accesses to the package Repository where all functions,</p>
<p>records and data are stored and modeled that are needed for the semiconductor models.</p>
<p>The package Semiconductors is for user access but not the package Repository.</p>
</html>", revisions="<html>
<ul>
<li><em>April 2009</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"));
    end R_Resistor;

    record ModelcardRESISTOR
      "Record for the specification of modelcard parameters"
      extends Modelica.Icons.Record;
      extends Modelica.Electrical.Spice3.Internal.ModelcardR;
      annotation (Documentation(info="<html>
<p>In modelcards, that are typical for SPICE3, the so called technology parameters are stored. These parameters are usually set for more than one semiconductor device in a circuit, e.g., the temperature of a whole electrical circuit.</p>
<p>Technology parameters of the semiconductor resistor model</p>
</html>"));
    end ModelcardRESISTOR;

    model C_Capacitor "Semiconductor capacitor"
    extends Modelica.Electrical.Spice3.Internal.C_SEMI;
                    annotation (
        Documentation(info="<html>
<p>C_Capacitor is a Semiconductor Capacitor model.</p>
<p>This capacitor model allows the calculation of the actual capacitance value from strictly geometric information and the specification of the process.</p>
<p>The models from the package Semiconductors accesses to the package Repository where all functions, records and data are stored and modeled that are needed for the semiconductor models. The package Semiconductors is for user access, but not the package Repository.</p>
</html>", revisions="<html>
<ul>
<li><em>September 2011 </em>revised by Sandra B&ouml;hme</br/>
<li><em>April 2009</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"));
    end C_Capacitor;

    record ModelcardCAPACITOR
      "Record for the specification of modelcard parameters for Semiconductor Capacitor"
      extends Modelica.Icons.Record;
      extends Modelica.Electrical.Spice3.Internal.ModelcardC;
      annotation (Documentation(info="<html>
<p>Technology parameters of the semiconductor capacitor model.</p>
<p>In modelcards, that are typical for SPICE3, the so called technology parameters are stored. These parameters are usually set for more than one semiconductor device in a circuit, e.g., the temperature of a whole electrical circuit.</p>
</html>"));
    end ModelcardCAPACITOR;
    annotation(preferredView="info",
      Documentation(info="<html>
<p>This package contains both the semiconductor devices models of SPICE3, which are available, and their modelcards. The user should apply the models of this package.</p>
<p>All models of this package extend models of the package Repository, which contains the functions, parameters and data which are necessary to model the behaviour of the semiconductor devices.The modelcard records contain the SPICE3 technology parameters, which can be adjusted for more than one MOS simultaneously.</p>
</html>"));
  end Semiconductors;

  package Sources "Time dependent SPICE3 voltage and current sources"

    extends Modelica.Icons.SourcesPackage;

    model V_constant "Constant independent voltage sources"
      parameter SI.Voltage V=1 "Value of constant voltage";
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
    equation
      v = V;
      annotation (
        Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}), graphics={
        Text(extent={{-100,-120},{100,-80}}, textString="%name=%V"),
            Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-50,0}}, color={0,0,255}),
            Line(points={{-50,0},{50,0}}, color={0,0,255}),
            Line(points={{50,0},{90,0}}, color={0,0,255}),
            Line(points={{60,20},{80,20}}, color={0,0,255}),
            Line(points={{-70,30},{-70,10}}, color={0,0,255}),
            Line(points={{-80,20},{-60,20}}, color={0,0,255})}),
    Documentation(info="<html>
<p>The V_constant source is a  source is a simple constant voltage source for an ideal constant voltage which is provided by a parameter.</p>
</html>"));
    end V_constant;

    model V_sin "Sinusoidal voltage source"
      import Modelica.Constants.pi;
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Voltage VO=0.0 "Offset";
      parameter SI.Voltage VA=0.0 "Amplitude";
      parameter SI.Frequency FREQ(start=1) "Frequency";
      parameter SI.Time TD=0.0 "Delay";
      parameter SI.Damping THETA=0.0 "Damping factor";
    equation
        assert(FREQ>0, "Frequency less or equal zero");
        v = VO + (if time < TD then 0 else VA*
        Modelica.Math.exp(-(time - TD)*THETA)*Modelica.Math.sin(2*pi
        *FREQ*(time - TD)));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Text(
              extent={{-122,53},{-22,3}},
              lineColor={0,0,255},
              textString="+"),
            Text(
              extent={{19,59},{119,9}},
              lineColor={0,0,255},
              textString="-"),
             Ellipse(
               extent={{-51,50},{49,-50}},
               lineColor={0,0,255},
               fillColor={255,255,255},
               fillPattern=FillPattern.Solid),
             Line(points={{-90,0},{50,0}}, color={0,0,255}),
             Line(points={{50,0},{90,0}}, color={0,0,255}),
            Line(points={{-80,4},{-75.2,36.3},{-72,54.3},{-68.7,68.5},{-65.5,
                  78.2},{-62.3,83.3},{-59.1,83.6},{-55.9,79.3},{-52.7,71.1},{
                  -48.6,56.2},{-43,29.8},{-35,-9.9},{-30.2,-29.7},{-26.1,-41.9},
                  {-22.1,-49.2},{-18.1,-51.3},{-14.1,-48.5},{-10.1,-41.3},{
                  -5.23,-28.1},{8.44,17.7},{13.3,30.4},{18.1,38.8},{22.1,42},{
                  26.9,41.2},{31.8,35.8},{38.2,23.4},{51.1,-6.5},{57.5,-17.2},{
                  63.1,-21.9},{68.7,-21.9},{75.2,-16.5},{80,-9.8}},
                                                         color={192,192,192}),
            Text(
              extent={{-150,-56},{150,-96}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>Damped sinusoidal source</p>
<h4>Note:</h4>
<ul>
<li>All parameters of sources should be set explicitly.</li>
<li>since TSTEP and TSTOP are not available for modeling in Modelica, differences to SPICE may occur if not all parameters are set.<br></li>
</ul>
</html>"));
    end V_sin;

    model V_exp "Exponential voltage source"
     extends Modelica.Electrical.Analog.Interfaces.OnePort;

      parameter SI.Voltage V1=0 "Initial value";
      parameter SI.Voltage V2=0 "Pulsed value";
      parameter SI.Time TD1=0.0 "Rise delay time";
      parameter SI.Time TAU1=1 "Rise time constant";
      parameter SI.Time TD2=1 "Fall delay time";
      parameter SI.Time TAU2=1 "Fall time constant";

    equation
    v = V1 + (if (time < TD1) then 0 else if (time < (TD2)) then
              (V2-V1)*(1 - Modelica.Math.exp(-(time - TD1)/TAU1)) else
              (V2-V1)*(1 - Modelica.Math.exp(-(time - TD1)/TAU1)) +
              (V1-V2)*(1 - Modelica.Math.exp(-(time - TD2)/TAU2)));
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{-117,57},{-17,7}},
              lineColor={0,0,255},
              textString="+"),
            Text(
              extent={{22,60},{122,10}},
              lineColor={0,0,255},
              textString="-"),
            Text(
              extent={{-153,-58},{147,-98}},
              textString="%name",
              lineColor={0,0,255}),
             Ellipse(
               extent={{-51,50},{49,-50}},
               lineColor={0,0,255},
               fillColor={255,255,255},
               fillPattern=FillPattern.Solid),
             Line(points={{-90,0},{50,0}}, color={0,0,255}),
             Line(points={{50,0},{90,0}}, color={0,0,255}),
            Line(points={{-70,-48},{-67.2,-33.3},{-64.3,-20.1},{-60.8,-5.6},{
                  -57.3,7},{-53.7,17.92},{-49.5,29.18},{-45.3,38.7},{-40.3,48},
                  {-34.6,56.5},{-28.3,64.1},{-21.2,70.6},{-12.7,76.3},{-2.1,
                  81.2},{0,82},{2.12,69.5},{4.95,54.7},{7.78,41.8},{10,31},{
                  14.14,18.3},{17.68,8},{21.9,-2.2},{26.2,-10.6},{31.1,-18.5},{
                  36.8,-25.4},{43.1,-31.3},{50.9,-36.5},{60.8,-40.8},{70,-43.4}},
                                                                      color={
                  192,192,192})}),
        Documentation(info="<html>
<p>Rising and falling exponential source.</p>
<h4>Note:</h4>
<ul>
<li>All parameters of sources should be set explicitly.</li>
<li>since TSTEP and TSTOP are not available for modeling in Modelica, differences to SPICE may occur if not all parameters are set.- it should be set all the parameters definitely<br>- normally, there exist differences between Dymola and Spice, because TSTEP and TSTOP are not available.<br></li>
</ul>
</html>"));
    end V_exp;

    model V_pulse "Pulse voltage source"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;

      parameter SI.Voltage V1 = 0 "Initial value";
      parameter SI.Voltage V2 = 0 "Pulsed value";
      parameter SI.Time TD = 0.0 "Delay time";
      parameter SI.Time TR(start=1) "Rise time";
      parameter SI.Time TF = TR "Fall time";
      parameter SI.Time PW = Modelica.Constants.inf "Pulse width";
      parameter SI.Time PER= Modelica.Constants.inf "Period";

    protected
      parameter SI.Time Trising=TR "End time of rising phase within one period";
      parameter SI.Time Twidth=Trising + PW
        "End time of width phase within one period";
      parameter SI.Time Tfalling=Twidth + TF
        "End time of falling phase within one period";
      SI.Time T0(final start=TD, fixed=true) "Start time of current period";
      Integer counter(start=-1, fixed=true) "Period counter";
      Integer counter2(start=-1, fixed=true);

    equation
      when pre(counter2) <> 0 and sample(TD, PER) then
        T0 = time;
        counter2 = pre(counter);
        counter = pre(counter) - (if pre(counter) > 0 then 1 else 0);
      end when;
      v = V1 + (if (time < TD or counter2 == 0 or time >= T0 +
        Tfalling) then 0 else if (time < T0 + Trising) then (time - T0)*
        (V2-V1)/Trising else if (time < T0 + Twidth) then V2-V1 else
        (T0 + Tfalling - time)*(V2-V1)/(Tfalling - Twidth));

      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{-120,49},{-20,-1}},
              lineColor={0,0,255},
              textString="+"),
            Text(
              extent={{25,53},{125,3}},
              lineColor={0,0,255},
              textString="-"),
            Text(
              extent={{-157,-62},{143,-102}},
              textString="%name",
              lineColor={0,0,255}),
             Ellipse(
               extent={{-51,50},{49,-50}},
               lineColor={0,0,255},
               fillColor={255,255,255},
               fillPattern=FillPattern.Solid),
             Line(points={{-90,0},{50,0}}, color={0,0,255}),
             Line(points={{50,0},{90,0}}, color={0,0,255}),
            Line(points={{-86,-74},{-65,-74},{-35,66},{-4,66},{25,-74},{46,-74},
                  {75,66}}, color={192,192,192})}),
        Documentation(info="<html>
<p>Periodic pulse source with not limited number of periods.</p>
<p>A single pulse is described by the following table:</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><h4>time</h4></td>
<td><h4>value</h4></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>V1</p></td>
</tr>
<tr>
<td><p>TD</p></td>
<td><p>V1</p></td>
</tr>
<tr>
<td><p>TD+TR</p></td>
<td><p>V2</p></td>
</tr>
<tr>
<td><p>TD+TR+PW</p></td>
<td><p>V2</p></td>
</tr>
<tr>
<td><p>TD+TR+PW+TF</p></td>
<td><p>V1</p></td>
</tr>
<tr>
<td><p>TSTOP</p></td>
<td><p>V1</p></td>
</tr>
</table>
<p>Intermediate points are determined by linear interpolation.</p>
<p>A pulse it looks like a saw tooth, use this parameters e.g.:</p>
<table cellspacing=\"2\" cellpadding=\"2\" border=\"1\"><tr>
<td><h4>Parameter</h4></td>
<td><h4>Value</h4></td>
</tr>
<tr>
<td><p>V1</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>V2</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>TD</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>TR</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>TF</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>PW</p></td>
<td><p>2</p></td>
</tr>
<tr>
<td><p>PER</p></td>
<td><p>1</p></td>
</tr>
</table>
<h4>Note:</h4>
<ul>
<li>All parameters of sources should be set explicitly.</li>
<li>since TSTEP and TSTOP are not available for modeling in Modelica, differences to SPICE may occur if not all parameters are set.</li>
</ul>
</html>"));
    end V_pulse;

    model V_pwl "Piece-wise linear voltage source"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter Real table[:, :]=[0, 0; 1, 1; 2, 4]
        "Table matrix (time = first column, voltage = second column)";
    protected
     parameter Integer x= size(table,1);
     parameter Real tlast = table[x,1] + 1;
     parameter Real valuelast = table[x,2];
     parameter Real lastvaluematrix[1,2]=[tlast, valuelast];
     parameter Real tablenew[:,2]=cat(1,table,lastvaluematrix);
      Modelica.Blocks.Sources.TimeTable tab(table=tablenew);
    equation
      v = tab.y;
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{-150,-56},{150,-96}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-120,49},{-20,-1}},
              lineColor={0,0,255},
              textString="+"),
            Text(
              extent={{25,53},{125,3}},
              lineColor={0,0,255},
              textString="-"),
             Ellipse(
               extent={{-51,50},{49,-50}},
               lineColor={0,0,255},
               fillColor={255,255,255},
               fillPattern=FillPattern.Solid),
             Line(points={{-90,0},{50,0}}, color={0,0,255}),
             Line(points={{50,0},{90,0}}, color={0,0,255}),
                                   Line(points={{-40,-50},{-40,70},{60,70},{60,
                  -50},{-40,-50},{-40,-20},{60,-20},{60,10},{-40,10},{-40,40},{
                  60,40},{60,70},{10,70},{10,-51}}, color={192,192,192})}),
        Documentation(info="<html>
<p>This model generates a voltage by <strong>linear interpolation</strong> in a given table. The time points and voltage values are stored in a matrix <strong>table[i,j]</strong>, where the first column table[:,1] contains the time points and the second column contains the voltage to be interpolated. The table interpolation has the following properties:</p>
<ul>
<li>The time points need to be <strong>monotonically increasing</strong>.</li>
<li><strong>Discontinuities</strong> are allowed, by providing the same time point twice in the table.</li>
<li>Values <strong>outside</strong> of the table range, are computed by <strong>extrapolation</strong> through the last or first two points of the table.</li>
<li>If the table has only <strong>one row</strong>, no interpolation is performed and the voltage value is just returned independently of the actual time instant, i.e., this is a constant voltage source.</li>
<li>Via parameters <strong>startTime</strong> and <strong>offset</strong> the curve defined by the table can be shifted both in time and in the voltage.</li>
<li>The table is implemented in a numerically sound way by generating <strong>time events</strong> at interval boundaries.
    This generates continuously differentiable values for the integrator.</li>
</ul>
<p>Example:</p>
<pre>   table = [0  0
            1  0
            1  1
            2  4
            3  9
            4 16]
If, e.g., time = 1.0, the voltage v =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the voltage v =  2.5,
    e.g., time = 2.0, the voltage v =  4.0,
    e.g., time = 5.0, the voltage v = 23.0 (i.e., extrapolation).
</pre>
</html>"));
    end V_pwl;

    model V_sffm "Single-frequency FM voltage source"
      import Modelica.Constants.pi;
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Voltage VO = 0 "Offset";
      parameter SI.Voltage VA = 0 "Amplitude";
      parameter SI.Frequency FC( start=0) "Carrier frequency";
      parameter Real MDI=0 "Modulation index";
      parameter SI.Frequency FS= FC "Signal frequency";
    equation
      v = VO + VA *Modelica.Math.sin( 2 *pi * FC *time + MDI *Modelica.Math.sin(2 *pi *FS *time));
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{-150,-56},{150,-96}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-120,49},{-20,-1}},
              lineColor={0,0,255},
              textString="+"),
            Text(
              extent={{25,53},{125,3}},
              lineColor={0,0,255},
              textString="-"),
             Ellipse(
               extent={{-51,50},{49,-50}},
               lineColor={0,0,255},
               fillColor={255,255,255},
               fillPattern=FillPattern.Solid),
             Line(points={{-90,0},{50,0}}, color={0,0,255}),
             Line(points={{50,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-51,57},{55,18}},
              lineColor={0,0,255},
              textString="SFFM")}),
        Documentation(info="<html>
<p>The single-frequency frequency modulation source generates a carrier signal of the frequency FC. This signal is modulated by the signal frequency FS. See the formula in the Modelica text.</p>
<h4>Attention:</h4>
<ul>
<li>All parameters of sources should be set explicitly.</li>
<li>since TSTEP and TSTOP are not available for modeling in Modelica, differences to SPICE may occur if not all parameters are set.</li>
</ul>
</html>"));
    end V_sffm;

   model I_constant "Constant independent current sources"
      parameter SI.Current I=1 "Value of constant voltage";
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
   equation
      i = I;
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={
            Text(extent={{-94,-106},{106,-66}}, textString="%name=%I"),
            Ellipse(
              extent={{-51,50},{49,-50}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-50,0}}, color={0,0,255}),
            Line(points={{50,0},{90,0}}, color={0,0,255}),
            Line(points={{-1,-50},{-1,50}},
                                          color={0,0,255})}),
        Documentation(info="<html>
<p>The I_constant source is a simple constant current source for an ideal constant current which is provided by a parameter.</p>
</html>"));
   end I_constant;

    model I_sin "Sinusoidal current source"
      import Modelica.Constants.pi;
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Current IO=0 "Offset";
      parameter SI.Current IA=0 "Amplitude";
      parameter SI.Frequency FREQ(start=1) "Frequency";
      parameter SI.Time TD=0.0 "Delay";
      parameter SI.Damping THETA=0.0 "Damping factor";
    equation
        assert(FREQ>0, "Frequency less or equal zero");
        i = IO + (if time < TD then 0 else IA*
        Modelica.Math.exp(-(time - TD)*THETA)*Modelica.Math.sin(2*pi
        *FREQ*(time - TD)));
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
             Ellipse(
               extent={{-51,50},{49,-50}},
               lineColor={0,0,255},
               fillColor={255,255,255},
               fillPattern=FillPattern.Solid),
             Line(points={{-90,0},{-50,0}}, color={0,0,255}),
             Line(points={{50,0},{90,0}}, color={0,0,255}),
             Line(points={{-1,-50},{-1,50}},
                                           color={0,0,255}),
            Text(
              extent={{-144,-64},{156,-104}},
              textString="%name",
              lineColor={0,0,255}),Line(points={{-77,-12},{-72.2,20.3},{-69,
                  38.3},{-65.7,52.5},{-62.5,62.2},{-59.3,67.3},{-56.1,67.6},{
                  -52.9,63.3},{-49.7,55.1},{-45.6,40.2},{-40,13.8},{-32,-25.9},
                  {-27.2,-45.7},{-23.1,-57.9},{-19.1,-65.2},{-15.1,-67.3},{
                  -11.1,-64.5},{-7.1,-57.3},{-2.23,-44.1},{11.44,1.7},{16.3,
                  14.4},{21.1,22.8},{25.1,26},{29.9,25.2},{34.8,19.8},{41.2,7.4},
                  {54.1,-22.5},{60.5,-33.2},{66.1,-37.9},{71.7,-37.9},{78.2,
                  -32.5},{83,-25.8}},
                color={192,192,192})}),
        Documentation(info="<html>
<p>Damped sinusoidal source</p>
<h4>Note:</h4>
<ul>
<li>All parameters of sources should be set explicitly.</li>
<li>since TSTEP and TSTOP are not available for modeling in Modelica, differences to SPICE may occur if not all parameters are set.</li>
</ul>
</html>"));
    end I_sin;

    model I_exp "Exponential current source"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Current I1=0 "Initial value";
      parameter SI.Current I2=0 "Pulsed value";
      parameter SI.Time TD1=0.0 "Rise delay time";
      parameter SI.Time TAU1=1 "Rise time constant";
      parameter SI.Time TD2=2 "Fall delay time";
      parameter SI.Time TAU2=1 "Fall time constant";
    equation
    i = I1 + (if (time < TD1) then 0 else if (time < (TD2)) then
              (I2-I1)*(1 - Modelica.Math.exp(-(time - TD1)/TAU1)) else
              (I2-I1)*(1 - Modelica.Math.exp(-(time - TD1)/TAU1)) +
              (I1-I2)*(1 - Modelica.Math.exp(-(time - TD2)/TAU2)));
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
             Ellipse(
               extent={{-50,50},{50,-50}},
               lineColor={0,0,255},
               fillColor={255,255,255},
               fillPattern=FillPattern.Solid),
             Line(points={{-89,0},{-49,0}}, color={0,0,255}),
             Line(points={{51,0},{91,0}}, color={0,0,255}),
             Line(points={{0,-50},{0,50}}, color={0,0,255}),
            Text(
              extent={{-145,-60},{155,-100}},
              textString="%name",
              lineColor={0,0,255}),Line(points={{-79,-53},{-76.2,-38.3},{-73.3,
                  -25.1},{-69.8,-10.6},{-66.3,2},{-62.7,12.92},{-58.5,24.18},{
                  -54.3,33.7},{-49.3,43},{-43.6,51.5},{-37.3,59.1},{-30.2,65.6},
                  {-21.7,71.3},{-11.1,76.2},{-9,77},{-6.88,64.5},{-4.05,49.7},{
                  -1.22,36.8},{1.606,25.45},{5.14,13.3},{8.68,3},{12.9,-7.2},{
                  17.2,-15.6},{22.1,-23.5},{27.8,-30.4},{34.1,-36.3},{41.9,
                  -41.5},{51.8,-45.8},{61,-48.4}},
                                           color={192,192,192})}),
        Documentation(info="<html>
<p>Rising and falling exponential source.</p>
<h4>Note:</h4>
<ul>
<li>All parameters of sources should be set explicitly.</li>
<li>since TSTEP and TSTOP are not available for modeling in Modelica, differences to SPICE may occur if not all parameters are set.</li>
</ul>
</html>"));
    end I_exp;

    model I_pulse "Pulse current source"
     extends Modelica.Electrical.Analog.Interfaces.OnePort;

      parameter SI.Current I1 = 0 "Initial value";
      parameter SI.Current I2 = 0 "Pulsed value";
      parameter SI.Time TD = 0.0 "Delay time";
      parameter SI.Time TR(start=1) "Rise time";
      parameter SI.Time TF = TR "Fall time";
      parameter SI.Time PW = Modelica.Constants.inf "Pulse width";
      parameter SI.Time PER= Modelica.Constants.inf "Period";

    protected
      parameter SI.Time Trising=TR "End time of rising phase within one period";
      parameter SI.Time Twidth=Trising + PW
        "End time of width phase within one period";
      parameter SI.Time Tfalling=Twidth + TF
        "End time of falling phase within one period";
      SI.Time T0(final start=TD, fixed=true) "Start time of current period";
      Integer counter(start=-1) "Period counter";
      Integer counter2(start=-1);

    equation
      when pre(counter2) <> 0 and sample(TD, PER) then
        T0 = time;
        counter2 = pre(counter);
        counter = pre(counter) - (if pre(counter) > 0 then 1 else 0);
      end when;
      i = I1 + (if (time < TD or counter2 == 0 or time >= T0 +
        Tfalling) then 0 else if (time < T0 + Trising) then (time - T0)*
        (I2-I1)/Trising else if (time < T0 + Twidth) then I2-I1 else
        (T0 + Tfalling - time)*(I2-I1)/(Tfalling - Twidth));

      annotation (Icon(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}), graphics={
                                  Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
             Ellipse(
               extent={{-51,50},{49,-50}},
               lineColor={0,0,255},
               fillColor={255,255,255},
               fillPattern=FillPattern.Solid),
             Line(points={{-90,0},{-50,0}}, color={0,0,255}),
             Line(points={{50,0},{90,0}}, color={0,0,255}),
             Line(points={{-1,-50},{-1,50}},
                                           color={0,0,255}),
            Text(
              extent={{-150,-58},{150,-98}},
              textString="%name",
              lineColor={0,0,255}), Line(points={{-85,-60},
                  {-64,-60},{-34,80},{-3,80},{26,-60},{47,-60},{76,80}}, color=
                  {192,192,192})}),
        Documentation(info="<html>
<p>Periodic pulse source with not limited number of periods.</p>
<p>A single pulse is described by the following table:</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><h4>time</h4></td>
<td><h4>value</h4></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>I1</p></td>
</tr>
<tr>
<td><p>TD</p></td>
<td><p>I1</p></td>
</tr>
<tr>
<td><p>TD+TR</p></td>
<td><p>I2</p></td>
</tr>
<tr>
<td><p>TD+TR+PW</p></td>
<td><p>I2</p></td>
</tr>
<tr>
<td><p>TD+TR+PW+TF</p></td>
<td><p>I1</p></td>
</tr>
<tr>
<td><p>TSTOP</p></td>
<td><p>I1</p></td>
</tr>
</table>
<p>Intermediate points are determined by linear interpolation.</p>
<p>A pulse it looks like a saw tooth, use this parameters e.g.:</p>
<table cellspacing=\"2\" cellpadding=\"2\" border=\"1\"><tr>
<td><h4>Parameter</h4></td>
<td><h4>Value</h4></td>
</tr>
<tr>
<td><p>I1</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>I2</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>TD</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>TR</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>TF</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>PW</p></td>
<td><p>2</p></td>
</tr>
<tr>
<td><p>PER</p></td>
<td><p>1</p></td>
</tr>
</table>
<h4>Note:</h4>
<ul>
<li>All parameters of sources should be set explicitly.</li>
<li>since TSTEP and TSTOP are not available for modeling in Modelica, differences to SPICE may occur if not all parameters are set.</li>
</ul>
</html>"));
    end I_pulse;

    model I_pwl "Piece-wise linear current source"
       extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter Real table[:, :]=[0, 0; 1, 1; 2, 4]
        "Table matrix (time = first column, voltage = second column)";
    protected
     parameter Integer x= size(table,1);
     parameter Real tlast = table[x,1] + 1;
     parameter Real valuelast = table[x,2];
     parameter Real lastvaluematrix[1,2]=[tlast, valuelast];
     parameter Real tablenew[:,2]=cat(1,table,lastvaluematrix);
     Modelica.Blocks.Sources.TimeTable tab(table=tablenew);

    equation
      i = tab.y;

      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={
             Ellipse(
               extent={{-51,50},{49,-50}},
               lineColor={0,0,255},
               fillColor={255,255,255},
               fillPattern=FillPattern.Solid),
             Line(points={{-90,0},{-50,0}}, color={0,0,255}),
             Line(points={{50,0},{90,0}}, color={0,0,255}),
             Line(points={{-1,-50},{-1,50}},
                                           color={0,0,255}),
            Text(
              extent={{-148,-57},{152,-97}},
              textString="%name",
              lineColor={0,0,255}),Line(points={{-44,-39},{-44,81},{56,81},{56,
                  -39},{-44,-39},{-44,-9},{56,-9},{56,21},{-44,21},{-44,51},{56,
                  51},{56,81},{6,81},{6,-40}}, color={192,192,192}),
                                  Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>This model generates a current  by <strong>linear interpolation</strong> in a given table. The time points and current values are stored in a matrix <strong>table[i,j]</strong>, where the first column table[:,1] contains the time points and the second column contains the current to be interpolated. The table interpolation has the following properties:</p>

<ul>
<li>The time points need to be <strong>monotonically increasing</strong>.</li>
<li><strong>Discontinuities</strong> are allowed, by providing the same time point twice in the table.</li>
<li>Values <strong>outside</strong> of the table range, are computed by <strong>extrapolation</strong> through the last or first two points of the table.</li>
<li>If the table has only <strong>one row</strong>, no interpolation is performed and the current value is just returned independently of the actual time instant, i.e., this is a constant current source.</li>
<li>Via parameters <strong>startTime</strong> and <strong>offset</strong> the curve defined by the table can be shifted both in time and in the current.</li>
<li>The table is implemented in a numerically sound way by generating <strong>time events</strong> at interval boundaries.
    This generates continuously differentiable values for the integrator.</li>
</ul>

<p>Example:</p>
<pre>   table = [0  0
            1  0
            1  1
            2  4
            3  9
            4 16]
If, e.g., time = 1.0, the current i =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the current i =  2.5,
    e.g., time = 2.0, the current i =  4.0,
    e.g., time = 5.0, the current i = 23.0 (i.e., extrapolation).
</pre>
</html>"));
    end I_pwl;

    model I_sffm "Single-frequency FM current source"
      import Modelica.Constants.pi;
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Current IO = 0 "Offset";
      parameter SI.Current IA = 0 "Amplitude";
      parameter SI.Frequency FC( start=0) "Carrier frequency";
      parameter Real MDI=0 "Modulation index";
      parameter SI.Frequency FS= FC "Signal frequency";
    equation
      i = IO + IA *Modelica.Math.sin( 2 *pi * FC *time + MDI *Modelica.Math.sin(2 *pi *FS *time));
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{-150,-56},{150,-96}},
              textString="%name",
              lineColor={0,0,255}),
             Ellipse(
               extent={{-51,50},{49,-50}},
               lineColor={0,0,255},
               fillColor={255,255,255},
               fillPattern=FillPattern.Solid),
             Line(points={{50,0},{90,0}}, color={0,0,255}),
             Line(points={{-92,0},{-52,0}},
                                          color={0,0,255}),
             Line(points={{0,-50},{0,50}}, color={0,0,255}),
                                  Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-58,53},{48,14}},
              lineColor={0,0,255},
              textString="SFFM")}),
        Documentation(info="<html>
<p>The single-frequency frequency modulation source generates a carrier signal of the frequency FC. This signal is modulated by the signal frequency FS. See the formula in the Modelica text.</p>
<h4>Note:</h4>
<ul>
<li>All parameters of sources should be set explicitly.</li>
<li>since TSTEP and TSTOP are not available for modeling in Modelica, differences to SPICE may occur if not all parameters are set.</li>
</ul>
</html>"));
    end I_sffm;

    annotation(preferredView="info", Documentation(info=
                   "<html>
<p>This package contains the SPICE sources.</p>
<p><strong>Note:</strong> There are differences between SPICE3 and Modelica concerning the default values of the parameter. Therefore it is recommended to specify <strong>all</strong> parameters of the source.</p>
</html>", revisions="<html>
<ul>
<li><em>August 2009 </em>default values improved by Jonathan Kress<br/></li>
<li><em>October 2008</em> by Christoph Clauss initially implemented.</li>
</ul>
</html>"));
  end Sources;

  package Additionals
    "Some useful additional models, e.g., from SPICE2 the polynomial sources"
      extends Modelica.Icons.Package;
    function poly "POLY function of SPICE2"
      extends Modelica.Icons.Function;
      input Real s[:] "Variables";
      input Real a[:] "Coefficients";
      output Real v "Value of polynomial";
    protected
      Integer n "number of polynomial variables, like POLY(n)";
      Integer na "number of polynomial coefficients, like POLY(n)";
      Integer ia "state of the usage of a";
    algorithm
      n := size(s,1);
      na := size(a,1);
      assert(n > 0,"poly: number of variables zero");
      assert(na > 0,"poly: number of coefficients zero");
      ia := 0;

    // case one coefficient
      if (na == 1) then
        v := a[1] * s[1];
        return;
      end if;

    // absolute term
      v := a[1];
      ia := 1;

    // linear terms
      for i1 in 1:n loop
        ia := ia + 1;
        if ia > na then
                        return;
                                end if;
        v := v + a[ia] * s[i1];
      end for;

    // quadratic terms
      for i1 in 1:n loop
        for i2 in i1:n loop
          ia := ia + 1;
          if ia > na then
             return;
          end if;
          v := v + a[ia] * s[i1] * s[i2];
        end for;
      end for;

    // cubic terms
      for i1 in 1:n loop
        for i2 in i1:n loop
          for i3 in i2:n loop
            ia := ia + 1;
            if ia > na then
               return;
            end if;
            v := v + a[ia] * s[i1] * s[i2] * s[i3];
          end for;
        end for;
      end for;

    // fourth potential terms
      for i1 in 1:n loop
        for i2 in i1:n loop
          for i3 in i2:n loop
            for i4 in i3:n loop
              ia := ia + 1;
              if ia > na then
                return;
              end if;
              v := v + a[ia] * s[i1] * s[i2] * s[i3] * s[i4];
            end for;
          end for;
        end for;
      end for;

     // fifth potential terms
      for i1 in 1:n loop
        for i2 in i1:n loop
          for i3 in i2:n loop
            for i4 in i3:n loop
              for i5 in i4:n loop
                ia := ia + 1;
                if ia > na then
                  return;
                end if;
                v := v + a[ia] * s[i1] * s[i2] * s[i3] * s[i4] * s[i5];
              end for;
            end for;
          end for;
        end for;
      end for;

      v := na;
     annotation (Documentation(info="<html>
<p>Function needed for polynomial interpolation of POLY controlled sources:</p>
<ul>
<li>E_VCV_POLY</li>
<li>G_VCC_POLY</li>
<li>H_CCV_POLY</li>
<li>F_CCC_POLY</li>
</ul>
</html>"));
    end poly;

    model E_VCV_POLY
      "Polynomial voltage controlled voltage source, like SPICE2"

      parameter Integer N(final min=1) = 1 "Number of controlling voltages";
      parameter Real coeff[:] = {1} "Coefficients of polynomial";
      Modelica.Electrical.Analog.Interfaces.PositivePin p
        "Positive pin of the controlled (normally right) port (potential p2.v > n2.v for positive voltage drop v2)"
                                                                                                           annotation (Placement(
            transformation(extent={{110,40},{90,60}}),
            iconTransformation(extent={{110,40},{90,60}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n
        "Negative pin of the controlled (normally right) port"
                                                      annotation (Placement(
            transformation(extent={{90,-60},{110,-40}}),
            iconTransformation(extent={{90,-60},{110,-40}})));

      Modelica.Electrical.Analog.Interfaces.PositivePin pc[2*N]
        "Pin vector of controlling pins (normally left)"
            annotation (Placement(transformation(
              extent={{-90,-80},{-70,80}}), iconTransformation(extent={
                {-90,-80},{-70,80}})));

      Real control[N];
    equation
      p.i + n.i = 0;
      for i in 1:2*N loop
        pc[i].i = 0;
      end for;
      for i in 1:N loop
        control[i] = pc[2*i-1].v - pc[2*i].v;
      end for;
      p.v - n.v = poly(control, coeff);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-70,70},{70,-70}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Text(
              extent={{-100,-62},{99,-112}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{100,50},{30,50},{30,-50},{100,-50}}, color={0,0,255}),
            Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}),
            Line(points={{-20,50},{20,50}}, color={0,0,255}),
            Polygon(
              points={{20,50},{10,53},{10,47},{20,50}},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Text(
              extent={{-54,-26},{22,-60}},
              lineColor={0,0,255},
              textString="VCV")}),
        Documentation(info="<html>
<p>The polynomial source is a SPICE2 model, which is also known in other SPICE derivatives.</p>
<p>Nonlinear voltage controlled voltage source. The &quot;right&quot; port voltage between pin p2 and n2 (=p2.v - n2.v) is controlled by the &quot;left&quot; port vector of voltages at the pin vector pc[:] via</p>
<pre>    p2.v - n2.v = f(pc[1].v - pc[2].v, pc[3].v - pc[4].v,...)</pre>
<p>The controlling port (left) current vector is zero.</p>
<p>f is a polynomial in N variables s1...sN of the following form with M+1 coefficients a0, a1, a2,...aM.</p>
<pre>f = a0 +
    a1s1 + a2s2 + ... + aNsN +
    a(N+1)s1&sup2; + a(N+2)s1s2 + ... + a(.)s1sN +
    a(.)s2&sup2; + a(.)s2s3 + ... + a(.)s2sN +
    a(.)s3&sup2; + s3s4 + ... + a(.)s4sN +
    ... +
    a(.)sN&sup2; +
    a(.)s1&sup3; + a(.)s1&sup2;s2 + a(.)s1&sup2;s3 + ... + a(.)s1&sup2;sN +
    a(.)s1s2&sup2; + a(.)s1s2s3 + ... + a(.)s1s2sN +
    ... +
    a(.)sN&sup3; + ... </pre>
<p>The Coefficients a(.) are counted in this order. Reaching M, the particular sum is canceled.</p>
<p>In connection with the VCV, s1...sN are the voltages of the controlling side: s1=pc[1].v - pc[2].v, s2=pc[3].v - pc[4].v, s3=...</p>
<p>The corresponding SPICE description of the VCV polynomial source is the following:</p>
<pre>    Ename A1 A2 POLY(N) E11 E21 ... E1N E2N P0 P1...</pre>
<p>where Ename is the name of the instance, A1 and A2 are the nodes between them the controlled voltage is gripped,</p>
<p>N is the number of the controlling voltages, E11 E12 ... E1N E2N are pairs of nodes between them the controlling voltages</p>
<p>are gripped, and P0, P1... are the coefficients that are called a0, a1, ... aM in the description of the polynomial f above.</p>
<p>To describe the SPICE line in Modelica, the following explanation would be useful:</p>
<pre>Ename -&gt; E_VCV_POLY name
A1, A2 -&gt; pins name.p2, name.p1
N -&gt; parameter N
E11 -&gt; name.pc[2]
E12 -&gt; name.pc[1]
...
E1N -&gt; name.pc[N]
E2N -&gt; name.pc[N-1]
P0, P1 -&gt; polynomial coefficients name.coeff(coeff={P0,P1,...})</pre>
</html>", revisions="<html>
<ul>
<li><em>Sept 2008</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"));
    end E_VCV_POLY;

    model G_VCC_POLY
      "Polynomial voltage controlled current source, like SPICE2"

      parameter Integer N(final min=1) = 1 "Number of controlling voltages";
      parameter Real coeff[:] = {1} "Coefficients of polynomial";
      Modelica.Electrical.Analog.Interfaces.PositivePin p
        "Positive pin of the right port (potential p2.v > n2.v for positive voltage drop v2)" annotation (Placement(
            transformation(extent={{110,40},{90,60}}),
            iconTransformation(extent={{110,40},{90,60}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n
        "Negative pin of the right port" annotation (Placement(
            transformation(extent={{90,-60},{110,-40}}),
            iconTransformation(extent={{90,-60},{110,-40}})));

      Modelica.Electrical.Analog.Interfaces.PositivePin pc[2*N]
        "Pin vector of controlling pins"
            annotation (Placement(transformation(
              extent={{-90,-80},{-70,80}}), iconTransformation(extent={
                {-90,-80},{-70,80}})));

      Real control[N];
    equation
      p.i + n.i = 0;
      for i in 1:2*N loop
        pc[i].i = 0;
      end for;
      for i in 1:N loop
        control[i] = pc[2*i-1].v - pc[2*i].v;
      end for;
      p.i = poly(control, coeff);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-70,70},{70,-70}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Text(
              extent={{-100,-62},{99,-112}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{100,50},{30,50},{30,-50},{100,-50}}, color={0,0,255}),
            Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}),
            Line(points={{-20,50},{20,50}}, color={0,0,255}),
            Polygon(
              points={{20,50},{10,53},{10,47},{20,50}},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Text(
              extent={{-60,-24},{16,-58}},
              lineColor={0,0,255},
              textString="VCC")}),
        Documentation(info="<html>
<p>The polynomial source is a SPICE2 model, which is also known in other SPICE derivatives.</p>
<p>Nonlinear voltage controlled current source. The right port current at pin p2 (=p2.i) is controlled by the left port vector of voltages at the pin vector pc[:] via</p>
<pre>    p2.i = f(pc[1].v - pc[2].v, pc[3].v - pc[4].v,...)</pre>
<p>The controlling port (left) current vector is zero.</p>
<p>f is a polynomial in N variables s1...sN of the following form with M+1 coefficients a0, a1, a2,...aM.</p>
<pre>f = a0 +
    a1s1 + a2s2 + ... + aNsN +
    a(N+1)s1&sup2; + a(N+2)s1s2 + ... + a(.)s1sN +
    a(.)s2&sup2; + a(.)s2s3 + ... + a(.)s2sN +
    a(.)s3&sup2; + s3s4 + ... + a(.)s4sN +
    ... +
    a(.)sN&sup2; +
    a(.)s1&sup3; + a(.)s1&sup2;s2 + a(.)s1&sup2;s3 + ... + a(.)s1&sup2;sN +
    a(.)s1s2&sup2; + a(.)s1s2s3 + ... + a(.)s1s2sN +
    ... +
    a(.)sN&sup3; + ... </pre>
<p>The Coefficients a(.) are counted in this order. Reaching M, the particular sum is canceled.</p>
<p>In connection with the VCC, s1...sN are the voltages of the controlling side: s1=pc[1].v - pc[2].v, s2=pc[3].v - pc[4].v, s3=...</p>
<p>The corresponding SPICE description of the VCC polynomial source is the following:</p>
<pre>    Gname A1 A2 POLY(N) E11 E21 ... E1N E2N P0 P1...</pre>
<p>where Gname is the name of the instance, A1 and A2 are the nodes between them the current source is arranged, whose current is calculated,</p>
<p>N is the number of the controlling voltages, E11 E12 ... E1N E2N are pairs of nodes between them the controlling voltages</p>
<p>are gripped, and P0, P1... are the coefficients that are called a0, a1, ... aM in the description of the polynomial f above.</p>
<p>To describe the SPICE line in Modelica, the following explanation would be useful:</p>
<pre>Gname -&gt; G_VCC_POLY name
A1, A2 -&gt; pins name.p2, name.p1
N -&gt; parameter N
E11 -&gt; name.pc[2]
E12 -&gt; name.pc[1]
...
E1N -&gt; name.pc[N]
E2N -&gt; name.pc[N-1]
P0, P1 -&gt; polynomial coefficients name.coeff(coeff={P0,P1,...}) </pre>
</html>", revisions="<html>
<ul>
<li><em>Sept 2008</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"));
    end G_VCC_POLY;

    model H_CCV_POLY
      "Polynomial current controlled voltage source, like SPICE2"

      parameter Integer N(final min=1) = 1 "Number of controlling voltages";
      parameter Real coeff[:] = {1} "Coefficients of polynomial";
      Modelica.Electrical.Analog.Interfaces.PositivePin p
        "Positive pin of the right port (potential p2.v > n2.v for positive voltage drop v2)" annotation (Placement(
            transformation(extent={{110,40},{90,60}}),
            iconTransformation(extent={{110,40},{90,60}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n
        "Negative pin of the right port" annotation (Placement(
            transformation(extent={{90,-60},{110,-40}}),
            iconTransformation(extent={{90,-60},{110,-40}})));

      Modelica.Electrical.Analog.Interfaces.PositivePin pc[2*N]
        "Pin vector of controlling pins"
            annotation (Placement(transformation(
              extent={{-90,-80},{-70,80}}), iconTransformation(extent={
                {-90,-80},{-70,80}})));

      Real control[N];
    equation
      p.i + n.i = 0;
      for i in 1:N loop
        pc[2*i-1].i + pc[2*i].i = 0;
        pc[2*i-1].v - pc[2*i].v = 0;
      end for;
      for i in 1:N loop
        control[i] = pc[2*i-1].i;
      end for;
      p.v - n.v = poly(control, coeff);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-70,70},{70,-70}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Text(
              extent={{-100,-62},{99,-112}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{100,50},{30,50},{30,-50},{100,-50}}, color={0,0,255}),
            Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}),
            Line(points={{-20,50},{20,50}}, color={0,0,255}),
            Polygon(
              points={{20,50},{10,53},{10,47},{20,50}},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Text(
              extent={{-60,-26},{16,-60}},
              lineColor={0,0,255},
              textString="CCV")}),
        Documentation(info="<html>
<p>The polynomial source is a SPICE2 model, which is also known in other SPICE derivatives.</p>
<p>Nonlinear current controlled voltage source. The right port voltage between pin p2 and n2 (=p2.v - n2.v) is controlled by the left port vector of currents at pin pc (=pc.i) via</p>
<pre>    p2.v - n2.v = f(pc[2].i, pc[4].i,...)</pre>
<p>The controlling port (left) current vector is zero.</p>
<p>The corresponding SPICE description</p>
<pre>    Hname A1 A2 POLY(N) V1...VN P0 P1...</pre>
<p>f is a polynomial in N variables s1...sN of the following form with M+1 coefficients a0, a1, a2,...aM.</p>
<pre>f = a0 +
    a1s1 + a2s2 + ... + aNsN +
    a(N+1)s1&sup2; + a(N+2)s1s2 + ... + a(.)s1sN +
    a(.)s2&sup2; + a(.)s2s3 + ... + a(.)s2sN +
    a(.)s3&sup2; + s3s4 + ... + a(.)s4sN +
    ... +
    a(.)sN&sup2; +
    a(.)s1&sup3; + a(.)s1&sup2;s2 + a(.)s1&sup2;s3 + ... + a(.)s1&sup2;sN +
    a(.)s1s2&sup2; + a(.)s1s2s3 + ... + a(.)s1s2sN +
    ... +
    a(.)sN&sup3; + ... </pre>
<p>The Coefficients a(.) are counted in this order. Reaching M, the particular sum is canceled.</p><p>In Modelica the controlling pins have to be connected to the CCV in that way, that the required currents flow through the according pins of the CCV:</p><p>s1 = pc[2].i, s2 = pc[4].i, s3 = pc[6].i,...</p><p>The pairs pc[1].i and pc[2].i, pc[3].i and pc[4].i...form ports with pc[2].i + pc[1].i = 0, pc[4].i + pc[3].i = 0, ...</p><p>The corresponding SPICE description of the CCV polynomial source is the following:</p>
<pre>    Hname A1 A2 POLY(N) V1...VN P0 P1...</pre>
<p>where Hname is the name of the instance, A1 and A2 are the nodes between them the controlled voltage is gripped.</p><p>N is the number of the controlling currents, V1...VN are the voltage sources, that are necessary in SPICE to supply the controlling currents,</p><p>and P0, P1... are the coefficients that are called a0, a1, ... aM in the description of the polynomial f above.</p>
<p>To describe the SPICE line in Modelica, the following explanation would be useful:</p>
<pre>Hname -&gt; H_CCV_POLY name
A1, A2 -&gt; pins name.p2, name.p1
N -&gt; parameter N</pre>
<p>V1 (...VN) is declared in SPICE:</p>
<pre>   V1 V1+ V1- type of voltage source (constant, pulse, sin...)</pre>
<p>In Modelica the currents through V1...VN has to be led through the CCV. Therefore V1...VN have to be disconnected and additional nodes</p>
<pre>   V1_AD...VN_AD</pre>
<p>have to be added. In the case, that the SPICE source is</p>
<pre>   V1 n+ n- 0,</pre>
<p>this source can be eliminated.</p>
<pre>V1_AD -&gt; name.pc[2]
V1- -&gt; name.pc[1]
...
VN_AD -&gt; name.pc[N]
VN- -&gt; name.pc[N-1]
P0, P1 -&gt; polynomial coefficients name.coeff(coeff={P0,P1,...})
</pre>
</html>", revisions="<html>
<ul>
<li><em>Sept 2008</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"));
    end H_CCV_POLY;

    model F_CCC_POLY
      "Polynomial current controlled current source, like SPICE2"

      parameter Integer N(final min=1) = 1 "Number of controlling voltages";
      parameter Real coeff[:] = {1} "Coefficients of polynomial";
      Modelica.Electrical.Analog.Interfaces.PositivePin p
        "Positive pin of the right port (potential p2.v > n2.v for positive voltage drop v2)" annotation (Placement(
            transformation(extent={{110,40},{90,60}}),
            iconTransformation(extent={{110,40},{90,60}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n
        "Negative pin of the right port" annotation (Placement(
            transformation(extent={{90,-60},{110,-40}}),
            iconTransformation(extent={{90,-60},{110,-40}})));

      Modelica.Electrical.Analog.Interfaces.PositivePin pc[2*N]
        "Pin vector of controlling pins"
            annotation (Placement(transformation(
              extent={{-90,-80},{-70,80}}), iconTransformation(extent={
                {-90,-80},{-70,80}})));

      Real control[N];
    equation
      p.i + n.i = 0;
      for i in 1:N loop
        pc[2*i-1].i + pc[2*i].i = 0;
        pc[2*i-1].v - pc[2*i].v = 0;
      end for;
      for i in 1:N loop
        control[i] = pc[2*i-1].i;
      end for;
      p.i = poly(control, coeff);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-70,70},{70,-70}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Text(
              extent={{-100,-62},{99,-112}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{100,50},{30,50},{30,-50},{100,-50}}, color={0,0,255}),
            Ellipse(extent={{10,20},{50,-20}}, lineColor={0,0,255}),
            Line(points={{-20,50},{20,50}}, color={0,0,255}),
            Polygon(
              points={{20,50},{10,53},{10,47},{20,50}},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Text(
              extent={{-60,-24},{16,-58}},
              lineColor={0,0,255},
              textString="CCC")}),
        Documentation(info="<html>
<p>The polynomial source is a SPICE2 model, which is also known in other SPICE derivatives.</p>
<p>Nonlinear current controlled current source. The &quot;right&quot; port current at pin p2 (=p2.i) is controlled by the &quot;left&quot; port vector of currents at pin pc[:] via</p>
<pre>    p2.i = f(pc[2].i, pc[4].i,...)</pre>
<p>The controlling port (left) voltage is zero for each pair: pc[2].v - pc[1].v = 0, ...</p><p>Furthermore the currents of each pair are pc[2].i + pc[1].i = 0, ...</p>
<p>f is a polynomial in N variables s1...sN of the following form with M+1 coefficients a0, a1, a2,...aM.</p>
<pre>f = a0 +
    a1s1 + a2s2 + ... + aNsN +
    a(N+1)s1&sup2; + a(N+2)s1s2 + ... + a(.)s1sN +
    a(.)s2&sup2; + a(.)s2s3 + ... + a(.)s2sN +
    a(.)s3&sup2; + s3s4 + ... + a(.)s4sN +
    ... +
    a(.)sN&sup2; +
    a(.)s1&sup3; + a(.)s1&sup2;s2 + a(.)s1&sup2;s3 + ... + a(.)s1&sup2;sN +
    a(.)s1s2&sup2; + a(.)s1s2s3 + ... + a(.)s1s2sN +
    ... +
    a(.)sN&sup3; + ... </pre>
<p>The Coefficients a(.) are counted in this order. Reaching M, the particular sum is canceled.</p><p>In Modelica the controlling pins have to be connected to the CCC in that way, that the required currents flow through the according pins of the CCC:</p><p>s1=pc[2].i, s2=pc[4].i, s3=pc[6].i,...</p><p>The pairs pc[1].i and pc[2].i, pc[3].i and pc[4].i...form ports with pc[2].i + pc[1].i = 0, pc[4].i + pc[3].i = 0, ...</p><p>The corresponding SPICE description of the CCC polynomial source is the following:</p>
<pre>    Fname A1 A2 POLY(N) V1...VN P0 P1...</pre>
<p>where Fname is the name of the instance, A1 and A2 are the nodes between them the current source is arranged, whose current is calculated.</p><p>N is the number of the controlling currents, V1...VN are the voltage sources, that are necessary in SPICE to supply the controlling currents,</p><p>and P0, P1... are the coefficients that are called a0, a1, ... aM in the description of the polynomial f above.</p>
<p>To describe the SPICE line in Modelica, the following explanation would be useful:</p>
<pre>Fname -&gt; F_CCC_POLY name
A1, A2 -&gt; pins name.p2, name.p1
N -&gt; parameter N</pre>
<p>V1 (...VN) is declared in SPICE:</p>
<pre>   V1 V1+ V1- type of voltage source (constant, pulse, sin...)</pre>
<p>In Modelica the currents through V1...VN has to be led through the CCC. Therefore V1...VN have to be disconnected and additional nodes</p>
<pre>   V1_AD...VN_AD</pre>
<p>have to be added. In the case, that the SPICE source is</p>
<pre>   V1 n+ n- 0,</pre>
<p>this source can be eliminated.</p>
<pre>V1_AD -&gt; name.pc[2]
V1- -&gt; name.pc[1]
...
VN_AD -&gt; name.pc[N]
VN- -&gt; name.pc[N-1]
P0, P1 -&gt; polynomial coefficients name.coeff(coeff={P0,P1,...})
</pre>
</html>", revisions="<html>
<ul>
<li><em>Sept 2008</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"));
    end F_CCC_POLY;
    annotation (Documentation(info="<html>
<p>This package contains additional useful models which do not belong to the original SPICE3 model set.</p>
</html>"));
  end Additionals;

  package Interfaces "Connectors, Interfaces, and partial models"

    extends Modelica.Icons.InterfacesPackage;

    partial model TwoPortControlledSources
      "Component with two electrical ports, including current"
      SI.Voltage v1 "Voltage drop over the controlling port";
      SI.Voltage v2 "Voltage drop over the controlled port";
      SI.Current i1
        "Current flowing from pos. to neg. pin of the controlling port";
      SI.Current i2
        "Current flowing from pos. to neg. pin of the controlled port";
      Modelica.Electrical.Analog.Interfaces.PositivePin p1
        "Positive pin of the controlling port" annotation (Placement(
            transformation(extent={{-110,40},{-90,60}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n1
        "Negative pin of the controlling port" annotation (Placement(
            transformation(extent={{-90,-60},{-110,-40}})));
      Modelica.Electrical.Analog.Interfaces.PositivePin p2
        "Positive pin of the controlled port" annotation (Placement(
            transformation(extent={{110,40},{90,60}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n2
        "Negative pin of the controlled port" annotation (Placement(
            transformation(extent={{90,-60},{110,-40}})));
    equation
      v1 = p1.v - n1.v;
      v2 = p2.v - n2.v;
      0 = p1.i + n1.i;
      0 = p2.i + n2.i;
      i1 = p1.i;
      i2 = p2.i;
      annotation (
        Documentation(info="<html>
<p>TwoPort is a partial model that consists of two ports. It is assumed that the current flowing into the positive pin is identical to the current flowing out of pin n. This currents of each port are provided explicitly as currents i1 and i2, the voltages respectively as v1 and v2.</p>
</html>"));
    end TwoPortControlledSources;

    connector InductiveCouplePinIn
      "Pin to couple inductances via K, which gets the value of inductance"
      input SI.Inductance L;
      SI.CurrentSlope di "di/dt";
      flow SI.Voltage v;
      annotation (Icon(graphics={Polygon(
              points={{0,0},{0,100},{100,0},{0,-100},{0,-100},{0,0}},
              lineColor={170,85,255},
              fillColor={170,85,255},
              fillPattern=FillPattern.Solid)}));
    end InductiveCouplePinIn;

    connector InductiveCouplePinOut
      "Pin to couple inductances via K, which sets the value of inductance"
      output SI.Inductance L;
      SI.CurrentSlope di "di/dt";
      flow SI.Voltage v;
      annotation (Icon(graphics={Polygon(
              points={{-100,0},{0,100},{0,0},{0,-100},{-2,-98},{-100,0}},
              lineColor={170,85,255},
              fillColor={170,85,255},
              fillPattern=FillPattern.Solid)}));
    end InductiveCouplePinOut;

    partial model ConditionalSubstrate
      "Partial model to include a conditional substrate node"

      parameter Boolean useSubstrateNode = false
        "=true, if SubstrateNode is enabled"
      annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      Modelica.Electrical.Analog.Interfaces.PositivePin S(v = substrateVoltage, i = -substrateCurrent) if useSubstrateNode annotation (Placement(
            transformation(extent={{90,0},{110,20}}),    iconTransformation(extent={{90,-10},
                {110,10}})));
      SI.Voltage substrateVoltage;
      SI.Current substrateCurrent;

    equation
      if not useSubstrateNode then
        substrateVoltage = 0;
      end if;
      annotation (Documentation(revisions="<html>
<ul>
<li><em> February 17, 2009   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",     info="<html>
<p>
This partial model provides a conditional heating port for the connection to a thermal network.
</p>
<ul>
<li> If <strong>useHeatPort</strong> is set to <strong>false</strong> (default), no heat port is available, and the thermal
     loss power flows internally to the ground. In this case, the parameter <strong>T</strong> specifies
     the fixed device temperature (the default for T = 20<sup>o</sup>C).</li>
<li> If <strong>useHeatPort</strong> is set to <strong>true</strong>, a heat port is available.</li>
</ul>

<p>
If this model is used, the loss power has to be provided by an equation in the model which inherits from
ConditionalHeatingPort model (<strong>lossPower = ...</strong>). As device temperature
<strong>T_heatPort</strong> can be used to describe the influence of the device temperature
on the model behaviour.
</p>
</html>"));
    end ConditionalSubstrate;
    annotation(preferredView="info",
        Documentation(info="<html>
<p>The SPICE3 package uses the Modelica.Electrical.Analog interfaces. Only special partial models used in the SPICE3 package are located in this Interfaces package.</p>
</html>"));
  end Interfaces;

  package Types "Additional Spice3 type definitions"
    extends Modelica.Icons.TypesPackage;
    type VoltageSquare = Real (final quantity="ElectricalPotential2", final unit="V2");
    type GapEnergyPerTemperature = Real (final quantity="Energy per Temperature", final unit="eV/K");
    type GapEnergyPerEnergy = Real (final quantity="Energy per Energy", final unit="eV/J");
    type PerVolume = Real (final quantity="PerVolume", final unit="1/m3");
    type InverseElectricCurrent = Real (final quantity="InverseElectricCurrent", final unit="1/A")
      "Inverse of electric current";
    type ElectricFieldStrength_cm = Real (final quantity="ElectricFieldStrength",
          final unit="V/cm");
    annotation (Documentation(info="<html>
<p>This package Types contains units that are needed in the models of the Spice3 package.</p>
</html>"));
  end Types;

  package Internal
    "Collection of functions and records derived from the C++ Spice library"
    extends Modelica.Icons.InternalPackage;

  model MOS "Metal-Oxide Semiconductor Field-Effect Transistor"

    Modelica.Electrical.Analog.Interfaces.PositivePin G "gate node" annotation (Placement(transformation(
              extent={{-110,-12},{-90,10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin D "drain node" annotation (Placement(transformation(
              extent={{-10,90},{10,110}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin S "source node" annotation (Placement(
            transformation(extent={{-10,-110},{10,-90}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin B "bulk node" annotation (Placement(transformation(
              extent={{90,-10},{110,10}})));

    parameter Integer mtype(start = 0)
        "MOSFET type: 0 - N channel, 1 - P channel";
    parameter SI.Length L =  1e-4 "Length";
    parameter SI.Length W =  1e-4 "Width";
    parameter SI.Area AD = 0 "Area of the drain diffusion";
    parameter SI.Area AS = 0 "Area of the source diffusion";
    parameter SI.Length PD =  0 "Perimeter of the drain junction";
    parameter SI.Length PS =  0 "Perimeter of the source junction";
    parameter Real NRD = 1 "Number of squares of the drain diffusions";
    parameter Real NRS = 1 "Number of squares of the source diffusions";
    parameter Integer OFF = 0
        "Optional initial condition: 0 - IC not used, 1 - IC used, not implemented yet";
    parameter SI.Voltage IC( start = -1e40)
        "Initial condition values, not implemented yet";
    parameter SI.Temp_C TEMP = 27 "Operating temperature of the device";

    parameter ModelcardMOS modelcard "MOSFET modelcard" annotation(Evaluate=true);
    constant SpiceConstants C "General constants of SPICE simulator";
    final parameter Mos1.Mos1ModelLineParams p = Mos1.mos1RenameParameters(modelcard, C)
        "Model line parameters" annotation(Evaluate=true);
    final parameter Mosfet.Mosfet m = Mos1.mos1RenameParametersDev(
      modelcard,
      mtype,
      W,
      L,
      AS,
      AS,
      PD,
      PS,
      NRD,
      NRS,
      OFF,
      IC,
      TEMP) "Renamed parameters" annotation(Evaluate=true);
    final parameter Integer m_type = if (m.m_bPMOS > 0.5) then -1 else 1
        "Type of the transistor";
    final parameter Mos.MosModelLineVariables vp = Mos1.mos1ModelLineParamsInitEquations(
          p,
          C,
          m_type) "Model line variables";
    final parameter Mos1.Mos1Calc c1 = Mos.mosCalcInitEquations(
          p,
          C,
          vp,
          m) "Precalculated parameters";
    final parameter Mos1.Mos1Calc c2 = Mos.mosCalcCalcTempDependencies(
          p,
          C,
          vp,
          m,
          c1,
          m_type) "Precalculated parameters";

    Mos.CurrrentsCapacitances cc;

    constant Boolean m_bInit = false;

    SI.Voltage Dinternal;  //internal drain node
    SI.Voltage Sinternal;  //internal source node
    SI.Current ird;
    SI.Current irs;
    SI.Current ibdgmin;
    SI.Current ibsgmin;

    SI.Current icBD;
    SI.Current icBS;
    SI.Current icGB;
    SI.Current icGS;
    SI.Current icGD;
    SI.Voltage vDS "Drain - source voltage";
    SI.Voltage vGS "Gate - source voltage";

  equation
    assert( NRD > 0, "NRD, length of drain in squares, must be greater than zero");
    assert( NRS > 0, "NRS, length of source in squares, must be greater than zero");

    vDS = D.v - S.v;
    vGS = G.v - S.v;

    cc = Mos.mosCalcNoBypassCode(
      m,
      m_type,
      c2,
      p,
      C,
      vp,
      m_bInit,
      {G.v, B.v, Dinternal, Sinternal});

    // drain- and sourceresistances
    // ----------------------------
    ird * c1.m_drainResistance = (D.v - Dinternal);
    irs * p.m_sourceResistance = (S.v - Sinternal);

    // capacitances
    // ------------

     icBD = cc.cBD * (der(B.v) - der(Dinternal));
     icBS = cc.cBS * (der(B.v) - der(Sinternal));
     icGB = cc.cGB * (der(G.v) - der(B.v));
     icGD = cc.cGD * (der(G.v) - der(Dinternal));
     icGS = cc.cGS * (der(G.v) - der(Sinternal));

    // currents
    // --------
     ibsgmin = SpiceConstants.CKTgmin * (B.v - Sinternal);
     ibdgmin = SpiceConstants.CKTgmin * (B.v - Dinternal);
    G.i = icGB + icGD + icGS;
    B.i = cc.iBD + cc.iBS + ibdgmin + ibsgmin - icGB + icBD + icBS;
    D.i = ird;
    S.i = irs;

  //currentsum at inner node
  //------------------------
    0    = -ird + cc.idrain - cc.iBD - ibdgmin - icGD - icBD;
    0    = -irs - cc.idrain - cc.iBS - ibsgmin - icGS - icBS;

    annotation (Documentation(info="<html>
<p>MOSFET model, both N and P channel, LEVEL 1: Shichman-Hodges</p>
<p>The package Repository is not for user access. There all function, records and data are stored, that are needed for the semiconductor models of the package Semiconductors.</p>
</html>", revisions="<html>
<ul>
<li><em>March 2008</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{0,92},{0,40},{-12,40},{-12,-40},{0,-40},{0,-94}},
                color={0,0,255}),
            Line(points={{-92,0},{-20,0}}, color={0,0,255}),
            Line(points={{-12,0},{94,0}}, color={0,0,255}),
            Line(points={{-20,40},{-20,-40}}, color={0,0,255}),
            Text(
              extent={{8,-34},{92,-86}},
              lineColor={0,0,255},
              textString="%name")}));
  end MOS;

     record ModelcardMOS "Record with technology parameters (.model)"
     extends Modelica.Icons.Record;
       parameter SI.Voltage VTO=-1e40 "Zero-bias threshold voltage, default 0";
       parameter SI.Transconductance KP=-1e40
        "Transconductance parameter, default 2e-5";
       parameter Real GAMMA=-1e40 "Bulk threshold parameter, default 0";
       parameter SI.Voltage PHI=-1e40 "Surface potential, default 0.6";  //Substrate Sperrschicht Potential
       parameter SI.InversePotential LAMBDA=0
        "Channel-length modulation, default 0";
       parameter SI.Resistance RD=-1e40 "Drain ohmic resistance, default 0";
       parameter SI.Resistance RS=-1e40 "Source ohmic resistance, default 0";
       parameter SI.Capacitance CBD=-1e40
        "Zero-bias B-D junction capacitance, default 0";
       parameter SI.Capacitance CBS=-1e40
        "Zero-bias B-S junction capacitance, default 0";
       parameter SI.Current IS=1e-14 "Bulk junction saturation current";
       parameter SI.Voltage PB=0.8 "Bulk junction potential";
       parameter SI.Permittivity CGSO=0.0
        "Gate-source overlap capacitance per meter channel width";
       parameter SI.Permittivity CGDO=0.0
        "Gate-drain overlap capacitance per meter channel width";
       parameter SI.Permittivity CGBO=0.0
        "Gate-bulk overlap capacitance per meter channel width";
       parameter SI.Resistance RSH=0.0
        "Drain and source diffusion sheet resistance";
       parameter SI.CapacitancePerArea CJ=0.0
        "Zero-bias bulk junction bottom cap. per sq-meter of junction area";
       parameter Real MJ=0.5 "Bulk junction bottom grading coefficient";
       parameter SI.Permittivity CJSW=0.0
        "Zero-bias junction sidewall cap. per meter of junction perimeter";
       parameter Real MJSW=0.5 "Bulk junction sidewall grading coefficient";
       parameter SI.CurrentDensity JS=0.0
        "Bulk junction saturation current per sq-meter of junction area";
       parameter SI.Length TOX=-1e40 "Oxide thickness, default 1e-7";
       parameter Real NSUB=-1e40 "Substrate doping, default 0";
       parameter SI.Conversions.NonSIunits.PerArea_cm NSS=0.0
        "Surface state density";
       parameter Real TPG=1.0
        "Type of gate material: +1 opp. to substrate, -1 same as substrate, 0 Al gate";
       parameter SI.Length LD=0.0 "Lateral diffusion";
       parameter SI.Conversions.NonSIunits.Area_cmPerVoltageSecond UO=600
        "Surface mobility";
       parameter Real KF=0 "Flicker noise coefficient";
       parameter Real AF=1.0 "Flicker noise exponent";
       parameter Real FC=0.5
        "Coefficient for forward-bias depletion capacitance formula";
       parameter SI.Temp_C TNOM=27
        "Parameter measurement temperature, default 27";
       constant Integer LEVEL=1 "Model level: Shichman-Hodges";
      annotation (Documentation(info="<html>
<p>Modelcard parameters for MOSFET model, both N and P channel, LEVEL 1: Shichman-Hodges</p>
<p>The package Repository is not for user access. There all function, records and data are stored, that are needed for the semiconductor models of the package Semiconductors.</p>
</html>"));
     end ModelcardMOS;

  model MOS2 "Metal-Oxide Semiconductor Field-Effect Transistor"

    Modelica.Electrical.Analog.Interfaces.PositivePin G "gate node"
                                          annotation (Placement(transformation(
              extent={{-110,-12},{-90,10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin D "drain node"
                                           annotation (Placement(transformation(
              extent={{-10,90},{10,110}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin S "source node"
                                            annotation (Placement(
            transformation(extent={{-10,-110},{10,-90}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin B "bulk node"
                                          annotation (Placement(transformation(
              extent={{90,-10},{110,10}})));

    parameter Integer mtype(start = 0)
        "MOSFET type: 0 - N channel, 1 - P channel";
    parameter SI.Length L = 1e-4 "Length";
    parameter SI.Length W = 1e-4 "Width";
    parameter SI.Area AD = 0 "Area of the drain diffusion";
    parameter SI.Area AS = 0 "Area of the source diffusion";
    parameter SI.Length PD = 0 "Perimeter of the drain junction";
    parameter SI.Length PS = 0 "Perimeter of the source junction";
    parameter Real NRD = 1 "Number of squares of the drain diffusions";
    parameter Real NRS = 1 "Number of squares of the source diffusions";
  //--------------------------------------------------------------------------------------
  //need to be Boolean instead of integer, will be changed with the next Modelica version
  //via converting script
    parameter Integer OFF = 0
        "Optional initial condition: 0 - IC not used, 1 - IC used, not implemented yet";
  //--------------------------------------------------------------------------------------
    parameter SI.Voltage IC_VDS = -1e40
        "Initial condition value (VDS, not implemented yet)";
    parameter SI.Voltage IC_VGS = -1e40
        "Initial condition value (VGS, not implemented yet)";
    parameter SI.Voltage IC_VBS = -1e40
        "Initial condition value (VBS, not implemented yet)";
    parameter Boolean UIC = false
        "Use initial conditions: true, if initial condition is used";
    parameter SI.Temp_C TEMP = 27 "Operating temperature of the device";

    parameter Spice3.Internal.ModelcardMOS2
                            modelcard "MOSFET modelcard"
                annotation(Evaluate=true);

   final parameter Spice3.Internal.Mos2.Mos2ModelLineParams p=
          Spice3.Internal.Mos2.mos2RenameParametersRevised(
          modelcard) "Model line parameters"
                      annotation(Evaluate=true);

    final parameter Spice3.Internal.Mosfet.Mosfet m=
          Spice3.Internal.Mosfet.mosfetRenameParametersDev(
            W,
            L,
            AD,
            AS,
            PD,
            PS,
            NRD,
            NRS,
            OFF,
            IC_VDS,
            IC_VGS,
            IC_VBS,
            UIC,
            TEMP) "Renamed parameters"
                                  annotation(Evaluate=true);
    final parameter Spice3.Internal.Mosfet.Mosfet m1=
          Spice3.Internal.Mosfet.mosfetInitEquations(m);

    final parameter Integer m_type = if (m.m_bPMOS > 0.5) then -1 else 1
        "Type of the transistor";

    final parameter Spice3.Internal.Mos2.Mos2ModelLineParams
        p1=
          Spice3.Internal.Mos2.mos2ModelLineParamsInitEquationsRevised(
           p, m_type) "Model line variables";
    final parameter Spice3.Internal.Mos2.Mos2Calc c11=
          Spice3.Internal.Mos.mos2CalcInitEquationsRevised(
          p1, m1) "Precalculated parameters";
    final parameter Spice3.Internal.Mos2.Mos2Calc c22=
          Spice3.Internal.Mos.mos2CalcCalcTempDependenciesRevised(
            p1,
            m1,
            c11,
            m_type) "Precalculated parameters";

    Spice3.Internal.Mos.CurrrentsCapacitances cc;

    constant Boolean m_bInit = false;

    SI.Voltage Dinternal;
    SI.Voltage Sinternal;
    SI.Voltage vBD;
    SI.Voltage vBS;
    SI.Voltage vGB;
    SI.Voltage vGD;
    SI.Voltage vGS;
    SI.Current ird;
    SI.Current irs;
    SI.Current ibdgmin;
    SI.Current ibsgmin;

    SI.Current icBD;
    SI.Current icBS;
    SI.Current icGB;
    SI.Current icGS;
    SI.Current icGD;

  //-------------------------------obsolete-----------------------------------------------------------------------------------------------
    parameter SI.Voltage IC( start = -1e40)
        "Initial condition values, not implemented yet";

    Real icqmGB;
    Real icqmGS;
    Real icqmGD;
    SI.Voltage vDS "Drain - source voltage";

    Spice3.Internal.Mos.DEVqmeyer qm;
    Spice3.Internal.Mos.CurrrentsCapacitances cc_obsolete;

  //-------------------------------------------------------------------------------------------------------------------------------------

    final parameter Spice3.Internal.Mos2.Mos2ModelLineVariables
                                                 vp=
           Spice3.Internal.Mos2.mos2ModelLineParamsInitEquations(
             p,
             C,
             m_type) "Model line variables";
    final parameter Spice3.Internal.Mos2.Mos2Calc
                                   c1=Spice3.Internal.Mos.mos2CalcInitEquations(
             p,
             C,
             vp,
             m) "Precalculated parameters";
    final parameter Spice3.Internal.Mos2.Mos2Calc
                                   c2=Spice3.Internal.Mos.mos2CalcCalcTempDependencies(
             p,
             C,
             vp,
             m,
             c1,
             m_type) "Precalculated parameters";

    final parameter Spice3.Internal.Mos2.Mos2ModelLineParams
                                             p_obsolete=Spice3.Internal.Mos2.mos2RenameParameters(
          modelcard, C) "Model line parameters"
                      annotation(Evaluate=true);

     constant Spice3.Internal.SpiceConstants C
        "General constants of SPICE simulator";
     Real MOScapgd = qm.qm_capgd;
    Real MOScapgs = qm.qm_capgs;
    Real MOScapgb = qm.qm_capgb;
  equation
    assert( NRD > 0, "NRD, length of drain in squares, must be greater than zero");
    assert( NRS > 0, "NRS, length of source in squares, must be greater than zero");

      cc = Spice3.Internal.Mos.mos2CalcNoBypassCodeRevised(
          m1,
          m_type,
          c22,
          p1,
          m_bInit,
          {G.v,B.v,Dinternal,Sinternal});
    // voltages
    // --------
    vBD = B.v - Dinternal;
    vBS = B.v - Sinternal;
    vGB = G.v - B.v;
    vGD = G.v - Dinternal;
    vGS = G.v - Sinternal;

    // drain- and sourceresistances
    // ----------------------------
    ird * c11.m_drainResistance  = (D.v - Dinternal);
    irs * c11.m_sourceResistance =  (S.v - Sinternal);

    // capacitances
    // ------------

    icBD = cc.cBD * der(vBD);
    icBS = cc.cBS * der(vBS);
    icGB = cc.cGB * der(vGB);
    icGD = cc.cGD * der(vGD);
    icGS = cc.cGS * der(vGS);

    // currents
    // --------
      ibsgmin = Spice3.Internal.SpiceConstants.CKTgmin*(B.v -
        Sinternal);
      ibdgmin = Spice3.Internal.SpiceConstants.CKTgmin*(B.v -
        Dinternal);
    G.i =  icGB + icGD + icGS;
    B.i = cc.iBD + cc.iBS+ ibdgmin + ibsgmin -icGB + icBD + icBS;
    D.i = ird;
    S.i = irs;

  //currentsum at inner node
  //------------------------
    0    = -ird + cc.idrain - cc.iBD - ibdgmin - icGD - icBD;
    0    = -irs - cc.idrain - cc.iBS - ibsgmin - icGS - icBS;

  //----------------------obsolete--------------------------------------------------
    vDS = D.v - S.v;
      (cc_obsolete,qm) =
        Spice3.Internal.Mos.mos2CalcNoBypassCode(
          m,
          m_type,
          c2,
          p,
          C,
          vp,
          m_bInit,
          {G.v,B.v,Dinternal,Sinternal});

    icqmGB = 0;
    icqmGS = 0;
    icqmGD = 0;

    annotation (Documentation(info="<html>
<p>MOSFET model, both N and P channel, LEVEL 2</p>
<p>The package Repository is not for user access. There all function, records and data are stored, that are needed for the semiconductor models of the package Semiconductors.</p>
</html>", revisions="<html>
<ul>
<li><em>January 2009</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{0,92},{0,40},{-12,40},{-12,-40},{0,-40},{0,-94}},
                color={0,0,255}),
            Line(points={{-92,0},{-20,0}}, color={0,0,255}),
            Line(points={{-12,0},{94,0}}, color={0,0,255}),
            Line(points={{-20,40},{-20,-40}}, color={0,0,255}),
            Text(
              extent={{8,-34},{92,-86}},
              lineColor={0,0,255},
              textString="%name")}));
  end MOS2;

     record ModelcardMOS2 "Record with technology parameters (.model)"
       extends Modelica.Icons.Record;
     extends Spice3.Internal.ModelcardMOS(MJSW=0.33);

       parameter SI.Conversions.NonSIunits.PerArea_cm NFS=0.0
        "Fast surface state density";
       parameter SI.Length XJ=0.0 "Metallurgical junction depth";
       parameter Types.ElectricFieldStrength_cm UCRIT=1e4
        "Critical field for mobility degradation (MOS2 only)";
       parameter Real UEXP=0.0
        "Critical field exponent in mobility degradation (MOS2 only)";
       parameter SI.Velocity VMAX=0.0 "Maximum drift velocity of carries";
       parameter Real NEFF=1.0
        "Total channel charge (fixed and mobile) coefficient (MOS2 only)";
       parameter Real DELTA=0.0 "Width effect on threshold voltage";

      annotation (Documentation(info="<html>
<p>Modelcard parameters for MOSFET model, both N and P channel, LEVEL 2</p>
<p>The package Repository is not for user access. There all function, records and data are stored, that are needed for the semiconductor models of the package Semiconductors.</p>
</html>"));
     end ModelcardMOS2;

    model BJT2 "Bipolar junction transistor"

      Modelica.Electrical.Analog.Interfaces.PositivePin B "Base node"
        annotation (Placement(transformation(extent={{-108,-10},{-88,10}}),
            iconTransformation(extent={{-106,-10},{-86,10}})));
      Modelica.Electrical.Analog.Interfaces.PositivePin C "Collector node"
        annotation (Placement(transformation(extent={{10,88},{30,108}}),
            iconTransformation(extent={{20,90},{40,110}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin E "Emitter node"
        annotation (Placement(transformation(extent={{10,-108},{30,-88}}),
            iconTransformation(extent={{20,-110},{40,-90}})));
      extends Spice3.Interfaces.ConditionalSubstrate;
      parameter Real TBJT( start = 1) "Type of transistor (NPN=1, PNP=-1)";
      parameter Real AREA = 1.0 "Area factor";
      parameter Boolean OFF = false
        "Optional initial condition: false - IC not used, true - IC used, not implemented yet";
      parameter SI.Voltage IC_VBE = -1e40
        "Initial condition value (VBC, not implemented yet)";
      parameter SI.Voltage IC_VCE = -1e40
        "Initial condition value (VBE, not implemented yet)";
      parameter Boolean UIC = false
        "Use initial conditions: true, if initial condition is used";
      parameter SI.Temp_C TEMP = 27 "Operating temperature of the device";
      parameter Boolean SENS_AREA = false
        "Flag to request sensitivity WRT area, not implemented yet";

      parameter Modelica.Electrical.Spice3.Internal.ModelcardBJT2
                             modelcard "BJT modelcard" annotation(Evaluate=true);

      final parameter Spice3.Internal.Bjt.BjtModelLineParams p=
          Spice3.Internal.Bjt.bjtRenameParameters(modelcard,
          TBJT) "Model line parameters" annotation(Evaluate=true);
      final parameter Spice3.Internal.Bjt.Bjt dev=
          Spice3.Internal.Bjt.bjtRenameParametersDev(
            AREA,
            OFF,
            IC_VBE,
            IC_VCE,
            UIC,
            SENS_AREA,
            TEMP) "Renamed parameters" annotation(Evaluate=true);
      final parameter Spice3.Internal.Bjt.BjtModelLineParams p1=
          Spice3.Internal.Bjt.bjtModelLineInitEquations(p)
        "Model line variables";
      final parameter Spice3.Internal.Bjt.Bjt dev1=
          Spice3.Internal.Bjt.bjtInitEquations(dev, p1)
        "Precalculated parameters";
      final parameter Spice3.Internal.Bjt.BjtCalc c=
          Spice3.Internal.Bjt.bjtCalcTempDependencies(dev1, p1)
        "Precalculated parameters";

      constant Boolean m_bInit = false;
      Spice3.Internal.Bjt.CurrentsCapacitances cc;
      SI.Voltage Cinternal;    // inner collector node
      SI.Voltage Binternal;    // inner base node
      SI.Voltage Einternal;    // inner emitter node
      SI.Voltage vbe;
      SI.Voltage vbc;
      SI.Voltage vbx;
      SI.Voltage vcs;
      SI.Current irc;
      SI.Current ire;
      SI.Current irb;
      SI.Current ibcgmin;
      SI.Current ibegmin;
      SI.Current icapbe;
      SI.Current icapbc;
      SI.Current icapbx;
      SI.Current icapcs;
      SI.Current icaptt;

    equation
      cc = Spice3.Internal.Bjt.bjtNoBypassCode(
          dev1,
          p1,
          c,
          {C.v,B.v,E.v,Cinternal,Binternal,Einternal});

      // voltages
      vbe = Binternal - Einternal;
      vbc = Binternal - Cinternal;
      vbx = B.v - Cinternal;
      vcs = Cinternal - substrateVoltage;

      // currents through capacitances
      icapbe = if (m_bInit) then 0.0 else cc.capbe*der(vbe);
      icapbc = if (m_bInit) then 0.0 else cc.capbc*der(vbc);
      icaptt = if (m_bInit) then 0.0 else cc.captt*der(vbc);
      icapbx = if (m_bInit) then 0.0 else cc.capbx*der(vbx);
      icapcs = if (m_bInit) then 0.0 else cc.capcs*der(vcs);

      // resistances
      irc * p1.m_collectorResist = (C.v - Cinternal);
      ire * p1.m_emitterResist = (E.v -Einternal);
    //  irb * cc.rx = (B.v - Binternal);  // exact resistance
      irb * p.m_baseResist = (B.v - Binternal); // faulty resistance

      // currents
      ibcgmin = Spice3.Internal.SpiceConstants.CKTgmin*(
        Binternal - Cinternal);
      ibegmin = Spice3.Internal.SpiceConstants.CKTgmin*(
        Binternal - Einternal);
      C.i = irc;
      E.i = ire;
      B.i = irb + icapbx;
      //current sum at inner nodes
      0 =  ibcgmin + irc -cc.iCC + cc.iBCN + cc.iBC + icapbc + icapbx - icapcs + icaptt; //current sum for inner node Cinternal
      0 =  ibegmin + ire + cc.iCC + cc.iBEN + cc.iBE + icapbe;          //current sum for inner node Einternal
      0 = - ibcgmin - ibegmin + irb - cc.iBC - cc.iBE - cc.iBCN - cc.iBEN -icapbc - icapbe - icaptt; //current sum for inner node Binternal
      substrateCurrent = icapcs;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Line(
              points={{-20,60},{-20,-60}},
              color={0,0,255}),
            Line(
              points={{-20,0},{-86,0}},
              color={0,0,255}),
            Line(
              points={{34,94},{-20,40}},
              color={0,0,255}),
            Line(
              points={{-20,-40},{32,-92}},
              color={0,0,255}),
            Text(
              extent={{-94,56},{206,16}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>
<p>Bipolar junction transistor model, both NPN and PNP</p>
<p>The package Internal is not for user access. There all function, records and data are stored, that are needed for the semiconductor models of the package Semiconductors.</p>
</html>",     revisions="<html>
<ul>
<li><em>August 2009</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"));
    end BJT2;

    record ModelcardBJT2 "Record with technology parameters (.model)"
      extends Modelica.Icons.Record;
      parameter SI.Temp_C TNOM = 27 "Parameter measurement temperature";
      parameter SI.Current IS = 1e-16 "Transport saturation current";
      parameter Real BF = 100.00 "Ideal maximum forward beta F";
      parameter Real NF = 1.0 "Forward current emission coefficientF";
      parameter Real NE = 1.5 "B-E leakage emission coefficient";
      parameter SI.Current ISE = -1e40
        "B-E leakage saturation current, default = 0";
      constant Real C2 = -1e40 "Obsolete parameter name, default = 0";
      parameter SI.Current ISC = -1e40
        "B-C leakage saturation current, default = 0";
      constant Real C4 = -1e40 "Obsolete parameter name, default = 0";
      parameter Real BR = 1.0 "Ideal maximum reverse beta";
      parameter Real NR = 1.0 "Reverse current emission coefficient";
      parameter Real NC = 2.0 "B-C leakage emission coefficient";
      parameter SI.Voltage VAF=0.0 "Forward Early voltage";
      parameter SI.Current IKF=0.0 "Forward beta roll-off corner current";
      parameter SI.Voltage VAR=0.0 "Reverse Early voltage";
      parameter SI.Current IKR=0.0 "Reverse beta roll-off corner current";
      parameter SI.Resistance RE=0.0 "Emitter resistance";
      parameter SI.Resistance RC=0.0 "Collector resistance";
      parameter SI.Current IRB=0.0 "Current for base resistance = (rb+rbm)/2";
      parameter SI.Resistance RB=0.0 "Zero bias base resistance";
      parameter SI.Resistance RBM=0.0 "Minimum base resistance, default = 0.0";
      parameter SI.Capacitance CJE=0.0 "Zero bias B-E depletion capacitance";
      parameter SI.Voltage VJE=0.75 "B-E built in potential";
      parameter Real MJE = 0.33 "B-E junction exponential factor";
      parameter SI.Time TF=0.0 "Ideal forward transit time";
      parameter Real XTF = 0.0 "Coefficient for bias dependence of TF";
      parameter SI.Current ITF=0.0 "High current dependence of TF,";
      parameter SI.Voltage VTF=0.0 "Voltage giving VBC dependence of TF";
      parameter SI.Frequency PTF=0.0 "Excess phase at freq=1/(TF*2*Pi) Hz";
      parameter SI.Capacitance CJC=0.0 "Zero bias B-C depletion capacitance";
      parameter SI.Voltage VJC=0.75 "B-C built in potential";
      parameter Real MJC = 0.33 "B-C junction grading coefficient";
      parameter Real XCJC = 1.0 "Fraction of B-C cap to internal base";
      parameter SI.Time TR=0.0 "Ideal reverse transit time";
      parameter SI.Capacitance CJS=0.0 "Zero bias C-S capacitance";
      parameter SI.Voltage VJS=0.75 "Substrate junction built-in potential";
      parameter Real MJS = 0.0 "Substrate junction grading coefficient";
      parameter Real XTB = 0.0 "Forward and reverse beta temperature exponent";
      parameter SI.GapEnergy EG=1.11
        "Energy gap for IS temperature effect on IS";
      parameter Real XTI = 3.0 "Temperature exponent for IS";
      parameter Real KF = 0.0 "Flicker Noise Coefficient";
      parameter Real AF = 1.0 "Flicker Noise Exponent";
      parameter Real FC = 0.5 "Forward bias junction fit parameter";

      annotation (Documentation(info="<html>
<p>Modelcard parameters for BJT model, both PNP and NPN</p>
<p>The package Internal is not for user access. There all function, records and data are stored, that are needed for the semiconductor models of the package Semiconductors.</p>
</html>"));
    end ModelcardBJT2;

    model BJT "Bipolar junction transistor, obsolete, use model BJT2"
      extends Modelica.Icons.ObsoleteModel;
      Modelica.Electrical.Analog.Interfaces.PositivePin B "Base node"
        annotation (Placement(transformation(extent={{-108,-10},{-88,10}}),
            iconTransformation(extent={{-106,-10},{-86,10}})));
      Modelica.Electrical.Analog.Interfaces.PositivePin C "Collector node"
        annotation (Placement(transformation(extent={{10,88},{30,108}}),
            iconTransformation(extent={{20,90},{40,110}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin E "Emitter node"
        annotation (Placement(transformation(extent={{10,-108},{30,-88}}),
            iconTransformation(extent={{20,-110},{40,-90}})));

      parameter Real TBJT( start = 1) "Type of transistor (NPN=1, PNP=-1)";
      parameter Real AREA = 1.0 "Area factor";
      parameter Boolean OFF = false
        "Optional initial condition: false - IC not used, true - IC used, not implemented yet";
      parameter SI.Voltage IC_VCE( start = -1e40)
        "Initial condition value (VBE, not implemented yet";
      parameter SI.Voltage IC_VBE( start = -1e40)
        "Initial condition value (VBC, not implemented yet";
      parameter SI.Temp_C TEMP = 27 "Operating temperature of the device";
      parameter Boolean SENS_AREA = false
        "Flag to request sensitivity WRT area, not implemented yet";

      parameter Modelica.Electrical.Spice3.Internal.ModelcardBJT
                             modelcard "BJT modelcard" annotation(Evaluate=true);

      final parameter Spice3.Internal.Bjt3.BjtModelLineParams
                                              p=Spice3.Internal.Bjt3.bjtRenameParameters(
                                                                         modelcard,
          Con,TBJT) "Model line parameters" annotation(Evaluate=true);
      constant Spice3.Internal.SpiceConstants Con
        "General constants of SPICE simulator";
      final parameter Spice3.Internal.Bjt3.Bjt
                               p1=Spice3.Internal.Bjt3.bjtRenameParametersDev(
              AREA,
              OFF,
              IC_VBE,
              IC_VCE,
              SENS_AREA) "Renamed parameters"
                   annotation(Evaluate=true);
      final parameter Spice3.Internal.Model.Model m=
          Spice3.Internal.Bjt3.bjtRenameParametersDevTemp(TEMP)
        "Renamed parameters" annotation(Evaluate=true);
      final parameter Spice3.Internal.Bjt3.BjtModelLineVariables vl=
          Spice3.Internal.Bjt3.bjtModelLineInitEquations(p)
        "Model line variables";
      final parameter Spice3.Internal.Bjt3.Bjt3Calc
                                    c=Spice3.Internal.Bjt3.bjt3CalcTempDependencies(
              p1,
              p,
              m,
              vl) "Precalculated parameters";
      final parameter Spice3.Internal.Bjt3.BjtVariables
                                        v=Spice3.Internal.Bjt3.bjtInitEquations(
              p1,
              p,
              vl) "Precalculated parameters";

      constant Boolean m_bInit = false;
      Spice3.Internal.Bjt3.CurrentsCapacitances cc;
      Real Cinternal;    //inner collector node
      Real Binternal;    //inner base node
      Real Einternal;    //inner emitter node
      Real irc;
      Real ire;
      Real irb;
      Real ibcgmin;
      Real ibegmin;
      Real capbe;
      Real icapbe;
      Real capbc;
      Real icapbc;
      Real capbx;
      Real icapbx;
      SI.Voltage vBE "Base - emitter voltage";
      SI.Voltage vCE "Collector - emitter voltage";
      SI.Voltage vBC "Base - collector voltage";

    equation
      vBE = B.v - E.v;
      vCE = C.v - E.v;
      vBC = B.v - C.v;

       (cc,capbe,capbc,capbx) = Spice3.Internal.Bjt3.bjtNoBypassCode(
             m,
             p1,
             p,
             c,
             v,
             vl,
             {C.v,B.v,E.v,Cinternal,Binternal,Einternal},
             m_bInit);

          //currents through capacitances
         icapbe = if (m_bInit) then 0.0 else capbe*(der(Binternal) - der(Einternal));
         icapbc = if (m_bInit) then 0.0 else capbc*(der(Binternal) - der(Cinternal));
         icapbx = if (m_bInit) then 0.0 else capbx*(der(B.v) - der(Cinternal));
         //Resistances
         irc * p.m_collectorResist = (C.v - Cinternal);
         ire * p.m_emitterResist = (E.v -Einternal);
         irb * p.m_baseResist = (B.v - Binternal);

        //currents
      ibcgmin = Spice3.Internal.SpiceConstants.CKTgmin*(
        Binternal - Cinternal);
      ibegmin = Spice3.Internal.SpiceConstants.CKTgmin*(
        Binternal - Einternal);
        C.i = irc;
        E.i = ire;
        B.i = irb + icapbx;
        //current sum at inner nodes
        0 =  ibcgmin + irc -cc.iCC + cc.iBCN + cc.iBC + icapbc + icapbx;  //current sum for inner node Cinternal
        0 =  ibegmin + ire + cc.iCC + cc.iBEN + cc.iBE + icapbe;          //current sum for inner node Einternal
        0 = - ibcgmin - ibegmin + irb - cc.iBC - cc.iBE - cc.iBCN - cc.iBEN -icapbc - icapbe; //current sum for inner node Binternal

      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Line(
              points={{-20,60},{-20,-60}},
              color={0,0,255}),
            Line(
              points={{-20,0},{-86,0}},
              color={0,0,255}),
            Line(
              points={{34,94},{-20,40}},
              color={0,0,255}),
            Line(
              points={{-20,-40},{32,-92}},
              color={0,0,255}),
            Text(
              extent={{-94,56},{206,16}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>This model is obsolete, please use BJT2</p>
<p>Bipolar junction transistor model</p>
<p>The package Internal is not for user access. There all function, records and data are stored, that are needed for the semiconductor models of the package Semiconductors.</p>
</html>",     revisions="<html>
<ul>
<li><em>August 2009</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"),
      obsolete = "Obsolete model - use Modelica.Electrical.Spice3.Internal.BJT2 instead");
    end BJT;

    record ModelcardBJT
      "Record with technology parameters (.model), obsolete model, please use ModelcardBJT2"
      extends Modelica.Icons.Record;
      extends Modelica.Icons.ObsoleteModel;
      parameter SI.Temp_C TNOM = -1e40
        "Parameter measurement temperature, default 27";
      parameter SI.Current IS = 1e-16 "Transport saturation current";
      parameter Real BF = 100.00 "Ideal maximum forward beta F";
      parameter Real NF = 1.0 "Forward current emission coefficientF";
      parameter Real NE = 1.5 "B-E leakage emission coefficient";
      parameter SI.Current ISE = -1e40
        "B-E leakage saturation current, default = 0";
      constant Real C2 =  -1e40 "Obsolete parameter name, default = 0";
      parameter SI.Current ISC = -1e40
        "B-C leakage saturation current, default = 0";
      constant Real C4 =   -1e40 "Obsolete parameter name, default = 0";
      parameter Real BR = 1.0 "Ideal maximum reverse beta";
      parameter Real NR = 1.0 "Reverse current emission coefficient";
      parameter Real NC = 2.0 "B-C leakage emission coefficient";
      parameter SI.Voltage VAF = 0.0 "Forward Early voltage";
      parameter SI.Current IKF = 0.0 "Forward beta roll-off corner current";
      parameter SI.Voltage VAR = 0.0 "Reverse Early voltage";
      parameter SI.Current IKR = 0.0 "Reverse beta roll-off corner current";
      parameter SI.Resistance RE = 0.0 "Emitter resistance";
      parameter SI.Resistance RC = 0.0 "Collector resistance";
      parameter SI.Current IRB = 0.0 "Current for base resistance = (rb+rbm)/2";
      parameter SI.Resistance RB = 0.0 "Zero bias base resistance";
      parameter SI.Resistance RBM = -1e40
        "Minimum base resistance, default = 0.0";
      parameter SI.Capacitance CJE = 0.0 "Zero bias B-E depletion capacitance";
      parameter SI.Voltage VJE = 0.75 "B-E built in potential";
      parameter Real MJE = 0.33 "B-E junction exponential factor";
      parameter SI.Time TF = 0.0 "Ideal forward transit time";
      parameter Real XTF = 0.0 "Coefficient for bias dependence of TF";
      parameter SI.Current ITF = 0.0 "High current dependence of TF,";
      parameter SI.Voltage VTF = 0.0 "Voltage giving VBC dependence of TF";
      parameter SI.Temp_C PTF = 0.0 "Excess phase at freq=1/(TF*2*Pi) Hz";
      parameter SI.Capacitance CJC = 0.0 "Zero bias B-C depletion capacitance";
      parameter SI.Voltage VJC = 0.75 "B-C built in potential";
      parameter Real MJC = 0.33 "B-C junction grading coefficient";
      parameter Real XCJC = 1.0 "Fraction of B-C cap to internal base";
      parameter SI.Time TR = 0.0 "Ideal reverse transit time";
      parameter SI.Capacitance CJS = 0.0 "Zero bias C-S capacitance";
      parameter SI.Voltage VJS = 0.75 "Substrate junction built-in potential";
      parameter Real MJS = 0.0 "Substrate junction grading coefficient";
      parameter Real XTB = 0.0 "Forward and reverse beta temperature exponent";
      parameter SI.GapEnergy EG = 1.11
        "Energy gap for IS temperature effect on IS";
      parameter Real XTI = 3.0 "Temperature exponent for IS";
      parameter Real KF = 0.0 "Flicker Noise Coefficient";
      parameter Real AF = 1.0 "Flicker Noise Exponent";
      parameter Real FC = 0.5 "Forward bias junction fit parameter";

      annotation (Documentation(info="<html>
<p>This record is obsolete, please use ModelcardBJT2</p>
<p>Modelcard parameters for BJT model, both PNP and NPN</p>
<p>The package Internal is not for user access. There all function, records and data are stored, that are needed for the semiconductor models of the package Semiconductors.</p>
</html>"),
      obsolete = "Obsolete record - use Modelica.Electrical.Spice3.Internal.ModelcardBJT2 instead");
    end ModelcardBJT;

  model JFET "Junction Field-Effect Transistor"

    Modelica.Electrical.Analog.Interfaces.PositivePin G "gate node" annotation (Placement(transformation(
              extent={{-110,-12},{-90,10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin D "drain node" annotation (Placement(transformation(
              extent={{-10,90},{10,110}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin S "source node" annotation (Placement(
            transformation(extent={{-10,-110},{10,-90}})));

    parameter Integer mtype( start = 0)
        "JFET type: 0 - N channel, 1 - P channel";
    parameter Real AREA( start = 1)
        "Number of parallel connected identical elements";
    parameter Boolean OFF = false
        "Optional initial condition: 0 - IC not used, 1 - IC used, not implemented yet";
    parameter SI.Voltage IC_VDS = -1e40
        "Initial condition value (VDS, not implemented yet)";
    parameter SI.Voltage IC_VGS = -1e40
        "Initial condition value (VGS, not implemented yet)";
    parameter Boolean UIC = false
        "Use initial conditions: true, if initial condition is used";
    parameter SI.Temp_C TEMP=27 "Operating temperature of the device";

    parameter Modelica.Electrical.Spice3.Internal.ModelcardJFET modelcard
        "JFET modelcard" annotation(Evaluate=true);
    final parameter Modelica.Electrical.Spice3.Internal.Jfet.JfetModelLine p=
          Modelica.Electrical.Spice3.Internal.Jfet.jfetRenameParameters(modelcard)
        "Model line parameters" annotation(Evaluate=true);
    final parameter Modelica.Electrical.Spice3.Internal.Fet.Fet m=
          Modelica.Electrical.Spice3.Internal.Fet.fetRenameParametersDev(
            AREA,
            OFF,
            IC_VDS,
            IC_VGS,
            UIC,
            TEMP) "Renamed parameters" annotation(Evaluate=true);

    final parameter Integer m_type = if (mtype > 0.5) then -1 else 1
        "Type of the transistor";
    //    enum fet_type { NFET = 1, PFET = -1 };

    final parameter Modelica.Electrical.Spice3.Internal.Jfet.JfetModelLine p1=
          Modelica.Electrical.Spice3.Internal.Jfet.jfetInitEquations(m, p)
        "Precalculated parameters";
    final parameter Modelica.Electrical.Spice3.Internal.Jfet.JfetModelLine p2=
          Modelica.Electrical.Spice3.Internal.Jfet.jfetModelLineInitEquations(p1)
        "Model line variables";
    final parameter Modelica.Electrical.Spice3.Internal.Fet.Fet m1=
          Modelica.Electrical.Spice3.Internal.Jfet.jfetCalcTempDependencies(m, p2)
        "Precalculated parameters";
    Modelica.Electrical.Spice3.Internal.Fet.CurrrentsCapacitances cc;

    constant Boolean m_bInit = false;

    SI.Voltage Dinternal;  //internal drain node
    SI.Voltage Sinternal;  //internal source node
    SI.Voltage vGD;
    SI.Voltage  vGS;
    SI.Current ird;
    SI.Current irs;
    SI.Current igdgmin;
    SI.Current igsgmin;

    SI.Current icGS;
    SI.Current icGD;

  equation
      cc = Modelica.Electrical.Spice3.Internal.Jfet.jfetNoBypassCode(
          m1,
          p2,
          m_type,
          m_bInit,
          {G.v,Dinternal,Sinternal});

    // voltages
    // --------
    vGD = G.v - Dinternal;
    vGS = G.v - Sinternal;

    // drain- and sourceresistances
    // ----------------------------
    ird * p2.m_drainResist = (D.v - Dinternal);
    irs * p2.m_sourceResist = (S.v - Sinternal);

    // capacitances
    // ------------
    icGD = cc.cGD * der(vGD);
    icGS = cc.cGS * der(vGS);

    // currents
    // --------
      igsgmin = Modelica.Electrical.Spice3.Internal.SpiceConstants.CKTgmin*(G.v -
        Sinternal);
      igdgmin = Modelica.Electrical.Spice3.Internal.SpiceConstants.CKTgmin*(G.v -
        Dinternal);
    G.i = icGD + icGS + cc.iGD + igdgmin + cc.iGS + igsgmin;
    D.i = ird;
    S.i = irs;

    //currentsum at inner node
    //------------------------
    0    = -ird + cc.idrain - cc.iGD - igdgmin - icGD;
    0    = -irs - cc.idrain - cc.iGS - igsgmin - icGS;

    annotation (Documentation(info="<html>
<p>JFET model, both N and P channel</p>
<p>The package Internal is not for user access. There all function, records and data are stored, that are needed for modeling the semiconductor models of the package Semiconductors.</p>
</html>", revisions="<html>
<ul>
<li><em>March 2008</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{0,92},{0,40},{-12,40},{-12,-40},{0,-40},{0,-94}},
                color={0,0,255}),
            Line(points={{-92,0},{-20,0}}, color={0,0,255}),
            Line(points={{-20,40},{-20,-40}}, color={0,0,255}),
            Text(
              extent={{8,-34},{96,-54}},
              lineColor={0,0,255},
              textString="%name")}));
  end JFET;

    record ModelcardJFET "Record with technology parameters (.model)"
    extends Modelica.Icons.Record;
      parameter SI.Capacitance CGS=-1e40
        "Zero-bias G-S junction capacitance, default 0";
      parameter SI.Capacitance CGD=-1e40
        "Zero-bias G-D junction capacitance, default 0";
      parameter SI.Current IS=1e-14 "Saturation current of pn junctions";
      parameter Real FC=0.5
        "Coefficient for forward-bias depletion capacitance formula";
      parameter SI.Resistance RD=-1e40 "Drain ohmic resistance, default 0";
      parameter SI.Resistance RS=-1e40 "Source ohmic resistance, default 0";
      parameter SI.Temp_C TNOM=27 "Parameter measurement temperature";
      parameter SI.Voltage VTO=-1e40 "Zero-bias threshold voltage, default -2";
      parameter SI.InversePotential B=-1e40
        "Dotierungsverlauf parameter, default 1";
      parameter Real BETA=-1e40 "Output admittance parameter, default 1e-4";
      parameter SI.InversePotential LAMBDA=0
        "Channel-length modulation, default 0";
      parameter SI.Voltage PB=1.0 "Junction potential of pn junctions";
      parameter Real AF=1.0 "Flicker noise exponent";
      parameter Real KF=0 "Flicker noise coefficient";

     annotation (Documentation(info="<html>
<p>Modelcard parameters for JFET model, both N and P channel</p>
<p>The package Internal is not for user access. There all function, records and data are stored, that are needed for modeling the semiconductor models of the package Semiconductors.</p>
</html>"));
    end ModelcardJFET;

   model DIODE "Diode model"

     extends Modelica.Electrical.Analog.Interfaces.TwoPin;

     parameter Real AREA = 1 "Area factor";
     parameter Boolean OFF = false
        "Optional initial condition: false - IC not used, true - IC used, not implemented yet";
     parameter SI.Voltage IC( start = -1e40)
        "Initial condition value (VD, not implemented yet";
     parameter SI.Temp_C TEMP = 27 "Operating temperature of the device";
     parameter Boolean SENS_AREA( start = false)
        "Flag to request sensitivity WRT area, not implemented yet";

     parameter ModelcardDIODE modelcarddiode "DIODE modelcard" annotation(Evaluate=true);
     constant SpiceConstants C "General constants of SPICE simulator";
     final parameter Diode.DiodeModelLineParams param=
          Diode.diodeRenameParameters(modelcarddiode, C)
        "Model line parameters";
     final parameter Diode.DiodeParams dp=Diode.diodeRenameParametersDev(
             TEMP,
             AREA,
             IC,
             OFF,
             SENS_AREA) "Renamed parameters"
                      annotation(Evaluate=true);
     final parameter Model.Model m=Diode.diodeRenameParametersDevTemp(TEMP)
        "Renamed parameters"
                 annotation(Evaluate=true);
     final parameter Diode.DiodeVariables c1=Diode.diodeInitEquations(param)
        "Precalculated values";
     final parameter Diode.DiodeCalc c2=Diode.diodeCalcTempDependencies(
             param,
             dp,
             m,
             c1) "Precalculated values";
     constant Boolean m_mbInit = false;

     Diode.CurrentsCapacitances cc;
     Real icap;
     Real m_dCap;
     Real pin;
     Real ir;
     Real igmin;

   equation
      (cc,m_dCap) = Diode.diodeNoBypassCode(
           param,
           dp,
           c2,
           m,
           m_mbInit,
           {pin,n.v});

     //current through capacitance
     icap = if (m_mbInit) then 0.0 else m_dCap*(der(pin)-der(n.v));
     //resistance
       ir*param.m_resist = (p.v - pin);

     //gmin
      igmin = SpiceConstants.CKTgmin*(pin - n.v);

     p.i =  ir;
     n.i =  -(cc.m_dCurrent +igmin) -icap;

   //currentsum at inner node
     0 =  -ir + cc.m_dCurrent + igmin +icap;

     annotation (
       Icon(graphics={
            Line(points={{90,0},{-90,0}}, color={0,0,255}),
           Polygon(
             points={{30,0},{-30,40},{-30,-40},{30,0}},
             lineColor={0,0,255},
             fillColor={255,255,255},
             fillPattern=FillPattern.Solid),
           Line(points={{-90,0},{40,0}}, color={0,0,255}),
           Line(points={{40,0},{90,0}}, color={0,0,255}),
           Line(points={{30,40},{30,-40}}, color={0,0,255}),
           Text(
             extent={{-154,100},{146,60}},
             textString="%name",
             lineColor={0,0,255})}),
       Documentation(info="<html>
<p>DIODE model</p>
<p>The package Repository is not for user access. There all function, records and data are stored, that are needed for the semiconductor models of the package Semiconductors.</p>
</html>", revisions="<html>
<ul>
<li><em>Nov. 2008</em> by Kristin Majetta <br/>initially implemented</li>
</ul>
</html>"));
   end DIODE;

   record ModelcardDIODE "Record with technology parameters (.model)"
     extends Modelica.Icons.Record;
    parameter SI.Current IS=1e-14 "Saturation Current";
    parameter SI.Resistance RS=0.0 "Ohmic resistance";
    parameter Real N=1.0 "Emission coefficient";
    parameter SI.Time TT=0.0 "Transit time";
    parameter SI.Capacitance CJO=0.0 "Junction capacitance";
    parameter SI.Voltage VJ=1.0 "Junction Potential";
    parameter Real M=0.5 "Grading coefficient";
    parameter SI.ActivationEnergy EG=1.11 "Activation Energy";
    parameter Real XTI=3.0 "Saturation current temperature exponent";
    parameter Real FC=0.5 "Forward bias junction fit parameter";
    parameter SI.Voltage BV=-1e40 "Reverse breakdown voltage, default infinity";
    parameter SI.Current IBV=1e-3 "Current at reverse breakdown voltage";
    parameter SI.Temp_C TNOM=27 "Parameter measurement temperature";
    parameter Real KF=0.0 "Flicker noise coefficient";
    parameter Real AF=1.0 "Flicker noise exponent";
    parameter SI.Conductance G=0 "Ohmic conductance";
     annotation (Documentation(info="<html>
<p>Modelcard parameters for DIODE model</p>
<p>The package Repository is not for user access. There all function, records and data are stored, that are needed for the semiconductor models of the package Semiconductors.</p>
</html>"));
   end ModelcardDIODE;

    model R_SEMI "Semiconductor resistor"

      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Resistance R= -1e40
        "Resistance, if specified, geometrical information is overwritten";
      parameter SI.Temp_C TEMP = -1e40 "Temperature of resistor";
      parameter SI.Length L = -1e40 "Length of the resistor";
      parameter SI.Length W = -1e40
        "Width of the resistor, default DEFW (modelcard)";
      parameter Boolean SENS_AREA= false
        "Parameter for sensitivity analyses, not implemented yet";
      parameter ModelcardR modelcard "Resistor modelcard";
      constant SpiceConstants C "General constants of SPICE simulator";
      final parameter Rsemiconductor.ResistorModelLineParams lp=
          Rsemiconductor.resistorRenameParameters(modelcard, C)
        "Model Line Parameters";
      final parameter Rsemiconductor.ResistorParams rp=
          Rsemiconductor.resistorRenameParametersDev(
              R,
              W,
              L,
              TEMP,
              SENS_AREA,
              C) "Renamed parameters";

        Rsemiconductor.ResistorVariables vp;

    algorithm
      vp := Rsemiconductor.resistorInitEquations(rp, lp);

      (vp.m_dConduct,vp.m_dCond_dTemp) :=
        Modelica.Electrical.Spice3.Internal.Functions.resDepTemp(
            vp.m_dResist,
            rp.m_dTemp,
            lp.m_dTnom,
            lp.m_dTC1,
            lp.m_dTC2);

     i :=vp.m_dConduct*v;

      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Rectangle(
              extent={{-70,28},{70,-32}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-70,0},{-90,0}},
              color={0,0,255}),
            Line(
              points={{70,0},{90,0}},
              color={0,0,255}),
            Text(
              extent={{-150,64},{150,24}},
              textString="%name",
              lineColor={0,0,255})}),Documentation(revisions="<html>
<dl>
<dt><em> April 2009 </em></dt>
<dd>by Kristin Majetta initially implemented</dd>
</dl>
</html>", info="<html>
<p>Semiconductor resistance model</p>
<p>The package Repository is not for user access. There all function, records and data are stored, that are needed for the semiconductor models of the package Semiconductors.</p>
</html>"));
    end R_SEMI;

    record ModelcardR "Record with technology parameters (.model)"
      extends Modelica.Icons.Record;
     parameter SI.LinearTemperatureCoefficientResistance TC1 = 0.0
        "First order temperature coefficient";
     parameter SI.QuadraticTemperatureCoefficientResistance TC2 = 0.0
        "Second order temperature coefficient";
     parameter SI.Resistance RSH = -1e40 "Sheet resistance";
     parameter SI.Temp_C TNOM = -1e40
        "Parameter measurement temperature, default 27";
     parameter SI.Length DEFW = 1e-5 "Default device width";
     parameter SI.Length NARROW = 0 "Narrowing of resistor due to side etching";
      annotation (Documentation(info="<html>
<p>Modelcard parameters for semiconductor resistance model</p>
<p>The package Repository is not for user access. There all function, records and data are stored, that are needed for the semiconductor models of the package Semiconductors.</p>
</html>"));
    end ModelcardR;

    model C_SEMI "Semiconductor capacitor"

      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Capacitance C = -1e40
        "Capacitance, if specified, geometrical information is overwritten";
      parameter SI.Temp_C TEMP = 27 "Temperature of capacitor";
      parameter SI.Length  L(start = 0) "Length of the capacitor";
      parameter SI.Length  W = -1e40
        "Width of the capacitor, default DEFW (modelcard)";
      parameter Boolean SENS_AREA = false
        "Parameter for sensitivity analyses, not implemented yet";
      parameter SI.Voltage IC = 0 "Initial value";
      parameter Boolean UIC = false
        "Use initial conditions: true, if initial condition is used";
      parameter Modelica.Electrical.Spice3.Internal.ModelcardC modelcard
        "Capacitor modelcard";
      final parameter
        Modelica.Electrical.Spice3.Internal.Csemiconductor.CapacitorModelLineParams lp=
          Modelica.Electrical.Spice3.Internal.Csemiconductor.capacitorRenameParameters(
           modelcard) "Model Line Parameters";
      final parameter
        Modelica.Electrical.Spice3.Internal.Csemiconductor.Capacitor               cp=
          Modelica.Electrical.Spice3.Internal.Csemiconductor.capacitorRenameParametersDev(
              C,
              W,
              L,
              TEMP,
              SENS_AREA,
              lp) "Renamed parameters";

      Modelica.Electrical.Spice3.Internal.Csemiconductor.Capacitor vp;

    protected
      SI.Voltage vinternal;

    initial equation
      if UIC then
        vinternal = IC;
      else
        der(vinternal) = 0;
      end if;

    algorithm
      if (cp.m_dCapIsGiven < 0.5) then
        assert( L > 0, "Length of capacitor must be greater than zero");
      end if;

      vp := Modelica.Electrical.Spice3.Internal.Csemiconductor.capacitorInitEquations(
         cp, lp);

      vinternal := p.v - n.v;
      i         := vp.m_dCapac*der(vinternal);

      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Line(
              points={{-14,28},{-14,-28}},
              color={0,0,255},
              thickness=0.5),
            Line(
              points={{14,28},{14,-28}},
              color={0,0,255},
              thickness=0.5),
            Line(points={{-90,0},{-14,0}}, color={0,0,255}),
            Line(points={{14,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-130,-40},{134,-60}},
              textString="C=%C"),
            Text(extent={{-138,42},{136,62}}, textString="%name")}),
                                     Documentation(revisions="<html>
<ul>
<li><em>April 2009</em> by Kristin Majetta
    <br>initially implemented</li>
</ul>
</html>", info="<html>
<p>Semiconductor capacitance model</p>
<p><br/>The package Repository is not for user access. There all function, records and data are stored, that are needed for the semiconductor models of the package Semiconductors.</p>
</html>"));
    end C_SEMI;

    record ModelcardC "Record with technology parameters (.model)"
    extends Modelica.Icons.Record;
      parameter SI.CapacitancePerArea CJ = 0.0
        "Junction bottom capacitance     F/meters2";
      parameter SI.Permittivity CJSW = 0.0
        "Junction sidewall capacitance   F/meters";
      parameter SI.Length  DEFW=1e-5 "Default device width";
      parameter SI.Length  NARROW=0 "Narrowing due to side etching";
      annotation (Documentation(info="<html>
<p>Modelcard parameters for semiconductor capacitance model</p>
<p><br/>The package Repository is not for user access. There all function, records and data are stored, that are needed for the semiconductor models of the package Semiconductors.</p>
</html>"));
    end ModelcardC;

     record SpiceConstants "General constants of SPICE simulator"
       extends Modelica.Icons.Record;
       constant Real EPSSIL =     (11.7 * 8.854214871e-12);
       constant Real EPSOX =      3.453133e-11;
       constant SI.Charge CHARGE =     (1.6021918e-19);
       constant SI.Temp_K CONSTCtoK =  (273.15);
       constant SI.HeatCapacity CONSTboltz = (1.3806226e-23); // J/K
       constant SI.Temp_K REFTEMP =    300.15;  /* 27 deg C */

       constant Real CONSTroot2 =  sqrt(2.0);
       constant Real CONSTvt0(   final unit= "(J)/(A.s)") = Modelica.Constants.k * SI.Conversions.from_degC(27)  / CHARGE; // deg C
       constant Real CONSTKoverQ(  final unit= "(J/K)/(A.s)")= Modelica.Constants.k / CHARGE;
       constant Real CONSTe =      exp(1.0);

       // options

       constant SI.Conductance CKTgmin =         1e-12;
       constant SI.Temp_K CKTnomTemp =      300.15;
       constant SI.Temp_K CKTtemp =         300.15;
       constant SI.Area CKTdefaultMosAD = 0.0;
       constant SI.Area CKTdefaultMosAS = 0.0;
       constant SI.Length CKTdefaultMosL =  100e-6;
       constant SI.Length CKTdefaultMosW =  100e-6;
       constant Real CKTreltol =       1e-10;
       constant Real CKTabstol =       1e-15;
       constant Real CKTvolttol =      1e-10;
       constant Real CKTtemptol =      1e-3;
      annotation (Documentation(info="<html>
<p>General constants used by SPICE</p>
<p>The package Internal is not for user access. There all function, records and data are stored, that are needed for the semiconductor models of the package Semiconductors.</p>
</html>"));
     end SpiceConstants;

    record MaterialParameters
    extends Modelica.Icons.Record;
      // energy gap for silicon
      constant SI.GapEnergy EnergyGapSi = 1.16;
      // first band correction factor of silicon
      constant Types.GapEnergyPerTemperature FirstBandCorrFactorSi = 7.02e-4;
      // second band correction factor of silicon
      constant SI.Temperature SecondBandCorrFactorSi = 1108;
      // band correction factor for T = 300K
      constant SI.GapEnergy BandCorrFactorT300 = 1.1150877;
      // intrinsic conduction carrier density
      constant Types.PerVolume IntCondCarrDensity = 1.45e16;
     annotation (Documentation(info="<html>
<p>Definition of Material parameters</p>
<p>The package Repository is not for user access. There all function, records and data are stored, that are needed for the semiconductor models of the package Semiconductors.</p>
</html>"));
    end MaterialParameters;

  package Functions "Equations for semiconductor calculation"
    extends Modelica.Icons.InternalPackage;

      function junctionPotDepTemp
        "Temperature dependency of junction potential"
        extends Modelica.Icons.Function;

        input SI.Voltage phi0;
        input SI.Temp_K temp "Device Temperature";
        input SI.Temp_K tnom "Nominal Temperature";

        output SI.Voltage ret "Output voltage";

      protected
        SI.GapEnergy phibtemp;
        SI.GapEnergy phibtnom;
        SI.Voltage vt;
        constant SI.GapEnergy unitGapEnergy = 1;
        constant SI.Voltage unitVoltage = 1;

      algorithm
        phibtemp :=
          Modelica.Electrical.Spice3.Internal.Functions.energyGapDepTemp(temp);
        phibtnom :=
          Modelica.Electrical.Spice3.Internal.Functions.energyGapDepTemp(tnom);
        vt := Spice3.Internal.SpiceConstants.CONSTKoverQ*
          temp;
        ret := (phi0 - phibtnom*(unitVoltage/unitGapEnergy)) * temp / tnom + phibtemp*(unitVoltage/unitGapEnergy) + vt * 3 * Modelica.Math.log( tnom / temp);

        annotation (Documentation(info="<html>
<p>This internal function calculates the temperature dependent junction potential based on the actual and the nominal temperature.</p>
</html>"));
      end junctionPotDepTemp;

      function saturationCurDepTempSPICE3MOSFET
        "Temperature dependency of saturation current"
      extends Modelica.Icons.Function;
        input SI.Current satcur0 "Saturation current";
        input SI.Temp_K temp "Device Temperature";
        input SI.Temp_K tnom "Nominal Temperature";

        output Real ret "Output current"; //unit Current

      protected
        SI.Voltage vt;
        SI.Voltage vtnom;
        SI.GapEnergy energygaptnom;
        SI.GapEnergy energygaptemp;
        constant SI.GapEnergy unitGapEnergy = 1;
        constant SI.Voltage unitVoltage = 1;

      algorithm
        vt := Spice3.Internal.SpiceConstants.CONSTKoverQ*
          temp;
        vtnom := Spice3.Internal.SpiceConstants.CONSTKoverQ*
          tnom;
        energygaptnom :=
          Modelica.Electrical.Spice3.Internal.Functions.energyGapDepTemp(tnom);
        energygaptemp :=
          Modelica.Electrical.Spice3.Internal.Functions.energyGapDepTemp(temp);
        ret           := satcur0 * exp( energygaptnom*(unitVoltage/unitGapEnergy) / vtnom - energygaptemp*(unitVoltage/unitGapEnergy) / vt);

        annotation (Documentation(info="<html>
<p>This internal function calculates the temperature dependent saturation current based on the actual and the nominal temperature.</p>
</html>"));
      end saturationCurDepTempSPICE3MOSFET;

      function junctionVCrit "Voltage limitation"
      extends Modelica.Icons.Function;
        input SI.Temp_K temp "temperature";
        input Real ncoeff;
        input SI.Current satcur "Saturation current";

        output Real ret "Output value";

      protected
        SI.Voltage vte;

      algorithm
        vte := Spice3.Internal.SpiceConstants.CONSTKoverQ*
          temp*ncoeff;
        ret := vte * Modelica.Math.log( vte / (sqrt(2) * satcur));
        ret := if ( ret > 1e10) then  1e10 else ret;

        annotation (Documentation(info="<html>
<p>This internal function limits the junction voltage. If it increases 1e10, it is hold to be constant at that value.</p>
</html>"));
      end junctionVCrit;

      function junctionParamDepTempSPICE3
        "Temperature dependency of junction parameters"
      extends Modelica.Icons.Function;
        input SI.Voltage phi0;
        input Real cap0;
        input Real mcoeff;
        input SI.Temp_K temp "Device temperature";
        input SI.Temp_K tnom "Nominal temperature";

        output SI.Voltage junctionpot "Junction potential";
        output Real jucntioncap "Junction capacitance";

      protected
        SI.GapEnergy phibtemp;
        SI.GapEnergy phibtnom;
        SI.Voltage vt;
        SI.Voltage vtnom;
        Real arg;
        Real fact2;
        Real pbfact;
        Real arg1;
        Real fact1;
        Real pbfact1;
        Real pbo;
        Real gmaold;
        Real gmanew;

      algorithm
        phibtemp :=
          Modelica.Electrical.Spice3.Internal.Functions.energyGapDepTemp(temp);
        phibtnom :=
          Modelica.Electrical.Spice3.Internal.Functions.energyGapDepTemp(tnom);
        vt          := Spice3.Internal.SpiceConstants.CONSTKoverQ * temp;
        vtnom       := Spice3.Internal.SpiceConstants.CONSTKoverQ * tnom;
        arg         := -phibtemp/(2*Modelica.Constants.k*temp) +
                       1.1150877/(Modelica.Constants.k*(2*Spice3.Internal.SpiceConstants.REFTEMP));
        fact2       := temp/Spice3.Internal.SpiceConstants.REFTEMP;
        pbfact      := -2*vt*(1.5*Modelica.Math.log(fact2)+Spice3.Internal.SpiceConstants.CHARGE*arg);
        arg1        := -phibtnom/(Modelica.Constants.k*2*tnom) +
                       1.1150877/(2*Modelica.Constants.k*Spice3.Internal.SpiceConstants.REFTEMP);
        fact1       := tnom/Spice3.Internal.SpiceConstants.REFTEMP;
        pbfact1     := -2 * vtnom*(1.5*Modelica.Math.log(fact1)+Spice3.Internal.SpiceConstants.CHARGE*arg1);
        pbo         := (phi0-pbfact1)/fact1;
        junctionpot := pbfact+fact2*pbo;
        gmaold      := (phi0 -pbo)/pbo;
        gmanew      := (junctionpot-pbo)/pbo;
        jucntioncap := cap0 /
                       (1+mcoeff* (400e-6*(tnom-Spice3.Internal.SpiceConstants.REFTEMP)-gmaold))  *
                       (1+mcoeff* (400e-6*(temp-Spice3.Internal.SpiceConstants.REFTEMP)-gmanew));

        annotation (Documentation(info="<html>
<p>This internal function calculates several temperature dependent junction parameters based on the actual and the nominal temperature.</p>
</html>"));
      end junctionParamDepTempSPICE3;

      function junctionCapCoeffs "Coefficient calculation"
      extends Modelica.Icons.Function;
        input Real mj;
        input Real fc;
        input SI.Voltage phij;

        output SI.Voltage f1;
        output Real f2;
        output Real f3;

      protected
        Real xfc;

      algorithm
        xfc := Modelica.Math.log(1 - fc);
        f1  := phij * (1 - exp(( 1 - mj)  * xfc)) / (1 - mj);
        f2  := exp(( 1 + mj) * xfc);
        f3  := 1 - fc * (1 + mj);

        annotation (Documentation(info="<html>
<p>This internal auxiliary function calculates some coefficients which are necessary for the calculation of junction capacities.</p>
</html>"));
      end junctionCapCoeffs;

    function junction2SPICE3MOSFETRevised
        "Junction current and conductance calculation"
    extends Modelica.Icons.Function;
      input SI.Voltage voltage "Input voltage";
      input SI.Temp_K temp "Device Temperature";
      input Real ncoeff;
      input SI.Current satcur "Saturation current";

      output SI.Current out_current "Calculated current";
      output SI.Conductance out_cond "Calculated conductance";

      protected
      SI.Voltage vte;
      Real max_exponent;
      Real evbd;
      Real evd;
      constant Real max_exp = 50.;
      constant SI.Current max_current = 1e4;

    algorithm
      if (satcur > 1e-101) then
        vte := Spice3.Internal.SpiceConstants.CONSTKoverQ*temp*ncoeff;

        max_exponent := Modelica.Math.log(max_current/satcur);
        max_exponent := min(max_exp, max_exponent);

        if (voltage <= 0) then
          out_cond    := satcur/vte;
          out_current := out_cond * voltage;
          out_cond := out_cond + Spice3.Internal.SpiceConstants.CKTgmin;
        elseif (voltage >= max_exponent * vte) then
          evd         := exp( max_exponent);
          out_cond    := satcur * evd / vte;
          out_current := satcur * (evd - 1) + out_cond * (voltage - max_exponent * vte);

        else
          evbd        := exp( voltage / vte);
          out_cond := satcur*evbd/vte + Spice3.Internal.SpiceConstants.CKTgmin;
          out_current := satcur *(evbd-1);
        end if;
      else
        out_current := 0.;
        out_cond    := 0.;
      end if;

      annotation (Documentation(info="<html>
<p>This internal function calculates both the junction current and the junction conductance dependent from the given voltage.</p>
</html>"));
    end junction2SPICE3MOSFETRevised;

    function junction2SPICE3MOSFET
      "Junction current and conductance calculation, obsolete, use junction2SPICE3MOSFETRevised"
      extends Modelica.Icons.Function;
      extends Modelica.Icons.ObsoleteModel;

      input SI.Current current "Input current";
      input SI.Conductance cond "Input conductance";
      input SI.Voltage voltage "Input voltage";
      input SI.Temp_K temp "Device Temperature";
      input Real ncoeff;
      input SI.Current satcur "Saturation current";

      output SI.Current out_current "Calculated current";
      output SI.Conductance out_cond "Calculated conductance";

      protected
      SI.Voltage vte;
      Real max_exponent;
      Real evbd;
      Real evd;
      constant Real max_exp =     50.;
      constant SI.Current max_current = 1e4;

    algorithm
      out_current := current;
      out_cond := cond;
      if (satcur > 1e-101) then
          vte := Spice3.Internal.SpiceConstants.CONSTKoverQ*
            temp*ncoeff;

        max_exponent := Modelica.Math.log(max_current/satcur);
        max_exponent := min(max_exp, max_exponent);

        if (voltage <= 0) then
          out_cond    := satcur/vte;
          out_current := out_cond * voltage;
            out_cond := out_cond + Spice3.Internal.SpiceConstants.CKTgmin;
        elseif (voltage >= max_exponent * vte) then
          evd         := exp( max_exponent);
          out_cond    := satcur * evd / vte;
          out_current := satcur * (evd - 1) + out_cond * (voltage - max_exponent * vte);

        else
          evbd        := exp( voltage / vte);
            out_cond := satcur*evbd/vte + Spice3.Internal.SpiceConstants.CKTgmin;
          out_current := satcur *(evbd-1);
        end if;
      else
        out_current := 0.;
        out_cond    := 0.;
      end if;

      annotation (Documentation(info="<html>
<p>This internal function calculates both the junction current and the junction conductance dependent from the given voltage.</p>
</html>"),
      obsolete = "Obsolete function - use Modelica.Electrical.Spice3.Internal.Functions.junction2SPICE3MOSFETRevised instead");
    end junction2SPICE3MOSFET;

    function junctionCapRevised "Junction capacity"
      extends Modelica.Icons.Function;
      input SI.Capacitance capin "Input capacitance";
      input SI.Voltage voltage "Input voltage";
      input SI.Voltage depcap;
      input Real mj;
      input Real phij;
      input SI.Voltage f1;
      input Real f2;
      input Real f3;

      output SI.Capacitance capout "Output capacitance";
      output SI.Charge charge "Output charge";

      protected
      Real arg;
      Real sarg;
      Real czof2;

    algorithm
      if (voltage < depcap) then
        arg  := 1 - (voltage / phij);
        if (mj == 0.5) then
          sarg := 1 / sqrt(arg);
        else
            sarg := exp(-1*mj*Modelica.Math.log(arg));
        end if;
        capout := capin * sarg;
        charge := phij * (capin * (1 - arg * sarg) / (1 - mj));
      else
        czof2  := capin / f2;
        capout := czof2 * (f3 + mj * voltage / phij);
        charge := capin * f1 + czof2 *
                  (f3 * (voltage - depcap) + (mj / (2*phij)) * (voltage^2 - depcap^2));
      end if;

      annotation (Documentation(info="<html>
<p>This internal function calculates the charge and the capacitance of the junction capacity dependent from the given voltage.</p>
</html>"));
    end junctionCapRevised;

    function junctionCap "Junction capacity, obsolete, use JunctionCapRevised"
      extends Modelica.Icons.Function;
      extends Modelica.Icons.ObsoleteModel;

      input SI.Capacitance capin "Input capacitance";
      input SI.Voltage voltage "Input voltage";
      input SI.Voltage depcap;
      input Real mj;
      input Real phij;
      input SI.Voltage f1;
      input Real f2;
      input Real f3;

      output SI.Capacitance capout "Output capacitance";
      output SI.Charge charge "Output charge";

      protected
      Real arg;
      Real sarg;
      Real czof2;

    algorithm
      if (voltage < depcap) then
        arg  := 1 - (voltage / phij);
        if (mj == 0.5) then
          sarg := 1 / sqrt(arg);
        else
          sarg := exp( -1 * mj * Modelica.Math.log( arg));
        end if;
        capout := capin * sarg;
        charge := phij * (capin * (1 - arg * sarg) / (1 - mj));
      else
        czof2  := capin / f2;
        capout := czof2 * (f3 + mj * voltage / phij);
        charge := capin * f1 + czof2 *
                  (f3 * (voltage - depcap) + (mj / (2*phij)) * (voltage^2 - depcap^2));
      end if;

      annotation (Documentation(info="<html>
<p>This internal function calculates the charge and the capacitance of the junction capacity dependent from the given voltage.</p>
</html>"),
      obsolete = "Obsolete function - use Modelica.Electrical.Spice3.Internal.Functions.junctionCapRevised instead");
    end junctionCap;

    function saturationCurDepTempSPICE3
      "Temperature dependency of saturation current"
      extends Modelica.Icons.Function;
      input SI.Current satcur0 "Saturation current";
      input SI.Temp_K temp "Device Temperature";
      input SI.Temp_K tnom "Nominal Temperature";
      input Real emissioncoeff;
      input Real energygap;
      input Real satcurexp;

      output SI.Current ret "Output value";

      protected
      SI.Voltage vt;
      SI.Voltage vte;

    algorithm
        vt := Spice3.Internal.SpiceConstants.CONSTKoverQ*
          temp;
      vte := emissioncoeff * vt;
      ret := satcur0 * exp( ((temp / tnom) - 1) * energygap / vte
             + satcurexp / emissioncoeff * Modelica.Math.log( temp / tnom));

      annotation (Documentation(info="<html>
<p>This internal function calculates the temperature dependent saturation current based on the actual and the nominal temperature.</p>
</html>"));
    end saturationCurDepTempSPICE3;

    function junctionVoltage23SPICE3 "Junction Voltage"
      extends Modelica.Icons.Function;
      input SI.Voltage vb;
      input SI.Current ivb;
      input SI.Current satcur "Saturation current";
      input SI.Temp_K temp "Device temperature";
      input Real ncoeff;

      output SI.Voltage v23 "Output value";

      protected
      SI.Voltage vt;
      SI.Current cbv;
      Real tol;
      Integer iter;

    algorithm
        vt := Spice3.Internal.SpiceConstants.CONSTKoverQ*
          temp;
      v23 := vb;
      cbv := ivb;

      if (cbv < satcur * vb / vt) then
        cbv := satcur * vb / vt;
      else
          tol := Spice3.Internal.SpiceConstants.CKTreltol*
            cbv;
        v23 := vb - vt * Modelica.Math.log( 1 + cbv / satcur);
        for iter in 0:24 loop
          v23 := vb - vt * Modelica.Math.log( cbv / satcur + 1 - v23 / vt);
          if (abs( satcur * ( exp(( vb - v23) / vt) - 1 + v23 / vt) - cbv) <= tol) then

          end if;
        end for;
      end if;

      annotation (Documentation(info="<html>
<p>This internal function calculates the junction voltage based on the actual temperature, voltage and saturation current.</p>
</html>"));
    end junctionVoltage23SPICE3;

    function junction3 "Junction current and conductance calculation"
      extends Modelica.Icons.Function;
      input SI.Voltage voltage "Input voltage";
      input SI.Temp_K temp "Device Temperature";
      input Real ncoeff;
      input SI.Current satcur "Saturation current";
      input SI.Voltage v23;

      output SI.Current current "Output current";
      output SI.Conductance cond "Output conductance";

      protected
      constant Real max_exp = 50.0;
      constant SI.Current max_current = 1.0e4;
      SI.Voltage vte;
      Real max_exponent;
      Real evd;
      Real arg;
      Real evrev;
      SI.Voltage vr;

    algorithm
      if (satcur > 1.0e-101) then
          vte := Spice3.Internal.SpiceConstants.CONSTKoverQ*
            temp*ncoeff;
        max_exponent := Modelica.Math.log( max_current / satcur);
        max_exponent := min( max_exp, max_exponent);
        if (voltage >= max_exponent * vte) then
          evd     := exp( max_exponent);
          cond    := satcur * evd / vte;
          current := satcur * (evd - 1) + cond * (voltage - max_exponent * vte);
        elseif (voltage >= -3 * vte) then
          evd     := exp( voltage / vte);
            current := satcur*(evd - 1) + Spice3.Internal.SpiceConstants.CKTgmin
              *voltage;
            cond := satcur*evd/vte + Spice3.Internal.SpiceConstants.CKTgmin;
        elseif (voltage >= -v23) then
            arg := 3*vte/(voltage*Spice3.Internal.SpiceConstants.CONSTe);
          arg     := arg * arg * arg;
            current := -1.*satcur*(1 + arg) + Spice3.Internal.SpiceConstants.CKTgmin
              *voltage;
            cond := satcur*3*arg/voltage + Spice3.Internal.SpiceConstants.CKTgmin;
        else
          vr := -( v23 + voltage);
          if (vr > max_exponent * vte) then
            evd     := exp( max_exponent);
            cond    := satcur * evd / vte;
            current := -1. * (satcur * (evd - 1) + cond * (vr - max_exponent * vte));
          else
            evrev   := exp( vr / vte);
              current := -1.*satcur*evrev + Spice3.Internal.SpiceConstants.CKTgmin
                *voltage;
              cond := satcur*evrev/vte + Spice3.Internal.SpiceConstants.CKTgmin;
          end if;
        end if;
      else
        current := 0.0;
        cond    := 0.0;
      end if;

      annotation (Documentation(info="<html>
<p>This internal function calculates both the junction current and the junction conductance dependent from the given voltage.</p>
</html>"));
    end junction3;

    function junctionCapTransTime
      "Junction capacitance transittime calculation"
      extends Modelica.Icons.Function;
      input SI.Capacitance capin "Input capacitance";
      input SI.Voltage voltage "Input voltage";
      input SI.Voltage depcap;
      input Real mj;
      input Real phij;
      input SI.Voltage f1;
      input Real f2;
      input Real f3;
      input SI.Time transittime;
      input SI.Conductance conduct "Input conductance";
      input SI.Current current "Input current";

      output SI.Capacitance capout "Output capacitance";
      output SI.Charge charge "Output charge";

    algorithm
        (capout,charge) := junctionCap(
              capin,
              voltage,
              depcap,
              mj,
              phij,
              f1,
              f2,
              f3);
      capout := capout + transittime * conduct;
      charge := charge + transittime * current;

      annotation (Documentation(info="<html>
<p>This internal function calculates the capacitance and the charge dependent on the transittime.</p>
</html>"));
    end junctionCapTransTime;

    function junction2 "Junction current and conductance calculation"
      extends Modelica.Icons.Function;
      input SI.Voltage voltage "Input Voltage";
      input SI.Temp_K temp "Device Temperature";
      input Real ncoeff;
      input SI.Current satcur "Saturation current";

      output SI.Current current "Output current";
      output SI.Conductance cond "Output conductance";

      protected
      constant Real max_exp = 50.0;
      constant Real max_current = 1.0e4;
      SI.Voltage vte;
      Real max_exponent;
      Real evd;
      Real arg;

    algorithm
      if (satcur > 1.0e-101) then
          vte := Spice3.Internal.SpiceConstants.CONSTKoverQ*
            temp*ncoeff;
        max_exponent := Modelica.Math.log( max_current / satcur);
        max_exponent := min( max_exp, max_exponent);
        if (voltage >= max_exponent * vte) then
          evd     := exp( max_exponent);
          cond    := satcur * evd / vte;
          current := satcur * (evd - 1) + cond * (voltage - max_exponent * vte);

        elseif (voltage >= -5 * vte) then
          evd     := exp( voltage / vte);
            current := satcur*(evd - 1) + Spice3.Internal.SpiceConstants.CKTgmin
              *voltage;
            cond := satcur*evd/vte + Spice3.Internal.SpiceConstants.CKTgmin;
        else
            arg := 3*vte/(voltage*Spice3.Internal.SpiceConstants.CONSTe);
          arg     := arg * arg * arg;
            current := -1*satcur*(1 + arg) + Spice3.Internal.SpiceConstants.CKTgmin
              *voltage;
            cond := satcur*3*arg/voltage + Spice3.Internal.SpiceConstants.CKTgmin;
        end if;
      else
        current := 0.0;
        cond    := 0.0;
      end if;

      annotation (Documentation(info="<html>
<p>This internal function calculates both the junction current and the junction conductance dependent from the given voltage.</p>
</html>"));
    end junction2;

    function resDepTemp "Temperature dependent conductance"
      extends Modelica.Icons.Function;
      input SI.Resistance resist "Input resistance";
      input SI.Temp_K temp "Device temperature";
      input SI.Temp_K tnom "Nominal temperature";
      input Real tc1;
      input Real tc2;

      output SI.Conductance conduct "Output conductance";
      output Real dCond_dTemp "Output value";

      protected
      Real difference;
      Real factor;

    algorithm
      difference := temp - tnom;
      factor := 1.0 + tc1 * difference + tc2 * difference * difference;
      conduct := 1.0 /(resist * factor);
      dCond_dTemp := (tc1 + 2 * tc2 * difference) * conduct * conduct;

      annotation (Documentation(info="<html>
<p>This internal function calculates the conductance in dependency from the temperature.</p>
</html>"));
    end resDepTemp;

    function resDepGeom "Resistance dependent from width and narrow"
    extends Modelica.Icons.Function;
    input Real rsh "Input sheet resistance";
    input SI.Length width "Input transistor width";
    input SI.Length length "Input transistor length";
    input SI.Length narrow "Input narrow";

    output Real out "Output value";

    algorithm
      out :=rsh*(length - narrow)/(width - narrow);

      annotation (Documentation(info="<html>
<p>This internal function calculates the resistance in dependency from the geometrical values (width, narrow) and resistivity.</p>
</html>"));
    end resDepGeom;

    function saturationCurDepTempSPICE3JFET
      "Temperature dependency of saturation current"
      extends Modelica.Icons.Function;
      input SI.Current satcur0 "Saturation current";
      input SI.Temp_K temp "Device Temperature";
      input SI.Temp_K tnom "Nominal Temperature";

      output SI.Current ret "Output value";

      protected
      SI.Voltage vt;

    algorithm
      vt := Spice3.Internal.SpiceConstants.CONSTKoverQ*temp;
      ret := satcur0  * exp( (temp / tnom - 1) * 1.11 / vt);

    end saturationCurDepTempSPICE3JFET;

    function capDepGeom "Capacitance dependent from width and narrow"
      extends Modelica.Icons.Function;
      input SI.CapacitancePerArea cap0 "Junction bottom capacitance";
      input SI.Permittivity capsw0 "Junction sidewall capacitance";
      input SI.Length  width "Input capacitor width";
      input SI.Length  length "Input capacitor length";
      input SI.Length  narrow "Input narrow";

      output SI.Capacitance out "Output value";

    algorithm
      out := cap0 * (width - narrow) * (length - narrow)
             + capsw0 * 2 * ((length - narrow) + (width - narrow));

    end capDepGeom;

    function energyGapDepTemp "Temperature dependency of energy gap"
      extends Modelica.Icons.Function;
        input SI.Temp_K temp "Temperature";
        output SI.GapEnergy ret "Output Gap Energy";

    algorithm
        ret := Spice3.Internal.MaterialParameters.EnergyGapSi - (
          Spice3.Internal.MaterialParameters.FirstBandCorrFactorSi
          *temp*temp)/(temp + Spice3.Internal.MaterialParameters.SecondBandCorrFactorSi);

        annotation (Documentation(info="<html>
<p>This internal function calculates the temperature dependent energy gap based on the actual temperature, and two coefficients given as input to the function.</p>
</html>"));
    end energyGapDepTemp;

    function junction2SPICE3BJT "Junction current and conductance calculation"
      extends Modelica.Icons.Function;
      input SI.Voltage voltage "Input Voltage";
      input SI.Temp_K temp "Device Temperature";
      input Real ncoeff1;
      input Real ncoeff2;
      input SI.Current satcur1 "Saturation current";
      input SI.Current satcur2 "Saturation current";

      output SI.Current current1 "Output current";
      output SI.Conductance cond1 "Output conductance";
      output SI.Current current2 "Output current";
      output SI.Conductance cond2 "Output conductance";

      protected
      SI.Voltage vte;
      SI.Voltage vtn;
      Real evd;

    algorithm
        vtn := Spice3.Internal.SpiceConstants.CONSTKoverQ*
          temp*ncoeff1;
        vte := Spice3.Internal.SpiceConstants.CONSTKoverQ*
          temp*ncoeff2;
      if (voltage > -5 * vtn) then
        evd     := exp( voltage / vtn);
          current1 := satcur1*(evd - 1) + Spice3.Internal.SpiceConstants.CKTgmin
            *voltage;
          cond1 := satcur1*evd/vtn + Spice3.Internal.SpiceConstants.CKTgmin;
        if (satcur2 == 0) then
          current2 := 0;
          cond2    := 0;
        else
          evd      := exp(voltage/vte);
          current2 := satcur2 * (evd-1);
          cond2    := satcur2 * evd / vte;
        end if;
      else
          cond1 := -satcur1/voltage + Spice3.Internal.SpiceConstants.CKTgmin;
        current1 := cond1 * voltage;
        cond2    := -satcur2/voltage;
        current2 := -satcur2;
      end if;

    end junction2SPICE3BJT;

    function energyGapDepTemp_old "Temperature dependency of energy gap"
      extends Modelica.Icons.Function;
      input SI.Temp_K temp "Temperature";
      output SI.Voltage ret "Output voltage";

      protected
       SI.Voltage gap0 =   1.16;
       Real coeff1( final unit = "V/K") = 7.02e-4;
       SI.Temp_K coeff2 = 1108.0;

    algorithm
      ret := gap0 - (coeff1 * temp * temp) / (temp + coeff2);

      annotation (Documentation(info="<html>
<p>This internal function calculates the temperature dependent energy gap based on the actual temperature, and two coefficients given as input to the function.</p>
</html>"));
    end energyGapDepTemp_old;
      annotation (Documentation(info="<html>
<p>The package Equation contains functions that are needed to model the semiconductor models. Some of these functions are used by several semiconductor models.</p>
</html>"));
  end Functions;

    package SpiceRoot "Basic records and functions"
      extends Modelica.Icons.InternalPackage;

      record SpiceRoot "Data for insertion to matrices"
        extends Modelica.Icons.Record;
        SI.Current[6] m_pCurrentValues(   start = zeros(6));
        Real[36] m_pResJacobi(      start = zeros(36));
        Real[36] m_pCapJacobi(      start = zeros(36));

        annotation (Documentation(info="<html>
<p>This data are to collect intermediate results to be inserted into SPICE-like matrices for linear systems of equations.</p>
</html>"));
      end SpiceRoot;

      function useInitialConditions "Initial condition handling"
        extends Modelica.Icons.Function;
        output Boolean ret;

      algorithm
        ret := false;

        annotation (Documentation(info="<html>
<p>This function useInitialConditions appoints whether the initial conditions that are given in the description are used or not.</p>
</html>"));
      end useInitialConditions;

      function initJunctionVoltages
        "Choice of junction voltage handling, obsolete, use initJunctionVoltagesRevised"
        extends Modelica.Icons.Function;
        extends Modelica.Icons.ObsoleteModel;

        output Boolean ret;
      algorithm

        ret := false;

        annotation (Documentation(info="<html>
<p>This internal function is provided to choose the junction voltage handling which is at the current library version fixed to false.</p>
</html>"),
        obsolete = "Obsolete function - use Modelica.Electrical.Spice3.Internal.SpiceRoot.initJunctionVoltagesRevised instead");
      end initJunctionVoltages;

      function limitJunctionVoltage
        "Limitation of junction voltage, obsolete, use limitJunctionVoltageRevised"
        extends Modelica.Icons.Function;
        extends Modelica.Icons.ObsoleteModel;

        input SI.Voltage voltage "Input voltage";

        output SI.Voltage ret;

      algorithm
        ret := voltage;

        annotation (Documentation(info="<html>
<p>This internal function is provided to limit the junction voltage which is at the current library version fixed to false.</p>
</html>"),
        obsolete = "Obsolete function - use Modelica.Electrical.Spice3.Internal.SpiceRoot.limitJunctionVoltageRevised instead");
      end limitJunctionVoltage;

      function limitJunctionVoltageRevised "Limitation of junction voltage"
        extends Modelica.Icons.Function;
        input SI.Voltage voltage "Input voltage";

        output SI.Voltage ret;

      algorithm
        ret := voltage;

        annotation (Documentation(info="<html>
<p>This internal function is provided to limit the junction voltage which is at the current library version fixed to false.</p>
</html>"));
      end limitJunctionVoltageRevised;

      function initJunctionVoltagesRevised
        "Choice of junction voltage handling"
        extends Modelica.Icons.Function;
        output Boolean ret;
      algorithm

        ret := false;

        annotation (Documentation(info="<html>
<p>This internal function is provided to choose the junction voltage handling which is at the current library version fixed to false.</p>
</html>"));
      end initJunctionVoltagesRevised;
      annotation (Documentation(info="<html>
<p>The package SpiceRoot contains basic records and functions that are needed in SPICE3.</p>
</html>"));
    end SpiceRoot;

    package Model "Device Temperature"
      extends Modelica.Icons.InternalPackage;

    record Model "Device Temperature"
      extends Modelica.Icons.Record;
      SI.Temp_K m_dTemp( start = SpiceConstants.CKTnomTemp)
          "TEMP, Device Temperature";
        annotation (Documentation(info="<html>
<p>The record Model includes the device temperature which has a default value of 27&deg;C.</p>
</html>"));
    end Model;

      annotation (Documentation(info="<html>
<p>The package Model contains the record Model that includes the device temperature.</p>
</html>"));
    end Model;

    package Mosfet "Functions and records for MOSFETs"
      extends Modelica.Icons.InternalPackage;

      record Mosfet "Record for Mosfet parameters"
        extends Spice3.Internal.Model.Model;

        SI.Length m_len(start = 1e-4) "L, length of channel region";
        SI.Length m_width(           start = 1e-4) "W, width of channel region";
        SI.Area m_drainArea(       start=
              Spice3.Internal.SpiceConstants.CKTdefaultMosAD)
          "AD, area of drain diffusion";
        SI.Area m_sourceArea(      start=
              Spice3.Internal.SpiceConstants.CKTdefaultMosAS)
          "AS, area of source diffusion";
        Real m_drainSquares(    start = 1.0) "NRD, length of drain in squares";
        Real m_sourceSquares(   start = 1.0) "NRS, length of source in squares";
        SI.Length m_drainPerimeter(  start = 0.0) "PD, Drain perimeter";
        SI.Length m_sourcePerimeter( start = 0.0) "PS, Source perimeter";
        SI.Voltage m_dICVDS(          start = 0.0)
          "IC_VDS, Initial D-S voltage";
        Real m_dICVDSIsGiven "IC_VDS, IsGivenValue";
        SI.Voltage m_dICVGS(          start = 0.0)
          "IC_VGS, Initial G-S voltage";
        Real m_dICVGSIsGiven "IC_VGS, IsGivenValue";
        SI.Voltage m_dICVBS(          start = 0.0)
          "IC_VBS, Initial B-S voltage";
        Real m_dICVBSIsGiven "IC_VBS, IsGivenValue";
        Integer m_off(          start = 0)
          "Device initially off, non-zero to indicate device is off for dc analysis";

      //----------------------obsolete-----------------------------------
        Integer m_bPMOS(        start = 0) "P type MOSFET model";
        Integer m_nLevel(       start = 1) "MOS model level";
        SI.Length m_drainPerimiter(  start = 0.0) "PD, Drain perimeter";
        SI.Length m_sourcePerimiter( start = 0.0) "PS, Source perimeter";
      //-----------------------------------------------------------------
        Boolean m_uic;

        annotation (Documentation(info="<html>
<p>This record Mosfet contains parameters that are used for all types of Mosfet transistors in SPICE3.</p>
</html>"));
      end Mosfet;

      record MosfetModelLineParams "Record for Mosfet model line parameters"
        extends Modelica.Icons.Record;
         Real m_jctSatCurDensity(           start = 0.0)
          "JS, Bulk jct. sat. current density, input - use tSatCurDens";
         SI.Resistance m_sheetResistance(            start = 0.0)
          "RSH, Sheet resistance";
         Real m_bulkJctPotential(           start = 0.8)
          "PB, Bulk junction potential, input - use tBulkPot";
         SI.LinearTemperatureCoefficient m_bulkJctBotGradingCoeff(     start = 0.5)
          "MJ, Bottom grading coefficient";    //unit checked by maj
         SI.LinearTemperatureCoefficient m_bulkJctSideGradingCoeff(    start = 0.5)
          "MJSW, Side grading coefficient";    //unit checked by maj
         Real m_oxideThickness(             start = 1.0e-7)
          "TOX, Oxide thickness unit: micron";
       //--------------------------obsolete------------------------
         Real m_oxideThicknessIsGiven "TOX, IsGiven value";
      //-----------------------------------------------------------
         Real m_gateSourceOverlapCapFactor( start= 0.0)
          "CGS0, Gate-source overlap cap";
         Real m_gateDrainOverlapCapFactor( start= 0.0)
          "CGD0, Gate-drain overlap cap";
         Real m_gateBulkOverlapCapFactor( start= 0.0)
          "CGB0, Gate-bulk overlap cap";
         Real m_fNcoef(                     start = 0.0)
          "KF, Flicker noise coefficient";
         Real m_fNexp(                      start = 1.0)
          "AF, Flicker noise exponent";
        Real m_mjswIsGiven "MJSW, IsGivenValue";
        Real m_cgsoIsGiven "CGSO, IsGivenValue";
        Real m_cgdoIsGiven "CGDO, IsGivenValue";
        Real m_cgboIsGiven "CGBO, IsGivenValue";
        Real m_pbIsGiven "PB, IsGivenValue";

        annotation (Documentation(info="<html>
<p>This record MosfetModelLineParams contains the model line parameters that are used for all kinds of Mosfet transistors in SPICE3.</p>
</html>"));
      end MosfetModelLineParams;

      record MosfetModelLine "Type of the transistor"
        extends Modelica.Icons.Record;
        Integer m_type(   start = 1) "device type : 1 = n,  -1 = p";

        annotation (Documentation(info="<html>
<p>This record contains only one variable and it provides the information on the transistor type (PMOS or nmos).</p>
</html>"));
      end MosfetModelLine;

      record MosfetCalc "Mosfet Variables"
        extends Modelica.Icons.Record;
        SI.Voltage m_vds "Vds, Drain-Source voltage";
        SI.Voltage m_vgs "Vgs, Gate-Source voltage";
        SI.Voltage m_vbs "Vbs, Bulk-Source voltage";
        SI.Current m_cbs "Ibs, B-S junction current";
        SI.Conductance m_gbs "Gbs, Bulk-Source conductance";
        SI.Current m_cbd "Ibd, B-D junction current";
        SI.Conductance m_gbd "Gbd, Bulk-Drain conductance";
        SI.Current m_cdrain "Ids";
        SI.Conductance m_gds "Gds, Drain-Source conductance";
        SI.Transconductance m_gm "Gm, Transconductance";
        SI.Transconductance m_gmbs "Gmbs, Bulk-Source transconductance";
        SI.Capacitance m_capbsb "Cbsb";
        SI.Charge m_chargebsb "Qbsb";
        SI.Capacitance m_capbss "Cbss";
        SI.Charge m_chargebss "Qbss";
        SI.Capacitance m_capbdb "Cbdb";
        SI.Charge m_chargebdb "Qbdb";
        SI.Capacitance m_capbds "Cbds";
        SI.Charge m_chargebds "Qbds";
        Real m_Beta "Beta";
        SI.Capacitance m_capGSovl "Cgso, Gate-source overlap cap.";
        SI.Capacitance m_capGDovl "Cgdo, Gate-drain overlap cap.";
        SI.Capacitance m_capGBovl "Cgbo, Gate-bulk overlap cap.";
        SI.Capacitance m_capOx "Cox";
        SI.Voltage m_von "Von, Turn-on voltage";
        SI.Voltage m_vdsat "Vdsat";
        Integer m_mode(start = 1) "Mode";
        SI.Length m_lEff;
        SI.Resistance m_sourceResistance "Rs";
        SI.Resistance m_drainResistance "Rd";

        annotation (Documentation(info="<html>
<p>This record MosfetCalc contains variables that are needed for calculation within modeling the semiconductor models.</p>
</html>"));
      end MosfetCalc;

      function mosfetInitEquations "MOSFET initial precalculations"
        extends Modelica.Icons.Function;
        input Mosfet in_m "Input parameter set";

        output Mosfet out_m "Changed parameter set";

      algorithm
        out_m := in_m;

        if (out_m.m_drainSquares == 0) then
          out_m.m_drainSquares  := 1.;
        end if;
        if (out_m.m_sourceSquares == 0) then
          out_m.m_sourceSquares := 1.;
        end if;

        annotation (Documentation(info="<html>
<p>This function initially precalculates some values for transistor area which can be used for all transistor models.</p>
</html>"));
      end mosfetInitEquations;

      function mosfetModelLineInitEquations "Type transcription"
        extends Modelica.Icons.Function;
        input Mosfet in_m "Input parameter set";

        output MosfetModelLine out_ml "Changed parameter set";

      algorithm
        out_ml.m_type := if (in_m.m_bPMOS > 0.5) then -1 else 1;
        // -1: PMOS ; 1: NMOS

        annotation (Documentation(info="<html>
<p>In this function during the initialization phase the transistor type is transcribed to another parameter for further usage.</p>
</html>"));
      end mosfetModelLineInitEquations;

      function getNumberOfElectricalPins "Number of Pins"
        extends Modelica.Icons.Function;
        output Integer ret "Number of pins";

      algorithm
        ret := 4;
        annotation (Documentation(info="<html>
<p>This function getNumberOfElectricalPins identifies the number of electrical pins. At the current library version it is fixed to 4.</p>
</html>"));
      end getNumberOfElectricalPins;

      function mosfetRenameParametersDev
        "Device parameter renaming to internal names"
        extends Modelica.Icons.Function;
        input SI.Length  W "Channel Width";
        input SI.Length  L "Channel Length";
        input SI.Area AD "Area of the drain diffusion";
        input SI.Area AS "Area of the source diffusion";
        input SI.Length  PD "Perimeter of the drain junction";
        input SI.Length  PS "Perimeter of the source junction";
        input Real NRD "Number of squares of the drain diffusions";
        input Real NRS "Number of squares of the source diffusions";
        input Integer OFF
          "Optional initial condition: 0 - IC not used, 1 - IC used, not implemented yet";
        input SI.Voltage IC_VDS
          "Initial condition value VDS, not implemented yet";
        input SI.Voltage IC_VGS
          "Initial condition value VGS, not implemented yet";
        input SI.Voltage IC_VBS
          "Initial condition value VBS, not implemented yet";
        input Boolean UIC "Use initial condition, UIC";
        input SI.Temp_C TEMP "Temperature";

        output Modelica.Electrical.Spice3.Internal.Mosfet.Mosfet dev
          "Output record Mosfet";

      algorithm
        /*device parameters*/
        dev.m_len             := L "L, length of channel region";
        dev.m_width           := W "W, width of channel region";
        dev.m_drainArea       := AD "AD, area of drain diffusion";
        dev.m_sourceArea      := AS "AS, area of source diffusion";
        dev.m_drainSquares    := NRD "NRD, length of drain in squares";
        dev.m_sourceSquares   := NRS "NRS, length of source in squares";
        dev.m_drainPerimeter  := PD "PD, Drain perimeter";
        dev.m_sourcePerimeter := PS "PS, Source perimeter";

        dev.m_dICVDSIsGiven := if (IC_VDS > -1e40) then 1 else 0
          "IC_VDS IsGivenValue";
        dev.m_dICVDS := if (IC_VDS > -1e40) then IC_VDS else 0
          "Initial condition of VDS";

        dev.m_dICVGSIsGiven := if (IC_VGS > -1e40) then 1 else 0
          "IC_VGS IsGivenValue";
        dev.m_dICVGS := if (IC_VGS > -1e40) then IC_VGS else 0
          "Initial condition of VGS";

        dev.m_dICVBSIsGiven := if (IC_VBS > -1e40) then 1 else 0
          "IC_VBS IsGivenValue";
        dev.m_dICVBS := if (IC_VBS > -1e40) then IC_VBS else 0
          "Initial condition of VBS";

        dev.m_off   := OFF "Non-zero to indicate device is off for dc analysis";
        dev.m_uic   := UIC "Use initial conditions";
        dev.m_dTemp := TEMP + Spice3.Internal.SpiceConstants.CONSTCtoK
          "Device temperature";

        annotation (Documentation(info="<html>
<pre>This function mos1RenameParametersDev assigns the external (given by the user) device parameters to the internal parameters. It also does the analysis of the IsGiven values (level 1).</pre>
</html>"));
      end mosfetRenameParametersDev;

      annotation (Documentation(info="<html>
<p>The package Mosfet contains all functions and records that are used for all types of Mosfet transistors in SPICE3.</p>
</html>"));
    end Mosfet;

    package Mos "Records and functions for MOSFETs level 1,2,3,6"
      extends Modelica.Icons.InternalPackage;

      record MosModelLineParams
        "Record for Mosfet model line parameters (for level 1, 2, 3 and 6)"
        extends Spice3.Internal.Mosfet.MosfetModelLineParams;

         Real m_oxideCapFactor(      start = 0.0);
         SI.Voltage m_vt0(                 start = 0.0)
          "VTO, Threshold voltage";
         Real m_vtOIsGiven "VTO IsGivenValue";
         SI.Capacitance m_capBD(               start = 0.0)
          "CBD, B-D junction capacitance";
         Real m_capBDIsGiven "CapBD IsGivenValue";
         SI.Capacitance m_capBS(               start = 0.0)
          "CBS, B-S junction capacitance";
         Real m_capBSIsGiven "CapBS IsGivenValue";
         SI.CapacitancePerArea m_bulkCapFactor(       start = 0.0)
          "CJ, Bottom junction cap per area";
         Real m_bulkCapFactorIsGiven "Bulk cap factor IsGivenValue";
         SI.Permittivity m_sideWallCapFactor(   start = 0.0)
          "CJSW, Side grading coefficient";
         Real m_fwdCapDepCoeff(      start = 0.5)
          "FC, Forward bias junction fit parameter";
         SI.Voltage m_phi(                 start = 0.6)
          "PHI, Surface potential";
         Real m_phiIsGiven "Phi IsGivenValue";
         SI.Voltage m_gamma(               start = 0.0)
          "GAMMA, Bulk threshold parameter";
         Real m_gammaIsGiven "Gamma IsGivenValue";
         SI.InversePotential m_lambda "Channel-length modulation";
         Real m_substrateDoping(start = 0.0) "NSUB, Substrate doping";
         Real m_substrateDopingIsGiven "Substrate doping IsGivenValue";
         Real m_gateType(start = 1.0) "TPG, Gate type";
         SI.Conversions.NonSIunits.PerArea_cm
          m_surfaceStateDensity(start = 0.0) "NSS, Gate type";
         //-----------------obsolete--------------------------------------------
         Real m_surfaceStateDensityIsGiven(start=0)
          "surfaceStateDensityIsGivenValue";
         //---------------------------------------------------------------------
         SI.Conversions.NonSIunits.Area_cmPerVoltageSecond
          m_surfaceMobility( start = 600.0) "UO, Surface mobility";
         SI.Length m_latDiff(             start = 0.0) "LD, Lateral diffusion";
         SI.Current m_jctSatCur(           start = 1.0e-14)
          "IS, Bulk junction sat. current";
         SI.Resistance m_drainResistance(     start = 0)
          "RD, Drain ohmic resistance";
         Real m_drainResistanceIsGiven "Drain resistance IsGivenValue";
         SI.Resistance m_sourceResistance(    start = 0)
          "RS, Source ohmic resistance";
         Real m_sourceResistanceIsGiven "Source resistance IsGivenValue";
         SI.Transconductance m_transconductance "input - use tTransconductance";
         Real m_transconductanceIsGiven "Transconductance IsGivenValue";
         SI.Temp_K m_tnom(start=Spice3.Internal.SpiceConstants.CKTnomTemp)
          "TNOM, Parameter measurement temperature";

        annotation (Documentation(info="<html>
<p>This record MosModelLineParams contains the model line parameters that are used for the MOSFET transistors level 1, 2, 3 and 6 in SPICE3.</p>
</html>"));
      end MosModelLineParams;

      record MosModelLineVariables
        "Record for Mosfet model line variables (for level 1)"
        extends Modelica.Icons.Record;
        Real m_oxideCapFactor;
        SI.Voltage m_vt0;
        SI.Voltage m_phi;
        Real m_gamma;
        SI.Transconductance m_transconductance;

        annotation (Documentation(info="<html>
<p>This record MosModelLineVariables contains the model line variables that are used for the MOSFET transistors level 1 SPICE3.</p>
</html>"));
      end MosModelLineVariables;

      record MosCalc "Further MOSFET variables (for level 1, 2, 3 and 6)"
        extends Spice3.Internal.Mosfet.MosfetCalc;

        SI.Transconductance m_tTransconductance(start=0.);
        SI.Conversions.NonSIunits.Area_cmPerVoltageSecond m_tSurfMob( start = 0.);
        SI.Voltage m_tPhi(start=0.7);
        SI.Voltage m_tVto(start=1.);
        SI.CurrentDensity m_tSatCurDens( start = 0.);
        SI.Current m_tDrainSatCur(start=0.);
        SI.Current m_tSourceSatCur(start=0.);
        SI.Capacitance m_tCBDb(start=0.);
        SI.Capacitance m_tCBDs(start=0.);
        SI.Capacitance m_tCBSb(start=0.);
        SI.Capacitance m_tCBSs(start=0.);
        SI.CapacitancePerArea m_tCj( start = 0.);
        SI.Permittivity m_tCjsw( start = 0.);
        SI.Voltage m_tBulkPot(start=0.7);
        SI.Voltage m_tDepCap( start = 0.35);
        SI.Voltage m_tVbi(start=1.);
        SI.Voltage m_VBScrit(start=0.7);
        SI.Voltage m_VBDcrit(start=0.7);
        SI.Voltage m_f1b( start = 0.);
        Real m_f2b( start = 0.);
        Real m_f3b( start = 0.);
        SI.Voltage m_f1s( start = 0.);
        Real m_f2s( start = 0.);
        Real m_f3s( start = 0.);
        SI.Voltage m_dVt( start = 0.);

        SI.Capacitance m_capgd(start=0.);
        SI.Capacitance m_capgs(start=0.);
        SI.Capacitance m_capgb(start=0.);
        SI.Charge m_qgs(start=0.);
        SI.Charge m_qgd(start=0.);
        SI.Charge m_qgb(start=0.);

        annotation (Documentation(info="<html>
<pre>This record MosCalc contains further MOSFET variables (for level 1, 2, 3 and 6).</pre>
</html>"));
      end MosCalc;

      record DEVqmeyer "Meyer capacities and charge"
        extends Modelica.Icons.Record;
        SI.Capacitance qm_capgb(  start = 0);
        SI.Capacitance qm_capgs(  start = 0);
        SI.Capacitance qm_capgd(  start = 0);
        SI.Charge qm_qgs(  start = 0);
        SI.Charge qm_qgb(  start = 0);
        SI.Charge qm_qgd(  start = 0);
        SI.Voltage qm_vgs(  start = 0);
        SI.Voltage qm_vgb(  start = 0);
        SI.Voltage qm_vgd(  start = 0);

        annotation (Documentation(info="<html>
<p>This record DEVqmeyer contains values that are needed for the calculation of the Meyer capacities and charge.</p>
</html>"));
      end DEVqmeyer;

      record CurrrentsCapacitances "Currents and Capacities"
        extends Modelica.Icons.Record;
        SI.Current idrain( start = 0);
        SI.Current iBD( start = 0);
        SI.Current iBS( start = 0);
        SI.Capacitance cGS( start = 0);
        SI.Capacitance cGB( start = 0);
        SI.Capacitance cGD( start = 0);
        SI.Capacitance cBS( start = 0);
        SI.Capacitance cBD( start = 0);
        SI.Capacitance m_capgd;

        annotation (Documentation(info="<html>
<p>This record CurrentsCapacities contains values for the currents and the capacities inside the MOSFET models level 1, 2, 3 and 6.</p>
</html>"));
      end CurrrentsCapacitances;

      function mosCalcInitEquations "Mosfet initial precalculations (level 1)"
        extends Modelica.Icons.Function;
        input Spice3.Internal.Mos1.Mos1ModelLineParams in_p
          "Input record model line parameters for MOS1";
        input Spice3.Internal.SpiceConstants in_C
          "Input record SPICE constants";
        input MosModelLineVariables in_vp "Input record model line variables";
        input Spice3.Internal.Mosfet.Mosfet in_m
          "Input record MOSFET parameters";

        output Spice3.Internal.Mos1.Mos1Calc out_c
          "Output record Mos1 calculated values";

      algorithm
         out_c.m_drainResistance := if
                                      (in_p.m_drainResistanceIsGiven > 0.5) then
             in_p.m_drainResistance else
             in_p.m_sheetResistance * in_m.m_drainSquares;

         out_c.m_sourceResistance := if  (in_p.m_sourceResistanceIsGiven > 0.5) then
             in_p.m_sourceResistance else
             in_p.m_sheetResistance * in_m.m_sourceSquares;

        out_c.m_lEff := in_m.m_len - 2 * in_p.m_latDiff;

        if ( abs( out_c.m_lEff) < 1e-18) then
          out_c.m_lEff := 1e-6;
        end if;
        out_c.m_capGSovl := in_p.m_gateSourceOverlapCapFactor * in_m.m_width;
        out_c.m_capGDovl := in_p.m_gateDrainOverlapCapFactor * in_m.m_width;

        out_c.m_capGBovl := in_p.m_gateBulkOverlapCapFactor * out_c.m_lEff;
        out_c.m_capOx    := in_vp.m_oxideCapFactor * out_c.m_lEff * in_m.m_width;

        out_c.m_tTransconductance := 0;
        out_c.m_tSurfMob := 0;
        out_c.m_tPhi := 0.7;
        out_c.m_tVto := 1.;
        out_c.m_tSatCurDens := 0;
        out_c.m_tDrainSatCur := 0;
        out_c.m_tSourceSatCur := 0;
        out_c.m_tCBDb := 0;
        out_c.m_tCBDs := 0;
        out_c.m_tCBSb := 0;
        out_c.m_tCBSs := 0;
        out_c.m_tCj := 0;
        out_c.m_tCjsw := 0;
        out_c.m_tBulkPot := 0.7;
        out_c.m_tDepCap := 0.35;
        out_c.m_tVbi := 1.;
        out_c.m_VBScrit := 0.7;
        out_c.m_VBDcrit := 0.7;
        out_c.m_f1b := 0;
        out_c.m_f2b := 0;
        out_c.m_f3b := 0;
        out_c.m_f1s := 0;
        out_c.m_f2s := 0;
        out_c.m_f3s := 0;
        out_c.m_dVt := 0;

        out_c.m_capgd := 0;
        out_c.m_capgs := 0;
        out_c.m_capgb := 0;
        out_c.m_qgs := 0;
        out_c.m_qgd := 0;
        out_c.m_qgb := 0;

        out_c.m_vds := 0;
        out_c.m_vgs := 0;
        out_c.m_vbs := 0;
        out_c.m_cbs := 0;
        out_c.m_gbs := 0;
        out_c.m_cbd := 0;
        out_c.m_gbd := 0;
        out_c.m_cdrain := 0;
        out_c.m_gds := 0;
        out_c.m_gm := 0;
        out_c.m_gmbs := 0;
        out_c.m_capbsb := 0;
        out_c.m_chargebsb := 0;
        out_c.m_capbss := 0;
        out_c.m_chargebss := 0;
        out_c.m_capbdb := 0;
        out_c.m_chargebdb := 0;
        out_c.m_capbds := 0;
        out_c.m_chargebds := 0;
        out_c.m_Beta := 0;

        out_c.m_von := 0;
        out_c.m_vdsat := 0;
        out_c.m_mode := 1;

        annotation (Documentation(info="<html>
<p>This function mosCalcInitEquations does the initial precalculation of the MOSFET parameters (level 1).</p>
</html>"));
      end mosCalcInitEquations;

      function mosCalcCalcTempDependencies
        "Precalculation relating to temperature"
        extends Modelica.Icons.Function;
        input Spice3.Internal.Mos1.Mos1ModelLineParams in_p
          "Input record model line parameters for MOS1";
        input Spice3.Internal.SpiceConstants in_C
          "Input record SPICE constants";
        input MosModelLineVariables in_vp "Input record model line variables";
        input Spice3.Internal.Mosfet.Mosfet in_m
          "Input record MOSFET parameters";
        input Spice3.Internal.Mos1.Mos1Calc in_c "Input record Mos1Calc";
        input Integer in_m_type "Type of MOS transistor";

        output Spice3.Internal.Mos1.Mos1Calc out_c
          "Output record with calculated values";

      protected
         Real ratio;
         Real ratio4;
         Real res;

      algorithm
        out_c := in_c;

        ratio                     := in_m.m_dTemp / in_p.m_tnom;
        ratio4                    := ratio * sqrt(ratio);
        out_c.m_tTransconductance := in_vp.m_transconductance / ratio4;
        out_c.m_Beta              := out_c.m_tTransconductance * in_m.m_width / out_c.m_lEff;

        out_c.m_tSurfMob          := in_p.m_surfaceMobility / ratio4;

        out_c.m_tPhi :=
          Spice3.Internal.Functions.junctionPotDepTemp(
                in_vp.m_phi,
                in_m.m_dTemp,
                in_p.m_tnom);

        out_c.m_tVbi := in_vp.m_vt0 - in_m_type*(in_vp.m_gamma*sqrt(in_vp.m_phi))
           + 0.5*(Spice3.Internal.Functions.energyGapDepTemp_old(
          in_p.m_tnom) -
          Spice3.Internal.Functions.energyGapDepTemp_old(               in_m.m_dTemp))
           + in_m_type*0.5*(out_c.m_tPhi - in_vp.m_phi);
        out_c.m_tVto := out_c.m_tVbi + in_m_type * in_vp.m_gamma * sqrt(out_c.m_tPhi);

        out_c.m_tBulkPot := Spice3.Internal.Functions.junctionPotDepTemp(
                in_p.m_bulkJctPotential,
                in_m.m_dTemp,
                in_p.m_tnom);
        out_c.m_tDepCap  := in_p.m_fwdCapDepCoeff * out_c.m_tBulkPot;

       if (in_p.m_jctSatCurDensity == 0.0 or in_m.m_sourceArea == 0.0 or in_m.m_drainArea == 0.0) then
          out_c.m_tDrainSatCur :=
            Spice3.Internal.Functions.saturationCurDepTempSPICE3MOSFET(
                  in_p.m_jctSatCur,
                  in_m.m_dTemp,
                  in_p.m_tnom);
          out_c.m_tSourceSatCur := out_c.m_tDrainSatCur;
          out_c.m_VBScrit :=
            Spice3.Internal.Functions.junctionVCrit(
                  in_m.m_dTemp,
                  1.0,
                  out_c.m_tSourceSatCur);
          out_c.m_VBDcrit       := out_c.m_VBScrit;
        else
          out_c.m_tSatCurDens :=
            Spice3.Internal.Functions.saturationCurDepTempSPICE3MOSFET(
                  in_p.m_jctSatCurDensity,
                  in_m.m_dTemp,
                  in_p.m_tnom);
          out_c.m_tDrainSatCur  := out_c.m_tSatCurDens * in_m.m_drainArea;
          out_c.m_tSourceSatCur := out_c.m_tSatCurDens * in_m.m_sourceArea;
          out_c.m_VBScrit :=
            Spice3.Internal.Functions.junctionVCrit(
                  in_m.m_dTemp,
                  1.0,
                  out_c.m_tSourceSatCur);
          out_c.m_VBDcrit :=
            Spice3.Internal.Functions.junctionVCrit(
                  in_m.m_dTemp,
                  1.0,
                  out_c.m_tDrainSatCur);
        end if;

        if ( not (in_p.m_capBDIsGiven > 0.5) or not (in_p.m_capBSIsGiven > 0.5)) then
          (res,out_c.m_tCj) :=
            Spice3.Internal.Functions.junctionParamDepTempSPICE3(
                  in_p.m_bulkJctPotential,
                  in_p.m_bulkCapFactor,
                  in_p.m_bulkJctBotGradingCoeff,
                  in_m.m_dTemp,
                  in_p.m_tnom);
          (res,out_c.m_tCjsw) :=
            Spice3.Internal.Functions.junctionParamDepTempSPICE3(
                  in_p.m_bulkJctPotential,
                  in_p.m_sideWallCapFactor,
                  in_p.m_bulkJctSideGradingCoeff,
                  in_m.m_dTemp,
                  in_p.m_tnom);
          (out_c.m_f1s,out_c.m_f2s,out_c.m_f3s) :=
            Spice3.Internal.Functions.junctionCapCoeffs(
                  in_p.m_bulkJctSideGradingCoeff,
                  in_p.m_fwdCapDepCoeff,
                  out_c.m_tBulkPot);
        end if;

        if (in_p.m_capBDIsGiven > 0.5) then
          (res,out_c.m_tCBDb) :=
            Spice3.Internal.Functions.junctionParamDepTempSPICE3(
                  in_p.m_bulkJctPotential,
                  in_p.m_capBD,
                  in_p.m_bulkJctBotGradingCoeff,
                  in_m.m_dTemp,
                  in_p.m_tnom);
          out_c.m_tCBDs          := 0.0;
        else
          out_c.m_tCBDb := out_c.m_tCj * in_m.m_drainArea;
          out_c.m_tCBDs := out_c.m_tCjsw * in_m.m_drainPerimeter;
        end if;

        if (in_p.m_capBSIsGiven > 0.5) then
          (res,out_c.m_tCBSb) :=
            Spice3.Internal.Functions.junctionParamDepTempSPICE3(
                  in_p.m_bulkJctPotential,
                  in_p.m_capBS,
                  in_p.m_bulkJctBotGradingCoeff,
                  in_m.m_dTemp,
                  in_p.m_tnom);
          out_c.m_tCBSs          := 0.0;
        else
          out_c.m_tCBSb := out_c.m_tCj * in_m.m_sourceArea;
          out_c.m_tCBSs := out_c.m_tCjsw * in_m.m_sourcePerimeter;
        end if;
        (out_c.m_f1b,out_c.m_f2b,out_c.m_f3b) :=
          Spice3.Internal.Functions.junctionCapCoeffs(
                in_p.m_bulkJctBotGradingCoeff,
                in_p.m_fwdCapDepCoeff,
                out_c.m_tBulkPot);
        out_c.m_dVt := in_m.m_dTemp*Spice3.Internal.SpiceConstants.CONSTKoverQ;

        annotation (Documentation(info="<html>
<p>This function mosCalcCalcTempDependencies does precalculation relating to the temperature (level 1).</p>
</html>"));
      end mosCalcCalcTempDependencies;

      function mosCalcNoBypassCode
        "Calculation of currents and capacities (level 1)"
        extends Modelica.Icons.Function;
        input Spice3.Internal.Mosfet.Mosfet in_m
          "Input record MOSFET parameters";
        input Integer in_m_type "Type of MOS transistor";
        input Spice3.Internal.Mos1.Mos1Calc in_c "Input record Mos1Calc";
        input Spice3.Internal.Mos1.Mos1ModelLineParams in_p
          "Input record model line parameters for MOS1";
        input Spice3.Internal.SpiceConstants in_C
          "Input record SPICE constants";
        input MosModelLineVariables in_vp "Input record model line variables";
        input Boolean in_m_bInit;
        input SI.Voltage[4] in_m_pVoltageValues; /* gate bulk drain source */

        output CurrrentsCapacitances out_cc;

      protected
        SI.Voltage vbd;
        SI.Voltage vgd;
        SI.Voltage vgb;
        SI.Current cur;
        Integer n;
        DEVqmeyer qm;
        Spice3.Internal.Mos1.Mos1Calc int_c;
        Real hlp;

      algorithm
        int_c := in_c;
        out_cc.m_capgd := 0;

        int_c.m_vgs := in_m_type * (in_m_pVoltageValues[1] - in_m_pVoltageValues[4]); // ( G , SP)
        int_c.m_vbs := in_m_type * (in_m_pVoltageValues[2] - in_m_pVoltageValues[4]); // ( B , SP)
        int_c.m_vds := in_m_type * (in_m_pVoltageValues[3] - in_m_pVoltageValues[4]); // ( DP, SP)

        if (Spice3.Internal.SpiceRoot.useInitialConditions()) and (in_m.m_dICVBSIsGiven
             > 0.5) then
          int_c.m_vbs := in_m_type * in_m.m_dICVBS;
        elseif (
            Spice3.Internal.SpiceRoot.initJunctionVoltages()) then
          int_c.m_vbs := if (in_m.m_off >0.5) then 0. else int_c.m_VBScrit;
        end if;
        if (Spice3.Internal.SpiceRoot.useInitialConditions())
             and (in_m.m_dICVDSIsGiven > 0.5) then
          int_c.m_vds := in_m_type * in_m.m_dICVDS;
        elseif (
            Spice3.Internal.SpiceRoot.initJunctionVoltages()) then
          int_c.m_vds := if (in_m.m_off > 0.5) then 0. else (int_c.m_VBDcrit - int_c.m_VBScrit);
        end if;
        if (Spice3.Internal.SpiceRoot.useInitialConditions())
             and (in_m.m_dICVGSIsGiven > 0.5) then
          int_c.m_vgs := in_m_type * in_m.m_dICVGS;
        elseif (
            Spice3.Internal.SpiceRoot.initJunctionVoltages()) then
          if ( in_m.m_off > 0.5) then
            int_c.m_vgs := 0.;
          end if;
        end if;

        vbd := int_c.m_vbs - int_c.m_vds;
        vgd := int_c.m_vgs - int_c.m_vds;

        if ( int_c.m_vds >= 0) then
          vbd         := int_c.m_vbs - int_c.m_vds;
        else
            int_c.m_vbs := vbd + int_c.m_vds;
        end if;

        vgb := int_c.m_vgs - int_c.m_vbs;

        (int_c.m_cbd,int_c.m_gbd) :=
          Spice3.Internal.Functions.junction2SPICE3MOSFET(
                int_c.m_cbd,
                int_c.m_gbd,
                vbd,
                in_m.m_dTemp,
                1.0,
                int_c.m_tDrainSatCur);
         out_cc.iBD                 := in_m_type * int_c.m_cbd;
        (int_c.m_cbs,int_c.m_gbs) :=
          Spice3.Internal.Functions.junction2SPICE3MOSFET(
                int_c.m_cbs,
                int_c.m_gbs,
                int_c.m_vbs,
                in_m.m_dTemp,
                1.0,
                int_c.m_tSourceSatCur);
         out_cc.iBS                 := in_m_type * int_c.m_cbs;

        int_c.m_mode := if (int_c.m_vds >= 0) then 1 else -1; // 1: normal mode, -1: inverse mode

        if (int_c.m_mode == 1) then

          int_c := Spice3.Internal.Mos1.drainCur(
                  int_c.m_vbs,
                  int_c.m_vgs,
                  int_c.m_vds,
                  int_c,
                  in_p,
                  in_C,
                  in_vp,
                  in_m_type);
        else
          int_c := Spice3.Internal.Mos1.drainCur(
                  vbd,
                  vgd,
                  -int_c.m_vds,
                  int_c,
                  in_p,
                  in_C,
                  in_vp,
                  in_m_type);
        end if;

        n      := if (int_c.m_mode == 1) then 6 else 5;
        out_cc.idrain := in_m_type * int_c.m_cdrain * int_c.m_mode;

        int_c.m_capbss    := 0.0;
        int_c.m_chargebss := 0.0;
        int_c.m_capbds    := 0.0;
        int_c.m_chargebds := 0.0;
        (int_c.m_capbsb,int_c.m_chargebsb) :=
          Spice3.Internal.Functions.junctionCap(
                int_c.m_tCBSb,
                int_c.m_vbs,
                int_c.m_tDepCap,
                in_p.m_bulkJctBotGradingCoeff,
                int_c.m_tBulkPot,
                int_c.m_f1b,
                int_c.m_f2b,
                int_c.m_f3b);

        (int_c.m_capbdb,int_c.m_chargebdb) :=
          Spice3.Internal.Functions.junctionCap(
                int_c.m_tCBDb,
                vbd,
                int_c.m_tDepCap,
                in_p.m_bulkJctBotGradingCoeff,
                int_c.m_tBulkPot,
                int_c.m_f1b,
                int_c.m_f2b,
                int_c.m_f3b);

        if ( not (in_p.m_capBSIsGiven > 0.5)) then
          (int_c.m_capbss,int_c.m_chargebss) :=
            Spice3.Internal.Functions.junctionCap(
                  int_c.m_tCBSs,
                  int_c.m_vbs,
                  int_c.m_tDepCap,
                  in_p.m_bulkJctSideGradingCoeff,
                  int_c.m_tBulkPot,
                  int_c.m_f1s,
                  int_c.m_f2s,
                  int_c.m_f3s);
        end if;

        if (not (in_p.m_capBDIsGiven > 0.5)) then
          (int_c.m_capbds,int_c.m_chargebds) :=
            Spice3.Internal.Functions.junctionCap(
                  int_c.m_tCBDs,
                  vbd,
                  int_c.m_tDepCap,
                  in_p.m_bulkJctSideGradingCoeff,
                  int_c.m_tBulkPot,
                  int_c.m_f1s,
                  int_c.m_f2s,
                  int_c.m_f3s);
        end if;

        out_cc.cBS := if (in_m_bInit) then 1e-15 else (int_c.m_capbsb + int_c.m_capbss);

        out_cc.cBD := if (in_m_bInit) then 1e-15 else (int_c.m_capbdb + int_c.m_capbds);
        if (int_c.m_mode > 0) then
          qm := mosCalcDEVqmeyer( int_c.m_vgs, vgd, vgb, int_c);
        else
          qm := mosCalcDEVqmeyer( vgd, int_c.m_vgs, vgb, int_c);
          hlp := qm.qm_capgd;
          qm.qm_capgd := qm.qm_capgs;
          qm.qm_capgs := hlp;
        end if;

          int_c.m_capgd := 2 * qm.qm_capgd + int_c.m_capGDovl;
          int_c.m_capgs := 2 * qm.qm_capgs + int_c.m_capGSovl;
          int_c.m_capgb := 2 * qm.qm_capgb + int_c.m_capGBovl;

        out_cc.cGB := if (in_m_bInit) then -1e40 else int_c.m_capgb;
        out_cc.cGD := if (in_m_bInit) then -1e40 else int_c.m_capgd;
        out_cc.cGS := if (in_m_bInit) then -1e40 else int_c.m_capgs;

        annotation (Documentation(info="<html>
<p>This function NoBypassCode calculates the currents (and the capacitances) that are necessary for the currents sum in the toplevelmodel (level 1).</p>
</html>"));
      end mosCalcNoBypassCode;

      function mosCalcDEVqmeyer "Calculation of Meyer capacities"
        extends Modelica.Icons.Function;
        input SI.Voltage vgs;
        input SI.Voltage vgd;
        input SI.Voltage vgb;
        input MosCalc in_c "Input variable set";

        output DEVqmeyer out_qm "Qmeyer values";

      protected
        SI.Voltage vds;
        SI.Voltage vddif;
        SI.Voltage vddif1;
        Types.VoltageSquare vddif2;
        SI.Voltage vgst;

      algorithm
        vgst := vgs - in_c.m_von;
        if (vgst <= -in_c.m_tPhi) then
          out_qm.qm_capgb := in_c.m_capOx / 2.;
          out_qm.qm_capgs := 0.;
          out_qm.qm_capgd := 0.;
        elseif (vgst <= -in_c.m_tPhi / 2.) then
          out_qm.qm_capgb := -vgst * in_c.m_capOx / (2. * in_c.m_tPhi);
          out_qm.qm_capgs := 0.;
          out_qm.qm_capgd := 0.;
        elseif (vgst <= 0.) then
          out_qm.qm_capgb := -vgst * in_c.m_capOx / (2. * in_c.m_tPhi);
          out_qm.qm_capgs := vgst * in_c.m_capOx / (1.5 * in_c.m_tPhi) + in_c.m_capOx / 3.;
          out_qm.qm_capgd := 0.;
        else
          vds := vgs - vgd;
          if (in_c.m_vdsat <= vds) then
            out_qm.qm_capgs := in_c.m_capOx / 3.;
            out_qm.qm_capgd := 0.;
            out_qm.qm_capgb := 0.;
          else
            vddif  := 2.0 * in_c.m_vdsat - vds;
            vddif1 := in_c.m_vdsat - vds;
            vddif2 := vddif * vddif;
            out_qm.qm_capgd := in_c.m_capOx * (1. - in_c.m_vdsat  * in_c.m_vdsat  / vddif2) / 3.;
            out_qm.qm_capgs := in_c.m_capOx * (1. - vddif1 * vddif1 / vddif2) / 3.;
            out_qm.qm_capgb := 0.;
          end if;
        end if;

        out_qm.qm_qgs := 0.0;
        out_qm.qm_qgb := 0.0;
        out_qm.qm_qgd := 0.0;
        out_qm.qm_vgs := 0.0;
        out_qm.qm_vgb := 0.0;
        out_qm.qm_vgd := 0.0;

        annotation (Documentation(info="<html>
<p>This function mosCalcDEVqmeyer calculates the Meyer capacities and charge for the Meyer model.</p>
</html>"));
      end mosCalcDEVqmeyer;

      function mos2CalcInitEquationsRevised
        "Mosfet initial precalculations (level 2)"
        extends Modelica.Icons.Function;
        input Spice3.Internal.Mos2.Mos2ModelLineParams in_p
          "Input record Mos2 values";
        input Spice3.Internal.Mosfet.Mosfet in_m
          "Input record MOSFET parameters";

        output Spice3.Internal.Mos2.Mos2Calc out_c
          "Output record Mos2 calculated values";

      algorithm
        out_c.m_drainResistance := if  (in_p.m_drainResistanceIsGiven > 0.5) then
             in_p.m_drainResistance else
             in_p.m_sheetResistance * in_m.m_drainSquares;

        out_c.m_sourceResistance := if  (in_p.m_sourceResistanceIsGiven > 0.5) then
             in_p.m_sourceResistance else
             in_p.m_sheetResistance * in_m.m_sourceSquares;

        out_c.m_lEff := in_m.m_len - 2 * in_p.m_latDiff;

        if ( abs( out_c.m_lEff) < 1e-18) then
          out_c.m_lEff := 1e-6;
        end if;
        out_c.m_capGSovl := in_p.m_gateSourceOverlapCapFactor * in_m.m_width;
        out_c.m_capGDovl := in_p.m_gateDrainOverlapCapFactor * in_m.m_width;
        out_c.m_capGBovl := in_p.m_gateBulkOverlapCapFactor * out_c.m_lEff;

        out_c.m_capOx    := in_p.m_oxideCapFactor * out_c.m_lEff * in_m.m_width;

        annotation (Documentation(info="<html>
<p>This function mosCalcInitEquations does the initial precalculation of the MOSFET parameters (level 2).</p>
</html>"));
      end mos2CalcInitEquationsRevised;

      function mos2CalcInitEquations
        "Mosfet initial precalculations (level 1) obsolete, use mos2CalcInitEquationsRevised"
        extends Modelica.Icons.Function;
        extends Modelica.Icons.ObsoleteModel;

        input Spice3.Internal.Mos2.Mos2ModelLineParams
                                       in_p "Input record Mos2 values";
        input Spice3.Internal.SpiceConstants in_C "Spice constants";
        input Spice3.Internal.Mos2.Mos2ModelLineVariables in_vp
          "Input record model line variables";
        input Spice3.Internal.Mosfet.Mosfet in_m
          "Input record MOSFET parameters";

        output Spice3.Internal.Mos2.Mos2Calc
                             out_c "Output record Mos2 calculated values";

      algorithm
       out_c.m_drainResistance := if  (in_p.m_drainResistanceIsGiven > 0.5) then
             in_p.m_drainResistance else
             in_p.m_sheetResistance * in_m.m_drainSquares;

      out_c.m_sourceResistance := if  (in_p.m_sourceResistanceIsGiven > 0.5) then
             in_p.m_sourceResistance else
             in_p.m_sheetResistance * in_m.m_sourceSquares;

        out_c.m_lEff := in_m.m_len - 2 * in_p.m_latDiff;

        if ( abs( out_c.m_lEff) < 1e-18) then
          out_c.m_lEff := 1e-6;
        end if;
        out_c.m_capGSovl := in_p.m_gateSourceOverlapCapFactor * in_m.m_width;
        out_c.m_capGDovl := in_p.m_gateDrainOverlapCapFactor * in_m.m_width;
        out_c.m_capGBovl := in_p.m_gateBulkOverlapCapFactor * out_c.m_lEff;

        out_c.m_capOx    := in_vp.m_oxideCapFactor * out_c.m_lEff * in_m.m_width;

        annotation (Documentation(info="<html>
<p>This function mosCalcInitEquations does the initial precalculation of the MOSFET parameters (level 2).</p>
</html>"),
        obsolete = "Obsolete model - use Modelica.Electrical.Spice3.Internal.Mos.mos2CalcInitEquationsRevised instead");
      end mos2CalcInitEquations;

      function mos2CalcCalcTempDependenciesRevised
        "Precalculation relating to temperature"
        extends Modelica.Icons.Function;
        input Spice3.Internal.Mos2.Mos2ModelLineParams in_p
          "Output record Mos1 calculated values";
        input Spice3.Internal.Mosfet.Mosfet in_m
          "Input record MOSFET parameters";
        input Spice3.Internal.Mos2.Mos2Calc in_c "Input record Mos2Calc";
        input Integer in_m_type "Type of MOS transistor";

        output Spice3.Internal.Mos2.Mos2Calc out_c
          "Output record with calculated values";

      protected
         Real ratio;
         Real ratio4;
         Real res;

      algorithm
        out_c := in_c;

        ratio                     := in_m.m_dTemp / in_p.m_tnom;
        ratio4                    := ratio * sqrt(ratio);
        out_c.m_tTransconductance := in_p.m_transconductance / ratio4;
        out_c.m_Beta              := out_c.m_tTransconductance * in_m.m_width / out_c.m_lEff;

        out_c.m_tSurfMob          := in_p.m_surfaceMobility / ratio4;

        out_c.m_tPhi := Spice3.Internal.Functions.junctionPotDepTemp(
          in_p.m_phi,
          in_m.m_dTemp,
          in_p.m_tnom);

        out_c.m_tVbi := in_p.m_vt0 - in_m_type*(in_p.m_gamma*sqrt(in_p.m_phi)) + 0.5*(
          Spice3.Internal.Functions.energyGapDepTemp(in_p.m_tnom) -
          Spice3.Internal.Functions.energyGapDepTemp(in_m.m_dTemp)) + in_m_type*0.5*(
          out_c.m_tPhi - in_p.m_phi);
        out_c.m_tVto := out_c.m_tVbi + in_m_type * in_p.m_gamma * sqrt(out_c.m_tPhi);

        out_c.m_tBulkPot := Spice3.Internal.Functions.junctionPotDepTemp(
          in_p.m_bulkJctPotential,
          in_m.m_dTemp,
          in_p.m_tnom);
        out_c.m_tDepCap  := in_p.m_fwdCapDepCoeff * out_c.m_tBulkPot;

        if (in_p.m_jctSatCurDensity == 0.0 or in_m.m_sourceArea == 0.0 or in_m.m_drainArea == 0.0) then
          out_c.m_tDrainSatCur := Spice3.Internal.Functions.saturationCurDepTempSPICE3MOSFET(
            in_p.m_jctSatCur,
            in_m.m_dTemp,
            in_p.m_tnom);
          out_c.m_tSourceSatCur := out_c.m_tDrainSatCur;
          out_c.m_VBScrit := Spice3.Internal.Functions.junctionVCrit(
            in_m.m_dTemp,
            1.0,
            out_c.m_tSourceSatCur);
          out_c.m_VBDcrit       := out_c.m_VBScrit;
        else
          out_c.m_tSatCurDens :=
            Spice3.Internal.Functions.saturationCurDepTempSPICE3MOSFET(
            in_p.m_jctSatCurDensity,
            in_m.m_dTemp,
            in_p.m_tnom);
          out_c.m_tDrainSatCur  := out_c.m_tSatCurDens * in_m.m_drainArea;
          out_c.m_tSourceSatCur := out_c.m_tSatCurDens * in_m.m_sourceArea;
          out_c.m_VBScrit := Spice3.Internal.Functions.junctionVCrit(
            in_m.m_dTemp,
            1.0,
            out_c.m_tSourceSatCur);
          out_c.m_VBDcrit := Spice3.Internal.Functions.junctionVCrit(
            in_m.m_dTemp,
            1.0,
            out_c.m_tDrainSatCur);
        end if;

        if ( not (in_p.m_capBDIsGiven > 0.5) or not (in_p.m_capBSIsGiven > 0.5)) then
          (res,out_c.m_tCj) := Spice3.Internal.Functions.junctionParamDepTempSPICE3(
            in_p.m_bulkJctPotential,
            in_p.m_bulkCapFactor,
            in_p.m_bulkJctBotGradingCoeff,
            in_m.m_dTemp,
            in_p.m_tnom);
          (res,out_c.m_tCjsw) := Spice3.Internal.Functions.junctionParamDepTempSPICE3(
            in_p.m_bulkJctPotential,
            in_p.m_sideWallCapFactor,
            in_p.m_bulkJctSideGradingCoeff,
            in_m.m_dTemp,
            in_p.m_tnom);
          (out_c.m_f1s,out_c.m_f2s,out_c.m_f3s) :=
            Spice3.Internal.Functions.junctionCapCoeffs(
            in_p.m_bulkJctSideGradingCoeff,
            in_p.m_fwdCapDepCoeff,
            out_c.m_tBulkPot);
        end if;

        if (in_p.m_capBDIsGiven > 0.5) then
          (res,out_c.m_tCBDb) := Spice3.Internal.Functions.junctionParamDepTempSPICE3(
            in_p.m_bulkJctPotential,
            in_p.m_capBD,
            in_p.m_bulkJctBotGradingCoeff,
            in_m.m_dTemp,
            in_p.m_tnom);
          out_c.m_tCBDs          := 0.0;
        else
          out_c.m_tCBDb := out_c.m_tCj * in_m.m_drainArea;
          out_c.m_tCBDs := out_c.m_tCjsw * in_m.m_drainPerimeter;
        end if;

        if (in_p.m_capBSIsGiven > 0.5) then
          (res,out_c.m_tCBSb) := Spice3.Internal.Functions.junctionParamDepTempSPICE3(
            in_p.m_bulkJctPotential,
            in_p.m_capBS,
            in_p.m_bulkJctBotGradingCoeff,
            in_m.m_dTemp,
            in_p.m_tnom);
          out_c.m_tCBSs          := 0.0;
        else
          out_c.m_tCBSb := out_c.m_tCj * in_m.m_sourceArea;
          out_c.m_tCBSs := out_c.m_tCjsw * in_m.m_sourcePerimeter;
        end if;
        (out_c.m_f1b,out_c.m_f2b,out_c.m_f3b) :=
          Spice3.Internal.Functions.junctionCapCoeffs(
          in_p.m_bulkJctBotGradingCoeff,
          in_p.m_fwdCapDepCoeff,
          out_c.m_tBulkPot);
        out_c.m_dVt := in_m.m_dTemp*Spice3.Internal.SpiceConstants.CONSTKoverQ;

        annotation (Documentation(info="<html>
<p>This function mosCalcCalcTempDependencies does precalculation relating to the temperature (level 2).</p>
</html>"));
      end mos2CalcCalcTempDependenciesRevised;

      function mos2CalcCalcTempDependencies
        "Precalculation relating to temperature obsolete, use mos2CalcCalcTempDependenciesRevised"
        extends Modelica.Icons.Function;
        extends Modelica.Icons.ObsoleteModel;

        input Spice3.Internal.Mos2.Mos2ModelLineParams
                                       in_p
          "Output record Mos1 calculated values";
        input Spice3.Internal.SpiceConstants in_C "Spice constants";
        input Spice3.Internal.Mos2.Mos2ModelLineVariables in_vp
          "Input record model line variables";
        input Spice3.Internal.Mosfet.Mosfet in_m
          "Input record MOSFET parameters";
        input Spice3.Internal.Mos2.Mos2Calc
                            in_c "Input record Mos2Calc";
        input Integer in_m_type "Type of MOS transistor";

        output Spice3.Internal.Mos2.Mos2Calc
                             out_c "Output record with calculated values";

      protected
         Real ratio;
         Real ratio4;

      algorithm
        out_c := in_c;

        ratio                     := in_m.m_dTemp / in_p.m_tnom;
        ratio4                    := ratio * sqrt(ratio);
        out_c.m_tTransconductance := in_vp.m_transconductance / ratio4;
        out_c.m_Beta              := out_c.m_tTransconductance * in_m.m_width / out_c.m_lEff;

        out_c.m_tSurfMob          := in_p.m_surfaceMobility / ratio4;

        out_c.m_tPhi :=
          Spice3.Internal.Functions.junctionPotDepTemp(
                in_vp.m_phi,
                in_m.m_dTemp,
                in_p.m_tnom);

        out_c.m_tVbi := in_vp.m_vt0 - in_m_type*(in_vp.m_gamma*sqrt(in_vp.m_phi))
           + 0.5*(Spice3.Internal.Functions.energyGapDepTemp(
          in_p.m_tnom) -
          Spice3.Internal.Functions.energyGapDepTemp(in_m.m_dTemp))
           + in_m_type*0.5*(out_c.m_tPhi - in_vp.m_phi);
        out_c.m_tVto := out_c.m_tVbi + in_m_type * in_vp.m_gamma * sqrt(out_c.m_tPhi);

        out_c.m_tBulkPot := Spice3.Internal.Functions.junctionPotDepTemp(
                in_p.m_bulkJctPotential,
                in_m.m_dTemp,
                in_p.m_tnom);
        out_c.m_tDepCap  := in_p.m_fwdCapDepCoeff * out_c.m_tBulkPot;

        if (in_p.m_jctSatCurDensity == 0.0 or in_m.m_sourceArea == 0.0 or in_m.m_drainArea == 0.0) then
          out_c.m_tDrainSatCur :=
            Spice3.Internal.Functions.saturationCurDepTempSPICE3MOSFET(
                  in_p.m_jctSatCur,
                  in_m.m_dTemp,
                  in_p.m_tnom);
          out_c.m_tSourceSatCur := out_c.m_tDrainSatCur;
          out_c.m_VBScrit :=
            Spice3.Internal.Functions.junctionVCrit(
                  in_m.m_dTemp,
                  1.0,
                  out_c.m_tSourceSatCur);
          out_c.m_VBDcrit       := out_c.m_VBScrit;
        else
          out_c.m_tSatCurDens :=
            Spice3.Internal.Functions.saturationCurDepTempSPICE3MOSFET(
                  in_p.m_jctSatCurDensity,
                  in_m.m_dTemp,
                  in_p.m_tnom);
          out_c.m_tDrainSatCur  := out_c.m_tSatCurDens * in_m.m_drainArea;
          out_c.m_tSourceSatCur := out_c.m_tSatCurDens * in_m.m_sourceArea;
          out_c.m_VBScrit :=
            Spice3.Internal.Functions.junctionVCrit(
                  in_m.m_dTemp,
                  1.0,
                  out_c.m_tSourceSatCur);
          out_c.m_VBDcrit :=
            Spice3.Internal.Functions.junctionVCrit(
                  in_m.m_dTemp,
                  1.0,
                  out_c.m_tDrainSatCur);
        end if;

        if ( not (in_p.m_capBDIsGiven > 0.5) or not (in_p.m_capBSIsGiven > 0.5)) then
          (out_c.m_tCj) :=
            Spice3.Internal.Functions.junctionParamDepTempSPICE3(
                  in_p.m_bulkJctPotential,
                  in_p.m_bulkCapFactor,
                  in_p.m_bulkJctBotGradingCoeff,
                  in_m.m_dTemp,
                  in_p.m_tnom);
          (out_c.m_tCjsw) :=
            Spice3.Internal.Functions.junctionParamDepTempSPICE3(
                  in_p.m_bulkJctPotential,
                  in_p.m_sideWallCapFactor,
                  in_p.m_bulkJctSideGradingCoeff,
                  in_m.m_dTemp,
                  in_p.m_tnom);
          (out_c.m_f1s,out_c.m_f2s,out_c.m_f3s) :=
            Spice3.Internal.Functions.junctionCapCoeffs(
                  in_p.m_bulkJctSideGradingCoeff,
                  in_p.m_fwdCapDepCoeff,
                  out_c.m_tBulkPot);
        end if;

        if (in_p.m_capBDIsGiven > 0.5) then
          (out_c.m_tCBDb) :=
            Spice3.Internal.Functions.junctionParamDepTempSPICE3(
                  in_p.m_bulkJctPotential,
                  in_p.m_capBD,
                  in_p.m_bulkJctBotGradingCoeff,
                  in_m.m_dTemp,
                  in_p.m_tnom);
          out_c.m_tCBDs          := 0.0;
        else
          out_c.m_tCBDb := out_c.m_tCj * in_m.m_drainArea;
          out_c.m_tCBDs := out_c.m_tCjsw * in_m.m_drainPerimeter;
        end if;

        if (in_p.m_capBSIsGiven > 0.5) then
          (out_c.m_tCBSb) :=
            Spice3.Internal.Functions.junctionParamDepTempSPICE3(
                  in_p.m_bulkJctPotential,
                  in_p.m_capBS,
                  in_p.m_bulkJctBotGradingCoeff,
                  in_m.m_dTemp,
                  in_p.m_tnom);
          out_c.m_tCBSs          := 0.0;
        else
          out_c.m_tCBSb := out_c.m_tCj * in_m.m_sourceArea;
          out_c.m_tCBSs := out_c.m_tCjsw * in_m.m_sourcePerimeter;
        end if;
        (out_c.m_f1b,out_c.m_f2b,out_c.m_f3b) :=
          Spice3.Internal.Functions.junctionCapCoeffs(
                in_p.m_bulkJctBotGradingCoeff,
                in_p.m_fwdCapDepCoeff,
                out_c.m_tBulkPot);
        out_c.m_dVt := in_m.m_dTemp*Spice3.Internal.SpiceConstants.CONSTKoverQ;

        annotation (Documentation(info="<html>
<p>This function mosCalcCalcTempDependencies does precalculation relating to the temperature (level 2).</p>
</html>"),
        obsolete = "Obsolete function - use Modelica.Electrical.Spice3.Internal.Mos.mos2CalcCalcTempDependenciesRevised instead");
      end mos2CalcCalcTempDependencies;

      function mos2CalcNoBypassCodeRevised
        "Calculation of currents and capacities (level 2)"
        extends Modelica.Icons.Function;
        input Spice3.Internal.Mosfet.Mosfet in_m
          "Input record MOSFET parameters";
        input Integer in_m_type "Type of MOS transistor";
        input Spice3.Internal.Mos2.Mos2Calc in_c "Input record Mos2Calc";
        input Spice3.Internal.Mos2.Mos2ModelLineParams in_p
          "Input record model line parameters";
        input Boolean in_m_bInit;
        input SI.Voltage[4] in_m_pVoltageValues; // gate bulk drain source

        output Modelica.Electrical.Spice3.Internal.Mos.CurrrentsCapacitances out_cc
          "Calculated currents and capacitances";

      protected
        SI.Voltage vbd "Voltage";
        SI.Voltage vgd "Voltage";
        SI.Voltage vgb "Voltage";
        Modelica.Electrical.Spice3.Internal.Mos.DEVqmeyer qm
          "Qmeyer capacitances";
        Spice3.Internal.Mos2.Mos2Calc int_c "Record Mos2Calc";
        Real hlp;

      algorithm
        int_c := in_c;

        int_c.m_vgs := in_m_type * (in_m_pVoltageValues[1] - in_m_pVoltageValues[4]); // ( G , SP)
        int_c.m_vbs := in_m_type * (in_m_pVoltageValues[2] - in_m_pVoltageValues[4]); // ( B , SP)
        int_c.m_vds := in_m_type * (in_m_pVoltageValues[3] - in_m_pVoltageValues[4]); // ( DP, SP)

        if (in_m.m_uic and in_m.m_dICVBSIsGiven > 0.5) then
          int_c.m_vbs := in_m_type * in_m.m_dICVBS;
        elseif (Spice3.Internal.SpiceRoot.initJunctionVoltagesRevised()) then
          int_c.m_vbs := if (in_m.m_off == 1)  then 0. else int_c.m_VBScrit;
        end if;
        if (in_m.m_uic and in_m.m_dICVDSIsGiven > 0.5) then
          int_c.m_vds := in_m_type * in_m.m_dICVDS;
        elseif (Spice3.Internal.SpiceRoot.initJunctionVoltagesRevised()) then
          int_c.m_vds := if (in_m.m_off == 1)  then 0. else (int_c.m_VBDcrit - int_c.m_VBScrit);
        end if;
        if (in_m.m_uic and in_m.m_dICVGSIsGiven > 0.5) then
          int_c.m_vgs := in_m_type * in_m.m_dICVGS;
        elseif (Spice3.Internal.SpiceRoot.initJunctionVoltagesRevised()) then
          if ( in_m.m_off == 1) then
            int_c.m_vgs := 0.;
          end if;
        end if;

        if (int_c.m_vds == 0 and int_c.m_vgs == 0 and int_c.m_vbs == 0 and not (
            in_m.m_uic) and (in_m.m_off == 0)) then
          int_c.m_vbs := -1;
          int_c.m_vgs := in_m_type * int_c.m_tVto;
          int_c.m_vds := 0;
        end if;

        vbd := int_c.m_vbs - int_c.m_vds;
        vgd := int_c.m_vgs - int_c.m_vds;

        if ( int_c.m_vds >= 0) then
          int_c.m_vbs := Spice3.Internal.SpiceRoot.limitJunctionVoltageRevised(int_c.m_vbs);
          vbd         := int_c.m_vbs - int_c.m_vds;
        else
          vbd := Spice3.Internal.SpiceRoot.limitJunctionVoltageRevised(vbd);
          int_c.m_vbs := vbd + int_c.m_vds;
        end if;

        vgb := int_c.m_vgs - int_c.m_vbs;

        (int_c.m_cbd,int_c.m_gbd) := Spice3.Internal.Functions.junction2SPICE3MOSFETRevised(
          vbd,
          in_m.m_dTemp,
          1.0,
          int_c.m_tDrainSatCur);
        out_cc.iBD                := in_m_type * int_c.m_cbd;
        (int_c.m_cbs,int_c.m_gbs) := Spice3.Internal.Functions.junction2SPICE3MOSFETRevised(
          int_c.m_vbs,
          in_m.m_dTemp,
          1.0,
          int_c.m_tSourceSatCur);
        out_cc.iBS                := in_m_type * int_c.m_cbs;

        int_c.m_mode := if (int_c.m_vds >= 0) then 1 else -1; // 1: normal mode, -1: inverse mode

        if (int_c.m_mode == 1) then
          int_c := Spice3.Internal.Mos2.drainCurRevised(
            int_c.m_vbs,
            int_c.m_vgs,
            int_c.m_vds,
            in_m,
            int_c,
            in_p,
            in_m_type);
        else
          int_c := Spice3.Internal.Mos2.drainCurRevised(
            vbd,
            vgd,
            -int_c.m_vds,
            in_m,
            int_c,
            in_p,
            in_m_type);
        end if;
        out_cc.idrain := in_m_type * int_c.m_cdrain * int_c.m_mode;

        int_c.m_capbss    := 0.0;
        int_c.m_chargebss := 0.0;
        int_c.m_capbds    := 0.0;
        int_c.m_chargebds := 0.0;
        (int_c.m_capbsb,int_c.m_chargebsb) := Spice3.Internal.Functions.junctionCapRevised(
          int_c.m_tCBSb,
          int_c.m_vbs,
          int_c.m_tDepCap,
          in_p.m_bulkJctBotGradingCoeff,
          int_c.m_tBulkPot,
          int_c.m_f1b,
          int_c.m_f2b,
          int_c.m_f3b);

        (int_c.m_capbdb,int_c.m_chargebdb) := Spice3.Internal.Functions.junctionCapRevised(
          int_c.m_tCBDb,
          vbd,
          int_c.m_tDepCap,
          in_p.m_bulkJctBotGradingCoeff,
          int_c.m_tBulkPot,
          int_c.m_f1b,
          int_c.m_f2b,
          int_c.m_f3b);

        if ( not (in_p.m_capBSIsGiven > 0.5)) then
          (int_c.m_capbss,int_c.m_chargebss) := Spice3.Internal.Functions.junctionCapRevised(
            int_c.m_tCBSs,
            int_c.m_vbs,
            int_c.m_tDepCap,
            in_p.m_bulkJctSideGradingCoeff,
            int_c.m_tBulkPot,
            int_c.m_f1s,
            int_c.m_f2s,
            int_c.m_f3s);
        end if;

        if (not (in_p.m_capBDIsGiven > 0.5)) then
          (int_c.m_capbds,int_c.m_chargebds) := Spice3.Internal.Functions.junctionCapRevised(
            int_c.m_tCBDs,
            vbd,
            int_c.m_tDepCap,
            in_p.m_bulkJctSideGradingCoeff,
            int_c.m_tBulkPot,
            int_c.m_f1s,
            int_c.m_f2s,
            int_c.m_f3s);
        end if;

        out_cc.cBS := if (in_m_bInit) then 1e-15 else (int_c.m_capbsb + int_c.m_capbss);
        out_cc.cBD := if (in_m_bInit) then 1e-15 else (int_c.m_capbdb + int_c.m_capbds);

        if (int_c.m_mode > 0) then
          qm := Modelica.Electrical.Spice3.Internal.Mos.mosCalcDEVqmeyer(
                  int_c.m_vgs,
                  vgd,
                  vgb,
                  int_c);
        else
          qm := Modelica.Electrical.Spice3.Internal.Mos.mosCalcDEVqmeyer(
                  vgd,
                  int_c.m_vgs,
                  vgb,
                  int_c);
          // Inverser Betrieb -> Drain und Source vertauschen
          // Tausch der Spannungen bei Aufruf von DEVqmeyer
          // Tausch der Kapazitaeten GD und GS
          hlp         := qm.qm_capgd;
          qm.qm_capgd := qm.qm_capgs;
          qm.qm_capgs := hlp;
        end if;

        int_c.m_capgd := 2 * qm.qm_capgd + int_c.m_capGDovl;
        int_c.m_capgs := 2 * qm.qm_capgs + int_c.m_capGSovl;
        int_c.m_capgb := 2 * qm.qm_capgb + int_c.m_capGBovl;

        out_cc.cGB := if (in_m_bInit) then -1e40 else int_c.m_capgb;
        out_cc.cGD := if (in_m_bInit) then -1e40 else int_c.m_capgd;
        out_cc.cGS := if (in_m_bInit) then -1e40 else int_c.m_capgs;

        annotation (Documentation(info="<html>
<p>This function NoBypassCode calculates the currents (and the capacitances) that are necessary for the currents sum in the toplevelmodel (level 2).</p>
</html>"));
      end mos2CalcNoBypassCodeRevised;

      function mos2CalcNoBypassCode
        "Calculation of currents and capacities (level 2) obsolete, use mos2CalcNoBypassCodeRevised"
        extends Modelica.Icons.Function;
        extends Modelica.Icons.ObsoleteModel;

        input Spice3.Internal.Mosfet.Mosfet in_m
          "Input record MOSFET parameters";
        input Integer in_m_type "Type of MOS transistor";
        input Spice3.Internal.Mos2.Mos2Calc
                            in_c "Input record Mos2Calc";
        input Spice3.Internal.Mos2.Mos2ModelLineParams
                                       in_p
          "Input record model line parameters";
        input Spice3.Internal.SpiceConstants in_C "Spice constants";
        input Spice3.Internal.Mos2.Mos2ModelLineVariables
                                          in_vp
          "Input record model line variables";
        input Boolean in_m_bInit;
        input SI.Voltage[4] in_m_pVoltageValues; /* gate bulk drain source */

        output CurrrentsCapacitances out_cc
          "Calculated currents and capacitances";

        output DEVqmeyer qm "Calculated qmeyer values";

      protected
        SI.Voltage vbd "Voltage";
        SI.Voltage vgd "Voltage";
        SI.Voltage vgb "Voltage";
        SI.Current cur "Voltage";
        Integer n;

        DEVqmeyer in_qm(
        qm_capgb = 0,
        qm_capgs =  0,
        qm_capgd =  0,
        qm_qgs =  0,
        qm_qgb =  0,
        qm_qgd =  0,
        qm_vgs =  0,
        qm_vgb =  0,
        qm_vgd =  0) "Qmeyer capacitances";
        Spice3.Internal.Mos2.Mos2Calc
                      int_c "Record Mos2Calc";
        Spice3.Internal.Mosfet.Mosfet int_m(
        m_len =          1e-4,
        m_width =        1e-4,
        m_drainArea =    Spice3.Internal.SpiceConstants.CKTdefaultMosAD,
        m_sourceArea =   Spice3.Internal.SpiceConstants.CKTdefaultMosAS,
        m_drainSquares = 1.0,
        m_sourceSquares= 1.0,
        m_drainPerimeter=0.0,
        m_sourcePerimeter= 0.0,
        m_dICVDS =         0.0,
        m_dICVDSIsGiven =  0.0,
        m_dICVGS =         0.0,
        m_dICVGSIsGiven =  0.0,
        m_dICVBS =         0.0,
        m_dICVBSIsGiven =  0.0,
        m_off =            0,
        m_bPMOS =          0,
        m_nLevel =         1,
        m_drainPerimiter = 0.0,
        m_sourcePerimiter= 0.0,
        m_uic =            false) "Record Mosfet";

        Real hlp;
      algorithm
        int_c := in_c;

        int_c.m_vgs := in_m_type * (in_m_pVoltageValues[1] - in_m_pVoltageValues[4]); // ( G , SP)
        int_c.m_vbs := in_m_type * (in_m_pVoltageValues[2] - in_m_pVoltageValues[4]); // ( B , SP)
        int_c.m_vds := in_m_type * (in_m_pVoltageValues[3] - in_m_pVoltageValues[4]); // ( DP, SP)

        if (Spice3.Internal.SpiceRoot.useInitialConditions()) and (in_m.m_dICVBSIsGiven
             > 0.5) then
          int_c.m_vbs := in_m_type * in_m.m_dICVBS;
        elseif (
            Spice3.Internal.SpiceRoot.initJunctionVoltages()) then
          int_c.m_vbs := if (in_m.m_off >0.5) then 0. else int_c.m_VBScrit;
        end if;
        if (Spice3.Internal.SpiceRoot.useInitialConditions())
             and (in_m.m_dICVDSIsGiven > 0.5) then
          int_c.m_vds := in_m_type * in_m.m_dICVDS;
        elseif (
            Spice3.Internal.SpiceRoot.initJunctionVoltages()) then
          int_c.m_vds := if (in_m.m_off > 0.5) then 0. else (int_c.m_VBDcrit - int_c.m_VBScrit);
        end if;
        if (Spice3.Internal.SpiceRoot.useInitialConditions())
             and (in_m.m_dICVGSIsGiven > 0.5) then
          int_c.m_vgs := in_m_type * in_m.m_dICVGS;
        elseif (
            Spice3.Internal.SpiceRoot.initJunctionVoltages()) then
          if ( in_m.m_off > 0.5) then
            int_c.m_vgs := 0.;
          end if;
        end if;

        if (int_c.m_vds <> 0 and int_c.m_vgs <> 0 and int_c.m_vbs <> 0 and not (
            Spice3.Internal.SpiceRoot.useInitialConditions())
             and (in_m.m_off <> 0)) then
          int_c.m_vbs := -1;
          int_c.m_vgs := in_m_type * int_c.m_tVto;
          int_c.m_vds := 0;
        end if;

        vbd := int_c.m_vbs - int_c.m_vds;
        vgd := int_c.m_vgs - int_c.m_vds;

        if ( int_c.m_vds >= 0) then
          int_c.m_vbs :=
            Spice3.Internal.SpiceRoot.limitJunctionVoltage(
            int_c.m_vbs);
          vbd         := int_c.m_vbs - int_c.m_vds;
        else
          vbd :=
            Spice3.Internal.SpiceRoot.limitJunctionVoltage(
            vbd);
          int_c.m_vbs := vbd + int_c.m_vds;
        end if;

        vgb := int_c.m_vgs - int_c.m_vbs;

        (int_c.m_cbd,int_c.m_gbd) :=
          Spice3.Internal.Functions.junction2SPICE3MOSFET(
                int_c.m_cbd,
                int_c.m_gbd,
                vbd,
                in_m.m_dTemp,
                1.0,
                int_c.m_tDrainSatCur);
         out_cc.iBD                 := in_m_type * int_c.m_cbd;
        (int_c.m_cbs,int_c.m_gbs) :=
          Spice3.Internal.Functions.junction2SPICE3MOSFET(
                int_c.m_cbs,
                int_c.m_gbs,
                int_c.m_vbs,
                in_m.m_dTemp,
                1.0,
                int_c.m_tSourceSatCur);
         out_cc.iBS                 := in_m_type * int_c.m_cbs;

        int_c.m_mode := if (int_c.m_vds >= 0) then 1 else -1; // 1: normal mode, -1: inverse mode

        if (int_c.m_mode == 1) then

          int_c := Spice3.Internal.Mos2.drainCur(
                                  int_c.m_vbs, int_c.m_vgs, int_c.m_vds,int_m, int_c, in_p, in_C, in_vp, in_m_type);
        else
          int_c := Spice3.Internal.Mos2.drainCur(
                                  vbd,               vgd,  -int_c.m_vds,int_m, int_c, in_p, in_C, in_vp, in_m_type);
        end if;

        n      := if (int_c.m_mode == 1) then 6 else 5;
        out_cc.idrain := in_m_type * int_c.m_cdrain * int_c.m_mode;

        int_c.m_capbss    := 0.0;
        int_c.m_chargebss := 0.0;
        int_c.m_capbds    := 0.0;
        int_c.m_chargebds := 0.0;
        (int_c.m_capbsb,int_c.m_chargebsb) :=
          Spice3.Internal.Functions.junctionCap(
                int_c.m_tCBSb,
                int_c.m_vbs,
                int_c.m_tDepCap,
                in_p.m_bulkJctBotGradingCoeff,
                int_c.m_tBulkPot,
                int_c.m_f1b,
                int_c.m_f2b,
                int_c.m_f3b);

        (int_c.m_capbdb,int_c.m_chargebdb) :=
          Spice3.Internal.Functions.junctionCap(
                int_c.m_tCBDb,
                vbd,
                int_c.m_tDepCap,
                in_p.m_bulkJctBotGradingCoeff,
                int_c.m_tBulkPot,
                int_c.m_f1b,
                int_c.m_f2b,
                int_c.m_f3b);

        if ( not (in_p.m_capBSIsGiven > 0.5)) then
          (int_c.m_capbss,int_c.m_chargebss) :=
            Spice3.Internal.Functions.junctionCap(
                  int_c.m_tCBSs,
                  int_c.m_vbs,
                  int_c.m_tDepCap,
                  in_p.m_bulkJctSideGradingCoeff,
                  int_c.m_tBulkPot,
                  int_c.m_f1s,
                  int_c.m_f2s,
                  int_c.m_f3s);
        end if;

        if (not (in_p.m_capBDIsGiven > 0.5)) then
          (int_c.m_capbds,int_c.m_chargebds) :=
            Spice3.Internal.Functions.junctionCap(
                  int_c.m_tCBDs,
                  vbd,
                  int_c.m_tDepCap,
                  in_p.m_bulkJctSideGradingCoeff,
                  int_c.m_tBulkPot,
                  int_c.m_f1s,
                  int_c.m_f2s,
                  int_c.m_f3s);
        end if;

        out_cc.cBS := if (in_m_bInit) then 1e-15 else (int_c.m_capbsb + int_c.m_capbss);

        out_cc.cBD := if (in_m_bInit) then 1e-15 else (int_c.m_capbdb + int_c.m_capbds);

        if (int_c.m_mode > 0) then
          qm := mosCalcDEVqmeyer( int_c.m_vgs, vgd, vgb, int_c);
        else
          qm := mosCalcDEVqmeyer( vgd, int_c.m_vgs, vgb, int_c);
          hlp := qm.qm_capgd;
          qm.qm_capgd := qm.qm_capgs;
          qm.qm_capgs := hlp;
        end if;

        if (in_m_bInit) then
          int_c.m_capgd := 2 * qm.qm_capgd + int_c.m_capGDovl;
          int_c.m_capgs := 2 * qm.qm_capgs + int_c.m_capGSovl;
          int_c.m_capgb := 2 * qm.qm_capgb + int_c.m_capGBovl;

          int_c.m_qgs   := int_c.m_capgs * int_c.m_vgs;
          int_c.m_qgb   := int_c.m_capgb * vgb;
          int_c.m_qgd   := int_c.m_capgd * vgd;
        else
          int_c.m_capgd := qm.qm_capgd + in_qm.qm_capgd + int_c.m_capGDovl;
          int_c.m_capgs := qm.qm_capgs + in_qm.qm_capgs + int_c.m_capGSovl;
          int_c.m_capgb := qm.qm_capgb + in_qm.qm_capgb + int_c.m_capGBovl;

          int_c.m_qgs   := (int_c.m_vgs - in_qm.qm_vgs) * int_c.m_capgs + in_qm.qm_qgs;
          int_c.m_qgb   := (vgb - in_qm.qm_vgb) * int_c.m_capgb + in_qm.qm_qgb;
          int_c.m_qgd   := (vgd - in_qm.qm_vgd) * int_c.m_capgd + in_qm.qm_qgd;
        end if;

          out_cc.m_capgd := int_c.m_capgd;

        qm.qm_qgs := int_c.m_qgs;
        qm.qm_qgb := int_c.m_qgb;
        qm.qm_qgd := int_c.m_qgd;
        qm.qm_vgs := int_c.m_vgs;
        qm.qm_vgb := vgb;
        qm.qm_vgd := vgd;

        out_cc.cGB := if (in_m_bInit) then -1e40 else int_c.m_capgb;
        out_cc.cGD := if (in_m_bInit) then -1e40 else out_cc.m_capgd;
        out_cc.cGS := if (in_m_bInit) then -1e40 else int_c.m_capgs;

        annotation (Documentation(info="<html>
<p>This function NoBypassCode calculates the currents (and the capacitances) that are necessary for the currents sum in the toplevelmodel (level 2).</p>
</html>"),
        obsolete = "Obsolete function - use Modelica.Electrical.Spice3.Internal.Mos.mos2CalcNoBypassCodeRevised instead");
      end mos2CalcNoBypassCode;

      annotation (Documentation(info="<html>
<p>This package Mos contains functions and records with data of the MOSFET models level 1, 2, 3 and 6.</p>
</html>"));
    end Mos;

    package Mos1 "Records and functions for MOSFETs level 1"
      extends Modelica.Icons.InternalPackage;

      record Mos1ModelLineParams
        "Record for Mosfet model line parameters (for level 1)"
        extends Mos.MosModelLineParams(
         m_lambda( start = 0.0),
         m_transconductance( start = 2.0e-5));

        annotation (Documentation(info="<html>
<p>This record Mos1ModelLineParams contains the model line parameters that are used for the MOSFET transistors level 1 in SPICE3.</p>
</html>"));
      end Mos1ModelLineParams;

      record Mos1Calc "Further MOSFET variables (for level 1)"
        extends Mos.MosCalc;

        annotation (Documentation(info="<html>
<p>This record Mos1Calc contains further MOSFET variables (for level 1) that are needed for the calculations.</p>
</html>"));
      end Mos1Calc;

      function mos1ModelLineParamsInitEquations "Initial precalculation"
        extends Modelica.Icons.Function;
        input Mos1ModelLineParams in_p
          "Input record model line parameters for MOS1";
        input SpiceConstants in_C "Spice constants";
        input Integer in_m_type "Type of MOS transistor";

        output Mos.MosModelLineVariables out_v
          "Output record model line variables";

      protected
        SI.Voltage vtnom;
        SI.Voltage fermis;
        Real fermig;
        Real wkfng;
        Real wkfngs;
        Real egfet1;
        Real vfb;

      algorithm
        out_v.m_oxideCapFactor   := in_p.m_oxideCapFactor;
        out_v.m_transconductance := in_p.m_transconductance;
        out_v.m_phi              := in_p.m_phi;
        out_v.m_gamma            := in_p.m_gamma;
        out_v.m_vt0              := in_p.m_vt0;

        vtnom  := in_p.m_tnom*SpiceConstants.CONSTKoverQ;
        egfet1 := 1.16 - (7.02e-4*in_p.m_tnom*in_p.m_tnom)/(in_p.m_tnom + 1108);

        if (not (in_p.m_oxideThicknessIsGiven > 0.5) or in_p.m_oxideThickness == 0) then
          if
            (in_p.m_oxideThickness == 0) then
            out_v.m_oxideCapFactor := 0;
          end if;
        else
          out_v.m_oxideCapFactor := 3.9 * 8.854214871e-12 / in_p.m_oxideThickness;

          if (out_v.m_oxideCapFactor <> 0) then

            if (not (in_p.m_transconductanceIsGiven > 0.5)) then
              out_v.m_transconductance := in_p.m_surfaceMobility * out_v.m_oxideCapFactor * 1e-4; // (m**2/cm**2)
            end if;
            if (in_p.m_substrateDopingIsGiven > 0.5) then
              if (in_p.m_substrateDoping * 1e6 > 1.45e16) then // (cm**3/m**3)
                if (not (in_p.m_phiIsGiven > 0.5)) then
                  out_v.m_phi := 2*vtnom*Modelica.Math.log(in_p.m_substrateDoping*1e6/1.45e16); // (cm**3/m**3)
                  out_v.m_phi := max(0.1, out_v.m_phi);
                end if;
                fermis := in_m_type *0.5  * out_v.m_phi;
                wkfng  := 3.2;
                if (in_p.m_gateType <> 0) then
                  fermig := in_m_type * in_p.m_gateType *0.5  * egfet1;
                  wkfng  := 3.25 +0.5  * egfet1 - fermig;
                end if;
                wkfngs := wkfng - (3.25 +0.5  * egfet1 + fermis);
                if (not (in_p.m_gammaIsGiven > 0.5)) then
                  out_v.m_gamma := sqrt(2 * 11.70 * 8.854214871e-12 * SpiceConstants.CHARGE *
                                   in_p.m_substrateDoping * 1e6 / out_v.m_oxideCapFactor);         // (cm**3/m**3)
                end if;
                if (not (in_p.m_vtOIsGiven > 0.5)) then
                  vfb         := wkfngs - in_p.m_surfaceStateDensity * 1e4 * SpiceConstants.CHARGE / out_v.m_oxideCapFactor; // (cm**2/m**2)
                  out_v.m_vt0 := vfb + in_m_type * (out_v.m_gamma * sqrt(out_v.m_phi) + out_v.m_phi);
                 end if;
              end if;
            end if;
          end if;
        end if;

        annotation (Documentation(info="<html>
<p>This function mos1ModelLineParamsInitEquation does the initial precalculation of the MOSFET model line parameters for level 1.</p>
</html>"));
      end mos1ModelLineParamsInitEquations;

      function drainCur "Drain current calculation"
        extends Modelica.Icons.Function;
        input SI.Voltage vb;
        input SI.Voltage vg;
        input SI.Voltage vds;

        input Mos1Calc in_c "Input record Mos1Calc";
        input Mos1ModelLineParams in_p
          "Input record model line parameters for MOS1";
        input SpiceConstants in_C "Spice constants";
        input Mos.MosModelLineVariables in_vp
          "Input record model line variables";
        input Integer in_m_type "Type of Mos transistor";

        output Mos1Calc out_c "Output record Mos1Calc";

      protected
        Real arg;
        Real betap;
        Real sarg;
        SI.Voltage vgst;

      algorithm
        out_c := in_c;

         if (vb <= 0) then
            sarg := sqrt( out_c.m_tPhi - vb);
         else
            sarg := sqrt( out_c.m_tPhi);
            sarg := sarg - vb / (sarg + sarg);
            sarg := max( 0., sarg);
         end if;

         out_c.m_von   := (out_c.m_tVbi * in_m_type) + in_vp.m_gamma * sarg;
         vgst          := vg - out_c.m_von;
         out_c.m_vdsat := max( vgst, 0.);
         arg           := if (sarg <= 0) then 0 else in_vp.m_gamma / (sarg + sarg);

         if (vgst <= 0) then
            /* cutoff region */
            out_c.m_cdrain := 0;
            out_c.m_gm     := 0;
            out_c.m_gds    := 0;
            out_c.m_gmbs   := 0;

         else
            betap := out_c.m_Beta*(1 + in_p.m_lambda*vds);

            if (vgst <= vds) then
               /* saturation region */
               out_c.m_cdrain := betap * vgst * vgst * 0.5;
               out_c.m_gm     := betap * vgst;
               out_c.m_gds    := in_p.m_lambda * out_c.m_Beta * vgst * vgst * 0.5;
               out_c.m_gmbs   := out_c.m_gm * arg;
            else
               /* linear region */
               out_c.m_cdrain := betap * vds * (vgst - 0.5 * vds);
               out_c.m_gm     := betap * vds;
               out_c.m_gds    := betap * (vgst - vds) + in_p.m_lambda * out_c.m_Beta * vds * (vgst - 0.5  * vds);
               out_c.m_gmbs   := out_c.m_gm * arg;
            end if;
         end if;

        annotation (Documentation(info="<html>
<p>This function drainCur calculates the main currents that flows from drain node to source node (level 1).</p>
</html>"));
      end drainCur;

      function mos1RenameParameters "Parameter renaming to internal names"
      extends Modelica.Icons.Function;
        input ModelcardMOS ex "Modelcard with technology parameters";
        input SpiceConstants con "Spice constants";

        output Mos.MosModelLineParams intern
          "Output record model line parameters";

      algorithm
        intern.m_cgboIsGiven := 0;
        intern.m_cgdoIsGiven := 0;
        intern.m_cgsoIsGiven := 0;
        intern.m_mjswIsGiven := 0;
      intern.m_pbIsGiven := 0;
        intern.m_surfaceStateDensityIsGiven := 0;

          intern.m_oxideCapFactor := 0;

          intern.m_vtOIsGiven := if          (ex.VTO > -1e40) then 1 else 0;
          intern.m_vt0 := if         (ex.VTO > -1e40) then ex.VTO else 0;

          intern.m_capBDIsGiven := if          (ex.CBD > -1e40) then 1 else 0;
          intern.m_capBD := if         (ex.CBD > -1e40) then ex.CBD else 0;

          intern.m_capBSIsGiven := if          (ex.CBS > -1e40) then 1 else 0;
          intern.m_capBS := if         (ex.CBS > -1e40) then ex.CBS else 0;

            intern.m_bulkCapFactorIsGiven := if          (ex.CJ > -1e40) then 1 else 0;
          intern.m_bulkCapFactor := if         (ex.CJ > -1e40) then ex.CJ else 0;

          intern.m_sideWallCapFactor := ex.CJSW
          "F/m zero-bias junction sidewall cap. per meter of junction perimeter (default 0)";
          intern.m_fwdCapDepCoeff := ex.FC
          "Coefficient for forward-bias depletion capacitance formula (default 0.5)";

          intern.m_phiIsGiven := if          (ex.PHI > -1e40) then 1 else 0;
          intern.m_phi := if         (ex.PHI > -1e40) then ex.PHI else 0.6;

           intern.m_gammaIsGiven := if          (ex.GAMMA > -1e40) then 1 else 0;
          intern.m_gamma := if         (ex.GAMMA > -1e40) then ex.GAMMA else 0;

          intern.m_lambda := ex.LAMBDA
          "1/V channel-length modulation (default 0)";

          intern.m_substrateDopingIsGiven := if          (ex.NSUB > -1e40) then 1 else 0;
          intern.m_substrateDoping := if         (ex.NSUB > -1e40) then ex.NSUB else 0;

          intern.m_gateType := ex.TPG
          "Type of gate material: +1 opp. to substrate, -1 same as substrate, 0 Al gate (default 1)";
          intern.m_surfaceStateDensity := ex.NSS
          "IN 1/(cm*cm) surface state density (default 0)";
          intern.m_surfaceMobility := ex.UO
          "In (cm*cm)/(Vs) surface mobility (default 600)";
          intern.m_latDiff := ex.LD "In m lateral diffusion (default 0)";
          intern.m_jctSatCur := ex.IS
          "A bulk junction saturation current (default 1e-14)";

          intern.m_drainResistanceIsGiven := if
                                               (ex.RD > -1e40) then 1 else 0;
          intern.m_drainResistance := if
                                       (ex.RD > -1e40) then ex.RD else 0;

          intern.m_sourceResistanceIsGiven := if
                                               (ex.RS > -1e40) then 1 else 0;
          intern.m_sourceResistance := if
                                       (ex.RS > -1e40) then ex.RS else 0;

          intern.m_transconductanceIsGiven := if          (ex.KP > -1e40) then 1 else 0;
          intern.m_transconductance := if         (ex.KP > -1e40) then ex.KP else 2e-5;

          intern.m_tnom := if (ex.TNOM > -1e40) then ex.TNOM + SpiceConstants.CONSTCtoK else 300.15
          "parameter measurement temperature (default 27 deg C)";

         intern.m_jctSatCurDensity := ex.JS
          "A/(m*m) bulk junction saturation current per sq-meter of junction area (default 0)";
         intern.m_sheetResistance := ex.RSH
          "Ohm drain and source diffusion sheet resistance (default 0)";
         intern.m_bulkJctPotential := ex.PB
          "V bulk junction potential (default 0.8)";
         intern.m_bulkJctBotGradingCoeff := ex.MJ
          "bulk junction bottom grading coeff. (default 0.5)";
         intern.m_bulkJctSideGradingCoeff := ex.MJSW
          "bulk junction sidewall grading coeff. (default 0.5)";

         intern.m_oxideThicknessIsGiven := if          (ex.TOX > -1e40) then 1 else 0;
          intern.m_oxideThickness := if         (ex.TOX > -1e40) then ex.TOX else 0;

         intern.m_gateSourceOverlapCapFactor := ex.CGSO
          "F/m gate-source overlap capacitance per meter channel width (default 0)";
         intern.m_gateDrainOverlapCapFactor := ex.CGDO
          "F/m gate-drain overlap capacitance per meter channel width (default 0)";
         intern.m_gateBulkOverlapCapFactor := ex.CGBO
          "F/m gate-bulk overlap capacitance per meter channel width (default 0)";
         intern.m_fNcoef := ex.KF "Flicker-noise coefficient (default 0)";
         intern.m_fNexp := ex.AF "Flicker-noise exponent (default 1)";

        annotation (Documentation(info="<html>
<p>This function mos1RenameParameters assigns the external (given by the user, e.g., RD) technology parameters
to the internal parameters (e.g., m_drainResistance). It also does the analysis of the IsGiven values (level 1).</p>
</html>"));
      end mos1RenameParameters;

      function mos1RenameParametersDev
        "Device parameter renaming to internal names"
        extends Modelica.Icons.Function;
        input ModelcardMOS ex;
        input Integer mtype;
        input SI.Length W "Channel Width";
        input SI.Length L "Channel Length";
        input SI.Area AD "Area of the drain diffusion";
        input SI.Area AS "Area of the source diffusion";
        input SI.Length PD "Perimeter of the drain junction";
        input SI.Length PS "Perimeter of the source junction";
        input Real NRD "Number of squares of the drain diffusions";
        input Real NRS "Number of squares of the source diffusions";
        input Integer OFF
          "Optional initial condition: 0 - IC not used, 1 - IC used, not implemented yet";
        input Real IC "Initial condition values, not implemented yet";
        input SI.Temp_C TEMP "Temperature";

        output Mosfet.Mosfet dev "Output record Mosfet";

      algorithm
      /*device parameters*/
        dev.m_len := L "L, length of channel region";
        dev.m_width := W "W, width of channel region";
        dev.m_drainArea := AD "AD, area of drain diffusion";
        dev.m_sourceArea := AS "AS, area of source diffusion";
        dev.m_drainSquares := NRD "NRD, length of drain in squares";
        dev.m_sourceSquares := NRS "NRS, length of source in squares";
        dev.m_drainPerimeter := PD "PD, Drain perimeter";
        dev.m_sourcePerimeter := PS "PS, Source perimeter";

          dev.m_dICVDSIsGiven := if          (IC > -1e40) then 1 else 0
          "ICVDS IsGivenValue";
          dev.m_dICVDS := if         (IC > -1e40) then IC else 0
          "Initial condition of VDS";

          dev.m_dICVGSIsGiven := if          (IC > -1e40) then 1 else 0
          "ICVGS IsGivenValue";
          dev.m_dICVGS := if         (IC > -1e40) then IC else 0
          "Initial condition of VGS";

          dev.m_dICVBSIsGiven := if          (IC > -1e40) then 1 else 0
          "ICVBS IsGivenValue";
          dev.m_dICVBS := if         (IC > -1e40) then IC else 0
          "Initial condition of VBS";

        dev.m_off := OFF "Non-zero to indicate device is off for dc analysis";
        dev.m_bPMOS := mtype "P type MOSFET model";
        dev.m_nLevel := ex.LEVEL "Level";
        assert(ex.LEVEL== 1, "only MOS Level1 implemented");
        dev.m_dTemp :=TEMP + SpiceConstants.CONSTCtoK "Device temperature";

        dev.m_drainPerimiter := 0;
        dev.m_sourcePerimiter := 0;
        dev.m_uic := false;

        annotation (Documentation(info="<html>
<p>This function mos1RenameParametersDev assigns the external (given by the user) device parameters to the internal parameters. It also does the analysis of the IsGiven values (level 1).</p>
</html>"));
      end mos1RenameParametersDev;
      annotation (Documentation(info="<html>
<p>This package Mos1 contains functions and record with data of the MOSFET model level 1.</p>
</html>"));
    end Mos1;

    package Mos2 "Records and functions for MOSFETs level 2"
      extends Modelica.Icons.InternalPackage;

      record Mos2ModelLineParams
        "Record for Mosfet model line parameters (for level 2)"
        extends Spice3.Internal.Mos.MosModelLineParams(
          m_lambda(start=0.0),
          m_transconductance(start=2.0e-5),
          m_bulkJctSideGradingCoeff(start=0.33),
          m_oxideThickness(start=1.0e-7));

        Real m_narrowFactor( start = 0.0) "DELTA, Width effect on threshold";
        Real m_critFieldExp( start = 0.0) "UEXP, Crit. field exp for mob. deg";
        Types.ElectricFieldStrength_cm m_critField( start = 1.0e4)
          "UCRIT, Crit. field for mob. degradation";
        SI.Velocity m_maxDriftVel( start = 0.0)
          "VMAX, Maximum carrier drift velocity";
        SI.Length m_junctionDepth( start = 0.0) "XJ, Junction depth";
        SI.Charge m_channelCharge( start = 1.0)
          "NEFF, Total channel charge coeff";
        SI.Conversions.NonSIunits.PerArea_cm m_fastSurfaceStateDensity( start = 0.0)
          "NFS, Fast surface state density";
        Real m_xd; // unit m/V(-0.5) -> m/Wurzel V
        annotation (Documentation(info="<html>
<p>This record Mos1ModelLineParams contains the model line parameters that are used for the MOSFET transistors level 2 in SPICE3.</p>
</html>"));
      end Mos2ModelLineParams;

      record Mos2ModelLineVariables
        "Record for Mosfet model line variables (for level 2)"
        extends Spice3.Internal.Mos.MosModelLineVariables;

        Real m_bulkCapFactor;
        Real m_substrateDoping;
        Real m_xd;

        annotation (Documentation(info="<html>
<p>This record MosModelLineVariables contains the model line variables that are used for the MOSFET transistors level 2 SPICE3.</p>
</html>"));
      end Mos2ModelLineVariables;

      record Mos2Calc "Further MOSFET variables (for level 2)"
        extends Spice3.Internal.Mos.MosCalc;

        annotation (Documentation(info="<html>
<p>This record Mos1Calc contains further MOSFET variables (for level 2) that are needed for the calculations.</p>
</html>"));
      end Mos2Calc;

      function mos2ModelLineParamsInitEquations
        "Initial precalculation obsolete, use mos2ModelLineParamsInitEquationsRevised"
        extends Modelica.Icons.Function;
        extends Modelica.Icons.ObsoleteModel;

        input Mos2ModelLineParams in_p
          "Input record model line parameters for MOS2";
        input Spice3.Internal.SpiceConstants in_C "Spice constants";
        input Integer in_m_type "Type of MOS transistor";

        output Mos2ModelLineVariables out_v
          "Output record with model line variables";

      protected
        SI.Voltage vtnom;
        SI.Voltage fermis;
        Real fermig;
        Real wkfng;
        Real wkfngs;
        Real egfet1;
        Real vfb;

      algorithm
        out_v.m_oxideCapFactor   := in_p.m_oxideCapFactor;
        out_v.m_transconductance := in_p.m_transconductance;
        out_v.m_phi              := in_p.m_phi;
        out_v.m_gamma            := in_p.m_gamma;
        out_v.m_vt0              := in_p.m_vt0;
        out_v.m_substrateDoping  := in_p.m_substrateDoping;
        out_v.m_bulkCapFactor    := in_p.m_bulkCapFactor;

        vtnom                  := in_p.m_tnom * in_C.CONSTKoverQ;
        egfet1                 := 1.16 - (7.02e-4 * in_p.m_tnom * in_p.m_tnom) / (in_p.m_tnom + 1108);
        out_v.m_oxideCapFactor := 3.9 * 8.854214871e-12 / in_p.m_oxideThickness;

        if ( not (in_p.m_transconductanceIsGiven > 0.5)) then
          out_v.m_transconductance := in_p.m_surfaceMobility * 1.0e-4 * out_v.m_oxideCapFactor;
        end if;

        if  (in_p.m_substrateDopingIsGiven > 0.5) then
          if ( out_v.m_substrateDoping * 1.0e6 > 1.45e16) then
            if ( not (in_p.m_phiIsGiven > 0.5)) then
              out_v.m_phi := 2 * vtnom * Modelica.Math.log( out_v.m_substrateDoping * 1.0e6 / 1.45e16);
              out_v.m_phi := max( 0.1, out_v.m_phi);
            end if;
            fermis := in_m_type * 0.5 * out_v.m_phi;
            wkfng  := 3.2;
            if ( in_p.m_gateType <> 0) then
              fermig := in_m_type * in_p.m_gateType * 0.5 * egfet1;
              wkfng  := 3.25 + 0.5 * egfet1 - fermig;
            end if;
            wkfngs := wkfng - (3.25 + 0.5 * egfet1 + fermis);
            if ( not (in_p.m_gammaIsGiven > 0.5)) then
              out_v.m_gamma := sqrt(2.0 * 11.70 * 8.854214871e-12 * in_C.CHARGE * out_v.m_substrateDoping
                                 * 1.0e6) / out_v.m_oxideCapFactor;
            end if;
            if ( not (in_p.m_vtOIsGiven > 0.5)) then
              vfb         := wkfngs - in_p.m_surfaceStateDensity * 1.0e4 * in_C.CHARGE / out_v.m_oxideCapFactor;
              out_v.m_vt0 := vfb + in_m_type * (out_v.m_gamma * sqrt(out_v.m_phi)+ out_v.m_phi);
            else
              vfb        := out_v.m_vt0 - in_m_type * (out_v.m_gamma * sqrt(out_v.m_phi) + out_v.m_phi);
            end if;
            out_v.m_xd := sqrt( (in_C.EPSSIL + in_C.EPSSIL) / (in_C.CHARGE * out_v.m_substrateDoping * 1.0e6));
          else
            out_v.m_substrateDoping := 0.0;
          end if;
        end if;

        if ( not (in_p.m_bulkCapFactorIsGiven > 0.5)) then
          out_v.m_bulkCapFactor := sqrt( in_C.EPSSIL * in_C.CHARGE * out_v.m_substrateDoping
                                    * 1e6 /(2 * in_p.m_bulkJctPotential));
        end if;

        annotation (Documentation(info="<html>
<p>This function mos1ModelLineParamsInitEquation does the initial precalculation of the MOSFET model line parameters for level 2.</p>
</html>"),
        obsolete = "Obsolete function - use Modelica.Electrical.Spice3.Internal.Mos2.mos2ModelLineParamsInitEquationsRevised instead");
      end mos2ModelLineParamsInitEquations;

      function mos2ModelLineParamsInitEquationsRevised "Initial precalculation"
        extends Modelica.Icons.Function;
        input Modelica.Electrical.Spice3.Internal.Mos2.Mos2ModelLineParams in_p
          "Input record model line parameters for MOS2";
        input Integer in_m_type "Type of MOS transistor";

        output Modelica.Electrical.Spice3.Internal.Mos2.Mos2ModelLineParams out_p
          "Input record model line parameters for MOS2";

      protected
        SI.Voltage vtnom;
        SI.Voltage fermis;
        Real fermig;
        Real wkfng;
        Real wkfngs;
        Real egfet1;
        Real vfb;

      algorithm
        out_p := in_p;

        vtnom := out_p.m_tnom*Spice3.Internal.SpiceConstants.CONSTKoverQ;
        egfet1 := Spice3.Internal.MaterialParameters.EnergyGapSi - (Modelica.Electrical.Spice3.Internal.MaterialParameters.FirstBandCorrFactorSi
          *out_p.m_tnom*out_p.m_tnom)/(out_p.m_tnom + Spice3.Internal.MaterialParameters.SecondBandCorrFactorSi);
        out_p.m_oxideCapFactor := Spice3.Internal.SpiceConstants.EPSOX/out_p.m_oxideThickness;

        if ( not (out_p.m_transconductanceIsGiven > 0.5)) then
          out_p.m_transconductance := out_p.m_surfaceMobility * 1.0e-4 * out_p.m_oxideCapFactor;
        end if;

        if  (out_p.m_substrateDopingIsGiven > 0.5) then
          if (out_p.m_substrateDoping*1.0e6 > Modelica.Electrical.Spice3.Internal.MaterialParameters.IntCondCarrDensity) then
            if ( not (out_p.m_phiIsGiven > 0.5)) then
              out_p.m_phi := 2*vtnom*Modelica.Math.log(out_p.m_substrateDoping*1.0e6
                /Spice3.Internal.MaterialParameters.IntCondCarrDensity);
              out_p.m_phi := max( 0.1, out_p.m_phi);
            end if;
            fermis := in_m_type * 0.5 * out_p.m_phi;
            wkfng  := 3.2;
            if ( out_p.m_gateType <> 0) then
              fermig := in_m_type * out_p.m_gateType * 0.5 * egfet1;
              wkfng  := 3.25 + 0.5 * egfet1 - fermig;
            end if;
            wkfngs := wkfng - (3.25 + 0.5 * egfet1 + fermis);
            if ( not (out_p.m_gammaIsGiven > 0.5)) then
              out_p.m_gamma := sqrt(2.0*Spice3.Internal.SpiceConstants.EPSSIL*
                Spice3.Internal.SpiceConstants.CHARGE*out_p.m_substrateDoping*1.0e6)
                /out_p.m_oxideCapFactor;
            end if;
            if ( not (out_p.m_vtOIsGiven > 0.5)) then
              vfb := wkfngs - out_p.m_surfaceStateDensity*1.0e4*Spice3.Internal.SpiceConstants.CHARGE
                /out_p.m_oxideCapFactor;
              out_p.m_vt0 := vfb + in_m_type * (out_p.m_gamma * sqrt(out_p.m_phi)+ out_p.m_phi);
            else
              vfb        := out_p.m_vt0 - in_m_type * (out_p.m_gamma * sqrt(out_p.m_phi) + out_p.m_phi);
            end if;
            out_p.m_xd := sqrt((Spice3.Internal.SpiceConstants.EPSSIL + Spice3.Internal.SpiceConstants.EPSSIL)
              /(Spice3.Internal.SpiceConstants.CHARGE*out_p.m_substrateDoping*1.0e6));
          else
            out_p.m_substrateDoping := 0.0;
          end if;
        end if;

        if ( not (out_p.m_bulkCapFactorIsGiven > 0.5)) then
          out_p.m_bulkCapFactor := sqrt(Spice3.Internal.SpiceConstants.EPSSIL*
            Spice3.Internal.SpiceConstants.CHARGE*out_p.m_substrateDoping*1e6/(2
            *out_p.m_bulkJctPotential));
        end if;

        annotation (Documentation(info="<html>
<p>This function mos1ModelLineParamsInitEquation does the initial precalculation of the MOSFET model line parameters for level 2.</p>
</html>"));
      end mos2ModelLineParamsInitEquationsRevised;

      function drainCurRevised "Drain current calculation"
        extends Modelica.Icons.Function;
        input SI.Voltage vbs;
        input SI.Voltage vgs;
        input SI.Voltage vds;

        input Spice3.Internal.Mosfet.Mosfet in_m "Record MOSFET";
        input Modelica.Electrical.Spice3.Internal.Mos2.Mos2Calc in_c
          "Input record Mos2Calc";
        input Modelica.Electrical.Spice3.Internal.Mos2.Mos2ModelLineParams in_p
          "Input record model line parameters for MOS2";
        input Integer in_m_type "Type of MOS transistor";

        output Modelica.Electrical.Spice3.Internal.Mos2.Mos2Calc out_c
          "Output record Mos2Calc";

      protected
        Real vt;      // K * T / Q
        Real beta1;
        Real dsrgdb;
        Real d2sdb2;
        Real sphi = 0.0;
        Real sphi3 = 1.0;    // square root of phi
        Real barg;
        Real sarg;
        Real bsarg = 0.0;
        Real sarg3;
        Real d2bdb2;
        Real factor;
        Real dbrgdb;
        Real eta;
        Real vbin;
        Real vth;
        Real dgddb2;
        Real dgddvb;
        Real dgdvds;
        Real gamasd;
        Real gammad;
        Real xn =   1.0;
        Real argg = 0.0;
        Real vgst;
        Real vgsx;
        Real dgdvbs;
        Real body;
        Real bodys = 0.0;
        Real gdbdv;
        Real dodvbs;
        Real dodvds = 0.0;
        Real dxndvd = 0.0;
        Real dxndvb = 0.0;
        Real dudvgs;
        Real dudvds;
        Real dudvbs;
        Real ufact;
        Real ueff;
        Real dsdvgs;
        Real dsdvbs;
        Real dbsrdb = 0.0;
        Real gdbdvs = 0.0;
        Real dldvgs;
        Real dldvds;
        Real dldvbs;
        Real clfact;
        Real xleff;
        Real deltal;
        Real xwb;
        Real xld;
        Real xlamda = in_p.m_lambda;
        Real phiMinVbs;
        Real tmp;

        Real argss;
        Real argsd;
        Real args = 0.0;
        Real argd = 0.0;
        Real argxs = 0.0;
        Real argxd = 0.0;
        Real dbargs;
        Real dbargd;
        Real dbxws;
        Real dbxwd;
        Real xwd;
        Real xws;
        Real daddb2;
        Real dasdb2;
        Real ddxwd;
        Real cfs;
        Real cdonco;
        Real argv;
        Real gammd2;
        Real arg;
        Real y3;
        Real xvalid = 0.0;
        Real[4] sig1;
        Real[4] sig2;
        Real[4] a4;
        Real[4] b4;
        Real[8] x4 = fill(0.0, 8);
        Real[8] poly4;
        Real delta4;
        Integer j;
        Integer iknt = 0;
        Integer i;
        Integer jknt = 0;
        Real v1;
        Real v2;
        Real xv;
        Real a1;
        Real b1;
        Real c1;
        Real d1;
        Real b2;
        Real r1;
        Real s1;
        Real s2;
        Real p1;
        Real p0;
        Real p2;
        Real a3;
        Real b3;
        Real sargv;
        Real dldsat;
        Real xlfact;
        Real xdv;
        Real xlv;
        Real vqchan;
        Real dqdsat;
        Real vl;
        Real dfunds;
        Real dfundg;
        Real dfundb;
        Real xls;
        Real dfact;
        Real vdson;
        Real cdson;
        Real gdson;
        Real didvds;
        Real gmw;
        Real gbson;
        Real expg;

      algorithm
        out_c := in_c;

        vt := Spice3.Internal.SpiceConstants.CONSTKoverQ*Spice3.Internal.SpiceConstants.REFTEMP;

        phiMinVbs := out_c.m_tPhi - vbs;
        if ( vbs <= 0.0) then
          sarg   := sqrt( phiMinVbs);
          dsrgdb := -0.5 / sarg;
          d2sdb2 := 0.5 * dsrgdb / phiMinVbs;
        else
          sphi   :=sqrt(out_c.m_tPhi);
          sphi3  :=out_c.m_tPhi*sphi;
          sarg   :=sphi/(1.0 + 0.5*vbs/out_c.m_tPhi);
          tmp    :=sarg/sphi3;
          dsrgdb :=-0.5*sarg*tmp;
          d2sdb2 :=-dsrgdb*tmp;
        end if;

        if ( (vds-vbs) >= 0) then
          barg   := sqrt( phiMinVbs + vds);
          dbrgdb := -0.5 / barg;
          d2bdb2 := 0.5 * dbrgdb / (phiMinVbs + vds);
        else
          barg   := sphi / (1.0 + 0.5 * (vbs - vds) / out_c.m_tPhi);
          tmp    := barg / sphi3;
          dbrgdb := -0.5 * barg * tmp;
          d2bdb2 := -dbrgdb * tmp;
        end if;

        factor := 0.125*in_p.m_narrowFactor*2.0*Modelica.Constants.pi*Spice3.Internal.SpiceConstants.EPSSIL
          /out_c.m_capOx*out_c.m_lEff;

        eta    := 1.0 + factor;
        vbin   := out_c.m_tVbi * in_m_type + factor * phiMinVbs;
        if ( (in_p.m_gamma > 0.0) or (in_p.m_substrateDoping > 0.0)) then
          xwd := in_p.m_xd * barg;
          xws := in_p.m_xd * sarg;

          argss  := 0.0;
          argsd  := 0.0;
          dbargs := 0.0;
          dbargd := 0.0;
          dgdvds := 0.0;
          dgddb2 := 0.0;
          if ( in_p.m_junctionDepth > 0) then
            tmp   := 2.0 / in_p.m_junctionDepth;
            argxs := 1.0 + xws * tmp;
            argxd := 1.0 + xwd * tmp;
            args  := sqrt( argxs);
            argd  := sqrt( argxd);
            tmp   := 0.5 * in_p.m_junctionDepth / out_c.m_lEff;
            argss := tmp * (args - 1.0);
            argsd := tmp * (argd - 1.0);
          end if;
          gamasd := in_p.m_gamma * (1.0 - argss - argsd);
          dbxwd  := in_p.m_xd * dbrgdb;
          dbxws  := in_p.m_xd * dsrgdb;
          if ( in_p.m_junctionDepth > 0) then
            tmp    := 0.5 / out_c.m_lEff;
            dbargs := tmp * dbxws / args;
            dbargd := tmp * dbxwd / argd;
            dasdb2 := -in_p.m_xd * (d2sdb2 + dsrgdb * dsrgdb * in_p.m_xd
                      / (in_p.m_junctionDepth * argxs)) / (out_c.m_lEff * args);
            daddb2 := -in_p.m_xd * (d2bdb2 + dbrgdb * dbrgdb * in_p.m_xd
                      / (in_p.m_junctionDepth * argxd))
                      / (out_c.m_lEff * argd);
            dgddb2 := -0.5 * in_p.m_gamma * (dasdb2 + daddb2);
          end if;
          dgddvb := -in_p.m_gamma * (dbargs + dbargd);
          if ( in_p.m_junctionDepth > 0) then
            ddxwd  := -dbxwd;
            dgdvds := -in_p.m_gamma * 0.5 * ddxwd / (out_c.m_lEff * argd);
          end if;
        else
          gamasd := in_p.m_gamma;
          gammad := in_p.m_gamma;
          dgddvb := 0.0;
          dgdvds := 0.0;
          dgddb2 := 0.0;
        end if;

        out_c.m_von   := vbin + gamasd * sarg;
        vth           := out_c.m_von;
        out_c.m_vdsat := 0.0;
        if ( in_p.m_fastSurfaceStateDensity <> 0.0 and out_c.m_capOx <> 0.0) then
          cfs := Spice3.Internal.SpiceConstants.CHARGE*in_p.m_fastSurfaceStateDensity*
            1.0e4;
          cdonco       := -(gamasd * dsrgdb + dgddvb * sarg) + factor;
          xn           := 1.0 + cfs / out_c.m_capOx * in_m.m_width * out_c.m_lEff + cdonco;
          tmp          := vt * xn;
          out_c.m_von  := out_c.m_von + tmp;
          argg         := 1.0 / tmp;
          vgst         := vgs - out_c.m_von;
        else
          vgst := vgs - out_c.m_von;
          if ( vgs <= out_c.m_von) then
            // cutoff region
            out_c.m_gds    := 0.0;
            out_c.m_cdrain := 0.0;
            out_c.m_gm     := 0.0;
            out_c.m_gmbs   := 0.0;
            return;
          end if;
        end if;

        sarg3  := sarg * sarg * sarg;
        gammad := gamasd;
        dgdvbs := dgddvb;
        body   := barg * barg * barg - sarg3;
        gdbdv  := 2.0 * gammad * (barg * barg * dbrgdb - sarg * sarg * dsrgdb);
        dodvbs := -factor + dgdvbs * sarg + gammad * dsrgdb;

        if ( (in_p.m_fastSurfaceStateDensity <> 0.0) and (out_c.m_capOx <> 0.0)) then
          dxndvb := 2.0 * dgdvbs * dsrgdb + gammad * d2sdb2 + dgddb2 * sarg;
          dodvbs := dodvbs + vt * dxndvb;
          dxndvd := dgdvds * dsrgdb;
          dodvds := dgdvds * sarg + vt * dxndvd;
        end if;

        // evaluate effective mobility and its derivatives
        ufact  := 1.0;
        ueff   := in_p.m_surfaceMobility * 1e-4;
        dudvgs := 0.0;
        dudvds := 0.0;
        dudvbs := 0.0;
        if (out_c.m_capOx > 0.0) then
          tmp := in_p.m_critField*Spice3.Internal.SpiceConstants.EPSSIL*100/in_p.m_oxideCapFactor;
          if (vgst > tmp) then
            ufact  := exp( in_p.m_critFieldExp * Modelica.Math.log( tmp / vgst));
            ueff   := in_p.m_surfaceMobility * 1.0e-4 * ufact;
            dudvgs := -ufact * in_p.m_critFieldExp / vgst;
            dudvds := 0.0;
            dudvbs := in_p.m_critFieldExp * ufact * dodvbs / vgst;
          end if;
        end if;

        // evaluate saturation voltage and its derivatives according to
        // Grove-Frohman equation
        vgsx   := vgs;
        gammad := gamasd / eta;
        dgdvbs := dgddvb;
        if (in_p.m_fastSurfaceStateDensity <> 0 and out_c.m_capOx <> 0) then
          vgsx := max( vgs, out_c.m_von);
        end if;
        if (gammad > 0) then
          gammd2 := gammad * gammad;
          argv   := (vgsx - vbin) / eta + phiMinVbs;
          if (argv <= 0.0) then
            out_c.m_vdsat := 0.0;
            dsdvgs        := 0.0;
            dsdvbs        := 0.0;
          else
            arg           := sqrt( 1.0 + 4.0 * argv / gammd2);
            out_c.m_vdsat := (vgsx - vbin) / eta + gammd2 * (1.0 - arg) / 2.0;
            out_c.m_vdsat := max( out_c.m_vdsat, 0.0);
            dsdvgs        := (1.0 - 1.0 / arg) / eta;
            dsdvbs        := (gammad * (1.0 - arg) + 2.0 * argv / (gammad * arg))
                             / eta * dgdvbs + 1.0 / arg + factor * dsdvgs;
          end if;
        else
          out_c.m_vdsat := (vgsx - vbin) / eta;
          out_c.m_vdsat := max( out_c.m_vdsat, 0.0);
          dsdvgs        := 1.0;
          dsdvbs        := 0.0;
        end if;

        if (in_p.m_maxDriftVel > 0) then
          // evaluate saturation voltage and its derivatives
          // according to Baum's theory of scattering velocity saturation
          v1 := (vgsx - vbin) / eta + phiMinVbs;
          v2 := phiMinVbs;
          xv := in_p.m_maxDriftVel * out_c.m_lEff / ueff;
          a1 := gammad / 0.75;
          b1 := -2.0 * (v1 + xv);
          c1 := -2.0 * gammad * xv;
          d1 := 2.0 * v1 * (v2 + xv) - v2 * v2 - 4.0 / 3.0 * gammad * sarg3;
          b2 := a1 * c1 - 4.0 * d1;
          r1 := -b1 * b1 / 3.0 + b2;
          s1 := 2.0 * b1 * b1 * (-b1) / 27.0 + b1 * b2 / 3.0 + (-d1) * (a1 * a1 - 4.0 * b1) - c1 * c1;
          s2 := s1 * s1;
          p1 := s2 / 4.0 + r1 * r1 * r1 / 27.0;
          p0 := abs( p1);
          p2 := sqrt( p0);

          sig1[1] :=  1.0;
          sig1[2] := -1.0;
          sig1[3] :=  1.0;
          sig1[4] := -1.0;
          sig2[1] :=  1.0;
          sig2[2] :=  1.0;
          sig2[3] := -1.0;
          sig2[4] := -1.0;

          if (p1 < 0) then
            y3 := 2.0 * exp( Modelica.Math.log( sqrt( s2 / 4.0 + p0)) / 3.0)
                  * cos( Modelica.Math.atan( -2.0 * p2 / s1) / 3.0) + b1 / 3.0;
          else
            y3 := exp( Modelica.Math.log( abs( -s1 / 2.0 + p2)) / 3.0)
                  + exp( Modelica.Math.log( abs( -s1 / 2.0 - p2)) / 3.0)
                  + b1 / 3.0;
          end if;

          a3 := sqrt( a1 * a1 / 4.0 - b1 + y3);
          b3 := sqrt( y3 * y3 / 4.0 - d1);

          for i in 1:4 loop
            a4[i]  := a1/2.0+sig1[i]*a3;
            b4[i]  := y3/2.0+sig2[i]*b3;
            delta4 := a4[i]*a4[i]/4.0-b4[i];
            if (delta4 >= 0) then
              iknt     := iknt+1;
              tmp      := sqrt(delta4);
              x4[iknt] := -a4[i]/2.0+tmp;
              iknt     := iknt+1;
              x4[iknt] := -a4[i]/2.0-tmp;
            end if;
          end for;
          jknt := 0;
          for j in 1:iknt loop
            if (x4[j] > 0) then
              poly4[j] := x4[j]*x4[j]*x4[j]*x4[j]+a1*x4[j]*x4[j]*x4[j];
              poly4[j] := poly4[j]+b1*x4[j]*x4[j]+c1*x4[j]+d1;
              if (abs(poly4[j]) <= 1.0e-6) then
                jknt := jknt+1;
                if (jknt <= 1) then
                  xvalid := x4[j];
                end if;
                if (x4[j] <= xvalid) then
                  xvalid := x4[j];
                end if;
              end if;
            end if;
          end for;

          if (jknt > 0) then
            out_c.m_vdsat := xvalid * xvalid - phiMinVbs;
          end if;
        end if;

        // evaluate effective channel length and its derivatives
        dldvgs := 0.0;
        dldvds := 0.0;
        dldvbs := 0.0;
        if (vds <> 0.0) then
          gammad :=gamasd;
          if ((vbs - out_c.m_vdsat) <= 0) then
            bsarg  := sqrt(out_c.m_vdsat + phiMinVbs);
            dbsrdb := -0.5 / bsarg;
          else
            bsarg  :=sphi/(1.0 + 0.5*(vbs - out_c.m_vdsat)/out_c.m_tPhi);
            dbsrdb :=-0.5*bsarg*bsarg/sphi3;
          end if;
          bodys  := bsarg * bsarg * bsarg - sarg3;
          gdbdvs := 2.0 * gammad * (bsarg * bsarg * dbsrdb - sarg * sarg * dsrgdb);
          if (in_p.m_maxDriftVel <= 0) then
            if (in_p.m_substrateDoping <> 0.0 and (xlamda <= 0.0)) then
              argv   := (vds - out_c.m_vdsat) / 4.0;
              sargv  := sqrt(1.0 + argv * argv);
              arg    := sqrt(argv + sargv);
              xlfact := in_p.m_xd / (out_c.m_lEff * vds);
              xlamda := xlfact * arg;
              dldsat := vds * xlamda / (8.0 * sargv);

              dldvgs := dldsat * dsdvgs;
              dldvds := -xlamda + dldsat;
              dldvbs := dldsat * dsdvbs;
            end if;
          else
            argv   := (vgsx - vbin) / eta - out_c.m_vdsat;
            xdv    := in_p.m_xd / sqrt(in_p.m_channelCharge);
            xlv    := in_p.m_maxDriftVel * xdv / (2.0 * ueff);
            vqchan := argv - gammad * bsarg;
            dqdsat := -1.0 + gammad * dbsrdb;
            vl     := in_p.m_maxDriftVel *out_c. m_lEff;
            dfunds := vl * dqdsat - ueff * vqchan;
            dfundg := (vl - ueff * out_c.m_vdsat) / eta;
            dfundb := -vl * (1.0 + dqdsat - factor / eta) + ueff *
               (gdbdvs - dgdvbs * bodys / 1.5) / eta;
            dsdvgs := -dfundg / dfunds;
            dsdvbs := -dfundb / dfunds;
            if ((in_p.m_substrateDoping <> 0.0) and (xlamda <= 0.0)) then
              argv   := vds - out_c.m_vdsat;
              argv   := max(argv,0.0);
              xls    := sqrt(xlv * xlv + argv);
              dldsat := xdv / (2.0 * xls);
              xlfact := xdv / (out_c.m_lEff * vds);
              xlamda := xlfact * (xls - xlv);
              dldsat := dldsat / out_c.m_lEff;

              dldvgs := dldsat * dsdvgs;
              dldvds := -xlamda + dldsat;
              dldvbs := dldsat * dsdvbs;
            end if;
          end if;
        end if;

        // limit channel shortening at punch-through
        xwb    :=in_p.m_xd*sqrt(out_c.m_tBulkPot);
        xld    :=out_c.m_lEff - xwb;
        clfact :=1.0 - xlamda*vds;
        dldvds :=-xlamda - dldvds;
        xleff  :=out_c.m_lEff*clfact;
        deltal :=xlamda*vds*out_c.m_lEff;
        if (in_p.m_substrateDoping == 0.0) then
          xwb := 0.25e-6;
        end if;
        if (xleff < xwb) then
          xleff  := xwb / (1.0 + (deltal - xld) / xwb);
          clfact := xleff / out_c.m_lEff;
          dfact  := xleff * xleff / (xwb * xwb);
          dldvgs := dfact * dldvgs;
          dldvds := dfact * dldvds;
          dldvbs := dfact * dldvbs;
        end if;

        // evaluate effective beta (effective kp)
        beta1 := out_c.m_Beta * ufact / clfact;

        // test for mode of operation and branch appropriately
        gammad := gamasd;
        dgdvbs := dgddvb;
        if (vds <= 1.0e-10) then
          if (vgs <= out_c.m_von) then
            if ((in_p.m_fastSurfaceStateDensity == 0.0) or (out_c.m_capOx == 0.0)) then
              out_c.m_gds := 0.0;
            else
              out_c.m_gds := beta1 * (out_c.m_von - vbin - gammad * sarg) * exp(argg * (vgs - out_c.m_von));
            end if;
          else
            out_c.m_gds :=beta1*(vgs - vbin - gammad*sarg);
          end if;
          out_c.m_cdrain :=0.0;
          out_c.m_gm     :=0.0;
          out_c.m_gmbs   :=0.0;
          return;
        end if;

        if (vgs <= out_c.m_von) then
          // subthreshold region
          if (out_c.m_vdsat <= 0) then
            out_c.m_gds    := 0.0;
            if (vgs > vth) then
              return;
            end if;
            out_c.m_cdrain := 0.0;
            out_c.m_gm     := 0.0;
            out_c.m_gmbs   := 0.0;
            return;
          end if;
          vdson := min(out_c.m_vdsat, vds);
          if (vds > out_c.m_vdsat) then
            barg   := bsarg;
            dbrgdb := dbsrdb;
            body   := bodys;
            gdbdv  := gdbdvs;
          end if;
          cdson  := beta1 * ((out_c.m_von - vbin - eta * vdson * 0.5) * vdson - gammad * body / 1.5);
          didvds := beta1 * (out_c.m_von - vbin - eta * vdson - gammad * barg);
          gdson  := -cdson * dldvds / clfact - beta1 * dgdvds * body / 1.5;
          if (vds < out_c.m_vdsat) then
            gdson := gdson + didvds;
          end if;
          gbson := -cdson * dldvbs / clfact + beta1 *
                   (dodvbs * vdson + factor * vdson - dgdvbs * body / 1.5 - gdbdv);
          if (vds > out_c.m_vdsat) then
            gbson := gbson + didvds * dsdvbs;
          end if;
          expg           := exp(argg * (vgs - out_c.m_von));
          out_c.m_cdrain := cdson * expg;
          gmw            := out_c.m_cdrain * argg;
          out_c.m_gm     := gmw;
          if (vds > out_c.m_vdsat) then
            out_c.m_gm := gmw + didvds * dsdvgs * expg;
          end if;
          tmp          := gmw * (vgs - out_c.m_von) / xn;
          out_c.m_gds  := gdson * expg - out_c.m_gm * dodvds - tmp * dxndvd;
          out_c.m_gmbs := gbson * expg - out_c.m_gm * dodvbs - tmp * dxndvb;
        elseif (vds <= out_c.m_vdsat) then
          // linear region
          out_c.m_cdrain := beta1 * ((vgs - vbin - eta * vds / 2.0) * vds - gammad * body / 1.5);
          arg            := out_c.m_cdrain * (dudvgs / ufact - dldvgs / clfact);
          out_c.m_gm     := arg + beta1 * vds;
          arg            := out_c.m_cdrain * (dudvds / ufact - dldvds / clfact);
          out_c.m_gds    := arg + beta1 * (vgs - vbin - eta *
                            vds - gammad * barg - dgdvds * body / 1.5);
          arg            := out_c.m_cdrain * (dudvbs / ufact - dldvbs / clfact);
          out_c.m_gmbs   := arg - beta1 * (gdbdv + dgdvbs * body / 1.5 - factor * vds);
        else
          // saturation region
          out_c.m_cdrain := beta1 * ((vgs - vbin - eta *
                           out_c.m_vdsat / 2.0) * out_c.m_vdsat - gammad * bodys / 1.5);
          arg            := out_c.m_cdrain * (dudvgs / ufact - dldvgs / clfact);
          out_c.m_gm     := arg + beta1 * out_c.m_vdsat
                           + beta1 * (vgs - vbin - eta * out_c.m_vdsat - gammad * bsarg) * dsdvgs;
          out_c.m_gds    := -out_c.m_cdrain * dldvds / clfact - beta1 * dgdvds * bodys / 1.5;
          arg            := out_c.m_cdrain * (dudvbs / ufact - dldvbs / clfact);
          out_c.m_gmbs   := arg - beta1 * (gdbdvs + dgdvbs * bodys / 1.5 - factor * out_c.m_vdsat)
                           + beta1 *  (vgs - vbin - eta * out_c.m_vdsat - gammad * bsarg) * dsdvbs;
        end if;

        annotation (Documentation(info="<html>
<p>This function drainCur calculates the main currents that flows from drain node to source node (level 2).</p>
</html>"));
      end drainCurRevised;

      function drainCur
        "Drain current calculation obsolete, use drainCurRevised"
        extends Modelica.Icons.Function;
        extends Modelica.Icons.ObsoleteModel;

        input SI.Voltage vbs;
        input SI.Voltage vgs;
        input SI.Voltage vds;

        input Spice3.Internal.Mosfet.Mosfet in_m "Record MOSFET";
        input Mos2Calc in_c "Input record Mos2Calc";
        input Mos2ModelLineParams in_p
          "Input record model line parameters for MOS2";
        input Spice3.Internal.SpiceConstants in_C "Spice constants";
        input Mos2ModelLineVariables in_vp "Input record model line variables";
        input Integer in_m_type "Type of MOS transistor";

        output Mos2Calc out_c "Output record Mos2Calc";

      protected
        Real vt;      // K * T / Q
        Real beta1;
        Real dsrgdb;
        Real d2sdb2;
        Real sphi = 0.0;
        Real sphi3 = 1.0;    // square root of phi
        Real barg;
        Real sarg;
        Real bsarg = 0.0;
        Real sarg3;
        Real d2bdb2;
        Real factor;
        Real dbrgdb;
        Real eta;
        Real vbin;
        Real vth;
        Real dgddb2;
        Real dgddvb;
        Real dgdvds;
        Real gamasd;
        Real gammad;
        Real xn =   1.0;
        Real argg = 0.0;
        Real vgst;
        Real vgsx;
        Real dgdvbs;
        Real body;
        Real bodys = 0.0;
        Real gdbdv;
        Real dodvbs;
        Real dodvds = 0.0;
        Real dxndvd = 0.0;
        Real dxndvb = 0.0;
        Real dudvgs;
        Real dudvds;
        Real dudvbs;
        Real ufact;
        Real ueff;
        Real dsdvgs;
        Real dsdvbs;
        Real dbsrdb = 0.0;
        Real gdbdvs = 0.0;
        Real dldvgs;
        Real dldvds;
        Real dldvbs;
        Real clfact;
        Real xleff;
        Real deltal;
        Real xwb;
        Real xld;
        Real xlamda = in_p.m_lambda;
        Real phiMinVbs;
        Real tmp;

        Real argss;
        Real argsd;
        Real args = 0.0;
        Real argd = 0.0;
        Real argxs = 0.0;
        Real argxd = 0.0;
        Real dbargs;
        Real dbargd;
        Real dbxws;
        Real dbxwd;
        Real xwd;
        Real xws;
        Real daddb2;
        Real dasdb2;
        Real ddxwd;
        Real cfs;
        Real cdonco;
        Real argv;
        Real gammd2;
        Real arg;
        Real y3;
        Real xvalid = 0.0;
        Real[4] sig1;
        Real[4] sig2;
        Real[4] a4;
        Real[4] b4;
        Real[8] x4 = fill(0.0, 8);
        Real[8] poly4;
        Real delta4;
        Integer j;
        Integer iknt = 0;
        Integer i;
        Integer jknt = 0;
        Real v1;
        Real v2;
        Real xv;
        Real a1;
        Real b1;
        Real c1;
        Real d1;
        Real b2;
        Real r1;
        Real s1;
        Real s2;
        Real p1;
        Real p0;
        Real p2;
        Real a3;
        Real b3;
        Real sargv;
        Real dldsat;
        Real xlfact;
        Real xdv;
        Real xlv;
        Real vqchan;
        Real dqdsat;
        Real vl;
        Real dfunds;
        Real dfundg;
        Real dfundb;
        Real xls;
        Real dfact;
        Real vdson;
        Real cdson;
        Real gdson;
        Real didvds;
        Real gmw;
        Real gbson;
        Real expg;

      algorithm
        out_c := in_c;

        vt := in_C.CONSTKoverQ * in_C.REFTEMP;

        phiMinVbs := out_c.m_tPhi - vbs;
        if ( vbs <= 0.0) then
          sarg   := sqrt( phiMinVbs);
          dsrgdb := -0.5 / sarg;
          d2sdb2 := 0.5 * dsrgdb / phiMinVbs;
        else
          sphi   :=sqrt(out_c.m_tPhi);
          sphi3  :=out_c.m_tPhi*sphi;
          sarg   :=sphi/(1.0 + 0.5*vbs/out_c.m_tPhi);
          tmp    :=sarg/sphi3;
          dsrgdb :=-0.5*sarg*tmp;
          d2sdb2 :=-dsrgdb*tmp;
        end if;

        if ( (vds-vbs) >= 0) then
          barg   := sqrt( phiMinVbs + vds);
          dbrgdb := -0.5 / barg;
          d2bdb2 := 0.5 * dbrgdb / (phiMinVbs + vds);
        else
          barg   := sphi / (1.0 + 0.5 * (vbs - vds) / out_c.m_tPhi);
          tmp    := barg / sphi3;
          dbrgdb := -0.5 * barg * tmp;
          d2bdb2 := -dbrgdb * tmp;
        end if;

        factor := 0.125 * in_p.m_narrowFactor * 2.0 * Modelica.Constants.pi*in_C.EPSSIL / out_c.m_capOx * out_c.m_lEff;

        eta    := 1.0 + factor;
        vbin   := out_c.m_tVbi * in_m_type + factor * phiMinVbs;
        if ( (in_vp.m_gamma > 0.0) or (in_vp.m_substrateDoping > 0.0)) then
          xwd := in_vp.m_xd * barg;
          xws := in_vp.m_xd * sarg;

          argss  := 0.0;
          argsd  := 0.0;
          dbargs := 0.0;
          dbargd := 0.0;
          dgdvds := 0.0;
          dgddb2 := 0.0;
          if ( in_p.m_junctionDepth > 0) then
            tmp   := 2.0 / in_p.m_junctionDepth;
            argxs := 1.0 + xws * tmp;
            argxd := 1.0 + xwd * tmp;
            args  := sqrt( argxs);
            argd  := sqrt( argxd);
            tmp   := 0.5 * in_p.m_junctionDepth / out_c.m_lEff;
            argss := tmp * (args - 1.0);
            argsd := tmp * (argd - 1.0);
          end if;
          gamasd := in_vp.m_gamma * (1.0 - argss - argsd);
          dbxwd  := in_vp.m_xd * dbrgdb;
          dbxws  := in_vp.m_xd * dsrgdb;
          if ( in_p.m_junctionDepth > 0) then
            tmp    := 0.5 / out_c.m_lEff;
            dbargs := tmp * dbxws / args;
            dbargd := tmp * dbxwd / argd;
            dasdb2 := -in_vp.m_xd * (d2sdb2 + dsrgdb * dsrgdb * in_vp.m_xd
                      / (in_p.m_junctionDepth * argxs)) / (out_c.m_lEff * args);
            daddb2 := -in_vp.m_xd * (d2bdb2 + dbrgdb * dbrgdb * in_vp.m_xd
                      / (in_p.m_junctionDepth * argxd))
                      / (out_c.m_lEff * argd);
            dgddb2 := -0.5 * in_vp.m_gamma * (dasdb2 + daddb2);
          end if;
          dgddvb := -in_vp.m_gamma * (dbargs + dbargd);
          if ( in_p.m_junctionDepth > 0) then
            ddxwd  := -dbxwd;
            dgdvds := -in_vp.m_gamma * 0.5 * ddxwd / (out_c.m_lEff * argd);
          end if;
        else
          gamasd := in_vp.m_gamma;
          gammad := in_vp.m_gamma;
          dgddvb := 0.0;
          dgdvds := 0.0;
          dgddb2 := 0.0;
        end if;

        out_c.m_von   := vbin + gamasd * sarg;
        vth           := out_c.m_von;
        out_c.m_vdsat := 0.0;
        if ( in_p.m_fastSurfaceStateDensity <> 0.0 and out_c.m_capOx <> 0.0) then
          cfs          := in_C.CHARGE * in_p.m_fastSurfaceStateDensity * 1.0e4;
          cdonco       := -(gamasd * dsrgdb + dgddvb * sarg) + factor;
          xn           := 1.0 + cfs / out_c.m_capOx * in_m.m_width * out_c.m_lEff + cdonco;
          tmp          := vt * xn;
          out_c.m_von  := out_c.m_von + tmp;
          argg         := 1.0 / tmp;
          vgst         := vgs - out_c.m_von;
        else
          vgst := vgs - out_c.m_von;
          if ( vgs <= out_c.m_von) then
            // cutoff region
            out_c.m_gds    := 0.0;
            out_c.m_cdrain := 0.0;
            out_c.m_gm     := 0.0;
            out_c.m_gmbs   := 0.0;
            return;
          end if;
        end if;

        sarg3  := sarg * sarg * sarg;
        gammad := gamasd;
        dgdvbs := dgddvb;
        body   := barg * barg * barg - sarg3;
        gdbdv  := 2.0 * gammad * (barg * barg * dbrgdb - sarg * sarg * dsrgdb);
        dodvbs := -factor + dgdvbs * sarg + gammad * dsrgdb;

        if ( (in_p.m_fastSurfaceStateDensity <> 0.0) and (out_c.m_capOx <> 0.0)) then
          dxndvb := 2.0 * dgdvbs * dsrgdb + gammad * d2sdb2 + dgddb2 * sarg;
          dodvbs := dodvbs + vt * dxndvb;
          dxndvd := dgdvds * dsrgdb;
          dodvds := dgdvds * sarg + vt * dxndvd;
        end if;

        // evaluate effective mobility and its derivatives
        ufact  := 1.0;
        ueff   := in_p.m_surfaceMobility * 1e-4;
        dudvgs := 0.0;
        dudvds := 0.0;
        dudvbs := 0.0;
        if (out_c.m_capOx > 0.0) then
          tmp := in_p.m_critField * in_C.EPSSIL * 100 / in_vp.m_oxideCapFactor;
          if (vgst > tmp) then
            ufact  := exp( in_p.m_critFieldExp * Modelica.Math.log( tmp / vgst));
            ueff   := in_p.m_surfaceMobility * 1.0e-4 * ufact;
            dudvgs := -ufact * in_p.m_critFieldExp / vgst;
            dudvds := 0.0;
            dudvbs := in_p.m_critFieldExp * ufact * dodvbs / vgst;
          end if;
        end if;

        // evaluate saturation voltage and its derivatives according to
        // Grove-Frohman equation
        vgsx   := vgs;
        gammad := gamasd / eta;
        dgdvbs := dgddvb;
        if (in_p.m_fastSurfaceStateDensity <> 0 and out_c.m_capOx <> 0) then
          vgsx := max( vgs, out_c.m_von);
        end if;
        if (gammad > 0) then
          gammd2 := gammad * gammad;
          argv   := (vgsx - vbin) / eta + phiMinVbs;
          if (argv <= 0.0) then
            out_c.m_vdsat := 0.0;
            dsdvgs        := 0.0;
            dsdvbs        := 0.0;
          else
            arg           := sqrt( 1.0 + 4.0 * argv / gammd2);
            out_c.m_vdsat := (vgsx - vbin) / eta + gammd2 * (1.0 - arg) / 2.0;
            out_c.m_vdsat := max( out_c.m_vdsat, 0.0);
            dsdvgs        := (1.0 - 1.0 / arg) / eta;
            dsdvbs        := (gammad * (1.0 - arg) + 2.0 * argv / (gammad * arg))
                             / eta * dgdvbs + 1.0 / arg + factor * dsdvgs;
          end if;
        else
          out_c.m_vdsat := (vgsx - vbin) / eta;
          out_c.m_vdsat := max( out_c.m_vdsat, 0.0);
          dsdvgs        := 1.0;
          dsdvbs        := 0.0;
        end if;

        if (in_p.m_maxDriftVel > 0) then
          // evaluate saturation voltage and its derivatives
          // according to Baum's theory of scattering velocity saturation
          v1 := (vgsx - vbin) / eta + phiMinVbs;
          v2 := phiMinVbs;
          xv := in_p.m_maxDriftVel * out_c.m_lEff / ueff;
          a1 := gammad / 0.75;
          b1 := -2.0 * (v1 + xv);
          c1 := -2.0 * gammad * xv;
          d1 := 2.0 * v1 * (v2 + xv) - v2 * v2 - 4.0 / 3.0 * gammad * sarg3;
          b2 := a1 * c1 - 4.0 * d1;
          r1 := -b1 * b1 / 3.0 + b2;
          s1 := 2.0 * b1 * b1 * (-b1) / 27.0 + b1 * b2 / 3.0 + (-d1) * (a1 * a1 - 4.0 * b1) - c1 * c1;
          s2 := s1 * s1;
          p1 := s2 / 4.0 + r1 * r1 * r1 / 27.0;
          p0 := abs( p1);
          p2 := sqrt( p0);

          sig1[1] :=  1.0;
          sig1[2] := -1.0;
          sig1[3] :=  1.0;
          sig1[4] := -1.0;
          sig2[1] :=  1.0;
          sig2[2] :=  1.0;
          sig2[3] := -1.0;
          sig2[4] := -1.0;

          if (p1 < 0) then
            y3 := 2.0 * exp( Modelica.Math.log( sqrt( s2 / 4.0 + p0)) / 3.0)
                  * cos( Modelica.Math.atan( -2.0 * p2 / s1) / 3.0) + b1 / 3.0;
          else
            y3 := exp( Modelica.Math.log( abs( -s1 / 2.0 + p2)) / 3.0)
                  + exp( Modelica.Math.log( abs( -s1 / 2.0 - p2)) / 3.0)
                  + b1 / 3.0;
          end if;

          a3 := sqrt( a1 * a1 / 4.0 - b1 + y3);
          b3 := sqrt( y3 * y3 / 4.0 - d1);

          for i in 1:4 loop
            a4[i]  := a1/2.0+sig1[i]*a3;
            b4[i]  := y3/2.0+sig2[i]*b3;
            delta4 := a4[i]*a4[i]/4.0-b4[i];
            if (delta4 >= 0) then
              iknt     := iknt+1;
              tmp      := sqrt(delta4);
              x4[iknt] := -a4[i]/2.0+tmp;
              iknt     := iknt+1;
              x4[iknt] := -a4[i]/2.0-tmp;
            end if;
          end for;
          jknt := 0;
          for j in 1:iknt loop
            if (x4[j] > 0) then
              poly4[j] := x4[j]*x4[j]*x4[j]*x4[j]+a1*x4[j]*x4[j]*x4[j];
              poly4[j] := poly4[j]+b1*x4[j]*x4[j]+c1*x4[j]+d1;
              if (abs(poly4[j]) <= 1.0e-6) then
                jknt := jknt+1;
                if (jknt <= 1) then
                  xvalid := x4[j];
                end if;
                if (x4[j] <= xvalid) then
                  xvalid := x4[j];
                end if;
              end if;
            end if;
          end for;

          if (jknt > 0) then
            out_c.m_vdsat := xvalid * xvalid - phiMinVbs;
          end if;
        end if;

        // evaluate effective channel length and its derivatives
        dldvgs := 0.0;
        dldvds := 0.0;
        dldvbs := 0.0;
        if (vds <> 0.0) then
          gammad :=gamasd;
          if ((vbs - out_c.m_vdsat) <= 0) then
            bsarg  := sqrt(out_c.m_vdsat + phiMinVbs);
            dbsrdb := -0.5 / bsarg;
          else
            bsarg  :=sphi/(1.0 + 0.5*(vbs - out_c.m_vdsat)/out_c.m_tPhi);
            dbsrdb :=-0.5*bsarg*bsarg/sphi3;
          end if;
          bodys  := bsarg * bsarg * bsarg - sarg3;
          gdbdvs := 2.0 * gammad * (bsarg * bsarg * dbsrdb - sarg * sarg * dsrgdb);
          if (in_p.m_maxDriftVel <= 0) then
            if (in_vp.m_substrateDoping <> 0.0 and (xlamda <= 0.0)) then
              argv   := (vds - out_c.m_vdsat) / 4.0;
              sargv  := sqrt(1.0 + argv * argv);
              arg    := sqrt(argv + sargv);
              xlfact := in_vp.m_xd / (out_c.m_lEff * vds);
              xlamda := xlfact * arg;
              dldsat := vds * xlamda / (8.0 * sargv);

              dldvgs := dldsat * dsdvgs;
              dldvds := -xlamda + dldsat;
              dldvbs := dldsat * dsdvbs;
            end if;
          else
            argv   := (vgsx - vbin) / eta - out_c.m_vdsat;
            xdv    := in_vp.m_xd / sqrt(in_p.m_channelCharge);
            xlv    := in_p.m_maxDriftVel * xdv / (2.0 * ueff);
            vqchan := argv - gammad * bsarg;
            dqdsat := -1.0 + gammad * dbsrdb;
            vl     := in_p.m_maxDriftVel *out_c. m_lEff;
            dfunds := vl * dqdsat - ueff * vqchan;
            dfundg := (vl - ueff * out_c.m_vdsat) / eta;
            dfundb := -vl * (1.0 + dqdsat - factor / eta) + ueff *
               (gdbdvs - dgdvbs * bodys / 1.5) / eta;
            dsdvgs := -dfundg / dfunds;
            dsdvbs := -dfundb / dfunds;
            if ((in_vp.m_substrateDoping <> 0.0) and (xlamda <= 0.0)) then
              argv   := vds - out_c.m_vdsat;
              argv   := max(argv,0.0);
              xls    := sqrt(xlv * xlv + argv);
              dldsat := xdv / (2.0 * xls);
              xlfact := xdv / (out_c.m_lEff * vds);
              xlamda := xlfact * (xls - xlv);
              dldsat := dldsat / out_c.m_lEff;

              dldvgs := dldsat * dsdvgs;
              dldvds := -xlamda + dldsat;
              dldvbs := dldsat * dsdvbs;
            end if;
          end if;
        end if;

        // limit channel shortening at punch-through
        xwb    :=in_vp.m_xd*sqrt(out_c.m_tBulkPot);
        xld    :=out_c.m_lEff - xwb;
        clfact :=1.0 - xlamda*vds;
        dldvds :=-xlamda - dldvds;
        xleff  :=out_c.m_lEff*clfact;
        deltal :=xlamda*vds*out_c.m_lEff;
        if (in_vp.m_substrateDoping == 0.0) then
          xwb := 0.25e-6;
        end if;
        if (xleff < xwb) then
          xleff  := xwb / (1.0 + (deltal - xld) / xwb);
          clfact := xleff / out_c.m_lEff;
          dfact  := xleff * xleff / (xwb * xwb);
          dldvgs := dfact * dldvgs;
          dldvds := dfact * dldvds;
          dldvbs := dfact * dldvbs;
        end if;

        // evaluate effective beta (effective kp)
        beta1 := out_c.m_Beta * ufact / clfact;

        // test for mode of operation and branch appropriately
        gammad := gamasd;
        dgdvbs := dgddvb;
        if (vds <= 1.0e-10) then
          if (vgs <= out_c.m_von) then
            if ((in_p.m_fastSurfaceStateDensity == 0.0) or (out_c.m_capOx == 0.0)) then
              out_c.m_gds := 0.0;
            else
              out_c.m_gds := beta1 * (out_c.m_von - vbin - gammad * sarg) * exp(argg * (vgs - out_c.m_von));
            end if;
          else
            out_c.m_gds :=beta1*(vgs - vbin - gammad*sarg);
          end if;
          out_c.m_cdrain :=0.0;
          out_c.m_gm     :=0.0;
          out_c.m_gmbs   :=0.0;
          return;
        end if;

        if (vgs <= out_c.m_von) then
          // subthreshold region
          if (out_c.m_vdsat <= 0) then
            out_c.m_gds    := 0.0;
            if (vgs > vth) then
              return;
            end if;
            out_c.m_cdrain := 0.0;
            out_c.m_gm     := 0.0;
            out_c.m_gmbs   := 0.0;
            return;
          end if;
          vdson := min(out_c.m_vdsat, vds);
          if (vds > out_c.m_vdsat) then
            barg   := bsarg;
            dbrgdb := dbsrdb;
            body   := bodys;
            gdbdv  := gdbdvs;
          end if;
          cdson  := beta1 * ((out_c.m_von - vbin - eta * vdson * 0.5) * vdson - gammad * body / 1.5);
          didvds := beta1 * (out_c.m_von - vbin - eta * vdson - gammad * barg);
          gdson  := -cdson * dldvds / clfact - beta1 * dgdvds * body / 1.5;
          if (vds < out_c.m_vdsat) then
            gdson := gdson + didvds;
          end if;
          gbson := -cdson * dldvbs / clfact + beta1 *
                   (dodvbs * vdson + factor * vdson - dgdvbs * body / 1.5 - gdbdv);
          if (vds > out_c.m_vdsat) then
            gbson := gbson + didvds * dsdvbs;
          end if;
          expg           := exp(argg * (vgs - out_c.m_von));
          out_c.m_cdrain := cdson * expg;
          gmw            := out_c.m_cdrain * argg;
          out_c.m_gm     := gmw;
          if (vds > out_c.m_vdsat) then
            out_c.m_gm := gmw + didvds * dsdvgs * expg;
          end if;
          tmp          := gmw * (vgs - out_c.m_von) / xn;
          out_c.m_gds  := gdson * expg - out_c.m_gm * dodvds - tmp * dxndvd;
          out_c.m_gmbs := gbson * expg - out_c.m_gm * dodvbs - tmp * dxndvb;
        elseif (vds <= out_c.m_vdsat) then
          // linear region
          out_c.m_cdrain := beta1 * ((vgs - vbin - eta * vds / 2.0) * vds - gammad * body / 1.5);
          arg            := out_c.m_cdrain * (dudvgs / ufact - dldvgs / clfact);
          out_c.m_gm     := arg + beta1 * vds;
          arg            := out_c.m_cdrain * (dudvds / ufact - dldvds / clfact);
          out_c.m_gds    := arg + beta1 * (vgs - vbin - eta *
                            vds - gammad * barg - dgdvds * body / 1.5);
          arg            := out_c.m_cdrain * (dudvbs / ufact - dldvbs / clfact);
          out_c.m_gmbs   := arg - beta1 * (gdbdv + dgdvbs * body / 1.5 - factor * vds);
        else
          // saturation region
          out_c.m_cdrain := beta1 * ((vgs - vbin - eta *
                           out_c.m_vdsat / 2.0) * out_c.m_vdsat - gammad * bodys / 1.5);
          arg            := out_c.m_cdrain * (dudvgs / ufact - dldvgs / clfact);
          out_c.m_gm     := arg + beta1 * out_c.m_vdsat
                           + beta1 * (vgs - vbin - eta * out_c.m_vdsat - gammad * bsarg) * dsdvgs;
          out_c.m_gds    := -out_c.m_cdrain * dldvds / clfact - beta1 * dgdvds * bodys / 1.5;
          arg            := out_c.m_cdrain * (dudvbs / ufact - dldvbs / clfact);
          out_c.m_gmbs   := arg - beta1 * (gdbdvs + dgdvbs * bodys / 1.5 - factor * out_c.m_vdsat)
                           + beta1 *  (vgs - vbin - eta * out_c.m_vdsat - gammad * bsarg) * dsdvbs;
        end if;

        annotation (Documentation(info="<html>
<p>This function drainCur calculates the main currents that flows from drain node to source node (level 2).</p>
</html>"),
        obsolete = "Obsolete function - use Modelica.Electrical.Spice3.Internal.Mos2.drainCurRevised instead");
      end drainCur;

      function mos2RenameParametersRevised
        "Parameter renaming to internal names"
        extends Modelica.Icons.Function;
        input Spice3.Internal.ModelcardMOS2 ex
          "Modelcard with technology parameters";

        output Modelica.Electrical.Spice3.Internal.Mos2.Mos2ModelLineParams intern
          "Output record model line parameters";

      algorithm
        intern.m_narrowFactor := ex.DELTA;           // DELTA, Width effect on threshold
        intern.m_critFieldExp := ex.UEXP;            // UEXP, Crit. field exp for mob. deg
        intern.m_critField := ex.UCRIT;              // UCRIT, Crit. field for mob. degradation
        intern.m_maxDriftVel := ex.VMAX;             // VMAX, Maximum carrier drift velocity
        intern.m_junctionDepth := ex.XJ;             // XJ, Junction depth
        intern.m_channelCharge := ex.NEFF;           // NEFF, Total channel charge coeff
        intern.m_fastSurfaceStateDensity := ex.NFS;  // NFS, Fast surface state density

        // MosModelLineParams
        intern.m_oxideCapFactor := 0;
        intern.m_vtOIsGiven := if (ex.VTO > -1e40) then 1 else 0;
        intern.m_vt0 := if (ex.VTO > -1e40) then ex.VTO else 0;
        intern.m_capBDIsGiven := if (ex.CBD > -1e40) then 1 else 0;
        intern.m_capBD := if (ex.CBD > -1e40) then ex.CBD else 0;
        intern.m_capBSIsGiven := if (ex.CBS > -1e40) then 1 else 0;
        intern.m_capBS := if (ex.CBS > -1e40) then ex.CBS else 0;
        intern.m_bulkCapFactor := ex.CJ;           // F/(m*m) zero-bias bulk junction bottom cap. per sq-meter of junction area (default 0)
        intern.m_sideWallCapFactor := ex.CJSW;     // F/m zero-bias junction sidewall cap. per meter of junction perimeter (default 0)
        intern.m_fwdCapDepCoeff := ex.FC;          // coefficient for forward-bias depletion capacitance formula (default 0.5)
        intern.m_phiIsGiven := if (ex.PHI > -1e40) then 1 else 0;
        intern.m_phi := if (ex.PHI > -1e40) then ex.PHI else 0.6;
        intern.m_gammaIsGiven := if (ex.GAMMA > -1e40) then 1 else 0;
        intern.m_gamma := if (ex.GAMMA > -1e40) then ex.GAMMA else 0;
        intern.m_lambda := ex.LAMBDA;              // 1/V channel-length modulation (default 0)
        intern.m_substrateDopingIsGiven := if (ex.NSUB > -1e40) then 1 else 0;
        intern.m_substrateDoping := if (ex.NSUB > -1e40) then ex.NSUB else 0;
        intern.m_gateType := ex.TPG;               // type of gate material: +1 opp. to substrate, -1 same as substrate, 0 Al gate (default 1)
        intern.m_surfaceStateDensity := ex.NSS;    // 1/(cm*cm) surface state density (default 0)
        intern.m_surfaceMobility := ex.UO;         // (cm*cm)/(Vs) surface mobility (default 600)
        intern.m_latDiff := ex.LD;                 // m lateral diffusion (default 0)
        intern.m_jctSatCur := ex.IS;               // A bulk junction saturation current (default 1e-14)
        intern.m_drainResistanceIsGiven := if (ex.RD > -1e40) then 1 else 0;
        intern.m_drainResistance := if (ex.RD > -1e40) then ex.RD else 0;
        intern.m_sourceResistanceIsGiven := if (ex.RS > -1e40) then 1 else 0;
        intern.m_sourceResistance := if (ex.RS > -1e40) then ex.RS else 0;
        intern.m_transconductanceIsGiven := if (ex.KP > -1e40) then 1 else 0;
        intern.m_transconductance := if (ex.KP > -1e40) then ex.KP else 2e-5;
        intern.m_tnom := ex.TNOM + Spice3.Internal.SpiceConstants.CONSTCtoK;

        // MosfetModelLineParams
        intern.m_jctSatCurDensity := ex.JS;             // A/(m*m) bulk junction saturation current per sq-meter of junction area (default 0)
        intern.m_sheetResistance := ex.RSH;             // Ohm drain and source diffusion sheet resistance (default 0)
        intern.m_bulkJctPotential := ex.PB;             // V bulk junction potential (default 0.8)
        intern.m_bulkJctBotGradingCoeff := ex.MJ;       // bulk junction bottom grading coeff. (default 0.5)
        intern.m_bulkJctSideGradingCoeff := ex.MJSW;    // bulk junction sidewall grading coeff. (default 0.5)
        intern.m_oxideThickness := if (ex.TOX > -1e40) then ex.TOX else 1e-7; // m oxide thickness (default 1e-7)
        intern.m_gateSourceOverlapCapFactor := ex.CGSO; // F/m gate-source overlap capacitance per meter channel width (default 0)
        intern.m_gateDrainOverlapCapFactor := ex.CGDO;  // F/m gate-drain overlap capacitance per meter channel width (default 0)
        intern.m_gateBulkOverlapCapFactor := ex.CGBO;   // F/m gate-bulk overlap capacitance per meter channel width (default 0)
        intern.m_fNcoef := ex.KF;                       // flicker-noise coefficient (default 0)
        intern.m_fNexp := ex.AF;                        // flicker-noise exponent (default 1)

        annotation (Documentation(info="<html>
<p>This function mos2RenameParameters assigns the external (given by the user, e.g., RD) technology parameters
to the internal parameters (e.g., m_drainResistance). It also does the analysis of the IsGiven values (level 2).</p>
</html>"));
      end mos2RenameParametersRevised;

      function mos2RenameParameters
        "Parameter renaming to internal names obsolete, use mos2RenameParametersRevised"
        extends Modelica.Icons.Function;
        extends Modelica.Icons.ObsoleteModel;

        input Spice3.Internal.ModelcardMOS2
                            ex "Modelcard with technology parameters";
        input Spice3.Internal.SpiceConstants con "Spice constants";

        output Mos2ModelLineParams intern "Output record model line parameters";

      algorithm
         intern.m_narrowFactor := ex.DELTA;           // DELTA, Width effect on threshold
         intern.m_critFieldExp := ex.UEXP;            // UEXP, Crit. field exp for mob. deg
         intern.m_critField := ex.UCRIT;              // UCRIT, Crit. field for mob. degradation
         intern.m_maxDriftVel := ex.VMAX;             // VMAX, Maximum carrier drift velocity
         intern.m_junctionDepth := ex.XJ;             // XJ, Junction depth
         intern.m_channelCharge := ex.NEFF;           // NEFF, Total channel charge coeff
         intern.m_fastSurfaceStateDensity := ex.NFS;  // NFS, Fast surface state density

         intern.m_oxideCapFactor := 0;

          intern.m_vtOIsGiven := if          (ex.VTO > -1e40) then 1 else 0;
          intern.m_vt0 := if         (ex.VTO > -1e40) then ex.VTO else 0;

          intern.m_capBDIsGiven := if          (ex.CBD > -1e40) then 1 else 0;
          intern.m_capBD := if         (ex.CBD > -1e40) then ex.CBD else 0;

          intern.m_capBSIsGiven := if          (ex.CBS > -1e40) then 1 else 0;
          intern.m_capBS := if         (ex.CBS > -1e40) then ex.CBS else 0;

          intern.m_bulkCapFactor := ex.CJ;           // F/(m*m) zero-bias bulk junction bottom cap. per sq-meter of junction area (default 0)
          intern.m_sideWallCapFactor := ex.CJSW;     // F/m zero-bias junction sidewall cap. per meter of junction perimeter (default 0)
          intern.m_fwdCapDepCoeff := ex.FC;          // coefficient for forward-bias depletion capacitance formula (default 0.5)

          intern.m_phiIsGiven := if          (ex.PHI > -1e40) then 1 else 0;
          intern.m_phi := if         (ex.PHI > -1e40) then ex.PHI else 0.6;

          intern.m_gammaIsGiven := if          (ex.GAMMA > -1e40) then 1 else 0;
          intern.m_gamma := if         (ex.GAMMA > -1e40) then ex.GAMMA else 0;

          intern.m_lambda := ex.LAMBDA;              // 1/V channel-length modulation (default 0)

          intern.m_substrateDopingIsGiven := if          (ex.NSUB > -1e40) then 1 else 0;
          intern.m_substrateDoping := if         (ex.NSUB > -1e40) then ex.NSUB else 0;

          intern.m_gateType := ex.TPG;               // type of gate material: +1 opp. to substrate, -1 same as substrate, 0 Al gate (default 1)
          intern.m_surfaceStateDensity := ex.NSS;    // 1/(cm*cm) surface state density (default 0)
          intern.m_surfaceMobility := ex.UO;         // (cm*cm)/(Vs) surface mobility (default 600)
          intern.m_latDiff := ex.LD;                 // m lateral diffusion (default 0)
          intern.m_jctSatCur := ex.IS;               // A bulk junction saturation current (default 1e-14)

          intern.m_drainResistanceIsGiven := if
                                               (ex.RD > -1e40) then 1 else 0;
          intern.m_drainResistance := if
                                       (ex.RD > -1e40) then ex.RD else 0;

                intern.m_sourceResistanceIsGiven := if
                                               (ex.RS > -1e40) then 1 else 0;
          intern.m_sourceResistance := if
                                       (ex.RS > -1e40) then ex.RS else 0;

          intern.m_transconductanceIsGiven := if          (ex.KP > -1e40) then 1 else 0;
          intern.m_transconductance := if         (ex.KP > -1e40) then ex.KP else 2e-5;

        intern.m_tnom := if (ex.TNOM > -1e40) then ex.TNOM + Spice3.Internal.SpiceConstants.CONSTCtoK
           else 300.15;

         intern.m_jctSatCurDensity := ex.JS;             // A/(m*m) bulk junction saturation current per sq-meter of junction area (default 0)
         intern.m_sheetResistance := ex.RSH;             // Ohm drain and source diffusion sheet resistance (default 0)
         intern.m_bulkJctPotential := ex.PB;             // V bulk junction potential (default 0.8)
         intern.m_bulkJctBotGradingCoeff := ex.MJ;       // bulk junction bottom grading coeff. (default 0.5)
         intern.m_bulkJctSideGradingCoeff := ex.MJSW;    // bulk junction sidewall grading coeff. (default 0.5)

         intern.m_oxideThickness := ex.TOX;              // m oxide thickness (default 1e-7)

         intern.m_oxideThicknessIsGiven := if          (ex.TOX > -1e40) then 1 else 0;
         intern.m_oxideThickness := if         (ex.TOX > -1e40) then ex.TOX else 1e-7;

         intern.m_gateSourceOverlapCapFactor := ex.CGSO; // F/m gate-source overlap capacitance per meter channel width (default 0)
         intern.m_gateDrainOverlapCapFactor := ex.CGDO;  // F/m gate-drain overlap capacitance per meter channel width (default 0)
         intern.m_gateBulkOverlapCapFactor := ex.CGBO;   // F/m gate-bulk overlap capacitance per meter channel width (default 0)
         intern.m_fNcoef := ex.KF;                       // flicker-noise coefficient (default 0)
         intern.m_fNexp := ex.AF;                        // flicker-noise exponent (default 1)

        annotation (Documentation(info="<html>
<p>This function mos2RenameParameters assigns the external (given by the user, e.g., RD) technology parameters
to the internal parameters (e.g., m_drainResistance). It also does the analysis of the IsGiven values (level 2).</p>
</html>"),
        obsolete = "Obsolete function - use Modelica.Electrical.Spice3.Internal.Mos2.mos2RenameParametersRevised instead");
      end mos2RenameParameters;

      function mos2RenameParametersDev
        "Device parameter renaming to internal names"
        extends Modelica.Icons.Function;
        input Spice3.Internal.ModelcardMOS2
                            ex;

        input Integer mtype;
        input SI.Length W "Width of channel region";
        input SI.Length L "Length of channel region";
        input SI.Area AD "Area of drain diffusion";
        input SI.Area AS "Area of source diffusion";
        input SI.Length PD "Drain perimeter";
        input SI.Length PS "Source perimeter";
        input Real NRD "Length of drain squares";
        input Real NRS "Length of Source squares";
        input Integer OFF
          "Optional initial condition: 0 - IC not used, 1 - IC used, not implemented yet";
        input Real IC "Initial condition values, not implemented yet";
        input SI.Temp_C TEMP "Temperature";

        output Spice3.Internal.Mosfet.Mosfet dev "Output record Mosfet";

      algorithm
      /*device parameters*/
        dev.m_len := L;               // L, length of channel region
        dev.m_width := W;             // W, width of channel region
        dev.m_drainArea := AD;        // AD, area of drain diffusion
        dev.m_sourceArea := AS;       // AS, area of source diffusion
        dev.m_drainSquares := NRD;    // NRD, length of drain in squares
        dev.m_sourceSquares := NRS;   // NRS, length of source in squares
        dev.m_drainPerimiter := PD;   // PD, Drain perimeter;
        dev.m_sourcePerimiter := PS;  // PS, Source perimeter

          dev.m_dICVDSIsGiven := if          (IC > -1e40) then 1 else 0;
          dev.m_dICVDS := if         (IC > -1e40) then IC else 0;

          dev.m_dICVGSIsGiven := if          (IC > -1e40) then 1 else 0;
          dev.m_dICVGS := if         (IC > -1e40) then IC else 0;

          dev.m_dICVBSIsGiven := if          (IC > -1e40) then 1 else 0;
          dev.m_dICVBS := if         (IC > -1e40) then IC else 0;

        dev.m_off := OFF;             // non-zero to indicate device is off for dc analysis
        dev.m_bPMOS := mtype;         // P type MOSFET model
        dev.m_nLevel := ex.LEVEL;
        assert(ex.LEVEL== 1, "only MOS Level1 implemented");
        dev.m_dTemp := TEMP + Spice3.Internal.SpiceConstants.CONSTCtoK;
        annotation (Documentation(info="<html>
<p>This function mos2RenameParameters assigns the external (given by the user) device parameters to the internal parameters. It also does the analysis of the IsGiven values (level 2).</p>
</html>"));
      end mos2RenameParametersDev;

      annotation (Documentation(info="<html>
<p>This package Mos2 contains functions and records with data of the MOSFET model level 2.</p>
</html>"));
    end Mos2;

    package Diode "Records and functions for diode model"
      extends Modelica.Icons.InternalPackage;

      record DiodeModelLineParams "Record for Diode model line parameters"
        extends Modelica.Icons.Record;
        SI.Current m_satCur( start = 1.0e-14) "IS, Saturation current";
        SI.Resistance m_resist( start = 0.0) "RS, Ohmic resistance";
        Real m_emissionCoeff( start = 1.0) "N, Emission Coefficient";
        SI.Time m_transitTime( start = 0.0) "TT, Transit Time";
        SI.Capacitance m_junctionCap( start = 0.0) "CJO, Junction capacitance";
        SI.Voltage m_junctionPot( start = 1.0) "VJ, Junction potential";
        SI.LinearTemperatureCoefficient m_gradingCoeff( start = 0.5)
          "M, Grading coefficient";                                                                           //unit check by maj
        SI.ActivationEnergy m_activationEnergy( start = 1.11)
          "EG, Activation energy";
        Real m_saturationCurrentExp( start = 3.0)
          "XTI, Saturation current temperature exp.";
        Real m_depletionCapCoeff( start = 0.5)
          "FC, Forward bias junction fit parameter";
        SI.Voltage m_breakdownVoltage "BV, Reverse breakdown voltage";
        Real m_pBvIsGiven "BV is given value";
        SI.Current m_breakdownCurrent( start = 1.0e-3)
          "IBV, Current at reverse breakdown voltage";
        SI.Temp_K m_nomTemp( start=SpiceConstants.CKTnomTemp)
          "TNOM, Parameter measurement temperature";
        Real m_fNcoef( start = 0.0) "KF, flicker noise coefficient";
        Real m_fNexp( start = 1.0) "AF, flicker noise exponent";
        SI.Conductance m_conductance "G, Ohmic conductance";

        annotation (Documentation(info="<html>
<p>This record contains the model line (also called model card) parameters that are used for the diode model  in SPICE3.</p>
</html>"));
      end DiodeModelLineParams;

      record DiodeModelLineVariables "Record for Diode model line variables"
        extends Modelica.Icons.Record;
        Real m_gradingCoeff;
        Real m_activationEnergy;
        Real m_depletionCapCoeff;
        SI.Conductance m_conductance;

        annotation (Documentation(info="<html>
<p>This record contains the model line (also called model card) variables  that are used for the diode model in SPICE3.</p>
</html>"));
      end DiodeModelLineVariables;

      record DiodeParams "Record for Diode device parameters"
        extends Modelica.Icons.Record;
        Real m_area(start = 1.0) "AREA, Area factor";
        Boolean m_bOff(start = false) "OFF, Initially off";
        SI.Voltage m_dIC(start = 0.0) "IC, Initial device voltage";
        Real m_pIcIsGiven "IC is given value";
        Boolean m_bSensArea(start = false)
          "SENS_AREA, flag to request sensitivity WRT area";

        annotation (Documentation(info="<html>
<p>This record contains the device parameters that are used for the diode model in SPICE3.</p>
</html>"));
      end DiodeParams;

      record DiodeVariables "Variables for the diode model"
        extends Modelica.Icons.Record;
        Real m_pBvIsGiven "Additional BV is given variable";

        annotation (Documentation(info="<html>
<p>This record contains the model  variables that are used for the diode model in SPICE3.</p>
</html>"));
      end DiodeVariables;

      record DiodeCalc "Diode variables"
        extends Modelica.Icons.Record;
        SI.Voltage m_tJctPot;
        SI.Capacitance m_tJctCap;
        Real m_tF1;
        Real m_f2;
        Real m_f3;
        SI.Current m_tSatCur;
        SI.Voltage m_tVcrit;
        Real m_dVte;
        SI.Voltage m_tBrkdwnV;

        annotation (Documentation(info="<html>
<p>This record contains the model variables that are used for the diode model in SPICE3.</p>
</html>"));
      end DiodeCalc;

      record CurrentsCapacitances "Diode variables"
        extends Modelica.Icons.Record;
        SI.Current m_dCurrent;

        annotation (Documentation(info="<html>
<p>This record contains the model variables that are used for the diode model in SPICE3.</p>
</html>"));
      end CurrentsCapacitances;

      function diodeModelLineInitEquations
        "Initial precalculation of model line parameters"
        extends Modelica.Icons.Function;
        input DiodeModelLineParams in_p
          "Input record with diode model line parameters";

        output DiodeModelLineVariables out_v
          "Output record with diode model line variables";

      algorithm
        // limit grading coeff to max of 0.9
        if (in_p.m_gradingCoeff > 0.9) then
          out_v.m_gradingCoeff := 0.9;
        end if;
        // limit activation energy to min of 0.1
        if (in_p.m_activationEnergy < 0.1) then
          out_v.m_activationEnergy := 0.1;
        end if;
        // limit depletion cap coeff to max of 0.95
        if (in_p.m_depletionCapCoeff > 0.95) then
          out_v.m_depletionCapCoeff := 0.95;
        end if;

        out_v.m_conductance := if (in_p.m_resist == 0.0) then 0.0 else 1.0 / in_p.m_resist;

        annotation (Documentation(info="<html>
<p>Within this function some parameters are initially precalculated from model line parameters.</p>
</html>"));
      end diodeModelLineInitEquations;

      function diodeInitEquations "Initial calculation"
        extends Modelica.Icons.Function;
        input DiodeModelLineParams in_p
          "Input record with diode model line parameters";

        output DiodeVariables out_v "Output record with diode variables";

      algorithm
       out_v.m_pBvIsGiven := in_p.m_pBvIsGiven;
        if (out_v.m_pBvIsGiven > 0.5) then
          if (in_p.m_breakdownVoltage > 1.0e+100) then
            out_v.m_pBvIsGiven := 1.0e-41; // set to false
          end if;
        end if;

        annotation (Documentation(info="<html>
<p>In this function some initial calculations for the diode model are done, especially concerning the handling of the breakthrough voltage.</p>
</html>"));
      end diodeInitEquations;

      function diodeCalcTempDependencies "Temperature dependency calculation"
        extends Modelica.Icons.Function;
        input DiodeModelLineParams in_p
          "Input record diode model line parameters";
        input DiodeParams in_dp "Input record diode parameters";
        input Model.Model in_m "Input record Model";
        input DiodeVariables in_v "Input record diode variables";

        output DiodeCalc out_c "Output record with calculated values";

      algorithm
        (out_c.m_tJctPot,out_c.m_tJctCap) :=
          Modelica.Electrical.Spice3.Internal.Functions.junctionParamDepTempSPICE3(
                in_p.m_junctionPot,
                in_p.m_junctionCap,
                in_p.m_gradingCoeff,
                in_m.m_dTemp,
                in_p.m_nomTemp);
        out_c.m_tJctCap := in_dp.m_area * out_c.m_tJctCap;
        (out_c.m_tF1,out_c.m_f2,out_c.m_f3) :=
          Modelica.Electrical.Spice3.Internal.Functions.junctionCapCoeffs(
                in_p.m_gradingCoeff,
                in_p.m_depletionCapCoeff,
                out_c.m_tJctPot);

        out_c.m_tSatCur :=
          Modelica.Electrical.Spice3.Internal.Functions.saturationCurDepTempSPICE3(
                in_p.m_satCur,
                in_m.m_dTemp,
                in_p.m_nomTemp,
                in_p.m_emissionCoeff,
                in_p.m_activationEnergy,
                in_p.m_saturationCurrentExp);
        out_c.m_tVcrit :=
          Modelica.Electrical.Spice3.Internal.Functions.junctionVCrit(
                in_m.m_dTemp,
                in_p.m_emissionCoeff,
                out_c.m_tSatCur);
        out_c.m_dVte := in_m.m_dTemp*SpiceConstants.CONSTKoverQ*in_p.m_emissionCoeff;
        if (in_v.m_pBvIsGiven > 0.5) then
          out_c.m_tBrkdwnV :=
            Modelica.Electrical.Spice3.Internal.Functions.junctionVoltage23SPICE3(
                  in_p.m_breakdownVoltage,
                  in_p.m_breakdownCurrent,
                  out_c.m_tSatCur,
                  in_m.m_dTemp,
                  in_p.m_emissionCoeff);
        end if;
        out_c.m_tSatCur := in_dp.m_area * out_c.m_tSatCur;

        annotation (Documentation(info="<html>
<p>In this function for the diode model temperature dependencies are calculated using temperature treating functions from the equation package.</p>
</html>"));
      end diodeCalcTempDependencies;

      function diodeNoBypassCode "Calculation of currents"
        extends Modelica.Icons.Function;
        input DiodeModelLineParams in_p
          "Input record model line parameters for diode";
        input DiodeParams in_dp "Input record with parameters for diode";
        input DiodeCalc in_c "Input record DiodeCalc";
        input Model.Model in_m "Input record model";
        input Boolean in_m_mbInit;
        input SI.Voltage[2] in_m_pVoltageValues; /* DPP, DN */

        output CurrentsCapacitances out_cc
          "Output record with calculated currents and capacitances";

        output SI.Capacitance m_dCap "Output capacitance";

      protected
        SI.Voltage m_dPNVoltage "Voltage";
        SI.Current m_dCurrent "Current";
        SI.Conductance m_dCond "Conductance";
        SI.Charge m_dCharge "Charge";
        SI.Current m_dCapCurrent "Current";

      algorithm
        m_dPNVoltage := in_m_pVoltageValues[1] - in_m_pVoltageValues[2];

        if (SpiceRoot.useInitialConditions() and in_dp.m_pIcIsGiven > 0.5) then
          m_dPNVoltage := in_dp.m_dIC;
        elseif (SpiceRoot.initJunctionVoltages()) then
          if (in_dp.m_bOff) then
            m_dPNVoltage := 0.0;
          else
            m_dPNVoltage := in_c.m_tVcrit;
          end if;
        end if;

        if (in_p.m_pBvIsGiven > 0.5) then
          (out_cc.m_dCurrent,m_dCond) :=
            Modelica.Electrical.Spice3.Internal.Functions.junction3(
                  m_dPNVoltage,
                  in_m.m_dTemp,
                  in_p.m_emissionCoeff,
                  in_c.m_tSatCur,
                  in_c.m_tBrkdwnV);
        else
          (out_cc.m_dCurrent,m_dCond) :=
            Modelica.Electrical.Spice3.Internal.Functions.junction2(
                  m_dPNVoltage,
                  in_m.m_dTemp,
                  in_p.m_emissionCoeff,
                  in_c.m_tSatCur);
        end if;

         m_dCurrent := out_cc.m_dCurrent;

        (m_dCap,m_dCharge) :=
          Modelica.Electrical.Spice3.Internal.Functions.junctionCapTransTime(
                in_c.m_tJctCap,
                m_dPNVoltage,
                in_c.m_tJctPot*in_p.m_depletionCapCoeff,
                in_p.m_gradingCoeff,
                in_p.m_junctionPot,
                in_c.m_tF1,
                in_c.m_f2,
                in_c.m_f3,
                in_p.m_transitTime,
                m_dCond,
                m_dCurrent);

        annotation (Documentation(info="<html>
<p>This function NoBypassCode calculates the currents (and the capacitances) that are necessary for the currents to be used in the top-level model.</p>
</html>"));
      end diodeNoBypassCode;

      function diodeCalcAdditionalValues "Calculation of additional values"
        extends Modelica.Icons.Function;
        input DiodeVariables in_v "Input record with diode variables";
        input DiodeModelLineParams in_p
          "Input record with diode model line parameters";
        input DiodeParams in_dp "Input record with diode parameters";
        input SI.Voltage[2] in_m_pVoltageValues; /* DP, DPP */

        output DiodeVariables out_v "Output record with diode variables";

      algorithm
        out_v := in_v;

        annotation (Documentation(info="<html>
<p>This function is prepared for additional calculations but it is plain (inputs are written to the outputs) in the actual version of this library.</p>
</html>"));
      end diodeCalcAdditionalValues;

      function diodeRenameParameters "Technology parameter renaming"
        extends Modelica.Icons.Function;
        input ModelcardDIODE ex "Modelcard with technology parameters";
        input SpiceConstants con "Spice constants";

        output DiodeModelLineParams intern
          "Output record diode model line parameters";

      algorithm
         intern.m_satCur := ex.IS;
         intern.m_resist:=ex.RS;
         intern.m_emissionCoeff := ex.N;
         intern.m_transitTime := ex.TT;
         intern.m_junctionCap := ex.CJO;
         intern.m_junctionPot := ex.VJ;

         intern.m_gradingCoeff := if (ex.M > 0.9) then 0.9 else ex.M;
         intern.m_activationEnergy := if (ex.EG < 0.1) then 0.1 else ex.EG;
         intern.m_saturationCurrentExp := ex.XTI;
         intern.m_depletionCapCoeff := if (ex.FC > 0.95) then 0.95 else ex.FC;

         intern.m_pBvIsGiven := if (ex.BV > -1e40) then 1 else 0;
         intern.m_breakdownVoltage := if (ex.BV > -1e40) then ex.BV else 0;

         intern.m_breakdownCurrent := ex.IBV;
         intern.m_nomTemp := ex.TNOM + SpiceConstants.CONSTCtoK;
         intern.m_fNcoef := ex.KF;
         intern.m_fNexp := ex.AF;

         intern.m_conductance := if (ex.RS == 0) then  0 else 1/ex.RS;

        annotation (Documentation(info="<html>
<p>This function assigns the external (given by the user, e.g., IS) technology parameters
to the internal parameters (e.g., m_satCur). It also does the analysis of the IsGiven values.</p>
</html>"));
      end diodeRenameParameters;

      function diodeRenameParametersDev "Temperature calculation"
        extends Modelica.Icons.Function;
        input SI.Temp_K TEMP "Temperature";
        input Real AREA "Area factor";
        input Real IC "Initial condition value (VD, not implemented yet";
        input Boolean OFF
          "Optional initial condition: false - IC not used, true - IC used, not implemented yet";
        input Boolean SENS_AREA
          "Flag to request sensitivity WRT area, not implemented yet";

        output DiodeParams dev "Output record with calculated diode parameters";

      algorithm
      /*device parameters*/
        dev.m_area := AREA;

        dev.m_pIcIsGiven := if (IC > -1e40) then 1 else 0;
        dev.m_dIC := if
                       (IC > -1e40) then IC else 0;
        dev.m_bOff := OFF;
        dev.m_bSensArea := SENS_AREA;

        annotation (Documentation(info="<html>
<p>This function assigns the external (given by the user, e.g., AREA) device parameters
to the internal parameters (e.g., m_area). It also does the analysis of the IsGiven values.</p>
</html>"));
      end diodeRenameParametersDev;

      function diodeRenameParametersDevTemp "Temperature calculation"
        extends Modelica.Icons.Function;
        input SI.Temp_C TEMP "Temperature";
        output Model.Model dev_temp "Input record Model";

      algorithm
        dev_temp.m_dTemp := TEMP + SpiceConstants.CONSTCtoK;

        annotation (Documentation(info="<html>
<p>This function calculates device parameters which are temperature dependent.</p>
</html>"));
      end diodeRenameParametersDevTemp;
      annotation (Documentation(info="<html>
<p>This package Diode contains functions and record with data of the semiconductor diode model.</p>
</html>"));
    end Diode;

    package Rsemiconductor
      "Records and functions for semiconductor resistor model"
        extends Modelica.Icons.InternalPackage;

      record ResistorParams "Resistor device parameters"
        extends Modelica.Icons.Record;
        SI.Resistance m_dResist( start=1000) "Device is a resistor model";
        Real m_dResIsGiven "Resistance is given value";
        SI.Length m_dWidth( start=0) "Width";
        Real m_dWidthIsGiven "Width is given value";
        SI.Length m_dLength "Length";
        Real m_dLengthIsGiven "Length is given value";
        Boolean m_bSensResist( start = false)
          "flag to request sensitivity WRT resistance";
        SI.Temp_C m_dTemp(start = 27) "Resistor device temperature";

        annotation (Documentation(info="<html>
<p>This record contains the device parameters that are used for the resistor model in SPICE3.</p>
</html>"));
      end ResistorParams;

      record ResistorModelLineParams "Record for resistor model line parameters"
        extends Modelica.Icons.Record;
        SI.LinearTemperatureCoefficientResistance m_dTC1 "First order temperature coefficient";
        SI.QuadraticTemperatureCoefficientResistance m_dTC2 "Second order temperature coefficient";
        SI.Resistance m_dRsh "Sheet resistance";
        Real m_dRshIsGiven;
        SI.Length m_dDefW "Default device width";
        SI.Length m_dNarrow "Narrowing of resistor";
        SI.Temp_C m_dTnom "Parameter measurement temperature";

        annotation (Documentation(info="<html>
<p>This record contains the model line (also called model card) parameters that are used for the resistor model in SPICE3.</p>
</html>"));
      end ResistorModelLineParams;

      record ResistorVariables "Variables for the resistor model"
        extends Modelica.Icons.Record;
        SI.Length m_dWidth;
        SI.Length m_dLength;
        SI.Resistance m_dResist;
        SI.Conductance m_dConduct;
        SI.Temp_C m_dCond_dTemp;
        annotation (Documentation(info="<html>
<p>This record contains the model variables that are used for the resistor model in SPICE3.</p>
</html>"));
      end ResistorVariables;

      function resistorRenameParameters "Technology parameter renaming"
        extends Modelica.Icons.Function;
        input ModelcardR ex "Modelcard with technology parameters";
        input SpiceConstants con "Spice constants";

        output ResistorModelLineParams intern
          "Output record with resistor model line parameters";

      algorithm
        intern.m_dTC1 := ex.TC1;
        intern.m_dTC2 := ex.TC2;

        intern.m_dRshIsGiven := if (ex.RSH > -1e40) then 1 else 0;
        intern.m_dRsh := if (ex.RSH > -1e40) then ex.RSH else 0;

        intern.m_dDefW := ex.DEFW;
        intern.m_dNarrow := ex.NARROW;
        intern.m_dTnom := if (ex.TNOM > -1e40) then ex.TNOM + SpiceConstants.CONSTCtoK else
                300.15;

        annotation (Documentation(info="<html>
<p>This function assigns the external (given by the user, e.g., N) technology parameters
to the internal parameters (e.g., m_emissionCoeff). It also does the analysis of the IsGiven values.</p>
</html>"));
      end resistorRenameParameters;

      function resistorRenameParametersDev "Device parameter renaming"
        extends Modelica.Icons.Function;
        input SI.Resistance R "Resistance";
        input SI.Length W "Width";
        input SI.Length L "Length";
        input SI.Temp_C TEMP "Temperature";
        input Boolean SENS_AREA
          "Parameter for sensitivity analyses, not implemented yet";

       input SpiceConstants con "Spice constants";

       output ResistorParams intern "Output record with resistor parameters";

      algorithm
         intern.m_dResIsGiven := if
                                   (R > -1e40) then 1 else 0;
         intern.m_dResist := if
                               (R > -1e40) then R else 0;

         intern.m_dWidthIsGiven := if
                                     (W >-1e40) then 1 else 0;
         intern.m_dWidth := if
                              (W > -1e40) then W else 0;

         intern.m_dLengthIsGiven := if
                                     (L >-1e40) then 1 else 0;
         intern.m_dLength := if
                              (L > -1e40) then L else 0;
         intern.m_bSensResist := SENS_AREA;
        intern.m_dTemp := if (TEMP > -1e40) then TEMP + SpiceConstants.CONSTCtoK else
                300.15;

        annotation (Documentation(info="<html>
<p>This function assigns the external (given by the user, e.g., AREA) device parameters
to the internal parameters (e.g., m_area). It also does the analysis of the IsGiven values.</p>
</html>"));
      end resistorRenameParametersDev;

      function resistorInitEquations "Initial calculation"
        extends Modelica.Icons.Function;
        input ResistorParams in_p "Input record with resistor parameters";
        input ResistorModelLineParams in_p2
          "Input record with resistor model line parameters";
        output ResistorVariables out "Output record with resistor variables";

      algorithm
        out.m_dLength := 0;
        out.m_dConduct := 0;
        out.m_dCond_dTemp := 0;

      out.m_dWidth := in_p.m_dWidth;
        if ( in_p.m_dResIsGiven < 0.5) then
            if (abs(in_p.m_dLength)>1e-8) and (abs(in_p2.m_dRsh)>1e-25) then
                if (not (in_p.m_dWidthIsGiven > 0.5)) then
                    out.m_dWidth :=in_p2.m_dDefW;
                end if;

            (out.m_dResist) :=
              Modelica.Electrical.Spice3.Internal.Functions.resDepGeom(
                    in_p2.m_dRsh,
                    out.m_dWidth,
                    in_p.m_dLength,
                    in_p2.m_dNarrow);
             else
                  out.m_dResist :=1000;
             end if;
        end if;
        if
          (in_p.m_dResist < 1e-12) and (in_p.m_dResIsGiven > 0.5) then
            out.m_dResist :=1e-12;
        end if;
       if (in_p.m_dResist > 1e-12) and (in_p.m_dResIsGiven > 0.5) then
          out.m_dResist := in_p.m_dResist;
       end if;

        annotation (Documentation(info="<html>
<p>In this function some initial calculations for the resistor model are done, especially concerning the handling of the breakthrough voltage.</p>
</html>"));
      end resistorInitEquations;

      annotation (Documentation(info="<html>
<p>This package Rsemiconductor contains functions and records with data of the semiconductor resistor model.</p>
</html>"));
    end Rsemiconductor;

    package Bjt "Records and functions for bjt model"
      extends Modelica.Icons.InternalPackage;

      record Bjt "Record for bjt device parameters"
        extends Spice3.Internal.Model.Model;

        Real m_area(  start = 1.0) "AREA";
        Boolean m_bOff(  start = false) "OFF";
        SI.Voltage m_dICvbe(start=0.0) "IC_VBE";
        Real m_bICvbeIsGiven( start = 0.0);
        SI.Voltage m_dICvce(start=0.0) "IC_VCE";
        Real m_bICvceIsGiven( start = 0.0);
        Boolean m_uic "Use initial conditions, UIC";
        Boolean m_bSensArea( start = false) "SENS_AREA";

        SI.Current m_transitTimeHighCurrentF(start=0.0);
        Types.InverseElectricCurrent m_invRollOffF(start=0);
        Types.InverseElectricCurrent m_invRollOffR(start=0);

        SI.Capacitance m_CScap(start=0);
        annotation (Documentation(info="<html>
<p>This record contains the device parameters that are used for the bipolar transistor bjt model in SPICE3.</p>
</html>"));
      end Bjt;

      record BjtModelLineParams "Record for bjt model line parameters"
        extends Modelica.Icons.Record;
        Real m_type( start = 1) "device type : 1 = n,  -1 = p";

        SI.Temp_K m_tnom(start=Spice3.Internal.SpiceConstants.CKTnomTemp)
          "TNOM, Parameter measurement temperature";
        SI.Current m_satCur(start=1.0e-16) "IS, Saturation Current";
        Real m_betaF( start = 100.0) "BF, Ideal forward beta";
        Real m_emissionCoeffF(  start = 1.0) "NF, Forward emission coefficient";
        Real m_leakBEemissionCoeff( start = 1.5)
          "NE, B-E leakage emission coefficient";
        SI.Current m_leakBEcurrent(start=0.)
          "ISE, B-E leakage saturation current";
        Real m_c2( start = 0.) "C2, Obsolete parameter name";
        SI.Current m_leakBCcurrent(start=0.)
          "ISC, B-C leakage saturation current";
        Real m_c4( start = 0.) "C4, Obsolete parameter name";
        Real m_leakBEcurrentIsGiven;
        Real m_c2IsGiven;
        Real m_leakBCcurrentIsGiven;
        Real m_c4IsGiven;
        Real m_betaR( start = 1.0) "BR, Ideal reverse beta";
        Real m_emissionCoeffR( start = 1.0) "NR, Reverse emission coefficient";
        Real m_leakBCemissionCoeff( start = 2.0)
          "NC, B-C leakage emission coefficient";
        SI.Voltage m_earlyVoltF(start=0.0) "VAF, Forward Early voltage";
        SI.Current m_rollOffF(start=0.0)
          "IKF, Forward beta roll-off corner current";
        SI.Voltage m_earlyVoltR(start=0.0) "VAR, Reverse Early voltage";
        SI.Current m_rollOffR(start=0.0)
          "IKR, reverse beta roll-off corner current";
        SI.Resistance m_emitterResist(start=0.0) "RE, Emitter resistance";
        SI.Resistance m_collectorResist(start=0.0) "RC, Collector resistance";
        SI.Current m_baseCurrentHalfResist(start=0.0)
          "IRB, Current for base resistance=(rb+rbm)/2";
        SI.Resistance m_baseResist(start=0.0) "RB, Zero bias base resistance";
        SI.Resistance m_minBaseResist(start=0.0) "RBM, Minimum base resistance";
        Real m_minBaseResistIsGiven;
        SI.Capacitance m_depletionCapBE(start=0.0)
          "CJE, Zero bias B-E depletion capacitance";
        SI.Voltage m_potentialBE(start=0.75) "VJE, B-E built in potential";
        Real m_junctionExpBE( start = 0.33) "MJE, B-E built in potential";
        SI.Time m_transitTimeF(start=0.0) "TF, Ideal forward transit time";
        Real m_transitTimeBiasCoeffF( start = 0.0)
          "XTF, Coefficient for bias dependence of TF";
        SI.Current m_transitTimeHighCurrentF(start=0.0)
          "ITF, High current dependence of TF";
        SI.Voltage m_transitTimeFVBC(start=0.0)
          "VTF, Voltage giving VBC dependence of TF";
        SI.Frequency m_excessPhase(start=0.0) "PTF, Excess phase";
        SI.Capacitance m_depletionCapBC(start=0.0)
          "CJC, Zero bias B-C depletion capacitance";
        SI.Voltage m_potentialBC(start=0.75) "VJC, B-C built in potential";
        Real m_junctionExpBC( start = 0.33)
          "MJC, B-C junction grading coefficient";
        Real m_baseFractionBCcap( start = 1.0)
          "XCJC, Fraction of B-C cap to internal base";
        SI.Time m_transitTimeR(start=0.0) "TR, Ideal reverse transit time";
        SI.Capacitance m_capCS(start=0.0) "CJS, Zero bias C-S capacitance";
        SI.Voltage m_potentialSubstrate(start=0.75)
          "VJS, Zero bias C-S capacitance";
        Real m_exponentialSubstrate( start = 0.0)
          "MJS, Substrate junction grading coefficient";
        Real m_betaExp( start = 0.0) "XTB, Forward and reverse beta temp. exp.";
        SI.GapEnergy m_energyGap(start=1.11)
          "EG, Energy gap for IS temp. dependency";
        Real m_tempExpIS( start = 3.0) "XTI,Temp. exponent for IS";
        Real m_fNcoef( start = 0.0) "KF, Flicker Noise Coefficient";
        Real m_fNexp( start = 1.0) "AF, Flicker Noise Exponent";
        Real m_depletionCapCoeff( start = 0.5)
          "FC, Forward bias junction fit parameter";

        SI.Conductance m_collectorConduct(start=0.0);
        SI.Conductance m_emitterConduct(start=0.0);
        SI.InversePotential m_transitTimeVBCFactor(start=0.0);
        Real m_excessPhaseFactor( start = 0.0);
        SI.InversePotential m_invEarlyVoltF(start=0.0);
        Types.InverseElectricCurrent m_invRollOffF(start=0.0);
        SI.InversePotential m_invEarlyVoltR(start=0.0);
        Types.InverseElectricCurrent m_invRollOffR(start=0.0);

        //obsolete
        Real m_bNPN= 1;
        Real m_bPNP= 1;

        Real m_area = 1.0;
        Boolean m_bOff = false;
        SI.Voltage m_dICvbe = 0;
        Real m_bICvbeIsGiven = 0;
        SI.Voltage m_dICvce = 0;
        Real m_bICvceIsGiven = 0;
        Boolean m_bSensArea = false;
        Real m_dTemp = 1;

        annotation (Documentation(info="<html>
<p>This record contains the model line (also called model card) parameters that are used for the bipolar transistor model in SPICE3.</p>
</html>"));
      end BjtModelLineParams;

      record BjtCalc "Bjt variables"
        extends Modelica.Icons.Record;
        SI.Current m_tSatCur(start=0);
        Real m_tBetaF( start = 1);
        Real m_tBetaR( start = 1);
        SI.Current m_tBEleakCur(start=1e-14);
        SI.Current m_tBCleakCur(start=1e-14);
        SI.Capacitance m_tBEcap(start=0);
        SI.Voltage m_tBEpot(start=0.7);
        SI.Capacitance m_tBCcap(start=0);
        SI.Voltage m_tBCpot(start=0.7);
        SI.Voltage m_tDepCapBE(start=0.7);
        SI.Voltage m_tDepCapBC(start=0.7);
        SI.Voltage m_tVcrit(start=0.7);
        SI.Voltage m_dVt(start=0.025);
        SI.Voltage m_tF1c(start=0);
        Real m_f2c( start = 0);
        Real m_f3c( start = 0);
        SI.Voltage m_tF1e(start=0);
        Real m_f2e( start = 0);
        Real m_f3e( start = 0);

        annotation (Documentation(info="<html>
<p>This record contains the model variables that are used for the bipolar transistor model in SPICE3.</p>
</html>"));
      end BjtCalc;

      record CurrentsCapacitances "Bjt variables"
        extends Modelica.Icons.Record;
        SI.Current iBE(start=0.0);
                                   //current through diode dE1 (ideal part)
        SI.Current iBEN(start=0.0);
                                   //current through diode dE2 (non ideal part)
        SI.Current iBC(start=0.0);
                                  //current through diode dC1 (ideal part)
        SI.Current iBCN(start=0.0);
                                   //current through diode dC2 (non ideal part)
        SI.Current iCC(start=0.0);
                                   //channel current
        SI.Capacitance capbc(start=0.0);
        SI.Capacitance capbe(start=0.0);
        SI.Capacitance capbx(start=0.0);
        SI.Capacitance captt(start=0.0);
        SI.Capacitance capcs(start=0.0);
        SI.Resistance rx(start=0.0);

        //obsolete
        Real iXX;

        annotation (Documentation(info="<html>
<p>This record contains the model variables that are used for the bipolar transistor model in SPICE3.</p>
</html>"));
      end CurrentsCapacitances;

      function bjtModelLineInitEquations "Initial calculation"
        extends Modelica.Icons.Function;
        input BjtModelLineParams in_p
          "Input record with Bjt model line parameters";

        output BjtModelLineParams out_p
          "Output record with Bjt model line variables";

      algorithm
        out_p := in_p;

        if ( not (out_p.m_leakBEcurrentIsGiven > 0.5) and (out_p.m_c2IsGiven > 0.5)) then
          out_p.m_leakBEcurrent := out_p.m_c2 * out_p.m_satCur;
        end if;
        if ( not (out_p.m_leakBCcurrentIsGiven > 0.5) and (out_p.m_c4IsGiven > 0.5)) then
          out_p.m_leakBCcurrent := out_p.m_c4 * out_p.m_satCur;
        end if;
        if (out_p.m_earlyVoltF <> 0) then
          out_p.m_invEarlyVoltF := 1 / out_p.m_earlyVoltF;
        end if;
        if (out_p.m_rollOffF <> 0) then
          out_p.m_invRollOffF := 1 / out_p.m_rollOffF;
        end if;
        if (out_p.m_earlyVoltR <> 0) then
          out_p.m_invEarlyVoltR := 1 / out_p.m_earlyVoltR;
        end if;
        if (out_p.m_rollOffR <> 0) then
          out_p.m_invRollOffR := 1 / out_p.m_rollOffR;
        end if;
        if (out_p.m_collectorResist <> 0) then
          out_p.m_collectorConduct := 1 / out_p.m_collectorResist;
        end if;
        if (out_p.m_emitterResist <> 0) then
          out_p.m_emitterConduct := 1 / out_p.m_emitterResist;
        end if;
        if (out_p.m_transitTimeFVBC <> 0) then
          out_p.m_transitTimeVBCFactor := 1 / (out_p.m_transitTimeFVBC * 1.44);
        end if;
        out_p.m_excessPhaseFactor := (out_p.m_excessPhase/(180.0/
          Modelica.Constants.pi))*out_p.m_transitTimeF;
        if (out_p.m_depletionCapCoeff > 0.9999) then
          out_p.m_depletionCapCoeff := 0.9999;
        end if;
        annotation (Documentation(info="<html>
<p>Within this function some parameters are initially precalculated from model line parameters.</p>
</html>"));
      end bjtModelLineInitEquations;

      function bjtInitEquations "Initial calculation"
        extends Modelica.Icons.Function;
        input Bjt in_p "Input record Bjt";
        input BjtModelLineParams in_pml
          "Input record with Bjt model line parameters";

        output Bjt out_v "Output record with Bjt";

      algorithm
        out_v := in_p;

        // calculate the parameters that depend on the area factor
        out_v.m_transitTimeHighCurrentF := in_pml.m_transitTimeHighCurrentF * out_v.m_area;
        out_v.m_invRollOffF             := in_pml.m_invRollOffF / out_v.m_area;
        out_v.m_invRollOffR             := in_pml.m_invRollOffR / out_v.m_area;
        out_v.m_CScap                   := in_pml.m_capCS * out_v.m_area;

        annotation (Documentation(info="<html>
<p>Within this function some parameters are initially precalculated from model line parameters.</p>
</html>"));
      end bjtInitEquations;

      function bjtCalcTempDependencies "Temperature dependency calculation"
        extends Modelica.Icons.Function;
        input Bjt in_p3 "Input record Bjt";
        input BjtModelLineParams in_p
          "Input record with Bjt model line parameters";

        output BjtCalc out_c "Output record BjtCalc";

      protected
        Real fact1;
        Real fact2;
        SI.Voltage vt;
        SI.GapEnergy egfet;
        Types.GapEnergyPerEnergy arg;
        SI.Voltage pbfact;
        Real ratlog;
        Real ratio1;
        Real factlog;
        Real factor;
        Real bfactor;
        SI.Voltage pbo;
        Real gmanew;
        Real gmaold;

      algorithm
        fact1 := in_p.m_tnom/Spice3.Internal.SpiceConstants.REFTEMP;
        vt := in_p3.m_dTemp*Spice3.Internal.SpiceConstants.CONSTKoverQ;
        fact2 := in_p3.m_dTemp/Spice3.Internal.SpiceConstants.REFTEMP;

        egfet := Spice3.Internal.MaterialParameters.EnergyGapSi - (Spice3.Internal.MaterialParameters.FirstBandCorrFactorSi
          *in_p3.m_dTemp*in_p3.m_dTemp)/(in_p3.m_dTemp + Spice3.Internal.MaterialParameters.SecondBandCorrFactorSi);

        arg := -egfet/(2*Spice3.Internal.SpiceConstants.CONSTboltz*in_p3.m_dTemp)
           + Spice3.Internal.MaterialParameters.BandCorrFactorT300/(Spice3.Internal.SpiceConstants.CONSTboltz
          *(Spice3.Internal.SpiceConstants.REFTEMP + Spice3.Internal.SpiceConstants.REFTEMP));
        pbfact := -2*vt*(1.5*Modelica.Math.log(fact2) + Spice3.Internal.SpiceConstants.CHARGE
          *arg);

        ratlog  := Modelica.Math.log(in_p3.m_dTemp/in_p.m_tnom);
        ratio1  := in_p3.m_dTemp / in_p.m_tnom - 1;
        factlog := ratio1 * in_p.m_energyGap / vt + in_p.m_tempExpIS * ratlog;
        factor  := exp( factlog);
        bfactor := exp(ratlog * in_p.m_betaExp);
        pbo     := (in_p.m_potentialBE - pbfact) / fact1;
        gmaold  := (in_p.m_potentialBE - pbo) / pbo;

        out_c.m_tSatCur    := in_p.m_satCur * factor * in_p3.m_area;
        out_c.m_tBetaF     := in_p.m_betaF * bfactor;
        out_c.m_tBetaR     := in_p.m_betaR * bfactor;
        out_c.m_tBEleakCur := in_p.m_leakBEcurrent * exp(factlog / in_p.m_leakBEemissionCoeff) / bfactor
                              * in_p3.m_area;
        out_c.m_tBCleakCur := in_p.m_leakBCcurrent * exp(factlog / in_p.m_leakBCemissionCoeff) / bfactor
                              * in_p3.m_area;

        out_c.m_tBEcap := in_p.m_depletionCapBE/(1 + in_p.m_junctionExpBE*(4e-4*(
          in_p.m_tnom - Spice3.Internal.SpiceConstants.REFTEMP) - gmaold));
        out_c.m_tBEpot := fact2 * pbo + pbfact;

        gmanew := (out_c.m_tBEpot - pbo) / pbo;

        out_c.m_tBEcap := out_c.m_tBEcap*(1 + in_p.m_junctionExpBE*(4e-4*(in_p3.m_dTemp
           - Spice3.Internal.SpiceConstants.REFTEMP) - gmanew));

        pbo    := (in_p.m_potentialBC - pbfact) / fact1;
        gmaold := (in_p.m_potentialBC - pbo) / pbo;

        out_c.m_tBCcap := in_p.m_depletionCapBC/(1 + in_p.m_junctionExpBC*(4e-4*(
          in_p.m_tnom - Spice3.Internal.SpiceConstants.REFTEMP) - gmaold));
        out_c.m_tBCpot := fact2 * pbo + pbfact;

        gmanew := (out_c.m_tBCpot - pbo) / pbo;

        out_c.m_tBCcap := out_c.m_tBCcap*(1 + in_p.m_junctionExpBC*(4e-4*(in_p3.m_dTemp
           - Spice3.Internal.SpiceConstants.REFTEMP) - gmanew));

        out_c.m_tDepCapBE := in_p.m_depletionCapCoeff * out_c.m_tBEpot;
        out_c.m_tDepCapBC := in_p.m_depletionCapCoeff * out_c.m_tBCpot;
        out_c.m_tVcrit := vt*Modelica.Math.log(vt/(Spice3.Internal.SpiceConstants.CONSTroot2
          *in_p.m_satCur));
        out_c.m_dVt       := vt;

        // calculate the parameters that depend on the area factor
        out_c.m_tBEcap := out_c.m_tBEcap * in_p3.m_area;
        out_c.m_tBCcap := out_c.m_tBCcap * in_p3.m_area;
        (out_c.m_tF1c,out_c.m_f2c,out_c.m_f3c) :=
          Spice3.Internal.Functions.junctionCapCoeffs(
            in_p.m_junctionExpBC,
            in_p.m_depletionCapCoeff,
            out_c.m_tBCpot);
        (out_c.m_tF1e,out_c.m_f2e,out_c.m_f3e) :=
          Spice3.Internal.Functions.junctionCapCoeffs(
            in_p.m_junctionExpBE,
            in_p.m_depletionCapCoeff,
            out_c.m_tBEpot);

        annotation (Documentation(info="<html>
<p>In this function for the bipolar transistor model temperature dependencies are calculated using temperature treating functions from the equation package.</p>
</html>"));
      end bjtCalcTempDependencies;

      function bjtNoBypassCode "Calculation of currents"
        extends Modelica.Icons.Function;
        input Bjt in_p3 "Input record Bjt";
        input BjtModelLineParams in_p
          "Input record with Bjt model line parameters";
        input BjtCalc in_c "Input record BjtCalc";
        input SI.Voltage[6] in_m_pVoltageValues;
                                                   /* 1 Col; 2 Base; 3 Emit; 4 ColP; 5 BaseP; 6 EmitP */

        output CurrentsCapacitances out_cc
          "Output record with calculated currents and capacitances";

      protected
        SI.Voltage vce;
        SI.Voltage vbe;
        SI.Voltage vbx;
        SI.Voltage vbc;
        SI.Conductance gbe;
       // SI.Current cbe;
        Real cbe;
        SI.Conductance gbc;
        SI.Current cbc;
        SI.Conductance gben;
        SI.Current cben;
        SI.Conductance gbcn;
        SI.Current cbcn;
        SI.Current cjbe;
        SI.Current cjbc;
        Real dqbdve;
        Real dqbdvc;
        Real qb;
        Real q1;
        Real q2;
        Real arg;
        Real sqarg;
        Real cc;
        SI.Current cex;
        SI.Conductance gex;
        SI.Time ttime;
        Real step;
        Real laststep;
        SI.Current bcex0;
        SI.Current bcex1;
        Real arg1;
        Real arg2;
        Real denom;
        Real arg3;
        Real rbpr;
        Real rbpi;
        Real gx;
        Real xjrb;
        Real go;
        Real gm;
        SI.Capacitance captt;
        SI.Charge chargebe;
        SI.Charge chargebc;
        SI.Charge chargebx;
        Real argtf;
        Real exponent;
        Real temp;

        Real aux1;
        Real aux2;
        SI.Charge chargecs;
        SI.Voltage vcs;
        Real sarg;

      algorithm
        temp := 0;

        vce := in_p.m_type * (in_m_pVoltageValues[4] - in_m_pVoltageValues[6]); // ( ColP, EmitP);
        vbe := in_p.m_type * (in_m_pVoltageValues[5] - in_m_pVoltageValues[6]); // ( BaseP, EmitP);
        vbx := in_p.m_type * (in_m_pVoltageValues[2] - in_m_pVoltageValues[4]); // ( Base, ColP);

        if (in_p3.m_uic) then
          if (in_p3.m_bICvbeIsGiven > 0.5) then
            vbe := in_p.m_type * in_p3.m_dICvbe;
          end if;
          if (in_p3.m_bICvceIsGiven > 0.5) then
            vce := in_p.m_type * in_p3.m_dICvce;
          end if;
          vbx := vbe - vce;
        elseif (Spice3.Internal.SpiceRoot.initJunctionVoltages()) then
          if (in_p3.m_bOff) then
            vbe := 0.0;
            vce := 0.0;
            vbx := 0.0;
          else
            vbe := in_c.m_tVcrit;
            vce := vbe;
            vbx := 0.0;
          end if;
        end if;

        vbc := vbe - vce;

        // junction current
        (cbe,gbe,cben,gben) := Spice3.Internal.Functions.junction2SPICE3BJT(
            vbe,
            in_p3.m_dTemp,
            in_p.m_emissionCoeffF,
            in_p.m_leakBEemissionCoeff,
            in_c.m_tSatCur,
            in_c.m_tBEleakCur);
        out_cc.iBE  := in_p.m_type * cbe / in_c.m_tBetaF;
        out_cc.iBEN := in_p.m_type * cben;
        (cbc,gbc,cbcn,gbcn) := Spice3.Internal.Functions.junction2SPICE3BJT(
            vbc,
            in_p3.m_dTemp,
            in_p.m_emissionCoeffR,
            in_p.m_leakBCemissionCoeff,
            in_c.m_tSatCur,
            in_c.m_tBCleakCur);
        out_cc.iBC  := in_p.m_type * cbc / in_c.m_tBetaR;
        out_cc.iBCN := in_p.m_type * cbcn;
        cjbe        := cbe / in_c.m_tBetaF + cben;
        cjbc        := cbc / in_c.m_tBetaR + cbcn;

        // determine base charge terms
        q1 := 1.0/(1.0 - in_p.m_invEarlyVoltF * vbc - in_p.m_invEarlyVoltR * vbe);
        if (in_p.m_invRollOffF == 0 and in_p.m_invRollOffR == 0) then
          qb     := q1;
          dqbdve := q1*qb*in_p.m_invEarlyVoltR;
          dqbdvc := q1*qb*in_p.m_invEarlyVoltF;
        else
          q2    := in_p.m_invRollOffF*cbe + in_p.m_invRollOffR*cbc;
          arg   := max( 0.0, 1+4*q2);
          sqarg := 1;
          if (arg <> 0) then
            sqarg := sqrt(arg);
          end if;
          qb     := q1*(1+sqarg)/2;
          dqbdve := q1*(qb*in_p.m_invEarlyVoltR + in_p.m_invRollOffF*gbe/sqarg);
          dqbdvc := q1*(qb*in_p.m_invEarlyVoltF + in_p.m_invRollOffR*gbc/sqarg);
        end if;

        // determine dc incremental conductances - Weil's approximation
        cc    := 0.0;
        cex   := cbe;
        gex   := gbe;
        ttime := 1;
        if ((in_p.m_excessPhaseFactor <> 0) and (ttime > 0.0)) then
          step     :=0;
          laststep :=1;
          bcex0    :=0;
          bcex1    :=0;
          if ( bcex1 == 0.0) then
               bcex1 := cbe / qb;
               bcex0 := bcex1;

          end if;
          arg1  := step / in_p.m_excessPhaseFactor;
          arg2  := 3 * arg1;
          arg1  := arg2 * arg1;
          denom := 1 + arg1 + arg2;
          arg3  := arg1 / denom;
          cc    := (bcex0 * (1 + step / laststep + arg2) -
                   bcex1 * step / laststep) / denom;
          cex   := cbe * arg3;
          gex   := gbe * arg3;

        end if;
        cc := cc+(cex-cbc)/qb;

        // resistances
        rbpr := in_p.m_minBaseResist / in_p3.m_area;
        rbpi := in_p.m_baseResist / in_p3.m_area-rbpr;
        gx   := rbpr + rbpi / qb;
        xjrb := in_p.m_baseCurrentHalfResist * in_p3.m_area;
        if (xjrb <> 0) then
          arg1 := max( (cjbe + cjbc) / xjrb, 1e-9);
          arg2 := (-1 + sqrt( 1 + 14.59025 * arg1)) / 2.4317 / sqrt( arg1); // z s. Gl. (11-44a)
          arg1 := tan(arg2);
          gx   := rbpr + 3 * rbpi * (arg1-arg2) / arg2 / arg1 / arg1;
        end if;
        // keine if-Abfrage falls gx als Widerstand in Top_level genutzt wird !!!
        // ----------------------------------------------------------------------
        if (gx <> 0) then
          gx := 1 / gx;
        end if;
        out_cc.rx := gx;

        // determine dc incremental conductances
        go := (gbc+(cex-cbc)*dqbdvc/qb)/qb;
        gm := (gex-(cex-cbc)*dqbdve/qb)/qb - go;
        out_cc.iCC := in_p.m_type * cc;

        // charge storage elements and transit time calculation
        captt := 0.0;
        if (in_p.m_transitTimeF <> 0.0 and vbe > 0.0) then
          argtf := 0.0;
          arg2  := 0.0;
          arg3  := 0.0;
          if (in_p.m_transitTimeBiasCoeffF <> 0.0) then
            argtf := in_p.m_transitTimeBiasCoeffF;
            if (in_p.m_transitTimeVBCFactor <> 0.0) then
              exponent := min( 50., vbc * in_p.m_transitTimeVBCFactor);
              argtf    := argtf * exp( exponent);
            end if;
              arg2 := argtf;
              if (in_p.m_transitTimeHighCurrentF <> 0) then
               temp := cbe / (cbe + in_p.m_transitTimeHighCurrentF);
                argtf := argtf * temp * temp;
                arg2  := argtf * (3-temp-temp);
              end if;
              arg3 := cbe * argtf * in_p.m_transitTimeVBCFactor;
          end if;
          cbe   := cbe * (1 + argtf) / qb;
          gbe   := (gbe * (1 + arg2) - cbe * dqbdve) / qb;
          captt := in_p.m_transitTimeF * (arg3 - cbe * dqbdvc) / qb;
        end if;
        out_cc.captt := captt; // (BaseP, ColP)

        (out_cc.capbe,chargebe) := Spice3.Internal.Functions.junctionCapTransTime(
            in_c.m_tBEcap,
            vbe,
            in_c.m_tDepCapBE,
            in_p.m_junctionExpBE,
            in_c.m_tBEpot,
            in_c.m_tF1e,
            in_c.m_f2e,
            in_c.m_f3e,
            in_p.m_transitTimeF,
            gbe,
            cbe);

        aux1 := in_c.m_tBCcap*in_p.m_baseFractionBCcap;
        (out_cc.capbc,chargebc) := Spice3.Internal.Functions.junctionCapTransTime(
            aux1,
            vbc,
            in_c.m_tDepCapBC,
            in_p.m_junctionExpBC,
            in_c.m_tBCpot,
            in_c.m_tF1c,
            in_c.m_f2c,
            in_c.m_f3c,
            in_p.m_transitTimeR,
            gbc,
            cbc);

        aux2:= in_c.m_tBCcap*(1. - in_p.m_baseFractionBCcap);
        (out_cc.capbx,chargebx) := Spice3.Internal.Functions.junctionCap(
            aux2,
            vbx,
            in_c.m_tDepCapBC,
            in_p.m_junctionExpBC,
            in_c.m_tBCpot,
            in_c.m_tF1c,
            in_c.m_f2c,
            in_c.m_f3c);

        out_cc.capcs := 0;
        chargecs := 0;
        vcs      := in_p.m_type * (0- in_m_pVoltageValues[4]); // ( Subst,  ColP);
        if (vcs < 0) then
          arg          := 1 - vcs / in_p.m_potentialSubstrate;
          sarg := exp(-in_p.m_exponentialSubstrate*Modelica.Math.log(
            arg));
          out_cc.capcs := in_p3.m_CScap * sarg;
          chargecs     := in_p.m_potentialSubstrate * in_p3.m_CScap *
                         (1-arg*sarg)/(1-in_p.m_exponentialSubstrate);
        else
          out_cc.capcs := in_p3.m_CScap * (1 + in_p.m_exponentialSubstrate * vcs / in_p.m_potentialSubstrate);
          chargecs     := vcs * in_p3.m_CScap *(1+in_p.m_exponentialSubstrate*vcs/
                                       (2*in_p.m_potentialSubstrate));
        end if;

        //obsolete --> for backward compatibility

        out_cc.iXX :=1;

        annotation (smoothOrder(normallyConstant=in_p3)=1,Documentation(info="<html>
<p>This function NoBypassCode calculates the currents (and the capacitances) that are necessary for the currents to be used in the top-level model.</p>
</html>"));
      end bjtNoBypassCode;

      function bjtRenameParameters "Technology parameter renaming"
        extends Modelica.Icons.Function;

        input Modelica.Electrical.Spice3.Internal.ModelcardBJT2
                                           ex
          "Modelcard with technology parameters";
        input Real TBJT;

        output BjtModelLineParams intern
          "Output record with Bjt model line parameters";

      algorithm
        intern.m_minBaseResistIsGiven := 0;
        intern.m_collectorConduct := 0;
        intern.m_emitterConduct := 0;
        intern.m_transitTimeVBCFactor := 0;
        intern.m_excessPhaseFactor := 0;
        intern.m_invEarlyVoltF := 0;
        intern.m_invRollOffF := 0;
        intern.m_invEarlyVoltR := 0;
        intern.m_invRollOffR := 0;

      //obsolete
        intern.m_bNPN := 1;
        intern.m_bPNP:=1;

        intern.m_area := 1.0;
        intern.m_bOff := false;
        intern.m_dICvbe := 0;
        intern.m_bICvbeIsGiven := 0;
        intern.m_dICvce := 0;
        intern.m_bICvceIsGiven := 0;
        intern.m_bSensArea := false;
        intern.m_dTemp := 1;

        intern.m_satCur := ex.IS;
        intern.m_betaF := ex.BF;
        intern.m_emissionCoeffF := ex.NF;
        intern.m_leakBEemissionCoeff := ex.NE;

        intern.m_leakBEcurrentIsGiven := if (ex.ISE > -1e40) then 1 else 0;
        intern.m_leakBEcurrent := if (ex.ISE > -1e40) then ex.ISE else 0;

        intern.m_c2IsGiven := if (ex.C2 > -1e40) then 1 else 0;
        intern.m_c2 := if (ex.C2 > -1e40) then ex.C2 else 0;

        intern.m_leakBCcurrentIsGiven := if (ex.ISC > -1e40) then 1 else 0;
        intern.m_leakBCcurrent := if (ex.ISC > -1e40) then ex.ISC else 0;

        intern.m_c4IsGiven := if (ex.C4 > -1e40) then 1 else 0;
        intern.m_c4 := if (ex.C4 > -1e40) then ex.C4 else 0;

        intern.m_betaR := ex. BR;
        intern.m_emissionCoeffR := ex.NR;
        intern.m_leakBCemissionCoeff := ex.NC;
        intern.m_earlyVoltF := ex.VAF;
        intern.m_rollOffF := ex.IKF;
        intern.m_earlyVoltR := ex.VAR;
        intern.m_rollOffR := ex.IKR;
        intern.m_emitterResist := ex.RE;
        intern.m_collectorResist := ex.RC;
        intern.m_baseCurrentHalfResist := ex.IRB;
        intern.m_baseResist := ex.RB;
        intern.m_minBaseResist := if (ex.RBM > -1e40) then ex.RBM else intern.m_baseResist;
        intern.m_depletionCapBE := ex.CJE;
        intern.m_potentialBE := ex.VJE;
        intern.m_junctionExpBE := ex.MJE;
        intern.m_transitTimeF := ex.TF;
        intern.m_transitTimeBiasCoeffF := ex.XTF;
        intern.m_transitTimeHighCurrentF := ex.ITF;
        intern.m_transitTimeFVBC :=ex.VTF;
        intern.m_excessPhase := ex.PTF;
        intern.m_depletionCapBC := ex.CJC;
        intern.m_potentialBC := ex.VJC;
        intern.m_junctionExpBC := ex.MJC;
        intern.m_baseFractionBCcap := ex.XCJC;
        intern.m_transitTimeR := ex.TR;
        intern.m_capCS := ex.CJS;
        intern.m_potentialSubstrate := ex.VJS;
        intern.m_exponentialSubstrate := ex.MJS;
        intern.m_betaExp := ex.XTB;
        intern.m_energyGap := ex.EG;
        intern.m_tempExpIS := ex.XTI;
        intern.m_fNcoef := ex.KF;
        intern.m_fNexp := ex.AF;
        intern.m_depletionCapCoeff := ex.FC;
        intern.m_tnom := ex.TNOM + Spice3.Internal.SpiceConstants.CONSTCtoK;

        intern.m_type := TBJT;

        annotation (Documentation(info="<html>
<p>This function assigns the external (given by the user, e.g. IS) technology parameters</p>
<p>to the internal parameters (e.g. m_satCur). It also does the analysis of the IsGiven values.</p>
</html>"));
      end bjtRenameParameters;

      function bjtRenameParametersDev "Temperature calculation"
        extends Modelica.Icons.Function;

        input Real AREA "Area factor";
        input Boolean OFF
          "Optional initial condition: false - IC not used, true - IC used, not implemented yet";
        input SI.Voltage IC_VBE "Initial condition value, not yet implemented";
        input SI.Voltage IC_VCE "Initial condition value, not yet implemented";
        input Boolean UIC "Use initial conditions, UIC";
        input Boolean SENS_AREA
          "Flag for sensitivity analysis, not yet implemented";
        input SI.Temp_C TEMP "Temperature";

        output Bjt dev "Output record Bjt";

      algorithm
        dev.m_area := AREA;
        dev.m_bOff := OFF;

        dev.m_bICvbeIsGiven := if (IC_VBE > -1e40) then 1 else 0;
        dev.m_dICvbe := if (IC_VBE > -1e40) then IC_VBE else 0;

        dev.m_bICvceIsGiven := if (IC_VCE > -1e40) then 1 else 0;
        dev.m_dICvce := if (IC_VCE > -1e40) then IC_VCE else 0;

        dev.m_uic := UIC;
        dev.m_bSensArea := SENS_AREA;
        dev.m_dTemp := TEMP + Spice3.Internal.SpiceConstants.CONSTCtoK
          "Device temperature";

        dev.m_transitTimeHighCurrentF := 0;
       dev.m_invRollOffF := 0;
       dev.m_invRollOffR := 0;
       dev.m_CScap := 0;
        annotation (Documentation(info="<html>
<p>This function assigns the external (given by the user, e.g. AREA) device parameters</p>
<p>to the internal parameters (e.g. m_area). It also does the analysis of the IsGiven values.</p>
</html>"));
      end bjtRenameParametersDev;

      record BjtModelLineVariables
        "Record for bjt model line variables, obsolete"
        extends Modelica.Icons.Record;
        extends Modelica.Icons.ObsoleteModel;

        SI.Current m_leakBEcurrent=1;
        SI.Current m_leakBCcurrent=1;
        SI.Resistance m_minBaseResist=1;
        Real m_invEarlyVoltF=1;
        Real m_invRollOffF=1;
        Real m_invEarlyVoltR=1;
        Real m_invRollOffR=1;
        SI.Conductance m_collectorConduct=1;
        SI.Conductance m_emitterConduct=1;
        Real m_transitTimeVBCFactor=1;
        Real m_excessPhaseFactor=1;

        Integer m_type=1;

        annotation (Documentation(info="<html>
<p>This record contains the model line (also called model card) variables that are used for the bipolar transistor model in SPICE3.</p>
</html>"),
        obsolete = "Obsolete record for bjt model line variables");
      end BjtModelLineVariables;

      record BjtVariables "Variables for the bjt model, obsolete"
        extends Modelica.Icons.Record;
        extends Modelica.Icons.ObsoleteModel;
        extends Bjt3Variables;

        Real m_CScap= 1;

        annotation (Documentation(info="<html>
<p>This record contains the model variables that are used for the bipolar transistor bjt model in SPICE3.</p>
</html>"),
        obsolete = "Obsolete record");
      end BjtVariables;

      record Bjt3Variables "Variables for the bjt3 model, obsolete"
        extends Modelica.Icons.Record;
        extends Modelica.Icons.ObsoleteModel;
        SI.Current m_transitTimeHighCurrentF=1;
        Real m_invRollOffF=1;
        Real m_invRollOffR=1;

        annotation (Documentation(info="<html>
<p>This record contains the model variables that are used for the bipolar transistor bjt3 model in SPICE3.</p>
</html>"),
        obsolete = "Obsolete record");
      end Bjt3Variables;
      annotation (Documentation(info="<html>
<p>This package Bjt contains functions and records with data of the Bjt bipolar transistor models.</p>
</html>"));
    end Bjt;

    package Bjt3 "Records and functions for bjt model, obsolete"
      extends Modelica.Icons.InternalPackage;
      extends Modelica.Icons.ObsoleteModel;

      record BjtModelLineParams
        "Record for bjt model line parameters, obsolete"
        extends Modelica.Icons.Record;
        extends Modelica.Icons.ObsoleteModel;
        Real m_type( start = 1) "device type : 1 = n,  -1 = p";

        Boolean m_bNPN( start = true) "NPN type device";
        Boolean m_bPNP( start = false) "PNP type device";
        SI.Temp_C m_tnom( start=Spice3.Internal.SpiceConstants.CKTnomTemp)
          "TNOM, Parameter measurement temperature";
        SI.Current m_satCur( start = 1.0e-16) "IS, Saturation Current";
        Real m_betaF( start = 100.0) "BF, Ideal forward beta";
        Real m_emissionCoeffF(  start = 1.0) "NF, Forward emission coefficient";
        Real m_leakBEemissionCoeff( start = 1.5)
          "NE, B-E leakage emission coefficient";
        SI.Current m_leakBEcurrent( start = 0.)
          "ISE, B-E leakage saturation current";
        Real m_c2( start = 0.) "C2, Obsolete parameter name";
        SI.Current m_leakBCcurrent( start = 0.)
          "ISC, B-C leakage saturation current";
        Real m_c4( start = 0.) "C4, Obsolete parameter name";
        Real m_leakBEcurrentIsGiven;
        Real m_c2IsGiven;
        Real m_leakBCcurrentIsGiven;
        Real m_c4IsGiven;
        Real m_betaR( start = 1.0) "BR, Ideal reverse beta";
        Real m_emissionCoeffR( start = 1.0) "NR, Reverse emission coefficient";
        Real m_leakBCemissionCoeff( start = 2.0)
          "NC, B-C leakage emission coefficient";
        SI.Voltage m_earlyVoltF( start = 0.0) "VAF, Forward Early voltage";
        SI.Current m_rollOffF( start = 0.0)
          "IKF, Forward beta roll-off corner current";
        SI.Voltage m_earlyVoltR( start = 0.0) "VAR, Reverse Early voltage";
        SI.Current m_rollOffR( start = 0.0)
          "IKR, reverse beta roll-off corner current";
        SI.Resistance m_emitterResist( start = 0.0) "RE, Emitter resistance";
        SI.Resistance m_collectorResist( start = 0.0)
          "RC, Collector resistance";
        SI.Current m_baseCurrentHalfResist( start = 0.0)
          "IRB, Current for base resistance=(rb+rbm)/2";
        SI.Resistance m_baseResist( start = 0.0)
          "RB, Zero bias base resistance";
        SI.Resistance m_minBaseResist( start = 0.0)
          "RBM, Minimum base resistance";
        Real m_minBaseResistIsGiven;
        SI.Capacitance m_depletionCapBE( start = 0.0)
          "CJE, Zero bias B-E depletion capacitance";
        SI.Voltage m_potentialBE( start = 0.75) "VJE, B-E built in potential";
        Real m_junctionExpBE( start = 0.33) "MJE, B-E built in potential";
        SI.Time m_transitTimeF( start = 0.0) "TF, Ideal forward transit time";
        Real m_transitTimeBiasCoeffF( start = 0.0)
          "XTF, Coefficient for bias dependence of TF";
        SI.Current m_transitTimeHighCurrentF( start = 0.0)
          "ITF, High current dependence of TF";
        SI.Voltage m_transitTimeFVBC( start = 0.0)
          "VTF, Voltage giving VBC dependence of TF";
        SI.Temp_C m_excessPhase( start = 0.0) "PTF, Excess phase";
        SI.Capacitance m_depletionCapBC( start = 0.0)
          "CJC, Zero bias B-C depletion capacitance";
        SI.Voltage m_potentialBC( start = 0.75) "VJC, B-C built in potential";
        Real m_junctionExpBC( start = 0.33)
          "MJC, B-C junction grading coefficient";
        Real m_baseFractionBCcap( start = 1.0)
          "XCJC, Fraction of B-C cap to internal base";
        SI.Time m_transitTimeR( start = 0.0) "TR, Ideal reverse transit time";
        SI.Capacitance m_capCS( start = 0.0) "CJS, Zero bias C-S capacitance";
        SI.Voltage m_potentialSubstrate( start = 0.75)
          "VJS, Zero bias C-S capacitance";
        Real m_exponentialSubstrate( start = 0.0)
          "MJS, Substrate junction grading coefficient";
        Real m_betaExp( start = 0.0) "XTB, Forward and reverse beta temp. exp.";
        SI.GapEnergy m_energyGap( start = 1.11)
          "EG, Energy gap for IS temp. dependency";
        Real m_tempExpIS( start = 3.0) "XTI,Temp. exponent for IS";
        Real m_fNcoef( start = 0.0) "KF, Flicker Noise Coefficient";
        Real m_fNexp( start = 1.0) "AF, Flicker Noise Exponent";
        Real m_depletionCapCoeff( start = 0.5)
          "FC, Forward bias junction fit parameter";

        Real m_collectorConduct( start = 0.0);
        Real m_emitterConduct( start = 0.0);
        Real m_transitTimeVBCFactor( start = 0.0);
        Real m_excessPhaseFactor( start = 0.0);
        Real m_invEarlyVoltF( start = 0.0);
        Types.InverseElectricCurrent m_invRollOffF( start = 0.0);
        Real m_invEarlyVoltR( start = 0.0);
        Types.InverseElectricCurrent m_invRollOffR( start = 0.0);

        annotation (Documentation(info="<html>
<p>This record contains the model line (also called model card) parameters that are used for the bipolar transistor model in SPICE3.</p>
</html>"),
        obsolete = "Obsolete record");
      end BjtModelLineParams;

      record BjtModelLineVariables
        "Record for bjt model line variables, obsolete"
        extends Modelica.Icons.Record;
        extends Modelica.Icons.ObsoleteModel;
        SI.Current m_leakBEcurrent;
        SI.Current m_leakBCcurrent;
        SI.Resistance m_minBaseResist;
        Real m_invEarlyVoltF;
        Real m_invRollOffF;
        Real m_invEarlyVoltR;
        Real m_invRollOffR;
        SI.Conductance m_collectorConduct;
        SI.Conductance m_emitterConduct;
        Real m_transitTimeVBCFactor;
        Real m_excessPhaseFactor;

        Integer m_type;

        annotation (Documentation(info="<html>
<p>This record contains the model line (also called model card) variables that are used for the bipolar transistor model in SPICE3.</p>
</html>"),
        obsolete = "Obsolete record");
      end BjtModelLineVariables;

      function bjtModelLineInitEquations "Initial calculation, obsolete"
        extends Modelica.Icons.Function;
        extends Modelica.Icons.ObsoleteModel;
        input BjtModelLineParams in_p
          "Input record with Bjt model line parameters";

        output BjtModelLineVariables out_v
          "Output record with Bjt model line variables";

      protected
        Real xfc;

      algorithm
        out_v.m_type := if
                          (in_p.m_bPNP) then -1 else 1;

        if ( not (in_p.m_leakBEcurrentIsGiven > 0.5) and (in_p.m_c2IsGiven > 0.5)) then
          out_v.m_leakBEcurrent := in_p.m_c2 * in_p.m_satCur;
        end if;
        if ( not (in_p.m_leakBCcurrentIsGiven > 0.5) and (in_p.m_c4IsGiven > 0.5)) then
          out_v.m_leakBCcurrent := in_p.m_c4 * in_p.m_satCur;
        end if;
        if ( not (in_p.m_minBaseResistIsGiven > 0.5)) then
          out_v.m_minBaseResist := in_p.m_baseResist;
        end if;
        if (in_p.m_earlyVoltF <> 0) then
          out_v.m_invEarlyVoltF := 1 / in_p.m_earlyVoltF;
        end if;
        if (in_p.m_rollOffF <> 0) then
          out_v.m_invRollOffF := 1 / in_p.m_rollOffF;
        end if;
        if (in_p.m_earlyVoltR <> 0) then
          out_v.m_invEarlyVoltR := 1 / in_p.m_earlyVoltR;
        end if;
        if (in_p.m_rollOffR <> 0) then
          out_v.m_invRollOffR := 1 / in_p.m_rollOffR;
        end if;
        if (in_p.m_collectorResist <> 0) then
          out_v.m_collectorConduct := 1 / in_p.m_collectorResist;
        end if;
        if (in_p.m_emitterResist <> 0) then
          out_v.m_emitterConduct := 1 / in_p.m_emitterResist;
        end if;
        if (in_p.m_transitTimeFVBC <> 0) then
          out_v.m_transitTimeVBCFactor := 1 / (in_p.m_transitTimeFVBC * 1.44);
        end if;
        out_v.m_excessPhaseFactor := (in_p.m_excessPhase / (180.0 / Modelica.Constants.pi)) * in_p.m_transitTimeF;

        xfc  := Modelica.Math.log(1 - in_p.m_depletionCapCoeff);

        annotation (Documentation(info="<html>
<p>Within this function some parameters are initially precalculated from model line parameters.</p>
</html>"),
        obsolete = "Obsolete function");
      end bjtModelLineInitEquations;

      record Bjt3 "Record for bjt3 device parameters, obsolete"
        extends Spice3.Internal.Model.Model;
        extends Modelica.Icons.Record;
        extends Modelica.Icons.ObsoleteModel;
       Real m_area(  start = 1.0) "AREA";
       Boolean m_bOff(  start = false) "OFF";
       SI.Voltage m_dICvbe( start = 0.0) "IC_VBE";
       Real m_bICvbeIsGiven( start = 0.0);
       SI.Voltage m_dICvce( start = 0.0) "IC_VCE";
       Real m_bICvceIsGiven( start = 0.0);
       Boolean m_bSensArea( start = false) "SENS_AREA";

        Real m_transitTimeHighCurrentF(start = 0.0);
        Types.InverseElectricCurrent m_invRollOffF( start = 0);
        Types.InverseElectricCurrent m_invRollOffR( start = 0);

        annotation (Documentation(info="<html>
<p>This record contains the device parameters that are used for the bipolar transistor bjt3 model in SPICE3.</p>
</html>"),
        obsolete = "Obsolete record");
      end Bjt3;

      record Bjt3Variables "Variables for the bjt3 model, obsolete"
        extends Modelica.Icons.Record;
        extends Modelica.Icons.ObsoleteModel;
        SI.Current m_transitTimeHighCurrentF( start = 0.0);
        Real m_invRollOffF( start = 0.0);
        Real m_invRollOffR( start = 0.0);

        annotation (Documentation(info="<html>
<p>This record contains the model variables that are used for the bipolar transistor bjt3 model in SPICE3.</p>
</html>"),
        obsolete = "Obsolete record");
      end Bjt3Variables;

      record Bjt3Calc "Bjt3 variables, obsolete"
        extends Modelica.Icons.Record;
        extends Modelica.Icons.ObsoleteModel;
        SI.Current m_tSatCur = 0;
        Real m_tBetaF = 1;
        Real m_tBetaR = 1;
        SI.Current m_tBEleakCur = 1e-14;
        SI.Current m_tBCleakCur = 1e-14;
        Real m_tBEcap = 0;
        Real m_tBEpot = 0.7;
        Real m_tBCcap = 0;
        Real m_tBCpot = 0.7;
        Real m_tDepCapBE = 0.7;
        Real m_tDepCapBC = 0.7;
        Real m_tVcrit = 0.7;
        Real m_dVt = 0.25;
        Real m_tF1c = 0;
        Real m_f2c = 0;
        Real m_f3c = 0;
        Real m_tF1e = 0;
        Real m_f2e = 0;
        Real m_f3e = 0;

        annotation (Documentation(info="<html>
<p>This record contains the model variables that are used for the bipolar transistor model in SPICE3.</p>
</html>"),
        obsolete = "Obsolete record");
      end Bjt3Calc;

      record CurrentsCapacitances "Bjt3 variables, obsolete"
        extends Modelica.Icons.Record;
        extends Modelica.Icons.ObsoleteModel;
        SI.Current iBE( start = 0.0);  //current through diode dE1 (ideal part)
        SI.Current iBEN( start = 0.0); //current through diode dE2 (non ideal part)
        SI.Current iBC( start = 0.0); //current through diode dC1 (ideal part)
        SI.Current iBCN( start = 0.0); //current through diode dC2 (non ideal part)
        SI.Current iCC( start = 0.0);  //channel current
        SI.Current capbc( start = 0.0);
        SI.Capacitance capbe( start = 0.0);
        SI.Capacitance capbx( start = 0.0);
        Real iXX( start = 0.0);
        SI.Capacitance capcs( start = 0.0);

        annotation (Documentation(info="<html>
<p>This record contains the model variables that are used for the bipolar transistor model in SPICE3.</p>
</html>"),
        obsolete = "Obsolete record");
      end CurrentsCapacitances;

      function bjt3InitEquations "Initial calculation, obsolete"
        extends Modelica.Icons.Function;
        extends Modelica.Icons.ObsoleteModel;
        input Bjt3 in_p "Input record Bjt3";
        input BjtModelLineParams in_pml
          "Input record with Bjt model line parameters";
        input BjtModelLineVariables in_vl
          "Input record with Bjt model line variables";
        output Bjt3Variables out_v "Output record with Bjt variables";

      algorithm
        // calculate the parameters that depend on the area factor
        out_v.m_transitTimeHighCurrentF := in_pml.m_transitTimeHighCurrentF * in_p.m_area;
        out_v.m_invRollOffF             := in_vl.m_invRollOffF / in_p.m_area;
        out_v.m_invRollOffR             := in_vl.m_invRollOffR / in_p.m_area;

        annotation (Documentation(info="<html>
<p>Within this function some parameters are initially precalculated from model line parameters.</p>
</html>"),
        obsolete = "Obsolete function");
      end bjt3InitEquations;

      function bjt3CalcTempDependencies
        "Temperature dependency calculation, obsolete"
        extends Modelica.Icons.Function;
        extends Modelica.Icons.ObsoleteModel;
        input Bjt3 in_p3 "Input record Bjt3";
        input BjtModelLineParams in_p
          "Input record with Bjt model line parameters";
        input Spice3.Internal.Model.Model m "Input record model";
        input BjtModelLineVariables in_vl
          "Input record with Bjt model line variables";

        output Bjt3Calc out_c "Output record Bjt3Calc";

      protected
        Real xfc;
        Real gmanew;
        Real fact1;
        SI.Voltage vt;
        Real fact2;
        Real egfet;
        Types.GapEnergyPerEnergy arg;
        Real pbfact;
        Real ratlog;
        Real ratio1;
        Real factlog;
        Real factor;
        Real bfactor;
        Real pbo;
        Real gmaold;
      algorithm

        fact1 := in_p.m_tnom/Spice3.Internal.SpiceConstants.REFTEMP;
        vt := m.m_dTemp*Spice3.Internal.SpiceConstants.CONSTKoverQ;
        fact2 := m.m_dTemp/Spice3.Internal.SpiceConstants.REFTEMP;

        egfet  := 1.16 - (7.02e-4 * m.m_dTemp * m.m_dTemp) / (m.m_dTemp + 1108);

        arg := -egfet/(2*Modelica.Constants.k*m.m_dTemp) + 1.1150877/(Modelica.Constants.k
          *(Spice3.Internal.SpiceConstants.REFTEMP +
          Spice3.Internal.SpiceConstants.REFTEMP));
        pbfact := -2*vt*(1.5*Modelica.Math.log(fact2) + Spice3.Internal.SpiceConstants.CHARGE
          *arg);

        ratlog  := Modelica.Math.log( m.m_dTemp / in_p.m_tnom);
        ratio1  := m.m_dTemp / in_p.m_tnom - 1;
        factlog := ratio1 * in_p.m_energyGap / vt + in_p.m_tempExpIS * ratlog;
        factor  := exp( factlog);
        bfactor := exp(ratlog * in_p.m_betaExp);
        pbo    := (in_p.m_potentialBE - pbfact) / fact1;
        gmaold := (in_p.m_potentialBE - pbo) / pbo;

        out_c.m_tSatCur    := in_p.m_satCur * factor * in_p3.m_area;
        out_c.m_tBetaF     := in_p.m_betaF * bfactor;
        out_c.m_tBetaR     := in_p.m_betaR * bfactor;
        out_c.m_tBEleakCur := in_vl.m_leakBEcurrent * exp(factlog / in_p.m_leakBEemissionCoeff) / bfactor
                              * in_p3.m_area;
        out_c.m_tBCleakCur := in_vl.m_leakBCcurrent * exp(factlog / in_p.m_leakBCemissionCoeff) / bfactor
                              * in_p3.m_area;

        out_c.m_tBEcap := in_p.m_depletionCapBE/(1 + in_p.m_junctionExpBE*(4e-4*(
          in_p.m_tnom - Spice3.Internal.SpiceConstants.REFTEMP)
           - gmaold));
        out_c.m_tBEpot := fact2 * pbo + pbfact;

        gmanew := (out_c.m_tBEpot - pbo) / pbo;

        out_c.m_tBEcap := out_c.m_tBEcap*(1 + in_p.m_junctionExpBE*(4e-4*(m.m_dTemp
           - Spice3.Internal.SpiceConstants.REFTEMP) - gmanew));

        pbo    := (in_p.m_potentialBC - pbfact) / fact1;
        gmaold := (in_p.m_potentialBC - pbo) / pbo;

        out_c.m_tBCcap := in_p.m_depletionCapBC/(1 + in_p.m_junctionExpBC*(4e-4*(
          in_p.m_tnom - Spice3.Internal.SpiceConstants.REFTEMP)
           - gmaold));
        out_c.m_tBCpot := fact2 * pbo + pbfact;

        gmanew := (out_c.m_tBCpot - pbo) / pbo;

        out_c.m_tBCcap := out_c.m_tBCcap*(1 + in_p.m_junctionExpBC*(4e-4*(m.m_dTemp
           - Spice3.Internal.SpiceConstants.REFTEMP) - gmanew));

        out_c.m_tDepCapBE := in_p.m_depletionCapCoeff * out_c.m_tBEpot;
        out_c.m_tDepCapBC := in_p.m_depletionCapCoeff * out_c.m_tBCpot;
        xfc               := Modelica.Math.log( 1 - in_p.m_depletionCapCoeff);
        out_c.m_tVcrit := vt*Modelica.Math.log(vt/(Spice3.Internal.SpiceConstants.CONSTroot2
          *in_p.m_satCur));
        out_c.m_dVt       := vt;

        // calculate the parameters that depend on the area factor
        out_c.m_tBEcap := out_c.m_tBEcap * in_p3.m_area;
        out_c.m_tBCcap := out_c.m_tBCcap * in_p3.m_area;
        (out_c.m_tF1c,out_c.m_f2c,out_c.m_f3c) :=
          Spice3.Internal.Functions.junctionCapCoeffs(
                in_p.m_junctionExpBC,
                in_p.m_depletionCapCoeff,
                out_c.m_tBCpot);
        (out_c.m_tF1e,out_c.m_f2e,out_c.m_f3e) :=
          Spice3.Internal.Functions.junctionCapCoeffs(
                in_p.m_junctionExpBE,
                in_p.m_depletionCapCoeff,
                out_c.m_tBEpot);

        annotation (Documentation(info="<html>
<p>In this function for the bipolar transistor model temperature dependencies are calculated using temperature treating functions from the equation package.</p>
</html>"),
        obsolete = "Obsolete function");
      end bjt3CalcTempDependencies;

      function bjt3NoBypassCode "Calculation of currents, obsolete"
        extends Modelica.Icons.Function;
        extends Modelica.Icons.ObsoleteModel;
        input Spice3.Internal.Model.Model in_m "Input record model";
        input Bjt in_p3 "Input record Bjt3";
        input BjtModelLineParams in_p
          "Input record with Bjt model line parameters";
        input Bjt3Calc in_c "Input record Bjt3Calc";
        input BjtModelLineVariables in_vl
          "Input record with Bjt model line variables";
        input SI.Voltage[6] in_m_pVoltageValues; /* 1 Col; 2 Base; 3 Emit; 4 ColP; 5 BaseP; 6 EmitP */
        input Boolean in_m_bInit;

        output CurrentsCapacitances out_cc
          "Output record with calculated currents and capacitances";

        output SI.Capacitance capbe "Capacitance";
        output SI.Capacitance capbc "Capacitance";
        output SI.Capacitance capbx "Capacitance";

      protected
        SI.Voltage vce;
        SI.Voltage vbe;
        SI.Voltage vbx;
        SI.Voltage vbc;
        SI.Conductance gbe;
        SI.Current cbe;
        SI.Conductance gbc;
        SI.Current cbc;
        SI.Conductance gben;
        SI.Current cben;
        SI.Conductance gbcn;
        SI.Current cbcn;
        SI.Current cjbe;
        SI.Current cjbc;
          Real dqbdve;
          Real dqbdvc;
          Real qb;
          Real q1;
          Real q2;
          Real arg;
          Real sqarg;
          Real cc;
        SI.Current cex;
        SI.Conductance gex;
        SI.Time ttime;
          Real step;
          Real laststep;
        SI.Current bcex0;
        SI.Current bcex1;
          Real arg1;
          Real arg2;
          Real denom;
          Real arg3;
          Real rbpr;
          Real rbpi;
          Real gx;
          Real xjrb;
          Real go;
          Real gm;
        Real captt;
        SI.Charge chargebe;
        SI.Charge chargebc;
        SI.Charge chargebx;
          Real argtf;
          Real exponent;
      //  SI.Temp_K temp;
          Real temp;

          Real aux1;
          Real aux2;

      algorithm
        vce := in_p.m_type * (in_m_pVoltageValues[4] - in_m_pVoltageValues[6]); // ( ColP, EmitP);
        vbe := in_p.m_type * (in_m_pVoltageValues[5] - in_m_pVoltageValues[6]); // ( BaseP, EmitP);
        vbx := in_p.m_type * (in_m_pVoltageValues[2] - in_m_pVoltageValues[4]); // ( Base, ColP);

        if (Spice3.Internal.SpiceRoot.useInitialConditions()) then
          if (in_p3.m_bICvbeIsGiven > 0.5) then
            vbe := in_p.m_type * in_p3.m_dICvbe;
          end if;
          if (in_p3.m_bICvceIsGiven > 0.5) then
            vce := in_p.m_type * in_p3.m_dICvce;
          end if;
          vbx := vbe - vce;
        elseif (Spice3.Internal.SpiceRoot.initJunctionVoltages()) then
          if (in_p3.m_bOff) then
            vbe := 0.0;
            vce := 0.0;
            vbx := 0.0;
          else
            vbe := in_c.m_tVcrit;
            vce := vbe;
            vbx := 0.0;
          end if;
        end if;

        vbc := vbe - vce;

          // junction current
        (cbe,gbe) := Spice3.Internal.Functions.junction2(
                vbe,
                in_m.m_dTemp,
                in_p.m_emissionCoeffF,
                in_c.m_tSatCur);

        out_cc.iBE   := in_p.m_type * cbe / in_c.m_tBetaF;
        (cben,gben) := Spice3.Internal.Functions.junction2(
                vbe,
                in_m.m_dTemp,
                in_p.m_leakBEemissionCoeff,
                in_c.m_tBEleakCur);
        out_cc.iBEN  := in_p.m_type * cben;
        (cbc,gbc) := Spice3.Internal.Functions.junction2(
                vbc,
                in_m.m_dTemp,
                in_p.m_emissionCoeffR,
                in_c.m_tSatCur);
        out_cc.iBC   := in_p.m_type * cbc / in_c.m_tBetaR;
        (cbcn,gbcn) := Spice3.Internal.Functions.junction2(
                vbc,
                in_m.m_dTemp,
                in_p.m_leakBCemissionCoeff,
                in_c.m_tBCleakCur);
        out_cc.iBCN  := in_p.m_type * cbcn;
        cjbe         := cbe / in_c.m_tBetaF + cben;
        cjbc         := cbc / in_c.m_tBetaR + cbcn;

        // determine base charge terms
        q1 := 1.0/(1.0 - in_p.m_invEarlyVoltF * vbc - in_p.m_invEarlyVoltR * vbe);
        if (in_vl.m_invRollOffF == 0 and in_vl.m_invRollOffR == 0) then
          qb     := q1;
          dqbdve := q1*qb*in_p.m_invEarlyVoltR;
          dqbdvc := q1*qb*in_p.m_invEarlyVoltF;
        else
          q2    := in_vl.m_invRollOffF*cbe + in_vl.m_invRollOffR*cbc;
          arg   := max( 0.0, 1+4*q2);
          sqarg := 1;
          if (arg <> 0) then
            sqarg := sqrt(arg);
          end if;
          qb     := q1*(1+sqarg)/2;
          dqbdve := q1*(qb*in_p.m_invEarlyVoltR + in_vl.m_invRollOffF*gbe/sqarg);
          dqbdvc := q1*(qb*in_p.m_invEarlyVoltF + in_vl.m_invRollOffR*gbc/sqarg);
        end if;

        // determine dc incremental conductances - Weil's approximation
        cc    := 0.0;
        cex   := cbe;
        gex   := gbe;
        ttime := 1;
        if ((in_vl.m_excessPhaseFactor <> 0) and (ttime > 0.0)) then
          step     :=0;
          laststep :=1;
          bcex0    :=0;
          bcex1    :=0;
          if ( bcex1 == 0.0) then
               bcex1 := cbe / qb;
               bcex0 := bcex1;

          end if;
          arg1  := step / in_vl.m_excessPhaseFactor;
          arg2  := 3 * arg1;
          arg1  := arg2 * arg1;
          denom := 1 + arg1 + arg2;
          arg3  := arg1 / denom;
          cc    := (bcex0 * (1 + step / laststep + arg2) -
                   bcex1 * step / laststep) / denom;
          cex   := cbe * arg3;
          gex   := gbe * arg3;

        end if;
        cc := cc+(cex-cbc)/qb;

        // resistances
        rbpr := in_vl.m_minBaseResist / in_p3.m_area;
        rbpi := in_p.m_baseResist / in_p3.m_area-rbpr;
        gx   := rbpr + rbpi / qb;
        xjrb := in_p.m_baseCurrentHalfResist * in_p3.m_area;
        if (xjrb <> 0) then
          arg1 := max( (cjbe + cjbc) / xjrb, 1e-9);
          arg2 := (-1 + sqrt( 1 + 14.59025 * arg1)) / 2.4317 / sqrt( arg1);
          arg1 := tan(arg2);
          gx   := rbpr + 3 * rbpi * (arg1-arg2) / arg2 / arg1 / arg1;
        end if;
        if (gx <> 0) then
          gx := 1 / gx;
        end if;

        // determine dc incremental conductances
        go := (gbc+(cex-cbc)*dqbdvc/qb)/qb;
        gm := (gex-(cex-cbc)*dqbdve/qb)/qb - go;
        out_cc.iCC := in_p.m_type * cc;

        // charge storage elements and transit time calculation
        captt := 0.0;
        if (in_p.m_transitTimeF <> 0.0 and vbe > 0.0) then
          argtf := 0.0;
          arg2  := 0.0;
          arg3  := 0.0;
          if (in_p.m_transitTimeBiasCoeffF <> 0.0) then
            argtf := in_p.m_transitTimeBiasCoeffF;
            if (in_vl.m_transitTimeVBCFactor <> 0.0) then
              exponent := min( 50., vbc * in_vl.m_transitTimeVBCFactor);
              argtf    := argtf * exp( exponent);
            end if;
              arg2 := argtf;
              if (in_p.m_transitTimeHighCurrentF <> 0) then
                temp  := cbe / (cbe + in_p.m_transitTimeHighCurrentF);
                argtf := argtf * temp * temp;
                arg2  := argtf * (3-temp-temp);
              end if;
              arg3 := cbe * argtf * in_vl.m_transitTimeVBCFactor;
          end if;
          cbe   := cbe * (1 + argtf) / qb;
          gbe   := (gbe * (1 + arg2) - cbe * dqbdve) / qb;
          captt := in_p.m_transitTimeF * (arg3 - cbe * dqbdvc) / qb;
        end if;
        (capbe,chargebe) :=
          Spice3.Internal.Functions.junctionCapTransTime(
                in_c.m_tBEcap,
                vbe,
                in_c.m_tDepCapBE,
                in_p.m_junctionExpBE,
                in_c.m_tBEpot,
                in_c.m_tF1e,
                in_c.m_f2e,
                in_c.m_f3e,
                in_p.m_transitTimeF,
                gbe,
                cbe);

        out_cc.iXX        := 0;
        aux1 := in_c.m_tBCcap*in_p.m_baseFractionBCcap;
        (capbc,chargebc) :=
          Spice3.Internal.Functions.junctionCapTransTime(
                aux1,
                vbc,
                in_c.m_tDepCapBC,
                in_p.m_junctionExpBC,
                in_c.m_tBCpot,
                in_c.m_tF1c,
                in_c.m_f2c,
                in_c.m_f3c,
                in_p.m_transitTimeR,
                gbc,
                cbc);

        aux2:= in_c.m_tBCcap*(1. - in_p.m_baseFractionBCcap);
        (capbx,chargebx) :=
          Spice3.Internal.Functions.junctionCap(
                aux2,
                vbx,
                in_c.m_tDepCapBC,
                in_p.m_junctionExpBC,
                in_c.m_tBCpot,
                in_c.m_tF1c,
                in_c.m_f2c,
                in_c.m_f3c);

        annotation (Documentation(info="<html>
<p>This function NoBypassCode calculates the currents (and the capacitances) that are necessary for the currents to be used in the top-level model.</p>
</html>"),
        obsolete = "Obsolete function");
      end bjt3NoBypassCode;

      record Bjt "Record for bjt device parameters, obsolete"
        extends Bjt3;
        annotation (Documentation(info="<html>
<p>This record contains the device parameters that are used for the bipolar transistor bjt model in SPICE3.</p>
</html>"),
        obsolete = "Obsolete record");
      end Bjt;

      record BjtVariables "Variables for the bjt model, obsolete"
        extends Bjt3Variables;

        Real m_CScap;

        annotation (Documentation(info="<html>
<p>This record contains the model variables that are used for the bipolar transistor bjt model in SPICE3.</p>
</html>"),
        obsolete = "Obsolete record");
      end BjtVariables;

      function bjtInitEquations "Initial calculation, obsolete"
        extends Modelica.Icons.Function;
        extends Modelica.Icons.ObsoleteModel;
        input Bjt in_p "Input record Bjt";
        input BjtModelLineParams in_pml
          "Input record with Bjt model line parameters";
        input BjtModelLineVariables in_vl
          "Input record with Bjt model line variables";
        output BjtVariables out_v "Output record with Bjt variables";

      protected
        Bjt3Variables v3 "Record with Bjt variables";

      algorithm
        v3 := bjt3InitEquations(in_p, in_pml, in_vl);
        // calculate the parameters that depend on the area factor
        out_v.m_CScap := in_pml.m_capCS * in_p.m_area;

        annotation (Documentation(info="<html>
<p>Within this function some parameters are initially precalculated from model line parameters.</p>
</html>"),
        obsolete = "Obsolete function");
      end bjtInitEquations;

      function bjtNoBypassCode "Calculation of currents, obsolete"
        extends Modelica.Icons.Function;
        extends Modelica.Icons.ObsoleteModel;
        input Spice3.Internal.Model.Model in_m "Input record model";
        input Bjt3 in_p3 "Input record Bjt3";
        input BjtModelLineParams in_p
          "Input record with Bjt model line parameters";
        input Bjt3Calc in_c "Input record Bjt3Calc";
        input BjtVariables in_v "Input record with Bjt variables";
        input BjtModelLineVariables in_vl;
        input SI.Voltage[6] in_m_pVoltageValues; /* 1 Col; 2 Base; 3 Emit; 4 Subst; 5 ColP; 6 BaseP; 7 EmitP */

        input Boolean in_m_bInit;

        output CurrentsCapacitances out_cc
          "Output record with calculated currents and capacitances";

        output SI.Capacitance capbe "Capacitance";
        output SI.Capacitance capbc "Capacitance";
        output SI.Capacitance capbx "Capacitance";
      protected
        SI.Voltage[6] bjt3_VoltageValues; /* 1 Col; 2 Base; 3 Emit; 4 ColP; 5 BaseP; 6 EmitP */
        Integer i;
        SI.Capacitance capcs;
        SI.Charge chargecs;
        SI.Voltage vcs;
        Real arg;
        Real sarg;

      algorithm
        // Bjt3 has got only 6 pins, therefore new vector VoltageValues
        for i in 1:3 loop
          bjt3_VoltageValues[i] := in_m_pVoltageValues[i];
        end for;
        for i in 4:6 loop
          bjt3_VoltageValues[i] := in_m_pVoltageValues[i];
        end for;

        (out_cc, capbe, capbc, capbx)   := bjt3NoBypassCode(in_m, in_p3, in_p, in_c, in_vl, bjt3_VoltageValues,
                     in_m_bInit);
        capcs    := 0;
        chargecs := 0;
        vcs      := in_p.m_type * (0- in_m_pVoltageValues[4]); // ( Subst,  ColP);
        if (vcs < 0) then
          arg      := 1 - vcs / in_p.m_potentialSubstrate;
          sarg     := exp( -in_p.m_exponentialSubstrate * Modelica.Math.log( arg));
          capcs    := in_v.m_CScap * sarg;
          chargecs := in_p.m_potentialSubstrate * in_v.m_CScap *
                      (1-arg*sarg)/(1-in_p.m_exponentialSubstrate);
        else
          capcs    := in_v.m_CScap * (1 + in_p.m_exponentialSubstrate * vcs / in_p.m_potentialSubstrate);
          chargecs := vcs * in_v.m_CScap *(1+in_p.m_exponentialSubstrate*vcs/
                                       (2*in_p.m_potentialSubstrate));
        end if;

        annotation (Documentation(info="<html>
<p>This function NoBypassCode calculates the currents (and the capacitances) that are necessary for the currents to be used in the top-level model.</p>
</html>"),
        obsolete = "Obsolete function");
      end bjtNoBypassCode;

      function bjtRenameParameters "Technology parameter renaming, obsolete"
          extends Modelica.Icons.Function;
        extends Modelica.Icons.ObsoleteModel;
        input Modelica.Electrical.Spice3.Internal.ModelcardBJT ex
          "Modelcard with technology parameters";
        input Spice3.Internal.SpiceConstants con "Spice constants";
        input Real TBJT "Type";

        output BjtModelLineParams intern
          "Output record with Bjt model line parameters";
      algorithm

        intern.m_type := TBJT;
        intern.m_satCur := ex.IS;
        intern.m_betaF := ex.BF;
        intern.m_emissionCoeffF := ex.NF;
        intern.m_leakBEemissionCoeff := ex.NE;

        intern.m_leakBEcurrentIsGiven := if (ex.ISE > -1e40) then 1 else 0;
        intern.m_leakBEcurrent := if
                                    (ex.ISE > -1e40) then ex.ISE else 0;

        intern.m_c2IsGiven := if (ex.C2 > -1e40) then 1 else 0;
        intern.m_c2 := if (ex.C2 > -1e40) then ex.C2 else 0;

        intern.m_leakBCcurrentIsGiven := if (ex.ISC > -1e40) then 1 else 0;
        intern.m_leakBCcurrent := if (ex.ISC > -1e40) then ex.ISC else 0;

        intern.m_c4IsGiven := if (ex.C4 > -1e40) then 1 else 0;
        intern.m_c4 := if (ex.C4 > -1e40) then ex.C4 else 0;

        intern.m_betaR := ex. BR;
        intern.m_emissionCoeffR := ex.NR;
        intern.m_leakBCemissionCoeff := ex.NC;
        intern.m_earlyVoltF := ex.VAF;
        intern.m_rollOffF := ex.IKF;
        intern.m_earlyVoltR := ex.VAR;
        intern.m_rollOffR := ex.IKR;
        intern.m_emitterResist := ex.RE;
        intern.m_collectorResist := ex.RC;
        intern.m_baseCurrentHalfResist := ex.IRB;
        intern.m_baseResist := ex.RB;

        intern.m_minBaseResistIsGiven := if (ex.RBM > -1e40) then 1 else 0;
        intern.m_minBaseResist := if (ex.RBM > -1e40) then ex.RBM else 0;

        intern.m_depletionCapBE :=ex.CJE;
        intern.m_potentialBE :=ex.VJE;
        intern.m_junctionExpBE := ex.MJE;
        intern.m_transitTimeF :=ex.TF;
        intern.m_transitTimeBiasCoeffF := ex.XTF;
        intern.m_transitTimeHighCurrentF := ex.ITF;
        intern.m_transitTimeFVBC :=ex.VTF;
        intern.m_excessPhase := ex.PTF;
        intern.m_depletionCapBC := ex.CJC;
        intern.m_potentialBC := ex.VJC;
        intern.m_junctionExpBC := ex.MJC;
        intern.m_baseFractionBCcap := ex.XCJC;
        intern.m_transitTimeR := ex.TR;
        intern.m_capCS := ex.CJS;
        intern.m_potentialSubstrate := ex.VJS;
        intern.m_exponentialSubstrate := ex.MJS;
        intern.m_betaExp := ex.XTB;
        intern.m_energyGap := ex.EG;
        intern.m_tempExpIS := ex.XTI;
        intern.m_fNcoef := ex.KF;
        intern.m_fNexp := ex.AF;
        intern.m_depletionCapCoeff :=ex.FC;
        intern.m_tnom := if (ex.TNOM > -1e40) then ex.TNOM +
          Spice3.Internal.SpiceConstants.CONSTCtoK else 300.15;

        annotation (Documentation(info="<html>
<p>This function assigns the external (given by the user, e.g., IS) technology parameters
to the internal parameters (e.g., m_satCur). It also does the analysis of the IsGiven values.</p>
</html>"),
        obsolete = "Obsolete function");
      end bjtRenameParameters;

      function bjtRenameParametersDev "Temperature calculation, obsolete"
         extends Modelica.Icons.Function;
        extends Modelica.Icons.ObsoleteModel;
       input Real AREA "Area factor";
       input Boolean OFF
          "Optional initial condition: false - IC not used, true - IC used, not implemented yet";
       input SI.Voltage IC_VBE "Initial condition value, not yet implemented";
       input SI.Voltage IC_VCE "Initial condition value, not yet implemented";
       input Boolean SENS_AREA
          "Flag for sensitivity analysis, not yet implemented";

       output Bjt3 dev "Output record Bjt3";

      algorithm
        dev.m_area := AREA;
        dev.m_bOff := OFF;

        dev.m_bICvbeIsGiven := if (IC_VBE > -1e40) then 1 else 0;
        dev.m_dICvbe := if (IC_VBE > -1e40) then IC_VBE else 0;

        dev.m_bICvceIsGiven := if (IC_VCE > -1e40) then 1 else 0;
        dev.m_dICvce := if (IC_VCE > -1e40) then IC_VCE else 0;

        dev.m_bSensArea := SENS_AREA;

        annotation (Documentation(info="<html>
<p>This function assigns the external (given by the user, e.g., AREA) device parameters to the internal parameters (e.g., m_area). It also does the analysis of the IsGiven values.</p>
</html>"),
        obsolete = "Obsolete function");
      end bjtRenameParametersDev;

      function bjtRenameParametersDevTemp "Temperature calculation, obsolete"
         extends Modelica.Icons.Function;
        extends Modelica.Icons.ObsoleteModel;
       input SI.Temp_C TEMP "Temperature";

      output Spice3.Internal.Model.Model m "Output record model";
      algorithm

        m.m_dTemp := TEMP + Spice3.Internal.SpiceConstants.CONSTCtoK;

        annotation (Documentation(info="<html>
<p>This function calculates device parameters which are temperature dependent.</p>
</html>"),
        obsolete = "Obsolete function");
      end bjtRenameParametersDevTemp;

      function bjtRenameParametersType "Type, obsolete"
        extends Modelica.Icons.Function;
        extends Modelica.Icons.ObsoleteModel;
       input Real TBJT "Type";
       output BjtModelLineParams dev_type "Output record Bjt3";
      algorithm
        dev_type.m_type := TBJT;

        annotation (Documentation(info="<html>
<p>This function assigns the external (given by the user, e.g. AREA) device parameters to the internal parameters (e.g. m_area). It also does the analysis of the IsGiven values.</p>
</html>"),
        obsolete = "Obsolete function");
      end bjtRenameParametersType;

      annotation (Documentation(info="<html>
<p>The package Bjt3 is obsolete. Please use package Bjt instead.</p>
<p>This package Bjt3 contains functions and records with data of the Bjt3 bipolar transistor models.</p>
</html>"),
        obsolete = "Obsolete package - use Modelica.Electrical.Spice3.Internal.Bjt");
    end Bjt3;

    package Fet
        extends Modelica.Icons.InternalPackage;
      record Fet "Record for Fet parameters"
        extends Modelica.Electrical.Spice3.Internal.Model.Model;

        Real m_area(start = 1.0) "AREA, Area factor";
        Boolean m_off(start = false) "OFF, Device initially off";
        SI.Voltage m_dICVDS(start = 0.0) "IC_VDS";
        Real m_bICVDSIsGiven "IC_VDS, IsGivenValue";
        SI.Voltage m_dICVGS(start = 0.0) "IC_VGS";
        Real m_bICVGSIsGiven "IC_VGS, IsGivenValue";
        Boolean m_uic "Use initial conditions, UIC";

        SI.Current m_tSatCur(start = 0);
        SI.Voltage m_tGatePot(start = 0);
        SI.Capacitance m_tCGS(start = 0);
        SI.Capacitance m_tCGD(start = 0);
        SI.Voltage m_corDepCap(start = 0);
        SI.Voltage m_vcrit(start = 0);
        SI.Voltage m_f1(start = 0);
        Real m_f2(start = 0);
        Real m_f3(start = 0);
        SI.Voltage m_dVt(start = 0);

        SI.Voltage m_vgs "Vgs, Voltage G-S";
        SI.Voltage m_vgd "Vgd, Voltage G-D";
        SI.Voltage m_vds "Vds";
        SI.Current m_cgd "Igd";
        SI.Conductance m_ggd "Ggd";
        SI.Current m_cgs "Igs";
        SI.Conductance m_ggs "Ggs";
        SI.Charge m_chargegd "Qgd";
        SI.Capacitance m_capgd "Cgd, G-D junction cap";
        SI.Charge m_chargegs "Qgs";
        SI.Capacitance m_capgs "Cgs, G-S junction capacitance";
        SI.Current m_cdrain "Idrain";
        SI.Conductance m_gm "Gm";
        SI.Conductance m_gds "Gds";

      end Fet;

      record FetModelLine "Record for Fet model line parameters"
      extends Modelica.Icons.Record;
        SI.Voltage m_threshold(start = -2.0) "VTO";
        Real m_beta(start = 1e-4) "BETA";
        SI.InversePotential m_lModulation(start = 0.0) "LAMBDA";
        SI.Resistance m_drainResist(start = 0.0) "RD";
        SI.Resistance m_sourceResist(start = 0) "RS";
        SI.Capacitance m_capGS(start = 0) "CGS";
        SI.Capacitance m_capGD(start = 0) "CGD";
        SI.Voltage m_gatePotential(start = 1.0) "PB";
        SI.Current m_gateSatCurrent(start = 1e-14) "IS";
        Real m_depletionCapCoeff(start = 0.5) "FC";
        Real m_b(start = 1.0) "B";
        Real m_fNcoef(start = 0.0) "KF";
        Real m_fNexp(start = 1.0) "AF";

        SI.Conductance m_drainConduct(start = 0);
        SI.Conductance m_sourceConduct(start = 0);
        SI.Temp_K m_tnom(start=Modelica.Electrical.Spice3.Internal.SpiceConstants.CKTnomTemp) "TNOM";

      end FetModelLine;

      record CurrrentsCapacitances "Currents and Capacities"
      extends Modelica.Icons.Record;
        SI.Current idrain(start=0);
        SI.Current iGD(start=0);
        SI.Current iGS(start=0);
        SI.Capacitance cGS(start=0);
        SI.Capacitance cGD(start=0);

        annotation (Documentation(info="<html>
<p>This record CurrentsCapacities contains values for the currents and the capacities inside the model Jfet.</p>
</html>"));
      end CurrrentsCapacitances;

    function fetRenameParametersDev
        "Device Parameter renaming to internal names"

    extends Modelica.Icons.Function;
      input Real AREA "Number of parallel connected identical elements";
      input Boolean OFF
          "Optional initial condition: 0 - IC not used, 1 - IC used, not implemented yet";
      input SI.Voltage IC_VDS
          "Initial condition value VDS, not implemented yet";
      input SI.Voltage IC_VGS
          "Initial condition value VGS, not implemented yet";
      input Boolean UIC "Use initial conditions, UIC";
      input SI.Temp_C TEMP "Temperature";

      output Fet dev "Output record MESFET";

    algorithm
      dev.m_capgd := 0;
      dev.m_capgs := 0;
      dev.m_cdrain := 0;
      dev.m_cgd := 0;
      dev.m_cgs := 0;
      dev.m_chargegd := 0;
      dev.m_chargegs := 0;
      dev.m_corDepCap := 0;
      dev.m_dVt := 0;
      dev.m_f1 := 0;
      dev.m_f2 := 0;
      dev.m_f3 := 0;
      dev.m_gds := 0;
      dev.m_ggd := 0;
      dev.m_ggs := 0;
      dev.m_gm := 0;
      dev.m_tCGD := 0;
      dev.m_tCGS := 0;
      dev.m_tGatePot := 0;
      dev.m_tSatCur := 0;
      dev.m_vcrit := 0;
      dev.m_vds := 0;
      dev.m_vgd := 0;
      dev.m_vgs := 0;

      dev.m_bICVDSIsGiven := if ( IC_VDS > -1e40) then 1 else 0;
      dev.m_dICVDS := if ( IC_VDS > -1e40) then IC_VDS else 0;

      dev.m_bICVGSIsGiven := if ( IC_VGS > -1e40) then 1 else 0;
      dev.m_dICVGS := if ( IC_VGS > -1e40) then IC_VGS else 0;

      dev.m_off   := OFF;           // non-zero to indicate device is off for dc analysis
      dev.m_uic   := UIC;
      dev.m_dTemp := TEMP + Modelica.Electrical.Spice3.Internal.SpiceConstants.CONSTCtoK;
      dev.m_area  := AREA;          // Number of parallel connected identical elements

    end fetRenameParametersDev;

    end Fet;

      package Jfet "Records and functions for Jfet"
          extends Modelica.Icons.InternalPackage;

        record JfetModelLine "Record for Jfet model line parameters"
          extends Modelica.Electrical.Spice3.Internal.Fet.FetModelLine;

          SI.InversePotential m_bFac;

        end JfetModelLine;

        function jfetInitEquations "FET initial precalculations"
        extends Modelica.Icons.Function;
          input Modelica.Electrical.Spice3.Internal.Fet.Fet in_f;
          input JfetModelLine in_fm;

          output JfetModelLine out_fm;

        algorithm
          out_fm := in_fm;

          out_fm.m_beta           := in_fm.m_beta * in_f.m_area;
          out_fm.m_drainConduct   := in_fm.m_drainConduct * in_f.m_area;
          out_fm.m_sourceConduct  := in_fm.m_sourceConduct * in_f.m_area;
          out_fm.m_gateSatCurrent := in_fm.m_gateSatCurrent * in_f.m_area;

        end jfetInitEquations;

        function jfetModelLineInitEquations "Initial precalculation"
        extends Modelica.Icons.Function;
          input JfetModelLine in_fm;

          output JfetModelLine out_fm;

        algorithm
          out_fm := in_fm;

          //  Fet_Model_Line::InitEquations();
          //  algorithm aus FET.fetModelLineInitEquations kopiert, statt Funktionsaufruf
          if (in_fm.m_drainResist <> 0) then
            out_fm.m_drainConduct := 1 / in_fm.m_drainResist;
          end if;
          if (in_fm.m_sourceResist <> 0) then
            out_fm.m_sourceConduct := 1 / in_fm.m_sourceResist;
          end if;

          if (out_fm.m_depletionCapCoeff > 0.95) then
            out_fm.m_depletionCapCoeff := 0.95;
          end if;
          out_fm.m_bFac := (1 - out_fm.m_b) / (out_fm.m_gatePotential - out_fm.m_threshold);

        end jfetModelLineInitEquations;

        function drainCur "Drain current calculation"
        extends Modelica.Icons.Function;
          input SI.Voltage vds;
          input SI.Voltage vgs;
          input SI.Voltage vgd;

          input Modelica.Electrical.Spice3.Internal.Fet.Fet in_f;
          input JfetModelLine in_fm;

          output Modelica.Electrical.Spice3.Internal.Fet.Fet out_f;

      protected
          SI.Voltage vto;
          SI.Voltage vgst;
          Real betap;
        //  SI.InversePotential Bfac;
          Real Bfac;
          Real apart;
          Real cpart;
          SI.Voltage vgdt;

        algorithm
          out_f := in_f;

          // Modification for Sydney University JFET model
          vto := in_fm.m_threshold;

          if (vds >= 0) then
            vgst := vgs - vto;
            // compute drain current and derivatives for normal mode
            if (vgst <= 0) then
              // normal mode, cutoff region
              out_f.m_cdrain := 0;
              out_f.m_gm     := 0;
              out_f.m_gds    := 0;
            else
              betap := in_fm.m_beta*(1 + in_fm.m_lModulation*vds);
              Bfac  := in_fm.m_bFac;
              if (vgst >= vds) then
                // normal mode, linear region
                apart          := 2*in_fm.m_b + 3*Bfac*(vgst - vds);
                cpart          := vds*(vds*(Bfac*vds - in_fm.m_b)+vgst*apart);
                out_f.m_cdrain := betap*cpart;
                out_f.m_gm     := betap*vds*(apart + 3*Bfac*vgst);
                out_f.m_gds    := betap*(vgst - vds)*apart + in_fm.m_beta*in_fm.m_lModulation*cpart;
              else
                Bfac       := vgst*Bfac;
                out_f.m_gm := betap*vgst*(2*in_fm.m_b+3*Bfac);
                // normal mode, saturation region
                cpart          := vgst*vgst*(in_fm.m_b+Bfac);
                out_f.m_cdrain := betap*cpart;
                out_f.m_gds    := in_fm.m_lModulation*in_fm.m_beta*cpart;
              end if;
            end if;
          else
            vgdt := vgd - vto;
            // compute drain current and derivatives for inverse mode
            if (vgdt <= 0) then
              // inverse mode, cutoff region
              out_f.m_cdrain := 0;
              out_f.m_gm     := 0;
              out_f.m_gds    := 0;
            else
              betap := in_fm.m_beta*(1 - in_fm.m_lModulation*vds);
              Bfac  := in_fm.m_bFac;
              if (vgdt + vds >= 0) then
                // inverse mode, linear region
                apart := 2*in_fm.m_b + 3*Bfac*(vgdt + vds);
                cpart := vds*(-vds*(-Bfac*vds-in_fm.m_b)+vgdt*apart);
                out_f.m_cdrain := betap*cpart;
                out_f.m_gm     := betap*vds*(apart + 3*Bfac*vgdt);
                out_f.m_gds    := betap*(vgdt + vds)*apart - in_fm.m_beta*in_fm.m_lModulation*cpart - out_f.m_gm;
              else
                Bfac :=vgdt*Bfac;
                out_f.m_gm     := -betap*vgdt*(2*in_fm.m_b+3*Bfac);
                // inverse mode, saturation region
                cpart          := vgdt*vgdt*(in_fm.m_b+Bfac);
                out_f.m_cdrain := - betap*cpart;
                out_f.m_gds    := in_fm.m_lModulation*in_fm.m_beta*cpart - out_f.m_gm;
              end if;
            end if;
          end if;

        end drainCur;

        function calculateGateCap "Gate capacitance calculation"
        extends Modelica.Icons.Function;
          input Modelica.Electrical.Spice3.Internal.Fet.Fet in_f;
          input SI.Voltage vgs "Input voltage gate source";
          input SI.Voltage vgd "Input voltage gate drain";

          output SI.Capacitance capgs "Output capacitance gate source";
          output SI.Charge chargegs "Output charge gate source";
          output SI.Capacitance capgd "Output capacitance gate drain";
          output SI.Charge chargegd "Output charge gate drain";

        algorithm
          (capgs,chargegs) := Modelica.Electrical.Spice3.Internal.Functions.junctionCap(
                  in_f.m_tCGS,
                  vgs,
                  in_f.m_corDepCap,
                  0.5,
                  in_f.m_tGatePot,
                  in_f.m_f1,
                  in_f.m_f2,
                  in_f.m_f3);
          (capgd,chargegd) := Modelica.Electrical.Spice3.Internal.Functions.junctionCap(
                  in_f.m_tCGD,
                  vgd,
                  in_f.m_corDepCap,
                  0.5,
                  in_f.m_tGatePot,
                  in_f.m_f1,
                  in_f.m_f2,
                  in_f.m_f3);

        end calculateGateCap;

        function jfetCalcTempDependencies
        "Precalculations relating to temperature"
        extends Modelica.Icons.Function;
          input Modelica.Electrical.Spice3.Internal.Fet.Fet in_f;
          input JfetModelLine in_fm;

          output Modelica.Electrical.Spice3.Internal.Fet.Fet out_f;

        algorithm
          out_f := in_f;

          (out_f.m_tGatePot,out_f.m_tCGS) :=
            Modelica.Electrical.Spice3.Internal.Functions.junctionParamDepTempSPICE3(
                  in_fm.m_gatePotential,
                  in_fm.m_capGS,
                  0.5,
                  out_f.m_dTemp,
                  in_fm.m_tnom);
          out_f.m_tCGS := out_f.m_area * out_f.m_tCGS;
          (out_f.m_tGatePot,out_f.m_tCGD) :=
            Modelica.Electrical.Spice3.Internal.Functions.junctionParamDepTempSPICE3(
                  in_fm.m_gatePotential,
                  in_fm.m_capGD,
                  0.5,
                  out_f.m_dTemp,
                  in_fm.m_tnom);
          out_f.m_tCGD := out_f.m_area * out_f.m_tCGD;
          (out_f.m_f1,out_f.m_f2,out_f.m_f3) :=
            Modelica.Electrical.Spice3.Internal.Functions.junctionCapCoeffs(
                  0.5,
                  in_fm.m_depletionCapCoeff,
                  out_f.m_tGatePot);

          out_f.m_tSatCur :=
            Modelica.Electrical.Spice3.Internal.Functions.saturationCurDepTempSPICE3JFET(
                  in_fm.m_gateSatCurrent,
                  out_f.m_dTemp,
                  in_fm.m_tnom);
          out_f.m_vcrit := Modelica.Electrical.Spice3.Internal.Functions.junctionVCrit(
                  out_f.m_dTemp,
                  1.0,
                  out_f.m_tSatCur);
          out_f.m_dVt := out_f.m_dTemp*Modelica.Electrical.Spice3.Internal.SpiceConstants.CONSTKoverQ;
          out_f.m_corDepCap := in_fm.m_depletionCapCoeff * out_f.m_tGatePot;

        end jfetCalcTempDependencies;

        function jfetNoBypassCode "Calculations of currents and capacities"
        extends Modelica.Icons.Function;
          input Modelica.Electrical.Spice3.Internal.Fet.Fet in_f
          "Input record fet parameters";
          input JfetModelLine in_fm "Input record model line parameters";
          input Integer in_m_type "Type of MOS transistor";
          input Boolean in_m_bInit;
          input SI.Voltage[3] in_m_pVoltageValues; // gate drain source

          output Modelica.Electrical.Spice3.Internal.Fet.CurrrentsCapacitances out_cc
          "Calculated currents and capacitances";

      protected
          Modelica.Electrical.Spice3.Internal.Fet.Fet int_f "Record Fet";

        algorithm
          int_f := in_f;

          int_f.m_vgd := in_m_type * (in_m_pVoltageValues[1] - in_m_pVoltageValues[2]); // ( G,  DP);
          int_f.m_vgs := in_m_type * (in_m_pVoltageValues[1] - in_m_pVoltageValues[3]); // ( G,  SP);

          if (in_f.m_uic and int_f.m_bICVGSIsGiven > 0.5) then
            int_f.m_vgs := in_m_type * int_f.m_dICVGS;
          elseif (Modelica.Electrical.Spice3.Internal.SpiceRoot.initJunctionVoltages()) then
            if (int_f.m_off == true) then
              int_f.m_vgs := 0;
            else
              int_f.m_vgs := int_f.m_vcrit;
            end if;
          end if;
          if (in_f.m_uic and int_f.m_bICVDSIsGiven > 0.5) then
            int_f.m_vgd := in_m_type * int_f.m_dICVDS + int_f.m_vgs;
          elseif (Modelica.Electrical.Spice3.Internal.SpiceRoot.initJunctionVoltages()) then
            if (int_f.m_off == true) then
              int_f.m_vgd := 0;
            else
              int_f.m_vgd := int_f.m_vcrit;
            end if;
          end if;

          int_f.m_vgs :=
            Modelica.Electrical.Spice3.Internal.SpiceRoot.limitJunctionVoltage(int_f.m_vgs);
          int_f.m_vgd :=
            Modelica.Electrical.Spice3.Internal.SpiceRoot.limitJunctionVoltage(int_f.m_vgd);
          int_f.m_vds := int_f.m_vgs - int_f.m_vgd;

          //////////////////////////////////////////////////////////////////////
          // junction currents
          (int_f.m_cgd,int_f.m_ggd) :=
            Modelica.Electrical.Spice3.Internal.Functions.junction2(
                  int_f.m_vgd,
                  int_f.m_dTemp,
                  1.0,
                  int_f.m_tSatCur);
          out_cc.iGD := in_m_type * int_f.m_cgd;
          (int_f.m_cgs,int_f.m_ggs) :=
            Modelica.Electrical.Spice3.Internal.Functions.junction2(
                  int_f.m_vgs,
                  int_f.m_dTemp,
                  1.0,
                  int_f.m_tSatCur);
          out_cc.iGS := in_m_type * int_f.m_cgs;

          //////////////////////////////////////////////////////////////////////
          // channel current calculation
          // Let the actual instance calculate the values
          int_f := drainCur(
                      int_f.m_vds,
                      int_f.m_vgs,
                      int_f.m_vgd,
                      int_f,
                      in_fm);
          out_cc.idrain := in_m_type * int_f.m_cdrain;

          //////////////////////////////////////////////////////////////////////
          // channel charge calculation
          if (not in_m_bInit) then
            (int_f.m_capgs,int_f.m_chargegs,int_f.m_capgd,int_f.m_chargegd)
              := calculateGateCap(
                        int_f,
                        int_f.m_vgs,
                        int_f.m_vgd);
            out_cc.cGD := if (in_m_bInit) then -1e40 else int_f.m_capgd;
            out_cc.cGS := if (in_m_bInit) then -1e40 else int_f.m_capgs;
          end if;

        end jfetNoBypassCode;

        function jfetRenameParameters "Parameter renaming to internal names"
        extends Modelica.Icons.Function;
          input Modelica.Electrical.Spice3.Internal.ModelcardJFET ex
          "Modelcard with technology parameters";

          output JfetModelLine intern "Output record model line parameters";

        algorithm
          intern.m_drainConduct := 0;
        intern.m_sourceConduct := 0;
        intern.m_bFac := 0;

          intern.m_capGS := if ( ex.CGS > -1e40) then ex.CGS else 0;
          // Zero-bias G-S junction capacitance, default 0
          intern.m_capGD := if ( ex.CGD > -1e40) then ex.CGD else 0;
          // Zero-bias G-D junction capacitance, default 0
          intern.m_gateSatCurrent := ex.IS;
          // Saturation current of pn junctions
          intern.m_depletionCapCoeff := ex.FC;
          // Coefficient for forward-bias depletion capacitance formula
          intern.m_drainResist := if ( ex.RD > -1e40) then ex.RD else 0;
          // Drain ohmic resistance, default 0
          intern.m_sourceResist := if ( ex.RS > -1e40) then ex.RS else 0;
          // Source ohmic resistance, default 0
          intern.m_tnom := ex.TNOM + Modelica.Electrical.Spice3.Internal.SpiceConstants.CONSTCtoK;
          // Parameter measurement temperature, default 27
          intern.m_threshold := if ( ex.VTO > -1e40) then ex.VTO else -2.0;
          // Zero-bias threshold voltage, default -2
          intern.m_b := if ( ex.B > -1e40) then ex.B else 1.0;
          // Dotierungsverlauf parameter, default 1
          intern.m_beta := if ( ex.BETA > -1e40) then ex.BETA else 1e-4;
          // Output admittance parameter, default 1e4
          intern.m_lModulation := ex.LAMBDA;
          // Channel-length modulation, default 0
          intern.m_gatePotential := ex.PB;
          // Junction potential of pn junctions
          intern.m_fNexp := ex.AF;
          // Flicker noise exponent
          intern.m_fNcoef := ex.KF;
          // Flicker noise coefficient

          annotation (Documentation(info="<html>
<p>This function jfetRenameParameters assigns the external (given by the user, e.g. RD) technology parameters
to the internal parameters (e.g. m_drainResistance). It also does the analysis of the IsGiven values.</p>
</html>"));
        end jfetRenameParameters;

      end Jfet;

      package Csemiconductor
          extends Modelica.Icons.InternalPackage;
        record Capacitor
          extends Modelica.Electrical.Spice3.Internal.Model.Model;

            SI.Capacitance m_dCapac(start=1e-9) "Device is a Capacitor model";
            Real m_dCapIsGiven "Capacitor is given value";
            SI.Length  m_dWidth(start=0) "Width";
            SI.Length  m_dLength(start=0) "Length";
            Boolean m_bSensCapac( start = false)
          "flag to request sensitivity WRT Capacitor";

        end Capacitor;

        record CapacitorModelLineParams
        "Record for Capacitor model line parameters"
          extends Modelica.Icons.Record;

            SI.CapacitancePerArea m_dCj "Junction bottom capacitance";
            SI.Permittivity m_dCjsw "Junction sidewall capacitance";
            SI.Length  m_dDefW "Default device width";
            SI.Length  m_dNarrow "Narrowing due to side etching";

        end CapacitorModelLineParams;

        function capacitorInitEquations
        extends Modelica.Icons.Function;
          input Capacitor in_p "Input record with capacitor parameters";
          input CapacitorModelLineParams in_p2
          "Input record with capacitor model line parameters";

          output Capacitor out "Output record with capacitor variables";

        algorithm
          out := in_p;

          if (in_p.m_dCapIsGiven < 0.5) then
            if (abs(in_p.m_dLength)>1e-18 and abs(in_p2.m_dCj)>1e-25) then
              out.m_dCapac := Modelica.Electrical.Spice3.Internal.Functions.capDepGeom(
                      in_p2.m_dCj,
                      in_p2.m_dCjsw,
                      out.m_dWidth,
                      in_p.m_dLength,
                      in_p2.m_dNarrow);
            end if;
          end if;

        end capacitorInitEquations;

        function capacitorRenameParameters
        extends Modelica.Icons.Function;
          input Modelica.Electrical.Spice3.Internal.ModelcardC ex
          "Modelcard with technology parameters";

          output CapacitorModelLineParams intern
          "Output record with capacitor model line parameters";

        algorithm
          intern.m_dCj := ex.CJ;
          intern.m_dCjsw := ex.CJSW;
          intern.m_dDefW := ex.DEFW;
          intern.m_dNarrow := ex.NARROW;

        end capacitorRenameParameters;

        function capacitorRenameParametersDev
        extends Modelica.Icons.Function;
          input SI.Capacitance C "Capacitance";
          input SI.Length  W "Width";
          input SI.Length  L "Length";
          input SI.Temp_C TEMP "Temperature";
          input Boolean SENS_AREA
          "Parameter for sensitivity analyses, not implemented yet";
          input CapacitorModelLineParams p;

          output Capacitor intern "Output record with capacitor parameters";

        algorithm
          intern.m_dCapIsGiven := if (C > -1e40) then 1 else 0;
          intern.m_dCapac := if (C > -1e40) then C else 1e-9;

          intern.m_dWidth := if (W > -1e40) then W else p.m_dDefW;

          intern.m_dLength := L;
          intern.m_bSensCapac := SENS_AREA;
          intern.m_dTemp := TEMP + Modelica.Electrical.Spice3.Internal.SpiceConstants.CONSTCtoK;

        end capacitorRenameParametersDev;

      end Csemiconductor;
    annotation (Documentation(info="<html>
<p>The package Internal contains functions and auxiliary models that are necessary for the Spice3 models. The package should not be used by the users of the Spice3-library.</p>
</html>"));
  end Internal;

    annotation (Documentation(info="<html>
<p>The Spice3 package contains models of the electronic simulator SPICE3. The models were translated into Modelica by rewriting the SPICE3 model code. </p>
</html>"), Icon(graphics={
          Line(points={{-20,40},{-20,-40}}),
          Line(points={{-90,0},{-20,0}}),
          Line(points={{0,0},{90,0}}),
          Line(points={{20,90},{20,40},{0,40},{0,-40},{20,-40},{20,-90}})}));
end Spice3;
