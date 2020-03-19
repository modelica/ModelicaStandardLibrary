within Modelica.Mechanics.Translational.Components;
model GeneralPositionToForceAdaptor
  "Signal adaptor for a Translational flange with force as output and position, speed and acceleration as input (especially useful for FMUs)"
  extends Modelica.Blocks.Interfaces.Adaptors.PotentialToFlowAdaptor(
    final Name_p="s",
    final Name_pder="v",
    final Name_pder2="a",
    final Name_f="f",
    final Name_fder="der(f)",
    final Name_fder2="der2(f)",
    final use_fder=false,
    final use_fder2=false,
    final p(unit="m"),
    final pder(unit="m/s"),
    final pder2(unit="m/s2"),
    final f(unit="N"),
    final fder(unit="N/s"),
    final fder2(unit="N/s2"));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange
    annotation (Placement(transformation(extent={{10,-10},{30,10}}),
        iconTransformation(extent={{10,-10},{30,10}})));
equation
  y = flange.f "output = flow = force";
  u = flange.s "input = potential = position";
  annotation (
    defaultComponentName="positionToForceAdaptor",
    Documentation(info="<html>
<p>
Adaptor between a flange connector and a signal representation of the flange.
This component is used to provide a pure signal interface around a Translational model
and export this model in form of an input/output block,
especially as FMU (<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>).
Examples of the usage of this adaptor are provided in
<a href=\"modelica://Modelica.Mechanics.Translational.Examples.GenerationOfFMUs\">Translational.Examples.GenerationOfFMUs</a>.
This adaptor has position, velocity and acceleration as input signals and
force as output signal.
</p>
<p>
Note, the input signals must be consistent to each other
(v=der(s), a=der(v)).
</p>
</html>"),
       Icon(graphics={
            Rectangle(
              extent={{-20,100},{20,-100}},
              lineColor={0,127,0},
              radius=10,
          lineThickness=0.5)}));
end GeneralPositionToForceAdaptor;
