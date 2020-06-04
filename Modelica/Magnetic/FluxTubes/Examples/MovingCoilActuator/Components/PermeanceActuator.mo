within Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components;
model PermeanceActuator
  "Detailed actuator model for rough magnetic design of actuator and system simulation"

  parameter Real N=140 "Number of turns" annotation (Dialog(group=
          "Parameters", groupImage=
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/MovingCoilActuator/MovingCoilActuator_dimensions.png"));
  parameter SI.Resistance R=2.86 "Coil resistance";

  parameter SI.Radius r_core=12.5e-3
    "Radius of ferromagnetic stator core";

  parameter SI.Length l_PM=3.5e-3
    "Radial thickness of permanent magnet ring";
  parameter SI.Length t=0.02
    "Axial length of permanent magnet ring and air gap respectively";

  parameter SI.Length l_air=3e-3
    "Total radial length of armature air gap";

  parameter SI.Length l_FeOut=4e-3
    "Radial thickness of outer back iron (for estimation of leakage permeance)";

  parameter FluxTubes.Material.HardMagnetic.BaseData material=
      Material.HardMagnetic.BaseData()
    "Ferromagnetic material characteristics"
    annotation (choicesAllMatching=true, Dialog(group="Material"));

  parameter SI.Mass m_a=0.012 "Mass of armature"
    annotation (Dialog(group="Armature and stopper"));

  parameter SI.TranslationalSpringConstant c=1e11
    "Spring stiffness between impact partners"
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.TranslationalDampingConstant d=400
    "Damping coefficient between impact partners"
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.Position x_min=-4e-3
    "Position of stopper at minimum armature position"
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.Position x_max=4e-3
    "Position of stopper at maximum armature position"
    annotation (Dialog(group="Armature and stopper"));

  SI.Position x(start=x_min, stateSelect=StateSelect.prefer)
    "Armature position, alias for flange position";

  SI.Inductance L "Coil inductance";

  FluxTubes.Sources.ConstantMagneticPotentialDifference mmf_PM(final V_m=
       material.H_cB*l_PM) "Permanent magnet's magnetomotive force"
    annotation (Placement(transformation(
        origin={10,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  FluxTubes.Examples.Utilities.TranslatoryArmatureAndStopper armature(
    final L=0,
    final m=m_a,
    final c=c,
    final d=d,
    n=2,
    final x_max=x_max,
    final x_min=x_min)
    "Inertia of moving coil + coil carrier; stoppers at end of stroke range"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Electrical.Analog.Basic.Resistor r(final R=R) annotation (
      Placement(transformation(
        origin={-80,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  Basic.Ground ground annotation (Placement(transformation(extent={{30,
            -38},{50,-18}})));
  FluxTubes.Basic.ElectroMagneticConverter coil(final N=N) annotation (
      Placement(transformation(
        origin={0,-20},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  FluxTubes.Shapes.Force.HollowCylinderRadialFlux g_ma(
    final dlBydx=1,
    final l=t/2 + x,
    final r_i=r_core,
    final r_o=r_core + l_air + l_PM,
    final mu_r=1.05,
    final useSupport=false) annotation (Placement(transformation(
        origin={-20,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  FluxTubes.Shapes.Force.HollowCylinderRadialFlux g_mb(
    final r_i=r_core,
    final r_o=r_core + l_air + l_PM,
    final dlBydx=-1,
    final l=t/2 - x,
    final mu_r=1.05,
    final useSupport=false) annotation (Placement(transformation(
        origin={30,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  FluxTubes.Shapes.Leakage.CoaxCylindersEndFaces g_mLeak1(
    final r_1=r_core + l_air + l_PM,
    final r_2=r_core + l_air + l_PM + l_FeOut,
    final r_0=r_core)
    "Leakage between coaxial end planes of ferromagnetic stator core and outer back iron"
    annotation (Placement(transformation(
        origin={-60,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  FluxTubes.Shapes.Leakage.HalfCylinder g_mLeak2(final l=2*pi*(r_core +
        (l_air + l_PM)/2))
    "Leakage between edges of ferromagnetic stator core and outer back iron"
    annotation (Placement(transformation(
        origin={-40,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  Modelica.Electrical.Analog.Interfaces.PositivePin p
    "Electrical connector" annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n
    "Electrical connector" annotation (Placement(transformation(extent={{-90,-110},{-110,-90}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange
    "Flange of component" annotation (Placement(transformation(extent={
            {90,-10},{110,10}})));
equation
  x = flange.s;
  L = coil.N^2*(g_ma.G_m + g_mLeak1.G_m + g_mLeak2.G_m);

  connect(armature.flange_b, flange) annotation (Line(
      points={{80,0},{100,0}}, color={0,127,0}));
  connect(r.p, p) annotation (Line(points={{-80,40},{-80,100},{-100,100}},
                                                                         color={0,0,255}));
  connect(armature.flange_a, g_mb.flange)
    annotation (Line(points={{60,0},{40,0}}, color={0,127,0}));
  connect(g_mb.flange, g_ma.flange) annotation (Line(points={{40,0},{40,
          40},{-10,40},{-10,0}}, color={0,127,0}));
  connect(g_mLeak1.port_n, g_ma.port_n) annotation (Line(points={{-60,0},
          {-60,-10},{-20,-10}}, color={255,127,0}));
  connect(g_mLeak2.port_n, g_ma.port_n) annotation (Line(points={{-40,0},
          {-40,-10},{-20,-10}}, color={255,127,0}));
  connect(g_ma.port_n, coil.port_p) annotation (Line(points={{-20,-10},{-18,-10},{-18,-12},{-14,-12},{-14,-10},{-10,-10}},
                                                             color={255,
          127,0}));
  connect(coil.port_n, g_mb.port_n)
    annotation (Line(points={{10,-10},{30,-10}},color={255,127,0}));
  connect(g_mb.port_n, mmf_PM.port_p) annotation (Line(points={{30,-10},
          {50,-10},{50,30},{10,30}}, color={255,127,0}));
  connect(mmf_PM.port_p, g_mLeak2.port_p) annotation (Line(points={{10,
          30},{-40,30},{-40,20}}, color={255,127,0}));
  connect(mmf_PM.port_p, g_mLeak1.port_p) annotation (Line(points={{10,
          30},{-60,30},{-60,20}}, color={255,127,0}));
  connect(g_ma.port_p, mmf_PM.port_n)
    annotation (Line(points={{-20,10},{10,10}}, color={255,127,0}));
  connect(mmf_PM.port_n, g_mb.port_p)
    annotation (Line(points={{10,10},{30,10}}, color={255,127,0}));
  connect(r.n, coil.p) annotation (Line(points={{-80,20},{-80,-30},{-10,-30}},
                 color={0,0,255}));
  connect(coil.n, n) annotation (Line(points={{10,-30},{10,-100},{-100,-100}},
                                                                           color={0,0,255}));
  connect(ground.port, g_mb.port_n) annotation (Line(
      points={{40,-18},{40,-10},{30,-10}}, color={255,127,0}));
  annotation (Documentation(info="<html>
<p>
In the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a> model the force F is strictly proportional to the current i as indicated by the converter constant c. However, there is an additional non-linear force component in such an actuator that is due to the dependency of the coil inductance L on the armature position x. The inductance increases as the armature moves into the stator. The total force is
</p>

<blockquote><pre>
    1  2 dL
F = - i  --  + c i
    2    dx
</pre></blockquote>

<p>
Both force components are properly considered with a simple permeance model as shown in the figures below. Figure (a) illustrates the dimensions of the axis-symmetric moving coil actuator that are needed in the permeance model. Figure (b) shows partitioning into flux tubes and the permanent magnetic field without current. G_ma and G_mb both are the permeances resulting from a series connection of the permanent magnet and air gap sections. The field plot of the coil-imposed mmf is shown in figure (c) without the permanent magnetic mmf (H_cB=0). The placement of the magnetic network components in figure (d) retains the geometric structure of the actuator. In figure (e), the permeance model is restructured and thus simplified.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/MovingCoilActuator/MovingCoilActuator_PermeanceModel.png\" alt=\"Structure, assigned flux tubes and field plots of the moving coil actuator\">
</div>
</html>"),
   Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
                  extent={{-90,100},{90,-100}},
                  lineColor={255,128,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{-90,100},{-50,-100}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={255,128,0},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{90,80},{-90,100}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={255,128,0},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{90,-80},{-90,-100}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={255,128,0},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{70,34},{-90,-34}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={255,128,0},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{90,52},{-16,64}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={255,213,170},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{90,-64},{-12,-52}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={255,213,170},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{150,150},{-150,110}},
                  textColor={0,0,255},
                  textString="%name")}));
end PermeanceActuator;
