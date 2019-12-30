within Modelica.Electrical.Machines.SpacePhasors.Blocks;
block FromPolar "Converts a space phasor from polar coordinates"
  extends Modelica.Blocks.Interfaces.MIMOs(final n=2);
equation
  y = u[1]*{cos(u[2]),sin(u[2])};
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Line(points={{-60,60},{-60,-60},
          {60,-60}}, color={0,0,255}),Line(points={{-100,-100},{100,100}},
          color={0,0,255}),Polygon(points={{26,26},{14,20},{20,14},{26,26}},
          lineColor={0,0,255}),Line(
                points={{-18,-18},{-14,-22},{-10,-28},{-6,-34},{-2,-44},{
            0,-52},{0,-60}},
                color={0,0,255},
                smooth=Smooth.Bezier),Polygon(points={{-18,-18},{-14,-26},
          {-10,-22},{-18,-18}}, lineColor={0,0,255}),Text(
                extent={{-100,100},{-6,-6}},
                textColor={0,0,255},
                textString="P"),Text(
                extent={{6,6},{100,-100}},
                textColor={0,0,255},
                textString="R")}), Documentation(info="<html>
Converts a space phasor from polar coordinates to rectangular coordinates.
</html>"));
end FromPolar;
