within Modelica.Thermal.FluidHeatFlow.BaseClasses;
partial model SimpleFriction "Simple friction model"
  parameter Modelica.SIunits.VolumeFlowRate V_flowLaminar(min=Modelica.Constants.small, start=0.1)
    "Laminar volume flow"
    annotation(Dialog(group="Simple Friction"));
  parameter Modelica.SIunits.Pressure dpLaminar(start=0.1)
    "Laminar pressure drop"
    annotation(Dialog(group="Simple Friction"));
  parameter Modelica.SIunits.VolumeFlowRate V_flowNominal(start=1)
    "Nominal volume flow"
    annotation(Dialog(group="Simple Friction"));
  parameter Modelica.SIunits.Pressure dpNominal(start=1)
    "Nominal pressure drop"
    annotation(Dialog(group="Simple Friction"));
  parameter Real frictionLoss(min=0, max=1) = 0
    "Part of friction losses fed to medium"
    annotation(Dialog(group="Simple Friction"));
  Modelica.SIunits.Pressure pressureDrop;
  Modelica.SIunits.VolumeFlowRate volumeFlow;
  Modelica.SIunits.Power Q_friction;
protected
  parameter Modelica.SIunits.Pressure dpNomMin=dpLaminar/V_flowLaminar*V_flowNominal;
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
<p>
Linear and quadratic dependency are coupled smoothly at V_flowLaminar / dpLaminar.
Quadratic dependency is defined by nominal volume flow and pressure drop (V_flowNominal / dpNominal).
See also sketch at diagram layer.
</p>
</html>"),
  Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Line(points={{-80,0},{80,0}}, color={0,0,255}),
        Line(points={{0,80},{0,-80}}, color={0,0,255}),
        Line(points={{-40,-20},{40,20}}, color={0,0,255}),
        Line(points={{40,20},{60,40},{70,60},{74,80}}, color={0,0,255}),
        Line(points={{-40,-20},{-60,-40},{-70,-60},{-74,-80}}, color={0,0,255}),
        Line(points={{40,20},{40,0}}, color={0,0,255}),
        Line(points={{60,40},{60,0}}, color={0,0,255}),
        Line(points={{40,20},{0,20}}, color={0,0,255}),
        Line(points={{60,40},{0,40}}, color={0,0,255}),
        Text(
          extent={{18,0},{48,-20}},
          textColor={0,0,255},
          textString="V_flowLaminar"),
        Text(
          extent={{50,0},{80,-20}},
          textColor={0,0,255},
          textString="V_flowNominal"),
        Text(
          extent={{-30,30},{-4,10}},
          textColor={0,0,255},
          textString="dpLaminar"),
        Text(
          extent={{-30,50},{-4,30}},
          textColor={0,0,255},
          textString="dpNominal"),
        Text(
          extent={{0,20},{30,0}},
          textColor={0,0,255},
          textString="dp ~ V_flow"),
        Text(
          extent={{30,60},{60,40}},
          textColor={0,0,255},
          textString="dp ~ V_flow^2")}));
end SimpleFriction;
