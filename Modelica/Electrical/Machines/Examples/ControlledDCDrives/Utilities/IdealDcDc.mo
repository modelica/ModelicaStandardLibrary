within Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities;
model IdealDcDc "Ideal DC-DC inverter"
  parameter SI.Time Td "Dead time";
  parameter SI.Time Ti=1e-6 "Time constant of integral power controller";
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage
    annotation (Placement(transformation(extent={{10,-80},{-10,-60}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,70})));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerBat
    annotation (Placement(transformation(extent={{40,80},{20,60}})));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerMot annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={30,-70})));
  Modelica.Blocks.Continuous.FirstOrder deadTime(
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0,
    T=Td) annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,0})));
  Modelica.Blocks.Continuous.Integrator powerController(
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0,
    k=1/Ti/unitVoltage) annotation (Placement(transformation(extent={{30,10},{10,30}})));
  Modelica.Electrical.Analog.Basic.Ground groundMotor annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-80,-80})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_nBat annotation (
      Placement(transformation(extent={{-110,110},{-90,90}}),
        iconTransformation(extent={{-110,110},{-90,90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_pBat
    annotation (Placement(transformation(extent={{90,110},{110,90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_nMot
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_pMot
    annotation (Placement(transformation(extent={{90,-112},{110,-92}})));
  Modelica.Blocks.Interfaces.RealInput vRef
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
protected
  constant SI.Voltage unitVoltage=1 annotation(HideResult=true);
equation
  connect(signalCurrent.p, powerBat.nc)
    annotation (Line(points={{10,70},{20,70}},         color={0,0,255}));
  connect(powerBat.pv, powerBat.pc)
    annotation (Line(points={{30,60},{40,60},{40,70}}, color={0,0,255}));
  connect(signalVoltage.p, powerMot.pc)
    annotation (Line(points={{10,-70},{20,-70}},          color={0,0,255}));
  connect(powerMot.pc, powerMot.pv)
    annotation (Line(points={{20,-70},{20,-60},{30,-60}}, color={0,0,255}));
  connect(powerBat.power, feedback.u2) annotation (Line(points={{40,81},
          {40,88},{70,88},{70,0},{58,0}},
                                  color={0,0,127}));
  connect(powerMot.power, feedback.u1) annotation (Line(points={{20,-81},
          {20,-88},{50,-88},{50,-8}},
                             color={0,0,127}));
  connect(feedback.y, powerController.u) annotation (Line(points={{50,9},
          {50,20},{32,20}}, color={0,0,127}));
  connect(powerController.y, signalCurrent.i)
    annotation (Line(points={{9,20},{0,20},{0,58}}, color={0,0,127}));
  connect(pin_nBat, signalCurrent.n) annotation (Line(points={{-100,100},
          {-100,70},{-10,70}},          color={0,0,255}));
  connect(pin_pBat, powerBat.pc) annotation (Line(points={{100,100},{
          100,70},{40,70}}, color={0,0,255}));
  connect(pin_nBat, powerBat.nv) annotation (Line(points={{-100,100},{
          30,100},{30,80}}, color={0,0,255}));
  connect(pin_nMot, powerMot.nv) annotation (Line(points={{-100,-100},{
          30,-100},{30,-80}}, color={0,0,255}));
  connect(pin_pMot, powerMot.nc) annotation (Line(points={{100,-102},{
          100,-70},{40,-70}},
                          color={0,0,255}));
  connect(pin_nMot, groundMotor.p) annotation (Line(points={{-100,-100},
          {-100,-80},{-90,-80}},color={0,0,255}));
  connect(deadTime.y, signalVoltage.v)
    annotation (Line(points={{-9,0},{0,0},{0,-58}}, color={0,0,127}));
  connect(vRef, deadTime.u)
    annotation (Line(points={{-120,0},{-32,0}}, color={0,0,127}));
  connect(signalVoltage.n, pin_nMot) annotation (Line(points={{-10,-70},
          {-100,-70},{-100,-100}},
                                 color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{100,100},{20,20}},     color={0,0,255}),
        Line(points={{-20,-20},{-100,-100}}, color={0,0,255}),
        Text(
          extent={{-40,80},{40,60}},
          textColor={128,128,128},
          textString="Bat"),
        Text(
          extent={{-100,20},{100,-20}},
          textColor={0,0,255},
          textString="%name"),
        Text(
          extent={{-40,-60},{40,-80}},
          textColor={128,128,128},
          textString="Mot")}),    Documentation(info="<html>
<p>This is a model of an ideal DC-DC inverter based on a power balance achieved by an integral controller.</p>
</html>"));
end IdealDcDc;
