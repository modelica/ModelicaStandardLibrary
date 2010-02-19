within Modelica.Electrical;
package Spice3 "Library for components of the Berkeley SPICE3 simulator"
  import SI = Modelica.SIunits;

extends Modelica.Icons.Library2;

  package UsersGuide "Users Guide"

  class Overview "Overview"

    annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview of Spice3 library</font></h4></p>
<p><h4>Information</h4></p>
<p><br/>The Spice3 library is a Modelica library that contains some models of the Berkeley SPICE3 analog simulator. </p>
<p><br/><u>General information about the analog simulator SPICE3 </u></p>
<p>SPICE (Simulation Program with Integrated Circuit Emphasis) is a simulator for analog electrical circuits. It was developed as one of the first analog simulators in the university of Berkeley in 1970.</p>
<p>SPICE-netlists, which contain the circuit that shall be simulated, are one of &nbsp;the de-facto-standard up to now. For nearly every electrical circuit a SPICE-netlist exists. Today the actual version of SPICE is SPICE3e/SPICE3f.</p>
<p>SPICE contains basic elements (resistor, inductor, capacitor), sources and semiconductor devices (diode, bipolar transistors, junction field effect transistors, MOS-field effect transistors) as well as models of lines.</p>
<p>Out of this offered pool of elements, the circuits that shall be simulated are build in the form of SPICE-netlists. </p>
<p><br/><u>The Spice3-library for Modelica</u></p>
<p>The Spice3 library was extraced from orinial SPICE3 C++ code. To be sure the Modelica models are correct the simulation results were compared to SPICE3.</p>
<p>The Spice3-library was built in accordance to the model structure in SPICE. It contains the following packages:</p>
<p><ul>
<li>Examples</li>
<li>Basics (R, C, L, controlled sources) </li>
<li>Semiconductos (MOS (P, N), BJT(NPN PNP), Diode, semiconductor resistor)</li>
<li>Sources (constant, sinusodial, exponential, pulse, piece wise linear, single-frequency FM, respectively for V and I)</li>
<li>Additionals (useful features from PSPICE/SPICE2)</li>
<li>Interfaces</li>
<li>Repository (functions and data neede to model the semiconductor devices)<br/></li>
</ul></p>
<p>Since the semiconductor models, especially MOS and BJT, are very complex models, many functions, data and parameters were needed for their description. Therefore a special Package Repository was created that contains all thel functions and records with data and parameters that are needed for the semiconductor models. It is not necessary that a user of the library works inside this package,so is not for user access.The package Additionals is also a special one. It is not part of the original SPICE3 models. Nevertheless it contains useful models/features like the polynomial sources of SPICE2 that are often used.</p>
</html>", revisions="<html>
</html>"));
  end Overview;

  class useofsemiconductors "Use of Semiconductors"

    annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Use of Semiconductors</font></h4></p>
<p>Within the semiconductor devices SPICE3 differentiates between technology parameters and device parameters. Device parameters can be chosen for every single model instance, e.g. the channel length of a transistor. Technology parameters which are specified in a model card (.model) are adjustable for more than one element simultaneously, e.g. the type of transistors. As usualy done in Modelica the parameters of the modelcard can be set in a parameter list. </p>
<p>To parametrice more than one model two ways are possible:</p>
<p><ol>
<li>Apart record:<br/>For each transistor in the circuit a record with the technologieparameters is made avaliable as an instance of the record modelcardMOS. In the example<br/>&QUOT;inverter_apart_record&QUOT; this way is explained more in detail.</li>
<li>Extended model:<br/>For each set of technologyparameters a apart model has to be defined. In the example &QUOT;inverter_extended_model&QUOT; this way is explained more in detail.</li>
</ol></p>
</html>",
   revisions="<html>
</html>"));

  end useofsemiconductors;

  class Spicenetlist "SPICE3 netlists"

    annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Translation of SPICE3 netlists to Modelica </font></h4></p>
<p>Since SPICE3 netlists are avaliable for nearly every electrical circuit a desirable feature would be to translate SPICE3 netlists to Modelica. With the help of the example of an inverter circuits a possible way of the translation will be explained.</p>
<p>
<table cellspacing=\"0\" cellpadding=\"0\" border=\"1\"><tr>
<td valign=\"top\"><code><p>inverter</p>
<p><br/></p>
<p>Mp1 11 1 13 11 MPmos</p>
<p>Mp2 11 13 2 11 MPmos</p>
<p>Mn1 13 1 0 0 MNmos</p>
<p>Mn2 2 13 0 0 MNmos</p>
<p><br/><br/></p>
<p>Vgate 1 0 PULSE(0 5 2s 1s)</p>
<p>Vdrain 11 0 PULSE(0 5 0s 1s)</p>
<p><br/><br/></p>
<p>.model MPmos PMOS (gamma=0.37)</p>
<p>.model MNmos NMOS (gamma=0.37 lambda=0.02)</p>
<p><br/><br/></p>
<p>.tran 0.01 5</p>
<p><br/><br/></p>
<p>.end</p></code></td>
<td valign=\"top\"><code><p>model inverter </p>
<p>&nbsp; Spice3.Basic.Ground g;</p>
<p>&nbsp; Spice3&hellip;M Mp1(mtype=true, M(GAMMA=0.37));</p>
<p>&nbsp; Spice3&hellip;M Mp2(mtype=true, M(GAMMA=0.37));</p>
<p>&nbsp; Spice3&hellip;M Mn1(M(LAMBDA=0.02, GAMMA=0.37));</p>
<p>&nbsp; Spice3&hellip;M Mn2(p(LAMBDA=0.02, GAMMA=0.37)); </p>
<p>&nbsp; Spice3&hellip;V_pulse vdrain(V1=0, V2=5, TD=0, TR=1);</p>
<p>&nbsp; Spice3&hellip;V_pulse vdrain(V1=0, V2=5, TD=0, TR=1);</p>
<p>&nbsp; Spice3.Interfaces.Pin p_in, p_out;</p>
<p>protected </p>
<p>&nbsp; Spice3.Interfaces.Pin n0, n1, n2, n11, n13;</p>
<p>equation</p>
<p>&nbsp; connect(p_in, n1);&nbsp;&nbsp;&nbsp;connect(p_out, n2);</p>
<p>&nbsp; connect(g.p, n0);</p>
<p>&nbsp; connect(vdrain.n,n0);&nbsp;&nbsp;&nbsp;connect(vdrain.p,n11);</p>
<p>&nbsp; connect(Mp1.B,n11);&nbsp;&nbsp;&nbsp;connect(Mp1.D, n11);</p>
<p>&nbsp; connect(Mp1.G, n1);&nbsp;&nbsp;&nbsp;connect(Mp1.S, n13);</p>
<p>&nbsp; connect(Mp2.B,n11);&nbsp;&nbsp;&nbsp;connect(Mp2.D, n11);</p>
<p>&nbsp; connect(Mp2.G, n13);&nbsp;&nbsp;&nbsp;connect(Mp2.S, n2);</p>
<p>&nbsp; connect(Mn1.B,n0);&nbsp;&nbsp;&nbsp;connect(Mn1.D, n13); </p>
<p>&nbsp; connect(Mn1.G, n1);&nbsp;&nbsp;&nbsp;connect(Mn1.S, n0);</p>
<p>&nbsp; connect(Mn2.B,n0);&nbsp;&nbsp;&nbsp;connect(Mn2.D, n2);</p>
<p>&nbsp; connect(Mn2.G, n13);&nbsp;&nbsp;&nbsp;connect(Mn2.S, n0);</p>
<p>end inverter;</p>
</code></td>
</tr>
</table>
<caption>Table1: Translation of the SPICE3 netlist (left side) to Modelica (right side)</caption>
</p>
<p>Given is a SPICE3 netlist that contains two nverter circuits. This netlist should be translated to Modelica in which the input voltage of the first inverter (node number 1) and the</p>
<p>output voltage of the second (node number 2)later will be connected with the surrounding circuit. The following steps are necessary:</p>
<p><ol>
<li>A name for the Modelica model has to be chosen. It could be taken from the first line of the SPICE3 netlist.</li>
<li>The ground node has to be instantiated (Spice3.Basic.Ground).</li>
<li>For each component of the netlist an instant has to be created. According to the first letter of the SPICE3 model identifier in the netlist, the needed component has to be chosen, instantiated and according to the given parameters parametrized, e.g. the SPICE line<br/><br/>Vdrain 11 0 PULSE(0 5 0 1)<br/><br/>becomes the following Modelica line:<br/><br/>Spice3&hellip;V_pulse vdrain(V1=0, V2=5, TD=0, TR=1); <br/></li>
<li>For all node numbers an internal pin has to be created. For example the node number 2 from the SPICE3 netlist becomes<br/><br/>protected Spice3.Interfaces.Pin n2;<br/><br/>in Modelica. The code letter (here n) is needed because a single number is no name in Modelica.<br/></li>
<li>According to the netlist the internal pins have to be connected with the components, e.g. connect(Mp1.D, n11).</li>
<li>In the last step the external pins have to be allocated ant connected to the according internal pin. In table 1 this is done as follows: <br/><br/>Spice3.Interfaces.Pin p_in, p_out;<br/><br/>connect(p_in, n1); connect(p_out, n2); </li>
</ol></p>
</html>", revisions="<html>
</html>"));
  end Spicenetlist;

  class Literature "Literature"

    annotation (Documentation(info="<html>
<p>The following books and articles have been useful for the implementation of the Spice3 library. </p>
<p><h4>Books</h4></p>
<dl><dt><a name=\"ref_\">A</a>ntognetti, P.; Massobrio, G.(1988): </dt>
<dl><dt><blockquote><b> Semiconductor Device Modeling with SPICE. </b>McGraw-Hill Book Company, USA</blockquote></dt>
<dl><dt>Connelly, A.; Choi, P.(1992):</dt>
<dl><dt><blockquote><b>Macromodeling with SPICE.</b> Prentice-Hall, New Jersey, USA</blockquote></dt>
<dl><dt>Johnson, B.; Quarles, T.; Newton, A. R.; Pederson, D. O.; Sangiovanni-Vincentelli, A. (1991):</dt>
<dl><dt><blockquote><b>SPICE3 Version 3e User's Manual. </b>University of Berkeley, Department of Electrical Engineering and Computer Sciences, USA</blockquote></dt>
<blockquote><a href=\"http://bear.cwru.edu/eecs_cad/man_spice3.pdf\">SPICE3 users manual</a> </blockquote>
<dl><dt>Kielkowski, R.(1994):</dt>
<dl><dt><blockquote><b>Inside SPICE - Overcoming the obstacles of circuit simulation.</b> McGraw-Hill, USA</blockquote></dt>
<p><h4>Articles</h4></p>
<dl><dt>B&ouml;hme, S.; Majetta, K.; Clauss, C.; Schneider, P.(2009): </dt>
<dl><dt><blockquote><b>Spice3 Modelica Library.</b> Modelica Conference, Como, Italy</blockquote> </dt>
</dl></html>",
          revisions="<html>
</html>"));
  end Literature;

  class ReleaseNotes "Release notes"

    annotation (Documentation(info="<html>
<p>This section summarizes the changes that have been performed on the Spice3 library. </p>
<p><ul>
<li>Version 1.0 (2010-02-18): first version of the library was released</li>
</ul></p>
<p> </p>
</html>",
   revisions="<html>
</html>"));

  end ReleaseNotes;

  class Contact "Contact information"

    annotation (Documentation(info="<html>
<dl><dt><b>Main Authors:</b> </dt>
<dd>Kristin Majetta</dd>
<dd>Fraunhofer Institute Integrated Circuits</dd>
<dd>Design Automation Division</dd>
<dd>Zeunerstrasse 38</dd>
<dd>01069 Dresden, Germany</dd>
<dd>email: <a href=\"mailto:Kristin.Majetta@eas.iis.fraunhofer.de\">Kristin Majetta@eas.iis.fraunhofer.de</a><br/><br/></dd>
<dd>Christoph Clauss</dd>
<dd>Fraunhofer Institute Integrated Circuits</dd>
<dd>Design Automation Division</dd>
<dd>Zeunerstrasse 38</dd>
<dd>01069 Dresden, Germany</dd>
<dd>email: <a href=\"mailto:Christoph.Clauss@eas.iis.fraunhofer.de\">Christoph.Clauss@eas.iis.fraunhofer.de</a><br/><br/></dd>
<dd>Sandra Boehme</dd>
<dd>Fraunhofer Institute Integrated Circuits</dd>
<dd>Design Automation Division</dd>
<dd>Zeunerstrasse 38</dd>
<dd>01069 Dresden, Germany</dd>
<dd>email: <a href=\"mailto:Sandra.Boehme@eas.iis.fraunhofer.de\">Sandra.Boehme@eas.iis.fraunhofer.de</a><br/><br/></dd>
</dl><p><h4>Acknowledgements:</h4></p>
<p><ul>
<li>The development of this library was done within the European ITEA2 projects EUROSYSLIB and MODELISAR. </li>
<li>For his contribution we thank Mr. Jonathan Gerbet.</li>
</ul></p>
</html>", revisions="<html>
</html>"));
  end Contact;

  annotation (DocumentationClass=true, Documentation(info="<html>
<p>Package Spice3 is a <b>free</b> Modelica package </p>
<p>This is a short <b>User&apos;s Guide</b> for the overall library. </p>
</html>",   revisions="<html>
<p><ul>
<li><i>Feb 2010 </i>by Kristin Majetta initially written</li>
</ul></p>
</html>"),  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics),
      uses(Modelica(version="3.1")));
  end UsersGuide;

  package Examples "Example circuits"
  extends Modelica.Icons.Library2;

    model Inverter "Simple inverter circuit"
    //--------------------------------------------------------------------------------------------------------------

    //--------------------------------------------------------------------------------------------------------------

      Spice3.Semiconductors.M_PMOS MP(modelcard(
          RD=0,
          RS=0,
          CBD=0,
          CBS=0))
        annotation (Placement(transformation(extent={{-14,8},{6,28}})));
      Spice3.Semiconductors.M_NMOS MN(modelcard(
          RD=0,
          RS=0,
          CBD=0,
          CBS=0))
        annotation (Placement(transformation(extent={{-14,-34},{6,-14}})));
      Spice3.Basic.Ground ground
        annotation (Placement(transformation(extent={{-14,-60},{6,-40}})));
      Spice3.Sources.V_pulse vin(
        V2=5,
        TD=4e-12,
        TR=0.1e-12,
        TF=0.1e-12,
        PW=1e-12,
        PER=2e-12) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-40,-16})));
      Spice3.Sources.V_pulse v(V2=5, TR=0.1e-12)        annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={40,-4})));
    equation
      connect(MN.D, MP.S)    annotation (Line(
          points={{-4,-14},{-4,8}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(MP.G, MN.G)    annotation (Line(
          points={{-14,17.9},{-14,-24.1}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(MN.S, MN.B)     annotation (Line(
          points={{-4,-34},{6,-34},{6,-24}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(MP.B, MP.D)   annotation (Line(
          points={{6,18},{6,28},{-4,28}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(MN.S, ground.p)   annotation (Line(
          points={{-4,-34},{-4,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(v.p, MP.D)         annotation (Line(
          points={{40,6},{40,28},{-4,28}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(v.n, ground.p)        annotation (Line(
          points={{40,-14},{40,-40},{-4,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(vin.p, MP.G)      annotation (Line(
          points={{-40,-6},{-40,17.9},{-14,17.9}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(vin.n, ground.p)     annotation (Line(
          points={{-40,-26},{-40,-40},{-4,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation ( Diagram(
            coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
                100,100}}), graphics),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-100,-102},{80,48}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Polygon(
              points={{-100,48},{-80,68},{100,68},{80,48},{-100,48}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Polygon(
              points={{100,68},{100,-82},{80,-102},{80,48},{100,68}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Text(
              extent={{-96,1},{77,-51}},
              lineColor={0,0,255},
              textString="1"),
            Text(
              extent={{-120,130},{120,71}},
              lineColor={255,0,0},
              textString="%name")}),
        experiment(
          StopTime=1e-011,
          NumberOfIntervals=2000,
          Tolerance=1e-007),
        experimentSetupOutput,
        Documentation(info="<html>
<p>An inverter is an electrical circuit that consists of a PMOS and a NMOS transistor. Its task is to turn the input voltage from high potential to low potential or the other way round. </p>
<p>Simulate until 1.e-11 s. Display the input voltage Vin.p.v as well as the output voltage MP.S.v. It shows that the input voltage is inverted.</p>
</html>", revisions="<html>
<p><ul>
<li><i>March 2009 </i>by Kristin Majetta initially implemented</li>
</ul></p>
</html>"));
    end Inverter;

    model Inverters_apart_record
      "Two inverters where transistor models use different modelcard instances"

      Spice3.Basic.Ground ground annotation (Placement(transformation(extent={{-38,-80},
                {-18,-60}},        rotation=0)));
    //--------------------------------------------------------------------------------------------------------------
    /*apart record: For each transistor in the circuit a record with the technologieparameters is made avaliable
  as an instance of the record modelcardMOS */
      parameter Spice3.Semiconductors.modelcardMOS MPmos(GAMMA=0.37)
        "specified modelcardMOS for MPmos"; //instance of record modelcardMOS
      parameter Spice3.Semiconductors.modelcardMOS MNmos(GAMMA=0.37, LAMBDA=
            0.02) "specified modelcardMOS for MNmos";
                                             //instance of record modelcardMOS
      Spice3.Semiconductors.M_PMOS mp1(modelcard=MPmos)
                annotation (Placement(transformation(extent={{-38,20},{-18,40}},
              rotation=0)));
      Spice3.Semiconductors.M_NMOS mn1(modelcard=MNmos)
                annotation (Placement(transformation(extent={{-38,-30},{-18,-10}},
              rotation=0)));
      Spice3.Semiconductors.M_PMOS mp2(modelcard=MPmos)
                annotation (Placement(transformation(extent={{2,20},{22,40}},
              rotation=0)));
      Spice3.Semiconductors.M_NMOS mn2(modelcard=MNmos)
                annotation (Placement(transformation(extent={{2,-30},{22,-10}},
              rotation=0)));
    //--------------------------------------------------------------------------------------------------------------

      Spice3.Basic.C_Capacitor c1(C=1e-5)
        annotation (Placement(transformation(
            origin={-8,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Spice3.Basic.C_Capacitor c2(C=1e-5)
        annotation (Placement(transformation(
            origin={34,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));

      Spice3.Sources.V_pulse vin(
        V2=5,
        TD=2,
        TR=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-60,-32})));
      Spice3.Sources.V_pulse v(V2=5, TR=1)       annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={60,-32})));
    equation
      connect(mp1.B, mp1.D) annotation (Line(points={{-18,30},{-18,40},{-28,
              40}},
            color={0,0,255}));
      connect(mn1.S, ground.p)
        annotation (Line(points={{-28,-30},{-28,-60}}, color={0,0,255}));
      connect(mp1.S, mn1.D)
        annotation (Line(points={{-28,20},{-28,-10}}, color={0,0,255}));
      connect(mn1.G, mp1.G) annotation (Line(points={{-38,-20.1},{-38,29.9}},
            color={0,0,255}));
      connect(mn1.B, mn1.S) annotation (Line(points={{-18,-20},{-18,-30},{-28,
              -30}},
            color={0,0,255}));
      connect(mp2.B, mp2.D) annotation (Line(points={{22,30},{22,40},{12,40}},
            color={0,0,255}));
      connect(mn2.S, ground.p) annotation (Line(points={{12,-30},{12,-60},{-28,
              -60}}, color={0,0,255}));
      connect(mp2.S, mn2.D)
        annotation (Line(points={{12,20},{12,-10}}, color={0,0,255}));
      connect(mn2.G, mp2.G) annotation (Line(points={{2,-20.1},{2,29.9}},
            color={0,0,255}));
      connect(mn2.B, mn2.S) annotation (Line(points={{22,-20},{22,-30},{12,
              -30}}, color={0,0,255}));
      connect(mp2.G, mn1.D) annotation (Line(points={{2,29.9},{2,0},{-28,0},{
              -28,-10}},  color={0,0,255}));
      connect(c1.p, mn1.D) annotation (Line(points={{-8,-20},{-8,0},{-28,0},{
              -28,-10}}, color={0,0,255}));
      connect(mn2.D, c2.p) annotation (Line(points={{12,-10},{12,0},{34,0},{34,
              -20}}, color={0,0,255}));
      connect(c2.n, ground.p) annotation (Line(points={{34,-40},{34,-60},{-28,
              -60}}, color={0,0,255}));
      connect(c1.n, ground.p) annotation (Line(points={{-8,-40},{-8,-60},{-28,
              -60}}, color={0,0,255}));
      connect(mp1.G, vin.p)    annotation (Line(
          points={{-38,29.9},{-60,29.9},{-60,-22}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(vin.n, ground.p)    annotation (Line(
          points={{-60,-42},{-60,-60},{-28,-60}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(v.p, mp2.D)       annotation (Line(
          points={{60,-22},{60,40},{12,40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(mp1.D, mp2.D) annotation (Line(
          points={{-28,40},{12,40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(v.n, ground.p)       annotation (Line(
          points={{60,-42},{60,-60},{-28,-60}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation ( Diagram(
            coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
                100,100}}), graphics),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-100,-100},{80,50}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Polygon(
              points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Polygon(
              points={{100,70},{100,-80},{80,-100},{80,50},{100,70}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Text(
              extent={{-96,3},{77,-49}},
              lineColor={0,0,255},
              textString="2"),
            Text(
              extent={{-120,132},{120,73}},
              lineColor={255,0,0},
              textString="%name")}),
        experiment(StopTime=5),
        experimentSetupOutput,
        Documentation(info="<html>
<p>An inverter is an electrical circuit that consists of a PMOS and a NMOS. Its task is to turn the input voltage from high potential to low potential or the other way round. This circuit<i> inverter_extended_model</i> contains two inverters. The input voltage of the first inverter is nearly equal to the output voltage of the second inverter. Capacities cause some differences. </p>
<p>To see the typical behavior of the circuit the input voltages and the output voltages should be plotted. Besides that it can be interesting to watch the outputvoltage of the first inverter. Simulated until t=5s. </p>
<p>Input voltages: vin.p.v and v.p.v</p>
<p>Output voltage of the first inverter: mn1.ND.v </p>
<p>Output voltage of the second Inverter: mn2.ND.v </p>
<p>This example shows one posibility to make the record of the technology parameters avaliable for more than one transistor. For each transistor in the circuit a record with the technology parameters is made avaliable as an instance of the record modelcardMOS. In this circuit we need two different records for technology parameters, one for PMOS (MPmos) and one for NMOS (MNmos). This instances of the record for the technology parameters were made avaliable for every transistor as one of theirs parameters (Spice3.Repository.MOS mn1(mtype=0, modelcard=MNmos).</p>
</html>", revisions="<html>
<p><ul>
<li><i>April 2009 </i>by Kristin Majetta initially implemented</li>
</ul></p>
</html>"));
    end Inverters_apart_record;

    model Inverters_extended_model
      "Two inverters with MOS models defined by inheritance"

      Spice3.Basic.Ground ground annotation (Placement(transformation(extent={{-40,-80},
                {-20,-60}},        rotation=0)));
    //--------------------------------------------------------------------------------------------------------------
    /*extended model: For each set of technology parameters an apart model has to be defined. Every transistor extends
  this model. In this process the required technology parameters are specified. */

      model MPmos "PMOS transistor with specified modelcard"
        Spice3.Semiconductors.modelcardMOS M(GAMMA=0.37);
        extends Spice3.Semiconductors.M_PMOS(modelcard=M);
      end MPmos;

      model MNmos "NMOS transistor with specified modelcard"
        Spice3.Semiconductors.modelcardMOS M(GAMMA=0.37, LAMBDA=0.02);
        extends Spice3.Semiconductors.M_NMOS(modelcard=M);
      end MNmos;

      MPmos mp1 annotation (Placement(transformation(extent={{-40,20},{-20,40}},
              rotation=0)));
      MNmos mn1 annotation (Placement(transformation(extent={{-40,-30},{-20,-10}},
              rotation=0)));
      MPmos mp2 annotation (Placement(transformation(extent={{0,20},{20,40}},
              rotation=0)));
      MNmos mn2 annotation (Placement(transformation(extent={{0,-30},{20,-10}},
              rotation=0)));
    //--------------------------------------------------------------------------------------------------------------

      Spice3.Basic.C_Capacitor c1(C=1e-5)
        annotation (Placement(transformation(
            origin={-10,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Spice3.Basic.C_Capacitor c2(C=1e-5)
        annotation (Placement(transformation(
            origin={32,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));

      Spice3.Sources.V_pulse vin(
        V2=5,
        TD=2,
        TR=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-60,-22})));
      Spice3.Sources.V_pulse v(V2=5, TR=1)       annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={56,-22})));
    equation
      connect(mp1.B, mp1.D) annotation (Line(points={{-20,30},{-20,40},{-30,40}},
            color={0,0,255}));
      connect(mn1.S, ground.p)
        annotation (Line(points={{-30,-30},{-30,-60}}, color={0,0,255}));
      connect(mp1.S, mn1.D)
        annotation (Line(points={{-30,20},{-30,-10}}, color={0,0,255}));
      connect(mn1.G, mp1.G) annotation (Line(points={{-40,-20.1},{-40,29.9}},
            color={0,0,255}));
      connect(mn1.B, mn1.S) annotation (Line(points={{-20,-20},{-20,-30},{-30,-30}},
            color={0,0,255}));
      connect(mp2.B, mp2.D) annotation (Line(points={{20,30},{20,40},{10,40}},
            color={0,0,255}));
      connect(mn2.S, ground.p) annotation (Line(points={{10,-30},{10,-60},{-30,-60}},
                     color={0,0,255}));
      connect(mp2.S, mn2.D)
        annotation (Line(points={{10,20},{10,-10}}, color={0,0,255}));
      connect(mn2.G, mp2.G) annotation (Line(points={{0,-20.1},{0,29.9}},
            color={0,0,255}));
      connect(mn2.B, mn2.S) annotation (Line(points={{20,-20},{20,-30},{10,-30}},
                     color={0,0,255}));
      connect(mp2.G, mn1.D) annotation (Line(points={{0,29.9},{0,0},{-30,0},{-30,-10}},
                          color={0,0,255}));
      connect(c1.p, mn1.D) annotation (Line(points={{-10,-20},{-10,0},{-30,0},{
              -30,-10}}, color={0,0,255}));
      connect(mn2.D, c2.p) annotation (Line(points={{10,-10},{10,0},{32,0},{32,-20}},
                     color={0,0,255}));
      connect(c2.n, ground.p) annotation (Line(points={{32,-40},{32,-60},{-30,
              -60}}, color={0,0,255}));
      connect(c1.n, ground.p) annotation (Line(points={{-10,-40},{-10,-60},{-30,
              -60}}, color={0,0,255}));
      connect(vin.p, mp1.G)    annotation (Line(
          points={{-60,-12},{-60,26},{-40,26},{-40,29.9}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(vin.n, ground.p)    annotation (Line(
          points={{-60,-32},{-60,-60},{-30,-60}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(v.p, mp2.D)       annotation (Line(
          points={{56,-12},{56,40},{10,40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(mp2.D, mp1.D) annotation (Line(
          points={{10,40},{-30,40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(v.n, ground.p)       annotation (Line(
          points={{56,-32},{56,-60},{-30,-60}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation ( Diagram(
            coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
                100,100}}), graphics),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-100,-100},{80,50}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Polygon(
              points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Polygon(
              points={{100,70},{100,-80},{80,-100},{80,50},{100,70}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Text(
              extent={{-96,3},{77,-49}},
              lineColor={0,0,255},
              textString="3"),
            Text(
              extent={{-120,132},{120,73}},
              lineColor={255,0,0},
              textString="%name")}),
        experiment(StopTime=5),
        experimentSetupOutput,
        DymolaStoredErrors,
        Documentation(info="<html>
<p>An inverter is an electrical circuit that consists of a PMOS and a NMOS. Its task is to turn the input voltage from high potential to low potential or the other way round. This circuit<i> inverter_extended_model</i> contains two inverters. The input voltage of the first inverter is nearly equal to the output voltage of the second inverter. Capacities cause some differences. </p>
<p>To see the typical behavior of the circuit the input voltages and the output voltages should be plotted. Besides that it can be interesting to watch the outputvoltage of the first inverter. Simulated until t=5s. </p>
<p>Input voltages: vin.p.v and v.p.v</p>
<p>Output voltage of the first inverter: mn1.ND.v </p>
<p>Output voltage of the second Inverter: mn2.ND.v </p>
<p>This example shows one posibility to make the record of the technology parameters avaliable for more than one transistor. For each set of technology parameters an apart model has to be defined (in this example: MPmos ans MNmos). Inside the model definition the technology parameters are appointed (Spice3.Semiconductors.modelcardMOS M(GAMMA=0.37, LAMBDA=0.02)). Every model extends a transistor. In this process the required technologieparameters are specified (extends Spice3.Repository.MOS(final mtype=1, modelcard=M). To make transistors available in the circuit instances of the defined models are applied (MPmos mp1; MNmos mn1; MPmos mp2; MNmos mn2;). </p>
</html>", revisions="<html>
<p><ul>
<li><i>April 2009 </i>by Kristin Majetta initially implemented</li>
</ul></p>
</html>"));
    end Inverters_extended_model;

    model FourInverters
      "Four inverters with MOSFET level 1, using private record as model card"

      Spice3.Basic.Ground ground annotation (Placement(transformation(extent={{-74,-80},
                {-54,-60}},        rotation=0)));

      parameter Spice3.Semiconductors.modelcardMOS modp
        "private PMOS modelcard";
      parameter Spice3.Semiconductors.modelcardMOS modn
        "provate NMOS modelcard";

      Spice3.Semiconductors.M_PMOS mp1(modelcard=modp)
                annotation (Placement(transformation(extent={{-74,20},{-54,40}},
              rotation=0)));
      Spice3.Semiconductors.M_NMOS mn1(modelcard=modn)
                annotation (Placement(transformation(extent={{-74,-30},{-54,-10}},
              rotation=0)));
      Spice3.Semiconductors.M_PMOS mp2(modelcard=modp)
                annotation (Placement(transformation(extent={{-34,20},{-14,40}},
              rotation=0)));
      Spice3.Semiconductors.M_NMOS mn2(modelcard=modn)
                annotation (Placement(transformation(extent={{-34,-30},{-14,-10}},
              rotation=0)));
      Spice3.Semiconductors.M_PMOS mp3(modelcard=modp)
                annotation (Placement(transformation(extent={{6,20},{26,40}},
              rotation=0)));
      Spice3.Semiconductors.M_PMOS mp4(modelcard=modn)
                annotation (Placement(transformation(extent={{46,20},{66,40}},
              rotation=0)));
      Spice3.Semiconductors.M_NMOS mn3(modelcard=modp)
                annotation (Placement(transformation(extent={{6,-30},{26,-10}},
              rotation=0)));
      Spice3.Semiconductors.M_NMOS mn4(modelcard=modn)
                annotation (Placement(transformation(extent={{46,-30},{66,-10}},
              rotation=0)));
      Spice3.Basic.C_Capacitor c1(C=10e-6)
        annotation (Placement(transformation(
            origin={-44,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Spice3.Basic.C_Capacitor c2(C=10e-6)
        annotation (Placement(transformation(
            origin={-2,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Spice3.Basic.C_Capacitor c3(C=10e-6)
        annotation (Placement(transformation(
            origin={36,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Spice3.Basic.C_Capacitor c4(C=10e-6)
        annotation (Placement(transformation(
            origin={76,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Spice3.Sources.V_pulse vin(
        V2=5,
        TD=2,
        TR=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-86,-42})));
      Spice3.Sources.V_pulse v(V2=5, TR=1)                        annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={92,-48})));
    equation
      connect(mp1.B, mp1.D) annotation (Line(points={{-54,30},{-54,40},{-64,
              40}},
            color={0,0,255}));
      connect(mn1.S, ground.p)
        annotation (Line(points={{-64,-30},{-64,-60}}, color={0,0,255}));
      connect(mp1.S, mn1.D)
        annotation (Line(points={{-64,20},{-64,-10}}, color={0,0,255}));
      connect(mn1.G, mp1.G) annotation (Line(points={{-74,-20.1},{-74,29.9}},
            color={0,0,255}));
      connect(mn1.B, mn1.S) annotation (Line(points={{-54,-20},{-54,-30},{-64,
              -30}},
            color={0,0,255}));
      connect(mp2.B, mp2.D) annotation (Line(points={{-14,30},{-14,40},{-24,
              40}},
            color={0,0,255}));
      connect(mn2.S, ground.p) annotation (Line(points={{-24,-30},{-24,-60},{
              -64,-60}},
                     color={0,0,255}));
      connect(mp2.S, mn2.D)
        annotation (Line(points={{-24,20},{-24,-10}},
                                                    color={0,0,255}));
      connect(mn2.G, mp2.G) annotation (Line(points={{-34,-20.1},{-34,29.9}},
            color={0,0,255}));
      connect(mn2.B, mn2.S) annotation (Line(points={{-14,-20},{-14,-30},{-24,
              -30}}, color={0,0,255}));
      connect(c1.p, mn1.D) annotation (Line(points={{-44,-20},{-44,0},{-64,0},
              {-64,-10}},color={0,0,255}));
      connect(mn2.D, c2.p) annotation (Line(points={{-24,-10},{-24,0},{-2,0},{
              -2,-20}},
                     color={0,0,255}));
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
      connect(mp3.B, mp3.D) annotation (Line(points={{26,30},{26,40},{16,40}},
            color={0,0,255}));
      connect(mp4.B, mp4.D) annotation (Line(points={{66,30},{66,40},{56,40}},
                    color={0,0,255}));
      connect(mp3.S, mn3.D)
        annotation (Line(points={{16,20},{16,-10}}, color={0,0,255}));
      connect(mp4.S, mn4.D)
        annotation (Line(points={{56,20},{56,-10}},   color={0,0,255}));
      connect(mn3.S, ground.p) annotation (Line(points={{16,-30},{16,-60},{-64,
              -60}}, color={0,0,255}));
      connect(mn4.S, ground.p) annotation (Line(points={{56,-30},{56,-60},{-64,
              -60}},     color={0,0,255}));
      connect(c3.p, mn3.D) annotation (Line(points={{36,-20},{36,0},{16,0},{16,
              -10}}, color={0,0,255}));
      connect(c4.p, mn4.D) annotation (Line(points={{76,-20},{76,0},{56,0},{56,
              -10}},      color={0,0,255}));
      connect(c2.p, mn3.G) annotation (Line(points={{-2,-20},{2,-20},{2,-20.1},
              {6,-20.1}},         color={0,0,255}));
      connect(mn3.G, mp3.G) annotation (Line(points={{6,-20.1},{6,29.9}},
            color={0,0,255}));
      connect(c3.p, mn4.G) annotation (Line(points={{36,-20},{41,-20},{41,
              -20.1},{46,-20.1}},  color={0,0,255}));
      connect(mn4.G, mp4.G) annotation (Line(points={{46,-20.1},{46,29.9}},
            color={0,0,255}));
      connect(c1.p, mn2.G) annotation (Line(points={{-44,-20},{-39,-20},{-39,
              -20.1},{-34,-20.1}},color={0,0,255}));
      connect(vin.p, mn1.G)    annotation (Line(
          points={{-86,-32},{-86,0},{-74,0},{-74,-20.1}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(vin.n, ground.p)    annotation (Line(
          points={{-86,-52},{-86,-60},{-64,-60}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(v.p, mp4.D)       annotation (Line(
          points={{92,-38},{92,40},{56,40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(v.n, ground.p)       annotation (Line(
          points={{92,-58},{92,-60},{-64,-60}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(mp3.D, mp4.D) annotation (Line(
          points={{16,40},{56,40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(mp2.D, mp3.D) annotation (Line(
          points={{-24,40},{16,40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(mp1.D, mp2.D) annotation (Line(
          points={{-64,40},{-24,40}},
          color={0,0,255},
          smooth=Smooth.None));
      annotation (Diagram(
            coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            initialScale=0.1), graphics),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            initialScale=0.1), graphics={
            Rectangle(
              extent={{-100,-100},{80,50}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Polygon(
              points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Polygon(
              points={{100,70},{100,-80},{80,-100},{80,50},{100,70}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Text(
              extent={{-96,3},{77,-49}},
              lineColor={0,0,255},
              textString="4"),
            Text(
              extent={{-120,132},{120,73}},
              lineColor={255,0,0},
              textString="%name")}),
        experiment(StopTime=5),
        experimentSetupOutput,
        Documentation(info="<html>
<p>This circuit that contains four inverter was designed to show the functionality of the MOS transistor models. To see the behavior of the circuit the output voltages of each inverter should be displayed (mp1.NS.v, mp2.NS.v, mp3.NS.v, mp4.NS.v). The output voltages of the second an fourth inverter and the inputvoltage of the first inverter have the same potential. The output voltages of the first and third inverter have the opposite potential compared with inverter 2 and 4. </p>
<p>Simulate until t=5s. The outputvalues should be: mp1.NS.v, mp2.NS.v, mp3.NS.v, mp4.NS.v and vgate.p.v </p>
</html>", revisions="<html>
<p><ul>
<li><i>April 2009 </i>by Kristin Majetta initially implemented</li>
</ul></p>
</html>"));
    end FourInverters;

    model Nand "MOS Nand gate circuit"

      Spice3.Semiconductors.M_PMOS m_PMOS(
        L=2e-5,
        W=1e-5,
        modelcard(PHI=0.7))               annotation (Placement(transformation(
              extent={{-22,24},{-2,44}},  rotation=0)));
      Spice3.Semiconductors.M_PMOS m_PMOS1(modelcard(PHI=0.7))
                                           annotation (Placement(transformation(
              extent={{24,24},{44,44}},rotation=0)));
      Spice3.Semiconductors.M_NMOS m_NMOS annotation (Placement(transformation(
              extent={{-24,-44},{-4,-24}},rotation=0)));
      Spice3.Semiconductors.M_NMOS m_NMOS1 annotation (Placement(transformation(
              extent={{-24,-10},{-4,10}}, rotation=0)));
      Spice3.Sources.V_constant v_constant(V=5) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}},
                                                     rotation=270,
            origin={62,34})));
      Spice3.Basic.Ground ground annotation (Placement(transformation(extent={{20,-100},
                {40,-80}},         rotation=0)));
      Spice3.Sources.V_pulse vin1(
        TR=1e-9,
        TF=1e-9,
        V2=5,
        TD=2e-8,
        PW=4e-8,
        PER=8e-8)                    annotation (Placement(transformation(
            origin={-50,24},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Spice3.Sources.V_pulse vin2(
        V2=5,
        TR=1e-9,
        TF=1e-9,
        TD=1e-8,
        PW=4e-8,
        PER=8e-8)                     annotation (Placement(transformation(
            origin={-52,-44},
            extent={{-10,-10},{10,10}},
            rotation=270)));

    equation
      connect(m_PMOS.B, m_PMOS.D) annotation (Line(points={{-2,34},{-2,44},{
              -12,44}},  color={0,0,255}));
      connect(m_PMOS1.B, m_PMOS1.D) annotation (Line(points={{44,34},{44,44},
              {34,44}}, color={0,0,255}));
      connect(v_constant.p, m_PMOS1.D) annotation (Line(points={{62,44},{62,44},
              {34,44}}, color={0,0,255}));
      connect(m_PMOS1.D, m_PMOS.D)
        annotation (Line(points={{34,44},{-12,44}}, color={0,0,255}));
      connect(m_PMOS.G, m_NMOS1.G) annotation (Line(points={{-22,33.9},{-22,
              16},{-24,16},{-24,-0.1}},
                      color={0,0,255}));
      connect(m_PMOS.G, vin1.p)  annotation (Line(points={{-22,33.9},{-38,33.9},
              {-38,34},{-50,34}}, color={0,0,255}));
      connect(vin1.n, ground.p)  annotation (Line(points={{-50,14},{-62,14},{
              -62,-80},{30,-80}},color={0,0,255}));
      connect(m_PMOS1.G, m_NMOS.G) annotation (Line(points={{24,33.9},{24,14},
              {-32,14},{-32,-34.1},{-24,-34.1}},
                                              color={0,0,255}));
      connect(m_NMOS.G, vin2.p)  annotation (Line(points={{-24,-34.1},{-38,
              -34.1},{-38,-34},{-52,-34}},
                                  color={0,0,255}));
      connect(vin2.n, ground.p)  annotation (Line(points={{-52,-54},{-52,-80},{
              30,-80}},color={0,0,255}));
      connect(m_NMOS.S, ground.p) annotation (Line(points={{-14,-44},{-14,-80},
              {30,-80}},color={0,0,255}));
      connect(m_NMOS1.B, m_NMOS.B)
        annotation (Line(points={{-4,0},{-4,-34}},   color={0,0,255}));
      connect(m_NMOS.B, m_NMOS.S) annotation (Line(points={{-4,-34},{-4,-44},
              {-14,-44}}, color={0,0,255}));
      connect(m_NMOS1.S, m_NMOS.D)
        annotation (Line(points={{-14,-10},{-14,-24}},
                                                    color={0,0,255}));
      connect(m_PMOS.S, m_NMOS1.D)
        annotation (Line(points={{-12,24},{-12,18},{-14,18},{-14,10}},
                                                     color={0,0,255}));
      connect(m_PMOS1.S, m_NMOS1.D) annotation (Line(points={{34,24},{34,10},
              {-14,10}}, color={0,0,255}));
      connect(v_constant.n, ground.p) annotation (Line(points={{62,24},{62,-80},
              {30,-80}},color={0,0,255}));
      annotation (                           Diagram(coordinateSystem(
              preserveAspectRatio=true,  extent={{-100,-100},{100,100}}),
                                                     graphics),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-100,-100},{80,50}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Polygon(
              points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Polygon(
              points={{100,70},{100,-80},{80,-100},{80,50},{100,70}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Text(
              extent={{-96,3},{77,-49}},
              lineColor={0,0,255},
              textString="5"),
            Text(
              extent={{-120,132},{120,73}},
              lineColor={255,0,0},
              textString="%name")}),
        Documentation(info="<html>
<p>In nearly every electronic the basic circuit &QUOT;nand&QUOT; are used. A nand contains two PMOS and two NMOS. The faulty wiring can be seen in the graphical mode. If and only if the two input voltages have high potential, the output voltage has low potential, otherwise the output voltage has high potential. </p>
<p>Nand truth table (1 means true, it is represented by the 5V voltage): </p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"1\"><tr>
<td><p>input voltage vin1</p></td>
<td><p>input voltage vin2</p></td>
<td><p>output voltage m_NMOS1.NS</p></td>
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
<p><br/><br/><br/>Simulate until t=2e-7s. Display the two input voltages vin1.p.v and vin2.p.v and the output voltage m_NMOS1.ND.v, which becomes zero only if both input values are high. </p>
</html>", revisions="<html>
<p><ul>
<li><i>May 2009 </i>by Kristin Majetta initially implemented</li>
</ul></p>
</html>"),
        experiment(StopTime=2e-007),
        experimentSetupOutput);
    end Nand;

    model Nor "MOS NOR gate circuit"

      Spice3.Semiconductors.M_PMOS m_PMOS(modelcard(
          RD=1e-4,
          RS=1e-4,
          CBD=1e-5,
          CBS=1e-5,
          CGSO=1e-5,
          CGDO=1e-5,
          CGBO=1e-5))                     annotation (Placement(transformation(
              extent={{-16,24},{4,44}},   rotation=0)));
      Spice3.Semiconductors.M_PMOS m_PMOS1(modelcard(
          RD=1e-4,
          RS=1e-4,
          CBD=1e-5,
          CBS=1e-5,
          CGSO=1e-5,
          CGDO=1e-5,
          CGBO=1e-5))                      annotation (Placement(transformation(
              extent={{-16,-6},{4,14}},   rotation=0)));
      Spice3.Semiconductors.M_NMOS m_NMOS(modelcard(
          RD=1e-4,
          RS=1e-4,
          CBD=1e-5,
          CBS=1e-5,
          CGSO=1e-5,
          CGDO=1e-5,
          CGBO=1e-5))                     annotation (Placement(transformation(
              extent={{-16,-44},{4,-24}}, rotation=0)));
      Spice3.Semiconductors.M_NMOS m_NMOS1(modelcard(
          RD=1e-4,
          RS=1e-4,
          CBD=1e-5,
          CBS=1e-5,
          CGSO=1e-5,
          CGDO=1e-5,
          CGBO=1e-5))                      annotation (Placement(transformation(
              extent={{32,-44},{52,-24}},
                                       rotation=0)));
      Spice3.Basic.Ground ground annotation (Placement(transformation(extent={{28,-100},
                {48,-80}},         rotation=0)));
      Spice3.Sources.V_pulse vin1(
        V2=5,
        TR=0.001,
        TF=0.001,
        PW=2,
        PER=10,
        TD=2)                        annotation (Placement(transformation(
            origin={-42,24},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Spice3.Sources.V_pulse vin2(
        V2=5,
        TR=0.001,
        TF=0.001,
        PW=2,
        PER=10,
        TD=1)                         annotation (Placement(transformation(
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
      connect(m_NMOS.B, m_NMOS.S) annotation (Line(points={{4,-34},{4,-44},{
              -6,-44}},   color={0,0,255}));
      connect(m_NMOS1.B, m_NMOS1.S) annotation (Line(points={{52,-34},{52,-44},
              {42,-44}}, color={0,0,255}));
      connect(m_NMOS1.S, ground.p) annotation (Line(points={{42,-44},{38,-44},
              {38,-80}},
                       color={0,0,255}));
      connect(m_NMOS.S, ground.p) annotation (Line(points={{-6,-44},{-6,-80},{
              38,-80}}, color={0,0,255}));
      connect(vin2.p, m_NMOS.G)     annotation (Line(points={{-44,-34},{-29,
              -34},{-29,-34.1},{-16,-34.1}},
                                      color={0,0,255}));
      connect(vin2.n, ground.p)     annotation (Line(points={{-44,-54},{-44,-80},
              {38,-80}},color={0,0,255}));
      connect(vin1.p, m_PMOS.G)    annotation (Line(points={{-42,34},{-29,34},
              {-29,33.9},{-16,33.9}}, color={0,0,255}));
      connect(vin1.n, ground.p)    annotation (Line(points={{-42,14},{-64,14},{
              -64,-80},{38,-80}},color={0,0,255}));
      connect(m_PMOS.S, m_PMOS1.D)
        annotation (Line(points={{-6,24},{-6,14}},   color={0,0,255}));
      connect(m_PMOS1.S, m_NMOS.D) annotation (Line(points={{-6,-6},{-6,-24}},
            color={0,0,255}));
      connect(m_NMOS1.D, m_NMOS.D) annotation (Line(points={{42,-24},{-6,-24}},
            color={0,0,255}));
      connect(vin2.p, m_PMOS1.G)     annotation (Line(points={{-44,-34},{-44,4},
              {-16,4},{-16,3.9}},   color={0,0,255}));
      connect(vin1.p, m_NMOS1.G)    annotation (Line(points={{-42,34},{-28,34},
              {-28,-18},{32,-18},{32,-34.1}},
                                         color={0,0,255}));
      connect(m_PMOS.B, m_PMOS.D) annotation (Line(
          points={{4,34},{4,44},{-6,44}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(m_PMOS1.B, m_PMOS.B) annotation (Line(
          points={{4,4},{4,34}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(v.p, m_PMOS.D)        annotation (Line(
          points={{62,44},{-6,44}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(v.n, ground.p)        annotation (Line(
          points={{62,24},{62,-80},{38,-80}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (                           Diagram(coordinateSystem(
              preserveAspectRatio=true,  extent={{-100,-100},{100,100}}),
                                                     graphics),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-100,-100},{80,50}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Polygon(
              points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Polygon(
              points={{100,70},{100,-80},{80,-100},{80,50},{100,70}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Text(
              extent={{-96,3},{77,-49}},
              lineColor={0,0,255},
              textString="6"),
            Text(
              extent={{-120,132},{120,73}},
              lineColor={255,0,0},
              textString="%name")}),
        Documentation(info="<html>
<p>In nearly every electronic the basic circuit &QUOT;nor&QUOT; is used. A nor contains two PMOS and two NMOS. The faulty wiring can be seen in the graphical mode. If and only if the two inputvoltages have low potential, the outputvoltage has high potential, otherwise the outputvoltage has low potential. </p>
<p>Nor truth table (1 means true, it is represented by the 5V voltage): </p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"1\"><tr>
<td><p>input voltage vin1</p></td>
<td><p>input voltage vin2</p></td>
<td><p>output voltage m_PMOS1.NS</p></td>
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
<p><br/><br/><br/><br/>Simulate until t=5s. Display the two input voltages vin1.p.v and vin2.p.v and the output voltage m_PMOS1.NS.v. </p>
<p>The output value in the example shows a behaviour &QUOT;near&QUOT; the one of the truth table, since the capacitances are huge. Therefore loading is not finished before the next input changes.</p>
</html>", revisions="<html>
<p><ul>
<li><i>March 2009 </i>by Kristin Majetta initially implemented</li>
</ul></p>
</html>"),
        experiment(StopTime=5),
        experimentSetupOutput);
    end Nor;

    model Graetz "Graetz rectifier circuit"

      Spice3.Semiconductors.D_DIODE D1(modelcarddiode(CJO=1e-7))
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={0,14})));
      Spice3.Semiconductors.D_DIODE D3(modelcarddiode(CJO=1e-7))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={20,-8})));
      Spice3.Semiconductors.D_DIODE D4(modelcarddiode(CJO=1e-7))
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={1,-30})));
      Spice3.Semiconductors.D_DIODE D2(modelcarddiode(CJO=1e-7))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-20,-8})));
      Spice3.Semiconductors.R_Resistor r_out(R=10)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={42,-7})));
      Spice3.Sources.V_sin v_sin(VA=10, FREQ=200)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-44,-8})));
      Spice3.Basic.Ground ground
        annotation (Placement(transformation(extent={{-30,-60},{-10,-40}})));
    equation
      connect(D1.n, D3.p) annotation (Line(
          points={{10,14},{20,14},{20,2}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(D2.p, D1.p) annotation (Line(
          points={{-20,2},{-20,14},{-10,14}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(D4.n, D3.n) annotation (Line(
          points={{11,-30},{20,-30},{20,-18}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(D4.p, D2.n) annotation (Line(
          points={{-9,-30},{-20,-30},{-20,-18}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(D4.p, ground.p) annotation (Line(
          points={{-9,-30},{-20,-30},{-20,-40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(v_sin.n, ground.p) annotation (Line(
          points={{-44,-18},{-44,-40},{-20,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(D4.n, r_out.p)      annotation (Line(
          points={{11,-30},{42,-30},{42,-17}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(r_out.n, D1.p)      annotation (Line(
          points={{42,3},{42,26},{-20,26},{-20,14},{-10,14}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(D3.p, v_sin.p) annotation (Line(
          points={{20,2},{20,40},{-44,40},{-44,2}},
          color={0,0,255},
          smooth=Smooth.None));
      annotation (
        Diagram(graphics),
        Icon(graphics={
            Rectangle(
              extent={{-100,-100},{80,50}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Polygon(
              points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Polygon(
              points={{100,70},{100,-80},{80,-100},{80,50},{100,70}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Text(
              extent={{-96,3},{77,-49}},
              lineColor={0,0,255},
              textString="7"),
            Text(
              extent={{-120,132},{120,73}},
              lineColor={255,0,0},
              textString="%name")}),
        experiment(StopTime=0.025),
        experimentSetupOutput,
        Documentation(info="<html>
<p>The Graetz rectifier circuit is to show the behaviour of diodes.</p>
<p>Simulator until 0.025 s. Then display the input voltge v_sin.p.v. The r_out.p.v voltage is the rectified voltage result, which is pulsing mostly in the positive range.</p>
</html>", revisions="<html>
<p><ul>
<li><i>Jan. 2010 </i>by Kristin Majetta initially implemented</li>
</ul></p>
</html>"));
    end Graetz;

    model oscillator "Oscillator circuit"

      Spice3.Basic.R_Resistor r(R=1000) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-36,20})));
      Spice3.Basic.C_Capacitor c(C=1e-7)
        annotation (Placement(transformation(extent={{-32,0},{-12,20}})));
      Spice3.Basic.C_Capacitor c1(C=1e-7)
        annotation (Placement(transformation(extent={{24,0},{44,20}})));
      Spice3.Basic.R_Resistor r1(R=22000) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-6,20})));
      Spice3.Basic.R_Resistor r2(R=22000) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={18,20})));
      Spice3.Basic.R_Resistor r3(R=1000) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,20})));
      Spice3.Semiconductors.Q_NPNBJT T1(mod(CJE=1e-9, CJC=1e-9))
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-30,-24})));
      Spice3.Semiconductors.Q_NPNBJT T2(mod(CJE=1e-9, CJC=1e-9))
        annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
      Spice3.Basic.Ground ground1
        annotation (Placement(transformation(extent={{-78,-34},{-58,-14}})));
      Spice3.Basic.Ground ground2
        annotation (Placement(transformation(extent={{50,-60},{70,-40}})));
      Spice3.Basic.R_Resistor r4(R=10000)         annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={64,-2})));
      Spice3.Sources.V_pulse v(
        V2=8,
        TD=0.0005,
        TR=0.01,
        PW=1000,
        PER=1000,
        TF=0)     annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-68,20})));

    equation
      connect(r.n,r1. n) annotation (Line(
          points={{-36,30},{-6,30}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(r1.n,r2. n) annotation (Line(
          points={{-6,30},{18,30}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(r2.n,r3. n) annotation (Line(
          points={{18,30},{50,30}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(r.p,c. p) annotation (Line(
          points={{-36,10},{-32,10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(c.n,r1. p) annotation (Line(
          points={{-12,10},{-6,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(r2.p,c1. p) annotation (Line(
          points={{18,10},{24,10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(c1.n,r3. p) annotation (Line(
          points={{44,10},{50,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(r1.p, T2.B)     annotation (Line(
          points={{-6,10},{-6,-30},{30.4,-30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(r2.p, T1.B)    annotation (Line(
          points={{18,10},{18,-24},{-20.4,-24}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(T1.C, r.p)    annotation (Line(
          points={{-33,-34},{-48,-34},{-48,10},{-36,10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(T1.E, ground1.p)    annotation (Line(
          points={{-33,-14},{-68,-14}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(T2.E, ground2.p)     annotation (Line(
          points={{43,-40},{60,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(r3.p, T2.C)     annotation (Line(
          points={{50,10},{50,-20},{43,-20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(r3.p, r4.p)         annotation (Line(
          points={{50,10},{58,10},{58,8},{64,8}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(ground2.p, r4.n)         annotation (Line(
          points={{60,-40},{60,-12},{64,-12}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(v.p, r.n)       annotation (Line(
          points={{-68,30},{-36,30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(v.n, ground1.p)       annotation (Line(
          points={{-68,10},{-68,-14}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (Diagram(graphics),
        Icon(graphics={
            Text(
              extent={{-108,156},{132,97}},
              lineColor={255,0,0},
              textString="%name"),
            Rectangle(
              extent={{-100,-100},{80,50}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Polygon(
              points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Polygon(
              points={{100,70},{100,-80},{80,-100},{80,50},{100,70}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Text(
              extent={{-96,3},{77,-49}},
              lineColor={0,0,255},
              textString="8"),
            Text(
              extent={{-120,132},{120,73}},
              lineColor={255,0,0},
              textString="%name")}),
        experiment(StopTime=0.025),
        experimentSetupOutput,
        uses(                     Modelica(version="3.1"), Spice3(version="1")),
        Documentation(info="<html>
<p>The oscillator circuit demonstrates the usage of BJT transistors.</p>
<p><br/>Simulate until 0.025 s. Display v.p.v, which is rising until 5 V. Furthermore display r4.p.v, which starts oscillating.</p>
</html>", revisions="<html>
<p><ul>
<li><i>Jan. 2010 </i>by Jonathan Gerbet initially implemented</li>
</ul></p>
</html>"));
    end oscillator;
  end Examples;

  package Basic "Basic electronical components"

    extends Modelica.Icons.Library;

    model Ground "Ground node"

      Modelica.Electrical.Analog.Interfaces.Pin p "Ground pin" annotation (Placement(transformation(
            origin={0,100},
            extent={{10,-10},{-10,10}},
            rotation=270)));
    equation
      p.v = 0;
      annotation (
        Documentation(info="<HTML>
<P>
Ground of an electrical circuit. The potential at the
ground node is zero. Every electrical circuit has to contain
at least one ground object.
</P>
<P>
SPICE does not have an element for the ground node (mass). In SPICE
netlists the ground is specified by the node number 0.
This Modelica SPICE library demands to describe the ground node
by this gound element.
</P>
</HTML>
",     revisions="<html>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
            Line(
              points={{0,100},{0,40}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{-60,40},{60,40}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{-40,20},{40,20}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{-20,0},{20,0}},
              color={0,0,255},
              smooth=Smooth.None),
            Text(
              extent={{-50,-14},{58,-54}},
              lineColor={0,0,255},
              textString="%name")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics),
        Window(
          x=0.23,
          y=0.23,
          width=0.59,
          height=0.63));
    end Ground;

    model R_Resistor "Ideal linear electrical resistor"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Resistance R=1 "Resistance";
    equation
      R*i = v;
      annotation (
        Documentation(info="<HTML>
<P>
The linear resistor connects the branch voltage <i>v</i> with the
branch current <i>i</i> by <i>i*R = v</i>.
The Resistance <i>R</i> is allowed to be positive, zero, or negative.
</P>
</HTML>
",     revisions="<html>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-70,0}}, color={0,0,255}),
            Line(points={{70,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-136,-46},{140,-62}},
              lineColor={0,0,0},
              textString="R=%R"),
            Text(extent={{-136,34},{138,54}},  textString="%name")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics),
        Window(
          x=0.2,
          y=0.06,
          width=0.62,
          height=0.69));
    end R_Resistor;

    model C_Capacitor "Ideal linear electrical capacitor"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Capacitance C=1 "Capacitance";
      parameter SI.Voltage IC=0 "Initial value";
      parameter Boolean UIC=false
        "Use initial conditions: true, if initial condition is used";
    protected
      SI.Voltage v_internal(start=IC, fixed=UIC);
    equation
        v_internal = p.v - n.v;
        i = C*der(v_internal);
      annotation (
        Window(
          x=0.32,
          y=0.33,
          width=0.48,
          height=0.58),
        Documentation(info="<HTML>
<p>
The linear capacitor connects the branch voltage <i>v</i> with the
branch current <i>i</i> by <i>i = C * dv/dt</i>.
The Capacitance <i>C</i> is allowed to be positive, zero, or negative.
</p>
</HTML>
"),     Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
            Line(
              points={{-14,28},{-14,-28}},
              color={0,0,255},
              thickness=0.5),
            Line(
              points={{14,28},{14,-28}},
              color={0,0,255},
              thickness=0.5),
            Line(points={{-90,0},{-14,0}}),
            Line(points={{14,0},{90,0}}),
            Text(
              extent={{-130,-40},{134,-60}},
              lineColor={0,0,0},
              textString="C=%C"),
            Text(extent={{-138,42},{136,62}},  textString="%name")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics));
    end C_Capacitor;

    model L_Inductor "Ideal linear electrical inductor"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Inductance L=1 "Inductance";
      parameter SI.Current IC=0 "Initial value";
      parameter Boolean UIC=false
        "Use initial conditions: true, if initial condition is used";
      SI.Current i_internal(start=IC, fixed=UIC);
    equation
      i_internal = p.i;
      L*der(i_internal) = v;
      annotation (
        Documentation(info="<html>
<p>The linear inductor connects the branch voltage <i>v</i> with the branch current <i>i</i> by <i>v = L * di/dt</i>. The inductance <i>L</i> is allowed to be positive, zero, or negative. </p>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
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
              lineColor={0,0,0},
              textString="L=%L"),
            Text(extent={{-136,36},{138,56}},  textString="%name")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics),
        Window(
          x=0.3,
          y=0.12,
          width=0.6,
          height=0.6));
    end L_Inductor;

    model E_VCV "Linear voltage-controlled voltage source"
      extends Interfaces.TwoPort_controlled_sources;
      parameter Real gain=1 "Voltage gain";
    equation
      v2 = v1*gain;
      i1 = 0;
      annotation (
        Documentation(info="<HTML>
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
is translated to Modelica:<br>
<pre>
    Ename -> Spice3.Basic.E_VCV Ename
    (Ename is the name of the Modelica instance)
    N+ -> p2.v
    N- -> n2.v
    NC+ -> p1.v
    NC- -> n1.v
    VALUE -> gain
</pre>
</HTML>
"),     Window(
          x=0.28,
          y=0.02,
          width=0.59,
          height=0.92),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
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
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics));
    end E_VCV;

    model G_VCC "Linear voltage-controlled current source"
      extends Interfaces.TwoPort_controlled_sources;
      parameter SI.Conductance transConductance=1 "Transconductance";
    equation
      i2 = v1*transConductance;
      i1 = 0;
      annotation (
        Documentation(info="<HTML>
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
is translated to Modelica:<br>
<pre>

    Gname -> Spice3.Basic.G_VCC Gname
    (Gname is the name of the Modelica instance)
    N+ -> p2.i
    N- -> n2.i
    NC+ -> p1 .v
    NC- -> n1.v
    VALUE -> transConductance
</pre>
</HTML>
"),     Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
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
            Line(points={{9,0},{49,0}})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
        Window(
          x=0.34,
          y=0.05,
          width=0.6,
          height=0.6));
    end G_VCC;

    model H_CCV "Linear current-controlled voltage source"
      extends Interfaces.TwoPort_controlled_sources;

      parameter SI.Resistance transResistance=1 "Transresistance";
    equation
      v2 = i1*transResistance;
      v1 = 0;
      annotation (
        Documentation(info="<html>
    VALUE -&GT; transResistance </pre>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
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
            Line(points={{-90,50},{-20,50},{-20,-50},{-90,-50}})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
        Window(
          x=0.3,
          y=0.13,
          width=0.6,
          height=0.6));
    end H_CCV;

    model F_CCC "Linear current-controlled current source"
      extends Interfaces.TwoPort_controlled_sources;
      parameter Real gain=1 "Current gain";
    equation
      i2 = i1*gain;
      v1 = 0;
      annotation (
        Documentation(info="<html>
<p>The linear current-controlled current source is a TwoPort. The &QUOT;right&QUOT; port current at pin 2 (=p2.i) is controlled by the &QUOT;left&QUOT; port current at pin p1(=p1.i) via </p>
<pre>    p2.i = p1.i * gain.</pre>
<p>The controlling port voltage is zero. Any current gain can be chosen. </p>
<p>The corresponding SPICE description </p>
<pre>    Fname N+ N- VNAM VALUE</pre>
<p><br/>is translated to Modelica:</p>
<pre>    Fname -&GT; Spice3.Basic.F_CCC Fname
    (Fname is the name of the Modelica instance)
    N+ -&GT; p2.i
    N- -&GT; n2.i  </pre>
<p>The voltage source VNAM has the two nodes NV+ and NV-: </p>
<pre>                   VNAM NV+ NV- VALUE_V</pre>
<p>The current through VNAM hast to be led through the CCC.</p>
<p>Therefore VNAM has to be disconnected and an additional</p>
<p>node NV_AD has to be added. </p>
<pre>    NV_AD -&GT; p1.i
    NV- -&GT; n1.i</pre>
<p>On this way the current, that flows through the voltage source VNAM, flows through the CCC. </p>
<pre>    VALUE -&GT; gain </pre>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
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
            Line(points={{10,0},{50,0}})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
        Window(
          x=0.31,
          y=0.09,
          width=0.6,
          height=0.6));
    end F_CCC;

    annotation(preferedView="info", Window(
         x=0.03,
         y=0.04,
         width=0.54,
         height=0.35,
         library=1,
         autolayout=1),
  Documentation(info="<html>
<p>This Package contains the basic components of the SPICE3 models. The first letter of the </p><p>name of the component shows the SPICE name, e.g. <b>R</b>_Resistor: <b>R</b> is the SPICE-name of the component </p><p>resistor which is used in SPICE-Netlists. </p>
</html>",
     revisions="<html>
<dl>
<dt>
<b>Main Authors:</b>
<dd>
<a href=\"http://people.eas.iis.fhg.de/Christoph.Clauss/\">Christoph Clau&szlig;</a>
    &lt;<a href=\"mailto:clauss@eas.iis.fhg.de\">clauss@eas.iis.fhg.de</a>&gt;<br>

    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden<br>
<p>
</dl>
</html>"));
  end Basic;

  package Semiconductors "Semiconductor devices and model cards"
    extends Modelica.Icons.Library;
    import Modelica.SIunits;

    model M_PMOS "PMOS MOSFET device"
      extends Repository.MOS( final mtype=1);
    equation

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              points={{60,0},{40,5},{40,-5},{60,0}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>P channel MOSFET transistor with fixed level 1: Shichman-Hodges model</p>
</html>", revisions="<html>
<p><ul>
<li><i>March 2008 </i>by Kristin Majetta <br/>initially implemented</li>
</ul></p>
</html>"));
    end M_PMOS;

    model M_NMOS "NMOS MOSFET device"
      extends Repository.MOS( final mtype=0);
    equation

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              points={{40,0},{60,5},{60,-5},{40,0}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>N channel MOSFET transistor with fixed level 1: Shichman-Hodges model</p>
</html>", revisions="<html>
<p><ul>
<li><i>March 2008 </i>by Kristin Majetta <br/>initially implemented</li>
</ul></p>
</html>"));
    end M_NMOS;

    record modelcardMOS "Record for the specification of modelcard parameters"
      extends Repository.modelcardMOS;
      annotation (Documentation(info="<html>
<p>Technology model parameters of MOSFET transistor with fixed level 1: Shichman-Hodges model</p>
</html>"));
    end modelcardMOS;

    model Q_NPNBJT "Bipolar junction transistor"
     extends Spice3.Repository.BJT(mod(final TBJT=1));

      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              points={{8,-68},{2,-55},{-4,-62},{8,-68}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
                                     Diagram(coordinateSystem(
              preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
            graphics),
        Documentation(info="<html>
<p>NPN bipolar junction transistor model: Modified Gummel-Poon</p>
</html>", revisions="<html>
<p><ul>
<li><i>August 2009 </i>by Kristin Majetta <br/>initially implemented</li>
</ul></p>
</html>"));

    end Q_NPNBJT;

    model Q_PNPBJT "Bipolar junction transistor"
     extends Spice3.Repository.BJT(mod(final TBJT=-1));

      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              points={{0,-60},{14,-67},{8,-74},{0,-60}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
                                     Diagram(coordinateSystem(
              preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
            graphics),
        Documentation(info="<html>
<p>PNP bipolar junction transistor model: Modified Gummel-Poon</p>
</html>", revisions="<html>
<p><ul>
<li><i>August 2009 </i>by Kristin Majetta <br/>initially implemented</li>
</ul></p>
</html>"));

    end Q_PNPBJT;

    record modelcardBJT "Record for the specification of modelcard parameters"
      extends Spice3.Repository.modelcardBJT;
      annotation (Documentation(info="<html>
<p>Technology parameters of the  modified Gummel-Poon bipolar junction transistor model</p>
</html>"));
    end modelcardBJT;

   model D_DIODE "Diode model"
     extends Spice3.Repository.DIODE;

     annotation (
       Icon(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}),
          graphics),
       Diagram(graphics),
       DymolaStoredErrors,
        Documentation(info="<html>
<p>Junction diode model</p>
</html>", revisions="<html>
<p><ul>
<li><i>Nov. 2008 </i>by Kristin Majetta <br/>initially implemented</li>
</ul></p>
</html>"));

   end D_DIODE;

   record modelcardDIODE "Record for the specification of modelcard parameters"
     extends Spice3.Repository.modelcardDIODE;
      annotation (Documentation(info="<html>
<p>Technology parameters of the junction diode model</p>
</html>"));
   end modelcardDIODE;

    model R_Resistor "Semiconductor resistor from SPICE3"
    extends Spice3.Repository.R_SEMI;
                    annotation (Placement(transformation(extent={{-110,-10},{
                -90,10}}, rotation=0), iconTransformation(extent={{-100,0},{-80,
                20}})),         Placement(transformation(extent={{110,-10},{90,
                10}}, rotation=0), iconTransformation(extent={{120,0},{100,20}})),
                  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),      graphics),
        Documentation(info="<html>
<p>Semiconductor resistor model</p>
</html>", revisions="<html>
<p><ul>
<li><i>April 2009 </i>by Kristin Majetta <br/>initially implemented</li>
</ul></p>
</html>"));
    end R_Resistor;

    record modelcardRESISTOR
      "Record for the specification of modelcard parameters"
      extends Spice3.Repository.modelcardR;
      annotation (Documentation(info="<html>
<p>Technology parameters of the semiconductor resistor model</p>
</html>"));
    end modelcardRESISTOR;
    annotation(preferedView="info",
      Window(
        x=0.03,
        y=0.04,
        width=0.50,
        height=0.36,
        library=1,
        autolayout=1),
      Documentation(info="<html>
<p>This package contains both the semiconductor devices models of SPICE3, which are available, and their modelcards. The user should apply the models of this package.</p>
<p>All models of this package extend models of the package Repository, which contains the functions, parameters and data which are necessary to model the behaviour of the semiconductor devices.The modelcard records contain the SPICE3 technology parameters, which can be adjusted for more than one MOS simultaneously.</p>
</html>",
     revisions="<html>
<dl>

</dl>
</html>"));
  end Semiconductors;

  package Sources "Time dependent SPICE3 voltage and current sources"

    extends Modelica.Icons.Library;

    model V_constant "Constant independent voltage sources"
      parameter SI.Voltage V=1 "Value of constant voltage";
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
    equation
      v = V;
      annotation (
        Window(
          x=0.33,
          y=0.18,
          width=0.6,
          height=0.6),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Line(points={{-90,0},{-10,0}}, color={0,0,0}),
            Line(points={{-10,60},{-10,-60}}, color={0,0,0}),
            Line(points={{0,30},{0,-30}}, color={0,0,0}),
            Line(points={{0,0},{90,0}}, color={0,0,0}),
            Text(extent={{-100,-120},{100,-80}}, textString="%name=%V")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
        Documentation(revisions="<html>
</html>", info="<html>
<p>Constant voltage source</p>
</html>"));
    end V_constant;

    model V_sin "Sinusoidal voltage source"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Voltage VO=0.0 "Offset";
      parameter SI.Voltage VA=0.0 "Amplitude";
      parameter SI.Frequency FREQ(start=1) "Frequency";
      parameter SI.Time TD=0.0 "Delay";
      parameter SI.Damping THETA=0.0 "Damping factor";
    protected
        constant Real pi=Modelica.Constants.pi;
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
             Line(points={{-90,0},{50,0}},  color={0,0,255}),
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
              lineColor={0,0,255})}),                            Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics),
        Documentation(revisions="<html>
</html>", info="<html>
<p>Damped sinusoidal source</p>
<p><h4>Note:</h4></p>
<p><ul>
<li>All parameters of sources should be set explicitly.</li>
<li>since TSTEP and TSTOP are not available for modeling in Modelica, differences to SPICE may occur if not all parameters are set.<br/></li>
</ul></p>
</html>"),
        DymolaStoredErrors);
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
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
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
             Line(points={{-90,0},{50,0}},  color={0,0,255}),
             Line(points={{50,0},{90,0}}, color={0,0,255}),
            Line(points={{-70,-48},{-67.2,-33.3},{-64.3,-20.1},{-60.8,-5.6},{
                  -57.3,7},{-53.7,17.92},{-49.5,29.18},{-45.3,38.7},{-40.3,48},
                  {-34.6,56.5},{-28.3,64.1},{-21.2,70.6},{-12.7,76.3},{-2.1,
                  81.2},{0,82},{2.12,69.5},{4.95,54.7},{7.78,41.8},{10,31},{
                  14.14,18.3},{17.68,8},{21.9,-2.2},{26.2,-10.6},{31.1,-18.5},{
                  36.8,-25.4},{43.1,-31.3},{50.9,-36.5},{60.8,-40.8},{70,-43.4}},
                                                                      color={
                  192,192,192})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
        Window(
          x=0.11,
          y=0.12,
          width=0.78,
          height=0.83),
        Documentation(revisions="<html>
</html>", info="<html>
<p>Rising and falling exponential source.</p>
<p><h4>Note:</h4></p>
<p><ul>
<li>All parameters of sources should be set explicitly.</li>
<li>since TSTEP and TSTOP are not available for modeling in Modelica, differences to SPICE may occur if not all parameters are set.- it should be set all the parameters definitly <br/>- normally, there exist differences between Dymola and Spice, because TSTEP and TSTOP are not available. <br/></li>
</ul></p>
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
      parameter Modelica.SIunits.Time T_rising=TR
        "End time of rising phase within one period";
      parameter Modelica.SIunits.Time T_width=T_rising + PW
        "End time of width phase within one period";
      parameter Modelica.SIunits.Time T_falling=T_width + TF
        "End time of falling phase within one period";
      Modelica.SIunits.Time T0(final start=TD) "Start time of current period";
      Integer counter(start=-1) "Period counter";
      Integer counter2(start=-1);

    equation
      when pre(counter2) <> 0 and sample(TD, PER) then
        T0 = time;
        counter2 = pre(counter);
        counter = pre(counter) - (if pre(counter) > 0 then 1 else 0);
      end when;
      v = V1 + (if (time < TD or counter2 == 0 or time >= T0 +
        T_falling) then 0 else if (time < T0 + T_rising) then (time - T0)*
        (V2-V1)/T_rising else if (time < T0 + T_width) then V2-V1 else
        (T0 + T_falling - time)*(V2-V1)/(T_falling - T_width));

      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
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
             Line(points={{-90,0},{50,0}},  color={0,0,255}),
             Line(points={{50,0},{90,0}}, color={0,0,255}),
            Line(points={{-86,-74},{-65,-74},{-35,66},{-4,66},{25,-74},{46,-74},
                  {75,66}}, color={192,192,192})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
        Window(
          x=0.21,
          y=0.22,
          width=0.6,
          height=0.63),
        Documentation(revisions="<html>
</html>", info="<html>
<p>Periodic pulse source with not limited number of periods.</p>
<p>A single pulse is described by the following table:</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><p><h4>time</h4></p></td>
<td><p><h4>value</h4></p></td>
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
<p><br/>Intermediate points are determined by linear interpolation.</p>
<p>A pulse it looks like a saw tooth, use this parameters e.g.:</p>
<table cellspacing=\"2\" cellpadding=\"2\" border=\"1\"><tr>
<td><p><h4>Parameter</h4></p></td>
<td><p><h4>Value</h4></p></td>
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
<p><br/><h4>Note:</h4></p>
<p><ul>
<li>All parameters of sources should be set explicitly.</li>
<li>since TSTEP and TSTOP are not available for modeling in Modelica, differences to SPICE may occur if not all parameters are set.</li>
</ul></p>
</html>"));
    end V_pulse;

    model V_pwl "Piece-wise linear voltage source"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter Real table[:, :]=[0, 0; 1, 1; 2, 4]
        "Table matrix (time = first column, voltage = second column)";
      Modelica.Blocks.Sources.TimeTable tab(table=table);
    equation
      v = tab.y;
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
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
             Line(points={{-90,0},{50,0}},  color={0,0,255}),
             Line(points={{50,0},{90,0}}, color={0,0,255}),
                                   Line(points={{-40,-50},{-40,70},{60,70},{60,
                  -50},{-40,-50},{-40,-20},{60,-20},{60,10},{-40,10},{-40,40},{
                  60,40},{60,70},{10,70},{10,-51}},color={192,192,192})}),
        Window(
          x=0.25,
          y=0.01,
          width=0.72,
          height=0.86),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
        Documentation(info="<html>
<p>This model generates a voltage by <b>linear interpolation</b> in a given table. The time points and voltage values are stored in a matrix <b>table[i,j]</b>, where the first column table[:,1] contains the time points and the second column contains the voltage to be interpolated. The table interpolation has the following proporties: </p>
<p><ul>
<li>The time points need to be <b>monotonically increasing</b>. </li>
<li><b>Discontinuities</b> are allowed, by providing the same time point twice in the table. </li>
<li>Values <b>outside</b> of the table range, are computed by <b>extrapolation</b> through the last or first two points of the table.</li>
<li>If the table has only <b>one row</b>, no interpolation is performed and the voltage value is just returned independantly of the actual time instant, i.e., this is a constant voltage source.</li>
<li>Via parameters <b>startTime</b> and <b>offset</b> the curve defined by the table can be shifted both in time and in the voltage. </li>
<li>The table is implemented in a numerically sound way by generating <b>time events</b> at interval boundaries, in order to not integrate over a discontinuous or not differentiable points. </li>
</ul></p>
<p>Example: </p>
<pre>   table = [0  0
            1  0
            1  1
            2  4
            3  9
            4 16]
If, e.g., time = 1.0, the voltage v =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the voltage v =  2.5,
    e.g., time = 2.0, the voltage v =  4.0,
<p><code>    e.g., time = 5.0, the voltage v = 23.0 (i.e. extrapolation).</code> </p>
</html>",
       revisions="<html>
</html>"));
    end V_pwl;

    model V_sffm "Single-frequency FM voltage source"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Voltage VO = 0 "Offset";
      parameter SI.Voltage VA = 0 "Amplitude";
      parameter SI.Frequency FC( start=0) "Carrier frequency";
      parameter Real MDI=0 "Modulation index";
      parameter SI.Frequency FS= FC "Singnal frequency";
    protected
        constant Real pi=Modelica.Constants.pi;
    equation
      v = VO + VA *Modelica.Math.sin( 2 *pi * FC *time + MDI *Modelica.Math.sin(2 *pi *FS *time));
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
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
             Line(points={{-90,0},{50,0}},  color={0,0,255}),
             Line(points={{50,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-51,57},{55,18}},
              lineColor={0,0,255},
              textString="SFFM")}),
        Window(
          x=0.25,
          y=0.01,
          width=0.72,
          height=0.86),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
        Documentation(info="<html>
<p>The single-frequency frequency modulation source generates a carrier signal of the frequency FC. This signal is modulated by the signal frequency FS. See the formula in the modelica text.</p>
<p><h4>Attention:</h4></p>
<p><ul>
<li>All parameters of sources should be set explicitly.</li>
<li>since TSTEP and TSTOP are not available for modeling in Modelica, differences to SPICE may occur if not all parameters are set.</li>
</ul></p>
</html>",
       revisions="<html>
</html>"));
    end V_sffm;

   model I_constant "Constant independent current sources"
      parameter SI.Current I=1 "Value of constant voltage";
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
   equation
      i = I;
      annotation (
        Window(
          x=0.33,
          y=0.18,
          width=0.6,
          height=0.6),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
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
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
        Documentation(revisions="<html>
</html>", info="<html>
<p>Constant current source</p>
</html>"));
   end I_constant;

    model I_sin "Sinusoidal current source"

      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Current IO=0 "Offset";
      parameter SI.Current IA=0 "Amplitude";
      parameter SI.Frequency FREQ(start=1) "Frequency";
      parameter SI.Time TD=0.0 "Delay";
      parameter SI.Damping THETA=0.0 "Damping factor";
    protected
        constant Real pi=Modelica.Constants.pi;
    equation
        assert(FREQ>0, "Frequency less or equal zero");
        i = IO + (if time < TD then 0 else IA*
        Modelica.Math.exp(-(time - TD)*THETA)*Modelica.Math.sin(2*pi
        *FREQ*(time - TD)));
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={   Polygon(
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
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
        Window(
          x=0.33,
          y=0.06,
          width=0.6,
          height=0.75),
        Documentation(revisions="<html>
</html>", info="<html>
<p>Damped sinusoidal source</p>
<p><h4>Note:</h4></p>
<p><ul>
<li>All parameters of sources should be set explicitly.</li>
<li>since TSTEP and TSTOP are not available for modeling in Modelica, differences to SPICE may occur if not all parameters are set.</li>
</ul></p>
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
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={                              Polygon(
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
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
        Window(
          x=0.11,
          y=0.12,
          width=0.78,
          height=0.83),
        Documentation(revisions="<html>
</html>", info="<html>
<p>Rising and falling exponential source.</p>
<p><h4>Note:</h4></p>
<p><ul>
<li>All parameters of sources should be set explicitly.</li>
<li>since TSTEP and TSTOP are not available for modeling in Modelica, differences to SPICE may occur if not all parameters are set.</li>
</ul></p>
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
      parameter Modelica.SIunits.Time T_rising=TR
        "End time of rising phase within one period";
      parameter Modelica.SIunits.Time T_width=T_rising + PW
        "End time of width phase within one period";
      parameter Modelica.SIunits.Time T_falling=T_width + TF
        "End time of falling phase within one period";
      Modelica.SIunits.Time T0(final start=TD) "Start time of current period";
      Integer counter(start=-1) "Period counter";
      Integer counter2(start=-1);

    equation
      when pre(counter2) <> 0 and sample(TD, PER) then
        T0 = time;
        counter2 = pre(counter);
        counter = pre(counter) - (if pre(counter) > 0 then 1 else 0);
      end when;
      i = I1 + (if (time < TD or counter2 == 0 or time >= T0 +
        T_falling) then 0 else if (time < T0 + T_rising) then (time - T0)*
        (I2-I1)/T_rising else if (time < T0 + T_width) then I2-I1 else
        (T0 + T_falling - time)*(I2-I1)/(T_falling - T_width));

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),
                               Icon(coordinateSystem(preserveAspectRatio=false,
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
              lineColor={0,0,255}),                      Line(points={{-85,-60},
                  {-64,-60},{-34,80},{-3,80},{26,-60},{47,-60},{76,80}}, color=
                  {192,192,192})}),
        Documentation(revisions="<html>
</html>", info="<html>
<p>Periodic pulse source with not limited number of periods.</p>
<p>A single pulse is described by the following table:</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><p><h4>time</h4></p></td>
<td><p><h4>value</h4></p></td>
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
<p><br/>Intermediate points are determined by linear interpolation.</p>
<p>A pulse it looks like a saw tooth, use this parameters e.g.:</p>
<table cellspacing=\"2\" cellpadding=\"2\" border=\"1\"><tr>
<td><p><h4>Parameter</h4></p></td>
<td><p><h4>Value</h4></p></td>
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
<p><br/><h4>Note:</h4></p>
<p><ul>
<li>All parameters of sources should be set explicitly.</li>
<li>since TSTEP and TSTOP are not available for modeling in Modelica, differences to SPICE may occur if not all parameters are set.<br/><br/></li>
</ul></p>
</html>"));
    end I_pulse;

    model I_pwl "Piece-wise linear current source"
       extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter Real table[:, :]=[0, 0; 1, 1; 2, 4]
        "Table matrix (time = first column, voltage = second column)";
      Modelica.Blocks.Sources.TimeTable tab(table=table);

    equation
      i = tab.y;

      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
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
                  51},{56,81},{6,81},{6,-40}},     color={192,192,192}),
                                  Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
        Window(
          x=0.25,
          y=0.01,
          width=0.72,
          height=0.86),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
        Documentation(info="<html>
<p>This model generates a current  by <b>linear interpolation</b> in a given table. The time points and current values are stored in a matrix <b>table[i,j]</b>, where the first column table[:,1] contains the time points and the second column contains the current to be interpolated. The table interpolation has the following proporties: </p>
<p><ul>
<li>The time points need to be <b>monotonically increasing</b>. </li>
<li><b>Discontinuities</b> are allowed, by providing the same time point twice in the table. </li>
<li>Values <b>outside</b> of the table range, are computed by <b>extrapolation</b> through the last or first two points of the table.</li>
<li>If the table has only <b>one row</b>, no interpolation is performed and the current value is just returned independantly of the actual time instant, i.e., this is a constant current source.</li>
<li>Via parameters <b>startTime</b> and <b>offset</b> the curve defined by the table can be shifted both in time and in the current. </li>
<li>The table is implemented in a numerically sound way by generating <b>time events</b> at interval boundaries, in order to not integrate over a discontinuous or not differentiable points. </li>
</ul></p>
<p>Example: </p>
<pre>   table = [0  0
            1  0
            1  1
            2  4
            3  9
            4 16]
If, e.g., time = 1.0, the current i =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the current i =  2.5,
    e.g., time = 2.0, the current i =  4.0,
<p><code>    e.g., time = 5.0, the current i = 23.0 (i.e. extrapolation).</code> </p>
</html>",
       revisions="<html>
</html>"));
    end I_pwl;

    model I_sffm "Single-frequency FM current source"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Current IO = 0 "offset";
      parameter SI.Current IA = 0 "amplitude";
      parameter SI.Frequency FC( start=0) "carrier frequency";
      parameter Real MDI=0 "modulation index";
      parameter SI.Frequency FS= FC "singnal frequency";

    protected
        constant Real pi=Modelica.Constants.pi;
    equation
      i = IO + IA *Modelica.Math.sin( 2 *pi * FC *time + MDI *Modelica.Math.sin(2 *pi *FS *time));
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
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
             Line(points={{0,-50},{0,50}},color={0,0,255}),
                                  Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-58,53},{48,14}},
              lineColor={0,0,255},
              textString="SFFM")}),
        Window(
          x=0.25,
          y=0.01,
          width=0.72,
          height=0.86),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
        Documentation(info="<html>
<p>The single-frequency frequency modulation source generates a carrier signal of the frequency FC. This signal is modulated by the signal frequency FS. See the formula in the modelica text.</p>
<p><h4>Note:</h4></p>
<p><ul>
<li>All parameters of sources should be set explicitly.</li>
<li>since TSTEP and TSTOP are not available for modeling in Modelica, differences to SPICE may occur if not all parameters are set.</li>
</ul></p>
</html>",
       revisions="<html>
</html>"));
    end I_sffm;

    annotation(preferedView="info",
      Window(
        x=0.03,
        y=0.04,
        width=0.50,
        height=0.60,
        library=1,
        autolayout=1),Documentation(info="<html>
<p>This package contains the SPICE sources. </p>
<p><b>Note:</b> There are differences between SPICE3 and Modelica concerning the default values of the parameter. Therefore it is recommended to specify <b>all</b> parameters of the source.</p>
</html>", revisions="<html>
<p><ul>
<li><i>August 2009 </i>default values improved by Jonathan Kress<br/></li>
<li><i>October 2008 </i>by Christoph Clauss initially implemented.</li>
</ul></p>
</html>"));
  end Sources;

  package Additionals
    "Some useful additional models, e.g. from SPICE2 the polynomial sources"
    function poly "POLY function of SPICE2"
      input Real s[:];
      input Real a[:];
      output Real v;
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
      //assert(na>ia, "poly: function does not suppert coefficients");
      annotation (Documentation(info="<html>
<p>Function needed for polynomial interpolation of POLY controlled sources</p>
</html>"));
    end poly;

    model E_VCV_POLY
      "polynomial voltage controlled voltage source, like SPICE2 or PSPICE"

      parameter Integer N(final min=1) = 1 "number of controlling voltages";
      parameter Real coeff[:] = {1} "coefficients of polynomial";
      Modelica.Electrical.Analog.Interfaces.PositivePin p
        "Positive pin of the controlled (normally right) port (potential p2.v > n2.v for positive voltage drop v2)"
                                                                                                           annotation (Placement(
            transformation(extent={{110,40},{90,60}}, rotation=0),
            iconTransformation(extent={{110,40},{90,60}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n
        "Negative pin of the controlled (normally right) port"
                                                      annotation (Placement(
            transformation(extent={{90,-60},{110,-40}}, rotation=0),
            iconTransformation(extent={{90,-60},{110,-40}})));

      Modelica.Electrical.Analog.Interfaces.PositivePin pc[2*N]
        "Pin vector of controlling pins (normally left)"
            annotation (Placement(transformation(
              extent={{-90,-80},{-70,80}}, rotation=0), iconTransformation(extent={
                {-90,-80},{-70,80}})));
    //protected
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
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                        graphics),
        Documentation(info="<html>
<p>The polynomial source is a SPICE2 model, which is also known in other SPICE derivates.</p>
<p>Nonlinear voltage controlled voltage source. The &QUOT;right&QUOT; port voltage between pin p2 and n2 (=p2.v - n2.v) is controlled by the &QUOT;left&QUOT; port vector of voltages at the pin vector pc[:] via </p>
<pre>    p2.v - n2.v = f(pc[2].v - pc[1].v, pc[4].v - pc[3].v,...)</pre>
<p>The controlling port (left) current vector is zero. </p>
<p>f is a polynomial in N variables s1...sN of the following form with M+1 coefficients a0, a1, a2,...aM. </p>
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
<p><br/><br/>The Coefficients a(.) are counted in this order. Reaching M, the particular sum is canceled.</p><p><br/><br/>In connection with the VCV, s1...sN are the voltages of the controlling side: s1=pc[2].v - pc[1].v, s2=pc[4].v - pc[3].v, s3=...</p>
<p>The corresponding SPICE description of the VCV polynomial source is the following: </p>
<pre>    Ename A1 A2 POLY(N) E11 E21 ... E1N E2N P0 P1...</pre>
<p>where Ename is the name of the instance, A1 and A2 are the nodes between them the controlled voltage is gripped, </p><p>N is the number of the controlling voltages, E11 E12 ... E1N E2N are pairs of nodes between them the controlling voltages</p><p>are gripped, and P0, P1... are the coefficients that are called a0, a1, ... aM in the description of the polynomial f above. </p>
<p>To describe the SPICE line in Modelica, the following explanation would be useful:</p>
<pre>Ename -&GT; E_VCV_POLY name
A1, A2 -&GT; pins name.p2, name.p1
N -&GT; parameter N
E11 -&GT; name.pc[2]
E12 -&GT; name.pc[1]
...
E1N -&GT; name.pc[N]
E2N -&GT; name.pc[N-1]
P0, P1 -&GT; polynomial coefficients name.coeff(coeff={P0,P1,...})</pre>
</html>", revisions="<html>
<p><ul>
<li><i>Sept 2008 </i>by Kristin Majetta <br/>initially implemented</li>
</ul></p>
</html>"));
    end E_VCV_POLY;

    model G_VCC_POLY
      "polynomial voltage controlled current source, like SPICE2 or PSPICE"

      parameter Integer N(final min=1) = 1 "number of controlling voltages";
      parameter Real coeff[:] = {1} "coefficients of polynomial";
      Modelica.Electrical.Analog.Interfaces.PositivePin p
        "Positive pin of the right port (potential p2.v > n2.v for positive voltage drop v2)"
                                                                                                           annotation (Placement(
            transformation(extent={{110,40},{90,60}}, rotation=0),
            iconTransformation(extent={{110,40},{90,60}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n
        "Negative pin of the right port"              annotation (Placement(
            transformation(extent={{90,-60},{110,-40}}, rotation=0),
            iconTransformation(extent={{90,-60},{110,-40}})));

      Modelica.Electrical.Analog.Interfaces.PositivePin pc[2*N]
        "Pin vector of controlling pins"
            annotation (Placement(transformation(
              extent={{-90,-80},{-70,80}}, rotation=0), iconTransformation(extent={
                {-90,-80},{-70,80}})));
    //protected
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
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                        graphics),
        Documentation(info="<html>
<p>The polynomial source is a SPICE2 model, which is also known in other SPICE derivates.</p>
<p>Nonlinear voltage controlled current source. The right port current at pin p2 (=p2.i) is controlled by the left port vector of voltages at the pin vector pc[:] via </p>
<pre>    p2.i = f(pc[2].v - pc[1].v, pc[4].v - pc[3].v,...)</pre>
<p>The controlling port (left) current vector is zero. </p>
<p>f is a polynomial in N variables s1...sN of the following form with M+1 coefficients a0, a1, a2,...aM. </p>
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
<p><br/><br/>The Coefficients a(.) are counted in this order. Reaching M, the particular sum is canceled.</p><p><br/><br/>In connection with the VCC, s1...sN are the voltages of the controlling side: s1=pc[2].v - pc[1].v, s2=pc[4].v - pc[3].v, s3=...</p><p><br/><br/>The corresponding SPICE description of the VCC polynomial source is the following: </p>
<pre>    Gname A1 A2 POLY(N) E11 E21 ... E1N E2N P0 P1...</pre>
<p>where Gname is the name of the instance, A1 and A2 are the nodes between them the current source is arranged, whose current is calculated, </p><p>N is the number of the controlling voltages, E11 E12 ... E1N E2N are pairs of nodes between them the controlling voltages</p><p>are gripped, and P0, P1... are the coefficients that are called a0, a1, ... aM in the description of the polynomial f above. </p>
<p><br/>To describe the SPICE line in Modelica, the following explanation would be useful:</p>
<pre>Gname -&GT; G_VCC_POLY name
A1, A2 -&GT; pins name.p2, name.p1
N -&GT; parameter N
E11 -&GT; name.pc[2]
E12 -&GT; name.pc[1]
...
E1N -&GT; name.pc[N]
E2N -&GT; name.pc[N-1]
P0, P1 -&GT; polynomial coefficients name.coeff(coeff={P0,P1,...}) </pre>
</html>", revisions="<html>
<p><ul>
<li><i>Sept 2008 </i>by Kristin Majetta <br/>initially implemented</li>
</ul></p>
</html>"));
    end G_VCC_POLY;

    model H_CCV_POLY
      "polynomial current controlled voltage source, like SPICE2 or PSPICE"

      parameter Integer N(final min=1) = 1 "number of controlling voltages";
      parameter Real coeff[:] = {1} "coefficients of polynomial";
      Modelica.Electrical.Analog.Interfaces.PositivePin p
        "Positive pin of the right port (potential p2.v > n2.v for positive voltage drop v2)"
                                                                                                           annotation (Placement(
            transformation(extent={{110,40},{90,60}}, rotation=0),
            iconTransformation(extent={{110,40},{90,60}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n
        "Negative pin of the right port"              annotation (Placement(
            transformation(extent={{90,-60},{110,-40}}, rotation=0),
            iconTransformation(extent={{90,-60},{110,-40}})));

      Modelica.Electrical.Analog.Interfaces.PositivePin pc[2*N]
        "Pin vector of controlling pins"
            annotation (Placement(transformation(
              extent={{-90,-80},{-70,80}}, rotation=0), iconTransformation(extent={
                {-90,-80},{-70,80}})));
    //protected
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
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                        graphics),
        Documentation(info="<html>
<p>The polynomial source is a SPICE2 model, which is also known in other SPICE derivates.</p>
<p>Nonlinear current controlled voltage source. The right port voltage between pin p2 and n2 (=p2.v - n2.v) is controlled by the left port vector of currents at pin pc (=pc.i) via </p>
<pre>    p2.v - n2.v = f(pc[2].i, pc[4].i,...)</pre>
<p>The controlling port (left) current vector is zero. </p>
<p>The corresponding SPICE description </p>
<pre>    Hname A1 A2 POLY(N) V1...VN P0 P1...</pre>
<p>f is a polynomial in N variables s1...sN of the following form with M+1 coefficients a0, a1, a2,...aM. </p>
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
<p><br/><br/>The Coefficients a(.) are counted in this order. Reaching M, the particular sum is canceled.</p><p><br/><br/>In Modelica the controlling pins have to be connected to the CCV in that way, that the required currents flow through the according pins of the CCV:</p><p><br/><br/>s1 = pc[2].i, s2 = pc[4].i, s3 = pc[6].i,...</p><p><br/><br/>The pairs pc[1].i and pc[2].i, pc[3].i and pc[4].i...form ports with pc[2].i + pc[1].i = 0, pc[4].i + pc[3].i = 0, ...</p><p><br/><br/>The corresponding SPICE description of the CCV polynomial source is the following: </p>
<pre>    Hname A1 A2 POLY(N) V1...VN P0 P1...</pre>
<p>where Hname is the name of the instance, A1 and A2 are the nodes between them the controlled voltage is gripped. </p><p>N is the number of the controlling currents, V1...VN are the voltage sources, that are necessary in SPICE to supply the controlling currents,</p><p>and P0, P1... are the coefficients that are called a0, a1, ... aM in the description of the polynomial f above. </p>
<p><br/>To describe the SPICE line in Modelica, the following explanation would be useful:</p>
<pre>Hname -&GT; H_CCV_POLY name
A1, A2 -&GT; pins name.p2, name.p1
N -&GT; parameter N</pre>
<p>V1 (...VN) is declared in SPICE: </p>
<pre>   V1 V1+ V1- type of voltage source (constant, pulse, sin...)</pre>
<p>In Modelica the currents through V1...VN has to be led throught the CCV. Therefore V1...VN have to be disconnected and additional nodes </p>
<pre>   V1_AD...VN_AD</pre>
<p>have to be added. In the case, that the SPICE source is</p>
<pre>   V1 n+ n- 0,</pre>
<p>this source can be eliminated. </p>
<pre>V1_AD -&GT; name.pc[2]
V1- -&GT; name.pc[1]
...
VN_AD -&GT; name.pc[N]
VN- -&GT; name.pc[N-1]
<p><code>P0, P1 -&GT; polynomial coefficients name.coeff(coeff={P0,P1,...}) </code> </p>
</html>", revisions="<html>
<p><ul>
<li><i>Sept 2008 </i>by Kristin Majetta <br/>initially implemented</li>
</ul></p>
</html>"));
    end H_CCV_POLY;

    model F_CCC_POLY
      "polynomial current controlled current source, like SPICE2 or PSPICE"

      parameter Integer N(final min=1) = 1 "number of controlling voltages";
      parameter Real coeff[:] = {1} "coefficients of polynomial";
      Modelica.Electrical.Analog.Interfaces.PositivePin p
        "Positive pin of the right port (potential p2.v > n2.v for positive voltage drop v2)"
                                                                                                           annotation (Placement(
            transformation(extent={{110,40},{90,60}}, rotation=0),
            iconTransformation(extent={{110,40},{90,60}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n
        "Negative pin of the right port"              annotation (Placement(
            transformation(extent={{90,-60},{110,-40}}, rotation=0),
            iconTransformation(extent={{90,-60},{110,-40}})));

      Modelica.Electrical.Analog.Interfaces.PositivePin pc[2*N]
        "Pin vector of controlling pins"
            annotation (Placement(transformation(
              extent={{-90,-80},{-70,80}}, rotation=0), iconTransformation(extent={
                {-90,-80},{-70,80}})));
    //protected
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
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                        graphics),
        Documentation(info="<html>
<p>The polynomial source is a SPICE2 model, which is also known in other SPICE derivates.</p>
<p>Nonlinear current controlled current source. The &QUOT;right&QUOT; port current at pin p2 (=p2.i) is controlled by the &QUOT;left&QUOT; port vector of currents at pin pc[:] via </p>
<pre>    p2.i = f(pc[2].i, pc[4].i,...)</pre>
<p>The controlling port (left) voltage is zero for each pair: pc[2].v - pc[1].v = 0, ...</p><p>Furthermore the currents of each pair are pc[2].i + pc[1].i = 0, ... </p>
<p>f is a polynomial in N variables s1...sN of the following form with M+1 coefficients a0, a1, a2,...aM. </p>
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
<p><br/><br/>The Coefficients a(.) are counted in this order. Reaching M, the particular sum is canceled.</p><p><br/><br/>In Modelica the controlling pins have to be connected to the CCC in that way, that the required currents flow through the according pins of the CCC:</p><p><br/><br/>s1=pc[2].i, s2=pc[4].i, s3=pc[6].i,...</p><p><br/><br/>The pairs pc[1].i and pc[2].i, pc[3].i and pc[4].i...form ports with pc[2].i + pc[1].i = 0, pc[4].i + pc[3].i = 0, ...</p><p><br/><br/>The corresponding SPICE description of the CCC polynomial source is the following: </p>
<pre>    Fname A1 A2 POLY(N) V1...VN P0 P1...</pre>
<p>where Fname is the name of the instance, A1 and A2 are the nodes between them the current source is arranged, whose current is calculated. </p><p>N is the number of the controlling currents, V1...VN are the voltage sources, that are necessary in SPICE to supply the controlling currents,</p><p>and P0, P1... are the coefficients that are called a0, a1, ... aM in the description of the polynomial f above. </p>
<p><br/>To describe the SPICE line in Modelica, the following explanation would be useful:</p>
<pre>Fname -&GT; F_CCC_POLY name
A1, A2 -&GT; pins name.p2, name.p1
N -&GT; parameter N</pre>
<p>V1 (...VN) is declared in SPICE: </p>
<pre>   V1 V1+ V1- type of voltage source (constant, pulse, sin...)</pre>
<p>In Modelica the currents through V1...VN has to be led throught the CCC. Therefore V1...VN have to be disconnected and additional nodes </p>
<pre>   V1_AD...VN_AD</pre>
<p>have to be added. In the case, that the SPICE source is </p>
<pre>   V1 n+ n- 0,</pre>
<p>this source can be eliminated. </p>
<pre>V1_AD -&GT; name.pc[2]
V1- -&GT; name.pc[1]
...
VN_AD -&GT; name.pc[N]
VN- -&GT; name.pc[N-1]
<p><code>P0, P1 -&GT; polynomial coefficients name.coeff(coeff={P0,P1,...}) </code> </p>
</html>", revisions="<html>
<p><ul>
<li><i>Sept 2008 </i>by Kristin Majetta <br/>initially implemented</li>
</ul></p>
</html>"));
    end F_CCC_POLY;
    annotation (Documentation(info="<html>
<p>This package contains additional useful models which do not belong to the original SPICE3 model set.</p>
</html>"));
  end Additionals;

  package Interfaces "Connectors, Interfaces, and partial models"

    extends Modelica.Icons.Library;

    partial model TwoPort_controlled_sources
      "Component with two electrical ports, including current"
      SI.Voltage v1 "Voltage drop over the controlling port";
      SI.Voltage v2 "Voltage drop over the controlled port";
      SI.Current i1
        "Current flowing from pos. to neg. pin of the controlling port";
      SI.Current i2
        "Current flowing from pos. to neg. pin of the controlled port";
      Modelica.Electrical.Analog.Interfaces.PositivePin p1
        "Positive pin of the controlling port"       annotation (Placement(
            transformation(extent={{-110,40},{-90,60}}, rotation=0)));
      Modelica.Electrical.Analog.Interfaces.NegativePin n1
        "Negative pin of the controlling port"       annotation (Placement(
            transformation(extent={{-90,-60},{-110,-40}}, rotation=0)));
      Modelica.Electrical.Analog.Interfaces.PositivePin p2
        "Positive pin of the controlled port"         annotation (Placement(
            transformation(extent={{110,40},{90,60}}, rotation=0)));
      Modelica.Electrical.Analog.Interfaces.NegativePin n2
        "Negative pin of the controlled port"         annotation (Placement(
            transformation(extent={{90,-60},{110,-40}}, rotation=0)));
    equation
      v1 = p1.v - n1.v;
      v2 = p2.v - n2.v;
      0 = p1.i + n1.i;
      0 = p2.i + n2.i;
      i1 = p1.i;
      i2 = p2.i;
      annotation (
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
        Window(
          x=0.16,
          y=0.12,
          width=0.6,
          height=0.6));
    end TwoPort_controlled_sources;

    annotation(preferedView="info", Window(
        x=0.03,
        y=0.04,
        width=0.21,
        height=0.49,
        library=1,
        autolayout=1),Documentation(info="<html>
<p>The SPICE3 package uses the Modelica.Electrical.Analog interfaces. Only special partial models used in the SPICE3 package are located in this Interfaces package.</p>
</html>"));
  end Interfaces;

  package Repository
    "Collection of functions and records derived from the C++ Spice library"

  model MOS "Metal-Oxide Semiconductor Field-Effect Transistor"

    Modelica.Electrical.Analog.Interfaces.PositivePin G "gate node" annotation (Placement(transformation(
              extent={{-110,-12},{-90,10}}, rotation=0)));
    Modelica.Electrical.Analog.Interfaces.PositivePin D "drain node" annotation (Placement(transformation(
              extent={{-10,90},{10,110}}, rotation=0)));
    Modelica.Electrical.Analog.Interfaces.NegativePin S "source node" annotation (Placement(
            transformation(extent={{-10,-110},{10,-90}}, rotation=0)));
    Modelica.Electrical.Analog.Interfaces.PositivePin B "bulk node" annotation (Placement(transformation(
              extent={{90,-10},{110,10}}, rotation=0)));

    parameter Real mtype(start = 0) "MOSFET type: 0 - N channel, 1 - P channel";
    parameter Real L = 1e-4 "m, Length";
    parameter Real W = 1e-4 "m, Width";
    parameter Real AD = 0 "m*m, Area of the drain diffusion";
    parameter Real AS = 0 "m*m, Area of the source diffusion";
    parameter Real PD = 0 "m, Perimeter of the drain junction";
    parameter Real PS = 0 "m, Perimeter of the source junction";
    parameter Real NRD = 1 "Number of squares of the drain diffusions";
    parameter Real NRS = 1 "Number of squares of the source diffusions";
    parameter Real OFF = 0
        "Optional initial condition: 0 - IC not used, 1 - IC used, not implemented yet";
    parameter Real IC( start = -1e40)
        "v, Initial condition values, not implemented yet";                                  //default 0
    parameter Real TEMP = 27 "°C, Operating temperature of the device";

    parameter Repository.modelcardMOS modelcard "MOSFET modelcard" annotation(Evaluate=true);
    Repository.SpiceConstants C;
    final parameter Mos1.Mos1ModelLineParams p = Mos1.Mos1RenameParameters(modelcard, C) annotation(Evaluate=true);
    final parameter Mosfet.Mosfet m = Mos1.Mos1RenameParameters_dev(
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
      TEMP) annotation(Evaluate=true);
    final parameter Integer m_type = if (m.m_bPMOS > 0.5) then -1 else 1;
    final parameter Mos.MosModelLineVariables vp = Mos1.Mos1ModelLineParamsInitEquations(
          p,
          C,
          m_type);
    final parameter Mos1.Mos1Calc c1 = Mos.MosCalcInitEquations(
          p,
          C,
          vp,
          m);
    final parameter Mos1.Mos1Calc c2 = Mos.MosCalcCalcTempDependencies(
          p,
          C,
          vp,
          m,
          c1,
          m_type);
  //  Mos.DEVqmeyer qm;
    Mos.CurrrentsCapacitances cc;

    constant Boolean m_bInit = false;

    Real Din;  //voltage at Node Din
    Real Sin;  //voltage at node Sin
    Real ird;
    Real irs;
    Real ibdgmin;
    Real ibsgmin;

    Real icBD;
    Real icBS;
    Real icGB;
    Real icGS;
    Real icGD;
    Modelica.SIunits.Voltage vDS "Drain - source voltage";
    Modelica.SIunits.Voltage vGS "Gate - source voltage";

  equation
    assert( NRD <> 0, "NRD, length of drain in squares, must not be zero");
    assert( NRS <> 0, "NRS, length of source in squares, must not be zero");

    vDS = D.v - S.v;
    vGS = G.v - S.v;

    cc = Mos.MosCalcNoBypassCode(
      m,
      m_type,
      c2,
      p,
      C,
      vp,
      m_bInit,
      {G.v, B.v, Din, Sin});

    // drain- and sourceresistances
    // ----------------------------
    ird * c1.m_drainResistance = (D.v - Din);
    irs * p.m_sourceResistance = (S.v - Sin);

    // capacitances
    // ------------

     icBD = cc.cBD * (der(B.v) - der(Din));
     icBS = cc.cBS * (der(B.v) - der(Sin));
     icGB = cc.cGB * (der(G.v) - der(B.v));
     icGD = cc.cGD * (der(G.v) - der(Din));
     icGS = cc.cGS * (der(G.v) - der(Sin));

    // currents
    // --------
     ibsgmin = SpiceConstants.CKTgmin * (B.v - Sin);
     ibdgmin = SpiceConstants.CKTgmin * (B.v - Din);
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
</html>", revisions="<html>
<p><ul>
<li><i>March 2008 </i>by Kristin Majetta <br/>initially implemented</li>
</ul></p>
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                {100,100}}), graphics),
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
              textString="%name")}),
        DymolaStoredErrors);
  end MOS;

     record modelcardMOS "Record with technological parameters (.model)"
      //parameter Real LEVEL=1 "Model index";
       parameter Real VTO=-1e40 "V, Zero-bias threshold voltage, default 0";
       parameter Real KP=-1e40
        "A/(V*V), Transconductance parameter, default 2e-5";
       parameter Real GAMMA=-1e40 "V, Bulk threshold parameter, default 0";
       parameter Real PHI=-1e40 "V, Surface potential, default 0.6";
       parameter Real LAMBDA=0 "1/V, Channel-length modulation, default 0";
       parameter Real RD=-1e40 "Ohm, Drain ohmic resistance, default 0";
       parameter Real RS=-1e40 "Ohm, Source ohmic resistance, default 0";
       parameter Real CBD=-1e40
        "F, Zero-bias B-D junction capacitance, default 0";
       parameter Real CBS=-1e40
        "F, Zero-bias B-S junction capacitance, default 0";
       parameter Real IS=1.e-14 "A, Bulk junction saturation current";
       parameter Real PB=0.8 "V, Bulk junction potential";
       parameter Real CGSO=0.0
        "F/m, Gate-source overlap capacitance per meter channel width";
       parameter Real CGDO=0.0
        "F/m, Gate-drain overlap capacitance per meter channel width";
       parameter Real CGBO=0.0
        "F/m, Gate-bulk overlap capacitance per meter channel width";
       parameter Real RSH=0.0
        "Ohm, Drain and source diffusion sheet resistance";
       parameter Real CJ=0.0
        "F/(m*m), Zero-bias bulk junction bottom cap. per sq-meter of junction area";
       parameter Real MJ=0.5 "Bulk junction bottom grading coefficient";
       parameter Real CJSW=0.0
        "F/m, Zero-bias junction sidewall cap. per meter of junction perimeter";
       parameter Real MJSW=0.5 "Bulk junction sidewall grading coefficient";
       parameter Real JS=0.0
        "A/(m*m), Bulk junction saturation current per sq-meter of junction area";
       parameter Real TOX=-1e40 "m, Oxide thickness, default 1e-7";
       parameter Real NSUB=-1e40 "Substrate doping, default 0";
       parameter Real NSS=0.0 "1/(cm*cm), Surface state density";
       parameter Real TPG=1.0
        "Type of gate material: +1 opp. to substrate, -1 same as substrate, 0 Al gate";
       parameter Real LD=0.0 "m, Lateral diffusion";
       parameter Real UO=600 "(cm*cm)/(Vs), Surface mobility";
       parameter Real KF=0 "Flicker noise coefficient";
       parameter Real AF=1.0 "Flicker noise exponent";
       parameter Real FC=0.5
        "Coefficient for forward-bias depletion capacitance formula";
       parameter Real TNOM=-1e40
        "degree C, Parameter measurement temperature, default 27";
       constant Integer LEVEL=1 "Model level: Shichman-Hodges";
     equation

      annotation (Documentation(info="<html>
<p>Modelcard parameters for MOSFET model, both N and P channel, LEVEL 1: Shichman-Hodges</p>
</html>"));
     end modelcardMOS;

  model MOS2 "Metal-Oxide Semiconductor Field-Effect Transistor"

    Modelica.Electrical.Analog.Interfaces.PositivePin G "gate node"
                                          annotation (Placement(transformation(
              extent={{-110,-12},{-90,10}}, rotation=0)));
    Modelica.Electrical.Analog.Interfaces.PositivePin D "drain node"
                                           annotation (Placement(transformation(
              extent={{-10,90},{10,110}}, rotation=0)));
    Modelica.Electrical.Analog.Interfaces.NegativePin S "source node"
                                            annotation (Placement(
            transformation(extent={{-10,-110},{10,-90}}, rotation=0)));
    Modelica.Electrical.Analog.Interfaces.PositivePin B "bulk node"
                                          annotation (Placement(transformation(
              extent={{90,-10},{110,10}}, rotation=0)));

    parameter Real mtype(start = 0) "MOSFET type: 0 - N channel, 1 - P channel";
    parameter Real L = 1e-4 "m, Length";
    parameter Real W = 1e-4 "m, Width";
    parameter Real AD = 0 "m*m, Area of the drain diffusion";
    parameter Real AS = 0 "m*m, Area of the source diffusion";
    parameter Real PD = 0 "m, Perimeter of the drain junction";
    parameter Real PS = 0 "m, Perimeter of the source junction";
    parameter Real NRD = 1 "Number of squares of the drain diffusions";
    parameter Real NRS = 1 "Number of squares of the source diffusions";
    parameter Real OFF = 0
        "Optional initial condition: 0 - IC not used, 1 - IC used, not implemented yet";
    parameter Real IC( start = -1e40)
        "v, Initial condition values, not implemented yet";                                  //default 0
    parameter Real TEMP = 27 "°C, Operating temperature of the device";

  //  Real dummy_toplevel;
    Real MOScapgd = qm.qm_capgd;
    Real MOScapgs = qm.qm_capgs;
    Real MOScapgb = qm.qm_capgb;

    parameter Spice3.Repository.modelcardMOS2 modelcard "MOSFET modelcard"
                annotation(Evaluate=true);
    constant Spice3.Repository.SpiceConstants C
        "General constants of SPICE simulator";
    final parameter Spice3.Repository.Mos2.Mos2ModelLineParams p=
          Spice3.Repository.Mos2.Mos2RenameParameters(modelcard, C)
                      annotation(Evaluate=true);
    final parameter Spice3.Repository.Mosfet.Mosfet m=
          Spice3.Repository.Mos2.Mos2RenameParameters_dev(
            modelcard,
            mtype,
            W,
            L,
            AD,
            AS,
            PD,
            PS,
            NRD,
            NRS,
            OFF,
            IC,
            TEMP)
                annotation(Evaluate=true);
    final parameter Integer m_type = if (m.m_bPMOS > 0.5) then -1 else 1;
    final parameter Spice3.Repository.Mos2.Mos2ModelLineVariables vp=
          Spice3.Repository.Mos2.Mos2ModelLineParamsInitEquations(
            p,
            C,
            m_type);
    final parameter Spice3.Repository.Mos2.Mos2Calc c1=
          Spice3.Repository.Mos.Mos2CalcInitEquations(
            p,
            C,
            vp,
            m);
    final parameter Spice3.Repository.Mos2.Mos2Calc c2=
          Spice3.Repository.Mos.Mos2CalcCalcTempDependencies(
            p,
            C,
            vp,
            m,
            c1,
            m_type);
    Mos.DEVqmeyer qm;
    Spice3.Repository.Mos.CurrrentsCapacitances cc;

    constant Boolean m_bInit = false;

    Real Din;
    Real Sin;
    Real ird;
    Real irs;
    Real ibdgmin;
    Real ibsgmin;
   // Real spannung;
   // Real derspannung;

    Real icBD;
    Real icBS;
    Real icGB;
    Real icGS;
    Real icGD;

    Real icqmGB;
    Real icqmGS;
    Real icqmGD;
    Modelica.SIunits.Voltage vDS "Drain - source voltage";
    Modelica.SIunits.Voltage vGS "Gate - source voltage";

  equation
    assert( NRD <> 0, "NRD, length of drain in squares, must not be zero");
    assert( NRS <> 0, "NRS, length of source in squares, must not be zero");

    vDS = D.v - S.v;
    vGS = G.v - S.v;

      (cc,qm) = Spice3.Repository.Mos.Mos2CalcNoBypassCode(
          m,
          m_type,
          c2,
          p,
          C,
          vp,
          m_bInit,
          {G.v,B.v,Din,Sin});

    // drain- and sourceresistances
    // ----------------------------
    ird * c1.m_drainResistance  = (D.v - Din);
    irs * p.m_sourceResistance =  (S.v - Sin);

    // capacitances
    // ------------

    icBD = cc.cBD * (der(B.v) - der(Din));
    icBS = cc.cBS * (der(B.v) - der(Sin));
    icGB = cc.cGB * (der(G.v) - der(B.v));//
    icGD = cc.cGD * (der(G.v) - der(Din));//
    icGS = cc.cGS * (der(G.v) - der(Sin));//

    icqmGB = qm.qm_capgb*(der(G.v) - der(B.v));//
    icqmGS = qm.qm_capgs*(der(G.v) - der(Sin));//
    icqmGD = qm.qm_capgd*(der(G.v) - der(Din));//
   //  spannung = G.v - Din;
   //  derspannung = der(spannung);

    // currents
    // --------
      ibsgmin = Spice3.Repository.SpiceConstants.CKTgmin*(B.v - Sin);
      ibdgmin = Spice3.Repository.SpiceConstants.CKTgmin*(B.v - Din);
    G.i =  icGB + icGD + icGS + icqmGB + icqmGD + icqmGS;
    B.i = cc.iBD + cc.iBS+ ibdgmin + ibsgmin -icGB + icBD + icBS - icqmGB;
    D.i = ird;
    S.i = irs;

  //currentsum at inner node
  //------------------------
    0    = -ird + cc.idrain - cc.iBD - ibdgmin - icGD - icBD  - icqmGD;
    0    = -irs - cc.idrain - cc.iBS - ibsgmin - icGS - icBS  - icqmGS;

    annotation (Documentation(info="<html>
<p>MOSFET model, both N and P channel, LEVEL 2</p>
</html>", revisions="<html>
<p><ul>
<li><i>January 2009 </i>by Kristin Majetta <br/>initially implemented</li>
</ul></p>
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics),
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
              textString="%name")}),
        DymolaStoredErrors);
  end MOS2;

     record modelcardMOS2 "record with technological parameters (.model)"
     extends modelcardMOS(MJSW=0.33);

       parameter Real NFS=0.0 "Fast surface state density";
       parameter Real XJ=0.0 "Metallurgiecal junction depth";
       parameter Real UCRIT=1.e4
        "Critical field for mobility degradation (MOS2 only)";
       parameter Real UEXP=0.0
        "Critical field exponent in mobility degradation (MOS2 only)";
       parameter Real VMAX=0.0 "Maximum drift velocity of carries";
       parameter Real NEFF=1.0
        "Total channel charge (fixed and mobile) coefficient (MOS2 only)";
       parameter Real DELTA=0.0 "Width effect on theshold voltage";

      annotation (Documentation(info="<html>
<p>Modelcard parameters for MOSFET model, both N and P channel, LEVEL 2</p>
</html>"));
     end modelcardMOS2;

    model BJT "Bipolar junction transistor"

      Modelica.Electrical.Analog.Interfaces.PositivePin B "Base node"
        annotation (Placement(transformation(extent={{-108,-10},{-88,10}}),
            iconTransformation(extent={{-106,-10},{-86,10}})));
      Modelica.Electrical.Analog.Interfaces.PositivePin C "Collector node"
        annotation (Placement(transformation(extent={{10,88},{30,108}}),
            iconTransformation(extent={{20,90},{40,110}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin E "Emitter node"
        annotation (Placement(transformation(extent={{10,-108},{30,-88}}),
            iconTransformation(extent={{20,-110},{40,-90}})));

      parameter Real AREA = 1.0 "Area factor";
      parameter Boolean OFF = false
        "Optional initial condition: false - IC not used, true - IC used, not implemented yet";
      parameter Real IC_VCE( start = -1e40)
        "v, Initial condition value (VBE, not implemented yet";                    //default 0
      parameter Real IC_VBE( start = -1e40)
        "v, Initial condition value (VBC, not implemented yet";                    //default 0
      parameter Real TEMP = 27 "°C, Operating temperature of the device";
      parameter Boolean SENS_AREA = false
        "Flag to request sensitivity WRT area, not implemented yet";

      parameter Spice3.Repository.modelcardBJT mod "BJT modelcard"                            annotation(Evaluate=true);

      Real dummy;

      //Spice3_dynamisch_komplett_Bjt.Repository.Bjt3.Bjt3 p3;
      final parameter Spice3.Repository.Bjt3.BjtModelLineParams p=
          Bjt3.BjtRenameParameters(mod, Con)                                                                        annotation(Evaluate=true);
      constant Spice3.Repository.SpiceConstants Con "General SPICE constants";
      final parameter Spice3.Repository.Bjt3.Bjt p1=
          Bjt3.BjtRenameParameters_dev(
              AREA,
              OFF,
              IC_VBE,
              IC_VCE,
              SENS_AREA)
                   annotation(Evaluate=true);
      final parameter Spice3.Repository.Model.Model m=
          Bjt3.BjtRenameParameters_dev_Temp(TEMP)                                                                          annotation(Evaluate=true);
      final parameter Spice3.Repository.Bjt3.BjtModelLineVariables vl=
          Bjt3.BjtModelLineInitEquations(p);
      final parameter Spice3.Repository.Bjt3.Bjt3Calc c=
          Bjt3.Bjt3CalcTempDependencies(
              p1,
              p,
              m,
              vl);
      final parameter Spice3.Repository.Bjt3.BjtVariables v=
          Bjt3.BjtInitEquations(
              p1,
              p,
              vl);

      constant Boolean m_bInit = false;
      Spice3.Repository.Bjt3.CurrentsCapacitances cc;
      Real Cin;    //inner collector node
      Real Bin;    //inner base node
      Real Ein;    //inner emitter node
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
      Modelica.SIunits.Voltage vBE "Base - emitter voltage";
      Modelica.SIunits.Voltage vCE "Collector - emitter voltage";
      Modelica.SIunits.Voltage vBC "Base - collector voltage";

    equation
     //(p1,m) =  Bjt3.BjtRenameParameters_dev(AREA, OFF, IC_VBE, IC_VCE, SENS_AREA, TEMP);

      vBE = B.v - E.v;
      vCE = C.v - E.v;
      vBC = B.v - C.v;

       (cc,dummy,capbe,capbc,capbx) = Bjt3.BjtNoBypassCode(
             m,
             p1,
             p,
             c,
             v,
             vl,
             {C.v,B.v,E.v,Cin,Bin,Ein},
             m_bInit);

          //currents through capacitances
         icapbe = if (m_bInit) then 0.0 else capbe*(der(Bin) - der(Ein));//in_m_pVoltageValuesDot[5]-in_m_pVoltageValuesDot[6]);
         icapbc = if (m_bInit) then 0.0 else capbc*(der(Bin) - der(Cin));//in_m_pVoltageValuesDot[5]-in_m_pVoltageValuesDot[4]);
         icapbx = if (m_bInit) then 0.0 else capbx*(der(B.v) - der(Cin));//in_m_pVoltageValuesDot[2]-in_m_pVoltageValuesDot[4]);
         //Resistances
         irc * p.m_collectorResist = (C.v - Cin);
         ire * p.m_emitterResist = (E.v -Ein);
         irb * p.m_baseResist = (B.v - Bin);

        //currents
        ibcgmin = SpiceConstants.CKTgmin * (Bin - Cin);
        ibegmin = SpiceConstants.CKTgmin * (Bin - Ein);
        C.i = irc;
        E.i = ire;
        B.i = irb + cc.capbx;// + icBX;
       // //current sum at inner nodes
        0 =  ibcgmin + irc -cc.iCC + cc.iBCN + cc.iBC + icapbc + icapbx;  //current sum for inner node Cin
        0 =  ibegmin + ire + cc.iCC + cc.iBEN + cc.iBE + icapbe;          //current sum for inner node Ein
        0 = - ibcgmin - ibegmin + irb - cc.iBC - cc.iBE - cc.iBCN - cc.iBEN -icapbc - icapbe; //current sum for inner node Bin

      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Line(
              points={{-20,60},{-20,-60}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{-20,0},{-86,0}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{34,94},{-20,40}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{-20,-40},{32,-92}},
              color={0,0,255},
              smooth=Smooth.None),
            Text(
              extent={{-94,56},{206,16}},
              textString="%name",
              lineColor={0,0,255})}),Diagram(coordinateSystem(
              preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
            graphics),
        Documentation(info="<html>
<p>Bibpolar junction transistor model</p>
</html>",     revisions="<html>
<p><ul>
<li><i>August 2009 </i>by Kristin Majetta <br/>initially implemented</li>
</ul></p>
</html>"));
    end BJT;

    record modelcardBJT
      //String m_type( start = "NPN");

      parameter Real TBJT( start = 1) "Type of transistor (NPN=1, PNP=-1)";  //1=NPN, -1=PNP
      parameter Real TNOM = -1e40
        "°C, Parameter measurement temperature, default 27";
      parameter Real IS = 1e-16 "A, Transport saturation current"; // m_satCur
      parameter Real BF = 100.00 "Ideal maximum forward beta F"; //m_beta
      parameter Real NF = 1.0 "Forward current emission coefficientF"; //m_emissionCoeff
      parameter Real NE = 1.5 "B-E leakage emission coefficient ";
                                             //m_leakBEemissionCoeff
      parameter Real ISE = -1e40
        "A, B-E leakage saturation current, default = 0"; //m_leakBEcurrent,
      constant Real C2 =  -1e40 "Obsolete parameter name, , default = 0"; //m_c2
      parameter Real ISC = -1e40
        "A, B-C leakage saturation current, default = 0";  //m_leakBCcurrent
      constant Real C4 =  -1e40 "Obsolete parameter name, default = 0"; //m_c4
      parameter Real BR = 1.0 "Ideal maximum reverse beta"; //m_betaR
      parameter Real NR = 1.0 "Reverse current emission coefficient "; //m_emissionCoeffR
      parameter Real NC = 2.0 "B-C leakage emission coefficient";
                                            // m_leakBCemissionCoef
      parameter Real VAF = 0.0 "V, Forward Early voltage"; // m_earlyVoltF
      parameter Real IKF = 0.0 "A, Forward beta roll-off corner current"; //m_rollOffF
      parameter Real VAR = 0.0 "V, Reverse Early voltage"; // m_earlyVoltR
      parameter Real IKR = 0.0 "A, Reverse beta roll-off corner current"; // m_rollOffR
      parameter Real RE = 0.0 "Ohm, Emitter resistance"; // m_emitterResist
      parameter Real RC = 0.0 "Ohm, Collector resistance"; // m_collectorResist
      parameter Real IRB = 0.0 "A, Current for base resistance = (rb+rbm)/2";
                                                       //m_baseCurrentHalfResist
      parameter Real RB = 0.0 "Ohm, Zero bias base resistance"; // m_baseResist
      parameter Real RBM = -1e40 "Ohm, Minimum base resistance, default = 0.0";
      parameter Real CJE = 0.0 "Farad, Zero bias B-E depletion capacitance";
                                                      // m_depletionCapBE
      parameter Real VJE = 0.75 "V, B-E built in potential"; // m_potentialBE
      parameter Real MJE = 0.33 "B-E junction exponential faktor"; // m_junctionExpBE
      parameter Real TF = 0.0 "sec, Ideal forward transit time"; // m_transitTimeF
      parameter Real XTF = 0.0 "Coefficient for bias dependence of TF ";
                                                  //m_transitTimeBiasCoeffF
      parameter Real ITF = 0.0 "A, High current dependence of TF,";
                                             // m_transitTimeHighCurrentF
      parameter Real VTF = 0.0 "V, Voltage giving VBC dependence of TF";
                                                  // m_transitTimeFVBC
      parameter Real PTF = 0.0 "deg, Excess phase at freq=1/(TF*2*Pi) Hz"; //m_excessPhase
      parameter Real CJC = 0.0 "F, Zero bias B-C depletion capacitance";
                                                  //m_depletionCapBC
      parameter Real VJC = 0.75 "V, B-C built in potential"; // m_potentialBC
      parameter Real MJC = 0.33 "B-C junction grading coefficient"; // m_junctionExpBC
      parameter Real XCJC = 1.0 "Fraction of B-C cap to internal base";
                                                // m_baseFractionBCcap
      parameter Real TR = 0.0 "sec, Ideal reverse transit time"; // m_transitTimeR
      parameter Real CJS = 0.0 "F, Zero bias C-S capacitance "; //m_capCS
      parameter Real VJS = 0.75 "V, Substrate junction built-in potential "; //m_potentialSubstrate
      parameter Real MJS = 0.0 "Substrate junction grading coefficient ";
                                                   //m_exponentialSubstrate
      parameter Real XTB = 0.0 "Forward and reverse beta temperature exponent "; //m_betaExp
      parameter Real EG = 1.11
        "eV, Energy gap for IS temperature effect on IS ";                        //m_energyGap
      parameter Real XTI = 3.0 "Temperature exponent for IS"; // m_tempExpIS
      parameter Real KF = 0.0 "Flicker Noise Coefficient "; //m_fNcoef
      parameter Real AF = 1.0 "Flicker Noise Exponent "; //m_fNexp
      parameter Real FC = 0.5 "Forward bias junction fit parameter";

      annotation (Documentation(info="<html>
<p>Modelcard parameters for BJT model, both PNP and NPN</p>
</html>"));
    end modelcardBJT;

   model DIODE

     extends Modelica.Electrical.Analog.Interfaces.TwoPin;

     parameter Real AREA = 1 "Area factor";
     parameter Boolean OFF = false
        "Optional initial condition: false - IC not used, true - IC used, not implemented yet";
     parameter Real IC( start = -1e40)
        "v, Initial condition value (VD, not implemented yet";                   //default 0
     parameter Real TEMP = 27 "°C, Operating temperature of the device";
     parameter Boolean SENS_AREA( start = false)
        "Flag to request sensitivity WRT area, not implemented yet";

     parameter Spice3.Repository.modelcardDIODE modelcarddiode
        "DIODE modelcard"                                                         annotation(Evaluate=true);
     Spice3.Repository.SpiceConstants C;
     final parameter Spice3.Repository.Diode.DiodeModelLineParams param=
          Spice3.Repository.Diode.DiodeRenameParameters(modelcarddiode, C);
     //Diode.DiodeModelLineVariables vp;
     final parameter Spice3.Repository.Diode.DiodeParams dp=
          Spice3.Repository.Diode.DiodeRenameParameters_dev(
             TEMP,
             AREA,
             IC,
             OFF,
             SENS_AREA)
                      annotation(Evaluate=true);
     final parameter Spice3.Repository.Model.Model m=
          Spice3.Repository.Diode.DiodeRenameParameters_dev_temp(TEMP)
                 annotation(Evaluate=true);
     final parameter Spice3.Repository.Diode.DiodeVariables c1=
          Spice3.Repository.Diode.DiodeInitEquations(param);
     final parameter Spice3.Repository.Diode.DiodeCalc c2=
          Spice3.Repository.Diode.DiodeCalcTempDependencies(
             param,
             dp,
             m,
             c1);
     constant Boolean m_mbInit = false;

     Spice3.Repository.Diode.CurrentsCapacitances cc;
     Real icap;
     Real m_dCap;
     Real pin;
     Real ir;
     Real igmin;

   equation
   // vp:=Diode.DiodeModelLineInitEquations(p);

      (cc,m_dCap) = Spice3.Repository.Diode.DiodeNoBypassCode(
           param,
           dp,
           c2,
           m,
           m_mbInit,
           {pin,n.v});
             //{der(pin),der(n.v)}
     //current through capacitance
     icap = if (m_mbInit) then 0.0 else m_dCap*(der(pin)-der(n.v));
     //resistance
       ir*param.m_resist = (p.v - pin);

     //gmin
      igmin = Spice3.Repository.SpiceConstants.CKTgmin*(pin - n.v);

     p.i =  ir;
     n.i =  -(cc.m_dCurrent +igmin) -icap;

   //currentsum at inner node
     0 =  -ir + cc.m_dCurrent + igmin +icap;

     annotation (
       Icon(graphics={
            Line(points={{90,0},{-90,0}},     color={0,0,255}),
           Polygon(
             points={{30,0},{-30,40},{-30,-40},{30,0}},
             lineColor={0,0,0},
             fillColor={255,255,255},
             fillPattern=FillPattern.Solid),
           Line(points={{-90,0},{40,0}}, color={0,0,255}),
           Line(points={{40,0},{90,0}}, color={0,0,255}),
           Line(points={{30,40},{30,-40}}, color={0,0,255}),
           Text(
             extent={{-154,100},{146,60}},
             textString="%name",
             lineColor={0,0,255})}),
       Diagram(graphics),
       DymolaStoredErrors,
       Documentation(info="<html>
<p>DIODE model</p>
</html>", revisions="<html>
<p><ul>
<li><i>Nov. 2008 </i>by Kristin Majetta <br/>initially implemented</li>
</ul></p>
</html>"));
   end DIODE;

   record modelcardDIODE
   // parameter Boolean D;  //Diode model
    parameter Real IS=1e-14 "A, Saturation Current";
    parameter Real RS=0.0 "Ohm, Ohmic resistance";
    parameter Real N=1.0 "Emission coefficient";
    parameter Real TT=0.0 "s, Transit time";
    parameter Real CJO=0.0 "F, Junction capacitance";
    parameter Real VJ=1.0 "V, Junction Potential";
    parameter Real M=0.5 "Grading coefficient";
    parameter Real EG=1.11 "eV, Activation Energy";
    parameter Real XTI=3.0 "Saturation current temperature exponent";
    parameter Real FC=0.5 "Forward bias junction fit parameter";
    parameter Real BV=-1e40 "V, Reverse breakdown voltage, default infinity";
    parameter Real IBV=1e-3 "Am Current at reverse breakdown voltage";
    parameter Real TNOM=27 "degree C, Parameter measurement temperature";
    parameter Real KF=0.0 "Flicker noise coefficient";
    parameter Real AF=1.0 "Flicker noise exponent";
    parameter Real G=0 "S, Ohmic conductance";
     annotation (Documentation(info="<html>
<p>Modelcard parameters for DIODE model</p>
</html>"));
   end modelcardDIODE;

    model R_SEMI

      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter SI.Resistance R= -1e40
        "Resistance, if specified, geometrical information is overwritten";
      parameter Real TEMP = -1e40 "°C, Temperature of resistor";
      parameter Real L = -1e40 "m, lenght of the resistor";
      parameter Real W = -1e40
        "m, width of the resistor, default DEFW (modelcard)";
      parameter Boolean SENS_AREA= false
        "parameter for sensitivity analyses, not implemented yet";
      parameter Spice3.Repository.modelcardR modelcard "Resistor modelcard";
      Spice3.Repository.SpiceConstants C;
      final parameter Spice3.Repository.R_semiconductor.ResistorModelLineParams
        lp=Spice3.Repository.R_semiconductor.ResistorRenameParameters(modelcard,
          C);
      final parameter Spice3.Repository.R_semiconductor.ResistorParams rp=
          Spice3.Repository.R_semiconductor.ResistorRenameParameters_dev(
              R,
              W,
              L,
              TEMP,
              SENS_AREA,
              C);

        Spice3.Repository.R_semiconductor.ResistorVariables vp;

    algorithm
      vp := Spice3.Repository.R_semiconductor.ResistorInitEquations(rp, lp);

      (vp.m_dConduct,vp.m_dCond_dTemp) := Spice3.Repository.Equation.RESdepTemp(
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
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{70,0},{90,0}},
              color={0,0,255},
              smooth=Smooth.None),
            Text(
              extent={{-150,64},{150,24}},
              textString="%name",
              lineColor={0,0,255})}),Documentation(revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> April 2009 </i>
       by Kristin Majetta <br>initially implemented</li>
</ul>
</html>", info="<html>
<p>Semiconductor resistance model</p>
</html>"));
    end R_SEMI;

    record modelcardR
     parameter Real TC1 = 0.0 "Ohm/°C, First order temperature coefficient";
     parameter Real TC2 = 0.0
        "Ohm/(°C*°C), Second2 order temperature coefficient";
     parameter Real RSH = -1e40 "Ohm/Area Sheet resistance";
     parameter Real TNOM = -1e40
        "°C, Parameter measurement temperature, default 27";
     parameter Real DEFW = 1e-5 "m, Default device width";
     parameter Real NARROW = 0 "m, Narrowing of resistor due to side etching";
      annotation (Documentation(info="<html>
<p>Modelcard parameters for semiconductor resistance model</p>
</html>"));
    end modelcardR;

     record SpiceConstants
       constant Real EPSSIL =     (11.7 * 8.854214871e-12);
       constant Real EPSOX =      3.453133e-11;
       constant Real CHARGE =     (1.6021918e-19);
       constant Real CONSTCtoK =  (273.15);
       constant Real CONSTboltz = (1.3806226e-23);
       constant Real REFTEMP =    300.15;  /* 27 degrees C */

       constant Real CONSTroot2 =  sqrt(2.0);
       constant Real CONSTvt0 =    CONSTboltz * (27 + CONSTCtoK)  / CHARGE; // deg c
       constant Real CONSTKoverQ = CONSTboltz / CHARGE;
       constant Real CONSTe =      exp(1.0);

       // options

       constant Real CKTgmin =         1e-12;
       constant Real CKTnomTemp =      300.15;
       constant Real CKTtemp =         300.15;
       constant Real CKTdefaultMosAD = 0.0;
       constant Real CKTdefaultMosAS = 0.0;
       constant Real CKTdefaultMosL =  100e-6;
       constant Real CKTdefaultMosW =  100e-6;
       constant Real CKTreltol =       1e-10;
       constant Real CKTabstol =       1e-15;
       constant Real CKTvolttol =      1e-10;
       constant Real CKTtemptol =      1e-3;
      annotation (Documentation(info="<html>
<p>General constants used by SPICE</p>
</html>"));
     end SpiceConstants;

  package Equation
    /*
C++  double Model::RESdepTemp(
C++   double& dCond_dTemp,
C++   const double& resist, const double& temp, const double& tnom,
C++   const double& tc1, const double& tc2) const
{
C++   double difference = temp - tnom;
C++   double factor     = 1.0 + tc1 * difference + tc2 * difference * difference;
C++   double conduct    = 1.0 / (resist * factor);
C++   dCond_dTemp = (tc1 + 2 * tc2 * difference) * conduct * conduct;
C++   return conduct;
C++}

C++  double Model::ResDepGeom(
C++   const double& rsh,
C++   const double& width, const double& length, const double& narrow)
C++  {
C++  #ifdef SML_DEBUG
C++ //    if (m_bEquationDebug)
C++ //    cout << "   ResDepGeom: rsh=" << rsh << ", w=" << width << ", l="
C++ //         << length << ", narrow=" << narrow << ", -> R="
C++ //         << rsh * (length - narrow) / (width - narrow) << "\n";
C++ #endif
C++   return rsh * (length - narrow) / (width - narrow);
C++ }

C++ ////////////////////////////////////////////////////////////////////////////////

C++ double Model::CapDepGeom(
C++   const double& cap0, const double& capsw0,
C++   const double& width, const double& length, const double& narrow)
C++ {
C++  #ifdef SML_DEBUG
C++ //    if (m_bEquationDebug)
C++ //    cout << "   CapDepGeom: c0=" << cap0 << ", csw0=" << capsw0 << ", w="
C++ //         << width << ", l=" << length << ", narrow=" << narrow << ", -> C="
C++ //         << cap0 * (width - narrow) * (length - narrow)
C++ //       + capsw0 * 2 * ((length - narrow) + (width - narrow)) << "\n";
C++ #endif
C++   return cap0 * (width - narrow) * (length - narrow)
C++      + capsw0 * 2 * ((length - narrow) + (width - narrow));
C++ }


C++ double Model::JunctionCapDepTemp(
C++   const double& cap0, const double& mcoeff,
C++   const double& phi0, const double& temp, const double& tnom)
C++ {
C++   return
C++      cap0 * exp( mcoeff * log( phi0 / JunctionPotDepTemp( phi0, temp, tnom)));
C++ }



C++ ////////////////////////////////////////////////////////////////////////////////

C++ static const double max_exp      = 50.;
C++ static const double max_current  = 1.e4;

C++ void Model::Junction2(
C++   double& current, double& cond,
C++   const double& voltage, const double& temp, const double& ncoeff,
C++   const double& satcur)
C++ {
C++   if (satcur > 1e-101)
C++   {
C++      double vte          = CONSTKoverQ * temp * ncoeff;
C++      double max_exponent = log( max_current / satcur);
C++          max_exponent = F_Min( max_exp, max_exponent);
C++      if (voltage >= max_exponent * vte)
C++          {
C++         double evd = exp( max_exponent);
C++         cond       = satcur * evd / vte;
C++             current    = satcur * (evd - 1) + cond * (voltage - max_exponent * vte);
C++          }
C++          else if (voltage >= -5 * vte)
C++          {
C++         double evd = exp( voltage / vte);
C++         current    = satcur * (evd - 1) + CKTgmin * voltage;
C++         cond       = satcur * evd / vte + CKTgmin;
C++          }
C++      else
C++          {
C++         double arg = 3 * vte / (voltage * CONSTe);
C++         arg        = arg * arg * arg;
C++         current    = -1 * satcur * (1 + arg) + CKTgmin * voltage;
C++         cond       = satcur * 3 * arg / voltage + CKTgmin;
C++          }
C++   }
C++   else
C++   {
C++           current = 0.;
C++           cond = 0.;
C++   }
C++ }

C++ void Model::Junction2_SPICE3_BSIM(
C++   double& current, double& cond, const double& voltage,
C++   const double& satcur)
C++ {
C++   if (satcur > 1e-101)
C++   {
C++      double max_exponent = log( max_current / satcur);
C++          max_exponent = F_Min( max_exp, max_exponent);
C++      if (voltage <= 0.0 )
C++      {
C++         cond = satcur / CONSTvt0 + CKTgmin;
C++         current = cond * voltage ;
C++      }
C++      else if (voltage >= max_exponent * CONSTvt0)
C++      {
C++         double evd = exp( max_exponent);
C++             cond       = satcur * evd / CONSTvt0;
C++         current    = satcur * (evd - 1) + cond * (voltage - max_exponent * CONSTvt0);
C++      }
C++      else
C++      {
C++         double evbs = exp(voltage/CONSTvt0);
C++         cond = satcur * evbs/CONSTvt0 + CKTgmin;
C++         current = satcur * (evbs-1) + CKTgmin * voltage ;
C++      }
C++   }
C++   else
C++   {
C++           current = 0.;
C++           cond = 0.;
C++   }
C++ }

C++ double Model::JunctionVoltage23(
C++   Model* device, const double& vb, const double& ivb,
C++   const double& satcur, const double& temp, const double& ncoeff)
C++ {
C++   double vte = CONSTKoverQ * temp * ncoeff;
C++   double v23 = -1 * vb + vte * log( (ivb - CKTgmin * vb) / satcur);

C++   double arg = (3 * vte / CONSTe / v23);
C++   double tol  = CKTreltol * ivb + CKTabstol;
C++   if (satcur * arg * arg * arg > tol)
C++   {
C++      // fehler: strom am uebergang zu gross
C++      v23 = - 3 * vte / CONSTe / exp( log( tol) / 3.0);
C++      //       CEM_JunctionBreakDownV4(
C++      //          device, -1 * satcur * exp(( v23 - vb ) / vte ) + CKTgmin * vb).print();
C++   }
C++
C++   if (v23 > - 3 * vte)
C++   {
C++      // fehler: kein sperrbereich
C++      v23 = - 3 * vte;
C++      //       CEM_JunctionBreakDownV3(
C++      //          device, -1 * satcur * exp(( v23 - vb ) / vte ) + CKTgmin * vb).print();
C++   }
C++   return v23;
C++ }

C++  double Model::JunctionVoltage23_SPICE3(
C++   Model* device, const double& vb, const double& ivb,
C++   const double& satcur, const double& temp, const double& ncoeff)
C++ {
C++   double vt  = CONSTKoverQ * temp;
C++   // eigentlich sollte immer vte verwendet werden, ansonsten wird der
C++   // Durchbruchpunkt falsch bestimmt, aber SPICE-Kompatibilitaet!
C++   // double vte = vt * ncoeff;
C++   double v23 = vb;
C++   double cbv = ivb;

C++   if (cbv < satcur * vb / vt)
C++   {
C++      cbv = satcur * vb / vt;
C++      CEM_JunctionBreakDownV1( device, cbv).print();
C++   }
C++   else
C++   {
C++      double tol  = CKTreltol * cbv;
C++      v23  = vb - vt * log( 1 + cbv / satcur);
C++      for(int iter = 0 ; iter < 25 ; iter++)
C++      {
C++         v23 = vb - vt * log( cbv / satcur + 1 - v23 / vt);
C++         if (fabs( satcur *
C++                   ( exp(( vb - v23) / vt) - 1 + v23 / vt) - cbv) <= tol)
C++            return v23;
C++      }
C++      CEM_JunctionBreakDownV2(
C++         device, v23, satcur * ( exp(( vb - v23) / vt) - 1 + v23 / vt)).print();
C++   }
C++   return v23;
C++   }

C++   void Model::Junction3(
C++   double& current, double& cond,
C++   const double& voltage, const double& temp, const double& ncoeff,
C++   const double& satcur, const double& v23)
C++ {
C++   if (satcur > 1e-101)
C++   {
C++      double vte = CONSTKoverQ * temp * ncoeff;
C++      double max_exponent = log( max_current / satcur);
C++          max_exponent = F_Min( max_exp, max_exponent);
C++      if (voltage >= max_exponent * vte)
C++      {
C++         double evd = exp( max_exponent);
C++             cond       = satcur * evd / vte;
C++         current    = satcur * (evd - 1) + cond * (voltage - max_exponent * vte);
C++      }
C++      else if (voltage >= -3 * vte)
C++      {
C++         double evd = exp( voltage / vte );
C++         current    = satcur * (evd - 1) + CKTgmin * voltage;
C++         cond       = satcur * evd / vte + CKTgmin;
C++      }
C++      else if(voltage >= -v23)
C++      {
C++         double arg = 3 * vte / (voltage * CONSTe);
C++         arg        = arg * arg * arg;
C++         current    = -1. * satcur * (1 + arg) + CKTgmin * voltage;
C++         cond       = satcur * 3 * arg / voltage + CKTgmin;
C++      }
      else
          {
                  double vr = -( v23 + voltage );
                  if (vr > max_exponent * vte)
                  {
              double evd = exp( max_exponent);
                  cond       = satcur * evd / vte;
              current    = -1. * (satcur * (evd - 1) + cond * (vr - max_exponent * vte));
                  }
              else
                  {
             double evrev = exp( vr / vte );
             current      = -1. * satcur * evrev + CKTgmin * voltage;
             cond         = satcur * evrev / vte + CKTgmin;
                  }
          }
   }
   else
   {
           current = 0.;
           cond = 0.;
   }
}


////////////////////////////////////////////////////////////////////////////////

void Model::JunctionCapTransTime(
   double& capout, double& charge,
   const double& capin,
   const double& voltage, const double& depcap, const double& mj,
   const double& phij, const double& f1, const double& f2, const double& f3,
   const double& transittime, const double& conduct, const double& current)
{
   JunctionCap( capout, charge, capin, voltage, depcap, mj, phij, f1, f2, f3);
   capout += transittime * conduct;
   charge += transittime * current;
}

void Model::JunctionCapBSIM(
   double& capout, double& charge, const double& capin,
   const double& voltage, const double& mj, const double& phij)
{
   if( voltage < 0 ) {
      double arg = 1 - voltage / phij;
      double sarg = exp(-mj*log(arg));
      charge = phij * capin * (1-arg*sarg)/(1-mj);
      capout = capin * sarg;
   } else {
      charge = voltage * capin + voltage * voltage * (capin * mj * 0.5 / phij);
      capout = capin + voltage * (capin * mj / phij);
   }
}

////////////////////////////////////////////////////////////////////////////////



double Model::SaturationCurDepTemp(
   const double& satcur0,
   const double& temp, const double& tnom, const double& emissioncoeff,
   const double& satcurexp)
{
   double vt            = CONSTKoverQ * temp;
   double energygaptnom = EnergyGap_dep_Temp( temp);
   double energygaptemp = EnergyGap_dep_Temp( tnom);
   return satcur0
      * exp(
         (temp / tnom * energygaptnom - energygaptemp) / (emissioncoeff * vt)
         + satcurexp / emissioncoeff * log( temp / tnom));
}

double Model::SaturationCurDepTempSPICE3(
   const double& satcur0,
   const double& temp, const double& tnom, const double& emissioncoeff,
   const double& energygap, const double& satcurexp)
{
   double vt = CONSTKoverQ * temp;
   double vte= emissioncoeff * vt;
   return satcur0 * exp( ((temp / tnom) - 1) * energygap / vte
                         + satcurexp / emissioncoeff * log( temp / tnom) );
}

double Model::SaturationCurDepTempSPICE3JFET(
   const double& satcur0,
   const double& temp, const double& tnom)
{
   double vt = CONSTKoverQ * temp;
   return satcur0  * exp( (temp / tnom - 1) * 1.11 / vt);
}


////// end of file /////////////////////////////////////////////////////////////
*/
      function EnergyGap_dep_Temp
      /* double EnergyGap_dep_Temp(
   const double& temp, const double& gap0 = 1.16,
   const double& coeff1 = 7.02e-4, const double& coeff2 = 1108.); */

        input Real temp;
        input Real gap0 =   1.16;
        input Real coeff1 = 7.02e-4;
        input Real coeff2 = 1108.;

        output Real ret;

      algorithm
      /*  return gap0 - (coeff1 * temp * temp) / (temp + coeff2); */

        ret := gap0 - (coeff1 * temp * temp) / (temp + coeff2);

      end EnergyGap_dep_Temp;

      function JunctionPotDepTemp
      /* double Model::JunctionPotDepTemp(
   const double& phi0, const double& temp, const double& tnom) */

        input Real phi0;
        input Real temp;
        input Real tnom;

        output Real ret;

      protected
        Real phibtemp;
        Real phibtnom;
        Real vt;

      algorithm
      /* double phibtemp = EnergyGap_dep_Temp( temp);
   double phibtnom = EnergyGap_dep_Temp( tnom);
   double vt       = CONSTKoverQ * temp;
   return (phi0 - phibtnom) * temp / tnom + phibtemp + vt * 3 * log( tnom / temp); */

        phibtemp := EnergyGap_dep_Temp( temp);
        phibtnom := EnergyGap_dep_Temp( tnom);
        vt       := SpiceRoot.SPICEcircuitCONST.CONSTKoverQ * temp;
        ret := (phi0 - phibtnom) * temp / tnom + phibtemp + vt * 3 * Modelica.Math.log( tnom / temp);

      end JunctionPotDepTemp;

      function SaturationCurDepTempSPICE3MOSFET
      /* double Model::SaturationCurDepTempSPICE3MOSFET(
   const double& satcur0, const double& temp, const double& tnom) */

        input Real satcur0;
        input Real temp;
        input Real tnom;

        output Real ret;

      protected
        Real vt;
        Real vtnom;
        Real energygaptnom;
        Real energygaptemp;

      algorithm
      /* double vt            = CONSTKoverQ * temp;
   double vtnom         = CONSTKoverQ * tnom;
   double energygaptnom = EnergyGap_dep_Temp( tnom);
   double energygaptemp = EnergyGap_dep_Temp( temp);
   return satcur0  * exp( energygaptnom / vtnom - energygaptemp / vt); */

        vt            := SpiceRoot.SPICEcircuitCONST.CONSTKoverQ * temp;
        vtnom         := SpiceRoot.SPICEcircuitCONST.CONSTKoverQ * tnom;
        energygaptnom := EnergyGap_dep_Temp( tnom);
        energygaptemp := EnergyGap_dep_Temp( temp);
        ret           := satcur0  * exp( energygaptnom / vtnom - energygaptemp / vt);

      end SaturationCurDepTempSPICE3MOSFET;

      function JunctionVCrit
      /* double Model::JunctionVCrit(
   const double& temp, const double& ncoeff, const double& satcur) */

        input Real temp;
        input Real ncoeff;
        input Real satcur;

        output Real ret;

      protected
        Real vte;

      algorithm
      /* double vte = CONSTKoverQ * temp * ncoeff;
   double ret = vte * log( vte / (CONSTroot2 * satcur));
   if (ret > 1e10)
      return 1e10;
   else
      return ret; */

        vte := SpiceRoot.SPICEcircuitCONST.CONSTKoverQ * temp * ncoeff;
        ret := vte * Modelica.Math.log( vte / (sqrt(2) * satcur));
        ret := if ( ret > 1e10) then  1e10 else ret;

      end JunctionVCrit;

      function JunctionParamDepTempSPICE3
      /* void Model::JunctionParamDepTempSPICE3(
   double& junctionpot, double& jucntioncap,
   const double& phi0, const double& cap0, const double& mcoeff,
   const double& temp, const double& tnom) */

        input Real phi0;
        input Real cap0;
        input Real mcoeff;
        input Real temp;
        input Real tnom;

        output Real junctionpot;
        output Real jucntioncap;

      protected
        Real phibtemp;
        Real phibtnom;
        Real vt;
        Real vtnom;
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
      /* double phibtemp = EnergyGap_dep_Temp( temp);
   double phibtnom = EnergyGap_dep_Temp( tnom);
   double vt       = CONSTKoverQ * temp;
   double vtnom = CONSTKoverQ * tnom;
   double arg = -phibtemp/(2*CONSTboltz*temp) +
      1.1150877/(CONSTboltz*(REFTEMP+REFTEMP));
   double fact2 = temp/REFTEMP;
   double pbfact = -2*vt*(1.5*log(fact2)+CHARGE*arg);
   double arg1 = -phibtnom/(CONSTboltz*2*tnom) +
      1.1150877/(2*CONSTboltz*REFTEMP);
   double fact1 = tnom/REFTEMP;
   double pbfact1 = -2 * vtnom*(1.5*log(fact1)+CHARGE*arg1);
   double pbo = (phi0-pbfact1)/fact1;
   junctionpot = pbfact+fact2*pbo;
   double gmaold = (phi0 -pbo)/pbo;
   double gmanew = (junctionpot-pbo)/pbo;
   jucntioncap   = cap0 /
      (1+mcoeff* (400e-6*(tnom-REFTEMP)-gmaold) ) *
      (1+mcoeff* (400e-6*(temp-REFTEMP)-gmanew) ); */

        phibtemp    := EnergyGap_dep_Temp( temp);
        phibtnom    := EnergyGap_dep_Temp( tnom);
        vt          := SpiceRoot.SPICEcircuitCONST.CONSTKoverQ * temp;
        vtnom       := SpiceRoot.SPICEcircuitCONST.CONSTKoverQ * tnom;
        arg         := -phibtemp/(2*SpiceRoot.SPICEcircuitCONST.CONSTboltz*temp) +
                       1.1150877/(SpiceRoot.SPICEcircuitCONST.CONSTboltz*(2*SpiceRoot.SPICEcircuitCONST.REFTEMP));
        fact2       := temp/SpiceRoot.SPICEcircuitCONST.REFTEMP;
        pbfact      := -2*vt*(1.5*Modelica.Math.log(fact2)+SpiceRoot.SPICEcircuitCONST.CHARGE*arg);
        arg1        := -phibtnom/(SpiceRoot.SPICEcircuitCONST.CONSTboltz*2*tnom) +
                       1.1150877/(2*SpiceRoot.SPICEcircuitCONST.CONSTboltz*SpiceRoot.SPICEcircuitCONST.REFTEMP);
        fact1       := tnom/SpiceRoot.SPICEcircuitCONST.REFTEMP;
        pbfact1     := -2 * vtnom*(1.5*Modelica.Math.log(fact1)+SpiceRoot.SPICEcircuitCONST.CHARGE*arg1);
        pbo         := (phi0-pbfact1)/fact1;
        junctionpot := pbfact+fact2*pbo;
        gmaold      := (phi0 -pbo)/pbo;
        gmanew      := (junctionpot-pbo)/pbo;
        jucntioncap := cap0 /
                       (1+mcoeff* (400e-6*(tnom-SpiceRoot.SPICEcircuitCONST.REFTEMP)-gmaold))  *
                       (1+mcoeff* (400e-6*(temp-SpiceRoot.SPICEcircuitCONST.REFTEMP)-gmanew));

      end JunctionParamDepTempSPICE3;

      function JunctionCapCoeffs
      /* void Model::JunctionCapCoeffs(
   double& f1, double& f2, double& f3,
   const double& mj, const double& fc, const double& phij) */

        input Real mj;
        input Real fc;
        input Real phij;

        output Real f1;
        output Real f2;
        output Real f3;

      protected
        Real xfc;

      algorithm
      /* double xfc = log(1 - fc);
   f1 = phij * (1 - exp(( 1 - mj ) * xfc)) / (1 - mj);
   f2 = exp(( 1 + mj) * xfc);
   f3 = 1 - fc * (1 + mj); */

        xfc := Modelica.Math.log(1 - fc);
        f1  := phij * (1 - exp(( 1 - mj)  * xfc)) / (1 - mj);
        f2  := exp(( 1 + mj) * xfc);
        f3  := 1 - fc * (1 + mj);

      end JunctionCapCoeffs;

    function Junction2_SPICE3_MOSFET
    /* void Model::Junction2_SPICE3_MOSFET(
   double& current, double& cond,
   const double& voltage, const double& temp, const double& ncoeff,
   const double& satcur) */

      input Real current;
      input Real cond;
      input Real voltage;
      input Real temp;
      input Real ncoeff;
      input Real satcur;

      output Real out_current;
      output Real out_cond;

      protected
      Real vte;
      Real max_exponent;
      Real evbd;
      Real evd;
      constant Real max_exp =     50.;
      constant Real max_current = 1.e4;

    algorithm
    /*{if (satcur > 1e-101)
C++   {
C++      double vte = CONSTKoverQ * temp * ncoeff;
C++      double max_exponent = log( max_current / satcur);
C++          max_exponent = F_Min( max_exp, max_exponent);
C++      if(voltage <= 0)
C++      {
C++         cond    = satcur/vte;
C++         current = cond * voltage;
C++         cond    += CKTgmin;
C++      }
C++      else if (voltage >= max_exponent * vte)
C++      {
C++         double evd = exp( max_exponent);
C++             cond       = satcur * evd / vte;
C++         current    = satcur * (evd - 1) + cond * (voltage - max_exponent * vte);
C++      }
C++      else
C++      {
C++         double evbd = exp( voltage / vte);
C++         cond    = satcur*evbd/vte + CKTgmin;
C++         current = satcur *(evbd-1);
C++      }
C++   }
C++   else
C++   {
C++           current = 0.;
C++           cond = 0.;
C++   }} */

      out_current := current;
      out_cond := cond;
      if (satcur > 1e-101) then
        vte := SpiceRoot.SPICEcircuitCONST.CONSTKoverQ * temp * ncoeff;

        max_exponent := Modelica.Math.log(max_current/satcur);
        max_exponent := min(max_exp, max_exponent);

        if (voltage <= 0) then
          out_cond    := satcur/vte;
          out_current := out_cond * voltage;
          out_cond    := out_cond + SpiceRoot.SPICEcircuitCONST.CKTgmin;
        elseif (voltage >= max_exponent * vte) then
          evd         := exp( max_exponent);
          out_cond    := satcur * evd / vte;
          out_current := satcur * (evd - 1) + out_cond * (voltage - max_exponent * vte);

        else
          evbd        := exp( voltage / vte);
          out_cond    := satcur*evbd/vte + SpiceRoot.SPICEcircuitCONST.CKTgmin;
          out_current := satcur *(evbd-1);
        end if;
      else
        out_current := 0.;
        out_cond    := 0.;
      end if;

    end Junction2_SPICE3_MOSFET;

    function JunctionCap
    /* void Model::JunctionCap(
   double& capout, double& charge,
   const double& capin,
   const double& voltage, const double& depcap, const double& mj,
   const double& phij, const double& f1, const double& f2, const double& f3) */

      input Real capin;
      input Real voltage;
      input Real depcap;
      input Real mj;
      input Real phij;
      input Real f1;
      input Real f2;
      input Real f3;

      output Real capout;
      output Real charge;
    //  output Real guck;    //added by K.Majetta 21.08.08

      protected
      Real arg;
      Real sarg;
      Real czof2;

    algorithm
    /*{if (voltage < depcap)
   {
      double arg = 1 - voltage / phij;
      double sarg;
      if (mj == .5)
         sarg = 1 / sqrt( arg);
      else
         sarg = exp( -1 * mj * log( arg));
      capout = capin * sarg;
      charge = phij * (capin * (1 - arg * sarg) / (1 - mj));
   }
   else
   {
      double czof2 = capin / f2;
      capout = czof2 * (f3 + mj * voltage / phij);
      charge = capin * f1 + czof2 *
         (f3 * (voltage - depcap) + (mj / (phij + phij)) *
          (voltage * voltage - depcap * depcap));
   }} */

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
    end JunctionCap;

    function SaturationCurDepTempSPICE3
    /* double Model::SaturationCurDepTempSPICE3(
   const double& satcur0,
   const double& temp, const double& tnom, const double& emissioncoeff,
   const double& energygap, const double& satcurexp) */

      input Real satcur0;
      input Real temp;
      input Real tnom;
      input Real emissioncoeff;
      input Real energygap;
      input Real satcurexp;

      output Real ret;

      protected
      Real vt;
      Real vte;

    algorithm
    /* {
   double vt = CONSTKoverQ * temp;
   double vte= emissioncoeff * vt;
   return satcur0 * exp( ((temp / tnom) - 1) * energygap / vte
                         + satcurexp / emissioncoeff * log( temp / tnom) );
} */

        vt := Spice3.Repository.SpiceConstants.CONSTKoverQ*temp;
      vte := emissioncoeff * vt;
      ret := satcur0 * exp( ((temp / tnom) - 1) * energygap / vte
             + satcurexp / emissioncoeff * Modelica.Math.log( temp / tnom));

    end SaturationCurDepTempSPICE3;

    function JunctionVoltage23_SPICE3
    /* double Model::JunctionVoltage23_SPICE3(
   Model* device, const double& vb, const double& ivb,
   const double& satcur, const double& temp, const double& ncoeff) */

      input Real vb;
      input Real ivb;
      input Real satcur;
      input Real temp;
      input Real ncoeff;

      output Real v23;

      protected
      Real vt;
      Real cbv;
      Real tol;
      Integer iter;

    algorithm
    /* {
   double vt  = CONSTKoverQ * temp;
   // eigentlich sollte immer vte verwendet werden, ansonsten wird der
   // Durchbruchpunkt falsch bestimmt, aber SPICE-Kompatibilitaet!
   // double vte = vt * ncoeff;
   double v23 = vb;
   double cbv = ivb;

   if (cbv < satcur * vb / vt)
   {
      cbv = satcur * vb / vt;
      CEM_JunctionBreakDownV1( device, cbv).print();
   }
   else
   {
      double tol  = CKTreltol * cbv;
      v23  = vb - vt * log( 1 + cbv / satcur);
      for(int iter = 0 ; iter < 25 ; iter++)
      {
         v23 = vb - vt * log( cbv / satcur + 1 - v23 / vt);
         if (fabs( satcur *
                   ( exp(( vb - v23) / vt) - 1 + v23 / vt) - cbv) <= tol)
            return v23;
      }
      CEM_JunctionBreakDownV2(
         device, v23, satcur * ( exp(( vb - v23) / vt) - 1 + v23 / vt)).print();
   }
   return v23;
} */

        vt := Spice3.Repository.SpiceConstants.CONSTKoverQ*temp;
      // eigentlich sollte immer vte verwendet werden, ansonsten wird der
      // Durchbruchpunkt falsch bestimmt, aber SPICE-Kompatibilitaet!
      // double vte = vt * ncoeff;
      v23 := vb;
      cbv := ivb;

      if (cbv < satcur * vb / vt) then
        cbv := satcur * vb / vt;
      else
          tol := Spice3.Repository.SpiceConstants.CKTreltol*cbv;
        v23 := vb - vt * Modelica.Math.log( 1 + cbv / satcur);
        for iter in 0:24 loop
          v23 := vb - vt * Modelica.Math.log( cbv / satcur + 1 - v23 / vt);
          if (abs( satcur * ( exp(( vb - v23) / vt) - 1 + v23 / vt) - cbv) <= tol) then
    //        break;

          end if;
        end for;
      end if;

    end JunctionVoltage23_SPICE3;

    function Junction3
    /* void Model::Junction3(
   double& current, double& cond,
   const double& voltage, const double& temp, const double& ncoeff,
   const double& satcur, const double& v23) */

      input Real voltage;
      input Real temp;
      input Real ncoeff;
      input Real satcur;
      input Real v23;

      output Real current;
      output Real cond;

      protected
      constant Real max_exp = 50.0;
      constant Real max_current = 1.0e4;
      Real vte;
      Real max_exponent;
      Real evd;
      Real arg;
      Real evrev;
      Real vr;

    algorithm
    /*{
   if (satcur > 1e-101)
   {
      double vte = CONSTKoverQ * temp * ncoeff;
      double max_exponent = log( max_current / satcur);
          max_exponent = F_Min( max_exp, max_exponent);
      if (voltage >= max_exponent * vte)
      {
         double evd = exp( max_exponent);
             cond       = satcur * evd / vte;
         current    = satcur * (evd - 1) + cond * (voltage - max_exponent * vte);
      }
      else if (voltage >= -3 * vte)
      {
         double evd = exp( voltage / vte );
         current    = satcur * (evd - 1) + CKTgmin * voltage;
         cond       = satcur * evd / vte + CKTgmin;
      }
      else if(voltage >= -v23)
      {
         double arg = 3 * vte / (voltage * CONSTe);
         arg        = arg * arg * arg;
         current    = -1. * satcur * (1 + arg) + CKTgmin * voltage;
         cond       = satcur * 3 * arg / voltage + CKTgmin;
      }
      else
          {
                  double vr = -( v23 + voltage );
                  if (vr > max_exponent * vte)
                  {
              double evd = exp( max_exponent);
                  cond       = satcur * evd / vte;
              current    = -1. * (satcur * (evd - 1) + cond * (vr - max_exponent * vte));
                  }
              else
                  {
             double evrev = exp( vr / vte );
             current      = -1. * satcur * evrev + CKTgmin * voltage;
             cond         = satcur * evrev / vte + CKTgmin;
                  }
          }
   }
   else
   {
           current = 0.;
           cond = 0.;
   }
} */

      if (satcur > 1.0e-101) then
          vte := Spice3.Repository.SpiceConstants.CONSTKoverQ*temp*ncoeff;
        max_exponent := Modelica.Math.log( max_current / satcur);
        max_exponent := min( max_exp, max_exponent);
        if (voltage >= max_exponent * vte) then
          evd     := exp( max_exponent);
          cond    := satcur * evd / vte;
          current := satcur * (evd - 1) + cond * (voltage - max_exponent * vte);
        elseif (voltage >= -3 * vte) then
          evd     := exp( voltage / vte);
            current := satcur*(evd - 1) + Spice3.Repository.SpiceConstants.CKTgmin
              *voltage;
            cond := satcur*evd/vte + Spice3.Repository.SpiceConstants.CKTgmin;
        elseif (voltage >= -v23) then
            arg := 3*vte/(voltage*Spice3.Repository.SpiceConstants.CONSTe);
          arg     := arg * arg * arg;
            current := -1.*satcur*(1 + arg) + Spice3.Repository.SpiceConstants.CKTgmin
              *voltage;
            cond := satcur*3*arg/voltage + Spice3.Repository.SpiceConstants.CKTgmin;
        else
          vr := -( v23 + voltage);
          if (vr > max_exponent * vte) then
            evd     := exp( max_exponent);
            cond    := satcur * evd / vte;
            current := -1. * (satcur * (evd - 1) + cond * (vr - max_exponent * vte));
          else
            evrev   := exp( vr / vte);
              current := -1.*satcur*evrev + Spice3.Repository.SpiceConstants.CKTgmin
                *voltage;
              cond := satcur*evrev/vte + Spice3.Repository.SpiceConstants.CKTgmin;
          end if;
        end if;
      else
        current := 0.0;
        cond    := 0.0;
      end if;

    end Junction3;

    function JunctionCapTransTime
    /* void Model::JunctionCapTransTime(
   double& capout, double& charge,
   const double& capin,
   const double& voltage, const double& depcap, const double& mj,
   const double& phij, const double& f1, const double& f2, const double& f3,
   const double& transittime, const double& conduct, const double& current) */

      input Real capin;
      input Real voltage;
      input Real depcap;
      input Real mj;
      input Real phij;
      input Real f1;
      input Real f2;
      input Real f3;
      input Real transittime;
      input Real conduct;
      input Real current;

      output Real capout;
      output Real charge;

    algorithm
    /* {
   JunctionCap( capout, charge, capin, voltage, depcap, mj, phij, f1, f2, f3);
   capout += transittime * conduct;
   charge += transittime * current;
} */

        (capout,charge) := Spice3.Repository.Equation.JunctionCap(
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

    end JunctionCapTransTime;

    function Junction2
    /* void Model::Junction2(
   double& current, double& cond,
   const double& voltage, const double& temp, const double& ncoeff,
   const double& satcur) */

      input Real voltage;
      input Real temp;
      input Real ncoeff;
      input Real satcur;

      output Real current;
      output Real cond;
      output Real guck1;

      protected
      constant Real max_exp = 50.0;
      constant Real max_current = 1.0e4;
      Real vte;
      Real max_exponent;
      Real evd;
      Real arg;

    algorithm
    /*{
   if (satcur > 1e-101)
   {
      double vte          = CONSTKoverQ * temp * ncoeff;
      double max_exponent = log( max_current / satcur);
          max_exponent = F_Min( max_exp, max_exponent);
      if (voltage >= max_exponent * vte)
          {
         double evd = exp( max_exponent);
         cond       = satcur * evd / vte;
             current    = satcur * (evd - 1) + cond * (voltage - max_exponent * vte);
          }
          else if (voltage >= -5 * vte)
          {
         double evd = exp( voltage / vte);
         current    = satcur * (evd - 1) + CKTgmin * voltage;
         cond       = satcur * evd / vte + CKTgmin;
          }
      else
          {
         double arg = 3 * vte / (voltage * CONSTe);
         arg        = arg * arg * arg;
         current    = -1 * satcur * (1 + arg) + CKTgmin * voltage;
         cond       = satcur * 3 * arg / voltage + CKTgmin;
          }
   }
   else
   {
           current = 0.;
           cond = 0.;
   }
} */

      if (satcur > 1.0e-101) then
          vte := Spice3.Repository.SpiceConstants.CONSTKoverQ*temp*ncoeff;
        max_exponent := Modelica.Math.log( max_current / satcur);
        max_exponent := min( max_exp, max_exponent);
        if (voltage >= max_exponent * vte) then
          evd     := exp( max_exponent);
          cond    := satcur * evd / vte;
          current := satcur * (evd - 1) + cond * (voltage - max_exponent * vte);
          guck1:=temp;                                                              //EDIT by K.Majetta
        elseif (voltage >= -5 * vte) then
          evd     := exp( voltage / vte);
            current := satcur*(evd - 1) + Spice3.Repository.SpiceConstants.CKTgmin
              *voltage;
            cond := satcur*evd/vte + Spice3.Repository.SpiceConstants.CKTgmin;
        else
            arg := 3*vte/(voltage*Spice3.Repository.SpiceConstants.CONSTe);
          arg     := arg * arg * arg;
            current := -1*satcur*(1 + arg) + Spice3.Repository.SpiceConstants.CKTgmin
              *voltage;
            cond := satcur*3*arg/voltage + Spice3.Repository.SpiceConstants.CKTgmin;
        end if;
      else
        current := 0.0;
        cond    := 0.0;
      end if;

    end Junction2;

    function RESdepTemp
     /*
double Model::RESdepTemp(
   double& dCond_dTemp,
   const double& resist, const double& temp, const double& tnom,
   const double& tc1, const double& tc2) const
{
   double difference = temp - tnom;
   double factor     = 1.0 + tc1 * difference + tc2 * difference * difference;
   double conduct    = 1.0 / (resist * factor);
   dCond_dTemp = (tc1 + 2 * tc2 * difference) * conduct * conduct;
   return conduct;
}

*/
    input Real resist;
    input Real temp;
    input Real tnom;
    input Real tc1;
    input Real tc2;

    output Real conduct;
    output Real dCond_dTemp;

      protected
      Real difference;
      Real factor;

    algorithm
      difference := temp - tnom;
      factor := 1.0 + tc1 * difference + tc2 * difference * difference;
      conduct := 1.0 /(resist * factor);
      dCond_dTemp := (tc1 + 2 * tc2 * difference) * conduct * conduct;
    end RESdepTemp;

    function ResDepGeom
    /*double Model::ResDepGeom(
   const double& rsh,
   const double& width, const double& length, const double& narrow)
{
#ifdef SML_DEBUG
//    if (m_bEquationDebug)
//    cout << "   ResDepGeom: rsh=" << rsh << ", w=" << width << ", l="
//         << length << ", narrow=" << narrow << ", -> R="
//         << rsh * (length - narrow) / (width - narrow) << "\n";
#endif
   return rsh * (length - narrow) / (width - narrow);
}*/

    input Real rsh;
    input Real width;
    input Real length;
    input Real narrow;

    output Real out;

    algorithm
      out :=rsh*(length - narrow)/(width - narrow);
    end ResDepGeom;
  end Equation;

    package SpiceRoot

      record SPICEcircuitCONST
        /* aus SpiceRoot.h uebernommen */
        // assuming silicon - make definition for epsilon of silicon

         constant Real EPSSIL =     (11.7 * 8.854214871e-12);
         constant Real EPSOX =      3.453133e-11;
         constant Real CHARGE =     (1.6021918e-19);
        constant Real CONSTCtoK =  (273.15);
         constant Real CONSTboltz = (1.3806226e-23);
        constant Real REFTEMP =    300.15;  /* 27 degrees C */

        /*SPICEcircuitConst::SPICEcircuitConst()
  // assign again - there are compilers that produce errors otherways
  CONSTroot2 = sqrt(2.0);
  CONSTe     = exp((double)1.0);
  double SPICEcircuitConst::CONSTroot2 = sqrt(2.0);
  double SPICEcircuitConst::CONSTvt0 = CONSTboltz * (27 */
                                                                /* deg c */
                                                                           /* + CONSTCtoK ) / CHARGE;
  double SPICEcircuitConst::CONSTKoverQ = CONSTboltz / CHARGE;
  double SPICEcircuitConst::CONSTe = ::exp((double)1.0);

  // options
  double SPICEcircuitConst::CKTgmin         = 1e-12;
  double SPICEcircuitConst::CKTnomTemp      = 300.15;
  double SPICEcircuitConst::CKTtemp         = 300.15;
  double SPICEcircuitConst::CKTdefaultMosAD = 0.0;
  double SPICEcircuitConst::CKTdefaultMosAS = 0.0;
  double SPICEcircuitConst::CKTdefaultMosL  = 100e-6;
  double SPICEcircuitConst::CKTdefaultMosW  = 100e-6;
  double SPICEcircuitConst::CKTreltol       = 1e-10;  // changed: was 1e-3
  double SPICEcircuitConst::CKTabstol       = 1e-15;  // changed: was 1e-12
  double SPICEcircuitConst::CKTvolttol      = 1e-10; // changed: was 1e-6
  double SPICEcircuitConst::CKTtemptol      = 1e-3; // changed: was 1e-6
  bool   SPICEcircuitConst::CKTtryToCompact = false;
  bool   SPICEcircuitConst::CKTbadMOS3      = false;

  // tran parameters
  double SPICEcircuitConst::TRANtstep     = 1e-9;
  double SPICEcircuitConst::TRANtstop     = 1;
  double SPICEcircuitConst::TRANtstart    = 0;
  double SPICEcircuitConst::TRANtmax      = 1e-9;
  bool SPICEcircuitConst::TRANuseinitcond = false;  */

        /* SPICEcircuitConst::SPICEcircuitConst() */

        constant Real CONSTroot2 =  sqrt(2.0);
        constant Real CONSTvt0 =    CONSTboltz * (27 + CONSTCtoK)  / CHARGE; // deg c
        constant Real CONSTKoverQ = CONSTboltz / CHARGE;
        constant Real CONSTe =      exp(1.0);

        // options

        constant Real CKTgmin =         1e-12;
        constant Real CKTnomTemp =      300.15;
        constant Real CKTtemp =         300.15;
        constant Real CKTdefaultMosAD = 0.0;
        constant Real CKTdefaultMosAS = 0.0;
        constant Real CKTdefaultMosL =  1.0e-4;
        constant Real CKTdefaultMosW =  1.0e-4;
        constant Real CKTreltol =       1e-10;
        constant Real CKTabstol =       1e-15;
        constant Real CKTvolttol =      1e-10;
        constant Real CKTtemptol =      1e-3;

      end SPICEcircuitCONST;

      record SpiceRoot

      /* bool SpiceRoot::m_bInit         = false;
bool SpiceRoot::m_bDC           = false;
#ifdef DEMO
int SpiceRoot::m_nNumberOfInstances = 0;
#endif

SpiceRoot::SpiceRoot() :
#ifdef SML_DEBUG
        m_nCallCount( 0), m_nCalcCount( 0),
        m_bInOutDebug( false), m_bJacobiDebug( false),
        m_bStructureDebug( false), m_bHistoryDebug( false),
        m_bEquationDebug( false),
        m_bAnyDebug( false),                        // von Herrn Leitner voreingestellter Wert!!!
                m_bAskForCont( false),
        m_bParamDebug( true),                        // Slz, 17.04. 2002
        m_dDebugEnd( 1e38),m_dDebugStart( 0.),
                m_pStream( NULL),
#endif
        m_nNoOfNode( 0), m_nLastExternNode( 0),
        m_pVoltageValues( NULL),
        m_pCurrentValues( NULL), m_pResJacobi( NULL), m_pCapJacobi( NULL),
#ifndef NO_HISTORY
        m_pHistoryTimes( NULL), m_pHistoryValues( NULL),
        m_nNumberOfHistoryValues( 0), m_nNumberOfHistoryTimePoints( 0),
        m_dHistorySize( 0.), m_nHistoryBlockSize( 5), m_bHistoryByTime( false),
        m_bHistoryAllValues( false),
#endif
        m_bFirstCalc( true)
{
#ifdef DEMO
   if (++m_nNumberOfInstances > 10)
      throw DemoException();
#endif }  */

      //  Boolean m_bInit(            start = false);
      //  Integer m_nNoOfNode(        start = 0);
      //  Real[6] m_pVoltageValues(   start = zeros(6));
      //  Real[6] m_pVoltageValuesDot(start = zeros(6));
        Real[6] m_pCurrentValues(   start = zeros(6));
        Real[36] m_pResJacobi(      start = zeros(36));
        Real[36] m_pCapJacobi(      start = zeros(36));
      //  Integer m_nLastExternNode = 0;
      //  Boolean m_bDC =   false;
      //  Boolean m_bFirstCalc = true;

      end SpiceRoot;

      function UseInitialConditions
      /* virtual bool UseInitialConditions() const { return false; }; */

        output Boolean ret;

      algorithm
        ret := false;

      end UseInitialConditions;

      function InitJunctionVoltages
      /* virtual bool InitJunctionVoltages() const { return false; }; */

        output Boolean ret;
      algorithm

        ret := false;

      end InitJunctionVoltages;

      function LimitJunctionVoltage
      /* double SpiceRoot::LimitJunctionVoltage(
   const double& voltage, const double& vt,
   const double& vcrit,
   const bool& backwardleading, const double& bv)*/

        input Real voltage;

        output Real ret;

      algorithm
      /*{return voltage;} */

        ret := voltage;

      end LimitJunctionVoltage;
    end SpiceRoot;

    package Model

    record Model
    /* Model::Model( const String& modelname, const String& elemname)
        : m_dTemp( CKTnomTemp ), m_sModelName( modelname),
          m_sElementName( elemname),
          m_pNodeNumber( NULL),
          m_bCalcTemp( false), m_bSetup( false),
          m_pDotModel( NULL),
          m_nNumberOfVoltageSource( 1), m_nNumberOfInductances( 1),
          m_pParameters( NULL), m_pValues( NULL),
          m_pLevelValue( NULL), m_bNeedLevelFirst( false)
{
   m_sModelName.to_upper();
   AddParameter( "TEMP", m_dTemp, CKTnomTemp)->SetOffset( CONSTCtoK);// Device Temperature
} */

    //  Integer m_pNodeNumber = 0;
    //  Boolean m_bCalcTemp( start = false);
    //  Boolean m_bSetup =      false;

      Real m_dTemp( start = SpiceRoot.SPICEcircuitCONST.CKTnomTemp); // TEMP, Device Temperature
    end Model;

    end Model;

    package Mosfet
      record Mosfet
        extends Model.Model;
      /*      Mosfet_Model_Line* m_pModel;
      double m_len;                   // the length of the channel region
      Value *m_lenValue;
      double m_width;                   // the width of the channel region
      Value *m_widthValue;
      double m_drainArea;           // the area of the drain diffusion
      Value *m_drainAreaValue;
      double m_sourceArea;          // the area of the source diffusion
      Value *m_sourceAreaValue;
      double m_drainSquares;        // the length of the drain in squares
      Value *m_drainSquaresValue;
      double m_sourceSquares;       // the length of the source in squares
      Value *m_sourceSquaresValue;
      double m_drainPerimiter;
      Value *m_drainPerimiterValue;
      double m_sourcePerimiter;
      Value *m_sourcePerimiterValue;
      bool m_off;  // non-zero to indicate device is off for dc analysis
      double m_dICVDS;
      Value* m_ICVDSValue;
      double m_dICVGS;
      Value* m_ICVGSValue;
      double m_dICVBS;
      Value* m_ICVBSValue;
   private:
      MosfetCalc* m_pCalculation;
      bool   m_bNMOS;
      Value* m_pNMOSValue;
      bool   m_bPMOS;
      Value* m_pPMOSValue;
      int    m_nLevel; */

        /* param_sub_section: General Mosfet Parameters */
      //  Real m_len(             start = SpiceRoot.SPICEcircuitCONST.CKTdefaultMosL);  // L, length of channel region
        Real m_len(             start = 1e-4);  // L, length of channel region
      //  Real m_width(           start = SpiceRoot.SPICEcircuitCONST.CKTdefaultMosW);  // W, width of channel region
        Real m_width(           start = 1e-4);  // W, width of channel region
        Real m_drainArea(       start = SpiceRoot.SPICEcircuitCONST.CKTdefaultMosAD); // AD, area of drain diffusion
        Real m_sourceArea(      start = SpiceRoot.SPICEcircuitCONST.CKTdefaultMosAS); // AS, area of source diffusion
        Real m_drainSquares(    start = 1.0);                               // NRD, length of drain in squares
        Real m_sourceSquares(   start = 1.0);                               // NRS, length of source in squares
        Real m_drainPerimiter(  start = 0.0);                               // PD, Drain perimeter;
        Real m_sourcePerimiter( start = 0.0);                               // PS, Source perimeter
        Real m_dICVDS(          start = 0.0);                               // IC_VDS, Initial D-S voltage;
        Real m_dICVDSIsGiven;
        Real m_dICVGS(          start = 0.0);                               // IC_VGS, Initial G-S voltage;
        Real m_dICVGSIsGiven;
        Real m_dICVBS(          start = 0.0);                               // IC_VBS, Initial B-S voltage;
        Real m_dICVBSIsGiven;
        Real m_off(          start = 0);    // Device initially off  // non-zero to indicate device is off for dc analysis
        Real m_bPMOS(        start = 0);    // P type MOSfet model
        Integer m_nLevel(       start = 1);

      //  Real m_lenValue =             m_len;
      //  Real m_widthValue =           m_width;
      //  Real m_drainAreaValue =       m_drainArea;
      //  Real m_sourceAreaValue =      m_sourceArea;
      //  Real m_drainSquaresValue =    m_drainSquares;
      //  Real m_sourceSquaresValue =   m_sourceSquares;
      //  Real m_drainPerimiterValue =  m_drainPerimiter;
      //  Real m_sourcePerimiterValue = m_sourcePerimiter;
      //  Real m_ICVDSValue =           m_dICVDS;
      //  Real m_ICVGSValue =           m_dICVGS;
      //  Real m_ICVBSValue =           m_dICVBS;
      //  Boolean m_bNMOS =       true;          // N type MOSfet model
      //  Boolean m_pNMOSValue =  m_bNMOS;
      //  Boolean m_pPMOSValue =  m_bPMOS;
      //  Integer m_pLevel =      1;             // Level
      //  Integer m_nLevelValue = m_pLevel;      // Level

      /* Mosfet::Mosfet( const String& elementname)
         : Model( "MOSFET", elementname), m_pModel( NULL)
{
   // param_sub_section: General Mosfet Parameters
   m_lenValue   = AddParameter( "L", m_len, CKTdefaultMosL);  // length
   m_widthValue = AddParameter( "W", m_width, CKTdefaultMosW);  // width
   m_drainAreaValue       = AddParameter( "AD", m_drainArea, CKTdefaultMosAD);  // Drain area
   m_sourceAreaValue      = AddParameter( "AS", m_sourceArea, CKTdefaultMosAS);  // Source Area
   m_drainPerimiterValue  = AddParameter( "PD", m_drainPerimiter, 0.0);  // Drain perimeter
   m_sourcePerimiterValue = AddParameter( "PS", m_sourcePerimiter, 0.0);  // Source perimeter
   m_drainSquaresValue    = AddParameter( "NRD", m_drainSquares, 1.0);  // Drain squares
   m_sourceSquaresValue   = AddParameter( "NRS", m_sourceSquares, 1.0); // Source squares

   m_ICVDSValue = AddParameter( "IC_VDS", m_dICVDS, 0.0)->Alias( "IC_1")->Alias( "IC"); // Initial D-S voltage
   m_ICVGSValue = AddParameter( "IC_VGS", m_dICVGS, 0.0)->Alias( "IC_2"); // Initial G-S voltage
   m_ICVBSValue = AddParameter( "IC_VBS", m_dICVBS, 0.0)->Alias( "IC_3"); // Initial B-S voltage

   AddParameter( "OFF", m_off, false); // Device initially off

   m_pNMOSValue = AddParameter( "NMOS", m_bNMOS, true); // N type MOSfet model
   m_pPMOSValue = AddParameter( "PMOS", m_bPMOS, false); // P type MOSfet model
   m_pLevelValue = new IntValue( *this, "LEVEL", m_nLevel, 1, false); //
   m_pCalculation = NULL;
*/

      end Mosfet;

      record MosfetModelLineParams
       //  extends SpiceRoot.SPICEcircuitCONST;
      /*    double m_jctSatCurDensity;    // input - use tSatCurDens
        double m_sheetResistance;
        double m_bulkJctPotential;    // input - use tBulkPot
        double m_bulkJctBotGradingCoeff;
        double m_bulkJctSideGradingCoeff;
        double m_oxideThickness;       // unit: micron
        double m_gateSourceOverlapCapFactor;
        double m_gateDrainOverlapCapFactor;
        double m_gateBulkOverlapCapFactor;
        double m_fNcoef;
        double m_fNexp;
        Value* m_oxideThicknessValue;
        Value* m_mjswValue;
        Value* m_pbValue;
        Value* m_cgsoValue;
        Value* m_cgdoValue;
        Value* m_cgboValue;
        Mosfet_Model_Line* m_pModel;*/

         Real m_jctSatCurDensity(           start = 0.0); // JS, Bulk jct. sat. current density, input - use tSatCurDens
         Real m_sheetResistance(            start = 0.0); // RSH, Sheet resistance
         Real m_bulkJctPotential(           start = 0.8); // PB, Bulk junction potential, input - use tBulkPot
         Real m_bulkJctBotGradingCoeff(     start = 0.5); // MJ, Bottom grading coefficient
         Real m_bulkJctSideGradingCoeff(    start = 0.5); // MJSW, Side grading coefficient;
         Real m_oxideThickness(             start = 1.0e-7); // TOX, Oxide thickness unit: micron
         Real m_oxideThicknessIsGiven;
         Real m_gateSourceOverlapCapFactor( start= 0.0); // CGS0, Gate-source overlap cap
         Real m_gateDrainOverlapCapFactor( start= 0.0); // CGD0, Gate-drain overlap cap
         Real m_gateBulkOverlapCapFactor( start= 0.0); // CGB0, Gate-bulk overlap cap
         Real m_fNcoef(                     start = 0.0); // KF, Flicker noise coefficient
         Real m_fNexp(                      start = 1.0); // AF, Flicker noise exponent

      //  Real m_oxideThicknessValue = m_oxideThickness;   // TOX, Oxide thickness
      //  Real m_mjswValue = m_bulkJctSideGradingCoeff;    // Side grading coefficient
      //  Real m_pbValue =   m_bulkJctPotential;           // Bulk junction potential
      //  Real m_cgsoValue = m_gateSourceOverlapCapFactor; // CGS0, Gate-source overlap cap
      //  Real m_cgdoValue = m_gateDrainOverlapCapFactor;  // CGD0, Gate-drain overlap cap
      //  Real m_cgboValue = m_gateBulkOverlapCapFactor;   // CGB0, Gate-bulk overlap cap

      /*MosfetModelLineParams::MosfetModelLineParams( Mosfet_Model_Line* model)
        : SPICEcircuitConst(),
          m_pModel( model)
  {
   */
         /* param_sub_section: General Mosfet Parameters */
                                                           /*
     m_pModel->AddParameter( "RSH", m_sheetResistance, 0.0); // Sheet resistance
     m_oxideThicknessValue = m_pModel->AddParameter( "TOX", m_oxideThickness, 0.0); // Oxide thickness
     m_pModel->AddParameter( "JS", m_jctSatCurDensity, 0.0); // Bulk jct. sat. current density
     m_pbValue = m_pModel->AddParameter( "PB", m_bulkJctPotential, .8);  // Bulk junction potential
     m_pModel->AddParameter( "MJ", m_bulkJctBotGradingCoeff, .5); // Bottom grading coefficient
     m_mjswValue = m_pModel->AddParameter( "MJSW", m_bulkJctSideGradingCoeff, .5); // Side grading coefficient
     m_cgsoValue = m_pModel->AddParameter( "CGSO", m_gateSourceOverlapCapFactor, 0.)->Alias( "CGS0"); // Gate-source overlap cap.
     m_cgdoValue = m_pModel->AddParameter( "CGDO", m_gateDrainOverlapCapFactor, 0.)->Alias( "CGD0");// Gate-drain overlap cap
     m_cgboValue = m_pModel->AddParameter( "CGBO", m_gateBulkOverlapCapFactor, 0.)->Alias( "CGB0");// Gate-bulk overlap cap.
     m_pModel->AddParameter( "KF", m_fNcoef, 0.0); // Flicker noise coefficient
     m_pModel->AddParameter( "AF", m_fNexp, 1.0);  // Flicker noise exponent

     m_gateDrainOverlapCapFactor  = 0.0;
     m_gateSourceOverlapCapFactor = 0.0;
     m_gateBulkOverlapCapFactor   = 0.0;
  }*/

      end MosfetModelLineParams;

      record Mosfet_Model_Line
        /*
     Mosfet_Model_Line::Mosfet_Model_Line(
       int    m_nLevel;
       int    m_type;                    // device type : 1 = n,  -1 = p
       bool   m_bNMOS;
       bool   m_bPMOS;
       AddParameter( "NMOS", m_bNMOS, true);  // N type MOSfet model
       AddParameter( "PMOS", m_bPMOS, false); // P type MOSfet model
       m_pLevelValue = AddParameter( "LEVEL", m_nLevel, 1); //
       m_bNeedLevelFirst = true;
  */
        Integer m_type(   start = 1);     // device type : 1 = n,  -1 = p

      end Mosfet_Model_Line;

      record MosfetCalc
      /*MosfetCalc::MosfetCalc(
   Mosfet* device, Mosfet_Model_Line* model, const MosfetModelLineParams* params)
        : m_pDevice( device), m_pModel( model), m_pParameters( params)
{
   m_pDevice->AddValue( "Vds", m_vds);   // Drain-Source voltage
   m_pDevice->AddValue( "Vgs", m_vgs);   // Gate-Source voltage
   m_pDevice->AddValue( "Vbs", m_vbs);   // Bulk-Source voltage
   m_pDevice->AddValue( "Ibs", m_cbs);   // B-S junction current
   m_pDevice->AddValue( "Gbs", m_gbs);   // Bulk-Source conductance
   m_pDevice->AddValue( "Ibd", m_cbd);   // B-D junction current
   m_pDevice->AddValue( "Gbd", m_gbd);   // Bulk-Drain conductance
   m_pDevice->AddValue( "Ids", m_cdrain);//
   m_pDevice->AddValue( "Gds", m_gds);   // Drain-Source conductance
   m_pDevice->AddValue( "Gm", m_gm);     // Transconductance
   m_pDevice->AddValue( "Gmbs", m_gmbs); // Bulk-Source transconductance
   m_pDevice->AddValue( "Cbsb", m_capbsb);
   m_pDevice->AddValue( "Qbsb", m_chargebsb);
   m_pDevice->AddValue( "Cbss", m_capbss);
   m_pDevice->AddValue( "Qbss", m_chargebss);
   m_pDevice->AddValue( "Cbdb", m_capbdb);
   m_pDevice->AddValue( "Qbdb", m_chargebdb);
   m_pDevice->AddValue( "Cbds", m_capbds);
   m_pDevice->AddValue( "Qbds", m_chargebds);
   m_pDevice->AddValue( "Gs", m_sourceConductance);
   m_pDevice->AddValue( "Gd", m_drainConductance);
   m_pDevice->AddValue( "Beta", m_Beta);
   m_pDevice->AddValue( "Cgso", m_capGSovl);// Gate-source overlap cap.
   m_pDevice->AddValue( "Cgdo", m_capGDovl);// Gate-drain overlap cap
   m_pDevice->AddValue( "Cgbo", m_capGBovl);// Gate-bulk overlap cap.
   m_pDevice->AddValue( "Cox", m_capOx);
   m_pDevice->AddValue( "Von", m_von); // Turn-on voltage
   m_pDevice->AddValue( "Vdsat", m_vdsat);
   m_pDevice->AddValue( "Mode", m_mode);
   m_mode = 1;
}*/

        Real m_vds;               // Vds,  Drain-Source voltage
        Real m_vgs;               // Vgs, Gate-Source voltage
        Real m_vbs;               // Vbs, Bulk-Source voltage
        Real m_cbs;               // Ibs, B-S junction current
        Real m_gbs;               // Gbs, Bulk-Source conductance
        Real m_cbd;               // Ibd, B-D junction current
        Real m_gbd;               // Gbd, Bulk-Drain conductance
        Real m_cdrain;            // Ids
        Real m_gds;               // Gds, Drain-Source conductance
        Real m_gm;                // Gm, Transconductance
        Real m_gmbs;              // Gmbs, Bulk-Source transconductance
        Real m_capbsb;            // Cbsb
        Real m_chargebsb;         // Qbsb
        Real m_capbss;            // Cbss
        Real m_chargebss;         // Qbss
        Real m_capbdb;            // Cbdb
        Real m_chargebdb;         // Qbdb
        Real m_capbds;            // Cbds
        Real m_chargebds;         // Qbds
        Real m_sourceResistance;  // Rs
        Real m_drainResistance;   // Rd
        //Real m_sourceConductance; //Gs
        //Real m_drainConductance;  //Gd
        Real m_Beta;              // Beta
        Real m_capGSovl;          // Cgso, Gate-source overlap cap.
        Real m_capGDovl;          // Cgdo, Gate-drain overlap cap
        Real m_capGBovl;          // Cgbo, Gate-bulk overlap cap.
        Real m_capOx;             // Cox
        Real m_von;               // Von, Turn-on voltage
        Real m_vdsat;             // Vdsat
        Integer m_mode(start = 1);// Mode

        Real m_lEff;

      /*      double m_sourceConductance;   //conductance of source(or 0):set in setup
      double m_drainConductance;    //conductance of drain(or 0):set in setup
      int m_mode;               // device mode : 1 = normal, -1 = inverse
      double m_Beta;
      double m_lEff;
      double m_capGSovl;
      double m_capGDovl;
      double m_capGBovl;
      double m_capOx;
      double m_von;
      double m_vdsat;

      double m_vds;
      double m_vgs;
      double m_vbs;
      double m_cbs;
      double m_gbs;
      double m_cbd;
      double m_gbd;
      double m_gds;
      double m_gm;
      double m_gmbs;
      double m_cdrain;
      double m_capbsb;
      double m_chargebsb;
      double m_capbss;
      double m_chargebss;
      double m_capbdb;
      double m_chargebdb;
      double m_capbds;
      double m_chargebds;  */

      end MosfetCalc;

      function MosfetInitEquations
      /* void Mosfet::InitEquations() */

        input Mosfet in_m;

        output Mosfet out_m;

      algorithm
        out_m := in_m;
      /*{if (!m_pModel)
   {
      DefineDotModel();
      m_pModel->Init();
   }
   if (!m_pCalculation)
      SetDotModel( m_pModel, true);
   if (m_drainSquares  == 0)
      m_drainSquares  = 1.;
   if (m_sourceSquares == 0)
      m_sourceSquares = 1.;
   m_pCalculation->InitEquations();
  }  */

        if (out_m.m_drainSquares == 0) then
          out_m.m_drainSquares  := 1.;
        end if;
        if (out_m.m_sourceSquares == 0) then
          out_m.m_sourceSquares := 1.;
        end if;

      end MosfetInitEquations;

      function Mosfet_Model_LineInitEquations
      /* void Mosfet_Model_Line::InitEquations() */

        input Mosfet in_m;

        output Mosfet_Model_Line out_ml;

      algorithm
      /*{m_type = m_bPMOS ? PMOS : NMOS;
   GetParameterPtr()->InitEquations();
  } */

        out_ml.m_type := if (in_m.m_bPMOS > 0.5) then -1 else 1;
        // -1: PMOS ; 1: NMOS

      end Mosfet_Model_LineInitEquations;

      function GetNumberOfElectricalPins
      /* virtual int GetNumberOfElectricalPins() const { return 4; }; */

        output Integer ret;

      algorithm
        ret := 4;
      end GetNumberOfElectricalPins;

    end Mosfet;

    package Mos

      record MosModelLineParams
        extends Mosfet.MosfetModelLineParams;

      /* class MosModelLineParams : public MosfetModelLineParams
{
   protected:
      double m_oxideCapFactor;
      double m_vt0;                 // input - use tVto
      double m_capBD;                   // input - use tCbd
      double m_capBS;                   // input - use tCbs
      double m_bulkCapFactor;       // input - use tCj
      double m_sideWallCapFactor;   // input - use tCjsw
      double m_fwdCapDepCoeff;
      double m_phi;                 // input - use tPhi
      double m_gamma;
      double m_lambda;
      double m_substrateDoping;
      double m_gateType;
      double m_surfaceStateDensity;
      double m_surfaceMobility;     // input - use tSurfMob
      double m_latDiff;
      double m_jctSatCur;           // input - use tSatCur
      double m_drainResistance;
      double m_sourceResistance;
      double m_transconductance;    // input - use tTransconductance
      double m_tnom;                // temperature at which parameters measured

      Value* m_jctSatCurValue;
      Value* m_drainResistanceValue;
      Value* m_sourceResistanceValue;
      Value* m_transconductanceValue;
      Value* m_vt0Value;
      Value* m_capBDValue;
      Value* m_capBSValue;
      Value* m_bulkCapFactorValue;
      Value* m_phiValue;
      Value* m_gammaValue;
      Value* m_substrateDopingValue;
      Value* m_gateTypeValue;
      Value* m_surfaceStateDensityValue;
      Value* m_surfaceMobilityValue;
      Value* m_sideWallCapFactorValue;
      Value* m_tnomValue;
};*/

         Real m_oxideCapFactor(      start = 0.0);
         Real m_vt0(                 start = 0.0);    // VTO, Threshold voltage           // input - use tVto
         Real m_vtOIsGiven;
         Real m_capBD(               start = 0.0);    // CBD, B-D junction capacitance    // input - use tCbd
         Real m_capBDIsGiven;
         Real m_capBS(               start = 0.0);    // CBS, B-S junction capacitance    // input - use tCbs
         Real m_capBSIsGiven;
         Real m_bulkCapFactor(       start = 0.0);    // CJ, Bottom junction cap per area // input - use tCj
         Real m_bulkCapFactorIsGiven;
         Real m_sideWallCapFactor(   start = 0.0);    // CJSW, Side grading coefficient   // input - use tCjsw
         Real m_fwdCapDepCoeff(      start = 0.5);    // FC, Forward bias jct. fit parm.
         Real m_phi(                 start = 0.6);    // PHI, Surface potential           // input - use tPhi
         Real m_phiIsGiven;
         Real m_gamma(               start = 0.0);    // GAMMA, Bulk threshold parameter
         Real m_gammaIsGiven;
         Real m_lambda;
         Real m_substrateDoping(     start = 0.0);    // NSUB, Substrate doping
         Real m_substrateDopingIsGiven;
         Real m_gateType(            start = 1.0);    // TPG, Gate type
         Real m_surfaceStateDensity( start = 0.0);    // NSS, Gate type
         Real m_surfaceMobility(     start = 600.0);  // UO, Surface mobility             // input - use tSurfMob
         Real m_latDiff(             start = 0.0);    // LD, Lateral diffusion
         Real m_jctSatCur(           start = 1.0e-14);// IS, Bulk junction sat. current   // input - use tSatCur
         Real m_drainResistance(     start = 0);      // RD, Drain ohmic resistance
         Real m_drainResistanceIsGiven;
         Real m_sourceResistance(    start = 0);      // RS, Source ohmic resistance
         Real m_sourceResistanceIsGiven;
         Real m_transconductance;                     // input - use tTransconductance
         Real m_transconductanceIsGiven;
         Real m_tnom(                start=SpiceConstants.CKTnomTemp);                        // TNOM, Parameter measurement temperature

      //  Real m_jctSatCurValue =           m_jctSatCur;           // IS, Bulk junction sat. current
      //  Real m_drainResistanceValue =     m_drainResistance;     // RD, Drain ohmic resistance
      //  Real m_sourceResistanceValue =    m_sourceResistance;    // RS, Source ohmic resistance
      //  Real m_transconductanceValue;
      //  Real m_vt0Value =                 m_vt0;                 // VTO, Threshold voltage
      //  Real m_capBDValue =               m_capBD;               // CBD, B-D junction capacitance
      //  Real m_capBSValue =               m_capBS;               // CBS, B-S junction capacitance
      //  Real m_bulkCapFactorValue =       m_bulkCapFactor;       // CJ, Bottom junction cap per area
      //  Real m_phiValue =                 m_phi;                 // PHI, Surface potential
      //  Real m_gammaValue =               m_gamma;               // GAMMA, Bulk threshold parameter
      //  Real m_substrateDopingValue =     m_substrateDoping;     // NSUB, Substrate doping
      //  Real m_gateTypeValue =            m_gateType;            // TPG, Gate type
      //  Real m_surfaceStateDensityValue = m_surfaceStateDensity; // NSS, Gate type
      //  Real m_surfaceMobilityValue =     m_surfaceMobility;     // UO, Surface mobility
      //  Real m_sideWallCapFactorValue =   m_sideWallCapFactor;   // CJSW, Side grading coefficient
      //  Real m_tnomValue =                m_tnom;                // TNOM, Parameter measurement temperature

      /* MosModelLineParams::MosModelLineParams( Mosfet_Model_Line* model)
        : MosfetModelLineParams( model)
{
   m_tnomValue = m_pModel->AddParameter( "TNOM", m_tnom, CKTnomTemp)->SetOffset( CONSTCtoK);   // Parameter measurement temperature
   m_vt0Value = m_pModel->AddParameter( "VTO", m_vt0, 0.0)->Alias( "VT0");                     // Threshold voltage
   m_substrateDopingValue = m_pModel->AddParameter( "NSUB", m_substrateDoping, 0.0);           // Substrate doping
   m_surfaceStateDensityValue = m_pModel->AddParameter( "NSS", m_surfaceStateDensity, 0.0);    // Gate type
   m_pModel->AddParameter( "LD", m_latDiff, 0.0);                                              //Lateral diffusion
   m_jctSatCurValue = m_pModel->AddParameter( "IS", m_jctSatCur, 1e-14);                       // Bulk junction sat. current
   m_gammaValue           = m_pModel->AddParameter( "GAMMA", m_gamma, 0.0);                    // Bulk threshold parameter
   m_surfaceMobilityValue = m_pModel->AddParameter( "UO", m_surfaceMobility, 600.0)->Alias( "U0"); // Surface mobility
   m_gateTypeValue        = m_pModel->AddParameter( "TPG", m_gateType, 1.0);                   // Gate type
   m_drainResistanceValue = m_pModel->AddParameter( "RD", m_drainResistance, 0.0);             // Drain ohmic resistance
   m_sourceResistanceValue = m_pModel->AddParameter( "RS", m_sourceResistance, 0.0);           // Source ohmic resistance

   m_capBDValue = m_pModel->AddParameter( "CBD", m_capBD, 0.0);                                // B-D junction capacitance
   m_capBSValue = m_pModel->AddParameter( "CBS", m_capBS, 0.0);                                // B-S junction capacitance
   m_bulkCapFactorValue = m_pModel->AddParameter( "CJ", m_bulkCapFactor, 0.0);                 // Bottom junction cap per area
   m_sideWallCapFactorValue = m_pModel->AddParameter( "CJSW", m_sideWallCapFactor, 0.0);       // Side grading coefficient
   m_phiValue = m_pModel->AddParameter( "PHI", m_phi, .6);                                     // Surface potential
   m_pModel->AddParameter( "FC", m_fwdCapDepCoeff, .5);                                        // Forward bias jct. fit parm.

   m_oxideCapFactor             = 0.0;
}*/
      end MosModelLineParams;

      record MosModelLineVariables

        Real m_oxideCapFactor;
        Real m_vt0;
        Real m_phi;
        Real m_gamma;
        Real m_transconductance;

      end MosModelLineVariables;

      record MosCalc
        extends Mosfet.MosfetCalc;

      /* MosCalc::MosCalc(
   Mosfet* device, Mosfet_Model_Line* model, const MosModelLineParams* params)
        : MosfetCalc( device, model, params),
          m_pParameters( params)
{
   m_tTransconductance = 0.; // any value ...
   m_tSurfMob          = 0.;
   m_tPhi              = 0.7;
   m_tVto              = 1.;
   m_tSatCurDens       = 0.;
   m_tDrainSatCur      = 0.;
   m_tSourceSatCur     = 0.;
   m_tCBDb             = 0.;
   m_tCBDs             = 0.;
   m_tCBSb             = 0.;
   m_tCBSs             = 0.;
   m_tCj               = 0.;
   m_tCjsw             = 0.;
   m_tBulkPot          = 0.7;
   m_tDepCap           = 0.35;
   m_tVbi              = 1.;
   m_VBScrit           = .7;
   m_VBDcrit           = 0.7;
   m_f1b               = 0.;
   m_f2b               = 0.;
   m_f3b               = 0.;
   m_f1s               = 0.;
   m_f2s               = 0.;
   m_f3s               = 0.;
   m_dVt               = 0.;

   m_capgd = 0.;
   m_capgs = 0.;
   m_capgb = 0.;
   m_qgs = 0.;
   m_qgd = 0.;
   m_qgb = 0.;
}  */

        Real m_tTransconductance( start = 0.); // any value ...
        Real m_tSurfMob( start = 0.);
        Real m_tPhi( start = 0.7);
        Real m_tVto( start = 1.);
        Real m_tSatCurDens( start = 0.);
        Real m_tDrainSatCur( start = 0.);
        Real m_tSourceSatCur( start = 0.);
        Real m_tCBDb( start = 0.);
        Real m_tCBDs( start = 0.);
        Real m_tCBSb( start = 0.);
        Real m_tCBSs( start = 0.);
        Real m_tCj( start = 0.);
        Real m_tCjsw( start = 0.);
        Real m_tBulkPot( start = 0.7);
        Real m_tDepCap( start = 0.35);
        Real m_tVbi( start = 1.);
        Real m_VBScrit( start = 0.7);
        Real m_VBDcrit( start = 0.7);
        Real m_f1b( start = 0.);
        Real m_f2b( start = 0.);
        Real m_f3b( start = 0.);
        Real m_f1s( start = 0.);
        Real m_f2s( start = 0.);
        Real m_f3s( start = 0.);
        Real m_dVt( start = 0.);

        Real m_capgd( start = 0.);
        Real m_capgs( start = 0.);
        Real m_capgb( start = 0.);
        Real m_qgs( start = 0.);
        Real m_qgd( start = 0.);
        Real m_qgb( start = 0.);

      end MosCalc;

      record DEVqmeyer

        Real qm_capgb(  start = 0);
        Real qm_capgs(  start = 0);
        Real qm_capgd(  start = 0);
        Real qm_qgs(  start = 0);
        Real qm_qgb(  start = 0);
        Real qm_qgd(  start = 0);
        Real qm_vgs(  start = 0);
        Real qm_vgb(  start = 0);
        Real qm_vgd(  start = 0);

      end DEVqmeyer;

      record CurrrentsCapacitances

        Real idrain( start = 0);
        Real iBD( start = 0);
        Real iBS( start = 0);
        Real cGS( start = 0);
        Real cGB( start = 0);
        Real cGD( start = 0);
        Real cBS( start = 0);
        Real cBD( start = 0);
        Real m_capgd;          //added by K. Majetta on 080606
        Real test;              //added by K.Majetta on 080821

      end CurrrentsCapacitances;

      function MosCalcInitEquations
      /* void MosCalc::InitEquations() */

        input Mos1.Mos1ModelLineParams in_p;
        input SpiceConstants in_C;
        input Mos.MosModelLineVariables in_vp;
        input Mosfet.Mosfet in_m;

        output Mos1.Mos1Calc out_c;

      algorithm
      /* {if (m_pDevice->m_len - 2 * m_pParameters->m_latDiff <= 0)
      NegativeLEffEx(
         m_pDevice, m_pDevice->m_len - 2 * m_pParameters->m_latDiff).print();*/

      //  if (in_m.m_len - 2 * in_p.m_latDiff <= 0) then
      //    NegativeLEffEx(m_pDevice, m_pDevice->m_len - 2 * m_pParameters->m_latDiff).print();
      //  end if;

      /*
C++   if (m_pParameters->m_drainResistanceValue->IsGiven())
C++   {
C++      if (m_pParameters->m_drainResistance != 0)
C++         m_drainConductance = 1 / m_pParameters->m_drainResistance;
C++   }
C++   else
C++      if (m_pParameters->m_sheetResistance != 0)
C++         m_drainConductance = 1 /
C++            (m_pParameters->m_sheetResistance * m_pDevice->m_drainSquares);*/
      /*
  if (in_p.m_drainResistance > 0) then  // if (in_p.m_drainResistanceValue->IsGiven()) then
    if (in_p.m_drainResistance <> 0) then
      out_c.m_drainConductance := 1 / in_p.m_drainResistance;
    end if;
  else
    if (in_p.m_sheetResistance <> 0) then
      out_c.m_drainConductance := 1 / (in_p.m_sheetResistance * in_m.m_drainSquares);
    end if;
  end if;
*/

         out_c.m_drainResistance := if
                                      (in_p.m_drainResistanceIsGiven > 0.5) then
             in_p.m_drainResistance else
             in_p.m_sheetResistance * in_m.m_drainSquares;

      /*   if (m_pParameters->m_sourceResistanceValue->IsGiven())
C++   {
C++      if (m_pParameters->m_sourceResistance != 0)
C++         m_sourceConductance = 1 / m_pParameters->m_sourceResistance;
C++   }
C++   else if (m_pParameters->m_sheetResistance != 0)
C++      m_sourceConductance =
C++         1 / (m_pParameters->m_sheetResistance * m_pDevice->m_sourceSquares);*/
      /*
  if (in_p.m_sourceResistance > 0) then // if (in_p.m_sourceResistanceValue->IsGiven()) then
    if (in_p.m_sourceResistance <> 0) then
      out_c.m_sourceConductance := 1 / in_p.m_sourceResistance;
    end if;
  elseif (in_p.m_sheetResistance <> 0) then
    out_c.m_sourceConductance := 1 / (in_p.m_sheetResistance * in_m.m_sourceSquares);
  end if;
*/

      out_c.m_sourceResistance := if  (in_p.m_sourceResistanceIsGiven > 0.5) then
             in_p.m_sourceResistance else
             in_p.m_sheetResistance * in_m.m_sourceSquares;

      /*   m_lEff     = m_pDevice->m_len - 2 * m_pParameters->m_latDiff;
   // frank bergmann, 130900
   // abfrage auf zu kleinen wert - setzen auf vernuenftigen
   // brachte probleme bei einsatz unter windows
   if (F_Abs( m_lEff) < 1e-18)
      m_lEff = 1e-6;
   m_capGSovl = m_pParameters->m_gateSourceOverlapCapFactor * m_pDevice->m_width;
   m_capGDovl = m_pParameters->m_gateDrainOverlapCapFactor * m_pDevice->m_width;
   m_capGBovl = m_pParameters->m_gateBulkOverlapCapFactor * m_lEff;
   m_capOx    = m_pParameters->m_oxideCapFactor * m_lEff * m_pDevice->m_width;
   m_pDevice->InitHistory( MOSlastStore);
}  */

        out_c.m_lEff := in_m.m_len - 2 * in_p.m_latDiff;

        if ( abs( out_c.m_lEff) < 1e-18) then
          out_c.m_lEff := 1e-6;
        end if;
        out_c.m_capGSovl := in_p.m_gateSourceOverlapCapFactor * in_m.m_width;
        out_c.m_capGDovl := in_p.m_gateDrainOverlapCapFactor * in_m.m_width;

        out_c.m_capGBovl := in_p.m_gateBulkOverlapCapFactor * out_c.m_lEff;
        out_c.m_capOx    := in_vp.m_oxideCapFactor * out_c.m_lEff * in_m.m_width;
        //m_pDevice->InitHistory( MOSlastStore);

      end MosCalcInitEquations;

      function MosCalcCalcTempDependencies
      /* void MosCalc::CalcTempDependencies() */

        input Mos1.Mos1ModelLineParams in_p;
        input SpiceConstants in_C;
        input Mos.MosModelLineVariables in_vp;
        input Mosfet.Mosfet in_m;
        input Mos1.Mos1Calc in_c;
        input Integer in_m_type;

        output Mos1.Mos1Calc out_c;

      /* double dummy, ratio, ratio4; */
      protected
         Real dummy;
         Real ratio;
         Real ratio4;

      algorithm
        out_c := in_c;
      /*   double ratio   = m_pDevice->m_dTemp / m_pParameters->m_tnom;
   double ratio4  = ratio * sqrt(ratio);
   m_tTransconductance = m_pParameters->m_transconductance / ratio4;
   m_Beta = m_tTransconductance * m_pDevice->m_width / m_lEff;
   m_tSurfMob          = m_pParameters->m_surfaceMobility / ratio4;*/

        ratio                     := in_m.m_dTemp / in_p.m_tnom;
        ratio4                    := ratio * sqrt(ratio);
        out_c.m_tTransconductance := in_vp.m_transconductance / ratio4;
        out_c.m_Beta              := out_c.m_tTransconductance * in_m.m_width / out_c.m_lEff;

        out_c.m_tSurfMob          := in_p.m_surfaceMobility / ratio4;

      /*  m_tPhi = m_pDevice->JunctionPotDepTemp(
      m_pParameters->m_phi, m_pDevice->m_dTemp, m_pParameters->m_tnom); */

        out_c.m_tPhi := Equation.JunctionPotDepTemp(in_vp.m_phi, in_m.m_dTemp, in_p.m_tnom);

      /*  m_tVbi =  m_pParameters->m_vt0 - m_pModel->m_type *
      (m_pParameters->m_gamma * sqrt(m_pParameters->m_phi)) + .5 *
      (m_pDevice->EnergyGap_dep_Temp( m_pParameters->m_tnom) -
       m_pDevice->EnergyGap_dep_Temp( m_pDevice->m_dTemp))
      + m_pModel->m_type * .5 * (m_tPhi - m_pParameters->m_phi);
  m_tVto = m_tVbi +
      m_pModel->m_type * m_pParameters->m_gamma * sqrt(m_tPhi); */

        out_c.m_tVbi := in_vp.m_vt0 - in_m_type * (in_vp.m_gamma * sqrt(in_vp.m_phi)) +.5  *
                        (Equation.EnergyGap_dep_Temp( in_p.m_tnom) - Equation.EnergyGap_dep_Temp( in_m.m_dTemp))
                        + in_m_type *.5  * (out_c.m_tPhi - in_vp.m_phi);
        out_c.m_tVto := out_c.m_tVbi + in_m_type * in_vp.m_gamma * sqrt(out_c.m_tPhi);

      /*  m_tBulkPot = m_pDevice->JunctionPotDepTemp(
      m_pParameters->m_bulkJctPotential,
      m_pDevice->m_dTemp, m_pParameters->m_tnom);
  m_tDepCap  = m_pParameters->m_fwdCapDepCoeff * m_tBulkPot; */

        out_c.m_tBulkPot := Equation.JunctionPotDepTemp(in_p.m_bulkJctPotential,in_m.m_dTemp, in_p.m_tnom);
        out_c.m_tDepCap  := in_p.m_fwdCapDepCoeff * out_c.m_tBulkPot;

      /*   if ((m_pParameters->m_jctSatCurDensity == 0.) ||
       (m_pDevice->m_sourceArea == 0.) ||
       (m_pDevice->m_drainArea == 0.))
   {
      m_tDrainSatCur = m_pDevice->SaturationCurDepTempSPICE3MOSFET(
         m_pParameters->m_jctSatCur, m_pDevice->m_dTemp,
         m_pParameters->m_tnom);
      m_tSourceSatCur = m_tDrainSatCur;
      m_VBScrit = m_pDevice->JunctionVCrit( m_pDevice->m_dTemp, 1., m_tSourceSatCur);
      m_VBDcrit = m_VBScrit;
   }
   else
   {
      m_tSatCurDens = m_pDevice->SaturationCurDepTempSPICE3MOSFET(
         m_pParameters->m_jctSatCurDensity, m_pDevice->m_dTemp,
         m_pParameters->m_tnom);
      m_tDrainSatCur = m_tSatCurDens * m_pDevice->m_drainArea;
      m_tSourceSatCur = m_tSatCurDens * m_pDevice->m_sourceArea;
      m_VBScrit = m_pDevice->JunctionVCrit( m_pDevice->m_dTemp, 1., m_tSourceSatCur);
      m_VBDcrit = m_pDevice->JunctionVCrit( m_pDevice->m_dTemp, 1., m_tDrainSatCur);
   } */

        if (in_p.m_jctSatCurDensity == 0. or in_m.m_sourceArea == 0. or in_m.m_drainArea == 0.) then
          out_c.m_tDrainSatCur  := Equation.SaturationCurDepTempSPICE3MOSFET(
                                   in_p.m_jctSatCur, in_m.m_dTemp, in_p.m_tnom);
          out_c.m_tSourceSatCur := out_c.m_tDrainSatCur;
          out_c.m_VBScrit       := Equation.JunctionVCrit( in_m.m_dTemp, 1., out_c.m_tSourceSatCur);
          out_c.m_VBDcrit       := out_c.m_VBScrit;
        else
          out_c.m_tSatCurDens   := Equation.SaturationCurDepTempSPICE3MOSFET(
                                   in_p.m_jctSatCurDensity, in_m.m_dTemp,in_p.m_tnom);
          out_c.m_tDrainSatCur  := out_c.m_tSatCurDens * in_m.m_drainArea;
          out_c.m_tSourceSatCur := out_c.m_tSatCurDens * in_m.m_sourceArea;
          out_c.m_VBScrit       := Equation.JunctionVCrit( in_m.m_dTemp, 1., out_c.m_tSourceSatCur);
          out_c.m_VBDcrit       := Equation.JunctionVCrit( in_m.m_dTemp, 1., out_c.m_tDrainSatCur);
        end if;

      /*   if (!m_pParameters->m_capBDValue->IsGiven() || !m_pParameters->m_capBSValue->IsGiven())
C++   {
C++      m_pDevice->JunctionParamDepTempSPICE3(
C++         dummy, m_tCj, m_pParameters->m_bulkJctPotential,
C++         m_pParameters->m_bulkCapFactor,
C++         m_pParameters->m_bulkJctBotGradingCoeff,
C++         m_pDevice->m_dTemp, m_pParameters->m_tnom);
C++      m_pDevice->JunctionParamDepTempSPICE3(
C++         dummy, m_tCjsw, m_pParameters->m_bulkJctPotential,
C++         m_pParameters->m_sideWallCapFactor,
C++         m_pParameters->m_bulkJctSideGradingCoeff,
C++         m_pDevice->m_dTemp, m_pParameters->m_tnom);
C++      //       m_tCj = JunctionCapDepTemp(
C++      //          m_pParameters->m_bulkCapFactor, m_pParameters->m_bulkJctBotGradingCoeff,
C++      //          m_pParameters->m_bulkJctPotential,
C++      //          m_pDevice->m_dTemp, m_pParameters->m_tnom);
C++      //       m_tCjsw = JunctionCapDepTemp(
C++      //          m_pParameters->m_sideWallCapFactor,
C++      //          m_pParameters->m_bulkJctSideGradingCoeff,
C++      //          m_pParameters->m_bulkJctPotential,
C++      //          m_pDevice->m_dTemp, m_pParameters->m_tnom);
C++     m_pDevice->JunctionCapCoeffs(
C++         m_f1s, m_f2s, m_f3s, m_pParameters->m_bulkJctSideGradingCoeff,
C++         m_pParameters->m_fwdCapDepCoeff, m_tBulkPot);
C++   } */

      //  if ( not in_p.m_capBDValue->IsGiven() or not in_p.m_capBSValue->IsGiven())
        if ( not (in_p.m_capBDIsGiven > 0.5) or not (in_p.m_capBSIsGiven > 0.5)) then
          (dummy, out_c.m_tCj)   := Equation.JunctionParamDepTempSPICE3(
                                    in_p.m_bulkJctPotential, in_p.m_bulkCapFactor,
                                    in_p.m_bulkJctBotGradingCoeff, in_m.m_dTemp, in_p.m_tnom);
          (dummy, out_c.m_tCjsw) := Equation.JunctionParamDepTempSPICE3(
                                    in_p.m_bulkJctPotential, in_p.m_sideWallCapFactor,
                                    in_p.m_bulkJctSideGradingCoeff, in_m.m_dTemp, in_p.m_tnom);
          (out_c.m_f1s, out_c.m_f2s, out_c.m_f3s) := Equation.JunctionCapCoeffs(
                                    in_p.m_bulkJctSideGradingCoeff, in_p.m_fwdCapDepCoeff, out_c.m_tBulkPot);
        end if;

      /* if (m_pParameters->m_capBDValue->IsGiven())
C++   {
C++      m_pDevice->JunctionParamDepTempSPICE3(
C++         dummy, m_tCBDb, m_pParameters->m_bulkJctPotential,
C++         m_pParameters->m_capBD, m_pParameters->m_bulkJctBotGradingCoeff,
C++         m_pDevice->m_dTemp, m_pParameters->m_tnom);
C++      //       m_tCBDb = JunctionCapDepTemp(
C++      //          m_pParameters->m_capBD, m_pParameters->m_bulkJctBotGradingCoeff,
C++      //          m_pParameters->m_bulkJctPotential,
C++      //          m_pDevice->m_dTemp, m_pParameters->m_tnom);
C++      m_tCBDs = 0.0;
C++   }
C++   else
C++   {
C++      m_tCBDb = m_tCj * m_pDevice->m_drainArea;
C++      m_tCBDs = m_tCjsw * m_pDevice->m_drainPerimiter;
C++   } */

      //  if (m_pParameters->m_capBDValue->IsGiven())
        if (in_p.m_capBDIsGiven > 0.5) then
          (dummy, out_c.m_tCBDb) := Equation.JunctionParamDepTempSPICE3(
                                    in_p.m_bulkJctPotential, in_p.m_capBD,
                                    in_p.m_bulkJctBotGradingCoeff, in_m.m_dTemp, in_p.m_tnom);
          out_c.m_tCBDs          := 0.0;
        else
          out_c.m_tCBDb := out_c.m_tCj * in_m.m_drainArea;
          out_c.m_tCBDs := out_c.m_tCjsw * in_m.m_drainPerimiter;
        end if;

      /*   if (m_pParameters->m_capBSValue->IsGiven())
C++   {
C++      m_pDevice->JunctionParamDepTempSPICE3(
C++         dummy, m_tCBSb, m_pParameters->m_bulkJctPotential,
C++         m_pParameters->m_capBS, m_pParameters->m_bulkJctBotGradingCoeff,
C++         m_pDevice->m_dTemp, m_pParameters->m_tnom);
C++      //       m_tCBSb = JunctionCapDepTemp(
C++      //          m_pParameters->m_capBS, m_pParameters->m_bulkJctBotGradingCoeff,
C++      //          m_pParameters->m_bulkJctPotential,
C++      //          m_pDevice->m_dTemp, m_pParameters->m_tnom);
C++      m_tCBSs = 0.0;
C++   }
C++   else
C++   {
C++      m_tCBSb = m_tCj * m_pDevice->m_sourceArea;
C++      m_tCBSs = m_tCjsw * m_pDevice->m_sourcePerimiter;
C++   }
C++   m_pDevice->JunctionCapCoeffs(
C++      m_f1b, m_f2b, m_f3b, m_pParameters->m_bulkJctBotGradingCoeff,
C++      m_pParameters->m_fwdCapDepCoeff, m_tBulkPot);
C++   m_dVt   = m_pDevice->m_dTemp * m_pDevice->CONSTKoverQ;
C++   } */

      //  if (m_pParameters->m_capBSValue->IsGiven())
        if (in_p.m_capBSIsGiven > 0.5) then
          (dummy, out_c.m_tCBSb) := Equation.JunctionParamDepTempSPICE3(
                                    in_p.m_bulkJctPotential, in_p.m_capBS,
                                    in_p.m_bulkJctBotGradingCoeff, in_m.m_dTemp, in_p.m_tnom);
          out_c.m_tCBSs          := 0.0;
        else
          out_c.m_tCBSb := out_c.m_tCj * in_m.m_sourceArea;
          out_c.m_tCBSs := out_c.m_tCjsw * in_m.m_sourcePerimiter;
        end if;
         (out_c.m_f1b, out_c.m_f2b, out_c.m_f3b) := Equation.JunctionCapCoeffs(
                                                    in_p.m_bulkJctBotGradingCoeff,
                                                    in_p.m_fwdCapDepCoeff, out_c.m_tBulkPot);
        out_c.m_dVt   := in_m.m_dTemp * SpiceRoot.SPICEcircuitCONST.CONSTKoverQ;

      end MosCalcCalcTempDependencies;

      function MosCalcNoBypassCode
      /* void MosCalc::NoBypassCode() */

        input Mosfet.Mosfet in_m;
        input Integer in_m_type;
        input Mos1.Mos1Calc in_c;
        input Mos1.Mos1ModelLineParams in_p;
        input SpiceConstants in_C;
        input Mos.MosModelLineVariables in_vp;
        //input DEVqmeyer in_qm;                 // qmeyer-Parameter vom letzten Schritt
        input Boolean in_m_bInit;
        input Real[4] in_m_pVoltageValues; /* gate bulk drain source */

        output CurrrentsCapacitances out_cc;

      //  output DEVqmeyer out_qm;

      protected
        Real vbd;
        Real vgd;
        Real vgb;
        Real cur;
        Integer n;
        DEVqmeyer qm;
        DEVqmeyer in_qm;  // muss hier wieder raus
        Mos1.Mos1Calc int_c;

        Real zzz;

      algorithm
        int_c := in_c;

      /*{m_vds = m_pModel->m_type * m_pDevice->GetVoltage( DP, SP);
   m_vgs = m_pModel->m_type * m_pDevice->GetVoltage( G , SP);
   m_vbs = m_pModel->m_type * m_pDevice->GetVoltage( B , SP); */

        int_c.m_vgs := in_m_type * (in_m_pVoltageValues[1] - in_m_pVoltageValues[4]); // ( G , SP)
        int_c.m_vbs := in_m_type * (in_m_pVoltageValues[2] - in_m_pVoltageValues[4]); // ( B , SP)
        int_c.m_vds := in_m_type * (in_m_pVoltageValues[3] - in_m_pVoltageValues[4]); // ( DP, SP)

      /* if (m_pDevice->UseInitialConditions() && m_pDevice->m_ICVBSValue->IsGiven())
C++      m_vbs = m_pModel->m_type * m_pDevice->m_dICVBS;
C++   else if (m_pDevice->InitJunctionVoltages())
C++      if (m_pDevice->m_off)
C++         m_vbs = 0.;
C++      else
C++         m_vbs = m_VBScrit;
C++   if (m_pDevice->UseInitialConditions() && m_pDevice->m_ICVDSValue->IsGiven())
C++      m_vds = m_pModel->m_type * m_pDevice->m_dICVDS;
C++   else if (m_pDevice->InitJunctionVoltages())
C++      if (m_pDevice->m_off)
C++         m_vds = 0.;
C++      else
C++         m_vds = m_VBDcrit - m_VBScrit;
C++   if (m_pDevice->UseInitialConditions() && m_pDevice->m_ICVGSValue->IsGiven())
C++      m_vgs = m_pModel->m_type * m_pDevice->m_dICVGS;
C++   else if (m_pDevice->InitJunctionVoltages())
C++      if (m_pDevice->m_off)
C++         m_vgs = 0.; */

        if ( SpiceRoot.UseInitialConditions())    and (in_m.m_dICVBSIsGiven >0.5) then
          int_c.m_vbs := in_m_type * in_m.m_dICVBS;
        elseif ( SpiceRoot.InitJunctionVoltages()) then
          int_c.m_vbs := if (in_m.m_off >0.5) then 0. else int_c.m_VBScrit;
        end if;
        if ( SpiceRoot.UseInitialConditions()) and (in_m.m_dICVDSIsGiven > 0.5) then
          int_c.m_vds := in_m_type * in_m.m_dICVDS;
        elseif ( SpiceRoot.InitJunctionVoltages()) then
          int_c.m_vds := if (in_m.m_off > 0.5) then 0. else (int_c.m_VBDcrit - int_c.m_VBScrit);
        end if;
        if ( SpiceRoot.UseInitialConditions()) and (in_m.m_dICVGSIsGiven > 0.5) then
          int_c.m_vgs := in_m_type * in_m.m_dICVGS;
        elseif ( SpiceRoot.InitJunctionVoltages()) then
          if ( in_m.m_off > 0.5) then
            int_c.m_vgs := 0.;
          end if;
        end if;

      /* if (!m_vds && !m_vgs && !m_vbs && !m_pDevice->UseInitialConditions() &&
C++       !m_pDevice->m_off)
C++   {
C++      m_vbs = -1;
C++      m_vgs = m_pModel->m_type * m_tVto;
C++      m_vds = 0;
C++   }

C++   double vbd = m_vbs - m_vds;
C++   double vgd = m_vgs - m_vds;

C++   if (m_vds >= 0)
C++   {
C++      m_vbs = m_pDevice->LimitJunctionVoltage( m_vbs, m_dVt, m_VBScrit);
C++      vbd = m_vbs-m_vds;
C++   } else {
C++      vbd = m_pDevice->LimitJunctionVoltage( vbd, m_dVt, m_VBDcrit);
C++      m_vbs = vbd + m_vds;
C++   }
C++
C++   double vgb = m_vgs - m_vbs; */

      /***** in C nachsehen ****
C++  if ( not SpiceRoot.UseInitialConditions() and not in_m.m_off) then
C++       //not int_c.m_vds and not int_c.m_vgs and not int_c.m_vbs and
C++    int_c.m_vbs := -1;
C++    int_c.m_vgs := in_m_type * int_c.m_tVto;
C++    int_c.m_vds := 0;
C++  end if;
C++*/

        vbd := int_c.m_vbs - int_c.m_vds;
        vgd := int_c.m_vgs - int_c.m_vds;

        if ( int_c.m_vds >= 0) then
      //    int_c.m_vbs := SpiceRoot.LimitJunctionVoltage(int_c.m_vbs);
          vbd         := int_c.m_vbs - int_c.m_vds;
        else
      //    vbd         := SpiceRoot.LimitJunctionVoltage(vbd);
          int_c.m_vbs := vbd + int_c.m_vds;
        end if;

        vgb := int_c.m_vgs - int_c.m_vbs;

      /*   //////////////////////////////////////////////////////////////////////
C++   // resistances
C++   m_pDevice->InternConductance( D, DP, m_drainConductance);
C++   m_pDevice->InternConductance( S, SP, m_sourceConductance); */

      /*   //////////////////////////////////////////////////////////////////////
C++   // bulk-source and bulk-drain diodes here we just
C++   // evaluate the ideal diode current and the
C++   // corresponding derivative (conductance).
C++   // m_pDevice->Junction2( cbd, gbd, vbd, m_pDevice->m_dTemp, 1., m_tDrainSatCur);
C++   m_pDevice->Junction2_SPICE3_MOSFET( m_cbd, m_gbd, vbd, m_pDevice->m_dTemp, 1., m_tDrainSatCur);
C++   m_pDevice->InsertConductance(
C++      B, DP, m_gbd, m_pModel->m_type * m_cbd, m_pModel->m_type * vbd);
C++   //    Junction2( cbs, gbs, vbs, m_pDevice->m_dTemp, 1., m_tSourceSatCur);
C++   m_pDevice->Junction2_SPICE3_MOSFET( m_cbs, m_gbs, m_vbs, m_pDevice->m_dTemp, 1., m_tSourceSatCur);
C++   m_pDevice->InsertConductance(
C++      B, SP, m_gbs, m_pModel->m_type * m_cbs, m_pModel->m_type * m_vbs); */

         (int_c.m_cbd, int_c.m_gbd) := Equation.Junction2_SPICE3_MOSFET( int_c.m_cbd, int_c.m_gbd, vbd,
                                       in_m.m_dTemp, 1., int_c.m_tDrainSatCur);
         out_cc.iBD                 := in_m_type * int_c.m_cbd;
         (int_c.m_cbs, int_c.m_gbs) := Equation.Junction2_SPICE3_MOSFET( int_c.m_cbs, int_c.m_gbs, int_c.m_vbs,
                                       in_m.m_dTemp, 1., int_c.m_tSourceSatCur);
         out_cc.iBS                 := in_m_type * int_c.m_cbs;

      /*   //////////////////////////////////////////////////////////////////////
C++   // now to determine whether the user was able to
C++   // correctly identify the source and drain of his
C++   // device
C++   if (m_vds >= 0)
C++      m_mode =  1; // normal mode
C++   else
C++      m_mode = -1; // inverse mode */

        int_c.m_mode := if (int_c.m_vds >= 0) then 1 else -1; // 1: normal mode, -1: inverse mode

      /*   //////////////////////////////////////////////////////////////////////
C++   // this block of code evaluates the drain
C++   // current and its derivatives
C++   if (m_mode == 1)
C++      // Let the actual instance calculate the values
C++      DrainCur( m_vbs, m_vgs, m_vds, m_cdrain, m_gm, m_gmbs, m_gds);
C++   else
C++      DrainCur( vbd, vgd, -m_vds, m_cdrain, m_gm, m_gmbs, m_gds);
C++   m_pDevice->InsertNonChargeCurrent(
C++      DP, SP, m_pModel->m_type * m_cdrain * m_mode,
C++      DP, SP, m_gds, m_pModel->m_type * m_vds,
C++      G, m_mode == 1 ? SP : DP, m_mode * m_gm, m_pModel->m_type * (m_mode == 1 ? m_vgs : vgd),
      B, m_mode == 1 ? SP : DP, m_mode * m_gmbs, m_pModel->m_type * (m_mode == 1 ? m_vbs : vbd)); */

        if (int_c.m_mode == 1) then

          int_c := Mos1.DrainCur( int_c.m_vbs, int_c.m_vgs, int_c.m_vds, int_c, in_p, in_C, in_vp, in_m_type);
        else
          int_c := Mos1.DrainCur( vbd,               vgd,  -int_c.m_vds, int_c, in_p, in_C, in_vp, in_m_type);
        end if;

        n      := if (int_c.m_mode == 1) then 6 else 5;
        out_cc.idrain := in_m_type * int_c.m_cdrain * int_c.m_mode;

        zzz := int_c.m_cdrain;
        // out_cc.idrain := zzz; //in_m_pVoltageValues[3]; //int_c.m_vds;

      /*   //////////////////////////////////////////////////////////////////////
C++   // now we do the hard part of the bulk-drain and bulk-source diode -
C++   // we evaluate the non-linear capacitance and charge
C++   m_capbss    = 0.0;
C++   m_chargebss = 0.0;
C++   m_capbds    = 0.0;
C++   m_chargebds = 0.0;
C++   m_pDevice->JunctionCap(
C++      m_capbsb, m_chargebsb, m_tCBSb, m_vbs, m_tDepCap,
C++      m_pParameters->m_bulkJctBotGradingCoeff, m_tBulkPot,
C++      m_f1b, m_f2b, m_f3b);
C++   m_pDevice->JunctionCap(
C++      m_capbdb, m_chargebdb, m_tCBDb, vbd, m_tDepCap,
C++      m_pParameters->m_bulkJctBotGradingCoeff, m_tBulkPot,
C++      m_f1b, m_f2b, m_f3b);
C++   if (!m_pParameters->m_capBSValue->IsGiven())
C++      m_pDevice->JunctionCap(
C++         m_capbss, m_chargebss, m_tCBSs, m_vbs, m_tDepCap,
C++         m_pParameters->m_bulkJctSideGradingCoeff, m_tBulkPot,
C++         m_f1s, m_f2s, m_f3s);
C++   if (!m_pParameters->m_capBDValue->IsGiven())
C++      m_pDevice->JunctionCap(
C++         m_capbds, m_chargebds, m_tCBDs, vbd, m_tDepCap,
C++         m_pParameters->m_bulkJctSideGradingCoeff, m_tBulkPot,
C++         m_f1s, m_f2s, m_f3s);
C++   m_pDevice->InsertCapacitance(
C++      B, SP, m_capbsb + m_capbss, m_pModel->m_type * (m_chargebsb + m_chargebss),
C++      m_pModel->m_type * m_vbs);
C++   m_pDevice->InsertCapacitance(
C++      B, DP, m_capbdb + m_capbds, m_pModel->m_type * (m_chargebdb + m_chargebds),
C++      m_pModel->m_type * vbd); */

        int_c.m_capbss    := 0.0;
        int_c.m_chargebss := 0.0;
        int_c.m_capbds    := 0.0;
        int_c.m_chargebds := 0.0;
        (int_c.m_capbsb, int_c.m_chargebsb) := Equation.JunctionCap(
               int_c.m_tCBSb, int_c.m_vbs, int_c.m_tDepCap,
               in_p.m_bulkJctBotGradingCoeff, int_c.m_tBulkPot,
               int_c.m_f1b, int_c.m_f2b, int_c.m_f3b);

        (int_c.m_capbdb, int_c.m_chargebdb) := Equation.JunctionCap(
               int_c.m_tCBDb, vbd, int_c.m_tDepCap,
               in_p.m_bulkJctBotGradingCoeff, int_c.m_tBulkPot,
               int_c.m_f1b, int_c.m_f2b, int_c.m_f3b);

      //  if ( not in_p.m_capBSIsValue->IsGiven()) then
        if ( not (in_p.m_capBSIsGiven > 0.5)) then
          (int_c.m_capbss, int_c.m_chargebss) := Equation.JunctionCap(
               int_c.m_tCBSs,int_c. m_vbs, int_c.m_tDepCap,
               in_p.m_bulkJctSideGradingCoeff, int_c.m_tBulkPot,
               int_c.m_f1s, int_c.m_f2s, int_c.m_f3s);
        end if;
      //  if (not in_p.m_capBDValue->IsGiven()) then
        if (not (in_p.m_capBDIsGiven > 0.5)) then
          (int_c.m_capbds, int_c.m_chargebds) := Equation.JunctionCap(
               int_c.m_tCBDs, vbd, int_c.m_tDepCap,
               in_p.m_bulkJctSideGradingCoeff, int_c.m_tBulkPot,
               int_c.m_f1s, int_c.m_f2s, int_c.m_f3s);
        end if;

      //   m_pDevice->InsertCapacitance(
      //      B, SP, m_capbsb + m_capbss, m_pModel->m_type * (m_chargebsb + m_chargebss),
      //      m_pModel->m_type * m_vbs);
        out_cc.cBS := if (in_m_bInit) then 1e-15 else (int_c.m_capbsb + int_c.m_capbss); //statt 1e-15 eigentlich 0

      //   m_pDevice->InsertCapacitance(
      //      B, DP, m_capbdb + m_capbds, m_pModel->m_type * (m_chargebdb + m_chargebds),
      //      m_pModel->m_type * vbd); */
        out_cc.cBD := if (in_m_bInit) then 1e-15 else (int_c.m_capbdb + int_c.m_capbds);  //statt 1e-15 eigentlich 0

      /*   //////////////////////////////////////////////////////////////////////
C++   // Last we have to calculate the gate capacitances
C++   // calculate meyer's capacitors
C++   // new cmeyer - this just evaluates at the current time,
C++   // expects you to remember values from previous time returns 1/2 of
C++   // non-constant portion of capacitance you must add in the other half
C++   // from previous time and the constant part
C++   if (m_mode > 0)
C++      DEVqmeyer( m_vgs, vgd, vgb, MOScapgs, MOScapgd, MOScapgb);
C++   else
C++      DEVqmeyer( vgd, m_vgs, vgb, MOScapgd, MOScapgs, MOScapgb); */

        if (int_c.m_mode > 0) then
          qm := MosCalcDEVqmeyer( int_c.m_vgs, vgd, vgb, int_c);
        else
          qm := MosCalcDEVqmeyer( vgd, int_c.m_vgs, vgb, int_c);
        end if;
        in_qm := qm;
      /* if (m_pDevice->m_bInit)
C++   {
C++      m_capgd = 2 * m_pDevice->GetHistoryValue( MOScapgd, 0) + m_capGDovl;
C++      m_capgs = 2 * m_pDevice->GetHistoryValue( MOScapgs, 0) + m_capGSovl;
C++      m_capgb = 2 * m_pDevice->GetHistoryValue( MOScapgb, 0) + m_capGBovl;
C++      m_qgs   = m_capgs * m_vgs;
C++      m_qgb   = m_capgb * vgb;
C++      m_qgd   = m_capgd * vgd;
C++   }
C++   else
C++   {
C++      m_capgd = m_pDevice->GetHistoryValue( MOScapgd, 0) + m_pDevice->GetHistoryValue( MOScapgd) + m_capGDovl;
C++      m_capgs = m_pDevice->GetHistoryValue( MOScapgs, 0) + m_pDevice->GetHistoryValue( MOScapgs) + m_capGSovl;
C++      m_capgb = m_pDevice->GetHistoryValue( MOScapgb, 0) + m_pDevice->GetHistoryValue( MOScapgb) + m_capGBovl;
C++      m_qgs   = (m_vgs - m_pDevice->GetHistoryValue( MOSvgs)) * m_capgs + m_pDevice->GetHistoryValue( MOSqgs);
C++      m_qgb   = (vgb - m_pDevice->GetHistoryValue( MOSvgb)) * m_capgb + m_pDevice->GetHistoryValue( MOSqgb);
C++      m_qgd   = (vgd - m_pDevice->GetHistoryValue( MOSvgd)) * m_capgd + m_pDevice->GetHistoryValue( MOSqgd);
C++   } */

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

      /* m_pDevice->SetHistoryValue( MOSqgs, m_qgs);
C++   m_pDevice->SetHistoryValue( MOSqgb, m_qgb);
C++   m_pDevice->SetHistoryValue( MOSqgd, m_qgd);
C++   m_pDevice->SetHistoryValue( MOSvgs, m_vgs);
C++   m_pDevice->SetHistoryValue( MOSvgb, vgb);
C++   m_pDevice->SetHistoryValue( MOSvgd, vgd); */

        qm.qm_qgs := int_c.m_qgs;
        qm.qm_qgb := int_c.m_qgb;
        qm.qm_qgd := int_c.m_qgd;
        qm.qm_vgs := int_c.m_vgs;
        qm.qm_vgb := vgb;
        qm.qm_vgd := vgd;

        //C++ neue qmeyer-Parameter fuer naechsten Rechenschritt ablegen
      //C++  out_qm := qm;

      /* m_pDevice->InsertCapacitance(
C++      G, DP, m_capgd, m_pModel->m_type * m_qgd, m_pModel->m_type * vgd);
C++   m_pDevice->InsertCapacitance(
C++      G, SP, m_capgs, m_pModel->m_type * m_qgs, m_pModel->m_type * m_vgs);
C++   m_pDevice->InsertCapacitance(
C++      G, B , m_capgb, m_pModel->m_type * m_qgb, m_pModel->m_type * vgb);} */

        out_cc.cGB := if (in_m_bInit) then -1e40 else int_c.m_capgb;  //statt 1e-15 eigentlich 0
        out_cc.cGD := if (in_m_bInit) then -1e40 else int_c.m_capgd;  //statt 1e-15 eigentlich 0
        out_cc.cGS := if (in_m_bInit) then -1e40 else int_c.m_capgs;  //statt 1e-15 eigentlich 0

      end MosCalcNoBypassCode;

      function MosCalcDEVqmeyer
      /* // Compute the MOS overlap capacitances as functions of the
   //  device terminal voltages
   void MosCalc::DEVqmeyer(
   double vgs,    // initial voltage gate-source
   double vgd,    // initial voltage gate-drain
   double vgb,    // initial voltage gate-bulk
   int NrCapGs,   // non-constant portion of g-s overlap capacitance
   int NrCapGd,   // non-constant portion of g-d overlap capacitance
   int NrCapGb    // non-constant portion of g-b overlap capacitance ) */

        input Real vgs;
        input Real vgd;
        input Real vgb;
        input MosCalc in_c;

        output DEVqmeyer out_qm;

      protected
        Real vds;
        Real vddif;
        Real vddif1;
        Real vddif2;
        Real vgst;

      algorithm
      /*{double vds;    // Drain-Source voltage
   double vddif;
   double vddif1;
   double vddif2;
   double vgst;
   vgst = vgs - m_von;
   if (vgst <= -m_tPhi)
   {
      m_pDevice->SetHistoryValue( NrCapGb, m_capOx / 2.);
      m_pDevice->SetHistoryValue( NrCapGs, 0.);
      m_pDevice->SetHistoryValue( NrCapGd, 0.);
   }
   else if (vgst <= -m_tPhi / 2.)
   {
      m_pDevice->SetHistoryValue( NrCapGb, -vgst * m_capOx / (2. * m_tPhi));
      m_pDevice->SetHistoryValue( NrCapGs, 0.);
      m_pDevice->SetHistoryValue( NrCapGd, 0.);
   }
   else if (vgst <= 0.)
   {
      m_pDevice->SetHistoryValue( NrCapGb, -vgst * m_capOx / (2. * m_tPhi));
      m_pDevice->SetHistoryValue( NrCapGs, vgst * m_capOx / (1.5 * m_tPhi) + m_capOx / 3.);
      m_pDevice->SetHistoryValue( NrCapGd, 0.);
   }
   else
   {
      vds = vgs - vgd;
      if (m_vdsat <= vds)
      {
         m_pDevice->SetHistoryValue( NrCapGs, m_capOx / 3.);
         m_pDevice->SetHistoryValue( NrCapGd, 0.);
         m_pDevice->SetHistoryValue( NrCapGb, 0.);
      }
      else
      {
         vddif  = 2.0 * m_vdsat - vds;
         vddif1 = m_vdsat - vds; //-1.0e-12
         vddif2 = vddif * vddif;
         m_pDevice->SetHistoryValue( NrCapGd, m_capOx * (1. - m_vdsat  * m_vdsat  / vddif2) / 3.);
         m_pDevice->SetHistoryValue( NrCapGs, m_capOx * (1. - vddif1 * vddif1 / vddif2) / 3.);
         m_pDevice->SetHistoryValue( NrCapGb, 0.);
      }   }}  */

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
            vddif1 := in_c.m_vdsat - vds; //-1.0e-12
            vddif2 := vddif * vddif;
            out_qm.qm_capgd := in_c.m_capOx * (1. - in_c.m_vdsat  * in_c.m_vdsat  / vddif2) / 3.;
            out_qm.qm_capgs := in_c.m_capOx * (1. - vddif1 * vddif1 / vddif2) / 3.;
            out_qm.qm_capgb := 0.;
          end if;
        end if;

      end MosCalcDEVqmeyer;

      function Mos2CalcInitEquations
      /* void MosCalc::InitEquations() */

        input Mos2.Mos2ModelLineParams in_p;
        input SpiceConstants in_C;
        input Mos.MosModelLineVariables in_vp;
        input Mosfet.Mosfet in_m;

        output Mos2.Mos2Calc out_c;

      algorithm
      /* {if (m_pDevice->m_len - 2 * m_pParameters->m_latDiff <= 0)
      NegativeLEffEx(
         m_pDevice, m_pDevice->m_len - 2 * m_pParameters->m_latDiff).print();*/

      //  if (in_m.m_len - 2 * in_p.m_latDiff <= 0) then
      //    NegativeLEffEx(m_pDevice, m_pDevice->m_len - 2 * m_pParameters->m_latDiff).print();
      //  end if;

      /*
C++   if (m_pParameters->m_drainResistanceValue->IsGiven())
C++   {
C++      if (m_pParameters->m_drainResistance != 0)
C++         m_drainConductance = 1 / m_pParameters->m_drainResistance;
C++   }
C++   else
C++      if (m_pParameters->m_sheetResistance != 0)
C++         m_drainConductance = 1 /
C++            (m_pParameters->m_sheetResistance * m_pDevice->m_drainSquares);*/

       out_c.m_drainResistance := if  (in_p.m_drainResistanceIsGiven > 0.5) then
             in_p.m_drainResistance else
             in_p.m_sheetResistance * in_m.m_drainSquares;

      // if
      //   (in_p.m_drainResistanceIsGiven > 0.5) then
      //   if
      //     (in_p.m_drainResistance <> 0) then
      //     out_c.m_drainConductance :=1/in_p.m_drainResistance;
      //   end if;
      // else
      //   if (in_p.m_sheetResistance <>0) then
      //      out_c.m_drainConductance :=1/in_p.m_sheetResistance*in_m.m_drainSquares;
      //   end if;
      // end if;

      /*   if (m_pParameters->m_sourceResistanceValue->IsGiven())
C++   {
C++      if (m_pParameters->m_sourceResistance != 0)
C++         m_sourceConductance = 1 / m_pParameters->m_sourceResistance;
C++   }
C++   else if (m_pParameters->m_sheetResistance != 0)
C++      m_sourceConductance =
C++         1 / (m_pParameters->m_sheetResistance * m_pDevice->m_sourceSquares);*/
      //
        // if (in_p.m_sourceResistanceIsGiven > 0.5) then
        //   if (in_p.m_sourceResistance <> 0) then
        //     out_c.m_sourceConductance := 1 / in_p.m_sourceResistance;
        //   end if;
        // elseif (in_p.m_sheetResistance <> 0) then
        //   out_c.m_sourceConductance := 1 / (in_p.m_sheetResistance * in_m.m_sourceSquares);
        // end if;

      out_c.m_sourceResistance := if  (in_p.m_sourceResistanceIsGiven > 0.5) then
             in_p.m_sourceResistance else
             in_p.m_sheetResistance * in_m.m_sourceSquares;

      /*   m_lEff     = m_pDevice->m_len - 2 * m_pParameters->m_latDiff;
   // frank bergmann, 130900
   // abfrage auf zu kleinen wert - setzen auf vernuenftigen
   // brachte probleme bei einsatz unter windows
   if (F_Abs( m_lEff) < 1e-18)
      m_lEff = 1e-6;
   m_capGSovl = m_pParameters->m_gateSourceOverlapCapFactor * m_pDevice->m_width;
   m_capGDovl = m_pParameters->m_gateDrainOverlapCapFactor * m_pDevice->m_width;
   m_capGBovl = m_pParameters->m_gateBulkOverlapCapFactor * m_lEff;
   m_capOx    = m_pParameters->m_oxideCapFactor * m_lEff * m_pDevice->m_width;
   m_pDevice->InitHistory( MOSlastStore);
}  */

        out_c.m_lEff := in_m.m_len - 2 * in_p.m_latDiff;

        if ( abs( out_c.m_lEff) < 1e-18) then
          out_c.m_lEff := 1e-6;
        end if;
        out_c.m_capGSovl := in_p.m_gateSourceOverlapCapFactor * in_m.m_width;
        out_c.m_capGDovl := in_p.m_gateDrainOverlapCapFactor * in_m.m_width;
        out_c.m_capGBovl := in_p.m_gateBulkOverlapCapFactor * out_c.m_lEff;

        out_c.m_capOx    := in_vp.m_oxideCapFactor * out_c.m_lEff * in_m.m_width;
        //m_pDevice->InitHistory( MOSlastStore);

      end Mos2CalcInitEquations;

      function Mos2CalcCalcTempDependencies
      /* void MosCalc::CalcTempDependencies() */

        input Mos2.Mos2ModelLineParams in_p;
        input SpiceConstants in_C;
        input Mos.MosModelLineVariables in_vp;
        input Mosfet.Mosfet in_m;
        input Mos2.Mos2Calc in_c;
        input Integer in_m_type;

        output Mos2.Mos2Calc out_c;

      /* double dummy, ratio, ratio4; */
      protected
         Real dummy;
         Real ratio;
         Real ratio4;

      algorithm
        out_c := in_c;
      /*   double ratio   = m_pDevice->m_dTemp / m_pParameters->m_tnom;
   double ratio4  = ratio * sqrt(ratio);
   m_tTransconductance = m_pParameters->m_transconductance / ratio4;
   m_Beta = m_tTransconductance * m_pDevice->m_width / m_lEff;
   m_tSurfMob          = m_pParameters->m_surfaceMobility / ratio4;*/

        ratio                     := in_m.m_dTemp / in_p.m_tnom;
        ratio4                    := ratio * sqrt(ratio);
        out_c.m_tTransconductance := in_vp.m_transconductance / ratio4;
        out_c.m_Beta              := out_c.m_tTransconductance * in_m.m_width / out_c.m_lEff;

        out_c.m_tSurfMob          := in_p.m_surfaceMobility / ratio4;

      /*  m_tPhi = m_pDevice->JunctionPotDepTemp(
      m_pParameters->m_phi, m_pDevice->m_dTemp, m_pParameters->m_tnom); */

        out_c.m_tPhi := Equation.JunctionPotDepTemp(in_vp.m_phi, in_m.m_dTemp, in_p.m_tnom);

      /*  m_tVbi =  m_pParameters->m_vt0 - m_pModel->m_type *
      (m_pParameters->m_gamma * sqrt(m_pParameters->m_phi)) + .5 *
      (m_pDevice->EnergyGap_dep_Temp( m_pParameters->m_tnom) -
       m_pDevice->EnergyGap_dep_Temp( m_pDevice->m_dTemp))
      + m_pModel->m_type * .5 * (m_tPhi - m_pParameters->m_phi);
  m_tVto = m_tVbi +
      m_pModel->m_type * m_pParameters->m_gamma * sqrt(m_tPhi); */

        out_c.m_tVbi := in_vp.m_vt0 - in_m_type * (in_vp.m_gamma * sqrt(in_vp.m_phi)) +.5  *
                        (Equation.EnergyGap_dep_Temp( in_p.m_tnom) - Equation.EnergyGap_dep_Temp( in_m.m_dTemp))
                        + in_m_type *.5  * (out_c.m_tPhi - in_vp.m_phi);
        out_c.m_tVto := out_c.m_tVbi + in_m_type * in_vp.m_gamma * sqrt(out_c.m_tPhi);

      /*  m_tBulkPot = m_pDevice->JunctionPotDepTemp(
      m_pParameters->m_bulkJctPotential,
      m_pDevice->m_dTemp, m_pParameters->m_tnom);
  m_tDepCap  = m_pParameters->m_fwdCapDepCoeff * m_tBulkPot; */

        out_c.m_tBulkPot := Equation.JunctionPotDepTemp(in_p.m_bulkJctPotential,in_m.m_dTemp, in_p.m_tnom);
        out_c.m_tDepCap  := in_p.m_fwdCapDepCoeff * out_c.m_tBulkPot;

      /*   if ((m_pParameters->m_jctSatCurDensity == 0.) ||
       (m_pDevice->m_sourceArea == 0.) ||
       (m_pDevice->m_drainArea == 0.))
   {
      m_tDrainSatCur = m_pDevice->SaturationCurDepTempSPICE3MOSFET(
         m_pParameters->m_jctSatCur, m_pDevice->m_dTemp,
         m_pParameters->m_tnom);
      m_tSourceSatCur = m_tDrainSatCur;
      m_VBScrit = m_pDevice->JunctionVCrit( m_pDevice->m_dTemp, 1., m_tSourceSatCur);
      m_VBDcrit = m_VBScrit;
   }
   else
   {
      m_tSatCurDens = m_pDevice->SaturationCurDepTempSPICE3MOSFET(
         m_pParameters->m_jctSatCurDensity, m_pDevice->m_dTemp,
         m_pParameters->m_tnom);
      m_tDrainSatCur = m_tSatCurDens * m_pDevice->m_drainArea;
      m_tSourceSatCur = m_tSatCurDens * m_pDevice->m_sourceArea;
      m_VBScrit = m_pDevice->JunctionVCrit( m_pDevice->m_dTemp, 1., m_tSourceSatCur);
      m_VBDcrit = m_pDevice->JunctionVCrit( m_pDevice->m_dTemp, 1., m_tDrainSatCur);
   } */

        if (in_p.m_jctSatCurDensity == 0. or in_m.m_sourceArea == 0. or in_m.m_drainArea == 0.) then
          out_c.m_tDrainSatCur  := Equation.SaturationCurDepTempSPICE3MOSFET(
                                   in_p.m_jctSatCur, in_m.m_dTemp, in_p.m_tnom);
          out_c.m_tSourceSatCur := out_c.m_tDrainSatCur;
          out_c.m_VBScrit       := Equation.JunctionVCrit( in_m.m_dTemp, 1., out_c.m_tSourceSatCur);
          out_c.m_VBDcrit       := out_c.m_VBScrit;
        else
          out_c.m_tSatCurDens   := Equation.SaturationCurDepTempSPICE3MOSFET(
                                   in_p.m_jctSatCurDensity, in_m.m_dTemp,in_p.m_tnom);
          out_c.m_tDrainSatCur  := out_c.m_tSatCurDens * in_m.m_drainArea;
          out_c.m_tSourceSatCur := out_c.m_tSatCurDens * in_m.m_sourceArea;
          out_c.m_VBScrit       := Equation.JunctionVCrit( in_m.m_dTemp, 1., out_c.m_tSourceSatCur);
          out_c.m_VBDcrit       := Equation.JunctionVCrit( in_m.m_dTemp, 1., out_c.m_tDrainSatCur);
        end if;

      /*   if (!m_pParameters->m_capBDValue->IsGiven() || !m_pParameters->m_capBSValue->IsGiven())
C++   {
C++      m_pDevice->JunctionParamDepTempSPICE3(
C++         dummy, m_tCj, m_pParameters->m_bulkJctPotential,
C++         m_pParameters->m_bulkCapFactor,
C++         m_pParameters->m_bulkJctBotGradingCoeff,
C++         m_pDevice->m_dTemp, m_pParameters->m_tnom);
C++      m_pDevice->JunctionParamDepTempSPICE3(
C++         dummy, m_tCjsw, m_pParameters->m_bulkJctPotential,
C++         m_pParameters->m_sideWallCapFactor,
C++         m_pParameters->m_bulkJctSideGradingCoeff,
C++         m_pDevice->m_dTemp, m_pParameters->m_tnom);
C++      //       m_tCj = JunctionCapDepTemp(
C++      //          m_pParameters->m_bulkCapFactor, m_pParameters->m_bulkJctBotGradingCoeff,
C++      //          m_pParameters->m_bulkJctPotential,
C++      //          m_pDevice->m_dTemp, m_pParameters->m_tnom);
C++      //       m_tCjsw = JunctionCapDepTemp(
C++      //          m_pParameters->m_sideWallCapFactor,
C++      //          m_pParameters->m_bulkJctSideGradingCoeff,
C++      //          m_pParameters->m_bulkJctPotential,
C++      //          m_pDevice->m_dTemp, m_pParameters->m_tnom);
C++     m_pDevice->JunctionCapCoeffs(
C++         m_f1s, m_f2s, m_f3s, m_pParameters->m_bulkJctSideGradingCoeff,
C++         m_pParameters->m_fwdCapDepCoeff, m_tBulkPot);
C++   } */

      //  if ( not in_p.m_capBDValue->IsGiven() or not in_p.m_capBSValue->IsGiven())
        if ( not (in_p.m_capBDIsGiven > 0.5) or not (in_p.m_capBSIsGiven > 0.5)) then
          (dummy, out_c.m_tCj)   := Equation.JunctionParamDepTempSPICE3(
                                    in_p.m_bulkJctPotential, in_p.m_bulkCapFactor,
                                    in_p.m_bulkJctBotGradingCoeff, in_m.m_dTemp, in_p.m_tnom);
          (dummy, out_c.m_tCjsw) := Equation.JunctionParamDepTempSPICE3(
                                    in_p.m_bulkJctPotential, in_p.m_sideWallCapFactor,
                                    in_p.m_bulkJctSideGradingCoeff, in_m.m_dTemp, in_p.m_tnom);
          (out_c.m_f1s, out_c.m_f2s, out_c.m_f3s) := Equation.JunctionCapCoeffs(
                                    in_p.m_bulkJctSideGradingCoeff, in_p.m_fwdCapDepCoeff, out_c.m_tBulkPot);
        end if;

      /* if (m_pParameters->m_capBDValue->IsGiven())
C++   {
C++      m_pDevice->JunctionParamDepTempSPICE3(
C++         dummy, m_tCBDb, m_pParameters->m_bulkJctPotential,
C++         m_pParameters->m_capBD, m_pParameters->m_bulkJctBotGradingCoeff,
C++         m_pDevice->m_dTemp, m_pParameters->m_tnom);
C++      //       m_tCBDb = JunctionCapDepTemp(
C++      //          m_pParameters->m_capBD, m_pParameters->m_bulkJctBotGradingCoeff,
C++      //          m_pParameters->m_bulkJctPotential,
C++      //          m_pDevice->m_dTemp, m_pParameters->m_tnom);
C++      m_tCBDs = 0.0;
C++   }
C++   else
C++   {
C++      m_tCBDb = m_tCj * m_pDevice->m_drainArea;
C++      m_tCBDs = m_tCjsw * m_pDevice->m_drainPerimiter;
C++   } */

      //  if (m_pParameters->m_capBDValue->IsGiven())
        if (in_p.m_capBDIsGiven > 0.5) then
          (dummy, out_c.m_tCBDb) := Equation.JunctionParamDepTempSPICE3(
                                    in_p.m_bulkJctPotential, in_p.m_capBD,
                                    in_p.m_bulkJctBotGradingCoeff, in_m.m_dTemp, in_p.m_tnom);
          out_c.m_tCBDs          := 0.0;
        else
          out_c.m_tCBDb := out_c.m_tCj * in_m.m_drainArea;
          out_c.m_tCBDs := out_c.m_tCjsw * in_m.m_drainPerimiter;
        end if;

      /*   if (m_pParameters->m_capBSValue->IsGiven())
C++   {
C++      m_pDevice->JunctionParamDepTempSPICE3(
C++         dummy, m_tCBSb, m_pParameters->m_bulkJctPotential,
C++         m_pParameters->m_capBS, m_pParameters->m_bulkJctBotGradingCoeff,
C++         m_pDevice->m_dTemp, m_pParameters->m_tnom);
C++      //       m_tCBSb = JunctionCapDepTemp(
C++      //          m_pParameters->m_capBS, m_pParameters->m_bulkJctBotGradingCoeff,
C++      //          m_pParameters->m_bulkJctPotential,
C++      //          m_pDevice->m_dTemp, m_pParameters->m_tnom);
C++      m_tCBSs = 0.0;
C++   }
C++   else
C++   {
C++      m_tCBSb = m_tCj * m_pDevice->m_sourceArea;
C++      m_tCBSs = m_tCjsw * m_pDevice->m_sourcePerimiter;
C++   }
C++   m_pDevice->JunctionCapCoeffs(
C++      m_f1b, m_f2b, m_f3b, m_pParameters->m_bulkJctBotGradingCoeff,
C++      m_pParameters->m_fwdCapDepCoeff, m_tBulkPot);
C++   m_dVt   = m_pDevice->m_dTemp * m_pDevice->CONSTKoverQ;
C++   } */

      //  if (m_pParameters->m_capBSValue->IsGiven())
        if (in_p.m_capBSIsGiven > 0.5) then
          (dummy, out_c.m_tCBSb) := Equation.JunctionParamDepTempSPICE3(
                                    in_p.m_bulkJctPotential, in_p.m_capBS,
                                    in_p.m_bulkJctBotGradingCoeff, in_m.m_dTemp, in_p.m_tnom);
          out_c.m_tCBSs          := 0.0;
        else
          out_c.m_tCBSb := out_c.m_tCj * in_m.m_sourceArea;
          out_c.m_tCBSs := out_c.m_tCjsw * in_m.m_sourcePerimiter;
        end if;
         (out_c.m_f1b, out_c.m_f2b, out_c.m_f3b) := Equation.JunctionCapCoeffs(
                                                    in_p.m_bulkJctBotGradingCoeff,
                                                    in_p.m_fwdCapDepCoeff, out_c.m_tBulkPot);
        out_c.m_dVt   := in_m.m_dTemp * SpiceRoot.SPICEcircuitCONST.CONSTKoverQ;

      end Mos2CalcCalcTempDependencies;

      function Mos2CalcNoBypassCode
      /* void MosCalc::NoBypassCode() */

        input Mosfet.Mosfet in_m;
        input Integer in_m_type;
        input Mos2.Mos2Calc in_c;
        input Mos2.Mos2ModelLineParams in_p;
        input SpiceConstants in_C;
        input Mos2.Mos2ModelLineVariables in_vp;
        //input DEVqmeyer in_qm;                 // qmeyer-Parameter vom letzten Schritt
        input Boolean in_m_bInit;
        input Real[4] in_m_pVoltageValues; /* gate bulk drain source */

        output CurrrentsCapacitances out_cc;

        output DEVqmeyer qm;

      protected
        Real vbd;
        Real vgd;
        Real vgb;
        Real cur;
        Integer n;

        DEVqmeyer in_qm;  // muss hier wieder raus
        Mos2.Mos2Calc int_c;
        Mosfet.Mosfet int_m;

        Real zzz;

      algorithm
        int_c := in_c;

      /*{m_vds = m_pModel->m_type * m_pDevice->GetVoltage( DP, SP);
   m_vgs = m_pModel->m_type * m_pDevice->GetVoltage( G , SP);
   m_vbs = m_pModel->m_type * m_pDevice->GetVoltage( B , SP); */

        int_c.m_vgs := in_m_type * (in_m_pVoltageValues[1] - in_m_pVoltageValues[4]); // ( G , SP)
        int_c.m_vbs := in_m_type * (in_m_pVoltageValues[2] - in_m_pVoltageValues[4]); // ( B , SP)
        int_c.m_vds := in_m_type * (in_m_pVoltageValues[3] - in_m_pVoltageValues[4]); // ( DP, SP)

      /* if (m_pDevice->UseInitialConditions() && m_pDevice->m_ICVBSValue->IsGiven())
C++      m_vbs = m_pModel->m_type * m_pDevice->m_dICVBS;
C++   else if (m_pDevice->InitJunctionVoltages())
C++      if (m_pDevice->m_off)
C++         m_vbs = 0.;
C++      else
C++         m_vbs = m_VBScrit;
C++   if (m_pDevice->UseInitialConditions() && m_pDevice->m_ICVDSValue->IsGiven())
C++      m_vds = m_pModel->m_type * m_pDevice->m_dICVDS;
C++   else if (m_pDevice->InitJunctionVoltages())
C++      if (m_pDevice->m_off)
C++         m_vds = 0.;
C++      else
C++         m_vds = m_VBDcrit - m_VBScrit;
C++   if (m_pDevice->UseInitialConditions() && m_pDevice->m_ICVGSValue->IsGiven())
C++      m_vgs = m_pModel->m_type * m_pDevice->m_dICVGS;
C++   else if (m_pDevice->InitJunctionVoltages())
C++      if (m_pDevice->m_off)
C++         m_vgs = 0.; */

        if ( SpiceRoot.UseInitialConditions())    and (in_m.m_dICVBSIsGiven >0.5) then
          int_c.m_vbs := in_m_type * in_m.m_dICVBS;
        elseif ( SpiceRoot.InitJunctionVoltages()) then
          int_c.m_vbs := if (in_m.m_off >0.5) then 0. else int_c.m_VBScrit;
        end if;
        if ( SpiceRoot.UseInitialConditions()) and (in_m.m_dICVDSIsGiven > 0.5) then
          int_c.m_vds := in_m_type * in_m.m_dICVDS;
        elseif ( SpiceRoot.InitJunctionVoltages()) then
          int_c.m_vds := if (in_m.m_off > 0.5) then 0. else (int_c.m_VBDcrit - int_c.m_VBScrit);
        end if;
        if ( SpiceRoot.UseInitialConditions()) and (in_m.m_dICVGSIsGiven > 0.5) then
          int_c.m_vgs := in_m_type * in_m.m_dICVGS;
        elseif ( SpiceRoot.InitJunctionVoltages()) then
          if ( in_m.m_off > 0.5) then
            int_c.m_vgs := 0.;
          end if;
        end if;

      /* if (!m_vds && !m_vgs && !m_vbs && !m_pDevice->UseInitialConditions() &&
C++       !m_pDevice->m_off)
C++   {
C++      m_vbs = -1;
C++      m_vgs = m_pModel->m_type * m_tVto;
C++      m_vds = 0;
C++   }

C++   double vbd = m_vbs - m_vds;
C++   double vgd = m_vgs - m_vds;

C++   if (m_vds >= 0)
C++   {
C++      m_vbs = m_pDevice->LimitJunctionVoltage( m_vbs, m_dVt, m_VBScrit);
C++      vbd = m_vbs-m_vds;
C++   } else {
C++      vbd = m_pDevice->LimitJunctionVoltage( vbd, m_dVt, m_VBDcrit);
C++      m_vbs = vbd + m_vds;
C++   }
C++
C++   double vgb = m_vgs - m_vbs; */

      /***** eigentlich muss die folgende Stelle so aussehen: ****/
      //if (not(int_c.m_vds) and  not(int_c.m_vgs) and not(int_c.m_vbs) and not (SpiceRoot.UseInitialConditions()) and  not(in_m.m_off)) then
        if (int_c.m_vds<>0 and  int_c.m_vgs<>0 and int_c.m_vbs<>0 and not (SpiceRoot.UseInitialConditions()) and  (in_m.m_off<>0)) then
          int_c.m_vbs := -1;
          int_c.m_vgs := in_m_type * int_c.m_tVto;
          int_c.m_vds := 0;
        end if;

        vbd := int_c.m_vbs - int_c.m_vds;
        vgd := int_c.m_vgs - int_c.m_vds;

        if ( int_c.m_vds >= 0) then
         int_c.m_vbs := SpiceRoot.LimitJunctionVoltage(int_c.m_vbs);
          vbd         := int_c.m_vbs - int_c.m_vds;
        else
          vbd         := SpiceRoot.LimitJunctionVoltage(vbd);
          int_c.m_vbs := vbd + int_c.m_vds;
        end if;

        vgb := int_c.m_vgs - int_c.m_vbs;

      /*   //////////////////////////////////////////////////////////////////////
C++   // resistances
C++   m_pDevice->InternConductance( D, DP, m_drainConductance);
C++   m_pDevice->InternConductance( S, SP, m_sourceConductance); */

      /*   //////////////////////////////////////////////////////////////////////
C++   // bulk-source and bulk-drain diodes here we just
C++   // evaluate the ideal diode current and the
C++   // corresponding derivative (conductance).
C++   // m_pDevice->Junction2( cbd, gbd, vbd, m_pDevice->m_dTemp, 1., m_tDrainSatCur);
C++   m_pDevice->Junction2_SPICE3_MOSFET( m_cbd, m_gbd, vbd, m_pDevice->m_dTemp, 1., m_tDrainSatCur);
C++   m_pDevice->InsertConductance(
C++      B, DP, m_gbd, m_pModel->m_type * m_cbd, m_pModel->m_type * vbd);
C++   //    Junction2( cbs, gbs, vbs, m_pDevice->m_dTemp, 1., m_tSourceSatCur);
C++   m_pDevice->Junction2_SPICE3_MOSFET( m_cbs, m_gbs, m_vbs, m_pDevice->m_dTemp, 1., m_tSourceSatCur);
C++   m_pDevice->InsertConductance(
C++      B, SP, m_gbs, m_pModel->m_type * m_cbs, m_pModel->m_type * m_vbs); */

         (int_c.m_cbd, int_c.m_gbd) := Equation.Junction2_SPICE3_MOSFET( int_c.m_cbd, int_c.m_gbd, vbd,
                                       in_m.m_dTemp, 1., int_c.m_tDrainSatCur);
         out_cc.iBD                 := in_m_type * int_c.m_cbd;
         (int_c.m_cbs, int_c.m_gbs) := Equation.Junction2_SPICE3_MOSFET( int_c.m_cbs, int_c.m_gbs, int_c.m_vbs,
                                       in_m.m_dTemp, 1., int_c.m_tSourceSatCur);
         out_cc.iBS                 := in_m_type * int_c.m_cbs;

      /*   //////////////////////////////////////////////////////////////////////
C++   // now to determine whether the user was able to
C++   // correctly identify the source and drain of his
C++   // device
C++   if (m_vds >= 0)
C++      m_mode =  1; // normal mode
C++   else
C++      m_mode = -1; // inverse mode */

        int_c.m_mode := if (int_c.m_vds >= 0) then 1 else -1; // 1: normal mode, -1: inverse mode

      /*   //////////////////////////////////////////////////////////////////////
C++   // this block of code evaluates the drain
C++   // current and its derivatives
C++   if (m_mode == 1)
C++      // Let the actual instance calculate the values
C++      DrainCur( m_vbs, m_vgs, m_vds, m_cdrain, m_gm, m_gmbs, m_gds);
C++   else
C++      DrainCur( vbd, vgd, -m_vds, m_cdrain, m_gm, m_gmbs, m_gds);
C++   m_pDevice->InsertNonChargeCurrent(
C++      DP, SP, m_pModel->m_type * m_cdrain * m_mode,
C++      DP, SP, m_gds, m_pModel->m_type * m_vds,
C++      G, m_mode == 1 ? SP : DP, m_mode * m_gm, m_pModel->m_type * (m_mode == 1 ? m_vgs : vgd),
      B, m_mode == 1 ? SP : DP, m_mode * m_gmbs, m_pModel->m_type * (m_mode == 1 ? m_vbs : vbd)); */

        if (int_c.m_mode == 1) then

          int_c := Mos2.DrainCur( int_c.m_vbs, int_c.m_vgs, int_c.m_vds,int_m, int_c, in_p, in_C, in_vp, in_m_type);
        else
          int_c := Mos2.DrainCur( vbd,               vgd,  -int_c.m_vds,int_m, int_c, in_p, in_C, in_vp, in_m_type);
        end if;

        n      := if (int_c.m_mode == 1) then 6 else 5;
        out_cc.idrain := in_m_type * int_c.m_cdrain * int_c.m_mode;

        zzz := int_c.m_cdrain;
        // out_cc.idrain := zzz; //in_m_pVoltageValues[3]; //int_c.m_vds;

      /*   //////////////////////////////////////////////////////////////////////
C++   // now we do the hard part of the bulk-drain and bulk-source diode -
C++   // we evaluate the non-linear capacitance and charge
C++   m_capbss    = 0.0;
C++   m_chargebss = 0.0;
C++   m_capbds    = 0.0;
C++   m_chargebds = 0.0;
C++   m_pDevice->JunctionCap(
C++      m_capbsb, m_chargebsb, m_tCBSb, m_vbs, m_tDepCap,
C++      m_pParameters->m_bulkJctBotGradingCoeff, m_tBulkPot,
C++      m_f1b, m_f2b, m_f3b);
C++   m_pDevice->JunctionCap(
C++      m_capbdb, m_chargebdb, m_tCBDb, vbd, m_tDepCap,
C++      m_pParameters->m_bulkJctBotGradingCoeff, m_tBulkPot,
C++      m_f1b, m_f2b, m_f3b);
C++   if (!m_pParameters->m_capBSValue->IsGiven())
C++      m_pDevice->JunctionCap(
C++         m_capbss, m_chargebss, m_tCBSs, m_vbs, m_tDepCap,
C++         m_pParameters->m_bulkJctSideGradingCoeff, m_tBulkPot,
C++         m_f1s, m_f2s, m_f3s);
C++   if (!m_pParameters->m_capBDValue->IsGiven())
C++      m_pDevice->JunctionCap(
C++         m_capbds, m_chargebds, m_tCBDs, vbd, m_tDepCap,
C++         m_pParameters->m_bulkJctSideGradingCoeff, m_tBulkPot,
C++         m_f1s, m_f2s, m_f3s);
C++   m_pDevice->InsertCapacitance(
C++      B, SP, m_capbsb + m_capbss, m_pModel->m_type * (m_chargebsb + m_chargebss),
C++      m_pModel->m_type * m_vbs);
C++   m_pDevice->InsertCapacitance(
C++      B, DP, m_capbdb + m_capbds, m_pModel->m_type * (m_chargebdb + m_chargebds),
C++      m_pModel->m_type * vbd); */

        int_c.m_capbss    := 0.0;
        int_c.m_chargebss := 0.0;
        int_c.m_capbds    := 0.0;
        int_c.m_chargebds := 0.0;
        (int_c.m_capbsb, int_c.m_chargebsb) := Equation.JunctionCap(
               int_c.m_tCBSb, int_c.m_vbs, int_c.m_tDepCap,
               in_p.m_bulkJctBotGradingCoeff, int_c.m_tBulkPot,
               int_c.m_f1b, int_c.m_f2b, int_c.m_f3b);

        (int_c.m_capbdb, int_c.m_chargebdb) := Equation.JunctionCap(
               int_c.m_tCBDb, vbd, int_c.m_tDepCap,
               in_p.m_bulkJctBotGradingCoeff, int_c.m_tBulkPot,
               int_c.m_f1b, int_c.m_f2b, int_c.m_f3b);

      //  if ( not in_p.m_capBSIsValue->IsGiven()) then
        if ( not (in_p.m_capBSIsGiven > 0.5)) then
          (int_c.m_capbss, int_c.m_chargebss) := Equation.JunctionCap(
               int_c.m_tCBSs,int_c. m_vbs, int_c.m_tDepCap,
               in_p.m_bulkJctSideGradingCoeff, int_c.m_tBulkPot,
               int_c.m_f1s, int_c.m_f2s, int_c.m_f3s);
        end if;
      //  if (not in_p.m_capBDValue->IsGiven()) then
        if (not (in_p.m_capBDIsGiven > 0.5)) then
          (int_c.m_capbds, int_c.m_chargebds) := Equation.JunctionCap(
               int_c.m_tCBDs, vbd, int_c.m_tDepCap,
               in_p.m_bulkJctSideGradingCoeff, int_c.m_tBulkPot,
               int_c.m_f1s, int_c.m_f2s, int_c.m_f3s);
        end if;

      //   m_pDevice->InsertCapacitance(
      //      B, SP, m_capbsb + m_capbss, m_pModel->m_type * (m_chargebsb + m_chargebss),
      //      m_pModel->m_type * m_vbs);
        out_cc.cBS := if (in_m_bInit) then 1e-15 else (int_c.m_capbsb + int_c.m_capbss); //statt 1e-15 eigentlich 0

      //   m_pDevice->InsertCapacitance(
      //      B, DP, m_capbdb + m_capbds, m_pModel->m_type * (m_chargebdb + m_chargebds),
      //      m_pModel->m_type * vbd); */
        out_cc.cBD := if (in_m_bInit) then 1e-15 else (int_c.m_capbdb + int_c.m_capbds);  //statt 1e-15 eigentlich 0

      /*   //////////////////////////////////////////////////////////////////////
C++   // Last we have to calculate the gate capacitances
C++   // calculate meyer's capacitors
C++   // new cmeyer - this just evaluates at the current time,
C++   // expects you to remember values from previous time returns 1/2 of
C++   // non-constant portion of capacitance you must add in the other half
C++   // from previous time and the constant part
C++   if (m_mode > 0)
C++      DEVqmeyer( m_vgs, vgd, vgb, MOScapgs, MOScapgd, MOScapgb);
C++   else
C++      DEVqmeyer( vgd, m_vgs, vgb, MOScapgd, MOScapgs, MOScapgb); */

        if (int_c.m_mode > 0) then
          qm := MosCalcDEVqmeyer( int_c.m_vgs, vgd, vgb, int_c);
        else
          qm := MosCalcDEVqmeyer( vgd, int_c.m_vgs, vgb, int_c);
        end if;
        in_qm := qm;
      /* if (m_pDevice->m_bInit)
C++   {
C++      m_capgd = 2 * m_pDevice->GetHistoryValue( MOScapgd, 0) + m_capGDovl;
C++      m_capgs = 2 * m_pDevice->GetHistoryValue( MOScapgs, 0) + m_capGSovl;
C++      m_capgb = 2 * m_pDevice->GetHistoryValue( MOScapgb, 0) + m_capGBovl;
C++      m_qgs   = m_capgs * m_vgs;
C++      m_qgb   = m_capgb * vgb;
C++      m_qgd   = m_capgd * vgd;
C++   }
C++   else
C++   {
C++      m_capgd = m_pDevice->GetHistoryValue( MOScapgd, 0) + m_pDevice->GetHistoryValue( MOScapgd) + m_capGDovl;
C++      m_capgs = m_pDevice->GetHistoryValue( MOScapgs, 0) + m_pDevice->GetHistoryValue( MOScapgs) + m_capGSovl;
C++      m_capgb = m_pDevice->GetHistoryValue( MOScapgb, 0) + m_pDevice->GetHistoryValue( MOScapgb) + m_capGBovl;
C++      m_qgs   = (m_vgs - m_pDevice->GetHistoryValue( MOSvgs)) * m_capgs + m_pDevice->GetHistoryValue( MOSqgs);
C++      m_qgb   = (vgb - m_pDevice->GetHistoryValue( MOSvgb)) * m_capgb + m_pDevice->GetHistoryValue( MOSqgb);
C++      m_qgd   = (vgd - m_pDevice->GetHistoryValue( MOSvgd)) * m_capgd + m_pDevice->GetHistoryValue( MOSqgd);
C++   } */

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

      /* m_pDevice->SetHistoryValue( MOSqgs, m_qgs);
C++   m_pDevice->SetHistoryValue( MOSqgb, m_qgb);
C++   m_pDevice->SetHistoryValue( MOSqgd, m_qgd);
C++   m_pDevice->SetHistoryValue( MOSvgs, m_vgs);
C++   m_pDevice->SetHistoryValue( MOSvgb, vgb);
C++   m_pDevice->SetHistoryValue( MOSvgd, vgd); */

        qm.qm_qgs := int_c.m_qgs;
        qm.qm_qgb := int_c.m_qgb;
        qm.qm_qgd := int_c.m_qgd;
        qm.qm_vgs := int_c.m_vgs;
        qm.qm_vgb := vgb;
        qm.qm_vgd := vgd;

        //C++ neue qmeyer-Parameter fuer naechsten Rechenschritt ablegen
      //C++  out_qm := qm;

      /* m_pDevice->InsertCapacitance(
C++      G, DP, m_capgd, m_pModel->m_type * m_qgd, m_pModel->m_type * vgd);
C++   m_pDevice->InsertCapacitance(
C++      G, SP, m_capgs, m_pModel->m_type * m_qgs, m_pModel->m_type * m_vgs);
C++   m_pDevice->InsertCapacitance(
C++      G, B , m_capgb, m_pModel->m_type * m_qgb, m_pModel->m_type * vgb);} */

        out_cc.cGB := if (in_m_bInit) then -1e40 else int_c.m_capgb;//+qm.qm_capgb;  //statt 1e-15 eigentlich 0
        out_cc.cGD := if (in_m_bInit) then -1e40 else out_cc.m_capgd;//+qm.qm_capgd;  //statt 1e-15 eigentlich 0
        out_cc.cGS := if (in_m_bInit) then -1e40 else int_c.m_capgs;//+qm.qm_capgs;  //statt 1e-15 eigentlich 0

      end Mos2CalcNoBypassCode;
    end Mos;

    package Mos1
      record Mos1ModelLineParams
        extends Mos.MosModelLineParams(
         m_lambda( start = 0.0),
         m_transconductance( start = 2.0e-5));
         // LAMBDA, Channel length modulation
         // KP, Transconductance parameter

      /*Mos1ModelLineParams::Mos1ModelLineParams( Mosfet_Model_Line* model)
        : MosModelLineParams( model)
{
   m_pModel->AddParameter( "LAMBDA", m_lambda, 0.0);         // Channel length modulation
   m_transconductanceValue = m_pModel->AddParameter( "KP", m_transconductance, 2e-5); //Transconductance parameter
}*/
      end Mos1ModelLineParams;

      record Mos1Calc
        extends Mos.MosCalc;

      /* Mos1Calc::Mos1Calc(
   Mosfet* device, Mosfet_Model_Line* model, const Mos1ModelLineParams* params)
        : MosCalc( device, model, params),
          m_pParameters( params)
{} */

      end Mos1Calc;

      function Mos1ModelLineParamsInitEquations
      /* void Mos1ModelLineParams::InitEquations()
{ // some double's to make the source better readable
   double vtnom;
   double fermis, fermig;
   double wkfng, wkfngs;
   double egfet1;
   double vfb;*/

        input Mos1ModelLineParams in_p;
        input SpiceConstants in_C;
        input Integer in_m_type;

        output Mos.MosModelLineVariables out_v;

      protected
        Real vtnom;
        Real fermis;
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
      /*   //    MosModelLineParams::InitEquations();
   vtnom = m_tnom * CONSTKoverQ;
   egfet1 = 1.16 - (7.02e-4 * m_tnom * m_tnom) / (m_tnom + 1108);*/

        vtnom  := in_p.m_tnom*SpiceRoot.SPICEcircuitCONST.CONSTKoverQ;
        egfet1 := 1.16 - (7.02e-4*in_p.m_tnom*in_p.m_tnom)/(in_p.m_tnom + 1108);

      /*//
   if ((!m_oxideThicknessValue->IsGiven())||(m_oxideThickness == 0)) - Spice3f4; aber dort default-Value: 1.0e-07
   if (m_oxideThickness == 0)
      m_oxideCapFactor = 0;
   else
   {
      m_oxideCapFactor = 3.9 * 8.854214871e-12 / m_oxideThickness;
      if (!m_transconductanceValue->IsGiven())
         m_transconductance = m_surfaceMobility * m_oxideCapFactor * 1e-4; // (m**2/cm**2)

      if (m_substrateDopingValue->IsGiven())
      {
         if (m_substrateDoping * 1e6  > 1.45e16) // (cm**3/m**3)
         {
            if (!m_phiValue->IsGiven())
            {
               m_phi = 2 * vtnom * log(m_substrateDoping * 1e6 / 1.45e16); //  (cm**3/m**3)
               m_phi = F_Max(.1, m_phi);
            }
            fermis = m_pModel->m_type * .5 * m_phi;
            wkfng = 3.2;
            if (m_gateType != 0)
            {
               fermig = m_pModel->m_type * m_gateType * .5 * egfet1;
               wkfng = 3.25 + .5 * egfet1 - fermig;
            }
            wkfngs = wkfng - (3.25 + .5 * egfet1 + fermis);

            if (!m_gammaValue->IsGiven())
               m_gamma =
                  sqrt(2 * 11.70 * 8.854214871e-12 * CHARGE * m_substrateDoping *
                       1e6 ) / m_oxideCapFactor; // (cm**3/m**3)

            if (!m_vt0Value->IsGiven())
            {
               vfb   = wkfngs - m_surfaceStateDensity * 1e4
                  * CHARGE / m_oxideCapFactor; //  (cm**2/m**2)
               m_vt0 = vfb + m_pModel->m_type * (m_gamma * sqrt(m_phi) + m_phi);
            }
         }
         else
         {
//            NsubNiEx( m_pModel, m_substrateDoping, 1.45e10).print();
                        ConflictToxNsubEx( m_pModel, m_oxideThickness, m_substrateDoping, 1.45e10).print();
            m_substrateDoping = 0.;
         }
      }
   }
}*/
        /*//   if ((!m_oxideThicknessValue->IsGiven())||(m_oxideThickness == 0)) - Spice3f4; aber dort default-Value: 1.0e-07
C++   if (m_oxideThickness == 0)
C++      m_oxideCapFactor = 0;
C++   else
C++   {
C++      m_oxideCapFactor = 3.9 * 8.854214871e-12 / m_oxideThickness;
C++      if (!m_transconductanceValue->IsGiven())
C++         m_transconductance = m_surfaceMobility * m_oxideCapFactor * 1e-4; // (m**2/cm**2)
*/

        if (not (in_p.m_oxideThicknessIsGiven > 0.5) or in_p.m_oxideThickness == 0) then
          if
            (in_p.m_oxideThickness == 0) then
            out_v.m_oxideCapFactor := 0;
          end if;
        else
          out_v.m_oxideCapFactor := 3.9 * 8.854214871e-12 / in_p.m_oxideThickness;

      //  out_v.m_oxideCapFactor := if (in_p.m_oxideThickness == 0) then 0 else 3.9 * 8.854214871e-12 / in_p.m_oxideThickness;

          if (out_v.m_oxideCapFactor <> 0) then

            if (not (in_p.m_transconductanceIsGiven > 0.5)) then
              out_v.m_transconductance := in_p.m_surfaceMobility * out_v.m_oxideCapFactor * 1e-4; // (m**2/cm**2)
            end if;
            if (in_p.m_substrateDopingIsGiven > 0.5) then
              if (in_p.m_substrateDoping * 1e6 > 1.45e16) then // (cm**3/m**3)
                if (not (in_p.m_phiIsGiven > 0.5)) then
                  out_v.m_phi := 2*vtnom*Modelica.Math.log(in_p.m_substrateDoping*1e6/1.45e16); // (cm**3/m**3)
                  out_v.m_phi := max(.1, out_v.m_phi);
                end if;
                fermis := in_m_type *.5  * out_v.m_phi;
                wkfng  := 3.2;
                if (in_p.m_gateType <> 0) then
                  fermig := in_m_type * in_p.m_gateType *.5  * egfet1;
                  wkfng  := 3.25 +.5  * egfet1 - fermig;
                end if;
                wkfngs := wkfng - (3.25 +.5  * egfet1 + fermis);
                if (not (in_p.m_gammaIsGiven > 0.5)) then
                  out_v.m_gamma := sqrt(2 * 11.70 * 8.854214871e-12 * SpiceRoot.SPICEcircuitCONST.CHARGE *
                                   in_p.m_substrateDoping * 1e6 / out_v.m_oxideCapFactor);                     // (cm**3/m**3)
                end if;
                if (not (in_p.m_vtOIsGiven > 0.5)) then
                  vfb         := wkfngs - in_p.m_surfaceStateDensity * 1e4 * SpiceRoot.SPICEcircuitCONST.CHARGE / out_v.m_oxideCapFactor; // (cm**2/m**2)
                  out_v.m_vt0 := vfb + in_m_type * (out_v.m_gamma * sqrt(out_v.m_phi) + out_v.m_phi);
                  //            else
                  //              //ConflictToxNsubEx( m_pModel, m_oxideThickness, m_substrateDoping, 1.45e10).print();
                  //              out_v.m_substrateDoping :=  0.;
                end if;
              end if;
            end if;
          end if;
        end if;
      end Mos1ModelLineParamsInitEquations;

      function DrainCur
      /*   double vb, double vg, double vds,
   double &cdrain, double &gm, double &gmbs, double &gds)  */
        input Real vb;
        input Real vg;
        input Real vds;

        input Mos1Calc in_c;
        input Mos1ModelLineParams in_p;
        input SpiceConstants in_C;
        input Mos.MosModelLineVariables in_vp;
        input Integer in_m_type;

        output Mos1Calc out_c;

      /* double arg, betap, sarg, vgst; */
      protected
        Real arg;
        Real betap;
        Real sarg;
        Real vgst;

      algorithm
        out_c := in_c;

      /*
C++   if (vb <= 0)
C++      sarg = sqrt( m_tPhi - vb);
C++   else
C++   {
C++      sarg = sqrt( m_tPhi);
C++      sarg = sarg - vb / (sarg + sarg);
C++      sarg = F_Max( 0., sarg);
C++   }
*/

         if (vb <= 0) then
            sarg := sqrt( out_c.m_tPhi - vb);
         else
            sarg := sqrt( out_c.m_tPhi);
            sarg := sarg - vb / (sarg + sarg);
            sarg := max( 0., sarg);
         end if;

      /*
C++   m_von   = (m_tVbi * m_pModel->m_type) + m_pParameters->m_gamma * sarg;
C++   vgst    = vg - m_von;
C++   m_vdsat = F_Max( vgst, 0.);
C++   if (sarg <= 0)
C++      arg = 0;
C++   else
C++      arg  = m_pParameters->m_gamma / (sarg + sarg);
*/
         out_c.m_von   := (out_c.m_tVbi * in_m_type) + in_vp.m_gamma * sarg;
         vgst          := vg - out_c.m_von;
         out_c.m_vdsat := max( vgst, 0.);
         arg           := if (sarg <= 0) then 0 else in_vp.m_gamma / (sarg + sarg);
      /*
C++
C++   if (vgst <= 0)
C++   {
C++      // cutoff region
C++      cdrain = 0;
C++      gm     = 0;
C++      gds    = 0;
C++      gmbs   = 0;
C++   }
C++   else
C++   {
C++      betap = m_Beta * (1 + m_pParameters->m_lambda * vds);
C++      if (vgst <= vds)
C++      {
C++         // saturation region
C++         cdrain = betap * vgst * vgst * .5;
C++         gm     = betap * vgst;
C++         gds    = m_pParameters->m_lambda * m_Beta * vgst * vgst * .5;
C++         gmbs   = gm * arg;
C++      }
C++      else
C++      {
C++         // linear region
C++         cdrain = betap * vds * (vgst - .5 * vds);
C++         gm     = betap * vds;
C++         gds    = betap * (vgst - vds) +
C++            m_pParameters->m_lambda * m_Beta * vds * (vgst - .5 * vds);
C++         gmbs   = gm * arg;
C++      }
C++   }
*/
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

      end DrainCur;

      function Mos1RenameParameters
        "renames the external parameters (e.g. RD) into the internal names (e.g. m_drainResistance)"

        input Spice3.Repository.modelcardMOS ex;
        input Spice3.Repository.SpiceConstants con;
        // input Boolean mtype;
        // input Real W;
        // input Real L;
        // input Real AD;
        // input Real AS;
        // input Real PD;
        // input Real PS;
        // input Real NRD;
        // input Real NRS;
        // input Boolean OFF;
        // input Real IC;
       // input Real TEMP;

        output Mos.MosModelLineParams intern;

      algorithm
        // from MosModelLinesParams

         intern.m_oxideCapFactor := 0;              // not available in modelcard parameters????

         //intern.m_vt0 := ex.VTO;                    // V zero-bias threshold voltage (default 0)

          intern.m_vtOIsGiven := if          (ex.VTO > -1e40) then 1 else 0;
          intern.m_vt0 := if         (ex.VTO > -1e40) then ex.VTO else 0;

          //intern.m_capBD := ex.CBD;                  // F zero-bias B-D junction capacitance (default 0)

          intern.m_capBDIsGiven := if          (ex.CBD > -1e40) then 1 else 0;
          intern.m_capBD := if         (ex.CBD > -1e40) then ex.CBD else 0;

         // intern.m_capBS := ex.CBS;                  // F zero-bias B-S junction capacitance (default 0)

          intern.m_capBSIsGiven := if          (ex.CBS > -1e40) then 1 else 0;
          intern.m_capBS := if         (ex.CBS > -1e40) then ex.CBS else 0;

        //  intern.m_bulkCapFactor := ex.CJ;           // F/(m*m) zero-bias bulk junction bottom cap. per sq-meter of junction area (default 0)

          intern.m_bulkCapFactorIsGiven := if          (ex.CJ > -1e40) then 1 else 0;
          intern.m_bulkCapFactor := if         (ex.CJ > -1e40) then ex.CJ else 0;

          intern.m_sideWallCapFactor := ex.CJSW;     // F/m zero-bias junction sidewall cap. per meter of junction perimeter (default 0)
          intern.m_fwdCapDepCoeff := ex.FC;          // coefficient for forward-bias depletion capacitance formula (default 0.5)
      //  intern.m_phi := ex.PHI;                    // V surface potential (default 0.6)

          intern.m_phiIsGiven := if          (ex.PHI > -1e40) then 1 else 0;
          intern.m_phi := if         (ex.PHI > -1e40) then ex.PHI else 0.6;

       //  intern.m_gamma := ex.GAMMA;                // V bulk threshold parameter (default 0)

          intern.m_gammaIsGiven := if          (ex.GAMMA > -1e40) then 1 else 0;
          intern.m_gamma := if         (ex.GAMMA > -1e40) then ex.GAMMA else 0;

          intern.m_lambda := ex.LAMBDA;              // 1/V channel-length modulation (default 0)

      //  intern.m_substrateDoping := ex.NSUB;       // substrate doping (default 0)

          intern.m_substrateDopingIsGiven := if          (ex.NSUB > -1e40) then 1 else 0;
          intern.m_substrateDoping := if         (ex.NSUB > -1e40) then ex.NSUB else 0;

          intern.m_gateType := ex.TPG;               // type of gate material: +1 opp. to substrate, -1 same as substrate, 0 Al gate (default 1)
          intern.m_surfaceStateDensity := ex.NSS;    // 1/(cm*cm) surface state density (default 0)
          intern.m_surfaceMobility := ex.UO;         // (cm*cm)/(Vs) surface mobility (default 600)
          intern.m_latDiff := ex.LD;                 // m lateral diffusion (default 0)
          intern.m_jctSatCur := ex.IS;               // A bulk junction saturation current (defaul 1e-14)

          //intern.m_drainResistance := ex.RD;         // Ohm drain ohmic resistance (default 0)

          intern.m_drainResistanceIsGiven := if
                                               (ex.RD > -1e40) then 1 else 0;
          intern.m_drainResistance := if
                                       (ex.RD > -1e40) then ex.RD else 0;

        //  intern.m_sourceResistance := ex.RS;        // Ohm source ohmic resistance (default 0)

           intern.m_sourceResistanceIsGiven := if
                                               (ex.RS > -1e40) then 1 else 0;
          intern.m_sourceResistance := if
                                       (ex.RS > -1e40) then ex.RS else 0;

        //  intern.m_transconductance := ex.KP;        // A/(V*V) transconductance parameter (default 2e-5)

          intern.m_transconductanceIsGiven := if          (ex.KP > -1e40) then 1 else 0;
          intern.m_transconductance := if         (ex.KP > -1e40) then ex.KP else 2e-5;

      //    intern.m_tnom := ex.TNOM;
          intern.m_tnom := if (ex.TNOM > -1e40) then ex.TNOM + SpiceRoot.SPICEcircuitCONST.CONSTCtoK else 300.15;

                        // °C parameter measurement temperature (default 27)

      // from MosfetModelLinesParams
         intern.m_jctSatCurDensity := ex.JS;             // A/(m*m) bulk junction saturation current per sq-meter of junction area (default 0)
         intern.m_sheetResistance := ex.RSH;             // Ohm drain and source diffusion sheet resistance (default 0)
         intern.m_bulkJctPotential := ex.PB;             // V bulk junction potential (default 0.8)
         intern.m_bulkJctBotGradingCoeff := ex.MJ;       // bulk junction bottom grading coeff. (default 0.5)
         intern.m_bulkJctSideGradingCoeff := ex.MJSW;    // bulk junction sidewall grading coeff. (default 0.5)

      // intern.m_oxideThickness := ex.TOX;              // m oxide thickness (default 1e-7)

         intern.m_oxideThicknessIsGiven := if          (ex.TOX > -1e40) then 1 else 0;
          intern.m_oxideThickness := if         (ex.TOX > -1e40) then ex.TOX else 0;

         intern.m_gateSourceOverlapCapFactor := ex.CGSO; // F/m gate-source overlap capacitance per meter channel width (default 0)
         intern.m_gateDrainOverlapCapFactor := ex.CGDO;  // F/m gate-drain overlap capacitance per meter channel width (default 0)
         intern.m_gateBulkOverlapCapFactor := ex.CGBO;   // F/m gate-bulk overlap capacitance per meter channel width (default 0)
         intern.m_fNcoef := ex.KF;                       // flicker-noise coefficient (default 0)
         intern.m_fNexp := ex.AF;                        // flicker-noise exponent (default 1)

      end Mos1RenameParameters;

      function Mos1RenameParameters_dev
        "renames the external parameters (e.g. RD) into the internal names (e.g. m_drainResistance)"
        input Spice3.Repository.modelcardMOS ex;
       // input Spice3.Attempt_1_konstanten_parameter_inArbeit.SpiceConstants con;
        input Real mtype;
        input Real W;
        input Real L;
        input Real AD;
        input Real AS;
        input Real PD;
        input Real PS;
        input Real NRD;
        input Real NRS;
        input Real OFF;
        input Real IC;
        input Real TEMP;

        output Mosfet.Mosfet dev;

      algorithm
      /*device parameters*/
       //  Real m_len(             start = SpiceRoot.SPICEcircuitCONST.CKTdefaultMosL);  // L, length of channel region
        dev.m_len := L;               // L, length of channel region
      //  Real m_width(           start = SpiceRoot.SPICEcircuitCONST.CKTdefaultMosW);  // W, width of channel region
        dev.m_width := W;             // W, width of channel region
        dev.m_drainArea := AD;        // AD, area of drain diffusion
        dev.m_sourceArea := AS;       // AS, area of source diffusion
        dev.m_drainSquares := NRD;    // NRD, length of drain in squares
        dev.m_sourceSquares := NRS;   // NRS, length of source in squares
        dev.m_drainPerimiter := PD;   // PD, Drain perimeter;
        dev.m_sourcePerimiter := PS;  // PS, Source perimeter
      //  dev.m_dICVDS := IC;     // IC_VDS, Initial D-S voltage;

          dev.m_dICVDSIsGiven := if          (IC > -1e40) then 1 else 0;
          dev.m_dICVDS := if         (IC > -1e40) then IC else 0;

      //  dev.m_dICVGS := 1;     // IC_VGS, Initial G-S voltage;

          dev.m_dICVGSIsGiven := if          (IC > -1e40) then 1 else 0;
          dev.m_dICVGS := if         (IC > -1e40) then IC else 0;

      //  dev.m_dICVBS := 2;     // IC_VBS, Initial B-S voltage;

          dev.m_dICVBSIsGiven := if          (IC > -1e40) then 1 else 0;
          dev.m_dICVBS := if         (IC > -1e40) then IC else 0;

        dev.m_off := OFF;             // non-zero to indicate device is off for dc analysis
        dev.m_bPMOS := mtype;         // P type MOSfet model
        dev.m_nLevel := ex.LEVEL;
        assert(ex.LEVEL== 1, "only MOS Level1 implemented");
        dev.m_dTemp :=TEMP + SpiceRoot.SPICEcircuitCONST.CONSTCtoK;
      end Mos1RenameParameters_dev;
    end Mos1;

    package Mos2
      record Mos2ModelLineParams
        extends Spice3.Repository.Mos.MosModelLineParams(
          m_lambda(start=0.0),
          m_transconductance(start=2.0e-5),
          m_bulkJctSideGradingCoeff(start=0.33),
          m_oxideThickness(start=1.0e-7));
        // Channel length modulation
        // Transconductance parameter

        Real m_narrowFactor( start = 0.0);              // DELTA, Width effect on threshold
        Real m_critFieldExp( start = 0.0);              // UEXP, Crit. field exp for mob. deg
        Real m_critField( start = 1.0e4);               // UCRIT, Crit. field for mob. degradation
        Real m_maxDriftVel( start = 0.0);               // VMAX, Maximum carrier drift velocity
        Real m_junctionDepth( start = 0.0);             // XJ, Junction depth
        Real m_channelCharge( start = 1.0);             // NEFF, Total channel charge coeff
        Real m_fastSurfaceStateDensity( start = 0.0);   // NFS, Fast surface state density

      /*
Mos2ModelLineParams::Mos2ModelLineParams( Mosfet_Model_Line* model)
        : MosModelLineParams( model)
{
   m_pModel->AddParameter( "LAMBDA", m_lambda, 0.0);   // Channel length modulation
   m_narrowFactorValue = m_pModel->AddParameter( "DELTA", m_narrowFactor, 0.); // Width effect on threshold
   m_transconductanceValue = m_pModel->AddParameter( "KP", m_transconductance, 2e-5); // Transconductance parameter
   m_pModel->AddParameter( "UEXP", m_critFieldExp, 0.); // Crit. field exp for mob. deg
   m_pModel->AddParameter( "UCRIT", m_critField, 1e4); //Crit. field for mob. degradation
   m_pModel->AddParameter( "VMAX", m_maxDriftVel, 0.);// Maximum carrier drift velocity
   m_pModel->AddParameter( "XJ", m_junctionDepth, 0.);// Junction depth
   m_pModel->AddParameter( "NEFF", m_channelCharge, 1.);// Total channel charge coeff
   m_pModel->AddParameter( "NFS", m_fastSurfaceStateDensity, 0.);// Fast surface state density

   m_oxideThickness          = 1e-7;
   m_bulkJctSideGradingCoeff = .33;
}
*/
      end Mos2ModelLineParams;

      record Mos2ModelLineVariables
        extends Spice3.Repository.Mos.MosModelLineVariables;

        Real m_bulkCapFactor;
        Real m_substrateDoping;
        Real m_xd;

      end Mos2ModelLineVariables;

      record Mos2Calc
        extends Spice3.Repository.Mos.MosCalc;

      /* Mos2Calc::Mos2Calc(
   Mosfet* device, Mosfet_Model_Line* model, const Mos2ModelLineParams* params)
        : MosCalc( device, model, params), m_pParameters( params)
{} */

      end Mos2Calc;

      function Mos2ModelLineParamsInitEquations
      /* void Mos2ModelLineParams::InitEquations()
{  */
           /* some double's to make the source better readable */
                                                                 /*
   double vtnom;
   double fermis, fermig;
   double wkfng, wkfngs;
   double egfet1;
   double vfb; */

        input Mos2ModelLineParams in_p;
        input Spice3.Repository.SpiceConstants in_C;
        input Integer in_m_type;

        output Mos2ModelLineVariables out_v;
        //output Real dummy;
      protected
        Real vtnom;
        Real fermis;
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

      /*   //    MosModelLineParams::InitEquations();
   vtnom = m_tnom * CONSTKoverQ;
   egfet1 = 1.16 - (7.02e-4 * m_tnom * m_tnom) / (m_tnom + 1108);
   m_oxideCapFactor = 3.9 * 8.854214871e-12 / m_oxideThickness; */

        vtnom                  := in_p.m_tnom * in_C.CONSTKoverQ;
        egfet1                 := 1.16 - (7.02e-4 * in_p.m_tnom * in_p.m_tnom) / (in_p.m_tnom + 1108);
        out_v.m_oxideCapFactor := 3.9 * 8.854214871e-12 / in_p.m_oxideThickness;

      /*   if(!m_transconductanceValue->IsGiven())
      m_transconductance = m_surfaceMobility * 1e-4 */
                                                            /*(m**2/cm**2) */
                                                                             /* * m_oxideCapFactor; */

        if ( not (in_p.m_transconductanceIsGiven > 0.5)) then
          out_v.m_transconductance := in_p.m_surfaceMobility * 1.0e-4 * out_v.m_oxideCapFactor;
        end if;

      /*   if(m_substrateDopingValue->IsGiven())
   {
      if(m_substrateDoping * 1e6 */
                                         /*(cm**3/m**3)*/
                                                         /* > 1.45e16)
      {
         if(!m_phiValue->IsGiven())
         {
            m_phi = 2 * vtnom * log( m_substrateDoping * 1e6 */
                                                                     /*(cm**3/m**3)*/
                                                                                     /* / 1.45e16);
            m_phi = F_Max( .1, m_phi);
         }
         fermis = m_pModel->m_type * .5 * m_phi;
         wkfng = 3.2;
         if(m_gateType != 0)
         {
            fermig = m_pModel->m_type * m_gateType * .5 * egfet1;
            wkfng = 3.25 + .5 * egfet1 - fermig;
         }
         wkfngs = wkfng - (3.25 + .5 * egfet1 + fermis);
         if(!m_gammaValue->IsGiven())
            m_gamma = sqrt(2 * 11.70 * 8.854214871e-12 * CHARGE * m_substrateDoping
                           * 1e6 */
                                         /*(cm**3/m**3)*/
                                                         /*) / m_oxideCapFactor;
         if(!m_vt0Value->IsGiven())
         {
            vfb   = wkfngs - m_surfaceStateDensity * 1e4 */
                                                                 /*(cm**2/m**2)*/
                                                                                 /* * CHARGE / m_oxideCapFactor;
            m_vt0 = vfb + m_pModel->m_type * (m_gamma * sqrt(m_phi)+ m_phi);
         }
         else
            vfb = m_vt0 - m_pModel->m_type * (m_gamma * sqrt(m_phi) + m_phi);
         m_xd = sqrt( (EPSSIL + EPSSIL) / (CHARGE * m_substrateDoping * 1e6 */
                                                                                    /*(cm**3/m**3)*/
                                                                                                    /*));
      }
      else
      {
//       NsubNiEx( m_pModel, m_substrateDoping, 1.45e10).print();
                 ConflictToxNsubEx( m_pModel, m_oxideThickness, m_substrateDoping, 1.45e10).print();
         m_substrateDoping = 0.;
      }
   } */

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

      /*   if(!m_bulkCapFactorValue->IsGiven())
      m_bulkCapFactor = sqrt( EPSSIL * CHARGE * m_substrateDoping
                              * 1e6 */
                                            /*cm**3/m**3*/
                                                          /* /(2 * m_bulkJctPotential));
}
*/

        if ( not (in_p.m_bulkCapFactorIsGiven > 0.5)) then
          out_v.m_bulkCapFactor := sqrt( in_C.EPSSIL * in_C.CHARGE * out_v.m_substrateDoping
                                    * 1e6 /(2 * in_p.m_bulkJctPotential));
        end if;
      //  dummy:=out_v.m_gamma;
      end Mos2ModelLineParamsInitEquations;

      function DrainCur
      /* double vbs, double vgs, double vds,
   double &cdrain, double &gm, double &gmbs, double &gds) */

         input Real vbs;
         input Real vgs;
         input Real vds;

         input Spice3.Repository.Mosfet.Mosfet in_m;
         input Mos2Calc in_c;
         input Mos2ModelLineParams in_p;
         input Spice3.Repository.SpiceConstants in_C;
         input Mos2ModelLineVariables in_vp;
         input Integer in_m_type;

         output Mos2Calc out_c;
         output Real test_gamma;
      /* { double vt;      // K * T / Q
   double beta1;
   double dsrgdb;
   double d2sdb2;
   double sphi = 0., sphi3 = 1.;    // square root of phi
   double barg,   sarg,   bsarg = 0.,  sarg3;
   double d2bdb2;
   double factor;
   double dbrgdb;
   double eta;
   double vbin,   vth;
   double dgddb2, dgddvb, dgdvds;
   double gamasd, gammad;
   double xn   = 1.;
   double argg = 0.;
   double vgst,   vgsx;
   double dgdvbs;
   double body,   bodys = 0.;
   double gdbdv;
   double dodvbs, dodvds = 0.;
   double dxndvd = 0., dxndvb = 0.;
   double dudvgs, dudvds, dudvbs;
   double ufact,  ueff;
   double dsdvgs, dsdvbs;
   double dbsrdb;
   double gdbdvs = 0.;
   double dldvgs, dldvds, dldvbs;
   double clfact;
   double xleff,  deltal;
   double xwb,    xld;
   double xlamda = m_pParameters->m_lambda;
   double phiMinVbs; */

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
        Real dbsrdb;
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
        Real[8] x4;
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

      /* vt = m_pDevice->CONSTKoverQ * GetTemperature(); */

        vt := in_C.CONSTKoverQ * in_C.REFTEMP;// * GetTemperature();      //GetTemperature noch nicht implementiert 090107

      /*   // compute some useful quantities
   phiMinVbs = m_tPhi - vbs;
   if (vbs <= 0.0)
   {
      sarg   = sqrt( phiMinVbs);
      dsrgdb = -0.5 / sarg;
      d2sdb2 = 0.5 * dsrgdb / phiMinVbs;
   }
   else
   {
      double tmp;

      sphi   = sqrt( m_tPhi);
      sphi3  = m_tPhi * sphi;
      sarg   = sphi / (1.0 + 0.5 * vbs / m_tPhi);
      tmp    = sarg / sphi3;
      dsrgdb = -0.5 * sarg * tmp;
      d2sdb2 = -dsrgdb * tmp;
   }

   if ((vds-vbs) >= 0)
   {
      barg   = sqrt( phiMinVbs + vds);
      dbrgdb = -0.5 / barg;
      d2bdb2 = 0.5 * dbrgdb / (phiMinVbs + vds);
   }
   else
   {
      double tmp;

      barg   = sphi / (1.0 + 0.5 * (vbs - vds) / m_tPhi);
      tmp    = barg / sphi3;
      dbrgdb = -0.5 * barg * tmp;
      d2bdb2 = -dbrgdb * tmp;
   } */

        // compute some useful quantities
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

      /*   // calculate threshold voltage (von)
   // narrow-channel effect
   // XXX constant per device
   factor = 0.125 * m_pParameters->m_narrowFactor * 2.0 * M_PI*EPSSIL
      / m_capOx * m_lEff;
   // XXX constant per device
   eta    = 1.0 + factor;
   vbin   = m_tVbi * m_pModel->m_type + factor * phiMinVbs;
   if ((m_pParameters->m_gamma > 0.0) || (m_pParameters->m_substrateDoping > 0.0))
   {
      double argss, argsd, args = 0., argd = 0., argxs = 0., argxd = 0.;
      double dbargs, dbargd, dbxws, dbxwd;
      double xwd, xws;

      xwd = m_pParameters->m_xd * barg;
      xws = m_pParameters->m_xd * sarg;

      // short-channel effect with vds .ne. 0.0
      argss  = 0.0;
      argsd  = 0.0;
      dbargs = 0.0;
      dbargd = 0.0;
      dgdvds = 0.0;
      dgddb2 = 0.0;
      if (m_pParameters->m_junctionDepth > 0)
      {
         double tmp;

         tmp   = 2.0 / m_pParameters->m_junctionDepth;
         argxs = 1.0 + xws * tmp;
         argxd = 1.0 + xwd * tmp;
         args  = sqrt( argxs);
         argd  = sqrt( argxd);
         tmp   = .5 * m_pParameters->m_junctionDepth / m_lEff;
         argss = tmp * (args - 1.0);
         argsd = tmp * (argd - 1.0);
      }
      gamasd = m_pParameters->m_gamma * (1.0 - argss - argsd);
      dbxwd  = m_pParameters->m_xd * dbrgdb;
      dbxws  = m_pParameters->m_xd * dsrgdb;
      if (m_pParameters->m_junctionDepth > 0)
      {
         double daddb2, dasdb2, tmp;

         tmp    = 0.5 / m_lEff;
         dbargs = tmp * dbxws / args;
         dbargd = tmp * dbxwd / argd;
         dasdb2 = -m_pParameters->m_xd
            * (d2sdb2 + dsrgdb * dsrgdb * m_pParameters->m_xd
               / (m_pParameters->m_junctionDepth * argxs))
            / (m_lEff * args);
         daddb2 = -m_pParameters->m_xd
            * (d2bdb2 + dbrgdb * dbrgdb * m_pParameters->m_xd
               / (m_pParameters->m_junctionDepth * argxd))
            / (m_lEff * argd);
         dgddb2 = -0.5 * m_pParameters->m_gamma * (dasdb2 + daddb2);
      }
      dgddvb = -m_pParameters->m_gamma * (dbargs + dbargd);
      if (m_pParameters->m_junctionDepth > 0)
      {
         double ddxwd;

         ddxwd  = -dbxwd;
         dgdvds = -m_pParameters->m_gamma * 0.5 * ddxwd / (m_lEff * argd);
      }
   }
   else
   {
      gamasd = m_pParameters->m_gamma;
      gammad = m_pParameters->m_gamma;
      dgddvb = 0.0;
      dgdvds = 0.0;
      dgddb2 = 0.0;
   } */

        // calculate threshold voltage (von)
        // narrow-channel effect
        // XXX constant per device
        factor := 0.125 * in_p.m_narrowFactor * 2.0 * Modelica.Constants.pi*in_C.EPSSIL / out_c.m_capOx * out_c.m_lEff;
        // XXX constant per device
        eta    := 1.0 + factor;
        vbin   := out_c.m_tVbi * in_m_type + factor * phiMinVbs;  //in_m_type + factor * phiMinVbs;
        if ( (in_vp.m_gamma > 0.0) or (in_vp.m_substrateDoping > 0.0)) then
          xwd := in_vp.m_xd * barg;
          xws := in_vp.m_xd * sarg;

          // short-channel effect with vds .ne. 0.0
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

      /*   m_von   = vbin + gamasd * sarg;
   vth   = m_von;
   m_vdsat = 0.0;
   if (m_pParameters->m_fastSurfaceStateDensity != 0.0 && m_capOx != 0.0)
   {
      double cfs, cdonco, tmp;

      // XXX constant per model
      cfs    = CHARGE * m_pParameters->m_fastSurfaceStateDensity * 1e4; //(cm**2/m**2)
      cdonco = -(gamasd * dsrgdb + dgddvb * sarg) + factor;
      xn     = 1.0 + cfs / m_capOx * m_pDevice->m_width * m_lEff + cdonco;
      tmp    = vt * xn;
      m_von    = m_von + tmp;
      argg   = 1.0 / tmp;
      vgst   = vgs - m_von;
   }
   else
   {
      vgst = vgs - m_von;
      if (vgs <= m_von)
      {
         // cutoff region
         gds    = 0.0;
         cdrain = 0.0;
         gm     = 0.0;
         gmbs   = 0.0;
         return;
      }
   } */

        out_c.m_von   := vbin + gamasd * sarg;
        vth           := out_c.m_von;
        out_c.m_vdsat := 0.0;
        if ( in_p.m_fastSurfaceStateDensity <> 0.0 and out_c.m_capOx <> 0.0) then
          // XXX constant per model
          cfs          := in_C.CHARGE * in_p.m_fastSurfaceStateDensity * 1.0e4; //(cm**2/m**2)
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

      /*   // compute some more useful quantities
   sarg3  = sarg * sarg * sarg;
   // XXX constant per model
   gammad = gamasd;
   dgdvbs = dgddvb;
   body   = barg * barg * barg - sarg3;
   gdbdv  = 2.0 * gammad * (barg * barg * dbrgdb - sarg * sarg * dsrgdb);
   dodvbs = -factor + dgdvbs * sarg + gammad * dsrgdb;

   if ((m_pParameters->m_fastSurfaceStateDensity != 0.0) && (m_capOx != 0.0))
   {
      dxndvb = 2.0 * dgdvbs * dsrgdb + gammad * d2sdb2 + dgddb2 * sarg;
      dodvbs = dodvbs + vt * dxndvb;
      dxndvd = dgdvds * dsrgdb;
      dodvds = dgdvds * sarg + vt * dxndvd;
   } */

        // compute some more useful quantities
        sarg3  := sarg * sarg * sarg;
        // XXX constant per model
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

      /*   // evaluate effective mobility and its derivatives
   ufact  = 1.0;
   ueff   = m_pParameters->m_surfaceMobility * 1e-4; // (m**2/cm**)
   dudvgs = 0.0;
   dudvds = 0.0;
   dudvbs = 0.0;
   if (m_capOx > 0.0)
   {
      double tmp;

      tmp = m_pParameters->m_critField * EPSSIL * 100 // cm/m
         / m_pParameters->m_oxideCapFactor;
      if (vgst > tmp)
      {
         ufact  = exp( m_pParameters->m_critFieldExp * log( tmp / vgst));
         ueff   = m_pParameters->m_surfaceMobility * 1e-4 * ufact; // (m**2/cm**2)
         dudvgs = -ufact * m_pParameters->m_critFieldExp / vgst;
         dudvds = 0.0;
         dudvbs = m_pParameters->m_critFieldExp * ufact * dodvbs / vgst;
      }
   } */

        // evaluate effective mobility and its derivatives
        ufact  := 1.0;
        ueff   := in_p.m_surfaceMobility * 1e-4; // (m**2/cm**)
        dudvgs := 0.0;
        dudvds := 0.0;
        dudvbs := 0.0;
        if (out_c.m_capOx > 0.0) then
          tmp := in_p.m_critField * in_C.EPSSIL * 100 / in_vp.m_oxideCapFactor;
          if (vgst > tmp) then
            ufact  := exp( in_p.m_critFieldExp * Modelica.Math.log( tmp / vgst));
            ueff   := in_p.m_surfaceMobility * 1.0e-4 * ufact; // (m**2/cm**2)
            dudvgs := -ufact * in_p.m_critFieldExp / vgst;
            dudvds := 0.0;
            dudvbs := in_p.m_critFieldExp * ufact * dodvbs / vgst;
          end if;
        end if;

      /*   // evaluate saturation voltage and its derivatives according to
   // grove-frohman equation
   vgsx   = vgs;
   gammad = gamasd / eta;
   dgdvbs = dgddvb;
   if (m_pParameters->m_fastSurfaceStateDensity != 0 && m_capOx != 0)
   {
      vgsx = F_Max( vgs, m_von);
   }

   if (gammad > 0)
   {
      double argv, gammd2;

      gammd2 = gammad * gammad;
      argv   = (vgsx - vbin) / eta + phiMinVbs;
      if (argv <= 0.0)
      {
         m_vdsat  = 0.0;
         dsdvgs = 0.0;
         dsdvbs = 0.0;
      }
      else
      {
         double arg;

         arg    = sqrt( 1.0 + 4.0 * argv / gammd2);
         m_vdsat  = (vgsx - vbin) / eta + gammd2 * (1.0 - arg) / 2.0;
         m_vdsat  = F_Max( m_vdsat, 0.0);
         dsdvgs = (1.0 - 1.0 / arg) / eta;
         dsdvbs = (gammad * (1.0 - arg) + 2.0 * argv / (gammad * arg))
            / eta * dgdvbs + 1.0 / arg + factor * dsdvgs;
      }
   }
   else
   {
      m_vdsat  = (vgsx - vbin) / eta;
      m_vdsat  = F_Max( m_vdsat, 0.0);
      dsdvgs = 1.0;
      dsdvbs = 0.0;
   } */

        // evaluate saturation voltage and its derivatives according to
        // grove-frohman equation
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

      /*   if (m_pParameters->m_maxDriftVel > 0)
   {
      // evaluate saturation voltage and its derivatives
      // according to baum's theory of scattering velocity
      // saturation
      double y3, xvalid = 0.;
      double sig1[ 4];
      double sig2[ 4];
      double a4[ 4],b4[ 4], x4[ 8], poly4[ 8], delta4, tmp;
      int j, iknt = 0, i, jknt = 0;

      double v1 = (vgsx - vbin) / eta + phiMinVbs;
      double v2 = phiMinVbs;
      double xv = m_pParameters->m_maxDriftVel * m_lEff / ueff;
      double a1 = gammad / 0.75;
      double b1 = -2.0 * (v1 + xv);
      double c1 = -2.0 * gammad * xv;
      double d1 = 2.0 * v1 * (v2 + xv) - v2 * v2 - 4.0 / 3.0 * gammad * sarg3;
      double b2 = a1 * c1 - 4.0 * d1;
      double r1 = -b1 * b1 / 3.0 + b2;
      double s1 = 2.0 * b1 * b1 * -b1 / 27.0 + b1 * b2 / 3.0
         + -d1 * (a1 * a1 - 4.0 * b1) - c1 * c1;
      double s2 = s1 * s1;
      double p1  = s2 / 4.0 + r1 * r1 * r1 / 27.0;
      double p0 = F_Abs( p1);
      double p2 = sqrt( p0);
      double a3, b3;

      sig1[0] = 1.0; sig1[1] = -1.0; sig1[2] =  1.0; sig1[3] = -1.0;
      sig2[0] = 1.0; sig2[1] =  1.0; sig2[2] = -1.0; sig2[3] = -1.0;

      if (p1 < 0)
      {
         y3 = 2.0 * exp( log( sqrt( s2 / 4.0 + p0)) / 3.0)
            * cos( atan( -2.0 * p2 / s1) / 3.0) + b1 / 3.0;
      }
      else
      {
         y3 =  exp( log( F_Abs( -s1 / 2.0 + p2)) / 3.0)
            + exp( log( F_Abs( -s1 / 2.0 - p2)) / 3.0)
            + b1 / 3.0;
      }

      a3 = sqrt( a1 * a1 / 4.0 - b1 + y3);
      b3 = sqrt( y3 * y3 / 4.0 - d1);

      for( i = 1; i<=4; i++)
      {
         a4[i-1] = a1/2.0+sig1[i-1]*a3;
         b4[i-1] = y3/2.0+sig2[i-1]*b3;
         delta4 = a4[i-1]*a4[i-1]/4.0-b4[i-1];
         if (delta4 >= 0)
         {
            iknt = iknt+1;
            tmp = sqrt(delta4);
            x4[iknt-1] = -a4[i-1]/2.0+tmp;
            iknt = iknt+1;
            x4[iknt-1] = -a4[i-1]/2.0-tmp;
         }
      }
      jknt = 0;
      for(j = 1;j<=iknt;j++)
      {
         if (x4[j-1] > 0)
         {
            // XXX implement this sanely
            poly4[j-1] = x4[j-1]*x4[j-1]*x4[j-1]*x4[j-1]+a1*x4[j-1]*
               x4[j-1]*x4[j-1];
            poly4[j-1] = poly4[j-1]+b1*x4[j-1]*x4[j-1]+c1*x4[j-1]+d1;
            if (F_Abs(poly4[j-1]) <= 1.0e-6)
            {
               jknt = jknt+1;
               if (jknt <= 1)
               {
                  xvalid = x4[j-1];
               }
               if (x4[j-1] <= xvalid) xvalid = x4[j-1];
            }
         }
      }

      if (jknt > 0)
      {
         m_vdsat = xvalid * xvalid - phiMinVbs;
      }
   } */

        if (in_p.m_maxDriftVel > 0) then
          // evaluate saturation voltage and its derivatives
          // according to baum's theory of scattering velocity
          // saturation
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
              // XXX implement this sanely
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

      /*   // evaluate effective channel length and its derivatives
   dldvgs = 0.0;
   dldvds = 0.0;
   dldvbs = 0.0;
   if (vds != 0.0)
   {
      gammad = gamasd;
      if ((vbs - m_vdsat) <= 0)
      {
         bsarg  = sqrt(m_vdsat + phiMinVbs);
         dbsrdb = -0.5 / bsarg;
      }
      else
      {
         bsarg  = sphi / (1.0 + 0.5 * (vbs - m_vdsat) / m_tPhi);
         dbsrdb = -0.5 * bsarg * bsarg / sphi3;
      }
      bodys  = bsarg * bsarg * bsarg - sarg3;
      gdbdvs = 2.0 * gammad * (bsarg * bsarg * dbsrdb - sarg * sarg * dsrgdb);
      if (m_pParameters->m_maxDriftVel <= 0)
      {
         if ((m_pParameters->m_substrateDoping != 0.0) && (xlamda <= 0.0))
         {
            double sargv, argv, arg, dldsat, xlfact;

            argv   = (vds - m_vdsat) / 4.0;
            sargv  = sqrt(1.0 + argv * argv);
            arg    = sqrt(argv + sargv);
            xlfact = m_pParameters->m_xd / (m_lEff * vds);
            xlamda = xlfact * arg;
            dldsat = vds * xlamda / (8.0 * sargv);

            dldvgs = dldsat * dsdvgs;
            dldvds = -xlamda + dldsat;
            dldvbs = dldsat * dsdvbs;
         }

      }
      else
      {
         double argv, xdv, xlv, vqchan, dqdsat, vl, dfunds, dfundg, dfundb;

         argv   = (vgsx - vbin) / eta - m_vdsat;
         xdv    = m_pParameters->m_xd / sqrt(m_pParameters->m_channelCharge);
         xlv    = m_pParameters->m_maxDriftVel * xdv / (2.0 * ueff);
         vqchan = argv - gammad * bsarg;
         dqdsat = -1.0 + gammad * dbsrdb;
         vl     = m_pParameters->m_maxDriftVel * m_lEff;
         dfunds = vl * dqdsat - ueff * vqchan;
         dfundg = (vl - ueff * m_vdsat) / eta;
         dfundb = -vl * (1.0 + dqdsat - factor / eta) + ueff *
            (gdbdvs - dgdvbs * bodys / 1.5) / eta;
         dsdvgs = -dfundg / dfunds;
         dsdvbs = -dfundb / dfunds;
         if ((m_pParameters->m_substrateDoping != 0.0) && (xlamda <= 0.0))
         {
            double dldsat, argv, xlfact, xls;

            argv   = vds - m_vdsat;
            argv   = F_Max(argv,0.0);
            xls    = sqrt(xlv * xlv + argv);
            dldsat = xdv / (2.0 * xls);
            xlfact = xdv / (m_lEff * vds);
            xlamda = xlfact * (xls - xlv);
            dldsat = dldsat / m_lEff;

            dldvgs = dldsat * dsdvgs;
            dldvds = -xlamda + dldsat;
            dldvbs = dldsat * dsdvbs;
         }
      }
   } */

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

      /*   // limit channel shortening at punch-through
   xwb    = m_pParameters->m_xd * sqrt( m_tBulkPot);
   xld    = m_lEff - xwb;
   clfact = 1.0 - xlamda * vds;
   dldvds = -xlamda - dldvds;
   xleff  = m_lEff * clfact;
   deltal = xlamda * vds * m_lEff;
   if (m_pParameters->m_substrateDoping == 0.0)
      xwb = 0.25e-6;
   if (xleff < xwb)
   {
      double dfact;

      xleff  = xwb / (1.0 + (deltal - xld) / xwb);
      clfact = xleff / m_lEff;
      dfact  = xleff * xleff / (xwb * xwb);
      dldvgs = dfact * dldvgs;
      dldvds = dfact * dldvds;
      dldvbs = dfact * dldvbs;
   } */

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

      /*   // evaluate effective beta (effective kp)
   beta1 = m_Beta * ufact / clfact;

   // test for mode of operation and branch appropriately
   gammad = gamasd;
   dgdvbs = dgddvb;
   if (vds <= 1.0e-10)
   {
      if (vgs <= m_von)
         if ((m_pParameters->m_fastSurfaceStateDensity == 0.0) || (m_capOx == 0.0))
            gds = 0.0;
         else
            gds = beta1 * (m_von - vbin - gammad * sarg) * exp(argg * (vgs - m_von));
      else
         gds = beta1 * (vgs - vbin - gammad * sarg);
      cdrain = 0.0;
      gm     = 0.0;
      gmbs   = 0.0;
      return;
   } */

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

      /*   if (vgs <= m_von)
   {
      // subthreshold region
      double vdson, cdson, gdson, didvds, gmw, gbson, expg, tmp;

      if (m_vdsat <= 0)
      {
         gds    = 0.0;
         if (vgs > vth)
            return;
         cdrain = 0.0;
         gm     = 0.0;
         gmbs   = 0.0;
         return;
      }
      vdson = F_Min(m_vdsat,vds);
      if (vds > m_vdsat)
      {
         barg   = bsarg;
         dbrgdb = dbsrdb;
         body   = bodys;
         gdbdv  = gdbdvs;
      }
      cdson   = beta1 * ((m_von - vbin - eta * vdson * 0.5) * vdson - gammad * body / 1.5);
      didvds  = beta1 * (m_von - vbin - eta * vdson - gammad * barg);
      gdson   = -cdson * dldvds / clfact - beta1 * dgdvds * body / 1.5;
      if (vds < m_vdsat)
         gdson = gdson + didvds;
      gbson   = -cdson * dldvbs / clfact + beta1 *
         (dodvbs * vdson + factor * vdson - dgdvbs * body / 1.5 - gdbdv);
      if (vds > m_vdsat)
         gbson = gbson + didvds * dsdvbs;
      expg   = exp(argg * (vgs - m_von));
      cdrain = cdson * expg;
      gmw    = cdrain * argg;
      gm     = gmw;
      if (vds > m_vdsat)
         gm = gmw + didvds * dsdvgs * expg;
      tmp    = gmw * (vgs - m_von) / xn;
      gds    = gdson * expg - gm * dodvds - tmp * dxndvd;
      gmbs   = gbson * expg - gm * dodvbs - tmp * dxndvb;
   }
   else if (vds <= m_vdsat)
   {
      // linear region
      double arg;

      cdrain = beta1 * ((vgs - vbin - eta * vds / 2.0) * vds - gammad * body / 1.5);
      arg    = cdrain * (dudvgs / ufact - dldvgs / clfact);
      gm     = arg + beta1 * vds;
      arg    = cdrain * (dudvds / ufact - dldvds / clfact);
      gds    = arg + beta1 * (vgs - vbin - eta *
                              vds - gammad * barg - dgdvds * body / 1.5);
      arg    = cdrain * (dudvbs / ufact - dldvbs / clfact);
      gmbs   = arg - beta1 * (gdbdv + dgdvbs * body / 1.5 - factor * vds);
   }
   else
   {
      // saturation region
      double arg;

      cdrain = beta1 * ((vgs - vbin - eta *
                         m_vdsat / 2.0) * m_vdsat - gammad * bodys / 1.5);
      arg     = cdrain * (dudvgs / ufact - dldvgs / clfact);
      gm     = arg + beta1 * m_vdsat
         + beta1 * (vgs - vbin - eta * m_vdsat - gammad * bsarg) * dsdvgs;
      gds    = -cdrain * dldvds / clfact - beta1 * dgdvds * bodys / 1.5;
      arg     = cdrain * (dudvbs / ufact - dldvbs / clfact);
      gmbs   = arg - beta1 * (gdbdvs + dgdvbs * bodys / 1.5 - factor * m_vdsat)
         + beta1 *  (vgs - vbin - eta * m_vdsat - gammad * bsarg) * dsdvbs;
   } */

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
      test_gamma:=in_vp.m_gamma;
      end DrainCur;

      function Mos2RenameParameters
        "renames the external parameters (e.g. RD) into the internal names (e.g. m_drainResistance)"

        input Spice3.Repository.modelcardMOS2 ex;
        input Spice3.Repository.SpiceConstants con;

        output Mos2ModelLineParams intern;

      algorithm
      // from Mos2ModelLineParams
         intern.m_narrowFactor := ex.DELTA;           // DELTA, Width effect on threshold
         intern.m_critFieldExp := ex.UEXP;            // UEXP, Crit. field exp for mob. deg
         intern.m_critField := ex.UCRIT;              // UCRIT, Crit. field for mob. degradation
         intern.m_maxDriftVel := ex.VMAX;             // VMAX, Maximum carrier drift velocity
         intern.m_junctionDepth := ex.XJ;             // XJ, Junction depth
         intern.m_channelCharge := ex.NEFF;           // NEFF, Total channel charge coeff
         intern.m_fastSurfaceStateDensity := ex.NFS;  // NFS, Fast surface state density

       // from MosModelLinesParams

         intern.m_oxideCapFactor := 0;              // not available in modelcard parameters????

         //intern.m_vt0 := ex.VTO;                    // V zero-bias threshold voltage (default 0)

          intern.m_vtOIsGiven := if          (ex.VTO > -1e40) then 1 else 0;
          intern.m_vt0 := if         (ex.VTO > -1e40) then ex.VTO else 0;

          //intern.m_capBD := ex.CBD;                  // F zero-bias B-D junction capacitance (default 0)

          intern.m_capBDIsGiven := if          (ex.CBD > -1e40) then 1 else 0;
          intern.m_capBD := if         (ex.CBD > -1e40) then ex.CBD else 0;

         // intern.m_capBS := ex.CBS;                  // F zero-bias B-S junction capacitance (default 0)

          intern.m_capBSIsGiven := if          (ex.CBS > -1e40) then 1 else 0;
          intern.m_capBS := if         (ex.CBS > -1e40) then ex.CBS else 0;

          intern.m_bulkCapFactor := ex.CJ;           // F/(m*m) zero-bias bulk junction bottom cap. per sq-meter of junction area (default 0)
          intern.m_sideWallCapFactor := ex.CJSW;     // F/m zero-bias junction sidewall cap. per meter of junction perimeter (default 0)
          intern.m_fwdCapDepCoeff := ex.FC;          // coefficient for forward-bias depletion capacitance formula (default 0.5)
      //  intern.m_phi := ex.PHI;                    // V surface potential (default 0.6)

          intern.m_phiIsGiven := if          (ex.PHI > -1e40) then 1 else 0;
          intern.m_phi := if         (ex.PHI > -1e40) then ex.PHI else 0.6;

       //  intern.m_gamma := ex.GAMMA;                // V bulk threshold parameter (default 0)

          intern.m_gammaIsGiven := if          (ex.GAMMA > -1e40) then 1 else 0;
          intern.m_gamma := if         (ex.GAMMA > -1e40) then ex.GAMMA else 0;

          intern.m_lambda := ex.LAMBDA;              // 1/V channel-length modulation (default 0)

      //  intern.m_substrateDoping := ex.NSUB;       // substrate doping (default 0)

          intern.m_substrateDopingIsGiven := if          (ex.NSUB > -1e40) then 1 else 0;
          intern.m_substrateDoping := if         (ex.NSUB > -1e40) then ex.NSUB else 0;

          intern.m_gateType := ex.TPG;               // type of gate material: +1 opp. to substrate, -1 same as substrate, 0 Al gate (default 1)
          intern.m_surfaceStateDensity := ex.NSS;    // 1/(cm*cm) surface state density (default 0)
          intern.m_surfaceMobility := ex.UO;         // (cm*cm)/(Vs) surface mobility (default 600)
          intern.m_latDiff := ex.LD;                 // m lateral diffusion (default 0)
          intern.m_jctSatCur := ex.IS;               // A bulk junction saturation current (defaul 1e-14)

          //intern.m_drainResistance := ex.RD;         // Ohm drain ohmic resistance (default 0)

          intern.m_drainResistanceIsGiven := if
                                               (ex.RD > -1e40) then 1 else 0;
          intern.m_drainResistance := if
                                       (ex.RD > -1e40) then ex.RD else 0;

        //  intern.m_sourceResistance := ex.RS;        // Ohm source ohmic resistance (default 0)

           intern.m_sourceResistanceIsGiven := if
                                               (ex.RS > -1e40) then 1 else 0;
          intern.m_sourceResistance := if
                                       (ex.RS > -1e40) then ex.RS else 0;

        //  intern.m_transconductance := ex.KP;        // A/(V*V) transconductance parameter (default 2e-5)

          intern.m_transconductanceIsGiven := if          (ex.KP > -1e40) then 1 else 0;
          intern.m_transconductance := if         (ex.KP > -1e40) then ex.KP else 2e-5;

        intern.m_tnom := if (ex.TNOM > -1e40) then ex.TNOM + Spice3.Repository.SpiceConstants.CONSTCtoK else
                300.15;

                        // °C parameter measurement temperature (default 27)

      // from MosfetModelLinesParams
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

      //ajustable parameters not yet used in MOS1
      /*
 parameter Real LEVEL=1 "";
 parameter Real TF=0 "?? ideal forward transit time";
  parameter Real NFS=0.0 "?? fast surface state density";
 parameter Real XJ=0.0 "?? metallurgiecal junction depth";
 parameter Real UCRIT=1.e4
    "?? critical field for mobility degradation (MOS2 only)";
 parameter Real UEXP=0.0
    "?? critical field exponent in mobility degradation (MOS2 only)";
 parameter Real UTRA=0.0
    "?? transverse field coeff(mobility) (deleted for MOS2)";
 parameter Real VMAX=0.0 "?? maximum drift velocity of carries";
 parameter Real NEFF=1.0
    "?? total channel charge (fixed and mobile) coefficient (MOS2 only)";
 parameter Real DELTA=0.0 "width effect on theshold voltage";
 parameter Real THETA=0.0 "1/V mobility modulation (MOS3 only)";
 parameter Real ETA=0.0 "static feedback (MOS3 only)";
 parameter Real KAPPA=0.2 "saturation field factor (MOS3 only)";

*/
      end Mos2RenameParameters;

      function Mos2RenameParameters_dev
        "renames the external parameters (e.g. RD) into the internal names (e.g. m_drainResistance)"
        input Spice3.Repository.modelcardMOS2 ex;
       // input Spice3.Attempt_1_konstanten_parameter_inArbeit.SpiceConstants con;
        input Real mtype;
        input Real W;
        input Real L;
        input Real AD;
        input Real AS;
        input Real PD;
        input Real PS;
        input Real NRD;
        input Real NRS;
        input Real OFF;
        input Real IC;
        input Real TEMP;

        output Mosfet.Mosfet dev;

      algorithm
      /*device parameters*/
       //  Real m_len(             start = SpiceRoot.SPICEcircuitCONST.CKTdefaultMosL);  // L, length of channel region
        dev.m_len := L;               // L, length of channel region
      //  Real m_width(           start = SpiceRoot.SPICEcircuitCONST.CKTdefaultMosW);  // W, width of channel region
        dev.m_width := W;             // W, width of channel region
        dev.m_drainArea := AD;        // AD, area of drain diffusion
        dev.m_sourceArea := AS;       // AS, area of source diffusion
        dev.m_drainSquares := NRD;    // NRD, length of drain in squares
        dev.m_sourceSquares := NRS;   // NRS, length of source in squares
        dev.m_drainPerimiter := PD;   // PD, Drain perimeter;
        dev.m_sourcePerimiter := PS;  // PS, Source perimeter
      //  dev.m_dICVDS := IC;     // IC_VDS, Initial D-S voltage;

          dev.m_dICVDSIsGiven := if          (IC > -1e40) then 1 else 0;
          dev.m_dICVDS := if         (IC > -1e40) then IC else 0;

      //  dev.m_dICVGS := 1;     // IC_VGS, Initial G-S voltage;

          dev.m_dICVGSIsGiven := if          (IC > -1e40) then 1 else 0;
          dev.m_dICVGS := if         (IC > -1e40) then IC else 0;

      //  dev.m_dICVBS := 2;     // IC_VBS, Initial B-S voltage;

          dev.m_dICVBSIsGiven := if          (IC > -1e40) then 1 else 0;
          dev.m_dICVBS := if         (IC > -1e40) then IC else 0;

        dev.m_off := OFF;             // non-zero to indicate device is off for dc analysis
        dev.m_bPMOS := mtype;         // P type MOSfet model
        dev.m_nLevel := ex.LEVEL;
        assert(ex.LEVEL== 1, "only MOS Level1 implemented");
        dev.m_dTemp :=TEMP + SpiceRoot.SPICEcircuitCONST.CONSTCtoK;
      end Mos2RenameParameters_dev;
    end Mos2;

    package Diode
      record DiodeModelLineParams

      /* Diode_Model_Line::Diode_Model_Line( const String& elementname)
   //     Diode Models

   //     The dc characteristics of the diode are  determined  by
   //     the  parameters IS and N.An  ohmic  resistance, RS, is
   //     included.Charge storage effects are modeled by  a  transit
   //     time,TT, and a nonlinear depletion layer capacitance which
   //     is determined by the parameters CJO, VJ, and  M.The temperature
   //     dependence of the saturation current is defined by
   //     the parameters EG, the  energy and XTI, the saturation
   //     current  temperature exponent.  Reverse breakdown is modeled
   //     by an exponential increase in the reverse diode current  and
   //     is  determined  by  the parameters BV and IBV (both of which
   //     are positive numbers).

   // <pre>            name   parameter                        units   default    example    area</br>

   //       1    IS     saturation current               A       1.0E-14    1.0E-14    *
   //       2    RS     ohmic resistance                 Ohm     0          10         *
   //       3    N      emission coefficient             -       1          1.0
   //       4    TT     transit-time                     sec     0          0.1Ns
   //       5    CJO    zero-bias junction capacitance   F       0          2PF        *
   //       6    VJ     junction potential               V       1          0.6
   //       7    M      grading coefficient              -       0.5        0.5
   //       8    EG     activation energy                eV      1.11       1.11 Si
   //                                                                       0.69 Sbd
   //                                                                       0.67 Ge
   //       9    XTI    saturation-current temp. exp     -       3.0        3.0 jn
   //                                                                       2.0 Sbd
   //      10    KF     flicker noise coefficient        -       0
   //      11    AF     flicker noise exponent           -       1
   //      12    FC     coefficient for forward-bias     -       0.5
   //                   depletion capacitance formula
   //      13    BV     reverse breakdown voltage        V       infinite   40.0
   //      14    IBV    current at breakdown voltage     A       1.0E-3</pre>

         : DotModel( "DIODE .MODEL", elementname)
{
   AddParameter( "D", m_bD, true);                       // Diode model
   AddParameter( "IS", m_satCur, 1e-14);                 // Saturation current
   AddParameter( "RS", m_resist, 0.0);                   // Ohmic resistance
   AddParameter( "N", m_emissionCoeff, 1.0);             // Emission Coefficient
   AddParameter( "TT", m_transitTime, 0.0);              // Transit Time
   AddParameter( "CJO", m_junctionCap, 0.0)->Alias( "CJ0"); // Junction capacitance
   AddParameter( "VJ", m_junctionPot, 1.0);              // Junction potential
   AddParameter( "M", m_gradingCoeff, 0.5);              // Grading coefficient
   AddParameter( "EG", m_activationEnergy, 1.11);        // Activation energy
   AddParameter( "XTI", m_saturationCurrentExp, 3.0);    // Saturation current temperature exp.
   AddParameter( "FC", m_depletionCapCoeff, 0.5);        // Forward bias junction fit parameter
   m_pBvValue = AddParameter( "BV", m_breakdownVoltage, 0.0); // Reverse breakdown voltage
   AddParameter( "IBV", m_breakdownCurrent, 1e-3);       // Current at reverse breakdown voltage
   AddParameter( "TNOM", m_nomTemp, CKTnomTemp)->SetOffset( CONSTCtoK); // Parameter measurement temperature
   AddParameter( "KF", m_fNcoef, 0.0);                   // flicker noise coefficient
   AddParameter( "AF", m_fNexp, 1.0);                    // flicker noise exponent
   AddValue( "G", m_conductance)->Alias( "COND");        // Ohmic conductance
} */

       // Boolean m_bD( start = true);                        // "D", Diode model
        Real m_satCur( start = 1.0e-14);                    // "IS", Saturation current
        Real m_resist( start = 0.0);                        // "RS", Ohmic resistance
        Real m_emissionCoeff( start = 1.0);                 // "N", Emission Coefficient
        Real m_transitTime( start = 0.0);                   // "TT", Transit Time
        Real m_junctionCap( start = 0.0);                   // "CJO", Junction capacitance
        Real m_junctionPot( start = 1.0);                   // "VJ", Junction potential
        Real m_gradingCoeff( start = 0.5);                  // "M", Grading coefficient
        Real m_activationEnergy( start = 1.11);             // "EG", Activation energy
        Real m_saturationCurrentExp( start = 3.0);          // "XTI", Saturation current temperature exp.
        Real m_depletionCapCoeff( start = 0.5);             // "FC", Forward bias junction fit parameter
        Real m_breakdownVoltage;                            // "BV", Reverse breakdown voltage
        Real m_pBvIsGiven;
        Real m_breakdownCurrent( start = 1.0e-3);           // "IBV", Current at reverse breakdown voltage
        Real m_nomTemp( start=Spice3.Repository.SpiceConstants.CKTnomTemp);
                                                            // "TNOM", Parameter measurement temperature
        Real m_fNcoef( start = 0.0);                        // "KF", flicker noise coefficient
        Real m_fNexp( start = 1.0);                         // "AF", flicker noise exponent
        Real m_conductance;                                 // "G", Ohmic conductance

      end DiodeModelLineParams;

      record DiodeModelLineVariables

        Real m_gradingCoeff;
        Real m_activationEnergy;
        Real m_depletionCapCoeff;
        Real m_conductance;

      end DiodeModelLineVariables;

      record DiodeParams
      /* Diode::Diode( const String& elementname)
   //      Junction Diodes

   //      General form: <pre>
   //      DN+ N- NAME &lt;AREA&gt; &lt;OFF&gt; &lt;IC=VD&gt;
   //      </pre>Examples:<pre>
   //      D BRIDGE 2 10 DIODE1
   //      D CLMP 3 7 DMOD 3.0 IC=0.2
   //      </pre>N+ and N- are the positive and negative nodes,  respectively.
   //      NAME is the model name, AREA is the area factor,
   //      and OFF  indicates an (optional) starting  condition  on  the
   //      device  for  dc  analysis.  If the area factor is omitted, a
   //      value of 1.0 is assumed.  The (optional)  initial  condition
   //      specification  using IC = VD is intended for use with the IC
   //      option on the other than the quiescent operating point.
        : Model( "Diode", elementname), m_pModel( NULL)
{
   AddParameter( "AREA", m_area, 1.0);               // Area factor
   AddParameter( "OFF", m_bOff, false);              // Initially off
   m_pIcValue = AddParameter( "IC", m_dIC, 0.0);     // Initial device voltage
   AddParameter( "SENS_AREA", m_bSensArea, false);   // flag to request sensitivity WRT area
   AddParameter( "D", m_bD, true);                   // Diode model

   AddValue( "VD", m_dPNVoltage);                    // Diode voltage
   AddValue( "ID", m_dCurrent)->Alias( "C");         // Diode current
   AddValue( "GD", m_dCond);                         // Diode conductance
   AddValue( "CHARGE", m_dCharge);                   // Diode capacitor charge
   AddValue( "CD", m_dCap);                          // Diode capacitance
   AddValue( "CAPCUR", m_dCapCurrent);               // Diode capacitor current
   AddValue( "P", m_dPower);                         // Diode Power
   AddValue( "SENS_DC",   m_dUnusedSensValue, false); // dc sensitivity
   AddValue( "SENS_REAL", m_dUnusedSensValue, false); // dc sens. and real part of ac sensitivity
   AddValue( "SENS_IMAG", m_dUnusedSensValue, false); // imag part of ac sensitivity
   AddValue( "SENS_MAG",  m_dUnusedSensValue, false); // sensitivity of ac magnitude
   AddValue( "SENS_PH",   m_dUnusedSensValue, false); // sensitivity of ac phase
   AddValue( "SENS_CPIX", m_dUnusedSensValue, false); // ac sensitivity
   AddValue( "Vr", m_dResVoltage);
   AddValue( "Gr", m_dResCond);
   AddValue( "Ir", m_dResCurrent);

   m_dResCurrent = 0.;
   m_dResVoltage = 0.;
   m_dResCond    = 0.;

   m_tJctPot    = 0.0;
   m_tJctCap    = 0.0;
   m_tDepCap    = 0.0;
   m_tSatCur    = 0.0;
   m_tVcrit     = 0.0;
   m_tF1        = 0.0;
   m_tBrkdwnV   = 0.0;
   m_f2                 = 0.0;
   m_f3                 = 0.0;
   m_dVte               = 0.0;
} */

        Real m_area(start = 1.0);                   // "AREA", Area factor
        Boolean m_bOff(start = false);              // "OFF", Initially off
        Real m_dIC(start = 0.0);                    // "IC", Initial device voltage
        Real m_pIcIsGiven;
        Boolean m_bSensArea(start = false);         // "SENS_AREA", flag to request sensitivity WRT area
       // Boolean m_bD(start = true);                 // "D", Diode model

      //Ausgabeparameter

        // Real m_dPNVoltage;                          // "VD", Diode voltage
        // Real m_dCurrent;                            // "ID", Diode current
        // Real m_dCond;                               // "GD", Diode conductance
        // Real m_dCharge;                             // "CHARGE", Diode capacitor charge
        // Real m_dCap;                                // "CD", Diode capacitance
        // Real m_dCapCurrent;                         // "CAPCUR", Diode capacitor current
        // Real m_dPower;                              // "P", Diode Power
        // Boolean m_dUnusedSensValue1(start = false); // "SENS_DC", dc sensitivity
        // Boolean m_dUnusedSensValue2(start = false); // "SENS_REAL", dc sens. and real part of ac sensitivity
        // Boolean m_dUnusedSensValue3(start = false); // "SENS_IMAG", imag part of ac sensitivity
        // Boolean m_dUnusedSensValue4(start = false); // "SENS_MAG", sensitivity of ac magnitude
        // Boolean m_dUnusedSensValue5(start = false); // "SENS_PH", sensitivity of ac phase
        // Boolean m_dUnusedSensValue6(start = false); // "SENS_CPIX", ac sensitivity

      //werden by additional values berechnet, möglichweiße nicht wichtig für funktionalität der diode
        // Real m_dResVoltage(start = 0.0);            // "Vr"
        // Real m_dResCond(start = 0.0);               // "Gr"
        // Real m_dResCurrent(start = 0.0);            // "Ir"

        // stehen in DiodeCalc
      /*  Real m_tJctPot(start = 0.0);
  Real m_tJctCap(start = 0.0);
  Real m_tDepCap(start = 0.0);
  Real m_tSatCur(start = 0.0);
  Real m_tVcrit(start = 0.0);
  Real m_tF1(start = 0.0);
  Real m_tBrkdwnV(start = 0.0);
  Real m_f2(start = 0.0);
  Real m_f3(start = 0.0);
  Real m_dVte(start = 0.0);
*/
      end DiodeParams;

      record DiodeVariables

        Real m_pBvIsGiven;

      //zusätzliche ausgabewerte, die möglicherweiße keinen einfluss auf unktion der diode haben
        // Real m_dResVoltage;
        // Real m_dResCond;
        // Real m_dResCurrent;
        // Real m_dPower;

      end DiodeVariables;

      record DiodeCalc

        Real m_tJctPot;
        Real m_tJctCap;
        Real m_tF1;
        Real m_f2;
        Real m_f3;
        Real m_tSatCur;
        Real m_tVcrit;
        Real m_dVte;
        Real m_tBrkdwnV;

      end DiodeCalc;

      record CurrentsCapacitances

        Real m_dCurrent;
      //  Real m_dCapCurrent;

      end CurrentsCapacitances;

      function DiodeModelLineInitEquations
      /* void Diode_Model_Line::InitEquations() */

        input DiodeModelLineParams in_p;

        output DiodeModelLineVariables out_v;

      algorithm
      /*{// limit grading coeff to max of .9
   if (m_gradingCoeff > .9)
   {
      Ex_Param_MaxLimit( this, "M", m_gradingCoeff, .9);       // Grading coefficient
      m_gradingCoeff = .9;
   }
   // limit activation energy to min of .1
   if (m_activationEnergy < .1)
   {
      Ex_Param_MinLimit( this, "EG", m_activationEnergy, .1);    // Activation energy
      m_activationEnergy = .1;
   }
   // limit depletion cap coeff to max of .95
   if (m_depletionCapCoeff > .95)
   {
      Ex_Param_MaxLimit( this, "FC", m_depletionCapCoeff, .95); // Forward bias junction fit parameter
      m_depletionCapCoeff = .95;
   }

   if (m_resist == 0.0)
      m_conductance = 0.0;
   else
      m_conductance = 1.0 / m_resist;
}*/

        // limit grading coeff to max of .9
        if (in_p.m_gradingCoeff > 0.9) then
          out_v.m_gradingCoeff := 0.9;
        end if;
        // limit activation energy to min of .1
        if (in_p.m_activationEnergy < 0.1) then
          out_v.m_activationEnergy := 0.1;
        end if;
        // limit depletion cap coeff to max of .95
        if (in_p.m_depletionCapCoeff > 0.95) then
          out_v.m_depletionCapCoeff := 0.95;
        end if;

        out_v.m_conductance := if (in_p.m_resist == 0.0) then 0.0 else 1.0 / in_p.m_resist;

      end DiodeModelLineInitEquations;

      function DiodeInitEquations
      /* void Diode::InitEquations() */

        input DiodeModelLineParams in_p;

        output DiodeVariables out_v;

      algorithm
      /* {
//        Testen Value of BV (Durchbruchsspannung auf sinnvollen numerischen Wert       -  St.Scholz,27.09.2001

//        Ex_Param_BvIsGiven(this,"BV",(int)(m_pModel->m_pBvValue->IsGiven())).print();

        if (m_pModel->m_pBvValue->IsGiven())
                if (m_pModel->m_breakdownVoltage>1.0e+100)
                {
#ifdef SML_DEBUG
                        Ex_Param_BvToLarge(this,"BV",m_pModel->m_breakdownVoltage).print();
#endif
                        m_pModel->m_pBvValue->SetIsGivenFalse();
//                        Ex_Param_BvIsGiven(this,"BV",(m_pModel->m_pBvValue->IsGiven())).print();
                }
                else
                {
                        if (m_pModel->m_breakdownVoltage<1.0e+00)
                        {
                                Ex_Param_BvToSmall(this,"BV",m_pModel->m_breakdownVoltage).print();
                        }
//                        else
//                        {
//                                Ex_Param_Bv(this,"BV",m_pModel->m_breakdownVoltage).print();
//                        }
                }
} */
       out_v.m_pBvIsGiven := in_p.m_pBvIsGiven;
        if (out_v.m_pBvIsGiven > 0.5) then
          if (in_p.m_breakdownVoltage > 1.0e+100) then
            out_v.m_pBvIsGiven := 1.0e-41; // auf false setzen!
          end if;
        end if;

      end DiodeInitEquations;

      function DiodeCalcTempDependencies
      /* void Diode::CalcTempDependencies() */

        input DiodeModelLineParams in_p;
        input DiodeParams in_dp;
        input Spice3.Repository.Model.Model in_m;
        input DiodeVariables in_v;

        output DiodeCalc out_c;

      algorithm
      /*{if (!m_pModel)
      DefineDotModel();

   // theoretisch korrekt waere: (aber wg. SPICE-Kompatibilitaet):
   //    m_tJctPot = JunctionPotDepTemp(
   //       m_pModel->m_junctionPot, m_dTemp, m_pModel->m_nomTemp);
   //    m_tJctCap = m_area * JunctionCapDepTemp(
   //       m_pModel->m_junctionCap, m_pModel->m_gradingCoeff,
   //       m_pModel->m_junctionPot, m_dTemp, m_pModel->m_nomTemp);
   JunctionParamDepTempSPICE3(
      m_tJctPot, m_tJctCap,
      m_pModel->m_junctionPot, m_pModel->m_junctionCap, m_pModel->m_gradingCoeff,
      m_dTemp, m_pModel->m_nomTemp);
   m_tJctCap = m_area * m_tJctCap;
   JunctionCapCoeffs(
      m_tF1, m_f2, m_f3, m_pModel->m_gradingCoeff,
      m_pModel->m_depletionCapCoeff, m_tJctPot);

   m_tSatCur = SaturationCurDepTempSPICE3(
      m_pModel->m_satCur, m_dTemp, m_pModel->m_nomTemp,
      m_pModel->m_emissionCoeff,
      m_pModel->m_activationEnergy,
      m_pModel->m_saturationCurrentExp);
   m_tVcrit = JunctionVCrit( m_dTemp, m_pModel->m_emissionCoeff, m_tSatCur);
   m_dVte   = m_dTemp * CONSTKoverQ * m_pModel->m_emissionCoeff;
   if (m_pModel->m_pBvValue->IsGiven())
      m_tBrkdwnV = JunctionVoltage23_SPICE3(
         this, m_pModel->m_breakdownVoltage, m_pModel->m_breakdownCurrent,
         m_tSatCur, m_dTemp, m_pModel->m_emissionCoeff);
   m_tSatCur = m_area * m_tSatCur;
} */

        (out_c.m_tJctPot,out_c.m_tJctCap) :=
          Spice3.Repository.Equation.JunctionParamDepTempSPICE3(
                in_p.m_junctionPot,
                in_p.m_junctionCap,
                in_p.m_gradingCoeff,
                in_m.m_dTemp,
                in_p.m_nomTemp);
        out_c.m_tJctCap := in_dp.m_area * out_c.m_tJctCap;
        (out_c.m_tF1,out_c.m_f2,out_c.m_f3) :=
          Spice3.Repository.Equation.JunctionCapCoeffs(
                in_p.m_gradingCoeff,
                in_p.m_depletionCapCoeff,
                out_c.m_tJctPot);

        out_c.m_tSatCur :=
          Spice3.Repository.Equation.SaturationCurDepTempSPICE3(
                in_p.m_satCur,
                in_m.m_dTemp,
                in_p.m_nomTemp,
                in_p.m_emissionCoeff,
                in_p.m_activationEnergy,
                in_p.m_saturationCurrentExp);
        out_c.m_tVcrit := Spice3.Repository.Equation.JunctionVCrit(
                in_m.m_dTemp,
                in_p.m_emissionCoeff,
                out_c.m_tSatCur);
        out_c.m_dVte := in_m.m_dTemp*Spice3.Repository.SpiceConstants.CONSTKoverQ
          *in_p.m_emissionCoeff;
        if (in_v.m_pBvIsGiven > 0.5) then
          out_c.m_tBrkdwnV :=
            Spice3.Repository.Equation.JunctionVoltage23_SPICE3(
                  in_p.m_breakdownVoltage,
                  in_p.m_breakdownCurrent,
                  out_c.m_tSatCur,
                  in_m.m_dTemp,
                  in_p.m_emissionCoeff);
        end if;
        out_c.m_tSatCur := in_dp.m_area * out_c.m_tSatCur;

      end DiodeCalcTempDependencies;

      function DiodeNoBypassCode
      /* void Diode::NoBypassCode() */

        input DiodeModelLineParams in_p;
        input DiodeParams in_dp;
        input DiodeCalc in_c;
        input Spice3.Repository.Model.Model in_m;
        input Boolean in_m_mbInit;
        input Real[2] in_m_pVoltageValues; /* DPP, DN */
       // input Real[2] in_m_pVoltageValuesDot; /* DPP, DN */

        output CurrentsCapacitances out_cc;
        // output Real guck1;                      //EDIT by K.Majetta
        output Real m_dCap;
      protected
        Real guck1;
        Real m_dPNVoltage;
        Real m_dCurrent;
        Real m_dCond;
       // Real m_dCap;
        Real m_dCharge;
        Real m_dCapCurrent;

      algorithm
      /*{
//        Ausgabe, ob Parameter "BV" für diese Diode gesetzt!!!
//        Ex_Param_BvIsGiven(this,"BV",(int)(m_pModel->m_pBvValue->IsGiven())).print();

   m_dPNVoltage = GetVoltage( DPP, DN);

   if (UseInitialConditions() && m_pIcValue->IsGiven())
      m_dPNVoltage = m_dIC;
   else if (InitJunctionVoltages())
      if (m_bOff)
         m_dPNVoltage = 0.;
      else
         m_dPNVoltage = m_tVcrit;

   m_dPNVoltage = LimitJunctionVoltage(
      m_dPNVoltage, m_dVte, m_tVcrit, m_pModel->m_pBvValue->IsGiven(), m_tBrkdwnV); */

        m_dPNVoltage := in_m_pVoltageValues[1] - in_m_pVoltageValues[2]; /*GetVoltage(DPP, DN)*/

        if (Spice3.Repository.SpiceRoot.UseInitialConditions() and in_dp.m_pIcIsGiven > 0.5) then
          m_dPNVoltage := in_dp.m_dIC;
        elseif (Spice3.Repository.SpiceRoot.InitJunctionVoltages()) then
          if (in_dp.m_bOff) then
            m_dPNVoltage := 0.0;
          else
            m_dPNVoltage := in_c.m_tVcrit;
          end if;
        end if;

      /* //////////////////////////////////////////////////////////////////////
   // resistance
   InternConductance( DP, DPP, m_pModel->m_conductance * m_area);

   //////////////////////////////////////////////////////////////////////
   // junction current
   if (m_pModel->m_pBvValue->IsGiven())
      Junction3(
         m_dCurrent, m_dCond, m_dPNVoltage, m_dTemp, m_pModel->m_emissionCoeff, m_tSatCur, m_tBrkdwnV);
   else
      Junction2(
         m_dCurrent, m_dCond, m_dPNVoltage, m_dTemp, m_pModel->m_emissionCoeff, m_tSatCur);
   InsertConductance( DPP, DN, m_dCond, m_dCurrent, m_dPNVoltage); */

        if (in_p.m_pBvIsGiven > 0.5) then
          (out_cc.m_dCurrent,m_dCond) := Spice3.Repository.Equation.Junction3(
                  m_dPNVoltage,
                  in_m.m_dTemp,
                  in_p.m_emissionCoeff,
                  in_c.m_tSatCur,
                  in_c.m_tBrkdwnV);
        else
          (out_cc.m_dCurrent,m_dCond,guck1) :=
            Spice3.Repository.Equation.Junction2(
                  m_dPNVoltage,
                  in_m.m_dTemp,
                  in_p.m_emissionCoeff,
                  in_c.m_tSatCur);
        end if;

      /* //////////////////////////////////////////////////////////////////////
   // charge storage elements
   JunctionCapTransTime(
      m_dCap, m_dCharge, m_tJctCap, m_dPNVoltage, m_tJctPot * m_pModel->m_depletionCapCoeff,
      m_pModel->m_gradingCoeff, m_pModel->m_junctionPot, m_tF1, m_f2, m_f3,
      m_pModel->m_transitTime, m_dCond, m_dCurrent);
   // korrekt waere: (wieder mal Kompatibilitaet ...)
   //    JunctionCapTransTime(
   //       m_dCap, m_dCharge, m_tJctCap, m_dPNVoltage, m_tJctPot * m_pModel->m_depletionCapCoeff,
   //       m_pModel->m_gradingCoeff, m_tJctPot, m_tF1, m_f2, m_f3,
   //       m_pModel->m_transitTime, m_dCond, m_dCurrent);
   m_dCapCurrent = InsertCapacitance( DPP, DN, m_dCap, m_dCharge, m_dPNVoltage);
} */

       //////////////////////////////////////////////////////////////////////
       // charge storage elements
        (m_dCap,m_dCharge) := Spice3.Repository.Equation.JunctionCapTransTime(
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
      //  out_cc.m_dCapCurrent :=if (in_m_mbInit) then 0.0 else m_dCap*(in_m_pVoltageValuesDot[1]-in_m_pVoltageValuesDot[2]);

      end DiodeNoBypassCode;

      function DiodeCalcAdditionalValues
      /* void Diode::CalcAdditionalValues() */
        input DiodeVariables in_v;
        input DiodeModelLineParams in_p;
        input DiodeParams in_dp;
        input Real[2] in_m_pVoltageValues; /* DP, DPP */

        output DiodeVariables out_v;

      algorithm
        out_v := in_v;

      // /*{
      //    m_dResVoltage = GetVoltage( DP, DPP);
      //    m_dResCond    = m_pModel->m_conductance * m_area;
      //    m_dResCurrent = m_dResVoltage * m_dResCond;
      //
      //    m_dPower = m_dPNVoltage * m_dCurrent;
      // } */
      //auskommentiert kristin
      //   out_v.m_dResVoltage := in_m_pVoltageValues[1] - in_m_pVoltageValues[2];
      //   out_v.m_dResCond    := in_p.m_conductance * in_dp.m_area;
      //   out_v.m_dResCurrent := out_v.m_dResVoltage * out_v.m_dResCond;
      //   out_v.m_dPower      := in_dp.m_dPNVoltage * in_dp.m_dCurrent;

      end DiodeCalcAdditionalValues;

      function DiodeRenameParameters
        "renames the external parameters (e.g. RD) into the internal names (e.g. m_drainResistance)"

        input Spice3.Repository.modelcardDIODE ex;
        input Spice3.Repository.SpiceConstants con;

        output Spice3.Repository.Diode.DiodeModelLineParams intern;

      algorithm
        // from DiodeModelLinesParams

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

         //assert(ex.BV >= 0, "Breakthrough voltage BV must be not be negative");

         intern.m_breakdownCurrent := ex.IBV;
        intern.m_nomTemp := ex.TNOM + Spice3.Repository.SpiceConstants.CONSTCtoK;
         intern.m_fNcoef := ex.KF;
         intern.m_fNexp := ex.AF;

         intern.m_conductance := if (ex.RS == 0) then  0 else 1/ex.RS;

      end DiodeRenameParameters;

      function DiodeRenameParameters_dev
       // "renames the external parameters (e.g. RD) into the internal names (e.g. m_drainResistance)"
      //  input Spice3_diode.Repository.modelcardMOS ex;
       // input Spice3.Attempt_1_konstanten_parameter_inArbeit.SpiceConstants con;
        input Real TEMP;
        input Real AREA;
        input Real IC;
        input Boolean OFF;
        input Boolean SENS_AREA;

        output DiodeParams dev;

      algorithm
      /*device parameters*/
        dev.m_area := AREA;

        dev.m_pIcIsGiven := if (IC > -1e40) then 1 else 0;
        dev.m_dIC := if
                       (IC > -1e40) then IC else 0;
        dev.m_bOff := OFF;
        dev.m_bSensArea := SENS_AREA;

      end DiodeRenameParameters_dev;

      function DiodeRenameParameters_dev_temp
       // "renames the external parameters (e.g. RD) into the internal names (e.g. m_drainResistance)"
      //  input Spice3_diode.Repository.modelcardMOS ex;
       // input Spice3.Attempt_1_konstanten_parameter_inArbeit.SpiceConstants con;
        input Real TEMP;
        output Spice3.Repository.Model.Model dev_temp;

      algorithm
        dev_temp.m_dTemp := TEMP + Spice3.Repository.SpiceConstants.CONSTCtoK;

      end DiodeRenameParameters_dev_temp;
    end Diode;

    package R_semiconductor
      record ResistorParams
      /*    m_pResValue   = AddParameter( "R", m_dResist, 1000.);      // Device is a resistor model
   m_pWidthValue = AddParameter( "W", m_dWidth, 0.);          // Width
   AddParameter( "L", m_dLength, 0.);                         // Length
   AddParameter( "SENS_RESIST", m_bSensResist, false);        // flag to request sensitivity WRT resistance
   */
          Real m_dResist( start=1000) "Device is a resistor model";
          Real m_dResIsGiven;
          Real m_dWidth( start=0) "Width";
          Real m_dWidthIsGiven;
          Real m_dLength "Length";
          Real m_dLengthIsGiven;
          Boolean m_bSensResist( start = false)
          "flag to request sensitivity WRT resistance";
          Real m_dTemp(start = 27);

      end ResistorParams;

      record ResistorModelLineParams

          Real m_dTC1 "First order temp, coefficient";
          Real m_dTC2 "Second order temp, coefficient";
          Real m_dRsh "Sheet resistance";
          Real m_dRshIsGiven;
          Real m_dDefW "Default device width";
          Real m_dNarrow "Narrowing of resistor";
          Real m_dTnom "Parameter measurement temperature";

         /*AddParameter( "R", m_bR, true);                            // Device is a resistor model
   AddParameter( "TC1", m_dTC1, 0.0);                         // First order temp, coefficient
   AddParameter( "TC2", m_dTC2, 0.0);                         // Second order temp, coefficient
   AddParameter( "RSH", m_dRsh, 0.0);                         // Sheet resistance
   AddParameter( "DEFW", m_dDefW, 10e-6);                     // Default device width
   AddParameter( "NARROW", m_dNarrow, 0.0);                   // Narrowing of resistor
   AddParameter( "TNOM", m_dTnom, CKTnomTemp)->SetOffset( CONSTCtoK);// Parameter measurement temperature*/
      end ResistorModelLineParams;

      record ResistorVariables
       Real m_dWidth;
       Real m_dLength;
       Real m_dResist;
       Real m_dConduct;
       Real m_dCond_dTemp;
      end ResistorVariables;

      function ResistorRenameParameters

      input Spice3.Repository.modelcardR ex;
      input Spice3.Repository.SpiceConstants con;

      output Spice3.Repository.R_semiconductor.ResistorModelLineParams intern;

      algorithm
        intern.m_dTC1 := ex.TC1;
        intern.m_dTC2 := ex.TC2;

        intern.m_dRshIsGiven := if (ex.RSH > -1e40) then 1 else 0;
        intern.m_dRsh := if (ex.RSH > -1e40) then ex.RSH else 0;

        intern.m_dDefW := ex.DEFW;
        intern.m_dNarrow := ex.NARROW;
        intern.m_dTnom := if (ex.TNOM > -1e40) then ex.TNOM + Spice3.Repository.SpiceRoot.SPICEcircuitCONST.CONSTCtoK else
                300.15;

      end ResistorRenameParameters;

      function ResistorRenameParameters_dev

        input Real R;
        input Real W;
        input Real L;
        input Real TEMP;
        input Boolean SENS_AREA;

       input Spice3.Repository.SpiceConstants con;

       output ResistorParams intern;

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
        intern.m_dTemp := if (TEMP > -1e40) then TEMP + Spice3.Repository.SpiceRoot.SPICEcircuitCONST.CONSTCtoK else
                300.15;

      end ResistorRenameParameters_dev;

      function ResistorInitEquations
       input Spice3.Repository.R_semiconductor.ResistorParams in_p;
       input Spice3.Repository.R_semiconductor.ResistorModelLineParams in_p2;
       output ResistorVariables out;

      /*
void Resistor::InitEquations()
{
   if (!m_pResValue->IsGiven())

      if (m_pModel && (F_Abs(m_dLength)>1e-18) && (F_Abs(m_pModel->m_dRsh)>1e-25))
      {
         if (!m_pWidthValue->IsGiven())
            m_dWidth = m_pModel->m_dDefW;
         m_dResist   = ResDepGeom(
            m_pModel->m_dRsh, m_dWidth, m_dLength, m_pModel->m_dNarrow);
      }
      else
         Ex_Param_WarnDefault( this, "R", F_String( m_dResist)).print();
   if (m_dResist < 1e-12)
   {
      Ex_Param_MinLimit( this, "R", m_dResist, 1e-12).print();
      m_dResist = 1e-12;
   }
}
 */
      algorithm
      out.m_dWidth := in_p.m_dWidth;
        if ( in_p.m_dResIsGiven < 0.5) then
            if (abs(in_p.m_dLength)>1e-8) and (abs(in_p2.m_dRsh)>1e-25) then
                if (not (in_p.m_dWidthIsGiven > 0.5)) then
                    out.m_dWidth :=in_p2.m_dDefW;
                end if;

            (out.m_dResist) := Spice3.Repository.Equation.ResDepGeom(
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

      end ResistorInitEquations;

    end R_semiconductor;

    package Bjt3
      record BjtModelLineParams

        //String m_type( start = "NPN");
         Real m_type( start = 1);             // device type : 1 = n,  -1 = p

         Boolean m_bNPN( start = true);            // "NPN", NPN type device
         Boolean m_bPNP( start = false);           // "PNP", PNP type device
        Real m_tnom( start=Spice3.Repository.SpiceConstants.CKTnomTemp);
                                                         // "TNOM", Parameter measurement temperature
        Real m_satCur( start = 1.0e-16);          // "IS", Saturation Current
        Real m_betaF( start = 100.0);             // "BF", Ideal forward beta
        Real m_emissionCoeffF(  start = 1.0);      // "NF", Forward emission coefficient
        Real m_leakBEemissionCoeff( start = 1.5); // "NE", B-E leakage emission coefficient
        Real m_leakBEcurrent( start = 0.);        // "ISE", B-E leakage saturation current
        Real m_c2( start = 0.);                   // "C2", Obsolete parameter name
        Real m_leakBCcurrent( start = 0.);        // "ISC", B-C leakage saturation current
        Real m_c4( start = 0.);                   // "C4", Obsolete parameter name
        Real m_leakBEcurrentIsGiven;
        Real m_c2IsGiven;
        Real m_leakBCcurrentIsGiven;
        Real m_c4IsGiven;
        Real m_betaR( start = 1.0);                    // "BR", Ideal reverse beta
        Real m_emissionCoeffR( start = 1.0);           // "NR", Reverse emission coefficient
        Real m_leakBCemissionCoeff( start = 2.0);      // "NC", B-C leakage emission coefficient
        Real m_earlyVoltF( start = 0.0);               // "VAF", Forward Early voltage
        Real m_rollOffF( start = 0.0);                 // "IKF", Forward beta roll-off corner current
        Real m_earlyVoltR( start = 0.0);               // "VAR", Reverse Early voltage
        Real m_rollOffR( start = 0.0);                 // "IKR", reverse beta roll-off corner current
        Real m_emitterResist( start = 0.0);            // "RE", Emitter resistance
        Real m_collectorResist( start = 0.0);          // "RC", Collector resistance
        Real m_baseCurrentHalfResist( start = 0.0);    // "IRB", Current for base resistance=(rb+rbm)/2
        Real m_baseResist( start = 0.0);               // "RB", Zero bias base resistance
        Real m_minBaseResist( start = 0.0);            // "RBM", Minimum base resistance
        Real m_minBaseResistIsGiven;
        Real m_depletionCapBE( start = 0.0);           // "CJE", Zero bias B-E depletion capacitance
        Real m_potentialBE( start = 0.75);             // "VJE", B-E built in potential
        Real m_junctionExpBE( start = 0.33);           // "MJE", B-E built in potential
        Real m_transitTimeF( start = 0.0);             // "TF", Ideal forward transit time
        Real m_transitTimeBiasCoeffF( start = 0.0);    // "XTF", Coefficient for bias dependence of TF
        Real m_transitTimeHighCurrentF( start = 0.0);  // "ITF", High current dependence of TF
        Real m_transitTimeFVBC( start = 0.0);          // "VTF", Voltage giving VBC dependence of TF
        Real m_excessPhase( start = 0.0);              // "PTF", Excess phase
        Real m_depletionCapBC( start = 0.0);           // "CJC", Zero bias B-C depletion capacitance
        Real m_potentialBC( start = 0.75);             // "VJC", B-C built in potential
        Real m_junctionExpBC( start = 0.33);           // "MJC", B-C junction grading coefficient
        Real m_baseFractionBCcap( start = 1.0);        // "XCJC", Fraction of B-C cap to internal base
        Real m_transitTimeR( start = 0.0);             // "TR", Ideal reverse transit time
        Real m_capCS( start = 0.0);                    // "CJS", Zero bias C-S capacitance
        Real m_potentialSubstrate( start = 0.75);      // "VJS", Zero bias C-S capacitance
        Real m_exponentialSubstrate( start = 0.0);     // "MJS", Substrate junction grading coefficient
        Real m_betaExp( start = 0.0);                  // "XTB", Forward and reverse beta temp. exp.
        Real m_energyGap( start = 1.11);               // "EG", Energy gap for IS temp. dependency
        Real m_tempExpIS( start = 3.0);                // "XTI",Temp. exponent for IS
        Real m_fNcoef( start = 0.0);                   // "KF", Flicker Noise Coefficient
        Real m_fNexp( start = 1.0);                    // "AF", Flicker Noise Exponent
        Real m_depletionCapCoeff( start = 0.5);        // "FC", Forward bias junction fit parameter

        Real m_collectorConduct( start = 0.0);
        Real m_emitterConduct( start = 0.0);
        Real m_transitTimeVBCFactor( start = 0.0);
        Real m_excessPhaseFactor( start = 0.0);
        Real m_invEarlyVoltF( start = 0.0);
        Real m_invRollOffF( start = 0.0);
        Real m_invEarlyVoltR( start = 0.0);
        Real m_invRollOffR( start = 0.0);

      /* Bjt_Model_Line::Bjt_Model_Line( const String& elementname)
        : DotModel( "BJT .MODEL", elementname)
{
   AddParameter( "NPN", m_bNPN, true);         // NPN type device
   AddParameter( "PNP", m_bPNP, false);        // PNP type device
   AddParameter( "TNOM", m_tnom, CKTnomTemp)->SetOffset( CONSTCtoK); // Parameter measurement temperature
   AddParameter( "IS", m_satCur, 1e-16);       // Saturation Current
   AddParameter( "BF", m_betaF, 100.);         // Ideal forward beta
   AddParameter( "NF", m_emissionCoeffF, 1.);  // Forward emission coefficient
   AddParameter( "NE", m_leakBEemissionCoeff, 1.5); // B-E leakage emission coefficient
   m_leakBEcurrentValue = AddParameter( "ISE", m_leakBEcurrent, 0.);// B-E leakage saturation current
   m_c2Value            = AddParameter( "C2", m_c2, 0.);// Obsolete parameter name
   m_leakBCcurrentValue = AddParameter( "ISC", m_leakBCcurrent, 0.);// B-C leakage saturation current
   m_c4Value            = AddParameter( "C4", m_c4, 0.);// Obsolete parameter name
   AddParameter( "BR", m_betaR, 1.); // Ideal reverse beta
   AddParameter( "NR", m_emissionCoeffR, 1.); // Reverse emission coefficient
   AddParameter( "NC", m_leakBCemissionCoeff, 2.);// B-C leakage emission coefficient
   AddParameter( "VAF", m_earlyVoltF, 0.)->Alias( "VA");// Forward Early voltage
   AddParameter( "IKF", m_rollOffF, 0.)->Alias( "IK");// Forward beta roll-off corner current
   AddParameter( "VAR", m_earlyVoltR, 0.)->Alias( "VB");// Reverse Early voltage
   AddParameter( "IKR", m_rollOffR, 0.);// reverse beta roll-off corner current
   AddParameter( "RE", m_emitterResist, 0.);// Emitter resistance
   AddParameter( "RC", m_collectorResist, 0.);// Collector resistance
   AddParameter( "IRB", m_baseCurrentHalfResist, 0.);// Current for base resistance=(rb+rbm)/2
   AddParameter( "RB", m_baseResist, 0.);// Zero bias base resistance
   m_minBaseResistValue = AddParameter( "RBM", m_minBaseResist, 0.); // Minimum base resistance
   AddParameter( "CJE", m_depletionCapBE, 0.);// Zero bias B-E depletion capacitance
   AddParameter( "VJE", m_potentialBE, .75)->Alias( "PE");// B-E built in potential
   AddParameter( "MJE", m_junctionExpBE, .33)->Alias( "ME");// B-E built in potential
   AddParameter( "TF", m_transitTimeF, 0.);// Ideal forward transit time
   AddParameter( "XTF", m_transitTimeBiasCoeffF, 0.);// Coefficient for bias dependence of TF
   AddParameter( "ITF", m_transitTimeHighCurrentF, 0.);// High current dependence of TF
   AddParameter( "VTF", m_transitTimeFVBC, 0.);// Voltage giving VBC dependence of TF
   AddParameter( "PTF", m_excessPhase, 0.);// Excess phase
   AddParameter( "CJC", m_depletionCapBC, 0.);// Zero bias B-C depletion capacitance
   AddParameter( "VJC", m_potentialBC, .75)->Alias( "PC");// B-C built in potential
   AddParameter( "MJC", m_junctionExpBC, .33)->Alias( "MC");// B-C junction grading coefficient
   AddParameter( "XCJC", m_baseFractionBCcap, 1.);// Fraction of B-C cap to internal base
   AddParameter( "TR", m_transitTimeR, 0.);// Ideal reverse transit time
   AddParameter( "CJS", m_capCS, 0.)->Alias( "CCS");// Zero bias C-S capacitance
   AddParameter( "VJS", m_potentialSubstrate, .75)->Alias( "PS");// Zero bias C-S capacitance
   AddParameter( "MJS", m_exponentialSubstrate, 0.)->Alias( "MS");// Substrate junction grading coefficient
   AddParameter( "XTB", m_betaExp, 0.);// Forward and reverse beta temp. exp.
   AddParameter( "EG", m_energyGap, 1.11);// Energy gap for IS temp. dependency
   AddParameter( "XTI", m_tempExpIS, 3.);// Temp. exponent for IS
   AddParameter( "KF", m_fNcoef, 0.);// Flicker Noise Coefficient
   AddParameter( "AF", m_fNexp, 1.);// Flicker Noise Exponent
   AddParameter( "FC", m_depletionCapCoeff, .5);// Forward bias junction fit parameter

   m_collectorConduct     = 0.;
   m_emitterConduct       = 0.;
   m_transitTimeVBCFactor = 0.;
   m_excessPhaseFactor    = 0.;
   m_type                 = NPN;
   m_invEarlyVoltF        = 0.;
   m_invRollOffF          = 0.;
   m_invEarlyVoltR        = 0.;
   m_invRollOffR          = 0.;
}
*/
      end BjtModelLineParams;

      record BjtModelLineVariables

        Real m_leakBEcurrent;
        Real m_leakBCcurrent;
        Real m_minBaseResist;
        Real m_invEarlyVoltF;
        Real m_invRollOffF;
        Real m_invEarlyVoltR;
        Real m_invRollOffR;
        Real m_collectorConduct;
        Real m_emitterConduct;
        Real m_transitTimeVBCFactor;
        Real m_excessPhaseFactor;

        Integer m_type;

      end BjtModelLineVariables;

      function BjtModelLineInitEquations
      /* void Bjt_Model_Line::InitEquations() */

        input BjtModelLineParams in_p;

        output BjtModelLineVariables out_v;

      protected
        Real xfc;

      algorithm
      /* { m_type = m_bPNP ? PNP : NPN;

   double xfc;

   if ((!m_leakBEcurrentValue->IsGiven()) && (m_c2Value->IsGiven()))
      m_leakBEcurrent = m_c2 * m_satCur;
   if ((!m_leakBCcurrentValue->IsGiven()) && (m_c4Value->IsGiven()))
      m_leakBCcurrent = m_c4 * m_satCur;
   if (!m_minBaseResistValue->IsGiven())
      m_minBaseResist = m_baseResist;
   if (m_earlyVoltF != 0)
      m_invEarlyVoltF = 1 / m_earlyVoltF;
   if (m_rollOffF != 0)
      m_invRollOffF = 1 / m_rollOffF;
   if (m_earlyVoltR != 0)
      m_invEarlyVoltR = 1 / m_earlyVoltR;
   if (m_rollOffR != 0)
      m_invRollOffR = 1 / m_rollOffR;
   if (m_collectorResist != 0)
      m_collectorConduct = 1 / m_collectorResist;
   if (m_emitterResist != 0)
      m_emitterConduct = 1 / m_emitterResist;
   if (m_transitTimeFVBC != 0)
      m_transitTimeVBCFactor =1 / (m_transitTimeFVBC * 1.44);
   m_excessPhaseFactor = (m_excessPhase / (180.0 / M_PI)) * m_transitTimeF;
   if (m_depletionCapCoeff > .9999)
   {
      Ex_Param_MaxLimit( this, "FC", m_depletionCapCoeff, .9999);
      m_depletionCapCoeff = .9999;
   }
   xfc  = log( 1 - m_depletionCapCoeff);
}  */

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

      end BjtModelLineInitEquations;

      record Bjt3
        extends Model.Model;
      /* Bjt3::Bjt3( const String& elementname)
        : Model( "Bjt", elementname), m_pModel( NULL)
{
   Col          = 1;
   Base         = 2;
   Emit         = 3;
   ColP         = 4;
   BaseP        = 5;
   EmitP        = 6;

   AddParameter( "AREA", m_area, 1.);
   AddParameter( "OFF", m_bOff, false);
   m_bICvbeValue = AddParameter( "IC_VBE", m_dICvbe, 0.0)->Alias( "IC_1")->Alias( "IC");
   m_bICvceValue = AddParameter( "IC_VCE", m_dICvce, 0.0)->Alias( "IC_2");
   AddParameter( "SENS_AREA", m_bSensArea, false);

   m_tSatCur = 0.;  // temperature adjusted saturation current
   m_tBetaF = 1.;   // temperature adjusted forward beta
   m_tBetaR        = 1.;   // temperature adjusted reverse beta
   m_tBEleakCur    = 1.e-14;   // temperature adjusted B-E leakage current
   m_tBCleakCur  = 1.e-14;   // temperature adjusted B-C leakage current
   m_tBEcap      = 0.;   // temperature adjusted B-E capacitance
   m_tBEpot      = .7;   // temperature adjusted B-E potential
   m_tBCcap      = 0.;   // temperature adjusted intern B-C capacitance
   m_tBCpot      = .7;   // temperature adjusted B-C potential
   m_CScap       = 0.;    // C-S capacitance
   m_tDepCapBC     = .7;  // temperature adjusted join point in diode curve
   m_tDepCapBE     = .7;  // temperature adjusted join point in diode curve
   m_tVcrit    = .7;   // temperature adjusted critical voltage
   m_dVt         = .025;

   m_transitTimeHighCurrentF = 0.;
   m_invRollOffF             = 0.;
   m_invRollOffR             = 0.;

   m_tF1c         = 0.;      // temperature adjusted polynomial coefficient
   m_tF1e         = 0.;      // temperature adjusted polynomial coefficient
   m_f2c          = 0.;      // temperature adjusted polynomial coefficient
   m_f2e          = 0.;      // temperature adjusted polynomial coefficient
   m_f3c          = 0.;      // temperature adjusted polynomial coefficient
   m_f3e          = 0.;      // temperature adjusted polynomial coefficient
} */
       Real m_area(  start = 1.0);           // "AREA"
       Boolean m_bOff(  start = false);      // "OFF"
       Real m_dICvbe( start = 0.0);         // "IC_VBE"
       Real m_bICvbeIsGiven( start = 0.0);  // Startwert wie m_dICvbe
       Real m_dICvce( start = 0.0);         // "IC_VCE"
       Real m_bICvceIsGiven( start = 0.0);  // Startwert wie m_dICvce
       Boolean m_bSensArea( start = false);  // "SENS_AREA"

       //  Real m_tSatCur( start = 0.0);        // temperature adjusted saturation current
       //  Real m_tBetaF( start = 1.0);         // temperature adjusted forward beta
       //  Real m_tBetaR( start = 1.0);         // temperature adjusted reverse beta
       //  Real m_tBEleakCur( start = 1.0e-14); // temperature adjusted B-E leakage current
       //  Real m_tBCleakCur( start = 1.0e-14); // temperature adjusted B-C leakage current
       //  Real m_tBEcap( start = 0.0);         // temperature adjusted B-E capacitance
       //  Real m_tBEpot( start = 0.7);         // temperature adjusted B-E potential
       //  Real m_tBCcap( start = 0.0);         // temperature adjusted intern B-C capacitance
       //  Real m_tBCpot( start = 0.7);         // temperature adjusted B-C potential
       //  Real m_CScap( start = 0.0);          // C-S capacitance
       //  Real m_tDepCapBC( start = 0.7);      // temperature adjusted join point in diode curve
       //  Real m_tDepCapBE( start = 0.7);      // temperature adjusted join point in diode curve
       //  Real m_tVcrit( start = 0.7);         // temperature adjusted critical voltage
       //  Real m_dVt( start = 0.025);

         Real m_transitTimeHighCurrentF(start = 0.0);
         Real m_invRollOffF( start = 0);
         Real m_invRollOffR( start = 0);

       //  Real m_tF1c( start = 0.0);           // temperature adjusted polynomial coefficient
       //  Real m_tF1e( start = 0.0);           // temperature adjusted polynomial coefficient
       //  Real m_f2c( start = 0.0);            // temperature adjusted polynomial coefficient
       //  Real m_f2e( start = 0.0);            // temperature adjusted polynomial coefficient
       //  Real m_f3c( start = 0.0);            // temperature adjusted polynomial coefficient
       //  Real m_f3e( start = 0.0);            // temperature adjusted polynomial coefficient

      end Bjt3;

      record Bjt3Variables

        Real m_transitTimeHighCurrentF( start = 0.0);
        Real m_invRollOffF( start = 0.0);
        Real m_invRollOffR( start = 0.0);

      end Bjt3Variables;

      record Bjt3Calc

        Real m_tSatCur = 0;
        Real m_tBetaF = 1;
        Real m_tBetaR = 1;
        Real m_tBEleakCur = 1e-14;
        Real m_tBCleakCur = 1e-14;
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

      end Bjt3Calc;

      record CurrentsCapacitances

        Real iBE( start = 0.0);  //Strom durch Diode dE1 (idealer Anteil)
        Real iBEN( start = 0.0); //Strom durch Diode dE2 (nicht idealer Anteil)
        Real iBC( start = 0.0); //Strom durch Diode dC1 (idealer Anteil)
        Real iBCN( start = 0.0); //Strom durch Diode dC2 (nicht idealer Anteil)
        Real iCC( start = 0.0);  //Kanalstrom
        Real capbc( start = 0.0);
        Real capbe( start = 0.0);
        Real capbx( start = 0.0);
        Real iXX( start = 0.0);
        Real capcs( start = 0.0);

      end CurrentsCapacitances;

      function Bjt3InitEquations
      /* void Bjt3::InitEquations() */

        input Bjt3 in_p;
        input BjtModelLineParams in_pml;
        input BjtModelLineVariables in_vl;
        output Bjt3Variables out_v;

      algorithm
      /* {
   if (!m_pModel)
      DefineDotModel();

   // calculate the parameters that depend on the area factor
   m_transitTimeHighCurrentF = m_pModel->m_transitTimeHighCurrentF * m_area;
   m_invRollOffF             = m_pModel->m_invRollOffF / m_area;
   m_invRollOffR             = m_pModel->m_invRollOffR / m_area;

   if (m_pModel->m_excessPhaseFactor != 0)
      InitHistory( 1, 2);
} */

        // calculate the parameters that depend on the area factor
        out_v.m_transitTimeHighCurrentF := in_pml.m_transitTimeHighCurrentF * in_p.m_area;
        out_v.m_invRollOffF             := in_vl.m_invRollOffF / in_p.m_area;
        out_v.m_invRollOffR             := in_vl.m_invRollOffR / in_p.m_area;

      //  if (m_pModel->m_excessPhaseFactor != 0)
      //    InitHistory( 1, 2);
      //  end if;

      end Bjt3InitEquations;

      function Bjt3CalcTempDependencies
      /* void Bjt3::CalcTempDependencies() */

        input Bjt3 in_p3;
        input BjtModelLineParams in_p;
        input Model.Model m;
        input BjtModelLineVariables in_vl;
      //  input Model.Model in_m;

        output Bjt3Calc out_c;

      protected
        Real xfc;
        Real gmanew;
        Real fact1;
        Real vt;
        Real fact2;
        Real egfet;
        Real arg;
        Real pbfact;
        Real ratlog;
        Real ratio1;
        Real factlog;
        Real factor;
        Real bfactor;
        Real pbo;
        Real gmaold;
       // Real m_dTemp = SpiceRoot.SPICEcircuitCONST.CKTnomTemp;
      algorithm
      /* {
C++   if (!m_pModel)
C++      DefineDotModel();
C++   double xfc, gmanew;
C++   double fact1 = m_pModel->m_tnom / REFTEMP;
C++   double vt     = GetTemperature() * CONSTKoverQ;
C++   double fact2  = GetTemperature() / REFTEMP;
C++   double egfet  = 1.16 - (7.02e-4 * GetTemperature() * GetTemperature()) / (GetTemperature() + 1108);
C++   double arg    = -egfet / (2 * CONSTboltz * GetTemperature()) + 1.1150877 / (CONSTboltz * (REFTEMP + REFTEMP));
C++   double pbfact = -2 * vt * (1.5 * log( fact2) + CHARGE * arg);

C++   double ratlog       = log( GetTemperature() / m_pModel->m_tnom);
C++   double ratio1       = GetTemperature() / m_pModel->m_tnom - 1;
C++   double factlog      = ratio1 * m_pModel->m_energyGap / vt + m_pModel->m_tempExpIS * ratlog;
C++   double factor       = exp( factlog);
C++   double bfactor      = exp(ratlog * m_pModel->m_betaExp);

C++   double pbo = (m_pModel->m_potentialBE - pbfact) / fact1;
C++   double gmaold = (m_pModel->m_potentialBE - pbo) / pbo; */

      //statt der eigentlichen Funktion "GetTemperature", wird hier m_dTemp verwendet (vorerst)

        fact1 := in_p.m_tnom/Spice3.Repository.SpiceConstants.REFTEMP;
      //  vt := GetTemperature()*Spice3.Repository.SpiceConstants.CONSTKoverQ;
        vt := m.m_dTemp*Spice3.Repository.SpiceConstants.CONSTKoverQ;
      //  fact2 := GetTemperature()/Spice3.Repository.SpiceConstants.REFTEMP;
        fact2 := m.m_dTemp/Spice3.Repository.SpiceConstants.REFTEMP;
      //  egfet  := 1.16 - (7.02e-4 * GetTemperature() * GetTemperature()) / (GetTemperature() + 1108);
        egfet  := 1.16 - (7.02e-4 * m.m_dTemp * m.m_dTemp) / (m.m_dTemp + 1108);
      //  arg := -egfet/(2*Spice3.Repository.SpiceConstants.CONSTboltz*GetTemperature()) + 1.1150877/(Spice3.Repository.SpiceConstants.CONSTboltz
      //    *(Spice3.Repository.SpiceConstants.REFTEMP + Spice3.Repository.SpiceConstants.REFTEMP));
        arg := -egfet/(2*Spice3.Repository.SpiceConstants.CONSTboltz*m.m_dTemp) + 1.1150877/(Spice3.Repository.SpiceConstants.CONSTboltz
          *(Spice3.Repository.SpiceConstants.REFTEMP + Spice3.Repository.SpiceConstants.REFTEMP));
        pbfact := -2*vt*(1.5*Modelica.Math.log(fact2) + Spice3.Repository.SpiceConstants.CHARGE
          *arg);

      //  ratlog  := log( GetTemperature() / in_p.m_tnom);
        ratlog  := Modelica.Math.log( m.m_dTemp / in_p.m_tnom);
      //  ratio1  := GetTemperature() / in_p.m_tnom - 1;
        ratio1  := m.m_dTemp / in_p.m_tnom - 1;
      //  factlog  = ratio1 * m_pModel->m_energyGap / vt + m_pModel->m_tempExpIS * ratlog;
        factlog := ratio1 * in_p.m_energyGap / vt + in_p.m_tempExpIS * ratlog;
      //factor  = exp( factlog);
        factor  := exp( factlog);
        bfactor := exp(ratlog * in_p.m_betaExp);

        pbo    := (in_p.m_potentialBE - pbfact) / fact1;
        gmaold := (in_p.m_potentialBE - pbo) / pbo;

      /* m_tSatCur    = m_pModel->m_satCur * factor * m_area;
C++   m_tBetaF     = m_pModel->m_betaF * bfactor;
C++   m_tBetaR     = m_pModel->m_betaR * bfactor;
C++   m_tBEleakCur = m_pModel->m_leakBEcurrent * exp(factlog / m_pModel->m_leakBEemissionCoeff) / bfactor
C++      * m_area;
C++   m_tBCleakCur = m_pModel->m_leakBCcurrent * exp(factlog / m_pModel->m_leakBCemissionCoeff) / bfactor
C++      * m_area;

C++   m_tBEcap = m_pModel->m_depletionCapBE
C++      / (1 + m_pModel->m_junctionExpBE * (4e-4 * (m_pModel->m_tnom - REFTEMP) - gmaold));
C++   m_tBEpot = fact2 * pbo + pbfact;
C++
C++   gmanew = (m_tBEpot - pbo) / pbo;

C++   m_tBEcap *= 1 + m_pModel->m_junctionExpBE * (4e-4 * (GetTemperature() - REFTEMP) - gmanew);

C++   pbo = (m_pModel->m_potentialBC - pbfact) / fact1;
C++   gmaold = (m_pModel->m_potentialBC - pbo) / pbo;

C++   m_tBCcap = m_pModel->m_depletionCapBC
C++      / (1 + m_pModel->m_junctionExpBC * (4e-4 * (m_pModel->m_tnom - REFTEMP) - gmaold));
C++   m_tBCpot = fact2 * pbo + pbfact;

C++   gmanew = (m_tBCpot - pbo) / pbo;

C++   m_tBCcap *= 1 + m_pModel->m_junctionExpBC * (4e-4 * (GetTemperature() - REFTEMP) - gmanew);

C++   m_tDepCapBE = m_pModel->m_depletionCapCoeff * m_tBEpot;
C++   m_tDepCapBC = m_pModel->m_depletionCapCoeff * m_tBCpot;
C++   xfc  = log( 1 - m_pModel->m_depletionCapCoeff);
C++   m_tVcrit = vt * log(vt / (CONSTroot2 * m_pModel->m_satCur));
C++   m_dVt      = vt; */

        out_c.m_tSatCur    := in_p.m_satCur * factor * in_p3.m_area;
        out_c.m_tBetaF     := in_p.m_betaF * bfactor;
        out_c.m_tBetaR     := in_p.m_betaR * bfactor;
        out_c.m_tBEleakCur := in_vl.m_leakBEcurrent * exp(factlog / in_p.m_leakBEemissionCoeff) / bfactor
                              * in_p3.m_area;
        out_c.m_tBCleakCur := in_vl.m_leakBCcurrent * exp(factlog / in_p.m_leakBCemissionCoeff) / bfactor
                              * in_p3.m_area;

        out_c.m_tBEcap := in_p.m_depletionCapBE/(1 + in_p.m_junctionExpBE*(4e-4
          *(in_p.m_tnom - Spice3.Repository.SpiceConstants.REFTEMP) - gmaold));
        out_c.m_tBEpot := fact2 * pbo + pbfact;

        gmanew := (out_c.m_tBEpot - pbo) / pbo;

      //  out_c.m_tBEcap := out_c.m_tBEcap*(1 + in_p.m_junctionExpBE*(4e-4*(
      //    GetTemperature() - Spice3.Repository.SpiceConstants.REFTEMP) - gmanew));
        out_c.m_tBEcap := out_c.m_tBEcap*(1 + in_p.m_junctionExpBE*(4e-4*(m.m_dTemp - Spice3.Repository.SpiceConstants.REFTEMP)
           - gmanew));

        pbo    := (in_p.m_potentialBC - pbfact) / fact1;
        gmaold := (in_p.m_potentialBC - pbo) / pbo;

        out_c.m_tBCcap := in_p.m_depletionCapBC/(1 + in_p.m_junctionExpBC*(4e-4
          *(in_p.m_tnom - Spice3.Repository.SpiceConstants.REFTEMP) - gmaold));
        out_c.m_tBCpot := fact2 * pbo + pbfact;

        gmanew := (out_c.m_tBCpot - pbo) / pbo;

      //  out_c.m_tBCcap := out_c.m_tBCcap*(1 + in_p.m_junctionExpBC*(4e-4*(
      //    GetTemperature() - Spice3.Repository.SpiceConstants.REFTEMP) - gmanew));
        out_c.m_tBCcap := out_c.m_tBCcap*(1 + in_p.m_junctionExpBC*(4e-4*(m.m_dTemp - Spice3.Repository.SpiceConstants.REFTEMP)
           - gmanew));

        out_c.m_tDepCapBE := in_p.m_depletionCapCoeff * out_c.m_tBEpot;
        out_c.m_tDepCapBC := in_p.m_depletionCapCoeff * out_c.m_tBCpot;
        xfc               := Modelica.Math.log( 1 - in_p.m_depletionCapCoeff);
        out_c.m_tVcrit := vt*Modelica.Math.log(vt/(Spice3.Repository.SpiceConstants.CONSTroot2
          *in_p.m_satCur));
        out_c.m_dVt       := vt;

      /* // calculate the parameters that depend on the area factor
C++   m_tBEcap *= m_area;
C++   m_tBCcap *= m_area;
C++   JunctionCapCoeffs(
C++      m_tF1c, m_f2c, m_f3c, m_pModel->m_junctionExpBC,
C++     m_pModel->m_depletionCapCoeff, m_tBCpot);
C++   JunctionCapCoeffs(
C++      m_tF1e, m_f2e, m_f3e, m_pModel->m_junctionExpBE,
C++      m_pModel->m_depletionCapCoeff, m_tBEpot);
C++} */

        // calculate the parameters that depend on the area factor
        out_c.m_tBEcap := out_c.m_tBEcap * in_p3.m_area;
        out_c.m_tBCcap := out_c.m_tBCcap * in_p3.m_area;
        (out_c.m_tF1c,out_c.m_f2c,out_c.m_f3c) :=
          Spice3.Repository.Equation.JunctionCapCoeffs(
                in_p.m_junctionExpBC,
                in_p.m_depletionCapCoeff,
                out_c.m_tBCpot);
        (out_c.m_tF1e,out_c.m_f2e,out_c.m_f3e) :=
          Spice3.Repository.Equation.JunctionCapCoeffs(
                in_p.m_junctionExpBE,
                in_p.m_depletionCapCoeff,
                out_c.m_tBEpot);

      end Bjt3CalcTempDependencies;

      function Bjt3NoBypassCode
      /* void Bjt3::NoBypassCode() */

        input Spice3.Repository.Model.Model in_m;
        input Bjt in_p3;
        input BjtModelLineParams in_p;
        input Bjt3Calc in_c;
        input BjtModelLineVariables in_vl;
        input Real[6] in_m_pVoltageValues; /* 1 Col; 2 Base; 3 Emit; 4 ColP; 5 BaseP; 6 EmitP */
        //input Real[6] in_m_pVoltageValuesDot; /* 1 Col; 2 Base; 3 Emit; 4 ColP; 5 BaseP; 6 EmitP */
        input Boolean in_m_bInit;

        output CurrentsCapacitances out_cc;
        output Real dummy;
        output Real capbe;
        output Real capbc;
        output Real capbx;

      protected
        Real guck;
        Real vce;
        Real vbe;
        Real vbx;
        Real vbc;
        Real gbe;
        Real cbe;
        Real gbc;
        Real cbc;
        Real gben;
        Real cben;
        Real gbcn;
        Real cbcn;
        Real cjbe;
        Real cjbc;
        Real dqbdve;
        Real dqbdvc;
        Real qb;
        Real q1;
        Real q2;
        Real arg;
        Real sqarg;
        Real cc;
        Real cex;
        Real gex;
        Real ttime;
        Real step;
        Real laststep;
        Real bcex0;
        Real bcex1;
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
       // Real capbe;
        Real chargebe;
       // Real capbc;
        Real chargebc;
       // Real capbx;
        Real chargebx;
        Real argtf;
        Real exponent;
        Real temp;

        Real dummy1;
        Real aux1;
        Real aux2;

      algorithm
      /*{double vce = m_pModel->m_type * GetVoltage( ColP, EmitP);
   double vbe = m_pModel->m_type * GetVoltage( BaseP, EmitP);
   double vbx = m_pModel->m_type * GetVoltage( Base, ColP);

   if (UseInitialConditions())
   {
      if (m_bICvbeValue->IsGiven())
         vbe = m_pModel->m_type * m_dICvbe;
      if (m_bICvceValue->IsGiven())
         vce = m_pModel->m_type * m_dICvce;
      vbx = vbe - vce;
   }
   else if (InitJunctionVoltages())
   {
      if (m_bOff)
      {
         vbe = 0.;
         vce = 0.;
         vbx = 0.;
      }
      else
      {
         vbe = m_tVcrit;
         vce = vbe;
         vbx = 0.;
      }
   }

   double vbc = vbe - vce;

   vbe = LimitJunctionVoltage( vbe, m_dVt, m_tVcrit);
   vbc = LimitJunctionVoltage( vbc, m_dVt, m_tVcrit); */

        vce := in_p.m_type * (in_m_pVoltageValues[4] - in_m_pVoltageValues[6]); // ( ColP, EmitP);
        vbe := in_p.m_type * (in_m_pVoltageValues[5] - in_m_pVoltageValues[6]); // ( BaseP, EmitP);
        vbx := in_p.m_type * (in_m_pVoltageValues[2] - in_m_pVoltageValues[4]); // ( Base, ColP);

        if (Spice3.Repository.SpiceRoot.UseInitialConditions()) then
          if (in_p3.m_bICvbeIsGiven > 0.5) then
            vbe := in_p.m_type * in_p3.m_dICvbe;
          end if;
          if (in_p3.m_bICvceIsGiven > 0.5) then
            vce := in_p.m_type * in_p3.m_dICvce;
          end if;
          vbx := vbe - vce;
        elseif (Spice3.Repository.SpiceRoot.InitJunctionVoltages()) then
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

      /* //////////////////////////////////////////////////////////////////////
   // junction current
   double gbe, cbe, gbc, cbc, gben, cben, gbcn, cbcn;
   Junction2(
      cbe, gbe, vbe, m_dTemp, m_pModel->m_emissionCoeffF, m_tSatCur);
   InsertConductance(
      BaseP, EmitP, gbe / m_tBetaF,
      m_pModel->m_type * cbe / m_tBetaF,
      m_pModel->m_type * vbe);
   Junction2(
      cben, gben, vbe, m_dTemp, m_pModel->m_leakBEemissionCoeff, m_tBEleakCur);
   InsertConductance(
      BaseP, EmitP, gben, m_pModel->m_type * cben, m_pModel->m_type * vbe);
   Junction2(
      cbc, gbc, vbc, m_dTemp, m_pModel->m_emissionCoeffR, m_tSatCur);
   InsertConductance(
      BaseP, ColP, gbc / m_tBetaR,
      m_pModel->m_type * cbc / m_tBetaR,
      m_pModel->m_type * vbc);
   Junction2(
      cbcn, gbcn, vbc, m_dTemp, m_pModel->m_leakBCemissionCoeff, m_tBCleakCur);
   InsertConductance(
      BaseP, ColP, gbcn, m_pModel->m_type * cbcn, m_pModel->m_type * vbc);

   double cjbe = cbe / m_tBetaF + cben;
   double cjbc = cbc / m_tBetaR + cbcn; */

        //////////////////////////////////////////////////////////////////////
        // junction current
        (cbe,gbe,dummy1) := Spice3.Repository.Equation.Junction2(
                vbe,
                in_m.m_dTemp,
                in_p.m_emissionCoeffF,
                in_c.m_tSatCur);
        dummy := dummy1;
        out_cc.iBE   := in_p.m_type * cbe / in_c.m_tBetaF;
        (cben,gben,dummy1) := Spice3.Repository.Equation.Junction2(
                vbe,
                in_m.m_dTemp,
                in_p.m_leakBEemissionCoeff,
                in_c.m_tBEleakCur);
        out_cc.iBEN  := in_p.m_type * cben;
        (cbc,gbc,dummy1) := Spice3.Repository.Equation.Junction2(
                vbc,
                in_m.m_dTemp,
                in_p.m_emissionCoeffR,
                in_c.m_tSatCur);
        out_cc.iBC   := in_p.m_type * cbc / in_c.m_tBetaR;
        (cbcn,gbcn,dummy1) := Spice3.Repository.Equation.Junction2(
                vbc,
                in_m.m_dTemp,
                in_p.m_leakBCemissionCoeff,
                in_c.m_tBCleakCur);
        out_cc.iBCN  := in_p.m_type * cbcn;
        cjbe         := cbe / in_c.m_tBetaF + cben;
        cjbc         := cbc / in_c.m_tBetaR + cbcn;

      /* //////////////////////////////////////////////////////////////////////
   // determine base charge terms
   double dqbdve, dqbdvc, qb;
   double q1 = 1. /
      (1. - m_pModel->m_invEarlyVoltF * vbc - m_pModel->m_invEarlyVoltR * vbe);
   if (m_invRollOffF == 0 && m_invRollOffR == 0) {
      qb = q1;
      dqbdve = q1*qb*m_pModel->m_invEarlyVoltR;
      dqbdvc = q1*qb*m_pModel->m_invEarlyVoltF;
   } else {
      double q2=m_invRollOffF*cbe+m_invRollOffR*cbc;
      double arg=F_Max( 0., 1+4*q2);
      double sqarg=1;
      if(arg != 0)
         sqarg=sqrt(arg);
      qb=q1*(1+sqarg)/2;
      dqbdve=q1*(qb*m_pModel->m_invEarlyVoltR+m_invRollOffF*gbe/sqarg);
      dqbdvc=q1*(qb*m_pModel->m_invEarlyVoltF+m_invRollOffR*gbc/sqarg);
   } */

        //////////////////////////////////////////////////////////////////////
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

      /* //////////////////////////////////////////////////////////////////////
   // determine dc incremental conductances - Weil's approximation
   double cc = 0., cex = cbe, gex = gbe;
   double time = GetTime();
   if ((m_pModel->m_excessPhaseFactor != 0) && (time > 0.0))
   {
      double step     = GetHistoryTimeStep( 0);
      double laststep = GetHistoryTimeStep( 1);
      double bcex0    = GetHistoryValue( 0, 1);
      double bcex1    = GetHistoryValue( 0, 2);
      if( bcex1 == 0.0)
      {
         bcex0 = bcex1 = cbe / qb;
         SetHistoryValue( 0, bcex0);
      }
      double arg1  = step / m_pModel->m_excessPhaseFactor;
      double arg2  = 3 * arg1;
      arg1  = arg2 * arg1;
      double denom = 1 + arg1 + arg2;
      double arg3  = arg1 / denom;
      cc = (bcex0 * (1 + step / laststep + arg2) - bcex1 * step / laststep)
         / denom;
      cex = cbe * arg3;
      gex = gbe * arg3;
      SetHistoryValue( 0, cc + cex / qb);
   }
   cc=cc+(cex-cbc)/qb; */

        //////////////////////////////////////////////////////////////////////
        // determine dc incremental conductances - Weil's approximation
        cc    := 0.0;
        cex   := cbe;
        gex   := gbe;
        ttime := 1;// GetTime();
        if ((in_vl.m_excessPhaseFactor <> 0) and (ttime > 0.0)) then
          step     :=0;// GetHistoryTimeStep( 0);
          laststep :=1;// GetHistoryTimeStep( 1);
          bcex0    :=0;// GetHistoryValue( 0, 1);
          bcex1    :=0;// GetHistoryValue( 0, 2);
          if ( bcex1 == 0.0) then
               bcex1 := cbe / qb;
               bcex0 := bcex1;
      //         SetHistoryValue( 0, bcex0);
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
      //    SetHistoryValue( 0, cc + cex / qb);
        end if;
        cc := cc+(cex-cbc)/qb;

      /* //////////////////////////////////////////////////////////////////////
   // resistances
   InternConductance( Col,   ColP, m_pModel->m_collectorConduct * m_area);
   InternConductance( Emit, EmitP, m_pModel->m_emitterConduct * m_area);

   double rbpr = m_pModel->m_minBaseResist / m_area;
   double rbpi = m_pModel->m_baseResist / m_area-rbpr;
   double gx = rbpr + rbpi / qb;
   double xjrb = m_pModel->m_baseCurrentHalfResist * m_area;
   if (xjrb != 0)
   {
      double arg1 = F_Max ((cjbe + cjbc) / xjrb, 1e-9);
      double arg2 = (-1 + sqrt (1 + 14.59025 * arg1)) / 2.4317 / sqrt (arg1);
      arg1 = tan(arg2);
      gx   = rbpr + 3 * rbpi * (arg1-arg2) / arg2 / arg1 / arg1;
   }
   if (gx != 0)
      gx = 1 / gx;
   InternConductance( Base, BaseP, gx); */

        //////////////////////////////////////////////////////////////////////
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

      /* //////////////////////////////////////////////////////////////////////
   // determine dc incremental conductances
   double go = (gbc+(cex-cbc)*dqbdvc/qb)/qb;
   double gm = (gex-(cex-cbc)*dqbdve/qb)/qb-go;
   InsertNonChargeCurrent(
      ColP, EmitP, m_pModel->m_type * cc,
      BaseP, ColP, -go, m_pModel->m_type * vbc,
      BaseP, EmitP, gm+go, m_pModel->m_type * vbe); */

        //////////////////////////////////////////////////////////////////////
        // determine dc incremental conductances
        go := (gbc+(cex-cbc)*dqbdvc/qb)/qb;
        gm := (gex-(cex-cbc)*dqbdve/qb)/qb-go;
        out_cc.iCC := in_p.m_type * cc;

      /* //////////////////////////////////////////////////////////////////////
   // charge storage elements and transit time calculation
   double captt = 0.0, capbe, chargebe, capbc, chargebc, capbx, chargebx;
   if (m_pModel->m_transitTimeF != 0.0 && vbe > 0.0)
   {
      double argtf = 0.0;
      double arg2  = 0.0;
      double arg3  = 0.0;
      if (m_pModel->m_transitTimeBiasCoeffF != 0.0)
      {
         argtf = m_pModel->m_transitTimeBiasCoeffF;
         if (m_pModel->m_transitTimeVBCFactor != 0.0)
                 {
                        double exponent = F_Min( 50., vbc * m_pModel->m_transitTimeVBCFactor);
            argtf = argtf * exp( exponent);
                 }
         arg2 = argtf;
         if(m_transitTimeHighCurrentF != 0)
         {
            double temp = cbe / (cbe + m_transitTimeHighCurrentF);
            argtf = argtf * temp * temp;
            arg2 = argtf * (3-temp-temp);
         }
         arg3 = cbe * argtf * m_pModel->m_transitTimeVBCFactor;
      }
      cbe   = cbe * (1 + argtf) / qb;
      gbe   = (gbe * (1 + arg2) - cbe * dqbdve) / qb;
      captt = m_pModel->m_transitTimeF * (arg3 - cbe * dqbdvc) / qb;
   }
   JunctionCapTransTime(
      capbe, chargebe, m_tBEcap, vbe, m_tDepCapBE,
      m_pModel->m_junctionExpBE, m_tBEpot, m_tF1e, m_f2e, m_f3e,
      m_pModel->m_transitTimeF, gbe, cbe);
   InsertChargeCurrent(
      BaseP, EmitP, m_pModel->m_type * chargebe,
      BaseP, EmitP, capbe, m_pModel->m_type * vbe,
      BaseP, ColP, captt, m_pModel->m_type * vbc);

   JunctionCapTransTime(
      capbc, chargebc, m_tBCcap * m_pModel->m_baseFractionBCcap,
      vbc, m_tDepCapBC,
      m_pModel->m_junctionExpBC, m_tBCpot, m_tF1c, m_f2c, m_f3c,
      m_pModel->m_transitTimeR, gbc, cbc);
   InsertCapacitance(
      BaseP, ColP, capbc, m_pModel->m_type * chargebc, m_pModel->m_type * vbc);
   JunctionCap(
      capbx, chargebx, m_tBCcap * (1. - m_pModel->m_baseFractionBCcap),
      vbx, m_tDepCapBC,
      m_pModel->m_junctionExpBC, m_tBCpot, m_tF1c, m_f2c, m_f3c);
   InsertCapacitance(
      Base, ColP, capbx, m_pModel->m_type * chargebx, m_pModel->m_type * vbx);
} */

        //////////////////////////////////////////////////////////////////////
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
        (capbe,chargebe) := Spice3.Repository.Equation.JunctionCapTransTime(
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
      //  out_cc.capbe := if (in_m_bInit) then 0.0 else capbe*(in_m_pVoltageValuesDot[5]-in_m_pVoltageValuesDot[6]);
        out_cc.iXX        := 0; // ? in_p.m_type * chargebe
        aux1 := in_c.m_tBCcap*in_p.m_baseFractionBCcap;
        (capbc,chargebc) := Spice3.Repository.Equation.JunctionCapTransTime(
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
        //out_cc.capbc      := if (in_m_bInit) then 0.0 else capbc*(in_m_pVoltageValuesDot[5]-in_m_pVoltageValuesDot[4]);
        aux2:= in_c.m_tBCcap*(1. - in_p.m_baseFractionBCcap);
        (capbx,chargebx) := Spice3.Repository.Equation.JunctionCap(
                aux2,
                vbx,
                in_c.m_tDepCapBC,
                in_p.m_junctionExpBC,
                in_c.m_tBCpot,
                in_c.m_tF1c,
                in_c.m_f2c,
                in_c.m_f3c);
       // out_cc.capbx      := if (in_m_bInit) then 0.0 else capbx*(in_m_pVoltageValuesDot[2]-in_m_pVoltageValuesDot[4]);

      end Bjt3NoBypassCode;

      record Bjt
        extends Bjt3;
      end Bjt;

      record BjtVariables
        extends Bjt3Variables;

        Real m_CScap;

      end BjtVariables;

      function BjtInitEquations
      /* void Bjt::InitEquations() */

        input Bjt in_p;
        input BjtModelLineParams in_pml;
        input BjtModelLineVariables in_vl;
        output BjtVariables out_v;

      protected
        Bjt3Variables v3;

      algorithm
      /*{Bjt3::InitEquations();
   // calculate the parameters that depend on the area factor
   m_CScap = m_pModel->m_capCS * m_area;
} */

        v3 := Bjt3InitEquations(in_p, in_pml, in_vl);
        // calculate the parameters that depend on the area factor
        out_v.m_CScap := in_pml.m_capCS * in_p.m_area;

      end BjtInitEquations;

      function BjtNoBypassCode
      /* void Bjt::NoBypassCode() */

        input Spice3.Repository.Model.Model in_m;
        input Bjt3 in_p3;
        input BjtModelLineParams in_p;
        input Bjt3Calc in_c;
        input BjtVariables in_v;
        input BjtModelLineVariables in_vl;
        input Real[6] in_m_pVoltageValues; /* 1 Col; 2 Base; 3 Emit; 4 Subst; 5 ColP; 6 BaseP; 7 EmitP */
        //input Real[6] in_m_pVoltageValuesDot; /* 1 Col; 2 Base; 3 Emit; 4 Subst; 5 ColP; 6 BaseP; 7 EmitP */

        input Boolean in_m_bInit;

        output CurrentsCapacitances out_cc;
        output Real dummy;
        output Real capbe;
        output Real capbc;
        output Real capbx;
      protected
        Real[6] bjt3_VoltageValues; /* 1 Col; 2 Base; 3 Emit; 4 ColP; 5 BaseP; 6 EmitP */
        //Real[6] bjt3_VoltageValuesDot; /* 1 Col; 2 Base; 3 Emit; 4 ColP; 5 BaseP; 6 EmitP */
        Integer i;
        Real capcs;
        Real chargecs;
        Real vcs;
        Real arg;
        Real sarg;

      algorithm
        // Bjt3 hat nur 6 Anschlüsse, deshalb neuer Vektor VoltageValues
        for i in 1:3 loop
          bjt3_VoltageValues[i] := in_m_pVoltageValues[i];
        end for;
        for i in 4:6 loop
          bjt3_VoltageValues[i] := in_m_pVoltageValues[i];      //muss eigentlich sein: bjt3_VoltageValues[i] := in_m_pVoltageValues[i+1]; wegen "S" Anschluss
        end for;

      //   for i in 1:6 loop
      //     bjt3_VoltageValuesDot[i] := in_m_pVoltageValuesDot[i];
      //   end for;
      /*{Bjt3::NoBypassCode();
   double capcs = 0, chargecs = 0;
   double vcs = m_pModel->m_type * GetVoltage( Subst,  ColP);
   if (vcs < 0)
   {
      double arg  = 1 - vcs / m_pModel->m_potentialSubstrate;
      double sarg = exp( -m_pModel->m_exponentialSubstrate * log( arg));
      capcs    = m_CScap * sarg;
      chargecs = m_pModel->m_potentialSubstrate * m_CScap *
         (1-arg*sarg)/(1-m_pModel->m_exponentialSubstrate);
   }
   else
   {
      capcs = m_CScap *
         (1 + m_pModel->m_exponentialSubstrate * vcs / m_pModel->m_potentialSubstrate);
      chargecs = vcs * m_CScap *(1+m_pModel->m_exponentialSubstrate*vcs/
                                 (2*m_pModel->m_potentialSubstrate));
   }
   InsertCapacitance(
      Subst,  ColP, capcs, m_pModel->m_type * chargecs, m_pModel->m_type * vcs);
} */

        (out_cc, dummy, capbe, capbc, capbx)   := Bjt3NoBypassCode(in_m, in_p3, in_p, in_c, in_vl, bjt3_VoltageValues,
                     in_m_bInit);//bjt3_VoltageValuesDot
        capcs    := 0;
        chargecs := 0;
        vcs      := in_p.m_type * (0- in_m_pVoltageValues[4]); // ( Subst,  ColP);  -->eigentlich: vcs      := in_p.m_type * (in_m_pVoltageValues[4] - in_m_pVoltageValues[5]);
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
       // out_cc.capcs :=  if (in_m_bInit) then 0.0 else capcs*(0-in_m_pVoltageValuesDot[4]);  //-->eigentlich (in_m_pVoltageValuesDot[4]-in_m_pVoltageValuesDot[5])

      end BjtNoBypassCode;

      function BjtRenameParameters
        input Spice3.Repository.modelcardBJT ex;
        input Spice3.Repository.SpiceConstants con;

        output Spice3.Repository.Bjt3.BjtModelLineParams intern;
      algorithm

        intern.m_type := ex.TBJT;
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
        intern.m_tnom := if (ex.TNOM > -1e40) then ex.TNOM + SpiceRoot.SPICEcircuitCONST.CONSTCtoK else 300.15;
      end BjtRenameParameters;

      function BjtRenameParameters_dev
       input Real AREA;
       input Boolean OFF;
       input Real IC_VBE;
       input Real IC_VCE;
       input Boolean SENS_AREA;
      // input Real TEMP;

       output Bjt3 dev;
      // output Model.Model m;
      algorithm

       // parameter Real m_area(  start = 1.0);           // "AREA"
      // parameter Boolean m_bOff(  start = false);      // "OFF"
      // parameter Real m_dICvbe( start = 0.0);         // "IC_VBE"
      // parameter Real m_bICvbeIsGiven( start = 0.0);  // Startwert wie m_dICvbe
      // parameter Real m_dICvce( start = 0.0);         // "IC_VCE"
      // parameter Real m_bICvceIsGiven( start = 0.0);  // Startwert wie m_dICvce
      // parameter Boolean m_bSensArea( start = false);  // "SENS_AREA"

        dev.m_area := AREA;
        dev.m_bOff := OFF;

        dev.m_bICvbeIsGiven := if (IC_VBE > -1e40) then 1 else 0;
        dev.m_dICvbe := if (IC_VBE > -1e40) then IC_VBE else 0;

        dev.m_bICvceIsGiven := if (IC_VCE > -1e40) then 1 else 0;
        dev.m_dICvce := if (IC_VCE > -1e40) then IC_VCE else 0;

        dev.m_bSensArea := SENS_AREA;
       // m.m_dTemp :=TEMP + SpiceRoot.SPICEcircuitCONST.CONSTCtoK;

      end BjtRenameParameters_dev;

      function BjtRenameParameters_dev_Temp
       input Real TEMP;

      // output Bjt3 dev;
      output Model.Model m;
      algorithm

       m.m_dTemp :=TEMP + SpiceRoot.SPICEcircuitCONST.CONSTCtoK;

      end BjtRenameParameters_dev_Temp;
    end Bjt3;
    annotation (Documentation(info="<html>
<p>This package contains all function, parameters and data of semiconductor models, that are transformed from SPICE3 into Modelica. The models of the package semiconductors access to repository models. This package should not be used via direct access by a user of the Spice-Library for Modelica. It is restricted to the development. </p>
</html>"));
  end Repository;

annotation(preferedView="info", Window(
    x=0.05,
    y=0.06,
    width=0.16,
    height=0.58,
    library=1,
    autolayout=1),
  Documentation(info="<html>
<p>This package contains models of the Berkeley SPICE3 simulator (R, C, L, controlled and independent sources, semiconductor device models). The semiconductor models are transferred from the SPICE3 code, up to now </p>
<p><ul>
<li>MOSFET Level 1 </li>
<li>Bipolar junction transistor, </li>
<li>Diode </li>
<li>Semiconductor resistor</li>
</ul></p>
<p><br/>For the usage of this package, especially for detailed explanation of parameters, it is useful to know the <a href=\"http://bear.cwru.edu/eecs_cad/man_spice3.pdf\">SPICE3 users manual</a> which modelling relied on.</p>
<p><br/><b>Open issues</b>:</p>
<p><ul>
<li>devices from SPICE3 that are not modelled yet: </li>
<li><ul>
<li>MESFETs </li>
<li>JFETs </li>
<li>MOSFET Level 2,3,6, BSIM </li>
<li>Line models </li>
<li>Semiconductor C </li>
</ul></li>
<li>unit check (at the moment many parameters of type Real) </li>
<li>tests</li>
<li>not supported analyse types (AC, DCTransfer, ...)</li>
</ul></p>
<p><br/><br/><b>Copyright:</b> </p>
<p><br/><br/>Copyright &copy; 1998-2010, Modelica Association and Fraunhofer-Gesellschaft.</p>
<p><i>The Modelica package is </i><i><b>free</b></i><i> software; it can be redistributed and/or modified </i></p>
<p>under the terms of the <i><b>Modelica license</b></i><i>, see the license conditions and the </i></p>
<p><br/>accompanying <i><b>disclaimer</b></i><i> in the documentation of package Modelica in file &QUOT;Modelica/package.mo&QUOT;.</i></p>
</html>",
   revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> September 2009 </i>
       by Kristin Majetta <br>Bipolar transistor implemented</li>
<li><i> August 2009 </i>
       by Jonathan Kress <br>default values in sources improved</li>
<li><i> August 2009 </i>
       by Kristin Majetta <br>Bipolar transistor started</li>
<li><i> April 2009 </i>
       by Kristin Majetta <br>Semiconductor Resistor implemented</li>
<li><i> March 2009 </i>
       by Kristin Majetta <br>DIODE implemented</li>
<li><i> 25th February 2009 </i>
       by Kristin Majetta <br>MOS Level 2 implemented</li>
<li><i> 15th October 2008 </i>
       by Kristin Majetta <br>minor errors fixed in L_Inductor, I_Pulse and SpiceRoot</li>
<li><i> April, 2008   </i>
       by Sandra Boehme <br> initially implemented<br>
       </li>
</ul>
</html>"),
    uses(Modelica(version="3.1")),
    version="1");
end Spice3;
