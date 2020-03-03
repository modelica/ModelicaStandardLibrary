within Modelica.Blocks.Logical;
block OnOffController "On-off controller"
  extends Modelica.Blocks.Icons.PartialBooleanBlock;
  Blocks.Interfaces.RealInput reference
    "Connector of Real input signal used as reference signal" annotation (
      Placement(transformation(extent={{-140,80},{-100,40}})));
  Blocks.Interfaces.RealInput u
    "Connector of Real input signal used as measurement signal" annotation (
      Placement(transformation(extent={{-140,-40},{-100,-80}})));
  Blocks.Interfaces.BooleanOutput y
    "Connector of Real output signal used as actuator signal" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));

  parameter Real bandwidth(start=0.1) "Bandwidth around reference signal";
  parameter Boolean pre_y_start=false "Value of pre(y) at initial time";

initial equation
  pre(y) = pre_y_start;
equation
  y = pre(y) and (u < reference + bandwidth/2) or (u < reference - bandwidth/
    2);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{-92,74},{44,44}},
          textString="reference"),
        Text(
          extent={{-94,-52},{-34,-74}},
          textString="u"),
        Line(points={{-76,-32},{-68,-6},{-50,26},{-24,40},{-2,42},{16,36},{32,28},{48,12},{58,-6},{68,-28}},
          color={0,0,127}),
        Line(points={{-78,-2},{-6,18},{82,-12}},
          color={255,0,0}),
        Line(points={{-78,12},{-6,30},{82,0}}),
        Line(points={{-78,-16},{-6,4},{82,-26}}),
        Line(points={{-82,-18},{-56,-18},{-56,-40},{64,-40},{64,-20},{90,-20}},
          color={255,0,255})}), Documentation(info="<html>
<p>The block OnOffController sets the output signal <strong>y</strong> to <strong>true</strong> when
the input signal <strong>u</strong> falls below the <strong>reference</strong> signal minus half of
the bandwidth and sets the output signal <strong>y</strong> to <strong>false</strong> when the input
signal <strong>u</strong> exceeds the <strong>reference</strong> signal plus half of the bandwidth.</p>
</html>"));
end OnOffController;
