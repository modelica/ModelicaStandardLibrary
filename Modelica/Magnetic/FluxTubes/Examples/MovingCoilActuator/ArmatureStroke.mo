within Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator;
model ArmatureStroke
  "Armature stroke of both moving coil actuator models after a voltage step at time t=0"

  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Basic.Ground pmGround annotation (Placement(
        transformation(extent={{-80,-70},{-60,-50}})));
  Modelica.Electrical.Analog.Sources.StepVoltage pmSource(startTime=0, V=
        pmActuator.R*1.5) "Steady state current 1.5A" annotation (
      Placement(transformation(
        origin={-70,-30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator pmActuator(
    material=Material.HardMagnetic.PlasticNdFeB(),
    x(start=pmActuator.x_min, fixed=true),
    armature(v(fixed=true)),
    coil(i(fixed=true)))
    "Moving coil actuator described with permeance model" annotation (
      Placement(transformation(extent={{-40,-40},{-20,-20}})));

  Modelica.Mechanics.Translational.Components.Mass pmLoad(m=0.05)
    "Load to be moved in addition to the armature mass" annotation (
      Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Electrical.Analog.Basic.Ground cGround annotation (Placement(
        transformation(extent={{-80,0},{-60,20}})));
  Modelica.Electrical.Analog.Sources.StepVoltage cSource(startTime=0, V=
        cActuator.R*1.5) "Steady state current 1.5A" annotation (
      Placement(transformation(
        origin={-70,40},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator cActuator(
    x(start=cActuator.x_min, fixed=true),
    armature(v(fixed=true)),
    l(i(start=0, fixed=true)))
    "Moving coil actuator described with converter constant" annotation (
      Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Mechanics.Translational.Components.Mass cLoad(m=0.05)
    "Load to be moved in addition to the armature mass" annotation (
      Placement(transformation(extent={{0,30},{20,50}})));
equation
  connect(pmLoad.flange_a, pmActuator.flange)
    annotation (Line(points={{0,-30},{-20,-30}}, color={0,127,0}));
  connect(cGround.p, cSource.n)
    annotation (Line(points={{-70,20},{-70,30}}, color={0,0,255}));
  connect(cLoad.flange_a, cActuator.flange)
    annotation (Line(points={{0,40},{-20,40}}, color={0,127,0}));
  connect(cSource.p, cActuator.p) annotation (Line(points={{-70,50},{-56,50},{-56,50},{-40,50}},
                                  color={0,0,255}));
  connect(cSource.n, cActuator.n) annotation (Line(points={{-70,30},{-56,30},{-56,30},{-40,30}},
                                  color={0,0,255}));
  connect(pmSource.n, pmGround.p)
    annotation (Line(points={{-70,-40},{-70,-50}}, color={0,0,255}));
  connect(pmSource.n, pmActuator.n) annotation (Line(points={{-70,-40},{-54,-40},{-54,-40},{-40,-40}},
                                     color={0,0,255}));
  connect(pmSource.p, pmActuator.p) annotation (Line(points={{-70,-20},{-55,-20},{-55,-20},{-40,-20}},
                                     color={0,0,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Text(
                extent={{-98,98},{48,86}},
                textColor={0,0,255},
                textString=
            "Comparison of a pull-in stroke of both converter models"),
          Text( extent={{-98,90},{-30,80}},
                textColor={0,0,255},
                textString="after a voltage step at t=0")}),
    experiment(StopTime=0.05, Tolerance=1e-007),
    Documentation(info="<html>
<p>
Have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a> and at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a>
for an explanation of both actuator models.</p>

<p>
A voltage step at time t=0 is applied to both actuator models. In each model, the armature and an attached load mass perform a stroke between the two stoppers included in cActuator.armature and pmActuator.armature respectively. <strong>Simulate for 0.05 s</strong> and plot vs. time (same physical quantities together in a common diagram for comparison):
</p>
<blockquote><pre>
cActuator.p.i                     // input current to converter constant model
pmActuator.p.i                    // input current to permeance model
cActuator.armature.flange_a.f     // actuator force of converter constant model
pmActuator.armature.flange_a.f    // actuator force of permeance model
cActuator.x                       // armature position of converter constant model
pmActuator.x                      // armature position of permeance model
cActuator.L                       // inductance of converter constant model
pmActuator.L                      // inductance of permeance model
</pre></blockquote>
<p>
The initial current rise in both actuator models is due to the inductance of the actuator coil. After acceleration of the armature and the load, the current decreases due to the motion-induced back-emf. Bouncing occurs when the armatures of both models arrive at the stopper at maximum armature position. The bouncing is rather intense due to the absence of any kind of external friction in this simple example (apart from the nonlinear damping in the stopper elements). After decay of the bouncing, both actuators operate under conditions valid for a blocked armature.
</p>
<p>
Whereas the steady state current is the same in both models, the steady state actuator force is not due to the neglect of the non-linear force component in the converter constant model. Differences in the current rise of both models are due to the neglect of the coil inductance variation in the converter constant model.
</p>
</html>"));
end ArmatureStroke;
