within Modelica.Blocks.Interfaces;
partial block MVcontrol "Multi-Variable continuous controller"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer nu_s=1 "Number of setpoint inputs";
  parameter Integer nu_m=1 "Number of measurement inputs";
  parameter Integer ny=1 "Number of actuator outputs";
  RealInput u_s[nu_s] "Connector of setpoint input signals" annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}})));
  RealInput u_m[nu_m] "Connector of measurement input signals" annotation (
      Placement(transformation(
        origin={0,-120},
        extent={{20,-20},{-20,20}},
        rotation=270)));
  RealOutput y[ny] "Connector of actuator output signals" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));
  annotation (                                      Documentation(info="<html>
<p>
Block has two continuous Real input signal vectors and one
continuous Real output signal vector. The block is designed
to be used as base class for a corresponding controller.
</p>
</html>"));
end MVcontrol;
