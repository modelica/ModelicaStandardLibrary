within Modelica.Blocks.Sources;
block TimeTable
  "Generate a (possibly discontinuous) signal by linear interpolation in a table"

  parameter Real table[:, 2] = fill(0.0, 0, 2)
    "Table matrix (time = first column; e.g., table=[0, 0; 1, 1; 2, 4])"
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/TimeTable.png"));
  parameter SI.Time timeScale(
    min=Modelica.Constants.eps)=1 "Time scale of first table column"
    annotation (Evaluate=true);
  extends Interfaces.SignalSource;
  parameter SI.Time shiftTime=startTime
    "Shift time of first table column";
protected
  discrete Real a "Interpolation coefficient a of actual interval (y=a*x+b)";
  discrete Real b "Interpolation coefficient b of actual interval (y=a*x+b)";
  Integer last(start=1) "Last used lower grid index";
  discrete SI.Time nextEvent(start=0, fixed=true) "Next event instant";
  discrete Real nextEventScaled(start=0, fixed=true)
    "Next scaled event instant";
  Real timeScaled "Scaled time";

  function getInterpolationCoefficients
    "Determine interpolation coefficients and next time event"
    extends Modelica.Icons.Function;
    input Real table[:, 2] "Table for interpolation";
    input Real offset "y-offset";
    input Real startTimeScaled "Scaled time-offset";
    input Real timeScaled "Actual scaled time instant";
    input Integer last "Last used lower grid index";
    input Real TimeEps "Relative epsilon to check for identical time instants";
    input Real shiftTimeScaled "Time shift";
    output Real a "Interpolation coefficient a (y=a*x + b)";
    output Real b "Interpolation coefficient b (y=a*x + b)";
    output Real nextEventScaled "Next scaled event instant";
    output Integer next "New lower grid index";
  protected
    Integer columns=2 "Column to be interpolated";
    Integer ncol=2 "Number of columns to be interpolated";
    Integer nrow=size(table, 1) "Number of table rows";
    Integer next0;
    Real tp;
    Real dt;
  algorithm
    next := last;
    nextEventScaled := timeScaled - TimeEps*abs(timeScaled);
    // in case there are no more time events
    tp := timeScaled + TimeEps*abs(timeScaled);

    if tp < startTimeScaled then
      // First event not yet reached
      nextEventScaled := startTimeScaled;
      a := 0;
      b := offset;
    elseif nrow < 2 then
      // Special action if table has only one row
      a := 0;
      b := offset + table[1, columns];
    else
      tp := tp - shiftTimeScaled;
      // Find next time event instant. Note, that two consecutive time instants
      // in the table may be identical due to a discontinuous point.
      while next < nrow and tp >= table[next, 1] loop
        next := next + 1;
      end while;

      // Define next time event, if last table entry not reached
      if next < nrow then
        nextEventScaled := shiftTimeScaled + table[next, 1];
      end if;

      // Determine interpolation coefficients
      if next == 1 then
        next := 2;
      end if;
      next0 := next - 1;
      dt := table[next, 1] - table[next0, 1];
      if dt <= TimeEps*abs(table[next, 1]) then
        // Interpolation interval is not big enough, use "next" value
        a := 0;
        b := offset + table[next, columns];
      else
        a := (table[next, columns] - table[next0, columns])/dt;
        b := offset + table[next0, columns] - a*table[next0, 1];
      end if;
    end if;
    // Take into account shiftTimeScaled "a*(time - shiftTime) + b"
    b := b - a*shiftTimeScaled;
  end getInterpolationCoefficients;
algorithm
  if noEvent(size(table, 1) > 1) then
    assert(not (table[1, 1] > 0.0 or table[1, 1] < 0.0), "The first point in time has to be set to 0, but is table[1,1] = " + String(table[1, 1]));
  end if;
  when {time >= pre(nextEvent),initial()} then
    (a,b,nextEventScaled,last) := getInterpolationCoefficients(
        table,
        offset,
        startTime/timeScale,
        timeScaled,
        last,
        100*Modelica.Constants.eps,
        shiftTime/timeScale);
    nextEvent := nextEventScaled*timeScale;
  end when;
equation
  assert(size(table, 1) > 0, "No table values defined.");
  timeScaled = time/timeScale;
  y = a*timeScaled + b;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-48,70},{2,-50}},
          lineColor={255,255,255},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-48,-50},{-48,70},{52,70},{52,-50},{-48,-50},{-48,-20},
              {52,-20},{52,10},{-48,10},{-48,40},{52,40},{52,70},{2,70},{2,-51}}),
        Text(
          extent={{-150,-150},{150,-110}},
          textString="offset=%offset")}),
        Documentation(info="<html>
<p>
This block generates an output signal by <strong>linear interpolation</strong> in
a table. The time points and function values are stored in a matrix
<strong>table[i,j]</strong>, where the first column table[:,1] contains the
time points and the second column contains the data to be interpolated.
The table interpolation has the following properties:
</p>
<ul>
<li>The interpolation interval is found by a linear search where the interval used in the
    last call is used as start interval.</li>
<li>The time points need to be <strong>monotonically increasing</strong>.</li>
<li><strong>Discontinuities</strong> are allowed, by providing the same
    time point twice in the table.</li>
<li>Values <strong>outside</strong> of the table range, are computed by
    <strong>extrapolation</strong> through the last or first two points of the
    table.</li>
<li>If the table has only <strong>one row</strong>, no interpolation is performed and
    the function value is just returned independently of the actual time instant.</li>
<li>Via parameters <strong>shiftTime</strong> and <strong>offset</strong> the curve defined
    by the table can be shifted both in time and in the ordinate value.
    The time instants stored in the table are therefore <strong>relative</strong>
    to <strong>shiftTime</strong>.</li>
<li>If time &lt; startTime, no interpolation is performed and the offset
    is used as ordinate value for the output.</li>
<li>If the table has more than one row, the first point in time <strong>always</strong> has to be set to <strong>0</strong>, e.g.,
    <strong>table=[1,1;2,2]</strong> is <strong>illegal</strong>. If you want to
    shift the time table in time use the <strong>shiftTime</strong> parameter instead.</li>
<li>The table is implemented in a numerically sound way by
    generating <strong>time events</strong> at interval boundaries.
    This generates continuously differentiable values for the integrator.</li>
<li>Via parameter <strong>timeScale</strong> the first column of the table array can
    be scaled, e.g., if the table array is given in hours (instead of seconds)
    <strong>timeScale</strong> shall be set to 3600.</li>
</ul>
<p>
Example:
</p>
<blockquote><pre>
   table = [0, 0;
            1, 0;
            1, 1;
            2, 4;
            3, 9;
            4, 16];
If, e.g., time = 1.0, the output y =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the output y =  2.5,
    e.g., time = 2.0, the output y =  4.0,
    e.g., time = 5.0, the output y = 23.0 (i.e., extrapolation).
</pre></blockquote>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/TimeTable.png\"
     alt=\"TimeTable.png\">
</p>

</html>",
        revisions="<html>
<h4>Release Notes</h4>
<ul>
<li><em>Oct. 21, 2002</em>
       by Christian Schweiger:<br>
       Corrected interface from
<blockquote><pre>
parameter Real table[:, :]=[0, 0; 1, 1; 2, 4];
</pre></blockquote>
       to
<blockquote><pre>
parameter Real table[:, <strong>2</strong>]=[0, 0; 1, 1; 2, 4];
</pre></blockquote>
       </li>
<li><em>Nov. 7, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
</html>"));
end TimeTable;
