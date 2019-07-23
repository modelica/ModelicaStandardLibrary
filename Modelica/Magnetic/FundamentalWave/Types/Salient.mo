within Modelica.Magnetic.FundamentalWave.Types;
record Salient "Base record of saliency with d and q component"
  replaceable Real d "Component of d (direct) axis, aligned to real part";
  replaceable Real q
    "Component of q (quadrature) axis, aligned to imaginary part";
  annotation (Documentation(info="<html>
<p>
Definition of saliency with respect to the orthogonal d- and q-axis. Saliency, however, refers to different properties in d- and q-axis and thus considers the anisotropic behavior.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientCurrent\">SalientCurrent</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientVoltage\">SalientVoltage</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientInductance\">SalientInductance</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientReluctance\">SalientReluctance</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientResistance\">SalientResistance</a>
</p>

</html>"));
end Salient;
