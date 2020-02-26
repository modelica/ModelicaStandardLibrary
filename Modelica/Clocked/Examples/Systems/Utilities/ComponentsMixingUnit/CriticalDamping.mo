within Modelica.Clocked.Examples.Systems.Utilities.ComponentsMixingUnit;
block CriticalDamping
  "Output the input signal filtered with an n-th order filter with critical damping"

  import Modelica.Blocks.Types.Init;
  extends Modelica.Blocks.Interfaces.SISO;

  parameter Integer n=2 "Order of filter";
  parameter SI.Frequency f(start=1) "Cut-off frequency";
  parameter Boolean normalized = true
    "= true, if amplitude at f_cut is 3 dB, otherwise unmodified filter";
  output Real x[n](start=zeros(n)) "Filter states";
protected
  parameter Real alpha=if normalized then sqrt(2^(1/n) - 1) else 1.0
    "Frequency correction factor for normalized filter";
  parameter Real w=2*Modelica.Constants.pi*f/alpha;
equation
  der(x[1]) = (u - x[1])*w;
  for i in 2:n loop
    der(x[i]) = (x[i - 1] - x[i])*w;
  end for;
  y = x[n];
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{-80.6897,77.6256},{-80.6897,-90.3744}}, color={192,192,
              192}),
        Polygon(
          points={{-79.7044,90.6305},{-87.7044,68.6305},{-71.7044,68.6305},{-79.7044,
              88.6305},{-79.7044,90.6305}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{0,0},{60,-60}},
          textColor={192,192,192},
          textString="PTn"),
        Line(points={{-80.7599,-80.5082},{-70.7599,-74.5082},{-56,-60},{-48,-42},
              {-42,-18},{-36,4},{-26,20},{-10.7599,34.9018},{-0.759907,
              38.8218},{9.24009,41.6818},{19.2401,43.7818},{29.2401,45.3118},
              {39.2401,46.4318},{49.2401,47.2518},{59.2401,47.8518},{69.2401,
              48.2918},{79.2401,48.6118}}, color={0,0,127}),
        Text(
          extent={{-70,94},{26,48}},
          textColor={192,192,192},
          textString="%n"),
        Text(
          extent={{8,-106},{8,-146}},
          textString="f=%f")}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{40,0},{-40,0}}),
        Text(
          extent={{-55,55},{55,5}},
          textString="1"),
        Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
        Line(points={{-100,0},{-60,0}}, color={0,0,255}),
        Line(points={{60,0},{100,0}}, color={0,0,255}),
        Text(
          extent={{-54,-6},{44,-56}},
          textString="(s/w + 1)"),
        Text(
          extent={{38,-10},{58,-30}},
          textString="n")}),
    Documentation(info="<html>
<p>This block defines the transfer function between the
input u and the output y
as an n-th order filter with <em>critical damping</em>
characteristics and cut-off frequency f. It is
a slightly simplified version of the <a href=\"modelica://Modelica.Blocks.Continuous.CriticalDamping\">Modelica.Blocks.Continuous.CriticalDamping</a> block.
It doesn't provide the same initialization capabilities as the continuous block, since the initialization of
clocked partitions is currently performed differently to the continuous time partitions.
</p>

</html>"));
end CriticalDamping;
