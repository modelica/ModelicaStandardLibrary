within Modelica.Blocks;
package Sources
  "Library of signal source blocks generating Real, Integer and Boolean signals"
  import Modelica.Blocks.Interfaces;

  extends Modelica.Icons.SourcesPackage;

  block RealExpression "Set output signal to a time varying Real expression"

    Modelica.Blocks.Interfaces.RealOutput y=0.0 "Value of Real output"
      annotation (Dialog(group="Time varying output signal"), Placement(
          transformation(extent={{100,-10},{120,10}})));

    annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,40},{100,-40}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Text(
            extent={{-96,15},{96,-15}},
            textString="%y"),
          Text(
            extent={{-150,90},{150,50}},
            textString="%name",
            textColor={0,0,255})}), Documentation(info="<html>
<p>
The (time varying) Real output signal of this block can be defined in its
parameter menu via variable <strong>y</strong>. The purpose is to support the
easy definition of Real expressions in a block diagram. For example,
in the y-menu the definition \"if time &lt; 1 then 0 else 1\" can be given in order
to define that the output signal is one, if time &ge; 1 and otherwise
it is zero. Note, that \"time\" is a built-in variable that is always
accessible and represents the \"model time\" and that
variable <strong>y</strong> is both a variable and a connector.
</p>
</html>"));

  end RealExpression;

  block IntegerExpression
    "Set output signal to a time varying Integer expression"

    Modelica.Blocks.Interfaces.IntegerOutput y=0 "Value of Integer output"
      annotation (Dialog(group="Time varying output signal"), Placement(
          transformation(extent={{100,-10},{120,10}})));

    annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,40},{100,-40}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Text(
            extent={{-96,15},{96,-15}},
            textString="%y"),
          Text(
            extent={{-150,90},{150,50}},
            textString="%name",
            textColor={0,0,255})}), Documentation(info="<html>
<p>
The (time varying) Integer output signal of this block can be defined in its
parameter menu via variable <strong>y</strong>. The purpose is to support the
easy definition of Integer expressions in a block diagram. For example,
in the y-menu the definition \"if time &lt; 1 then 0 else 1\" can be given in order
to define that the output signal is one, if time &ge; 1 and otherwise
it is zero. Note, that \"time\" is a built-in variable that is always
accessible and represents the \"model time\" and that
variable <strong>y</strong> is both a variable and a connector.
</p>
</html>"));

  end IntegerExpression;

  block BooleanExpression
    "Set output signal to a time varying Boolean expression"

    Modelica.Blocks.Interfaces.BooleanOutput y=false "Value of Boolean output"
      annotation (Dialog(group="Time varying output signal"), Placement(
          transformation(extent={{100,-10},{120,10}})));

    annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,40},{100,-40}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Text(
            extent={{-96,15},{96,-15}},
            textString="%y"),
          Text(
            extent={{-150,90},{150,50}},
            textString="%name",
            textColor={0,0,255}),
          Polygon(
            points={{100,10},{120,0},{100,-10},{100,10}},
            lineColor=DynamicSelect({255,0,255}, if y then {0,255,0} else {255,0,255}),
            fillColor=DynamicSelect({255,255,255}, if y then {0,255,0} else {255,255,255}),
            fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
The (time varying) Boolean output signal of this block can be defined in its
parameter menu via variable <strong>y</strong>. The purpose is to support the
easy definition of Boolean expressions in a block diagram. For example,
in the y-menu the definition \"time &gt;= 1 and time &lt;= 2\" can be given in order
to define that the output signal is <strong>true</strong> in the time interval
1 &le; time &le; 2 and otherwise it is <strong>false</strong>.
Note, that \"time\" is a built-in variable that is always
accessible and represents the \"model time\" and that
variable <strong>y</strong> is both a variable and a connector.
</p>
</html>"));

  end BooleanExpression;

  block ContinuousClock "Generate current time signal"
    extends Interfaces.SignalSource;

  equation
    y = offset + (if time < startTime then 0 else time - startTime);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Ellipse(extent={{-80,80},{80,-80}}, lineColor={160,160,164}),
          Line(points={{0,80},{0,60}}, color={160,160,164}),
          Line(points={{80,0},{60,0}}, color={160,160,164}),
          Line(points={{0,-80},{0,-60}}, color={160,160,164}),
          Line(points={{-80,0},{-60,0}}, color={160,160,164}),
          Line(points={{37,70},{26,50}}, color={160,160,164}),
          Line(points={{70,38},{49,26}}, color={160,160,164}),
          Line(points={{71,-37},{52,-27}}, color={160,160,164}),
          Line(points={{39,-70},{29,-51}}, color={160,160,164}),
          Line(points={{-39,-70},{-29,-52}}, color={160,160,164}),
          Line(points={{-71,-37},{-50,-26}}, color={160,160,164}),
          Line(points={{-71,37},{-54,28}}, color={160,160,164}),
          Line(points={{-38,70},{-28,51}}, color={160,160,164}),
          Line(
            points={{0,0},{-50,50}},
            thickness=0.5),
          Line(
            points={{0,0},{40,0}},
            thickness=0.5),
          Text(
            extent={{-150,-150},{150,-110}},
            textString="startTime=%startTime")}),
      Documentation(info="<html>
<p>
The Real output y is a clock signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/ContinuousClock.png\"
     alt=\"ContinuousClock.png\">
</div>
</html>"));
  end ContinuousClock;

  block Constant "Generate constant signal of type Real"
    parameter Real k(start=1) "Constant output value"
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Constant.png"));
    extends Interfaces.SO;

  equation
    y = k;
    annotation (
      defaultComponentName="const",
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,0},{80,0}}),
          Text(
            extent={{-150,-150},{150,-110}},
            textString="k=%k")}),
      Documentation(info="<html>
<p>
The Real output y is a constant signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Constant.png\"
     alt=\"Constant.png\">
</div>
</html>"));
  end Constant;

  block Step "Generate step signal of type Real"
    parameter Real height=1 "Height of step"
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Step.png"));
    extends Interfaces.SignalSource;

  equation
    y = offset + (if time < startTime then 0 else height);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-70},{0,-70},{0,50},{80,50}}),
          Text(
            extent={{-150,-150},{150,-110}},
            textString="startTime=%startTime")}),
      Documentation(info="<html>
<p>
The Real output y is a step signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Step.png\"
     alt=\"Step.png\">
</div>

</html>"));
  end Step;

  block Ramp "Generate ramp signal"
    parameter Real height=1 "Height of ramps"
      annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Ramp.png"));
    parameter SI.Time duration(min=0.0, start=2)
      "Duration of ramp (= 0.0 gives a Step)";
    extends Interfaces.SignalSource;

  equation
    y = offset + (if time < startTime then 0 else if time < (startTime +
      duration) then (time - startTime)*height/duration else height);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-70},{-40,-70},{31,38}}),
          Text(
            extent={{-150,-150},{150,-110}},
            textString="duration=%duration"),
          Line(points={{31,38},{86,38}})}),
      Documentation(info="<html>
<p>
The Real output y is a ramp signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Ramp.png\"
     alt=\"Ramp.png\">
</div>

<p>
If parameter duration is set to 0.0, the limiting case of a Step signal is achieved.
</p>
</html>"));
  end Ramp;

  block Sine "Generate sine signal"
    import Modelica.Constants.pi;
    parameter Real amplitude=1 "Amplitude of sine wave"
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Sine.png"));
    parameter SI.Frequency f(start=1) "Frequency of sine wave";
    parameter SI.Angle phase=0 "Phase of sine wave";
    extends Interfaces.SignalSource;
  equation
    y = offset + (if time < startTime then 0 else amplitude*Modelica.Math.sin(2
      *pi*f*(time - startTime) + phase));
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,
                74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,
                59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7,
                -64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},
                {57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, smooth = Smooth.Bezier),
          Text(
            extent={{-147,-152},{153,-112}},
            textString="f=%f")}),
      Documentation(info="<html>
<p>
The Real output y is a sine signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Sine.png\"
     alt=\"Sine.png\">
</div>
</html>"));
  end Sine;

  block Cosine "Generate cosine signal"
    import Modelica.Constants.pi;
    parameter Real amplitude=1 "Amplitude of cosine wave"
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Cosine.png"));
    parameter SI.Frequency f(start=1) "Frequency of cosine wave";
    parameter SI.Angle phase=0 "Phase of cosine wave";
    extends Interfaces.SignalSource;
  equation
    y = offset + (if time < startTime then 0 else amplitude*Modelica.Math.cos(2
      *pi*f*(time - startTime) + phase));
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,80},{-76.2,79.8},{-70.6,76.6},{-64.9,69.7},{-59.3,
                59.4},{-52.9,44.1},{-44.83,21.2},{-27.9,-30.8},{-20.7,-50.2},{-14.3,
                -64.2},{-8.7,-73.1},{-3,-78.4},{2.6,-80},{8.2,-77.6},{13.9,-71.5},
                {19.5,-61.9},{25.9,-47.2},{34,-24.8},{42,0}}, smooth=Smooth.Bezier),
          Text(
            extent={{-147,-152},{153,-112}},
            textString="f=%f"),
          Line(points={{42,1},{53.3,35.2},{60.5,54.1},{66.9,67.4},{72.6,75.6},{
                78.2,80.1},{83.8,80.8}})}),
      Documentation(info="<html>
<p>
The Real output y is a cosine signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Cosine.png\"
     alt=\"Cosine.png\">
</div>
</html>"));
  end Cosine;

  block SineVariableFrequencyAndAmplitude
    "Generate sine signal with variable frequency and amplitude"
    extends Interfaces.SO;
    import Modelica.Constants.pi;
    parameter Boolean useConstantAmplitude=false "Enable constant amplitude";
    parameter Real constantAmplitude=1 "Constant amplitude"
      annotation(Dialog(enable=useConstantAmplitude));
    parameter Boolean useConstantFrequency=false "Enable constant frequency";
    parameter SI.Frequency constantFrequency=1 "Constant frequency"
      annotation(Dialog(enable=useConstantFrequency));
    parameter Real offset=0 "Offset of the sine wave"
      annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/SineVariableFrequencyAndAmplitude.png"));
    SI.Angle phi(start=0) "Phase of the sine wave";
    Blocks.Interfaces.RealInput amplitude if not useConstantAmplitude "Amplitude"
                  annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          origin={-120,60})));
    Blocks.Interfaces.RealInput f(unit="Hz") if not useConstantFrequency
      "Frequency" annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          origin={-120,-60})));
  protected
    Blocks.Interfaces.RealInput amplitude_internal "Amplitude" annotation (Placement(
          transformation(
          extent={{-2,-2},{2,2}},
          origin={-80,60})));
    Blocks.Interfaces.RealInput f_internal(unit="Hz") "Frequency" annotation (Placement(
          transformation(
          extent={{-2,-2},{2,2}},
          origin={-80,-60})));
    Blocks.Sources.Constant amplitude_constant(final k=constantAmplitude) if
      useConstantAmplitude
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-80,30})));
    Blocks.Sources.Constant f_constant(final k=constantFrequency) if
      useConstantFrequency
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-80,-30})));
  equation
    der(phi) = 2*pi*f_internal;
    y = offset + amplitude_internal*sin(phi);
    connect(f, f_internal)
      annotation (Line(points={{-120,-60},{-80,-60}}, color={0,0,127}));
    connect(amplitude, amplitude_internal)
      annotation (Line(points={{-120,60},{-80,60}}, color={0,0,127}));
    connect(amplitude_constant.y, amplitude_internal)
      annotation (Line(points={{-80,41},{-80,60}}, color={0,0,127}));
    connect(f_constant.y, f_internal)
      annotation (Line(points={{-80,-41},{-80,-60}}, color={0,0,127}));
    annotation (defaultComponentName="sine",
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
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
  {80,-15.1}},     smooth = Smooth.Bezier)}),
      Documentation(info="<html>
<p>
This signal source provides a sinusoidal signal with variable frequency <code>f</code> and variable <code>amplitude</code>,
i.e. the phase angle of the sine wave is integrated from 2*&pi;*f.
</p>
<p>
Note that the initial value of the phase angle <code>phi</code> defines the initial phase shift,
and that the parameter <code>startTime</code> is omitted since the voltage can be kept equal to offset with setting the input <code>amplitude</code> to zero.
</p>
</html>"));
  end SineVariableFrequencyAndAmplitude;

  block CosineVariableFrequencyAndAmplitude
    "Generate cosine signal with variable frequency and amplitude"
    extends Interfaces.SO;
    import Modelica.Constants.pi;
    parameter Boolean useConstantAmplitude=false "Enable constant amplitude";
    parameter Real constantAmplitude=1 "Constant amplitude"
      annotation(Dialog(enable=useConstantAmplitude));
    parameter Boolean useConstantFrequency=false "Enable constant frequency";
    parameter SI.Frequency constantFrequency=1 "Constant frequency"
      annotation(Dialog(enable=useConstantFrequency));
    parameter Real offset=0 "Offset of the sine wave"
      annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/CosineVariableFrequencyAndAmplitude.png"));
    SI.Angle phi(start=0) "Phase of the sine wave";
    Blocks.Interfaces.RealInput amplitude if not useConstantAmplitude "Amplitude"
                  annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          origin={-120,60})));
    Blocks.Interfaces.RealInput f(unit="Hz") if not useConstantFrequency
      "Frequency" annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          origin={-120,-60})));
  protected
    Blocks.Interfaces.RealInput amplitude_internal "Amplitude" annotation (Placement(
          transformation(
          extent={{-2,-2},{2,2}},
          origin={-80,60})));
    Blocks.Interfaces.RealInput f_internal(unit="Hz") "Frequency" annotation (Placement(
          transformation(
          extent={{-2,-2},{2,2}},
          origin={-80,-60})));
    Blocks.Sources.Constant amplitude_constant(final k=constantAmplitude) if
      useConstantAmplitude
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-80,30})));
    Blocks.Sources.Constant f_constant(final k=constantFrequency) if
      useConstantFrequency
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-80,-30})));
  equation
    der(phi) = 2*pi*f_internal;
    y = offset + amplitude_internal*cos(phi);
    connect(f, f_internal)
      annotation (Line(points={{-120,-60},{-80,-60}}, color={0,0,127}));
    connect(amplitude, amplitude_internal)
      annotation (Line(points={{-120,60},{-80,60}}, color={0,0,127}));
    connect(amplitude_constant.y, amplitude_internal)
      annotation (Line(points={{-80,41},{-80,60}}, color={0,0,127}));
    connect(f_constant.y, f_internal)
      annotation (Line(points={{-80,-41},{-80,-60}}, color={0,0,127}));
    annotation (defaultComponentName="cosine",
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={
  {-80,80},{-78.4,79.6},{-76.8,79.2},{-75.2,78.8},{-73.6,78.4},{-72,78},
  {-70.4,77.5},{-68.8,77.1},{-67.2,76.6},{-65.6,76.1},{-64,75.6},
  {-62.4,75},{-60.8,74.4},{-59.2,73.7},{-57.6,73},{-56,72.2},
  {-54.4,71.3},{-52.8,70.3},{-51.2,69.2},{-49.6,68},{-48,66.6},
  {-46.4,65.2},{-44.8,63.6},{-43.2,61.8},{-41.6,59.9},{-40,57.7},
  {-38.4,55.5},{-36.8,53},{-35.2,50.3},{-33.6,47.5},{-32,44.4},
  {-30.4,41.1},{-28.8,37.7},{-27.2,34},{-25.6,30.1},{-24,26.1},
  {-22.4,21.9},{-20.8,17.5},{-19.2,13},{-17.6,8.3},{-16,3.5},
  {-14.4,-1.3},{-12.8,-6.2},{-11.2,-11.1},{-9.6,-16},{-8,-20.8},
  {-6.4,-25.5},{-4.8,-30.1},{-3.2,-34.5},{-1.6,-38.6},{0,-42.4},
  {1.6,-45.9},{3.2,-49},{4.8,-51.7},{6.4,-53.9},{8,-55.5},
  {9.6,-56.5},{11.2,-57},{12.8,-56.8},{14.4,-55.9},{16,-54.4},
  {17.6,-52.2},{19.2,-49.3},{20.8,-45.7},{22.4,-41.5},{24,-36.7},
  {25.6,-31.4},{27.2,-25.6},{28.8,-19.4},{30.4,-12.9},{32,-6.2},
  {33.6,0.6},{35.2,7.4},{36.8,14},{38.4,20.4},{40,26.3},
  {41.6,31.8},{43.2,36.5},{44.8,40.6},{46.4,43.7},{48,45.9},
  {49.6,47.1},{51.2,47.2},{52.8,46.2},{54.4,44.1},{56,41},
  {57.6,36.8},{59.2,31.8},{60.8,25.9},{62.4,19.4},{64,12.4},
  {65.6,5.1},{67.2,-2.2},{68.8,-9.5},{70.4,-16.4},{72,-22.8},
  {73.6,-28.4},{75.2,-33},{76.8,-36.6},{78.4,-38.9},{80,-39.8}},
      smooth = Smooth.Bezier)}),
      Documentation(info="<html>
<p>
This signal source provides a cosine signal with variable frequency <code>f</code> and variable <code>amplitude</code>,
i.e. the phase angle of the cosine wave is integrated from 2*&pi;*f.
</p>
<p>
Note that the initial value of the phase angle <code>phi</code> defines the initial phase shift,
and that the parameter <code>startTime</code> is omitted since the voltage can be kept equal to offset with setting the input <code>amplitude</code> to zero.
</p>
</html>"));
  end CosineVariableFrequencyAndAmplitude;

  block Sinc "Generate sinc signal"
    import Modelica.Constants.pi;
    import Modelica.Constants.eps;
    parameter Real amplitude=1 "Amplitude of sine wave"
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Sinc.png"));
    parameter SI.Frequency f(start=1) "Frequency of sine wave";
    extends Interfaces.SignalSource;
  protected
    SI.Angle x=2*pi*f*(time - startTime);
  equation
    y = offset + (if time < startTime then 0 else amplitude*
      (if noEvent(time - startTime < eps) then 1 else (sin(x))/x));
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-147,-152},{153,-112}},
            textString="f=%f",
            textColor={0,0,0}),
      Line(points={
        {-80, 80.0},{-76, 78.7},{-72, 74.8},{-68, 68.7},{-64, 60.5},
        {-60, 50.9},{-56, 40.4},{-52, 29.4},{-48, 18.7},{-44,  8.7},
        {-40,  0.0},{-36, -7.2},{-32,-12.5},{-28,-15.8},{-24,-17.3},
        {-20,-17.0},{-16,-15.1},{-12,-12.1},{ -8, -8.3},{ -4, -4.1},
        {  0,  0.0},{  4,  3.7},{  8,  6.8},{ 12,  9.0},{ 16, 10.1},
        { 20, 10.2},{ 24,  9.3},{ 28,  7.6},{ 32,  5.3},{ 36,  2.7},
        { 40,  0.0},{ 44, -2.5},{ 48, -4.7},{ 52, -6.2},{ 56, -7.1},
        { 60, -7.3},{ 64, -6.7},{ 68, -5.6},{ 72, -3.9},{ 76, -2.0},
        { 80,  0.0}}, smooth = Smooth.Bezier)}),
      Documentation(info="<html>
<p>
The Real output y is a sinc signal: <code> amplitude*(sin(2*&pi;*f*t))/((2*&pi;*f*t))</code>
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Sinc.png\"
     alt=\"Sinc.png\">
</div>
</html>"));
  end Sinc;

  block ExpSine "Generate exponentially damped sine signal"
    import Modelica.Constants.pi;
    parameter Real amplitude=1 "Amplitude of sine wave"
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/ExpSine.png"));
    parameter SI.Frequency f(start=2) "Frequency of sine wave";
    parameter SI.Angle phase=0 "Phase of sine wave";
    parameter SI.Damping damping(start=1)
      "Damping coefficient of sine wave";
    extends Interfaces.SignalSource;
  equation
    y = offset + (if time < startTime then 0 else amplitude*Modelica.Math.exp(-
      (time - startTime)*damping)*Modelica.Math.sin(2*pi*f*(time -
      startTime) + phase));
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,0},{-75.2,32.3},{-72,50.3},{-68.7,64.5},{-65.5,74.2},
                {-62.3,79.3},{-59.1,79.6},{-55.9,75.3},{-52.7,67.1},{-48.6,52.2},
                {-43,25.8},{-35,-13.9},{-30.2,-33.7},{-26.1,-45.9},{-22.1,-53.2},
                {-18.1,-55.3},{-14.1,-52.5},{-10.1,-45.3},{-5.23,-32.1},{8.44,
                13.7},{13.3,26.4},{18.1,34.8},{22.1,38},{26.9,37.2},{31.8,31.8},
                {38.2,19.4},{51.1,-10.5},{57.5,-21.2},{63.1,-25.9},{68.7,-25.9},
                {75.2,-20.5},{80,-13.8}}, smooth = Smooth.Bezier),
          Text(
            extent={{-147,-152},{153,-112}},
            textString="f=%f")}),
      Documentation(info="<html>
<p>
The Real output y is a sine signal with exponentially changing amplitude:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/ExpSine.png\"
     alt=\"ExpSine.png\">
</div>
</html>"));
  end ExpSine;

  block Exponentials "Generate a rising and falling exponential signal"

    parameter Real outMax=1 "Height of output for infinite riseTime"
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Exponentials.png"));
    parameter SI.Time riseTime(min=0,start=0.5) "Rise time";
    parameter SI.Time riseTimeConst(min=Modelica.Constants.small) = 0.1
      "Rise time constant; rising is defined as outMax*(1-exp(-riseTime/riseTimeConst))";
    parameter SI.Time fallTimeConst(min=Modelica.Constants.small)=
      riseTimeConst "Fall time constant";
    extends Interfaces.SignalSource;
  protected
    Real y_riseTime;

  equation
    y_riseTime = outMax*(1 - Modelica.Math.exp(-riseTime/riseTimeConst));
    y = offset + (if (time < startTime) then 0 else if (time < (startTime +
      riseTime)) then outMax*(1 - Modelica.Math.exp(-(time - startTime)/
      riseTimeConst)) else y_riseTime*Modelica.Math.exp(-(time - startTime -
      riseTime)/fallTimeConst));

    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-90,-70},{68,-70}}, color={192,192,192}),
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-70},{-77.2,-55.3},{-74.3,-42.1},{-70.8,-27.6},{-67.3,
                -15},{-63.7,-4.08},{-59.5,7.18},{-55.3,16.7},{-50.3,26},{-44.6,
                34.5},{-38.3,42.1},{-31.2,48.6},{-22.7,54.3},{-12.1,59.2},{-10,
                60},{-7.88,47.5},{-5.05,32.7},{-2.22,19.8},{0.606,8.45},{4.14,-3.7},
                {7.68,-14},{11.9,-24.2},{16.2,-32.6},{21.1,-40.5},{26.8,-47.4},
                {33.1,-53.3},{40.9,-58.5},{50.8,-62.8},{60,-65.4}}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
          Text(
            extent={{-150,-150},{150,-110}},
            textString="riseTime=%riseTime")}),
      Documentation(info="<html>
<p>
The Real output y is a rising exponential followed
by a falling exponential signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Exponentials.png\"
     alt=\"Exponentials.png\">
</div>
</html>"));
  end Exponentials;

  block Pulse "Generate pulse signal of type Real"
    parameter Real amplitude=1 "Amplitude of pulse"
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Pulse.png"));
    parameter Real width(
      final min=Modelica.Constants.small,
      final max=100) = 50 "Width of pulse in % of period";
    parameter SI.Time period(final min=Modelica.Constants.small,
        start=1) "Time for one period";
    parameter Integer nperiod=-1
      "Number of periods (< 0 means infinite number of periods)";
    extends Interfaces.SignalSource;
  protected
    SI.Time T_width=period*width/100;
    SI.Time T_start "Start time of current period";
    Integer count "Period count";
  initial algorithm
    count := integer((time - startTime)/period);
    T_start := startTime + count*period;
  equation
    when integer((time - startTime)/period) > pre(count) then
      count = pre(count) + 1;
      T_start = time;
    end when;
    y = offset + (if (time < startTime or nperiod == 0 or (nperiod > 0 and
      count >= nperiod)) then 0 else if time < T_start + T_width then amplitude
       else 0);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-70},{-40,-70},{-40,44},{0,44},{0,-70},{40,-70},{40,
                44},{79,44}}),
          Text(
            extent={{-147,-152},{153,-112}},
            textString="period=%period")}),
      Documentation(info="<html>
<p>
The Real output y is a pulse signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Pulse.png\"
     alt=\"Pulse.png\">
</div>
</html>"));
  end Pulse;

  block SawTooth "Generate saw tooth signal"
    parameter Real amplitude=1 "Amplitude of saw tooth"
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/SawTooth.png"));
    parameter SI.Time period(final min=Modelica.Constants.small,start=1)
      "Time for one period";
    parameter Integer nperiod=-1
      "Number of periods (< 0 means infinite number of periods)";
    extends Interfaces.SignalSource;
  protected
    SI.Time T_start(final start=startTime) "Start time of current period";
    Integer count "Period count";
  initial algorithm
    count := integer((time - startTime)/period);
    T_start := startTime + count*period;
  equation
    when integer((time - startTime)/period) > pre(count) then
      count = pre(count) + 1;
      T_start = time;
    end when;
    y = offset + (if (time < startTime or nperiod == 0 or (nperiod > 0 and
      count >= nperiod)) then 0 else amplitude*(time - T_start)/period);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-70},{-60,-70},{0,40},{0,-70},{60,41},{60,-70}}),
          Text(
            extent={{-147,-152},{153,-112}},
            textString="period=%period")}),
      Documentation(info="<html>
<p>
The Real output y is a saw tooth signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/SawTooth.png\"
     alt=\"SawTooth.png\">
</div>
</html>"));
  end SawTooth;

  block Trapezoid "Generate trapezoidal signal of type Real"
    parameter Real amplitude=1 "Amplitude of trapezoid"
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Trapezoid.png"));
    parameter SI.Time rising(final min=0) = 0
      "Rising duration of trapezoid";
    parameter SI.Time width(final min=0) = 0.5
      "Width duration of trapezoid";
    parameter SI.Time falling(final min=0) = 0
      "Falling duration of trapezoid";
    parameter SI.Time period(final min=Modelica.Constants.small, start=1)
      "Time for one period";
    parameter Integer nperiod=-1
      "Number of periods (< 0 means infinite number of periods)";
    extends Interfaces.SignalSource;
  protected
    parameter SI.Time T_rising=rising
      "End time of rising phase within one period";
    parameter SI.Time T_width=T_rising + width
      "End time of width phase within one period";
    parameter SI.Time T_falling=T_width + falling
      "End time of falling phase within one period";
    SI.Time T_start "Start time of current period";
    Integer count "Period count";
  initial algorithm
    count := integer((time - startTime)/period);
    T_start := startTime + count*period;
  equation
    when integer((time - startTime)/period) > pre(count) then
      count = pre(count) + 1;
      T_start = time;
    end when;
    y = offset + (if (time < startTime or nperiod == 0 or (nperiod > 0 and
      count >= nperiod)) then 0 else if (time < T_start + T_rising) then
      amplitude*(time - T_start)/rising else if (time < T_start + T_width)
       then amplitude else if (time < T_start + T_falling) then amplitude*(
      T_start + T_falling - time)/falling else 0);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-147,-152},{153,-112}},
            textString="period=%period"),
          Line(points={{-81,-70},{-60,-70},{-30,40},{9,40},{39,-70},{61,-70},{
                90,40}})}),
      Documentation(info="<html>
<p>
The Real output y is a trapezoid signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Trapezoid.png\"
     alt=\"Trapezoid\">
</div>
</html>"));
  end Trapezoid;

  block LogFrequencySweep "Logarithmic frequency sweep"
    extends Modelica.Blocks.Interfaces.SO;
    import Modelica.Constants.eps;
    parameter Real wMin(final min=eps) "Start frequency"
      annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/LogFrequencySweep.png"));
    parameter Real wMax(final min=eps) "End frequency";
    parameter SI.Time startTime=0 "Start time of frequency sweep";
    parameter SI.Time duration(min=0.0, start=1) "Duration of ramp (= 0.0 gives a Step)";
  equation
    y = if time < startTime then wMin else
      if time < (startTime + max(duration,eps)) then
        10^(log10(wMin) + (log10(wMax) - log10(wMin))*min(1, (time-startTime)/max(duration,eps)))
      else
        wMax;
     annotation (defaultComponentName="logSweep",
       Documentation(info="<html>
<p>The output <code>y</code> performs a logarithmic frequency sweep.
The logarithm of frequency <code>w</code> performs a linear ramp from <code>log10(wMin)</code> to <code>log10(wMax)</code>.
The output is the decimal power of this logarithmic ramp.
</p>
<p>For <code>time &lt; startTime</code> the output is equal to <code>wMin</code>.</p>
<p>For <code>time &gt; startTime+duration</code> the output is equal to <code>wMax</code>.</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/LogFrequencySweep.png\"
     alt=\"LogFrequencySweep.png\">
</div>

</html>"),
      Icon(graphics={
          Line(points={{-78,44},{80,44}}, color={192,192,192}),
          Line(points={{-78,34},{80,34}}, color={192,192,192}),
          Line(points={{-78,20},{80,20}}, color={192,192,192}),
          Line(points={{-78,-2},{80,-2}}, color={192,192,192}),
          Line(points={{-78,-48},{80,-48}}, color={192,192,192}),
          Line(
            points={{-70,-48},{-50,-48},{50,44},{70,44}},
            color={0,0,127},
            thickness=0.5),
          Line(points={{-50,-48},{-50,44}}, color={192,192,192}),
          Line(points={{50,-48},{50,44}}, color={192,192,192}),
          Line(points={{-78,40},{80,40}}, color={192,192,192}),
                                 Polygon(
                points={{90,-48},{68,-40},{68,-56},{90,-48}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
                          Polygon(
                points={{-70,90},{-78,68},{-62,68},{-70,90}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
          Line(points={{-70,-56},{-70,68}}, color={192,192,192})}));
  end LogFrequencySweep;

  block KinematicPTP
    "Move as fast as possible along a distance within given kinematic constraints"

    parameter Real deltaq[:]={1} "Distance to move"
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/KinematicPTP.png"));
    parameter Real qd_max[:](each final min=Modelica.Constants.small) = {1}
      "Maximum velocities der(q)";
    parameter Real qdd_max[:](each final min=Modelica.Constants.small) = {1}
      "Maximum accelerations der(qd)";
    parameter SI.Time startTime=0 "Time instant at which movement starts";

    extends Interfaces.MO(final nout=max([size(deltaq, 1); size(qd_max, 1); size(qdd_max, 1)]));

  protected
    parameter Real p_deltaq[nout]=(if size(deltaq, 1) == 1 then ones(nout)*
        deltaq[1] else deltaq);
    parameter Real p_qd_max[nout]=(if size(qd_max, 1) == 1 then ones(nout)*
        qd_max[1] else qd_max);
    parameter Real p_qdd_max[nout]=(if size(qdd_max, 1) == 1 then ones(nout)*
        qdd_max[1] else qdd_max);
    Real sd_max;
    Real sdd_max;
    Real sdd;
    Real aux1[nout];
    Real aux2[nout];
    SI.Time Ta1;
    SI.Time Ta2;
    SI.Time Tv;
    SI.Time Te;
    Boolean noWphase;

  equation
    for i in 1:nout loop
      aux1[i] = p_deltaq[i]/p_qd_max[i];
      aux2[i] = p_deltaq[i]/p_qdd_max[i];
    end for;
    sd_max = 1/max(abs(aux1));
    sdd_max = 1/max(abs(aux2));

    Ta1 = sqrt(1/sdd_max);
    Ta2 = sd_max/sdd_max;
    noWphase = Ta2 >= Ta1;
    Tv = if noWphase then Ta1 else 1/sd_max;
    Te = if noWphase then Ta1 + Ta1 else Tv + Ta2;

    // path-acceleration
    sdd = if time < startTime then 0 else ((if noWphase then (if time < Ta1 +
      startTime then sdd_max else (if time < Te + startTime then -sdd_max else
      0)) else (if time < Ta2 + startTime then sdd_max else (if time < Tv +
      startTime then 0 else (if time < Te + startTime then -sdd_max else 0)))));

    // acceleration
    y = p_deltaq*sdd;
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,78},{-80,-82}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,88},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{82,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-80,0},{-70,0},{-70,70},{-30,70},{-30,0},{20,0},{20,-70},{
                60,-70},{60,0},{68,0}}),
          Text(
            extent={{2,80},{80,20}},
            textColor={192,192,192},
            textString="acc"),
          Text(
            extent={{-150,-150},{150,-110}},
            textString="deltaq=%deltaq")}),
          Documentation(info="<html>
<p>
The goal is to move as <strong>fast</strong> as possible along a distance
<strong>deltaq</strong>
under given <strong>kinematical constraints</strong>. The distance can be a positional or
angular range. In robotics such a movement is called <strong>PTP</strong> (Point-To-Point).
This source block generates the <strong>acceleration</strong> qdd of this signal
as output:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/KinematicPTP.png\"
     alt=\"KinematicPTP.png\">
</div>

<p>
After integrating the output two times, the position q is
obtained. The signal is constructed in such a way that it is not possible
to move faster, given the <strong>maximally</strong> allowed <strong>velocity</strong> qd_max and
the <strong>maximally</strong> allowed <strong>acceleration</strong> qdd_max.
</p>
<p>
If several distances are given (vector deltaq has more than 1 element),
an acceleration output vector is constructed such that all signals
are in the same periods in the acceleration, constant velocity
and deceleration phase. This means that only one of the signals
is at its limits whereas the others are synchronized in such a way
that the end point is reached at the same time instant.
</p>

<p>
This element is useful to generate a reference signal for a controller
which controls a drive train or in combination with model
Modelica.Mechanics.Rotational.<strong>Accelerate</strong> to drive
a flange according to a given acceleration.
</p>

</html>", revisions="<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>June 27, 2001</em>
       by Bernhard Bachmann.<br>
       Bug fixed that element is also correct if startTime is not zero.</li>
<li><em>Nov. 3, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Vectorized and moved from Rotational to Blocks.Sources.</li>
<li><em>June 29, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       realized.</li>
</ul>
</html>"));
  end KinematicPTP;

  block KinematicPTP2
    "Move as fast as possible from start to end position within given kinematic constraints with output signals q, qd=der(q), qdd=der(qd)"

    parameter Real q_begin[:]={0} "Start position"
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/KinematicPTP2.png"));
    parameter Real q_end[:]={1} "End position";
    parameter Real qd_max[:](each final min=Modelica.Constants.small) = {1}
      "Maximum velocities der(q)";
    parameter Real qdd_max[:](each final min=Modelica.Constants.small) = {1}
      "Maximum accelerations der(qd)";
    parameter SI.Time startTime=0
      "Time instant at which movement starts";

    extends Modelica.Blocks.Icons.Block;
    final parameter Integer nout=max([size(q_begin, 1); size(q_end, 1); size(qd_max, 1); size(qdd_max, 1)])
      "Number of output signals (= dimension of q, qd, qdd, moving)";
    output SI.Time endTime "Time instant at which movement stops";

    Modelica.Blocks.Interfaces.RealOutput q[nout]
      "Reference position of path planning" annotation (Placement(
          transformation(extent={{100,70},{120,90}})));
    Modelica.Blocks.Interfaces.RealOutput qd[nout]
      "Reference speed of path planning" annotation (Placement(transformation(
            extent={{100,20},{120,40}})));
    Modelica.Blocks.Interfaces.RealOutput qdd[nout]
      "Reference acceleration of path planning" annotation (Placement(
          transformation(extent={{100,-40},{120,-20}})));
    Modelica.Blocks.Interfaces.BooleanOutput moving[nout]
      "= true, if end position not yet reached; = false, if end position reached or axis is completely at rest"
      annotation (Placement(transformation(extent={{100,-90},{120,-70}})));

  protected
    parameter Real p_q_begin[nout]=(if size(q_begin, 1) == 1 then ones(nout)*
        q_begin[1] else q_begin);
    parameter Real p_q_end[nout]=(if size(q_end, 1) == 1 then ones(nout)*q_end[
        1] else q_end);
    parameter Real p_qd_max[nout]=(if size(qd_max, 1) == 1 then ones(nout)*
        qd_max[1] else qd_max);
    parameter Real p_qdd_max[nout]=(if size(qdd_max, 1) == 1 then ones(nout)*
        qdd_max[1] else qdd_max);
    parameter Real p_deltaq[nout]=p_q_end - p_q_begin;
    constant Real eps=10*Modelica.Constants.eps;
    Boolean motion_ref;
    Real sd_max_inv;
    Real sdd_max_inv;
    Real sd_max;
    Real sdd_max;
    Real sdd;
    Real aux1[nout];
    Real aux2[nout];
    SI.Time Ta1;
    SI.Time Ta2;
    SI.Time Tv;
    SI.Time Te;
    Boolean noWphase;
    SI.Time Ta1s;
    SI.Time Ta2s;
    SI.Time Tvs;
    SI.Time Tes;
    Real sd_max2;
    Real s1;
    Real s2;
    Real s3;
    Real s;
    Real sd;

  equation
    for i in 1:nout loop
      aux1[i] = p_deltaq[i]/p_qd_max[i];
      aux2[i] = p_deltaq[i]/p_qdd_max[i];
    end for;

    sd_max_inv = max(abs(aux1));
    sdd_max_inv = max(abs(aux2));

    if sd_max_inv <= eps or sdd_max_inv <= eps then
      sd_max = 0;
      sdd_max = 0;
      Ta1 = 0;
      Ta2 = 0;
      noWphase = false;
      Tv = 0;
      Te = 0;
      Ta1s = 0;
      Ta2s = 0;
      Tvs = 0;
      Tes = 0;
      sd_max2 = 0;
      s1 = 0;
      s2 = 0;
      s3 = 0;
      s = 0;
    else
      sd_max = 1/max(abs(aux1));
      sdd_max = 1/max(abs(aux2));
      Ta1 = sqrt(1/sdd_max);
      Ta2 = sd_max/sdd_max;
      noWphase = Ta2 >= Ta1;
      Tv = if noWphase then Ta1 else 1/sd_max;
      Te = if noWphase then Ta1 + Ta1 else Tv + Ta2;
      Ta1s = Ta1 + startTime;
      Ta2s = Ta2 + startTime;
      Tvs = Tv + startTime;
      Tes = Te + startTime;
      sd_max2 = sdd_max*Ta1;
      s1 = sdd_max*(if noWphase then Ta1*Ta1 else Ta2*Ta2)/2;
      s2 = s1 + (if noWphase then sd_max2*(Te - Ta1) - (sdd_max/2)*(Te - Ta1)^2
         else sd_max*(Tv - Ta2));
      s3 = s2 + sd_max*(Te - Tv) - (sdd_max/2)*(Te - Tv)*(Te - Tv);

      if time < startTime then
        s = 0;
      elseif noWphase then
        if time < Ta1s then
          s = (sdd_max/2)*(time - startTime)*(time - startTime);
        elseif time < Tes then
          s = s1 + sd_max2*(time - Ta1s) - (sdd_max/2)*(time - Ta1s)*(time -
            Ta1s);
        else
          s = s2;
        end if;
      elseif time < Ta2s then
        s = (sdd_max/2)*(time - startTime)*(time - startTime);
      elseif time < Tvs then
        s = s1 + sd_max*(time - Ta2s);
      elseif time < Tes then
        s = s2 + sd_max*(time - Tvs) - (sdd_max/2)*(time - Tvs)*(time - Tvs);
      else
        s = s3;
      end if;

    end if;

    sd = der(s);
    sdd = der(sd);

    qdd = p_deltaq*sdd;
    qd = p_deltaq*sd;
    q = p_q_begin + p_deltaq*s;
    endTime = Tes;

    // report when axis is moving
    motion_ref = time < endTime;
    for i in 1:nout loop
      moving[i] = if abs(q_begin[i] - q_end[i]) > eps then motion_ref else
        false;
    end for;

    annotation (
      defaultComponentName="kinematicPTP",
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,78},{-80,-82}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,88},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{17,0}}, color={192,192,192}),
          Line(
            points={{-80,0},{-70,0},{-70,70},{-50,70},{-50,0},{-15,0},{-15,-70},
                {5,-70},{5,0},{18,0}}),
          Text(
            extent={{34,96},{94,66}},
            textString="q"),
          Text(
            extent={{40,44},{96,14}},
            textString="qd"),
          Text(
            extent={{32,-18},{99,-44}},
            textString="qdd"),
          Text(
            extent={{-32,-74},{97,-96}},
            textString="moving")}),
      Documentation(info="<html>
<p>
The goal is to move as <strong>fast</strong> as possible from start position <strong>q_begin</strong>
to end position <strong>q_end</strong>
under given <strong>kinematical constraints</strong>. The positions can be translational or
rotational definitions (i.e., q_begin/q_end is given). In robotics such a movement is called <strong>PTP</strong> (Point-To-Point).
This source block generates the <strong>position</strong> q(t), the
<strong>speed</strong> qd(t) = der(q), and the <strong>acceleration</strong> qdd = der(qd)
as output. The signals are constructed in such a way that it is not possible
to move faster, given the <strong>maximally</strong> allowed <strong>velocity</strong> qd_max and
the <strong>maximally</strong> allowed <strong>acceleration</strong> qdd_max:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/KinematicPTP2.png\"
     alt=\"KinematicPTP2.png\">
</div>

<p>
If vectors q_begin/q_end have more than 1 element,
the output vectors are constructed such that all signals
are in the same periods in the acceleration, constant velocity
and deceleration phase. This means that only one of the signals
is at its limits whereas the others are synchronized in such a way
that the end point is reached at the same time instant.
</p>

<p>
This element is useful to generate a reference signal for a controller
which controls, e.g., a drive train, or to drive
a flange according to a given acceleration.
</p>

</html>", revisions="<html>
<ul>
<li><em>March 24, 2007</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Non-standard Modelica function \"constrain(..)\" replaced by standard
       Modelica implementation (via internal function position()).<br>
       New output signal \"moving\" added.</li>
<li><em>June 27, 2001</em>
       by Bernhard Bachmann.<br>
       Bug fixed that element is also correct if startTime is not zero.</li>
<li><em>Nov. 3, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Vectorized and moved from Rotational to Blocks.Sources.</li>
<li><em>June 29, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       realized.</li>
</ul>
</html>"));
  end KinematicPTP2;

  block TimeTable
    "Generate a (possibly discontinuous) signal by linear interpolation in a table"

    parameter Real table[:, 2] = fill(0.0, 0, 2)
      "Table matrix (time = first column; e.g., table=[0, 0; 1, 1; 2, 4])"
      annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/TimeTable.png"));
    parameter SI.Time timeScale(
      min=Modelica.Constants.eps)=1 "Time scale of first table column"
      annotation (Evaluate=true);
    extends Interfaces.SignalSource;
    parameter SI.Time shiftTime=startTime
      "Shift time of first table column";
  protected
    discrete Real a "Interpolation coefficient a of actual interval (y=a*x+b)";
    discrete Real b "Interpolation coefficient b of actual interval (y=a*x+b)";
    Integer last(start=1) "Last used lower grid index";
    discrete SI.Time nextEvent(start=0, fixed=true) "Next event instant";
    discrete Real nextEventScaled(start=0, fixed=true)
      "Next scaled event instant";
    Real timeScaled "Scaled time";

    function getInterpolationCoefficients
      "Determine interpolation coefficients and next time event"
      extends Modelica.Icons.Function;
      input Real table[:, 2] "Table for interpolation";
      input Real offset "y-offset";
      input Real startTimeScaled "Scaled time-offset";
      input Real timeScaled "Actual scaled time instant";
      input Integer last "Last used lower grid index";
      input Real TimeEps "Relative epsilon to check for identical time instants";
      input Real shiftTimeScaled "Time shift";
      output Real a "Interpolation coefficient a (y=a*x + b)";
      output Real b "Interpolation coefficient b (y=a*x + b)";
      output Real nextEventScaled "Next scaled event instant";
      output Integer next "New lower grid index";
    protected
      Integer columns=2 "Column to be interpolated";
      Integer ncol=2 "Number of columns to be interpolated";
      Integer nrow=size(table, 1) "Number of table rows";
      Integer next0;
      Real tp;
      Real dt;
    algorithm
      next := last;
      nextEventScaled := timeScaled - TimeEps*abs(timeScaled);
      // in case there are no more time events
      tp := timeScaled + TimeEps*abs(timeScaled);

      if tp < startTimeScaled then
        // First event not yet reached
        nextEventScaled := startTimeScaled;
        a := 0;
        b := offset;
      elseif nrow < 2 then
        // Special action if table has only one row
        a := 0;
        b := offset + table[1, columns];
      else
        tp := tp - shiftTimeScaled;
        // Find next time event instant. Note, that two consecutive time instants
        // in the table may be identical due to a discontinuous point.
        while next < nrow and tp >= table[next, 1] loop
          next := next + 1;
        end while;

        // Define next time event, if last table entry not reached
        if next < nrow then
          nextEventScaled := shiftTimeScaled + table[next, 1];
        end if;

        // Determine interpolation coefficients
        if next == 1 then
          next := 2;
        end if;
        next0 := next - 1;
        dt := table[next, 1] - table[next0, 1];
        if dt <= TimeEps*abs(table[next, 1]) then
          // Interpolation interval is not big enough, use "next" value
          a := 0;
          b := offset + table[next, columns];
        else
          a := (table[next, columns] - table[next0, columns])/dt;
          b := offset + table[next0, columns] - a*table[next0, 1];
        end if;
      end if;
      // Take into account shiftTimeScaled "a*(time - shiftTime) + b"
      b := b - a*shiftTimeScaled;
    end getInterpolationCoefficients;
  algorithm
    if noEvent(size(table, 1) > 1) then
      assert(not (table[1, 1] > 0.0 or table[1, 1] < 0.0), "The first point in time has to be set to 0, but is table[1,1] = " + String(table[1, 1]));
    end if;
    when {time >= pre(nextEvent),initial()} then
      (a,b,nextEventScaled,last) := getInterpolationCoefficients(
          table,
          offset,
          startTime/timeScale,
          timeScaled,
          last,
          100*Modelica.Constants.eps,
          shiftTime/timeScale);
      nextEvent := nextEventScaled*timeScale;
    end when;
  equation
    assert(size(table, 1) > 0, "No table values defined.");
    timeScaled = time/timeScale;
    y = a*timeScaled + b;
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-48,70},{2,-50}},
            lineColor={255,255,255},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-48,-50},{-48,70},{52,70},{52,-50},{-48,-50},{-48,-20},
                {52,-20},{52,10},{-48,10},{-48,40},{52,40},{52,70},{2,70},{2,-51}}),
          Text(
            extent={{-150,-150},{150,-110}},
            textString="offset=%offset")}),
          Documentation(info="<html>
<p>
This block generates an output signal by <strong>linear interpolation</strong> in
a table. The time points and function values are stored in a matrix
<strong>table[i,j]</strong>, where the first column table[:,1] contains the
time points and the second column contains the data to be interpolated.
The table interpolation has the following properties:
</p>
<ul>
<li>The interpolation interval is found by a linear search where the interval used in the
    last call is used as start interval.</li>
<li>The time points need to be <strong>monotonically increasing</strong>.</li>
<li><strong>Discontinuities</strong> are allowed, by providing the same
    time point twice in the table.</li>
<li>Values <strong>outside</strong> of the table range, are computed by
    <strong>extrapolation</strong> through the last or first two points of the
    table.</li>
<li>If the table has only <strong>one row</strong>, no interpolation is performed and
    the function value is just returned independently of the actual time instant.</li>
<li>Via parameters <strong>shiftTime</strong> and <strong>offset</strong> the curve defined
    by the table can be shifted both in time and in the ordinate value.
    The time instants stored in the table are therefore <strong>relative</strong>
    to <strong>shiftTime</strong>.</li>
<li>If time &lt; startTime, no interpolation is performed and the offset
    is used as ordinate value for the output.</li>
<li>If the table has more than one row, the first point in time <strong>always</strong> has to be set to <strong>0</strong>, e.g.,
    <strong>table=[1,1;2,2]</strong> is <strong>illegal</strong>. If you want to
    shift the time table in time use the <strong>shiftTime</strong> parameter instead.</li>
<li>The table is implemented in a numerically sound way by
    generating <strong>time events</strong> at interval boundaries.
    This generates continuously differentiable values for the integrator.</li>
<li>Via parameter <strong>timeScale</strong> the first column of the table array can
    be scaled, e.g., if the table array is given in hours (instead of seconds)
    <strong>timeScale</strong> shall be set to 3600.</li>
</ul>
<p>
Example:
</p>
<blockquote><pre>
   table = [0, 0;
            1, 0;
            1, 1;
            2, 4;
            3, 9;
            4, 16];
If, e.g., time = 1.0, the output y =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the output y =  2.5,
    e.g., time = 2.0, the output y =  4.0,
    e.g., time = 5.0, the output y = 23.0 (i.e., extrapolation).
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/TimeTable.png\"
     alt=\"TimeTable.png\">
</div>

</html>", revisions="<html>
<h4>Release Notes</h4>
<ul>
<li><em>Oct. 21, 2002</em>
       by Christian Schweiger:<br>
       Corrected interface from
<blockquote><pre>
parameter Real table[:, :]=[0, 0; 1, 1; 2, 4];
</pre></blockquote>
       to
<blockquote><pre>
parameter Real table[:, <strong>2</strong>]=[0, 0; 1, 1; 2, 4];
</pre></blockquote>
       </li>
<li><em>Nov. 7, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
</html>"));
  end TimeTable;

  block CombiTimeTable
    "Table look-up with respect to time and linear/periodic extrapolation methods (data from matrix/file)"
    import Modelica.Blocks.Tables.Internal;
    extends Modelica.Blocks.Interfaces.MO(final nout=max([size(columns, 1); size(offset, 1)]));
    parameter Boolean tableOnFile=false
      "= true, if table is defined on file or in function usertab"
      annotation (Dialog(group="Table data definition"));
    parameter Real table[:, :] = fill(0.0, 0, 2)
      "Table matrix (time = first column; e.g., table=[0, 0; 1, 1; 2, 4])"
      annotation (Dialog(group="Table data definition",enable=not tableOnFile));
    parameter String tableName="NoName"
      "Table name on file or in function usertab (see docu)"
      annotation (Dialog(group="Table data definition",enable=tableOnFile));
    parameter String fileName="NoName" "File where matrix is stored"
      annotation (Dialog(
        group="Table data definition",
        enable=tableOnFile,
        loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
            caption="Open file in which table is present")));
    parameter Boolean verboseRead=true
      "= true, if info message that file is loading is to be printed"
      annotation (Dialog(group="Table data definition",enable=tableOnFile));
    parameter Integer columns[:]=2:size(table, 2)
      "Columns of table to be interpolated"
      annotation (Dialog(group="Table data interpretation",
      groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/CombiTimeTable.png"));
    parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
      "Smoothness of table interpolation"
      annotation (Dialog(group="Table data interpretation"));
    parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints
      "Extrapolation of data outside the definition range"
      annotation (Dialog(group="Table data interpretation"));
    parameter SI.Time timeScale(
      min=Modelica.Constants.eps)=1 "Time scale of first table column"
      annotation (Dialog(group="Table data interpretation"), Evaluate=true);
    parameter Real offset[:]={0} "Offsets of output signals"
      annotation (Dialog(group="Table data interpretation"));
    parameter SI.Time startTime=0
      "Output = offset for time < startTime"
      annotation (Dialog(group="Table data interpretation"));
    parameter SI.Time shiftTime=startTime
      "Shift time of first table column"
      annotation (Dialog(group="Table data interpretation"));
    parameter Modelica.Blocks.Types.TimeEvents timeEvents=Modelica.Blocks.Types.TimeEvents.Always
      "Time event handling of table interpolation"
      annotation (Dialog(group="Table data interpretation", enable=smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments));
    parameter Boolean verboseExtrapolation=false
      "= true, if warning messages are to be printed if time is outside the table definition range"
      annotation (Dialog(group="Table data interpretation", enable=extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    final parameter SI.Time t_min=t_minScaled*timeScale
      "Minimum abscissa value defined in table";
    final parameter SI.Time t_max=t_maxScaled*timeScale
      "Maximum abscissa value defined in table";
    final parameter Real t_minScaled=Internal.getTimeTableTmin(tableID)
      "Minimum (scaled) abscissa value defined in table";
    final parameter Real t_maxScaled=Internal.getTimeTableTmax(tableID)
      "Maximum (scaled) abscissa value defined in table";
  protected
    final parameter Real p_offset[nout]=(if size(offset, 1) == 1 then ones(nout)*offset[1] else offset)
      "Offsets of output signals";
    parameter Modelica.Blocks.Types.ExternalCombiTimeTable tableID=
        Modelica.Blocks.Types.ExternalCombiTimeTable(
          if tableOnFile then tableName else "NoName",
          if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName",
          table,
          startTime/timeScale,
          columns,
          smoothness,
          extrapolation,
          shiftTime/timeScale,
          if smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then timeEvents elseif smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then Modelica.Blocks.Types.TimeEvents.Always else Modelica.Blocks.Types.TimeEvents.NoTimeEvents,
          if tableOnFile then verboseRead else false) "External table object";
    discrete SI.Time nextTimeEvent(start=0, fixed=true)
      "Next time event instant";
    discrete Real nextTimeEventScaled(start=0, fixed=true)
      "Next scaled time event instant";
    Real timeScaled "Scaled time";
  equation
    if tableOnFile then
      assert(tableName <> "NoName",
        "tableOnFile = true and no table name given");
    else
      assert(size(table, 1) > 0 and size(table, 2) > 0,
        "tableOnFile = false and parameter table is an empty matrix");
    end if;

    if verboseExtrapolation and (
      extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or
      extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint) then
      assert(noEvent(time >= t_min), "
Extrapolation warning: Time (=" + String(time) + ") must be greater or equal
than the minimum abscissa value t_min (=" + String(t_min) + ") defined in the table.
", level=AssertionLevel.warning);
      assert(noEvent(time <= t_max), "
Extrapolation warning: Time (=" + String(time) + ") must be less or equal
than the maximum abscissa value t_max (=" + String(t_max) + ") defined in the table.
", level=AssertionLevel.warning);
    end if;

    timeScaled = time/timeScale;
    when {time >= pre(nextTimeEvent), initial()} then
      nextTimeEventScaled = Internal.getNextTimeEvent(tableID, timeScaled);
      nextTimeEvent = if nextTimeEventScaled < Modelica.Constants.inf then nextTimeEventScaled*timeScale else Modelica.Constants.inf;
    end when;
    if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
      for i in 1:nout loop
        y[i] = p_offset[i] + Internal.getTimeTableValueNoDer(tableID, i, timeScaled, nextTimeEventScaled, pre(nextTimeEventScaled));
      end for;
    elseif smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then
      for i in 1:nout loop
        y[i] = p_offset[i] + Internal.getTimeTableValueNoDer2(tableID, i, timeScaled, nextTimeEventScaled, pre(nextTimeEventScaled));
      end for;
    else
      for i in 1:nout loop
        y[i] = p_offset[i] + Internal.getTimeTableValue(tableID, i, timeScaled, nextTimeEventScaled, pre(nextTimeEventScaled));
      end for;
    end if;
    annotation (
      Documentation(info="<html>
<p>
This block generates an output signal y[:] by <strong>constant</strong>,
<strong>linear</strong> or <strong>cubic Hermite spline interpolation</strong>
in a table. The time points and function values are stored in a matrix
<strong>table[i,j]</strong>, where the first column table[:,1] contains the
time points and the other columns contain the data to be interpolated.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/CombiTimeTable.png\"
     alt=\"CombiTimeTable.png\">
</div>

<p>
Via parameter <strong>columns</strong> it can be defined which columns of the
table are interpolated. If, e.g., columns={2,4}, it is assumed that
2 output signals are present and that the first output is computed
by interpolation of column 2 and the second output is computed
by interpolation of column 4 of the table matrix.
The table interpolation has the following properties:
</p>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
<li>The time points need to be <strong>strictly increasing</strong> for cubic Hermite
    spline interpolation, otherwise <strong>monotonically increasing</strong>.</li>
<li><strong>Discontinuities</strong> are allowed for (constant or) linear interpolation,
    by providing the same time point twice in the table.</li>
<li>Via parameter <strong>smoothness</strong> it is defined how the data is interpolated:
<blockquote><pre>
smoothness = 1: Linear interpolation
           = 2: Akima interpolation: Smooth interpolation by cubic Hermite
                splines such that der(y) is continuous, also if extrapolated.
           = 3: Constant segments
           = 4: Fritsch-Butland interpolation: Smooth interpolation by cubic
                Hermite splines such that y preserves the monotonicity and
                der(y) is continuous, also if extrapolated.
           = 5: Steffen interpolation: Smooth interpolation by cubic Hermite
                splines such that y preserves the monotonicity and der(y)
                is continuous, also if extrapolated.
           = 6: Modified Akima interpolation: Smooth interpolation by cubic
                Hermite splines such that der(y) is continuous, also if
                extrapolated. Additionally, overshoots and edge cases of the
                original Akima interpolation method are avoided.
</pre></blockquote></li>
<li>First and second <strong>derivatives</strong> are provided, with exception of the following two smoothness options.
<ol>
<li>No derivatives are provided for interpolation by constant segments.</li>
<li>No second derivative is provided for linear interpolation.<br>There is a design inconsistency, that it is possible
to model a signal consisting of constant segments using linear interpolation and duplicated sample points.
In contrast to interpolation by constant segments, the first derivative is provided as zero.</li>
</ol></li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the first or last value of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (If smoothness is LinearSegments or ConstantSegments
                   this means to extrapolate linearly through the first/last
                   two table points.).
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>If the table has only <strong>one row</strong>, no interpolation is performed and
    the table values of this row are just returned.</li>
<li>Via parameters <strong>shiftTime</strong> and <strong>offset</strong> the curve defined
    by the table can be shifted both in time and in the ordinate value.
    The time instants stored in the table are therefore <strong>relative</strong>
    to <strong>shiftTime</strong>.</li>
<li>If time &lt; startTime, no interpolation is performed and the offset
    is used as ordinate value for all outputs.</li>
<li>The table is implemented in a numerically sound way by
    generating <strong>time events</strong> at interval boundaries, in case of
    interpolation by linear segments.
    This generates continuously differentiable values for the integrator.
    Via parameter <strong>timeEvents</strong> it is defined how the time events are generated:
<blockquote><pre>
timeEvents = 1: Always generate time events at interval boundaries
           = 2: Generate time events at discontinuities (defined by duplicated sample points)
           = 3: No time events at interval boundaries
</pre></blockquote>
    For interpolation by constant segments time events are always generated at interval boundaries.
    For smooth interpolation by cubic Hermite splines no time events are generated at interval boundaries.</li>
<li>Via parameter <strong>timeScale</strong> the first column of the table array can
    be scaled, e.g., if the table array is given in hours (instead of seconds)
    <strong>timeScale</strong> shall be set to 3600.</li>
<li>For special applications it is sometimes needed to know the minimum
    and maximum time instant defined in the table as a parameter. For this
    reason parameters <strong>t_min</strong>/<strong>t_minScaled</strong> and
    <strong>t_max</strong>/<strong>t_maxScaled</strong> are provided and can be
    accessed from the outside of the table object. Whereas <strong>t_min</strong> and
    <strong>t_max</strong> define the scaled abscissa values (using parameter
    <strong>timeScale</strong>) in SI.Time, <strong>t_minScaled</strong> and
    <strong>t_maxScaled</strong> define the unitless original abscissa values of
    the table.</li>
</ul>
<p>
Example:
</p>
<blockquote><pre>
table = [0, 0;
         1, 0;
         1, 1;
         2, 4;
         3, 9;
         4, 16];
extrapolation = 2 (default), timeEvents = 2
If, e.g., time = 1.0, the output y =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the output y =  2.5,
    e.g., time = 2.0, the output y =  4.0,
    e.g., time = 5.0, the output y = 23.0 (i.e., extrapolation via last 2 points).
</pre></blockquote>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li>Explicitly supplied as <strong>parameter matrix</strong> \"table\",
    and the other parameters have the following values:
<blockquote><pre>
tableName is \"NoName\" or has only blanks,
fileName  is \"NoName\" or has only blanks.
</pre></blockquote></li>
<li><strong>Read</strong> from a <strong>file</strong> \"fileName\" where the matrix is stored as
    \"tableName\". Both text and MATLAB MAT-file format is possible.
    (The text format is described below).
    The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
    The library supports at least v4, v6 and v7 whereas v7.3 is optional.
    It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
    by command
<blockquote><pre>
save tables.mat tab1 tab2 tab3
</pre></blockquote>
    or Scilab by command
<blockquote><pre>
savematfile tables.mat tab1 tab2 tab3
</pre></blockquote>
    when the three tables tab1, tab2, tab3 should be used from the model.<br>
    Note, a fileName can be defined as URI by using the helper function
    <a href=\"modelica://Modelica.Utilities.Files.loadResource\">loadResource</a>.</li>
<li>Statically stored in function \"usertab\" in file \"usertab.c\".
    The matrix is identified by \"tableName\". Parameter
    fileName = \"NoName\" or has only blanks. Row-wise storage is always to be
    preferred as otherwise the table is reallocated and transposed.</li>
</ol>
<p>
When the constant \"NO_FILE_SYSTEM\" is defined, all file I/O related parts of the
source code are removed by the C-preprocessor, such that no access to files takes place.
</p>
<p>
If tables are read from a text file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double tab1(6,2)   # comment line
  0   0
  1   0
  1   1
  2   4
  3   9
  4  16
double tab2(6,2)   # another comment line
  0   0
  2   0
  2   2
  4   8
  6  18
  8  32
-----------------------------------------------------
</pre></blockquote>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
Finally, in successive rows of the file, the elements of the matrix
have to be given. The elements have to be provided as a sequence of
numbers in row-wise order (therefore a matrix row can span several
lines in the file and need not start at the beginning of a line).
Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4).
Number separators are spaces, tab (\\t), comma (,), or semicolon (;).
Several matrices may be defined one after another. Line comments start
with the hash symbol (#) and can appear everywhere.
Text files should either be ASCII or UTF-8 encoded, where UTF-8 encoded strings are only allowed in line comments and an optional UTF-8 BOM at the start of the text file is ignored.
Other characters, like trailing non comments, are not allowed in the file.
</p>
<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>", revisions="<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>April 09, 2013</em>
       by Thomas Beutlich:<br>
       Implemented as external object.</li>
<li><em>March 31, 2001</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Used CombiTableTime as a basis and added the
       arguments <strong>extrapolation, columns, startTime</strong>.
       This allows periodic function definitions.</li>
</ul>
</html>"),
      Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Polygon(lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid,
        points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
      Line(points={{-80.0,68.0},{-80.0,-80.0}},
        color={192,192,192}),
      Line(points={{-90.0,-70.0},{82.0,-70.0}},
        color={192,192,192}),
      Polygon(lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid,
        points={{90.0,-70.0},{68.0,-62.0},{68.0,-78.0},{90.0,-70.0}}),
      Rectangle(lineColor={255,255,255},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-48.0,-50.0},{2.0,70.0}}),
      Line(points={{-48.0,-50.0},{-48.0,70.0},{52.0,70.0},{52.0,-50.0},{-48.0,-50.0},{-48.0,-20.0},{52.0,-20.0},{52.0,10.0},{-48.0,10.0},{-48.0,40.0},{52.0,40.0},{52.0,70.0},{2.0,70.0},{2.0,-51.0}})}));
  end CombiTimeTable;

  block BooleanConstant "Generate constant signal of type Boolean"
    parameter Boolean k=true "Constant output value"
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/BooleanConstant.png"));
    extends Interfaces.partialBooleanSource;

  equation
    y = k;
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={Line(points={{-80,0},{80,0}}),
            Text(
            extent={{-150,-140},{150,-110}},
            textString="%k")}),
        Documentation(info="<html>
<p>
The Boolean output y is a constant signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/BooleanConstant.png\"
     alt=\"BooleanConstant.png\">
</div>
</html>"));
  end BooleanConstant;

  block BooleanStep "Generate step signal of type Boolean"
    parameter SI.Time startTime=0 "Time instant of step start"
     annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/BooleanStep.png"));
    parameter Boolean startValue=false "Output before startTime";

    extends Interfaces.partialBooleanSource;
  equation
    y = if time >= startTime then not startValue else startValue;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(
            visible=not startValue,
            points={{-80,-70},{0,-70},{0,50},{80,50}}),
          Line(
            visible=startValue,
            points={{-80,50},{0,50},{0,-70},{68,-70}}),
          Text(
            extent={{-150,-140},{150,-110}},
            textString="%startTime")}),
      Documentation(info="<html>
<p>
The Boolean output y is a step signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/BooleanStep.png\"
     alt=\"BooleanStep.png\">
</div>
</html>"));
  end BooleanStep;

  block BooleanPulse "Generate pulse signal of type Boolean"

    parameter Real width(
      final min=Modelica.Constants.small,
      final max=100) = 50 "Width of pulse in % of period"
      annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/BooleanPulse.png"));
    parameter SI.Time period(final min=Modelica.Constants.small,
        start=1) "Time for one period";
    parameter SI.Time startTime=0 "Time instant of first pulse";
    extends Modelica.Blocks.Interfaces.partialBooleanSource;

  protected
    parameter SI.Time Twidth=period*width/100
      "Width of one pulse" annotation (HideResult=true);
    discrete SI.Time pulseStart "Start time of pulse"
      annotation (HideResult=true);
  initial equation
    pulseStart = startTime;
  equation
    when sample(startTime, period) then
      pulseStart = time;
    end when;
    y = time >= pulseStart and time < pulseStart + Twidth;
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={Text(
            extent={{-150,-140},{150,-110}},
            textString="%period"), Line(points={{-80,-70},{-40,-70},{-40,44},{0,
                44},{0,-70},{40,-70},{40,44},{79,44}})}),
        Documentation(info="<html>
<p>
The Boolean output y is a pulse signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Pulse.png\"
     alt=\"Pulse.png\">
</div>
</html>"));
  end BooleanPulse;

  block SampleTrigger "Generate sample trigger signal"
    parameter SI.Time period(final min=Modelica.Constants.small,
        start=0.01) "Sample period"
      annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/SampleTrigger.png"));
    parameter SI.Time startTime=0
      "Time instant of first sample trigger";
    extends Interfaces.partialBooleanSource;

  equation
    y = sample(startTime, period);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-60,-70},{-60,70}}),
          Line(points={{-20,-70},{-20,70}}),
          Line(points={{20,-70},{20,70}}),
          Line(points={{60,-70},{60,70}}),
          Text(
            extent={{-150,-140},{150,-110}},
            textString="%period")}),
        Documentation(info="<html>
<p>
The Boolean output y is a trigger signal where the output y is only <strong>true</strong>
at sample times (defined by parameter <strong>period</strong>) and is otherwise
<strong>false</strong>.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/SampleTrigger.png\"
     alt=\"SampleTrigger.png\">
</div>
</html>"));
  end SampleTrigger;

  block BooleanTable
    "Generate a Boolean output signal based on a vector of time instants"

    parameter SI.Time table[:]={0,1}
      "Vector of time points. At every time point, the output y gets its opposite value (e.g., table={0,1})" annotation(Dialog(group="Table data definition"));
    parameter Boolean startValue=false
      "Start value of y. At time = table[1], y changes to 'not startValue'" annotation(Dialog(group="Table data interpretation",
      groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/BooleanTable.png"));
    parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint
      "Extrapolation of data outside the definition range" annotation(Dialog(group="Table data interpretation"));
    parameter SI.Time startTime=-Modelica.Constants.inf
      "Output = false for time < startTime" annotation(Dialog(group="Table data interpretation"));
    parameter SI.Time shiftTime=0
      "Shift time of table" annotation(Dialog(group="Table data interpretation"));

    extends Interfaces.partialBooleanSO;

    CombiTimeTable combiTimeTable(
      final table=if n > 0 then if startValue then [table[1], 1.0; table, {mod(i + 1, 2.0) for i in 1:n}] else [table[1], 0.0; table, {mod(i, 2.0) for i in 1:n}] else if startValue then [0.0, 1.0] else [0.0, 0.0],
      final smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      final columns={2},
      final extrapolation=extrapolation,
      final startTime=startTime,
      final shiftTime=shiftTime) annotation(Placement(transformation(extent={{-30,-10},{-10,10}})));
    Modelica.Blocks.Math.RealToBoolean realToBoolean annotation(Placement(transformation(extent={{10,-10},{30,10}})));

  protected
      function isValidTable "Check if table is valid"
        extends Modelica.Icons.Function;
        input Real table[:] "Vector of time instants";
    protected
        Integer n=size(table, 1) "Number of table points";
      algorithm
        if n > 0 then
          // Check whether time values are strict monotonically increasing
          for i in 2:n loop
            assert(table[i] > table[i-1],
              "Time values of table not strict monotonically increasing: table["
               + String(i - 1) + "] = " + String(table[i - 1]) + ", table[" +
              String(i) + "] = " + String(table[i]));
          end for;
        end if;
      end isValidTable;

      parameter Integer n=size(table, 1) "Number of table points";
  initial algorithm
      isValidTable(table);
  equation
      assert(extrapolation <> Modelica.Blocks.Types.Extrapolation.LastTwoPoints, "Unsuitable extrapolation setting.");
      connect(combiTimeTable.y[1], realToBoolean.u) annotation(Line(points={{-9,0},{8,0}}, color={0,0,127}));
      connect(realToBoolean.y, y) annotation(Line(points={{31,0},{110,0},{110,0}}, color={255,127,0}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Polygon(
            points={{-80,88},{-88,66},{-72,66},{-80,88}},
            lineColor={255,0,255},
            fillColor={255,0,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,66},{-80,-82}}, color={255,0,255}),
          Line(points={{-90,-70},{72,-70}}, color={255,0,255}),
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}},
            lineColor={255,0,255},
            fillColor={255,0,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-18,70},{32,-50}},
            lineColor={255,255,255},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid), Line(points={{-18,-50},{-18,70},{32,
                70},{32,-50},{-18,-50},{-18,-20},{32,-20},{32,10},{-18,10},{-18,
                40},{32,40},{32,70},{32,70},{32,-51}})}),
      Documentation(info="<html>
<p>
The Boolean output y is a signal defined by parameter vector <strong>table</strong>.
In the vector time points are stored.
The table interpolation has the following properties:
</p>

<ul>
<li>At every time point, the output y
    changes its value to the negated value of the previous one.</li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the <strong>startValue</strong> or last value of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (This setting is not suitable and triggers an assert.)
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>Via parameter <strong>shiftTime</strong> the curve defined by the table can be shifted
    in time.
    The time instants stored in the table are therefore <strong>relative</strong>
    to <strong>shiftTime</strong>.</li>
<li>If time &lt; startTime, no interpolation is performed and <strong>false</strong>
    is used as ordinate value for the output.</li>
</ul>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/BooleanTable.png\"
     alt=\"BooleanTable.png\">
</div>

<p>
The precise semantics is:
</p>

<blockquote><pre>
<strong>if</strong> size(table,1) == 0 <strong>then</strong>
   y = startValue;
<strong>else</strong>
   //            time &lt; table[1]: y = startValue
   // table[1] &le; time &lt; table[2]: y = not startValue
   // table[2] &le; time &lt; table[3]: y = startValue
   // table[3] &le; time &lt; table[4]: y = not startValue
   // ...
<strong>end if</strong>;
</pre></blockquote>
</html>"));
  end BooleanTable;

  block RadioButtonSource "Boolean signal source that mimics a radio button"

    parameter SI.Time buttonTimeTable[:]={0,1}
      "Time instants where button is pressed";
    input Boolean reset[:]={false}
      "Reset button to false, if an element of reset becomes true"
      annotation (Dialog(group="Time varying expressions"));

    Modelica.Blocks.Interfaces.BooleanOutput on(start=false,fixed=true)
      annotation (Placement(transformation(extent={{100,-15},{130,15}})));
  protected
    Modelica.Blocks.Sources.BooleanTable table(table=buttonTimeTable, y(start=false, fixed=true));
    parameter Integer nReset=size(reset, 1);
    Boolean pre_reset[nReset];
  initial equation
    pre(pre_reset) = fill(false, nReset);
    pre(reset) = fill(false, nReset);
  algorithm
    pre_reset := pre(reset);
    when pre_reset then
      on := false;
    end when;

    when change(table.y) then
      on := true;
    end when;

    annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          initialScale=0.06), graphics={Rectangle(
            extent={{-100,-100},{100,100}},
            borderPattern=BorderPattern.Raised,
            fillColor=DynamicSelect({192,192,192}, if on then {0,255,0} else {192,192,192}),
            fillPattern=FillPattern.Solid,
            lineColor={128,128,128}), Text(
            extent={{-300,110},{300,175}},
            textColor={0,0,255},
            textString="%name")},
          interaction={OnMouseDownSetBoolean(on, true)}), Documentation(info="<html>
<p>
Boolean signal source that mimics a radio button:
Via a table, a radio button is pressed (i.e., the output 'on' is set to true) and is reset when an element of the Boolean vector
'reset' becomes true. If both appear at the same time instant, setting
the button according to the table has a higher priority as resetting
the button. Example:
</p>

<blockquote><pre>
RadioButtonSource start(buttonTimeTable={1,3}, reset={stop.on});
RadioButtonSource stop (buttonTimeTable={2,4}, reset={start.on});
</pre></blockquote>

<p>
The \"start\" button is pressed at time=1 s and time=3 s,
whereas the \"stop\" button is pressed at time=2 s and time=4 s.
This gives the following result:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/RadioButtonSource.png\"
     alt=\"RadioButtonSource.png\">
</blockquote>

<p>
This example is also available in
<a href=\"modelica://Modelica.Blocks.Examples.Interaction1\">Modelica.Blocks.Examples.Interaction1</a>
</p>

</html>"));
  end RadioButtonSource;

  block IntegerConstant "Generate constant signal of type Integer"
    parameter Integer k(start=1) "Constant output value";
    extends Interfaces.IntegerSO;

  equation
    y = k;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,0},{80,0}}),
          Text(
            extent={{-150,-150},{150,-110}},
            textString="k=%k")}),
      Documentation(info="<html>
<p>
The Integer output y is a constant signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/IntegerConstant.png\"
     alt=\"IntegerConstant.png\">
</div>
</html>"));
  end IntegerConstant;

  block IntegerStep "Generate step signal of type Integer"
    parameter Integer height=1 "Height of step";
    extends Interfaces.IntegerSignalSource;
  equation
    y = offset + (if time < startTime then 0 else height);
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-70},{0,-70},{0,50},{80,50}}),
          Text(
            extent={{-150,-150},{150,-110}},
            textString="startTime=%startTime")}),
      Documentation(info="<html>
<p>
The Integer output y is a step signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/IntegerStep.png\"
     alt=\"IntegerStep.png\">
</div>
</html>"));
  end IntegerStep;

  block IntegerTable
    "Generate an Integer output signal based on a table matrix with [time, yi] values"

    parameter Real table[:, 2]=fill(0,0,2) "Table matrix (first column: time; second column: y)" annotation(Dialog(group="Table data definition"));
    parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint
      "Extrapolation of data outside the definition range" annotation(Dialog(group="Table data interpretation"));
    parameter SI.Time startTime=-Modelica.Constants.inf
      "Output = 0 for time < startTime" annotation(Dialog(group="Table data interpretation"));
    parameter SI.Time shiftTime=0
      "Shift time of first table column" annotation(Dialog(group="Table data interpretation"));

    extends Interfaces.IntegerSO;

    CombiTimeTable combiTimeTable(
      final table=table,
      final smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      final columns={2},
      final extrapolation=extrapolation,
      final startTime=startTime,
      final shiftTime=shiftTime) annotation(Placement(transformation(extent={{-30,-10},{-10,10}})));
    Modelica.Blocks.Math.RealToInteger realToInteger annotation(Placement(transformation(extent={{10,-10},{30,10}})));

  protected
      function isValidTable "Check if table is valid"
        extends Modelica.Icons.Function;
        input Real table[:, 2] "Table matrix";
    protected
        SI.Time t_last;
        Integer n=size(table, 1) "Number of table points";
      algorithm
        if n > 0 then
          // Check whether time values are strict monotonically increasing
          t_last := table[1, 1];
          for i in 2:n loop
            assert(table[i, 1] > t_last,
              "Time values of table not strict monotonically increasing: table["
               + String(i - 1) + ",1] = " + String(table[i - 1, 1]) + "table[" +
              String(i) + ",1] = " + String(table[i, 1]));
          end for;

          // Check that all values in the second column are Integer values
          for i in 1:n loop
            assert(rem(table[i, 2], 1) == 0.0,
              "Table value is not an Integer: table[" + String(i) + ",2] = " +
              String(table[i, 2]));
          end for;
        end if;
      end isValidTable;

      parameter Integer n=size(table, 1) "Number of table points";
  initial algorithm
      isValidTable(table);
  equation
      assert(n > 0, "No table values defined.");
      assert(extrapolation <> Modelica.Blocks.Types.Extrapolation.LastTwoPoints, "Unsuitable extrapolation setting.");
      connect(combiTimeTable.y[1], realToInteger.u) annotation(Line(points={{-9,0},{8,0}}, color={0,0,127}));
      connect(realToInteger.y, y) annotation(Line(points={{31,0},{110,0},{110,0}}, color={255,127,0}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={
          Line(points={{-80,64},{-80,-84}}, color={192,192,192}),
          Polygon(
            points={{-80,86},{-88,64},{-72,64},{-80,86}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-74},{82,-74}}, color={192,192,192}),
          Polygon(
            points={{90,-74},{68,-66},{68,-82},{90,-74}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-46,68},{4,-52}},
            lineColor={255,255,255},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-46,-52},{-46,68},{54,68},{54,-52},{-46,-52},{-46,-22},
                {54,-22},{54,8},{-46,8},{-46,38},{54,38},{54,68},{4,68},{4,-53}})}),
      Documentation(info="<html>

<p>
This block generates an Integer output signal by using a table.
The time points and y-values are stored in a matrix
<strong>table[i,j]</strong>, where the first column table[:,1] contains the
Real time points and the second column contains the Integer value of the
output y at this time point.
The table interpolation has the following properties:
</p>

<ul>
<li>An assert is triggered, if no table values are provided, if the
    time points are not strict monotonically increasing, or if
    the second column of the table matrix does not contain Integer values.</li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the first or last value of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (This setting is not suitable and triggers an assert.)
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>If the table has only <strong>one row</strong>, no interpolation is performed and
    the table values of this row are just returned.</li>
<li>Via parameter <strong>shiftTime</strong> the curve defined by the table can be shifted
    in time.
    The time instants stored in the table are therefore <strong>relative</strong>
    to <strong>shiftTime</strong>.</li>
<li>If time &lt; startTime, no interpolation is performed and zero
    is used as ordinate value for the output.</li>
</ul>

<p>
Example:
</p>
<blockquote><pre>
table = [  0, 1;
           1, 4;
         1.5, 5;
           2, 6];
</pre></blockquote>
<p>
results in the following output:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/IntegerTable.png\"
     alt=\"IntegerTable.png\">
</div>

</html>"));
  end IntegerTable;
  annotation (Documentation(info="<html>
<p>
This package contains <strong>source</strong> components, i.e., blocks which
have only output signals. These blocks are used as signal generators
for Real, Integer and Boolean signals.
</p>

<p>
All Real source signals (with the exception of the Constant source)
have at least the following two parameters:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>offset</strong></td>
      <td>Value which is added to the signal</td>
  </tr>
  <tr><td><strong>startTime</strong></td>
      <td>Start time of signal. For time &lt; startTime,
                the output y is set to offset.</td>
  </tr>
</table>

<p>
The <strong>offset</strong> parameter is especially useful in order to shift
the corresponding source, such that at initial time the system
is stationary. To determine the corresponding value of offset,
usually requires a trimming calculation.
</p>
</html>", revisions="<html>
<ul>
<li><em>October 21, 2002</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and Christian Schweiger:<br>
       Integer sources added. Step, TimeTable and BooleanStep slightly changed.</li>
<li><em>Nov. 8, 1999</em>
       by <a href=\"mailto:christoph@clauss-it.com\">Christoph Clau&szlig;</a>,
       <a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>,
       <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       New sources: Exponentials, TimeTable. Trapezoid slightly enhanced
       (nperiod=-1 is an infinite number of periods).</li>
<li><em>Oct. 31, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       <a href=\"mailto:christoph@clauss-it.com\">Christoph Clau&szlig;</a>,
       <a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>,
       All sources vectorized. New sources: ExpSine, Trapezoid,
       BooleanConstant, BooleanStep, BooleanPulse, SampleTrigger.
       Improved documentation, especially detailed description of
       signals in diagram layer.</li>
<li><em>June 29, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>"));
end Sources;
