within Modelica.Blocks.Sources;
block KinematicPTP2
  "Move as fast as possible from start to end position within given kinematic constraints with output signals q, qd=der(q), qdd=der(qd)"

  parameter Real q_begin[:]={0} "Start position"
  annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/KinematicPTP2.png"));
  parameter Real q_end[:]={1} "End position";
  parameter Real qd_max[:](each final min=Modelica.Constants.small) = {1}
    "Maximum velocities der(q)";
  parameter Real qdd_max[:](each final min=Modelica.Constants.small) = {1}
    "Maximum accelerations der(qd)";
  parameter SI.Time startTime=0
    "Time instant at which movement starts";

  extends Modelica.Blocks.Icons.Block;
  final parameter Integer nout=max([size(q_begin, 1); size(q_end, 1); size(qd_max, 1); size(qdd_max, 1)])
    "Number of output signals (= dimension of q, qd, qdd, moving)";
  output SI.Time endTime "Time instant at which movement stops";

  Modelica.Blocks.Interfaces.RealOutput q[nout]
    "Reference position of path planning" annotation (Placement(
        transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput qd[nout]
    "Reference speed of path planning" annotation (Placement(transformation(
          extent={{100,20},{120,40}})));
  Modelica.Blocks.Interfaces.RealOutput qdd[nout]
    "Reference acceleration of path planning" annotation (Placement(
        transformation(extent={{100,-40},{120,-20}})));
  Modelica.Blocks.Interfaces.BooleanOutput moving[nout]
    "= true, if end position not yet reached; = false, if end position reached or axis is completely at rest"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));

protected
  parameter Real p_q_begin[nout]=(if size(q_begin, 1) == 1 then ones(nout)*
      q_begin[1] else q_begin);
  parameter Real p_q_end[nout]=(if size(q_end, 1) == 1 then ones(nout)*q_end[
      1] else q_end);
  parameter Real p_qd_max[nout]=(if size(qd_max, 1) == 1 then ones(nout)*
      qd_max[1] else qd_max);
  parameter Real p_qdd_max[nout]=(if size(qdd_max, 1) == 1 then ones(nout)*
      qdd_max[1] else qdd_max);
  parameter Real p_deltaq[nout]=p_q_end - p_q_begin;
  constant Real eps=10*Modelica.Constants.eps;
  Boolean motion_ref;
  Real sd_max_inv;
  Real sdd_max_inv;
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
  SI.Time Ta1s;
  SI.Time Ta2s;
  SI.Time Tvs;
  SI.Time Tes;
  Real sd_max2;
  Real s1;
  Real s2;
  Real s3;
  Real s;
  Real sd;

equation
  for i in 1:nout loop
    aux1[i] = p_deltaq[i]/p_qd_max[i];
    aux2[i] = p_deltaq[i]/p_qdd_max[i];
  end for;

  sd_max_inv = max(abs(aux1));
  sdd_max_inv = max(abs(aux2));

  if sd_max_inv <= eps or sdd_max_inv <= eps then
    sd_max = 0;
    sdd_max = 0;
    Ta1 = 0;
    Ta2 = 0;
    noWphase = false;
    Tv = 0;
    Te = 0;
    Ta1s = 0;
    Ta2s = 0;
    Tvs = 0;
    Tes = 0;
    sd_max2 = 0;
    s1 = 0;
    s2 = 0;
    s3 = 0;
    s = 0;
  else
    sd_max = 1/max(abs(aux1));
    sdd_max = 1/max(abs(aux2));
    Ta1 = sqrt(1/sdd_max);
    Ta2 = sd_max/sdd_max;
    noWphase = Ta2 >= Ta1;
    Tv = if noWphase then Ta1 else 1/sd_max;
    Te = if noWphase then Ta1 + Ta1 else Tv + Ta2;
    Ta1s = Ta1 + startTime;
    Ta2s = Ta2 + startTime;
    Tvs = Tv + startTime;
    Tes = Te + startTime;
    sd_max2 = sdd_max*Ta1;
    s1 = sdd_max*(if noWphase then Ta1*Ta1 else Ta2*Ta2)/2;
    s2 = s1 + (if noWphase then sd_max2*(Te - Ta1) - (sdd_max/2)*(Te - Ta1)^2
       else sd_max*(Tv - Ta2));
    s3 = s2 + sd_max*(Te - Tv) - (sdd_max/2)*(Te - Tv)*(Te - Tv);

    if time < startTime then
      s = 0;
    elseif noWphase then
      if time < Ta1s then
        s = (sdd_max/2)*(time - startTime)*(time - startTime);
      elseif time < Tes then
        s = s1 + sd_max2*(time - Ta1s) - (sdd_max/2)*(time - Ta1s)*(time -
          Ta1s);
      else
        s = s2;
      end if;
    elseif time < Ta2s then
      s = (sdd_max/2)*(time - startTime)*(time - startTime);
    elseif time < Tvs then
      s = s1 + sd_max*(time - Ta2s);
    elseif time < Tes then
      s = s2 + sd_max*(time - Tvs) - (sdd_max/2)*(time - Tvs)*(time - Tvs);
    else
      s = s3;
    end if;

  end if;

  sd = der(s);
  sdd = der(sd);

  qdd = p_deltaq*sdd;
  qd = p_deltaq*sd;
  q = p_q_begin + p_deltaq*s;
  endTime = Tes;

  // report when axis is moving
  motion_ref = time < endTime;
  for i in 1:nout loop
    moving[i] = if abs(q_begin[i] - q_end[i]) > eps then motion_ref else
      false;
  end for;

  annotation (
    defaultComponentName="kinematicPTP",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-80,78},{-80,-82}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,88},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{17,0}}, color={192,192,192}),
        Line(
          points={{-80,0},{-70,0},{-70,70},{-50,70},{-50,0},{-15,0},{-15,-70},
              {5,-70},{5,0},{18,0}}),
        Text(
          extent={{34,96},{94,66}},
          textString="q"),
        Text(
          extent={{40,44},{96,14}},
          textString="qd"),
        Text(
          extent={{32,-18},{99,-44}},
          textString="qdd"),
        Text(
          extent={{-32,-74},{97,-96}},
          textString="moving")}),
    Documentation(info="<html>
<p>
The goal is to move as <strong>fast</strong> as possible from start position <strong>q_begin</strong>
to end position <strong>q_end</strong>
under given <strong>kinematical constraints</strong>. The positions can be translational or
rotational definitions (i.e., q_begin/q_end is given). In robotics such a movement is called <strong>PTP</strong> (Point-To-Point).
This source block generates the <strong>position</strong> q(t), the
<strong>speed</strong> qd(t) = der(q), and the <strong>acceleration</strong> qdd = der(qd)
as output. The signals are constructed in such a way that it is not possible
to move faster, given the <strong>maximally</strong> allowed <strong>velocity</strong> qd_max and
the <strong>maximally</strong> allowed <strong>acceleration</strong> qdd_max:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/KinematicPTP2.png\"
     alt=\"KinematicPTP2.png\">
</p>

<p>
If vectors q_begin/q_end have more than 1 element,
the output vectors are constructed such that all signals
are in the same periods in the acceleration, constant velocity
and deceleration phase. This means that only one of the signals
is at its limits whereas the others are synchronized in such a way
that the end point is reached at the same time instant.
</p>

<p>
This element is useful to generate a reference signal for a controller
which controls, e.g., a drive train, or to drive
a flange according to a given acceleration.
</p>

</html>",
        revisions="<html>
<ul>
<li><em>March 24, 2007</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Non-standard Modelica function \"constrain(..)\" replaced by standard
       Modelica implementation (via internal function position()).<br>
       New output signal \"moving\" added.</li>
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
end KinematicPTP2;
