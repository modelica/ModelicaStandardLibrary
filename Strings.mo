package Strings "Operations on strings" 
  extends Modelica.Icons.Library;
  
  annotation (
  version="0.9.1",
  versionDate="2004-08-21",
  preferedView="info",
    Documentation(info="<HTML>
<h3><font color=\"#008000\">Library content</font></h3>
<p>
Package <b>Strings</b> contains functions to manipulate strings.
In the table below a link to the function definition
and an example for every function call is given.
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Function</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td><a href=\"Modelica:Modelica.Strings.character\">character</a>(str,index)</td>
      <td>Returns the character at the specified index</td></tr>
  <tr><td><a href=\"Modelica:Modelica.Strings.count\">count</a>(str,searchStr,caseSensitive=true)</td>
      <td>Count the number of occurrences of a string</td></tr>
  <tr><td><a href=\"Modelica:Modelica.Strings.find\">find</a>(str,searchStr,caseSensitive=true,startIndex=1)</td>
      <td>Find first occurrence of a string in another string</td></tr>
  <tr><td><a href=\"Modelica:Modelica.Strings.isEmpty\">isEmpty</a>(str)</td>
      <td>Return true, if empty string (no characters)</td></tr>
  <tr><td><a href=\"Modelica:Modelica.Strings.isEqual\">isEqual</a>(str1,str2,caseSensitive=true)</td>
      <td>Determine whether two strings are identical</td></tr>
  <tr><td><a href=\"Modelica:Modelica.Strings.length\">length</a>(str)</td>
      <td>Returns length of string</td></tr>
  <tr><td><a href=\"Modelica:Modelica.Strings.repeat\">repeat</a>(n,string=\" \")</td>
      <td>Generate string n times</td></tr>
  <tr><td><a href=\"Modelica:Modelica.Strings.replace\">replace</a>(str,searchStr,replaceStr,caseSensitive=true,<br>
      startIndex=1, replaceAll=true)</td>  
      <td>Replace one or all occurrences of a string</td></tr>
  <tr><td><a href=\"Modelica:Modelica.Strings.substring\">substring</a>(str,index,length=Inf)</td>
      <td>Returns a substring defined by start index and number of characters</td></tr>
  <tr><td><a href=\"Modelica:Modelica.Strings.toLower\">toLower</a>(str)</td>
      <td>Convert string to lower case</td></tr>
  <tr><td><a href=\"Modelica:Modelica.Strings.toUpper\">toUpper</a>(str)</td>
      <td>Convert string to upper case</td></tr>
</table>
<p>
The functions \"count\", \"find\", \"isEqual\", \"replace\" have the optional
input argument <b>caseSensitive</b> with default <b>true</b>. 
If <b>false</b>, the operation is carried out without taking
into account whether a character is upper or lower case.
</p>
</HTML>
"), uses(Modelica(version="1.6")));
  
  function character "Returns the character at the specified index" 
    extends Modelica.Icons.Function;
    input String string1 "String from which a character is inquired";
    input Integer index(min=1) 
      "Character position (index=1 is first character in string1)";
    output String string2 
      "String containing the character of string1 at position index (if index is out of range, an empty string is returned)";
  external "C" string2=  ModelicaStrings_character(string1, index);
    annotation (  preferedView="info",
  Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>

<blockquote><pre>
Strings.<b>character</b>(string1, index);
</pre></blockquote>

<h3><font color=\"#008000\">Description</font></h3>
<p>
Returns the string containing the character of string1 at 
position index (if index is out of range, an empty 
string is returned).
</p>

</html>"));
  end character;
  
  function count "Count the number of non-overlapping occurrences of a string" 
    extends Modelica.Icons.Function;
    input String string;
    input String searchString;
    input Boolean caseSensitive=true 
      "= false, if lower and upper case are ignored for count";
    input Integer startIndex(min=1)=1 "Start search at index startIndex";
    output Integer result "Number of occurrences of 'searchString' in 'string'";
  external "C" result=  ModelicaStrings_count(string, searchString, caseSensitive, startIndex);
    annotation (  preferedView="info",
  Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Strings.<b>count</b>(string, searchString)
Strings.<b>count</b>(string, searchString, caseSensitive=true, startIndex=1)
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
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
    input String searchString "String that is searched in string";
    input Boolean caseSensitive=true 
      "= false, if lower and upper case are ignored for the search";
    input Integer startIndex(min=1)=1 "Start search at index startIndex";
    output Integer index 
      "Index of first occurrence of 'searchString' within 'string' or zero if not present";
  external "C" index=  ModelicaStrings_find(string, searchString, caseSensitive, startIndex);
    annotation (  preferedView="info",
  Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Strings.<b>find</b>(string, searchString);
Strings.<b>find</b>(string, searchString, caseSensitive=true, startIndex=1);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
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
  
  function isEmpty "Return true, if string is empty (i.e., has no characters)" 
    extends Modelica.Icons.Function;
    input String string "String to be analysed";
    output Boolean result 
      "= true, if string is empty, i.e., length(string) == 0 ";
  external "C" result=  ModelicaStrings_isEmpty(string);
    annotation (  preferedView="info",
  Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Strings.<b>isEmpty</b>(string);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
</p>
</html>"));
  end isEmpty;
  
  function isEqual "Determine whether two strings are identical" 
    extends Modelica.Icons.Function;
    input String string1;
    input String string2;
    input Boolean caseSensitive=true 
      "= false, if lower and upper case are ignored for the comparison";
    output Boolean identical "True, if string1 is identical to string2";
  external "C" identical=  ModelicaStrings_isEqual(string1, string2, caseSensitive);
    annotation (  preferedView="info",
  Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Strings.<b>isEqual</b>(string1, string2);
Strings.<b>isEqual</b>(string1, string2, caseSensitive=true);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
</p>
</html>"));
  end isEqual;
  
  function length "Returns length of string" 
    extends Modelica.Icons.Function;
    input String string;
    output Integer result "Number of characters of string";
  external "C" result=  strlen(string);
    annotation (  preferedView="info",
  Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Strings.<b>length</b>(string);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
</p>
</html>"));
  end length;
  
  function repeat "Generate string n times" 
    extends Modelica.Icons.Function;
    input Integer n(min=0) = 1 "Number of occurences";
    input String string=" " "String that is repeated";
    output String repeatedString "String containing n concatenated strings";
  external "C" repeatedString=  ModelicaStrings_repeat(n,string);
    annotation (  preferedView="info",
  Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Strings.<b>repeat</b>(n, string=\" \");
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
</p>
</html>"));
  end repeat;
  
  function replace 
    "Replace all non-overlapping occurrences of a string from left to right" 
    
    extends Modelica.Icons.Function;
    input String string "String to be modified";
    input String searchString 
      "Replace all non-overlapping occurrences of 'searchString' in 'string' with 'replaceString'";
    input String replaceString 
      "String that replaces 'searchString' in 'string'";
    input Boolean caseSensitive=true 
      "= false, if lower and upper case are ignored when searching for searchString";
    input Integer startIndex=1 "Start search at index startIndex";
    input Boolean replaceAll=true "if false, replace only the first occurence";
    output String result "Result of replacement operation";
  external "C" result=  ModelicaStrings_replace(string, searchString,
      replaceString, caseSensitive);
    annotation (  preferedView="info",
  Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Strings.<b>replace</b>(string, searchString, replaceString);
Strings.<b>replace</b>(string, searchString, replaceString,
                caseSensitive=true, startIndex=1, replaceAll=true);
</pre></blockquote>

<h3><font color=\"#008000\">Description</font></h3>
<p>
</p>
<p>
The optional arguments startIndex and replaceAll are not yet supported.
</p>
</html>"));
  end replace;
  
  function substring 
    "Returns a substring defined by start index and number of characters" 
    
    extends Modelica.Icons.Function;
    input String string "String from which a substring is inquired";
    input Integer index(min=1) 
      "Character position of substring begin (index=1 is first character in string)";
    input Integer length=Modelica.Constants.Integer_inf 
      "Maximum number of characters to include in substring";
    output String substring 
      "String containing substring string(index:index+length-1), or less characters if string end reached, or empty string if index is out of range";
  external "C" substring=  ModelicaStrings_substring(string, index, length);
    annotation (  preferedView="info",
  Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Strings.<b>substring</b>(string, index)
Strings.<b>substring</b>(string, index, length=Modelica.Constants.Integer_inf);
</pre></blockquote>

<h3><font color=\"#008000\">Description</font></h3>
<p>
</p>
</html>"));
  end substring;
  
  function toLower 
    "Convert string to lower case (all other characters are preserved)" 
    
    extends Modelica.Icons.Function;
    input String string1 "input string";
    output String string2 
      "All upper case letters of string1 transformed to lower case";
  external "C" string2=  ModelicaStrings_toLower(string1);
    annotation (  preferedView="info",
  Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Strings.<b>toLower</b>(string1);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
</p>
</html>"));
  end toLower;
  
  function toUpper 
    "Convert string to upper case (all other characters are preserved)" 
    
    extends Modelica.Icons.Function;
    input String string1 "input string";
    output String string2 
      "all lower case letters of string1 transformed to upper case";
  external "C" string2=  ModelicaStrings_toUpper(string1);
    annotation (  preferedView="info",
  Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Strings.<b>toUpper</b>(string2);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
</p>
</html>"));
  end toUpper;
  
end Strings;
