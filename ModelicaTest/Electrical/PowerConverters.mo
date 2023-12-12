within ModelicaTest.Electrical;
package PowerConverters
  extends Modelica.Icons.ExamplesPackage;
  model HalfControlledBridge2mPulse
    "2*m pulse half controlled rectifier bridge with resistive load"
    import Modelica_Electrical_PowerConverters =
      Modelica.Electrical.PowerConverters;
    extends Modelica.Icons.Example;
    import Modelica.Constants.pi;
    parameter Integer m(final min=3) = 3 "Number of phases" annotation(Evaluate=true);
    parameter SI.Voltage Vrms=110 "RMS supply voltage";
    parameter SI.Frequency f=50 "Frequency";
    parameter SI.Angle constantFiringAngle=30*pi/180
      "Firing angle";
    parameter SI.Resistance R=20 "Load resistance";

    Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
      final m=m,
      V=fill(sqrt(2)*Vrms, m),
      phase=-
          Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
      f=fill(f, m)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,-30})));
    Modelica_Electrical_PowerConverters.ACDC.HalfControlledBridge2mPulse
      rectifier(final m=m, offStart_p=fill(true, m))
      annotation (Placement(transformation(extent={{-40,24},{-20,44}})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
      annotation (Placement(transformation(
          origin={50,10},
          extent={{10,-10},{-10,10}},
          rotation=90)));
    Modelica.Blocks.Math.Mean meanVoltage(f=2*m*f) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          origin={80,40})));
    Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=2*m*f)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          origin={80,10})));
    Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
      annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={0,-40})));
    Modelica.Blocks.Math.Mean meanCurrent(f=2*m*f) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          origin={80,-60})));
    Modelica_Electrical_PowerConverters.ACDC.Control.VoltageBridge2mPulse
      pulse2m(
      m=m,
      f=f,
      useFilter=false,
      constantFiringAngle=constantFiringAngle) annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-30,0})));
    Modelica.Electrical.Polyphase.Basic.MultiStarResistance
      multiStarResistance(final m=m) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,-60})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
          transformation(extent={{-90,-100},{-70,-80}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
        Placement(transformation(
          origin={30,30},
          extent={{10,-10},{-10,10}},
          rotation=90)));
    Modelica.Electrical.Polyphase.Basic.Resistor resistor1(m=m, R=fill(1, m))
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-80,-4})));
  equation
    connect(meanCurrent.u, currentSensor.i) annotation (Line(
        points={{68,-60},{0,-60},{0,-50}}, color={0,0,127}));
    connect(voltagesensor.v, meanVoltage.u) annotation (Line(
        points={{60,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
    connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
        points={{60,10},{68,10}}, color={0,0,127}));
    connect(rectifier.dc_n, currentSensor.n) annotation (Line(
        points={{-20,28},{-10,28},{-10,-40}}, color={0,0,255}));
    connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
        points={{-20,40},{50,40},{50,20}}, color={0,0,255}));
    connect(currentSensor.p, voltagesensor.n) annotation (Line(
        points={{10,-40},{50,-40},{50,0}}, color={0,0,255}));
    connect(pulse2m.fire_p, rectifier.fire_p) annotation (Line(
        points={{-36,11},{-36,22}}, color={255,0,255}));
    connect(sineVoltage.plug_n, multiStarResistance.plug) annotation (
        Line(
        points={{-80,-40},{-80,-50}}, color={0,0,255}));
    connect(multiStarResistance.pin, ground.p) annotation (Line(
        points={{-80,-70},{-80,-80}}, color={0,0,255}));
    connect(resistor.n, currentSensor.p) annotation (Line(
        points={{30,20},{30,-40},{10,-40}}, color={0,0,255}));
    connect(resistor.p, rectifier.dc_p) annotation (Line(
        points={{30,40},{-20,40}}, color={0,0,255}));
    connect(sineVoltage.plug_p, resistor1.plug_n) annotation (Line(points={{-80,
            -20},{-80,-20},{-80,-14}}, color={0,0,255}));
    connect(resistor1.plug_p, rectifier.ac) annotation (Line(points={{-80,6},{
            -80,6},{-80,32},{-80,34},{-40,34}}, color={0,0,255}));
    connect(pulse2m.ac, rectifier.ac) annotation (Line(points={{-40,0},{-60,0},
            {-60,16},{-80,16},{-80,34},{-40,34}}, color={0,0,255}));
    annotation (
      experiment(
        StopTime=0.1,
        Tolerance=1e-06,
        Interval=0.0002),
      Documentation(info="<html>
<p>This example shows a half controlled <code>2*m</code> pulse bridge rectifier with resistive load, where <code>m</code> is the number of phases. In case of resistive load the half controlled bridge shows the same output voltage as the
<a href=\"modelica:/Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse.ThyristorBridge2mPulse_R\">full controlled bridge</a>.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>

</html>"));
  end HalfControlledBridge2mPulse;

  model ThyristorBridge2mPulse_R
    "2*m pulse thyristor rectifier bridge with resistive load"
    extends
      ModelicaTest.Electrical.PowerConverters.ExampleTemplates.ThyristorBridge2mPulse(
       pulse2m(constantFiringAngle=constantFiringAngle));
    extends Modelica.Icons.Example;
    import Modelica.Constants.pi;
    parameter SI.Angle constantFiringAngle=30*pi/180
      "Firing angle";
    parameter SI.Resistance R=20 "Load resistance";
    Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
        Placement(transformation(
          origin={30,30},
          extent={{10,-10},{-10,10}},
          rotation=90)));
  equation
    connect(resistor.n, currentSensor.p)
      annotation (Line(points={{30,20},{30,-40},{10,-40}}, color={0,0,255}));
    connect(resistor.p, rectifier.dc_p) annotation (Line(points={{30,40},{-10,
            40},{-10,40},{-20,40}}, color={0,0,255}));
    annotation (
      experiment(
        StopTime=0.1,
        Tolerance=1e-06,
        Interval=0.0002),
      Documentation(info="<html>
<p>This example shows a full controlled <code>2*m</code> pulse bridge rectifier with resistive load, where <code>m</code> is the number of phases. In case of resistive load the full controlled bridge shows the same output voltage as the
<a href=\"modelica:/Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse.HalfControlledBridge2mPulse\">half controlled bridge</a>.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
  end ThyristorBridge2mPulse_R;

  package ExampleTemplates
    partial model ThyristorBridge2mPulse
      "Template of 2*m pulse bridge thyristor rectifier"
      extends Modelica.Electrical.PowerConverters.Icons.ExampleTemplate;
      import Modelica.Constants.pi;
      parameter Integer m(final min=3) = 3 "Number of phases" annotation(Evaluate=true);
      parameter SI.Voltage Vrms=110 "RMS supply voltage";
      parameter SI.Frequency f=50 "Frequency";

      Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
        final m=m,
        V=fill(sqrt(2)*Vrms, m),
        phase=-
            Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
        f=fill(f, m)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-80,-30})));
      Modelica.Electrical.PowerConverters.ACDC.ThyristorBridge2mPulse
        rectifier(final m=m)
        annotation (Placement(transformation(extent={{-40,24},{-20,44}})));
      Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
        annotation (Placement(transformation(
            origin={50,10},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.Blocks.Math.Mean meanVoltage(f=2*m*f) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            origin={80,40})));
      Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=2*m*f)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={80,10})));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={0,-40})));
      Modelica.Blocks.Math.Mean meanCurrent(f=2*m*f) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            origin={80,-60})));
      Modelica.Electrical.PowerConverters.ACDC.Control.VoltageBridge2mPulse
        pulse2m(
        m=m,
        f=f,
        useFilter=false) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={-30,0})));
      Modelica.Electrical.Polyphase.Basic.MultiStarResistance
        multiStarResistance(final m=m) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-80,-60})));
      Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
            transformation(extent={{-90,-100},{-70,-80}})));
      Modelica.Electrical.Polyphase.Basic.Resistor innerResistor(m=m, R=fill(1,
            m)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-80,-4})));
    equation
      connect(meanCurrent.u, currentSensor.i) annotation (Line(
          points={{68,-60},{0,-60},{0,-50}}, color={0,0,127}));
      connect(voltagesensor.v, meanVoltage.u) annotation (Line(
          points={{60,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
      connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
          points={{60,10},{68,10}}, color={0,0,127}));
      connect(rectifier.dc_n, currentSensor.n) annotation (Line(
          points={{-20,28},{-10,28},{-10,-40}}, color={0,0,255}));
      connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
          points={{-20,40},{50,40},{50,20}}, color={0,0,255}));
      connect(currentSensor.p, voltagesensor.n) annotation (Line(
          points={{10,-40},{50,-40},{50,0}}, color={0,0,255}));
      connect(pulse2m.fire_p, rectifier.fire_p) annotation (Line(
          points={{-36,11},{-36,22}}, color={255,0,255}));
      connect(pulse2m.fire_n, rectifier.fire_n) annotation (Line(
          points={{-24,11},{-24,22}}, color={255,0,255}));
      connect(sineVoltage.plug_n, multiStarResistance.plug) annotation (
          Line(
          points={{-80,-40},{-80,-50}}, color={0,0,255}));
      connect(multiStarResistance.pin, ground.p) annotation (Line(
          points={{-80,-70},{-80,-80}}, color={0,0,255}));
      connect(pulse2m.ac, rectifier.ac) annotation (Line(points={{-40,0},{-60,0},
              {-60,20},{-80,20},{-80,34},{-40,34}}, color={0,0,255}));
      connect(sineVoltage.plug_p, innerResistor.plug_n) annotation (Line(points=
             {{-80,-20},{-80,-20},{-80,-14}}, color={0,0,255}));
      connect(innerResistor.plug_p, rectifier.ac)
        annotation (Line(points={{-80,6},{-80,34},{-40,34}}, color={0,0,255}));
      annotation (
        Documentation(info="<html>
<p>Template of
<a href=\"modelica:/Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse\">
<code>2*m</code> pulse bridge rectifiers</a>, where <code>m</code> is the number of phases; load is not yet included.</p>
</html>"));
    end ThyristorBridge2mPulse;
  end ExampleTemplates;
end PowerConverters;
