within Modelica.Mechanics.MultiBody.Interfaces;
model FlangeWithBearingAdaptor
  "Adaptor to allow direct connections to the sub-connectors of FlangeWithBearing"
  parameter Boolean includeBearingConnector=false
    "= true, if bearing frame connector is present, otherwise not present";

  Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing flangeAndFrame(includeBearingConnector=includeBearingConnector) "Compound connector consisting of 1-dim. rotational flange and 3-dim. frame mounting" annotation (Placement(transformation(extent={{-130,-30},{-70,30}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange
    "1-dim. rotational flange"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Frame_a frame if includeBearingConnector
    "3-dim. frame in which the 1-dim. shaft is mounted" annotation (Placement(
        transformation(
        origin={0,-100},
        extent={{-16,-16},{16,16}},
        rotation=90)));

equation
  connect(flange, flangeAndFrame.flange) annotation (Line(
      points={{0,0},{-100,0}}));
  connect(frame, flangeAndFrame.bearingFrame) annotation (Line(
      points={{0,-100},{0,-40},{-100,-40},{-100,0}},
      thickness=0.5));
  annotation (
    defaultComponentName="adaptor",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,30},{20,-100}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,-10},{-100,-40},{0,-40},{0,-100}},
          thickness=0.5),
        Line(points={{-90,0},{0,0}}),
        Text(
          extent={{-216,88},{86,36}},
          textColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html>
<p>
Adaptor object to make a more visible connection to the flange and frame
subconnectors of a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing\">FlangeWithBearing</a>
connector.
</p>
</html>"));
end FlangeWithBearingAdaptor;
