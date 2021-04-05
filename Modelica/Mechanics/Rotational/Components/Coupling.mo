within Modelica.Mechanics.Rotational.Components;
model Coupling "Ideal rotational coupling"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
  Modelica.Units.SI.AngularVelocity w(displayUnit="rpm") = der(flange_a.phi) "Angular velocity of bith flanges";
  Modelica.Units.SI.Torque tau = flange_a.tau "Torque driving b from a";
equation
  flange_a.phi + flange_b.phi = 0;
  flange_a.tau - flange_b.tau = 0;
  annotation (Icon(graphics={
        Rectangle(
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100,-10},{100,10}}),
        Text(textColor={0,0,255},
          extent={{-150,80},{150,120}},
          textString="%name"),
        Rectangle(
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-30,-60},{30,60}}),
        Rectangle(
          extent={{-10,42},{10,38}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,22},{10,18}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,2},{10,-2}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,-18},{10,-22}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,-38},{10,-42}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,60},{10,58}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,-58},{10,-60}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{10,58},{10,40},{-10,40},{-10,20},{10,20},{10,-2},{-10,0},{
              -10,-22},{10,-20},{10,-42},{-10,-40},{-10,-60}}, color={0,0,0})}),
      Documentation(info="<html>
<p>
This is a model of an ideal stiff coupling (face to face), 
i.e. the angular velocity if flange_b is exactly in opposite direction of flange_a, 
and the torque of both flanges is identical.
</p>
<p>
The usage is demonstrated in an <a href=\"modelica://Modelica.Electrical.Machines.Examples.DCMachines.DCPM_Drive\">example in Modelica.Electrical.Machines</a>.
</p>
<p>
Variable <code>w</code> shows angular velocity of the connected flanges, 
whereas <code>tau</code> shows the torque transferred from flange_a to flange_b, 
i.e. a positive torque means flange_a is driving flange_b. 
</p>
</html>"));
end Coupling;
