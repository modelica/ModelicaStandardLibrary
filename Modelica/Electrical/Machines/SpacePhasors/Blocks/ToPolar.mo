within Modelica.Electrical.Machines.SpacePhasors.Blocks;
block ToPolar "Converts a space phasor to polar coordinates"
  extends Modelica.Blocks.Interfaces.MIMOs(final n=2);
  constant Real small=Modelica.Constants.small;
equation
  y[1] = sqrt(u[1]^2 + u[2]^2);
  y[2] = if noEvent(y[1] <= small) then 0 else Modelica.Math.atan2(u[2],
    u[1]);
  /*
  if y[1] <= small then
    y[2] = 0;
  else
    if u[2] >= 0 then
      y[2] =  Modelica.Math.acos(u[1]/y[1]);
    else
      y[2] = -Modelica.Math.acos(u[1]/y[1]);
    end if;
  end if;
*/
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
                textString="R"),Text(
                extent={{6,6},{100,-100}},
                textColor={0,0,255},
                textString="P")}), Documentation(info="<html>
Converts a space phasor from rectangular coordinates to polar coordinates.
</html>"));
end ToPolar;
