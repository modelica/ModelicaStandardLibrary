within Modelica.Utilities;
package Time "Functions to work with date and time"
  extends Modelica.Icons.FunctionsPackage;

  impure function getTime "Retrieve the current time (in the local time zone)"
    extends Modelica.Icons.Function;
    output Types.TimeType now "Current time";
  algorithm
    (now.millisecond, now.second, now.minute, now.hour, now.day, now.month, now.year) := Internal.Time.getTime();
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

  function dayOfWeek "Return day of week for given date"
    extends Modelica.Icons.Function;
    input Types.TimeType timeIn "Date";
    output Integer dow(min=1, max=7) "Day of week: 1 = Monday, ..., 6 = Saturday, 7 = Sunday";
  algorithm
    dow := Internal.Time.dayOfWeek(timeIn.year, timeIn.month, timeIn.day);
      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
dow = Time.<strong>dayOfWeek</strong>(timeIn);
</pre></blockquote>
<h4>Description</h4>
<p>
Returns the day of the week for a given date using Tomohiko Sakamoto's algorithm.
The returned Integer number of <code>dow</code> has the following meaning:
</p>

<blockquote>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Day of week</th>
    <th>Number</th></tr>

<tr><td>Monday</td> <td>1</td></tr>

<tr><td>Tuesday</td> <td>2</td></tr>

<tr><td>Wednesday</td> <td>3</td></tr>

<tr><td>Thursday</td> <td>4</td></tr>

<tr><td>Friday</td> <td>5</td></tr>

<tr><td>Saturday</td> <td>6</td></tr>

<tr><td>Sunday</td> <td>7</td></tr>

</table>
</blockquote>

<h4>Example</h4>
<blockquote><pre>
now = getTime()      // = Modelica.Utilities.Types.TimeType(281, 30, 13, 10, 6, 12, 2019)
                     // Dec. 06, 2019 at 10:13 after 30.281 s
dow = dayOfWeek(now) // = 5
                     // Dec. 06, 2019 (Saint Nicholas Day) is a Friday
</pre></blockquote>
</html>"));
  end dayOfWeek;

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

  final constant String weekDays[7] = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"} "Array of week days";
  final constant String shortWeekDays[7] = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"} "Array of abbreviated week days";
  final constant String months[12] = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"} "Array of month names";
  final constant String shortMonths[12] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"} "Array of abbreviated month names";

    annotation (
Documentation(info="<html>
<p>
This package contains functions to work with date and time.
</p>
</html>"));
end Time;
