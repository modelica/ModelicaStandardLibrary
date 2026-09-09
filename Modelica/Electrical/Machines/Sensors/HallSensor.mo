within Modelica.Electrical.Machines.Sensors;
model HallSensor "Hall sensor"
  import Modelica.Constants.pi;
  extends
    Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
  parameter Integer p(final min=1, start=2) "Number of pole pairs";
  parameter SI.Angle phi0=-pi/p "Initial mechanical angle";
  Modelica.Blocks.Interfaces.RealOutput y(
    quantity="Angle",
    final unit="rad",
    displayUnit="deg") "\"Electrical angle\""
    annotation (Placement(transformation(extent={{-100,-10},{-120,10}})));
equation
  flange.tau=0;
  y=mod((flange.phi - phi_support - phi0)*p, 2*pi);
   annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(extent={{-70,70},{70,-70}}, lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(points={{0,0},{0,70}},  color={95,95,95}),
        Line(points={{0,-70},{0,0}}, color={95,95,95}),
        Line(points={{-70,0},{-100,0}}, color={95,95,95}),
        Line(points={{100,0},{70,0}}, color={95,95,95}),
        Text(
          extent={{-150,120},{150,80}},
          textColor={0,0,255},
          fillColor={255,255,255},
          textString="%name"),
        Line(points={{0,-30},{-0.545517,38.9449}},
                                     color={95,95,95},
          origin={-26,15},
          rotation=60),
        Line(points={{0,-30},{-0.545517,38.9449}},
                                     color={95,95,95},
          origin={34,-19},
          rotation=60),
        Line(points={{0,-30},{0.545517,38.9449}},
                                     color={95,95,95},
          origin={26,15},
          rotation=-60),
        Line(points={{0,-30},{0.545517,38.9449}},
                                     color={95,95,95},
          origin={-34,-19},
          rotation=-60),
        Ellipse(extent={{-20,20},{20,-20}}, lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="rad")}),
    Documentation(info="<html>
<p>
Simple model of a hall sensor, i.e. measuring the angle of the flange (w.r.t. the optional support), multiplying by the number of phases p to obtain the electrical angle,
and adding a correction term i.e. the initial angle of the flange phi0.
</p>
<p>
Note that phi0 has to be set that way, that in shaft position phi0 the flux linkage of phase 1 is a maximum.
</p>
</html>"));
end HallSensor;
