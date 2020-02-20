within Modelica.Clocked.RealSignals.Interfaces;
partial block PartialNoise
  "Interface for SISO blocks with Real signals that add noise to the signal"
  extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end PartialNoise;
