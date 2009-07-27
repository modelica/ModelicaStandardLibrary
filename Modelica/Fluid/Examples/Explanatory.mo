within Modelica_Fluid.Examples;
package Explanatory
  "A set of examples illustrating when special attention has to be paid"

  model MomentumBalanceFittings
    "Illustrating a case in which kinetic terms play a major role in the momentum balance"
     extends Modelica.Icons.Example;
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}),
                      graphics),
      Documentation(info="<html>
<p>
This example shows the use of a sudden expansion / contraction model, which is connected to two boundary conditions prescribing static pressure. Notice that the prescribed static pressure on the right boundary is higher than on the left one. Still, the fluid flows from left to right. 
</p>
<p>
The reason for this is that the boundary conditions model infinite reservoirs with an infinite diameter and thus zero flow velocity. The sudden expansion model does however have two ends with finite diameters, and, as explained in the <a href=\"Modelica://Modelica_Fluid.UsersGuide.Overview\">Overview</a> of the Users' Guide, the momentum balance is not fulfilled exactly for this type of connections. Using a simple <code>connect()</code>-statement, the difference of the kinetic terms is neglected, which is not reasonable in the present model: At the left boundary condition it is zero, and on the left side of the sudden expansion it has a non-zero value. It is not reasonable to neglect it in the shown model, because there is little friction and therefore these kinetic effects dominate. Consequently, only modelling these effects explicitly leads to the correct results.
</p>
<p>
To do so, two additional sudden expansions / contractions are included in the model. The diameter is set to <code>inf</code> close to the boundaries and the proper values close to the original model. These additional components now introduce <i>exact</i> momentum balances and the results are as expected.
</p>
<p>
The total pressures offer an additional perspective on the model. After setting the parameter <code>show_totalPressures</code> on the Advanced tab of the <code>AbruptAdaptor</code>s to <code>true</code>, the total pressures are included in said models and may be plotted. This allows to confirm that the <b>total</b> pressure <i>always</i> reduces along the flow direction, even in the upper model.
</p>
 
 
<p align=\"center\">
<img src=\"../Images/Examples/MomentumBalanceFittings.png\" border=\"1\">
</p>
 
 
</html>"),
      Commands(file=
            "Scripts/Examples/MomentumBalanceFittings/Plot the model results.mos"
          "Plot the model results"));
    Modelica_Fluid.Sources.Boundary_pT leftBoundary1(
      redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase,
      nPorts=1,
      p=100000) 
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica_Fluid.Sources.Boundary_pT rightBoundary1(
      redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase,
      nPorts=1,
      p=110000) 
      annotation (Placement(transformation(extent={{80,20},{60,40}})));
    Modelica_Fluid.Fittings.AbruptAdaptor suddenExpansion1(
      diameter_a=0.1,
      diameter_b=0.2,
      redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase,
      show_totalPressures=true,
      show_portVelocities=true) 
      annotation (Placement(transformation(extent={{-12,20},{8,40}})));
    Modelica_Fluid.Sources.Boundary_pT leftBoundary2(
      redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase,
      nPorts=1,
      p=100000) 
      annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
    Modelica_Fluid.Sources.Boundary_pT rightBoundary2(
      redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase,
      nPorts=1,
      p=110000) 
      annotation (Placement(transformation(extent={{90,-40},{70,-20}})));
    Modelica_Fluid.Fittings.AbruptAdaptor suddenExpansion2(
      diameter_a=0.1,
      diameter_b=0.2,
      redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase,
      show_totalPressures=true,
      show_portVelocities=true) 
      annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
    Modelica_Fluid.Fittings.AbruptAdaptor leftAdaptor(
      diameter_a=0.1,
      redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase,
      diameter_b=Modelica.Constants.inf) 
      annotation (Placement(transformation(extent={{-40,-40},{-60,-20}})));
    Modelica_Fluid.Fittings.AbruptAdaptor rightAdaptor(
      redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase,
      diameter_a=0.2,
      diameter_b=Modelica.Constants.inf) 
      annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
    inner System system 
      annotation (Placement(transformation(extent={{-92,56},{-72,76}})));
  equation
    connect(leftBoundary1.ports[1], suddenExpansion1.port_a) annotation (Line(
        points={{-60,30},{-12,30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(suddenExpansion1.port_b, rightBoundary1.ports[1]) annotation (Line(
        points={{8,30},{60,30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(leftAdaptor.port_b, leftBoundary2.ports[1]) annotation (Line(
        points={{-60,-30},{-70,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(leftAdaptor.port_a, suddenExpansion2.port_a) annotation (Line(
        points={{-40,-30},{-10,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(suddenExpansion2.port_b,rightAdaptor. port_a) annotation (Line(
        points={{10,-30},{40,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(rightAdaptor.port_b, rightBoundary2.ports[1]) annotation (Line(
        points={{60,-30},{70,-30}},
        color={0,127,255},
        smooth=Smooth.None));
  end MomentumBalanceFittings;
end Explanatory;
