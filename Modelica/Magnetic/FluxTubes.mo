within Modelica.Magnetic;
package FluxTubes
  "Library for modelling of electromagnetic devices with lumped magnetic networks"

  import SI = Modelica.SIunits;
  import Modelica.Constants.pi;
  import mu_0 = Modelica.Constants.mue_0;

  extends Modelica.Icons.Package;

package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;

  class FluxTubeConcept "Flux tube concept"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>Overview of the Conept of Magnetic Flux Tubes</font></h3>
<p>
Following below, the concept of magnetic flux tubes is outlined in short. For a detailed description of flux tube elements, please have a look at the listed literature. Magnetic flux tubes enable for modeling of magnetic fields with lumped networks. The figure below and the following equations illustrate the transition from the original magnetic field quantities described by <i>Maxwell</i>'s equations to network elements with a flow variable and an across variable:
</p>

<IMG src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/magnetic_flux_tube_schematic.png\" ALT=\"Magnetic flux tube\">

<p>
For a region with an approximately homogeneous distribution of the magnetic field strength <b>H</b> and the magnetic flux density <b>B</b> through cross sectional area <i>A</i> at each length coordinate <i>s</i>  (<i>A</i> perpendicular to the direction of the magnetic field lines), a magnetic reluctance <i>R<sub>m</sub></i> can be defined:</p>

<IMG src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/eq_transition_reluctance_flowAcross_IntegralQuantities.png\" ALT=\"Transition from field quantities to flow- and across variables\">

<p>
With the definition of the magnetic potential difference <i>V<sub>m</sub></i> as an across variable and the magnetic flux <i>&Phi;</i> as flow variable, a reluctance element <i>R<sub>m</sub></i> can be defined similar to resistive network elements in other physical domains. Using <i>Maxwell</i>'s constitutive equation
</p>

<IMG src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/eq_MaxwellConstitutive.png\" ALT=\"Maxwell's constitutive equation\">

<p>the general formula for the calculation of a magnetic reluctance <i>R<sub>m</sub></i> from its geometric and material properties is:</p>

<IMG src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/eq_reluctance_general.png\" ALT=\"General formula for calculation of a magnetic reluctance\">

<p>
For a prismatic or cylindrical volume of length <i>l</i> and cross sectional area <i>A</i> with the magnetic flux entering and leaving the region through its end planes, the above equation simplifies to:</p>

<IMG src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/eq_reluctance_prismatic.png\" ALT=\"Magnetic reluctance of a prismatic or cylindrical volume\">

<p>
Similar equations can be derived for other geometries. In cases where a direct integration is not possible, the reluctance can be calclulated on base of average length, average cross sectional area and volume <i>V</i> respectively:
</p>

<IMG src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/eq_reluctanceFromAverageGeometry.png\" ALT=\"Reluctance calculation from average geometric quantities\">

<p>
Network elements for sources of a magnetic potential difference or magnetomotive force, i.e., coils or permanent magnets can be formulated as well. The resulting magnetic network models of actuators reflect the main dimensions of these devices as well as the normally nonlinear characteristics of their magnetically active materials.
</p>

</html>
"));
  end FluxTubeConcept;

  class ReluctanceForceCalculation "Reluctance forces"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>Calculation of reluctance forces from lumped magnetic network models</font></h3>

<p>
Generally, the thrust <i>F</i> developed by a translatory electro-magneto-mechanical actuator (similar for the rotational case with torque and angular position) is equal to the change of magnetic co-energy <i>W<sub>m</sub><sup>*</sup></i> with armature position <i>x</i> according to

<IMG src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/ReluctanceForceCalculation/eq_CoEnergy_general.png\" ALT=\"Equation for force calculation from change of magnetic co-energy with armature position\">

(<i>&Psi;</i> flux linkage, <i>i</i> actuator current). In lumped magnetic network models, the above equation simplifies to

<IMG src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/ReluctanceForceCalculation/eq_forceFromPermeance_network.png\" ALT=\"Equation for force calculation in lumped magnetic network models\">

<p>
where <i>n<sub>linear</sub></i> is the number of flux tube elements with constant relative permeability that change its permeance <i>G<sub>m i</sub></i> with armature position (index <i>i</i>), <i>V<sub>m i</sub></i> the magnetic voltage across each respective flux tube and <i>dG<sub>m i</sub>/dx</i> the derivative of the respective permeances with respect to armature position. Transition from the general formula based on magnetic co-energy to the latter one is outlined in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ka08]</a> for the reciprocal of the permeance, i.e., for the magnetic reluctance <i>R<sub>m</sub></i>. Note that
</p>

<IMG src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/ReluctanceForceCalculation/eq_transition_forceReluctancePermeance.png\" ALT=\"Transition from force calculation based on reluctance to calculation based on permeance\">

<p>with <i>&Phi;<sub>i</sub></i> being the magnetic flux through each respective flux tube element.</p>

<p>
Flux tube elements with <i>non-linear</i> material characteristics <i>&mu;<sub>r</sub></i>(<i>B</i>) in magnetic network models do not restrict the usability of the above equation. However, it is required that these nonlinear flux tube elements do not change its shape with armature motion (e.g., portion of a solenoid plunger where the magnetic flux passes through in axial direction). This limitation is not a strong one, since the permeance of nonlinear, but highly permeable ferromagnetic flux tube elements and its change with armature position compared to that of air gap flux tubes can be neglected in most cases. Because of this constraint, the dimensions of possibly nonlinear flux tube elements in sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">Shapes.FixedShape</a> are fixed, whereas the dimension in direction of motion of the linear flux tube elements in sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Shapes.Force</a> can vary during simulation. For the flux tubes defined in this package with their rather simple shapes, the derivative <i>dG<sub>m</sub>/dx</i> is given analytically. For more complex shapes and variations of dimensions with armature motion, it must be provided analytically during model development, preferably by extending the partial model <a href=\"modelica://Modelica.Magnetic.FluxTubes.Interfaces.PartialForce\">Interfaces.PartialForce</a>.
</p>

<p>
The sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Shapes.Leakage</a> contains flux tube shapes typical for leakage flux around prismatic or cylindrical poles. Since the permeance of these flux tubes does not change with armature position, they do not contribute to a reluctance actuator's thrust.
</p>

</html>
"));
  end ReluctanceForceCalculation;

  class Literature "Literature"
    extends Modelica.Icons.References;

    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>Literature</font></h3>
<ul>
<li>
Usage of the Modelica Magnetic library is described in:
<dl>
<dt>[B&ouml;08] B&ouml;drich, T.:</dt>
<dd> <b>Electromagnetic Actuator Modelling with the Extended Modelica Magnetic Library</b>.
     Modelica 2008 Conference, Bielefeld, Germany,
     pp. 221-227, March 3-4, 2008.
     Download from:
     <a href=\"http://www.modelica.org/events/modelica2008/Proceedings/sessions/session2d2.pdf\">http://www.modelica.org/events/modelica2008/Proceedings/sessions/session2d2.pdf</a>
     </dd>
</dl>
</li>
<li>
The method of magnetic flux tubes as well as derivation of the permeance of many flux tube shapes is explained in detail in:
<dl>
<dt>[Ro41] Roters, H.:</dt>
<dd> <b>Electromagnetic Devices</b>.
New York: John Wiley &amp; Sons 1941 (8th Printing 1961)
</dd>
</dl>
</li>
<li> Structure, properties, applications and design of electromagnetic (reluctance type) actuators are thoroughly described in:
<dl>
<dt>[Ka08] Kallenbach, E.; Eick, R.; Quendt, P.; Str&ouml;hla, T.; Feindt, K.; Kallenbach, M.:</dt>
<dd><b>Elektromagnete: Grundlagen, Berechnung, Entwurf und Anwendung</b>.
3rd ed., Wiesbaden: Vieweg Teubner 2008 (in German)
<br>&nbsp;</dd>
<dt>[Ro00] Roschke, T.:</dt
<dd><b>Entwurf geregelter elektromagnetischer Antriebe f&uuml;r Luftsch&uuml;tze</b>.
    Fortschritt-Berichte VDI, Reihe 21, Nr. 293, D&uuml;sseldorf: VDI-Verlag 2000 (in German)</dd>
</dl>
</li>
<li>
Application of the method of magnetic flux tubes to the design of rotational electrical machines is explained for example in:
<dl>
<dt>[HM94] Hendershot, J.R. Jr.; Miller, T.J.E.:</dt>
<dd> <b>Design of Brushless Permanent-Magnet Motors</b>.
Magna Physics Publishing and Oxford University Press 1994
</dd>
</dl>
</li>

</ul>

</html>
"));
  end Literature;

  class Contact "Contact"
    extends Modelica.Icons.Contact;

    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>Contact</font></h3>

<dl>
<dt>
<b>Main Author:</b></dt>
<br>
<dd>
    <a href=\"http://www.ifte.de/mitarbeiter/boedrich.html\">Thomas B&ouml;drich</a><br>
    Dresden University of Technology<br>
    Institute of Electromechanical and Electronic Design<br>
    01062 Dresden, Germany<br>
    Phone: +49 - 351 - 463 36296<br>
    Fax: +49 - 351 - 463 37183<br>
    email: <A HREF=\"mailto:Thomas.Boedrich@mailbox.tu-dresden.de\">Thomas.Boedrich@mailbox.tu-dresden.de</A><br></dd>
</dl>
<br>
<p><b>Acknowledgements:</b></p>
<ul>

<li>
The magnetisation characteristics of the included soft magnetic materials were compiled and measured respectively by Thomas Roschke, now with Johnson Electric. Provision of this data is highly appreciated. He also formulated the approximation function used for description of the magnetisation characteristics of these materials.
</li>

<li>
Andr&eacute; Klick of then Dresden University of Technology, Dresden, Germany gave valuable support on the implementation of this library. His contribution is highly appreciated, too.
</li>

</ul>

</html>
"));
  end Contact;

  annotation (__Dymola_DocumentationClass=true, Documentation(info="<html>
<p>
This library contains components for modelling of electromagnetic devices with lumped magnetic networks. Those models are suited for both rough design of the magnetic subsystem of a device as well as for efficient dynamic simulation at system level together with neighbouring subsystems. At present, components and examples for modelling of <i>translatory</i> electromagnetic and electrodynamic actuators are provided. If needed, these components can be adapted to network modellling of <i>rotational</i> electrical machines.
</p>
<p>
This user's guide gives a short introduction to the underlying concept of <b>magnetic flux tubes</b>, summarizes the calculation of magnetic <b>reluctance forces</b> from lumped magnetic network models and lists <b>reference literature</b>.
</p>
<p>
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples\">Examples</a> illustrates the usage of magnetic network models with simple models from different fields of application.
</html>"));
end UsersGuide;

  package Examples
    "Illustration of component usage with simple models of various devices"
    extends Modelica.Icons.ExamplesPackage;

    model SaturatedInductor
      "Inductor with saturation in the ferromagnetic core"
      extends Modelica.Icons.Example;

      Modelica.Magnetic.FluxTubes.Basic.Ground ground_m
        annotation (Placement(transformation(extent={{50,-30},{70,-10}},
            rotation=0)));
      Modelica.Electrical.Analog.Sources.SineVoltage source(
        freqHz=50,
        phase=pi/2,
        V=230*sqrt(2)) "Voltage applied to inductor"
                annotation (Placement(transformation(
          origin={-80,10},
          extent={{-10,-10},{10,10}},
          rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor r(R=7.5)
        "Inductor coil resistance"
        annotation (Placement(transformation(extent={{-61,10},{-41,30}},
            rotation=0)));
      Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter coil(
                                    N=600, i(fixed=true)) "Inductor coil"
        annotation (Placement(transformation(extent={{-30,0},{-10,20}},
            rotation=0)));
      Basic.ConstantReluctance r_mLeak(R_m=1.2e6) "Constant leakage reluctance"
        annotation (Placement(transformation(
          origin={10,10},
          extent={{-10,-10},{10,10}},
          rotation=270)));
      Modelica.Magnetic.FluxTubes.Shapes.FixedShape.Cuboid r_mAirPar(
        a=0.025,
        b=0.025,
        nonLinearPermeability=false,
        mu_rConst=1,
        l=0.0001)
        "Reluctance of small parasitic air gap (ferromagnetic core packeted from single sheets)"
        annotation (Placement(transformation(extent={{26,10},{46,30}}, rotation=
             0)));
      Modelica.Magnetic.FluxTubes.Shapes.FixedShape.Cuboid r_mFe(
        mu_rConst=1000,
        a=0.025,
        b=0.025,
        nonLinearPermeability=true,
        l=4*0.065,
        material=Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet.M350_50A())
        "Reluctance of ferromagnetic inductor core"
        annotation (Placement(transformation(
          origin={60,10},
          extent={{-10,-10},{10,10}},
          rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(extent={{-90,-30},{-70,-10}},
            rotation=0)));

    equation
      connect(source.p, r.p)        annotation (Line(points={{-80,20},{-61,20}},
          color={0,0,255}));
      connect(r.n, coil.p) annotation (Line(points={{-41,20},{-30,20},{-30,16}},
          color={0,0,255}));
      connect(source.n, coil.n) annotation (Line(points={{-80,0},{-30,0},{-30,4}},
          color={0,0,255}));
      connect(coil.port_p, r_mLeak.port_p) annotation (Line(points={{-10,16},{
              -10,20},{10,20}},
                              color={255,127,0}));
      connect(r_mLeak.port_p, r_mAirPar.port_p) annotation (Line(points={{10,20},
              {26,20}},
                      color={255,127,0}));
      connect(r_mAirPar.port_n, r_mFe.port_p) annotation (Line(points={{46,20},
            {54,20},{54,20},{60,20}}, color={255,127,0}));
      connect(r_mFe.port_n, r_mLeak.port_n) annotation (Line(points={{60,0},{
            47.5,0},{47.5,5.55112e-016},{35,5.55112e-016},{35,0},{10,0}}, color=
           {255,127,0}));
      connect(r_mFe.port_n, coil.port_n) annotation (Line(points={{60,0},{-10,0},
            {-10,4}}, color={255,127,0}));
    connect(ground.p, source.n) annotation (Line(
        points={{-80,-10},{-80,0}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground_m.port, r_mFe.port_n) annotation (Line(
        points={{60,-10},{60,0},{60,0}},
        color={255,127,0},
        smooth=Smooth.None));
      annotation (
          experiment(StopTime=0.1, Tolerance=1e-007),
        Documentation(info="<html>
<p>
This model demonstrates the effects of non-linear magnetisation characteristics of soft magnetic materials (hysteresis neglected). A sinusoidal voltage is applied to an inductor with a closed ferromagnetic core of rectangular shape. Set the <b>tolerance</b> to <b>1e-7</b>, <b>simulate for 0.1 s</b> and plot for example:
</p>

<pre>
    coil.i vs. time           // non-harmonic current due to saturation of the core material
    r_mFe.mu_r vs. r_mFe.B    // relative permeability vs. flux density inside core
    r_mFe.B vs. r_mFe.H       // magnetisation curve B(H); hysteresis neglected
</pre>

<p>
The magnetisation characteristics of the flux tube element representing the ferromagnetic core can easily be changed from simplified linear behaviour (nonLinearPermeability set to false and R_mFe.mu_rConst set to a positive value, preferably mu_rConst >> 1) to non-linear behaviour (e.g., selection of one of the electric sheets in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">Material.SoftMagnetic</a> with nonLinearPermeability set to true). This enables for convenient inital design of magnetic circuits with linear material characteristics prior to simulation with non-linear behaviour.
</p>

<h4>Note</h4>

<p>
If the supply voltage has a zero-crossing when applied to the inductor at time t=0 (i.e., source.phase set to zero instead of pi/2), then the inrush current that is typical for switching of inductive loads can be observed.
</p>
</html>"),Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
        Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics));
    end SaturatedInductor;

    package MovingCoilActuator
      "Two translatory electrodynamic actuator models of different modelling depth and their comparison"
      extends Modelica.Icons.ExamplesPackage;

      model ForceCurrentBehaviour
        "Comparison of the force-current characteristics of both converter models with armature blocked at mid-position"

        extends Modelica.Icons.Example;

        Modelica.Electrical.Analog.Basic.Ground pmGround
          annotation (Placement(transformation(extent={{-70,-100},{-50,-80}},
              rotation=0)));
        Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator
          pmActuator(x(start=0), material=
              Modelica.Magnetic.FluxTubes.Material.HardMagnetic.PlasticNdFeB())
          "Moving coil actuator described with permeance model"
          annotation (Placement(transformation(extent={{-20,-70},{0,-50}},
              rotation=0)));
        Modelica.Mechanics.Translational.Components.Fixed pmFixedPos(
                                                          s0=0)
          "Fixed armature position"
          annotation (Placement(transformation(extent={{10,-70},{30,-50}},
              rotation=0)));
        Modelica.Electrical.Analog.Sources.RampCurrent pmRampCurrent(
          I=-6,
          duration=6,
          offset=3) "Ideal current source "
          annotation (Placement(transformation(
            origin={-60,-60},
            extent={{-10,-10},{10,10}},
            rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground cGround
          annotation (Placement(transformation(extent={{-70,-20},{-50,0}},
              rotation=0)));
        Modelica.Mechanics.Translational.Components.Fixed cFixedPos(
                                                         s0=0)
          "Fixed armature position"
          annotation (Placement(transformation(extent={{10,10},{30,30}},
              rotation=0)));
        Modelica.Electrical.Analog.Sources.RampCurrent cRampCurrent(
          I=-6,
          duration=6,
          offset=3) "Ideal current source "
          annotation (Placement(transformation(
            origin={-60,20},
            extent={{-10,-10},{10,10}},
            rotation=270)));
        Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator
          cActuator "Moving coil actuator described with converter constant"
          annotation (Placement(transformation(extent={{-20,10},{0,30}},
              rotation=0)));
        Modelica.Blocks.Tables.CombiTable1Ds comparisonWithFEA(table=[-3,-9.65653;
              -2.5,-8.28587; -2,-6.82002; -1.5,-5.25898; -1,-3.60274; -0.5,-1.85131;
              0,-0.00468; 0.5,1.93714; 1,3.97415; 1.5,6.10636; 2,8.33376; 2.5,
              10.65636; 3,13.07415])
          "Column 1: current, col. 2: force; mu_rFe=const.=1000 in FEA model"
          annotation (Placement(transformation(extent={{40,50},{60,70}},
              rotation=0)));
        Modelica.Electrical.Analog.Sensors.CurrentSensor iSensor
          "Input value for look-up table with FEA results"
          annotation (Placement(transformation(extent={{-50,40},{-30,20}},
              rotation=0)));
      equation
        connect(pmFixedPos.flange,   pmActuator.flange)
          annotation (Line(points={{20,-60},{0,-60}}, color={0,127,0}));
        connect(pmRampCurrent.p, pmActuator.p)
                                           annotation (Line(points={{-60,-50},{
              -30,-50},{-30,-54},{-20,-54}}, color={0,0,255}));
        connect(pmActuator.n, pmRampCurrent.n)
                                           annotation (Line(points={{-20,-66},{
              -30,-66},{-30,-70},{-60,-70}}, color={0,0,255}));
        connect(pmGround.p, pmRampCurrent.n)
                                         annotation (Line(points={{-60,-80},{
              -60,-70}}, color={0,0,255}));
        connect(cGround.p,cRampCurrent. n) annotation (Line(points={{-60,0},{
              -60,10}}, color={0,0,255}));
        connect(cActuator.flange,cFixedPos.flange)            annotation (Line(
            points={{0,20},{20,20}}, color={0,127,0}));
        connect(cRampCurrent.n, cActuator.n)         annotation (Line(points={{
              -60,10},{-30,10},{-30,14},{-20,14}}, color={0,0,255}));
        connect(cRampCurrent.p, iSensor.p) annotation (Line(points={{-60,30},{
              -50,30}}, color={0,0,255}));
        connect(cActuator.p, iSensor.n)         annotation (Line(points={{-20,
              26},{-30,26},{-30,30}}, color={0,0,255}));
        connect(iSensor.i, comparisonWithFEA.u) annotation (Line(points={{-40,
              40},{-40,60},{38,60}}, color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-98,96},{100,86}},
              lineColor={0,0,255},
              textString=
                  "Comparison of the force-current characteristics of both converter models"),
              Text(
              extent={{-98,88},{2,78}},
              lineColor={0,0,255},
              textString="with armature blocked at mid-position")}),
                                                                   experiment(StopTime=
                6, Tolerance=1e-007),
          Documentation(info="<html>
<p>
Have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a> and at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a> for an explanation of both converter models. <br>
</p>
<p>
Simulation of the force-current characteristics of both converter models with the armature blocked at mid-position x=0 reveals the difference between the two models. In the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a>, force is proportional to current. In the simple <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a> there is an additional non-linear force component that is due to the dependency of the inductance on the armature position. Comparison with FEA results validates the higher accuracy of the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a>. In the FEA model, the relative permeability of the stator iron was set to mu_rFe=const.=1000 in order to avoid additional non-linear force components due to saturation. <b>Simulate for 6 s</b> and <b>plot vs. current (e.g., iSensor.i)</b></p>
<pre>
    pmFixedPos.flange_b.f       // force of permeance model
    cFixedPos.flange_b.f        // force of converter constant model
    comparisonWithFEA.y[1]      // force of FEA model for comparison
</pre>
</html>"));
      end ForceCurrentBehaviour;

      model ForceStrokeBehaviour
        "Force-stroke characteristic of the permeance model at constant current"

        extends Modelica.Icons.Example;

        Modelica.Electrical.Analog.Basic.Ground ground
          annotation (Placement(transformation(extent={{-70,-30},{-50,-10}},
              rotation=0)));
        Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator
          actuator(x(start=0), material=
              Modelica.Magnetic.FluxTubes.Material.HardMagnetic.PlasticNdFeB())
          annotation (Placement(transformation(extent={{-30,0},{-10,20}},
              rotation=0)));
        Modelica.Electrical.Analog.Sources.ConstantCurrent source(I=3)
          annotation (Placement(transformation(
            origin={-60,10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
        Modelica.Blocks.Sources.Ramp sweepX(
          height=7.99e-3,
          duration=8,
          offset=-3.995e-3,
          startTime=-4) annotation (Placement(transformation(extent={{70,0},{50,
                20}}, rotation=0)));
        Modelica.Mechanics.Translational.Sources.Position feedX(
                                                        exact=true)
          annotation (Placement(transformation(extent={{30,0},{10,20}},
              rotation=0)));
        Modelica.Blocks.Tables.CombiTable1Ds comparisonWithFEA(table=[-0.004,-8.8729,
              -9.07503,0.00332; -0.0035,-9.05239,-9.25042,0.00352; -0.003,-9.1915,-9.38558,
              0.00371; -0.0025,-9.28247,-9.47266,0.0039; -0.002,-9.3587,-9.54503,
              0.00409; -0.0015,-9.41568,-9.59782,0.00429; -0.001,-9.45496,-9.6331,
              0.00448; -0.0005,-9.47427,-9.64839,0.00467; 0,-9.48639,-9.65616,0.00486;
              0.0005,-9.48623,-9.65174,0.00505; 0.001,-9.4732,-9.63435,0.00524;
              0.0015,-9.44143,-9.59825,0.00543; 0.002,-9.39915,-9.55226,0.00562;
              0.0025,-9.33166,-9.47988,0.00581; 0.003,-9.23707,-9.38112,0.006; 0.0035,
              -9.09497,-9.23417,0.00619; 0.004,-8.91839,-9.05337,0.00638])
          "Column 1: position, col.2: force with non-linear stator iron, col.3: force with mu_rFe=const.=1000, col.4: inductance with mu_rFe=const.=1000 "
          annotation (Placement(transformation(extent={{50,40},{70,60}},
              rotation=0)));
      equation
        connect(ground.p, source.n)          annotation (Line(points={{-60,-10},
              {-60,0}}, color={0,0,255}));
        connect(source.n, actuator.n)          annotation (Line(points={{-60,0},
              {-46,0},{-46,4},{-30,4}}, color={0,0,255}));
        connect(source.p, actuator.p)          annotation (Line(points={{-60,20},
              {-46,20},{-46,16},{-30,16}}, color={0,0,255}));
        connect(sweepX.y, feedX.s_ref) annotation (Line(points={{49,10},{32,10}},
            color={0,0,127}));
        connect(feedX.flange,   actuator.flange) annotation (Line(points={{10,
              10},{-10,10}}, color={0,127,0}));
        connect(feedX.s_ref, comparisonWithFEA.u) annotation (Line(points={{32,
              10},{32,50},{48,50}}, color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
                {{-100,-100},{100,100}}),
                            graphics),                             experiment(
            StartTime=-4,
            StopTime=4,
            Tolerance=1e-007),
          Documentation(info="<html>
<p>
Have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a> and at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a> for an explanation of both converter models. <br>
</p>
<p>
Simulation of the force-stroke characteristic of the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a> with a constant current I=3A and a forced armature movement (similar to measurements in reality) shows the dependency of both force-generating permeances G_ma and G_mb as well as inductance L on armature position x. <b>Simulate for 8 s</b> and <b>plot vs.</b> armature position <b>feedX.flange_b.s</b> (same physical quantities together in a common diagram for comparison):</p>
<pre>
    feedX.flange_b.f            // force of permeance model (permeance of stator iron neglegted in this model)
    comparisonWithFEA.y[1]      // force of FEA model with non-linear stator iron 1.0718
    comparisonWithFEA.y[2]      // force of FEA model with mu_rFe=const.=1000
    actuator.g_ma.G_m           // permeance G_ma
    actuator.g_mb.G_m           // permeance G_mb
    actuator.L                  // inductance of permeance model
    comparisonWithFEA.y[3]      // inductance of FEA model for comparison (mu_rFe=const.=1000).
</pre>
</html>"));
      end ForceStrokeBehaviour;

      model ArmatureStroke
        "Armature stroke of both moving coil actuator models after a voltage step at time t=0"

        extends Modelica.Icons.Example;

        Modelica.Electrical.Analog.Basic.Ground pmGround
          annotation (Placement(transformation(extent={{-80,-70},{-60,-50}},
              rotation=0)));
        Modelica.Electrical.Analog.Sources.StepVoltage pmSource(
          startTime=0,
          V=pmActuator.R*1.5) "Steady state current 1.5A"
          annotation (Placement(transformation(
            origin={-70,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
        Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator
          pmActuator(material=Modelica.Magnetic.FluxTubes.Material.HardMagnetic.PlasticNdFeB(), x(
              start=pmActuator.x_min, fixed=true),
        armature(v(fixed=true)),
        coil(i(fixed=true)))
          "Moving coil actuator described with permeance model"
          annotation (Placement(transformation(extent={{-40,-40},{-20,-20}},
              rotation=0)));
        Modelica.Mechanics.Translational.Components.Mass pmLoad(
                                                            m=0.05)
          "Load to be moved in addition to the armature mass"
          annotation (Placement(transformation(extent={{0,-40},{20,-20}},
              rotation=0)));
        Modelica.Electrical.Analog.Basic.Ground cGround
          annotation (Placement(transformation(extent={{-80,0},{-60,20}},
              rotation=0)));
        Modelica.Electrical.Analog.Sources.StepVoltage cSource(
          startTime=0,
          V=cActuator.R*1.5) "Steady state current 1.5A"
          annotation (Placement(transformation(
            origin={-70,40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
        Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator
          cActuator(x(start=cActuator.x_min, fixed=true), armature(v(
                fixed=true)),
        l(i(start=0, fixed=true)))
          "Moving coil actuator described with converter constant"
          annotation (Placement(transformation(extent={{-40,30},{-20,50}},
              rotation=0)));
        Modelica.Mechanics.Translational.Components.Mass cLoad(
                                                           m=0.05)
          "Load to be moved in addition to the armature mass"
          annotation (Placement(transformation(extent={{0,30},{20,50}},
              rotation=0)));
      equation
        connect(pmLoad.flange_a, pmActuator.flange)
          annotation (Line(points={{0,-30},{-20,-30}}, color={0,127,0}));
        connect(cGround.p, cSource.n) annotation (Line(points={{-70,20},{-70,30}},
            color={0,0,255}));
        connect(cLoad.flange_a, cActuator.flange)    annotation (Line(points={{
              0,40},{-20,40}}, color={0,127,0}));
        connect(cSource.p, cActuator.p)  annotation (Line(points={{-70,50},{-56,
              50},{-56,46},{-40,46}}, color={0,0,255}));
        connect(cSource.n, cActuator.n)  annotation (Line(points={{-70,30},{-56,
              30},{-56,34},{-40,34}}, color={0,0,255}));
        connect(pmSource.n, pmGround.p)
          annotation (Line(points={{-70,-40},{-70,-50}}, color={0,0,255}));
        connect(pmSource.n, pmActuator.n)
                                        annotation (Line(points={{-70,-40},{-54,
              -40},{-54,-36},{-40,-36}}, color={0,0,255}));
        connect(pmSource.p, pmActuator.p)
                                        annotation (Line(points={{-70,-20},{-55,
              -20},{-55,-24},{-40,-24}}, color={0,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
                {{-100,-100},{100,100}}), graphics={Text(
              extent={{-98,98},{48,86}},
              lineColor={0,0,255},
              textString=
                  "Comparison of a pull-in stroke of both converter models"),
              Text(
              extent={{-98,90},{-30,80}},
              lineColor={0,0,255},
              textString="after a voltage step at t=0")}),         experiment(StopTime=
                0.05, Tolerance=1e-007),
          Documentation(info="<html>
<p>
Have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a> and at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a>
for an explanation of both actuator models.</p>

<p>
A voltage step at time t=0 is applied to both actuator models. In each model, the armature and an attached load mass perform a stroke between the two stoppers included in cActuator.armature and pmActuator.armature respectively. <b>Simulate for 0.05 s</b> and plot vs. time (same physical quantities together in a common diagram for comparison):
</p>
<pre>
    cActuator.p.i                     // input current to converter constant model
    pmActuator.p.i                    // input current to permeance model
    cActuator.armature.flange_a.f     // actuator force of converter constant model
    pmActuator.armature.flange_a.f    // actuator force of permeance model
    cActuator.x                       // armature position of converter constant model
    pmActuator.x                      // armature position of permeance model
    cActuator.L                       // inductance of converter constant model
    pmActuator.L                      // inductance of permeance model
</pre>
<p>
The initial current rise in both actuator models is due to the inductance of the actuator coil. After acceleration of the armature and the load, the current decreases due to the motion-induced back-emf. Bouncing occurs when the armatures of both models arrive at the stopper at maximum armature position. The bouncing is rather intense due to the absence of any kind of external friction in this simple example (apart from the nonlinear damping in the stopper elements). After decay of the bouncing, both actuators operate under conditions valid for a blocked armature.
</p>
<p>
Whereas the steady state current is the same in both models, the steady state actuator force is not due to the neglection of the non-linear force component in the converter constant model. Differences in the current rise of both models are due to the neglection of the coil inductance variation in the converter constant model.
</p>
</html>"));
      end ArmatureStroke;

      package Components "Components to be used in examples"
        extends Modelica.Icons.Package;

        model PermeanceActuator
          "Detailed actuator model for rough magnetic design of actuator and system simulation"

          parameter Real N = 140 "Number of turns";
          parameter SI.Resistance R = 2.86 "Coil resistance";

          parameter SI.Radius r_core = 12.5e-3
            "Radius of ferromagnetic stator core";

          parameter SI.Length l_PM = 3.5e-3
            "Radial thickness of permanent magnet ring";
          parameter SI.Length t = 0.02
            "Axial length of permanent magnet ring and air gap respectively";

          parameter SI.Length l_air = 3e-3
            "Total radial length of armature air gap";

          parameter SI.Length l_FeOut = 4e-3
            "Radial thickness of outer back iron (for estimation of leakage permeance)";

          parameter Modelica.Magnetic.FluxTubes.Material.HardMagnetic.BaseData
            material=
            Modelica.Magnetic.FluxTubes.Material.HardMagnetic.BaseData()
            "Ferromagnetic material characteristics"     annotation(choicesAllMatching=true, Dialog(group="Material"));

          parameter SI.Mass m_a = 0.012 "Mass of armature" annotation(Dialog(group="Armature and stopper"));

          parameter SI.TranslationalSpringConstant c=
                1e11 "Spring stiffness between impact partners" annotation(Dialog(group="Armature and stopper"));
          parameter SI.TranslationalDampingConstant d=
                400 "Damping coefficient between impact partners"   annotation(Dialog(group="Armature and stopper"));
          parameter SI.Position x_min=-4e-3
            "Position of stopper at minimum armature position" annotation(Dialog(group="Armature and stopper"));
          parameter SI.Position x_max=4e-3
            "Position of stopper at maximum armature position" annotation(Dialog(group="Armature and stopper"));

          SI.Position x(start = x_min, stateSelect=StateSelect.prefer)
            "Armature position, alias for flange position";

          SI.Inductance L "Coil inductance";

          Modelica.Magnetic.FluxTubes.Sources.ConstantMagneticPotentialDifference
            mmf_PM(
            final V_m=material.H_cB*l_PM)
            "Permanent magnet's magnetomotive force"
            annotation (Placement(transformation(
              origin={10,20},
              extent={{-10,-10},{10,10}},
              rotation=270)));

          Modelica.Magnetic.FluxTubes.Examples.Utilities.TranslatoryArmatureAndStopper
            armature(
            final L=0,
            final m=m_a,
            final c=c,
            final d=d,
            n=2,
            final x_max=x_max,
            final x_min=x_min)
            "Inertia of moving coil + coil carrier; stoppers at end of stroke range"
            annotation (Placement(transformation(extent={{60,-10},{80,10}},
                rotation=0)));
          Modelica.Electrical.Analog.Basic.Resistor r(final R=R)
            annotation (Placement(transformation(
              origin={-80,30},
              extent={{-10,-10},{10,10}},
              rotation=270)));

          Basic.Ground ground annotation (Placement(transformation(extent={{30,
                  -38},{50,-18}}, rotation=0)));
          Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter coil(
                                        final N=N)
            annotation (Placement(transformation(
              origin={0,-20},
              extent={{-10,-10},{10,10}},
              rotation=90)));
          Modelica.Magnetic.FluxTubes.Shapes.Force.HollowCylinderRadialFlux
            g_ma(
            final dlBydx=1,
            final l=t/2 + x,
            final r_i=r_core,
            final r_o=r_core + l_air + l_PM,
            final mu_r=1.05,
            final useSupport=false)
                             annotation (Placement(transformation(
              origin={-20,0},
              extent={{-10,-10},{10,10}},
              rotation=270)));
          Modelica.Magnetic.FluxTubes.Shapes.Force.HollowCylinderRadialFlux
            g_mb(
            final r_i=r_core,
            final r_o=r_core + l_air + l_PM,
            final dlBydx=-1,
            final l=t/2 - x,
            final mu_r=1.05,
            final useSupport=false)
                             annotation (Placement(transformation(
              origin={30,0},
              extent={{-10,-10},{10,10}},
              rotation=270)));
          Modelica.Magnetic.FluxTubes.Shapes.Leakage.CoaxCylindersEndFaces
            g_mLeak1(
            final r_1=r_core + l_air + l_PM,
            final r_2=r_core + l_air + l_PM + l_FeOut,
            final r_0=r_core)
            "Leakgage between coaxial end planes of ferromagnetic stator core and outer back iron"
            annotation (Placement(transformation(
              origin={-60,10},
              extent={{-10,-10},{10,10}},
              rotation=270)));
          Modelica.Magnetic.FluxTubes.Shapes.Leakage.HalfCylinder g_mLeak2(
            final l=2*pi*(r_core + (l_air + l_PM)/2))
            "Leakgage between edges of ferromagnetic stator core and outer back iron"
            annotation (Placement(transformation(
              origin={-40,10},
              extent={{-10,-10},{10,10}},
              rotation=270)));

          Modelica.Electrical.Analog.Interfaces.PositivePin p
            "Electrical connector"
            annotation (Placement(transformation(extent={{-110,50},{-90,70}},
                rotation=0)));
          Modelica.Electrical.Analog.Interfaces.NegativePin n
            "Electrical connector"
            annotation (Placement(transformation(extent={{-90,-70},{-110,-50}},
                rotation=0)));
          Modelica.Mechanics.Translational.Interfaces.Flange_b flange
            "Flange of component"
            annotation (Placement(transformation(extent={{90,-10},{110,10}},
                rotation=0)));
        equation
          x = flange.s;
          L = coil.N^2 * (g_ma.G_m + g_mLeak1.G_m + g_mLeak2.G_m);

          connect(armature.flange_b, flange) annotation (Line(
            points={{80,0},{100,0}},
            color={0,127,0},
            pattern=LinePattern.None));
          connect(r.p, p)
            annotation (Line(points={{-80,40},{-80,60},{-100,60}}, color={0,0,
                255}));
          connect(armature.flange_a,g_mb. flange) annotation (Line(points={{60,0},{
                40,0},{40,-1.83697e-015}},     color={0,127,0}));
          connect(g_mb.flange,g_ma. flange) annotation (Line(points={{40,
                -1.83697e-015},{40,40},{-10,40},{-10,-1.83697e-015}}, color={0,
                127,0}));
          connect(g_mLeak1.port_n, g_ma.port_n) annotation (Line(points={{-60,0},
                {-60,-10},{-20,-10}}, color={255,127,0}));
          connect(g_mLeak2.port_n, g_ma.port_n) annotation (Line(points={{-40,0},
                {-40,-10},{-20,-10}}, color={255,127,0}));
          connect(g_ma.port_n, coil.port_p) annotation (Line(points={{-20,-10},
                {-18,-10},{-18,-12},{-14,-12},{-14,-10},{-6,-10}}, color={255,
                127,0}));
          connect(coil.port_n, g_mb.port_n) annotation (Line(points={{6,-10},{
                30,-10}}, color={255,127,0}));
          connect(g_mb.port_n, mmf_PM.port_p) annotation (Line(points={{30,-10},
                {50,-10},{50,30},{10,30}}, color={255,127,0}));
          connect(mmf_PM.port_p, g_mLeak2.port_p) annotation (Line(points={{10,30},
                {-40,30},{-40,20}},     color={255,127,0}));
          connect(mmf_PM.port_p, g_mLeak1.port_p) annotation (Line(points={{10,30},
                {-60,30},{-60,20}},     color={255,127,0}));
          connect(g_ma.port_p, mmf_PM.port_n) annotation (Line(points={{-20,10},
                {10,10}}, color={255,127,0}));
          connect(mmf_PM.port_n, g_mb.port_p) annotation (Line(points={{10,10},
                {30,10}}, color={255,127,0}));
          connect(r.n, coil.p) annotation (Line(points={{-80,20},{-80,-30},{-6,
                -30}}, color={0,0,255}));
          connect(coil.n, n) annotation (Line(points={{6,-30},{6,-60},{-100,-60}},
              color={0,0,255}));
        connect(ground.port, g_mb.port_n) annotation (Line(
            points={{40,-18},{40,-10},{30,-10}},
            color={255,127,0},
            smooth=Smooth.None));
          annotation (
          __Dymola_Images(Parameters(source=
                    "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/MovingCoilActuator/MovingCoilActuator_dimensions.png")),
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                  graphics),
            Documentation(info="<html>
<p>
In the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a> model the force F is strictly proportional to the current i as indicated by the converter constant c. However, there is an additional non-linear force component in such an actuator that is due to the dependency of the coil inductance L on the armature position x. The inductance increases as the armature moves into the stator. The total force is
</p>

<pre>
        1  2 dL
    F = - i  --  + c i
        2    dx
</pre>

<p>
Both force components are properly considered with a simple permeance model as shown in the figures below. Figure (a) illustrates the dimensions of the axisymmetric moving coil actuator that are needed in the permeance model. Figure (b) shows partitioning into flux tubes and the permanent magnetic field without current. G_ma and G_mb both are the permeances resulting from a series connection of the permaent magnet and air gap sections. The field plot of the coil-imposed mmf is shown in figure (c) without the permanent magnetic mmf (H_cB=0). The placement of the magnetic network components in figure (d) retains the geometric structure of the actuator. In figure (e), the permeance model is restructured and thus simplified.
</p>

<IMG src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/MovingCoilActuator/MovingCoilActuator_PermeanceModel.png\" ALT=\"Structure, assigned flux tubes and field plots of the moving coil actuator\">
</html>"),  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={
              Rectangle(
                extent={{-90,100},{90,-100}},
                lineColor={255,128,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-90,100},{-50,-100}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,80},{-90,100}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,-80},{-90,-100}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{70,34},{-90,-34}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,52},{-16,64}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={255,213,170},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,-64},{-12,-52}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={255,213,170},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{0,160},{0,120}},
                lineColor={0,0,255},
                textString="%name")}));
        end PermeanceActuator;

        model ConstantActuator
          "Simple behavioural actuator model for system simulation"

          parameter SI.ElectricalForceConstant k = 3.88 "Converter constant";
          parameter SI.Resistance R = 2.86 "Coil resistance";
          parameter SI.Inductance L = 0.0051 "Coil inductance at mid-stroke";
          parameter SI.Mass m_a = 0.012 "Armature mass" annotation(Dialog(group="Armature and stopper"));
          parameter Modelica.SIunits.TranslationalSpringConstant c=
                1e11 "Spring stiffness between impact partners" annotation(Dialog(group="Armature and stopper"));
          parameter Modelica.SIunits.TranslationalDampingConstant d=
                400 "Damping coefficient between impact partners"   annotation(Dialog(group="Armature and stopper"));
          parameter SI.Position x_min = -4e-3 "Minimum armature position" annotation(Dialog(group="Armature and stopper"));
          parameter SI.Position x_max = 4e-3 "Maximum armature position" annotation(Dialog(group="Armature and stopper"));

          SI.Position x(start=x_min, stateSelect=StateSelect.prefer)
            "Armature position, alias for flange position";

          Modelica.Electrical.Analog.Basic.Resistor r(final R=R)
            "Coil resistance"
            annotation (Placement(transformation(extent={{-90,50},{-70,70}},
                rotation=0)));
          Modelica.Magnetic.FluxTubes.Examples.Utilities.TranslatoryArmatureAndStopper
            armature(
            final m=m_a,
            final x_max=x_max,
            final x_min=x_min,
            final L=0,
            final c=c,
            final d=d,
            n=2) "Armature inertia with stoppers at end of stroke range"
            annotation (Placement(transformation(extent={{60,-10},{80,10}},
                rotation=0)));

          Modelica.Electrical.Analog.Basic.Inductor l(final L=L)
            "Coil inductance"
            annotation (Placement(transformation(extent={{-60,50},{-40,70}},
                rotation=0)));
          Modelica.Electrical.Analog.Basic.TranslationalEMF
            electroTranslationalConverter( final k=k)
            annotation (Placement(transformation(extent={{-40,-10},{-20,10}},
                rotation=0)));
          Modelica.Electrical.Analog.Interfaces.PositivePin p
            "Electrical connector"
            annotation (Placement(transformation(extent={{-110,50},{-90,70}},
                rotation=0)));
          Modelica.Electrical.Analog.Interfaces.NegativePin n
            "Electrical connector"
            annotation (Placement(transformation(extent={{-90,-70},{-110,-50}},
                rotation=0)));
          Modelica.Mechanics.Translational.Interfaces.Flange_b flange
            "Flange of component"
            annotation (Placement(transformation(extent={{90,-10},{110,10}},
                rotation=0)));
        equation
          flange.s = x;

          connect(r.p, p) annotation (Line(points={{-90,60},{-100,60}}, color={
                0,0,255}));
          connect(l.p,r. n)
            annotation (Line(points={{-60,60},{-70,60}}, color={0,0,255}));
          connect(armature.flange_b, flange) annotation (Line(points={{80,0},{
                85,0},{85,1.16573e-015},{90,1.16573e-015},{90,0},{100,0}},
              color={0,127,0}));
          connect(l.n, electroTranslationalConverter.p) annotation (Line(points=
               {{-40,60},{-30,60},{-30,10}}, color={0,0,255}));
          connect(n, electroTranslationalConverter.n) annotation (Line(points={
                {-100,-60},{-30,-60},{-30,-10}}, color={0,0,255}));
          connect(electroTranslationalConverter.flange, armature.flange_a)
            annotation (Line(points={{-20,0},{0,0},{0,-6.10623e-016},{20,
                -6.10623e-016},{20,0},{60,0}}, color={0,127,0}));
          annotation (Diagram(coordinateSystem(preserveAspectRatio=false,
                extent={{-100,-100},{100,100}}),
                              graphics),
                               Icon(coordinateSystem(preserveAspectRatio=false,
                extent={{-100,-100},{100,100}}), graphics={
              Rectangle(
                extent={{-80,100},{80,-100}},
                lineColor={255,128,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-70,80},{72,-80}},
                lineColor={255,128,0},
                textString="c"),
              Line(points={{-90,60},{-80,60}}, color={0,0,255}),
              Line(points={{-90,-60},{-80,-60}}, color={0,0,255}),
              Line(points={{80,0},{90,0}}, color={0,127,0}),
              Text(
                extent={{0,160},{0,120}},
                lineColor={0,0,255},
                textString="%name")}),
            Documentation(info="<html>
<p>
Similar to rotational DC-Motors, the electro-mechanical energy conversion of translatory electrodynamic actuators and generators of moving coil and moving magnet type can be described with the following two converter equations:
</p>

<pre>
      F = c * i
    V_i = c * v
</pre>

<p>
with electrodynamic or <i>Lorentz</i> force F, converter constant c, current i, induced back-emf V_i and armature velocity v. The model is very similar to the well-known behavioural model of a rotational one-phase DC-Machine, except that it is for translatory motion. For a moving coil actuator with a coil inside an air gap with flux density B and a total wire length l inside the magnetic field, the converter constant becomes
</p>

<pre>
    c = B * l.
</pre>

<p>
The converter constant c as well as coil resistance R and inductance L are assumed to be known, e.g., from measurements or catalogue data. Hence this model is well-suited for system simulation together with neighbouring subsystems, but not for actuator design, where the motor constant is to be found on base of the magnetic circuit's geometry, material properties and winding data. See <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a> for a more accurate model of this actuator that is based on a magnetic network. Due to identical connectors, both models can be used in system simulation, e.g. to simulate a stroke as demonstrated in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.ArmatureStroke\">ArmatureStroke</a>.
</p>
</html>"));
        end ConstantActuator;
      end Components;
      annotation (Documentation(info="<html>
<p>
Moving coil actuators are often called electrodynamic actuators and a proportional behaviour between force and current is expressed by a converter constant (see <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a>). However, in a simple moving coil actuator as presented in this example there is an additional non-linear force component that is due to the increase of the inductance when the armature coil moves into the ferromagnetic stator. A simple <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a> can be used to describe this non-linear force component.
</p>
</html>"),     Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
    end MovingCoilActuator;

    package SolenoidActuator
      "Two models of a reluctance actuator of different modelling depth and their comparison and usage"
      extends Modelica.Icons.ExamplesPackage;

      model ComparisonQuasiStationary
        "Slow forced armature motion of both solenoid models so that electromagnetic field and current are quasi-stationary"

        extends Modelica.Icons.Example;

        parameter SI.Voltage v_step = 12 "Applied voltage";

        Modelica.Blocks.Sources.Ramp x_set(
          duration=10,
          height=-(advancedSolenoid.x_max - advancedSolenoid.x_min),
          offset=advancedSolenoid.x_max)
          "Prescribed armature position, slow enforced motion from x_max to x_min"
                               annotation (Placement(transformation(extent={{80,
                -10},{60,10}}, rotation=0)));
        Modelica.Electrical.Analog.Basic.Ground advancedGround
          annotation (Placement(transformation(extent={{-80,10},{-60,30}},
              rotation=0)));
        Modelica.Electrical.Analog.Sources.StepVoltage advancedSource(V=v_step)
          annotation (Placement(transformation(
            origin={-70,50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
        Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.AdvancedSolenoid
          advancedSolenoid
          annotation (Placement(transformation(extent={{-40,40},{-20,60}},
              rotation=0)));
        Modelica.Mechanics.Translational.Sources.Position advancedFeed_x(
                                                                 f_crit=1000, exact=true)
          annotation (Placement(transformation(
            origin={0,50},
            extent={{-10,-10},{10,10}},
            rotation=180)));
        Modelica.Electrical.Analog.Basic.Ground simpleGround
          annotation (Placement(transformation(extent={{-80,-90},{-60,-70}},
              rotation=0)));
        Modelica.Electrical.Analog.Sources.StepVoltage simpleSource(V=v_step)
          annotation (Placement(transformation(
            origin={-70,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
        Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.SimpleSolenoid
          simpleSolenoid
          annotation (Placement(transformation(extent={{-40,-60},{-20,-40}},
              rotation=0)));
        Modelica.Mechanics.Translational.Sources.Position simpleFeed_x(
                                                               f_crit=1000, exact=false)
          annotation (Placement(transformation(
            origin={0,-50},
            extent={{-10,-10},{10,10}},
            rotation=180)));
        Modelica.Blocks.Tables.CombiTable1Ds comparisonWithFEA(table=[0.00025,-85.8619,
              0.00014821,0.11954; 0.0005,-59.9662,0.00013931,0.11004; 0.00075,-41.0806,
              0.0001277,0.098942; 0.001,-28.88,0.00011587,0.088425; 0.00125,-21.4113,
              0.00010643,0.08015; 0.0015,-16.8003,9.9406e-005,0.073992; 0.00175,
              -13.6942,9.3416e-005,0.068792; 0.002,-11.1188,8.8564e-005,
              0.064492; 0.00225,-9.6603,8.4505e-005,0.060917; 0.0025,-8.4835,
              8.1215e-005,0.058017; 0.00275,-7.4658,7.7881e-005,0.055125; 0.003,
              -6.5591,7.5197e-005,0.052733; 0.00325,-5.9706,7.2447e-005,0.05035;
              0.0035,-5.5013,7.0342e-005,0.048525; 0.00375,-5.0469,6.8527e-005,
              0.046867; 0.004,-4.6573,6.6526e-005,0.045158; 0.00425,-4.2977,
              6.4425e-005,0.043442; 0.0045,-4.0912,6.2747e-005,0.04205; 0.00475,
              -3.7456,6.1231e-005,0.040733; 0.005,-3.5869,5.9691e-005,0.039467])
          "Valid for u_source=12V only; column 1: position, col.2: force, col.3: armature flux, col.4: inductance"
          annotation (Placement(transformation(extent={{60,60},{80,80}},
              rotation=0)));
      equation
        connect(advancedGround.p, advancedSource.n)
                                      annotation (Line(points={{-70,30},{-70,40}},
            color={0,0,255}));
        connect(x_set.y, advancedFeed_x.s_ref)
                                       annotation (Line(points={{59,0},{20,0},{
              20,50},{12,50}}, color={0,0,127}));
        connect(simpleSolenoid.p, simpleSource.p)
                                             annotation (Line(points={{-40,-44},
              {-50,-44},{-50,-40},{-70,-40}}, color={0,0,255}));
        connect(simpleSolenoid.n, simpleSource.n)
                                             annotation (Line(points={{-40,-56},
              {-50,-56},{-50,-60},{-70,-60}}, color={0,0,255}));
        connect(simpleSolenoid.flange,simpleFeed_x.flange)   annotation (Line(
            points={{-20,-50},{-10,-50}}, color={0,127,0}));
        connect(advancedSolenoid.n, advancedSource.n)
                                              annotation (Line(points={{-40,44},
              {-50,44},{-50,40},{-70,40}}, color={0,0,255}));
        connect(simpleFeed_x.s_ref, x_set.y)  annotation (Line(points={{12,-50},
              {20,-50},{20,0},{59,0}}, color={0,0,127}));
        connect(x_set.y,comparisonWithFEA. u) annotation (Line(points={{59,0},{
              50,0},{50,70},{58,70}}, color={0,0,127}));
        connect(advancedFeed_x.flange,   advancedSolenoid.flange)
                                                        annotation (Line(points=
             {{-10,50},{-20,50}}, color={0,127,0}));
        connect(advancedSource.p, advancedSolenoid.p)
                                              annotation (Line(points={{-70,60},
              {-50,60},{-50,56},{-40,56}}, color={0,0,255}));
        connect(simpleGround.p, simpleSource.n)
                                        annotation (Line(points={{-70,-70},{-70,
              -60}}, color={0,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
                {{-100,-100},{100,100}}),
                            graphics),                             experiment(StopTime=
                10, Tolerance=1e-007),
          Documentation(info="<html>
<p>
Have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator\">SolenoidActuator</a> for general comments and at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.SimpleSolenoid\">SimpleSolenoid</a> and <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.AdvancedSolenoid\">AdvancedSolenoid</a> for a detailed description of both magnetic network models.
</p>

<p>
Similar to static force-stroke measurements on real actuators, the armatures of both actuator models are forced to move slowly here. Hence, the dynamics of the electrical subsystems due to coil inductance and armature motion can be neglected and the static force-stroke characteristics are obtained. To illustrate the accuracy to be expected from the lumped magnetic network models, results obtained with stationary FEA are included as reference (position-dependent force, armature flux and actuator inductance). Note that these reference values are valid for the default supply voltage v_step=12V DC only!
</p>

<p>
Set the <b>tolerance</b> to <b>1e-7</b> and <b>simulate for 10 s</b>. Plot in one common window the electromagnetic force of the two magnetic network models and the FEA reference <b>vs. armature position x_set.y</b>:
</p>

<pre>
    simpleSolenoid.armature.flange_a.f     // electromagnetic force of simple magnetic network model
    advancedSolenoid.armature.flange_a.f   // electromagnetic force of advaned magnetic network model
    comparisonWithFEA.y[1]                 // electromagnetic force obtained with FEA as reference
</pre>

<p>
Electromagnetic or reluctance forces always act towards a decrease of air gap lengths. With the defined armature position coordinate x, the forces of the models are negative.
</p>

<p>
The magnetic flux through the armature and the actuator's static inductance both illustrate the differences between the two magnetic network models. Similar to the forces, compare these quantities in one common plot window for each variable (plot vs. armature position x_set.y):
</p>

<pre>
    simpleSolenoid.G_mFeArm.Phi            // magnetic flux through armature of simple magnetic network model
    advancedSolenoid.G_mFeArm.Phi          // magnetic flux through armature of advanced magnetic network model
    comparisonWithFEA.y[2]                 // magnetic flux obtained with FEA as reference

    simpleSolenoid.coil.L_stat             // static inductance of simple magnetic network model
    advancedSolenoid.L_statTot             // series connection of both partial coils of advanced network model
    comparisonWithFEA.y[3]                 // static inductance obtained with FEA as reference
</pre>

<p>
As mentioned in the description of both magnetic network models, one can tell the higher armature flux and inductance of the advanced solenoid model at large air gaps compared to that of the simple model. The effect of this difference on dynamic model behaviour can be analysed in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.ComparisonPullInStroke\">ComparisonPullInStroke</a>.
</p>
</html>"));
      end ComparisonQuasiStationary;

      model ComparisonPullInStroke
        "Pull-in stroke of both solenoid models after a voltage step at time t=0"

        extends Modelica.Icons.Example;

        parameter SI.Voltage v_step = 12 "Applied voltage";

        Modelica.Electrical.Analog.Basic.Ground advancedGround
          annotation (Placement(transformation(extent={{-70,-10},{-50,10}},
              rotation=0)));
        Modelica.Electrical.Analog.Sources.StepVoltage advancedSource(V=v_step)
          annotation (Placement(transformation(
            origin={-60,30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
        Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.AdvancedSolenoid
          advancedSolenoid(x(fixed=true))
                         annotation (Placement(transformation(extent={{-20,20},
                {0,40}}, rotation=0)));
        Modelica.Mechanics.Translational.Components.Mass advancedLoad(
                                                                  m=0.01)
          "translatory load to be pulled horizontally"
          annotation (Placement(transformation(extent={{20,20},{40,40}},
              rotation=0)));
        Modelica.Electrical.Analog.Basic.Ground simpleGround
          annotation (Placement(transformation(extent={{-70,-90},{-50,-70}},
              rotation=0)));
        Modelica.Electrical.Analog.Sources.StepVoltage simpleSource(V=v_step)
          annotation (Placement(transformation(
            origin={-60,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
        Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.SimpleSolenoid
          simpleSolenoid(x(fixed=true))
                       annotation (Placement(transformation(extent={{-20,-60},{
                0,-40}}, rotation=0)));
        Modelica.Mechanics.Translational.Components.Mass simpleLoad(
                                                                m=0.01)
          "translatory load to be pulled horizontally"
          annotation (Placement(transformation(extent={{20,-60},{40,-40}},
              rotation=0)));
        Modelica.Blocks.Sources.CombiTimeTable comparisonWithFEA(
          table=[0,0,0,0.005; 2.61165e-007,7.93537e-005,-1.97914e-005,0.005;
              2.61165e-007,7.93537e-005,-1.97914e-005,0.005; 0.0001,0.0300045,-0.00748335,
              0.005; 0.0002,0.05926,-0.0147799,0.005; 0.0003,0.0877841,-0.021894,
              0.00499999; 0.0004,0.115593,-0.036608,0.00499997; 0.0005,0.142707,
              -0.0568957,0.00499994; 0.0006,0.169143,-0.076676,0.00499988;
              0.0007,0.194915,-0.0959614,0.0049998; 0.0008,0.220042,-0.124763,
              0.00499968; 0.0009,0.244539,-0.155317,0.00499951; 0.001,0.26842,-0.185107,
              0.00499928; 0.0011,0.291701,-0.214153,0.00499898; 0.0012,0.314394,
              -0.249655,0.0049986; 0.0013,0.336514,-0.288306,0.00499812; 0.0014,
              0.358074,-0.325991,0.00499754; 0.0015,0.379086,-0.362735,
              0.00499682; 0.0016,0.399562,-0.398563,0.00499597; 0.0017,0.419514,
              -0.44324,0.00499496; 0.0018,0.438955,-0.487015,0.00499378; 0.0019,
              0.457893,-0.529698,0.00499242; 0.002,0.47634,-0.571317,0.00499085;
              0.0021,0.494305,-0.611901,0.00498906; 0.0022,0.511799,-0.657374,
              0.00498704; 0.0023,0.528832,-0.704491,0.00498476; 0.0024,0.545412,
              -0.750434,0.00498221; 0.0025,0.561548,-0.795237,0.00497937;
              0.0026,0.577248,-0.83893,0.00497623; 0.0027,0.592521,-0.881543,
              0.00497277; 0.0028,0.607375,-0.926803,0.00496896; 0.0029,0.62182,
              -0.974598,0.0049648; 0.003,0.63586,-1.02121,0.00496027; 0.0031,
              0.649503,-1.06667,0.00495534; 0.0032,0.662756,-1.11102,0.00495;
              0.0033,0.675625,-1.15428,0.00494424; 0.0034,0.688119,-1.19648,
              0.00493803; 0.0035,0.700242,-1.23778,0.00493136; 0.0036,0.712005,
              -1.28391,0.00492421; 0.0037,0.72341,-1.32891,0.00491657; 0.0038,
              0.734463,-1.3728,0.00490842; 0.0039,0.74517,-1.41563,0.00489974;
              0.004,0.755536,-1.45743,0.00489052; 0.0041,0.765568,-1.49822,
              0.00488074; 0.0042,0.775269,-1.53803,0.00487038; 0.0043,0.784646,
              -1.57689,0.00485943; 0.0044,0.793704,-1.61483,0.00484787; 0.0045,
              0.80245,-1.65314,0.00483569; 0.0046,0.810888,-1.69366,0.00482288;
              0.0047,0.81902,-1.7332,0.00480941; 0.0048,0.826851,-1.77179,
              0.00479528; 0.0049,0.834387,-1.80945,0.00478046; 0.005,0.841631,-1.84622,
              0.00476495; 0.0051,0.84859,-1.88259,0.00474873; 0.0052,0.855304,-1.92429,
              0.00473179; 0.0053,0.861739,-1.96564,0.0047141; 0.0054,0.8679,-2.00668,
              0.00469566; 0.0055,0.873791,-2.04743,0.00467645; 0.0056,0.879419,
              -2.08794,0.00465645; 0.0057,0.884782,-2.1282,0.00463565; 0.0058,
              0.889885,-2.16824,0.00461403; 0.0059,0.894731,-2.20808,0.00459157;
              0.006,0.899322,-2.24774,0.00456827; 0.0061,0.903661,-2.28927,
              0.0045441; 0.0062,0.907752,-2.33091,0.00451905; 0.0063,0.911603,-2.37014,
              0.0044931; 0.0064,0.915232,-2.40274,0.00446624; 0.0065,0.91862,-2.43469,
              0.00443846; 0.0066,0.92177,-2.466,0.00440974; 0.0067,0.924686,-2.49668,
              0.00438007; 0.0068,0.927368,-2.52672,0.00434945; 0.0069,0.929822,
              -2.55615,0.00431785; 0.007,0.93205,-2.58498,0.00428527; 0.0071,
              0.934052,-2.61318,0.00425169; 0.0072,0.935241,-2.64973,0.00421711;
              0.0073,0.936164,-2.68643,0.00418151; 0.0074,0.936854,-2.7228,
              0.00414488; 0.0075,0.937309,-2.7588,0.0041072; 0.0076,0.937532,-2.7944,
              0.00406845; 0.0077,0.937522,-2.82958,0.00402864; 0.0078,0.937411,
              -2.866,0.00398773; 0.0079,0.937385,-2.90613,0.00394572; 0.008,
              0.937133,-2.94589,0.0039026; 0.0081,0.936656,-2.98525,0.00385834;
              0.0082,0.935953,-3.02414,0.00381293; 0.0083,0.935024,-3.06251,
              0.00376636; 0.0084,0.934308,-3.10824,0.00371862; 0.0085,0.933608,
              -3.15783,0.00366967; 0.0086,0.93269,-3.20708,0.00361952; 0.0087,
              0.931553,-3.25592,0.00356812; 0.0088,0.930194,-3.30427,0.00351548;
              0.0089,0.928473,-3.35247,0.00346157; 0.009,0.926467,-3.40014,
              0.00340636; 0.0091,0.924232,-3.44698,0.00334985; 0.0092,0.921766,
              -3.49289,0.00329202; 0.0093,0.918579,-3.53879,0.00323283; 0.0094,
              0.913925,-3.5856,0.00317229; 0.0095,0.909004,-3.63034,0.00311037;
              0.0096,0.903809,-3.67275,0.00304706; 0.0097,0.89859,-3.72881,
              0.00298233; 0.0098,0.893783,-3.82589,0.00291616; 0.0099,0.888707,
              -3.92096,0.00284852; 0.01,0.883343,-4.01357,0.00277938; 0.0101,
              0.876979,-4.10734,0.00270869; 0.0102,0.869783,-4.19987,0.00263642;
              0.0103,0.862246,-4.28752,0.00256254; 0.0104,0.854574,-4.37627,
              0.00248701; 0.0105,0.847614,-4.49154,0.00240979; 0.0106,0.840302,
              -4.60102,0.00233085; 0.0107,0.832625,-4.70399,0.00225014; 0.0108,
              0.822938,-4.82647,0.00216761; 0.0109,0.812813,-4.93752,0.00208323;
              0.011,0.802204,-5.04175,0.00199695; 0.0111,0.78997,-5.30274,
              0.00190873; 0.0112,0.777197,-5.54515,0.00181846; 0.0113,0.763521,
              -5.78149,0.00172606; 0.0114,0.748272,-6.039,0.00163144; 0.0115,
              0.73235,-6.25778,0.0015345; 0.0116,0.715211,-6.57852,0.00143514;
              0.0117,0.696998,-6.91971,0.00133326; 0.0118,0.677065,-7.30735,
              0.00122872; 0.0119,0.652791,-7.88085,0.00112136; 0.012,0.62734,-8.29718,
              0.00101097; 0.0121,0.597125,-9.13179,0.000897364; 0.0122,0.564919,
              -9.82427,0.000780251; 0.0123,0.527838,-11.1684,0.000659331;
              0.0124,0.487477,-12.1609,0.000534142; 0.0125,0.436631,-14.9103,
              0.000404205; 0.0126,0.379243,-16.2449,0.000268616; 0.0126134,
              0.371242,-16.2777,0.00025; 0.0126134,0.371242,-16.2777,0.00025;
              0.0126868,0.350822,-16.2554,0.000198624; 0.0126868,0.350822,-16.2554,
              0.000198624; 0.0127,0.351869,-16.3218,0.000199455; 0.0128,0.37695,
              -17.0338,0.000241587; 0.0128157,0.381787,-17.1198,0.00025;
              0.0128157,0.381787,-17.1198,0.00025; 0.0129,0.406591,-17.48,
              0.000292352; 0.013,0.433421,-17.8191,0.000336402; 0.0131,0.457261,
              -17.8337,0.000373609; 0.0132,0.477911,-17.6706,0.000403962;
              0.0133,0.495294,-17.4605,0.00042752; 0.0134,0.509353,-17.3988,
              0.000444358; 0.0135,0.520015,-17.4878,0.0004545; 0.0136,0.527192,
              -17.7433,0.000457911; 0.0136003,0.527207,-17.7443,0.000457911;
              0.0136003,0.527207,-17.7443,0.000457911; 0.0137,0.530748,-18.1997,
              0.000454491; 0.0138,0.530517,-18.8646,0.000444064; 0.0139,
              0.526294,-19.7142,0.000426376; 0.014,0.517828,-20.6871,
              0.000401101; 0.0141,0.504836,-21.6765,0.000367869; 0.0142,
              0.487037,-22.6627,0.000326301; 0.0143,0.464073,-23.4017,
              0.000276025; 0.0143458,0.451744,-23.5657,0.00025; 0.0143458,
              0.451744,-23.5657,0.00025; 0.0144,0.439383,-23.6302,0.000223375;
              0.0144518,0.438001,-23.8106,0.00021654; 0.0144518,0.438001,-23.8106,
              0.00021654; 0.0145,0.442437,-24.0882,0.000220288; 0.0146,0.459291,
              -24.7355,0.000241352; 0.014643,0.466338,-24.9736,0.00025;
              0.014643,0.466338,-24.9736,0.00025; 0.0147,0.47417,-25.2545,
              0.000258795; 0.0148,0.483493,-25.7045,0.000266567; 0.0148288,
              0.485111,-25.8323,0.00026698; 0.0148288,0.485111,-25.8323,
              0.00026698; 0.0149,0.486998,-26.1506,0.000264454; 0.015,0.484444,
              -26.5924,0.000252282; 0.0150127,0.483671,-26.6456,0.00025;
              0.0150127,0.483671,-26.6456,0.00025; 0.0151,0.477935,-26.9803,
              0.000233764; 0.0151954,0.478678,-27.3825,0.000227777; 0.0151954,
              0.478678,-27.3825,0.000227777; 0.0152,0.478896,-27.404,
              0.000227786; 0.0153,0.486112,-27.9096,0.000231723; 0.0154,
              0.494618,-28.4114,0.000237745; 0.0154716,0.499054,-28.7526,
              0.000239402; 0.0154716,0.499054,-28.7526,0.000239402; 0.0155,
              0.500242,-28.8872,0.000239151; 0.0156,0.502893,-29.3755,
              0.000235871; 0.0157,0.505639,-29.8643,0.000232816; 0.0158,
              0.509736,-30.3772,0.000231912; 0.0158118,0.51029,-30.4396,
              0.000231905; 0.0158118,0.51029,-30.4396,0.000231905; 0.0159,
              0.514622,-30.9065,0.000232198; 0.016,0.519654,-31.4343,
              0.000232755; 0.016048,0.521947,-31.6846,0.000232849; 0.016048,
              0.521947,-31.6846,0.000232849; 0.0161,0.524291,-31.9527,
              0.000232753; 0.0162,0.528618,-32.4638,0.000232328; 0.0163,0.53296,
              -32.9726,0.000231976; 0.0164,0.537374,-33.4793,0.000231787;
              0.0165,0.541801,-33.9827,0.000231672; 0.0166,0.546199,-34.4828,
              0.000231561; 0.0167,0.550555,-34.9795,0.000231435; 0.0168,
              0.554875,-35.4729,0.0002313; 0.0169,0.559164,-35.9631,0.000231166;
              0.017,0.56344,-36.4518,0.000231035; 0.0171,0.567726,-36.9417,
              0.000230906; 0.0172,0.571982,-37.4284,0.000230779; 0.0173,
              0.576209,-37.9119,0.000230653; 0.0174,0.580407,-38.3923,
              0.000230528; 0.0175,0.584575,-38.8695,0.000230405; 0.0176,
              0.588716,-39.3436,0.000230284; 0.0177,0.593137,-39.8493,
              0.000230163; 0.0178,0.59757,-40.357,0.000230038; 0.0179,0.601967,
              -40.8716,0.000229911; 0.018,0.60633,-41.3953,0.000229783; 0.0181,
              0.610659,-41.9153,0.000229654; 0.0182,0.614955,-42.4317,
              0.000229526; 0.0183,0.619218,-42.9441,0.0002294; 0.0184,0.623441,
              -43.452,0.000229276; 0.0185,0.627634,-43.9562,0.000229154; 0.0186,
              0.631795,-44.4569,0.000229034; 0.0187,0.635926,-44.954,
              0.000228915; 0.0188,0.640026,-45.4476,0.000228797; 0.0189,
              0.644096,-45.9377,0.000228681; 0.019,0.648136,-46.4242,
              0.000228566; 0.0191,0.652146,-46.9074,0.000228453; 0.0192,
              0.656126,-47.387,0.000228341; 0.0193,0.660077,-47.8633,
              0.000228231; 0.0194,0.663999,-48.3362,0.000228122; 0.0195,
              0.667892,-48.8057,0.000228014; 0.0196,0.671756,-49.2718,
              0.000227908; 0.0197,0.675592,-49.7347,0.000227802; 0.0198,0.67979,
              -50.2404,0.000227697; 0.0199,0.684118,-50.7623,0.000227586; 0.02,
              0.688404,-51.2799,0.000227471; 0.0201,0.692654,-51.7933,
              0.000227355; 0.0202,0.696868,-52.3025,0.000227241; 0.0203,
              0.701047,-52.8002,0.00022713; 0.0204,0.705193,-53.2717,
              0.000227022; 0.0205,0.709307,-53.7394,0.000226918; 0.0206,
              0.713479,-54.2135,0.000226817; 0.0207,0.717635,-54.686,
              0.000226716; 0.0208,0.721755,-55.1544,0.000226615; 0.0209,
              0.725839,-55.619,0.000226515; 0.021,0.729888,-56.0796,0.000226416;
              0.0211,0.733903,-56.5364,0.000226319; 0.0212,0.737883,-56.9893,
              0.000226222; 0.0213,0.741829,-57.4383,0.000226127; 0.0214,
              0.745732,-57.8827,0.000226033; 0.0215,0.749587,-58.3217,
              0.000225941; 0.0216,0.75341,-58.7569,0.00022585; 0.0217,0.757199,
              -59.1885,0.00022576; 0.0218,0.760956,-59.6164,0.000225671; 0.0219,
              0.764681,-60.0407,0.000225583; 0.022,0.768373,-60.4614,
              0.000225497; 0.0221,0.772034,-60.8786,0.000225411; 0.0222,
              0.775663,-61.2922,0.000225326; 0.0223,0.779579,-61.7378,
              0.000225242; 0.0224,0.784355,-62.2802,0.000225151; 0.0225,
              0.789065,-62.8168,0.000225046; 0.0226,0.793716,-63.3474,
              0.000224938; 0.0227,0.798315,-63.8721,0.000224831; 0.0228,
              0.802863,-64.3256,0.000224728; 0.0229,0.80737,-64.7356,
              0.000224637; 0.023,0.811833,-65.1406,0.000224555; 0.0231,0.816247,
              -65.541,0.000224477; 0.0232,0.820611,-65.9369,0.000224399; 0.0233,
              0.824909,-66.3269,0.000224322; 0.0234,0.829106,-66.7079,
              0.000224246; 0.0235,0.833258,-67.0845,0.000224172; 0.0236,
              0.837362,-67.457,0.000224099; 0.0237,0.84142,-67.8252,0.000224027;
              0.0238,0.845433,-68.1893,0.000223957; 0.0239,0.8494,-68.5494,
              0.000223887; 0.024,0.853323,-68.9053,0.000223818; 0.0241,0.857201,
              -69.2573,0.00022375; 0.0242,0.861036,-69.6053,0.000223683; 0.0243,
              0.864828,-69.9494,0.000223617; 0.0244,0.868577,-70.2896,
              0.000223552; 0.0245,0.873541,-70.7381,0.000223484; 0.0246,
              0.878506,-71.1879,0.000223404; 0.0247,0.883389,-71.6312,
              0.00022332; 0.0248,0.888198,-72.0678,0.000223236; 0.0249,0.892935,
              -72.4978,0.000223154; 0.025,0.8976,-72.9212,0.000223074; 0.0251,
              0.902194,-73.2832,0.000222997; 0.0252,0.906729,-73.5797,
              0.00022293; 0.0253,0.911203,-73.8711,0.000222873; 0.0254,0.915611,
              -74.1579,0.00022282; 0.0255,0.919953,-74.4404,0.000222768; 0.0256,
              0.924227,-74.7185,0.000222716; 0.0257,0.928436,-74.9923,
              0.000222665; 0.0258,0.932872,-75.2805,0.000222615; 0.0259,
              0.937419,-75.5759,0.000222563; 0.026,0.941886,-75.8664,
              0.000222509; 0.0261,0.946276,-76.1519,0.000222456; 0.0262,
              0.950592,-76.4326,0.000222404; 0.0263,0.954834,-76.7084,
              0.000222354; 0.0264,0.959005,-76.9795,0.000222304; 0.0265,
              0.963104,-77.246,0.000222255; 0.0266,0.967134,-77.5079,
              0.000222207; 0.0267,0.971094,-77.7654,0.00022216; 0.0268,0.974988,
              -78.0184,0.000222114; 0.0269,0.978815,-78.2671,0.000222068; 0.027,
              0.982577,-78.5115,0.000222024; 0.0271,0.986275,-78.7518,
              0.00022198; 0.0272,0.98991,-78.9879,0.000221937; 0.0273,0.993484,
              -79.2201,0.000221895; 0.0274,0.996996,-79.4482,0.000221854;
              0.0275,1.00082,-79.6845,0.000221813; 0.0276,1.00486,-79.8903,
              0.000221773; 0.0277,1.00883,-80.0919,0.000221735; 0.0278,1.01272,
              -80.2892,0.000221699; 0.0279,1.01653,-80.4824,0.000221665; 0.028,
              1.02026,-80.6717,0.000221631; 0.0281,1.02392,-80.8572,0.000221597;
              0.0282,1.0275,-81.0389,0.000221565; 0.0283,1.03101,-81.2168,
              0.000221533; 0.0284,1.03445,-81.3911,0.000221501; 0.0285,1.03781,
              -81.5619,0.000221471; 0.0286,1.04111,-81.7292,0.000221441; 0.0287,
              1.04434,-81.893,0.000221412; 0.0288,1.04751,-82.0535,0.000221383;
              0.0289,1.05061,-82.2107,0.000221355; 0.029,1.05365,-82.3647,
              0.000221328; 0.0291,1.05663,-82.5155,0.000221301; 0.0292,1.05954,
              -82.6633,0.000221275; 0.0293,1.0624,-82.808,0.000221249; 0.0294,
              1.0652,-82.9498,0.000221224; 0.0295,1.06794,-83.0887,0.000221199;
              0.0296,1.07063,-83.2248,0.000221175; 0.0297,1.07326,-83.3581,
              0.000221151; 0.0298,1.07584,-83.4886,0.000221128; 0.0299,1.07836,
              -83.6165,0.000221106; 0.03,1.08088,-83.7439,0.000221083; 0.0301,
              1.08376,-83.8895,0.000221061; 0.0302,1.08657,-84.0316,0.000221037;
              0.0303,1.08931,-84.1703,0.000221012; 0.0304,1.09198,-84.3057,
              0.000220988; 0.0305,1.09459,-84.4378,0.000220965; 0.0306,1.09714,
              -84.5667,0.000220942; 0.0307,1.09962,-84.6924,0.00022092; 0.0308,
              1.10205,-84.7987,0.000220899; 0.0309,1.10442,-84.8994,0.00022088;
              0.031,1.10673,-84.9975,0.000220862; 0.0311,1.10898,-85.0932,
              0.000220846; 0.0312,1.11119,-85.1866,0.000220829; 0.0313,1.11333,
              -85.2778,0.000220813; 0.0314,1.11543,-85.3668,0.000220798; 0.0315,
              1.11748,-85.4536,0.000220782; 0.0316,1.11947,-85.5382,0.000220768;
              0.0317,1.12142,-85.6209,0.000220753; 0.0318,1.12332,-85.7015,
              0.000220739; 0.0319,1.12518,-85.7802,0.000220725; 0.032,1.12699,-85.857,
              0.000220712; 0.0321,1.12875,-85.9319,0.000220699; 0.0322,1.13048,
              -86.005,0.000220686; 0.0323,1.13216,-86.0763,0.000220673; 0.0324,
              1.1338,-86.1459,0.000220661; 0.0325,1.1354,-86.2138,0.000220649;
              0.0326,1.13696,-86.28,0.000220638; 0.0327,1.13849,-86.3447,
              0.000220627; 0.0328,1.13997,-86.4078,0.000220616; 0.0329,1.14143,
              -86.4693,0.000220605; 0.033,1.14284,-86.5294,0.000220594; 0.0331,
              1.14423,-86.588,0.000220584; 0.0332,1.14558,-86.6452,0.000220574;
              0.0333,1.14689,-86.701,0.000220564; 0.0334,1.14818,-86.7555,
              0.000220555; 0.0335,1.14943,-86.8086,0.000220546; 0.0336,1.15065,
              -86.8605,0.000220537; 0.0337,1.15185,-86.9111,0.000220528; 0.0338,
              1.15301,-86.9605,0.000220519; 0.0339,1.15415,-87.0086,0.000220511;
              0.034,1.15526,-87.0556,0.000220503; 0.0341,1.15634,-87.1015,
              0.000220495; 0.0342,1.1574,-87.1463,0.000220487; 0.0343,1.15843,-87.19,
              0.000220479; 0.0344,1.15943,-87.2326,0.000220472; 0.0345,1.16041,
              -87.2742,0.000220465; 0.0346,1.16137,-87.3148,0.000220458; 0.0347,
              1.16231,-87.3544,0.000220451; 0.0348,1.16322,-87.3931,0.000220444;
              0.0349,1.16411,-87.4308,0.000220438; 0.035,1.16498,-87.4676,
              0.000220431; 0.0351,1.16582,-87.5035,0.000220425; 0.0352,1.16665,
              -87.5385,0.000220419; 0.0353,1.16746,-87.5727,0.000220413; 0.0354,
              1.16824,-87.6061,0.000220407; 0.0355,1.16901,-87.6386,0.000220402;
              0.0356,1.16976,-87.6704,0.000220396; 0.0357,1.17049,-87.7014,
              0.000220391; 0.0358,1.17121,-87.7316,0.000220386; 0.0359,1.1719,-87.7612,
              0.00022038; 0.036,1.17258,-87.79,0.000220375; 0.0361,1.17325,-87.8181,
              0.000220371; 0.0362,1.1739,-87.8455,0.000220366; 0.0363,1.17453,-87.8722,
              0.000220361; 0.0364,1.17514,-87.8984,0.000220357; 0.0365,1.17574,
              -87.9238,0.000220352; 0.0366,1.17633,-87.9487,0.000220348; 0.0367,
              1.1769,-87.9729,0.000220344; 0.0368,1.17746,-87.9966,0.00022034;
              0.0369,1.17801,-88.0197,0.000220336; 0.037,1.17858,-88.0441,
              0.000220332; 0.0371,1.17922,-88.0712,0.000220328; 0.0372,1.17985,
              -88.0975,0.000220323; 0.0373,1.18045,-88.123,0.000220319; 0.0374,
              1.18103,-88.1477,0.000220314; 0.0375,1.1816,-88.1717,0.00022031;
              0.0376,1.18215,-88.195,0.000220306; 0.0377,1.18268,-88.2176,
              0.000220302; 0.0378,1.1832,-88.2395,0.000220299; 0.0379,1.1837,-88.2607,
              0.000220295; 0.038,1.18419,-88.2814,0.000220291; 0.0381,1.18466,-88.3014,
              0.000220288; 0.0382,1.18512,-88.3208,0.000220284; 0.0383,1.18556,
              -88.3396,0.000220281; 0.0384,1.18599,-88.3578,0.000220278; 0.0385,
              1.18641,-88.3756,0.000220275; 0.0386,1.18682,-88.3928,0.000220272;
              0.0387,1.18721,-88.4094,0.000220269; 0.0388,1.18759,-88.4256,
              0.000220266; 0.0389,1.18796,-88.4413,0.000220264; 0.039,1.18832,-88.4565,
              0.000220261; 0.0391,1.18867,-88.4713,0.000220258; 0.0392,1.18901,
              -88.4856,0.000220256; 0.0393,1.18934,-88.4995,0.000220253; 0.0394,
              1.18965,-88.513,0.000220251; 0.0395,1.18996,-88.5261,0.000220249;
              0.0396,1.19026,-88.5388,0.000220247; 0.0397,1.19055,-88.5511,
              0.000220245; 0.0398,1.19084,-88.563,0.000220242; 0.0399,1.19111,-88.5746,
              0.00022024; 0.04,1.19137,-88.5859,0.000220239; 0.0401,1.19163,-88.5968,
              0.000220237; 0.0402,1.19188,-88.6074,0.000220235; 0.0403,1.19212,
              -88.6176,0.000220233; 0.0404,1.19236,-88.6276,0.000220231; 0.0405,
              1.19259,-88.6373,0.00022023; 0.0406,1.19281,-88.6466,0.000220228;
              0.0407,1.19302,-88.6557,0.000220226; 0.0408,1.19323,-88.6646,
              0.000220225; 0.0409,1.19343,-88.6731,0.000220223; 0.041,1.19363,-88.6814,
              0.000220222; 0.0411,1.19382,-88.6895,0.000220221; 0.0412,1.19401,
              -88.6973,0.000220219; 0.0413,1.19418,-88.7049,0.000220218; 0.0414,
              1.19436,-88.7122,0.000220217; 0.0415,1.19453,-88.7194,0.000220215;
              0.0416,1.19469,-88.7263,0.000220214; 0.0417,1.19485,-88.733,
              0.000220213; 0.0418,1.195,-88.7395,0.000220212; 0.0419,1.19515,-88.7459,
              0.000220211; 0.042,1.1953,-88.752,0.00022021; 0.0421,1.19544,-88.7579,
              0.000220209; 0.0422,1.19557,-88.7637,0.000220208; 0.0423,1.19571,
              -88.7693,0.000220207; 0.0424,1.19583,-88.7747,0.000220206; 0.0425,
              1.19596,-88.78,0.000220205; 0.0426,1.19608,-88.7851,0.000220204;
              0.0427,1.1962,-88.7901,0.000220203; 0.0428,1.19631,-88.7949,
              0.000220202; 0.0429,1.19642,-88.7996,0.000220202; 0.043,1.19653,-88.8041,
              0.000220201; 0.0431,1.19663,-88.8085,0.0002202; 0.0432,1.19673,-88.8127,
              0.000220199; 0.0433,1.19683,-88.8169,0.000220199; 0.0434,1.19692,
              -88.8209,0.000220198; 0.0435,1.19702,-88.8248,0.000220197; 0.0436,
              1.1971,-88.8286,0.000220197; 0.0437,1.19719,-88.8322,0.000220196;
              0.0438,1.19728,-88.8358,0.000220195; 0.0439,1.19736,-88.8392,
              0.000220195; 0.044,1.19744,-88.8426,0.000220194; 0.0441,1.19751,-88.8458,
              0.000220194; 0.0442,1.19759,-88.8489,0.000220193; 0.0443,1.19766,
              -88.852,0.000220192; 0.0444,1.19773,-88.855,0.000220192; 0.0445,
              1.1978,-88.8578,0.000220191; 0.0446,1.19786,-88.8606,0.000220191;
              0.0447,1.19793,-88.8633,0.000220191; 0.0448,1.19799,-88.8659,
              0.00022019; 0.0449,1.19805,-88.8685,0.00022019; 0.045,1.19811,-88.871,
              0.000220189; 0.0451,1.19816,-88.8734,0.000220189; 0.0452,1.19822,
              -88.8757,0.000220188; 0.0453,1.19827,-88.8779,0.000220188; 0.0454,
              1.19832,-88.8801,0.000220188; 0.0455,1.19837,-88.8822,0.000220187;
              0.0456,1.19842,-88.8843,0.000220187; 0.0457,1.19847,-88.8863,
              0.000220187; 0.0458,1.19851,-88.8882,0.000220186; 0.0459,1.19856,
              -88.8901,0.000220186; 0.046,1.1986,-88.8919,0.000220186; 0.0461,
              1.19864,-88.8937,0.000220185; 0.0462,1.19868,-88.8954,0.000220185;
              0.0463,1.19872,-88.897,0.000220185; 0.0464,1.19876,-88.8987,
              0.000220184; 0.0465,1.1988,-88.9002,0.000220184; 0.0466,1.19883,-88.9017,
              0.000220184; 0.0467,1.19887,-88.9032,0.000220184; 0.0468,1.1989,-88.9046,
              0.000220183; 0.0469,1.19893,-88.906,0.000220183; 0.047,1.19897,-88.9074,
              0.000220183; 0.0471,1.199,-88.9087,0.000220183; 0.0472,1.19903,-88.91,
              0.000220182; 0.0473,1.19906,-88.9112,0.000220182; 0.0474,1.19908,
              -88.9124,0.000220182; 0.0475,1.19911,-88.9135,0.000220182; 0.0476,
              1.19914,-88.9146,0.000220182; 0.0477,1.19916,-88.9157,0.000220181;
              0.0478,1.19919,-88.9168,0.000220181; 0.0479,1.19921,-88.9178,
              0.000220181; 0.048,1.19924,-88.9188,0.000220181; 0.0481,1.19926,-88.9198,
              0.000220181; 0.0482,1.19928,-88.9207,0.000220181; 0.0483,1.1993,-88.9216,
              0.00022018; 0.0484,1.19932,-88.9225,0.00022018; 0.0485,1.19934,-88.9233,
              0.00022018; 0.0486,1.19936,-88.9242,0.00022018; 0.0487,1.19938,-88.925,
              0.00022018; 0.0488,1.1994,-88.9258,0.00022018; 0.0489,1.19942,-88.9265,
              0.00022018; 0.049,1.19944,-88.9273,0.000220179; 0.0491,1.19945,-88.928,
              0.000220179; 0.0492,1.19947,-88.9287,0.000220179; 0.0493,1.19948,
              -88.9293,0.000220179; 0.0494,1.1995,-88.93,0.000220179; 0.0495,
              1.19951,-88.9306,0.000220179; 0.0496,1.19953,-88.9312,0.000220179;
              0.0497,1.19954,-88.9318,0.000220179; 0.0498,1.19956,-88.9324,
              0.000220179; 0.0499,1.19957,-88.933,0.000220178; 0.05,1.19958,-88.9335,
              0.000220178; 0.05,1.19958,-88.9335,0.000220178],
          tableOnFile=false,
          columns=2:4,
          extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
          "Valid for u_source=12VDC and m_load=0.01kg only; column 2: current, col.3: force, col.4: position"
          annotation (Placement(transformation(extent={{-40,60},{-20,80}},
              rotation=0)));

      equation
        connect(advancedGround.p, advancedSource.n)
          annotation (Line(points={{-60,10},{-60,20}}, color={0,0,255}));
        connect(advancedSource.p, advancedSolenoid.p)
          annotation (Line(points={{-60,40},{-40,40},{-40,36},{-20,36}}, color=
              {0,0,255}));
        connect(advancedSolenoid.n, advancedSource.n)
          annotation (Line(points={{-20,24},{-40,24},{-40,20},{-60,20}}, color=
              {0,0,255}));
        connect(advancedSolenoid.flange, advancedLoad.flange_a)
          annotation (Line(points={{0,30},{20,30}}, color={0,127,0}));
        connect(simpleGround.p, simpleSource.n)
          annotation (Line(points={{-60,-70},{-60,-60}}, color={0,0,255}));
        connect(simpleSource.p, simpleSolenoid.p)
          annotation (Line(points={{-60,-40},{-40,-40},{-40,-44},{-20,-44}},
            color={0,0,255}));
        connect(simpleSolenoid.n, simpleSource.n)
          annotation (Line(points={{-20,-56},{-40,-56},{-40,-60},{-60,-60}},
            color={0,0,255}));
        connect(simpleSolenoid.flange, simpleLoad.flange_a)
          annotation (Line(points={{0,-50},{20,-50}}, color={0,127,0}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
                {{-100,-100},{100,100}}),
                            graphics),                             experiment(StopTime=
                0.05, Tolerance=1e-007),
          Documentation(info="<html>
<p>
Have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator\">SolenoidActuator</a> for general comments and at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.SimpleSolenoid\">SimpleSolenoid</a> and <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.AdvancedSolenoid\">AdvancedSolenoid</a> for a detailed description of both magnetic network models.
</p>

<p>
A voltage step is applied to both solenoid models at time t=0. The armatures of both models and therewith connected loads are pulled from their rest position at maximum air gap length to their minimum position that is due to a stopper. As a reference, simulation results obtained with a dynamic model based on stationary FEA look-up tables (not part of this library) are included. Note that these reference results are valid for the default supply voltage v_step=12V DC and the default load mass m_load=0.01kg only!
</p>

<p>
Set the <b>tolerance</b> to <b>1e-7</b> and <b>simulate for 0.05 s</b>. Plot actuator current, force and position of the two magnetic network models and the FEA-based reference <b>vs. time</b> (each quantity in one common plot window):
</p>

<pre>
Plot window for current:
    simpleSolenoid.p.i          // rapid current rise indicates low inductance of simple network model
    advancedSolenoid.p.i        // current rise slower, better match with FEA reference
    comparisonWithFEA.y[1]      // current obtained from dynamic model based on stationary FEA look-up tables

Plot window for force:
    simpleSolenoid.armature.flange_a.f       // reluctance force of simple actuator model
    advancedSolenoid.armature.flange_a.f     // reluctance force of advanced actuator model
    comparisonWithFEA.y[2]      // force obtained from dynamic model based on stationary FEA look-up tables

Plot window for position:
    simpleSolenoid.x            // armature position of simple actuator model
    advancedSolenoid.x          // armature position of advanced actuator model
    comparisonWithFEA.y[3]      // position obtained from dynamic model based on stationary FEA look-up tables
</pre>

<p>
The characteristic current drop during pull-in is due to both armature motion and increasing inductance with decreasing air gap length. Bouncing occurs when  armature and load of each model arrive at the stopper at minimum position. Although the pull-in times of the two magnetic network models are relatively close to the time obtained with the reference model, the accuracy of the advanced solenoid model is better, as one can tell from a comparison of the current rise at the beginning of the stroke.
</p>

</html>"));
      end ComparisonPullInStroke;

      package Components "Components to be used in examples"
       extends Modelica.Icons.Package;

        model SimpleSolenoid
          "Simple network model of a lifting magnet with planar armature end face"

          parameter SI.Resistance R = 10 "Armature coil resistance";
          parameter Real N = 957 "Number of turns";

        //yoke
          parameter SI.Radius r_yokeOut = 15e-3 "Outer yoke radius";
          parameter SI.Radius r_yokeIn = 13.5e-3 "Inner yoke radius";
          parameter SI.Length l_yoke = 35e-3 "Axial yoke length";
          parameter SI.Length t_yokeBot = 3.5e-3
            "Axial thickness of yoke bottom";

        //pole
          parameter SI.Length l_pole = 6.5e-3 "Axial length of pole";
          parameter SI.Length t_poleBot = 3.5e-3
            "Axial thickness of bottom at pole side";

          parameter SI.Length t_airPar = 0.65e-3
            "Radial thickness of parasitic air gap due to slide guiding";

          parameter Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData
            material=
            Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.Steel.Steel_9SMnPb28()
            "Ferromagnetic material characteristics"
            annotation(choicesAllMatching=true, Dialog(group="Material"));

        //armature
          parameter SI.Radius r_arm = 5e-3 "Armature radius = pole radius" annotation(Dialog(group="Armature and stopper"));
          parameter SI.Length l_arm = 26e-3 "Armature length" annotation(Dialog(group="Armature and stopper"));
          parameter Modelica.SIunits.TranslationalSpringConstant c=
                1e11 "Spring stiffness between impact partners" annotation(Dialog(group="Armature and stopper"));
          parameter Modelica.SIunits.TranslationalDampingConstant d=
                400 "Damping coefficient between impact partners"   annotation(Dialog(group="Armature and stopper"));
          parameter SI.Position x_min = 0.25e-3
            "Stopper at minimum armature position"                                     annotation(Dialog(group="Armature and stopper"));
          parameter SI.Position x_max = 5e-3
            "Stopper at maximum armature position"                                  annotation(Dialog(group="Armature and stopper"));

          SI.Position x(start=x_max, stateSelect=StateSelect.prefer)
            "Armature position, alias for flange position (identical with length of working air gap)";

        protected
          parameter SI.Density rho_steel = 7853
            "Density for calculation of armature mass from geometry";

        public
          Modelica.Magnetic.FluxTubes.Basic.Ground ground
            annotation (Placement(transformation(extent={{50,10},{70,30}},
                rotation=0)));
          Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter coil(
                                        final N=N, i(fixed=true))
            "Electro-magnetic converter"
            annotation (Placement(transformation(
              origin={0,20},
              extent={{-10,-10},{10,10}},
              rotation=90)));
          Modelica.Electrical.Analog.Basic.Resistor r(final R=R)
            "Coil resistance"
            annotation (Placement(transformation(extent={{-70,-30},{-50,-10}},
                rotation=0)));
          Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
            g_mFeYokeSide(
            final nonLinearPermeability=true,
            final material=material,
            final l=l_yoke - (t_poleBot + t_yokeBot)/2,
            final r_i=r_yokeIn,
            final r_o=r_yokeOut)
            "Permeance of of hollow cylindric section of ferromagnetic yoke"
            annotation (Placement(transformation(extent={{-10,80},{10,100}},
                rotation=0)));

          Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
            g_mFeArm(
            final nonLinearPermeability=true,
            final material=material,
            final l=l_yoke - (t_yokeBot + t_poleBot)/2 - l_pole - (x_max +
                x_min)/2,
            final r_i=0,
            final r_o=r_arm) "Permeance of ferfomagnetic armature"
            annotation (Placement(transformation(
              origin={16,40},
              extent={{-10,-10},{10,10}},
              rotation=180)));

          Modelica.Magnetic.FluxTubes.Shapes.Force.HollowCylinderAxialFlux
            g_mAirWork(
            final mu_r=1,
            final dlBydx=1,
            final r_i=0,
            final r_o=r_arm,
            final useSupport=false,
            final l=flange.s)
            "Permeance of working air gap (between armature and pole end faces)"
            annotation (Placement(transformation(
              origin={-30,30},
              extent={{-10,10},{10,-10}},
              rotation=180)));
          Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux
            g_mFeYokeBot(
            final nonLinearPermeability=true,
            final material=material,
            final l=t_yokeBot,
            final r_i=r_arm + t_airPar,
            final r_o=r_yokeIn)
            "Permeance of bottom side of ferromagnetic yoke"
            annotation (Placement(transformation(
              origin={80,80},
              extent={{-10,-10},{10,10}},
              rotation=90)));

          Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux
            g_mAirPar(
            final nonLinearPermeability=false,
            final mu_rConst=1,
            final l=t_yokeBot,
            final r_i=r_arm,
            final r_o=r_arm + t_airPar)
            "Permeance of parasitic radial air gap due to slide guiding"
            annotation (Placement(transformation(
              origin={80,50},
              extent={{-10,-10},{10,10}},
              rotation=90)));
          Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux
            g_mFePoleBot(
            final l=t_poleBot,
            final r_i=r_arm,
            final r_o=r_yokeIn,
            final nonLinearPermeability=true,
            final material=material) "Permeance of bottom side of pole"
            annotation (Placement(transformation(
              origin={-72,80},
              extent={{-10,-10},{10,10}},
              rotation=90)));

          Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
            g_mFePole(
            final nonLinearPermeability=true,
            final material=material,
            final l=l_pole,
            final r_i=0,
            final r_o=r_arm) "Permeance of ferromagnetic pole"
            annotation (Placement(transformation(
              origin={-72,40},
              extent={{10,-10},{-10,10}},
              rotation=270)));

          Modelica.Magnetic.FluxTubes.Examples.Utilities.TranslatoryArmatureAndStopper
            armature(
            final m=rho_steel*l_arm*pi*r_arm^2,
            final x_max=x_max,
            final x_min=x_min,
            final L=0,
            final c=c,
            final d=d,
            n=2,
          v(fixed=true))
            "Inertia of armature and stoppers at end of stroke range"
                                      annotation (Placement(transformation(
                extent={{64,-10},{84,10}}, rotation=0)));
          Modelica.Magnetic.FluxTubes.Shapes.Leakage.QuarterCylinder g_mLeak1(
            l=2*pi*(r_arm +t_airPar/2))
            "Leakage pereance between inner edge of yoke bore and armature side face"
            annotation (Placement(transformation(
              origin={60,50},
              extent={{-10,-10},{10,10}},
              rotation=90)));
          Modelica.Magnetic.FluxTubes.Shapes.Leakage.QuarterHollowCylinder
            g_mLeak2(
              final l=2*pi*r_arm, final ratio=8)
            "Leakage permeance between inner side of yoke bottom and armature side (r_i = t_airPar)"
            annotation (Placement(transformation(
              origin={40,50},
              extent={{-10,-10},{10,10}},
              rotation=90)));
          Modelica.Magnetic.FluxTubes.Shapes.Force.LeakageAroundPoles
            g_mLeakWork(
            final mu_r=1,
            final dlBydx=1,
            final w=2*pi*(r_arm + 0.0015),
            final r=0.003,
            final l=flange.s,
            final useSupport=false)
            "Permeance of leakage air gap around working air gap (between armature and pole side faces)"
            annotation (Placement(transformation(
              origin={-30,70},
              extent={{-10,10},{10,-10}},
              rotation=180)));
          Modelica.Electrical.Analog.Interfaces.PositivePin p
            "Electrical connector"
            annotation (Placement(transformation(extent={{-110,50},{-90,70}},
                rotation=0)));
          Modelica.Electrical.Analog.Interfaces.NegativePin n
            "Electrical connector"
            annotation (Placement(transformation(extent={{-90,-70},{-110,-50}},
                rotation=0)));
          Modelica.Mechanics.Translational.Interfaces.Flange_b flange
            "Flange of component"
            annotation (Placement(transformation(extent={{90,-10},{110,10}},
                rotation=0)));
        equation
          x = flange.s;
          connect(r.p, p)      annotation (Line(points={{-70,-20},{-90,-20},{
                -90,60},{-100,60}}, color={0,0,255}));
          connect(armature.flange_b, flange)     annotation (Line(points={{84,0},
                {88,0},{88,1.16573e-015},{92,1.16573e-015},{92,0},{100,0}},
              color={0,127,0}));
          connect(armature.flange_a,g_mAirWork. flange) annotation (Line(points=
               {{64,0},{34,0},{34,52},{-30,52},{-30,40}}, color={0,127,0}));
          connect(g_mAirWork.flange,g_mLeakWork. flange)
                                                     annotation (Line(points={{
                -30,40},{-30,52},{34,52},{34,80},{-30,80}}, color={0,127,0}));
          connect(r.n, coil.p) annotation (Line(points={{-50,-20},{-6,-20},{-6,
                10}}, color={0,0,255}));
          connect(coil.n, n) annotation (Line(points={{6,10},{6,-60},{-100,-60}},
              color={0,0,255}));
          connect(coil.port_p, g_mAirWork.port_p) annotation (Line(points={{-6,30},
                {-20,30}},     color={255,127,0}));
          connect(g_mAirWork.port_p, g_mLeakWork.port_p) annotation (Line(
              points={{-20,30},{-20,70}}, color={255,127,0}));
          connect(g_mAirWork.port_n, g_mLeakWork.port_n) annotation (Line(
              points={{-40,30},{-40,70}}, color={255,127,0}));
          connect(g_mFePole.port_p, g_mAirWork.port_n) annotation (Line(points=
                {{-72,30},{-40,30}}, color={255,127,0}));
          connect(g_mFePoleBot.port_p, g_mFePole.port_n) annotation (Line(
              points={{-72,70},{-72,50}}, color={255,127,0}));
          connect(g_mFePoleBot.port_n, g_mFeYokeSide.port_p) annotation (Line(
              points={{-72,90},{-10,90}}, color={255,127,0}));
          connect(g_mFeYokeSide.port_n, g_mFeYokeBot.port_n) annotation (Line(
              points={{10,90},{80,90}}, color={255,127,0}));
          connect(g_mFeYokeBot.port_p, g_mAirPar.port_n) annotation (Line(
              points={{80,70},{80,60}}, color={255,127,0}));
          connect(g_mFeArm.port_p, g_mLeak2.port_p) annotation (Line(points={{
                26,40},{40,40}}, color={255,127,0}));
          connect(g_mLeak2.port_p, g_mLeak1.port_p) annotation (Line(points={{
                40,40},{60,40}}, color={255,127,0}));
          connect(g_mLeak1.port_p, g_mAirPar.port_p) annotation (Line(points={{
                60,40},{80,40}}, color={255,127,0}));
          connect(g_mLeak2.port_n, g_mLeak1.port_n) annotation (Line(points={{
                40,60},{60,60}}, color={255,127,0}));
          connect(g_mLeak1.port_n, g_mAirPar.port_n) annotation (Line(points={{
                60,60},{80,60}}, color={255,127,0}));
          connect(g_mFeArm.port_n, coil.port_n) annotation (Line(points={{6,40},{
                6,35},{6,30},{6,30}},  color={255,127,0}));
        connect(ground.port, g_mLeak1.port_p) annotation (Line(
            points={{60,30},{60,40}},
            color={255,127,0},
            smooth=Smooth.None));
          annotation (__Dymola_Images(Parameters(source=
                    "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/SolenoidActuator/Solenoid_dimensions.png")),
            Window(
              x=0.16,
              y=0.15,
              width=0.6,
              height=0.6),
            Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={
              Rectangle(
                extent={{-90,100},{90,-100}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,-30},{-4,30}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-40,-30},{-90,30}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-80,-100},{-90,100}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,90},{-90,100}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,-100},{-90,-90}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,40},{80,100}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,-100},{80,-40}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-70,80},{70,40}},
                lineColor={255,213,170},
                fillColor={255,213,170},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-70,-40},{70,-80}},
                lineColor={255,213,170},
                fillColor={255,213,170},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{0,160},{0,120}},
                lineColor={0,0,255},
                textString="%name")}),
            Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics),
          Documentation(info="<html>
<p>
Please refer to the <b>Parameters</b> section for a schematic drawing of this axisymmetric lifting magnet.
In the half-section below, the flux tube elements of the actuator's magnetic circuit are superimposed on a field plot obtained with FEA. The magnetomotive force imposed by the coil is modelled as one lumped element. As a result, the radial leakage flux between armature and yoke that occurs especially at large working air gaps can not be considered properly. This leads to a a higher total reluctance and lower inductance respectively compared to FEA for large working air gaps (i.e., armature close to x_max). Please have a look at the comments associated with the individual model components for a short explanation of their purpose in the model.
</p>

<IMG src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/SolenoidActuator/SimpleSolenoidModel_fluxTubePartitioning.png\" ALT=\"Field lines and assigned flux tubes of the simple solenoid model\">

<p>
The coupling coefficient c_coupl in the coil is set to 1 in this example, since leakage flux is accounted for explicitly with the flux tube element G_mLeakWork. Although this leakage model is rather simple, it describes the reluctance force due to the leakage field sufficiently, especially at large air gaps. With decreasing air gap length, the influence of the leakage flux on the actuator's net reluctance force decreases due to the increasing influence of the main working air gap G_mAirWork.
</p>

<p>
During model-based actuator design, the radii and lengths of the flux tube elements (and hence their cross-sectional areas and flux densities) should be assigned with parametric equations so that common design rules are met (e.g., allowed flux density in ferromagnetic parts, allowed current density and required cross-sectional area of winding). For simplicity, those equations are omitted in the example. Instead, the found values are assigned to the model elements directly.
</p>
</html>"));
        end SimpleSolenoid;

        model AdvancedSolenoid
          "Advanced network model of a lifting magnet with planar armature end face, split magnetomotive force"

          parameter Real N = 957 "Number of turns";
          parameter SI.Resistance R = 5 "Coil resistance";
          parameter SI.Resistance R_par = 1e5
            "Resistance parallel to the coil, in series to C_par";
          parameter SI.Capacitance C_par = 1e-9
            "Capacitance parallel to the coil, in series to R_par";

        //yoke
          parameter SI.Radius r_yokeOut = 15e-3 "Outer yoke radius";
          parameter SI.Radius r_yokeIn = 13.5e-3 "Inner yoke radius";
          parameter SI.Length l_yoke = 35e-3 "Axial yoke length";
          parameter SI.Length t_yokeBot = 3.5e-3
            "Axial thickness of yoke bottom";

        //pole
          parameter SI.Length l_pole = 6.5e-3 "Axial length of pole";
          parameter SI.Length t_poleBot = 3.5e-3
            "Axial thickness of bottom at pole side";

          parameter SI.Length t_airPar = 0.65e-3
            "Radial thickness of parasitic air gap due to slide guiding";

          parameter Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData
            material=
            Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.Steel.Steel_9SMnPb28()
            "Ferromagnetic material characteristics"
            annotation(choicesAllMatching=true, Dialog(group="Material"));

        //armature
          parameter SI.Radius r_arm = 5e-3 "Armature radius = pole radius" annotation(Dialog(group="Armature and stopper"));
          parameter SI.Length l_arm = 26e-3 "Armature length" annotation(Dialog(group="Armature and stopper"));
          parameter Modelica.SIunits.TranslationalSpringConstant c=
                1e11 "Spring stiffness between impact partners"
            annotation(Dialog(group="Armature and stopper"));
          parameter Modelica.SIunits.TranslationalDampingConstant d=
                400 "Damping coefficient between impact partners"
            annotation(Dialog(group="Armature and stopper"));
          parameter SI.Position x_min = 0.25e-3
            "Stopper at minimum armature position"                                     annotation(Dialog(group="Armature and stopper"));
          parameter SI.Position x_max = 5e-3
            "Stopper at maximum armature position"                                  annotation(Dialog(group="Armature and stopper"));

          SI.Position x(start=x_max, stateSelect=StateSelect.prefer)
            "Armature position";

          SI.MagneticFlux Psi_tot "Total flux linkage for information only";
          SI.Inductance L_statTot
            "Total static inductance for information only";

        protected
          parameter SI.Density rho_steel = 7853
            "Density for calculation of armature mass from geometry";

        public
          Modelica.Magnetic.FluxTubes.Basic.Ground ground
            annotation (Placement(transformation(extent={{42,2},{62,22}},
                rotation=0)));
          Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter coil1(
                                         final N=N/2, i(fixed=true))
            "Electro-magnetic conversion in first half of coil"
            annotation (Placement(transformation(
              origin={-46,20},
              extent={{-10,-10},{10,10}},
              rotation=90)));
          Modelica.Electrical.Analog.Basic.Resistor r_1(final R=R)
            "Resistance of first half of coil"
            annotation (Placement(transformation(extent={{-84,-30},{-64,-10}},
                rotation=0)));
          Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
            g_mFeYokeSide1(
            final l=l_yoke/2 - t_poleBot/2,
            final r_i=r_yokeIn,
            final r_o=r_yokeOut,
            final nonLinearPermeability=true,
            final material=material)
            "Permeance of of first half of yoke's hollow cylindric section"
            annotation (Placement(transformation(extent={{-50,70},{-30,90}},
                rotation=0)));

          Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
            g_mFeArm(
            final r_i=0,
            final l=l_yoke - (t_yokeBot + t_poleBot)/2 - l_pole - (x_max + x_min)/2,
            final r_o=r_arm,
            final nonLinearPermeability=true,
            final material=material) "Permeance of ferfomagnetic armature"
            annotation (Placement(transformation(
              origin={10,30},
              extent={{-10,10},{10,-10}},
              rotation=180)));

          Modelica.Magnetic.FluxTubes.Shapes.Force.HollowCylinderAxialFlux
            g_mAirWork(
            final r_o=r_arm,
            final useSupport=false,
            final mu_r=1,
            final dlBydx=1,
            final r_i=0,
            final l=flange.s)
            "Permeance of working air gap (between armature and pole end faces)"
            annotation (Placement(transformation(
              origin={-20,30},
              extent={{-10,10},{10,-10}},
              rotation=180)));
          Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux
            g_mFeYokeBot(
            final l=t_yokeBot,
            final r_i=r_arm + t_airPar,
            final r_o=r_yokeIn,
            final nonLinearPermeability=true,
            final material=material)
            "Permeance of bottom side of ferromagnetic yoke"
            annotation (Placement(transformation(
              origin={74,70},
              extent={{-10,-10},{10,10}},
              rotation=90)));

          Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux
            g_mAirPar(
            final l=t_yokeBot,
            final r_i=r_arm,
            final r_o=r_arm + t_airPar,
            final nonLinearPermeability=false,
            final mu_rConst=1)
            "Permeance of parasitic radial air gap due to slide guiding"
            annotation (Placement(transformation(
              origin={74,40},
              extent={{-10,-10},{10,10}},
              rotation=90)));
          Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux
            g_mFePoleBot(
            final l=t_poleBot,
            final r_i=r_arm,
            final r_o=r_yokeIn,
            final nonLinearPermeability=true,
            final material=material) "Permeance of bottom side of pole"
            annotation (Placement(transformation(
              origin={-78,56},
              extent={{-10,-10},{10,10}},
              rotation=90)));

          Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
            g_mFePole(
            final l=l_pole,
            final r_o=r_arm,
            final nonLinearPermeability=true,
            final material=material) "Permeance of ferromagnetic pole"
            annotation (Placement(transformation(
              origin={-68,30},
              extent={{-10,10},{10,-10}},
              rotation=180)));

          Modelica.Magnetic.FluxTubes.Examples.Utilities.TranslatoryArmatureAndStopper
            armature(
            final x_max=x_max,
            final x_min=x_min,
            final m=rho_steel*l_arm*pi*r_arm^2,
            final L=0,
            final c=c,
            final d=d,
            n=2,
          v(fixed=true))
            "Inertia of armature and stoppers at end of stroke range"
                                      annotation (Placement(transformation(
                extent={{64,-10},{84,10}}, rotation=0)));
          Modelica.Magnetic.FluxTubes.Shapes.Leakage.QuarterCylinder g_mLeak1(
            final l=2*pi*(r_arm +t_airPar/2))
            "Leakage pereance between inner edge of yoke bore and armature side face"
            annotation (Placement(transformation(
              origin={60,40},
              extent={{-10,-10},{10,10}},
              rotation=90)));
          Modelica.Magnetic.FluxTubes.Shapes.Leakage.QuarterHollowCylinder
            g_mLeak2(
            final ratio=8,
            final l=2*pi*r_arm)
            "Leakage permeance between inner side of yoke bottom and armature side (r_i = t_airPar)"
                             annotation (Placement(transformation(
              origin={46,40},
              extent={{-10,-10},{10,10}},
              rotation=90)));
          Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter coil2(
            final N=N/2, i(fixed=true))
            "Electro-magnetic conversion in first half of coil"
            annotation (Placement(transformation(
              origin={30,20},
              extent={{-10,-10},{10,10}},
              rotation=90)));
          Modelica.Electrical.Analog.Basic.Capacitor c_par1(final C=C_par, v(start=
                0, fixed=true))
            "Parasitic capacitance assigned to first half of coil"
            annotation (Placement(transformation(extent={{-60,-50},{-40,-30}},
                rotation=0)));
          Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux
            G_mLeakRad(
            final mu_rConst=1,
            final r_i=r_arm,
            final r_o=r_yokeIn,
            final l=l_yoke/4,
            final nonLinearPermeability=false)
            "Permeance of radial leakage flux tube between armature side and yoke side"
            annotation (Placement(transformation(
              origin={0,56},
              extent={{-10,-10},{10,10}},
              rotation=90)));
          Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
            g_mFeYokeSide2(
            final l=l_yoke/2 - t_yokeBot/2,
            final r_i=r_yokeIn,
            r_o=r_yokeOut,
            final nonLinearPermeability=true,
            final material=material)
            "Permeance of of second half of yoke's hollow cylindric section"
            annotation (Placement(transformation(extent={{20,70},{40,90}},
                rotation=0)));

          Modelica.Electrical.Analog.Basic.Capacitor c_par2(final C=C_par, v(start=
                0, fixed=true))
            "Parasitic capacitance assigned to second half of coil"
            annotation (Placement(transformation(extent={{16,-50},{36,-30}},
                rotation=0)));
          Modelica.Electrical.Analog.Basic.Resistor r_par1(final R=R_par)
            "Parasitic resistance assigned to first half of coil"
            annotation (Placement(transformation(extent={{-84,-50},{-64,-30}},
                rotation=0)));
          Modelica.Electrical.Analog.Basic.Resistor r_par2(final R=R_par)
            "Parasitic resistance assigned to second half of coil"
            annotation (Placement(transformation(extent={{-8,-50},{12,-30}},
                rotation=0)));
          Modelica.Electrical.Analog.Basic.Resistor r_2(final R=R)
            "Resistance of second half of coil"
            annotation (Placement(transformation(extent={{-8,-30},{12,-10}},
                rotation=0)));
          Modelica.Magnetic.FluxTubes.Shapes.Leakage.QuarterCylinder g_mLeak3(
            final l=2*pi*(r_arm + t_airPar/2))
            "Leakage pereance between outer edge of yoke bore and armature side face"
            annotation (Placement(transformation(
              origin={88,40},
              extent={{-10,-10},{10,10}},
              rotation=90)));
          Modelica.Magnetic.FluxTubes.Shapes.Force.LeakageAroundPoles
            g_mLeakWork(
            final w=2*pi*(r_arm + 0.0015),
            final r=0.003,
            final useSupport=false,
            final mu_r=1,
            final dlBydx=1,
            final l=flange.s)
            "Permeance of leakage air gap around working air gap (between armature and pole side faces)"
            annotation (Placement(transformation(
              origin={-20,64},
              extent={{-10,10},{10,-10}},
              rotation=180)));
          Modelica.Electrical.Analog.Interfaces.PositivePin p
            "Electrical connector"
            annotation (Placement(transformation(extent={{-110,50},{-90,70}},
                rotation=0)));
          Modelica.Electrical.Analog.Interfaces.NegativePin n
            "Electrical connector"
            annotation (Placement(transformation(extent={{-90,-70},{-110,-50}},
                rotation=0)));
          Modelica.Mechanics.Translational.Interfaces.Flange_b flange
            "Flange of component"
            annotation (Placement(transformation(extent={{90,-10},{110,10}},
                rotation=0)));
        equation
          x = flange.s;
          Psi_tot = coil1.Psi + coil2.Psi;
          L_statTot = coil1.L_stat + coil2.L_stat;
          connect(armature.flange_b, flange)     annotation (Line(points={{84,0},
                {88,0},{88,1.16573e-015},{92,1.16573e-015},{92,0},{100,0}},
              color={0,127,0}));
          connect(r_par1.n,c_par1. p)
                                   annotation (Line(points={{-64,-40},{-60,-40}},
              color={0,0,255}));
          connect(r_par1.p, r_1.p)      annotation (Line(points={{-84,-40},{-84,
                -20}}, color={0,0,255}));
          connect(c_par2.p,r_par2. n)
                                   annotation (Line(points={{16,-40},{12,-40}},
              color={0,0,255}));
          connect(r_par2.p, r_2.p)      annotation (Line(points={{-8,-40},{-8,
                -20}}, color={0,0,255}));
          connect(r_1.p, p)     annotation (Line(points={{-84,-20},{-92,-20},{
                -92,60},{-100,60}}, color={0,0,255}));
          connect(g_mLeakWork.flange,g_mAirWork. flange) annotation (Line(
              points={{-20,74},{-6,74},{-6,40},{-20,40}}, color={0,127,0}));
          connect(g_mAirWork.flange, armature.flange_a) annotation (Line(points=
               {{-20,40},{-6,40},{-6,0},{64,0}}, color={0,127,0}));
          connect(n,c_par2. n) annotation (Line(points={{-100,-60},{36,-60},{36,
                -40}}, color={0,0,255}));
          connect(coil2.port_p, g_mFeArm.port_p) annotation (Line(points={{24,
                30},{20,30}}, color={255,127,0}));
          connect(G_mLeakRad.port_p, g_mFeArm.port_n) annotation (Line(points={{
                -6.12323e-016,46},{0,46},{0,30}},  color={255,127,0}));
          connect(g_mAirWork.port_p, g_mFeArm.port_n) annotation (Line(points={
                {-10,30},{0,30}}, color={255,127,0}));
          connect(coil1.port_n, g_mAirWork.port_n) annotation (Line(points={{
                -40,30},{-30,30}}, color={255,127,0}));
          connect(g_mAirWork.port_n, g_mLeakWork.port_n) annotation (Line(
              points={{-30,30},{-30,64}}, color={255,127,0}));
          connect(g_mLeakWork.port_p, g_mAirWork.port_p) annotation (Line(
              points={{-10,64},{-10,30}}, color={255,127,0}));
          connect(coil1.port_p, g_mFePole.port_p) annotation (Line(points={{-52,
                30},{-58,30}}, color={255,127,0}));
          connect(g_mFePole.port_n, g_mFePoleBot.port_p) annotation (Line(
              points={{-78,30},{-78,46}}, color={255,127,0}));
          connect(g_mFePoleBot.port_n, g_mFeYokeSide1.port_p) annotation (Line(
              points={{-78,66},{-78,80},{-50,80}}, color={255,127,0}));
          connect(g_mFeYokeSide1.port_n, G_mLeakRad.port_n) annotation (Line(
              points={{-30,80},{6.12323e-016,80},{6.12323e-016,66}}, color={255,
                127,0}));
          connect(g_mFeYokeSide1.port_n, g_mFeYokeSide2.port_p) annotation (Line(
              points={{-30,80},{20,80}}, color={255,127,0}));
          connect(g_mFeYokeSide2.port_n, g_mFeYokeBot.port_n) annotation (Line(
              points={{40,80},{74,80}}, color={255,127,0}));
          connect(coil2.port_n, g_mLeak2.port_p) annotation (Line(points={{36,
                30},{46,30}}, color={255,127,0}));
          connect(g_mLeak2.port_p, g_mLeak1.port_p) annotation (Line(points={{
                46,30},{60,30}}, color={255,127,0}));
          connect(g_mLeak1.port_p, g_mAirPar.port_p) annotation (Line(points={{
                60,30},{74,30}}, color={255,127,0}));
          connect(g_mAirPar.port_p, g_mLeak3.port_p) annotation (Line(points={{
                74,30},{88,30}}, color={255,127,0}));
          connect(g_mLeak2.port_n, g_mLeak1.port_n) annotation (Line(points={{
                46,50},{60,50}}, color={255,127,0}));
          connect(g_mLeak1.port_n, g_mAirPar.port_n) annotation (Line(points={{
                60,50},{74,50}}, color={255,127,0}));
          connect(g_mAirPar.port_n, g_mLeak3.port_n) annotation (Line(points={{
                74,50},{88,50}}, color={255,127,0}));
          connect(g_mFeYokeBot.port_p, g_mAirPar.port_n) annotation (Line(
              points={{74,60},{74,50}}, color={255,127,0}));
          connect(coil2.p, r_2.n) annotation (Line(points={{24,10},{24,-20},{12,
                -20}}, color={0,0,255}));
          connect(coil2.n, c_par2.n) annotation (Line(points={{36,10},{36,-40}},
              color={0,0,255}));
          connect(coil1.n, c_par1.n) annotation (Line(points={{-40,10},{-40,-40}},
              color={0,0,255}));
          connect(coil1.n, r_2.p) annotation (Line(points={{-40,10},{-40,-20},{
                -8,-20}}, color={0,0,255}));
          connect(r_1.n, coil1.p) annotation (Line(points={{-64,-20},{-52,-20},
                {-52,10}}, color={0,0,255}));
        connect(ground.port, g_mLeak2.port_p) annotation (Line(
            points={{52,22},{52,30},{46,30}},
            color={255,127,0},
            smooth=Smooth.None));
          annotation (__Dymola_Images(Parameters(source=
                    "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/SolenoidActuator/Solenoid_dimensions.png")),
            Window(
              x=0.16,
              y=0.15,
              width=0.6,
              height=0.6),
            Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={
              Rectangle(
                extent={{-90,100},{90,-100}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,-30},{-4,30}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-40,-30},{-90,30}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-80,-100},{-90,100}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,90},{-90,100}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,-100},{-90,-90}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,40},{80,100}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,-100},{80,-40}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-70,80},{70,40}},
                lineColor={255,213,170},
                fillColor={255,213,170},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-70,-40},{70,-80}},
                lineColor={255,213,170},
                fillColor={255,213,170},
                fillPattern=FillPattern.Solid),
              Line(points={{4,30},{4,32},{2,38},{-4,48},{-14,60},{-22,72},{-24,
                    80},{-24,90}}, color={255,128,0}),
              Line(points={{22,30},{22,32},{20,38},{14,48},{4,60},{-4,72},{-6,
                    80},{-6,90}}, color={255,128,0}),
              Line(points={{40,30},{40,32},{38,38},{32,48},{22,60},{14,72},{12,
                    80},{12,90}}, color={255,128,0}),
              Text(
                extent={{0,160},{0,120}},
                lineColor={0,0,255},
                textString="%name")}),
            Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics),
          Documentation(info="<html>
<p>
Please have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.SimpleSolenoid\">SimpleSolenoid</a> for a general description of this actuator. Unlike in that simple magnetic network model, the coil is split into two lumped elements here. This enables for more realistic modelling of the radial leakage flux between armature and yoke (leakage permeance G_mLeakRad). Especially for large air gaps, the influence of this leakage flux on the actuator's inductance and its electromagnetic force is rather strong. Please have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.ComparisonQuasiStationary\">ComparisonQuasiStationary</a> for a comparison of both models with FEA-based results included as reference.
</p>

<IMG src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/SolenoidActuator/AdvancedSolenoidModel_fluxTubePartitioning.png\" ALT=\"Assigned flux tubes and field plot of the solenoid actuator\">

<p>
The parasitic capacitances c_par1 and c_par2 accross both partial coils assure that the voltages across these coils are well-defined during simulation.
</p>
</html>"));
        end AdvancedSolenoid;
      end Components;
      annotation (Documentation(info="<html>
<p>
In electromagnetic or reluctance actuators, a thrust or reluctance force is generated due to a non-zero gradient of the relative magnetic permeability mu_r at surfaces between regions of different permeability (non-saturated ferromagnetic material: mu_r>>1, adjacent air: mu_r=1). In lumped magnetic network models, this force can be calculated as shortly outlined in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.ReluctanceForceCalculation\">Reluctance Forces</a> of the User's Guide.
</p>

<p>
As an example of a reluctance actuator, a simple axisymmetric lifting magnet with planar end planes of armature and pole is shown. Often, a <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.SimpleSolenoid\">SimpleSolenoid</a> model is sufficient for initial rough design of such an actuator's magnetic subsystem. Higher accuracy can be gained from an <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.AdvancedSolenoid\">AdvancedSolenoid</a> model where the coil-imposed magnetomotive force is split and the leakage flux between armature and yoke is accounted for more precisely.
</p>

<p>
The differences between these two models in static behaviour can be analysed and compared to results obtained with a more accurate finite element analysis (FEA) in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.ComparisonQuasiStationary\">ComparisonQuasiStationary</a>. The resulting differences in dynamic behaviour can be analysed and compared to FEA results with simulation of a pull-in stroke in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.ComparisonPullInStroke\">ComparisonPullInStroke</a>.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics));
    end SolenoidActuator;

    package Utilities "Utilities to be used in examples"
      extends Modelica.Icons.Package;

      model TranslatoryArmatureAndStopper
        "Mass with free travel between two stoppers"

        parameter SI.Length L(start=0)
          "Length of component from left flange to right flange (= flange_b.s - flange_a.s)";
        parameter SI.Mass m( start=1) "Armature mass";

        parameter Modelica.SIunits.TranslationalSpringConstant c(
            start = 1e11) "Spring stiffness between impact partners";
        parameter Modelica.SIunits.TranslationalDampingConstant d(
            start = 2e7) "Damping coefficient between impact partners";
        parameter Real n(final min=1)=2
          "Exponent of spring forces (f_c = c*|s_rel|^n)" annotation(Evaluate=true);

        parameter SI.Position x_max(start=10e-3)
          "Position of stopper at maximum armature position";
        parameter SI.Position x_min(start=0)
          "Position of stopper at minimum armature position";
        Modelica.SIunits.Position s(start=0)
          "Absolute position of center of component (= flange_a.s + L/2)";
        Modelica.SIunits.Velocity v(start=0)
          "Absolute velocity of components (= der(s))";
        Modelica.SIunits.Acceleration a(start=0)
          "Absolute acceleration of components (= der(v))";
        Modelica.Mechanics.Translational.Components.Mass mass(
                                                          final L=L, final m=m)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
        Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
              rotation=0)));
        Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b
          annotation (Placement(transformation(extent={{90,-10},{110,10}},
              rotation=0)));
        Modelica.Mechanics.Translational.Components.Fixed limit_xMin(
                                                          s0=x_min)
          annotation (Placement(transformation(extent={{-80,-50},{-60,-30}},
              rotation=0)));
        Modelica.Mechanics.Translational.Components.Fixed limit_xMax(
                                                          s0=x_max)
          annotation (Placement(transformation(extent={{60,-50},{80,-30}},
              rotation=0)));
        Modelica.Mechanics.Translational.Components.ElastoGap stopper_xMax(
          final c=c,
          final d=d,
          final n=n,
          final s_rel0=0)
          annotation (Placement(transformation(extent={{50,-30},{70,-10}},
              rotation=0)));
        Modelica.Mechanics.Translational.Components.ElastoGap stopper_xMin(
          final c=c,
          final d=d,
          final n=n,
          final s_rel0=0)
          annotation (Placement(transformation(extent={{-70,-30},{-50,-10}},
              rotation=0)));

      equation
        mass.s = s;
        mass.v = v;
        mass.a = a;
        connect(mass.flange_a, stopper_xMin.flange_b)
          annotation (Line(points={{-10,0},{-40,0},{-40,-20},{-50,-20}}, color=
              {0,127,0}));
        connect(limit_xMax.flange,  stopper_xMax. flange_b)
          annotation (Line(points={{70,-40},{70,-20}}, color={0,191,0}));
        connect(stopper_xMax.flange_a, mass.flange_b)
          annotation (Line(points={{50,-20},{40,-20},{40,0},{10,0}}, color={0,
              127,0}));
        connect(mass.flange_a, flange_a)         annotation (Line(points={{-10,
              0},{-32.5,0},{-32.5,1.16573e-015},{-55,1.16573e-015},{-55,0},{
              -100,0}}, color={0,127,0}));
        connect(limit_xMin.flange,   stopper_xMin.flange_a) annotation (Line(
            points={{-70,-40},{-70,-20}}, color={0,127,0}));
        connect(flange_b, mass.flange_b) annotation (Line(points={{100,0},{10,0}},
            color={0,127,0}));
        annotation (defaultComponentName = "armature",
          Window(
            x=0.21,
            y=0.35,
            width=0.53,
            height=0.73),
          Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
            Line(
              points={{-80,-60},{-80,-80}},
              color={160,160,164},
              thickness=0.5),
            Line(
              points={{-80,-76},{-40,-76}},
              color={160,160,164},
              thickness=0.5,
              arrow={Arrow.None,Arrow.Filled}),
            Text(
              extent={{-84,-82},{-76,-92}},
              lineColor={160,160,164},
              pattern=LinePattern.Dash,
              lineThickness=0.5,
              textString=
                     "0"),
            Text(
              extent={{-46,-82},{-38,-92}},
              lineColor={160,160,164},
              pattern=LinePattern.Dash,
              lineThickness=0.5,
              textString=
                     "x"),
            Ellipse(
              extent={{-82,-78},{-78,-74}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid)}),
          Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
            Rectangle(
              extent={{-90,10},{90,-10}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={255,127,0}),
            Text(
              extent={{-120,140},{120,100}},
              lineColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-50,60},{50,-60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={255,127,0}),
            Rectangle(
              extent={{-80,-20},{-88,-80}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{88,-20},{80,-80}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-80,80},{-88,20}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{88,80},{80,20}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-100,-100},{100,-140}},
              lineColor={0,0,0},
              textString="m=%m"),
            Line(points={{-50,-80},{30,-80}}, color={0,0,0}),
            Polygon(
              points={{60,-80},{30,-70},{30,-90},{60,-80}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid)}),
          Documentation(info="<html>
<p>
In translatory actuators with limited stroke, the armature with its inertia can travel between two stoppers.
</p>
</html>"));
      end TranslatoryArmatureAndStopper;

      record CoilDesign
        "Calculation of winding parameters (wire diameter, number of turns et al.) and recalculation with optionally chosen parameters; to be adapted to particular design tasks"
        extends Modelica.Icons.Record;

        parameter SI.Resistivity rho_20 = 0.0178e-6
          "Resistivity of conductor material at 20ï¿½C (default: Copper)";
        parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_20=
                                                                      0.0039
          "Temperature coefficient of conductor material's resistivity at 20degC (default: Copper)";
        parameter SI.Temperature T_op = 293.15
          "Operating temperature of winding";

        final parameter SI.Resistivity rho = rho_20 * (1 + alpha_20 *(T_op - 20+273.15))
          "Resistivity at operating temperature";

        parameter SI.Length h_w "Height of winding cross-section";
        parameter SI.Length b_w "Width of winding cross-section";

        final parameter SI.Area A_w = h_w * b_w "Cross-section area of winding";

        parameter SI.Length l_avg "Average length of one turn";

        parameter SI.Voltage V_op
          "Operating voltage (nominal/ minimum/ maximum voltage depending on design objective)";

        parameter SI.CurrentDensity J_desired = 4e6
          "DESIRED current density at operating temperature and voltage resp.";

        parameter Real c_condFillChosen = 0.6
          "CHOSEN conductor filling factor = total conductor area without insulation/ total winding area";

        final parameter Real N_calculated = V_op/ (rho * l_avg * J_desired)
          "CALCULATED number of turns";

        final parameter SI.Diameter d_wireCalculated = sqrt(4 * A_w * c_condFillChosen /(pi * N_calculated))
          "CALCULATED wire diameter (without insulation)";

        final parameter SI.Area A_wireCalculated = pi * d_wireCalculated^2 / 4
          "Calculated wire cross-section area";

        final parameter SI.Resistance R_calculated = rho * N_calculated * l_avg / A_wireCalculated
          "Winding resistance at operating temperature and voltage resp. with CALCULATED number of turns and wire diameter";

        final parameter SI.Power P_calculated = V_op^2 / R_calculated
          "Winding's ohmic losses at operating temperature and voltage resp. with CALCULATED number of turns and wire diameter";

        parameter SI.Diameter d_wireChosen = d_wireCalculated
          "CHOSEN available wire diameter (without insulation)" annotation(Dialog(group="Chosen feasible parameters (optional)"));

        parameter Real N_chosen = N_calculated "CHOSEN number of turns"
                                                         annotation(Dialog(group="Chosen feasible parameters (optional)"));

        final parameter SI.Area A_wireChosen = pi * d_wireChosen^2 / 4
          "Wire cross-section area resulting from CHOSEN wire diameter";

        final parameter SI.Resistance R_actual = rho * N_chosen * l_avg / A_wireChosen
          "Winding resistance at operating temperature and voltage resp. resulting from CHOSEN number of turns and wire diameter";

        final parameter SI.Power P_actual = V_op^2 / R_actual
          "Winding's ohmic losses at operating temperature and voltage resp. resulting from CHOSEN number of turns and wire diameter";

        final parameter SI.CurrentDensity J_actual = V_op * 4/(R_actual * pi * d_wireChosen^2)
          "Current density at operating temperature and voltage resp. resulting from CHOSEN number of turns and wire diameter";

        final parameter Real c_condFillActual = N_chosen * pi * d_wireChosen^2 /(4 * A_w)
          "Conductor filling factor resulting from CHOSEN number of turns and wire diameter";

        annotation (Icon(graphics),
          Documentation(info="<html>
<p>
This model exemplarily shows dimensioning of a winding (wire diameter, number of turns) based on desired operating conditions (voltage, temperature, current density, conductor filling factor) for a given cross-section area of the winding. It can be modified according to the parameters given and sought after for a particular design project.
</p>

<p>
The calculated winding resistance and number of turns can be used as input parameters to the electrical subsystem
of a device to be modelled. Operating voltage V_op can be minimum, nominal and maximum voltage respectively as specified for a particular design project. In conjunction with the setting of the operating temperature T_op, this enables for analysis of the device under worst-case conditions (e.g., minimum required magnetomotive force, maximum allowed ohmic losses, minimum and maximum force respectively).
</p>

<p>
For manufacturing of a winding, the obtained wire diameter d_wireCalculated must be rounded to that of an available wire. In order to analyse the influence of this rounding, one can enter the chosen wire diameter d_wireChosen and number of turns N_chosen as optional input. Calculation of the resulting winding parameters enables for comparison with the ones obtained otherwise.
</p>
</html>"));

      end CoilDesign;
    end Utilities;
    annotation (Documentation(info="<html>
</html>"));
  end Examples;

  package Basic "Basic elements of magnetic network models"
    extends Modelica.Icons.Package;

    model Ground "Zero magnetic potential"

      Modelica.Magnetic.FluxTubes.Interfaces.PositiveMagneticPort port
        annotation (Placement(transformation(extent={{-10,110},{10,90}},
            rotation=-0)));
    equation
      port.V_m = 0;
      annotation (
        Documentation(info="<html>
<p>
The magnetic potential at the magnetic ground node is zero. Every magnetic network model must contain at least one magnetic ground object.
</p>
</html>
"),     Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-60,50},{60,50}}, color={255,127,0}),
          Line(points={{-40,30},{40,30}}, color={255,127,0}),
          Line(points={{-20,10},{20,10}}, color={255,127,0}),
          Line(points={{0,90},{0,50}}, color={255,127,0}),
          Text(
            extent={{-150,-40},{150,0}},
            lineColor={0,0,255},
            textString="%name")}),
        Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(
            points={{-60,50},{60,50}},
            color={255,127,0},
            thickness=0.5),
          Line(
            points={{-40,30},{40,30}},
            color={255,127,0},
            thickness=0.5),
          Line(
            points={{-20,10},{20,10}},
            color={255,127,0},
            thickness=0.5),
          Line(
            points={{0,100},{0,50}},
            color={255,127,0},
            thickness=0.5),
          Text(
            extent={{-40,-40},{40,20}},
            lineColor={0,0,255},
            textString="port.V_m = 0")}),
        Window(
          x=0.23,
          y=0.23,
          width=0.59,
          height=0.63));
    end Ground;

    model ElectroMagneticConverter "Electro-magnetic energy conversion"

      Modelica.Magnetic.FluxTubes.Interfaces.PositiveMagneticPort port_p
        "Positive magnetic port"
        annotation (Placement(transformation(extent={{90,50},{110,70}},
            rotation=0)));
      Modelica.Magnetic.FluxTubes.Interfaces.NegativeMagneticPort port_n
        "Negative magnetic port"
        annotation (Placement(transformation(extent={{110,-70},{90,-50}},
            rotation=0)));
      Modelica.Electrical.Analog.Interfaces.PositivePin p
        "Positive electric pin"
        annotation (Placement(transformation(extent={{-90,50},{-110,70}},
            rotation=0)));
      Modelica.Electrical.Analog.Interfaces.NegativePin n
        "Negative electric pin"
        annotation (Placement(transformation(extent={{-110,-70},{-90,-50}},
            rotation=0)));
      SI.Voltage v "Voltage";
      SI.Current i(start = 0, stateSelect=StateSelect.prefer) "Current";
      SI.MagneticPotentialDifference V_m "Magnetic potential difference";
      SI.MagneticFlux Phi "Magnetic flux coupled into magnetic circuit";

      parameter Real N(start = 1) "Number of turns";

      //for information only:
      SI.MagneticFlux Psi "Flux linkage for information only";
      SI.Inductance L_stat "Static inductance abs(Psi/i) for information only";

    protected
      Real eps = 100*Modelica.Constants.eps;
    equation
      v = p.v - n.v;
      0 = p.i + n.i;
      i = p.i;

      V_m = port_p.V_m - port_n.V_m;
      0 = port_p.Phi + port_n.Phi;
      Phi = port_p.Phi;

      //converter equations:
      V_m = i * N;   // Ampere's law
      N * der(Phi) = -v;   // Faraday's law

      //for information only:
      Psi = N * Phi;
      //use of abs() for positive results; due to Modelica sign conventions for flow into connectors:
      L_stat = noEvent(if abs(i) > eps then abs(Psi/i) else abs(Psi/eps));

      annotation (defaultComponentName = "converter",
        Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Polygon(
            points={{-134,63},{-124,60},{-134,57},{-134,63}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Line(points={{-150,60},{-125,60}}, color={160,160,164}),
          Polygon(
            points={{141,-57},{151,-60},{141,-63},{141,-57}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Line(points={{125,-60},{150,-60}}, color={160,160,164}),
          Text(
            extent={{128,-56},{144,-41}},
            lineColor={160,160,164},
            textString="Phi"),
          Text(
            extent={{128,64},{145,79}},
            lineColor={0,0,0},
            textString="Phi"),
          Line(points={{-150,-59},{-125,-59}}, color={160,160,164}),
          Polygon(
            points={{-140,-56},{-150,-59},{-140,-62},{-140,-56}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-141,-56},{-124,-41}},
            lineColor={160,160,164},
            textString="i"),
          Text(
            extent={{-150,63},{-133,78}},
            lineColor={160,160,164},
            textString="i"),
          Line(points={{124,61},{149,61}}, color={160,160,164}),
          Polygon(
            points={{134,64},{124,61},{134,58},{134,64}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid)}),
        Window(
          x=0.26,
          y=0.14,
          width=0.58,
          height=0.58),
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-70,100},{70,-100}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(extent={{-50,0},{-30,20}}, lineColor={0,0,255}),
          Line(points={{-40,60},{-40,40}}, color={0,0,255}),
          Ellipse(extent={{-50,20},{-30,40}}, lineColor={0,0,255}),
          Ellipse(extent={{-50,-20},{-30,0}}, lineColor={0,0,255}),
          Ellipse(extent={{-50,-40},{-30,-20}}, lineColor={0,0,255}),
          Line(points={{-40,-40},{-40,-60}}, color={0,0,255}),
          Rectangle(
            extent={{-54,40},{-40,-40}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-40,60},{-92,60}}, color={0,0,255}),
          Line(points={{-40,-60},{-90,-60}}, color={0,0,255}),
          Line(
            points={{0,100},{-70,100}},
            color={0,0,255},
            pattern=LinePattern.Dash),
          Line(
            points={{-70,100},{-70,-100}},
            color={0,0,255},
            pattern=LinePattern.Dash),
          Line(
            points={{0,-100},{-70,-100}},
            color={0,0,255},
            pattern=LinePattern.Dash),
          Line(
            points={{70,100},{0,100}},
            color={255,127,0},
            pattern=LinePattern.Dash),
          Line(
            points={{70,-100},{0,-100}},
            color={255,127,0},
            pattern=LinePattern.Dash),
          Line(
            points={{70,100},{70,-100}},
            color={255,127,0},
            pattern=LinePattern.Dash),
          Ellipse(extent={{-4,-34},{64,34}}, lineColor={255,127,0}),
          Line(points={{30,-60},{30,-34}}, color={255,127,0}),
          Line(points={{18,0},{42,0}}, color={255,127,0}),
          Line(points={{42,10},{42,-12}}, color={255,127,0}),
          Line(points={{30,34},{30,60}}, color={255,127,0}),
          Line(points={{30,60},{100,60}}, color={255,127,0}),
          Line(points={{30,-60},{90,-60}}, color={255,127,0}),
          Text(
            extent={{-150,150},{150,110}},
            lineColor={0,0,255},
            textString="%name"),
          Line(points={{18,10},{18,-12}}, color={255,127,0}),
          Line(points={{-90,30},{-90,-30}}, color={0,0,255}),
          Polygon(
            points={{-90,-30},{-84,-10},{-96,-10},{-90,-30}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Line(points={{90,30},{90,-30}}, color={255,128,0}),
          Polygon(
            points={{90,-30},{96,-10},{84,-10},{90,-30}},
            lineColor={255,128,0},
            fillColor={255,128,0},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>
The electro-magnetic energy conversion is given by <i>Ampere</i>'s law and <i>Faraday</i>'s law respectively:
</p>

<pre>
    V_m = i * N
    N * d&Phi;/dt = -v
</pre>

<p>
V_m is the magnetomotive force that is supplied to the connected magnetic circuit, &Phi; is the magnetic flux through the associated branch of this magnetic circuit. The negative sign of the induced voltage v is due to <i>Lenz</i>'s law.
</p>

<p>
The flux linkage &Psi; and the static inductance L_stat = |&Psi;/i| are calculated for information only. Note that L_stat is set to |&Psi;/eps| if |i| &lt; eps
(= 100*Modelica.Constants.eps).
</p>
</html>"));
    end ElectroMagneticConverter;

    model ConstantReluctance "Constant reluctance"

      extends Modelica.Magnetic.FluxTubes.Interfaces.PartialTwoPorts;

      parameter SI.Reluctance R_m(start = 1) "Magnetic reluctance";

    equation
      V_m = Phi * R_m;

      annotation (
        Window(
          x=0.16,
          y=0.15,
          width=0.6,
          height=0.6),
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={255,128,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-70,0},{-90,0}}, color={255,128,0}),
          Line(points={{70,0},{90,0}}, color={255,128,0}),
          Text(
            extent={{-100,-100},{100,-62}},
            textString="%name",
            lineColor={0,0,255})}),
        Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
      Documentation(info="<html>
<p>
This constant reluctance is provided for test purposes and simple magnetic network models. The reluctance is not calculated from geometry and permeability of a flux tube, but is provided as a parameter.
</p>
</html>"));
    end ConstantReluctance;

    model LeakageWithCoefficient
      "Leakage reluctance with respect to the reluctance of a useful flux path (not for dynamic simulation of actuators)"

      extends Modelica.Magnetic.FluxTubes.Interfaces.PartialLeakage;

      parameter SI.CouplingCoefficient c_usefulFlux( start = 0.7)
        "Ratio useful flux/(leakage flux + useful flux) = useful flux/total flux";

      input SI.Reluctance R_mUsefulTot
        "Total reluctance of useful flux path as reference"
         annotation(Dialog(group="Reference reluctance"));
    equation
      (1 - c_usefulFlux) * R_m = c_usefulFlux * R_mUsefulTot;   // Generalized Kirchhoff's current law

      annotation (__Dymola_Images(Parameters(group="Reference reluctance", source=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Basic/LeakageWithCoefficient.png")),
          Documentation(info="<html>
<p>
Differently from the flux tube elements of package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Shapes.Leakage</a>
that are calculated from their geometry, this leakage reluctance is calculated with reference to the total reluctance of a useful flux path. Please refer to the <b>Parameters</b> section for an illustration of the resulting magnetic network. Exploiting <i>Kirchhoff</i>'s generalized current law, the leakage reluctance is calculated by means of a coupling coefficient c_usefulFlux.
</p>

<h4>Attention:</h4>

<p>
This element must <b>not</b> be used <b>for dynamic simulation of</b> electro-magneto-mechanical <b>actuators</b>, where the shape of at least one flux tube element with reluctance force generation in the useful flux path changes with armature motion (e.g., air gap). This change results in a non-zero derivative dG_m/dx of those elements permeance G_m with respect to armature position x, which in turn will lead to a non-zero derivative of the leakage permeance with respect to armature position. This would generate a reluctance force in the leakage element that is not accounted for properly. <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force.LeakageAroundPoles\">Shapes.Force.LeakageAroundPoles</a> provides a simple leakage reluctance with force generation.
</p>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),
             graphics));
    end LeakageWithCoefficient;

    model EddyCurrent
      "For modelling of eddy current in a conductive magnetic flux tube"

      extends Modelica.Magnetic.FluxTubes.Interfaces.PartialTwoPorts;
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T = 273.15);

      parameter SI.Resistivity rho( start = 0.098e-6)
        "Resistivity of flux tube material (default: Iron at 20degC)";
      parameter SI.Length l(start = 1) "Average length of eddy current path";
      parameter SI.Area A(start = 1)
        "Cross sectional area of eddy current path";

      final parameter SI.Resistance R = rho * l /A
        "Electrical resistance of eddy current path";

    equation
      LossPower = V_m*der(Phi);
      V_m = 1/R * der(Phi); //Magnetic voltage drop in magnetic network due to eddy current
      annotation (
        Window(
          x=0.16,
          y=0.15,
          width=0.6,
          height=0.6),
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={255,128,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-70,0},{-90,0}}, color={255,128,0}),
          Line(points={{70,0},{90,0}}, color={255,128,0}),
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={255,128,0},
            fillColor={255,128,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-100,-98},{100,-60}},
            textString="%name",
            lineColor={0,0,255})}),
        Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
      Documentation(info="<html>
<p>
Eddy currents are induced in a conductive magnetic flux tube when the flux changes with time. This causes a magnetic voltage drop in addition to the voltage drop that is due to the reluctance of this flux tube. The eddy current component can be thought of as a short-circuited secundary winding of a transformer with only one turn. Its resistance is calculated from the geometry and resistivity of the eddy current path.
</p>

<p>
Partitioning of a solid conductive cylinder or prism into several hollow cylinders or separate nested prisms and modelling of each of these flux tubes connected in parallel with a series connection of a reluctance element and an eddy current component can model the delayed buildup of the magnetic field in the complete flux tube from the outer to the inner sections. Please refer to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ka08]</a> for an illustration.
</p>
</html>"));
    end EddyCurrent;

  end Basic;

  package Shapes
    "Reluctance and permeance elements respectively based on geometric shapes"
    extends Modelica.Icons.Package;

    package FixedShape
      "Flux tubes with fixed shape during simulation and linear or non-linear material characteristics"
      extends Modelica.Icons.VariantsPackage;

      model HollowCylinderAxialFlux
        "(Hollow) cylinder with axial flux; fixed shape; linear or non-linear material characteristics"

        extends Modelica.Magnetic.FluxTubes.Interfaces.PartialFixedShape;

        parameter SI.Length l( start = 0.01)
          "Axial length (in direction of flux)"   annotation(Dialog(group="Fixed geometry"));
        parameter SI.Radius r_i( start = 0)
          "Inner radius of hollow cylinder (zero for cylinder)"
          annotation(Dialog(group="Fixed geometry"));
        parameter SI.Radius r_o( start = 0.01)
          "Outer radius of (hollow) cylinder"
          annotation(Dialog(group="Fixed geometry"));

      equation
        A = pi*(r_o^2 - r_i^2);
        G_m = (mu_0 * mu_r * A)/ l;

        annotation (__Dymola_Images(Parameters(group="Fixed geometry", source=
                  "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HollowCylinderAxialFlux.png")),
          Window(
            x=0.16,
            y=0.15,
            width=0.6,
            height=0.6),
          Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics),
          Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics),
        Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">FixedShape</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>

<p>
Set the inner radius r_i=0 for modelling of a solid cylindric flux tube.
</p>
</html>"));
      end HollowCylinderAxialFlux;

      model HollowCylinderRadialFlux
        "Hollow cylinder with radial flux; fixed shape; linear or non-linear material characteristics"

        extends Modelica.Magnetic.FluxTubes.Interfaces.PartialFixedShape;

        parameter SI.Length l( start = 0.01)
          "Width (orthogonal to flux direction)"  annotation(Dialog(group="Fixed geometry"));
        parameter SI.Radius r_i( start = 0.01)
          "Inner radius of hollow cylinder" annotation(Dialog(group="Fixed geometry"));
        parameter SI.Radius r_o( start = 0.02)
          "Outer radius of hollow cylinder"                                      annotation(Dialog(group="Fixed geometry"));

      equation
        A = l * pi*(r_o + r_i); // Area at arithmetic mean radius for calculation of average flux density
        G_m = 2* pi* mu_0* mu_r* l/ Modelica.Math.log(r_o/r_i);

        annotation (__Dymola_Images(Parameters(group="Fixed geometry", source=
                  "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HollowCylinderRadialFlux.png")),
          Window(
            x=0.16,
            y=0.15,
            width=0.6,
            height=0.6),
          Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics),
          Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics),
        Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">FixedShape</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>

<p>
For hollow cylindric flux tubes with a radial magnetic flux, the flux density is a function of the radius. For that reason, the characteristic mu_r(B) is evaluated for the flux density at the flux tube's mean radius.
</p>

<p>
For those flux tube sections of a magnetic device that have a nonlinear material characteristic mu_r(B) and a large aspect ratio of outer to inner radius r_o/r_i, the section can be split up in a series connection of several hollow cylindric flux tubes with radial flux. This allows for more realistic modelling of the dependence of flux density on the radius compared to modelling with just one flux tube element.
</p>
</html>"));
      end HollowCylinderRadialFlux;

      model Cuboid
        "Flux tube with rectangular cross-section; fixed shape; linear or non-linear material characteristics"

        extends Modelica.Magnetic.FluxTubes.Interfaces.PartialFixedShape;

        parameter SI.Length l = 0.01 "Length in direction of flux"
                                                  annotation(Dialog(group="Fixed geometry"));
        parameter SI.Length a = 0.01 "Width of rectangular cross-section"                           annotation(Dialog(group="Fixed geometry"));
        parameter SI.Length b = 0.01 "Height of rectangular cross-section" annotation(Dialog(group="Fixed geometry"));

      equation
        A = a * b;
        G_m = (mu_0 * mu_r * A)/ l;

        annotation (__Dymola_Images(Parameters(group="Fixed geometry", source=
                  "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/CuboidParallelFlux.png")),
          Window(
            x=0.16,
            y=0.15,
            width=0.6,
            height=0.6),
          Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics),
          Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics),
        Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">FixedShape</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end Cuboid;

      annotation (Documentation(info="<html>
<p>
Please have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.ReluctanceForceCalculation\">UsersGuide.ReluctanceForceCalculation</a> for an explanation of the different flux tube categories and resulting sub-packages.
</p>

<p>
Due to the restrictions on reluctance force calculation outlined there, flux tube elements with a possibly non-linear material characteristic mu_r(B) must have a fixed shape during simulation of converter motion. Hence, the dimensions of these flux tubes are defined as parameters in the model components that extend the base class <a href=\"modelica://Modelica.Magnetic.FluxTubes.Interfaces.PartialFixedShape\">Interfaces.PartialFixedShape</a>.</p>

<p>
For initial design of magnetic circuits, the relative permeability of possibly non-linear flux tube elements can easily be set to a constant value mu_rConst (non-linearPermeability set to false). In some cases, this can simplify the rough geometric design of a device's magnetic circuit. Once an initial geometry is found, the magnetic subsystem can be simulated and fine-tuned with more realistic non-linear characteristics of ferromagnetic materials. Doing so requires setting of the parameter non-linearPermeability to true and selection of one of the soft magnetic materials of <a href=\"Material.SoftMagnetic\">Material.SoftMagnetic</a>.
</p>
</html>"));
    end FixedShape;

    package Force
      "Flux tubes with reluctance force generation; constant permeability"
      extends Modelica.Icons.VariantsPackage;

      model HollowCylinderAxialFlux
        "(Hollow) cylinder with axial flux; constant permeability"

        extends Modelica.Magnetic.FluxTubes.Interfaces.PartialForce;

        SI.Length l = s "Axial length (in direction of flux)"
                                                  annotation(Dialog(group="Variable geometry"));
        parameter SI.Radius r_i( start = 0) "Inner radius of (hollow) cylinder";
        parameter SI.Radius r_o( start = 0.01)
          "Outer radius of (hollow) cylinder";

        SI.MagneticFluxDensity B "Homogeneous flux density";

      protected
        parameter SI.Area A = pi*(r_o^2 - r_i^2)
          "Cross-sectional area orthogonal to direction of flux";

      equation
        G_m = mu_0*mu_r * A /l;

        dGmBydx = -1 * mu_0*mu_r * A /l^2 * dlBydx;

        B = Phi/A;

        annotation (__Dymola_Images(Parameters(group="Variable geometry", source=
                  "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HollowCylinderAxialFlux.png")),
            Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Force</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"),Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),
                  graphics));
      end HollowCylinderAxialFlux;

      model HollowCylinderRadialFlux
        "Hollow cylinder with radial flux; constant permeability"

        extends Modelica.Magnetic.FluxTubes.Interfaces.PartialForce;

        SI.Length l = s "Axial length (orthogonal to direction of flux)"
                                                  annotation(Dialog(group="Variable geometry"));
        parameter SI.Radius r_i( start = 0.01)
          "Inner radius of hollow cylinder";
        parameter SI.Radius r_o( start = 0.015)
          "Outer radius of hollow cylinder";

        SI.MagneticFluxDensity B_avg
          "Average flux density (at arithmetic mean radius)";

      protected
        SI.Area A_avg
          "Average cross-sectional area orthogonal to direction of flux (at arithmetic mean radius)";

      equation
        G_m = mu_0*mu_r * 2 * pi * l /Modelica.Math.log(r_o/r_i);

        dGmBydx = mu_0*mu_r * 2 * pi/Modelica.Math.log(r_o/r_i) * dlBydx;

        A_avg = pi*(r_i + r_o) * l;
        B_avg = Phi/A_avg;

        annotation (__Dymola_Images(Parameters(group="Variable geometry", source=
                  "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HollowCylinderRadialFlux.png")),
            Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Force</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end HollowCylinderRadialFlux;

      model CuboidParallelFlux
        "Cuboid with flux in direction of motion, e.g., air gap with rectangular cross-section; constant permeability"

        extends Modelica.Magnetic.FluxTubes.Interfaces.PartialForce;

        SI.Length l = s "Axial length (in direction of flux)"
                                                  annotation(Dialog(group="Variable geometry"));
        parameter SI.Length a( start = 0.01)
          "Width of rectangular cross-section";
        parameter SI.Length b( start = 0.01)
          "Height of rectangular cross-section";

        SI.MagneticFluxDensity B "Homogeneous flux density";

      protected
        parameter SI.Area A = a*b
          "Cross-sectional area orthogonal to direction of flux";

      equation
        G_m = mu_0*mu_r * A /l;

        dGmBydx = -1 * mu_0*mu_r * A /l^2 * dlBydx;

        B = Phi/A;

        annotation (__Dymola_Images(Parameters(group="Variable geometry", source=
                  "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/CuboidParallelFlux.png")),
            Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Force</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end CuboidParallelFlux;

      model CuboidOrthogonalFlux
        "Cuboid with flux orthogonal to direction of motion; constant permeability"

        extends Modelica.Magnetic.FluxTubes.Interfaces.PartialForce;

        SI.Length l = s "Length in direction of motion (orthogonal to flux)"
          annotation(Dialog(group="Variable geometry"));
        parameter SI.Length a( start = 0.01)
          "Width of rectangular cross-section";
        parameter SI.Length b( start = 0.01)
          "Height of rectangular cross-section (in flux direction)";

        SI.MagneticFluxDensity B "Homogeneous flux density";

      protected
        SI.Area A "Cross-sectional area orthogonal to direction of flux";

      equation
        A = a*l;
        G_m = mu_0*mu_r * A /b;

        dGmBydx = mu_0*mu_r * a /b * dlBydx;

        B = Phi/A;

        annotation (__Dymola_Images(Parameters(group="Variable geometry", source=
                  "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/CuboidOrthogonalFlux.png")),
            Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Force</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end CuboidOrthogonalFlux;

      model LeakageAroundPoles
        "Leakage flux tube around cylindrical or prismatic poles"

        extends Modelica.Magnetic.FluxTubes.Interfaces.PartialForce;
        SI.Length l = s "Axial length (in direction of flux)"
          annotation(Dialog(group="Variable geometry"));

        parameter SI.Length w( start = 0.1)
          "Width orthogonal to flux; mean circumference of flux tube in case of cylindrical poles";
        parameter SI.Radius r( start = 0.01) "Radius of leakage field";

      equation
        //adapted from [Ka08], but corrected
        //(in [Ka08] equation accidentally swapped with that of a similar element)
        G_m = mu_0 * w /pi * Modelica.Math.log(1 + pi * r/l);

        //derivative at full length:
        //  dGmBydx = mu_0 * w /pi * 1/(1 + pi * r/l) * (-1)*pi*r/l^2  * dlBydx;
        //simplified:
        dGmBydx = - mu_0 * w * r * dlBydx / (l^2 *(1 + pi * r/l));

        annotation (__Dymola_Images(Parameters(group="Variable geometry", source=
                  "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/LeakageAroundPoles.png")),
            Documentation(info="<html>
<p>
Please refer to the description of  the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Force</a> for a description of all elements of this package.
</p>

<p>
Leakage flux around a prismatic or cylindric air gap between to poles can be described with this model. Due to its constant radius of the leakage field r, the model is rather simple. Whereas in reality the leakage radius is approximately constant for air gap lengths l greater than this radius, it decreases with air gap lengths less than the leakage radius. This decrease for small air gaps is neglected here, since the influence of the leakage flux tube compared to that of the enclosed main air gap (connected in parallel) decreases for decreasing air gap length l.
</p>

<p>
Note that in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ka08]</a> the equation for G_m is accidentally swapped with that of a similar element.
</p>
</html>"));
      end LeakageAroundPoles;

      annotation (Documentation(info="<html>
<p>
Please have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.ReluctanceForceCalculation\">UsersGuide.ReluctanceForceCalculation</a> for an explanation of the different flux tube categories and resulting sub-packages.
</p>
Flux tube elements with generation of a reluctance force are intended for modelling of position-dependent air gap sections and permanent magnet sections respectively of translatory actuators. By default, the position co-ordinate of the mechanical connector flange.s is identical with the dimension l of the package's flux tube elements. l is the dimension changes with armature motion. If needed, the identity l=flange.s can be replaced by an actuator-specific equation, for example, when a flux tube length increases with decreasing armature position. The position co-ordinate of an element's translatory connector flange.s in turn will be identical with the armature position x in most cases, as the examples illustrate.</p>
<p>
The derivative of each element's permeance with respect to armature position dGmBydx is calculated from the derivative of the flux tube's permeance with respect to its varying dimension dGmBydl and the derivative of this dimension with respect to armature position dlBydx:</p>
<pre>
    dG_m   dG_m   dl
    ---- = ---- * --
     dx     dl    dx
</pre>
</p>
<p>
The parameter dlBydx must be set in each flux tube element to +1 or -1 according to the definition of the armature co-ordinate and the position of the element in a device's magnetic circuit. Proper match between armature motion and resulting variation of the flux tube length assures that the element's reluctance force acts in the right direction.
</p>
<p>
The shapes of the flux tubes defined in this package are rather simple. Only one dimenion varies with armature motion. Flux tubes with more complex variations of dimensions with armature motion can be defined by extending the base class <a href=\"modelica://Modelica.Magnetic.FluxTubes.Interfaces.PartialForce\">Interfaces.PartialForce</a>, if needed. Determination of the analytic derivative dGmBydl could become more complex for those flux tubes.
</p>
</html>"));
    end Force;

    package Leakage
      "Leakage flux tubes with position-independent permeance and hence no force generation; mu_r=1"
      extends Modelica.Icons.VariantsPackage;

      model QuarterCylinder
        "Leakage flux from one edge to the opposite plane through a quarter cylinder"

        extends Modelica.Magnetic.FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Length l( start = 0.1)
          "Axial length orthogonal to flux (=2*pi*r for cylindrical pole and r>>distance between edge and plane)";

      equation
        G_m = mu_0 * 0.52 * l;

        annotation (__Dymola_Images(Parameters(source=
                  "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/QuarterCylinder.png")),
            Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end QuarterCylinder;

      model QuarterHollowCylinder
        "Leakage flux in circumferential direction through a quarter hollow cylinder"

        extends Modelica.Magnetic.FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Length l( start = 0.1)
          "Axial length orthogonal to flux (=2*pi*r for cylindrical pole and r>>r_i)";
        parameter Real ratio( start = 1) "Constant ratio t/r_i";

      equation
        G_m = 2* mu_0 * l * Modelica.Math.log(1 + ratio) /pi;

        annotation (__Dymola_Images(Parameters(source=
                  "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/QuarterHollowCylinder.png")),
            Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end QuarterHollowCylinder;

      model HalfCylinder "Leakage flux through the edges of a half cylinder"

        extends Modelica.Magnetic.FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Length l( start = 0.1)
          "Axial length orthogonal to flux (=2*pi*r for cylindrical pole and r>>distance between edges)";

      equation
        G_m = mu_0 * 0.26 * l;

        annotation (__Dymola_Images(Parameters(source=
                  "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/HalfCylinder.png")),
            Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end HalfCylinder;

      model HalfHollowCylinder
        "Leakage flux in circumferential direction through a half hollow cylinder"

        extends Modelica.Magnetic.FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Length l( start = 0.1)
          "Axial length orthogonal to flux (=2*pi*r for cylindrical pole and r>>r_i)";
        parameter Real ratio( start = 1) "Constant ratio t/r_i";

      equation
        G_m = mu_0 * l * Modelica.Math.log(1 + ratio) /pi;

        annotation (__Dymola_Images(Parameters(source=
                  "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/HalfHollowCylinder.png")),
            Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end HalfHollowCylinder;

      model QuarterSphere
        "Leakage flux through the corners of a quarter sphere"

        extends Modelica.Magnetic.FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Radius r( start = 0.005) "Radius of quarter sphere";

      equation
        G_m = mu_0 * 0.077 * 2*r;

        annotation (__Dymola_Images(Parameters(source=
                  "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/QuarterSphere.png")),
            Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end QuarterSphere;

      model QuarterHollowSphere
        "Leakage flux through the edges of a qarter hollow sphere"

        extends Modelica.Magnetic.FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Length t( start = 0.01) "Thickness of sperical shell";

      equation
        G_m = mu_0 * 0.25 * t;

        annotation (__Dymola_Images(Parameters(source=
                  "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/QuarterHollowSphere.png")),
          Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end QuarterHollowSphere;

      model EighthOfSphere
        "Leakage flux through one edge and the opposite plane of an eighth of a sphere"

        extends Modelica.Magnetic.FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Radius r( start = 0.01) "Radius of eighth of sphere";

      equation
        G_m = mu_0 * 0.308 * r;

        annotation (__Dymola_Images(Parameters(source=
                  "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/EighthOfSphere.png")),
            Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end EighthOfSphere;

      model EighthOfHollowSphere
        "Leakage flux through one edge and the opposite plane of an eighth of a hollow sphere"

        extends Modelica.Magnetic.FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Length t( start = 0.01) "Thickness of sperical shell";

      equation
        G_m = mu_0 * 0.5 * t;

        annotation (__Dymola_Images(Parameters(source=
                  "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/EighthOfHollowSphere.png")),
            Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end EighthOfHollowSphere;

      model CoaxCylindersEndFaces
        "Leakage flux between the end planes of a inner solid cylinder and a coaxial outer hollow cylinder"

        extends Modelica.Magnetic.FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Radius r_0( start = 10e-3)
          "Radius of inner solid cylinder";
        parameter SI.Radius r_1( start = 17e-3)
          "Inner radius of outer hollow cylinder";
        parameter SI.Radius r_2( start = 20e-3)
          "Outer radius of outer hollow cylinder";

        final parameter SI.Distance l_g = r_1 - r_0
          "Radial gap length between both cylinders";
        final parameter SI.Length t = r_2 - r_1
          "Radial thickness of outer hollow cylinder";

      equation
        // [Ro41], p. 139, Eq. (22)
        G_m = if t <= r_0 then
              2 * mu_0 * (r_0 + l_g/2) * Modelica.Math.log(1 + 2*t/l_g) else
              2 * mu_0 * (r_0 + l_g/2) * Modelica.Math.log(1 + 2*r_0/l_g);

        annotation (__Dymola_Images(Parameters(source=
                  "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/CoaxCylindersEndFaces.png")),
            Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end CoaxCylindersEndFaces;

      annotation (Documentation(info="<html>
<p>
Please have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.ReluctanceForceCalculation\">UsersGuide.ReluctanceForceCalculation</a> for an explanation of the different flux tube categories and resulting sub-packages.
</p>

<p>
The permeances of all elements of this package are calculated from their geometry. These flux tube elements are intended for modelling of leakage fields through vacuum, air and other media with a relative permeability mu_r=1. <a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.LeakageWithCoefficient\">Basic.LeakageWithCoefficient</a> accounts for leakage not by the geometry of flux tubes, but by a coupling coefficient c_usefulFlux.
</p>

<p>
All dimensions are defined as parameters. As a result, the shape of these elements will remain constant during dynamic simulation of actuators and reluctance forces will not be generated in these flux tube elements. A simple leakage flux tube with reluctance force generation is provided with the element <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force.LeakageAroundPoles\">Force.LeakageAroundPoles</a>. In cases where the accuracy of that element is not sufficient, the leakage elements of this package can be adapted and extended so that they are able to change their shape with armature motion and to generate reluctance forces. This requires an extension of the partial model <a href=\"modelica://Modelica.Magnetic.FluxTubes.Interfaces.PartialForce\">Interfaces.PartialForce</a>, a higher variability of the variables representing the flux tube's dimensions, definition of a relationship between armature position and these dimensions and determination of the analytic derivative dG_m/dx of the flux tube's permeance G_m with respect to armature position x.
</p>
</html>"));
    end Leakage;

  end Shapes;

  package Material
    "Magnetisation characteristics of common soft magnetic and hard magnetic materials"
    extends Modelica.Icons.MaterialPropertiesPackage;

    package SoftMagnetic
      "Characteristics mu_r(B) of common soft magnetic materials; hysteresis neglected"
      extends Modelica.Icons.MaterialPropertiesPackage;

      record BaseData
        "Coefficients for approximation of soft magnetic materials"

        extends Modelica.Icons.Record;

        parameter SI.RelativePermeability mu_i = 1
          "Initial relative permeability at B=0";
        parameter SI.MagneticFluxDensity B_myMax = 1
          "Flux density at maximum relative permeability";
        parameter Real c_a = 1 "Coefficient of approximation function";
        parameter Real c_b = 1 "Coefficient of approximation function";
        parameter Real n = 1 "Exponent of approximation function";

        annotation (Documentation(info="<html>
<p>
The parameters needed for <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.mu_rApprox\">approximation of the magnetisation characteristics</a> of included soft magnetic materials are declared in this record.
</p>
</html>"));
      end BaseData;

      package Steel "Various ferromagnetic steels"
        extends Modelica.Icons.MaterialPropertiesPackage;
        record Steel_9SMnPb28 "9SMnPb28 (1.0718)"
          extends Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=400,
            B_myMax=1.488,
            c_a=1200,
            c_b=3,
            n=12.5);
          annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
</html>"));
        end Steel_9SMnPb28;

        record Steel_9SMn28K "9SMn28k (1.0715)"
          extends Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=500,
            B_myMax=1.036,
            c_a=43414,
            c_b=35.8,
            n=14)
          annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
</html>"));
        end Steel_9SMn28K;

        record DC01 "DC01 (1.0330, previously St2)"
          extends Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=5,
            B_myMax=1.1,
            c_a=6450,
            c_b=3.65,
            n=7.7)
                  annotation (
            Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
</html>"));
        end DC01;

        record DC03 "DC03 (1.0347, previously St3)"
          extends Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=0,
            B_myMax=1.05,
            c_a=27790,
            c_b=16,
            n=10.4) annotation (
            Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
</html>"));
        end DC03;

        record X6Cr17 "X6Cr17 (1.4016)"
          extends Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=274,
            B_myMax=1.1,
            c_a=970,
            c_b=1.2,
            n=8.3) annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
</html>"));
        end X6Cr17;

        record AISI_1008 "AISI 1008 (1.0204)"
          extends Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=200,
            B_myMax=1.17,
            c_a=8100,
            c_b=2.59,
            n=10) annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
</html>"));
        end AISI_1008;

        record AISI_12L14 "AISI 12L14 (1.0718)"
          extends Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=10,
            B_myMax=0.94,
            c_a=5900,
            c_b=4.19,
            n=6.4) annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
</html>"));
        end AISI_12L14;
        annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
</html>"));
      end Steel;

      package ElectricSheet "Various electric sheets"
        extends Modelica.Icons.MaterialPropertiesPackage;

      record M330_50A "M330-50A (1.0809) @ 50Hz"
        extends Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=500,
            B_myMax=0.7,
            c_a=24000,
            c_b=9.38,
            n=9.6) annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Sample: complete core after machining and packet assembling<br>
</p>
</html>"));
      end M330_50A;

      record M350_50A "M350-50A (1.0810) @ 50Hz"
        extends Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=1210,
            B_myMax=1.16,
            c_a=24630,
            c_b=2.44,
            n=14) annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Sample: sheet strip<br>
Measurement: Epstein frame
</p>
</html>"));
      end M350_50A;

      record M530_50A "M530-50A (1.0813) @ 50Hz"
        extends Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=2120,
            B_myMax=1.25,
            c_a=12400,
            c_b=1.6,
            n=13.5) annotation (Documentation(
              info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Sample: sheet strip<br>
Measurement: Epstein frame
</p>
</html>"));
      end M530_50A;

      record M700_100A "M700-100A (1.0826) @ 50Hz"
        extends Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=1120,
            B_myMax=1.2,
            c_a=20750,
            c_b=3.55,
            n=13.15) annotation (Documentation(
              info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Sample: sheet strip<br>
Measurement: Epstein frame
</p>
</html>"));
      end M700_100A;

      record M940_100A "M940-100A @ 50Hz"
        extends Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=680,
            B_myMax=1.26,
            c_a=17760,
            c_b=3.13,
            n=13.9) annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Sample: sheet strip<br>
Measurement: Epstein frame
</p>
</html>"));
      end M940_100A;

        annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
</html>"));
      end ElectricSheet;

      package PureIron "Pure iron "
        extends Modelica.Icons.MaterialPropertiesPackage;

        record RFe80 "Hyperm 0 (RFe80)"
          extends Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=123,
            B_myMax=1.27,
            c_a=44410,
            c_b=6.4,
            n=10) annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Source of B(H) characteristics: Product catalogue <i>Magnequench</i>, 2000
</p>
</html>"));
        end RFe80;

        record VacoferS2 "VACOFER S2 (99.95% Fe)"
          extends Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=2666,
            B_myMax=1.15,
            c_a=187000,
            c_b=4.24,
            n=19) annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Source of B(H) characteristics:
<dd>
<p><i>Boll, R.</i>: Weichmagnetische Werkstoffe: Einf&uuml;hrung in den Magnetismus, VAC-Werkstoffe und ihre Anwendungen. 4th ed. Berlin, M&uuml;nchen: Siemens Aktiengesellschaft 1990</p>
</dd>
</p>
</html>"));
        end VacoferS2;
      end PureIron;

      package CobaltIron "Cobalt iron"
        extends Modelica.Icons.MaterialPropertiesPackage;

        record Vacoflux50 "Vacoflux 50 (50% CoFe)"
          extends Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=3850,
            B_myMax=1.75,
            c_a=11790,
            c_b=2.63,
            n=15.02) annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Source of B(H) characteristics: VACUUMSCHMELZE GmbH &amp; Co. KG, Germany
</p>
</html>"));
        end Vacoflux50;
      end CobaltIron;

      package NickelIron "Nickel iron"
        extends Modelica.Icons.MaterialPropertiesPackage;

        record MuMetall "MUMETALL (77% NiFe)"
          extends Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=27300,
            B_myMax=0.46,
            c_a=1037500,
            c_b=3.67,
            n=10) annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Source of B(H) characteristics:
<dd>
<p><i>Boll, R.</i>: Weichmagnetische Werkstoffe: Einf&uuml;hrung in den Magnetismus, VAC-Werkstoffe und ihre Anwendungen. 4th ed. Berlin, M&uuml;nchen: Siemens Aktiengesellschaft 1990</p>
</dd>
</p>
</html>"));
        end MuMetall;

        record Permenorm3601K3 "PERMENORM 3601 K3 (36% NiFe)"
          extends Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=3000,
            B_myMax=0.67,
            c_a=50000,
            c_b=2.39,
            n=9.3) annotation (Documentation(
              info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Source of B(H) characteristics:
<dd>
<p><i>Boll, R.</i>: Weichmagnetische Werkstoffe: Einf&uuml;hrung in den Magnetismus, VAC-Werkstoffe und ihre Anwendungen. 4th ed. Berlin, M&uuml;nchen: Siemens Aktiengesellschaft 1990</p>
</dd>
</p>
</html>"));
        end Permenorm3601K3;
      end NickelIron;

      function mu_rApprox
        "Approximation of relative permeability mu_r as a function of flux density B for soft magnetic materials"

        extends Modelica.Icons.Function;

        input Modelica.SIunits.MagneticFluxDensity B
          "Flux density in ferromagnetic flux tube element";
        //Material specific parameter set:
        input Modelica.SIunits.RelativePermeability mu_i
          "Initial relative permeability at B=0";
        input Modelica.SIunits.MagneticFluxDensity B_myMax
          "Flux density at maximum relative permeability";
        input Real c_a "Coefficient of approximation function";
        input Real c_b "Coefficient of approximation function";
        input Real n "Exponent of approximation function";

        output Modelica.SIunits.RelativePermeability mu_r
          "Relative magnetic permeability of ferromagnetic flux tube element";

      protected
        Real B_N
          "Flux density B normalized to flux density at maximum relative permeability B_myMax";

      algorithm
        B_N := abs(B/B_myMax);
        mu_r := 1 + (mu_i-1 + c_a*B_N)/(1 + c_b*B_N + B_N^n);

        annotation (Documentation(info="<html>
<p>
The relative permeability mu_r as a function of flux density B for all soft magnetic materials currently included in this library is approximated with the following function <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro00]</a>:
<br>
<dl>
<dd>
<IMG src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/SoftMagnetic/eq_mu_rApprox.png\" ALT=\"Equation for approximation mu_r(B)\">
</dd>
</dl>
<br>
Two of the five parameters of this equation have a physical meaning, namely the initial relative permeability mu_i at B=0 and the magnetic flux density at maximum permeability B_myMax. B_N is the flux density normalized to latter parameter.
</html>"));
      end mu_rApprox;
      annotation (Documentation(info="<html>
<p>
The magnetisation characteristics mu_r(B) of all soft magnetic materials currently included in this library are approximated with a <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.mu_rApprox\">function</a>. Each material is characterised by the five parameters of this function. The approximated characteristics mu_r(B) for most of the ferromagnetic materials currently included are shown in the plots below (solid lines) together with the original data points compiled from measurements and literature.

<IMG src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/SoftMagnetic/Steel.png\" ALT=\"Approximated magnetization characteristics of selected steels\">

<IMG src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/SoftMagnetic/Miscellaneous.png\" ALT=\"Approximated magnetization characteristics of miscellaneous soft magnetic materials\">

<IMG src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/SoftMagnetic/ElectricSheet.png\" ALT=\"Approximated magnetization characteristics of included electric sheets\">

<p>
For the nonlinear curve fit, data points for high flux densities (approximately B>1T) have been weighted higher than the ones for low flux densities. This is due to the large impact of saturated ferromagnetic sections in a magnetic circuit compared to that of non-saturated sections with relative permeabilities mu_r>>1.
</p>

<p>
Note that the magnetisation characteristics largely depend on possible previous machining and on measurement conditions. A virgin material normally has a considerably higher permeability than the same material after machining (and packet assembling in case of electric sheets). This is indicated in the above plots by different magnetisation curves for similar materials. In most cases, the original data points represent commutating curves obtained with measurements at 50Hz.
</p>

<p>
Additional user-specific materials can be defined as needed. This requires determination of the approximation parameters from the original data points, preferably with a nonlinear curve fit.
</p>
</html>"));

    end SoftMagnetic;

    package HardMagnetic
      "Characteristics of common permanent magnetic materials (temperature dependence considered)"
      extends Modelica.Icons.MaterialPropertiesPackage;

      record BaseData "Record for permanent magnetic material data"
        extends Modelica.Icons.Record;

        parameter SI.MagneticFieldStrength H_cBRef = 1
          "Coercivity at reference temperature";
        parameter SI.MagneticFluxDensity B_rRef = 1
          "Remanence at reference temperature";
        parameter SI.Temperature T_ref = 293.15 "Reference temperature";
        parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_Br=
                                                              0
          "Temperature coefficient of remanence at reference temperature";

        parameter SI.Temperature T_op = 293.15 "Operating temperature";

        final parameter SI.MagneticFluxDensity B_r = B_rRef * (1 + alpha_Br *(T_op - T_ref))
          "Remanence at operating temperature";
        final parameter SI.MagneticFieldStrength H_cB = H_cBRef * (1 + alpha_Br *(T_op - T_ref))
          "Coercivity at operating temperature";
        final parameter SI.RelativePermeability mu_r = B_r/ (mu_0 * H_cB)
          "Relative permeability";

        annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a> for a description of all permanent magnetic material characteristics of this package.
</p>
</html>"));
      end BaseData;

      record NdFeB "NdFeB sintered; exemplary values"
        extends Modelica.Magnetic.FluxTubes.Material.HardMagnetic.BaseData(
          H_cBRef=900000,
          B_rRef=1.2,
          T_ref=20 + 273.15,
          alpha_Br=-0.001);
        annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a> for a description of all permanent magnetic material characteristics of this package.
</p>
</html>"));
      end NdFeB;

      record Sm2Co17 "Sm2Co17 sintered, exemplary values"
        extends Modelica.Magnetic.FluxTubes.Material.HardMagnetic.BaseData(
          H_cBRef=750000,
          B_rRef=1.02,
          T_ref=20 + 273.15,
          alpha_Br=-0.0003);
        annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a> for a description of all permanent magnetic material characteristics of this package.
</p>
</html>"));
      end Sm2Co17;

      record SmCo5 "SmCo5 sintered, exemplary values"
        extends Modelica.Magnetic.FluxTubes.Material.HardMagnetic.BaseData(
          H_cBRef=720000,
          B_rRef=0.95,
          T_ref=20 + 273.15,
          alpha_Br=-0.0004);
        annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a> for a description of all permanent magnetic material characteristics of this package.
</p>
</html>"));
      end SmCo5;

      record PlasticNdFeB "Plastic-bonded NdFeB, exemplary values"
        extends Modelica.Magnetic.FluxTubes.Material.HardMagnetic.BaseData(
          H_cBRef=400000,
          B_rRef=0.58,
          T_ref=20 + 273.15,
          alpha_Br=-0.001);
        annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a> for a description of all permanent magnetic material characteristics of this package.
</p>
</html>"));
      end PlasticNdFeB;

      record PlasticSmCo "Plastic-bonded Sm-Co, exemplary values"
        extends Modelica.Magnetic.FluxTubes.Material.HardMagnetic.BaseData(
          H_cBRef=385000,
          B_rRef=0.57,
          T_ref=20 + 273.15,
          alpha_Br=-0.0004);
        annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a> for a description of all permanent magnetic material characteristics of this package.
</p>
</html>"));
      end PlasticSmCo;

      record HardFerrite "Hard ferrite sintered, exemplary values"
        extends Modelica.Magnetic.FluxTubes.Material.HardMagnetic.BaseData(
          H_cBRef=170000,
          B_rRef=0.38,
          T_ref=20 + 273.15,
          alpha_Br=-0.002);
        annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a> for a description of all permanent magnetic material characteristics of this package.
</p>
</html>"));
      end HardFerrite;

      record PlasticHardFerrite "Plastic-bonded hard ferrite, exemplary values"
        extends Modelica.Magnetic.FluxTubes.Material.HardMagnetic.BaseData(
          H_cBRef=130000,
          B_rRef=0.21,
          T_ref=20 + 273.15,
          alpha_Br=-0.002);
        annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a> for a description of all permanent magnetic material characteristics of this package.
</p>
</html>"));
      end PlasticHardFerrite;

      annotation (Documentation(info="<html>
<p>
Typical values for remanence, coercivity and the temperature coefficient of remanence are provided for the common permanent magnetic materials illustrated below.
<dl>
<dd>
<IMG src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HardMagnetic/HardMagneticMaterials.png\" ALT=\"Demagnetization characteristics of included permanent magnetic materials\">
</dd>
</dl>
<p>
Linear demagnetization curves are modelled. The characteristic, temperature-dependent \"knee\" of many permanent magnetic materials is not considered, since proper design of permanent magnetic circuits should avoid operation of permanent magnets \"below\" that point due to partial demagnetization. As a result, the temperature coefficient of coercivity is not considered. Only the temperature coefficient of remanence alpha_Br is accounted for, since it describes the dependende of the demagnetization curve on the temperature sufficiently for the region \"above the knee-point\".
</p>
<p>
Additional user-specific materials can be defined as needed.
</p>
</html>"));
    end HardMagnetic;
  annotation (Documentation(info="<html>
</html>"));
  end Material;

  package Interfaces "Interfaces of magnetic network components"
    extends Modelica.Icons.InterfacesPackage;

    connector MagneticPort "Generic magnetic port"
      SI.MagneticPotentialDifference V_m "Magnetic potential at the port";
      flow SI.MagneticFlux Phi "Magnetic flux flowing into the port";

      annotation (defaultComponentName = "mag",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}),
         graphics),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                graphics));
    end MagneticPort;

    connector PositiveMagneticPort "Positive magnetic port"
      extends Modelica.Magnetic.FluxTubes.Interfaces.MagneticPort;

      annotation (defaultComponentName = "port_p",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={255,127,0},
              fillColor={255,127,0},
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Text(
              extent={{-100,160},{-100,100}},
              lineColor={255,127,0},
              textString="%name"), Rectangle(
              extent={{-40,40},{40,-40}},
              lineColor={255,127,0},
              fillColor={255,127,0},
              fillPattern=FillPattern.Solid)}));

    end PositiveMagneticPort;

    connector NegativeMagneticPort "Negative magnetic port"
      extends Modelica.Magnetic.FluxTubes.Interfaces.MagneticPort;

    annotation (defaultComponentName = "port_n",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={255,127,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Text(
              extent={{100,160},{100,100}},
              lineColor={255,127,0},
              textString="%name"), Rectangle(
              extent={{-40,40},{40,-40}},
              lineColor={255,127,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));

    end NegativeMagneticPort;

    partial model PartialTwoPortsElementary
      "Partial component with two magnetic ports p and n for textual programming"

      Modelica.Magnetic.FluxTubes.Interfaces.PositiveMagneticPort port_p
        "Positive magnetic port"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
            rotation=0)));
      Modelica.Magnetic.FluxTubes.Interfaces.NegativeMagneticPort port_n
        "Negative magnetic port"
        annotation (Placement(transformation(extent={{90,-10},{110,10}},
            rotation=0)));

      annotation (
        Documentation(info="<html>
<p>
Partial model of a flux tube component with two magnetic ports:
the positive port connector port_p, and the negative port
connector port_n.
</p>
</html>
"),     Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
        Window(
          x=0.33,
          y=0.04,
          width=0.63,
          height=0.67),
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics));
    end PartialTwoPortsElementary;

    partial model PartialTwoPorts
      "Partial component with magnetic potential difference between two magnetic ports p and n and magnetic flux Phi from p to n"

      extends Modelica.Magnetic.FluxTubes.Interfaces.PartialTwoPortsElementary;
      SI.MagneticPotentialDifference V_m
        "Magnetic potential difference between both ports";
      SI.MagneticFlux Phi "Magnetic flux from port_p to port_n";

    equation
      V_m = port_p.V_m - port_n.V_m;
      Phi = port_p.Phi;
      0 = port_p.Phi + port_n.Phi;

      annotation (Documentation(info="<html>
<p>
It is assumed that the magnetic flux flowing into port_p is identical to the flux flowing out of port_n.
This magnetic flux is provided explicitly as flux Phi.
</p>
</html>"));
    end PartialTwoPorts;

    partial model PartialFixedShape
      "Base class for flux tubes with fixed shape during simulation; linear or non-linear material characteristics"

      extends Modelica.Magnetic.FluxTubes.Interfaces.PartialTwoPorts;

      parameter Boolean nonLinearPermeability = true
        "= true, if non-linear rel. permeability is used, otherwise constant rel. permeability"
        annotation(Dialog(group="Material"),Evaluate=true);
      parameter SI.RelativePermeability mu_rConst = 1
        "Constant relative permeability; used if nonLinearPermeability = false"
         annotation(Dialog(group="Material", enable = not nonLinearPermeability));

      parameter Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData
        material=
        Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData()
        "Ferromagnetic material characteristics; used if nonLinearPermeability = true"
        annotation(choicesAllMatching=true, Dialog(group="Material", enable = nonLinearPermeability));

      SI.Reluctance R_m "Magnetic reluctance";
      SI.Permeance G_m "Magnetic permeance";
      SI.MagneticFluxDensity B "Magnetic flux density";
      SI.CrossSection A "Cross-sectional area penetrated by magnetic flux";
      SI.MagneticFieldStrength H "Magnetic field strength";

        SI.RelativePermeability mu_r "Relative magnetic permeability";

    equation
      mu_r = if nonLinearPermeability then
        Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.mu_rApprox(
            B,
            material.mu_i,
            material.B_myMax,
            material.c_a,
            material.c_b,
            material.n) else mu_rConst;
      R_m = 1/G_m;
      V_m = Phi * R_m;
      B = Phi/A;
      H = B / (mu_0 * mu_r);

      annotation (
        Window(
          x=0.16,
          y=0.15,
          width=0.6,
          height=0.6),
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={255,128,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-70,0},{-90,0}}, color={255,128,0}),
          Line(points={{70,0},{90,0}}, color={255,128,0}),
          Text(
            extent={{-150,-100},{150,-60}},
            textString="%name",
            lineColor={0,0,255})}),
        Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
      Documentation(info="<html>
<p>
Please refer to the description of  the sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">Shapes.FixedShape</a> for utilisation of this partial model.
</p>
</html>"));
    end PartialFixedShape;

    partial model PartialForce
      "Base class for flux tubes with reluctance force generation; constant permeability"

      extends Modelica.Magnetic.FluxTubes.Interfaces.PartialTwoPorts;

      parameter Boolean useSupport=false
        "= true, if support flange enabled, otherwise implicitly grounded"
          annotation(Evaluate=true, HideResult=true);

      parameter SI.RelativePermeability mu_r(start = 1)
        "Relative magnetic permeability";

      SI.Force F_m "Reluctance force";
      Modelica.SIunits.Length s = flange.s - s_support
        "Distance between flange and support";

      SI.Reluctance R_m "Magnetic reluctance";
      SI.Permeance G_m "Magnetic permeance";
      SI.Permeability dGmBydx
        "Derivative of permeance with respect to armature position";
      parameter Integer dlBydx = 1
        "Derivative of flux tube's varying dimension with respect to armature position; set to +1 or -1";

     Modelica.Mechanics.Translational.Interfaces.Flange_b flange
        "Generated reluctance force at armature position"
      annotation (Placement(transformation(extent={{-10,90},{10,110}}, rotation=
             0)));
     Modelica.Mechanics.Translational.Interfaces.Support support(
                 s=s_support, f=-flange.f) if
        useSupport "Support/housing of component"
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
            rotation=0)));

    protected
      Modelica.SIunits.Length s_support "Absolute position of support flange";

    equation
      V_m = Phi * R_m;
      R_m = 1/G_m;
      F_m = 0.5 * V_m^2 * dGmBydx;

      if not useSupport then
         s_support = 0;
      end if;
      flange.f = -F_m;

      annotation (
        Window(
          x=0.16,
          y=0.15,
          width=0.6,
          height=0.6),
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{30,30},{70,-30}},
            lineColor={255,128,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-70,0},{-90,0}}, color={255,128,0}),
          Line(points={{70,0},{90,0}}, color={255,128,0}),
          Text(
            extent={{-150,-80},{150,-40}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-10,-100},{-30,-120}}, color={0,0,0}),
          Line(points={{-30,-100},{-50,-120}}, color={0,0,0}),
          Line(points={{-30,-100},{30,-100}}, color={0,0,0}),
          Line(points={{10,-100},{-10,-120}}, color={0,0,0}),
          Line(points={{30,-100},{10,-120}}, color={0,0,0}),
          Rectangle(
            extent={{-70,30},{-30,-30}},
            lineColor={255,128,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-10,80},{10,-30}},
            lineColor={0,0,0},
            fillColor={0,127,0},
            fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
      Documentation(info="<html>
<p>
Please refer to the description of  the sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Shapes.Force</a> for utilisation of this partial model.
</p>
</html>"));
    end PartialForce;

    partial model PartialLeakage
      "Base class for leakage flux tubes with position-independent permeance and hence no force generation; mu_r=1"

      extends Modelica.Magnetic.FluxTubes.Interfaces.PartialTwoPorts;

      SI.Reluctance R_m "Magnetic reluctance";
      SI.Permeance G_m "Magnetic permeance";

    equation
      V_m = Phi * R_m;
      R_m = 1/G_m;

      annotation (
        Window(
          x=0.16,
          y=0.15,
          width=0.6,
          height=0.6),
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={255,128,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-70,0},{-90,0}}, color={255,128,0}),
          Line(points={{70,0},{90,0}}, color={255,128,0}),
          Text(
            extent={{-150,-100},{150,-60}},
            textString="%name",
            lineColor={0,0,255})}),
        Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
      Documentation(info="<html>
<p>
Please refer to the description of  the sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Shapes.Leakage</a> for utilisation of this partial model.
</p>
</html>"));
    end PartialLeakage;
    annotation (             Window(
        x=0,
        y=0.48,
        width=0.2,
        height=0.21,
        library=1,
        autolayout=1),
    Documentation(info="<html>
<p>
This package contains connectors for the magnetic domain and partial models for lumped magnetic network components.
</p>

</html>"));
  end Interfaces;

  package Sources
    "Sources of different complexity of magnetomotive force and magnetic flux"
    extends Modelica.Icons.SourcesPackage;

    model ConstantMagneticPotentialDifference "Constant magnetomotive force"

      extends Modelica.Magnetic.FluxTubes.Interfaces.PartialTwoPortsElementary;
      parameter SI.MagneticPotentialDifference V_m
        "Magnetic potential differnce";
      SI.MagneticFlux Phi "Magnetic flux from port_p to port_n";

    equation
      V_m = port_p.V_m - port_n.V_m;
      Phi = port_p.Phi;
      0 = port_p.Phi + port_n.Phi;

      annotation (defaultComponentName = "constantSource",
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Ellipse(
            extent={{-50,-50},{50,50}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{100,0},{50,0}}, color={255,127,0}),
          Line(points={{-50,0},{-100,0}}, color={255,127,0}),
          Text(
            extent={{-80,-20},{-80,-40}},
            lineColor={255,128,0},
            textString="+"),
          Text(
            extent={{80,-20},{80,-40}},
            lineColor={255,128,0},
            textString="-"),
          Text(
            extent={{-150,-110},{150,-70}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-50,0},{50,0}}, color={255,127,0})}),
        Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
        Window(
          x=0.48,
          y=0.25,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>
Magnetic circuits under steady-state conditions, i.e., with stationary magnetic fields (change of magnetic flux  d&Phi;/dt = 0) can be described with constant sources of a magnetic potential difference or magnetomotive force (mmf). Constant magnetic potential differences are imposed by
</p>
<ul>
<li>coils with stationary current (di / dt = 0) and </li>
<li>permanent magnets modelled with <i>Th&eacute;venin</i>'s equivalent magnetic circuit. </li>
</ul>
<p>
For modelling of reluctance actuators with this source component it is assumed that the armature is fixed so that no motion-induced flux change d&Phi;/dt can occur.
</p>
</html>"));
    end ConstantMagneticPotentialDifference;

    model SignalMagneticPotentialDifference
      "Signal-controlled magnetomotive force"

      extends Modelica.Magnetic.FluxTubes.Interfaces.PartialTwoPortsElementary;
      Modelica.Blocks.Interfaces.RealInput V_m "Magnetic potential difference"
        annotation (Placement(transformation(
          origin={0,90},
          extent={{10,-10},{-10,10}},
          rotation=90)));
      SI.MagneticFlux Phi "Magnetic flux from port_p to port_n";

    equation
      V_m = port_p.V_m - port_n.V_m;
      Phi = port_p.Phi;
      0 = port_p.Phi + port_n.Phi;
      annotation (defaultComponentName = "signalSource",
        Window(
          x=0.27,
          y=0.04,
          width=0.61,
          height=0.73),
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-100,0},{-50,0}}, color={255,127,0}),
          Line(points={{50,0},{100,0}}, color={255,127,0}),
          Text(
            extent={{-80,-20},{-80,-40}},
            lineColor={255,128,0},
            textString="+"),
          Text(
            extent={{80,-20},{80,-40}},
            lineColor={255,128,0},
            textString="-"),
          Line(points={{0,100},{0,50}}, color={255,127,0}),
          Text(
            extent={{-150,-110},{150,-70}},
            textString="%name",
            lineColor={0,0,255}),
          Ellipse(
            extent={{-50,-50},{50,50}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-50,0},{50,0}}, color={255,127,0})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
        Documentation(info="<html>
<p>
In electromagnetic devices, a change of a coil's magnetic flux linkage &Psi; reacts on the electrical subsystem in that a voltage v is induced due to <i>Faraday</i>'s law:
</p>
<pre>
    v = - d&Psi;/dt
</pre>
<p>This reaction can possibly be neglected for</p>
<ul>
<li>modelling ofelectromagnetic actuators under quasi-stationary conditions (slow current change, slow armature motion),
<li>modelling of current-controlled electromagnetic actuators (ideal current source) and</li>
<li>for system simulation where the system dynamics is not governed by an electromagnetic actuator, but by the surrounding subsystems.</li>
</ul>
<p>
In these cases, the magnetic potential difference or magnetomotive force imposed by a coil can easily be modelled with a signal-controlled source. Except for the neglected dynamics, steady-state actuator forces will be calculated properly in actuator models based on these sources.
</p>
</html>"));
    end SignalMagneticPotentialDifference;

    model ConstantMagneticFlux "Source of constant magnetic flux"

      extends Modelica.Magnetic.FluxTubes.Interfaces.PartialTwoPortsElementary;
      parameter SI.MagneticFlux Phi = 1 "Magnetic flux";
      SI.MagneticPotentialDifference V_m
        "Magnetic potential difference between both ports";

    equation
      V_m = port_p.V_m - port_n.V_m;
      Phi = port_p.Phi;
      0 = port_p.Phi + port_n.Phi;
      annotation (defaultComponentName = "constantSource",
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Text(
            extent={{-150,-110},{150,-70}},
            textString="%name",
            lineColor={0,0,255}),
          Polygon(
            points={{80,0},{60,6},{60,-6},{80,0}},
            lineColor={255,128,0},
            fillColor={255,128,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-100,0},{-50,0}}, color={255,127,0}),
          Line(points={{50,0},{100,0}}, color={255,127,0}),
          Ellipse(
            extent={{-50,-50},{50,50}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{0,50},{0,-50}}, color={255,127,0})}),
        Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-125,0},{-115,0}}, color={160,160,164}),
          Line(points={{-120,-5},{-120,5}}, color={160,160,164}),
          Line(points={{115,0},{125,0}}, color={160,160,164})}),
        Window(
          x=0.48,
          y=0.25,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>
Sources of a constant magnetic flux are useful for modelling of permanent magnets with <i>Norton</i>'s magnetic equivalent circuit.
</p>
</html>"));
    end ConstantMagneticFlux;

    model SignalMagneticFlux "Signal-controlled magnetic flux source"

      extends Modelica.Magnetic.FluxTubes.Interfaces.PartialTwoPortsElementary;
      Modelica.Blocks.Interfaces.RealInput Phi "Magnetic flux"
        annotation (Placement(transformation(
          origin={0,90},
          extent={{10,-10},{-10,10}},
          rotation=90)));
      SI.MagneticPotentialDifference V_m
        "Magnetic potential difference between both ports";

    equation
      V_m = port_p.V_m - port_n.V_m;
      Phi = port_p.Phi;
      0 = port_p.Phi + port_n.Phi;
      annotation (defaultComponentName = "signalSource",
        Window(
          x=0.27,
          y=0.04,
          width=0.61,
          height=0.73),
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Polygon(
            points={{80,0},{60,6},{60,-6},{80,0}},
            lineColor={255,128,0},
            fillColor={255,128,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,-110},{150,-70}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-100,0},{-50,0}}, color={255,127,0}),
          Line(points={{50,0},{100,0}}, color={255,127,0}),
          Line(points={{0,100},{0,50}}, color={255,127,0}),
          Ellipse(
            extent={{-50,-50},{50,50}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{0,50},{0,-50}}, color={255,127,0})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
        Documentation(info="<html>
<p>
This source of a magnetic flux is intended for test purposes, e.g., for simulation and subsequent plotting of a softmagnetic material's magnetisation characteristics if used together with a non-linear reluctance element.
</p>
</html>"));
    end SignalMagneticFlux;

    annotation (             Window(
        x=0.45,
        y=0.01,
        width=0.35,
        height=0.49,
        library=1,
        autolayout=1),
    Documentation(info="<html>
<p>
This package contains sources of a magnetic potential difference or a magnetic flux:
</p>
</html>"));
  end Sources;

  package Sensors "Sensors to measure variables in magnetic networks"
    extends Modelica.Icons.SensorsPackage;

  model MagneticPotentialDifferenceSensor
      "Sensor to measure magnetic potential difference"
    extends Modelica.Icons.RotationalSensor;
    extends Modelica.Magnetic.FluxTubes.Interfaces.PartialTwoPortsElementary;

    Modelica.Blocks.Interfaces.RealOutput V_m
        "Magnetic potential difference between ports p and n as output signal"
       annotation (Placement(transformation(
          origin={0,-100},
          extent={{10,-10},{-10,10}},
          rotation=90)));
    SI.MagneticFlux Phi "Magnetic flux from port_p to port_n";

  equation
    V_m = port_p.V_m - port_n.V_m;
    Phi = port_p.Phi;
    Phi = 0;
    0 = port_p.Phi + port_n.Phi;

    annotation (
      Window(
        x=0.28,
        y=0.29,
        width=0.6,
        height=0.6),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
            Text(
              extent={{-52,1},{48,-57}},
              lineColor={0,0,0},
              textString="V_m"),
            Line(points={{-70,0},{-90,0}}, color={0,0,0}),
            Line(points={{70,0},{90,0}}, color={0,0,0}),
            Line(points={{0,-90},{0,-70}}, color={0,0,0}),
            Text(
              extent={{-150,120},{150,80}},
              textString="%name",
              lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
            Line(points={{-70,0},{-100,0}}, color={255,128,0}),
            Line(points={{70,0},{100,0}}, color={255,128,0}),
            Line(points={{0,-100},{0,-70}}, color={0,0,0})}));
  end MagneticPotentialDifferenceSensor;

  model MagneticFluxSensor "Sensor to measure magnetic flux"
    extends Modelica.Magnetic.FluxTubes.Interfaces.PartialTwoPortsElementary;
    extends Modelica.Icons.RotationalSensor;

    Modelica.Blocks.Interfaces.RealOutput Phi
        "Magnetic flux from port p to port n as output signal"
        annotation (Placement(transformation(
          origin={0,-100},
          extent={{10,-10},{-10,10}},
          rotation=90)));
  equation
    port_p.V_m = port_n.V_m;
    Phi = port_p.Phi;
    0 = port_p.Phi + port_n.Phi;

        annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                      graphics),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{0,-100},{0,-70}}, color={0,0,0}),
            Line(points={{-70,0},{-90,0}}, color={0,0,0}),
            Line(points={{70,0},{90,0}}, color={0,0,0}),
            Text(extent={{-29,-11},{30,-70}}, textString="Phi"),
            Text(
              extent=[-150,120; 150,80],
              textString="%name",
              lineColor={0,0,255}),
            Line(points=[0,-90; 0,-70])}));
  end MagneticFluxSensor;
    annotation (Documentation(info="<html>
<p>
For analysis of magnetic networks, only magnetic potential differences and magnetic flux are variables of interest. For that reason, a magnetic potential sensor is not provided.
</p>
</html>"));
  end Sensors;

annotation (
  Window(
    x=0.45,
    y=0.01,
    width=0.44,
    height=0.65,
    library=1,
    autolayout=1),
  Documentation(info="<html>
<p>
This library contains components for modelling of electromagnetic devices with lumped magnetic networks. Those models are suited for both rough design of the magnetic subsystem of a device as well as for efficient dynamic simulation at system level together with neighbouring subsystems. At present, components and examples for modelling of <i>translatory</i> electromagnetic and electrodynamic actuators are provided. If needed, these components can be adapted to network modelling of <i>rotational</i> electrical machines.
</p>
<p>
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide\">User's Guide</a> gives a short introduction to the underlying concept of <b>magnetic flux tubes</b>, summarizes the calculation of magnetic <b>reluctance forces</b> from lumped magnetic network models and lists <b>reference literature</b>.
</p>
<p>
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples\">Examples</a> illustrates the usage of magnetic network models with simple models from different fields of application.
</p>

<p>
Copyright &copy; 2005-2010, Modelica Association and Thomas B&ouml;drich.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>
", revisions="<html>
<table border=1>

<thead>
<tr><td>Version</td> <td>Date</td>  <td>Author(s)</td> <td>Comments</td></tr>
</thead>

<tbody>
<tr><td>1.3</td>  <td>2010-04-22</td>
    <td>Christian&nbsp;Kral</td> <td>Added conditional heat port to EddyCurrent model</td> </tr>
<tr><td>1.2</td>  <td>2009-08-11</td>
    <td>Christian&nbsp;Kral<br>
        Anton&nbsp;Haumer<br>
        Thomas&nbsp;B&ouml;drich&nbsp;<br>
        Martin&nbsp;Otter</td> <td>Update and improvement for inclusion in the
        Modelica Standard Library.</td> </tr>
<tr><td>1.1</td>  <td>2009-05-19</td>  <td>Thomas B&ouml;drich </td>
    <td> Coupling coefficient in Basic.ElectroMagneticConverter Removed.<br>
         Basic.EddyCurrent added .<br>
         Example MovingCoilActuator, especially PermeanceModel, completely revised. <br>
         Leakage coefficient replaced by coupling coefficient in Basic.LeakageWithCoefficient. <br>
         Utilities.CoilDesign: parameter U renamed to V_op,CoilDesign moved to Utilities.<br>
         Reference direction for magnetic flux added in all sources.<br>
         degC replaced by K for compatibility with Modelica 3.0.<br>
         redeclare in Sensors for compatibility with Modelica 3.0 removed.<br>
         Partial flux tube components moved to Interfaces and basic elements moved to new package Basic. </td> </tr>
<tr><td>1.0</td>  <td>2007-10-11</td>  <td>Thomas B&ouml;drich </td> <td>Release of version 1.0 of the library </td> </tr>
<tr><td></td>     <td>2005</td>        <td>Thomas B&ouml;drich </td> <td>First release of a Modelica magnetic library</td> </tr>
</tbody>

</table>

</html>"),
  Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}},
      grid={2,2}), graphics={
        Rectangle(extent={{36,2},{60,-84}}, lineColor={0,0,0}),
        Line(points={{20,2},{-60,2},{-60,-84},{20,-84},{20,-62},{-36,-62},{-36,
              -20},{20,-20},{20,2}}, color={0,0,0}),
        Line(points={{-64,-28},{-32,-36}}, color={0,0,0}),
        Line(points={{-64,-52},{-32,-60}}, color={0,0,0}),
        Line(points={{-64,-16},{-32,-24}}, color={0,0,0}),
        Line(points={{-64,-16},{-78,-16}}, color={0,0,0}),
        Line(points={{-64,-52},{-78,-52}}, color={0,0,0}),
        Ellipse(extent={{-78,-20},{-86,-12}}, lineColor={0,0,0}),
        Ellipse(extent={{-78,-56},{-86,-48}}, lineColor={0,0,0}),
        Line(points={{-64,-40},{-32,-48}}, color={0,0,0})}));
end FluxTubes;
