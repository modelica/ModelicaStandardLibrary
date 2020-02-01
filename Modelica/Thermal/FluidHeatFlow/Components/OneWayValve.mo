within Modelica.Thermal.FluidHeatFlow.Components;
model OneWayValve "Simple one-way valve"
  extends FluidHeatFlow.BaseClasses.TwoPort(m(start=0), final tapT=1);

  parameter SI.VolumeFlowRate V_flowNominal(start=1) "Nominal volume flow rate (forward)";
  parameter SI.Pressure dpForward(displayUnit="bar")=1e-6 "Pressure drop at nominal flow (forward)";
  parameter SI.Pressure dpNominal(displayUnit="bar", start=1e5) "Nominal pressure (backward)";
  parameter SI.VolumeFlowRate V_flowBackward(start=1E-6) "Leakage volume flow rate (backward)";
  parameter Real frictionLoss(min=0, max=1, start=0)
    "Part of friction losses fed to medium";
  Boolean backward(start=true) "State forward=false / backward=true";
protected
  Real s(start=0, final unit="1")
    "Auxiliary variable for actual position on the valve characteristic";
  /* s < 0: backward, leakage flow
         s > 0: forward, small pressure drop */
  constant SI.VolumeFlowRate unitVolumeFlowRate = 1;
  constant SI.Pressure unitPressureDrop = 1;
equation
  backward = s<0;
  dp     = (s*unitVolumeFlowRate)*(if backward then 1 else dpForward/V_flowNominal);
  V_flow = (s*unitPressureDrop)  *(if backward then V_flowBackward/dpNominal else 1);
  Q_flow = frictionLoss*V_flow*dp;
annotation (Documentation(info="<html>
<p>Simple one-way valve, comparable to the electrical <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealDiode\">ideal diode</a> model.</p>
<ul>
<li>from flowPort_a to flowPort_b: small pressure drop, linearly dependent on volumeFlow</li>
<li>from flowPort_b to flowPort_a: small leakage flow, linearly dependent on pressure drop</li>
</ul>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Polygon(
          points={{-90,10},{-60,10},{-60,60},{0,0},{60,60},{60,10},{90,10},{90,-10},
              {60,-10},{60,-60},{0,0},{-60,-60},{-60,-10},{-90,-10},{-90,10}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(extent={{-150,-70},{150,-110}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          points={{-60,60},{60,-60},{50,-40},{40,-50},{60,-60}},
          thickness=0.5),
        Polygon(
          points={{50,-40},{60,-60},{40,-50},{50,-40}},
          fillPattern=FillPattern.Solid)}));
end OneWayValve;
