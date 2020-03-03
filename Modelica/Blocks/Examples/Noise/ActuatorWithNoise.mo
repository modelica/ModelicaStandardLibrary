within Modelica.Blocks.Examples.Noise;
model ActuatorWithNoise
  "Demonstrates how to model measurement noise in an actuator"
extends Modelica.Icons.Example;
  Utilities.Parts.MotorWithCurrentControl motor
    annotation (Placement(transformation(extent={{-86,-10},{-66,10}})));
  Utilities.Parts.Controller controller
    annotation (Placement(transformation(extent={{-60,40},{-80,60}})));
  Modelica.Blocks.Sources.Step speed(startTime=0.5, height=50)
    annotation (Placement(transformation(extent={{20,40},{0,60}})));
  Modelica.Mechanics.Rotational.Components.Gearbox gearbox(
    lossTable=[0,0.85,0.8,0.1,0.1],
    c=1e6,
    d=1e4,
    ratio=10,
    w_rel(fixed=true),
    b=0.0017453292519943,
    phi_rel(fixed=true))
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Mechanics.Translational.Components.IdealGearR2T idealGearR2T(ratio=
        300) annotation (Placement(transformation(extent={{-32,-10},{-12,10}})));
  Modelica.Mechanics.Translational.Components.Mass mass(m=100)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Modelica.Mechanics.Translational.Sources.ConstantForce constantForce(
      f_constant=10000) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        origin={86,0})));
  Modelica.Blocks.Nonlinear.SlewRateLimiter slewRateLimiter(Rising=50)
    annotation (Placement(transformation(extent={{-20,40},{-40,60}})));
  Modelica.Mechanics.Translational.Components.Mass rodMass(m=3)
    annotation (Placement(transformation(extent={{-4,-10},{16,10}})));
  Modelica.Mechanics.Translational.Components.SpringDamper elastoGap(c=1e8, d=
        1e5,
    v_rel(fixed=true),
    s_rel(fixed=true))
             annotation (Placement(transformation(extent={{22,-10},{42,10}})));
  inner .Modelica.Blocks.Noise.GlobalSeed globalSeed(enableNoise=true) annotation (Placement(transformation(extent={{60,60},{80,80}})));
equation
  connect(controller.y1, motor.iq_rms1) annotation (Line(
      points={{-81,50},{-94,50},{-94,6},{-88,6}}, color={0,0,127}));
  connect(motor.phi, controller.positionMeasured) annotation (Line(
      points={{-71,8},{-66,8},{-66,20},{-50,20},{-50,44},{-58,44}}, color={0,0,127}));
  connect(motor.flange, gearbox.flange_a) annotation (Line(
      points={{-66,0},{-60,0}}));
  connect(gearbox.flange_b, idealGearR2T.flangeR) annotation (Line(
      points={{-40,0},{-32,0}}));
  connect(constantForce.flange, mass.flange_b) annotation (Line(
      points={{76,0},{70,0}}, color={0,127,0}));
  connect(speed.y, slewRateLimiter.u) annotation (Line(
      points={{-1,50},{-18,50}}, color={0,0,127}));
  connect(slewRateLimiter.y, controller.positionReference) annotation (Line(
      points={{-41,50},{-50,50},{-50,56},{-58,56}}, color={0,0,127}));
  connect(rodMass.flange_a, idealGearR2T.flangeT) annotation (Line(
      points={{-4,0},{-12,0}}, color={0,127,0}));
  connect(rodMass.flange_b, elastoGap.flange_a) annotation (Line(
      points={{16,0},{22,0}}, color={0,127,0}));
  connect(elastoGap.flange_b, mass.flange_a) annotation (Line(
      points={{42,0},{50,0}}, color={0,127,0}));
  annotation (
    experiment(StopTime=8, Interval = 0.01, Tolerance=1e-005),
    Documentation(info="<html>
<p>
This example models an actuator with a noisy sensor (which is in the motor component):
</p>

<blockquote>
<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/NoiseExamples/ActuatorNoiseDiagram.png\"/>
</p></blockquote>

<p>
The drive train consists of a synchronous motor with a current controller (= motor) and a gear box.
The gearbox drives a rod through a linear translation model. Softly attached to the rod is
another mass representing the actual actuator (= mass). The actuator is loaded with a constant force.
</p>

<p>
The whole drive is steered by a rate limited speed step command through a controller model.
In the motor the shaft angle is measured and this measurement signal is modelled by adding
additive noise to the motor angle.
</p>

<p>
In the following figure, the position of the actuator and the motor output torque are
shown with and without noise. The noise is not very strong, such that it has no visible effect
on the position of the actuator. The effect of the noise can be seen in the motor torque.
</p>

<blockquote><p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/NoiseExamples/ActuatorNoise.png\"/>
</p></blockquote>

<p>
Note, the noise in all components can be easily switched off by setting parameter
enableNoise = false in the globalSeed component.
</p>
</html>", revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Blocks/Noise/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
end ActuatorWithNoise;
