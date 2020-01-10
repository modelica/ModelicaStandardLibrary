within Modelica.Electrical.Machines.BasicMachines.QuasiStaticDCMachines;
model DC_PermanentMagnet "Quasi-static permanent magnet DC machine"
  extends Machines.BasicMachines.DCMachines.DC_PermanentMagnet(final
      quasiStatic=true);
  extends Machines.Icons.QuasiStaticMachine;
  annotation (defaultComponentName="dcpm", Documentation(info="<html>
<strong>Quasi-static model of a DC Machine with permanent magnets.</strong><br>
This model is fully compatible with the
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet\">transient machine model of a DC machine with permanent magnets</a>;
the only difference is that electrical transients are neglected.
</html>"));
end DC_PermanentMagnet;
