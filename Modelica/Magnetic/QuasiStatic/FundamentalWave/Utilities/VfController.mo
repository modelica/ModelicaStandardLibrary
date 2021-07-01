within Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities;
block VfController "Voltage-Frequency-Controller"
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Angle orientation[m]=-
      Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m)
    "Orientation of phases";
  parameter SI.Voltage VNominal
    "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal "Nominal frequency";
  parameter SI.Angle BasePhase=0 "Common phase shift";
  output SI.Voltage amplitude;
  Modelica.ComplexBlocks.Interfaces.ComplexOutput y[m]
    "Complex quasi-static voltages (RMS)" annotation (Placement(
        transformation(extent={{100,-10},{120,10}}), iconTransformation(
          extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput u(unit="Hz") "Frequency input (Hz)"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
equation
  //amplitude = VNominal*min(abs(u)/fNominal, 1);
  amplitude = VNominal*(if abs(u) < fNominal then abs(u)/fNominal else 1);
  y = Modelica.ComplexMath.fromPolar(fill(amplitude, m), orientation + fill(
    BasePhase - pi/2, m));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{
            100,100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{-100,-100},{0,60},
          {80,60}}, color={0,0,255}),Line(
              points={{-70,0},{-60.2,29.9},{-53.8,46.5},{-48.2,58.1},{-43.3,
            65.2},{-38.3,69.2},{-33.4,69.8},{-28.5,67},{-23.6,61},{-18.6,52},
            {-13,38.6},{-5.98,18.6},{8.79,-26.9},{15.1,-44},{20.8,-56.2},{
            25.7,-64},{30.6,-68.6},{35.5,-70},{40.5,-67.9},{45.4,-62.5},{
            50.3,-54.1},{55.9,-41.3},{63,-21.7},{70,0}},
              color={192,192,192},
              smooth=Smooth.Bezier),Line(
              points={{-40,0},{-30.2,29.9},{-23.8,46.5},{-18.2,58.1},{-13.3,
            65.2},{-8.3,69.2},{-3.4,69.8},{1.5,67},{6.4,61},{11.4,52},{17,
            38.6},{24.02,18.6},{38.79,-26.9},{45.1,-44},{50.8,-56.2},{55.7,
            -64},{60.6,-68.6},{65.5,-70},{70.5,-67.9},{75.4,-62.5},{80.3,-54.1},
            {85.9,-41.3},{93,-21.7},{100,0}},
              color={192,192,192},
              smooth=Smooth.Bezier),Line(
              points={{-100,0},{-90.2,29.9},{-83.8,46.5},{-78.2,58.1},{-73.3,
            65.2},{-68.3,69.2},{-63.4,69.8},{-58.5,67},{-53.6,61},{-48.6,52},
            {-43,38.6},{-35.98,18.6},{-21.21,-26.9},{-14.9,-44},{-9.2,-56.2},
            {-4.3,-64},{0.6,-68.6},{5.5,-70},{10.5,-67.9},{15.4,-62.5},{
            20.3,-54.1},{25.9,-41.3},{33,-21.7},{40,0}},
              color={192,192,192},
              smooth=Smooth.Bezier),Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              textColor={0,0,255})}),
    Documentation(info="<html>
<p>
This is a simple voltage-frequency-controller. The amplitude of the voltage is linear dependent (<code>VNominal/fNominal</code>) on the frequency (input signal <code>u</code>), but limited by <code>VNominal</code> (nominal RMS voltage per phase). An
<code>m</code> quasi-static phasor signal is provided as output signal <code>y</code>, representing complex voltages.
The output voltages may serve as inputs for complex voltage sources with phase input. Symmetrical voltages are assumed.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 1:</strong> Voltage vs. frequency of voltage frequency controller</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Utilities/VoltageFrequencyController.png\">
    </td>
  </tr>
</table>

</html>"));
end VfController;
