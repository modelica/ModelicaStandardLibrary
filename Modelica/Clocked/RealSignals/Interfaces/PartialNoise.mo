within Modelica.Clocked.RealSignals.Interfaces;
partial block PartialNoise
  "Interface for SISO blocks with Real signals that add noise to the signal"
  extends Clocked.RealSignals.Interfaces.PartialClockedSISO;

  parameter Real noiseMax=0.1 "Upper limit of noise band";
  parameter Real noiseMin=-noiseMax "Lower limit of noise band";
  annotation (Documentation(info="<html>
<p>Interface block for uniformly distributed noise in some range noiseMin&nbsp;&hellip;&nbsp;noiseMax applied to a clocked Real input signal; the resulting noisy signal is provided as clocked Real output signal.</p>
</html>"));
end PartialNoise;
