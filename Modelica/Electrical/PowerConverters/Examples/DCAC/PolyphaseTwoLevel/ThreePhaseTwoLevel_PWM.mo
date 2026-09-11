within Modelica.Electrical.PowerConverters.Examples.DCAC.PolyphaseTwoLevel;
model ThreePhaseTwoLevel_PWM "Test of pulse width modulation methods"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Voltage V_LL=400 "RMS line-to-line voltage";
  parameter SI.Voltage V_DC=sqrt(2)*V_LL "Ideal DC volatge";
  parameter SI.Voltage Vmax=V_DC/sqrt(3) "Max. output voltage";
  parameter SI.Frequency f_sw=2500 "Switching frequency";
  parameter SI.Voltage VNom=V_LL/sqrt(3) "Nominal RMS voltage";
  parameter SI.Frequency fNom=50 "Nominal frequency";
  parameter SI.Frequency fRef=50 "Reference frequency";
  Modelica.Blocks.Sources.Constant refFrequ(k=fRef)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Electrical.Machines.Utilities.VfController vfController(
    VNominal=VNom, fNominal=fNom, BasePhase=pi/2)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.ToSpacePhasor toSpacePhasorRef
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Electrical.PowerConverters.DCAC.Control.PWM pwm(
    pwmType=Modelica.Electrical.PowerConverters.Types.PWMType.SVPWM,
    uMax=Vmax, f=f_sw)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,20})));
  Modelica.Electrical.PowerConverters.DCAC.Polyphase2Level multiPhase2Level
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage dcPos(V=V_DC/2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,70})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage dcNeg(V=V_DC/2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,30})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,50})));
  Modelica.Electrical.Polyphase.Sensors.PotentialSensor potentialSensor
    annotation (Placement(transformation(extent={{30,40},{50,60}})));
  Modelica.Blocks.Math.Harmonic harmonic(f=fRef, k=1)
    annotation (Placement(transformation(extent={{70,40},{90,60}})));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.ToSpacePhasor toSpacePhasor
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Blocks.Sources.RealExpression rotationAngle(y=vfController.x)
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.Rotator rotator
    annotation (Placement(transformation(extent={{10,-50},{30,-30}})));
  Modelica.Blocks.Continuous.Filter filter2[2](
    each init=Modelica.Blocks.Types.Init.InitialOutput,
    each analogFilter=Modelica.Blocks.Types.AnalogFilter.Bessel,
    y_start={VNom*sqrt(2),0},
    each order=2,
    each f_cut=0.5*fRef)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.ToPolar toPolar
    annotation (Placement(transformation(extent={{70,-50},{90,-30}})));
equation
  connect(pwm.fire_p, multiPhase2Level.fire_p)
    annotation (Line(points={{4,31},{4,38}},          color={255,0,255}));
  connect(pwm.fire_n, multiPhase2Level.fire_n)
    annotation (Line(points={{16,31},{16,38}},        color={255,0,255}));
  connect(dcNeg.n, multiPhase2Level.dc_n) annotation (Line(points={{-30,20},{
          -10,20},{-10,44},{0,44}},
                           color={0,0,255}));
  connect(dcPos.p, multiPhase2Level.dc_p) annotation (Line(points={{-30,80},{
          -10,80},{-10,56},{0,56}},
                           color={0,0,255}));
  connect(dcPos.n, ground.p)
    annotation (Line(points={{-30,60},{-30,50}}, color={0,0,255}));
  connect(ground.p, dcNeg.p)
    annotation (Line(points={{-30,50},{-30,40}}, color={0,0,255}));
  connect(multiPhase2Level.ac, potentialSensor.plug_p)
    annotation (Line(points={{20,50},{30,50}}, color={0,0,255}));
  connect(toSpacePhasor.y, rotator.u)
    annotation (Line(points={{1,-40},{8,-40}},     color={0,0,127}));
  connect(potentialSensor.phi, toSpacePhasor.u) annotation (Line(points={{51,50},
          {60,50},{60,-20},{-30,-20},{-30,-40},{-22,-40}}, color={0,0,127}));
  connect(potentialSensor.phi[1], harmonic.u)
    annotation (Line(points={{51,50},{68,50}}, color={0,0,127}));
  connect(rotator.y, filter2.u)
    annotation (Line(points={{31,-40},{38,-40}}, color={0,0,127}));
  connect(filter2.y, toPolar.u)
    annotation (Line(points={{61,-40},{68,-40}}, color={0,0,127}));
  connect(pwm.u, toSpacePhasorRef.y)
    annotation (Line(points={{10,8},{10,0},{-9,0}},
                                               color={0,0,127}));
  connect(vfController.y, toSpacePhasorRef.u)
    annotation (Line(points={{-39,0},{-32,0}}, color={0,0,127}));
  connect(refFrequ.y, vfController.u)
    annotation (Line(points={{-69,0},{-62,0}}, color={0,0,127}));
  connect(rotationAngle.y, rotator.angle)
    annotation (Line(points={{-39,-60},{20,-60},{20,-52}}, color={0,0,127}));
  annotation (experiment(
      StopTime=0.1,
      Interval=0.001,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>
A reference space vector (formed by a vfController and a transformation to space phasor) is applied.
The resulting switching patterns are applied to a three-phase twolevel bridge, fed by DC voltage.
The resulting voltages with reference to midpoint of the DC voltage are measured.
</p>
<p>
The RMS of the first harmonic of the first of these voltages is calculated.
Please note that the value of the first harmonic is valid after the first period.
</p>
<p>
Furthermore, these three voltages are transformed to the corresponding space phasor.
Note that the zero component is not zero, indicating the shift of the neutral with respect to the midpoint of the DC voltage.
</p>
<p>
The space phasor is rotated to the coordinate system rotating with reference frequency.
To suppress the influence of switching, real and imaginary part of the rotated phasor are filtered.
The polar representation of this rotated and filtered phasor are calculated.
</p>
<p>
Please note that the filter has a settle time depending on the filter parameters and causes a delay (phase shift).
</p>
<h4>Note</h4>
<p>
Intersective PWM without additional measures (e.g. over-modulation or injection of 3<sup>rd</sup> harmonic) achieves lower voltages (&radic;3 / 2) 
than space vector PWM, in this example 200 V RMS comapred to 230.94 V RMS.
</p>
</html>"));
end ThreePhaseTwoLevel_PWM;
