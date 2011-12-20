within ;
package ModelicaReference "Modelica Reference"
   extends ModelicaReference.Icons.Information;


class ModelicaGrammar "Modelica Grammar"
  extends ModelicaReference.Icons.Information;

  annotation (Documentation(info="<html><head><title>Modelica 3.2 Revision 1 Grammar</title>
<style type=\"text/css\">
A.HREF { text-decoration:none; color:#003399 }
</style>
</head>
<body><h4>Modelica 3.2 Revision 1 Grammar</h4>
<p>This is the grammar of Modelica 3.2 Revision 1 in EBNF form. Each
non-terminal appearing on the right hand side of a production is a link to the
production for that non-terminal. This grammar is identical to that in the
Modelica 3.2 specification except for removal of some unnecessary parentheses,
grouping of some common terms, and reformatting for easier readability. The
following typographic conventions are used:
<ul>
<li>Keywords are set in <b>boldface</b>.</li>
<li>Literals other than keywords are <font color=\"green\">\"</font><tt>quoted-monospaced</tt><font color=\"green\">\"</font> text.</li>
<li>Non-terminals are set in <i>italics</i>, with <font color=\"#003399\"><i>blue italics</i></font> used for links.</li>
<li>EBNF meta-characters are <font color=\"green\">green</font>.</li>
</ul>
<h5>Stored Definition</h5>
<p><a name=\"stored_definition\" class=NAME><i>stored_definition</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>within</b><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#name\" class=HREF><i>name</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>final</b><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><a href=\"#class_definition\" class=HREF><i>class_definition</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<h5>Class Definition</h5>
<p><a name=\"class_definition\" class=NAME><i>class_definition</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>encapsulated</b><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>partial</b><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">(</font><tt>&nbsp;</tt><b>class</b><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>model</b><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>record</b><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>block</b><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>expandable</b><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><b>connector</b><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>type</b><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>package</b><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>function</b><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>operator</b><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>function</b><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>record</b><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">)</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#class_specifier\" class=HREF><i>class_specifier</i></a>
<p><a name=\"class_specifier\" class=NAME><i>class_specifier</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><i>IDENT</i><tt>&nbsp;</tt><a href=\"#string_comment\" class=HREF><i>string_comment</i></a><tt>&nbsp;</tt><a href=\"#composition\" class=HREF><i>composition</i></a><tt>&nbsp;</tt><b>end</b><tt>&nbsp;</tt><i>IDENT</i>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><i>IDENT</i><tt>&nbsp;</tt><font color=green>\"</font><tt>=</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#base_prefix\" class=HREF><i>base_prefix</i></a><tt>&nbsp;</tt><a href=\"#name\" class=HREF><i>name</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#array_subscripts\" class=HREF><i>array_subscripts</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#class_modification\" class=HREF><i>class_modification</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><a href=\"#comment\" class=HREF><i>comment</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><i>IDENT</i><tt>&nbsp;</tt><font color=green>\"</font><tt>=</tt><font color=green>\"</font><tt>&nbsp;</tt><b>enumeration</b><tt>&nbsp;</tt><font color=green>\"</font><tt>(</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">(</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#enum_list\" class=HREF><i>enum_list</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green>\"</font><tt>:</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">)</font><tt>&nbsp;</tt><font color=green>\"</font><tt>)</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#comment\" class=HREF><i>comment</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><i>IDENT</i><tt>&nbsp;</tt><font color=green>\"</font><tt>=</tt><font color=green>\"</font><tt>&nbsp;</tt><b>der</b><tt>&nbsp;</tt><font color=green>\"</font><tt>(</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#name\" class=HREF><i>name</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>,</tt><font color=green>\"</font><tt>&nbsp;</tt><i>IDENT</i><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><font color=green>\"</font><tt>,</tt><font color=green>\"</font><tt>&nbsp;</tt><i>IDENT</i><tt>&nbsp;</tt><font color=green size=\"+1\">}</font><tt>&nbsp;</tt><font color=green>\"</font><tt>)</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#comment\" class=HREF><i>comment</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>extends</b><tt>&nbsp;</tt><i>IDENT</i><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#class_modification\" class=HREF><i>class_modification</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><a href=\"#string_comment\" class=HREF><i>string_comment</i></a><tt>&nbsp;</tt><a href=\"#composition\" class=HREF><i>composition</i></a><tt>&nbsp;</tt><b>end</b><tt>&nbsp;</tt><i>IDENT</i>
<p><a name=\"base_prefix\" class=NAME><i>base_prefix</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#type_prefix\" class=HREF><i>type_prefix</i></a>
<p><a name=\"enum_list\" class=NAME><i>enum_list</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#enumeration_literal\" class=HREF><i>enumeration_literal</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><font color=green>\"</font><tt>,</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#enumeration_literal\" class=HREF><i>enumeration_literal</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<p><a name=\"enumeration_literal\" class=NAME><i>enumeration_literal</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><i>IDENT</i><tt>&nbsp;</tt><a href=\"#comment\" class=HREF><i>comment</i></a>
<p><a name=\"composition\" class=NAME><i>composition</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#element_list\" class=HREF><i>element_list</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><b>public</b><tt>&nbsp;</tt><a href=\"#element_list\" class=HREF><i>element_list</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>protected</b><tt>&nbsp;</tt><a href=\"#element_list\" class=HREF><i>element_list</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#equation_section\" class=HREF><i>equation_section</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#algorithm_section\" class=HREF><i>algorithm_section</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>external</b><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#language_specification\" class=HREF><i>language_specification</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#external_function_call\" class=HREF><i>external_function_call</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#annotation\" class=HREF><i>annotation</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#annotation\" class=HREF><i>annotation</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<p><a name=\"language_specification\" class=NAME><i>language_specification</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><i>STRING</i>
<p><a name=\"external_function_call\" class=NAME><i>external_function_call</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#component_reference\" class=HREF><i>component_reference</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>=</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><i>IDENT</i><tt>&nbsp;</tt><font color=green>\"</font><tt>(</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#expression_list\" class=HREF><i>expression_list</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green>\"</font><tt>)</tt><font color=green>\"</font>
<p><a name=\"element_list\" class=NAME><i>element_list</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#element\" class=HREF><i>element</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<p><a name=\"element\" class=NAME><i>element</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#import_clause\" class=HREF><i>import_clause</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#extends_clause\" class=HREF><i>extends_clause</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>redeclare</b><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>final</b><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>inner</b><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>outer</b><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">(</font><tt>&nbsp;</tt><a href=\"#class_definition\" class=HREF><i>class_definition</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#component_clause\" class=HREF><i>component_clause</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>replaceable</b><tt>&nbsp;</tt><font color=green size=\"+1\">(</font><tt>&nbsp;</tt><a href=\"#class_definition\" class=HREF><i>class_definition</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#component_clause\" class=HREF><i>component_clause</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">)</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#constraining_clause\" class=HREF><i>constraining_clause</i></a><tt>&nbsp;</tt><a href=\"#comment\" class=HREF><i>comment</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">)</font>
<p><a name=\"import_clause\" class=NAME><i>import_clause</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>import</b><tt>&nbsp;</tt><font color=green size=\"+1\">(</font><tt>&nbsp;</tt><i>IDENT</i><tt>&nbsp;</tt><font color=green>\"</font><tt>=</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#name\" class=HREF><i>name</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#name\" class=HREF><i>name</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><font color=green>\"</font><tt>.</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green>\"</font><tt>*</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green>\"</font><tt>.*</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">)</font><tt>&nbsp;</tt><a href=\"#comment\" class=HREF><i>comment</i></a>
<h5>Extends</h5>
<p><a name=\"extends_clause\" class=NAME><i>extends_clause</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>extends</b><tt>&nbsp;</tt><a href=\"#name\" class=HREF><i>name</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#class_modification\" class=HREF><i>class_modification</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#annotation\" class=HREF><i>annotation</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<p><a name=\"constraining_clause\" class=NAME><i>constraining_clause</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>constrainedby</b><tt>&nbsp;</tt><a href=\"#name\" class=HREF><i>name</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#class_modification\" class=HREF><i>class_modification</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<h5>Component Clause</h5>
<p><a name=\"component_clause\" class=NAME><i>component_clause</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#type_prefix\" class=HREF><i>type_prefix</i></a><tt>&nbsp;</tt><a href=\"#type_specifier\" class=HREF><i>type_specifier</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#array_subscripts\" class=HREF><i>array_subscripts</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><a href=\"#component_list\" class=HREF><i>component_list</i></a>
<p><a name=\"type_prefix\" class=NAME><i>type_prefix</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>flow</b><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>stream</b><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>discrete</b><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>parameter</b><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>constant</b><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>input</b><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>output</b><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<p><a name=\"type_specifier\" class=NAME><i>type_specifier</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#name\" class=HREF><i>name</i></a>
<p><a name=\"component_list\" class=NAME><i>component_list</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#component_declaration\" class=HREF><i>component_declaration</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><font color=green>\"</font><tt>,</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#component_declaration\" class=HREF><i>component_declaration</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<p><a name=\"component_declaration\" class=NAME><i>component_declaration</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#declaration\" class=HREF><i>declaration</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#condition_attribute\" class=HREF><i>condition_attribute</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><a href=\"#comment\" class=HREF><i>comment</i></a>
<p><a name=\"condition_attribute\" class=NAME><i>condition_attribute</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>if</b><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a>
<p><a name=\"declaration\" class=NAME><i>declaration</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><i>IDENT</i><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#array_subscripts\" class=HREF><i>array_subscripts</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#modification\" class=HREF><i>modification</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<h5>Modification</h5>
<p><a name=\"modification\" class=NAME><i>modification</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#class_modification\" class=HREF><i>class_modification</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><font color=green>\"</font><tt>=</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green>\"</font><tt>=</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green>\"</font><tt>:=</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a>
<p><a name=\"class_modification\" class=NAME><i>class_modification</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green>\"</font><tt>(</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#argument_list\" class=HREF><i>argument_list</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green>\"</font><tt>)</tt><font color=green>\"</font>
<p><a name=\"argument_list\" class=NAME><i>argument_list</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#argument\" class=HREF><i>argument</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><font color=green>\"</font><tt>,</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#argument\" class=HREF><i>argument</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<p><a name=\"argument\" class=NAME><i>argument</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#element_modification_or_replaceable\" class=HREF><i>element_modification_or_replaceable</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#element_redeclaration\" class=HREF><i>element_redeclaration</i></a>
<p><a name=\"element_modification_or_replaceable\" class=NAME><i>element_modification_or_replaceable</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>each</b><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>final</b><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">(</font><tt>&nbsp;</tt><a href=\"#element_modification\" class=HREF><i>element_modification</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#element_replaceable\" class=HREF><i>element_replaceable</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">)</font>
<p><a name=\"element_modification\" class=NAME><i>element_modification</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#name\" class=HREF><i>name</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#modification\" class=HREF><i>modification</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><a href=\"#string_comment\" class=HREF><i>string_comment</i></a>
<p><a name=\"element_redeclaration\" class=NAME><i>element_redeclaration</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>redeclare</b><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>each</b><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>final</b><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">(</font><tt>&nbsp;</tt><a href=\"#class_definition\" class=HREF><i>class_definition</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#component_clause1\" class=HREF><i>component_clause1</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#element_replaceable\" class=HREF><i>element_replaceable</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">)</font>
<p><a name=\"element_replaceable\" class=NAME><i>element_replaceable</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>replaceable</b><tt>&nbsp;</tt><font color=green size=\"+1\">(</font><tt>&nbsp;</tt><a href=\"#class_definition\" class=HREF><i>class_definition</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#component_clause1\" class=HREF><i>component_clause1</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">)</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#constraining_clause\" class=HREF><i>constraining_clause</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<p><a name=\"component_clause1\" class=NAME><i>component_clause1</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#type_prefix\" class=HREF><i>type_prefix</i></a><tt>&nbsp;</tt><a href=\"#type_specifier\" class=HREF><i>type_specifier</i></a><tt>&nbsp;</tt><a href=\"#component_declaration1\" class=HREF><i>component_declaration1</i></a>
<p><a name=\"component_declaration1\" class=NAME><i>component_declaration1</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#declaration\" class=HREF><i>declaration</i></a><tt>&nbsp;</tt><a href=\"#comment\" class=HREF><i>comment</i></a>
<h5>Equation</h5>
<p><a name=\"equation_section\" class=NAME><i>equation_section</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>initial</b><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><b>equation</b><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#equation\" class=HREF><i>equation</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<p><a name=\"algorithm_section\" class=NAME><i>algorithm_section</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>initial</b><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><b>algorithm</b><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#statement\" class=HREF><i>statement</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<p><a name=\"equation\" class=NAME><i>equation</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">(</font><tt>&nbsp;</tt><a href=\"#simple_expression\" class=HREF><i>simple_expression</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>=</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#if_equation\" class=HREF><i>if_equation</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#for_equation\" class=HREF><i>for_equation</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#connect_clause\" class=HREF><i>connect_clause</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#when_equation\" class=HREF><i>when_equation</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#name\" class=HREF><i>name</i></a><tt>&nbsp;</tt><a href=\"#function_call_args\" class=HREF><i>function_call_args</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">)</font><tt>&nbsp;</tt><a href=\"#comment\" class=HREF><i>comment</i></a>
<p><a name=\"statement\" class=NAME><i>statement</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">(</font><tt>&nbsp;</tt><a href=\"#component_reference\" class=HREF><i>component_reference</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">(</font><tt>&nbsp;</tt><font color=green>\"</font><tt>:=</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#function_call_args\" class=HREF><i>function_call_args</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">)</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green>\"</font><tt>(</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#output_expression_list\" class=HREF><i>output_expression_list</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>)</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green>\"</font><tt>:=</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#component_reference\" class=HREF><i>component_reference</i></a><tt>&nbsp;</tt><a href=\"#function_call_args\" class=HREF><i>function_call_args</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>break</b>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>return</b>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#if_statement\" class=HREF><i>if_statement</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#for_statement\" class=HREF><i>for_statement</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#while_statement\" class=HREF><i>while_statement</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#when_statement\" class=HREF><i>when_statement</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">)</font><tt>&nbsp;</tt><a href=\"#comment\" class=HREF><i>comment</i></a>
<p><a name=\"if_equation\" class=NAME><i>if_equation</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>if</b><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a><tt>&nbsp;</tt><b>then</b><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#equation\" class=HREF><i>equation</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><b>elseif</b><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a><tt>&nbsp;</tt><b>then</b><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#equation\" class=HREF><i>equation</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>else</b><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#equation\" class=HREF><i>equation</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
"+"
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>end</b><tt>&nbsp;</tt><b>if</b>
<p><a name=\"if_statement\" class=NAME><i>if_statement</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>if</b><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a><tt>&nbsp;</tt><b>then</b><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#statement\" class=HREF><i>statement</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><b>elseif</b><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a><tt>&nbsp;</tt><b>then</b><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#statement\" class=HREF><i>statement</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>else</b><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#statement\" class=HREF><i>statement</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>end</b><tt>&nbsp;</tt><b>if</b>
<p><a name=\"for_equation\" class=NAME><i>for_equation</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>for</b><tt>&nbsp;</tt><a href=\"#for_indices\" class=HREF><i>for_indices</i></a><tt>&nbsp;</tt><b>loop</b><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#equation\" class=HREF><i>equation</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font><tt>&nbsp;</tt><b>end</b><tt>&nbsp;</tt><b>for</b>
<p><a name=\"for_statement\" class=NAME><i>for_statement</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>for</b><tt>&nbsp;</tt><a href=\"#for_indices\" class=HREF><i>for_indices</i></a><tt>&nbsp;</tt><b>loop</b><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#statement\" class=HREF><i>statement</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font><tt>&nbsp;</tt><b>end</b><tt>&nbsp;</tt><b>for</b>
<p><a name=\"for_indices\" class=NAME><i>for_indices</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#for_index\" class=HREF><i>for_index</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><font color=green>\"</font><tt>,</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#for_index\" class=HREF><i>for_index</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<p><a name=\"for_index\" class=NAME><i>for_index</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><i>IDENT</i><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>in</b><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<p><a name=\"while_statement\" class=NAME><i>while_statement</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>while</b><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a><tt>&nbsp;</tt><b>loop</b><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#statement\" class=HREF><i>statement</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font><tt>&nbsp;</tt><b>end</b><tt>&nbsp;</tt><b>while</b>
<p><a name=\"when_equation\" class=NAME><i>when_equation</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>when</b><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a><tt>&nbsp;</tt><b>then</b><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#equation\" class=HREF><i>equation</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><b>elsewhen</b><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a><tt>&nbsp;</tt><b>then</b><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#equation\" class=HREF><i>equation</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>end</b><tt>&nbsp;</tt><b>when</b>
<p><a name=\"when_statement\" class=NAME><i>when_statement</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>when</b><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a><tt>&nbsp;</tt><b>then</b><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#statement\" class=HREF><i>statement</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><b>elsewhen</b><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a><tt>&nbsp;</tt><b>then</b><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#statement\" class=HREF><i>statement</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>end</b><tt>&nbsp;</tt><b>when</b>
<p><a name=\"connect_clause\" class=NAME><i>connect_clause</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>connect</b><tt>&nbsp;</tt><font color=green>\"</font><tt>(</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#component_reference\" class=HREF><i>component_reference</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>,</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#component_reference\" class=HREF><i>component_reference</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>)</tt><font color=green>\"</font>
<h5>Expression</h5>
<p><a name=\"expression\" class=NAME><i>expression</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#simple_expression\" class=HREF><i>simple_expression</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>if</b><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a><tt>&nbsp;</tt><b>then</b><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><b>elseif</b><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a><tt>&nbsp;</tt><b>then</b><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>else</b><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a>
<p><a name=\"simple_expression\" class=NAME><i>simple_expression</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#logical_expression\" class=HREF><i>logical_expression</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><font color=green>\"</font><tt>:</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#logical_expression\" class=HREF><i>logical_expression</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><font color=green>\"</font><tt>:</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#logical_expression\" class=HREF><i>logical_expression</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<p><a name=\"logical_expression\" class=NAME><i>logical_expression</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#logical_term\" class=HREF><i>logical_term</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><b>or</b><tt>&nbsp;</tt><a href=\"#logical_term\" class=HREF><i>logical_term</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<p><a name=\"logical_term\" class=NAME><i>logical_term</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#logical_factor\" class=HREF><i>logical_factor</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><b>and</b><tt>&nbsp;</tt><a href=\"#logical_factor\" class=HREF><i>logical_factor</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<p><a name=\"logical_factor\" class=NAME><i>logical_factor</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><b>not</b><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><a href=\"#relation\" class=HREF><i>relation</i></a>
<p><a name=\"relation\" class=NAME><i>relation</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#arithmetic_expression\" class=HREF><i>arithmetic_expression</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#rel_op\" class=HREF><i>rel_op</i></a><tt>&nbsp;</tt><a href=\"#arithmetic_expression\" class=HREF><i>arithmetic_expression</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<p><a name=\"rel_op\" class=NAME><i>rel_op</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green>\"</font><tt>&lt;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green>\"</font><tt>&lt;=</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green>\"</font><tt>&gt;</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green>\"</font><tt>&gt;=</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green>\"</font><tt>==</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green>\"</font><tt>&lt;&gt;</tt><font color=green>\"</font>
<p><a name=\"arithmetic_expression\" class=NAME><i>arithmetic_expression</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#add_op\" class=HREF><i>add_op</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><a href=\"#term\" class=HREF><i>term</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#add_op\" class=HREF><i>add_op</i></a><tt>&nbsp;</tt><a href=\"#term\" class=HREF><i>term</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<p><a name=\"add_op\" class=NAME><i>add_op</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green>\"</font><tt>+</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green>\"</font><tt>-</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green>\"</font><tt>.+</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green>\"</font><tt>.-</tt><font color=green>\"</font>
<p><a name=\"term\" class=NAME><i>term</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#factor\" class=HREF><i>factor</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#mul_op\" class=HREF><i>mul_op</i></a><tt>&nbsp;</tt><a href=\"#factor\" class=HREF><i>factor</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<p><a name=\"mul_op\" class=NAME><i>mul_op</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green>\"</font><tt>*</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green>\"</font><tt>/</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green>\"</font><tt>.*</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green>\"</font><tt>./</tt><font color=green>\"</font>
<p><a name=\"factor\" class=NAME><i>factor</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#primary\" class=HREF><i>primary</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><font color=green size=\"+1\">(</font><tt>&nbsp;</tt><font color=green>\"</font><tt>^</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green>\"</font><tt>.^</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">)</font><tt>&nbsp;</tt><a href=\"#primary\" class=HREF><i>primary</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<p><a name=\"primary\" class=NAME><i>primary</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><i>UNSIGNED_NUMBER</i>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><i>STRING</i>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>false</b>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>true</b>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#component_reference\" class=HREF><i>component_reference</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green size=\"+1\">(</font><tt>&nbsp;</tt><a href=\"#name\" class=HREF><i>name</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>der</b><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>initial</b><tt>&nbsp;</tt><font color=green size=\"+1\">)</font><tt>&nbsp;</tt><a href=\"#function_call_args\" class=HREF><i>function_call_args</i></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green>\"</font><tt>(</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#output_expression_list\" class=HREF><i>output_expression_list</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>)</tt><font color=green>\"</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green>\"</font><tt>[</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#expression_list\" class=HREF><i>expression_list</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><font color=green>\"</font><tt>;</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#expression_list\" class=HREF><i>expression_list</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">}</font><tt>&nbsp;</tt><font color=green>\"</font><tt>]</tt><font color=green>\"</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><font color=green>\"</font><tt>{</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#function_arguments\" class=HREF><i>function_arguments</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>}</tt><font color=green>\"</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>end</b>
<p><a name=\"name\" class=NAME><i>name</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><font color=green>\"</font><tt>.</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><i>IDENT</i><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><font color=green>\"</font><tt>.</tt><font color=green>\"</font><tt>&nbsp;</tt><i>IDENT</i><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<p><a name=\"component_reference\" class=NAME><i>component_reference</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><font color=green>\"</font><tt>.</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><i>IDENT</i><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#array_subscripts\" class=HREF><i>array_subscripts</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><font color=green>\"</font><tt>.</tt><font color=green>\"</font><tt>&nbsp;</tt><i>IDENT</i><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#array_subscripts\" class=HREF><i>array_subscripts</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<p><a name=\"function_call_args\" class=NAME><i>function_call_args</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green>\"</font><tt>(</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#function_arguments\" class=HREF><i>function_arguments</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green>\"</font><tt>)</tt><font color=green>\"</font>
<p><a name=\"function_arguments\" class=NAME><i>function_arguments</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#function_argument\" class=HREF><i>function_argument</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><font color=green>\"</font><tt>,</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#function_arguments\" class=HREF><i>function_arguments</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><b>for</b><tt>&nbsp;</tt><a href=\"#for_indices\" class=HREF><i>for_indices</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#named_arguments\" class=HREF><i>named_arguments</i></a>
<p><a name=\"named_arguments\" class=NAME><i>named_arguments</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#named_argument\" class=HREF><i>named_argument</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><font color=green>\"</font><tt>,</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#named_arguments\" class=HREF><i>named_arguments</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<p><a name=\"named_argument\" class=NAME><i>named_argument</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><i>IDENT</i><tt>&nbsp;</tt><font color=green>\"</font><tt>=</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#function_argument\" class=HREF><i>function_argument</i></a>
<p><a name=\"function_argument\" class=NAME><i>function_argument</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>function</b><tt>&nbsp;</tt><a href=\"#name\" class=HREF><i>name</i></a><tt>&nbsp;</tt><font color=green>\"</font><tt>(</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#named_arguments\" class=HREF><i>named_arguments</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green>\"</font><tt>)</tt><font color=green>\"</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a>
<p><a name=\"output_expression_list\" class=NAME><i>output_expression_list</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><font color=green>\"</font><tt>,</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<p><a name=\"expression_list\" class=NAME><i>expression_list</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><font color=green>\"</font><tt>,</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">}</font>
<p><a name=\"array_subscripts\" class=NAME><i>array_subscripts</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green>\"</font><tt>[</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#subscript\" class=HREF><i>subscript</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><font color=green>\"</font><tt>,</tt><font color=green>\"</font><tt>&nbsp;</tt><a href=\"#subscript\" class=HREF><i>subscript</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">}</font><tt>&nbsp;</tt><font color=green>\"</font><tt>]</tt><font color=green>\"</font>
<p><a name=\"subscript\" class=NAME><i>subscript</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green>\"</font><tt>:</tt><font color=green>\"</font><tt>&nbsp;</tt><font color=green size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#expression\" class=HREF><i>expression</i></a>
<p><a name=\"comment\" class=NAME><i>comment</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#string_comment\" class=HREF><i>string_comment</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#annotation\" class=HREF><i>annotation</i></a><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<p><a name=\"string_comment\" class=NAME><i>string_comment</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=green size=\"+1\">[</font><tt>&nbsp;</tt><i>STRING</i><tt>&nbsp;</tt><font color=green size=\"+1\">{</font><tt>&nbsp;</tt><font color=green>\"</font><tt>+</tt><font color=green>\"</font><tt>&nbsp;</tt><i>STRING</i><tt>&nbsp;</tt><font color=green size=\"+1\">}</font><tt>&nbsp;</tt><font color=green size=\"+1\">]</font>
<p><a name=\"annotation\" class=NAME><i>annotation</i></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><b>annotation</b><tt>&nbsp;</tt><a href=\"#class_modification\" class=HREF><i>class_modification</i></a>
</body></html>"));
end ModelicaGrammar;


package Annotations "Annotations"
  extends ModelicaReference.Icons.Information;
  class choices "choices"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define graphical layout of choices in a parameter menu
</p>

<h4>Examples</h4>

<pre><b>replaceable model</b> MyResistor=Resistor
  <b>annotation</b>(choices(
              choice(redeclare MyResistor=lib2.Resistor(a={2}) \"...\"),
              choice(redeclare MyResistor=lib2.Resistor2 \"...\")));

<b>replaceable</b> Resistor Load(R=2) constrainedby TwoPin
  <b>annotation</b>(choices(
              choice(redeclare lib2.Resistor Load(a={2}) \"...\"),
              choice(redeclare Capacitor Load(L=3) \"...\")));

<b>replaceable</b> FrictionFunction a(func=exp) constrainedby Friction
  <b>annotation</b>(choices(
             choice(redeclare ConstantFriction a(c=1) \"...\"),
             choice(redeclare TableFriction a(table=\"...\") \"...\"),
             choice(redeclare FunctionFriction a(func=exp) \"...\"))));

<b>type</b> KindOfController=Integer(min=1,max=3)
   <b>annotation</b>(choices(
                choice=1 \"P\",
                choice=2 \"PI\",
                choice=3 \"PID\"));

<b>model</b> A
  KindOfController x;
<b>end</b> A;
A a(x=3 \"PID\");
</pre>

<h4>Description</h4>

<p>
A declaration can have an annotation \"choices\" containing modifiers on choice, where each of them indicates a suitable redeclaration or modifications of the element.
This is a hint for users of the model, and can also be used by the user interface to suggest reasonable redeclaration, where the string comments on the choice declaration can be used as textual explanations of the choices.  The annotation is not restricted to replaceable elements but can also be applied to non-replaceable elements, enumeration types, and simple variables.
</p>

</html>"));
  end choices;

  class defaultComponentName "defaultComponentName"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Default name when dragging component
</p>

<h4>Syntax</h4>

<pre>   <b>annotation</b>\"(\" defaultComponentName \"=\" STRING \")\"
</pre>

<h4>Description</h4>

<p>
When creating a component of the given class, the recommended component name is the
giving string.
</p>

</html>"));
  end defaultComponentName;

  class defaultComponentPrefixes "defaultComponentPrefixes"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Default prefixes when dragging component
</p>

<h4>Examples</h4>

<pre><b>annotation</b>(defaultComponentPrefixes=\"inner\",
           defaultComponentName=\"world\")
</pre>

<h4>Syntax</h4>

<pre>   <b>annotation</b>\"(\" defaultComponentPrefixes \"=\" STRING \")\"
</pre>

<h4>Description</h4>

<p>
The following prefixes may be included in the string prefixes: inner, outer, replaceable, constant, parameter, discrete. In combination with defaultComponentName it can be used to make it easy for users to create inner components matching the outer declarations.
</p>

</html>"));
  end defaultComponentPrefixes;

  class derivative "derivative"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define derivative of function
</p>

<h4>Examples</h4>

<pre><b>function</b> foo0 <b>annotation</b>(derivative=foo1); <b>end</b> foo0;
<b>function</b> foo1 <b>annotation</b>(derivative(order=2)=foo2); <b>end</b> foo1;
<b>function</b> foo2 <b>end</b> foo2;
</pre>

<h4>Description</h4>

<p>
Derivatives of functions can be declared explicitly using the derivative annotation, whereas a function can be defined as a partial derivative of another function using the der-operator in a short function definition.
</p>

<p>
A function declaration can have an annotation derivative specifying the derivative function. This can influence simulation time and accuracy and can be applied to both functions written in Modelica and to external functions. A derivative annotation can state that it is only valid under certain restrictions on the input arguments. These restrictions are defined using the following optional attributes: order (only a restriction if order &gt; 1, the default for order is 1), noDerivative, and zeroDerivative. The given derivative-function can only be used to compute the derivative of a function call if these restrictions are satisfied. There may be multiple restrictions on the derivative, in which case they must all be satisfied. The restrictions also imply that some derivatives of some inputs are excluded from the call of the derivative (since they are not necessary). A function may supply multiple derivative functions subject to different restrictions.
</p>

<p>
The inputs to the derivative function of order 1 are constructed as follows:
</p>

<ul>
<li> First are all inputs to the original function, and after all them we will
     in order append one derivative for each input containing reals.<br>&nbsp;</li>
<li> The outputs are constructed by starting with an empty list and then in
     order appending one derivative for each output containing reals.<br>&nbsp;</li>
<li> If the Modelica function call is a nth derivative (n>=1), i.e., this
     function call has been derived from an (n-1)th derivative, an
     annotation(order=n+1)=?,  specifies the (n+1)th derivative, and the
     (n+1)th derivative call is constructed as follows:<br>&nbsp;</li>
<li> The input arguments are appended with the (n+1)th derivative,
     which are constructed in order from the nth order derivatives.<br>&nbsp;</li>
<li> The output arguments are similar to the output argument for the
     nth derivative, but each output is one higher in derivative order.</li>
</ul>

<p>
Example: Given the declarations
</p>

<pre> function foo0
   ...
   input Real x;
   input Boolean linear;
   input ...;
   output Real y;
   ...
   annotation(derivative=foo1);
 end foo0;

 function foo1
   ...
   input Real x;
   input Boolean linear;
   input ...;
   input Real der_x;
   ...
   output Real der_y;
   ...
   annotation(derivative(order=2)=foo2);
 end foo1;

 function foo2
   ...
   input Real x;
   input Boolean linear;
   input ...;
   input Real der_x;
   ...;
   input Real der_2_x;
   ...
   output Real der_2_y;
   ...
</pre>

<p>
the equation
</p>

<pre>(...,y(t),...)=foo0(...,x(t),b,...);
</pre>

<p>
implies that:
<p>

<pre>(...,d y(t)/dt,...)=foo1(...,x(t),b,..., ...,d x(t)/dt,...);
(...,d^2 y(t)/dt^2,...)=foo2(...,x(t),b,...,d x(t)/dt,..., ...,d^2 x(t)/dt^2,...);
</pre>

<p>
An input or output to the function may be any simple type (Real, Boolean, Integer, String and enumeration types) or a record, provided the record does not contain both reals and non-reals predefined types. The function must have at least one input containing reals. The output list of the derivative function may not be empty.
</p>

<ul>
<li> zeroDerivative=input_var1<br>
    The derivative function is only valid if input_var1 is independent
    of the variables the function call is  differentiated with respect to
    (i.e., that the derivative of input_var1 is \"zero\").
    The derivative of input_var1 is excluded from the argument list of the derivative-function.
    Assume that function f takes a matrix and a scalar. Since the matrix argument is
    usually a parameter expression it is then useful to define the function
    as follows (the additional derivative = f_general_der is optional and
    can be used when the derivative of the matrix is non-zero).
<pre>function f \"Simple table lookup\"
  input Real x;
  input Real y[:, 2];
  output Real z;
  annotation(derivative(zeroDerivative=y) = f_der,
             derivative=f_general_der);
algorithm
  ...
end f;

function f_der \"Derivative of simple table lookup\"
  input Real x;
  input Real y[:, 2];
  input Real x_der;
  output Real z_der;
algorithm
  ...
end f_der;

function f_general_der \"Derivative of table lookup taking into account varying tables\"
  input Real x;
  input Real y[:, 2];
  input Real x_der;
  input Real y_der[:, 2];
  output Real z_der;
algorithm
  ...
end f_general_der;

</pre></li>

<li> noDerivative(input_var2 = f(input_var1, ...) )<br>
    The derivative function is only valid if the input argument input_var2
    is computed as f(input_var1, ...). The derivative of input_var2
    is excluded from the argument list of the derivative-function.
    Assume that function fg is defined as a composition f(x, g(x)).
    When differentiating f it is useful to give the derivative under the
    assumption that the second argument is defined in this way:
<pre>function fg
  input Real x;
  output Real z;
algorithm
   z := f(x, g(x));
end fg;

function f
  input Real x;
  input Real y;
  output Real z;
  annotation(derivative(noDerivative(y = g(x))) = f_der);
algorithm
  ...
end f;

function f_der
  input Real x;
  input Real x_der;
  input Real y;
  output Real z_der;
algorithm
  ...
end f_der;
</pre>
This is useful if g represents the major computational effort of fg).</li>
</ul>

</html>"));
  end derivative;

  class Dialog "Dialog"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define graphical layout of the parameter menu.
</p>

<h4>Syntax</h4>
<blockquote>
<pre><b>annotation</b>(<b>Dialog</b>(<b>enable</b> = true,
                     <b>tab</b> = \"General\",
                   <b>group</b> = \"Parameters\",
      <b>showStartAttribute</b> = false,
              <b>groupImage</b> = \"modelica://MyPackage/Resources/Images/image.png\",
         <b>connectorSizing</b> = false));
</pre>
</blockquote>

<h4>Description</h4>
<p>
The annotations <b><code>tab</code></b> and <b><code>group</code></b> define the placement of the component or of variables in a dialog with optional tab and group specification. If <code><b>enable</b> = false</code>, the input field may be disabled [and no input can be given]. If <code><b>showStartAttribute</b> = true</code> the dialog should allow the user to set the start-value and the fixed attribute for the variable instead of the value-attribute [this is primarily intended for non-parameter values and avoids introducing a separate parameter for the start-value of the variable].
</p>
<p>
The annotation <b><code>groupImage</code></b> references an image using an Modelica URI, and the image is intended to be shown together with the parameter-group (only one image per group is supported). Disabling the input field will not disable the image.
</p>
<p>
The value of the <b><code>connectorSizing</code></b> annotation must be a literal false or true value [since if the value is an expression, the <code>connectorSizing</code> functionality is conditional and this will then lead easily to wrong models]. If <code>connectorSizing = false</code>, this annotation has no effect. If <code>connectorSizing = true</code>, the corresponding variable must be declared with the parameter prefix, must be a subtype of a scalar Integer and must have a literal default value of zero [since this annotation is designed for a parameter that is used as vector dimension and the dimension of the vector should be zero when the component is dragged or redeclared; furthermore, when a tool does not support the connectorSizing annotation, dragging will still result in a correct model].
If <code>connectorSizing = true</code>, a tool may set the parameter value in a modifier automatically, if used as dimension size of a vector of connectors. [The <code>connectorSizing</code> annotation is used in cases where connections to a vector of connectors shall be made and a new connection requires to resize the vector and to  connect  to the new index (unary connections). The annotation allows a tool to perform these two actions in many cases automatically. This is, e.g., very useful for state machines and for certain components of fluid libraries.]
</p>
<p>
Annotation \"Dialog\" is defined as:
</p>
<blockquote>
<pre><b>record</b> Dialog
  <b>parameter</b> String  tab                = \"General\";
  <b>parameter</b> String  group              = \"Parameters\";
  <b>parameter</b> String  groupImage         = \"\";
  <b>parameter</b> Boolean enable             = <b>true</b>;
  <b>parameter</b> Boolean showStartAttribute = <b>false</b>;
  <b>parameter</b> Boolean connectorSizing    = <b>false</b>;
<b>end</b> Dialog;
</pre>
</blockquote>

<h4>Examples</h4>
<p>
A parameter dialog is a sequence of tabs with a sequence of groups inside them.
</p>

<pre><b>model</b> DialogDemo
  <b>parameter</b> Boolean b = true \"Boolean parameter\";
  <b>parameter</b> Modelica.SIunits.Length length \"Real parameter with unit\";
  <b>parameter</b> Integer nInports=0 annotation(Dialog(connectorSizing=true));
  <b>parameter</b> Real r1 \"Real parameter in Group 1\" annotation(Dialog(group=\"Group 1\"));
  <b>parameter</b> Real r2 \"Disabled Real parameter in group 1\"
                     <b>annotation</b>(<b>Dialog</b>(<b>group</b>=\"Group 1\", <b>enable</b> = <b>not</b> b));
  <b>parameter</b> Real r3 \"Real parameter in Tab 1\" <b>annotation</b>(<b>Dialog</b>(<b>tab</b>=\"Tab 1\"));
  <b>parameter</b> Real r4 \"Real parameter in Tab 1 and Group 2\"
                     <b>annotation</b>(<b>Dialog</b>(<b>tab</b>=\"Tab 1\", <b>group</b>=\"Group 2\"));
  StepIn stepIn[nInports];
  ...
<b>end</b> DialogDemo;
</pre>
</html>"));
  end Dialog;

  class Documentation "Documentation"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Annotations for documentation
</p>

<h4>Syntax</h4>

<pre>documentation_annotation:
   <b>annotation</b>\"(\" Documentation \"(\" \"info\" \"=\" STRING
                            [\",\" \"revisions\" \"=\" STRING ] \")\" \")\"
</pre>

<h4>Description</h4>
<P>
The \"Documentation\" annotation can contain the \"info\" annotation giving a textual description, the \"revisions\" annotation giving a list of revisions and other annotations defined by a tool [The \"revisions\" documentation may be omitted in printed documentation]. How the tool interprets the information in \"Documentation\" is unspecified. Within a string of the \"Documentation\" annotation, the tags &lt;HTML&gt; and &lt;/HTML&gt; or &lt;html&gt; and &lt;/html&gt; define optionally begin and end of content that is HTML encoded. Links to Modelica classes may be defined with the HTML link command using scheme \"Modelica\", e.g.,
</p>

<pre>    &lt;a href=\"modelica://MultiBody.Tutorial\"&gt;MultiBody.Tutorial&lt;/a&gt;
</pre>

<p>
Together with scheme \"Modelica\" the (URI)  fragment specifiers #diagram, #info, #text, #icon may be used to reference different layers. Example:
</p>

<pre>   &lt;a href=\"modelica://MultiBody.Joints.Revolute#info\"&gt;Revolute&lt;/a&gt;
</pre>

</html>"));
  end Documentation;

  class DynamicSelect "DynamicSelect"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define schematic animation of diagram layer
</p>

<h4>Examples</h4>

<blockquote>
<p>
The level of a tank is animated by a rectangle expanding in vertical direction and its color depending on a variable overflow:
</p>

<pre><b>annotation</b>(
  Icon(graphics={Rectangle(
    extent=<b>DynamicSelect</b>({{0,0},{20,20}},{{0,0},{20,level}}),
    fillColor=<b>DynamicSelect</b>({0,0,255},
                            <b>if</b> overflow <b>then</b> {255,0,0} <b>else</b> {0,0,255}))}
);
</pre></blockquote>

<h4>Description</h4>

<p>
Any value (coordinates, color, text, etc.) in graphical annotations can be dependent on class variables using the DynamicSelect expression. DynamicSelect has the syntax of a function call with two arguments, where the first argument specifies the value of the editing state and the second argument the value of the non-editing state. The first argument must be a literal expression
and this value is used for the annotation when editing and/or browsing the diagram layer.
The second argument may contain references to variables to enable a dynamic behavior
and the actual value is used for the annotation for schematic animation
of the diagram layer, e.g., after a simulation.
</p>

</html>"));
  end DynamicSelect;

  class Evaluate "Evaluate"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Annotation for code generation (evaluate parameter value)
</p>

<h4>Syntax</h4>

<pre>   <b>annotation</b>\"(\" Evaluate \"=\" ( <b>false</b> | <b>true</b> ) \")
</pre>

<h4>Description</h4>

<p>
Has only an effect for a declaration with the prefix parameter.
</p>

<p>
If Evaluate = true, the model developer proposes to utilize the value for the symbolic processing. In that case, it is not possible to change the parameter value after symbolic pre-processing.
</p>

<p>
If Evaluate = false, the model developer proposes to not utilize the value of the corresponding parameter for the symbolic processing.
</p>

<p>
Evaluate is for example used for axis of rotation parameters in the Modelica.Mechanics.MultiBody library in order to improve the efficiency of the generated code
</p>

</html>"));
  end Evaluate;

  class experiment "experiment"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define default experiment parameters
</p>

<h4>Examples</h4>

<pre><b>annotation</b>(experiment(StartTime=0, StopTime=5, Tolerance=1e-6))
</pre>

<h4>Syntax</h4>

<pre>experiment_annotation:
   <b>annotation</b>\"(\" \"experiment\" \"(\" [experimentOption] {, experimentOption}] \")\"

experimentOption:
   StartTime  \"=\" [\"+\" | \"-\"] UNSIGNED_NUMBER |
   StopTime   \"=\" [\"+\" | \"-\"] UNSIGNED_NUMBER |
   Tolerance  \"=\" UNSIGNED_NUMBER
</pre>

<h4>Description</h4>

<p>
The experiment annotation defines the default start time (StartTime) in [s], the default stop time (StopTime) in [s], and the default relative integration tolerance (Tolerance) for simulation experiments to be carried out with the model or block at hand.
</p>

</html>"));
  end experiment;

  class dateModified "dateModified"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>UTC date and time of the latest change to the package in the following format (with one space between date and time):<br>
&nbsp;&nbsp;<code>YYYY-MM-DD hh:mm:ssZ</code></p>
<p><b><font style=\"color: #008000; \">Examples</font></b></p>
<pre><b>package</b> Modelica
  <b>annotation</b>(version      = &quot;3.0.1&quot;,
             versionDate  = &quot;2008-04-10&quot;,
             versionBuild = 4,
             <em>dateModified = &quot;2009-02-15 16:33:14Z&quot;</em>,
             revisionId   = &quot;$I&#8203;d:: package.mo 2566 2009-02-15 16:33:14Z #$&quot;);
  ...
  <b>end</b> Modelica;</pre>
<p><b><font style=\"color: #008000; \">Syntax</font></b></p>
<blockquote><p><code><b>annotation</b>&quot;(&quot; dateModified &quot;=&quot; STRING &quot;)&quot;</code></p></blockquote>
<p><b><font style=\"color: #008000; \">Description</font></b> </p>
<p>&ldquo;<code>dateModified</code>&rdquo; is the UTC date and time (according to <a href=\"http://en.wikipedia.org/wiki/ISO_8601\">ISO 8601</a>) of the last modification of the
package. <em>The intention is that a Modelica tool updates this annotation whenever the package or part of it
was modified and is saved on persistent storage (like file or database system).</em></p>
<p>Related annotations:</p>
<ul>
  <li><a href=\"modelica://ModelicaReference.Annotations.version\">version</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.versionDate\">versionDate</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.versionBuild\">versionBuild</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.revisionId\">revisionId</a></li>
</ul>
</html>"));
  end dateModified;

  class HideResult "HideResult"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Annotation for code generation (hide result)
</p>

<h4>Syntax</h4>

<pre>   <b>annotation</b>\"(\" HideResult \"=\" ( <b>false</b> | <b>true</b> ) \")
</pre>

<h4>Description</h4>

<p>
HideResult = true defines that the model developer proposes to not show the simulator results of the corresponding component [e.g., it will not be possible to plot this variable].
</p>

<p>
HideResult = false defines that the developer proposes to show the corresponding component [if a variable is declared in a protected section, a tool might not include it in a simulation result. By setting HideResult = false, the modeler would like to have the variable in the simulation result, even if in the protected section].
</p>

<p>
HideResult is for example used in the connectors of the Modelica.StateGraph library to not show variables to the modeler that are of no interest to him and would confuse him.
</p>

</html>"));
  end HideResult;

  class Inline "Inline"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Annotation for code generation (inline function body)
</p>

<h4>Syntax</h4>

<pre>   <b>annotation</b>\"(\" Inline \"=\" ( <b>false</b> | <b>true</b> ) \")
</pre>

<h4>Description</h4>

<p>
Has only an effect within a function declaration.
</p>

<p>
If \"Inline = true\", the model developer proposes to inline the function.
This means, that the body of the function is included at all places where the function is called.
</p>

<p>
If \"Inline = false\", the model developer proposes to not inline the function.
</p>

<p>
Inline = true is for example used in Modelica.Mechanics.MultiBody.Frames and in functions of Modelica.Media to have no overhead for function calls such as resolving a vector in a different coordinate system and at the same time the function can be analytically differentiated, e.g., for index reduction needed for mechanical systems.
</p>

</html>"));
  end Inline;

  class LateInline "LateInline"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Annotation for code generation (inline function body after symbolic processing)
</p>

<h4>Syntax</h4>

<pre>   <b>annotation</b>\"(\" LateInline \"=\" ( <b>false</b> | <b>true</b> ) \")
</pre>

<h4>Description</h4>

<p>
Has only an effect within a function declaration.
</p>

<p>
If \"LateInline = true\", the model developer proposes to inline the function after all symbolic transformations have been performed, but before common subexpression elimination takes place.
</p>

<p>
If \"LateInline = false\", the model developer proposes to not inline the function after symbolic transformations have been performed.
</p>

<p>
This annotation is for example used in Modelica.Media.Water.IF97_Utilities.T_props_ph to provide in combination with common subexpression elimination the automatic caching of function calls. Furthermore, it is used in order that a tool is able to propagate specific enthalpy over connectors in the Modelica_Fluid library.
</p>

</html>"));
  end LateInline;

  class missingInnerMessage "missingInnerMessage"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Warning message, if inner declaration is missing
</p>

<h4>Examples</h4>

<pre><b>model</b> World
  <b>annotation</b>(defaultComponentName     = \"world\",
             defaultComponentPrefixes = \"inner replaceable\",
             missingInnerMessage      = \"The World object is missing\");
  ...
<b>end</b> World;
</pre>

<h4>Syntax</h4>

<pre>   <b>annotation</b>\"(\" missingInnerMessage \"=\" STRING \")\"
</pre>

<h4>Description</h4>

<p>
When an outer component of the class does not have a corresponding inner component, the string message may be used as a diagnostic message.
</p>

</html>"));
  end missingInnerMessage;

  class PreferredView "preferredView"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define default view when selecting class
</p>

<h4>Syntax</h4>

<pre>preferred view_annotation:
   <b>annotation</b>\"(\" preferredView \"=\" (\"info\" | \"diagram\" | \"text\") \")\"
</pre>

<h4>Description</h4>

<p>
The preferredView annotation defines the default view when selecting the class. info means info layer, i.e., the documentation of the class, diagram means diagram layer and text means the Modelica text layer.
</p>

</html>"));
  end PreferredView;

  class revisionId "revisionId"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>Revision identifier of the version management system used to manage this library. It marks the latest submitted change to any file belonging to the package.</p>
<p><b><font style=\"color: #008000; \">Examples</font></b> </p>
<pre><b>package</b> Modelica
  <b>annotation</b>(version      = &quot;3.0.1&quot;,
             versionDate  = &quot;2008-04-10&quot;,
             versionBuild = 4,
             dateModified = &quot;2009-02-15 16:33:14Z&quot;,
             <em>revisionId   = &quot;$I&#8203;d:: package.mo 2566 2009-02-15 16:33:14Z #$&quot;</em>);
  ...
  <b>end</b> Modelica;</pre>
<p><b><font style=\"color: #008000; \">Syntax</font></b></p>
<blockquote><p><code><b>annotation</b>&quot;(&quot; revisionId &quot;=&quot; STRING &quot;)&quot;</code></p></blockquote>
<p><b><font style=\"color: #008000; \">Description</font></b> </p>
<p>&ldquo;<code>revisionId</code>&rdquo; is a tool specific revision identifier possibly generated by a source code management system (e.g., <a href=\"http://subversion.apache.org\">Subversion</a> or <a href=\"http://en.wikipedia.org/wiki/Concurrent_Versions_System\">CVS</a>). This information allows to exactly identify the library source code in the source code management system.</p>
<p>Related annotations:</p>
<ul>
  <li><a href=\"modelica://ModelicaReference.Annotations.version\">version</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.versionDate\">versionDate</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.versionBuild\">versionBuild</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.dateModified\">dateModified</a></li>
</ul>
</html>"));
  end revisionId;

  class smoothOrder "smoothOrder"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define differentiability of function body
</p>

<h4>Examples</h4>

<pre><b>function</b> SpecialPolynomial
  <b>input</b>  Real u;
  <b>output</b> Real y;
<b>algorithm</b>
   y = <b>if</b> u > 0 <b>then</b> u^2 <b>else</b> 0;
  <b>annotation</b>(smoothOrder = 1);
<b>end</b> SpecialPolynomial;

<b>model</b> TestSpecialPolynomial
   Real y;
   Real yd;
   Real ydd;
<b>equation</b>
   y   = SpecialPolynomial(sin(time));
   yd  = <b>der</b>(y);     // fine, SpecialPolynomial is analytically differentiated once
   ydd = <b>der</b>(yd);    // error, SpecialPolynomial cannot be differentiated twice
<b>end</b> TestSpecialPolynomial;
</pre>

<h4>Syntax</h4>

<pre>   <b>annotation</b>\"(\" smoothOrder \"=\" UNSIGNED_INTEGER \")\"
</pre>

<h4>Description</h4>

<p>
This annotation has only an effect within a function declaration.
</p>

<p>
smoothOrder defines the minimum number of differentations of the function, in order that all of the differentiated outputs are continuous provided all input arguments and their derivatives up to order smoothOrder are continuous.
</p>

<p>
This means that the function is at least C<sup>smoothOrder</sup>. smoothOrder = 1 means that the function can be differentiated at least once in order that all output arguments are still continuous, provided the input arguments are continuous. If a tool needs the derivative of a function, e.g., for index reduction or to compute an analytic Jacobian, the function can be differentiated analytically at most smoothOrder times.
</p>

</html>"));
  end smoothOrder;

  class version "version"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define version information of package
</p>

<h4>Examples</h4>

<pre><b>package</b> Modelica
  <b>annotation</b>(version=\"2.1\",
             conversion(noneFromVersion=\"2.1 Beta 1\",
                        from(version=\"1.5\",
                             script=\"convertFromModelica1_5.mos\")));
  ...
<b>end</b> Modelica;

<b>model</b> A
  <b>annotation</b>(version=\"1.0\",
     uses(Modelica(version=\"1.5\")));
  ...
<b>end</b> A;

<b>model</b> B
  <b>annotation</b>(uses(Modelica(version=\"2.1 Beta 1\")));
  ...
<b>end</b> B;
</pre>

<p>
In this example the model A uses an older version of the Modelica library and can be upgraded using the given script, and model B uses an older version of the Modelica library but no changes are required when upgrading.
</p>

<h4>Description</h4>

<p>
Version numbers are of the forms:
</p>

<ul>
<li> Main release versions:
     <pre>\"\"\" UNSIGNED_INTEGER { \".\" UNSIGNED_INTEGER } \"\"\"</pre>
     Example: <code>\"2.1\"</code><br>&nbsp;</li>

<li> Pre-release versions:
     <pre>\"\"\" UNSIGNED_INTEGER { \".\" UNSIGNED_INTEGER } \" \" {S-CHAR} \"\"\"</pre>
     Example: <code>\"2.1 Beta 1\"</code><br>&nbsp;</li>

<li> Un-ordered versions:
     <pre> \"\"\" NON-DIGIT {S-CHAR} \"\"\" </pre>
     Example: <code>\"Test 1\"</code></li>
</ul>

<p>
The main release versions are ordered using the hierarchical numerical names, and follow the corresponding pre-release versions. The pre-release versions of the same main release version are internally ordered alphabetically.
</p>

<p>
In a top-level class, the version number and the dependency to earlier versions of this class are defined using one or more of the following annotations:
</p>

<ul>
<li> <code>version = CURRENT-VERSION-NUMBER</code><br>
     Defines the version number of the model or package.
     All classes within this top-level class have this version number.<br>&nbsp;</li>

<li> <code>conversion ( noneFromVersion = VERSION-NUMBER)</code><br>
     Defines that user models using the VERSION-NUMBER can be upgraded to
     the CURRENT-VERSION-NUMBER of the current class without any changes.<br>&nbsp;</li>

<li> <code>conversion ( from (version = VERSION-NUMBER, script = \"?\") ) </code><br>
     Defines that user models using the VERSION-NUMBER can be upgraded to
     the CURRENT-VERSION-NUMBER of the current class by applying the given
     script. The semantics of the conversion script is not defined.<br>&nbsp;</li>

<li> <code>uses(IDENT (version = VERSION-NUMBER) )</code><br>
     Defines that classes within this top-level class uses version
     VERSION-NUMBER of classes within the top-level class IDENT.
     The annotations uses and conversion may contain several different sub-entries.</li>
</ul>

<p>
A top-level class, IDENT, with version VERSION-NUMBER can be stored in one
of the following ways in a directory given in the MODELICAPATH:
</p>

<ul>
<li> The file IDENT \".mo\"<br>
     Example: Modelica.mo</li>
<li> The file IDENT \" \" VERSION-NUMBER \".mo\"<br>
     Example: Modelica 2.1.mo</li>
<li> The directory IDENT<br>
     Example: Modelica</li>
<li> The directory IDENT \" \" VERSION-NUMBER<br>
     Example: Modelica 2.1</li>
</ul>
<p>
This allows a tool to access multiple versions of the same package.
</p>
<p>Related annotations:</p>
<ul>
  <li><a href=\"modelica://ModelicaReference.Annotations.version\">version</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.versionBuild\">versionBuild</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.dateModified\">dateModified</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.revisionId\">revisionId</a></li>
</ul>
</html>"));
  end version;

  class versionBuild "versionBuild"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>Defines the optional build number of the library.</p>
<p><b><font style=\"color: #008000; \">Examples</font></b> </p>
<pre><b>package</b> Modelica
  <b>annotation</b>(version      = &quot;3.0.1&quot;,
             versionDate  = &quot;2008-04-10&quot;,
             <em>versionBuild = 4</em>,
             dateModified = &quot;2009-02-15 16:33:14Z&quot;,
             revisionId   = &quot;$I&#8203;d:: package.mo 2566 2009-02-15 16:33:14Z #$&quot;);
  ...
  <b>end</b> Modelica;</pre>
<p><b><font style=\"color: #008000; \">Syntax</font></b></p>
<blockquote><p><code><b>annotation</b>&quot;(&quot; versionBuild &quot;=&quot; INTEGER &quot;)&quot;</code></p></blockquote>
<p><b><font style=\"color: #008000; \">Description</font></b> </p>
<p>&ldquo;<code>versionBuild</code>&rdquo; is the optional build number of the library. When a new version is released &ldquo;<code>versionBuild</code>&rdquo; should be omitted or &ldquo;<code>versionBuild = 1</code>&rdquo;. There might be bug fixes to the library that do not justify a new library version. Such maintenance changes are called a &ldquo;build&rdquo; release of the library. For every new maintenance change, the &ldquo;<code>versionBuild</code>&rdquo; number is increased. A &ldquo;<code>versionBuild</code>&rdquo; number A that is higher as &ldquo;<code>versionBuild</code>&rdquo; number B, is a newer release of the library. There are no conversions between the same versions with different build numbers.</p>
<p>Related annotations:</p>
<ul>
  <li><a href=\"modelica://ModelicaReference.Annotations.version\">version</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.versionDate\">versionDate</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.dateModified\">dateModified</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.revisionId\">revisionId</a></li>
</ul>
</html>"));
  end versionBuild;

  class versionDate "versionDate"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>UTC date of first version build (in format: <code>YYYY-MM-DD</code>).</p>
<p><b><font style=\"color: #008000; \">Examples</font></b> </p>
<pre><b>package</b> Modelica
  <b>annotation</b>(version      = &quot;3.0.1&quot;,
             <em>versionDate  = &quot;2008-04-10&quot;</em>,
             versionBuild = 4,
             dateModified = &quot;2009-02-15 16:33:14Z&quot;,
             revisionId   = &quot;$I&#8203;d:: package.mo 2566 2009-02-15 16:33:14Z #$&quot;);
  ...
  <b>end</b> Modelica;</pre>
<p><b><font style=\"color: #008000; \">Syntax</font></b></p>
<blockquote><p><code><b>annotation</b>&quot;(&quot; versionDate &quot;=&quot; STRING &quot;)&quot;</code></p></blockquote>
<p><b><font style=\"color: #008000; \">Description</font></b> </p>
<p>&ldquo;<code>versionDate</code>&rdquo; is the date in UTC format (according to <a href=\"http://en.wikipedia.org/wiki/ISO_8601\">ISO 8601</a>) when the library was released.</p>
<p>Related annotations:</p>
<ul>
  <li><a href=\"modelica://ModelicaReference.Annotations.version\">version</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.versionBuild\">versionBuild</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.dateModified\">dateModified</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.revisionId\">revisionId</a></li>
</ul>
</html>"));
  end versionDate;

  class unassignedMessage "unassignedMessage"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Error message, if variable is not assigned
</p>

<h4>Examples</h4>

<pre><b>connector</b> Frame \"Frame of a mechanical system\"
    ...
  <b>flow</b> Modelica.SIunits.Force f[3] <b>annotation</b>(unassignedMessage =
\"All Forces cannot be uniquely calculated. The reason could be that the
mechanism contains a planar loop or that joints constrain the same motion.
For planar loops, use in one revolute joint per loop the option
PlanarCutJoint=true in the Advanced menu.
\");
<b>end</b> Frame;
</pre>

<h4>Syntax</h4>

<pre>   <b>annotation</b>\"(\" unassignedMessage \"=\" STRING \")\"
</pre>

<h4>Description</h4>

<p>
When the variable to which this annotation is attached in the declaration cannot be computed due to the structure of the equations, the string message can be used as a diagnostic message. When using BLT partitioning, this means if a variable \"a\" or one of its aliases \"b = a\", \"b = -a\", cannot be assigned, the message is displayed. This annotation is used to provide library specific error messages.
</p>
</html>"));
  end unassignedMessage;
  annotation (Documentation(info="<html>
<p>
In this package annotations are described.
Annotations are intended for storing extra information about a model, such as graphics, documentation or versioning. A Modelica tool is free to define and use other annotations, in addition to those defined here. The only requirement is that any tool shall save files with all annotations from this chapter and all vendor-specific annotations intact. To ensure this, annotations must be represented with constructs according to the Modelica grammar. The Modelica language specification defines the semantic meaning if a tool implements any of these annotations.
</p>
</html>"));
end Annotations;


package Classes "Classes (model, function, ...)"
  extends ModelicaReference.Icons.Information;
  class 'block' "block"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define specialized class <i>block</i>
</p>
<h4>Examples</h4>

<pre><b>block</b> Integrator
  <b>input</b> Real u;
  <b>output</b> Real y;
<b>protected</b>
  Real x;
<b>equation
  der</b>(x) = u;
  y = x;
<b>end</b> Integrator;</pre>

<h4>Syntax</h4>

<PRE>   [ <B>encapsulated</B> ][ <B>partial </B>] <B>block</B>
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment</PRE>

<p>See Modelica Language Specification for further details.</p>

<h4>Description</h4>
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
  end 'block';

  class 'class' "class"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define class
</p>
<h4>Examples</h4>

<pre><b>class</b> MyTable
  <b>extends</b> ExternalObject;
  <b>function</b> constructor
     ...
  <b>end</b> constructor;

  <b>function</b> destructor
     ...
  <b>end</b> destructor;
<b>end</b> MyTable;</pre>

<h4>Syntax</h4>
<PRE>   [ <B>encapsulated</B> ][ <B>partial </B>] <B>class</B>
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment</PRE>

<p>See Modelica Language Specification for further details.</p>

<h4>Description</h4>

<p>
The keyword class is used to define general classes (without any restrictions).
It is identical to the keyword model.
In most cases, it is recommended to use specialized classes as
<a href=\"modelica://ModelicaReference.Classes.Connector\">connector</a>,
<a href=\"modelica://ModelicaReference.Classes.Model\">model</a>,
<a href=\"modelica://ModelicaReference.Classes.Block\">block</a>,
<a href=\"modelica://ModelicaReference.Classes.Package\">package</a>,
<a href=\"modelica://ModelicaReference.Classes.Record\">record</a>,
<a href=\"modelica://ModelicaReference.Classes.Function\">function</a>,
<a href=\"modelica://ModelicaReference.Classes.Type\">type</a>.
\"class\" should only be used to define
<a href=\"modelica://ModelicaReference.Classes.ExternalObject\">ExternalObject</a>s.
</p>
</html>"));
  end 'class';

  class 'connector' "connector"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define specialized class <i>connector</i>
</p>
<h4>Examples</h4>

<pre><b>connector</b> flange
  Modelica.SIunits.Angle phi;
  <b>flow</b> Modelica.SIunits.Torque tau;
<b>end</b> flange;</pre>

<h4>Syntax</h4>
<PRE>   [ <B>encapsulated</B> ][ <B>partial </B>] <B>connector</B>
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment</PRE>

<p>See Modelica Language Specification for further details.</p>

<h4>Description</h4>
<p>The keyword connector is used to define connectors, which are used
in
<a href=\"modelica://ModelicaReference.Connect\">connect</a>
statements. In connectors, no equations are allowed in the
definition or in any of its components.
With respect to \"class\", it is enhanced to allow connect(..) to components
of connector classes.
</p>

<p>
Variable declarations in a connector can have the additional prefixes
<a href=\"modelica://ModelicaReference.Flow\">flow</a> or
<a href=\"modelica://ModelicaReference.Stream\">stream</a>, besides
the prefixes
<a href=\"modelica://ModelicaReference.Input\">input</a> and
<a href=\"modelica://ModelicaReference.Output\">output</a>, that are
also allowed outside of a connector. Based on the prefix, a
<a href=\"modelica://ModelicaReference.Connect\">connect</a>
statement leads to specific connection equations, that describe the
balance equations in the infinitesimal connection points.
</p>

<h4>Example</h4>

<p>
If three connectors c1, c2, c3 with the definition
</p>

<pre>
<b>connector</b> Demo
  Real        p;  // potential variable
  <b>flow</b>   Real f;  // flow variable
  <b>stream</b> Real s;  // stream variable
<b>end</b> Demo;
</pre>

<p>
are connected together with
</p>

<pre>
   <b>connect</b>(c1,c2);
   <b>connect</b>(c1,c3);
</pre>

<p>
then this leads to the following equations:
</p>

<pre>
  // Potential variables are identical
  c1.p = c2.p;
  c1.p = c3.p;

  // The sum of the flow variables is zero
  0 = c1.f + c2.f + c3.f;

  /* The sum of the product of flow variables and upstream stream variables is zero
     (this implicit set of equations is explicitly solved when generating code;
     the \"&lt;undefined&gt;\" parts are defined in such a way that
     inStream(..) is continuous).
  */
  0 = c1.f*(<b>if</b> c1.f > 0 <b>then</b> s_mix <b>else</b> c1.s) +
      c2.f*(<b>if</b> c2.f > 0 <b>then</b> s_mix <b>else</b> c2.s) +
      c3.f*(<b>if</b> c3.f > 0 <b>then</b> s_mix <b>else</b> c3.s);

  <b>inStream</b>(c1.s) = <b>if</b> c1.f > 0 <b>then</b> s_mix <b>else</b> &lt;undefined&gt;;
  <b>inStream</b>(c2.s) = <b>if</b> c2.f > 0 <b>then</b> s_mix <b>else</b> &lt;undefined&gt;;
  <b>inStream</b>(c3.s) = <b>if</b> c3.f > 0 <b>then</b> s_mix <b>else</b> &lt;undefined&gt;;
</pre>
</html>"));
  end 'connector';

  class 'function' "function"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define specialized class <i>function</i>
</p>
<h4>Examples</h4>

<pre><b>function</b> si
  <b>input</b> Real x;
  <b>output</b> Real y;
<b>algorithm</b>
  y = <b>if abs</b>(x) &lt; Modelica.Constants.eps <b>then</b> 1 <b>else</b> Modelica.Math.sin(x)/x;
<b>end</b> si;</pre>

<img src=\"modelica://ModelicaReference/Resources/Images/function.png\" width=\"400\" height=\"280\" alt=\"Simulation result\">

<h4>Syntax</h4>

<PRE>   [ <B>encapsulated</B> ][ <B>partial </B>] <B>function</B>
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment</PRE>

<p>See Modelica Language Specification for further details.</p>

<h4>Description</h4>

<P>The keyword function is used to define functions as known from programming
languages. Each part of a function interface must
either have causality equal to input or output. A function may not be used in connections.
In functions, no equations or initial algorithm and at most
one algorithm clause are allowed. Calling a function requires
either an algorithm clause or an external function interface.</p>

<p>
The syntax and semantics of a function have many similarities to those of the block
specialized class. A function has many of the properties of a general class,
e.g., being able to inherit other functions, or to redeclare or modify
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
     of those. If an output or a local array dimension is declared with (:),
     the size of the dimension can be changed in the function. A size change
     takes place by assigning a full array with the respective sizes to the
     dynamically sized array on the left hand side of an equal sign.</li>

<li> The local variables of a function are not automatically initialized to
     the implicit default values of the data type [(e.g., 0.0 for Real)
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
     the function is translated).</li>
</ul>

<p>
A function may have a function as an input argument.
The declared type of such an input formal parameter in a function can be
the class-name of a partial function that has no replaceable elements.
It cannot be the class-name of a record [i.e., <i>record constructor functions are not
allowed in this context.</i>] Such an input formal parameter of function type
can also have an optional functional default value. Example:
</p>

<blockquote><pre>
<b>function</b> quadrature \"Integrate function y=integrand(x) from x1 to x2\"
  <b>input</b>  Real x1;
  <b>input</b>  Real x2;
  <b>input</b>  Integrand integrand;   // Integrand is a partial function, see below
  // With default: input Integrand integrand := Modelica.Math.sin;
  <b>output</b> Real integral;
<b>algorithm</b>
  integral :=(x2-x1)*(integrand(x1) + integrand(x2))/2;
<b>end</b> quadrature;

<b>partial function</b> Integrand
  <b>input</b>  Real x;
  <b>output</b> Real y;
<b>end</b> Integrand;
</pre></blockquote>

<p>
A functional argument can be provided in one of the following forms
to be passed to a formal parameter of function type in a function call
(see examples below):
</p>
<ol>
<li> as a function name,</li>
<li> as a function partial application, </li>
<li> as a function that is a component,</li>
<li> as a function partial application of a function that is a component.</li>
</ol>

<p>
In all cases the provided function must be \"function type compatible\"
to the corresponding formal parameter of function type. Example:
</p>

<blockquote><pre>
// A function as a positional input argument according to case (a)
<b>function</b> Parabola
   <b>extends</b> Integrand;
<b>algorithm</b>
   y = x*x;
<b>end</b> Parabola;

area = quadrature(0, 1, Parabola);

// The quadrature2 example below uses a function integrand that
// is a component as input argument according to case (c):
<b>function</b> quadrature2 \"Integrate function y=integrand(x) from x1 to x2\"
  <b>input</b>  Real x1;
  <b>input</b>  Real x2;
  <b>input</b>  Integrand integrand;   // Integrand is a partial function type
  <b>output</b> Real integral;
<b>algorithm</b>
   integral := quadrature(x1,       (x1+x2)/2, integrand)+
               quadrature((x1+x2)/2, x2,       integrand);
<b>end</b> quadrature2;
</pre></blockquote>

<p>
A function partial application is a function call with certain
formal parameters bound to expressions. A function partial application
returns a partially evaluated function that is also a function,
with the remaining not bound formal parameters still present in the
same order as in the original function declaration. A function partial
application is specified by the function keyword followed by a function
call to func_name giving named formal parameter associations for the
formal parameters to be bound, e.g.:
</p>

<blockquote><pre>
<b>function</b> func_name(..., formal_parameter_name = expr, ...)
</pre></blockquote>

<p>
[<i>Note that the keyword function in a function partial application
differentiates the syntax from a normal function call where some
parameters have been left out, and instead supplied via default values.</i>]
The function created by the function partial application acts as the
original function but with the bound formal input parameters(s) removed,
i.e., they cannot be supplied arguments at function call. The binding
occurs when the partially evaluated function is created. A partially
evaluated function is \"function compatible\" to the same function where
all bound arguments are removed [<i>thus, for checking function type
compatibility, bound formal parameters are ignored</i>].
</p>

<p>
Example of function partial application as argument, positional argument passing, according to case (b) above:
</p>

<blockquote><pre>
<b>model</b> Test
   <b>parameter</b> Integer N;
   Real area;
<b>algorithm</b>
   area := 0;
   <b>for</b> i <b>in</b> 1:N <b>loop</b>
     area  := area + quadrature(0, 1, <b>function</b> Sine(A=2, w=i*time));
   <b>end for</b>;
<b>end</b> Test;

<b>function</b> Sine  \"y = Sine(x,A,w)\"
  <b>extends</b> Integrand;
  <b>input</b> Real A;
  <b>input</b> Real w;
<b>algorithm</b>
  y:=A*Modelica.Math.sin(w*x);
<b>end</b> Sine;

//Call with function partial application as named input argument:
area  := area + quadrature(0, 1, integrand = <b>function</b> Sine(A=2, w=i*time));
</pre></blockquote>

<p>
Example showing that function types are matching after
removing the bound arguments A and w in a function partial
application:
</p>

<blockquote><pre>
<b>function</b> Sine2  \"y = Sine2(A,w,x)\"
  <b>input</b> Real A;
  <b>input</b> Real w;
  <b>input</b> Real x; // Note: x is now last in argument list.
  <b>output</b> Real y;
<b>algorithm</b>
  y:=A*Modelica.Math.sin(w*x);
<b>end</b> Sine2;

// The partially evaluated Sine2 has only one argument:
// x - and is thus type compatible with Integrand.
area = quadrature(0, 1, integrand = <b>function</b> Sine2(A=2, w=3));
</pre></blockquote>

<p>
Example of a function partial application of a function that is
a component, according to case (d) above:
</p>

<blockquote><pre>
<b>partial function</b> SurfaceIntegrand
   <b>input</b> Real x;
   <b>input</b> Real y;
   <b>output</b> Real z;
<b>end</b> SurfaceIntegrand;

<b>function</b> quadratureOnce
  <b>input</b> Real x;
  <b>input</b> Real y1;
  <b>input</b> Real y2;
  <b>inpu</b>t SurfaceIntegrand integrand;
  <b>output</b> Real z;
<b>algorithm</b>
  // This is according to case (d) and needs to bind the 2nd argument
  z := quadrature(y1, y2, <b>function</b> integrand(y=x));
<b>end</b> quadratureOnce;

<b>function</b> surfaceQuadrature
  <b>input</b> Real x1;
  <b>input</b> Real x2;
  <b>input</b> Real y1;
  <b>input</b> Real y2;
  <b>input</b> SurfaceIntegrand integrand;
  <b>output</b> Real integral;
<b>algorithm</b>
   // Case (b) and (c)
   integral := quadrature(x1, x2,
     <b>function</b> quadratureOnce(y1=y1, y2=y2, integrand=integrand);
<b>end</b> surfaceQuadrature;
</pre></blockquote>
</html>"));
  end 'function';

  class 'model' "model"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define specialized class <i>model</i>
</p>
<h4>Examples</h4>

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

<h4>Syntax</h4>
<PRE>   [ <B>encapsulated</B> ][ <B>partial </B>] <B>model</B>
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment</PRE>

<p>See Modelica Language Specification for further details.</p>

<h4>Description</h4>
<P>
The keyword model is identical to the keyword class, i.e.,
no restrictions and no enhancements.
</P>
</html>"));
  end 'model';

  class 'package' "package"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define specialized class <i>package</i>
</p>
<h4>Examples</h4>

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

<h4>Syntax</h4>
<PRE>   [ <B>encapsulated</B> ][ <B>partial </B>] <B>package</B>
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment</PRE>

<p>See Modelica Language Specification for further details.</p>

<h4>Description</h4>
<P>May only contain declarations of classes and constants.
   Enhanced to allow import of elements of packages.</P>

</html>"));
  end 'package';

  class 'record' "record"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Define specialized class <i>record</i>
</p>
<h4>Examples</h4>

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

<h4>Syntax</h4>
<PRE>   [ <B>encapsulated</B> ][ <B>partial </B>] <B>record</B>
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment</PRE>

<p>See Modelica Language Specification for further details.</p>

<h4>Description</h4>

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
  end 'record';

  class 'type' "type"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Define specialized class <i>type</i>
</p>
<h4>Examples</h4>

<pre><b>type</b> R0Plus = Real(min=0);</pre>

<h4>Syntax</h4>
<PRE>   [ <B>encapsulated</B> ][ <B>partial </B>] <B>type</B>
   IDENT class_specifier

class_specifier :
   string_comment composition <B>end</B> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <B>enumeration</B> \"(\" ( [enum_list] | \":\" ) \")\" comment</PRE>

<p>See Modelica Language Specification for further details.</p>

<h4>Description</h4>
<p>The keyword type is used to define types, which may only be extensions to the predefined types, enumerations, array of type, or classes extending from type.
Enhanced to extend from predefined types [No other specialized class has this property].
</p>

</html>"));
  end 'type';

  class ExternalObject "ExternalObject"
  extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define external functions with internal memory.
</p>

<h4>Description</h4>

<p>
External functions may have internal memory reported between function calls. Within Modelica this memory is defined as instance of the predefined class <b>ExternalObject</b> according to the following rules:
</p>

<ul>
<li> There is a predefined partial class <b>ExternalObject</b>
     [<i>since the class is partial, it is not possible to define an
     instance of this class</i>].</li>

<li> An external object class shall be directly extended from
     ExternalObject, shall have exactly two function definitions,
     called \"<b>constructor</b>\" and \"<b>destructor</b>\", and
     shall not contain other elements. </li>

<li> The constructor function is called exactly once before the first use of
     the object. For each completely constructed object, the destructor
     is called exactly once, after the last use of the object, even
     if an error occurs. The constructor shall have exactly one output
     argument in which the constructed ExternalObject is returned.
     The destructor shall have no output arguments and the only input
     argument of the destructor shall be the ExternalObject.
     It is not legal to call explicitly the constructor and destructor
     functions.</li>

<li> Classes derived from ExternalObject can neither be used in an
     extends-clause nor in a short class definition.</li>

<li> External functions may be defined which operate on the internal memory
     of an ExternalObject. An ExternalObject used as input argument or
     return value of an external C-function is mapped to the C-type \"void*\".</li>
</ul>

<h4>Examples</h4>

<p>
A user-defined table may be defined in the following way as an ExternalObject
(the table is read in a user-defined format from file and has memory for the last used table interval):
</p>

<pre>
<b>class</b> MyTable
  <b>extends</b> ExternalObject;
  <b>function</b> constructor
    <b>input</b>  String  fileName := \"\";
    <b>input</b>  String  tableName := \"\";
    <b>output</b> MyTable table;
    <b>external</b> \"C\" table = initMyTable(fileName, tableName);
  <b>end</b> constructor;

  <b>function</b> destructor \"Release storage of table\"
    <b>inpu</b>t  MyTable table;
    <b>external</b> \"C\" closeMyTable(table);
  <b>end</b> destructor;
<b>end</b> MyTable;
</pre>

<p>
and used in the following way:
</p>

<pre>
<b>model</b> test \"Define a new table and interpolate in it\"
  MyTable table=MyTable(fileName =\"testTables.txt\",
                        tableName=\"table1\");  // call initMyTable
  Real y;
<b>equation</b>
  y = interpolateMyTable(table, time);
<b>end</b> test;
</pre>

<p>
This requires to provide the following Modelica function:
</p>

<pre>
<b>function</b> interpolateMyTable \"Interpolate in table\"
  <b>input</b>  MyTable table;
  <b>input</b>  Real  u;
  <b>output</b> Real  y;
  <b>external</b> \"C\" y = interpolateMyTable(table, u);
<b>end</b> interpolateTable;
</pre>

<p>
The external C-functions may be defined in the following way:
</p>

<pre>
<b>typedef struct</b> {  /* User-defined datastructure of the table */
  <b>double</b>* array;      /* nrow*ncolumn vector       */
  <b>int</b>     nrow;       /* number of rows            */
  <b>int</b>     ncol;       /* number of columns         */
  <b>int</b>     type;       /* interpolation type        */
  <b>int</b>     lastIndex;  /* last row index for search */
} MyTable;

<b>void</b>* initMyTable(char* fileName, char* tableName) {
  MyTable* table = malloc(sizeof(MyTable));
  <b>if</b> ( table == NULL ) ModelicaError(\"Not enough memory\");
        // read table from file and store all data in *table
  <b>return</b> (void*) table;
};

<b>void </b>closeMyTable(void* object) { /* Release table storage */
  MyTable* table = (MyTable*) object;
  <b>if</b> ( object == NULL ) return;
  free(table->array);
  free(table);
}

<b>double</b> interpolateMyTable(void* object, double u) {
  MyTable* table = (MyTable*) object;
  <b>double</b> y;
  // Interpolate using \"table\" data (compute y)
  <b>return</b> y;
};
</pre>
</html>"));
  end ExternalObject;
  annotation (Documentation(info="<html>
<p>
In this package specialized kinds of classes (earlier known as restricted classes) are
described. They have the properties of a general class, apart from restrictions.
Moreover, they have additional properties called enhancements.
</p>
</html>"));
end Classes;


package Operators "Operators (+, der, size, ...)"
  extends ModelicaReference.Icons.Information;
class ElementaryOperators "Elementary operators (+, >, or, ..)"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Elementary operators are overloaded and operate on variables
of type Real, Integer, Boolean, and String, as well as on scalars
or arrays.
</p>
<h4>Syntax</h4>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td colspan=\"3\"><b>Arithmetic Operators (operate on Real, Integer scalars or arrays)</b></td>
  <tr><td><i>Operators</i></td>
      <td><i>Example</i></td>
      <td><i>Description</i></td>
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
      <td><i>Description</i></td>
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
      <td>a &lt;= b</td>
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
      <td><i>Description</i></td>
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
      <td><i>Description</i></td>
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

<p>Operator precedence determines the order of evaluation of operators in an expression. An operator with higher precedence is evaluated before an operator with lower precedence in the same expression.</p>

<p>The following table presents all the expression operators in order of precedence from highest to lowest. All operators are binary except exponentiation, the postfix operators and those shown as unary together with <i>expr</i>, the conditional operator, the array construction operator {} and concatenation operator [ ], and the array range constructor which is either binary or ternary. Operators with the same precedence occur at the same line of the table:</p>

<table border=\"1\" cellpadding=\"1\" cellspacing=\"1\">
    <tr>
      <td><i>Operator Group</i></td>
      <td><i>Operator Syntax</i></td>
      <td><i>Examples</i></td>
    </tr>
    <tr>
      <td>postfix array index operator</td>
      <td><code>[]</code></td>
      <td><code>arr[index]</code></td>
    </tr>
    <tr>
      <td>postfix access operator</td>
      <td><code>.</code></td>
      <td><code>a.b</code></td>
    </tr>
    <tr>
      <td>postfix function call</td>
      <td><i>funcName(function-arguments)</i></td>
      <td><code>sin(4.36)</code></td>
    </tr>
    <tr>
      <td>array construct/concat</td>
      <td>{<i>expressions</i>}<br>
          [<i>expressions</i>]<br>
          [<i>expressions</i>; <i>expressions</i>...]
      </td>
      <td><code>{2,3}<br>[5,6]<br>[2,3; 7,8]</code></td>
    </tr>
    <tr>
      <td>exponentiation</td>
      <td><code>^</code></td>
      <td><code>2^3</code></td>
    </tr>
    <tr>
      <td>multiplicative and<br> array elementwise multiplicative</td>
      <td><code>*&nbsp;&nbsp;/&nbsp;&nbsp;.*&nbsp;&nbsp;./</code></td>
      <td><code>2*3&nbsp;&nbsp; 2/3<br>
                [1,2;3,4].*[2,3;5,6]</code></td>
    </tr>
    <tr>
      <td>additive and<br> array elementwise additive</td>
      <td><code>+&nbsp;&nbsp;-&nbsp;&nbsp;+<i>expr</i>&nbsp;&nbsp;-<i>expr</i><br>
                .+&nbsp;&nbsp;.-</code></td>
      <td><code>a+b, a-b, +a, -a<br>
                [1,2;3,4].+[2,3;5,6]</code</td>
    </tr>
    <tr>
      <td>relational</td>
      <td><code>&lt;&nbsp;&nbsp;&lt;=&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;=&nbsp;&nbsp;==&nbsp;&nbsp;&lt;&gt;</code></td>
      <td><code>a&lt;b,&nbsp;a&lt;=b, a&gt;b, ...</code></td>
    </tr>
    <tr>
      <td><code>...</code></td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>unary negation</td>
      <td><code>not&nbsp;<i>expr</i></code></td>
      <td><code>not b1</code></td>
    </tr>
    <tr>
      <td>logical and</td>
      <td><code>and</code></td>
      <td><code>b1 and b2</code></td>
    </tr>
    <tr>
      <td>logical or<</td>
      <td><code>or</code></td>
      <td><code>b1 or b2</code</td>
    </tr>
    <tr>
      <td>array range</td>
      <td><i>expr</i>&nbsp;<code>:</code>&nbsp;<i>expr</i>&nbsp;<code>:</code>&nbsp;<i>expr</i></td>
      <td><code>1:5:100</code>, start:step:stop</td>
    </tr>
    <tr>
      <td>conditional</td>
      <td><code>if</code>&nbsp;<i>expr</i>&nbsp;<code>then</code>&nbsp;<i>expr</i>&nbsp;<code>else</code>&nbsp;<i>expr</i></td>
      <td><code>if b then 3 else x</code></td>
    </tr>
    <tr>
      <td>named argument</td>
      <td><i>ident&nbsp;</i><code>=</code>&nbsp;<i>expr</i></td>
      <td><code>x = 2.26</code></td>
    </tr>
</table>
<p>The conditional operator may also include <code>elseif</code>-clauses. Equality <code>=</code> and assignment <code>:=</code> are not expression operators since they are allowed only in equations and in assignment statements respectively. All binary expression
operators are left associative.</p>

<p>Note, the unary minus and plus in Modelica
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

  class 'abs()' "abs()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Absolute value of Real or Integer variable.
</p>
<h4>Syntax</h4>
<blockquote><code><b>abs</b>(v)</code></blockquote>
<h4>Description</h4>
<P>Is expanded into &quot;noEvent(<B>if </B>v &ge; 0
<B>then</B> v <B>else</B> -v)&quot;. Argument v
needs to be an Integer or Real expression. </P>
<h4>Examples</h4>
<pre>
  <b>abs</b>({-3, 0, 3})
 = {3, 0, 3}</pre>
</html>"));
  end 'abs()';

  class 'acos()' "acos()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Trigonometric inverse cosine function
</p>
<h4>Syntax</h4>
<blockquote><code><b>acos</b>(u)</code></blockquote>
<h4>Description</h4>

<p>Returns the inverse of cos of u, with -1 &le; u &le; +1.
Argument u needs to be an Integer or Real expression.</p>

<p>
The acos function can also be accessed as Modelica.Math.acos.
</p>

<img src=\"modelica://ModelicaReference/Resources/Images/acos.png\" alt=\"acos\">

<h4>Examples</h4>
<pre><b>acos</b>(0)
 = 1.5707963267949</pre>
</html>"));
  end 'acos()';

  class 'asin()' "asin()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Trigonometric inverse sine function
</p>
<h4>Syntax</h4>
<blockquote><code><b>asin</b>(u)</code></blockquote>
<h4>Description</h4>

<p>Returns the inverse of sin of u, with -1 &le; u &le; +1.
Argument u needs to be an Integer or Real expression.</p>

<p>
The asin function can also be accessed as Modelica.Math.asin.
</p>

<img src=\"modelica://ModelicaReference/Resources/Images/asin.png\" alt=\"asin\">

<h4>Examples</h4>
<pre><b>asin</b>(0)
 = 0.0</pre>
</html>"));
  end 'asin()';

  class 'assert()' "assert()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Trigger error and print error message if assertion condition is not fulfilled
</p>
<h4>Syntax</h4>
<blockquote><code><b>assert</b>(condition, message, level = AssertionLevel.error)</code></blockquote>
<h4>Description</h4>
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

<h4>Examples</h4>
<pre>  <b>parameter</b> Real upperLimit=2;
  <b>parameter</b> Real lowerLimit=-2;
<b>equation</b>
  <b>assert</b>(upperLimit > lowerLimit, \"upperLimit must be greater than lowerLimit.\");
</pre>
</html>"));
  end 'assert()';

  class 'atan()' "atan()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Trigonometric inverse tangent function
</p>
<h4>Syntax</h4>
<blockquote><code><b>atan</b>(u)</code></blockquote>
<h4>Description</h4>

<p>Returns the inverse of tan of u, with -&infin; &lt; u &lt; &infin;.
Argument u needs to be an Integer or Real expression.</p>

<p>
The atan function can also be accessed as Modelica.Math.atan.
</p>

<img src=\"modelica://ModelicaReference/Resources/Images/atan.png\" alt=\"atan\">

<h4>Examples</h4>
<pre><b>atan</b>(1)
 = 0.785398163397448</pre>
</html>"));
  end 'atan()';

  class 'atan2()' "atan2()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Four quadrant inverse tangent
</p>
<h4>Syntax</h4>
<blockquote><pre><b>atan2</b>(u1,u2)</pre></blockquote>
<h4>Description</h4>

<p>
Returns y = atan2(u1,u2) such that tan(y) = u1/u2 and
y is in the range -pi &lt; y &le; pi. u2 may be zero, provided
u1 is not zero. Usually u1, u2 is provided in such a form that
u1 = sin(y) and u2 = cos(y).
Arguments u1 and u2 need to be Integer or Real expressions.
</p>

<p>
The atan2 function can also be accessed as Modelica.Math.atan2.
</p>

<img src=\"modelica://ModelicaReference/Resources/Images/atan2.png\" alt=\"atan2\">

<h4>Examples</h4>
<pre><b>atan2</b>(1,0)
 = 1.5707963267949</pre>
</html>"));
  end 'atan2()';

  class 'cardinality()' "cardinality()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Number of connectors in connection.
This is a deprecated operator. It should  no longer be used, since it will be removed in one of the next Modelica releases.
</p>

<h4>Syntax</h4>
<blockquote><pre><b>cardinality</b>(c)</pre></blockquote>
<h4>Description</h4>
<p>Returns the number of (inside and outside) occurrences
of connector instance c in a connect statement as an Integer number.</p>
<p><i>[The cardinality operator allows the definition of connection dependent equations in a model.]</i></p>

<p>
Instead of the cardinality(..) operator, often conditional
connectors can be used, that are enabled/disabled via Boolean
parameters.
</p>

<h4>Examples</h4>
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
  end 'cardinality()';

  class 'ceil()' "ceil()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Round a Real number towards plus infinity
</p>
<h4>Syntax</h4>
<blockquote><pre><b>ceil</b>(x)</pre></blockquote>
<h4>Description</h4>
<p>Returns the smallest integer not less than <code>x</code>.
Result and argument shall have type Real.
<i>[Note, outside of a when clause state events are
triggered when the return value changes discontinuously.]</i></p>
<h4>Examples</h4>
<pre><b>ceil</b>({-3.14, 3.14})
 = {-3.0, 4.0}</pre>
</html>"));
  end 'ceil()';

  class 'change()' "change()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Indicate discrete variable changing
</p>
<h4>Syntax</h4>
<blockquote><pre><b>change</b>(v)</pre></blockquote>
<h4>Description</h4>
<P>Is expanded into &quot;(v&lt;&gt;pre(v))&quot;.
The same restrictions as for the pre() operator apply.</P>
<h4>Examples</h4>
<pre><b>model</b> BothEdges
  Boolean u;
  Integer i;
<b>equation</b>
  u = Modelica.Math.sin(<b>time</b>) &gt; 0.5;
  <b>when</b> <b>change</b>(u) <b>then</b>
    i = <b>pre</b>(i) + 1;
  <b>end when</b>;
<b>end</b> BothEdges;</pre>

<img src=\"modelica://ModelicaReference/Resources/Images/change.png\" width=\"400\" height=\"280\" alt=\"Simulation result\">
</html>"));
  end 'change()';

  class 'cos()' "cos()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Trigonometric cosine function
</p>
<h4>Syntax</h4>
<blockquote><pre><b>cos</b>(u)</pre></blockquote>
<h4>Description</h4>
<p>Returns the cosine of u, with -&infin; &lt; u &lt; &infin;
Argument u needs to be an Integer or Real expression.</p>

<p>
The cosine function can also be accessed as Modelica.Math.cos.
</p>

<img src=\"modelica://ModelicaReference/Resources/Images/cos.png\" alt=\"cos\">

<h4>Examples</h4>
<pre><b>cos</b>(3.14159265358979)
 = -1.0</pre>
</html>"));
  end 'cos()';

  class 'cosh()' "cosh()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Hyberbolic cosine function
</p>
<h4>Syntax</h4>
<blockquote><pre><b>cosh</b>(u)</pre></blockquote>
<h4>Description</h4>
<p>Returns the cosh of u, with -&infin; &lt; u &lt; &infin;.
Argument u needs to be an Integer or Real expression.</p>

<p>
The cosh function can also be accessed as Modelica.Math.cosh.
</p>

<img src=\"modelica://ModelicaReference/Resources/Images/cosh.png\" alt=\"cosh\">

<h4>Examples</h4>
<pre><b>cosh</b>(1)
  = 1.54308063481524</pre>
</html>"));
  end 'cosh()';

class 'cross()' "cross()"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Return cross product of two vectors
</p>
<h4>Syntax</h4>
<blockquote><pre><b>cross</b>(x, y)</pre></blockquote>
<h4>Description</h4>
<p>
Returns the cross product of the 3-vectors x and y, i.e.
</p>
<blockquote><pre>
<b>cross</b>(x,y) = <b>vector</b>( [ x[2]*y[3]-x[3]*y[2];
                       x[3]*y[1]-x[1]*y[3];
                       x[1]*y[2]-x[2]*y[1] ] );
</pre></blockquote>
</html>"));
end 'cross()';

  class 'delay()' "delay()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Delay expression
</p>
<h4>Syntax</h4>
<blockquote><pre><b>delay</b>(expr, delayTime, delayMax)
<b>delay</b>(expr, delayTime)</pre></blockquote>
<h4>Description</h4>
<P>Returns <CODE>\"expr(time - delayTime)\"</CODE> for <CODE>time &gt; time.start + delayTime</CODE>
and <CODE>\"expr(time.start)\"</CODE> for <CODE>time &le; time.start + delayTime</CODE>. The
arguments, i.e., <code>expr</code>, <code>delayTime</code> and <code>delayMax</code>, need to be subtypes of Real.
<CODE>delayMax</CODE> needs to be additionally a parameter expression. The following relation
shall hold: <CODE>0 &le; delayTime &le; delayMax</code>, otherwise an error occurs. If
<code>delayMax</code> is not supplied in the argument list, <code>delayTime</code> need to be a
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
<h4>Examples</h4>
<pre><b>model</b> Delay
  Real x;
  Real y;
<b>equation
  der</b>(x) = 2;
  y = <b>delay</b>(x, 1);
<b>end</b> Delay;</pre>

<img src=\"modelica://ModelicaReference/Resources/Images/delay.png\" width=\"400\" height=\"280\" alt=\"Simulation result\">
</html>"));
  end 'delay()';

  class 'der()' "der()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Time derivative of expression or<br>
partial derivative of function
</p>

<h4>Syntax</h4>

<blockquote><pre><b>der</b>(expr) or
IDENT \"=\" <b>der</b> \"(\" name \",\" IDENT { \",\" IDENT } \")\" comment</pre>
</blockquote>

<h4>Description</h4>
<p>
The first form is the time derivative of expression expr.
If the expression expr is a scalar it needs to be a subtype of Real. The expression and all its subexpressions must be differentiable. If expr is an array, the operator is applied to all elements of the array. For Real parameters and
constants the result is a zero scalar or array of the same size as the
variable.</p>

<p>
The second form is the partial derivative of a function
and may only be used as declarations of functions.
The semantics is that a function [and only a function] can be specified in this form, defining that it is the partial derivative of the function to the right of the equal sign (looked up in the same way as a short class definition - the looked up name must be a function), and partially differentiated with respect to each IDENT in order (starting from the first one). The IDENT must be Real inputs to the function.
The comment allows a user to comment the function (in the info-layer and as one-line description, and as icon).
</p>

<h4>Examples</h4>

<blockquote>
<pre>  Real x, xdot1, xdot2;
<b>equation</b>
  xdot1 = <b>der</b>(x);
  xdot2 = <b>der</b>(x*sin(x));
</pre>
</blockquote>

<p>
The specific enthalphy can be computed from a Gibbs-function as follows:
</p>

<blockquote>
<pre><b>function</b> Gibbs
  <b>input</b> Real p,T;
  <b>output</b> Real g;
<b>algorithm</b>
  ...
<b>end</b> Gibbs;

<b>function</b> Gibbs_T=<b>der</b>(Gibbs, T);

<b>function</b> specificEnthalpy
  <b>input</b> Real p,T;
  <b>output</b> Real h;
<b>algorithm</b>
  h:=Gibbs(p,T)-T*Gibbs_T(p,T);
<b>end</b> specificEnthalpy;
</pre>
</blockquote>
</html>"));
  end 'der()';

class 'diagonal()' "diagonal()"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Returns a diagonal matrix
</p>
<h4>Syntax</h4>
<blockquote><pre><b>diagonal</b>(v)</pre></blockquote>
<h4>Description</h4>
<p>
Returns a square matrix with the elements of vector v
on the diagonal and all other elements zero.
</p>
</html>"));
end 'diagonal()';

  class 'div()' "div()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Integer part of division of two Real numbers
</p>
<h4>Syntax</h4>
<blockquote><pre><b>div</b>(x, y)</pre></blockquote>
<h4>Description</h4>
<P>Returns the algebraic quotient <CODE>x/y</CODE> with any
fractional part discarded (also known as truncation
toward zero). <I>[Note: this is defined for / in C99;
in C89 the result for negative numbers is
implementation-defined, so the standard function
<CODE>div()</CODE> must be used.]</I> Result and arguments
shall have type Real or Integer. If either of the
arguments is Real the result is Real otherwise Integer.</P>

<p><i>[Note, outside of a when clause state events are triggered
when the return value changes discontinuously.]</i></p>

<h4>Examples</h4>
<pre><b>div</b>(13,6)
 = 2</pre>
</html>"));
  end 'div()';

  class 'edge()' "edge()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Indicate rising edge
</p>
<h4>Syntax</h4>
<blockquote><pre><b>edge</b>(b)</pre></blockquote>
<h4>Description</h4>
<P>Is expanded into &quot;(b <B>and not pre</B>(b))&quot;
for Boolean variable b. The same restrictions as for the
<B>pre</B> operator apply (e.g., not to be used in function
classes).</P>
<h4>Examples</h4>
<pre><b>model</b> RisingEdge
  Boolean u;
  Integer i;
<b>equation</b>
  u = Modelica.Math.sin(<b>time</b>) &gt; 0.5;
  <b>when</b> <b>edge</b>(u) <b>then</b>
    i = <b>pre</b>(i) + 1;
  <b>end when</b>;
<b>end</b> RisingEdge;</pre>

<img src=\"modelica://ModelicaReference/Resources/Images/edge.png\" width=\"400\" height=\"280\" alt=\"Simulation result\">
</html>"));
  end 'edge()';

  class 'exp()' "exp()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Exponential, base e.
</p>
<h4>Syntax</h4>
<blockquote><pre><b>exp</b>(u)</pre></blockquote>
<h4>Description</h4>
<p>Returns the base e exponential of u, with -&infin; &lt; u &lt; &infin;
Argument u needs to be an Integer or Real expression.</p>

<p>
The exponential function can also be accessed as Modelica.Math.exp.
</p>

<img src=\"modelica://ModelicaReference/Resources/Images/exp.png\" alt=\"exp\">

<h4>Examples</h4>
<pre><b>exp</b>(1)
 = 2.71828182845905</pre>
</html>"));
  end 'exp()';

class 'fill()' "fill()"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Return a Real, Integer, Boolean or String array with all elements equal
</p>
<h4>Syntax</h4>
<blockquote><pre><b>fill</b>(s, n1, n2, n3, ...)</pre></blockquote>
<h4>Description</h4>
<p>
Returns the n1 x n2 x n3 x ... array with all elements equal
to scalar or array expression s (ni >= 0). The returned
array has the same type as s. Recursive definition:
<p>
<blockquote><pre>
fill(s,n1,n2,n3, ...) = fill(fill(s,n2,n3, ...), n1);
fill(s,n) = {s,s,..., s}
</pre></blockquote>
<h4>Examples</h4>
<blockquote><pre>
Real    mr[2,2] = fill(-1,2,2);  // = [-1,-1;-1,-1]
Boolean vb[3]   = fill(true,3);  // = {true, true, true}
</pre></blockquote>
</html>"));
end 'fill()';

  class 'floor()' "floor()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Round Real number towards minus infinity
</p>
<h4>Syntax</h4>
<blockquote><pre><b>floor</b>(x)</pre></blockquote>
<h4>Description</h4>
<p>Returns the largest integer not greater than <code>x</code>.
Result and argument shall have type Real. <i>[Note, outside
of a when clause state events are triggered when the return
value changes discontinuously.]</i></p>
<h4>Examples</h4>
<pre><b>floor</b>({-3.14, 3.14})
 = {-4.0, 3.0}</pre>
</html>"));
  end 'floor()';

class 'identity()' "identity()"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Returns the identity matrix of the desired size
</p>
<h4>Syntax</h4>
<blockquote><pre><b>identity</b>(n)</pre></blockquote>
<h4>Description</h4>
<p>
Returns the n x n Integer identity matrix, with ones
on the diagonal and zeros at the other places.
</p>
</html>"));
end 'identity()';

  class 'initial()' "initial()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
True during initialization
</p>
<h4>Syntax</h4>
<blockquote><pre><b>initial</b>()</pre></blockquote>
<h4>Description</h4>
<p>Returns <b>true</b> during the initialization phase and <b>false</b> otherwise.</p>
<h4>Examples</h4>
<pre>  Boolean off;
  Real x;
<b>equation</b>
  off = x &lt; -2 or <b>initial</b>();</pre>
</html>"));
  end 'initial()';

  class 'inStream()' "inStream()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Returns the mixing value of a stream variable if it flows into the component where the inStream operator
is used.
</p>

<p>
For an introduction into stream variables and an example for the inStream(..) operator, see
<a href=\"modelica://ModelicaReference.Stream\">stream</a>.
</p>

<h4>Syntax</h4>

<blockquote><pre><b>inStream</b>(IDENT) </pre>
</blockquote>

<p>
where IDENT must be a variable reference in a connector component declared with the
<a href=\"modelica://ModelicaReference.Stream\">stream</a> prefix.
</p>

<h4>Description</h4>

<p>
In combination with the stream variables of a connector, the inStream() operator
is designed to describe in a numerically reliable way the bi-directional
transport of specific quantities carried by a flow of matter. inStream(v) is
only allowed on stream variables v and is informally the value the stream
variable has, assuming that the flow is from the connection point into the
component. This value is computed from the stream connection equations of the
flow variables and of the stream variables. For the following definition it is
assumed that N inside connectors mj.c (j=1,2,...,N) and M outside connectors
ck(k=1,2,...,M) belonging to the same connection set
are connected together and a stream variable h_outflow is associated with
a flow variable m_flow in connector c.
</p>

<blockquote>
<pre><b>connector</b> FluidPort
   ...
   <b>flow</b>   Real m_flow     \"Flow of matter; m_flow &gt; 0 if flow into component\";
   <b>stream</b> Real h_outflow  \"Specific variable in component if m_flow &lt; 0\"
<b>end</b> FluidPort;

<b>model</b> FluidSystem
   ...
   FluidComponent m1, m2, ..., mN;
   FluidPort      c1, c2, ..., cM;
<b>equation</b>
   <b>connect</b>(m1.c, m2.c);
   <b>connect</b>(m1.c, m3.c);
      ...
   <b>connect</b>(m1.c, mN.c);
   <b>connect</b>(m1.c, c1);
   <b>connect</b>(m1.c, c2);
      ...
   <b>connect</b>(m1.c, cM);
   ...
<b>end</b> FluidSystem;
</pre>
</blockquote>

<p>
With these prerequisites, the semantics of the expression
</p>

<blockquote>
<pre><b>inStream</b>(m<sub>i</sub>.c.h_outflow)
</pre>
</blockquote>

<p>
is given implicitly by defining an additional variable <b>h_mix_in</b><sub>i</sub>,
and by adding to the model the conservation equations for mass and energy corresponding
to the infinitesimally small volume spanning the connection set. The connect equation
for the flow variables has already been added to the system according to the connection
semantics of flow variables:
</p>

<blockquote>
<pre>// Standard connection equation for flow variables
0 = <b>sum</b>(m<sub>j</sub>.c.m_flow <b>for</b> j <b>in</b> 1:N) + <b>sum</b>(-c<sub>k</sub>.m_flow <b>for</b> k in 1:M);
</pre></blockquote>

<p>
Whenever the inStream() operator is applied to a stream variable of an
inside connector, the balance equation of the transported property must
be added  under the assumption of flow going into the connector
</p>

<blockquote>
<pre>// Implicit definition of the inStream() operator applied to inside connector i
0 = <b>sum</b>(m<sub>j</sub>.c.m_flow*(<b>if</b> m<sub>j</sub>.c.m_flow > 0 <b>or</b> j==i <b>then</b> h_mix_in<sub>i</sub> <b>else</b> m<sub>j</sub>.c.h_outflow) <b>for</b> j <b>in</b> 1:N) +
    <b>sum</b>(-c<sub>k</sub>.m_flow* (<b>if</b> c<sub>k</sub>.m_flow > 0 <b>then</b> h_mix_in<sub>i</sub> <b>else</b> inStream(c<sub>k</sub>.h_outflow) <b>for</b> k <b>in</b> 1:M);
<b>inStream</b>(m<sub>i</sub>.c.h_outflow) = h_mix_in<sub>i</sub>;
</pre>
</blockquote>

<p>
Note that the result of the inStream(m<sub>i</sub>.c.h_outflow) operator is different for each port i,
because the assumption of flow entering the port is different for each of them.
Additional equations need to be generated for the stream variables of outside connectors.
</p>

<blockquote>
<pre>// Additional connection equations for outside connectors
<b>for</b> q in 1:M <b>loop</b>
  0 = <b>sum</b>(m<sub>j</sub>.c.m_flow*(<b>if</b> m<sub>j</sub>.c.m_flow > 0 <b>then</b> h_mix_out<sub>q</sub> <b>else</b> m<sub>j</sub>.c.h_outflow) <b>for</b> j <b>in</b> 1:N) +
      <b>sum</b>(-c<sub>k</sub>.m_flow* (<b>if</b> c<sub>k</sub>.m_flow > 0 <b>or</b> k==q <b>then</b> h_mix_out<sub>q</sub> <b>else</b> <b>inStream</b>(c<sub>k</sub>.h_outflow)
          <b>for</b> k <b>in</b> 1:M);
  c<sub>q</sub>.h_outflow = h_mix_out<sub>q</sub>;
<b>end for</b>;
</pre></blockquote>

<p>
Neglecting zero flow conditions, the above implicit equations can be
analytically solved for the inStream(..) operators.
The details are given in Section 15.2 of the
<a href=\"http://www.modelica.org/documents/ModelicaSpec32.pdf\">Modelica Language Specification version 3.2</a>.
The stream connection equations have singularities and/or multiple solutions if one or more
of the flow variables become zero. When all the flows are zero, a singularity is always
present, so it is necessary to approximate the solution in an open neighbourhood
of that point. [<i>For example assume that m<sub>j</sub>.c.m_flow = c<sub>k</sub>.m_flow = 0,
then all equations above are identically fulfilled and inStream(..) can have any value</i>].
It is required that the inStream() operator is appropriately approximated in that case
and the approximation must fulfill the following requirements:
</p>

<ol>
<li> inStream(m<sub>i</sub>.c.h_outflow) and inStream(c<sub>k</sub>.h_outflow)
     must be <b>unique</b> with respect to all values of the flow and stream
     variables in the connection set, and must have a continuous dependency on them.<br>&nbsp;</li>
<li> Every solution of the implicit equation system above must fulfill the equation
     system identically [<i>upto the usual numerical accuracy</i>],
     provided the absolute value of every flow variable in the connection set is
     greater as a small value (|m<sub>1</sub>.c.m_flow| &gt; eps and |m<sub>2</sub>.c.m_flow| &gt; eps
     and ... and |c<sub>M</sub>.m_flow| &gt; eps).</li>
</ol>

<p>
In Section 15.2 a recommended implementation of the solution of the implicit equation system is
given, that fulfills the above requirements.
</p>

</html>"));
  end 'inStream()';

  class 'Integer()' "Integer()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Returns ordinal number of enumeration
</p>
<h4>Syntax</h4>
<blockquote><pre><b>Integer</b>(E.e1)</pre></blockquote>
<h4>Description</h4>
<p>
Returns the ordinal number of the enumeration value E.enumvalue, where Integer(E.e1)=1, Integer(E.en)= size(E), for an enumeration type E=enumeration(e1, ...,  en).</p>

<h4>Examples</h4>
<pre>  <b>type</b> Size = enumeration(small, medium, large, xlarge);
  <b>Integer</b>(Size.large) = 3</pre>

</html>"));
  end 'Integer()';

  class 'integer()' "integer()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Round Real number towards minus infinity
</p>
<h4>Syntax</h4>
<blockquote><pre><b>integer</b>(x)</pre></blockquote>
<h4>Description</h4>
<p>Returns the largest integer not greater than <code>x</code>.
The argument shall have type Real. The result has type Integer.</p>
<p><i>[Note, outside of a when clause state events are triggered
when the return value changes discontinuously.]</i></p>
<h4>Examples</h4>
<pre><b>integer</b>({-3.14, 3.14})
 = {-4, 3}</pre>
</html>"));
  end 'integer()';

  class 'inverse()' "inverse()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>Every function with one output argument may have one or more &quot;<code>inverse</code>&quot; annotations to define inverses of this function. </p>
<p><b><font style=\"color: #008000; \">Syntax</font></b> </p>
<blockquote>
<pre><b>function</b> f1
  <b>input</b> A1 u1;
  ...
  <b>input</b> T1 uk;
  ...
  <b>input</b> Am um = am;
  ...
  <b>input</b> An un;
  <b>output</b> T2 y;
  <b>annotation</b>(<b>inverse</b>(uk = f2(..., y, ....), ui = f3(..., y, ...), ...));
<b>algorithm</b>
  ...
<b>end</b> f1;</pre></blockquote>
<h4>Description</h4>
<p>The meaning is that function &quot;<code>f2</code>&quot; is one inverse to function &quot;<code>f1</code>&quot; where the previous output &quot;<code>y</code>&quot; is now an input and the previous input &quot;<code>uk</code>&quot; is now an output. More than one inverse can be defined within the same inverse annotation. Several inverses are separated by commas. <em>(The inverse requires that for all valid values of the inputarguments of <code>f2(...,y, ...)</code> and <code>uk</code> being calculated as <code>uk := f2(..., y, ...)</code> implies the equality <code>y = f1(..., uk, ...,) </code>up to a certain precision.)</em></p>
<p>Function &quot;<code>f1</code>&quot; can have any number and types of arguments with and without default value. The restriction is that the number of unknown variables in the output argument of both &quot;<code>f1</code>&quot; and &quot;<code>f2</code>&quot; must be the same and that &quot;<code>f2</code>&quot; must have exactly the same arguments as &quot;<code>f1</code>&quot; (with the same defaults, if an argument um has a default), but the order of the arguments may be permuted.</p>
<h4><font style=\"color: #008000; \">Examples</font></h4>
<pre><b>function</b> h_pTX
  <b>input</b> Real p    &quot;pressure&quot;;
  <b>input</b> Real T    &quot;temperature&quot;;
  <b>input</b> Real X[:] &quot;mass fractions&quot;;
  <b>output</b> Real h   &quot;specific enthalpy&quot;;
  <b>annotation</b>(<b>inverse</b>(T = T_phX(p,h,X)));
<b>algorithm</b>
  ...
<b>end</b> h_pTX;

<b>function</b> T_phX
  <b>input</b> Real  p    &quot;pressure&quot;;
  <b>input</b> Real  h    &quot;specific enthalpy&quot;;
  <b>input</b> Real  X[:] &quot;mass fractions&quot;;
  <b>output</b> Real T    &quot;temperature&quot;;
<b>algorithm</b>
  ...
<b>end</b> T_phX;</pre>
</html>"));
  end 'inverse()';

class 'linspace()' "linspace()"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Return Real vector with equally spaced elements
</p>
<h4>Syntax</h4>
<blockquote><pre><b>linspace</b>(x1, x2, n)</pre></blockquote>
<h4>Description</h4>
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
<h4>Examples</h4>
<blockquote><pre>
Real v[:] = linspace(1,7,4);  // = {1, 3, 5, 7}
</pre></blockquote>
</html>"));
end 'linspace()';

  class 'log()' "log()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Natural (base e) logarithm
</p>
<h4>Syntax</h4>
<blockquote><pre><b>log</b>(u)</pre></blockquote>
<h4>Description</h4>
<p>Returns the base e logarithm of u, with u &gt; 0.
Argument u needs to be an Integer or Real expression.</p>

<p>
The natural logarithm can also be accessed as Modelica.Math.log.
</p>

<img src=\"modelica://ModelicaReference/Resources/Images/log.png\" alt=\"log\">

<h4>Examples</h4>
<pre><b>log</b>(1)
 = 0</pre>
</html>"));
  end 'log()';

  class 'log10()' "log10()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Base 10 logarithm
</p>
<h4>Syntax</h4>
<blockquote><pre><b>log10</b>(u)</pre></blockquote>
<h4>Description</h4>
<p>Returns the base 10 logarithm of u, with u &gt; 0.
Argument u needs to be an Integer or Real expression.</p>

<p>
The base 10 logarithm can also be accessed as Modelica.Math.log10.
</p>

<img src=\"modelica://ModelicaReference/Resources/Images/log10.png\" alt=\"log10\">

<h4>Examples</h4>
<pre><b>log10</b>(1)
 = 0</pre>
</html>"));
  end 'log10()';

class 'matrix()' "matrix()"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Returns the first two dimensions of an array as matrix
</p>
<h4>Syntax</h4>
<blockquote><pre><b>matrix</b>(A)</pre></blockquote>
<h4>Description</h4>
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
end 'matrix()';

class 'max()' "max()"
  extends ModelicaReference.Icons.Information;

  annotation (Documentation(info="<html>
<p>
Returns the largest element
</p>
<h4>Syntax</h4>
<blockquote><pre>
<b>max</b>(A)
<b>max</b>(x,y)
<b>max</b>(e(i, ..., j) <b>for</b> i <b>in</b> u, ..., j <b>in</b> v)
</pre></blockquote>
<h4>Description</h4>
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
<h4>Examples</h4>
<blockquote><pre>
<b>max</b>(i^2 <b>for</b> i <b>in</b> {3,7,6})  // = 49
</pre></blockquote>
</html>"));
end 'max()';

class 'min()' "min()"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Returns the smallest element
</p>
<h4>Syntax</h4>
<blockquote><pre>
<b>min</b>(A)
<b>min</b>(x,y)
<b>min</b>(e(i, ..., j) <b>for</b> i <b>in</b> u, ..., j <b>in</b> v)
</pre></blockquote>
<h4>Description</h4>
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
<h4>Examples</h4>
<blockquote><pre>
<b>min</b>(i^2 <b>for</b> i <b>in</b> {3,7,6})  // = 9
</pre></blockquote>
</html>"));
end 'min()';

  class 'mod()' "mod()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Integer modulus of a division of two Real numbers
</p>
<h4>Syntax</h4>
<blockquote><pre><b>mod</b>(x, y)</pre></blockquote>
<h4>Description</h4>
<P>Returns the integer modulus of <CODE>x/y</CODE>, i.e., mod(x, y) = x - floor(x/y)*y.
Result and arguments shall have type Real or Integer. If either of the
arguments is Real the result is Real otherwise Integer. <I>[Note, outside of
a when clause state events are triggered when the return value changes
discontinuously.]</I></P>
<h4>Examples</h4>
<pre><b>mod</b>(3,1.4)
 = 0.2
<b>mod</b>(-3,1.4)
 = 1.2
<b>mod</b>(3,-1.4)
 = -1.2</pre>
</html>"));
  end 'mod()';

class 'ndims()' "ndims()"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Return number of array dimensions
</p>
<h4>Syntax</h4>
<blockquote><pre><b>ndims</b>(A)</pre></blockquote>
<h4>Description</h4>
<p>
Returns the number of dimensions k of array expression
A, with k >= 0.
</p>
<h4>Examples</h4>
<blockquote><pre>
Real A[8,4,5];
Integer n = ndims(A);  // = 3
</pre></blockquote>
</html>"));
end 'ndims()';

  class 'noEvent()' "noEvent()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Turn off event triggering
</p>
<h4>Syntax</h4>
<blockquote><pre><b>noEvent</b>(expr)</pre></blockquote>
<h4>Description</h4>
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
<h4>Examples</h4>
<pre>der(h)=<B>if noEvent</B>(h&gt;0) <B>then</B> -c*sqrt(h) <B>else</B> 0;</pre>
</html>"));
  end 'noEvent()';

class 'ones()' "ones()"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Returns an array with \"1\" elements
</p>
<h4>Syntax</h4>
<blockquote><pre><b>ones</b>(n1, n2, n3, ...)</pre></blockquote>
<h4>Description</h4>
<p>
Return the n1 x n2 x n3 x ... Integer array with all
elements equal to one (ni >=0 ).
</p>
</html>"));
end 'ones()';

class 'outerProduct()' "outerProduct()"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Returns the outer product of two vectors
</p>
<h4>Syntax</h4>
<blockquote><pre><b>outerProduct</b>(v1,v2)</pre></blockquote>
<h4>Description</h4>
<p>
Returns the outer product of vectors v1 and v2 <br>
(= matrix(v)*transpose( matrix(v) ) ).
</p>
</html>"));
end 'outerProduct()';

  class 'pre()' "pre()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Refer to left limit
</p>
<h4>Syntax</h4>
<blockquote><pre><b>pre</b>(y)</pre></blockquote>
<h4>Description</h4>
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
<h4>Examples</h4>
<pre><b>model</b> Hysteresis
  Real u;
  Boolean y;
<b>equation</b>
  u = Modelica.Math.sin(<b>time</b>);
  y = u &gt; 0.5 or <b>pre</b>(y) and u &gt;= -0.5;
<b>end</b> Hysteresis;</pre>

<img src=\"modelica://ModelicaReference/Resources/Images/pre.png\" width=\"400\" height=\"280\" alt=\"Simulation result\">
</html>"));
  end 'pre()';

class 'product()' "product()"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Returns the scalar product
</p>
<h4>Syntax</h4>
<blockquote><pre>
<b>product</b>(A)
<b>product</b>(e(i, ..., j) <b>for</b> i <b>in</b> u, ..., j <b>in</b> v)
</pre></blockquote>
<h4>Description</h4>
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
<h4>Examples</h4>
<blockquote><pre>
{<b>product</b>(j <b>for</b> j <b>in</b> 1:i) <b>for</b> i <b>in</b> 0:4} // = {1,1,2,6,24}
</pre></blockquote>
</html>"));
end 'product()';

  class 'reinit()' "reinit()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Reinitialize state variable
</p>
<h4>Examples</h4>
<h4>Syntax</h4>
<blockquote><pre><b>reinit</b>(x, expr)</pre></blockquote>
<h4>Description</h4>
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
  end 'reinit()';

  class 'rem()' "rem()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Integer remainder of the division of two Real numbers
</p>
<h4>Syntax</h4>
<blockquote><pre><b>rem</b>(x, y)</pre></blockquote>
<h4>Description</h4>
<P>Returns the integer remainder of <CODE>x/y</CODE>,
such that <CODE>div(x,y) * y + rem(x, y) = x</CODE>.
Result and arguments shall have type Real or
Integer. If either of the arguments is Real the
result is Real otherwise Integer. <I>[Note, outside
of a when clause state events are triggered when
the return value changes discontinuously.]</I></P>
<h4>Examples</h4>
<pre><b>rem</b>(3,1.4)
 = 0.2
<b>rem</b>(-3,1.4)
 = -0.2
<b>rem</b>(3,-1.4)
 = 0.2</pre>
</html>"));
  end 'rem()';

  class 'sample()' "sample()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Trigger time events
</p>
<h4>Syntax</h4>
<blockquote><pre><b>sample</b>(start, interval)</pre></blockquote>
<h4>Description</h4>
<P>Returns true and triggers time events at time instants
<CODE>&quot;start + i*interval&quot; (i=0, 1, ...)</CODE>.
During continuous integration the operator returns always
false. The starting time &quot;start&quot; and the sample
interval &quot;interval&quot; need to be parameter
expressions and need to be a subtype of Real or Integer.
</P>
<h4>Examples</h4>
<pre><b>model</b> Sampling
  Integer i;
<b>equation</b>
  <b>when</b> <b>sample</b>(1, 0.1) <b>then</b>
    i = <b>pre</b>(i) + 1;
  <b>end when</b>;
<b>end</b> Sampling;</pre>

<img src=\"modelica://ModelicaReference/Resources/Images/sample.png\" width=\"400\" height=\"280\" alt=\"Simulation result\">
</html>"));
  end 'sample()';

class 'scalar()' "scalar()"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Returns a one-element array as scalar
</p>
<h4>Syntax</h4>
<blockquote><pre><b>scalar</b>(A)</pre></blockquote>
<h4>Description</h4>
<p>
Returns the single element of array A.
<b>size</b>(A,i) = 1 is required for 1 &le; i &le; <b>ndims</b>(A).
</p>
<h4>Examples</h4>
<blockquote><pre>
Real A[1,1,1] = {{{3}}};
Real e = scalar(A);  // = 3
</pre></blockquote>
</html>"));
end 'scalar()';

  class 'semiLinear()' "semiLinear()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Returns \"if x >= 0 then positiveSlope*x else negativeSlope*x\" and handle x=0 in a meaningful way
</p>
<h4>Syntax</h4>
<blockquote><pre><b>semiLinear</b>(x, positiveSlope, negativeSlope)</pre></blockquote>
<h4>Description</h4>
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
  end 'semiLinear()';

  class 'sign()' "sign()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Signum function of a Real or Integer number
</p>
<h4>Syntax</h4>
<blockquote><pre><b>sign</b>(v)</pre></blockquote>
<h4>Description</h4>
<p>Is expanded into &quot;noEvent(<b>if</b> v &gt; 0 <b>then</b> 1 <b>else
if</b> v &lt; 0 <b>then</b> -1 <b>else</b> 0)&quot;. Argument v
needs to be an Integer or Real expression. <i>[Note, outside of a
when clause state events are triggered.]</i></p>
<h4>Examples</h4>
<pre><b>sign</b>({-3, 0, 3})
 = {-1, 0, 1}</pre>
</html>"));
  end 'sign()';

  class 'sin()' "sin()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Trigonometric sine function
</p>
<h4>Syntax</h4>
<blockquote><pre><b>sin</b>(u)</pre></blockquote>
<h4>Description</h4>
<p>Returns the sine of u, with -&infin; &lt; u &lt; &infin;.
Argument u needs to be an Integer or Real expression.</p>

<p>
The sine function can also be accessed as Modelica.Math.sin.
</p>

<img src=\"modelica://ModelicaReference/Resources/Images/sin.png\" alt=\"sin\">

<h4>Examples</h4>
<pre><b>sin</b>(3.14159265358979)
 = 0.0</pre>
</html>"));
  end 'sin()';

  class 'sinh()' "sinh()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Hyberbolic sine function
</p>
<h4>Syntax</h4>
<blockquote><pre><b>sinh</b>(u)</pre></blockquote>
<h4>Description</h4>
<p>Returns the sinh of u, with -&infin; &lt; u &lt; &infin;.
Argument u needs to be an Integer or Real expression.</p>

<p>
The sinh function can also be accessed as Modelica.Math.sinh.
</p>

<img src=\"modelica://ModelicaReference/Resources/Images/sinh.png\" alt=\"sinh\">

<h4>Examples</h4>
<pre><b>sinh</b>(1)
  = 1.1752011936438</pre>
</html>"));
  end 'sinh()';

class 'size()' "size()"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Returns dimensions of an array
</p>
<h4>Syntax</h4>
<blockquote><pre>
   <b>size</b>(A,i)
   <b>size</b>(A)
</pre></blockquote>
<h4>Description</h4>
<p>
The first form returns the size of dimension i of array expression A
where i shall be &gt; 0 and &le; <b>ndims</b>(A).
</p>
<p>
The second form returns a vector of length <b>ndims</b>(A)
containing the dimension sizes of A.
</p>
<h4>Examples</h4>
<blockquote><pre>
Real A[8,4,5];
Integer n3   = size(A,3);  // = 5
Integer n[:] = size(A);    // = {8,4,5}
</pre></blockquote>
</html>"));
end 'size()';

class 'skew()' "skew()"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Returns the skew matrix that is associated with a vector
</p>
<h4>Syntax</h4>
<blockquote><pre><b>skew</b>(x)</pre></blockquote>
<h4>Description</h4>
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
end 'skew()';

  class 'smooth()' "smooth()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Indicate smoothness of expression
</p>
<h4>Syntax</h4>
<blockquote><pre><b>smooth</b>(p, expr)</pre></blockquote>
<h4>Description</h4>
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
<h4>Examples</h4>
<PRE>  Real x, y, z;
<B>equation</B>
  x = <B>if</B> time&lt;1 <B>then</B> 2 <B>else</B> time-2;
  z = smooth(0, <B>if</B> time&lt;0 <B>then</B> 0 <B>else</B> time);
  y = smooth(1, noEvent(<B>if</B> x&lt;0 <B>then</B> 0 <B>else</B> sqrt(x)*x));
  // noEvent is necessary.</PRE>
</html>"));
  end 'smooth()';

  class 'sqrt()' "sqrt()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Square root
</p>
<h4>Syntax</h4>
<blockquote><pre><b>sqrt</b>(v)</pre></blockquote>
<h4>Description</h4>
<p>Returns the square root of v if v&gt;=0, otherwise an error occurs.
Argument v needs to be an Integer or Real expression.</p>
<h4>Examples</h4>
<pre><b>sqrt</b>(9)
 = 3.0</pre>
</html>"));
  end 'sqrt()';

  class 'String()' "String()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Convert a scalar Real, Integer or Boolean expression to a String representation
</p>
<h4>Syntax</h4>
<blockquote>
<pre>
<b>String</b>(b_expr, minimumLength=0, leftJustified=true)
<b>String</b>(i_expr, minimumLength=0, leftJustified=true)
<b>String</b>(r_expr, significantDigits=6, minimumLength=0, leftJustified=true)
<b>String</b>(r_expr, format)
<b>String</b>(e_expr, minimumLength=0, leftJustified=true)
</pre>
</blockquote>
<h4>Description</h4>
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
       (e.g., \"12.3456\", \"0.0123456\", \"12345600\", \"1.23456E-10\")</td></tr>
<tr>
  <td> String format </td>
  <td> defines the string formating according to ANSI-C without \"%\" and \"*\" character<br>
       (e.g., \".6g\", \"14.5e\", \"+6f\"). In particular:<br>
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
<h4>Examples</h4>
<blockquote>
<pre>
String(2.0)   // = \"2.0\"
String(true)  // = \"true\"
String(123, minimumLength=6, leftJustified=false)  // = \"   123\"
</pre>
</blockquote>
</html>"));
  end 'String()';

class 'sum()' "sum()"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Returns the scalar sum
</p>
<h4>Syntax</h4>
<blockquote><pre>
<b>sum</b>(A)
<b>sum</b>(e(i, ..., j) <b>for</b> i <b>in</b> u, ..., j <b>in</b> v)
</pre></blockquote>
<h4>Description</h4>
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
<h4>Examples</h4>
<blockquote><pre>
<b>sum</b>(i <b>for</b> i <b>in</b> 1:10)  // Gives  1+2+...+10=55
   // Read it as: compute the sum of i for i in the range 1 to 10.
</pre></blockquote>
</html>"));
end 'sum()';

class 'symmetric()' "symmetric()"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Returns a symmetric matrix
</p>
<h4>Syntax</h4>
<blockquote><pre><b>symmetric</b>(A)</pre></blockquote>
<h4>Description</h4>
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
end 'symmetric()';

  class 'tan()' "tan()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Trigonometric tangent function
</p>
<h4>Syntax</h4>
<blockquote><pre><b>tan</b>(u)</pre></blockquote>
<h4>Description</h4>
<p>Returns the tangent of u, with -&infin; &lt; u &lt; &infin;
(if u is a multiple of (2n-1)*pi/2, y = tan(u) is +/- infinity).
Argument u needs to be an Integer or Real expression.</p>

<p>
The tangent function can also be accessed as Modelica.Math.tan.
</p>

<img src=\"modelica://ModelicaReference/Resources/Images/tan.png\" alt=\"tan\">

<h4>Examples</h4>
<pre><b>tan</b>(3.14159265358979)
 = 0.0
</pre>
</html>"));
  end 'tan()';

  class 'tanh()' "tanh()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Hyberbolic tangent function
</p>
<h4>Syntax</h4>
<blockquote><pre><b>tanh</b>(u)</pre></blockquote>
<h4>Description</h4>
<p>Returns the tanh of u, with -&infin; &lt; u &lt; &infin;.
Argument u needs to be an Integer or Real expression.</p>

<p>
The tanh function can also be accessed as Modelica.Math.tanh.
</p>

<img src=\"modelica://ModelicaReference/Resources/Images/tanh.png\" alt=\"tanh\">

<h4>Examples</h4>
<pre><b>tanh</b>(1)
  = 0.761594155955765</pre>
</html>"));
  end 'tanh()';

  class 'terminal()' "terminal()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
True after successful analysis
</p>
<h4>Syntax</h4>
<blockquote><pre><b>terminal</b>()</pre></blockquote>
<h4>Description</h4>
<p>Returns <b>true</b> at the end of a successful analysis.</p>
<h4>Examples</h4>
<pre>  Boolean a, b;
<b>equation</b>
  a = <b>change</b>(b) or <b>terminal</b>();</pre>
</html>"));
  end 'terminal()';

  class 'terminate()' "terminate()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Successfully terminate current analysis
</p>
<h4>Syntax</h4>
<blockquote><pre><b>terminate</b>(message)</pre></blockquote>
<h4>Description</h4>
<P>The terminate function successfully terminates the analysis
which was carried out. The function has a string argument
indicating the reason for the success. <I>[The intention is to
give more complex stopping criteria than a fixed point in time.]</I></P>
<h4>Examples</h4>
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
  end 'terminate()';

class 'transpose()' "transpose()"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Transpose of a matrix or permutation of the first two dimensions of an array
</p>
<h4>Syntax</h4>
<blockquote><pre><b>transpose</b>(A)</pre></blockquote>
<h4>Description</h4>
<p>
Permutes the first two dimensions of array A.
It is an error, if array A does not have at least
2 dimensions.
</p>
</html>"));
end 'transpose()';

class 'vector()' "vector()"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Returns an array with one non-singleton dimension as vector
</p>
<h4>Syntax</h4>
<blockquote><pre><b>vector</b>(A)</pre></blockquote>
<h4>Description</h4>
<p>
Returns a 1-vector, if A is a scalar and otherwise returns a vector containing all the elements of the array, provided there is at
most one dimension size > 1.
</p>
<h4>Examples</h4>
<blockquote><pre>
Real A[1,2,1] = {{{3},{4}}};
Real v[2] = vector(A);  // = {3,4}
</pre></blockquote>
</html>"));
end 'vector()';

class 'zeros()' "zeros()"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Returns a zero array.
</p>
<h4>Syntax</h4>
<blockquote><pre><b>zeros</b>(n1, n2, n3, ...)</pre></blockquote>
<h4>Description</h4>
<p>
Returns the n1 x n2 x n3 x ... Integer array with all
elements equal to zero (ni >= 0).
</p>
</html>"));
end 'zeros()';
  annotation (Documentation(info="<html>
<p>
In this chapter <b>operators</b> of Modelica are documented.
Elementary operators, such as \"+\" or \"-\" are overloaded and
operate on scalar and array variables. Other operators
have the same syntax as a
<a href=\"modelica://ModelicaReference.Classes.Function\">Modelica function</a>
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
end Operators;


class BalancedModel "Balanced model"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
The basic concept to count unknowns and equations.
</p>

<p>
Restrictions for model and block classes are present, in order that missing
or too many equations can be detected and localized by a Modelica
translator before using the respective model or block class.
</p>

<h4>Examples</h4>

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

<h4>Description</h4>

<p>
The restrictions below apply after flattening \" i.e., inherited components are included \" possibly modified.
</p>

<p>
<b>Definition 1: Local Number of Unknowns</b>
</p>

<p>
The local number of unknowns of a model or block class is the sum based on the components:
</p>

<ul>
<li> For each declared component of specialized class type (Real, Integer, String, Boolean, enumeration and arrays of those, etc.) or record, not declared as outer, it is the \"number of unknown variables\" inside it (i.e., excluding parameters and constants and counting the elements after expanding all records and arrays to a set of scalars of primitive types). </li>

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
<li>The number of equations defined locally (i.e., not in any model or block component), including binding equations, and equations generated from connect-equations. This includes the proper count for when-clauses, and algorithms, and is also used for the flat Hybrid DAE formulation.</li>

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
A model or block class is \"locally balanced\" if the \"local number of unknowns\" is identical to the \"local equation size\" for all legal values of constants and parameters [respecting final bindings and min/max-restrictions. A tool shall verify the \"locally balanced\" property for the actual values of parameters and constants in the simulation model. It is a quality of implementation  for a tool to verify this property in general, due to arrays of (locally) undefined sizes, conditional declarations, for loops, etc.].
</p>

<p>
<b>Definition 4: Globally Balanced</b>
</p>

<p>
Similarly as locally balanced, but including all unknowns and equations from all components. The global number of unknowns is computed by expanding all unknowns (i.e., excluding parameters and constants) into a set of scalars of primitive types. This should match the global equation size defined as:
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
<li>In a non-partial model or block, all non-connector inputs of model or block components must have binding equations. [E.g., if the model contains a component, firstOrder (of specialized class model) and firstOrder has  \"input Real u\" then there must be a binding equation for firstOrder.u.] </li>
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
These are 5 equations in 5 unknowns (locally balanced model). A more detailed analysis would reveal that this is structurally non-singular, i.e., that the hybrid DAE will not contain a singularity independent of actual values.
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


class 'connect()' "connect()"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Connect objects
</p>
<h4>Examples</h4>

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

<h4>Syntax</h4>

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

<h4>Description</h4>

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
end 'connect()';


class 'encapsulated' "encapsulated"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Break lookup in hierarchy
</p>
<h4>Examples</h4>

<pre><b>encapsulated model</b> Test
  <b>import</b> Modelica.Mechanics.Rotational;

  Rotational.Components.Inertia inertia; // lookup successful
  Modelica.Mechanics.Translational.SlidingMass slidingMass; // lookup fails
<b>equation</b>
  ...
<b>end</b> Test;</pre>

<h4>Syntax</h4>

<PRE>class_definition :
   [ <B>encapsulated</B> ]
   [ <B>partial</B> ]
   ( <B>class</B> | <B>model</B> | <B>record</B> | <B>block</B> | <B>connector</B> | <B>type</B> |
     <B>package</B> | <b>function</B> )
   IDENT class_specifier</PRE>

<h4>Description</h4>

<p>When an element, equation or algorithm is instantiated, any name is
looked up sequentially in each member of the ordered set of parents
until a match is found or a parent is encapsulated. In the latter case
the lookup stops except for the predefined types, functions and
operators defined in this specification. For these cases the lookup
continues in the global scope, where they are defined. <i>[E.g., abs is
searched upwards in the hierarchy as usual. If an encapsulated boundary
is reached, abs is searched in the global scope instead. The operator
abs cannot be redefined in the global scope, because an existing class
cannot be redefined at the same level.]</i></p>
</html>"));
end 'encapsulated';


class 'extends' "extends"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Inheritance from base class
</p>
<h4>Examples</h4>

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

<p>yields an instance with <CODE>bcomp.b=3</CODE>, which overrides <CODE>b=2</CODE>.</P>

<h4>Syntax</h4>

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

<h4>Description</h4>

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

<p>Since
specialized classes of different
kinds have different properties,
only specialized classes that are \"in some sense
compatible\" to
each other can be derived from each other via inheritance. The
following table
shows which kind of specialized class can be used in an extends clauses
of
another kind of specialized class:</p>

<table border=\"1\" cellpadding=\"1\" cellspacing=\"1\" >
<tr>
  <td></td><td colspan=7 align=center><b>Base Class</b></td>
</tr>
<tr>
  <td><b>Derived Class</b></td>
  <td>package</td>
  <td>function</td>
  <td>type</td>
  <td>record</td>
  <td>connector</td>
  <td>block</td>
  <td>model</td>
</tr>
<tr>
  <td>package</td>
  <td>yes</td>
  <td></td><td></td><td></td><td></td><td></td><td></td>
</tr>
<tr>
  <td>function</td>
  <td></td>
  <td>yes</td>
  <td></td><td></td><td></td><td></td><td></td>
</tr>
<tr>
  <td>type</td>
  <td></td>
  <td></td>
  <td>yes</td>
  <td></td><td></td><td></td><td></td>
</tr>
<tr>
  <td>record</td>
  <td></td>
  <td></td>
  <td></td>
  <td>yes</td>
  <td></td><td></td><td></td>
</tr>
<tr>
  <td>connector</td>
  <td></td>
  <td></td>
  <td>yes</td>
  <td>yes</td>
  <td>yes</td>
  <td></td><td></td>
</tr>
<tr>
  <td>block</td>
  <td></td>
  <td></td>
  <td></td>
  <td>yes</td>
  <td></td>
  <td>yes</td>
  <td></td>
</tr>
<tr>
  <td>model</td>
  <td></td>
  <td></td>
  <td></td>
  <td>yes</td>
  <td></td>
  <td>yes</td>
  <td>yes</td>
</tr>
</table>

<p>The specialized classes <code>package</code>,  <code>function</code>,  <code>type</code>, and  <code>record</code> can only be derived from their own kind <i>(e.g., a package can only be base class for packages. All other kinds of classes can use the import statement to use the contents of a package)</i>.</p>

</html>"));
end 'extends';


class 'flow' "flow"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Declare flow (through) variable, which have to sum up to zero in connections
</p>
<h4>Examples</h4>

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

<h4>Syntax</h4>

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
   [ <B>flow</b> | <B>stream</b> ]
   [ <B>discrete</B> | <B>parameter</b> | <B>constant</b> ] [ <B>input</b> | <B>output</b> ]</PRE>

<h4>Description</h4>

<p>The flow prefix is used in order to generate equations for through variables, which sum up to zero in connections,
whereas variables without the flow prefix are identical in a connection.</p>
</html>"));
end 'flow';


class 'for' "for"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Repeat equations or statements a specific number of times
</p>
<h4>Examples</h4>
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
<h4>Syntax</h4>
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
<h4>Description</h4>
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
for-clauses it can be expanded into the usual form by replacing each \",\" by <code>'loop for'</code> and adding extra <code>'end
for'</code>. For reduction-expressions it can be expanded into the usual form by replacing each ',' by <code>') for'</code> and
prepending the reduction-expression with <code>'function-name('</code>.</p>
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
end 'for';


class 'if' "if"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Declare equations or execute statements conditionally
</p>
<h4>Examples</h4>
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
<h4>Syntax</h4>
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
<h4>Description</h4>
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
end 'if';


class 'import' "import"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Import classes
</p>
<h4>Examples</h4>

<pre><b>class</b> Lookup
  <b>import</b> SI = Modelica.SIunits; // #1
  <b>import</b> Modelica.Math.*; // #2
  <b>import</b> Modelica.Mechanics.Rotational; // #3

  SI.Torque torque; // due to #1 (Modelica.SIunits.Torque)
  Rotational.Components.Inertia inertia; // due to #3 (Modelica.Mechanics.Rotational.Components.Inertia)
<b>equation</b>
  torque = sin(<b>time</b>); // due to #2 (Modelica.Math.sin)
  ...
<b>end</b> Lookup;</pre>

<h4>Syntax</h4>

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
<h4>Description</h4>

<p>Using import statements extends the static name lookup to additional import names.
The generated import names are:</p>

<ul>
  <li><code>C</code> for <code><b>import</b> A.B.C;</code></li>
  <li><code>D</code> for <code><b>import</b> D = A.B.C;</code></li>
  <li><code>C</code> and all other classes in B for <code><b>import</b> A.B.*;</code></li>
</ul>
</html>"));
end 'import';


class 'input' "input"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Define causality and/or block diagram connection semantic
(depending on context)
</p>
<h4>Examples</h4>

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

<h4>Syntax</h4>

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

<h4>Description</h4>

<p>
The prefixes <b>input</b> and <b>output</b> have a slightly different semantic meaning depending on the context where they are used:
</p>

<ul>
<li> In functions, these prefixes define the computational causality of the
     function body, i.e., given the variables declared as input,
     the variables declared as output are computed in the function body.<br>&nbsp;</li>

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
end 'input';


class 'output' "output"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Define causality and/or block diagram connection semantic
(depending on context)
</p>

<h4>Examples</h4>

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

<h4>Syntax</h4>

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

<h4>Description</h4>

<p>
The prefixes <b>input</b> and <b>output</b> have a slightly different semantic meaning depending on the context where they are used:
</p>

<ul>
<li> In functions, these prefixes define the computational causality of the
     function body, i.e., given the variables declared as input,
     the variables declared as output are computed in the function body.<br>&nbsp;</li>

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
end 'output';


class 'partial' "partial"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Prohibit instantiation of components of the class
</p>
<h4>Examples</h4>

<pre><b>partial block</b> PartialBlock
  <b>input</b> Real u;
  <b>output</b> Real y;
<b>protected</b>
  Real x;
<b>equation</b>
  x = y;
<b>end</b> PartialBlock;

<b>block</b> Integrator
  <b>extends</b> PartialBlock;
<b>equation
  der</b>(x) = u;
<b>end</b> Integrator;

<b>block</b> Gain
  <b>extends</b> PartialBlock;
  <b>parameter</b> k = 1;
<b>equation</b>
  x = k*u;
<b>end</b> Gain;

<b>model</b> Composition
  PartialBlock block1; // Illegal
  Integrator block2; // Legal
  Gain block3; // Legal
<b>end</b> Composition;</pre>

<h4>Syntax</h4>

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

<h4>Description</h4>

<p>
The keyword <b>partial</b> defines that a class is <b>incomplete</b> and
that it cannot be instantiated. For example, defining
</p>

<pre>   PartialBlock block1;</pre>

<p>
is illegal. A partial class can only be used in an \"extends\" clause to inherit from it
or in a \"constrained\" clause to define the constraints of a replaceable class.
</p>

</html>"));
end 'partial';


class 'stream' "stream"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Declare stream variable in a connector to describe bi-directional flow of matter
</p>
<h4>Examples</h4>

<blockquote>
<pre><b>connector</b> FluidPort
  <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium;
  Medium.AbsolutePressure        p          \"Pressure in connection point\";
  <b>flow</b>   Medium.MassFlowRate     m_flow     \"&gt; 0, if flow into component\";
  <b>stream</b> Medium.SpecificEnthalpy h_outflow  \"h close to port if m_flow &lt; 0\";
<b>end</b> FluidPort;
</pre></blockquote>
<p>
FluidPort is a stream connector, because a connector variable has the
stream prefix. The Medium definition and the stream variables are associated
with the only flow variable (m_flow) that defines a fluid stream.
The Medium and the stream variables are transported with this flow variable.
The stream variable h_outflow is the stream property inside the component
close to the boundary, when fluid flows out of the component into
the connection point. The stream properties for the other flow direction
can be inquired with the built-in operator
<a href=\"modelica://ModelicaReference.Operators.InStream\">inStream()</a>. The value of the
stream variable corresponding to the actual flow direction can be
inquired through the built-in operator actualStream().
</p>

<blockquote>
<pre><b>model</b> IsenthalpicFlow \"No energy storage/losses, e.g., pressure drop, valve, ...\"
  <b>replaceable package</b> Medium=Modelica.Media.Interfaces.PartialMedium;
  FluidPort port_a, port_b:
  Medium.ThermodynamicState port_a_state_inflow \"State at port_a if inflowing\";
  Medium.ThermodynamicState port_b_state_inflow \"State at port_b if inflowing\";
<b>equation</b>
  // Medium states for inflowing fluid
  port_a_state_inflow = Medium.setState_phX(port_a.p,
                                            <b>inStream</b>(port_a.h_outflow));
  port_b_state_inflow = Medium.setState_phX(port_b.p,
                                            <b>inStream</b>(port_b.h_outflow));
  // Mass balance
  0 = port_a.m_flow + port_b.m_flow;

  // Instantaneous propagation of enthalpy flow between the ports with
  // isenthalpic state transformation (no storage and no loss of energy)
  port_a.h_outflow = <b>inStream</b>(port_b.h_outflow);
  port_b.h_outflow = <b>inStream</b>(port_a.h_outflow);

  // (Regularized) Momentum balance
  port_a.m_flow = f(port_a.p, port_b.p,
                    Medium.density(port_a_state_inflow),
                    Medium.density(port_b_state_inflow));
<b>end</b> IsenthalpicFlow;
</pre></blockquote>

<p>When two or more FluidPort (inside) connectors are connected together, then <b>no</b>
connection equations are generated for <b>stream</b> variables. Instead, these
equations are constructed by the <b>inStream</b>(..) built-in operator
(see example model IsenthalpicFlow) above. If two IsenthalpicFlow components
are connected together:
</p>

<blockquote><pre>   IsenthalpicFlow dp1;
   IsenthalpicFlow dp2;
<b>equation</b>
  <b>connect</b>(dp1, dp2);
</pre></blockquote>

<p>
Then, the following connection equations are generated
</p>

<blockquote><pre>dp1.p = dp2.p;
0 = dp1.m_flow + dp2.m_flow;
</pre></blockquote>

<p>
Note, no equation for a stream variable is generated. However, the inStream(..)
operators inside the components provide the \"ideal mixing\" equations:
</p>

<blockquote><pre>// within dp1:
  <b>inStream</b>(dp1.port_b.h_outflow) := dp2.port_a.h_outflow;

// within dp2:
  <b>inStream</b>(dp2.port_a.h_outflow) := dp1.port_b.h_outflow;
</pre></blockquote>

<h4>Syntax</h4>

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
   [ <B>flow</b> | <B>stream</b> ]
   [ <B>discrete</B> | <B>parameter</b> | <B>constant</b> ] [ <B>input</b> | <B>output</b> ]</PRE>

<h4>Description</h4>

<p>
A detailed description of the stream keyword and the inStream operator is given
in Chapter 15 and Appendix D of the
<a href=\"http://www.modelica.org/documents/ModelicaSpec32.pdf\">Modelica Language Specification version 3.2</a>.
An overview and a rational is provided in a
<a href=\"modelica://Modelica/Resources/Documentation/Fluid/Stream-Connectors-Overview-Rationale.pdf\">slide set</a>.
</p>

<p>
The two basic variable types in a connector <b>potential</b> (or across) variable
and <b>flow</b> (or through) variable are not sufficient to describe in a numerically
sound way the bi-directional flow of matter with convective transport of specific
quantities, such as specific enthalpy and chemical composition. The values of these
specific quantities are determined from the upstream side of the flow, i.e., they depend
on the flow direction. When using across and through variables, the corresponding models
would include nonlinear systems of equations with Boolean unknowns for the flow directions
and singularities around zero flow. Such equation systems cannot be solved reliably in
general. The model formulations can be simplified when formulating two different balance
equations for the two possible flow directions. This is not possible with across and
through variables though.
</p>

<p>
This fundamental problem is addressed in Modelica 3.1 by
introducing a third type of connector variable, called stream variable,
declared with the prefix <b>stream</b>. A stream variable describes a quantity that
is carried by a flow variable, i.e., a purely convective transport phenomenon.
The value of the stream variable is the specific property inside the component
close to the boundary, assuming that matter flows out of the component into the
connection point. In other words, it is the value the carried quantity would
have if the fluid was flowing out of the connector, irrespective of the actual flow direction.
</p>

<p>
The basic idea is sketched at hand of an example:
Three connectors c1, c2, c3 with the definition
</p>

<blockquote><pre>
<b>connector</b> Demo
  Real        p;  // potential variable
  <b>flow</b>   Real m_flow;  // flow variable
  <b>stream</b> Real h;  // stream variable
<b>end</b> Demo;
</pre></blockquote>

<p>
are connected together with
</p>

<blockquote><pre>
<b>connect</b>(c1,c2);
<b>connect</b>(c1,c3);
</pre></blockquote>

<p>
then this leads to the following equations:
</p>

<blockquote><pre>
// Potential variables are identical
c1.p = c2.p;
c1.p = c3.p;

// The sum of the flow variables is zero
0 = c1.m_flow + c2.m_flow + c3.m_flow;

/* The sum of the product of flow variables and upstream stream variables is zero
   (this implicit set of equations is explicitly solved when generating code;
   the \"&lt;undefined&gt;\" parts are defined in such a way that
   inStream(..) is continuous).
*/
0 = c1.m_flow*(<b>if</b> c1.m_flow > 0 <b>then</b> h_mix <b>else</b> c1.h) +
    c2.m_flow*(<b>if</b> c2.m_flow > 0 <b>then</b> h_mix <b>else</b> c2.h) +
    c3.m_flow*(<b>if</b> c3.m_flow > 0 <b>then</b> h_mix <b>else</b> c3.h);

<b>inStream</b>(c1.h) = <b>if</b> c1.m_flow > 0 <b>then</b> h_mix <b>else</b> &lt;undefined&gt;;
<b>inStream</b>(c2.h) = <b>if</b> c2.m_flow > 0 <b>then</b> h_mix <b>else</b> &lt;undefined&gt;;
<b>inStream</b>(c3.h) = <b>if</b> c3.m_flow > 0 <b>then</b> h_mix <b>else</b> &lt;undefined&gt;;

</pre></blockquote>

<p>
If at least one variable in a connector has the stream prefix, the connector
is called <b>stream connector</b> and the corresponding variable is called
<b>stream variable</b>. The following definitions hold:
</p>

<ul>
<li> The stream prefix can only be used in a connector declaration.</li>
<li> A stream connector must have exactly one scalar variable with the flow prefix.
     [<i>The idea is that all stream variables of a connector are associated with
      this flow variable</i>].</li>
<li> For every outside connector, one equation is generated for every variable
     with the stream prefix [<i>to describe the propagation of the stream
     variable along a model hierarchy</i>]. For the exact definition,
     see the end of section 15.2.</li>
<li> For inside connectors, variables with the stream prefix do not lead to
     connection equations.</li>
<li> Connection equations with stream variables are generated in a
     model when using the inStream() operator or the actualStream() operator.</li>
</ul>

<p>
For further details, see the definition of the
<a href=\"modelica://ModelicaReference.Operators.InStream\">inStream()</a> operator.
</p>

</html>"));
end 'stream';


class 'time' "time"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Built-in variable time
</p>
<h4>Examples</h4>

<PRE><B>encapsulated model</B> SineSource
  <B>import</B> Modelica.Math.sin;
  <B>connector</B> OutPort=<B>output</B> Real;
  OutPort y=sin(time); // Uses the built-in variable time.
<B>end</B> SineSource;</PRE>

<h4>Syntax</h4>

<pre><b>time</b></pre>

<h4>Description</h4>

<P>All declared variables are functions of the independent
variable <B>time</B>. Time is a built-in variable available
in all classes, which is treated as an input variable. It
is implicitly defined as:</P>

<PRE><B>input</B> Real time (<B>final</B> quantity = \"Time\",
                 <B>final</B> unit     = \"s\");</PRE>

<P>The value of the <B>start</B> attribute of time is set to
the time instant at which the simulation is started.</P>

</html>"));
end 'time';


class 'when' "when"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Activate equations or statements when condition becomes true
</p>
<h4>Examples</h4>
<PRE> <B>equation
   when</B> x &gt; 2 <B>then</B>
     y3 = 2*x +y1+y2; // Order of y1 and y3 equations does not matter
     y1 = sin(x);
   <B>end when</B>;
   y2 = sin(y1);</PRE>

<h4>Syntax</h4>

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

<h4>Description</h4>

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

<P><I>For when in equation sections the order between the equations does not matter, e.g.,</I></P>
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
with identical conditions, e.g.,</I></P>

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
end 'when';


class 'while' "while"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Repeat statements as long as a condition is fulfilled
</p>
<h4>Examples</h4>
<pre>    Integer i;
  <b>algorithm</b>
    i := 1;
    <b>while</b> i &lt; 10 <b>loop</b>
      i := i + 1;
      <b>...
    end while</b>;</pre>

<h4>Syntax</h4>

<PRE>  <B>while</B> expression <B>loop</B>
    { algorithm \";\" }
  <B>end while</B></PRE>

<h4>Description</h4>

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
end 'while';


package Icons
  partial class Information "Icon for general information packages"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,174,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-14,56},{16,38}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-24,10},{16,10},{16,-44},{26,-44},{26,-54},{-14,-54},{-14,
                -2},{-24,-2},{-24,10}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
                              Documentation(info="<html>
<p>This icon indicate classes containing only documentation, intended for general description of e.g., concepts and features of a package.</p>
</html>"));
  end Information;

  partial class Contact "Icon for contact information"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,70},{100,-72}},
            lineColor={0,0,0},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-100,-72},{100,-72},{0,20},{-100,-72}},
            lineColor={0,0,0},
            smooth=Smooth.None,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{22,0},{100,70},{100,-72},{22,0}},
            lineColor={0,0,0},
            smooth=Smooth.None,
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-100,70},{100,70},{0,-20},{-100,70}},
            lineColor={0,0,0},
            smooth=Smooth.None,
            fillColor={241,241,241},
            fillPattern=FillPattern.Solid)}),
                              Documentation(info="<html>
<p>This icon shall be used for the contact information of the library developers.</p>
</html>"));
  end Contact;
end Icons;


class Contact "Contact"
  extends ModelicaReference.Icons.Contact;

 annotation (Documentation(info="<html>
<dl>
<dt><b>Library Officers:</b>
<dd> <a href=\"http://claimid.com/dietmarw\">Dietmar Winkler</a><br>
     Telemark University College<br>
     PO box 203<br>
     NO-3901 Porsgrunn<br>
     Norway<br>
     &nbsp;<br>
     and<br>&nbsp;<br>
    <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
    Institut f&uuml;r Robotik und Mechatronik<br>
    Abteilung Systemdynamik und Regelungstechnik<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>
<p><b>Acknowledgements:</b></p>
<ul>
<li> The initial version of ModelicaReference is from Christian Schweiger (DLR) who
     provided it up to Modelica version 2.2.</li>

<li> Martin Otter (DLR) updated ModelicaReference for Modelica 3.0.</li>

<li> Dietmar Winkler (Telemark University College) updated ModelicaReference for
     Modelica 3.1 and 3.2</li>

<li> Stefan Vorkoetter (Maplesoft) provided ModelicaReference.ModelicaGrammar
     for Modelica 3.2.</li>
</ul>

</html>"));

end Contact;


annotation (__Dymola_DocumentationClass=true,
     dateModified="2010-10-06 17:00:00Z",
     revisionId="$Id::                                       $",
     Documentation(info="<html>
<p>
This package is a reference to Modelica keywords,
<a href=\"modelica://ModelicaReference.Operators\">Modelica builtin operators</a>
, and the <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica grammar</a>.
It is based on the
<a href=\"http://www.modelica.org/documents/ModelicaSpec32.pdf\">Modelica Language Specification version 3.2</a> from March 2010. Currently, not the whole Modelica language is documented in ModelicaReference (but a large subset).
</p>

<p>
<b>Copyright &copy; 2003-2010 Modelica Association, DLR, Telemark University College, and Maplesoft.</b>
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>", revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Revision</th>
      <th>Date</th>
      <th>Author</th>
      <th>Comment</th>
    </tr>
     <tr>
      <td valign=\"top\"><a href=\"http://trac.modelica.org/Modelica/changeset/4781/Modelica\">r4781</a></td>
      <td valign=\"top\">2011-12-15</td>
      <td valign=\"top\"><a href=\"http://claimid.com/dietmarw\">Dietmar Winkler</a></td>
      <td valign=\"top\">Use quoted class names for function descriptions (closes ticket <a href=\"http://trac.modelica.org/Modelica/ticket/565\">#565</a>)</td>
    </tr>
    <tr>
      <td valign=\"top\"><a href=\"http://trac.modelica.org/Modelica/changeset/4256/Modelica\">r4256</a></td>
      <td valign=\"top\">2010-10-06</td>
      <td valign=\"top\"><a href=\"http://claimid.com/dietmarw\">Dietmar Winkler</a></td>
      <td valign=\"top\">Removed 'uses' annotation and added icons so it can be used with multiple versions of the MSL (closes ticket <a href=\"http://trac.modelica.org/Modelica/ticket/425\">#425</a>)</td>
    </tr>
    <tr>
      <td valign=\"top\"><a href=\"http://trac.modelica.org/Modelica/changeset/4218/Modelica\">r4218</a></td>
      <td valign=\"top\">2010-09-25</td>
      <td valign=\"top\"><a href=\"http://claimid.com/dietmarw\">Dietmar Winkler</a></td>
      <td valign=\"top\">Major clean up of the documentation by use of <a href=\"http://linkchecker.sourceforge.net\"> LinkChecker</a> (closes ticket <a href=\"http://trac.modelica.org/Modelica/ticket/228\">#228</a>)</td>
    </tr>
    <tr>
      <td valign=\"top\"><a href=\"http://trac.modelica.org/Modelica/changeset/4145/Modelica\">r4145</a></td>
      <td valign=\"top\">2010-09-07</td>
      <td valign=\"top\"><a href=\"http://claimid.com/dietmarw\">Dietmar Winkler</a></td>
      <td valign=\"top\">Added an update of the <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica 3.2 grammar</a>
                       from Stefan Vorkoetter (Maplesoft).</td>
    </tr>
    <tr>
      <td valign=\"top\"><a href=\"http://trac.modelica.org/Modelica/changeset/3742/Modelica\">r3742</a></td>
      <td valign=\"top\">2010-04-13</td>
      <td valign=\"top\"><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a></td>
      <td valign=\"top\">Added the <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica 3.2 grammar</a>
                       from Stefan Vorkoetter (Maplesoft).<br>
                       Introduced a \"Contact\" subpackage with updated contact and
                       acknowledgment information.</td>
    </tr>
    <tr>
      <td valign=\"top\"><a href=\"http://trac.modelica.org/Modelica/changeset/3598/Modelica\">r3598</a></td>
      <td valign=\"top\">2010-03-10</td>
      <td valign=\"top\"><a href=\"http://claimid.com/dietmarw\">Dietmar Winkler</a></td>
      <td valign=\"top\">Added some annotations from Modelica language version 3.1 and 3.2 (see ticket <a href=\"http://trac.modelica.org/Modelica/ticket/228\">#228</a>)</td>
    </tr>
    <tr>
      <td valign=\"top\"><a href=\"http://trac.modelica.org/Modelica/changeset/948/Modelica\">r948</a></td>
      <td valign=\"top\">2008-01-02</td>
      <td valign=\"top\"><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a></td>
      <td valign=\"top\">Adapted to Modelica language version 3.0</td>
    </tr>
    <tr>
      <td valign=\"top\"></td>
      <td valign=\"top\">2004-09-30</td>
      <td valign=\"top\"><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a></td>
      <td valign=\"top\">Moved the content of \"Functions\" into \"Operators\" and updated \"Operators\" according to Modelica 2.1</td>
    </tr>
    <tr>
      <td valign=\"top\"></td>
      <td valign=\"top\">2003-07-10</td>
      <td valign=\"top\"><a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a></td>
      <td valign=\"top\">Implemented.</td>
    </tr>
</table>
</html>"));
end ModelicaReference;
