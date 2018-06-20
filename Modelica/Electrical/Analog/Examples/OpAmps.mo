within Modelica.Electrical.Analog.Examples;
package OpAmps "Examples with operational amplifiers"
  extends Modelica.Icons.ExamplesPackage;
  model InvertingAmp "Inverting amplifier"
    extends Modelica.Icons.Example;
    parameter SI.Voltage Vps=+15 "Positive supply";
    parameter SI.Voltage Vns=-15 "Negative supply";
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    parameter Real k=2 "Desired amplification";
    parameter SI.Resistance R1=1000 "Arbitrary resistance";
    parameter SI.Resistance R2=k*R1 "Calculated resistance to reach desired amplification k";
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimted opAmp(
      Vps=Vps,
      Vns=Vns,
      out(i(start=0, fixed=false)))
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
    Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
      V=2*Vin,
      rising=0.2/f,
      width=0.3/f,
      falling=0.2/f,
      period=1/f,
      nperiod=-1,
      offset=-Vin,
      startTime=-(vIn.rising + vIn.width/2)) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,0})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,-20})));
    Modelica.Electrical.Analog.Basic.Resistor r1(R=R1)
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    Modelica.Electrical.Analog.Basic.Resistor r2(R=R2)
      annotation (Placement(transformation(extent={{20,20},{0,40}})));
  equation
    connect(r1.n, r2.n) annotation (Line(
        points={{-20,30},{0,30}}, color={0,0,255}));
    connect(r2.n, opAmp.in_n) annotation (Line(
        points={{0,30},{-10,30},{-10,6},{0,6}}, color={0,0,255}));
    connect(r2.p, opAmp.out) annotation (Line(
        points={{20,30},{30,30},{30,0},{20,0}}, color={0,0,255}));
    connect(ground.p, opAmp.in_p) annotation (Line(
        points={{-10,-80},{-10,-6},{0,-6}}, color={0,0,255}));
    connect(vIn.p, r1.p) annotation (Line(
        points={{-80,10},{-80,30},{-40,30}}, color={0,0,255}));
    connect(ground.p, vIn.n) annotation (Line(
        points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
    connect(ground.p, vOut.n) annotation (Line(
        points={{-10,-80},{50,-80},{50,-30}}, color={0,0,255}));
    connect(opAmp.out, vOut.p) annotation (Line(
        points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
    annotation (
      Documentation(info="<html>
                        <p>This is an inverting amplifier. Resistance R1 can be chosen, R2 is defined by the desired amplification k.</p>
                        </html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end InvertingAmp;

  model NonInvertingAmp "Non-inverting amplifier"
    extends Modelica.Icons.Example;
    parameter SI.Voltage Vps=+15 "Positive supply";
    parameter SI.Voltage Vns=-15 "Negative supply";
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    parameter Real k=2 "Desired amplification";
    parameter SI.Resistance R1=1000 "Arbitrary resistance";
    parameter SI.Resistance R2=(k - 1)*R1 "Calculated resistance to reach desired amplification k";
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimted opAmp(
      Vps=Vps,
      Vns=Vns,
      out(i(start=0)))
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
    Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
      V=2*Vin,
      rising=0.2/f,
      width=0.3/f,
      falling=0.2/f,
      period=1/f,
      nperiod=-1,
      offset=-Vin,
      startTime=-(vIn.rising + vIn.width/2)) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,0})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,-20})));
    Modelica.Electrical.Analog.Basic.Resistor r1(R=R1) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={10,50})));
    Modelica.Electrical.Analog.Basic.Resistor r2(R=R2) annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={10,30})));
  equation
    connect(opAmp.out, r2.p) annotation (Line(
        points={{20,0},{30,0},{30,30},{20,30}}, color={0,0,255}));
    connect(r1.n, ground.p) annotation (Line(
        points={{20,50},{80,50},{80,-80},{-10,-80}},         color={0,0,255}));
    connect(vIn.p, opAmp.in_p) annotation (Line(
        points={{-80,10},{-20,10},{-20,-6},{0,-6}}, color={0,0,255}));
    connect(r2.n, opAmp.in_n) annotation (Line(
        points={{0,30},{-10,30},{-10,6},{0,6}}, color={0,0,255}));
    connect(r2.n, r1.p) annotation (Line(
        points={{0,30},{-10,30},{-10,50},{0,50}}, color={0,0,255}));
    connect(ground.p, vIn.n) annotation (Line(
        points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
    connect(opAmp.out, vOut.p) annotation (Line(
        points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
    connect(ground.p, vOut.n) annotation (Line(
        points={{-10,-80},{50,-80},{50,-30}}, color={0,0,255}));
    annotation (Documentation(info=
                   "<html>
                         <p>This is a non inverting amplifier. Resistance R1 can be chosen, R2 is defined by the desired amplification k.</p>
                         </html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end NonInvertingAmp;

  model VoltageFollower "Reproduce input voltage"
    extends Modelica.Icons.Example;
    parameter SI.Voltage Vps=+15 "Positive supply";
    parameter SI.Voltage Vns=-15 "Negative supply";
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    parameter SI.Resistance Ri=1
      "Inner resistance of input voltage source";
    parameter SI.Resistance Rl=1 "Load resistance";
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimted opAmp(
      Vps=Vps,
      Vns=Vns,
      v_in(start=0))
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
    Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
      V=2*Vin,
      rising=0.2/f,
      width=0.3/f,
      falling=0.2/f,
      period=1/f,
      nperiod=-1,
      offset=-Vin,
      startTime=-(vIn.rising + vIn.width/2)) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,0})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={60,-20})));
    Modelica.Electrical.Analog.Basic.Resistor ri(R=Ri)
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    Modelica.Electrical.Analog.Basic.Resistor rl(R=Rl) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={30,-18})));
  equation
    connect(ground.p, vIn.n) annotation (Line(
        points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
    connect(opAmp.out, vOut.p) annotation (Line(
        points={{20,0},{60,0},{60,-10}}, color={0,0,255}));
    connect(ground.p, vOut.n) annotation (Line(
        points={{-10,-80},{60,-80},{60,-30}}, color={0,0,255}));
    connect(opAmp.out, opAmp.in_n) annotation (Line(
        points={{20,0},{30,0},{30,20},{-10,20},{-10,6},{0,6}}, color={0,0,255}));
    connect(vIn.p, ri.p) annotation (Line(
        points={{-80,10},{-60,10}}, color={0,0,255}));
    connect(ri.n, opAmp.in_p) annotation (Line(
        points={{-40,10},{-20,10},{-20,-6},{0,-6}}, color={0,0,255}));
    connect(opAmp.out, rl.p) annotation (Line(
        points={{20,0},{30,0},{30,-8}}, color={0,0,255}));
    connect(ground.p, rl.n) annotation (Line(
        points={{-10,-80},{30,-80},{30,-28}}, color={0,0,255}));
    annotation (Documentation(info=
                   "<html>
    <p>This is a voltage follower. It reproduces the input voltage at the output without loading the input voltage source with a stiff output.</p>
                         </html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end VoltageFollower;

  model Differentiator "Differentiating amplifier"
    extends Modelica.Icons.Example;
    import Modelica.Constants.pi;
    parameter SI.Voltage Vps=+15 "Positive supply";
    parameter SI.Voltage Vns=-15 "Negative supply";
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    parameter Real k=2 "Desired amplification";
    parameter SI.Resistance R=1000 "Arbitrary resistance";
    parameter SI.Capacitance C=k/(2*pi*f*R) "Calculated capacitance to reach desired amplification k";
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimted opAmp(Vps=Vps, Vns=
          Vns) annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
    Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
      V=2*Vin,
      rising=0.2/f,
      width=0.3/f,
      falling=0.2/f,
      period=1/f,
      nperiod=-1,
      offset=-Vin,
      startTime=-(vIn.rising + vIn.width/2)) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,0})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,-20})));
    Modelica.Electrical.Analog.Basic.Resistor r(R=R)
      annotation (Placement(transformation(extent={{20,20},{0,40}})));
    Modelica.Electrical.Analog.Basic.Capacitor c(C=C, v(fixed=true, start=0))
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  equation
    connect(r.n, c.n) annotation (Line(
        points={{0,30},{-20,30}}, color={0,0,255}));
    connect(vIn.p, c.p) annotation (Line(
        points={{-80,10},{-80,30},{-40,30}}, color={0,0,255}));
    connect(vIn.n, ground.p) annotation (Line(
        points={{-80,-10},{-80,-80},{-10,-80}}, color={0,0,255}));
    connect(ground.p, opAmp.in_p) annotation (Line(
        points={{-10,-80},{-10,-6},{0,-6}}, color={0,0,255}));
    connect(opAmp.in_n, r.n) annotation (Line(
        points={{0,6},{-10,6},{-10,30},{0,30}}, color={0,0,255}));
    connect(r.p, opAmp.out) annotation (Line(
        points={{20,30},{30,30},{30,0},{20,0}}, color={0,0,255}));
    connect(opAmp.out, vOut.p) annotation (Line(
        points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
    connect(vOut.n, ground.p) annotation (Line(
        points={{50,-30},{50,-80},{-10,-80}}, color={0,0,255}));
    annotation (Documentation(info=
                   "<html>
                        <p>This is a (inverting) differentiating amplifier. Resistance R can be chosen, capacitance C is defined by the desired time constant resp. frequency.</p>
                        </html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end Differentiator;

  model Integrator "Integrating amplifier"
    extends Modelica.Icons.Example;
    import Modelica.Constants.pi;
    parameter SI.Voltage Vps=+15 "Positive supply";
    parameter SI.Voltage Vns=-15 "Negative supply";
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    parameter Real k=2 "Desired amplification";
    parameter SI.Resistance R=1000 "Arbitrary resistance";
    parameter SI.Capacitance C=1/k/(2*pi*f*R) "Calculated capacitance to reach desired amplification k";
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimted opAmp(
      Vps=Vps,
      Vns=Vns,
      v_in(start=0))
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
    Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
      V=2*Vin,
      rising=0.2/f,
      width=0.3/f,
      falling=0.2/f,
      period=1/f,
      nperiod=-1,
      offset=-Vin,
      startTime=-(vIn.rising + vIn.width/2)) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,0})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,-20})));
    Modelica.Electrical.Analog.Basic.Resistor r(R=R)
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    Modelica.Electrical.Analog.Basic.Capacitor c(C=C, v(fixed=true, start=0))
      annotation (Placement(transformation(extent={{20,20},{0,40}})));
  equation
    connect(c.n, r.n) annotation (Line(
        points={{0,30},{-20,30}}, color={0,0,255}));
    connect(c.p, opAmp.out) annotation (Line(
        points={{20,30},{30,30},{30,0},{20,0}}, color={0,0,255}));
    connect(c.n, opAmp.in_n) annotation (Line(
        points={{0,30},{-10,30},{-10,6},{0,6}}, color={0,0,255}));
    connect(ground.p, opAmp.in_p) annotation (Line(
        points={{-10,-80},{-10,-6},{0,-6}}, color={0,0,255}));
    connect(vIn.p, r.p) annotation (Line(
        points={{-80,10},{-80,30},{-40,30}}, color={0,0,255}));
    connect(ground.p, vIn.n) annotation (Line(
        points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
    connect(opAmp.out, vOut.p) annotation (Line(
        points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
    connect(ground.p, vOut.n) annotation (Line(
        points={{-10,-80},{50,-80},{50,-30}}, color={0,0,255}));
    annotation (Documentation(info=
                   "<html>
                        <p>This is an (inverting) integrating amplifier. Resistance R can be chosen, capacitance C is defined by the desired time constant resp. frequency.</p>
                        </html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end Integrator;

  model LowPass "Low-pass filter"
    extends Modelica.Icons.Example;
    import Modelica.Constants.pi;
    parameter SI.Voltage Vps=+15 "Positive supply";
    parameter SI.Voltage Vns=-15 "Negative supply";
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    parameter Real k=1 "Desired amplification";
    parameter SI.Resistance R1=1000 "Arbitrary resistance";
    parameter SI.Resistance R2=k*R1 "Calculated resistance to reach k";
    parameter SI.Frequency fG=f/10 "Limiting frequency, as an example coupled to f";
    parameter SI.Capacitance C=1/(2*pi*fG*R2) "Calculated capacitance to reach fG";
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimted opAmp(
      Vps=Vps,
      Vns=Vns,
      v_in(start=0))
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
    Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
      rising=0.2/f,
      width=0.3/f,
      falling=0.2/f,
      period=1/f,
      nperiod=-1,
      startTime=-(vIn.rising + vIn.width/2),
      V=Vin,
      offset=0) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,0})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,-20})));
    Modelica.Electrical.Analog.Basic.Resistor r1(R=R1)
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    Modelica.Electrical.Analog.Basic.Resistor r2(R=R2)
      annotation (Placement(transformation(extent={{20,20},{0,40}})));
    Modelica.Electrical.Analog.Basic.Capacitor c(C=C, v(fixed=true, start=0))
      annotation (Placement(transformation(extent={{20,40},{0,60}})));
  equation
    connect(r1.n, r2.n) annotation (Line(
        points={{-20,30},{0,30}}, color={0,0,255}));
    connect(r2.n, opAmp.in_n) annotation (Line(
        points={{0,30},{-10,30},{-10,6},{0,6}}, color={0,0,255}));
    connect(r2.p, opAmp.out) annotation (Line(
        points={{20,30},{30,30},{30,0},{20,0}}, color={0,0,255}));
    connect(r2.p, c.p) annotation (Line(
        points={{20,30},{30,30},{30,50},{20,50}}, color={0,0,255}));
    connect(c.n, r2.n) annotation (Line(
        points={{0,50},{-10,50},{-10,30},{0,30}}, color={0,0,255}));
    connect(ground.p, opAmp.in_p) annotation (Line(
        points={{-10,-80},{-10,-6},{0,-6}}, color={0,0,255}));
    connect(vIn.p, r1.p) annotation (Line(
        points={{-80,10},{-80,30},{-40,30}}, color={0,0,255}));
    connect(ground.p, vIn.n) annotation (Line(
        points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
    connect(opAmp.out, vOut.p) annotation (Line(
        points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
    connect(ground.p, vOut.n) annotation (Line(
        points={{-10,-80},{50,-80},{50,-30}}, color={0,0,255}));
    annotation (Documentation(info=
                   "<html>
                         <p>This is a (inverting) low pass filter. Resistance R1 can be chosen, resistance R2 is defined by the desired amplification k, capacitance C is defined by the desired cut-off frequency.</p>
                         <p>The example is taken from: U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 13.3</p>
                         </html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end LowPass;

  model HighPass "High-pass filter"
    extends Modelica.Icons.Example;
    import Modelica.Constants.pi;
    parameter SI.Voltage Vps=+15 "Positive supply";
    parameter SI.Voltage Vns=-15 "Negative supply";
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    parameter Real k=1 "Desired amplification";
    parameter SI.Resistance R1=1000 "Arbitrary resistance";
    parameter SI.Resistance R2=k*R1 "Calculated resistance to reach k";
    parameter SI.Frequency fG=f/10 "Limiting frequency, as an example coupled to f";
    parameter SI.Capacitance C=1/(2*pi*fG*R1) "Calculated capacitance to reach fG";
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimted opAmp(
      Vps=Vps,
      Vns=Vns,
      out(i(start=0)))
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
    Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
      rising=0.2/f,
      width=0.3/f,
      falling=0.2/f,
      period=1/f,
      nperiod=-1,
      startTime=-(vIn.rising + vIn.width/2),
      V=Vin,
      offset=0) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,0})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,-20})));
    Modelica.Electrical.Analog.Basic.Resistor r1(R=R1)
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    Modelica.Electrical.Analog.Basic.Resistor r2(R=R2)
      annotation (Placement(transformation(extent={{20,20},{0,40}})));
    Modelica.Electrical.Analog.Basic.Capacitor c(C=C, v(fixed=true, start=0))
      annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
  equation
    connect(r1.n, r2.n) annotation (Line(
        points={{-20,30},{0,30}}, color={0,0,255}));
    connect(r2.n, opAmp.in_n) annotation (Line(
        points={{0,30},{-10,30},{-10,6},{0,6}}, color={0,0,255}));
    connect(r2.p, opAmp.out) annotation (Line(
        points={{20,30},{30,30},{30,0},{20,0}}, color={0,0,255}));
    connect(c.n, r1.p) annotation (Line(
        points={{-50,30},{-40,30}}, color={0,0,255}));
    connect(ground.p, opAmp.in_p) annotation (Line(
        points={{-10,-80},{-10,-6},{0,-6}}, color={0,0,255}));
    connect(vIn.p, c.p) annotation (Line(
        points={{-80,10},{-80,30},{-70,30}}, color={0,0,255}));
    connect(ground.p, vIn.n) annotation (Line(
        points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
    connect(opAmp.out, vOut.p) annotation (Line(
        points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
    connect(ground.p, vOut.n) annotation (Line(
        points={{-10,-80},{50,-80},{50,-30}}, color={0,0,255}));
    annotation (Documentation(info=
                   "<html>
                         <p>This is a (inverting) high pass filter. Resistance R1 can be chosen, resistance R2 is defined by the desired amplification k, capacitance C is defined by the desired cut-off frequency.</p>
                         <p>The example is taken from: U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 13.3</p>
                         </html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end HighPass;

  model Comparator "Comparator"
    extends Modelica.Icons.Example;
    parameter SI.Voltage Vps=+15 "Positive supply";
    parameter SI.Voltage Vns=-15 "Negative supply";
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    parameter SI.Voltage Vref=0 "Reference voltage";
    parameter Real k=(Vref - Vns)/(Vps - Vns) "Calculated potentiometer ratio to reach Vref";
    parameter SI.Resistance R=1000 "Resistance of potentiometer";
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimted opAmp(Vps=Vps, Vns=
          Vns) annotation (Placement(transformation(extent={{0,10},{20,-10}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
    Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
      rising=0.2/f,
      width=0.3/f,
      falling=0.2/f,
      period=1/f,
      nperiod=-1,
      startTime=-(vIn.rising + vIn.width/2),
      V=2*Vin,
      offset=-Vin) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,0})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,-20})));
    Modelica.Electrical.Analog.Basic.Potentiometer potentiometer(R=R, rConstant=
         k) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          origin={-10,-30})));
    Modelica.Electrical.Analog.Sources.SupplyVoltage supplyVoltage(Vps=Vps, Vns=
         Vns) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          origin={-10,-50})));
  equation
    connect(vIn.p, opAmp.in_p) annotation (Line(
        points={{-80,10},{-10,10},{-10,6},{0,6}}, color={0,0,255}));
    connect(opAmp.out, vOut.p) annotation (Line(
        points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
    connect(ground.p, vOut.n) annotation (Line(
        points={{-10,-80},{50,-80},{50,-30}}, color={0,0,255}));
    connect(ground.p, vIn.n) annotation (Line(
        points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
    connect(potentiometer.contact, opAmp.in_n) annotation (Line(
        points={{0,-20},{0,-6}}, color={0,0,255}));
    connect(potentiometer.pin_p, supplyVoltage.pin_p) annotation (Line(
        points={{-20,-30},{-20,-50}}, color={0,0,255}));
    connect(potentiometer.pin_n, supplyVoltage.pin_n) annotation (Line(
        points={{0,-30},{0,-50}}, color={0,0,255}));
    connect(ground.p, supplyVoltage.ground) annotation (Line(
        points={{-10,-80},{-10,-50}}, color={0,0,255}));
    annotation (Documentation(info=
                   "<html>
                        <p>This is a comparator. Resistance R1 can be chosen, resistance R2 is defined by the desired reference voltage Vref (between Vn and Vp). The output switches between Vn for input voltage &lt; Vref and Vp for input voltage &gt; Vref.</p>
                        </html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end Comparator;

  model InvertingSchmittTrigger "Inverting Schmitt trigger with hysteresis"
    extends Modelica.Icons.Example;
    parameter SI.Voltage Vps=+15 "Positive supply";
    parameter SI.Voltage Vns=-15 "Negative supply";
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    parameter SI.Voltage vHys=1 "(positive) hysteresis voltage";
    parameter Real k=vHys/Vps "Auxiliary calculated parameter to be used in R2 calculation";
    parameter SI.Resistance R1=1000 "Arbitrary resistance";
    parameter SI.Resistance R2=(1 - k)/k*R1 "Calculated resistance to reach hysteresis voltage";
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimted opAmp(
      Vps=Vps,
      Vns=Vns,
      out(i(start=0)),
      homotopyType=Modelica.Blocks.Types.LimiterHomotopy.LowerLimit)
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
    Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
      rising=0.2/f,
      width=0.3/f,
      falling=0.2/f,
      period=1/f,
      nperiod=-1,
      startTime=-(vIn.rising + vIn.width/2),
      V=2*Vin,
      offset=-Vin) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,0})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,-20})));
    Modelica.Electrical.Analog.Basic.Resistor r1(R=R1) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={30,-60})));
    Modelica.Electrical.Analog.Basic.Resistor r2(R=R2) annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={30,-20})));
  equation
    connect(r2.n, r1.p) annotation (Line(
        points={{30,-30},{30,-50}}, color={0,0,255}));
    connect(ground.p, r1.n) annotation (Line(
        points={{-10,-80},{30,-80},{30,-80},{30,-80},{30,-70},{30,-70}}, color={0,0,255}));
    connect(opAmp.out, r2.p) annotation (Line(
        points={{20,0},{30,0},{30,-10}}, color={0,0,255}));
    connect(r2.n, opAmp.in_p) annotation (Line(
        points={{30,-30},{30,-40},{-10,-40},{-10,-6},{0,-6}}, color={0,0,255}));
    connect(vIn.p, opAmp.in_n) annotation (Line(
        points={{-80,10},{-20,10},{-20,6},{0,6}}, color={0,0,255}));
    connect(ground.p, vIn.n) annotation (Line(
        points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
    connect(ground.p, vOut.n) annotation (Line(
        points={{-10,-80},{50,-80},{50,-30}}, color={0,0,255}));
    connect(opAmp.out, vOut.p) annotation (Line(
        points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
    annotation (Documentation(info=
                   "<html>
                        <p>This is a (inverting) Schmitt trigger. Resistance R1 can be chosen, resistance R2 is defined by the desired hysteresis. The output gets Vn for input voltage &gt; 0 + vHys and Vp for input voltage &lt; vHys*Vns/Vps.</p>
                        <p>The example is taken from: U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 6.5.2</p>
                        </html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end InvertingSchmittTrigger;

  model SchmittTrigger "Schmitt trigger with hysteresis"
    extends Modelica.Icons.Example;
    parameter SI.Voltage Vps=+15 "Positive supply";
    parameter SI.Voltage Vns=-15 "Negative supply";
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    parameter SI.Voltage vHys=1 "(positive) hysteresis voltage";
    parameter Real k=vHys/Vps "Auxiliary calculated parameter to be used in R2 calculation";
    parameter SI.Resistance R1=1000 "Arbitrary resistance";
    parameter SI.Resistance R2=R1/k "Calculated resistance to reach hysteresis voltage";
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimted opAmp(
      Vps=Vps,
      Vns=Vns,
      out(i(start=0)),
      homotopyType=Modelica.Blocks.Types.LimiterHomotopy.UpperLimit)
      annotation (Placement(transformation(extent={{0,10},{20,-10}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
    Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
      rising=0.2/f,
      width=0.3/f,
      falling=0.2/f,
      period=1/f,
      nperiod=-1,
      startTime=-(vIn.rising + vIn.width/2),
      V=2*Vin,
      offset=-Vin) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,0})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,-20})));
    Modelica.Electrical.Analog.Basic.Resistor r1(R=R1) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          origin={-30,20})));
    Modelica.Electrical.Analog.Basic.Resistor r2(R=R2) annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={10,20})));
  equation
    connect(ground.p, vIn.n) annotation (Line(
        points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
    connect(ground.p, vOut.n) annotation (Line(
        points={{-10,-80},{50,-80},{50,-30}}, color={0,0,255}));
    connect(opAmp.out, vOut.p) annotation (Line(
        points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
    connect(opAmp.in_n, ground.p) annotation (Line(
        points={{0,-6},{-10,-6},{-10,-80}}, color={0,0,255}));
    connect(opAmp.out, r2.n) annotation (Line(
        points={{20,0},{30,0},{30,20},{20,20}}, color={0,0,255}));
    connect(r2.p, opAmp.in_p) annotation (Line(
        points={{0,20},{-10,20},{-10,6},{0,6}}, color={0,0,255}));
    connect(r2.p, r1.n) annotation (Line(
        points={{0,20},{-20,20}}, color={0,0,255}));
    connect(r1.p, vIn.p) annotation (Line(
        points={{-40,20},{-80,20},{-80,10}}, color={0,0,255}));
    annotation (Documentation(info=
                   "<html>
                        <p>This is a (non-inverting) Schmitt trigger. Resistance R1 can be chosen, resistance R2 is defined by the desired hysteresis. The output gets Vp for input voltage &gt; vHys and Vn for input voltage &lt; vHys*Vns/Vps.</p>
                        <p>The example is taken from: U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 6.5.2</p>
                        </html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end SchmittTrigger;

  model Multivibrator "Multivibrator with Schmitt trigger"
    extends Modelica.Icons.Example;
    parameter SI.Voltage Vps=+15 "Positive supply";
    parameter SI.Voltage Vns=-15 "Negative supply";
    parameter SI.Frequency f=10 "Desired frequency";
    parameter SI.Resistance R1=1000 "Resistance 1 for adjusting the Schmitt trigger voltage level";
    parameter SI.Resistance R2=1000 "Resistance 2 for adjusting the Schmitt trigger voltage level";
    parameter SI.Resistance R=1000 "Arbitrary resistance";
    parameter SI.Capacitance C=1/f/(2*R*log(1 + 2*R1/R2)) "Calculated capacitance to reach the desired frequency f";
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimted opAmp(
      Vps=Vps,
      Vns=Vns) annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,-20})));
    Modelica.Electrical.Analog.Basic.Resistor r1(R=R1, i(start=0)) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-10,-40})));
    Modelica.Electrical.Analog.Basic.Resistor r2(R=R2) annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          origin={10,-20})));
    Modelica.Electrical.Analog.Basic.Resistor r(R=R)
      annotation (Placement(transformation(extent={{20,20},{0,40}})));
    Modelica.Electrical.Analog.Basic.Capacitor c(C=C, v(start=1, fixed=true))
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-30,-40})));
  equation
    connect(ground.p, r1.n) annotation (Line(
        points={{-10,-60},{-10,-50}}, color={0,0,255}));
    connect(ground.p, vOut.n) annotation (Line(
        points={{-10,-60},{50,-60},{50,-30}}, color={0,0,255}));
    connect(opAmp.out, vOut.p) annotation (Line(
        points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
    connect(ground.p, c.n) annotation (Line(
        points={{-10,-60},{-30,-60},{-30,-50}}, color={0,0,255}));
    connect(opAmp.out, r.p) annotation (Line(
        points={{20,0},{30,0},{30,30},{20,30}}, color={0,0,255}));
    connect(r.n, opAmp.in_n) annotation (Line(
        points={{0,30},{-10,30},{-10,6},{0,6}}, color={0,0,255}));
    connect(opAmp.out, r2.p) annotation (Line(
        points={{20,0},{30,0},{30,-20},{20,-20}}, color={0,0,255}));
    connect(r2.n, opAmp.in_p) annotation (Line(
        points={{0,-20},{-10,-20},{-10,-6},{0,-6}}, color={0,0,255}));
    connect(opAmp.in_p, r1.p) annotation (Line(
        points={{0,-6},{-10,-6},{-10,-30}}, color={0,0,255}));
    connect(r.n, c.p) annotation (Line(
        points={{0,30},{-30,30},{-30,-30}}, color={0,0,255}));
    annotation (Documentation(info=
                   "<html>
                        <p>This is a Multivibrator with Schmitt trigger according to:</p>
                        <p>U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 6.5.3</p>
                        </html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end Multivibrator;

  model SignalGenerator "Rectangle-Triangle generator"
    extends Modelica.Icons.Example;
    import Modelica.Constants.pi;
    parameter SI.Voltage Vps=+15 "Positive supply";
    parameter SI.Voltage Vns=-Vps "Negative supply";
    parameter SI.Voltage VAmp=10 "Desired amplitude of output";
    parameter SI.Resistance R1=1000 "Arbitrary resistance for Schmitt trigger part";
    parameter SI.Resistance R2=R1*Vps/VAmp "Calculated resistance for Schmitt trigger to reach VAmp";
    parameter SI.Frequency f=10 "Desired frequency";
    parameter SI.Resistance R=1000 "Arbitrary resistance of integrator part";
    parameter SI.Capacitance C=Vps/VAmp/(4*f*R) "Calculated capacitance of integrator part to reach f";
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimted opAmp1(
      Vps=Vps,
      Vns=Vns,
      strict=false,
      homotopyType=Modelica.Blocks.Types.LimiterHomotopy.UpperLimit)
      annotation (Placement(transformation(extent={{-60,10},{-40,-10}})));
    Modelica.Electrical.Analog.Basic.Resistor r2(R=R2, i(start=Vps/R2))
      annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-50,30})));
    Modelica.Electrical.Analog.Basic.Resistor r1(R=R1) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          origin={-50,50})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimted opAmp2(
      Vps=Vps,
      Vns=Vns,
      v_in(start=0),
      strict=false)
      annotation (Placement(transformation(extent={{30,-10},{50,10}})));
    Modelica.Electrical.Analog.Basic.Capacitor c(C=C, v(fixed=true, start=0))
      annotation (Placement(transformation(extent={{50,20},{30,40}})));
    Modelica.Electrical.Analog.Basic.Resistor r(R=R)
      annotation (Placement(transformation(extent={{-10,20},{10,40}})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOutRectangle annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={-30,-20})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOutTriangle annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={60,-18})));
  equation
    connect(opAmp1.out, r2.n) annotation (Line(
        points={{-40,0},{-30,0},{-30,30},{-40,30}}, color={0,0,255}));
    connect(opAmp1.in_p, r2.p) annotation (Line(
        points={{-60,6},{-70,6},{-70,30},{-60,30}}, color={0,0,255}));
    connect(opAmp1.in_n, ground.p) annotation (Line(
        points={{-60,-6},{-70,-6},{-70,-40},{0,-40}}, color={0,0,255}));
    connect(opAmp1.out, r.p) annotation (Line(
        points={{-40,0},{-30,0},{-30,30},{-10,30}}, color={0,0,255}));
    connect(r.n, c.n) annotation (Line(
        points={{10,30},{30,30}}, color={0,0,255}));
    connect(c.p, opAmp2.out) annotation (Line(
        points={{50,30},{60,30},{60,0},{50,0}}, color={0,0,255}));
    connect(ground.p, opAmp2.in_p) annotation (Line(
        points={{0,-40},{20,-40},{20,-6},{30,-6}}, color={0,0,255}));
    connect(c.n, opAmp2.in_n) annotation (Line(
        points={{30,30},{20,30},{20,6},{30,6}}, color={0,0,255}));
    connect(r2.p, r1.p) annotation (Line(
        points={{-60,30},{-70,30},{-70,50},{-60,50}}, color={0,0,255}));
    connect(opAmp2.out, r1.n) annotation (Line(
        points={{50,0},{60,0},{60,50},{-40,50}}, color={0,0,255}));
    connect(opAmp1.out, vOutRectangle.p) annotation (Line(
        points={{-40,0},{-30,0},{-30,-10}}, color={0,0,255}));
    connect(ground.p, vOutRectangle.n) annotation (Line(
        points={{0,-40},{-30,-40},{-30,-30}}, color={0,0,255}));
    connect(opAmp2.out, vOutTriangle.p) annotation (Line(
        points={{50,0},{60,0},{60,-8}}, color={0,0,255}));
    connect(ground.p, vOutTriangle.n) annotation (Line(
        points={{0,-40},{60,-40},{60,-28}}, color={0,0,255}));
    annotation (Documentation(info=
                   "<html>
                        <p>This signal generator consists of a Schmitt trigger and an integrator. The output of the Schmitt trigger part opamp (opAmp1) is a rectangular signal with the amplitude VAmp and the frequency f.
                        The output of the integrator part opamp (opAmp2) is a triangular signal of also the amplitude Vamp and the frequency f.</p>
                        <p>Source:</p>
                        <p>U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 14.5.2</p>
                        </html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end SignalGenerator;

  model LCOscillator "LC oscillator"
    extends Modelica.Icons.Example;
    import Modelica.Constants.pi;
    parameter SI.Voltage VAmp=10 "Amplitude of output";
    parameter SI.Frequency f=1000 "Desired frequency";
    parameter Real A=1.001 "Amplification constant: A > 1 amplification, A = 1 pure sinusoidal oscillation, A < 0 damping";
    parameter SI.Inductance L=0.001 "Arbitrary inductance > 0";
    parameter SI.Capacitance C=1/((2*pi*f)^2*L) "Calculated capacitance to reach frequency f";
    parameter SI.Resistance R=10000.0 "Damping resistance";
    parameter SI.Resistance R1=10000.0 "Arbitrary high resistance";
    parameter SI.Resistance R2=(A - 1)*R1 "Calculated resistance to reach amplification A";
    parameter Real gamma=(1 - A)/(2*R*C) "Calculated characteristical parameter";
    Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
          transformation(
          origin={20,-50},
          extent={{-10,-10},{10,10}})));
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimted opAmp
      annotation (Placement(transformation(extent={{-50,10},{-30,-10}})));
    Modelica.Electrical.Analog.Basic.Resistor r(R=R)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Electrical.Analog.Basic.Resistor r2(R=R2, i(start=0)) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-20,-20})));
    Modelica.Electrical.Analog.Basic.Resistor r1(R=R1) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          origin={0,-40})));
    Modelica.Electrical.Analog.Basic.Capacitor c(C=C, v(start=VAmp, fixed=true))
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={40,-20})));
    Modelica.Electrical.Analog.Basic.Inductor l(L=L, i(fixed=true, start=0))
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={20,-20})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={60,-20})));
  equation
    connect(opAmp.out, r.p) annotation (Line(
        points={{-30,0},{-10,0}}, color={0,0,255}));
    connect(opAmp.out, r2.p) annotation (Line(
        points={{-30,0},{-20,0},{-20,-10}}, color={0,0,255}));
    connect(r2.n, r1.p) annotation (Line(
        points={{-20,-30},{-20,-40},{-10,-40}}, color={0,0,255}));
    connect(r2.n, opAmp.in_n) annotation (Line(
        points={{-20,-30},{-20,-40},{-60,-40},{-60,-6},{-50,-6}}, color={0,0,255}));
    connect(r1.n, ground.p) annotation (Line(
        points={{10,-40},{20,-40}}, color={0,0,255}));
    connect(r.n, opAmp.in_p) annotation (Line(
        points={{10,0},{20,0},{20,20},{-60,20},{-60,6},{-50,6}}, color={0,0,255}));
    connect(l.n, ground.p) annotation (Line(
        points={{20,-30},{20,-40}}, color={0,0,255}));
    connect(r.n, l.p) annotation (Line(
        points={{10,0},{20,0},{20,-10}}, color={0,0,255}));
    connect(c.p, l.p) annotation (Line(
        points={{40,-10},{20,-10}}, color={0,0,255}));
    connect(c.n, l.n) annotation (Line(
        points={{40,-30},{20,-30}}, color={0,0,255}));
    connect(ground.p, vOut.n) annotation (Line(
        points={{20,-40},{60,-40},{60,-30}}, color={0,0,255}));
    connect(r.n, vOut.p) annotation (Line(
        points={{10,0},{60,0},{60,-10}}, color={0,0,255}));
    annotation (Documentation(info=
                   "<html>
                       <p>This is an LC oscillator according to:</p>
                       <p>U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 14.1</p>
                       </html>"),
      experiment(
        StartTime=0,
        StopTime=0.01,
        Tolerance=0.0001,
        Interval=1e-005));
  end LCOscillator;
end OpAmps;
