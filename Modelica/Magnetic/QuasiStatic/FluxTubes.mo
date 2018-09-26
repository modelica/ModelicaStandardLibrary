within Modelica.Magnetic.QuasiStatic;
package FluxTubes "Library for modelling of quasi static electromagnetic devices with lumped magnetic networks"

  import SI = Modelica.SIunits;
  import Modelica.Constants.pi;
  import mu_0 = Modelica.Constants.mue_0;

  extends Modelica.Icons.Package;

  package UsersGuide "User's Guide"
    extends Modelica.Icons.Information;

    class FluxTubeConcept "Flux tube concept"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<h4>Overview of the concept of quasi static magnetic flux tubes</h4>
<p>
Following below, the concept of magnetic flux tubes is outlined in short. For a detailed description of flux tube elements, please have a look at the listed literature. Magnetic flux tubes enable the modeling of magnetic fields with lumped equivalent circuit networks.</p>

<p>Since quasi static conditions are assumed, each field quantity can be represented by a complex phasor -- which is indicated by underlining the respective variable:
</p>

<ul>
<li>Normal component of magnetic flux density,
    <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/B_n.png\"> </li>
<li>Normal component of magnetic field strength,
    <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/H_n.png\"> </li>
<li>Magnetic flux,
    <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/Phi.png\"> </li>
<li>Magnetic potential difference,
    <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/V_m.png\"> </li>
</ul>

<p>The figure below and the following equations illustrate the relationships between</p>

<ul>
<li>the normal component of flux density and magnetic flux, and</li>
<li>the normal component of field strength and magnetic potential difference.</li>
</ul>


<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/magnetic_flux_tube_schematic_qs.png\" alt=\"Magnetic flux tube\">
</p>

<p>A <strong>flux tube</strong> confines the magnetic flux. Flied lines, and flux tubes, respectively are always closed. So there is no flux entering or leaving a flux tube. The total flux of a configuration can be represented by parallel flux tubes, representing different flux paths. This is considered by connecting the elements of a lumped circuit model, such that the sum of all fluxes of a connection is equivalent to zero.</p>

<p>
For a section of a flux tube with length
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/l.png\">
the magnetic potential difference is determined by the length integral over the magnetic field strength:</p>

<dl>
<dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/V_m-H_n.png\">
</dd>
</dl>

<p>
The magnetic flux entering, and leaving a flux tube, respectively, is determined by the surface integral of the normal component
of the magnetic field strength:</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/Phi-B_n.png\">
</dd></dl>
<p>The magnetic potential difference and the magnetic flux have the same angle, so the reluctance a real (non complex) quantity:</p>

<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m-V_m-Phi.png\">
</dd></dl>

<p>
For a
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape.GenericFluxTube\">generic flux tube</a> reluctance with constant
area of cross section,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/A.png\">,
and length,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/l.png\">,
the magnetic reluctance is:</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m_cuboid.png\">
</dd></dl>

<h4>Assumptions</h4>

<ul>
<li><strong>Force</strong> interaction is not considered</li>
<li>Reluctance models are <strong>linear</strong>; so non-linearities can only be taken into account by adapting the constant relative permeability;
see example
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Examples.NonLinearInductor\">NonLinearInductor</a></li>
</ul>

<h4>Notes</h4>

<p>The parameter and variable names are chosen as close as possible to the transient
<a href=\"modelica://Modelica.Magnetic.FluxTubes\">FluxTubes</a> library, to avoid additional effort when converting transient into quasi static flux tubes models.</p>

<h4>Reference Note</h4>

<p>A similar approach on quasi static flux tube models is published in
[<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.UsersGuide.Literature\">Raabe2012</a>].</p>
</html>"));
    end FluxTubeConcept;

    class Literature "Literature"
      extends Modelica.Icons.References;

      annotation (Documentation(info="<html>
<h4>References</h4>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <td valign=\"top\">[Raabe2012]</td>
      <td valign=\"top\">N. Raabe,
        &quot;<a href=\"http://www.ep.liu.se/ecp/076/016/ecp12076016.pdf\">
        An approach for modelling quasi-stationary magnetic circuits</a>,&quot;
        <em>Modelica Conference</em>,
        pp. 167-172, 2012.</td>
    </tr>
</table>

<h4>Additional References</h4>
<p>
Additional reference on magnetic flux tubes are listed in
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">Modelica.Magnetic.FluxTubes</a>.
</p>
</html>"));
    end Literature;

    class ReleaseNotes "Release Notes"
      extends Modelica.Icons.ReleaseNotes;
      annotation (Documentation(info="<html>
<h5>Version 3.2.3, 2018-09-26</h5>
<ul>
<li>Included in the MSL 3.2.3</li>
<li>Added some more examples according to
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1515\">#1515</a></li>
<li>Added magnitudes and angles of complex quantities for better result interpretation</li>
</ul>


<h5>Version 1.0.0, 2013-12-18</h5>
<ul>
<li>Initial version before inclusion in MSL</li>
</ul>
</html>"));
    end ReleaseNotes;

    class Contact "Contact"
      extends Modelica.Icons.Contact;

      annotation (Documentation(info="<html>
<h4>Contact</h4>

<p>
  <strong>Dr. Christian Kral</strong><br>
  <a href=\"http://christiankral.net/\">Electric Machines, Drives and Systems</a><br>
  A-1060 Vienna, Austria<br>
  email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a>
</p>

<p>
<strong>Anton Haumer</strong><br>
<a href=\"https://www.haumer.at\">Technical Consulting &amp; Electrical Engineering</a><br>
D-93049 Regensburg, Germany<br>
email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a><br>
</p>

</html>"));
    end Contact;
    annotation (DocumentationClass=true, Documentation(info="<html>
<p>The quasi static flux tubes library is based on the transient library
<a href=\"modelica://Modelica.Magnetic.FluxTubes\">Magnetic.FluxTubes</a>. The main principles of confined flux and flux tubes apply, too. The quasi static flux tubes library contains components for modelling of electromagnetic devices with lumped magnetic networks based on quasi static theory. Models based on this library are suited for quasi static simulation of transformers at component and system level.</p>
<p>The quasi static components of this library do not consider saturation since <strong>linearity</strong> is strictly assumed. In case that the permeability of a saturated circuit needs to be considered, a
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors.Transient.FundamentalWavePermabilitySensor\">transient permeability estimation sensor</a> is provided do determine the effective permeability from a transient simulation.
</p>

<p>
A general introduction into <strong>quasi static</strong> (quasi stationary) phasor can be found in
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview\">Modelica.Electrical.QuasiStationary</a>.
</p>

<p>
This user's guide gives a short introduction to the underlying
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.UsersGuide.FluxTubeConcept\">concept</a> of quasi static magnetic flux tubes, summarizes basic relationships and equations.
</p>
</html>"));
  end UsersGuide;

  package Examples
  "Illustration of component usage with simple models of various devices"
    extends Modelica.Icons.ExamplesPackage;

    model LinearInductor "Linear inductor with ferromagnetic core"
      extends Modelica.Icons.Example;
      output Modelica.SIunits.Current deviation = feedback.y "Deviation of transient and quasi static current";
      FluxTubes.Basic.Ground ground_mQS annotation (Placement(transformation(extent={{70,-90},{90,-70}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource
        sourceQS(
        f=50,
        V=230,
      gamma(fixed=true),
      phi=1.5707963267949) "Voltage applied to inductor" annotation (Placement(
            transformation(
            origin={-80,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor
        rQS(R_ref=7.5) "Inductor coil resistance" annotation (Placement(transformation(extent={{-40,-50},
                {-20,-30}})));
      FluxTubes.Basic.ElectroMagneticConverter coilQS(N=600) "Inductor coil" annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
      Basic.ConstantReluctance r_mLeakQS(R_m=1.2e6) "Constant leakage reluctance"
        annotation (Placement(transformation(
            origin={30,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Shapes.FixedShape.GenericFluxTube r_mAirParQS(
        mu_rConst=1,
        l=0.0001,
        area=0.025^2)
      "Reluctance of small parasitic air gap (ferromagnetic core packeted from single sheets)"
        annotation (Placement(transformation(extent={{46,-50},{66,-30}})));
      Shapes.FixedShape.GenericFluxTube r_mFeQS(
        mu_rConst=1000,
        l=4*0.065,
        area=0.025^2) "Reluctance of ferromagnetic inductor core"
        annotation (Placement(transformation(
            origin={80,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));

      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground groundQS
        annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));

      Modelica.Magnetic.FluxTubes.Basic.Ground ground_m
        annotation (Placement(transformation(extent={{70,10},{90,30}})));
      Modelica.Electrical.Analog.Sources.SineVoltage source(
        freqHz=50,
        phase=pi/2,
        V=230*sqrt(2)) "Voltage applied to inductor" annotation (Placement(
            transformation(
            origin={-80,50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor r(R=7.5)
      "Inductor coil resistance"
        annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
      Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter coil(N=600, i(fixed=
            true)) "Inductor coil" annotation (Placement(transformation(
              extent={{-10,40},{10,60}})));
      Modelica.Magnetic.FluxTubes.Basic.ConstantReluctance r_mLeak(R_m=1.2e6)
      "Constant leakage reluctance"   annotation (Placement(transformation(
            origin={30,50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube r_mAirPar(
        nonLinearPermeability=false,
        mu_rConst=1,
        l=0.0001,
        area=0.025^2)
      "Reluctance of small parasitic air gap (ferromagnetic core packeted from single sheets)"
        annotation (Placement(transformation(extent={{46,50},{66,70}})));
      Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube r_mFe(
        mu_rConst=1000,
        l=4*0.065,
        material=
            Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet.M350_50A(),
        B(start=0),
        nonLinearPermeability=false,
        area=0.025^2) "Reluctance of ferromagnetic inductor core"
        annotation (Placement(transformation(
            origin={80,50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
            transformation(extent={{-90,10},{-70,30}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor
        currentSensorQS
        annotation (Placement(transformation(extent={{-70,-30},{-50,-50}})));
      Modelica.ComplexBlocks.ComplexMath.ComplexToPolar complexToPolar annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={-40,-10})));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
        annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
      Modelica.Blocks.Math.Feedback feedback
        annotation (Placement(transformation(extent={{0,10},{20,30}})));
    Modelica.Blocks.Math.RootMeanSquare rootMeanSquare(f=50)
      annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
    equation
      connect(coilQS.port_p, r_mLeakQS.port_p) annotation (Line(points={{10,-40},{10,-40},{30,-40}},
                              color={255,170,85}));
      connect(r_mLeakQS.port_p, r_mAirParQS.port_p)
        annotation (Line(points={{30,-40},{46,-40}}, color={255,170,85}));
      connect(r_mAirParQS.port_n, r_mFeQS.port_p)
        annotation (Line(points={{66,-40},{74,-40},{80,-40}}, color={255,170,85}));
      connect(r_mFeQS.port_n, r_mLeakQS.port_n) annotation (Line(points={{80,-60},{67.5,
              -60},{55,-60},{30,-60}}, color={255,170,85}));
      connect(r_mFeQS.port_n, coilQS.port_n) annotation (Line(points={{80,-60},{10,-60},{10,-60}},
                               color={255,170,85}));
      connect(ground_mQS.port, r_mFeQS.port_n) annotation (Line(
          points={{80,-70},{80,-60}},
          color={255,170,85}));
      connect(rQS.pin_n, coilQS.pin_p) annotation (Line(
          points={{-20,-40},{-10,-40},{-10,-40}},
          color={85,170,255}));
      connect(sourceQS.pin_n, coilQS.pin_n) annotation (Line(
          points={{-80,-60},{-10,-60},{-10,-60}},
          color={85,170,255}));
      connect(sourceQS.pin_n, groundQS.pin) annotation (Line(
          points={{-80,-60},{-80,-70}},
          color={85,170,255}));
      connect(r.n, coil.p)
        annotation (Line(points={{-20,60},{-10,60},{-10,60}}, color={0,0,255}));
      connect(source.n, coil.n)
        annotation (Line(points={{-80,40},{-10,40},{-10,40}}, color={0,0,255}));
      connect(coil.port_p, r_mLeak.port_p)
        annotation (Line(points={{10,60},{10,60},{30,60}},   color={255,170,85}));
      connect(r_mLeak.port_p, r_mAirPar.port_p)
        annotation (Line(points={{30,60},{46,60}}, color={255,170,85}));
      connect(r_mAirPar.port_n, r_mFe.port_p)
        annotation (Line(points={{66,60},{74,60},{80,60}}, color={255,170,85}));
      connect(r_mFe.port_n, r_mLeak.port_n) annotation (Line(points={{80,40},{67.5,40},
              {55,40},{30,40}}, color={255,170,85}));
      connect(r_mFe.port_n, coil.port_n)
        annotation (Line(points={{80,40},{10,40},{10,40}},   color={255,170,85}));
      connect(ground.p, source.n) annotation (Line(
          points={{-80,30},{-80,40}},
          color={0,0,255}));
      connect(ground_m.port, r_mFe.port_n) annotation (Line(
          points={{80,30},{80,40}},
          color={255,170,85}));
      connect(sourceQS.pin_p, currentSensorQS.pin_p) annotation (Line(
          points={{-80,-40},{-70,-40}},
          color={85,170,255}));
      connect(currentSensorQS.pin_n, rQS.pin_p) annotation (Line(
          points={{-50,-40},{-40,-40}},
          color={85,170,255}));
      connect(currentSensorQS.y, complexToPolar.u) annotation (Line(
          points={{-60,-29},{-60,-10},{-52,-10}},
          color={85,170,255}));
      connect(source.p, currentSensor.p) annotation (Line(
          points={{-80,60},{-70,60}},
          color={0,0,255}));
      connect(currentSensor.n, r.p) annotation (Line(
          points={{-50,60},{-40,60}},
          color={0,0,255}));
    connect(currentSensor.i, rootMeanSquare.u) annotation (Line(
        points={{-60,49},{-60,20},{-52,20}},
        color={0,0,127}));
    connect(rootMeanSquare.y, feedback.u1) annotation (Line(
        points={{-29,20},{2,20}},
        color={0,0,127}));
    connect(complexToPolar.len, feedback.u2) annotation (Line(
        points={{-28,-4},{10,-4},{10,12}},
        color={0,0,127}));
      annotation (experiment(
          StopTime=0.2,
          Tolerance=1e-07), Documentation(
            info="<html>
<p>
This model compares a transient-linear magnetic circuit with a quasi static magnetic circuit. A sinusoidal voltage is applied to an inductor with a closed ferromagnetic core of rectangular shape.
</p>

<p>Compare the following quantities</p>
<ul>
<li>Sinusoidal supply voltage<br>
    <code>source.v | sourceQS.v.re|im</code></li>
<li>Non-linear transient current due to saturation and equivalent quasi static current<br>
    <code>currentSensor.i | currentSensorQS.i.re|im</code></li>
<li>Difference between RMS fundamental wave of transient current and the RMS quasi static current<br>
    <code>feedback.y</code></li>
<li>Relative permeability of iron core of transient and quasi static circuit<br>
    <code>r_mFe.mu_rConst | r_mFeQS.mu_rConst</code></li>
</ul>
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false)));
    end LinearInductor;

    model NonLinearInductor "Non linear inductor with ferromagnetic core"
      extends Modelica.Icons.Example;
      output Modelica.SIunits.Current deviation = feedback.y "Deviation of transient and quasi static current";
      FluxTubes.Basic.Ground ground_mQS annotation (Placement(transformation(extent={{80,-90},{100,-70}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource
        sourceQS(
        f=50,
        V=230,
      gamma(fixed=true),
      phi=1.5707963267949) "Voltage applied to inductor"   annotation (Placement(
            transformation(
            origin={-90,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor
        rQS(R_ref=7.5) "Inductor coil resistance"
                                   annotation (Placement(transformation(extent={{-50,-50},
                {-30,-30}})));
      FluxTubes.Basic.ElectroMagneticConverter coilQS(N=600) "Inductor coil" annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
      Basic.ConstantReluctance r_mLeakQS(R_m=1.2e6)
      "Constant leakage reluctance"
        annotation (Placement(transformation(
            origin={20,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Shapes.FixedShape.GenericFluxTube
                               r_mAirParQS(
        l=0.0001,
        mu_rConst=1,
        area=0.025^2)
      "Reluctance of small parasitic air gap (ferromagnetic core packeted from single sheets)"
        annotation (Placement(transformation(extent={{30,-50},
                {50,-30}})));
      Shapes.FixedShape.GenericFluxTube
                               r_mFeQS(
        l=4*0.065,
        mu_rConst=655,
        area=0.025^2) "Reluctance of ferromagnetic inductor core"
        annotation (Placement(transformation(
            origin={90,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));

      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
        groundQS
        annotation (Placement(transformation(extent={{-100,
                -90},{-80,-70}})));

      Modelica.Magnetic.FluxTubes.Basic.Ground ground_m
        annotation (Placement(transformation(extent={{80,10},
                {100,30}})));
      Modelica.Electrical.Analog.Sources.SineVoltage source(
        freqHz=50,
        phase=pi/2,
        V=230*sqrt(2)) "Voltage applied to inductor" annotation (Placement(
            transformation(
            origin={-90,50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor r(R=7.5)
      "Inductor coil resistance"
        annotation (Placement(transformation(extent={{-50,50},
                {-30,70}})));
      Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter
        coil(N=600, i(fixed=true)) "Inductor coil" annotation (Placement(transformation(
              extent={{-20,40},{0,60}})));
      Modelica.Magnetic.FluxTubes.Basic.ConstantReluctance
        r_mLeak(R_m=1.2e6) "Constant leakage reluctance"
                                      annotation (Placement(transformation(
            origin={20,50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube
        r_mAirPar(
        nonLinearPermeability=false,
        mu_rConst=1,
        l=0.0001,
        area=0.025^2)
      "Reluctance of small parasitic air gap (ferromagnetic core packeted from single sheets)"
        annotation (Placement(transformation(extent={{30,50},
                {50,70}})));
      Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube r_mFe(
        l=4*0.065,
        material=
            Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet.M350_50A(),
        B(start=0),
        mu_rConst=655,
        nonLinearPermeability=true,
        area=0.025^2) "Reluctance of ferromagnetic inductor core"
        annotation (Placement(transformation(
            origin={90,50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
            transformation(extent={{-100,10},{-80,30}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor
        currentSensorQS
        annotation (Placement(transformation(extent={{-80,-30},
                {-60,-50}})));
      Modelica.ComplexBlocks.ComplexMath.ComplexToPolar complexToPolar annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={-50,-10})));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
        annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
      Modelica.Blocks.Math.Feedback feedback
        annotation (Placement(transformation(extent={{-10,10},{10,30}})));
      Sensors.Transient.FundamentalWavePermabilitySensor
        fundamentalWavePermabilitySensor(
        f=50,
        A=0.025^2,
        l=4*0.065) annotation (Placement(
            transformation(extent={{60,50},{80,70}})));
    Modelica.Blocks.Math.Harmonic rootMeanSquare(f=50, k=1)
      annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
    equation
      connect(coilQS.port_p, r_mLeakQS.port_p) annotation (Line(points={{0,-40},{0,-40},{20,-40}},
                              color={255,170,85}));
      connect(r_mLeakQS.port_p, r_mAirParQS.port_p)
        annotation (Line(points={{20,-40},{22,-40},
              {30,-40}}, color={255,170,85}));
      connect(r_mAirParQS.port_n, r_mFeQS.port_p)
        annotation (Line(points={{50,-40},{50,-40},
              {90,-40}}, color={255,170,85}));
      connect(r_mFeQS.port_n, r_mLeakQS.port_n) annotation (Line(points={{90,-60},
              {20,-60}}, color={255,170,85}));
      connect(r_mFeQS.port_n, coilQS.port_n) annotation (Line(points={{90,-60},{0,-60},{0,-60}},
                               color={255,170,85}));
      connect(ground_mQS.port, r_mFeQS.port_n) annotation (Line(
          points={{90,-70},{90,-60}},
          color={255,170,85}));
      connect(rQS.pin_n, coilQS.pin_p) annotation (Line(
          points={{-30,-40},{-20,-40},{-20,-40}},
          color={85,170,255}));
      connect(sourceQS.pin_n, coilQS.pin_n) annotation (Line(
          points={{-90,-60},{-20,-60},{-20,-60}},
          color={85,170,255}));
      connect(sourceQS.pin_n, groundQS.pin) annotation (Line(
          points={{-90,-60},{-90,-70}},
          color={85,170,255}));
      connect(r.n, coil.p)
        annotation (Line(points={{-30,60},{-20,60},{-20,60}}, color={0,0,255}));
      connect(source.n, coil.n)
        annotation (Line(points={{-90,40},{-20,40},{-20,40}}, color={0,0,255}));
      connect(coil.port_p, r_mLeak.port_p)
        annotation (Line(points={{0,60},{0,60},{20,60}}, color={255,170,85}));
      connect(r_mLeak.port_p, r_mAirPar.port_p)
        annotation (Line(points={{20,60},{30,60}}, color={255,170,85}));
      connect(r_mFe.port_n, r_mLeak.port_n) annotation (Line(points={{90,40},
              {20,40}}, color={255,170,85}));
      connect(r_mFe.port_n, coil.port_n)
        annotation (Line(points={{90,40},{0,40},{0,40}}, color={255,170,85}));
      connect(ground.p, source.n) annotation (Line(
          points={{-90,30},{-90,40}},
          color={0,0,255}));
      connect(ground_m.port, r_mFe.port_n) annotation (Line(
          points={{90,30},{90,40}},
          color={255,170,85}));
      connect(sourceQS.pin_p, currentSensorQS.pin_p) annotation (Line(
          points={{-90,-40},{-80,-40}},
          color={85,170,255}));
      connect(currentSensorQS.pin_n, rQS.pin_p) annotation (Line(
          points={{-60,-40},{-50,-40}},
          color={85,170,255}));
      connect(currentSensorQS.y, complexToPolar.u) annotation (Line(
          points={{-70,-29},{-70,-10},{-62,-10}},
          color={85,170,255}));
      connect(source.p, currentSensor.p) annotation (Line(
          points={{-90,60},{-80,60}},
          color={0,0,255}));
      connect(currentSensor.n, r.p) annotation (Line(
          points={{-60,60},{-50,60}},
          color={0,0,255}));
      connect(r_mAirPar.port_n,
        fundamentalWavePermabilitySensor.fluxP)
        annotation (Line(
          points={{50,60},{60,60}},
          color={255,170,85}));
      connect(fundamentalWavePermabilitySensor.fluxN,
        r_mFe.port_p) annotation (Line(
          points={{80,60},{90,60}},
          color={255,170,85}));
      connect(fundamentalWavePermabilitySensor.fluxP,
        fundamentalWavePermabilitySensor.potentialP)
        annotation (Line(
          points={{60,60},{60,70},{70,70}},
          color={255,170,85}));
      connect(fundamentalWavePermabilitySensor.potentialN,
        r_mFe.port_n) annotation (Line(
          points={{70,50},{70,40},{90,40}},
          color={255,170,85}));
    connect(complexToPolar.len, feedback.u2) annotation (Line(
        points={{-38,-4},{0,-4},{0,12}},
        color={0,0,127}));
    connect(currentSensor.i, rootMeanSquare.u) annotation (Line(
        points={{-70,49},{-70,20},{-62,20}},
        color={0,0,127}));
    connect(rootMeanSquare.y_rms, feedback.u1) annotation (Line(
        points={{-39,26},{-20,26},{-20,20},{-8,20}},
        color={0,0,127}));
      annotation (experiment(
          StopTime=0.2,
          Tolerance=1e-07),                                   Documentation(
            info="<html>
<p>
This model compares a transient non-linear magnetic circuit with a linearized quasi static magnetic circuit. A sinusoidal voltage is applied to an inductor with a closed ferromagnetic core of rectangular shape.
</p>

<p>Compare the following quantities</p>
<ul>
<li>Sinusoidal supply voltage<br>
    <code>source.v | sourceQS.v.re|im</code></li>
<li>Non-linear transient current due to saturation and equivalent quasi static current<br>
    <code>currentSensor.i | currentSensorQS.i.re|im</code></li>
<li>Difference between RMS fundamental wave of transient current and the RMS quasi static current<br>
    <code>feedback.y</code></li>
<li>Effective fundamental wave relative permeability of iron core of transient and quasi static circuit<br>
    <code>fundamentalWavePermabilitySensor.mur | r_mFeQS.mu_rConst</code></li>
</ul>
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false)));
    end NonLinearInductor;

    package FixedShapes "Examples of fixed shape magnetic circuits"
    extends Modelica.Icons.ExamplesPackage;
      model CylinderSections
      "Magnetic circuit using different cylinder sections"
        extends Modelica.Icons.Example;
        parameter Modelica.SIunits.RelativePermeability mu_rConst = 100
        "Relative permeability";
      Shapes.FixedShape.HollowCylinderAxialFlux hollowCylinderAxialInner(
        l=0.01,
        r_o=0.02,
        r_i=0.01,
          mu_rConst=mu_rConst)
        annotation (Placement(transformation(extent={{-20,10},{0,30}})));
      Shapes.FixedShape.HollowCylinderRadialFlux hollowCylinderRadiaLRight(
          mu_rConst=mu_rConst,
          l=0.02,
          r_i=0.015,
          r_o=0.055)
                  annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={40,38})));
      Shapes.FixedShape.HollowCylinderRadialFlux hollowCylinderRadialLeft(
          mu_rConst=mu_rConst,
          l=0.02,
          r_i=0.015,
          r_o=0.055)
                  annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-60,40})));
      Shapes.FixedShape.HollowCylinderAxialFlux hollowCylinderAxialOuter(
        l=0.01,
        r_i=0.05,
          mu_rConst=mu_rConst,
          r_o=0.06)
                   annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={-10,60})));
      Basic.Ground ground
        annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
        Modelica.Blocks.Sources.Constant constFrequency(k=50)
          annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
      Sources.SignalMagneticFlux source(gamma(fixed=true, start=0))
                                        annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-40,-10})));
        Basic.Crossing crossing
          annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
        ComplexBlocks.Sources.ComplexRampPhasor complexRamp(
          magnitude2=0.0008,
          phi=0,
          duration=1,
          magnitude1=0) annotation (Placement(transformation(extent={{0,-80},{-20,-60}})));
      equation
      connect(hollowCylinderAxialInner.port_n, hollowCylinderRadiaLRight.port_p)
        annotation (Line(
          points={{0,20},{40,20},{40,28}}, color={255,170,85}));
      connect(hollowCylinderRadiaLRight.port_n, hollowCylinderAxialOuter.port_p)
        annotation (Line(
          points={{40,48},{40,60},{0,60}}, color={255,170,85}));
      connect(hollowCylinderAxialOuter.port_n, hollowCylinderRadialLeft.port_p)
        annotation (Line(
          points={{-20,60},{-60,60},{-60,50}},
          color={255,170,85}));
        connect(constFrequency.y, source.f) annotation (Line(
            points={{-59,-70},{-46,-70},{-46,-22}},
            color={0,0,127}));
        connect(hollowCylinderRadialLeft.port_n, ground.port) annotation (Line(
            points={{-60,30},{-60,-10}},
            color={255,170,85}));
        connect(source.port_p, crossing.port_p2) annotation (Line(
            points={{-30,-10},{-30,0}},
            color={255,170,85}));
        connect(source.port_n, crossing.port_n1) annotation (Line(
            points={{-50,-10},{-50,-10},{-50,0}},
            color={255,170,85}));
        connect(crossing.port_n2, hollowCylinderAxialInner.port_p) annotation (Line(
            points={{-30,20},{-20,20}},
            color={255,170,85}));
        connect(crossing.port_p1, ground.port) annotation (Line(
            points={{-50,20},{-60,20},{-60,-10}},
            color={255,170,85}));
        connect(complexRamp.y, source.Phi) annotation (Line(points={{-21,-70},{-34,-70},{-34,-22}}, color={85,170,255}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>This model tests different types of cylinder sections in one example. The circuit is operated at 50Hz and variable magnetic flux.</p>
</html>"),experiment(StopTime=1,Interval=0.001));
      end CylinderSections;

      model CuboidSections "Magnetic circuit using different cuboid sections"
        extends Modelica.Icons.Example;
        parameter Modelica.SIunits.RelativePermeability mu_rConst = 100
        "Relative permeability";
      Basic.Ground ground
        annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
      Sources.SignalMagneticPotentialDifference source(gamma(fixed=true, start=0))
                                                       annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-40,20})));
        Shapes.FixedShape.Cuboid cuboidBottom(
          mu_rConst=mu_rConst,
          l=0.1,
          a=0.01,
          b=0.01) annotation (Placement(transformation(extent={{-20,10},{0,30}})));
        Shapes.FixedShape.Cuboid cuboidTop(
          mu_rConst=mu_rConst,
          a=0.01,
          l=0.1,
          b=0.01) annotation (Placement(transformation(extent={{-20,50},{0,70}})));
        Shapes.FixedShape.Cuboid cuboidRight(
          mu_rConst=mu_rConst,
          a=0.01,
          l=0.005,
          b=0.01) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={40,40})));
        Shapes.FixedShape.Cuboid cuboidLeft(
          mu_rConst=mu_rConst,
          a=0.01,
          l=0.005,
          b=0.01) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-60,40})));
        Modelica.Blocks.Sources.Constant constFrequency(k=50)
          annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
        Basic.Short short
          annotation (Placement(transformation(extent={{12,10},{32,30}})));
        Basic.Idle idle annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={80,40})));
        ComplexBlocks.Sources.ComplexRampPhasor complexRamp(
          magnitude2=0.0008,
          phi=0,
          duration=1,
          magnitude1=0) annotation (Placement(transformation(extent={{0,-70},{-20,-50}})));
      equation
        connect(source.port_n, ground.port) annotation (Line(
            points={{-50,20},{-60,20},{-60,-10}},
            color={255,170,85}));
        connect(cuboidLeft.port_p, cuboidTop.port_p) annotation (Line(
            points={{-60,50},{-60,60},{-20,60}},
            color={255,170,85}));
        connect(cuboidTop.port_n, cuboidRight.port_n) annotation (Line(
            points={{0,60},{40,60},{40,50}},
            color={255,170,85}));
        connect(cuboidBottom.port_p, source.port_p) annotation (Line(
            points={{-20,20},{-30,20}},
            color={255,170,85}));
        connect(source.port_n, cuboidLeft.port_n) annotation (Line(
            points={{-50,20},{-60,20},{-60,30}},
            color={255,170,85}));
        connect(constFrequency.y, source.f) annotation (Line(
            points={{-59,-60},{-46,-60},{-46,8}},
            color={0,0,127}));
        connect(cuboidBottom.port_n, short.port_p) annotation (Line(
            points={{0,20},{12,20}},
            color={255,170,85}));
        connect(short.port_n, cuboidRight.port_p) annotation (Line(
            points={{32,20},{40,20},{40,30}},
            color={255,170,85}));
        connect(idle.port_p, cuboidTop.port_n) annotation (Line(
            points={{80,50},{80,60},{0,60}},
            color={255,170,85}));
        connect(idle.port_n, short.port_n) annotation (Line(
            points={{80,30},{80,20},{32,20}},
            color={255,170,85}));
        connect(complexRamp.y, source.V_m) annotation (Line(points={{-21,-60},{-34,-60},{-34,8}},  color={85,170,255}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false),          graphics={Text(
                extent={{-100,100},{100,80}},
                lineColor={0,0,255},
                pattern=LinePattern.Dash,
                textString="Added short and idle model for testing purposes only")}),
          Documentation(info="<html>
<p>This model investigates a magnetic circuit consisting of four different cuboid sections. The circuit is operated at 50Hz and variable magnetic potential difference.</p>
</html>"),experiment(StopTime=1,Interval=0.001));
      end CuboidSections;
      annotation (Documentation(info="<html>
<p>This package contains examples of quasi-static magnetic circuits with fixed shape components.</p>
</html>"));
    end FixedShapes;

    package Leakage "Examples of magnetic circuits with leakage"
    extends Modelica.Icons.ExamplesPackage;
      model CylinderLeakage "Testing cylinder leakage models"
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        parameter Modelica.SIunits.RelativePermeability mu_rConst = 100
        "Relative permeability";
        Shapes.Leakage.QuarterCylinder quarterCylinder1(l=2*pi*0.1)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Shapes.FixedShape.HollowCylinderAxialFlux hollowCylinderAxialFlux1(
          r_i=0,
          r_o=0.04,
          l=0.1,
          mu_rConst=mu_rConst)
          annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
        Shapes.FixedShape.HollowCylinderAxialFlux hollowCylinderAxialFlux2(
          r_i=0,
          l=0.1,
          r_o=0.05,
          mu_rConst=mu_rConst)
                 annotation (Placement(transformation(extent={{20,-10},{40,10}})));
        Shapes.Leakage.QuarterCylinder quarterCylinder2(l=2*pi*0.1)
          annotation (Placement(transformation(extent={{50,-10},{70,10}})));
        Sources.ConstantMagneticFlux constantSource(f=50, Phi=Complex(re=5E-3,
            im=0))
        annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));
        Basic.Ground ground1 annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-90,0})));
        Shapes.FixedShape.HollowCylinderAxialFlux hollowCylinderAxialAir1(
          r_i=0,
          r_o=0.04,
          l=0.01) annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
        Shapes.FixedShape.HollowCylinderAxialFlux hollowCylinderAxialAir2(
          r_i=0,
          r_o=0.04,
          l=0.01) annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
      Sensors.MagneticPotentialSensor magneticPotentialSensor annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-40,-80})));
      Sensors.MagneticPotentialDifferenceSensor
        magneticPotentialDifferenceSensor
        annotation (Placement(transformation(extent={{-50,-40},{-70,-20}})));
      Sensors.MagneticFluxSensor magneticFluxSensor
        annotation (Placement(transformation(extent={{-50,40},{-70,20}})));
      Sensors.ReferenceSensor referenceSensor
        annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
      Sensors.FrequencySensor frequencySensor
        annotation (Placement(transformation(extent={{-60,-70},{-80,-50}})));
      equation
        connect(quarterCylinder2.port_p, hollowCylinderAxialFlux2.port_n) annotation (
           Line(
            points={{50,0},{40,0}},
            color={255,170,85}));
        connect(hollowCylinderAxialFlux2.port_p, quarterCylinder1.port_n) annotation (
           Line(
            points={{20,0},{10,0}},
            color={255,170,85}));
        connect(quarterCylinder1.port_p, hollowCylinderAxialFlux1.port_n) annotation (
           Line(
            points={{-10,0},{-20,0}},
            color={255,170,85}));
        connect(hollowCylinderAxialAir2.port_n, quarterCylinder2.port_n) annotation (
            Line(
            points={{70,-20},{80,-20},{80,0},{70,0}},
            color={255,170,85}));
        connect(hollowCylinderAxialAir2.port_p, hollowCylinderAxialFlux2.port_n)
          annotation (Line(
            points={{50,-20},{40,-20},{40,0}},
            color={255,170,85}));
        connect(hollowCylinderAxialAir1.port_n, hollowCylinderAxialFlux2.port_p)
          annotation (Line(
            points={{10,-20},{20,-20},{20,0}},
            color={255,170,85}));
        connect(hollowCylinderAxialAir1.port_p, hollowCylinderAxialFlux1.port_n)
          annotation (Line(
            points={{-10,-20},{-20,-20},{-20,0}},
            color={255,170,85}));
      connect(ground1.port, constantSource.port_n) annotation (Line(
          points={{-80,0},{-76,0},{-76,0},{-70,0}},
          color={255,170,85}));
      connect(constantSource.port_p, hollowCylinderAxialFlux1.port_p)
        annotation (Line(
          points={{-50,0},{-40,0}},
          color={255,170,85}));
      connect(ground1.port, magneticPotentialDifferenceSensor.port_n)
        annotation (Line(
          points={{-80,0},{-80,-30},{-70,-30}},
          color={255,170,85}));
      connect(magneticPotentialDifferenceSensor.port_p,
        hollowCylinderAxialFlux1.port_p) annotation (Line(
          points={{-50,-30},{-40,-30},{-40,0}},
          color={255,170,85}));
      connect(hollowCylinderAxialFlux1.port_p, magneticPotentialSensor.port)
        annotation (Line(
          points={{-40,0},{-40,-70}},
          color={255,170,85}));
      connect(magneticFluxSensor.port_n, ground1.port) annotation (Line(
          points={{-70,30},{-80,30},{-80,0}},
          color={255,170,85}));
      connect(magneticFluxSensor.port_p, quarterCylinder2.port_n) annotation (
          Line(
          points={{-50,30},{80,30},{80,0},{70,0}},
          color={255,170,85}));
      connect(frequencySensor.port, hollowCylinderAxialFlux1.port_p)
        annotation (Line(
          points={{-60,-60},{-40,-60},{-40,0}},
          color={255,170,85}));
      connect(referenceSensor.port, hollowCylinderAxialFlux1.port_p)
        annotation (Line(
          points={{-20,-60},{-40,-60},{-40,0}},
          color={255,170,85}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false)),
          experiment(StopTime=1,Interval=0.001),
        Documentation(info="<html>
<p>Test of one source and cylindrical components with leakage and various sensors.</p>
</html>"));
      end CylinderLeakage;

      model GeneralLeakage "Magnetic circuit with generic leakage mode"
        extends Modelica.Icons.Example;
        Basic.ConstantReluctance constantReluctance(R_m=1E-5)
          annotation (Placement(transformation(extent={{0,50},{20,70}})));
        Basic.LeakageWithCoefficient leakageWithCoefficient(R_mUsefulTot=1E-5)
          annotation (Placement(transformation(extent={{20,10},{0,30}})));
        Basic.EddyCurrent eddyCurrent(useConductance=true, G=10000) annotation (
            Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={40,40})));
        Sources.ConstantMagneticPotentialDifference constantSource(f=50, V_m(re=100,
              im=0)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-20,40})));
        Basic.Ground ground
          annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
      equation
        connect(constantReluctance.port_p, constantSource.port_p) annotation (Line(
            points={{0,60},{-20,60},{-20,50}},
            color={255,170,85}));
        connect(constantReluctance.port_n, eddyCurrent.port_p) annotation (Line(
            points={{20,60},{40,60},{40,50}},
            color={255,170,85}));
        connect(eddyCurrent.port_n, leakageWithCoefficient.port_p) annotation (Line(
            points={{40,30},{40,20},{20,20}},
            color={255,170,85}));
        connect(leakageWithCoefficient.port_n, constantSource.port_n) annotation (
            Line(
            points={{0,20},{-20,20},{-20,30}},
            color={255,170,85}));
        connect(ground.port, constantSource.port_n) annotation (Line(
            points={{-20,0},{-20,30}},
            color={255,170,85}));
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false)),
          experiment(StartTime=1,Interval=0.001),
        Documentation(info="<html>
<p>Magnetic circuit with two reluctances, leakage reluctance,  and eddy current loss.</p>
</html>"));
      end GeneralLeakage;
      annotation (Documentation(info="<html>
<p>This package contains examples of quasi-static magnetic circuits with leakage field components.</p>
</html>"));
    end Leakage;
    annotation (Documentation(info="<html>
<p>
This package contains examples to demonstrate the usage of the quasi static flux tubes components.
</p>
</html>"));
  end Examples;

  package Basic "Basic elements of magnetic network models"
    extends Modelica.Icons.Package;

    model Ground "Zero magnetic potential"

      FluxTubes.Interfaces.PositiveMagneticPort port annotation (Placement(transformation(extent={{-10,110},{10,90}}, rotation=-0)));
    equation
      port.V_m = Complex(0);
      annotation (
        Documentation(info="<html>
<p>
The magnetic potential at the magnetic ground node is zero. Every magnetic network model must contain at least one magnetic ground object.
</p>
</html>"),
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-60,50},{60,50}}, color={255,170,85}),
          Line(points={{-40,30},{40,30}}, color={255,170,85}),
          Line(points={{-20,10},{20,10}}, color={255,170,85}),
          Line(points={{0,90},{0,50}}, color={255,170,85}),
          Text(
            extent={{-150,-50},{150,-10}},
            lineColor={0,0,255},
            textString="%name")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={Line(
                  points={{-60,50},{60,50}},
                  color={255,170,85}),
                                 Line(
                  points={{-40,30},{40,30}},
                  color={255,170,85}),
                                 Line(
                  points={{-20,10},{20,10}},
                  color={255,170,85}),
                                 Line(
                  points={{0,100},{0,50}},
                  color={255,170,85}),
                                 Text(
                  extent={{-40,-40},{40,20}},
                  lineColor={0,0,255},
                  textString="port.V_m = 0")}));
    end Ground;

    model ElectroMagneticConverter "Electro-magnetic energy conversion"

      constant Complex j=Complex(0, 1);
      FluxTubes.Interfaces.PositiveMagneticPort port_p "Positive magnetic port" annotation (Placement(transformation(extent={{90,90},{110,110}}), iconTransformation(extent={{90,90},{110,110}})));
      FluxTubes.Interfaces.NegativeMagneticPort port_n "Negative magnetic port" annotation (Placement(transformation(extent={{110,-110},{90,-90}}), iconTransformation(extent={{110,-110},{90,-90}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin pin_p
      "Positive electric pin" annotation (Placement(transformation(extent={{-90,90},{-110,110}}), iconTransformation(extent={{-90,90},{-110,110}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin pin_n
      "Negative electric pin"   annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}), iconTransformation(extent={{-110,-110},{-90,-90}})));
      Modelica.SIunits.ComplexVoltage v "Voltage";
      Modelica.SIunits.ComplexCurrent i(re(start=0, stateSelect=StateSelect.prefer),
                                        im(start=0, stateSelect=StateSelect.prefer))
      "Current";
      Modelica.SIunits.ComplexMagneticPotentialDifference V_m
      "Magnetic potential difference";
      Modelica.SIunits.ComplexMagneticFlux Phi
      "Magnetic flux coupled into magnetic circuit";
      Modelica.SIunits.AngularVelocity omega;

      parameter Real N=1 "Number of turns";

      //for information only:
      Modelica.SIunits.ComplexMagneticFlux Psi
      "Flux linkage for information only";
      SI.Inductance L_stat "Static inductance abs(Psi/i) for information only";

    protected
      Real eps=100*Modelica.Constants.eps;
    equation
      v = pin_p.v - pin_n.v;
      Complex(0) = pin_p.i + pin_n.i;
      i = pin_p.i;

      V_m = port_p.V_m - port_n.V_m;
      Complex(0) = port_p.Phi + port_n.Phi;
      Phi = port_p.Phi;

      // Induced voltages from complex magnetic flux, number of turns
      // and angles of orientation of winding
      v = -j*omega*N*Phi;
      // Amperes law
      V_m = N*i;
      // for information only:
      Psi = N*Phi;
      // Use of abs for positive results; due to Modelica sign conventions for flow into connectors:
      L_stat = noEvent(if Modelica.ComplexMath.'abs'(i) > eps then Modelica.ComplexMath.'abs'(Psi/i) else Modelica.ComplexMath.'abs'(Psi/eps));

      omega = der(port_p.reference.gamma);

      // Potential roots are not used; instead the reference angle is handled
      // by means of Connections.branch between electric pin_p and magnetic port_p
      Connections.branch(port_p.reference, port_n.reference);
      port_p.reference.gamma = port_n.reference.gamma;
      Connections.branch(pin_p.reference, pin_n.reference);
      pin_p.reference.gamma = pin_n.reference.gamma;
      Connections.branch(port_p.reference, pin_p.reference);
      port_p.reference.gamma = pin_p.reference.gamma;
      annotation (
        defaultComponentName="converter",
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}})),
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-30,100},{-30,60}},color={85,170,255}),
          Line(points={{-30,-60},{-30,-100}},color={85,170,255}),
          Line(points={{-30,100},{-90,100}},
                                           color={85,170,255}),
          Line(points={{-30,-100},{-88,-100}},
                                             color={85,170,255}),
          Line(
            points={{0,80},{-100,80}},
            color={85,170,255},
            pattern=LinePattern.Dash),
          Line(
            points={{-100,80},{-100,-80}},
            color={85,170,255},
            pattern=LinePattern.Dash),
          Line(
            points={{0,-80},{-100,-80}},
            color={85,170,255},
            pattern=LinePattern.Dash),
          Line(
            points={{100,80},{0,80}},
            color={255,170,85},
            pattern=LinePattern.Dash),
          Line(
            points={{100,-80},{0,-80}},
            color={255,170,85},
            pattern=LinePattern.Dash),
          Line(
            points={{100,80},{100,-80}},
            color={255,170,85},
            pattern=LinePattern.Dash),
          Ellipse(extent={{-4,-34},{64,34}}, lineColor={255,170,85}),
          Line(points={{30,-100},{30,-34}},color={255,170,85}),
          Line(points={{18,0},{42,0}}, color={255,170,85}),
          Line(points={{42,10},{42,-12}}, color={255,170,85}),
          Line(points={{30,34},{30,100}},color={255,170,85}),
          Line(points={{30,100},{90,100}},color={255,170,85}),
          Line(points={{30,-100},{90,-100}},
                                           color={255,170,85}),
          Text(
            extent={{-150,150},{150,110}},
            textString="%name",
              pattern=LinePattern.None,
              lineColor={0,0,255}),
          Line(points={{18,10},{18,-12}}, color={255,170,85}),
          Line(points={{-110,30},{-110,-30}},
                                            color={85,170,255}),
          Polygon(
            points={{-110,-30},{-104,-10},{-116,-10},{-110,-30}},
            lineColor={85,170,255},
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid),
          Line(points={{110,30},{110,-30}},
                                          color={255,170,85}),
          Polygon(
              points={{110,-30},{116,-10},{104,-10},{110,-30}},
              lineColor={255,170,85},
              fillColor={255,170,85},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={85,170,255},
              smooth=Smooth.Bezier,
              origin={-23,45},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={85,170,255},
              smooth=Smooth.Bezier,
              origin={-23,15},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={85,170,255},
              smooth=Smooth.Bezier,
              origin={-23,-15},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={85,170,255},
              smooth=Smooth.Bezier,
              origin={-23,-45},
              rotation=270)}),
        Documentation(info="<html>
<p>
The electro magnetic energy conversion is given by <strong>Ampere</strong>'s law and <strong>Faraday</strong>'s law respectively:
</p>

<dl>
<dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/converter.png\">
</dd>
</dl>

<p>
In this equation
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/V_m.png\">
is the magnetomotive force that is supplied to the connected magnetic circuit,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/Phi.png\">
is the magnetic flux through the associated branch of this magnetic circuit. The negative sign of the induced voltage
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/v.png\"> is due to <strong>Lenz</strong>'s law.
</p>

<p>
The static inductance is calculated from the flux linkage
</p>
<dl>
<dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/Psi-N-Phi.png\">
</dd>
</dl>
<p>and the current
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/i.png\">:
</p>
<dl>
<dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/L_stat-Psi-i.png\">
</dd>
</dl>
<p>
This quantity is calculated for information only.</p>

<h5>Note</h5>

<p><img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/L_stat.png\">
is set to</p>
<dl>
<dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/L_stat-Psi-eps.png\">
</dd>
</dl>
<p>
if
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/i-lt-eps.png\">.
</p></html>"));
    end ElectroMagneticConverter;

    model ConstantReluctance "Constant reluctance"

      extends FluxTubes.Interfaces.PartialTwoPorts;

      parameter SI.Reluctance R_m=1 "Magnetic reluctance";

    equation
      V_m = Phi*R_m;

      annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={255,170,85},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-70,0},{-90,0}}, color={255,170,85}),
          Line(points={{70,0},{90,0}}, color={255,170,85}),
          Text(
            extent={{-150,50},{150,90}},
            textString="%name",
            lineColor={0,0,255})}), Documentation(info="<html>
<p>
This constant reluctance is provided for test purposes and simple magnetic network models. The reluctance is not calculated from geometry and permeability of a flux tube, but is provided as parameter.
</p>
</html>"));
    end ConstantReluctance;

    model ConstantPermeance "Constant permeance"

      extends FluxTubes.Interfaces.PartialTwoPorts;

      parameter SI.Permeance G_m=1 "Magnetic permeance";

    equation
      G_m * V_m = Phi;

      annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={255,170,85},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
          Line(points={{-70,0},{-90,0}}, color={255,170,85}),
          Line(points={{70,0},{90,0}}, color={255,170,85}),
          Text(
            extent={{-150,50},{150,90}},
            textString="%name",
            lineColor={0,0,255})}), Documentation(info="<html>
<p>
This constant permeance is provided for test purposes and simple magnetic network models. The permeance is not calculated from geometry and permeability of a flux tube, but is provided as parameter.
</p>
</html>", revisions="<html>
</html>"));
    end ConstantPermeance;

    model LeakageWithCoefficient
    "Leakage reluctance with respect to the reluctance of a useful flux path (not for dynamic simulation of actuators)"

      extends FluxTubes.Interfaces.PartialLeakage;

      parameter SI.CouplingCoefficient c_usefulFlux=0.7
      "Ratio useful flux/(leakage flux + useful flux) = useful flux/total flux";

      input SI.Reluctance R_mUsefulTot
      "Total reluctance of useful flux path as reference"   annotation (Dialog(
            group="Reference reluctance", groupImage=
              "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Basic/LeakageWithCoefficient.png"));

    equation
      (1 - c_usefulFlux)*R_m = c_usefulFlux*R_mUsefulTot;
      // Generalized Kirchhoff's current law

      annotation (Documentation(info="<html>
<p>
Differently from the flux tube elements of package <a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage\">Shapes.Leakage</a>
that are calculated from their geometry, this leakage reluctance is calculated with reference to the total reluctance of a useful flux path. Parameter <code>c_usefulFlux</code> is the ratio of the useful flux over the total flux.
</p>
</html>"));
    end LeakageWithCoefficient;

    model EddyCurrent
    "For modelling of eddy current in a conductive magnetic flux tube"

      constant Complex j=Complex(0, 1);
      extends FluxTubes.Interfaces.PartialTwoPorts;

      parameter Boolean useConductance = false
      "Use conductance instead of geometry data and rho"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Modelica.SIunits.Conductance G(min=0) = 1/0.098e-6
      "Equivalent loss conductance G=A/rho/l"
        annotation(Dialog(enable=useConductance),Evaluate=true);
      parameter SI.Resistivity rho=0.098e-6
      "Resistivity of flux tube material (default: Iron at 20degC)"
        annotation(Dialog(enable=not useConductance));
      parameter SI.Length l=1 "Average length of eddy current path"
        annotation(Dialog(enable=not useConductance));
      parameter SI.Area A=1 "Cross sectional area of eddy current path"
        annotation(Dialog(enable=not useConductance));

      final parameter SI.Resistance R=rho*l/A
      "Electrical resistance of eddy current path"
        annotation(Dialog(enable=not useConductance));

      extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
          final T=273.15);

    equation
      lossPower = (pi/2)*Modelica.ComplexMath.imag(omega*V_m*
        Modelica.ComplexMath.conj(Phi));
      // Alternative calculation of loss power
      // lossPower = -(pi/2)*Modelica.ComplexMath.real(j*omega*V_m*Modelica.ComplexMath.conj(Phi));
      if G > 0 then
        (pi/2)*V_m = j*omega*Phi * (if useConductance then G else 1/R);
      else
        V_m = Complex(0, 0);
      end if;

      annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-70,0},{-90,0}}, color={255,170,85}),
          Line(points={{70,0},{90,0}}, color={255,170,85}),
          Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={255,170,85},
              fillColor={255,170,85},
              fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,50},{150,90}},
            textString="%name",
            lineColor={0,0,255})}), Documentation(info="<html>
<p>
Eddy currents are induced in a conductive magnetic flux tube when the flux changes with time. This causes a magnetic voltage drop in addition to the voltage drop that is due to the reluctance of this flux tube. The eddy current component can be thought of as a short-circuited secondary winding of a transformer with only one turn. Its resistance is then determined by the geometry and resistivity of the eddy current path. Alternatively, a total conductance parameter can be used.
</p>

<p>
Partitioning of a solid conductive cylinder or prism into several hollow cylinders or separate nested prisms and modelling of each of these flux tubes connected in parallel with a series connection of a reluctance element and an eddy current component can model the delayed buildup of the magnetic field in the complete flux tube from the outer to the inner sections. Please refer to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ka08]</a> for an illustration.
</p>
</html>",     revisions="<html>
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false)));
    end EddyCurrent;

    model Idle "Idle running branch"
      extends FluxTubes.Interfaces.PartialTwoPorts;
    equation
      Phi = Complex(0);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{-100,0},{-40,0}}, color={255,170,85}),
            Line(points={{40,0},{100,0}}, color={255,170,85}),
          Text(
            extent={{-150,50},{150,90}},
            textString="%name",
            lineColor={0,0,255})}),
        Documentation(info="<html>
<p>
This is a simple idle running branch. The magnetic flux through this component is equal to zero.
</p></html>",
          revisions="<html>
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}})));
    end Idle;

    model Short "Short cut branch"
      extends FluxTubes.Interfaces.PartialTwoPorts;
    equation
      V_m = Complex(0,0);
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-100,0},{100,0}}, color={255,170,85}),
          Text(
            extent={{-150,50},{150,90}},
            textString="%name",
            lineColor={0,0,255})}), Documentation(
            info="<html>
<p>
This is a simple short cut branch. The magnetic voltage of this component is equal to zero.
</p></html>", revisions="<html>
</html>"));
    end Short;

    model Crossing "Crossing of two branches"

      FluxTubes.Interfaces.PositiveMagneticPort port_p1 "Positive port_p1 connected with port_p2" annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
      FluxTubes.Interfaces.PositiveMagneticPort port_p2 "Positive port_p2 connected with port_p1" annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
      FluxTubes.Interfaces.NegativeMagneticPort port_n1 "Negative port_n1 connected with port_n2" annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
      FluxTubes.Interfaces.NegativeMagneticPort port_n2 "Negative port_n2 connected with port_n1" annotation (Placement(transformation(extent={{90,90},{110,110}})));

    equation
      Connections.branch(port_p1.reference, port_p2.reference);
      Connections.branch(port_n1.reference, port_n2.reference);
      port_p1.reference.gamma = port_p2.reference.gamma;
      port_n1.reference.gamma = port_n2.reference.gamma;

      port_p1.V_m = port_p2.V_m;
      port_p1.Phi + port_p2.Phi = Complex(0,0);
      port_n1.V_m = port_n2.V_m;
      port_n1.Phi + port_n2.Phi = Complex(0,0);

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
          Line(
              points={{100,100},{40,100},{-40,-100},{-100,-100}},
              color={255,170,85}),
          Line(
              points={{-100,100},{-40,100},{40,-98},{100,-100}},
              color={255,170,85}),
            Text(
              extent={{-150,110},{150,150}},
              lineColor={0,0,255},
              textString="%name")}), Documentation(
            info="<html>
<p>
This is a simple crossing of two branches. The ports <code>port_p1</code> and <code>port_p2</code> are connected, as well as <code>port_n1</code> and <code>port_n2</code>.
</p></html>",
          revisions="<html>
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false)));
    end Crossing;
    annotation (Documentation(info="<html>
<p>This package contains the basic components of quasi static flux tubes package.</p>
</html>"));
  end Basic;

  package Shapes
  "Reluctance and permeance elements respectively based on geometric shapes"
    extends Modelica.Icons.Package;

    package FixedShape
    "Flux tubes with fixed shape during simulation and linear or non-linear material characteristics"
      extends Modelica.Icons.VariantsPackage;

      model GenericFluxTube
      "Flux tube with fixed cross-section and length; linear or non-linear material characteristics"

        extends FluxTubes.Interfaces.PartialFixedShape;

        parameter SI.Length l=0.01 "Length in direction of flux"
          annotation(Dialog(group="Fixed geometry", groupImage=
            "modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/GenericFluxTube_qs.png"));
        parameter SI.CrossSection area=0.0001 "Area of cross section"
          annotation (Dialog(group="Fixed geometry"));
      equation
        A=area;
        G_m = (mu_0*mu_r*A)/l;

        annotation (Documentation(info="<html>
<p>
The generic flux tube models the reluctance with constant
<code>area</code> of cross section, and length, <code>l</code>
the magnetic reluctance by:</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m_generic.png\">,
</dd></dl>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/GenericFluxTube_qs.png\">
</p></html>",
          revisions="<html>
<h5>Version 3.2.2, 2014-01-15 (Christian&nbsp;Kral)</h5>
<ul>
<li>Added GenericFluxTube</li>
</ul>

</html>"),       Icon(coordinateSystem(preserveAspectRatio=false)));
      end GenericFluxTube;

      model Cuboid
      "Flux tube with rectangular cross-section; fixed shape; linear or non-linear material characteristics"

        extends FluxTubes.Interfaces.PartialFixedShape;

        parameter SI.Length l=0.01 "Length in direction of flux" annotation (
            Dialog(group="Fixed geometry", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/CuboidParallelFlux_qs.png"));
        parameter SI.Length a=0.01 "Width of rectangular cross-section"
          annotation (Dialog(group="Fixed geometry"));
        parameter SI.Length b=0.01 "Height of rectangular cross-section"
          annotation (Dialog(group="Fixed geometry"));

      equation
        A = a*b;
        G_m = (mu_0*mu_r*A)/l;

        annotation (Documentation(info="<html>
<p>
The cuboid models the reluctance with rectangular dimensions <code>a</code> and <code>b</code>, and length, <code>l</code>
the magnetic reluctance by:</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m_cuboid.png\">
</dd></dl>

<p>The area of cross section is determined by:</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/A_cuboid.png\">
</dd></dl>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/CuboidParallelFlux_qs.png\">
</p></html>"));
      end Cuboid;

      model HollowCylinderAxialFlux
      "(Hollow) cylinder with axial flux; fixed shape; linear or non-linear material characteristics"

        extends FluxTubes.Interfaces.PartialFixedShape;

        parameter SI.Length l=0.01 "Axial length (in direction of flux)"
          annotation (Dialog(group="Fixed geometry", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/HollowCylinderAxialFlux_qs.png"));
        parameter SI.Radius r_i=0
        "Inner radius of hollow cylinder (zero for cylinder)"
          annotation (Dialog(group="Fixed geometry"));
        parameter SI.Radius r_o=0.01 "Outer radius of (hollow) cylinder"
          annotation (Dialog(group="Fixed geometry"));
        parameter Modelica.SIunits.Angle alpha=2*Modelica.Constants.pi
        "Central angle";
      equation
        A = pi*(r_o^2 - r_i^2)*alpha/(2*Modelica.Constants.pi);
        G_m = (mu_0*mu_r*A)/l;

        annotation (Documentation(info="<html>
<p>The axial cylinder models is characterized by the outer diameter, <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/r_o.png\"/>, the inner diameter, <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/r_i.png\"/>, length, <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/l.png\"/>. The magnetic reluctance is determined by:</p>
<p><img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m_cuboid.png\"/></p>
<p>The area of cross section yields:</p>
<p><img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/A_axial.png\"/></p>
<p><img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/HollowCylinderAxialFlux_qs.png\"/></p>
<p>A hollow cylinder is depicted in the above figure left for <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/alpha2pi.png\"/>. A solid cylindric flux tube an be considered by setting the inner radius, <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/r_i.png\"/>, equal to zero.</p>
<p>A circular sector of the area of cross section with central angle <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/alpha.png\"/> is depicted in the above figure right.</p>
</html>"));
      end HollowCylinderAxialFlux;

      model HollowCylinderRadialFlux
      "Hollow cylinder with radial flux; fixed shape; linear or non-linear material characteristics"

        extends FluxTubes.Interfaces.PartialFixedShape;

        parameter SI.Length l=0.01 "Width (orthogonal to flux direction)"
                                                 annotation (Dialog(group=
                "Fixed geometry", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/HollowCylinderRadialFlux_qs.png"));
        parameter SI.Radius r_i=0.01 "Inner radius of hollow cylinder"
          annotation (Dialog(group="Fixed geometry"));
        parameter SI.Radius r_o=0.02 "Outer radius of hollow cylinder"
          annotation (Dialog(group="Fixed geometry"));
        parameter Modelica.SIunits.Angle alpha=2*Modelica.Constants.pi
        "Central angle";
      equation
        A = l*pi*(r_o + r_i);
        // Area at arithmetic mean radius for calculation of average flux density
        G_m = 2*pi*mu_0*mu_r*l/Modelica.Math.log(r_o/r_i)*alpha/(2*Modelica.Constants.pi);

        annotation (Documentation(info="<html>
<p>The radial cylinder model is characterized by the outer diameter, <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/r_o.png\"/>, the inner diameter, <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/r_i.png\"/>, length, <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/l.png\"/>, and the angle <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/alpha.png\"/>. The magnetic reluctance is determined by:</p>
<p><img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m_radial.png\"/></p>
<p>In this model the magnetic flux and the magnetic potential difference, respectively, are radially oriented.</p>
<p><img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/HollowCylinderRadialFlux_qs.png\"/></p>
<p>The above figure left shows a radial flux cylinder with <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/alpha2pi.png\"/>. The figure on the right indicates the central angle <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/alpha.png\"/> in case a cylinder section shall be considered.</p>
</html>"));
      end HollowCylinderRadialFlux;

      annotation (Documentation(info="<html>
<p>
This package provides different reluctance models, based on different geometric data.
</p>
</html>"));
    end FixedShape;

    package Leakage
    "Leakage flux tubes with position-independent permeance and hence no force generation; mu_r=1"
      extends Modelica.Icons.VariantsPackage;

      model QuarterCylinder
      "Leakage flux from one edge to the opposite plane through a quarter cylinder"

        extends FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Length l=0.1
        "Axial length orthogonal to flux (=2*pi*r for cylindrical pole and r>>distance between edge and plane)"
          annotation (Dialog(group="Parameters", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/QuarterCylinder.png"));
      equation
        G_m = mu_0*0.52*l;

        annotation (Documentation(info="<html>
<p>
In
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>
the equations for determining the reluctance
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m.png\">
are summarized. As an alternative to the geometry based data a
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.LeakageWithCoefficient\">generic leakage</a> model is provided in this library.
</p></html>"));
      end QuarterCylinder;

      model QuarterHollowCylinder
      "Leakage flux in circumferential direction through a quarter hollow cylinder"

        extends FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Length l=0.1
        "Axial length orthogonal to flux (=2*pi*r for cylindrical pole and r>>r_i)"
          annotation (Dialog(group="Parameters", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/QuarterHollowCylinder.png"));
        parameter Real ratio(start=1) "Constant ratio t/r_i";

      equation
        G_m = 2*mu_0*l*Modelica.Math.log(1 + ratio)/pi;

        annotation (Documentation(info="<html>
<p>
In
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>
the equations for determining the reluctance
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m.png\">
are summarized. As an alternative to the geometry based data a
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.LeakageWithCoefficient\">generic leakage</a> model is provided in this library.
</p></html>"));
      end QuarterHollowCylinder;

      model HalfCylinder "Leakage flux through the edges of a half cylinder"

        extends FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Length l=0.1
        "Axial length orthogonal to flux (=2*pi*r for cylindrical pole and r>>distance between edges)"
          annotation (Dialog(group="Parameters", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/HalfCylinder.png"));

      equation
        G_m = mu_0*0.26*l;

        annotation (Documentation(info="<html>
<p>
In
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>
the equations for determining the reluctance
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m.png\">
are summarized. As an alternative to the geometry based data a
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.LeakageWithCoefficient\">generic leakage</a> model is provided in this library.
</p></html>"));
      end HalfCylinder;

      model HalfHollowCylinder
      "Leakage flux in circumferential direction through a half hollow cylinder"

        extends FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Length l=0.1
        "Axial length orthogonal to flux (=2*pi*r for cylindrical pole and r>>r_i)"
          annotation (Dialog(group="Parameters", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/HalfHollowCylinder.png"));
        parameter Real ratio(start=1) "Constant ratio t/r_i";

      equation
        G_m = mu_0*l*Modelica.Math.log(1 + ratio)/pi;

        annotation (Documentation(info="<html>
<p>
In
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>
the equations for determining the reluctance
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m.png\">
are summarized. As an alternative to the geometry based data a
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.LeakageWithCoefficient\">generic leakage</a> model is provided in this library.
</p></html>"));
      end HalfHollowCylinder;

      model QuarterSphere
      "Leakage flux through the corners of a quarter sphere"

        extends FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Radius r=0.005 "Radius of quarter sphere"
          annotation (Dialog(group="Parameters", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/QuarterSphere.png"));

      equation
        G_m = mu_0*0.077*2*r;

        annotation (Documentation(info="<html>
<p>
In
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>
the equations for determining the reluctance
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m.png\">
are summarized. As an alternative to the geometry based data a
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.LeakageWithCoefficient\">generic leakage</a> model is provided in this library.
</p></html>"));
      end QuarterSphere;

      model QuarterHollowSphere
      "Leakage flux through the edges of a quarter hollow sphere"

        extends FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Length t(start=0.01) "Thickness of spherical shell"
          annotation (Dialog(group="Parameters", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/QuarterHollowSphere.png"));

      equation
        G_m = mu_0*0.25*t;

        annotation (Documentation(info="<html>
<p>
In
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>
the equations for determining the reluctance
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m.png\">
are summarized. As an alternative to the geometry based data a
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.LeakageWithCoefficient\">generic leakage</a> model is provided in this library.
</p></html>"));
      end QuarterHollowSphere;

      model EighthOfSphere
      "Leakage flux through one edge and the opposite plane of an eighth of a sphere"

        extends FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Radius r=0.01 "Radius of eighth of sphere"
          annotation (Dialog(group="Parameters", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/EighthOfSphere.png"));

      equation
        G_m = mu_0*0.308*r;

        annotation (Documentation(info="<html>
<p>
In
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>
the equations for determining the reluctance
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m.png\">
are summarized. As an alternative to the geometry based data a
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.LeakageWithCoefficient\">generic leakage</a> model is provided in this library.
</p></html>"));
      end EighthOfSphere;

      model EighthOfHollowSphere
      "Leakage flux through one edge and the opposite plane of an eighth of a hollow sphere"

        extends FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Length t(start=0.01) "Thickness of spherical shell"
          annotation (Dialog(group="Parameters", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/EighthOfHollowSphere.png"));

      equation
        G_m = mu_0*0.5*t;

        annotation (Documentation(info="<html>
<p>
In
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>
the equations for determining the reluctance
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m.png\">
are summarized. As an alternative to the geometry based data a
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.LeakageWithCoefficient\">generic leakage</a> model is provided in this library.
</p></html>"));
      end EighthOfHollowSphere;

      model CoaxCylindersEndFaces
      "Leakage flux between the end planes of a inner solid cylinder and a coaxial outer hollow cylinder"

        extends FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Radius r_0=10e-3 "Radius of inner solid cylinder"
          annotation (Dialog(group="Parameters", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/CoaxCylindersEndFaces.png"));
        parameter SI.Radius r_1=17e-3 "Inner radius of outer hollow cylinder";
        parameter SI.Radius r_2=20e-3 "Outer radius of outer hollow cylinder";

        final parameter SI.Distance l_g=r_1 - r_0
        "Radial gap length between both cylinders";
        final parameter SI.Length t=r_2 - r_1
        "Radial thickness of outer hollow cylinder";

      equation
        // [Ro41], p. 139, Eq. (22)
        G_m = if t <= r_0 then 2*mu_0*(r_0 + l_g/2)*Modelica.Math.log(1 + 2*t/
          l_g) else 2*mu_0*(r_0 + l_g/2)*Modelica.Math.log(1 + 2*r_0/l_g);

        annotation (Documentation(info="<html>
<p>
In
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>
the equations for determining the reluctance
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m.png\">
are summarized. As an alternative to the geometry based data a
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.LeakageWithCoefficient\">generic leakage</a> model is provided in this library.
</p></html>"));
      end CoaxCylindersEndFaces;

      annotation (Documentation(info="<html>
<p>
The permeances of all elements of this package are calculated from their geometry <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>. These flux tube elements are intended for modelling of leakage fields through vacuum, air and other media with a relative permeability
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/mu_r-1.png\">.
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.LeakageWithCoefficient\">Basic.LeakageWithCoefficient</a> accounts for leakage not by the geometry of flux tubes, but by a coupling coefficient <code>c_usefulFlux</code>.
</p></html>"));
    end Leakage;
    annotation (Documentation(info="<html>
<p>This packages contains components which are parameterized based on geometric data.</p>
</html>"));
  end Shapes;

  package Interfaces "Interfaces of magnetic network components"
    extends Modelica.Icons.InterfacesPackage;

    connector MagneticPort "Quasi-static magnetic port"
      Modelica.SIunits.ComplexMagneticPotential V_m
      "Complex magnetic potential at the port";
      flow Modelica.SIunits.ComplexMagneticFlux Phi
      "Complex magnetic flux flowing into the port";
      annotation (Documentation(info="<html>
<p>Base definition of complex quasi-static magnetic port.
The potential variable is the complex magnetic potential difference <code>V_m</code> and the flow variable
is the complex magnetic flux <code>Phi</code>.</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Interfaces.MagneticPort\">Magnetic.FluxTubes.Interfaces.MagneticPort</a>
</p>

</html>"));
    end MagneticPort;

    connector PositiveMagneticPort "Positive quasi-static magnetic port"
      extends Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.MagneticPort;
      Modelica.Electrical.QuasiStationary.Types.Reference reference "Reference";
      annotation (
        defaultComponentName="port_p",
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                graphics={Text(
                  extent={{-100,100},{100,60}},
                  lineColor={255,170,85},
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid,
                  textString="%name"), Rectangle(
              extent={{-40,40},{40,-40}},
              lineColor={255,170,85},
              fillColor={255,170,85},
              fillPattern=FillPattern.Solid)}),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}),
             graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={255,170,85},
              fillColor={255,170,85},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
The positive magnetic port is based on the
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.MagneticPort\">MagneticPort</a>.
Additionally the reference angle is specified in the connector. The time derivative of the
reference angle is the actual angular frequency of the quasi-static magnetic potential and flux.
The symbol is also designed such way to look different than the
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.MagneticPort\">MagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Interfaces.PositiveMagneticPort\">Magnetic.FluxTubes.Interfaces.PositiveMagneticPort</a>
</p>
</html>"));
    end PositiveMagneticPort;

    connector NegativeMagneticPort "Negative quasi-static magnetic port"
      extends Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.MagneticPort;
      Modelica.Electrical.QuasiStationary.Types.Reference reference "Reference";
      annotation (
        defaultComponentName="port_n",
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),
                graphics={Text(
                  extent={{-100,100},{100,60}},
                  lineColor={255,170,85},
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid,
                  textString="%name"), Rectangle(
              extent={{-40,40},{40,-40}},
              lineColor={255,170,85},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}),
             graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={255,170,85},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
The negative magnetic port is based on the
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.MagneticPort\">MagneticPort</a>.
Additionally the reference angle is specified in the connector. The time derivative of the
reference angle is the actual angular frequency of the quasi-static magnetic potential and flux.
The symbol is also designed such way to look different than the
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.MagneticPort\">MagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Interfaces.NegativeMagneticPort\">Magnetic.FluxTubes.Interfaces.NegativeMagneticPort</a>
</p>
</html>"));
    end NegativeMagneticPort;

    partial model PartialTwoPortsElementary
    "Partial component with two magnetic ports p and n for textual programming"

      FluxTubes.Interfaces.PositiveMagneticPort port_p "Positive quasi-static magnetic port" annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      FluxTubes.Interfaces.NegativeMagneticPort port_n "Negative quasi-static magnetic port" annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.SIunits.ComplexMagneticPotentialDifference V_m
      "Magnetic potential difference of both ports";
      Modelica.SIunits.MagneticPotentialDifference abs_V_m = Modelica.ComplexMath.'abs'(V_m)
      "Magnitude of complex magnetic potential difference";
      Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
      "Argument of complex magnetic potential difference";
      Modelica.SIunits.ComplexMagneticFlux Phi(re(start=0),im(start=0))
      "Magnetic flux from port_p to port_n";
      Modelica.SIunits.MagneticFlux abs_Phi=
          Modelica.ComplexMath.'abs'(Phi) "Magnitude of complex magnetic flux";
      Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
      "Argument of complex magnetic flux";
      Modelica.SIunits.AngularVelocity omega;
    equation
      Connections.branch(port_p.reference, port_n.reference);
      port_p.reference.gamma = port_n.reference.gamma;
      omega = der(port_p.reference.gamma);

      V_m = port_p.V_m - port_n.V_m;
      Phi = port_p.Phi;

      annotation (Documentation(info="<html>
<p>
Partial model of a flux tube component with two magnetic ports:
the positive port connector <code>port_p</code>, and the negative port
connector <code>port_n</code>. The total magnetic potential difference
<code>V_m</code> and the flux flowing into the positive port,
<code>Phi</code> are also defined in this model.
</p></html>"));
    end PartialTwoPortsElementary;

    partial model PartialTwoPorts
    "Partial component with magnetic potential difference between two magnetic ports p and n and magnetic flux Phi from p to n"

      extends FluxTubes.Interfaces.PartialTwoPortsElementary;

    equation
      Complex(0) = port_p.Phi + port_n.Phi;

      annotation (Documentation(info="<html>
<p>
It is assumed that the magnetic flux flowing into <code>port_p</code>
is identical to the flux flowing out of <code>port_n</code>.
</p>
</html>"));
    end PartialTwoPorts;

    partial model PartialFixedShape
    "Base class for flux tubes with fixed shape during simulation; linear or non-linear material characteristics"

      extends FluxTubes.Interfaces.PartialTwoPorts;

      parameter SI.RelativePermeability mu_rConst=1
      "Constant relative permeability";

      Modelica.SIunits.Reluctance R_m "Magnetic reluctance";
      Modelica.SIunits.Permeance G_m "Magnetic permeance";
      Modelica.SIunits.ComplexMagneticFluxDensity B
      "Magnetic flux density (normal component)";
      Modelica.SIunits.MagneticFluxDensity abs_B = Modelica.ComplexMath.'abs'(B)
      "Magnitude of complex magnetic flux density";
      Modelica.SIunits.Angle arg_B=Modelica.ComplexMath.arg(B)
      "Argument of complex magnetic flux density";
      SI.CrossSection A "Area of cross section penetrated by magnetic flux";
      Modelica.SIunits.ComplexMagneticFieldStrength H
      "Magnetic field strength (normal component)";
      Modelica.SIunits.MagneticFieldStrength abs_H = Modelica.ComplexMath.'abs'(H)
      "Magnitude of complex magnetic field strength";
      Modelica.SIunits.Angle arg_H=Modelica.ComplexMath.arg(H)
      "Argument of complex magnetic field strength";

      SI.RelativePermeability mu_r "Relative magnetic permeability";

    equation
      mu_r = mu_rConst;
      R_m = 1/G_m;
      V_m = Phi*R_m;
      B = Phi/A;
      H = B/(mu_0*mu_r);

      annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={255,170,85},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
          Line(points={{-70,0},{-90,0}}, color={255,170,85}),
          Line(points={{70,0},{90,0}}, color={255,170,85}),
          Text(
            extent={{-150,50},{150,90}},
            textString="%name",
            lineColor={0,0,255})}), Documentation(info="<html>
<p>
Please refer to the description of  the subpackage
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape\">Shapes.FixedShape</a>
for utilisation of this partial model.
</p>
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false)));
    end PartialFixedShape;

    partial model PartialLeakage
    "Base class for leakage flux tubes with position-independent permeance and hence no force generation; mu_r=1"

      extends FluxTubes.Interfaces.PartialTwoPorts;

      SI.Reluctance R_m "Magnetic reluctance";
      SI.Permeance G_m "Magnetic permeance";

    equation
      V_m = Phi*R_m;
      R_m = 1/G_m;

      annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={255,170,85},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
          Line(points={{-70,0},{-90,0}}, color={255,170,85}),
          Line(points={{70,0},{90,0}}, color={255,170,85}),
          Text(
            extent={{-150,50},{150,90}},
            textString="%name",
            lineColor={0,0,255})}), Documentation(info="<html>
<p>
Please refer to the description of the subpackage
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage\">Shapes.Leakage</a>
for utilisation of this partial model.
</p>
</html>"));
    end PartialLeakage;

    partial model AbsoluteSensor "Partial potential sensor"
      extends Modelica.Icons.RotationalSensor;
      Modelica.SIunits.AngularVelocity omega;
      FluxTubes.Interfaces.PositiveMagneticPort port "Quasi-static magnetic port" annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    equation
      omega = der(port.reference.gamma);
      port.Phi = Complex(0);
      annotation (Icon(graphics={
            Line(points={{-70,0},{-90,0}}, color={255,170,85}),
            Text(
              extent={{-150,120},{150,80}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={170,85,255},
              fillPattern=FillPattern.Solid,
              textString="%name")}), Documentation(info="<html>
<p>
The absolute sensor partial model provides a single
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>
to measure the complex magnetic potential. Additionally this model contains a base icon and a definition
of the angular frequency.
</p></html>"));
    end AbsoluteSensor;

    partial model RelativeSensor "Partial magnetic voltage or flux sensor"
      extends Modelica.Icons.RotationalSensor;
      extends FluxTubes.Interfaces.PartialTwoPorts;
      Modelica.ComplexBlocks.Interfaces.ComplexOutput y annotation (Placement(
            transformation(
            origin={0,-110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}),
                       graphics={
            Line(points={{-70,0},{-90,0}}, color={255,170,85}),
            Line(points={{70,0},{90,0}}, color={255,170,85}),
            Text(
              extent={{-150,120},{150,80}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={170,85,255},
              fillPattern=FillPattern.Solid,
              textString="%name"),
            Line(
              points={{0,-70},{0,-100}})}),
          Documentation(info="<html>
<p>
The relative sensor partial model relies on the
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.PartialTwoPorts\">PartialTwoPorts</a>
to measure the complex magnetic voltage, flux or power. Additionally this model contains a base icon and a definition
of the angular frequency.
</p></html>"));
    end RelativeSensor;

    partial model Source "Partial magnetic voltage or flux source"
      FluxTubes.Interfaces.PositiveMagneticPort port_p "Positive magnetic port" annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      FluxTubes.Interfaces.NegativeMagneticPort port_n "Negative magnetic port" annotation (Placement(transformation(extent={{90,-10},{110,10}})));

      Modelica.SIunits.AngularVelocity omega;
      Modelica.SIunits.Angle gamma(start=0) = port_p.reference.gamma;
    equation
      Connections.root(port_p.reference);
      Connections.branch(port_p.reference, port_n.reference);
      port_p.reference.gamma = port_n.reference.gamma;
      omega = der(port_p.reference.gamma);

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                       graphics={
            Text(
              extent={{150,60},{-150,100}},
              textString="%name",
              lineColor={0,0,255}),
            Line(
              points={{-90,0},{-50,0}},
              color={255,170,85}),
            Line(
              points={{50,0},{90,0}},
              color={255,170,85}),
            Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={255,170,85},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),            Documentation(info="<html>
<p>
The source model provides a positive and negative magnetic port. Additionally this model contains a base icon
and a definition of the angular frequency.
</p></html>"));
    end Source;
    annotation (Documentation(info="<html>
<p>
This package contains connectors for the magnetic domain and partial models for lumped magnetic network components.
</p>

</html>"));
  end Interfaces;

  package Sources
  "Sources of different complexity of magnetomotive force and magnetic flux"
    extends Modelica.Icons.SourcesPackage;

    model ConstantMagneticPotentialDifference "Constant magnetomotive force"

      extends FluxTubes.Interfaces.Source;
      parameter Modelica.SIunits.Frequency f(start=1) "Frequency of the source";
      parameter Modelica.SIunits.ComplexMagneticPotentialDifference V_m
      "Magnetic potential difference";
      Modelica.SIunits.ComplexMagneticFlux Phi(re(start=0),im(start=0))
      "Magnetic flux from port_p to port_n";

    equation
      omega = 2*Modelica.Constants.pi*f;
      V_m = port_p.V_m - port_n.V_m;
      Complex(0) = port_p.Phi + port_n.Phi;
      Phi = port_p.Phi;

      annotation (
        defaultComponentName="magVoltageSource",
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{90,0},{50,0}}, color={255,170,85}),
          Line(points={{-50,0},{-90,0}}, color={255,170,85}),
          Line(points={{-50,0},{50,0}}, color={255,170,85}),
            Line(points={{-80,20},{-60,20}}, color={255,170,85}),
            Line(points={{-70,30},{-70,10}}, color={255,170,85}),
            Line(points={{60,20},{80,20}}, color={255,170,85})}),
        Documentation(info="<html>
<p>
This source provides a constant quasi static magnetic potential difference <code>V_m</code> (or magnetomotive force, mmf),
at fixed frequency, <code>f</code>.
</p>
</html>"));
    end ConstantMagneticPotentialDifference;

    model SignalMagneticPotentialDifference
    "Signal-controlled magnetomotive force"

      extends FluxTubes.Interfaces.Source;
      Modelica.Blocks.Interfaces.RealInput f annotation (Placement(
            transformation(
            origin={60,120},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={60,120})));
      Modelica.ComplexBlocks.Interfaces.ComplexInput V_m annotation (Placement(
            transformation(
            origin={-60,120},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={-60,120})));
      Modelica.SIunits.ComplexMagneticFlux Phi(re(start=0),im(start=0))
      "Magnetic flux from port_p to port_n";
    equation
      omega = 2*Modelica.Constants.pi*f;
      V_m = port_p.V_m - port_n.V_m;
      Complex(0) = port_p.Phi + port_n.Phi;
      Phi = port_p.Phi;

      annotation (
        defaultComponentName="magVoltageSource",
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-90,0},{-50,0}},  color={255,170,85}),
          Line(points={{50,0},{90,0}},  color={255,170,85}),
          Ellipse(
            extent={{-50,-50},{50,50}},
            lineColor={255,170,85},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-50,0},{50,0}}, color={255,170,85}),
            Line(points={{-80,20},{-60,20}}, color={255,170,85}),
            Line(points={{-70,30},{-70,10}}, color={255,170,85}),
            Line(points={{60,20},{80,20}}, color={255,170,85})}),
        Documentation(info="<html>
<p>
This source provides a quasi static magnetic potential difference <code>V_m</code> (or magnetomotive force, mmf)
with signal inputs for:
</p>
<ul>
<li>Complex magnetic potential difference, <code>V_m</code></li>
<li>Frequency <code>f</code></li>
</ul>
</html>"));
    end SignalMagneticPotentialDifference;

    model ConstantMagneticFlux "Source of constant magnetic flux"

      extends FluxTubes.Interfaces.Source;
      parameter Modelica.SIunits.Frequency f(start=1) "Frequency of the source";
      Modelica.SIunits.ComplexMagneticPotentialDifference V_m
      "Magnetic potential difference between both ports";
      parameter Modelica.SIunits.ComplexMagneticFlux Phi=Complex(1,0)
      "Magnetic flux";

    equation
      omega = 2*Modelica.Constants.pi*f;
      V_m = port_p.V_m - port_n.V_m;
      Complex(0) = port_p.Phi + port_n.Phi;
      Phi = port_p.Phi;
      annotation (
        defaultComponentName="magFluxSource",
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Polygon(
            points={{80,0},{60,6},{60,-6},{80,0}},
            lineColor={255,170,85},
            fillColor={255,170,85},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{-50,0}},  color={255,170,85}),
          Line(points={{50,0},{90,0}},  color={255,170,85}),
          Ellipse(
            extent={{-50,-50},{50,50}},
            lineColor={255,170,85},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{0,50},{0,-50}}, color={255,170,85})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}})),
        Documentation(info="<html>
<p>
This source provides a constant quasi static magnetic flux <code>Phi</code> at fixed frequency, <code>f</code>.
</p>
</html>"));
    end ConstantMagneticFlux;

    model SignalMagneticFlux "Signal-controlled magnetic flux source"

      extends FluxTubes.Interfaces.Source;
      Modelica.Blocks.Interfaces.RealInput f annotation (Placement(
            transformation(
            origin={60,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.SIunits.ComplexMagneticPotentialDifference V_m
      "Magnetic potential difference between both ports";
      Modelica.ComplexBlocks.Interfaces.ComplexInput Phi annotation (Placement(
            transformation(
            origin={-60,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));

    equation
      omega = 2*Modelica.Constants.pi*f;
      V_m = port_p.V_m - port_n.V_m;
      Complex(0) = port_p.Phi + port_n.Phi;
      Phi = port_p.Phi;
      annotation (
        defaultComponentName="magFluxSource",
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Polygon(
            points={{80,0},{60,6},{60,-6},{80,0}},
            lineColor={255,170,85},
            fillColor={255,170,85},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{-50,0}},  color={255,170,85}),
          Line(points={{50,0},{90,0}},  color={255,170,85}),
          Ellipse(
            extent={{-50,-50},{50,50}},
            lineColor={255,170,85},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{0,50},{0,-50}}, color={255,170,85})}),
        Documentation(info="<html>
<p>
This source provides a quasi static magnetic flux with inputs for:
</p>
<ul>
<li>Complex magnetic flux, <code>Phi</code></li>
<li>Frequency <code>f</code></li>
</ul>
</html>"));
    end SignalMagneticFlux;
    annotation (Documentation(info="<html>
<p>
This package contains sources of a magnetic potential difference or a magnetic flux:
</p>
</html>"));
  end Sources;

  package Sensors "Sensors to measure variables in magnetic networks"
    extends Modelica.Icons.SensorsPackage;

    model ReferenceSensor "Sensor of reference angle gamma"
      extends FluxTubes.Interfaces.AbsoluteSensor;
      Modelica.Blocks.Interfaces.RealOutput y "Reference angle" annotation (
          Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      y = port.reference.gamma;
      annotation (Icon(graphics={Text(
              extent={{60,-60},{-60,-30}},
              fillPattern=FillPattern.Solid,
              textString="ref")}), Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>This sensor determines the reference angle of the connected quasi static magnetic system.
The integral of the angular frequency of the quasi static magnetic system is equal to the reference angle.
</p>
</html>"));
    end ReferenceSensor;

    model FrequencySensor "Frequency sensor"
      extends FluxTubes.Interfaces.AbsoluteSensor;
      import Modelica.Constants.pi;
      Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
              extent={{100,-10},{120,10}})));
    equation
      2*pi*y = omega;
      annotation (Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              textString="f")}), Documentation(info="<html>
<p>
This sensor can be used to measure the frequency of the reference system.
The integral of the angular frequency of the quasi static magnetic system is equal to the reference angle.
</p>
</html>"));
    end FrequencySensor;

    model MagneticPotentialSensor "Potential sensor"
      extends FluxTubes.Interfaces.AbsoluteSensor;
      Modelica.ComplexBlocks.Interfaces.ComplexOutput y annotation (Placement(
            transformation(extent={{100,-10},{120,10}})));
    equation
      y = port.V_m;
      annotation (defaultComponentName="magPotentialSensor",
      Documentation(info="<html>
<p>
This sensor can be used to measure the complex magnetic potential <code>V_m</code> in a quasi static magnetic system.
</p>
</html>"));
    end MagneticPotentialSensor;

    model MagneticPotentialDifferenceSensor
    "Sensor to measure magnetic potential difference"
      extends FluxTubes.Interfaces.RelativeSensor;

    equation
      Phi = Complex(0);
      y = V_m;

      annotation (defaultComponentName="magVoltageSensor",
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{-52,1},{48,-57}},
              textString="V_m"),
            Line(points={{-70,0},{-90,0}}, color={255,170,85}),
            Line(points={{70,0},{90,0}}, color={255,170,85}),
            Line(points={{0,-90},{0,-70}})}),
                                      Diagram(coordinateSystem(
            preserveAspectRatio=false)),
        Documentation(info="<html>
<p>
This sensor can be used to measure the complex magnetic potential difference <code>V_m</code>
in a quasi static magnetic system.
</p>
</html>"));
    end MagneticPotentialDifferenceSensor;

    model MagneticFluxSensor "Sensor to measure magnetic flux"
      extends FluxTubes.Interfaces.RelativeSensor;

    equation
      V_m = Complex(0);
      y = Phi;

      annotation (defaultComponentName="magFluxSensor",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Line(points={{0,-100},{0,-70}}),Line(points={{-70,0},{-90,0}}),Line(
              points={{70,0},{90,0}}),Text(extent={{-29,-11},{30,
              -70}}, textString="Phi"),Line(points={{0,-90},{0,-70}})}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>
This sensor can be used to measure the complex magnetic flux <code>Phi</code> of a quasi static magnetic system.
</p>
</html>"));
    end MagneticFluxSensor;

    package Transient "Transient fundamental wave sensors"
      extends Modelica.Icons.SensorsPackage;
      model FundamentalWavePermabilitySensor
      "Sensor of fundamental wave permeability"
        extends Modelica.Icons.RotationalSensor;
        parameter Modelica.SIunits.Frequency f "Fundamental wave frequency";
        parameter Modelica.SIunits.Area A "Area of cross section";
        parameter Modelica.SIunits.Length l "Length";

        Modelica.Magnetic.FluxTubes.Interfaces.PositiveMagneticPort
          fluxP "Positive port of flux path"
                annotation (Placement(transformation(
                extent={{-110,-10},{-90,10}}),
              iconTransformation(extent={{-110,-10},{-90,10}})));
        Modelica.Magnetic.FluxTubes.Interfaces.NegativeMagneticPort
          fluxN "Negative port of flux path"
                annotation (Placement(transformation(
                extent={{90,-10},{110,10}}),
              iconTransformation(extent={{90,-10},{110,10}})));
        Modelica.Magnetic.FluxTubes.Interfaces.PositiveMagneticPort
          potentialP "Positive port of magnetic potential difference path"
                     annotation (Placement(
              transformation(extent={{-10,90},{10,110}}),
              iconTransformation(extent={{-10,90},{10,110}})));
        Modelica.Magnetic.FluxTubes.Interfaces.NegativeMagneticPort
          potentialN "Negative port of magnetic potential difference path"
                     annotation (Placement(
              transformation(extent={{-10,-110},{10,-90}}),
              iconTransformation(extent={{-10,-110},{10,-90}})));
        Modelica.Magnetic.FluxTubes.Sensors.MagneticPotentialDifferenceSensor
          magneticPotentialDifferenceSensor annotation (
           Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={70,30})));
        Modelica.Magnetic.FluxTubes.Sensors.MagneticFluxSensor
          magneticFluxSensor annotation (Placement(
              transformation(extent={{40,-70},{60,-90}})));
        Modelica.Blocks.Math.Harmonic harmonicPotential(
          final f=f,
          final k=1,
          final x0Cos=0,
          final x0Sin=0) "Fundamental wave of magnetic potential difference"
                         annotation (Placement(
              transformation(extent={{40,20},{20,40}})));
        Modelica.Blocks.Math.Harmonic harmonicFlux(
          final f=f,
          final k=1,
          final x0Cos=0,
          final x0Sin=0) "Fundamental wave of magnetic flux"
                         annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              origin={30,-10})));
        Modelica.Blocks.Interfaces.RealOutput mu "Absolute permeability"
                         annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-40,-110})));
        Modelica.Blocks.Interfaces.RealOutput mur "Relative permeability"
                                  annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-80,-110})));
        Permeability permeability(final A=A, final l=l)
        "Determines relative and absolute permeability"
                                  annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-20,0})));
      equation
        connect(magneticPotentialDifferenceSensor.port_n,
          potentialN) annotation (Line(
            points={{70,20},{70,-100},{0,-100}},
            color={255,170,85}));
        connect(magneticPotentialDifferenceSensor.port_p,
          potentialP) annotation (Line(
            points={{70,40},{70,100},{0,100}},
            color={255,170,85}));
        connect(magneticFluxSensor.port_p, fluxP)
          annotation (Line(
            points={{40,-80},{-100,-80},{-100,0}},
            color={255,170,85}));
        connect(magneticFluxSensor.port_n, fluxN)
          annotation (Line(
            points={{60,-80},{100,-80},{100,0}},
            color={255,170,85}));
        connect(harmonicFlux.u, magneticFluxSensor.Phi)
          annotation (Line(
            points={{42,-10},{50,-10},{50,-70}},
            color={0,0,127}));
        connect(magneticPotentialDifferenceSensor.V_m,
          harmonicPotential.u) annotation (Line(
            points={{60,30},{42,30}},
            color={0,0,127}));
        connect(permeability.V_m, harmonicPotential.y_rms)
          annotation (Line(
            points={{-8,6},{0,6},{0,36},{19,36}},
            color={0,0,127}));
        connect(permeability.Phi, harmonicFlux.y_rms)
          annotation (Line(
            points={{-8,-6},{0,-6},{0,-4},{19,-4}},
            color={0,0,127}));
        connect(permeability.mur, mur) annotation (Line(
            points={{-31,6},{-80,6},{-80,-110}},
            color={0,0,127}));
        connect(permeability.mu, mu) annotation (Line(
            points={{-31,-6},{-40,-6},{-40,-110}},
            color={0,0,127}));
        annotation (Icon(coordinateSystem(
                preserveAspectRatio=false), graphics={
                                        Text(extent={{-29,-11},{30,-70}},
                textString="mu")}), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>
This sensor is used to determined the effective fundamental wave permeability of a saturated lumped circuit reluctance. For this purpose the sensor is placed such way that the magnetic flux and the magnetic potential difference of the investigated reluctance are sensed. The area of cross section and the effective length of the investigated magnetic path have to be provided as parameters.
</p>
<p>See example
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Examples.NonLinearInductor\">NonLinearInductor</a>.</p>
</html>"));
      end FundamentalWavePermabilitySensor;

      model Permeability
      "Determines permeability from flux and magnetic potential difference"

        parameter Modelica.SIunits.Area A
        "Area of cross section penetrated by flux";
        parameter Modelica.SIunits.Length l
        "Length associated with magnetic potential difference";

        Modelica.Blocks.Interfaces.RealInput Phi "Magnetic flux"
                          annotation (Placement(
              transformation(extent={{-140,40},{-100,80}})));
        Modelica.Blocks.Interfaces.RealInput V_m
        "Magnetic potential difference"   annotation (
            Placement(transformation(extent={{-140,-80},
                  {-100,-40}})));
        Modelica.Blocks.Interfaces.RealOutput mu "Absolute permeability"
                         annotation (Placement(
              transformation(extent={{100,50},{120,70}})));
        Modelica.Blocks.Interfaces.RealOutput mur "Relative Permeability"
                                  annotation (Placement(
              transformation(extent={{100,-70},{120,-50}})));

      equation
        if noEvent(abs(V_m) < Modelica.Constants.eps) then
           mu = 0;
           mur = 0;
        else
           mu =Phi /V_m*l/A;
           mur = mu/Modelica.Constants.mue_0;
        end if;

        annotation (Diagram(coordinateSystem(
                preserveAspectRatio=false)), Icon(
              coordinateSystem(preserveAspectRatio=false),
              graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,127},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid), Text(
                extent={{60,-60},{-60,60}},
                fillColor={255,170,85},
                fillPattern=FillPattern.Solid,
                textString="mu")}),
        Documentation(info="<html>
<p>This model determines the absolute and relative permeability from two real inputs:</p>
<ul>
<li>RMS magnetic potential difference,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/realV_m.png\" alt=\"V_m\"></li>
<li>RMS magnetic flux,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/realPhi.png\" alt=\"Phi\"></li>
</ul>
<p>In order to calculate the permeabilities, the area of cross section,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/A.png\" alt=\"l\">,
and the geometric length,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/l.png\" alt=\"l\">,
of the flux path have to be take into account</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/permeabilities.png\" alt=\"Permeabilities\">
</dd></dl>
<p>In case that the magnetic potential difference is close to zero, permeabilities yield:</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/permeabilities-0.png\" alt=\"Permeabilities=0\">
</dd></dl>
</html>"));
      end Permeability;
    annotation (Documentation(info="<html>
<p>This package contains sensors to be used with transient flux tubes models in order to provide information
for quasi static parameters.</p>
</html>"));
    end Transient;
    annotation (Documentation(info="<html>
<p>
For analysis of magnetic networks, only magnetic potential differences and magnetic flux are variables of interest. For that reason, a magnetic potential sensor is not provided.
</p>
</html>"));
  end Sensors;
  annotation (Documentation(info="<html>
<p>
This library is intended to provide models for the investigation of
quasi static electromagnetic devices with lumped magnetic networks.
</p>
</html>", revisions="<html></html>"),
           Icon(coordinateSystem(preserveAspectRatio=false), graphics={
    Polygon(
        origin={-3.75,0.0},
        fillColor={255,170,85},
        fillPattern=FillPattern.Solid,
        points={{33.75,50.0},{-46.25,50.0},{-46.25,-50.0},{33.75,-50.0},{33.75,
            -30.0},{-21.25,-30.0},{-21.25,30.0},{33.75,30.0}}),
    Ellipse(
      origin={10.4708,41.6771},
      extent={{-86.0,-24.0},{-78.0,-16.0}}),
    Line(
      origin={10.4708,41.6771},
      points={{-64.0,-20.0},{-78.0,-20.0}}),
    Line(
      origin={10.4708,41.6771},
      points={{-64.1812,-31.6229},{-32.0,-40.0}}),
    Line(
      origin={10.4708,41.6771},
      points={{-64.0,-20.0},{-32.0,-28.0}}),
    Ellipse(
      origin={10.4708,41.6771},
      extent={{-86.0,-60.0},{-78.0,-52.0}}),
    Line(
      origin={10.4708,41.6771},
      points={{-64.0,-56.0},{-78.0,-56.0}}),
    Line(
      origin={10.4708,41.6771},
      points={{-64.0,-44.0},{-32.0,-52.0}}),
    Line(
      origin={10.4708,41.6771},
      points={{-64.0,-56.0},{-32.0,-64.0}}),
    Rectangle(
        origin={62.5,0.0},
        fillColor={255,170,85},
        fillPattern=FillPattern.Solid,
        extent={{-12.5,-50.0},{12.5,50.0}}),
      Line(
        points={{-86,4},{-84,8},{-80,10},{-76,8},{-72,2},{-68,0},{-64,2},{-62,6}},
        color={85,170,255})}));
end FluxTubes;
