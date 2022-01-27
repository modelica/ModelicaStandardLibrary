within ModelicaTest.Electrical.QuasiStatic;
package SinglePhase "Single-phase quasi-static package"
  extends Modelica.Icons.ExamplesPackage;
  model SerialConnection "Example of serial connections"
    extends Modelica.Icons.Example;
    output SI.ComplexVoltage v = voltageSensor.v "Total voltage";
    Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VariableCurrentSource currentSource(gamma(fixed=true, start=0))                                                  annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-50,-20})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground ground annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Impedance impedance(Z_ref(re=1, im=1)) annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Admittance admittance(Y_ref(re=0.5, im=0.5)) annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableResistor variableResistor annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableConductor variableConductor annotation (Placement(transformation(extent={{0,20},{20,40}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Conductor conductor(G_ref=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-90,10})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableCapacitor variableCapacitor annotation (Placement(transformation(extent={{30,20},{50,40}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableInductor variableInductor annotation (Placement(transformation(extent={{60,20},{80,40}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableImpedance variableImpedance annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={70,-40})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableAdmittance variableAdmittance annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={40,-40})));
    Modelica.Blocks.Sources.Constant const(k=1) annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
    Modelica.Blocks.Sources.Constant const1(k=1) annotation (Placement(transformation(extent={{-20,70},{0,90}})));
    Modelica.Blocks.Sources.Constant const2(k=1/100/Modelica.Constants.pi) annotation (Placement(transformation(extent={{70,70},{50,90}})));
    Modelica.Blocks.Sources.Constant const3(k=1/100/Modelica.Constants.pi) annotation (Placement(transformation(extent={{100,50},{80,70}})));
    Modelica.ComplexBlocks.Sources.ComplexConstant const4(k(re=0.5, im=0.5))   annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
    Modelica.ComplexBlocks.Sources.ComplexConstant const5(k(re=1, im=1)) annotation (Placement(transformation(extent={{-30,-90},{-10,-70}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageSensor voltageSensor annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={-20,-20})));
    Modelica.ComplexBlocks.Sources.ComplexConstant const6(k(re=1, im=0))       annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
    Modelica.Blocks.Sources.Ramp ramp(
      height=80,
      duration=1,
      offset=10,
      startTime=0) annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageRMSSensor
      voltageRMSSensor annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={10,-20})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentRMSSensor
      currentRMSSensor annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={90,0})));
  equation

    connect(const.y, variableResistor.R_ref) annotation (Line(points={{-29,60},{-20,60},{-20,42}}, color={0,0,127}));
    connect(const1.y, variableConductor.G_ref) annotation (Line(points={{1,80},{6,80},{10,80},{10,42}}, color={0,0,127}));
    connect(const2.y, variableCapacitor.C) annotation (Line(points={{49,80},{40,80},{40,42}}, color={0,0,127}));
    connect(const3.y, variableInductor.L) annotation (Line(points={{79,60},{70,60},{70,42}},   color={0,0,127}));
    connect(ground.pin, currentSource.pin_p) annotation (Line(points={{-50,-40},{-50,-35},{-50,-30}}, color={85,170,255}));
    connect(currentSource.pin_n, conductor.pin_p) annotation (Line(points={{-50,-10},{-50,-10},{-50,0},{-90,0}}, color={85,170,255}));
    connect(conductor.pin_n, impedance.pin_p) annotation (Line(points={{-90,20},{-90,30}}, color={85,170,255}));
    connect(impedance.pin_n, admittance.pin_p) annotation (Line(points={{-70,30},{-65,30},{-60,30}}, color={85,170,255}));
    connect(admittance.pin_n, variableResistor.pin_p) annotation (Line(points={{-40,30},{-35,30},{-30,30}}, color={85,170,255}));
    connect(variableResistor.pin_n, variableConductor.pin_p) annotation (Line(points={{-10,30},{-5,30},{0,30}}, color={85,170,255}));
    connect(variableConductor.pin_n, variableCapacitor.pin_p) annotation (Line(points={{20,30},{25,30},{30,30}}, color={85,170,255}));
    connect(variableCapacitor.pin_n, variableInductor.pin_p) annotation (Line(points={{50,30},{55,30},{60,30}}, color={85,170,255}));
    connect(variableImpedance.pin_n, variableAdmittance.pin_p) annotation (Line(points={{60,-40},{55,-40},{50,-40}}, color={85,170,255}));
    connect(const4.y, variableAdmittance.Y_ref) annotation (Line(points={{21,-60},{30,-60},{40,-60},{40,-52}}, color={85,170,255}));
    connect(const5.y, variableImpedance.Z_ref) annotation (Line(points={{-9,-80},{28,-80},{70,-80},{70,-52}}, color={85,170,255}));
    connect(variableAdmittance.pin_n, ground.pin) annotation (Line(points={{30,-40},{30,-40},{-50,-40}}, color={85,170,255}));
    connect(voltageSensor.pin_p, conductor.pin_p) annotation (Line(points={{-20,-10},{-20,0},{-90,0}}, color={85,170,255}));
    connect(voltageSensor.pin_n, ground.pin) annotation (Line(points={{-20,-30},{-20,-40},{-50,-40}}, color={85,170,255}));
    connect(const6.y, currentSource.I) annotation (Line(points={{-79,-50},{-70,-50},{-70,-26},{-62,-26}}, color={85,170,255}));
    connect(ramp.y, currentSource.f) annotation (Line(points={{-79,-20},{-74,-20},{-70,-20},{-70,-14},{-62,-14}}, color={0,0,127}));
    connect(voltageRMSSensor.pin_p, conductor.pin_p) annotation (Line(points={{10,-10},{10,0},{-90,0}}, color={85,170,255}));
    connect(voltageRMSSensor.pin_n, ground.pin) annotation (Line(points={{10,-30},{10,-40},{-50,-40}}, color={85,170,255}));
    connect(variableInductor.pin_n, currentRMSSensor.pin_p) annotation (Line(points={{80,30},{90,30},{90,10}}, color={85,170,255}));
    connect(currentRMSSensor.pin_n, variableImpedance.pin_p) annotation (Line(points={{90,-10},{90,-40},{80,-40}}, color={85,170,255}));
    annotation (experiment(StopTime=1),
      Documentation(info="<html>
<p>Serial connection of different single-phase basic components</p>
</html>"));
  end SerialConnection;

  model Ideal "Ideal components"
    extends Modelica.Icons.Example;
    output SI.ComplexCurrent I = currentSensor.i "Current";
    Modelica.Electrical.QuasiStatic.SinglePhase.Ideal.Idle idle annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-50,10})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Ideal.Short short annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Ideal.IdealCommutingSwitch idealCommutingSwitch annotation (Placement(transformation(extent={{30,20},{50,40}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Ideal.IdealIntermediateSwitch idealIntermediateSwitch annotation (Placement(transformation(extent={{60,20},{80,40}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Ideal.IdealOpeningSwitch idealOpeningSwitch annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Ideal.IdealClosingSwitch idealClosingSwitch annotation (Placement(transformation(extent={{-10,20},{10,40}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Impedance impedance(
      alpha_ref=0.004,
      useHeatPort=true,
      Z_ref(re=2, im=2),
      T_ref=293.15)     annotation (Placement(transformation(extent={{80,-10},{60,10}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource voltageSource(
      gamma(start=0, fixed=true),
      f=50,
      phi=0,
      V=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-90,10})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Admittance admittance(
      Y_ref(re=0.5, im=0.5),
      useHeatPort=true,
      T_ref=293.15,
      alpha_ref=0.004)  annotation (Placement(transformation(extent={{80,-30},{60,-10}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground ground annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
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
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableImpedance variableImpedance(
      useHeatPort=true,
      T_ref=293.15,
      alpha_ref=0.004) annotation (Placement(transformation(extent={{30,10},{10,-10}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableAdmittance variableAdmittance(
      useHeatPort=true,
      T_ref=293.15,
      alpha_ref=0.004) annotation (Placement(transformation(extent={{10,-10},{-10,-30}})));
    Modelica.ComplexBlocks.Sources.ComplexConstant const_admittance(k(re=0.5, im=0.5)) annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
    Modelica.ComplexBlocks.Sources.ComplexConstant const_impedance(k(re=2, im=2)) annotation (Placement(transformation(extent={{-30,-70},{-10,-50}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentSensor currentSensor annotation (Placement(transformation(extent={{-60,-30},{-80,-10}})));
  equation

    connect(voltageSource.pin_p, short.pin_p) annotation (Line(points={{-90,20},{-90,20},{-90,30},{-80,30}}, color={85,170,255}));
    connect(short.pin_n, idle.pin_p) annotation (Line(points={{-60,30},{-50,30},{-50,20}}, color={85,170,255}));
    connect(idealCommutingSwitch.n1, idealIntermediateSwitch.p1) annotation (Line(points={{50,34},{54,34},{60,34}}, color={85,170,255}));
    connect(idealCommutingSwitch.n2, idealIntermediateSwitch.p2) annotation (Line(points={{50,30},{55,30},{60,30}}, color={85,170,255}));
    connect(short.pin_n, idealOpeningSwitch.pin_p) annotation (Line(points={{-60,30},{-50,30},{-40,30}}, color={85,170,255}));
    connect(idealClosingSwitch.pin_n, idealCommutingSwitch.p) annotation (Line(points={{10,30},{20,30},{30,30}}, color={85,170,255}));
    connect(idealIntermediateSwitch.n2, impedance.pin_p) annotation (Line(points={{80,30},{84,30},{90,30},{90,0},{80,0}}, color={85,170,255}));
    connect(idealIntermediateSwitch.n1, admittance.pin_p) annotation (Line(points={{80,34},{100,34},{100,34},{100,-22},{100,-20},{80,-20}}, color={85,170,255}));
    connect(ground.pin, voltageSource.pin_n) annotation (Line(points={{-90,-40},{-90,0}}, color={85,170,255}));
    connect(booleanStep2.y, idealCommutingSwitch.control) annotation (Line(points={{49,80},{49,80},{40,80},{40,42}}, color={255,0,255}));
    connect(booleanStep3.y, idealIntermediateSwitch.control) annotation (Line(points={{79,60},{70,60},{70,42}}, color={255,0,255}));
    connect(prescribedTemperature.port, admittance.heatPort) annotation (Line(points={{20,-90},{50,-90},{50,-30},{70,-30}}, color={191,0,0}));
    connect(prescribedTemperature.port, impedance.heatPort) annotation (Line(points={{20,-90},{50,-90},{50,-10},{70,-10}}, color={191,0,0}));
    connect(ramp.y, prescribedTemperature.T) annotation (Line(points={{-19,-90},{-10.5,-90},{-2,-90}}, color={0,0,127}));
    connect(variableAdmittance.pin_p, admittance.pin_n) annotation (Line(points={{10,-20},{36,-20},{60,-20}}, color={85,170,255}));
    connect(impedance.pin_n, variableImpedance.pin_p) annotation (Line(points={{60,0},{46,0},{30,0}}, color={85,170,255}));
    connect(variableImpedance.pin_n, variableAdmittance.pin_n) annotation (Line(points={{10,0},{-30,0},{-30,-20},{-10,-20}}, color={85,170,255}));
    connect(const_admittance.y, variableAdmittance.Y_ref) annotation (Line(points={{-39,-40},{-22,-40},{0,-40},{0,-32}}, color={85,170,255}));
    connect(const_impedance.y, variableImpedance.Z_ref) annotation (Line(points={{-9,-60},{4,-60},{20,-60},{20,-12}}, color={85,170,255}));
    connect(variableAdmittance.heatPort, variableImpedance.heatPort) annotation (Line(points={{0,-10},{0,-10},{0,6},{0,10},{20,10}}, color={191,0,0}));
    connect(variableImpedance.heatPort, prescribedTemperature.port) annotation (Line(points={{20,10},{34,10},{50,10},{50,-90},{20,-90}}, color={191,0,0}));
    connect(booleanStep1.y, idealClosingSwitch.control) annotation (Line(points={{-11,80},{0,80},{0,42}}, color={255,0,255}));
    connect(booleanStep4.y, idealOpeningSwitch.control) annotation (Line(points={{-39,60},{-30,60},{-30,42}}, color={255,0,255}));
    connect(idealOpeningSwitch.pin_n, idealClosingSwitch.pin_p) annotation (Line(points={{-20,30},{-15,30},{-10,30}}, color={85,170,255}));
    connect(idle.pin_n, variableAdmittance.pin_n) annotation (Line(points={{-50,0},{-50,0},{-50,-20},{-10,-20}}, color={85,170,255}));
    connect(currentSensor.pin_p, variableAdmittance.pin_n) annotation (Line(points={{-60,-20},{-35,-20},{-10,-20}}, color={85,170,255}));
    connect(currentSensor.pin_n, voltageSource.pin_n) annotation (Line(points={{-80,-20},{-90,-20},{-90,0}}, color={85,170,255}));
    annotation (experiment(StopTime=1),      Documentation(info="<html>
<p>Serial connection of different single-phase ideal components and temperature dependent basic components</p>
</html>"));
  end Ideal;

  model FrequencySweep "Tests voltage and current frequency sweep sources"
    extends Modelica.Icons.Example;
    output SI.Current iL = inductor.abs_i "Inductor current";
    output SI.Voltage vC = capacitor.abs_v "Inductor voltage";
    output SI.Current iLL = impedanceL.abs_i "Inductor current";
    output SI.Voltage vCC = impedanceC.abs_v "Inductor voltage";

    Modelica.Electrical.QuasiStatic.SinglePhase.Sources.FrequencySweepVoltageSource voltageSource(
      gamma(start=0, fixed=true),
      duration=1,
      V=1,
      fStart=100,
      fStop=0.01)
           annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-60,40})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Inductor inductor(L=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,40})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundV annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Sources.FrequencySweepCurrentSource currentSource(
      gamma(start=0, fixed=true),
      startTime=0,
      duration=1,
      I=1,
      fStart=0.01,
      fStop=100) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-60,-40})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Capacitor capacitor(C=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,-40})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundI annotation (Placement(transformation(extent={{-90,-80},{-70,-60}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource               constantSource(
      gamma(start=0, fixed=true),
      V=1,
      f=1,
      phi=0)
           annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={20,40})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableImpedance impedanceL annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={50,40})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundV1    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
    Modelica.ComplexBlocks.Sources.ComplexRampPhasor complexRampL(
      magnitude1=100,
      magnitude2=0.01,
      useLogRamp=true,
      startTime=0,
      duration=1,
      phi=1.5707963267949) annotation (Placement(transformation(extent={{92,30},{72,50}})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Sources.CurrentSource               currentCurrent(
      gamma(start=0, fixed=true),
      I=1,
      f=1,
      phi=0)    annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,-40})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableImpedance
                                                                    impedanceC     annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={50,-40})));
    Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundI1    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
    Modelica.ComplexBlocks.Sources.ComplexRampPhasor complexRampC(
      useLogRamp=true,
      startTime=0,
      duration=1,
      magnitude1=0.01,
      magnitude2=100,
      phi=-1.5707963267949) annotation (Placement(transformation(extent={{90,-50},{70,-30}})));
  equation
    connect(groundV.pin, voltageSource.pin_n) annotation (Line(points={{-80,20},{-60,20},{-60,30}}, color={85,170,255}));
    connect(voltageSource.pin_n, inductor.pin_n) annotation (Line(points={{-60,30},{-60,20},{-30,20},{-30,30}}, color={85,170,255}));
    connect(inductor.pin_p, voltageSource.pin_p) annotation (Line(points={{-30,50},{-30,60},{-60,60},{-60,50}}, color={85,170,255}));
    connect(currentSource.pin_n, capacitor.pin_p) annotation (Line(points={{-60,-30},{-60,-20},{-30,-20},{-30,-30}}, color={85,170,255}));
    connect(currentSource.pin_p, capacitor.pin_n) annotation (Line(points={{-60,-50},{-60,-60},{-30,-60},{-30,-50}}, color={85,170,255}));
    connect(groundI.pin, currentSource.pin_p) annotation (Line(points={{-80,-60},{-60,-60},{-60,-50}}, color={85,170,255}));
    connect(groundV1.pin, constantSource.pin_n) annotation (Line(points={{0,20},{20,20},{20,30}}, color={85,170,255}));
    connect(constantSource.pin_n, impedanceL.pin_n) annotation (Line(points={{20,30},{20,20},{50,20},{50,30}}, color={85,170,255}));
    connect(impedanceL.pin_p, constantSource.pin_p) annotation (Line(points={{50,50},{50,60},{20,60},{20,50}}, color={85,170,255}));
    connect(complexRampL.y, impedanceL.Z_ref) annotation (Line(points={{71,40},{62,40},{62,40}}, color={85,170,255}));
    connect(currentCurrent.pin_n, impedanceC.pin_p) annotation (Line(points={{20,-30},{20,-20},{50,-20},{50,-30}}, color={85,170,255}));
    connect(currentCurrent.pin_p, impedanceC.pin_n) annotation (Line(points={{20,-50},{20,-60},{50,-60},{50,-50}}, color={85,170,255}));
    connect(groundI1.pin, currentCurrent.pin_p) annotation (Line(points={{0,-60},{20,-60},{20,-50}}, color={85,170,255}));
    connect(complexRampC.y, impedanceC.Z_ref) annotation (Line(points={{69,-40},{62,-40}}, color={85,170,255}));
  end FrequencySweep;
end SinglePhase;
