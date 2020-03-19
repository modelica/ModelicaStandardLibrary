within Modelica.Mechanics.Rotational.Components;
model GeneralAngleToTorqueAdaptor
  "Signal adaptor for a rotational flange with torque as output and angle, speed and acceleration as input (especially useful for FMUs)"
  extends
    Modelica.Blocks.Interfaces.Adaptors.PotentialToFlowAdaptor(
    final Name_p="phi",
    final Name_pder="w",
    final Name_pder2="a",
    final Name_f="tau",
    final Name_fder="der(tau)",
    final Name_fder2="der2(tau)",
    final use_fder=false,
    final use_fder2=false,
    final p(unit="rad"),
    final pder(unit="rad/s"),
    final pder2(unit="rad/s2"),
    final f(unit="N.m"),
    final fder(unit="N.m/s"),
    final fder2(unit="N.m/s2"));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b    flange
    annotation (Placement(transformation(extent={{10,-10},{30,10}}),
        iconTransformation(extent={{10,-10},{30,10}})));
equation
  y = flange.tau "output = flow = torque";
  u = flange.phi "input = potential = angle";
  annotation (defaultComponentName="angleToTorqueAdaptor",
    Documentation(info="<html>
<p>
Adaptor between a flange connector and a signal representation of the flange.
This component is used to provide a pure signal interface around a Rotational model
and export this model in form of an input/output block,
especially as FMU (<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>).
This adaptor has angle, angular velocity and angular acceleration as input signals and
torque as output signal.
</p>
<p>
Note, the input signals must be consistent to each other
(w=der(phi), a=der(w)).
</p>
</html>"),
    Icon(graphics={
            Rectangle(
              extent={{-20,100},{20,-100}},
              lineColor={95,95,95},
              radius=10,
          lineThickness=0.5)}));
end GeneralAngleToTorqueAdaptor;
