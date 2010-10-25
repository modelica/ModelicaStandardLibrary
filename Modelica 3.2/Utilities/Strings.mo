within Modelica.Utilities;
package Strings "Operations on strings"
  extends Modelica.Icons.Package;

  function length "Returns length of string"
    extends Modelica.Icons.Function;
    input String string;
    output Integer result "Number of characters of string";
  external "C" result=  ModelicaStrings_length(string);
    annotation (Library="ModelicaExternalC", Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Strings.<b>length</b>(string);
</pre></blockquote>
<h4>Description</h4>
<p>
Returns the number of characters of \"string\".
</p>
</html>"));
  end length;

  function substring "Returns a substring defined by start and end index"

    extends Modelica.Icons.Function;
    input String string "String from which a substring is inquired";
    input Integer startIndex(min=1)
      "Character position of substring begin (index=1 is first character in string)";
    input Integer endIndex(min=1) "Character position of substring end";
    output String result
      "String containing substring string[startIndex:endIndex]";
  external "C" result =
                      ModelicaStrings_substring(string,startIndex,endIndex);
    annotation (Library="ModelicaExternalC",
  Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
string2 = Strings.<b>substring</b>(string, startIndex, endIndex);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns
the substring from position startIndex
up to and including position endIndex of \"string\" .
</p>
<p>
If index, startIndex, or endIndex are not correct, e.g.,
if endIndex &gt; length(string), an assert is triggered.
</p>
<h4>Example</h4>
<blockquote><pre>
  string1 := \"This is line 111\";
  string2 := Strings.substring(string1,9,12); // string2 = \"line\"
</pre></blockquote>
</html>"));
  end substring;

  function repeat "Repeat a string n times"
    extends Modelica.Icons.Function;
    input Integer n(min=0) = 1 "Number of occurences";
    input String string=" " "String that is repeated";
    output String repeatedString "String containing n concatenated strings";
  algorithm
    repeatedString :="";
    for i in 1:n loop
       repeatedString := repeatedString + string;
    end for;
    annotation (
  Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
string2 = Strings.<b>repeat</b>(n);
string2 = Strings.<b>repeat</b>(n, string=\" \");
</pre></blockquote>
<h4>Description</h4>
<p>
The first form returns a string consisting of n blanks.
</p>
<p>
The second form returns a string consisting of n substrings
defined by the optional argument \"string\".
</p>
</html>"));
  end repeat;

  function compare "Compare two strings lexicographically"
    extends Modelica.Icons.Function;
    input String string1;
    input String string2;
    input Boolean caseSensitive=true "= false, if case of letters is ignored";
    output Modelica.Utilities.Types.Compare result "Result of comparison";
  external "C" result=  ModelicaStrings_compare(string1, string2, caseSensitive);
    annotation (Library="ModelicaExternalC", Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
result = Strings.<b>compare</b>(string1, string2);
result = Strings.<b>compare</b>(string1, string2, caseSensitive=true);
</pre></blockquote>
<h4>Description</h4>
<p>
Compares two strings. If the optional argument caseSensitive=false,
upper case letters are treated as if they would be lower case letters.
The result of the comparison is returned as:
</p>
<pre>
  result = Modelica.Utilities.Types.Compare.Less     // string1 &lt; string2
         = Modelica.Utilities.Types.Compare.Equal    // string1 = string2
         = Modelica.Utilities.Types.Compare.Greater  // string1 &gt; string2
</pre>
<p>
Comparison is with regards to lexicographical order,
e.g., \"a\" &lt; \"b\";
</p>
</html>"));
  end compare;

  function isEqual "Determine whether two strings are identical"
    extends Modelica.Icons.Function;
    input String string1;
    input String string2;
    input Boolean caseSensitive=true
      "= false, if lower and upper case are ignored for the comparison";
    output Boolean identical "True, if string1 is identical to string2";
  algorithm
    identical :=compare(string1, string2, caseSensitive) == Types.Compare.Equal;
    annotation (
  Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Strings.<b>isEqual</b>(string1, string2);
Strings.<b>isEqual</b>(string1, string2, caseSensitive=true);
</pre></blockquote>
<h4>Description</h4>
<p>
Compare whether two strings are identical,
optionally ignoring case.
</p>
</html>"));
  end isEqual;

  function count "Count the number of non-overlapping occurrences of a string"
    extends Modelica.Icons.Function;
    input String string "String that is analyzed";
    input String searchString "String that is searched for in string";
    input Integer startIndex(min=1)=1 "Start search at index startIndex";
    input Boolean caseSensitive=true
      "= false, if lower and upper case are ignored for count";
    output Integer result "Number of occurrences of 'searchString' in 'string'";
  protected
    Integer lenSearchString = length(searchString);
    Integer i = startIndex;
  algorithm
    result := 0;
    while i <> 0 loop
       i := find(string, searchString, i, caseSensitive);
       if i > 0 then
          result := result + 1;
          i := i + lenSearchString;
       end if;
    end while;
    annotation (
  Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Strings.<b>count</b>(string, searchString)
Strings.<b>count</b>(string, searchString, startIndex=1,
                     caseSensitive=true)
</pre></blockquote>
<h4>Description</h4>
<p>
Returns the number of non-overlapping occurrences of string \"searchString\"
in \"string\". The search is started at index \"startIndex\" (default = 1).
If the optional argument \"caseSensitive\" is false,
for the counting it does not matter whether a letter is upper
or lower case.
/p>
</html>"));
  end count;

  function find "Find first occurrence of a string within another string"
    extends Modelica.Icons.Function;
    input String string "String that is analyzed";
    input String searchString "String that is searched for in string";
    input Integer startIndex(min=1)=1 "Start search at index startIndex";
    input Boolean caseSensitive=true
      "= false, if lower and upper case are ignored for the search";
     output Integer index
      "Index of the beginning of the first occurrence of 'searchString' within 'string', or zero if not present";
  protected
    Integer lengthSearchString = length(searchString);
    Integer len = lengthSearchString-1;
    Integer i = startIndex;
    Integer i_max = length(string) - lengthSearchString + 1;
  algorithm
    index := 0;
    while i <= i_max loop
       if isEqual(substring(string,i,i+len),
                  searchString, caseSensitive) then
          index := i;
          i := i_max + 1;
       else
          i := i+1;
       end if;
    end while;
    annotation (
  Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
index = Strings.<b>find</b>(string, searchString);
index = Strings.<b>find</b>(string, searchString, startIndex=1,
                     caseSensitive=true);
</pre></blockquote>
<h4>Description</h4>
<p>
Finds first occurence of \"searchString\" within \"string\"
and return the corresponding index.
Start search at index \"startIndex\" (default = 1).
If the optional argument \"caseSensitive\" is false, lower
and upper case are ignored for the search.
If \"searchString\" is not found, a value of \"0\" is returned.
</p>
</html>
"));
  end find;

  function findLast "Find last occurrence of a string within another string"
    extends Modelica.Icons.Function;
    input String string "String that is analyzed";
    input String searchString "String that is searched for in string";
    input Integer startIndex(min=0)=0
      "Start search at index startIndex. If startIndex = 0, start at length(string)";
    input Boolean caseSensitive=true
      "= false, if lower and upper case are ignored for the search";
    output Integer index
      "Index of the beginning of the last occurrence of 'searchString' within 'string', or zero if not present";
  protected
    Integer lenString = length(string);
    Integer lenSearchString = length(searchString);
    Integer i;
  algorithm
    i := if startIndex == 0 then lenString-lenSearchString+1 else startIndex;
    index := 0;
    while i >= 1 loop
       if isEqual(substring(string,i,i+lenSearchString-1),
                  searchString, caseSensitive) then
          index := i;
          i := 0;
       else
          i := i-1;
       end if;
    end while;
    annotation (
  Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
index = Strings.<b>findLast</b>(string, searchString);
index = Strings.<b>findLast</b>(string, searchString,
                         startIndex=length(string), caseSensitive=true,
</pre></blockquote>
<h4>Description</h4>
<p>
Finds first occurence of \"searchString\" within \"string\"
when searching from the last character of \"string\"
backwards, and return the corresponding index.
Start search at index \"startIndex\" (default = length(string)).
If the optional argument \"caseSensitive\" is false, lower
and upper case are ignored for the search.
If \"searchString\" is not found, a value of \"0\" is returned.
</p>
</html>
"));
  end findLast;

  function replace
    "Replace non-overlapping occurrences of a string from left to right"
    extends Modelica.Icons.Function;
    input String string "String to be modified";
    input String searchString
      "Replace non-overlapping occurrences of 'searchString' in 'string' with 'replaceString'";
    input String replaceString
      "String that replaces 'searchString' in 'string'";
    input Integer startIndex=1 "Start search at index startIndex";
    input Boolean replaceAll=true
      "if false, replace only the first occurrence, otherwise all occurrences";
    input Boolean caseSensitive=true
      "= false, if lower and upper case are ignored when searching for searchString";
    output String result "Resultant string of replacement operation";
  protected
    Integer lenString = length(string);
    Integer lenSearchString = length(searchString);
    Integer i = startIndex;
    Integer i_found;
  algorithm
    result := if startIndex == 1 then "" else substring(string,1,startIndex-1);
    while i > 0 loop
       i_found := find(string, searchString, i, caseSensitive);
       if i_found > 0 then
          result := if i_found == 1 then
                       replaceString else
                       result + (if i_found-1<i then "" else substring(string, i, i_found-1)) + replaceString;
          i := i_found + lenSearchString;
          if i > lenString then
             i := 0;
          elseif not replaceAll then
             result := result + substring(string, i, lenString);
             i := 0;
          end if;
       elseif lenString<i then
          i := 0;
       else
          result := result + substring(string, i, lenString);
          i := 0;
       end if;
    end while;
    annotation (
  Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Strings.<b>replace</b>(string, searchString, replaceString);
Strings.<b>replace</b>(string, searchString, replaceString,
                startIndex=1, replaceAll=true, caseSensitive=true);
</pre></blockquote>
<h4>Description</h4>
<p>
Search in \"string\" for \"searchString\" and replace the found
substring by \"replaceString\".
<p>
<ul>
<li> The search starts at the first character of \"string\",
     or at character position \"startIndex\",
     if this optional argument is provided.</li>
<li> If the optional argument \"replaceAll\" is <b>true</b> (default),
     all occurrences of \"searchString\" are replaced.
     If the argument is <b>false</b>, only the first occurrence
     is replaced. </li>
<li> The search for \"searchString\" distinguishes upper and lower
     case letters. If the optional argument \"caseSensitive\" is
     <b>false</b>,
     the search ignores whether letters are upper
     or lower case. </li>
</ul>
<p>
The function returns the \"string\" with the
performed replacements.
</p>
</html>"));
  end replace;

  function sort "Sort vector of strings in alphabetic order"
    extends Modelica.Icons.Function;
    input String stringVector1[:] "vector of strings";
    input Boolean caseSensitive=true
      "= false, if lower and upper case are ignored when comparing elements of stringVector1";
    output String stringVector2[size(stringVector1,1)]
      "string1 sorted in alphabetical order";
    /* shellsort algorithm; should be improved later */
  protected
    Integer gap;
    Integer i;
    Integer j;
    String tempString;
    Integer nStringVector1 = size(stringVector1,1);
    Boolean swap;
  algorithm
    stringVector2 := stringVector1;
    gap := div(nStringVector1,2);

    while gap > 0 loop
       i := gap;
       while i < nStringVector1 loop
          j := i-gap;
          if j >= 0 then
             swap := compare(stringVector2[j+1], stringVector2[j+gap+1], caseSensitive)
                     == Modelica.Utilities.Types.Compare.Greater;
          else
             swap := false;
          end if;

          while swap loop
             tempString := stringVector2[j+1];
             stringVector2[j+1] := stringVector2[j+gap+1];
             stringVector2[j+gap+1] := tempString;
             j := j - gap;
             if j >= 0 then
                swap := compare(stringVector2[j+1], stringVector2[j+gap+1], caseSensitive)
                        == Modelica.Utilities.Types.Compare.Greater;
             else
                swap := false;
             end if;
          end while;
          i := i + 1;
       end while;
       gap := div(gap,2);
    end while;

    annotation (Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
stringVector2 = Streams.<b>sort</b>(stringVector1);
stringVector2 = Streams.<b>sort</b>(stringVector1, caseSensitive=true);
</pre></blockquote>
<h4>Description</h4>
<p>
Function <b>sort</b>(..) sorts a string vector stringVector1
in lexicographical order and returns the result in stringVector2.
If the optional argument \"caseSensitive\" is <b>false</b>, lower
and upper case letters are not distinguished.
</p>
<h4>Example</h4>
<blockquote><pre>
  s1 = {\"force\", \"angle\", \"pressure\"};
  s2 = Strings.sort(s1);
       -> s2 = {\"angle\", \"force\", \"pressure\"};
</pre></blockquote>
</HTML>"));
  end sort;

  function scanToken "Scan for the next token and return it"
    extends Modelica.Icons.Function;
    input String string "String to be scanned";
    input Integer startIndex(min=1) = 1
      "Start scanning of string at character startIndex";
    input Boolean unsigned=false
      "= true, if Real and Integer tokens shall not start with a sign";
    output Types.TokenValue token "Scanned token";
    output Integer nextIndex
      "Index of character after the found token; = 0, if NoToken";
  protected
    Integer startTokenIndex;
  algorithm
    // Initialize token
    token.real :=0.0;
    token.integer :=0;
    token.boolean :=false;
    token.string :="";

    // skip white space and line comments
    startTokenIndex := Advanced.skipLineComments(string, startIndex);
    if startTokenIndex > length(string) then
      token.tokenType := Modelica.Utilities.Types.TokenType.NoToken;
      nextIndex := startTokenIndex;
    else
      // scan Integer number
        (nextIndex, token.integer) := Advanced.scanInteger(string, startTokenIndex, unsigned);
         token.tokenType := Types.TokenType.IntegerToken;

      // scan Real number
      if nextIndex == startTokenIndex then
        (nextIndex, token.real) :=Advanced.scanReal(string, startTokenIndex, unsigned);
         token.tokenType := Types.TokenType.RealToken;
      end if;

      // scan String
      if nextIndex == startTokenIndex then
         (nextIndex,token.string) := Advanced.scanString(string, startTokenIndex);
          token.tokenType:= Types.TokenType.StringToken;
      end if;

      // scan Identifier or Boolean
      if nextIndex == startTokenIndex then
         (nextIndex,token.string) := Advanced.scanIdentifier(string, startTokenIndex);
         if nextIndex > startTokenIndex then
            if token.string == "false" then
               token.string := "";
               token.boolean :=false;
               token.tokenType := Types.TokenType.BooleanToken;
            elseif token.string == "true" then
               token.string := "";
               token.boolean := true;
               token.tokenType := Types.TokenType.BooleanToken;
            else
               token.tokenType := Types.TokenType.IdentifierToken;
            end if;
         end if;
      end if;

      // scan Delimiter
      if nextIndex == startTokenIndex then
         token.string :=substring(string, startTokenIndex, startTokenIndex);
         token.tokenType := Types.TokenType.DelimiterToken;
         nextIndex := startTokenIndex + 1;
      end if;
    end if;
    annotation ( Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
(token, nextIndex) = Strings.<b>scanToken</b>(string, startIndex, unsigned=false);
</pre></blockquote>
<h4>Description</h4>
<p>
Function <b>scanToken</b> scans the string starting at index
\"startIndex\" and returns the next token, as well as the
index directly after the token. The returned token is a record
that holds the type of the token and the value of the token:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\">token.tokenType</td>
      <td valign=\"top\">Type of the token, see below</td></tr>
  <tr><td valign=\"top\">token.real</td>
      <td valign=\"top\">Real value if tokenType == TokenType.RealToken</td></tr>
  <tr><td valign=\"top\">token.integer</td>
      <td valign=\"top\">Integer value if tokenType == TokenType.IntegerToken</td></tr>
  <tr><td valign=\"top\">token.boolean</td>
      <td valign=\"top\">Boolean value if tokenType == TokenType.BooleanToken</td></tr>
  <tr><td valign=\"top\">token.string</td>
      <td valign=\"top\">String value if tokenType == TokenType.StringToken/IdentifierToken/DelimiterToken</td></tr>
</table>
<p>
Variable token.tokenType is an enumeration (emulated as a package
with constants) that can have the following values:
</p>
<pre>
   import T = Modelica.Utilities.Types.TokenType;
</pre>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\">T.RealToken</td>
      <td valign=\"top\">Modelica Real literal (e.g., 1.23e-4)</td></tr>
  <tr><td valign=\"top\">T.IntegerToken</td>
      <td valign=\"top\">Modelica Integer literal (e.g., 123)</td></tr>
  <tr><td valign=\"top\">T.BooleanToken</td>
      <td valign=\"top\">Modelica Boolean literal (e.g., false)</td></tr>
  <tr><td valign=\"top\">T.StringToken</td>
      <td valign=\"top\">Modelica String literal (e.g., \"string 123\")</td></tr>
  <tr><td valign=\"top\">T.IdentifierToken</td>
      <td valign=\"top\">Modelica identifier (e.g., \"force_a\")</td></tr>
  <tr><td valign=\"top\">T.DelimiterToken</td>
      <td valign=\"top\">any character without white space that does not appear<br>
          as first character in the tokens above (e.g., \"&\")</td></tr>
  <tr><td valign=\"top\">T.NoToken</td>
      <td valign=\"top\">White space, line comments and no other token<br>
          until the end of the string</td></tr>
</table>
<p>
Modelica line comments (\"// ... end-of-line/end-of-string\")
as well as white space is ignored.
If \"unsigned=true\", a Real or Integer literal
is not allowed to start with a \"+\" or \"-\" sign.
</p>
<h4>Example</h4>
<blockquote><pre>
  import Modelica.Utilities.Strings.*;
  import T = Modelica.Utilities.Types.TokenType;
  (token, index) := scanToken(string);
  <b>if</b> token.tokenType == T.RealToken <b>then</b>
     realValue := token.real;
  <b>elseif</b> token.tokenType == T.IntegerToken <b>then</b>
     integerValue := token.integer;
  <b>elseif</b> token.tokenType == T.BooleanToken<b> then</b>
     booleanValue := token.boolean;
  <b>elseif</b> token.tokenType == T.Identifier <b>then</b>
     name := token.string;
  <b>else</b>
     syntaxError(string,index,\"Expected Real, Integer, Boolean or identifier token\");
  <b>end if</b>;
</pre></blockquote>
</html>"));
  end scanToken;

  function scanReal
    "Scan for the next Real number and trigger an assert if not present"
    extends Modelica.Icons.Function;
    input String string "String to be scanned";
    input Integer startIndex(min=1)=1
      "Start scanning of string at character startIndex";
    input Boolean unsigned=false
      "= true, if Real token shall not start with a sign";
    input String message=""
      "Message used in error message if scan is not successful";
    output Real number "Value of real number";
    output Integer nextIndex "index of character after the found number";
  algorithm
    (nextIndex, number) :=Advanced.scanReal(string, startIndex, unsigned);
    if nextIndex == startIndex then
       nextIndex :=Advanced.skipWhiteSpace(string, startIndex);
       if unsigned then
          syntaxError(string, nextIndex, "Expected a Real number without a sign " + message);
       else
          syntaxError(string, nextIndex, "Expected a Real number " + message);
       end if;
    end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
             number = Strings.<b>scanReal</b>(string);
(number, nextIndex) = Strings.<b>scanReal</b>(string, startIndex=1,
                                            unsigned=false, message=\"\");
</pre></blockquote>
<h4>Description</h4>
<p>
The first form, \"scanReal(string)\", scans \"string\" for a
Real number with leading white space and returns the value.
</p>
<p>
The second form, \"scanReal(string,startIndex,unsigned)\",
scans the string starting at index
\"startIndex\", checks whether the next token is a Real literal
and returns its value as a Real number, as well as the
index directly after the Real number.
If the optional argument \"unsigned\" is <b>true</b>,
the real number shall not have a leading \"+\" or \"-\" sign.
</p>
<p>
If the required Real number with leading white space
is not present in \"string\",  an assert is triggered.
</p>
</html>"));
  end scanReal;

  function scanInteger
    "Scan for the next Integer number and trigger an assert if not present"
    extends Modelica.Icons.Function;
    input String string "String to be scanned";
    input Integer startIndex(min=1)=1
      "Start scanning of string at character startIndex";
    input Boolean unsigned=false
      "= true, if Integer token shall not start with a sign";
    input String message=""
      "Message used in error message if scan is not successful";
    output Integer number "Value of Integer number";
    output Integer nextIndex "Index of character after the found number";
  algorithm
    (nextIndex, number) :=Advanced.scanInteger(string, startIndex, unsigned);
    if nextIndex == startIndex then
       nextIndex :=Advanced.skipWhiteSpace(string, startIndex);
       if unsigned then
          syntaxError(string, nextIndex, "Expected an Integer number without a sign " + message);
       else
          syntaxError(string, nextIndex, "Expected an Integer number " + message);
       end if;
    end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
             number = Strings.<b>scanInteger</b>(string);
(number, nextIndex) = Strings.<b>scanInteger</b>(string, startIndex=1,
                                               unsigned=false, message=\"\");
</pre></blockquote>
<h4>Description</h4>
<p>
Function <b>scanInteger</b> scans the string starting at index
\"startIndex\", checks whether the next token is an Integer literal
and returns its value as an Integer number, as well as the
index directly after the Integer number. An assert is triggered,
if the scanned string does not contain an Integer literal with optional
leading white space.
</p>
</html>"));
  end scanInteger;

  function scanBoolean
    "Scan for the next Boolean number and trigger an assert if not present"
    extends Modelica.Icons.Function;
    input String string "String to be scanned";
    input Integer startIndex(min=1)=1
      "Start scanning of string at character startIndex";
    input String message=""
      "Message used in error message if scan is not successful";
    output Boolean number "Value of Boolean";
    output Integer nextIndex "Index of character after the found number";
  protected
    String identifier;
  algorithm
    (nextIndex, identifier) :=Advanced.scanIdentifier(string, startIndex);

    if nextIndex > startIndex then
       if identifier == "false" then
          number := false;
       elseif identifier == "true" then
          number := true;
       else
          nextIndex := startIndex;
       end if;
    end if;

    if nextIndex == startIndex then
       nextIndex :=Advanced.skipWhiteSpace(string, startIndex);
       syntaxError(string, nextIndex,
         "Expected a Boolean constant, i.e., \"false\" or \"true\" " + message);
    end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
             number = Strings.<b>scanBoolean</b>(string);
(number, nextIndex) = Strings.<b>scanBoolean</b>(string, startIndex=1, message=\"\");
</pre></blockquote>
<h4>Description</h4>
<p>
Function <b>scanBoolean</b> scans the string starting at index
\"startIndex\", checks whether the next token is a Boolean literal
(i.e., is either the string \"false\" or \"true\", if converted to lower case letters)
and returns its value as a Boolean number, as well as the
index directly after the Boolean number. An assert is triggered,
if the scanned string does not contain a Boolean literal with optional
leading white space.
</p>
</html>"));
  end scanBoolean;

  function scanString
    "Scan for the next Modelica string and trigger an assert if not present"
    extends Modelica.Icons.Function;
    input String string "String to be scanned";
    input Integer startIndex(min=1)=1
      "Start scanning of string at character startIndex";
    input String message=""
      "Message used in error message if scan is not successful";
    output String result "Value of string";
    output Integer nextIndex "Index of character after the found string";
  algorithm
    (nextIndex, result) :=Advanced.scanString(string, startIndex);
    if nextIndex == startIndex then
       nextIndex :=Advanced.skipWhiteSpace(string, startIndex);
       syntaxError(string, nextIndex, "Expected a string enclosed in double quotes " + message);
    end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
             string2 = Strings.<b>scanString</b>(string);
(string2, nextIndex) = Strings.<b>scanString</b>(string, startIndex=1, message=\"\");
</pre></blockquote>
<h4>Description</h4>
<p>
Function <b>scanString</b> scans the string starting at index
\"startIndex\", checks whether the next token is a String literal
and returns its value as a String, as well as the
index directly after the String. An assert is triggered,
if the scanned string does not contain a String literal with optional
leading white space.
</p>
</html>"));
  end scanString;

  function scanIdentifier
    "Scan for the next Identifier and trigger an assert if not present"
    extends Modelica.Icons.Function;
    input String string "String to be scanned";
    input Integer startIndex(min=1)=1
      "Start scanning of identifier at character startIndex";
    input String message=""
      "Message used in error message if scan is not successful";
    output String identifier "Value of Identifier";
    output Integer nextIndex "Index of character after the found identifier";
  algorithm
    (nextIndex, identifier) :=Advanced.scanIdentifier(string, startIndex);
    if nextIndex == startIndex then
       nextIndex :=Advanced.skipWhiteSpace(string, startIndex);
       syntaxError(string, nextIndex, "Expected an identifier " + message);
    end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
             identifier = Strings.<b>scanIdentifier</b>(string);
(identifier, nextIndex) = Strings.<b>scanIdentifier</b>(string, startIndex=1, message=\"\");
</pre></blockquote>
<h4>Description</h4>
<p>
Function <b>scanIdentifier</b> scans the string starting at index
\"startIndex\", checks whether the next token is an Identifier
and returns its value as a string, as well as the
index directly after the Identifier. An assert is triggered,
if the scanned string does not contain an Identifier with optional
leading white space.
</p>
</html>"));
  end scanIdentifier;

  function scanDelimiter
    "Scan for the next delimiter and trigger an assert if not present"
    extends Modelica.Icons.Function;
    input String string "String to be scanned";
    input Integer startIndex(min=1)=1
      "Start scanning of delimiters at character startIndex";
    input String requiredDelimiters[:]={","} "Delimiters that are searched";
    input String message=""
      "Message used in error message if scan is not successful";
    output String delimiter "Found delimiter";
    output Integer nextIndex "Index of character after the found delimiter";
  protected
    Integer lenString = length(string);
    Integer lenDelimiter;
    Integer nDelimiters = size(requiredDelimiters,1);
    Integer endIndex;
    Boolean found;
    Integer i;

    encapsulated function concatenate "Concatenate strings together"
       input String strings[:];
       output String string;
    algorithm
       string := "{\"";
       for i in 1:size(strings,1) loop
          if i == 1 then
             string := "{\"" + strings[1] + "\"";
          else
             string := string + ", \"" + strings[i] + "\"";
          end if;
       end for;
       string := string + "}";
    end concatenate;
  algorithm
    nextIndex := Advanced.skipLineComments(string,startIndex);
    found := false;
    i := 1;
    while not found and i <= nDelimiters loop
       lenDelimiter :=length(requiredDelimiters[i]);
       if lenDelimiter == 0 then
          found := true;
          delimiter := "";
       else
          endIndex :=nextIndex + lenDelimiter - 1;
          if endIndex <= lenString then
             if substring(string,nextIndex,endIndex) == requiredDelimiters[i] then
                found := true;
                delimiter := requiredDelimiters[i];
             end if;
          end if;
          i := i + 1;
       end if;
    end while;

    if found then
        nextIndex := nextIndex + lenDelimiter;
    else
       if size(requiredDelimiters,1) == 1 then
          syntaxError(string, nextIndex, "Expected delimiter \"" + requiredDelimiters[1] + "\"\n" + message);
       else
          syntaxError(string, nextIndex, "Expected a delimiter out of " +
                      concatenate(requiredDelimiters) + "\n" + message);
       end if;
    end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
             delimiter = Strings.<b>scanDelimiter</b>(string);
(delimiter, nextIndex) = Strings.<b>scanDelimiter</b>(string, startIndex=1,
                                 requiredDelimiters={\",\"}, message=\"\");
</pre></blockquote>
<h4>Description</h4>
<p>
Function <b>scanDelimiter</b> scans the string starting at index
\"startIndex\", checks whether the next token is a delimiter string
and returns its value as a string, as well as the
index directly after the delimiter. An assert is triggered,
if the scanned string does not contain a delimiter out of the
list of requiredDelimiters. Input argument requiredDelimiters is a vector
of strings. The elements may have any length, including length 0.
If an element of the requiredDelimiters is zero, white space
is treated as delimiter. The function returns delimiter=\"\" and nextIndex
is the index of the first non white space character.
</p>
</html>"));
  end scanDelimiter;

  function scanNoToken "Scan string and check that it contains no more token"
    extends Modelica.Icons.Function;
    input String string "String to be scanned";
    input Integer startIndex(min=1)=1
      "Start scanning of string at character startIndex";
    input String message=""
      "Message used in error message if scan is not successful";
  protected
    Integer nextIndex;
  algorithm
    nextIndex :=Advanced.skipLineComments(string, startIndex);
    if nextIndex <= length(string) then
       syntaxError(string, nextIndex, "Expected no more token " + message);
    end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Strings.<b>scanNoToken</b>(string, startIndex=1, message=\"\");
</pre></blockquote>
<h4>Description</h4>
<p>
Function <b>scanNoToken</b> scans the string starting at index
\"startIndex\" and checks whether there is no more token in the
string. An assert is triggered if this is not the case,
using the \"message\" argument as additional explanation in
the error text.
</p>
</html>"));
  end scanNoToken;

  function syntaxError
    "Print an error message, a string and the index at which scanning detected an error"
    extends Modelica.Icons.Function;
    input String string "String that has an error at position index";
    input Integer index "Index of string at which scanning detected an error";
    input String message="" "String printed at end of error message";

  protected
    Integer maxIndex = 40;
    Integer maxLenString = 60;
    Integer lenString = length(string);
    String errString;
    Integer index2 = if index < 1 then 1 else if index > lenString then lenString else index;
  algorithm
  // if "string" is too long, skip part of the string when printing it
     if index2 <= maxIndex then
       errString := string;
     else
       errString := "... " + substring(string, index2-maxIndex, lenString);
       index2 := maxIndex + 5; // To mark right position
     end if;

     if length(errString) > maxLenString then
        errString := substring(errString, 1, maxLenString) + " ...";
     end if;

  // Print error message
     Streams.error("Syntax error at character " + String(index) + " of\n" +
                   errString + "\n" +
                   repeat(index2-1, " ") + "*" + "\n" +
                   message);
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Strings.<b>syntaxError</b>(string, index, message);
</pre></blockquote>
<h4>Description</h4>
<p>
Function <b>syntaxError</b> prints an error message in the
following form:
</p>
<pre>
   Syntax error at column &lt;index&gt; of
   &lt;string&gt;
       ^       // shows character that is wrong
   &lt;message&gt;
</pre>
<p>
where the strings withing &lt;..&gt; are the actual values of the
input arguments of the function.
</p>
<p>
If the given string is too long, only a relevant
part of the string is printed.
</p>
</html>"));
  end syntaxError;

  package Advanced "Advanced scanning functions"

    function scanReal "Scans a signed real number"
      extends Modelica.Icons.Function;
      input String string;
      input Integer startIndex(min=1)=1 "Index where scanning starts";
      input Boolean unsigned=false
        "= true, if number shall not start with '+' or '-'";
      output Integer nextIndex
        "Index after the found token (success=true) or index at which scanning failed (success=false)";
      output Real number "Value of Real number";
      external "C" ModelicaStrings_scanReal(string, startIndex, unsigned, nextIndex, number);
      annotation (Library="ModelicaExternalC",Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
(nextIndex, realNumber) = <b>scanReal</b>(string, startIndex=1, unsigned=false);
</pre></blockquote>
<h4>Description</h4>
<p>
Starts scanning of \"string\" at position \"startIndex\".
First skips white space and scans afterwards a number
of type Real with an optional sign according to the Modelica grammar:
</p>
<pre>
    real     ::= [sign] unsigned [fraction] [exponent]
    sign     ::= '+' | '-'
    unsigned ::= digit [unsigned]
    fraction ::= '.' [unsigned]
    exponent ::= ('e' | 'E') [sign] unsigned
    digit    ::= '0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'
</pre>
<p>
If successful, the function returns nextIndex = index of character
directly after the found real number, as well as the value
in the second output argument.
</p>
<p>
If not successful, on return nextIndex = startIndex and
the second output argument is zero.
</p>
<p>
If the optional argument \"unsigned\" is <b>true</b>, the number
shall not start with '+' or '-'. The default of \"unsigned\" is <b>false</b>.
</p>
<h4>See also</h4>
<a href=\"modelica://Modelica.Utilities.Strings.Advanced\">Strings.Advanced</a>.
</html>
"));
    end scanReal;

    function scanInteger "Scans signed integer number"
      extends Modelica.Icons.Function;
      input String string;
      input Integer startIndex(min=1)=1;
      input Boolean unsigned=false
        "= true, if number shall not start with '+' or '-'";
      output Integer nextIndex
        "Index after the found token (success=true) or index at which scanning failed (success=false)";
      output Integer number "Value of Integer number";
      external "C" ModelicaStrings_scanInteger(string, startIndex, unsigned, nextIndex, number);
      annotation (Library="ModelicaExternalC",Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
(nextIndex, integerNumber) = <b>scanInteger</b>(string, startIndex=1, unsigned=false);
</pre></blockquote>
<h4>Description</h4>
<p>
Starts scanning of \"string\" at position \"startIndex\".
First skips white space and scans afterwards a signed number
of type Integer. An Integer starts with an optional '+'
or '-', immediately
followed by a non-empty sequence of digits.
</p>
<p>
If successful, the function returns nextIndex = index of character
directly after the found Integer number, as well as the Integer value
in the second output argument.
</p>
<p>
If not successful, on return nextIndex = startIndex and
the second output argument is zero.
</p>
<p>
Note, a Real number, such as \"123.4\", is not treated
as an Integer number and scanInteger will return
nextIndex = startIndex in this case.
</p>
<p>
If the optional argument \"unsigned\" is <b>true</b>, the number
shall not start with '+' or '-'. The default of \"unsigned\" is <b>false</b>.
</p>
<h4>See also</h4>
<a href=\"modelica://Modelica.Utilities.Strings.Advanced\">Strings.Advanced</a>.
</html>
"));
    end scanInteger;

    function scanString "Scan string"
      extends Modelica.Icons.Function;
      input String string;
      input Integer startIndex(min=1)=1 "Index where scanning starts";
      output Integer nextIndex
        "Index after the found token (success=true) or index at which scanning failed (success=false)";
      output String string2 "Value of String token";
      external "C" ModelicaStrings_scanString(string, startIndex, nextIndex, string2);
      annotation (Library="ModelicaExternalC",Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
(nextIndex, string2) = <b>scanString</b>(string, startIndex=1);
</pre></blockquote>
<h4>Description</h4>
<p>
Starts scanning of \"string\" at position \"startIndex\".
First skips white space and scans afterwards a string
according to the Modelica grammar, i.e., a string
enclosed in double quotes.
</p>
<p>
If successful, the function returns nextIndex = index of character
directly after the found string, as well as the string value
in the second output argument.
</p>
<p>
If not successful, on return nextIndex = startIndex and
the second output argument is an empty string.
</p>
<h4>See also</h4>
<a href=\"modelica://Modelica.Utilities.Strings.Advanced\">Strings.Advanced</a>.
</html>
"));
    end scanString;

    function scanIdentifier "Scans simple identifiers"
      extends Modelica.Icons.Function;
      input String string;
      input Integer startIndex(min=1)=1 "Index where scanning starts";
      output Integer nextIndex
        "Index after the found token (success=true) or index at which scanning failed (success=false)";
      output String identifier "Value of identifier token";
      external "C" ModelicaStrings_scanIdentifier(string, startIndex, nextIndex, identifier);

      annotation (Library="ModelicaExternalC",Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
(nextIndex, identifier) = <b>scanIdentifier</b>(string, startIndex=1);
</pre></blockquote>
<h4>Description</h4>
<p>
Starts scanning of \"string\" at position \"startIndex\".
First skips white space and scans afterwards a Modelica
identifier, i.e., a sequence of characters starting with
a letter (\"a\"..\"z\" or \"A\"..\"Z\") followed by letters,
digits or underscores (\"_\").
</p>
<p>
If successful, the function returns nextIndex = index of character
directly after the found identifier, as well as the identifier
as string in the second output argument.
</p>
<p>
If not successful, on return nextIndex = startIndex and
the second output argument is an empty string.
</p>
<h4>See also</h4>
<a href=\"modelica://Modelica.Utilities.Strings.Advanced\">Strings.Advanced</a>.
</html>
"));
    end scanIdentifier;

    function skipWhiteSpace "Scans white space"
      extends Modelica.Icons.Function;
      input String string;
      input Integer startIndex(min=1)=1;
      output Integer nextIndex;
      external "C" nextIndex = ModelicaStrings_skipWhiteSpace(string, startIndex);
      annotation (Library="ModelicaExternalC",Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
nextIndex = <b>skipWhiteSpace</b>(string, startIndex);
</pre></blockquote>
<h4>Description</h4>
<p>
Starts scanning of \"string\" at position \"startIndex\" and
skips white space. The function returns nextIndex = index of character
of the first non white space character.
</p>
<h4>See also</h4>
<a href=\"modelica://Modelica.Utilities.Strings.Advanced\">Strings.Advanced</a>.
</html>
"));
    end skipWhiteSpace;

    function skipLineComments "Scans comments and white space"
      extends Modelica.Icons.Function;
      input String string;
      input Integer startIndex(min=1)=1;
      output Integer nextIndex;
    protected
      Integer lenString = length(string);
      Boolean scanning;
      Boolean lineComment;
    algorithm
      nextIndex := startIndex;
      scanning := true;
      while scanning loop
         nextIndex := Advanced.skipWhiteSpace(string, nextIndex);
         if nextIndex+1 <= lenString then
            if substring(string,nextIndex,nextIndex+1) == "//" then
               // search end of line comment
               nextIndex := nextIndex + 2;
               if nextIndex <= lenString then
                  lineComment := true;
                  while lineComment loop
                     if substring(string,nextIndex,nextIndex) == "\n" then
                        lineComment := false;
                     end if;
                     nextIndex := nextIndex + 1;
                     if nextIndex > lenString then
                        lineComment := false;
                        scanning := false;
                     end if;
                  end while;
               else
                  scanning := false;
               end if;
            else
               scanning := false;
            end if;
         else
            scanning := false;
         end if;
      end while;
      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
nextIndex = <b>skipLineComments</b>(string, startIndex);
</pre></blockquote>
<h4>Description</h4>
<p>
Starts scanning of \"string\" at position \"startIndex\".
First skips white space and scans afterwards a Modelica (C/C++)
line comment, i.e., a sequence of characters that
starts with \"//\" and ends with an end-of-line \"\\n\" or
with the end of the string. If end-of-line is reached,
the function continues to skip white space and
scanning of line comments until end-of-string is
reached, or another token is detected.
</p>
<p>
If successful, the function returns nextIndex = index of character
directly after the found line comment.
</p>
<p>
If not successful, on return nextIndex = startIndex.
</p>
<h4>See also</h4>
<a href=\"modelica://Modelica.Utilities.Strings.Advanced\">Strings.Advanced</a>.
</html>
"));
    end skipLineComments;
    annotation (Documentation(info="<html>
<h4>Library content</h4>
<p>
Package <b>Strings.Advanced</b> contains basic scanning
functions. These functions should be <b>not called</b> directly, because
it is much simpler to utilize the higher level functions \"Strings.scanXXX\".
The functions of the \"Strings.Advanced\" library provide
the basic interface in order to implement the higher level
functions in package \"Strings\".
</p>
<p>
Library \"Advanced\" provides the following functions:
</p>
<pre>
  (nextIndex, realNumber)    = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanReal\">scanReal</a>        (string, startIndex, unsigned=false);
  (nextIndex, integerNumber) = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanInteger\">scanInteger</a>     (string, startIndex, unsigned=false);
  (nextIndex, string2)       = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanString\">scanString</a>      (string, startIndex);
  (nextIndex, identifier)    = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanIdentifier\">scanIdentifier</a>  (string, startIndex);
   nextIndex                 = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.skipWhiteSpace\">skipWhiteSpace</a>  (string, startIndex);
   nextIndex                 = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.skipLineComments\">skipLineComments</a>(string, startIndex);
</pre>
<p>
All functions perform the following actions:
</p>
<ol>
<li> Scanning starts at character position \"startIndex\" of
     \"string\" (startIndex has a default of 1).
<li> First, white space is skipped, such as blanks (\" \"), tabs (\"\\t\"), or newline (\"\\n\")</li>
<li> Afterwards, the required token is scanned.</li>
<li> If successful, on return nextIndex = index of character
     directly after the found token and the token value is returned
     as second output argument.<br>
     If not successful, on return nextIndex = startIndex.
     </li>
</ol>
<p>
The following additional rules apply for the scanning:
</p>
<ul>
<li> Function <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanReal\">scanReal</a>:<br>
     Scans a full number including one optional leading \"+\" or \"-\" (if unsigned=false)
     according to the Modelica grammar. For example, \"+1.23e-5\", \"0.123\" are
     Real numbers, but \".1\" is not.
     Note, an Integer number, such as \"123\" is also treated as a Real number.<br>&nbsp;</li>
<li> Function <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanInteger\">scanInteger</a>:<br>
     Scans an Integer number including one optional leading \"+\"
     or \"-\" (if unsigned=false) according to the Modelica (and C/C++) grammar.
     For example, \"+123\", \"20\" are Integer numbers.
     Note, a Real number, such as \"123.4\" is not an Integer and
     scanInteger returns nextIndex = startIndex.<br>&nbsp;</li>
<li> Function <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanString\">scanString</a>:<br>
     Scans a String according to the Modelica (and C/C++) grammar, e.g.,
     \"This is a \"string\"\" is a valid string token.<br>&nbsp;</li>
<li> Function <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanIdentifier\">scanIdentifier</a>:<br>
     Scans a Modelica identifier, i.e., the identifier starts either
     with a letter, followed by letters, digits or \"_\".
     For example, \"w_rel\", \"T12\".<br>&nbsp;</li>
<li> Function <a href=\"modelica://Modelica.Utilities.Strings.Advanced.skipLineComments\">skipLineComments</a><br>
     Skips white space and Modelica (C/C++) line comments iteratively.
     A line comment starts with \"//\" and ends either with an
     end-of-line (\"\\n\") or the end of the \"string\". </li>
</ul>
</html>
"));
  end Advanced;
  annotation (
    Documentation(info="<HTML>
<h4>Library content</h4>
<p>
Package <b>Strings</b> contains functions to manipulate strings.
</p>
<p>
In the table below an example
call to every function is given using the <b>default</b> options.
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Function</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td valign=\"top\">len = <a href=\"modelica://Modelica.Utilities.Strings.length\">length</a>(string)</td>
      <td valign=\"top\">Returns length of string</td></tr>
  <tr><td valign=\"top\">string2 = <a href=\"modelica://Modelica.Utilities.Strings.substring\">substring</a>(string1,startIndex,endIndex)
       </td>
      <td valign=\"top\">Returns a substring defined by start and end index</td></tr>
  <tr><td valign=\"top\">result = <a href=\"modelica://Modelica.Utilities.Strings.repeat\">repeat</a>(n)<br>
 result = <a href=\"modelica://Modelica.Utilities.Strings.repeat\">repeat</a>(n,string)</td>
      <td valign=\"top\">Repeat a blank or a string n times.</td></tr>
  <tr><td valign=\"top\">result = <a href=\"modelica://Modelica.Utilities.Strings.compare\">compare</a>(string1, string2)</td>
      <td valign=\"top\">Compares two substrings with regards to alphabetical order</td></tr>
  <tr><td valign=\"top\">identical =
<a href=\"modelica://Modelica.Utilities.Strings.isEqual\">isEqual</a>(string1,string2)</td>
      <td valign=\"top\">Determine whether two strings are identical</td></tr>
  <tr><td valign=\"top\">result = <a href=\"modelica://Modelica.Utilities.Strings.count\">count</a>(string,searchString)</td>
      <td valign=\"top\">Count the number of occurrences of a string</td></tr>
  <tr>
<td valign=\"top\">index = <a href=\"modelica://Modelica.Utilities.Strings.find\">find</a>(string,searchString)</td>
      <td valign=\"top\">Find first occurrence of a string in another string</td></tr>
<tr>
<td valign=\"top\">index = <a href=\"modelica://Modelica.Utilities.Strings.findLast\">findLast</a>(string,searchString)</td>
      <td valign=\"top\">Find last occurrence of a string in another string</td></tr>
  <tr><td valign=\"top\">string2 = <a href=\"modelica://Modelica.Utilities.Strings.replace\">replace</a>(string,searchString,replaceString)</td>
      <td valign=\"top\">Replace one or all occurrences of a string</td></tr>
  <tr><td valign=\"top\">stringVector2 = <a href=\"modelica://Modelica.Utilities.Strings.sort\">sort</a>(stringVector1)</td>
      <td valign=\"top\">Sort vector of strings in alphabetic order</td></tr>
  <tr><td valign=\"top\">(token, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanToken\">scanToken</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for a token (Real/Integer/Boolean/String/Identifier/Delimiter/NoToken)</td></tr>
  <tr><td valign=\"top\">(number, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanReal\">scanReal</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for a Real constant</td></tr>
  <tr><td valign=\"top\">(number, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanInteger\">scanInteger</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for an Integer constant</td></tr>
  <tr><td valign=\"top\">(boolean, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanBoolean\">scanBoolean</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for a Boolean constant</td></tr>
  <tr><td valign=\"top\">(string2, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanString\">scanString</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for a String constant</td></tr>
  <tr><td valign=\"top\">(identifier, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanIdentifier\">scanIdentifier</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for an identifier</td></tr>
  <tr><td valign=\"top\">(delimiter, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanDelimiter\">scanDelimiter</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for delimiters</td></tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Strings.scanNoToken\">scanNoToken</a>(string,startIndex)</td>
      <td valign=\"top\">Check that remaining part of string consists solely of <br>
          white space or line comments (\"// ...\\n\").</td></tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Strings.syntaxError\">syntaxError</a>(string,index,message)</td>
      <td valign=\"top\"> Print a \"syntax error message\" as well as a string and the <br>
           index at which scanning detected an error</td></tr>
</table>
<p>
The functions \"compare\", \"isEqual\", \"count\", \"find\", \"findLast\", \"replace\", \"sort\"
have the optional
input argument <b>caseSensitive</b> with default <b>true</b>.
If <b>false</b>, the operation is carried out without taking
into account whether a character is upper or lower case.
</p>
</HTML>"));
end Strings;
