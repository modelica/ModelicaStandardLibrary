within Modelica.Electrical.QuasiStatic.Machines;
package BasicMachines "Basic machine models"
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
          points={{-70,-90},{-60,-90},{-30,-20},{20,-20},{50,-90},{60,-90},{
              60,-100},{-70,-100},{-70,-90}})}), Documentation(info="<html>
This package contains components for modeling quasi-static electrical induction machines, based on space phasor theory:
<ul>
<li>package InductionMachines: quasi-static models of three-phase induction machines</li>
<li>package SynchronousMachines: quasi-static models of three-phase synchronous machines</li>
<li>package Transformers: quasi-static three-phase transformers (see detailed documentation in subpackage)</li>
<li>package Components: components for quasi-static modeling machines and transformers</li>
</ul>
</html>"));
end BasicMachines;
