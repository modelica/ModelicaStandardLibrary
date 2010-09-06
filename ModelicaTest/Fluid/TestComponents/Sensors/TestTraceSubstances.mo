within ModelicaTest.Fluid.TestComponents.Sensors;
model TestTraceSubstances
  import Modelica.Fluid;
  extends Modelica.Icons.Example;
  replaceable package Medium=Modelica.Media.Air.MoistAir(extraPropertiesNames={"CO2"});
  inner Modelica.Fluid.System system  annotation (Placement(transformation(
          extent={{-100,-100},{-80,-80}}, rotation=0)));
  Modelica.Fluid.Sources.Boundary_ph boundary_prescriberho_1(nPorts=1,
    p=system.p_ambient,
    use_p_in=false,
    use_h_in=false,
    use_C_in=true,
    redeclare package Medium = Medium)
                        annotation (Placement(transformation(extent={{
            -40,10},{-20,30}}, rotation=0)));
  Modelica.Fluid.Sensors.TraceSubstances traceSubstance(redeclare package
      Medium =         Medium)
    annotation (Placement(transformation(extent={{-10,20},{10,40}}, rotation=0)));
  Modelica.Fluid.Sources.Boundary_ph boundary_prescriberho_2(nPorts=1,
    p=system.p_ambient,
    use_h_in=false,
    use_C_in=true,
    redeclare package Medium = Medium)
                        annotation (Placement(transformation(extent={{
            -40,-30},{-20,-10}}, rotation=0)));
  Modelica.Fluid.Sensors.TraceSubstancesTwoPort traceSubstance1(redeclare
      package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}}, rotation=
            0)));
  Modelica.Blocks.Sources.Ramp C(duration=1, height=1.519E-3)
    "substance concentration, raising to 1000 PPM CO2"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(boundary_prescriberho_1.ports[1], traceSubstance.port)
                                                             annotation (Line(
      points={{-20,20},{0,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary_prescriberho_2.ports[1], traceSubstance1.port_a)
                                                                annotation (Line(
      points={{-20,-20},{-10,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(C.y, boundary_prescriberho_1.C_in[1]) annotation (Line(
      points={{-59,0},{-50,0},{-50,12},{-42,12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(C.y, boundary_prescriberho_2.C_in[1]) annotation (Line(
      points={{-59,0},{-50,0},{-50,-28},{-42,-28}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
            100,100}}),
            graphics),
    experiment(StopTime=2, Tolerance=1e-006));
end TestTraceSubstances;
