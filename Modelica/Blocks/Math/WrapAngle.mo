within Modelica.Blocks.Math;
block WrapAngle "Wrap angle to interval ]-pi,pi] or [0,2*pi["

  extends Interfaces.SISO(u(unit="rad"), y(unit="rad"));
  parameter Boolean positiveRange=false "Use only positive output range, if true";

equation
  y = Modelica.Math.wrapAngle(u,positiveRange);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{-80,54},{-80,54},{-60,80},{-60,-80},{60,80},{60,-80},{
              80,-52}}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Line(points={{0,-80},{0,68}}, color={192,192,192}),
        Polygon(
          points={{0,90},{-8,68},{8,68},{0,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This blocks wraps the input angle into the interval ]-pi,pi], if <code>positiveRange == false</code>.
Otherwise the input angle <code>u</code> is wrapped to the interval [0,2*pi[.
</p>

</html>"));
end WrapAngle;
