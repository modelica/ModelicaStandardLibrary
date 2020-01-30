within Modelica.Thermal.FluidHeatFlow.Sources;
model VolumeFlow "Enforces constant volume flow"

  extends FluidHeatFlow.BaseClasses.TwoPort(final tapT=1);
  parameter Boolean useVolumeFlowInput=false
    "Enable / disable volume flow input"
    annotation(Evaluate=true, choices(checkBox=true));
  parameter SI.VolumeFlowRate constantVolumeFlow(start=1)
    "Volume flow rate"
    annotation(Dialog(enable=not useVolumeFlowInput));
  Modelica.Blocks.Interfaces.RealInput volumeFlow(unit="m3/s")=internalVolumeFlow if useVolumeFlowInput
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
protected
  SI.VolumeFlowRate internalVolumeFlow;
equation
  if not useVolumeFlowInput then
    internalVolumeFlow = constantVolumeFlow;
  end if;
  Q_flow = 0;
  V_flow = internalVolumeFlow;
  annotation (
    Documentation(info="<html>
<p>Fan resp. pump with constant volume flow rate. Pressure increase is the response of the whole system.</p>
<p>Coolant's temperature and enthalpy flow are not affected.</p>
<p>
Setting parameter m (mass of medium within fan/pump) to zero
leads to neglect of temperature transient cv*m*der(T).
</p>
<p>Thermodynamic equations are defined by BaseClasses.TwoPort.</p>
</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Ellipse(
          extent={{-90,90},{90,-90}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,68},{90,10},{90,-10},{-60,-68},{-60,68}},
          lineColor={255,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-40,30},{20,-30}},
          textString="V"),                Text(
          extent={{-150,-140},{150,-100}},
          textColor={0,0,255},
          textString="%name")}));
end VolumeFlow;
