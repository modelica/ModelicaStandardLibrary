within ModelicaTest;
package Utilities "Test functions for Modelica.Utilities"
extends Modelica.Icons.ExamplesPackage;
  function Strings "Test functions of Modelica.Utilities.Strings"
    extends Modelica.Icons.Function;
    import Modelica.Utilities.Streams;
    import Modelica.Utilities.Strings;
    import Modelica.Utilities.Types;
    input String logFile="ModelicaTestLog.txt"
      "Filename where the log is stored";
    output Boolean ok;
  protected
    Integer i;
    Integer j;
    Real r;
    String s;
    Boolean b;
    String svec[2];
    Types.TokenValue token;
    Integer hash1;
    Integer hash2;
    Modelica.Utilities.Types.Compare c;
  algorithm
    Streams.print("... Test of Modelica.Utilities.Strings");
    Streams.print("... Test of Modelica.Utilities.Strings", logFile);

    i := Strings.length("hello, world");
    assert(i == 12, "Strings.length failed");
    // assert(Strings.length("hello, world") == 12, "Strings.length failed");
    // **** Dymola says "Failed to expand" if you uncomment the line above.

    s := Strings.substring("12345678", 3, 3);
    assert(s == "3", "Strings.Advanced.substring 1 failed");

    s := Strings.substring(
        "12345678",
        3,
        5);
    assert(s == "345", "Strings.Advanced.substring 2 failed");

    s := Strings.repeat(3, "12");
    assert(s == "121212", "Strings.Advanced.repeat failed");

    c := Strings.compare(
        "abc",
        "ABC",
        caseSensitive=false);
    assert(c == Modelica.Utilities.Types.Compare.Equal,
      "Strings.Advanced.compare 1 failed");

    c := Strings.compare("abc", "zef");
    assert(c == Modelica.Utilities.Types.Compare.Less,
      "Strings.Advanced.compare 2 failed");

    b := Strings.isEqual("abc", "ABC");
    assert(not b, "Strings.Advanced.isEqual 1 failed");

    b := Strings.isEqual(
        "abc",
        "ABC",
        caseSensitive=false);
    assert(b, "Strings.Advanced.isEqual 2 failed");

    b := Strings.isEmpty("");
    assert(b, "Strings.Advanced.isEmpty 1 failed");

    b := Strings.isEmpty("   ");
    assert(b, "Strings.Advanced.isEmpty 2 failed");

    b := Strings.isEmpty("a");
    assert(not b, "Strings.Advanced.isEmpty 3 failed");

    b := Strings.isEmpty("  abc  ");
    assert(not b, "Strings.Advanced.isEmpty 4 failed");

    i := Strings.count("line1 line2 line1 line2", "line2");
    assert(i == 2, "Strings.Advanced.count failed");

    i := Strings.find("x line x line x", "line");
    assert(i == 3, "Strings.Advanced.find failed");

    i := Strings.findLast("x line x line x", "line");
    assert(i == 10, "Strings.Advanced.findLast failed");

    s := Strings.replace(
        "x line x line x",
        "line",
        "LINE");
    assert(s == "x LINE x LINE x", "Strings.Advanced.replace failed");

    svec := Strings.sort({"zxy","abc"});
    assert(svec[1] == "abc" and svec[2] == "zxy",
      "Strings.Advanced.sort failed");

    // Strings.Advanced
    i := Strings.Advanced.skipWhiteSpace("  abc ", 1);
    assert(i == 3, "Strings.Advanced.skipWhiteSpace failed");

    i := Strings.Advanced.skipLineComments(" // xx", 1);
    assert(i == 7, "Strings.Advanced.skipLineComments 1 failed");

    i := Strings.Advanced.skipLineComments(" // xx", 1);
    assert(i == 7, "Strings.Advanced.skipLineComments 1 failed");

    // i := Strings.Advanced.skipLineComments(" // xx\n //yy \n  abc");
    // assert(i == 17, "Strings.Advanced.skipLineComments 2 failed");

    (i,r) := Strings.Advanced.scanReal("  -123.47e-2", 1);
    assert(i == 13 and r == -123.47e-2, "Strings.Advanced.scanReal 1 failed");

    (i,r) := Strings.Advanced.scanReal(
        "  123 ",
        1,
        unsigned=true);
    assert(i == 6 and r == 123, "Strings.Advanced.scanReal 2 failed");

    (i,j) := Strings.Advanced.scanInteger("  -123", 1);
    assert(i == 7 and j == -123, "Strings.Advanced.scanInteger 1 failed");

    (i,j) := Strings.Advanced.scanInteger(
        "  123",
        1,
        unsigned=true);
    assert(i == 6 and j == 123, "Strings.Advanced.scanInteger 2 failed");

    (i,s) := Strings.Advanced.scanString(" \"string text\" x=3", 1);
    assert(i == 15 and s == "string text", "Strings.Advanced.scanString failed");

    (i,s) := Strings.Advanced.scanIdentifier(" x_12=2;", 1);
    assert(i == 6 and s == "x_12", "Strings.Advanced.scanIdentifier failed");

    // Strings.scanToken
    (token,i) := Strings.scanToken("  -123.47e-2", 1);
    assert(i == 13 and token.tokenType == Types.TokenType.RealToken and token.real
       == -123.47e-2, "Strings.scanToken 1 failed");

    (token,i) := Strings.scanToken("  -123", 1);
    assert(i == 7 and token.tokenType == Types.TokenType.IntegerToken and token.integer
       == -123, "Strings.scanToken 2 failed");

    (token,i) := Strings.scanToken(
        "  123",
        1,
        unsigned=true);
    assert(i == 6 and token.tokenType == Types.TokenType.IntegerToken and token.integer
       == 123, "Strings.scanToken 3 failed");

    (token,i) := Strings.scanToken("  true x", 1);
    assert(i == 7 and token.tokenType == Types.TokenType.BooleanToken and token.boolean,
      "Strings.scanToken 4 failed");

    (token,i) := Strings.scanToken("  false x", 1);
    assert(i == 8 and token.tokenType == Types.TokenType.BooleanToken and not
      token.boolean, "Strings.scanToken 5 failed");

    (token,i) := Strings.scanToken(" \"string text\" x=3", 1);
    assert(i == 15 and token.tokenType == Types.TokenType.StringToken and token.string
       == "string text", "Strings.scanToken 6 failed");

    (token,i) := Strings.scanToken(" x_12=2;", 1);
    assert(i == 6 and token.tokenType == Types.TokenType.IdentifierToken and
      token.string == "x_12", "Strings.scanToken 7 failed");

    (token,i) := Strings.scanToken("  abc = 3;   ", 11);
    assert(i == 14 and token.tokenType == Types.TokenType.NoToken,
      "Strings.scanToken 8 failed");

    // Strings.scanXXX
    (r,i) := Strings.scanReal(
        "  123 ",
        1,
        unsigned=true);
    assert(i == 6 and r == 123, "Strings.scanRequiredReal 2 failed");

    (j,i) := Strings.scanInteger("  -123", 1);
    assert(i == 7 and j == -123, "Strings.scanRequiredInteger 1 failed");

    (j,i) := Strings.scanInteger(
        "  123",
        1,
        unsigned=true);
    assert(i == 6 and j == 123, "Strings.scanRequiredInteger 2 failed");

    (b,i) := Strings.scanBoolean("  true x", 1);
    assert(i == 7 and b, "Strings.scanRequiredBoolean 1 failed");

    (b,i) := Strings.scanBoolean("  false x", 1);
    assert(i == 8 and not b, "Strings.scanRequiredBoolean 2 failed");

    (s,i) := Strings.scanString(" \"string text\" x=3", 1);
    assert(i == 15 and s == "string text", "Strings.scanRequiredString failed");

    (s,i) := Strings.scanIdentifier(" x_12=2;", 1);
    assert(i == 6 and s == "x_12", "Strings.scanRequiredIdentifier failed");

    (s,i) := Strings.scanDelimiter(
        "  &,",
        1,
        {"&",","});
    assert(i == 4 and s == "&", "Strings.scanRequiredDelimiter 1 failed");

    (s,i) := Strings.scanDelimiter(
        "  /*,",
        1,
        {"&","/*"});
    assert(i == 5 and s == "/*", "Strings.scanRequiredDelimiter 2 failed");

    Strings.scanNoToken("  abc = 3;   ", 11);

    // The hash-function can now be redefined, so we don't know what it is.
    hash1 := Strings.hashString("this is a test");
    assert(hash1 == Strings.hashString("this is a test"), "Strings.hashString 1 failed");
    hash2 := Strings.hashString("Controller.noise1");
    assert(hash2 == Strings.hashString("Controller.noise1"), "Strings.hashString 2 failed");
    // Check that hashString actually produces different values
    assert(hash1 <> Strings.hashString("this is a tes1"), "Strings.hashString 1 failed");
    assert(hash1 <> Strings.hashString("this is a tes2"), "Strings.hashString 1 failed");

    // Strings.contains
    assert(Strings.contains("", ""), "Strings.contains 1 failed (empty strings)");
    assert(Strings.contains("foo bar", "o"), "Strings.contains 2 failed (multiple occurences)");
    assert(Strings.contains("foo bar", "o ba"), "Strings.contains 3 failed (occurrence at middle)");
    assert(Strings.contains("foo bar", "fo"), "Strings.contains 4 failed (occurrence at start)");
    assert(Strings.contains("foo bar", "ar"), "Strings.contains 5 failed (occurrence at end)");
    assert(not Strings.contains("foo bar", "x"), "Strings.contains 6 failed (no occurrence)");
    assert(Strings.contains("foo", ""), "Strings.contains 7 failed (empty search string)");
    assert(not Strings.contains("foo bar", "O"), "Strings.contains 8 failed (case sensitive)");
    assert(Strings.contains("foo bar", "O", false), "Strings.contains 9 failed (case insensitive)");

    ok := true;
  end Strings;

  function Streams "Test functions of Modelica.Utilities.Streams"
    extends Modelica.Icons.Function;
    import Modelica.Utilities.Streams;
    import Modelica.Utilities.Files;
    input String logFile="ModelicaTestLog.txt"
      "Filename where the log is stored";
    output Boolean ok;
  protected
    String file1="testStreams1.txt";
    String file2="testStreams2.txt";
    String line1="this is line 1";
    String line2="this is line 2";
    String line3="this is line 3";
    String line4="this is line 4";
    String line5="this is line 5";
    String lines[3];
    String rline;
    Integer nLines;
    Boolean eof;
  algorithm
    Streams.print("... Test of Modelica.Utilities.Streams");
    Streams.print("... Test of Modelica.Utilities.Streams", logFile);

    Files.removeFile(file1);
    Streams.print(line1, file1);
    Streams.print(line2, file1);
    Streams.print(line3, file1);
    Streams.close(file1);

    Files.removeFile(file2);
    Streams.print(line4, file2);
    Streams.print(line5, file2);
    Streams.close(file2);

    lines := Streams.readFile(file1);
    assert(lines[1] == line1 and lines[2] == line2 and lines[3] == line3,
      "Streams.readFile failed");

    nLines := Streams.countLines(file1);
    assert(nLines == 3, "Streams.countLines failed");

    (rline,eof) := Streams.readLine(file1, 1);
    assert(rline == line1 and not eof, "Streams.readLine 1 failed");

    (rline,eof) := Streams.readLine(file2, 1);
    assert(rline == line4 and not eof, "Streams.readLine 1 failed");

    (rline,eof) := Streams.readLine(file1, 2);
    assert(rline == line2 and not eof, "Streams.readLine 2 failed");

    (rline,eof) := Streams.readLine(file2, 2);
    assert(rline == line5 and not eof, "Streams.readLine 2 failed");

    (rline,eof) := Streams.readLine(file1, 3);
    assert(rline == line3 and not eof, "Streams.readLine 3 failed");

    (rline,eof) := Streams.readLine(file2, 3);
    assert(rline == "" and eof, "Streams.readLine 3 failed");

    (rline,eof) := Streams.readLine(file1, 4);
    assert(rline == "" and eof, "Streams.readLine 4 failed");

    Files.removeFile(file1);
    Files.removeFile(file2);

    ok := true;
  end Streams;

  function WriteFile "Test functions of Modelica.Utilities.Streams"
    extends Modelica.Icons.Function;
    import Modelica.Utilities.Streams;
    import Modelica.Utilities.Files;
    input String logFile="ModelicaTestLog.txt"
      "Filename where the log is stored";
    output Boolean ok;
  protected
    String file1="testStreams1.txt";
    String file2="testStreams2.txt";
    String line1="this is line 1";
    String line2="this is line 2";
    String line3="this is line 3";
    String line4="this is line 4";
    String line5="this is line 5";
  algorithm
    Streams.print("... Test of Modelica.Utilities.Streams for writing of a file");
    Streams.print("... Test of Modelica.Utilities.Streams for writing of a file", logFile);

    Files.removeFile(file1);
    Streams.print(line1, file1);
    Streams.print(line2, file1);
    Streams.print(line3, file1);
    Streams.close(file1);

    Files.removeFile(file2);
    Streams.print(line4, file2);
    Streams.print(line5, file2);
    Streams.close(file2);

    ok := true;
  end WriteFile;

  function ReadFile "Test reading from file"
    extends Modelica.Icons.Function;
    import Modelica.Utilities.Streams;
    import Modelica.Utilities.Files;
    input String file1 = Modelica.Utilities.Files.loadResource("modelica://ModelicaTest/Resources/Data/ReadStreamTestFile.txt");
    input String logFile = "ModelicaTestLog.txt"
      "Filename where the log is stored";
    output Boolean ok;
  protected
    String line1="this is line 1";
    String line2="this is line 2";
    String line3="this is line 3";
    String lines[3];
    String rline;
    Integer nLines;
    Boolean eof;
  algorithm
    Streams.print("... Test of Modelica.Utilities.Streams to read from file");
    Streams.print("... Test of Modelica.Utilities.Streams to read from file", logFile);

    lines := Streams.readFile(file1);
    assert(lines[1] == line1 and lines[2] == line2 and lines[3] == line3,
      "Streams.readFile failed (at least one of the lines is wrongly read)");

    nLines := Streams.countLines(file1);
    assert(nLines == 3, "Streams.countLines failed");

    (rline,eof) := Streams.readLine(file1, 1);
    assert(rline == line1 and not eof, "Streams.readLine 1 failed");

    (rline,eof) := Streams.readLine(file1, 2);
    assert(rline == line2 and not eof, "Streams.readLine 2 failed");

    (rline,eof) := Streams.readLine(file1, 3);
    assert(rline == line3 and not eof, "Streams.readLine 3 failed");

    (rline,eof) := Streams.readLine(file1, 4);
    assert(rline == "" and eof, "Streams.readLine 4 failed");

    ok := true;
  end ReadFile;

  function System "Test functions of Modelica.Utilities.System"
    import Modelica.Utilities.Streams;
    extends Modelica.Icons.Function;
    input String logFile="ModelicaTestLog.txt"
      "Filename where the log is stored";
    output Boolean ok;
  protected
    Integer pid;
  algorithm
    Streams.print("... Test of Modelica.Utilities.System");
    Streams.print("... Test of Modelica.Utilities.System", logFile);

    pid := Modelica.Utilities.System.getPid();
    Streams.print("    pid  = " + String(pid));

    ok := true;
  end System;

  function Time "Test functions of Modelica.Utilities.Time"
    import Modelica.Utilities.Streams;
    import Modelica.Utilities.Time.{DateTime, dayOfWeek, getTime, isLeapYear, leapDays};
    extends Modelica.Icons.Function;
    input String logFile="ModelicaTestLog.txt"
      "Filename where the log is stored";
    input String weekDays[7] = Modelica.Utilities.Time.weekDays "Array of week days";
    output Boolean ok;
  protected
    DateTime now;
    Integer dow(min=1, max=7) "Day of week";
  algorithm
    Streams.print("... Test of Modelica.Utilities.Time");
    Streams.print("... Test of Modelica.Utilities.Time", logFile);

    now := getTime();
    Streams.print("    ms   = " + String(now.millisecond));
    Streams.print("    sec  = " + String(now.second));
    Streams.print("    min  = " + String(now.minute));
    Streams.print("    hour = " + String(now.hour));
    Streams.print("    day  = " + String(now.day));
    Streams.print("    mon  = " + String(now.month));
    Streams.print("    year = " + String(now.year));
    dow := dayOfWeek(now);
    Streams.print("    dow  = " + weekDays[dow]);

    dow := dayOfWeek(DateTime(year=2019, month=12, day=8, hour=12, minute=0, second=0, millisecond=0));
    assert(7 == dow, "Time.dayOfWeek failed");

    assert(not isLeapYear(1900), "Time.isLeapYear failed");
    assert(isLeapYear(2000), "Time.isLeapYear failed");
    assert(not isLeapYear(2019), "Time.isLeapYear failed");
    assert(isLeapYear(2020), "Time.isLeapYear failed");

    assert(0 == leapDays(2000, 2000), "Time.leapDays failed");
    assert(5 == leapDays(2000, 2020), "Time.leapDays failed");
    assert(-5 == leapDays(2020, 2000), "Time.leapDays failed");
    assert(5 == leapDays(-2020, -2000), "Time.leapDays failed");
    assert(98 == leapDays(1600, 2001), "Time.leapDays failed");
    assert(97 == leapDays(1601, 2001), "Time.leapDays failed");
    assert(97 == leapDays(1600, 2000), "Time.leapDays failed");
    assert(96 == leapDays(1601, 2000), "Time.leapDays failed");

    ok := true;
  end Time;

  function DateTime "Test constructors of Duration operator record and conversion to epoch"

    import Modelica.Utilities.Streams;
    import Modelica.Utilities.Time.DateTime;
    import Modelica.Utilities.Time.Duration;

    extends Modelica.Icons.Function;

    input String logFile="ModelicaTestLog.txt" "Filename where the log is stored";
    input Boolean test_past = false "Optionally run / skip tests for DateTimes before epoch year 1970";
    output Boolean ok;

  protected
    Real act_r, ref_r;
    String act_s, ref_s;
    DateTime act_dt, ref_dt;
    DateTime dt0, dt1, dt2, dt3;
    Duration d;
    Integer rc "Dummy return value";

  algorithm

    Streams.print("... Test of Modelica.Utilities.Time.DateTime");
    Streams.print("... Test of Modelica.Utilities.Time.DateTime", logFile);

    // ---------------------------------------- //
    //  constructor and epoch conversion tests  //
    // ---------------------------------------- //

    // 1 day passed since custom epoch year 2017
    ref_dt := DateTime(2017,  1,  1,  1,  1,  1, 0);
    ref_r :=  3661;

    act_dt := DateTime(ref_r, epoch_year=2017);
    act_r :=  DateTime.epoch(ref_dt, epoch_year=2017);

    assert(ref_dt==act_dt, "constructor test failed (1 day since 2017)");
    assert(ref_r==act_r, "conversion to epoch failed (1 day since 2017)");

    // 1 day passed since default epoch year 2017
    ref_dt:= DateTime(1970,  1,  1,  1,  1,  1, 0);
    ref_r := 3661;

    act_dt:= DateTime(ref_r);
    act_r := DateTime.epoch(ref_dt);

    assert(ref_dt==act_dt, "constructor test failed (1 day since 1970)");
    assert(ref_r==act_r, "conversion to epoch failed (1 day since 1970)");

    // start of new year
    ref_dt:= DateTime(1999, 12, 31, 23, 59, 59, 0);
    ref_r := 946684799;

    act_dt:= DateTime(ref_r);
    act_r := DateTime.epoch(ref_dt);

    assert(ref_dt==act_dt, "constructor test failed (last second in 1999)");
    assert(ref_r==act_r, "conversion to epoch failed (last second in 1999)");

    ref_dt:= DateTime(2000,  1,  1,  0,  0,  0, 0);
    ref_r := 946684800;

    act_dt:= DateTime(ref_r);
    act_r := DateTime.epoch(ref_dt);

    assert(ref_dt==act_dt, "constructor test failed (first second in 2000)");
    assert(ref_r==act_r, "conversion to epoch failed (first second in 2000)");

    // special leap year (new century and multiple of 400)
    ref_dt:= DateTime(2000,  2, 28, 23, 59, 59, 0);
    ref_r := 951782399;

    act_dt:= DateTime(ref_r);
    act_r := DateTime.epoch(ref_dt);

    assert(ref_dt==act_dt, "constructor test failed (detection of special leap year 1)");
    assert(ref_r==act_r, "conversion to epoch failed (detection of special leap year 1)");

    ref_dt:= DateTime(2000,  3,  1,  0,  0,  0, 0);
    ref_r := 951868800;

    act_dt:= DateTime(ref_r);
    act_r := DateTime.epoch(ref_dt);

    assert(ref_dt==act_dt, "constructor test failed (detection of special leap year 2)");
    assert(ref_r==act_r, "conversion to epoch failed (detection of special leap year 2)");

    // no leap year (new century)
    ref_dt:= DateTime(2100,  2, 28, 23, 59, 59, 0);
    ref_r := 951782399;

    act_dt:= DateTime(ref_r, epoch_year=2070);
    act_r := DateTime.epoch(ref_dt, epoch_year=2070);

    assert(ref_dt==act_dt, "constructor test failed (detection of special non-leap year 1)");
    assert(ref_r==act_r, "conversion to epoch failed (detection of special non-leap year 1)");

    ref_dt:= DateTime(2100,  3,  1,  0,  0,  0, 0);
    ref_r := 951782400;

    act_dt:= DateTime(ref_r, epoch_year=2070);
    act_r := DateTime.epoch(ref_dt, epoch_year=2070);

    assert(ref_dt==act_dt, "constructor test failed (detection of special non-leap year 2)");
    assert(ref_r==act_r, "conversion to epoch failed (detection of special non-leap year 2)");

    // regular year
    ref_dt:= DateTime(2017,  2, 28, 23, 59, 59, 0);
    ref_r := 1488326399;

    act_dt:= DateTime(ref_r);
    act_r := DateTime.epoch(ref_dt);

    assert(ref_dt==act_dt, "constructor test failed (regular year 1)");
    assert(ref_r==act_r, "conversion to epoch failed (regular year 1)");

    ref_dt:= DateTime(2017,  3,  1,  0,  0,  0, 0);
    ref_r := 1488326400;

    act_dt:= DateTime(ref_r);
    act_r := DateTime.epoch(ref_dt);

    assert(ref_dt==act_dt, "constructor test failed (regular year 2)");
    assert(ref_r==act_r, "conversion to epoch failed (regular year 2)");

    // leap year
    ref_dt:= DateTime(2020,  2, 28, 23, 59, 59, 0);
    ref_r := 1582934399;

    act_dt:= DateTime(ref_r);
    act_r := DateTime.epoch(ref_dt);

    assert(ref_dt==act_dt, "constructor test failed (regular leap year 1)");
    assert(ref_r==act_r, "conversion to epoch failed (regular leap year 1)");

    ref_dt:= DateTime(2020,  3,  1,  0,  0,  0, 0);
    ref_r := 1583020800;

    act_dt:= DateTime(ref_r);
    act_r := DateTime.epoch(ref_dt);

    assert(ref_dt==act_dt, "constructor test failed (regular leap year 2)");
    assert(ref_r==act_r, "conversion to epoch failed (regular leap year 2)");

    // end of year
    ref_dt:= DateTime(2019, 12, 31, 23, 59, 59, 0);
    ref_r := 1577836799;

    act_dt:= DateTime(ref_r);
    act_r := DateTime.epoch(ref_dt);

    assert(ref_dt==act_dt, "constructor test failed (end of regular year)");
    assert(ref_r==act_r, "conversion to epoch failed (end of regular year)");

    ref_dt:= DateTime(2020, 12, 31, 23, 59, 59, 0);
    ref_r := 1609459199;

    act_dt:= DateTime(ref_r);
    act_r := DateTime.epoch(ref_dt);

    assert(ref_dt==act_dt, "constructor test failed (end of leap year)");
    assert(ref_r==act_r, "conversion to epoch failed (end of leap year)");

    if test_past then
      // lowest value for 32bit integer
      // this test is not relevant, as datatype Real is used to count
      // seconds from epoch. Would be needed, if Integer is used instead
      // (for whatever reason). But it does not hurt to have it, so we keep it.
      ref_dt:= DateTime(1901, 12, 13, 20, 45, 53, 0);
      ref_r := -2147483647;

      act_dt:= DateTime(ref_r);
      act_r := DateTime.epoch(ref_dt);

      assert(ref_dt==act_dt, "constructor test failed (lowest possible value for 32bit integer)");
      assert(ref_r==act_r, "conversion to epoch failed (lowest possible value for 32bit integer)");

      // regular year in past
      ref_dt:= DateTime(1910, 12, 31, 1, 59, 59, 0);
      ref_r := -1861999201;

      act_dt:= DateTime(ref_r);
      act_r := DateTime.epoch(ref_dt);

      assert(ref_dt==act_dt, "constructor test failed (regular year before epoch)");
      assert(ref_r==act_r, "conversion to epoch failed (regular year before epoch)");

      // leap year in past
      ref_dt:= DateTime(1912, 12, 31, 1, 59, 59, 0);
      ref_r := -1798840801;

      act_dt:= DateTime(ref_r);
      act_r := DateTime.epoch(ref_dt);

      assert(ref_dt==act_dt, "constructor test failed (leap regular year before epoch)");
      assert(ref_r==act_r, "conversion to epoch failed (leap regular year before epoch)");
    end if;

    // compare two DateTime records created from system time. dt2 should be a few seconds later than dt1
    dt1 :=DateTime();
    rc :=Modelica.Utilities.System.command("sleep 1") "Sleep 1s on linux";
    rc :=Modelica.Utilities.System.command("ping -n 2 127.0.0.1 > NUL") "Sleep 1s on windows";
    dt2 :=DateTime();

    assert(  (dt2 > dt1) and (DateTime.epoch(dt2)-DateTime.epoch(dt1) < 5),
      "constructor from system time failed (dt1 is younger than dt2)");


    // ---------------- //
    //  operator tests  //
    // ---------------- //

    dt1 := DateTime(2019, 12, 31, 23, 59, 59, 999);
    dt2 := DateTime(2020, 01, 01, 00, 00, 00, 0);
    dt3 := DateTime(2020, 01, 01, 00, 00, 00, 1);

    // 'String'.formated
    ref_s :="2020-01-01 00:00:00";
    act_s :=String(dt3);
    assert(ref_s==act_s, "default string formating failed. \n"+ref_s+" <> "+act_s);

    ref_s :="Monday, 06. April 20, 13:01:07.999";
    act_s :=String(DateTime(2020, 4, 6, 13, 01, 7, 999),  format="%A, %d. %B %y, %H:%M:%S.%L");
    assert(ref_s==act_s, "custom string formating 1 failed. \n"+ref_s+" <> "+act_s);

    ref_s :="Tue, Apr. 07 2020, 01:11:17";
    act_s :=String(DateTime(2020, 4, 7, 01, 11, 17, 999),  format="%a, %b. %d %Y, %H:%M:%S");
    assert(ref_s==act_s, "custom string formating 1 failed. \n"+ref_s+" <> "+act_s);

    ref_s :="% Tue, %Apr";
    act_s :=String(DateTime(2020, 4, 7, 01, 11, 17, 999),  format="%% %a, %%%b");
    assert(ref_s==act_s, "custom string formating 1 failed. \n"+ref_s+" <> "+act_s);

    // ==
    assert(dt1==dt1, "dt1==dt1 failed");

    // <>
    assert(dt1<>dt2, "dt1<>dt2 failed");

    // >
    assert(dt2>dt1, "dt2>dt1 failed");

    // >=
    assert(dt2>=dt1, "dt2>=dt1 failed");
    assert(dt1>=dt1, "dt1>=dt1 failed");

    // <
    assert(dt2<dt3, "dt2<dt3 failed");

    // <=
    assert(dt2<=dt3, "dt2<=dt3 failed");
    assert(dt3<=dt3, "dt3<=dt3 failed");

    // + add Duration
    dt0 := DateTime("2020-04-20 04:30:00");
    d := Duration(days=11, hours=2, minutes=3, seconds=100, milliseconds=0);
    ref_dt := DateTime("2020-05-01 06:34:40");
    assert(dt0+d==ref_dt, "DateTime+Duration failed");
    assert(d+dt0==ref_dt, "Duration+DateTime failed");

    // - subtract DateTime
    assert(dt2-dt1==Duration(days=0, hours=0, minutes=0, seconds=0, milliseconds=1),  "dt2-dt1 failed");
    assert(dt1-dt2==Duration(days=0, hours=0, minutes=0, seconds=0, milliseconds=-1), "dt1-dt2 failed");

    // - subtract Duration
    act_dt := DateTime("2020-04-20 04:30:00") - Duration(days=10, hours=2, minutes=3, seconds=4, milliseconds=0);
    ref_dt := DateTime("2020-04-10 02:26:56");
    assert(act_dt==ref_dt, "DateTime-Duration failed");

    // return result
    ok := true;

    annotation ();
  end DateTime;

  function Duration "Test constructors and functions in Duration operator record"

    import Modelica.Utilities.Streams;
    import Modelica.Utilities.Time.Duration;
    import Modelica.Utilities.Time.DateTime;

    extends Modelica.Icons.Function;

    input String logFile="ModelicaTestLog.txt" "Filename where the log is stored";
    output Boolean ok;

  protected
    Duration d1, d2, d3;
    Duration act, ref;
    Real ref_r, act_r;
    Integer ref_v[:], act_v[:];
    String act_s, ref_s;

  algorithm

    Streams.print("... Test of Modelica.Utilities.Time.Duration");
    Streams.print("... Test of Modelica.Utilities.Time.Duration", logFile);

    // preparation of duration variables, used through out the test
    d1 :=Duration(days=1, hours=1, minutes=1, seconds=1, milliseconds=1);
    d2 :=Duration(days=0, hours=23, minutes=59, seconds=59, milliseconds=999);
    d3 :=Duration(days=-1, hours=-1, minutes=-1, seconds=-1, milliseconds=-1);

    // constructors
    ref := Duration(days=-45, hours=33, minutes=61, seconds=-9871, milliseconds=-1501);
    act := Duration(totalSeconds=-3775412.501);
    assert(ref==act, "constructor test 1 failed (fromSeconds vs fromInput)");

    ref := Duration(dt1=DateTime(2020, 1, 1, 1, 1, 1, 1), dt2=DateTime(2020, 1, 1, 1, 1, 2, 500));
    act := Duration(totalSeconds=1.499);
    assert(ref==act, "constructor test 2 failed (fromSeconds vs fromDateTimes, positive result)");

    ref := Duration(dt1=DateTime(2020, 1, 1, 1, 1, 2, 500), dt2=DateTime(2020, 1, 1, 1, 1, 1, 1));
    act := Duration(totalSeconds=-1.499);
    assert(ref==act, "constructor test 3 failed (fromSeconds vs fromDateTimes, negative result)");

    ref := Duration(days=-8, hours=-23, minutes=-30, seconds=-0, milliseconds=0);
    act := Duration(DateTime("2020-1-10 0:0:0"), DateTime("2020-1-1 0:30:0"));
    assert(ref==act, "constructor test 4a failed (fromInput vs fromDateTimes, negative result)");

    ref_r := -775800.0;
    act_r := Duration.inSeconds(act);
    assert(ref_r==act_r, "constructor test 4b failed (real vs fromDateTimes in seconds, negative result)");

    // 'String'.formated
    ref_s :="1d 1h 1min 1s 1ms";
    act_s :=String(d1);
    assert(ref_s==act_s, "default string formating failed. Got "+ref_s+"<>"+act_s);

    ref_s :="25h 01' 01.001''";
    act_s :=String(d1, format="%Hh %M' %S.%L''");
    assert(ref_s==act_s, "custom string formating 1 failed. \n"+ref_s+" <> "+act_s);

    ref_s :="25h %01'% 1''";
    act_s :=String(d1, format="%Hh %%%M'%% %seconds''");
    assert(ref_s==act_s, "custom string formating 2 failed. \n"+ref_s+" <> "+act_s);

    ref_s :="25h 61s";
    act_s :=String(d1, format="%Hh %Ss");
    assert(ref_s==act_s, "custom string formating 3 failed. \n"+ref_s+" <> "+act_s);

    // ==
    assert(d1==d1, "d1==d1 failed");

    // <>
    assert(d1<>d2, "d1<>d2 failed");

    // >
    assert(d1>d2, "d1>d2 failed");

    // >=
    assert(d1>=d2, "d1>=d2 failed");
    assert(d1>=d1, "d1>=d1 failed");

    // <
    assert(d3<d1, "d3<d1 failed");

    // <=
    assert(d3<=d1, "d3<=d1 failed");
    assert(d3<=d3, "d3<=d3 failed");

    // +
    ref :=Duration(days=1, hours=24, minutes=60, seconds=60, milliseconds=1000);
    act :=d1 + d2;
    assert(ref==act, "d1+d2 failed");

    ref :=Duration(totalSeconds=0);
    act := Duration.normalize(d1 + d3);
    assert(ref==act, "d1+d3 failed");

    // - subtract
    ref :=Duration(days=-1, hours=22, minutes=58, seconds=58, milliseconds=998);
    act :=d2 - d1;
    assert(ref==act, "d2-d1 failed");

    ref :=Duration(days=1, hours=-22, minutes=-58, seconds=-58, milliseconds=-998);
    act :=d1 - d2;
    assert(ref==act, "d1-d2 failed");

    // - negate
    ref :=Duration(days=-1, hours=-1, minutes=-1, seconds=-1, milliseconds=-1);
    act :=-d1;
    assert(ref==act, "-d1 failed");

    // * multiply 1
    ref :=Duration(days=2, hours=2, minutes=2, seconds=2, milliseconds=2);
    act :=d1 * 2;
    assert(ref==act, "d1*2 failed");

    // * multiply 2
    ref :=Duration(days=2, hours=2, minutes=2, seconds=2, milliseconds=2);
    act := 2 * d1;
    assert(ref==act, "2*d1 failed");

    // / divide
    ref := Duration(days=0, hours=12, minutes=30, seconds=30, milliseconds=501);
    // 501ms result from the implementation of the division: fromSeconds is used, which rounds to the closest full milliseconds
    // 1 / 2 = 0.5, rounded -> 1
    act := Duration.normalize(d1 / 2);
    assert(ref==act, "d1/2 failed");

    // '0'
    ref := Duration(days=0, hours=0, minutes=0, seconds=0, milliseconds=0);
    act := Duration.'0'();
    assert(ref==act, "'0' failed");

    // asVector
    ref_v :={0, 23, 59, 59, 999};
    act_v :=Duration.asVector(d2);

    for i in 1:size(ref_v, 1) loop
      assert(ref_v[i]==act_v[i], "conversion to vector failed (element "+String(i)+")");
    end for;

    // avg
    ref := Duration(days=1, hours=0, minutes=30, seconds=30, milliseconds=500);
    act := Duration.avg({d1, d2});
    assert(ref==act, "average of {d1, d2} failed");

    // inSeconds
    ref_r := 2291959.03;
    act_r := Duration.inSeconds(Duration(days=27, hours=-12, minutes=30, seconds=559, milliseconds=30));
    assert(ref_r==act_r, "conversion to total seconds failed");

    // normalize
    ref_v :={2, 5, 38, 0, 1};
    act_v :=Duration.asVector(
              Duration.normalize(
                Duration(days=1, hours=28, minutes=97, seconds=59, milliseconds=1001)));

    for i in 1:size(ref_v, 1) loop
      assert(ref_v[i]==act_v[i], "normalization failed (element " +String(i)+")");
    end for;

    // sum
    assert(sum(Duration(i, 0, 0, 0, 0) for i in 1:2) == Duration(3, 0, 0, 0, 0), "sum failed");

    // return result
    ok := true;

  end Duration;

  function Internal "Test functions of Modelica.Utilities.Internal"
    extends Modelica.Icons.Function;
    import Modelica.Utilities.Internal.FileSystem;
    // We must extend to make internal functions available.
    import Modelica.Utilities.System;
    import Modelica.Utilities.Types;
    import Modelica.Utilities.Streams;

    input String logFile="ModelicaTestLog.txt"
      "Filename where the log is stored";
    output Boolean ok;
  protected
    String dir1;
    String dir2;
    String dir3;
    String dir4;
    String env;
    Boolean exist;
    Modelica.Utilities.Types.FileType fileType;
  algorithm
    Streams.print("... Test of Modelica.Utilities.Internal.FileSystem and .System");
    Streams.print("... Test of Modelica.Utilities.Internal.FileSystem and .System", logFile);

    // Check Modelica.Utilities.Internal and Modelica.Utilities.System
    dir1 := System.getWorkDirectory();
    dir2 := dir1 + "/#ModelicaTest";
    fileType := FileSystem.stat(dir2);
    if fileType > Types.FileType.NoFile then
      FileSystem.rmdir(dir2);
    end if;
    FileSystem.mkdir(dir2);
    fileType := FileSystem.stat(dir2);
    assert(fileType == Types.FileType.Directory, "FileSystem.mkdir/stat failed");

    System.setWorkDirectory(dir2);

    dir3 := System.getWorkDirectory();
    assert(dir2 == dir3, "System.xxxWorkDirectory failed\n" + "set dir = " +
      dir1 + "\n" + "get dir = " + dir3 + "\n");
    System.setWorkDirectory("..");

    dir4 := dir1 + "/#ModelicaTest2";
    FileSystem.rename(dir2, dir4);
    FileSystem.rmdir(dir4);

    System.setEnvironmentVariable(
        "#ModelicaTest",
        "/dir1/dir2/dir3",
        convertFromSlash=true);
    (env,exist) := System.getEnvironmentVariable("#ModelicaTest",
      convertToSlash=true);
    assert(exist, "System.getEnvironmentVariable 1 failed");
    assert(env == "/dir1/dir2/dir3", "System.getEnvironmentVariable 2 failed\n"
       + "env = " + env);
    ok := true;
  end Internal;

  function Files "Test functions of Modelica.Utilities.Files"
    extends Modelica.Icons.Function;
    import Modelica.Utilities.Files;
    import Modelica.Utilities.Streams;

    input String logFile="ModelicaTestLog.txt"
      "Filename where the log is stored";
    input String dirPath = Modelica.Utilities.Files.loadResource("modelica://ModelicaTest/Resources/Data");
    input String filePath = Modelica.Utilities.Files.loadResource("modelica://ModelicaTest/Resources/Data/ReadStreamTestFile.txt");

    output Boolean ok;
  protected
    String directory;
    String name;
    String extension;
  algorithm
    Streams.print("... Test of Modelica.Utilities.Files");
    Streams.print("... Test of Modelica.Utilities.Files", logFile);

    Modelica.Utilities.Files.list(dirPath);
    Modelica.Utilities.Files.list(filePath);
    // list() does not have output, therefore assert not feasible

    (directory,name,extension) := Files.splitPathName("E:/test1/test2.save.txt");
    assert(directory == "E:/test1/" and name == "test2.save" and extension ==
      ".txt", "Files.splitPathName 1 failed");

    (directory,name,extension) := Files.splitPathName("E:/test1/test2");
    assert(directory == "E:/test1/" and name == "test2" and extension == "",
      "Files.splitPathName 2 failed");

    ok := true;
  end Files;

  function testAll "Test functions of Modelica.Utilities"
    extends Modelica.Icons.Function;
    input String logFile="ModelicaTestLog.txt"
      "Filename where the log is stored";
    output Boolean ok;
  protected
    Boolean result;
  algorithm
    result := ModelicaTest.Utilities.Strings(logFile);
    result := ModelicaTest.Utilities.Streams(logFile);
    result := ModelicaTest.Utilities.Files(logFile);
    result := ModelicaTest.Utilities.Internal(logFile);
    result := ModelicaTest.Utilities.System(logFile);
    result := ModelicaTest.Utilities.Time(logFile);
    result := ModelicaTest.Utilities.Duration(logFile);
    result := ModelicaTest.Utilities.DateTime(logFile);
    ok := true;
  end testAll;

  model TestStrings
    extends Modelica.Icons.Example;

    Boolean result;
  algorithm
    when initial() then
      result := ModelicaTest.Utilities.Strings();
    end when;

    annotation (experiment(StopTime=0));
  end TestStrings;

  model TestStreams
    extends Modelica.Icons.Example;

    Boolean result;
  algorithm
    when initial() then
      result := ModelicaTest.Utilities.Streams();
    end when;

    annotation (experiment(StopTime=0));
  end TestStreams;

  model TestWriteFile
    extends Modelica.Icons.Example;
    Boolean result;
  algorithm
    when initial() then
      result := ModelicaTest.Utilities.WriteFile();
    end when;

    annotation (experiment(StopTime=0));
  end TestWriteFile;

  model TestReadFile
    extends Modelica.Icons.Example;
    parameter String file = Modelica.Utilities.Files.loadResource("modelica://ModelicaTest/Resources/Data/ReadStreamTestFile.txt");
    Boolean result;
  algorithm
    when initial() then
      result := ModelicaTest.Utilities.ReadFile(file);
    end when;

    annotation (experiment(StopTime=0));
  end TestReadFile;

  model TestInternal
    extends Modelica.Icons.Example;

    Boolean result;
  algorithm
    when initial() then
      result := ModelicaTest.Utilities.Internal();
    end when;

    annotation (experiment(StopTime=0));
  end TestInternal;

  model TestFiles
    extends Modelica.Icons.Example;

    parameter String dirPath = Modelica.Utilities.Files.loadResource("modelica://ModelicaTest/Resources/Data");
    parameter String filePath = Modelica.Utilities.Files.loadResource("modelica://ModelicaTest/Resources/Data/ReadStreamTestFile.txt");

    Boolean result;
  algorithm
    when initial() then
      result := ModelicaTest.Utilities.Files(dirPath = dirPath, filePath = filePath);
    end when;

    annotation (experiment(StopTime=0));
  end TestFiles;

  model TestExamplesCalculator
    extends Modelica.Icons.Example;
    parameter Real eps=1e-13 "Threshold for comparison of floating-point numbers";
  equation
    assert(Modelica.Math.isEqual(11., Modelica.Utilities.Examples.calculator("2+3*(4-1)"), eps), "Test of Modelica.Utilities.Examples.calculator failed!");
    assert(Modelica.Math.isEqual(0.5, Modelica.Utilities.Examples.calculator("sin(pi/6)"), eps), "Test of Modelica.Utilities.Examples.calculator failed!");
    annotation (experiment(StopTime=0));
  end TestExamplesCalculator;

end Utilities;
