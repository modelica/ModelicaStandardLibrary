within Modelica.Thermal.FluidHeatFlow.BaseClasses;
partial model SimpleFriction "Simple friction model"
  parameter SI.VolumeFlowRate V_flowLaminar(min=Modelica.Constants.small, start=0.1)
    "Laminar volume flow"
    annotation(Dialog(group="Simple friction"));
  parameter SI.Pressure dpLaminar(start=0.1)
    "Laminar pressure drop"
    annotation(Dialog(group="Simple friction"));
  parameter SI.VolumeFlowRate V_flowNominal(start=1)
    "Nominal volume flow"
    annotation(Dialog(group="Simple friction"));
  parameter SI.Pressure dpNominal(start=1)
    "Nominal pressure drop"
    annotation(Dialog(group="Simple friction"));
  parameter Real frictionLoss(min=0, max=1) = 0
    "Part of friction losses fed to medium"
    annotation(Dialog(group="Simple friction"));
  SI.Pressure pressureDrop;
  SI.VolumeFlowRate volumeFlow;
  SI.Power Q_friction;
protected
  parameter SI.Pressure dpNomMin=dpLaminar/V_flowLaminar*V_flowNominal;
  parameter Real k(final unit="Pa.s2/m6", fixed=false);
initial algorithm
  assert(V_flowNominal>V_flowLaminar,
    "SimpleFriction: V_flowNominal has to be > V_flowLaminar!");
  assert(dpNominal>=dpNomMin,
    "SimpleFriction: dpNominal has to be > dpLaminar/V_flowLaminar*V_flowNominal!");
  k:=(dpNominal - dpNomMin)/(V_flowNominal - V_flowLaminar)^2;
equation
  if volumeFlow > +V_flowLaminar then
    pressureDrop = +dpLaminar/V_flowLaminar*volumeFlow + k*(volumeFlow - V_flowLaminar)^2;
  elseif volumeFlow < -V_flowLaminar then
    pressureDrop = +dpLaminar/V_flowLaminar*volumeFlow - k*(volumeFlow + V_flowLaminar)^2;
  else
    pressureDrop =  dpLaminar/V_flowLaminar*volumeFlow;
  end if;
  Q_friction = frictionLoss*volumeFlow*pressureDrop;
annotation (Documentation(info="<html>
<p>
Definition of relationship between pressure drop and volume flow rate:
</p>
<ul>
<li>-V_flowLaminar &lt; VolumeFlow &lt; +V_flowLaminar: laminar, i.e., linear dependency of pressure drop on volume flow.</li>
<li>-V_flowLaminar &gt; VolumeFlow or VolumeFlow &lt; +V_flowLaminar: turbulent, i.e., quadratic dependency of pressure drop on volume flow.</li>
</ul>
<div>
<img src=\"modelica://Modelica/Resources/Images/Thermal/FluidHeatFlow/BaseClasses/SimpleFriction.png\"
     alt=\"SimpleFriction.png\">
</div>
<p>
Linear and quadratic dependency are coupled smoothly at V_flowLaminar / dpLaminar.
Quadratic dependency is defined by nominal volume flow and pressure drop (V_flowNominal / dpNominal).
See also sketch at diagram layer.
</p>
</html>"));
end SimpleFriction;
