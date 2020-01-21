within Modelica.Electrical.QuasiStatic.Polyphase;
package Basic "Basic components for AC polyphase models"
  extends Modelica.Icons.Package;

  annotation (Icon(graphics={
        Line(origin={10,40}, points={{-100,-40},{-80,-40}}),
        Line(origin={10,40}, points={{60,-40},{80,-40}}),
        Rectangle(
          lineColor={85,170,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-70,-30},{70,30}})}, coordinateSystem(extent={{-100,-100},
            {100,100}}, preserveAspectRatio=true)), Documentation(info="<html>
<p>This package hosts basic models for quasi-static polyphase circuits.
Quasi-static theory can be found in the
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic\">SinglePhase.Basic</a>

</html>"));
end Basic;
