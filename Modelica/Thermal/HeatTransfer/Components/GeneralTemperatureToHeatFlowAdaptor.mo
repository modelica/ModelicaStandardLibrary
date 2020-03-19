within Modelica.Thermal.HeatTransfer.Components;
model GeneralTemperatureToHeatFlowAdaptor
  "Signal adaptor for a HeatTransfer port with heat flow as output and temperature and derivative of temperature as input (especially useful for FMUs)"
  extends Modelica.Blocks.Interfaces.Adaptors.PotentialToFlowAdaptor(
    final Name_p="T",
    final Name_pder="dT",
    final Name_pder2="d2T",
    final Name_f="Q",
    final Name_fder="der(Q)",
    final Name_fder2="der2(Q)",
    final use_pder2=false,
    final use_fder=false,
    final use_fder2=false,
    p(unit="K", displayUnit="degC"),
    final pder(unit="K/s"),
    final pder2(unit="K/s2"),
    final f(unit="W"),
    final fder(unit="W/s"),
    final fder2(unit="W/s2"));
  HeatTransfer.Interfaces.HeatPort_b heatPort annotation (Placement(
        transformation(extent={{10,-10},{30,10}}), iconTransformation(extent={{
            10,-10},{30,10}})));
equation
  y = heatPort.Q_flow "output = flow = heat flow";
  u = heatPort.T "input = potential = temperature";
  annotation (defaultComponentName="temperatureToHeatFlowAdaptor",
    Documentation(info="<html>
<p>
Adaptor between a heatport connector and a signal representation of the flange.
This component is used to provide a pure signal interface around a HeatTransfer model
and export this model in form of an input/output block,
especially as FMU (<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>).
Examples of the usage of this adaptor are provided in
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Examples.GenerationOfFMUs\">HeatTransfer.Examples.GenerationOfFMUs</a>.
This adaptor has temperature and derivative of temperature as input signals and heatflow as output signal.
</p>
<p>
Note, the input signals must be consistent to each other
(derT=der(T)).
</p>
</html>"),
    Icon(graphics={
            Rectangle(
          extent={{-20,100},{20,-100}},
          lineColor={191,0,0},
          radius=10,
          lineThickness=0.5)}));
end GeneralTemperatureToHeatFlowAdaptor;
