within Modelica.Electrical.Machines.BasicMachines.Components;
model Inductor "Space phasor inductor"
  parameter SI.Inductance L[2] "Inductance of both axes";
  SI.Voltage v_[2];
  SI.Current i_[2];
  Machines.Interfaces.SpacePhasor spacePhasor_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Machines.Interfaces.SpacePhasor spacePhasor_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  spacePhasor_a.i_ + spacePhasor_b.i_ = zeros(2);
  v_ = spacePhasor_a.v_ - spacePhasor_b.v_;
  i_ = spacePhasor_a.i_;
  v_[1] = L[1]*der(i_[1]);
  v_[2] = L[2]*der(i_[2]);
  annotation (Documentation(info="<html>
This is a model of an inductor, described with space phasors.
</html>"),
    Icon(graphics={
        Line(
          points={{-60,0},{-90,0}},
          color={0,0,255}),
        Line(
          points={{90,0},{60,0}},
          color={0,0,255}),
        Text(
          extent={{-150,40},{150,80}},
          textColor={0,0,255},
          textString="%name"),
        Line(
          points={{-60,0},{-59,6},{-52,14},{-38,14},{-31,6},{-30,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{-30,0},{-29,6},{-22,14},{-8,14},{-1,6},{0,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{0,0},{1,6},{8,14},{22,14},{29,6},{30,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{30,0},{31,6},{38,14},{52,14},{59,6},{60,0}},
          color={0,0,255},
          smooth=Smooth.Bezier)}));
end Inductor;
