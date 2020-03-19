within Modelica.Mechanics.Translational.Examples.Utilities;
model DirectMass "Input/output block of a direct mass model"
  extends Modelica.Blocks.Icons.Block;
  parameter SI.Mass m(min=0)=1 "Mass";
  Modelica.Mechanics.Translational.Components.Mass mass(
    m=m,
    s(start=0, fixed=true),
    v(start=0, fixed=true))
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Mechanics.Translational.Sources.Force forceSource
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Interfaces.RealInput fDrive(unit="N")
    "Accelerating force acting at flange (= -flange.f)"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Mechanics.Translational.Components.GeneralForceToPositionAdaptor forceToPosition
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Interfaces.RealOutput s(unit="m")
    "Mass moves with position s due to force f"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput v(unit="m/s")
    "Mass moves with speed v due to force f"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Interfaces.RealOutput a(unit="m/s2")
    "Mass moves with acceleration a due to force f"
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  Modelica.Blocks.Interfaces.RealInput f(unit="N") "Force to drive the mass"
                              annotation (Placement(transformation(
          extent={{140,-100},{100,-60}})));
equation
  connect(forceToPosition.f, f) annotation (Line(points={{23,-8},{60,
          -8},{60,-80},{120,-80}}, color={0,0,127}));
  connect(forceToPosition.p, s) annotation (Line(points={{23,8},{60,8},
          {60,80},{110,80}}, color={0,0,127}));
  connect(forceToPosition.pder, v) annotation (Line(points={{23,5},{
          80,5},{80,30},{110,30}}, color={0,0,127}));
  connect(forceToPosition.pder2, a) annotation (Line(points={{23,2},{
          80,2},{80,-30},{110,-30}}, color={0,0,127}));
  connect(fDrive, forceSource.f)
    annotation (Line(points={{-120,0},{-52,0}}, color={0,0,127}));
  connect(forceSource.flange, mass.flange_a)
    annotation (Line(points={{-30,0},{-20,0}}, color={0,127,0}));
  connect(mass.flange_b, forceToPosition.flange)
    annotation (Line(points={{0,0},{18,0}}));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Text(
                extent={{-84,-58},{24,-90}},
                textColor={135,135,135},
                textString="to FMU"),Text(
                extent={{8,96},{92,66}},
                horizontalAlignment=TextAlignment.Right,
          textString="s"),                            Text(
                extent={{10,46},{94,16}},
                horizontalAlignment=TextAlignment.Right,
          textString="v"),   Text(
                extent={{10,-10},{94,-40}},
                horizontalAlignment=TextAlignment.Right,
                textString="a"),Text(
                extent={{-150,-110},{150,-140}},
          textString="m=%m"),      Bitmap(extent={{-96,-42},{64,54}},
            fileName="modelica://Modelica/Resources/Images/Mechanics/Translational/DirectMass.png"),
          Text( extent={{10,-60},{94,-90}},
                horizontalAlignment=TextAlignment.Right,
          textString="f")}), Documentation(info="<html>
<p>
A translational component with pure signal interface which can be applied for
a FMU (<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>)
exchange.
The input force <code>fDrive</code> is applied on one side of a sliding mass
whereby the input force&nbsp;<code>f</code> is applied
on the other side of it.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.Translational.Examples.Utilities.InverseMass\">InverseMass</a>.
</p>
</html>"));
end DirectMass;
