within Modelica.Magnetic.FundamentalWave.UsersGuide;
class Polyphase "Polyphase windings"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>Symmetrical three-phase system</h4>

<p>
Symmetrical three-phases systems of currents (or voltages) consists of three sinusoidal
sine waves with an angular displacement of
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/2pi_3.png\"/>.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/i123.png\"/>,
</div>

<p>
Electrical three-phase machines have (usually) symmetrical three-phase windings which
excite spatial magnetic potential with a spacial displacement of
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/2pi_3.png\"/>
- with respect to the fundamental wave,
see [<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.References\">Laughton02</a>].
Such a symmetrical three-phase system of currents (or voltages) can be represented by
<a href=\"http://en.wikipedia.org/wiki/Phasor\">phasors</a>, as depicted in Fig. 1(a).
The associated three-phase winding is depicted in Fig. 2(a). The winding axis are displaced by
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/2pi_3.png\"/>:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/orientationk_3.png\"/>
</div>

<p>
So there is a strong coherence between angular displacement in the time and
spatial domain which also applies to polyphase systems.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1: </strong>Symmetrical (a) three-phase and (b) five-phase current system</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/phase35.png\"
           alt=\"phase35.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 2: </strong>Symmetrical (a) three-phase and (b) five-phase winding</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/winding35.png\"
           alt=\"winding35.png\">
    </td>
  </tr>
</table>

<h4>Symmetrical polyphase system</h4>

<p>
In symmetrical polyphase systems odd and even phase numbers have to be distinguished.
</p>

<h5>Odd number of phases</h5>

<p>
For a symmetrical polyphase system with <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/m.png\"/>
phases the displacement in the time and spatial domain is
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/2pi_m.png\"/>,
as depicted in Fig. 1 and 2.
</p>

<p>
Mathematically, this symmetry is expressed in terms of phase currents by:
</p>

<div><img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/ik_odd.png\"/></div>

<p>
The orientation of the winding axis of such winding is given by:
</p>

<div><img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/orientationk_m.png\"/></div>

<h5>Even number of phases</h5>

<p>
In the current implementation of the FundamentalWave library, phase numbers equal
to the power of two are not supported. However, any other polyphase system with even
an phase number, <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/m.png\"/>,
can be recursively split into various symmetrical systems with odd phase numbers, as depicted in Fig. 3 and 4.
The displacement between the two symmetrical systems is
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/pi_m.png\"/>.
A function for calculating the <a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">symmetricOrientation</a> is available.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 3: </strong>Symmetrical (a) six and (b) ten phase current system</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/phase610.png\"
           alt=\"phase610.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 4: </strong>Symmetrical (a) six and (b) ten phase winding</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/winding610.png\"
           alt=\"winding610.png\">
    </td>
  </tr>
</table>

<h4>Note</h4>

<p>
In a fully symmetrical machine, the orientation of the winding axes and the symmetrical currents (or voltages)
<a href=\"http://en.wikipedia.org/wiki/Phasor\">phasors</a> have different signs; see Fig. 1 and 2 for odd phase numbers
and Fig. 3 and 4 for even phase numbers.
</p>
</html>"));
end Polyphase;
