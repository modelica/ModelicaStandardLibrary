within Modelica.Electrical.QuasiStationary.UsersGuide.Overview;
class Power "Real and reactive power"

  annotation (Documentation(info="<html>

<p>For periodic waveforms, the average value of the instantaneous power is <b>real power</b> <i>P</i>.
<b>Reactive power</b> <i>Q</i> is a term
associated with inductors and capacitors. For pure inductors and capacitors, real power is equal to zero.
Yet, there is instantaneous power exchanged with connecting network.
</p>

The
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.Examples.SeriesResonance\">
          series resonance circuit</a> which was also adressed in the
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.ACCircuit\">
          AC circuit</a>
will be investigated.

<h5>Power of a resistor</h5>

<p>
The instantaneous voltage and current are in phase:
</p>
<p>
<IMG BORDER=\"0\"  SRC=\"../Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/v_r.png\"> <br>
<IMG BORDER=\"0\"  SRC=\"../Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/i_r.png\">
</p>

<p>
Therefore, the instantaneous power is
</p>
<p>
<IMG BORDER=\"0\"  SRC=\"../Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/power_r.png\">
</p>

<p>A graphical representation of these equations is depicted in Fig. 1</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"../Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/power_resistor.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 1: Instantaneous voltage, current of power of a resistor</caption>
</table>

<p>Real power of the resistor is the average of instantaneous power:</p>
<p>
<IMG BORDER=\"0\"  SRC=\"../Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/p_r.png\">
</p>


<h5>Power of an inductor</h5>

<p>
The instantaneous voltage leads the current by a quarter of the period:
</p>
<p>
<IMG BORDER=\"0\"  SRC=\"../Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/v_l.png\"> <br>
<IMG BORDER=\"0\"  SRC=\"../Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/i_l.png\">
</p>

<p>
Therefore, the instantaneous power is
</p>
<p>
<IMG BORDER=\"0\"  SRC=\"../Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/power_l.png\">
</p>

<p>A graphical representation of these equations is depicted in Fig. 2</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"../Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/power_inductor.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 2: Instantaneous voltage, current of power of an inductor</caption>
</table>

<p>Reqactive power of the inductor is:</p>
<p>
<IMG BORDER=\"0\"  SRC=\"../Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/q_l.png\">
</p>

<h5>Power of a capacitor</h5>

<p>
The instantaneous voltage lags the current by a quarter of the period:
</p>
<p>
<IMG BORDER=\"0\"  SRC=\"../Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/v_c.png\"> <br>
<IMG BORDER=\"0\"  SRC=\"../Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/i_c.png\">
</p>

<p>
Therefore, the instantaneous power is
</p>
<p>
<IMG BORDER=\"0\"  SRC=\"../Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/power_c.png\">
</p>

<p>A graphical representation of these equations is depicted in Fig. 3</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"../Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/power_capacitor.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 3: Instantaneous voltage, current of power of a capacitor</caption>
</table>

<p>Reqactive power of the capacitor is:</p>
<p>
<IMG BORDER=\"0\"  SRC=\"../Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/q_c.png\">
</p>

<h5>Complex apparent power</h5>

<p>For an arbitrary component with two pins, real and reactive power can be determined by the complex phasors:</p>
<p>
<IMG BORDER=\"0\"  SRC=\"../Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/s.png\">
</p>

<p>
In this equation <sup>*</sup> represents the conjugate complex operator
</p>

<h4>See also</h4>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.Introduction\">
          Introduction</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.ACCircuit\">
          AC circuit</a>
</html>"));
end Power;
