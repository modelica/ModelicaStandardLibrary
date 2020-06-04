within ;
package ModelicaReference "Modelica Reference"
extends ModelicaReference.Icons.Information;

class ModelicaGrammar "Modelica Grammar"
  extends ModelicaReference.Icons.Information;

  annotation (Documentation(info="<html><head><title>Modelica 3.4 Grammar</title>
<style type=\"text/css\">
A.HREF { text-decoration:none; color:#003399 }
</style>
</head>
<body><h4>Modelica 3.4 Grammar</h4>
<p>This is the grammar of Modelica 3.4 in EBNF form. Each
non-terminal appearing on the right hand side of a production is a link to the
production for that non-terminal. This grammar is identical to that in the
Modelica 3.4 specification except for removal of some unnecessary
parentheses, grouping of some common terms, and reformatting for easier
readability. The following typographic conventions are used:</p>
<ul>
<li>Keywords are set in <strong>boldface</strong>.</li>
<li>Literals other than keywords are <font color=\"green\">\"</font><tt>quoted-monospaced</tt><font color=\"green\">\"</font> text.</li>
<li>Non-terminals are set in <em>italics</em>, with <font color=\"#003399\"><em>blue italics</em></font> used for links.</li>
<li>EBNF meta-characters are <font color=\"green\">green</font>.</li>
</ul>
<h5>Stored Definition</h5>
<p><a name=\"stored_definition\" class=\"NAME\"><em>stored_definition</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>within</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#name\" class=\"HREF\"><em>name</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>final</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><a href=\"#class_definition\" class=\"HREF\"><em>class_definition</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
</p>
<h5>Class Definition</h5>
<p><a name=\"class_definition\" class=\"NAME\"><em>class_definition</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>encapsulated</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><a href=\"#class_prefixes\" class=\"HREF\"><em>class_prefixes</em></a><tt>&nbsp;</tt><a href=\"#class_specifier\" class=\"HREF\"><em>class_specifier</em></a>
</p>
<p><a name=\"class_prefixes\" class=\"NAME\"><em>class_prefixes</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>partial</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">(</font><tt>&nbsp;</tt><strong>class</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>model</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>operator</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><strong>record</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>block</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>expandable</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><strong>connector</strong>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>type</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>package</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>pure</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>impure</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>operator</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><strong>function</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>operator</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">)</font>
</p>
<p><a name=\"class_specifier\" class=\"NAME\"><em>class_specifier</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#long_class_specifier\" class=\"HREF\"><em>long_class_specifier</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#short_class_specifier\" class=\"HREF\"><em>short_class_specifier</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#der_class_specifier\" class=\"HREF\"><em>der_class_specifier</em></a>
</p>
<p><a name=\"long_class_specifier\" class=\"NAME\"><em>long_class_specifier</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><em>IDENT</em><tt>&nbsp;</tt><a href=\"#string_comment\" class=\"HREF\"><em>string_comment</em></a><tt>&nbsp;</tt><a href=\"#composition\" class=\"HREF\"><em>composition</em></a><tt>&nbsp;</tt><strong>end</strong><tt>&nbsp;</tt><em>IDENT</em>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>extends</strong><tt>&nbsp;</tt><em>IDENT</em><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#class_modification\" class=\"HREF\"><em>class_modification</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><a href=\"#string_comment\" class=\"HREF\"><em>string_comment</em></a><tt>&nbsp;</tt><a href=\"#composition\" class=\"HREF\"><em>composition</em></a><tt>&nbsp;</tt><strong>end</strong><tt>&nbsp;</tt><em>IDENT</em>
</p>
<p><a name=\"short_class_specifier\" class=\"NAME\"><em>short_class_specifier</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><em>IDENT</em><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>=</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#base_prefix\" class=\"HREF\"><em>base_prefix</em></a><tt>&nbsp;</tt><a href=\"#type_specifier\" class=\"HREF\"><em>type_specifier</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#array_subscripts\" class=\"HREF\"><em>array_subscripts</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#class_modification\" class=\"HREF\"><em>class_modification</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><a href=\"#comment\" class=\"HREF\"><em>comment</em></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><em>IDENT</em><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>=</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><strong>enumeration</strong><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>(</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">(</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#enum_list\" class=\"HREF\"><em>enum_list</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>:</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">)</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>)</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#comment\" class=\"HREF\"><em>comment</em></a>
</p>
<p><a name=\"der_class_specifier\" class=\"NAME\"><em>der_class_specifier</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><em>IDENT</em><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>=</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><strong>der</strong><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>(</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#type_specifier\" class=\"HREF\"><em>type_specifier</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>,</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><em>IDENT</em><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>,</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><em>IDENT</em><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>)</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#comment\" class=\"HREF\"><em>comment</em></a>
</p>
<p><a name=\"base_prefix\" class=\"NAME\"><em>base_prefix</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>input</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>output</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
</p>
<p><a name=\"enum_list\" class=\"NAME\"><em>enum_list</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#enumeration_literal\" class=\"HREF\"><em>enumeration_literal</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>,</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#enumeration_literal\" class=\"HREF\"><em>enumeration_literal</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
</p>
<p><a name=\"enumeration_literal\" class=\"NAME\"><em>enumeration_literal</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><em>IDENT</em><tt>&nbsp;</tt><a href=\"#comment\" class=\"HREF\"><em>comment</em></a>
</p>
<p><a name=\"composition\" class=\"NAME\"><em>composition</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#element_list\" class=\"HREF\"><em>element_list</em></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><strong>public</strong><tt>&nbsp;</tt><a href=\"#element_list\" class=\"HREF\"><em>element_list</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>protected</strong><tt>&nbsp;</tt><a href=\"#element_list\" class=\"HREF\"><em>element_list</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#equation_section\" class=\"HREF\"><em>equation_section</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#algorithm_section\" class=\"HREF\"><em>algorithm_section</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>external</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#language_specification\" class=\"HREF\"><em>language_specification</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#external_function_call\" class=\"HREF\"><em>external_function_call</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#annotation_comment\" class=\"HREF\"><em>annotation_comment</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#annotation_comment\" class=\"HREF\"><em>annotation_comment</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
</p>
<p><a name=\"language_specification\" class=\"NAME\"><em>language_specification</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><em>STRING</em>
</p>
<p><a name=\"external_function_call\" class=\"NAME\"><em>external_function_call</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#component_reference\" class=\"HREF\"><em>component_reference</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>=</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><em>IDENT</em><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>(</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#expression_list\" class=\"HREF\"><em>expression_list</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>)</tt><font color=\"green\">\"</font>
</p>
<p><a name=\"element_list\" class=\"NAME\"><em>element_list</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#element\" class=\"HREF\"><em>element</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
</p>
<p><a name=\"element\" class=\"NAME\"><em>element</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#import_clause\" class=\"HREF\"><em>import_clause</em></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#extends_clause\" class=\"HREF\"><em>extends_clause</em></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>redeclare</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>final</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>inner</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>outer</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">(</font><tt>&nbsp;</tt><a href=\"#class_definition\" class=\"HREF\"><em>class_definition</em></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#component_clause\" class=\"HREF\"><em>component_clause</em></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>replaceable</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">(</font><tt>&nbsp;</tt><a href=\"#class_definition\" class=\"HREF\"><em>class_definition</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#component_clause\" class=\"HREF\"><em>component_clause</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">)</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#constraining_clause\" class=\"HREF\"><em>constraining_clause</em></a><tt>&nbsp;</tt><a href=\"#comment\" class=\"HREF\"><em>comment</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">)</font>
</p>
<p><a name=\"import_clause\" class=\"NAME\"><em>import_clause</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>import</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">(</font><tt>&nbsp;</tt><em>IDENT</em><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>=</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#name\" class=\"HREF\"><em>name</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#name\" class=\"HREF\"><em>name</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>.</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>*</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>.*</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>{</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#import_list\" class=\"HREF\"><em>import_list</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>}</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">)</font><tt>&nbsp;</tt><a href=\"#comment\" class=\"HREF\"><em>comment</em></a>
</p>
<p><a name=\"import_list\" class=\"NAME\"><em>import_list</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><em>IDENT</em><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>,</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><em>IDENT</em><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
</p>
<h5>Extends</h5>
<p><a name=\"extends_clause\" class=\"NAME\"><em>extends_clause</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>extends</strong><tt>&nbsp;</tt><a href=\"#type_specifier\" class=\"HREF\"><em>type_specifier</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#class_modification\" class=\"HREF\"><em>class_modification</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#annotation_comment\" class=\"HREF\"><em>annotation_comment</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
</p>
<p><a name=\"constraining_clause\" class=\"NAME\"><em>constraining_clause</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>constrainedby</strong><tt>&nbsp;</tt><a href=\"#type_specifier\" class=\"HREF\"><em>type_specifier</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#class_modification\" class=\"HREF\"><em>class_modification</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
</p>
<h5>Component Clause</h5>
<p><a name=\"component_clause\" class=\"NAME\"><em>component_clause</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#type_prefix\" class=\"HREF\"><em>type_prefix</em></a><tt>&nbsp;</tt><a href=\"#type_specifier\" class=\"HREF\"><em>type_specifier</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#array_subscripts\" class=\"HREF\"><em>array_subscripts</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><a href=\"#component_list\" class=\"HREF\"><em>component_list</em></a>
</p>
<p><a name=\"type_prefix\" class=\"NAME\"><em>type_prefix</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>flow</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>stream</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>discrete</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>parameter</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>constant</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>input</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>output</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
</p>
<p><a name=\"component_list\" class=\"NAME\"><em>component_list</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#component_declaration\" class=\"HREF\"><em>component_declaration</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>,</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#component_declaration\" class=\"HREF\"><em>component_declaration</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
</p>
<p><a name=\"component_declaration\" class=\"NAME\"><em>component_declaration</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#declaration\" class=\"HREF\"><em>declaration</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#condition_attribute\" class=\"HREF\"><em>condition_attribute</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><a href=\"#comment\" class=\"HREF\"><em>comment</em></a>
</p>
<p><a name=\"condition_attribute\" class=\"NAME\"><em>condition_attribute</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>if</strong><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a>
</p>
<p><a name=\"declaration\" class=\"NAME\"><em>declaration</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><em>IDENT</em><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#array_subscripts\" class=\"HREF\"><em>array_subscripts</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#modification\" class=\"HREF\"><em>modification</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
</p>
<h5>Modification</h5>
<p><a name=\"modification\" class=\"NAME\"><em>modification</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#class_modification\" class=\"HREF\"><em>class_modification</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>=</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>=</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>:=</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a>
</p>
<p><a name=\"class_modification\" class=\"NAME\"><em>class_modification</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\">\"</font><tt>(</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#argument_list\" class=\"HREF\"><em>argument_list</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>)</tt><font color=\"green\">\"</font>
</p>
<p><a name=\"argument_list\" class=\"NAME\"><em>argument_list</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#argument\" class=\"HREF\"><em>argument</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>,</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#argument\" class=\"HREF\"><em>argument</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
</p>
<p><a name=\"argument\" class=\"NAME\"><em>argument</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#element_modification_or_replaceable\" class=\"HREF\"><em>element_modification_or_replaceable</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#element_redeclaration\" class=\"HREF\"><em>element_redeclaration</em></a>
</p>
<p><a name=\"element_modification_or_replaceable\" class=\"NAME\"><em>element_modification_or_replaceable</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>each</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>final</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">(</font><tt>&nbsp;</tt><a href=\"#element_modification\" class=\"HREF\"><em>element_modification</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#element_replaceable\" class=\"HREF\"><em>element_replaceable</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">)</font>
</p>
<p><a name=\"element_modification\" class=\"NAME\"><em>element_modification</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#name\" class=\"HREF\"><em>name</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#modification\" class=\"HREF\"><em>modification</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><a href=\"#string_comment\" class=\"HREF\"><em>string_comment</em></a>
</p>
<p><a name=\"element_redeclaration\" class=\"NAME\"><em>element_redeclaration</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>redeclare</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>each</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>final</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">(</font><tt>&nbsp;</tt><a href=\"#short_class_definition\" class=\"HREF\"><em>short_class_definition</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#component_clause1\" class=\"HREF\"><em>component_clause1</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#element_replaceable\" class=\"HREF\"><em>element_replaceable</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">)</font>
</p>
<p><a name=\"element_replaceable\" class=\"NAME\"><em>element_replaceable</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>replaceable</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">(</font><tt>&nbsp;</tt><a href=\"#short_class_definition\" class=\"HREF\"><em>short_class_definition</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#component_clause1\" class=\"HREF\"><em>component_clause1</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">)</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#constraining_clause\" class=\"HREF\"><em>constraining_clause</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
</p>
<p><a name=\"component_clause1\" class=\"NAME\"><em>component_clause1</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#type_prefix\" class=\"HREF\"><em>type_prefix</em></a><tt>&nbsp;</tt><a href=\"#type_specifier\" class=\"HREF\"><em>type_specifier</em></a><tt>&nbsp;</tt><a href=\"#component_declaration1\" class=\"HREF\"><em>component_declaration1</em></a>
</p>
<p><a name=\"component_declaration1\" class=\"NAME\"><em>component_declaration1</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#declaration\" class=\"HREF\"><em>declaration</em></a><tt>&nbsp;</tt><a href=\"#comment\" class=\"HREF\"><em>comment</em></a>
</p>
<p><a name=\"short_class_definition\" class=\"NAME\"><em>short_class_definition</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#class_prefixes\" class=\"HREF\"><em>class_prefixes</em></a><tt>&nbsp;</tt><a href=\"#short_class_specifier\" class=\"HREF\"><em>short_class_specifier</em></a>
</p>
<h5>Equation</h5>
<p><a name=\"equation_section\" class=\"NAME\"><em>equation_section</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>initial</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><strong>equation</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#equation\" class=\"HREF\"><em>equation</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
</p>
<p><a name=\"algorithm_section\" class=\"NAME\"><em>algorithm_section</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>initial</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><strong>algorithm</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#statement\" class=\"HREF\"><em>statement</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
</p>
<p><a name=\"equation\" class=\"NAME\"><em>equation</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">(</font><tt>&nbsp;</tt><a href=\"#simple_expression\" class=\"HREF\"><em>simple_expression</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>=</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#if_equation\" class=\"HREF\"><em>if_equation</em></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#for_equation\" class=\"HREF\"><em>for_equation</em></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#connect_clause\" class=\"HREF\"><em>connect_clause</em></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#when_equation\" class=\"HREF\"><em>when_equation</em></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#component_reference\" class=\"HREF\"><em>component_reference</em></a><tt>&nbsp;</tt><a href=\"#function_call_args\" class=\"HREF\"><em>function_call_args</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">)</font><tt>&nbsp;</tt><a href=\"#comment\" class=\"HREF\"><em>comment</em></a>
</p>
<p><a name=\"statement\" class=\"NAME\"><em>statement</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">(</font><tt>&nbsp;</tt><a href=\"#component_reference\" class=\"HREF\"><em>component_reference</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">(</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>:=</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#function_call_args\" class=\"HREF\"><em>function_call_args</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">)</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>(</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#output_expression_list\" class=\"HREF\"><em>output_expression_list</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>)</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>:=</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#component_reference\" class=\"HREF\"><em>component_reference</em></a><tt>&nbsp;</tt><a href=\"#function_call_args\" class=\"HREF\"><em>function_call_args</em></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>break</strong>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>return</strong>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#if_statement\" class=\"HREF\"><em>if_statement</em></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#for_statement\" class=\"HREF\"><em>for_statement</em></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#while_statement\" class=\"HREF\"><em>while_statement</em></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#when_statement\" class=\"HREF\"><em>when_statement</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">)</font><tt>&nbsp;</tt><a href=\"#comment\" class=\"HREF\"><em>comment</em></a>
</p>
<p><a name=\"if_equation\" class=\"NAME\"><em>if_equation</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>if</strong><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><strong>then</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#equation\" class=\"HREF\"><em>equation</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><strong>elseif</strong><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><strong>then</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#equation\" class=\"HREF\"><em>equation</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>else</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#equation\" class=\"HREF\"><em>equation</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>end</strong><tt>&nbsp;</tt><strong>if</strong>
</p>
<p><a name=\"if_statement\" class=\"NAME\"><em>if_statement</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>if</strong><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><strong>then</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#statement\" class=\"HREF\"><em>statement</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><strong>elseif</strong><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><strong>then</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#statement\" class=\"HREF\"><em>statement</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>else</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#statement\" class=\"HREF\"><em>statement</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>end</strong><tt>&nbsp;</tt><strong>if</strong>
</p>
<p><a name=\"for_equation\" class=\"NAME\"><em>for_equation</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>for</strong><tt>&nbsp;</tt><a href=\"#for_indices\" class=\"HREF\"><em>for_indices</em></a><tt>&nbsp;</tt><strong>loop</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#equation\" class=\"HREF\"><em>equation</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font><tt>&nbsp;</tt><strong>end</strong><tt>&nbsp;</tt><strong>for</strong>
</p>
<p><a name=\"for_statement\" class=\"NAME\"><em>for_statement</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>for</strong><tt>&nbsp;</tt><a href=\"#for_indices\" class=\"HREF\"><em>for_indices</em></a><tt>&nbsp;</tt><strong>loop</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#statement\" class=\"HREF\"><em>statement</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font><tt>&nbsp;</tt><strong>end</strong><tt>&nbsp;</tt><strong>for</strong>
</p>
<p><a name=\"for_indices\" class=\"NAME\"><em>for_indices</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#for_index\" class=\"HREF\"><em>for_index</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>,</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#for_index\" class=\"HREF\"><em>for_index</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
</p>
<p><a name=\"for_index\" class=\"NAME\"><em>for_index</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><em>IDENT</em><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>in</strong><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
</p>
<p><a name=\"while_statement\" class=\"NAME\"><em>while_statement</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>while</strong><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><strong>loop</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#statement\" class=\"HREF\"><em>statement</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font><tt>&nbsp;</tt><strong>end</strong><tt>&nbsp;</tt><strong>while</strong>
</p>
<p><a name=\"when_equation\" class=\"NAME\"><em>when_equation</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>when</strong><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><strong>then</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#equation\" class=\"HREF\"><em>equation</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><strong>elsewhen</strong><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><strong>then</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#equation\" class=\"HREF\"><em>equation</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>end</strong><tt>&nbsp;</tt><strong>when</strong>
</p>
<p><a name=\"when_statement\" class=\"NAME\"><em>when_statement</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>when</strong><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><strong>then</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#statement\" class=\"HREF\"><em>statement</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><strong>elsewhen</strong><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><strong>then</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#statement\" class=\"HREF\"><em>statement</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>end</strong><tt>&nbsp;</tt><strong>when</strong>
</p>
<p><a name=\"connect_clause\" class=\"NAME\"><em>connect_clause</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>connect</strong><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>(</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#component_reference\" class=\"HREF\"><em>component_reference</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>,</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#component_reference\" class=\"HREF\"><em>component_reference</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>)</tt><font color=\"green\">\"</font>
</p>
<h5>Expression</h5>
<p><a name=\"expression\" class=\"NAME\"><em>expression</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#simple_expression\" class=\"HREF\"><em>simple_expression</em></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>if</strong><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><strong>then</strong><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><strong>elseif</strong><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><strong>then</strong><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>else</strong><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a>
</p>
<p><a name=\"simple_expression\" class=\"NAME\"><em>simple_expression</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#logical_expression\" class=\"HREF\"><em>logical_expression</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>:</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#logical_expression\" class=\"HREF\"><em>logical_expression</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>:</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#logical_expression\" class=\"HREF\"><em>logical_expression</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
</p>
<p><a name=\"logical_expression\" class=\"NAME\"><em>logical_expression</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#logical_term\" class=\"HREF\"><em>logical_term</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><strong>or</strong><tt>&nbsp;</tt><a href=\"#logical_term\" class=\"HREF\"><em>logical_term</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
</p>
<p><a name=\"logical_term\" class=\"NAME\"><em>logical_term</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#logical_factor\" class=\"HREF\"><em>logical_factor</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><strong>and</strong><tt>&nbsp;</tt><a href=\"#logical_factor\" class=\"HREF\"><em>logical_factor</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
</p>
<p><a name=\"logical_factor\" class=\"NAME\"><em>logical_factor</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><strong>not</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><a href=\"#relation\" class=\"HREF\"><em>relation</em></a>
</p>
<p><a name=\"relation\" class=\"NAME\"><em>relation</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#arithmetic_expression\" class=\"HREF\"><em>arithmetic_expression</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#relational_operator\" class=\"HREF\"><em>relational_operator</em></a><tt>&nbsp;</tt><a href=\"#arithmetic_expression\" class=\"HREF\"><em>arithmetic_expression</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
</p>
<p><a name=\"relational_operator\" class=\"NAME\"><em>relational_operator</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\">\"</font><tt>&lt;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>&lt;=</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>&gt;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>&gt;=</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>==</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>&lt;&gt;</tt><font color=\"green\">\"</font>
</p>
<p><a name=\"arithmetic_expression\" class=\"NAME\"><em>arithmetic_expression</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#add_operator\" class=\"HREF\"><em>add_operator</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><a href=\"#term\" class=\"HREF\"><em>term</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#add_operator\" class=\"HREF\"><em>add_operator</em></a><tt>&nbsp;</tt><a href=\"#term\" class=\"HREF\"><em>term</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
</p>
<p><a name=\"add_operator\" class=\"NAME\"><em>add_operator</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\">\"</font><tt>+</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>-</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>.+</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>.-</tt><font color=\"green\">\"</font>
</p>
<p><a name=\"term\" class=\"NAME\"><em>term</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#factor\" class=\"HREF\"><em>factor</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><a href=\"#mul_operator\" class=\"HREF\"><em>mul_operator</em></a><tt>&nbsp;</tt><a href=\"#factor\" class=\"HREF\"><em>factor</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
</p>
<p><a name=\"mul_operator\" class=\"NAME\"><em>mul_operator</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\">\"</font><tt>*</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>/</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>.*</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>./</tt><font color=\"green\">\"</font>
</p>
<p><a name=\"factor\" class=\"NAME\"><em>factor</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#primary\" class=\"HREF\"><em>primary</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">(</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>^</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>.^</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">)</font><tt>&nbsp;</tt><a href=\"#primary\" class=\"HREF\"><em>primary</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
</p>
<p><a name=\"primary\" class=\"NAME\"><em>primary</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><em>UNSIGNED_NUMBER</em>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><em>STRING</em>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>false</strong>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>true</strong>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#component_reference\" class=\"HREF\"><em>component_reference</em></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">(</font><tt>&nbsp;</tt><a href=\"#component_reference\" class=\"HREF\"><em>component_reference</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>der</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>initial</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>pure</strong><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">)</font><tt>&nbsp;</tt><a href=\"#function_call_args\" class=\"HREF\"><em>function_call_args</em></a>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>(</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#output_expression_list\" class=\"HREF\"><em>output_expression_list</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>)</tt><font color=\"green\">\"</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>[</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#expression_list\" class=\"HREF\"><em>expression_list</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>;</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#expression_list\" class=\"HREF\"><em>expression_list</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>]</tt><font color=\"green\">\"</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>{</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#array_arguments\" class=\"HREF\"><em>array_arguments</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>}</tt><font color=\"green\">\"</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>end</strong>
</p>
<p><a name=\"type_specifier\" class=\"NAME\"><em>type_specifier</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>.</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><a href=\"#name\" class=\"HREF\"><em>name</em></a>
</p>
<p><a name=\"name\" class=\"NAME\"><em>name</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><em>IDENT</em><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>.</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><em>IDENT</em><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
</p>
<p><a name=\"component_reference\" class=\"NAME\"><em>component_reference</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>.</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><em>IDENT</em><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#array_subscripts\" class=\"HREF\"><em>array_subscripts</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>.</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><em>IDENT</em><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#array_subscripts\" class=\"HREF\"><em>array_subscripts</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
</p>
<p><a name=\"function_call_args\" class=\"NAME\"><em>function_call_args</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\">\"</font><tt>(</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#function_arguments\" class=\"HREF\"><em>function_arguments</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>)</tt><font color=\"green\">\"</font>
</p>
<p><a name=\"function_arguments\" class=\"NAME\"><em>function_arguments</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>,</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#function_arguments_non_first\" class=\"HREF\"><em>function_arguments_non_first</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>for</strong><tt>&nbsp;</tt><a href=\"#for_indices\" class=\"HREF\"><em>for_indices</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>function</strong><tt>&nbsp;</tt><a href=\"#name\" class=\"HREF\"><em>name</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>(</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#named_arguments\" class=\"HREF\"><em>named_arguments</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>)</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>,</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#function_arguments_non_first\" class=\"HREF\"><em>function_arguments_non_first</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#named_arguments\" class=\"HREF\"><em>named_arguments</em></a>
</p>
<p><a name=\"function_arguments_non_first\" class=\"NAME\"><em>function_arguments_non_first</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#function_argument\" class=\"HREF\"><em>function_argument</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>,</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#function_arguments_non_first\" class=\"HREF\"><em>function_arguments_non_first</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#named_arguments\" class=\"HREF\"><em>named_arguments</em></a>
</p>
<p><a name=\"array_arguments\" class=\"NAME\"><em>array_arguments</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>,</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#array_arguments_non_first\" class=\"HREF\"><em>array_arguments_non_first</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><strong>for</strong><tt>&nbsp;</tt><a href=\"#for_indices\" class=\"HREF\"><em>for_indices</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
</p>
<p><a name=\"array_arguments_non_first\" class=\"NAME\"><em>array_arguments_non_first</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>,</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#array_arguments_non_first\" class=\"HREF\"><em>array_arguments_non_first</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
</p>
<p><a name=\"named_arguments\" class=\"NAME\"><em>named_arguments</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#named_argument\" class=\"HREF\"><em>named_argument</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>,</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#named_arguments\" class=\"HREF\"><em>named_arguments</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
</p>
<p><a name=\"named_argument\" class=\"NAME\"><em>named_argument</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><em>IDENT</em><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>=</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#function_argument\" class=\"HREF\"><em>function_argument</em></a>
</p>
<p><a name=\"function_argument\" class=\"NAME\"><em>function_argument</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>function</strong><tt>&nbsp;</tt><a href=\"#name\" class=\"HREF\"><em>name</em></a><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>(</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#named_arguments\" class=\"HREF\"><em>named_arguments</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>)</tt><font color=\"green\">\"</font>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a>
</p>
<p><a name=\"output_expression_list\" class=\"NAME\"><em>output_expression_list</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>,</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
</p>
<p><a name=\"expression_list\" class=\"NAME\"><em>expression_list</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>,</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font>
</p>
<p><a name=\"array_subscripts\" class=\"NAME\"><em>array_subscripts</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\">\"</font><tt>[</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#subscript\" class=\"HREF\"><em>subscript</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>,</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><a href=\"#subscript\" class=\"HREF\"><em>subscript</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>]</tt><font color=\"green\">\"</font>
</p>
<p><a name=\"subscript\" class=\"NAME\"><em>subscript</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\">\"</font><tt>:</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">|</font><tt>&nbsp;</tt><a href=\"#expression\" class=\"HREF\"><em>expression</em></a>
</p>
<p><a name=\"comment\" class=\"NAME\"><em>comment</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><a href=\"#string_comment\" class=\"HREF\"><em>string_comment</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><a href=\"#annotation_comment\" class=\"HREF\"><em>annotation_comment</em></a><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
</p>
<p><a name=\"string_comment\" class=\"NAME\"><em>string_comment</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><font color=\"green\" size=\"+1\">[</font><tt>&nbsp;</tt><em>STRING</em><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">{</font><tt>&nbsp;</tt><font color=\"green\">\"</font><tt>+</tt><font color=\"green\">\"</font><tt>&nbsp;</tt><em>STRING</em><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">}</font><tt>&nbsp;</tt><font color=\"green\" size=\"+1\">]</font>
</p>
<p><a name=\"annotation_comment\" class=\"NAME\"><em>annotation_comment</em></a>:
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tt><strong>annotation</strong><tt>&nbsp;</tt><a href=\"#class_modification\" class=\"HREF\"><em>class_modification</em></a>
</p>
</body></html>"));
end ModelicaGrammar;

package Annotations "Annotations"
  extends ModelicaReference.Icons.Information;
  class absoluteValue "absoluteValue"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
A simple type or component of a simple type may have the annotation <code>absoluteValue</code>.
Note that this is only relevant for components of a few specific types.
</p>
<p>
If <code>false</code>, then the variable defines a relative quantity, and if <code>true</code> an absolute quantity.
</p>

<h4>Syntax</h4>

<blockquote><pre>
   <strong>annotation</strong>\"(\" absoluteValue \"=\" ( <strong>false</strong> | <strong>true</strong> ) \")
</pre></blockquote>

<h4>Description</h4>

<p>
When converting between units (in the user-interface for plotting and entering parameters), the offset must be ignored, for a variable defined with annotation <code>absoluteValue = false</code>.
</p>

<h4>Example usage</h4>
<p>
This annotation is used in the Modelica Standard Library for example in <a href=\"modelica://Modelica.Units.SI\">Modelica.Units.SI</a> for the type definition TemperatureDifference.
</p>
</html>"));
  end absoluteValue;

  class choices "choices"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define graphical layout of choices in a parameter menu
</p>

<h4>Description</h4>
<p>
A declaration can have an annotation <code>choices</code> containing modifiers on choice, where each of them indicates a suitable redeclaration or modifications of the element.
This is a hint for users of the model, and can also be used by the user interface to suggest reasonable redeclaration, where the string comments on the choice declaration can be used as textual explanations of the choices.  The annotation is not restricted to replaceable elements but can also be applied to non-replaceable elements, enumeration types, and simple variables.
</p>
<p>
For a Boolean variable, a <code>choices</code> annotation may contain the definition <code>checkBox = true</code>, meaning to display a checkbox to input the values <code>false</code> or <code>true</code> in the graphical user interface.
</p>

<h4>Examples</h4>
<blockquote><pre>
<strong>replaceable model</strong> MyResistor=Resistor
  <strong>annotation</strong>(choices(
              choice(redeclare MyResistor=lib2.Resistor(a={2}) \"...\"),
              choice(redeclare MyResistor=lib2.Resistor2 \"...\")));

<strong>replaceable</strong> Resistor Load(R=2) constrainedby TwoPin
  <strong>annotation</strong>(choices(
              choice(redeclare lib2.Resistor Load(a={2}) \"...\"),
              choice(redeclare Capacitor Load(L=3) \"...\")));

<strong>replaceable</strong> FrictionFunction a(func=exp) constrainedby Friction
  <strong>annotation</strong>(choices(
             choice(redeclare ConstantFriction a(c=1) \"...\"),
             choice(redeclare TableFriction a(table=\"...\") \"...\"),
             choice(redeclare FunctionFriction a(func=exp) \"...\"))));

<strong>type</strong> KindOfController=Integer(min=1,max=3)
   <strong>annotation</strong>(choices(
                choice=1 \"P\",
                choice=2 \"PI\",
                choice=3 \"PID\"));

<strong>model</strong> A
  KindOfController x;
<strong>end</strong> A;
A a(x=3 \"PID\");
</pre></blockquote>
<p>
It can also be applied to Boolean variables to define a check box:
</p>
<blockquote><pre>
  <strong>parameter</strong> Boolean useHeatPort=false <strong>annotation</strong>(choices(checkBox=true));
</pre></blockquote>
</html>"));
  end choices;

  class choicesAllMatching "choicesAllMatching"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Automatically display a list of matching choices in a graphical parameter menu.
</p>

<h4>Description</h4>
<p>
Choices menus of replaceable elements can be automatically constructed showing the names of all classes that are either directly or indirectly derived by inheritance from the constraining class of the declaration.
</p>
<p>
This can be recommended by having <code><strong>annotation</strong> choicesAllMatching = true;</code> and disabled by having <code><strong>annotation</strong> choicesAllMatching = false;</code>.
</p>

<h4>Examples</h4>
<blockquote><pre>
<strong>replaceable package</strong> Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
                             <strong>constrainedby</strong> Modelica.Media.Interfaces.PartialMedium
                             <strong>annotation</strong> (choicesAllMatching=true);
</pre></blockquote>
</html>"));
  end choicesAllMatching;

  class dateModified "dateModified"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>UTC date and time of the latest change to the package in the following format (with one space between date and time):<br>
&nbsp;&nbsp;<code>YYYY-MM-DD hh:mm:ssZ</code></p>
<h4>Syntax</h4>
<blockquote><pre>
<strong>annotation</strong>&quot;(&quot; dateModified &quot;=&quot; STRING &quot;)&quot;
</pre></blockquote>
<h4>Description</h4>
<p>
&ldquo;<code>dateModified</code>&rdquo; is the UTC date and time (according to <a href=\"http://en.wikipedia.org/wiki/ISO_8601\">ISO 8601</a>) of the last modification of the package.
<em>The intention is that a Modelica tool updates this annotation whenever the package or part of it was modified and is saved on persistent storage (like file or database system).</em>
</p>
<h4>Examples</h4>
<blockquote><pre>
<strong>package</strong> Modelica
  <strong>annotation</strong>(version      = &quot;3.0.1&quot;,
             versionDate  = &quot;2008-04-10&quot;,
             <em>dateModified = &quot;2009-02-15 16:33:14Z&quot;</em>,
             revisionId   = &quot;c04e23a0d 2018-08-01 12:00:00 +0200&quot;);
  ...
  <strong>end</strong> Modelica;
</pre></blockquote>
<h5>Related annotations</h5>
<ul>
  <li><a href=\"modelica://ModelicaReference.Annotations.revisionId\">revisionId</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.uses\">uses</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.version\">version</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.versionDate\">versionDate</a></li>
</ul>
</html>"));
  end dateModified;

  class defaultComponentName "defaultComponentName"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Default name when dragging component
</p>

<h4>Syntax</h4>

<blockquote><pre>   <strong>annotation</strong>\"(\" defaultComponentName \"=\" STRING \")\"
</pre></blockquote>

<h4>Description</h4>

<p>
When creating a component of the given class, the recommended component name is the
given string.
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

<blockquote><pre><strong>annotation</strong>(defaultComponentPrefixes=\"inner\",
           defaultComponentName=\"world\")
</pre></blockquote>

<h4>Syntax</h4>

<blockquote><pre>   <strong>annotation</strong>\"(\" defaultComponentPrefixes \"=\" STRING \")\"
</pre></blockquote>

<h4>Description</h4>

<p>
The following prefixes may be included in the string prefixes: inner, outer, replaceable, constant, parameter, discrete. In combination with defaultComponentName it can be used to make it easy for users to create inner components matching the outer declarations.
</p>

</html>"));
  end defaultComponentPrefixes;

  class defaultConnectionStructurallyInconsistent
    "defaultConnectionStructurallyInconsistent"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
A model or block definition may contain the annotation <code>defaultConnectionStructurallyInconsistent</code>.
</p>

<h4>Syntax</h4>

<blockquote><pre>
   <strong>annotation</strong>\"(\" defaultConnectionStructurallyInconsistent \"=\" ( <strong>false</strong> | <strong>true</strong> ) \")
</pre></blockquote>

<h4>Description</h4>

<p>
If <code>true</code>, it is stated that a default connection will result in a structurally inconsistent <code>model</code> or <code>block</code>.
A \"default connection\" is constructed by instantiating the respective <code>model</code> or <code>block</code> and for every input <code>u</code> providing an equation <code>0=f(u)</code>, and for every (potential,flow) pair of the form <code>(v,i)</code>, providing an equation of the form <code>0=f(v,i)</code>.
</p>

<h4>Example usage</h4>
<p>
It is useful to check all models/blocks of a Modelica package in a simple way. One check is to default connect every model/block and to check whether the resulting class is structurally consistent (= a stronger requirement as \"balanced\").
</p>
<p>
It is rarely needed; but can be used for InverseBlockConstraints, in order to prevent a wrong error message.
Additionally, when a user defined model is structurally inconsistent, a tool should try to pinpoint in which class the error is present.
This annotation avoids then to show a wrong error message.
</p>
</html>"));
  end defaultConnectionStructurallyInconsistent;

  class derivative "derivative"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define derivative of function
</p>

<h4>Examples</h4>

<blockquote><pre><strong>function</strong> foo0 <strong>annotation</strong>(derivative=foo1); <strong>end</strong> foo0;
<strong>function</strong> foo1 <strong>annotation</strong>(derivative(order=2)=foo2); <strong>end</strong> foo1;
<strong>function</strong> foo2 <strong>end</strong> foo2;
</pre></blockquote>

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

<blockquote><pre> function foo0
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
</pre></blockquote>

<p>
the equation
</p>

<blockquote><pre>(...,y(t),...)=foo0(...,x(t),b,...);
</pre></blockquote>

<p>
implies that:
</p>

<blockquote><pre>(...,d y(t)/dt,...)=foo1(...,x(t),b,..., ...,d x(t)/dt,...);
(...,d^2 y(t)/dt^2,...)=foo2(...,x(t),b,...,d x(t)/dt,..., ...,d^2 x(t)/dt^2,...);
</pre></blockquote>

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
<blockquote><pre>function f \"Simple table lookup\"
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

</pre></blockquote></li>

<li> noDerivative(input_var2 = f(input_var1, ...) )<br>
    The derivative function is only valid if the input argument input_var2
    is computed as f(input_var1, ...). The derivative of input_var2
    is excluded from the argument list of the derivative-function.
    Assume that function fg is defined as a composition f(x, g(x)).
    When differentiating f it is useful to give the derivative under the
    assumption that the second argument is defined in this way:
<blockquote><pre>function fg
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
</pre></blockquote>
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
<blockquote><pre><strong>annotation</strong>(<strong>Dialog</strong>(<strong>enable</strong> = true,
                     <strong>tab</strong> = \"General\",
                   <strong>group</strong> = \"Parameters\",
      <strong>showStartAttribute</strong> = false,
           <strong>colorSelector</strong> = false,
              <strong>groupImage</strong> = \"modelica://MyPackage/Resources/Images/image.png\",
         <strong>connectorSizing</strong> = false));
</pre></blockquote>

<h4>Description</h4>
<p>
The annotations <strong><code>tab</code></strong> and <strong><code>group</code></strong> define the placement of the component or of variables in a dialog with optional tab and group specification. If <code><strong>enable</strong> = false</code>, the input field may be disabled [and no input can be given]. If <code><strong>showStartAttribute</strong> = true</code> the dialog should allow the user to set the start-value and the fixed attribute for the variable instead of the value-attribute [this is primarily intended for non-parameter values and avoids introducing a separate parameter for the start-value of the variable].
</p>
<p>
If <code>colorSelector=true</code>, it indicates that an rgb-value selector can be presented for a vector of  three elements and generate values <code>0..255</code> (the annotation should be usable both for vectors of Integers and Reals).
</p>
<p>
The annotation <strong><code>groupImage</code></strong> references an image using an Modelica URI, and the image is intended to be shown together with the parameter-group (only one image per group is supported). Disabling the input field will not disable the image.
</p>
<p>
The value of the <strong><code>connectorSizing</code></strong> annotation must be a literal false or true value [since if the value is an expression, the <code>connectorSizing</code> functionality is conditional and this will then lead easily to wrong models]. If <code>connectorSizing = false</code>, this annotation has no effect. If <code>connectorSizing = true</code>, the corresponding variable must be declared with the parameter prefix, must be a subtype of a scalar Integer and must have a literal default value of zero [since this annotation is designed for a parameter that is used as vector dimension and the dimension of the vector should be zero when the component is dragged or redeclared; furthermore, when a tool does not support the connectorSizing annotation, dragging will still result in a correct model].
If <code>connectorSizing = true</code>, a tool may set the parameter value in a modifier automatically, if used as dimension size of a vector of connectors. [The <code>connectorSizing</code> annotation is used in cases where connections to a vector of connectors shall be made and a new connection requires to resize the vector and to  connect  to the new index (unary connections). The annotation allows a tool to perform these two actions in many cases automatically. This is, e.g., very useful for state machines and for certain components of fluid libraries.]
</p>
<p>
Annotation \"Dialog\" is defined as:
</p>
<blockquote><pre><strong>record</strong> Dialog
  <strong>parameter</strong> String  tab                = \"General\";
  <strong>parameter</strong> String  group              = \"Parameters\";
  <strong>parameter</strong> String  groupImage         = \"\";
  <strong>parameter</strong> Boolean enable             = <strong>true</strong>;
  <strong>parameter</strong> Boolean showStartAttribute = <strong>false</strong>;
  <strong>parameter</strong> Boolean connectorSizing    = <strong>false</strong>;
  <strong>parameter</strong> Boolean colorSelector      = <strong>false</strong>;
  <strong>parameter</strong> Selector loadSelector;
  <strong>parameter</strong> Selector saveSelector;
<strong>end</strong> Dialog;

<strong>record</strong> Selector
  <strong>parameter</strong> String filter=\"\";
  <strong>parameter</strong> String caption=\"\";
<strong>end</strong> Selector;
</pre></blockquote>

<h4>Examples</h4>
<p>
A parameter dialog is a sequence of tabs with a sequence of groups inside them.
</p>
<p>
A <code>Selector</code> displays a file dialog to select a file: Parameter <code>filter</code> only shows files that fulfill the given pattern defined by \"<code>text1 (*.ext1);;text2 (*.ext2);</code>\" to show only files with file extension <code>*.ext1</code> or <code>*.ext2</code> and displaying a description text \"<code>text1</code>\" and \"<code>text2</code>\", respectively. Parameter caption is the text displayed in the dialog menu. Parameter <code>loadSelector</code> is used to select an existing file for reading, whereas parameter <code>saveSelector</code> is used to define a file for writing.
</p>

<blockquote><pre><strong>model</strong> DialogDemo
  <strong>parameter</strong> Boolean b = true \"Boolean parameter\";
  <strong>parameter</strong> Modelica.Units.SI.Length length \"Real parameter with unit\";
  <strong>parameter</strong> Integer nInports=0 annotation(Dialog(connectorSizing=true));
  <strong>parameter</strong> Real r1 \"Real parameter in Group 1\" annotation(Dialog(group=\"Group 1\"));
  <strong>parameter</strong> Real r2 \"Disabled Real parameter in group 1\"
                     <strong>annotation</strong>(<strong>Dialog</strong>(<strong>group</strong>=\"Group 1\", <strong>enable</strong> = <strong>not</strong> b));
  <strong>parameter</strong> Real r3 \"Real parameter in Tab 1\" <strong>annotation</strong>(<strong>Dialog</strong>(<strong>tab</strong>=\"Tab 1\"));
  <strong>parameter</strong> Real r4 \"Real parameter in Tab 1 and Group 2\"
                     <strong>annotation</strong>(<strong>Dialog</strong>(<strong>tab</strong>=\"Tab 1\", <strong>group</strong>=\"Group 2\"));
  StepIn stepIn[nInports];
  ...
<strong>end</strong> DialogDemo;
</pre></blockquote>
</html>"));
  end Dialog;

  class Documentation "Documentation"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Annotations for documentation
</p>
<h4>Syntax</h4>
<blockquote><pre>
documentation_annotation:
   <strong>annotation</strong>\"(\" Documentation \"(\" \"info\" \"=\" STRING
                            [\",\" \"revisions\" \"=\" STRING ] \")\" \")\"
</pre></blockquote>
<h4>Description</h4>
<p>
The \"Documentation\" annotation can contain the \"info\" annotation giving a textual description, the \"revisions\" annotation giving a list of revisions and other annotations defined by a tool [The \"revisions\" documentation may be omitted in printed documentation]. How the tool interprets the information in \"Documentation\" is unspecified. Within a string of the \"Documentation\" annotation, the tags &lt;HTML&gt; and &lt;/HTML&gt; or &lt;html&gt; and &lt;/html&gt; define the start and end of content that is HTML encoded. Links to Modelica classes may be defined with the HTML link command using scheme \"Modelica\", e.g.,
</p>
<blockquote><pre>
    &lt;a href=\"modelica://ExamplePackage.Tutorial\"&gt;ExamplePackage.Tutorial&lt;/a&gt;
</pre></blockquote>
<p>
Together with scheme \"Modelica\" the (URI)  fragment specifiers #diagram, #info, #text, #icon may be used to reference different layers. Example:
</p>
<blockquote><pre>
   &lt;a href=\"modelica://ExamplePackage.SimpleModel#info\"&gt;SimpleModel&lt;/a&gt;
</pre></blockquote>
</html>"));
  end Documentation;

class DocumentationClass "DocumentationClass"
  extends ModelicaReference.Icons.Information;

  annotation (Documentation(info="<html>
<p>
Annotation for defining documentation classes
</p>

<h4>Syntax</h4>

<blockquote><pre>documentation class_annotation:
   <strong>annotation</strong>\"(\" DocumentationClass \"=\" <strong>true</strong> \")\"
</pre></blockquote>

<h4>Description</h4>

<p>
Only allowed as class annotation on any kind of class and implies that this class and all
classes within it are treated as having the annotation preferredView=\"info\".
If the annotation preferredView is explicitly set for a class, it has precedence over
a DocumentationClass annotation.
</p>

<p><em>
[A tool may display such classes in special ways. For example, the
description texts of the classes might be  displayed instead of the class
names, and if no icon is defined, a special information default icon may be
displayed in the package browser.]
</em></p>
</html>"));
end DocumentationClass;

  class DynamicSelect "DynamicSelect"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define schematic animation of diagram layer
</p>

<h4>Examples</h4>

<p>
The level of a tank is animated by a rectangle expanding in vertical direction and its color depending on a variable overflow:
</p>

<blockquote><pre><strong>annotation</strong>(
  Icon(graphics={Rectangle(
    extent=<strong>DynamicSelect</strong>({{0,0},{20,20}},{{0,0},{20,level}}),
    fillColor=<strong>DynamicSelect</strong>({0,0,255},
                            <strong>if</strong> overflow <strong>then</strong> {255,0,0} <strong>else</strong> {0,0,255}))}
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

<blockquote><pre>   <strong>annotation</strong>\"(\" Evaluate \"=\" ( <strong>false</strong> | <strong>true</strong> ) \")
</pre></blockquote>

<h4>Description</h4>
<p>
The annotation Evaluate can occur in the component declaration, its type declaration, or a base-class of the type-declaration.
In the case of multiple conflicting annotations it is handled similarly to modifiers (e.g., an Evaluate-annotation on the component declaration takes precedence).
The annotation Evaluate only has effect for a component declared with the prefix <code>parameter</code>.
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

<blockquote><pre><strong>annotation</strong>(experiment(StartTime=0, StopTime=5, Tolerance=1e-6))
</pre></blockquote>

<h4>Syntax</h4>

<blockquote><pre>experiment_annotation:
   <strong>annotation</strong>\"(\" \"experiment\" \"(\" [experimentOption] {, experimentOption}] \")\"

experimentOption:
   StartTime  \"=\" [\"+\" | \"-\"] UNSIGNED_NUMBER |
   StopTime   \"=\" [\"+\" | \"-\"] UNSIGNED_NUMBER |
   Interval   \"=\" UNSIGNED_NUMBER
   Tolerance  \"=\" UNSIGNED_NUMBER
</pre></blockquote>

<h4>Description</h4>
<p>
The experiment annotation defines the default start time (<code>StartTime</code>) in [s], the default stop time (<code>StopTime</code>) in [s], the suitable time resolution for the result grid (<code>Interval</code>) in [s], and the default relative integration tolerance (<code>Tolerance</code>) for simulation experiments to be carried out with the model or block at hand.
</p>
</html>"));
  end experiment;

  class HideResult "HideResult"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Annotation for code generation (hide result)
</p>

<h4>Syntax</h4>

<blockquote><pre>   <strong>annotation</strong>\"(\" HideResult \"=\" ( <strong>false</strong> | <strong>true</strong> ) \")
</pre></blockquote>

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

<blockquote><pre>
   <strong>annotation</strong>\"(\" Inline \"=\" ( <strong>false</strong> | <strong>true</strong> ) \")
</pre></blockquote>

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

<h4>Example usage</h4>

<p>
Inline = true is for example used in  <a href=\"modelica://Modelica.Mechanics.MultiBody.Frames\">Modelica.Mechanics.MultiBody.Frames</a> and in functions of <a href=\"modelica://Modelica.Media\">Modelica.Media</a> to have no overhead for function calls such as resolving a vector in a different coordinate system and at the same time the function can be analytically differentiated, e.g., for index reduction needed for mechanical systems.
</p>
</html>"));
  end Inline;

  class InlineAfterIndexReduction "InlineAfterIndexReduction"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Annotation for code generation
</p>

<h4>Syntax</h4>

<blockquote><pre>
   <strong>annotation</strong>\"(\" InlineAfterIndexReduction \"=\" ( <strong>false</strong> | <strong>true</strong> ) \")
</pre></blockquote>

<h4>Description</h4>

<p>
Has only an effect within a function declaration.
If true, the model developer proposes to inline the function after the function is differentiated for index reduction, and before any other symbolic transformations are performed.
</p>
<p>
<em>This annotation cannot be combined with annotations <a href=\"modelica://ModelicaReference.Annotations.Inline\">Inline</a> and <a href=\"modelica://ModelicaReference.Annotations.LateInline\">LateInline</a>!</em>
</p>

<h4>Example usage</h4>
<p>
<code>InlineAfterIndexReduction = true</code> is for example used in <a href=\"modelica://Modelica.Mechanics.Rotational.Components.AngleToTorqueAdaptor\">Modelica.Mechanics.Rotational.Components.AngleToTorqueAdaptor</a> to define that an input signal is the derivative of another input signal.
</p>
</html>"));
  end InlineAfterIndexReduction;

    class inverse "inverse"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>Every function with one output argument may have one or more &quot;<code>inverse</code>&quot; annotations to define inverses of this function.</p>
<h4>Syntax</h4>
<blockquote><pre><strong>function</strong> f1
  <strong>input</strong> A1 u1;
  ...
  <strong>input</strong> T1 uk;
  ...
  <strong>input</strong> Am um = am;
  ...
  <strong>input</strong> An un;
  <strong>output</strong> T2 y;
  <strong>annotation</strong>(<strong>inverse</strong>(uk = f2(..., y, ....), ui = f3(..., y, ...), ...));
<strong>algorithm</strong>
  ...
<strong>end</strong> f1;</pre></blockquote>
<h4>Description</h4>
<p>The meaning is that function &quot;<code>f2</code>&quot; is one inverse to function &quot;<code>f1</code>&quot; where the previous output &quot;<code>y</code>&quot; is now an input and the previous input &quot;<code>uk</code>&quot; is now an output. More than one inverse can be defined within the same inverse annotation. Several inverses are separated by commas. <em>(The inverse requires that for all valid values of the input arguments of <code>f2(...,y, ...)</code> and <code>uk</code> being calculated as <code>uk := f2(..., y, ...)</code> implies the equality <code>y = f1(..., uk, ...,) </code>up to a certain precision.)</em></p>
<p>Function &quot;<code>f1</code>&quot; can have any number and types of arguments with and without default value. The restriction is that the number of unknown variables in the output argument of both &quot;<code>f1</code>&quot; and &quot;<code>f2</code>&quot; must be the same and that &quot;<code>f2</code>&quot; must have exactly the same arguments as &quot;<code>f1</code>&quot; (with the same defaults, if an argument um has a default), but the order of the arguments may be permuted.</p>
<h4>Examples</h4>
<blockquote><pre><strong>function</strong> h_pTX
  <strong>input</strong> Real p    &quot;pressure&quot;;
  <strong>input</strong> Real T    &quot;temperature&quot;;
  <strong>input</strong> Real X[:] &quot;mass fractions&quot;;
  <strong>output</strong> Real h   &quot;specific enthalpy&quot;;
  <strong>annotation</strong>(<strong>inverse</strong>(T = T_phX(p,h,X)));
<strong>algorithm</strong>
  ...
<strong>end</strong> h_pTX;

<strong>function</strong> T_phX
  <strong>input</strong> Real  p    &quot;pressure&quot;;
  <strong>input</strong> Real  h    &quot;specific enthalpy&quot;;
  <strong>input</strong> Real  X[:] &quot;mass fractions&quot;;
  <strong>output</strong> Real T    &quot;temperature&quot;;
<strong>algorithm</strong>
  ...
<strong>end</strong> T_phX;</pre></blockquote>
</html>"));
  end inverse;

  class LateInline "LateInline"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Annotation for code generation (inline function body after symbolic processing)
</p>

<h4>Syntax</h4>

<blockquote><pre>   <strong>annotation</strong>\"(\" LateInline \"=\" ( <strong>false</strong> | <strong>true</strong> ) \")
</pre></blockquote>

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

<h4>Example usage</h4>
<p>
This annotation is for example used in  <a href=\"modelica://Modelica.Media.Water.IF97_Utilities.T_props_ph\">Modelica.Media.Water.IF97_Utilities.T_props_ph</a> to provide in combination with common subexpression elimination the automatic caching of function calls. Furthermore, it is used in order that a tool is able to propagate specific enthalpy over connectors in the <a href=\"modelica://Modelica.Fluid\">Modelica.Fluid</a> library.
</p>
</html>"));
  end LateInline;

  class missingInnerMessage "missingInnerMessage"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Diagnostic message, if inner declaration is missing
</p>

<h4>Examples</h4>

<blockquote><pre><strong>model</strong> World
  <strong>annotation</strong>(defaultComponentName     = \"world\",
             defaultComponentPrefixes = \"inner replaceable\",
             missingInnerMessage      = \"The World object is missing\");
  ...
<strong>end</strong> World;
</pre></blockquote>

<h4>Syntax</h4>

<blockquote><pre>   <strong>annotation</strong>\"(\" missingInnerMessage \"=\" STRING \")\"
</pre></blockquote>

<h4>Description</h4>

<p>
When an outer component of the class does not have a corresponding inner component, the string message may be used as a diagnostic message.
However, the inner component is automatically added - if unique - regardless of this annotation.
</p>

</html>"));
  end missingInnerMessage;

  class obsolete "obsolete"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
A class may have the following annotation:
</p>
<blockquote><pre>
    annotation(obsolete = \"message\");
</pre></blockquote>

<h4>Syntax</h4>

<blockquote><pre>
   <strong>annotation</strong>\"(\" obsolete \"=\" STRING \")\"
</pre></blockquote>

<h4>Description</h4>

<p>
It indicates that the class ideally should not be used anymore and gives a message indicating the recommended action.
</p>
</html>"));
  end obsolete;

  class preferredView "preferredView"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define default view when selecting class
</p>

<h4>Syntax</h4>

<blockquote><pre>preferred view_annotation:
   <strong>annotation</strong>\"(\" preferredView \"=\" (\"info\" | \"diagram\" | \"text\") \")\"
</pre></blockquote>

<h4>Description</h4>

<p>
The preferredView annotation defines the default view when selecting the class. info means info layer, i.e., the documentation of the class, diagram means diagram layer and text means the Modelica text layer.
</p>

</html>"));
  end preferredView;

  class revisionId "revisionId"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>Revision identifier of the <a href=\"https://en.wikipedia.org/wiki/Version_control\">version management system</a> used to manage this library. It marks the latest submitted change to any file belonging to the package.</p>
<h4>Syntax</h4>
<blockquote><pre>
<strong>annotation</strong>&quot;(&quot; revisionId &quot;=&quot; STRING &quot;)&quot;
</pre></blockquote>
<h4>Description</h4>
<p>
&ldquo;<code>revisionId</code>&rdquo; is a tool specific revision identifier possibly generated by a source code management system (e.g., <a href=\"http://subversion.apache.org\">Subversion</a> or <a href=\"http://en.wikipedia.org/wiki/Git\">Git</a>). This information allows to exactly identify the library source code in the source code management system.
</p>
<h4>Examples</h4>
<blockquote><pre><strong>package</strong> Modelica
  <strong>annotation</strong>(version      = &quot;3.2.3&quot;,
             versionDate  = &quot;2018-08-01&quot;,
             dateModified = &quot;2018-12-12 07:40:19Z&quot;,
             <em>revisionId   = &quot;c04e23a0d 2018-08-01 12:00:00 +0200&quot;</em>);
  ...
  <strong>end</strong> Modelica;</pre></blockquote>
<h5>Related annotations</h5>
<ul>
  <li><a href=\"modelica://ModelicaReference.Annotations.version\">version</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.versionDate\">versionDate</a></li>
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

<h4>Syntax</h4>
<blockquote><pre>
   <strong>annotation</strong>\"(\" smoothOrder \"=\" UNSIGNED_INTEGER \")\"
   <strong>annotation</strong>\"(\" smoothOrder \"(\" normallyConstant=NAME [\",\" normallyConstant=NAME] \")\"
                             \"=\" UNSIGNED_NUMBER \")\"
</pre></blockquote>

<h4>Description</h4>
<p>
This annotation has only an effect within a function declaration.
</p>

<p>
smoothOrder defines the number of differentiations of the function, in order that all of the differentiated outputs are continuous provided all input arguments and their derivatives up to order smoothOrder are continuous.
</p>

<p>
This means that the function is at least C<sup>smoothOrder</sup>. smoothOrder = 1 means that the function can be differentiated at least once in order that all output arguments are still continuous, provided the input arguments are continuous. If a tool needs the derivative of a function, e.g., for index reduction or to compute an analytic Jacobian, the function can be differentiated analytically at most smoothOrder times.
</p>
<p>
The optional argument <code>normallyConstant</code> of <code>smoothOrder</code> defines that the function argument <code>NAME</code> is usually constant.
</p>

<h4>Examples</h4>
<p>
This annotation is used by many functions of the <a href=\"modelica://Modelica.Fluid\">Modelica.Fluid</a> library, such as <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_DP\">Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_DP</a>, since geometric arguments to these functions are usually constant.
</p>
<blockquote><pre>
<strong>function</strong> SpecialPolynomial
  <strong>input</strong>  Real u;
  <strong>output</strong> Real y;
<strong>algorithm</strong>
   y = <strong>if</strong> u > 0 <strong>then</strong> u^2 <strong>else</strong> 0;
  <strong>annotation</strong>(smoothOrder = 1);
<strong>end</strong> SpecialPolynomial;

<strong>model</strong> TestSpecialPolynomial
   Real y;
   Real yd;
   Real ydd;
<strong>equation</strong>
   y   = SpecialPolynomial(sin(time));
   yd  = <strong>der</strong>(y);     // fine, SpecialPolynomial is analytically differentiated once
   ydd = <strong>der</strong>(yd);    // error, SpecialPolynomial cannot be differentiated twice
<strong>end</strong> TestSpecialPolynomial;
</pre></blockquote>
</html>"));
  end smoothOrder;

  class unassignedMessage "unassignedMessage"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Error message, if variable is not assigned
</p>

<h4>Examples</h4>

<blockquote><pre><strong>connector</strong> Frame \"Frame of a mechanical system\"
    ...
  <strong>flow</strong> Modelica.Units.SI.Force f[3] <strong>annotation</strong>(unassignedMessage =
\"All Forces cannot be uniquely calculated. The reason could be that the
mechanism contains a planar loop or that joints constrain the same motion.
For planar loops, use in one revolute joint per loop the option
PlanarCutJoint=true in the Advanced menu.
\");
<strong>end</strong> Frame;
</pre></blockquote>

<h4>Syntax</h4>

<blockquote><pre>
   <strong>annotation</strong>\"(\" unassignedMessage \"=\" STRING \")\"
</pre></blockquote>

<h4>Description</h4>

<p>
When the variable to which this annotation is attached in the declaration cannot be computed due to the structure of the equations, the string message can be used as a diagnostic message. When using BLT partitioning, this means if a variable \"a\" or one of its aliases \"b = a\", \"b = -a\", cannot be assigned, the message is displayed. This annotation is used to provide library specific error messages.
</p>
</html>"));
  end unassignedMessage;

  class uses "uses"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Defines that classes within this top-level class uses a specific version of another top-level class
</p>

<h4>Examples</h4>

<blockquote><pre>
<strong>model</strong> A
  <strong>annotation</strong>(version=\"1.0\",
     uses(Modelica(version=\"1.5\")));
  ...
<strong>end</strong> A;

<strong>model</strong> B
  <strong>annotation</strong>(uses(Modelica(version=\"2.1 Beta 1\")));
  ...
<strong>end</strong> B;
</pre></blockquote>

<h4>Description</h4>

<ul>
<li> <code>uses(IDENT (version = VERSION-NUMBER) )</code><br>
     Defines that classes within this top-level class uses version
     VERSION-NUMBER of classes within the top-level class IDENT.
     The annotations uses and conversion may contain several different sub-entries.</li>
</ul>

<h5>Related annotations</h5>
<ul>
  <li><a href=\"modelica://ModelicaReference.Annotations.dateModified\">dateModified</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.revisionId\">revisionId</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.version\">version</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.versionDate\">versionDate</a></li>
</ul>
</html>"));
  end uses;

  class version "version"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define version information of package
</p>

<h4>Examples</h4>

<blockquote><pre><strong>package</strong> Modelica
  <strong>annotation</strong>(version=\"2.1\",
             conversion(noneFromVersion=\"2.1 Beta 1\",
                        from(version=\"1.5\",
                             script=\"convertFromModelica1_5.mos\")));
  ...
<strong>end</strong> Modelica;

<strong>model</strong> A
  <strong>annotation</strong>(version=\"1.0\",
     uses(Modelica(version=\"1.5\")));
  ...
<strong>end</strong> A;

<strong>model</strong> B
  <strong>annotation</strong>(uses(Modelica(version=\"2.1 Beta 1\")));
  ...
<strong>end</strong> B;
</pre></blockquote>

<p>
In this example the model A uses an older version of the Modelica library and can be upgraded using the given script, and model B uses an older version of the Modelica library but no changes are required when upgrading.
</p>

<h4>Description</h4>

<p>
Version numbers are of the forms:
</p>

<ul>
<li> Main release versions:
     <blockquote><pre>\"\"\" UNSIGNED_INTEGER { \".\" UNSIGNED_INTEGER } \"\"\"</pre></blockquote>
     Example: <code>\"2.1\"</code><br>&nbsp;</li>

<li> Pre-release versions:
     <blockquote><pre>\"\"\" UNSIGNED_INTEGER { \".\" UNSIGNED_INTEGER } \" \" {S-CHAR} \"\"\"</pre></blockquote>
     Example: <code>\"2.1 Beta 1\"</code><br>&nbsp;</li>

<li> Un-ordered versions:
     <blockquote><pre> \"\"\" NON-DIGIT {S-CHAR} \"\"\" </pre></blockquote>
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

<li> <code>conversion ( from (version = VERSION-NUMBER, [to = VERSION_NUMBER \",\"] script = \"?\" ) ) </code><br>
     Defines that user models using the VERSION-NUMBER or any of the given VERSION-NUMBER can be upgraded to the given VERSION-NUMBER
     (if the to-tag is missing this is the CURRENT-VERSION-NUMBER) of the current class by applying the given conversion rules.
     <em>The to-tag is added for clarity and optionally allows a tool to convert in multiple steps.</em>
     <br>&nbsp;</li>

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
<h5>Related annotations</h5>
<ul>
  <li><a href=\"modelica://ModelicaReference.Annotations.dateModified\">dateModified</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.revisionId\">revisionId</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.uses\">uses</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.version\">version</a></li>
</ul>
</html>"));
  end version;

  class versionBuild "versionBuild"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>Defines the optional build number of the library.</p>

<blockquote>
<em>This is a <strong>deprecated</strong> annotation. It should no longer be used, since it will be removed in one of the next Modelica releases. Use instead <a href=\"https://semver.org/\">Semantic Versioning</a> which provides a better mechanism for maintaining releases and bug-fixes in a well defined way.</em>
</blockquote>

<h4>Syntax</h4>
<blockquote><pre>
<strong>annotation</strong>&quot;(&quot; versionBuild &quot;=&quot; INTEGER &quot;)&quot;
</pre></blockquote>
<h4>Description</h4>
<p>&ldquo;<code>versionBuild</code>&rdquo; is the optional build number of the library.
When a new version is released &ldquo;<code>versionBuild</code>&rdquo; should be omitted or &ldquo;<code>versionBuild = 1</code>&rdquo;.
There might be bug fixes to the library that do not justify a new library version.
Such maintenance changes are called a &ldquo;build&rdquo; release of the library.
For every new maintenance change, the &ldquo;<code>versionBuild</code>&rdquo; number is increased.
A &ldquo;<code>versionBuild</code>&rdquo; number A that is higher as &ldquo;<code>versionBuild</code>&rdquo; number B, is a newer release of the library. There are no conversions between the same versions with different build numbers.
</p>
<h4>Examples</h4>
<blockquote><pre>
<strong>package</strong> Modelica
  <strong>annotation</strong>(version      = &quot;3.0.1&quot;,
             versionDate  = &quot;2008-04-10&quot;,
             <em>versionBuild = 4</em>,
             dateModified = &quot;2009-02-15 16:33:14Z&quot;,
             revisionId   = &quot;c04e23a0d 2018-08-01 12:00:00 +0200&quot;);
  ...
  <strong>end</strong> Modelica;
</pre></blockquote>
<h5>Related annotations</h5>
<ul>
  <li><a href=\"modelica://ModelicaReference.Annotations.dateModified\">dateModified</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.revisionId\">revisionId</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.uses\">uses</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.version\">version</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.versionDate\">versionDate</a></li>
</ul>
</html>"));
  end versionBuild;

  class versionDate "versionDate"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>UTC date of first version build (in format: <code>YYYY-MM-DD</code>).</p>
<h4>Syntax</h4>
<blockquote><pre>
<strong>annotation</strong>&quot;(&quot; versionDate &quot;=&quot; STRING &quot;)&quot;
</pre></blockquote>
<h4>Description</h4>
<p>&ldquo;<code>versionDate</code>&rdquo; is the date in UTC format (according to <a href=\"http://en.wikipedia.org/wiki/ISO_8601\">ISO 8601</a>) when the library was released.</p>
<h4>Examples</h4>
<blockquote><pre>
<strong>package</strong> Modelica
  <strong>annotation</strong>(version      = &quot;3.0.1&quot;,
             <em>versionDate  = &quot;2008-04-10&quot;</em>,
             dateModified = &quot;2009-02-15 16:33:14Z&quot;,
             revisionId   = &quot;c04e23a0d 2018-08-01 12:00:00 +0200&quot;);
  ...
  <strong>end</strong> Modelica;</pre></blockquote>
<h5>Related annotations</h5>
<ul>
  <li><a href=\"modelica://ModelicaReference.Annotations.uses\">uses</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.version\">version</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.dateModified\">dateModified</a></li>
  <li><a href=\"modelica://ModelicaReference.Annotations.revisionId\">revisionId</a></li>
</ul>
</html>"));
  end versionDate;

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
Define specialized class <em>block</em>
</p>
<h4>Examples</h4>

<blockquote><pre><strong>block</strong> Integrator
  <strong>input</strong> Real u;
  <strong>output</strong> Real y;
<strong>protected</strong>
  Real x;
<strong>equation
  der</strong>(x) = u;
  y = x;
<strong>end</strong> Integrator;</pre></blockquote>

<h4>Syntax</h4>

<blockquote><pre>   [ <strong>encapsulated</strong> ][ <strong>partial</strong>] <strong>block</strong>
   IDENT class_specifier

class_specifier :
   string_comment composition <strong>end</strong> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <strong>enumeration</strong> \"(\" ( [enum_list] | \":\" ) \")\" comment</pre></blockquote>

<p>See <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica Grammar</a> for further details.</p>

<h4>Description</h4>
<p>
A block class is the same as a model class
with the restriction that each connector component of a block must
have prefixes input and/or output for all connector variables.
The purpose is to model input/output blocks of block diagrams.
Due to the restrictions on input and output prefixes,
connections between blocks are only possible according
to block diagram semantic.
</p>
</html>"));
  end 'block';

  class 'class' "class"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define class
</p>
<h4>Examples</h4>

<blockquote><pre><strong>class</strong> MyTable
  <strong>extends</strong> ExternalObject;
  <strong>function</strong> constructor
     ...
  <strong>end</strong> constructor;

  <strong>function</strong> destructor
     ...
  <strong>end</strong> destructor;
<strong>end</strong> MyTable;</pre></blockquote>

<h4>Syntax</h4>
<blockquote><pre>   [ <strong>encapsulated</strong> ][ <strong>partial</strong>] <strong>class</strong>
   IDENT class_specifier

class_specifier :
   string_comment composition <strong>end</strong> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <strong>enumeration</strong> \"(\" ( [enum_list] | \":\" ) \")\" comment</pre></blockquote>

<p>See <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica Grammar</a> for further details.</p>

<h4>Description</h4>

<p>
The keyword class is used to define general classes (without any restrictions).
It is identical to the keyword model.
In most cases, it is recommended to use specialized classes as
<a href=\"modelica://ModelicaReference.Classes.'connector'\">connector</a>,
<a href=\"modelica://ModelicaReference.Classes.'model'\">model</a>,
<a href=\"modelica://ModelicaReference.Classes.'block'\">block</a>,
<a href=\"modelica://ModelicaReference.Classes.'package'\">package</a>,
<a href=\"modelica://ModelicaReference.Classes.'record'\">record</a>,
<a href=\"modelica://ModelicaReference.Classes.'function'\">function</a>,
<a href=\"modelica://ModelicaReference.Classes.'type'\">type</a>.
\"class\" should be used to define
<a href=\"modelica://ModelicaReference.Classes.ExternalObject\">ExternalObject</a>s,
and can be used for classes merely containing documentation and/or graphics.
</p>
</html>"));
  end 'class';

  class 'connector' "connector"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define specialized class <em>connector</em>
</p>
<h4>Examples</h4>

<blockquote><pre><strong>connector</strong> flange
  Modelica.Units.SI.Angle phi;
  <strong>flow</strong> Modelica.Units.SI.Torque tau;
<strong>end</strong> flange;</pre></blockquote>

<h4>Syntax</h4>
<blockquote><pre>   [ <strong>encapsulated</strong> ][ <strong>partial</strong>] <strong>connector</strong>
   IDENT class_specifier

class_specifier :
   string_comment composition <strong>end</strong> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <strong>enumeration</strong> \"(\" ( [enum_list] | \":\" ) \")\" comment</pre></blockquote>

<p>See <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica Grammar</a> for further details.</p>

<h4>Description</h4>
<p>The keyword connector is used to define connectors, which are used
in
<a href=\"modelica://ModelicaReference.Operators.'connect()'\">connect()</a>
statements. In connectors, no equations are allowed in the
definition or in any of its components.
With respect to \"class\", it is enhanced to allow connect(..) to components
of connector classes.
</p>

<p>
Variable declarations in a connector can have the additional prefixes
<a href=\"modelica://ModelicaReference.'flow'\">flow</a> or
<a href=\"modelica://ModelicaReference.'stream'\">stream</a>, besides
the prefixes
<a href=\"modelica://ModelicaReference.'input'\">input</a> and
<a href=\"modelica://ModelicaReference.'output'\">output</a>, that are
also allowed outside of a connector. Based on the prefix, a
<a href=\"modelica://ModelicaReference.Operators.'connect()'\">connect()</a>
statement leads to specific connection equations, that describe the
balance equations in the infinitesimal connection points.
</p>

<h4>Example</h4>

<p>
If three connectors c1, c2, c3 with the definition
</p>

<blockquote><pre>
<strong>connector</strong> Demo
  Real        p;  // potential variable
  <strong>flow</strong>   Real f;  // flow variable
  <strong>stream</strong> Real s;  // stream variable
<strong>end</strong> Demo;
</pre></blockquote>

<p>
are connected together with
</p>

<blockquote><pre>
   <strong>connect</strong>(c1,c2);
   <strong>connect</strong>(c1,c3);
</pre></blockquote>

<p>
then this leads to the following equations:
</p>

<blockquote><pre>
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
  0 = c1.f*(<strong>if</strong> c1.f > 0 <strong>then</strong> s_mix <strong>else</strong> c1.s) +
      c2.f*(<strong>if</strong> c2.f > 0 <strong>then</strong> s_mix <strong>else</strong> c2.s) +
      c3.f*(<strong>if</strong> c3.f > 0 <strong>then</strong> s_mix <strong>else</strong> c3.s);

  <strong>inStream</strong>(c1.s) = <strong>if</strong> c1.f > 0 <strong>then</strong> s_mix <strong>else</strong> &lt;undefined&gt;;
  <strong>inStream</strong>(c2.s) = <strong>if</strong> c2.f > 0 <strong>then</strong> s_mix <strong>else</strong> &lt;undefined&gt;;
  <strong>inStream</strong>(c3.s) = <strong>if</strong> c3.f > 0 <strong>then</strong> s_mix <strong>else</strong> &lt;undefined&gt;;
</pre></blockquote>
</html>"));
  end 'connector';

  class ExternalObject "ExternalObject"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define external functions with internal memory.
</p>

<h4>Description</h4>

<p>
External functions may have internal memory reported between function calls. Within Modelica this memory is defined as instance of the predefined class <strong>ExternalObject</strong> according to the following rules:
</p>

<ul>
<li> There is a predefined partial class <strong>ExternalObject</strong>
     [<em>since the class is partial, it is not possible to define an
     instance of this class</em>].</li>

<li> An external object class shall be directly extended from
     ExternalObject, shall have exactly two function definitions,
     called \"<strong>constructor</strong>\" and \"<strong>destructor</strong>\", and
     shall not contain other elements.</li>

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

<blockquote><pre>
<strong>class</strong> MyTable
  <strong>extends</strong> ExternalObject;
  <strong>function</strong> constructor
    <strong>input</strong>  String  fileName = \"\";
    <strong>input</strong>  String  tableName = \"\";
    <strong>output</strong> MyTable table;
    <strong>external</strong> \"C\" table = initMyTable(fileName, tableName);
  <strong>end</strong> constructor;

  <strong>function</strong> destructor \"Release storage of table\"
    <strong>input</strong>  MyTable table;
    <strong>external</strong> \"C\" closeMyTable(table);
  <strong>end</strong> destructor;
<strong>end</strong> MyTable;
</pre></blockquote>

<p>
and used in the following way:
</p>

<blockquote><pre>
<strong>model</strong> test \"Define a new table and interpolate in it\"
  MyTable table=MyTable(fileName =\"testTables.txt\",
                        tableName=\"table1\");  // call initMyTable
  Real y;
<strong>equation</strong>
  y = interpolateMyTable(table, time);
<strong>end</strong> test;
</pre></blockquote>

<p>
This requires to provide the following Modelica function:
</p>

<blockquote><pre>
<strong>function</strong> interpolateMyTable \"Interpolate in table\"
  <strong>input</strong>  MyTable table;
  <strong>input</strong>  Real  u;
  <strong>output</strong> Real  y;
  <strong>external</strong> \"C\" y = interpolateMyTable(table, u);
<strong>end</strong> interpolateTable;
</pre></blockquote>

<p>
The external C-functions may be defined in the following way:
</p>

<blockquote><pre>
<strong>typedef struct</strong> {  /* User-defined data structure of the table */
  <strong>double</strong>* array;      /* nrow*ncolumn vector       */
  <strong>int</strong>     nrow;       /* number of rows            */
  <strong>int</strong>     ncol;       /* number of columns         */
  <strong>int</strong>     type;       /* interpolation type        */
  <strong>int</strong>     lastIndex;  /* last row index for search */
} MyTable;

<strong>void</strong>* initMyTable(const char* fileName, const char* tableName) {
  MyTable* table = malloc(sizeof(MyTable));
  <strong>if</strong> ( table == NULL ) ModelicaError(\"Not enough memory\");
        // read table from file and store all data in *table
  <strong>return</strong> (void*) table;
}

<strong>void</strong> closeMyTable(void* object) { /* Release table storage */
  MyTable* table = (MyTable*) object;
  <strong>if</strong> ( object == NULL ) return;
  free(table->array);
  free(table);
}

<strong>double</strong> interpolateMyTable(void* object, double u) {
  MyTable* table = (MyTable*) object;
  <strong>double</strong> y;
  // Interpolate using \"table\" data (compute y)
  <strong>return</strong> y;
}
</pre></blockquote>
</html>"));
  end ExternalObject;

  class 'function' "function"
    extends ModelicaReference.Icons.Information;

class 'function partial application' "function partial application"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
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
<strong>function</strong> func_name(..., formal_parameter_name = expr, ...)
</pre></blockquote>

<p>
[<em>Note that the keyword function in a function partial application
differentiates the syntax from a normal function call where some
parameters have been left out, and instead supplied via default values.</em>]
The function created by the function partial application acts as the
original function but with the bound formal input parameters(s) removed,
i.e., they cannot be supplied arguments at function call. The binding
occurs when the partially evaluated function is created. A partially
evaluated function is \"function compatible\" to the same function where
all bound arguments are removed [<em>thus, for checking function type
compatibility, bound formal parameters are ignored</em>].
</p>

<p>
Example of function partial application as argument, positional argument passing, according to case (b) above:
</p>

<blockquote><pre>
<strong>model</strong> Test
   <strong>parameter</strong> Integer N;
   Real area;
<strong>algorithm</strong>
   area := 0;
   <strong>for</strong> i <strong>in</strong> 1:N <strong>loop</strong>
     area  := area + quadrature(0, 1, <strong>function</strong> Sine(A=2, w=i*time));
   <strong>end for</strong>;
<strong>end</strong> Test;

<strong>function</strong> Sine  \"y = Sine(x,A,w)\"
  <strong>extends</strong> Integrand;
  <strong>input</strong> Real A;
  <strong>input</strong> Real w;
<strong>algorithm</strong>
  y:=A*Modelica.Math.sin(w*x);
<strong>end</strong> Sine;

//Call with function partial application as named input argument:
area  := area + quadrature(0, 1, integrand = <strong>function</strong> Sine(A=2, w=i*time));
</pre></blockquote>

<p>
Example showing that function types are matching after
removing the bound arguments A and w in a function partial
application:
</p>

<blockquote><pre>
<strong>function</strong> Sine2  \"y = Sine2(A,w,x)\"
  <strong>input</strong> Real A;
  <strong>input</strong> Real w;
  <strong>input</strong> Real x; // Note: x is now last in argument list.
  <strong>output</strong> Real y;
<strong>algorithm</strong>
  y:=A*Modelica.Math.sin(w*x);
<strong>end</strong> Sine2;

// The partially evaluated Sine2 has only one argument:
// x - and is thus type compatible with Integrand.
area = quadrature(0, 1, integrand = <strong>function</strong> Sine2(A=2, w=3));
</pre></blockquote>

<p>
Example of a function partial application of a function that is
a component, according to case (d) above:
</p>

<blockquote><pre>
<strong>partial function</strong> SurfaceIntegrand
   <strong>input</strong> Real x;
   <strong>input</strong> Real y;
   <strong>output</strong> Real z;
<strong>end</strong> SurfaceIntegrand;

<strong>function</strong> quadratureOnce
  <strong>input</strong> Real x;
  <strong>input</strong> Real y1;
  <strong>input</strong> Real y2;
  <strong>input</strong> SurfaceIntegrand integrand;
  <strong>output</strong> Real z;
<strong>algorithm</strong>
  // This is according to case (d) and needs to bind the 2nd argument
  z := quadrature(y1, y2, <strong>function</strong> integrand(y=x));
<strong>end</strong> quadratureOnce;

<strong>function</strong> surfaceQuadrature
  <strong>input</strong> Real x1;
  <strong>input</strong> Real x2;
  <strong>input</strong> Real y1;
  <strong>input</strong> Real y2;
  <strong>input</strong> SurfaceIntegrand integrand;
  <strong>output</strong> Real integral;
<strong>algorithm</strong>
   // Case (b) and (c)
   integral := quadrature(x1, x2,
     <strong>function</strong> quadratureOnce(y1=y1, y2=y2, integrand=integrand);
<strong>end</strong> surfaceQuadrature;
</pre></blockquote>
</html>"));
  end 'function partial application';

  class 'pure function' "pure function"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
    <p>
Modelica functions are normally pure which makes it easy for humans to reason about the code
since they behave as mathematical functions, and possible for compilers to optimize.</p>
<ul>
<li>
Pure Modelica functions always give the same output values or errors for the same input values
and only the output values influence the simulation result, i.e. is seen as equivalent to a mathematical map from input values to output values.
Some input values may map to errors. Pure functions are thus allowed to fail by
calling assert, or ModelicaError in C-code, or dividing by zero.
Such errors will only be reported when and if the function is called.
Pure Modelica functions are not assumed to be thread-safe.</li>
<li>A Modelica function which does not have the pure function properties is impure.</li>
</ul>
<p>The declaration of functions follows these rules:</p>
<ul>
<li>Functions defined in Modelica (non-external) are normally assumed to be pure (the exception is the deprecated case below),
if they are impure they shall be marked with the impure keyword. They can be explicitly marked as pure.</li>
<li>External functions must be explicitly declared with pure or impure.</li>
<li>A deprecated semantics is that external functions (and functions defined in Modelica directly or indirectly calling them)
without pure or impure keyword are assumed to be impure – but without any restriction on calling them.
Except for the function Modelica.Utilities.Streams.print diagnostics must be given if called in a simulation model.</li>
</ul>
    </html>"));
  end 'pure function';
     annotation (Documentation(info="<html>
<p>
Define specialized class <em>function</em>
</p>
<h4>Examples</h4>

<blockquote><pre><strong>function</strong> si
  <strong>input</strong> Real x;
  <strong>output</strong> Real y;
<strong>algorithm</strong>
  y = <strong>if abs</strong>(x) &lt; Modelica.Constants.eps <strong>then</strong> 1 <strong>else</strong> Modelica.Math.sin(x)/x;
<strong>end</strong> si;</pre></blockquote>

<div>
<img src=\"modelica://ModelicaReference/Resources/Images/function.png\" width=\"400\" height=\"280\" alt=\"Simulation result\">
</div>

<h4>Syntax</h4>

<blockquote><pre>   [ <strong>encapsulated</strong> ][ <strong>partial</strong>] [ <strong>pure</strong> | <strong>impure</strong>] <strong>function</strong>
   IDENT class_specifier

class_specifier :
   string_comment composition <strong>end</strong> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <strong>enumeration</strong> \"(\" ( [enum_list] | \":\" ) \")\" comment</pre></blockquote>

<p>See <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica Grammar</a> for further details.</p>

<h4>Description</h4>

<p>The keyword function is used to define functions as known from programming
languages.
</p>

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

<li> A function may not be used in connections, may not have equations, may not have initial algorithms.</li>

<li> A function can have at most one algorithm section or one external function interface (not both), which, if present, is the body of the function.</li>

<li> For a function to be called in a simulation model, the function may not be partial,
     and the output variables must be assigned inside the function either in declaration assignments
     or in an algorithm section, or have an external function interface as its body, or be defined as a function partial derivative.
     The output variables of a function should be computed.</li>

<li> A function cannot contain calls to the Modelica built-in operators
     der, initial, terminal, sample, pre, edge, change, reinit, delay,
     cardinality, inStream, actualStream, to the operators of the built-in package Connections,
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
<li> A function may be called using a mix of positional (as in conventional programming languages) and named arguments.</li>

<li> A function can be recursive.</li>

<li> A formal parameter or local variable may be initialized
     through a binding (=) of a default value in its declaration.
     Initialization through an equation is not possible.</li>

<li> A function is dynamically instantiated when it is called rather than
     being statically instantiated by an instance declaration,
     which is the case for other kinds of classes.</li>

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
It cannot be the class-name of a record [i.e., <em>record constructor functions are not
allowed in this context.</em>] Such an input formal parameter of function type
can also have an optional functional default value. Example:
</p>

<blockquote><pre>
<strong>function</strong> quadrature \"Integrate function y=integrand(x) from x1 to x2\"
  <strong>input</strong>  Real x1;
  <strong>input</strong>  Real x2;
  <strong>input</strong>  Integrand integrand;   // Integrand is a partial function, see below
  // With default: input Integrand integrand := Modelica.Math.sin;
  <strong>output</strong> Real integral;
<strong>algorithm</strong>
  integral :=(x2-x1)*(integrand(x1) + integrand(x2))/2;
<strong>end</strong> quadrature;

<strong>partial function</strong> Integrand
  <strong>input</strong>  Real x;
  <strong>output</strong> Real y;
<strong>end</strong> Integrand;
</pre></blockquote>

<p>
A functional argument can be provided in one of the following forms
to be passed to a formal parameter of function type in a function call
(see examples below):
</p>
<ol>
<li> as a function name,</li>
<li> as a function partial application,</li>
<li> as a function that is a component,</li>
<li> as a function partial application of a function that is a component.</li>
</ol>

<p>
In all cases the provided function must be \"function type compatible\"
to the corresponding formal parameter of function type. Example:
</p>

<blockquote><pre>
// A function as a positional input argument according to case (a)
<strong>function</strong> Parabola
   <strong>extends</strong> Integrand;
<strong>algorithm</strong>
   y = x*x;
<strong>end</strong> Parabola;

area = quadrature(0, 1, Parabola);

// The quadrature2 example below uses a function integrand that
// is a component as input argument according to case (c):
<strong>function</strong> quadrature2 \"Integrate function y=integrand(x) from x1 to x2\"
  <strong>input</strong>  Real x1;
  <strong>input</strong>  Real x2;
  <strong>input</strong>  Integrand integrand;   // Integrand is a partial function type
  <strong>output</strong> Real integral;
<strong>algorithm</strong>
   integral := quadrature(x1,       (x1+x2)/2, integrand)+
               quadrature((x1+x2)/2, x2,       integrand);
<strong>end</strong> quadrature2;
</pre></blockquote></html>"));
  end 'function';

  class 'model' "model"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define specialized class <em>model</em>
</p>
<h4>Examples</h4>

<blockquote><pre><strong>model</strong> SlidingMass
  <strong>parameter</strong> Modelica.Units.SI.Mass m=1;
  <strong>parameter</strong> Modelica.Units.SI.Force f=1;
  Modelica.Units.SI.Position s;
  Modelica.Units.SI.Velocity v;
  Modelica.Units.SI.Acceleration a;
<strong>equation</strong>
  <strong>der</strong>(s) = v;
  <strong>der</strong>(v) = a;
  m*a = f;
<strong>end</strong> SlidingMass;</pre></blockquote>

<h4>Syntax</h4>
<blockquote><pre>   [ <strong>encapsulated</strong> ][ <strong>partial</strong>] <strong>model</strong>
   IDENT class_specifier

class_specifier :
   string_comment composition <strong>end</strong> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <strong>enumeration</strong> \"(\" ( [enum_list] | \":\" ) \")\" comment</pre></blockquote>

<p>See <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica Grammar</a> for further details.</p>

<h4>Description</h4>
<p>
The keyword model is identical to the keyword class, i.e.,
no restrictions and no enhancements.
</p>
</html>"));
  end 'model';

  class 'package' "package"
    extends ModelicaReference.Icons.Information;

    annotation (Documentation(info="<html>
<p>
Define specialized class <em>package</em>
</p>
<h4>Examples</h4>

<blockquote><pre><strong>package</strong> Library
  <strong>constant</strong> Real k = 0.1;

  <strong>type</strong> X = Real(min=0);

  <strong>model</strong> A
    ...
  <strong>end</strong> A;

  <strong>model</strong> B
    ...
  <strong>end</strong> B;
<strong>end</strong> Library;</pre></blockquote>

<h4>Syntax</h4>
<blockquote><pre>   [ <strong>encapsulated</strong> ][ <strong>partial</strong>] <strong>package</strong>
   IDENT class_specifier

class_specifier :
   string_comment composition <strong>end</strong> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <strong>enumeration</strong> \"(\" ( [enum_list] | \":\" ) \")\" comment</pre></blockquote>

<p>See <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica Grammar</a> for further details.</p>

<h4>Description</h4>
<p>May only contain declarations of classes and constants.
   Enhanced to allow import of elements of packages.</p>

</html>"));
  end 'package';

  class 'record' "record"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Define specialized class <em>record</em>
</p>
<h4>Examples</h4>

<blockquote><pre>  <strong>record</strong> States
    Modelica.Units.SI.Position s;
    Modelica.Units.SI.Velocity v;
  <strong>end</strong> States;

  <strong>record</strong> System
    <strong>parameter</strong> Modelica.Units.SI.Mass m=1;
    <strong>parameter</strong> Modelica.Units.SI.Force f=1;
    Modelica.Units.SI.Acceleration a;
    States states;
  <strong>end</strong> System;

  <strong>model</strong> SlidingMass
    System sys;
  <strong>equation</strong>
    <strong>der</strong>(sys.states.s) = sys.states.v;
    <strong>der</strong>(sys.states.v) = sys.a;
    sys.m*sys.a = sys.f;
  <strong>end</strong> SlidingMass;</pre></blockquote>

<h4>Syntax</h4>
<blockquote><pre>   [ <strong>encapsulated</strong> ][ <strong>partial</strong>] <strong>record</strong>
   IDENT class_specifier

class_specifier :
   string_comment composition <strong>end</strong> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <strong>enumeration</strong> \"(\" ( [enum_list] | \":\" ) \")\" comment</pre></blockquote>

<p>See <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica Grammar</a> for further details.</p>

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
Define specialized class <em>type</em>
</p>
<h4>Examples</h4>

<blockquote><pre><strong>type</strong> R0Plus = Real(min=0);</pre></blockquote>

<h4>Syntax</h4>
<blockquote><pre>   [ <strong>encapsulated</strong> ][ <strong>partial</strong>] <strong>type</strong>
   IDENT class_specifier

class_specifier :
   string_comment composition <strong>end</strong> IDENT
   | \"=\" base_prefix name [ array_subscripts ] [ class_modification ] comment
   | \"=\" <strong>enumeration</strong> \"(\" ( [enum_list] | \":\" ) \")\" comment</pre></blockquote>

<p>See <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica Grammar</a> for further details.</p>

<h4>Description</h4>
<p>The keyword type is used to define types, which may only be extensions to the predefined types, enumerations, array of type, or classes extending from type.
Enhanced to extend from predefined types [No other specialized class has this property].
</p>

</html>"));
  end 'type';

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

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td colspan=\"3\"><strong>Arithmetic Operators (operate on Real, Integer scalars or arrays)</strong></td></tr>
  <tr><td><em>Operators</em></td>
      <td><em>Example</em></td>
      <td><em>Description</em></td>
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
          matrix*matrix: matrix product<br>
          vector*matrix: row-matrix*matrix (result: vector)<br>
          matrix*vector: matrix*column-matrix (result: vector)</td></tr>
  <tr><td>/</td>
      <td>a / b</td>
      <td>division of two scalars or an array by a scalar;<br>
          division of an array by a scalar is defined element-wise.<br>
          The result is always of real type. In order to get integer<br>
          division with truncation use the function div.</td></tr>

  <tr><td>^</td>
      <td>a^b</td>
      <td>scalar power or integer power of a square matrix</td></tr>

  <tr><td>.*, ./, .^</td>
      <td>a .* b</td>
      <td>element-wise multiplication, division and exponentiation of
          scalars and arrays</td></tr>

  <tr><td>=</td>
      <td>a * b = c + d</td>
      <td>equal operator of an equation; element-wise on arrays</td></tr>
  <tr><td>:=</td>
      <td>a := c + d</td>
      <td>assignment operator; element-wise on arrays</td></tr>
</table>

&nbsp;

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td colspan=\"3\"><strong>Relational Operators (operate on Real, Integer, Boolean, String scalars)</strong></td></tr>
  <tr><td><em>Operators</em></td>
      <td><em>Example</em></td>
      <td><em>Description</em></td>
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

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td colspan=\"3\"><strong>Boolean Operators (operate on scalars or element-wise on arrays)</strong></td></tr>
  <tr><td><em>Operators</em></td>
      <td><em>Example</em></td>
      <td><em>Description</em></td>
      </tr>
  <tr><td><strong>and</strong></td>
      <td>a <strong>and</strong> b</td>
      <td>logical and</td></tr>
  <tr><td><strong>or</strong></td>
      <td>a <strong>or</strong> b</td>
      <td>logical or</td></tr>
  <tr><td><strong>not</strong></td>
      <td><strong>not</strong> a</td>
      <td>logical not</td></tr>
</table>

&nbsp;

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td colspan=\"3\"><strong>Other Operators</strong></td></tr>
  <tr><td><em>Operators</em></td>
      <td><em>Example</em></td>
      <td><em>Description</em></td>
      </tr>
  <tr><td>[..]</td>
      <td>[1,2;3,4]</td>
      <td>Matrix constructor; \",\" separates columns, \";\" separates rows</td></tr>
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

<p>The following table presents all the expression operators in order of precedence from highest to lowest. All operators are binary except exponentiation, the postfix operators and those shown as unary together with <em>expr</em>, the conditional operator, the array construction operator {} and concatenation operator [ ], and the array range constructor which is either binary or ternary. Operators with the same precedence occur at the same line of the table:</p>

<table border=\"1\" cellpadding=\"1\" cellspacing=\"1\">
    <tr>
      <td><em>Operator Group</em></td>
      <td><em>Operator Syntax</em></td>
      <td><em>Examples</em></td>
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
      <td><em>funcName(function-arguments)</em></td>
      <td><code>sin(4.36)</code></td>
    </tr>
    <tr>
      <td>array construct/concat</td>
      <td>{<em>expressions</em>}<br>
          [<em>expressions</em>]<br>
          [<em>expressions</em>; <em>expressions</em>...]
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
      <td><code>+&nbsp;&nbsp;-&nbsp;&nbsp;+<em>expr</em>&nbsp;&nbsp;-<em>expr</em><br>
                .+&nbsp;&nbsp;.-</code></td>
      <td><code>a+b, a-b, +a, -a<br>
                [1,2;3,4].+[2,3;5,6]</code></td>
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
      <td><code>not&nbsp;<em>expr</em></code></td>
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
      <td><code>b1 or b2</code></td>
    </tr>
    <tr>
      <td>array range</td>
      <td><em>expr</em>&nbsp;<code>:</code>&nbsp;<em>expr</em>&nbsp;<code>:</code>&nbsp;<em>expr</em></td>
      <td><code>1:5:100</code>, start:step:stop</td>
    </tr>
    <tr>
      <td>conditional</td>
      <td><code>if</code>&nbsp;<em>expr</em>&nbsp;<code>then</code>&nbsp;<em>expr</em>&nbsp;<code>else</code>&nbsp;<em>expr</em></td>
      <td><code>if b then 3 else x</code></td>
    </tr>
    <tr>
      <td>named argument</td>
      <td><em>ident&nbsp;</em><code>=</code>&nbsp;<em>expr</em></td>
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

<blockquote><pre>  2*-2   // = -4 in Mathematica/MATLAB; is illegal in Modelica
  --2    // =  2 in Mathematica/MATLAB; is illegal in Modelica
  ++2    // =  2 in Mathematica/MATLAB; is illegal in Modelica
  2--2   // =  4 in Mathematica/MATLAB; is illegal in Modelica
</pre></blockquote>

</html>"));
  end ElementaryOperators;

  class 'abs()' "abs()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Absolute value of Real or Integer variable.
</p>
<h4>Syntax</h4>
<blockquote><code><strong>abs</strong>(v)</code></blockquote>
<h4>Description</h4>
<p>Is expanded into &quot;noEvent(<strong>if</strong> v &ge; 0
<strong>then</strong> v <strong>else</strong> -v)&quot;. Argument v
needs to be an Integer or Real expression.</p>
<h4>Examples</h4>
<blockquote><pre>
  <strong>abs</strong>({-3, 0, 3})
 = {3, 0, 3}</pre></blockquote>
</html>"));
  end 'abs()';

  class 'acos()' "acos()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Trigonometric inverse cosine function
</p>
<h4>Syntax</h4>
<blockquote><code><strong>acos</strong>(u)</code></blockquote>
<h4>Description</h4>

<p>Returns the inverse of cos of u, with -1 &le; u &le; +1.
Argument u needs to be an Integer or Real expression.</p>

<p>
The acos function can also be accessed as Modelica.Math.acos.
</p>

<div>
<img src=\"modelica://ModelicaReference/Resources/Images/acos.png\" alt=\"acos\">
</div>

<h4>Examples</h4>
<blockquote><pre><strong>acos</strong>(0)
 = 1.5707963267949</pre></blockquote>
</html>"));
  end 'acos()';

    class 'activeState()' "activeState()"
extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
This operator returns true if state is active in a <a href=\"modelica://ModelicaReference.StateMachines\">state machine</a>.
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>activeState</strong>(state)</pre></blockquote>
<h4>Description</h4>
<p>
Argument <strong>state</strong> is a block instance.
The operator returns <strong>true</strong>, if this instance is a state of a state machine and this state is active at the actual clock tick.
If it is not active, the operator returns <strong>false</strong>.
</p>
</html>"));
  end 'activeState()';

  class 'actualStream()' "actualStream()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
The <code><strong>actualStream</strong>(v)</code> operator is provided for convenience, in order to return the actual value of the stream variable, depending on the actual flow direction. The only argument of this built-in operator needs to be a reference to a stream variable. The operator is vectorizable, in the case of vector arguments. For the following definition it is assumed that an (inside or outside) connector <code>c</code> contains a stream variable <code>h_outflow</code> which is associated with a flow variable <code>m_flow</code> in the same connector <code>c</code>:</p>

<blockquote><pre>
<strong>actualStream</strong>(port.h_outflow) = <strong>if</strong> port.m_flow &gt; 0 <strong>then inStream</strong>(port.h_outflow)
                                                  <strong>else</strong> port.h_outflow;
</pre></blockquote>

<h4>Example</h4>
<p>
The <code><strong>actualStream</strong>(v)</code> operator is typically used in two contexts:
</p>
<blockquote><pre>
der(U) = c.m_flow*actualStream(c.h_outflow); // (1)energy balance equation
h_port = actualStream(port.h);               // (2)monitoring the enthalpy at a port
</pre></blockquote>
<p>
In the case of equation (1), although the <code><strong>actualStream()</strong></code> operator is discontinuous, the product with the flow variable is not, because <code><strong>actualStream())</strong></code> is discontinuous when the flow is zero by construction.
Therefore, a tool might infer that the expression is <code><strong>smooth(0, ...)</strong></code> automatically, and decide whether or not to generate an event.
If a user wants to avoid events entirely, he/she may enclose the right-hand side of (1) with the <code><strong>noEvent()</strong></code> operator.
</p>
<p>
Equations like (2) might be used for monitoring purposes (e.g. plots), in order to inspect what the <em>actual</em> enthalpy of the fluid flowing through a port is.
In this case, the user will probably want to see the change due to flow reversal at the exact instant, so an event should be generated.
If the user does not bother, then he/she should enclose the right-hand side of (2) with <code><strong>noEvent()</strong></code>.
Since the output of <code><strong>actualStream()</strong></code> will be discontinuous, it should not be used by itself to model physical behaviour (e.g., to compute densities used in momentum balances) - <code><strong>inStream()</strong></code> should be used for this purpose. The operator <code><strong>actualStream()</strong></code> should be used to model physical behaviour only when multiplied by the corresponding flow variable (like in the above energy balance equation), because this removes the discontinuity.
</p>
</html>"));
  end 'actualStream()';

  class 'array()' "array()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
The constructor function <code>array(A,B,C,...)</code> constructs an array from its arguments.
</p>

<h4>Examples</h4>

<blockquote><pre>
{1,2,3} <em>is a 3-vector of type Integer</em>
{{11,12,13}, {21,22,23}} <em>is a 2x3 matrix of type Integer</em>
{{{1.0, 2.0, 3.0}}} <em>is a 1x1x3 array of type Real</em>

Real[3] v = array(1, 2, 3.0);
<strong>type</strong> Angle = Real(unit=\"rad\");
<strong>parameter</strong> Angle alpha = 2.0; // type of alpha is Real.
// array(alpha, 2, 3.0) or {alpha, 2, 3.0} is a 3-vector of type Real.
Angle[3] a = {1.0, alpha, 4}; // type of a is Real[3].
</pre></blockquote>

<h4>Description</h4>

The constructor function <code>array(A,B,C,...)</code> constructs an array from its arguments according to the following
rules:
<ul>
<li>Size matching: All arguments must have the same sizes, i.e., <code>size(A)=size(B)=size(C)=...</code></li>
<li>All arguments must be type compatible expressions giving the type of the elements. The data type of the result array is the maximally expanded type of the arguments. Real and Integer subtypes can be mixed resulting in a Real result array where the Integer numbers have been transformed to Real numbers.</li>
<li>Each application of this constructor function adds a one-sized dimension to the left in the result compared to the dimensions of the argument arrays, i.e., <code>ndims(array(A,B,C)) = ndims(A) + 1 = ndims(B) + 1, ...</code></li>
<li><code>{A, B, C, ...}</code> is a shorthand notation for <code>array(A, B, C, ...)</code>.</li>
<li>There must be at least one argument [i.e., <code>array()</code> or <code>{}</code> are not defined].</li>
</ul>
</html>"));
  end 'array()';

  class 'asin()' "asin()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Trigonometric inverse sine function
</p>
<h4>Syntax</h4>
<blockquote><code><strong>asin</strong>(u)</code></blockquote>
<h4>Description</h4>

<p>Returns the inverse of sin of u, with -1 &le; u &le; +1.
Argument u needs to be an Integer or Real expression.</p>

<p>
The asin function can also be accessed as Modelica.Math.asin.
</p>

<div>
<img src=\"modelica://ModelicaReference/Resources/Images/asin.png\" alt=\"asin\">
</div>

<h4>Examples</h4>
<blockquote><pre><strong>asin</strong>(0)
 = 0.0</pre></blockquote>
</html>"));
  end 'asin()';

  class 'assert()' "assert()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Trigger error and print error message if assertion condition is not fulfilled
</p>
<h4>Syntax</h4>
<blockquote><code><strong>assert</strong>(condition, message, level = AssertionLevel.error)</code></blockquote>
<h4>Description</h4>
<p>The Boolean expression <em>condition</em> shall be true for successful model evaluations.
Otherwise, an error occurs using the string expression <em>message</em>
as error message.</p>
<p>If the condition of an assert statement is true, message is not
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
     terminal()=true triggers an assert, the analysis failed.</li>
<li> level = AssertionLevel.warning:<br>
     The current evaluation is not aborted, message indicates
     the cause of the warning [It is recommended to report the
     warning only once when the condition becomes false, and it is
     reported that the condition is no longer violated when the
     condition returns to true. The assert(..) statement shall
     have no influence on the behavior of the model.
     For example, by evaluating the condition and reporting the
     message only after accepted integrator steps. The condition
     needs to be implicitly treated with noEvent(..) since
     otherwise events might be triggered that can lead to slightly
     changed simulation results].</li>
</ul>

<p>
The AssertionLevel.error case can be used to avoid evaluating a model outside its limits of validity; for instance, a function to compute the saturated liquid temperature cannot be called with a pressure lower than the triple point value.
The AssertionLevel.warning case can be used when the boundary of validity is not hard: for instance, a fluid property model based on a polynomial interpolation curve might give accurate results between temperatures of 250 K and 400 K, but still give reasonable results in the range 200 K and 500 K. When the temperature gets out of the smaller interval, but still stays in the largest one, the user should be warned, but the simulation should continue without any further action. The corresponding code would be
</p>
<blockquote><pre>  <strong>assert</strong>(T &gt; 250 and T &lt; 400, \"Medium model outside full accuracy range\",
         AssertionLevel.warning);
  <strong>assert</strong>(T &gt; 200 and T &lt; 500, \"Medium model outside feasible region\");
</pre></blockquote>

<h4>Examples</h4>
<blockquote><pre>  <strong>parameter</strong> Real upperLimit=2;
  <strong>parameter</strong> Real lowerLimit=-2;
<strong>equation</strong>
  <strong>assert</strong>(upperLimit > lowerLimit, \"upperLimit must be greater than lowerLimit.\");
</pre></blockquote>
</html>"));
  end 'assert()';

  class 'atan()' "atan()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Trigonometric inverse tangent function
</p>
<h4>Syntax</h4>
<blockquote><code><strong>atan</strong>(u)</code></blockquote>
<h4>Description</h4>

<p>Returns the inverse of tan of u, with -&infin; &lt; u &lt; &infin;.
Argument u needs to be an Integer or Real expression.</p>

<p>
The atan function can also be accessed as Modelica.Math.atan.
</p>

<div>
<img src=\"modelica://ModelicaReference/Resources/Images/atan.png\" alt=\"atan\">
</div>

<h4>Examples</h4>
<blockquote><pre><strong>atan</strong>(1)
 = 0.785398163397448</pre></blockquote>
</html>"));
  end 'atan()';

  class 'atan2()' "atan2()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Four quadrant inverse tangent
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>atan2</strong>(u1,u2)</pre></blockquote>
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

<div>
<img src=\"modelica://ModelicaReference/Resources/Images/atan2.png\" alt=\"atan2\">
</div>

<h4>Examples</h4>
<blockquote><pre><strong>atan2</strong>(1,0)
 = 1.5707963267949</pre></blockquote>
</html>"));
  end 'atan2()';

  class 'backSample()' "backSample()"
  extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Shifts a clocked expressions to undo a delay as part of the <a href=\"modelica://ModelicaReference.Synchronous\">synchronous language elements</a>.
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>backSample</strong>(u, shiftCounter, resolution)</pre></blockquote>
<h4>Examples</h4>
<blockquote><pre>

  Real x=sample(time, u);
  // Ticks at 0, 3/10, 6/10 with values corresponding to time

  Real x2=shiftSample(x, 1, 3);
  // Ticks at 1/10 with value 0/10, and at 4/10 with value 3/10 etc

  Real x3=backSample(x2, 1, 3);
  // Same as x.
</pre></blockquote>
</html>"));
  end 'backSample()';

  class 'cardinality()' "cardinality()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Number of connectors in connection.
This is a deprecated operator. It should  no longer be used, since it will be removed in one of the next Modelica releases.
</p>

<h4>Syntax</h4>
<blockquote><pre><strong>cardinality</strong>(c)</pre></blockquote>
<h4>Description</h4>
<p>Returns the number of (inside and outside) occurrences
of connector instance c in a connect statement as an Integer number.</p>
<p><em>[The cardinality operator allows the definition of connection dependent equations in a model.]</em></p>

<p>
Instead of the cardinality(..) operator, often conditional
connectors can be used, that are enabled/disabled via Boolean
parameters.
</p>

<h4>Examples</h4>
<blockquote><pre><strong>connector</strong> Pin
  Real      v;
  <strong>flow</strong> Real i;
<strong>end</strong> Pin;
<strong>model</strong> Resistor
   <strong>Pin</strong> p, n;
<strong>equation</strong>
   // Handle cases if pins are not connected
      <strong>if cardinality</strong>(p) == 0 <strong>and cardinality</strong>(n) == 0 <strong>then</strong>
         p.v = 0;
         n.v = 0;
      <strong>elseif cardinality</strong>(p) == 0 <strong>then</strong>
         p.i = 0;
      <strong>elseif cardinality</strong>(n) == 0 <strong>then</strong>
         n.i = 0;
      <strong>end if</strong>;
   // Equations of resistor
      ...
<strong>end</strong> Resistor;</pre></blockquote>
</html>"));
  end 'cardinality()';

  class 'cat()' "cat()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
The function <code>cat(k,A,B,C,...)</code>concatenates arrays <code>A,B,C,...</code> along dimension <code>k</code>.
</p>

<h4>Examples</h4>

<blockquote><pre>
Real[2,3] r1 = cat(1, {{1.0, 2.0, 3}}, {{4, 5, 6}});
Real[2,6] r2 = cat(2, r1, 2*r1);
</pre></blockquote>

<h4>Description</h4>

The function <code>cat(k,A,B,C,...)</code>concatenates arrays <code>A,B,C,...</code> along dimension <code>k</code> according to the following rules:
<ul>
<li>Arrays <code>A, B, C, ...</code> must have the same number of dimensions, i.e., <code>ndims(A) = ndims(B) = ...</code></li>
<li>Arrays <code>A, B, C, ...</code> must be type compatible expressions giving the type of the elements of the result. The maximally expanded types should be equivalent. Real and Integer subtypes can be mixed resulting in a Real result array where the Integer numbers have been transformed to Real numbers.</li>
<li><code>k</code> has to characterize an existing dimension, i.e., <code>1 &lt;= k &lt;= ndims(A) = ndims(B) = ndims(C)</code>; <code>k</code> shall be an integer number.</li>
<li>Size matching: Arrays <code>A, B, C, ...</code> must have identical array sizes with the exception of the size of dimension <code>k</code>, i.e., <code>size(A,j) = size(B,j), for 1 &lt;= j &lt;= ndims(A) and j &lt;&gt; k</code>.</li>
</ul>

<p>Concatenation is formally defined according to:</p>
<blockquote><pre>
Let R = cat(k,A,B,C,...), and let n = ndims(A) = ndims(B) = ndims(C) = ...., then
size(R,k) = size(A,k) + size(B,k) + size(C,k) + ...
size(R,j) = size(A,j) = size(B,j) = size(C,j) = ...., for 1 &lt;= j &lt;= n and j &lt;&gt; k.
R[i_1, ..., i_k, ..., i_n] = A[i_1, ..., i_k, ..., i_n], for i_k &lt;= size(A,k),
R[i_1, ..., i_k, ..., i_n] = B[i_1, ..., i_k - size(A,i), ..., i_n], for i_k &lt;= size(A,k) + size(B,k),
....
where 1 &lt;= i_j &lt;= size(R,j) for 1 &lt;= j &lt;= n.
</pre></blockquote>
</html>"));
  end 'cat()';

  class 'ceil()' "ceil()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Round a Real number towards plus infinity
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>ceil</strong>(x)</pre></blockquote>
<h4>Description</h4>
<p>Returns the smallest integer not less than <code>x</code>.
Result and argument shall have type Real.
<em>[Note, outside of a when clause state events are
triggered when the return value changes discontinuously.]</em></p>
<h4>Examples</h4>
<blockquote><pre><strong>ceil</strong>({-3.14, 3.14})
 = {-3.0, 4.0}</pre></blockquote>
</html>"));
  end 'ceil()';

  class 'change()' "change()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Indicate discrete variable changing
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>change</strong>(v)</pre></blockquote>
<h4>Description</h4>
<p>Is expanded into &quot;(v&lt;&gt;pre(v))&quot;.
The same restrictions as for the pre() operator apply.</p>
<h4>Examples</h4>
<blockquote><pre><strong>model</strong> BothEdges
  Boolean u;
  Integer i;
<strong>equation</strong>
  u = Modelica.Math.sin(<strong>time</strong>) &gt; 0.5;
  <strong>when</strong> <strong>change</strong>(u) <strong>then</strong>
    i = <strong>pre</strong>(i) + 1;
  <strong>end when</strong>;
<strong>end</strong> BothEdges;</pre></blockquote>

<div>
<img src=\"modelica://ModelicaReference/Resources/Images/change.png\" width=\"400\" height=\"280\" alt=\"Simulation result\">
</div>
</html>"));
  end 'change()';

  class 'Clock()' "Clock()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Generates clocks as part of the <a href=\"modelica://ModelicaReference.Synchronous\">synchronous language elements</a>.
</p>
<h4>Examples</h4>
<blockquote><pre>
  Clock c=Clock(2, 1000); // Defines a clock variable
  Real interval1(start=2e-3);
equation
  when Clock() then
    // Inferred Clock
    x=A*previous(x)+B*u;
  end when;
  when Clock(2,1000) then
    // periodic clock that ticks at 0, 0.002, 0.004, ...
    // Could also use when c then
    y1 = previous(y1) + 1;
  end when;
  when Clock(interval1) then
    // Clock with a Real interval
    // The clock starts at the start of the simulation, tstart, or when the controller is switched on.
    // Here the next clock tick is scheduled at previous(interval1)=interval1.start=2e-3
    // At the second clock tick at tstart+interval1.start the next clock tick is scheduled at
    // previous(interval1)=5e-3
    interval1=previous(interval1)+3e-3;
  end when;
  when Clock(angle>0, 0.1) then
    // clock with a boolean interval, triggers when angle>0 becomes true.
    y2 = previous(y2) + 1;
  end when;
  when Clock(c, \"ImplicitTrapezoid\") then
    // Solver Clock
    // Ticks at the same rate as c but uses the ImplicitTrapezoid method to solve the differential equations
    der(x)=x;
  end when;
</pre></blockquote>
</html>"));
  end 'Clock()';

  class 'connect()' "connect()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Connect objects
</p>
<h4>Examples</h4>

<blockquote><pre><strong>model</strong> Integrate
  Modelica.Blocks.Sources.Step step;
  Modelica.Blocks.Continuous.Integrator integrator;
<strong>equation</strong>
  connect(step.outPort, integrator.inPort);
<strong>end</strong> Integrate;</pre></blockquote>

<p>Example of array use:</p>

<blockquote><pre><strong>connector</strong> InPort = <strong>input</strong> Real;

<strong>connector</strong> OutPort = <strong>output</strong> Real;

<strong>block</strong> MatrixGain
  <strong>input</strong> InPort u[size(A,1)];
  <strong>output</strong> OutPort y[size(A,2)]
  <strong>parameter</strong> Real A[:,:]=[1];
<strong>equation</strong>
  y=A*u;
<strong>end</strong> MatrixGain;

  sin sinSource[5];
  MatrixGain gain(A=5*identity(5));
  MatrixGain gain2(A=ones(5,2));
  OutPort x[2];
<strong>equation</strong>
  <strong>connect</strong>(sinSource.y, gain.u); // Legal
  <strong>connect</strong>(gain.y, gain2.u);     // Legal
  <strong>connect</strong>(gain2.y, x);          // Legal</pre></blockquote>

<h4>Syntax</h4>

<p>See section on <code>connect_clause</code> in the <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica Grammar</a>.</p>

<h4>Description</h4>

<p>Connections between objects are introduced by the <strong>connect</strong>
statement in the equation part of a class. The <strong>connect</strong>
construct takes two references to connectors, each of which is
either of the following forms:</p>

<ul>
  <li>c1.c2. ... .cn, where c1 is a connector of the class, n&ge;1
      and ci+1 is a connector element of ci for i=1:(n-1).</li>
  <li>m.c, where m is a non-connector element in the class and c is
      a connector element of m.</li>
</ul>

<p>There may optionally be array subscripts on any of the components;
the array subscripts shall be parameter expressions. If the connect
construct references array of connectors, the array dimensions must
match, and each corresponding pair of elements from the arrays is
connected as a pair of scalar connectors.</p>

<p>The two main tasks are to:</p>

<ul>
  <li>Build connection sets from <strong>connect</strong> statements.</li>
  <li>Generate equations for the complete model.</li>
</ul>

<p>Definitions:</p>

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
      <em>[Example: in connect(a,b.c) 'a' is an outside connector and 'b.c'
      is an inside connector, unless 'b' is a connector.]</em></li>
</ul>
</html>"));
  end 'connect()';

  class 'Connections.branch()' "Connections.branch()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Defines <em>required</em> branch of spanning-tree
</p>

<h4>Syntax</h4>
<blockquote><pre>
Connections.branch(A.R,B.R);
</pre></blockquote>

<h4>Description</h4>
<p>
Defines a branch from the overdetermined type or record instance <code>R</code> in connector instance <code>A</code> to the corresponding overdetermined type or record instance <code>R</code> in connector instance <code>B</code> for a virtual connection graph.
These branches are required to be part of the spanning-tree for the virtual connection graph (they do not directly generate equations, but should be combined with equations coupling <code>A.R</code> to <code>B.R</code>),
whereas connect-statements are optional for the spanning-tree (and generate different equations depending on whether they are part of the spanning-tree or not).
</p>
<h4>Examples</h4>
<p>
This function can be used at all places where a <a href=\"modelica://ModelicaReference.Operators.'connect()'\">connect(...)</a> statement is allowed.
</p>
<p>
E.g., it is not allowed to use this function in a when-clause.
This definition shall be used if in a model with connectors <code>A</code> and <code>B</code> the overdetermined records <code>A.R</code> and <code>B.R</code> are algebraically coupled in the model, e.g., due to <code>B.R = f(A.R, &lt;other unknowns&gt;)</code>.
</p>
</html>"));
  end 'Connections.branch()';

  class 'Connections.root()' "Connections.root()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Defines a <em>definite</em> root node.
</p>
<h4>Syntax</h4>
<blockquote><pre>
Connections.root(A.R);
</pre></blockquote>

<h4>Description</h4>
<p>
The overdetermined type or record instance <code>R</code> in connector instance <code>A</code> is a (definite) root node in a virtual connection graph.
</p>

<h4>Examples</h4>
<p>
This definition shall be used if in a model with connector <code>A</code> the overdetermined record <code>A.R</code> is (consistently) assigned, e.g.,  from a parameter expressions.
</p>
</html>"));
  end 'Connections.root()';

  class 'Connections.potentialRoot()' "Connection.potentialRoot()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Defines a <em>potential</em> root node.
</p>
<h4>Syntax</h4>
<blockquote><pre>
Connections.potentialRoot(A.R);
Connections.potentialRoot(A.R, priority = p);
</pre></blockquote>

<h4>Description</h4>
<p>
The overdetermined type or record instance <code>R</code> in connector instance <code>A</code> is a potential root node in a virtual connection graph with priority <code>p</code> (with <code>p &ge; 0</code>).
If no second argument is provided, the priority is zero. <code>p</code> shall be a parameter expression of type Integer.
In a virtual connection subgraph without a  <a href=\"modelica://ModelicaReference.Operators.'Connections.root()'\">Connections.root()</a> definition, one of the potential roots with the lowest priority number is selected as root.
</p>

<h4>Examples</h4>
<p>
This definition may  be used if in a model with connector <code>A</code> the overdetermined record <code>A.R</code> appears differentiated, <code>der(A.R)</code>, together with the constraint equations of <code>A.R</code>, i.e., a non-redundant subset of <code>A.R</code> maybe used as states.
</p>
</html>"));
  end 'Connections.potentialRoot()';

  class 'Connections.isRoot()' "Connections.isRoot()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Returns root status.
</p>
<h4>Syntax</h4>
<blockquote><pre>
b = Connections.isRoot(A.R);
</pre></blockquote>

<h4>Description</h4>
<p>
Returns true, if the overdetermined type or record instance <code>R</code> in connector instance <code>A</code> is selected as a root in the virtual connection graph.
</p>
</html>"));
  end 'Connections.isRoot()';

  class 'Connections.rooted()' "Connections.rooted()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Returns which node of a connection branch is closer to root.
</p>
<h4>Syntax</h4>
<blockquote><pre>
b = Connections.rooted(A.R);
b = rooted(A.R);  // deprecated
</pre></blockquote>

<h4>Description</h4>
<p>
If the operator <code>Connections.rooted(A.R)</code> is used, or the equivalent <em>but deprecated</em> operator <code>rooted(A.R)</code>, then there must be exactly one statement <code>Connections.branch(A.R,B.R)</code> involving <code>A.R</code> (the argument of <code>Connections.rooted</code> must be the first argument of <code>Connections.branch</code>).
In that case <code>Connections.rooted(A.R)</code> returns <em>true</em>, if <code>A.R</code> is closer to the root of the spanning tree than <code>B.R</code>; otherwise <em>false</em> is returned.
</p>
<h4>Examples</h4>
<p>
This operator can be used to avoid equation systems by providing analytic inverses, see <a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.FixedRotation\">Modelica.Mechanics.MultiBody.Parts.FixedRotation</a>.
</p>
</html>"));
  end 'Connections.rooted()';

  class 'cos()' "cos()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Trigonometric cosine function
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>cos</strong>(u)</pre></blockquote>
<h4>Description</h4>
<p>Returns the cosine of u, with -&infin; &lt; u &lt; &infin;
Argument u needs to be an Integer or Real expression.</p>

<p>
The cosine function can also be accessed as Modelica.Math.cos.
</p>

<div>
<img src=\"modelica://ModelicaReference/Resources/Images/cos.png\" alt=\"cos\">
</div>

<h4>Examples</h4>
<blockquote><pre><strong>cos</strong>(3.14159265358979)
 = -1.0</pre></blockquote>
</html>"));
  end 'cos()';

  class 'cosh()' "cosh()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Hyperbolic cosine function
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>cosh</strong>(u)</pre></blockquote>
<h4>Description</h4>
<p>Returns the cosh of u, with -&infin; &lt; u &lt; &infin;.
Argument u needs to be an Integer or Real expression.</p>

<p>
The cosh function can also be accessed as Modelica.Math.cosh.
</p>

<div>
<img src=\"modelica://ModelicaReference/Resources/Images/cosh.png\" alt=\"cosh\">
</div>

<h4>Examples</h4>
<blockquote><pre><strong>cosh</strong>(1)
  = 1.54308063481524</pre></blockquote>
</html>"));
  end 'cosh()';

  class 'cross()' "cross()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Return cross product of two vectors
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>cross</strong>(x, y)</pre></blockquote>
<h4>Description</h4>
<p>
Returns the cross product of the 3-vectors x and y, i.e.
</p>
<blockquote><pre>
<strong>cross</strong>(x,y) = <strong>vector</strong>( [ x[2]*y[3]-x[3]*y[2];
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
<blockquote><pre><strong>delay</strong>(expr, delayTime, delayMax)
<strong>delay</strong>(expr, delayTime)</pre></blockquote>
<h4>Description</h4>
<p>Returns <code>\"expr(time - delayTime)\"</code> for <code>time &gt; time.start + delayTime</code>
and <code>\"expr(time.start)\"</code> for <code>time &le; time.start + delayTime</code>. The
arguments, i.e., <code>expr</code>, <code>delayTime</code> and <code>delayMax</code>, need to be subtypes of Real.
<code>delayMax</code> needs to be additionally a parameter expression. The following relation
shall hold: <code>0 &le; delayTime &le; delayMax</code>, otherwise an error occurs. If
<code>delayMax</code> is not supplied in the argument list, <code>delayTime</code> need to be a
parameter expression.</p>
<p><em>[The <strong>delay</strong> operator allows a numerical sound implementation
by interpolating in the (internal) integrator polynomials, as well as a
more simple realization by interpolating linearly in a buffer containing
past values of expression expr. Without further information, the complete
time history of the delayed signals need to be stored, because the delay
time may change during simulation. To avoid excessive storage requirements
and to enhance efficiency, the maximum allowed delay time has to be given
via delayMax, or delayTime must be a parameter expression (so that the
constant delay is known before simulation starts).
This gives an upper bound on the values of the delayed
signals which have to be stored. For realtime simulation where fixed step
size integrators are used, this information is sufficient to allocate the
necessary storage for the internal buffer before the simulation starts.
For variable step size integrators, the buffer size is dynamic during
integration. In principal, a delay operator could break algebraic loops.
For simplicity, this is not supported because the minimum delay time has
to be give as additional argument to be fixed at compile time. Furthermore,
the maximum step size of the integrator is limited by this minimum delay
time in order to avoid extrapolation in the delay buffer.]</em></p>
<h4>Examples</h4>
<blockquote><pre><strong>model</strong> Delay
  Real x;
  Real y;
<strong>equation
  der</strong>(x) = 2;
  y = <strong>delay</strong>(x, 1);
<strong>end</strong> Delay;</pre></blockquote>

<div>
<img src=\"modelica://ModelicaReference/Resources/Images/delay.png\" width=\"400\" height=\"280\" alt=\"Simulation result\">
</div>
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

<blockquote><pre><strong>der</strong>(expr) or
IDENT \"=\" <strong>der</strong> \"(\" name \",\" IDENT { \",\" IDENT } \")\" comment</pre></blockquote>

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

<blockquote><pre>  Real x, xdot1, xdot2;
<strong>equation</strong>
  xdot1 = <strong>der</strong>(x);
  xdot2 = <strong>der</strong>(x*sin(x));
</pre></blockquote>

<p>
The specific enthalpy can be computed from a Gibbs-function as follows:
</p>

<blockquote><pre><strong>function</strong> Gibbs
  <strong>input</strong> Real p,T;
  <strong>output</strong> Real g;
<strong>algorithm</strong>
  ...
<strong>end</strong> Gibbs;

<strong>function</strong> Gibbs_T=<strong>der</strong>(Gibbs, T);

<strong>function</strong> specificEnthalpy
  <strong>input</strong> Real p,T;
  <strong>output</strong> Real h;
<strong>algorithm</strong>
  h:=Gibbs(p,T)-T*Gibbs_T(p,T);
<strong>end</strong> specificEnthalpy;
</pre></blockquote>
</html>"));
  end 'der()';

  class 'diagonal()' "diagonal()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Returns a diagonal matrix
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>diagonal</strong>(v)</pre></blockquote>
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
<blockquote><pre><strong>div</strong>(x, y)</pre></blockquote>
<h4>Description</h4>
<p>Returns the algebraic quotient <code>x/y</code> with any
fractional part discarded (also known as truncation
toward zero). <em>[Note: this is defined for / in C99;
in C89 the result for negative numbers is
implementation-defined, so the standard function
<code>div()</code> must be used.]</em> Result and arguments
shall have type Real or Integer. If either of the
arguments is Real the result is Real otherwise Integer.</p>

<p><em>[Note, outside of a when clause state events are triggered
when the return value changes discontinuously.]</em></p>

<h4>Examples</h4>
<blockquote><pre><strong>div</strong>(13,6)
 = 2</pre></blockquote>
</html>"));
  end 'div()';

  class 'edge()' "edge()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Indicate rising edge
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>edge</strong>(b)</pre></blockquote>
<h4>Description</h4>
<p>Is expanded into &quot;(b <strong>and not pre</strong>(b))&quot;
for Boolean variable b. The same restrictions as for the
<strong>pre</strong> operator apply (e.g., not to be used in function
classes).</p>
<h4>Examples</h4>
<blockquote><pre><strong>model</strong> RisingEdge
  Boolean u;
  Integer i;
<strong>equation</strong>
  u = Modelica.Math.sin(<strong>time</strong>) &gt; 0.5;
  <strong>when</strong> <strong>edge</strong>(u) <strong>then</strong>
    i = <strong>pre</strong>(i) + 1;
  <strong>end when</strong>;
<strong>end</strong> RisingEdge;</pre></blockquote>

<div>
<img src=\"modelica://ModelicaReference/Resources/Images/edge.png\" width=\"400\" height=\"280\" alt=\"Simulation result\">
</div>
</html>"));
  end 'edge()';

  class 'exp()' "exp()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Exponential, base e.
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>exp</strong>(u)</pre></blockquote>
<h4>Description</h4>
<p>Returns the base e exponential of u, with -&infin; &lt; u &lt; &infin;
Argument u needs to be an Integer or Real expression.</p>

<p>
The exponential function can also be accessed as Modelica.Math.exp.
</p>

<div>
<img src=\"modelica://ModelicaReference/Resources/Images/exp.png\" alt=\"exp\">
</div>

<h4>Examples</h4>
<blockquote><pre><strong>exp</strong>(1)
 = 2.71828182845905</pre></blockquote>
</html>"));
  end 'exp()';

  class 'fill()' "fill()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Return a Real, Integer, Boolean or String array with all elements equal
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>fill</strong>(s, n1, n2, n3, ...)</pre></blockquote>
<h4>Description</h4>
<p>
Returns the n1 x n2 x n3 x ... array with all elements equal
to scalar or array expression s (ni >= 0). The returned
array has the same type as s. Recursive definition:
</p>
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

  class 'firstTick()' "firstTick()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Returns true for the first tick of the clock, part of the <a href=\"modelica://ModelicaReference.Synchronous\">synchronous language elements</a>.
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>firstTick</strong>(u)</pre></blockquote>
<h4>Description</h4>
<p>
This operator returns <strong>true</strong> at the first tick of the clock of the expression, in which this operator is called.
The operator returns <strong>false</strong> at all subsequent ticks of the clock. The optional argument <strong>u</strong> is only used for clock inference.
</p>
</html>"));
  end 'firstTick()';

  class 'floor()' "floor()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Round Real number towards minus infinity
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>floor</strong>(x)</pre></blockquote>
<h4>Description</h4>
<p>Returns the largest integer not greater than <code>x</code>.
Result and argument shall have type Real. <em>[Note, outside
of a when clause state events are triggered when the return
value changes discontinuously.]</em></p>
<h4>Examples</h4>
<blockquote><pre><strong>floor</strong>({-3.14, 3.14})
 = {-4.0, 3.0}</pre></blockquote>
</html>"));
  end 'floor()';

  class 'hold()' "hold()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Returns a piecewise constant signal based on a clocked variable as part of the <a href=\"modelica://ModelicaReference.Synchronous\">synchronous language elements</a>.
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>hold</strong>(u)</pre></blockquote>
<h4>Description</h4>
<p>
Input argument <strong>u</strong> is a clocked Component Expression or a parameter expression.
The operator returns a piecewise constant signal of the same type of <strong>u</strong>.
When the clock of <strong>u</strong> ticks, the operator returns u and
otherwise returns the value of <strong>u</strong> from the last clock activation.
Before the first clock activation of <strong>u</strong>, the operator returns the start value of <strong>u</strong>.
</p>
</html>"));
  end 'hold()';

  class 'homotopy()' "homotopy()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
During the initialization phase of a dynamic simulation problem, it often happens that large nonlinear systems of equations must be solved by means of an iterative solver.
The convergence of such solvers critically depends on the choice of initial guesses for the unknown variables.
The process can be made more robust by providing an alternative, simplified version of the model, such that convergence is possible even without accurate initial guess values, and then by continuously transforming the simplified model into the actual model.
This transformation can be formulated using expressions of this kind:
</p>

<blockquote><pre>
lambda*actual + (1-lambda)*simplified
</pre></blockquote>

<p>
in the formulation of the system equations, and is usually called a homotopy transformation.
If the simplified expression is chosen carefully, the solution of the problem changes continuously with lambda, so by taking small enough steps it is possible to eventually obtain the solution of the actual problem.
</p>
<p>
It is recommended to perform (conceptually) one homotopy iteration over the whole model, and not several homotopy iterations over the respective non-linear algebraic equation systems.
The reason is that the following structure can be present:
</p>
<blockquote><pre>
<strong>w = f<sub>1</sub>(x)</strong> // has homotopy operator
<strong>0 = f<sub>2</sub>(der(x), x, z, w)</strong>
</pre></blockquote>
<p>
Here, a non-linear equation system <strong><code>f<sub>2</sub></code></strong> is present.
The homotopy operator is, however used on a variable that is an 'input' to the non-linear algebraic equation system, and modifies the characteristics of the non-linear algebraic equation system.
The only useful way is to perform the homotopy iteration over <strong><code>f<sub>1</sub></code></strong> and <strong><code>f<sub>2</sub></code></strong> together.
</p>
<p>
The suggested approach is 'conceptual', because more efficient implementations are possible, e.g., by determining the smallest iteration loop, that contains the equations of the first BLT block in which a homotopy operator is present and all equations up to the last BLT block that describes a non-linear algebraic equation system.
</p>
<p>
A trivial implementation of the homotopy operator is obtained by defining the following function in the globalscope:
</p>

<blockquote><pre>
<strong>function</strong> homotopy
  <strong>input</strong> Real actual;
  <strong>input</strong> Real simplified;
  <strong>output</strong> Real y;
<strong>algorithm</strong>
  y := actual;
  <strong>annotation</strong>(Inline = true);
<strong>end</strong> homotopy;
</pre></blockquote>

<h4>Syntax</h4>
<blockquote><pre>
<strong>homotopy</strong>(actual=actual, simplified=simplified)
</pre></blockquote>

<h4>Description</h4>
<p>
The scalar expressions 'actual' and 'simplified' are subtypes of Real.
A Modelica translator should map this operator into either of the two forms:
</p>
<ol>
<li> Returns 'actual' <em>[a trivial implementation]</em>.</li>
<li> <p>In order to solve algebraic systems of equations, the operator might during the solution process return a combination of the two arguments, ending at actual, <em>e.g.,</em></p>
<blockquote><pre><em>
actual*lambda + simplified*(1-lambda),
</em></pre></blockquote>
<p>where <code>lambda</code> is a homotopy parameter going from 0 to 1.</p>
<p>The solution must fulfill the equations for homotopy returning 'actual'.</p></li>
</ol>

<h4>Examples</h4>
<h5>Example 1</h5>
<p>
In electrical systems it is often difficult to solve non-linear algebraic equations if switches are part of the
algebraic loop.
An idealized diode model might be implemented in the following way, by starting with a 'flat' diode characteristic and then move with the homotopy operator to the desired 'steep' characteristic:
</p>
<blockquote><pre>
<strong>model</strong> IdealDiode
  ...
  <strong>parameter</strong> Real Goff = 1e-5;
<strong>protected</strong>
  <strong>Real</strong> Goff_flat = max(0.01, Goff);
  <strong>Real</strong> Goff2;
<strong>equation</strong>
  off = s &lt; 0;
  Goff2 = <strong>homotopy</strong>(actual=Goff, simplified=Goff_flat);
  u = s*(<strong>if</strong> off <strong>then</strong> 1     <strong>else</strong> Ron2) + Vknee;
  i = s*(<strong>if</strong> off <strong>then</strong> Goff2 <strong>else</strong> 1   ) + Goff2*Vknee;
  ...
<strong>end</strong> IdealDiode;
</pre></blockquote>

<h5>Example 2</h5>
<p>
In electrical systems it is often useful that all voltage sources start with zero voltage and all current sources with zero current, since steady state initialization with zero sources can be easily obtained.
A typical voltage source would then be defined as:
</p>

<blockquote><pre>
<strong>model</strong> ConstantVoltageSource
  <strong>extends</strong> Modelica.Electrical.Analog.Interfaces.OnePort;
  <strong>parameter</strong> Modelica.Units.SI.Voltage V;
<strong>equation</strong>
  v = <strong>homotopy</strong>(actual=V, simplified=0.0);
<strong>end</strong> ConstantVoltageSource;
</pre></blockquote>

<h5>Example 3</h5>
<p>
In fluid system modelling, the pressure/flowrate relationships are highly nonlinear due to the quadratic terms and due to the dependency on fluid properties.
A simplified linear model, tuned on the nominal operating point, can be used to make the overall model less nonlinear and thus easier to solve without accurate start values.
Named arguments are used here in order to further improve the readability.
</p>

<blockquote><pre>
<strong>model</strong> PressureLoss
  <strong>import</strong> SI = Modelica.Units.SI;
  ...
  <strong>parameter</strong> SI.MassFlowRate m_flow_nominal \"Nominal mass flow rate\";
  <strong>parameter</strong> SI.Pressure     dp_nominal     \"Nominal pressure drop\";
  SI.Density                rho            \"Upstream density\";
  SI.DynamicViscosity       lambda         \"Upstream viscosity\";
<strong>equation</strong>
  ...
  m_flow = <strong>homotopy</strong>(actual     = turbulentFlow_dp(dp, rho, lambda),
                    simplified = dp/dp_nominal*m_flow_nominal);
  ...
<strong>end</strong> PressureLoss;
</pre></blockquote>

<h5>Example 4</h5>
<p>
Note that the homotopy operator <strong>shall not</strong> be used to combine unrelated expressions, since this can generate singular systems from combining two well-defined systems.
</p>

<blockquote><pre>
<strong>model</strong> DoNotUse
  Real x;
  <strong>parameter</strong> Real x0 = 0;
<strong>equation</strong>
  der(x) = 1-x;
<strong>initial equation</strong>
  0 = <strong>homotopy</strong>(der(x), x - x0);
<strong>end</strong> DoNotUse;
</pre></blockquote>
<p>
The initial equation is expanded into
</p>
<blockquote><pre>
0 = lambda*der(x) + (1-lambda)*(x-x0)
</pre></blockquote>
<p>
and you can solve the two equations to give
</p>
<blockquote><pre>
x = (lambda+(lambda-1)*x0)/(2*lambda - 1)
</pre></blockquote>
<p>
which has the correct value of <code>x0</code> at <code>lambda = 0</code> and of <code>1</code> at <code>lambda = 1</code>, but unfortunately has a singularity at <code>lambda = 0.5</code>.
</p>
</html>"));
  end 'homotopy()';

  class 'identity()' "identity()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Returns the identity matrix of the desired size
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>identity</strong>(n)</pre></blockquote>
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
<blockquote><pre><strong>initial</strong>()</pre></blockquote>
<h4>Description</h4>
<p>Returns <strong>true</strong> during the initialization phase and <strong>false</strong> otherwise.</p>
<h4>Examples</h4>
<blockquote><pre>  Boolean off;
  Real x;
<strong>equation</strong>
  off = x &lt; -2 or <strong>initial</strong>();</pre></blockquote>
</html>"));
  end 'initial()';

  class 'initialState()' "initialState()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Defines the initially active block instance of the <a href=\"modelica://ModelicaReference.StateMachines\">state machine</a>.
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>initialState</strong>(state)</pre></blockquote>
<h4>Description</h4>
<p>Argument <strong>state</strong> is the block instance that is defined to be the initial state of a state machine.
At the first clock tick of the state machine, this state becomes active. </p>
</html>"));
  end 'initialState()';

  class 'inStream()' "inStream()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Returns the mixing value of a stream variable if it flows into the component where the inStream operator
is used.
</p>

<p>
For an introduction into stream variables and an example for the inStream(..) operator, see
<a href=\"modelica://ModelicaReference.'stream'\">stream</a>.
</p>

<h4>Syntax</h4>

<blockquote><pre><strong>inStream</strong>(IDENT) </pre></blockquote>

<p>
where <code>IDENT</code> must be a variable reference in a connector component declared with the
<a href=\"modelica://ModelicaReference.'stream'\">stream</a> prefix.
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

<blockquote><pre><strong>connector</strong> FluidPort
   ...
   <strong>flow</strong>   Real m_flow     \"Flow of matter; m_flow &gt; 0 if flow into component\";
   <strong>stream</strong> Real h_outflow  \"Specific variable in component if m_flow &lt; 0\"
<strong>end</strong> FluidPort;

<strong>model</strong> FluidSystem
   ...
   FluidComponent m1, m2, ..., mN;
   FluidPort      c1, c2, ..., cM;
<strong>equation</strong>
   <strong>connect</strong>(m1.c, m2.c);
   <strong>connect</strong>(m1.c, m3.c);
      ...
   <strong>connect</strong>(m1.c, mN.c);
   <strong>connect</strong>(m1.c, c1);
   <strong>connect</strong>(m1.c, c2);
      ...
   <strong>connect</strong>(m1.c, cM);
   ...
<strong>end</strong> FluidSystem;
</pre></blockquote>

<p>
With these prerequisites, the semantics of the expression
</p>

<blockquote><pre><strong>inStream</strong>(m<sub>i</sub>.c.h_outflow)
</pre></blockquote>

<p>
is given implicitly by defining an additional variable <strong>h_mix_in</strong><sub>i</sub>,
and by adding to the model the conservation equations for mass and energy corresponding
to the infinitesimally small volume spanning the connection set. The connect equation
for the flow variables has already been added to the system according to the connection
semantics of flow variables:
</p>

<blockquote><pre>// Standard connection equation for flow variables
0 = <strong>sum</strong>(m<sub>j</sub>.c.m_flow <strong>for</strong> j <strong>in</strong> 1:N) + <strong>sum</strong>(-c<sub>k</sub>.m_flow <strong>for</strong> k in 1:M);
</pre></blockquote>

<p>
Whenever the inStream() operator is applied to a stream variable of an
inside connector, the balance equation of the transported property must
be added  under the assumption of flow going into the connector
</p>

<blockquote><pre>// Implicit definition of the inStream() operator applied to inside connector i
0 = <strong>sum</strong>(m<sub>j</sub>.c.m_flow*(<strong>if</strong> m<sub>j</sub>.c.m_flow > 0 <strong>or</strong> j==i <strong>then</strong> h_mix_in<sub>i</sub> <strong>else</strong> m<sub>j</sub>.c.h_outflow) <strong>for</strong> j <strong>in</strong> 1:N) +
    <strong>sum</strong>(-c<sub>k</sub>.m_flow* (<strong>if</strong> c<sub>k</sub>.m_flow > 0 <strong>then</strong> h_mix_in<sub>i</sub> <strong>else</strong> inStream(c<sub>k</sub>.h_outflow) <strong>for</strong> k <strong>in</strong> 1:M);
<strong>inStream</strong>(m<sub>i</sub>.c.h_outflow) = h_mix_in<sub>i</sub>;
</pre></blockquote>

<p>
Note that the result of the inStream(m<sub>i</sub>.c.h_outflow) operator is different for each port i,
because the assumption of flow entering the port is different for each of them.
Additional equations need to be generated for the stream variables of outside connectors.
</p>

<blockquote><pre>// Additional connection equations for outside connectors
<strong>for</strong> q in 1:M <strong>loop</strong>
  0 = <strong>sum</strong>(m<sub>j</sub>.c.m_flow*(<strong>if</strong> m<sub>j</sub>.c.m_flow > 0 <strong>then</strong> h_mix_out<sub>q</sub> <strong>else</strong> m<sub>j</sub>.c.h_outflow) <strong>for</strong> j <strong>in</strong> 1:N) +
      <strong>sum</strong>(-c<sub>k</sub>.m_flow* (<strong>if</strong> c<sub>k</sub>.m_flow > 0 <strong>or</strong> k==q <strong>then</strong> h_mix_out<sub>q</sub> <strong>else</strong> <strong>inStream</strong>(c<sub>k</sub>.h_outflow)
          <strong>for</strong> k <strong>in</strong> 1:M);
  c<sub>q</sub>.h_outflow = h_mix_out<sub>q</sub>;
<strong>end for</strong>;
</pre></blockquote>

<p>
Neglecting zero flow conditions, the above implicit equations can be
analytically solved for the inStream(..) operators.
The details are given in <a href=\"https://specification.modelica.org/v3.4/Ch15.html#stream-operator-instream-and-connection-equations\">Section 15.2 (Stream Operator inStream and Connection Equations) of the Modelica 3.4 specification</a>.
The stream connection equations have singularities and/or multiple solutions if one or more
of the flow variables become zero. When all the flows are zero, a singularity is always
present, so it is necessary to approximate the solution in an open neighborhood
of that point. [<em>For example assume that m<sub>j</sub>.c.m_flow = c<sub>k</sub>.m_flow = 0,
then all equations above are identically fulfilled and inStream(..) can have any value</em>].
It is required that the inStream() operator is appropriately approximated in that case
and the approximation must fulfill the following requirements:
</p>

<ol>
<li> inStream(m<sub>i</sub>.c.h_outflow) and inStream(c<sub>k</sub>.h_outflow)
     must be <strong>unique</strong> with respect to all values of the flow and stream
     variables in the connection set, and must have a continuous dependency on them.<br>&nbsp;</li>
<li> Every solution of the implicit equation system above must fulfill the equation
     system identically [<em>up to the usual numerical accuracy</em>],
     provided the absolute value of every flow variable in the connection set is
     greater than a small value (|m<sub>1</sub>.c.m_flow| &gt; eps and |m<sub>2</sub>.c.m_flow| &gt; eps
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
<blockquote><pre><strong>Integer</strong>(&lt;expression of enumeration type&gt;)</pre></blockquote>
<h4>Description</h4>
<p>
Returns the ordinal number of the enumeration value E.enumvalue, to which the expression
is evaluated, where Integer(E.e1) =1, Integer(E.en) =size(E), for an enumeration
type E=enumeration(e1, ...,  en).
</p>

<h4>Examples</h4>
<blockquote><pre>
<strong>type</strong> Size = <strong>enumeration</strong>(small, medium, large, xlarge);
Size tshirt = Size.large;
Integer tshirtValue = <strong>Integer</strong>(tshirt);  // = 3
</pre></blockquote>
</html>"));
  end 'Integer()';

  class 'integer()' "integer()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Round Real number towards minus infinity
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>integer</strong>(x)</pre></blockquote>
<h4>Description</h4>
<p>Returns the largest integer not greater than <code>x</code>.
The argument shall have type Real. The result has type Integer.</p>
<p><em>[Note, outside of a when clause state events are triggered
when the return value changes discontinuously.]</em></p>
<h4>Examples</h4>
<blockquote><pre><strong>integer</strong>({-3.14, 3.14})
 = {-4, 3}</pre></blockquote>
</html>"));
  end 'integer()';

  class 'interval()' "interval()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Part of the <a href=\"modelica://ModelicaReference.Synchronous\">synchronous language elements</a>.
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>interval</strong>(u)</pre></blockquote>
<h4>Description</h4>
<p>
This operator returns the interval between the previous and present tick of the clock of the expression, in which this operator is called.
The optional argument u is only used for clock inference.
</p>
</html>"));
  end 'interval()';

  class 'linspace()' "linspace()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Return Real vector with equally spaced elements
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>linspace</strong>(x1, x2, n)</pre></blockquote>
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
<blockquote><pre><strong>log</strong>(u)</pre></blockquote>
<h4>Description</h4>
<p>Returns the base e logarithm of u, with u &gt; 0.
Argument u needs to be an Integer or Real expression.</p>

<p>
The natural logarithm can also be accessed as Modelica.Math.log.
</p>

<div>
<img src=\"modelica://ModelicaReference/Resources/Images/log.png\" alt=\"log\">
</div>

<h4>Examples</h4>
<blockquote><pre><strong>log</strong>(1)
 = 0</pre></blockquote>
</html>"));
  end 'log()';

  class 'log10()' "log10()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Base 10 logarithm
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>log10</strong>(u)</pre></blockquote>
<h4>Description</h4>
<p>Returns the base 10 logarithm of u, with u &gt; 0.
Argument u needs to be an Integer or Real expression.</p>

<p>
The base 10 logarithm can also be accessed as Modelica.Math.log10.
</p>

<div>
<img src=\"modelica://ModelicaReference/Resources/Images/log10.png\" alt=\"log10\">
</div>

<h4>Examples</h4>
<blockquote><pre><strong>log10</strong>(1)
 = 0</pre></blockquote>
</html>"));
  end 'log10()';

  class 'matrix()' "matrix()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Returns the first two dimensions of an array as matrix
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>matrix</strong>(A)</pre></blockquote>
<h4>Description</h4>
<p>
Returns <strong>promote</strong>(A,2), if A is a scalar or vector and
otherwise returns the elements of the first two dimensions
as a matrix. <strong>size</strong>(A,i) = 1 is required for
2 &lt; i &le; <strong>ndims</strong>(A).
</p>
<p>
Function <strong>promote</strong>(A,n) fills dimensions of size 1
from the right to array A up to dimension n, where
\"n &gt; <strong>ndims</strong>(A)\" is required. Let
C = <strong>promote</strong>(A,n), with nA = <strong>ndims</strong>(A),
then
</p>
<blockquote><pre>
<strong>ndims</strong>(C) = n,
<strong>size</strong>(C,j) = <strong>size</strong>(A,j) for 1 &le; j &le; nA,
<strong>size</strong>(C,j) = 1 for nA+1 &le; j &le; n,
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
<strong>max</strong>(A)
<strong>max</strong>(x,y)
<strong>max</strong>(e(i, ..., j) <strong>for</strong> i <strong>in</strong> u, ..., j <strong>in</strong> v)
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
<strong>max</strong>(i^2 <strong>for</strong> i <strong>in</strong> {3,7,6})  // = 49
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
<strong>min</strong>(A)
<strong>min</strong>(x,y)
<strong>min</strong>(e(i, ..., j) <strong>for</strong> i <strong>in</strong> u, ..., j <strong>in</strong> v)
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
<strong>min</strong>(i^2 <strong>for</strong> i <strong>in</strong> {3,7,6})  // = 9
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
<blockquote><pre><strong>mod</strong>(x, y)</pre></blockquote>
<h4>Description</h4>
<p>Returns the integer modulus of <code>x/y</code>, i.e., mod(x, y) = x - floor(x/y)*y.
Result and arguments shall have type Real or Integer. If either of the
arguments is Real the result is Real otherwise Integer. <em>[Note, outside of
a when clause state events are triggered when the return value changes
discontinuously.]</em></p>
<h4>Examples</h4>
<blockquote><pre><strong>mod</strong>(3,1.4)
 = 0.2
<strong>mod</strong>(-3,1.4)
 = 1.2
<strong>mod</strong>(3,-1.4)
 = -1.2</pre></blockquote>
</html>"));
  end 'mod()';

  class 'ndims()' "ndims()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Return number of array dimensions
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>ndims</strong>(A)</pre></blockquote>
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

  class 'noClock()' "noClock()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Part of the <a href=\"modelica://ModelicaReference.Synchronous\">synchronous language elements</a>.
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>noClock</strong>(u)</pre></blockquote>
<h4>Description</h4>
<p>
The clock of <strong>y = noClock(u)</strong> is always inferred.
At every tick of the clock of <strong>y</strong>, the operator returns the value of <strong>u</strong> from the last tick of the clock of <strong>u</strong>.
If <strong>noClock(u)</strong> is called before the first tick of the clock of <strong>u</strong>, the start value of <strong>u</strong> is returned.
</p>
</html>"));
  end 'noClock()';

  class 'noEvent()' "noEvent()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Turn off event triggering
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>noEvent</strong>(expr)</pre></blockquote>
<h4>Description</h4>
<p>Real elementary relations within expr are taken literally, i.e., no state or time event is triggered.</p>
<h4>smooth vs. noEvent</h4>
<p>The noEvent operator implies that real elementary expressions are taken
literally instead of generating crossing functions. The smooth operator
should be used instead of noEvent, in order to avoid events for efficiency
reasons. A tool is free to not generate events for expressions inside smooth.
However, smooth does not guarantee that no events will be generated, and thus
it can be necessary to use noEvent inside smooth. <em>[Note that smooth does
not guarantee a smooth output if any of the occurring variables change
discontinuously.]</em></p>
<p><em>[Example:</em></p>
<blockquote><pre>  Real x, y, z;
<strong>equation</strong>
  x = <strong>if</strong> time&lt;1 <strong>then</strong> 2 <strong>else</strong> time-2;
  z = smooth(0, <strong>if</strong> time&lt;0 <strong>then</strong> 0 <strong>else</strong> time);
  y = smooth(1, noEvent(<strong>if</strong> x&lt;0 <strong>then</strong> 0 <strong>else</strong> sqrt(x)*x));
  // noEvent is necessary.</pre></blockquote>
<p><em>]</em></p>
<h4>Examples</h4>
<blockquote><pre>der(h)=<strong>if noEvent</strong>(h&gt;0) <strong>then</strong> -c*sqrt(h) <strong>else</strong> 0;</pre></blockquote>
</html>"));
  end 'noEvent()';

  class 'ones()' "ones()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Returns an array with \"1\" elements
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>ones</strong>(n1, n2, n3, ...)</pre></blockquote>
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
<blockquote><pre><strong>outerProduct</strong>(v1,v2)</pre></blockquote>
<h4>Description</h4>
<p>
Returns the outer product of vectors v1 and v2<br>
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
<blockquote><pre><strong>pre</strong>(y)</pre></blockquote>
<h4>Description</h4>
<p>Returns the &quot;left limit&quot; y(t<sup>pre</sup>)
of variable y(t) at a time instant t. At an event instant,
y(t<sup>pre</sup>) is the value of y after the last event
iteration at time instant t. The
<strong>pre</strong> operator can be applied if the following three
conditions are fulfilled simultaneously:</p>
<ul>
  <li>variable y is a subtype of a simple type</li>
  <li>y is a discrete-time expression</li>
  <li>the operator is <strong>not</strong> applied in a <strong>function</strong> class</li>
</ul>
<p>The first value of <strong>pre</strong>(y) is
determined in the initialization phase.</p>
<p>A new event is triggered if at least for one variable v
&quot;<strong>pre</strong>(v) &lt;&gt; v&quot; after the active model
equations are evaluated at an event instant. In this case
the model is at once reevaluated. This evaluation sequence
is called &quot;<em>event iteration</em>&quot;. The integration
is restarted, if for all v used in <strong>pre</strong>-operators the
following condition holds: &quot;<strong>pre</strong>(v) == v&quot;.</p>
<p><em>[If v and <strong>pre</strong>(v) are only used in when clauses,
the translator might mask event iteration for variable v since
v cannot change during event iteration. It is a &quot;quality
of implementation&quot; to find the minimal loops for event
iteration, i.e., not all parts of the model need to be
reevaluated.</em></p>
<p><em>The language allows mixed algebraic systems of equations
where the unknown variables are of type Real, Integer, Boolean,
or an enumeration. These systems of equations can be solved by
a global fix point iteration scheme, similarly to the event
iteration, by fixing the Boolean,  Integer, and/or enumeration
unknowns during one iteration. Again, it is a quality of
implementation to solve these systems more efficiently, e.g.,
by applying the fix point iteration scheme to a subset of the
model equations.]</em></p>
<p><em>Note that <strong>pre</strong>(v) requires the argument to be a variable and a discrete-time expression,
this formulation was chosen to allow using <strong>pre</strong>(v) both for discrete-time variables and
for continuous-time variables inside when-clauses.
</em></p>
<h4>Examples</h4>
<blockquote><pre><strong>model</strong> Hysteresis
  Real u;
  Boolean y;
<strong>equation</strong>
  u = Modelica.Math.sin(<strong>time</strong>);
  y = u &gt; 0.5 or <strong>pre</strong>(y) and u &gt;= -0.5;
<strong>end</strong> Hysteresis;</pre></blockquote>

<div>
<img src=\"modelica://ModelicaReference/Resources/Images/pre.png\" width=\"400\" height=\"280\" alt=\"Simulation result\">
</div>
</html>"));
  end 'pre()';

  class 'previous()' "previous()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Gives the previous value of a clocked expression as part of the <a href=\"modelica://ModelicaReference.Synchronous\">synchronous language elements</a>.
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>previous</strong>(u)</pre></blockquote>
<h4>Description</h4>
<p>
The return argument has the same type as the input argument.
Input and return arguments are on the same clock.
At the first tick of the clock of <strong>u</strong> or after a <a href=\"modelica://ModelicaReference.Operators.'transition()'\">reset transition</a>,
the start value of <strong>u</strong>  is returned.
At subsequent activations of the clock of <strong>u</strong>, the value of <strong>u</strong> from the previous clock activation is returned.
</p>
</html>"));
  end 'previous()';

  class 'product()' "product()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Returns the scalar product
</p>
<h4>Syntax</h4>
<blockquote><pre>
<strong>product</strong>(A)
<strong>product</strong>(e(i, ..., j) <strong>for</strong> i <strong>in</strong> u, ..., j <strong>in</strong> v)
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
The type of <strong>product</strong>(e(i, ..., j) <strong>for</strong> i <strong>in</strong>
u, ..., j <strong>in</strong> v) is the same as the type of e(i,...j).
</p>
<h4>Examples</h4>
<blockquote><pre>
{<strong>product</strong>(j <strong>for</strong> j <strong>in</strong> 1:i) <strong>for</strong> i <strong>in</strong> 0:4} // = {1,1,2,6,24}
</pre></blockquote>
</html>"));
  end 'product()';

  class 'reinit()' "reinit()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Reinitialize state variable
</p>

<h4>Syntax</h4>
<blockquote><pre><strong>reinit</strong>(x, expr)</pre></blockquote>
<h4>Description</h4>
<p>
The operator reinitializes <code>x</code> with expr at an event instant. <code>x</code> is a Real variable
(or an array of Real variables) that must be selected as a state (resp., states), that is
reinit on <code>x</code> implies <code>stateSelect = StateSelect.always</code> on <code>x</code>.
<code>expr</code> needs to be type-compatible with <code>x</code>. The reinit operator can for the same variable
(resp. array of variables) only be applied (either as an individual variable or as part
of an array of variables) in one equation (having reinit of the same variable in when and
else-when of the same variable is allowed).
The reinit operator can only be used in the body of a when-equation. It cannot be used
in an algorithm section.
</p>

<p>
The reinit operator does not break the single assignment rule, because reinit(x,expr)
in equations evaluates expr to a value (value), then at the end of the current event iteration step
it assigns this value to x (this copying from values to reinitialized state(s) is done after
all other evaluations of the model and before copying x to pre(x)).
</p>

<p>
<em>
[If a higher index system is present, that is constraints between state variables,
some state variables need to be redefined to non-state variables. During simulation,
non-state variables should be chosen in such a way that variables with an applied reinit
operator are selected as states at least when the corresponding when-clauses become active.
If this is not possible, an error occurs, since otherwise the reinit operator would be applied
on a non-state variable.]
</em>
</p>

<h4>Examples</h4>
<blockquote><pre>
// Bouncing ball
   <strong>parameter</strong> Real e=0.5 \"Coefficient of restitution\"
   Real h, v;
   Boolean flying;
<strong>equation</strong>
   <strong>der</strong>(h) = v;
   <strong>der</strong>(v) = <strong>if</strong> flying <strong>then</strong> -g <strong>else</strong> 0;
   flying = <strong>not</strong> (h&lt;=0 <strong>and</strong> v&lt;=0);

   <strong>when</strong> h &lt; 0 <strong>then</strong>
     <strong>reinit</strong>(v, -e*<strong>pre</strong>(v));
   <strong>end when</strong>;
</pre></blockquote>
</html>"));
  end 'reinit()';

  class 'rem()' "rem()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Integer remainder of the division of two Real numbers
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>rem</strong>(x, y)</pre></blockquote>
<h4>Description</h4>
<p>Returns the integer remainder of <code>x/y</code>,
such that <code>div(x,y) * y + rem(x, y) = x</code>.
Result and arguments shall have type Real or
Integer. If either of the arguments is Real the
result is Real otherwise Integer. <em>[Note, outside
of a when clause state events are triggered when
the return value changes discontinuously.]</em></p>
<h4>Examples</h4>
<blockquote><pre><strong>rem</strong>(3,1.4)
 = 0.2
<strong>rem</strong>(-3,1.4)
 = -0.2
<strong>rem</strong>(3,-1.4)
 = 0.2</pre></blockquote>
</html>"));
  end 'rem()';

  class 'rooted()' "rooted() - deprecated"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
<strong>Deprecated</strong> operator, see <a href=\"modelica://ModelicaReference.Operators.'Connections.rooted()'\">Connections.rooted()</a> instead.
</p>
</html>"));
  end 'rooted()';

  class 'sample()' "sample()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Trigger time events
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>sample</strong>(start, interval)</pre></blockquote>
<h4>Description</h4>
<p>Returns true and triggers time events at time instants
<code>&quot;start + i*interval&quot; (i=0, 1, ...)</code>.
During continuous integration the operator returns always
false. The starting time &quot;start&quot; and the sample
interval &quot;interval&quot; need to be parameter
expressions and need to be a subtype of Real or Integer.
</p>
<h4>Examples</h4>
<blockquote><pre><strong>model</strong> Sampling
  Integer i;
<strong>equation</strong>
  <strong>when</strong> <strong>sample</strong>(1, 0.1) <strong>then</strong>
    i = <strong>pre</strong>(i) + 1;
  <strong>end when</strong>;
<strong>end</strong> Sampling;</pre></blockquote>

<div>
<img src=\"modelica://ModelicaReference/Resources/Images/sample.png\" width=\"400\" height=\"280\" alt=\"Simulation result\">
</div>
</html>"));
  end 'sample()';

  class 'sample()clocked' "sample() Clocked"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Samples a value according to a clock as part of the <a href=\"modelica://ModelicaReference.Synchronous\">synchronous language elements</a>.
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>sample</strong>(u)</pre></blockquote>
<blockquote><pre><strong>sample</strong>(u, c)</pre></blockquote>
<h4>Description</h4>
<p>
 The operator returns a clocked variable that has c as associated clock and has the value of the
 left limit of u when c is active (that is the value of u just before the event of c is triggered).
 If argument c is not provided, it is inferred
</p>
<p>
The return argument has the same type as the first input argument.
The optional argument c is of type Clock.
</p>
</html>"));
  end 'sample()clocked';

  class 'scalar()' "scalar()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Returns a one-element array as scalar
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>scalar</strong>(A)</pre></blockquote>
<h4>Description</h4>
<p>
Returns the single element of array A.
<strong>size</strong>(A,i) = 1 is required for 1 &le; i &le; <strong>ndims</strong>(A).
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
<blockquote><pre><strong>semiLinear</strong>(x, positiveSlope, negativeSlope)</pre></blockquote>
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
<strong>Rule 1</strong>: The equations
</p>
<blockquote><pre>
y = <strong>semiLinear</strong>(x, sa, s1);
y = <strong>semiLinear</strong>(x, s1, s2);
y = <strong>semiLinear</strong>(x, s2, s3);
   ...
y = <strong>semiLinear</strong>(x, sN, sb);
</pre></blockquote>
<p>
may be replaced by
</p>
<blockquote><pre>
s1 = <strong>if</strong> x >= 0 <strong>then</strong> sa <strong>else</strong> sb
s2 = s1;
s3 = s2;
   ...
sN = sN-1;
y = <strong>semiLinear</strong>(x, sa, sb);
</pre></blockquote>
<p>
<strong>Rule 2</strong>: The equations
</p>
<blockquote><pre>
x = 0;
y = 0;
y = <strong>semiLinear</strong>(x, sa, sb);
</pre></blockquote>
<p>
may be replaced by
</p>
<blockquote><pre>
x = 0
y = 0;
sa = sb;
</pre></blockquote>
<p>
<em> [For symbolic transformations, the following property is
useful (this follows from the definition):</em>
</p>
<blockquote><pre>
<strong>semiLinear</strong>(m_flow, port_h, h);
</pre></blockquote>
<p>
is identical to
</p>
<blockquote><pre>
-<strong>semiLinear</strong>(-m_flow, h, port_h);
</pre></blockquote>
<p>
<em> The semiLinear function is designed to handle reversing
flow in fluid systems, such as</em>
</p>
<blockquote><pre>
H_flow = <strong>semiLinear</strong>(m_flow, port.h, h);
</pre></blockquote>
<p>
<em> i.e., the enthalpy flow rate H _flow is computed from the mass flow
rate m_flow and the upstream specific enthalpy depending on the
flow direction.]</em>
</p>
</html>"));
  end 'semiLinear()';

  class 'shiftSample()' "shiftSample()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Shifts a clocked expressions to delay it as part of the <a href=\"modelica://ModelicaReference.Synchronous\">synchronous language elements</a>.
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>shiftSample</strong>(u, shiftCounter, resolution)</pre></blockquote>
<h4>Examples</h4>
<blockquote><pre>
  Clock u  = Clock(3, 10);
  // ticks: 0, 3/10, 6/10, ..

  Clock y1 = shiftSample(u,1,3);
  // ticks: 1/10, 4/10, ...

  Real x=sample(time, u);
  // Ticks at 0, 3/10, 6/10 with values corresponding to time

  Real x2=shiftSample(x, 1, 3);
  // Ticks at 1/10 with value 0/10, and at 4/10 with value 3/10 etc
</pre></blockquote>
</html>"));
  end 'shiftSample()';

  class 'sign()' "sign()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Sign function of a Real or Integer number
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>sign</strong>(v)</pre></blockquote>
<h4>Description</h4>
<p>Is expanded into &quot;noEvent(<strong>if</strong> v &gt; 0 <strong>then</strong> 1 <strong>else
if</strong> v &lt; 0 <strong>then</strong> -1 <strong>else</strong> 0)&quot;. Argument v
needs to be an Integer or Real expression.</p>
<h4>Examples</h4>
<blockquote><pre><strong>sign</strong>({-3, 0, 3})
 = {-1, 0, 1}</pre></blockquote>
</html>"));
  end 'sign()';

  class 'sin()' "sin()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Trigonometric sine function
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>sin</strong>(u)</pre></blockquote>
<h4>Description</h4>
<p>Returns the sine of u, with -&infin; &lt; u &lt; &infin;.
Argument u needs to be an Integer or Real expression.</p>

<p>
The sine function can also be accessed as Modelica.Math.sin.
</p>

<div>
<img src=\"modelica://ModelicaReference/Resources/Images/sin.png\" alt=\"sin\">
</div>

<h4>Examples</h4>
<blockquote><pre><strong>sin</strong>(3.14159265358979)
 = 0.0</pre></blockquote>
</html>"));
  end 'sin()';

  class 'sinh()' "sinh()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Hyperbolic sine function
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>sinh</strong>(u)</pre></blockquote>
<h4>Description</h4>
<p>Returns the sinh of u, with -&infin; &lt; u &lt; &infin;.
Argument u needs to be an Integer or Real expression.</p>

<p>
The sinh function can also be accessed as Modelica.Math.sinh.
</p>

<div>
<img src=\"modelica://ModelicaReference/Resources/Images/sinh.png\" alt=\"sinh\">
</div>

<h4>Examples</h4>
<blockquote><pre><strong>sinh</strong>(1)
  = 1.1752011936438</pre></blockquote>
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
   <strong>size</strong>(A,i)
   <strong>size</strong>(A)
</pre></blockquote>
<h4>Description</h4>
<p>
The first form returns the size of dimension i of array expression A
where i shall be &gt; 0 and &le; <strong>ndims</strong>(A).
</p>
<p>
The second form returns a vector of length <strong>ndims</strong>(A)
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
<blockquote><pre><strong>skew</strong>(x)</pre></blockquote>
<h4>Description</h4>
<p>
Returns the 3 x 3 skew symmetric matrix associated with a
3-vector, i.e.,
</p>
<blockquote><pre>
<strong>cross</strong>(x,y) = <strong>skew</strong>(x)*y;
<strong>skew</strong>(x) = [ 0   , -x[3],  x[2];
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
<blockquote><pre><strong>smooth</strong>(p, expr)</pre></blockquote>
<h4>Description</h4>
<p>If p&gt;=0 <strong>smooth</strong>(p, expr) returns expr and states
that expr is p times continuously differentiable, i.e.: expr
is continuous in all real variables appearing in the expression
and all partial derivatives with respect to all appearing real
variables <strong>exist</strong> and are continuous up to order p.</p>
<p>The only allowed types for expr in smooth are: real expressions,
arrays of allowed expressions, and records containing only
components of allowed expressions.</p>
<h4>smooth vs. noEvent</h4>
<p>The noEvent operator implies that real elementary expressions are taken
literally instead of generating crossing functions. The smooth operator
should be used instead of noEvent, in order to avoid events for efficiency
reasons. A tool is free to not generate events for expressions inside smooth.
However, smooth does not guarantee that no events will be generated, and thus
it can be necessary to use noEvent inside smooth. <em>[Note that smooth does
not guarantee a smooth output if any of the occurring variables change
discontinuously.]</em></p>
<h4>Examples</h4>
<blockquote><pre>  Real x, y, z;
<strong>equation</strong>
  x = <strong>if</strong> time&lt;1 <strong>then</strong> 2 <strong>else</strong> time-2;
  z = smooth(0, <strong>if</strong> time&lt;0 <strong>then</strong> 0 <strong>else</strong> time);
  y = smooth(1, noEvent(<strong>if</strong> x&lt;0 <strong>then</strong> 0 <strong>else</strong> sqrt(x)*x));
  // noEvent is necessary.</pre></blockquote>
</html>"));
  end 'smooth()';

  class 'sqrt()' "sqrt()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Square root
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>sqrt</strong>(v)</pre></blockquote>
<h4>Description</h4>
<p>Returns the square root of v if v&gt;=0, otherwise an error occurs.
Argument v needs to be an Integer or Real expression.</p>
<h4>Examples</h4>
<blockquote><pre><strong>sqrt</strong>(9)
 = 3.0</pre></blockquote>
</html>"));
  end 'sqrt()';

  class 'String()' "String()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Convert a scalar Real, Integer or Boolean expression to a String representation
</p>
<h4>Syntax</h4>
<blockquote><pre>
<strong>String</strong>(b_expr, minimumLength=0, leftJustified=true)
<strong>String</strong>(i_expr, minimumLength=0, leftJustified=true)
<strong>String</strong>(r_expr, significantDigits=6, minimumLength=0, leftJustified=true)
<strong>String</strong>(r_expr, format)
<strong>String</strong>(e_expr, minimumLength=0, leftJustified=true)
</pre></blockquote>
<h4>Description</h4>
<p>
The arguments have the following meaning
(the default values of the optional arguments are shown in the left column):
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
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
  <td> Minimum length of the resulting string. If necessary,<br>
       the blank character is used to fill up unused space.</td></tr>
<tr>
  <td> Boolean leftJustified = <strong>true</strong> </td>
  <td> if <strong>true</strong>, the converted result is left justified;<br>
       if <strong>false</strong>, it is right justified in the string.</td></tr>
<tr>
  <td> Integer significantDigits = 6 </td>
  <td> defines the number of significant digits in the result string<br>
       (e.g., \"12.3456\", \"0.0123456\", \"12345600\", \"1.23456E-10\")</td></tr>
<tr>
  <td> String format </td>
  <td> defines the string formatting according to ANSI-C without \"%\" and \"*\" character<br>
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
       least this wide and wider if necessary. If the converted number has<br>
       fewer characters it will be padded on the left (or the right depending<br>
       on &lt;flags&gt;) with blanks or 0 (depending on &lt;flags&gt;).</td></tr>
<tr>
  <td>&lt;precision&gt;</td>
  <td> The number of digits to be printed after the decimal point for<br>
       e, E, or f conversions, or the number of significant digits for<br>
       g or G conversions.</td></tr>
<tr>
  <td> &lt;conversion&gt;</td>
  <td> = \"e\": Exponential notation using a  lower case e<br>
       = \"E\": Exponential notation using an upper case E<br>
       = \"f\": Fixed point notation<br>
       = \"g\": Either \"e\" or \"f\"<br>
       = \"G\": Same as \"g\", but with upper case E</td></tr></table></td></tr>
</table>
<h4>Examples</h4>
<blockquote><pre>
String(2.0)   // = \"2.0\"
String(true)  // = \"true\"
String(123, minimumLength=6, leftJustified=false)  // = \"   123\"
</pre></blockquote>
</html>"));
  end 'String()';

  class 'subSample()' "subSample()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Subsamples a clocked expressions as part of the <a href=\"modelica://ModelicaReference.Synchronous\">synchronous language elements</a>.
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>subSample</strong>(u, factor)</pre></blockquote>
<h4>Description</h4>
<p>
The clock of <strong>y = subSample(u,factor)</strong> is <strong>factor</strong>-times slower than the clock of <strong>u</strong>.
At every <strong>factor</strong> ticks of the clock of <strong>u</strong>, the operator returns the value of <strong>u</strong>.
The first activation of the clock of <strong>y</strong> coincides with the first activation of the clock of <strong>u</strong>.
If argument <strong>factor</strong> is not provided or is equal to zero, it is inferred.
</p>
</html>"));
  end 'subSample()';

  class 'sum()' "sum()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Returns the scalar sum
</p>
<h4>Syntax</h4>
<blockquote><pre>
<strong>sum</strong>(A)
<strong>sum</strong>(e(i, ..., j) <strong>for</strong> i <strong>in</strong> u, ..., j <strong>in</strong> v)
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
The type of <strong>sum</strong>(e(i, ..., j) <strong>for</strong> i <strong>in</strong>
u, ..., j <strong>in</strong> v) is the same as the type of e(i,...j).
</p>
<h4>Examples</h4>
<blockquote><pre>
<strong>sum</strong>(i <strong>for</strong> i <strong>in</strong> 1:10)  // Gives  1+2+...+10=55
   // Read it as: compute the sum of i for i in the range 1 to 10.
</pre></blockquote>
</html>"));
  end 'sum()';

  class 'superSample()' "superSample()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Supersamples a clocked expressions as part of the <a href=\"modelica://ModelicaReference.Synchronous\">synchronous language elements</a>.
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>superSample</strong>(u, factor)</pre></blockquote>
<h4>Description</h4>
<p>
The clock of <strong>y = superSample(u,factor)</strong> is <strong>factor</strong>-times faster than the clock of <strong>u</strong>.
At every tick of the clock of <strong>u</strong>, the operator returns the value of <strong>u</strong>.
The first activation of the clock of <strong>y</strong> coincides with the first activation of the clock of <strong>u</strong>.
If argument <strong>factor</strong> is not provided or is equal to zero, it is inferred.
</p>
</html>"));
  end 'superSample()';

  class 'symmetric()' "symmetric()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Returns a symmetric matrix
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>symmetric</strong>(A)</pre></blockquote>
<h4>Description</h4>
<p>
Returns a matrix where the diagonal elements and the
elements above the diagonal are identical to the
corresponding elements of matrix A and where the
elements below the diagonal are set equal to the elements
above the diagonal of A, i.e.,
</p>
<blockquote><pre>
B := <strong>symmetric</strong>(A)
     -> B[i,j] := A[i,j], <strong>if</strong> i &le; j,
        B[i,j] := A[j,i], <strong>if</strong> i &gt; j.
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
<blockquote><pre><strong>tan</strong>(u)</pre></blockquote>
<h4>Description</h4>
<p>Returns the tangent of u, with -&infin; &lt; u &lt; &infin;
(if u is a multiple of (2n-1)*pi/2, y = tan(u) is +/- infinity).
Argument u needs to be an Integer or Real expression.</p>

<p>
The tangent function can also be accessed as Modelica.Math.tan.
</p>

<div>
<img src=\"modelica://ModelicaReference/Resources/Images/tan.png\" alt=\"tan\">
</div>

<h4>Examples</h4>
<blockquote><pre><strong>tan</strong>(3.14159265358979)
 = 0.0
</pre></blockquote>
</html>"));
  end 'tan()';

  class 'tanh()' "tanh()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Hyperbolic tangent function
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>tanh</strong>(u)</pre></blockquote>
<h4>Description</h4>
<p>Returns the tanh of u, with -&infin; &lt; u &lt; &infin;.
Argument u needs to be an Integer or Real expression.</p>

<p>
The tanh function can also be accessed as Modelica.Math.tanh.
</p>

<div>
<img src=\"modelica://ModelicaReference/Resources/Images/tanh.png\" alt=\"tanh\">
</div>

<h4>Examples</h4>
<blockquote><pre><strong>tanh</strong>(1)
  = 0.761594155955765</pre></blockquote>
</html>"));
  end 'tanh()';

  class 'terminal()' "terminal()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
True after successful analysis
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>terminal</strong>()</pre></blockquote>
<h4>Description</h4>
<p>Returns <strong>true</strong> at the end of a successful analysis.</p>
<h4>Examples</h4>
<blockquote><pre>  Boolean a, b;
<strong>equation</strong>
  a = <strong>change</strong>(b) or <strong>terminal</strong>();</pre></blockquote>
</html>"));
  end 'terminal()';

  class 'terminate()' "terminate()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Successfully terminate current analysis
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>terminate</strong>(message)</pre></blockquote>
<h4>Description</h4>
<p>The terminate function successfully terminates the analysis
which was carried out. The function has a string argument
indicating the reason for the success. <em>[The intention is to
give more complex stopping criteria than a fixed point in time.]</em></p>
<h4>Examples</h4>
<blockquote><pre><strong>model</strong> ThrowingBall
  Real x(start=0);
  Real y(start=1);
<strong>equation</strong>
  <strong>der</strong>(x)= ... ;
  <strong>der</strong>(y)= ... ;
<strong>algorithm</strong>
  <strong>when</strong> y &lt; 0 <strong>then</strong>
    <strong>terminate</strong>(\"The ball touches the ground\");
  <strong>end when;
end</strong> ThrowingBall;</pre></blockquote>
</html>"));
  end 'terminate()';

  class 'ticksInState()' "ticksInState()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
This operator returns the number of ticks since a transition was made to the active state in a <a href=\"modelica://ModelicaReference.StateMachines\">state machine</a>.
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>ticksInState</strong>()</pre></blockquote>
<h4>Description</h4>
<p>
Returns the number of ticks of the clock of the state machine since a transition was made to the currently active state.
</p>
</html>"));
  end 'ticksInState()';

  class 'timeInState()' "timeInState()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
This operator returns the time (in seconds) since a transition was made to the active state in a <a href=\"modelica://ModelicaReference.StateMachines\">state machine</a>.
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>timeInState</strong>()</pre></blockquote>
<h4>Description</h4>
<p>
Returns the time duration as Real in [s] since a transition was made to the currently active state.
</p>
</html>"));
  end 'timeInState()';

  class 'transition()' "transition()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
This operator defines a transition in a <a href=\"modelica://ModelicaReference.StateMachines\">state machine</a>.
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>transition</strong>(from, to, condition, immediate, reset, synchronize, priority)</pre></blockquote>
<h4>Description</h4>
<p>
This operator defines a transition from instance <strong>from</strong> to instance <strong>to</strong>.
The <strong>from</strong> and <strong>to</strong> instances become states of a state machine.
The transition fires when <strong>condition = true</strong> if <strong>immediate = true</strong> (this is called an immediate transition)
or <strong>previous(condition)</strong> when <strong>immediate = false</strong> (this is called a delayed transition).
Argument <strong>priority</strong> defines the priority of firing when several transitions could fire.
In this case the transition with the smallest value of <strong>priority</strong> fires.
It is required that priority is greater or equal to 1 and that for all transitions from the same state, the priorities are different.
If <strong>reset = true</strong>, the states of the target state are reinitialized, i.e. state machines are restarted in initial state and state variables are reset to their start values. If synchronize=true, any transition is disabled until all state machines of the from-state have reached final states, i.e. states without outgoing transitions.
</p>
<p>
Arguments <strong>from</strong> and <strong>to</strong> are block instances and <strong>condition</strong>
is a Boolean argument. The optional arguments <strong>immediate</strong>, <strong>reset</strong>, and <strong>synchronize</strong>
are of type Boolean, have parametric variability and a default of true, true, false respectively.
The optional argument <strong>priority</strong> is of type Integer, has parametric variability and a default of 1.
</p>
</html>"));
  end 'transition()';

  class 'transpose()' "transpose()"
    extends ModelicaReference.Icons.Information;
    annotation (Documentation(info="<html>
<p>
Transpose of a matrix or permutation of the first two dimensions of an array
</p>
<h4>Syntax</h4>
<blockquote><pre><strong>transpose</strong>(A)</pre></blockquote>
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
<blockquote><pre><strong>vector</strong>(A)</pre></blockquote>
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
<blockquote><pre><strong>zeros</strong>(n1, n2, n3, ...)</pre></blockquote>
<h4>Description</h4>
<p>
Returns the n1 x n2 x n3 x ... Integer array with all
elements equal to zero (ni >= 0).
</p>
</html>"));
  end 'zeros()';
  annotation (Documentation(info="<html>
<p>
In this chapter <strong>operators</strong> of Modelica are documented.
Elementary operators, such as \"+\" or \"-\" are overloaded and
operate on scalar and array variables. Other operators
have the same syntax as a
<a href=\"modelica://ModelicaReference.Classes.'function'\">Modelica function</a>
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

<blockquote><pre>   <strong>partial model</strong> BaseCorrelation
     <strong>input</strong> Real x;
     Real y;
   <strong>end</strong> BaseCorrelation;

   <strong>model</strong> SpecialCorrelation // correct in Modelica 2.2 and 3.0
      <strong>extends</strong> BaseCorrelation(x=2);
   <strong>equation</strong>
       y=2/x;
   <strong>end</strong> SpecialCorrelation;

   <strong>model</strong> UseCorrelation // correct according to Modelica 2.2
                        // not valid according to Modelica 3.0
      <strong>replaceable model</strong> Correlation=BaseCorrelation;
      Correlation correlation;
   <strong>equation</strong>
      correlation.y=time;
   <strong>end</strong> UseCorrelation;

   <strong>model</strong> Broken // after redeclaration, there is 1 equation too much in Modelica 2.2
      UseCorrelation example(redeclare Correlation=SpecialCorrelation);
   <strong>end</strong> Broken;
</pre></blockquote>

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
<strong>Definition 1: Local Number of Unknowns</strong>
</p>

<p>
The local number of unknowns of a model or block class is the sum based on the components:
</p>

<ul>
<li> For each declared component of specialized class type (Real, Integer, String, Boolean, enumeration and arrays of those, etc.) or record, not declared as outer, it is the \"number of unknown variables\" inside it (i.e., excluding parameters and constants and counting the elements after expanding all records and arrays to a set of scalars of primitive types).</li>

<li> Each declared component  of specialized class type or record declared as outer is ignored [i.e., all variables inside the component are treated as known].</li>

<li> For each declared component of specialized class connector component, it is the \"number of unknown variables\" inside it (i.e., excluding parameters and constants and counting the elements after expanding all records and arrays to a set of scalars of primitive types).</li>

<li> For each declared component of specialized class block or model, it is the \"sum of the number of inputs and flow variables\" in the (top level) public connector components of these components (and counting the elements after expanding all records and arrays to a set of scalars of primitive types).</li>
</ul>

<p>
<strong>Definition 2: Local Equation Size</strong>
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
<blockquote><pre>  model M
    input Real u;
    input Real u2=2;
  end M;
</pre></blockquote>
Here \"u\" and \"u2\" are top-level inputs and not connectors. The variable u2 has a binding equation, but u does not have a binding equation. In the equation count, it is assumed that an equation for u is supplied when using the model.]</li>
</ul>

<p>
<strong>Definition 3: Locally Balanced</strong>
</p>

<p>
A model or block class is \"locally balanced\" if the \"local number of unknowns\" is identical to the \"local equation size\" for all legal values of constants and parameters [respecting final bindings and min/max-restrictions. A tool shall verify the \"locally balanced\" property for the actual values of parameters and constants in the simulation model. It is a quality of implementation  for a tool to verify this property in general, due to arrays of (locally) undefined sizes, conditional declarations, for loops, etc.].
</p>

<p>
<strong>Definition 4: Globally Balanced</strong>
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
<li>In a non-partial model or block, all non-connector inputs of model or block components must have binding equations. [E.g., if the model contains a component, firstOrder (of specialized class model) and firstOrder has  \"input Real u\" then there must be a binding equation for firstOrder.u.]</li>
<li>A component declared with the inner or outer prefix shall not be of a class having top-level public connectors containing inputs.</li>
<li>Modifiers for components shall only contain redeclarations of replaceable elements and binding equations for parameters, constants (that do not yet have binding equations), inputs and variables having a default binding equation.</li>
<li>All non-partial model and block classes must be locally balanced [this means that the local number of unknowns equals the local equation size].</li>
</ul>

<p>
Based on these restrictions, the following strong guarantee can be given for simulation models and blocks:
</p>

<p>
<strong>Proposition 1: All simulation models and blocks are globally balanced.</strong><br>
[Therefore the number of unknowns equal to the number of equations of a simulation model or block, provided that every used non-partial model or block class is locally balanced.]
</p>

<blockquote><pre>Example 1:

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
</pre></blockquote>

<p>
Model Capacitor is a locally balanced model according to the following analysis:
</p>

<blockquote><pre>Locally unknown variables: p.i, p.v, n.i, n.v, u
Local equations:  0 = p.i + n.i;
                  u = p.v - n.v;
                  C*der(u) = p.i;
                  and 2 equations corresponding to the
                  2 flow-variables p.i and n.i.
</pre></blockquote>

<p>
These are 5 equations in 5 unknowns (locally balanced model). A more detailed analysis would reveal that this is structurally non-singular, i.e., that the hybrid DAE will not contain a singularity independent of actual values.
If the equation \"u = p.v - n.v\" would be missing in the Capacitor model, there would be 4 equations in 5 unknowns and the model would be locally unbalanced and thus simulation models in which this model is used would be usually  structurally singular and  thus not solvable.
If the equation \"u = p.v - n.v\" would be replaced by the equation \"u = 0\" and the equation C*der(u) = p.i would be replaced by the equation \"C*der(u) = 0\", there would be 5 equations in 5 unknowns (locally balanced), but the equations would be singular, regardless of how the equations corresponding to the flow-variables are constructed because the information that \"u\" is constant is given twice in a slightly different form.
</p>

<blockquote><pre>Example 2:

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
</pre></blockquote>

<p>
Since t is partial we cannot check whether this is a globally balanced model, but we can check that Circuit is locally balanced.
Counting on  model Circuit results in the following balance sheet:
</p>

<blockquote><pre>Locally unknown variables (8): p.i, p.v, n.i, n.v, and 2 flow variables for t (t.p.i, t.n.i)
                                                   and 2 flow variable for c (c.p.i, c.n.i).
Local equations:     p.v = t.p.v;
                       0 = p.i - t.p.i;
                   c.p.v = load.n.v;
                       0 = c.p.i+load.n.i;
                     n.v = c.n.v;
                       0 = n.i - c.n.i;
                    and 2 equation corresponding to the
                    flow variables p.i, n.i
</pre></blockquote>

<p>
In total we have 8 scalar unknowns and 8 scalar equations, i.e., a locally balanced model (and this feature holds for any models used for the replaceable component \"t\").
Some more analysis reveals that this local set of equations and unknowns is structurally non-singular. However, this does not provide any guarantees for the global set of equations, and specific combinations of models that are \"locally non-singular\" may lead to a globally non-singular model.]
</p>

<blockquote><pre>Example 3:

import Modelica.Units.SI;
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
</pre></blockquote>

<p>
The use of connector here is a special design pattern. The variables p, h, Xi are marked as input to get correct equation count. Since they are connectors they should neither be given binding equations in derived classes nor when using the model. The design pattern is to give textual equations for them (as below); using connect-statements for these connectors would be possible (and would work) but is not part of the design.
This partial model defines that T,d,u can be computed from the medium model, provided p,h,Xi are given. Every medium with one or multiple substances and one or multiple phases, including incompressible media, has the property that T,d,u can be computed from p,h,Xi. A particular medium may have different \"independent variables\" from which all other intrinsic thermodynamic variables can be recursively computed. For example, a simple air model could be defined as:
</p>

<blockquote><pre>model SimpleAir \"Medium model of simple air. Independent variables: p,T\"
   extends BaseProperties(nXi = 0,
        p(stateSelect = if preferredMediumStates then StateSelect.prefer
                                   else StateSelect.default),
        T(stateSelect = if preferredMediumStates then StateSelect.prefer
                                   else StateSelect.default));
   constant SI.SpecificHeatCapacity R_s  = 287;
   constant SI.SpecificHeatCapacity cp = 1005.45;
   constant SI.Temperature          T0 = 298.15
equation
   d = p/(R_s*T);
   h = cp*(T-T0);
   u = h - p/d;
end SimpleAir;
</pre></blockquote>

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

<blockquote><pre>import Modelica.Units.SI;
connector FluidPort
  replaceable model Medium = BaseProperties;

  SI.AbsolutePressure  p;
  flow SI.MassFlowRate m_flow;

  SI.SpecificEnthalpy      h;
  flow SI.EnthalpyFlowRate H_flow;

  SI.MassFraction       Xi     [Medium.nXi] \"Independent mixture mass fractions\";
  flow SI.MassFlowRate mXi_flow[Medium.nXi] \"Independent substance mass flow rates\";
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
</pre></blockquote>

<p>
The local number of unknowns of DynamicVolume is:
</p>

<ul>
<li> 4+2*nXi (inside the port connector), plus</li>
<li> 2+nXi (variables U, M and MXi), plus</li>
<li> 2+nXi (the input variables in the connectors of the medium model)</li>
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

<blockquote><pre>model FixedBoundary_pTX
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
</pre></blockquote>

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

class 'encapsulated' "encapsulated"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Break lookup in hierarchy
</p>
<h4>Examples</h4>

<blockquote><pre><strong>encapsulated model</strong> Test
  <strong>import</strong> Modelica.Mechanics.Rotational;

  Rotational.Components.Inertia inertia; // lookup successful
  Modelica.Mechanics.Translational.SlidingMass slidingMass; // lookup fails
<strong>equation</strong>
  ...
<strong>end</strong> Test;</pre></blockquote>

<h4>Syntax</h4>

<p>See section on <code>class_definition</code> in the <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica Grammar</a>.</p>

<h4>Description</h4>

<p>When an element, equation or algorithm is instantiated, any name is
looked up sequentially in each member of the ordered set of parents
until a match is found or a parent is encapsulated. In the latter case
the lookup stops except for the predefined types, functions and
operators defined in this specification. For these cases the lookup
continues in the global scope, where they are defined. <em>[E.g., abs is
searched upwards in the hierarchy as usual. If an encapsulated boundary
is reached, abs is searched in the global scope instead. The operator
abs cannot be redefined in the global scope, because an existing class
cannot be redefined at the same level.]</em></p>
</html>"));
end 'encapsulated';

class 'extends' "extends"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Inheritance from base class
</p>
<h4>Examples</h4>

<blockquote><pre><strong>class</strong> A
  <strong>parameter</strong> Real a, b;
<strong>end</strong> A;

<strong>class</strong> B
  <strong>extends</strong> A(b=2);
<strong>end</strong> B;

<strong>class</strong> C
  <strong>extends</strong> B(a=1);
<strong>end</strong> C;</pre></blockquote>

<p>From the example above we get the following instantiated
class:</p>

<blockquote><pre><strong>class</strong> Cinstance
  <strong>parameter</strong> Real a=1;
  <strong>parameter</strong> Real b=2;
<strong>end</strong> Cinstance;</pre></blockquote>

<p>The ordering of the merging rules ensures that, given
classes A and B defined above,</p>

<blockquote><pre><strong>class</strong> C2
  B bcomp(b=3);
<strong>end</strong> C2;</pre></blockquote>

<p>yields an instance with <code>bcomp.b=3</code>, which overrides <code>b=2</code>.</p>

<h4>Syntax</h4>

<p>See section on <code>extends_clause</code> in the <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica Grammar</a>.</p>

<h4>Description</h4>

<p>The name of the base class is looked up in the partially
instantiated parent of the extends clause. The found base
class is instantiated with a new environment and the
partially instantiated parent of the extends clause. The new
environment is the result of merging</p>

<ol>
  <li>arguments of all parent environments that match names in the instantiated base class</li>
  <li>the optional class modification of the extends clause</li>
</ol>

<p>in that order.</p>

<p>The elements of the instantiated base class become elements
of the instantiated parent class.</p>

<p>The declaration elements of the instantiated base class shall either</p>

<ul>
  <li>not already exist in the partially instantiated parent class
      <em>[i.e., have different names]</em>.</li>
  <li>be exactly identical to any element of the instantiated parent
      class with the same name and the same level of protection
      (<strong>public</strong> or <strong>protected</strong>) and same contents. In this
      case, one of the elements is ignored (since they are identical
      it does not matter which one).</li>
</ul>

<p>Otherwise the model is incorrect.</p>

<p>Equations of the instantiated base class that are syntactically
equivalent to equations in the instantiated parent class are discarded.
<em>[Note: equations that are mathematically equivalent but not
syntactically equivalent are not discarded, hence yield an
overdetermined system of equations.]</em></p>

<p>Since specialized classes of different kinds have different properties,
only specialized classes that are \"in some sense compatible\" to each other
can be derived from each other via inheritance. The following table
shows which kind of specialized class can be used in an extends clause of
another kind of specialized class (the \"grey\" cells mark the few exceptional
cases, where a specialized class can be derived from a specialized class of
another kind):</p>

<table border=\"1\" cellpadding=\"1\" cellspacing=\"1\" >
<thead>
<tr>
  <th></th><th colspan=\"12\">Base Class</th>
</tr>
<tr>
  <td><strong>Derived Class</strong></td>
  <td>package</td>
  <td>operator</td>
  <td>function</td>
  <td>operator function</td>
  <td>type</td>
  <td>record</td>
  <td>operator record</td>
  <td>expandable connector</td>
  <td>connector</td>
  <td>block</td>
  <td>model</td>
  <td>class</td>
</tr>
</thead>
<tbody>
<tr>
  <td>package</td>
  <td>yes</td>
  <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
  <td style=\"background-color:lightgray\">yes</td>
</tr>
<tr>
  <td>operator</td>
  <td></td>
  <td>yes</td>
  <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
  <td style=\"background-color:lightgray\">yes</td>
</tr>
<tr>
  <td>function</td>
  <td></td>
  <td></td>
  <td>yes</td>
  <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
  <td style=\"background-color:lightgray\">yes</td>
</tr>
<tr>
  <td>operator<br>function</td>
  <td></td>
  <td></td>
  <td style=\"background-color:lightgray\">yes</td>
  <td>yes</td>
  <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
  <td style=\"background-color:lightgray\">yes</td>
</tr>
<tr>
  <td>type</td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td>yes</td>
  <td></td><td></td><td></td><td></td><td></td><td></td>
  <td style=\"background-color:lightgray\">yes</td>
</tr>
<tr>
  <td>record</td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td>yes</td>
  <td></td><td></td><td></td><td></td><td></td>
  <td style=\"background-color:lightgray\">yes</td>
</tr>
<tr>
  <td>operator<br>record</td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td>yes</td>
  <td></td><td></td><td></td><td></td>
  <td style=\"background-color:lightgray\">yes</td>
</tr>
<tr>
  <td>expandable<br>connector</td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td>yes</td>
  <td></td><td></td><td></td>
  <td style=\"background-color:lightgray\">yes</td>
</tr>
<tr>
  <td>connector</td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td style=\"background-color:lightgray\">yes</td>
  <td style=\"background-color:lightgray\">yes</td>
  <td style=\"background-color:lightgray\">yes</td>
  <td style=\"background-color:lightgray\">yes</td>
  <td>yes</td>
  <td></td><td></td>
  <td style=\"background-color:lightgray\">yes</td>
</tr>
<tr>
  <td>block</td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td style=\"background-color:lightgray\">yes</td>
  <td></td>
  <td></td>
  <td></td>
  <td>yes</td>
  <td></td>
  <td style=\"background-color:lightgray\">yes</td>
</tr>
<tr>
  <td>model</td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td style=\"background-color:lightgray\">yes</td>
  <td></td>
  <td></td>
  <td></td>
  <td style=\"background-color:lightgray\">yes</td>
  <td>yes</td>
  <td style=\"background-color:lightgray\">yes</td>
</tr>
<tr>
  <td>class</td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td>yes</td>
</tr>
</tbody>
</table>

<p>The specialized classes <code>package</code>, <code>operator</code>,
<code>function</code>, <code>type</code>, <code>record</code>,
<code>operator record</code> and <code>expandable connector</code>
can only be derived from their own kind
[<em>(e.g., a package can only be base class for packages.
All other kinds of classes can use the import statement to use the contents
of a package)</em>] and from <code>class</code>.</p>

</html>"));
end 'extends';

class 'flow' "flow"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Declare flow (through) variable, which have to sum up to zero in connections
</p>
<h4>Examples</h4>

<blockquote><pre><strong>connector</strong> Pin
  Modelica.Units.SI.Voltage v;
  <strong>flow</strong> Modelica.Units.SI.Current i;
<strong>end</strong> Pin;

<strong>model</strong> A
  Pin p;
<strong>end</strong> A;

<strong>model</strong> Composition
  A a;
  A b;
  A c;
<strong>equation
  connect</strong>(a.p, b.p);
  <strong>connect</strong>(a.p, c.p);
<strong>end</strong> Composition;</pre></blockquote>

<p>From the connect statements in model Composition, the following connect equations are derived:</p>

<blockquote><pre>a.p.v = b.p.v;
a.p.v = c.p.v;
a.p.i + b.p.i + c.p.i = 0;</pre></blockquote>

<h4>Syntax</h4>

<p>See section on <code>type_prefix</code> in the <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica Grammar</a>.</p>

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
<strong>for</strong> clauses are mostly used in algorithm sections, such as
</p>
<blockquote><pre>
    <strong>parameter</strong> Integer np=10;
    Real p[np], x, y;
  <strong>algorithm</strong>
     y := p[1];
     <strong>for</strong> i <strong>in</strong> 2:np <strong>loop</strong>   // i shall not be declared
        y := y*x + p[i];
     <strong>end for</strong>;
</pre></blockquote>
<p>
Other forms of the <strong>for</strong> condition:
</p>
<blockquote><pre>
    <strong>for</strong> i <strong>in</strong> 1:10 <strong>loop</strong>            // i takes the values 1,2,3,...,10
    <strong>for</strong> r <strong>in</strong> 1.0 : 1.5 : 5.5 <strong>loop</strong> // r takes the values 1.0, 2.5, 4.0, 5.5
    <strong>for</strong> i <strong>in</strong> {1,3,6,7} <strong>loop</strong>       // i takes the values 1, 3, 6, 7
</pre></blockquote>
<p>
In equation sections, <strong>for</strong> clauses are expanded at translation time
in order that symbolic transformations can be applied. Typically, a
<strong>for</strong> clause in an equation section is used on component arrays,
e.g., to connect elements of an array of components together:
</p>
<blockquote><pre>
    <strong>parameter</strong> Integer nR=10 \"Number of resistances\";
    Modelica.Electrical.Analog.Basic.Resistor R[nR];
  <strong>equation</strong>
     <strong>for</strong> i <strong>in</strong> 1:nR-1 <strong>loop</strong>
        <strong>connect</strong>(R[i].p R[i+1].n);   // 9 connect equations
     <strong>end for</strong>;
</pre></blockquote>
<h4>Syntax</h4>
<p>
In equation sections:
</p>
<blockquote><pre>
  <strong>for</strong> for_indices <strong>loop</strong>
     { equation \";\" }
  <strong>end for</strong>;
  for_indices : for_index {\",\" for_index}
  for_index   : IDENT [ in expression ]
</pre></blockquote>
<p>
In algorithm sections:
</p>
<blockquote><pre>
  <strong>for</strong> for_indices <strong>loop</strong>
     { algorithm \";\" }
  <strong>end for</strong>;
  for_indices : for_index {\",\" for_index}
  for_index   : IDENT [ in expression ]
</pre></blockquote>
<h4>Description</h4>
<p>A clause</p>
<blockquote><pre>    <strong>for</strong> IDENT <strong>in</strong> expression <strong>loop</strong></pre></blockquote>
<p>is one example of a for clause.</p>
<p>The expression of a for clause shall be a vector expression. It is
evaluated once for each for clause, and is evaluated in the scope
immediately enclosing the for clause. In an equation section,
the expression of a for clause shall be a parameter expression (in order
that the for clause can be expanded into equations during translation).
The loop-variable is in scope inside the loop-construct and shall not be assigned
to.</p>
<p><em>[Example:</em></p>
<p><em>The loop-variable may hide other variables as in the following example.
Using another name for the loop-variable
is, however, strongly recommended.</em></p>
<blockquote><pre>    <strong>constant</strong> Integer j=4;
    Real x[j];
  <strong>equation</strong>
    <strong>for</strong> j <strong>in</strong> 1:j <strong>loop</strong> // The loop-variable j takes the values 1,2,3,4
      x[j]=j; // Uses the loop-variable j
    <strong>end for</strong>;</pre></blockquote>
<p><em>]</em></p>
<h4>Several iterators</h4>
<p>The notation with several iterators is a shorthand notation for nested for-clauses (or reduction-expressions). For
for-clauses it can be expanded into the usual form by replacing each \",\" by <code>'loop for'</code> and adding extra <code>'end
for'</code>. For reduction-expressions it can be expanded into the usual form by replacing each ',' by <code>') for'</code> and
prepending the reduction-expression with <code>'function-name('</code>.</p>
<p><em>[Example:</em></p>
<blockquote><pre>    Real x[4,3];
  <strong>equation</strong>
    <strong>for</strong> j, i in 1:2 <strong>loop</strong>
      // The loop-variable j takes the values 1,2,3,4 (due to use)
      // The loop-variable i takes the values 1,2 (given range)
      x[j,i]=j+i;
    <strong>end for</strong>;</pre></blockquote>
<p><em>]</em></p>
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

<blockquote><pre>    <strong>parameter</strong> Boolean linear=true;
    <strong>parameter</strong> Boolean quadratic=false;
    Real x, y;
  <strong>equation</strong>
    <strong>if</strong> linear <strong>then</strong>
      y = x + 1;
    <strong>elseif</strong> quadratic <strong>then</strong>
      y = x^2 + x + 1;
    <strong>else</strong>
      y = Modelica.Math.sin(x) + 1;
    <strong>end if</strong>;</pre></blockquote>

<h4>If expression</h4>
<blockquote><pre>  Integer i;
  Integer sign_of_i=<strong>if</strong> i&lt;0 <strong>then</strong> -1 <strong>else if</strong> i==0 <strong>then</strong> 0 <strong>else</strong> 1;</pre></blockquote>
<h4>Syntax</h4>
<p>
In equation sections:
</p>
<blockquote><pre>   <strong>if</strong> expression <strong>then</strong>
     { equation \";\" }
   { <strong>elseif</strong> expression <strong>then</strong>
     { equation \";\" }
   }
   [ <strong>else</strong>
     { equation \";\" }
   ]
   <strong>end if</strong></pre></blockquote>
<p>
In algorithm sections:
</p>
<blockquote><pre>   <strong>if</strong> expression <strong>then</strong>
     { algorithm \";\" }
   { <strong>elseif</strong> expression <strong>then</strong>
     { algorithm \";\" }
   }
   [ <strong>else</strong>
     { algorithm \";\" }
   ]
   <strong>end if</strong></pre></blockquote>
<h4>Description</h4>
<h4>If clause</h4>
<p>
The expression of an <strong>if</strong> and <strong>elseif</strong>-clause must be scalar Boolean expression.
One <strong>if</strong>-clause, and zero or more <strong>elseif</strong>-clauses, and an optional <strong>else</strong>-clause
together form a list of branches. One or zero of the bodies of these <strong>if</strong>-, <strong>elseif</strong>-
and <strong>else</strong>-clauses is selected, by evaluating the conditions of the <strong>if</strong>- and
<strong>elseif</strong>-clauses sequentially until a condition that evaluates to true is found. If none of
the conditions evaluate to true the body of the <strong>else</strong>-clause is selected (if an
<strong>else</strong>-clause exists, otherwise no body is selected). In an algorithm section, the selected
body is then executed. In an equation section, the equations in the body are seen as equations
that must be satisfied. The bodies that are not selected have no effect on that model evaluation.
</p>
<p>
If clauses in <strong>equation</strong> sections which do not have exclusively parameter expressions as
switching conditions shall have an <strong>else</strong> clause and each branch shall have the <em>same
number</em> of <em>equations</em>. <em>[If this condition is violated, the single assignment rule
would not hold, because the number of equations may change during simulation although the number
of unknowns remains the same].</em>
</p>

<h4>If expression</h4>

<p>An expression</p>
<blockquote><pre>   <strong>if</strong> expression1 <strong>then</strong> expression2 <strong>else</strong> expression3</pre></blockquote>
<p>is one example of if-expression. First expression1, which must be Boolean expression,
is evaluated. If expression1 is true expression2 is evaluated and is the value of the
if-expression, else expression3 is evaluated and is the value of the if-expression.
The two expressions, expression2 and expression3, must be type compatible and give the
type of the if-expression. If-expressions with <strong>elseif</strong> are defined by replacing
<strong>elseif</strong> by <strong>else if</strong>.<em>[Note: elseif is added for symmetry with if-clauses.]</em>
</p>
</html>"));
end 'if';

class 'import' "import"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Import classes
</p>
<h4>Examples</h4>

<blockquote><pre><strong>class</strong> Lookup
  <strong>import</strong> SI = Modelica.Units.SI; // #1 (Try to avoid renaming imports!)
  <strong>import</strong> Modelica.Math.*; // #2 (Try to avoid wildcard imports!)
  <strong>import</strong> Modelica.Mechanics.Rotational; // #3
  <strong>import</strong> Modelica.Units.SI.{Molality, Molarity}; // #4

  SI.Torque torque; // due to #1 (Modelica.Units.SI.Torque)
  Rotational.Components.Inertia inertia; // due to #3 (Modelica.Mechanics.Rotational.Components.Inertia)
  Molarity c = 1; // due to #4 (Modelica.Units.SI.Molarity)
<strong>equation</strong>
  torque = sin(<strong>time</strong>); // due to #2 (Modelica.Math.sin)
  ...
<strong>end</strong> Lookup;</pre></blockquote>

<h4>Syntax</h4>

<p>See section on <code>import_clause</code> in the <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica Grammar</a>.</p>

<h4>Description</h4>

<p>Using import statements extends the static name lookup to additional import names.
The generated import names are:</p>

<ul>
  <li><code>C</code> for <code><strong>import</strong> A.B.C;</code></li>
  <li><code>D</code> for <code><strong>import</strong> D = A.B.C;</code></li>
  <li><code>C</code> and all other classes in B for <code><strong>import</strong> A.B.*;</code></li>
</ul>
<h5>Note</h5>
<p><em>Especially the renaming and wildcard import statements should be avoided since they might lead to name-lookup conflicts.</em></p>
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

<blockquote><pre><strong>connector</strong> RealInput = <strong>input</strong> Real;
<strong>connector</strong> RealOutput = <strong>output</strong> Real;

<strong>block</strong> Integrator
  RealInput  u;
  RealOutput y;
<strong>protected</strong>
  Real x;
<strong>equation</strong>
  <strong>der</strong>(x) = u;
  y = x;
<strong>end</strong> Integrator;</pre></blockquote>

<h4>Syntax</h4>

<p>See section on <code>type_prefix</code> in the <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica Grammar</a>.</p>

<h4>Description</h4>

<p>
The prefixes <strong>input</strong> and <strong>output</strong> have a slightly different semantic meaning depending on the context where they are used:
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
<blockquote><pre>  <strong>block</strong> FirstOrder
     <strong>input</strong> Real u;
       ...
  <strong>end</strong> FirstOrder;

  <strong>model</strong> UseFirstOrder
     FirstOrder firstOrder(u=time); // binding equation for u
      ...
  <strong>end</strong> UseFirstOrder;
</pre></blockquote>
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

<blockquote><pre><strong>connector</strong> RealInput = <strong>input</strong> Real;
<strong>connector</strong> RealOutput = <strong>output</strong> Real;

<strong>block</strong> Integrator
  RealInput  u;
  RealOutput y;
<strong>protected</strong>
  Real x;
<strong>equation</strong>
  <strong>der</strong>(x) = u;
  y = x;
<strong>end</strong> Integrator;</pre></blockquote>

<h4>Syntax</h4>

<p>See section on <code>type_prefix</code> in the <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica Grammar</a>.</p>

<h4>Description</h4>

<p>
The prefixes <strong>input</strong> and <strong>output</strong> have a slightly different semantic meaning depending on the context where they are used:
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
<blockquote><pre>  <strong>block</strong> FirstOrder
     <strong>input</strong> Real u;
       ...
  <strong>end</strong> FirstOrder;

  <strong>model</strong> UseFirstOrder
     FirstOrder firstOrder(u=time); // binding equation for u
      ...
  <strong>end</strong> UseFirstOrder;
</pre></blockquote>
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

<blockquote><pre><strong>partial block</strong> PartialBlock
  <strong>input</strong> Real u;
  <strong>output</strong> Real y;
<strong>protected</strong>
  Real x;
<strong>equation</strong>
  x = y;
<strong>end</strong> PartialBlock;

<strong>block</strong> Integrator
  <strong>extends</strong> PartialBlock;
<strong>equation
  der</strong>(x) = u;
<strong>end</strong> Integrator;

<strong>block</strong> Gain
  <strong>extends</strong> PartialBlock;
  <strong>parameter</strong> k = 1;
<strong>equation</strong>
  x = k*u;
<strong>end</strong> Gain;

<strong>model</strong> Composition
  PartialBlock block1; // Illegal
  Integrator block2; // Legal
  Gain block3; // Legal
<strong>end</strong> Composition;</pre></blockquote>

<h4>Syntax</h4>

<p>See section on <code>class_definition</code> in the <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica Grammar</a>.</p>

<h4>Description</h4>

<p>
The keyword <strong>partial</strong> defines that a class is <strong>incomplete</strong> and
that it cannot be instantiated. For example, defining
</p>

<blockquote><pre>   PartialBlock block1;</pre></blockquote>

<p>
is illegal. A partial class can only be used in an \"extends\" clause to inherit from it
or in a \"constrainedby\" clause to define the constraints of a replaceable class.
</p>

</html>"));
end 'partial';

class StateMachines "State Machines"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
The state machines defined in the Modelica Language are based on the <a href=\"modelica://ModelicaReference.Synchronous\">synchronous language elements</a>.
Note that the state machines defined in the Modelica Standard Library are not based on this.
</p>
<h4>Examples</h4>
<blockquote><pre>
  inner Integer v(start=0);
  block Increase
    outer output Integer v;
  equation
    v = previous(v) + 2;
  end Increase;
  Increase increase;
  block Decrease
    outer output Integer v;
  equation
    v = previous(v) - 1;
  end Decrease;
  Decrease decrease;
equation
  initialState(increase);
  transition(increase, decrease, v>=6, immediate=false);
  transition(decrease, increase, v==0, immediate=false);
</pre></blockquote>
In this example we will start in <strong>increase</strong> and increase <strong>v</strong> until a limit, and then decrease it, and repeat.

<h4>Description</h4>
A detailed description of the State Machines using Synchronous Language Elements is given in <a href=\"https://specification.modelica.org/v3.4/Ch17.html\">Chapter 17 (State Machines) of the Modelica 3.4 specification</a>.
</html>"));
end StateMachines;

class 'stream' "stream"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Declare stream variable in a connector to describe bi-directional flow of matter
</p>
<h4>Examples</h4>

<blockquote><pre><strong>connector</strong> FluidPort
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium;
  Medium.AbsolutePressure        p          \"Pressure in connection point\";
  <strong>flow</strong>   Medium.MassFlowRate     m_flow     \"&gt; 0, if flow into component\";
  <strong>stream</strong> Medium.SpecificEnthalpy h_outflow  \"h close to port if m_flow &lt; 0\";
<strong>end</strong> FluidPort;
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
<a href=\"modelica://ModelicaReference.Operators.'inStream()'\">'inStream()'</a>. The value of the
stream variable corresponding to the actual flow direction can be
inquired through the built-in operator <a href=\"modelica://ModelicaReference.Operators.'actualStream()'\">'actualStream()'</a>.
</p>

<blockquote><pre><strong>model</strong> IsenthalpicFlow \"No energy storage/losses, e.g., pressure drop, valve, ...\"
  <strong>replaceable package</strong> Medium=Modelica.Media.Interfaces.PartialMedium;
  FluidPort port_a, port_b:
  Medium.ThermodynamicState port_a_state_inflow \"State at port_a if inflowing\";
  Medium.ThermodynamicState port_b_state_inflow \"State at port_b if inflowing\";
<strong>equation</strong>
  // Medium states for inflowing fluid
  port_a_state_inflow = Medium.setState_phX(port_a.p,
                                            <strong>inStream</strong>(port_a.h_outflow));
  port_b_state_inflow = Medium.setState_phX(port_b.p,
                                            <strong>inStream</strong>(port_b.h_outflow));
  // Mass balance
  0 = port_a.m_flow + port_b.m_flow;

  // Instantaneous propagation of enthalpy flow between the ports with
  // isenthalpic state transformation (no storage and no loss of energy)
  port_a.h_outflow = <strong>inStream</strong>(port_b.h_outflow);
  port_b.h_outflow = <strong>inStream</strong>(port_a.h_outflow);

  // (Regularized) Momentum balance
  port_a.m_flow = f(port_a.p, port_b.p,
                    Medium.density(port_a_state_inflow),
                    Medium.density(port_b_state_inflow));
<strong>end</strong> IsenthalpicFlow;
</pre></blockquote>

<p>When two or more FluidPort (inside) connectors are connected together, then <strong>no</strong>
connection equations are generated for <strong>stream</strong> variables. Instead, these
equations are constructed by the <strong>inStream</strong>(..) built-in operator
(see example model IsenthalpicFlow) above. If two IsenthalpicFlow components
are connected together:
</p>

<blockquote><pre>   IsenthalpicFlow dp1;
   IsenthalpicFlow dp2;
<strong>equation</strong>
  <strong>connect</strong>(dp1, dp2);
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
  <strong>inStream</strong>(dp1.port_b.h_outflow) := dp2.port_a.h_outflow;

// within dp2:
  <strong>inStream</strong>(dp2.port_a.h_outflow) := dp1.port_b.h_outflow;
</pre></blockquote>

<h4>Syntax</h4>

<p>See section on <code>type_prefix</code> in the <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica Grammar</a>.</p>

<h4>Description</h4>

<p>
A detailed description of the stream keyword and the inStream operator is given
in <a href=\"https://specification.modelica.org/v3.4/Ch15.html\">Chapter 15 (Stream Connectors)</a>
and <a href=\"https://specification.modelica.org/v3.4/A4.html\">Appendix D (Derivation of Stream Equations)</a>
of the Modelica 3.4 specification.
An overview and a rational is provided in a
<a href=\"modelica://Modelica/Resources/Documentation/Fluid/Stream-Connectors-Overview-Rationale.pdf\">slide set</a>.
</p>

<p>
The two basic variable types in a connector <strong>potential</strong> (or across) variable
and <strong>flow</strong> (or through) variable are not sufficient to describe in a numerically
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
declared with the prefix <strong>stream</strong>. A stream variable describes a quantity that
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
<strong>connector</strong> Demo
  Real        p;  // potential variable
  <strong>flow</strong>   Real m_flow;  // flow variable
  <strong>stream</strong> Real h;  // stream variable
<strong>end</strong> Demo;
</pre></blockquote>

<p>
are connected together with
</p>

<blockquote><pre>
<strong>connect</strong>(c1,c2);
<strong>connect</strong>(c1,c3);
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
0 = c1.m_flow*(<strong>if</strong> c1.m_flow > 0 <strong>then</strong> h_mix <strong>else</strong> c1.h) +
    c2.m_flow*(<strong>if</strong> c2.m_flow > 0 <strong>then</strong> h_mix <strong>else</strong> c2.h) +
    c3.m_flow*(<strong>if</strong> c3.m_flow > 0 <strong>then</strong> h_mix <strong>else</strong> c3.h);

<strong>inStream</strong>(c1.h) = <strong>if</strong> c1.m_flow > 0 <strong>then</strong> h_mix <strong>else</strong> &lt;undefined&gt;;
<strong>inStream</strong>(c2.h) = <strong>if</strong> c2.m_flow > 0 <strong>then</strong> h_mix <strong>else</strong> &lt;undefined&gt;;
<strong>inStream</strong>(c3.h) = <strong>if</strong> c3.m_flow > 0 <strong>then</strong> h_mix <strong>else</strong> &lt;undefined&gt;;

</pre></blockquote>

<p>
If at least one variable in a connector has the stream prefix, the connector
is called <strong>stream connector</strong> and the corresponding variable is called
<strong>stream variable</strong>. The following definitions hold:
</p>

<ul>
<li> The stream prefix can only be used in a connector declaration.</li>
<li> A stream connector must have exactly one scalar variable with the flow prefix.
     [<em>The idea is that all stream variables of a connector are associated with
      this flow variable</em>].</li>
<li> For every outside connector, one equation is generated for every variable
     with the stream prefix [<em>to describe the propagation of the stream
     variable along a model hierarchy</em>]. For the exact definition,
     see the end of section 15.2.</li>
<li> For inside connectors, variables with the stream prefix do not lead to
     connection equations.</li>
<li> Connection equations with stream variables are generated in a
     model when using the inStream() operator or the actualStream() operator.</li>
</ul>

<p>
For further details, see the definition of the
<a href=\"modelica://ModelicaReference.Operators.'inStream()'\">'inStream()'</a> operator.
</p>

</html>"));
end 'stream';

class Synchronous "Synchronous Language Elements"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Synchronous language elements are added to Modelica as an alternative to normal <a href=\"modelica://ModelicaReference.'when'\">when</a>-clauses to
making modeling of complex sampled systems safer and easier.
</p>
<h4>Examples</h4>
<blockquote><pre>
  // Discrete controller
  when Clock() then
    E*dc.xd=A*previous(dc.xd)+B*dc.yd;
      dc.ud=C*previous(dc.xd)+D*dc.yd;
  end when;

  // hold controller output:
  plant.u=hold(dc.ud);

  // Plant
  0=f(der(plant.x),plant.x,plant.u);
  plant.y=g(plant.x);

  // Sample continuous signal
  dc.yd=sample(plant.y, Clock(3));
</pre></blockquote>
In this example <strong>dc.xd</strong> and <strong>dc.ud</strong> are Clocked variables, and only defined when the Clock is active (every 3rd second).
At time instants where the associated clock is not active, the value of a clocked variable can be inquired by using an explicit cast operator, e.g., <strong>hold</strong>.

<h4>Description</h4>
A detailed description of the Synchronous Language Elements is given in <a href=\"https://specification.modelica.org/v3.4/Ch16.html\">Chapter 16 (Synchronous Language Elements) of the Modelica 3.4 specification</a>.
</html>"));
end Synchronous;

class 'time' "time"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Built-in variable time
</p>
<h4>Examples</h4>

<blockquote><pre><strong>encapsulated model</strong> SineSource
  <strong>import</strong> Modelica.Math.sin;
  <strong>connector</strong> OutPort=<strong>output</strong> Real;
  OutPort y=sin(time); // Uses the built-in variable time.
<strong>end</strong> SineSource;</pre></blockquote>

<h4>Syntax</h4>

<blockquote><pre><strong>time</strong></pre></blockquote>

<h4>Description</h4>

<p>All declared variables are functions of the independent
variable <strong>time</strong>. Time is a built-in variable available
in all classes, which is treated as an input variable. It
is implicitly defined as:</p>

<blockquote><pre><strong>input</strong> Real time (<strong>final</strong> quantity = \"Time\",
                 <strong>final</strong> unit     = \"s\");</pre></blockquote>

<p>The value of the <strong>start</strong> attribute of time is set to
the time instant at which the simulation is started.</p>

</html>"));
end 'time';

class 'when' "when"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Activate equations or statements when condition becomes true
</p>
<h4>Examples</h4>
<blockquote><pre> <strong>equation
   when</strong> x &gt; 2 <strong>then</strong>
     y3 = 2*x +y1+y2; // Order of y1 and y3 equations does not matter
     y1 = sin(x);
   <strong>end when</strong>;
   y2 = sin(y1);</pre></blockquote>

<h4>Syntax</h4>

<p>
In equation sections:
</p>

<blockquote><pre>  <strong>when</strong> expression <strong>then</strong>
    { equation \";\" }
  { <strong>elsewhen</strong> expression <strong>then</strong>
    { equation \";\" } }
  <strong>end when</strong></pre></blockquote>

<p>
In algorithm sections:
</p>
<blockquote><pre>  <strong>when</strong> expression <strong>then</strong>
    { algorithm \";\" }
  { <strong>elsewhen</strong> expression <strong>then</strong>
    { algorithm \";\" } }
  <strong>end when</strong></pre></blockquote>

<h4>Description</h4>

<p>The expression of a when clause shall be a discrete-time Boolean scalar
or vector expression. The equations and algorithm statements within a when
clause are activated when the scalar or any one of the elements of the vector
expression becomes true. When-clauses in equation sections are allowed, provided
the equations within the when-clause have one of the following forms:</p>

<ul>
  <li>v = expr;</li>
  <li> (out1, out2, out3, ...) = function_call(in1, in2, ...);</li>
  <li>operators <strong>assert</strong>(), <strong>terminate</strong>(), <strong>reinit</strong>()</li>
  <li><strong>For</strong> and <strong>if</strong>-clause if the equations within the <strong>for</strong> and <strong>if</strong>-clauses satisfy these requirements.</li>
  <li>In an equation section, the different branches of when/elsewhen must have the same set of component references on the left-hand side.</li>
  <li>In an equation section, the branches of an if-then-else clause inside when-clauses must have the same set of component references on the left-hand side, unless the if-then-else have exclusively parameter expressions as switching conditions.</li>
</ul>

<p>A when clause shall not be used within a function class.</p>

<p><em>[Example:</em></p>

<p><em>Algorithms are activated when x becomes &gt; 2:</em></p>

<blockquote><pre>   <strong>when</strong> x &gt; 2 <strong>then</strong>
     y1 := sin(x);
     y3 := 2*x + y1 + y2;
   <strong>end when</strong>;</pre></blockquote>

<p><em>Algorithms are activated when either x becomes &gt; 2 or sample(0,2) becomes true or x becomes less than 5:</em></p>

<blockquote><pre>   <strong>when</strong> {x &gt; 2, sample(0,2), x &lt; 5} <strong>then</strong>
     y1 := sin(x);
     y3 := 2*x + y1 + y2;
   <strong>end when</strong>;</pre></blockquote>

<p><em>For when in equation sections the order between the equations does not matter, e.g.,</em></p>
<blockquote><pre> <strong>equation
   when</strong> x &gt; 2 <strong>then</strong>
     y3 = 2*x +y1+y2; // Order of y1 and y3 equations does not matter
     y1 = sin(x);
   <strong>end when</strong>;
   y2 = sin(y1);</pre></blockquote>

<p><em>The needed restrictions on equations within a when-clause becomes apparent with the following example:</em></p>

<blockquote><pre>   Real x, y;
<strong>equation</strong>
   x + y = 5;
   <strong>when</strong> condition <strong>then</strong>
      2*x + y = 7;         // error: not valid Modelica
   <strong>end when</strong>;</pre></blockquote>

<p><em>When the equations of the when-clause are not activated it is not clear which
variable to hold constant, either x or y. A corrected version of this example is:</em></p>

<blockquote><pre>   Real x, y;
<strong>equation</strong>
   x + y = 5;
   <strong>when</strong> condition <strong>then</strong>
      y = 7 - 2*x;        // fine
   <strong>end when</strong>;</pre></blockquote>

<p><em>Here, variable y is held constant when the when-clause is de-activated and x
is computed from the first equation using the value of y from the previous event instant.</em></p>

<p><em>For when in algorithm sections the order is significant and it is advisable to have only
one assignment within the when-clause and instead use several algorithms having when-clauses
with identical conditions, e.g.,</em></p>

<blockquote><pre> <strong>algorithm</strong>
   <strong>when</strong> x &gt; 2 <strong>then</strong>
     y1 := sin(x);
   <strong>end when</strong>;
 <strong>equation</strong>
   y2 = sin(y1);
 <strong>algorithm</strong>
   <strong>when</strong> x &gt; 2 <strong>then</strong>
     y3 := 2*x + y1 + y2;
   <strong>end when</strong>;</pre></blockquote>

<p><em>Merging the when-clauses can lead to less efficient code and different models
with different behaviour depending on the order of the assignment to y1 and y3 in the algorithm.]</em></p>

<p>A when clause</p>

<blockquote><pre> <strong>algorithm
   when</strong> {x&gt;1, <strong>..., </strong>y&gt;p} <strong>then
     ...
   elsewhen</strong> x &gt; y.start <strong>then
     ...
   end when</strong>;</pre></blockquote>

<p>is equivalent to the following special if-clause, where Boolean b1[N]
and Boolean b2 are necessary because the <strong>edge</strong>() operator can only
be applied to variables</p>

<blockquote><pre>   Boolean b1[N](start={x.start&gt;1,<strong> ..., </strong>y.start&gt;p});
   Boolean b2(start=x.start&gt;y.start);
 <strong>algorithm</strong>
   b1:={x&gt;1, ..., y&gt;p};
   b2:=x&gt;y.start;

   <strong>if edge</strong>(b1[1]) <strong>or edge</strong>(b1[2]) <strong>or ... edge</strong>(b1[N]) <strong>then
     ...
   elseif edge</strong>(b2) <strong>then
     ...
   end if</strong>;</pre></blockquote>

<p>with &quot;<strong>edge</strong>(A)= A <strong>and not pre</strong>(A)&quot; and the additional
guarantee, that the algorithms within this special if clause are only evaluated
at event instants.</p>

<p>A when-clause</p>

<blockquote><pre> <strong>equation
   when</strong> x&gt;2 <strong>then</strong>
     v1 = expr1 ;
     v2 = expr2 ;
   <strong>end when</strong>;</pre></blockquote>

<p>is equivalent to the following special if-expressions</p>

<blockquote><pre>   Boolean b(start=x.start&gt;2);
 <strong>equation</strong>
   b  = x&gt;2;
   v1 = <strong>if edge</strong>(b) <strong>then</strong> expr1 <strong>else pre</strong>(v1);
   v2 = <strong>if edge</strong>(b) <strong>then</strong> expr2 <strong>else pre</strong>(v2);</pre></blockquote>

<p>The start-values of the introduced Boolean variables are defined by
the taking the start-value of the when-condition, as above where p is a
parameter variable. The start-values of the special functions
<strong>initial</strong>, <strong>terminal</strong>, and <strong>sample</strong> is false.</p>

<p>When clauses cannot be nested.</p>

<p><em>[Example:</em></p>

<p><em>The following when clause is invalid:</em></p>

<blockquote><pre>   <strong>when</strong> x &gt; 2 <strong>then
     when</strong> y1 &gt; 3 <strong>then</strong>
       y2 = sin(x);
     <strong>end when</strong>;
   <strong>end when</strong>;</pre></blockquote>

<p><em>]</em></p>
</html>"));
end 'when';

class 'while' "while"
  extends ModelicaReference.Icons.Information;
  annotation (Documentation(info="<html>
<p>
Repeat statements as long as a condition is fulfilled
</p>
<h4>Examples</h4>
<blockquote><pre>    Integer i;
  <strong>algorithm</strong>
    i := 1;
    <strong>while</strong> i &lt; 10 <strong>loop</strong>
      i := i + 1;
      <strong>...
    end while</strong>;</pre></blockquote>

<h4>Syntax</h4>

<blockquote><pre>  <strong>while</strong> expression <strong>loop</strong>
    { algorithm \";\" }
  <strong>end while</strong></pre></blockquote>

<h4>Description</h4>

<p>The expression of a while clause shall be a scalar Boolean expression.
The while-clause corresponds to while-statements in programming languages,
and is formally defined as follows</p>

<ol>
  <li>The expression of the while clause is evaluated.</li>
  <li>If the expression of the while-clause is false, the execution
      continues after the while-clause.</li>
  <li>If the expression of the while-clause is true, the entire body of
      the while clause is executed (except if a break statement or return
      statement is executed), and then execution proceeds at step 1.</li>
</ol>

</html>"));
end 'while';

class Contact "Contact"
  extends ModelicaReference.Icons.Contact;

  annotation (Documentation(info="<html>
<dl>
<dt><strong>Library Officers:</strong></dt>
<dd><a href=\"https://github.com/dietmarw\">Dietmar Winkler</a> and <a href=\"https://github.com/HansOlsson\">Hans Olsson</a></dd>
</dl>
<p><strong>Acknowledgements:</strong></p>
<ul>
<li> The initial version of ModelicaReference is from Christian Schweiger (DLR) who
     provided it up to Modelica version 2.2.</li>

<li> Martin Otter (DLR) updated ModelicaReference for Modelica 3.0.</li>

<li> Dietmar Winkler (DWE) updated ModelicaReference for
     Modelica 3.1 and 3.2</li>

<li> Stefan Vorkoetter (Maplesoft) provided ModelicaReference.ModelicaGrammar
     for Modelica 3.2.</li>
</ul>

</html>"));

end Contact;

package Icons "Library of icons"
  extends ModelicaReference.Icons.IconsPackage;
  partial class Information "Icon for general information packages"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Ellipse(
            lineColor={75,138,73},
            fillColor={75,138,73},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-100.0,-100.0},{100.0,100.0}}),
          Polygon(
            origin={-4.167,-15.0},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{
                4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,
                -50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}},
            smooth=Smooth.Bezier),
          Ellipse(
            origin={7.5,56.5},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-12.5,-12.5},{12.5,12.5}})}), Documentation(info="<html>
<p>This icon indicate classes containing only documentation, intended for general description of, e.g., concepts and features of a package.</p>
</html>"));
  end Information;

  partial class Contact "Icon for contact information"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,70},{100,-72}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-100,-72},{100,-72},{0,20},{-100,-72}},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{22,0},{100,70},{100,-72},{22,0}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-100,70},{100,70},{0,-20},{-100,70}},
            fillColor={241,241,241},
            fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>This icon shall be used for the contact information of the library developers.</p>
</html>"));
  end Contact;

  partial class IconsPackage "Icon for packages containing icons"
    extends ModelicaReference.Icons.Package;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Polygon(
            origin={-8.167,-17},
            fillColor={128,128,128},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{
                4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,
                -50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}},
            smooth=Smooth.Bezier), Ellipse(
            origin={-0.5,56.5},
            fillColor={128,128,128},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-12.5,-12.5},{12.5,12.5}})}));
  end IconsPackage;

  partial class Package "Icon for standard packages"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            lineColor={200,200,200},
            fillColor={248,248,248},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100.0,-100.0},{100.0,100.0}},
            radius=25.0),
          Rectangle(
            lineColor={128,128,128},
            extent={{-100.0,-100.0},{100.0,100.0}},
            radius=25.0)}),   Documentation(info="<html>
<p>Standard package icon.</p>
</html>"));
  end Package;
end Icons;

annotation (
  DocumentationClass=true,
  version="4.0.0",
  versionDate="2020-06-04",
  dateModified = "2020-06-04 11:00:00Z",
  revisionId="$Format:%h %ci$",
  Documentation(info="<html>
<p>
This package is a reference to Modelica keywords,
<a href=\"modelica://ModelicaReference.Operators\">Modelica builtin operators</a>,
and the <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica grammar</a>.
It is based on the
<a href=\"https://www.modelica.org/documents/ModelicaSpec34.pdf\">Modelica Language Specification version 3.4</a> from 10th April 2017. Currently, not the whole Modelica language is documented in ModelicaReference (but a large subset).
</p>

<p>
Copyright &copy; 2003-2020, Modelica Association and contributors
</p>

<p>
<em>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the 3-Clause BSD license. For license conditions (including the disclaimer of warranty) visit <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
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
      <td></td>
      <td>2020-02-24</td>
      <td><a href=\"https://github.com/HansOlsson\">Hans Olsson</a></td>
      <td>
      Add minimal parts for synchronous and state machines - making the reference feature-complete.
      </td>
    </tr>
    <tr>
      <td></td>
      <td>2019-09-27</td>
      <td><a href=\"https://github.com/HansOlsson\">Hans Olsson</a></td>
      <td>
      Update to Modelica Specification 3.4 (except grammar):
      <ul>
      <li>Change of missingInnerMessage, to indicate that it less important.</li>
      <li>Example for InlineAfterIndexReduction.</li>
      <li>Version conversions are specified, and to-version is possible.</li>
      <li>The function section was rewritten, and pure functions added as a sub-class, and function partial application also moved to a sub-class.</li>
      <li>Correct constrained to constrainedby (could also be constraining-clause).</li>
      <li>Remaining: synchronous, state machines, specifying conversions(?), ...</li>
      </ul>
      </td>
    </tr>
    <tr>
      <td></td>
      <td>2017-09-22</td>
      <td><a href=\"https://github.com/HansOlsson\">Hans Olsson</a></td>
      <td>
      <ul>
      <li>Changed grammar to have colon emphasized as well, since it may otherwise look like a dot after 't' due to lack of kerning.</li>
      <li>Annotation inverse moved to annotations.</li>
      <li>The operator sign does not generate events, <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2324\">#2324</a></li>
      <li>Some stylistic improvements of the English text</li>
      </ul>
      </td>
     </tr>
     <tr>
      <td></td>
      <td>2013-07-26</td>
      <td><a href=\"https://github.com/dietmarw\">Dietmar Winkler</a>,<br>
                         <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a></td>
      <td>
<ul>
<li> Update of grammar from Maplesoft which reflects changes from
     <a href=\"https://github.com/modelica/ModelicaSpecification/issues/1140\">#1140</a></li>
<li> Introduced the same new icons as in Modelica 3.2.1</li>
<li> Fixing incorrect links and HTML errors in documentation.</li>
<li> Fixing trivial typos.</li>
<li> Moves operators from the top level (array, cat, ..) to subpackage Operators</li>
<li> Adding homotopy() operator.</li>
<li> <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1007\">#1007</a>: png figures are compressed.</li>
<li> <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/670\">#670</a>: Adds more function and operator descriptions</li>
<li> <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/644\">#644</a>: Improved description of operator delay</li>
<li> Updated the documentation to reflect Modelica Specification 3.2 Rev2:
     <ul>
     <li> Update of reinit(), Integer(), DocumentationClass</li>
     <li> <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/988\">#988</a>: Adding the annotations:<br>
          checkBox<br>
          choicesAllMatching<br>
          colorSelector<br>
          loadSelector<br>
          saveSelector<br>
          normallyConstant</li>
     <li> <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/802\">#802</a>: Adding the additional connection operators<br>
          Connections.branch()<br>
          Connections.root()<br>
          Connections.potentialRoot()<br>
          Connections.isRoot()<br>
          Connections.rooted()<br>
          rooted() with deprecation notice</li>
     <li> <a href=\"https://github.com/modelica/ModelicaSpecification/issues/1048\">#1048</a>: GenerateEvents annotation removed in Modelica 3.2 rev2</li>
     </ul></li>
</ul>
     </td>
     </tr>

     <tr>
      <td><a href=\"https://github.com/modelica/ModelicaStandardLibrary/commit/e46b941f168f0cb5fb1a9e10d31a247e08ea4dec\">r4781</a></td>
      <td>2011-12-15</td>
      <td><a href=\"https://github.com/dietmarw\">Dietmar Winkler</a></td>
      <td>Use quoted class names for function descriptions (closes ticket <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/565\">#565</a>)</td>
    </tr>
    <tr>
      <td><a href=\"https://github.com/modelica/ModelicaStandardLibrary/commit/13f826a01b70f8d7b7616b4bfe00413563ed6c40\">r4256</a></td>
      <td>2010-10-06</td>
      <td><a href=\"https://github.com/dietmarw\">Dietmar Winkler</a></td>
      <td>Removed 'uses' annotation and added icons so it can be used with multiple versions of the MSL (closes ticket <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/425\">#425</a>)</td>
    </tr>
    <tr>
      <td><a href=\"https://github.com/modelica/ModelicaStandardLibrary/commit/da0b65b3f79cf097ab5314904158006c9b02d0b0\">r4218</a></td>
      <td>2010-09-25</td>
      <td><a href=\"https://github.com/dietmarw\">Dietmar Winkler</a></td>
      <td>Major clean up of the documentation by use of <a href=\"http://linkchecker.sourceforge.net\">LinkChecker</a> (closes ticket <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/228\">#228</a>)</td>
    </tr>
    <tr>
      <td><a href=\"https://github.com/modelica/ModelicaStandardLibrary/commit/ba34d1a53de471a689e0582b766ace2ac462edd9\">r4145</a></td>
      <td>2010-09-07</td>
      <td><a href=\"https://github.com/dietmarw\">Dietmar Winkler</a></td>
      <td>Added an update of the <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica 3.2 grammar</a>
                       from Stefan Vorkoetter (Maplesoft).</td>
    </tr>
    <tr>
      <td><a href=\"https://github.com/modelica/ModelicaStandardLibrary/commit/1d033f42c988e62f418dd2cc817a9f4055569941\">r3742</a></td>
      <td>2010-04-13</td>
      <td><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a></td>
      <td>Added the <a href=\"modelica://ModelicaReference.ModelicaGrammar\">Modelica 3.2 grammar</a>
                       from Stefan Vorkoetter (Maplesoft).<br>
                       Introduced a \"Contact\" subpackage with updated contact and
                       acknowledgment information.</td>
    </tr>
    <tr>
      <td><a href=\"https://github.com/modelica/ModelicaStandardLibrary/commit/5500dfde969ec28db5dca88afb771ea308100160\">r3598</a></td>
      <td>2010-03-10</td>
      <td><a href=\"https://github.com/dietmarw\">Dietmar Winkler</a></td>
      <td>Added some annotations from Modelica language version 3.1 and 3.2 (see ticket <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/228\">#228</a>)</td>
    </tr>
    <tr>
      <td><a href=\"https://github.com/modelica/ModelicaStandardLibrary/commit/a792223829c266d80d648ecd3a912062b0cdb67d\">r948</a></td>
      <td>2008-01-02</td>
      <td><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a></td>
      <td>Adapted to Modelica language version 3.0</td>
    </tr>
    <tr>
      <td></td>
      <td>2004-09-30</td>
      <td><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a></td>
      <td>Moved the content of \"Functions\" into \"Operators\" and updated \"Operators\" according to Modelica 2.1</td>
    </tr>
    <tr>
      <td></td>
      <td>2003-07-10</td>
      <td>Christian Schweiger</td>
      <td>Implemented.</td>
    </tr>
</table>
</html>"));
end ModelicaReference;
