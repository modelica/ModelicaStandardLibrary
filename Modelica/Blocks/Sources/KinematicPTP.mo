within Modelica.Blocks.Sources;
block KinematicPTP
  "Move as fast as possible along a distance within given kinematic constraints"

  parameter Real deltaq[:]={1} "Distance to move"
  annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/KinematicPTP.png"));
  parameter Real qd_max[:](each final min=Modelica.Constants.small) = {1}
    "Maximum velocities der(q)";
  parameter Real qdd_max[:](each final min=Modelica.Constants.small) = {1}
    "Maximum accelerations der(qd)";
  parameter SI.Time startTime=0 "Time instant at which movement starts";

  extends Interfaces.MO(final nout=max([size(deltaq, 1); size(qd_max, 1); size(qdd_max, 1)]));

protected
  parameter Real p_deltaq[nout]=(if size(deltaq, 1) == 1 then ones(nout)*
      deltaq[1] else deltaq);
  parameter Real p_qd_max[nout]=(if size(qd_max, 1) == 1 then ones(nout)*
      qd_max[1] else qd_max);
  parameter Real p_qdd_max[nout]=(if size(qdd_max, 1) == 1 then ones(nout)*
      qdd_max[1] else qdd_max);
  Real sd_max;
  Real sdd_max;
  Real sdd;
  Real aux1[nout];
  Real aux2[nout];
  SI.Time Ta1;
  SI.Time Ta2;
  SI.Time Tv;
  SI.Time Te;
  Boolean noWphase;

equation
  for i in 1:nout loop
    aux1[i] = p_deltaq[i]/p_qd_max[i];
    aux2[i] = p_deltaq[i]/p_qdd_max[i];
  end for;
  sd_max = 1/max(abs(aux1));
  sdd_max = 1/max(abs(aux2));

  Ta1 = sqrt(1/sdd_max);
  Ta2 = sd_max/sdd_max;
  noWphase = Ta2 >= Ta1;
  Tv = if noWphase then Ta1 else 1/sd_max;
  Te = if noWphase then Ta1 + Ta1 else Tv + Ta2;

  // path-acceleration
  sdd = if time < startTime then 0 else ((if noWphase then (if time < Ta1 +
    startTime then sdd_max else (if time < Te + startTime then -sdd_max else
    0)) else (if time < Ta2 + startTime then sdd_max else (if time < Tv +
    startTime then 0 else (if time < Te + startTime then -sdd_max else 0)))));

  // acceleration
  y = p_deltaq*sdd;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-80,78},{-80,-82}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,88},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{82,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,0},{-70,0},{-70,70},{-30,70},{-30,0},{20,0},{20,-70},{
              60,-70},{60,0},{68,0}}),
        Text(
          extent={{2,80},{80,20}},
          textColor={192,192,192},
          textString="acc"),
        Text(
          extent={{-150,-150},{150,-110}},
          textString="deltaq=%deltaq")}),
        Documentation(info="<html>
<p>
The goal is to move as <strong>fast</strong> as possible along a distance
<strong>deltaq</strong>
under given <strong>kinematical constraints</strong>. The distance can be a positional or
angular range. In robotics such a movement is called <strong>PTP</strong> (Point-To-Point).
This source block generates the <strong>acceleration</strong> qdd of this signal
as output:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/KinematicPTP.png\"
     alt=\"KinematicPTP.png\">
</p>

<p>
After integrating the output two times, the position q is
obtained. The signal is constructed in such a way that it is not possible
to move faster, given the <strong>maximally</strong> allowed <strong>velocity</strong> qd_max and
the <strong>maximally</strong> allowed <strong>acceleration</strong> qdd_max.
</p>
<p>
If several distances are given (vector deltaq has more than 1 element),
an acceleration output vector is constructed such that all signals
are in the same periods in the acceleration, constant velocity
and deceleration phase. This means that only one of the signals
is at its limits whereas the others are synchronized in such a way
that the end point is reached at the same time instant.
</p>

<p>
This element is useful to generate a reference signal for a controller
which controls a drive train or in combination with model
Modelica.Mechanics.Rotational.<strong>Accelerate</strong> to drive
a flange according to a given acceleration.
</p>

</html>",
        revisions="<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>June 27, 2001</em>
       by Bernhard Bachmann.<br>
       Bug fixed that element is also correct if startTime is not zero.</li>
<li><em>Nov. 3, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Vectorized and moved from Rotational to Blocks.Sources.</li>
<li><em>June 29, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       realized.</li>
</ul>
</html>"));
end KinematicPTP;
