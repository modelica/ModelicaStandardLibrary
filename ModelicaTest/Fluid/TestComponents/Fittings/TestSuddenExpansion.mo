within ModelicaTest.Fluid.TestComponents.Fittings;
model TestSuddenExpansion
  "Test of sudden expansion models, with correct and wrong usage"
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.Boundary_pT leftBoundary1(
    redeclare package Medium =
        Modelica.Media.Water.StandardWaterOnePhase,
    nPorts=1,
    p=100000)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Fluid.Sources.Boundary_pT rightBoundary1(
    redeclare package Medium =
        Modelica.Media.Water.StandardWaterOnePhase,
    nPorts=1,
    p=110000)
    annotation (Placement(transformation(extent={{80,20},{60,40}})));
  Modelica.Fluid.Fittings.AbruptAdaptor suddenExpansion1(
    diameter_a=0.1,
    diameter_b=0.2,
    redeclare package Medium =
        Modelica.Media.Water.StandardWaterOnePhase)
    annotation (Placement(transformation(extent={{-12,20},{8,40}})));
  Modelica.Fluid.Sources.Boundary_pT leftBoundary2(
    redeclare package Medium =
        Modelica.Media.Water.StandardWaterOnePhase,
    nPorts=1,
    p=100000)
    annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
  Modelica.Fluid.Sources.Boundary_pT rightBoundary2(
    redeclare package Medium =
        Modelica.Media.Water.StandardWaterOnePhase,
    nPorts=1,
    p=110000)
    annotation (Placement(transformation(extent={{90,-40},{70,-20}})));
  Modelica.Fluid.Fittings.AbruptAdaptor suddenExpansion2(
    diameter_a=0.1,
    diameter_b=0.2,
    redeclare package Medium =
        Modelica.Media.Water.StandardWaterOnePhase)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Modelica.Fluid.Fittings.AbruptAdaptor leftAdapter(
    diameter_a=0.1,
    redeclare package Medium =
        Modelica.Media.Water.StandardWaterOnePhase,
    diameter_b=Modelica.Constants.inf)
    annotation (Placement(transformation(extent={{-40,-40},{-60,-20}})));
  Modelica.Fluid.Fittings.AbruptAdaptor rightAdapter(
    redeclare package Medium =
        Modelica.Media.Water.StandardWaterOnePhase,
    diameter_a=0.2,
    diameter_b=Modelica.Constants.inf)
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  connect(leftBoundary1.ports[1], suddenExpansion1.port_a) annotation (Line(
      points={{-60,30},{-12,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(suddenExpansion1.port_b, rightBoundary1.ports[1]) annotation (Line(
      points={{8,30},{60,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(leftAdapter.port_b, leftBoundary2.ports[1]) annotation (Line(
      points={{-60,-30},{-70,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(leftAdapter.port_a, suddenExpansion2.port_a) annotation (Line(
      points={{-40,-30},{-10,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(suddenExpansion2.port_b, rightAdapter.port_a) annotation (Line(
      points={{10,-30},{40,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(rightAdapter.port_b, rightBoundary2.ports[1]) annotation (Line(
      points={{60,-30},{70,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics),
    Documentation(info="<html>
<p>
This example shows the use of a sudden expansion / contraction model, which is connected to two boundary conditions prescribing static pressure. Notice that the prescribed static pressure on the right boundary is higher than on the left one. Still, the fluid flows from left to right.
</p>
<p>
The reason for this is that the boundary conditions model infinite reservoirs with an infinite diameter and thus zero flow velocity. The sudden expansion model does however have two ends with finite diameters, and, as explained in the <a href=\"modelica://Modelica.Fluid.UsersGuide.Overview\">Overview</a> of the Users' Guide, the momentum balance is not fulfilled exactly for this type of connections. Using a simple <code>connect()</code>-statement, the difference of the kinetic terms is neglected, which is not reasonable in the present model: At the left boundary condition it is zero, and on the left side of the sudden expansion it has a non-zero value. It is not reasonable to neglect it in the shown model, because there is little friction and therefore these kinetic effects dominate. Consequently, only modelling these effects explicitly leads to the correct results.
</p>
<p>
To do so, two additional sudden expansions / contractions are included in the model. The diameter is set to <code>inf</code> close to the boundaries and the proper values close to the original model. These additional components now introduce <i>exact</i> momentum balances and the results are as expected.
</p>
</html>"));
end TestSuddenExpansion;
