within Modelica.Utilities;
package Types "Type definitions used in package Modelica.Utilities" 
  package Compare 
    "Type and constants to compare two strings, as temporary solution until enumerations are available" 
    
    extends Modelica.Icons.Enumeration;
    constant Integer Less=1;
    constant Integer Equal=2;
    constant Integer Greater=3;
    type Type = Integer;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
<b>TokenType</b>.Temp tokenType = TokenType.<b>RealToken</b>;
</pre></blockquote>
<h4>Description</h4>
<p>
Package <b>TokenType</b> is an emulation of the following enumeration
</p>
<pre>
   enumeration TokenType = {RealToken, IntegerToken, BooleanToken,
                            StringToken, IdentifierToken, DelimiterToken,
                            NoToken);
</pre>
<p>
since enumerations are not yet supported in available
Modelica tools.
</p>
</html>"));
  end Compare;
  
  package FileType 
    "Type and constants to describe the type of a file, as temporary solution until enumerations are available" 
    
    extends Modelica.Icons.Enumeration;
    constant Integer NoFile=1 "no file exists";
    constant Integer RegularFile=2 "regular file";
    constant Integer Directory=3 "directory";
    constant Integer SpecialFile=4 "pipe, FIFO, device, etc.";
    
    type Type = Integer;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
<b>FileType</b>.Type fileType = FileType.<b>RegularFile</b>;
</pre></blockquote>
<h4>Description</h4>
<p>
Package <b>FileType</b> is an emulation of the following enumeration
</p>
<pre>
   enumeration FileType = {NoFile, RegularFile, Directory, SpecialFile};
</pre>
<p>
since enumerations are not yet supported in available
Modelica tools.
</p>
</html>"));
  end FileType;
  
  package TokenType 
    "Type and constants for token types, as temporary solution until enumerations are available" 
    
    extends Modelica.Icons.Enumeration;
    constant Integer RealToken=1;
    constant Integer IntegerToken=2;
    constant Integer BooleanToken=3;
    constant Integer StringToken=4;
    constant Integer IdentifierToken=5;
    constant Integer DelimiterToken=6;
    constant Integer NoToken=7;
    
    type Type = Integer;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
<b>TokenType</b>.Temp tokenType = TokenType.<b>RealToken</b>;
</pre></blockquote>
<h4>Description</h4>
<p>
Package <b>TokenType</b> is an emulation of the following enumeration
</p>
<pre>
   enumeration TokenType = {RealToken, IntegerToken, BooleanToken,
                            StringToken, IdentifierToken, DelimiterToken,
                            NoToken);
</pre>
<p>
since enumerations are not yet supported in available
Modelica tools.
</p>
</html>"));
  end TokenType;
  
  record TokenValue "Value of token" 
     extends Modelica.Icons.Record;
     TokenType.Type tokenType "Type of token";
     Real real "Value if tokenType == TokenType.RealToken";
     Integer integer "Value if tokenType == TokenType.IntegerToken";
     Boolean boolean "Value if tokenType == TokenType.BooleanToken";
     String string 
      "Value if tokenType == TokenType.StringToken/IdentifierToken/DelimiterToken";
    annotation (Documentation(info="<html>
   
</html>"));
  end TokenValue;
  annotation (Documentation(info="<html>
<p>
This package contains type definitions used in Modelica.Utilities.
</p>

</html>"));
end Types;
