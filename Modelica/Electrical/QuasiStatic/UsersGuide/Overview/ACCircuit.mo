within Modelica.Electrical.QuasiStatic.UsersGuide.Overview;
class ACCircuit "AC circuit"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<p>
A simple
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Examples.SeriesResonance\">
          example</a> of a series connection of a resistor, an inductor and a capacitor
as depicted in Fig. 1 should be explained in the following. For various frequencies,
the voltage drops across the resistor, the inductor and the capacitor should be determined.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/ACCircuit/resonance_circuit.png\"
           alt=\"resonance_circuit.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 1: Series AC circuit of a resistor and an inductor at variable frequency</caption>
</table>

<p>
The voltage drop across the resistor
</p>

<div>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/ACCircuit/img1.png\"
 alt=\"
\\underline{v}_{r}=R\\underline{i}\">
</div>

<p>
and the inductor
</p>

<div>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/ACCircuit/img2.png\"
 alt=\"
\\underline{v}_{l}=j\\omega L\\underline{i}\">
</div>

<p>
and the capacitor
</p>

<div>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/ACCircuit/img3.png\"
 alt=\"
\\underline{v}_{l}=j\\omega L\\underline{i}\">
</div>

<p>
add up to the total voltage
</p>

<div>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/ACCircuit/img4.png\"
 alt=\"
\\underline{v}=\\underline{v}_{r}+\\underline{v}_{l}\">
</div>

<p>
as illustrated in the phasor diagram of Fig. 2.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/ACCircuit/phasor_diagram.png\"
           alt=\"phasor_diagram.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 2: Phasor diagram of a resistor and inductance series connection</caption>
</table>

<p>Due to the series connection of the resistor, inductor and capacitor, the three currents are all equal:</p>

<div>
<img border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/ACCircuit/img5.png\"
 alt=\"img5.png\">
</div>

<h4>See also</h4>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.Introduction\">
          Introduction</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.Power\">
          Power</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.ReferenceSystem\">
          Reference system</a>

</html>"));
end ACCircuit;
