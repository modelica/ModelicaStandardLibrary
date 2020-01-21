within Modelica.Electrical.Analog;
package Sources "Time-dependent and controlled voltage and current sources"

  extends Modelica.Icons.SourcesPackage;

  model SignalVoltage
    "Generic voltage source using the input signal as source voltage"
    extends Modelica.Electrical.Analog.Icons.VoltageSource;
    Interfaces.PositivePin p annotation (Placement(transformation(extent={{-110,
              -10},{-90,10}})));
    Interfaces.NegativePin n annotation (Placement(transformation(extent={{110,
              -10},{90,10}})));
    Modelica.Blocks.Interfaces.RealInput v(unit="V")
      "Voltage between pin p and n (= p.v - n.v) as input signal" annotation (
        Placement(transformation(
          origin={0,120},
          extent={{-20,-20},{20,20}},
          rotation=270)));
    SI.Current i "Current flowing from pin p to pin n";
  equation
    v = p.v - n.v;
    0 = p.i + n.i;
    i = p.i;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}})),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
                              Line(points={{-109,20},{-84,
            20}}, color={160,160,164}),Polygon(
              points={{-94,23},{-84,20},{-94,17},{-94,23}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),Line(points={{91,20},{116,20}},
            color={160,160,164}),Text(
              extent={{-109,25},{-89,45}},
              textColor={160,160,164},
              textString="i"),Polygon(
              points={{106,23},{116,20},{106,17},{106,23}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),Text(
              extent={{91,45},{111,25}},
              textColor={160,160,164},
              textString="i"),Line(points={{-119,-5},{-119,5}}, color={160,160,164}),
            Line(points={{-124,0},{-114,0}}, color={160,160,164}),Line(
            points={{116,0},{126,0}}, color={160,160,164})}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Martin Otter<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>The signal voltage source is a parameterless converter of real valued signals into a the source voltage. No further effects are modeled. The real valued signal has to be provided by components of the blocks library. It can be regarded as the &quot;Opposite&quot; of a voltage sensor.</p>
</html>"));
  end SignalVoltage;

  model ConstantVoltage "Source for constant voltage"
    parameter SI.Voltage V(start=1) "Value of constant voltage";
    extends Interfaces.OnePort;
    extends Modelica.Electrical.Analog.Icons.VoltageSource;
  equation
    v = V;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Text(
            extent={{-150,-110},{150,-70}},
            textString="V=%V")}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>The ConstantVoltage source is a simple source for an ideal constant voltage which is provided by a parameter. There is no internal resistance modeled. If it is used instead of a battery model it is not very realistic: This battery will never be unloaded.</p>
</html>"));
  end ConstantVoltage;

  model StepVoltage "Step voltage source"
    parameter SI.Voltage V(start=1) "Height of step";
    extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.Step
        signalSource(final height=V));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-70,-70},{0,-70},{0,70},{69,70}},
              color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}})),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/StepVoltage.png\"
     alt=\"StepVoltage.png\">
</p>
</html>"));
  end StepVoltage;

  model RampVoltage "Ramp voltage source"
    parameter SI.Voltage V(start=1) "Height of ramp";
    parameter SI.Time duration(min=Modelica.Constants.small, start=2)
      "Duration of ramp";
    extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.Ramp
        signalSource(final height=V, final duration=duration));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}})),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-80,-60},{-50,-60},{50,60},{80,60}},
              color={192,192,192})}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/RampVoltage.png\"
     alt=\"RampVoltage.png\">
</p>
</html>"));
  end RampVoltage;

  model SineVoltage "Sine voltage source"
    parameter SI.Voltage V(start=1) "Amplitude of sine wave";
    parameter SI.Angle phase=0 "Phase of sine wave";
    parameter SI.Frequency f(start=1) "Frequency of sine wave";
    extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.Sine
        signalSource(
        final amplitude=V,
        final f=f,
        final phase=phase));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-66,0},{-56.2,29.9},{-49.8,46.5},
                {-44.2,58.1},{-39.3,65.2},{-34.3,69.2},{-29.4,69.8},{-24.5,67},
                {-19.6,61},{-14.6,52},{-9,38.6},{-1.98,18.6},{12.79,-26.9},{
                19.1,-44},{24.8,-56.2},{29.7,-64},{34.6,-68.6},{39.5,-70},{44.5,
                -67.9},{49.4,-62.5},{54.3,-54.1},{59.9,-41.3},{67,-21.7},{74,0}},
              color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/SineVoltage.png\"
     alt=\"SineVoltage.png\">
</p>
</html>"));

  end SineVoltage;

  model CosineVoltage "Cosine voltage source"
    parameter SI.Voltage V(start=1) "Amplitude of cosine wave";
    parameter SI.Angle phase=0 "Phase of cosine wave";
    parameter SI.Frequency f(start=1) "Frequency of cosine wave";
    extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.Cosine
        signalSource(
        final amplitude=V,
        final f=f,
        final phase=phase));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={Line(
            points={{-71,70},{-68.4,69.8},{-63.5,67},{-58.6,61},{-53.6,52},{-48,
                38.6},{-40.98,18.6},{-26.21,-26.9},{-19.9,-44},{-14.2,-56.2},{-9.3,
                -64},{-4.4,-68.6},{0.5,-70},{5.5,-67.9},{10.4,-62.5},{15.3,-54.1},
                {20.9,-41.3},{28,-21.7},{35,0}},
            color={192,192,192},
            smooth=Smooth.Bezier), Line(points={{35,0},{44.8,29.9},{51.2,46.5},
                {56.8,58.1},{61.7,65.2},{66.7,69.2},{71.6,69.8}}, color={192,
                192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})),
      Documentation(revisions="<html>
<ul>
<li>Initially implemented by Christian Kral on 2013-05-14</li>
</ul>
</html>", info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/CosineVoltage.png\"
     alt=\"CosineVoltage.png\">
</p>
</html>"));

  end CosineVoltage;

  model SineVoltageVariableFrequencyAndAmplitude
    "Sine voltage source with variable frequency and amplitude"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    extends Modelica.Electrical.Analog.Icons.VoltageSource;
    import Modelica.Constants.pi;
    parameter Boolean useConstantAmplitude=false "Enable constant amplitude";
    parameter Modelica.SIunits.Voltage constantAmplitude=1 "Constant amplitude"
      annotation(Dialog(enable=useConstantAmplitude));
    parameter Boolean useConstantFrequency=false "Enable constant frequency";
    parameter Modelica.SIunits.Frequency constantFrequency=1 "Constant frequency"
      annotation(Dialog(enable=useConstantFrequency));
    parameter Modelica.SIunits.Voltage offset=0 "Offset of the sine wave";
    Modelica.SIunits.Angle phi(start=0) "Phase of the sine wave";
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
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
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

  model CosineVoltageVariableFrequencyAndAmplitude
    "Cosine voltage source with variable frequency and amplitude"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    extends Modelica.Electrical.Analog.Icons.VoltageSource;
    import Modelica.Constants.pi;
    parameter Boolean useConstantAmplitude=false "Enable constant amplitude";
    parameter Modelica.SIunits.Voltage constantAmplitude=1 "Constant amplitude"
      annotation(Dialog(enable=useConstantAmplitude));
    parameter Boolean useConstantFrequency=false "Enable constant frequency";
    parameter Modelica.SIunits.Frequency constantFrequency=1 "Constant frequency"
      annotation(Dialog(enable=useConstantFrequency));
    parameter Modelica.SIunits.Voltage offset=0 "Offset of the sine wave";
    Modelica.SIunits.Angle phi(start=0) "Phase of the sine wave";
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
    v = offset + V_internal*cos(phi);
    connect(f, f_internal)
      annotation (Line(points={{-60,120},{-60,80}}, color={0,0,127}));
    connect(V, V_internal)
      annotation (Line(points={{60,120},{60,80}}, color={0,0,127}));
    connect(f_constant.y, f_internal)
      annotation (Line(points={{-41,80},{-60,80}}, color={0,0,127}));
    connect(V_constant.y, V_internal)
      annotation (Line(points={{41,80},{60,80}}, color={0,0,127}));
    annotation (defaultComponentName="cosineVoltage",
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
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>
This voltage source provides a cosine voltage with variable frequency <code>f</code> and variable amplitude <code>V</code>, 
i.e. the phase angle of the sine wave is integrated from 2*&pi;*f.
</p>
<p>
Note that the initial value of the phase angle <code>phi</code> defines the initial phase shift, 
and that the parameter <code>startTime</code> is omitted since the voltage can be kept equal to offset with setting the input <code>V</code> to zero.
</p>
</html>"));
  end CosineVoltageVariableFrequencyAndAmplitude;

  model ExpSineVoltage "Exponentially damped sine voltage source"
    parameter SI.Voltage V(start=1) "Amplitude of sine wave";
    parameter SI.Frequency f(start=2) "Frequency of sine wave";
    parameter SI.Angle phase=0 "Phase of sine wave";
    parameter SI.Damping damping(start=1) "Damping coefficient of sine wave";
    extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.ExpSine
        signalSource(
        final amplitude=V,
        final f=f,
        final phase=phase,
        final damping=damping));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-64,-14},{-59.2,18.3},{-56,36.3},
                {-52.7,50.5},{-49.5,60.2},{-46.3,65.3},{-43.1,65.6},{-39.9,61.3},
                {-36.7,53.1},{-32.6,38.2},{-27,11.8},{-19,-27.9},{-14.2,-47.7},
                {-10.1,-59.9},{-6.1,-67.2},{-2.1,-69.3},{1.9,-66.5},{5.9,-59.3},
                {10.77,-46.1},{24.44,-0.3},{29.3,12.4},{34.1,20.8},{38.1,24},{
                42.9,23.2},{47.8,17.8},{54.2,5.4},{67.1,-24.5},{73.5,-35.2},{
                79.1,-39.9},{84.7,-39.9},{91.2,-34.5},{96,-27.8}}, color={192,
                192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}})),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/ExpSineVoltage.png\"
     alt=\"ExpSineVoltage.png\">
</p>
</html>"));
  end ExpSineVoltage;

  model ExponentialsVoltage "Rising and falling exponential voltage source"
    parameter Real vMax(start=1) "Upper bound for rising edge";
    parameter SI.Time riseTime(min=0, start=0.5) "Rise time";
    parameter SI.Time riseTimeConst(min=Modelica.Constants.small, start=0.1)
      "Rise time constant";
    parameter SI.Time fallTimeConst(min=Modelica.Constants.small, start=
          riseTimeConst) "Fall time constant";
    extends Interfaces.VoltageSource(redeclare
        Modelica.Blocks.Sources.Exponentials signalSource(
        final outMax=vMax,
        final riseTime=riseTime,
        final riseTimeConst=riseTimeConst,
        final fallTimeConst=fallTimeConst));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-76,-59},{-73.2,-44.3},{-70.3,-31.1},
                {-66.8,-16.6},{-63.3,-4},{-59.7,6.92},{-55.5,18.18},{-51.3,27.7},
                {-46.3,37},{-40.6,45.5},{-34.3,53.1},{-27.2,59.6},{-18.7,65.3},
                {-8.1,70.2},{-6,71},{-3.88,58.5},{-1.05,43.7},{1.78,30.8},{
                4.606,19.45},{8.14,7.3},{11.68,-3},{15.9,-13.2},{20.2,-21.6},{
                25.1,-29.5},{30.8,-36.4},{37.1,-42.3},{44.9,-47.5},{54.8,-51.8},
                {64,-54.4}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}})),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/ExponentialsVoltage.png\"
     alt=\"ExponentialsVoltage.png\">
</p>
</html>"));
  end ExponentialsVoltage;

  model PulseVoltage "Pulse voltage source"
    parameter SI.Voltage V(start=1) "Amplitude of pulse";
    parameter Real width(
      final min=Modelica.Constants.small,
      final max=100,
      start=50) "Width of pulse in % of period";
    parameter SI.Time period(final min=Modelica.Constants.small, start=1)
      "Time for one period";
    extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.Pulse
        signalSource(
        final amplitude=V,
        final width=width,
        final period=period));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-70,-70},{-40,-70},{-40,70},{0,70},
                {0,-70},{40,-70},{40,70},{80,70}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}})),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/PulseVoltage.png\"
     alt=\"PulseVoltage.png\">
</p>
</html>"));
  end PulseVoltage;

  model SawToothVoltage "Saw tooth voltage source"
    parameter SI.Voltage V(start=1) "Amplitude of saw tooth";
    parameter SI.Time period(start=1) "Time for one period";
    extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.SawTooth
        signalSource(final amplitude=V, final period=period));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-85,-70},{-65,-70},{-5,71},{-5,-70},
                {55,71},{55,-70}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}})),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/SawToothVoltage.png\"
     alt=\"SawToothVoltage.png\">
</p>
</html>"));
  end SawToothVoltage;

  model TrapezoidVoltage "Trapezoidal voltage source"
    parameter SI.Voltage V(start=1) "Amplitude of trapezoid";
    parameter SI.Time rising(final min=0, start=0)
      "Rising duration of trapezoid";
    parameter SI.Time width(final min=0, start=0.5)
      "Width duration of trapezoid";
    parameter SI.Time falling(final min=0, start=0)
      "Falling duration of trapezoid";
    parameter SI.Time period(final min=Modelica.Constants.small, start=1)
      "Time for one period";
    parameter Integer nperiod(start=-1)
      "Number of periods (< 0 means infinite number of periods)";
    extends Interfaces.VoltageSource(redeclare
        Modelica.Blocks.Sources.Trapezoid signalSource(
        final amplitude=V,
        final rising=rising,
        final width=width,
        final falling=falling,
        final period=period,
        final nperiod=nperiod));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-81,-70},{-60,-70},{-30,70},{1,70},
                {30,-70},{51,-70},{80,70}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={         Line(
              points={{60,81},{60,-30}},
              color={192,192,192},
              pattern=LinePattern.Dash)}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/TrapezoidVoltage.png\"
     alt=\"TrapezoidVoltage.png\">
</p>
</html>"));
  end TrapezoidVoltage;

  model TableVoltage "Voltage source by linear interpolation in a table"
    parameter Real table[:, :]=[0, 0; 1, 1; 2, 4]
      "Table matrix (time = first column, voltage = second column)";
    extends Interfaces.VoltageSource(redeclare
        Modelica.Blocks.Sources.TimeTable signalSource(final table=table));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-58,-36},{-58,84},{42,84},{42,-36},
                {-58,-36},{-58,-6},{42,-6},{42,24},{-58,24},{-58,54},{42,54},{
                42,84},{-8,84},{-8,-37}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}})),
      Documentation(info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package.  Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p><br>This block generates a voltage source by <strong>linear interpolation</strong> in a table. The time points and voltage values are stored in a matrix <strong>table[i,j]</strong>, where the first column table[:,1] contains the time points and the second column contains the voltage to be interpolated. The table interpolation has the following properties:</p>
<ul>
<li>The time points need to be <strong>monotonically increasing</strong>.</li>
<li><strong>Discontinuities</strong> are allowed, by providing the same time point twice in the table.</li>
<li>Values <strong>outside</strong> of the table range, are computed by <strong>extrapolation</strong> through the last or first two points of the table.</li>
<li>If the table has only <strong>one row</strong>, no interpolation is performed and the voltage value is just returned independently of the actual time instant, i.e., this is a constant voltage source.</li>
<li>Via parameters <strong>startTime</strong> and <strong>offset</strong> the curve defined by the table can be shifted both in time and in the voltage.</li>
<li>The table is implemented in a numerically sound way by generating <strong>time events</strong> at interval boundaries.
    This generates continuously differentiable values for the integrator.</li>
</ul>
<p>Example:</p>
<blockquote><pre>
   table = [0  0
            1  0
            1  1
            2  4
            3  9
            4 16]
If, e.g., time = 1.0, the voltage v =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the voltage v =  2.5,
    e.g., time = 2.0, the voltage v =  4.0,
    e.g., time = 5.0, the voltage v = 23.0 (i.e., extrapolation).
</pre></blockquote>
<p><br>  Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/TableVoltage.png\"
     alt=\"TableVoltage.png\">
</p>
</html>", revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"));
  end TableVoltage;

  model SignalCurrent
    "Generic current source using the input signal as source current"
    extends Modelica.Electrical.Analog.Icons.CurrentSource;
    Interfaces.PositivePin p annotation (Placement(transformation(extent={{-110,
              -10},{-90,10}})));
    Interfaces.NegativePin n annotation (Placement(transformation(extent={{110,
              -10},{90,10}})));
    Modelica.Blocks.Interfaces.RealInput i(unit="A")
      "Current flowing from pin p to pin n as input signal" annotation (
        Placement(transformation(
          origin={0,120},
          extent={{-20,-20},{20,20}},
          rotation=270)));
    SI.Voltage v "Voltage drop between the two pins (= p.v - n.v)";
  equation
    v = p.v - n.v;
    0 = p.i + n.i;
    i = p.i;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}})),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Martin Otter<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>The signal current source is a parameterless converter of real valued signals into a the source current. No further effects are modeled. The real valued signal has to be provided by components of the blocks library. It can be regarded as the &quot;Opposite&quot; of a current sensor.</p>
</html>"));
  end SignalCurrent;

  model ConstantCurrent "Source for constant current"
    parameter SI.Current I(start=1) "Value of constant current";
    extends Interfaces.OnePort;
    extends Modelica.Electrical.Analog.Icons.CurrentSource;
  equation
    i = I;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Text(
            extent={{-150,-100},{150,-60}},
            textString="I=%I")}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>The ConstantCurrent source is a simple source for an ideal constant current which is provided by a parameter. There is no internal resistance modeled. No further effects are modeled. Especially, the current flow will never end.</p>
</html>"));
  end ConstantCurrent;

  model StepCurrent "Step current source"
    parameter SI.Current I(start=1) "Height of step";
    extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.Step
        signalSource(final height=I));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-86,-70},{-14,-70},{-14,70},{57,
                70}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}})),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/StepCurrent.png\"
     alt=\"StepCurrent.png\">
</p>
</html>"));
  end StepCurrent;

  model RampCurrent "Ramp current source"
    parameter SI.Current I(start=1) "Height of ramp";
    parameter SI.Time duration(min=Modelica.Constants.small, start=2)
      "Duration of ramp";
    extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.Ramp
        signalSource(final height=I, final duration=duration));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}})),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-80,-60},{-50,-60},{50,60},{80,60}},
              color={192,192,192})}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/RampCurrent.png\"
     alt=\"RampCurrent.png\">
</p>
</html>"));
  end RampCurrent;

  model SineCurrent "Sine current source"
    parameter SI.Current I(start=1) "Amplitude of sine wave";
    parameter SI.Angle phase=0 "Phase of sine wave";
    parameter SI.Frequency f(start=1) "Frequency of sine wave";
    extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.Sine
        signalSource(
        final amplitude=I,
        final f=f,
        final phase=phase));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-70,0},{-60.2,29.9},{-53.8,46.5},
                {-48.2,58.1},{-43.3,65.2},{-38.3,69.2},{-33.4,69.8},{-28.5,67},
                {-23.6,61},{-18.6,52},{-13,38.6},{-5.98,18.6},{8.79,-26.9},{
                15.1,-44},{20.8,-56.2},{25.7,-64},{30.6,-68.6},{35.5,-70},{40.5,
                -67.9},{45.4,-62.5},{50.3,-54.1},{55.9,-41.3},{63,-21.7},{70,0}},
              color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}})),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/SineCurrent.png\"
     alt=\"SineCurrent.png\">
</p>
</html>"));

  end SineCurrent;

  model CosineCurrent "Cosine current source"
    parameter SI.Current I(start=1) "Amplitude of cosine wave";
    parameter SI.Angle phase=0 "Phase of cosine wave";
    parameter SI.Frequency f(start=1) "Frequency of cosine wave";
    extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.Cosine
        signalSource(
        final amplitude=I,
        final f=f,
        final phase=phase));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(
            points={{-71,70},{-68.4,69.8},{-63.5,67},{-58.6,61},{-53.6,52},{-48,
                38.6},{-40.98,18.6},{-26.21,-26.9},{-19.9,-44},{-14.2,-56.2},{-9.3,
                -64},{-4.4,-68.6},{0.5,-70},{5.5,-67.9},{10.4,-62.5},{15.3,-54.1},
                {20.9,-41.3},{28,-21.7},{35,0}},
            color={192,192,192},
            smooth=Smooth.Bezier), Line(points={{35,0},{44.8,29.9},{51.2,46.5},
                {56.8,58.1},{61.7,65.2},{66.7,69.2},{71.6,69.8}}, color={192,
                192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}})),
      Documentation(revisions="<html>
<ul>
<li>Initially implemented by Christian Kral on 2013-05-14</li>
</ul>
</html>", info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/CosineCurrent.png\"
     alt=\"CosineCurrent.png\">
</p>
</html>"));

  end CosineCurrent;

  model SineCurrentVariableFrequencyAndAmplitude
    "Sine current source with variable frequency and amplitude"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    extends Modelica.Electrical.Analog.Icons.CurrentSource;
    import Modelica.Constants.pi;
    parameter Boolean useConstantAmplitude=false "Enable constant amplitude";
    parameter Modelica.SIunits.Current constantAmplitude=1 "Constant amplitude"
      annotation(Dialog(enable=useConstantAmplitude));
    parameter Boolean useConstantFrequency=false "Enable constant frequency";
    parameter Modelica.SIunits.Frequency constantFrequency=1 "Constant frequency"
      annotation(Dialog(enable=useConstantFrequency));
    parameter Modelica.SIunits.Current offset=0 "Offset of the sine wave";
    Modelica.SIunits.Angle phi(start=0) "Phase of the sine wave";
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
    i = offset + I_internal*sin(phi);
    connect(f,f_internal)
      annotation (Line(points={{-60,120},{-60,80}}, color={0,0,127}));
    connect(I,I_internal)
      annotation (Line(points={{60,120},{60,80}}, color={0,0,127}));
    connect(f_constant.y,f_internal)
      annotation (Line(points={{-41,80},{-60,80}}, color={0,0,127}));
    connect(I_constant.y,I_internal)
      annotation (Line(points={{41,80},{60,80}}, color={0,0,127}));
    annotation (defaultComponentName="sineCurrent",
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
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>
This current source provides a sinusoidal current with variable frequency <code>f</code> and variable amplitude <code>I</code>, 
i.e. the phase angle of the sine wave is integrated from 2*&pi;*f.
</p>
<p>
Note that the initial value of the phase angle <code>phi</code> defines the initial phase shift, 
and that the parameter <code>startTime</code> is omitted since the current can be kept equal to offset with setting the input <code>I</code> to zero.
</p>
</html>"));
  end SineCurrentVariableFrequencyAndAmplitude;

  model CosineCurrentVariableFrequencyAndAmplitude
    "Cosine current source with variable frequency and amplitude"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    extends Modelica.Electrical.Analog.Icons.CurrentSource;
    import Modelica.Constants.pi;
    parameter Boolean useConstantAmplitude=false "Enable constant amplitude";
    parameter Modelica.SIunits.Current constantAmplitude=1 "Constant amplitude"
      annotation(Dialog(enable=useConstantAmplitude));
    parameter Boolean useConstantFrequency=false "Enable constant frequency";
    parameter Modelica.SIunits.Frequency constantFrequency=1 "Constant frequency"
      annotation(Dialog(enable=useConstantFrequency));
    parameter Modelica.SIunits.Current offset=0 "Offset of the sine wave";
    Modelica.SIunits.Angle phi(start=0) "Phase of the sine wave";
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
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
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

  model ExpSineCurrent "Exponentially damped sine current source"
    parameter Real I(start=1) "Amplitude of sine wave";
    parameter SI.Frequency f(start=2) "Frequency of sine wave";
    parameter SI.Angle phase=0 "Phase of sine wave";
    parameter SI.Damping damping(start=1) "Damping coefficient of sine wave";
    extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.ExpSine
        signalSource(
        final amplitude=I,
        final f=f,
        final phase=phase,
        final damping=damping));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-80,-14},{-75.2,18.3},{-72,36.3},
                {-68.7,50.5},{-65.5,60.2},{-62.3,65.3},{-59.1,65.6},{-55.9,61.3},
                {-52.7,53.1},{-48.6,38.2},{-43,11.8},{-35,-27.9},{-30.2,-47.7},
                {-26.1,-59.9},{-22.1,-67.2},{-18.1,-69.3},{-14.1,-66.5},{-10.1,
                -59.3},{-5.23,-46.1},{8.44,-0.3},{13.3,12.4},{18.1,20.8},{22.1,
                24},{26.9,23.2},{31.8,17.8},{38.2,5.4},{51.1,-24.5},{57.5,-35.2},
                {63.1,-39.9},{68.7,-39.9},{75.2,-34.5},{80,-27.8}}, color={192,
                192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}})),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/ExpSineCurrent.png\"
     alt=\"ExpSineCurrent.png\">
</p>
</html>"));
  end ExpSineCurrent;

  model ExponentialsCurrent "Rising and falling exponential current source"
    parameter Real iMax(start=1) "Upper bound for rising edge";
    parameter SI.Time riseTime(min=0, start=0.5) "Rise time";
    parameter SI.Time riseTimeConst(min=Modelica.Constants.small, start=0.1)
      "Rise time constant";
    parameter SI.Time fallTimeConst(min=Modelica.Constants.small, start=
          riseTimeConst) "Fall time constant";
    extends Interfaces.CurrentSource(redeclare
        Modelica.Blocks.Sources.Exponentials signalSource(
        final outMax=iMax,
        final riseTime=riseTime,
        final riseTimeConst=riseTimeConst,
        final fallTimeConst=fallTimeConst));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-76,-59},{-73.2,-44.3},{-70.3,-31.1},
                {-66.8,-16.6},{-63.3,-4},{-59.7,6.92},{-55.5,18.18},{-51.3,27.7},
                {-46.3,37},{-40.6,45.5},{-34.3,53.1},{-27.2,59.6},{-18.7,65.3},
                {-8.1,70.2},{-6,71},{-3.88,58.5},{-1.05,43.7},{1.78,30.8},{
                4.606,19.45},{8.14,7.3},{11.68,-3},{15.9,-13.2},{20.2,-21.6},{
                25.1,-29.5},{30.8,-36.4},{37.1,-42.3},{44.9,-47.5},{54.8,-51.8},
                {64,-54.4}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}})),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/ExponentialsCurrent.png\"
     alt=\"ExponentialsCurrent.png\">
</p>
</html>"));
  end ExponentialsCurrent;

  model PulseCurrent "Pulse current source"
    parameter SI.Current I(start=1) "Amplitude of pulse";
    parameter Real width(
      final min=Modelica.Constants.small,
      final max=100,
      start=50) "Width of pulse in % of period";
    parameter SI.Time period(final min=Modelica.Constants.small, start=1)
      "Time for one period";
    extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.Pulse
        signalSource(
        final amplitude=I,
        final width=width,
        final period=period));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-80,-67},{-50,-67},{-50,73},{-10,
                73},{-10,-67},{30,-67},{30,73},{70,73}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}})),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));

  end PulseCurrent;

  model SawToothCurrent "Saw tooth current source"
    parameter SI.Current I(start=1) "Amplitude of saw tooth";
    parameter SI.Time period(start=1) "Time for one period";
    extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.SawTooth
        signalSource(final amplitude=I, final period=period));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-70,-71},{-50,-71},{10,70},{10,-71},
                {70,70},{70,-71}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}})),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/SawToothCurrent.png\"
     alt=\"SawToothCurrent.png\">
</p>
</html>"));
  end SawToothCurrent;

  model TrapezoidCurrent "Trapezoidal current source"
    parameter SI.Current I(start=1) "Amplitude of trapezoid";
    parameter SI.Time rising(final min=0, start=0)
      "Rising duration of trapezoid";
    parameter SI.Time width(final min=0, start=0.5)
      "Width duration of trapezoid";
    parameter SI.Time falling(final min=0, start=0)
      "Falling duration of trapezoid";
    parameter SI.Time period(final min=Modelica.Constants.small, start=1)
      "Time for one period";
    parameter Integer nperiod(start=-1)
      "Number of periods (< 0 means infinite number of periods)";
    extends Interfaces.CurrentSource(redeclare
        Modelica.Blocks.Sources.Trapezoid signalSource(
        final amplitude=I,
        final rising=rising,
        final width=width,
        final falling=falling,
        final period=period,
        final nperiod=nperiod));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-81,-66},{-60,-66},{-30,74},{1,74},
                {30,-66},{51,-66},{80,74}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={         Line(
              points={{60,80},{60,-30}},
              color={192,192,192},
              pattern=LinePattern.Dash)}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/TrapezoidCurrent.png\"
     alt=\"TrapezoidCurrent.png\">
</p>
</html>"));
  end TrapezoidCurrent;

  model TableCurrent "Current source by linear interpolation in a table"
    parameter Real table[:, :]=[0, 0; 1, 1; 2, 4]
      "Table matrix (time = first column, current = second column)";
    extends Interfaces.CurrentSource(redeclare
        Modelica.Blocks.Sources.TimeTable signalSource(final table=table));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-66,-36},{-66,84},{34,84},{34,-36},
                {-66,-36},{-66,-6},{34,-6},{34,24},{-66,24},{-66,54},{34,54},{
                34,84},{-16,84},{-16,-37}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}})),
      Documentation(info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p><br>This block generates a current source by <strong>linear interpolation</strong> in a table. The time points and current values are stored in a matrix <strong>table[i,j]</strong>, where the first column table[:,1] contains the time points and the second column contains the current to be interpolated. The table interpolation has the following properties:</p>
<ul>
<li>The time points need to be <strong>monotonically increasing</strong>.</li>
<li><strong>Discontinuities</strong> are allowed, by providing the same time point twice in the table.</li>
<li>Values <strong>outside</strong> of the table range, are computed by <strong>extrapolation</strong> through the last or first two points of the table.</li>
<li>If the table has only <strong>one row</strong>, no interpolation is performed and the current value is just returned independently of the actual time instant, i.e., this is a constant current source.</li>
<li>Via parameters <strong>startTime</strong> and <strong>offset</strong> the curve defined by the table can be shifted both in time and in the current.</li>
<li>The table is implemented in a numerically sound way by generating <strong>time events</strong> at interval boundaries.
    This generates continuously differentiable values for the integrator.</li>
</ul>
<p>Example:</p>
<blockquote><pre>
   table = [0  0
            1  0
            1  1
            2  4
            3  9
            4 16]
If, e.g., time = 1.0, the current i =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the current i =  2.5,
    e.g., time = 2.0, the current i =  4.0,
    e.g., time = 5.0, the current i = 23.0 (i.e., extrapolation).
</pre></blockquote>
<p><br> Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/TableCurrent.png\"
     alt=\"TableCurrent.png\">
</p>
</html>", revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"));
  end TableCurrent;

  model SupplyVoltage "Supply voltage (positive and negative)"
    parameter SI.Voltage Vps=+15 "Positive supply";
    parameter SI.Voltage Vns=-15 "Negative supply";
    Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin ground
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage positiveSupply(final V=
          Vps)
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage negativeSupply(final V=-
          Vns) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  equation
    connect(pin_p, positiveSupply.p) annotation (Line(
        points={{-100,0},{-60,0}}, color={0,0,255}));
    connect(negativeSupply.n, pin_n) annotation (Line(
        points={{60,0},{100,0}}, color={0,0,255}));
    connect(positiveSupply.n, ground) annotation (Line(
        points={{-40,0},{0,0}}, color={0,0,255}));
    connect(ground, negativeSupply.p) annotation (Line(
        points={{0,0},{40,0}}, color={0,0,255}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Line(
            points={{-60,40},{-60,-40}},
            color={0,0,255}),
          Line(
            points={{40,40},{40,-40}},
            color={0,0,255}),
          Line(
            points={{-40,20},{-40,-20}},
            color={0,0,255}),
          Line(
            points={{60,20},{60,-20}},
            color={0,0,255}),
          Line(
            points={{-90,0},{-60,0}},
            color={0,0,255}),
          Line(
            points={{60,0},{90,0}},
            color={0,0,255}),
          Text(
            extent={{-150,110},{150,70}},
            textColor={0,0,255},
            textString="%name"),
          Line(
            points={{-40,0},{-10,0}},
            color={0,0,255}),
          Line(
            points={{10,0},{40,0}},
            color={0,0,255}),
          Text(
            extent={{-100,40},{-80,20}},
            textColor={0,0,255},
            textString="+"),
          Text(
            extent={{80,40},{100,20}},
            textColor={0,0,255},
            textString="-"),
          Text(
            extent={{-10,40},{10,20}},
            textColor={0,0,255},
            textString="0")}),
      Documentation(info="<html>
                       <p>This is a simple model of a constant supply voltage with positive and negative supply, the potential between positive and negative supply is accessible.</p>
                       </html>"));
  end SupplyVoltage;
  annotation (Documentation(info="<html>
<p>This package contains time-dependent and controlled voltage and current sources. Most of the sources use the behavior modeled in the Modelica.Blocks.Sources package. All sources are ideal in the sense that <strong>no</strong> internal resistances are included.</p>
</html>", revisions="<html>
<dl>
<dt>
<strong>Main Authors:</strong>
</dt>
<dd>
Christoph Clau&szlig;
    &lt;<a href=\"mailto:christoph@clauss-it.com\">christoph@clauss-it.com</a>&gt;<br>
    Andr&eacute; Schneider
    &lt;<a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden
</dd>
</dl>

<p>
Copyright &copy; 1998-2020, Modelica Association and contributors
</p>
</html>"));
end Sources;
