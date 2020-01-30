within Modelica.Mechanics.Rotational.Sources;
model EddyCurrentTorque "Simple model of a rotational eddy current brake"
  import Modelica.Electrical.Machines.Thermal.linearTemperatureDependency;
  parameter SI.Torque tau_nominal
    "Maximum torque (always braking)";
  parameter SI.AngularVelocity w_nominal(min=Modelica.Constants.eps)
    "Nominal speed (leads to maximum torque) at reference temperature";
  parameter SI.Temperature TRef(start=293.15)
    "Reference temperature";
  parameter
    Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
    alpha20(start=0) "Temperature coefficient of material";
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTorque;
  extends
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort;
  SI.Torque tau
    "Accelerating torque acting at flange (= flange.tau)";
  SI.AngularVelocity w
    "Angular velocity of flange with respect to support (= der(phi))";
  Real w_normalized "Relative speed w/w_nominal";
equation
  tau = flange.tau;
  w = der(phi);
  w_normalized = w/(w_nominal*linearTemperatureDependency(1, TRef, alpha20, TheatPort));
  tau = 2*tau_nominal*w_normalized/(1 + w_normalized*w_normalized);
  lossPower = tau*w;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
          Line(points={{-75,0},{75,0}}, color={192,192,192}),
          Line(points={{0,60},{0,-50}}, color={192,192,192}),
        Line(points={{0,0},{4,25},{8,41},{12,48},{16,50},{20,49},{24,46},{28,42},{32,38},{36,34},{46,25},{56,18},{66,12},{76,8}}, color={0,0,127}, smooth=Smooth.Bezier),
        Line(points={{0,0},{-4,-25},{-8,-41},{-12,-48},{-16,-50},{-20,-49},{-24,-46},{-28,-42},{-32,-38},{-36,-34},{-46,-25},{-56,-18},{-66,-12},{-76,-8}}, color={0,0,127}, smooth=Smooth.Bezier)}),
    Documentation(info="<html>
<p>This is a simple model of a rotational <strong>eddy current brake</strong>. The torque versus speed characteristic is defined by Kloss' equation.</p>
<p><strong>Thermal behaviour:</strong><br>
The resistance of the braking disc is influenced by the actual temperature Theatport, which in turn shifts the speed w_nominal at which the (unchanged) maximum torque occurs.<br>
If the heatPort is not used (useHeatPort = false), the operational temperature remains at the given temperature T.<br>
However, the speed w_nominal at which the maximum torque occurs is adapted from reference temperature TRef to the operational temperature.</p>
</html>"));
end EddyCurrentTorque;
