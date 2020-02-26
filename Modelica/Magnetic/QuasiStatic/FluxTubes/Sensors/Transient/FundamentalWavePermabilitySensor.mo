within Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors.Transient;
model FundamentalWavePermabilitySensor
"Sensor of fundamental wave permeability"
  extends Modelica.Icons.RoundSensor;
  parameter SI.Frequency f "Fundamental wave frequency";
  parameter SI.Area A "Area of cross section";
  parameter SI.Length l "Length";

  Magnetic.FluxTubes.Interfaces.PositiveMagneticPort fluxP
    "Positive port of flux path" annotation (Placement(transformation(extent={{
            -110,-10},{-90,10}}), iconTransformation(extent={{-110,-10},{-90,10}})));
  Magnetic.FluxTubes.Interfaces.NegativeMagneticPort fluxN
    "Negative port of flux path" annotation (Placement(transformation(extent={{
            90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
  Magnetic.FluxTubes.Interfaces.PositiveMagneticPort potentialP
    "Positive port of magnetic potential difference path" annotation (Placement(
        transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={
            {-10,90},{10,110}})));
  Magnetic.FluxTubes.Interfaces.NegativeMagneticPort potentialN
    "Negative port of magnetic potential difference path" annotation (Placement(
        transformation(extent={{-10,-110},{10,-90}}), iconTransformation(extent=
           {{-10,-110},{10,-90}})));
  Magnetic.FluxTubes.Sensors.MagneticPotentialDifferenceSensor magneticPotentialDifferenceSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,30})));
  Magnetic.FluxTubes.Sensors.MagneticFluxSensor magneticFluxSensor
    annotation (Placement(transformation(extent={{40,-70},{60,-90}})));
  Modelica.Blocks.Math.Harmonic harmonicPotential(
    final f=f,
    final k=1,
    final x0Cos=0,
    final x0Sin=0) "Fundamental wave of magnetic potential difference"
                   annotation (Placement(
        transformation(extent={{40,20},{20,40}})));
  Modelica.Blocks.Math.Harmonic harmonicFlux(
    final f=f,
    final k=1,
    final x0Cos=0,
    final x0Sin=0) "Fundamental wave of magnetic flux"
                   annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        origin={30,-10})));
  Modelica.Blocks.Interfaces.RealOutput mu(unit="H/m") "Absolute permeability"
                   annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,-110})));
  Modelica.Blocks.Interfaces.RealOutput mur(unit="1") "Relative permeability"
                            annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-110})));
  Permeability permeability(final A=A, final l=l)
  "Determines relative and absolute permeability"
                            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-20,0})));
equation
  connect(magneticPotentialDifferenceSensor.port_n,
    potentialN) annotation (Line(
      points={{70,20},{70,-100},{0,-100}},
      color={255,170,85}));
  connect(magneticPotentialDifferenceSensor.port_p,
    potentialP) annotation (Line(
      points={{70,40},{70,100},{0,100}},
      color={255,170,85}));
  connect(magneticFluxSensor.port_p, fluxP)
    annotation (Line(
      points={{40,-80},{-100,-80},{-100,0}},
      color={255,170,85}));
  connect(magneticFluxSensor.port_n, fluxN)
    annotation (Line(
      points={{60,-80},{100,-80},{100,0}},
      color={255,170,85}));
  connect(harmonicFlux.u, magneticFluxSensor.Phi)
    annotation (Line(
      points={{42,-10},{50,-10},{50,-70}},
      color={0,0,127}));
  connect(magneticPotentialDifferenceSensor.V_m,
    harmonicPotential.u) annotation (Line(
      points={{60,30},{42,30}},
      color={0,0,127}));
  connect(permeability.V_m, harmonicPotential.y_rms)
    annotation (Line(
      points={{-8,6},{0,6},{0,36},{19,36}},
      color={0,0,127}));
  connect(permeability.Phi, harmonicFlux.y_rms)
    annotation (Line(
      points={{-8,-6},{0,-6},{0,-4},{19,-4}},
      color={0,0,127}));
  connect(permeability.mur, mur) annotation (Line(
      points={{-31,6},{-80,6},{-80,-110}},
      color={0,0,127}));
  connect(permeability.mu, mu) annotation (Line(
      points={{-31,-6},{-40,-6},{-40,-110}},
      color={0,0,127}));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=false), graphics={
        Text(
          extent={{-60,-60},{-20,-100}},
          textColor={64,64,64},
          textString="H/m"),
        Line(points={{-90,0},{90,0}}, color={255,128,0}),
        Line(points={{0,90},{0,70}}, color={255,128,0}),
        Line(points={{0,-70},{0,-90}}, color={255,128,0})}),
  Documentation(info="<html>
<p>
This sensor is used to determined the effective fundamental wave permeability of a saturated lumped circuit reluctance. For this purpose the sensor is placed such way that the magnetic flux and the magnetic potential difference of the investigated reluctance are sensed. The area of cross section and the effective length of the investigated magnetic path have to be provided as parameters.
</p>
<p>See example
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Examples.NonLinearInductor\">NonLinearInductor</a>.</p>
</html>"));
end FundamentalWavePermabilitySensor;
