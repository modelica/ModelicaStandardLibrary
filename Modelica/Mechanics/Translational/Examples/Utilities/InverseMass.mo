within Modelica.Mechanics.Translational.Examples.Utilities;
model InverseMass "Input/output block of an inverse mass model"
  extends Modelica.Blocks.Icons.Block;
  parameter SI.Mass m=1 "Mass";
  Modelica.Mechanics.Translational.Components.Mass mass(
    m=m)           annotation (Placement(transformation(extent={{-10,
            -10},{10,10}})));
  Modelica.Mechanics.Translational.Components.GeneralPositionToForceAdaptor positionToForce
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Interfaces.RealInput s(unit="m") "Position to drive the mass"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput v(unit="m/s") "Speed to drive the mass"
    annotation (Placement(transformation(extent={{-140,30},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput a(unit="m/s2")
    "Acceleration to drive the mass"            annotation (Placement(
        transformation(extent={{-140,-70},{-100,-30}})));
  Modelica.Blocks.Interfaces.RealOutput f(unit="N")
    "Force needed to drive the flange according to s, v, a"
    annotation (Placement(transformation(extent={{-100,-90},{-120,-70}})));
equation

  connect(positionToForce.f, f) annotation (Line(points={{-23,-8},{-60,
          -8},{-60,-80},{-110,-80}}, color={0,0,127}));
  connect(positionToForce.flange, mass.flange_a)
    annotation (Line(points={{-18,0},{-10,0}}, color={0,127,0}));
  connect(positionToForce.p, s) annotation (Line(points={{-23,8},{-60,
          8},{-60,80},{-120,80}}, color={0,0,127}));
  connect(positionToForce.pder, v) annotation (Line(points={{-23,5},{-80,
          5},{-80,50},{-120,50}},     color={0,0,127}));
  connect(positionToForce.pder2, a) annotation (Line(points={{-23,2},{-80,
          2},{-80,-50},{-120,-50}},      color={0,0,127}));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Text(
                extent={{0,-62},{96,-94}},
                textColor={135,135,135},
                textString="to FMU"),Text(
                extent={{-94,96},{-10,66}},
                horizontalAlignment=TextAlignment.Left,
          textString="s"),     Text(
                extent={{-94,46},{-10,16}},
                horizontalAlignment=TextAlignment.Left,
          textString="v"),   Text(
                extent={{-92,-14},{-8,-44}},
                horizontalAlignment=TextAlignment.Left,
                textString="a"),Text(
                extent={{-150,-110},{150,-140}},
          textString="m=%m"),      Bitmap(extent={{-58,-42},{98,48}},
            fileName="modelica://Modelica/Resources/Images/Mechanics/Translational/InverseMass.png"),
          Text( extent={{-90,-64},{-6,-94}},
                horizontalAlignment=TextAlignment.Left,
          textString="f")}), Documentation(info="<html>
<p>
A translational component with pure signal interface which can be applied for
a FMU (<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>)
exchange.
Based on the kinematic inputs applied on a sliding mass
the output force&nbsp;<code>f</code> is returned.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.Translational.Examples.Utilities.DirectMass\">DirectMass</a>.
</p>
</html>"));
end InverseMass;
