within Modelica.Electrical.Analog.Basic;
model GeneralCurrentToVoltageAdaptor
  "Signal adaptor for an Electrical OnePort with voltage and derivative of voltage as outputs and current and derivative of current as inputs (especially useful for FMUs)"
  extends Modelica.Blocks.Interfaces.Adaptors.FlowToPotentialAdaptor(
    final Name_p="v",
    final Name_pder="dv",
    final Name_pder2="d2v",
    final Name_f="i",
    final Name_fder="di",
    final Name_fder2="d2i",
    final use_pder2=false,
    final use_fder2=false,
    final p(unit="V"),
    final pder(unit="V/s"),
    final pder2(unit="V/s2"),
    final f(unit="A"),
    final fder(unit="A/s"),
    final fder2(unit="A/s2"));
  SI.Voltage v "Voltage drop between the two pins (= p.v - n.v)";
  SI.Current i "Current flowing from pin p to pin n";
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
    annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
    annotation (Placement(transformation(extent={{-30,-90},{-10,-70}})));
equation
  v = pin_p.v - pin_n.v;
  i = pin_p.i;
  pin_p.i + pin_n.i = 0;
  y = v "output = potential = voltage";
  u = i "input = flow = current";
  annotation (defaultComponentName="currentToVoltageAdaptor", Documentation(info="<html>
<p>
Adaptor between an electrical oneport and a signal representation of the oneport.
This component is used to provide a pure signal interface around an Electrical model
and export this model in form of an input/output block,
especially as FMU (<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>).
Examples of the usage of this adaptor are provided in
<a href=\"modelica://Modelica.Electrical.Analog.Examples.GenerationOfFMUs\">Electrical.Analog.Examples.GenerationOfFMUs</a>.
This adaptor has current and derivative of current as inputs and voltage and derivative of voltage as output signals.
</p>
<p>
Note, the input signals must be consistent to each other
(di=der(i)).
</p>
<p>
Note, the adaptor contains <strong>no ground</strong>.
Bear in mind that separating physical components and connecting them via adaptor signals requires to place appropriate
<a href=\"modelica://Modelica.Electrical.Analog.Basic.Ground\">ground components</a> to define electric potential within the subcircuits.
</p>
</html>"), Icon(graphics={
            Rectangle(
              extent={{-20,100},{20,-100}},
              lineColor={0,0,255},
              radius=10,
          lineThickness=0.5)}));
end GeneralCurrentToVoltageAdaptor;
