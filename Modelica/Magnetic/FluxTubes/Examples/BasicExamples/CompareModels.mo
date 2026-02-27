within Modelica.Magnetic.FluxTubes.Examples.BasicExamples;
model CompareModels "Compare non-hysteretic model and Tellinen/Everett"
  extends Modelica.Icons.Example;
  parameter SI.Current I=1 "Excitation peak current";
  SI.MagneticFieldStrength H1=coreNon_Hys.H "Field Strength in non-hysteretic core";
  SI.MagneticFluxDensity B1=coreNon_Hys.B "Flux Density in non-hysteretic core";
  SI.MagneticPolarization J1=B1 - mu_0*H1 "Magnetic polarisation in non-hysteretic core";
  SI.MagneticFieldStrength H2=coreEverett.H "Field Strength in hysteretic core = H1";
  SI.MagneticFluxDensity B2=coreEverett.B "Flux Density in hysteretic core";
  SI.MagneticPolarization J2=B2 - mu_0*H2 "Magnetic polarisation in hysteretic core";
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent1 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,50})));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent2 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-50})));
  Modelica.Electrical.Analog.Basic.Ground groundE1
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Electrical.Analog.Basic.Ground groundE2
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter excitingCoil1(N=700)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={20,50})));
  Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter excitingCoil2(N=700)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={20,-50})));
  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube
                                    coreNon_Hys(
    magnetization=Modelica.Magnetic.FluxTubes.Types.Magnetization.Macfadyen,
    mu_rConst=1000,
    material=
        Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet.M330_50A(),
    materialMacfadyen=
        Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.Macfadyen.M330_50A(),
    area=0.000112,
    l=0.94) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,50})));
  Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenEverett
    coreEverett(
    mat=Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter.M330_50A(),
    l=0.94,
    A=0.000112,
    MagRel(fixed=true))
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,-50})));
  Modelica.Magnetic.FluxTubes.Basic.Ground groundM1
    annotation (Placement(transformation(extent={{30,10},{50,30}})));
  Modelica.Magnetic.FluxTubes.Basic.Ground groundM2
    annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=I, f=50) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,0})));
equation
  connect(signalCurrent1.p, groundE1.p)
    annotation (Line(points={{0,40},{0,30}}, color={0,0,255}));
  connect(signalCurrent2.p, groundE2.p)
    annotation (Line(points={{0,-60},{0,-70}}, color={0,0,255}));
  connect(signalCurrent1.n, excitingCoil1.p)
    annotation (Line(points={{0,60},{10,60}}, color={0,0,255}));
  connect(signalCurrent1.p, excitingCoil1.n)
    annotation (Line(points={{0,40},{10,40}}, color={0,0,255}));
  connect(signalCurrent2.n, excitingCoil2.p)
    annotation (Line(points={{0,-40},{10,-40}}, color={0,0,255}));
  connect(signalCurrent2.p, excitingCoil2.n)
    annotation (Line(points={{0,-60},{10,-60}}, color={0,0,255}));
  connect(coreNon_Hys.port_n, groundM1.port)
    annotation (Line(points={{40,40},{40,30}}, color={255,127,0}));
  connect(excitingCoil1.port_n, coreNon_Hys.port_n)
    annotation (Line(points={{30,40},{40,40}}, color={255,127,0}));
  connect(excitingCoil1.port_p, coreNon_Hys.port_p)
    annotation (Line(points={{30,60},{40,60}}, color={255,127,0}));
  connect(coreEverett.port_n, groundM2.port)
    annotation (Line(points={{40,-60},{40,-70}}, color={255,127,0}));
  connect(excitingCoil2.port_n, coreEverett.port_n)
    annotation (Line(points={{30,-60},{40,-60}}, color={255,127,0}));
  connect(excitingCoil2.port_p, coreEverett.port_p)
    annotation (Line(points={{30,-40},{40,-40}}, color={255,127,0}));
  connect(sine.y, signalCurrent1.i) annotation (Line(points={{-39,0},{-20,0},{-20,
          50},{-12,50}}, color={0,0,127}));
  connect(sine.y, signalCurrent2.i) annotation (Line(points={{-39,0},{-20,0},{-20,
          -50},{-12,-50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=0.1,
      Interval=1e-05,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>
This model compares the magnetization characteristic of a non-hysteretic model with a Tellinen/Everett-model including hysteresis, both for M330-50A. 
</p>
<p>
Plot <code>B1</code> (flux density of the non-hysteretic model) and <code>B1</code> (flux density of the hysteretic model) 
versus <code>H1</code> (field strength, which is the same as <code>H2</code> due to the same geometry of the core and the same excitation).
Try different excitation peak currents <code>I</code>.
</p>
</html>"));
end CompareModels;
