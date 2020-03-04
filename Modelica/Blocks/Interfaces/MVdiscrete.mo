within Modelica.Blocks.Interfaces;
partial block MVdiscrete "Discrete Multi-Variable controller"
  extends DiscreteBlock;
  parameter Integer nu_s=1 "Number of setpoint inputs";
  parameter Integer nu_m=1 "Number of measurement inputs";
  parameter Integer ny=1 "Number of actuator outputs";
  Discrete.Sampler sampler_s[nu_s](each final samplePeriod=samplePeriod,
      each final startTime=startTime) annotation (Placement(transformation(
          extent={{-90,-10},{-70,10}})));
  Discrete.Sampler sampler_m[nu_m](each final samplePeriod=samplePeriod,
      each final startTime=startTime) annotation (Placement(transformation(
        origin={0,-80},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealInput u_s[nu_s]
    "Setpoint input signals" annotation (Placement(transformation(
          extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput u_m[nu_m]
    "Measurement input signals" annotation (Placement(
        transformation(
        origin={0,-120},
        extent={{20,-20},{-20,20}},
        rotation=270)));
  Modelica.Blocks.Interfaces.RealOutput y[ny]
    "Actuator output signals" annotation (Placement(transformation(
          extent={{100,-10},{120,10}})));
equation
  connect(u_s, sampler_s.u) annotation (Line(points={{-120,0},{-92,0}}));
  connect(u_m, sampler_m.u)
    annotation (Line(points={{0,-120},{0,-106},{0,-92}}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
            extent={{-100,-10},{-80,-30}},
            textString="u_s",
            textColor={0,0,255})}),         Documentation(info="<html>
<p>
Block has two Real input signal vectors and one
Real output signal vector. The vector signals
are sampled due to the defined <strong>samplePeriod</strong> parameter.
The block is designed
to be used as base class for a corresponding controller.
See the base-class <a href=\"modelica://Modelica.Blocks.Interfaces.DiscreteBlock\">DiscreteBlock</a> for more information.
</p>
</html>"));
end MVdiscrete;
