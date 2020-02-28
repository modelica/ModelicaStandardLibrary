within Modelica.Magnetic.QuasiStatic.FluxTubes.Examples.BasicExamples;
model ToroidalCoreQuadraticCrossSection "Educational example: iron core with airgap"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Length r_o=0.055 "Outer radius of iron core";
  parameter SI.Length r_i=0.045 "Inner radius of iron core";
  parameter SI.Length l=0.01 "Length of rectangular cross section";
  parameter SI.RelativePermeability mu_r=1000 "Relative permeability of core";
  parameter SI.Length delta=0.001 "Length of airgap";
  parameter SI.Angle alpha=(1 - delta/(2*pi*(r_o + r_i)/2))*2*pi "Section angle of toroidal core";
  parameter Integer N=500 "Number of exciting coil turns";
  parameter SI.Current I=1.5 "Maximum exciting current";
  Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.ElectroMagneticConverter excitingCoil(N=N)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape.HollowCylinderCircumferentialFlux core(
    mu_rConst=mu_r,
    l=l,
    r_i=r_i,
    r_o=r_o,
    alpha=alpha) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        origin={0,30})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape.HollowCylinderCircumferentialFlux airGap(
    mu_rConst=1,
    l=l,
    r_i=r_i,
    r_o=r_o,
    alpha=2*pi - alpha) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,-50})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.ElectroMagneticConverter measuringCoil(N=1)
    annotation (Placement(transformation(extent={{40,-10},{20,10}})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.Ground magneticGround
    annotation (Placement(transformation(extent={{-30,-70},{-10,-50}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground electricGround1
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VariableCurrentSource currentSource(gamma(fixed=true, start=0)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,0})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors.MagneticFluxSensor magFluxSensor
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-20,-30})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground electricGround2
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageSensor voltageSensor annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={60,0})));
  Blocks.Sources.Constant const(k=50) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,30})));
  ComplexBlocks.Sources.ComplexRampPhasor complexRamp(
    magnitude1=0,
    magnitude2=I,
    phi=0,
    startTime=0.01,
    duration=0.015) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-30})));
equation
  connect(excitingCoil.port_n, magFluxSensor.port_n)
    annotation (Line(points={{-20,-10},{-20,-20}}, color={255,127,0}));
  connect(magFluxSensor.port_p, magneticGround.port)
    annotation (Line(points={{-20,-40},{-20,-50}}, color={255,127,0}));
  connect(magneticGround.port, airGap.port_n)
    annotation (Line(points={{-20,-50},{-10,-50}}, color={255,127,0}));
  connect(excitingCoil.port_p, core.port_p)
    annotation (Line(points={{-20,10},{-20,30},{-10,30}}, color={255,127,0}));
  connect(currentSource.pin_n, excitingCoil.pin_p) annotation (Line(points={{-60,10},{-40,10}}, color={85,170,255}));
  connect(currentSource.pin_p, electricGround1.pin) annotation (Line(points={{-60,-10},{-50,-10}}, color={85,170,255}));
  connect(electricGround1.pin, excitingCoil.pin_n) annotation (Line(points={{-50,-10},{-40,-10}}, color={85,170,255}));
  connect(electricGround2.pin, voltageSensor.pin_n) annotation (Line(points={{50,-10},{60,-10}}, color={85,170,255}));
  connect(const.y, currentSource.f) annotation (Line(points={{-80,19},{-80,6},{-72,6}}, color={0,0,127}));
  connect(complexRamp.y, currentSource.I) annotation (Line(points={{-80,-19},{-80,-6},{-72,-6}}, color={85,170,255}));
  connect(measuringCoil.pin_n, electricGround2.pin) annotation (Line(points={{40,-10},{50,-10}}, color={85,170,255}));
  connect(measuringCoil.pin_p, voltageSensor.pin_p) annotation (Line(points={{40,10},{50,10},{50,10},{60,10}}, color={85,170,255}));
  connect(core.port_n, measuringCoil.port_p) annotation (Line(points={{10,30},{20,30},{20,10}}, color={255,170,85}));
  connect(airGap.port_p, measuringCoil.port_n) annotation (Line(points={{10,-50},{20,-50},{20,-10}}, color={255,170,85}));
  annotation (Documentation(info="<html>
<p>
Educational example of a magnetic circuit containing a toroidal iron core with rectangular cross section and an airgap:
</p>
<p>
A current ramp is applied in positive electric direction through the exciting coil, causing a rising magnetomotive force (mmf) in positive magnetic direction of the electromagnetic converter.
The mmf in turn causes a magnetic flux through the circuit in the direction indicated by the flux sensor.
From that magnetic flux, flux density can be calculated in every element of the magnetic circuit. Flux density is used to derive magnetic field strength.
Magnetic field strength times length of the flux line gives magnetic potential difference of each element.
The sum of all magnetic potential differences is covered by the mmf of the exciting coil.
</p>
<p>
Using the values shown in section Parameters, the results can be validated easily by analytic calculations:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>element   </th><th>cross section</th><th>length                         </th><th>rel. permeability </th><th>B                   </th><th>H                                    </th><th>mmf              </th></tr>
<tr><td>core      </td><td>(r_o - r_i)*l</td><td>(r_o + r_i)/2*alpha             </td><td>&mu;<sub>r</sub>  </td><td>flux / cross section</td><td>B/(&mu;<sub>r</sub>*&mu;<sub>0</sub>)</td><td>H*length         </td></tr>
<tr><td>airgap    </td><td>(r_o - r_i)*l</td><td>delta=(r_o + r_i)/2*(2*pi-alpha)</td><td>1</td><td>flux / cross section</td><td>B/(&mu;<sub>0</sub>)</td><td>H*delta         </td></tr>
<tr><td>total     </td><td>             </td><td>                               </td><td>                  </td><td>                    </td><td>                                     </td><td>&Sigma; mmf = N*I</td></tr>
</table>
<p>
Note that since no leakage is present, the magnetic flux is the same in every element - they are connected in series.
For calculation of the length of flux lines, a medium flux line is used.
</p>
<p>
Additionally, a measuring coil is placed in the airgap.
Due to Faraday's law, the time derivative of flux causes an induced voltage both in the exciting coil (in positive direction) and in the measuring coil (in negative direction).
Since the quasi static current and therefore flux follow a time dependent ramp, the quasi static induced voltages follow a ramp as well.
</p>
<p>
Note the proper usage of electric and magnetic grounds to define zero potential.
</p>
</html>"), experiment(StopTime=0.05, Interval=0.0001));
end ToroidalCoreQuadraticCrossSection;
