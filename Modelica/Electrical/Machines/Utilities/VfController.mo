within Modelica.Electrical.Machines.Utilities;
block VfController "Voltage-Frequency controller"
  import Modelica.Constants.pi;
  extends Modelica.Blocks.Interfaces.SIMO(u(unit="Hz"), final nout=m);
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Angle orientation[m]=-
      Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m)
    "Orientation of phases";
  parameter SI.Voltage VNominal "Nominal RMS voltage per phase";
  parameter SI.Frequency fNominal "Nominal frequency";
  parameter SI.Angle BasePhase=0 "Common phase shift";
  parameter Boolean EconomyMode=false "Economy mode: voltage quadratic dependent on frequency"
    annotation(Evaluate=true,choices(checkBox=true));
  output SI.Angle x(start=0, fixed=true) "Integrator state";
  output SI.Voltage amplitude;
protected
  parameter Integer pow=if EconomyMode then 2 else 1
    annotation(Evaluate=true);
equation
  //amplitude = sqrt(2)*VNominal*min(abs(u)/fNominal, 1);
  amplitude = sqrt(2)*VNominal*(if abs(u) < fNominal then (abs(u)/fNominal)^pow else 1);
  der(x) = 2*pi*u;
  y = amplitude*sin(fill(x + BasePhase, m) + orientation);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
        Line(visible=not EconomyMode, points={{-100,-100},{0,60},{80,60}}, color={0,0,255}),
        Line(
          points={{-70,0},{-60.2,29.9},{-53.8,46.5},{-48.2,58.1},{-43.3,
              65.2},{-38.3,69.2},{-33.4,69.8},{-28.5,67},{-23.6,61},{-18.6,
              52},{-13,38.6},{-5.98,18.6},{8.79,-26.9},{15.1,-44},{20.8,-56.2},
              {25.7,-64},{30.6,-68.6},{35.5,-70},{40.5,-67.9},{45.4,-62.5},
              {50.3,-54.1},{55.9,-41.3},{63,-21.7},{70,0}},
          color={192,192,192},
          smooth=Smooth.Bezier),
        Line(
          points={{-40,0},{-30.2,29.9},{-23.8,46.5},{-18.2,58.1},{-13.3,
              65.2},{-8.3,69.2},{-3.4,69.8},{1.5,67},{6.4,61},{11.4,52},{17,
              38.6},{24.02,18.6},{38.79,-26.9},{45.1,-44},{50.8,-56.2},{
              55.7,-64},{60.6,-68.6},{65.5,-70},{70.5,-67.9},{75.4,-62.5},{
              80.3,-54.1},{85.9,-41.3},{93,-21.7},{100,0}},
          color={192,192,192},
          smooth=Smooth.Bezier),
        Line(
          points={{-100,0},{-90.2,29.9},{-83.8,46.5},{-78.2,58.1},{-73.3,
              65.2},{-68.3,69.2},{-63.4,69.8},{-58.5,67},{-53.6,61},{-48.6,
              52},{-43,38.6},{-35.98,18.6},{-21.21,-26.9},{-14.9,-44},{-9.2,
              -56.2},{-4.3,-64},{0.6,-68.6},{5.5,-70},{10.5,-67.9},{15.4,-62.5},
              {20.3,-54.1},{25.9,-41.3},{33,-21.7},{40,0}},
          color={192,192,192},
          smooth=Smooth.Bezier),
        Line(visible=EconomyMode, points={{-100,-100},{-90,-98},{-80,-94},{-70,-86},{-60,-74},
              {-50,-60},{-40,-42},{-30,-22},{-20,2},{-10,30},{0,60},{80,60}},
             color={0,0,255})}),   Documentation(info="<html>
Simple Voltage-Frequency controller.<br>
Amplitude of voltage is linear dependent (VNominal/fNominal) on frequency (input signal \"u\"), but limited by VNominal (nominal RMS voltage per phase).<br>
m sine-waves with amplitudes as described above are provided as output signal \"y\".<br>
By setting parameter EconomyMode=true, Voltage rises quadratically with frequency which means flux,torque and loss reduction for fan and pump drives.<br>
The sine-waves are intended to feed a m-phase SignalVoltage.<br>
Phase shifts between sine-waves may be chosen by the user; default values are <em>(k-1)/m*pi for k in 1:m</em>.
</html>"));
end VfController;
