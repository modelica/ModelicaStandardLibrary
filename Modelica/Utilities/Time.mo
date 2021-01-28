within Modelica.Utilities;
package Time "Functions to work with date and time"
  extends Modelica.Icons.UtilitiesPackage;

  final constant String weekDays[7] = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"} "Array of week days";
  final constant String shortWeekDays[7] = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"} "Array of abbreviated week days";
  final constant String months[12] = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"} "Array of month names";
  final constant String shortMonths[12] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"} "Array of abbreviated month names";

  impure function getTime "Retrieve the current time (in the local time zone)"
    extends Modelica.Icons.Function;
    output DateTime now "Current date and time";
  algorithm
    now := DateTime.now();
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
now = Time.<strong>getTime</strong>();
</pre></blockquote>
<h4>Description</h4>
<p>
Returns the local time at the time instant this function was called.
The returned value is of type <a href=\"modelica://Modelica.Utilities.Time.DateTime\">DateTime</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
now = getTime()   // = Modelica.Utilities.Time.DateTime(2015, 2, 15, 10, 13, 30, 281)
                  // Feb. 15, 2015 at 10:13 after 30.281 s
</pre></blockquote>
<h4>Note</h4>
<p>This function is impure!</p>
</html>"));
  end getTime;

  function dayOfWeek "Return day of week for given date"
    extends Modelica.Icons.Function;
    input DateTime dt "Date and time";
    output Integer dow(min=1, max=7) "Day of week: 1 = Monday, ..., 6 = Saturday, 7 = Sunday";
  algorithm
    dow := Internal.Time.dayOfWeek(dt.year, dt.month, dt.day);
      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
dow = Time.<strong>dayOfWeek</strong>(dt);
</pre></blockquote>
<h4>Description</h4>
<p>
Returns the day of the week for a given date using Tomohiko Sakamoto's algorithm.
The returned Integer number of <code>dow</code> has the following meaning:
</p>

<blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
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
dt = getTime()      // = Modelica.Utilities.Time.DateTime(2019, 6, 12, 10, 13, 30, 281)
                    // Dec. 06, 2019 at 10:13 after 30.281 s
dow = dayOfWeek(dt) // = 5
str = weekDays[dow] // = Friday
                    // Dec. 06, 2019 (Saint Nicholas Day) is a Friday
</pre></blockquote>
</html>"));
  end dayOfWeek;

  function daysInYear "Return the number of days in year"
    extends Modelica.Icons.Function;
    input Integer year "Year";
    output Integer days "Number of days in year";
  algorithm
    days := if isLeapYear(year) then 366 else 365;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
days = Time.<strong>daysInYear</strong>(year);
</pre></blockquote>
<h4>Description</h4>
<p>
Returns the number of days in year.
</p>
</html>"));
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
</pre></blockquote>
</html>"));
  end leapDays;

  operator record DateTime "DateTime record with several constructors and overloaded operators"
    extends Modelica.Icons.OperatorRecord;

    Integer millisecond(min=0, max=999) "Millisecond" annotation(absoluteValue=true);
    Integer second(min=0, max=61) "Second" annotation(absoluteValue=true);
    Integer minute(min=0, max=59) "Minute" annotation(absoluteValue=true);
    Integer hour(min=0, max=23) "Hour" annotation(absoluteValue=true);
    Integer day(min=1, max=31) "Day" annotation(absoluteValue=true);
    Integer month(min=1, max=12) "Month" annotation(absoluteValue=true);
    Integer year "Year" annotation(absoluteValue=true);

    encapsulated operator 'constructor' "Available constructors"
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Icons.Function;

      function fromReadable "Create DateTime from human readable format"
        extends Function;

        input Integer year "Year";
        input Integer month(min=1, max=12) "Month";
        input Integer day(min=1, max=31) "Day";
        input Integer hour(min=0, max=23) "Hour";
        input Integer minute(min=0, max=59) "Minute";
        input Integer second(min=0, max=61) "Second";
        input Integer millisecond(min=0, max=999)=0 "Millisecond";

        output DateTime dt(millisecond=millisecond, second=second, minute=minute, hour=hour, day=day, month=month, year=year) "Date and time";

      algorithm
      annotation(Inline = true);
      end fromReadable;

      function fromSystemTime "Create DateTime from current system time"
        import Modelica.Utilities.Internal.Time.getTime;
        extends Function;

        output DateTime dt "Current date and time";

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
        dt := DateTime(millisecond=millisecond, second=second, minute=minute, hour=hour, day=day, month=month, year=year);

      end fromSystemTime;

      function fromEpoch "Create DateTime from elapsed seconds since reference year"
        import Modelica.Utilities.Internal.Time.localTime;
        extends Function;

        input Real seconds "Elapsed seconds since epoch_year";
        input Integer epoch_year = 1970 "Reference year";
        output DateTime dt "Date and time";

      protected
        Integer millisecond "Millisecond";
        Integer second "Second";
        Integer minute "Minute";
        Integer hour "Hour";
        Integer day "Day";
        Integer month "Month";
        Integer year "Year";

      algorithm

        (millisecond, second, minute, hour, day, month, year) := localTime(seconds, epoch_year);
        dt := DateTime(millisecond=millisecond, second=second, minute=minute, hour=hour, day=day, month=month, year=year);

      end fromEpoch;

      function fromString "Create DateTime from formatted string"
        import Modelica.Utilities.Internal.Time.stringToTime;
        extends Function;

        input String str "Formatted date and time string";
        input String format = "%Y-%m-%d %H:%M:%S" "Format string passed to strptime";
        output DateTime dt "Date and time";

      protected
        Integer millisecond "Millisecond";
        Integer second "Second";
        Integer minute "Minute";
        Integer hour "Hour";
        Integer day "Day";
        Integer month "Month";
        Integer year "Year";

      algorithm

        (millisecond, second, minute, hour, day, month, year) := stringToTime(str, format);
        dt := DateTime(millisecond=millisecond, second=second, minute=minute, hour=hour, day=day, month=month, year=year);

      end fromString;
      annotation (Documentation(info="<html>
<p>Here the constructor operator(s) is/are defined.</p>
</html>"), Icon(
          graphics={
            Rectangle(
              lineColor={200,200,200},
              fillColor={248,248,248},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{-100,-100},{100,100}},
              radius=25),
            Rectangle(
              lineColor={128,128,128},
              extent={{-100,-100},{100,100}},
              radius=25),
            Text(
              textColor={128,128,128},
              extent={{-90,-90},{90,90}},
              textString="f")}));
    end 'constructor';

    encapsulated operator 'String' "Convert DateTime to string"
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Icons.Function;

      function formatted "Use strftime conversion to format a DateTime record as string"
        import Modelica.Utilities.Internal.Time.timeToString;
        extends Function;

        input DateTime dt "Date and time";
        input String format = "%Y-%m-%d %H:%M:%S" "Format string passed to strftime";
        input Integer maxSize = 128 "Maximal length of formatted string";
        output String str "Formatted date and time string";

      algorithm
        str := timeToString(dt.millisecond, dt.second, dt.minute, dt.hour, dt.day, dt.month, dt.year, format, maxSize);
        annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote>
<pre>
String(dt)
String(dt, format)
String(dt, format, maxSize)
</pre>
</blockquote>

<h4>Description</h4>
<p>
The input value <code>dt</code> of type DateTime is converted to a string.
</p>
<p>
The content of the output string can be controlled
via the <code>format</code> string by setting one or more of the conversion specifiers listed below.
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
        <td>01, 02,&nbsp;&hellip;&nbsp;99</td>
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
        <td>01, 02,&nbsp;&hellip;&nbsp;12</td>
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
        <td>01, 02,&nbsp;&hellip;&nbsp;31</td>
    </tr>
    <tr>
        <td>%H</td>
        <td>hour, zero padded to length 2</td>
        <td>00, 01,&nbsp;&hellip;&nbsp;24</td>
    </tr>
    <tr>
        <td>%M</td>
        <td>minute, zero padded to length 2</td>
        <td>00, 01,&nbsp;&hellip;&nbsp;60</td>
    </tr>
    <tr>
        <td>%S</td>
        <td>second, zero padded to length 2</td>
        <td>00, 01,&nbsp;&hellip;&nbsp;60</td>
    </tr>
    <tr>
        <td>%%</td>
        <td>single percent character</td>
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
        <td>000, 001,&nbsp;&hellip;&nbsp;999</td>
    </tr>
</table>

<h4>Example</h4>
<blockquote>
<pre>
import Modelica.Utilities.Time.DateTime;
dt = DateTime(2020, 12, 24, 00, 01, 02, 003);

String(dt)                                       // = \"2020-12-24 00:01:02\"
String(dt, \"%a, %b. %d %Y, %H:%M:%S\")            // = \"Thu, Dec. 24 2020, 00:01:02\"
String(dt, format=\"%A, %d. %B %y, %H:%M:%S.%L\")  // = \"Thursday, 24. December 20, 00:01:02.003\"
</pre>
</blockquote>
</html>"));
      end formatted;
      annotation (Documentation(info="<html>
<p>Here the String operator(s) is/are defined.</p>
</html>"), Icon(
          graphics={
            Rectangle(
              lineColor={200,200,200},
              fillColor={248,248,248},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{-100,-100},{100,100}},
              radius=25),
            Rectangle(
              lineColor={128,128,128},
              extent={{-100,-100},{100,100}},
              radius=25),
            Text(
              textColor={128,128,128},
              extent={{-90,-90},{90,90}},
              textString="f")}));
    end 'String';

    encapsulated operator function '==' "Check equality of two DateTime objects"
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Icons.Function;
      extends Function;

      input DateTime dt1;
      input DateTime dt2;
      output Boolean result "= dt1 == dt2";

    algorithm
      result := dt1.year == dt2.year and
                dt1.month == dt2.month and
                dt1.day == dt2.day and
                dt1.hour == dt2.hour and
                dt1.minute == dt2.minute and
                dt1.second == dt2.second and
                dt1.millisecond == dt2.millisecond;

    end '==';

    encapsulated operator function '<>' "Check inequality of two DateTime objects"
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Icons.Function;
      extends Function;

      input DateTime dt1;
      input DateTime dt2;
      output Boolean result "= dt1 <> dt2";

    algorithm
      result := not dt1 == dt2;
    end '<>';

    encapsulated operator function '>' "Check if DateTime dt1 is later as dt2"
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Icons.Function;
      extends Function;

      input DateTime dt1;
      input DateTime dt2;
      output Boolean result "= dt1 > dt2";

    algorithm
      if dt1.year > dt2.year then
        result := true;
      else
        if dt1.year == dt2.year and dt1.month > dt2.month then
          result := true;
        else
          if dt1.month == dt2.month and dt1.day > dt2.day then
            result := true;
          else
            if dt1.day == dt2.day and dt1.hour > dt2.hour then
              result := true;
            else
              if dt1.hour == dt2.hour and dt1.minute > dt2.minute then
                result := true;
              else
                if dt1.minute == dt2.minute and dt1.second > dt2.second then
                  result := true;
                else
                  if dt1.second == dt2.second and dt1.millisecond > dt2.millisecond then
                    result := true;
                  else
                    result := false;
                  end if;
                end if;
              end if;
            end if;
          end if;
        end if;
      end if;
    end '>';

    encapsulated operator function '>=' "Check if DateTime dt1 is equal to dt2 or later"
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Icons.Function;
      extends Function;

      input DateTime dt1;
      input DateTime dt2;
      output Boolean result "= dt1 >= dt2";

    algorithm
      result := dt1 == dt2 or dt1 > dt2;

    end '>=';

    encapsulated operator function '<' "Check if DateTime dt1 is earlier as dt2"
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Icons.Function;
      extends Function;

      input DateTime dt1;
      input DateTime dt2;
      output Boolean result "= dt1 < dt2";

    algorithm
      result := not dt1 == dt2 and dt2 > dt1;

    end '<';

    encapsulated operator function '<=' "Check if DateTime dt1 is equal to dt2 or earlier"
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Icons.Function;
      extends Function;

      input DateTime dt1;
      input DateTime dt2;
      output Boolean result "= dt1 <= dt2";

    algorithm
      result := dt1 == dt2 or dt1 < dt2;

    end '<=';

    encapsulated operator '+' "Add to DateTime"
      function add_Duration1 "Add Duration d to DateTime dt"

        import Modelica.Utilities.Time.{DateTime, Duration};
        import Modelica.Icons.Function;
        extends Function;

        input DateTime dt;
        input Duration d;
        output DateTime result "= dt + d";

      algorithm
        result := DateTime.'constructor'.fromEpoch(DateTime.epoch(dt) + Duration.inSeconds(d));

      end add_Duration1;

      function add_Duration2 "Add Duration d to DateTime dt - swapped input"

        import Modelica.Utilities.Time.{DateTime, Duration};
        import Modelica.Icons.Function;
        extends Function;

        input Duration d;
        input DateTime dt;
        output DateTime result "= d + dt";

      algorithm
        result := DateTime.'+'.add_Duration1(dt, d);

      end add_Duration2;

      annotation (Icon(graphics={
          Rectangle(
            lineColor={200,200,200},
            fillColor={248,248,248},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100,-102},{100,98}},
            radius=25),
          Rectangle(
            lineColor={128,128,128},
            extent={{-100,-102},{100,98}},
            radius=25),
          Line(
            points={{-50,0},{50,0}}),
          Line(
            points={{-50,0},{50,0}},
              origin={0,0},
              rotation=90)}));
    end '+';

    encapsulated operator '-' "Binary minus"
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Icons.Function;

      function subtract_DateTime "Return time delta between dt2 and dt1 as Duration"
        extends Function;

        import Modelica.Utilities.Time.Duration;

        input DateTime dt1;
        input DateTime dt2;
        output Duration result "= dt1 - dt2";

      algorithm
        result := Duration.'constructor'.fromDateTimes(dt2, dt1);

      end subtract_DateTime;

      function subtract_Duration "Subtract Duration d from DateTime dt"
        extends Function;

        import Modelica.Utilities.Time.Duration;

        input DateTime dt;
        input Duration d;
        output DateTime result "= dt - d";

      algorithm
        result := DateTime.'constructor'.fromEpoch(DateTime.epoch(dt) - Duration.inSeconds(d));

      end subtract_Duration;

    annotation (Documentation(info="<html>
<p>Here the binary minus operator is defined.</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics={
          Rectangle(
            lineColor={200,200,200},
            fillColor={248,248,248},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100,-100},{100,100}},
            radius=25),
          Rectangle(
            lineColor={128,128,128},
            extent={{-100,-100},{100,100}},
            radius=25),
          Line(
            points={{-50,0},{50,0}})}));
    end '-';

    encapsulated function epoch "Convert DateTime to elapsed seconds since custom epoch year"
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Utilities.Internal.Time.diffTime;
      import Modelica.Icons.Function;
      extends Function;

      input DateTime dt "Date and time";
      input Integer epoch_year = 1970 "Reference year";
      output Real seconds "Elapsed seconds since epoch_year in the current time zone";

    algorithm
      seconds := diffTime(dt.millisecond, dt.second, dt.minute, dt.hour, dt.day, dt.month, dt.year, epoch_year);
      annotation (Inline=true);
    end epoch;

    encapsulated function now "Get current system date and time as DateTime"
      import Modelica.Utilities.Time.DateTime;
      import Modelica.Icons.Function;
      extends Function;

      output DateTime now "Current date and time";
    algorithm
      now := DateTime.'constructor'.fromSystemTime();
      annotation (Inline=true);
    end now;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote>
<pre>
Time.<strong>DateTime</strong>();
Time.<strong>DateTime</strong>(year, month, day, hour, minute, second, millisecond);
Time.<strong>DateTime</strong>(seconds);
Time.<strong>DateTime</strong>(seconds, epoch_year);
</pre>
</blockquote>

<h4>Description</h4>
<p>
The operator record DateTime stores the required information to address a specific point in time via date and time values.
</p>
<p>
There are multiple constructors provided to create a DateTime element. See the examples below for details.
</p>
<p>
DateTimes can be compared (==, &lt;&gt;, &gt;, &lt;, &ge;, &le;), giving a boolean result and subtracted (-), giving a Duration.
</p>
<p>
DateTimes can be converted to an epoch representation with the function DateTime.epoch(dt, epoch_year).
</p>

<h4>Example</h4>

The examples below demonstrate the different methods to create a DateTime record.

<blockquote>
<pre>
import Modelica.Utilities.Time.DateTime;

// Create DateTime records from the current system time
DateTime();                              // create DateTime record using default constructor, which is fromSystemTime
DateTime.'constructor'.fromSystemTime(); // explicit call of constructor
DateTime.now();                          // convenience function for explicit call of constructor fromSystemTime

// Create DateTime records manually by setting each field
DateTime.'constructor'.fromReadable(2020, 01, 31, 14, 40, 50, 500); // explicit call of constructor
DateTime(2020, 01, 31, 14, 40, 50, 500);                            // automatic selection of constructor fromReadable

// Create DateTime records manually using the elapsed seconds since the given epoch year
DateTime(seconds=1);                          // automatic selection of constructor fromEpoch
DateTime.'constructor'.fromEpoch(1);          // explicit call of constructor. 1s passed since default epoch year 1970
DateTime.'constructor'.fromEpoch(1000, 2020); // explicit call of constructor. 1000s passed since custom epoch year 2020
</pre>
</blockquote>
</html>"));
  end DateTime;

  operator record Duration "Duration record with several constructors and overloaded operators"
    extends Modelica.Icons.OperatorRecord;

    Integer days "Days";
    Integer hours "Hours";
    Integer minutes "Minutes";
    Integer seconds "Seconds";
    Integer milliseconds "Milliseconds";

    encapsulated operator 'constructor' "Available constructors"
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons.Function;

      function fromInput "Create Duration field by field from user input"
        extends Function;

        input Integer days "Days";
        input Integer hours "Hours";
        input Integer minutes "Minutes";
        input Integer seconds "Seconds";
        input Integer milliseconds "Milliseconds";
        output Duration d(days=days, hours=hours, minutes=minutes, seconds=seconds, milliseconds=milliseconds) "Duration";

      algorithm
      annotation (Inline = true);
      end fromInput;

      function fromDateTimes "Create Duration from two DateTime records"
        import Modelica.Utilities.Time.DateTime;
        import Modelica.Math.nearestInteger;
        extends Function;

        input DateTime dt1 "Start time";
        input DateTime dt2 "End time";
        output Duration d "= dt2 - dt1";

      protected
        Real diff;
        Real e1, e2;
        Integer days "Elapsed days";
        Integer hours "Elapsed hours";
        Integer minutes "Elapsed minutes";
        Integer seconds "Elapsed seconds";
        Integer milliseconds "Elapsed milliseconds";

      algorithm
        e1 := DateTime.epoch(dt1, epoch_year=dt1.year);
        e2 := DateTime.epoch(dt2, epoch_year=dt1.year);

        diff := abs(e2 - e1);

        days := integer(diff/(24*3600));
        hours := integer(diff/3600 - days*24);
        minutes := integer((diff - (days*24 + hours)*3600)/60);
        seconds := integer(diff - (days*24 + hours)*3600 - minutes*60);
        milliseconds := nearestInteger(rem(diff,1)*1000);

        d := Duration(days=days, hours=hours, minutes=minutes, seconds=seconds, milliseconds=milliseconds);
        if e2 < e1 then
          d := -d;
        end if;

      end fromDateTimes;

      function fromSeconds "Create duration record from total amount of seconds, rounding to the third decimal"
        extends Function;
        import Modelica.Math.nearestInteger;

        input Real totalSeconds=0 "Duration in seconds. Decimal place is converted to milliseconds";
        output Duration d "Duration with input converted to seconds and milliseconds";

      protected
        Integer days "Days";
        Integer hours "Hours";
        Integer minutes "Minutes";
        Integer seconds "Seconds";
        Integer milliseconds "Milliseconds";

        Integer carryover;

      algorithm

        milliseconds := nearestInteger(rem(totalSeconds, 1) * 1000);

        seconds := integer(div(totalSeconds, 1));
        carryover := div(seconds, 60);
        seconds := rem(seconds, 60);

        minutes := carryover;
        carryover := div(minutes, 60);
        minutes := rem(minutes, 60);

        hours := carryover;
        carryover := div(hours, 24);
        hours := rem(hours, 24);

        days := carryover;

        d := Duration(days=days, hours=hours, minutes=minutes, seconds=seconds, milliseconds=milliseconds);

      end fromSeconds;
      annotation (Documentation(info="<html>
<p>Here the constructor operator(s) is/are defined.</p>
</html>"), Icon(
          graphics={
            Rectangle(
              lineColor={200,200,200},
              fillColor={248,248,248},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{-100,-100},{100,100}},
              radius=25),
            Rectangle(
              lineColor={128,128,128},
              extent={{-100,-100},{100,100}},
              radius=25),
            Text(
              textColor={128,128,128},
              extent={{-90,-90},{90,90}},
              textString="f")}));
    end 'constructor';

    encapsulated operator 'String' "Convert Duration to string"
      import Modelica.Utilities.Time.Duration;
      import Modelica.Utilities.Strings.replace;
      import Modelica.Icons.Function;

      function formatted "Convert duration to string, using C inspired conversion specifier characters"
        import Modelica.Utilities.Strings.contains;
        extends Function;

        input Duration d "Duration";
        input String format = "%daysd %hoursh %minutesmin %secondss %millisecondsms";
        output String str "Formatted duration string";

      protected
        Duration d2;

        encapsulated function string0 "Create string with minimum length, filled with 0"
          import Modelica.Utilities.Strings.replace;
            input Integer i;
            input Integer l;
            output String s0;
        algorithm
            s0 := replace(String(i, minimumLength=l, leftJustified=false), " ", "0");
        end string0;

      algorithm

        d2 := d;

        if not contains(format, "%days") and not contains(format, "%d") then
          d2.hours := d2.hours + d2.days*24;
        end if;

        if not contains(format, "%hours") and not contains(format, "%H") then
          d2.minutes := d2.minutes + d2.hours*60;
        end if;

        if not contains(format, "%minutes") and not contains(format, "%M") then
          d2.seconds := d2.seconds + d2.minutes*60;
        end if;

        if not contains(format, "%seconds") and not contains(format, "%S") then
          d2.milliseconds := d2.milliseconds + d2.seconds*1000;
        end if;

        str := replace(format, "%%",            "%|");
        str := replace(str,    "%days",         String( d2.days));
        str := replace(str,    "%d",            string0(d2.days, l=2));
        str := replace(str,    "%hours",        String( d2.hours));
        str := replace(str,    "%H",            string0(d2.hours, l=2));
        str := replace(str,    "%minutes",      String( d2.minutes));
        str := replace(str,    "%M",            string0(d2.minutes, l=2));
        str := replace(str,    "%seconds",      String( d2.seconds));
        str := replace(str,    "%S",            string0(d2.seconds, l=2));
        str := replace(str,    "%milliseconds", String( d2.milliseconds));
        str := replace(str,    "%L",            string0(d2.milliseconds, l=3));
        str := replace(str,    "%|",            "%");

        annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote>
<pre>
String(d)
String(d, format)
</pre>
</blockquote>

<h4>Description</h4>
<p>
The input value <code>d</code> of type Duration is converted to a string.
</p>
<p>
The content of the output string can be controlled
via the <code>format</code> string by setting one or more of the conversion specifiers listed below.
</p>
<p>
If higher time values are not included, they are added to the next lower time value.
If e.g., days are not part of the format string, but hours, the number of days will be converted
to hours and added to the hours value.
</p>
<p>
If lower time values are not included, they are neglected.
If e.g., only days and hours are part of the format string, minutes, seconds and milliseconds will be ignored.
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
        <td>single percent character</td>
        <td>%</td>
    </tr>
</table>

<h4>Example</h4>
<blockquote>
<pre>
import Modelica.Utilities.Time.Duration;
d = Duration(days=1, hours=2, minutes=3, seconds=4, milliseconds=5);

String(d)                        // = \"1d 2h 3min 4s 5ms\"
String(d, \"%hoursh %secondss\")   // = \"26h 184s\" (days are included in hours, minutes in seconds, ms stripped off)
String(d, format=\"%Hh %S.%L''\")  // = \"26h 184.005''\" (days are included in hours, minutes in seconds)
String(d, format=\"%days'\")          // = \"1\" (only full days are shown, rest is stripped off)
</pre>
</blockquote>
</html>"));
      end formatted;
      annotation (Documentation(info="<html>
<p>Here the String operator(s) is/are defined.</p>
</html>"), Icon(
          graphics={
            Rectangle(
              lineColor={200,200,200},
              fillColor={248,248,248},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{-100,-100},{100,100}},
              radius=25),
            Rectangle(
              lineColor={128,128,128},
              extent={{-100,-100},{100,100}},
              radius=25),
            Text(
              textColor={128,128,128},
              extent={{-90,-90},{90,90}},
              textString="f")}));
    end 'String';

    encapsulated operator function '==' "Check equality of two Duration objects by normalizing them"
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons.Function;
      extends Function;

      input Duration d1;
      input Duration d2;
      output Boolean result "= d1 == d2";

    protected
      Duration d1_norm = Duration.normalize(d1);
      Duration d2_norm = Duration.normalize(d2);

    algorithm
      result := d1_norm.days == d2_norm.days and
                d1_norm.hours == d2_norm.hours and
                d1_norm.minutes == d2_norm.minutes and
                d1_norm.seconds == d2_norm.seconds and
                d1_norm.milliseconds == d2_norm.milliseconds;

    end '==';

    encapsulated operator function '<>' "Check inequality of two Duration objects by normalizing them"
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons.Function;
      extends Function;

      input Duration d1;
      input Duration d2;
      output Boolean result "= d1 <> d2";

    algorithm
      result := not d1 == d2;
    end '<>';

    encapsulated operator function '>' "Check if Duration d1 is greater than d2"
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons.Function;
      extends Function;

      input Duration d1;
      input Duration d2;
      output Boolean result "= d1 > d2";

    algorithm
      result := Duration.inSeconds(d1) > Duration.inSeconds(d2);
    end '>';

    encapsulated operator function '>=' "Check if Duration d1 is greater than d2 or equal"
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons.Function;
      extends Function;

      input Duration d1;
      input Duration d2;
      output Boolean result "= d1 >= d2";

    algorithm
      result := d1 == d2 or d1 > d2;

    end '>=';

    encapsulated operator function '<' "Check if Duration d1 is less than d2"
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons.Function;
      extends Function;

      input Duration d1;
      input Duration d2;
      output Boolean result "= d1 < d2";

    algorithm
      result := not d1 == d2 and d2 > d1;

    end '<';

    encapsulated operator function '<=' "Check if Duration d1 is less than d2 or equal"
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons.Function;
      extends Function;

      input Duration d1;
      input Duration d2;
      output Boolean result "= d1 <= d2";

    algorithm
      result := d1 == d2 or d1 < d2;

    end '<=';

    encapsulated operator function '+' "Add Durations d1 and d2 and normalize the sum"
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons.Function;
      extends Function;

      input Duration d1;
      input Duration d2;
      output Duration result "= d1 + d2";

    algorithm
      result := Duration.normalize(Duration(
        days=d1.days + d2.days,
        hours=d1.hours + d2.hours,
        minutes=d1.minutes + d2.minutes,
        seconds=d1.seconds + d2.seconds,
        milliseconds=d1.milliseconds + d2.milliseconds));

    end '+';

    encapsulated operator '-' "Unary and binary minus"
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons.Function;

      function negate "Unary minus (multiply all duration values by -1)"
        extends Function;

        input Duration d;
        output Duration result "= -d";

      algorithm
        result := Duration(
          days=-d.days,
          hours=-d.hours,
          minutes=-d.minutes,
          seconds=-d.seconds,
          milliseconds=-d.milliseconds);

      end negate;

      function subtract "Subtract two durations element wise and normalize the difference"
        extends Function;

        input Duration d1;
        input Duration d2;
        output Duration result "= d1 - d2";

      algorithm
        result := Duration.normalize(Duration(
          days=d1.days - d2.days,
          hours=d1.hours - d2.hours,
          minutes=d1.minutes - d2.minutes,
          seconds=d1.seconds - d2.seconds,
          milliseconds=d1.milliseconds - d2.milliseconds));

      end subtract;
    annotation (Documentation(info="<html>
<p>Here the unary and binary minus operator(s) is/are defined.</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics={
          Rectangle(
            lineColor={200,200,200},
            fillColor={248,248,248},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100,-100},{100,100}},
            radius=25),
          Rectangle(
            lineColor={128,128,128},
            extent={{-100,-100},{100,100}},
            radius=25),
          Line(
            points={{-50,0},{50,0}})}));
    end '-';

    encapsulated operator '*' "Multiplication"
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons.Function;

      function multiply1 "Multiply a duration with a real (by converting the duration to seconds)"
        extends Function;

        input Duration d;
        input Real r;
        output Duration result "= inSeconds(d)*r";

      algorithm
        result := Duration(totalSeconds=Duration.inSeconds(d)*r);

      end multiply1;

      function multiply2 "Multiply a duration with a real (by converting the duration to seconds)"
        extends Function;

        input Real r;
        input Duration d;
        output Duration result "= inSeconds(d)*r";

      algorithm
        result := Duration(totalSeconds=r*Duration.inSeconds(d));

      end multiply2;
      annotation (
        Documentation(info="<html>
<p>Here the multiplication operator(s) is/are defined.</p>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}),
            graphics={
            Rectangle(
              lineColor={200,200,200},
              fillColor={248,248,248},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{-100,-100},{100,100}},
              radius=25),
            Rectangle(
              lineColor={128,128,128},
              extent={{-100,-100},{100,100}},
              radius=25),
            Line(points={{-40,35},{40,-35}}),
            Line(points={{-40,-35},{40,35}}),
            Line(points={{-55,0},{55,0}}),
            Line(points={{0,55},{0,-55}})}));
    end '*';

    encapsulated operator '/' "Division"
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons.Function;

      function divide
        "Divide a duration by a real. The first milliseconds value can vary by 1 (due to rounding in the fromSeconds constructor)"
        extends Function;

        input Duration d;
        input Real r;
        output Duration result "= inSeconds(d)/r";

      algorithm
        result := Duration(totalSeconds=Duration.inSeconds(d)/r);

      end divide;
      annotation (
        Documentation(info="<html>
<p>Here the multiplication operator(s) is/are defined.</p>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}),
            graphics={
            Rectangle(
              lineColor={200,200,200},
              fillColor={248,248,248},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{-100,-100},{100,100}},
              radius=25),
            Rectangle(
              lineColor={128,128,128},
              extent={{-100,-100},{100,100}},
              radius=25),
            Line(points={{-20,-55},{20,55}})}));
    end '/';

    encapsulated operator function '0' "Zero-element of addition (= Duration())"
      import Modelica.Utilities.Time.Duration;
      import Modelica.Icons.Function;
      extends Function;

      output Duration result "= Duration()";

    algorithm
      result := Duration(days=0, hours=0, minutes=0, seconds=0, milliseconds=0);

    end '0';

  encapsulated function asVector "Return duration as vector {days, hours, minutes, seconds, milliseconds}"
    import Modelica.Utilities.Time.Duration;
    import Modelica.Icons.Function;
    extends Function;

    input Duration d "Value to convert";
    output Integer[5] d_vec "Duration as vector {days, hours, minutes, seconds, milliseconds}";

  algorithm

    d_vec :={d.days, d.hours, d.minutes, d.seconds, d.milliseconds};

  end asVector;

  encapsulated function avg "Return Duration with averaged values for a vector of durations"
    import Modelica.Utilities.Time.Duration;
    import Modelica.Icons.Function;
    extends Function;

    input Duration d_vec[:] "Vector of duration";
    output Duration d_avg "Average duration";

    protected
    Integer n = size(d_vec, 1);
    Real totalSeconds = 0;

  algorithm
    for i in 1:n loop
      totalSeconds := totalSeconds + Duration.inSeconds(d_vec[i]);
    end for;

    d_avg := Duration(totalSeconds=totalSeconds/n);

  end avg;

  encapsulated function inSeconds "Convert Duration to total amount of seconds"
    import Modelica.Utilities.Time.Duration;
    import Modelica.Icons.Function;
    extends Function;

    input Duration d;
    output Real totalSeconds "Elapsed seconds";

  algorithm
    totalSeconds := d.milliseconds/1000 + d.seconds + 60*(d.minutes + 60*(d.hours + 24*d.days));

  end inSeconds;

  encapsulated function normalize
    "Recompute duration with usual maximum values for milliseconds, seconds, minutes and hours"
    import Modelica.Utilities.Time.Duration;
    import Modelica.Icons.Function;
    extends Function;

    input Duration d "Duration";
    output Duration d_norm "Normalized duration";

  algorithm

    d_norm := Duration(totalSeconds=Duration.inSeconds(d));

  end normalize;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote>
<pre>
Time.<strong>Duration</strong>();
Time.<strong>Duration</strong>(days=0, hours=0, minutes=0, seconds=0, milliseconds=0);
Time.<strong>Duration</strong>(dt1, dt2);
Time.<strong>Duration</strong>(totalSeconds);
</pre>
</blockquote>

<h4>Description</h4>
<p>
The operator record Duration is used for elapsed time.
This can be the time between given by DateTime records
(i.e., by subtracting them) or a manually specified duration.
</p>
<p>
There are multiple constructors provided to create a Duration element.
See the examples below for details.
</p>

<p>Here is a brief summary, what the Duration operator record is capable of:</p>
<ul>
    <li>
        Durations can be compared (==, &lt;&gt;, &gt;, &lt;, &ge;, &le;), giving a boolean result.
    </li>
    <li>
        Durations can be added, subtracted and negated (+, -), giving a Duration.
    </li>
    <li>
        Durations can be multiplied and divided by scalars (*, /), giving a Duration.
    </li>
    <li>
        The elements of a Duration can be returned as vector with Duration.asVector().
    </li>
    <li>
        For a vector of Durations, the average can be computed with Duration.avg().
    </li>
    <li>
        Durations can be expressed in seconds only, using Duration.inSeconds().
    </li>
    <li>
        Durations can be normalized with Duration.normalize(),
        which ensures a representation with hours &lt; 24, min &lt; 60, etc.).
    </li>
</ul>

<h4>Example</h4>

The examples below demonstrate the different methods to create a Duration record.

<blockquote>
<pre>
import Modelica.Utilities.Time.Duration;

// Create Duration records from direct input
Duration.'constructor'.fromInput(10, 0, 0, 0, 0);                  // explicit call of constructor
Duration(days=10, hours=0, minutes=0, seconds=00, milliseconds=0); // automatic selection of constructor fromInput
Duration(10, 0, 0, 0, 0);                                          // automatic selection of constructor fromInput

// Create Duration records from two DateTimes
import Modelica.Utilities.Time.DateTime;
dt1 = DateTime.now();
dt2 = DateTime.now();
Duration.'constructor'.fromDateTimes(dt1, dt2);  // explicit call of constructor
Duration(dt1, dt2);                              // automatic selection of constructor via data type
Duration(dt1=dt1, dt2=dt2);                      // automatic selection of constructor via names

// Create Duration records manually using the elapsed seconds since the given epoch year
Duration();                                      // create Duration record using default constructor, which is fromSeconds
Duration.'constructor'.fromSeconds(1);           // explicit call of constructor
Duration(totalSeconds=1.5);                      // automatic selection of constructor via name
</pre>
</blockquote>
</html>"));
  end Duration;
    annotation (
Documentation(info="<html>
<p>
This package contains functions and records to work with date and time.
</p>
</html>"));
end Time;
