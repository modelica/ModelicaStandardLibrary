within Modelica.Electrical.Machines.Interfaces;
partial model FlangeSupport "Shaft and support"
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange "Shaft end"
    annotation (Placement(transformation(extent={{-10,110},{10,90}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a support
    "Housing and support" annotation (Placement(transformation(extent={{-10,
            -110},{10,-90}})));
  SI.Angle phi "Angle between shaft and support";
  SI.Torque tau "Torque";
  SI.AngularVelocity w
    "Relative angular velocity of flange and support";
equation
  phi = flange.phi - support.phi;
  w = der(phi);
  tau = -flange.tau;
  tau = support.tau;
  annotation (Documentation(info="<html>
<p>
This partial model defines shaft and housing connector for loss models.
Positive torque <code>tau</code> acts as braking torque.
</p>
</html>"),
       Icon(graphics={Rectangle(
          extent={{-20,-80},{20,-120}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid)}));
end FlangeSupport;
