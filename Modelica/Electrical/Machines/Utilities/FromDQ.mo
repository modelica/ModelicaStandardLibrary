within Modelica.Electrical.Machines.Utilities;
block FromDQ
  "Transform rotor fixed space phasor to instantaneous stator quantities"
  extends Modelica.Blocks.Interfaces.MIMO(final nin=2, final nout=m);
  parameter Integer m(min=1) = 3 "Number of phases" annotation(Evaluate=true);
  parameter Integer p "Number of pole pairs";
  Modelica.Blocks.Math.Gain toGamma(final k=-p) annotation (Placement(
        transformation(
        origin={0,-50},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.Rotator rotator
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant i0(final k=0) annotation (Placement(
        transformation(extent={{20,-20},{40,-40}})));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.FromSpacePhasor fromSpacePhasor(final m=m)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Interfaces.RealInput phi(unit="rad") annotation (Placement(
        transformation(
        origin={0,-120},
        extent={{20,-20},{-20,20}},
        rotation=270)));
equation
  connect(phi, toGamma.u)
    annotation (Line(points={{0,-120},{0,-120},{0,-62}}, color={0,0,127}));
  connect(rotator.angle, toGamma.y)
    annotation (Line(points={{0,-12},{0,-39},{0,-39}}, color={0,0,127}));
  connect(rotator.y, fromSpacePhasor.u)
    annotation (Line(points={{11,0},{34,0},{58,0}}, color={0,0,127}));
  connect(i0.y, fromSpacePhasor.zero) annotation (Line(
      points={{41,-30},{50,-30},{50,-8},{58,-8}}, color={0,0,127}));
  connect(u, rotator.u) annotation (Line(
      points={{-120,0},{-12,0}}, color={0,0,127}));
  connect(fromSpacePhasor.y, y) annotation (Line(
      points={{81,0},{110,0}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
The d and q components of a space phasor <code>u[2]</code> are rotated back to the stator fixed reference system,
using the provided mechanical rotor angle phi. The output are the instantaneous polyphase values <code>y[m]</code>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Utilities.ToDQ\">ToDQ</a>
</p>
</html>"));
end FromDQ;
