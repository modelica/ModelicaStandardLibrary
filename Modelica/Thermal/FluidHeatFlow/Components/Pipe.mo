within Modelica.Thermal.FluidHeatFlow.Components;
model Pipe "Pipe with optional heat exchange"
  extends FluidHeatFlow.BaseClasses.TwoPort;
  extends FluidHeatFlow.BaseClasses.SimpleFriction;

  parameter Boolean useHeatPort = false "= true, if HeatPort is enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Length h_g(start=0)
    "Geodetic height (height difference from flowPort_a to flowPort_b)";
  parameter SI.Acceleration g(final min=0)=Modelica.Constants.g_n "Gravitation";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(T=T_q, Q_flow=Q_flowHeatPort) if useHeatPort
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
protected
  SI.HeatFlowRate Q_flowHeatPort "Heat flow at conditional heatPort";
equation
  if not useHeatPort then
    Q_flowHeatPort=0;
  end if;
  // coupling with FrictionModel
  volumeFlow = V_flow;
  dp = pressureDrop + medium.rho*g*h_g;
  // energy exchange with medium
  Q_flow = Q_flowHeatPort + Q_friction;
annotation (Documentation(info="<html>
<p>Pipe with optional heat exchange.</p>
<p>
Thermodynamic equations are defined by BaseClasses.TwoPort.
Q_flow is defined by heatPort.Q_flow (useHeatPort=true) or zero (useHeatPort=false).</p>
<p>
<strong>Note:</strong> Setting parameter m (mass of medium within pipe) to zero
leads to neglect of temperature transient cv*m*der(T).
</p>
<p>
<strong>Note:</strong> Injecting heat into a pipe with zero mass flow causes
temperature rise defined by storing heat in medium's mass.
</p>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-90,20},{90,-20}},
          lineColor={255,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Polygon(visible=useHeatPort,
          points={{-10,-90},{-10,-40},{0,-20},{10,-40},{10,-90},{-10,-90}},
          lineColor={255,0,0}),           Text(extent={{-150,80},{150,40}},
          textString="%name",
          textColor={0,0,255})}));
end Pipe;
