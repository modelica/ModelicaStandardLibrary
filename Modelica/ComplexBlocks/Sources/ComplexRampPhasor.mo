within Modelica.ComplexBlocks.Sources;
block ComplexRampPhasor "Generate a phasor with ramped magnitude and constant angle"
  extends Modelica.ComplexBlocks.Interfaces.ComplexSO;
  import Modelica.Constants.eps;
  parameter Real magnitude1(final min=0,start=1) "Magnitude of complex phasor at startTime"
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/ComplexBlocks/Sources/ComplexRampPhasor.png"));
  parameter Real magnitude2(final min=0,start=1) "Magnitude of complex phasor at startTime+duration";
  parameter Boolean useLogRamp = false "Ramp appears linear on a logarithmic scale, if true";
  parameter Modelica.Units.SI.Angle phi(start=0) "Angle of complex phasor";
  parameter Modelica.Units.SI.Time startTime=0 "Start time of frequency sweep";
  parameter Modelica.Units.SI.Time duration(min=0.0, start=1) "Duration of ramp (= 0.0 gives a Step)";
  Real magnitude "Actual magnitude of complex phasor";
equation
  assert(not useLogRamp or (magnitude1>eps and magnitude2>eps),
    "ComplexRampPhasor: magnitude1 and magnitude2 have to be greater than eps, if useLogRamp = true");
  magnitude = if not useLogRamp then
    magnitude1 + (if time < startTime then
      0 else
      if time < (startTime + max(duration,eps)) then
        (time - startTime)*(magnitude2-magnitude1)/max(duration,eps)
      else
      magnitude2-magnitude1)
  else
    if time < startTime then magnitude1 else
    if time < (startTime + max(duration,eps)) then
      10^(log10(magnitude1) + (log10(magnitude2) - log10(magnitude1))*min(1, (time-startTime)/max(duration,eps)))
    else
      magnitude2;

  y = magnitude*Modelica.ComplexMath.exp(Complex(0, phi));

  annotation (defaultComponentName="complexRamp",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={    Line(
              points={{0,-8},{24,12}},
              color={85,170,255}),
                             Polygon(
              points={{38,24},{17,15},{26,4},{38,24}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),Line(
              points={{0,8},{60,58}},
              color={85,170,255}),
                             Polygon(
              points={{76,72},{55,63},{64,52},{76,72}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
                                             Line(points={{0,-80},{0,68}},
          color={192,192,192}),   Polygon(
              points={{0,90},{-8,68},{8,68},{0,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),                Polygon(
              points={{90,0},{68,8},{68,-8},{90,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
The output y is a complex phasor with constant angle and a ramped magnitude.
</p>

<p>
In case of <code>useLogRamp == false</code> the magnitude ramp is linear:
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/ComplexBlocks/Sources/ComplexRampPhasorLinear.png\"
     alt=\"ComplexRampPhasorLinear.png\">
</div>

<p>
In case of <code>useLogRamp == true</code> the magnitude ramp appears linear on a logarithmic scale:
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/ComplexBlocks/Sources/ComplexRampPhasorLog.png\"
     alt=\"ComplexRampPhasorLog.png\">
</div>

</html>"));
end ComplexRampPhasor;
