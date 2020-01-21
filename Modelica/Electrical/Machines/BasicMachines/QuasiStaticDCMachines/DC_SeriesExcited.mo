within Modelica.Electrical.Machines.BasicMachines.QuasiStaticDCMachines;
model DC_SeriesExcited "Quasi-static series excited linear DC machine"
  extends Machines.BasicMachines.DCMachines.DC_SeriesExcited(final quasiStatic=
        true);
  extends Machines.Icons.QuasiStaticMachine;
  annotation (defaultComponentName="dcse", Documentation(info="<html>
<strong>Quasi-static model of a DC Machine with Series excitation.</strong><br>
This model is fully compatible with the
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_SeriesExcited\">transient machine model of a DC machine with series excitation</a>;
the only difference is that electrical transients are neglected.
</html>"));
end DC_SeriesExcited;
