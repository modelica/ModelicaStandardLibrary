within Modelica.Mechanics.MultiBody.Interfaces;
connector FlangeWithBearing
  "Connector consisting of 1-dim. rotational flange and its bearing frame"
  parameter Boolean includeBearingConnector=false
    "= true, if bearing frame connector is present, otherwise not present";
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange
    "1-dim. rotational flange";
  Modelica.Mechanics.MultiBody.Interfaces.Frame bearingFrame if includeBearingConnector "3-dim. frame in which the 1-dim. shaft is mounted";

  annotation (
    defaultComponentName="flange",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-20,1},{20,-1}},
          lineColor={135,135,135},
          lineThickness=0.5),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,25},{100,-25}},
          lineColor={64,64,64},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Line(points={{-80,60},{80,60}}),
        Line(points={{-80,-60},{80,-60}}),
        Line(points={{0,100},{0,60}}),
        Line(points={{0,-60},{0,-100}}),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={135,135,135}),
        Rectangle(extent={{-100,25},{100,-25}}, lineColor={64,64,64})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{-50,-40},{50,-40}},
          thickness=0.5),
        Line(
          points={{-50,40},{50,40}},
          thickness=0.5),
        Text(
          extent={{-158,-66},{158,-124}},
          textString="%name"),
        Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={255,255,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,15},{60,-15}},
          lineColor={64,64,64},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Line(points={{0,60},{0,40}}),
        Line(points={{0,-40},{0,-60}}),
        Line(points={{-50,40},{50,40}}),
        Line(points={{-50,-40},{50,-40}}),
        Rectangle(extent={{-60,60},{60,-60}}, lineColor={135,135,135}),
        Rectangle(extent={{-60,15},{60,-15}}, lineColor={64,64,64})}),
    Documentation(info="<html>
<p>
This hierarchical connector models a 1-dim. rotational flange
connector and its optional bearing defined by a 3-dim. frame connector.
If a connection to the subconnectors should be clearly visible,
connect first an  instance of
<a href=\"modelica://Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearingAdaptor\">FlangeWithBearingAdaptor</a>
to the FlangeWithBearing connector.
</p>
</html>"));

end FlangeWithBearing;
