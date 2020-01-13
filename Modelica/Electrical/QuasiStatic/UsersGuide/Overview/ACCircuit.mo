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
  <caption style=\"caption-side:bottom\">Fig. 1: Series AC circuit of a resistor and an inductor at variable frequency</caption>
</table>

<p>
The voltage drop across the resistor
</p>

<p>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/ACCircuit/img1.png\"
 alt=\"
\\underline{v}_{r}=R\\underline{i}\">
</p>

<p>
and the inductor
</p>

<p>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/ACCircuit/img2.png\"
 alt=\"
\\underline{v}_{l}=j\\omega L\\underline{i}\">
</p>

<p>
and the capacitor
</p>

<p>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/ACCircuit/img3.png\"
 alt=\"
\\underline{v}_{l}=j\\omega L\\underline{i}\">
</p>

<p>
add up to the total voltage
</p>

<p>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/ACCircuit/img4.png\"
 alt=\"
\\underline{v}=\\underline{v}_{r}+\\underline{v}_{l}\">
</p>

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
  <caption style=\"caption-side:bottom\">Fig. 2: Phasor diagram of a resistor and inductance series connection</caption>
</table>

<p>Due to the series connection of the resistor, inductor and capacitor, the three currents are all equal:</p>

<p>
<img border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/ACCircuit/img5.png\"
 alt=\"img5.png\">
</p>

<h4>See also</h4>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.Introduction\">
          Introduction</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.Power\">
          Power</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.ReferenceSystem\">
          Reference system</a>

</html>"));
end ACCircuit;
