within Modelica.Electrical.QuasiStatic.UsersGuide.Overview;
class Introduction "Introduction to phasors"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>

<p>
The purely sinusoidal voltage
</p>

<div>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Introduction/img1.png\"
 alt=\"v=\\sqrt{2}V_{\\mathrm{RMS}}\\cos(\\omega t+\\varphi_{v})\">
</div>

<p>
in the time domain can be represented by a complex
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Glossar\">rms</a> phasor
</p>

<div>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Introduction/img2.png\"
 alt=\"\\underline{v}=V_{\\mathrm{RMS}}e^{j\\varphi_{v}}.\">
</div>

<p>For these quasi-static
phasor the following relationship applies:</p>

<div>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Introduction/img3.png\"
 alt=\"\\begin{displaymath}
v=\\mathrm{Re}(\\sqrt{2}\\underline{v}e^{j\\omega t})\\end{displaymath}\">
</div>

<p>
This equation is also illustrated in Fig. 1.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Introduction/phasor_voltage.png\"
           alt=\"phasor_voltage.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 1: Relationship between voltage phasor and time domain voltage</caption>
</table>

<p>
From the above equation it is obvious that for <em>t</em> = 0
the time domain voltage is <em>v</em> = cos(<em>&phi;<sub>v</sub></em>).
The complex representation of the phasor corresponds with this instance, too, since
the phasor is leading the real axis by the angle <em>&phi;<sub>v</sub></em>.
</p>

<p>
The explanation given for sinusoidal voltages can certainly also be applied
to sinusoidal currents.</p>

<h4>See also</h4>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.ACCircuit\">
          AC circuit</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.Power\">
          Power</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.ReferenceSystem\">
          Reference system</a>

</html>"));
end Introduction;
