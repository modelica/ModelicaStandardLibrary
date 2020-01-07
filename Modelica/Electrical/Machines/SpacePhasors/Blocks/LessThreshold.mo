within Modelica.Electrical.Machines.SpacePhasors.Blocks;
block LessThreshold "Sets angle to zero when length is below threshold"
  extends Modelica.Blocks.Interfaces.MISO(final nin=2);
  parameter Real threshold(final min=0) "Threshold";
equation
  y = if noEvent(u[1]<threshold) then 0 else u[2];
end LessThreshold;
