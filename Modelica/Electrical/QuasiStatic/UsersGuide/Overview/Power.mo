within Modelica.Electrical.QuasiStatic.UsersGuide.Overview;
class Power "Real and reactive power"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>

<p>For periodic waveforms, the average value of the instantaneous power is <strong>real power</strong> <em>P</em>.
<strong>Reactive power</strong> <em>Q</em> is a term
associated with inductors and capacitors. For pure inductors and capacitors, real power is equal to zero.
Yet, there is instantaneous power exchanged with connecting network.
</p>

The
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Examples.SeriesResonance\">
          series resonance circuit</a> which was also addressed in the
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.ACCircuit\">
          AC circuit</a>
will be investigated.

<h5>Power of a resistor</h5>

<p>
The instantaneous voltage and current are in phase:
</p>
<div>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/v_r.png\"
                   alt=\"v_r.png\"><br>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/i_r.png\"
                   alt=\"i_r.png\">
</div>

<p>
Therefore, the instantaneous power is
</p>
<div>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/power_r.png\"
                   alt=\"power_r.png\">
</div>

<p>A graphical representation of these equations is depicted in Fig. 1</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/power_resistor.png\"
           alt=\"power_resistor.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 1: Instantaneous voltage, current of power of a resistor</caption>
</table>

<p>Real power of the resistor is the average of instantaneous power:</p>
<div>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/p_r.png\"
                   alt=\"p_r.png\">
</div>

<h5>Power of an inductor</h5>

<p>
The instantaneous voltage leads the current by a quarter of the period:
</p>
<div>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/v_l.png\"
                   alt=\"v_l.png\"><br>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/i_l.png\"
                   alt=\"i_l.png\">
</div>

<p>
Therefore, the instantaneous power is
</p>
<div>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/power_l.png\"
                   alt=\"power_l.png\">
</div>

<p>A graphical representation of these equations is depicted in Fig. 2</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/power_inductor.png\"
           alt=\"power_inductor.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 2: Instantaneous voltage, current of power of an inductor</caption>
</table>

<p>Reactive power of the inductor is:</p>
<div>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/q_l.png\"
                   alt=\"q_l.png\">
</div>

<h5>Power of a capacitor</h5>

<p>
The instantaneous voltage lags the current by a quarter of the period:
</p>
<div>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/v_c.png\"
                   alt=\"v_c.png\"><br>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/i_c.png\"
                   alt=\"i_c.png\">
</div>

<p>
Therefore, the instantaneous power is
</p>
<div>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/power_c.png\"
                   alt=\"power_c.png\">
</div>

<p>A graphical representation of these equations is depicted in Fig. 3</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/power_capacitor.png\"
           alt=\"power_capacitor.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 3: Instantaneous voltage, current of power of a capacitor</caption>
</table>

<p>Reactive power of the capacitor is:</p>
<div>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/q_c.png\"
                   alt=\"q_c.png\">
</div>

<h5>Complex apparent power</h5>

<p>For an arbitrary component with two pins, real and reactive power can be determined by the complex phasors:</p>
<div>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/s.png\"
                   alt=\"s.png\">
</div>

<p>
In this equation <sup>*</sup> represents the conjugate complex operator
</p>

<h4>See also</h4>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.Introduction\">
          Introduction</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.ACCircuit\">
          AC circuit</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.ReferenceSystem\">
          Reference system</a>
</html>"));
end Power;
