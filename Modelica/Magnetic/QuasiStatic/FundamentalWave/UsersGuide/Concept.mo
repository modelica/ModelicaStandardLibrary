within Modelica.Magnetic.QuasiStatic.FundamentalWave.UsersGuide;
class Concept "Fundamental wave concept"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h5>Reference frames</h5>

<p>Quasi-static magnetic ports contain the complex magnetic flux (flow variable) and the complex magnetic potential difference (potential variable) and a reference angle. The relationship between the different complex phasors with respect to different references will be explained by means of the complex magnetic flux. The same transformation relationships also apply to the complex magnetic potential difference. However, the discussed relationships are important for handling connectors in the air gap model, transform equations into the rotor fixed reference frame, etc.</p>

<p>
Let us assume that the air gap model contains stator and rotor magnetic ports which relate to the different sides of the machine. The angle relationship between these ports is
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_relationship.png\"/>,
</div>

<p>where
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_s.png\"/>
is the connector reference angle of the stator ports,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_r.png\"/>
is the connector reference angle of the rotor ports, and
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_mechanical.png\"/>
is the difference of the mechanical angles of the flange and the support, respectively,
multiplied by the number of pole pairs,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/p.png\"/>.
The stator and rotor reference angles are directly related with the electrical frequencies of the
electric circuits of the stator,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/f_s.png\"/>,
and rotor,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/f_r.png\"/>,
respectively, by means of:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_f.png\"/>
</div>

<p>
This is a strict consequence of the electromagnetic coupling between the quasi-static electric and the quasi-static magnetic domain.</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1:</strong> Reference frames of the quasi-static fundamental wave library</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/ReferenceFrames.png\"/>
    </td>
  </tr>
</table>

<p>
The complex magnetic flux with respect a stator and rotor magnetic port are equal,
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Phi(ref)=Phi,re+jPhi,im.png\"/>,
</div>

<p>
but the reference phase angles are different according to the relationship explained above. The stator and rotor reference angles refer to quasi-static magnetic connectors. The complex magnetic flux of the (stator) port with respect to the <strong>stator fixed</strong> reference frame is then calculated by</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Phi_s_ref.png\"/>.
</div>

<p>
The complex magnetic flux of the (rotor) magnetic port with respect to the <strong>rotor fixed</strong> reference frame is then calculated by</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Phi_r_ref.png\"/>.
</div>

<p>
The two stator and rotor fixed complex fluxes are related by</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Phi_r_s.png\"/>.
</div>

</html>"));
end Concept;
