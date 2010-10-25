within Modelica.Fluid;
package Icons
  extends Modelica.Icons.Package;
  partial class VariantLibrary
    "Icon for a library that contains several variants of one component"
    extends Modelica.Icons.VariantsPackage;

    annotation (             Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics));
  end VariantLibrary;

  partial package BaseClassLibrary "Icon for library"
    extends Modelica.Icons.BasesPackage;

    annotation (             Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics));
  end BaseClassLibrary;
end Icons;
