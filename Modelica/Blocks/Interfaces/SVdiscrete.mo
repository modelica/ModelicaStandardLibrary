within Modelica.Blocks.Interfaces;
partial block SVdiscrete "Discrete Single-Variable controller"
  extends DiscreteBlock;

  Discrete.Sampler sampler_s(final samplePeriod=samplePeriod, final startTime=
       startTime) annotation (Placement(transformation(extent={{-100,-10},{-80,
            10}})));
  Discrete.Sampler sampler_m(final samplePeriod=samplePeriod, final startTime=
       startTime) annotation (Placement(transformation(
        origin={0,-90},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealInput u_s
    "Scalar setpoint input signal" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput u_m
    "Scalar measurement input signal" annotation (Placement(
        transformation(
        origin={0,-120},
        extent={{20,-20},{-20,20}},
        rotation=270)));
  Modelica.Blocks.Interfaces.RealOutput y
    "Scalar actuator output signal" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
equation
  connect(u_s, sampler_s.u) annotation (Line(points={{-120,0},{-102,0}}));
  connect(u_m, sampler_m.u)
    annotation (Line(points={{0,-120},{0,-111},{0,-102}}));
  annotation (             Documentation(info="<html>
<p>
Block has two Real input signals and one
Real output signal
that are sampled due to the defined <strong>samplePeriod</strong> parameter.
The block is designed
to be used as base class for a corresponding controller.
See the base-class <a href=\"modelica://Modelica.Blocks.Interfaces.DiscreteBlock\">DiscreteBlock</a> for more information.
</p>
</html>"));
end SVdiscrete;
