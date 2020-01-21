within Modelica.Electrical.Machines.BasicMachines.Components;
model PermanentMagnetWithLosses "Permanent magnet excitation"
  extends Machines.BasicMachines.Components.PermanentMagnet;
  extends Machines.Losses.InductionMachines.PermanentMagnetLosses;
  annotation(defaultComponentName="magnet", Documentation(info="<html>
Model of a permanent magnet excitation with loss, characterized by an equivalent excitation current.
</html>"));
end PermanentMagnetWithLosses;
