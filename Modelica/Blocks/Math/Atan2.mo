within Modelica.Blocks.Math;
block Atan2 "Output atan(u1/u2) of the inputs u1 and u2"
  extends Interfaces.SI2SO(y(unit="rad"));
equation
  y = Modelica.Math.atan2(u1, u2);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Polygon(
          points={{0,90},{-8,68},{8,68},{0,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-80},{0,68}}, color={192,192,192}),
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,-34.9},{-46.1,-31.4},{-29.4,-27.1},{-18.3,-21.5},{-10.3,
              -14.5},{-2.03,-3.17},{7.97,11.6},{15.5,19.4},{24.3,25},{39,30},
              {62.1,33.5},{80,34.9}},
          smooth=Smooth.Bezier),
        Line(
          points={{-80,45.1},{-45.9,48.7},{-29.1,52.9},{-18.1,58.6},{-10.2,
              65.8},{-1.82,77.2},{0,80}},
          smooth=Smooth.Bezier),
        Line(
          points={{0,-80},{8.93,-67.2},{17.1,-59.3},{27.3,-53.6},{42.1,-49.4},
              {69.9,-45.8},{80,-45.1}},
          smooth=Smooth.Bezier),
        Text(
          extent={{-90,-46},{-18,-94}},
          textColor={192,192,192},
          textString="atan2")}),
    Documentation(info="<html>
<p>
This blocks computes the output <strong>y</strong> as the
<em>tangent-inverse</em> of the input <strong>u1</strong> divided by
input <strong>u2</strong>:
</p>
<blockquote><pre>
y = <strong>atan2</strong>( u1, u2 );
</pre></blockquote>
<p>
u1 and u2 shall not be zero at the same time instant.
<strong>Atan2</strong> uses the sign of u1 and u2 in order to construct
the solution in the range -180 deg &le; y &le; 180 deg, whereas
block <strong>Atan</strong> gives a solution in the range
-90 deg &le; y &le; 90 deg.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/atan2.png\"
     alt=\"atan2.png\">
</p>

</html>"));
end Atan2;
