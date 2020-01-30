within Modelica.Thermal.FluidHeatFlow.Sources;
model PressureIncrease "Enforces constant pressure increase"

  extends FluidHeatFlow.BaseClasses.TwoPort(final tapT=1);
  parameter Boolean usePressureIncreaseInput=false
    "Enable / disable pressure increase input"
    annotation(Evaluate=true, choices(checkBox=true));
  parameter SI.Pressure constantPressureIncrease(start=1)
    "Pressure increase"
    annotation(Dialog(enable=not usePressureIncreaseInput));
  Modelica.Blocks.Interfaces.RealInput pressureIncrease(unit="Pa")=internalPressureIncrease if usePressureIncreaseInput
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
protected
  SI.Pressure internalPressureIncrease;
equation
  if not usePressureIncreaseInput then
    internalPressureIncrease = constantPressureIncrease;
  end if;
  Q_flow = 0;
  dp = -internalPressureIncrease;
  annotation (
    Documentation(info="<html>
<p>Fan resp. pump with constant pressure increase. Mass resp. volume flow is the response of the whole system.</p>
<p>Coolant's temperature and enthalpy flow are not affected.</p>
<p>
Setting parameter m (mass of medium within fan/pump) to zero
leads to neglect of temperature transient cv*m*der(T).
</p>
<p>Thermodynamic equations are defined by BaseClasses.TwoPort.</p>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Ellipse(
          extent={{-90,90},{90,-90}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,68},{90,10},{90,-10},{-60,-68},{-60,68}},
          lineColor={0,0,255},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-40,30},{20,-30}},
          textString="dp"),               Text(
          extent={{-150,-100},{150,-140}},
          textColor={0,0,255},
          textString="%name")}));
end PressureIncrease;
