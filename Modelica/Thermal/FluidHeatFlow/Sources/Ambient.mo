within Modelica.Thermal.FluidHeatFlow.Sources;
model Ambient "Ambient with constant properties"

  extends FluidHeatFlow.BaseClasses.SinglePortLeft(
    final Exchange=true,
    final T0=293.15,
    final T0fixed=false);
  parameter Boolean usePressureInput=false
    "Enable / disable pressure input"
    annotation(Evaluate=true, choices(checkBox=true));
  parameter SI.Pressure constantAmbientPressure(start=0)
    "Ambient pressure"
    annotation(Dialog(enable=not usePressureInput));
  parameter Boolean useTemperatureInput=false
    "Enable / disable temperature input"
    annotation(Evaluate=true, choices(checkBox=true));
  parameter SI.Temperature constantAmbientTemperature(start=293.15, displayUnit="degC")
    "Ambient temperature"
    annotation(Dialog(enable=not useTemperatureInput));
  Modelica.Blocks.Interfaces.RealInput ambientPressure=pAmbient if usePressureInput
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,60}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,60})));
  Modelica.Blocks.Interfaces.RealInput ambientTemperature=TAmbient if useTemperatureInput
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,-60}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,-60})));
protected
  SI.Pressure pAmbient;
  SI.Temperature TAmbient;

equation
  if not usePressureInput then
    pAmbient = constantAmbientPressure;
  end if;
  if not useTemperatureInput then
    TAmbient = constantAmbientTemperature;
  end if;
  flowPort.p = pAmbient;
  T = TAmbient;
annotation (Documentation(info="<html>
<p>(Infinite) ambient with constant pressure and temperature.</p>
<p>Thermodynamic equations are defined by BaseClasses.SinglePortLeft.</p>
</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Ellipse(
          extent={{-90,90},{90,-90}},
          lineColor={255,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{20,80},{80,20}},
          textString="p"), Text(
          extent={{20,-20},{80,-80}},
          textString="T")}));
end Ambient;
