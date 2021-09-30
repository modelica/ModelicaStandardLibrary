within Modelica.Electrical.QuasiStatic;
package Machines "Quasi-static machine models"
  extends Modelica.Icons.Package;
  annotation (Icon(graphics={
        Rectangle(
          origin={0,14.817},
          fillColor={170,213,255},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-54.179,-59.817},{65.821,60.183}}),
        Rectangle(
          origin={5.821,15},
          fillColor={128,128,128},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-80,-60},{-60,60}}),
        Rectangle(
          origin={5.821,15},
          fillColor={95,95,95},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{60,-10},{80,10}}),
        Rectangle(
          origin={5.821,15},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          extent={{-60,50},{20,70}}),
        Polygon(
          origin={5.821,15},
          fillPattern=FillPattern.Solid,
          points={{-70,-90},{-60,-90},{-30,-20},{20,-20},{50,-90},{60,-90},{60,
              -100},{-70,-100},{-70,-90}})}), preferredView="info", Documentation(info="<html>
<p><strong>For a discrimination of various machine models, see <a href=\"modelica://Modelica.Electrical.Machines.UsersGuide.Discrimination\">discrimination</a></strong>.</p>
<p>
Copyright &copy; 1998-2020, Modelica Association and contributors
</p>
<p>This package hosts models for quasi-static transformers.
</p>
<h4>Note</h4>
<p>
Quasi-static DC machines are still operated with DC voltage and current, whereas the quasi-static transformers
are operated with sinusoidal voltages and currents represented by time phasors. 
Quasi-static DC machine models therefore are part of the
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.QuasiStaticDCMachines\">machines library</a>.
</p>
</html>"));
end Machines;
