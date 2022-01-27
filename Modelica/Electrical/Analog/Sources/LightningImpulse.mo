within Modelica.Electrical.Analog.Sources;
block LightningImpulse "Lightning impulse voltage or current trajectory"
  import Modelica.Electrical.Analog.Types.ImpulseApproximation;
  import Modelica.Constants.small;
  parameter ImpulseApproximation approximation=Modelica.Electrical.Analog.Types.ImpulseApproximation.Heidler
    "Approximation of impulse";
  parameter Real amplitude "Amplitude";
  parameter Modelica.Units.SI.Time T1=10e-6 "Rise time";
  parameter Modelica.Units.SI.Time T2=350e-6 "Decay time to half value";
  extends Modelica.Blocks.Interfaces.SignalSource;
  parameter Integer m(final min=2)=5 "Integer exponent of Heidler-function 5..10"
    annotation(Dialog(tab="Advanced", enable=approximation==ImpulseApproximation.Heidler));
protected
  parameter Real eta(final min=small, fixed=false, start=1)
    "Amplitude parameter";
  parameter Modelica.Units.SI.Time T0=
    if approximation==ImpulseApproximation.DoubleExp then T2*T1/(T2 - T1)*log(T2/T1)
    else T1*(m*T2/T1)^(1/(m + 1))
    "Initial value of time parameter";
  parameter Modelica.Units.SI.Time T(final min=small,
    fixed=false, start=T0) "Time when maximum occurs";
  parameter Modelica.Units.SI.Time T10(final min=small,
    fixed=false, start=if approximation==ImpulseApproximation.DoubleExp then 0.01*T0 else 0.1*T0) "Time to 10%";
  parameter Modelica.Units.SI.Time tau1(final min=small,
    fixed=false, start=if approximation==ImpulseApproximation.DoubleExp then T2 else T1) "Time constant 1";
  parameter Modelica.Units.SI.Time tau2(final min=small,
    fixed=false, start=if approximation==ImpulseApproximation.DoubleExp then T1 else T2) "Time constant 2";
initial equation
  if approximation==ImpulseApproximation.DoubleExp then
    //y=1/eta*(exp(-time/tau1) - exp(-time/tau2));
    //time T when maximum occurs
    exp(-T/tau1)/tau1 = exp(-T/tau2)/tau2;
    //eta to reach amplitude at T
    eta=exp(-T/tau1) - exp(-T/tau2);
    //at T10 the output rises to 10% of the amplitude
    0.1*eta=exp(-T10/tau1) - exp(-T10/tau2);
    //at T10 + 0.8*T1 the output rises to 90% of the amplitude
    0.9*eta=exp(-(T10 + 0.8*T1)/tau1) - exp(-(T10 + 0.8*T1)/tau2);
    //at T2 from virtual start the output falls below 50% of the amplitude
    0.5*eta=exp(-(T10 - 0.1*T1 + T2)/tau1) - exp(-(T10 - 0.1*T1 + T2)/tau2);
  else
    //y=1/eta*(time/tau1)^m/(1 + (time/tau1)^m)*exp(-time/tau2);
    //time T when maximum occurs
    tau2/T*m=1 + (T/tau1)^m;
    //eta to reach amplitude at T
    eta=(T/tau1)^m/(1 + (T/tau1)^m)*exp(-T/tau2);
    //at T10 the output rises to 10% of the amplitude
    0.1*eta=(T10/tau1)^m/(1 + (T10/tau1)^m)*exp(-T10/tau2);
    //at T10 + 0.8*T1 the output rises to 90% of the amplitude
    0.9*eta=((T10 + 0.8*T1)/tau1)^m/(1 + ((T10 + 0.8*T1)/tau1)^m)*exp(-(T10 + 0.8*T1)/tau2);
    //at T2 from virtual start the output falls below 50% of the amplitude
    0.5*eta=((T10 - 0.1*T1 + T2)/tau1)^m/(1 + ((T10 - 0.1*T1 + T2)/tau1)^m)*exp(-(T10 - 0.1*T1 + T2)/tau2);
  end if;
equation
  assert(approximation==ImpulseApproximation.Heidler or T1<0.2*T2,"Rise time has to be smaller than 0.2*decay time!");
  if time<startTime then
    y=offset;
  else
    if approximation==ImpulseApproximation.DoubleExp then
      y=offset + amplitude/eta*(exp(-(time - startTime)/tau1) - exp(-(time - startTime)/tau2));
    else
      y=offset + amplitude/eta*((time - startTime)/tau1)^m/(1 + ((time - startTime)/tau1)^m)*exp(-(time - startTime)/tau2);
    end if;
  end if;
  annotation (defaultComponentName="lightning",
  Documentation(info="<html>
<p>
Simplified trajectory of an impulse (like the current of lightnings) as one of two choices:
</p>
<ul>
<li>double-exponential function <code>y = amplitude/eta*(exp(-time/tau1) - exp(-time/tau2))</code></li>
<li>so-called Heidler function <code>y = amplitude/eta*(time/tau1)<sup>m</sup>/(1 + (time/tau1)<sup>m</sup>)*exp(-time/tau2)</code></li>
</ul>
<p>
The parameters of the trajectory are defined by:
</p>
<ul>
<li>The <code>amplitude</code> of the trajectory</li>
<li>Rise time <code>T1</code></li>
<li>Decay time to half value <code>T2</code></li>
<li>For the Heidler function, integer exponent <code>m = 5..10</code> is recommended.</li>
</ul>
<h4>Explanations</h4>
<p>
According to Fig. 1, a straight line between 0.1 and 0.9 of the amplitude is drawn. 
The virtual start of the trajectory is defined by the intersection of this straight line and the abscissa. 
The rise time <code>T1</code> is defined as the time span between the virtual start of the trajectory and the point in time when the straight line reaches the amplitude.
The decay time to half value <code>T2</code> is defined as the time span between the virtual start and the point in time when the output falls below 0.5 of the amplitude.
</p>
<p>Note: Due to numerical reasons, for the double-exponential function <code>T1 &lt; 0.2*T2</code> is required.</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 1:</strong> Parameters of the lightning current</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/Lightning.png\">
    </td>
  </tr>
</table>
<h4>Note</h4>
<p>
For a standard trajectory with <code>amplitude = 100 kA, T1 = 10 &micro;s, T2 = 350 &micro;s</code> the integral of the output reaches the required charge <code>Q = 50 C</code> nearly perfect.
</p>
<h4>References</h4>
<ul>
<li>Fridolin Heidler and Klaus Stimper, Blitz und Blitzschutz. VDE 2009, ISBN 978-3-8007-2974-6.</li>
<li>Fridolin Heidler, Blitzstromparameter nach IEC 62305 - Hintergrund, Erfahrung und Ausblick. Elektronik &amp; Automation (etz) (1) 2009, pp. 57-64.</li>
<li>DIN EN 62305-1 (VDE 0185-305-1):2011-10 Blitzschutz - Teil 1: Allgemeine Grunds&auml;tze.</li>
<li>Michael Rock, Pr&uuml;fgeneratoren zur Simulation von Blitzimpulsstr&ouml;men im Labor und ihre Wechselwirkung mit den Pr&uuml;fobjekten.
    Habilitation, Universit&auml;t Ilmenau 2012, ISBN 978-3-86360-032-7.</li>
</ul>
</html>"),
    Icon(graphics={
        Polygon(
          points={{-80,80},{-88,58},{-72,58},{-80,80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,58},{-80,-90}}, color={192,192,192}),
        Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-78},{-54,76},{-54,76},{-54,76},{-54,76},{-54,76},{
              -54,76},{-54,76},{-54,76},{-54,76},{-54,76},{-52,76},{-52,76},{
              -52,76},{-52,76},{-49.88,63.5},{-47.05,48.7},{-44.22,35.8},{
              -41.394,24.45},{-37.86,12.3},{-34.32,2},{-30.1,-8.2},{-25.8,-16.6},
              {-20.9,-24.5},{-15.2,-31.4},{-8.9,-37.3},{-1.1,-42.5},{8.8,-46.8},
              {18,-49.4}})}));
end LightningImpulse;
