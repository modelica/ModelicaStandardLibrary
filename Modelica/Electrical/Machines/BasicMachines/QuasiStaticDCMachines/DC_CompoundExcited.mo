within Modelica.Electrical.Machines.BasicMachines.QuasiStaticDCMachines;
model DC_CompoundExcited "Quasi-static compound excited linear DC machine"
  extends Machines.BasicMachines.DCMachines.DC_CompoundExcited(final quasiStatic=
        true);
  extends Machines.Icons.QuasiStaticMachine;
  annotation (defaultComponentName="dcse", Documentation(info="<html>
<strong>Quasi-static model of a DC Machine with Compound excitation.</strong><br>
This model is fully compatible with the
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_CompoundExcited\">transient machine model of a DC machine with compound excitation</a>;
the only difference is that electrical transients are neglected.
</html>"));
end DC_CompoundExcited;
