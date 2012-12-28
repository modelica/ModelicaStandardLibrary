within ModelicaTest.Fluid.TestCriticalCases;
model IdealMixing1 "Test properties of ideal mixing"
  extends Modelica.Icons.Example;
  // package Medium =  Modelica.Fluid.Media.Water.ConstantPropertyLiquidWater;
  // Modelica.Media.IdealGases.MixtureGases.FlueGasSixComponents,package Medium = Modelica.Media.Air.DryAirNasa;
  package Medium =
      Modelica.Media.IdealGases.MixtureGases.FlueGasSixComponents;

  Modelica.Fluid.Pipes.StaticPipe pipeFriction1(
    length=1,
    diameter=0.2,
    redeclare package Medium = Medium,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow (from_dp=
            false))                    annotation (Placement(transformation(
          extent={{-32,-40},{-12,-20}}, rotation=0)));
  Modelica.Fluid.Pipes.StaticPipe pipeFriction2(
    length=1,
    diameter=0.2,
    redeclare package Medium = Medium,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow (from_dp=
            false))                    annotation (Placement(transformation(
          extent={{12,-40},{32,-20}}, rotation=0)));
  Modelica.Fluid.Pipes.StaticPipe pipeFriction3(
    length=1,
    diameter=0.2,
    redeclare package Medium = Medium,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow (from_dp=
            false))
    annotation (Placement(transformation(
        origin={0,0},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Fluid.Sources.Boundary_pT boundary1(nPorts=1,
    use_p_in=true,
    use_T_in=true,
    redeclare package Medium = Medium) annotation (Placement(transformation(
          extent={{-68,-40},{-48,-20}}, rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT boundary2(nPorts=1,
    use_p_in=false,
    use_T_in=false,
    p=101000,
    T=320,
    redeclare package Medium = Medium) annotation (Placement(transformation(
          extent={{66,-40},{46,-20}}, rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT boundary3(nPorts=1,
    use_p_in=true,
    use_T_in=false,
    T=340,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(
        origin={0,30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Blocks.Sources.Sine sine1(
    amplitude=0.05e5,
    freqHz=2,
    offset=1e5,
    phase=0.013962634015955) annotation (Placement(transformation(extent={{
            -100,-20},{-80,0}}, rotation=0)));
  Modelica.Blocks.Sources.Sine sine2(
    amplitude=10,
    freqHz=1,
    phase=0.0017453292519943,
    offset=300) annotation (Placement(transformation(extent={{-100,-58},{-80,
            -38}}, rotation=0)));
  Modelica.Blocks.Sources.Sine sine3(
    amplitude=0.05e5,
    freqHz=2,
    offset=1e5) annotation (Placement(transformation(
        origin={0,70},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  inner Modelica.Fluid.System system
                        annotation (Placement(transformation(extent={{-88,60},
            {-68,80}}, rotation=0)));
 Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,-60},{10,-80}},
          rotation=0)));
equation
  connect(pipeFriction1.port_b, pipeFriction2.port_a) annotation (Line(
      points={{-12,-30},{12,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipeFriction3.port_a, pipeFriction1.port_b) annotation (Line(
      points={{-1.12703e-16,-10},{0,-10},{0,-30},{-12,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary1.ports[1], pipeFriction1.port_a)
                                                annotation (Line(
      points={{-48,-30},{-32,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary2.ports[1], pipeFriction2.port_b)
                                                annotation (Line(
      points={{46,-30},{32,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary3.ports[1], pipeFriction3.port_b)
                                                annotation (Line(
      points={{-1.11022e-15,20},{-1.11022e-15,10},{1.1119e-15,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sine1.y, boundary1.p_in) annotation (Line(
      points={{-79,-10},{-76,-10},{-76,-22},{-70,-22}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sine2.y, boundary1.T_in) annotation (Line(
      points={{-79,-48},{-76,-48},{-76,-26},{-70,-26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sine3.y, boundary3.p_in) annotation (Line(
      points={{-1.28416e-15,59},{-1.28416e-15,50.5},{-8,50.5},{-8,42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(temperature.port, pipeFriction3.port_a) annotation (Line(
      points={{6.10623e-16,-60},{6.10623e-16,-10},{-1.12703e-16,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (experiment(StopTime=10));
end IdealMixing1;
