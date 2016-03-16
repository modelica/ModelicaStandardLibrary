within Modelica.Magnetic.QuasiStatic;
package FundamentalWave "Quasi static fundamental wave electric machines"
  extends Modelica.Icons.Package;
  package UsersGuide "User's Guide"
    extends Modelica.Icons.Information;
    class Concept "Fundamental wave concept"
      extends Modelica.Icons.Information;
      annotation (Documentation(info="<html>
<h5>Reference frames</h5>

<p>Quasi static magnetic ports contain the complex magnetic flux (flow variable) and the complex magnetic potential difference (potential variable) and a reference angle. The relationship between the different complex phasors with respect to different references will be explained by means of the complex magnetic flux. The same transformation relationships also apply to the complex magnetic potential difference. However, the discussed relationships are important for handling connectors in the air gap model, transform equations into the rotor fixed reference frame, etc. </p>

<p>
Let us assume that the air gap model contains stator and rotor magnetic ports which relate to the different sides of the machine. The angle relationship between these ports is
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_relationship.png\"/>,
</p>

<p>where
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_s.png\"/>
is the connector reference angle of the stator ports,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_r.png\"/>
is the connector reference angle of the rotor ports, and
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_mechanical.png\"/>
is the difference of the mechanical angles of the flange and the support, respectively,
multiplied by the number of pole pairs,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/p.png\"/>.
The stator and rotor reference angles are directly related with the electrical frequencies of the
electric circuits of the stator,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/f_s.png\"/>,
and rotor,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/f_r.png\"/>,
respectively, by means of:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_f.png\"/>
</p>

<p>
This is a strict consequence of the electro magnetic coupling between the quasi static electric and the quasi static magnetic domain.</p>


<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><b>Fig. 1:</b> Reference frames of the quasi static fundamental wave library</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/ReferenceFrames.png\"/>
    </td>
  </tr>
</table>

<p>
The complex magnetic flux with respect a stator and rotor magnetic port are equal,
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Phi(ref)=Phi,re+jPhi,im.png\"/>,
</p>

<p>
but the reference phase angles are different according to the relationship explained above. The stator and rotor reference angles refer to quasi static magnetic connectors. The complex magnetic flux of the (stator) port with respect to the <b>stator fixed</b> reference frame is then calculated by</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Phi_s_ref.png\"/>.
</p>

<p>
The complex magnetic flux of the (rotor) magnetic port with respect to the <b>rotor fixed</b> reference frame is then calculated by</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Phi_r_ref.png\"/>.
</p>

<p>
The two stator and rotor fixed complex fluxes are related by</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Phi_r_s.png\"/>.
</p>

</html>"));
    end Concept;

    class Contact "Contact"
      extends Modelica.Icons.Contact;
      annotation (Documentation(info="<html>
<h4>Contact</h4>

<p>
  Dr. Christian Kral<br>
  <a href=\"http://christiankral.net/\">Electric Machines, Drives and Systems</a><br>
  A-1060 Vienna, Austria<br>
  email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a>
</p>

<p>
Anton Haumer<br>
<a href=\"http://www.haumer.at\">Technical Consulting &amp; Electrical Engineering</a><br>
3423 St. Andrae-Woerdern, Austria<br>
email: <a HREF=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a><br>
</p>

</html>"));
    end Contact;

    class ReleaseNotes "Release Notes"
      extends Modelica.Icons.ReleaseNotes;
      annotation (Documentation(info="<html>

<h5>Version 3.2.2, 2015-02-02</h5>
<ul>
<li>Restructuring of components in Interfaces and BasesClasses</li>
<li>Migration of library to MSL trunk</li>
<li>Update and improvement of documentation</li>
<li>Added new component:</li>
<ul>
    <li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Permeance\">Permeance</a></li>
</ul>
<li>Removed parameter text from icon layer for reluctance and permeance model</li>
<li>Fixed issues of ticket #1524</li>
<li>Restructured cage models with reluctance instead of inductance model according to ticket #1537</li>
<li>Bug fixes according to #1226</li>
<li>Added magnitude and argument of complex magnetic potentials, magnetic fluxes, voltages and currents in interface, electromagnetic coupling and machine models, see #1405</li>
<li>Added active, reactive and apparent power and power factor in interface and machine models, see #1405</li>
<li>Added new interface model
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.PartialTwoPortExtended\">PartialTwoPortExtended</a>
to simplify consistent inclusion of variables, see #1405</li>
<li>Changed icon and location of terminal box according to #1706</li>
</ul>

<h5>Version 0.4.1, 2013-12-18</h5>
<ul>
<li>Renamed base magnetic port to MagneticPort</li>
<li>Bug fix of single to multi phase converter</li>
<li>Bug fix of phase number propagation in SaliencyCageWinding fixed</li>
<li>Improved documentation of library</li>
<li>Added current controlled SMR example and indicated SMR inverter example as obsolete</li>
<li>Improved example of mains supplied SMPM with damper cage</li>
</ul>

<h5>Version 0.4.0, 2013-11-13</h5>
<ul>
<li>Renamed all machine class names according to #1348<li>
</ul>

<h5>Version 0.3.0, 2013-11-07</h5>
<ul>
<li>Renamed the library from QuasiStationaryFundamantalWave to QuasiStaticFundamantalWave according to #1344<li>
</ul>

<h5>Version 0.2.5, 2013-11-06</h5>
<ul>
<li>Changed implementation of symmetrical components: symmetricTransformationMatrix(m) is now
    multiplied by numberOfSymmetricBaseSystems(m) in order to overcome differences in calculation
    of current and voltage symmetrical components. The symmetrical components of a system of
    even phase numbers are now equal to the symmetrical components of one corresponding base system.
<li>Improved examples package and removed SMPM_Inverter example<li>
</ul>

<h5>Version 0.2.4, 2013-10-02</h5>
<ul>
<li>Implemented induction machine with squirrel cage example with inverter</li>
<li>Alternative implementation of transformation matrix for faster compilation in Dymola</li>
</ul>

<h5>Version 0.2.3, 2013-09-25</h5>
<ul>
<li>Adapted sine / cosine of QS V/f-converter to match transient behavior</li>
</ul>

<h5>Version 0.2.2, 2013-09-24</h5>
<ul>
<li>Fixed initialization of examples (changed implementation of QuasiStationary.Sources, added start values for gamma, gammas, gammar)</li>
</ul>

<h5>Version 0.2.1, 2013-09-23</h5>
<ul>
<li>Implemented permanent magnet synchronous machine example with inverter</li>
</ul>

<h5>Version 0.2.0, 2013-09-01</h5>
<ul>
<li>Implemented induction machine with slip ring rotor including example</li>
<li>Implemented magnetic crossing </li>
</ul>

<h5>Version 0.1.0, 2013-08-27</h5>
<ul>
<li>Documentation of <a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.UsersGuide.Concept\">phasor concept</a></li>
<li>Connections.branch between electric and magnetic quasi static connectors to handle open circuit and motor operation of machines</li>
<li>Saliency effects are properly considered</li>
<li>Electromagnetic coupling with Analog domain is implemented fully quasi static with v = 0 at the electric connectors -- this may have to be changed in the future</li>
<li>Implemented machine types</li>
<li><ul>
<li>Induction machine with squirrel cage </li>
<li>Permanent magnet synchronous machine with optional damper cage </li>
<li>Electrical excited synchronous machine with optional damper cage (may be removed in first release) </li>
<li>Synchronous reluctance machine with optional damper cage (may be removed in first release) </li>
</ul></li>
</ul>
</html>"));
    end ReleaseNotes;

    class References "References"
      extends Modelica.Icons.References;
      annotation (Documentation(info="<html>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <td valign=\"top\">[Lang1984]</td>
      <td valign=\"top\">W. Lang,
        &quot;&Uuml;ber die Bemessung verlustarmer Asynchronmotoren mit K&auml;figl&auml;ufer f&uuml;r
        Pulsumrichterspeisung,&quot;
        Doctoral Thesis,
        Technical University of Vienna, 1984.</td>
    </tr>
</table>
</html>"));
    end References;
    annotation (Documentation(info="<html>
<p>
This is the library of quasi static fundamental wave models for multi phase electric machines. This is complementary library with the transient machine models of
<a href=\"modelica://Modelica.Magnetic.FundamentalWave\">FundamentalWave</a>.
</p>
</html>"));
  end UsersGuide;

  package Examples "Examples"
    extends Modelica.Icons.ExamplesPackage;
    package Components
      "Examples for testing quasi static fundamental wave components"
      extends Modelica.Icons.ExamplesPackage;
      model MultiPhaseInductance "Multi phase inductance"
        extends Modelica.Icons.Example;
        parameter Integer m=5 "Number of phases";
        parameter Modelica.SIunits.Frequency f=1 "Supply frequency";
        parameter Modelica.SIunits.Voltage VRMS=100 "RMS supply voltage";
        parameter Modelica.SIunits.Resistance R=1E-5 "Resistance";
        parameter Modelica.SIunits.Inductance L=1 "Load inductance";
        parameter Real effectiveTurns=5 "Effective number of turns";
        // Symmetrical multi phase magnetic reluctance
        final parameter Modelica.SIunits.Reluctance R_m=m*effectiveTurns^2/2/L
          "Equivalent magnetic reluctance";
        output Modelica.SIunits.ComplexCurrent Ie=resistor_e.i[1]
          "Current of electric representation";
        output Modelica.SIunits.ComplexCurrent Im=resistor_m.i[1]
          "Current of magnetic representation";
        Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground_e
          annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
        Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground_m
          annotation (Placement(transformation(extent={{-70,-90},{-50,-70}})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star_e(m=m)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-60,40})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star_m(m=m)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-60,-60})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource
          voltageSource_e(
          m=m,
          f=f,
          phi=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m),
          V=fill(VRMS, m),
          gamma(fixed=true, start=0))
                           annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-60,70})));

        Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource
          voltageSource_m(
          m=m,
          f=f,
          phi=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m),
          V=fill(VRMS, m),
          gamma(fixed=true, start=0))
                           annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-60,-30})));

        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor
          resistor_e(m=m, R_ref=fill(R*m/3, m))
          annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor
          resistor_m(m=m, R_ref=fill(R*m/3, m))
          annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor
          inductor_e(m=m, L=fill(L, m)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={0,70})));
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter
          converter_m(m=m, effectiveTurns=effectiveTurns)
          annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Reluctance
          reluctance_m(R_m(d=R_m, q=R_m)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={60,-30})));
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Ground
          groundM_m
          annotation (Placement(transformation(extent={{10,-90},{30,-70}})));
      equation
        connect(star_e.pin_n, ground_e.pin) annotation (Line(
            points={{-60,30},{-60,30}},
            color={85,170,255}));
        connect(star_e.plug_p, voltageSource_e.plug_n) annotation (Line(
            points={{-60,50},{-60,60}},
            color={85,170,255}));
        connect(voltageSource_e.plug_n, inductor_e.plug_n) annotation (Line(
            points={{-60,60},{0,60}},
            color={85,170,255}));
        connect(converter_m.port_p, reluctance_m.port_p) annotation (Line(
            points={{20,-20},{60,-20}},
            color={255,170,85}));
        connect(converter_m.port_n, reluctance_m.port_n) annotation (Line(
            points={{20,-40},{60,-40}},
            color={255,170,85}));
        connect(converter_m.port_n, groundM_m.port_p) annotation (Line(
            points={{20,-40},{20,-70}},
            color={255,170,85}));
        connect(voltageSource_m.plug_n, star_m.plug_p) annotation (Line(
            points={{-60,-40},{-60,-50}},
            color={85,170,255}));
        connect(star_m.pin_n, ground_m.pin) annotation (Line(
            points={{-60,-70},{-60,-70}},
            color={85,170,255}));
        connect(voltageSource_m.plug_n, converter_m.plug_n) annotation (Line(
            points={{-60,-40},{0,-40}},
            color={85,170,255}));
        connect(voltageSource_e.plug_p, resistor_e.plug_p) annotation (Line(
            points={{-60,80},{-40,80}},
            color={85,170,255}));
        connect(resistor_e.plug_n, inductor_e.plug_p) annotation (Line(
            points={{-20,80},{0,80}},
            color={85,170,255}));
        connect(voltageSource_m.plug_p, resistor_m.plug_p) annotation (Line(
            points={{-60,-20},{-40,-20}},
            color={85,170,255}));
        connect(resistor_m.plug_n, converter_m.plug_p) annotation (Line(
            points={{-20,-20},{0,-20}},
            color={85,170,255}));
        annotation ( experiment(StopTime=100,
              Interval=0.01));
      end MultiPhaseInductance;

      model EddyCurrentLosses
        "Comparison of equivalent circuits of eddy current loss models"
        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        // ## Original value R = 0.1 Ohm
        parameter Modelica.SIunits.Resistance R=0.1 "Resistance";
        parameter Modelica.SIunits.Conductance Gc=0.0001 "Loss conductance";
        parameter Modelica.SIunits.Reluctance R_m=1
          "Reluctance of the magnetic circuit";
        parameter Real N=1 "Number of turns";
        output Modelica.SIunits.Power lossPower_e=sum(loss_e.conductor.LossPower);
        output Modelica.SIunits.Power lossPower_m=loss_m.lossPower;
        Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground_e
          annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
        Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground_m
          annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star_e(m=m)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-80,30})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star_m(m=m)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-80,-60})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource
          sineVoltage_e(
          m=m,
          f=1,
          phi=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m),
          V=fill(1/sqrt(2), m),
          gamma(fixed=true, start=0))
                                annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-80,60})));

        Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource
          sineVoltage_m(
          m=m,
          f=1,
          phi=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m),
          V=fill(1/sqrt(2), m),
          gamma(fixed=true, start=0))
                                annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-80,-30})));

        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor
          resistor_e(m=m, R_ref=fill(R*m/3, m)) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              origin={-60,70})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor
          resistor_m(m=m, R_ref=fill(R*m/3, m)) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              origin={-60,-20})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor
          powerb_e(m=m)
          annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor
          powerb_m(m=m)
          annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor loss_e(m=
             m,G_ref=fill(Gc*3/m, m)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={0,60})));
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter
          converter_e(effectiveTurns=N)
          annotation (Placement(transformation(extent={{20,50},{40,70}})));
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter
          converter_m(effectiveTurns=N)
          annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.EddyCurrent
          loss_m(G=m*N^2*Gc/2) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={60,-20})));
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Reluctance
          reluctance_e(R_m(d=R_m, q=R_m)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={80,60})));
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Reluctance
          reluctance_m(R_m(d=R_m, q=R_m)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={80,-30})));
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Ground
          mground_e
          annotation (Placement(transformation(extent={{30,0},{50,20}})));
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Ground
          mground_m
          annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
      equation
        connect(sineVoltage_e.plug_n, converter_e.plug_n) annotation (Line(
            points={{-80,50},{20,50}},
            color={85,170,255}));
        connect(sineVoltage_e.plug_n, star_e.plug_p) annotation (Line(
            points={{-80,50},{-80,40}},
            color={85,170,255}));
        connect(converter_e.port_p, reluctance_e.port_p) annotation (Line(
            points={{40,70},{80,70}},
            color={255,170,85}));
        connect(converter_e.port_n, reluctance_e.port_n) annotation (Line(
            points={{40,50},{80,50}},
            color={255,170,85}));
        connect(converter_e.port_n, mground_e.port_p) annotation (Line(
            points={{40,50},{40,20}},
            color={255,170,85}));
        connect(resistor_e.plug_p, sineVoltage_e.plug_p) annotation (Line(
            points={{-70,70},{-80,70}},
            color={85,170,255}));
        connect(loss_e.plug_n, sineVoltage_e.plug_n) annotation (Line(
            points={{0,50},{-80,50}},
            color={85,170,255}));
        connect(loss_e.plug_p, converter_e.plug_p) annotation (Line(
            points={{0,70},{20,70}},
            color={85,170,255}));
        connect(resistor_e.plug_n, powerb_e.currentP) annotation (Line(
            points={{-50,70},{-40,70}},
            color={85,170,255}));
        connect(powerb_e.currentN, converter_e.plug_p) annotation (Line(
            points={{-20,70},{20,70}},
            color={85,170,255}));
        connect(star_e.pin_n, ground_e.pin) annotation (Line(
            points={{-80,20},{-80,20}},
            color={85,170,255}));
        connect(powerb_e.currentP, powerb_e.voltageP) annotation (Line(
            points={{-40,70},{-40,80},{-30,80}},
            color={85,170,255}));
        connect(powerb_e.voltageN, sineVoltage_e.plug_n) annotation (Line(
            points={{-30,60},{-30,50},{-80,50}},
            color={85,170,255}));
        connect(sineVoltage_m.plug_n, star_m.plug_p) annotation (Line(
            points={{-80,-40},{-80,-50}},
            color={85,170,255}));
        connect(sineVoltage_m.plug_n, converter_m.plug_n) annotation (Line(
            points={{-80,-40},{20,-40}},
            color={85,170,255}));
        connect(converter_m.port_n, reluctance_m.port_n) annotation (Line(
            points={{40,-40},{80,-40}},
            color={255,170,85}));
        connect(converter_m.port_p, loss_m.port_p) annotation (Line(
            points={{40,-20},{50,-20}},
            color={255,170,85}));
        connect(loss_m.port_n, reluctance_m.port_p) annotation (Line(
            points={{70,-20},{80,-20}},
            color={255,170,85}));
        connect(converter_m.port_n, mground_m.port_p) annotation (Line(
            points={{40,-40},{40,-70}},
            color={255,170,85}));
        connect(sineVoltage_m.plug_p, resistor_m.plug_p) annotation (Line(
            points={{-80,-20},{-70,-20}},
            color={85,170,255}));
        connect(resistor_m.plug_n, powerb_m.currentP) annotation (Line(
            points={{-50,-20},{-40,-20}},
            color={85,170,255}));
        connect(powerb_m.currentN, converter_m.plug_p) annotation (Line(
            points={{-20,-20},{20,-20}},
            color={85,170,255}));
        connect(star_m.pin_n, ground_m.pin) annotation (Line(
            points={{-80,-70},{-80,-70}},
            color={85,170,255}));
        connect(powerb_m.currentP, powerb_m.voltageP) annotation (Line(
            points={{-40,-20},{-40,-10},{-30,-10}},
            color={85,170,255}));
        connect(powerb_m.voltageN, sineVoltage_m.plug_n) annotation (Line(
            points={{-30,-30},{-30,-40},{-80,-40}},
            color={85,170,255}));
        annotation (
          experiment(StopTime=40, Interval=0.01),
          Documentation(info="<html>
<p>
In this example the eddy current losses are implemented in two different ways. Compare the loss dissipation <code>powerb_e.power</code> and <code>powerb_m.power</code> of the two models indicated by power meters.</p>
</html>"));
      end EddyCurrentLosses;
    end Components;

    package BasicMachines "Examples of basic machines"
      extends Modelica.Icons.ExamplesPackage;
      package InductionMachines "Induction machine examples"
        extends Modelica.Icons.ExamplesPackage;
        model IMC_DOL
          "Induction machines with squirrel cage started directly on line (DOL)"
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Integer m=5 "Number of phases";
          parameter Modelica.SIunits.Voltage VsNominal=100
            "Nominal RMS voltage per phase";
          parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
          parameter Modelica.SIunits.Time tOn=0.1 "Start time of machine";
          parameter Modelica.SIunits.Torque T_Load=161.4 "Nominal load torque";
          parameter Modelica.SIunits.AngularVelocity w_Load(displayUnit="rev/min")=
               1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
          parameter Modelica.SIunits.Inertia J_Load=0.5 "Load inertia";
          parameter Integer p=2 "Number of pole pairs";
          output Modelica.SIunits.Current Itr=currentQuasiRMSSensor.I
            "Transient RMS current";
          output Modelica.SIunits.Current Iqs=currentQuasiRMSSensorQS.I
            "QS RMS current";
          Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource
            voltageSourceQS(
            m=m,
            f=fNominal,
            V=fill(VsNominal, m),
            phi=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(
                m)) annotation (Placement(transformation(
                origin={-60,40},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starQS(m=m)
            annotation (Placement(transformation(
                origin={-70,20},
                extent={{-10,-10},{10,10}},
                rotation=180)));
          Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground groundQS
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-90,20})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor
            powerSensorQS(m=m) annotation (Placement(transformation(extent={{-60,
                    70},{-40,90}})));
          Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensorQS(m=m)
            annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Ideal.IdealClosingSwitch
            idealCloserQS(
            final m=m,
            Ron=fill(1e-5*m/3, m),
            Goff=fill(1e-5*3/m, m)) annotation (Placement(transformation(
                origin={-60,70},
                extent={{10,10},{-10,-10}},
                rotation=270)));
          Modelica.Blocks.Sources.BooleanStep booleanStepQS[m](each startTime=
                tOn, each startValue=false) annotation (Placement(
                transformation(extent={{-96,60},{-76,80}})));
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(
                origin={-90,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
             Placement(transformation(extent={{-60,-90},{-80,-70}})));
          Modelica.Electrical.MultiPhase.Sources.CosineVoltage cosineVoltage(
            final m=m,
            freqHz=fill(fNominal, m),
            V=fill(sqrt(2.0)*VsNominal, m)) annotation (Placement(
                transformation(
                origin={-60,-60},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloser(
            final m=m,
            Ron=fill(1e-5*m/3, m),
            Goff=fill(1e-5*3/m, m)) annotation (Placement(transformation(
                origin={-60,-30},
                extent={{10,10},{-10,-10}},
                rotation=270)));
          Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime=tOn,
              each startValue=false) annotation (Placement(transformation(
                  extent={{-96,-40},{-76,-20}})));
          Modelica.Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor(final m=m)
            annotation (Placement(transformation(origin={-20,-20}, extent={{-10,-10},{10,
                    10}})));
          Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(m=m,
              terminalConnection="Y") annotation (Placement(transformation(
                  extent={{20,-64},{40,-44}})));
          Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
            imc(
            Jr=imcData.Jr,
            Js=imcData.Js,
            p=imcData.p,
            fsNominal=imcData.fsNominal,
            TsRef=imcData.TsRef,
            alpha20s(displayUnit="1/K") = imcData.alpha20s,
            frictionParameters=imcData.frictionParameters,
            statorCoreParameters=imcData.statorCoreParameters,
            strayLoadParameters=imcData.strayLoadParameters,
            alpha20r(displayUnit="1/K") = imcData.alpha20r,
            phiMechanical(fixed=true),
            wMechanical(fixed=true),
            Rs=imcData.Rs*m/3,
            Lssigma=imcData.Lssigma*m/3,
            Lszero=imcData.Lszero*m/3,
            Lm=imcData.Lm*m/3,
            Lrsigma=imcData.Lrsigma*m/3,
            Rr=imcData.Rr*m/3,
            TrRef=imcData.TrRef,
            m=m,
            TsOperational=293.15,
            TrOperational=293.15) annotation (Placement(transformation(extent={
                    {20,-80},{40,-60}})));
          Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=J_Load)
            annotation (Placement(transformation(extent={{50,-80},{70,-60}})));
          Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
            quadraticLoadTorque(
            w_nominal=w_Load,
            tau_nominal=-T_Load,
            TorqueDirection=false,
            useSupport=false) annotation (Placement(transformation(extent={{100,
                    -80},{80,-60}})));
          Modelica.Electrical.MultiPhase.Sensors.PowerSensor powerSensor(final
              m=m) annotation (Placement(transformation(extent={{-60,-30},{-40,
                    -10}})));
          Modelica.Mechanics.Rotational.Components.Inertia loadInertiaQS(J=
                J_Load) annotation (Placement(transformation(extent={{50,20},{
                    70,40}})));
          Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
            quadraticLoadTorqueQS(
            w_nominal=w_Load,
            tau_nominal=-T_Load,
            TorqueDirection=false,
            useSupport=false) annotation (Placement(transformation(extent={{100,
                    20},{80,40}})));
          parameter
            Modelica.Electrical.Machines.Utilities.ParameterRecords.AIM_SquirrelCageData
            imcData "Machine data"
            annotation (Placement(transformation(extent={{70,74},{90,94}})));
          FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage imcQS(
            Jr=imcData.Jr,
            Js=imcData.Js,
            p=imcData.p,
            fsNominal=imcData.fsNominal,
            TsRef=imcData.TsRef,
            alpha20s(displayUnit="1/K") = imcData.alpha20s,
            frictionParameters=imcData.frictionParameters,
            statorCoreParameters=imcData.statorCoreParameters,
            strayLoadParameters=imcData.strayLoadParameters,
            alpha20r(displayUnit="1/K") = imcData.alpha20r,
            Rs=imcData.Rs*m/3,
            Lssigma=imcData.Lssigma*m/3,
            Lm=imcData.Lm*m/3,
            Lrsigma=imcData.Lrsigma*m/3,
            Rr=imcData.Rr*m/3,
            TrRef=imcData.TrRef,
            m=m,
            wMechanical(fixed=true),
            TsOperational=293.15,
            gammar(fixed=true, start=pi/2),
            gamma(fixed=true, start=-pi/2),
            TrOperational=293.15) annotation (Placement(transformation(extent={
                    {20,20},{40,40}})));
          Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
            groundMachineQS annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={10,10})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star
            starMachineQS(m=
                Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m))
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=270,
                origin={10,30})));
          Utilities.MultiTerminalBox terminalBoxQS(m=m, terminalConnection="Y")
            annotation (Placement(transformation(extent={{20,36},{40,56}})));
        initial equation
          imc.is[1:2] = zeros(2);
          imc.rotorCage.electroMagneticConverter.Phi = Complex(0, 0);

        equation
          connect(groundQS.pin, starQS.pin_n)
            annotation (Line(points={{-80,20},{-80,20}}, color={85,170,255}));
          connect(starQS.plug_p, voltageSourceQS.plug_n)
            annotation (Line(points={{-60,20},{-60,30}}, color={85,170,255}));
          connect(powerSensorQS.currentN, currentQuasiRMSSensorQS.plug_p)
            annotation (Line(points={{-40,80},{-30,80}}, color={85,170,255}));
          connect(powerSensorQS.voltageP, powerSensorQS.currentP) annotation (
              Line(points={{-50,90},{-60,90},{-60,80}}, color={85,170,255}));
          connect(powerSensorQS.voltageN, starQS.plug_p) annotation (Line(
                points={{-50,70},{-50,20},{-60,20}}, color={85,170,255}));
          connect(booleanStepQS.y, idealCloserQS.control) annotation (Line(
              points={{-75,70},{-67,70}},
              color={255,0,255}));
          connect(star.pin_n, ground.p)
            annotation (Line(points={{-80,-80},{-80,-80}}, color={0,0,255}));
          connect(cosineVoltage.plug_n, star.plug_p)
            annotation (Line(points={{-60,-70},{-60,-80}}, color={0,0,255}));
          connect(imc.flange, loadInertia.flange_a) annotation (Line(points={{
                  40,-70},{40,-70},{50,-70}}));
          connect(loadInertia.flange_b, quadraticLoadTorque.flange)
            annotation (Line(points={{70,-70},{80,-70}}));
          connect(terminalBoxM.plug_sn, imc.plug_sn)
            annotation (Line(points={{24,-60},{24,-60}}, color={0,0,255}));
          connect(terminalBoxM.plug_sp, imc.plug_sp)
            annotation (Line(points={{36,-60},{36,-60}}, color={0,0,255}));
          connect(booleanStep.y, idealCloser.control) annotation (Line(
              points={{-75,-30},{-67,-30}},
              color={255,0,255}));
          connect(idealCloser.plug_p, cosineVoltage.plug_p) annotation (Line(
              points={{-60,-40},{-60,-50}},
              color={0,0,255}));
          connect(idealCloserQS.plug_p, voltageSourceQS.plug_p) annotation (
              Line(
              points={{-60,60},{-60,50}},
              color={85,170,255}));
          connect(idealCloserQS.plug_n, powerSensorQS.currentP) annotation (
              Line(
              points={{-60,80},{-60,80}},
              color={85,170,255}));
          connect(idealCloser.plug_n, powerSensor.pc) annotation (Line(
              points={{-60,-20},{-60,-20}},
              color={0,0,255}));
          connect(powerSensor.nc, currentQuasiRMSSensor.plug_p)
            annotation (Line(points={{-40,-20},{-30,-20}}, color={0,0,255}));
          connect(currentQuasiRMSSensor.plug_n, terminalBoxM.plugSupply)
            annotation (Line(points={{-10,-20},{30,-20},{30,-58}}, color={0,0,255}));
          connect(loadInertiaQS.flange_b, quadraticLoadTorqueQS.flange)
            annotation (Line(points={{70,30},{80,30}}));
          connect(powerSensor.pv, powerSensor.pc) annotation (Line(
              points={{-50,-10},{-60,-10},{-60,-20}},
              color={0,0,255}));
          connect(powerSensor.nv, star.plug_p) annotation (Line(
              points={{-50,-30},{-50,-80},{-60,-80}},
              color={0,0,255}));
          connect(imcQS.flange, loadInertiaQS.flange_a) annotation (Line(
              points={{40,30},{50,30}}));
          connect(terminalBoxQS.plug_sn, imcQS.plug_sn) annotation (Line(
              points={{24,40},{24,40}},
              color={85,170,255}));
          connect(terminalBoxQS.plug_sp, imcQS.plug_sp) annotation (Line(
              points={{36,40},{36,40}},
              color={85,170,255}));
          connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
              Line(
              points={{10,40},{10,42},{21,42}},
              color={85,170,255}));
          connect(currentQuasiRMSSensorQS.plug_n, terminalBoxQS.plugSupply)
            annotation (Line(points={{-10,80},{30,80},{30,42}}, color={85,170,255}));
          connect(starMachineQS.pin_n, groundMachineQS.pin) annotation (Line(
              points={{10,20},{10,20}},
              color={85,170,255}));
          annotation (Diagram(coordinateSystem(preserveAspectRatio=false,
                  extent={{-100,-100},{100,100}}), graphics={Rectangle(
                          extent={{-100,98},{100,4}},
                          lineColor={0,0,255},
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid,
                          pattern=LinePattern.Dash),Rectangle(
                          extent={{-100,-2},{100,-92}},
                          lineColor={0,0,255},
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid,
                          pattern=LinePattern.Dash),Text(
                          extent={{20,-6},{100,-14}},
                          lineColor={0,0,0},
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid,
                          textStyle={TextStyle.Bold},
                          textString="%m phase transient
"),             Text(
                  extent={{20,14},{100,6}},
                          lineColor={0,0,0},
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid,
                          textStyle={TextStyle.Bold},
                          textString="%m phase QS
")}),           experiment(StopTime=1.5, Interval=0.001),
            Documentation(info="<html>
<h4>Direct on line (DOL) starting of an induction machine with squirrel cage</h4>
<p>
This example compares a time transient and a quasi static model of a multi phase induction machine. At start time <code>tOn</code> a transient and a quasi static multi phase voltage source are connected to an induction machine. The machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed, finally reaching nominal speed.</p>

<p>
Simulate for 1 second and plot (versus time):
</p>

<ul>
<li><code>currentRMSsensor.I|currentSensorQS.abs_i[1]</code>: (equivalent) RMS stator current</li>
<li><code>imc|imcQS.wMechanical</code>: machine speed</li>
<li><code>imc|imcQS.tauElectrical</code>: machine torque</li>
</ul>
</html>"));
        end IMC_DOL;

        model IMC_Inverter
          "Test example: InductionMachineSquirrelCage with inverter"
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Integer m=3 "Number of phases";
          parameter Modelica.SIunits.Voltage VNominal=100
            "Nominal RMS voltage per phase";
          parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
          parameter Modelica.SIunits.Frequency f=50 "Actual frequency";
          parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
          parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
          parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
          parameter Modelica.SIunits.Inertia JLoad=0.29
            "Load's moment of inertia";
          output Modelica.SIunits.Current Itr=currentQuasiRMSSensor.I
            "Transient RMS current";
          output Modelica.SIunits.Current Iqs=currentQuasiRMSSensorQS.I
            "QS RMS current";
          Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
            imc(
            p=imcData.p,
            fsNominal=imcData.fsNominal,
            TsRef=imcData.TsRef,
            alpha20s(displayUnit="1/K") = imcData.alpha20s,
            Jr=imcData.Jr,
            Js=imcData.Js,
            frictionParameters=imcData.frictionParameters,
            phiMechanical(fixed=true),
            wMechanical(fixed=true),
            statorCoreParameters=imcData.statorCoreParameters,
            strayLoadParameters=imcData.strayLoadParameters,
            TrRef=imcData.TrRef,
            m=m,
            TsOperational=293.15,
            Rs=imcData.Rs*m/3,
            Lssigma=imcData.Lssigma*m/3,
            Lszero=imcData.Lszero*m/3,
            Lm=imcData.Lm*m/3,
            Lrsigma=imcData.Lrsigma*m/3,
            Rr=imcData.Rr*m/3,
            alpha20r=imcData.alpha20r,
            TrOperational=293.15) annotation (Placement(transformation(extent={
                    {20,-90},{40,-70}})));
          Modelica.Blocks.Sources.Ramp ramp(height=f, duration=tRamp)
            annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
          Modelica.Electrical.Machines.Utilities.VfController vfController(
            final m=m,
            VNominal=VNominal,
            fNominal=fNominal,
            BasePhase=+Modelica.Constants.pi/2) annotation (Placement(
                transformation(extent={{-38,-30},{-18,-10}})));
          Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage(
              final m=m) annotation (Placement(transformation(
                origin={-10,-50},
                extent={{10,10},{-10,-10}},
                rotation=180)));
          Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
             Placement(transformation(extent={{-30,-60},{-50,-40}})));
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(
                origin={-60,-50},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
            annotation (Placement(transformation(extent={{48,-90},{68,-70}})));
          Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(
            startTime=tStep,
            stepTorque=-TLoad,
            useSupport=false,
            offsetTorque=0) annotation (Placement(transformation(extent={{96,-90},
                    {76,-70}})));
          Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
              terminalConnection="Y", m=m) annotation (Placement(transformation(
                  extent={{20,-74},{40,-54}})));
          parameter
            Modelica.Electrical.Machines.Utilities.ParameterRecords.AIM_SquirrelCageData
            imcData "Machine data"
            annotation (Placement(transformation(extent={{70,70},{90,90}})));
          Modelica.Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor
            currentQuasiRMSSensor(final m=m) annotation (Placement(
                transformation(
                origin={20,-50},
                extent={{-10,10},{10,-10}})));
          FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage imcQS(
            p=imcData.p,
            fsNominal=imcData.fsNominal,
            TsRef=imcData.TsRef,
            alpha20s(displayUnit="1/K") = imcData.alpha20s,
            Jr=imcData.Jr,
            Js=imcData.Js,
            frictionParameters=imcData.frictionParameters,
            statorCoreParameters=imcData.statorCoreParameters,
            strayLoadParameters=imcData.strayLoadParameters,
            TrRef=imcData.TrRef,
            m=m,
            gammar(fixed=true, start=+pi/2),
            gamma(fixed=true, start=-pi/2),
            wMechanical(fixed=true, start=0),
            TsOperational=293.15,
            Rs=imcData.Rs*m/3,
            Lssigma=imcData.Lssigma*m/3,
            Lm=imcData.Lm*m/3,
            Lrsigma=imcData.Lrsigma*m/3,
            Rr=imcData.Rr*m/3,
            alpha20r=imcData.alpha20r,
            TrOperational=293.15) annotation (Placement(transformation(extent={
                    {20,10},{40,30}})));
          Modelica.Mechanics.Rotational.Components.Inertia loadInertiaQS(J=
                JLoad) annotation (Placement(transformation(extent={{50,10},{70,
                    30}})));
          Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStepQS(
            startTime=tStep,
            stepTorque=-TLoad,
            useSupport=false,
            offsetTorque=0) annotation (Placement(transformation(extent={{96,10},
                    {76,30}})));
          Utilities.MultiTerminalBox terminalBox1(terminalConnection="Y", m=m)
            annotation (Placement(transformation(extent={{20,26},{40,46}})));
          Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor
            currentQuasiRMSSensorQS(m=m) annotation (Placement(transformation(
                origin={20,50},
                extent={{-10,10},{10,-10}})));
          Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
            groundMachineQS annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-30,30})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star
            starMachineQS(m=
                Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m))
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,30})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableVoltageSource
            signalVoltageQS(final m=m) annotation (Placement(transformation(
                origin={-10,50},
                extent={{10,-10},{-10,10}})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starQS(
              final m=m) annotation (Placement(transformation(extent={{-30,40},
                    {-50,60}})));
          Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground groundQS
            annotation (Placement(transformation(
                origin={-60,50},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          FundamentalWave.Utilities.VfController vfControllerQS(
            final m=m,
            VNominal=VNominal,
            fNominal=fNominal,
            BasePhase=+Modelica.Constants.pi/2) annotation (Placement(
                transformation(extent={{-40,74},{-20,94}})));
        initial equation
          imc.is[1:2] = zeros(2);
          imc.ir[1:m - 1] = zeros(m - 1);

        equation
          connect(ramp.y, vfController.u) annotation (Line(points={{-79,0},{-70,
                  0},{-70,-20},{-40,-20}}, color={0,0,255}));
          connect(loadTorqueStep.flange, loadInertia.flange_b)
            annotation (Line(points={{76,-80},{68,-80}}));
          connect(terminalBox.plug_sn, imc.plug_sn) annotation (Line(
              points={{24,-70},{24,-70}},
              color={0,0,255}));
          connect(terminalBox.plug_sp, imc.plug_sp) annotation (Line(
              points={{36,-70},{36,-70}},
              color={0,0,255}));
          connect(imc.flange, loadInertia.flange_a) annotation (Line(
              points={{40,-80},{48,-80}}));
          connect(signalVoltage.plug_n, currentQuasiRMSSensor.plug_p)
            annotation (Line(
              points={{0,-50},{10,-50}},
              color={0,0,255}));
          connect(currentQuasiRMSSensor.plug_n, terminalBox.plugSupply)
            annotation (Line(
              points={{30,-50},{30,-68}},
              color={0,0,255}));
          connect(ground.p, star.pin_n) annotation (Line(
              points={{-50,-50},{-50,-50}},
              color={0,0,255}));
          connect(star.plug_p, signalVoltage.plug_p) annotation (Line(
              points={{-30,-50},{-20,-50}},
              color={0,0,255}));
          connect(vfController.y, signalVoltage.v) annotation (Line(
              points={{-17,-20},{-10,-20},{-10,-43}},
              color={0,0,127}));
          connect(loadTorqueStepQS.flange, loadInertiaQS.flange_b)
            annotation (Line(points={{76,20},{70,20}}));
          connect(imcQS.flange, loadInertiaQS.flange_a) annotation (Line(
              points={{40,20},{50,20}}));
          connect(terminalBox1.plug_sn, imcQS.plug_sn) annotation (Line(
              points={{24,30},{24,30}},
              color={85,170,255}));
          connect(terminalBox1.plug_sp, imcQS.plug_sp) annotation (Line(
              points={{36,30},{36,30}},
              color={85,170,255}));
          connect(currentQuasiRMSSensorQS.plug_n, terminalBox1.plugSupply)
            annotation (Line(
              points={{30,50},{30,32}},
              color={85,170,255}));
          connect(groundMachineQS.pin, starMachineQS.pin_n) annotation (Line(
              points={{-20,30},{-10,30}},
              color={85,170,255}));
          connect(starMachineQS.plug_p, terminalBox1.starpoint) annotation (
              Line(
              points={{10,30},{10,32},{21,32}},
              color={85,170,255}));
          connect(groundQS.pin, starQS.pin_n) annotation (Line(
              points={{-50,50},{-50,50}},
              color={85,170,255}));
          connect(starQS.plug_p, signalVoltageQS.plug_n) annotation (Line(
              points={{-30,50},{-20,50}},
              color={85,170,255}));
          connect(signalVoltageQS.plug_p, currentQuasiRMSSensorQS.plug_p)
            annotation (Line(
              points={{0,50},{10,50}},
              color={85,170,255}));
          connect(vfControllerQS.y, signalVoltageQS.V) annotation (Line(
              points={{-19,84},{-6,84},{-6,60}},
              color={85,170,255}));
          connect(ramp.y, vfControllerQS.u) annotation (Line(
              points={{-79,0},{-70,0},{-70,84},{-42,84}},
              color={0,0,127}));
          connect(ramp.y, signalVoltageQS.f) annotation (Line(
              points={{-79,0},{-70,0},{-70,70},{-14,70},{-14,60}},
              color={0,0,127}));
          annotation (
            experiment(StopTime=1.5, Interval=0.001),
            Documentation(info="<html>
<h4>Induction machine with squirrel cage fed by an ideal inverter</h4>

<p>This example compares a time transient and a quasi static model of a multi phase induction machine.
An ideal frequency inverter is modeled by using a <code>VfController</code> and a multi phase <code>SignalVoltage.
Frequency is raised by a ramp, causing the induction machine with squirrel cage to start,
and accelerating inertias. At time <code>tStep</code> a load step is applied.<p>

<p>Simulate for 1.5 seconds and plot (versus time):</p>

<ul>
<li><code>currentRMSsensor.I|currentSensorQS.abs_i[1]</code>: (equivalent) RMS stator current</li>
<li><code>imc|imcQS.wMechanical</code>: machine speed</li>
<li><code>imc|imcQS.tauElectrical</code>: machine torque</li>
</ul>
</html>"),  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}),
                                 graphics={Rectangle(
                          extent={{-74,-2},{100,-100}},
                          lineColor={0,0,255},
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid,
                          pattern=LinePattern.Dash),Rectangle(
                          extent={{-74,100},{100,2}},
                          lineColor={0,0,255},
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid,
                          pattern=LinePattern.Dash),Text(
                          extent={{20,-6},{100,-14}},
                          lineColor={0,0,0},
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid,
                          textStyle={TextStyle.Bold},
                          textString="%m phase transient
"),             Text(
                  extent={{-66,10},{14,2}},
                          lineColor={0,0,0},
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid,
                          textStyle={TextStyle.Bold},
                          textString="%m phase QS
")}));
        end IMC_Inverter;

        model IMS_Start "Starting of induction machine with slip rings"
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Integer m=3 "Number of stator phases";
          parameter Integer mr=3 "Number of rotor phases";
          parameter Modelica.SIunits.Voltage VsNominal=100
            "Nominal RMS voltage per phase";
          parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
          parameter Modelica.SIunits.Time tOn=0.1 "Start time of machine";
          parameter Modelica.SIunits.Resistance RStart=0.16/imsData.turnsRatio^
              2 "Starting resistance";
          parameter Modelica.SIunits.Time tRheostat=1.0
            "Time of shortening the rheostat";
          parameter Modelica.SIunits.Torque T_Load=161.4 "Nominal load torque";
          parameter Modelica.SIunits.AngularVelocity w_Load(displayUnit="rev/min")=
               Modelica.SIunits.Conversions.from_rpm(1440.45)
            "Nominal load speed";
          parameter Modelica.SIunits.Inertia J_Load=0.29 "Load inertia";
          output Modelica.SIunits.Current Itr=currentQuasiRMSSensor.I
            "Transient RMS current";
          output Modelica.SIunits.Current Iqs=currentQuasiRMSSensorQS.I
            "QS RMS current";
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(
                origin={-90,-70},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
             Placement(transformation(
                extent={{10,-10},{-10,10}},
                origin={-70,-70})));
          Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
            final m=m,
            freqHz=fill(fNominal, m),
            V=fill(sqrt(2.0)*VsNominal, m)) annotation (Placement(
                transformation(
                origin={-60,-52},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloser(
            final m=m,
            Ron=fill(1e-5*m/3, m),
            Goff=fill(1e-5*3/m, m)) annotation (Placement(transformation(
                origin={-60,-28},
                extent={{-10,-10},{10,10}},
                rotation=90)));
          Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime=tOn)
            annotation (Placement(transformation(extent={{-96,-38},{-76,-18}})));
          Modelica.Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor(m=m)
            annotation (Placement(transformation(origin={-20,-18}, extent={{-10,-10},{10,
                    10}})));
          Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(m=m,
              terminalConnection="Y") annotation (Placement(transformation(
                  extent={{10,-64},{30,-44}})));
          Utilities.MultiTerminalBox terminalBoxQS(m=m, terminalConnection="Y")
            annotation (Placement(transformation(extent={{10,36},{30,56}})));
          Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing
            ims(
            Jr=imsData.Jr,
            Js=imsData.Js,
            p=imsData.p,
            fsNominal=imsData.fsNominal,
            TsRef=imsData.TsRef,
            alpha20s(displayUnit="1/K") = imsData.alpha20s,
            frictionParameters=imsData.frictionParameters,
            statorCoreParameters=imsData.statorCoreParameters,
            strayLoadParameters=imsData.strayLoadParameters,
            phiMechanical(fixed=true),
            wMechanical(fixed=true),
            TrRef=imsData.TrRef,
            alpha20r(displayUnit="1/K") = imsData.alpha20r,
            useTurnsRatio=imsData.useTurnsRatio,
            VsNominal=imsData.VsNominal,
            VrLockedRotor=imsData.VrLockedRotor,
            rotorCoreParameters=imsData.rotorCoreParameters,
            TurnsRatio=imsData.turnsRatio,
            Rs=imsData.Rs*m/3,
            Lssigma=imsData.Lssigma*m/3,
            Lszero=imsData.Lszero*m/3,
            Lm=imsData.Lm*m/3,
            Lrsigma=imsData.Lrsigma*mr/3,
            Lrzero=imsData.Lrzero*mr/3,
            Rr=imsData.Rr*mr/3,
            mr=mr,
            m=m,
            TsOperational=293.15,
            TrOperational=293.15) annotation (Placement(transformation(extent={
                    {10,-80},{30,-60}})));
          FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing imsQS(
            p=imsData.p,
            fsNominal=imsData.fsNominal,
            TsRef=imsData.TsRef,
            alpha20s(displayUnit="1/K") = imsData.alpha20s,
            Jr=imsData.Jr,
            Js=imsData.Js,
            frictionParameters=imsData.frictionParameters,
            statorCoreParameters=imsData.statorCoreParameters,
            strayLoadParameters=imsData.strayLoadParameters,
            TrRef=imsData.TrRef,
            alpha20r(displayUnit="1/K") = imsData.alpha20r,
            useTurnsRatio=imsData.useTurnsRatio,
            VsNominal=imsData.VsNominal,
            VrLockedRotor=imsData.VrLockedRotor,
            rotorCoreParameters=imsData.rotorCoreParameters,
            Rs=imsData.Rs*m/3,
            Lssigma=imsData.Lssigma*m/3,
            Lm=imsData.Lm*m/3,
            gammar(fixed=true, start=pi/2),
            gamma(fixed=true, start=-pi/2),
            wMechanical(fixed=true),
            TurnsRatio=imsData.turnsRatio,
            Lrsigma=imsData.Lrsigma*mr/3,
            Rr=imsData.Rr*mr/3,
            mr=mr,
            m=m,
            TsOperational=566.3,
            TrOperational=566.3) annotation (Placement(transformation(extent={{
                    10,20},{30,40}})));
          Modelica.Electrical.Machines.Utilities.SwitchedRheostat rheostatM(
            tStart=tRheostat,
            m=mr,
            RStart=RStart*mr/3) annotation (Placement(transformation(extent={{-10,
                    -80},{10,-60}})));
          FundamentalWave.Utilities.SwitchedRheostat rheostatE(
            tStart=tRheostat,
            RStart=RStart*mr/3,
            m=mr) annotation (Placement(transformation(extent={{-10,20},{10,40}})));
          Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=J_Load)
            annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
          Modelica.Mechanics.Rotational.Components.Inertia loadInertiaE(J=
                J_Load) annotation (Placement(transformation(extent={{40,20},{
                    60,40}})));
          Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
            quadraticLoadTorque(
            tau_nominal=-T_Load,
            TorqueDirection=false,
            useSupport=false,
            w_nominal=w_Load) annotation (Placement(transformation(extent={{90,
                    -80},{70,-60}})));
          Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
            quadraticLoadTorqueE(
            tau_nominal=-T_Load,
            TorqueDirection=false,
            useSupport=false,
            w_nominal=w_Load) annotation (Placement(transformation(extent={{90,
                    20},{70,40}})));
          parameter
            Modelica.Electrical.Machines.Utilities.ParameterRecords.AIM_SlipRingData
            imsData "Machine data"
            annotation (Placement(transformation(extent={{70,70},{90,90}})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource
            voltageSourceQS(
            m=m,
            phi=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(
                m),
            f=fNominal,
            V=fill(VsNominal, m)) annotation (Placement(transformation(
                origin={-60,40},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starQS(m=m)
            annotation (Placement(transformation(
                origin={-70,20},
                extent={{-10,-10},{10,10}},
                rotation=180)));
          Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground groundQS
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-90,20})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor
            powerSensorQS(m=m) annotation (Placement(transformation(extent={{-60,
                    74},{-40,94}})));
          Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensorQS(m=m)
            annotation (Placement(transformation(extent={{-30,74},{-10,94}})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Ideal.IdealClosingSwitch
            idealCloserQS(
            final m=m,
            Ron=fill(1e-5*m/3, m),
            Goff=fill(1e-5*3/m, m)) annotation (Placement(transformation(
                origin={-60,64},
                extent={{10,10},{-10,-10}},
                rotation=270)));
          Modelica.Blocks.Sources.BooleanStep booleanStepQS[m](each startTime=
                tOn, each startValue=false) annotation (Placement(
                transformation(extent={{-96,54},{-76,74}})));
          Modelica.Electrical.MultiPhase.Sensors.PowerSensor powerSensor(m=m)
            annotation (Placement(transformation(extent={{-60,-28},{-40,-8}})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star
            starMachineQS(m=
                Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m))
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=270,
                origin={-20,30})));
          Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
            groundMachineQS annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={-20,10})));
        initial equation
          ims.is[1:2] = zeros(2);
          ims.ir[1:mr] = zeros(mr);

        equation
          connect(star.pin_n, ground.p)
            annotation (Line(points={{-80,-70},{-80,-70}}, color={0,0,255}));
          connect(sineVoltage.plug_n, star.plug_p)
            annotation (Line(points={{-60,-62},{-60,-70}}, color={0,0,255}));
          connect(loadInertiaE.flange_b, quadraticLoadTorqueE.flange)
            annotation (Line(points={{60,30},{64,30},{70,30}}));
          connect(imsQS.flange, loadInertiaE.flange_a)
            annotation (Line(points={{30,30},{34,30},{40,30}}));
          connect(booleanStep.y, idealCloser.control) annotation (Line(points={
                  {-75,-28},{-75,-28},{-67,-28}}, color={255,0,255}));
          connect(terminalBoxQS.plug_sn, imsQS.plug_sn)
            annotation (Line(points={{14,40},{14,40}}, color={0,0,255}));
          connect(terminalBoxQS.plug_sp, imsQS.plug_sp)
            annotation (Line(points={{26,40},{26,40}}, color={0,0,255}));
          connect(loadInertia.flange_b, quadraticLoadTorque.flange) annotation (
             Line(points={{60,-70},{60,-70},{70,-70}}));
          connect(ims.flange, loadInertia.flange_a) annotation (Line(points={{
                  30,-70},{30,-70},{40,-70}}));
          connect(terminalBoxM.plug_sp, ims.plug_sp)
            annotation (Line(points={{26,-60},{26,-60}}, color={0,0,255}));
          connect(terminalBoxM.plug_sn, ims.plug_sn)
            annotation (Line(points={{14,-60},{14,-60}}, color={0,0,255}));
          connect(currentQuasiRMSSensor.plug_n, terminalBoxM.plugSupply)
            annotation (Line(points={{-10,-18},{20,-18},{20,-58}}, color={0,0,255}));
          connect(rheostatM.plug_p, ims.plug_rp) annotation (Line(
              points={{10,-64},{10,-64}},
              color={0,0,255}));
          connect(rheostatM.plug_n, ims.plug_rn) annotation (Line(
              points={{10,-76},{10,-76}},
              color={0,0,255}));
          connect(idealCloser.plug_p, sineVoltage.plug_p) annotation (Line(
              points={{-60,-38},{-60,-42}},
              color={0,0,255}));
          connect(imsQS.plug_rp, rheostatE.plug_p) annotation (Line(
              points={{10,36},{10,36}},
              color={85,170,255}));
          connect(rheostatE.plug_n, imsQS.plug_rn) annotation (Line(
              points={{10,24},{10,24}},
              color={85,170,255}));
          connect(groundQS.pin, starQS.pin_n)
            annotation (Line(points={{-80,20},{-80,20}}, color={85,170,255}));
          connect(starQS.plug_p, voltageSourceQS.plug_n)
            annotation (Line(points={{-60,20},{-60,30}}, color={85,170,255}));
          connect(powerSensorQS.currentN, currentQuasiRMSSensorQS.plug_p)
            annotation (Line(points={{-40,84},{-40,84},{-30,84}}, color={85,170,255}));
          connect(powerSensorQS.voltageP, powerSensorQS.currentP) annotation (
              Line(points={{-50,94},{-60,94},{-60,84}}, color={85,170,255}));
          connect(powerSensorQS.voltageN, starQS.plug_p) annotation (Line(
                points={{-50,74},{-50,20},{-60,20}}, color={85,170,255}));
          connect(booleanStepQS.y, idealCloserQS.control) annotation (Line(
              points={{-75,64},{-67,64}},
              color={255,0,255}));
          connect(idealCloserQS.plug_p, voltageSourceQS.plug_p) annotation (
              Line(
              points={{-60,54},{-60,50}},
              color={85,170,255}));
          connect(idealCloserQS.plug_n, powerSensorQS.currentP) annotation (
              Line(
              points={{-60,74},{-60,84}},
              color={85,170,255}));
          connect(idealCloser.plug_n, powerSensor.pc) annotation (Line(
              points={{-60,-18},{-60,-18}},
              color={0,0,255}));
          connect(powerSensor.pc, powerSensor.pv) annotation (Line(
              points={{-60,-18},{-60,-8},{-50,-8}},
              color={0,0,255}));
          connect(powerSensor.nv, star.plug_p) annotation (Line(
              points={{-50,-28},{-50,-70},{-60,-70}},
              color={0,0,255}));
          connect(powerSensor.nc, currentQuasiRMSSensor.plug_p)
            annotation (Line(points={{-40,-18},{-30,-18}}, color={0,0,255}));
          connect(currentQuasiRMSSensorQS.plug_n, terminalBoxQS.plugSupply)
            annotation (Line(points={{-10,84},{20,84},{20,42}}, color={85,170,255}));
          connect(starMachineQS.pin_n, groundMachineQS.pin) annotation (Line(
              points={{-20,20},{-20,20}},
              color={85,170,255}));
          connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
              Line(
              points={{-20,40},{-20,42},{11,42}},
              color={85,170,255}));
          annotation (
            experiment(
              StopTime=1.5,
              Interval=0.001,
              Tolerance=1e-05),
            Documentation(info="<html>
<h4>Starting of an induction machine with slipring rotor resistance starting</h4>

<p>
This example compares a time transient and a quasi static model of a multi phase induction machine.
At start time <code>tOn</code> a transient and a quasi static multi phase voltage source are connected to induction machine with sliprings. The machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed,
using a starting resistance. At time <code>tRheostat</code> external rotor resistance is shortened, finally reaching nominal speed.</p>

<p>
Simulate for 1.5 seconds and plot (versus time):
</p>

<ul>
<li><code>currentRMSsensor.I|currentSensorQS.abs_i[1]</code>: (equivalent) RMS stator current</li>
<li><code>ims|imsQS.wMechanical</code>: machine speed</li>
<li><code>ims|imsQS.tauElectrical</code>: machine torque</li>
</ul>
</html>"),  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}),
                                 graphics={Rectangle(
                          extent={{-100,100},{100,2}},
                          lineColor={0,0,255},
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid,
                          pattern=LinePattern.Dash),Rectangle(
                          extent={{-100,-2},{100,-100}},
                          lineColor={0,0,255},
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid,
                          pattern=LinePattern.Dash),Text(
                          extent={{20,12},{100,4}},
                          lineColor={0,0,0},
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid,
                          textStyle={TextStyle.Bold},
                          textString="%m phase QS
"),             Text(
                  extent={{20,-4},{100,-12}},
                          lineColor={0,0,0},
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid,
                          textStyle={TextStyle.Bold},
                          textString="%m phase transient
")}));
        end IMS_Start;
      end InductionMachines;

      package SynchronousMachines "Synchronous machine examples"
        extends Modelica.Icons.ExamplesPackage;
        model SMPM_Mains
          "Permanent magnet synchronous machine operated at mains"
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Integer m=3 "Number of phases";
          parameter Modelica.SIunits.Frequency f=50 "Supply frequency";
          parameter Modelica.SIunits.Voltage V=112.3 "Supply voltage";
          parameter Modelica.SIunits.Torque T_Load=181.4 "Nominal load torque";
          parameter Modelica.SIunits.Time tStep=0.5 "Time of load torque step";
          parameter Modelica.SIunits.Inertia J_Load=0.29 "Load inertia";
          output Modelica.SIunits.Current Itr=currentQuasiRMSSensor.I
            "Transient RMS current";
          output Modelica.SIunits.Current Iqs=currentQuasiRMSSensorQS.I
            "QS RMS current";
          Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource
            voltageSourceQS(
            m=m,
            f=f,
            V=fill(V, m),
            phi=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(
                m)) annotation (Placement(transformation(
                origin={-60,50},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starQS(m=m)
            annotation (Placement(transformation(
                origin={-60,20},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground groundQS
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-78,10})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor
            powerSensorQS(m=m) annotation (Placement(transformation(extent={{-60,
                    70},{-40,90}})));
          Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensorQS(m=m)
            annotation (Placement(transformation(extent={{-20,70},{0,90}})));
          FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet
            smpmQS(
            m=m,
            Jr=smpmData.Jr,
            p=smpmData.p,
            fsNominal=smpmData.fsNominal,
            TsRef=smpmData.TsRef,
            frictionParameters=smpmData.frictionParameters,
            statorCoreParameters=smpmData.statorCoreParameters,
            strayLoadParameters=smpmData.strayLoadParameters,
            useDamperCage=smpmData.useDamperCage,
            Lrsigmad=smpmData.Lrsigmad,
            Lrsigmaq=smpmData.Lrsigmaq,
            Rrd=smpmData.Rrd,
            Rrq=smpmData.Rrq,
            TrRef=smpmData.TrRef,
            VsOpenCircuit=smpmData.VsOpenCircuit,
            permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
            wMechanical(fixed=true, start=2*pi*smpmData.fsNominal/smpmData.p),
            Rs=smpmData.Rs*m/3,
            Lssigma=smpmData.Lssigma*m/3,
            Lmd=smpmData.Lmd*m/3,
            Lmq=smpmData.Lmq*m/3,
            useSupport=false,
            Js=smpmData.Js,
            TsOperational=293.15,
            alpha20s=smpmData.alpha20s,
            gammar(start=pi/2, fixed=true),
            gamma(start=-pi/2, fixed=true),
            alpha20r=smpmData.alpha20r,
            TrOperational=293.15)
            annotation (Placement(transformation(extent={{-10,30},{10,50}})));

          Modelica.Mechanics.Rotational.Components.Inertia loadInertiaMQS(J=
                J_Load) annotation (Placement(transformation(extent={{20,30},{
                    40,50}})));
          Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStepMQS(
            startTime=tStep,
            stepTorque=-T_Load,
            useSupport=false,
            offsetTorque=0) annotation (Placement(transformation(extent={{70,30},
                    {50,50}})));
          parameter
            Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
            smpmData(useDamperCage=true) "Machine data"
            annotation (Placement(transformation(extent={{60,72},{80,92}})));
          Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
            groundMachineQS annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={-30,12})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star
            starMachineQS(m=
                Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m))
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=270,
                origin={-30,40})));
          Utilities.MultiTerminalBox terminalBoxQS(m=m, terminalConnection="Y")
            annotation (Placement(transformation(extent={{-10,46},{10,66}})));
          Modelica.Electrical.MultiPhase.Sources.CosineVoltage voltageSource(
            m=m,
            freqHz=fill(f, m),
            V=fill(sqrt(2)*V, m))
                               annotation (Placement(transformation(
                origin={-60,-50},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.MultiPhase.Basic.Star star(m=m) annotation (
              Placement(transformation(
                origin={-60,-80},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-80,-90})));
          Modelica.Electrical.MultiPhase.Sensors.PowerSensor powerSensor(m=m)
            annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
          Modelica.Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor(m=m)
            annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
          Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet
            smpm(
            m=m,
            Jr=smpmData.Jr,
            p=smpmData.p,
            fsNominal=smpmData.fsNominal,
            TsRef=smpmData.TsRef,
            frictionParameters=smpmData.frictionParameters,
            statorCoreParameters=smpmData.statorCoreParameters,
            strayLoadParameters=smpmData.strayLoadParameters,
            useDamperCage=smpmData.useDamperCage,
            Lrsigmad=smpmData.Lrsigmad,
            Lrsigmaq=smpmData.Lrsigmaq,
            Rrd=smpmData.Rrd,
            Rrq=smpmData.Rrq,
            TrRef=smpmData.TrRef,
            VsOpenCircuit=smpmData.VsOpenCircuit,
            permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
            wMechanical(fixed=true, start=2*pi*smpmData.fsNominal/smpmData.p),
            Rs=smpmData.Rs*m/3,
            Lssigma=smpmData.Lssigma*m/3,
            Lmd=smpmData.Lmd*m/3,
            Lmq=smpmData.Lmq*m/3,
            useSupport=false,
            Js=smpmData.Jr,
            phiMechanical(start=0, fixed=true),
            TsOperational=293.15,
            alpha20s=smpmData.alpha20s,
            alpha20r=smpmData.alpha20r,
            TrOperational=293.15,
            ir(fixed=true, start=zeros(2)))
            annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));

          Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(J=
                J_Load) annotation (Placement(transformation(extent={{20,-70},{
                    40,-50}})));
          Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStepM(
            startTime=tStep,
            stepTorque=-T_Load,
            useSupport=false,
            offsetTorque=0) annotation (Placement(transformation(extent={{70,-70},
                    {50,-50}})));
          Modelica.Electrical.Analog.Basic.Ground groundMachine annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={-30,-88})));
          Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(m=m,
              terminalConnection="Y") annotation (Placement(transformation(
                  extent={{-10,-54},{10,-34}})));
        initial equation
          smpm.is=zeros(m);

        equation
          connect(groundQS.pin, starQS.pin_n) annotation (Line(points={{-68,10},
                  {-68,10},{-60,10}}, color={85,170,255}));
          connect(starQS.plug_p, voltageSourceQS.plug_n)
            annotation (Line(points={{-60,30},{-60,40}}, color={85,170,255}));
          connect(voltageSourceQS.plug_p, powerSensorQS.currentP) annotation (
              Line(points={{-60,60},{-60,70},{-60,80}}, color={85,170,255}));
          connect(powerSensorQS.currentN, currentQuasiRMSSensorQS.plug_p)
            annotation (Line(points={{-40,80},{-20,80}}, color={85,170,255}));
          connect(powerSensorQS.voltageP, powerSensorQS.currentP) annotation (
              Line(points={{-50,90},{-60,90},{-60,80}}, color={85,170,255}));
          connect(powerSensorQS.voltageN, starQS.plug_p) annotation (Line(
                points={{-50,70},{-50,30},{-60,30}}, color={85,170,255}));
          connect(loadInertiaMQS.flange_b, torqueStepMQS.flange)
            annotation (Line(points={{40,40},{50,40}}));
          connect(smpmQS.flange, loadInertiaMQS.flange_a) annotation (Line(
              points={{10,40},{20,40}}));
          connect(terminalBoxQS.plug_sn, smpmQS.plug_sn) annotation (Line(
              points={{-6,50},{-6,50}},
              color={85,170,255}));
          connect(terminalBoxQS.plug_sp, smpmQS.plug_sp) annotation (Line(
              points={{6,50},{6,50}},
              color={85,170,255}));
          connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
              Line(
              points={{-30,50},{-30,52},{-9,52}},
              color={85,170,255}));
          connect(currentQuasiRMSSensorQS.plug_n, terminalBoxQS.plugSupply)
            annotation (Line(points={{0,80},{0,52}}, color={85,170,255}));
          connect(starMachineQS.pin_n, groundMachineQS.pin) annotation (Line(
              points={{-30,30},{-30,22}},
              color={85,170,255}));
          connect(loadInertiaM.flange_b, torqueStepM.flange)
            annotation (Line(points={{40,-60},{50,-60}}));
          connect(smpm.flange, loadInertiaM.flange_a) annotation (Line(
              points={{10,-60},{20,-60}}));
          connect(terminalBox.plug_sn, smpm.plug_sn) annotation (Line(
              points={{-6,-50},{-6,-50}},
              color={0,0,255}));
          connect(terminalBox.plug_sp, smpm.plug_sp) annotation (Line(
              points={{6,-50},{6,-50}},
              color={0,0,255}));
          connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
            annotation (Line(points={{0,-48},{0,-20}}, color={0,0,255}));
          connect(currentQuasiRMSSensor.plug_p, powerSensor.nc)
            annotation (Line(points={{-20,-20},{-40,-20}}, color={0,0,255}));
          connect(powerSensor.pc, voltageSource.plug_p) annotation (Line(
              points={{-60,-20},{-60,-40}},
              color={0,0,255}));
          connect(powerSensor.pv, powerSensor.pc) annotation (Line(
              points={{-50,-10},{-60,-10},{-60,-20}},
              color={0,0,255}));
          connect(voltageSource.plug_n, star.plug_p) annotation (Line(
              points={{-60,-60},{-60,-70}},
              color={0,0,255}));
          connect(star.pin_n, ground.p) annotation (Line(
              points={{-60,-90},{-70,-90}},
              color={0,0,255}));
          connect(groundMachine.p, terminalBox.starpoint) annotation (Line(
              points={{-30,-78},{-30,-48},{-9,-48}},
              color={0,0,255}));
          connect(powerSensor.nv, star.plug_p) annotation (Line(
              points={{-50,-30},{-50,-70},{-60,-70}},
              color={0,0,255}));
          annotation (Diagram(coordinateSystem(preserveAspectRatio=false,
                  extent={{-100,-100},{100,100}}), graphics={Rectangle(
                          extent={{-90,-2},{90,-100}},
                          lineColor={0,0,0},
                          pattern=LinePattern.Dash,
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid),Rectangle(
                          extent={{-90,100},{90,0}},
                          lineColor={0,0,0},
                          pattern=LinePattern.Dash,
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid)}), experiment(StopTime=
                 1, Interval=2E-4),
            Documentation(info="<html>
<h4>Mains operated permanent magnet synchronous machine loaded with step torque</h4>

<p>
This example compares a time transient and a quasi static model of a permanent magnet synchronous machine. The machines start with zero load and synchronous speed. At time <code>tStep</code> the machines are loaded with nominal torque. </p>

<p>
Simulate for 1 second and plot (versus time):
</p>

<ul>
<li><code>currentRMSsensor.I|currentSensorQS.abs_i[1]</code>: (equivalent) RMS stator current</li>
<li><code>smpm|smpmQS.wMechanical</code>: machine speed</li>
<li><code>smpm|smpmQS.tauElectrical</code>: machine torque</li>
</ul>
</html>"));
        end SMPM_Mains;

        model SMPM_OpenCircuit
          "Test example: PermanentMagnetSynchronousMachine with inverter"
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Integer m=3 "Number of phases";
          output Modelica.SIunits.Voltage Vtr=potentialSensor.phi[1]
            "Transient voltage";
          output Modelica.SIunits.Voltage Vqs=potentialSensorQS.abs_y[1]
            "QS voltage";
          FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet
            smpmQS(
            p=smpmData.p,
            fsNominal=smpmData.fsNominal,
            TsRef=smpmData.TsRef,
            Jr=smpmData.Jr,
            Js=smpmData.Js,
            frictionParameters=smpmData.frictionParameters,
            statorCoreParameters=smpmData.statorCoreParameters,
            strayLoadParameters=smpmData.strayLoadParameters,
            VsOpenCircuit=smpmData.VsOpenCircuit,
            useDamperCage=smpmData.useDamperCage,
            Lrsigmad=smpmData.Lrsigmad,
            Lrsigmaq=smpmData.Lrsigmaq,
            Rrd=smpmData.Rrd,
            Rrq=smpmData.Rrq,
            TrRef=smpmData.TrRef,
            permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
            phiMechanical(start=0),
            m=m,
            TsOperational=293.15,
            Rs=smpmData.Rs*m/3,
            alpha20s=smpmData.alpha20s,
            Lssigma=smpmData.Lssigma*m/3,
            Lmd=smpmData.Lmd*m/3,
            Lmq=smpmData.Lmq*m/3,
            alpha20r=smpmData.alpha20r,
            TrOperational=293.15) annotation (Placement(transformation(extent={
                    {-10,20},{10,40}})));

          Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
            useSupport=false,
            w_fixed(displayUnit="rad/s") = 2*pi*smpmData.fsNominal/smpmData.p,
            phi(start=0, fixed=true)) annotation (Placement(transformation(
                  extent={{80,-10},{60,10}})));
          parameter
            Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
            smpmData(useDamperCage=false) "Machine data"
            annotation (Placement(transformation(extent={{80,80},{100,100}})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starQS(m=m)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-20,50})));
          Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground groundQS
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-50,50})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor
            potentialSensorQS(m=m)
            annotation (Placement(transformation(extent={{10,40},{30,60}})));
          Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet
            smpm(
            p=smpmData.p,
            fsNominal=smpmData.fsNominal,
            TsRef=smpmData.TsRef,
            Jr=smpmData.Jr,
            Js=smpmData.Js,
            frictionParameters=smpmData.frictionParameters,
            statorCoreParameters=smpmData.statorCoreParameters,
            strayLoadParameters=smpmData.strayLoadParameters,
            VsOpenCircuit=smpmData.VsOpenCircuit,
            useDamperCage=smpmData.useDamperCage,
            Lrsigmad=smpmData.Lrsigmad,
            Lrsigmaq=smpmData.Lrsigmaq,
            Rrd=smpmData.Rrd,
            Rrq=smpmData.Rrq,
            TrRef=smpmData.TrRef,
            permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
            m=m,
            TsOperational=293.15,
            Rs=smpmData.Rs*m/3,
            alpha20s=smpmData.alpha20s,
            Lssigma=smpmData.Lssigma*m/3,
            Lszero=smpmData.Lszero*m/3,
            Lmd=smpmData.Lmd*m/3,
            Lmq=smpmData.Lmq*m/3,
            alpha20r=smpmData.alpha20r,
            TrOperational=293.15) annotation (Placement(transformation(extent={
                    {-10,-50},{10,-30}})));

          Modelica.Electrical.MultiPhase.Basic.Star star(m=m) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-20,-20})));
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-50,-20})));
          Modelica.Electrical.MultiPhase.Sensors.PotentialSensor
            potentialSensor(m=m)
            annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor
            resistorQS(m=m, R_ref=fill(1e6*m/3, m))
            annotation (Placement(transformation(extent={{-10,50},{10,70}})));
        equation
          connect(starQS.plug_p, smpmQS.plug_sn) annotation (Line(
              points={{-10,50},{-10,40},{-6,40}},
              color={85,170,255}));
          connect(groundQS.pin, starQS.pin_n) annotation (Line(
              points={{-40,50},{-30,50}},
              color={85,170,255}));
          connect(potentialSensorQS.plug_p, smpmQS.plug_sp) annotation (Line(
              points={{10,50},{10,40},{6,40}},
              color={85,170,255}));
          connect(constantSpeed.flange, smpm.flange) annotation (Line(
              points={{60,0},{50,0},{50,-40},{10,-40}}));
          connect(constantSpeed.flange, smpmQS.flange) annotation (Line(
              points={{60,0},{50,0},{50,30},{10,30}}));
          connect(ground.p, star.pin_n) annotation (Line(
              points={{-40,-20},{-30,-20}},
              color={0,0,255}));
          connect(star.plug_p, smpm.plug_sn) annotation (Line(
              points={{-10,-20},{-10,-30},{-6,-30}},
              color={0,0,255}));
          connect(potentialSensor.plug_p, smpm.plug_sp) annotation (Line(
              points={{10,-20},{10,-30},{6,-30}},
              color={0,0,255}));
          connect(resistorQS.plug_p, smpmQS.plug_sn) annotation (Line(
              points={{-10,60},{-10,40},{-6,40}},
              color={85,170,255}));
          connect(resistorQS.plug_n, smpmQS.plug_sp) annotation (Line(
              points={{10,60},{10,40},{6,40}},
              color={85,170,255}));
          annotation (
            experiment(StopTime=0.1, Interval=0.001),
            Documentation(info="<html>
<h4>Open circuit test of permanent magnet synchronous machine</h4>

<p>
This example compares a time transient and a quasi static model of a permanent magnet synchronous machine. The machines are operated at constant mechanical angular velocity.</p>

<p>
Simulate for 0.1 second and plot (versus time):
</p>

<ul>
<li><code>potentialSenor.phi|potentialSensorQS.abs_y[1]</code>: potential of terminal</li>
</ul>

<h5>Note</h5>
<p>The resistors connected to the terminals of the windings of the quasi static machine model are necessary to numerically stabilize the simulation.</p>
</html>"),  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={Rectangle(
                          extent={{-60,-4},{40,-80}},
                          lineColor={0,0,0},
                          pattern=LinePattern.Dash,
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid),Rectangle(
                          extent={{-60,80},{40,4}},
                          lineColor={0,0,0},
                          pattern=LinePattern.Dash,
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid)}));
        end SMPM_OpenCircuit;

        model SMPM_CurrentSource
          "Test example: PermanentMagnetSynchronousMachine fed by current source"
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Integer m=3 "Number of phases";
          parameter Modelica.SIunits.Voltage VNominal=100
            "Nominal RMS voltage per phase";
          parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
          parameter Modelica.SIunits.Frequency f=50 "Actual frequency";
          parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
          parameter Modelica.SIunits.Torque TLoad=181.4 "Nominal load torque";
          parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
          parameter Modelica.SIunits.Inertia JLoad=0.29
            "Load's moment of inertia";
          Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet
            smpm(
            p=smpmData.p,
            fsNominal=smpmData.fsNominal,
            TsOperational=293.15,
            Rs=smpmData.Rs,
            TsRef=smpmData.TsRef,
            alpha20s=smpmData.alpha20s,
            Lszero=smpmData.Lszero,
            Lssigma=smpmData.Lssigma,
            Jr=smpmData.Jr,
            Js=smpmData.Js,
            frictionParameters=smpmData.frictionParameters,
            phiMechanical(fixed=true),
            wMechanical(fixed=true),
            statorCoreParameters=smpmData.statorCoreParameters,
            strayLoadParameters=smpmData.strayLoadParameters,
            TrOperational=293.15,
            VsOpenCircuit=smpmData.VsOpenCircuit,
            Lmd=smpmData.Lmd,
            Lmq=smpmData.Lmq,
            useDamperCage=smpmData.useDamperCage,
            Lrsigmad=smpmData.Lrsigmad,
            Lrsigmaq=smpmData.Lrsigmaq,
            Rrd=smpmData.Rrd,
            Rrq=smpmData.Rrq,
            TrRef=smpmData.TrRef,
            alpha20r=smpmData.alpha20r,
            permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters)
            annotation (Placement(transformation(extent={{-10,-92},{10,-72}})));
          Modelica.Electrical.MultiPhase.Sources.SignalCurrent signalCurrent(
              final m=m) annotation (Placement(transformation(
                origin={0,-18},
                extent={{-10,10},{10,-10}},
                rotation=270)));
          Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
             Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=90,
                origin={40,-18})));
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(
                origin={40,-38},
                extent={{-10,-10},{10,10}})));
          Modelica.Electrical.Machines.Utilities.CurrentController
            currentController(p=smpm.p)
            annotation (Placement(transformation(extent={{-50,-28},{-30,-8}})));
          Modelica.Blocks.Sources.Constant iq(k=84.6) annotation (Placement(
                transformation(extent={{-100,-30},{-80,-10}})));
          Modelica.Blocks.Sources.Constant id(k=-53.5)
            annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
          Modelica.Electrical.MultiPhase.Sensors.VoltageQuasiRMSSensor
            voltageQuasiRMSSensor annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-20,-58})));
          Modelica.Electrical.MultiPhase.Basic.Star starM(final m=m)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-40,-58})));
          Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
                transformation(
                origin={-50,-80},
                extent={{-10,-10},{10,10}})));
          Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
              terminalConnection="Y") annotation (Placement(transformation(
                  extent={{-10,-76},{10,-56}})));
          Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle
            rotorDisplacementAngle(p=smpm.p) annotation (Placement(
                transformation(
                origin={30,-82},
                extent={{-10,10},{10,-10}},
                rotation=270)));
          Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={20,-52})));
          Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(J=0.29)
            annotation (Placement(transformation(extent={{40,-92},{60,-72}})));
          Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
            quadraticSpeedDependentTorque(tau_nominal=-181.4, w_nominal(
                displayUnit="rpm") = 157.07963267949)
            annotation (Placement(transformation(extent={{90,-92},{70,-72}})));
          parameter
            Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
            smpmData(useDamperCage=false) "Machine data"
            annotation (Placement(transformation(extent={{70,-18},{90,2}})));
          Modelica.Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor currentRMSsensor
            annotation (Placement(transformation(
                origin={0,-48},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet
            smpmQS(
            p=smpmData.p,
            fsNominal=smpmData.fsNominal,
            Rs=smpmData.Rs,
            TsRef=smpmData.TsRef,
            Lssigma=smpmData.Lssigma,
            Jr=smpmData.Jr,
            Js=smpmData.Js,
            frictionParameters=smpmData.frictionParameters,
            wMechanical(fixed=true),
            statorCoreParameters=smpmData.statorCoreParameters,
            strayLoadParameters=smpmData.strayLoadParameters,
            VsOpenCircuit=smpmData.VsOpenCircuit,
            Lmd=smpmData.Lmd,
            Lmq=smpmData.Lmq,
            useDamperCage=smpmData.useDamperCage,
            Lrsigmad=smpmData.Lrsigmad,
            Lrsigmaq=smpmData.Lrsigmaq,
            Rrd=smpmData.Rrd,
            Rrq=smpmData.Rrq,
            TrRef=smpmData.TrRef,
            permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
            TsOperational=293.15,
            alpha20s=smpmData.alpha20s,
            phiMechanical(fixed=true, start=0),
            alpha20r=smpmData.alpha20r,
            TrOperational=293.15) annotation (Placement(transformation(extent={
                    {-10,24},{10,44}})));

          Modelica.Mechanics.Rotational.Components.Inertia inertiaLoadQS(J=0.29)
            annotation (Placement(transformation(extent={{40,24},{60,44}})));
          Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
            quadraticSpeedDependentTorqueQS(tau_nominal=-181.4, w_nominal(
                displayUnit="rpm") = 157.07963267949)
            annotation (Placement(transformation(extent={{90,24},{70,44}})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star
            starMachineQS(m=
                Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m))
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={-30,44})));
          Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
            groundMQS annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-50,44})));
          Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox
            terminalBoxQS(terminalConnection="Y", m=m) annotation (Placement(
                transformation(extent={{-10,40},{10,60}})));
          Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.CurrentController
            currentController1(m=m, p=smpmQS.p)
            annotation (Placement(transformation(extent={{-50,74},{-30,94}})));
          Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensorQS
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={20,54})));
          Electrical.QuasiStationary.MultiPhase.Sources.ReferenceCurrentSource
            referenceCurrentSource annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=90,
                origin={0,84})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starQS(m=m)
            annotation (Placement(transformation(
                origin={40,84},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
            groundeQS annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={40,64})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor
            resistor(m=m, R_ref=fill(1e5, m)) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={20,84})));
        equation
          connect(star.pin_n, ground.p)
            annotation (Line(points={{40,-28},{40,-28}}, color={0,0,255}));
          connect(rotorDisplacementAngle.plug_n, smpm.plug_sn) annotation (Line(
                points={{36,-72},{36,-66},{-6,-66},{-6,-72}}, color={0,0,255}));
          connect(rotorDisplacementAngle.plug_p, smpm.plug_sp)
            annotation (Line(points={{24,-72},{6,-72}}, color={0,0,255}));
          connect(terminalBox.plug_sn, smpm.plug_sn) annotation (Line(
              points={{-6,-72},{-6,-72}},
              color={0,0,255}));
          connect(terminalBox.plug_sp, smpm.plug_sp) annotation (Line(
              points={{6,-72},{6,-72}},
              color={0,0,255}));
          connect(smpm.flange, rotorDisplacementAngle.flange) annotation (Line(
              points={{10,-82},{20,-82}}));
          connect(signalCurrent.plug_p, star.plug_p) annotation (Line(
              points={{0,-8},{40,-8}},
              color={0,0,255}));
          connect(angleSensor.flange, rotorDisplacementAngle.flange)
            annotation (Line(
              points={{20,-62},{20,-82}}));
          connect(angleSensor.phi, currentController.phi) annotation (Line(
              points={{20,-41},{20,-36},{-40,-36},{-40,-30}},
              color={0,0,127}));
          connect(id.y, currentController.id_rms) annotation (Line(
              points={{-79,20},{-74,20},{-74,-12},{-52,-12}},
              color={0,0,127}));
          connect(iq.y, currentController.iq_rms) annotation (Line(
              points={{-79,-20},{-70,-20},{-70,-24},{-52,-24}},
              color={0,0,127}));
          connect(groundM.p, terminalBox.starpoint) annotation (Line(
              points={{-50,-70},{-9,-70}},
              color={0,0,255}));
          connect(voltageQuasiRMSSensor.plug_p, terminalBox.plugSupply)
            annotation (Line(
              points={{-10,-58},{0,-58},{0,-70}},
              color={0,0,255}));
          connect(starM.plug_p, voltageQuasiRMSSensor.plug_n) annotation (Line(
              points={{-30,-58},{-30,-58}},
              color={0,0,255}));
          connect(starM.pin_n, groundM.p) annotation (Line(
              points={{-50,-58},{-50,-70}},
              color={0,0,255}));
          connect(currentController.y, signalCurrent.i) annotation (Line(
              points={{-29,-18},{-7,-18}},
              color={0,0,127}));
          connect(quadraticSpeedDependentTorque.flange, inertiaLoad.flange_b)
            annotation (Line(
              points={{70,-82},{60,-82}}));
          connect(signalCurrent.plug_n, currentRMSsensor.plug_p) annotation (
              Line(
              points={{0,-28},{0,-38}},
              color={0,0,255}));
          connect(currentRMSsensor.plug_n, voltageQuasiRMSSensor.plug_p)
            annotation (Line(
              points={{0,-58},{-10,-58}},
              color={0,0,255}));
          connect(smpm.flange, inertiaLoad.flange_a) annotation (Line(
              points={{10,-82},{10,-88},{20,-88},{20,-82},{40,-82}}));
          connect(quadraticSpeedDependentTorqueQS.flange, inertiaLoadQS.flange_b)
            annotation (Line(
              points={{70,34},{60,34}}));
          connect(smpmQS.flange, inertiaLoadQS.flange_a) annotation (Line(
              points={{10,34},{40,34}}));
          connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
              Line(
              points={{-20,44},{-20,46},{-9,46}},
              color={85,170,255}));
          connect(groundMQS.pin, starMachineQS.pin_n) annotation (Line(
              points={{-40,44},{-40,44}},
              color={85,170,255}));
          connect(terminalBoxQS.plug_sn, smpmQS.plug_sn) annotation (Line(
              points={{-6,44},{-6,44}},
              color={85,170,255}));
          connect(terminalBoxQS.plug_sp, smpmQS.plug_sp) annotation (Line(
              points={{6,44},{6,44}},
              color={85,170,255}));
          connect(angleSensorQS.phi, currentController1.phi) annotation (Line(
              points={{20,65},{20,68},{-40,68},{-40,72}},
              color={0,0,127}));
          connect(currentController1.I, referenceCurrentSource.I) annotation (
              Line(
              points={{-29,88},{-10,88}},
              color={85,170,255}));
          connect(referenceCurrentSource.plug_p, starQS.plug_p) annotation (
              Line(
              points={{0,94},{40,94}},
              color={85,170,255}));
          connect(starQS.pin_n, groundeQS.pin) annotation (Line(
              points={{40,74},{40,74}},
              color={85,170,255}));
          connect(currentController1.id_rms, id.y) annotation (Line(
              points={{-52,90},{-74,90},{-74,20},{-79,20}},
              color={0,0,127}));
          connect(iq.y, currentController1.iq_rms) annotation (Line(
              points={{-79,-20},{-70,-20},{-70,78},{-52,78}},
              color={0,0,127}));
          connect(angleSensorQS.flange, smpmQS.flange) annotation (Line(
              points={{20,44},{20,34},{10,34}}));
          connect(currentController1.gamma, referenceCurrentSource.gamma)
            annotation (Line(
              points={{-29,80},{-10,80}},
              color={0,0,127}));
          connect(referenceCurrentSource.plug_n, terminalBoxQS.plugSupply)
            annotation (Line(
              points={{0,74},{0,46}},
              color={85,170,255}));
          connect(referenceCurrentSource.plug_p, resistor.plug_p) annotation (
              Line(
              points={{0,94},{20,94}},
              color={85,170,255}));
          connect(resistor.plug_n, referenceCurrentSource.plug_n) annotation (
              Line(
              points={{20,74},{0,74}},
              color={85,170,255}));
          annotation (
            experiment(StopTime=2.0, Interval=0.001),
            Documentation(info="<html>
<h4>Simple field oriented control of permanent magnet synchronous machine</h4>

<p>
This example compares a time transient and a quasi static model of a permanent magnet synchronous machine. The machines are fed by a current source. The current components are oriented at the magnetic field orientation and transformed to the stator fixed reference frame. This way the machines are operated at constant torque. The machines start to accelerate from standstill.</p>

<p>
Simulate for 2 seconds and plot (versus time):
</p>

<ul>
<li><code>smpm|smpmQS.wMechanical</code>: machine speed</li>
<li><code>smpm|smpmQS.tauElectrical</code>: machine torque</li>
</ul>

<h5>Note</h5>
<p>The resistors connected to the terminals of the windings of the quasi static machine model are necessary to numerically stabilize the simulation.</p>
</html>"),  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}),
                                 graphics={Rectangle(
                          extent={{-64,100},{100,14}},
                          lineColor={0,0,0},
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid,
                          pattern=LinePattern.Dash),Rectangle(
                          extent={{-64,12},{100,-100}},
                          lineColor={0,0,0},
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid,
                          pattern=LinePattern.Dash)}));
        end SMPM_CurrentSource;

        model SMEE_Generator
          "Electrical excited synchronous machine operating as generator"
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Integer m=3 "Number of stator phases";
          parameter Modelica.SIunits.Voltage VsNominal=100
            "Nominal RMS voltage per phase";
          parameter Modelica.SIunits.Frequency fsNominal=50 "Nominal frequency";
          parameter Modelica.SIunits.AngularVelocity w=
              Modelica.SIunits.Conversions.from_rpm(1499) "Nominal speed";
          parameter Modelica.SIunits.Current Ie=19 "Excitation current";
          parameter Modelica.SIunits.Current Ie0=10
            "Initial excitation current";
          parameter Modelica.SIunits.Angle gamma0(displayUnit="deg") = 0
            "Initial rotor displacement angle";
          output Modelica.SIunits.Power Ptr=powerSensor.power "Transient power";
          output Modelica.SIunits.Power Pqs=powerSensorQS.y.re "QS power";
          Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
             Placement(transformation(extent={{-50,-30},{-70,-10}})));
          Modelica.Electrical.Analog.Basic.Ground grounde annotation (Placement(
                transformation(
                origin={-90,-20},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
            final m=m,
            final V=fill(VsNominal*sqrt(2), m),
            final freqHz=fill(fsNominal, m)) annotation (Placement(
                transformation(extent={{-20,-30},{-40,-10}})));
          Modelica.Electrical.MultiPhase.Sensors.PowerSensor powerSensor(m=m)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={0,-34})));
          Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(
              terminalConnection="Y", m=m) annotation (Placement(transformation(
                  extent={{-10,-64},{10,-44}})));
          Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited
            smee(
            phiMechanical(start=-(Modelica.Constants.pi + gamma0)/smee.p, fixed=
                 true),
            Jr=0.29,
            Js=0.29,
            p=2,
            fsNominal=smeeData.fsNominal,
            TsRef=smeeData.TsRef,
            alpha20s(displayUnit="1/K") = smeeData.alpha20s,
            Lrsigmad=smeeData.Lrsigmad,
            Lrsigmaq=smeeData.Lrsigmaq,
            Rrd=smeeData.Rrd,
            Rrq=smeeData.Rrq,
            TrRef=smeeData.TrRef,
            alpha20r(displayUnit="1/K") = smeeData.alpha20r,
            VsNominal=smeeData.VsNominal,
            IeOpenCircuit=smeeData.IeOpenCircuit,
            Re=smeeData.Re,
            TeRef=smeeData.TeRef,
            alpha20e(displayUnit="1/K") = smeeData.alpha20e,
            sigmae=smeeData.sigmae,
            statorCoreParameters(VRef=100),
            strayLoadParameters(IRef=100),
            brushParameters(ILinear=0.01),
            ir(fixed=true),
            useDamperCage=false,
            m=m,
            frictionParameters(PRef=0),
            Rs=smeeData.Rs*m/3,
            Lssigma=smeeData.Lssigma*m/3,
            Lmd=smeeData.Lmd*m/3,
            Lmq=smeeData.Lmq*m/3,
            TsOperational=293.15,
            TrOperational=293.15,
            TeOperational=293.15) annotation (Placement(transformation(extent={
                    {-10,-80},{10,-60}})));
          FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited
            smeeQS(
            p=2,
            fsNominal=smeeData.fsNominal,
            TsRef=smeeData.TsRef,
            alpha20s(displayUnit="1/K") = smeeData.alpha20s,
            Jr=0.29,
            Js=0.29,
            frictionParameters(PRef=0),
            statorCoreParameters(PRef=0, VRef=100),
            strayLoadParameters(PRef=0, IRef=100),
            Lrsigmad=smeeData.Lrsigmad,
            Rrd=smeeData.Rrd,
            Rrq=smeeData.Rrq,
            alpha20r(displayUnit="1/K") = smeeData.alpha20r,
            VsNominal=smeeData.VsNominal,
            IeOpenCircuit=smeeData.IeOpenCircuit,
            Re=smeeData.Re,
            TeRef=smeeData.TeRef,
            alpha20e(displayUnit="1/K") = smeeData.alpha20e,
            brushParameters(V=0, ILinear=0.01),
            Lrsigmaq=smeeData.Lrsigmaq,
            TrRef=smeeData.TrRef,
            useDamperCage=false,
            m=m,
            gammar(fixed=true, start=pi/2),
            gamma(fixed=true, start=-pi/2),
            TsOperational=293.15,
            Rs=smeeData.Rs*m/3,
            Lssigma=smeeData.Lssigma*m/3,
            Lmd=smeeData.Lmd*m/3,
            Lmq=smeeData.Lmq*m/3,
            TrOperational=293.15,
            TeOperational=293.15) annotation (Placement(transformation(extent={
                    {-10,20},{10,40}})));
          Modelica.Electrical.Analog.Basic.Ground groundr annotation (Placement(
                transformation(
                origin={-50,-88},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Basic.Ground groundrQS annotation (
              Placement(transformation(
                origin={-50,12},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Analog.Sources.RampCurrent rampCurrent(
            duration=0.1,
            I=Ie - Ie0,
            offset=Ie0) annotation (Placement(transformation(
                origin={-30,-70},
                extent={{-10,-10},{10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Sources.RampCurrent rampCurrentQS(
            duration=0.1,
            I=Ie - Ie0,
            offset=Ie0) annotation (Placement(transformation(
                origin={-28,30},
                extent={{-10,-10},{10,10}},
                rotation=90)));
          Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
            mechanicalPowerSensor annotation (Placement(transformation(extent={
                    {20,-80},{40,-60}})));
          Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
            mechanicalPowerSensorQS annotation (Placement(transformation(extent=
                   {{20,20},{40,40}})));
          Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
              final w_fixed=w, useSupport=false) annotation (Placement(
                transformation(extent={{70,-80},{50,-60}})));
          Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeedQS(
              final w_fixed=w, useSupport=false) annotation (Placement(
                transformation(extent={{70,20},{50,40}})));
          parameter
            Modelica.Electrical.Machines.Utilities.SynchronousMachineData
            smeeData(
            SNominal=30e3,
            VsNominal=100,
            fsNominal=50,
            IeOpenCircuit=10,
            x0=0.1,
            xd=1.6,
            xdTransient=0.1375,
            xdSubtransient=0.121428571,
            xqSubtransient=0.148387097,
            Ta=0.014171268,
            Td0Transient=0.261177343,
            Td0Subtransient=0.006963029,
            Tq0Subtransient=0.123345081,
            alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
            alpha20r(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
            alpha20e(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
            xq=1.1,
            TsSpecification=293.15,
            TsRef=293.15,
            TrSpecification=293.15,
            TrRef=293.15,
            TeSpecification=293.15,
            TeRef=293.15) "Machine data"
            annotation (Placement(transformation(extent={{70,70},{90,90}})));

          Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource
            voltageSourceQS(
            m=m,
            phi=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(
                m),
            V=fill(VsNominal, m),
            f=fsNominal) annotation (Placement(transformation(
                origin={-30,80},
                extent={{-10,-10},{10,10}},
                rotation=180)));
          Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starQS(m=m)
            annotation (Placement(transformation(
                origin={-60,80},
                extent={{-10,-10},{10,10}},
                rotation=180)));
          Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
            groundeQS annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-90,80})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor
            powerSensorQS(m=m) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={0,66})));
          Utilities.MultiTerminalBox terminalBoxQS(m=m, terminalConnection="Y")
            annotation (Placement(transformation(extent={{-10,36},{10,56}})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star
            starMachineQS(m=
                Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m))
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={-20,50})));
          Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
            groundMachineQS annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-50,50})));
        initial equation
          smee.is[1:2] = zeros(2);

        equation
          connect(star.pin_n, grounde.p)
            annotation (Line(points={{-70,-20},{-80,-20}}, color={0,0,255}));
          connect(star.plug_p, sineVoltage.plug_n)
            annotation (Line(points={{-50,-20},{-40,-20}}, color={0,0,255}));
          connect(smeeQS.flange, mechanicalPowerSensorQS.flange_a)
            annotation (Line(points={{10,30},{20,30}}));
          connect(mechanicalPowerSensorQS.flange_b, constantSpeedQS.flange)
            annotation (Line(points={{40,30},{50,30}}));
          connect(rampCurrentQS.p, groundrQS.p) annotation (Line(points={{-28,
                  20},{-34,20},{-34,12},{-40,12}}, color={0,0,255}));
          connect(rampCurrentQS.p, smeeQS.pin_en) annotation (Line(points={{-28,
                  20},{-20,20},{-20,24},{-10,24}}, color={0,0,255}));
          connect(rampCurrentQS.n, smeeQS.pin_ep) annotation (Line(points={{-28,
                  40},{-20,40},{-20,36},{-10,36}}, color={0,0,255}));
          connect(smee.flange, mechanicalPowerSensor.flange_a)
            annotation (Line(points={{10,-70},{20,-70}}));
          connect(mechanicalPowerSensor.flange_b, constantSpeed.flange)
            annotation (Line(points={{40,-70},{50,-70}}));
          connect(rampCurrent.p, groundr.p) annotation (Line(points={{-30,-80},
                  {-36,-80},{-36,-88},{-38,-88},{-38,-88},{-40,-88},{-40,-88}},
                color={0,0,255}));
          connect(rampCurrent.p, smee.pin_en) annotation (Line(points={{-30,-80},
                  {-20,-80},{-20,-76},{-10,-76}}, color={0,0,255}));
          connect(rampCurrent.n, smee.pin_ep) annotation (Line(points={{-30,-60},
                  {-20,-60},{-20,-64},{-10,-64}}, color={0,0,255}));
          connect(smee.plug_sn, terminalBoxM.plug_sn)
            annotation (Line(points={{-6,-60},{-6,-60}}, color={0,0,255}));
          connect(smee.plug_sp, terminalBoxM.plug_sp)
            annotation (Line(points={{6,-60},{6,-60}}, color={0,0,255}));
          connect(groundeQS.pin, starQS.pin_n) annotation (Line(points={{-80,80},
                  {-80,80},{-70,80}}, color={85,170,255}));
          connect(starQS.plug_p, voltageSourceQS.plug_n) annotation (Line(
                points={{-50,80},{-50,80},{-40,80}}, color={85,170,255}));
          connect(voltageSourceQS.plug_p, powerSensorQS.currentP) annotation (
              Line(points={{-20,80},{-20,80},{0,80},{0,76}},
                color={85,170,255}));
          connect(powerSensorQS.voltageP, powerSensorQS.currentP) annotation (
              Line(points={{10,66},{10,76},{0,76}}, color={85,170,255}));
          connect(powerSensorQS.voltageN, starQS.plug_p) annotation (Line(
                points={{-10,66},{-10,66},{-42,66},{-50,66},{-50,80}}, color={
                  85,170,255}));
          connect(sineVoltage.plug_p, powerSensor.pc)
            annotation (Line(points={{-20,-20},{0,-20},{0,-24}}, color={0,0,255}));
          connect(powerSensor.pc, powerSensor.pv)
            annotation (Line(points={{0,-24},{10,-24},{10,-34}}, color={0,0,255}));
          connect(powerSensor.nv, star.plug_p)
            annotation (Line(points={{-10,-34},{-50,-34},{-50,-20}}, color={0,0,255}));
          connect(powerSensor.nc, terminalBoxM.plugSupply)
            annotation (Line(points={{0,-44},{0,-58}}, color={0,0,255}));
          connect(terminalBoxQS.plug_sn, smeeQS.plug_sn) annotation (Line(
              points={{-6,40},{-6,40}},
              color={85,170,255}));
          connect(terminalBoxQS.plug_sp, smeeQS.plug_sp) annotation (Line(
              points={{6,40},{6,40}},
              color={85,170,255}));
          connect(powerSensorQS.currentN, terminalBoxQS.plugSupply) annotation (
             Line(
              points={{0,56},{0,42}},
              color={85,170,255}));
          connect(starMachineQS.pin_n, groundMachineQS.pin) annotation (Line(
              points={{-30,50},{-40,50}},
              color={85,170,255}));
          connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
              Line(
              points={{-10,50},{-10,42},{-9,42}},
              color={85,170,255}));
          annotation (
            experiment(
              StopTime=30,
              Interval=0.005,
              Tolerance=1e-06),
            Documentation(info="<html>
<h4>Electrically excited synchronous machine as generator</h4>
<p>
This example compares a time transient and a quasi static model of a electrically excited synchronous machine. The electrically excited synchronous generators are connected to the grid and driven with constant speed.
Since speed is slightly smaller than synchronous speed corresponding to mains frequency,
rotor angle is very slowly increased. This allows to see several characteristics dependent on rotor angle.
</p>

<p>
Simulate for 30 seconds:
</p>

<ul>
<li><code>smpm|smpmQS.tauElectrical</code>: machine torque</li>
</ul>

<p>Since the rotor slip is very low the transient and quasi static electro magnetic torque are practically equal.</p>
</html>"),  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}),
                                 graphics={Rectangle(
                          extent={{-100,-6},{100,-96}},
                          lineColor={0,0,255},
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid,
                          pattern=LinePattern.Dash),Rectangle(
                          extent={{-100,94},{100,0}},
                          lineColor={0,0,255},
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid,
                          pattern=LinePattern.Dash),Text(
                          extent={{20,10},{100,2}},
                          lineColor={0,0,0},
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid,
                          textStyle={TextStyle.Bold},
                          textString="%m phase QS
"),             Text(
                  extent={{20,-10},{100,-18}},
                          lineColor={0,0,0},
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid,
                          textStyle={TextStyle.Bold},
                          textString="%m phase transient
")}));
        end SMEE_Generator;

        model SMR_CurrentSource
          "Test example: Synchronous reluctance machine fed by current source"
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Integer m=3 "Number of phases";
          parameter Modelica.SIunits.Voltage VNominal=100
            "Nominal RMS voltage per phase";
          parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
          parameter Modelica.SIunits.Frequency f=50 "Actual frequency";
          parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
          parameter Modelica.SIunits.Torque TLoad=181.4 "Nominal load torque";
          parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
          parameter Modelica.SIunits.Inertia JLoad=0.29
            "Load's moment of inertia";
          Modelica.Electrical.MultiPhase.Sources.SignalCurrent signalCurrent(
              final m=m) annotation (Placement(transformation(
                origin={0,-18},
                extent={{-10,10},{10,-10}},
                rotation=270)));
          Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
             Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=90,
                origin={40,-18})));
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(
                origin={40,-38},
                extent={{-10,-10},{10,10}})));
          Modelica.Electrical.Machines.Utilities.CurrentController
            currentController(p=smr.p)
            annotation (Placement(transformation(extent={{-50,-28},{-30,-8}})));
          Modelica.Blocks.Sources.Constant iq(k=84.6) annotation (Placement(
                transformation(extent={{-100,-30},{-80,-10}})));
          Modelica.Blocks.Sources.Constant id(k=53.5)
            annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
          Modelica.Electrical.MultiPhase.Sensors.VoltageQuasiRMSSensor
            voltageQuasiRMSSensor annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-20,-58})));
          Modelica.Electrical.MultiPhase.Basic.Star starM(final m=m)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-40,-58})));
          Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
                transformation(
                origin={-50,-80},
                extent={{-10,-10},{10,10}})));
          Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
              terminalConnection="Y") annotation (Placement(transformation(
                  extent={{-10,-76},{10,-56}})));
          Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle
            rotorDisplacementAngle(p=smr.p) annotation (Placement(
                transformation(
                origin={30,-82},
                extent={{-10,10},{10,-10}},
                rotation=270)));
          Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={20,-52})));
          Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(J=0.29)
            annotation (Placement(transformation(extent={{44,-92},{64,-72}})));
          Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
            quadraticSpeedDependentTorque(
            tau_nominal=-181.4,
            w_nominal(displayUnit="rpm") = 157.07963267949,
            TorqueDirection=false)
            annotation (Placement(transformation(extent={{90,-92},{70,-72}})));
          Modelica.Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor currentRMSsensor
            annotation (Placement(transformation(
                origin={0,-48},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Mechanics.Rotational.Components.Inertia inertiaLoadQS(J=0.29)
            annotation (Placement(transformation(extent={{40,24},{60,44}})));
          Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
            quadraticSpeedDependentTorqueQS(
            tau_nominal=-181.4,
            w_nominal(displayUnit="rpm") = 157.07963267949,
            TorqueDirection=false)
            annotation (Placement(transformation(extent={{90,24},{70,44}})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star
            starMachineQS(m=
                Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m))
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={-30,44})));
          Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
            groundMQS annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-50,44})));
          Utilities.MultiTerminalBox terminalBoxQS(terminalConnection="Y", m=m)
            annotation (Placement(transformation(extent={{-10,40},{10,60}})));
          FundamentalWave.Utilities.CurrentController currentController1(m=m, p=
               smrQS.p)
            annotation (Placement(transformation(extent={{-50,74},{-30,94}})));
          Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensorQS
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={20,54})));
          Electrical.QuasiStationary.MultiPhase.Sources.ReferenceCurrentSource
            referenceCurrentSource annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=90,
                origin={0,84})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starQS(m=m)
            annotation (Placement(transformation(
                origin={40,84},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
            groundeQS annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={40,64})));
          Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor
            resistor(m=m, R_ref=fill(1e5, m)) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={20,84})));
          parameter
            Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_ReluctanceRotorData
            smrData(useDamperCage=false)
            annotation (Placement(transformation(extent={{70,70},{90,90}})));
          FundamentalWave.BasicMachines.SynchronousMachines.SM_ReluctanceRotor
            smrQS(
            p=smrData.p,
            fsNominal=smrData.fsNominal,
            TsRef=smrData.TsRef,
            alpha20s(displayUnit="1/K") = smrData.alpha20s,
            Jr=smrData.Jr,
            Js=smrData.Js,
            frictionParameters=smrData.frictionParameters,
            statorCoreParameters=smrData.statorCoreParameters,
            strayLoadParameters=smrData.strayLoadParameters,
            Lrsigmad=smrData.Lrsigmad,
            Lrsigmaq=smrData.Lrsigmaq,
            Rrd=smrData.Rrd,
            Rrq=smrData.Rrq,
            TrRef=smrData.TrRef,
            alpha20r(displayUnit="1/K") = smrData.alpha20r,
            Rs=smrData.Rs*m/3,
            Lssigma=smrData.Lssigma*m/3,
            Lmd=smrData.Lmd*m/3,
            Lmq=smrData.Lmq*m/3,
            m=m,
            gammar(start=pi/2),
            gamma(start=-pi/2),
            useDamperCage=smrData.useDamperCage,
            wMechanical(start=0, fixed=true),
            TsOperational=293.15,
            phiMechanical(start=0, fixed=true),
            TrOperational=293.15) annotation (Placement(transformation(extent={
                    {-10,24},{10,44}})));
          Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor
            smr(
            Jr=smrData.Jr,
            Js=smrData.Js,
            p=smrData.p,
            fsNominal=smrData.fsNominal,
            TsRef=smrData.TsRef,
            alpha20s(displayUnit="1/K") = smrData.alpha20s,
            frictionParameters=smrData.frictionParameters,
            statorCoreParameters=smrData.statorCoreParameters,
            strayLoadParameters=smrData.strayLoadParameters,
            phiMechanical(fixed=true),
            wMechanical(fixed=true),
            Lrsigmad=smrData.Lrsigmad,
            Lrsigmaq=smrData.Lrsigmaq,
            Rrd=smrData.Rrd,
            Rrq=smrData.Rrq,
            TrRef=smrData.TrRef,
            alpha20r(displayUnit="1/K") = smrData.alpha20r,
            ir(fixed=true),
            m=m,
            Rs=smrData.Rs*m/3,
            Lssigma=smrData.Lssigma*m/3,
            Lszero=smrData.Lszero*m/3,
            Lmd=smrData.Lmd*m/3,
            Lmq=smrData.Lmq*m/3,
            TsOperational=293.15,
            TrOperational=293.15,
            useDamperCage=smrData.useDamperCage) annotation (Placement(
                transformation(extent={{-10,-92},{10,-72}})));
        equation
          connect(star.pin_n, ground.p)
            annotation (Line(points={{40,-28},{40,-28}}, color={0,0,255}));
          connect(signalCurrent.plug_p, star.plug_p) annotation (Line(
              points={{0,-8},{40,-8}},
              color={0,0,255}));
          connect(angleSensor.flange, rotorDisplacementAngle.flange)
            annotation (Line(
              points={{20,-62},{20,-82}}));
          connect(angleSensor.phi, currentController.phi) annotation (Line(
              points={{20,-41},{20,-36},{-40,-36},{-40,-30}},
              color={0,0,127}));
          connect(id.y, currentController.id_rms) annotation (Line(
              points={{-79,20},{-74,20},{-74,-12},{-52,-12}},
              color={0,0,127}));
          connect(iq.y, currentController.iq_rms) annotation (Line(
              points={{-79,-20},{-70,-20},{-70,-24},{-52,-24}},
              color={0,0,127}));
          connect(groundM.p, terminalBox.starpoint) annotation (Line(
              points={{-50,-70},{-9,-70}},
              color={0,0,255}));
          connect(voltageQuasiRMSSensor.plug_p, terminalBox.plugSupply)
            annotation (Line(
              points={{-10,-58},{0,-58},{0,-70}},
              color={0,0,255}));
          connect(starM.plug_p, voltageQuasiRMSSensor.plug_n) annotation (Line(
              points={{-30,-58},{-30,-58}},
              color={0,0,255}));
          connect(starM.pin_n, groundM.p) annotation (Line(
              points={{-50,-58},{-50,-70}},
              color={0,0,255}));
          connect(currentController.y, signalCurrent.i) annotation (Line(
              points={{-29,-18},{-7,-18}},
              color={0,0,127}));
          connect(quadraticSpeedDependentTorque.flange, inertiaLoad.flange_b)
            annotation (Line(
              points={{70,-82},{64,-82}}));
          connect(signalCurrent.plug_n, currentRMSsensor.plug_p) annotation (
              Line(
              points={{0,-28},{0,-38}},
              color={0,0,255}));
          connect(currentRMSsensor.plug_n, voltageQuasiRMSSensor.plug_p)
            annotation (Line(
              points={{0,-58},{-10,-58}},
              color={0,0,255}));
          connect(quadraticSpeedDependentTorqueQS.flange, inertiaLoadQS.flange_b)
            annotation (Line(
              points={{70,34},{60,34}}));
          connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
              Line(
              points={{-20,44},{-20,46},{-9,46}},
              color={85,170,255}));
          connect(groundMQS.pin, starMachineQS.pin_n) annotation (Line(
              points={{-40,44},{-40,44}},
              color={85,170,255}));
          connect(angleSensorQS.phi, currentController1.phi) annotation (Line(
              points={{20,65},{20,68},{-40,68},{-40,72}},
              color={0,0,127}));
          connect(currentController1.I, referenceCurrentSource.I) annotation (
              Line(
              points={{-29,88},{-10,88}},
              color={85,170,255}));
          connect(referenceCurrentSource.plug_p, starQS.plug_p) annotation (
              Line(
              points={{0,94},{40,94}},
              color={85,170,255}));
          connect(starQS.pin_n, groundeQS.pin) annotation (Line(
              points={{40,74},{40,74}},
              color={85,170,255}));
          connect(currentController1.id_rms, id.y) annotation (Line(
              points={{-52,90},{-74,90},{-74,20},{-79,20}},
              color={0,0,127}));
          connect(iq.y, currentController1.iq_rms) annotation (Line(
              points={{-79,-20},{-70,-20},{-70,78},{-52,78}},
              color={0,0,127}));
          connect(currentController1.gamma, referenceCurrentSource.gamma)
            annotation (Line(
              points={{-29,80},{-10,80}},
              color={0,0,127}));
          connect(referenceCurrentSource.plug_n, terminalBoxQS.plugSupply)
            annotation (Line(
              points={{0,74},{0,46}},
              color={85,170,255}));
          connect(referenceCurrentSource.plug_p, resistor.plug_p) annotation (
              Line(
              points={{0,94},{20,94}},
              color={85,170,255}));
          connect(resistor.plug_n, referenceCurrentSource.plug_n) annotation (
              Line(
              points={{20,74},{0,74}},
              color={85,170,255}));
          connect(terminalBoxQS.plug_sn, smrQS.plug_sn) annotation (Line(
              points={{-6,44},{-6,44}},
              color={85,170,255}));
          connect(terminalBoxQS.plug_sp, smrQS.plug_sp) annotation (Line(
              points={{6,44},{6,44}},
              color={85,170,255}));
          connect(smrQS.flange, inertiaLoadQS.flange_a) annotation (Line(
              points={{10,34},{40,34}}));
          connect(angleSensorQS.flange, smrQS.flange) annotation (Line(
              points={{20,44},{20,34},{10,34}}));
          connect(terminalBox.plug_sn, smr.plug_sn) annotation (Line(
              points={{-6,-72},{-6,-72}},
              color={0,0,255}));
          connect(terminalBox.plug_sp, smr.plug_sp) annotation (Line(
              points={{6,-72},{6,-72}},
              color={0,0,255}));
          connect(smr.flange, rotorDisplacementAngle.flange) annotation (Line(
              points={{10,-82},{20,-82}}));
          connect(rotorDisplacementAngle.plug_p, terminalBox.plug_sp)
            annotation (Line(
              points={{24,-72},{6,-72}},
              color={0,0,255}));
          connect(terminalBox.plug_sn, rotorDisplacementAngle.plug_n)
            annotation (Line(
              points={{-6,-72},{-6,-66},{36,-66},{36,-72}},
              color={0,0,255}));
          connect(rotorDisplacementAngle.flange, inertiaLoad.flange_a)
            annotation (Line(
              points={{20,-82},{44,-82}}));
          annotation (
            experiment(StopTime=2.0, Interval=0.001),
            Documentation(info="<html>
<html>
<h4>Simple field oriented control of synchronous reluctance machine</h4>

<p>
This example compares a time transient and a quasi static model of a synchronous reluctance machine. The machines are fed by a current source. The current components are oriented at the magnetic field orientation and transformed to the stator fixed reference frame. This way the machines are operated at constant torque. The machines start to accelerate from standstill.</p>

<p>
Simulate for 2 seconds and plot (versus time):
</p>

<ul>
<li><code>smpm|smpmQS.wMechanical</code>: machine speed</li>
<li><code>smpm|smpmQS.tauElectrical</code>: machine torque</li>
</ul>
</html>"),  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={Rectangle(
                          extent={{-64,100},{100,14}},
                          lineColor={0,0,0},
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid,
                          pattern=LinePattern.Dash),Rectangle(
                          extent={{-64,12},{100,-100}},
                          lineColor={0,0,0},
                          fillColor={255,255,170},
                          fillPattern=FillPattern.Solid,
                          pattern=LinePattern.Dash)}));
        end SMR_CurrentSource;
      end SynchronousMachines;
    end BasicMachines;
  end Examples;

  package Components "Basic fundamental wave components"
    extends Modelica.Icons.Package;
    model Ground "Magnetic ground"

      FundamentalWave.Interfaces.PositiveMagneticPort port_p
        "Complex magnetic port" annotation (Placement(transformation(extent={{-10,
                90},{10,110}})));
    equation
      Connections.potentialRoot(port_p.reference, 254);
      if Connections.isRoot(port_p.reference) then
        port_p.reference.gamma = 0;
      end if;
      port_p.V_m = Complex(0, 0);
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{0,100},{0,50}}, color={255,
              170,85}),Line(points={{-60,50},{60,50}}, color={255,170,85}),Line(
              points={{-40,30},{40,30}}, color={255,170,85}),Line(points={{-20,
              10},{20,10}}, color={255,170,85})}),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{0,100},{0,50}}, color={255,128,0}),
            Line(points={{-60,50},{60,50}}, color={255,128,0}),
            Line(points={{-40,30},{40,30}}, color={255,128,0}),
            Line(points={{-20,10},{20,10}}, color={255,128,0}),
            Text(
              extent={{-144,-19},{156,-59}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>

<p>
Grounding of the complex magnetic potential. Each magnetic circuit has to be grounded at least one point of the circuit.
</p>

</html>"));
    end Ground;

    model Reluctance "Salient reluctance"
      import Modelica.Constants.pi;
      extends Interfaces.PartialTwoPortElementary;
      parameter Modelica.Magnetic.FundamentalWave.Types.SalientReluctance R_m(d(
            start=1), q(start=1)) "Magnetic reluctance in d=re and q=im axis";
    equation
      (pi/2)*V_m.re = R_m.d*Phi.re;
      (pi/2)*V_m.im = R_m.q*Phi.im;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
                  extent={{-70,30},{70,-30}},
                  lineColor={255,170,85},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{-96,0},{-70,0}},
              color={255,170,85}),Line(points={{70,0},{96,0}}, color={255,170,
              85}),Text(
                  extent={{0,60},{0,100}},
                  lineColor={0,0,255},
                  textString="%name")}), Documentation(info="<html>
<p>
The salient reluctance models the relationship between the complex magnetic potential difference
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/V_m.png\"> and the complex magnetic flux <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Phi.png\">,
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/reluctance.png\">
</p>

<p>which can also be expressed in terms complex phasors:</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/reluctance_alt.png\">
</p>
</html>"));
    end Reluctance;

    model Permeance "Salient Permeance"
      import Modelica.Constants.pi;
      extends Interfaces.PartialTwoPortElementary;
      parameter Modelica.Magnetic.FundamentalWave.Types.SalientPermeance G_m(d(
            start=1), q(start=1)) "Magnetic permeance in d=re and q=im axis";
    equation
      (pi/2)*G_m.d*V_m.re = Phi.re;
      (pi/2)*G_m.q*V_m.im = Phi.im;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{0,60},{0,100}},
                  lineColor={0,0,255},
                  textString="%name"),Rectangle(
                  extent={{-70,30},{70,-30}},
                  lineColor={255,170,85},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{-96,0},{-70,0}},
              color={255,170,85}),Line(points={{70,0},{96,0}}, color={255,170,
              85})}), Documentation(info="<html>
<p>
The salient permeance models the relationship between the complex magnetic potential difference
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/V_m.png\" alt=\"V_m.png\"> and the complex magnetic flux <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Phi.png\">:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/permeance.png\"
      alt=\"reluctance.png\">
</blockquote>
<p></p>


</html>"));
    end Permeance;

    model EddyCurrent
      "Constant loss model under sinusoidal magnetic conditions"
      import Modelica.Constants.pi;
      constant Complex j=Complex(0, 1);
      extends Interfaces.PartialTwoPortElementary;
      parameter Modelica.SIunits.Conductance G(min=0)
        "Equivalent symmetric loss conductance";
      extends
        Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
          final T=273.15);
      Modelica.SIunits.AngularVelocity omega=der(port_p.reference.gamma)
        "Angular velocity";
    equation
      lossPower = (pi/2)*Modelica.ComplexMath.imag(omega*V_m*
        Modelica.ComplexMath.conj(Phi));
      // Alternative calculation of loss power
      // lossPower = -(pi/2)*Modelica.ComplexMath.real(j*omega*V_m*Modelica.ComplexMath.conj(Phi));
      if G > 0 then
        (pi/2)*V_m = j*omega*G*Phi;
      else
        V_m = Complex(0, 0);
      end if;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Rectangle(
                  extent={{-70,30},{70,-30}},
                  lineColor={255,170,85},
                  fillColor={255,170,85},
                  fillPattern=FillPattern.Solid),Line(points={{-96,0},{-70,0}},
              color={255,170,85}),Line(points={{70,0},{96,0}}, color={255,170,
              85}),Text(
                  extent={{0,60},{0,100}},
                  lineColor={0,0,255},
                  textString="%name"),Text(
                  extent={{0,-40},{0,-80}},
                  lineColor={0,0,0},
                  textString="G=%G")}),
        Documentation(info="<html>
<p>
The eddy current loss model with respect to fundamental wave effects is designed in accordance to
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.EddyCurrent\">FluxTubes.Basic.EddyCurrent</a> and
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.EddyCurrent\">FundamentalWave.Components.EddyCurrent</a>.
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/eddycurrent.png\">.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\">Fig. 1: equivalent models of eddy current losses</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/eddycurrent_electric.png\">
    </td>
  </tr>
</table>

<p>Due to the nature of eddy current losses, which can be represented by symmetric
conductors in an equivalent electric circuit (Fig. 1), the respective
number of phases <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\"> has to be taken into account.
Assume that the <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\"> conductances
of the equivalent circuit are <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/Gc.png\">,
the conductance for the eddy current loss model is determined by</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/GGc.png\">
</p>

<p>
where <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/N.png\"> is the number of turns of the symmetric electro magnetic coupling.
</p>

<p>For such an <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\"> phase system
the relationship between the voltage and current <a href=\"http://www.haumer.at/refimg/SpacePhasors.pdf\">space phasors</a>
and the magnetic flux and magnetic potential difference phasor is
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/vPhi\">,<br>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/iV_m.png\">,
</p>

<p>
where <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/v_k\">
and <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/i_k\">
are the phase voltages and currents, respectively.
</p>

<p>
The dissipated loss power
</p>
<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/lossPower.png\">
</p>
<p>
can be determined for the <a href=\"http://www.haumer.at/refimg/SpacePhasors.pdf\">space phasor</a>
relationship of the voltage and current space phasor.
</p>
<h4>See also</h4>

<p><a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.EddyCurrent\">FluxTubes.Basic.EddyCurrent</a></p>
</html>"));
    end EddyCurrent;

    model MultiPhaseElectroMagneticConverter
      "Multi phase electro magnetic converter"
      import Modelica.Constants.pi;
      constant Complex j=Complex(0, 1);
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug
        plug_p(final m=m) "Positive plug" annotation (Placement(transformation(
            origin={-100,100},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug
        plug_n(final m=m) "Negative plug" annotation (Placement(transformation(
            origin={-100,-100},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      FundamentalWave.Interfaces.PositiveMagneticPort port_p
        "Positive complex magnetic port" annotation (Placement(transformation(
              extent={{90,90},{110,110}})));
      FundamentalWave.Interfaces.NegativeMagneticPort port_n
        "Negative complex magnetic port" annotation (Placement(transformation(
              extent={{90,-110},{110,-90}})));
      parameter Integer m=3 "Number of phases";
      parameter Real effectiveTurns "Effective number of turns";
      constant Modelica.SIunits.Angle orientation=0
        "Orientation of the first winding axis";
      // Local electric multi phase quantities
      Modelica.SIunits.ComplexVoltage v[m] "Complex voltage";
      Modelica.SIunits.Voltage abs_v[m]=Modelica.ComplexMath.'abs'(v)
        "Magnitude of complex voltage";
      Modelica.SIunits.Angle arg_v[m]=Modelica.ComplexMath.arg(v)
        "Argument of complex voltage";

      Modelica.SIunits.ComplexCurrent i[m] "Complex current";
      Modelica.SIunits.Current abs_i[m]=Modelica.ComplexMath.'abs'(i)
        "Magnitude of complex current";
      Modelica.SIunits.Angle arg_i[m]=Modelica.ComplexMath.arg(i)
        "Argument of complex current";

      Modelica.SIunits.ActivePower P[m]={Modelica.ComplexMath.real(v[k]*
          Modelica.ComplexMath.conj(i[k])) for k in 1:m} "Active power";
      Modelica.SIunits.ActivePower P_total=sum(P) "Total active power";
      Modelica.SIunits.ReactivePower Q[m]={Modelica.ComplexMath.imag(v[k]*
          Modelica.ComplexMath.conj(i[k])) for k in 1:m} "Reactive power";
      Modelica.SIunits.ReactivePower Q_total=sum(Q) "Total reactive power";
      Modelica.SIunits.ApparentPower S[m]={Modelica.ComplexMath.'abs'(v[k]*
          Modelica.ComplexMath.conj(i[k])) for k in 1:m}
        "Magnitude of complex apparent power";
      Modelica.SIunits.ApparentPower S_total=sqrt(P_total^2 + Q_total^2)
        "Magnitude of total complex apparent power";
      Real pf[m]={cos(Modelica.ComplexMath.arg(Complex(P[k], Q[k]))) for k in 1:m}
        "Power factor";

      // Local electromagnetic fundamental wave quantities
      Modelica.SIunits.ComplexMagneticPotentialDifference V_m
        "Complex magnetic potential difference";
      Modelica.SIunits.MagneticPotentialDifference abs_V_m=
          Modelica.ComplexMath.'abs'(V_m)
        "Magnitude of complex magnetic potential difference";
      Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
        "Argument of complex magnetic potential difference";

      Modelica.SIunits.ComplexMagneticFlux Phi "Complex magnetic flux";
      Modelica.SIunits.MagneticPotentialDifference abs_Phi=
          Modelica.ComplexMath.'abs'(Phi) "Magnitude of complex magnetic flux";
      Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
        "Argument of complex magnetic flux";

      Modelica.SIunits.AngularVelocity omega=der(port_p.reference.gamma);
      // A technical solution with a rotator cannot be applied to the equations below
      final parameter Complex N=effectiveTurns*Modelica.ComplexMath.exp(Complex(
          0, orientation)) "Complex effective number of turns";
      Modelica.SIunits.ComplexVoltage vSymmetricalComponent[m]
        "Symmetrical components of voltages";
      Modelica.SIunits.ComplexCurrent iSymmetricalComponent[m]
        "Symmetrical components of currents";
    protected
      final parameter Complex sTM[m,m]=
        Modelica.Electrical.MultiPhase.Functions.symmetricTransformationMatrix(m);
      final parameter Integer indexNonPos[:]=
          Electrical.MultiPhase.Functions.indexNonPositiveSequence(m)
        "Indices of all non positive sequence components";
      final parameter Integer indexPos[:]=
          Electrical.MultiPhase.Functions.indexPositiveSequence(m)
        "Indices of all positive sequence components";
    equation
      // Symmetrical components (preferred): vSymmetricalComponent = sTM*v; iSymmetricalComponent = sTM*i;
      for j in 1:m loop
        vSymmetricalComponent[j] = Complex(sum({sTM[j,k].re*v[k].re - sTM[j,k].im*v[k].im for k in 1:m}),
                                           sum({sTM[j,k].re*v[k].im + sTM[j,k].im*v[k].re for k in 1:m}));
        iSymmetricalComponent[j] = Complex(sum({sTM[j,k].re*i[k].re - sTM[j,k].im*i[k].im for k in 1:m}),
                                           sum({sTM[j,k].re*i[k].im + sTM[j,k].im*i[k].re for k in 1:m}));
      end for;
      // Magnetic flux and flux balance of the magnetic ports
      port_p.Phi = Phi;
      port_p.Phi + port_n.Phi = Complex(0, 0);
      // Magnetic potential difference of the magnetic ports
      port_p.V_m - port_n.V_m = V_m;
      // Voltage drop between the electrical plugs
      v = plug_p.pin.v - plug_n.pin.v;
      // Current and current balance of the electric plugs
      i = plug_p.pin.i;
      plug_p.pin.i + plug_n.pin.i = {Complex(0, 0) for k in 1:m};
      V_m.re = sqrt(2)*(2.0/pi)*Modelica.ComplexMath.real(N*
        iSymmetricalComponent[1])*m/2;
      V_m.im = sqrt(2)*(2.0/pi)*Modelica.ComplexMath.imag(N*
        iSymmetricalComponent[1])*m/2;
      for k in 1:size(indexNonPos, 1) loop
        iSymmetricalComponent[indexNonPos[k]] = Complex(0, 0);
      end for;
      for k in 2:size(indexPos, 1) loop
        vSymmetricalComponent[indexPos[1]] = vSymmetricalComponent[indexPos[k]];
      end for;
      // Induced voltages from complex magnetic flux, number of turns
      // and angles of orientation of winding
      -sqrt(2)*Complex(Modelica.ComplexMath.real(vSymmetricalComponent[indexPos[
        1]]), Modelica.ComplexMath.imag(vSymmetricalComponent[indexPos[1]])) =
        Modelica.ComplexMath.conj(N)*j*omega*Phi;
      // Potential roots are not used; instead the reference angle is handled
      // by means of Connections.branch between electric plug_p and magnetic port_p
      // It has to be checked whether this Modelica compliant
      //   Connections.potentialRoot(plug_p.reference);
      //   Connections.potentialRoot(port_p.reference);
      Connections.branch(port_p.reference, port_n.reference);
      port_p.reference.gamma = port_n.reference.gamma;
      Connections.branch(plug_p.reference, plug_n.reference);
      plug_p.reference.gamma = plug_n.reference.gamma;
      Connections.branch(plug_p.reference, port_p.reference);
      plug_p.reference.gamma = port_p.reference.gamma;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Ellipse(
                  extent={{-60,60},{58,0}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Ellipse(
                  extent={{-58,0},{60,-60}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{-60,60},{0,-60}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{100,-100},{94,-100},
              {84,-98},{76,-94},{64,-86},{50,-72},{42,-58},{36,-40},{30,-18},{
              30,0},{30,18},{34,36},{46,66},{62,84},{78,96},{90,100},{100,100}},
              color={255,170,85}),Line(points={{0,60},{-100,60},{-100,100}},
              color={85,170,255}),Line(points={{0,-60},{-100,-60},{-100,-98}},
              color={85,170,255}),Text(
                  extent={{0,160},{0,120}},
                  lineColor={0,0,255},
                  fillColor={255,128,0},
                  fillPattern=FillPattern.Solid,
                  textString="%name")}), Documentation(info="<html>

<p>
Each phase <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/k.png\"> of an <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\"> phase winding has an effective number of turns, <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/effectiveTurns_k.png\"> and an respective winging angle <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/orientation_k.png\"> and a phase current <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/i_k.png\">.
</p>

<p>
The total complex magnetic potential difference of the multi phase winding is determined by:
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Components/multiphaseconverter_vm.png\">
</p>

<p>
In this equation
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/i_sc1.png\">
is the positive symmetrical component of the currents.
</p>

<p>
The positive sequence of the voltages
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/v_sc1.png\">
induced in each winding is directly proportional to the complex magnetic flux and the number of turns. This relationship can be modeled by means of</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Components/multiphaseconverter_phi.png\">.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter\">
Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter\">
Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.QuasiStaticAnalogElectroMagneticConverter\">
QuasiStaticAnalogElectroMagneticConverter</a>
</p>
</html>"));
    end MultiPhaseElectroMagneticConverter;

    model QuasiStaticAnalogElectroMagneticConverter
      "Electro magnetic converter to only (!) quasi static analog, neglecting induced voltage"
      // Note: It has not whether the transient voltage induction and the
      //   leakage induction shall be considered in this model or not.
      //   This model is required for electrical excited synchronous machines (SMEE)
      import Modelica.Constants.pi;
      Modelica.Electrical.Analog.Interfaces.PositivePin pin_p "Positive pin"
        annotation (Placement(transformation(
            origin={-100,100},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "Negative pin"
        annotation (Placement(transformation(
            origin={-100,-100},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Interfaces.PositiveMagneticPort port_p "Positive complex magnetic port"
        annotation (Placement(transformation(extent={{90,90},{110,110}})));
      Interfaces.NegativeMagneticPort port_n "Negative complex magnetic port"
        annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
      parameter Real effectiveTurns "Effective number of turns"
        annotation (Evaluate=true);
      // Local electric single phase quantities
      Modelica.SIunits.Voltage v "Voltage drop";
      Modelica.SIunits.Current i "Current";

      // Local electromagnetic fundamental wave quantities
      Modelica.SIunits.ComplexMagneticPotentialDifference V_m
        "Complex magnetic potential difference";
      Modelica.SIunits.MagneticPotentialDifference abs_V_m=
          Modelica.ComplexMath.'abs'(V_m)
        "Magnitude of complex magnetic potential difference";
      Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
        "Argument of complex magnetic potential difference";

      Modelica.SIunits.ComplexMagneticFlux Phi "Complex magnetic flux";
      Modelica.SIunits.MagneticPotentialDifference abs_Phi=
          Modelica.ComplexMath.'abs'(Phi) "Magnitude of complex magnetic flux";
      Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
        "Argument of complex magnetic flux";

      Modelica.SIunits.Angle gamma "Angle of V_m fixed reference frame";
      Modelica.SIunits.AngularVelocity omega=der(port_p.reference.gamma);
    equation
      // Magnetic flux and flux balance of the magnetic ports
      port_p.Phi = Phi;
      port_p.Phi + port_n.Phi = Complex(0, 0);
      // Magnetic potential difference of the magnetic ports
      port_p.V_m - port_n.V_m = V_m;
      // Voltage drop between the electrical pins
      v = pin_p.v - pin_n.v;
      // Current and current balance of the electric pins
      i = pin_p.i;
      pin_p.i + pin_n.i = 0;
      // Complex magnetic potential difference is determined from currents, number
      // of turns and angles of orientation of the magnetic potential difference
      V_m = (2/pi)*effectiveTurns*i*Modelica.ComplexMath.fromPolar(1, -gamma);
      // Induced voltages is zero due to quasi static electric analog circuit
      v = 0;
      Connections.branch(port_p.reference, port_n.reference);
      port_p.reference.gamma = port_n.reference.gamma;
      // Reference angle to magnetic potential fixed frame
      gamma = port_p.reference.gamma;
      annotation (
        defaultComponentName="converter",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Ellipse(
                  extent={{-60,60},{58,0}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Ellipse(
                  extent={{-58,0},{60,-60}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{-60,60},{0,-60}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{100,-100},{94,-100},
              {84,-98},{76,-94},{64,-86},{50,-72},{42,-58},{36,-40},{30,-18},{
              30,0},{30,18},{34,36},{46,66},{62,84},{78,96},{90,100},{100,100}},
              color={255,128,0}),Line(points={{0,60},{-100,60},{-100,100}},
              color={0,0,255}),Line(points={{0,-60},{-100,-60},{-100,-98}},
              color={0,0,255}),Text(
                  extent={{0,160},{0,120}},
                  lineColor={0,0,255},
                  fillColor={255,128,0},
                  fillPattern=FillPattern.Solid,
                  textString="%name")}),
        Documentation(info="<html>
<p>
The analog single phase winding has an effective number of turns, <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/effectiveTurns.png\"> and a respective orientation of the winding, <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/orientation.png\">. The current in the winding is <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/i.png\">.
</p>

<p>
The total complex magnetic potential difference of the single phase winding is determined by:
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Components/singlephaseconverter_vm.png\">
</p>

<p>
where
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma.png\">
is the reference angle of the electrical and magnetic system, respectively. The induced voltage <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/v.png\"> is identical to zero.

<h4>See also</h4>
<p>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter\">
Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter\">
Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter\">
MultiPhaseElectroMagneticConverter</a>
</p>


</html>"));
    end QuasiStaticAnalogElectroMagneticConverter;

    model Idle "Idle running branch"
      extends Interfaces.PartialTwoPortElementary;
    equation
      Phi = Complex(0, 0);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Text(
                  extent={{0,60},{0,100}},
                  lineColor={0,0,255},
                  textString="%name"),Rectangle(
                  extent={{-100,40},{100,-40}},
                  lineColor={255,255,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{-100,0},{-40,0}},
              color={255,170,85}),Line(points={{40,0},{100,0}}, color={255,170,
              85})}),
        Documentation(info="<html>
<p>
This is a simple idle running branch.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Short\">Short</a>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Crossing\">Crossing</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Idle\">Magnetic.FundamentalWave.Components.Idle</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Short\">Magnetic.FundamentalWave.Components.Short</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Crossing\">Magnetic.FundamentalWave.Components.Crossing</a>
</p>

</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{-100,0},{-60,0}}, color={
              255,128,0}),Line(points={{60,0},{100,0}}, color={255,128,0}),Line(
              points={{-60,0},{-40,2},{-18,6},{0,14},{12,26}}, color={255,128,0}),
              Line(points={{60,0},{40,-2},{18,-6},{0,-14},{-12,-26}}, color={
              255,128,0})}));
    end Idle;

    model Short "Short connection"
      extends Interfaces.PartialTwoPort;
    equation
      connect(port_p, port_n) annotation (Line(points={{-100,0},{-1,0},{-1,0},{
              100,0}}, color={255,128,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Text(
              extent={{0,60},{0,100}},
              lineColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-100,40},{100,-40}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-100,0},{100,0}}, color={255,170,85})}),
          Documentation(info="<html>
<p>
This is a simple short cut branch.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Idle\">Idle</a>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Crossing\">Crossing</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Idle\">Magnetic.FundamentalWave.Components.Idle</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Short\">Magnetic.FundamentalWave.Components.Short</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Crossing\">Magnetic.FundamentalWave.Components.Crossing</a>
</p>

</html>"));
    end Short;

    model Crossing "Crossing of connections"

      Interfaces.PositiveMagneticPort port_p1 "Connected with port_p2"
        annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
      Interfaces.NegativeMagneticPort port_n1 "Connected with port_n2"
        annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
      Interfaces.PositiveMagneticPort port_p2 "Connected with port_p1"
        annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
      Interfaces.NegativeMagneticPort port_n2 "Connected with port_n1"
        annotation (Placement(transformation(extent={{90,90},{110,110}})));
    equation
      connect(port_p1, port_p2) annotation (Line(
          points={{-100,100},{-100,20},{0,20},{0,-20},{100,-20},{100,-100}},
          color={255,170,85}));
      connect(port_n2, port_n1) annotation (Line(
          points={{100,100},{100,0},{-100,0},{-100,-100}},
          color={255,170,85}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Text(
                  extent={{0,60},{0,100}},
                  lineColor={0,0,255},
                  textString="%name"),Rectangle(
                  extent={{-100,40},{100,-40}},
                  lineColor={255,255,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(
                  points={{-100,100},{-100,40},{100,-40},{100,-100}},
                  color={255,170,85}),Line(
                  points={{100,100},{100,40},{-100,-40},{-100,-100}},
                  color={255,170,85})}),
        Documentation(info="<html>
<p>
This is a simple short cut branch.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Idle\">Idle</a>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Short\">Short</a>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Idle\">Magnetic.FundamentalWave.Components.Idle</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Short\">Magnetic.FundamentalWave.Components.Short</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Crossing\">Magnetic.FundamentalWave.Components.Crossing</a>
</p>

</html>"));
    end Crossing;

    annotation (Documentation(info="<html>
<p>Basic components of the FundamentalWave library for modeling magnetic circuits. Machine specific components are
located at <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components\">Machines.Components</a>.</p>
</html>"));
  end Components;

  package BasicMachines "Basic quasi static machine models"
    extends Modelica.Icons.Package;
    package InductionMachines "Quasi static induction machines"
      extends Modelica.Icons.Package;
      model IM_SquirrelCage "Induction machine with squirrel cage"
        // Removed from extension of FUNDAMENTAL WAVE model: is(start=zeros(m)) ##
        extends BaseClasses.PartialBasicMachine(
          Rs(start=0.03),
          Lssigma(start=3*(1 - sqrt(1 - 0.0667))/(2*pi*fsNominal)),
          final L0(d=2.0*Lm/m/effectiveStatorTurns^2, q=2.0*Lm/m/
                effectiveStatorTurns^2),
          redeclare final
            Modelica.Electrical.Machines.Thermal.AsynchronousInductionMachines.ThermalAmbientAIMC
            thermalAmbient(final Tr=TrOperational),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortAIMC
            thermalPort,
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortAIMC
            internalThermalPort,
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceAIMC
            powerBalance(final lossPowerRotorWinding=sum(rotorCage.resistor.resistor.LossPower),
              final lossPowerRotorCore=0));
        parameter Modelica.SIunits.Inductance Lm(start=3*sqrt(1 - 0.0667)/(2*pi
              *fsNominal)) "Stator main field inductance per phase" annotation (
           Dialog(tab="Nominal resistances and inductances", groupImage=
                "modelica://Modelica/Resources/Images/Electrical/Machines/IMC.png"));
        parameter Modelica.SIunits.Inductance Lrsigma(start=3*(1 - sqrt(1 -
              0.0667))/(2*pi*fsNominal))
          "Rotor leakage inductance of equivalent m phase winding w.r.t. stator side"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Resistance Rr(start=0.04)
          "Rotor resistance of equivalent m phase winding w.r.t. stator side"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature TrRef(start=293.15)
          "Reference temperature of rotor resistance"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20r(start=0)
          "Temperature coefficient of rotor resistance at 20 degC"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature TrOperational(start=293.15)
          "Operational temperature of rotor resistance" annotation (Dialog(
              group="Operational temperatures", enable=not useThermalPort));
        output Modelica.SIunits.ComplexCurrent ir[m]=rotorCage.i
          "Rotor current";
        Modelica.SIunits.Current abs_ir[m]=Modelica.ComplexMath.'abs'(ir)
          "Magnitude of complex rotor current";
        Modelica.SIunits.Angle arg_ir[m]=Modelica.ComplexMath.arg(ir)
          "Argument of complex rotor current";

        Components.SymmetricMultiPhaseCageWinding rotorCage(
          final Lsigma=Lrsigma,
          final effectiveTurns=effectiveStatorTurns,
          final useHeatPort=true,
          final RRef=Rr,
          final TRef=TrRef,
          final TOperational=TrRef,
          final m=m,
          final alpha20=alpha20r)
          "Symmetric rotor cage winding including resistances and stray inductances"
          annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
      equation
        connect(rotorCage.heatPortWinding, internalThermalPort.heatPortRotorWinding)
          annotation (Line(
            points={{0,-40},{-40,-40},{-40,-90}},
            color={191,0,0}));
        connect(airGap.port_rn, rotorCage.port_p) annotation (Line(
            points={{-10,-10},{-10,-30}},
            color={255,128,0}));
        connect(airGap.port_rp, rotorCage.port_n) annotation (Line(
            points={{10,-10},{10,-30}},
            color={255,128,0}));
        annotation (
          defaultComponentName="imc",
          Documentation(info="<html>
<p>
Resistances and stray inductances of the machine refer to an <code>m</code> phase stator. The symmetry of the stator, rotor and supply are assumed. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>heat losses in the temperature dependent cage resistances</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<h4>See also</h4>
<p>
<a href=\"Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing\">
IM_SlipRing</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing\">
Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage\">
Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage</a>,
</p>
</html>"));
      end IM_SquirrelCage;

      model IM_SlipRing "Induction machine with slip ring rotor"
        parameter Integer mr(min=3) = m "Number of rotor phases";
        extends BaseClasses.PartialBasicMachine(
          Rs(start=0.03),
          Lssigma(start=3*(1 - sqrt(1 - 0.0667))/(2*pi*fsNominal)),
          final L0(d=2.0*Lm/m/effectiveStatorTurns^2, q=2.0*Lm/m/
                effectiveStatorTurns^2),
          redeclare final
            Modelica.Electrical.Machines.Thermal.AsynchronousInductionMachines.ThermalAmbientAIMS
            thermalAmbient(final Tr=TrOperational, final mr=mr),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortAIMS
            thermalPort(final mr=mr),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortAIMS
            internalThermalPort(final mr=mr),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceAIMS
            powerBalance(
            final lossPowerRotorWinding=sum(rotor.resistor.resistor.LossPower),
            final lossPowerRotorCore=rotor.core.lossPower,
            final lossPowerBrush=0,
            final powerRotor=
                Electrical.QuasiStationary.MultiPhase.Functions.activePower(vr,
                ir)));

        Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug
          plug_rn(final m=mr) "Negative plug of rotor" annotation (Placement(
              transformation(extent={{-110,-50},{-90,-70}})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug
          plug_rp(final m=mr) "Positive plug of rotor" annotation (Placement(
              transformation(extent={{-110,70},{-90,50}})));
        parameter Modelica.SIunits.Inductance Lm(start=3*sqrt(1 - 0.0667)/(2*pi
              *fsNominal)) "Stator main field inductance per phase" annotation (
           Dialog(tab="Nominal resistances and inductances", groupImage=
                "modelica://Modelica/Resources/Images/Electrical/Machines/IMS.png"));
        parameter Modelica.SIunits.Inductance Lrsigma(start=3*(1 - sqrt(1 -
              0.0667))/(2*pi*fsNominal))
          "Rotor leakage inductance per phase w.r.t. rotor side"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Resistance Rr(start=0.04)
          "Rotor resistance per phase w.r.t. rotor side"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature TrRef(start=293.15)
          "Reference temperature of rotor resistance"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20r(start=0)
          "Temperature coefficient of rotor resistance at 20 degC"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature TrOperational(start=293.15)
          "Operational temperature of rotor resistance" annotation (Dialog(
              group="Operational temperatures", enable=not useThermalPort));
        parameter Boolean useTurnsRatio(start=true)
          "Use TurnsRatio or calculate from locked-rotor voltage?";
        parameter Real TurnsRatio(final min=Modelica.Constants.small, start=1)
          "Effective number of stator turns / effective number of rotor turns"
          annotation (Dialog(enable=useTurnsRatio));
        parameter Modelica.SIunits.Voltage VsNominal(start=100)
          "Nominal stator voltage per phase"
          annotation (Dialog(enable=not useTurnsRatio));
        parameter Modelica.SIunits.Voltage VrLockedRotor(start=100*(2*pi*
              fsNominal*Lm)/sqrt(Rs^2 + (2*pi*fsNominal*(Lm + Lssigma))^2))
          "Locked rotor voltage per phase"
          annotation (Dialog(enable=not useTurnsRatio));
        parameter Modelica.Electrical.Machines.Losses.CoreParameters
          rotorCoreParameters(
          final m=3,
          PRef=0,
          VRef(start=1) = 1,
          wRef(start=1) = 1)
          "Rotor core loss parameter record, all quantities refer to rotor side"
          annotation (Dialog(tab="Losses"));
        output Modelica.SIunits.ComplexVoltage vr[mr]=plug_rp.pin.v - plug_rn.pin.v
          "Complex rotor voltage";
        Modelica.SIunits.Voltage abs_vr[mr]=Modelica.ComplexMath.'abs'(vr)
          "Magnitude of complex rotor voltage";
        Modelica.SIunits.Angle arg_vr[mr]=Modelica.ComplexMath.arg(vr)
          "Argument of complex rotor voltage";

        output Modelica.SIunits.ComplexCurrent ir[mr]=plug_rp.pin.i
          "Complex rotor current";
        Modelica.SIunits.Current abs_ir[mr]=Modelica.ComplexMath.'abs'(ir)
          "Magnitude of complex rotor current";
        Modelica.SIunits.Angle arg_ir[mr]=Modelica.ComplexMath.arg(ir)
          "Argument of complex rotor current";

        Modelica.SIunits.ActivePower Pr[mr]={Modelica.ComplexMath.real(vr[k]*
            Modelica.ComplexMath.conj(ir[k])) for k in 1:mr}
          "Active rotor power";
        Modelica.SIunits.ActivePower Pr_total=sum(Pr)
          "Total active rotor power";
        Modelica.SIunits.ReactivePower Qr[mr]={Modelica.ComplexMath.imag(vr[k]*
            Modelica.ComplexMath.conj(ir[k])) for k in 1:mr}
          "Reactive rotor power";
        Modelica.SIunits.ReactivePower Qr_total=sum(Qr)
          "Total reactive rotor power";
        Modelica.SIunits.ApparentPower Sr[mr]={Modelica.ComplexMath.'abs'(vr[k]
            *Modelica.ComplexMath.conj(ir[k])) for k in 1:mr}
          "Magnitude of complex rotor apparent power";
        Modelica.SIunits.ApparentPower Sr_total=sqrt(Pr_total^2 + Qr_total^2)
          "Magnitude of total complex rotor apparent power";
        Real pfr[m]={cos(Modelica.ComplexMath.arg(Complex(Pr[k], Qr[k]))) for k in
                1:m} "Rotor power factor";

      protected
        final parameter Real internalTurnsRatio=if useTurnsRatio then
            TurnsRatio else VsNominal/VrLockedRotor*(2*pi*fsNominal*Lm)/sqrt(Rs
            ^2 + (2*pi*fsNominal*(Lm + Lssigma))^2);
      public
        Components.SymmetricMultiPhaseWinding rotor(
          final Lsigma=Lrsigma,
          final effectiveTurns=effectiveStatorTurns/internalTurnsRatio,
          final useHeatPort=true,
          final RRef=Rr,
          final TRef=TrRef,
          final TOperational=TrOperational,
          final GcRef=rotorCoreParameters.GcRef,
          final m=mr,
          final alpha20=alpha20r)
          "Symmetric rotor winding including resistances, zero and stray inductances and zero core losses"
          annotation (Placement(transformation(
              origin={0,-40},
              extent={{-10,-10},{10,10}},
              rotation=90)));
      equation
        connect(rotor.plug_n, plug_rn) annotation (Line(points={{10,-50},{10,-60},
                {-100,-60}}, color={85,170,255}));
        connect(rotor.heatPortCore, internalThermalPort.heatPortRotorCore)
          annotation (Line(
            points={{10,-36},{20,-36},{20,-80},{-39.6,-80},{-39.6,-90.8}},
            color={191,0,0}));
        connect(rotor.heatPortWinding, internalThermalPort.heatPortRotorWinding)
          annotation (Line(
            points={{10,-44},{20,-44},{20,-80},{-40,-80},{-40,-90}},
            color={191,0,0}));
        connect(plug_rp, rotor.plug_p) annotation (Line(
            points={{-100,60},{-80,60},{-80,-50},{-10,-50}},
            color={85,170,255}));
        connect(airGap.port_rn, rotor.port_p) annotation (Line(
            points={{-10,-10},{-10,-30}},
            color={255,128,0}));
        connect(airGap.port_rp, rotor.port_n) annotation (Line(
            points={{10,-10},{10,-30}},
            color={255,128,0}));
        annotation (
          defaultComponentName="ims",
          Icon(graphics={Line(points={{-100,50},{-100,20},{-60,20}}, color={85,
                    170,255}), Line(points={{-100,-50},{-100,-20},{-60,-20}},
                  color={85,170,255})}),
          Documentation(info="<html>
<p>
Resistances and stray inductances of the machine always refer to either stator or rotor. The symmetry of the stator, rotor and supply are assumed. The number of stator and rotor phases may be different. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>heat losses in the temperature dependent rotor winding resistances</li>
<li>friction losses</li>
<li>stator and rotor core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<h4>See also</h4>
<p>
<a href=\"Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage\">
IM_SquirrelCage</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing\">
Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage\">
Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage</a>,
</p>
</html>"));
      end IM_SlipRing;
    end InductionMachines;

    package SynchronousMachines "Quasi static synchronous machines"
      extends Modelica.Icons.Package;
      model SM_PermanentMagnet
        "Permanent magnet synchronous machine with optional damper cage"
        extends BaseClasses.PartialBasicMachine(
          Rs(start=0.03),
          Lssigma(start=0.1/(2*pi*fsNominal)),
          final L0(d=2.0*Lmd/m/effectiveStatorTurns^2, q=2.0*Lmq/m/
                effectiveStatorTurns^2),
          redeclare final
            Modelica.Electrical.Machines.Thermal.SynchronousInductionMachines.ThermalAmbientSMPM
            thermalAmbient(
            final useDamperCage=useDamperCage,
            final Tr=TrOperational,
            final Tpm=TpmOperational),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMPM
            thermalPort(final useDamperCage=useDamperCage),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMPM
            internalThermalPort(final useDamperCage=useDamperCage),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceSMPM
            powerBalance(
            final lossPowerRotorWinding=damperCageLossPower,
            final lossPowerRotorCore=0,
            final lossPowerPermanentMagnet=permanentMagnet.lossPower));
        parameter Modelica.SIunits.Inductance Lmd(start=0.3/(2*pi*fsNominal))
          "Stator main field inductance per phase, d-axis" annotation (Dialog(
              tab="Nominal resistances and inductances", groupImage=
                "modelica://Modelica/Resources/Images/Electrical/Machines/SMPM.png"));
        parameter Modelica.SIunits.Inductance Lmq(start=0.3/(2*pi*fsNominal))
          "Stator main field inductance per phase, q-axis"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        // Rotor cage parameters
        parameter Boolean useDamperCage(start=true)
          "Enable/disable damper cage" annotation (Dialog(tab=
                "Nominal resistances and inductances", group="Damper cage"));
        parameter Modelica.SIunits.Inductance Lrsigmad(start=0.05/(2*pi*
              fsNominal))
          "Rotor leakage inductance, d-axis, w.r.t. stator side" annotation (
            Dialog(
            tab="Nominal resistances and inductances",
            group="Damper cage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigmad
          "Rotor leakage inductance, q-axis, w.r.t. stator side" annotation (
            Dialog(
            tab="Nominal resistances and inductances",
            group="Damper cage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrd(start=0.04)
          "Rotor resistance, d-axis, w.r.t. stator side" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="Damper cage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrq=Rrd
          "Rotor resistance , q-axis, w.r.t. stator side" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="Damper cage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Temperature TrRef(start=293.15)
          "Reference temperature of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="Damper cage",
            enable=useDamperCage));
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20r(start=0)
          "Temperature coefficient of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="Damper cage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Voltage VsOpenCircuit(start=112.3)
          "Open circuit RMS voltage per phase @ fsNominal";
        final parameter Modelica.SIunits.Temperature TpmOperational=293.15
          "Operational temperature of permanent magnet"
          annotation (Dialog(group="Operational temperatures"));
        parameter Modelica.SIunits.Temperature TrOperational(start=293.15)
          "Operational temperature of (optional) damper cage" annotation (
            Dialog(group="Operational temperatures", enable=not useThermalPort
                 and useDamperCage));
        parameter
          Modelica.Electrical.Machines.Losses.PermanentMagnetLossParameters
          permanentMagnetLossParameters(IRef(start=100), wRef(start=2*pi*
                fsNominal/p)) "Permanent magnet loss parameter record"
          annotation (Dialog(tab="Losses"));
        Modelica.ComplexBlocks.Interfaces.ComplexOutput ir[2] if useDamperCage
          "Damper cage currents";
        FundamentalWave.Components.Short short if not useDamperCage
          "Magnetic connection in case the damper cage is not present"
          annotation (Placement(transformation(
              origin={10,-40},
              extent={{10,10},{-10,-10}},
              rotation=270)));
        Components.SaliencyCageWinding rotorCage(
          final RRef(d=Rrd, q=Rrq),
          final Lsigma(d=Lrsigmad, q=Lrsigmaq),
          final useHeatPort=true,
          final TRef=TrRef,
          final TOperational=TrOperational,
          final alpha20=alpha20r,
          final effectiveTurns=sqrt(m/2.0)*effectiveStatorTurns) if
          useDamperCage
          "Symmetric rotor cage winding including resistances and stray inductances"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={20,-40})));
        FundamentalWave.BasicMachines.Components.PermanentMagnet
          permanentMagnet(
          final V_m=Complex(V_mPM, 0),
          final m=m,
          final permanentMagnetLossParameters=permanentMagnetLossParameters,
          final useHeatPort=true,
          final is=is) "Magnetic potential difference of permanent magnet"
          annotation (Placement(transformation(
              origin={-10,-40},
              extent={{-10,-10},{10,10}},
              rotation=270)));
      protected
        final parameter Modelica.SIunits.MagneticPotentialDifference V_mPM=(2/
            pi)*sqrt(2)*(m/2)*VsOpenCircuit/effectiveStatorTurns/(Lmd/
            effectiveStatorTurns^2*2*pi*fsNominal)
          "Equivalent excitation magnetic potential difference";
        Modelica.Blocks.Interfaces.RealOutput damperCageLossPower(final
            quantity="Power", final unit="W") "Damper losses";
      equation
        connect(ir, rotorCage.i);
        connect(damperCageLossPower, rotorCage.lossPower);
        if not useDamperCage then
          damperCageLossPower = 0;
        end if;
        connect(permanentMagnet.port_p, airGap.port_rn) annotation (Line(
            points={{-10,-30},{-10,-10}},
            color={255,128,0}));
        connect(permanentMagnet.support, airGap.support) annotation (Line(
            points={{-20,-40},{-50,-40},{-50,0},{-10,0}}));
        connect(permanentMagnet.heatPort, internalThermalPort.heatPortPermanentMagnet)
          annotation (Line(
            points={{-20,-30},{-40,-30},{-40,-90}},
            color={191,0,0}));
        connect(permanentMagnet.flange, inertiaRotor.flange_b) annotation (Line(
            points={{0,-40},{0,-20},{90,-20},{90,0}}));
        connect(airGap.port_rp, rotorCage.port_n) annotation (Line(
            points={{10,-10},{10,-30},{20,-30}},
            color={255,128,0}));
        connect(short.port_n, airGap.port_rp) annotation (Line(
            points={{10,-30},{10,-10}},
            color={255,128,0}));
        connect(short.port_p, permanentMagnet.port_n) annotation (Line(
            points={{10,-50},{-10,-50}},
            color={255,128,0}));
        connect(rotorCage.port_p, permanentMagnet.port_n) annotation (Line(
            points={{20,-50},{-10,-50}},
            color={255,128,0}));
        connect(rotorCage.heatPortWinding, internalThermalPort.heatPortRotorWinding)
          annotation (Line(
            points={{30,-40},{40,-40},{40,-80},{-40,-80},{-40,-90}},
            color={191,0,0}));
        annotation (
          defaultComponentName="smpm",
          Icon(graphics={
              Rectangle(
                extent={{-130,10},{-100,-10}},
                lineColor={0,0,0},
                fillColor={0,255,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-100,10},{-70,-10}},
                lineColor={0,0,0},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Ellipse(extent={{-134,34},{-66,-34}}, lineColor={85,170,255})}),
          Documentation(info="<html>
<p>
Resistances and stray inductances of the machine refer to an <code>m</code> phase stator. The symmetry of the stator and the supply are assumed. For rotor asymmetries can be taken into account by different resistances and stray inductances in the d- and q-axis. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>optional, when enabled: heat losses in the temperature dependent damper cage resistances</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
<li>permanent magnet losses</li>
</ul>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited\">
SM_ElectricalExcited</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ReluctanceRotor\">
SM_ReluctanceRotor</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet\">
Magnetic.FundamentalWave.BasicMachines.SM_PermanentMagnet</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited\">
Magnetic.FundamentalWave.BasicMachines.SM_ElectricalExcited</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor\">
Magnetic.FundamentalWave.BasicMachines.SM_ReluctanceRotor</a>,
</p>
</html>"));
      end SM_PermanentMagnet;

      model SM_ElectricalExcited
        "Electrical excited synchronous machine with optional damper cage"
        extends BaseClasses.PartialBasicMachine(
          Rs(start=0.03),
          Lssigma(start=0.1/(2*pi*fsNominal)),
          final L0(d=2.0*Lmd/m/effectiveStatorTurns^2, q=2.0*Lmq/m/
                effectiveStatorTurns^2),
          redeclare final
            Modelica.Electrical.Machines.Thermal.SynchronousInductionMachines.ThermalAmbientSMEE
            thermalAmbient(
            final useDamperCage=useDamperCage,
            final Te=TeOperational,
            final Tr=TrOperational),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMEE
            thermalPort(final useDamperCage=useDamperCage),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMEE
            internalThermalPort(final useDamperCage=useDamperCage),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceSMEE
            powerBalance(
            final lossPowerRotorWinding=damperCageLossPower,
            final powerExcitation=0,
            final lossPowerExcitation=excitation.resistor.LossPower,
            final lossPowerBrush=brush.lossPower,
            final lossPowerRotorCore=0));
        parameter Modelica.SIunits.Inductance Lmd(start=1.5/(2*pi*fsNominal))
          "Stator main field inductance per phase, d-axis" annotation (Dialog(
              tab="Nominal resistances and inductances", groupImage=
                "modelica://Modelica/Resources/Images/Electrical/Machines/SMEE.png"));
        parameter Modelica.SIunits.Inductance Lmq(start=1.5/(2*pi*fsNominal))
          "Stator main field inductance per phase, q-axis"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        // Rotor cage parameters
        parameter Boolean useDamperCage(start=true)
          "Enable/disable damper cage" annotation (Dialog(tab=
                "Nominal resistances and inductances", group="DamperCage"));
        parameter Modelica.SIunits.Inductance Lrsigmad(start=0.05/(2*pi*
              fsNominal))
          "Rotor leakage inductance, d-axis, w.r.t. stator side" annotation (
            Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigmad
          "Rotor leakage inductance, q-axis, w.r.t. stator side" annotation (
            Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrd(start=0.04)
          "Rotor resistance, d-axis, w.r.t. stator side" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrq=Rrd
          "Rotor resistance , q-axis, w.r.t. stator side" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Temperature TrRef(start=293.15)
          "Reference temperature of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20r(start=0)
          "Temperature coefficient of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        // Operational temperature
        parameter Modelica.SIunits.Temperature TrOperational(start=293.15)
          "Operational temperature of (optional) damper cage" annotation (
            Dialog(group="Operational temperatures", enable=not useThermalPort
                 and useDamperCage));
        parameter Modelica.SIunits.Temperature TeOperational(start=293.15)
          "Operational excitation temperature" annotation (Dialog(group=
                "Operational temperatures", enable=not useThermalPort));
        // Excitation parameters
        parameter Modelica.SIunits.Voltage VsNominal(start=100)
          "Nominal stator voltage" annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Current IeOpenCircuit(start=10)
          "Open circuit excitation current @ nominal voltage and frequency"
          annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Resistance Re(start=2.5)
          "Warm excitation resistance" annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Temperature TeRef(start=293.15)
          "Reference temperature of excitation resistance"
          annotation (Dialog(tab="Excitation"));
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20e(start=0) "Temperature coefficient of excitation resistance"
          annotation (Dialog(tab="Excitation"));
        parameter Modelica.Electrical.Machines.Losses.BrushParameters
          brushParameters "Brush loss parameter record"
          annotation (Dialog(tab="Losses"));
        output Modelica.SIunits.Voltage ve=pin_ep.v - pin_en.v
          "Excitation voltage";
        output Modelica.SIunits.Current ie=pin_ep.i "Excitation current";
        Modelica.ComplexBlocks.Interfaces.ComplexOutput ir[2] if useDamperCage
          "Damper cage currents";
        FundamentalWave.Components.Short short if not useDamperCage
          "Magnetic connection in case the damper cage is not present"
          annotation (Placement(transformation(
              origin={10,-40},
              extent={{10,10},{-10,-10}},
              rotation=270)));
        FundamentalWave.BasicMachines.Components.SaliencyCageWinding rotorCage(
          final Lsigma(d=Lrsigmad, q=Lrsigmaq),
          final useHeatPort=true,
          final TRef=TrRef,
          final TOperational=TrOperational,
          final RRef(d=Rrd, q=Rrq),
          final alpha20=alpha20r,
          final effectiveTurns=sqrt(m/2.0)*effectiveStatorTurns) if
          useDamperCage
          "Symmetric rotor cage winding including resistances and stray inductances"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={20,-40})));
        Components.QuasiStaticAnalogWinding excitation(
          final RRef=Re,
          final TRef=TeRef,
          final effectiveTurns=effectiveStatorTurns*turnsRatio*m/2,
          final useHeatPort=true,
          final TOperational=TeOperational,
          final alpha20=alpha20e)
          "Excitation winding including resistance and stray inductance"
          annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
      protected
        final parameter Real turnsRatio=sqrt(2)*VsNominal/(2*pi*fsNominal*Lmd*
            IeOpenCircuit) "Stator current / excitation current";
        Modelica.Blocks.Interfaces.RealOutput damperCageLossPower(final
            quantity="Power", final unit="W") "Damper losses";
      public
        Modelica.Electrical.Machines.Losses.DCMachines.Brush brush(final
            brushParameters=brushParameters, final useHeatPort=true)
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-80,40})));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep
          "Positive pin of excitation" annotation (Placement(transformation(
                extent={{-110,70},{-90,50}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_en
          "Negative pin of excitation" annotation (Placement(transformation(
                extent={{-90,-50},{-110,-70}})));
      equation
        connect(ir, rotorCage.i);
        connect(damperCageLossPower, rotorCage.lossPower);
        if not useDamperCage then
          damperCageLossPower = 0;
        end if;
        connect(airGap.port_rn, excitation.port_p) annotation (Line(
            points={{-10,-10},{-10,-30}},
            color={255,128,0}));
        connect(excitation.heatPortWinding, internalThermalPort.heatPortExcitation)
          annotation (Line(
            points={{-20,-50},{-20,-80},{-40,-80},{-40,-90}},
            color={191,0,0}));
        connect(airGap.port_rp, rotorCage.port_n) annotation (Line(
            points={{10,-10},{10,-30},{20,-30}},
            color={255,128,0}));
        connect(short.port_n, airGap.port_rp) annotation (Line(
            points={{10,-30},{10,-10}},
            color={255,128,0}));
        connect(rotorCage.port_p, excitation.port_n) annotation (Line(
            points={{20,-50},{-10,-50}},
            color={255,128,0}));
        connect(short.port_p, excitation.port_n) annotation (Line(
            points={{10,-50},{-10,-50}},
            color={255,128,0}));
        connect(rotorCage.heatPortWinding, internalThermalPort.heatPortRotorWinding)
          annotation (Line(
            points={{30,-40},{40,-40},{40,-80},{-40,-80},{-40,-90}},
            color={191,0,0}));
        connect(pin_ep, brush.p) annotation (Line(
            points={{-100,60},{-80,60},{-80,50}},
            color={0,0,255}));
        connect(brush.heatPort, internalThermalPort.heatPortBrush) annotation (
            Line(
            points={{-70,50},{-40,50},{-40,-90}},
            color={191,0,0}));
        connect(excitation.pin_n, pin_en) annotation (Line(
            points={{-30,-50},{-80,-50},{-80,-60},{-100,-60}},
            color={0,0,255}));
        connect(excitation.pin_p, brush.n) annotation (Line(
            points={{-30,-30},{-80,-30},{-80,30}},
            color={0,0,255}));
        annotation (
          defaultComponentName="smee",
          Icon(graphics={
              Ellipse(extent={{-134,34},{-66,-34}}, lineColor={85,170,255}),
              Line(points={{-100,50},{-100,20},{-130,20},{-130,-4}}, color={0,0,
                    255}),
              Line(points={{-130,-4},{-129,1},{-125,5},{-120,6},{-115,5},{-111,
                    1},{-110,-4}}, color={0,0,255}),
              Line(points={{-110,-4},{-109,1},{-105,5},{-100,6},{-95,5},{-91,1},
                    {-90,-4}}, color={0,0,255}),
              Line(points={{-90,-4},{-89,1},{-85,5},{-80,6},{-75,5},{-71,1},{-70,
                    -4}}, color={0,0,255}),
              Line(points={{-100,-50},{-100,-20},{-70,-20},{-70,-2}}, color={0,
                    0,255})}),
          Documentation(info="<html>
<p>
Resistances and stray inductances of the machine refer to an <code>m</code> phase stator. The symmetry of the stator and the supply are assumed. For rotor asymmetries can be taken into account by different resistances and stray inductances in the d- and q-axis. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>heat losses in the temperature dependent excitation winding resistance</li>
<li>optional, when enabled: heat losses in the temperature dependent damper cage resistances</li>
<li>brush losses in the excitation circuit</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet\">
SM_PermanentMagnet</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ReluctanceRotor\">
SM_ReluctanceRotor</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet\">
Magnetic.FundamentalWave.BasicMachines.SM_PermanentMagnet</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited\">
Magnetic.FundamentalWave.BasicMachines.SM_ElectricalExcited</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor\">
Magnetic.FundamentalWave.BasicMachines.SM_ReluctanceRotor</a>,
</p>
</html>"));
      end SM_ElectricalExcited;

      model SM_ReluctanceRotor
        "Synchronous reluctance machine with optional damper cage"
        extends BaseClasses.PartialBasicMachine(
          Rs(start=0.03),
          Lssigma(start=0.1/(2*pi*fsNominal)),
          final L0(d=2.0*Lmd/m/effectiveStatorTurns^2, q=2.0*Lmq/m/
                effectiveStatorTurns^2),
          redeclare final
            Modelica.Electrical.Machines.Thermal.SynchronousInductionMachines.ThermalAmbientSMR
            thermalAmbient(final useDamperCage=useDamperCage, final Tr=
                TrOperational),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMR
            thermalPort(final useDamperCage=useDamperCage),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMR
            internalThermalPort(final useDamperCage=useDamperCage),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceSMR
            powerBalance(final lossPowerRotorWinding=damperCageLossPower,
              final lossPowerRotorCore=0));

        parameter Modelica.SIunits.Temperature TrOperational(start=293.15)
          "Operational temperature of (optional) damper cage" annotation (
            Dialog(group="Operational temperatures", enable=not useThermalPort
                 and useDamperCage));
        parameter Modelica.SIunits.Inductance Lmd(start=2.9/(2*pi*fsNominal))
          "Stator main field inductance per phase, d-axis" annotation (Dialog(
              tab="Nominal resistances and inductances", groupImage=
                "modelica://Modelica/Resources/Images/Electrical/Machines/SMR.png"));
        parameter Modelica.SIunits.Inductance Lmq(start=0.9/(2*pi*fsNominal))
          "Stator main field inductance per phase, q-axis"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        // Rotor cage parameters
        parameter Boolean useDamperCage(start=true)
          "Enable/disable damper cage" annotation (Dialog(tab=
                "Nominal resistances and inductances", group="DamperCage"));
        parameter Modelica.SIunits.Inductance Lrsigmad(start=0.05/(2*pi*
              fsNominal))
          "Rotor leakage inductance, d-axis, w.r.t. stator side" annotation (
            Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigmad
          "Rotor leakage inductance, q-axis, w.r.t. stator side" annotation (
            Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrd(start=0.04)
          "Rotor resistance, d-axis, w.r.t. stator side" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrq=Rrd
          "Rotor resistance , q-axis, w.r.t. stator side" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Temperature TrRef(start=293.15)
          "Reference temperature of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20r(start=0)
          "Temperature coefficient of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        Modelica.ComplexBlocks.Interfaces.ComplexOutput ir[2] if useDamperCage
          "Damper cage currents";
        FundamentalWave.Components.Short short if not useDamperCage
          "Magnetic connection in case the damper cage is not present"
          annotation (Placement(transformation(
              origin={10,-40},
              extent={{10,10},{-10,-10}},
              rotation=270)));
        Components.SaliencyCageWinding rotorCage(
          final RRef(d=Rrd, q=Rrq),
          final Lsigma(d=Lrsigmad, q=Lrsigmaq),
          final useHeatPort=true,
          final TRef=TrRef,
          final TOperational=TrOperational,
          final alpha20=alpha20r,
          final effectiveTurns=sqrt(m/2.0)*effectiveStatorTurns) if
          useDamperCage
          "Symmetric rotor cage winding including resistances and stray inductances"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={20,-40})));
      protected
        Modelica.Blocks.Interfaces.RealOutput damperCageLossPower(final
            quantity="Power", final unit="W") "Damper losses";
      equation
        connect(ir, rotorCage.i);
        connect(damperCageLossPower, rotorCage.lossPower);
        if not useDamperCage then
          damperCageLossPower = 0;
        end if;
        connect(rotorCage.port_n, airGap.port_rp) annotation (Line(
            points={{20,-30},{10,-30},{10,-10}},
            color={255,128,0}));
        connect(short.port_n, airGap.port_rp) annotation (Line(
            points={{10,-30},{10,-10}},
            color={255,128,0}));
        connect(rotorCage.port_p, airGap.port_rn) annotation (Line(
            points={{20,-50},{-10,-50},{-10,-10}},
            color={255,128,0}));
        connect(short.port_p, airGap.port_rn) annotation (Line(
            points={{10,-50},{-10,-50},{-10,-10}},
            color={255,128,0}));
        connect(rotorCage.heatPortWinding, internalThermalPort.heatPortRotorWinding)
          annotation (Line(
            points={{30,-40},{40,-40},{40,-80},{-40,-80},{-40,-90}},
            color={191,0,0}));
        annotation (
          defaultComponentName="smr",
          Icon(graphics={
              Rectangle(extent={{-130,10},{-100,-10}}, lineColor={0,0,0}),
              Rectangle(extent={{-100,10},{-70,-10}}, lineColor={0,0,0}),
              Ellipse(extent={{-134,34},{-66,-34}}, lineColor={85,170,255})}),
          Documentation(info="<html>
<p>
Resistances and stray inductances of the machine refer to an <code>m</code> phase stator. The symmetry of the stator and the supply are assumed. For rotor asymmetries can be taken into account by different resistances and stray inductances in the d- and q-axis. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>optional, when enabled: heat losses in the temperature dependent damper cage resistances</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet\">
SM_PermanentMagnet</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited\">
SM_ElectricalExcited</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet\">
Magnetic.FundamentalWave.BasicMachines.SM_PermanentMagnet</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited\">
Magnetic.FundamentalWave.BasicMachines.SM_ElectricalExcited</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor\">
Magnetic.FundamentalWave.BasicMachines.SM_ReluctanceRotor</a>,
</p>
</html>"));
      end SM_ReluctanceRotor;
    end SynchronousMachines;

    package Components "Components for quasi static machine models"
      extends Modelica.Icons.Package;
      model SymmetricMultiPhaseWinding
        "Symmetric winding model coupling electrical and magnetic domain"
        // Orientation changed
        Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug
          plug_p(final m=m) "Positive plug" annotation (Placement(
              transformation(
              origin={-100,100},
              extent={{-10,-10},{10,10}},
              rotation=180)));
        Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug
          plug_n(final m=m) "Negative plug" annotation (Placement(
              transformation(
              origin={-100,-100},
              extent={{-10,-10},{10,10}},
              rotation=180)));
        Interfaces.NegativeMagneticPort port_n "Negative complex magnetic port"
          annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
        Interfaces.PositiveMagneticPort port_p "Positive complex magnetic port"
          annotation (Placement(transformation(extent={{90,90},{110,110}})));
        parameter Integer m=3 "Number of phases";
        parameter Boolean useHeatPort=false
          "Enable / disable (=fixed temperatures) thermal port"
          annotation (Evaluate=true);
        // Resistor model
        parameter Modelica.SIunits.Resistance RRef
          "Winding resistance per phase at TRef";
        parameter Modelica.SIunits.Temperature TRef(start=293.15)
          "Reference temperature of winding";
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20(start=0) "Temperature coefficient of winding at 20 degC";
        final parameter Modelica.SIunits.LinearTemperatureCoefficient alphaRef=
            Modelica.Electrical.Machines.Thermal.convertAlpha(
                  alpha20,
                  TRef,
                  293.15);
        parameter Modelica.SIunits.Temperature TOperational(start=293.15)
          "Operational temperature of winding"
          annotation (Dialog(enable=not useHeatPort));
        parameter Modelica.SIunits.Inductance Lsigma
          "Winding stray inductance per phase";
        parameter Real effectiveTurns=1 "Effective number of turns per phase";
        parameter Modelica.SIunits.Conductance GcRef
          "Electrical reference core loss reluctance";

        Modelica.SIunits.ComplexVoltage v[m]=plug_p.pin.v - plug_n.pin.v
          "Complex voltage";
        Modelica.SIunits.Voltage abs_v[m]=Modelica.ComplexMath.'abs'(v)
          "Magnitude of complex voltage";
        Modelica.SIunits.Angle arg_v[m]=Modelica.ComplexMath.arg(v)
          "Argument of complex voltage";
        Modelica.SIunits.ComplexCurrent i[m]=plug_p.pin.i "Complex current";
        Modelica.SIunits.Current abs_i[m]=Modelica.ComplexMath.'abs'(i)
          "Magnitude of complex current";
        Modelica.SIunits.Angle arg_i[m]=Modelica.ComplexMath.arg(i)
          "Argument of complex current";
        Modelica.SIunits.ActivePower P[m]={Modelica.ComplexMath.real(v[k]*
            Modelica.ComplexMath.conj(i[k])) for k in 1:m} "Active power";
        Modelica.SIunits.ActivePower P_total=sum(P) "Total active power";
        Modelica.SIunits.ReactivePower Q[m]={Modelica.ComplexMath.imag(v[k]*
            Modelica.ComplexMath.conj(i[k])) for k in 1:m} "Reactive power";
        Modelica.SIunits.ReactivePower Q_total=sum(Q) "Total reactive power";
        Modelica.SIunits.ApparentPower S[m]={Modelica.ComplexMath.'abs'(v[k]*
            Modelica.ComplexMath.conj(i[k])) for k in 1:m}
          "Magnitude of complex apparent power";
        Modelica.SIunits.ApparentPower S_total=sqrt(P_total^2 + Q_total^2)
          "Magnitude of total complex apparent power";
        Real pf[m]={cos(Modelica.ComplexMath.arg(Complex(P[k], Q[k]))) for k in
                1:m} "Power factor";

        Modelica.SIunits.ComplexMagneticPotentialDifference V_m=port_p.V_m -
            port_n.V_m "Complex magnetic potential difference";
        Modelica.SIunits.MagneticPotentialDifference abs_V_m=
            Modelica.ComplexMath.'abs'(V_m)
          "Magnitude of complex magnetic potential difference";
        Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
          "Argument of complex magnetic potential difference";
        Modelica.SIunits.ComplexMagneticFlux Phi=port_p.Phi
          "Complex magnetic flux";
        Modelica.SIunits.MagneticFlux abs_Phi=
            Modelica.ComplexMath.'abs'(Phi)
          "Magnitude of complex magnetic flux";
        Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
          "Argument of complex magnetic flux";

        Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter
          electroMagneticConverter(final m=m, final effectiveTurns=
              effectiveTurns) "Symmetric winding" annotation (Placement(
              transformation(extent={{-10,-40},{10,-20}})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor resistor(
          final m=m,
          final useHeatPort=useHeatPort,
          final T_ref=fill(TRef, m),
          final T=fill(TOperational, m),
          R_ref=fill(RRef, m),
          final alpha_ref=fill(alphaRef, m)) "Winding resistor" annotation (
            Placement(transformation(
              origin={-18,70},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding[m] if
             useHeatPort "Heat ports of winding resistors"
          annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortCore if
          useHeatPort "Heat ports of winding resistor"
          annotation (Placement(transformation(extent={{30,-110},{50,-90}})));
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.EddyCurrent
          core(final useHeatPort=useHeatPort, final G=(m/2)*GcRef*
              effectiveTurns^2)
          "Core loss model (currently eddy currents only)" annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={50,-40})));
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Reluctance
          strayReluctance(final R_m(d=m*effectiveTurns^2/2/Lsigma, q=m*
                effectiveTurns^2/2/Lsigma))
          "Stray reluctance equivalent to ideally coupled stray inductances"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={80,30})));
      equation
        connect(resistor.heatPort, heatPortWinding) annotation (Line(
            points={{-28,70},{-40,70},{-40,-100}},
            color={191,0,0}));
        connect(core.heatPort, heatPortCore) annotation (Line(
            points={{40,-50},{40,-100}},
            color={191,0,0}));
        connect(strayReluctance.port_n, core.port_n) annotation (Line(
            points={{80,20},{80,-40},{60,-40}},
            color={255,128,0}));
        connect(electroMagneticConverter.plug_p, resistor.plug_n) annotation (
            Line(
            points={{-10,-20},{-18,-20},{-18,60}},
            color={85,170,255}));
        connect(plug_n, electroMagneticConverter.plug_n) annotation (Line(
            points={{-100,-100},{-100,-40},{-10,-40}},
            color={85,170,255}));
        connect(plug_p, resistor.plug_p) annotation (Line(
            points={{-100,100},{-18,100},{-18,80}},
            color={85,170,255}));
        connect(port_p, electroMagneticConverter.port_p) annotation (Line(
            points={{100,100},{10,100},{10,-20}},
            color={255,170,85}));
        connect(strayReluctance.port_p, port_p) annotation (Line(
            points={{80,40},{80,100},{100,100}},
            color={255,170,85}));
        connect(port_n, core.port_n) annotation (Line(
            points={{100,-100},{100,-40},{60,-40}},
            color={255,170,85}));
        connect(electroMagneticConverter.port_n, core.port_p) annotation (Line(
            points={{10,-40},{40,-40}},
            color={255,170,85}));
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={
              Rectangle(
                extent={{-100,60},{100,-60}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{100,-100},{94,-100},{84,-98},{76,-94},{64,-86},{50,
                    -72},{42,-58},{36,-40},{30,-18},{30,0},{30,18},{34,36},{46,
                    66},{62,84},{78,96},{90,100},{100,100}}, color={255,128,0}),
              Line(points={{40,60},{-100,60},{-100,100}}, color={85,170,255}),
              Line(points={{40,-60},{-100,-60},{-100,-98}}, color={85,170,255}),
              Line(points={{40,60},{100,20},{40,-20},{0,-20},{-40,0},{0,20},{40,
                    20},{100,-20},{40,-60}}, color={85,170,255}),
              Text(
                extent={{0,160},{0,120}},
                lineColor={0,0,255},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid,
                textString="%name")}),
          Documentation(info="<html>
<p>
The symmetrical multi phase winding consists of a symmetrical winding
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor\">resistor</a>, a
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Reluctance\">stray reluctance</a>, a symmetrical
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter\">multi phase electromagnetic coupling</a> and a
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.EddyCurrent\">core loss</a> model including
heat <a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">port</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.Components.QuasiStionaryAnalogWinding\">
QuasiStionaryAnalogWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">
Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseWinding\">
Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseWinding</a>
</p>
</html>"));
      end SymmetricMultiPhaseWinding;

      model QuasiStaticAnalogWinding
        "Quasi static single phase winding neglecting induced voltage"

        Modelica.Electrical.Analog.Interfaces.PositivePin pin_p "Positive pin"
          annotation (Placement(transformation(
              origin={-100,100},
              extent={{-10,-10},{10,10}},
              rotation=180)));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "Negative pin"
          annotation (Placement(transformation(
              origin={-100,-100},
              extent={{-10,-10},{10,10}},
              rotation=180)));
        Interfaces.NegativeMagneticPort port_n "Negative complex magnetic port"
          annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
        Interfaces.PositiveMagneticPort port_p "Positive complex magnetic port"
          annotation (Placement(transformation(extent={{90,90},{110,110}})));
        parameter Boolean useHeatPort=false
          "Enable / disable (=fixed temperatures) thermal port"
          annotation (Evaluate=true);
        parameter Modelica.SIunits.Resistance RRef
          "Winding resistance per phase at TRef";
        parameter Modelica.SIunits.Temperature TRef(start=293.15)
          "Reference temperature of winding";
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20(start=0) "Temperature coefficient of winding at 20 degC";
        final parameter Modelica.SIunits.LinearTemperatureCoefficient alphaRef=
            Modelica.Electrical.Machines.Thermal.convertAlpha(
                  alpha20,
                  TRef,
                  293.15);
        parameter Modelica.SIunits.Temperature TOperational(start=293.15)
          "Operational temperature of winding"
          annotation (Dialog(enable=not useHeatPort));
        parameter Real effectiveTurns=1 "Effective number of turns per phase";

        Modelica.SIunits.Voltage v=pin_p.v - pin_n.v "Voltage";
        Modelica.SIunits.Current i=pin_p.i "Current";

        Modelica.SIunits.ComplexMagneticPotentialDifference V_m=port_p.V_m -
            port_n.V_m "Complex magnetic potential difference";
        Modelica.SIunits.MagneticPotentialDifference abs_V_m=
            Modelica.ComplexMath.'abs'(V_m)
          "Magnitude of complex magnetic potential difference";
        Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
          "Argument of complex magnetic potential difference";
        Modelica.SIunits.ComplexMagneticFlux Phi=port_p.Phi
          "Complex magnetic flux";
        Modelica.SIunits.MagneticFlux abs_Phi=
            Modelica.ComplexMath.'abs'(Phi)
          "Magnitude of complex magnetic flux";
        Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
          "Argument of complex magnetic flux";

        Modelica.Electrical.Analog.Basic.Resistor resistor(
          final useHeatPort=useHeatPort,
          final R=RRef,
          final T_ref=TRef,
          final alpha=alphaRef,
          final T=TOperational) annotation (Placement(transformation(
              origin={-10,70},
              extent={{10,10},{-10,-10}},
              rotation=90)));
        FundamentalWave.Components.QuasiStaticAnalogElectroMagneticConverter
          electroMagneticConverter(final effectiveTurns=effectiveTurns)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding if
          useHeatPort "Heat ports of winding resistor"
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
      equation
        connect(pin_p, resistor.p) annotation (Line(points={{-100,100},{-10,100},
                {-10,80}}, color={0,0,255}));
        connect(electroMagneticConverter.pin_n, pin_n) annotation (Line(points=
                {{-10,-10},{-10,-100},{-100,-100}}, color={0,0,255}));
        connect(electroMagneticConverter.port_p, port_p) annotation (Line(
              points={{10,10},{10,100},{100,100}}, color={255,128,0}));
        connect(electroMagneticConverter.port_n, port_n) annotation (Line(
              points={{10,-10},{10,-100},{100,-100}}, color={255,128,0}));
        connect(heatPortWinding, resistor.heatPort) annotation (Line(
            points={{0,-100},{0,-60},{-40,-60},{-40,70},{-20,70}},
            color={191,0,0}));
        connect(resistor.n, electroMagneticConverter.pin_p) annotation (Line(
            points={{-10,60},{-10,10}},
            color={0,0,255}));
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={
              Rectangle(
                extent={{-100,60},{100,-60}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{100,-100},{94,-100},{84,-98},{76,-94},{64,-86},{50,
                    -72},{42,-58},{36,-40},{30,-18},{30,0},{30,18},{34,36},{46,
                    66},{62,84},{78,96},{90,100},{100,100}}, color={255,128,0}),
              Line(points={{40,60},{-100,60},{-100,100}}, color={0,0,255}),
              Line(points={{40,-60},{-100,-60},{-100,-98}}, color={0,0,255}),
              Line(points={{40,60},{100,20},{40,-20},{0,-20},{-40,0},{0,20},{40,
                    20},{100,-20},{40,-60}}, color={0,0,255}),
              Text(
                extent={{0,160},{0,120}},
                lineColor={0,0,255},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid,
                textString="%name")}),
          Documentation(info="<html>
<p>
The single phase winding consists of a
<a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">resistor</a>,  and a
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter\">single phase electromagnetic coupling</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseWinding\">
SymmetricMultiPhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">
Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseWinding\">
Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseWinding</a>
</p>
</html>"));
      end QuasiStaticAnalogWinding;

      model RotorSaliencyAirGap "Air gap model with rotor saliency"
        import Modelica.Constants.pi;
        Interfaces.PositiveMagneticPort port_sp
          "Positive complex magnetic stator port" annotation (Placement(
              transformation(extent={{-110,-110},{-90,-90}})));
        Interfaces.NegativeMagneticPort port_sn
          "Negative complex magnetic stator port" annotation (Placement(
              transformation(extent={{-110,90},{-90,110}})));
        Interfaces.PositiveMagneticPort port_rp
          "Positive complex magnetic rotor port" annotation (Placement(
              transformation(extent={{90,90},{110,110}})));
        Interfaces.NegativeMagneticPort port_rn
          "Negative complex magnetic rotor port" annotation (Placement(
              transformation(extent={{90,-110},{110,-90}})));
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
          "Flange of the rotor" annotation (Placement(transformation(extent={{-10,
                  110},{10,90}})));
        Modelica.Mechanics.Rotational.Interfaces.Flange_a support
          "Support at which the reaction torque is acting" annotation (
            Placement(transformation(extent={{-10,-110},{10,-90}})));
        parameter Integer p "Number of pole pairs";
        parameter Modelica.Magnetic.FundamentalWave.Types.SalientInductance L0(
            d(start=1), q(start=1))
          "Salient inductance of a single unchorded coil w.r.t. the fundamental wave";
        final parameter
          Modelica.Magnetic.FundamentalWave.Types.SalientReluctance R_m(d=1/L0.d,
            q=1/L0.q) "Reluctance of the air gap model";
        // Complex phasors of magnetic potential differences
        Modelica.SIunits.ComplexMagneticPotentialDifference V_ms
          "Complex magnetic potential difference of stator w.r.t. stator reference frame";
        Modelica.SIunits.ComplexMagneticPotentialDifference V_msr=V_ms*
            Modelica.ComplexMath.fromPolar(1, gammar)
          "Complex magnetic potential difference of stator w.r.t. rotor fixed reference frame";
        Modelica.SIunits.ComplexMagneticPotentialDifference V_mr
          "Complex magnetic potential difference of rotor w.r.t. rotor reference frame";
        Modelica.SIunits.ComplexMagneticPotentialDifference V_mrr=V_mr*
            Modelica.ComplexMath.fromPolar(1, gammar)
          "Complex magnetic potential difference of rotor w.r.t. rotor fixed reference frame";
        // Complex phasors of magnetic fluxes
        Modelica.SIunits.ComplexMagneticFlux Phi_s
          "Complex magnetic flux of stator w.r.t. stator reference frame";
        Modelica.SIunits.ComplexMagneticFlux Phi_sr=Phi_s*
            Modelica.ComplexMath.fromPolar(1, gammar)
          "Complex magnetic flux of stator w.r.t. rotor fixed reference frame";
        Modelica.SIunits.ComplexMagneticFlux Phi_r
          "Complex magnetic flux of rotor w.r.t. rotor reference frame";
        Modelica.SIunits.ComplexMagneticFlux Phi_rr=Phi_r*
            Modelica.ComplexMath.fromPolar(1, gammar)
          "Complex magnetic flux of rotor w.r.t. rotor fixed reference frame";
        // Electrical torque and mechanical angle
        Modelica.SIunits.Torque tauElectrical "Electrical torque";
        // Modelica.SIunits.Torque tauTemp "Electrical torque";
        Modelica.SIunits.Angle gamma=p*(flange_a.phi - support.phi)
          "Electrical angle between rotor and stator";
        Modelica.SIunits.Angle gammas=port_sp.reference.gamma
          "Angle electrical quantities in stator reference frame";
        Modelica.SIunits.Angle gammar=port_rp.reference.gamma
          "Angle electrical quantities in rotor reference frame";
      equation
        // Stator flux into positive stator port
        port_sp.Phi = Phi_s;
        // Balance of stator flux
        port_sp.Phi + port_sn.Phi = Complex(0, 0);
        // Rotor flux into positive rotor port
        port_rp.Phi = Phi_r;
        // Balance of rotor flux
        port_rp.Phi + port_rn.Phi = Complex(0, 0);
        // Magneto motive force of stator
        port_sp.V_m - port_sn.V_m = V_ms;
        // Magneto motive force of stator
        port_rp.V_m - port_rn.V_m = V_mr;
        // Stator and rotor flux are equal with respect to different reference frames
        Phi_s = Phi_r;
        // Local balance of magneto motive force
        (pi/2.0)*(V_mrr.re + V_msr.re) = Phi_rr.re*R_m.d;
        (pi/2.0)*(V_mrr.im + V_msr.im) = Phi_rr.im*R_m.q;
        // Torque
        tauElectrical = -(pi*p/2.0)*(Phi_s.im*V_ms.re - Phi_s.re*V_ms.im);
        flange_a.tau = -tauElectrical;
        support.tau = tauElectrical;
        // Potential root of rotor has been removed. Only the stator positive
        //   plug is a potential root so that being a root determines that not
        //   electrical stator root is connected from outside; in this case the
        //   machine is operated as generator and the rotor angle is set to zero.
        // Magnetic stator and rotor port are (again) connected through
        //   Connections.branch, even though it is not clear yet whether this
        //   implementation is Modelica compliant
        Connections.potentialRoot(port_sp.reference);
        // Connections.potentialRoot(port_rp.reference);
        Connections.branch(port_sp.reference, port_sn.reference);
        port_sp.reference.gamma = port_sn.reference.gamma;
        Connections.branch(port_rp.reference, port_rn.reference);
        port_rp.reference.gamma = port_rn.reference.gamma;
        Connections.branch(port_sp.reference, port_rp.reference);
        gammas = gammar + gamma;
        if Connections.isRoot(port_sp.reference) then
          gammar = 0;
        end if;
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={
              Ellipse(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-100,90},{-100,60},{-80,60}}, color={255,128,0}),
              Line(points={{-100,-90},{-100,-60},{-80,-60}}, color={255,128,0}),
              Line(points={{40,60},{100,60},{100,90}}, color={255,128,0}),
              Line(points={{40,-60},{100,-60},{100,-90}}, color={255,128,0}),
              Ellipse(
                extent={{-60,80},{60,-80}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{0,80},{0,90}})}),
          Documentation(info="<html>
<p>
This salient air gap model can be used for machines with uniform airgaps and for machines with rotor saliencies. The air gap model is not symmetrical towards stator and rotor since it is assumed the saliency always refers to the rotor. The saliency of the air gap is represented by a main field inductance in the d- and q-axis.
</p>

<p>
For the mechanical interaction of the air gap model with the stator and the rotor it is equipped with to
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.Flange_a\">rotational connectors</a>. The torques acting on both connectors have the same absolute values but different signs. The stator and the rotor reference angles,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_s.png\"> and
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_r.png\"> are related by
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_relationship.png\">
where
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma.png\">
is the electrical angle between stator and rotor.
</p>

<p>
The air gap model has two magnetic stator and two magnetic rotor
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.MagneticPort\">ports</a>. The magnetic potential difference and the magnetic flux of the stator and rotor are equal complex quantities, respectively, but the reference angles are different; see <a href=\"Modelica.Magnetic.QuasiStatic.FundamentalWave.UsersGuide.Concept\">Concept</a>. The d and q axis components with respect to the rotor fixed reference frame (superscript r) are determined from the stator (superscript s) and rotor (superscript r) reference quantities, by
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/V_m_transformation.png\">.
</p>

<p>
The d and q axis magnetic potential difference components and flux components are related with the flux by:
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Machines/Components/airgap.png\">
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">
Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap</a>
</p>

</html>"));
      end RotorSaliencyAirGap;

      model SymmetricMultiPhaseCageWinding "Symmetrical rotor cage"
        import Modelica.Constants.pi;
        extends
          Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.PartialTwoPortExtended;
        parameter Integer m=3 "Number of phases";
        parameter Boolean useHeatPort=false
          "Enable / disable (=fixed temperatures) thermal port"
          annotation (Evaluate=true);
        parameter Modelica.SIunits.Resistance RRef
          "Winding resistance per phase at TRef";
        parameter Modelica.SIunits.Temperature TRef(start=293.15)
          "Reference temperature of winding";
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20(start=0) "Temperature coefficient of winding at 20 degC";
        final parameter Modelica.SIunits.LinearTemperatureCoefficient alphaRef=
            Modelica.Electrical.Machines.Thermal.convertAlpha(
                  alpha20,
                  TRef,
                  293.15);
        parameter Modelica.SIunits.Temperature TOperational(start=293.15)
          "Operational temperature of winding"
          annotation (Dialog(enable=not useHeatPort));
        parameter Modelica.SIunits.Inductance Lsigma "Cage stray inductance";
        parameter Real effectiveTurns=1 "Effective number of turns";
        Modelica.SIunits.ComplexCurrent i[m]=electroMagneticConverter.i
          "Cage currents";
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter
          electroMagneticConverter(final m=m, final effectiveTurns=
              effectiveTurns) "Symmetric winding" annotation (Placement(
              transformation(
              origin={0,-10},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor resistor(
          final useHeatPort=useHeatPort,
          final m=m,
          final T_ref=fill(TRef, m),
          final T=fill(TRef, m),
          R_ref=fill(RRef, m),
          alpha_ref=fill(alphaRef, m)) annotation (Placement(transformation(
              origin={-20,-50},
              extent={{10,10},{-10,-10}},
              rotation=90)));
        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star(final m=
              m) annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
        Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground
          annotation (Placement(transformation(
              origin={70,-20},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding if
          useHeatPort "Heat ports of winding resistor"
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
        Modelica.Thermal.HeatTransfer.Components.ThermalCollector
          thermalCollector(final m=m) if useHeatPort
          "Connector of thermal rotor resistance heat ports"
          annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starAuxiliary(
            final m=m) annotation (Placement(transformation(extent={{30,-90},{
                  50,-70}})));
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Reluctance
          strayReluctance(final R_m(d=m*effectiveTurns^2/2/Lsigma, q=m*
                effectiveTurns^2/2/Lsigma))
          "Stray reluctance equivalent to ideally coupled stray inductances"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={0,20})));
      equation
        connect(thermalCollector.port_a, resistor.heatPort) annotation (Line(
            points={{-40,-70},{-40,-50},{-30,-50}},
            color={191,0,0}));
        connect(thermalCollector.port_b, heatPortWinding) annotation (Line(
            points={{-40,-90},{-40,-100},{0,-100}},
            color={191,0,0}));
        connect(port_p, electroMagneticConverter.port_p) annotation (Line(
            points={{-100,0},{-10,0}},
            color={255,170,85}));
        connect(electroMagneticConverter.port_n, port_n) annotation (Line(
            points={{10,0},{100,0}},
            color={255,170,85}));
        connect(starAuxiliary.plug_p, resistor.plug_n) annotation (Line(
            points={{30,-80},{-20,-80},{-20,-60}},
            color={85,170,255}));
        connect(electroMagneticConverter.plug_n, star.plug_p) annotation (Line(
            points={{10,-20},{30,-20}},
            color={85,170,255}));
        connect(star.pin_n, ground.pin) annotation (Line(
            points={{50,-20},{60,-20}},
            color={85,170,255}));
        connect(starAuxiliary.pin_n, ground.pin) annotation (Line(
            points={{50,-80},{60,-80},{60,-20}},
            color={85,170,255}));
        connect(strayReluctance.port_p, port_p) annotation (Line(
            points={{-10,20},{-30,20},{-30,0},{-100,0}},
            color={255,170,85}));
        connect(strayReluctance.port_n, port_n) annotation (Line(
            points={{10,20},{30,20},{30,0},{100,0}},
            color={255,170,85}));
        connect(electroMagneticConverter.plug_p, resistor.plug_p) annotation (
            Line(
            points={{-10,-20},{-20,-20},{-20,-40}},
            color={85,170,255}));
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={Ellipse(
                      extent={{-80,80},{80,-80}},
                      lineColor={0,0,0},
                      fillColor={175,175,175},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-20,76},{20,36}},
                      lineColor={0,0,0},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{28,46},{68,6}},
                      lineColor={0,0,0},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{28,-8},{68,-48}},
                      lineColor={0,0,0},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-20,-36},{20,-76}},
                      lineColor={0,0,0},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-68,-6},{-28,-46}},
                      lineColor={0,0,0},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-66,50},{-26,10}},
                      lineColor={0,0,0},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Line(points={{-80,0},{-100,
                0}}, color={255,128,0}),Line(points={{100,0},{80,0}}, color={
                255,128,0}),Text(
                      extent={{0,100},{0,140}},
                      lineColor={0,0,255},
                      textString="%name")}),
          Documentation(info="<html>
<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Machines/Components/rotorcage.png\">
</p>

<p>
The symmetric rotor cage model of this library does not consist of rotor bars and end rings. Instead the symmetric cage is modeled by an equivalent symmetrical winding. The rotor cage model consists of
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\"> phases. If the cage is modeled by equivalent stator winding parameters, the number of effective turns,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/effectiveTurns.png\">, has to be chosen equivalent to the effective number of stator turns.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.Components.SaliencyCageWinding\">
SaliencyCageWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseCageWinding\">
Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseCageWinding</a>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">
Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap</a>
</p>
</html>"));
      end SymmetricMultiPhaseCageWinding;

      model SaliencyCageWinding "Rotor cage with saliency in d- and q-axis"
        extends
          Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.PartialTwoPortExtended;
        parameter Boolean useHeatPort=false
          "Enable / disable (=fixed temperatures) thermal port"
          annotation (Evaluate=true);
        parameter Modelica.Magnetic.FundamentalWave.Types.SalientResistance
          RRef(d(start=1), q(start=1)) "Salient cage resistance";
        parameter Modelica.SIunits.Temperature TRef(start=293.15)
          "Reference temperature of winding";
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20(start=0) "Temperature coefficient of winding at 20 degC";
        final parameter Modelica.SIunits.LinearTemperatureCoefficient alphaRef=
            Modelica.Electrical.Machines.Thermal.convertAlpha(
                  alpha20,
                  TRef,
                  293.15);
        parameter Modelica.SIunits.Temperature TOperational(start=293.15)
          "Operational temperature of winding"
          annotation (Dialog(enable=not useHeatPort));
        parameter Modelica.Magnetic.FundamentalWave.Types.SalientInductance
          Lsigma(d(start=1), q(start=1)) "Salient cage stray inductance";
        parameter Real effectiveTurns=1 "Effective number of turns";
        Modelica.ComplexBlocks.Interfaces.ComplexOutput i[2]=
            electroMagneticConverter.i "Cage currents";
        Modelica.Blocks.Interfaces.RealOutput lossPower(
          final quantity="Power",
          final unit="W") = sum(resistor.resistor.LossPower) "Damper losses";
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter
          electroMagneticConverter(final m=2, final effectiveTurns=
              effectiveTurns) annotation (Placement(transformation(
              origin={0,-10},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor resistor(
          final useHeatPort=useHeatPort,
          final m=2,
          final T_ref=fill(TRef, 2),
          final T=fill(TOperational, 2),
          R_ref={RRef.d,RRef.q},
          alpha_ref=fill(alphaRef, 2)) annotation (Placement(transformation(
              origin={-20,-50},
              extent={{10,10},{-10,-10}},
              rotation=90)));
        Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star(final m=
              2) annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
        Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground
          annotation (Placement(transformation(
              origin={70,-80},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding if
          useHeatPort "Heat ports of winding resistor"
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
        Modelica.Thermal.HeatTransfer.Components.ThermalCollector
          thermalCollector(final m=2) if useHeatPort
          "Connector of thermal rotor resistance heat ports"
          annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Reluctance
          strayReluctance(final R_m(d=effectiveTurns^2/Lsigma.d, q=
                effectiveTurns^2/Lsigma.q))
          "Stray reluctance equivalent to ideally coupled stray inductances"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={0,20})));
      equation
        connect(thermalCollector.port_b, heatPortWinding) annotation (Line(
            points={{-40,-90},{-40,-100},{0,-100}},
            color={191,0,0}));
        connect(resistor.heatPort, thermalCollector.port_a) annotation (Line(
            points={{-30,-50},{-40,-50},{-40,-70}},
            color={191,0,0}));
        connect(port_p, electroMagneticConverter.port_p) annotation (Line(
            points={{-100,0},{-10,0}},
            color={255,170,85}));
        connect(electroMagneticConverter.port_n, port_n) annotation (Line(
            points={{10,0},{100,0}},
            color={255,170,85}));
        connect(electroMagneticConverter.plug_n, resistor.plug_n) annotation (
            Line(
            points={{10,-20},{20,-20},{20,-80},{-20,-80},{-20,-60}},
            color={85,170,255}));
        connect(resistor.plug_n, star.plug_p) annotation (Line(
            points={{-20,-60},{-20,-80},{30,-80}},
            color={85,170,255}));
        connect(star.pin_n, ground.pin) annotation (Line(
            points={{50,-80},{60,-80}},
            color={85,170,255}));
        connect(electroMagneticConverter.plug_p, resistor.plug_p) annotation (
            Line(
            points={{-10,-20},{-20,-20},{-20,-40}},
            color={85,170,255}));
        connect(strayReluctance.port_p, port_p) annotation (Line(
            points={{-10,20},{-30,20},{-30,0},{-100,0}},
            color={255,170,85}));
        connect(strayReluctance.port_n, port_n) annotation (Line(
            points={{10,20},{30,20},{30,0},{100,0}},
            color={255,170,85}));
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={
              Ellipse(
                extent={{-80,80},{80,-80}},
                lineColor={0,0,0},
                fillColor={175,175,175},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-20,76},{20,36}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{28,46},{68,6}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{28,-8},{68,-48}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-20,-36},{20,-76}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-68,-6},{-28,-46}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-66,50},{-26,10}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,0},{-100,0}}, color={255,128,0}),
              Line(points={{100,0},{80,0}}, color={255,128,0}),
              Text(
                extent={{0,100},{0,140}},
                lineColor={0,0,255},
                textString="%name")}),
          Documentation(info="<html>

<p>
The salient cage model is a two axis model with two phases. The electromagnetic coupling therefore is also two phase coupling model. The angles of the two orientations are 0 and <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/pi_over_2.png\">. This way an asymmetrical rotor cage with different resistances and stray inductances in d- and q-axis can be modeled.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseCageWinding\">
SymmetricMultiPhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseCageWinding\">
Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseCageWinding</a>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">
Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap</a>
</p>
</html>"));
      end SaliencyCageWinding;

      model PermanentMagnet
        "Permanent magnet model without intrinsic reluctance, represented by magnetic potential difference"
        import Modelica;
        extends FundamentalWave.Losses.PermanentMagnetLosses;
        extends
          Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.PartialTwoPort;
        parameter Modelica.SIunits.ComplexMagneticPotentialDifference V_m=
            Complex(re=1, im=0)
          "Complex magnetic potential difference w.r.t. the rotor fixed reference frame";
        Modelica.SIunits.MagneticPotentialDifference abs_V_m=
            Modelica.ComplexMath.'abs'(V_m)
          "Magnitude of complex magnetic potential difference";
        Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
          "Argument of complex magnetic potential difference w.r.t. reference frame";

        Modelica.SIunits.Angle gamma "Angle of V_m fixed reference frame";
        Modelica.SIunits.ComplexMagneticFlux Phi "Complex magnetic flux";
        Modelica.SIunits.MagneticPotentialDifference abs_Phi=
            Modelica.ComplexMath.'abs'(Phi)
          "Magnitude of complex magnetic flux";
        Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
          "Argument of complex magnetic flux";
        Modelica.SIunits.ComplexMagneticPotentialDifference V_mGamma=V_m*
            Modelica.ComplexMath.fromPolar(1, -gamma)
          "Magnetic potential difference w.r.t. the reference frame";
      equation
        // Magneto motive force with respect to rotor fixed reference
        port_p.V_m - port_n.V_m = V_mGamma;
        // Flux into positive port with respect to rotor fixed reference
        port_p.Phi = Phi;
        // Local flux balance
        port_p.Phi + port_n.Phi = Complex(0, 0);
        // Reference angular speed and angle
        gamma = port_p.reference.gamma;
        // Connections.root(port_p.reference);
        annotation (
          Documentation(info="<html>
<p>Permanent magnet model with magnetic, mechanical and thermal connector including losses. The PM model is source  of constant magnetic potential difference. The PM loss is calculated by
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Losses.PermanentMagnetLosses\">PermanentMagnetLosses</a>.
</p>
</html>"),          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={Line(
                points={{-100,0},{100,0}},
                color={255,170,85}), Ellipse(extent={{-50,50},{50,-50}},
                  lineColor={255,170,85})}));
      end PermanentMagnet;
    end Components;

    package BaseClasses "Partial models for machines"
      extends Modelica.Icons.BasesPackage;

      partial model PartialBasicMachine
        "Partial model for quasi static multi phase machines"
        import Modelica;
        import Modelica.Constants.pi;
        extends Electrical.Machines.Icons.QuasiStaticFundamentalWaveMachine;
        parameter Integer m(min=3) = 3 "Number of stator phases";
        // Mechanical parameters
        parameter Modelica.SIunits.Inertia Jr(start=0.29) "Rotor inertia";
        parameter Boolean useSupport=false
          "Enable / disable (=fixed stator) support" annotation (Evaluate=true);
        parameter Modelica.SIunits.Inertia Js(start=Jr) "Stator inertia"
          annotation (Dialog(enable=useSupport));
        parameter Boolean useThermalPort=false
          "Enable / disable (=fixed temperatures) thermal port"
          annotation (Evaluate=true);
        parameter Integer p(min=1, start=2) "Number of pole pairs (Integer)";
        parameter Modelica.SIunits.Frequency fsNominal(start=50)
          "Nominal frequency";
        parameter Modelica.SIunits.Temperature TsOperational(start=293.15)
          "Operational temperature of stator resistance" annotation (Dialog(
              group="Operational temperatures", enable=not useThermalPort));
        parameter Modelica.SIunits.Resistance Rs(start=0.03)
          "Stator resistance per phase at TRef"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature TsRef(start=293.15)
          "Reference temperature of stator resistance"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20s(start=0)
          "Temperature coefficient of stator resistance at 20 degC"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Real effectiveStatorTurns=1
          "Effective number of stator turns";
        parameter Modelica.SIunits.Inductance Lssigma(start=3*(1 - sqrt(1 -
              0.0667))/(2*pi*fsNominal)) "Stator stray inductance per phase"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.Magnetic.FundamentalWave.Types.SalientInductance L0(
            d(start=1), q(start=1)) "Salient inductance of an unchorded coil"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.Electrical.Machines.Losses.FrictionParameters
          frictionParameters(wRef=2*pi*fsNominal/p)
          "Friction loss parameter record" annotation (Dialog(tab="Losses"));
        parameter Modelica.Electrical.Machines.Losses.CoreParameters
          statorCoreParameters(
          final m=3,
          wRef=2*pi*fsNominal/p,
          VRef(start=100))
          "Stator core loss parameter record; all parameters refer to stator side"
          annotation (Dialog(tab="Losses"));
        parameter Modelica.Electrical.Machines.Losses.StrayLoadParameters
          strayLoadParameters(IRef(start=100), wRef=2*pi*fsNominal/p)
          "Stray load loss parameter record" annotation (Dialog(tab="Losses"));
        output Modelica.SIunits.Angle gammas(start=0) = airGap.gammas
          "Angle of stator reference frame";
        output Modelica.SIunits.Angle gammar(start=0) = airGap.gammar
          "Angle of stator reference frame";
        output Modelica.SIunits.Angle gamma(start=0) = airGap.gamma
          "Electrical angle between stator and rotor";
        // Mechanical quantities
        output Modelica.SIunits.Angle phiMechanical=flange.phi -
            internalSupport.phi "Mechanical angle of rotor against stator";
        output Modelica.SIunits.AngularVelocity wMechanical(
          start=0,
          displayUnit="rev/min") = der(phiMechanical)
          "Mechanical angular velocity of rotor against stator";
        output Modelica.SIunits.Torque tauElectrical=inertiaRotor.flange_a.tau
          "Electromagnetic torque";
        output Modelica.SIunits.Torque tauShaft=-flange.tau "Shaft torque";
        replaceable output
          Modelica.Electrical.Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines
          powerBalance(
          final powerStator=
              Electrical.QuasiStationary.MultiPhase.Functions.activePower(vs,
              is),
          final powerMechanical=wMechanical*tauShaft,
          final powerInertiaStator=inertiaStator.J*inertiaStator.a*
              inertiaStator.w,
          final powerInertiaRotor=inertiaRotor.J*inertiaRotor.a*inertiaRotor.w,
          final lossPowerStatorWinding=sum(stator.resistor.resistor.LossPower),
          final lossPowerStatorCore=stator.core.lossPower,
          final lossPowerStrayLoad=strayLoad.lossPower,
          final lossPowerFriction=friction.lossPower) "Power balance";

        // Stator voltages and currents
        output Modelica.SIunits.ComplexVoltage vs[m]=plug_sp.pin.v - plug_sn.pin.v
          "Complex stator voltage";
        Modelica.SIunits.Voltage abs_vs[m]=Modelica.ComplexMath.'abs'(vs)
          "Magnitude of complex stator voltage";
        Modelica.SIunits.Angle arg_vs[m]=Modelica.ComplexMath.arg(vs)
          "Argument of complex stator voltage";

        output Modelica.SIunits.ComplexCurrent is[m]=plug_sp.pin.i
          "Complex stator current";
        Modelica.SIunits.Current abs_is[m]=Modelica.ComplexMath.'abs'(is)
          "Magnitude of complex stator current";
        Modelica.SIunits.Angle arg_is[m]=Modelica.ComplexMath.arg(is)
          "Argument of complex stator current";

        Modelica.SIunits.ActivePower Ps[m]={Modelica.ComplexMath.real(vs[k]*
            Modelica.ComplexMath.conj(is[k])) for k in 1:m}
          "Active stator power";
        Modelica.SIunits.ActivePower Ps_total=sum(Ps)
          "Total active stator power";
        Modelica.SIunits.ReactivePower Qs[m]={Modelica.ComplexMath.imag(vs[k]*
            Modelica.ComplexMath.conj(is[k])) for k in 1:m}
          "Reactive stator power";
        Modelica.SIunits.ReactivePower Qs_total=sum(Qs)
          "Total reactive stator power";
        Modelica.SIunits.ApparentPower Ss[m]={Modelica.ComplexMath.'abs'(vs[k]*
            Modelica.ComplexMath.conj(is[k])) for k in 1:m}
          "Magnitude of complex stator apparent power";
        Modelica.SIunits.ApparentPower Ss_total=sqrt(Ps_total^2 + Qs_total^2)
          "Magnitude of total complex stator apparent power";
        Real pfs[m]={cos(Modelica.ComplexMath.arg(Complex(Ps[k], Qs[k]))) for k in
                1:m} "Stator power factor";

        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange "Shaft"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Mechanics.Rotational.Components.Inertia inertiaRotor(final J=
              Jr) annotation (Placement(transformation(
              origin={80,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
        Modelica.Mechanics.Rotational.Interfaces.Flange_a support if useSupport
          "Support at which the reaction torque is acting" annotation (
            Placement(transformation(extent={{90,-110},{110,-90}})));
        Modelica.Mechanics.Rotational.Components.Inertia inertiaStator(final J=
              Js) annotation (Placement(transformation(
              origin={80,-100},
              extent={{10,10},{-10,-10}},
              rotation=180)));
        Modelica.Mechanics.Rotational.Components.Fixed fixed if (not useSupport)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={70,-90})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug
          plug_sp(final m=m) "Positive plug of stator" annotation (Placement(
              transformation(extent={{50,90},{70,110}})));
        Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug
          plug_sn(final m=m) "Negative plug of stator" annotation (Placement(
              transformation(extent={{-70,90},{-50,110}})));
        BasicMachines.Components.SymmetricMultiPhaseWinding stator(
          final useHeatPort=true,
          final m=m,
          final RRef=Rs,
          final TRef=TsRef,
          final Lsigma=Lssigma,
          final effectiveTurns=effectiveStatorTurns,
          final TOperational=TsOperational,
          final GcRef=statorCoreParameters.GcRef,
          final alpha20=alpha20s)
          "Symmetric stator winding including resistances, zero and stray inductances and core losses"
          annotation (Placement(transformation(
              origin={0,40},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        replaceable
          Modelica.Electrical.Machines.Interfaces.InductionMachines.PartialThermalAmbientInductionMachines
          thermalAmbient(
          final useTemperatureInputs=false,
          final Ts=TsOperational,
          final m=m) if not useThermalPort annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-70,-90})));
        replaceable
          Modelica.Electrical.Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines
          thermalPort(final m=m) if useThermalPort
          "Thermal port of induction machines"
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Ground groundS
          "Ground of stator magnetic circuit" annotation (Placement(
              transformation(extent={{-38,30},{-18,10}})));
        BasicMachines.Components.RotorSaliencyAirGap airGap(final p=p, final L0=
             L0) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Ground groundR
          "Ground of rotor magnetic circuit" annotation (Placement(
              transformation(extent={{-40,-30},{-20,-10}})));
        Losses.StrayLoad strayLoad(
          final strayLoadParameters=strayLoadParameters,
          final useHeatPort=true,
          final m=m)
          annotation (Placement(transformation(extent={{60,60},{40,80}})));
        Modelica.Electrical.Machines.Losses.Friction friction(final
            frictionParameters=frictionParameters, final useHeatPort=true)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={90,-30})));
      protected
        constant Real pi = Modelica.Constants.pi;
        replaceable
          Modelica.Electrical.Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines
          internalThermalPort(final m=m)
          annotation (Placement(transformation(extent={{-44,-94},{-36,-86}})));
        Modelica.Mechanics.Rotational.Interfaces.Support internalSupport
          annotation (Placement(transformation(extent={{56,-104},{64,-96}})));
      initial algorithm
        assert(not Modelica.Math.isPowerOf2(m), String(m) +
          " phases are currently not supported in this version of FundametalWave");

      equation
        connect(stator.plug_n, plug_sn) annotation (Line(
            points={{-10,50},{-10,70},{-60,70},{-60,100}},
            color={85,170,255}));
        connect(inertiaRotor.flange_b, flange)
          annotation (Line(points={{90,0},{100,0},{100,0}}));
        connect(internalSupport, inertiaStator.flange_a) annotation (Line(
            points={{60,-100},{70,-100}}));
        connect(internalSupport, fixed.flange) annotation (Line(
            points={{60,-100},{60,-90},{70,-90}}));
        connect(inertiaStator.flange_b, support) annotation (Line(points={{90,-100},
                {90,-100},{100,-100}}));
        connect(airGap.flange_a, inertiaRotor.flange_a) annotation (Line(
            points={{10,0},{25,0},{25,0},{40,0},{40,0},{70,0}}));
        connect(airGap.support, internalSupport) annotation (Line(
            points={{-10,0},{-50,0},{-50,-70},{60,-70},{60,-100}}));
        connect(groundR.port_p, airGap.port_rn) annotation (Line(points={{-30,-10},
                {-30,-10},{-10,-10}}, color={255,128,0}));
        connect(stator.plug_p, strayLoad.plug_n) annotation (Line(
            points={{10,50},{10,70},{40,70}},
            color={85,170,255}));
        connect(plug_sp, strayLoad.plug_p) annotation (Line(
            points={{60,100},{60,94},{60,94},{60,86},{60,86},{60,70}},
            color={85,170,255}));
        connect(strayLoad.support, internalSupport) annotation (Line(
            points={{50,60},{50,50},{60,50},{60,-100}}));
        connect(strayLoad.heatPort, internalThermalPort.heatPortStrayLoad)
          annotation (Line(
            points={{60,60},{60,50},{50,50},{50,-80},{-39.6,-80},{-39.6,-90}},
            color={191,0,0}));
        connect(friction.support, internalSupport) annotation (Line(
            points={{90,-40},{90,-70},{60,-70},{60,-100}}));
        connect(strayLoad.flange, inertiaRotor.flange_b) annotation (Line(
            points={{50,80},{90,80},{90,0}}));
        connect(friction.flange, inertiaRotor.flange_b) annotation (Line(
            points={{90,-20},{90,0}}));
        connect(friction.heatPort, internalThermalPort.heatPortFriction)
          annotation (Line(
            points={{80,-40},{50,-40},{50,-80},{-40,-80},{-40,-91.6}},
            color={191,0,0}));
        connect(groundS.port_p, airGap.port_sp) annotation (Line(
            points={{-28,10},{-10,10}},
            color={255,128,0}));
        connect(stator.port_n, airGap.port_sp) annotation (Line(
            points={{-10,30},{-10,10}},
            color={255,128,0}));
        connect(stator.port_p, airGap.port_sn) annotation (Line(
            points={{10,30},{10,10}},
            color={255,128,0}));
        connect(stator.heatPortWinding, internalThermalPort.heatPortStatorWinding)
          annotation (Line(
            points={{-10,44},{-40.4,44},{-40.4,-89.2}},
            color={191,0,0}));
        connect(stator.heatPortCore, internalThermalPort.heatPortStatorCore)
          annotation (Line(
            points={{-10,36},{-39.6,36},{-39.6,-89.2}},
            color={191,0,0}));
        connect(thermalAmbient.thermalPort, internalThermalPort) annotation (
            Line(points={{-60,-90},{-50,-90},{-40,-90}}, color={191,0,0}));
        connect(internalThermalPort, thermalPort) annotation (Line(points={{-40,
                -90},{-20,-90},{0,-90},{0,-100}}, color={191,0,0}));
        annotation (
          Documentation(info="<html>
<p>This partial model for induction machines contains elements common in all machine models.</p>
</html>"),Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Rectangle(
                extent={{80,-80},{120,-120}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-50,100},{-20,100},{-20,70}}, color={85,170,255}),
              Line(points={{50,100},{20,100},{20,70}}, color={85,170,255}),
              Text(
                extent={{-150,-120},{150,-180}},
                lineColor={0,0,255},
                textString="%name"),
              Line(
                visible=not useSupport,
                points={{80,-100},{120,-100}}),
              Line(
                visible=not useSupport,
                points={{90,-100},{80,-120}}),
              Line(
                visible=not useSupport,
                points={{100,-100},{90,-120}}),
              Line(
                visible=not useSupport,
                points={{110,-100},{100,-120}}),
              Line(
                visible=not useSupport,
                points={{120,-100},{110,-120}})}));
      end PartialBasicMachine;
    end BaseClasses;
  end BasicMachines;

  package Losses "Loss models"
    extends Modelica.Icons.Package;
    model StrayLoad "Model of stray load losses dependent on current and speed"
      extends Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.OnePort;
      extends Modelica.Electrical.Machines.Interfaces.FlangeSupport;
      import Modelica.Electrical.QuasiStationary.MultiPhase.Functions.quasiRMS;
      parameter Modelica.Electrical.Machines.Losses.StrayLoadParameters
        strayLoadParameters "Stray load loss parameters";
      extends
        Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
          useHeatPort=false);
      Modelica.SIunits.Current iRMS=quasiRMS(i);
    equation
      v = {Complex(0, 0) for k in 1:m};
      if (strayLoadParameters.PRef <= 0) then
        tau = 0;
      else
        tau = -strayLoadParameters.tauRef*(iRMS/strayLoadParameters.IRef)^2*
          smooth(1, if w >= 0 then +(+w/strayLoadParameters.wRef)^
          strayLoadParameters.power_w else -(-w/strayLoadParameters.wRef)^
          strayLoadParameters.power_w);
      end if;
      lossPower = -tau*w;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={85,170,255},
              pattern=LinePattern.Dot), Line(
              points={{-102,0},{100,0}},
              color={85,170,255})}), Documentation(info="<html>
<p>
Stray load losses are modeled similar to standards EN 60034-2 and IEEE 512, i.e., they are dependent on square of current,
but without scaling them to zero at no-load current.
</p>
<p>
For an estimation of dependency on varying angular velocity see:
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.UsersGuide.References\">[Lang1984]</a>
</p>
<p>
The stray load losses are modeled such way that they do not cause a voltage drop in the electric circuit.
Instead, the dissipated losses are considered through an equivalent braking torque at the shaft.
</p>
<p>
The stray load loss torque is
</p>
<pre>
  tau = PRef/wRef * (i/IRef)^2 * (w/wRef)^power_w
</pre>
<p>
where <code>i</code> is the current of the machine and <code>w</code> is the actual angular velocity.
The dependency of the stray load torque on the angular velocity is modeled by the exponent <code>power_w</code>.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.StrayLoadParameters\">StrayLoad parameters</a>
</p>
<p>
If it is desired to neglect stray load losses, set <code>strayLoadParameters.PRef = 0</code> (this is the default).
</p>
</html>"));
    end StrayLoad;

    model PermanentMagnetLosses
      "Model of permanent magnet losses dependent on current and speed"
      extends Modelica.Electrical.Machines.Interfaces.FlangeSupport;
      import Modelica.Electrical.QuasiStationary.MultiPhase.Functions.quasiRMS;
      parameter Integer m(min=1) = 3 "Number of phases";
      parameter
        Modelica.Electrical.Machines.Losses.PermanentMagnetLossParameters
        permanentMagnetLossParameters "Permanent magnet loss parameters";
      extends
        Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
          useHeatPort=false);
      input Modelica.SIunits.ComplexCurrent is[m]
        "Instantaneous stator currents";
      Modelica.SIunits.Current iRMS=quasiRMS(is);
    equation
      if (permanentMagnetLossParameters.PRef <= 0) then
        tau = 0;
      else
        tau = -permanentMagnetLossParameters.tauRef*(
          permanentMagnetLossParameters.c + (1 - permanentMagnetLossParameters.c)
          *(iRMS/permanentMagnetLossParameters.IRef)^
          permanentMagnetLossParameters.power_I)*smooth(1, if w >= 0 then +(+w/
          permanentMagnetLossParameters.wRef)^permanentMagnetLossParameters.power_w
           else -(-w/permanentMagnetLossParameters.wRef)^
          permanentMagnetLossParameters.power_w);
      end if;
      lossPower = -tau*w;
      annotation (Icon(graphics={Ellipse(extent={{-40,-40},{40,40}}, lineColor=
                  {200,0,0})}), Documentation(info="<html>
<p>
Permanent magnet losses are modeled dependent on current and speed.
</p>
<p>
The permanent magnet losses are modeled such way that they do not cause a voltage drop in the electric circuit.
Instead, the dissipated losses are considered through an equivalent braking torque at the shaft.
</p>
<p>
The permanent magnet loss torque is
</p>
<pre>
  tau = PRef/wRef * (c + (1 - c) * (i/IRef)^power_I) * (w/wRef)^power_w
</pre>
<p>
where <code>i</code> is the current of the machine and <code>w</code> is the actual angular velocity.
The parameter <code>c</code> designates the part of the permanent magnet losses that are present even at current = 0, i.e. independent of current.
The dependency of the permanent magnet loss torque on the stator current is modeled by the exponent <code>power_I</code>.
The dependency of the permanent magnet loss torque on the angular velocity is modeled by the exponent <code>power_w</code>.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.PermanentMagnetLossParameters\">Permanent magnet loss parameters</a>
</p>
<p>
If it is desired to neglect permanent magnet losses, set <code>strayLoadParameters.PRef = 0</code> (this is the default).
</p>
</html>"));
    end PermanentMagnetLosses;

  end Losses;

  package Sources "Sources to supply magnetic networks"
    extends Modelica.Icons.SourcesPackage;
    model ConstantMagneticPotentialDifference
      "Source with constant magnetic potential difference"
      extends Interfaces.PartialTwoPort;
      parameter Modelica.SIunits.Frequency f(start=1) "Frequency of the source";
      parameter Modelica.SIunits.ComplexMagneticPotentialDifference V_m=Complex(
          re=1, im=0) "Complex magnetic potential difference";
      Modelica.SIunits.MagneticPotentialDifference abs_V_m=
          Modelica.ComplexMath.'abs'(V_m)
        "Magnitude of complex magnetic potential difference";
      Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
        "Argument of complex magnetic potential difference";
      Modelica.SIunits.ComplexMagneticFlux Phi "Complex magnetic flux";
      Modelica.SIunits.MagneticPotentialDifference abs_Phi=
          Modelica.ComplexMath.'abs'(Phi) "Magnitude of complex magnetic flux";
      Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
        "Argument of complex magnetic flux";
    equation
      // Flux into positive port
      port_p.V_m - port_n.V_m = V_m;
      // Magneto motive force
      port_p.Phi = Phi;
      // Local flux balance
      port_p.Phi + port_n.Phi = Complex(0, 0);
      // Reference angular speed and angle
      omega = 2*Modelica.Constants.pi*f;
      Connections.root(port_p.reference);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-80,-20},{-80,-40}},
                  lineColor={255,170,85},
                  textString="+"),Text(
                  extent={{80,-20},{80,-40}},
                  lineColor={255,170,85},
                  textString="-"),Ellipse(
                  extent={{-50,-50},{50,50}},
                  lineColor={255,127,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{100,0},{50,0}},
              color={255,127,0}),Line(points={{-50,0},{-100,0}}, color={255,127,
              0}),Line(points={{-50,0},{50,0}}, color={255,127,0}),Text(
                  extent={{0,-120},{0,-80}},
                  textString="%name",
                  lineColor={0,0,255})}), Documentation(info="<html>
<p>
Source of constant magneto motive force.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.SignalMagneticPotentialDifference\">
SignalMagneticPotentialDifference</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.ConstantFlux\">
ConstantFlux</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.SignalFlux\">
SignalFlux</a>
</p>
</html>"));
    end ConstantMagneticPotentialDifference;

    model SignalMagneticPotentialDifference
      "Source of magnetic potential difference with signal input"
      extends Interfaces.PartialTwoPort;
      Modelica.ComplexBlocks.Interfaces.ComplexInput V_m
        "Complex signal input of magnetic potential difference" annotation (
          Placement(transformation(
            origin={0,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.SIunits.MagneticPotentialDifference abs_V_m=
          Modelica.ComplexMath.'abs'(V_m)
        "Magnitude of complex magnetic potential difference";
      Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
        "Argument of complex magnetic potential difference";
      Modelica.SIunits.ComplexMagneticFlux Phi "Complex magnetic flux";
      Modelica.SIunits.MagneticPotentialDifference abs_Phi=
          Modelica.ComplexMath.'abs'(Phi) "Magnitude of complex magnetic flux";
      Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
        "Argument of complex magnetic flux";
    equation
      // Flux into positive port
      port_p.V_m - port_n.V_m = V_m;
      // Magneto motive force
      port_p.Phi = Phi;
      // Local flux balance
      port_p.Phi + port_n.Phi = Complex(0, 0);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{80,-20},{80,-40}},
                  lineColor={255,170,85},
                  textString="-"),Ellipse(
                  extent={{-50,-50},{50,50}},
                  lineColor={255,170,85},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{100,0},{50,0}},
              color={255,170,85}),Line(points={{-50,0},{-100,0}}, color={255,
              128,0}),Line(points={{-50,0},{50,0}}, color={255,170,85}),Line(
              points={{0,100},{0,50}}, color={255,170,85}),Text(
                  extent={{0,-120},{0,-80}},
                  textString="%name",
                  lineColor={0,0,255}),Text(
                  extent={{-80,-20},{-80,-40}},
                  lineColor={255,170,85},
                  textString="+")}), Documentation(info="<html>
<p>
Source of magneto motive force with complex signal input.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.ConstantMagneticPotentialDifference\">
ConstantMagneticPotentialDifference</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.ConstantFlux\">
ConstantFlux</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.SignalFlux\">
SignalFlux</a>
</p>

</html>"));
    end SignalMagneticPotentialDifference;

    model ConstantFlux "Source of constant magnetic flux"
      extends Interfaces.PartialTwoPort;
      parameter Modelica.SIunits.Frequency f(start=1) "Frequency of the source";
      Modelica.SIunits.ComplexMagneticPotentialDifference V_m
        "Complex magnetic potential difference";
      Modelica.SIunits.MagneticPotentialDifference abs_V_m=
          Modelica.ComplexMath.'abs'(V_m)
        "Magnitude of complex magnetic potential difference";
      Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
        "Argument of complex magnetic potential difference";
      parameter Modelica.SIunits.ComplexMagneticFlux Phi=Complex(re=1, im=0)
        "Complex magnetic flux";
      Modelica.SIunits.MagneticPotentialDifference abs_Phi=
          Modelica.ComplexMath.'abs'(Phi) "Magnitude of complex magnetic flux";
      Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
        "Argument of complex magnetic flux";
    equation
      // Flux into positive port
      port_p.V_m - port_n.V_m = V_m;
      // Magneto motive force
      port_p.Phi = Phi;
      // Local flux balance
      port_p.Phi + port_n.Phi = Complex(0, 0);
      // Reference angular speed and angle
      omega = 2*Modelica.Constants.pi*f;
      Connections.root(port_p.reference);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Ellipse(
                  extent={{-50,-50},{50,50}},
                  lineColor={255,127,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{100,0},{50,0}},
              color={255,127,0}),Line(points={{-50,0},{-100,0}}, color={255,127,
              0}),Line(points={{0,50},{0,-50}}, color={255,127,0}),Polygon(
                  points={{80,0},{60,6},{60,-6},{80,0}},
                  lineColor={255,128,0},
                  fillColor={255,170,85},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{0,-120},{0,-80}},
                  textString="%name",
                  lineColor={0,0,255})}), Documentation(info="<html>
<p>
Source of constant magnetic flux.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.ConstantMagneticPotentialDifference\">
ConstantMagneticPotentialDifference</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.SignalMagneticPotentialDifference\">
SignalMagneticPotentialDifference</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.SignalFlux\">
SignalFlux</a>
</p>

</html>"));
    end ConstantFlux;

    model SignalFlux "Source of time varying magnetic flux"
      extends Interfaces.PartialTwoPort;
      Modelica.SIunits.ComplexMagneticPotentialDifference V_m
        "Complex magnetic potential difference";
      Modelica.SIunits.MagneticPotentialDifference abs_V_m=
          Modelica.ComplexMath.'abs'(V_m)
        "Magnitude of complex magnetic potential difference";
      Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
        "Argument of complex magnetic potential difference";

      Modelica.ComplexBlocks.Interfaces.ComplexInput Phi
        "Complex signal input of magnetic flux" annotation (Placement(
            transformation(
            origin={0,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.SIunits.MagneticPotentialDifference abs_Phi=
          Modelica.ComplexMath.'abs'(Phi) "Magnitude of complex magnetic flux";
      Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
        "Argument of complex magnetic flux";
    equation
      // Flux into positive port
      port_p.V_m - port_n.V_m = V_m;
      // Magneto motive force
      port_p.Phi = Phi;
      // Local flux balance
      port_p.Phi + port_n.Phi = Complex(0, 0);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Ellipse(
                  extent={{-50,-50},{50,50}},
                  lineColor={255,170,85},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{100,0},{50,0}},
              color={255,170,85}),Line(points={{-50,0},{-100,0}}, color={255,
              170,85}),Line(points={{0,50},{0,-50}}, color={255,170,85}),
              Polygon(
                  points={{80,0},{60,6},{60,-6},{80,0}},
                  lineColor={255,170,85},
                  fillColor={255,170,85},
                  fillPattern=FillPattern.Solid),Line(points={{0,100},{0,50}},
              color={255,170,85}),Text(
                  extent={{0,-120},{0,-80}},
                  textString="%name",
                  lineColor={0,0,255})}), Documentation(info="<html>
<p>
Source of magnetic flux with complex signal input.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.ConstantMagneticPotentialDifference\">
ConstantMagneticPotentialDifference</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.SignalMagneticPotentialDifference\">
SignalMagneticPotentialDifference</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.ConstantFlux\">
ConstantFlux</a>

</p>

</html>"));
    end SignalFlux;
  end Sources;

  package Sensors "Sensors to measure variables in magnetic networks"
    extends Modelica.Icons.SensorsPackage;
    model MagneticFluxSensor "Sensor to measure magnetic flux"
      extends Modelica.Icons.RotationalSensor;
      extends Interfaces.PartialTwoPort;
      Modelica.SIunits.ComplexMagneticPotentialDifference V_m
        "Complex magnetic potential difference";
      Modelica.ComplexBlocks.Interfaces.ComplexOutput Phi
        "Complex magnetic flux from por_ p to port_n as output signal"
        annotation (Placement(transformation(
            origin={0,-100},
            extent={{10,-10},{-10,10}},
            rotation=90)));
     Modelica.SIunits.MagneticFlux abs_Phi=Modelica.ComplexMath.'abs'(Phi)
        "Magnitude of complex magnetic flux";
      Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
        "Argument of complex magnetic flux";

    equation
      // Flux into positive port
      port_p.V_m - port_n.V_m = V_m;
      // Magneto motive force
      port_p.Phi = Phi;
      // Local flux balance
      port_p.Phi + port_n.Phi = Complex(0, 0);
      // No magnetic potential difference at sensor
      V_m = Complex(0, 0);
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={Text(
                  extent={{-29,-11},{30,-70}},
                  lineColor={0,0,0},
                  textString="Phi"),Line(points={{-72,0},{-90,0}}),
              Text(
                  extent={{-140,120},{140,80}},
                  textString="%name",
                  lineColor={0,0,255}),Line(points={{70,0},{90,0}}, color={0,0,
              0}),Line(points={{0,-90},{0,-70}})}),
        Documentation(info="<html>
<p>Sensor for magnetic flux.</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sensors.MagneticPotentialDifferenceSensor\">MagneticPotentialDifferenceSensor</a>
</p>
</html>"));
    end MagneticFluxSensor;

    model MagneticPotentialDifferenceSensor
      "Sensor to measure magnetic potential difference"
      extends Modelica.Icons.RotationalSensor;
      extends Interfaces.PartialTwoPort;
      Modelica.ComplexBlocks.Interfaces.ComplexOutput V_m
        "Complex magnetic potential difference between port_p and port_n as output signal"
        annotation (Placement(transformation(
            origin={0,-100},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.SIunits.MagneticPotentialDifference abs_V_m=
          Modelica.ComplexMath.'abs'(V_m)
        "Magnitude of complex magnetic potential difference";
      Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
        "Argument of complex magnetic potential difference";
      Modelica.SIunits.ComplexMagneticFlux Phi "Complex magnetic flux";
    equation
      // Flux into positive port
      port_p.V_m - port_n.V_m = V_m;
      // Magneto motive force
      port_p.Phi = Phi;
      // Local flux balance
      port_p.Phi + port_n.Phi = Complex(0, 0);
      // No magnetic flux through sensor
      Phi = Complex(0, 0);
      annotation (Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={Text(
                  extent={{-52,1},{48,-57}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  textString="V_m"),Line(points={{-70,0},{-90,0}}),
              Line(points={{70,0},{90,0}}),Line(points={{0,-90},
              {0,-70}}),Text(
                  extent={{-140,120},{140,80}},
                  textString="%name",
                  lineColor={0,0,255})}), Documentation(info="<html>
<p>Sensor for magnetic potential difference.</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sensors.MagneticFluxSensor\">MagneticFluxSensor</a>
</p></html>"));
    end MagneticPotentialDifferenceSensor;

    model MagneticPotentialSensor "Sensor to measure magnetic potential"
      extends Modelica.Icons.RotationalSensor;
      Modelica.ComplexBlocks.Interfaces.ComplexOutput V_m
        "Complex magnetic potential as output signal" annotation (Placement(
            transformation(
            origin={0,-100},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.SIunits.MagneticPotentialDifference abs_V_m=
          Modelica.ComplexMath.'abs'(V_m)
        "Magnitude of complex magnetic potential difference";
      Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
        "Argument of complex magnetic potential difference";

      FundamentalWave.Interfaces.PositiveMagneticPort port_p
        "Quasi static magnetic port of sensor"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    equation
      // No magnetic flux through sensor
      port_p.Phi = Complex(0, 0);
      // Magnetic potential
      V_m = port_p.V_m;
      annotation (Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={Text(
                  extent={{-52,1},{48,-57}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  textString="V_m"),Line(points={{-70,0},{-90,0}}),
              Line(points={{0,-90},{0,-70}}),Text(
                  extent={{-140,120},{140,80}},
                  textString="%name",
                  lineColor={0,0,255})}), Documentation(info="<html>
<p>Sensor for magnetic potential difference.</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sensors.MagneticFluxSensor\">MagneticFluxSensor</a>
</p></html>"));
    end MagneticPotentialSensor;
    annotation (Documentation(info="<html>
<p>
This package provides sensors for the magnetic potential difference and the magnetic flux in magnetic circuit.
</p>
</html>"));
  end Sensors;

  package Interfaces "Interfaces"
    extends Modelica.Icons.InterfacesPackage;
    connector MagneticPort "Basic quasi static magnet connector"
      Modelica.SIunits.ComplexMagneticPotential V_m
        "Complex magnetic potential at the node";
      flow Modelica.SIunits.ComplexMagneticFlux Phi
        "Complex magnetic flux flowing into the pin";
      annotation (Documentation(info="<html>
<p>Base definition of complex quasi static magnetic port. The potential variable is the complex magnetic potential difference <code>V_m</code> and the flow variable is the complex magnetic flux <code>Phi</code>.</p>
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>
</p>

</html>"));
    end MagneticPort;

    connector PositiveMagneticPort "Positive quasi static magnetic port"
      extends FundamentalWave.Interfaces.MagneticPort;
      Modelica.Electrical.QuasiStationary.Types.Reference reference "Reference";
      annotation (
        defaultComponentName="port_p",
        Diagram(graphics={Text(
              extent={{-100,100},{100,60}},
              lineColor={255,170,85},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              textString="%name"), Ellipse(
              extent={{-40,40},{40,-40}},
              lineColor={255,170,85},
              fillColor={255,170,85},
              fillPattern=FillPattern.Solid)}),
        Icon(graphics={Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={255,170,85},
              fillColor={255,170,85},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>

<p>
The positive port is based on
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.MagneticPort\">MagneticPort</a>.
Additionally the reference angle is specified in the connector. The time derivative of the reference angle is the actual angular velocity of the quasi static voltage and current. The symbol is also designed such way to look different than the
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.MagneticPort\">MagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>
</p>
</html>"));
    end PositiveMagneticPort;

    connector NegativeMagneticPort "Negative quasi static magnetic port"
      extends FundamentalWave.Interfaces.MagneticPort;
      Modelica.Electrical.QuasiStationary.Types.Reference reference "Reference";
      annotation (
        defaultComponentName="port_n",
        Diagram(graphics={Text(
              extent={{-100,100},{100,60}},
              lineColor={255,170,85},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              textString="%name"), Ellipse(
              extent={{-40,40},{40,-40}},
              lineColor={255,170,85},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Icon(graphics={Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={255,170,85},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>

<p>
The negative pin is based on <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">Pin</a>.
Additionally the reference angle is specified in the connector. The time derivative of the reference angle is the actual angular velocity of the quasi static voltage and current. The symbol is also designed such way to look different than the <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">positive pin</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.MagneticPort\">MagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>
</p>
</html>"));
    end NegativeMagneticPort;

    partial model PartialTwoPort "Partial two port for graphical programming"
      Modelica.SIunits.AngularVelocity omega=der(port_p.reference.gamma)
        "Reference angular velocity (= der(port_p.reference.gamma))";
      FundamentalWave.Interfaces.PositiveMagneticPort port_p
        "Positive quasi static magnetic port" annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      FundamentalWave.Interfaces.NegativeMagneticPort port_n
        "Negative quasi static magnetic port" annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
    equation
      Connections.branch(port_p.reference, port_n.reference);
      port_p.reference.gamma = port_n.reference.gamma;
      annotation (
        Documentation(info="<html>
<p>
The partial two port model consists of a positive and a negative magnetic port. The reference angles of the two ports are set equal and connected through <code>Connections.branch</code>.
</p>
</html>"));
    end PartialTwoPort;

    partial model PartialTwoPortExtended
      "Partial two port for graphical programming with additional variables"
      extends
        Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.PartialTwoPort;

      Modelica.SIunits.ComplexMagneticPotentialDifference V_m=port_p.V_m -
          port_n.V_m "Complex magnetic potential difference";
      Modelica.SIunits.MagneticPotentialDifference abs_V_m=
          Modelica.ComplexMath.'abs'(V_m)
        "Magnitude of complex magnetic potential difference";
      Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
        "Argument of complex magnetic potential difference";
      Modelica.SIunits.ComplexMagneticFlux Phi=port_p.Phi
        "Complex magnetic flux";
      Modelica.SIunits.MagneticFlux abs_Phi=Modelica.ComplexMath.'abs'(Phi)
        "Magnitude of complex magnetic flux";
      Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
        "Argument of complex magnetic flux";

      annotation (
        Documentation(info="<html>
<p>
The partial two port model consists of a positive and a negative magnetic port. The reference angles of the two ports are set equal and connected through <code>Connections.branch</code>.
</p>
<p>
This interface model contains an extended set of (output) variables compared to
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.PartialTwoPort\">PartialTwoPort</a>.
</p>
</html>"));
    end PartialTwoPortExtended;

    partial model PartialTwoPortElementary
      "Elementary partial two port for textual programming"
      extends Interfaces.PartialTwoPort;
      Modelica.SIunits.ComplexMagneticPotentialDifference V_m
        "Complex magnetic potential difference";
      Modelica.SIunits.MagneticPotentialDifference abs_V_m=
          Modelica.ComplexMath.'abs'(V_m)
        "Magnitude of complex magnetic potential difference";
      Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
        "Argument of complex magnetic potential difference";
      Modelica.SIunits.ComplexMagneticFlux Phi "Complex magnetic flux";
      Modelica.SIunits.MagneticFlux abs_Phi=Modelica.ComplexMath.'abs'(Phi)
        "Magnitude of complex magnetic flux";
      Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
        "Argument of complex magnetic flux";

    equation
      V_m = port_p.V_m - port_n.V_m;
      Phi = port_p.Phi;
      port_p.Phi + port_n.Phi = Complex(0, 0);
      annotation (
        Documentation(info="<html>
<p>
The partial two port elementary model extends from the partial two port model and adds one equation considering the balance of flow variables, <code>port_p.Phi + port_n.Phi = Complex(0,0)</code>. Additionally, a variable for magnetic potential difference of the two magnetic ports, <code>V_m</code>, and the flux into the positive port, <code>Phi</code>, are defined.
</p>
</html>"));
    end PartialTwoPortElementary;
  end Interfaces;

  package Utilities "Utilities for quasi static fundamental wave machines"
    extends Modelica.Icons.Package;
    block VfController "Voltage-Frequency-Controller"
      import Modelica.Constants.pi;
      parameter Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Angle orientation[m]=-
          Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m)
        "Orientation of phases";
      parameter Modelica.SIunits.Voltage VNominal
        "Nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency fNominal "Nominal frequency";
      parameter Modelica.SIunits.Angle BasePhase=0 "Common phase shift";
      output Modelica.SIunits.Voltage amplitude;
      Modelica.ComplexBlocks.Interfaces.ComplexOutput y[m]
        "Complex quasi static voltages (RMS)" annotation (Placement(
            transformation(extent={{100,-10},{120,10}}), iconTransformation(
              extent={{100,-10},{120,10}})));
      Modelica.Blocks.Interfaces.RealInput u "Frequency input (Hz)"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    equation
      //amplitude = VNominal*min(abs(u)/fNominal, 1);
      amplitude = VNominal*(if abs(u) < fNominal then abs(u)/fNominal else 1);
      y = Modelica.ComplexMath.fromPolar(fill(amplitude, m), orientation + fill(
        BasePhase - pi/2, m));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{
                100,100}}), graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{-100,-100},{0,60},
              {80,60}}, color={0,0,255}),Line(
                  points={{-70,0},{-60.2,29.9},{-53.8,46.5},{-48.2,58.1},{-43.3,
                65.2},{-38.3,69.2},{-33.4,69.8},{-28.5,67},{-23.6,61},{-18.6,52},
                {-13,38.6},{-5.98,18.6},{8.79,-26.9},{15.1,-44},{20.8,-56.2},{
                25.7,-64},{30.6,-68.6},{35.5,-70},{40.5,-67.9},{45.4,-62.5},{
                50.3,-54.1},{55.9,-41.3},{63,-21.7},{70,0}},
                  color={192,192,192},
                  smooth=Smooth.Bezier),Line(
                  points={{-40,0},{-30.2,29.9},{-23.8,46.5},{-18.2,58.1},{-13.3,
                65.2},{-8.3,69.2},{-3.4,69.8},{1.5,67},{6.4,61},{11.4,52},{17,
                38.6},{24.02,18.6},{38.79,-26.9},{45.1,-44},{50.8,-56.2},{55.7,
                -64},{60.6,-68.6},{65.5,-70},{70.5,-67.9},{75.4,-62.5},{80.3,-54.1},
                {85.9,-41.3},{93,-21.7},{100,0}},
                  color={192,192,192},
                  smooth=Smooth.Bezier),Line(
                  points={{-100,0},{-90.2,29.9},{-83.8,46.5},{-78.2,58.1},{-73.3,
                65.2},{-68.3,69.2},{-63.4,69.8},{-58.5,67},{-53.6,61},{-48.6,52},
                {-43,38.6},{-35.98,18.6},{-21.21,-26.9},{-14.9,-44},{-9.2,-56.2},
                {-4.3,-64},{0.6,-68.6},{5.5,-70},{10.5,-67.9},{15.4,-62.5},{
                20.3,-54.1},{25.9,-41.3},{33,-21.7},{40,0}},
                  color={192,192,192},
                  smooth=Smooth.Bezier),Text(
                  extent={{-150,150},{150,110}},
                  textString="%name",
                  lineColor={0,0,255})}),
        Documentation(info="<html>
<p>
This is a simple voltage-frequency-controller. The amplitude of the voltage is linear dependent (<code>VNominal/fNominal</code>) on the frequency (input signal <code>u</code>), but limited by <code>VNominal</code> (nominal RMS voltage per phase). An
<code>m</code> quasi static phasor signal is provided as output signal <code>y</code>, representing complex voltages.
The output voltages may serve as inputs for complex voltage sources with phase input. Symmetrical voltages are assumed.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><b>Fig. 1:</b> Voltage vs. frequency of voltage frequency controller</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Utilities/VoltageFrequencyController.png\"/>
    </td>
  </tr>
</table>

</html>"));
    end VfController;

    model TerminalBox "Terminal box Y/D-connection"
      parameter Integer m(min=1) = 3 "Number of phases";
      parameter String terminalConnection(start="Y") "Choose Y=star/D=delta"
        annotation (choices(choice="Y" "Star connection", choice="D"
            "Delta connection"));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug
        plug_sp(final m=m) "To positive stator plug" annotation (Placement(
            transformation(extent={{50,-50},{70,-70}}),
            iconTransformation(extent={{50,-50},{70,-70}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug
        plug_sn(final m=m) "To negative stator plug" annotation (Placement(
            transformation(extent={{-70,-50},{-50,-70}}),
            iconTransformation(extent={{-70,-50},{-50,-70}})));
      Electrical.QuasiStationary.MultiPhase.Basic.Star star(final m=m) if (
        terminalConnection <> "D") annotation (Placement(transformation(
            origin={-70,-80},
            extent={{-10,10},{10,-10}},
            rotation=180)));
      Electrical.QuasiStationary.MultiPhase.Basic.Delta delta(final m=m) if (
        terminalConnection == "D") annotation (Placement(transformation(extent=
                {{-20,-70},{-40,-50}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug
        plugSupply(final m=m) "To grid" annotation (Placement(transformation(
              extent={{-10,-30},{10,-50}}), iconTransformation(
              extent={{-10,-30},{10,-50}})));
      Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin starpoint if
           (terminalConnection <> "D") annotation (Placement(transformation(
              extent={{-100,-50},{-80,-30}}), iconTransformation(
              extent={{-100,-50},{-80,-30}})));
    equation
      connect(star.plug_p, plug_sn) annotation (Line(
          points={{-60,-80},{-60,-60}},
          color={85,170,255}));
      connect(delta.plug_n, plug_sn) annotation (Line(
          points={{-40,-60},{-40,-60},{-60,-60}},
          color={85,170,255}));
      connect(delta.plug_p, plug_sp) annotation (Line(
          points={{-20,-60},{60,-60},{60,-60}},
          color={85,170,255}));
      connect(plugSupply, plug_sp) annotation (Line(
          points={{0,-40},{0,-60},{60,-60}},
          color={85,170,255}));
      connect(star.pin_n, starpoint) annotation (Line(
          points={{-80,-80},{-86,-80},{-86,-40},{-90,-40}},
          color={85,170,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Text(
                  extent={{-40,-50},{40,-90}},
                  lineColor={0,0,0},
                  textString="%terminalConnection"),Polygon(
                  points={{-80,-40},{-80,-44},{-80,-80},{-40,-100},{40,-100},{
                  80,-70},{80,-44},{76,-40},{-80,-40}},
                  lineColor={95,95,95},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
TerminalBox: at the bottom connected to both machine plugs, connect at the top to the grid as usual,<br>
choosing Y-connection (StarDelta=Y) or D-connection (StarDelta=D).
</html>"));
    end TerminalBox;

    model MultiTerminalBox "Terminal box Y/D-connection"
      parameter Integer m(min=1) = 3 "Number of phases";
      final parameter Integer mSystems=
          Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m);
      final parameter Integer mBasic=integer(m/mSystems);
      parameter String terminalConnection(start="Y") "Choose Y=star/D=delta"
        annotation (choices(choice="Y" "Star connection", choice="D"
            "Delta connection"));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug
        plug_sp(final m=m) "To positive stator plug" annotation (Placement(
            transformation(extent={{50,-50},{70,-70}}),
            iconTransformation(extent={{50,-50},{70,-70}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug
        plug_sn(final m=m) "To negative stator plug" annotation (Placement(
            transformation(extent={{-70,-50},{-50,-70}}),
            iconTransformation(extent={{-70,-50},{-50,-70}})));
      Electrical.QuasiStationary.MultiPhase.Basic.MultiStar multiStar(final m=m) if
           (terminalConnection <> "D") annotation (Placement(transformation(
            origin={-70,-80},
            extent={{-10,10},{10,-10}},
            rotation=180)));
      Electrical.QuasiStationary.MultiPhase.Basic.MultiDelta multiDelta(final m=
           m) if (terminalConnection == "D") annotation (Placement(
            transformation(extent={{-20,-70},{-40,-50}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug
        plugSupply(final m=m) "To grid" annotation (Placement(transformation(
              extent={{-10,-30},{10,-50}}), iconTransformation(
              extent={{-10,-30},{10,-50}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug
        starpoint(final m=mSystems) if (terminalConnection <> "D") annotation (
          Placement(transformation(extent={{-100,-50},{-80,-30}}),
            iconTransformation(extent={{-100,-50},{-80,-30}})));
    equation
      connect(multiStar.plug_p, plug_sn) annotation (Line(
          points={{-60,-80},{-60,-60}},
          color={85,170,255}));
      connect(starpoint, multiStar.starpoints) annotation (Line(
          points={{-90,-40},{-86,-40},{-86,-80},{-80,-80}},
          color={85,170,255}));
      connect(multiDelta.plug_n, plug_sn) annotation (Line(
          points={{-40,-60},{-40,-60},{-60,-60}},
          color={85,170,255}));
      connect(multiDelta.plug_p, plug_sp) annotation (Line(
          points={{-20,-60},{60,-60},{60,-60}},
          color={85,170,255}));
      connect(plugSupply, plug_sp) annotation (Line(
          points={{0,-40},{0,-60},{60,-60}},
          color={85,170,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Polygon(
                  points={{-74,-40},{-80,-46},{-80,-80},{-40,-100},{40,-100},{
                  80,-70},{80,-44},{76,-40},{-74,-40}},
                  lineColor={95,95,95},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.CrossDiag),Text(
                  extent={{-40,-50},{40,-90}},
                  lineColor={0,0,0},
                  textString="%terminalConnection")}),
        Documentation(info="<html>
TerminalBox: at the bottom connected to both machine plugs, connect at the top to the grid as usual,<br>
choosing Y-connection (StarDelta=Y) or D-connection (StarDelta=D).
</html>"));
    end MultiTerminalBox;

    model SwitchedRheostat "Rheostat which is shortened after a given time"
      parameter Integer m=3 "Number of phases";
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug
        plug_p(final m=m) "To positive rotor plug" annotation (Placement(
            transformation(extent={{90,70},{110,50}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug
        plug_n(final m=m) "To negative rotor plug" annotation (Placement(
            transformation(extent={{90,-50},{110,-70}})));
      parameter Modelica.SIunits.Resistance RStart "Starting resistance";
      parameter Modelica.SIunits.Time tStart
        "Duration of switching on the starting resistor";
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star(final m=m)
        annotation (Placement(transformation(extent={{-40,-70},{-60,-50}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground
        annotation (Placement(transformation(
            origin={-80,-60},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.QuasiStationary.MultiPhase.Ideal.IdealCommutingSwitch
        idealCommutingSwitch(
        final m=m,
        Ron=fill(1e-5, m),
        Goff=fill(1e-5, m)) annotation (Placement(transformation(
            origin={40,20},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor rheostat(
          final m=m, R_ref=fill(RStart, m)) annotation (Placement(
            transformation(extent={{0,-30},{-20,-10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starRheostat(
          final m=m) annotation (Placement(transformation(extent={{-40,-30},{-60,
                -10}})));
      Modelica.Blocks.Sources.BooleanStep booleanStep[m](final startTime=fill(
            tStart, m), final startValue=fill(false, m)) annotation (Placement(
            transformation(extent={{-60,10},{-40,30}})));
    equation
      connect(booleanStep.y, idealCommutingSwitch.control) annotation (Line(
          points={{-39,20},{32,20}},
          color={255,0,255}));
      connect(idealCommutingSwitch.plug_p, plug_p) annotation (Line(
          points={{40,30},{40,60},{100,60}},
          color={85,170,255}));
      connect(idealCommutingSwitch.plug_n1, rheostat.plug_p) annotation (Line(
          points={{35,10},{35,-20},{0,-20}},
          color={85,170,255}));
      connect(rheostat.plug_n, starRheostat.plug_p) annotation (Line(
          points={{-20,-20},{-40,-20}},
          color={85,170,255}));
      connect(starRheostat.pin_n, ground.pin) annotation (Line(
          points={{-60,-20},{-60,-60},{-70,-60}},
          color={85,170,255}));
      connect(ground.pin, star.pin_n) annotation (Line(
          points={{-70,-60},{-60,-60}},
          color={85,170,255}));
      connect(star.plug_p, idealCommutingSwitch.plug_n2) annotation (Line(
          points={{-40,-60},{40,-60},{40,10}},
          color={85,170,255}));
      connect(plug_n, idealCommutingSwitch.plug_n2) annotation (Line(
          points={{100,-60},{40,-60},{40,10}},
          color={85,170,255}));
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={Rectangle(
                  extent={{26,40},{54,-40}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{100,60},{-40,60},
              {-40,40}}, color={0,0,255}),Line(points={{100,-60},{-40,-60},{-40,
              -40}}, color={0,0,255}),Ellipse(extent={{-44,40},{-36,32}},
              lineColor={0,0,255}),Ellipse(extent={{-44,-32},{-36,-40}},
              lineColor={0,0,255}),Line(points={{-80,40},{-42,-34}}, color={0,0,
              255}),Line(points={{40,40},{40,42},{40,60}}, color={0,0,255}),
              Line(points={{40,-40},{40,-60}}, color={0,0,255}),Line(points={{
              10,-80},{70,-80}}, color={0,0,255}),Line(points={{40,-60},{40,-80}},
              color={0,0,255}),Line(points={{20,-90},{60,-90}}, color={0,0,255}),
              Line(points={{30,-100},{50,-100}}, color={0,0,255})}),
        Documentation(info="<html>
<p>Switched rheostat, used for starting induction motors with slipring rotor:</p>
<p>The external rotor resistance <code>RStart</code> is shortened at time <code>tStart</code>.</p>
</html>"));
    end SwitchedRheostat;

    model CurrentController "Current controller"
      parameter Integer m=3 "Number of phases";
      parameter Integer p "Number of pole pairs";
      parameter Modelica.SIunits.Angle gamma0=0
        "Offset added to electrical rotor angle";
      Modelica.Blocks.Interfaces.RealInput id_rms annotation (Placement(
            transformation(extent={{-140,40},{-100,80}})));
      Modelica.Blocks.Interfaces.RealInput iq_rms annotation (Placement(
            transformation(extent={{-140,-80},{-100,-40}})));
      Modelica.Blocks.Interfaces.RealInput phi annotation (Placement(
            transformation(
            origin={0,-120},
            extent={{20,-20},{-20,20}},
            rotation=270)));
      Modelica.Blocks.Math.Gain toGamma(k=p) annotation (Placement(
            transformation(
            origin={0,-70},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.ComplexBlocks.Interfaces.ComplexOutput I[m]
        "Multi phase current phasors"
        annotation (Placement(transformation(extent={{100,30},{120,50}})));
      Modelica.Blocks.Interfaces.RealOutput gamma "Reference angle of source"
        annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
      Electrical.QuasiStationary.MultiPhase.Blocks.SingleToMultiPhase
        singleToMultiPhase(final m=m)
        annotation (Placement(transformation(extent={{20,30},{40,50}})));
      Modelica.ComplexBlocks.ComplexMath.RealToComplex realToComplex
        annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
      Modelica.Blocks.Sources.Constant const(final k=gamma0) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={30,-70})));
    equation
      connect(phi, toGamma.u)
        annotation (Line(points={{0,-120},{0,-82}}, color={0,0,127}));
      connect(singleToMultiPhase.y, I) annotation (Line(
          points={{41,40},{110,40}},
          color={85,170,255}));
      connect(toGamma.y, add.u1) annotation (Line(
          points={{0,-59},{0,-34},{38,-34}},
          color={0,0,127}));
      connect(const.y, add.u2) annotation (Line(
          points={{30,-59},{30,-46},{38,-46}},
          color={0,0,127}));
      connect(add.y, gamma) annotation (Line(
          points={{61,-40},{110,-40}},
          color={0,0,127}));
      connect(id_rms, realToComplex.re) annotation (Line(
          points={{-120,60},{-60,60},{-60,46},{-42,46}},
          color={0,0,127}));
      connect(iq_rms, realToComplex.im) annotation (Line(
          points={{-120,-60},{-60,-60},{-60,34},{-42,34}},
          color={0,0,127}));
      connect(realToComplex.y, singleToMultiPhase.u) annotation (Line(
          points={{-19,40},{18,40}},
          color={85,170,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-100,60},{20,40}},
                  lineColor={0,0,255},
                  textString="id_rms"),Text(
                  extent={{-100,-40},{20,-60}},
                  lineColor={0,0,255},
                  textString="iq_rms")}),
        Documentation(info="<html>
<p>
This is a simple current controller.
The desired RMS values of d  and q component of the quasi static space phasor current in rotor fixed coordinate system are the inputs <code>id_rms</code> and <code>iq_rms</code>.
Using the given rotor position input <code>phi</code>, the quasi static <code>m</code> phase output currents <code>i[m]</code> are calculated.
The model output can be used to feed a quasi static current source with phase input to supply synchronous machines.
</p>
</html>"));
    end CurrentController;
  end Utilities;
  annotation (preferredView="info", Documentation(info="<html>
  <p><b>For a discrimination of various machine models, see <a href=\"modelica://Modelica.Electrical.Machines.UsersGuide.Discrimination\">discrimination</a></b>.</p>
<p>
Copyright &copy; 2013-2016, <a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.Contact\">Christian Kral</a> and
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.Contact\">Anton Haumer</a>
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>"));
end FundamentalWave;
