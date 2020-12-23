within Modelica.Electrical.QuasiStatic.SinglePhase;
package Basic "Basic components for AC single-phase models"
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
<p>This package hosts basic models for quasi-static single-phase circuits.
Quasi-static theory for single-phase circuits can be found in the
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic\">Polyphase.Basic</a>

</html>"));
end Basic;
