within Modelica.UsersGuide;
package Conventions "Conventions"
  extends Modelica.Icons.Information;
  package Documentation "HTML documentation"
    extends Modelica.Icons.Information;

    package Format "Format"
      extends Modelica.Icons.Information;

      class Cases "Cases"
        extends Modelica.Icons.Information;
        annotation (Documentation(info="<html>

<p>In the Modelica documentation sometimes different cases have to be distinguished. If the case distinction refers to Modelica parameters or variables (Boolean expressions) the comparisons should be written in the style of Modelica code within <code>&lt;code&gt;</code> and <code>&lt;/code&gt;</code>
</p>

<h4>Examples</h4>

<h5>Example 1</h5>
<p>
<code>&lt;p&gt;If &lt;code&gt;useCage == true&lt;/code&gt;, a damper cage is considered in the model...&lt;/p&gt;</code>
</p>

<p>appears as</p>

<p>If <code>useCage == true</code>, a damper cage is considered in the model...</p>

<p>
For more complex case scenarios, an unordered list should be used. In this case only Modelica specific code segments and Boolean expressions.
</p>

<h5>Example 2</h5>

<blockquote><pre>
&lt;ul&gt;
  &lt;li&gt; If &lt;code&gt;useCage == true&lt;/code&gt;, a damper cage is considered in the model.
       Cage parameters must be specified in this case.&lt;/li&gt;
  &lt;li&gt; If &lt;code&gt;useCage == false&lt;/code&gt;, the damper cage is omitted.&lt;/li&gt;
&lt;/ul&gt;
</pre></blockquote>

<p>appears as</p>

<ul>
  <li> If <code>useCage == true</code>, a damper cage is considered in the model.
       Cage parameters must be specified in this case.</li>
  <li> If <code>useCage == false</code>, the damper cage is omitted.</li>
</ul>

<p>
In a more equation oriented case, additional equations or code segments can be added.
</p>

<h5>Example 3</h5>

<blockquote><pre>
&lt;ul&gt;
  &lt;li&gt;if &lt;code&gt;usePolar == true&lt;/code&gt;, assign magnitude and angle to output &lt;br&gt;
  &lt;!-- insert graphical representation of equations --&gt;
  y[i,1] = sqrt( a[i]^2 + b[i]^2 ) &lt;br&gt;
  y[i,2] = atan2( b[i], a[i] )
  &lt;/li&gt;
  &lt;li&gt;if &lt;code&gt;usePolar == false&lt;/code&gt;, assign cosine and sine to output &lt;br&gt;
  &lt;!-- insert graphical representation of equations --&gt;
  y[i,1] = a[i] &lt;br&gt;
  y[i,2] = b[i]
  &lt;/li&gt;
&lt;/ul&gt;
</pre></blockquote>

<p>appears as</p>

<ul>
  <li>if <code>usePolar == true</code>, assign magnitude and angle to output<br>

  <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Documentation/Format/Cases/y_i1_polar.png\"
       alt=\"y[i,1] = sqrt( a[i]^2 + b[i]^2 )\"><br>
  <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Documentation/Format/Cases/y_i2_polar.png\"
       alt=\"y[i,2] = atan2( b[i], a[i] )\">
  </li>
  <li>if <code>usePolar == false</code>, assign cosine and sine to output<br>
  <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Documentation/Format/Cases/y_i1_rect.png\"
       alt=\"y[i,1] = a[i]\"><br>
  <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Documentation/Format/Cases/y_i2_rect.png\"
       alt=\" y[i,2] = b[i]\">
  </li>
</ul>

</html>"));
      end Cases;

      class Code "Code"
        extends Modelica.Icons.Information;

        annotation (Documentation(info="<html>
<p>
<a href=\"modelica://Modelica.UsersGuide.Conventions.ModelicaCode\">Modelica code</a> conventions of class and instance names,
parameters and variables are specified separately. In this section it is summarized how to refer to
Modelica code in the HTML documentation.
</p>

<ol>
<li> For constants, parameters and variables in code segments <code>&lt;code&gt;</code>
     and <code>&lt;/code&gt;</code> should to be used, e.g.,<br>
     <code><strong>parameter</strong> Modelica.Units.SI.Time tStart &quot;Start time&quot;</code></li>
<li> Write multi or single line code segments as quoted preformatted text, i.e., embedded within
     <code>&lt;blockquote&gt;&lt;pre&gt;</code> and <code>&lt;/pre&gt;&lt;/blockquote&gt;</code> tags.</li>
<li> Multi line or single line code shall not be additionally indented.</li>
<li> Inline code segments may be typeset with <code>&lt;code&gt;</code> and <code>&lt;/code&gt;</code>.</li>
<li> In code segments use bold to emphasize Modelica keywords.</li>
</ol>

<h4>Examples</h4>

<h5>Example 1</h5>

<blockquote><pre>
&lt;blockquote&gt;&lt;pre&gt;
&lt;strong&gt;connector&lt;/strong&gt; Frame
   ...
   &lt;strong&gt;flow&lt;/strong&gt; SI.Force f[3] &lt;strong&gt;annotation&lt;/strong&gt;(unassignedMessage=&quot;...&quot;);
&lt;strong&gt;end&lt;/strong&gt; Frame;
&lt;/pre&gt;&lt;/blockquote&gt;
</pre></blockquote>

<p>appears as</p>

<blockquote><pre>
<strong>connector</strong> Frame
   ...
   <strong>flow</strong> SI.Force f[3] <strong>annotation</strong>(unassignedMessage=&quot;...&quot;);
<strong>end</strong> Frame;
</pre></blockquote>

<h5>Example 2</h5>

<blockquote><pre>
&lt;blockquote&gt;&lt;pre&gt;
&lt;strong&gt;parameter&lt;/strong&gt; Modelica.Units.SI.Conductance G=1 &quot;Conductance&quot;;
&lt;/pre&gt;&lt;/blockquote&gt;
</pre></blockquote>

<p>appears as</p>

<blockquote><pre>
<strong>parameter</strong> Modelica.Units.SI.Conductance G=1 &quot;Conductance&quot;;
</pre></blockquote>
</html>"));
      end Code;

      class Equations "Equations"
        extends Modelica.Icons.Information;

        annotation (Documentation(info="<html>

<p>
In the context of <a href=\"http://www.w3c.org/\">HTML</a> documentation
equations should have a graphical representation in PNG format. For that purpose tool
specific math typing capabilities can be used. Alternatively the LaTeX to HTML translator
<a href=\"http://www.latex2html.org\">LaTeX2HTML</a>, or the
<a href=\"http://www.homeschoolmath.net/worksheets/equation_editor.php\">Online Equation Editor</a>
or <a href=\"http://www.codecogs.com/latex/eqneditor.php\">codecogs</a> can be used.
</p>

<p>
A typical equation, e.g., of a Fourier synthesis, could look like<br>
<img
 src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Documentation/Format/Equations/fourier.png\"><br>
or<br>
<img
 src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Documentation/Format/Equations/sample.png\"
 alt=\"y=a_1+a_2\"><br>
In an <code>alt</code> tag the original equation should be stored, e.g.,</p>
<blockquote><pre>
&lt;img
&nbsp;src=&quot;modelica://Modelica/Resources/Images/UsersGuide/Conventions/Documentation/Format/Equations/sample.png&quot;
&nbsp;alt=&quot;y=a_1+a_2&quot;&gt;
</pre></blockquote>

<p>
If one wants to refer to particular variables and parameters in the documentation text, either a
graphical representation (PNG file) or italic fonts for regular physical symbols and lower case
<a href=\"http://www.w3.org/TR/html4/sgml/entities.html\">Greek letters</a>
should be used. Full word variables and full word indices should be spelled within
<code>&lt;code&gt;</code> and <code>&lt;/code&gt;</code>.
Vector and array indices should be typeset as subscripts using the
<code>&lt;sub&gt;</code> and <code>&lt;/sub&gt;</code> tags.
</p>

<p> Examples for such variables and parameters are:
<em>&phi;</em>, <em>&phi;</em><sub>ref</sub>, <em>v<sub>2</sub></em>, <code>useDamperCage</code>.
</p>

<h4>Numbered equations</h4>

<p>For numbering equations a one row table with two columns should be used. The equation number should be placed in the right column:</p>

<blockquote><pre>
&lt;table border=&quot;0&quot; cellspacing=&quot;10&quot; cellpadding=&quot;2&quot;&gt;
  &lt;tr&gt;
    &lt;td&gt;&lt;img
    src=&quot;modelica://Modelica/Resources/Images/UsersGuide/Conventions/Documentation/Format/Equations/sample.png&quot;
    alt=&quot;y=a_1+a_2&quot;&gt; &lt;/td&gt;
    &lt;td&gt;(1)&lt;/td&gt;
  &lt;/tr&gt;
&lt;/table&gt;
</pre></blockquote>

<p>appears as:</p>

<table border=\"0\" cellspacing=\"10\" cellpadding=\"2\">
  <tr>
    <td><img
         src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Documentation/Format/Equations/sample.png\"
         alt=\"y=a_1+a_2\"></td>
    <td>(1)</td>
  </tr>
</table>

</html>"));
      end Equations;

      class Figures "Figures"
        extends Modelica.Icons.Information;

        annotation (Documentation(info="<html>
<p>
Figures should in particular be included to examples to discuss the problems and results of the respective model. The library developers are yet encouraged to add figures to the documentation of other components to support the understanding of the users of the library.
</p>

<ol>
<li> Figures have to be placed <strong>outside</strong> of paragraphs to be HTML compliant.</li>
<li> Figures need to have <strong>at least</strong> a <code>src</code> and an <code>alt</code> attribute defined to be HTML compliant.</li>
<li> Technical figures should be placed within a table environment. Each technical figure should then also have a caption. The figure caption starts with a capital letter.</li>
<li> Illustration can be embedded without table environment.</li>
</ol>

<h4>Location of files</h4>

<p>
The <code>PNG</code> files should be placed in a folder which exactly represents the package structure.
</p>

<h4>Examples</h4>

<h5>Example 1</h5>

<p>This example shows how an illustration should be embedded in the Example
<a href=\"modelica://Modelica.Blocks.Examples.PID_Controller\">PID_Controller</a> of the
<a href=\"modelica://Modelica.Blocks\">Blocks</a> package.
</p>

<blockquote><pre>
&lt;img src=&quot;modelica://Modelica/Resources/Images/Blocks/PID_controller.png&quot;
     alt=&quot;PID_controller.png&quot;&gt;
</pre></blockquote>

<h5>Example 2</h5>

<p>This is a simple example of a technical figure with caption.</p>

<blockquote><pre>
&lt;table border=&quot;0&quot; cellspacing=&quot;0&quot; cellpadding=&quot;2&quot;&gt;
  &lt;caption&gt;Caption starts with a capital letter&lt;/caption&gt;
  &lt;tr&gt;
    &lt;td&gt;
      &lt;img src=&quot;modelica://Modelica/Resources/Images/Blocks/PID_controller.png&quot;
           alt=&quot;PID_controller.png&quot;&gt;
    &lt;/td&gt;
  &lt;/tr&gt;
&lt;/table&gt;
</pre></blockquote>

<h5>Example 3</h5>

<p>To refer to a certain figure, a figure number may be added. In such case the figure name (Fig.) including the figure enumeration (1,2,...) have to be displayed bold using <code>&lt;strong&gt;</code> and <code>&lt;/strong&gt;</code>.</p>
<p>The figure name and enumeration should look like this: <strong>Fig. 1:</strong></p>
<p>Figures have to be enumerated manually.</p>

<blockquote><pre>
&lt;table border=&quot;0&quot; cellspacing=&quot;0&quot; cellpadding=&quot;2&quot;&gt;
  &lt;caption&gt;&lt;strong&gt;Fig. 2:&lt;/strong&gt; Caption starts with a capital letter&lt;/caption&gt;
  &lt;tr&gt;
    &lt;td&gt;
      &lt;img src=&quot;modelica://Modelica/Resources/Images/Blocks/PID_controller.png&quot;
           alt=&quot;PID_controller.png&quot;&gt;
    &lt;/td&gt;
  &lt;/tr&gt;
&lt;/table&gt;
</pre></blockquote>
</html>"));
      end Figures;

      class Hyperlinks "Hyperlinks"
        extends Modelica.Icons.Information;

        annotation (Documentation(info="<html>
<ol>
<li> Hyperlinks should always be made when referring to a component or package.</li>
<li> The hyperlink text in between <code>&lt;a href=&quot;...&quot;&gt;</code> and <code>&lt;/a&gt;</code> should include the full main package name.</li>
<li> A link to an external component should include the full name of the package that it is referred to.</li>
<li> Modelica hyperlinks have to use the scheme <code>&quot;modelica://...&quot;</code></li>
<li> For hyperlinks referring to a Modelica component, see Example 1 and 2.</li>
<li> No links to commercial web sites are allowed.</li>
</ol>

<h4>Examples</h4>

<h5>Example 1</h5>

<blockquote><pre>
&lt;a href=&quot;modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.PlanarLoops&quot;&gt;
         Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.PlanarLoops&lt;/a&gt;
</pre></blockquote>
<p>appears as</p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.PlanarLoops\">
         Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.PlanarLoops</a>

<h5>Example 2</h5>

<blockquote><pre>
&lt;p&gt;
  The feeder cables are connected to an
  &lt;a href=&quot;modelica://Modelica.Electrical.Machines.BasicMachines.InductionMachines.IM_SquirrelCage&quot;&gt;
  induction machine&lt;/a&gt;.
&lt;/p&gt;
</pre></blockquote>
<p>appears as</p>
<p>
  The feeder cables are connected to an
  <a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.InductionMachines.IM_SquirrelCage\">
  induction machine</a>.
</p>
</html>"));
      end Hyperlinks;

      class Lists "Lists"
        extends Modelica.Icons.Information;

        annotation (Documentation(info="<html>
<ol>
<li> Lists have to be placed <strong>outside</strong> of paragraphs to be HTML compliant.</li>
<li> Items of a list shall start with
     <ol>
     <li> a capital letter if each item is a full sentence</li>
     <li> a small letter, if only text fragments are used or the list is fragment of a sentence</li>
     </ol></li>
</ol>

<h4>Examples</h4>

<h5>Example 1</h5>

<p>This is a simple example of an enumerated (ordered) list</p>

<blockquote><pre>
&lt;ol&gt;
  &lt;li&gt;item 1&lt;/li&gt;
  &lt;li&gt;item 2&lt;/li&gt;
&lt;/ol&gt;
</pre></blockquote>
<p>appears as</p>
<ol>
  <li>item 1</li>
  <li>item 2</li>
</ol>

<h5>Example 2</h5>

<p>This is a simple example of an unnumbered list.</p>

<blockquote><pre>
&lt;ul&gt;
  &lt;li&gt;item 1&lt;/li&gt;
  &lt;li&gt;item 2&lt;/li&gt;
&lt;/ul&gt;
</pre></blockquote>
<p>appears as</p>
<ul>
  <li>item 1</li>
  <li>item 2</li>
</ul>
</html>"));
      end Lists;

      class References "References"
        extends Modelica.Icons.Information;

        annotation (Documentation(info="<html>
<ol>
<li> Refer to references by [1], [Andronov1973], etc. by hyperlink and summarize literature in the references subsection of
     <a href=\"modelica://Modelica.UsersGuide.Conventions.UsersGuide.References\">Conventions.UsersGuide.References</a>.</li>
<li> There has to be made at least one citation to each reference.</li>
</ol>

<h4>Examples</h4>

<h5>Example 1</h5>

<blockquote><pre>
&lt;p&gt;
More details about electric machine modeling
can be found in [&lt;a href=&quot;modelica://Modelica.UsersGuide.Conventions.UsersGuide.References&quot;&gt;Gao2008&lt;/a&gt;]
and
[&lt;a href=&quot;modelica://Modelica.UsersGuide.Conventions.UsersGuide.References&quot;&gt;Kral2018&lt;/a&gt;, p. 149].
&lt;/p&gt;
</pre></blockquote>
<p>appears as</p>
<p>
More details about electric machine modeling
can be found in [<a href=\"modelica://Modelica.UsersGuide.Conventions.UsersGuide.References\">Gao2008</a>]
and
[<a href=\"modelica://Modelica.UsersGuide.Conventions.UsersGuide.References\">Kral2018</a>, p. 149].
</p>
</html>"));
      end References;

      class Tables "Tables"
        extends Modelica.Icons.Information;

        annotation (Documentation(info="<html>
<ol>
<li> Tables should always be typeset with <code>&lt;table&gt;</code> and <code>&lt;/table&gt;</code>,
     not with <code>&lt;pre&gt;</code> and <code>&lt;/pre&gt;</code>.</li>
<li> Tables have to be placed <strong>outside</strong> of paragraphs to be HTML compliant.</li>
<li> Each table must have a table caption.</li>
<li> Table headers and entries start with capital letters.</li>
</ol>

<h4>Examples</h4>

<h5>Example 1</h5>

<p>This is a simple example of a table.</p>

<blockquote><pre>
&lt;table border=&quot;1&quot; cellspacing=&quot;0&quot; cellpadding=&quot;2&quot;&gt;
  &lt;caption&gt;Caption starts with a capital letter&lt;/caption&gt;
  &lt;tr&gt;
    &lt;th&gt;Head 1&lt;/th&gt;
    &lt;th&gt;Head 2&lt;/th&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
    &lt;td&gt;Entry 1&lt;/td&gt;
    &lt;td&gt;Entry 2&lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
    &lt;td&gt;Entry 3&lt;/td&gt;
    &lt;td&gt;Entry 4&lt;/td&gt;
  &lt;/tr&gt;
&lt;/table&gt;
</pre></blockquote>
<p>appears as</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <caption>Caption starts with a capital letter</caption>
  <tr>
    <th><strong>Head 1</strong></th>
    <th><strong>Head 2</strong></th>
  </tr>
  <tr>
    <td>Entry 1</td>
    <td>Entry 2</td>
  </tr>
  <tr>
    <td>Entry 3</td>
    <td>Entry 4</td>
  </tr>
</table>

<h5>Example 2</h5>

<p>In this case of table captions, the table name (Tab.) including the table enumeration (1,2,...)
has to be displayed bold using <code>&lt;strong&gt;</code> and <code>&lt;/strong&gt;</code>. The table name
and enumeration should look like this: <strong>Tab. 1:</strong> Tables have to be enumerated manually.</p>

<blockquote><pre>
&lt;table border=&quot;1&quot; cellspacing=&quot;0&quot; cellpadding=&quot;2&quot;&gt;
  &lt;caption&gt;&lt;strong&gt;Tab 2:&lt;/strong&gt; Caption starts with a capital letter&lt;/caption&gt;
  &lt;tr&gt;
    &lt;th&gt;Head 1&lt;/th&gt;
    &lt;th&gt;Head 2&lt;/th&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
    &lt;td&gt;Entry 1&lt;/td&gt;
    &lt;td&gt;Entry 2&lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
    &lt;td&gt;Entry 3&lt;/td&gt;
    &lt;td&gt;Entry 4&lt;/td&gt;
  &lt;/tr&gt;
&lt;/table&gt;
</pre></blockquote>
<p>appears as</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Tab. 2:</strong> Caption starts with a capital letter</caption>
  <tr>
    <th>Head 1</th>
    <th>Head 2</th>
  </tr>
  <tr>
    <td>Entry 1</td>
    <td>Entry 2</td>
  </tr>
  <tr>
    <td>Entry 3</td>
    <td>Entry 4</td>
  </tr>
</table>
</html>"));
      end Tables;
      annotation (Documentation(info="<html>

<p>
In this section the format UsersGuide of the HTML documentation are specified.
The <a href=\"modelica://Modelica.UsersGuide.Conventions.Documentation.Structure\">structure</a> of the documentation is specified separately.
</p>

<h4>Paragraphs</h4>

<ol>
<li> In each section the paragraphs should start with <code>&lt;p&gt;</code>
     and terminate with <code>&lt;/p&gt;</code>.</li>
<li> Do not write plain text without putting it in a paragraph.</li>
<li> No artificial line breaks <code>&lt;br&gt;</code> should be added within text paragraphs if possible.
     Use separate paragraphs instead.</li>
<li> After a colon (:) continue with capital letter if new sentence starts;
     for text fragments continue with lower case letter</li>
</ol>

<h4>Emphasis</h4>

<ol>
<li> For setting text in <strong>strong font</strong> (normally interpreted as <strong>boldface</strong>) the tags <code>&lt;strong&gt;</code> and <code>&lt;/strong&gt;</code> have to be used.</li>
<li> For <em>emphasizing</em> text fragments <code>&lt;em&gt;</code> and <code>&lt;/em&gt;</code> has to be used.</li>
<li> Modelica terms such as expandable bus, array, etc. should not be emphasized anyhow.</li>
</ol>

<h4>Capitalization of Text</h4>

<ol>
<li> Table headers and entries should start with capital letters</li>
<li> Table entries should start with lower case letter if only text fragments are used.</li>
<li> Table and figure captions start with a capital letter</li>
</ol>

</html>"));
    end Format;

    class Structure "Structure"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<ol>
<li> In the HTML documentation of any Modelica library, the headings <code>&lt;h1&gt;</code>,
     <code>&lt;h2&gt;</code> and <code>&lt;h3&gt;</code> should not be used, because they are utilized by
     the automatically generated documentation.</li>
<li> The utilized heading format starts with <code>&lt;h4&gt;</code> and terminates with <code>&lt;/h4&gt;</code>, e.g.,
     <code>&lt;h4&gt;Description&lt;/h4&gt;</code></li>
<li> The  <code>&lt;h4&gt;</code> and  <code>&lt;h5&gt;</code> headings must not be terminated by a colon (:).</li>
<li> For additional structuring <code>&lt;h5&gt;</code> and <code>&lt;/h5&gt;</code> may be used as demonstrated below.</li>
</ol>

<h4>Structure</h4>

<p>
The following parts should be added to the documentation of each component:
</p>

<ol>
<li> General information without additional subsection explains how the class works</li>
<li> <strong>Syntax</strong> (for functions only): shows syntax of function call with minimum and full input parameters</li>
<li> <strong>Implementation</strong> (optional): explains how the implementation is made</li>
<li> <strong>Limitations</strong> (optional): explains the limitations of the component</li>
<li> <strong>Notes</strong> (optional): if required/useful</li>
<li> <strong>Examples</strong> (optional): if required/useful</li>
<li> <strong>Acknowledgments</strong> (optional): if required</li>
<li> <strong>See also</strong>: shows hyperlinks to related models</li>
<li> <strong>Revision history</strong> (optional): if required/intended for a package/model, the revision history
        should be placed in <code>annotation(Documentation(revisions=&quot;...&quot;));</code></li>
</ol>

<p>
These sections should appear in the listed order. The only exceptions are hierarchically structured notes and examples as explained in the following.
</p>

<h4>Additional notes and examples</h4>

<p>Some additional notes or examples may require additional <code>&lt;h5&gt;</code> headings. For either notes or examples the following cases may be applied:</p>

<h5>Example 1</h5>
<p>
This is an example of a single note.
</p>

<blockquote><pre>
&lt;h5&gt;Note&lt;/h5&gt;
&lt;p&gt;This is the note.&lt;/p&gt;
</pre></blockquote>

<h5>Example 2</h5>
<p>
This is an example of a very simple structure.
</p>

<blockquote><pre>
&lt;h5&gt;Notes&lt;/h5&gt;
&lt;p&gt;This is the first note.&lt;/p&gt;
&lt;p&gt;This is the second note.&lt;/p&gt;
</pre></blockquote>

<h5>Example 3</h5>
<p>
This example shows a more complex structure with enumeration.
</p>

<blockquote><pre>
&lt;h5&gt;Note 1&lt;/h5&gt;
...
&lt;h5&gt;Note 2&lt;/h5&gt;
...
</pre></blockquote>

<h4>Automatically created documentation</h4>

<p>
For parameters, connectors, as well as inputs and outputs of function automatic documentation is generated by the tool from the quoted comments.
</p>
</html>"));
    end Structure;
    annotation (Documentation(info="<html>
<a href=\"http://www.w3c.org/\">HTML</a> documentation of Modelica classes.
</html>"));
  end Documentation;

  package Terms "Terms and spelling"
    extends Modelica.Icons.Information;

    class Electrical "Electrical terms"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>

<p>The terms listed in this package shall be in accordance with <a href=\"http://www.electropedia.org/\">Electropedia</a>.</p>

<table border=\"1\" cellpadding=\"2\" cellspacing=\"0\" >
  <caption>List of electrical term spellings</caption>
  <tr>
    <th>To be used</th>
    <th>Not to be used</th>
  </tr>
  <tr>
    <td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=151-13-54\">cut-off frequency</a></td>
    <td>cut off frequency, cutoff frequency, cut-off-frequency, cutoff-frequency</td>
  </tr>
  <tr>
    <td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=151-11-09\">electromagnetic</a></td>
    <td>electro magnetic, electro-magnetic</td>
  </tr>
  <tr>
    <td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=151-11-10\">electromechanical</a></td>
    <td>electro mechanical, electro-mechanical</td>
  </tr>
  <tr>
    <td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=151-15-21\">no-load</a></td>
    <td>noload, no load</td>
  </tr>
  <tr>
    <td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=141-01-03\">polyphase</a></td>
    <td>multi phase, multi-phase, multiphase</td>
  </tr>
  <tr>
    <td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=113-04-08\">quasi-static</a></td>
    <td>quasistatic, quasi static</td>
  </tr>
  <tr>
    <td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=351-47-17\">set-point</a></td>
    <td>set point, setpoint</td>
  </tr>
  <tr>
    <td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=151-12-04\">short-circuit</a></td>
    <td>shortcircuit, short circuit</td>
  </tr>
  <tr>
    <td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=411-31-13\">single-phase</a></td>
    <td>single phase, singlephase, one phase, one-phase, onephase, 1 phase, 1-phase</td>
  </tr>
  <tr>
    <td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=141-02-10\">star point</a></td>
    <td>star-point, starpoint</td>
  </tr>
  <tr>
    <td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=811-12-22\">three-phase</a></td>
    <td>three phase, threephase, 3 phase, 3-phase</td>
  </tr>
</table>

</html>"));
    end Electrical;

    class Magnetic "Magnetic terms"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>

<p>The terms listed in this package shall be in accordance with <a href=\"http://www.electropedia.org/\">Electropedia</a>.</p>

<table border=\"1\" cellpadding=\"2\" cellspacing=\"0\" >
  <caption>List of magnetic term spellings</caption>
  <tr>
    <th>To be used</th>
    <th>Not to be used</th>
  </tr>
  <tr>
    <td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=151-11-09\">electromagnetic</a></td>
    <td>electro magnetic, electro-magnetic</td>
  </tr>
  <tr>
    <td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=121-11-60\">magnetomotive force</a></td>
    <td>magneto motive force</td>
  </tr>
  <tr>
    <td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=113-04-08\">quasi-static</a></td>
    <td>quasistatic, quasi static</td>
  </tr>
</table>

</html>"));
    end Magnetic;
    annotation (Documentation(info="<html>

<p>This is the documentation of terms to be used in the Modelica Standard Library.</p>

</html>"));
  end Terms;

  package ModelicaCode "Modelica code"
    extends Modelica.Icons.Information;

     class Format "Format"
       extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>

<h4>Comments and Annotations</h4>
<p>
Comments and annotations should start with a capital letter, for example:<br>
<code><strong>parameter</strong> Real a = 1 &quot;Arbitrary factor&quot;;</code>.<br>
For Boolean parameters, the description string should start with &quot;= true, &hellip;&quot;, for example:<br>
<code><strong>parameter</strong> Boolean useHeatPort = false &quot;= true, if heatPort is enabled&quot;;</code>.
</p>

<h4>Tabs and Groups</h4>
<p>
The annotations &quot;tab&quot; and &quot;group&quot; define the placement of
component or of variables in a dialog.
</p>
<p>
Using the <strong>group</strong> annotation, the following rules shall be followed:
</p>
<ol>
  <li>
    Avoid excessively long group labels.
  </li>
  <li>
    Use nouns rather than verbs, without ending punctuation.
  </li>
  <li>
    Use sentence-style capitalization.
  </li>
</ol>
<p>
Using the <strong>tab</strong> annotation, the following rules shall be followed:
</p>
<ol>
  <li>
    Try to group components or variables in the default \"general\" tab first.
    But feel free to define a&nbsp;new tab it they are so many.
  </li>
  <li>
    Label tabs based on their pattern. The label shall clearly reflect
    the content of the collected variables.
  </li>
  <li>
    Avoid long tab labels. One or two words are mostly sufficient.
  </li>
  <li>
    Use nouns rather than verbs, without ending punctuation.
  </li>
  <li>
    Use sentence-style capitalization.
  </li>
  <li>
    Visibility of parameters collected in one tab shall not be dependent
    on parameters shown in another tab.
  </li>
</ol>

<h5>Example</h5>
<p>
Imagine you define a&nbsp;controlled electric drive being composed of
a&nbsp;controller and an electrical machine. The latter
has parameters number of pole pairs&nbsp;<var>p</var>, nominal frequency
<var>f</var><sub>nom</sub>, rotor's moment of inertia <var>J</var><sub>rotor</sub>
and others.
The&nbsp;controller itself is divided into several sub-controllers
&ndash; such as the one for speed control with parameters like gain&nbsp;<var>k</var>
or time constant&nbsp;<var>T</var>.
Then, the above parameters of your electrical drive model could be sorted using tabs
and groups as follows:&nbsp;<var>p</var>, <var>f</var><sub>nom</sub> and
<var>J</var><sub>rotor</sub> grouped in the \"Electrical machine\" group in
the \"general\" tab; <var>k</var> and&nbsp;<var>T</var> in the group
\"Speed control\" under tab \"Controller\".
</p>
<p>
In the Modelica code, for example the parameter&nbsp;<var>k</var> will then
be defined like:
</p>

<blockquote><pre>
<strong>parameter</strong> Real k=1 \"Gain\"
  <strong>annotation</strong>(
    Dialog(
      tab=\"Controller\",
      group=\"Speed control\"));
</pre></blockquote>

<h4>Whitespace and Indentation</h4>
<p>
Trailing white-space (i.e., white-space at the end of the lines) shall not be used.
The tab-character shall not be used, since the tab-stops are not standardized.
</p>
<p>
The code in a&nbsp;class shall be indented relative to the class in steps of two spaces;
except that the headings <code>public</code>, <code>protected</code>, <code>equation</code>,
<code>algorithm</code>, and <code>end</code> of class marker shall not be indented.
The keywords <code>public</code> and <code>protected</code> are headings for a&nbsp;group
of declarations.
</p>
<p>
Long modifier lists shall be split into several indented lines with at most one modifier per line.
</p>
<p>
Full class definitions shall be separated by an empty line.
</p>

<h5>Example</h5>

<blockquote><pre>
<strong>package</strong> MyPackage
  <strong>partial</strong> <strong>model</strong> BaseModel
    <strong>parameter</strong> Real p;
    <strong>input</strong> Real u(unit=\"m/s\");
  <strong>protected</strong>
    Real y;
    Real x(
      start=1,
      unit=\"m\",
      nominal=10);
  <strong>equation</strong>
    <strong>der</strong>(x) = u;
    y = 2*x;
  <strong>end</strong> BaseModel;

  <strong>model</strong> ModelP2
    <strong>extends</strong> BaseModel(p=2);
  <strong>end</strong> ModelP2;
<strong>end</strong> MyPackage;
</pre></blockquote>
</html>"));
     end Format;

    class Naming "Naming convention"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>

<ol>
<li> <strong>Class and instance names</strong> are usually written in upper and lower case
     letters, e.g., &quot;ElectricCurrent&quot;. An underscore may be used in names.
     However, it has to be taken into account that the last underscore in a
     name might indicate that the following characters are rendered as a subscript.
     Example: &quot;pin_a&quot; may be rendered as &quot;pin<sub>a</sub>&quot;.</li>

<li> <strong>Class names</strong> start always with an upper case letter,
     with the exception of functions, that start with a lower case letter.</li>

<li> <strong>Instance names</strong>, i.e., names of component instances and
     of variables (with the exception of constants),
     start usually with a lower case letter with only
     a few exceptions if this is common sense
     (such as <code>T</code> for a temperature variable).</li>

<li> <strong>Constant names</strong>, i.e., names of variables declared with the
     &quot;constant&quot; prefix, follow the usual naming conventions
     (= upper and lower case letters) and start usually with an
     upper case letter, e.g., UniformGravity, SteadyState.</li>

<li> The two <strong>connectors</strong> of a domain that have identical declarations
     and different icons are usually distinguished by <code>_a</code>, <code>_b</code>
     or <code>_p</code>, <code>_n</code>, e.g., <code>Flange_a</code>, <code>Flange_b</code>,
     <code>HeatPort_a</code>, <code>HeatPort_b</code>.</li>

<li> A <strong>connector class</strong> has the instance
     name definition in the diagram layer and not in the
     <a href=\"modelica://Modelica.UsersGuide.Conventions.Icons\">icon</a> layer.</li>
</ol>

<h4>Variable names</h4>
<p>In the following table typical variable names are listed. This list should be completed.</p>

<table border=\"1\" cellpadding=\"2\" cellspacing=\"0\" >
   <caption>Variables and names</caption>
   <tr>
      <th>Variable</th>
      <th>Quantity</th>
    </tr>
    <tr>
      <td>a</td>
      <td>acceleration</td>
    </tr>
    <tr>
      <td>A</td>
      <td>area</td>
    </tr>
    <tr>
      <td>C</td>
      <td>capacitance</td>
    </tr>
    <tr>
      <td>d</td>
      <td>damping, density, diameter</td>
    </tr>
    <tr>
      <td>dp</td>
      <td>pressureDrop</td>
    </tr>
    <tr>
      <td>e</td>
      <td>specificEntropy</td>
    </tr>
    <tr>
      <td>E</td>
      <td>energy, entropy</td>
    </tr>
    <tr>
      <td>eta</td>
      <td>efficiency</td>
    </tr>
    <tr>
      <td>f</td>
      <td>force, frequency</td>
    </tr>
    <tr>
      <td>G</td>
      <td>conductance</td>
    </tr>
    <tr>
      <td>h</td>
      <td>height, specificEnthalpy</td>
    </tr>
    <tr>
      <td>H</td>
      <td>enthalpy</td>
    </tr>
    <tr>
      <td>HFlow</td>
      <td>enthalpyFlow</td>
    </tr>
    <tr>
      <td>i</td>
      <td>current</td>
    </tr>
    <tr>
      <td>J</td>
      <td>inertia</td>
    </tr>
    <tr>
      <td>l</td>
      <td>length</td>
    </tr>
    <tr>
      <td>L</td>
      <td>Inductance</td>
    </tr>
    <tr>
      <td>m</td>
      <td>mass</td>
    </tr>
    <tr>
      <td>M</td>
      <td>mutualInductance</td>
    </tr>
    <tr>
      <td>mFlow</td>
      <td>massFlow</td>
    </tr>
    <tr>
      <td>p</td>
      <td>pressure</td>
    </tr>
    <tr>
      <td>P</td>
      <td>power</td>
    </tr>
    <tr>
      <td>Q</td>
      <td>heat</td>
    </tr>
    <tr>
      <td>Qflow</td>
      <td>heatFlow</td>
    </tr>
    <tr>
      <td>r</td>
      <td>radius</td>
    </tr>
    <tr>
      <td>R</td>
      <td>radius, resistance</td>
    </tr>
    <tr>
      <td>t</td>
      <td>time</td>
    </tr>
    <tr>
      <td>T</td>
      <td>temperature</td>
    </tr>
    <tr>
      <td>tau</td>
      <td>torque</td>
    </tr>
    <tr>
      <td>U</td>
      <td>internalEnergy</td>
    </tr>
    <tr>
      <td>v</td>
      <td>electricPotential, specificVolume, velocity, voltage</td>
    </tr>
    <tr>
      <td>V</td>
      <td>volume</td>
    </tr>
    <tr>
      <td>w</td>
      <td>angularVelocity</td>
    </tr>
    <tr>
      <td>X</td>
      <td>reactance</td>
    </tr>
    <tr>
      <td>Z</td>
      <td>impedance</td>
    </tr>
</table>
</html>"));
    end Naming;

  class ParameterDefaults "Parameter defaults"
    extends Modelica.Icons.Information;

   annotation (Documentation(info="<html>

<p>
In this section the convention is summarized how default parameters are
handled in the Modelica Standard Library (since version 3.0).
</p>

<p>
Many models in this library have parameter declarations to define
constants of a model that might be changed before simulation starts.
Example:
</p>

<blockquote><pre>
<strong>model</strong> SpringDamper
<strong>parameter</strong> Real c(final unit=\"N.m/rad\") = 1e5    \"Spring constant\";
<strong>parameter</strong> Real d(final unit=\"N.m.s/rad\") = 0    \"Damping constant\";
<strong>parameter</strong> Modelica.Units.SI.Angle phi_rel0 = 0  \"Unstretched spring angle\";
...
<strong>end</strong> SpringDamper;
</pre></blockquote>

<p>
In Modelica it is possible to define a default value of a parameter in
the parameter declaration. In the example above, this is performed for
all parameters. Providing default values for all parameters can lead to
errors that are difficult to detect, since a modeler may have forgotten
to provide a meaningful value (the model simulates but gives wrong
results due to wrong parameter values). In general the following basic
situations are present:
</p>

<ol>
<li> The parameter value could be anything (e.g., a spring constant or
  a resistance value) and therefore the user should provide a value in
  all cases. A Modelica translator should warn, if no value is provided.
</li>

<li> The parameter value is not changed in &gt; 95 % of the cases
  (e.g., initialization or visualization parameters, or parameter phi_rel0
  in the example above). In this case a default parameter value should be
  provided, in order that the model or function can be conveniently
  used by a modeler.
</li>

<li> A modeler would like to quickly utilize a model, e.g.,
  <ul>
  <li> to automatically check that the model still translates and/or simulates
    (after some changes in the library),</li>
  <li> to make a quick demo of a library by drag-and-drop of components,</li>
  <li> to implement a simple test model in order to get a better understanding
    of the desired component.</li>
  </ul>
  In all these cases, it would be not practical, if the modeler would
  have to provide explicit values for all parameters first.
  </li>
</ol>

<p>
To handle the conflicting goals of (1) and (3), the Modelica Standard Library
uses two approaches to define default parameters, as demonstrated with the
following example:
</p>

<blockquote><pre>
<strong>model</strong> SpringDamper
<strong>parameter</strong> Real c(final unit=\"N.m/rad\"  , start = 1e5) \"Spring constant\";
<strong>parameter</strong> Real d(final unit=\"N.m.s/rad\", start = 0)   \"Damping constant\";
<strong>parameter</strong> Modelica.Units.SI.Angle phi_rel0 = 0        \"Unstretched spring angle\";
...
<strong>end</strong> SpringDamper;

SpringDamper sp1;              // warning for \"c\" and \"d\"
SpringDamper sp2(c=1e4, d=0);  // fine, no warning
</pre></blockquote>

<p>
Both definition forms, using a \"start\" value (for \"c\" and \"d\") and providing
a declaration equation (for \"phi_rel0\"), are valid Modelica and define the value
of the parameter. By convention, it is expected that Modelica translators will
trigger a warning message for parameters that are <strong>not</strong> defined by a declaration
equation, by a modifier equation or in an initial equation/algorithm section.
A Modelica translator might have options to change this behavior, especially,
that no messages are printed in such cases and/or that an error is triggered
instead of a warning.
</p>

</html>"));
  end ParameterDefaults;
    annotation (Documentation(info="<html>

<p>In this section guidelines on creating Modelica code are provided.</p>

</html>"));
  end ModelicaCode;

  package UsersGuide "User's Guide"
    extends Modelica.Icons.Information;

    class Implementation "Implementation notes"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
This class summarizes general information about the implementation which is not stated elsewhere.
</p>
<ol>
<li>The <code>&lt;caption&gt;</code> tag is currently not supported in some tools.</li>
<li>The <code>&amp;sim;</code> symbol (i.e., '&sim;' ) is currently not supported in some tools.</li>
<li>The <code>&amp;prop;</code> symbol (i.e., '&prop;' ) is currently not supported in some tools.</li>
</ol>
</html>"));
    end Implementation;

    class References "References"
      extends Modelica.Icons.References;

      annotation (Documentation(info="<html>

<ol>
<li> Citation formats should be unified according to IEEE Transactions style.</li>
<li> Reference should be formatted as tables with two columns.</li>
</ol>

<p>In the following the reference formats will be explained based on five examples:</p>

<ul>
<li> Journal (or conference) [Gao2008]</li>
<li> Book [Kral2018]</li>
<li> Master&apos;s thesis [Woehrnschimmel1998]</li>
<li> PhD thesis [Farnleitner1999]</li>
<li> Technical report [Marlino2005]</li>
</ul>

<p>The <a href=\"modelica://Modelica.UsersGuide.Conventions.Documentation.Format.References\">citation</a> is also explained.</p>

<h4>Example</h4>

<blockquote><pre>
&lt;table border=\"0\" cellspacing=\"0\" cellpadding=\"2\"&gt;
  &lt;tr&gt;
    &lt;td&gt;[Gao2008]&lt;/td&gt;
    &lt;td&gt;Z. Gao, T. G. Habetler, R. G. Harley, and R. S. Colby,
        &amp;quot;&lt;a href=&quot;https://ieeexplore.ieee.org/document/4401132&quot;&gt;A sensorless rotor temperature estimator for induction
        machines based on a current harmonic spectral estimation scheme&lt;/a&gt;&amp;quot;,
        &lt;em&gt;IEEE Transactions on Industrial Electronics&lt;/em&gt;,
        vol. 55, no. 1, pp. 407-416, Jan. 2008.
    &lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
    &lt;td&gt;[Kral2018]&lt;/td&gt;
    &lt;td&gt;C. Kral,
        &lt;em&gt;Modelica - object oriented modeling of polyphase electric machines&lt;/em&gt; (in German),
        M&amp;uuml;nchen: Hanser Verlag, 2018, &lt;a href=&quot;https://doi.org/10.3139/9783446457331&quot;&gt;DOI 10.3139/9783446457331&lt;/a&gt;,
        ISBN 978-3-446-45551-1.
    &lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
    &lt;td&gt;[Woehrnschimmel1998]&lt;/td&gt;
    &lt;td&gt;R. W&amp;ouml;hrnschimmel,
        &amp;quot;Simulation, modeling and fault detection for vector
        controlled induction machines&amp;quot;,
        Master&amp;apos;s thesis, Vienna University of Technology,
        Vienna, Austria, 1998.
    &lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
    &lt;td&gt;[Farnleitner1999]&lt;/td&gt;
    &lt;td&gt;E. Farnleitner,
      &amp;quot;Computational Fluid dynamics analysis for rotating
      electrical machinery&amp;quot;,
      Ph.D. dissertation, University of Leoben,
      Department of Applied Mathematics, Leoben, Austria, 1999.
    &lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
    &lt;td&gt;[Marlino2005]&lt;/td&gt;
    &lt;td&gt;L. D. Marlino,
      &amp;quot;Oak ridge national laboratory annual progress report for the
      power electronics and electric machinery program&amp;quot;,
      Oak Ridge National Laboratory, prepared for the U.S. Department of Energy,
      Tennessee, USA, Tech. Rep. FY2004 Progress Report, January 2005,
      &lt;a href=&quot;https://doi.org/10.2172/974618&quot;&gt;DOI 10.2172/974618&lt;/a&gt;.
    &lt;/td&gt;
  &lt;/tr&gt;
&lt;/table&gt;
</pre></blockquote>

<p>appears as</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>[Gao2008]</td>
    <td>Z. Gao, T. G. Habetler, R. G. Harley, and R. S. Colby,
        &quot;<a href=\"https://ieeexplore.ieee.org/document/4401132\">A sensorless rotor temperature estimator for induction
        machines based on a current harmonic spectral estimation scheme</a>&quot;,
        <em>IEEE Transactions on Industrial Electronics</em>,
        vol. 55, no. 1, pp. 407-416, Jan. 2008.
    </td>
  </tr>
  <tr>
    <td>[Kral2018]</td>
    <td>C. Kral,
        <em>Modelica - object oriented modeling of polyphase electric machines</em> (in German),
        M&uuml;nchen: Hanser Verlag, 2018, <a href=\"https://doi.org/10.3139/9783446457331\">DOI 10.3139/9783446457331</a>,
        ISBN 978-3-446-45551-1.
    </td>
  </tr>
  <tr>
    <td>[Woehrnschimmel1998]</td>
    <td>R. W&ouml;hrnschimmel,
        &quot;Simulation, modeling and fault detection for vector
        controlled induction machines&quot;,
        Master&apos;s thesis, Vienna University of Technology,
        Vienna, Austria, 1998.
    </td>
  </tr>
  <tr>
    <td>[Farnleitner1999]</td>
    <td>E. Farnleitner,
      &quot;Computational Fluid dynamics analysis for rotating
      electrical machinery&quot;,
      Ph.D. dissertation, University of Leoben,
      Department of Applied Mathematics, Leoben, Austria, 1999.
    </td>
  </tr>
  <tr>
    <td>[Marlino2005]</td>
    <td>L. D. Marlino,
      &quot;Oak ridge national laboratory annual progress report for the
      power electronics and electric machinery program&quot;,
      Oak Ridge National Laboratory, prepared for the U.S. Department of Energy,
      Tennessee, USA, Tech. Rep. FY2004 Progress Report, January 2005,
      <a href=\"https://doi.org/10.2172/974618\">DOI 10.2172/974618</a>.
    </td>
  </tr>
</table>

</html>"));
    end References;

    class Contact "Contact"
      extends Modelica.Icons.Contact;

      annotation (Documentation(info="<html>

<p>
This class summarizes contact information of the contributing persons.
</p>

<h4>Example</h4>

<blockquote><pre>
&lt;p&gt;
Library officers responsible for the maintenance and for the
organization of the development of this library are listed in
&lt;a href=\"modelica://Modelica.UsersGuide.Contact\"&gt;Modelica.UsersGuide.Contact&lt;/a&gt;.
&lt;/p&gt;

&lt;h4&gt;Main authors&lt;/h4&gt;

&lt;p&gt;
&lt;strong&gt;First author's name&lt;/strong&gt;&lt;br&gt;
First author's address&lt;br&gt;
next address line&lt;br&gt;
email: &lt;a href=\"mailto:author1@example.org\"&gt;author1@example.org&lt;/a&gt;&lt;br&gt;
web: &lt;a href=&quot;https://www.example.org&quot;&gt;https://www.example.org&lt;/a&gt;
&lt;/p&gt;

&lt;p&gt;
&lt;strong&gt;Second author's name&lt;/strong&gt;&lt;br&gt;
Second author's address&lt;br&gt;
next address line&lt;br&gt;
email: &lt;a href=\"mailto:author2@example.org\"&gt;author2@example.org&lt;/a&gt;
&lt;/p&gt;

&lt;h4&gt;Contributors to this library&lt;/h4&gt;

&lt;ul&gt;
&nbsp; &lt;li&gt;Person one&lt;/li&gt;
&nbsp; &lt;li&gt;...&lt;/li&gt;
&lt;/ul&gt;

&lt;h4&gt;Acknowledgements&lt;/h4&gt;

&lt;p&gt;
The authors would like to thank following persons for their support ...
&lt;/p&gt;

OR

&lt;p&gt;
We are thankful to our colleagues [names] who provided expertise to develop this library...
&lt;/p&gt;

OR

&lt;p&gt;
The [partial] financial support for the development of this library by [organization]
is highly appreciated.
&lt;/p&gt;

OR whatever
</pre></blockquote>
<p>appears as</p>
<p>
Library officers responsible for the maintenance and for the
organization of the development of this library are listed in
<a href=\"modelica://Modelica.UsersGuide.Contact\">Modelica.UsersGuide.Contact</a>.
</p>

<h4>Main authors</h4>

<p>
<strong>First author's name</strong><br>
First author's address<br>
next address line<br>
email: <a href=\"mailto:author1@example.org\">author1@example.org</a><br>
web: <a href=\"https://www.example.org\">https://www.example.org</a>
</p>

<p>
<strong>Second author's name</strong><br>
Second author's address<br>
next address line<br>
email: <a href=\"mailto:author2@example.org\">author2@example.org</a><br>
</p>

<h4>Contributors to this library</h4>

<ul>
  <li>Person one</li>
  <li>...</li>
</ul>

<h4>Acknowledgements</h4>

<p>
The authors would like to thank following persons for their support ...
</p>
</html>"));
    end Contact;

    class RevisionHistory "Revision History"
      extends Modelica.Icons.ReleaseNotes;

      annotation (Documentation(info="<html>

<ol>
<li> The revision history needs to answer the question:
     What has changed and what are the improvements over the previous versions and revision.</li>
<li> The revision history includes the documentation of the development history of each class and/or package.</li>
<li> Version number, date, author and comments shall be included.
     In case the version number is not known at the time of implementation,
     a dummy version number shall be used, e.g., <code>3.x.x</code>. The version date shall be the date of the
     latest change.</li>
</ol>

<h5>Example</h5>

<blockquote><pre>
&lt;table border=\"1\" cellspacing=\"0\" cellpadding=\"2\"&gt;
    &lt;tr&gt;
      &lt;th&gt;Version&lt;/th&gt;
      &lt;th&gt;Date&lt;/th&gt;
      &lt;th&gt;Author&lt;/th&gt;
      &lt;th&gt;Comment&lt;/th&gt;
    &lt;/tr&gt;
    ...
    &lt;tr&gt;
      &lt;td&gt;1.0.1&lt;/td&gt;
      &lt;td&gt;2008-05-26&lt;/td&gt;
      &lt;td&gt;A. Haumer&lt;br&gt;C. Kral&lt;/td&gt;
      &lt;td&gt;Fixed bug in documentation&lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
      &lt;td&gt;1.0.0&lt;/td&gt;
      &lt;td&gt;2008-05-21&lt;/td&gt;
      &lt;td&gt;A. Haumer&lt;/td&gt;
      &lt;td&gt;Initial version&lt;/td&gt;
    &lt;/tr&gt;
&lt;/table&gt;
</pre></blockquote>

<p>This code appears then as in the \"Revisions\" section below.</p>

</html>",
    revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Version</th>
      <th>Date</th>
      <th>Author</th>
      <th>Comment</th>
    </tr>
    <tr>
      <td>3.2.3</td>
      <td>2017-07-04</td>
      <td>C. Kral</td>
      <td>Added comment on version number and date, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2219\">#2219</a></td>
    </tr>
    <tr>
      <td>1.1.0</td>
      <td>2010-04-22</td>
      <td>C. Kral</td>
      <td>Migrated Conventions to UsersGuide of MSL</td>
    </tr>
    <tr>
      <td>1.0.5</td>
      <td>2010-03-11</td>
      <td>D. Winkler</td>
      <td>Updated image links guide to new 'modelica://' URIs, added contact details</td>
    </tr>
    <tr>
      <td>1.0.4</td>
      <td>2009-09-28</td>
      <td>C. Kral</td>
      <td>Applied new rules for equations as discussed on the 63rd Modelica Design Meeting</td>
    </tr>
    <tr>
      <td>1.0.3</td>
      <td>2008-05-26</td>
      <td>D. Winkler</td>
      <td>Layout fixes and enhancements</td>
    </tr>
    <tr>
      <td>1.0.1</td>
      <td>2008-05-26</td>
      <td>A. Haumer<br>C. Kral</td>
      <td>Fixed bug in documentation</td>
    </tr>
    <tr>
      <td>1.0.0</td>
      <td>2008-05-21</td>
      <td>A. Haumer</td>
      <td>Initial version</td>
    </tr>
</table>
</html>"));
    end RevisionHistory;

  annotation (Documentation(info="<html>
<p>The UsersGuide of each package should consist of the following classes</p>
<ol>
<li> <a href=\"modelica://Modelica.UsersGuide.Conventions.UsersGuide.Contact\">Contact</a> information of
     the library officer and the co-authors</li>
<li> Optional <a href=\"modelica://Modelica.UsersGuide.Conventions.UsersGuide.Implementation\">Implementation Notes</a> to give general information about the implementation</li>
<li> <a href=\"modelica://Modelica.UsersGuide.Conventions.UsersGuide.References\">References</a> for summarizing the literature of the package</li>
<li> <a href=\"modelica://Modelica.UsersGuide.Conventions.UsersGuide.RevisionHistory\">Revision history </a> to summarize the most important changes and improvements of the package</li>
</ol>
</html>"));
  end UsersGuide;

  class Icons "Icon design"
    extends Modelica.Icons.Information;
    annotation (Documentation(info="<html>

<p>The icon of a Modelica class shall consider the following guidelines:</p>

<h4>Color and Shapes</h4>

<p>The main icon color of a component shall be the same for all components of one library. White fill areas of an icon shall not be used to hide parts of an icon, see
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2031\">#2031</a>.
In the Modelica Standard Library the following color schemes apply:</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <caption>Color schemes applied to particular libraries</caption>
  <tr>
    <th>Package</th>
    <th>Color RGB code</th>
    <th>Color sample</th>
  </tr>
  <tr>
    <td>Modelica.Blocks</td>
    <td>{0,0,127}</td>
    <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleBlocks.png\"></td>
  </tr>
  <tr>
    <td>Modelica.ComplexBlocks</td>
    <td>{85,170,255}</td>
    <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleComplexBlocks.png\"></td>
  </tr>
  <tr>
    <td>Modelica.Clocked</td>
    <td>{95,95,95}</td>
    <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleClocked.png\"></td>
  </tr>
  <tr>
    <td>Modelica.StateGraph</td>
    <td>{0,0,0}</td>
    <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleStateGraph.png\"></td>
  </tr>
  <tr>
    <td>Modelica.Electrical.Analog</td>
    <td>{0,0,255}</td>
    <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleElectricalAnalog.png\"></td>
  </tr>
  <tr>
    <td>Modelica.Electrical.Digital</td>
    <td>{128,0,128}</td>
    <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleElectricalDigital.png\"></td>
  </tr>
  <tr>
    <td>Modelica.Electrical.Machines</td>
    <td>{0,0,255}</td>
    <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleElectricalMachines.png\"></td>
  </tr>
  <tr>
    <td>Modelica.Electrical.Polyphase</td>
    <td>{0,0,255}</td>
    <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleElectricalPolyphase.png\"></td>
  </tr>
  <tr>
    <td>Modelica.Electrical.QuasiStatic</td>
    <td>{85,170,255}</td>
    <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleElectricalQuasiStatic.png\"></td>
  </tr>
  <tr>
    <td>Modelica.Electrical.Spice3</td>
    <td> {170,85,255}</td>
    <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleElectricalSpice3.png\"></td>
  </tr>
  <tr>
    <td>Modelica.Magnetic.FluxTubes</td>
    <td>{255,127,0}</td>
    <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleMagneticFluxTubes.png\"></td>
  </tr>
  <tr>
    <td>Modelica.Magnetic.FundamentalWave</td>
    <td>{255,127,0}</td>
    <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleMagneticFundamentalWave.png\"></td>
  </tr>
  <tr>
    <td>Modelica.Magnetic.QuasiStatic</td>
    <td>{255,170,85}</td>
    <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleMagneticQuasiStatic.png\"></td>
  </tr>
  <tr>
    <td>Modelica.Mechanics.MultiBody</td>
    <td>{192,192,192}</td>
    <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleMechanicsMultiBody.png\"></td>
  </tr>
  <tr>
    <td>Modelica.Mechanics.Rotational</td>
    <td>{95,95,95}</td>
    <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleMechanicsRotational.png\"></td>
  </tr>
  <tr>
    <td>Modelica.Mechanics.Translational</td>
    <td>{0,127,0}</td>
    <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleMechanicsTranslational.png\"></td>
  </tr>
  <tr>
    <td>Modelica.Fluid</td>
    <td>{0,127,255}</td>
    <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleFluid.png\"></td>
  </tr>
  <tr>
    <td>Modelica.Media</td>
    <td>none</td>
    <td></td>
  </tr>
  <tr>
    <td>Modelica.Thermal.FluidHeatFlow</td>
    <td>{0,0,255}</td>
    <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleThermalFluidHeatFlow.png\"></td>
  </tr>
  <tr>
    <td>Modelica.Thermal.HeatTransfer</td>
    <td>{191,0,0}</td>
    <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleThermalHeatTransfer.png\"></td>
  </tr>
  <tr>
    <td>Modelica.Math</td>
    <td>none</td>
    <td></td>
  </tr>
  <tr>
    <td>Modelica.ComplexMath</td>
    <td>none</td>
    <td></td>
  </tr>
  <tr>
    <td>Modelica.Utilities</td>
    <td>none</td>
    <td></td>
  </tr>
  <tr>
    <td>Modelica.Constants</td>
    <td>none</td>
    <td></td>
  </tr>
  <tr>
    <td>Modelica.Icons</td>
    <td>none</td>
    <td></td>
  </tr>
  <tr>
    <td>Modelica.Units</td>
    <td>none</td>
    <td></td>
  </tr>
</table>

<h4>Icon size</h4>

<p>The icon of a Modelica class shall not be significantly greater or smaller than the default Diagram limits of 200 units x 200 units. These default diagram limits are</p>
<ul>
<li>-100 units &le; horizontal coordinate &le; +100 units</li>
<li>-100 units &le; vertical coordinate &le; +100 units</li>
</ul>
<p>If possible, the icon shall be designed such way, that the icon name <code>%name</code>
and the most significant parameter can be displayed within the vertical Diagram range of the icon.</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 1</strong>: (a) Typical icon, (b) including dimensions</caption>
  <tr>
    <td> (a)
      <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icon_name.png\"
           alt=\"Typical placement of component name\">
    </td>
    <td> (b)
      <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icon_name_dimensions.png\"
           alt=\"Typical dimensions of icon and its entities\">
    </td>
  </tr>
</table>

<h4>Component Name</h4>

<p>The component name <code>%name</code> shall be in RGB (0,0,255) blue color.</p>
<ul>
<li>Text height: 40 units</li>
<li>Text width: 300 units</li>
</ul>
<p>The text shall be located above the actual icon. If there is enough space, the upper text limit of the component name
shall be 10 units below the upper icon boundary, see <strong>Fig.&nbsp;1</strong>.</p>

<p>If the icon is as big as the entire icon range of 200 units x 200 units, e.g. in blocks,
the component name shall be placed above the icon with vertical 10 units of space between icon and lower text box, see <strong>Fig.&nbsp;2</strong>.</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 2</strong>: Block component name</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Block_name.png\"
           alt=\"Placement of block component name\">
    </td>
  </tr>
</table>

<p>If there is a connector located at the top icon boundary and it is obvious that this connector influences the model
behavior compared to a similar model without such connector, then a line from the connector to the actual icon
shall be avoided to keep the design straight, see <strong>Fig.&nbsp;4</strong>. If it is required to use a line indicating the connector dependency, then
the line shall be interrupted such that this line does not interfere with component name.</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 3</strong>: Component name between actual icon and connector</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icon_name_connector_above.png\"
           alt=\"Component name placed between actual icon and connector\">
    </td>
  </tr>
</table>

<p>In some cases, if there is not alternative, the component name has to be placed below the actual icon, see. <strong>Fig.&nbsp;4</strong>.</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 4</strong>: Component name below actual icon</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icon_name_below.png\"
           alt=\"Icon with name placed below it\">
    </td>
  </tr>
</table>

<h4>Parameter Name</h4>

<p>One significant parameter shall be placed below the icon, see <strong>Fig.&nbsp;1</strong> and <strong>Fig.&nbsp;2</strong>. The parameter name shall be RGB (0,0,0) black color.</p>
<ul>
<li>Text height: 40 units (or 30 units, minimum 20 units, if required)</li>
<li>Text width: 300 units</li>
</ul>
<p>The parameter text box shall be placed 10 units below the actual icon.
</p>

<h4>Connector location</h4>

<p>Physical connectors shall always be located on the icon boundary. Input and output connector shall be placed outside the icon, see <strong>Fig.&nbsp;2</strong> and <strong>Fig.&nbsp;3</strong>.
Preferred connector locations are:</p>
<ul>
<li>at the four corners of the icon diagram, see <strong>Fig.&nbsp;5</strong></li>
<li>at vertical or horizontal symmetry line of an icon, see <strong>Fig.&nbsp;1&ndash;3</strong></li>
<li>alternative connection points shall be located in a raster of 20 units (or 10 units) if required, see <strong>Fig.&nbsp;4</strong></li>
</ul>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 5</strong>: Connectors located at the four corners of the icon diagram</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icon_connector_corner.png\"
           alt=\"Icon of connector corner\">
    </td>
  </tr>
</table>

<h4>Sensors</h4>

<p>
Based on <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2628\">#2628</a> the following guidelines for the
design of sensors apply:
</p>

<ul>
<li>The sensor outputs shall be indicated by its SI unit, not its quantity; the proper SI unit shall be compliant with the unit definitions of
    <a href=\"modelica://Modelica.Units.SI\">Modelica.Units.SI</a>,
    e.g. heat flow is indicated by <strong>W</strong>, torque is indicated by <strong>N.m</strong></li>
<li>The text color of the SI units is {64,64,64} in RGB code</li>
<li>For a sensor with a single output signal the SI unit shall be placed within the sensor,
    see <strong>Fig.&nbsp;6</strong> and <strong>7</strong>
    <ul>
    <li>In a <a href=\"modelica://Modelica.Icons.RoundSensor\">round sensor</a> the text size shall be
        <ul>
        <li>either <code>{{-30,-10},{30,-70}}</code> (<strong>Fig.&nbsp;6(a)</strong>)</li>
        <li>or <code>{{-50,-12},{50,-48}}</code> (<strong>Fig.&nbsp;6(b)</strong>), depending on the better readability</li>
        </ul></li>

    <li>In a <a href=\"modelica://Modelica.Icons.RectangularSensor\">rectangular sensor</a> the text size shall be
        <code>{{-24,20},{66,-40}}</code> (<strong>Fig.&nbsp;7</strong>)</li>
    </ul></li>
<li>For a sensor with multiple output signals the SI unit shall be placed next to the output signal;
    a signal connectors and the SI units may overlap, see <strong>Fig.&nbsp;8</strong>
    <ul>
    <li>Text height: 40 units (or 30 units, minimum 20 units, if required)</li>
    <li>Text width: 40 units (or 30 units, minimum 20 units, if required)</li>
    </ul></li>
</ul>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 6</strong>: Round sensor with (a) short and (b) longer SI unit</caption>
  <tr>
    <td> (a)
      <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icon_sensor_round.png\"
           alt=\"Icon of connector corner\">
    </td>
    <td> (b)
      <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icon_sensor_round2.png\"
           alt=\"Icon of connector corner\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 7</strong>: Rectangular sensor </caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icon_sensor_rectangular.png\"
           alt=\"Icon of connector corner\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 8</strong>: Sensor with multiple signal outputs and SI units located next to the output connectors</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icon_sensor_multi.png\"
           alt=\"Icon of connector corner\">
    </td>
  </tr>
</table>

<h4>Diagram layer</h4>

<p>The diagram layer is intended to contain the graphical components, and if there are no graphical components it shall be left empty.
In particular do not make the diagram layer a copy of the icon layer.
Graphical illustrations shall not be added in the diagram layer, but can be added in the HTML documentation.</p>
</html>"));
  end Icons;
  annotation (DocumentationClass=true,Documentation(info="<html>
<p>A Modelica main package should be compliant with the UsersGuide stated in this documentation:</p>
<ol>
<li> Conventions of the <a href=\"modelica://Modelica.UsersGuide.Conventions.ModelicaCode\">Modelica code</a></li>
<li> Consistent <a href=\"modelica://Modelica.UsersGuide.Conventions.Documentation\">HTML documentation</a></li>
<li> Structure to be provided by a main package
<ul>
     <li> <a href=\"modelica://Modelica.UsersGuide.Conventions.UsersGuide\">User's Guide</a></li>
     <li> <strong>Examples</strong> containing models demonstrating the usage of the library.</li>
     <li> <strong>Components</strong> -- in case of a complex library a more detailed structure can be established.</li>
     <li> <strong>Sensors</strong></li>
     <li> <strong>Sources</strong></li>
     <li> <strong>Interfaces</strong> containing connectors and simple partial interface models.</li>
     <li> <strong>BaseClasses</strong> containing partial models with physical equations other than trivial and balance equations.</li>
     <li> <strong>Types</strong> containing type, enumeration and choice definitions.</li>
</ul></li>
<li> These packages should appear in the listed order.</li>
</ol>
</html>"));
end Conventions;
