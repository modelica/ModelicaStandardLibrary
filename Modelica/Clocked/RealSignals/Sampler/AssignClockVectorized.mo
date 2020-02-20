within Modelica.Clocked.RealSignals.Sampler;
block AssignClockVectorized
  "Assign a clock to a clocked Real signal vector"

  parameter Integer n(min=1)=1
    "Size of input signal vector u (= size of output signal vector y)";
  Modelica.Blocks.Interfaces.RealInput u[n]
    "Connector of clocked, Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y[n]
    "Connector of clocked, Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
   Clocked.ClockSignals.Interfaces.ClockInput clock annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
equation
  when clock then
    y = u;
  end when;

  annotation (
   defaultComponentName="assignClock1",
   Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.06),
                     graphics={
        Text(
          extent={{0,-40},{140,-80}},
          textColor={0,0,0},
          textString="n=%n"),
        Line(
          points={{-80,-60},{-40,-60},{-40,0},{0,0},{0,0},{0,0},{0,80},{40,80},
              {40,40},{80,40},{80,0},{80,0},{80,0},{100,0}},
          color={0,0,127},
          pattern=LinePattern.Dot),
        Line(
          points={{-80,-60},{-80,0},{-106,0}},
          color={0,0,127},
          pattern=LinePattern.Dot),
        Ellipse(
          extent={{-90,-50},{-70,-70}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-50,10},{-30,-10}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-10,90},{10,70}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{30,50},{50,30}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{70,10},{90,-10}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,-100},{0,70}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
This block assigns a clock to the Real <strong>vector</strong> input signal u
and provides u as vector output signal y.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.AssignClockVectorized\">example</a>
shows two discrete counters. In order to execute the counters with a sample period of 20ms an AssignClockVectorized block is used. Due to clock inference all equations within the blocks are deduced to be active at the clock ticks given by the periodicClock block.
<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/AssignClockVectorized_Model.png\" alt=\"AssignClockVectorized_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/AssignClockVectorized_Result.png\" alt=\"AssignClockVectorized_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
At every clock tick (that is every 20ms) the output of the unitDelay1 block is incremented by one and that of the unitDelay2 block is incremented by two. The vector size of the input and output is provided by parameter <strong>n</strong>=2 which is also shown in the icon
of block assignClock1.
</p>
</html>"));
end AssignClockVectorized;
