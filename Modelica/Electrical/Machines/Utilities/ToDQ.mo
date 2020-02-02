within Modelica.Electrical.Machines.Utilities;
block ToDQ
  "Transform instantaneous stator inputs to rotor fixed space phasor"
  extends Modelica.Blocks.Interfaces.MIMO(final nin=m, final nout=2);
  parameter Integer m(min=1) = 3 "Number of phases" annotation(Evaluate=true);
  parameter Integer p "Number of pole pairs";
  Modelica.Blocks.Math.Gain toGamma(final k=p) annotation (Placement(
        transformation(
        origin={0,-50},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.Rotator rotator
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput phi(unit="rad") annotation (Placement(
        transformation(
        origin={0,-120},
        extent={{20,-20},{-20,20}},
        rotation=270)));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.ToSpacePhasor toSpacePhasor(final m=m)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(phi, toGamma.u)
    annotation (Line(points={{0,-120},{0,-120},{0,-62}}, color={0,0,127}));
  connect(rotator.angle, toGamma.y)
    annotation (Line(points={{0,-12},{0,-39},{0,-39}}, color={0,0,127}));
  connect(toSpacePhasor.y, rotator.u) annotation (Line(
      points={{-39,0},{-12,0}}, color={0,0,127}));
  connect(u, toSpacePhasor.u) annotation (Line(
      points={{-120,0},{-62,0}}, color={0,0,127}));
  connect(rotator.y, y) annotation (Line(
      points={{11,0},{110,0}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
The polyphase input values <code>u[m]</code> are transformed to the corresponding space phasor which is rotated to the rotor fixed reference system,
using the provided mechanical rotor angle phi. The output are the resulting d and q components of the space phasor arranged in one vector <code>y[2]</code>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Utilities.FromDQ\">FromDQ</a>
</p>
</html>"));
end ToDQ;
