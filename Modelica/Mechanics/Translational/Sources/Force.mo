within Modelica.Mechanics.Translational.Sources;
model Force
  "External force acting on a drive train element as input signal"
  extends Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2;
  Modelica.Blocks.Interfaces.RealInput f(unit="N")
    "Driving force as input signal" annotation (Placement(transformation(
          extent={{-140,-20},{-100,20}})));

equation
  flange.f = -f;

  annotation (
    Documentation(info="<html>
<p>
The input signal \"f\" in [N] characterizes an <em>external
force</em> which acts (with positive sign) at a flange,
i.e., the component connected to the flange is driven by force f.
</p>
<p>
Input signal f can be provided from one of the signal generator
blocks of Modelica.Blocks.Source.
</p>
</html>"),
    Icon(
      coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{0,-60},{0,-101}}, color={0,127,0}),
        Polygon(
          points={{-100,10},{20,10},{20,41},{90,0},{20,-41},{20,-10},{-100,-10},{-100,10}},
          lineColor={0,127,0},
          fillColor={160,215,160},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,-32},{-80,-62}},
          textString="f"),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255}),
        Polygon(
          points={{50,-54},{-30,-54},{-30,-46},{-60,-60},{-30,-74},{-30,-66},{50,-66},{50,-54}},
          lineColor={0,127,0},
          fillColor={160,215,160},
          fillPattern=FillPattern.Solid)}));
end Force;
