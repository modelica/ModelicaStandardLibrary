within Modelica.Magnetic.FluxTubes.Examples.BasicExamples;
model ShowMaterial "Show material characteristic"
  extends Modelica.Icons.Example;
  parameter SI.Current I=1 "Peak exciting current";
  SI.MagneticFieldStrength H=coreNon_Hys.H "Magnetic field strength";
  SI.MagneticPolarization J=coreNon_Hys.B - mu_0*H "Magnetic polarization";
  SI.RelativePermeability mu_r=coreNon_Hys.mu_r "Relative permeability";
  SI.MagneticPolarization J_rD=combiTable1Ds.y[1] "Magnetic polarization from raw data";
  SI.RelativePermeability mu_r_rD=combiTable1Ds.y[2] "Relative permability from raw data";
  Modelica.Electrical.Analog.Sources.SineCurrent source(I=I, f=50) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,0})));
  Modelica.Electrical.Analog.Basic.Ground groundE1
    annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
  Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter excitingCoil(N=700)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}},rotation=0)));
  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube
                                    coreNon_Hys(
    magnetization=Modelica.Magnetic.FluxTubes.Types.Magnetization.Macfadyen,
    material=
        Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet.M330_50A(),
    materialMacfadyen=
        Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.Macfadyen.M330_50A(),
    materialTableBased=
        Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData.M330_50A(),
    area=0.000112,
    l=0.94,
    mu_rConst=1000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-20,10})));
  Modelica.Magnetic.FluxTubes.Basic.Ground groundM
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
  Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter measurementCoil(N=700)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={10,0})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,0})));
  Modelica.Blocks.Continuous.Integrator integrator(k=1/measurementCoil.N)
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Modelica.Electrical.Analog.Basic.Ground groundE2
    annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  Modelica.Blocks.Math.Harmonic harmonic1(f=source.f, k=1)
    annotation (Placement(transformation(extent={{70,-40},{90,-20}})));
  Modelica.Blocks.Math.Harmonic harmonic3(f=source.f, k=3)
    annotation (Placement(transformation(extent={{70,-70},{90,-50}})));
  Modelica.Magnetic.FluxTubes.Sensors.MagneticPotentialDifferenceSensor
    magVoltageSensor
    annotation (Placement(transformation(extent={{-30,40},{-10,20}})));
  Modelica.Blocks.Math.Gain gain(k=1/coreNon_Hys.l)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  parameter Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData.M330_50A
    material annotation (Placement(transformation(extent={{20,70},{40,90}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(
    table=material.table,
    smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative2,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
equation
  connect(source.p, groundE1.p)
    annotation (Line(points={{-80,-10},{-80,-20}}, color={0,0,255}));
  connect(source.n, excitingCoil.p)
    annotation (Line(points={{-80,10},{-60,10}}, color={0,0,255}));
  connect(source.p, excitingCoil.n)
    annotation (Line(points={{-80,-10},{-60,-10}}, color={0,0,255}));
  connect(excitingCoil.port_p, coreNon_Hys.port_p)
    annotation (Line(points={{-40,10},{-30,10}},
                                               color={255,127,0}));
  connect(coreNon_Hys.port_n, measurementCoil.port_p)
    annotation (Line(points={{-10,10},{0,10}}, color={255,127,0}));
  connect(measurementCoil.port_n, groundM.port)
    annotation (Line(points={{0,-10},{-20,-10},{-20,-20}}, color={255,127,0}));
  connect(excitingCoil.port_n, groundM.port) annotation (Line(points={{-40,-10},
          {-20,-10},{-20,-20}}, color={255,127,0}));
  connect(voltageSensor.v, integrator.u)
    annotation (Line(points={{51,0},{68,0}}, color={0,0,127}));
  connect(measurementCoil.n, groundE2.p)
    annotation (Line(points={{20,-10},{20,-20}}, color={0,0,255}));
  connect(measurementCoil.n, voltageSensor.p)
    annotation (Line(points={{20,-10},{40,-10}}, color={0,0,255}));
  connect(measurementCoil.p, voltageSensor.n)
    annotation (Line(points={{20,10},{40,10}}, color={0,0,255}));
  connect(voltageSensor.v, harmonic1.u) annotation (Line(points={{51,0},{60,0},
          {60,-30},{68,-30}}, color={0,0,127}));
  connect(voltageSensor.v, harmonic3.u) annotation (Line(points={{51,0},{60,0},
          {60,-60},{68,-60}},                 color={0,0,127}));
  connect(magVoltageSensor.port_p, coreNon_Hys.port_p)
    annotation (Line(points={{-30,30},{-30,10}}, color={255,127,0}));
  connect(magVoltageSensor.port_n, coreNon_Hys.port_n)
    annotation (Line(points={{-10,30},{-10,10}}, color={255,127,0}));
  connect(magVoltageSensor.V_m, gain.u)
    annotation (Line(points={{-20,40},{-20,50},{-12,50}}, color={0,0,127}));
  connect(gain.y, combiTable1Ds.u)
    annotation (Line(points={{11,50},{18,50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=0.1,
      Interval=1e-05,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>
This example demonstrates how to show the characteristics <code>J(H)</code> and <code>mu_r(H)</code> of a material 
by applying a sinusoidal excitation current to the exciting coil. 
However, hysteresis is not taken into account.
</p>
<p>
Number of turns and measurements of the core are approximately as they would be of an Epstein frame.
</p>
<p>
It is possible to compare the approximation with interpolated data from a manufacturer's datasheet (raw Data)  <code>J_rD</code> and <code>mu_r_rD</code> for material = <code>M330_50A</code>.
</p>
<p>
Note the non-sinusoidal trajectory of voltage <code>excitingCoil.v</code> due to saturation and a sonusoidal excitation current.
</p>
<p>
Note that the output of the integrated voltage (divided by the number of turns of the measurement coil) shows the magnetic flux in the core. 
To achieve satisfying accuracy, a rather small tolerance has to be used. 
</p>
</html>"));
end ShowMaterial;
