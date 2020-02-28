within Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities;
model SwitchingDcDc "Switching DC-DC inverter"
  parameter SI.Frequency fS "Switching frequency";
  parameter SI.Voltage VMax "Maximum Voltage";
  parameter SI.Resistance RonT=1e-05
    "Transistor closed resistance";
  parameter SI.Conductance GoffT=1e-05
    "Transistor opened conductance";
  parameter SI.Voltage VkneeT=0
    "Transistor threshold voltage";
  parameter SI.Resistance RonD=1e-05
    "Diode closed resistance";
  parameter SI.Conductance GoffD=1e-05
    "Diode opened conductance";
  parameter SI.Voltage VkneeD=0 "Diode threshold voltage";
  Modelica.Electrical.PowerConverters.DCDC.Control.Voltage2DutyCycle
    adaptor(useConstantVoltageLimit=false, VLim=VMax)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM pwm(
      useConstantDutyCycle=false, f=fS) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,-20})));
  Modelica.Electrical.PowerConverters.DCDC.HBridge dcdc(
    RonTransistor=RonT,
    GoffTransistor=GoffT,
    VkneeTransistor=VkneeT,
    RonDiode=RonD,
    GoffDiode=GoffD,
    VkneeDiode=VkneeD)                                  annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-20})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_nBat annotation (
      Placement(transformation(extent={{-110,110},{-90,90}}),
        iconTransformation(extent={{-110,110},{-90,90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_pBat
    annotation (Placement(transformation(extent={{90,110},{110,90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_pMot
    annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_nMot
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
  Modelica.Blocks.Interfaces.RealInput vRef
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput vMax
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
equation
  connect(adaptor.dutyCycle, pwm.dutyCycle)
    annotation (Line(points={{-39,0},{-30,0},{-30,-8}},
                                                   color={0,0,127}));
  connect(pwm.fire, dcdc.fire_p)
    annotation (Line(points={{-19,-14},{-12,-14}},
                                                 color={255,0,255}));
  connect(pwm.notFire, dcdc.fire_n)
    annotation (Line(points={{-19,-26},{-12,-26}},
                                                 color={255,0,255}));
  connect(pin_nBat, dcdc.dc_n1) annotation (Line(points={{-100,100},{-100,70},{-6,
          70},{-6,-10}},                       color={0,0,255}));
  connect(pin_pBat, dcdc.dc_p1) annotation (Line(points={{100,100},{100,70},{6,70},
          {6,-10}},              color={0,0,255}));
  connect(dcdc.dc_p2, pin_pMot) annotation (Line(points={{6,-30},{6,-70},
          {100,-70},{100,-100}},    color={0,0,255}));
  connect(pin_nMot, dcdc.dc_n2) annotation (Line(points={{-100,-100},{
          -100,-68},{-6,-68},{-6,-30}},
                          color={0,0,255}));
  connect(vRef, adaptor.v)
    annotation (Line(points={{-120,0},{-62,0}}, color={0,0,127}));
  connect(vMax, adaptor.vLim) annotation (Line(points={{-120,60},{-50,
          60},{-50,12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-98,98},{98,-98}},
          lineColor={217,67,180},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{98,98},{20,20}},       color={217,67,180}),
        Line(points={{-20,-20},{-98,-98}},   color={217,67,180}),
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
<p>This is a model of a switching DC-DC inverter based on a H-bridge.</p>
</html>"));
end SwitchingDcDc;
