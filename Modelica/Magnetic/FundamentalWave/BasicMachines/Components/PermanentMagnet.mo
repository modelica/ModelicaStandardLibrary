within Modelica.Magnetic.FundamentalWave.BasicMachines.Components;
model PermanentMagnet
  "Permanent magnet represented by magnetic potential difference"
  extends Magnetic.FundamentalWave.Sources.ConstantMagneticPotentialDifference;
  extends
    Modelica.Electrical.Machines.Losses.InductionMachines.PermanentMagnetLosses;
  annotation (defaultComponentName="pm", Documentation(info="<html>
<p>
Simple model of a permanent magnet, containing:
</p>
<ul>
<li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sources.ConstantMagneticPotentialDifference\">constant magnetomotive force</a></li>
<li><a href=\"modelica://Modelica.Electrical.Machines.Losses.InductionMachines.PermanentMagnetLosses\">loss model</a></li>
</ul>
<p>
The permanent magnet is modeled by a magnetic potential difference. The internal reluctance of the permanent magnet is not taken into account. The internal reluctance needs to be modeled outside the permanent magnet model, e.g., by the total machine reluctance considered in the air gap model.
</p>
</html>"));
end PermanentMagnet;
