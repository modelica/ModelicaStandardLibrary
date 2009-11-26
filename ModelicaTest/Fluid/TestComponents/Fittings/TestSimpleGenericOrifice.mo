within ModelicaTest.Fluid.TestComponents.Fittings;
model TestSimpleGenericOrifice
  extends Modelica.Icons.Example;
  parameter Real diameter_a = 0.1;
  parameter Real diameter_b = 0.2;
  parameter Real A_rel = (diameter_a/diameter_b)^2;
  parameter Real zeta =  (1 - A_rel)^2;

  replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Medium in all components"                        annotation (
    choicesAllMatching =                                                                            true);

  Modelica.Fluid.Sources.Boundary_pT ambient_a( redeclare package Medium =
        Medium,
    p=system.p_ambient,
    T=system.T_ambient,
    use_p_in=true,
    nPorts=2)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}}, rotation=0)));
  Modelica.Blocks.Sources.TimeTable p_table(table=[0,0.9999e5; 10,1.0001e5])
    annotation (Placement(transformation(extent={{-80,40},{-60,60}}, rotation=0)));

  Modelica.Fluid.Sources.Boundary_pT ambient_p1(nPorts=1,
    redeclare package Medium = Medium,
    p=1.0e5,
    T=Modelica.SIunits.Conversions.from_degC(80))
    annotation (Placement(transformation(extent={{60,40},{40,60}}, rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT ambient_p2(nPorts=1,
    redeclare package Medium = Medium,
    p=1.0e5,
    T=Modelica.SIunits.Conversions.from_degC(80))
    annotation (Placement(transformation(extent={{60,10},{40,30}}, rotation=0)));
  Modelica.Fluid.Fittings.SimpleGenericOrifice expansion1(
    redeclare package Medium = Medium,
    zeta=zeta,
    diameter=diameter_a)
             annotation (Placement(transformation(extent={{0,40},{20,60}},
          rotation=0)));
  Modelica.Fluid.Fittings.SimpleGenericOrifice expansion2(
    redeclare package Medium = Medium,
    from_dp=false,
    zeta=zeta,
    diameter=diameter_a) annotation (Placement(transformation(extent={{0,10},{20,30}},
          rotation=0)));

  inner Modelica.Fluid.System system
                                   annotation (Placement(transformation(extent=
            {{-82,-90},{-62,-70}}, rotation=0)));
equation
  connect(p_table.y, ambient_a.p_in)
                                    annotation (Line(points={{-59,50},{-52,50},
          {-52,58},{-42,58}}, color={0,0,127}));
  connect(ambient_a.ports[1], expansion1.port_a)
                                           annotation (Line(points={{-20,52},{
          -10,52},{-10,50},{0,50}},
                color={0,127,255}));
  connect(expansion1.port_b, ambient_p1.ports[1])
                                              annotation (Line(points={{20,50},
          {40,50}}, color={0,127,255}));
  connect(expansion2.port_b, ambient_p2.ports[1])
                                              annotation (Line(points={{20,20},
          {40,20}}, color={0,127,255}));
  connect(expansion2.port_a, ambient_a.ports[2])
                                           annotation (Line(points={{0,20},{-10,
          20},{-10,48},{-20,48}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(StopTime=10, NumberOfIntervals=10000),
    experimentSetupOutput,
    Documentation(info="<html>
</html>"));
end TestSimpleGenericOrifice;
