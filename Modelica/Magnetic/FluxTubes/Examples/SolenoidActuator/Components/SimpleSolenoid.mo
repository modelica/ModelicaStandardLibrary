within Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components;
model SimpleSolenoid
  "Simple network model of a lifting magnet with planar armature end face"

  parameter SI.Resistance R=10 "Armature coil resistance";
  parameter Real N=957 "Number of turns";

  //yoke
  parameter SI.Radius r_yokeOut=15e-3 "Outer yoke radius" annotation (
      Dialog(group="Parameters", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/SolenoidActuator/Solenoid_dimensions.png"));
  parameter SI.Radius r_yokeIn=13.5e-3 "Inner yoke radius";
  parameter SI.Length l_yoke=35e-3 "Axial yoke length";
  parameter SI.Length t_yokeBot=3.5e-3 "Axial thickness of yoke bottom";

  //pole
  parameter SI.Length l_pole=6.5e-3 "Axial length of pole";
  parameter SI.Length t_poleBot=3.5e-3
    "Axial thickness of bottom at pole side";

  parameter SI.Length t_airPar=0.65e-3
    "Radial thickness of parasitic air gap due to slide guiding";

  parameter FluxTubes.Material.SoftMagnetic.BaseData material=
      Material.SoftMagnetic.Steel.Steel_9SMnPb28()
    "Ferromagnetic material characteristics"
    annotation (choicesAllMatching=true, Dialog(group="Material"));

  //armature
  parameter SI.Radius r_arm=5e-3 "Armature radius = pole radius"
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.Length l_arm=26e-3 "Armature length"
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.TranslationalSpringConstant c=1e11
    "Spring stiffness between impact partners"
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.TranslationalDampingConstant d=400
    "Damping coefficient between impact partners"
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.Position x_min=0.25e-3
    "Stopper at minimum armature position"
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.Position x_max=5e-3
    "Stopper at maximum armature position"
    annotation (Dialog(group="Armature and stopper"));

  SI.Position x(start=x_max, stateSelect=StateSelect.prefer)
    "Armature position, alias for flange position (identical with length of working air gap)";

protected
  parameter SI.Density rho_steel=7853
    "Density for calculation of armature mass from geometry";

public
  FluxTubes.Basic.Ground ground annotation (Placement(transformation(
          extent={{50,10},{70,30}})));
  FluxTubes.Basic.ElectroMagneticConverter coil(final N=N, i(fixed=true))
    "Electromagnetic converter" annotation (Placement(transformation(
        origin={0,20},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Basic.Resistor r(final R=R)
    "Coil resistance" annotation (Placement(transformation(extent={{-70,
            -30},{-50,-10}})));
  FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux g_mFeYokeSide(
    final nonLinearPermeability=true,
    final material=material,
    final l=l_yoke - (t_poleBot + t_yokeBot)/2,
    final r_i=r_yokeIn,
    final r_o=r_yokeOut)
    "Permeance of hollow cylindric section of ferromagnetic yoke"
    annotation (Placement(transformation(extent={{-10,80},{10,100}})));

  FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux g_mFeArm(
    final nonLinearPermeability=true,
    final material=material,
    final l=l_yoke - (t_yokeBot + t_poleBot)/2 - l_pole - (x_max +
        x_min)/2,
    final r_i=0,
    final r_o=r_arm) "Permeance of ferromagnetic armature" annotation (
      Placement(transformation(
        origin={16,40},
        extent={{-10,-10},{10,10}},
        rotation=180)));

  FluxTubes.Shapes.Force.HollowCylinderAxialFlux g_mAirWork(
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
  FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux g_mFeYokeBot(
    final nonLinearPermeability=true,
    final material=material,
    final l=t_yokeBot,
    final r_i=r_arm + t_airPar,
    final r_o=r_yokeIn)
    "Permeance of bottom side of ferromagnetic yoke" annotation (
      Placement(transformation(
        origin={80,80},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux g_mAirPar(
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
  FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux g_mFePoleBot(
    final l=t_poleBot,
    final r_i=r_arm,
    final r_o=r_yokeIn,
    final nonLinearPermeability=true,
    final material=material) "Permeance of bottom side of pole"
    annotation (Placement(transformation(
        origin={-72,80},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux g_mFePole(
    final nonLinearPermeability=true,
    final material=material,
    final l=l_pole,
    final r_i=0,
    final r_o=r_arm) "Permeance of ferromagnetic pole" annotation (
      Placement(transformation(
        origin={-72,40},
        extent={{10,-10},{-10,10}},
        rotation=270)));

  FluxTubes.Examples.Utilities.TranslatoryArmatureAndStopper armature(
    final m=rho_steel*l_arm*pi*r_arm^2,
    final x_max=x_max,
    final x_min=x_min,
    final L=0,
    final c=c,
    final d=d,
    n=2,
    v(fixed=true))
    "Inertia of armature and stoppers at end of stroke range"
    annotation (Placement(transformation(extent={{64,-10},{84,10}})));
  FluxTubes.Shapes.Leakage.QuarterCylinder g_mLeak1(l=2*pi*(r_arm +
        t_airPar/2))
    "Leakage permeance between inner edge of yoke bore and armature side face"
    annotation (Placement(transformation(
        origin={60,50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  FluxTubes.Shapes.Leakage.QuarterHollowCylinder g_mLeak2(final l=2*pi*
        r_arm, final ratio=8)
    "Leakage permeance between inner side of yoke bottom and armature side (r_i = t_airPar)"
    annotation (Placement(transformation(
        origin={40,50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  FluxTubes.Shapes.Force.LeakageAroundPoles g_mLeakWork(
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
    "Electrical connector" annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n
    "Electrical connector" annotation (Placement(transformation(extent={{-90,-110},{-110,-90}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange
    "Flange of component" annotation (Placement(transformation(extent={
            {90,-10},{110,10}})));
equation
  x = flange.s;
  connect(r.p, p) annotation (Line(points={{-70,-20},{-90,-20},{-90,100},{-100,100}},
                      color={0,0,255}));
  connect(armature.flange_b, flange) annotation (Line(points={{84,0},{
          88,0},{92,0},{100,0}}, color={0,127,0}));
  connect(armature.flange_a, g_mAirWork.flange) annotation (Line(points=
         {{64,0},{34,0},{34,52},{-30,52},{-30,40}}, color={0,127,0}));
  connect(g_mAirWork.flange, g_mLeakWork.flange) annotation (Line(
        points={{-30,40},{-30,52},{34,52},{34,80},{-30,80}}, color={0,
          127,0}));
  connect(r.n, coil.p) annotation (Line(points={{-50,-20},{-10,-20},{-10,10}},
                color={0,0,255}));
  connect(coil.n, n) annotation (Line(points={{10,10},{10,-100},{-100,-100}},
                                                                          color={0,0,255}));
  connect(coil.port_p, g_mAirWork.port_p)
    annotation (Line(points={{-10,30},{-20,30}},color={255,127,0}));
  connect(g_mAirWork.port_p, g_mLeakWork.port_p)
    annotation (Line(points={{-20,30},{-20,70}}, color={255,127,0}));
  connect(g_mAirWork.port_n, g_mLeakWork.port_n)
    annotation (Line(points={{-40,30},{-40,70}}, color={255,127,0}));
  connect(g_mFePole.port_p, g_mAirWork.port_n)
    annotation (Line(points={{-72,30},{-40,30}}, color={255,127,0}));
  connect(g_mFePoleBot.port_p, g_mFePole.port_n)
    annotation (Line(points={{-72,70},{-72,50}}, color={255,127,0}));
  connect(g_mFePoleBot.port_n, g_mFeYokeSide.port_p)
    annotation (Line(points={{-72,90},{-10,90}}, color={255,127,0}));
  connect(g_mFeYokeSide.port_n, g_mFeYokeBot.port_n)
    annotation (Line(points={{10,90},{80,90}}, color={255,127,0}));
  connect(g_mFeYokeBot.port_p, g_mAirPar.port_n)
    annotation (Line(points={{80,70},{80,60}}, color={255,127,0}));
  connect(g_mFeArm.port_p, g_mLeak2.port_p)
    annotation (Line(points={{26,40},{40,40}}, color={255,127,0}));
  connect(g_mLeak2.port_p, g_mLeak1.port_p)
    annotation (Line(points={{40,40},{60,40}}, color={255,127,0}));
  connect(g_mLeak1.port_p, g_mAirPar.port_p)
    annotation (Line(points={{60,40},{80,40}}, color={255,127,0}));
  connect(g_mLeak2.port_n, g_mLeak1.port_n)
    annotation (Line(points={{40,60},{60,60}}, color={255,127,0}));
  connect(g_mLeak1.port_n, g_mAirPar.port_n)
    annotation (Line(points={{60,60},{80,60}}, color={255,127,0}));
  connect(g_mFeArm.port_n, coil.port_n) annotation (Line(points={{6,40},{6,30},{10,30}},
                          color={255,127,0}));
  connect(ground.port, g_mLeak1.port_p) annotation (Line(
      points={{60,30},{60,40}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(
      preserveAspectRatio=true,
      extent={{-100,-100},{100,100}}), graphics={
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
        extent={{150,150},{-150,110}},
        textColor={0,0,255},
        textString="%name")}), Documentation(info="<html>
<p>
Please refer to the <strong>Parameters</strong> section for a schematic drawing of this axis-symmetric lifting magnet.
In the half-section below, the flux tube elements of the actuator's magnetic circuit are superimposed on a field plot obtained with FEA. The magnetomotive force imposed by the coil is modelled as one lumped element. As a result, the radial leakage flux between armature and yoke that occurs especially at large working air gaps can not be considered properly. This leads to a a higher total reluctance and lower inductance respectively compared to FEA for large working air gaps (i.e., armature close to x_max). Please have a look at the comments associated with the individual model components for a short explanation of their purpose in the model.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/SolenoidActuator/SimpleSolenoidModel_fluxTubePartitioning.png\" alt=\"Field lines and assigned flux tubes of the simple solenoid model\">
</div>

<p>
The coupling coefficient c_coupl in the coil is set to 1 in this example, since leakage flux is accounted for explicitly with the flux tube element G_mLeakWork. Although this leakage model is rather simple, it describes the reluctance force due to the leakage field sufficiently, especially at large air gaps. With decreasing air gap length, the influence of the leakage flux on the actuator's net reluctance force decreases due to the increasing influence of the main working air gap G_mAirWork.
</p>

<p>
During model-based actuator design, the radii and lengths of the flux tube elements (and hence their cross-sectional areas and flux densities) should be assigned with parametric equations so that common design rules are met (e.g., allowed flux density in ferromagnetic parts, allowed current density and required cross-sectional area of winding). For simplicity, those equations are omitted in the example. Instead, the found values are assigned to the model elements directly.
</p>
</html>"));
end SimpleSolenoid;
