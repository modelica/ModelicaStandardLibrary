within Modelica.Mechanics.Translational.Components;
model GeneralForceToPositionAdaptor
  "Signal adaptor for a Translational flange with position, speed, and acceleration as outputs and force as input (especially useful for FMUs)"
  extends Modelica.Blocks.Interfaces.Adaptors.FlowToPotentialAdaptor(
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
  Modelica.Mechanics.Translational.Interfaces.Flange_a flange
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
equation
  y = flange.s "output = potential = position";
  u = flange.f "input = flow = force";
  annotation (
    defaultComponentName="forceToPositionAdaptor",
    Documentation(info="<html>
<p>
Adaptor between a flange connector and a signal representation of the flange.
This component is used to provide a pure signal interface around a Translational model
and export this model in form of an input/output block,
especially as FMU (<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>).
Examples of the usage of this adaptor are provided in
<a href=\"modelica://Modelica.Mechanics.Translational.Examples.GenerationOfFMUs\">Translational.Examples.GenerationOfFMUs</a>.
This adaptor has force as input and position, velocity and acceleration as output signals.
</p>
</html>"), Icon(graphics={
            Rectangle(
              extent={{-20,100},{20,-100}},
              lineColor={0,127,0},
              radius=10,
          lineThickness=0.5)}));
end GeneralForceToPositionAdaptor;
