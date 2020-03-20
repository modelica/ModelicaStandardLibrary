within Modelica.Electrical.PowerConverters.Examples.DCAC.PolyphaseTwoLevel;
model ThreePhaseTwoLevel_PWM "Test of pulse width modulation methods"
  extends Modelica.Icons.Example;
  import Modelica.Electrical.Polyphase.Functions.factorY2DC;
  import Modelica.Constants.pi;
  parameter Real RMS=1 "Reference RMS Y";
  Modelica.Blocks.Sources.Cosine cosine(f=2,
    phase=0,
    amplitude=RMS*sqrt(2))
    annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=cosine.amplitude,
    f=cosine.f,
    phase=cosine.phase)
    annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
  PowerConverters.DCAC.Control.PWM pwm(uMax=sqrt(2*3), f=100)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  PowerConverters.DCAC.Polyphase2Level multiPhase2Level
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage dcPos(V=pwm.uMax/2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,70})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage dcNeg(V=pwm.uMax/2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,30})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,50})));
  Modelica.Electrical.Polyphase.Sensors.PotentialSensor potentialSensor
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Math.Harmonic harmonic(f=cosine.f, k=1)
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.ToSpacePhasor toSpacePhasor
    annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.Rotator rotator
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Modelica.Blocks.Sources.Constant const(k=cosine.f)
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Modelica.Blocks.Continuous.Integrator integrator(k=2*pi)
    annotation (Placement(transformation(extent={{-30,-80},{-10,-60}})));
  Modelica.Blocks.Continuous.Filter filter[2](
    each init=Modelica.Blocks.Types.Init.InitialOutput,
    each analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
    y_start={cosine.amplitude,cosine.phase},
    each order=2,
    each f_cut=0.5*cosine.f)
    annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.ToPolar toPolar
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
equation
  connect(pwm.fire_p, multiPhase2Level.fire_p)
    annotation (Line(points={{-29,6},{-6,6},{-6,38}}, color={255,0,255}));
  connect(pwm.fire_n, multiPhase2Level.fire_n)
    annotation (Line(points={{-29,-6},{6,-6},{6,38}}, color={255,0,255}));
  connect(dcNeg.n, multiPhase2Level.dc_n) annotation (Line(points={{-40,20},
          {-20,20},{-20,44},{-10,44}},
                           color={0,0,255}));
  connect(dcPos.p, multiPhase2Level.dc_p) annotation (Line(points={{-40,80},
          {-20,80},{-20,56},{-10,56}},
                           color={0,0,255}));
  connect(dcPos.n, ground.p)
    annotation (Line(points={{-40,60},{-40,50}}, color={0,0,255}));
  connect(ground.p, dcNeg.p)
    annotation (Line(points={{-40,50},{-40,40}}, color={0,0,255}));
  connect(cosine.y, pwm.u[1]) annotation (Line(points={{-69,20},{-60,20},{-60,
          -1},{-52,-1}}, color={0,0,127}));
  connect(sine.y, pwm.u[2]) annotation (Line(points={{-69,-20},{-60,-20},{-60,
          1},{-52,1}}, color={0,0,127}));
  connect(multiPhase2Level.ac, potentialSensor.plug_p)
    annotation (Line(points={{10,50},{20,50}}, color={0,0,255}));
  connect(toSpacePhasor.y, rotator.u)
    annotation (Line(points={{-9,-40},{-2,-40}},   color={0,0,127}));
  connect(potentialSensor.phi, toSpacePhasor.u) annotation (Line(points={{41,50},
          {50,50},{50,-20},{-40,-20},{-40,-40},{-32,-40}}, color={0,0,127}));
  connect(const.y, integrator.u)
    annotation (Line(points={{-39,-70},{-32,-70}}, color={0,0,127}));
  connect(integrator.y, rotator.angle)
    annotation (Line(points={{-9,-70},{10,-70},{10,-52}},color={0,0,127}));
  connect(potentialSensor.phi[1], harmonic.u)
    annotation (Line(points={{41,50},{58,50}}, color={0,0,127}));
  connect(rotator.y, filter.u)
    annotation (Line(points={{21,-40},{28,-40}}, color={0,0,127}));
  connect(filter.y, toPolar.u)
    annotation (Line(points={{51,-40},{58,-40}}, color={0,0,127}));
  annotation (experiment(
      StopTime=2,
      Interval=0.001,
      Tolerance=1e-05),
    Documentation(info="<html>
<p>
A reference space vector (formed by real part = cosine and imaginary part = sine) of length &radic;2*RMS and frequency 2 Hz is applied.
The resulting switching patterns are applied to a three-phase twolevel bridge with switching frequency 100 Hz, fed by DC voltage = &radic;2*&radic;3*1
where 1 is the theoretical maximum voltage from terminal to neutral.
The resulting voltages with reference to midpoint of the DC voltage are measured.
</p>
<p>
The RMS of the first harmonic of the first of these voltages is calculated.
Please note that the value of the first harmonic is valid after the first period (i.e. 0.5 s).
</p>
<p>
Furthermore, these three voltages are transformed to the corresponding space phasor.
Note that the zero component is not zero, indicating the shift of the neutral with respect to the midpoint of the DC voltage.
</p>
<p>
The space phasor is rotated to the coordinate system rotating with 2*&pi;*2 Hz.
To suppress the influence of switching, real and imaginary part of the rotated phasor are filtered.
The polar representation of this rotated and filtered phasor are calculated.
</p>
<p>
Please note that the filter has a settle time depending on the filter parameters.
</p>
</html>"));
end ThreePhaseTwoLevel_PWM;
