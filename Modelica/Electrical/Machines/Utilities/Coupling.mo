within Modelica.Electrical.Machines.Utilities;
model Coupling "Ideal rotational coupling"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
  Modelica.Units.SI.AngularVelocity w(displayUnit="rpm") = der(flange_a.phi) "Angular velocity of flange_a";
  Modelica.Units.SI.Torque tau = flange_a.tau "Torque of flange_a and flange_b";
  Mechanics.Rotational.Components.IdealGear idealGear(final useSupport=false,
      final ratio=-1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(idealGear.flange_b, flange_b)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,0}));
  connect(idealGear.flange_a, flange_a)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,0}));
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
This is a model of an ideal stiff coupling: 
One device connected to the coupling is turning clockwise (looking at the shaft end), 
the other device connected to the coupling is turning counter-clockwise (looking at the shaft end). 
The torque at <code>flange_b</code> has the same magnitude as the torque at <code>flange_a</code> but opposite sign. 
This is achieved by using an 
<a href=\"modelica://Modelica.Mechanics.Rotational.Components.IdealGear\">ideal gear</a> with <code>ratio = -1</code>.
</p>
<p>
Variable <code>w</code> represents the angular velocity of <code>flange_a</code>
and <code>tau</code> represents the torque transferred from <code>flange_a</code> to <code>flange_b</code>.
</p>
<p>
This behaviour is essential when coupling electric machines. The usage is demonstrated 
in the example <a href=\"modelica://Modelica.Electrical.Machines.Examples.DCMachines.DCPM_Drive\">Modelica.Electrical.Machines.Examples.DCMachines.DCPM_Drive</a>.
</p>
</html>"));
end Coupling;
