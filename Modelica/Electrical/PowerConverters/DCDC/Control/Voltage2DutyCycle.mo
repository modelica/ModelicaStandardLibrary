within Modelica.Electrical.PowerConverters.DCDC.Control;
block Voltage2DutyCycle "Linearly transforms voltage to duty cycle"
  parameter Boolean reciprocal = false
    "Enables reciprocal formula between voltage and duty cycle";
  parameter Boolean useBipolarVoltage = true
    "Enables bipolar input voltage range"
    annotation(Dialog(enable=not reciprocal));
  parameter Boolean useConstantVoltageLimit=true
    "Enables constant voltage limit";
  parameter SI.Voltage VLim(final min=Modelica.Constants.small)
    "Voltage range limit mapped to dutyCycle = 1 resp. 0"
    annotation(Dialog(enable=useConstantVoltageLimit));
  Modelica.Blocks.Interfaces.RealInput v(unit = "V") "Voltage" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}}), iconTransformation(
          extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput dutyCycle "Duty cycle" annotation (
      Placement(transformation(extent={{100,-10},{120,10}}), iconTransformation(
          extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput vLim(unit = "V") if not useConstantVoltageLimit
    "Voltage limit" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Sources.Constant vLimConst(final k=VLim) if useConstantVoltageLimit
    "Constant voltage limit"
    annotation (Placement(transformation(extent={{40,70},{20,90}})));
protected
  Modelica.Blocks.Interfaces.RealInput vLimInt(unit="V") "Internal voltage limit"
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={0,80})));
equation
  if not reciprocal then
    if not useBipolarVoltage then
      dutyCycle =max(min(v, vLimInt), 0)/vLimInt;
    else
      dutyCycle =(max(min(v, vLimInt), -vLimInt)/vLimInt + 1)/2;
    end if;
  else
    dutyCycle =1 - vLimInt/max(v, vLimInt);
  end if;
  connect(vLim, vLimInt) annotation (Line(points={
          {0,120},{0,80}}, color={0,0,127}));
  connect(vLimInt, vLimConst.y) annotation (Line(points={{0,80},
          {19,80}}, color={0,0,127}));
  annotation (defaultComponentName="adaptor", Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,-60},{60,60}},
          pattern=LinePattern.Dash),
        Line(
          points={{-60,-60},{60,60}}),
        Polygon(
          points={{-78,-60},{-76,-60},{62,-60},{62,-54},{82,-60},{62,-66},{62,-60},
              {62,-60},{-78,-60}},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-80},{0,60},{-6,60},{0,80},{6,60},{0,60},{0,-80}},
          fillPattern=FillPattern.Solid), Text(extent={{
              -150,-120},{150,-160}}, textString = "%name", textColor = {0, 0, 255})}),
    Documentation(info="<html>
<p>
Transforms the input voltage signal into a duty cycle:</p>
<ul>
<li><code>reciprocal = false and useBipolarVoltage = false: v/VLim = dutyCycle</code></li>
<li><code>reciprocal = false and useBipolarVoltage = true : v/VLim = 2*dutyCycle - 1</code></li>
<li><code>reciprocal = true:                                v/VLim = 1/(1 - dutyCycle)</code></li>
</ul>
</html>"));
end Voltage2DutyCycle;
