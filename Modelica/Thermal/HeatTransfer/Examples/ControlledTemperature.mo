within Modelica.Thermal.HeatTransfer.Examples;
model ControlledTemperature "Control temperature of a resistor"
  extends Modelica.Icons.Example;
  parameter SI.Temperature TAmb(displayUnit="degC") = 293.15
    "Ambient temperature";
  parameter SI.TemperatureDifference TDif = 2
    "Error in temperature";
  output SI.Temperature TRes(displayUnit="degC") = resistor.T_heatPort "Resulting temperature";
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={
            {-100,-100},{-80,-80}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=10)
    annotation (Placement(
        transformation(
        origin={-90,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  HeatTransfer.Components.HeatCapacitor heatCapacitor(C=1, T(start=TAmb, fixed=
          true))
    annotation (Placement(transformation(extent={{0,-60},{20,-80}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(
    R=10,
    T_ref=293.15,
    alpha=1/255,
    useHeatPort=true) annotation (Placement(transformation(
        origin={-30,-50},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  HeatTransfer.Sources.FixedTemperature fixedTemperature(T=TAmb)
    annotation (Placement(transformation(extent={{100,-60},{80,-40}})));
  HeatTransfer.Celsius.TemperatureSensor temperatureSensor annotation (
      Placement(transformation(
        origin={10,-30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  HeatTransfer.Components.ThermalConductor thermalConductor(G=0.1)
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch idealSwitch
        annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=25,
    duration=6,
    offset=25,
    startTime=2) annotation (Placement(transformation(extent={{40,0},{20,20}})));
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=TDif)
    annotation (Placement(transformation(extent={{0,-20},{-20,0}})));
  Modelica.Blocks.Logical.Not logicalNot
    annotation (Placement(transformation(
          extent={{-30,-20},{-50,0}})));
equation
  connect(constantVoltage.n, resistor.n) annotation (Line(points={{-90,-60},{-30,-60}}, color={0,0,255}));
  connect(constantVoltage.n, ground.p) annotation (Line(points={{-90,-60},
          {-90,-80}}, color={0,0,255}));
  connect(resistor.heatPort, thermalConductor.port_a) annotation (Line(points={{-20,-50},{40,-50}}, color={191,0,0}));
  connect(thermalConductor.port_b, fixedTemperature.port) annotation (Line(
        points={{60,-50},{80,-50}}, color={191,0,0}));
  connect(resistor.heatPort, temperatureSensor.port) annotation (Line(points={{-20,-50},{10,-50},{10,-40}}, color={191,0,0}));
  connect(resistor.heatPort, heatCapacitor.port) annotation (Line(points={{-20,-50},{10,-50},{10,-60}}, color={191,0,0}));
  connect(constantVoltage.p, idealSwitch.p) annotation (Line(points={{-90,
          -40},{-70,-40}}, color={0,0,255}));
  connect(idealSwitch.n, resistor.p) annotation (Line(points={{-50,-40},{-30,-40}}, color={0,0,255}));
  connect(ramp.y, onOffController.reference) annotation (Line(points={{19,
          10},{10,10},{10,-4},{2,-4}}, color={0,0,127}));
  connect(temperatureSensor.T, onOffController.u) annotation (Line(points=
         {{10,-20},{10,-16},{2,-16}}, color={0,0,127}));
  connect(onOffController.y, logicalNot.u)
                                      annotation (Line(points={{-21,-10},{
          -28,-10}}, color={255,0,255}));
  connect(logicalNot.y, idealSwitch.control)
                                        annotation (Line(points={{-51,-10},{-60,-10},{-60,-28}},
                                color={255,0,255}));
  annotation (Documentation(info="<html>
<p>
A constant voltage of 10 V is applied to a
temperature dependent resistor of 10*(1+(T-20C)/(235+20C)) Ohms,
whose losses v**2/r are dissipated via a
thermal conductance of 0.1 W/K to ambient temperature 20 degree C.
The resistor is assumed to have a thermal capacity of 1 J/K,
having ambient temperature at the beginning of the experiment.
The temperature of this heating resistor is held by an OnOff-controller
at reference temperature within a given bandwidth +/- 1 K
by switching on and off the voltage source.
The reference temperature starts at 25 degree C
and rises between t = 2 and 8 seconds linear to 50 degree C.
An appropriate simulating time would be 10 seconds.
</p>
</html>"),    experiment(StopTime=10, Interval=0.001));
end ControlledTemperature;
