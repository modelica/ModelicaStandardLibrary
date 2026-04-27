within Modelica.Magnetic.FluxTubes.Examples.BasicExamples;
model EIcore "An iron core with shape E and I"
  extends Modelica.Icons.Example;
  parameter SI.Length delta=0.5e-3 "Air gap";
  parameter SI.Current I=5 "Excitation current";
  parameter Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.MaterialSettings
    materialSettings(magnetization=Modelica.Magnetic.FluxTubes.Types.Magnetization.Macfadyen,
      materialMacfadyen=
        Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.Macfadyen.M330_50A())
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.Cuboid yokeUL(
    nonLinearPermeability=materialSettings.nonLinearPermeability,
    mu_rConst=materialSettings.mu_rConst,
    magnetization=materialSettings.magnetization,
    material=materialSettings.material,
    materialMacfadyen=materialSettings.materialMacfadyen,
    l(displayUnit="mm") = 0.075,
    a(displayUnit="mm") = 0.04,
    b(displayUnit="mm") = 0.02)
          "Upper Left yoke"  annotation (Placement(transformation(extent={{-40,90},{-60,70}})));
  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.Cuboid yokeUR(
    nonLinearPermeability=materialSettings.nonLinearPermeability,
    mu_rConst=materialSettings.mu_rConst,
    magnetization=materialSettings.magnetization,
    material=materialSettings.material,
    materialMacfadyen=materialSettings.materialMacfadyen,
    l(displayUnit="mm") = 0.075,
    a(displayUnit="mm") = 0.04,
    b(displayUnit="mm") = 0.02)
          "Upper RIght yoke"  annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.Cuboid yokeLL(
    nonLinearPermeability=materialSettings.nonLinearPermeability,
    mu_rConst=materialSettings.mu_rConst,
    magnetization=materialSettings.magnetization,
    material=materialSettings.material,
    materialMacfadyen=materialSettings.materialMacfadyen,
    l(displayUnit="mm") = 0.075,
    a(displayUnit="mm") = 0.04,
    b(displayUnit="mm") = 0.02)
          "Lower Left yoke"  annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.Cuboid yokeLR(
    nonLinearPermeability=materialSettings.nonLinearPermeability,
    mu_rConst=materialSettings.mu_rConst,
    magnetization=materialSettings.magnetization,
    material=materialSettings.material,
    materialMacfadyen=materialSettings.materialMacfadyen,
    l(displayUnit="mm") = 0.075,
    a(displayUnit="mm") = 0.04,
    b(displayUnit="mm") = 0.02)
          "Lower Right yoke"  annotation (Placement(transformation(extent={{60,-90},{40,-70}})));
  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.Cuboid legL(
    nonLinearPermeability=materialSettings.nonLinearPermeability,
    mu_rConst=materialSettings.mu_rConst,
    magnetization=materialSettings.magnetization,
    material=materialSettings.material,
    materialMacfadyen=materialSettings.materialMacfadyen,
    l(displayUnit="mm") = 0.1,
    a(displayUnit="mm") = 0.04,
    b(displayUnit="mm") = 0.02)
          "Left leg" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-80,0})));
  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.Cuboid legR(
    nonLinearPermeability=materialSettings.nonLinearPermeability,
    mu_rConst=materialSettings.mu_rConst,
    magnetization=materialSettings.magnetization,
    material=materialSettings.material,
    materialMacfadyen=materialSettings.materialMacfadyen,
    l(displayUnit="mm") = 0.1,
    a(displayUnit="mm") = 0.04,
    b(displayUnit="mm") = 0.02)
          "Right leg" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={80,0})));
  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.Cuboid legM(
    nonLinearPermeability=materialSettings.nonLinearPermeability,
    mu_rConst=materialSettings.mu_rConst,
    magnetization=materialSettings.magnetization,
    material=materialSettings.material,
    materialMacfadyen=materialSettings.materialMacfadyen,
    l(displayUnit="mm") = 0.1 - delta,
    a(displayUnit="mm") = 0.04,
    b(displayUnit="mm") = 0.04)
          "Middle leg" annotation (Placement(transformation(extent={{10,10},{-10,
            -10}}, rotation=270)));
  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.Cuboid airgap(
    nonLinearPermeability=false,
    mu_rConst=1,
    l(displayUnit="mm") = delta,
    a(displayUnit="mm") = 0.04,
    b(displayUnit="mm") = 0.04)
          "Airgap" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={0,-30})));
  Modelica.Magnetic.FluxTubes.Basic.Ground groundM
    annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
  Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter coil(N=100)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Electrical.Analog.Sources.SineCurrent sineCurrent(I=I, f=10)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,30})));
  Modelica.Electrical.Analog.Basic.Ground groundE
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Modelica.Magnetic.FluxTubes.Sensors.MagneticFluxSensor magFluxSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-60})));
  Modelica.Blocks.Math.Gain fluxDensity(k=1/(airgap.a*airgap.b))
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
equation
  connect(coil.port_p, yokeUL.port_p)
    annotation (Line(points={{0,40},{0,80},{-40,80}}, color={255,127,0}));
  connect(yokeUL.port_n, legL.port_p)
    annotation (Line(points={{-60,80},{-80,80},{-80,10}}, color={255,127,0}));
  connect(legL.port_n, yokeLL.port_p) annotation (Line(points={{-80,-10},{-80,-80},
          {-60,-80}}, color={255,127,0}));
  connect(yokeLL.port_n, groundM.port)
    annotation (Line(points={{-40,-80},{0,-80}}, color={255,127,0}));
  connect(groundM.port, yokeLR.port_n)
    annotation (Line(points={{0,-80},{40,-80}}, color={255,127,0}));
  connect(yokeLR.port_p, legR.port_n)
    annotation (Line(points={{60,-80},{80,-80},{80,-10}}, color={255,127,0}));
  connect(legR.port_p, yokeUR.port_n)
    annotation (Line(points={{80,10},{80,80},{60,80}}, color={255,127,0}));
  connect(yokeUR.port_p, yokeUL.port_p)
    annotation (Line(points={{40,80},{-40,80}}, color={255,127,0}));
  connect(coil.port_n, legM.port_n)
    annotation (Line(points={{0,20},{0,10}}, color={255,127,0}));
  connect(legM.port_p, airgap.port_n)
    annotation (Line(points={{0,-10},{0,-20}}, color={255,127,0}));
  connect(sineCurrent.n, coil.p)
    annotation (Line(points={{-60,40},{-20,40}}, color={0,0,255}));
  connect(sineCurrent.p,groundE. p)
    annotation (Line(points={{-60,20},{-40,20}}, color={0,0,255}));
  connect(groundE.p, coil.n)
    annotation (Line(points={{-40,20},{-20,20}}, color={0,0,255}));
  connect(magFluxSensor.Phi, fluxDensity.u)
    annotation (Line(points={{10,-60},{18,-60}}, color={0,0,127}));
  connect(magFluxSensor.port_p, groundM.port)
    annotation (Line(points={{0,-70},{0,-80}}, color={255,127,0}));
  connect(airgap.port_p, magFluxSensor.port_n)
    annotation (Line(points={{0,-40},{0,-50}}, color={255,127,0}));
  annotation (experiment(
      Interval=0.0001,
      Tolerance=1e-06), Documentation(info="<html>
<p>
This is a core shaped as an E and an I with an airgap. 
</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 1:</strong> EI - core</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/BasicExamples/EIcore.png\">
    </td>
  </tr>
</table>
<p>
You might vary different parameters:
</p>
<ul>
<li>The current amplitude <code>I</code></li>
<li>The length of the airgap <code>delta</code></li>
<li>The material for all shapes at once via the record <code>materialSettings</code></li>
</ul>
</html>"));
end EIcore;
