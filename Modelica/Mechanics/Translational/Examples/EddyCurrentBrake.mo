within Modelica.Mechanics.Translational.Examples;
model EddyCurrentBrake "Demonstrate the usage of the translational eddy current brake"
  extends Modelica.Icons.Example;
  Modelica.Mechanics.Translational.Sources.EddyCurrentForce
    eddyCurrentForce(
    f_nominal=100,
    v_nominal=10,
    useHeatPort=true,
    TRef=293.15,
    alpha20(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Translational.Components.Mass mass(
    m=1,
    s(fixed=true, start=0),
    v(fixed=true, start=20))
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=1, T(
        fixed=true)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-10,-30})));
equation
  connect(eddyCurrentForce.flange, mass.flange_a)
    annotation (Line(points={{10,0},{20,0}}, color={0,127,0}));
  connect(eddyCurrentForce.heatPort, heatCapacitor.port) annotation (Line(
        points={{-10,-10},{-10,-15},{-10,-20}}, color={191,0,0}));
  annotation (
    experiment(StopTime=1.0, Interval=0.001),
    Documentation(info="<html>
An eddy current brake reduces the speed of a moving mass. Kinetic energy is converted to thermal energy which leads to a temperature increase of the thermal capacitance of the brake, which can be assumed as adiabatic during the rather short time span of the braking.
</html>"));
end EddyCurrentBrake;
