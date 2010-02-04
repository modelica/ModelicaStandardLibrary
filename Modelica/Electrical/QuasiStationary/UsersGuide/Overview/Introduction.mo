within Modelica.Electrical.QuasiStationary.UsersGuide.Overview;
class Introduction "Introduction to phasors"

  annotation (Documentation(info="<html>

<p>
The purely sinusoidal voltage
</p>

<p>
<IMG
 BORDER=\"0\"
 SRC=\"../Images/Electrical/QuasiStationary/UsersGuide/Overview/Introduction/img1.png\"
 ALT=\"
v=\\sqrt{2}V_{\\mathrm{RMS}}\\cos(\\omega t+\\varphi_{v})\">
</p>

<p>
in the time domain can be represented by a complex
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Glossar\">rms</a> phasor
</p>

<p>
<IMG
 BORDER=\"0\"
 SRC=\"../Images/Electrical/QuasiStationary/UsersGuide/Overview/Introduction/img2.png\"
 ALT=\"
\\underline{v}=V_{\\mathrm{RMS}}e^{j\\varphi_{v}}.\">
</p>

<p>For these quasi stationary
phasor the following relationship applies:</p>

<p>
<IMG
 BORDER=\"0\"
 SRC=\"../Images/Electrical/QuasiStationary/UsersGuide/Overview/Introduction/img3.png\"
 ALT=\"\\begin{displaymath}
v=\\mathrm{Re}(\\sqrt{2}\\underline{v}e^{j\\omega t})\\end{displaymath}\">
</p>

<p>
This equation is also illustrated in Fig. 1.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"../Images/Electrical/QuasiStationary/UsersGuide/Overview/Introduction/phasor_voltage.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 1: Relationship between voltage phasor and time domain voltage</caption>
</table>

<p>
From the above equation it is obvious that for <i>t</i> = 0
the time domain voltage is <i>v</i> = cos(<i>&phi;<sub>v</sub></i>).
The complex representation of the phasor corresponds with this instance, too, since
the phasor is leading the real axis by the angle <i>&phi;<sub>v</sub></i>.
</p>

<p>
The explanation given for sinusoidal voltages can certainly also be applied
to sinusoidal currents.</p>

<h4>See also</h4>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.ACCircuit\">
          AC circuit</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.Power\">
          Power</a>


</html>"));
end Introduction;
