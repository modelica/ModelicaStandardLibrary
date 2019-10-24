within Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator;
model ForceCurrentBehaviour
  "Comparison of the force-current characteristics of both converter models with armature blocked at mid-position"

  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Basic.Ground pmGround annotation (Placement(
        transformation(extent={{-70,-100},{-50,-80}})));
  FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator pmActuator(x(start=0),
      material=Material.HardMagnetic.PlasticNdFeB())
    "Moving coil actuator described with permeance model" annotation (
      Placement(transformation(extent={{-20,-70},{0,-50}})));
  Modelica.Mechanics.Translational.Components.Fixed pmFixedPos(s0=0)
    "Fixed armature position" annotation (Placement(transformation(extent=
           {{10,-70},{30,-50}})));
  Modelica.Electrical.Analog.Sources.RampCurrent pmRampCurrent(
    I=-6,
    duration=6,
    offset=3) "Ideal current source" annotation (Placement(
        transformation(
        origin={-60,-60},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground cGround annotation (Placement(
        transformation(extent={{-70,-20},{-50,0}})));
  Modelica.Mechanics.Translational.Components.Fixed cFixedPos(s0=0)
    "Fixed armature position" annotation (Placement(transformation(extent=
           {{10,10},{30,30}})));
  Modelica.Electrical.Analog.Sources.RampCurrent cRampCurrent(
    I=-6,
    duration=6,
    offset=3) "Ideal current source" annotation (Placement(
        transformation(
        origin={-60,20},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator cActuator
    "Moving coil actuator described with converter constant" annotation (
      Placement(transformation(extent={{-20,10},{0,30}})));
  Modelica.Blocks.Tables.CombiTable1Ds comparisonWithFEA(table=[-3, -9.65653;
        -2.5, -8.28587; -2, -6.82002; -1.5, -5.25898; -1, -3.60274; -0.5,
        -1.85131; 0, -0.00468; 0.5, 1.93714; 1, 3.97415; 1.5, 6.10636; 2,
        8.33376; 2.5, 10.65636; 3, 13.07415])
    "Column 1: current, col. 2: force; mu_rFe=const.=1000 in FEA model"
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor iSensor
    "Input value for look-up table with FEA results" annotation (
      Placement(transformation(extent={{-50,40},{-30,20}})));
equation
  connect(pmFixedPos.flange, pmActuator.flange)
    annotation (Line(points={{20,-60},{0,-60}}, color={0,127,0}));
  connect(pmRampCurrent.p, pmActuator.p) annotation (Line(points={{-60,-50},{-30,-50},{-30,-50},{-20,-50}},
                                          color={0,0,255}));
  connect(pmActuator.n, pmRampCurrent.n) annotation (Line(points={{-20,-70},{-30,-70},{-30,-70},{-60,-70}},
                                          color={0,0,255}));
  connect(pmGround.p, pmRampCurrent.n)
    annotation (Line(points={{-60,-80},{-60,-70}}, color={0,0,255}));
  connect(cGround.p, cRampCurrent.n)
    annotation (Line(points={{-60,0},{-60,10}}, color={0,0,255}));
  connect(cActuator.flange, cFixedPos.flange)
    annotation (Line(points={{0,20},{20,20}}, color={0,127,0}));
  connect(cRampCurrent.n, cActuator.n) annotation (Line(points={{-60,10},{-30,10},{-30,10},{-20,10}},
                                       color={0,0,255}));
  connect(cRampCurrent.p, iSensor.p)
    annotation (Line(points={{-60,30},{-50,30}}, color={0,0,255}));
  connect(cActuator.p, iSensor.n) annotation (Line(points={{-20,30},{-30,30},{-30,30}},
                         color={0,0,255}));
  connect(iSensor.i, comparisonWithFEA.u) annotation (Line(points={{-40,41},{-40,50},{38,50}},
                                 color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Text(
                extent={{-98,96},{100,86}},
                textColor={0,0,255},
                textString=
            "Comparison of the force-current characteristics of both converter models"),
          Text( extent={{-98,88},{2,78}},
                textColor={0,0,255},
                textString="with armature blocked at mid-position")}),
    experiment(StopTime=6, Tolerance=1e-007),
    Documentation(info="<html>
<p>
Have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a> and at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a> for an explanation of both converter models.<br>
</p>
<p>
Simulation of the force-current characteristics of both converter models with the armature blocked at mid-position x=0 reveals the difference between the two models. In the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a>, force is proportional to current. In the simple <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a> there is an additional non-linear force component that is due to the dependency of the inductance on the armature position. Comparison with FEA results validates the higher accuracy of the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a>. In the FEA model, the relative permeability of the stator iron was set to mu_rFe=const.=1000 in order to avoid additional non-linear force components due to saturation. <strong>Simulate for 6 s</strong> and <strong>plot vs. current (e.g., iSensor.i)</strong></p>
<blockquote><pre>
pmFixedPos.flange_b.f       // force of permeance model
cFixedPos.flange_b.f        // force of converter constant model
comparisonWithFEA.y[1]      // force of FEA model for comparison
</pre></blockquote>
</html>"));
end ForceCurrentBehaviour;
