within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.Functions;
function makeTable "Make a table from raw data"
  extends Modelica.Icons.Function;
  import Modelica.Math.Vectors.reverse;
  input BaseData material;
  output Real table[2*(material.N - 1) + 3, 2]=[
    cat(1, -{material.Hsat}, -reverse(material.HD[2:material.N]), {0}, material.HD[2:material.N], {material.Hsat}),
    cat(1, -{material.Jsat}, -reverse(material.JD[2:material.N]), {0}, material.JD[2:material.N], {material.Jsat})]
    "Table for usage in table interpolation";
  annotation (Documentation(info="<html>
<p>
Takes arrays <code>HD</code> and <code>JD</code> from raw data in the material parameter record and returns a table that can be used as parameter 
of <a href=\"modelica://Modelica.Blocks.Tables.CombiTable1Ds\">CombiTable1Ds</a>. 
The given characteristic is amended by the last node <code>(Hsat, Jsat)</code> and mirrored at the origin. 
If <code>extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint</code> is used, the behaviour is as expected: 
an asymptote at saturation polarization <code>Jsat</code>.
</p>
</html>"));
end makeTable;
