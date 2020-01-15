within Modelica.ComplexBlocks.Icons;
partial block ComplexBlock "Basic graphical layout of Complex input/output block"
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
          100,100}}), graphics={Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={85,170,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid), Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        textColor={0,0,255})}),
  Documentation(info="<html>
<p>
Block that has only the basic icon for an Complex input/output
block (no declarations, no equations). Most blocks
of package Modelica.ComplexBlocks inherit directly or indirectly
from this block.
</p>
</html>"));
end ComplexBlock;
