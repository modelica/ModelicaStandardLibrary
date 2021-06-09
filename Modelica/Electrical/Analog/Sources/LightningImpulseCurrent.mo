within Modelica.Electrical.Analog.Sources;
model LightningImpulseCurrent "Lightning impulse current"
  parameter Modelica.Electrical.Analog.Types.ImpulseApproximation approximation=
     Modelica.Electrical.Analog.Types.ImpulseApproximation.Heidler "Approximation of impulse";
  parameter SI.Current I "Amplitude";
  parameter SI.Time T1=10e-6 "Rise time";
  parameter SI.Time T2=350e-6 "Decay time to half value";
  parameter Integer m(final min=2)=5 "Integer exponent of Heidler-function 5..10"
    annotation(Dialog(tab="Advanced", enable=approximation == Modelica.Electrical.Analog.Types.ImpulseApproximation.Heidler));
  extends Modelica.Electrical.Analog.Interfaces.CurrentSource(redeclare
      Modelica.Electrical.Analog.Sources.LightningImpulse signalSource(
      final approximation=approximation,
      final amplitude=I,
      final T1=T1,
      final T2=T2,
      final m=m));
  annotation (Icon(graphics={
        Line(points={{-28,-80},{-2,74},{-2,74},{-2,74},{-2,74},{-2,74},{-2,74},
              {-2,74},{-2,74},{-2,74},{-2,74},{0,74},{0,74},{0,74},{0,74},{2.12,
              61.5},{4.95,46.7},{7.78,33.8},{10.606,22.45},{14.14,10.3},{17.68,
              0},{21.9,-10.2},{26.2,-18.6},{31.1,-26.5},{36.8,-33.4},{43.1,
              -39.3},{50.9,-44.5},{60.8,-48.8},{70,-51.4}})}),
                                     Documentation(info="<html>
<p>
Lightning impulse current using either a double exponential function or a Heidler function, 
see block <a href=\"modelica://Modelica.Electrical.Analog.Sources.LightningImpulse\">LightningImpulse</a>.
</p>
</html>"));
end LightningImpulseCurrent;
