within Modelica.Mechanics.Rotational.Examples;
model EddyCurrentBrake "Demonstrate the usage of the rotational eddy current brake"
  extends Modelica.Icons.Example;
  Modelica.Mechanics.Rotational.Sources.EddyCurrentTorque eddyCurrentTorque(
    useExcitationInput=true,
    tau_nominal=100,
    w_nominal=10,
    useSupport=false,
    alpha20(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper,
    TRef=293.15,
    useHeatPort=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(
    phi(fixed=true, start=0),
    J=1,
    w(fixed=true, start=20))
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=1, T(
        fixed=true)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-10,-30})));
  Blocks.Sources.Ramp ramp(
    height=1,
    duration=0.1,
    offset=0,
    startTime=0.1)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
equation
  connect(eddyCurrentTorque.flange, inertia.flange_a)
    annotation (Line(points={{10,0},{16,0},{20,0}}));
  connect(eddyCurrentTorque.heatPort, heatCapacitor.port) annotation (Line(
        points={{-10,-10},{-10,-15},{-10,-20}}, color={191,0,0}));
  connect(ramp.y, eddyCurrentTorque.excitation)
    annotation (Line(points={{-29,0},{-12,0}}, color={0,0,127}));
  annotation (
    experiment(StopTime=1.0, Interval=0.001),
    Documentation(info="<html>
<p>
An eddy current brake reduces the speed of a rotating inertia. Kinetic energy is converted to thermal energy which leads to a temperature increase of the thermal capacitance of the brake, which can be assumed as adiabatic during the rather short time span of the braking.
</p>
</html>"));
end EddyCurrentBrake;
