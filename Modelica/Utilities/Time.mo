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

    Integer a "Year";
    Integer mon "Month";
    Integer d "Day";
    Integer h "Hour";
    Integer min "Minute";
    Integer s "Second";
    Integer ms "Millisecond";

    encapsulated operator 'constructor'
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Icons;
      extends Icons.FunctionsPackage;

      function fromReadable
        extends Icons.Function;

        input Integer a "Year";
        input Integer mon "Month";
        input Integer d "Day";
        input Integer h "Hour";
        input Integer min "Minute";
        input Integer s "Second";
        input Integer ms "Millisecond";

        output DateTime t(ms=ms, s=s, min=min, h=h, d=d, mon=mon, a=a);

      algorithm

      end fromReadable;

      function fromSystemTime "Get system time as elapsed seconds since custom epoch year"
        import Modelica.Utilities.Internal.Time.getTime;
        extends Icons.Function;

        output DateTime t;

      protected
        Integer ms "Millisecond";
        Integer s "Second";
        Integer min "Minute";
        Integer h "Hour";
        Integer d "Day";
        Integer mon "Month";
        Integer a "Year";

      algorithm
        (ms, s, min, h, d, mon, a) := getTime();
        t :=DateTime(ms=ms, s=s, min=min, h=h, d=d, mon=mon, a=a);

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

        Integer ms "Millisecond";
        Integer s "Second";
        Integer min "Minute";
        Integer h "Hour";
        Integer d "Day";
        Integer mon "Month";
        Integer a "Year";

      algorithm

        // get milliseconds
        ms := nearestInteger(mod(abs(seconds),1)*1000);

        // get seconds
        s :=nearestInteger(mod(seconds,60));

        // get minutes
        rem :=seconds - s;
        min :=nearestInteger(mod(rem/60, 60));

        // get hours
        rem :=rem - min*60;
        h :=nearestInteger(mod(rem/3600, 24));

        // get number of days since epoch year
        rem :=rem - h*3600;
        days :=nearestInteger(rem/(24*3600));

        // get year
        if days >= 0 then
         // time is after reference year: count how many years must pass from reference year until 'days' is reached
         a :=epoch_year;
         counted_days := 0;
         while counted_days+daysInYear(a) <= days loop
           counted_days := counted_days + daysInYear(a);
           a :=a + 1;
         end while;
        else
         // time is before reference year: count years downwards
         a :=epoch_year - 1;
         counted_days := if isLeapYear(a) then -366 else -365;
         while counted_days > days loop
           a :=a - 1;
           counted_days := counted_days - daysInYear(a);
         end while;
        end if;

        // compute day in current year
        day_of_year :=days - counted_days + 1;

        // get month
        // use correct column depending on leap and regular year
        j :=if isLeapYear(a) then 2 else 1;
        for i in 1:12 loop
          if days_passed[j,i] >= day_of_year then
            mon :=i;
            break;
          end if;
        end for;

        // get day
        d :=if mon > 1 then day_of_year - days_passed[j,mon-1] else day_of_year;

        t :=DateTime(ms=ms, s=s, min=min, h=h, d=d, mon=mon, a=a);

      end fromEpoch;
    end 'constructor';

    encapsulated operator 'String' "Convert DateTime to string"
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Utilities.Strings.replace;
      import Modelica.Icons;
      extends Icons.FunctionsPackage;

      function formated
        extends Icons.Function;

        input DateTime t;
        input String format = "%y-%mon-%d %H:%MIN:%S";
        output String s;

      protected
        encapsulated function string0
          import Modelica.Utilities.Strings.replace;
            input Integer s;
            input Integer l;
            output String s0;
        algorithm
            s0 :=replace(String(s, minimumLength=l, leftJustified=false), " ", "0");
        end string0;

      algorithm
        s :=replace(format, "%y",   string0(t.a, l=4));
        s :=replace(s,      "%Y",   string0(t.a, l=4));
        s :=replace(s,      "%mon", String(t.mon));
        s :=replace(s,      "%MON", string0(t.mon, l=2));
        s :=replace(s,      "%d",   String(t.d));
        s :=replace(s,      "%D",   string0(t.d, l=2));
        s :=replace(s,      "%h",   String(t.h));
        s :=replace(s,      "%H",   string0(t.h, l=2));
        s :=replace(s,      "%min", String(t.min));
        s :=replace(s,      "%MIN", string0(t.min, l=2));
        s :=replace(s,      "%s",   String(t.s));
        s :=replace(s,      "%S",   string0(t.s, l=2));
        s :=replace(s,      "%ms",  String(t.ms));
        s :=replace(s,      "%MS",  string0(t.ms, l=2));

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
      result := t1.a == t2.a and
                t1.mon == t2.mon and
                t1.d == t2.d and
                t1.h == t2.h and
                t1.min == t2.min and
                t1.s == t2.s and
                t1.ms == t2.ms;

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
      if t1.a > t2.a then
        result :=true;
      else
        if t1.a==t2.a and t1.mon > t2.mon then
          result :=true;
        else
          if t1.mon==t2.mon and t1.d > t2.d then
            result :=true;
          else
            if t1.d==t2.d and t1.h > t2.h then
              result :=true;
            else
              if t1.h==t2.h and t1.min > t2.min then
                result :=true;
              else
                if t1.min==t2.min and t1.s > t2.s then
                  result :=true;
                else
                  if t1.s==t2.s and t1.ms > t2.ms then
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
      Integer ms=t.ms "Millisecond";
      Integer s=t.s "Second";
      Integer min=t.min "Minute";
      Integer h=t.h "Hour";
      Integer d=t.d "Day";
      Integer mon=t.mon "Month";
      Integer a=t.a "Year";

    algorithm
      // get leap years from year 0 until the chosen epoch year
      leap_years_til_epoch :=integer(epoch_year/4) - integer((epoch_year)/100) + integer((epoch_year)/400);

      // get leap days of passed years since epoch year
      leap_days :=integer((a-1)/4) - integer((a-1)/100) + integer((a-1)/400) - leap_years_til_epoch;

      // get current day of year and consider leap day if current year is leap year and february has passed
      day_of_year :=d + days_passed[j,mon];
      j := if isLeapYear(a) then 2 else 1;

      seconds :=ms/1000 + s + 60*(min + 60*(h + 24*(day_of_year-1 + leap_days + 365*(a-epoch_year))));

    end epoch;

  end DateTime;

  operator record Duration
    extends Modelica.Icons.Record;

    Integer d "Days";
    Integer h "Hours";
    Integer min "Minutes";
    Integer s "Seconds";
    Integer ms "Milliseconds";

    encapsulated operator 'constructor'
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons;
      extends Icons.FunctionsPackage;

      function fromInput
        extends Icons.Function;

        input Integer d=0 "Days";
        input Integer h=0 "Hours";
        input Integer min=0 "Minutes";
        input Integer s=0 "Seconds";
        input Integer ms=0 "Milliseconds";
        output Duration t(d=d, h=h, min=min, s=s, ms=ms);
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
        Integer d "Elapsed days";
        Integer h "Elapsed hours";
        Integer min "Elapsed minutes";
        Integer s "Elapsed seconds";
        Integer ms "Elapsed milliseconds";

      algorithm
        t_tmp :=t2;

        e1 :=DateTime.epoch(t1, epoch_year=t1.a);
        e2 :=DateTime.epoch(t_tmp, epoch_year=t1.a);

        diff :=abs(e2 - e1);
        sign_ :=sign(e2 - e1);

        d := integer(diff/(24*3600));
        h := integer(diff/3600-d*24);
        min := integer((diff-(d*24+h)*3600)/60);
        s := integer(diff - (d*24+h)*3600 - min*60);
        ms := nearestInteger(rem(diff,1)*1000);

        h := sign_*h;
        min := sign_*min;
        s := sign_*s;
        ms := sign_*ms;

        t :=Duration(d=d, h=h, min=min, s=s, ms=ms);

      end fromDateTimes;

      function fromSeconds "Create duration record from seconds, rounding to the third decimal"
        extends Icons.Function;
        import Modelica.Math.nearestInteger;

        input Real seconds "Duration in seconds. Decimal place is converted to ms";
        output Duration t "Duration with input converted to s and ms";

      protected
        Integer d, h, min, s, ms;
        Integer carryover;

      algorithm

        ms := nearestInteger(rem(seconds, 1) * 1000);

        s :=integer(div(seconds, 1));
        carryover :=div(s, 60);
        s := rem(s, 60);

        min :=carryover;
        carryover :=div(min, 60);
        min :=rem(min, 60);

        h :=carryover;
        carryover :=div(h, 24);
        h := rem(h, 24);

        d := carryover;

        t :=Duration(
            d=d,
            h=h,
            min=min,
            s=s,
            ms=ms);

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
        input String format = "%dd %hh %minmin %ss %msms";
        output String s;

      protected
        Duration t2;

        encapsulated function string0
          import Modelica.Utilities.Strings.replace;
            input Integer s;
            input Integer l;
            output String s0;
        algorithm
            s0 :=replace(String(s, minimumLength=l, leftJustified=false), " ", "0");
        end string0;

      algorithm

        t2 :=t;

        if not contains(format, "%d") and not contains(format, "%D") then
          t2.h :=t2.h + t2.d*24;
        end if;

        if not contains(format, "%h") and not contains(format, "%H") then
          t2.min :=t2.min + t2.h*60;
        end if;

        if not contains(format, "%min") and not contains(format, "%MIN") then
          t2.s :=t2.s + t2.min*60;
        end if;

        if not contains(format, "%s") and not contains(format, "%S") then
          t2.ms :=t2.ms + t2.s*1000;
        end if;

        s :=replace(format, "%d", String(t2.d));
        s :=replace(s,      "%D", string0(t2.d, l=2));
        s :=replace(s,      "%h", String(t2.h));
        s :=replace(s,      "%H", string0(t2.h, l=2));
        s :=replace(s, "%min", String(t2.min));
        s :=replace(s, "%MIN", string0(t2.min, l=2));
        s :=replace(s, "%s",   String(t2.s));
        s :=replace(s, "%S",   string0(t2.s, l=2));
        s :=replace(s, "%ms",  String(t2.ms));
        s :=replace(s, "%MS",  string0(t2.ms, l=3));

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
      result := t1_norm.d == t2_norm.d and
                t1_norm.h == t2_norm.h and
                t1_norm.min == t2_norm.min and
                t1_norm.s == t2_norm.s and
                t1_norm.ms == t2_norm.ms;

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
        d=t1.d + t2.d,
        h=t1.h + t2.h,
        min=t1.min + t2.min,
        s=t1.s + t2.s,
        ms=t1.ms + t2.ms));

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
          d=t1.d - t2.d,
          h=t1.h - t2.h,
          min=t1.min - t2.min,
          s=t1.s - t2.s,
          ms=t1.ms - t2.ms));

      end subtract;

      function negate "Unary minus (multiply duration values by -1)"
        extends Icons.Function;

        input Duration t;
        output Duration result "= -t1";

      algorithm
        result := Duration(
          d=-t.d,
          h=-t.h,
          min=-t.min,
          s=-t.s,
          ms=-t.ms);

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
        result := Duration(seconds=Duration.inSeconds(t)*r);

      end multiply1;

      function multiply2 "Multiply a duration with a real (by converting the duration to seconds)"
        extends Icons.Function;

        input Real r;
        input Duration t;
        output Duration result "= inSeconds(t)*r";

      algorithm
        result := Duration(seconds=r*Duration.inSeconds(t));

      end multiply2;
    end '*';

    encapsulated operator '/'  "Divide a duration by a real"
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons;

      extends Icons.FunctionsPackage;

      function divide "Divide a duration by a real. The first ms value can vary by 1 (due to rounding in the fromSeconds constructor)"
        extends Icons.Function;

        input Duration t;
        input Real r;
        output Duration result "= inSeconds(t)/r";

      algorithm
        result := Duration(seconds=Duration.inSeconds(t)/r);

      end divide;

    end '/';

    encapsulated operator function '0' "Zero-element of addition (= Duration())"
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons;
      extends Icons.Function;

      output Duration result "= Duration()";

    algorithm
      result := Duration(d=0, h=0, min=0, s=0, ms=0);

    end '0';

  encapsulated function asVector "Return duration as vector {d, h, min, s, ms}"
    import Modelica.Utilities.Time.Duration;
    import Modelica.Icons;
    extends Icons.Function;

    input Duration t "Value to convert";
    output Integer[5] t_vec "Elapsed time as vector {d, h, min, s, ms}";

  algorithm

    t_vec :={t.d, t.h, t.min, t.s, t.ms};

  end asVector;

  encapsulated function avg "Return average duration for a vector of durations"
    import Modelica.Utilities.Time.Duration;
    import Modelica.Icons;
    extends Icons.Function;

    input Duration t_vec[:];
    output Duration t_avg "Average duration";

    protected
    Integer n = size(t_vec, 1);
    Real seconds = 0;

  algorithm
    for i in 1:n loop
      seconds := seconds + Duration.inSeconds(t_vec[i]);
    end for;

    t_avg := Duration(seconds=seconds/n);

  end avg;

  encapsulated function inSeconds "Convert Duration to seconds"
    import Modelica.Utilities.Time.Duration;
    import Modelica.Icons;
    extends Icons.Function;

    input Duration t;
    output Real seconds "Elapsed seconds";

  algorithm
    seconds :=t.ms/1000 + t.s + 60*(t.min + 60*(t.h + 24*t.d));

  end inSeconds;

  encapsulated function normalize "Reformat duration with usual maximum values for ms, s, min and h and carryover to next bigger unit"
    import Modelica.Utilities.Time.Duration;
    import Modelica.Icons;
    extends Icons.Function;

    input Duration t "Duration";
    output Duration t_norm "Normalized duration";

  algorithm

    t_norm :=Duration(seconds=Duration.inSeconds(t));

  end normalize;

  end Duration;
    annotation (
Documentation(info="<html>
<p>
This package contains functions to work with date and time.
</p>
</html>"));
end Time;
