within Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator;
model ComparisonQuasiStatic
  "Slow forced armature motion of both solenoid models so that electromagnetic field and current are quasi-static"

  extends Modelica.Icons.Example;

  parameter SI.Voltage v_step=12 "Applied voltage";

  Modelica.Blocks.Sources.Ramp x_set(
    duration=10,
    height=-(advancedSolenoid.x_max - advancedSolenoid.x_min),
    offset=advancedSolenoid.x_max)
    "Prescribed armature position, slow enforced motion from x_max to x_min"
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Electrical.Analog.Basic.Ground advancedGround annotation (
      Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Electrical.Analog.Sources.StepVoltage advancedSource(V=v_step)
    annotation (Placement(transformation(
        origin={-70,50},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  FluxTubes.Examples.SolenoidActuator.Components.AdvancedSolenoid advancedSolenoid
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Mechanics.Translational.Sources.Position advancedFeed_x(f_crit=
       1000, exact=false)
                         annotation (Placement(transformation(
        origin={0,50},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.Analog.Basic.Ground simpleGround annotation (
      Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Modelica.Electrical.Analog.Sources.StepVoltage simpleSource(V=v_step)
    annotation (Placement(transformation(
        origin={-70,-50},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  FluxTubes.Examples.SolenoidActuator.Components.SimpleSolenoid simpleSolenoid
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Mechanics.Translational.Sources.Position simpleFeed_x(f_crit=
        1000, exact=false) annotation (Placement(transformation(
        origin={0,-50},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Blocks.Tables.CombiTable1Ds comparisonWithFEA(table=[0.00025,
        -85.8619, 0.00014821, 0.11954; 0.0005, -59.9662, 0.00013931,
        0.11004; 0.00075, -41.0806, 0.0001277, 0.098942; 0.001, -28.88,
        0.00011587, 0.088425; 0.00125, -21.4113, 0.00010643, 0.08015;
        0.0015, -16.8003, 9.9406e-005, 0.073992; 0.00175, -13.6942,
        9.3416e-005, 0.068792; 0.002, -11.1188, 8.8564e-005, 0.064492;
        0.00225, -9.6603, 8.4505e-005, 0.060917; 0.0025, -8.4835,
        8.1215e-005, 0.058017; 0.00275, -7.4658, 7.7881e-005, 0.055125;
        0.003, -6.5591, 7.5197e-005, 0.052733; 0.00325, -5.9706,
        7.2447e-005, 0.05035; 0.0035, -5.5013, 7.0342e-005, 0.048525;
        0.00375, -5.0469, 6.8527e-005, 0.046867; 0.004, -4.6573,
        6.6526e-005, 0.045158; 0.00425, -4.2977, 6.4425e-005, 0.043442;
        0.0045, -4.0912, 6.2747e-005, 0.04205; 0.00475, -3.7456,
        6.1231e-005, 0.040733; 0.005, -3.5869, 5.9691e-005, 0.039467])
    "Valid for u_source=12V only; column 1: position, col.2: force, col.3: armature flux, col.4: inductance"
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
equation
  connect(advancedGround.p, advancedSource.n)
    annotation (Line(points={{-70,30},{-70,40}}, color={0,0,255}));
  connect(x_set.y, advancedFeed_x.s_ref) annotation (Line(points={{59,0},
          {20,0},{20,50},{12,50}}, color={0,0,127}));
  connect(simpleSolenoid.p, simpleSource.p) annotation (Line(points={{-40,-40},{-50,-40},{-50,-40},{-70,-40}},
                                               color={0,0,255}));
  connect(simpleSolenoid.n, simpleSource.n) annotation (Line(points={{-40,-60},{-50,-60},{-50,-60},{-70,-60}},
                                               color={0,0,255}));
  connect(simpleSolenoid.flange, simpleFeed_x.flange)
    annotation (Line(points={{-20,-50},{-10,-50}}, color={0,127,0}));
  connect(advancedSolenoid.n, advancedSource.n) annotation (Line(points={{-40,40},{-50,40},{-50,40},{-70,40}},
                                                color={0,0,255}));
  connect(simpleFeed_x.s_ref, x_set.y) annotation (Line(points={{12,-50},
          {20,-50},{20,0},{59,0}}, color={0,0,127}));
  connect(x_set.y, comparisonWithFEA.u) annotation (Line(points={{59,0},{50,0},{50,50},{58,50}},
                                  color={0,0,127}));
  connect(advancedFeed_x.flange, advancedSolenoid.flange)
    annotation (Line(points={{-10,50},{-20,50}}, color={0,127,0}));
  connect(advancedSource.p, advancedSolenoid.p) annotation (Line(points={{-70,60},{-50,60},{-50,60},{-40,60}},
                                                color={0,0,255}));
  connect(simpleGround.p, simpleSource.n)
    annotation (Line(points={{-70,-70},{-70,-60}}, color={0,0,255}));
  annotation (experiment(StopTime=10, Tolerance=1e-007), Documentation(
        info="<html>
<p>
Have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator\">SolenoidActuator</a> for general comments and at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.SimpleSolenoid\">SimpleSolenoid</a> and <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.AdvancedSolenoid\">AdvancedSolenoid</a> for a detailed description of both magnetic network models.
</p>

<p>
Similar to static force-stroke measurements on real actuators, the armatures of both actuator models are forced to move slowly here. Hence, the dynamics of the electrical subsystems due to coil inductance and armature motion can be neglected and the static force-stroke characteristics are obtained. To illustrate the accuracy to be expected from the lumped magnetic network models, results obtained with stationary FEA are included as reference (position-dependent force, armature flux and actuator inductance). Note that these reference values are valid for the default supply voltage v_step=12V DC only!
</p>

<p>
Set the <strong>tolerance</strong> to <strong>1e-7</strong> and <strong>simulate for 10 s</strong>. Plot in one common window the electromagnetic force of the two magnetic network models and the FEA reference <strong>vs. armature position x_set.y</strong>:
</p>

<blockquote><pre>
simpleSolenoid.armature.flange_a.f     // electromagnetic force of simple magnetic network model
advancedSolenoid.armature.flange_a.f   // electromagnetic force of advanced magnetic network model
comparisonWithFEA.y[1]                 // electromagnetic force obtained with FEA as reference
</pre></blockquote>

<p>
Electromagnetic or reluctance forces always act towards a decrease of air gap lengths. With the defined armature position coordinate x, the forces of the models are negative.
</p>

<p>
The magnetic flux through the armature and the actuator's static inductance both illustrate the differences between the two magnetic network models. Similar to the forces, compare these quantities in one common plot window for each variable (plot vs. armature position x_set.y):
</p>

<blockquote><pre>
simpleSolenoid.g_mFeArm.Phi            // magnetic flux through armature of simple magnetic network model
advancedSolenoid.g_mFeArm.Phi          // magnetic flux through armature of advanced magnetic network model
comparisonWithFEA.y[2]                 // magnetic flux obtained with FEA as reference

simpleSolenoid.coil.L_stat             // static inductance of simple magnetic network model
advancedSolenoid.L_statTot             // series connection of both partial coils of advanced network model
comparisonWithFEA.y[3]                 // static inductance obtained with FEA as reference
</pre></blockquote>

<p>
As mentioned in the description of both magnetic network models, one can tell the higher armature flux and inductance of the advanced solenoid model at large air gaps compared to that of the simple model. The effect of this difference on dynamic model behaviour can be analysed in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.ComparisonPullInStroke\">ComparisonPullInStroke</a>.
</p>
</html>"));
end ComparisonQuasiStatic;
