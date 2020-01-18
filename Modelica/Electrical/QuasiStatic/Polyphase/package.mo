within Modelica.Electrical.QuasiStatic;
package Polyphase "Polyphase AC components"
  extends Modelica.Icons.Package;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Ellipse(
          origin={14,56},
          lineColor={0,0,255},
          extent={{-84,-126},{56,14}}),
        Ellipse(
          origin={-0,40},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          extent={{-40,-34},{-20,-14}}),
        Ellipse(
          origin={20,40},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          extent={{0,-34},{20,-14}}),
        Ellipse(
          origin={10,34},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          extent={{-20,-74},{0,-54}})}), Documentation(info="<html>
<p>This package hosts models for quasi-static polyphase circuits.
Quasi-static theory can be found in
[<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">Vaske1973</a>]
and other
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase\">SinglePhase</a>

</html>"));
end Polyphase;
