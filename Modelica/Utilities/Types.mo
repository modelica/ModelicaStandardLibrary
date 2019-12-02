within Modelica.Utilities;
package Types "Type definitions used in package Modelica.Utilities"
  extends Modelica.Icons.TypesPackage;
  type Compare = enumeration(
      Less "String 1 is lexicographically less than string 2",
      Equal "String 1 is identical to string 2",
      Greater "String 1 is lexicographically greater than string 2")
    "Enumeration defining comparison of two strings";

  type FileType = enumeration(
      NoFile "No file exists",
      RegularFile "Regular file",
      Directory "Directory",
      SpecialFile "Special file (pipe, FIFO, device, etc.)")
    "Enumeration defining the type of a file";

  type TokenType = enumeration(
      RealToken,
      IntegerToken,
      BooleanToken,
      StringToken,
      IdentifierToken,
      DelimiterToken,
      NoToken) "Enumeration defining the token type";

  record TokenValue "Value of token"
     extends Modelica.Icons.Record;
     TokenType tokenType "Type of token";
     Real real "Value if tokenType == TokenType.RealToken";
     Integer integer "Value if tokenType == TokenType.IntegerToken";
     Boolean boolean "Value if tokenType == TokenType.BooleanToken";
     String string
      "Value if tokenType == TokenType.StringToken/IdentifierToken/DelimiterToken";
    annotation (Documentation(info="<html>

</html>"));
  end TokenValue;

  record TimeType "Record containing date and time components"
    extends Modelica.Icons.Record;
    Integer ms(min=0, max=999) "Millisecond" annotation(absoluteValue=true);
    Integer sec(min=0, max=61) "Second" annotation(absoluteValue=true);
    Integer min(min=0, max=59) "Minute" annotation(absoluteValue=true);
    Integer hour(min=0, max=23) "Hour" annotation(absoluteValue=true);
    Integer day(min=1, max=31) "Day" annotation(absoluteValue=true);
    Integer mon(min=1, max=12) "Month" annotation(absoluteValue=true);
    Integer year "Year" annotation(absoluteValue=true);
    annotation (Documentation(info="<html>
<blockquote>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Argument</th>
    <th>Range</th>
    <th>Description</th></tr>

<tr><td>ms</td> <td>0 .. 999</td>
    <td>Milliseconds after second</td></tr>

<tr><td>sec</td> <td>0 .. 61</td>
    <td>Seconds after minute</td></tr>

<tr><td>min</td> <td>0 .. 59</td>
    <td>Minutes after hour</td></tr>

<tr><td>hour</td> <td>0 .. 23</td>
    <td>Hours after midnight</td></tr>

<tr><td>day</td> <td>1 .. 31</td>
    <td>Day of month</td></tr>

<tr><td>mon</td> <td>1 .. 12</td>
    <td>Month</td></tr>

<tr><td>year</td> <td>&zwnj;</td>
    <td>Year</td></tr>
</table>
</blockquote>
</html>"));
  end TimeType;

  annotation (Documentation(info="<html>
<p>
This package contains type definitions used in Modelica.Utilities.
</p>

</html>"));
end Types;
