within Modelica.Magnetic.FluxTubes.UsersGuide;
model BasicFormulae "Basic relations of properties"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tfoot>
  <tr>
    <td><strong>Fig. 1:</strong> Passive part of the magnetic circuit: Flux tube</td>
    <td><strong>Fig. 2:</strong> Active part of the magnetic circuit: Electro-Magnetic converter</td>
  </tr>
  </tfoot>
  <tbody>
  <tr>
    <td><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/magnetic_flux_tube_schematic.png\"></td>
    <td><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Basic/converter_signs.png\"></td>
  </tr>
  </tbody>
</table>
<h4>Note:</h4>
<p>
The coil shown in Fig. 2 is wound counter-clockwise (positive mathematical direction). 
For a coil wound clockwise the number of turns <code>N</code> has to be entered negative.<br> 
There is a left-hand assignment between coil current <code>i</code> and magnetic potential difference <code>V<sub>m</sub></code>.<br> 
The magnetomotive force <code>mmf</code> has the opposite direction as the magnetic potential difference <code>V<sub>m</sub></code> 
(and therefore a right-hand assignement), but it is not used in this library.
</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>Magnetic potential difference (in an active part, Fig. 2, i.e. Ampere's law)</td>
    <td>A</td>
    <td><code>V<sub>m</sub> = N&sdot;i</code></td>
  </tr>
  <tr>
    <td>Ohm's law of the magnetic circuit</td>
    <td>&Sum; V<sub>m</sub> = 0</td>
    <td><code>&Sum; V<sub>mPassive</sub> = -&Sum; V<sub>mActive</sub></code></td>
  </tr>
  <tr>
    <td>Magnetic potential difference (in a passive part, Fig. 1)</td>
    <td>A</td>
    <td><code>V<sub>m</sub> = H&sdot;l</code></td>
  </tr>
  <tr>
    <td>Magnetic field strength</td>
    <td>A/m</td>
    <td><code> H = V<sub>m</sub>/l</code></td>
  </tr>
  <tr>
    <td>Magnetization</td>
    <td>A/m</td>
    <td><code>M = &chi;&sdot;H</code></td>
  </tr>
  <tr>
    <td>Suceptibility</td>
    <td>1</td>
    <td><code>&chi; = &micro;<sub>r</sub> - 1</code></td>
  </tr>
  <tr>
    <td>Relative permeability</td>
    <td>1</td>
    <td><code>&micro;<sub>r</sub> = 1 + &chi;</code></td>
  </tr>
  <tr>
    <td>Magnetic constant</td>
    <td>(V&sdot;s)/(A&sdot;m)</td>
    <td><code>&micro;<sub>0</sub> = 1.25663706127&sdot;10<sup>-6</sup> &asymp; 4&sdot;&pi;&sdot;10<sup>-7</sup></code></td>
  </tr>
  <tr>
    <td>Polarization</td>
    <td>T</td>
    <td><code>J = &micro;<sub>0</sub>&sdot;&chi;&sdot;H</code></td>
  </tr>
  <tr>
    <td>Flux density</td>
    <td>T</td>
    <td><code>B = J + &micro;<sub>0</sub>&sdot;H = &micro;<sub>0</sub>&sdot;&micro;<sub>r</sub>&sdot;H</code></td>
  </tr>
  <tr>
    <td>Magnetic flux (per winding)</td>
    <td>Wb</td>
    <td>&#934; = B&sdot;A</td>
  </tr>
  <tr>
    <td>Magnetic conductance</td>
    <td>H</td>
    <td><code>G<sub>m</sub> = 1/R<sub>m</sub> = &#934;/V<sub>m</sub> = &micro;<sub>0</sub>&sdot;&micro;<sub>r</sub>&sdot;A/l</code></td>
  </tr>
  <tr>
    <td>Magnetic flux linkage (of the whole coil)</td>
    <td>Wb</td>
    <td><code>&psi; = N&sdot;&#934;</code></td>
  </tr>
  <tr>
    <td>Induced voltage (Farady's law)</td>
    <td>V</td>
    <td><code>v = -d&psi;/dt</code></td>
  </tr>
  <tr>
    <td>(Self) Inductance</td>
    <td>H</td>
    <td><code>L = N<sup>2</sup>&sdot;&micro;<sub>0</sub>&sdot;&micro;<sub>r</sub>&sdot;A/l</code></td>
  </tr>
</table>
</html>"));
end BasicFormulae;
