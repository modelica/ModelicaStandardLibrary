within Modelica.Magnetic.FluxTubes.Examples.BasicExamples;
model SaturatedInductor "Inductor with saturation in the ferromagnetic core"
  extends Modelica.Icons.Example;

  FluxTubes.Basic.Ground ground_m annotation (Placement(transformation(
          extent={{50,-30},{70,-10}})));
  Modelica.Electrical.Analog.Sources.SineVoltage source(
    f=50,
    phase=pi/2,
    V=230*sqrt(2)) "Voltage applied to inductor" annotation (Placement(
        transformation(
        origin={-80,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor r(R=7.5)
    "Inductor coil resistance" annotation (Placement(transformation(extent=
            {{-61,10},{-41,30}})));
  FluxTubes.Basic.ElectroMagneticConverter coil(N=600, i(fixed=true))
    "Inductor coil" annotation (Placement(transformation(extent={{-30,0},{-10,
            20}})));
  Basic.ConstantReluctance r_mLeak(R_m=1.2e6) "Constant leakage reluctance"
    annotation (Placement(transformation(
        origin={10,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Shapes.FixedShape.Cuboid r_mAirPar(
    a=0.025,
    b=0.025,
    nonLinearPermeability=false,
    mu_rConst=1,
    l=0.0001)
    "Reluctance of small parasitic air gap (ferromagnetic core packeted from single sheets)"
    annotation (Placement(transformation(extent={{26,10},{46,30}})));
  Shapes.FixedShape.Cuboid r_mFe(
    mu_rConst=1000,
    a=0.025,
    b=0.025,
    nonLinearPermeability=true,
    l=4*0.065,
    material=
        Material.SoftMagnetic.ElectricSheet.M350_50A(),
    B(start=0)) "Reluctance of ferromagnetic inductor core" annotation (
      Placement(transformation(
        origin={60,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-90,-30},{-70,-10}})));

equation
  connect(source.p, r.p)
    annotation (Line(points={{-80,20},{-61,20}}, color={0,0,255}));
  connect(r.n, coil.p) annotation (Line(points={{-41,20},{-30,20},{-30,20}}, color={0,0,255}));
  connect(source.n, coil.n)
    annotation (Line(points={{-80,0},{-30,0},{-30,0}}, color={0,0,255}));
  connect(coil.port_p, r_mLeak.port_p) annotation (Line(points={{-10,20},{-10,20},{10,20}},
                            color={255,127,0}));
  connect(r_mLeak.port_p, r_mAirPar.port_p)
    annotation (Line(points={{10,20},{26,20}}, color={255,127,0}));
  connect(r_mAirPar.port_n, r_mFe.port_p)
    annotation (Line(points={{46,20},{54,20},{60,20}}, color={255,127,0}));
  connect(r_mFe.port_n, r_mLeak.port_n) annotation (Line(points={{60,0},{
          47.5,0},{35,0},{10,0}}, color={255,127,0}));
  connect(r_mFe.port_n, coil.port_n)
    annotation (Line(points={{60,0},{-10,0},{-10,0}}, color={255,127,0}));
  connect(ground.p, source.n) annotation (Line(
      points={{-80,-10},{-80,0}}, color={0,0,255}));
  connect(ground_m.port, r_mFe.port_n) annotation (Line(
      points={{60,-10},{60,0}}, color={255,127,0}));
  annotation (experiment(StopTime=0.1, Tolerance=1e-007), Documentation(
        info="<html>
<p>
This model demonstrates the effects of non-linear magnetisation characteristics of soft magnetic materials (hysteresis neglected). A sinusoidal voltage is applied to an inductor with a closed ferromagnetic core of rectangular shape. Set the <strong>tolerance</strong> to <strong>1e-7</strong>, <strong>simulate for 0.1 s</strong> and plot for example:
</p>

<blockquote><pre>
coil.i vs. time           // non-harmonic current due to saturation of the core material
r_mFe.mu_r vs. r_mFe.B    // relative permeability vs. flux density inside core
r_mFe.B vs. r_mFe.H       // magnetisation curve B(H); hysteresis neglected
</pre></blockquote>

<p>
The magnetisation characteristics of the flux tube element representing the ferromagnetic core can easily be changed from simplified linear behaviour (nonLinearPermeability set to false and R_mFe.mu_rConst set to a positive value, preferably mu_rConst >> 1) to non-linear behaviour (e.g., selection of one of the electric sheets in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">Material.SoftMagnetic</a> with nonLinearPermeability set to true). This enables for convenient initial design of magnetic circuits with linear material characteristics prior to simulation with non-linear behaviour.
</p>

<h4>Note</h4>

<p>
If the supply voltage has a zero-crossing when applied to the inductor at time t=0 (i.e., source.phase set to zero instead of &pi;/2), then the inrush current that is typical for switching of inductive loads can be observed.
</p>
</html>"));
end SaturatedInductor;
