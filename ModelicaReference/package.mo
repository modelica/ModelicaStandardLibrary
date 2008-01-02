within ;
package ModelicaReference "Modelica Reference"
annotation (DocumentationClass=true, Documentation(info="<html>
<p>
This package is a reference to Modelica keywords and Modelica builtin 
operators and is based on the 
<a href=\"http://www.modelica.org/documents/ModelicaSpec30.pdf\">Modelica Language Specification version 3.0</a> from Sept. 2007.


<dl>
<dt><b>Main Author:</b></dt>
<dd><a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian.Schweiger</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
    Institut f&uuml;r Robotik und Mechatronik<br>
    Postfach 11 16<br>
    D-82230 Wessling<br>
    Germany<br>
    email: <A HREF=\"mailto:Christian.Schweiger@dlr.de\">Christian.Schweiger@dlr.de</A><br></dd>
</dl>

<p>
<b>Copyright &copy; 2003-2004, 2008 Modelica Association and DLR.</b>
</p>
<p>
<i>The <b>ModelicaReference</b> package is <b>free</b> software; 
it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p><br>
</html>", revisions="<html>

<ul>
<li><i>Jan. 2, 2008</i>
    by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
    Adapted to Modelica language version 3.0</li>

<li><i>Sept. 30, 2004</i>
    by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
    Moved the content of \"Functions\" into \"Operators\" and updated
    \"Operators\" according to Modelica 2.1</li>

<li><i>July 10, 2003</i>
     by <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
     Implemented.</li>
</ul>
</html>"));


package Classes "Classes (model, function, ...)" 
  class Block "block" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>block</font></h3>
<p>
Define specialized class <i>block</i>
</p>
<h3><font color=\"#008000\">Examples</font></h3>

<pre><b>block</b> Integrator
  <b>input</b> Real u;
  <b>output</b> Real y;
<b>protected</b>
  Real x;
<b>equation
  der</b>(x) = u;
  y = x;
<b>end</b> Integrator;</pre>

<h3><font color=\"#008000\">Syntax</font></h3>

<PRE>   [ <B>encapsulated</B> ][ <B>partial </B>] <B>block</B>
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment</PRE>

<p>See Modelica Language Specification for further details.</p>

<h3><font color=\"#008000\">Description</font></h3>
<P>
A block class is the same as a model class
with the restriction that each connector component of a block must
have prefixes input and/or output for all connector variables. 
The purpose is to model input/output blocks of block diagrams.
Due to the restrictions on input and output prefixes,
connections between blocks are only possible according
to block diagram semantic.
</P>
</html>"));
  end Block;
  
  class Class "class" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>class</font></h3>
<p>
Define class
</p>
<h3><font color=\"#008000\">Examples</font></h3>

<pre><b>class</b> MyTable
  <b>extends</b> ExternalObject;
  <b>function</b> constructor
     ...
  <b>end</b> constructor;

  <b>function</b> destructor
     ...
  <b>end</b> destructor;
<b>end</b> MyTable;</pre>

<h3><font color=\"#008000\">Syntax</font></h3>
<PRE>   [ <B>encapsulated</B> ][ <B>partial </B>] <B>class</B>
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment</PRE>

<p>See Modelica Language Specification for further details.</p>

<h3><font color=\"#008000\">Description</font></h3>

<p>
The keyword class is used to define general classes (without any restrictions).
It is identical to the keyword model.
In most cases, it is recommended to use specialized classes as <b>block</b>,
<b>connector</b>, <b>model</b>, <b>package</b>, <b>record</b>, <b>function</b>or <b>type</b>.
\"class\" should only be used to define ExternalObjects.
</p>
</html>"));
  end Class;
  
  class Connector "connector" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>connector</font></h3>
<p>
Define specialized class <i>connector</i>
</p>
<h3><font color=\"#008000\">Examples</font></h3>

<pre><b>connector</b> flange
  Modelica.SIunits.Angle phi;
  <b>flow</b> Modelica.SIunits.Torque tau;
<b>end</b> flange;</pre>

<h3><font color=\"#008000\">Syntax</font></h3>
<PRE>   [ <B>encapsulated</B> ][ <B>partial </B>] <B>connector</B>
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment</PRE>

<p>See Modelica Language Specification for further details.</p>

<h3><font color=\"#008000\">Description</font></h3>
<P>The keyword connector is used to define connectors, which are used
in connect statements. In connectors, no equations are allowed in the
definition or in any of its components.
With respect to \"class\", it is enhanced to allow connect(..) to components 
of connector classes.
</P>
</html>"));
  end Connector;
  
  class Function "function" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>function</font></h3>
<p>
Define specialized class <i>function</i>
</p>
<h3><font color=\"#008000\">Examples</font></h3>

<pre><b>function</b> si
  <b>input</b> Real x;
  <b>output</b> Real y;
<b>algorithm</b>
  y = <b>if abs</b>(x) &lt; Modelica.Constants.eps <b>then</b> 1 <b>else</b> Modelica.Math.sin(x)/x;
<b>end</b> si;</pre>

<p align=\"center\"><img src=\"../Images/function.png\" width=\"400\" height=\"280\" alt=\"Simulation result\"></p>

<h3><font color=\"#008000\">Syntax</font></h3>

<PRE>   [ <B>encapsulated</B> ][ <B>partial </B>] <B>function</B>
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment</PRE>

<p>See Modelica Language Specification for further details.</p>

<h3><font color=\"#008000\">Description</font></h3>

<P>The keyword function is used to define functions as known from programming
languages. Each part of a function interface must
either have causality equal to input or output. A function may not be used in connections.
In functions, no equations or initial algorithm and at most
one algorithm clause are allowed. Calling a function requires
either an algorithm clause or an external function interface.</p>

<p>
The syntax and semantics of a function have many similarities to those of the block 
specialized class. A function has many of the properties of a general class, 
e.g. being able to inherit other functions, or to redeclare or modify
elements of a function declaration.
</p>

<p> 
Modelica functions have the following restrictions compared to a 
general Modelica class:
</p>

<ul>
<li> Each input formal parameter of the function must be
     prefixed by the keyword input, and each result formal parameter
     by the keyword output. All public variables are formal parameters.</li>

<li> Input formal parameters are read-only after being bound to the 
     actual arguments or default values, i.e., they may not be assigned
     values in the body of the function.</li>

<li> A function may not be used in connections, may have no equations,
     may have no initial algorithm, and can have at most one algorithm
     section, which, if present, is the body of the function.</li>

<li> A function may have zero or one external function interface, which,
     if present, is the external definition of the function. </li>

<li> For a function to be called in a simulation model, it must have
     either an algorithm section or an external function interface as
     its body, and it may not be partial.</li>

<li> A function cannot contain calls to the Modelica built-in operators 
     der, initial, terminal, sample, pre, edge, change, reinit, delay,
     cardinality, to the operators of the built-in package Connections,
     and is not allowed to contain when-statements.</li>

<li> The dimension sizes not declared with (:) of each array result or
     array local variable [i.e., a non-input components] of a function must
     be either given by the input formal parameters, or given by constant
     or parameter expressions, or by expressions containing combinations
     of those</li>

<li> The local variables of a function are not automatically initialized to
     the implicit default values of the data type [(e.g. 0.0 for Real)
     for performance reasons. It is the responsibility of the user to
     provide explicit defaults or to define the values of such variables
     before they are referenced.]</li>

<li> Components of a function will inside the function behave as though
     they had discrete-time variability.</li>
</ul>

<p>
Modelica functions have the following enhancements compared to a general Modelica class: 
</p>

<ul>
<li> A function may be called using the conventional positional calling syntax
     for passing arguments.</li>

<li> A function can be recursive.</li>

<li> A formal parameter or local variable may be initialized
     through an assignment (:=) of a default value in its declaration.
     Initialization through an equation is not possible.</li>

<li> A function is dynamically instantiated when it is called rather than
     being statically instantiated by an instance declaration,
     which is the case for other kinds of classes. </li>

<li> A function may have an external function interface specifier as its body.</li>

<li> A function may have a return statement in its algorithm section body.</li>

<li> A function allows dimension sizes declared with (:) to be resized
     for non-input array variables (so the actual dimension need not to be known when
     the function is translated).</li>.
</ul>


</html>"));
  end Function;
  
  class Model "model" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>model</font></h3>
<p>
Define specialized class <i>model</i>
</p>
<h3><font color=\"#008000\">Examples</font></h3>

<pre><b>model</b> SlidingMass
  <b>parameter</b> Modelica.SIunits.Mass m=1;
  <b>parameter</b> Modelica.SIunits.Force f=1;
  Modelica.SIunits.Position s;
  Modelica.SIunits.Velocity v;
  Modelica.SIunits.Acceleration a;
<b>equation</b>
  <b>der</b>(s) = v;
  <b>der</b>(v) = a;
  m*a = f;
<b>end</b> SlidingMass;</pre>

<h3><font color=\"#008000\">Syntax</font></h3>
<PRE>   [ <B>encapsulated</B> ][ <B>partial </B>] <B>model</B>
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment</PRE>

<p>See Modelica Language Specification for further details.</p>

<h3><font color=\"#008000\">Description</font></h3>
<P>
The keyword model is identical to the keyword class, i.e.,
no restrictions and no enhancements. 
</P>
</html>"));
  end Model;
  
  class Package "package" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>package</font></h3>
<p>
Define specialized class <i>package</i>
</p>
<h3><font color=\"#008000\">Examples</font></h3>

<pre><b>package</b> Library
  <b>constant</b> Real k = 0.1;

  <b>type</b> X = Real(min=0);

  <b>model</b> A
    ...
  <b>end</b> A;

  <b>model</b> B
    ...
  <b>end</b> B;
<b>end</b> Library;</pre>


<h3><font color=\"#008000\">Syntax</font></h3>
<PRE>   [ <B>encapsulated</B> ][ <B>partial </B>] <B>package</B>
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment</PRE>

<p>See Modelica Language Specification for further details.</p>

<h3><font color=\"#008000\">Description</font></h3>
<P>May only contain declarations of classes and constants.
   Enhanced to allow import of elements of packages.</P>

</html>"));
  end Package;
  
  class Record "record" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>record</font></h3>
<p>
Define specialized class <i>record</i>
</p>
<h3><font color=\"#008000\">Examples</font></h3>

<pre>  <b>record</b> States
    Modelica.SIunits.Position s;
    Modelica.SIunits.Velocity v;
  <b>end</b> States;

  <b>record</b> System
    <b>parameter</b> Modelica.SIunits.Mass m=1;
    <b>parameter</b> Modelica.SIunits.Force f=1;
    Modelica.SIunits.Acceleration a;
    States states;
  <b>end</b> System;

  <b>model</b> SlidingMass
    System sys;
  <b>equation</b>
    <b>der</b>(sys.states.s) = sys.states.v;
    <b>der</b>(sys.states.v) = sys.a;
    sys.m*sys.a = sys.f;
  <b>end</b> SlidingMass;</pre>

<h3><font color=\"#008000\">Syntax</font></h3>
<PRE>   [ <B>encapsulated</B> ][ <B>partial </B>] <B>record</B>
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment</PRE>

<p>See Modelica Language Specification for further details.</p>

<h3><font color=\"#008000\">Description</font></h3>

<p>
The keyword record is used to define records which are generally used in
order to group variables. Only public sections are allowed in the definition
or in any of its components (i.e., equation, algorithm, initial equation,
initial algorithm and protected sections are not allowed). May not be used in 
connections. The elements of a record may not have prefixes input, output, inner, outer, 
or flow.  Enhanced with implicitly available record constructor function. 
Additionally, record components can be used as component references in
expressions and in the left hand side of assignments, subject to
normal type compatibility rules.
</p>

</html>"));
  end Record;
  
  class Type "type" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>type</font></h3>
<p>
Define specialized class <i>type</i>
</p>
<h3><font color=\"#008000\">Examples</font></h3>

<pre><b>type</b> R0Plus = Real(min=0);</pre>

<h3><font color=\"#008000\">Syntax</font></h3>
<PRE>   [ <B>encapsulated</B> ][ <B>partial </B>] <B>type</B>
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment</PRE>

<p>See Modelica Language Specification for further details.</p>

<h3><font color=\"#008000\">Description</font></h3>
<p>The keyword type is used to define types, which may only be extensions to the predefined types, enumerations, array of type, or classes extending from type.
Enhanced to extend from predefined types [No other specialized class has this property].
</p>

</html>"));
  end Type;
  annotation (Documentation(info="<html>
<p>
In this package specialized kinds of classes (earlier known as restricted classes) are
described. They have the properties of a general class, apart from restrictions.
Moreover, they have additional properties called enhancements.
</p>

</html>"));
end Classes;


package Operators "Operators (+, der, size, ...)" 
class ElementaryOperators "Elementary operators (+, >, or, ..)" 
    
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>Elementary Operators</font></h3>
<p>
Elementary operators are overloaded and operate on variables
of type Real, Integer, Boolean, and String, as well as on scalars
or arrays.
</p>
<h3><font color=\"#008000\">Syntax</font></h3>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td colspan=\"3\"><b>Arithmethic Operators (operate on Real, Integer scalars or arrays)</b></td>
  <tr><td><i>Operators</i></td>
      <td><i>Example</i></td>
      <td><i>Description</i></tr></td>
      </tr>
  <tr><td>+, -, .+, .-</td>
      <td>a + b<br>
          a .+ b</td>
      <td>addition and subtraction; element-wise on arrays</td></tr>

  <tr><td>*</td>
      <td>a * b</td>
      <td>multiplication;<br>
          scalar*array: element-wise multiplication<br>
          vector*vector: element-wise multiplication (result: scalar)<br>
          matrix*matrix: matrix product <br>
          vector*matrix: row-matrix*matrix (result: vector)<br>
          matrix*vector: matrix*column-matrix (result: vector)</td></tr>
  <tr><td>/</td>
      <td>a / b</td>
      <td>division of two scalars or an array by a scalar;<br>
          division of an array by a scalar is defined element-wise.<br>
          The result is always of real type. In order to get integer <br>
          division with truncation use the function div.</td></tr>

  <tr><td>^</td>
      <td>a^b</td>
      <td>scalar power or integer power of a square matrix</td></tr>

  <tr><td>.*, ./, .^</td>
      <td>a .* b</td>
      <td>element-wise multiplication, division and exponentation of 
          scalars and arrays</td></tr>

  <tr><td>=</td>
      <td>a * b = c + d</td>
      <td>equal operator of an equation; element-wise on arrays</td></tr>
  <tr><td>:=</td>
      <td>a := c + d</td>
      <td>assignment operator; element-wise on arrays</td></tr>
</table>

&nbsp;

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td colspan=\"3\"><b>Relational Operators (operate on Real, Integer, Boolean, String scalars)</b></td>
  <tr><td><i>Operators</i></td>
      <td><i>Example</i></td>
      <td><i>Description</i></tr></td>
      </tr>
  <tr><td>==</td>
      <td>a == b</td>
      <td>equal; for strings: identical characters</td></tr>
  <tr><td>&lt;&gt;</td>
      <td>a &lt;&gt; b</td>
      <td>not equal; for strings: a is lexicographically less than b</td></tr>
  <tr><td>&lt;</td>
      <td>a &lt; b</td>
      <td>less than</td></tr>
  <tr><td>&lt;=</td>
      <td>a &gt;= b</td>
      <td>less than or equal</td></tr>
  <tr><td>&gt;</td>
      <td>a &gt; b</td>
      <td>greater than</td></tr>
  <tr><td>&gt;=</td>
      <td>a &gt;= b</td>
      <td>greater than or equal</td></tr>
</table>

&nbsp;

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td colspan=\"3\"><b>Boolean Operators (operate on scalars or element-wise on arrays)</b></td>
  <tr><td><i>Operators</i></td>
      <td><i>Example</i></td>
      <td><i>Description</i></tr></td>
      </tr>
  <tr><td><b>and</b></td>
      <td>a <b>and</b> b</td>
      <td>logical and</td></tr>
  <tr><td><b>or</b></td>
      <td>a <b>or</b> b</td>
      <td>logical or</td></tr>
  <tr><td><b>not</b></td>
      <td><b>not</b> a</td>
      <td>logical not</td></tr>
</table>

&nbsp;

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td colspan=\"3\"><b>Other Operators</b></td>
  <tr><td><i>Operators</i></td>
      <td><i>Example</i></td>
      <td><i>Description</i></tr></td>
      </tr>
  <tr><td>[..]</td>
      <td>[1,2;3,4]</td>
      <td>Matrix constructor; \",\" separates rows, \";\" separates columns</td></tr>
  <tr><td>{..}</td>
      <td>{{1,2}, {3,4}}</td>
      <td>Array constructor; every {..} adds one dimension</td></tr>
  <tr><td>\"...\"</td>
      <td>\"string value\"<br>
          \"string \"value\"\"</td>
      <td>String literal (\" is used inside a string for \")</td></tr>
  <tr><td>+</td>
      <td>\"abc\" + \"def\"</td>
      <td>Concatenation of string scalars or arrays</td></tr>
</table>

<p class=\"MsoBodyText\"><span lang=\"EN-US\">Operator
precedence determines the order
of evaluation of operators in an expression. An operator with higher
precedence
is evaluated before an operator with lower precedence in the same
expression.</span></p>
<p class=\"MsoBodyTextIndent\"><span lang=\"EN-US\">The
following table presents all
the expression operators in order of precedence from highest to lowest.
All operators are binary except exponentiation, the postfix
operators and
those shown as unary together with <i>expr</i>, the
conditional operator, the
array construction operator {} and concatenation operator [ ], and the
array
range constructor which is either binary or ternary</span><span
 lang=\"EN-US\">. Operators with the same precedence occur at
the same line of the
table: </span></p>

<table class=\"MsoNormalTable\"
 style=\"margin-left: 12.5pt; border-collapse: collapse;\"
 border=\"0\" cellpadding=\"0\" cellspacing=\"0\">
  <tbody>
    <tr>
      <td
 style=\"border-style: solid none solid solid; border-color: windowtext -moz-use-text-color windowtext windowtext; border-width: 1pt medium 1pt 1pt; padding: 0pt 5.4pt; width: 134.65pt;\"
 valign=\"top\" width=\"180\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><i><span
 lang=\"EN-US\">Operator Group</span></i></p>
      </td>
      <td
 style=\"border-style: solid none; border-color: windowtext -moz-use-text-color; border-width: 1pt medium; padding: 0pt 5.4pt; width: 152.95pt;\"
 valign=\"top\" width=\"204\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><i><span
 lang=\"EN-US\">Operator Syntax</span></i></p>
      </td>
      <td
 style=\"border-style: solid solid solid none; border-color: windowtext windowtext windowtext -moz-use-text-color; border-width: 1pt 1pt 1pt medium; padding: 0pt 5.4pt; width: 144.75pt;\"
 valign=\"top\" width=\"193\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><i><span
 lang=\"EN-US\">Examples</span></i></p>
      </td>
    </tr>
    <tr>
      <td
 style=\"border-style: none solid; border-color: -moz-use-text-color windowtext; border-width: medium 1pt; padding: 0pt 5.4pt; width: 134.65pt;\"
 valign=\"top\" width=\"180\">
      <p class=\"MsoBodyText\" style=\"margin-top: 0pt;\"><span
 lang=\"EN-US\">postfix array index operator</span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 152.95pt;\"
 valign=\"top\" width=\"204\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">[]</span></span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 144.75pt;\"
 valign=\"top\" width=\"193\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">arr[index]</span></span></p>
      </td>
    </tr>
    <tr>
      <td
 style=\"border-style: none solid; border-color: -moz-use-text-color windowtext; border-width: medium 1pt; padding: 0pt 5.4pt; width: 134.65pt;\"
 valign=\"top\" width=\"180\">
      <p class=\"MsoBodyText\" style=\"margin-top: 0pt;\"><span
 lang=\"EN-US\">postfix access operator</span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 152.95pt;\"
 valign=\"top\" width=\"204\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">. </span></span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 144.75pt;\"
 valign=\"top\" width=\"193\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">a.b</span></span></p>
      </td>
    </tr>
    <tr>
      <td
 style=\"border-style: none solid; border-color: -moz-use-text-color windowtext; border-width: medium 1pt; padding: 0pt 5.4pt; width: 134.65pt;\"
 valign=\"top\" width=\"180\">
      <p class=\"MsoBodyText\" style=\"margin-top: 0pt;\"><span
 lang=\"EN-US\">postfix function call</span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 152.95pt;\"
 valign=\"top\" width=\"204\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><i><span
 lang=\"EN-US\">funcName</span></i><span
 lang=\"EN-US\">(<i>function-arguments</i>)</span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 144.75pt;\"
 valign=\"top\" width=\"193\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">sin(4.36)</span></span></p>
      </td>
    </tr>
    <tr>
      <td
 style=\"border-style: none solid; border-color: -moz-use-text-color windowtext; border-width: medium 1pt; padding: 0pt 5.4pt; width: 134.65pt;\"
 valign=\"top\" width=\"180\">
      <p class=\"MsoBodyText\" style=\"margin-top: 0pt;\"><span
 lang=\"EN-US\">array construct/concat</span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 152.95pt;\"
 valign=\"top\" width=\"204\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 lang=\"EN-US\">{<i>expressions</i>}&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp; [<i>expressions</i>]&nbsp;&nbsp; [<i>expressions</i></span><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">;</span></span><span lang=\"EN-US\">
      <i>expressions</i>...]</span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 144.75pt;\"
 valign=\"top\" width=\"193\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">{2,3}&nbsp; [5,6]</span></span></p>
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">[2,3; 7,8]</span></span></p>
      </td>
    </tr>
    <tr>
      <td
 style=\"border-style: none solid; border-color: -moz-use-text-color windowtext; border-width: medium 1pt; padding: 0pt 5.4pt; width: 134.65pt;\"
 valign=\"top\" width=\"180\">
      <p class=\"MsoBodyText\" style=\"margin-top: 0pt;\"><span
 lang=\"EN-US\">exponentiation</span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 152.95pt;\"
 valign=\"top\" width=\"204\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">^</span></span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 144.75pt;\"
 valign=\"top\" width=\"193\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">2^3</span></span></p>
      </td>
    </tr>
    <tr>
      <td
 style=\"border-style: none solid; border-color: -moz-use-text-color windowtext; border-width: medium 1pt; padding: 0pt 5.4pt; width: 134.65pt;\"
 valign=\"top\" width=\"180\">
      <p class=\"MsoBodyText\"
 style=\"margin-top: 0pt; text-align: left;\" align=\"left\"><span
 lang=\"EN-US\">multiplicative and array elementwise
multiplicative</span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 152.95pt;\"
 valign=\"top\" width=\"204\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">*</span></span><span class=\"CODE\"><span
 style=\"font-size: 9.5pt;\" lang=\"EN-US\">&nbsp;&nbsp;/&nbsp;
.*&nbsp;&nbsp; ./</span></span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 144.75pt;\"
 valign=\"top\" width=\"193\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: left; text-indent: 0pt;\" align=\"left\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">2*3&nbsp;&nbsp; 2/3<br>
[1,2;3,4].*[2,3;5,6]</span></span></p>
      </td>
    </tr>
    <tr>
      <td
 style=\"border-style: none solid; border-color: -moz-use-text-color windowtext; border-width: medium 1pt; padding: 0pt 5.4pt; width: 134.65pt;\"
 valign=\"top\" width=\"180\">
      <p class=\"MsoBodyText\"
 style=\"margin-top: 0pt; text-align: left;\" align=\"left\"><span
 lang=\"EN-US\">additive and array elementwise additive</span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 152.95pt;\"
 valign=\"top\" width=\"204\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: left; text-indent: 0pt;\" align=\"left\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">+</span></span><span class=\"CODE\"><span
 style=\"font-size: 9.5pt;\" lang=\"EN-US\">&nbsp;&nbsp;-</span></span><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">&nbsp;&nbsp;+</span></span><i><span
 lang=\"EN-US\">expr</span></i><span lang=\"EN-US\">&nbsp;
      </span><span class=\"CODE\"><span
 style=\"font-size: 9.5pt;\" lang=\"EN-US\">-</span></span><i><span
 lang=\"EN-US\">expr<br>
      </span></i><span lang=\"EN-US\">.+&nbsp;
.</span><span class=\"CODE\"><span
 style=\"font-size: 9.5pt;\" lang=\"EN-US\">-</span></span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 144.75pt;\"
 valign=\"top\" width=\"193\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">a+b</span></span><span
 lang=\"EN-US\">,</span><span class=\"CODE\"><span
 style=\"font-size: 9.5pt;\" lang=\"EN-US\">&nbsp;
a-b, +a, -a</span></span></p>
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">[1,2;3,4].+[2,3;5,6]</span></span></p>
      </td>
    </tr>
    <tr>
      <td
 style=\"border-style: none solid; border-color: -moz-use-text-color windowtext; border-width: medium 1pt; padding: 0pt 5.4pt; width: 134.65pt;\"
 valign=\"top\" width=\"180\">
      <p class=\"MsoBodyText\" style=\"margin-top: 0pt;\"><span
 lang=\"EN-US\">relational</span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 152.95pt;\"
 valign=\"top\" width=\"204\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">&lt;</span></span><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">&nbsp;&nbsp;&lt;=</span></span><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">&nbsp;&nbsp;&gt;</span></span><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">&nbsp;&nbsp;&gt;=</span></span><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">&nbsp;&nbsp;==</span></span><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">&nbsp;&nbsp;&lt;&gt;</span></span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 144.75pt;\"
 valign=\"top\" width=\"193\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">a&lt;b</span></span><span
 lang=\"EN-US\">,</span><span class=\"CODE\"><span
 style=\"font-size: 9.5pt;\" lang=\"EN-US\">&nbsp;
a&lt;=b, a&gt;b, ...</span></span></p>
      </td>
    </tr>
    <tr>
      <td
 style=\"border-style: none solid; border-color: -moz-use-text-color windowtext; border-width: medium 1pt; padding: 0pt 5.4pt; width: 134.65pt;\"
 valign=\"top\" width=\"180\">
      <p class=\"MsoBodyText\" style=\"margin-top: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">...</span></span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 152.95pt;\"
 valign=\"top\" width=\"204\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 144.75pt;\"
 valign=\"top\" width=\"193\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
    </tr>
    <tr>
      <td
 style=\"border-style: none solid; border-color: -moz-use-text-color windowtext; border-width: medium 1pt; padding: 0pt 5.4pt; width: 134.65pt;\"
 valign=\"top\" width=\"180\">
      <p class=\"MsoBodyText\" style=\"margin-top: 0pt;\"><span
 lang=\"EN-US\">unary negation</span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 152.95pt;\"
 valign=\"top\" width=\"204\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">not</span></span><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">&nbsp;</span></span><i><span
 lang=\"EN-US\">expr</span></i></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 144.75pt;\"
 valign=\"top\" width=\"193\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">not b1</span></span></p>
      </td>
    </tr>
    <tr>
      <td
 style=\"border-style: none solid; border-color: -moz-use-text-color windowtext; border-width: medium 1pt; padding: 0pt 5.4pt; width: 134.65pt;\"
 valign=\"top\" width=\"180\">
      <p class=\"MsoBodyText\" style=\"margin-top: 0pt;\"><span
 lang=\"EN-US\">logical and</span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 152.95pt;\"
 valign=\"top\" width=\"204\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">and</span></span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 144.75pt;\"
 valign=\"top\" width=\"193\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">b1 and b2</span></span></p>
      </td>
    </tr>
    <tr>
      <td
 style=\"border-style: none solid; border-color: -moz-use-text-color windowtext; border-width: medium 1pt; padding: 0pt 5.4pt; width: 134.65pt;\"
 valign=\"top\" width=\"180\">
      <p class=\"MsoBodyText\" style=\"margin-top: 0pt;\"><span
 lang=\"EN-US\">logical or</span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 152.95pt;\"
 valign=\"top\" width=\"204\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">or</span></span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 144.75pt;\"
 valign=\"top\" width=\"193\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">b1 or&nbsp; b2</span></span></p>
      </td>
    </tr>
    <tr>
      <td
 style=\"border-style: none solid; border-color: -moz-use-text-color windowtext; border-width: medium 1pt; padding: 0pt 5.4pt; width: 134.65pt;\"
 valign=\"top\" width=\"180\">
      <p class=\"MsoBodyText\" style=\"margin-top: 0pt;\"><span
 lang=\"EN-US\">array range</span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 152.95pt;\"
 valign=\"top\" width=\"204\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><i><span
 lang=\"EN-US\">expr</span></i><span lang=\"EN-US\">&nbsp;
      </span><span class=\"CODE\"><span
 style=\"font-size: 9.5pt;\" lang=\"EN-US\">:</span></span><span
 lang=\"EN-US\">&nbsp; <i>expr</i>&nbsp; </span><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">:</span></span><span lang=\"EN-US\">&nbsp;
      <i>expr</i></span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 144.75pt;\"
 valign=\"top\" width=\"193\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">1:5</span></span><span
 lang=\"EN-US\">,</span><span class=\"CODE\"><span
 style=\"font-size: 9.5pt;\" lang=\"EN-US\">
start:step:stop</span></span></p>
      </td>
    </tr>
    <tr>
      <td
 style=\"border-style: none solid; border-color: -moz-use-text-color windowtext; border-width: medium 1pt; padding: 0pt 5.4pt; width: 134.65pt;\"
 valign=\"top\" width=\"180\">
      <p class=\"MsoBodyText\" style=\"margin-top: 0pt;\"><span
 lang=\"EN-US\">conditional</span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 152.95pt;\"
 valign=\"top\" width=\"204\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">if</span></span><span
 lang=\"EN-US\">&nbsp;&nbsp;<i>expr</i>&nbsp;
      </span><span class=\"CODE\"><span
 style=\"font-size: 9.5pt;\" lang=\"EN-US\">then</span></span><span
 lang=\"EN-US\">&nbsp;&nbsp;<i>expr</i>&nbsp;
      </span><span class=\"CODE\"><span
 style=\"font-size: 9.5pt;\" lang=\"EN-US\">else</span></span><span
 lang=\"EN-US\">&nbsp;&nbsp;<i>expr</i></span></p>
      </td>
      <td
 style=\"border-style: none solid none none; border-color: -moz-use-text-color windowtext -moz-use-text-color -moz-use-text-color; border-width: medium 1pt medium medium; padding: 0pt 5.4pt; width: 144.75pt;\"
 valign=\"top\" width=\"193\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">if b then 3 else x</span></span></p>
      </td>
    </tr>
    <tr>
      <td
 style=\"border-style: none solid solid; border-color: -moz-use-text-color windowtext windowtext; border-width: medium 1pt 1pt; padding: 0pt 5.4pt; width: 134.65pt;\"
 valign=\"top\" width=\"180\">
      <p class=\"MsoBodyText\" style=\"margin-top: 0pt;\"><span
 lang=\"EN-US\">named argument</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 152.95pt;\"
 valign=\"top\" width=\"204\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><i><span
 lang=\"EN-US\">ident&nbsp; </span></i><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">=</span></span><span lang=\"EN-US\">&nbsp;
      <i>expr</i>&nbsp; </span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 144.75pt;\"
 valign=\"top\" width=\"193\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">x = 2.26</span></span></p>
      </td>
    </tr>
  </tbody>
</table>
<p class=\"MsoBodyText\"><span lang=\"EN-US\">The
conditional operator may also include
elseif-clauses. Equality </span><span class=\"CODE\"><span
 style=\"font-size: 9.5pt;\" lang=\"EN-US\">=</span></span><span
 lang=\"EN-US\"> and assignment </span><span
 class=\"CODE\"><span style=\"font-size: 9.5pt;\"
 lang=\"EN-US\">:=</span></span><span
 lang=\"EN-US\"> are not expression operators since they are
allowed only in
equations and in assignment statements respectively. All binary
expression
operators are left associative.</span></p>

<p class=\"MsoBodyText\"><span lang=\"EN-US\">
Note, the unary minus and plus in Modelica
is slightly different than in Mathematica (Mathematica is a registered trademark
of Wolfram Research Inc.) and in MATLAB (MATLAB is a registered trademark of MathWorks Inc.),
since the following expressions are illegal (whereas in
Mathematica and in MATLAB these are valid expressions):
</p>

<pre>  2*-2   // = -4 in Mathematica/MATLAB; is illegal in Modelica
  --2    // =  2 in Mathematica/MATLAB; is illegal in Modelica
  ++2    // =  2 in Mathematica/MATLAB; is illegal in Modelica
  2--2   // =  4 in Mathematica/MATLAB; is illegal in Modelica
</pre>

</html>"));
end ElementaryOperators;
  annotation (Documentation(info="<html>
<p>
In this chapter <b>operators</b> of Modelica are documented.
Elementary operators, such as \"+\" or \"-\" are overloaded and
operate on scalar and array variables. Other operators
have the same syntax as a 
<a href=\"Modelica:ModelicaReference.Classes.Function\">Modelica function</a>
call. However, they do not behave as a Modelica function, 
either because the result depends not only on the input arguments but 
also on the status of the simulation (such as \"pre(..)\"), or
the function operates on input arguments of different types
(such as \"String(..)\"). Neither of these \"functions\"
can be defined with a \"standard\" Modelica function and are 
therefore builtin operators of the Modelica language
(with exception of the basic mathematical functions,
sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, exp,
log, log10 that are provided for convenience as built-in functions).
</p>
</html>"));
  
  class Abs "abs" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>abs</font></h3>
<p>
Absolute value of Real or Integer variable.
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>abs</b>(v)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<P>Is expanded into &quot;noEvent(<B>if </B>v &ge; 0
<B>then</B> v <B>else</B> -v)&quot;. Argument v
needs to be an Integer or Real expression. </P>
<h3><font color=\"#008000\">Examples</font></h3>
<pre>
  <b>abs</b>({-3, 0, 3})
 = {3, 0, 3}</pre>
</html>"));
  end Abs;
  
  class Assert "assert" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>assert</font></h3>
<p>
Trigger error and print error message if assertion condition is not fulfilled
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>assert</b>(condition, message, level = AssertionLevel.error)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>The boolean expression <i>condition</i> shall be true for successful model evaluations.
Otherwise, an error occurs using the string expression <i>message</i>
as error message.</p>
<P>If the condition of an assert statement is true, message is not
evaluated and the procedure call is ignored. If the condition
evaluates to false different actions are taken depending on the level input:
</p>

<ul>
<li> level = AssertionLevel.error:<br>
     The current evaluation is aborted. The simulation may 
     continue with another evaluation [e.g., with a shorter step-size,
     or by changing the values of iteration variables].
     If the simulation is aborted, message indicates the cause of the
     error. Failed assertions takes precedence over successful
     termination, such that if the model first triggers the
     end of successful analysis by reaching the stop-time
     or explicitly with terminate(), but the evaluation with
     terminal()=true triggers an assert, the analysis failed. </li>
<li> level = AssertionLevel.warning:<br>
     The current evaluation is not aborted. message indicates 
     the cause of the warning [It is recommended to report the 
     warning only once when the condition becomes false, and it is
     reported that the condition is no longer violated when the
     condition returns to true. The assert(..) statement shall
     have no influence on the behavior of the model.
     For example, by evaluating the condition and reporting the
     message only after accepted integrator steps. condition
     needs to be implicitly treated with noEvent(..) since
     otherwise events might be triggered that can lead to slightly
     changed simulation results].</li>
</ul>

<p>
The AssertionLevel.error case can be used to avoid evaluating a model outside its limits of validity; for instance, a function to compute the saturated liquid temperature cannot be called with a pressure lower than the triple point value.
The AssertionLevel.warning case can be used when the boundary of validity is not hard: for instance, a fluid property model based on a polynomial interpolation curve might give accurate results between temperatures of 250 K and 400 K, but still give reasonable results in the range 200 K and 500 K. When the temperature gets out of the smaller interval, but still stays in the largest one, the user should be warned, but the simulation should continue without any further action. The corresponding code would be
</p>
<pre>  <b>assert</b>(T &gt; 250 and T &lt; 400, \"Medium model outside full accuracy range\",
         AssertionLevel.warning);
  <b>assert</b>(T &gt; 200 and T &lt; 500, \"Medium model outside feasible region\");
</pre>

<h3><font color=\"#008000\">Examples</font></h3>
<pre>  <b>parameter</b> Real upperLimit=2;
  <b>parameter</b> Real lowerLimit=-2;
<b>equation</b>
  <b>assert</b>(upperLimit > lowerLimit, \"upperLimit must be greater than lowerLimit.\");
</pre>
</html>"));
  end Assert;
  
  class Cardinality "cardinality" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>cardinality</font></h3>
<p>
Number of connectors in connection.
This is a deprecated operator. It should  no longer be used, since it will be removed in one of the next Modelica releases.
</p>

<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>cardinality</b>(c)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>Returns the number of (inside and outside) occurrences
of connector instance c in a connect statement as an Integer number.</p>
<p><i>[The cardinality operator allows the definition of connection dependent equations in a model.]</i></p>

<p>
Instead of the cardinality(..) operator, often conditional
connectors can be used, that are enabled/disabled via Boolean
parameters.
</p>

<h3><font color=\"#008000\">Examples</font></h3>
<PRE><B>connector</B> Pin
  Real      v;
  <B>flow</B> Real i;
<B>end</B> Pin;
<B>model</B> Resistor
   <B>Pin</B> p, n;
<B>equation</B>
   // Handle cases if pins are not connected
      <B>if cardinality</B>(p) == 0 <B>and cardinality</B>(n) == 0 <B>then</B>
         p.v = 0;
         n.v = 0;
      <B>elseif cardinality</B>(p) == 0 <B>then</B>
         p.i = 0;
      <B>elseif cardinality</B>(n) == 0 <B>then</B>
         n.i = 0;
      <B>end if</B>;
   // Equations of resistor
      ...
<B>end</B> Resistor;</PRE>
</html>"));
  end Cardinality;
  
  class Ceil "ceil" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>ceil</font></h3>
<p>
Round a Real number towards plus infinity
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>ceil</b>(x)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>Returns the smallest integer not less than <tt>x</tt>.
Result and argument shall have type Real.
<i>[Note, outside of a when clause state events are
triggered when the return value changes discontinuously.]</i></p>
<h3><font color=\"#008000\">Examples</font></h3>
<pre><b>ceil</b>({-3.14, 3.14})
 = {-3.0, 4.0}</pre>
</html>"));
  end Ceil;
  
  class Change "change" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>change</font></h3>
<p>
Indicate discrete variable changing
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>change</b>(v)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<P>Is expanded into &quot;(v&lt;&gt;pre(v))&quot;.
The same restrictions as for the pre() operator apply.</P>
<h3><font color=\"#008000\">Examples</font></h3>
<pre><b>model</b> BothEdges
  Boolean u;
  Integer i;
<b>equation</b>
  u = Modelica.Math.sin(<b>time</b>) &gt; 0.5;
  <b>when</b> <b>change</b>(u) <b>then</b>
    i = <b>pre</b>(i) + 1;
  <b>end when</b>;
<b>end</b> BothEdges;</pre>
<p align=\"center\"><img src=\"../Images/change.png\" width=\"400\" height=\"280\" alt=\"Simulation result\"></p>
</html>"));
  end Change;
  
  class Cos "cos" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>cos</font></h3>
<p>
Trigonometric cosine function
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>cos</b>(v)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>Returns the cosine of v.
Argument v needs to be an Integer or Real expression.</p>
<h3><font color=\"#008000\">Examples</font></h3>
<pre><b>cos</b>(3.14159265358979)
 = -1.0</pre>
</html>"));
  end Cos;
  
class Cross "cross" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>cross</font></h3>
<p>
Return cross product of two vectors
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>cross</b>(x, y)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Returns the cross product of the 3-vectors x and y, i.e.
</p>
<blockquote><pre>
<b>cross</b>(x,y) = <b>vector</b>( [ x[2]*y[3]-x[3]*y[2];  
                       x[3]*y[1]-x[1]*y[3];  
                       x[1]*y[2]-x[2]*y[1] ] );
</pre></blockquote>
</html>"));
end Cross;
  
  class Delay "delay" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>delay</font></h3>
<p>
Delay expression
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>delay</b>(expr, delayTime, delayMax)
<b>delay</b>(expr, delayTime)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<P>Returns <TT>\"expr(time - delayTime)\"</TT> for <TT>time &gt; time.start + delayTime</TT>
and <TT>\"expr(time.start)\"</TT> for <TT>time &le; time.start + delayTime</TT>. The
arguments, i.e., <tt>expr</tt>, <tt>delayTime</tt> and <tt>delayMax</tt>, need to be subtypes of Real.
<TT>delayMax</TT> needs to be additionally a parameter expression. The following relation
shall hold: <TT>0 &le; delayTime &le; delayMax</tt>, otherwise an error occurs. If
<tt>delayMax</tt> is not supplied in the argument list, <tt>delayTime</tt> need to be a
parameter expression.</P>
<p><i>[The <b>delay</b> operator allows a numerical sound implementation
by interpolating in the (internal) integrator polynomials, as well as a
more simple realization by interpolating linearly in a buffer containing
past values of expression expr. Without further information, the complete
time history of the delayed signals need to be stored, because the delay
time may change during simulation. To avoid excessive storage requirements
and to enhance efficiency, the maximum allowed delay time has to be given
via delayMax. This gives an upper bound on the values of the delayed
signals which have to be stored. For realtime simulation where fixed step
size integrators are used, this information is sufficient to allocate the
necessary storage for the internal buffer before the simulation starts.
For variable step size integrators, the buffer size is dynamic during
integration. In principal, a delay operator could break algebraic loops.
For simplicity, this is not supported because the minimum delay time has
to be give as additional argument to be fixed at compile time. Furthermore,
the maximum step size of the integrator is limited by this minimum delay
time in order to avoid extrapolation in the delay buffer.]</i></p>
<h3><font color=\"#008000\">Examples</font></h3>
<pre><b>model</b> Delay
  Real x;
  Real y;
<b>equation
  der</b>(x) = 2;
  y = <b>delay</b>(x, 1);
<b>end</b> Delay;</pre>
<p align=\"center\"><img src=\"../Images/delay.png\" width=\"400\" height=\"280\" alt=\"Simulation result\"></p>
</html>"));
  end Delay;
  
  class Der "der" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>der</font></h3>
<p>
Time derivative of expression
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>der</b>(expr)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<P>The time derivative of expression expr. 
If the expression expr is a scalar it needs to be a subtype of Real. The expression and all its subexpressions must be differentiable. If expr is an array, the operator is applied to all elements of the array. For Real parameters and
constants the result is a zero scalar or array of the same size as the
variable.</P>
<h3><font color=\"#008000\">Examples</font></h3>
<pre>  Real x, xdot1, xdot2;
<b>equation</b>
  xdot1 = <b>der</b>(x);
  xdot2 = <b>der</b>(x*sin(x));
</pre>
</html>"));
  end Der;
  
class Diagonal "diagonal" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>diagonal</font></h3>
<p>
Returns a diagonal matrix
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>diagonal</b>(v)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Returns a square matrix with the elements of vector v 
on the diagonal and all other elements zero.
</p>
</html>"));
end Diagonal;
  
  class Div "div" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>div</font></h3>
<p>
Integer part of division of two Real numbers
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>div</b>(x, y)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<P>Returns the algebraic quotient <TT>x/y</TT> with any
fractional part discarded (also known as truncation
toward zero). <I>[Note: this is defined for / in C99;
in C89 the result for negative numbers is
implementation-defined, so the standard function
<TT>div()</TT> must be used.]</I> Result and arguments
shall have type Real or Integer. If either of the
arguments is Real the result is Real otherwise Integer.</P>

<p><i>[Note, outside of a when clause state events are triggered
when the return value changes discontinuously.]</i></p>

<h3><font color=\"#008000\">Examples</font></h3>
<pre><b>div</b>(13,6)
 = 2</pre>
</html>"));
  end Div;
  
  class Edge "edge" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>edge</font></h3>
<p>
Indicate rising edge
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>edge</b>(b)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<P>Is expanded into &quot;(b <B>and not pre</B>(b))&quot;
for Boolean variable b. The same restrictions as for the
<B>pre</B> operator apply (e.g. not to be used in function
classes).</P>
<h3><font color=\"#008000\">Examples</font></h3>
<pre><b>model</b> RisingEdge
  Boolean u;
  Integer i;
<b>equation</b>
  u = Modelica.Math.sin(<b>time</b>) &gt; 0.5;
  <b>when</b> <b>edge</b>(u) <b>then</b>
    i = <b>pre</b>(i) + 1;
  <b>end when</b>;
<b>end</b> RisingEdge;</pre>
<p align=\"center\"><img src=\"../Images/edge.png\" width=\"400\" height=\"280\" alt=\"Simulation result\"></p>
</html>"));
  end Edge;
  
class Fill "fill" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>fill</font></h3>
<p>
Return a Real, Integer, Boolean or String array with all elements equal
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>fill</b>(s, n1, n2, n3, ...)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Returns the n1 x n2 x n3 x ... array with all elements equal 
to scalar or array expression s (ni >= 0). The returned 
array has the same type as s. Recursive definition:
<p>
<blockquote><pre>
fill(s,n1,n2,n3, ...) = fill(fill(s,n2,n3, ...), n1); 
fill(s,n) = {s,s,..., s}
</pre></blockquote>
<h3><font color=\"#008000\">Examples</font></h3>
<blockquote><pre>
Real    mr[2,2] = fill(-1,2,2);  // = [-1,-1;-1,-1]
Boolean vb[3]   = fill(true,3);  // = {true, true, true}
</pre></blockquote>
</html>"));
end Fill;
  
  class Floor "floor" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>floor</font></h3>
<p>
Round Real number towards minus infinity
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>floor</b>(x)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>Returns the largest integer not greater than <tt>x</tt>.
Result and argument shall have type Real. <i>[Note, outside
of a when clause state events are triggered when the return
value changes discontinuously.]</i></p>
<h3><font color=\"#008000\">Examples</font></h3>
<pre><b>floor</b>({-3.14, 3.14})
 = {-4.0, 3.0}</pre>
</html>"));
  end Floor;
  
class Identity "identity" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>identity</font></h3>
<p>
Returns the identity matrix of the desired size
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>identity</b>(n)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Returns the n x n Integer identity matrix, with ones 
on the diagonal and zeros at the other places.
</p>
</html>"));
end Identity;
  
  class Initial "initial" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>initial</font></h3>
<p>
True during initialization
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>initial</b>()</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>Returns <b>true</b> during the initialization phase and <b>false</b> otherwise.</p>
<h3><font color=\"#008000\">Examples</font></h3>
<pre>  Boolean off;
  Real x;
<b>equation</b>
  off = x &lt; -2 or <b>initial</b>();</pre>
</html>"));
  end Initial;
  
  class IntegerUpperCase "Integer" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>integer</font></h3>
<p>
Returns ordinal number of enumeration
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>Integer</b>(E.e1)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Returns the ordinal number of the enumeration value E.enumvalue, where Integer(E.e1)=1, Integer(E.en)= size(E), for an enumeration type E=enumeration(e1, ...,  en).</p>

<h3><font color=\"#008000\">Examples</font></h3>
<pre>  <b>type</b> Size = enumeration(small, medium, large, xlarge);
  <b>Integer</b>(Size.large) = 3</pre>


</html>"));
  end IntegerUpperCase;
  
  class IntegerLowerCase "integer" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>integer</font></h3>
<p>
Round Real number towards minus infinity
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>integer</b>(x)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>Returns the largest integer not greater than <tt>x</tt>.
The argument shall have type Real. The result has type Integer.</p>
<p><i>[Note, outside of a when clause state events are triggered
when the return value changes discontinuously.]</i></p>
<h3><font color=\"#008000\">Examples</font></h3>
<pre><b>integer</b>({-3.14, 3.14})
 = {-4, 3}</pre>
</html>"));
  end IntegerLowerCase;
  
  class IsPresent "isPresent" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>isPresent</font></h3>
<p>
Returns true if the formal input or output argument of a function is present
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>isPresent</b>(ident)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Returns true if the formal input or output argument ident is present 
as an actual argument of the function call. If the argument is not 
present, isPresent(ident) may return false <i>[but may also return 
true e.g. for implementations that always compute all results]</i>. 
isPresent() should be used for optimisation only and should not 
influence the results of outputs that are present in the output 
list. It can only be used in functions.
</p>
<h3><font color=\"#008000\">Examples</font></h3>
<blockquote>
<pre>
<b>function</b> eigenValues \"Compute eigenvalues and eigenvectors\" 
  <b>input</b>  Real A[:, size(A, 1)];
  <b>output</b> Real eigenvalues[size(A, 1), 2];
  <b>output</b> Real eigenvectors[size(A,1), size(A,2)];
<b>algorithm</b>
  // compute eigen values
  <b>if</b> <b>isPresent</b>(eigenvectors) <b>then</b>
     // compute eigen vectors
  <b>end</b> <b>if</b>;
<b>end</b> eigenValues;
        eval = eigenValues(A);  // compute only eigenvalues
(eval, evec) = eigenValues(A);  // compute eigenvalues and eigenvectors
</pre>
</blockquote>
</html>"));
    
  end IsPresent;
  
class Linspace "linspace" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>linspace</font></h3>
<p>
Return Real vector with equally spaced elements
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>linspace</b>(x1, x2, n)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Returns a Real vector with n equally spaced elements, 
such that 
</p>
<blockquote><pre>
v[i] = x1 + (x2-x1)*(i-1)/(n-1) for 1 &le; i &le; n. 
</pre></blockquote>
<p>
It is required that n &ge; 2. The arguments x1 and x2 shall 
be Real or Integer scalar expressions.
</p>
<h3><font color=\"#008000\">Examples</font></h3>
<blockquote><pre>
Real v[:] = linspace(1,7,2);  // = {1, 3, 5, 7}
</pre></blockquote>
</html>"));
end Linspace;
  
class Matrix "matrix" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>matrix</font></h3>
<p>
Returns the first two dimensions of an array as matrix
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>matrix</b>(A)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Returns <b>promote</b>(A,2), if A is a scalar or vector and 
otherwise returns the elements of the first two dimensions 
as a matrix. <b>size</b>(A,i) = 1 is required for 
2 &lt; i &le; <b>ndims</b>(A). 
</p>
<p>
Function <b>promote</b>(A,n) fills dimensions of size 1 
from the right to array A upto dimension n, where 
\"n &gt; <b>ndims</b>(A)\" is required. Let 
C = <b>promote</b>(A,n), with nA = <b>ndims</b>(A), 
then 
</p>
<blockquote><pre>
<b>ndims</b>(C) = n, 
<b>size</b>(C,j) = <b>size</b>(A,j) for 1 &le; j &le; nA, 
<b>size</b>(C,j) = 1 for nA+1 &le; j &le; n, 
C[i_1, ..., i_nA, 1, ..., 1] = A[i_1, ..., i_nA].
</pre></blockquote>
</html>"));
end Matrix;
  
class Max "max" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>max</font></h3>
<p>
Returns the largest element
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
<b>max</b>(A)
<b>max</b>(x,y)
<b>max</b>(e(i, ..., j) <b>for</b> i <b>in</b> u, ..., j <b>in</b> v)
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
The first form returns the largest element of array expression A.
</p>
<p>
The second form returns the largest element of the scalars x and y.
</p>
<p>
The third form is a reduction expression and 
returns the largest value of the 
scalar expression e(i, ..., j) evaluated for all 
combinations of i in u, ..., j in v
</p>
<h3><font color=\"#008000\">Examples</font></h3>
<blockquote><pre>
<b>max</b>(i^2 <b>for</b> i <b>in</b> {3,7,6})  // = 49
</pre></blockquote>
</html>"));
end Max;
  
class Min "min" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>min</font></h3>
<p>
Returns the smallest element
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
<b>min</b>(A)
<b>min</b>(x,y)
<b>min</b>(e(i, ..., j) <b>for</b> i <b>in</b> u, ..., j <b>in</b> v)
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
The first form returns the smallest element of array expression A.
</p>
<p>
The second form returns the smallest element of the scalars x and y.
</p>
<p>
The third form is a reduction expression and 
returns the smallest value of the 
scalar expression e(i, ..., j) evaluated for all 
combinations of i in u, ..., j in v
</p>
<h3><font color=\"#008000\">Examples</font></h3>
<blockquote><pre>
<b>min</b>(i^2 <b>for</b> i <b>in</b> {3,7,6})  // = 9
</pre></blockquote>
</html>"));
end Min;
  
  class Mod "mod" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>mod</font></h3>
<p>
Integer modulus of a division of two Real numbers
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>mod</b>(x, y)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<P>Returns the integer modulus of <TT>x/y</TT>, i.e. mod(x, y) = x - floor(x/y)*y.
Result and arguments shall have type Real or Integer. If either of the
arguments is Real the result is Real otherwise Integer. <I>[Note, outside of
a when clause state events are triggered when the return value changes
discontinuously.]</I></P>
<h3><font color=\"#008000\">Examples</font></h3>
<pre><b>mod</b>(3,1.4)
 = 0.2
<b>mod</b>(-3,1.4)
 = 1.2
<b>mod</b>(3,-1.4)
 = -1.2</pre>
</html>"));
  end Mod;
  
class Ndims "ndims" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>ndims</font></h3>
<p>
Return number of array dimensions
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>ndims</b>(A)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Returns the number of dimensions k of array expression 
A, with k >= 0.
</p>
<h3><font color=\"#008000\">Examples</font></h3>
<blockquote><pre>
Real A[8,4,5];
Integer n = ndims(A);  // = 3
</pre></blockquote>
</html>"));
end Ndims;
  
  class NoEvent "noEvent" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>noEvent</font></h3>
<p>
Turn off event triggering
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>noEvent</b>(expr)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>Real elementary relations within expr are taken literally, i.e., no state or time event is triggered.</p>
<h4>smooth vs. noEvent</h4>
<p>The noEvent operator implies that real elementary expressions are taken
literally instead of generating crossing functions. The smooth operator
should be used instead of noEvent, in order to avoid events for efficiency
reasons. A tool is free to not generate events for expressions inside smooth.
However, smooth does not guarantee that no events will be generated, and thus
it can be necessary to use noEvent inside smooth. <I>[Note that smooth does
not guarantee a smooth output if any of the occurring variables change
discontinuously.]</i></p>
<p><i>[Example:</i></p>
<PRE>  Real x, y, z;
<B>equation</B>
  x = <B>if</B> time&lt;1 <B>then</B> 2 <B>else</B> time-2;
  z = smooth(0, <B>if</B> time&lt;0 <B>then</B> 0 <B>else</B> time);
  y = smooth(1, noEvent(<B>if</B> x&lt;0 <B>then</B> 0 <B>else</B> sqrt(x)*x));
  // noEvent is necessary.</PRE>
<p><i>]</i></p>
<h3><font color=\"#008000\">Examples</font></h3>
<pre>der(h)=<B>if noEvent</B>(h&gt;0) <B>then</B> -c*sqrt(h) <B>else</B> 0;</pre>
</html>"));
  end NoEvent;
  
class Ones "ones" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>ones</font></h3>
<p>
Returns an array with \"1\" elements
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>ones</b>(n1, n2, n3, ...)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Return the n1 x n2 x n3 x ... Integer array with all 
elements equal to one (ni >=0 ).
</p>
</html>"));
end Ones;
  
class OuterProduct "outerProduct" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>outerProduct</font></h3>
<p>
Returns the outer product of two vectors
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>outerProduct</b>(v1,v2)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Returns the outer product of vectors v1 and v2 <br>
(= matrix(v)*transpose( matrix(v) ) ).
</p>
</html>"));
end OuterProduct;
  
  class Pre "pre" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>pre</font></h3>
<p>
Refer to left limit
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>pre</b>(y)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<P>Returns the &quot;left limit&quot; y(t<SUP>pre</SUP>)
of variable y(t) at a time instant t. At an event instant,
y(t<SUP>pre</SUP>) is the value of y after the last event
iteration at time instant t. The
<B>pre</B> operator can be applied if the following three
conditions are fulfilled simultaneously:</p>
<ul>
  <li>variable y is a subtype of a simple type</li>
  <li>y is a discrete-time expression</li>
  <li>the operator is <B>not</B> applied in a <B>function</B> class</li>
</ul>
<p>The first value of <B>pre</B>(y) is
determined in the initialization phase.</P>
<P>A new event is triggered if at least for one variable v
&quot;<B>pre</B>(v) &lt;&gt; v&quot; after the active model
equations are evaluated at an event instant. In this case
the model is at once reevaluated. This evaluation sequence
is called &quot;<I>event iteration</I>&quot;. The integration
is restarted, if for all v used in <B>pre</B>-operators the
following condition holds: &quot;<B>pre</B>(v) == v&quot;.</P>
<p><I>[If v and <B>pre</B>(v) are only used in when clauses,
the translator might mask event iteration for variable v since
v cannot change during event iteration. It is a &quot;quality
of implementation&quot; to find the minimal loops for event
iteration, i.e., not all parts of the model need to be
reevaluated.</i></p>
<p><i>The language allows mixed algebraic systems of equations
where the unknown variables are of type Real, Integer, Boolean,
or an enumeration. These systems of equations can be solved by
a global fix point iteration scheme, similarly to the event
iteration, by fixing the Boolean,  Integer, and/or enumeration
unknowns during one iteration. Again, it is a quality of
implementation to solve these systems more efficiently, e.g.,
by applying the fix point iteration scheme to a subset of the
model equations.]</I></p>
<h3><font color=\"#008000\">Examples</font></h3>
<pre><b>model</b> Hysteresis
  Real u;
  Boolean y;
<b>equation</b>
  u = Modelica.Math.sin(<b>time</b>);
  y = u &gt; 0.5 or <b>pre</b>(y) and u &gt;= -0.5;
<b>end</b> Hysteresis;</pre>
<p align=\"center\"><img src=\"../Images/pre.png\" width=\"400\" height=\"280\" alt=\"Simulation result\"></p>
</html>"));
  end Pre;
  
class Product "product" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>product</font></h3>
<p>
Returns the scalar product
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
<b>product</b>(A)
<b>product</b>(e(i, ..., j) <b>for</b> i <b>in</b> u, ..., j <b>in</b> v)
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
The first form returns the scalar product of all the elements of 
array expression A:<br>
A[1,...,1]*A[2,...,1]*....*A[end,...,1]*A[end,...,end]
</p>
<p>
The second form is a reduction expression and 
returns the product of the expression e(i, ..., j) evaluated for all combinations of i in u, ..., j in v:
</p>
<blockquote><pre>
e(u[1],...,v[1]) * e(u[2],...,v[1]) * ... *
e(u[end],...,v[1]) * ... * e(u[end],...,v[end])
</pre></blockquote>
<p>
The type of <b>product</b>(e(i, ..., j) <b>for</b> i <b>in</b>
u, ..., j <b>in</b> v) is the same as the type of e(i,...j).
</p>
<h3><font color=\"#008000\">Examples</font></h3>
<blockquote><pre>
{<b>product</b>(j <b>for</b> j <b>in</b> 1:i) <b>for</b> i <b>in</b> 0:4} // = {1,1,2,6,24}
</pre></blockquote>
</html>"));
end Product;
  
  class Reinit "reinit" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>reinit</font></h3>
<p>
Reinitialize state variable
</p>
<h3><font color=\"#008000\">Examples</font></h3>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>reinit</b>(x, expr)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<P>Reinitializes state variable x with expr at an event
instant. Argument x need to be</p>
<ul>
  <li>a subtype of Real and</li>
  <li>the <B>der</B>-operator need to be applied to it.</li>
</ul>
<p>expr need to be an Integer or Real expression. The
reinit operator can only be applied once for the same
variable x. It can only be applied in the body of a
when-clause.</P>
<p>The <B>reinit</B> operator does not break the single
assignment rule, because <B>reinit</B>(x, expr) makes
the previously known state variable x unknown and
introduces the equation &quot;x = expr&quot;.</p>
<p><I>[If a higher index system is present, i.e.
constraints between state variables, some state variables
need to be redefined to non-state variables. If possible,
non-state variables should be chosen in such a way that
states with an applied <B>reinit</B> operator are not
utilized. If this is not possible, an error occurs,
because the reinit operator is applied on a non-state variable.]</i></P>
<PRE>Bouncing ball:
    <B>der</B>(h) = v;
    <B>der</B>(v) = -g;
    <B>when</B> h &lt; 0 <B>then</B>
      <B>reinit</B>(v, -e*v);
    <B>end when</B>;</PRE>
</html>"));
  end Reinit;
  
  class Rem "rem" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>rem</font></h3>
<p>
Integer remainder of the division of two Real numbers
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>rem</b>(x, y)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<P>Returns the integer remainder of <TT>x/y</TT>,
such that <TT>div(x,y) * y + rem(x, y) = x</TT>.
Result and arguments shall have type Real or
Integer. If either of the arguments is Real the
result is Real otherwise Integer. <I>[Note, outside
of a when clause state events are triggered when
the return value changes discontinuously.]</I></P>
<h3><font color=\"#008000\">Examples</font></h3>
<pre><b>rem</b>(3,1.4)
 = 0.2
<b>rem</b>(-3,1.4)
 = -0.2
<b>rem</b>(3,-1.4)
 = 0.2</pre>
</html>"));
  end Rem;
  
  class Sample "sample" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>sample</font></h3>
<p>
Trigger time events
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>sample</b>(start, interval)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<P>Returns true and triggers time events at time instants
<TT>&quot;start + i*interval&quot; (i=0, 1, ...)</TT>.
During continuous integration the operator returns always
false. The starting time &quot;start&quot; and the sample
interval &quot;interval&quot; need to be parameter
expressions and need to be a subtype of Real or Integer.
</P>
<h3><font color=\"#008000\">Examples</font></h3>
<pre><b>model</b> Sampling
  Integer i;
<b>equation</b>
  <b>when</b> <b>sample</b>(1, 0.1) <b>then</b>
    i = <b>pre</b>(i) + 1;
  <b>end when</b>;
<b>end</b> Sampling;</pre>
<p align=\"center\"><img src=\"../Images/sample.png\" width=\"400\" height=\"280\" alt=\"Simulation result\"></p>
</html>"));
  end Sample;
  
class Scalar "scalar" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>scalar</font></h3>
<p>
Returns a one-element array as scalar
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>scalar</b>(A)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Returns the single element of array A. 
<b>size</b>(A,i) = 1 is required for 1 &le; i &le; <b>ndims</b>(A).
</p>
<h3><font color=\"#008000\">Examples</font></h3>
<blockquote><pre>
Real A[1,1,1] = {{{3}}};
Real e = scalar(A);  // = 3
</pre></blockquote>
</html>"));
end Scalar;
  
  class SemiLinear "semiLinear" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>semiLinear</font></h3>
<p>
Returns \"if x >= 0 then positiveSlope*x else negativeSlope*x\" and handle x=0 in a meaningful way
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>semiLinear</b>(x, positiveSlope, negativeSlope)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Returns \"if x >= 0 then positiveSlope*x else negativeSlope*x\".
In some situations, equations with the semiLinear function 
become underdetermined if the first argument (x) becomes 
zero, i.e., there are an infinite number of solutions. 
It is recommended that the following rules are used to 
transform the equations during the translation phase in 
order to select one meaningful solution in such cases:
</p>
<p>
<b>Rule 1</b>: The equations
</p>
<blockquote>
<pre>
y = <b>semiLinear</b>(x, sa, s1);
y = <b>semiLinear</b>(x, s1, s2);
y = <b>semiLinear</b>(x, s2, s3);
   ...
y = <b>semiLinear</b>(x, sN, sb);
</pre>
</blockquote>
<p>
may be replaced by
</p>
<blockquote>
<pre>
s1 = <b>if</b> x >= 0 <b>then</b> sa <b>else</b> sb
s2 = s1;
s3 = s2;
   ...
sN = sN-1;
y = <b>semiLinear</b>(x, sa, sb);
</pre>
</blockquote>
<p>
<b>Rule 2</b>: The equations
</p>
<blockquote>
<pre>
x = 0;
y = 0;
y = <b>semiLinear</b>(x, sa, sb);
</pre>
</blockquote>
<p>
may be replaced by
</p>
<blockquote>
<pre>
x = 0
y = 0;
sa = sb;
</pre>
</blockquote>
<p>
<i> [For symbolic transformations, the following property is 
useful (this follows from the definition):</i>
</p>
<blockquote>
<pre>
<b>semiLinear</b>(m_flow, port_h, h);
</pre>
</blockquote>
<p>
is identical to 
</p>
<blockquote><pre>
-<b>semiLinear</b>(-m_flow, h, port_h);
</pre></blockquote>
<p>
<i> The semiLinear function is designed to handle reversing 
flow in fluid systems, such as</i>
</p>
<blockquote><pre>
H_flow = <b>semiLinear</b>(m_flow, port.h, h);
</pre></blockquote>
<p>
<i> i.e., the enthalpy flow rate H _flow is computed from the mass flow 
rate m_flow and the upstream specific enthalpy depending on the 
flow direction.]</i>
</p>
</html>"));
  end SemiLinear;
  
  class Sign "sign" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>sign</font></h3>
<p>
Signum function of a Real or Integer number
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>sign</b>(v)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>Is expanded into &quot;noEvent(<b>if</b> v &gt; 0 <b>then</b> 1 <b>else
if</b> v &lt; 0 <b>then</b> -1 <b>else</b> 0)&quot;. Argument v
needs to be an Integer or Real expression. <i>[Note, outside of a
when clause state events are triggered.]</i></p>
<h3><font color=\"#008000\">Examples</font></h3>
<pre><b>sign</b>({-3, 0, 3})
 = {-1, 0, 1}</pre>
</html>"));
  end Sign;
  
  class Sin "sin" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>sin</font></h3>
<p>
Trigonometric sine function
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>sin</b>(v)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>Returns the sine of v.
Argument v needs to be an Integer or Real expression.</p>
<h3><font color=\"#008000\">Examples</font></h3>
<pre><b>sin</b>(3.14159265358979)
 = 0.0</pre>
</html>"));
  end Sin;
  
class Size "size" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>size</font></h3>
<p>
Returns dimensions of an array
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
   <b>size</b>(A,i)
   <b>size</b>(A)
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
The first form returns the size of dimension i of array expression A 
where i shall be &gt; 0 and &le; <b>ndims</b>(A).
</p>
<p>
The second form returns a vector of length <b>ndims</b>(A) 
containing the dimension sizes of A.
</p>
<h3><font color=\"#008000\">Examples</font></h3>
<blockquote><pre>
Real A[8,4,5];
Integer n3   = size(A,3);  // = 5
Integer n[:] = size(A);    // = {8,4,5}
</pre></blockquote>
</html>"));
end Size;
  
class Skew "skew" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>skew</font></h3>
<p>
Returns the skew matrix that is associated with a vector
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>skew</b>(x)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Returns the 3 x 3 skew symmetric matrix associated with a 
3-vector, i.e.,
</p>
<blockquote><pre>
<b>cross</b>(x,y) = <b>skew</b>(x)*y;  
<b>skew</b>(x) = [ 0   , -x[3],  x[2];  
            x[3],  0   , -x[1];  
           -x[2],  x[1],  0   ];
</pre></blockquote>
</html>"));
end Skew;
  
  class Smooth "smooth" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>smooth</font></h3>
<p>
Indicate smoothness of expression
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>smooth</b>(p, expr)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<P>If p&gt;=0 <B>smooth</B>(p, expr) returns expr and states
that expr is p times continuously differentiable, i.e.: expr
is continuous in all real variables appearing in the expression
and all partial derivatives with respect to all appearing real
variables <B>exist</B> and are continuous up to order p.</p>
<p>The only allowed types for expr in smooth are: real expressions,
arrays of allowed expressions, and records containing only
components of allowed expressions.</P>
<h4>smooth vs. noEvent</h4>
<p>The noEvent operator implies that real elementary expressions are taken
literally instead of generating crossing functions. The smooth operator
should be used instead of noEvent, in order to avoid events for efficiency
reasons. A tool is free to not generate events for expressions inside smooth.
However, smooth does not guarantee that no events will be generated, and thus
it can be necessary to use noEvent inside smooth. <I>[Note that smooth does
not guarantee a smooth output if any of the occurring variables change
discontinuously.]</I></p>
<h3><font color=\"#008000\">Examples</font></h3>
<PRE>  Real x, y, z;
<B>equation</B>
  x = <B>if</B> time&lt;1 <B>then</B> 2 <B>else</B> time-2;
  z = smooth(0, <B>if</B> time&lt;0 <B>then</B> 0 <B>else</B> time);
  y = smooth(1, noEvent(<B>if</B> x&lt;0 <B>then</B> 0 <B>else</B> sqrt(x)*x));
  // noEvent is necessary.</PRE>
</html>"));
  end Smooth;
  
  class Sqrt "sqrt" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>sqrt</font></h3>
<p>
Square root
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>sqrt</b>(v)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>Returns the square root of v if v&gt;=0, otherwise an error occurs.
Argument v needs to be an Integer or Real expression.</p>
<h3><font color=\"#008000\">Examples</font></h3>
<pre><b>sqrt</b>(9)
 = 3.0</pre>
</html>"));
  end Sqrt;
  
  class string "String" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>String</font></h3>
<p>
Convert a scalar Real, Integer or Boolean expression to a String representation
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote>
<pre>
<b>String</b>(b_expr, minimumLength=0, leftJustified=true)
<b>String</b>(i_expr, minimumLength=0, leftJustified=true)
<b>String</b>(r_expr, significantDigits=6, minimumLength=0, leftJustified=true)
<b>String</b>(r_expr, format)
<b>String</b>(e_expr, minimumLength=0, leftJustified=true)
</pre>
</blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
The arguments have the following meaning
(the default values of the optional arguments are shown in the left column):
</p>
<table border=1 cellspacing=0 cellpadding=2>
<tr>
  <td> Boolean b_expr</td>
  <td> Boolean expression</td></tr>
<tr>
  <td> Integer i_expr</td>
  <td> Integer expression</td></tr>
<tr>
  <td> Real r_expr</td>
  <td> Real expression</td></tr>
<tr>
  <td> type e_expr = enumeration(..)</td>
  <td> Enumeration expression</td></tr>
<tr>
  <td> Integer minimumLength = 0 </td>
  <td> Minimum length of the resulting string. If necessary, <br>
       the blank character is used to fill up unused space.</td></tr>
<tr>
  <td> Boolean leftJustified = <b>true</b> </td>
  <td> if <b>true</b>, the converted result is left justified;<br> 
       if <b>false</b>, it is right justified in the string.</td></tr>
<tr>
  <td> Integer significantDigits = 6 </td>
  <td> defines the number of significant digits in the result string<br>
       (e.g. \"12.3456\", \"0.0123456\", \"12345600\", \"1.23456E-10\")</td></tr>
<tr>
  <td> String format </td> 
  <td> defines the string formating according to ANSI-C without \"%\" and \"*\" character<br> 
       (e.g. \".6g\", \"14.5e\", \"+6f\"). In particular:<br>
&nbsp;&nbsp;&nbsp;&nbsp;
format = \"[&lt;flags&gt;] [&lt;width&gt;] [.&lt;precision&gt;] &lt;conversion&gt;\"<br>
with
<table>
<tr>
  <td>&lt;flags&gt;</td>
  <td> zero, one or more of<br>
       \"-\": left adjustment of the converted number<br>
       \"+\": number will always be printed with a sign<br>
       \"0\": padding to the field width with leading zeros</td></tr>
<tr>
  <td>&lt;width&gt;</td>
  <td> Minimum field width. The converted number will be printed in a field at<br>
       least this wide and wider if necessary. If the converted number has <br>
       fewer characters it will be padded on the left (or the right depending<br>
       on &lt;flags&gt;) with blanks or 0 (depending on &lt;flags&gt;).</td></tr>
<tr>
  <td>&lt;precision&gt;</td>
  <td> The number of digits to be printed after the decimal point for <br>
       e, E, or f conversions, or the number of significant digits for <br>
       g or G conversions.</td></tr>
<tr>
  <td> &lt;conversion&gt;</td>
  <td> = \"e\": Exponential notation using a  lower case e<br>
       = \"E\": Exponential notation using an upper case E<br>
       = \"f\": Fixed point notation<br>
       = \"g\": Either \"e\" or \"f\"<br>
       = \"G\": Same as \"g\", but with upper case E</td></tr></table>
</table>
<h3><font color=\"#008000\">Examples</font></h3>
<blockquote>
<pre>
String(2.0)   // = \"2.0\"
String(true)  // = \"true\"
String(123, minimumLength=6, leftJustified=false)  // = \"   123\"
</pre>
</blockquote>
</html>"));
  end string;
  
class Sum "sum" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>sum</font></h3>
<p>
Returns the scalar sum
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
<b>sum</b>(A)
<b>sum</b>(e(i, ..., j) <b>for</b> i <b>in</b> u, ..., j <b>in</b> v)
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
The first form returns the scalar sum of all the elements of 
array expression A:<br>
A[1,...,1]+A[2,...,1]+....+A[end,...,1]+A[end,...,end]
</p>
<p>
The second form is a reduction expression and 
returns the sum of the expression e(i, ..., j) evaluated for all combinations of i in u, ..., j in v:
</p>
<blockquote><pre>
e(u[1],...,v[1]) + e(u[2],...,v[1]) + ... +
e(u[end],...,v[1]) + ... + e(u[end],...,v[end])
</pre></blockquote>
<p>
The type of <b>sum</b>(e(i, ..., j) <b>for</b> i <b>in</b>
u, ..., j <b>in</b> v) is the same as the type of e(i,...j).
</p>
<h3><font color=\"#008000\">Examples</font></h3>
<blockquote><pre>
<b>sum</b>(i <b>for</b> i <b>in</b> 1:10)  // Gives  1+2+...+10=55
   // Read it as: compute the sum of i for i in the range 1 to 10.
</pre></blockquote>
</html>"));
end Sum;
  
class Symmetric "symmetric" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>symmetric</font></h3>
<p>
Returns a symmetric matrix
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>symmetric</b>(A)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Returns a matrix where the diagonal elements and the 
elements above the diagonal are identical to the 
corresponding elements of matrix A and where the 
elements below the diagonal are set equal to the elements 
above the diagonal of A, i.e., 
<p>
<blockquote><pre>
B := <b>symmetric</b>(A) 
     -> B[i,j] := A[i,j], <b>if</b> i &le; j, 
        B[i,j] := A[j,i], <b>if</b> i &gt; j.
</pre></blockquote>
</html>"));
end Symmetric;
  
  class Terminal "terminal" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>terminal</font></h3>
<p>
True after successful analysis
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>terminal</b>()</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>Returns <b>true</b> at the end of a successful analysis.</p>
<h3><font color=\"#008000\">Examples</font></h3>
<pre>  Boolean a, b;
<b>equation</b>
  a = <b>change</b>(b) or <b>terminal</b>();</pre>
</html>"));
  end Terminal;
  
  class Terminate "terminate" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>terminate</font></h3>
<p>
Successfully terminate current analysis
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>terminate</b>(message)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<P>The terminate function successfully terminates the analysis
which was carried out. The function has a string argument
indicating the reason for the success. <I>[The intention is to
give more complex stopping criteria than a fixed point in time.]</I></P>
<h3><font color=\"#008000\">Examples</font></h3>
<pre><B>model</B> ThrowingBall
  Real x(start=0);
  Real y(start=1);
<B>equation</B>
  <b>der</b>(x)= ... ;
  <b>der</b>(y)= ... ;
<B>algorithm</B>
  <B>when</B> y &lt; 0 <B>then</B>
    <b>terminate</b>(\"The ball touches the ground\");
  <B>end when;
end</B> ThrowingBall;</pre>
</html>"));
  end Terminate;
  
class Transpose "transpose" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>tranpose</font></h3>
<p>
Transpose of a matrix or permutation of the first two dimensions of an array
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>transpose</b>(A)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Permutes the first two dimensions of array A. 
It is an error, if array A does not have at least 
2 dimensions.
</p>
</html>"));
end Transpose;
  
class Vector "vector" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>vector</font></h3>
<p>
Returns an array with one non-singleton dimension as vector
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>vector</b>(A)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Returns a 1-vector, if A is a scalar and otherwise returns a vector containing all the elements of the array, provided there is at 
most one dimension size > 1. 
</p>
<h3><font color=\"#008000\">Examples</font></h3>
<blockquote><pre>
Real A[1,2,1] = {{{3},{4}}};
Real v[2] = vector(A);  // = {3,4}
</pre></blockquote>
</html>"));
end Vector;
  
class Zeros "zeros" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>zero</font></h3>
<p>
Returns a zero array.
</p>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre><b>zeros</b>(n1, n2, n3, ...)</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Returns the n1 x n2 x n3 x ... Integer array with all 
elements equal to zero (ni >= 0).
</p>
</html>"));
end Zeros;
end Operators;


class BalancedModel "balanced model" 
  
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>balanced models</font></h3>
<p>
The basic concept to count unknowns and equations.
</p>

<p>
Restrictions for model and block classes are present, in order that missing
or too many equations can be detected and localized by a Modelica
translator before using the respective model or block class.
</p>

<h3><font color=\"#008000\">Examples</font></h3>

<pre>   <b>partial model</b> BaseCorrelation
     <b>input</b> Real x;
     Real y;
   <b>end</b> BaseCorrelation;

   <b>model</b> SpecialCorrelation // correct in Modelica 2.2 and 3.0
      <b>extends</b> BaseCorrelation(x=2);
   <b>equation</b>
       y=2/x;
   <b>end</b> SpecialCorrelation;

   <b>model</b> UseCorrelation // correct according to Modelica 2.2
                        // not valid according to Modelica 3.0
      <b>replaceable model</b> Correlation=BaseCorrelation;
      Correlation correlation;
   <b>equation</b>
      correlation.y=time;
   <b>end</b> UseCorrelation;

   <b>model</b> Broken // after redeclaration, there is 1 equation too much in Modelica 2.2
      UseCorrelation example(redeclare Correlation=SpecialCorrelation);
   <b>end</b> Broken;
</pre>

<p>
In this case one can argue that both UseCorrelation (adding an acausal equation) and SpecialCorrelation (adding a default to an input) are correct, but still when combined they lead to a model with too many equations - and it is not possible to determine which model is incorrect without strict rules.
In Modelica 2.2, model Broken will work with some models. However, by just redeclaring it to model SpecialCorrelation, an error will occur and it will be very difficult in a larger model to figure out the source of this error. 
In Modelica 3.0, model UseCorrelation is no longer allowed and the translator will give an error. In fact, it is guaranteed that a redeclaration cannot lead to an unbalanced model any more.
</p>


<h3><font color=\"#008000\">Description</font></h3>

<p>
The restrictions below apply after flattening \" i.e. inherited components are included \" possibly modified. 
</p>

<p>
<b>Definition 1: Local Number of Unknowns</b>
</p>

<p>
The local number of unknowns of a model or block class is the sum based on the components:
</p>

<ul>
<li> For each declared component of specialized class type (Real, Integer, String, Boolean, enumeration and arrays of those, etc) or record, not declared as outer, it is the \"number of unknown variables\" inside it (i.e., excluding parameters and constants and counting the elements after expanding all records and arrays to a set of scalars of primitive types). </li>

<li> Each declared component  of specialized class type or record declared as outer is ignored [i.e., all variables inside the component are treated as known].</li>

<li> For each declared component of specialized class connector component, it is the \"number of unknown variables\" inside it (i.e., excluding parameters and constants and counting the elements after expanding all records and arrays to a set of scalars of primitive types).</li>

<li> For each declared component of specialized class block or model, it is the \"sum of the number of inputs and flow variables\" in the (top level) public connector components of these components (and counting the elements after expanding all records and arrays to a set of scalars of primitive types).</li>
</ul>


<p>
<b>Definition 2: Local Equation Size </b>
</p>

<p>
The local equation size of a model or block class is the sum of the following numbers: 
</p>

<ul>
<li>The number of equations defined locally (i.e. not in any model or block component), including binding equations, and equations generated from connect-equations. This includes the proper count for when-clauses, and algorithms, and is also used for the flat Hybrid DAE formulation.</li>

<li> The number of input and flow-variables present in each (top-level) public connector component. [This represents 
the number of connection equations that will be provided when the class is used.]</li>

<li> The number of (top level) public input variables that neither are connectors nor have binding equations [i.e., top-level inputs are treated as known variables. This represents the number of binding equations that will be provided when the class is used.].
[To clarify top-level inputs without binding equation (for non-inherited inputs binding equation is identical to declaration equation, but binding equations also include the case where another model extends M and has a modifier on \"u\" giving the value):
<pre>  model M
    input Real u;
    input Real u2=2;
  end M;
</pre>
Here \"u\" and \"u2\" are top-level inputs and not connectors. The variable u2 has a binding equation, but u does not have a binding equation. In the equation count, it is assumed that an equation for u is supplied when using the model.]</li>
</ul>

<p>
<b>Definition 3: Locally Balanced</b>
</p>

<p>
A model or block class is \"locally balanced\" if the \"local number of unknowns\" is identical to the \"local equation size\" for all legal values of constants and parameters [respecting final bindings and min/max-restrictions. A tool shall verify the \"locally balanced\" property for the actual values of parameters and constants in the simulation model. It is a quality of implementation  for a tool to verify this property in general, due to arrays of (locally) undefined sizes, conditional declarations, for loops etc].
</p>


<p>
<b>Definition 4: Globally Balanced</b>
</p>

<p>
Similarly as locally balanced, but including all unknowns and equations from all components. The global number of unknowns is computed by expanding all unknowns (i.e. excluding parameters and constants) into a set of scalars of primitive types. This should match the global equation size defined as:
</p>

<ul>
<li> The number of equations defined (included in any model or block component), including equations generated from connect-equations.</li>
<li>The number of input and flow-variables present in each (top-level) public connector component.</li>
<li> The number of (top level) public input variables that neither are connectors nor have binding equations [i.e., top-level inputs are treated as known variables].</li>
</ul>

<p>
The following restrictions hold: 
</p>

<ul>
<li>In a non-partial model or block, all non-connector inputs of model or block components must have binding equations. [E.g. if the model contains a component, firstOrder (of specialized class model) and firstOrder has  \"input Real u\" then there must be a binding equation for firstOrder.u.] </li>
<li>A component declared with the inner or outer prefix shall not be of a class having top-level public connectors containing inputs.</li>
<li>Modifiers for components shall only contain redeclarations of replaceable elements and binding equations for parameters, constants (that do not yet have binding equations), inputs and variables having a default binding equation.</li>
<li>All non-partial model and block classes must be locally balanced [this means that the local number of unknowns equals the local equation size].</li>
</ul>

<p>
Based on these restrictions, the following strong guarantee can be given for simulation models and blocks:
</p>


<p>
<b>Proposition 1: All simulation models and blocks are globally balanced.</b><br>
[Therefore the number of unknowns equal to the number of equations of a simulation model or block, provided that every used non-partial model or block class is locally balanced.] 
</p>

<pre>Example 1:

connector Pin
   Real v;
   flow Real i;
end Pin;

model Capacitor
   parameter Real C;
   Pin  p, n;
   Real u;
equation
   0 = p.i + n.i;
   u = p.v - n.v;
   C*der(u) = p.i;
end Capacitor;
</pre>

<p>
Model Capacitor is a locally balanced model according to the following analysis:
</p>

<pre>Locally unknown variables: p.i, p.v, n.i, n.v, u
Local equations:  0 = p.i + n.i;
                  u = p.v - n.v;
                  C*der(u) = p.i;
                  and 2 equations corresponding to the 
                  2 flow-variables p.i and n.i.
</pre>

<p>
These are 5 equations in 5 unknowns (locally balanced model). A more detailed analysis would reveal that this is structurally non-singular, i.e. that the hybrid DAE will not contain a singularity independent of actual values.
If the equation \"u = p.v - n.v\" would be missing in the Capacitor model, there would be 4 equations in 5 unknowns and the model would be locally unbalanced and thus simulation models in which this model is used would be usually  structurally singular and  thus not solvable.
If the equation \"u = p.v - n.v\" would be replaced by the equation \"u = 0\" and the equation C*der(u) = p.i would be replaced by the equation \"C*der(u) = 0\", there would be 5 equations in 5 unknowns (locally balanced), but the equations would be singular, regardless of how the equations corresponding to the flow-variables are constructed because the information that \"u\" is constant is given twice in a slightly different form.
</p>

<pre>Example 2:

connector Pin
   Real v;
   flow Real i;
end Pin;

partial model TwoPin
   Pin p,n;
end TwoPin;

model Capacitor
   parameter Real C;
   extends TwoPin;
   Real u;
equation
   0 = p.i + n.i;
   u = p.v \" n.v;
   C*der(u) = p.i;
end Capacitor;

model Circuit
   extends TwoPin;
   replaceable TwoPin t;
   Capacitor c(C=12);
equation
   connect(p, t.p);
   connect(t.n, c.p);
   connect(c.n, n);
end Circuit;
</pre>

<p>
Since t is partial we cannot check whether this is a globally balanced model, but we can check that Circuit is locally balanced.
Counting on  model Circuit results in the following balance sheet:
</p>

<pre>Locally unknown variables (8): p.i, p.v, n.i, n.v, and 2 flow variables for t (t.p.i, t.n.i)  
                                                   and 2 flow variable for c (c.p.i, c.n.i).
Local equations:     p.v = t.p.v;
                       0 = p.i - t.p.i;
                   c.p.v = load.n.v;
                       0 = c.p.i+load.n.i;
                     n.v = c.n.v;
                       0 = n.i - c.n.i;
                    and 2 equation corresponding to the 
                    flow variables p.i, n.i
</pre>

<p>
In total we have 8 scalar unknowns and 8 scalar equations, i.e., a locally balanced model (and this feature holds for any models used for the replaceable component \"t\"). 
Some more analysis reveals that this local set of equations and unknowns is structurally non-singular. However, this does not provide any guarantees for the global set of equations, and specific combinations of models that are \"locally non-singular\" may lead to a globally non-singular model.]
</p>

<pre>Example 3:

import SI = Modelica.SIunits;
partial model BaseProperties
   \"Interface of medium model for all type of media\"
   parameter Boolean preferredMediumStates=false;
   constant  Integer nXi \"Number of independent mass fractions\";
   InputAbsolutePressure     p;
   InputSpecificEnthalpy     h;
   InputMassFraction         Xi[nXi];
   SI.Temperature            T;
   SI.Density                d;
   SI.SpecificInternalEnergy u;

   connector InputAbsolutePressure = input SI.AbsolutePressure;
   connector InputSpecificEnthalpy = input SI.SpecificEnthalpy;
   connector InputMassFraction = input SI.MassFraction;
end BaseProperties;
</pre>

<p>
The use of connector here is a special design pattern. The variables p, h, Xi are marked as input to get correct equation count. Since they are connectors they should neither be given binding equations in derived classes nor when using the model. The design pattern is to give textual equations for them (as below); using connect-statements for these connectors would be possible (and would work) but is not part of the design.
This partial model defines that T,d,u can be computed from the medium model, provided p,h,Xi are given. Every medium with one or multiple substances and one or multiple phases, including incompressible media, has the property that T,d,u can be computed from p,h,Xi. A particular medium may have different \"independent variables\" from which all other intrinsic thermodynamic variables can be recursively computed. For example, a simple air model could be defined as:
</p>

<pre>model SimpleAir \"Medium model of simple air. Independent variables: p,T\"
   extends BaseProperties(nXi = 0, 	
        p(stateSelect = if preferredMediumStates then StateSelect.prefer 
                                   else StateSelect.default),
        T(stateSelect = if preferredMediumStates then StateSelect.prefer 
                                   else StateSelect.default));
   constant SI.SpecificHeatCapacity R  = 287;
   constant SI.SpecificHeatCapacity cp = 1005.45;
   constant SI.Temperature          T0 = 298.15
equation
   d = p/(R*T);
   h = cp*(T-T0);
   u = h \" p/d;
end SimpleAir;
</pre>

<p>
The local number of unknowns in model SimpleAir (after flattening) is:
</p>

<ul>
<li> 3 (T, d, u: variables defined in BaseProperties and inherited in SimpleAir), plus</li>
<li> 2+nXi (p, h, Xi: variables inside connectors defined in BaseProperties and inherited in SimpleAir)
resulting in 5+nXi unknowns.</li>
</ul>

<p>
The local equation size is:
</p>

<ul>
<li> 3 (equations defined in SimpleAir), plus</li>
<li> 2+nXi (input variables in the connectors inherited from BaseProperties)</li>
</ul>

<p>
Therefore, the model is locally balanced. 
The generic medium model BaseProperties is used as a replaceable model in different components, like a dynamic volume or a fixed boundary condition:
</p>

<pre>import SI = Modelica.SIunits
connector FluidPort
  replaceable model Medium = BaseProperties;
 
  SI.AbsolutePressure  p;
  flow SI.MassFlowRate m_flow;
  
  SI.SpecificEnthalpy      h;
  flow SI.EnthalpyFlowRate H_flow;
  
  SI.MassFraction       Xi     [Medium.nXi] \"Independent mixture mass fractions\";
  flow SI.MassFlowRate mXi_flow[Medium.nXi] \"Independent subst. mass flow rates\";
end FluidPort;
  
model DynamicVolume
   parameter SI.Volume V;
   replaceable model Medium = BaseProperties;
   FluidPort port(redeclare model Medium = Medium);
   Medium    medium(preferredMediumStates=true); // No modifier for p,h,Xi
   SI.InternalEnergy U; 
   SI.Mass           M; 
   SI.Mass           MXi[medium.nXi];
equation 
   U   = medium.u*M; 
   M   = medium.d*V; 
   MXi = medium.Xi*M; 
   der(U)   = port.H_flow;   // Energy balance
   der(M)   = port.m_flow;   // Mass balance
   der(MXi) = port.mXi_flow; // Substance mass balance

// Equations binding to medium (inputs)
   medium.p  = port.p;
   medium.h  = port.h;
   medium.Xi = port.Xi;
end DynamicVolume;
</pre>

<p>
The local number of unknowns of DynamicVolume is:
</p>

<ul>
<li> 4+2*nXi (inside the port connector), plus</li>
<li> 2+nXi (variables U, M and MXi), plus </li>
<li> 2+nXi (the input variables in the connectors of the medium model)
</ul>

<p>
resulting in 8+4*nXi unknowns; the local equation size is 
</p>

<ul>
<li> 6+3*nXi from the equation section, plus</li>
<li> 2+nXi flow variables in the port connector.</li>
</ul>

<p>
Therefore, DynamicVolume is a locally balanced model.
Note, when the DynamicVolume is used and the Medium model is redeclared to \"SimpleAir\", then a tool will try to select p,T as states, since these variables have StateSelect.prefer in the SimpleAir model (this means that the default states U,M are derived quantities). If this state selection is performed, all intrinsic medium variables are computed from medium.p and medium.T, although p and h are the input arguments to the medium model. This demonstrates that in Modelica input/output does not define the computational causality. Instead, it defines that equations have to be provided here for p,h,Xi, in order that the equation count is correct. The actual computational causality can be different as it is demonstrated with the SimpleAir model.
</p>

<pre>model FixedBoundary_pTX
   parameter SI.AbsolutePressure p \"Predefined boundary pressure\";
   parameter SI.Temperature      T \"Predefined boundary temperature\";
   parameter SI.MassFraction     Xi[medium.nXi] 
                                   \"Predefined boundary mass fraction\";
   replaceable model Medium = BaseProperties;
   FluidPort port(redeclare model Medium = Medium);
   Medium medium;
equation
   port.p        = p;
   port.H_flow   = semiLinear(port.m_flow, port.h , medium.h);
   port.MXi_flow = semiLinear(port.m_flow, port.Xi, medium.Xi);

// Equations binding to medium (note: T is not an input).
   medium.p  = p;
   medium.T  = T;
   medium.Xi = Xi;
end FixedBoundary_pTX;
</pre>

<p>
The number of local variables in FixedBoundary_pTX is:
</p>

<ul>
<li> 4+2*nXi (inside the port connector), plus</li>
<li> 2+nXi (the input variables in the connectors of the medium model)</li>
</ul>

<p>
resulting in 6+3*nXi unknowns, while the local equation size is
</p>

<ul>
<li> 4+2*nXi from the equation section, plus</li>
<li> 2+nXi flow variables in the port connector.</li>
</ul>

<p>
Therefore, FixedBoundary_pTX is a locally balanced model. The predefined boundary variables p and Xi are provided via equations to the input arguments medium.p and medium.Xi, in addition there is an equation for T in the same way \" even though T is not an input. Depending on the flow direction, either the specific enthalpy in the port (port.h) or h is used to compute the enthalpy flow rate H_flow. \"h\" is provided as binding equation to the medium. With the equation \"medium.T = T\", the specific enthalpy \"h\" of the reservoir is indirectly computed via the medium equations. Again, this demonstrates, that an \"input\" just defines the number of equations have to be provided, but that it not necessarily defines the computational causality.
</p>

</html>"));
end BalancedModel;


class Connect "connect" 
  
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>connect</font></h3>
<p>
Connect objects
</p>
<h3><font color=\"#008000\">Examples</font></h3>

<pre><b>model</b> Integrate
  Modelica.Blocks.Sources.Step step;
  Modelica.Blocks.Continuous.Integrator integrator;
<b>equation</b>
  connect(step.outPort, integrator.inPort);
<b>end</b> Integrate;</pre>

<p>Example of array use:</p>

<pre><B>connector</B> InPort = <B>input</B> Real;

<B>connector</B> OutPort = <B>output</B> Real;

<B>block</B> MatrixGain
  <B>input</B> InPort u[size(A,1)];
  <B>output</B> OutPort y[size(A,2)]
  <B>parameter</B> Real A[:,:]=[1];
<B>equation</B>
  y=A*u;
<B>end</B> MatrixGain;


  sin sinSource[5];
  MatrixGain gain(A=5*identity(5));
  MatrixGain gain2(A=ones(5,2));
  OutPort x[2];
<B>equation</B>
  <B>connect</B>(sinSource.y, gain.u); // Legal
  <B>connect</B>(gain.y, gain2.u);     // Legal
  <B>connect</B>(gain2.y, x);          // Legal</pre>

<h3><font color=\"#008000\">Syntax</font></h3>

<PRE>equation_clause :
  [ <B>initial</B> ] <B>equation</B> { equation \";\" | annotation  \";\" }

equation :
  ( simple_expression \"=\" expression
    | conditional_equation_e
    | for_clause_e
    | connect_clause
    | when_clause_e
    | IDENT function_call )
  comment

connect_clause :
  <B>connect</B> \"(\" component_reference \",\" component_reference \")\"</PRE>

<h3><font color=\"#008000\">Description</font></h3>

<P>Connections between objects are introduced by the <B>connect</B>
statement in the equation part of a class. The <B>connect</B>
construct takes two references to connectors, each of which is
either of the following forms:</P>

<UL>
  <LI>c1.c2. ... .cn, where c1 is a connector of the class, n&ge;1
      and ci+1 is a connector element of ci for i=1:(n-1).</LI>
  <LI>m.c, where m is a non-connector element in the class and c is
      a connector element of m.</LI>
</UL>

<P>There may optionally be array subscripts on any of the components;
the array subscripts shall be parameter expressions. If the connect
construct references array of connectors, the array dimensions must
match, and each corresponding pair of elements from the arrays is
connected as a pair of scalar connectors.</P>

<P>The two main tasks are to:</P>

<UL>
  <LI>Build connection sets from <B>connect </B>statements.</LI>
  <LI>Generate equations for the complete model.</LI>
</UL>

<P>Definitions:</P>

<ul>
  <li>Connection sets<br>
      A connection set is a set of variables connected by means of
      connect clauses. A connection set shall contain either only flow
      variables or only non-flow variables.</li>
  <li>Inside and outside connectors<br>
      In an element instance M, each connector element of M is called
      an outside connector with respect to M. All other connector elements
      that are hierarchically inside M, but not in one of the outside
      connectors of M, is called an inside connector with respect to M.<br>
      <i>[Example: in connect(a,b.c) 'a' is an outside connector and 'b.c'
      is an inside connector, unless 'b' is a connector.]</i></li>
</ul>
</html>"));
end Connect;


class Encapsulated "encapsulated" 
  
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>encapsulated</font></h3>
<p>
Break lookup in hierarchy
</p>
<h3><font color=\"#008000\">Examples</font></h3>

<pre><b>encapsulated model</b> Test
  <b>import</b> Modelica.Mechanics.Rotational;

  Rotational.Inertia inertia; // lookup successful
  Modelica.Mechanics.Translational.SlidingMass slidingMass; // lookup fails
<b>equation</b>
  ...
<b>end</b> Test;</pre>

<h3><font color=\"#008000\">Syntax</font></h3>

<PRE>class_definition :
   [ <B>encapsulated</B> ]
   [ <B>partial</B> ]
   ( <B>class</B> | <B>model</B> | <B>record</B> | <B>block</B> | <B>connector</B> | <B>type</B> |
     <B>package</B> | <b>function</B> )
   IDENT class_specifier</PRE>

<h3><font color=\"#008000\">Description</font></h3>

<p>When an element, equation or algorithm is instantiated, any name is
looked up sequentially in each member of the ordered set of parents
until a match is found or a parent is encapsulated. In the latter case
the lookup stops except for the predefined types, functions and
operators defined in this specification. For these cases the lookup
continues in the global scope, where they are defined. <i>[E.g. abs is
searched upwards in the hierarchy as usual. If an encapsulated boundary
is reached, abs is searched in the global scope instead. The operator
abs cannot be redefined in the global scope, because an existing class
cannot be redefined at the same level.]</i></p>
</html>"));
end Encapsulated;


class Extends "extends" 
  
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>extends</font></h3>
<p>
Inheritance from base class
</p>
<h3><font color=\"#008000\">Examples</font></h3>

<PRE><B>class</B> A
  <B>parameter</B> Real a, b;
<B>end</B> A;

<B>class</b> B
  <B>extends</b> A(b=2);
<B>end</B> B;

<B>class</b> C
  <B>extends</b> B(a=1);
<B>end</B> C;</PRE>

<p>From the example above we get the following instantiated
class:</P>

<PRE><B>class</b> Cinstance
  <B>parameter</b> Real a=1;
  <B>parameter</b> Real b=2;
<B>end</b> Cinstance;</PRE>

<p>The ordering of the merging rules ensures that, given
classes A and B defined above,</P>

<PRE><B>class</b> C2
  B bcomp(b=3);
<B>end</B> C2;</PRE>

<p>yields an instance with <TT>bcomp.b=3</TT>, which overrides <TT>b=2</TT>.</P>

<h3><font color=\"#008000\">Syntax</font></h3>

<PRE>class_definition :
   [ <B>encapsulated</B> ]
   [ <B>partial</b> ]
   ( <B>class</b> | <B>model</b> | <B>record</b> | <B>block</b> | <B>connector</b> | <B>type</b> |
     <B>package</B> | <b>function</b> )
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment

composition  :
   element_list
   { <B>public</b> element_list |
     <B>protected</b> element_list |
     equation_clause |
     algorithm_clause
   }
   [ <B>external</b> [ language_specification ]
              [ external_function_call ] [ annotation \";\" ]
              [ annotation  \";\" ] ]

element_list :
   { element \";\" | annotation  \";\" }

element :
   import_clause |
   extends_clause |
   [ <B>final</B> ]
   [ <B>inner</B> | <B>outer</B> ]
   ( ( class_definition | component_clause) |
     <B>replaceable</B> ( class_definition | component_clause)
        [constraining_clause comment])

extends_clause :
   <B>extends</b> name [ class_modification ]</PRE>

<h3><font color=\"#008000\">Description</font></h3>

<P>The name of the base class is looked up in the partially
instantiated parent of the extends clause. The found base
class is instantiated with a new environment and the
partially instantiated parent of the extends clause. The new
environment is the result of merging</P>

<OL>
  <LI>arguments of all parent environments that match names in the instantiated base class</LI>
  <LI>the optional class modification of the extends clause</LI>
</OL>

<P>in that order.</P>

<P>The elements of the instantiated base class become elements
of the instantiated parent class.</P>

<P>The declaration elements of the instantiated base class shall either</P>

<UL>
  <LI>not already exist in the partially instantiated parent class
      <I>[i.e., have different names]</I>.</LI>
  <LI>be exactly identical to any element of the instantiated parent
      class with the same name and the same level of protection
      (<B>public</B> or <B>protected</B>) and same contents. In this
      case, one of the elements is ignored (since they are identical
      it does not matter which one).</LI>
</UL>

<P>Otherwise the model is incorrect.</P>

<P>Equations of the instantiated base class that are syntactically
equivalent to equations in the instantiated parent class are discarded.
<I>[Note: equations that are mathematically equivalent but not
syntactically equivalent are not discarded, hence yield an
overdetermined system of equations.]</I></P>


<p class=\"MsoBodyText\"><span lang=\"EN-US\">Since
specialized classes of different
kinds have different properties,
only specialized classes that are \"in some sense
compatible\" to
each other can be derived from each other via inheritance. The
following table
shows which kind of specialized class can be used in an extends clauses
of
another kind of specialized class:</span></p>

<table class=\"MsoNormalTable\"
 style=\"border: medium none ; margin-left: 23.4pt; border-collapse: collapse;\"
 border=\"1\" cellpadding=\"0\" cellspacing=\"0\">
  <tbody>
    <tr style=\"page-break-inside: avoid; height: 15pt;\">
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 82.6pt; height: 15pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"110\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td colspan=\"7\"
 style=\"border-style: solid solid solid none; border-color: windowtext windowtext windowtext -moz-use-text-color; border-width: 1pt 1pt 1pt medium; padding: 0pt 5.4pt; width: 313.4pt; height: 15pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"418\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><b><span
 lang=\"EN-US\">Base Class</span></b></p>
      </td>
    </tr>
    <tr style=\"page-break-inside: avoid; height: 15pt;\">
      <td
 style=\"border-style: none solid solid; border-color: -moz-use-text-color windowtext windowtext; border-width: medium 1pt 1pt; padding: 0pt 5.4pt; width: 82.6pt; height: 15pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"110\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><b><span
 lang=\"EN-US\">Derived Class</span></b></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 49.4pt; height: 15pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"66\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">package</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 48pt; height: 15pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"64\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">function</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 30pt; height: 15pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"40\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">type</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 48pt; height: 15pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"64\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">record</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 54pt; height: 15pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"72\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">connector</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 39.35pt; height: 15pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"52\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">block</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 44.65pt; height: 15pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"60\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">model</span></p>
      </td>
    </tr>
    <tr style=\"page-break-inside: avoid;\">
      <td
 style=\"border-style: none solid solid; border-color: -moz-use-text-color windowtext windowtext; border-width: medium 1pt 1pt; padding: 0pt 5.4pt; width: 82.6pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"110\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 lang=\"EN-US\">package</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 49.4pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"66\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">yes</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 48pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"64\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 30pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"40\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 48pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"64\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 54pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"72\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 39.35pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"52\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 44.65pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"60\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
    </tr>
    <tr style=\"page-break-inside: avoid;\">
      <td
 style=\"border-style: none solid solid; border-color: -moz-use-text-color windowtext windowtext; border-width: medium 1pt 1pt; padding: 0pt 5.4pt; width: 82.6pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"110\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 lang=\"EN-US\">function</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 49.4pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"66\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 48pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"64\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">yes</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 30pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"40\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 48pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"64\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 54pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"72\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 39.35pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"52\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 44.65pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"60\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
    </tr>
    <tr style=\"page-break-inside: avoid;\">
      <td
 style=\"border-style: none solid solid; border-color: -moz-use-text-color windowtext windowtext; border-width: medium 1pt 1pt; padding: 0pt 5.4pt; width: 82.6pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"110\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 lang=\"EN-US\">type</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 49.4pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"66\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 48pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"64\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 30pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"40\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">yes</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 48pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"64\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 54pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"72\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 39.35pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"52\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 44.65pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"60\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
    </tr>
    <tr style=\"page-break-inside: avoid;\">
      <td
 style=\"border-style: none solid solid; border-color: -moz-use-text-color windowtext windowtext; border-width: medium 1pt 1pt; padding: 0pt 5.4pt; width: 82.6pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"110\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 lang=\"EN-US\">record</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 49.4pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"66\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 48pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"64\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 30pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"40\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 48pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"64\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">yes</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 54pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"72\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 39.35pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"52\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 44.65pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"60\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
    </tr>
    <tr style=\"page-break-inside: avoid;\">
      <td
 style=\"border-style: none solid solid; border-color: -moz-use-text-color windowtext windowtext; border-width: medium 1pt 1pt; padding: 0pt 5.4pt; width: 82.6pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"110\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 lang=\"EN-US\">connector</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 49.4pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"66\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 48pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"64\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; background: rgb(230, 230, 230) none repeat scroll 0%; width: 30pt; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"40\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">yes</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; background: rgb(230, 230, 230) none repeat scroll 0%; width: 48pt; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"64\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">yes</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 54pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"72\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;yes</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 39.35pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"52\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 44.65pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"60\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
    </tr>
    <tr style=\"page-break-inside: avoid;\">
      <td
 style=\"border-style: none solid solid; border-color: -moz-use-text-color windowtext windowtext; border-width: medium 1pt 1pt; padding: 0pt 5.4pt; width: 82.6pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"110\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 lang=\"EN-US\">block</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 49.4pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"66\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 48pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"64\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 30pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"40\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; background: rgb(230, 230, 230) none repeat scroll 0%; width: 48pt; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"64\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">yes</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 54pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"72\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 39.35pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"52\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">yes</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 44.65pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"60\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
    </tr>
    <tr style=\"page-break-inside: avoid;\">
      <td
 style=\"border-style: none solid solid; border-color: -moz-use-text-color windowtext windowtext; border-width: medium 1pt 1pt; padding: 0pt 5.4pt; width: 82.6pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"110\">
      <p class=\"MsoBodyTextIndent\" style=\"text-indent: 0pt;\"><span
 lang=\"EN-US\">model</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 49.4pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"66\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 48pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"64\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 30pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"40\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; background: rgb(230, 230, 230) none repeat scroll 0%; width: 48pt; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"64\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">yes</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 54pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"72\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">&nbsp;</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5"
           + ".4pt; background: rgb(230, 230, 230) none repeat scroll 0%; width: 39.35pt; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"52\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">yes</span></p>
      </td>
      <td
 style=\"border-style: none solid solid none; border-color: -moz-use-text-color windowtext windowtext -moz-use-text-color; border-width: medium 1pt 1pt medium; padding: 0pt 5.4pt; width: 44.65pt;\"
 nowrap=\"nowrap\" valign=\"top\" width=\"60\">
      <p class=\"MsoBodyTextIndent\"
 style=\"text-align: center; text-indent: 0pt;\" align=\"center\"><span
 lang=\"EN-US\">yes</span></p>
      </td>
    </tr>
  </tbody>
</table>
<p class=\"MsoBodyText\"><span lang=\"EN-US\">The
specialized classes </span><span class=\"CODE\"><span
 style=\"font-size: 9.5pt;\" lang=\"EN-US\">package</span></span><span
 lang=\"EN-US\">, </span><span class=\"CODE\"><span
 style=\"font-size: 9.5pt;\" lang=\"EN-US\">function</span></span><span
 lang=\"EN-US\">, </span><span class=\"CODE\"><span
 style=\"font-size: 9.5pt;\" lang=\"EN-US\">type</span></span><span
 lang=\"EN-US\"> and record can only be derived from their own
kind [<i>(e.g. a
package can only be base class for packages. All other kinds of classes
can use
the import statement to use the contents of a package)</i>]<i>.</i></span></p>


</html>"));
end Extends;


class Flow "flow" 
  
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>flow</font></h3>
<p>
Declare flow (through) variable, which have to sum up to zero in connections
</p>
<h3><font color=\"#008000\">Examples</font></h3>

<pre><b>connector</b> Pin
  Modelica.SIunits.Voltage v;
  <b>flow</b> Modelica.SIunits.Current i;
<b>end</b> Pin;

<b>model</b> A
  Pin p;
<b>end</b> A;

<b>model</b> Composition
  A a;
  A b;
  A c;
<b>equation
  connect</b>(a.p, b.p);
  <b>connect</b>(a.p, c.p);
<b>end</b> Composition;</pre>

<p>From the connect statements in model Composition, the following connect equations are derived:</p>

<pre>a.p.v = b.p.v;
a.p.v = c.p.v;
a.p.i + b.p.i + c.p.i = 0;</pre>

<h3><font color=\"#008000\">Syntax</font></h3>

<PRE>class_definition :
   [ <B>encapsulated</B> ]
   [ <B>partial</b> ]
   ( <B>class</b> | <B>model</b> | <B>record</b> | <B>block</b> | <B>connector</b> | <B>type</b> |
     <B>package</B> | <b>function</b> )
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment

base_prefix :
   type_prefix

composition  :
   element_list
   { <B>public</b> element_list |
     <B>protected</b> element_list |
     equation_clause |
     algorithm_clause
   }
   [ <B>external</b> [ language_specification ]
              [ external_function_call ] [ annotation \";\" ]
              [ annotation  \";\" ] ]

element_list :
   { element \";\" | annotation  \";\" }

element :
   import_clause |
   extends_clause |
   [ <B>final</B> ]
   [ <B>inner</B> | <B>outer</B> ]
   ( ( class_definition | component_clause) |
     <B>replaceable</B> ( class_definition | component_clause)
        [constraining_clause comment])

component_clause:
   type_prefix type_specifier [ array_subscripts ] component_list

type_prefix :
   [ <B>flow</b> ]
   [ <B>discrete</B> | <B>parameter</b> | <B>constant</b> ] [ <B>input</b> | <B>output</b> ]</PRE>

<h3><font color=\"#008000\">Description</font></h3>

<p>The flow prefix is used in order to generate equations for through variables, which sum up to zero in connections,
whereas variables without the flow prefix are identical in a connection.</p>
</html>"));
end Flow;


class For "for" 
  
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>for</font></h3>
<p>
Repeat equations or statements a specific number of times
</p>
<h3><font color=\"#008000\">Examples</font></h3>
<p>
<b>for</b> clauses are mostly used in algorithm sections, such as
</p>
<pre>
    <b>parameter</b> Integer np=10;
    Real p[np], x, y;
  <b>algorithm</b>
     y := p[1];
     <b>for</b> i <b>in</b> 2:np <b>loop</b>   // i shall not be declared
        y := y*x + p[i];
     <b>end for</b>;
</pre>
<p>
Other forms of the <b>for</b> condition:
</p>
<pre>
    <b>for</b> i <b>in</b> 1:10 <b>loop</b>            // i takes the values 1,2,3,...,10
    <b>for</b> r <b>in</b> 1.0 : 1.5 : 5.5 <b>loop</b> // r takes the values 1.0, 2.5, 4.0, 5.5
    <b>for</b> i <b>in</b> {1,3,6,7} <b>loop</b>       // i takes the values 1, 3, 6, 7
</pre>
<p>
In equation sections, <b>for</b> clauses are expanded at translation time
in order that symbolic transformations can be applied. Typically, a
<b>for</b> clause in an equation section is used on component arrays,
e.g., to connect elements of an array of components together:
</p>
<pre>
    <b>parameter</b> Integer nR=10 \"Number of resistances\";
    Modelica.Electrical.Analog.Basic.Resistor R[nR];
  <b>equation</b>
     <b>for</b> i <b>in</b> 1:nR-1 <b>loop</b>
        <b>connect</b>(R[i].p R[i+1].n);   // 9 connect equations
     <b>end for</b>;
</pre>
<h3><font color=\"#008000\">Syntax</font></h3>
<p>
In equation sections:
</p>
<pre>
  <b>for</b> for_indices <b>loop</b>
     { equation \";\" }
  <b>end for</b>;
  for_indices : for_index {\",\" for_index}
  for_index   : IDENT [ in expression ]
</pre>
<p>
In algorithm sections:
</p>
<pre>
  <b>for</b> for_indices <b>loop</b>
     { algorithm \";\" }
  <b>end for</b>;
  for_indices : for_index {\",\" for_index}
  for_index   : IDENT [ in expression ]
</pre>
<h3><font color=\"#008000\">Description</font></h3>
<p>A clause</p>
<pre>    <b>for</b> IDENT <b>in</b> expression <b>loop</b></pre>
<p>is one example of a for clause.</p>
<p>The expression of a for clause shall be a vector expression. It is
evaluated once for each for clause, and is evaluated in the scope
immediately enclosing the for clause. In an equation section,
the expression of a for clause shall be a parameter expression (in order
that the for clause can be expanded into equations during translation).
The loop-variable is in scope inside the loop-construct and shall not be assigned
to.</p>
<p><i>[Example:</i></p>
<p><i>The loop-variable may hide other variables as in the following example.
Using another name for the loop-variable
is, however, strongly recommended.</i></p>
<pre>    <b>constant</b> Integer j=4;
    Real x[j];
  <b>equation</b>
    <b>for</b> j <b>in</b> 1:j <b>loop</b> // The loop-variable j takes the values 1,2,3,4
      x[j]=j; // Uses the loop-variable j
    <b>end for</b>;</pre>
<p><i>]</i></p>
<h4>Several iterators</h4>
<p>The notation with several iterators is a shorthand notation for nested for-clauses (or reduction-expressions). For
for-clauses it can be expanded into the usual form by replacing each \",\" by <tt>'loop for'</tt> and adding extra <tt>'end
for'</tt>. For reduction-expressions it can be expanded into the usual form by replacing each ',' by <tt>') for'</tt> and
prepending the reduction-expression with <tt>'function-name('</tt>.</p>
<p><i>[Example:</i></p>
<pre>    Real x[4,3];
  <b>equation</b>
    <b>for</b> j, i in 1:2 <b>loop</b>
      // The loop-variable j takes the values 1,2,3,4 (due to use)
      // The loop-variable i takes the values 1,2 (given range)
      x[j,i]=j+i;
    <b>end for</b>;</pre>
<p><i>]</i></p>
</html>"));
end For;


class If "if" 
  
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>if</font></h3>
<p>
Declare equations or execute statements conditionally
</p>
<h3><font color=\"#008000\">Examples</font></h3>
<h4>If clause</h4>

<pre>    <b>parameter</b> Boolean linear=true;
    <b>parameter</b> Boolean quadratic=false;
    Real x, y;
  <b>equation</b>
    <b>if</b> linear <b>then</b>
      y = x + 1;
    <b>elseif</b> quadratic <b>then</b>
      y = x^2 + x + 1;
    <b>else</b>
      y = Modelica.Math.sin(x) + 1;
    <b>end if</b>;</pre>

<h4>If expression</h4>
<PRE>  Integer i;
  Integer sign_of_i=<B>if</B> i&lt;0 <B>then</B> -1 <B>else if</B> i==0 <B>then</B> 0 <B>else</B> 1;</PRE>
<h3><font color=\"#008000\">Syntax</font></h3>
<p>
In equation sections:
</p>
<PRE>   <B>if</B> expression <B>then</B>
     { equation \";\" }
   { <B>elseif </B>expression <B>then</B>
     { equation \";\" }
   }
   [ <B>else</B>
     { equation \";\" }
   ]
   <B>end if</B></pre>
<p>
In algorithm sections:
</p>
<pre>   <B>if</B> expression <B>then</B>
     { algorithm \";\" }
   { <B>elseif </B>expression <B>then</B>
     { algorithm \";\" }
   }
   [ <B>else</B>
     { algorithm \";\" }
   ]
   <B>end if</B></PRE>
<h3><font color=\"#008000\">Description</font></h3>
<h4>If clause</h4>
<P>
The expression of an <B>if</B> and <B>elseif</B>-clause must be scalar boolean expression.
One <B>if</B>-clause, and zero or more <B>elseif</B>-clauses, and an optional <B>else</B>-clause
together form a list of branches. One or zero of the bodies of these <B>if</B>-, <B>elseif</B>-
and <B>else</B>-clauses is selected, by evaluating the conditions of the <B>if</B>- and
<B>elseif</B>-clauses sequentially until a condition that evaluates to true is found. If none of
the conditions evaluate to true the body of the <B>else</B>-clause is selected (if an
<B>else</B>-clause exists, otherwise no body is selected). In an algorithm section, the selected
body is then executed. In an equation section, the equations in the body are seen as equations
that must be satisfied. The bodies that are not selected have no effect on that model evaluation.
</P>
<P>
If clauses in <B>equation </B>sections which do not have exclusively parameter expressions as
switching conditions shall have an <B>else</B> clause and each branch shall have the <I>same
number</I> of <I>equations</I>. <I>[If this condition is violated, the single assignment rule
would not hold, because the number of equations may change during simulation although the number
of unknowns remains the same].</I>
</P>

<h4>If expression</h4>

<P>An expression</P>
<pre>   <B>if</B> expression1 <B>then</B> expression2 <B>else</B> expression3</pre>
<P>is one example of if-expression. First expression1, which must be boolean expression,
is evaluated. If expression1 is true expression2 is evaluated and is the value of the
if-expression, else expression3 is evaluated and is the value of the if-expression.
The two expressions, expression2 and expression3, must be type compatible and give the
type of the if-expression. If-expressions with <B>elseif</B> are defined by replacing
<B>elseif</B> by <B>else if</B>.<I>[Note: elseif is added for symmetry with if-clauses.]</I>
</P>
</html>"));
end If;


class Import "import" 
  
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>import</font></h3>
<p>
Import classes
</p>
<h3><font color=\"#008000\">Examples</font></h3>

<pre><b>class</b> Lookup
  <b>import</b> SI = Modelica.SIunits; // #1
  <b>import</b> Modelica.Math.*; // #2
  <b>import</b> Modelica.Mechanics.Rotational; // #3

  SI.Torque torque; // due to #1 (Modelica.SIunits.Torque)
  Rotational.Inertia inertia; // due to #3 (Modelica.Mechanics.Rotational.Inertia)
<b>equation</b>
  torque = sin(<b>time</b>); // due to #2 (Modelica.Math.sin)
  ...
<b>end</b> Lookup;</pre>

<h3><font color=\"#008000\">Syntax</font></h3>

<PRE>class_definition :
   [ <B>encapsulated</B> ]
   [ <B>partial</b> ]
   ( <B>class</b> | <B>model</b> | <B>record</b> | <B>block</b> | <B>connector</b> | <B>type</b> |
     <B>package</B> | <b>function</b> )
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment

composition  :
   element_list
   { <B>public</b> element_list |
     <B>protected</b> element_list |
     equation_clause |
     algorithm_clause
   }
   [ <B>external</b> [ language_specification ]
              [ external_function_call ] [ annotation \";\" ]
              [ annotation  \";\" ] ]

element_list :
   { element \";\" | annotation  \";\" }

element :
   import_clause |
   extends_clause |
   [ <B>final</B> ]
   [ <B>inner</B> | <B>outer</B> ]
   ( ( class_definition | component_clause) |
     <B>replaceable</B> ( class_definition | component_clause)
        [constraining_clause comment])

import_clause :
   <B>import</B> ( IDENT \"=\" name | name [\".\" \"*\"] ) comment</PRE>
<h3><font color=\"#008000\">Description</font></h3>

<p>Using import statements extends the static name lookup to additional import names.
The generated import names are:</p>

<ul>
  <li><tt>C</tt> for <tt><b>import</b> A.B.C;</tt></li>
  <li><tt>D</tt> for <tt><b>import</b> D = A.B.C;</tt></li>
  <li><tt>C</tt> and all other classes in B for <tt><b>import</b> A.B.*;</tt></li>
</ul>
</html>"));
end Import;


class Input "input" 
  
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>input</font></h3>
<p>
Define causality and/or block diagram connection semantic
(depending on context)
</p>
<h3><font color=\"#008000\">Examples</font></h3>

<pre><b>connector</b> RealInput = <b>input</b> Real;
<b>connector</b> RealOutput = <b>output</b> Real;

<b>block</b> Integrator
  RealInput  u;
  RealOutput y;
<b>protected</b>
  Real x;
<b>equation</b>
  <b>der</b>(x) = u;
  y = x;
<b>end</b> Integrator;</pre>

<h3><font color=\"#008000\">Syntax</font></h3>

<PRE>class_definition :
   [ <B>encapsulated</B> ]
   [ <B>partial</b> ]
   ( <B>class</b> | <B>model</b> | <B>record</b> | <B>block</b> | <B>connector</b> | <B>type</b> |
     <B>package</B> | <b>function</b> )
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment

base_prefix :
   type_prefix

composition  :
   element_list
   { <B>public</b> element_list |
     <B>protected</b> element_list |
     equation_clause |
     algorithm_clause
   }
   [ <B>external</b> [ language_specification ]
              [ external_function_call ] [ annotation \";\" ]
              [ annotation  \";\" ] ]

element_list :
   { element \";\" | annotation  \";\" }

element :
   import_clause |
   extends_clause |
   [ <B>final</B> ]
   [ <B>inner</B> | <B>outer</B> ]
   ( ( class_definition | component_clause) |
     <B>replaceable</B> ( class_definition | component_clause)
        [constraining_clause comment])

component_clause:
   type_prefix type_specifier [ array_subscripts ] component_list

type_prefix :
   [ <B>flow</b> ]
   [ <B>discrete</B> | <B>parameter</b> | <B>constant</b> ] [ <B>input</b> | <B>output</b> ]</PRE>

<h3><font color=\"#008000\">Description</font></h3>

<p>
The prefixes <b>input</b> and <b>output</b> have a slightly different semantic meaning depending on the context where they are used:
</p>

<ul>
<li> In functions, these prefixes define the computational causality of the
     function body, i.e., given the variables declared as input, 
     the variables declared as output are computed in the function body<br>&nbsp;</li>.

<li> In simulation models and blocks (i.e., on the top level of a model or 
     block that shall be simulated), these prefixes define the interaction
     with the environment where the simulation model or block is used. 
     Especially, the input prefix defines that values for such a variable 
     have to be provided from the simulation environment and the output 
     prefix defines that the values of the corresponding variable 
     can be directly utilized in the simulation environment.<br>&nbsp;</li>

<li> In component models and blocks, the input prefix defines that a 
     binding equation has to be provided for the corresponding variable 
     when the component is utilized in order to guarantee a locally
     balanced model (i.e., the number of local equations is identical
     to the local number of unknowns). Example:
<pre>  <b>block</b> FirstOrder
     <b>input</b> Real u;
       ...
  <b>end</b> FirstOrder;

  <b>model</b> UseFirstOrder
     FirstOrder firstOrder(u=time); // binding equation for u
      ...
  <b>end</b> UseFirstOrder;
</pre>
     The output prefix does not have a particular effect in a model
     or block component and is ignored.<br>&nbsp;</li>

<li> In connectors, prefixes input and output define that the 
     corresponding connectors can only be connected according
     to block diagram semantics (e.g., a connector with an output
     variable can only be connected to a connector where the
     corresponding variable is declared as input). There is the
     restriction that connectors which have at least one variable
     declared as input must be externally connected
     (in order to get a locally balanced model, where the number
     of local unknowns is identical to the number of unknown equations).
     Together with the block diagram semantics rule this means,
     that such connectors must be connected exactly once externally.<br>&nbsp;</li>

<li> In records, prefixes input and output are not allowed,
     since otherwise a record could not be, e.g., passed as input
     argument to a function.</li>
</ul>

</html>"));
end Input;


class Output "output" 
  
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>output</font></h3>
<p>
Define causality and/or block diagram connection semantic
(depending on context)
</p>

<h3><font color=\"#008000\">Examples</font></h3>

<pre><b>connector</b> RealInput = <b>input</b> Real;
<b>connector</b> RealOutput = <b>output</b> Real;

<b>block</b> Integrator
  RealInput  u;
  RealOutput y;
<b>protected</b>
  Real x;
<b>equation</b>
  <b>der</b>(x) = u;
  y = x;
<b>end</b> Integrator;</pre>

<h3><font color=\"#008000\">Syntax</font></h3>

<PRE>class_definition :
   [ <B>encapsulated</B> ]
   [ <B>partial</b> ]
   ( <B>class</b> | <B>model</b> | <B>record</b> | <B>block</b> | <B>connector</b> | <B>type</b> |
     <B>package</B> | <b>function</b> )
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment

base_prefix :
   type_prefix

composition  :
   element_list
   { <B>public</b> element_list |
     <B>protected</b> element_list |
     equation_clause |
     algorithm_clause
   }
   [ <B>external</b> [ language_specification ]
              [ external_function_call ] [ annotation \";\" ]
              [ annotation  \";\" ] ]

element_list :
   { element \";\" | annotation  \";\" }

element :
   import_clause |
   extends_clause |
   [ <B>final</B> ]
   [ <B>inner</B> | <B>outer</B> ]
   ( ( class_definition | component_clause) |
     <B>replaceable</B> ( class_definition | component_clause)
        [constraining_clause comment])

component_clause:
   type_prefix type_specifier [ array_subscripts ] component_list

type_prefix :
   [ <B>flow</b> ]
   [ <B>discrete</B> | <B>parameter</b> | <B>constant</b> ] [ <B>input</b> | <B>output</b> ]</PRE>

<h3><font color=\"#008000\">Description</font></h3>

<p>
The prefixes <b>input</b> and <b>output</b> have a slightly different semantic meaning depending on the context where they are used:
</p>

<ul>
<li> In functions, these prefixes define the computational causality of the
     function body, i.e., given the variables declared as input, 
     the variables declared as output are computed in the function body<br>&nbsp;</li>.

<li> In simulation models and blocks (i.e., on the top level of a model or 
     block that shall be simulated), these prefixes define the interaction
     with the environment where the simulation model or block is used. 
     Especially, the input prefix defines that values for such a variable 
     have to be provided from the simulation environment and the output 
     prefix defines that the values of the corresponding variable 
     can be directly utilized in the simulation environment.<br>&nbsp;</li>

<li> In component models and blocks, the input prefix defines that a 
     binding equation has to be provided for the corresponding variable 
     when the component is utilized in order to guarantee a locally
     balanced model (i.e., the number of local equations is identical
     to the local number of unknowns). Example:
<pre>  <b>block</b> FirstOrder
     <b>input</b> Real u;
       ...
  <b>end</b> FirstOrder;

  <b>model</b> UseFirstOrder
     FirstOrder firstOrder(u=time); // binding equation for u
      ...
  <b>end</b> UseFirstOrder;
</pre>
     The output prefix does not have a particular effect in a model
     or block component and is ignored.<br>&nbsp;</li>

<li> In connectors, prefixes input and output define that the 
     corresponding connectors can only be connected according
     to block diagram semantics (e.g., a connector with an output
     variable can only be connected to a connector where the
     corresponding variable is declared as input). There is the
     restriction that connectors which have at least one variable
     declared as input must be externally connected
     (in order to get a locally balanced model, where the number
     of local unknowns is identical to the number of unknown equations).
     Together with the block diagram semantics rule this means,
     that such connectors must be connected exactly once externally.<br>&nbsp;</li>

<li> In records, prefixes input and output are not allowed,
     since otherwise a record could not be, e.g., passed as input
     argument to a function.</li>
</ul>

</html>"));
end Output;


class Partial "partial" 
  
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>partial</font></h3>
<p>
Prohibit instantiation of components of the class
</p>
<h3><font color=\"#008000\">Examples</font></h3>

<pre><b>partial block</b> BaseBlock
  <b>input</b> Real u;
  <b>output</b> Real y;
<b>protected</b>
  Real x;
<b>equation</b>
  x = y;
<b>end</b> BaseBlock;

<b>block</b> Integrator
  <b>extends</b> BaseBlock;
<b>equation
  der</b>(x) = u;
<b>end</b> Integrator;

<b>block</b> Gain
  <b>extends</b> BaseBlock;
  <b>parameter</b> k = 1;
<b>equation</b>
  x = k*u;
<b>end</b> Gain;

<b>model</b> Composition
  BaseBlock block1; // Illegal
  Integrator block2; // Legal
  Gain block3; // Legal
<b>end</b> Composition;</pre>

<h3><font color=\"#008000\">Syntax</font></h3>

<PRE>class_definition :
   [ <B>encapsulated</B> ]
   [ <B>partial</b> ]
   ( <B>class</b> | <B>model</b> | <B>record</b> | <B>block</b> | <B>connector</b> | <B>type</b> |
     <B>package</B> | <b>function</b> )
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment</PRE>

</html>"));
end Partial;


class Time "time" 
  
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>time</font></h3>
<p>
Built-in variable time
</p>
<h3><font color=\"#008000\">Examples</font></h3>

<PRE><B>encapsulated model</B> SineSource
  <B>import</B> Modelica.Math.sin;
  <B>connector</B> OutPort=<B>output</B> Real;
  OutPort y=sin(time); // Uses the built-in variable time.
<B>end</B> SineSource;</PRE>

<h3><font color=\"#008000\">Syntax</font></h3>

<pre><b>time</b></pre>

<h3><font color=\"#008000\">Description</font></h3>

<P>All declared variables are functions of the independent
variable <B>time</B>. Time is a built-in variable available
in all classes, which is treated as an input variable. It
is implicitly defined as:</P>

<PRE><B>input</B> Real time (<B>final</B> quantity = \"Time\",
                 <B>final</B> unit     = \"s\");</PRE>

<P>The value of the <B>start</B> attribute of time is set to
the time instant at which the simulation is started.</P>

</html>"));
end Time;


class When "when" 
  
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>when</font></h3>
<p>
Activate equations or statements when condition becomes true
</p>
<h3><font color=\"#008000\">Examples</font></h3>
<PRE> <B>equation
   when</B> x &gt; 2 <B>then</B>
     y3 = 2*x +y1+y2; // Order of y1 and y3 equations does not matter
     y1 = sin(x);
   <B>end when</B>;
   y2 = sin(y1);</PRE>

<h3><font color=\"#008000\">Syntax</font></h3>

<p>
In equation sections:
</p>

<PRE>  <B>when</B> expression <B>then</B>
    { equation \";\" }
  { <B>elsewhen</B> expression <B>then</B>
    { equation \";\" } }
  <B>end when</B></PRE>

<p>
In algorithm sections:
</p>
<PRE>  <B>when</B> expression <B>then</B>
    { algorithm \";\" }
  { <B>elsewhen</B> expression <B>then</B>
    { algorithm \";\" } }
  <B>end when</B></PRE>

<h3><font color=\"#008000\">Description</font></h3>

<P>The expression of a when clause shall be a discrete-time Boolean scalar
or vector expression. The equations and algorithm statements within a when
clause are activated when the scalar or any one of the elements of the vector
expression becomes true. When-clauses in equation sections are allowed, provided
the equations within the when-clause have one of the following forms:</P>

<UL>
  <LI>v = expr;</LI>
  <LI> (out1, out2, out3, ...) = function_call(in1, in2, ...);</LI>
  <LI>operators <B>assert</B>(), <B>terminate</B>(), <B>reinit</B>()</LI>
  <LI><B>For</B> and <B>if</B>-clause if the equations within the <B>for</B> and <B>if</B>-clauses satisfy these requirements.</LI>
  <LI>In an equation section, the different branches of when/elsewhen must have the same set of component references on the left-hand side.</LI>
  <LI>In an equation section, the branches of an if-then-else clause inside when-clauses must have the same set of component references on the left-hand side, unless the if-then-else have exclusively parameter expressions as switching conditions.</LI>
</UL>

<P>A when clause shall not be used within a function class.</P>

<P><I>[Example:</i></P>

<P><i>Algorithms are activated when x becomes &gt; 2:</I></P>

<PRE>   <B>when</B> x &gt; 2 <B>then</B>
     y1 := sin(x);
     y3 := 2*x + y1 + y2;
   <B>end when</B>;</PRE>

<P><I>Algorithms are activated when either x becomes &gt; 2 or sample(0,2) becomes true or x becomes less than 5:</I></P>

<PRE>   <B>when</B> {x &gt; 2, sample(0,2), x &lt; 5} <B>then</B>
     y1 := sin(x);
     y3 := 2*x + y1 + y2;
   <B>end when</B>;</PRE>

<P><I>For when in equation sections the order between the equations does not matter, e.g.</I></P>
<PRE> <B>equation
   when</B> x &gt; 2 <B>then</B>
     y3 = 2*x +y1+y2; // Order of y1 and y3 equations does not matter
     y1 = sin(x);
   <B>end when</B>;
   y2 = sin(y1);</PRE>

<P><I>The needed restrictions on equations within a when-clause becomes apparent with the following example:</I></P>

<PRE>   Real x, y;
<B>equation</B>
   x + y = 5;
   <B>when</B> condition <B>then</B>
      2*x + y = 7;         // error: not valid Modelica
   <B>end when</B>;</PRE>


<P><I>When the equations of the when-clause are not activated it is not clear which
variable to hold constant, either x or y. A corrected version of this example is:</I></P>

<PRE>   Real x, y;
<B>equation</B>
   x + y = 5;
   <B>when</B> condition <B>then</B>
      y = 7 - 2*x;        // fine
   <B>end when</B>;</PRE>

<P><I>Here, variable y is held constant when the when-clause is de-activated and x
is computed from the first equation using the value of y from the previous event instant.</i></P>

<P><i>For when in algorithm sections the order is significant and it is advisable to have only
one assignment within the when-clause and instead use several algorithms having when-clauses
with identical conditions, e.g.</I></P>

<PRE> <B>algorithm</B>
   <B>when</B> x &gt; 2 <B>then</B>
     y1 := sin(x);
   <B>end when</B>;
 <B>equation</B>
   y2 = sin(y1);
 <B>algorithm</B>
   <B>when</B> x &gt; 2 <B>then</B>
     y3 := 2*x + y1 + y2;
   <B>end when</B>;</PRE>

<P><I>Merging the when-clauses can lead to less efficient code and different models
with different behaviour depending on the order of the assignment to y1 and y3 in the algorithm.]</I></P>

<P>A when clause</P>

<PRE> <B>algorithm
   when</B> {x&gt;1, <B>..., </B>y&gt;p} <B>then
     ...
   elsewhen</B> x &gt; y.start <B>then
     ...
   end when</B>;</PRE>

<P>is equivalent to the following special if-clause, where Boolean b1[N]
and Boolean b2 are necessary because the <B>edge</B>() operator can only
be applied to variables</P>

<PRE>   Boolean b1[N](start={x.start&gt;1,<B> ..., </B>y.start&gt;p});
   Boolean b2(start=x.start&gt;y.start);
 <B>algorithm</B>
   b1:={x&gt;1, ..., y&gt;p};
   b2:=x&gt;y.start;

   <B>if edge</B>(b1[1]) <B>or edge</B>(b1[2]) <B>or ... edge</B>(b1[N]) <B>then
     ...
   elseif edge</B>(b2) <B>then
     ...
   end if</B>;</PRE>

<P>with &quot;<B>edge</B>(A)= A <B>and not pre</B>(A)&quot; and the additional
guarantee, that the algorithms within this special if clause are only evaluated
at event instants.</P>

<P>A when-clause</P>

<PRE> <B>equation
   when</B> x&gt;2 <B>then</B>
     v1 = expr1 ;
     v2 = expr2 ;
   <B>end when</B>;</PRE>

<P>is equivalent to the following special if-expressions</P>

<PRE>   Boolean b(start=x.start&gt;2);
 <B>equation</B>
   b  = x&gt;2;
   v1 = <B>if edge</B>(b) <B>then</B> expr1 <B>else pre</B>(v1);
   v2 = <B>if edge</B>(b) <B>then</B> expr2 <B>else pre</B>(v2);</PRE>

<P>The start-values of the introduced boolean variables are defined by
the taking the start-value of the when-condition, as above where p is a
parameter variable. The start-values of the special functions
<B>initial</B>, <B>terminal</B>, and <B>sample</B> is false.</P>

<P>When clauses cannot be nested.</P>

<P><I>[Example:</i></P>

<P><i>The following when clause is invalid:</I></P>

<PRE>   <B>when</B> x &gt; 2 <B>then
     when</B> y1 &gt; 3 <B>then</B>
       y2 = sin(x);
     <B>end when</B>;
   <B>end when</B>;</PRE>

<P><I>]</I></P>
</html>"));
end When;


class While "while" 
  
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>while</font></h3>
<p>
Repeat statements as long as a condition is fulfilled
</p>
<h3><font color=\"#008000\">Examples</font></h3>
<pre>    Integer i;
  <b>algorithm</b>
    i := 1;
    <b>while</b> i &lt; 10 <b>loop</b>
      i := i + 1;
      <b>...
    end while</b>;</pre>

<h3><font color=\"#008000\">Syntax</font></h3>

<PRE>  <B>while</B> expression <B>loop</B>
    { algorithm \";\" }
  <B>end while</B></PRE>

<h3><font color=\"#008000\">Description</font></h3>

<P>The expression of a while clause shall be a scalar boolean expression.
The while-clause corresponds to while-statements in programming languages,
and is formally defined as follows</P>

<OL>
  <LI>The expression of the while clause is evaluated.</LI>
  <LI>If the expression of the while-clause is false, the execution
      continues after the while-clause.</LI>
  <LI>If the expression of the while-clause is true, the entire body of
      the while clause is executed (except if a break statement or return
      statement is executed), and then execution proceeds at step 1.</LI>
</OL>

</html>"));
end While;

end ModelicaReference;
