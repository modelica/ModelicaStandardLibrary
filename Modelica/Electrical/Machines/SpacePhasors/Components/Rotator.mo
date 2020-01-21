within Modelica.Electrical.Machines.SpacePhasors.Components;
model Rotator "Rotates space phasor"
  import Modelica.Constants.pi;
protected
  Real RotationMatrix[2, 2]={{+cos(-angle),-sin(-angle)},{+sin(-angle),+
      cos(-angle)}};
  //Real InverseRotator[2,2] = {{+cos(+angle),-sin(+angle)},{+sin(+angle),+cos(+angle)}};
public
  Machines.Interfaces.SpacePhasor spacePhasor_a
    annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  Machines.Interfaces.SpacePhasor spacePhasor_b
    annotation (Placement(transformation(extent={{90,90},{110,110}})));
  Modelica.Blocks.Interfaces.RealInput angle(unit="rad") annotation (Placement(
        transformation(
        origin={0,-120},
        extent={{-20,-20},{20,20}},
        rotation=90)));
equation
  spacePhasor_b.v_ = RotationMatrix*spacePhasor_a.v_;
  //spacePhasor_a.v_ = InverseRotator*spacePhasor_b.v_;
  spacePhasor_b.i_ + RotationMatrix*spacePhasor_a.i_ = zeros(2);
  //spacePhasor_a.i_ + InverseRotator*spacePhasor_b.i_ = zeros(2);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
                                     Line(points={{0,0},{80,0},{60,10},{
          60,-10},{80,0}}, color={0,0,255}),Line(points={{0,0},{0,80},{-10,
          60},{10,60},{0,80}}, color={0,0,255}),Polygon(
                points={{50,0},{42,14},{54,16},{50,0}},
                lineColor={0,0,255},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
        Line(
          points={{0,50},{18,48},{32,40},{42,28},{48,16},{50,0}},
          color={0,0,255},
          smooth=Smooth.Bezier)}),      Documentation(info="<html>
Rotates space phasors of left connector to right connector by the angle provided by the input signal \"angle\" from one coordinate system into another.
</html>"));
end Rotator;
