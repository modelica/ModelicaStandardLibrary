within Modelica.Blocks.Interfaces;
partial block SVcontrol "Single-Variable continuous controller"
  extends Modelica.Blocks.Icons.Block;

  RealInput u_s "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  RealInput u_m "Connector of measurement input signal" annotation (Placement(
        transformation(
        origin={0,-120},
        extent={{20,-20},{-20,20}},
        rotation=270)));
  RealOutput y "Connector of actuator output signal" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
  annotation (                                      Documentation(info="<html>
<p>
Block has two continuous Real input signals and one
continuous Real output signal. The block is designed
to be used as base class for a corresponding controller.
</p>
</html>"));
end SVcontrol;
