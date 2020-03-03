within Modelica.Blocks;
package Logical "Library of components with Boolean input and output signals"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
This package provides blocks with Boolean input and output signals
to describe logical networks. A typical example for a logical
network built with package Logical is shown in the next figure:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Logical/LogicalNetwork1.png\"
     alt=\"LogicalNetwork1.png\">
</p>

<p>
The actual value of Boolean input and/or output signals is displayed
in the respective block icon as \"circle\", where \"white\" color means
value <strong>false</strong> and \"green\" color means value <strong>true</strong>. These
values are visualized in a diagram animation.
</p>
</html>"), Icon(graphics={Line(
          points={{-86,-22},{-50,-22},{-50,22},{48,22},{48,-22},{88,-24}},
          color={255,0,255})}));
end Logical;
