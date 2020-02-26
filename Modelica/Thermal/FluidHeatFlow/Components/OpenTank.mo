within Modelica.Thermal.FluidHeatFlow.Components;
model OpenTank "Model of a tank under ambient pressure"
  extends FluidHeatFlow.BaseClasses.SinglePortBottom(final Exchange=true);

  parameter SI.Area ATank(start=1) "Cross section of tank";
  parameter SI.Length hTank(start=1) "Height of tank";
  parameter SI.Pressure pAmbient(start=0) "Ambient pressure";
  parameter SI.Acceleration g(final min=0)=Modelica.Constants.g_n "Gravitation";
  parameter Boolean useHeatPort = false "= true, if HeatPort is enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  SI.Mass m "Mass of medium in tank";
protected
  SI.Enthalpy H "Enthalpy of medium";
  SI.HeatFlowRate Q_flow "Heat flow at the optional heatPort";
public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(final T=T, final Q_flow=Q_flow) if useHeatPort
    "Optional port for cooling or heating the medium in the tank"
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}),
        iconTransformation(extent={{-110,-110},{-90,-90}})));
  Modelica.Blocks.Interfaces.RealOutput level(quantity="Length", unit="m", start=0)
    "Level of medium in tank" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={110,0})));
  Modelica.Blocks.Interfaces.RealOutput TTank(quantity="Temperature", unit="K", displayUnit="degC")
    "Temperature of medium in tank" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={110,-60})));
equation
  //output medium temperature
  TTank = T;
  //optional heating/cooling
  if not useHeatPort then
    Q_flow = 0;
  end if;
  //check level
  assert(level>=0, "Tank got empty!");
  assert(level<=hTank, "Tank got full!");
  //mass balance
  m = medium.rho*ATank*level;
  der(m) = flowPort.m_flow;
  //energy balance
  H = m*h;
  der(H) = flowPort.H_flow + Q_flow;
  //pressure at bottom
  flowPort.p = pAmbient + m*g/ATank;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-80,-60},{80,-100}},
          fillColor={170,170,255},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{-80,0},{80,-80}},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,170,255}),
        Rectangle(
          extent={{-80,80},{80,0}},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,255,255}),
        Ellipse(
          extent={{-80,100},{80,60}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Sphere),
        Ellipse(
          extent={{-80,20},{80,-20}},
          fillColor={170,170,255},
          fillPattern=FillPattern.Sphere),
        Line(points={{100,0},{80,0}}, thickness=0.5),
        Line(points={{100,-60},{80,-60}},
                                        color={238,46,47},
          thickness=0.5),
        Ellipse(
          extent={{72,-56},{80,-64}},
          lineColor={238,46,47},
          lineThickness=0.5,
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Ellipse(visible=useHeatPort,
          extent={{-80,-74},{-68,-86}},
          lineColor={238,46,47},
          lineThickness=0.5,
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Ellipse(visible=useHeatPort,
          extent={{-68,-78},{-56,-90}},
          lineColor={238,46,47},
          lineThickness=0.5,
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Ellipse(visible=useHeatPort,
          extent={{-56,-82},{-44,-94}},
          lineColor={238,46,47},
          lineThickness=0.5,
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Ellipse(visible=useHeatPort,
          extent={{-44,-84},{-32,-96}},
          lineColor={238,46,47},
          lineThickness=0.5,
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Line(visible=useHeatPort,
          points={{-90,-100},{-56,-100},{-56,-88}},
          color={238,46,47},
          thickness=0.5)}),    Documentation(info="<html>
<p>This is a simple model of an open tank with volume A*h. The level and the temperature of the medium are measured and provided as output.</p>
<p>Note: If the level of the medium reaches 0 (minimum) or h (maximum), an assertion is triggered.</p>
<p>Note: The flowPort is assumed to be at the bottom. Therefore the pressure at the flowPort is ambient pressure + level*rho*g.</p>
<ul>
<li>If the mass flow rate at the port goes into the tank the level increases and the mixing rule is applied to obtain the temperature change of the medium in the tank.</li>
<li>If the mass flow rate at the port goes out of the tank the level decreases,
the temperature of the outflowing medium is defined by the the temperature of the medium in the tank.</li>
</ul>
<p>
It is assumed that the medium in the tank has the same temperature over the whole volume, i.e. mixed thoroughly.
</p>
<p>
Via the optional heatPort the medium in the tank can be cooled or heated.
</p>
</html>"));
end OpenTank;
