within Modelica.Utilities;
package Time "Functions to work with date and time"
  extends Modelica.Icons.FunctionsPackage;

  impure function getTime "Retrieve the current time (in the local time zone)"
    extends Modelica.Icons.Function;
    output Types.TimeType now "Current time";
  algorithm
    (now.ms, now.sec, now.min, now.hour, now.day, now.mon, now.year) := Internal.Time.getTime();
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
(ms, sec, min, hour, day, mon, year) = System.<strong>getTime</strong>();
</pre></blockquote>
<h4>Description</h4>
<p>
Returns the local time at the time instant this function was called.
All returned values are of type Integer and have the following meaning:
</p>

<blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Argument</th>
    <th>Range</th>
    <th>Description</th></tr>

<tr><td>ms</td> <td>0 .. 999</td>
    <td>Milli-seconds after seconds</td></tr>

<tr><td>sec</td> <td>0 .. 59</td>
    <td>Seconds after minute</td></tr>

<tr><td>min</td> <td>0 .. 59</td>
    <td>Minutes after hour</td></tr>

<tr><td>hour</td> <td>0 .. 23</td>
    <td>Hours after midnight</td></tr>

<tr><td>day</td> <td>1 .. 31</td>
    <td>Day of month</td></tr>

<tr><td>mon</td> <td>1 .. 12</td>
    <td>Current month</td></tr>

<tr><td>year</td> <td>&ge; 2015</td>
    <td>Current year</td></tr>
</table>
</blockquote>

<h4>Example</h4>
<blockquote><pre>
(ms, sec, min, hour, day, mon, year) = getTime()   // = (281, 30, 13, 10, 15, 2, 2015)
                                              // Feb. 15, 2015 at 10:13 after 30.281 s
</pre></blockquote>
<h4>Note</h4>
<p>This function is impure!</p>
</html>"));
  end getTime;

  function isLeapYear "Check if a year is a leap year"
    extends Modelica.Icons.Function;
    input Integer year "Year";
    output Boolean isLeap "= true, if year is a leap year";
  algorithm
    isLeap := (mod(year, 4) == 0 and mod(year, 100) <> 0) or mod(year, 400) == 0;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
isLeap = Time.<strong>isLeapYear</strong>(year);
</pre></blockquote>
<h4>Description</h4>
<p>
Checks if a given year is a leap year.
</p>
</html>"));
  end isLeapYear;

  function leapDays "Return the number of leap days in range"
    extends Modelica.Icons.Function;
    input Integer year1 "First year";
    input Integer year2 "Second year";
    output Integer days "Number of leap days in range [year1, year2 - 1]";
  protected
    Integer d "Length of range";
    Integer y1;
    Integer y2;
  algorithm
    d := year2 - year1;
    if d == 0 then
      days := 0;
      return;
    elseif d < 0 then
      y1 := year2;
      y2 := year1;
      d := -d;
    else
      y1 := year1;
      y2 := year2;
    end if;
    days := div(d - 1, 4) - div(d - 1, 100) + div(d - 1, 400);
    if isLeapYear(y1) or isLeapYear(y2 - 1) then
      days := days + 1;
    end if;
    if year1 > year2 then
      days := -days;
    end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
days = Time.<strong>leapDays</strong>(year1, year2);
</pre></blockquote>
<h4>Description</h4>
<p>
Returns the number of leap days in the range [<code>year1</code>, <code>year2</code> - 1].
In case of <code>year1</code> &gt; <code>year2</code>, the result is the negative number of leap days in range [<code>year2</code>, <code>year1</code> - 1].
</p>
<h4>Example</h4>
<blockquote><pre>
days = leapDays(2000, 2020) // = 5 leap days in range [2000, 2019]
                            // for the years 2000, 2004, 2008, 2012 and 2016
                            // excluding the second year 2020
</pre></blockquote>
</html>"));
  end leapDays;

    annotation (
Documentation(info="<html>
<p>
This package contains functions to work with date and time.
</p>
</html>"));
end Time;
