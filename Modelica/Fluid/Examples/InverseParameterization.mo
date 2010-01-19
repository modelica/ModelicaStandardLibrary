within Modelica.Fluid.Examples;
model InverseParameterization
  "Demonstrates the parameterization of a pump and a pipe for given nominal values"
  extends Modelica.Icons.Example;
  replaceable package Medium = Modelica.Media.Water.StandardWater;
      //Modelica.Media.Water.ConstantPropertyLiquidWater;

  Modelica.Fluid.Sources.Boundary_pT source(
    redeclare package Medium = Medium,
    nPorts=1,
    use_p_in=false,
    p=100000)
    annotation (Placement(transformation(extent={{-76,14},{-64,26}}, rotation=0)));
  Modelica.Fluid.Machines.ControlledPump pump(
    m_flow_nominal=1,
    control_m_flow=false,
    use_p_set=true,
    redeclare package Medium = Medium,
    p_a_nominal=100000,
    p_b_nominal=200000)
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Fluid.Fittings.SimpleGenericOrifice orifice(
    redeclare package Medium = Medium,
    diameter=2.54e-2,
    m_flow_nominal=1,
    use_zeta=false,
    zeta=0,
    dp_nominal=100000)
                      annotation (Placement(transformation(extent={{20,10},{40,
            30}}, rotation=0)));

  Modelica.Fluid.Sources.Boundary_pT sink(nPorts=1,redeclare package Medium = Medium, p=
        100000)
             annotation (Placement(transformation(extent={{76,14},{64,26}},
          rotation=0)));

  inner Modelica.Fluid.System system
                        annotation (Placement(transformation(extent={{-90,50},{
            -70,70}},  rotation=0)));
  Modelica.Fluid.Pipes.StaticPipe pipe1(
    redeclare package Medium = Medium,
    diameter=2.54e-2,
    length=0,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalTurbulentPipeFlow (
        m_flow_nominal=1,
        show_Res=true,
        dp_nominal=100000))
                      annotation (Placement(transformation(extent={{20,-30},{40,
            -10}},rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT sink1(nPorts=1,
    redeclare package Medium = Medium, p=200000)
             annotation (Placement(transformation(extent={{76,-26},{64,-14}},
          rotation=0)));
  Modelica.Blocks.Sources.Ramp p_set(
    height=0.2e5,
    offset=1.9e5,
    duration=8,
    startTime=1)
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Modelica.Fluid.Pipes.StaticPipe pipe2(
    redeclare package Medium = Medium,
    diameter=2.54e-2,
    length=1000,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
        show_Res=true,
        dp_nominal=100000,
        m_flow_nominal=1))
                      annotation (Placement(transformation(extent={{20,-70},{40,
            -50}},rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT sink2(nPorts=1,
    redeclare package Medium = Medium, p=200000)
             annotation (Placement(transformation(extent={{76,-66},{64,-54}},
          rotation=0)));
equation
  connect(orifice.port_b, sink.ports[1])
                                       annotation (Line(
      points={{40,20},{64,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(source.ports[1], pump.port_a) annotation (Line(
      points={{-64,20},{-40,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_b, orifice.port_a)
                                    annotation (Line(
      points={{-20,20},{20,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe1.port_b, sink1.ports[1]) annotation (Line(
      points={{40,-20},{64,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe1.port_a, pump.port_b) annotation (Line(
      points={{20,-20},{0,-20},{0,20},{-20,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(p_set.y, pump.p_set) annotation (Line(
      points={{-29,50},{-25,50},{-25,28.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pipe2.port_b, sink2.ports[1]) annotation (Line(
      points={{40,-60},{64,-60}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(pump.port_b, pipe2.port_a) annotation (Line(
      points={{-20,20},{0,20},{0,-60},{20,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (
    __Dymola_Commands(file(ensureSimulated=true)="Scripts/Fluid/InverseParameterization/plotResults.mos"
        "plotResults"),
    Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
            100,100}}),
            graphics),
    experiment(StopTime=10, NumberOfIntervals=10000),
    Documentation(info="<html>
<p>
A pump, an orifice and two pipes are parameterized with simple nominal values.
Note that pipe1 and pipe2 use the flowModel NominalTurbulentFlow and NominalLaminarFlow, respectively,
which do not require the specification of geometry data.
Instead pathLengths_nominal are obtained internally for given nominal pressure loss and nominal mass flow rate.
</p>
<p>
The pump controls a pressure ramp from 1.9 bar to 2.1 bar.
This causes an appropriate ramp on the mass flow rate of the orifice, which has a boundary pressure of 1 bar.
Flow reversal occurs in the pipes, which have a boundary pressure of 2 bar.
The Command plotResults can be used to see the pump speed N, which is controlled ideally to obtain the pressure ramp.
Moreover the internally obtained nominal design values that fulfill the nominal operating conditions as well as
the Reynolds number, m_flows_turbulent, and dps_fg_turbulent are plotted.
</p>
<p>
Note that the large value for pipe2.flowModel.pathLengths_nominal[1] is only meaningful under the made assumption of laminar flow,
 which is hardly possible for a real pipe.
</p>
<p>
Once the geometries have been designed, the NominalTurbulentPipeFlow correlations can easily be replaced with
TurbulentPipeFlow or DetailedPipeFlow correlations. Similarily the ControlledPump can be replaced with a PrescribedPump
to investigate a real controller or with a Pump with rotational shaft to investigate inertia effects.
</p>

<p align=\"center\">
<img src=\"../Images/Fluid/Examples/InverseParametrization.png\" border=\"1\">
</p>

</html>"));
end InverseParameterization;
