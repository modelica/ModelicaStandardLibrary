within Modelica.Mechanics.Translational.Sources;
model EddyCurrentForce "Simple model of a translational eddy current brake"
  import Modelica.Electrical.Machines.Thermal.linearTemperatureDependency;
  parameter SI.Force f_nominal
    "Maximum force (always braking)";
  parameter SI.Velocity v_nominal(min=Modelica.Constants.eps)
    "Nominal speed (leads to maximum force) at reference temperature";
  parameter SI.Temperature TRef(start=293.15)
    "Reference temperature";
  parameter
    Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
    alpha20(start=0) "Temperature coefficient of material";
  extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort;
  SI.Velocity v
    "Velocity of flange with respect to support (= der(s))";
  Real v_normalized "Relative speed v/v_nominal";
equation
  v = der(s);
  v_normalized = v/(v_nominal*linearTemperatureDependency(1, TRef, alpha20, TheatPort));
  f = 2*f_nominal*v_normalized/(1 + v_normalized*v_normalized);
  lossPower = f*v;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
          Line(points={{-75,0},{75,0}}, color={192,192,192}),
          Line(points={{0,60},{0,-50}}, color={192,192,192}),
        Line(points={{0,0},{4,25},{8,41},{12,48},{16,50},{20,49},{24,46},{28,42},{32,38},{36,34},{46,25},{56,18},{66,12},{76,8}}, color={0,0,127}, smooth=Smooth.Bezier),
        Line(points={{0,0},{-4,-25},{-8,-41},{-12,-48},{-16,-50},{-20,-49},{-24,-46},{-28,-42},{-32,-38},{-36,-34},{-46,-25},{-56,-18},{-66,-12},{-76,-8}}, color={0,0,127}, smooth=Smooth.Bezier)}),
    Documentation(info="<html>
<p>This is a simple model of a translational <strong>eddy current brake</strong>. The force versus speed characteristic is defined by Kloss' equation.</p>
<p><strong>Thermal behaviour:</strong><br>
The resistance of the braking fin is influenced by the actual temperature Theatport, which in turn shifts the speed v_nominal at which the (unchanged) maximum torque occurs.<br>
If the heatPort is not used (useHeatPort = false), the operational temperature remains at the given temperature T.<br>
However, the speed v_nominal at which the maximum torque occurs is adapted from reference temperature TRef to the operational temperature.</p>
</html>"));
end EddyCurrentForce;
