within Modelica.Electrical.QuasiStatic.Machines.BasicMachines.Components;
model IdealCore "Ideal transformer with 3 windings"
  extends PartialCore;
equation
  im = fill(Complex(0), m);
  v1 = n12*v2;
  v1 = n13*v3;
  annotation (defaultComponentName="core", Documentation(info="<html>
Ideal transformer with 3 windings: no magnetizing current.
</html>"));
end IdealCore;
