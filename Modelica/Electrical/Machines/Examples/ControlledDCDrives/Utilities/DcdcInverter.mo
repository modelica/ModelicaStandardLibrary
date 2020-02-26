within Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities;
model DcdcInverter "DC-DC inverter"
  parameter Boolean useIdealInverter=true "Use ideal averaging inverter, otherwise switching inverter";
  parameter SI.Frequency fS "Switching frequency";
  parameter SI.Time Td=0.5/fS "Dead time";
  parameter SI.Time Tmf=2/fS "Measurement filter time constant";
  parameter SI.Voltage VMax "Maximum Voltage";
  parameter SI.Time Ti=1e-6 "Time constant of integral power controller"
    annotation(Dialog(group="Averaging", enable=useIdealInverter));
  parameter SI.Resistance RonT=1e-05
    "Transistor closed resistance"
    annotation (Dialog(group="Switching", enable=not useIdealInverter));
  parameter SI.Conductance GoffT=1e-05
    "Transistor opened conductance"
    annotation (Dialog(group="Switching", enable=not useIdealInverter));
  parameter SI.Voltage VkneeT=0
    "Transistor threshold voltage"
    annotation (Dialog(group="Switching", enable=not useIdealInverter));
  parameter SI.Resistance RonD=1e-05
    "Diode closed resistance"
    annotation (Dialog(group="Switching", enable=not useIdealInverter));
  parameter SI.Conductance GoffD=1e-05
    "Diode opened conductance"
    annotation (Dialog(group="Switching", enable=not useIdealInverter));
  parameter SI.Voltage VkneeD=0 "Diode threshold voltage"
    annotation (Dialog(group="Switching", enable=not useIdealInverter));
  output SI.Power pDC=vDC*iDC "DC power (from battery)";
  output SI.Power pMot=vMot*iMot "Power to motor";
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_pBat
    annotation (Placement(transformation(extent={{50,110},{70,90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_nBat annotation (
      Placement(transformation(extent={{-70,110},{-50,90}}),
        iconTransformation(extent={{-70,110},{-50,90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_pMot
    annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_nMot
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));

  Modelica.Blocks.Interfaces.RealInput vRef
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput vDC annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-110,60})));
  Modelica.Blocks.Interfaces.RealOutput iDC annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={110,60})));

  Modelica.Blocks.Interfaces.RealOutput vMot annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={110,-60})));
  Modelica.Blocks.Interfaces.RealOutput iMot annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-110,-60})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vDCSensor annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,100})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor iMotSensor
    annotation (Placement(transformation(extent={{-50,-70},{-30,-90}})));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-90,20})));
  Modelica.Blocks.Continuous.FirstOrder vDCFilter(
    k=1,
    T=Tmf,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=VMax)
    annotation (Placement(transformation(extent={{-60,50},{-80,70}})));
  Modelica.Blocks.Continuous.FirstOrder iMotFilter(
    k=1,
    T=Tmf,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0)
    annotation (Placement(transformation(extent={{-60,-70},{-80,-50}})));
  IdealDcDc idealDcDc(Td=Td, Ti=Ti) if useIdealInverter
    annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  SwitchingDcDc switchingDcDc(
    fS=fS,
    VMax=VMax,
    RonT=RonT,
    GoffT=GoffT,
    VkneeT=VkneeT,
    RonD=RonD,
    GoffD=GoffD,
    VkneeD=VkneeD) if not useIdealInverter
    annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor iDCSensor
    annotation (Placement(transformation(extent={{50,70},{30,90}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vMotSensor annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-100})));
  Modelica.Blocks.Continuous.FirstOrder vMotFilter(
    k=1,
    T=Tmf,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0)
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  Modelica.Blocks.Continuous.FirstOrder iDCFilter(
    k=1,
    T=Tmf,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=VMax)
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
equation
  connect(iMotSensor.p, pin_nMot) annotation (Line(points={{-50,-80},{
          -60,-80},{-60,-100}},
                      color={0,0,255}));
  connect(vRef, variableLimiter.u)
    annotation (Line(points={{-120,0},{-72,0}}, color={0,0,127}));
  connect(gain.y, variableLimiter.limit2)
    annotation (Line(points={{-90,13.4},{-90,-8},{-72,-8}}, color={0,0,127}));
  connect(iMotSensor.i, iMotFilter.u)
    annotation (Line(points={{-40,-69},{-40,-60},{-58,-60}}, color={0,0,127}));
  connect(iMotFilter.y, iMot)
    annotation (Line(points={{-81,-60},{-110,-60}}, color={0,0,127}));
  connect(vDCFilter.y, vDC)
    annotation (Line(points={{-81,60},{-110,60}}, color={0,0,127}));
  connect(vDCFilter.y, gain.u)
    annotation (Line(points={{-81,60},{-90,60},{-90,27.2}}, color={0,0,127}));
  connect(vDCFilter.y, variableLimiter.limit1) annotation (Line(points={{-81,60},
          {-90,60},{-90,40},{-80,40},{-80,8},{-72,8}}, color={0,0,127}));
  connect(variableLimiter.y, idealDcDc.vRef) annotation (Line(points={{-49,0},{-40,
          0},{-40,-20},{8,-20}},              color={0,0,127}));
  connect(variableLimiter.y, switchingDcDc.vRef) annotation (Line(
        points={{-49,0},{-40,0},{-40,20},{-32,20}}, color={0,0,127}));
  connect(vDCFilter.y, switchingDcDc.vMax) annotation (Line(points={{-81,60},{-90,
          60},{-90,40},{-40,40},{-40,26},{-32,26}}, color={0,0,127}));
  connect(iDCSensor.p, pin_pBat)
    annotation (Line(points={{50,80},{60,80},{60,100}}, color={0,0,255}));
  connect(iMotSensor.n, switchingDcDc.pin_nMot)
    annotation (Line(points={{-30,-80},{-30,-80},{-30,10}}, color={0,0,255}));
  connect(vMotFilter.y, vMot)
    annotation (Line(points={{81,-60},{110,-60}}, color={0,0,127}));
  connect(iDCSensor.i, iDCFilter.u)
    annotation (Line(points={{40,69},{40,60},{58,60}}, color={0,0,127}));
  connect(iDCFilter.y, iDC)
    annotation (Line(points={{81,60},{110,60}}, color={0,0,127}));
  connect(idealDcDc.pin_pBat, iDCSensor.n)
    annotation (Line(points={{30,-10},{30,80}}, color={0,0,255}));
  connect(pin_nBat, switchingDcDc.pin_nBat)
    annotation (Line(points={{-60,100},{-30,100},{-30,30}}, color={0,0,255}));
  connect(pin_nBat, idealDcDc.pin_nBat) annotation (Line(points={{-60,100},
          {-30,100},{-30,80},{10,80},{10,-10}},
                                           color={0,0,255}));
  connect(iDCSensor.n, switchingDcDc.pin_pBat) annotation (Line(points={{30,80},
          {30,40},{-10,40},{-10,30}}, color={0,0,255}));
  connect(iMotSensor.n, idealDcDc.pin_nMot) annotation (Line(points={{-30,-80},{
          -30,-40},{10,-40},{10,-30}}, color={0,0,255}));
  connect(idealDcDc.pin_pMot, pin_pMot) annotation (Line(points={{30,
          -30.2},{30,-80},{60,-80},{60,-100}},
                                    color={0,0,255}));
  connect(pin_pMot, switchingDcDc.pin_pMot) annotation (Line(points={{60,-100},
          {60,-80},{-10,-80},{-10,10}},color={0,0,255}));
  connect(pin_nBat, vDCSensor.n)
    annotation (Line(points={{-60,100},{-10,100}}, color={0,0,255}));
  connect(pin_pBat, vDCSensor.p)
    annotation (Line(points={{60,100},{10,100}}, color={0,0,255}));
  connect(pin_nMot, vMotSensor.n)
    annotation (Line(points={{-60,-100},{-10,-100}}, color={0,0,255}));
  connect(pin_pMot, vMotSensor.p)
    annotation (Line(points={{60,-100},{10,-100}}, color={0,0,255}));
  connect(vMotFilter.u, vMotSensor.v)
    annotation (Line(points={{58,-60},{0,-60},{0,-89}}, color={0,0,127}));
  connect(vDCFilter.u, vDCSensor.v)
    annotation (Line(points={{-58,60},{0,60},{0,89}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-98,20},{98,-20}},
          textColor={0,0,255},
          textString="%name"),
        Text(
          extent={{-40,80},{40,60}},
          textColor={128,128,128},
          textString="Bat"),
        Text(
          extent={{-40,-60},{40,-80}},
          textColor={128,128,128},
          textString="Mot"),
        Line(points={{-20,-20},{-100,-100}}, color={0,0,255}),
        Line(points={{100,100},{20,20}},     color={0,0,255}),
        Rectangle(visible=not useIdealInverter,
          extent={{-98,98},{98,-98}},
          lineColor={217,67,180}),
        Line(visible=not useIdealInverter, points={{-20,-20},{-98,-98}},   color={217,67,180}),
        Line(visible=not useIdealInverter, points={{98,98},{20,20}},       color={217,67,180}),
        Text(
          extent={{-100,70},{-80,50}},
          textColor={128,128,128},
          textString="v"),
        Text(
          extent={{80,-50},{100,-70}},
          textColor={128,128,128},
          textString="v"),
        Text(
          extent={{80,70},{100,50}},
          textColor={128,128,128},
          textString="i"),
        Text(
          extent={{-100,-50},{-80,-70}},
          textColor={128,128,128},
          textString="i")}),    Documentation(info="<html>
<p>This is a model of a DC-DC inverter. The level of detail of the DC-DC inverter may be chosen from ideal averaging or switching.</p>
<p>Reference voltage is limited to actual battery voltage.</p>
<p>Battery voltage and motor current are measured.</p>
</html>"));
end DcdcInverter;
