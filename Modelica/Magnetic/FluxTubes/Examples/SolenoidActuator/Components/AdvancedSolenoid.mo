within Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components;
model AdvancedSolenoid
  "Advanced network model of a lifting magnet with planar armature end face, split magnetomotive force"

  parameter Real N=957 "Number of turns" annotation (Dialog(group=
          "Parameters", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/SolenoidActuator/Solenoid_dimensions.png"));
  parameter SI.Resistance R=5 "Coil resistance";
  parameter SI.Resistance R_par=1e5
    "Resistance parallel to the coil, in series to C_par";
  parameter SI.Capacitance C_par=1e-9
    "Capacitance parallel to the coil, in series to R_par";

  //yoke
  parameter SI.Radius r_yokeOut=15e-3 "Outer yoke radius";
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
    "Armature position";

  SI.MagneticFlux Psi_tot "Total flux linkage for information only";
  SI.Inductance L_statTot
    "Total static inductance for information only";

protected
  parameter SI.Density rho_steel=7853
    "Density for calculation of armature mass from geometry";

public
  FluxTubes.Basic.Ground ground annotation (Placement(transformation(
          extent={{42,2},{62,22}})));
  FluxTubes.Basic.ElectroMagneticConverter coil1(final N=N/2, i(fixed=true))
    "Electromagnetic conversion in first half of coil" annotation (
      Placement(transformation(
        origin={-46,20},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Basic.Resistor r_1(final R=R)
    "Resistance of first half of coil" annotation (Placement(
        transformation(extent={{-84,-30},{-64,-10}})));
  FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux g_mFeYokeSide1(
    final l=l_yoke/2 - t_poleBot/2,
    final r_i=r_yokeIn,
    final r_o=r_yokeOut,
    final nonLinearPermeability=true,
    final material=material)
    "Permeance of first half of yoke's hollow cylindric section"
    annotation (Placement(transformation(extent={{-50,70},{-30,90}})));

  FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux g_mFeArm(
    final r_i=0,
    final l=l_yoke - (t_yokeBot + t_poleBot)/2 - l_pole - (x_max +
        x_min)/2,
    final r_o=r_arm,
    final nonLinearPermeability=true,
    final material=material) "Permeance of ferromagnetic armature"
    annotation (Placement(transformation(
        origin={10,30},
        extent={{-10,10},{10,-10}},
        rotation=180)));

  FluxTubes.Shapes.Force.HollowCylinderAxialFlux g_mAirWork(
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
  FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux g_mFeYokeBot(
    final l=t_yokeBot,
    final r_i=r_arm + t_airPar,
    final r_o=r_yokeIn,
    final nonLinearPermeability=true,
    final material=material)
    "Permeance of bottom side of ferromagnetic yoke" annotation (
      Placement(transformation(
        origin={74,70},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux g_mAirPar(
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
  FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux g_mFePoleBot(
    final l=t_poleBot,
    final r_i=r_arm,
    final r_o=r_yokeIn,
    final nonLinearPermeability=true,
    final material=material) "Permeance of bottom side of pole"
    annotation (Placement(transformation(
        origin={-78,56},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux g_mFePole(
    final l=l_pole,
    final r_o=r_arm,
    final nonLinearPermeability=true,
    final material=material,
    r_i=0) "Permeance of ferromagnetic pole" annotation (Placement(
        transformation(
        origin={-68,30},
        extent={{-10,10},{10,-10}},
        rotation=180)));

  FluxTubes.Examples.Utilities.TranslatoryArmatureAndStopper armature(
    final x_max=x_max,
    final x_min=x_min,
    final m=rho_steel*l_arm*pi*r_arm^2,
    final L=0,
    final c=c,
    final d=d,
    n=2,
    v(fixed=true))
    "Inertia of armature and stoppers at end of stroke range"
    annotation (Placement(transformation(extent={{64,-10},{84,10}})));
  FluxTubes.Shapes.Leakage.QuarterCylinder g_mLeak1(final l=2*pi*(r_arm +
        t_airPar/2))
    "Leakage permeance between inner edge of yoke bore and armature side face"
    annotation (Placement(transformation(
        origin={60,40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  FluxTubes.Shapes.Leakage.QuarterHollowCylinder g_mLeak2(final ratio=8,
      final l=2*pi*r_arm)
    "Leakage permeance between inner side of yoke bottom and armature side (r_i = t_airPar)"
    annotation (Placement(transformation(
        origin={46,40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  FluxTubes.Basic.ElectroMagneticConverter coil2(final N=N/2, i(fixed=true))
    "Electromagnetic conversion in first half of coil" annotation (
      Placement(transformation(
        origin={30,20},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Basic.Capacitor c_par1(final C=C_par, v(
        start=0, fixed=true))
    "Parasitic capacitance assigned to first half of coil" annotation (
      Placement(transformation(extent={{-56,-50},{-36,-30}})));
  FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux G_mLeakRad(
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
  FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux g_mFeYokeSide2(
    final l=l_yoke/2 - t_yokeBot/2,
    final r_i=r_yokeIn,
    r_o=r_yokeOut,
    final nonLinearPermeability=true,
    final material=material)
    "Permeance of second half of yoke's hollow cylindric section"
    annotation (Placement(transformation(extent={{20,70},{40,90}})));

  Modelica.Electrical.Analog.Basic.Capacitor c_par2(final C=C_par, v(
        start=0, fixed=true))
    "Parasitic capacitance assigned to second half of coil" annotation (
     Placement(transformation(extent={{20,-50},{40,-30}})));
  Modelica.Electrical.Analog.Basic.Resistor r_par1(final R=R_par)
    "Parasitic resistance assigned to first half of coil" annotation (
      Placement(transformation(extent={{-84,-50},{-64,-30}})));
  Modelica.Electrical.Analog.Basic.Resistor r_par2(final R=R_par)
    "Parasitic resistance assigned to second half of coil" annotation (
      Placement(transformation(extent={{-8,-50},{12,-30}})));
  Modelica.Electrical.Analog.Basic.Resistor r_2(final R=R)
    "Resistance of second half of coil" annotation (Placement(
        transformation(extent={{-8,-30},{12,-10}})));
  FluxTubes.Shapes.Leakage.QuarterCylinder g_mLeak3(final l=2*pi*(r_arm +
        t_airPar/2))
    "Leakage permeance between outer edge of yoke bore and armature side face"
    annotation (Placement(transformation(
        origin={88,40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  FluxTubes.Shapes.Force.LeakageAroundPoles g_mLeakWork(
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
    "Electrical connector" annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n
    "Electrical connector" annotation (Placement(transformation(extent={{-90,-110},{-110,-90}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange
    "Flange of component" annotation (Placement(transformation(extent={
            {90,-10},{110,10}})));
equation
  x = flange.s;
  Psi_tot = coil1.Psi + coil2.Psi;
  L_statTot = coil1.L_stat + coil2.L_stat;
  connect(armature.flange_b, flange) annotation (Line(points={{84,0},{
          88,0},{92,0},{100,0}}, color={0,127,0}));
  connect(r_par1.n, c_par1.p)
    annotation (Line(points={{-64,-40},{-56,-40}}, color={0,0,255}));
  connect(r_par1.p, r_1.p)
    annotation (Line(points={{-84,-40},{-84,-20}}, color={0,0,255}));
  connect(c_par2.p, r_par2.n)
    annotation (Line(points={{20,-40},{12,-40}}, color={0,0,255}));
  connect(r_par2.p, r_2.p)
    annotation (Line(points={{-8,-40},{-8,-20}}, color={0,0,255}));
  connect(r_1.p, p) annotation (Line(points={{-84,-20},{-92,-20},{-92,100},{-100,100}},
                          color={0,0,255}));
  connect(g_mLeakWork.flange, g_mAirWork.flange) annotation (Line(
        points={{-20,74},{-6,74},{-6,40},{-20,40}}, color={0,127,0}));
  connect(g_mAirWork.flange, armature.flange_a) annotation (Line(points=
         {{-20,40},{-6,40},{-6,0},{64,0}}, color={0,127,0}));
  connect(n, c_par2.n) annotation (Line(points={{-100,-100},{40,-100},{40,-40}},
                 color={0,0,255}));
  connect(coil2.port_p, g_mFeArm.port_p)
    annotation (Line(points={{20,30},{20,30}}, color={255,127,0}));
  connect(G_mLeakRad.port_p, g_mFeArm.port_n) annotation (Line(points={{
          0,46},{0,46},{0,30}}, color={255,127,0}));
  connect(g_mAirWork.port_p, g_mFeArm.port_n)
    annotation (Line(points={{-10,30},{0,30}}, color={255,127,0}));
  connect(coil1.port_n, g_mAirWork.port_n)
    annotation (Line(points={{-36,30},{-30,30}}, color={255,127,0}));
  connect(g_mAirWork.port_n, g_mLeakWork.port_n)
    annotation (Line(points={{-30,30},{-30,64}}, color={255,127,0}));
  connect(g_mLeakWork.port_p, g_mAirWork.port_p)
    annotation (Line(points={{-10,64},{-10,30}}, color={255,127,0}));
  connect(coil1.port_p, g_mFePole.port_p)
    annotation (Line(points={{-56,30},{-58,30}}, color={255,127,0}));
  connect(g_mFePole.port_n, g_mFePoleBot.port_p)
    annotation (Line(points={{-78,30},{-78,46}}, color={255,127,0}));
  connect(g_mFePoleBot.port_n, g_mFeYokeSide1.port_p) annotation (Line(
        points={{-78,66},{-78,80},{-50,80}}, color={255,127,0}));
  connect(g_mFeYokeSide1.port_n, G_mLeakRad.port_n) annotation (Line(
        points={{-30,80},{0,80},{0,66}}, color={255,127,0}));
  connect(g_mFeYokeSide1.port_n, g_mFeYokeSide2.port_p)
    annotation (Line(points={{-30,80},{20,80}}, color={255,127,0}));
  connect(g_mFeYokeSide2.port_n, g_mFeYokeBot.port_n)
    annotation (Line(points={{40,80},{74,80}}, color={255,127,0}));
  connect(coil2.port_n, g_mLeak2.port_p)
    annotation (Line(points={{40,30},{46,30}}, color={255,127,0}));
  connect(g_mLeak2.port_p, g_mLeak1.port_p)
    annotation (Line(points={{46,30},{60,30}}, color={255,127,0}));
  connect(g_mLeak1.port_p, g_mAirPar.port_p)
    annotation (Line(points={{60,30},{74,30}}, color={255,127,0}));
  connect(g_mAirPar.port_p, g_mLeak3.port_p)
    annotation (Line(points={{74,30},{88,30}}, color={255,127,0}));
  connect(g_mLeak2.port_n, g_mLeak1.port_n)
    annotation (Line(points={{46,50},{60,50}}, color={255,127,0}));
  connect(g_mLeak1.port_n, g_mAirPar.port_n)
    annotation (Line(points={{60,50},{74,50}}, color={255,127,0}));
  connect(g_mAirPar.port_n, g_mLeak3.port_n)
    annotation (Line(points={{74,50},{88,50}}, color={255,127,0}));
  connect(g_mFeYokeBot.port_p, g_mAirPar.port_n)
    annotation (Line(points={{74,60},{74,50}}, color={255,127,0}));
  connect(coil2.p, r_2.n) annotation (Line(points={{20,10},{20,-20},{12,-20}},
                 color={0,0,255}));
  connect(coil2.n, c_par2.n)
    annotation (Line(points={{40,10},{40,-40}}, color={0,0,255}));
  connect(coil1.n, c_par1.n)
    annotation (Line(points={{-36,10},{-36,-40}}, color={0,0,255}));
  connect(coil1.n, r_2.p) annotation (Line(points={{-36,10},{-36,-20},{-8,-20}},
                    color={0,0,255}));
  connect(r_1.n, coil1.p) annotation (Line(points={{-64,-20},{-56,-20},{-56,10}},
                     color={0,0,255}));
  connect(ground.port, g_mLeak2.port_p) annotation (Line(
      points={{52,22},{52,30},{46,30}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(
      preserveAspectRatio=false,
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
      Line(points={{4,30},{4,32},{2,38},{-4,48},{-14,60},{-22,72},{-24,
            80},{-24,90}}, color={255,128,0}),
      Line(points={{22,30},{22,32},{20,38},{14,48},{4,60},{-4,72},{-6,
            80},{-6,90}}, color={255,128,0}),
      Line(points={{40,30},{40,32},{38,38},{32,48},{22,60},{14,72},{12,
            80},{12,90}}, color={255,128,0}),
      Text(
        extent={{150,150},{-150,110}},
        textColor={0,0,255},
        textString="%name")}), Documentation(info="<html>
<p>
Please have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.SimpleSolenoid\">SimpleSolenoid</a> for a general description of this actuator. Unlike in that simple magnetic network model, the coil is split into two lumped elements here. This enables for more realistic modelling of the radial leakage flux between armature and yoke (leakage permeance G_mLeakRad). Especially for large air gaps, the influence of this leakage flux on the actuator's inductance and its electromagnetic force is rather strong. Please have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.ComparisonQuasiStatic\">ComparisonQuasiStatic</a> for a comparison of both models with FEA-based results included as reference.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/SolenoidActuator/AdvancedSolenoidModel_fluxTubePartitioning.png\" alt=\"Assigned flux tubes and field plot of the solenoid actuator\">
</div>

<p>
The parasitic capacitances c_par1 and c_par2 across both partial coils assure that the voltages across these coils are well-defined during simulation.
</p>
</html>"));
end AdvancedSolenoid;
