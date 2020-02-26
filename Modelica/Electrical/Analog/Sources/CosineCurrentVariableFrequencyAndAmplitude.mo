within Modelica.Electrical.Analog.Sources;
model CosineCurrentVariableFrequencyAndAmplitude
  "Cosine current source with variable frequency and amplitude"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  extends Modelica.Electrical.Analog.Icons.CurrentSource;
  import Modelica.Constants.pi;
  parameter Boolean useConstantAmplitude=false "Enable constant amplitude";
  parameter SI.Current constantAmplitude=1 "Constant amplitude"
    annotation(Dialog(enable=useConstantAmplitude));
  parameter Boolean useConstantFrequency=false "Enable constant frequency";
  parameter SI.Frequency constantFrequency=1 "Constant frequency"
    annotation(Dialog(enable=useConstantFrequency));
  parameter SI.Current offset=0 "Offset of the sine wave";
  SI.Angle phi(start=0) "Phase of the sine wave";
  Blocks.Interfaces.RealInput I(unit="A") if not useConstantAmplitude
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
  Blocks.Sources.Constant I_constant(final k=constantAmplitude) if useConstantAmplitude
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  Blocks.Sources.Constant f_constant(final k=constantFrequency) if useConstantFrequency
    annotation (Placement(transformation(extent={{-20,70},{-40,90}})));
  Blocks.Interfaces.RealInput I_internal(unit="A") "Amplitude" annotation (Placement(
        transformation(
        extent={{-2,-2},{2,2}},
        rotation=270,
        origin={60,80})));
  Blocks.Interfaces.RealInput f_internal(unit="Hz") "Frequency" annotation (Placement(
        transformation(
        extent={{-2,-2},{2,2}},
        rotation=270,
        origin={-60,80})));
equation
  der(phi) = 2*pi*f_internal;
  i = offset + I_internal*cos(phi);
  connect(f,f_internal)
    annotation (Line(points={{-60,120},{-60,80}}, color={0,0,127}));
  connect(I,I_internal)
    annotation (Line(points={{60,120},{60,80}}, color={0,0,127}));
  connect(f_constant.y,f_internal)
    annotation (Line(points={{-41,80},{-60,80}}, color={0,0,127}));
  connect(I_constant.y,I_internal)
    annotation (Line(points={{41,80},{60,80}}, color={0,0,127}));
  annotation (defaultComponentName="cosineCurrent",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Line(
          points={{-80,80},{-78.4,79.6},{-76.8,79.2},{-75.2,78.8},{-73.6,78.4},{
              -72,78},{-70.4,77.5},{-68.8,77.1},{-67.2,76.6},{-65.6,76.1},{-64,75.6},
              {-62.4,75},{-60.8,74.4},{-59.2,73.7},{-57.6,73},{-56,72.2},{-54.4,
              71.3},{-52.8,70.3},{-51.2,69.2},{-49.6,68},{-48,66.6},{-46.4,65.2},
              {-44.8,63.6},{-43.2,61.8},{-41.6,59.9},{-40,57.7},{-38.4,55.5},{-36.8,
              53},{-35.2,50.3},{-33.6,47.5},{-32,44.4},{-30.4,41.1},{-28.8,37.7},
              {-27.2,34},{-25.6,30.1},{-24,26.1},{-22.4,21.9},{-20.8,17.5},{-19.2,
              13},{-17.6,8.3},{-16,3.5},{-14.4,-1.3},{-12.8,-6.2},{-11.2,-11.1},
              {-9.6,-16},{-8,-20.8},{-6.4,-25.5},{-4.8,-30.1},{-3.2,-34.5},{-1.6,
              -38.6},{0,-42.4},{1.6,-45.9},{3.2,-49},{4.8,-51.7},{6.4,-53.9},{8,
              -55.5},{9.6,-56.5},{11.2,-57},{12.8,-56.8},{14.4,-55.9},{16,-54.4},
              {17.6,-52.2},{19.2,-49.3},{20.8,-45.7},{22.4,-41.5},{24,-36.7},{25.6,
              -31.4},{27.2,-25.6},{28.8,-19.4},{30.4,-12.9},{32,-6.2},{33.6,0.6},
              {35.2,7.4},{36.8,14},{38.4,20.4},{40,26.3},{41.6,31.8},{43.2,36.5},
              {44.8,40.6},{46.4,43.7},{48,45.9},{49.6,47.1},{51.2,47.2},{52.8,46.2},
              {54.4,44.1},{56,41},{57.6,36.8},{59.2,31.8},{60.8,25.9},{62.4,19.4},
              {64,12.4},{65.6,5.1},{67.2,-2.2},{68.8,-9.5},{70.4,-16.4},{72,-22.8},
              {73.6,-28.4},{75.2,-33},{76.8,-36.6},{78.4,-38.9},{80,-39.8}},
          smooth=Smooth.Bezier,
          color={192,192,192})}),
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",
        info="<html>
<p>
This current source provides a cosine current with variable frequency <code>f</code> and variable amplitude <code>I</code>,
i.e. the phase angle of the sine wave is integrated from 2*&pi;*f.
</p>
<p>
Note that the initial value of the phase angle <code>phi</code> defines the initial phase shift,
and that the parameter <code>startTime</code> is omitted since the current can be kept equal to offset with setting the input <code>I</code> to zero.
</p>
</html>"));
end CosineCurrentVariableFrequencyAndAmplitude;
