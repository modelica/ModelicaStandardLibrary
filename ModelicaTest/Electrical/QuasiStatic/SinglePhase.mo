within ModelicaTest.Electrical.QuasiStatic;
package SinglePhase "Single phase quasi static package"
  extends Modelica.Icons.ExamplesPackage;
  model SerialConnection "Example of serial connections"
    extends Modelica.Icons.Example;
    output Modelica.SIunits.ComplexVoltage v = voltageSensor.y "Total voltage";
    Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource currentSource(gamma(fixed=true, start=0))                                                  annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-50,-20})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Impedance impedance(Z_ref(re=1, im=1)) annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Admittance admittance(Y_ref(re=0.5, im=0.5)) annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor variableResistor annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor variableConductor annotation (Placement(transformation(extent={{0,20},{20,40}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor conductor(G_ref=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-90,10})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor variableCapacitor annotation (Placement(transformation(extent={{30,20},{50,40}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor variableInductor annotation (Placement(transformation(extent={{60,20},{80,40}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableImpedance variableImpedance annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={70,-40})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableAdmittance variableAdmittance annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={40,-40})));
    Modelica.Blocks.Sources.Constant const(k=1) annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
    Modelica.Blocks.Sources.Constant const1(k=1) annotation (Placement(transformation(extent={{-20,70},{0,90}})));
    Modelica.Blocks.Sources.Constant const2(k=1/100/Modelica.Constants.pi) annotation (Placement(transformation(extent={{70,70},{50,90}})));
    Modelica.Blocks.Sources.Constant const3(k=1/100/Modelica.Constants.pi) annotation (Placement(transformation(extent={{100,50},{80,70}})));
    Modelica.ComplexBlocks.Sources.ComplexConstant const4(k(re=0.5, im=0.5))   annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
    Modelica.ComplexBlocks.Sources.ComplexConstant const5(k(re=1, im=1)) annotation (Placement(transformation(extent={{-30,-90},{-10,-70}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor voltageSensor annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={-20,-20})));
    Modelica.ComplexBlocks.Sources.ComplexConstant const6(k(re=1, im=0))       annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
    Modelica.Blocks.Sources.Ramp ramp(
      height=80,
      duration=1,
      offset=10,
      startTime=0) annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  equation

    connect(const.y, variableResistor.R_ref) annotation (Line(points={{-29,60},{-20,60},{-20,41}}, color={0,0,127}));
    connect(const1.y, variableConductor.G_ref) annotation (Line(points={{1,80},{6,80},{10,80},{10,41}}, color={0,0,127}));
    connect(const2.y, variableCapacitor.C) annotation (Line(points={{49,80},{40,80},{40,41}}, color={0,0,127}));
    connect(const3.y, variableInductor.L) annotation (Line(points={{79,60},{70,60},{70,40.8}}, color={0,0,127}));
    connect(ground.pin, currentSource.pin_p) annotation (Line(points={{-50,-40},{-50,-35},{-50,-30}}, color={85,170,255}));
    connect(currentSource.pin_n, conductor.pin_p) annotation (Line(points={{-50,-10},{-50,-10},{-50,0},{-90,0}},
                                                                                                    color={85,170,255}));
    connect(conductor.pin_n, impedance.pin_p) annotation (Line(points={{-90,20},{-90,30}}, color={85,170,255}));
    connect(impedance.pin_n, admittance.pin_p) annotation (Line(points={{-70,30},{-65,30},{-60,30}}, color={85,170,255}));
    connect(admittance.pin_n, variableResistor.pin_p) annotation (Line(points={{-40,30},{-35,30},{-30,30}}, color={85,170,255}));
    connect(variableResistor.pin_n, variableConductor.pin_p) annotation (Line(points={{-10,30},{-5,30},{0,30}}, color={85,170,255}));
    connect(variableConductor.pin_n, variableCapacitor.pin_p) annotation (Line(points={{20,30},{25,30},{30,30}}, color={85,170,255}));
    connect(variableCapacitor.pin_n, variableInductor.pin_p) annotation (Line(points={{50,30},{55,30},{60,30}}, color={85,170,255}));
    connect(variableInductor.pin_n, variableImpedance.pin_p) annotation (Line(points={{80,30},{90,30},{90,-40},{80,-40}}, color={85,170,255}));
    connect(variableImpedance.pin_n, variableAdmittance.pin_p) annotation (Line(points={{60,-40},{55,-40},{50,-40}}, color={85,170,255}));
    connect(const4.y, variableAdmittance.Y_ref) annotation (Line(points={{21,-60},{30,-60},{40,-60},{40,-51}}, color={85,170,255}));
    connect(const5.y, variableImpedance.Z_ref) annotation (Line(points={{-9,-80},{28,-80},{70,-80},{70,-51}}, color={85,170,255}));
    connect(variableAdmittance.pin_n, ground.pin) annotation (Line(points={{30,-40},{30,-40},{-50,-40}},  color={85,170,255}));
    connect(voltageSensor.pin_p, conductor.pin_p) annotation (Line(points={{-20,-10},{-20,0},{-90,0}}, color={85,170,255}));
    connect(voltageSensor.pin_n, ground.pin) annotation (Line(points={{-20,-30},{-20,-40},{-50,-40}}, color={85,170,255}));
    connect(const6.y, currentSource.I) annotation (Line(points={{-79,-50},{-70,-50},{-70,-24},{-60,-24}}, color={85,170,255}));
    connect(ramp.y, currentSource.f) annotation (Line(points={{-79,-20},{-74,-20},{-70,-20},{-70,-16},{-60,-16}}, color={0,0,127}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
      experiment(StopTime=1),
      Documentation(info="<html>
<p>Serial connection of different single phase basic components</p>
</html>"));
  end SerialConnection;

  model Ideal "Ideal components"
    extends Modelica.Icons.Example;
    output Modelica.SIunits.ComplexCurrent I = currentSensor.y "Current";
    Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.Idle idle annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-50,10})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.Short short annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.IdealCommutingSwitch idealCommutingSwitch annotation (Placement(transformation(extent={{30,20},{50,40}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.IdealIntermediateSwitch idealIntermediateSwitch annotation (Placement(transformation(extent={{60,20},{80,40}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.IdealOpeningSwitch idealOpeningSwitch annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.IdealClosingSwitch idealClosingSwitch annotation (Placement(transformation(extent={{-10,20},{10,40}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Impedance impedance(
      alpha_ref=0.004,
      useHeatPort=true,
      Z_ref(re=2, im=2),
      T_ref=293.15)     annotation (Placement(transformation(extent={{80,-10},{60,10}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource voltageSource(
      gamma(start=0, fixed=true),
      f=50,
      phi=0,
      V=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-90,10})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Admittance admittance(
      Y_ref(re=0.5, im=0.5),
      useHeatPort=true,
      T_ref=293.15,
      alpha_ref=0.004)  annotation (Placement(transformation(extent={{80,-30},{60,-10}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
    Modelica.Blocks.Sources.BooleanStep booleanStep1(startTime=0.2) annotation (Placement(transformation(extent={{-32,70},{-12,90}})));
    Modelica.Blocks.Sources.BooleanStep booleanStep2(startTime=0.4) annotation (Placement(transformation(extent={{70,70},{50,90}})));
    Modelica.Blocks.Sources.BooleanStep booleanStep3(startTime=0.6) annotation (Placement(transformation(extent={{100,50},{80,70}})));
    Modelica.Blocks.Sources.BooleanStep booleanStep4(startTime=0.8) annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
    Modelica.Blocks.Sources.Ramp ramp(
      height=100,
      duration=1,
      offset=293.15,
      startTime=0) annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableImpedance variableImpedance(
      useHeatPort=true,
      T_ref=293.15,
      alpha_ref=0.004) annotation (Placement(transformation(extent={{30,10},{10,-10}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableAdmittance variableAdmittance(
      useHeatPort=true,
      T_ref=293.15,
      alpha_ref=0.004) annotation (Placement(transformation(extent={{10,-10},{-10,-30}})));
    Modelica.ComplexBlocks.Sources.ComplexConstant const_admittance(k(re=0.5, im=0.5)) annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
    Modelica.ComplexBlocks.Sources.ComplexConstant const_impedance(k(re=2, im=2)) annotation (Placement(transformation(extent={{-30,-70},{-10,-50}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor currentSensor annotation (Placement(transformation(extent={{-60,-30},{-80,-10}})));
  equation

    connect(voltageSource.pin_p, short.pin_p) annotation (Line(points={{-90,20},{-90,20},{-90,30},{-80,30}},     color={85,170,255}));
    connect(short.pin_n, idle.pin_p) annotation (Line(points={{-60,30},{-50,30},{-50,20}},    color={85,170,255}));
    connect(idealCommutingSwitch.n1, idealIntermediateSwitch.p1) annotation (Line(points={{50,35},{54,35},{60,35}}, color={85,170,255}));
    connect(idealCommutingSwitch.n2, idealIntermediateSwitch.p2) annotation (Line(points={{50,30},{55,30},{60,30}},    color={85,170,255}));
    connect(short.pin_n, idealOpeningSwitch.pin_p) annotation (Line(points={{-60,30},{-50,30},{-40,30}},    color={85,170,255}));
    connect(idealClosingSwitch.pin_n, idealCommutingSwitch.p) annotation (Line(points={{10,30},{20,30},{30,30}},    color={85,170,255}));
    connect(idealIntermediateSwitch.n2, impedance.pin_p) annotation (Line(points={{80,30},{84,30},{90,30},{90,0},{80,0}},        color={85,170,255}));
    connect(idealIntermediateSwitch.n1, admittance.pin_p) annotation (Line(points={{80,35},{100,35},{100,34},{100,-22},{100,-20},{80,-20}}, color={85,170,255}));
    connect(ground.pin, voltageSource.pin_n) annotation (Line(points={{-90,-40},{-90,0}},   color={85,170,255}));
    connect(booleanStep2.y, idealCommutingSwitch.control) annotation (Line(points={{49,80},{49,80},{40,80},{40,38}}, color={255,0,255}));
    connect(booleanStep3.y, idealIntermediateSwitch.control) annotation (Line(points={{79,60},{70,60},{70,38}}, color={255,0,255}));
    connect(prescribedTemperature.port, admittance.heatPort) annotation (Line(points={{20,-90},{50,-90},{50,-30},{70,-30}}, color={191,0,0}));
    connect(prescribedTemperature.port, impedance.heatPort) annotation (Line(points={{20,-90},{50,-90},{50,-10},{70,-10}}, color={191,0,0}));
    connect(ramp.y, prescribedTemperature.T) annotation (Line(points={{-19,-90},{-10.5,-90},{-2,-90}}, color={0,0,127}));
    connect(variableAdmittance.pin_p, admittance.pin_n) annotation (Line(points={{10,-20},{36,-20},{60,-20}}, color={85,170,255}));
    connect(impedance.pin_n, variableImpedance.pin_p) annotation (Line(points={{60,0},{46,0},{30,0}}, color={85,170,255}));
    connect(variableImpedance.pin_n, variableAdmittance.pin_n) annotation (Line(points={{10,0},{-30,0},{-30,-20},{-10,-20}}, color={85,170,255}));
    connect(const_admittance.y, variableAdmittance.Y_ref) annotation (Line(points={{-39,-40},{-22,-40},{0,-40},{0,-31}}, color={85,170,255}));
    connect(const_impedance.y, variableImpedance.Z_ref) annotation (Line(points={{-9,-60},{4,-60},{20,-60},{20,-11}}, color={85,170,255}));
    connect(variableAdmittance.heatPort, variableImpedance.heatPort) annotation (Line(points={{0,-10},{0,-10},{0,6},{0,10},{20,10}}, color={191,0,0}));
    connect(variableImpedance.heatPort, prescribedTemperature.port) annotation (Line(points={{20,10},{34,10},{50,10},{50,-90},{20,-90}}, color={191,0,0}));
    connect(booleanStep1.y, idealClosingSwitch.control) annotation (Line(points={{-11,80},{0,80},{0,37}}, color={255,0,255}));
    connect(booleanStep4.y, idealOpeningSwitch.control) annotation (Line(points={{-39,60},{-30,60},{-30,37}}, color={255,0,255}));
    connect(idealOpeningSwitch.pin_n, idealClosingSwitch.pin_p) annotation (Line(points={{-20,30},{-15,30},{-10,30}}, color={85,170,255}));
    connect(idle.pin_n, variableAdmittance.pin_n) annotation (Line(points={{-50,0},{-50,0},{-50,-20},{-10,-20}}, color={85,170,255}));
    connect(currentSensor.pin_p, variableAdmittance.pin_n) annotation (Line(points={{-60,-20},{-35,-20},{-10,-20}}, color={85,170,255}));
    connect(currentSensor.pin_n, voltageSource.pin_n) annotation (Line(points={{-80,-20},{-90,-20},{-90,0}}, color={85,170,255}));
    annotation (experiment(StopTime=1),Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
      Documentation(info="<html>
<p>Serial connection of different single phase ideal components and temperature dependent basic components</p>
</html>"));
  end Ideal;
end SinglePhase;
