within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic;
package RawData "Records with measurents or datasheet"
  extends Modelica.Icons.RecordsPackage;
  annotation (Documentation(info="<html>
<p>
The magnetization table <code>H(J)</code> is taken from manufacturer's datasheet.
</p>
<p>
Using the function <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData.Functions.interpolationTable\">interpolationTable</a> 
the dataset is expanded by saturation polarization <code>Jsat</code>, adding the origin (0,0) and mirrored at the origin 
for interpolation, use <code>smoothness = MonotoneContinuousDerivative</code> and <code>extrapolation = HoldLastPoint</code>.
</p>
<p>
Assuming the maximum relative permeability is included in the measurements, additional parameters are calculated:
</p>
<ul>
<li>Susceptibility <code>Chi(H)</code></li>
<li>Relative permeability <code>mu_r(H)</code></li>
<li>Initial relative permeability <code>mu_ri</code>: linear extrapolation from the first two points to <code>H=0</code></li>
<li>Maximum relative permeability <code>mu_riMax</code></li>
<li>Alternative initial relative permeability <code>mu_ra</code>: linear extrapolation from right of the maximum to <code>H=0</code>
    using the function <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData.Functions.exMax\">exMax</a> (extrapolation from maximum)</li>
</ul>
</html>"));
end RawData;
