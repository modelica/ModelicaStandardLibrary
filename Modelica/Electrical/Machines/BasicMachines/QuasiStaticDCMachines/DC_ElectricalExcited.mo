within Modelica.Electrical.Machines.BasicMachines.QuasiStaticDCMachines;
model DC_ElectricalExcited
  "Quasi-static electrical shunt/separate excited linear DC machine"
  extends Machines.BasicMachines.DCMachines.DC_ElectricalExcited(final
      quasiStatic=true);
  extends Machines.Icons.QuasiStaticMachine;
  annotation (defaultComponentName="dcee", Documentation(info="<html>
<strong>Quasi-static model of a DC Machine with electrical shunt or separate excitation.</strong><br>
This model is fully compatible with the
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_ElectricalExcited\">transient machine model of a DC machine with electrical shunt or separate excitation</a>;
the only difference is that electrical transients are neglected.
</html>"));
end DC_ElectricalExcited;
