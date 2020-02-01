within Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components;
model ConstantActuator
  "Simple behavioural actuator model for system simulation"

  parameter SI.ElectricalForceConstant k=3.88 "Converter constant";
  parameter SI.Resistance R=2.86 "Coil resistance";
  parameter SI.Inductance L=0.0051 "Coil inductance at mid-stroke";
  parameter SI.Mass m_a=0.012 "Armature mass"
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.TranslationalSpringConstant c=1e11
    "Spring stiffness between impact partners"
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.TranslationalDampingConstant d=400
    "Damping coefficient between impact partners"
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.Position x_min=-4e-3 "Minimum armature position"
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.Position x_max=4e-3 "Maximum armature position"
    annotation (Dialog(group="Armature and stopper"));

  SI.Position x(start=x_min, stateSelect=StateSelect.prefer)
    "Armature position, alias for flange position";

  Modelica.Electrical.Analog.Basic.Resistor r(final R=R)
    "Coil resistance" annotation (Placement(transformation(extent={{-90,
            50},{-70,70}})));
  FluxTubes.Examples.Utilities.TranslatoryArmatureAndStopper armature(
    final m=m_a,
    final x_max=x_max,
    final x_min=x_min,
    final L=0,
    final c=c,
    final d=d,
    n=2) "Armature inertia with stoppers at end of stroke range"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Modelica.Electrical.Analog.Basic.Inductor l(final L=L)
    "Coil inductance" annotation (Placement(transformation(extent={{-60,
            50},{-40,70}})));
  Modelica.Electrical.Analog.Basic.TranslationalEMF
    electroTranslationalConverter(final k=k) annotation (Placement(
        transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p
    "Electrical connector" annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n
    "Electrical connector" annotation (Placement(transformation(extent={{-90,-110},{-110,-90}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange
    "Flange of component" annotation (Placement(transformation(extent={
            {90,-10},{110,10}})));
equation
  flange.s = x;

  connect(r.p, p)
    annotation (Line(points={{-90,60},{-100,60},{-100,100}},
                                                  color={0,0,255}));
  connect(l.p, r.n)
    annotation (Line(points={{-60,60},{-70,60}}, color={0,0,255}));
  connect(armature.flange_b, flange) annotation (Line(points={{80,0},{
          85,0},{90,0},{100,0}}, color={0,127,0}));
  connect(l.n, electroTranslationalConverter.p) annotation (Line(points=
         {{-40,60},{-30,60},{-30,10}}, color={0,0,255}));
  connect(n, electroTranslationalConverter.n) annotation (Line(points={{-100,-100},{-30,-100},{-30,-10}},
                                           color={0,0,255}));
  connect(electroTranslationalConverter.flange, armature.flange_a)
    annotation (Line(points={{-20,0},{0,0},{20,0},{60,0}}, color={0,127,
          0}));
  connect(p, p) annotation (Line(points={{-100,100},{-100,100}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={
            {-100,-100},{100,100}}), graphics={Rectangle(
                  extent={{-80,100},{80,-100}},
                  lineColor={255,128,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-70,80},{72,-80}},
                  textColor={255,128,0},
                  textString="c"),Line(points={{-90,100},{-80,100}},
          color={0,0,255}),Line(points={{-90,-100},{-80,-100}},
                                                              color={0,0,255}),
          Line(points={{80,0},{90,0}}, color={0,127,0}),Text(
                  extent={{150,150},{-150,110}},
                  textColor={0,0,255},
                  textString="%name")}), Documentation(info="<html>
<p>
Similar to rotational DC-Motors, the electro-mechanical energy conversion of translatory electrodynamic actuators and generators of moving coil and moving magnet type can be described with the following two converter equations:
</p>

<blockquote><pre>
  F = c * i
V_i = c * v
</pre></blockquote>

<p>
with electrodynamic or <em>Lorentz</em> force F, converter constant c, current i, induced back-emf V_i and armature velocity v. The model is very similar to the well-known behavioural model of a rotational single-phase DC-Machine, except that it is for translatory motion. For a moving coil actuator with a coil inside an air gap with flux density B and a total wire length l inside the magnetic field, the converter constant becomes
</p>

<blockquote><pre>
c = B * l.
</pre></blockquote>

<p>
The converter constant c as well as coil resistance R and inductance L are assumed to be known, e.g., from measurements or catalogue data. Hence this model is well-suited for system simulation together with neighbouring subsystems, but not for actuator design, where the motor constant is to be found on base of the magnetic circuit's geometry, material properties and winding data. See <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a> for a more accurate model of this actuator that is based on a magnetic network. Due to identical connectors, both models can be used in system simulation, e.g. to simulate a stroke as demonstrated in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.ArmatureStroke\">ArmatureStroke</a>.
</p>
</html>"));
end ConstantActuator;
