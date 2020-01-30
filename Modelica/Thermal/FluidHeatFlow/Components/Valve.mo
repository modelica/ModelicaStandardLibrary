within Modelica.Thermal.FluidHeatFlow.Components;
model Valve "Simple valve"
  extends FluidHeatFlow.BaseClasses.TwoPort(m(start=0), final tapT=1);

  parameter Boolean LinearCharacteristic(start=true)
    "Type of characteristic"
    annotation(Dialog(group="Standard characteristic"), choices(choice=true "Linear", choice=false
        "Exponential"));
  parameter Real y1(min=small, start=1) "Max. valve opening"
    annotation(Dialog(group="Standard characteristic"));
  parameter SI.VolumeFlowRate Kv1(min=small, start=1)
    "Max. flow @ y = y1"
    annotation(Dialog(group="Standard characteristic"));
  parameter Real kv0(min=small,max=1-small, start=0.01)
    "Leakage flow / max.flow @ y = 0"
    annotation(Dialog(group="Standard characteristic"));
  parameter SI.Pressure dp0(start=1) "Standard pressure drop"
    annotation(Dialog(group="Standard characteristic"));
  parameter SI.Density rho0(start=10)
    "Standard medium's density"
    annotation(Dialog(group="Standard characteristic"));
  parameter Real frictionLoss(min=0, max=1, start=0)
    "Part of friction losses fed to medium";
protected
  constant SI.VolumeFlowRate unitVolumeFlowRate = 1;
  constant Real small = Modelica.Constants.small;
  constant SI.VolumeFlowRate smallVolumeFlowRate = eps*unitVolumeFlowRate;
  constant Real eps = Modelica.Constants.eps;
  Real yLim = max(min(y,y1),0) "Limited valve opening";
  SI.VolumeFlowRate Kv "Standard flow rate";
public
  Modelica.Blocks.Interfaces.RealInput y annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
initial algorithm
  assert(y1>small, "Valve characteristic: y1 has to be > 0 !");
  assert(Kv1>smallVolumeFlowRate, "Valve characteristic: Kv1 has to be > 0 !");
  assert(kv0>small, "Valve characteristic: kv0 has to be > 0 !");
  assert(kv0<1-eps, "Valve characteristic: kv0 has to be < 1 !");
equation
  // evaluate standard characteristic
  Kv/Kv1 = if LinearCharacteristic then (kv0 + (1-kv0)*yLim/y1) else kv0*exp(Modelica.Math.log(1/kv0)*yLim/y1);
  // pressure drop under real conditions
  dp/dp0 = medium.rho/rho0*(V_flow/Kv)*abs(V_flow/Kv);
  // no energy exchange with medium
  Q_flow = frictionLoss*V_flow*dp;
annotation (Documentation(info="<html>
<p>Simple controlled valve.</p>
<p>
Standard characteristic Kv=<em>f </em>(y) is given at standard conditions (dp0, rho0),
</p>
<ul>
<li>either linear :<code> Kv/Kv1 = Kv0/Kv1 + (1-Kv0/Kv1) * y/Y1</code></li>
<li>or exponential:<code> Kv/Kv1 = Kv0/Kv1 * exp[log(Kv1/Kv0) * y/Y1]</code></li>
</ul>
<p>
where:
</p>
<ul>
<li><code>Kv0 ... min. flow @ y = 0</code></li>
<li><code>Y1 .... max. valve opening</code></li>
<li><code>Kv1 ... max. flow @ y = Y1</code></li>
</ul>
<p>
Flow resistance under real conditions is calculated by
</p>
<blockquote><pre>
V_flow**2 * rho / dp = Kv(y)**2 * rho0 / dp0
</pre></blockquote>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Polygon(
          points={{-90,10},{-60,10},{-60,60},{0,0},{60,60},{60,10},{90,10},
              {90,-10},{60,-10},{60,-60},{0,0},{-60,-60},{-60,-10},{-90,-10},
              {-90,10}},
          lineColor={255,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,80},{0,0}}, color={0,0,127}),
                                          Text(extent={{-150,-70},{150,-110}},
          textString="%name",
          textColor={0,0,255})}));
end Valve;
