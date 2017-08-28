within ModelicaTest.Electrical.QuasiStatic;
package MultiPhase "Multi-phase quasi static package"
  extends Modelica.Icons.ExamplesPackage;
  model SerialConnection "Example of serial connections"
    extends Modelica.Icons.Example;
    parameter Integer m = 3 "Number of phases";
    output Modelica.SIunits.ComplexVoltage v[m] = voltageSensor.y "Total voltage";
    Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableCurrentSource currentSource(gamma(fixed=true, start=0), m=m) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-50,-20})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Impedance impedance(Z_ref=fill(Complex(1,1),m), m=m)
                                                                             annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Admittance admittance(Y_ref=fill(Complex(0.5,0.5),m), m=m)
                                                                                                    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableResistor variableResistor(m=m)
                                                                                           annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor variableConductor(m=m)
                                                                                             annotation (Placement(transformation(extent={{0,20},{20,40}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor conductor(G_ref=fill(1,m), m=m)
                                                                                              annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-90,10})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor variableCapacitor(m=m)
                                                                                             annotation (Placement(transformation(extent={{30,20},{50,40}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor variableInductor(m=m)
                                                                                           annotation (Placement(transformation(extent={{60,20},{80,40}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableImpedance variableImpedance(m=m)
                                                                                             annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={70,-40})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableAdmittance variableAdmittance(m=m)
                                                                                               annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={40,-40})));
    Modelica.Blocks.Sources.Constant const[m](k=fill(1,m)) annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
    Modelica.Blocks.Sources.Constant const1[m](k=fill(1,m)) annotation (Placement(transformation(extent={{-20,70},{0,90}})));
    Modelica.Blocks.Sources.Constant const2[m](k=fill(1/100/Modelica.Constants.pi,m)) annotation (Placement(transformation(extent={{70,70},{50,90}})));
    Modelica.Blocks.Sources.Constant const3[m](k=fill(1/100/Modelica.Constants.pi,m)) annotation (Placement(transformation(extent={{100,50},{80,70}})));
    Modelica.ComplexBlocks.Sources.ComplexConstant const4[m](k=fill(Complex(0.5,0.5),m)) annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
    Modelica.ComplexBlocks.Sources.ComplexConstant const5[m](k=fill(Complex(1,1),m)) annotation (Placement(transformation(extent={{-30,-90},{-10,-70}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageSensor voltageSensor(m=m) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={-20,-20})));
    Modelica.ComplexBlocks.Sources.ComplexConstant const6[m](k=Modelica.ComplexMath.fromPolar(fill(1, m), -Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m)))
                                                                                     annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
    Modelica.Blocks.Sources.Ramp ramp(
      height=80,
      duration=1,
      offset=10,
      startTime=0) annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star(m=m)
                                                                   annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-50,-60})));
  equation

    connect(const.y, variableResistor.R_ref) annotation (Line(points={{-29,60},{-20,60},{-20,41}}, color={0,0,127}));
    connect(const1.y, variableConductor.G_ref) annotation (Line(points={{1,80},{6,80},{10,80},{10,41}}, color={0,0,127}));
    connect(const2.y, variableCapacitor.C) annotation (Line(points={{49,80},{40,80},{40,41}}, color={0,0,127}));
    connect(const3.y, variableInductor.L) annotation (Line(points={{79,60},{70,60},{70,41}}, color={0,0,127}));
    connect(currentSource.plug_n, conductor.plug_p) annotation (Line(points={{-50,-10},{-50,-10},{-50,0},{-90,0}}, color={85,170,255}));
    connect(conductor.plug_n, impedance.plug_p) annotation (Line(points={{-90,20},{-90,30}}, color={85,170,255}));
    connect(impedance.plug_n, admittance.plug_p) annotation (Line(points={{-70,30},{-60,30}}, color={85,170,255}));
    connect(admittance.plug_n, variableResistor.plug_p) annotation (Line(points={{-40,30},{-40,30},{-30,30}}, color={85,170,255}));
    connect(variableResistor.plug_n, variableConductor.plug_p) annotation (Line(points={{-10,30},{-5,30},{0,30}}, color={85,170,255}));
    connect(variableConductor.plug_n, variableCapacitor.plug_p) annotation (Line(points={{20,30},{25,30},{30,30}}, color={85,170,255}));
    connect(variableCapacitor.plug_n, variableInductor.plug_p) annotation (Line(points={{50,30},{55,30},{60,30}}, color={85,170,255}));
    connect(variableInductor.plug_n, variableImpedance.plug_p) annotation (Line(points={{80,30},{90,30},{90,-40},{80,-40}}, color={85,170,255}));
    connect(variableImpedance.plug_n, variableAdmittance.plug_p) annotation (Line(points={{60,-40},{55,-40},{50,-40}}, color={85,170,255}));
    connect(const4.y, variableAdmittance.Y_ref) annotation (Line(points={{21,-60},{30,-60},{40,-60},{40,-51}}, color={85,170,255}));
    connect(const5.y, variableImpedance.Z_ref) annotation (Line(points={{-9,-80},{28,-80},{70,-80},{70,-51}}, color={85,170,255}));
    connect(voltageSensor.plug_p, conductor.plug_p) annotation (Line(points={{-20,-10},{-20,0},{-90,0}}, color={85,170,255}));
    connect(const6.y, currentSource.I) annotation (Line(points={{-79,-50},{-70,-50},{-70,-24},{-60,-24}}, color={85,170,255}));
    connect(ramp.y, currentSource.f) annotation (Line(points={{-79,-20},{-74,-20},{-70,-20},{-70,-16},{-60,-16}}, color={0,0,127}));
    connect(currentSource.plug_p, variableAdmittance.plug_n) annotation (Line(points={{-50,-30},{-50,-40},{30,-40}}, color={85,170,255}));
    connect(variableAdmittance.plug_n, voltageSensor.plug_n) annotation (Line(points={{30,-40},{8,-40},{-20,-40},{-20,-36},{-20,-30}}, color={85,170,255}));
    connect(star.plug_p, currentSource.plug_p) annotation (Line(points={{-50,-50},{-50,-50},{-50,-30}}, color={85,170,255}));
    connect(star.pin_n, ground.pin) annotation (Line(points={{-50,-70},{-50,-70},{-50,-80}}, color={85,170,255}));
    annotation (      experiment(StopTime=1),
      Documentation(info="<html>
<p>Serial connection of different multi-phase basic components</p>
</html>"));
  end SerialConnection;

  model Ideal "Ideal components"
    extends Modelica.Icons.Example;
    parameter Integer m = 3 "Number of phases";
    output Modelica.SIunits.ComplexCurrent I[m] = currentSensor.y "Current";
    Modelica.Electrical.QuasiStationary.MultiPhase.Ideal.Idle idle(m=m)
                                                                   annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-50,10})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Ideal.Short short(m=m)
                                                                     annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Ideal.IdealCommutingSwitch idealCommutingSwitch(m=m,
      Ron=fill(1E-5, m),
      Goff=fill(1E-5, m))                                                                          annotation (Placement(transformation(extent={{30,20},{50,40}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Ideal.IdealIntermediateSwitch idealIntermediateSwitch(m=m,
      Ron=fill(1E-5, m),
      Goff=fill(1E-5, m))                                                                             annotation (Placement(transformation(extent={{60,20},{80,40}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Ideal.IdealOpeningSwitch idealOpeningSwitch(m=m,
      Ron=fill(1E-5, m),
      Goff=fill(1E-5, m))                                                                      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Ideal.IdealClosingSwitch idealClosingSwitch(m=m,
      Ron=fill(1E-5, m),
      Goff=fill(1E-5, m))                                                                      annotation (Placement(transformation(extent={{-10,20},{10,40}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Impedance impedance(
      useHeatPort=true,
      m=m,
      T_ref=fill(293.15, m),
      alpha_ref=fill(0.004, m),
      Z_ref=fill(Complex(2, 2), m))
                        annotation (Placement(transformation(extent={{80,-10},{60,10}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource voltageSource(
      gamma(start=0, fixed=true),
      f=50,
      m=m,
      V=fill(1, m),
      phi=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m))
           annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-90,10})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Admittance admittance(
      useHeatPort=true,
      m=m,
      T_ref=fill(293.15, m),
      alpha_ref=fill(0.004, m),
      Y_ref=fill(Complex(0.5, 0.5), m))
                        annotation (Placement(transformation(extent={{80,-30},{60,-10}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
    Modelica.Blocks.Sources.BooleanStep booleanStep1[m](startTime=fill(0.2, m)) annotation (Placement(transformation(extent={{-32,70},{-12,90}})));
    Modelica.Blocks.Sources.BooleanStep booleanStep2[m](startTime=fill(0.4, m)) annotation (Placement(transformation(extent={{70,70},{50,90}})));
    Modelica.Blocks.Sources.BooleanStep booleanStep3[m](startTime=fill(0.6, m)) annotation (Placement(transformation(extent={{100,50},{80,70}})));
    Modelica.Blocks.Sources.BooleanStep booleanStep4[m](startTime=fill(0.8, m)) annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature[m] annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
    Modelica.Blocks.Sources.Ramp ramp[m](
      height=fill(100, m),
      duration=fill(1, m),
      offset=fill(293.15, m),
      startTime=fill(0, m)) annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableImpedance variableImpedance(
      useHeatPort=true,
      m=m,
      T_ref=fill(293.15, m),
      alpha_ref=fill(0.004, m))
                       annotation (Placement(transformation(extent={{30,10},{10,-10}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableAdmittance variableAdmittance(
      useHeatPort=true,
      m=m,
      T_ref=fill(293.15, m),
      alpha_ref=fill(0.004, m))
                       annotation (Placement(transformation(extent={{10,-10},{-10,-30}})));
    Modelica.ComplexBlocks.Sources.ComplexConstant const_admittance[m](k=fill(Complex(0.5, 0.5), m)) annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
    Modelica.ComplexBlocks.Sources.ComplexConstant const_impedance[m](k=fill(Complex(2, 2), m)) annotation (Placement(transformation(extent={{-30,-70},{-10,-50}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor currentSensor annotation (Placement(transformation(extent={{-60,-30},{-80,-10}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star(m=m)
                                                                   annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-90,-40})));
  equation

    connect(voltageSource.plug_p, short.plug_p) annotation (Line(points={{-90,20},{-90,20},{-90,30},{-80,30}}, color={85,170,255}));
    connect(short.plug_n, idle.plug_p) annotation (Line(points={{-60,30},{-50,30},{-50,20}}, color={85,170,255}));
    connect(short.plug_n, idealOpeningSwitch.plug_p) annotation (Line(points={{-60,30},{-60,30},{-40,30}}, color={85,170,255}));
    connect(booleanStep2.y, idealCommutingSwitch.control) annotation (Line(points={{49,80},{49,80},{40,80},{40,38}}, color={255,0,255}));
    connect(booleanStep3.y, idealIntermediateSwitch.control) annotation (Line(points={{79,60},{70,60},{70,38}}, color={255,0,255}));
    connect(prescribedTemperature.port, admittance.heatPort) annotation (Line(points={{20,-90},{50,-90},{50,-30},{70,-30}}, color={191,0,0}));
    connect(prescribedTemperature.port, impedance.heatPort) annotation (Line(points={{20,-90},{50,-90},{50,-10},{70,-10}}, color={191,0,0}));
    connect(ramp.y, prescribedTemperature.T) annotation (Line(points={{-19,-90},{-10.5,-90},{-2,-90}}, color={0,0,127}));
    connect(variableAdmittance.plug_p, admittance.plug_n) annotation (Line(points={{10,-20},{36,-20},{60,-20}}, color={85,170,255}));
    connect(impedance.plug_n, variableImpedance.plug_p) annotation (Line(points={{60,0},{46,0},{30,0}}, color={85,170,255}));
    connect(variableImpedance.plug_n, variableAdmittance.plug_n) annotation (Line(points={{10,0},{-30,0},{-30,-20},{-10,-20}}, color={85,170,255}));
    connect(const_admittance.y, variableAdmittance.Y_ref) annotation (Line(points={{-39,-40},{-22,-40},{0,-40},{0,-31}}, color={85,170,255}));
    connect(const_impedance.y, variableImpedance.Z_ref) annotation (Line(points={{-9,-60},{4,-60},{20,-60},{20,-11}}, color={85,170,255}));
    connect(variableAdmittance.heatPort, variableImpedance.heatPort) annotation (Line(points={{0,-10},{0,-10},{0,6},{0,10},{20,10}}, color={191,0,0}));
    connect(variableImpedance.heatPort, prescribedTemperature.port) annotation (Line(points={{20,10},{34,10},{50,10},{50,-90},{20,-90}}, color={191,0,0}));
    connect(booleanStep1.y, idealClosingSwitch.control) annotation (Line(points={{-11,80},{0,80},{0,37}}, color={255,0,255}));
    connect(booleanStep4.y, idealOpeningSwitch.control) annotation (Line(points={{-39,60},{-30,60},{-30,37}}, color={255,0,255}));
    connect(idealOpeningSwitch.plug_n, idealClosingSwitch.plug_p) annotation (Line(points={{-20,30},{-15,30},{-10,30}}, color={85,170,255}));
    connect(idle.plug_n, variableAdmittance.plug_n) annotation (Line(points={{-50,0},{-50,0},{-50,-20},{-10,-20}}, color={85,170,255}));
    connect(currentSensor.plug_p, variableAdmittance.plug_n) annotation (Line(points={{-60,-20},{-35,-20},{-10,-20}}, color={85,170,255}));
    connect(currentSensor.plug_n, voltageSource.plug_n) annotation (Line(points={{-80,-20},{-90,-20},{-90,0}}, color={85,170,255}));
    connect(voltageSource.plug_n, star.plug_p) annotation (Line(points={{-90,0},{-90,0},{-90,-30}}, color={85,170,255}));
    connect(star.pin_n, ground.pin) annotation (Line(points={{-90,-50},{-90,-55},{-90,-60}}, color={85,170,255}));
    connect(idealClosingSwitch.plug_n, idealCommutingSwitch.plug_p) annotation (Line(points={{10,30},{18,30},{30,30}}, color={85,170,255}));
    connect(idealCommutingSwitch.plug_n1, idealIntermediateSwitch.plug_p1) annotation (Line(points={{50,35},{56,35},{60,35}}, color={85,170,255}));
    connect(idealCommutingSwitch.plug_n2, idealIntermediateSwitch.plug_p2) annotation (Line(points={{50,30},{56,30},{60,30}}, color={85,170,255}));
    connect(idealIntermediateSwitch.plug_n2, impedance.plug_p) annotation (Line(points={{80,30},{90,30},{90,0},{80,0}}, color={85,170,255}));
    connect(idealIntermediateSwitch.plug_n1, admittance.plug_p) annotation (Line(points={{80,35},{100,35},{100,-20},{80,-20}}, color={85,170,255}));
    annotation (experiment(StopTime=1),      Documentation(info="<html>
<p>Serial connection of different multi-phase ideal components and temperature dependent basic components</p>
</html>"));
  end Ideal;
end MultiPhase;
