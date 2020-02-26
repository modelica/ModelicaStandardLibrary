within Modelica.Electrical.Analog.Sources;
model SineVoltageVariableFrequencyAndAmplitude
  "Sine voltage source with variable frequency and amplitude"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  extends Modelica.Electrical.Analog.Icons.VoltageSource;
  import Modelica.Constants.pi;
  parameter Boolean useConstantAmplitude=false "Enable constant amplitude";
  parameter SI.Voltage constantAmplitude=1 "Constant amplitude"
    annotation(Dialog(enable=useConstantAmplitude));
  parameter Boolean useConstantFrequency=false "Enable constant frequency";
  parameter SI.Frequency constantFrequency=1 "Constant frequency"
    annotation(Dialog(enable=useConstantFrequency));
  parameter SI.Voltage offset=0 "Offset of the sine wave";
  SI.Angle phi(start=0) "Phase of the sine wave";
  Blocks.Interfaces.RealInput V(unit="V") if not useConstantAmplitude
    "Amplitude" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,120})));
  Blocks.Interfaces.RealInput f(unit="Hz") if not useConstantFrequency
    "Frequency" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,120})));
protected
  Blocks.Interfaces.RealInput V_internal(unit="V") "Amplitude" annotation (Placement(
        transformation(
        extent={{-2,-2},{2,2}},
        rotation=270,
        origin={60,80})));
  Blocks.Interfaces.RealInput f_internal(unit="Hz") "Frequency" annotation (Placement(
        transformation(
        extent={{-2,-2},{2,2}},
        rotation=270,
        origin={-60,80})));
  Blocks.Sources.Constant V_constant(final k=constantAmplitude) if useConstantAmplitude
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  Blocks.Sources.Constant f_constant(final k=constantFrequency) if useConstantFrequency
    annotation (Placement(transformation(extent={{-20,70},{-40,90}})));
equation
  der(phi) = 2*pi*f_internal;
  v = offset + V_internal*sin(phi);
  connect(f, f_internal)
    annotation (Line(points={{-60,120},{-60,80}}, color={0,0,127}));
  connect(V, V_internal)
    annotation (Line(points={{60,120},{60,80}}, color={0,0,127}));
  connect(f_constant.y, f_internal)
    annotation (Line(points={{-41,80},{-60,80}}, color={0,0,127}));
  connect(V_constant.y, V_internal)
    annotation (Line(points={{41,80},{60,80}}, color={0,0,127}));
  annotation (defaultComponentName="sineVoltage",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={
{-80,0},{-78.4,0},{-76.8,0},{-75.2,0},{-73.6,0.1},
{-72,0.1},{-70.4,0.2},{-68.8,0.3},{-67.2,0.4},{-65.6,0.6},
{-64,0.8},{-62.4,1.1},{-60.8,1.4},{-59.2,1.8},{-57.6,2.2},
{-56,2.7},{-54.4,3.3},{-52.8,3.9},{-51.2,4.6},{-49.6,5.4},
{-48,6.2},{-46.4,7.2},{-44.8,8.2},{-43.2,9.2},{-41.6,10.4},
{-40,11.6},{-38.4,12.9},{-36.8,14.2},{-35.2,15.6},{-33.6,17.1},
{-32,18.6},{-30.4,20.1},{-28.8,21.6},{-27.2,23.1},{-25.6,24.6},
{-24,26.1},{-22.4,27.5},{-20.8,28.8},{-19.2,30},{-17.6,31.1},
{-16,32},{-14.4,32.7},{-12.8,33.2},{-11.2,33.5},{-9.6,33.5},
{-8,33.2},{-6.4,32.5},{-4.8,31.5},{-3.2,30.1},{-1.6,28.4},
{0,26.2},{1.6,23.6},{3.2,20.6},{4.8,17.2},{6.4,13.3},
{8,9.1},{9.6,4.6},{11.2,-0.3},{12.8,-5.4},{14.4,-10.7},
{16,-16.1},{17.6,-21.6},{19.2,-27.1},{20.8,-32.3},{22.4,-37.4},
{24,-42.1},{25.6,-46.3},{27.2,-49.9},{28.8,-52.8},{30.4,-54.8},
{32,-56},{33.6,-56.1},{35.2,-55.2},{36.8,-53.1},{38.4,-49.8},
{40,-45.3},{41.6,-39.7},{43.2,-33},{44.8,-25.3},{46.4,-16.6},
{48,-7.3},{49.6,2.6},{51.2,12.8},{52.8,23},{54.4,33},
{56,42.5},{57.6,51.2},{59.2,58.8},{60.8,64.9},{62.4,69.3},
{64,71.9},{65.6,72.3},{67.2,70.5},{68.8,66.4},{70.4,60},
{72,51.4},{73.6,40.8},{75.2,28.4},{76.8,14.7},{78.4,0},
{80,-15.1}}, color={192,192,192},  smooth = Smooth.Bezier)}),
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",
        info="<html>
<p>
This voltage source provides a sinusoidal voltage with variable frequency <code>f</code> and variable amplitude <code>V</code>,
i.e. the phase angle of the sine wave is integrated from 2*&pi;*f.
</p>
<p>
Note that the initial value of the phase angle <code>phi</code> defines the initial phase shift,
and that the parameter <code>startTime</code> is omitted since the voltage can be kept equal to offset with setting the input <code>V</code> to zero.
</p>
</html>"));
end SineVoltageVariableFrequencyAndAmplitude;
