within Modelica.Electrical;
package Digital 
  "Library for digital electrical components based on the VHDL standard with 9-valued logic and conversion to 2-,3-,4-valued logic" 
package UsersGuide "User's Guide" 
    
  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
Library <b>Electrical.Digital</b> is a <b>free</b> Modelica package providing
components to model <b>digital</b> electronic
systems based on combinational and sequential logic in a convenient
way. This package contains the <b>User's Guide</b> for
the library and has the following content:
</p>
<ol>
<li><a href=\"Modelica://Modelica.Electrical.Digital.UsersGuide.OverView\">Overview of library</a>
     gives an overview of the library.</li>
<li> <a href=\"Modelica://Modelica.Electrical.Digital.UsersGuide.FirstExample\">A first example</a>
     demonstrates at hand of a first example how to use this library.</li>
<li> <a href=\"Modelica://Modelica.Electrical.Digital.UsersGuide.ApplicationExample\">An
     application example</a> demonstrates a generic n-bit adder.
     .</li>
<li><a href=\"Modelica://Modelica.Electrical.Digital.UsersGuide.ReleaseNotes\">Release Notes</a>
    summarizes the differences between different versions of this library.</li>
<li><a href=\"Modelica://Modelica.Electrical.Digital.UsersGuide.Literature\">Literature</a>
    provides references that have been used to design and implement this
    library.</li>
<li><a href=\"Modelica://Modelica.Electrical.Digital.UsersGuide.Contact\">Contact</a>
    provides information about the authors of the library as well as
    acknowledgments.</li>
</ol>
</html>"));
    
  class OverView "Overview of library" 
      
    annotation (Documentation(info="<html>
<p>
In this section, an overview of the most important features
of this library is given.
</p>
<p>(will be added as soon as possible). </p>
</html>
"));
  end OverView;
    
  class FirstExample "A first example" 
      
    annotation (Documentation(info="<html>
<p>
A first example will be given here (not yet done).
</p>
</html>
"));
  end FirstExample;
    
  class ApplicationExample "An application example" 
      
    annotation (Documentation(info="<html>
<p>
An application example will be given here (not yet done).
</p>
</html>
"));
  end ApplicationExample;
    
  class ReleaseNotes "Release notes" 
      
    annotation (Documentation(info="<html>
<h4>Version 1.0.7, 2005-07-01</h4>
<ul>
<li> xxxx</li>
</ul>
<h4>Version 1.0.6, 2004-10-18</h4>
<ul>
<li> Missing HTML tags added (problems with mismatched pre tags fixed).</li>
<li> CVS ID string deleted.</li>
</ul>
<h4>Version 1.0.5, 2004-10-01</h4>
<ul>
<li> Wrong identifiers x0 and Tdel in HalfAdder example fixed.</li>
<li> Experiment command in FlipFlop example deleted.</li>
<li> Known issue: Pulse source causes a warning in Dymola. It is recommended to use Clock source.</li>
</ul>
<h4>Version 1.0.4, 2004-09-30</h4>
<ul>
<li> Documentation improved.</li>
</ul>
<h4>Version 1.0.3, 2004-09-21</h4>
<ul>
<li> Table names changed from \"map\" to \"Table\".</li>
<li> Icons for converters modified.</li>
<li> LogicValueType renamed to Logic. For the Electrical.Digital library
     the type Logic has a fundamental meaning. Logic is similar to
     Real, Integer or Boolean in other packages. Names for converters
     are now more consistent (LogicToBoolean, RealToLogic etc.).</li>
<li> Icons for gates and sources improved.</li>
<li> New examples added.</li>
<li> Internal names for signals and ports unified.</li>
<li> Simple Clock source added in addition to Pulse source (for convenience reasons).</li>
</ul>
<h4>Version 1.0.2, 2004-09-13</h4>
<ul>
<li> First prerelease for discussions at the 40th Modelica Design Meeting.</li>
</ul>
<h4>Version 1.0.1, 2004-06-01</h4>
<ul>
<li> Packages Tables, Basic, and Gates implemented.</li>
<li> Transport and inertial delay implemented and successfully tested.</li>
</ul>
<h4>Version 1.0.0, 2003-05-01</h4>
<ul>
<li> A first version has been implemented for case studies.</li>
</ul>
</html>
"));
  equation 
      
  end ReleaseNotes;
    
  class Literature "Literature" 
      
    annotation (Documentation(info="<html>
<p>
The Electrical.Digital library is based on the following references:
</p>
<dl>
<dt>Ashenden, P. J.:</dt>
<dd> <b>The Designer's Guide to VHDL.</b> San Francisco: Morgan Kaufmann, 1995, 688 p. ISBN 1-55860-270-4.
     <br>&nbsp;</dd>
</dl>
<dl>
<dt>IEEE 1076-1993:</dt>
<dd> <b>IEEE Standard VHDL Language Reference Manual (ANSI).</b> 288 p. ISBN 1-55937-376-8. IEEE Ref. SH16840-NYF.
     <br>&nbsp;</dd>
</dl>
<dl>
<dt>IEEE 1164-1993:</dt>
<dd> <b>IEEE Standard Multivalue Logic System for VHDL Model Interoperability (Std_logic_1164).</b> 24 p. ISBN 1-55937-299-0. IEEE Ref. SH16097-NYF.
     <br>&nbsp;</dd>
</dl>
<dl>
<dt>Lipsett, R.; Schaefer, C.; Ussery, C.:</dt>
<dd> <b>VHDL: Hardware Description and Design.</b> Boston: Kluwer, 1989, 299 p. ISBN 079239030X.
     <br>&nbsp;</dd>
</dl>
<dl>
<dt>Navabi, Z:</dt>
<dd> <b>VHDL: Analysis and Modeling of Digital Systems.</b> New York: McGraw-Hill, 1993, 375 p. ISBN 0070464723.
     <br>&nbsp;</dd>
</dl>
</html>
 "));
      
  end Literature;
    
  class Contact "Contact" 
      
    annotation (Documentation(info="<html>
<dl>
<dt><b>Main Authors:</b>
<dd><a href=\"http://people.eas.iis.fraunhofer.de/Christoph.Clauss/\">Christoph Clau&szlig;</a>
    &lt;<A HREF=\"mailto:Christoph.Clauss@eas.iis.fraunhofer.de\">Christoph.Clauss@eas.iis.fraunhofer.de</A>&gt;<br>
    <a href=\"http://people.eas.iis.fraunhofer.de/Andre.Schneider/\">Andr&eacute; Schneider</a>
    &lt;<A HREF=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</A>&gt;<br>
    Fraunhofer Institute for Integrated Circuits (IIS)<br>
    Design Automation Department (EAS)<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden<br>
    Germany<br>
</dl>
<br>
<br>
<dl>
<dt><b>Acknowledgements:</b></dt>
<dd>
    We thank our colleague <a href=\"http://people.eas.iis.fraunhofer.de/Ulrich.Donath/\">Ulrich Donath</a>
    &lt;<a href=\"mailto:Ulrich.Donath@eas.iis.fraunhofer.de\">Ulrich.Donath@eas.iis.fraunhofer.de</a>&gt;
    for his support and fruitful discussions regarding all questions on VHDL and the IEEE 1164 standard
    logic libraries. Furthermore, we thank our students Teresa Schlegel and Enrico Weber for implementing
    and carefully testing many models and examples.<br>
</dd>
</dl>
</html>
"));
      
  end Contact;
    
end UsersGuide;
  
  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.45,
      y=0.01,
      width=0.44,
      height=0.65,
      library=1,
      autolayout=1),
    Documentation(info="<html>
<p>
This library contains packages for digital electrical components. Both, type system
and models are based on the VHDL standard (IEEE Std 1076-1987 VHDL, IEEE Std 1076-1993 VHDL,
IEEE Std 1164 Multivalue Logic System):
<ul>
<li>Interfaces: Definition of signals and interfaces</li>
<li>Tables: All truth tables needed</li>
<li>Delay: Transport and inertial delay</li>
<li>Basic: Basic logic without delay</li>
<li>Gates: Basic gates composed by basic components and inertial delay</li>
<li>Tristate: (not yet available)</li>
<li>FlipFlops: (not yet available) </li>
<li>Latches: (not yet available)</li>
<li>TransferGates: (not yet available)</li>
<li>Multiplexers (not yet available)</li>
<li>Memory: Ram, Rom, (not yet available)</li>
<li>Sources: Time-dependend signal sources</li>
<li>Converters</li>
<li>Examples</li>
</ul>
</p>
<p>
The logic values are coded by integer values. The following code table is necessary
for both setting of input and interpreting the output values.
</p>
<p><b>Code Table:</b></p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Logic value</b></td>
      <td valign=\"top\"><b>Integer code</b></td>
      <td valign=\"top\"><b>Meaning</b></td>
  </tr>
                         
  <tr><td valign=\"top\">'U'</td> <td valign=\"top\">1</td> <td valign=\"top\">Uninitialized</td></tr>
  <tr><td valign=\"top\">'X'</td> <td valign=\"top\">2</td> <td valign=\"top\">Forcing Unknown</td></tr>
  <tr><td valign=\"top\">'0'</td> <td valign=\"top\">3</td> <td valign=\"top\">Forcing 0</td></tr>
  <tr><td valign=\"top\">'1'</td> <td valign=\"top\">4</td> <td valign=\"top\">Forcing 1</td></tr>
  <tr><td valign=\"top\">'Z'</td> <td valign=\"top\">5</td> <td valign=\"top\">High Impedance</td></tr>
  <tr><td valign=\"top\">'W'</td> <td valign=\"top\">6</td> <td valign=\"top\">Weak Unknown</td></tr>
  <tr><td valign=\"top\">'L'</td> <td valign=\"top\">7</td> <td valign=\"top\">Weak 0</td></tr>
  <tr><td valign=\"top\">'H'</td> <td valign=\"top\">8</td> <td valign=\"top\">Weak 1</td></tr>
  <tr><td valign=\"top\">'-'</td> <td valign=\"top\">9</td> <td valign=\"top\">Don't care</td></tr>
</table>

<p>
The library will be developed in two main steps. The first step contains the basic components and
the gates. In the next step the more complicated devices will be added. Currently the first step of
the library is implemented and released for public use.
</p>

<p>
Copyright &copy; 1998-2007, Modelica Association and Fraunhofer-Gesellschaft.
</p>
<p>
<i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p><br>

</HTML>
"), Diagram,
    Icon(
      Polygon(points=[-100,-100; -100,50; 80,50; 80,-100; -100,-100],style(
            fillColor=30, fillPattern=1)),
      Polygon(points=[-100,50; -80,70; 100,70; 80,50; -100,50],      style(
            fillColor=30, fillPattern=1)),
      Polygon(points=[100,70; 100,-80; 80,-100; 80,50; 100,70],      style(
            fillColor=30, fillPattern=1)),
      Text(
        extent=[-120,122; 120,73],
        string="%name",
        style(color=1)),
      Rectangle(extent=[-52,4; -32,-36], style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=7,
          rgbfillColor={255,255,255})),
      Rectangle(extent=[8,-46; 28,-86], style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=7,
          rgbfillColor={255,255,255})),
      Rectangle(extent=[8,4; 28,-36], style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=7,
          rgbfillColor={255,255,255})),
      Line(points=[-72,-6; -52,-6], style(color=0, rgbcolor={0,0,0})),
      Line(points=[-72,-28; -52,-28], style(color=0, rgbcolor={0,0,0})),
      Ellipse(extent=[-32,-14; -28,-18], style(color=0, rgbcolor={0,0,0})),
      Ellipse(extent=[28,-14; 32,-18], style(color=0, rgbcolor={0,0,0})),
      Line(points=[-28,-16; 8,-16], style(color=0, rgbcolor={0,0,0})),
      Line(points=[-28,-16; -12,-16; -12,-56; 8,-56], style(color=0, rgbcolor={
              0,0,0})),
      Line(points=[8,-76; -72,-76], style(color=0, rgbcolor={0,0,0})),
      Line(points=[32,-16; 48,-16], style(color=0, rgbcolor={0,0,0})),
      Line(points=[28,-66; 48,-66], style(color=0, rgbcolor={0,0,0})),
      Text(
        extent=[-32,-8; -52,0],
        string="&",
        style(color=0, rgbcolor={0,0,0})),
      Text(
        extent=[28,-10; 8,-2],
        string="1",
        style(color=0, rgbcolor={0,0,0})),
      Text(
        extent=[28,-58; 8,-50],
        string="=",
        style(color=0, rgbcolor={0,0,0})),
      Text(
        extent=[-90,40; 70,10],
        string="Library",
        style(
          color=9,
          fillColor=0,
          fillPattern=1))));
  
  package Examples 
    "Examples that demonstrate the usage of the Digital electrical components" 
    model Multiplexer "4 to 1 Bit Multiplexer Example" 
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      annotation (
        Documentation(info="<HTML>
<h4>4 to 1 Bit Multiplexer</h4>
<P>
The multiplexer converts a parallel 4 bit signal in a sequential
1 bit stream.
</P>
</HTML>
"),     Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(Rectangle(extent=[-100,100; 100,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=51,
              rgbfillColor={255,255,170}))),
        Diagram,
        Window(
          x=0.2,
          y=0.06,
          width=0.62,
          height=0.69),
        experiment(StopTime=250),
        experimentSetupOutput);
      D.Sources.Clock CLK(period=20)  annotation (extent=[-80,-56; -60,-36]);
      D.Sources.Table D0(
        y0=3,
        x={4,3,4,3},
        t={50,100,145,200}) annotation (extent=[-80,58; -60,78]);
      D.Sources.Table D1(
        y0=3,
        x={4,3,4,3},
        t={22,140,150,180}) annotation (extent=[-80,32; -60,52]);
      D.Examples.Utilities.MUX4 MUX annotation (extent=[-10,0; 70,80]);
      D.Sources.Table D2(
        y0=3,
        x={4,3,4,3},
        t={22,140,150,180}) annotation (extent=[-80,6; -60,26]);
      D.Sources.Table D3(
        y0=3,
        x={4,3,4,3},
        t={22,140,150,180}) annotation (extent=[-80,-20; -60,0]);
      D.Examples.Utilities.JKFF FF annotation (extent=[-20,-62; 0,-42]);
      D.Sources.Set Enable annotation (extent=[-80,-82; -60,-62]);
    equation 
      connect(CLK.y, FF.clk) annotation (points=[-60,-46; -36,-46; -36,-52; -20,
            -52], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
      connect(Enable.y, FF.k) annotation (points=[-60,-72; -30,-72; -30,-59;
            -20,-59], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
      connect(Enable.y, FF.j) annotation (points=[-60,-72; -30,-72; -30,-45;
            -20,-45], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
      connect(CLK.y, MUX.a0) annotation (points=[-60,-46; -36,-46; -36,22.4;
            -10,22.4], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
      connect(D0.y, MUX.d0) annotation (points=[-60,68; -10,68], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
      connect(D1.y, MUX.d1) annotation (points=[-60,42; -54,42; -54,57.6; -10,
            57.6], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
      connect(D2.y, MUX.d2) annotation (points=[-60,16; -50,16; -50,47.2; -10,
            47.2], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
      connect(D3.y, MUX.d3) annotation (points=[-60,-10; -46,-10; -46,36.8; -10,
            36.8], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
      connect(FF.q, MUX.a1) annotation (points=[0,-45; 2,-45; 2,-22; -20,-22;
            -20,12; -10,12], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
    end Multiplexer;
    
    model FlipFlop "Pulse Triggered Master Slave Flip-Flop" 
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      annotation (
        Documentation(info="<HTML>
<h4>FlipFlop</h4>
<P>
Pulse-triggered master-slave flip-flop.
</P>
</HTML>
"),     Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(Rectangle(extent=[-100,100; 100,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=51,
              rgbfillColor={255,255,170}))),
        Diagram,
        Window(
          x=0.2,
          y=0.06,
          width=0.62,
          height=0.69),
        experiment(StopTime=250),
        experimentSetupOutput);
      D.Examples.Utilities.JKFF FF 
                     annotation (extent=[-10,-40; 70,40]);
      D.Sources.Clock CLK(period=10)  annotation (extent=[-80,-10; -60,10]);
      D.Sources.Table J(
        y0=3,
        x={4,3,4,3},
        t={50,100,145,200}) annotation (extent=[-80,18; -60,38]);
      D.Sources.Table K(
        y0=3,
        x={4,3,4,3},
        t={22,140,150,180}) annotation (extent=[-80,-38; -60,-18]);
    equation 
      connect(J.y, FF.j)     annotation (points=[-60,28; -10,28], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(CLK.y, FF.clk)    annotation (points=[-60,0; -10,0], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(K.y, FF.k)      annotation (points=[-60,-28; -10,-28], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
    end FlipFlop;
    
    model HalfAdder "adding circuit for binary numbers without input carry bit" 
      import Modelica.Electrical.Digital;
      annotation (
        Documentation(info="<HTML>
<P>
This example demonstrates an adding circuit for binary numbers, which internally realizes the interconnection to
And and to Xor in the final sum.
<br>
<br>
1 + 0 = 1<br>
0 + 1 = 1<br>
1 + 1 = 10<br>
0 + 0 = 0
<br>
<br>
<b>a</b> + <b>b</b> = <b>s</b>
<br>(The carry of this adding is <b>c</b>.)
<br>
<br>and
<br>
<br>
<b>a</b> * <b>b</b> = <b>s</b>
<br>  (It is an interconnection to And.)
<br>
<br>
<b>a</b> * <b>b</b> + <b>a</b> * <b>b</b> = <b>a</b> Xor <b>b</b> = <b>c</b>
<br>(It is an interconnection to Xor.)
<br>
<br>
<pre>  <b>a</b>     <b>b</b>     <b>c</b>      <b>s</b>     <b>t</b></pre>

 <pre>  1     0     1      0     1</pre>
 <pre>  0     1     1      0     2</pre>
 <pre>  1     1     0      1     3</pre>
 <pre>  0     0     0      0     4</pre>

<br>
<br>
<b>t</b> is the pick-up instant of the next bit(s) in the simulation.
The simulation stop time should be 5 seconds.
</P>
</HTML>
"),     Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(Rectangle(extent=[-88,100; 90,-100],   style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=51,
              rgbfillColor={255,255,170})), Line(points=[40,54; 40,60; -40,60;
                10,0; -40,-60; 40,-60; 40,-52], style(
              color=0,
              rgbcolor={0,0,0},
              fillPattern=1))),
        Diagram,
        Window(
          x=0.2,
          y=0.06,
          width=0.62,
          height=0.69),
        experiment(StopTime=5),
        experimentSetupOutput);
      Sources.Table a(
        t={1,2,3,4},
        x={4,3,4,3},
        y0=3)   annotation (extent=[-80,18; -60,38]);
      Sources.Table b(
        x={4,3},
        t={2,4},
        y0=3)   annotation (extent=[-80,-38; -60,-18]);
      Digital.Examples.Utilities.HalfAdder Adder(delayTime=0.3) 
                            annotation (extent=[-40,-40; 40,40]);
      Digital.Converters.LogicToReal s 
                               annotation (extent=[60,18; 80,38]);
      Digital.Converters.LogicToReal c 
                               annotation (extent=[60,-38; 80,-18]);
    equation 
      connect(b.y,Adder. b) annotation (points=[-60,-28; -40,-28],
                  style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=78,
          rgbfillColor={127,0,127},
          fillPattern=1));
      connect(a.y,Adder. a) annotation (points=[-60,28; -40,28],                style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=78,
          rgbfillColor={127,0,127},
          fillPattern=1));
      connect(Adder.s, s.x[1]) annotation (points=[40,28; 65,28], style(color=
              78, rgbcolor={127,0,127}));
      connect(Adder.c, c.x[1]) annotation (points=[40,-28; 65,-28], style(color=
             78, rgbcolor={127,0,127}));
    end HalfAdder;
    
    model FullAdder "Full 1 Bit Adder Example" 
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      annotation (
        Documentation(info="<HTML>
<P>
<br>It is an adding circuit for binary numbers with input carry bit, which consists of two HalfAdders.
<br>
<br>
<b>a</b>.y, <b>b</b>.y and <b>c</b>.y are the inputs of the FullAdder.
<br>
<b>c</b>out = <b>Or1</b>.y and <b>h</b>.s are the outputs of the Fulladder.
<br>
<br>
<b>t</b> is the pick-up instant of the next bit(s) in the simulation.
<pre>   <b>a</b>.y      <b>b</b>.y      <b>c</b>.y     <b>c</b>out        <b>h</b>.s        <b>t</b> </pre>

<pre>
     1        0        0        0          1        1
     0        1        0        0          1        2
     0        0        1        0          1        3
     1        1        0        1          0        4
     0        1        1        1          0        5
     1        0        1        1          0        6
     1        1        1        1          1        7
     0        0        0        0          0        8
</pre>
</P>
The simulation stop time should be 10 seconds.
</HTML>
"),     Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(Rectangle(extent=[-100,100; 100,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=51,
              rgbfillColor={255,255,170})), Line(points=[40,54; 40,60; -40,60; 10,0;
                -40,-60; 40,-60; 40,-52], style(
              color=0,
              rgbcolor={0,0,0},
              fillPattern=1))),
        Diagram,
        Window(
          x=0.2,
          y=0.06,
          width=0.62,
          height=0.69),
        experiment(StopTime=10),
        experimentSetupOutput(
          states=false,
          derivatives=false,
          inputs=false));
      Digital.Examples.Utilities.FullAdder Adder1            annotation (extent=[0,
            -30; 60,30]);
      Digital.Converters.LogicToReal s 
                               annotation (extent=[70,12; 90,32]);
      Digital.Converters.LogicToReal c_out 
                                   annotation (extent=[70,-32; 90,-12]);
      Digital.Examples.Utilities.Counter3 Counter 
        annotation (extent=[-60,-18; -20,22]);
      Digital.Sources.Set Enable(x=L.'1') annotation (extent=[-90,6; -70,26]);
      Digital.Sources.Clock CLK annotation (extent=[-90,-22; -70,-2]);
    equation 
      connect(Adder1.s, s.x[1]) 
                               annotation (points=[60.3,21; 68,21; 68,22; 75,22],
                                                                    style(color=
             78, rgbcolor={127,0,127}));
      connect(Adder1.c_out, c_out.x[1]) 
                                       annotation (points=[60,-21; 68,-21; 68,
            -22; 75,-22],
          style(color=78, rgbcolor={127,0,127}));
      connect(CLK.y, Counter.count) annotation (points=[-70,-12; -60,-12],
          style(color=78, rgbcolor={127,0,127}));
      connect(Enable.y, Counter.enable) annotation (points=[-70,16; -60,16],
          style(color=78, rgbcolor={127,0,127}));
      connect(Counter.q2, Adder1.a) annotation (points=[-20,16; -10,16; -10,21;
            0,21], style(color=78, rgbcolor={127,0,127}));
      connect(Counter.q1, Adder1.b) annotation (points=[-20,2; -10,2; -10,9; 0,
            9], style(color=78, rgbcolor={127,0,127}));
      connect(Counter.q0, Adder1.c_in) annotation (points=[-20,-12; -10,-12;
            -10,-21; 0,-21], style(color=78, rgbcolor={127,0,127}));
    end FullAdder;
    
    model Adder4 "4 Bit Adder Example" 
      import Modelica.Electrical.Digital;
      annotation (
        Documentation(info="<HTML>
<P>
Four Fulladders are combined to built a four bit adder unit.
<br>
<br>
In dependence on time five additions are carried out:
<br>
<pre>
at t = 0                            at t = 1
 a       0 0 0 0                       a      1 1 1 0
 b    +  0 0 0 0                       b   +  1 0 1 1
 <b>s     0 0 0 0 0</b>                      <b>s     1 0 0 1 0</b>
at t = 2                             at t = 3
 a       0 1 1 0                       a      1 1 1 0
 b    +  0 0 1 1                       b   +  1 0 1 0
 <b>s     1 0 1 0 0</b>                      <b>s     0 0 0 1 1</b>

at t = 4
 a      1 1 0 0
 b   +  1 1 1 0
 <b>s    0 0 1 0 1</b>
 </pre>
To show the influence of delay a large delay time of 0.1s is choosen.
Furthermore, all signals are initialized with U, the unitialized value.
Please remember, that the nine logic values are coded by the numbers 1,...,9.
The summands a and b can be found at the output signals of the taba and tabb sources.
The result can be seen in the output signals of the Fulladders according to:
<pre>
      a                       <b>a4</b>.y      <b>a3</b>.y      <b>a2</b>.y      <b>a1</b>.y
      b                       <b>b4</b>.y      <b>b3</b>.y      <b>b2</b>.y      <b>b1</b>.y
      sum   <b>Adder4</b>.c_out  <b>Adder4.s</b>  <b>Adder3.s</b>  <b>Adder2.s</b>  <b>Adder1.s</b>
</pre>
The simulation stop time has to be 5s.

</P>
</HTML>
"),     Coordsys(
          extent=[-200,-200; 200,200],
          grid=[2, 2],
          component=[20, 20]),
        Icon(Rectangle(extent=[-200,200; 200,-200], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=51,
              rgbfillColor={255,255,170}))),
        Diagram,
        Window(
          x=0.2,
          y=0.06,
          width=0.62,
          height=0.69),
        experiment(StopTime=5),
        experimentSetupOutput(
          states=false,
          derivatives=false,
          inputs=false));
      
      Digital.Sources.Table b4(
        y0=3,
        x={4,3},
        t={1,3}) annotation (extent=[70,-20; 110,20]);
      Digital.Sources.Table b1(
        x={4,3,4},
        y0=3,
        t={1,2,3}) annotation (extent=[-170,-20; -130,20]);
      Digital.Sources.Table b2(
        y0=3,
        x={4},
        t={4}) annotation (extent=[-90,-20; -50,20]);
      Digital.Sources.Table b3(
        y0=3,
        x={4},
        t={1}) annotation (extent=[-10,-20; 30,20]);
      Digital.Sources.Table a1(
        y0=3,
        x={4,3,4},
        t={1,2,3}) annotation (extent=[-170,40; -130,80]);
      Digital.Sources.Table a2(
        y0=3,
        x={4},
        t={1}) annotation (extent=[-90,40; -50,80]);
      Digital.Sources.Table a3(
        y0=3,
        x={4,3},
        t={1,4}) annotation (extent=[-8,40; 30,80]);
      Digital.Sources.Table a4(
        y0=3,
        x={3},
        t={1}) annotation (extent=[70,40; 110,80]);
      Sources.Set Set(x=3) 
        annotation (extent=[-130,-54; -170,-94],
                                            rotation=180);
      Digital.Examples.Utilities.FullAdder Adder1 
                                   annotation (extent=[-100,-80; -60,-40]);
      Digital.Examples.Utilities.FullAdder Adder2 
                                  annotation (extent=[-20,-80; 20,-40]);
      Digital.Examples.Utilities.FullAdder Adder3 
                                  annotation (extent=[60,-80; 100,-40]);
      Digital.Examples.Utilities.FullAdder Adder4 
                                  annotation (extent=[140,-80; 180,-40]);
    equation 
      connect(b1.y, Adder1.b)  annotation (points=[-130,0; -120,0; -120,-54;
            -100,-54], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(a1.y, Adder1.a)  annotation (points=[-130,60; -110,60; -110,-46;
            -100,-46], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(Set.y, Adder1.c_in)  annotation (points=[-130,-74; -100,-74],
          style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(Adder1.c_out, Adder2.c_in)  annotation (points=[-60,-74; -20,-74],
          style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(Adder2.c_out, Adder3.c_in) annotation (points=[20,-74; 60,-74],
          style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(Adder3.c_out, Adder4.c_in) annotation (points=[100,-74; 140,-74],
          style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(b2.y, Adder2.b) annotation (points=[-50,0; -40,0; -40,-54; -20,
            -54], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(a2.y, Adder2.a) annotation (points=[-50,60; -30,60; -30,-46; -20,
            -46], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(b3.y, Adder3.b) annotation (points=[30,0; 40,0; 40,-54; 60,-54],
          style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(a3.y, Adder3.a) annotation (points=[30,60; 50,60; 50,-46; 60,-46],
          style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(b4.y, Adder4.b) annotation (points=[110,0; 120,0; 120,-54; 140,
            -54], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
      connect(a4.y, Adder4.a) annotation (points=[110,60; 130,60; 130,-46; 140,
            -46], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
    end Adder4;
    
    model Counter3 "3 Bit Counter Example" 
      import D = Modelica.Electrical.Digital;
      annotation (
        Documentation(info="<HTML>
 
</HTML>
"),     Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(Rectangle(extent=[-100,100; 100,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=51,
              rgbfillColor={255,255,170}))),
        Diagram,
        Window(
          x=0.2,
          y=0.06,
          width=0.62,
          height=0.69),
        experiment(StopTime=10),
        experimentSetupOutput(
          states=false,
          derivatives=false,
          inputs=false));
      D.Sources.Step Enable       annotation (extent=[-90,8; -50,48]);
      D.Sources.Clock Clock       annotation (extent=[-90,-48; -50,-8]);
      D.Examples.Utilities.Counter3 Counter 
        annotation (extent=[-30,-40; 50,40]);
    equation 
      connect(Enable.y, Counter.enable) annotation (points=[-50,28; -30,28],
          style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
      connect(Clock.y, Counter.count) annotation (points=[-50,-28; -30,-28],
          style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
    end Counter3;
    
    model Counter "Generic N Bit Counter Example" 
      import D = Modelica.Electrical.Digital;
      annotation (
        Documentation(info="<HTML>
 
</HTML>
"),     Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(Rectangle(extent=[-100,100; 100,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=51,
              rgbfillColor={255,255,170}))),
        Diagram,
        Window(
          x=0.2,
          y=0.06,
          width=0.62,
          height=0.69),
        experiment(StopTime=100),
        experimentSetupOutput(
          states=false,
          derivatives=false,
          inputs=false));
      D.Sources.Step Enable       annotation (extent=[-90,8; -50,48]);
      D.Sources.Clock Clock       annotation (extent=[-90,-48; -50,-8]);
      D.Examples.Utilities.Counter Counter(n=4) 
        annotation (extent=[-30,-40; 50,40]);
      D.Converters.LogicToReal Q0 annotation (extent=[66,-40; 86,-20]);
      D.Converters.LogicToReal Q1 annotation (extent=[66,-20; 86,0]);
      D.Converters.LogicToReal Q2 annotation (extent=[66,0; 86,20]);
      D.Converters.LogicToReal Q3 annotation (extent=[66,20; 86,40]);
    equation 
      connect(Enable.y, Counter.enable) annotation (points=[-50,28; -30,28],
          style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
      connect(Clock.y, Counter.count) annotation (points=[-50,-28; -30,-28],
          style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
      connect(Q0.x[1], Counter.q[1]) annotation (points=[71,-30; 58,-30; 58,-24;
            50,-24], style(color=78, rgbcolor={127,0,127}));
      connect(Q1.x[1], Counter.q[2]) annotation (points=[71,-10; 60,-10; 60,-8;
            50,-8], style(color=78, rgbcolor={127,0,127}));
      connect(Q2.x[1], Counter.q[3]) annotation (points=[71,10; 60,10; 60,8; 50,
            8], style(color=78, rgbcolor={127,0,127}));
      connect(Q3.x[1], Counter.q[4]) annotation (points=[71,30; 60,30; 60,24;
            50,24], style(color=78, rgbcolor={127,0,127}));
    end Counter;
    
  package Utilities "Utility components used by package Examples" 
    model MUX4 "4 to 1 Bit Multiplexer" 
        import D = Modelica.Electrical.Digital;
        import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      annotation (
        Documentation(info="<HTML>
</HTML>
"),     Diagram,
        Icon(Rectangle(extent=[-90,100; 90,-100], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillColor=51,
                rgbfillColor={255,255,170})),
            Line(points=[-60,100; -60,-100], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1)),
            Line(points=[60,100; 60,-100], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1)),
          Text(
            extent=[-86,80; -64,60],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="D0"),
          Text(
            extent=[64,12; 86,-8],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="D"),
          Text(
            extent=[-150,-100; 150,-160],
            string="%name",
            style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=51,
              rgbfillColor={255,255,170},
              fillPattern=1)),
          Text(
    extent=[-60,100; 60,40],
              style(
                color=0,
                rgbcolor={0,0,0},
                gradient=2),
              string="MUX"),
          Text(
            extent=[-86,-60; -64,-80],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="A1"),
          Text(
            extent=[-86,54; -64,34],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="D1"),
          Text(
            extent=[-86,28; -64,8],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="D2"),
          Text(
            extent=[-86,2; -64,-18],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="D3"),
          Text(
            extent=[-86,-36; -64,-56],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="A0")));
        
      parameter Modelica.SIunits.Time delayTime=0.001;
      parameter D.Interfaces.Logic q0=L.'0';
        D.Interfaces.DigitalInput d0 annotation (extent=[-110,60; -90,80]);
        D.Interfaces.DigitalInput d1 annotation (extent=[-110,34; -90,54]);
        D.Interfaces.DigitalInput d2 annotation (extent=[-110,8; -90,28]);
        D.Interfaces.DigitalInput d3 annotation (extent=[-110,-18; -90,2]);
        D.Interfaces.DigitalInput a0 annotation (extent=[-110,-54; -90,-34]);
        D.Interfaces.DigitalInput a1 annotation (extent=[-110,-80; -90,-60]);
        D.Interfaces.DigitalOutput d annotation (extent=[90,-10; 110,10]);
        D.Basic.Or Or1(n=4) annotation (extent=[50,20; 70,40]);
        D.Basic.And And1(n=3) annotation (extent=[-20,60; 0,80]);
        D.Basic.And And2(n=3) annotation (extent=[-20,34; 0,54]);
        D.Basic.And And3(n=3) annotation (extent=[-20,8; 0,28]);
        D.Basic.And And4(n=3) annotation (extent=[-20,-18; 0,2]);
        D.Basic.Not Not1 annotation (extent=[-76,-54; -56,-34]);
        D.Basic.Not Not2 annotation (extent=[-76,-80; -56,-60]);
    equation 
        connect(a0, Not1.x) annotation (points=[-100,-44; -72,-44], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
        connect(a1, Not2.x) annotation (points=[-100,-70; -72,-70], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
        connect(d0, And1.x[2]) annotation (points=[-100,70; -58,70; -58,70; -16,
              70], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
        connect(d1, And2.x[2]) annotation (points=[-100,44; -16,44], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
        connect(d2, And3.x[2]) annotation (points=[-100,18; -16,18], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
        connect(d3, And4.x[2]) annotation (points=[-100,-8; -58,-8; -58,-8; -16,
              -8], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
        connect(And4.y, Or1.x[1]) annotation (points=[0,-8; 40,-8; 40,24; 54,24],
            style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
        connect(And3.y, Or1.x[2]) annotation (points=[0,18; 20,18; 20,28; 54,28],
            style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
        connect(And2.y, Or1.x[3]) annotation (points=[0,44; 20,44; 20,32; 54,32],
            style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
        connect(And1.y, Or1.x[4]) annotation (points=[0,70; 40,70; 40,36; 54,36],
            style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
        connect(Or1.y, d) annotation (points=[70,30; 80,30; 80,0; 100,0], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
        connect(Not1.y, And1.x[3]) annotation (points=[-56,-44; -50,-44; -50,
              75.3333; -16,75.3333], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
        connect(Not1.y, And3.x[3]) annotation (points=[-56,-44; -50,-44; -50,
              23.3333; -16,23.3333], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
        connect(Not2.y, And1.x[1]) annotation (points=[-56,-70; -40,-70; -40,
              64.6667; -16,64.6667], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
        connect(Not2.y, And2.x[1]) annotation (points=[-56,-70; -40,-70; -40,
              38.6667; -16,38.6667], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
        connect(a0, And4.x[3]) annotation (points=[-100,-44; -80,-44; -80,
              -2.66667; -16,-2.66667], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
        connect(a0, And2.x[3]) annotation (points=[-100,-44; -80,-44; -80,
              49.3333; -16,49.3333], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
        connect(a1, And4.x[1]) annotation (points=[-100,-70; -80,-70; -80,-90;
              -30,-90; -30,-13.3333; -16,-13.3333], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
        connect(a1, And3.x[1]) annotation (points=[-100,-70; -80,-70; -80,-90;
              -30,-90; -30,12.6667; -16,12.6667], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
    end MUX4;
      
    model RS "Unclocked RS FlipFlop" 
        import D = Modelica.Electrical.Digital;
        import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      annotation (
        Documentation(info="<HTML>
</HTML>
"),     Diagram,
        Icon(Rectangle(extent=[-90,100; 90,-100],   style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillColor=51,
                rgbfillColor={255,255,170})),
          Text(
    extent=[-100,100; 100,40],
              style(
                color=0,
                rgbcolor={0,0,0},
                gradient=2),
              string="RS"),
            Line(points=[-60,100; -60,-100], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1)),
            Line(points=[60,100; 60,-100], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1)),
          Text(
            extent=[-86,-60; -64,-80],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="R"),
          Text(
            extent=[-86,80; -64,60],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="S"),
          Text(
            extent=[64,80; 86,60],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="Q"),
          Text(
            extent=[64,-60; 86,-80],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="QN"),
          Text(
            extent=[-150,-100; 150,-160],
            string="%name",
              style(
                color=3,
                rgbcolor={0,0,255},
                fillColor=51,
                rgbfillColor={255,255,170},
                fillPattern=1))));
      parameter Modelica.SIunits.Time delayTime=0 "delay time";
      parameter D.Interfaces.Logic q0=L.'U' "initial value of output";
      D.Basic.Nor Nor1   annotation (extent=[-40,42; 0,82]);
      D.Basic.Nor Nor2   annotation (extent=[-40,-82; 0,-42]);
      D.Interfaces.DigitalInput s   annotation (extent=[-110,60; -90,80]);
      D.Interfaces.DigitalInput r    annotation (extent=[-110,-80; -90,-60]);
      D.Interfaces.DigitalOutput q   annotation (extent=[90,60; 110,80]);
      D.Interfaces.DigitalOutput qn   annotation (extent=[90,-80; 110,-60]);
      D.Delay.TransportDelay TD1(delayTime=delayTime,y0=q0) 
          annotation (extent=[-60,-64; -40,-44]);
    equation 
      connect(s, Nor1.x[2])   annotation (points=[-100,70; -32,70], style(color=
               78, rgbcolor={127,0,127}));
      connect(r, Nor2.x[1])    annotation (points=[-100,-70; -32,-70],
                        style(color=78, rgbcolor={127,0,127}));
      connect(Nor2.y, Nor1.x[1])   annotation (points=[0,-62; 20,-62; 20,-20;
              -70,20; -70,54; -32,54], style(color=78, rgbcolor={127,0,127}));
      connect(Nor1.y,qn)    annotation (points=[0,62; 50,62; 50,-70; 100,-70],
            style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
      connect(Nor2.y,q)    annotation (points=[0,-62; 70,-62; 70,70; 100,70],
            style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
      connect(TD1.y, Nor2.x[2]) annotation (points=[-40,-54; -32,-54], style(
              color=78, rgbcolor={127,0,127}));
      connect(TD1.x, Nor1.y) annotation (points=[-56,-54; -70,-54; -70,-20; 20,
              20; 20,62; 0,62], style(color=78, rgbcolor={127,0,127}));
    end RS;
      
    model RSFF "Unclocked RS FlipFlop" 
        import D = Modelica.Electrical.Digital;
        import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      annotation (
        Documentation(info="<HTML>
</HTML>
"),     Diagram,
        Icon(Rectangle(extent=[-90,100; 90,-100],   style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=51,
              rgbfillColor={255,255,170})),
          Text(
    extent=[-100,100; 100,40],
              style(
                color=0,
                rgbcolor={0,0,0},
                gradient=2),
              string="RS"),
            Line(points=[-60,100; -60,-100], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1)),
            Line(points=[60,100; 60,-100], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1)),
          Text(
            extent=[-86,-60; -64,-80],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="R"),
          Text(
            extent=[-86,80; -64,60],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="S"),
          Text(
            extent=[64,80; 86,60],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="Q"),
          Text(
            extent=[64,-60; 86,-80],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="QN"),
          Line(points=[-90,20; -60,0; -90,-20],   style(color=0, rgbcolor={0,0,0})),
          Text(
            extent=[-150,-100; 150,-160],
            string="%name",
            style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=51,
              rgbfillColor={255,255,170},
              fillPattern=1))));
        
      parameter Modelica.SIunits.Time delayTime=0.01;
      parameter D.Interfaces.Logic q0=L.'U';
      D.Interfaces.DigitalInput s   annotation (extent=[-110,60; -90,80]);
      D.Interfaces.DigitalInput r     annotation (extent=[-110,-80; -90,-60]);
      D.Interfaces.DigitalOutput q annotation (extent=[90,60; 110,80]);
      D.Interfaces.DigitalOutput qn "not Q" 
        annotation (extent=[90,-80; 110,-60]);
      D.Interfaces.DigitalInput clk       annotation (extent=[-110,-10; -90,10]);
      D.Examples.Utilities.RS RS1(delayTime=delayTime,q0=q0) 
                                        annotation (extent=[-10,-40; 70,40]);
      D.Basic.And And1       annotation (extent=[-70,8; -30,48]);
      D.Basic.And And2       annotation (extent=[-70,-48; -30,-8]);
    equation 
      connect(And2.y, RS1.r) 
                            annotation (points=[-30,-28; -10,-28], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
      connect(And1.y, RS1.s) 
                            annotation (points=[-30,28; -10,28], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
      connect(s, And1.x[2]) annotation (points=[-100,70; -70,70; -70,36; -62,36],
          style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
      connect(clk, And1.x[1]) annotation (points=[-100,0; -70,0; -70,20; -62,20],
          style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
      connect(clk, And2.x[2]) annotation (points=[-100,0; -70,0; -70,-20; -62,-20],
          style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
      connect(r, And2.x[1]) annotation (points=[-100,-70; -70,-70; -70,-36; -62,-36],
          style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
      connect(RS1.q,q) annotation (points=[70,28; 80,28; 80,70; 100,70], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
      connect(RS1.qn,qn) annotation (points=[70,-28; 80,-28; 80,-70; 100,-70],
          style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
    end RSFF;
      
    model DFF "D FlipFlop" 
        import D = Modelica.Electrical.Digital;
        import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      annotation (
        Documentation(info="<HTML>
</HTML>
"),     Diagram,
        Icon(Rectangle(extent=[-90,100; 90,-100],   style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=51,
              rgbfillColor={255,255,170})),
            Line(points=[-60,100; -60,-100], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1)),
            Line(points=[60,100; 60,-100], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1)),
          Text(
            extent=[-86,80; -64,60],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="D"),
          Text(
            extent=[64,80; 86,60],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="Q"),
          Text(
            extent=[64,-60; 86,-80],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="QN"),
          Line(points=[-90,20; -60,0; -90,-20],   style(color=0, rgbcolor={0,0,0})),
          Text(
            extent=[-150,-100; 150,-160],
            string="%name",
            style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=51,
              rgbfillColor={255,255,170},
              fillPattern=1)),
          Text(
    extent=[-100,100; 100,40],
              style(
                color=0,
                rgbcolor={0,0,0},
                gradient=2),
              string="D")));
        
      parameter Modelica.SIunits.Time Tdel=0.01;
      parameter Digital.Interfaces.Logic QInit=L.'U';
      Digital.Interfaces.DigitalInput d 
                                    annotation (extent=[-110,60; -90,80]);
      Digital.Interfaces.DigitalOutput q 
                                   annotation (extent=[90,60; 110,80]);
      Digital.Interfaces.DigitalOutput qn "not Q" 
        annotation (extent=[90,-80; 110,-60]);
      Digital.Interfaces.DigitalInput clk annotation (extent=[-110,-10; -90,10]);
      D.Examples.Utilities.RSFF RSFF1   annotation (extent=[-10,-40; 70,40]);
      Digital.Basic.Not Not1 
                            annotation (extent=[-70,-48; -30,-8]);
    equation 
      connect(RSFF1.q,q) 
                       annotation (points=[70,28; 80,28; 80,70; 100,70], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
      connect(RSFF1.qn,qn) 
                         annotation (points=[70,-28; 80,-28; 80,-70; 100,-70],
          style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=51,
          rgbfillColor={255,255,170},
          fillPattern=1));
      connect(Not1.y, RSFF1.r) 
                             annotation (points=[-30,-28; -10,-28], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
      connect(clk, RSFF1.clk)  annotation (points=[-100,0; -10,0], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
      connect(d, Not1.x)  annotation (points=[-100,70; -80,70; -80,-28; -62,-28],
            style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
      connect(d, RSFF1.s)  annotation (points=[-100,70; -80,70; -80,28; -10,28],
            style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=51,
            rgbfillColor={255,255,170},
            fillPattern=1));
    end DFF;
      
    model JKFF "JK FlipFlop" 
        import D = Modelica.Electrical.Digital;
        import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      annotation (
        Documentation(info="<HTML>
</HTML>
"),     Diagram,
        Icon(Rectangle(extent=[-90,100; 90,-100], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillColor=51,
                rgbfillColor={255,255,170})),
            Line(points=[-60,100; -60,-100], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1)),
            Line(points=[60,100; 60,-100], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1)),
          Text(
            extent=[-86,80; -64,60],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="J"),
          Text(
            extent=[64,80; 86,60],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="Q"),
          Text(
            extent=[64,-60; 86,-80],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="QN"),
          Line(points=[-90,20; -60,0; -90,-20],   style(color=0, rgbcolor={0,0,0})),
          Text(
            extent=[-150,-100; 150,-160],
            string="%name",
            style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=51,
              rgbfillColor={255,255,170},
              fillPattern=1)),
          Text(
    extent=[-100,100; 100,40],
              style(
                color=0,
                rgbcolor={0,0,0},
                gradient=2),
              string="JK"),
          Text(
            extent=[-86,-60; -64,-80],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="K")));
        
      parameter Modelica.SIunits.Time delayTime=0.001;
      parameter D.Interfaces.Logic q0=L.'0';
      D.Interfaces.DigitalInput j   annotation (extent=[-110,60; -90,80]);
      D.Interfaces.DigitalOutput q annotation (extent=[90,60; 110,80]);
      D.Interfaces.DigitalOutput qn "not Q" 
        annotation (extent=[90,-80; 110,-60]);
      D.Interfaces.DigitalInput clk       annotation (extent=[-110,-10; -90,10]);
      D.Interfaces.DigitalInput k   annotation (extent=[-110,-80; -90,-60]);
        D.Examples.Utilities.RS RS1(delayTime=delayTime,q0=q0) 
                                     annotation (extent=[30,-24; 70,16]);
        D.Examples.Utilities.RS RS2(delayTime=delayTime,q0=q0) 
                                     annotation (extent=[-44,-20; -4,20]);
        D.Basic.And And1(n=3) annotation (extent=[-70,4; -50,24]);
        D.Basic.And And2(n=3) annotation (extent=[-70,-24; -50,-4]);
        D.Basic.And And3 annotation (extent=[4,0; 24,20]);
        D.Basic.And And4 annotation (extent=[4,-28; 24,-8]);
        D.Basic.Not Not1 annotation (extent=[-34,-66; -14,-46]);
    equation 
        connect(And2.y, RS2.r) annotation (points=[-50,-14; -44,-14], style(color=
                78, rgbcolor={127,0,127}));
        connect(And1.y, RS2.s) annotation (points=[-50,14; -44,14], style(color=
               78, rgbcolor={127,0,127}));
        connect(clk, And2.x[3]) annotation (points=[-100,0; -74,0; -74,-8.66667;
              -66,-8.66667], style(color=78, rgbcolor={127,0,127}));
        connect(clk, And1.x[1]) annotation (points=[-100,0; -74,0; -74,8.66667;
              -66,8.66667], style(color=78, rgbcolor={127,0,127}));
        connect(k, And2.x[2]) annotation (points=[-100,-70; -74,-70; -74,-14;
              -66,-14], style(color=78, rgbcolor={127,0,127}));
        connect(And4.y, RS1.r) annotation (points=[24,-18; 30,-18], style(color=
               78, rgbcolor={127,0,127}));
        connect(And3.y, RS1.s) annotation (points=[24,10; 30,10], style(color=
                78, rgbcolor={127,0,127}));
        connect(RS2.qn, And4.x[2]) annotation (points=[-4,-14; 8,-14],
            style(color=78, rgbcolor={127,0,127}));
        connect(RS2.q, And3.x[2]) annotation (points=[-4,14; 8,14], style(color=
               78, rgbcolor={127,0,127}));
        connect(clk, Not1.x) annotation (points=[-100,0; -80,0; -80,-56; -30,
              -56], style(color=78, rgbcolor={127,0,127}));
        connect(Not1.y, And3.x[1]) annotation (points=[-14,-56; 2,-56; 2,6; 8,6],
            style(color=78, rgbcolor={127,0,127}));
        connect(Not1.y, And4.x[1]) annotation (points=[-14,-56; 2,-56; 2,-22; 8,
              -22], style(color=78, rgbcolor={127,0,127}));
        connect(j, And1.x[2]) annotation (points=[-100,70; -74,70; -74,14; -66,
              14], style(color=78, rgbcolor={127,0,127}));
        connect(RS1.q, And2.x[1]) annotation (points=[70,10; 80,10; 80,-36; -70,
              -36; -70,-19.3333; -66,-19.3333], style(color=78, rgbcolor={127,0,
                127}));
        connect(RS1.qn, And1.x[3]) annotation (points=[70,-18; 86,-18; 86,36;
              -70,36; -70,19.3333; -66,19.3333],     style(color=78, rgbcolor={
                127,0,127}));
      connect(RS1.qn, q) annotation (points=[70,-18; 86,-18; 86,70; 100,70],
            style(color=78, rgbcolor={127,0,127}));
      connect(RS1.q, qn) annotation (points=[70,10; 80,10; 80,-70; 100,-70],
            style(color=78, rgbcolor={127,0,127}));
    end JKFF;
      
              model HalfAdder 
                parameter Real delayTime=0;
                Digital.Interfaces.DigitalInput b 
                  annotation (
                      extent=[-110,-80; -90,-60],  rotation=0);
                Digital.Interfaces.DigitalOutput s 
                                     annotation (extent=[90,60; 110,80]);
                annotation (
                    Diagram, Icon(
                    Rectangle(
                      extent=[-90,100; 90,-100],   style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillColor=51,
                rgbfillColor={255,255,170})),
                    Text(
              extent=[-90,80; -60,60],
              style(color=0),
              string="a"),
                    Text(
              extent=[-90,-60; -60,-80],
              style(color=0),
              string="b"),
                    Text(
              extent=[60,80; 90,60],
              style(color=0),
              string="s"),
                    Text(
              extent=[60,-60; 90,-80],
              style(color=0),
              string="c"),
                    Text(
                      extent=[-150,-100; 150,-160],
                      style(color=3, rgbcolor={0,0,255}),
                      string="%name"),
                    Text(
              extent=[-100,100; 100,0],
              style(color=0, gradient=2),
              string="+"), 
            Line(points=[-60,100; -60,-100], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1)), 
            Line(points=[60,100; 60,-100], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1))), 
          Documentation(info="<html>
  
</html>"));
                Digital.Interfaces.DigitalInput a 
                  annotation (
                      extent=[-110,60; -90,80],  rotation=0);
                Digital.Interfaces.DigitalOutput c 
                                     annotation (extent=[90,-80; 110,-60]);
                Gates.AndGate AND(tLH=delayTime, tHL=delayTime) 
                  annotation (
                      extent=[-20,-82; 20,-42]);
                Gates.XorGate XOR(tLH=delayTime, tHL=delayTime) 
                  annotation (
                      extent=[-20,42; 20,82]);
        
              equation 
                connect(AND.y, c) 
                               annotation (points=[20,-62; 60,-62; 60,-70; 100,
              -70],                                                 style(
                    color=
                  78,
                    rgbcolor=
                     {127,0,127},
                    fillColor=
                      79,
                    rgbfillColor=
                         {170,85,255},
                    fillPattern=
                        1));
                connect(XOR.y, s) 
                               annotation (points=[20,62; 60,62; 60,70; 100,70],
                                                                  style(
                    color=
                  78,
                    rgbcolor=
                     {127,0,127},
                    fillColor=
                      79,
                    rgbfillColor=
                         {170,85,255},
                    fillPattern=
                        1));
                connect(b, AND.x[1]) 
                                  annotation (points=[-100,-70; -12,-70],
                                 style(
                    color=
                  78,
                    rgbcolor=
                     {127,0,127},
                    fillColor=
                      79,
                    rgbfillColor=
                         {170,85,255},
                    fillPattern=
                        1));
                connect(b, XOR.x[1]) 
                                  annotation (points=[-100,-70; -30,-70; -30,54;
              -12,54],         style(
                    color=
                  78,
                    rgbcolor=
                     {127,0,127},
                    fillColor=
                      79,
                    rgbfillColor=
                         {170,85,255},
                    fillPattern=
                        1));
                connect(a, XOR.x[2]) 
                                  annotation (points=[-100,70; -12,70],
                         style(
                    color=
                  78,
                    rgbcolor=
                     {127,0,127},
                    fillColor=
                      79,
                    rgbfillColor=
                         {170,85,255},
                    fillPattern=
                        1));
                connect(a, AND.x[2]) 
                                  annotation (points=[-100,70; -40,70; -40,-54;
              -12,-54],   style(
                    color=
                  78,
                    rgbcolor=
                     {127,0,127},
                    fillColor=
                      79,
                    rgbfillColor=
                         {170,85,255},
                    fillPattern=
                        1));
              end HalfAdder;
      
    model FullAdder "adding circuit for binary numbers with input carry bit" 
        
      annotation (
        Documentation(info="<HTML>
<P>
 <pre>
  <b>a     b     c in     c out     s</b>

         1     1     1     0
         0     0     0     0
         1     0     0     1
         0     1     0     1
 </pre>


</P>
</HTML>
"),     Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(Rectangle(extent=[-90,100; 90,-100],   style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillColor=51,
                rgbfillColor={255,255,170})),
          Text(
            extent=[-150,-96; 150,-151],
            style(color=3, rgbcolor={0,0,255}),
            string="%name"),
          Text(
            extent=[-86,80; -64,60],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
            string="a"),
          Text(
            extent=[-86,40; -64,20],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
            string="b"),
          Text(
            extent=[-86,-60; -64,-80],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
            string="c_in"),
          Text(
            extent=[60,-60; 90,-80],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
            string="c_out"),
          Text(
            extent=[64,80; 86,60],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
            string="s"),
          Text(
    extent=[-100,100; 100,0],
    string="+",
              style(
                color=0,
                rgbcolor={0,0,0},
                gradient=2)),
            Line(points=[-60,100; -60,-100], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1)),
            Line(points=[60,100; 60,-100], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1))),
        Diagram,
        Window(
          x=0.2,
          y=0.06,
          width=0.62,
          height=0.69));
        
      HalfAdder Adder2(delayTime=0.001) 
                                      annotation (extent=[10,36; 50,76]);
      HalfAdder Adder1(delayTime=0.001) 
                                       annotation (extent=[-60,36; -20,76]);
      Digital.Interfaces.DigitalInput a 
        annotation (extent=[-110,60; -90,80],  rotation=180);
      Digital.Interfaces.DigitalInput b 
        annotation (extent=[-110,20; -90,40], rotation=180);
      Digital.Interfaces.DigitalInput c_in 
        annotation (extent=[-110,-80; -90,-60], rotation=180);
      Digital.Interfaces.DigitalOutput s 
        annotation (extent=[112,60; 90,80],      rotation=180);
      Digital.Interfaces.DigitalOutput c_out 
        annotation (extent=[110,-80; 90,-60],    rotation=180);
      Basic.Or OR  annotation (extent=[10,-90; 50,-50]);
    equation 
        
      connect(c_out, OR.y)   annotation (points=[100,-70; 50,-70],
                       style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1));
      connect(Adder2.c, OR.x[2]) 
                               annotation (points=[50,42; 70,42; 70,-40; 10,-40;
              10,-62; 18,-62],style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1));
      connect(Adder2.s, s) 
        annotation (points=[50,70; 101,70], style(color=78, rgbcolor={127,0,127}));
        connect(Adder1.a, a) annotation (points=[-60,70; -100,70], style(color=78,
              rgbcolor={127,0,127}));
        connect(b, Adder1.b) annotation (points=[-100,30; -70,30; -70,42; -60,42],
            style(color=78, rgbcolor={127,0,127}));
        connect(Adder1.s, Adder2.a) annotation (points=[-20,70; 10,70], style(
              color=78, rgbcolor={127,0,127}));
        connect(Adder1.c, OR.x[1]) annotation (points=[-20,42; -10,42; -10,-78;
              18,-78], style(color=78, rgbcolor={127,0,127}));
        connect(c_in, Adder2.b) annotation (points=[-100,-70; 0,-70; 0,42; 10,42],
            style(color=78, rgbcolor={127,0,127}));
    end FullAdder;
      
    model Adder "Generic N Bit Adder" 
        import Modelica.Electrical.Digital;
      annotation (
        Documentation(info="<HTML>
  
</HTML>
"),     Coordsys(
          extent=[-100,-100; 100,100],
          grid=[2, 2],
          component=[20, 20]),
        Icon(Rectangle(extent=[-90,100; 90,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=51,
              rgbfillColor={255,255,170})),
          Text(
            extent=[68,80; 88,60],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
            string="S"),
          Text(
            extent=[-150,-100; 150,-160],
            string="%name",
            style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=51,
              rgbfillColor={255,255,170},
              fillPattern=1)),
          Text(
    extent=[-40,60; 40,20],
              style(
                color=0,
                rgbcolor={0,0,0},
                gradient=2),
            string="Adder"),
          Text(
            extent=[48,-60; 88,-80],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
            string="Cout"),
          Text(
            extent=[-90,-60; -50,-80],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
            string="Cin"),
          Text(
            extent=[-88,80; -68,60],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
            string="A"),
          Text(
            extent=[-88,40; -68,20],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
            string="B")),
        Diagram,
        Window(
          x=0.2,
          y=0.06,
          width=0.62,
          height=0.69));
      parameter Integer n=2;
      Digital.Examples.Utilities.FullAdder Adder[n] 
                                   annotation (extent=[-20,-20; 20,20]);
      Digital.Interfaces.DigitalInput a[n] annotation (extent=[-110,60; -90,80]);
      Digital.Interfaces.DigitalInput b[n] annotation (extent=[-110,20; -90,40]);
      Digital.Interfaces.DigitalInput c_in annotation (extent=[-110,-80; -90,-60]);
      Digital.Interfaces.DigitalOutput s[n] annotation (extent=[90,60; 110,80]);
      Digital.Interfaces.DigitalOutput c_out annotation (extent=[90,-80; 110,-60]);
    equation 
      connect(c_in,Adder[1].c_in);
      for i in 1:n loop
        connect(a[i],Adder[i].a);
        connect(b[i],Adder[i].b);
        connect(Adder[i].a,s[i]);
        if i>1 then
          connect(Adder[i-1].c_out,Adder[i].c_in);
        end if;
      end for;
      connect(Adder[n].c_out,c_out);
    end Adder;
      
    model Counter3 "3 Bit Counter" 
        import D = Modelica.Electrical.Digital;
        import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
       annotation (
         Documentation(info="<HTML>
  
</HTML>
"),      Diagram,
         Icon(Rectangle(extent=[-90,100; 90,-100], style(
                 color=0,
                 rgbcolor={0,0,0},
                 thickness=2,
                 fillColor=51,
                 rgbfillColor={255,255,170})),
           Text(
             extent=[-80,80; -40,60],
             style(
               color=0,
               rgbcolor={0,0,0},
               thickness=2,
               fillColor=7,
               rgbfillColor={255,255,255},
               fillPattern=1),
               string="ENABLE"),
           Text(
             extent=[64,80; 86,60],
             style(
               color=0,
               rgbcolor={0,0,0},
               thickness=2,
               fillColor=7,
               rgbfillColor={255,255,255},
               fillPattern=1),
              string="Q2"),
           Text(
             extent=[64,-60; 86,-80],
             style(
               color=0,
               rgbcolor={0,0,0},
               thickness=2,
               fillColor=7,
               rgbfillColor={255,255,255},
               fillPattern=1),
              string="Q0"),
           Text(
             extent=[-150,-100; 150,-160],
             string="%name",
             style(
               color=3,
               rgbcolor={0,0,255},
               fillColor=51,
               rgbfillColor={255,255,170},
               fillPattern=1)),
           Text(
     extent=[-60,40; 60,0],
               style(
                 color=0,
                 rgbcolor={0,0,0},
                 gradient=2),
              string="Counter3"),
           Text(
             extent=[-80,-60; -40,-80],
             style(
               color=0,
               rgbcolor={0,0,0},
               thickness=2,
               fillColor=7,
               rgbfillColor={255,255,255},
               fillPattern=1),
               string="COUNT"),
           Text(
             extent=[62,8; 84,-12],
             style(
               color=0,
               rgbcolor={0,0,0},
               thickness=2,
               fillColor=7,
               rgbfillColor={255,255,255},
               fillPattern=1),
              string="Q1")));
      D.Interfaces.DigitalInput enable 
                                     annotation (extent=[-110,60; -90,80]);
      D.Interfaces.DigitalOutput q2 annotation (extent=[90,60; 110,80]);
      D.Interfaces.DigitalInput count 
                                     annotation (extent=[-110,-80; -90,-60]);
      D.Examples.Utilities.JKFF FF1 
           annotation (extent=[-74,-20; -34,20]);
      D.Examples.Utilities.JKFF FF2 
           annotation (extent=[-20,-20; 20,20]);
      D.Examples.Utilities.JKFF FF3 
           annotation (extent=[34,-20; 74,20]);
      D.Interfaces.DigitalOutput q1 annotation (extent=[90,-10; 110,10]);
      D.Interfaces.DigitalOutput q0 annotation (extent=[90,-80; 110,-60]);
    equation 
      connect(enable, FF1.j)       annotation (points=[-100,70; -80,70; -80,14;
               -74,14],  style(
             color=78,
             rgbcolor={127,0,127},
             fillPattern=1));
      connect(enable, FF1.k)      annotation (points=[-100,70; -80,70; -80,-14;
               -74,-14],style(
             color=78,
             rgbcolor={127,0,127},
             fillPattern=1));
      connect(count, FF1.clk)      annotation (points=[-100,-70; -86,-70; -86,0;
               -74,0], style(
             color=78,
             rgbcolor={127,0,127},
             fillPattern=1));
      connect(FF1.q, FF2.clk)        annotation (points=[-34,14; -30,14; -30,0;
               -20,0], style(
             color=78,
             rgbcolor={127,0,127},
             fillPattern=1));
      connect(FF2.q, FF3.clk)        annotation (points=[20,14; 24,14; 24,0; 34,
               0], style(
             color=78,
             rgbcolor={127,0,127},
             fillPattern=1));
      connect(FF2.j, enable)       annotation (points=[-20,14; -26,14; -26,70;
               -100,70], style(
             color=78,
             rgbcolor={127,0,127},
             fillPattern=1));
      connect(FF2.k, FF2.j)         annotation (points=[-20,-14; -26,-14; -26,14;
               -20,14],  style(
             color=78,
             rgbcolor={127,0,127},
             fillPattern=1));
      connect(FF3.k, FF3.j)         annotation (points=[34,-14; 28,-14; 28,14;
               34,14],
                     style(
             color=78,
             rgbcolor={127,0,127},
             fillPattern=1));
      connect(FF3.j, enable)       annotation (points=[34,14; 28,14; 28,70; -100,
               70],      style(
             color=78,
             rgbcolor={127,0,127},
             fillPattern=1));
      connect(FF3.q, q2)     annotation (points=[74,14; 80,14; 80,70; 100,70],
             style(
             color=78,
             rgbcolor={127,0,127},
             fillPattern=1));
      connect(FF1.q, q0) annotation (points=[-34,14; -30,14; -30,-70; 100,-70],
            style(color=78, rgbcolor={127,0,127}));
      connect(FF2.q, q1) annotation (points=[20,14; 24,14; 24,-50; 86,-50; 86,0;
              100,0], style(color=78, rgbcolor={127,0,127}));
    end Counter3;
      
    model Counter "Generic N Bit Counter" 
        import D = Modelica.Electrical.Digital;
        import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      annotation (
        Documentation(info="<HTML>
  
</HTML>
"),     Diagram(Rectangle(extent=[90,80; 110,-80], style(
                color=78,
                rgbcolor={127,0,127},
                fillColor=78,
                rgbfillColor={127,0,127},
                fillPattern=1))),
        Icon(
            Rectangle(extent=[90,80; 110,-80], style(
                color=78,
                rgbcolor={127,0,127},
                fillColor=78,
                rgbfillColor={127,0,127},
                fillPattern=1)),
             Rectangle(extent=[-90,100; 90,-100], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillColor=51,
                rgbfillColor={255,255,170})),
          Text(
            extent=[-80,80; -40,60],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="ENABLE"),
          Text(
            extent=[66,8; 88,-12],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="Q"),
          Text(
            extent=[-150,-100; 150,-160],
            string="%name",
            style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=51,
              rgbfillColor={255,255,170},
              fillPattern=1)),
          Text(
    extent=[-40,40; 40,0],
              style(
                color=0,
                rgbcolor={0,0,0},
                gradient=2),
              string="Counter"),
          Text(
            extent=[-80,-60; -40,-80],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
              string="COUNT")));
      parameter Integer n=3;
      parameter Modelica.SIunits.Time delayTime=0.001;
      parameter D.Interfaces.Logic q0=L.'0';
      D.Interfaces.DigitalInput enable 
                                    annotation (extent=[-110,60; -90,80]);
      D.Interfaces.DigitalInput count 
                                    annotation (extent=[-110,-80; -90,-60]);
      D.Examples.Utilities.JKFF FF[n](each delayTime=delayTime,each q0=q0);
      D.Interfaces.DigitalOutput q[n] annotation (extent=[90,-80; 110,80]);
    equation 
      connect(enable,FF[1].j);
      connect(enable,FF[1].k);
      connect(count,FF[1].clk);
      connect(FF[1].q,q[1]);
      for i in 2:n loop
        connect(enable,FF[i].j);
        connect(enable,FF[i].k);
        connect(FF[i-1].q,FF[i].clk);
        connect(FF[i].q,q[i]);
      end for;
    end Counter;
      annotation (Documentation(info="<html>
<p>
This package contains utility components used by package Examples.
</p>

</html>"));
  end Utilities;
    annotation (Icon(
        Rectangle(extent=[-100,-100; 80,50],   style(fillColor=30,
              fillPattern=
                1)),
        Polygon(points=[-100,50; -80,70; 100,70; 80,50; -100,50],      style(
              fillColor=30, fillPattern=1)),
        Polygon(points=[100,70; 100,-80; 80,-100; 80,50; 100,70],      style(
              fillColor=30, fillPattern=1)),
        Text(
          extent=[-85,35; 65,-85],
          string="Library",
          style(color=3)),
        Text(
          extent=[-120,122; 120,73],
          string="%name",
          style(color=1))), Documentation(info="<html>
<p>
This package contains examples that demonstrate the usage of the
components of the Electrical.Digital library.
</p>
</html>"));
  end Examples;
  
  package Interfaces "Connectors for Digital electrical components" 
    
    type Logic = Integer(min=1,max=9) 
      "Signal type in package Digital according to the IEEE 1164 STD_ULOGIC type"
      annotation (Documentation(info="<html>
 
<p>
A variable of type Logic is an Integer in the range 1-9.
The Integer values have the following meaning:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Logic value</b></td>
      <td valign=\"top\"><b>Integer code</b></td>
      <td valign=\"top\"><b>Meaning</b></td>
  </tr>
                         
  <tr><td valign=\"top\">'U'</td> <td valign=\"top\">1</td> <td valign=\"top\">Uninitialized</td></tr>
  <tr><td valign=\"top\">'X'</td> <td valign=\"top\">2</td> <td valign=\"top\">Forcing Unknown</td></tr>
  <tr><td valign=\"top\">'0'</td> <td valign=\"top\">3</td> <td valign=\"top\">Forcing 0</td></tr>
  <tr><td valign=\"top\">'1'</td> <td valign=\"top\">4</td> <td valign=\"top\">Forcing 1</td></tr>
  <tr><td valign=\"top\">'Z'</td> <td valign=\"top\">5</td> <td valign=\"top\">High Impedance</td></tr>
  <tr><td valign=\"top\">'W'</td> <td valign=\"top\">6</td> <td valign=\"top\">Weak Unknown</td></tr>
  <tr><td valign=\"top\">'L'</td> <td valign=\"top\">7</td> <td valign=\"top\">Weak 0</td></tr>
  <tr><td valign=\"top\">'H'</td> <td valign=\"top\">8</td> <td valign=\"top\">Weak 1</td></tr>
  <tr><td valign=\"top\">'-'</td> <td valign=\"top\">9</td> <td valign=\"top\">Don't care</td></tr>
</table>

</html>"));
    
    record LogicValue "Logic values and their coding" 
      extends Modelica.Icons.Enumeration;
      
      constant Integer min=1;
      constant Integer max=9;
      constant Integer 'U'=1 "U  Uninitialized";
      constant Integer 'X'=2 "X  Forcing Unknown";
      constant Integer '0'=3 "0  Forcing 0";
      constant Integer '1'=4 "1  Forcing 1";
      constant Integer 'Z'=5 "Z  High Impedance";
      constant Integer 'W'=6 "W  Weak    Unknown";
      constant Integer 'L'=7 "L  Weak    0";
      constant Integer 'H'=8 "H  Weak    1";
      constant Integer '-'=9 "-  Don't care";
      annotation (Documentation(info="<html>
<p><b>Code Table:</b></p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Logic value</b></td>
      <td valign=\"top\"><b>Integer code</b></td>
      <td valign=\"top\"><b>Meaning</b></td>
  </tr>
                         
  <tr><td valign=\"top\">'U'</td> <td valign=\"top\">1</td> <td valign=\"top\">Uninitialized</td></tr>
  <tr><td valign=\"top\">'X'</td> <td valign=\"top\">2</td> <td valign=\"top\">Forcing Unknown</td></tr>
  <tr><td valign=\"top\">'0'</td> <td valign=\"top\">3</td> <td valign=\"top\">Forcing 0</td></tr>
  <tr><td valign=\"top\">'1'</td> <td valign=\"top\">4</td> <td valign=\"top\">Forcing 1</td></tr>
  <tr><td valign=\"top\">'Z'</td> <td valign=\"top\">5</td> <td valign=\"top\">High Impedance</td></tr>
  <tr><td valign=\"top\">'W'</td> <td valign=\"top\">6</td> <td valign=\"top\">Weak Unknown</td></tr>
  <tr><td valign=\"top\">'L'</td> <td valign=\"top\">7</td> <td valign=\"top\">Weak 0</td></tr>
  <tr><td valign=\"top\">'H'</td> <td valign=\"top\">8</td> <td valign=\"top\">Weak 1</td></tr>
  <tr><td valign=\"top\">'-'</td> <td valign=\"top\">9</td> <td valign=\"top\">Don't care</td></tr>
</table>


</html>"));
    end LogicValue;
    
    connector DigitalSignal = Logic "Digital port (both input/output possible)"
      annotation (Icon, Diagram,
      Documentation(info="<html>

</html>"));
    
    connector DigitalInput = input DigitalSignal 
      "input DigitalSignal as connector" 
      annotation (defaultComponentName="x",
        Icon(Rectangle(extent=[-100,-100; 100,100], style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=78,
            rgbfillColor={127,0,127}))),
        Diagram(                      Text(
          extent=[-150,-100; 150,-160],
          string="%name",
          style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=78,
            rgbfillColor={127,0,127})),
             Rectangle(extent=[-100,-100; 100,100],
                                               style(
            color=78,
            rgbcolor={127,0,127},
            fillColor=78,
            rgbfillColor={127,0,127}))),
      Documentation(info="<html>
  
</html>"));
    
    connector DigitalOutput = output DigitalSignal 
      "output DigitalSignal as connector" 
      annotation (defaultComponentName="y", Icon(Polygon(points=[-100,100; 100,0; -100,-100; -100,100], style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=7,
          rgbfillColor={255,255,255}))),
                                       Diagram(
              Polygon(points=[-100,100; 100,0; -100,-100; -100,100],
                                                                style(
          color=78,
          rgbcolor={127,0,127},
          fillColor=7,
          rgbfillColor={255,255,255})), Text(
          extent=[-150,-100; 150,-160],
          string="%name",
        style(color=78, rgbcolor={127,0,127}))));
    
    partial block SISO "Single input, single output" 
      import D = Modelica.Electrical.Digital;
      D.Interfaces.DigitalInput x "Connector of Digital input signal" 
                   annotation (extent=[-70,-10; -50,10]);
      D.Interfaces.DigitalOutput y "Connector of Digital output signal" 
                    annotation (extent=[90,-10; 110,10]);
      annotation (Diagram,                                                    Icon(
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255})),
          Line(points=[50,0; 92,0], style(color=78, rgbcolor={127,0,127}))),
        Documentation(info="<html>
 
</html>"));
    end SISO;
    
    partial block MISO "Multiple input - single output" 
      import D = Modelica.Electrical.Digital;
      
      parameter Integer n(final min=2) = 2 "Number of inputs";
      D.Interfaces.DigitalInput x[n] "Connector of Digital input signal vector"
                                     annotation (extent=[-70,-80; -50,80]);
      D.Interfaces.DigitalOutput y "Connector of Digital output signal" 
                    annotation (extent=[90,-10; 110,10]);
      annotation (Icon(
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255})),
          Line(points=[50,0; 90,0], style(color=78, rgbcolor={127,0,127}))),
          Diagram,
        Documentation(info="<html>
 
</html>"));
    end MISO;
    
    annotation (Icon(
        Rectangle(extent=[-100,-100; 80,50],   style(fillColor=30,
              fillPattern=
                1)),
        Polygon(points=[-100,50; -80,70; 100,70; 80,50; -100,50],      style(
              fillColor=30, fillPattern=1)),
        Polygon(points=[100,70; 100,-80; 80,-100; 80,50; 100,70],      style(
              fillColor=30, fillPattern=1)),
        Text(
          extent=[-85,35; 65,-85],
          string="Library",
          style(color=3)),
        Text(
          extent=[-120,122; 120,73],
          string="%name",
          style(color=1))), Documentation(info="<html>
<p>
This package contains interface definitions
(connectors) digital electrical components.
</p>
</html>"));
  end Interfaces;
  
  package Tables "Truth tables for all components of package Digital" 
    
    import D = Modelica.Electrical.Digital;
    import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
    
    constant D.Interfaces.Logic AndTable[L.max, L.max]=[
        L.'U', L.'U', L.'0', L.'U', L.'U', L.'U', L.'0', L.'U', L.'U';
        L.'U', L.'X', L.'0', L.'X', L.'X', L.'X', L.'0', L.'X', L.'X';
        L.'0', L.'0', L.'0', L.'0', L.'0', L.'0', L.'0', L.'0', L.'0';
        L.'U', L.'X', L.'0', L.'1', L.'X', L.'X', L.'0', L.'1', L.'X';
        L.'U', L.'X', L.'0', L.'X', L.'X', L.'X', L.'0', L.'X', L.'X';
        L.'U', L.'X', L.'0', L.'X', L.'X', L.'X', L.'0', L.'X', L.'X';
        L.'0', L.'0', L.'0', L.'0', L.'0', L.'0', L.'0', L.'0', L.'0';
        L.'U', L.'X', L.'0', L.'1', L.'X', L.'X', L.'0', L.'1', L.'X';
        L.'U', L.'X', L.'0', L.'X', L.'X', L.'X', L.'0', L.'X', L.'X'] 
      "9-value logic for 'and'";
    
    constant D.Interfaces.Logic OrTable[L.max, L.max]=[
        L.'U', L.'U', L.'U', L.'1', L.'U', L.'U', L.'U', L.'1', L.'U';
        L.'U', L.'X', L.'X', L.'1', L.'X', L.'X', L.'X', L.'1', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'X', L.'X', L.'0', L.'1', L.'X';
        L.'1', L.'1', L.'1', L.'1', L.'1', L.'1', L.'1', L.'1', L.'1';
        L.'U', L.'X', L.'X', L.'1', L.'X', L.'X', L.'X', L.'1', L.'X';
        L.'U', L.'X', L.'X', L.'1', L.'X', L.'X', L.'X', L.'1', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'X', L.'X', L.'0', L.'1', L.'X';
        L.'1', L.'1', L.'1', L.'1', L.'1', L.'1', L.'1', L.'1', L.'1';
        L.'U', L.'X', L.'X', L.'1', L.'X', L.'X', L.'X', L.'1', L.'X'] 
      "9-value logic for 'or'";
    
    constant D.Interfaces.Logic NotTable[L.max]={
        L.'U',L.'X',L.'1',L.'0',L.'X',L.'X',L.'1',L.'0',L.'X'} 
      "9-value logic for 'not'";
    
    constant D.Interfaces.Logic XorTable[L.max, L.max]=[
        L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'X', L.'X', L.'0', L.'1', L.'X';
        L.'U', L.'X', L.'1', L.'0', L.'X', L.'X', L.'1', L.'0', L.'X';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'X', L.'X', L.'0', L.'1', L.'X';
        L.'U', L.'X', L.'1', L.'0', L.'X', L.'X', L.'1', L.'0', L.'X';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X'] 
      "9-value logic for 'xor'";
    
    constant D.Interfaces.Logic X01Table[L.max]={
        L.'X',L.'X',L.'0',L.'1',L.'X',L.'X',L.'0',L.'1',L.'X'};
    
    constant D.Interfaces.Logic X01ZTable[L.max]={
        L.'X',L.'X',L.'0',L.'1',L.'Z',L.'X',L.'0',L.'1',L.'Z'};
    
    constant D.Interfaces.Logic UX01Table[L.max]={
        L.'U',L.'X',L.'0',L.'1',L.'X',L.'X',L.'0',L.'1',L.'X'};
    
    constant Integer DelayTable[9, 9]=[
        0, 0, -1, 1, 0, 0, -1, 1, 0;
        0, 0, -1, 1, 0, 0, -1, 1, 0;
        1, 1, 0, 1, 1, 1, 0, 1, 1;
        -1, -1, -1, 0, -1, -1, -1, 0, -1;
        0, 0, -1, 1, 0, 0, -1, 1, 0;
        0, 0, -1, 1, 0, 0, -1, 1, 0;
        1, 1, 0, 1, 1, 1, 0, 1, 1;
        -1, -1, -1, 0, -1, -1, -1, 0, -1;
        0, 0, -1, 1, 0, 0, -1, 1, 0];
    annotation (Icon(
        Rectangle(extent=[-100,-100; 80,50],   style(fillColor=30,
              fillPattern=
                1)),
        Polygon(points=[-100,50; -80,70; 100,70; 80,50; -100,50],      style(
              fillColor=30, fillPattern=1)),
        Polygon(points=[100,70; 100,-80; 80,-100; 80,50; 100,70],      style(
              fillColor=30, fillPattern=1)),
        Text(
          extent=[-85,35; 65,-85],
          string="Library",
          style(color=3)),
        Text(
          extent=[-120,122; 120,73],
          string="%name",
          style(color=1))), Documentation(info="<html>
 
</html>"));
  end Tables;
  
  package Delay "Transport and inertial delay blocks" 
    
    partial block DelayParams "Definition of delay parameters" 
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      parameter Modelica.SIunits.Time tLH=0 "rise inertial delay";
      parameter Modelica.SIunits.Time tHL=0 "fall inertial delay";
      parameter Digital.Interfaces.Logic y0=L.'U' "initial value of output";
      annotation (Documentation(info="<html>
   
</html>"));
    end DelayParams;
    
    model TransportDelay "Transport delay with initial parameter" 
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      extends D.Interfaces.SISO(x(start=L.'U',fixed=true));
      parameter Modelica.SIunits.Time delayTime=0 "delay time";
      parameter D.Interfaces.Logic y0=L.'U' "initial value of output";
    protected 
      D.Interfaces.Logic x_delayed;
    equation 
      x_delayed = integer(delay(x, delayTime));
      y = if delayTime > 0 then 
              (if time >= delayTime then x_delayed else y0) else 
                pre(x);
      annotation (Documentation(info="<HTML>
<P>
Provide the input as output exactly delayed by <i>Tdel</i>.
If time less than <i>Tdel</i> the initial value <i>initout</i> holds.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>August 11, 2003</i>
       by Christoph Clauss<br>
       initially modelled.</li>
</ul>
</HTML>"),
    Icon( Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255})),
          Polygon(points=[-6,60; -16,40; 4,40; -6,60], style(color=0, rgbcolor=
                  {0,0,0})),
          Line(points=[0,60; 20,60], style(
              color=0,
              rgbcolor={0,0,0},
              fillPattern=1)),
          Line(points=[10,60; 10,40], style(
              color=0,
              rgbcolor={0,0,0},
              fillPattern=1)),
          Text(
            extent=[-50,-40; 50,-20],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="Transport"),
          Text(
            extent=[-50,-60; 50,-40],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="Delay")));
    end TransportDelay;
    
    block InertialDelay "Inertial delay with initial parameter" 
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      extends D.Interfaces.SISO;
      parameter Modelica.SIunits.Time delayTime=0 "Minimum time to hold value";
      parameter D.Interfaces.Logic y0=L.'U' "Initial value of output y";
    protected 
      D.Interfaces.Logic y_auxiliary(start=y0, fixed=true);
      D.Interfaces.Logic x_old(start=y0, fixed=true);
      discrete Modelica.SIunits.Time t_next(start=delayTime, fixed=true);
    algorithm 
      when delayTime > 0 and change(x) then
        x_old := x;
        t_next := time + delayTime;
      elsewhen time >= t_next then
        y_auxiliary := x;
      end when;
      y := if delayTime > 0 then y_auxiliary else x;
      annotation (
        Documentation(info="<HTML>
<P>
Provides the input as output delayed by <i>Tdel</i> if the input holds its value for a longer time than <i>Tdel</i>.
If time is less than <i>Tdel</i> the initial value <i>initout</i> holds.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>August 12, 2003   </i>
       by Christoph Clauss<br>
       reviced</li>
<li><i>March 19, 2003</i>
       by Martin Otter<br>
       initially modelled.</li>
</ul>
</HTML>"),
        Diagram,
        Icon(
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255})),
          Polygon(points=[-6,60; -16,40; 4,40; -6,60], style(color=0, rgbcolor=
                  {0,0,0})),
          Line(points=[10,60; 10,40], style(
              color=0,
              rgbcolor={0,0,0},
              fillPattern=1)),
          Line(points=[0,60; 20,60], style(
              color=0,
              rgbcolor={0,0,0},
              fillPattern=1)),
          Text(
            extent=[-50,-40; 50,-20],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="Inertial"),
          Text(
            extent=[-50,-60; 50,-40],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="Delay")));
    end InertialDelay;
    
    model InertialDelaySensitive 
      "Provide the input as output if it holds its value for a specific amount of time" 
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      extends D.Interfaces.SISO(x(start=L.'U',fixed=true));
      parameter Modelica.SIunits.Time tLH=0 "rise inertial delay";
      parameter Modelica.SIunits.Time tHL=0 "fall inertial delay";
      parameter D.Interfaces.Logic y0=L.'U' "initial value of output";
    protected 
      Integer delayTable[:,:]=D.Tables.DelayTable 
        "specification of delay according to signal change";
      Modelica.SIunits.Time delayTime;
      D.Interfaces.Logic y_auxiliary(start=y0, fixed=true);
      D.Interfaces.Logic x_old(start=y0, fixed=true);
      Integer lh;
      discrete Modelica.SIunits.Time t_next;
    algorithm 
      when {initial(),(tLH > 0 or tHL > 0) and change(x) and not initial()} then
        x_old := if initial() or pre(x) == 0 then y0 else pre(x);
        lh := delayTable[x_old, x];
        delayTime := if (lh > 0) then tLH else (if (lh < 0) then tHL else 0);
        t_next := time + delayTime;
        if (lh == 0 or abs(delayTime) < Modelica.Constants.small) then
          y_auxiliary := x;
        end if;
     elsewhen time >= t_next then
        y_auxiliary := x;
     end when;
     y := if ((tLH > 0 or tHL > 0)) then y_auxiliary else x;
      annotation (
        Documentation(info="<HTML>
<P>
Provides the input as output delayed by <i>Tdel</i> if the input holds its value for a longer time than <i>Tdel</i>.
If the time is less than <i>Tdel</i> the initial value <i>initout</i> holds.<br>
The delay <i>Tdel</i> depends on the values of the signal change. To calculate <i>Tdel</i>, the delaymap specified in
Digital.Tables is used. If the corresponding value is 1, then <i>tLH</i> is used, if it is -1, then <i>tHL</i>
is used, if it is zero, the input is not delayed.
</P>
</HTML>
",     revisions="<HTML>
<ul>
<li><i>January 13, 2005  </i> improved when-conditions and declaration of delayTable
       by Dynasim<br>
       </li>
<li><i>September 15, 2004  </i> color changed, names changed
       by Christoph Clauss<br>
       </li>
<li><i>May 12, 2004  </i> test <i>if Tdel=0</i> replaced
       by Christoph Clauss<br>
       </li>
<li><i>February 5, 2004 </i> handling of <i>tHL=0</i> or <i>tLH=0</i> revised
       by Christoph Clauss<br>
       </li>
<li><i>October 12, 2003   </i>
       by Christoph Clauss<br>
       initially modelled</li>
</HTML>"),
        Diagram,
        Icon(
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255},
              fillPattern=1)),
          Text(
            extent=[-50,-40; 50,-20],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="Inertial"),
          Text(
            extent=[-50,-60; 50,-40],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="Delay"),
          Text(
            extent=[-50,-80; 50,-60],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="sensitive"),
          Polygon(points=[-6,60; -16,40; 4,40; -6,60], style(color=0, rgbcolor=
                  {0,0,0})),
          Line(points=[10,60; 10,40], style(
              color=0,
              rgbcolor={0,0,0},
              fillPattern=1)),
          Line(points=[0,60; 20,60], style(
              color=0,
              rgbcolor={0,0,0},
              fillPattern=1))));
    end InertialDelaySensitive;
    annotation (Icon(
        Rectangle(extent=[-100,-100; 80,50],   style(fillColor=30,
              fillPattern=
                1)),
        Polygon(points=[-100,50; -80,70; 100,70; 80,50; -100,50],      style(
              fillColor=30, fillPattern=1)),
        Polygon(points=[100,70; 100,-80; 80,-100; 80,50; 100,70],      style(
              fillColor=30, fillPattern=1)),
        Text(
          extent=[-85,35; 65,-85],
          string="Library",
          style(color=3)),
        Text(
          extent=[-120,122; 120,73],
          string="%name",
          style(color=1))), Documentation(info="<html>
  
</html>"));
  end Delay;
  
  package Basic "Basic logic blocks without delays" 
    
    model Not "Not Logic" 
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      extends D.Interfaces.SISO;
    protected 
      D.Interfaces.Logic auxiliary(start=L.'0', fixed=true);
    equation 
      auxiliary = D.Tables.NotTable[x];
      y = pre(auxiliary);
      annotation (
        Documentation(info="<HTML>
<P>
Not with 1 input value, without delay.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>August 14, 2003</i>
       by Teresa Schlegel<br>
       initially modelled.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[-50,40; 50,80],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="1"),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Ellipse(extent=[50,6; 62,-6], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255}))),
        Diagram);
    end Not;
    
    model And "And logic with multiple input and one output" 
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      extends D.Interfaces.MISO;
    protected 
      D.Interfaces.Logic auxiliary[n](each start=L.'U', each fixed=true);
    equation 
      auxiliary[1] = x[1];
      for i in 1:n - 1 loop
        auxiliary[i + 1] = D.Tables.AndTable[auxiliary[i], x[i + 1]];
      end for;
      y = pre(auxiliary[n]);
      annotation (
        Documentation(info="<HTML>
<P>
And with n input values, without delay.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by  Teresa Schlegel<br>
       initially modelled.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[-50,40; 50,80],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="&"),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255}))),
        Diagram);
    end And;
    
    model Nand "Nand logic with multiple input and one output" 
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      extends D.Interfaces.MISO;
    protected 
      D.Interfaces.Logic auxiliary[n](each start=L.'U', each fixed=true);
    equation 
      auxiliary[1] = x[1];
      for i in 1:n - 1 loop
        auxiliary[i + 1] = D.Tables.AndTable[auxiliary[i], x[i + 1]];
      end for;
      y = pre(D.Tables.NotTable[auxiliary[n]]);
      annotation (
        Documentation(info="<HTML>
<P>
Nand with n input values, without delay.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by  Teresa Schlegel<br>
       initially modelled.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[-50,40; 50,80],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="&"),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Ellipse(extent=[50,6; 62,-6], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255}))),
        Diagram);
    end Nand;
    
    model Or "Or logic with multiple input and one output" 
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      extends D.Interfaces.MISO;
    protected 
      D.Interfaces.Logic auxiliary[n](each start=L.'U', each fixed=true);
    equation 
      auxiliary[1] = x[1];
      for i in 1:n - 1 loop
        auxiliary[i + 1] = D.Tables.OrTable[auxiliary[i], x[i + 1]];
      end for;
      y = pre(auxiliary[n]);
      annotation (
        Documentation(info="<HTML>
<P>
Or with n input values, without delay.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by  Teresa Schlegel<br>
       initially modelled.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[-50,40; 50,80],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string=">=1"),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255}))),
        Diagram);
    end Or;
    
    model Nor "Nor logic with multiple input and one output" 
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      extends D.Interfaces.MISO;
    protected 
      D.Interfaces.Logic auxiliary[n](each start=L.'U', each fixed=true);
    equation 
      auxiliary[1] = x[1];
      for i in 1:n - 1 loop
        auxiliary[i + 1] = D.Tables.OrTable[auxiliary[i], x[i + 1]];
      end for;
      y = pre(D.Tables.NotTable[auxiliary[n]]);
      annotation (
        Documentation(info="<HTML>
<P>
Nor with n input values, without delay.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Liane Jacobi<br>
       initially modelled.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[-50,40; 50,80],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string=">=1"),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Ellipse(extent=[50,6; 62,-6], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255}))),
        Diagram);
    end Nor;
    
    model Xor "Xor logic with multiple input and one output" 
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      extends D.Interfaces.MISO;
    protected 
      D.Interfaces.Logic auxiliary[n](each start=L.'U', each fixed=true);
    equation 
      auxiliary[1] = x[1];
      for i in 1:n - 1 loop
        auxiliary[i + 1] = D.Tables.XorTable[auxiliary[i], x[i + 1]];
      end for;
      y = pre(auxiliary[n]);
      annotation (
        Documentation(info="<HTML>
<P>
Xor with n input values, without delay.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Liane Jacobi<br>
       initially modelled.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[-50,40; 50,80],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="=1"),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255}))),
        Diagram);
    end Xor;
    
    model Xnor "Xnor logic with multiple input and one output" 
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      extends D.Interfaces.MISO;
    protected 
      D.Interfaces.Logic auxiliary[n](each start=L.'U', each fixed=true);
    equation 
      auxiliary[1] = x[1];
      for i in 1:n - 1 loop
        auxiliary[i + 1] = D.Tables.XorTable[auxiliary[i], x[i + 1]];
      end for;
      y = pre(D.Tables.NotTable[auxiliary[n]]);
      annotation (
        Documentation(info="<HTML>
<P>
XNor with n input values, without delay.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Liane Jacobi<br>
       initially modelled.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[-50,40; 50,80],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="="),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255}))),
        Diagram);
    end Xnor;
    annotation (Icon(
        Rectangle(extent=[-100,-100; 80,50],   style(fillColor=30,
              fillPattern=
                1)),
        Polygon(points=[-100,50; -80,70; 100,70; 80,50; -100,50],      style(
              fillColor=30, fillPattern=1)),
        Polygon(points=[100,70; 100,-80; 80,-100; 80,50; 100,70],      style(
              fillColor=30, fillPattern=1)),
        Text(
          extent=[-85,35; 65,-85],
          string="Library",
          style(color=3)),
        Text(
          extent=[-120,122; 120,73],
          string="%name",
          style(color=1))), Documentation(info="<html>
  
</html>"));
  end Basic;
  
  package Gates "Logic gates including delays" 
    
    model InvGate 
      "InvGate with 1 input value, composed by Not and sensitive intertial delay" 
      import D = Modelica.Electrical.Digital;
      extends D.Delay.DelayParams;
      extends D.Interfaces.SISO;
      D.Basic.Not G1         annotation (extent=[-60,-20; -20,20]);
      D.Delay.InertialDelaySensitive G2(tLH=tLH, tHL=tHL) 
        annotation (extent=[20,-20; 60,20]);
      annotation (
        Documentation(info="<HTML>
<P>
InvGate with 1 input value, composed by Not and sensitive intertial delay.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>August 14, 2003</i>
       by Teresa Schlegel<br>
       initially modelled.</li>
</ul>
</HTML>"),
        Diagram,
        Icon(
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255})),
          Text(
            extent=[-50,80; 50,40],
            style(
              color=0,
              thickness=2,
              fillColor=47,
              fillPattern=1),
            string="1"),
          Text(
            extent=[-18,-60; 20,-100],
            string="Gate",
            style(color=0)),
          Ellipse(extent=[50,6; 62,-6], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255}))));
    equation 
      connect(G2.y, y)                      annotation (points=[60,0; 100,0],
          style(color=78, rgbcolor={127,0,127}));
      connect(G1.x, x)   annotation (points=[-52,0; -60,0],  style(color=78,
            rgbcolor={127,0,127}));
      connect(G1.y, G2.x) 
        annotation (points=[-20,0; 28,0],
                                        style(color=78, rgbcolor={127,0,127}));
    end InvGate;
    
    model AndGate "AndGate with multiple input" 
      import D = Modelica.Electrical.Digital;
      extends D.Interfaces.MISO;
      extends D.Delay.DelayParams;
      D.Basic.And G1(final n=n)     annotation (extent=[-40, -20; 0, 20]);
      D.Delay.InertialDelaySensitive G2(
        tLH=tLH,
        tHL=tHL,
        y0=y0)     annotation (extent=[20,-20; 60,20]);
      annotation (
        Documentation(info="<HTML>
<P>
AndGate with n input values, composed by And and sensitive intertial delay.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Teresa Schlegel<br>
       initially modelled.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255})),
          Text(
            extent=[-50,80; 50,40],
            style(color=0, thickness=2),
            string="&"),
          Text(
            extent=[-20,-60; 20,-100],
            style(color=0, thickness=2),
            string="Gate")),
        Diagram);
    equation 
      connect(x, G1.x) 
        annotation (points=[-60,0; -32,0], style(color=78, rgbcolor={127,0,127}));
      connect(y, G2.y) 
        annotation (points=[100,0; 60,0], style(color=78, rgbcolor={127,0,127}));
      connect(G1.y, G2.x) 
        annotation (points=[0,0; 28,0], style(color=78, rgbcolor={127,0,127}));
    end AndGate;
    
    model NandGate "NandGate with multiple input" 
      import D = Modelica.Electrical.Digital;
      extends D.Delay.DelayParams;
      extends D.Interfaces.MISO;
      annotation (extent=[0, -20; 40, 20], Diagram,
        Icon(
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255})),
          Text(
            extent=[-40,40; 40,80],
            style(
              color=0,
              thickness=2,
              fillPattern=1),
            string="&"),
          Text(
            extent=[-20,-60; 20,-100],
            style(color=0, thickness=2),
            string="Gate"),
          Ellipse(extent=[50,6; 62,-6], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255}))),
        Documentation(revisions="<HTML>
<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Teresa Schlegel<br>
       initially modelled.</li>
</ul>
</HTML>", info="<HTML>
<P>
NandGate with n input values, composed by Nand and sensitive intertial delay.
</P>
</HTML>"));
      annotation (
        Documentation(info="<HTML>
<P>
NandGate with n input values, composed by Nand and sensitive intertial delay.
</P>
<p><b>Release Notes:</b></p>
<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>October 22, 2003</i>
       by Liane Jacobi<br>
       realized.</li>
</ul>
</HTML>
"),     Icon(
          Text(
            extent=[-40,80; 40,40],
            style(color=0, thickness=2),
            string="&"),
          Text(
            extent=[-20, -40; 20, -80],
            style(color=0, thickness=2),
            string="Gate"),
          Ellipse(extent=[60, -10; 40, 10], style(color=0, thickness=2))),
        Diagram,
        DymolaStoredErrors);
      D.Basic.Nand G1(final n=n)      annotation (extent=[-40,-20; 0,20]);
      D.Delay.InertialDelaySensitive G2(
        tLH=tLH,
        tHL=tHL,
        y0=y0)     annotation (extent=[20,-20; 60,20]);
    equation 
      connect(x, G1.x) 
        annotation (points=[-60,0; -32,0], style(color=78, rgbcolor={127,0,127}));
      connect(G1.y, G2.x) 
        annotation (points=[0,0; 28,0], style(color=78, rgbcolor={127,0,127}));
      connect(G2.y, y) 
        annotation (points=[60,0; 100,0], style(color=78, rgbcolor={127,0,127}));
    end NandGate;
    
    model OrGate "OrGate with multiple input" 
      import D = Modelica.Electrical.Digital;
      extends D.Delay.DelayParams;
      extends D.Interfaces.MISO;
      D.Basic.Or G1(final n=n)    annotation (extent=[-40, -20; 0, 20]);
      D.Delay.InertialDelaySensitive G2(
        tLH=tLH,
        tHL=tHL,
        y0=y0)     annotation (extent=[20,-20; 60,20]);
      annotation (
        Documentation(info="<HTML>
<P>
OrGate with n input values, composed by Or and sensitive intertial delay.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Teresa Schlegel<br>
       initially modelled.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255})),
          Text(
            extent=[-50,80; 50,40],
            style(color=0, thickness=2),
            string=">=1"),
          Text(
            extent=[-20,-60; 20,-100],
            style(color=0, thickness=2),
            string="Gate")),
        Diagram);
    equation 
      connect(G1.y, G2.x) 
        annotation (points=[0,0; 28,0], style(color=78, rgbcolor={127,0,127}));
      connect(x,G1. x) 
        annotation (points=[-60,0; -32,0], style(color=78, rgbcolor={127,0,127}));
      connect(y, G2.y) 
        annotation (points=[100,0; 60,0], style(color=78, rgbcolor={127,0,127}));
    end OrGate;
    
    model NorGate "NorGate with multiple input" 
      import D = Modelica.Electrical.Digital;
      extends D.Delay.DelayParams;
      extends D.Interfaces.MISO;
      D.Basic.Nor G1(final n=n)     annotation (extent=[-40, -20; 0, 20]);
      D.Delay.InertialDelaySensitive G2(
        tLH=tLH,
        tHL=tHL,
        y0=y0)     annotation (extent=[20,-20; 60,20]);
      annotation (
        Documentation(info="<HTML>
<P>
NorGate with n input values, composed by Nor and sensitive intertial delay.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Liane Jacobi<br>
       initially modelled.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255})),
          Text(
            extent=[-50,80; 50,40],
            style(color=0, thickness=2),
            string=">=1"),
          Text(
            extent=[-20,-60; 20,-100],
            style(color=0, thickness=2),
            string="Gate"),
          Ellipse(extent=[50,6; 62,-6], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255}))),
        Diagram);
    equation 
      connect(G1.y, G2.x) 
        annotation (points=[0,0; 28,0], style(color=78, rgbcolor={127,0,127}));
      connect(x, G1.x) 
        annotation (points=[-60,0; -32,0], style(color=78, rgbcolor={127,0,127}));
      connect(y, G2.y) 
        annotation (points=[100,0; 60,0], style(color=78, rgbcolor={127,0,127}));
    end NorGate;
    
    model XorGate "XorGate with multiple input" 
      import D = Modelica.Electrical.Digital;
      extends D.Delay.DelayParams;
      extends D.Interfaces.MISO;
      D.Basic.Xor G1(final n=n)     annotation (extent=[-40, -20; 0, 20]);
      D.Delay.InertialDelaySensitive G2(
        tLH=tLH,
        tHL=tHL,
        y0=y0)     annotation (extent=[20,-20; 60,20]);
      annotation (
        Documentation(info="<HTML>
<P>
XorGate with n input values, composed by Xor and sensitive intertial delay.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Liane Jacobi<br>
       initially modelled.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255})),
          Text(
            extent=[-50,80; 50,40],
            style(color=0, thickness=2),
            string="=1"),
          Text(
            extent=[-20,-60; 20,-100],
            style(color=0, thickness=2),
            string="Gate")),
        Diagram);
    equation 
      connect(x, G1.x) 
        annotation (points=[-60,0; -32,0], style(color=78, rgbcolor={127,0,127}));
      connect(G1.y, G2.x) 
        annotation (points=[0,0; 28,0], style(color=78, rgbcolor={127,0,127}));
      connect(G2.y, y) 
        annotation (points=[60,0; 100,0], style(color=78, rgbcolor={127,0,127}));
    end XorGate;
    
    model XnorGate "XnorGate with multiple input" 
      import D = Modelica.Electrical.Digital;
      extends D.Delay.DelayParams;
      extends D.Interfaces.MISO;
      D.Basic.Xnor G1(final n=n)      annotation (extent=[-40,-20; 0,20]);
      D.Delay.InertialDelaySensitive G2(
        tLH=tLH,
        tHL=tHL,
        y0=y0)     annotation (extent=[20,-20; 60,20]);
      annotation (
        Documentation(info="<HTML>
<P>
XNorGate with n input values, composed by XNor and sensitive intertial delay.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>September 15, 2004</i> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><i>October 22, 2003</i>
       by Liane Jacobi<br>
       initially modelled.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255})),
          Text(
            extent=[-40,80; 40,40],
            style(color=0, thickness=2),
            string="="),
          Text(
            extent=[-20,-60; 20,-100],
            style(color=0, thickness=2),
            string="Gate")),
        Diagram,
        DymolaStoredErrors);
    equation 
      connect(x, G1.x) 
        annotation (points=[-60,0; -32,0], style(color=78, rgbcolor={127,0,127}));
      connect(G2.y, y) 
        annotation (points=[60,0; 100,0], style(color=78, rgbcolor={127,0,127}));
      connect(G1.y, G2.x) 
        annotation (points=[0,0; 28,0], style(color=78, rgbcolor={127,0,127}));
    end XnorGate;
    
    model BufGate 
      "BufGate with 1 input value, composed by Not and sensitive intertial delay" 
      import D = Modelica.Electrical.Digital;
      extends D.Delay.DelayParams;
      extends D.Interfaces.SISO;
      D.Delay.InertialDelaySensitive G1(tLH=tLH, tHL=tHL) 
        annotation (extent=[-30,-20; 10,20]);
      annotation (
        Documentation(info="<HTML>
<P>
BufGate with 1 input value, composed by Not and sensitive intertial delay.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>September 21, 2004</i>
       by Andre Schneider<br>
       initially modelled.</li>
</ul>
</HTML>"),
        Diagram,
        Icon(
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=84,
              rgbfillColor={213,170,255})),
          Text(
            extent=[-18,-60; 20,-100],
            string="Gate",
            style(color=0)),
          Text(
            extent=[-50,80; 50,40],
            style(
              color=0,
              thickness=2,
              fillColor=47,
              fillPattern=1),
            string="1")));
    equation 
      connect(G1.y, y)                      annotation (points=[10,0; 100,0],
          style(color=78, rgbcolor={127,0,127}));
      connect(G1.x, x) annotation (points=[-22,0; -60,0], style(color=78,
            rgbcolor={127,0,127}));
    end BufGate;
    annotation (Icon(
        Rectangle(extent=[-100,-100; 80,50],   style(fillColor=30,
              fillPattern=
                1)),
        Polygon(points=[-100,50; -80,70; 100,70; 80,50; -100,50],      style(
              fillColor=30, fillPattern=1)),
        Polygon(points=[100,70; 100,-80; 80,-100; 80,50; 100,70],      style(
              fillColor=30, fillPattern=1)),
        Text(
          extent=[-85,35; 65,-85],
          string="Library",
          style(color=3)),
        Text(
          extent=[-120,122; 120,73],
          string="%name",
          style(color=1))), Documentation(info="<html>
  
</html>"));
  end Gates;
  
  package Sources "Time-dependend digital signal sources" 
    
    block Set "Digital Set Source" 
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      parameter D.Interfaces.Logic x=L.'1' "Logic value to be set";
      D.Interfaces.DigitalOutput y 
                    annotation (extent=[90,-10; 110,10]);
    algorithm 
      assert(x >= L.min and x <= L.max, "Parameter is no logic value");
      y := x;
      annotation (Documentation(info="<HTML>
<P>
Sets a nine valued digital signal, which is specified by the <i>setval</i> parameter.
</P>
<P>
To specify <i>setval</i>, the integer code has to be used.
</P>
<p><b>Code Table</b></p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Logic value</b></td>
      <td valign=\"top\"><b>Integer code</b></td>
      <td valign=\"top\"><b>Meaning</b></td>
  </tr>
                         
  <tr><td valign=\"top\">'U'</td> <td valign=\"top\">1</td> <td valign=\"top\">Uninitialized</td></tr>
  <tr><td valign=\"top\">'X'</td> <td valign=\"top\">2</td> <td valign=\"top\">Forcing Unknown</td></tr>
  <tr><td valign=\"top\">'0'</td> <td valign=\"top\">3</td> <td valign=\"top\">Forcing 0</td></tr>
  <tr><td valign=\"top\">'1'</td> <td valign=\"top\">4</td> <td valign=\"top\">Forcing 1</td></tr>
  <tr><td valign=\"top\">'Z'</td> <td valign=\"top\">5</td> <td valign=\"top\">High Impedance</td></tr>
  <tr><td valign=\"top\">'W'</td> <td valign=\"top\">6</td> <td valign=\"top\">Weak Unknown</td></tr>
  <tr><td valign=\"top\">'L'</td> <td valign=\"top\">7</td> <td valign=\"top\">Weak 0</td></tr>
  <tr><td valign=\"top\">'H'</td> <td valign=\"top\">8</td> <td valign=\"top\">Weak 1</td></tr>
  <tr><td valign=\"top\">'-'</td> <td valign=\"top\">9</td> <td valign=\"top\">Don't care</td></tr>
</table>

<P>
If the logic values are imported by <br><b> import L = Modelica.Electrical.Digital.Interfaces.LogicValue; </b> <br>
they can be used to specify the parameter, e.g. <b>L.'0'</b> for forcing 0.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>August 20, 2003</i>
       by Teresa Schlegel<br>
       initially modelled.</li>
</ul>
</HTML>"),
    Icon( Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=52,
              rgbfillColor={213,255,170})),
          Text(
            extent=[-50,40; 50,80],
            string="SET",
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillPattern=1)),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Line(points=[50,0; 90,0], style(color=78, rgbcolor={127,0,127}))));
    end Set;
    
    block Step "Digital Step Source" 
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      parameter D.Interfaces.Logic before=L.'0' "Logic value before step";
      parameter D.Interfaces.Logic after=L.'1' "Logic value after step";
      parameter Real stepTime=1 "step time";
      D.Interfaces.DigitalOutput y 
                    annotation (extent=[90,-10; 110,10]);
    algorithm 
      assert(before >= L.min and before <= L.max, "Parameter is no logic value");
      assert(after >= L.min and after <= L.max, "Parameter is no logic value");
      when initial() then
        y := before;
      end when;
      if time >= stepTime then
        y := after;
      else
        y := before;
      end if;
      annotation (
        Documentation(info="<HTML>
<P>
The step source output signal steps from the value <i>before</i> to the value <i>after</i>
at the time <i>stepTime</i>.
</P>
<P>
To specify the logic value parameters, the integer code has to be used.
</P>
<p><b>Code Table</b></p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Logic value</b></td>
      <td valign=\"top\"><b>Integer code</b></td>
      <td valign=\"top\"><b>Meaning</b></td>
  </tr>
                         
  <tr><td valign=\"top\">'U'</td> <td valign=\"top\">1</td> <td valign=\"top\">Uninitialized</td></tr>
  <tr><td valign=\"top\">'X'</td> <td valign=\"top\">2</td> <td valign=\"top\">Forcing Unknown</td></tr>
  <tr><td valign=\"top\">'0'</td> <td valign=\"top\">3</td> <td valign=\"top\">Forcing 0</td></tr>
  <tr><td valign=\"top\">'1'</td> <td valign=\"top\">4</td> <td valign=\"top\">Forcing 1</td></tr>
  <tr><td valign=\"top\">'Z'</td> <td valign=\"top\">5</td> <td valign=\"top\">High Impedance</td></tr>
  <tr><td valign=\"top\">'W'</td> <td valign=\"top\">6</td> <td valign=\"top\">Weak Unknown</td></tr>
  <tr><td valign=\"top\">'L'</td> <td valign=\"top\">7</td> <td valign=\"top\">Weak 0</td></tr>
  <tr><td valign=\"top\">'H'</td> <td valign=\"top\">8</td> <td valign=\"top\">Weak 1</td></tr>
  <tr><td valign=\"top\">'-'</td> <td valign=\"top\">9</td> <td valign=\"top\">Don't care</td></tr>
</table>
<P>
If the logic values are imported by <br><b> import L = Modelica.Electrical.Digital.Interfaces.LogicValue; </b> <br>
they can be used to specify the parameter, e.g. <b>L.'0'</b> for forcing 0.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>August 20, 2003</i>
       by Teresa Schlegel<br>
       initially modelled.</li>
</ul>
</HTML>"),
        Icon(
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=52,
              rgbfillColor={213,255,170})),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Line(points=[-30,40; 0,40; 0,80; 30,80], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=84,
              rgbfillColor={213,170,255},
              fillPattern=1)),
          Line(points=[50,0; 90,0], style(color=78, rgbcolor={127,0,127}))),
        Diagram);
    equation 
      
    end Step;
    
    block Table "Digital Tabular Source" 
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      parameter D.Interfaces.Logic x[:]={1};
      parameter Real t[size(x, 1)]={1};
      parameter D.Interfaces.Logic y0=L.'U';
      final parameter Integer n=size(x, 1);
      D.Interfaces.DigitalOutput y 
                    annotation (extent=[90,-10; 110,10]);
    algorithm 
      if initial() then
        assert(y0 >= L.min and y0 <= L.max, "Parameter y0 is not of type Logic");
        assert(n > 0, "Invalid size of table (n < 1)");
        for i in 1:n loop
          assert(x[i] >= L.min and x[i] <= L.max, "Table element is not of type Logic");
        end for;
      end if;
      y := y0;
      for i in 1:n loop
        if time >= t[i] then
          y := x[i];
        end if;
      end for;
      annotation (
        Documentation(info="<HTML>
<P>
The table source output signal <i>y</i> steps to the values of the  <i>x</i> table at the corresponding
timepoints in the <i>t</i> table. <br>The initial value is specified by <i>y0</i>.
</P>
<P>
To specify the logic value parameters, the integer code has to be used.
</P>
<p><b>Code Table</b></p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Logic value</b></td>
      <td valign=\"top\"><b>Integer code</b></td>
      <td valign=\"top\"><b>Meaning</b></td>
  </tr>
                         
  <tr><td valign=\"top\">'U'</td> <td valign=\"top\">1</td> <td valign=\"top\">Uninitialized</td></tr>
  <tr><td valign=\"top\">'X'</td> <td valign=\"top\">2</td> <td valign=\"top\">Forcing Unknown</td></tr>
  <tr><td valign=\"top\">'0'</td> <td valign=\"top\">3</td> <td valign=\"top\">Forcing 0</td></tr>
  <tr><td valign=\"top\">'1'</td> <td valign=\"top\">4</td> <td valign=\"top\">Forcing 1</td></tr>
  <tr><td valign=\"top\">'Z'</td> <td valign=\"top\">5</td> <td valign=\"top\">High Impedance</td></tr>
  <tr><td valign=\"top\">'W'</td> <td valign=\"top\">6</td> <td valign=\"top\">Weak Unknown</td></tr>
  <tr><td valign=\"top\">'L'</td> <td valign=\"top\">7</td> <td valign=\"top\">Weak 0</td></tr>
  <tr><td valign=\"top\">'H'</td> <td valign=\"top\">8</td> <td valign=\"top\">Weak 1</td></tr>
  <tr><td valign=\"top\">'-'</td> <td valign=\"top\">9</td> <td valign=\"top\">Don't care</td></tr>
</table>
<P>
If the logic values are imported by <br><b> import L = Modelica.Electrical.Digital.Interfaces.LogicValue; </b> <br>
they can be used to specify the parameter, e.g. <b>L.'0'</b> for forcing 0.
</P>
</HTML>
",     revisions="<HTML>
<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>August 20, 2003</i>
       by Teresa Schlegel<br>
       initially modelled.</li>
</ul>
</HTML>"),
        Icon(
          Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=52,
              rgbfillColor={213,255,170})),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Line(points=[50,0; 90,0], style(color=78, rgbcolor={127,0,127})),
          Rectangle(extent=[-30,80; 32,70], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=30,
              rgbfillColor={215,215,215},
              fillPattern=1)),
          Rectangle(extent=[-30,70; 32,40], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Line(points=[0,80; 0,40], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=53,
              rgbfillColor={128,255,0},
              fillPattern=1)),
          Line(points=[-30,60; 32,60], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=53,
              rgbfillColor={128,255,0},
              fillPattern=1)),
          Line(points=[-30,50; 32,50], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=53,
              rgbfillColor={128,255,0},
              fillPattern=1))),
        Diagram);
    end Table;
    
    model Pulse "Digital Pulse Source" 
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      parameter Real width(
        final min=Modelica.Constants.small,
        final max=100) = 50 "Widths of pulses in % of periods";
      parameter Modelica.SIunits.Time period(final min=Modelica.Constants.small)=
           1 "Time for one period";
      parameter Modelica.SIunits.Time startTime=0 
        "Output = offset for time < startTime";
      parameter D.Interfaces.Logic pulse=L.'0';
      parameter D.Interfaces.Logic quiet=L.'1';
      Modelica.SIunits.Time T0(final start=startTime) 
        "Start time of current period";
      parameter Integer nperiod=-1 
        "Number of periods (< 0 means infinite number of periods)";
      Integer np(start=0);
      D.Interfaces.DigitalOutput y 
                    annotation (extent=[90,-10; 110,10]);
    protected 
      Boolean sampling;
    equation 
      sampling = nperiod <> 0 and (nperiod >= pre(np) or nperiod < 0);
      
      when sampling and sample(startTime, period) then
         T0 = time;
         np = if nperiod > 0 then pre(np) + 1 else pre(np);
      end when;
      
      if sampling then
         y = if time < startTime or time >= T0 + ((width*period)/100) then quiet else pulse;
      else
         y = quiet;
      end if;
      
      annotation (Documentation(info="<HTML>
<P>
The pulse source forms pulses between the  <i>quiet</i> value and the <i>pulse</i> value.
The pulse length <i>width</i> is specified in percent of the period length <i>period</i>.
The number of periods is specified by <i>nperiod</i>. If <i>nperiod</i> is less than zero,
the number of periods is unlimited.
</P>
<P>
To specify the logic value parameters, the integer code has to be used.
</P>
<p><b>Code Table</b></p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Logic value</b></td>
      <td valign=\"top\"><b>Integer code</b></td>
      <td valign=\"top\"><b>Meaning</b></td>
  </tr>
                         
  <tr><td valign=\"top\">'U'</td> <td valign=\"top\">1</td> <td valign=\"top\">Uninitialized</td></tr>
  <tr><td valign=\"top\">'X'</td> <td valign=\"top\">2</td> <td valign=\"top\">Forcing Unknown</td></tr>
  <tr><td valign=\"top\">'0'</td> <td valign=\"top\">3</td> <td valign=\"top\">Forcing 0</td></tr>
  <tr><td valign=\"top\">'1'</td> <td valign=\"top\">4</td> <td valign=\"top\">Forcing 1</td></tr>
  <tr><td valign=\"top\">'Z'</td> <td valign=\"top\">5</td> <td valign=\"top\">High Impedance</td></tr>
  <tr><td valign=\"top\">'W'</td> <td valign=\"top\">6</td> <td valign=\"top\">Weak Unknown</td></tr>
  <tr><td valign=\"top\">'L'</td> <td valign=\"top\">7</td> <td valign=\"top\">Weak 0</td></tr>
  <tr><td valign=\"top\">'H'</td> <td valign=\"top\">8</td> <td valign=\"top\">Weak 1</td></tr>
  <tr><td valign=\"top\">'-'</td> <td valign=\"top\">9</td> <td valign=\"top\">Don't care</td></tr>
</table>
<P>
If the logic values are imported by <br><b> import L = Modelica.Electrical.Digital.Interfaces.LogicValue; </b> <br>
they can be used to specify the parameter, e.g. <b>L.'0'</b> for forcing 0.
</P>
</HTML>
", revisions="<HTML>
<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>September 2, 2003</i>
       by Christoph Clauss<br>
       initially modelled.</li>
</ul>
</HTML>"),
    Icon( Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=52,
              rgbfillColor={213,255,170})),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Line(points=[50,0; 90,0], style(color=78, rgbcolor={127,0,127})),
          Line(points=[-36,40; -30,40; -30,40; -18,40; -18,40; -14,40; -14,80;
                14,80; 14,40; 14,40; 14,40; 28,40; 30,40; 36,40],
                                                          style(
              color=0,
              rgbcolor={0,0,0},
              fillPattern=1))));
    end Pulse;
    
    model Clock "Digital Clock Source" 
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      parameter Modelica.SIunits.Time startTime=0 
        "Output = offset for time < startTime";
      parameter Modelica.SIunits.Time period(
        final min=Modelica.Constants.small)=1 "Time for one period";
      parameter Real width(
        final min=Modelica.Constants.small,
        final max=100) = 50 "Width of pulses in % of period";
      D.Interfaces.DigitalOutput y "Connector of Digital output signal" 
                    annotation (extent=[90,-10; 110,10]);
    protected 
      Modelica.SIunits.Time t_i(final start=startTime) 
        "Start time of current period";
      Modelica.SIunits.Time t_width=period*width/100;
    algorithm 
      when sample(startTime, period) then
        t_i := time;
      end when;
      y := if (not time>=startTime) or time >= t_i + t_width then L.'0' else L.'1';
      annotation (Documentation(info="<HTML>
<P>
The clock source forms pulses between the  <i>'0'</i> value (forcing 0) and the <i>'1'</i> value (forcing 1).
The pulse length <i>width</i> is specified in percent of the period length <i>period</i>.
The number of periods is unlimited. The first pulse starts at startTime.
</P>
<P> The clock source is a special but often used variant of the pulse source.
</P>
</HTML>
",     revisions="<HTML>
<ul>
<li><i>   </i>
       by ...<br>
       </li>
<li><i>September 18, 2004</i>
       by Andre Schneider<br>
       initially modelled.</li>
</ul>
</HTML>"),
    Icon( Rectangle(extent=[-50,100; 50,-100], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=52,
              rgbfillColor={213,255,170})),
          Text(
            extent=[152,-160; -148,-100],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Line(points=[50,0; 90,0], style(color=78, rgbcolor={127,0,127})),
          Line(points=[-36,40; -30,40; -30,80; -18,80; -18,40; -6,40; -6,80; 6,80;
                6,40; 18,40; 18,80; 30,80; 30,40; 36,40], style(
              color=0,
              rgbcolor={0,0,0},
              fillPattern=1))),
        DymolaStoredErrors);
    end Clock;
    annotation (Icon(
        Rectangle(extent=[-100,-100; 80,50],   style(fillColor=30,
              fillPattern=
                1)),
        Polygon(points=[-100,50; -80,70; 100,70; 80,50; -100,50],      style(
              fillColor=30, fillPattern=1)),
        Polygon(points=[100,70; 100,-80; 80,-100; 80,50; 100,70],      style(
              fillColor=30, fillPattern=1)),
        Text(
          extent=[-85,35; 65,-85],
          string="Library",
          style(color=3)),
        Text(
          extent=[-120,122; 120,73],
          string="%name",
          style(color=1))), Documentation(info="<html>
  
</html>"));
  end Sources;
  
  package Converters "Converters between 2-,3-,4- and 9-valued logic" 
    block LogicToXO1 "Conversion to XO1" 
      import D = Modelica.Electrical.Digital;
      import T = Modelica.Electrical.Digital.Tables;
      D.Interfaces.DigitalInput x[n] 
                        annotation (extent=[-60, -10; -40, 10]);
      D.Interfaces.DigitalOutput y[n] 
                         annotation (extent=[40, -10; 60, 10]);
      parameter Integer n(final min=1) = 1 "signal width";
    algorithm 
      for i in 1:n loop
        y[i] := T.X01Table[x[i]];
      end for;
      annotation (
        Documentation(info="<HTML>
<P>
Conversion of a nine valued digital input into a X01 digital output without
any delay according to IEEE 1164 To_X01 function.
</P>
<p><b>Conversion Table:</b></p>
<pre>
                          input                  output
                          'U' (coded by 1)       'X'  (coded by 2)
                          'X' (coded by 2)       'X'  (coded by 2)
                          '0' (coded by 3)       '0'  (coded by 3)
                          '1' (coded by 4)       '1'  (coded by 4)
                          'Z' (coded by 5)       'X'  (coded by 2)
                          'W' (coded by 6)       'X'  (coded by 2)
                          'L' (coded by 7)       '0'  (coded by 3)
                          'H' (coded by 8)       '1'  (coded by 4)
                          '-' (coded by 9)       'X'  (coded by 2)
</pre>
<P>
If the signal width is greater than 1 this conversion is done for each signal.
</P>
</HTML>
",     revisions="<HTML>
<ul>
<li><i>September 15, 2004   </i>
       by Christoph Clauss name converted from cvt_to_x01 into LogicToX01<br>
       </li>
<li><i>November 5, 2003</i>
       by Christoph Clauss<br>
       initially modelled.</li>
</ul>
</HTML>
"),     Icon(
          Text(
            extent=[152,-100; -148,-40],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Polygon(points=[-40,-40; -40,40; 40,40; -40,-40], style(
              color=78,
              rgbcolor={127,0,127},
              fillColor=78,
              rgbfillColor={127,0,127},
              fillPattern=1)),
          Polygon(points=[-40,-40; 40,-40; 40,40; -40,-40], style(
              color=78,
              rgbcolor={127,0,127},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Text(
            extent=[0,-20; 40,-40],
            style(color=0, thickness=2),
            string="X01"),
          Rectangle(extent=[-40,40; 40,-40], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2))),
        Diagram);
    end LogicToXO1;
    
    block LogicToXO1Z "Conversion to XO1Z" 
      import D = Modelica.Electrical.Digital;
      import T = Modelica.Electrical.Digital.Tables;
      D.Interfaces.DigitalInput x[n] 
                        annotation (extent=[-60, -10; -40, 10]);
      D.Interfaces.DigitalOutput y[n] 
                         annotation (extent=[40, -10; 60, 10]);
      parameter Integer n(final min=1) = 1 "signal width";
    algorithm 
      for i in 1:n loop
        y[i] := T.X01ZTable[x[i]];
      end for;
      annotation (
        Documentation(info="<HTML>
<P>
Conversion of a nine valued digital input into a X01Z digital output without
any delay according to IEEE 1164 To_X01Z function.
</P>
<p><b>Conversion Table:</b></p>
<pre>
                          input                  output
                          'U' (coded by 1)       'X'  (coded by 2)
                          'X' (coded by 2)       'X'  (coded by 2)
                          '0' (coded by 3)       '0'  (coded by 3)
                          '1' (coded by 4)       '1'  (coded by 4)
                          'Z' (coded by 5)       'Z'  (coded by 5)
                          'W' (coded by 6)       'X'  (coded by 2)
                          'L' (coded by 7)       '0'  (coded by 3)
                          'H' (coded by 8)       '1'  (coded by 4)
                          '-' (coded by 9)       'X'  (coded by 2)
</pre>
<P>
If the signal width is greater than 1 this conversion is done for each signal.
</P>
</HTML>
",     revisions="<HTML>
<ul>
<li><i>September 15, 2004   </i>
       by Christoph Clauss name converted from cvt_to_x01z into LogicToX01Z<br>
       </li>
<li><i>November 5, 2003</i>
       by Christoph Clauss<br>
       initially modelled.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[152,-100; -148,-40],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Polygon(points=[-40,-40; -40,40; 40,40; -40,-40], style(
              color=78,
              rgbcolor={127,0,127},
              fillColor=78,
              rgbfillColor={127,0,127},
              fillPattern=1)),
          Polygon(points=[-40,-40; 40,-40; 40,40; -40,-40], style(
              color=78,
              rgbcolor={127,0,127},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Text(
            extent=[0,-20; 40,-40],
            style(color=0, thickness=2),
            string="X01Z"),
          Rectangle(extent=[-40,40; 40,-40], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2))),
        Diagram);
    end LogicToXO1Z;
    
    block LogicToUX01 "Conversion to UXO1" 
      import D = Modelica.Electrical.Digital;
      import T = Modelica.Electrical.Digital.Tables;
      D.Interfaces.DigitalInput x[n] 
                        annotation (extent=[-60, -10; -40, 10]);
      D.Interfaces.DigitalOutput y[n] 
                         annotation (extent=[40, -10; 60, 10]);
      parameter Integer n(final min=1) = 1 "signal width";
    algorithm 
      for i in 1:n loop
        y[i] := T.UX01Table[x[i]];
      end for;
      annotation (
        Documentation(info="<HTML>
<P>
Conversion of a nine valued digital input into a UX01 digital output without
any delay according to IEEE 1164 To_UX01 function.
</P>
<p><b>Conversion Table:</b></p>
<pre>
                          input                  output
                          'U' (coded by 1)       'U'  (coded by 1)
                          'X' (coded by 2)       'X'  (coded by 2)
                          '0' (coded by 3)       '0'  (coded by 3)
                          '1' (coded by 4)       '1'  (coded by 4)
                          'Z' (coded by 5)       'X'  (coded by 2)
                          'W' (coded by 6)       'X'  (coded by 2)
                          'L' (coded by 7)       '0'  (coded by 3)
                          'H' (coded by 8)       '1'  (coded by 4)
                          '-' (coded by 9)       'X'  (coded by 2)
</pre>
<P>
If the signal width is greater than 1 this conversion is done for each signal.
</P>
</HTML>
",     revisions="<HTML>
<ul>
<li><i>September 15, 2004   </i>
       by Christoph Clauss name converted from cvt_to_ux01 into LogicToUX01<br>
       </li>
<li><i>November 5, 2003</i>
       by Christoph Clauss<br>
       initially modelled.</li>
</ul>
</HTML>"),
        Icon(
          Text(
            extent=[152,-100; -148,-40],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Polygon(points=[-40,-40; -40,40; 40,40; -40,-40], style(
              color=78,
              rgbcolor={127,0,127},
              fillColor=78,
              rgbfillColor={127,0,127},
              fillPattern=1)),
          Polygon(points=[-40,-40; 40,-40; 40,40; -40,-40], style(
              color=78,
              rgbcolor={127,0,127},
              thickness=2,
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Text(
            extent=[0,-20; 40,-40],
            style(color=0, thickness=2),
            string="UX01"),
          Rectangle(extent=[-40,40; 40,-40], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2))),
        Diagram);
    end LogicToUX01;
    
    block BooleanToLogic "Boolean to Logic converter" 
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      Modelica.Blocks.Interfaces.BooleanInput x[n] 
        annotation (extent=[-60, -10; -40, 10]);
      annotation (
        Documentation(info="<HTML>
<P>
Conversion of a Boolean input into a digital output without any delay according to:
</P>
<pre>
                          input      output
                          true       '1'  (coded by 4)
                          false      '0'  (coded by 3)
</pre>
<P>
If the signal width is greater than 1 this conversion is done for each signal.
</P>
</HTML>
",     revisions="<HTML>
<ul>
<li><i>September 15, 2004   </i>
       by Christoph Clauss colors changed<br>
       </li>
<li><i>November 4, 2003</i>
       by Christoph Clauss<br>
       initially modelled.</li>
</ul>
</HTML>"),
        extent=[-60, -10; -40, 10],
        DymolaStoredErrors,
        Icon(Polygon(points=[-40,-40; 40,40; 40,-40; -40,-40],   style(
              color=78,
              rgbcolor={127,0,127},
              fillColor=78,
              rgbfillColor={127,0,127},
              fillPattern=1)), Polygon(points=[-40,40; 40,40; -40,-40; -40,40],
                      style(
              color=5,
              fillColor=5,
              fillPattern=1)),
          Text(
            extent=[152,-100; -148,-40],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-40,40; 40,-40], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2))),
        Diagram);
      
      Digital.Interfaces.DigitalOutput y[n] 
        annotation (extent=[40, -10; 60, 10]);
      annotation (extent=[40, -10; 60, 10]);
      annotation (Diagram);
      parameter Integer n(final min=1) = 1 "signal width";
    equation 
      for i in 1:n loop
        y[i] = if x[i] then L.'1' else L.'0';
      end for;
    end BooleanToLogic;
    
    block LogicToBoolean "Logic to Boolean converter" 
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      Digital.Interfaces.DigitalInput x[n] 
        annotation (extent=[-60, -10; -40, 10]);
      Modelica.Blocks.Interfaces.BooleanOutput y[n] 
        annotation (extent=[40, -10; 60, 10]);
      annotation (Documentation(info="<HTML>
<P>
Conversion of a digital input into a Boolean output without any delay according to:
</P>
<pre>
                          input                 output
                          'U'  (coded by 1)     false
                          'X'  (coded by 2)     false
                          '0'  (coded by 3)     false
                          '1'  (coded by 4)     true
                          'Z'  (coded by 5)     false
                          'W'  (coded by 6)     false
                          'L'  (coded by 7)     false
                          'H'  (coded by 8)     true
                          '-'  (coded by 9)     false
</pre>
<P>
If the signal width is greater than 1 this conversion is done for each signal.
</P>
</HTML>
",     revisions="<HTML>
<ul>
<li><i>September 15, 2004   </i>
       by Christoph Clauss colors changed<br>
       </li>
<li><i>November 4, 2003</i>
       by Christoph Clauss<br>
       initially modelled.</li>
</ul>
</HTML>"),
    Icon(Polygon(points=[-40,40; 40,40; -40,-40; -40,40], style(
              color=78,
              rgbcolor={127,0,127},
              fillColor=78,
              rgbfillColor={127,0,127})),
          Text(
            extent=[152,-100; -148,-40],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Polygon(points=[-40,-40; 40,-40; 40,40; -40,-40], style(
              color=5,
              rgbcolor={255,0,255},
              fillColor=5,
              rgbfillColor={255,0,255})),
          Rectangle(extent=[-40,40; 40,-40], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2))));
      parameter Integer n(final min=1) = 1 "signal width";
    equation 
      for i in 1:n loop
        y[i] = if x[i] == 4 or x[i] == 8 then true else false;
      end for;
    end LogicToBoolean;
    
    block RealToLogic "Real to Logic converter" 
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      Modelica.Blocks.Interfaces.RealInput x[n] 
        annotation (extent=[-60, -10; -40, 10]);
      annotation (
        Documentation(info="<HTML>
<P>
Conversion of a real input into a digital output without any delay according to:
</P>
<pre>
                                 condition            output
      first check:               input greater upp    lupp
      second check:              input larger low     llow
                                 else                 lmid
</pre>
<P>
If the signal width is greater than 1 this conversion is done for each signal.
</P>
</HTML>
",     revisions="<HTML>
<ul>
<li><i>September 15, 2004   </i>
       by Christoph Clauss colors changed<br>
       </li>
<li><i>November 5, 2003</i>
       by Christoph Clauss<br>
       initially modelled.</li>
</ul>
</HTML>"),
        extent=[-60, -10; -40, 10],
        DymolaStoredErrors,
        Icon(Polygon(points=[-40,-40; 40,40; 40,-40; -40,-40],   style(
              color=78,
              rgbcolor={127,0,127},
              fillColor=78,
              rgbfillColor={127,0,127},
              fillPattern=1)), Polygon(points=[-40,40; 40,40; -40,-40; -40,40],
                      style(fillPattern=1)),
          Text(
            extent=[148,-100; -152,-40],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-40,40; 40,-40], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2))),
        Diagram);
      
      Digital.Interfaces.DigitalOutput y[n] 
        annotation (extent=[40, -10; 60, 10]);
      annotation (extent=[40, -10; 60, 10]);
      annotation (Diagram);
      parameter Integer n(final min=1) = 1 "signal width";
      parameter Real upper_limit=1 "upper limit";
      parameter Real lower_limit=0 "lower limit";
      parameter Digital.Interfaces.Logic upper_value=L.'1' 
        "output if input > upper_limit";
      parameter Digital.Interfaces.Logic lower_value=L.'0' 
        "output if input < lower_limit";
      parameter Digital.Interfaces.Logic middle_value=L.'X' "output else";
    equation 
      for i in 1:n loop
        y[i] = if x[i] > upper_limit then upper_value else 
          if x[i] < lower_limit then lower_value else middle_value;
      end for;
    end RealToLogic;
    
    block LogicToReal "Logic to Real converter" 
      import L = Modelica.Electrical.Digital.Interfaces.LogicValue;
      Digital.Interfaces.DigitalInput x[n] 
        annotation (extent=[-60, -10; -40, 10]);
      Modelica.Blocks.Interfaces.RealOutput y[n] 
        annotation (extent=[40, -10; 60, 10]);
      annotation (Documentation(info="<HTML>
<P>
Conversion of a digital input into a Real output without any delay according to:
</P>
<pre>
                          input                 output
                          'U'  (coded by 1)     val_U
                          'X'  (coded by 2)     val_X
                          '0'  (coded by 3)     val_0
                          '1'  (coded by 4)     val_1
                          'Z'  (coded by 5)     val_Z
                          'W'  (coded by 6)     val_W
                          'L'  (coded by 7)     val_L
                          'H'  (coded by 8)     val_H
                          '-'  (coded by 9)     val_m
</pre>
<P>
The values val... are given by parameters.</P>
<P>If the signal width is greater than 1 this conversion is done for each signal.
</P>
</HTML>
",     revisions="<HTML>
<ul>
<li><i>September 15, 2004   </i>
       by Christoph Clauss colors changed<br>
       </li>
<li><i>November 5, 2003</i>
       by Christoph Clauss<br>
       initially modelled.</li>
</ul>
</HTML>"),
    Icon(Polygon(points=[-40,40; 40,40; -40,-40; -40,40],      style(
              color=78,
              rgbcolor={127,0,127},
              fillColor=78,
              rgbfillColor={127,0,127})),
                               Polygon(points=[-40,-40; 40,-40; 40,40; -40,-40],
                     style(fillPattern=1)),
          Text(
            extent=[152,-100; -148,-40],
            string="%name",
            style(color=3, rgbcolor={0,0,255})),
          Rectangle(extent=[-40,40; 40,-40], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2))),
        Diagram);
      parameter Integer n(final min=1) = 1 "signal width";
      parameter Real value_U=0.5 "value for digital U (uninitialized)";
      parameter Real value_X=0.5 "value for digital X (Forcing Unknown)";
      parameter Real value_0=0 "value for digital 0   (Forcing 0)";
      parameter Real value_1=1 "value for digital 1 (Forcing 1)";
      parameter Real value_Z=0.5 "value for digital Z (High Impedance)";
      parameter Real value_W=0.5 "value for digital W (Weak    Unknown)";
      parameter Real value_L=0 "value for digital L (Weak    0)";
      parameter Real value_H=1 "value for digital H (Weak    1)";
      parameter Real value_m=0.5 "value for digital m (Don´t care)";
    equation 
      for i in 1:n loop
       y[i]= if x[i] == L.'U' then value_U else 
                if x[i] == L.'X' then value_X else if 
          x[i] == L.'0' then value_0 else if x[i] == L.'1' then 
               value_1 else if x[i] == L.
          'Z' then value_Z else if x[i] == L.'W' then value_W else 
                if x[i] == L.'L' then value_L else if 
          x[i] == L.'H' then value_H else value_m;
      end for;
    end LogicToReal;
    
    annotation (Icon(
        Rectangle(extent=[-100,-100; 80,50],   style(fillColor=30,
              fillPattern=
                1)),
        Polygon(points=[-100,50; -80,70; 100,70; 80,50; -100,50],      style(
              fillColor=30, fillPattern=1)),
        Polygon(points=[100,70; 100,-80; 80,-100; 80,50; 100,70],      style(
              fillColor=30, fillPattern=1)),
        Text(
          extent=[-85,35; 65,-85],
          string="Library",
          style(color=3)),
        Text(
          extent=[-120,122; 120,73],
          string="%name",
          style(color=1))), Documentation(info="<html>
 
</html>"));
  end Converters;
  
end Digital;
