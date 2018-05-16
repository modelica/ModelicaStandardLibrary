within Modelica.Fluid;
package Icons
  extends Modelica.Icons.IconsPackage;
  partial class VariantLibrary
    "This icon will be removed in future Modelica versions, use Modelica.Icons.VariantsPackage instead."
    // extends Modelica.Icons.VariantsPackage;
    extends Modelica.Icons.ObsoleteModel;
    annotation (Documentation(info="<html>
<p>
This icon will be removed in future versions of the Modelica Standard Library.
Instead the icon <a href=\"modelica://Modelica.Icons.VariantsPackage\">Modelica.Icons.VariantsPackage</a> shall be used.
</p>
</html>"), Icon(graphics={
          Rectangle(
            lineColor={200,200,200},
            fillColor={248,248,248},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100,-100},{100,100}},
            radius=25.0),
          Rectangle(
            lineColor={128,128,128},
            extent={{-100,-100},{100,100}},
            radius=25.0),
          Ellipse(
            origin={10,10},
            fillColor={76,76,76},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-80.0,-80.0},{-20.0,-20.0}}),
          Ellipse(
            origin={10,10},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{0.0,-80.0},{60.0,-20.0}}),
          Ellipse(
            origin={10,10},
            fillColor={128,128,128},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{0.0,0.0},{60.0,60.0}}),
          Ellipse(
            origin={10,10},
            lineColor={128,128,128},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            extent={{-80.0,0.0},{-20.0,60.0}})}),
    obsolete = "Obsolete class - use Modelica.Icons.VariantsPackage instead");
  end VariantLibrary;

  partial package BaseClassLibrary
    "This icon will be removed in future Modelica versions, use Modelica.Icons.BasePackage instead."
    extends Modelica.Icons.BasesPackage;
    extends Modelica.Icons.ObsoleteModel;
    annotation(Documentation(info="<html>
<p>
This icon will be removed in future versions of the Modelica Standard Library.
Instead the icon <a href=\"modelica://Modelica.Icons.BasesPackage\">Modelica.Icons.BasesPackage</a> shall be used.
</p>
</html>"),
    obsolete = "Obsolete package - use Modelica.Icons.BasePackage instead");
  end BaseClassLibrary;
end Icons;
