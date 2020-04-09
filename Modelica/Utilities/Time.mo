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

  function daysInYear "Get number of days in year"
    extends Modelica.Icons.Function;
    input Integer a  "Year";
    output Integer days "Number of days in year a";
  algorithm
    days := if isLeapYear(a) then 366 else 365;
  end daysInYear;

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

  operator record DateTime
    extends Modelica.Icons.Record;

    Integer millisecond(min=0, max=999) "Millisecond" annotation(absoluteValue=true);
    Integer second(min=0, max=61) "Second" annotation(absoluteValue=true);
    Integer minute(min=0, max=59) "Minute" annotation(absoluteValue=true);
    Integer hour(min=0, max=23) "Hour" annotation(absoluteValue=true);
    Integer day(min=1, max=31) "Day" annotation(absoluteValue=true);
    Integer month(min=1, max=12) "Month" annotation(absoluteValue=true);
    Integer year "Year" annotation(absoluteValue=true);

    encapsulated operator 'constructor'
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Icons;
      extends Icons.FunctionsPackage;

      function fromReadable
        extends Icons.Function;

        input Integer year "Year";
        input Integer month "Month";
        input Integer day "Day";
        input Integer hour "Hour";
        input Integer minute "Minute";
        input Integer second "Second";
        input Integer millisecond "Millisecond";

        output DateTime t(millisecond=millisecond, second=second, minute=minute, hour=hour, day=day, month=month, year=year);

      algorithm

      end fromReadable;

      function fromSystemTime "Get system time as elapsed seconds since custom epoch year"
        import Modelica.Utilities.Internal.Time.getTime;
        extends Icons.Function;

        output DateTime t;

      protected
        Integer millisecond "Millisecond";
        Integer second "Second";
        Integer minute "Minute";
        Integer hour "Hour";
        Integer day "Day";
        Integer month "Month";
        Integer year "Year";

      algorithm
        (millisecond, second, minute, hour, day, month, year) := getTime();
        t :=DateTime(millisecond=millisecond, second=second, minute=minute, hour=hour, day=day, month=month, year=year);

      end fromSystemTime;

      function fromEpoch
        import Modelica.Utilities.Internal.Time.getTime;
        import Modelica.Math.nearestInteger;
        import Modelica.Utilities.Time.isLeapYear;
        import Modelica.Utilities.Time.daysInYear;
        extends Icons.Function;

        input Real seconds "Elapsed seconds since epoch_year";
        input Integer epoch_year = 1970 "Reference year";
        output DateTime t;

      protected
        Integer[2,12] days_passed = {{31,59,90,120,151,181,212,243,273,304,334,365},
                                    {31,60,91,121,152,182,213,244,274,305,335,366}};
        Real rem;
        Integer days, day_of_year, counted_days;
        Integer i, j;

        Integer millisecond "Millisecond";
        Integer second "Second";
        Integer minute "Minute";
        Integer hour "Hour";
        Integer day "Day";
        Integer month "Month";
        Integer year "Year";

      algorithm

        // get milliseconds
        millisecond := nearestInteger(mod(abs(seconds),1)*1000);

        // get seconds
        second :=nearestInteger(mod(seconds,60));

        // get minutes
        rem :=seconds - second;
        minute :=nearestInteger(mod(rem/60, 60));

        // get hours
        rem :=rem - minute*60;
        hour :=nearestInteger(mod(rem/3600, 24));

        // get number of days since epoch year
        rem :=rem - hour*3600;
        days :=nearestInteger(rem/(24*3600));

        // get year
        if days >= 0 then
         // time is after reference year: count how many years must pass from reference year until 'days' is reached
         year :=epoch_year;
         counted_days := 0;
         while counted_days+daysInYear(year) <= days loop
           counted_days := counted_days + daysInYear(year);
           year :=year + 1;
         end while;
        else
         // time is before reference year: count years downwards
         year :=epoch_year - 1;
         counted_days := if isLeapYear(year) then -366 else -365;
         while counted_days > days loop
           year :=year - 1;
           counted_days := counted_days - daysInYear(year);
         end while;
        end if;

        // compute day in current year
        day_of_year :=days - counted_days + 1;

        // get month
        // use correct column depending on leap and regular year
        j :=if isLeapYear(year) then 2 else 1;
        for i in 1:12 loop
          if days_passed[j,i] >= day_of_year then
            month :=i;
            break;
          end if;
        end for;

        // get day
        day :=if month > 1 then day_of_year - days_passed[j,month-1] else day_of_year;

        t :=DateTime(millisecond=millisecond, second=second, minute=minute, hour=hour, day=day, month=month, year=year);

      end fromEpoch;
    end 'constructor';

    encapsulated operator 'String' "Convert DateTime to string"
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Utilities.Strings.replace;
      import Modelica.Icons;
      extends Icons.FunctionsPackage;

      function formated
        extends Icons.Function;

        import Modelica.Utilities.Internal.Time.dayOfWeek;
        import Modelica.Utilities.Time.weekDays;
        import Modelica.Utilities.Time.shortWeekDays;
        import Modelica.Utilities.Time.months;
        import Modelica.Utilities.Time.shortMonths;

        input DateTime t;
        input String format = "%Y-%m-%d %H:%M:%S";
        output String str;

      protected
        encapsulated function string0 "Create string with minimum length, filled with 0"
          import Modelica.Utilities.Strings.replace;
            input Integer i;
            input Integer l;
            output String s0;
        algorithm
            s0 :=replace(String(i, minimumLength=l, leftJustified=false), " ", "0");
        end string0;

      algorithm
        str :=replace(format, "%%", "%");
        str :=replace(str,    "%y", string0(mod(t.year, 100), l=2));
        str :=replace(str,    "%Y", string0(t.year, l=4));
        str :=replace(str,    "%m", string0(t.month, l=2));
        str :=replace(str,    "%d", string0(t.day, l=2));
        str :=replace(str,    "%H", string0(t.hour, l=2));
        str :=replace(str,    "%M", string0(t.minute, l=2));
        str :=replace(str,    "%S", string0(t.second, l=2));
        str :=replace(str,    "%L", string0(t.millisecond, l=3));
        str :=replace(str,    "%a", shortWeekDays[dayOfWeek(t.year, t.month, t.day)]);
        str :=replace(str,    "%A", weekDays[dayOfWeek(t.year, t.month, t.day)]);
        str :=replace(str,    "%b", shortMonths[t.month]);
        str :=replace(str,    "%B", months[t.month]);
        annotation (Documentation(info="<html>

<h4>Syntax</h4>
<blockquote>
<pre>
String(t)
String(t, format)
</pre>
</blockquote>

<h4>Description</h4>
<p>
    The input value \"t\" of type DateTime is converted to a string.
</p>
<p>
    The content of the output string can be controlled
    via the \"format\" string by setting one or more of the conversion specifiers listed below.
</p>

<table border=\"1\" cellpadding=\"2\" cellspacing=\"0\">
    <tr>
        <th>Specifier</th>
        <th>Meaning</th>
        <th>Examples</th>
    </tr>
    <tr>
        <td>%y</td>
        <td>year without century</td>
        <td>01, 02, ... 99</td>
    </tr>
    <tr>
        <td>%Y</td>
        <td>year with century</td>
        <td>2001, 2002, 2099</td>
    </tr>
    <tr>
        <td>%b</td>
        <td>abbreviated month name</td>
        <td>Jan, Feb</td>
    </tr>
    <tr>
        <td>%B</td>
        <td>full month name</td>
        <td>January, February</td>
    </tr>
    <tr>
        <td>%m</td>
        <td>month as number, zero padded to length 2</td>
        <td>01, 02, ... 12</td>
    </tr>
    <tr>
        <td>%a</td>
        <td>abbreviated weekday</td>
        <td>Mon, Tue</td>
    </tr>
    <tr>
        <td>%A</td>
        <td>full name of weekday</td>
        <td>Monday, Tuesday</td>
    </tr>
    <tr>
        <td>%d</td>
        <td>day of month, zero padded to length 2</td>
        <td>01, 02, ... 31</td>
    </tr>
    <tr>
        <td>%H</td>
        <td>hour, zero padded to length 2</td>
        <td>00, 01, ... 24</td>
    </tr>
    <tr>
        <td>%M</td>
        <td>minute, zero padded to length 2</td>
        <td>00, 01, ... 60</td>
    </tr>
    <tr>
        <td>%S</td>
        <td>second, zero padded to length 2</td>
        <td>00, 01, ... 60</td>
    </tr>
    <tr>
        <td>%%</td>
        <td>single percent character. Not fully supported. See the Limitations section below.</td>
        <td>%</td>
    </tr>
</table>

<p>Additionally the following conversion specifiers are supported, which are not part of the C standard.</p>
<table border=\"1\" cellpadding=\"2\" cellspacing=\"0\">
    <tr>
        <th>Specifier</th>
        <th>Meaning</th>
        <th>Examples</th>
    </tr>
    <tr>
        <td>%L</td>
        <td>millisecond, zero padded to length 3</td>
        <td>000, 001, ... 999</td>
    </tr>
</table>

<h4>Example</h4>
<blockquote>
<pre>
import Modelica.Utilities.Time.DateTime;
dt = DateTime(2020, 12, 24, 00, 01, 02, 003);

String(dt)                                       // = \"2020-12-24 00:01:02\"
String(dt, \"\"%a, %b. %d %Y, %H:%M:%S\"\")          // = \"Thu, Dec. 24 2020, 00:01:02\"
String(dt, format=\"%A, %d. %B %y, %H:%M:%S.%L\")  // = \"Thursday, 24. December 20, 00:01:02.003\"
</pre>
</blockquote>

<h4>Limitations</h4>
<p>
    This function uses simple string replace methods to exchange the conversion specifiers with the appropriate values.
</p>
<p>
    When additional % characters are included in the format string (via %%) problems can occur, like shown below.
</p>

<blockquote>
<pre>
// ANTI-EXAMPLE - do not use
String(dt, format=\"%%b\")  // Should give \"%b\", but gives \"Dec.\" instead
</pre>
</blockquote>

</html>"));
      end formated;

    end 'String';

    encapsulated operator function '=='
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Icons;
      extends Icons.Function;

      input DateTime t1;
      input DateTime t2;
      output Boolean result "= t1 == t2";

    algorithm
      result := t1.year == t2.year and
                t1.month == t2.month and
                t1.day == t2.day and
                t1.hour == t2.hour and
                t1.minute == t2.minute and
                t1.second == t2.second and
                t1.millisecond == t2.millisecond;

    end '==';

    encapsulated operator function '<>'
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Icons;
      extends Icons.Function;

      input DateTime t1;
      input DateTime t2;
      output Boolean result "= t1 <> t2";

    algorithm
      result := not t1 == t2;
    end '<>';

    encapsulated operator function '>'
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Icons;
      extends Icons.Function;

      input DateTime t1;
      input DateTime t2;
      output Boolean result "= t1 <> t2";

    algorithm
      if t1.year > t2.year then
        result :=true;
      else
        if t1.year==t2.year and t1.month > t2.month then
          result :=true;
        else
          if t1.month==t2.month and t1.day > t2.day then
            result :=true;
          else
            if t1.day==t2.day and t1.hour > t2.hour then
              result :=true;
            else
              if t1.hour==t2.hour and t1.minute > t2.minute then
                result :=true;
              else
                if t1.minute==t2.minute and t1.second > t2.second then
                  result :=true;
                else
                  if t1.second==t2.second and t1.millisecond > t2.millisecond then
                    result :=true;
                  else
                    result :=false;
                  end if;
                end if;
              end if;
            end if;
          end if;
        end if;
      end if;
    end '>';

    encapsulated operator function '>='
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Icons;
      extends Icons.Function;

      input DateTime t1;
      input DateTime t2;
      output Boolean result "= t1 >= t2";

    algorithm
      result :=t1 == t2 or t1 > t2;

    end '>=';

    encapsulated operator function '<'
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Icons;
      extends Icons.Function;

      input DateTime t1;
      input DateTime t2;
      output Boolean result "= t1 < t2";

    algorithm
      result := not t1 == t2 and t2 > t1;

    end '<';

    encapsulated operator function '<='
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Icons;
      extends Icons.Function;

      input DateTime t1;
      input DateTime t2;
      output Boolean result "= t1 <= t2";

    algorithm
      result := t1 == t2 or t1 < t2;

    end '<=';

    encapsulated operator '-' "Unary and binary minus"
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Icons;

      extends Icons.FunctionsPackage;

      function subtract "Subtract two durations element wise"
        extends Icons.Function;

        import Modelica.Utilities.Time.Duration;

        input DateTime t1;
        input DateTime t2;
        output Duration result "= t1 - t2";

      algorithm
        result := Duration.'constructor'.fromDateTimes(t2, t1);

      end subtract;

    end '-';

    encapsulated function epoch "Convert time to elapsed seconds since custom epoch year"
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Utilities.Time.isLeapYear;
      import Modelica.Icons;
      extends Icons.Function;

      input DateTime t;
      input Integer epoch_year = 1970 "Reference year";
      output Real seconds "Elapsed seconds since epoch_year";

    protected
      Integer[2,12] days_passed = {{0,31,59,90,120,151,181,212,243,273,304,334},
                                   {0,31,60,91,121,152,182,213,244,274,305,335}};
      Integer leap_days, day_of_year;
      Integer leap_years_til_epoch;
      Integer j;

      // Aux variables for shorter access in code
      Integer millisecond=t.millisecond "Millisecond";
      Integer second=t.second "Second";
      Integer minute=t.minute "Minute";
      Integer hour=t.hour "Hour";
      Integer day=t.day "Day";
      Integer month=t.month "Month";
      Integer year=t.year "Year";

    algorithm
      // get leap years from year 0 until the chosen epoch year
      leap_years_til_epoch :=integer(epoch_year/4) - integer((epoch_year)/100) + integer((epoch_year)/400);

      // get leap days of passed years since epoch year
      leap_days :=integer((year-1)/4) - integer((year-1)/100) + integer((year-1)/400) - leap_years_til_epoch;

      // get current day of year and consider leap day if current year is leap year and february has passed
      j := if isLeapYear(year) then 2 else 1;
      day_of_year :=day + days_passed[j,month];

      seconds :=millisecond/1000 + second + 60*(minute + 60*(hour + 24*(day_of_year-1 + leap_days + 365*(year-epoch_year))));

    end epoch;

    encapsulated function now "Get current system date and time as DateTime"
      import Modelica.Utilities.Time.DateTime;
      output DateTime now;
    algorithm
       now:=DateTime.'constructor'.fromSystemTime();
    end now;

  end DateTime;

  operator record Duration
    extends Modelica.Icons.Record;

    Integer days "Days";
    Integer hours "Hours";
    Integer minutes "Minutes";
    Integer seconds "Seconds";
    Integer milliseconds "Milliseconds";

    encapsulated operator 'constructor'
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons;
      extends Icons.FunctionsPackage;

      function fromInput
        extends Icons.Function;

        input Integer days=0 "Days";
        input Integer hours=0 "Hours";
        input Integer minutes=0 "Minutes";
        input Integer seconds=0 "Seconds";
        input Integer milliseconds=0 "Milliseconds";
        output Duration t(days=days, hours=hours, minutes=minutes, seconds=seconds, milliseconds=milliseconds);
      algorithm
      end fromInput;

      function fromDateTimes
        import Modelica.Utilities.Time.DateTime;
        import Modelica.Math.nearestInteger;
        extends Icons.Function;

        input DateTime t1 "Start time";
        input DateTime t2 "End time";
        output Duration t;

      protected
        Real diff;
        Integer sign_;
        Real e1, e2;
        DateTime t_tmp;
        Integer days "Elapsed days";
        Integer hours "Elapsed hours";
        Integer minutes "Elapsed minutes";
        Integer seconds "Elapsed seconds";
        Integer milliseconds "Elapsed milliseconds";

      algorithm
        t_tmp :=t2;

        e1 :=DateTime.epoch(t1, epoch_year=t1.year);
        e2 :=DateTime.epoch(t_tmp, epoch_year=t1.year);

        diff :=abs(e2 - e1);
        sign_ :=sign(e2 - e1);

        days := integer(diff/(24*3600));
        hours := integer(diff/3600-days*24);
        minutes := integer((diff-(days*24+hours)*3600)/60);
        seconds := integer(diff - (days*24+hours)*3600 - minutes*60);
        milliseconds := nearestInteger(rem(diff,1)*1000);

        hours := sign_*hours;
        minutes := sign_*minutes;
        seconds := sign_*seconds;
        milliseconds := sign_*milliseconds;

        t :=Duration(days=days, hours=hours, minutes=minutes, seconds=seconds, milliseconds=milliseconds);

      end fromDateTimes;

      function fromSeconds "Create duration record from seconds, rounding to the third decimal"
        extends Icons.Function;
        import Modelica.Math.nearestInteger;

        input Real totalSeconds "Duration in seconds. Decimal place is converted to milliseconds";
        output Duration t "Duration with input converted to seconds and milliseconds";

      protected
        Integer days, hours, minutes, seconds, milliseconds;
        Integer carryover;

      algorithm

        milliseconds := nearestInteger(rem(totalSeconds, 1) * 1000);

        seconds :=integer(div(totalSeconds, 1));
        carryover :=div(seconds, 60);
        seconds := rem(seconds, 60);

        minutes :=carryover;
        carryover :=div(minutes, 60);
        minutes :=rem(minutes, 60);

        hours :=carryover;
        carryover :=div(hours, 24);
        hours := rem(hours, 24);

        days := carryover;

        t :=Duration(
            days=days,
            hours=hours,
            minutes=minutes,
            seconds=seconds,
            milliseconds=milliseconds);

      end fromSeconds;
    end 'constructor';

    encapsulated operator 'String' "Convert Duration to string"
      import Modelica.Utilities.Time.Duration;
      import Modelica.Utilities.Strings.replace;
      import Modelica.Icons;
      extends Icons.FunctionsPackage;

      function formated "Convert duration to string, using string replace"
        import Modelica.Utilities.Strings.contains;
        extends Icons.Function;

        input Duration t;
        input String format = "%daysd %hoursh %minutesmin %secondss %millisecondsms";
        output String str;

      protected
        Duration t2;

        encapsulated function string0 "Create string with minimum length, filled with 0"
          import Modelica.Utilities.Strings.replace;
            input Integer i;
            input Integer l;
            output String s0;
        algorithm
            s0 :=replace(String(i, minimumLength=l, leftJustified=false), " ", "0");
        end string0;

      algorithm

        t2 :=t;

        if not contains(format, "%days") and not contains(format, "%d") then
          t2.hours :=t2.hours + t2.days*24;
        end if;

        if not contains(format, "%hours") and not contains(format, "%H") then
          t2.minutes :=t2.minutes + t2.hours*60;
        end if;

        if not contains(format, "%minutes") and not contains(format, "%M") then
          t2.seconds :=t2.seconds + t2.minutes*60;
        end if;

        if not contains(format, "%seconds") and not contains(format, "%S") then
          t2.milliseconds :=t2.milliseconds + t2.seconds*1000;
        end if;

        str :=replace(format, "%%",            "%");
        str :=replace(str,    "%days",         String( t2.days));
        str :=replace(str,    "%d",            string0(t2.days, l=2));
        str :=replace(str,    "%hours",        String( t2.hours));
        str :=replace(str,    "%H",            string0(t2.hours, l=2));
        str :=replace(str,    "%minutes",      String( t2.minutes));
        str :=replace(str,    "%M",            string0(t2.minutes, l=2));
        str :=replace(str,    "%seconds",      String( t2.seconds));
        str :=replace(str,    "%S",            string0(t2.seconds, l=2));
        str :=replace(str,    "%milliseconds", String( t2.milliseconds));
        str :=replace(str,    "%L",            string0(t2.milliseconds, l=3));

        annotation (Documentation(info="<html>

<h4>Syntax</h4>
<blockquote>
<pre>
String(t)
String(t, format)
</pre>
</blockquote>

<h4>Description</h4>
<p>
    The input value \"t\" of type Duration is converted to a string.
</p>
<p>
    The content of the output string can be controlled
    via the \"format\" string by setting one or more of the conversion specifiers listed below.
</p>
<p>
    If higher time value are not included, they are added to the next lower time value.
    If e.g. days are not part of the format string, but hours, the number of days will be converted 
    to hours and added to the hours value.
</p>
<p>
    If lower time values are not included, they are neglected.
    If e.g. only days and hours are part of the format string, minutes, seconds and milliseconds will be ignored.
</p>

<table border=\"1\" cellpadding=\"2\" cellspacing=\"0\">
    <tr>
        <th>Specifier</th>
        <th>Meaning</th>
        <th>Examples</th>
    </tr>
    <tr>
        <td>%d</td>
        <td>number of days, zero padded to length 2</td>
        <td>01, 02, ...</td>
    </tr>
    <tr>
        <td>%days</td>
        <td>number of days as simple decimal</td>
        <td>1, 2, ...</td>
    </tr>
    <tr>
        <td>%H</td>
        <td>number of hours, zero padded to length 2</td>
        <td>00, 01, ...</td>
    </tr>
    <tr>
        <td>%hours</td>
        <td>number of hours as simple decimal</td>
        <td>0, 1, ...</td>
    </tr>
    <tr>
        <td>%M</td>
        <td>number of minutes, zero padded to length 2</td>
        <td>00, 01, ...</td>
    </tr>
    <tr>
        <td>%minutes</td>
        <td>number of minutes as simple decimal</td>
        <td>0, 1, ...</td>
    </tr>
    <tr>
        <td>%S</td>
        <td>number of seconds, zero padded to length 2</td>
        <td>00, 01, ...</td>
    </tr>
    <tr>
        <td>%seconds</td>
        <td>number of seconds as simple decimal</td>
        <td>0, 1, ...</td>
    </tr>
    <tr>
        <td>%L</td>
        <td>number of milliseconds, zero padded to length 3</td>
        <td>00, 01, ...</td>
    </tr>
    <tr>
        <td>%milliseconds</td>
        <td>number of milliseconds as simple decimal</td>
        <td>0, 1, ...</td>
    </tr>
    <tr>
        <td>%%</td>
        <td>single percent character. Not fully supported. See the Limitations section below.</td>
        <td>%</td>
    </tr>
</table>

<h4>Example</h4>
<blockquote>
<pre>
import Modelica.Utilities.Time.Duration;
d = Duration(days=1, hour=2, minutes=3, seconds=4, milliseconds=5);

String(d)                        // = \"1d 2h 3min 4s 5ms\"
String(d, \"%hoursh %secondss\")   // = \"26h 184s\" (days are included in hours, minutes in seconds, ms stripped off)
String(d, format=\"%Hh %S.%L''\")  // = \"26h 184.005''\" (days are included in hours, minutes in seconds)
String(d, format=\"%days'\")          // = \"1\" (only full days are shown, rest is stripped off)
</pre>
</blockquote>

<h4>Limitations</h4>
<p>
    This function uses simple string replace methods to exchange the conversion specifiers with the appropriate values.
</p>
<p>
    When additional % characters are included in the format string (via %%) problems can occur, like shown below.
</p>

<blockquote>
<pre>
// ANTI-EXAMPLE - do not use
String(d, format=\"%%days\")  // Should give \"%days\", but gives \"1\" instead
</pre>
</blockquote>

</html>"));
      end formated;

    end 'String';

    encapsulated operator function '=='
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons;
      extends Icons.Function;

      input Duration t1;
      input Duration t2;
      output Boolean result "= t1 == t2";

    protected
      Duration t1_norm = Duration.normalize(t1);
      Duration t2_norm = Duration.normalize(t2);

    algorithm
      result := t1_norm.days == t2_norm.days and
                t1_norm.hours == t2_norm.hours and
                t1_norm.minutes == t2_norm.minutes and
                t1_norm.seconds == t2_norm.seconds and
                t1_norm.milliseconds == t2_norm.milliseconds;

    end '==';

    encapsulated operator function '<>'
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons;
      extends Icons.Function;

      input Duration t1;
      input Duration t2;
      output Boolean result "= t1 <> t2";

    algorithm
      result := not t1 == t2;
    end '<>';

    encapsulated operator function '>'
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons;
      extends Icons.Function;

      input Duration t1;
      input Duration t2;
      output Boolean result "= t1 <> t2";

    algorithm
      result :=Duration.inSeconds(t1) > Duration.inSeconds(t2);
    end '>';

    encapsulated operator function '>='
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons;
      extends Icons.Function;

      input Duration t1;
      input Duration t2;
      output Boolean result "= t1 >= t2";

    algorithm
      result :=t1 == t2 or t1 > t2;

    end '>=';

    encapsulated operator function '<'
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons;
      extends Icons.Function;

      input Duration t1;
      input Duration t2;
      output Boolean result "= t1 < t2";

    algorithm
      result := not t1 == t2 and t2 > t1;

    end '<';

    encapsulated operator function '<='
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons;
      extends Icons.Function;

      input Duration t1;
      input Duration t2;
      output Boolean result "= t1 <= t2";

    algorithm
      result := t1 == t2 or t1 < t2;

    end '<=';

    encapsulated operator function '+'
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons;
      extends Icons.Function;

      input Duration t1;
      input Duration t2;
      output Duration result "= t1 + t2";

    algorithm
      result := Duration.normalize(Duration(
        days=t1.days + t2.days,
        hours=t1.hours + t2.hours,
        minutes=t1.minutes + t2.minutes,
        seconds=t1.seconds + t2.seconds,
        milliseconds=t1.milliseconds + t2.milliseconds));

    end '+';

    encapsulated operator '-' "Unary and binary minus"
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons;

      extends Icons.FunctionsPackage;

      function subtract "Subtract two durations element wise"
        extends Icons.Function;

        input Duration t1;
        input Duration t2;
        output Duration result "= t1 - t2";

      algorithm
        result := Duration.normalize(Duration(
          days=t1.days - t2.days,
          hours=t1.hours - t2.hours,
          minutes=t1.minutes - t2.minutes,
          seconds=t1.seconds - t2.seconds,
          milliseconds=t1.milliseconds - t2.milliseconds));

      end subtract;

      function negate "Unary minus (multiply duration values by -1)"
        extends Icons.Function;

        input Duration t;
        output Duration result "= -t1";

      algorithm
        result := Duration(
          days=-t.days,
          hours=-t.hours,
          minutes=-t.minutes,
          seconds=-t.seconds,
          milliseconds=-t.milliseconds);

      end negate;
    end '-';

    encapsulated operator '*' "Multiplication"
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons;

      extends Icons.FunctionsPackage;

      function multiply1 "Multiply a duration with a real (by converting the duration to seconds)"
        extends Icons.Function;

        input Duration t;
        input Real r;
        output Duration result "= inSeconds(t)*r";

      algorithm
        result := Duration(totalSeconds=Duration.inSeconds(t)*r);

      end multiply1;

      function multiply2 "Multiply a duration with a real (by converting the duration to seconds)"
        extends Icons.Function;

        input Real r;
        input Duration t;
        output Duration result "= inSeconds(t)*r";

      algorithm
        result := Duration(totalSeconds=r*Duration.inSeconds(t));

      end multiply2;
    end '*';

    encapsulated operator '/'  "Divide a duration by a real"
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons;

      extends Icons.FunctionsPackage;

      function divide "Divide a duration by a real. The first milliseconds value can vary by 1 (due to rounding in the fromSeconds constructor)"
        extends Icons.Function;

        input Duration t;
        input Real r;
        output Duration result "= inSeconds(t)/r";

      algorithm
        result := Duration(totalSeconds=Duration.inSeconds(t)/r);

      end divide;

    end '/';

    encapsulated operator function '0' "Zero-element of addition (= Duration())"
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons;
      extends Icons.Function;

      output Duration result "= Duration()";

    algorithm
      result := Duration(days=0, hours=0, minutes=0, seconds=0, milliseconds=0);

    end '0';

  encapsulated function asVector "Return duration as vector {days, hours, minutes, seconds, milliseconds}"
    import Modelica.Utilities.Time.Duration;
    import Modelica.Icons;
    extends Icons.Function;

    input Duration t "Value to convert";
    output Integer[5] t_vec "Elapsed time as vector {days, hours, minutes, seconds, milliseconds}";

  algorithm

    t_vec :={t.days, t.hours, t.minutes, t.seconds, t.milliseconds};

  end asVector;

  encapsulated function avg "Return average duration for a vector of durations"
    import Modelica.Utilities.Time.Duration;
    import Modelica.Icons;
    extends Icons.Function;

    input Duration t_vec[:];
    output Duration t_avg "Average duration";

    protected
    Integer n = size(t_vec, 1);
    Real totalSeconds = 0;

  algorithm
    for i in 1:n loop
      totalSeconds := totalSeconds + Duration.inSeconds(t_vec[i]);
    end for;

    t_avg := Duration(totalSeconds=totalSeconds/n);

  end avg;

  encapsulated function inSeconds "Convert Duration to total amount of seconds"
    import Modelica.Utilities.Time.Duration;
    import Modelica.Icons;
    extends Icons.Function;

    input Duration t;
    output Real totalSeconds "Elapsed seconds";

  algorithm
    totalSeconds :=t.milliseconds/1000 + t.seconds + 60*(t.minutes + 60*(t.hours + 24*t.days));

  end inSeconds;

  encapsulated function normalize "Reformat duration with usual maximum values for milliseconds, seconds, minutes and hours and carryover to next bigger unit"
    import Modelica.Utilities.Time.Duration;
    import Modelica.Icons;
    extends Icons.Function;

    input Duration t "Duration";
    output Duration t_norm "Normalized duration";

  algorithm

    t_norm :=Duration(totalSeconds=Duration.inSeconds(t));

  end normalize;

  end Duration;
    annotation (
Documentation(info="<html>
<p>
This package contains functions to work with date and time.
</p>
</html>"));
end Time;
