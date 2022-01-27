within Modelica.Electrical;
package Digital
  "Library for digital electrical components based on the VHDL standard with 9-valued logic and conversion to 2-,3-,4-valued logic"
  extends Modelica.Icons.Package;

    package UsersGuide "User's Guide"
      extends Modelica.Icons.Information;

      class ReleaseNotes "Release notes"
          extends Modelica.Icons.ReleaseNotes;

        annotation (Documentation(info="<html>
<h4>Version 1.0.8, 2009-10-01</h4>
<ul>
<li>Package Register with Flip-Flops and Latches added</li>
<li>InertialDealySensitiveVector added</li>
</ul>
<h4>Version 1.0.7, 2005-07-01</h4>
<ul>
<li>InertialDelaySensitive improved</li>
<li>Minor errors fixed in basic and delay models (final introduced)</li>
<li>Sources.Pulse rewritten to avoid a warning</li>
<li>Minor errors in default values of sources fixed</li>
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
<li> Known issue: Pulse source causes a warning in Dymola. It is recommended to use DigitalClock source.</li>
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
<li> Simple DigitalClock source added in addition to Pulse source (for convenience reasons).</li>
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
</html>"));
      end ReleaseNotes;

      class Literature "Literature"
          extends Modelica.Icons.References;

        annotation (Documentation(info="<html>
<p>
The Electrical.Digital library is based on the following references:
</p>
<dl>
<dt>Ashenden, P. J.:</dt>
<dd> <strong>The Designer's Guide to VHDL.</strong> San Francisco: Morgan Kaufmann, 1995, 688 p. ISBN 1-55860-270-4.
     <br>&nbsp;</dd>
</dl>
<dl>
<dt>IEEE 1076-1993:</dt>
<dd> <strong>IEEE Standard VHDL Language Reference Manual (ANSI).</strong> 288 p. ISBN 1-55937-376-8. IEEE Ref. SH16840-NYF.
     <br>&nbsp;</dd>
</dl>
<dl>
<dt>IEEE 1164-1993:</dt>
<dd> <strong>IEEE Standard Multivalue Logic System for VHDL Model Interoperability (Std_logic_1164).</strong> 24 p. ISBN 1-55937-299-0. IEEE Ref. SH16097-NYF.
     <br>&nbsp;</dd>
</dl>
<dl>
<dt>Lipsett, R.; Schaefer, C.; Ussery, C.:</dt>
<dd> <strong>VHDL: Hardware Description and Design.</strong> Boston: Kluwer, 1989, 299 p. ISBN 079239030X.
     <br>&nbsp;</dd>
</dl>
<dl>
<dt>Navabi, Z:</dt>
<dd> <strong>VHDL: Analysis and Modeling of Digital Systems.</strong> New York: McGraw-Hill, 1993, 375 p. ISBN 0070464723.
     <br>&nbsp;</dd>
</dl>
</html>"));

      end Literature;

      class Contact "Contact"
        extends Modelica.Icons.Contact;

        annotation (Documentation(info="<html>
<h4>Main authors</h4>

<dl>
<dt><strong>Christoph Clau&szlig;</strong></dt>
<dd>email: <a href=\"mailto:christoph@clauss-it.com\">christoph@clauss-it.com</a></dd>
<dt><strong>Andr&eacute; Schneider</strong></dt>
<dd>email: <a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a></dd>
<dt><strong>Ulrich Donath</strong></dt>
<dd>email: <a href=\"mailto:Ulrich.Donath@eas.iis.fraunhofer.de\">Ulrich.Donath@eas.iis.fraunhofer.de</a></dd>
</dl>

<dl>
<dt>Address</dt>
<dd>Fraunhofer Institute for Integrated Circuits (IIS)<br>
Design Automation Department (EAS)<br>
Zeunerstra&szlig;e 38<br>
D-01069 Dresden<br>
Germany</dd>
</dl>

<h4>Acknowledgements</h4>

<p>
We thank our students Teresa Schlegel and Enrico Weber for implementing
and carefully testing many models and examples.
</p>
</html>"));

      end Contact;

      annotation (DocumentationClass=true, Documentation(info="<html>
<p>
Library <strong>Electrical.Digital</strong> is a <strong>free</strong> Modelica package providing
components to model <strong>digital</strong> electronic
systems based on combinational and sequential logic in a convenient
way. This package contains the <strong>User's Guide</strong> for
the library and has the following content:
</p>
<ol>
<li><a href=\"modelica://Modelica.Electrical.Digital.UsersGuide.ReleaseNotes\">Release Notes</a>
    summarizes the differences between different versions of this library.</li>
<li><a href=\"modelica://Modelica.Electrical.Digital.UsersGuide.Literature\">Literature</a>
    provides references that have been used to design and implement this
    library.</li>
<li><a href=\"modelica://Modelica.Electrical.Digital.UsersGuide.Contact\">Contact</a>
    provides information about the authors of the library as well as
    acknowledgments.</li>
</ol>
</html>"));
    end UsersGuide;

      package Examples "Examples that demonstrate the usage of the Digital electrical components"
        extends Modelica.Icons.ExamplesPackage;

        model Multiplexer "4 to 1 Bit Multiplexer Example"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends Modelica.Icons.Example;

          D.Sources.DigitalClock CLK(period=20, startTime=0, width=50) annotation (Placement(transformation(
                  extent={{-80,-56},{-60,-36}})));
          D.Sources.Table D0(
            y0=L.'0',
            x={L.'1',L.'0',L.'1',L.'0'},
            t={50,100,145,200}) annotation (Placement(transformation(extent={{-80,58},
                {-60,78}})));
          D.Sources.Table D1(
            y0=L.'0',
            x={L.'1',L.'0',L.'1',L.'0'},
            t={22,140,150,180}) annotation (Placement(transformation(extent={{-80,32},
                {-60,52}})));
          D.Examples.Utilities.MUX4 MUX annotation (Placement(transformation(extent={{-10,0},
                {70,80}})));
          D.Sources.Table D2(
            y0=L.'0',
            x={L.'1',L.'0',L.'1',L.'0'},
            t={22,140,150,180}) annotation (Placement(transformation(extent={{-80,6},
                {-60,26}})));
          D.Sources.Table D3(
            y0=L.'0',
            x={L.'1',L.'0',L.'1',L.'0'},
            t={22,140,150,180}) annotation (Placement(transformation(extent={{-80,-20},
                {-60,0}})));
          D.Examples.Utilities.JKFF FF annotation (Placement(transformation(extent={{-20,-62},
                {0,-42}})));
          D.Sources.Set Enable(x=Modelica.Electrical.Digital.Interfaces.Logic.'1') annotation (Placement(transformation(extent={{-80,-82},
                {-60,-62}})));
        equation
          connect(CLK.y, FF.clk) annotation (Line(
              points={{-60,-46},{-36,-46},{-36,-52},{-20,-52}}, color={127,0,127}));
          connect(Enable.y, FF.k) annotation (Line(
              points={{-60,-72},{-30,-72},{-30,-59},{-20,-59}}, color={127,0,127}));
          connect(Enable.y, FF.j) annotation (Line(
              points={{-60,-72},{-30,-72},{-30,-45},{-20,-45}}, color={127,0,127}));
          connect(CLK.y, MUX.a0) annotation (Line(
              points={{-60,-46},{-36,-46},{-36,22.4},{-10,22.4}}, color={127,0,127}));
          connect(D0.y, MUX.d0) annotation (Line(
              points={{-60,68},{-10,68}}, color={127,0,127}));
          connect(D1.y, MUX.d1) annotation (Line(
              points={{-60,42},{-54,42},{-54,57.6},{-10,57.6}}, color={127,0,127}));
          connect(D2.y, MUX.d2) annotation (Line(
              points={{-60,16},{-50,16},{-50,47.2},{-10,47.2}}, color={127,0,127}));
          connect(D3.y, MUX.d3) annotation (Line(
              points={{-60,-10},{-46,-10},{-46,36.8},{-10,36.8}}, color={127,0,127}));
          connect(FF.q, MUX.a1) annotation (Line(
              points={{0,-45},{2,-45},{2,-22},{-20,-22},{-20,12},{-10,12}}, color={127,0,127}));
          annotation (
            Documentation(info="<html>
<p>The multiplexer converts a parallel 4 bit signal in a sequential 1 bit stream. The multiplexer component is composed by basic gates. It can be found in the Utilities subpackage. The example is designed to test and demonstrate the basic gate components.</p>
</html>"),            experiment(StopTime=250));
        end Multiplexer;

        model FlipFlop "Pulse Triggered Master Slave Flip-Flop"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends Modelica.Icons.Example;

          D.Examples.Utilities.JKFF FF
                         annotation (Placement(transformation(extent={{-10,-40},{70,
                    40}})));
          D.Sources.DigitalClock CLK(period=10, startTime=0, width=50) annotation (Placement(transformation(
                  extent={{-80,-10},{-60,10}})));
          D.Sources.Table J(
            y0=L.'0',
            x={L.'1',L.'0',L.'1',L.'0'},
            t={50,100,145,200}) annotation (Placement(transformation(extent={{-80,
                    18},{-60,38}})));
          D.Sources.Table K(
            y0=L.'0',
            x={L.'1',L.'0',L.'1',L.'0'},
            t={22,140,150,180}) annotation (Placement(transformation(extent={{-80,
                    -38},{-60,-18}})));
        equation
          connect(J.y, FF.j) annotation (Line(
              points={{-60,28},{-10,28}}, color={127,0,127}));
          connect(CLK.y, FF.clk) annotation (Line(
              points={{-60,0},{-10,0}}, color={127,0,127}));
          connect(K.y, FF.k) annotation (Line(
              points={{-60,-28},{-10,-28}}, color={127,0,127}));
          annotation (
            Documentation(info="<html>
<p>A pulse-triggered master-slave flip-flop is demonstrated. The flipflop component is composed by basic gates. It can be found in the Utilities subpackage. The example is designed to test and demonstrate the basic gate components.</p>
</html>"),            experiment(StopTime=250));
        end FlipFlop;

        model HalfAdder "Adding circuit for binary numbers without input carry bit"
          import Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends Modelica.Icons.Example;

          Modelica.Electrical.Digital.Sources.Table a(
            t={1,2,3,4},
            x={L.'1',L.'0',L.'1',L.'0'},
            y0=L.'0') annotation (Placement(transformation(extent={{-80,18},{-60,38}})));
          Modelica.Electrical.Digital.Sources.Table b(
            x={L.'1',L.'0'},
            t={2,4},
            y0=L.'0') annotation (Placement(transformation(extent={{-80,-38},{-60,-18}})));
          Modelica.Electrical.Digital.Examples.Utilities.HalfAdder Adder(delayTime=0.3, AND(G2(
                                                                                        y(       start=L.'U', fixed=true))),
        XOR(G2(                                                                                                    y(       start=L.'U', fixed=true))))
                                annotation (Placement(transformation(extent={{-40,
                    -40},{40,40}})));
          Modelica.Electrical.Digital.Converters.LogicToReal s(
        n=1,
        value_U=0.5,
        value_X=0.5,
        value_0=0,
        value_1=1,
        value_Z=0.5,
        value_W=0.5,
        value_L=0,
        value_H=1,
        value_m=0.5) annotation (Placement(transformation(extent={{60,
                    18},{80,38}})));
          Modelica.Electrical.Digital.Converters.LogicToReal c(
        n=1,
        value_U=0.5,
        value_X=0.5,
        value_0=0,
        value_1=1,
        value_Z=0.5,
        value_W=0.5,
        value_L=0,
        value_H=1,
        value_m=0.5) annotation (Placement(transformation(extent={{60,
                    -38},{80,-18}})));
        equation
          connect(b.y,Adder. b) annotation (Line(
              points={{-60,-28},{-40,-28}}, color={127,0,127}));
          connect(a.y,Adder. a) annotation (Line(
              points={{-60,28},{-40,28}}, color={127,0,127}));
          connect(Adder.s, s.x[1]) annotation (Line(points={{40,28},{65,28}}, color={127,0,127}));
          connect(Adder.c, c.x[1]) annotation (Line(points={{40,-28},{65,-28}}, color={127,0,127}));
          annotation (
            Documentation(info="<html>
<p>
This example demonstrates an adding circuit for binary numbers, which internally realizes the interconnection to
And and to Xor in the final sum.</p>
<br>
<br>
1 + 0 = 1<br>
0 + 1 = 1<br>
1 + 1 = 10<br>
0 + 0 = 0
<br>
<br>
<strong>a</strong> + <strong>b</strong> = <strong>s</strong>
<br>(The carry of this adding is <strong>c</strong>.)
<br>
<br>and
<br>
<br>
<strong>a</strong> * <strong>b</strong> = <strong>s</strong>
<br>  (It is an interconnection to And.)
<br>
<br>
<strong>a</strong> * <strong>b</strong> + <strong>a</strong> * <strong>b</strong> = <strong>a</strong> Xor <strong>b</strong> = <strong>c</strong>
<br>(It is an interconnection to Xor.)
<br>
<blockquote><pre>
<strong>a</strong>     <strong>b</strong>     <strong>c</strong>      <strong>s</strong>     <strong>t</strong>

1     0     1      0     1
0     1     1      0     2
1     1     0      1     3
0     0     0      0     4
</pre></blockquote>
<p>
<strong>t</strong> is the pick-up instant of the next bit(s) in the simulation.
The simulation stop time should be 5 seconds.
</p>
</html>"),            experiment(StopTime=5));
        end HalfAdder;

        model FullAdder "Full 1 Bit Adder Example"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends Modelica.Icons.Example;

          D.Examples.Utilities.FullAdder Adder1 annotation (Placement(
                transformation(extent={{0,-30},{60,30}})));
          D.Converters.LogicToReal s(value_0=0, value_1=1, value_H=1, value_L=0, value_m=0.5, value_U=0.5, value_W=0.5, value_X=0.5, value_Z=0.5, n=1)
                                   annotation (Placement(transformation(extent={{70,
                    12},{90,32}})));
          D.Converters.LogicToReal c_out(value_0=0, value_1=1, value_H=1, value_L=0, value_m=0.5, value_U=0.5, value_W=0.5, value_X=0.5, value_Z=0.5, n=1)
                                       annotation (Placement(transformation(extent=
                    {{70,-32},{90,-12}})));
          D.Examples.Utilities.Counter3 Counter
            annotation (Placement(transformation(extent={{-60,-18},{-20,22}})));
          D.Sources.Set Enable(x=L.'1') annotation (Placement(transformation(
                  extent={{-90,6},{-70,26}})));
          D.Sources.DigitalClock CLK(period=1, startTime=0, width=50) annotation (Placement(transformation(extent={{
                    -90,-22},{-70,-2}})));
        equation
          connect(Adder1.s, s.x[1])
                                   annotation (Line(points={{60.3,21},{68,21},{68,
                  22},{75,22}}, color={127,0,127}));
          connect(Adder1.c_out, c_out.x[1])
                                           annotation (Line(points={{60,-21},{68,
                  -21},{68,-22},{75,-22}}, color={127,0,127}));
          connect(CLK.y, Counter.count) annotation (Line(points={{-70,-12},{-60,-12}}, color={127,0,127}));
          connect(Enable.y, Counter.enable) annotation (Line(points={{-70,16},{-60,
                  16}}, color={127,0,127}));
          connect(Counter.q2, Adder1.a) annotation (Line(points={{-20,16},{-10,16},
                  {-10,21},{0,21}}, color={127,0,127}));
          connect(Counter.q1, Adder1.b) annotation (Line(points={{-20,2},{-10,2},{
                  -10,9},{0,9}}, color={127,0,127}));
          connect(Counter.q0, Adder1.c_in) annotation (Line(points={{-20,-12},{-10,
                  -12},{-10,-21},{0,-21}}, color={127,0,127}));
          annotation (
            Documentation(info="<html>
<p>
<br>It is an adding circuit for binary numbers with input carry bit, which consists of two HalfAdders.
<br>
<br>
<strong>a</strong>.y, <strong>b</strong>.y and <strong>c</strong>.y are the inputs of the FullAdder.
<br>
<strong>c</strong>out = <strong>Or1</strong>.y and <strong>h</strong>.s are the outputs of the FullAdder.
<br>
<br>
<strong>t</strong> is the pick-up instant of the next bit(s) in the simulation.</p>
<blockquote><pre>
<strong>a</strong>.y      <strong>b</strong>.y     <strong>c</strong>.y      <strong>c</strong>out       <strong>h</strong>.s        <strong>t</strong>

1        0        0        0          1        1
0        1        0        0          1        2
0        0        1        0          1        3
1        1        0        1          0        4
0        1        1        1          0        5
1        0        1        1          0        6
1        1        1        1          1        7
0        0        0        0          0        8
</pre></blockquote>
<p>
The simulation stop time should be 10 seconds.
</p>
</html>"),            experiment(StopTime=10));
        end FullAdder;

        model Adder4 "4 Bit Adder Example"
          import Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;

          extends Modelica.Icons.Example;

          Modelica.Electrical.Digital.Sources.Table b4(
            y0=L.'0',
            x={L.'1',L.'0'},
            t={1,3}) annotation (Placement(transformation(extent={{70,-20},{110,20}})));
          Modelica.Electrical.Digital.Sources.Table b1(
            x={L.'1',L.'0',L.'1'},
            y0=L.'0',
            t={1,2,3}) annotation (Placement(transformation(extent={{-170,-20},{
                    -130,20}})));
          Modelica.Electrical.Digital.Sources.Table b2(
            y0=L.'0',
            x={L.'1'},
            t={4}) annotation (Placement(transformation(extent={{-90,-20},{-50,20}})));
          Modelica.Electrical.Digital.Sources.Table b3(
            y0=L.'0',
            x={L.'1'},
            t={1}) annotation (Placement(transformation(extent={{-10,-20},{30,20}})));
          Modelica.Electrical.Digital.Sources.Table a1(
            y0=L.'0',
            x={L.'1',L.'0',L.'1'},
            t={1,2,3}) annotation (Placement(transformation(extent={{-170,40},{-130,
                    80}})));
          Modelica.Electrical.Digital.Sources.Table a2(
            y0=L.'0',
            x={L.'1'},
            t={1}) annotation (Placement(transformation(extent={{-90,40},{-50,80}})));
          Modelica.Electrical.Digital.Sources.Table a3(
            y0=L.'0',
            x={L.'1',L.'0'},
            t={1,4}) annotation (Placement(transformation(extent={{-8,40},{30,80}})));
          Modelica.Electrical.Digital.Sources.Table a4(
            y0=L.'0',
            x={L.'0'},
            t={1}) annotation (Placement(transformation(extent={{70,40},{110,80}})));
          Modelica.Electrical.Digital.Sources.Set Set(x=L.'0')
            annotation (Placement(transformation(
                origin={-150,-74},
                extent={{20,20},{-20,-20}},
                rotation=180)));
          Modelica.Electrical.Digital.Examples.Utilities.FullAdder Adder1(Adder1(AND(G2(
                                                                          y(      start=L.'U', fixed=true))),XOR(G2(y(start=L.'U', fixed=true)))),Adder2(AND(G2(
                                                                          y(      start=L.'U', fixed=true))),XOR(G2(y(start=L.'U', fixed=true)))))
                                       annotation (Placement(transformation(extent=
                    {{-100,-80},{-60,-40}})));
          Modelica.Electrical.Digital.Examples.Utilities.FullAdder Adder2(Adder1(AND(G2(
                                                                          y(      start=L.'U', fixed=true))),XOR(G2(y(start=L.'U', fixed=true)))),Adder2(AND(G2(
                                                                          y(      start=L.'U', fixed=true))),XOR(G2(y(start=L.'U', fixed=true)))))
                                      annotation (Placement(transformation(extent={
                    {-20,-80},{20,-40}})));
          Modelica.Electrical.Digital.Examples.Utilities.FullAdder Adder3(Adder1(AND(G2(
                                                                          y(      start=L.'U', fixed=true))),XOR(G2(y(start=L.'U', fixed=true)))),Adder2(AND(G2(
                                                                          y(      start=L.'U', fixed=true))),XOR(G2(y(start=L.'U', fixed=true)))))
                                      annotation (Placement(transformation(extent={
                    {60,-80},{100,-40}})));
          Modelica.Electrical.Digital.Examples.Utilities.FullAdder Adder4(Adder1(AND(G2(
                                                                          y(      start=L.'U', fixed=true))),XOR(G2(y(start=L.'U', fixed=true)))),Adder2(AND(G2(
                                                                          y(      start=L.'U', fixed=true))),XOR(G2(y(start=L.'U', fixed=true)))))
                                      annotation (Placement(transformation(extent={
                    {140,-80},{180,-40}})));
        equation
          connect(b1.y, Adder1.b) annotation (Line(
              points={{-130,0},{-120,0},{-120,-54},{-100,-54}}, color={127,0,127}));
          connect(a1.y, Adder1.a) annotation (Line(
              points={{-130,60},{-110,60},{-110,-46},{-100,-46}}, color={127,0,127}));
          connect(Set.y, Adder1.c_in) annotation (Line(
              points={{-130,-74},{-100,-74}}, color={127,0,127}));
          connect(Adder1.c_out, Adder2.c_in) annotation (Line(
              points={{-60,-74},{-20,-74}}, color={127,0,127}));
          connect(Adder2.c_out, Adder3.c_in) annotation (Line(
              points={{20,-74},{60,-74}}, color={127,0,127}));
          connect(Adder3.c_out, Adder4.c_in) annotation (Line(
              points={{100,-74},{140,-74}}, color={127,0,127}));
          connect(b2.y, Adder2.b) annotation (Line(
              points={{-50,0},{-40,0},{-40,-54},{-20,-54}}, color={127,0,127}));
          connect(a2.y, Adder2.a) annotation (Line(
              points={{-50,60},{-30,60},{-30,-46},{-20,-46}}, color={127,0,127}));
          connect(b3.y, Adder3.b) annotation (Line(
              points={{30,0},{40,0},{40,-54},{60,-54}}, color={127,0,127}));
          connect(a3.y, Adder3.a) annotation (Line(
              points={{30,60},{50,60},{50,-46},{60,-46}}, color={127,0,127}));
          connect(b4.y, Adder4.b) annotation (Line(
              points={{110,0},{120,0},{120,-54},{140,-54}}, color={127,0,127}));
          connect(a4.y, Adder4.a) annotation (Line(
              points={{110,60},{130,60},{130,-46},{140,-46}}, color={127,0,127}));
          annotation (
            Diagram(coordinateSystem(extent = {{-200,-100},{200,100}})),
            Documentation(info="<html>
<p>
Four FullAdders are combined to built a four bit adder unit.
</p>
<br>
<br>
In dependence on time five additions are carried out:
<br>
<blockquote><pre>
at t = 0                            at t = 1
 a       0 0 0 0                       a      1 1 1 0
 b    +  0 0 0 0                       b   +  1 0 1 1
 <strong>s     0 0 0 0 0</strong>                      <strong>s     1 0 0 1 0</strong>
at t = 2                             at t = 3
 a       0 1 1 0                       a      1 1 1 0
 b    +  0 0 1 1                       b   +  1 0 1 0
 <strong>s     1 0 1 0 0</strong>                      <strong>s     0 0 0 1 1</strong>

at t = 4
 a      1 1 0 0
 b   +  1 1 1 0
 <strong>s    0 0 1 0 1</strong>
</pre></blockquote>
<p>
To show the influence of delay a large delay time of 0.1s is chosen.
Furthermore, all signals are initialized with U, the uninitialized value.
Please remember, that the nine logic values are coded by the numbers 1,...,9.
The summands a and b can be found at the output signals of the taba and tabb sources.
The result can be seen in the output signals of the FullAdders according to:</p>
<blockquote><pre>
a                    <strong>a4</strong>.y      <strong>a3</strong>.y      <strong>a2</strong>.y      <strong>a1</strong>.y
b                    <strong>b4</strong>.y      <strong>b3</strong>.y      <strong>b2</strong>.y      <strong>b1</strong>.y
sum   <strong>Adder4</strong>.c_out  <strong>Adder4.s</strong>  <strong>Adder3.s</strong>  <strong>Adder2.s</strong>  <strong>Adder1.s</strong>
</pre></blockquote>
<p>The simulation stop time has to be 5s.</p>
</html>"),            experiment(StopTime=5));
        end Adder4;

        model Counter3 "3 Bit Counter Example"
          import D = Modelica.Electrical.Digital;
          extends Modelica.Icons.Example;

          D.Sources.Step Enable(after=D.Interfaces.Logic.'1', before=D.Interfaces.Logic.'0', stepTime=1) annotation (Placement(transformation(extent={
                    {-90,8},{-50,48}})));
          D.Sources.DigitalClock clock(period=1, startTime=0, width=50) annotation (Placement(transformation(extent={
                    {-90,-48},{-50,-8}})));
          D.Examples.Utilities.Counter3 Counter
            annotation (Placement(transformation(extent={{-30,-40},{50,40}})));
        equation
          connect(Enable.y, Counter.enable) annotation (Line(
              points={{-50,28},{-30,28}}, color={127,0,127}));
          connect(clock.y, Counter.count) annotation (Line(
              points={{-50,-28},{-30,-28}}, color={127,0,127}));
          annotation (
            Documentation(info="<html>
<p>The three bit counter example is built up by components of the Utilities package which uses components of the Gates library.</p>
<p>The counter counts the high-low slopes of the clock signal, if the enable signal is set to be true. Otherwise if it is set to zero the counter is not counting.</p>
<p>Plot Counter.count (clock signal), and Counter.enable, and the output bit signals Counter.q0, Counter.q1, and Counter.q2.</p>
</html>"),            experiment(StopTime=10));
        end Counter3;

        model Counter "Generic N Bit Counter Example"
          import D = Modelica.Electrical.Digital;
          extends Modelica.Icons.Example;

          D.Sources.Step Enable(after=D.Interfaces.Logic.'1', before=D.Interfaces.Logic.'0', stepTime=1) annotation (Placement(transformation(extent={
                    {-90,8},{-50,48}})));
          D.Sources.DigitalClock clock(period=1, startTime=0, width=50) annotation (Placement(transformation(extent={
                    {-90,-48},{-50,-8}})));
          D.Examples.Utilities.Counter Counter(n=4)
            annotation (Placement(transformation(extent={{-30,-40},{50,40}})));
          D.Converters.LogicToReal Q0(value_0=0, value_1=1, value_H=1, value_L=0, value_m=0.5, value_U=0.5, value_W=0.5, value_X=0.5, value_Z=0.5, n=1) annotation (Placement(transformation(extent={
                    {66,-40},{86,-20}})));
          D.Converters.LogicToReal Q1(value_0=0, value_1=1, value_H=1, value_L=0, value_m=0.5, value_U=0.5, value_W=0.5, value_X=0.5, value_Z=0.5, n=1) annotation (Placement(transformation(extent={
                    {66,-20},{86,0}})));
          D.Converters.LogicToReal Q2(value_0=0, value_1=1, value_H=1, value_L=0, value_m=0.5, value_U=0.5, value_W=0.5, value_X=0.5, value_Z=0.5, n=1) annotation (Placement(transformation(extent={
                    {66,0},{86,20}})));
          D.Converters.LogicToReal Q3(value_0=0, value_1=1, value_H=1, value_L=0, value_m=0.5, value_U=0.5, value_W=0.5, value_X=0.5, value_Z=0.5, n=1) annotation (Placement(transformation(extent={
                    {66,20},{86,40}})));
        equation
          connect(Enable.y, Counter.enable) annotation (Line(
              points={{-50,28},{-30,28}}, color={127,0,127}));
          connect(clock.y, Counter.count) annotation (Line(
              points={{-50,-28},{-30,-28}}, color={127,0,127}));
          connect(Q0.x[1], Counter.q[1]) annotation (Line(points={{71,-30},{58,-30},
                  {58,-24},{50,-24}}, color={127,0,127}));
          connect(Q1.x[1], Counter.q[2]) annotation (Line(points={{71,-10},{60,-10},
                  {60,-8},{50,-8}}, color={127,0,127}));
          connect(Q2.x[1], Counter.q[3]) annotation (Line(points={{71,10},{60,10},{
                  60,8},{50,8}}, color={127,0,127}));
          connect(Q3.x[1], Counter.q[4]) annotation (Line(points={{71,30},{60,30},{
                  60,24},{50,24}}, color={127,0,127}));
          annotation (
            Documentation(info="<html>
<p>The counter example is built up by components of the Utilities package which uses components of the Gates library. It demonstrates the generic counter model. The parameter n is the number of counting bits. In this example it is set to 4.</p>
<p>The counter counts the high-low slopes of the clock signal, if the enable signal is set to be true. Otherwise if it is set to zero the counter is not counting.</p>
<p>Plot Counter.count (clock signal), and Counter.enable, and the output bit signals Counter.q[0], Counter.q[1], Counter.q[2], and Counter.q[3]</p>
</html>"),            experiment(StopTime=100));
        end Counter;

        model VectorDelay "Vector delay"
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends Modelica.Icons.Example;

          Modelica.Electrical.Digital.Delay.InertialDelaySensitiveVector delay(
            final tHL=1,
            final tLH=2,
            final n=3, inertialDelaySensitive(each y(start=L.'U', fixed=true)))
            annotation (Placement(transformation(extent={{-36,-28},{40,48}})));
          Modelica.Electrical.Digital.Sources.Table table(x={L.'0',L.'1',L.'0', L.'1', L.'0'}, t={0,1,5,7,8})
            annotation (Placement(transformation(extent={{-96,40},{-76,60}})));
          Modelica.Electrical.Digital.Sources.Table table1(x={L.'0',L.'1'}, t={0,1})
            annotation (Placement(transformation(extent={{-96,0},{-76,20}})));
          Modelica.Electrical.Digital.Sources.Table table2(x={L.'0', L.'1', L.'0'}, t={0,1,6})
            annotation (Placement(transformation(extent={{-96,-50},{-76,-30}})));
        equation

          connect(table.y, delay.x[1]) annotation (Line(
              points={{-76,50},{-30.68,50},{-30.68,6.13667}}, color={127,0,127}));
          connect(table1.y, delay.x[2]) annotation (Line(
              points={{-76,10},{-30.68,10},{-30.68,9.81}}, color={127,0,127}));
          connect(table2.y, delay.x[3]) annotation (Line(
              points={{-76,-40},{-30.68,-40},{-30.68,13.4833}}, color={127,0,127}));
          annotation (Documentation(info="<html>
<p>This example is a simple test of the vector valued sensitive delay component. The delay times are chosen different from each other. To examine the results plot both the input vector x and the output vector y.</p>
</html>"),
        experiment(StopTime=10));
        end VectorDelay;

        model DFFREG "Pulse triggered D-Register-Bank, high active reset"
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends Modelica.Icons.Example;

          Modelica.Electrical.Digital.Sources.Table clock(x={L.'0',L.'1',L.'0',L.'1',L.'0',L.'1',L.'0'}, t={0,7,8,10,11,15,16})
            annotation (Placement(transformation(extent={{-86,-32},{-66,-12}})));
          Modelica.Electrical.Digital.Sources.Table data_0(x={L.'1',L.'0'}, t={0,12})
            annotation (Placement(transformation(extent={{-86,8},{-66,28}})));
          Modelica.Electrical.Digital.Sources.Table reset(x={L.'0',L.'1',L.'0'}, t={0,1,2})
            annotation (Placement(transformation(extent={{-86,-70},{-66,-50}})));
          Modelica.Electrical.Digital.Sources.Table data_1(t={0,10}, x={L.'H',L.'X'})
            annotation (Placement(transformation(extent={{-86,40},{-66,60}})));
          Modelica.Electrical.Digital.Registers.DFFREG dFFREG(
            n=2,
            tHL=5,
            tLH=6,
            delay( inertialDelaySensitive(each y(start=L.'U', fixed=true))),
        dFFR(                                                            clock(     start=L.'U', fixed=true), reset(     start=L.'U',fixed=true)))
            annotation (Placement(transformation(extent={{-24,-26},{70,68}})));

        equation
          connect(clock.y, dFFREG.clock) annotation (Line(
              points={{-66,-22},{-46,-22},{-46,11.6},{-20.24,11.6}}, color={127,0,127}));
          connect(reset.y, dFFREG.reset) annotation (Line(
              points={{-66,-60},{-20.24,-60},{-20.24,-7.2}}, color={127,0,127}));
          connect(data_0.y, dFFREG.dataIn[1]) annotation (Line(
              points={{-66,18},{-44,18},{-44,37.92},{-20.24,37.92}}, color={127,0,127}));
          connect(data_1.y, dFFREG.dataIn[2]) annotation (Line(
              points={{-66,50},{-44,50},{-44,41.68},{-20.24,41.68}}, color={127,0,127}));
          annotation (experiment(StopTime=25),
        Documentation(info="<html>
<p>This example is a simple test of the Registers.DFFREG component. The data width is set to two. After simulation plot both the dataIn and the dataOut vectors. To verify the results compare the truth table which is documented in the DFFREG component.</p>
</html>"));
        end DFFREG;

        model DFFREGL "Pulse triggered D-Register-Bank, low active reset"
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends Modelica.Icons.Example;

          Modelica.Electrical.Digital.Sources.Table clock(x={L.'0',L.'1',L.'0',L.'1',L.'0',L.'1',L.'0'}, t={0,7,8,10,11,15,16})
            annotation (Placement(transformation(extent={{-86,-30},{-66,-10}})));
          Modelica.Electrical.Digital.Sources.Table data_0(x={L.'1',L.'0'}, t={0,12})
            annotation (Placement(transformation(extent={{-88,10},{-68,30}})));
          Modelica.Electrical.Digital.Sources.Table reset(t={0,1,2}, x={L.'1',L.'0',L.'1'})
            annotation (Placement(transformation(extent={{-86,-70},{-66,-50}})));
          Modelica.Electrical.Digital.Sources.Table data_1(t={0,10}, x={L.'H',L.'X'})
            annotation (Placement(transformation(extent={{-86,40},{-66,60}})));
          Modelica.Electrical.Digital.Registers.DFFREGL dFFREGL(
            n=2,
            tHL=5,
            tLH=6,delay(inertialDelaySensitive(each y(start=L.'U', fixed=true))),
        dFFR(                                                                 clock(     start=L.'U', fixed=true), reset(     start=L.'U', fixed=true)))
            annotation (Placement(transformation(extent={{-41,-39},{62,65}})));
        equation

          connect(reset.y, dFFREGL.reset) annotation (Line(
              points={{-66,-60},{-36.88,-60},{-36.88,-18.2}}, color={127,0,127}));
          connect(clock.y, dFFREGL.clock) annotation (Line(
              points={{-66,-20},{-62,-20},{-62,2.6},{-36.88,2.6}}, color={127,0,127}));
          connect(data_0.y, dFFREGL.dataIn[1]) annotation (Line(
              points={{-68,20},{-52,20},{-52,31.72},{-36.88,31.72}}, color={127,0,127}));
          connect(data_1.y, dFFREGL.dataIn[2]) annotation (Line(
              points={{-66,50},{-52,50},{-52,35.88},{-36.88,35.88}}, color={127,0,127}));
          annotation (experiment(StopTime=25),
        Documentation(info="<html>
<p>This example is a simple test of the Registers.DFFREGL component. The data width is set to two. After simulation plot both the dataIn and the dataOut vectors. To verify the results compare the truth table which is documented in the DFFREGL component.</p>
</html>"));
        end DFFREGL;

        model DFFREGSRH "Pulse triggered D-Register-Bank, high active set and reset"
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends Modelica.Icons.Example;

          Modelica.Electrical.Digital.Sources.Table clock(x={L.'0',L.'1',L.'0'}, t={0,10,11})
            annotation (Placement(transformation(extent={{-86,-32},{-66,-12}})));
          Modelica.Electrical.Digital.Sources.Table data_0(x={L.'W'}, t={0})
            annotation (Placement(transformation(extent={{-86,8},{-66,28}})));
          Modelica.Electrical.Digital.Sources.Table reset(x={L.'0',L.'1',L.'0'}, t={0,1,2})
            annotation (Placement(transformation(extent={{-86,-70},{-66,-50}})));
          Modelica.Electrical.Digital.Sources.Table data_1(x={L.'0'}, t={0})
            annotation (Placement(transformation(extent={{-86,40},{-66,60}})));
          Modelica.Electrical.Digital.Sources.Table set(x={L.'0',L.'1',L.'0'}, t={0,5,6})
            annotation (Placement(transformation(extent={{-86,74},{-66,94}})));
          Modelica.Electrical.Digital.Registers.DFFREGSRH dFFREGSRH(
            tHL=2,
            tLH=3,
            n=2)
            annotation (Placement(transformation(extent={{-34,-37},{73,71}})));
        equation

          connect(clock.y, dFFREGSRH.clock) annotation (Line(
              points={{-66,-22},{-50,-22},{-50,6.2},{-29.72,6.2}}, color={127,0,127}));
          connect(set.y, dFFREGSRH.set) annotation (Line(
              points={{-66,84},{-48,84},{-48,60.2},{-29.72,60.2}}, color={127,0,127}));
          connect(reset.y, dFFREGSRH.reset) annotation (Line(
              points={{-66,-60},{-29.72,-60},{-29.72,-15.4}}, color={127,0,127}));
          connect(data_0.y, dFFREGSRH.dataIn[1]) annotation (Line(
              points={{-66,18},{-48,18},{-48,36.44},{-29.72,36.44}}, color={127,0,127}));
          connect(data_1.y, dFFREGSRH.dataIn[2]) annotation (Line(
              points={{-66,50},{-48,50},{-48,40.76},{-29.72,40.76}}, color={127,0,127}));
          annotation (experiment(StopTime=15),
        Documentation(info="<html>
<p>This example is a simple test of the Registers.DFFREGSRH component. The data width is set to two. After simulation plot both the dataIn and the dataOut vectors. To verify the results compare the truth table which is documented in the DFFREGSRH component.</p>
</html>"));
        end DFFREGSRH;

        model DFFREGSRL "Pulse triggered D-Register-Bank, low active set and reset"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends Modelica.Icons.Example;

          Modelica.Electrical.Digital.Sources.Table clock(x={L.'0',L.'1',L.'0'}, t={0,10,11})
            annotation (Placement(transformation(extent={{-86,-32},{-66,-12}})));
          Modelica.Electrical.Digital.Sources.Table data_0(x={L.'W'}, t={0})
            annotation (Placement(transformation(extent={{-86,8},{-66,28}})));
          Modelica.Electrical.Digital.Sources.Table reset(t={0,1,2}, x={L.'1',L.'0',L.'1'})
            annotation (Placement(transformation(extent={{-86,-70},{-66,-50}})));
          Modelica.Electrical.Digital.Sources.Table data_1(x={L.'0'}, t={0})
            annotation (Placement(transformation(extent={{-86,40},{-66,60}})));
          Modelica.Electrical.Digital.Sources.Table set(t={0,5,6}, x={L.'1',L.'0',L.'1'})
            annotation (Placement(transformation(extent={{-86,74},{-66,94}})));
          Modelica.Electrical.Digital.Registers.DFFREGSRL dFFREGSRL(
            tHL=2,
            tLH=3,
            n=2) annotation (Placement(transformation(extent={{-45,-54},{81,72}})));
        equation
          connect(reset.y, dFFREGSRL.reset) annotation (Line(
              points={{-66,-60},{-39.96,-60},{-39.96,-28.8}}, color={127,0,127}));
          connect(clock.y, dFFREGSRL.clock) annotation (Line(
              points={{-66,-22},{-56,-22},{-56,-3.6},{-39.96,-3.6}}, color={127,0,127}));
          connect(set.y, dFFREGSRL.set) annotation (Line(
              points={{-66,84},{-39.96,84},{-39.96,59.4}}, color={127,0,127}));
          connect(data_0.y, dFFREGSRL.dataIn[1]) annotation (Line(
              points={{-66,18},{-56,18},{-56,31.68},{-39.96,31.68}}, color={127,0,127}));
          connect(data_1.y, dFFREGSRL.dataIn[2]) annotation (Line(
              points={{-66,50},{-56,50},{-56,36.72},{-39.96,36.72}}, color={127,0,127}));
          annotation (experiment(StopTime=15),
        Documentation(info="<html>
<p>This example is a simple test of the Registers.DFFREGSRL component. The data width is set to two. After simulation plot both the dataIn and the dataOut vectors. To verify the results compare the truth table which is documented in the DFFREGSRL component.</p>
</html>"));
        end DFFREGSRL;

        model DLATREG "Level sensitive D-Register-Bank, high active reset"
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends Modelica.Icons.Example;

          Modelica.Electrical.Digital.Sources.Table enable(x={L.'0',L.'1',L.'0'}, t={0,10,18})
            annotation (Placement(transformation(extent={{-86,-32},{-66,-12}})));
          Modelica.Electrical.Digital.Sources.Table data_0(x={L.'W',L.'1'}, t={0,15})
            annotation (Placement(transformation(extent={{-86,8},{-66,28}})));
          Modelica.Electrical.Digital.Sources.Table reset(x={L.'0',L.'1',L.'0',L.'1',L.'0'}, t={0,1,2,20,21})
            annotation (Placement(transformation(extent={{-86,-70},{-66,-50}})));
          Modelica.Electrical.Digital.Sources.Table data_1(x={L.'0',L.'1'}, t={0,16})
            annotation (Placement(transformation(extent={{-86,40},{-66,60}})));
          Modelica.Electrical.Digital.Registers.DLATREG dLATREG(
            n=2,
            tHL=2,
            tLH=3, delay(inertialDelaySensitive(each y( start=L.'U', fixed=true))))
            annotation (Placement(transformation(extent={{-45,-50},{84,79}})));
        equation

          connect(reset.y, dLATREG.reset) annotation (Line(
              points={{-66,-60},{-39.84,-60},{-39.84,-24.2}}, color={127,0,127}));
          connect(enable.y, dLATREG.enable) annotation (Line(
              points={{-66,-22},{-56,-22},{-56,1.6},{-39.84,1.6}}, color={127,0,127}));
          connect(data_0.y, dLATREG.dataIn[1]) annotation (Line(
              points={{-66,18},{-56,18},{-56,37.72},{-39.84,37.72}}, color={127,0,127}));
          connect(data_1.y, dLATREG.dataIn[2]) annotation (Line(
              points={{-66,50},{-56,50},{-56,42.88},{-39.84,42.88}}, color={127,0,127}));
          annotation (experiment(StopTime=25),
        Documentation(info="<html>
<p>This example is a simple test of the Registers.DLATREG component. The data width is set to two. After simulation plot both the dataIn and the dataOut vectors. To verify the results compare the truth table which is documented in the DLATREG component.</p>
</html>"));
        end DLATREG;

        model DLATREGL "Level sensitive D-Register-Bank, low active reset"
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends Modelica.Icons.Example;

          Modelica.Electrical.Digital.Sources.Table enable(x={L.'0',L.'1',L.'0'}, t={0,10,18})
            annotation (Placement(transformation(extent={{-86,-32},{-66,-12}})));
          Modelica.Electrical.Digital.Sources.Table data_0(x={L.'W',L.'1'}, t={0,15})
            annotation (Placement(transformation(extent={{-86,8},{-66,28}})));
          Modelica.Electrical.Digital.Sources.Table reset(t={0,1,2,20,21}, x={L.'1',L.'0',L.'1',L.'0',L.'1'})
            annotation (Placement(transformation(extent={{-86,-70},{-66,-50}})));
          Modelica.Electrical.Digital.Sources.Table data_1(x={L.'0',L.'1'}, t={0,16})
            annotation (Placement(transformation(extent={{-86,40},{-66,60}})));
          Modelica.Electrical.Digital.Registers.DLATREGL dLATREGL(
            tHL=2,
            tLH=3,
            n=2, delay(inertialDelaySensitive(each y(start=L.'U', fixed=true)))) annotation (Placement(transformation(extent={{-45,-50},{84,79}})));
        equation

          connect(reset.y, dLATREGL.reset) annotation (Line(
              points={{-66,-60},{-39.84,-60},{-39.84,-24.2}}, color={127,0,127}));
          connect(enable.y, dLATREGL.enable) annotation (Line(
              points={{-66,-22},{-54,-22},{-54,1.6},{-39.84,1.6}}, color={127,0,127}));
          connect(data_0.y, dLATREGL.dataIn[1]) annotation (Line(
              points={{-66,18},{-56,18},{-56,37.72},{-39.84,37.72}}, color={127,0,127}));
          connect(data_1.y, dLATREGL.dataIn[2]) annotation (Line(
              points={{-66,50},{-56,50},{-56,42.88},{-39.84,42.88}}, color={127,0,127}));
          annotation (experiment(StopTime=25),
        Documentation(info="<html>
<p>This example is a simple test of the Registers.DLATREGL component. The data width is set to two. After simulation plot both the dataIn and the dataOut vectors. To verify the results compare the truth table which is documented in the DLATREGL component.</p>
</html>"));
        end DLATREGL;

        model DLATREGSRH "Level sensitive D-Register-Bank, high active set and reset"
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends Modelica.Icons.Example;

          Modelica.Electrical.Digital.Sources.Table enable(x={L.'0',L.'1',L.'0'}, t={0,10,18})
            annotation (Placement(transformation(extent={{-86,-32},{-66,-12}})));
          Modelica.Electrical.Digital.Sources.Table data_0(x={L.'W',L.'1'}, t={0,15})
            annotation (Placement(transformation(extent={{-86,8},{-66,28}})));
          Modelica.Electrical.Digital.Sources.Table reset(x={L.'0',L.'1',L.'0',L.'1',L.'0'}, t={0,1,2,20,21})
            annotation (Placement(transformation(extent={{-86,-70},{-66,-50}})));
          Modelica.Electrical.Digital.Sources.Table data_1(x={L.'0',L.'1'}, t={0,16})
            annotation (Placement(transformation(extent={{-86,40},{-66,60}})));
          Modelica.Electrical.Digital.Sources.Table set(x={L.'0',L.'1',L.'0'}, t={0,5,6})
            annotation (Placement(transformation(extent={{-86,74},{-66,94}})));
          Modelica.Electrical.Digital.Registers.DLATREGSRH dLATREGSRH(
            tHL=2,
            tLH=3,
            n=2, delay(inertialDelaySensitive(each y(start=L.'U', fixed=true)))) annotation (Placement(transformation(extent={{-45,-42},{69,71}})));
        equation

          connect(reset.y, dLATREGSRH.reset) annotation (Line(
              points={{-66,-60},{-40.44,-60},{-40.44,-19.4}}, color={127,0,127}));
          connect(enable.y, dLATREGSRH.enable) annotation (Line(
              points={{-66,-22},{-52,-22},{-52,3.2},{-40.44,3.2}}, color={127,0,127}));
          connect(data_0.y, dLATREGSRH.dataIn[1]) annotation (Line(
              points={{-66,18},{-52,18},{-52,34.84},{-40.44,34.84}}, color={127,0,127}));
          connect(data_1.y, dLATREGSRH.dataIn[2]) annotation (Line(
              points={{-66,50},{-52,50},{-52,39.36},{-40.44,39.36}}, color={127,0,127}));
          connect(set.y, dLATREGSRH.set) annotation (Line(
              points={{-66,84},{-40.44,84},{-40.44,59.7}}, color={127,0,127}));

          annotation (experiment(StopTime=25),
        Documentation(info="<html>
<p>This example is a simple test of the Registers.DLATREGSRH component. The data width is set to two. After simulation plot both the dataIn and the dataOut vectors. To verify the results compare the truth table which is documented in the DLATREGSRH component.</p>
</html>"));
        end DLATREGSRH;

        model DLATREGSRL "Level sensitive D-Register-Bank, low active set and reset"
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends Modelica.Icons.Example;

          Modelica.Electrical.Digital.Sources.Table enable(t={0,10,18}, x={L.'0',L.'1',L.'0'})
            annotation (Placement(transformation(extent={{-86,-32},{-66,-12}})));
          Modelica.Electrical.Digital.Sources.Table data_0(x={L.'W',L.'1'}, t={0,15})
            annotation (Placement(transformation(extent={{-86,8},{-66,28}})));
          Modelica.Electrical.Digital.Sources.Table reset(t={0,1,2,20,21}, x={L.'1',L.'0',L.'1',L.'0',L.'1'})
            annotation (Placement(transformation(extent={{-86,-70},{-66,-50}})));
          Modelica.Electrical.Digital.Sources.Table data_1(x={L.'0',L.'1'}, t={0,16})
            annotation (Placement(transformation(extent={{-86,40},{-66,60}})));
          Modelica.Electrical.Digital.Sources.Table set(t={0,5,6}, x={L.'1',L.'0',L.'1'})
            annotation (Placement(transformation(extent={{-86,74},{-66,94}})));
          Modelica.Electrical.Digital.Registers.DLATREGSRL dLATREGSRL(
            tHL=2,
            tLH=3,
            n=2, delay(inertialDelaySensitive(each y(start=L.'U',fixed=true)))) annotation (Placement(transformation(extent={{-45,-43},{69,71}})));
        equation

          connect(reset.y, dLATREGSRL.reset) annotation (Line(
              points={{-66,-60},{-40.44,-60},{-40.44,-20.2}}, color={127,0,127}));
          connect(enable.y, dLATREGSRL.enable) annotation (Line(
              points={{-66,-22},{-56,-22},{-56,2.6},{-40.44,2.6}}, color={127,0,127}));
          connect(data_0.y, dLATREGSRL.dataIn[1]) annotation (Line(
              points={{-66,18},{-56,18},{-56,34.52},{-40.44,34.52}}, color={127,0,127}));
          connect(data_1.y, dLATREGSRL.dataIn[2]) annotation (Line(
              points={{-66,50},{-56,50},{-56,39.08},{-40.44,39.08}}, color={127,0,127}));
          connect(set.y, dLATREGSRL.set) annotation (Line(
              points={{-66,84},{-40.44,84},{-40.44,59.6}}, color={127,0,127}));
          annotation (experiment(StopTime=25),
        Documentation(info="<html>
<p>This example is a simple test of the Registers.DLATREGSRL component. The data width is set to two. After simulation plot both the dataIn and the dataOut vectors. To verify the results compare the truth table which is documented in the DLATREGSRL component.</p>
</html>"));
        end DLATREGSRL;

        model NXFER "Functionality test of NXFERGATE"
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends Modelica.Icons.Example;
          Modelica.Electrical.Digital.Sources.Table e_table(
        y0=Modelica.Electrical.Digital.Interfaces.Logic.'U',
        x={L.'0',L.'1',L.'Z'},
        t={0,5,9})
            annotation (Placement(transformation(extent={{-75,30},{-55,50}})));
          Modelica.Electrical.Digital.Sources.Table x_table(
        y0=Modelica.Electrical.Digital.Interfaces.Logic.'U',
        x={L.'1',L.'0'},
        t={1,7})
            annotation (Placement(transformation(extent={{-75,-20},{-55,0}})));
          Modelica.Electrical.Digital.Tristates.NXFERGATE nXFERGATE(
                                            tHL=1, tLH=1)
            annotation (Placement(transformation(extent={{-40,-52},{52,41}})));
        equation

          connect(x_table.y, nXFERGATE.x) annotation (Line(
              points={{-55,-10},{-45.2,-10},{-45.2,-10.15},{-35.4,-10.15}}, color={127,0,127}));
          connect(e_table.y, nXFERGATE.enable) annotation (Line(
              points={{-55,40},{-35.4,40},{-35.4,27.05}}, color={127,0,127}));
          annotation (experiment(StopTime=12),
            Documentation(info="<html>
<p>This example is a simple test of the Tristates.NXFERGATE component.</p>
</html>"));
        end NXFER;

        model NRXFER "Functionality test of NRXFERGATE"
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends Modelica.Icons.Example;

          Modelica.Electrical.Digital.Sources.Table e_table(
        y0=Modelica.Electrical.Digital.Interfaces.Logic.'U',
        x={L.'0',L.'1',L.'Z'},
        t={0,5,9})
            annotation (Placement(transformation(extent={{-75,30},{-55,50}})));
          Modelica.Electrical.Digital.Sources.Table x_table(
        y0=Modelica.Electrical.Digital.Interfaces.Logic.'U',
        x={L.'1',L.'0'},
        t={1,7})
            annotation (Placement(transformation(extent={{-75,-20},{-55,0}})));
          Modelica.Electrical.Digital.Tristates.NRXFERGATE nRXFERGATE(
                                              tHL=1, tLH=1)
            annotation (Placement(transformation(extent={{-40,-54},{58,44}})));
        equation
          connect(x_table.y, nRXFERGATE.x) annotation (Line(
              points={{-55,-10},{-45.05,-10},{-45.05,-9.9},{-35.1,-9.9}}, color={127,0,127}));
          connect(e_table.y, nRXFERGATE.enable) annotation (Line(
              points={{-55,40},{-35.1,40},{-35.1,29.3}}, color={127,0,127}));
          annotation (experiment(StopTime=12),
            Documentation(info="<html>
<p>This example is a simple test of the Tristates.NRXFER component.  After simulation until 12 s plot x, enable, and y of the <code>nRXFERGATE </code>component. To verify the result compare to the truth table <code>NRXferTable</code>.</p>
</html>"));
        end NRXFER;

        model BUF3S "Functionality test of BUF3S"
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends Modelica.Icons.Example;
          Modelica.Electrical.Digital.Sources.Table e_table(
        y0=Modelica.Electrical.Digital.Interfaces.Logic.'U',
        x={L.'0',L.'1',L.'Z'},
        t={0,5,9})
            annotation (Placement(transformation(extent={{-75,30},{-55,50}})));
          Modelica.Electrical.Digital.Sources.Table x_table(
        y0=Modelica.Electrical.Digital.Interfaces.Logic.'U',
        x={L.'1',L.'0'},
        t={1,7})
            annotation (Placement(transformation(extent={{-75,-20},{-55,0}})));
          Modelica.Electrical.Digital.Tristates.BUF3S bUF3S(
            tHL=1,
            tLH=1,
            strength=Modelica.Electrical.Digital.Interfaces.Strength.'S_X01')
            annotation (Placement(transformation(extent={{-40,-50},{48,38}})));
        equation
          connect(x_table.y, bUF3S.x) annotation (Line(
              points={{-55,-10},{-35.6,-10.4}}, color={127,0,127}));
          connect(e_table.y, bUF3S.enable) annotation (Line(
              points={{-55,40},{-35.6,40},{-35.6,24.8}}, color={127,0,127}));
          annotation (experiment(StopTime=12),
            Documentation(info="<html>
<p>This example is a simple test of the Tristates.BUF3S component.  After simulation until 12 s plot x, enable, and y of the <code>bUF3S</code> component. To verify the result compare to the truth table Buf3sTable.</p>
</html>"));
        end BUF3S;

        model INV3S "Functionality test of INV3S"
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends Modelica.Icons.Example;

          Modelica.Electrical.Digital.Sources.Table e_table(
        y0=L.'U',
        x={L.'0',L.'1',L.'Z'},
        t={0,5,9})
            annotation (Placement(transformation(extent={{-75,30},{-55,50}})));
          Modelica.Electrical.Digital.Sources.Table x_table(
        y0=L.'U',
        x={L.'1',L.'0'},
        t={1,7})
            annotation (Placement(transformation(extent={{-75,-20},{-55,0}})));
          Modelica.Electrical.Digital.Tristates.INV3S iNV3S
            annotation (Placement(transformation(extent={{-34,-44},{42,32}})));
        equation
          connect(x_table.y, iNV3S.x) annotation (Line(
              points={{-55,-10},{-42.6,-10},{-42.6,-9.8},{-30.2,-9.8}}, color={127,0,127}));
          connect(e_table.y, iNV3S.enable) annotation (Line(
              points={{-55,40},{-30.2,40},{-30.2,20.6}}, color={127,0,127}));
          annotation (experiment(StopTime=12),
            Documentation(info="<html>
<p>This example is a simple test of the Tristates.INV3S component. After simulation until 12 s plot x, enable, and y of the <code>iNV3S</code> component. To verify the result compare to the truth table <code>T.UX01Table</code>.</p>
</html>"));
        end INV3S;

        model WiredX "Functionality test of WiredX"
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends Modelica.Icons.Example;
        Modelica.Electrical.Digital.Sources.Table e_table2(
        y0=L.'U',
        x={L.'0',L.'1',L.'0'},
        t={0,3,9})
            annotation (Placement(transformation(extent={{-85,68},{-65,88}})));
          Modelica.Electrical.Digital.Sources.Table x_table2(
        y0=L.'U',
        x={L.'1',L.'0'},
        t={1,7})
            annotation (Placement(transformation(extent={{-85,18},{-65,38}})));
          Modelica.Electrical.Digital.Tristates.BUF3S bUF3S2(
            tHL=1,
            tLH=1,
            strength=Modelica.Electrical.Digital.Interfaces.Strength.'S_X01')
            annotation (Placement(transformation(extent={{-48,-1},{16,63}})));
          Modelica.Electrical.Digital.Sources.Table e_table1(
        y0=L.'U',
        t={0,3,9},
        x={L.'0',L.'1',L.'0'})
            annotation (Placement(transformation(extent={{-85,-24},{-65,-4}})));
          Modelica.Electrical.Digital.Sources.Table x_table1(
        y0=L.'U',
        x={L.'0',L.'1',L.'0'},
        t={1,5,7})
            annotation (Placement(transformation(extent={{-85,-74},{-65,-54}})));
          Modelica.Electrical.Digital.Tristates.BUF3S bUF3S1(
            tHL=1,
            tLH=1,
            strength=Modelica.Electrical.Digital.Interfaces.Strength.'S_X01')
            annotation (Placement(transformation(extent={{-52,-94},{14,-28}})));
          Modelica.Electrical.Digital.Tristates.WiredX wiredX(n=2)
            annotation (Placement(transformation(extent={{26,-38},{80,16}})));
        equation
          connect(x_table2.y, bUF3S2.x) annotation (Line(
              points={{-65,28},{-44.8,27.8}}, color={127,0,127}));
          connect(e_table2.y, bUF3S2.enable) annotation (Line(
              points={{-65,78},{-44.8,78},{-44.8,53.4}}, color={127,0,127}));
          connect(x_table1.y, bUF3S1.x) annotation (Line(
              points={{-65,-64},{-48.7,-64.3}}, color={127,0,127}));
          connect(e_table1.y, bUF3S1.enable) annotation (Line(
              points={{-65,-14},{-48.7,-14},{-48.7,-37.9}}, color={127,0,127}));
          connect(bUF3S1.y, wiredX.x[1]) annotation (Line(
              points={{10.7,-64.3},{24,-64.3},{24,-21.8},{36.8,-21.8}}, color={127,0,127}));
          connect(bUF3S2.y, wiredX.x[2]) annotation (Line(
              points={{12.8,27.8},{26,27.8},{26,-0.2},{36.8,-0.2}}, color={127,0,127}));
          annotation (experiment(StopTime=12),
            Documentation(info="<html>
<p>This example is a simple test of the Tristates.WiredX component. The input width is set to two. After simulation until 12 s plot x[1], x[2], and y of the WiredX component. To verify the result compare to the truth table  Tables.ResolutionTable.</p>
</html>"));
        end WiredX;

        model MUX2x1 "Simple Multiplexer test"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends Modelica.Icons.Example;
          D.Multiplexers.MUX2x1 Mux2x1
            annotation (Placement(transformation(extent={{-34,-48},{56,48}})));
          D.Sources.Table Input1(
            y0=L.'U',
            x={L.'X',L.'0',L.'1',L.'0',L.'X',L.'U'},
            t={2,4,6,8,10,12})
            annotation (Placement(transformation(extent={{-90,14},{-70,34}})));
          D.Sources.Step Select(
            before=L.'0',
            after=L.'1',
            stepTime=7)
            annotation (Placement(transformation(extent={{-90,58},{-70,78}})));
          D.Sources.Table Input0(
            y0=L.'U',
            t={2,4,6,8,10,12},
            x={L.'1',L.'X',L.'0',L.'X',L.'1',L.'U'})
            annotation (Placement(transformation(extent={{-90,-34},{-70,-14}})));
        equation
          connect(Select.y, Mux2x1.sel) annotation (Line(
              points={{-70,68},{11,68},{11,43.2}}, color={127,0,127}));
          connect(Input0.y, Mux2x1.in0) annotation (Line(
              points={{-70,-24},{-29.5,-24}}, color={127,0,127}));
          connect(Input1.y, Mux2x1.in1) annotation (Line(
              points={{-70,24},{-29.5,24}}, color={127,0,127}));
          annotation (experiment(StopTime=15),
            Documentation(info="<html>
<p>This example is a simple test of a single multiplexer component with 2 inputs prescribed by sources, one select input, and one output. After simulation until 15 s plot Mux2x1.in0, Mux2x1.in1, Mux2x1.sel, and Mux2x1.out. Compare the output signal with the input signals. If the select signal changes, the output switches to the other input.</p>
</html>"));
        end MUX2x1;

        model RAM "Simple RAM test example"
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends Modelica.Icons.Example;

          Modelica.Electrical.Digital.Memories.DLATRAM
                         dLATRAM
            annotation (Placement(transformation(extent={{-11,-41},{103,73}})));
          Modelica.Electrical.Digital.Sources.Table
                        addr_1(
            y0=L.'U',
            x={L.'X',L.'0',L.'1',L.'Z',L.'W',L.'L',L.'H',L.'-',
               L.'U',L.'X',L.'0',L.'1',L.'Z',L.'W',L.'L',L.'H',L.'-',
               L.'U',L.'X',L.'0',L.'1',L.'Z',L.'W',L.'L',L.'H',L.'-',
               L.'U',L.'X',L.'0',L.'1',L.'Z',L.'W',L.'L',L.'H',L.'-',
               L.'U',L.'X',L.'0',L.'1',L.'Z',L.'W',L.'L',L.'H',L.'-',
               L.'U',L.'X',L.'0',L.'1',L.'Z',L.'W',L.'L',L.'H',L.'-',
               L.'U',L.'X',L.'0',L.'1',L.'Z',L.'W',L.'L',L.'H',L.'-',
               L.'U',L.'X',L.'0',L.'1',L.'Z',L.'W',L.'L',L.'H',L.'-',
               L.'U',L.'X',L.'0',L.'1',L.'Z',L.'W',L.'L',L.'H',L.'-'},
            t={5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110,
                115,120,125,130,135,140,145,150,155,160,165,170,175,180,185,190,195,
                200,205,210,215,220,225,230,235,240,245,250,255,260,265,270,275,280,
                285,290,295,300,305,310,315,320,325,330,335,340,345,350,355,360,365,
                370,375,380,385,390,395,400})
            annotation (Placement(transformation(extent={{-78,76},{-58,96}})));
          Modelica.Electrical.Digital.Sources.Set
                      data_1(x=Modelica.Electrical.Digital.Interfaces.Logic.'0')
            annotation (Placement(transformation(extent={{-78,20},{-58,40}})));
          Modelica.Electrical.Digital.Sources.Set
                      data_0(x=Modelica.Electrical.Digital.Interfaces.Logic.'0')
            annotation (Placement(transformation(extent={{-78,-8},{-58,12}})));
          Modelica.Electrical.Digital.Sources.Set
                      WE(x=Modelica.Electrical.Digital.Interfaces.Logic.'1')
            annotation (Placement(transformation(extent={{-78,-70},{-58,-50}})));
          Modelica.Electrical.Digital.Sources.Table
                        addr_0(
            y0=Modelica.Electrical.Digital.Interfaces.Logic.'U',
            t={45,90,135,180,225,270,315,360},
            x={L.'X',L.'0',L.'1',L.'Z',L.'W',L.'L',L.'H',L.'-'})
            annotation (Placement(transformation(extent={{-78,48},{-58,68}})));
          Modelica.Electrical.Digital.Sources.Set
                      RE(x=Modelica.Electrical.Digital.Interfaces.Logic.'1')
            annotation (Placement(transformation(extent={{-78,-38},{-58,-18}})));

        equation
          connect(RE.y,dLATRAM. RE) annotation (Line(
              points={{-58,-28},{-28,-28},{-28,4.6},{-6.44,4.6}}, color={127,0,127}));
          connect(WE.y,dLATRAM. WE) annotation (Line(
              points={{-58,-60},{-24,-60},{-24,-12.5},{-6.44,-12.5}}, color={127,0,127}));
          connect(addr_0.y,dLATRAM. addr[1]) annotation (Line(
              points={{-58,58},{-34,58},{-34,47.35},{-5.3,47.35}}, color={127,0,127}));
          connect(addr_1.y,dLATRAM. addr[2]) annotation (Line(
              points={{-58,86},{-32,86},{-32,53.05},{-5.3,53.05}}, color={127,0,127}));
          connect(data_1.y,dLATRAM. dataIn[2]) annotation (Line(
              points={{-58,30},{-32,30},{-32,30.25},{-5.3,30.25}}, color={127,0,127}));
          connect(data_0.y,dLATRAM. dataIn[1]) annotation (Line(
              points={{-58,2},{-34,2},{-34,24.55},{-5.3,24.55}}, color={127,0,127}));
          annotation (experiment(StopTime=400),
            Documentation(info="<html>
<p>This example is a simple and incomplete test of a single DLATRAM component . After simulation until 400 s plot dLATRAM.addr[1], dLATRAM.addr[2], and dLATRAM.dataOUT[1], dLATRAM.dataOut[2]. The address inputs are  prescribed with all possible combinations of logic values. It can be checked in which cases of address values the output is 'X' or '0'.</p>
</html>"));
        end RAM;

      package Utilities "Utility components used by package Examples"
        extends Modelica.Icons.UtilitiesPackage;

        model MUX4 "4 to 1 Bit Multiplexer"
        import D = Modelica.Electrical.Digital;
        import L = Modelica.Electrical.Digital.Interfaces.Logic;

          parameter SI.Time delayTime=0.001 "Delay time";
          parameter D.Interfaces.Logic q0=L.'0' "Initial value";
            D.Interfaces.DigitalInput d0 annotation (Placement(transformation(
                    extent={{-110,60},{-90,80}})));
            D.Interfaces.DigitalInput d1 annotation (Placement(transformation(
                    extent={{-110,34},{-90,54}})));
            D.Interfaces.DigitalInput d2 annotation (Placement(transformation(
                    extent={{-110,8},{-90,28}})));
            D.Interfaces.DigitalInput d3 annotation (Placement(transformation(
                    extent={{-110,-18},{-90,2}})));
            D.Interfaces.DigitalInput a0 annotation (Placement(transformation(
                    extent={{-110,-54},{-90,-34}})));
            D.Interfaces.DigitalInput a1 annotation (Placement(transformation(
                    extent={{-110,-80},{-90,-60}})));
            D.Interfaces.DigitalOutput d annotation (Placement(transformation(
                    extent={{90,-10},{110,10}})));
            D.Basic.Or Or1(n=4) annotation (Placement(transformation(extent={{50,20},
                      {70,40}})));
            D.Basic.And And1(n=3) annotation (Placement(transformation(extent={{-20,
                      60},{0,80}})));
            D.Basic.And And2(n=3) annotation (Placement(transformation(extent={{-20,
                      34},{0,54}})));
            D.Basic.And And3(n=3) annotation (Placement(transformation(extent={{-20,
                      8},{0,28}})));
            D.Basic.And And4(n=3) annotation (Placement(transformation(extent={{-20,
                      -18},{0,2}})));
            D.Basic.Not Not1 annotation (Placement(transformation(extent={{-76,-54},
                      {-56,-34}})));
            D.Basic.Not Not2 annotation (Placement(transformation(extent={{-76,-80},
                      {-56,-60}})));
        equation
            connect(a0, Not1.x) annotation (Line(
                points={{-100,-44},{-72,-44}}, color={127,0,127}));
            connect(a1, Not2.x) annotation (Line(
                points={{-100,-70},{-72,-70}}, color={127,0,127}));
            connect(d0, And1.x[2]) annotation (Line(
                points={{-100,70},{-58,70},{-58,70},{-16,70}}, color={127,0,127}));
            connect(d1, And2.x[2]) annotation (Line(
                points={{-100,44},{-16,44}}, color={127,0,127}));
            connect(d2, And3.x[2]) annotation (Line(
                points={{-100,18},{-16,18}}, color={127,0,127}));
            connect(d3, And4.x[2]) annotation (Line(
                points={{-100,-8},{-58,-8},{-58,-8},{-16,-8}}, color={127,0,127}));
            connect(And4.y, Or1.x[1]) annotation (Line(
                points={{0,-8},{40,-8},{40,24},{54,24}}, color={127,0,127}));
            connect(And3.y, Or1.x[2]) annotation (Line(
                points={{0,18},{20,18},{20,28},{54,28}}, color={127,0,127}));
            connect(And2.y, Or1.x[3]) annotation (Line(
                points={{0,44},{20,44},{20,32},{54,32}}, color={127,0,127}));
            connect(And1.y, Or1.x[4]) annotation (Line(
                points={{0,70},{40,70},{40,36},{54,36}}, color={127,0,127}));
            connect(Or1.y, d) annotation (Line(
                points={{70,30},{80,30},{80,0},{100,0}}, color={127,0,127}));
            connect(Not1.y, And1.x[3]) annotation (Line(
                points={{-56,-44},{-50,-44},{-50,75.3333},{-16,75.3333}}, color={127,0,127}));
            connect(Not1.y, And3.x[3]) annotation (Line(
                points={{-56,-44},{-50,-44},{-50,23.3333},{-16,23.3333}}, color={127,0,127}));
            connect(Not2.y, And1.x[1]) annotation (Line(
                points={{-56,-70},{-40,-70},{-40,64.6667},{-16,64.6667}}, color={127,0,127}));
            connect(Not2.y, And2.x[1]) annotation (Line(
                points={{-56,-70},{-40,-70},{-40,38.6667},{-16,38.6667}}, color={127,0,127}));
            connect(a0, And4.x[3]) annotation (Line(
                points={{-100,-44},{-80,-44},{-80,-2.66667},{-16,-2.66667}}, color={127,0,127}));
            connect(a0, And2.x[3]) annotation (Line(
                points={{-100,-44},{-80,-44},{-80,49.3333},{-16,49.3333}}, color={127,0,127}));
            connect(a1, And4.x[1]) annotation (Line(
                points={{-100,-70},{-80,-70},{-80,-90},{-30,-90},{-30,-13.3333},
                {-16,-13.3333}}, color={127,0,127}));
            connect(a1, And3.x[1]) annotation (Line(
                points={{-100,-70},{-80,-70},{-80,-90},{-30,-90},{-30,12.6667},
                {-16,12.6667}}, color={127,0,127}));
          annotation (
            Documentation(info="<html>
<p>MUX4 is a four bit multiplexer which is built up by And, Not, and Or gates according to the schematic.</p>
<p>The parameters delayTime and q0 are prepared but <strong>not</strong> yet used in the component. The MUX4 component uses standard values in its components.</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={
              Rectangle(
                extent={{-90,100},{90,-100}},
                lineThickness=0.5,
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-60,100},{-60,-100}},
                thickness=0.5),
              Line(
                points={{60,100},{60,-100}},
                thickness=0.5),
              Text(
                extent={{-86,80},{-64,60}},
                textString="D0"),
              Text(
                extent={{64,12},{86,-8}},
                textString="D"),
              Text(
                extent={{-150,-100},{150,-160}},
                textColor={0,0,255},
                textString="%name"),
              Text(
                extent={{-60,100},{60,40}},
                textString="MUX"),
              Text(
                extent={{-86,-60},{-64,-80}},
                textString="A1"),
              Text(
                extent={{-86,54},{-64,34}},
                textString="D1"),
              Text(
                extent={{-86,28},{-64,8}},
                textString="D2"),
              Text(
                extent={{-86,2},{-64,-18}},
                textString="D3"),
              Text(
                extent={{-86,-36},{-64,-56}},
                textString="A0")}));
        end MUX4;

        model RS "Unclocked RS FlipFlop"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;

          parameter SI.Time delayTime=0 "Delay time";
          parameter D.Interfaces.Logic q0=L.'U' "Initial value of output";
          D.Basic.Nor Nor1 annotation (Placement(transformation(extent={{-40,42},
                      {0,82}})));
          D.Basic.Nor Nor2 annotation (Placement(transformation(extent={{-40,-82},
                      {0,-42}})));
          D.Interfaces.DigitalInput s annotation (Placement(transformation(extent=
                     {{-110,60},{-90,80}})));
          D.Interfaces.DigitalInput r annotation (Placement(transformation(
                    extent={{-110,-80},{-90,-60}})));
          D.Interfaces.DigitalOutput q annotation (Placement(transformation(
                    extent={{90,60},{110,80}})));
          D.Interfaces.DigitalOutput qn annotation (Placement(transformation(
                    extent={{90,-80},{110,-60}})));
          D.Delay.TransportDelay TD1(delayTime=delayTime,y0=q0)
              annotation (Placement(transformation(extent={{-60,-64},{-40,-44}})));
        equation
          connect(s, Nor1.x[2]) annotation (Line(points={{-100,70},{-32,70}}, color={127,0,127}));
          connect(r, Nor2.x[1]) annotation (Line(points={{-100,-70},{-32,-70}}, color={127,0,127}));
          connect(Nor2.y, Nor1.x[1]) annotation (Line(points={{0,-62},{20,-62},{
                    20,-20},{-70,20},{-70,54},{-32,54}}, color={127,0,127}));
          connect(Nor1.y,qn) annotation (Line(
                points={{0,62},{50,62},{50,-70},{100,-70}}, color={127,0,127}));
          connect(Nor2.y,q) annotation (Line(
                points={{0,-62},{70,-62},{70,70},{100,70}}, color={127,0,127}));
          connect(TD1.y, Nor2.x[2]) annotation (Line(points={{-40,-54},{-32,-54}}, color={127,0,127}));
          connect(TD1.x, Nor1.y) annotation (Line(points={{-56,-54},{-70,-54},{-70,
                    -20},{20,20},{20,62},{0,62}}, color={127,0,127}));
          annotation (
            Documentation(info="<html>
<p>RS is a basic component for e.g., the RS (set-reset) flipflop, which is built up by Nor gates according to the schematic. To avoid a numerical loop a small transport delay is inserted which delay time is a parameter of the RS component. Also its initial value can be set by parameter.</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={
              Rectangle(
                extent={{-90,100},{90,-100}},
                lineThickness=0.5,
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-100,100},{100,40}},
                textString="RS"),
              Line(
                points={{-60,100},{-60,-100}},
                thickness=0.5),
              Line(
                points={{60,100},{60,-100}},
                thickness=0.5),
              Text(
                extent={{-86,-60},{-64,-80}},
                textString="R"),
              Text(
                extent={{-86,80},{-64,60}},
                textString="S"),
              Text(
                extent={{64,80},{86,60}},
                textString="Q"),
              Text(
                extent={{64,-60},{86,-80}},
                textString="QN"),
              Text(
                extent={{-150,-100},{150,-160}},
                textColor={0,0,255},
                textString="%name")}));
        end RS;

        model RSFF "Unclocked RS FlipFlop"
        import D = Modelica.Electrical.Digital;
        import L = Modelica.Electrical.Digital.Interfaces.Logic;

          parameter SI.Time delayTime=0.01 "Delay time";
          parameter D.Interfaces.Logic q0=L.'U' "Initial value";
          D.Interfaces.DigitalInput s annotation (Placement(transformation(extent=
                     {{-110,60},{-90,80}})));
          D.Interfaces.DigitalInput r annotation (Placement(transformation(
                    extent={{-110,-80},{-90,-60}})));
          D.Interfaces.DigitalOutput q annotation (Placement(transformation(extent=
                      {{90,60},{110,80}})));
          D.Interfaces.DigitalOutput qn "not Q"
            annotation (Placement(transformation(extent={{90,-80},{110,-60}})));
          D.Interfaces.DigitalInput clk annotation (Placement(transformation(
                    extent={{-110,-10},{-90,10}})));
          D.Examples.Utilities.RS RS1(delayTime=delayTime,q0=q0)
                                            annotation (Placement(transformation(
                    extent={{-10,-40},{70,40}})));
          D.Basic.And And1 annotation (Placement(transformation(extent={{-70,
                      8},{-30,48}})));
          D.Basic.And And2 annotation (Placement(transformation(extent={{-70,
                      -48},{-30,-8}})));
        equation
          connect(And2.y, RS1.r)
                                annotation (Line(
                points={{-30,-28},{-10,-28}}, color={127,0,127}));
          connect(And1.y, RS1.s)
                                annotation (Line(
                points={{-30,28},{-10,28}}, color={127,0,127}));
          connect(s, And1.x[2]) annotation (Line(
                points={{-100,70},{-70,70},{-70,36},{-62,36}}, color={127,0,127}));
          connect(clk, And1.x[1]) annotation (Line(
                points={{-100,0},{-70,0},{-70,20},{-62,20}}, color={127,0,127}));
          connect(clk, And2.x[2]) annotation (Line(
                points={{-100,0},{-70,0},{-70,-20},{-62,-20}}, color={127,0,127}));
          connect(r, And2.x[1]) annotation (Line(
                points={{-100,-70},{-70,-70},{-70,-36},{-62,-36}}, color={127,0,127}));
          connect(RS1.q,q) annotation (Line(
                points={{70,28},{80,28},{80,70},{100,70}}, color={127,0,127}));
          connect(RS1.qn,qn) annotation (Line(
                points={{70,-28},{80,-28},{80,-70},{100,-70}}, color={127,0,127}));
          annotation (
            Documentation(info="<html>
<p>Basing on the RS component RSFF is a RS (set-reset) flipflop composed according the schematic. Its parameter delayTime is the delay time of the RS component transport delay, q0 is the initial value of that delay.</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={
              Rectangle(
                extent={{-90,100},{90,-100}},
                lineThickness=0.5,
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-100,100},{100,40}},
                textString="RS"),
              Line(
                points={{-60,100},{-60,-100}},
                thickness=0.5),
              Line(
                points={{60,100},{60,-100}},
                thickness=0.5),
              Text(
                extent={{-86,-60},{-64,-80}},
                textString="R"),
              Text(
                extent={{-86,80},{-64,60}},
                textString="S"),
              Text(
                extent={{64,80},{86,60}},
                textString="Q"),
              Text(
                extent={{64,-60},{86,-80}},
                textString="QN"),
              Line(points={{-90,20},{-60,0},{-90,-20}}),
              Text(
                extent={{-150,-100},{150,-160}},
                textColor={0,0,255},
                textString="%name")}));
        end RSFF;

        model DFF "D FlipFlop"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;

          parameter SI.Time Tdel=0.01 "Delay time";
          parameter L QInit=L.'U' "Initial value";
          D.Interfaces.DigitalInput d annotation (Placement(transformation(extent=
                     {{-110,60},{-90,80}})));
          D.Interfaces.DigitalOutput q annotation (Placement(transformation(extent=
                      {{90,60},{110,80}})));
          D.Interfaces.DigitalOutput qn "not Q"
            annotation (Placement(transformation(extent={{90,-80},{110,-60}})));
          D.Interfaces.DigitalInput clk annotation (Placement(transformation(
                    extent={{-110,-10},{-90,10}})));
          D.Examples.Utilities.RSFF RSFF1 annotation (Placement(transformation(
                    extent={{-10,-40},{70,40}})));
          D.Basic.Not Not1 annotation (Placement(transformation(extent={{-70,
                      -48},{-30,-8}})));
        equation
          connect(RSFF1.q,q)
                           annotation (Line(
                points={{70,28},{80,28},{80,70},{100,70}}, color={127,0,127}));
          connect(RSFF1.qn,qn)
                             annotation (Line(
                points={{70,-28},{80,-28},{80,-70},{100,-70}}, color={127,0,127}));
          connect(Not1.y, RSFF1.r)
                                 annotation (Line(
                points={{-30,-28},{-22,-28},{-10,-28}}, color={127,0,127}));
          connect(d, Not1.x) annotation (Line(
                points={{-100,70},{-80,70},{-80,-28},{-62,-28}}, color={127,0,127}));
          connect(d, RSFF1.s) annotation (Line(
                points={{-100,70},{-80,70},{-80,28},{-10,28}}, color={127,0,127}));
        connect(clk, RSFF1.clk) annotation (Line(
            points={{-100,0},{-10,0}}, color={127,0,127}));
          annotation (
            Documentation(info="<html>
<p>Basing on the RS component DFF is a D  flipflop composed according the schematic. Its parameter delayTime is the delay time of the RS component transport delay, q0 is the initial value of that delay.</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={
              Rectangle(
                extent={{-90,100},{90,-100}},
                lineThickness=0.5,
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-60,100},{-60,-100}},
                thickness=0.5),
              Line(
                points={{60,100},{60,-100}},
                thickness=0.5),
              Text(
                extent={{-86,80},{-64,60}},
                textString="D"),
              Text(
                extent={{64,80},{86,60}},
                textString="Q"),
              Text(
                extent={{64,-60},{86,-80}},
                textString="QN"),
              Line(points={{-90,20},{-60,0},{-90,-20}}),
              Text(
                extent={{-150,-100},{150,-160}},
                textColor={0,0,255},
                textString="%name"),
              Text(
                extent={{-100,100},{100,40}},
                textString="D")}));
        end DFF;

        model JKFF "JK FlipFlop"
        import D = Modelica.Electrical.Digital;
        import L = Modelica.Electrical.Digital.Interfaces.Logic;

          parameter SI.Time delayTime=0.001 "Delay time";
          parameter D.Interfaces.Logic q0=L.'0' "Initial value";
          D.Interfaces.DigitalInput j annotation (Placement(transformation(extent=
                     {{-110,60},{-90,80}})));
          D.Interfaces.DigitalOutput q annotation (Placement(transformation(extent=
                      {{90,60},{110,80}})));
          D.Interfaces.DigitalOutput qn "not Q"
            annotation (Placement(transformation(extent={{90,-80},{110,-60}})));
          D.Interfaces.DigitalInput clk annotation (Placement(transformation(
                    extent={{-110,-10},{-90,10}})));
          D.Interfaces.DigitalInput k annotation (Placement(transformation(extent=
                     {{-110,-80},{-90,-60}})));
          D.Examples.Utilities.RS RS1(delayTime=delayTime,q0=q0)
                                       annotation (Placement(transformation(
                  extent={{30,-24},{70,16}})));
          D.Examples.Utilities.RS RS2(delayTime=delayTime,q0=q0)
                                       annotation (Placement(transformation(
                  extent={{-44,-20},{-4,20}})));
          D.Basic.And And1(n=3) annotation (Placement(transformation(extent={{-70,
                    4},{-50,24}})));
          D.Basic.And And2(n=3) annotation (Placement(transformation(extent={{-70,
                    -24},{-50,-4}})));
          D.Basic.And And3 annotation (Placement(transformation(extent={{4,0},{24,
                    20}})));
          D.Basic.And And4 annotation (Placement(transformation(extent={{4,-28},{
                    24,-8}})));
          D.Basic.Not Not1 annotation (Placement(transformation(extent={{-34,-66},
                    {-14,-46}})));
        equation
            connect(And2.y, RS2.r) annotation (Line(points={{-50,-14},{-44,-14}}, color={127,0,127}));
            connect(And1.y, RS2.s) annotation (Line(points={{-50,14},{-44,14}}, color={127,0,127}));
            connect(clk, And2.x[3]) annotation (Line(points={{-100,0},{-74,0},{
                -74,-8.66667},{-66,-8.66667}}, color={127,0,127}));
            connect(clk, And1.x[1]) annotation (Line(points={{-100,0},{-74,0},{
                -74,8.66667},{-66,8.66667}}, color={127,0,127}));
            connect(k, And2.x[2]) annotation (Line(points={{-100,-70},{-74,-70},{
                    -74,-14},{-66,-14}}, color={127,0,127}));
            connect(And4.y, RS1.r) annotation (Line(points={{24,-18},{30,-18}}, color={127,0,127}));
            connect(And3.y, RS1.s) annotation (Line(points={{24,10},{30,10}}, color={127,0,127}));
            connect(RS2.qn, And4.x[2]) annotation (Line(points={{-4,-14},{8,-14}}, color={127,0,127}));
            connect(RS2.q, And3.x[2]) annotation (Line(points={{-4,14},{8,14}}, color={127,0,127}));
            connect(clk, Not1.x) annotation (Line(points={{-100,0},{-80,0},{-80,-56},
                    {-30,-56}}, color={127,0,127}));
            connect(Not1.y, And3.x[1]) annotation (Line(points={{-14,-56},{2,-56},{
                    2,6},{8,6}}, color={127,0,127}));
            connect(Not1.y, And4.x[1]) annotation (Line(points={{-14,-56},{2,-56},{
                    2,-22},{8,-22}}, color={127,0,127}));
            connect(j, And1.x[2]) annotation (Line(points={{-100,70},{-74,70},{-74,
                    14},{-66,14}}, color={127,0,127}));
            connect(RS1.q, And2.x[1]) annotation (Line(points={{70,10},{80,10},
                {80,-36},{-70,-36},{-70,-19.3333},{-66,-19.3333}}, color={127,0,127}));
            connect(RS1.qn, And1.x[3]) annotation (Line(points={{70,-18},{86,
                -18},{86,36},{-70,36},{-70,19.3333},{-66,19.3333}}, color={127,0,127}));
          connect(RS1.qn, q) annotation (Line(points={{70,-18},{86,-18},{86,70},{
                    100,70}}, color={127,0,127}));
          connect(RS1.q, qn) annotation (Line(points={{70,10},{80,10},{80,-70},{100,
                    -70}}, color={127,0,127}));
          annotation (
            Documentation(info="<html>
<p>Basing on the RS component JKFF is a J-K-flipflop composed according the schematic. Its parameter delayTime is the delay time of the RS component transport delay, q0 is the initial value of that delay.</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={
              Rectangle(
                extent={{-90,100},{90,-100}},
                lineThickness=0.5,
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-60,100},{-60,-100}},
                thickness=0.5),
              Line(
                points={{60,100},{60,-100}},
                thickness=0.5),
              Text(
                extent={{-86,80},{-64,60}},
                textString="J"),
              Text(
                extent={{64,80},{86,60}},
                textString="Q"),
              Text(
                extent={{64,-60},{86,-80}},
                textString="QN"),
              Line(points={{-90,20},{-60,0},{-90,-20}}),
              Text(
                extent={{-150,-100},{150,-160}},
                textColor={0,0,255},
                textString="%name"),
              Text(
                extent={{-100,100},{100,40}},
                textString="JK"),
              Text(
                extent={{-86,-60},{-64,-80}},
                textString="K")}));
        end JKFF;

                  model HalfAdder "Half adder"
                    import L = Modelica.Electrical.Digital.Interfaces.Logic;
                    parameter Real delayTime=0 "Delay time";
                    Modelica.Electrical.Digital.Interfaces.DigitalInput b
                      annotation (Placement(transformation(extent={{-110,-80},{-90,
                      -60}})));
                    Modelica.Electrical.Digital.Interfaces.DigitalOutput s
                                         annotation (Placement(transformation(
                    extent={{90,60},{110,80}})));
                    Modelica.Electrical.Digital.Interfaces.DigitalInput a
                      annotation (Placement(transformation(extent={{-110,60},{-90,
                      80}})));
                    Modelica.Electrical.Digital.Interfaces.DigitalOutput c
                                         annotation (Placement(transformation(
                    extent={{90,-80},{110,-60}})));
                    Modelica.Electrical.Digital.Gates.AndGate AND(tLH=delayTime, tHL=delayTime, G2(y(start=L.'U',fixed=true)))
                      annotation (Placement(transformation(extent={{-20,-82},{20,
                      -42}})));
                    Modelica.Electrical.Digital.Gates.XorGate XOR(tLH=delayTime, tHL=delayTime, G2(y(start=L.'U', fixed=true)))
                      annotation (Placement(transformation(extent={{-20,42},{20,82}})));

                  equation
                    connect(AND.y, c)
                                   annotation (Line(points={{20,-62},{60,-62},{60,-70},
                    {100,-70}}, color={127,0,127}));
                    connect(XOR.y, s)
                                   annotation (Line(points={{20,62},{60,62},{60,70},
                    {100,70}}, color={127,0,127}));
                    connect(b, AND.x[1])
                                      annotation (Line(points={{-100,-70},{-12,-70}}, color={127,0,127}));
                    connect(b, XOR.x[1])
                                      annotation (Line(points={{-100,-70},{-30,-70},
                    {-30,54},{-12,54}}, color={127,0,127}));
                    connect(a, XOR.x[2])
                                      annotation (Line(points={{-100,70},{-12,70}}, color={127,0,127}));
                    connect(a, AND.x[2])
                                      annotation (Line(points={{-100,70},{-40,70},{
                    -40,-54},{-12,-54}}, color={127,0,127}));
                    annotation (Icon(coordinateSystem(preserveAspectRatio=true,
                    extent={{-100,-100},{100,100}}), graphics={Rectangle(
                                  extent={{-90,100},{90,-100}},
                                  lineThickness=0.5,
                                  fillColor={255,255,170},
                                  fillPattern=FillPattern.Solid),Text(
                                  extent={{-90,80},{-60,60}},
                                  textString="a"),Text(
                                  extent={{-90,-60},{-60,-80}},
                                  textString="b"),Text(
                                  extent={{60,80},{90,60}},
                                  textString="s"),Text(
                                  extent={{60,-60},{90,-80}},
                                  textString="c"),Text(
                                  extent={{-150,-100},{150,-160}},
                                  textColor={0,0,255},
                                  textString="%name"),Text(
                                  extent={{-100,100},{100,0}},
                                  textString="+"),Line(
                                  points={{-60,100},{-60,-100}},
                                  thickness=0.5),Line(
                                  points={{60,100},{60,-100}},
                                  thickness=0.5)}),
                      Documentation(info="<html>
<p>HalfAdder is a two bit adder which is composed by Gates components.</p>
<p>Its logic behavior is like this:</p>
<p><strong>HalfAdder behavior</strong></p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><h4>input a</h4></td>
<td><h4>input b</h4></td>
<td><h4>sum s</h4></td>
<td><h4>carry c</h4></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
</tr>
</table>
<p>The parameter delayTime is the delay time (tLH=tHL) of both the components.</p>
</html>"));
                  end HalfAdder;

        model FullAdder
        "Adding circuit for binary numbers with input carry bit"

          HalfAdder Adder2(delayTime=0.001)
                                          annotation (Placement(transformation(
                    extent={{10,36},{50,76}})));
          HalfAdder Adder1(delayTime=0.001)
                                           annotation (Placement(transformation(
                    extent={{-60,36},{-20,76}})));
          Modelica.Electrical.Digital.Interfaces.DigitalInput a
            annotation (Placement(transformation(
                  origin={-100,70},
                  extent={{-10,-10},{10,10}},
                  rotation=180)));
          Modelica.Electrical.Digital.Interfaces.DigitalInput b
            annotation (Placement(transformation(
                  origin={-100,30},
                  extent={{-10,-10},{10,10}},
                  rotation=180)));
          Modelica.Electrical.Digital.Interfaces.DigitalInput c_in
            annotation (Placement(transformation(
                  origin={-100,-70},
                  extent={{-10,-10},{10,10}},
                  rotation=180)));
          Modelica.Electrical.Digital.Interfaces.DigitalOutput s
            annotation (Placement(transformation(
                  origin={101,70},
                  extent={{11,-10},{-11,10}},
                  rotation=180)));
          Modelica.Electrical.Digital.Interfaces.DigitalOutput c_out
            annotation (Placement(transformation(
                  origin={100,-70},
                  extent={{10,-10},{-10,10}},
                  rotation=180)));
          Modelica.Electrical.Digital.Basic.Or OR
                       annotation (Placement(transformation(extent={{10,-90},{50,
                      -50}})));
        equation

          connect(c_out, OR.y) annotation (Line(
                points={{100,-70},{50,-70}}, color={127,0,127}));
          connect(Adder2.c, OR.x[2])
                                   annotation (Line(
                points={{50,42},{70,42},{70,-40},{10,-40},{10,-62},{18,-62}}, color={127,0,127}));
          connect(Adder2.s, s)
            annotation (Line(points={{50,70},{101,70}}, color={127,0,127}));
            connect(Adder1.a, a) annotation (Line(points={{-60,70},{-100,70}}, color={127,0,127}));
            connect(b, Adder1.b) annotation (Line(points={{-100,30},{-70,30},{-70,
                    42},{-60,42}}, color={127,0,127}));
            connect(Adder1.s, Adder2.a) annotation (Line(points={{-20,70},{10,70}}, color={127,0,127}));
            connect(Adder1.c, OR.x[1]) annotation (Line(points={{-20,42},{-10,42},{
                    -10,-78},{18,-78}}, color={127,0,127}));
            connect(c_in, Adder2.b) annotation (Line(points={{-100,-70},{0,-70},{0,
                    42},{10,42}}, color={127,0,127}));
          annotation (
            Documentation(info="<html>
<p>FullAdder is a two bit adder with additional carry in bit which is composed by Gates components.</p>
<p>Its logic behavior is like this:</p>
<p><strong>FullAdder behavior</strong></p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><h4>input a</h4></td>
<td><h4>input b</h4></td>
<td><h4>input carry c_in</h4></td>
<td><h4>sum s</h4></td>
<td><h4>output carry c_out</h4></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
</tr>
</table>
</html>"), Icon(coordinateSystem(
                  preserveAspectRatio=true,
                  extent={{-100,-100},{100,100}}), graphics={
              Rectangle(
                extent={{-90,100},{90,-100}},
                lineThickness=0.5,
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-150,-96},{150,-151}},
                textColor={0,0,255},
                textString="%name"),
              Text(
                extent={{-86,80},{-64,60}},
                textString="a"),
              Text(
                extent={{-86,40},{-64,20}},
                textString="b"),
              Text(
                extent={{-86,-60},{-64,-80}},
                textString="c_in"),
              Text(
                extent={{60,-60},{90,-80}},
                textString="c_out"),
              Text(
                extent={{64,80},{86,60}},
                textString="s"),
              Text(
                extent={{-100,100},{100,0}},
                textString="+"),
              Line(
                points={{-60,100},{-60,-100}},
                thickness=0.5),
              Line(
                points={{60,100},{60,-100}},
                thickness=0.5)}));
        end FullAdder;

        model Adder "Generic N Bit Adder"
        import Modelica.Electrical.Digital;

          parameter Integer n=2 "Number of single adders";
          Modelica.Electrical.Digital.Examples.Utilities.FullAdder Adder[n]
                                       annotation (Placement(transformation(extent=
                      {{-20,-20},{20,20}})));
          Modelica.Electrical.Digital.Interfaces.DigitalInput a[n]
                                               annotation (Placement(transformation(
                    extent={{-110,60},{-90,80}})));
          Modelica.Electrical.Digital.Interfaces.DigitalInput b[n]
                                               annotation (Placement(transformation(
                    extent={{-110,20},{-90,40}})));
          Modelica.Electrical.Digital.Interfaces.DigitalInput c_in
                                               annotation (Placement(transformation(
                    extent={{-110,-80},{-90,-60}})));
          Modelica.Electrical.Digital.Interfaces.DigitalOutput s[n]
                                                annotation (Placement(
                  transformation(extent={{90,60},{110,80}})));
          Modelica.Electrical.Digital.Interfaces.DigitalOutput c_out
                                                 annotation (Placement(
                  transformation(extent={{90,-80},{110,-60}})));
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
          annotation (
            Documentation(info="<html>
<p>The Adder is a generic n bit adder which is composed as a chain of FullAdder components. n can be chosen by the user, a and b are the n bit input vectors, s is the sum vector, and c_out is the carry bit of the &quot;highest&quot; FullAdder.   All components are built up by Gate components.</p>
</html>"), Icon(coordinateSystem(
                  preserveAspectRatio=true,
                  extent={{-100,-100},{100,100}}), graphics={
              Rectangle(
                extent={{-90,100},{90,-100}},
                lineThickness=0.5,
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{68,80},{88,60}},
                textString="S"),
              Text(
                extent={{-150,-100},{150,-160}},
                textColor={0,0,255},
                textString="%name"),
              Text(
                extent={{-40,60},{40,20}},
                textString="Adder"),
              Text(
                extent={{48,-60},{88,-80}},
                textString="Cout"),
              Text(
                extent={{-90,-60},{-50,-80}},
                textString="Cin"),
              Text(
                extent={{-88,80},{-68,60}},
                textString="A"),
              Text(
                extent={{-88,40},{-68,20}},
                textString="B")}));
        end Adder;

        model Counter3 "3 Bit Counter"
        import D = Modelica.Electrical.Digital;
        import L = Modelica.Electrical.Digital.Interfaces.Logic;

          D.Interfaces.DigitalInput enable
                                         annotation (Placement(transformation(
                    extent={{-110,60},{-90,80}})));
          D.Interfaces.DigitalOutput q2 annotation (Placement(transformation(extent=
                     {{90,60},{110,80}})));
          D.Interfaces.DigitalInput count
                                         annotation (Placement(transformation(
                    extent={{-110,-80},{-90,-60}})));
          D.Examples.Utilities.JKFF FF1
               annotation (Placement(transformation(extent={{-74,-20},{-34,20}})));
          D.Examples.Utilities.JKFF FF2
               annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
          D.Examples.Utilities.JKFF FF3
               annotation (Placement(transformation(extent={{34,-20},{74,20}})));
          D.Interfaces.DigitalOutput q1 annotation (Placement(transformation(extent=
                     {{90,-10},{110,10}})));
          D.Interfaces.DigitalOutput q0 annotation (Placement(transformation(extent=
                     {{90,-80},{110,-60}})));
        equation
          connect(enable, FF1.j) annotation (Line(
                points={{-100,70},{-80,70},{-80,14},{-74,14}}, color={127,0,127}));
          connect(enable, FF1.k) annotation (Line(
                points={{-100,70},{-80,70},{-80,-14},{-74,-14}}, color={127,0,127}));
          connect(count, FF1.clk) annotation (Line(
                points={{-100,-70},{-86,-70},{-86,0},{-74,0}}, color={127,0,127}));
          connect(FF1.q, FF2.clk) annotation (Line(
                points={{-34,14},{-30,14},{-30,0},{-20,0}}, color={127,0,127}));
          connect(FF2.q, FF3.clk) annotation (Line(
                points={{20,14},{24,14},{24,0},{34,0}}, color={127,0,127}));
          connect(FF2.j, enable) annotation (Line(
                points={{-20,14},{-26,14},{-26,70},{-100,70}}, color={127,0,127}));
          connect(FF2.k, FF2.j) annotation (Line(
                points={{-20,-14},{-26,-14},{-26,14},{-20,14}}, color={127,0,127}));
          connect(FF3.k, FF3.j) annotation (Line(
                points={{34,-14},{28,-14},{28,14},{34,14}}, color={127,0,127}));
          connect(FF3.j, enable) annotation (Line(
                points={{34,14},{28,14},{28,70},{-100,70}}, color={127,0,127}));
          connect(FF3.q, q2) annotation (Line(
                points={{74,14},{80,14},{80,70},{100,70}}, color={127,0,127}));
          connect(FF1.q, q0) annotation (Line(points={{-34,14},{-30,14},{-30,-70},{
                    100,-70}}, color={127,0,127}));
          connect(FF2.q, q1) annotation (Line(points={{20,14},{24,14},{24,-50},{86,
                    -50},{86,0},{100,0}}, color={127,0,127}));
           annotation (
             Documentation(info="<html>
<p>The Counter3 counts the high-low slopes of the count signal, if the enable signal is set to be true. It is composed by three JK flipflops. q0, q1, and q2 are the bits of the resulting number, where q0 is the lowest, and q2 the highest bit.</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={
              Rectangle(
                extent={{-90,100},{90,-100}},
                lineThickness=0.5,
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-80,80},{-40,60}},
                textString="ENABLE"),
              Text(
                extent={{64,80},{86,60}},
                textString="Q2"),
              Text(
                extent={{64,-60},{86,-80}},
                textString="Q0"),
              Text(
                extent={{-150,-100},{150,-160}},
                textColor={0,0,255},
                textString="%name"),
              Text(
                extent={{-60,40},{60,0}},
                textString="Counter3"),
              Text(
                extent={{-80,-60},{-40,-80}},
                textString="COUNT"),
              Text(
                extent={{62,8},{84,-12}},
                textString="Q1")}));
        end Counter3;

        model Counter "Generic N Bit Counter"
        import D = Modelica.Electrical.Digital;
        import L = Modelica.Electrical.Digital.Interfaces.Logic;

          parameter Integer n=3 "Number of bits";
          parameter SI.Time delayTime=0.001 "Delay of each JKFF";
          parameter D.Interfaces.Logic q0=L.'0' "Initial value";
          D.Interfaces.DigitalInput enable
                                        annotation (Placement(transformation(extent=
                     {{-110,60},{-90,80}})));
          D.Interfaces.DigitalInput count
                                        annotation (Placement(transformation(extent=
                     {{-110,-80},{-90,-60}})));
          D.Examples.Utilities.JKFF FF[n](each delayTime=delayTime,each q0=q0);
          D.Interfaces.DigitalOutput q[n] annotation (Placement(transformation(
                    extent={{90,-80},{110,80}})));
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
          annotation (
            Documentation(info="<html>
<p>The Counter is a generic component, which counts the high-low slopes of the count signal, if the enable signal is set to be true. It is composed by  n JK flipflops. q is the resulting number, where q[0] is the lowest, and q[n] the highest bit.</p>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Rectangle(
                extent={{90,80},{110,-80}},
                lineColor={127,0,127},
                fillColor={127,0,127},
                fillPattern=FillPattern.Solid)}),
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={
              Rectangle(
                extent={{90,80},{110,-80}},
                lineColor={127,0,127},
                fillColor={127,0,127},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-90,100},{90,-100}},
                lineThickness=0.5,
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-80,80},{-40,60}},
                textString="ENABLE"),
              Text(
                extent={{66,8},{88,-12}},
                textString="Q"),
              Text(
                extent={{-150,-100},{150,-160}},
                textColor={0,0,255},
                textString="%name"),
              Text(
                extent={{-40,40},{40,0}},
                textString="Counter"),
              Text(
                extent={{-80,-60},{-40,-80}},
                textString="COUNT")}));
        end Counter;
          annotation (Documentation(info="<html>
<p>This package contains utility components used by package Examples. Each component is built up hierarchically by components of the Gates package. In this way the Gates components were tested, and their usage is demonstrated.</p>
</html>"));
      end Utilities;

        annotation (Documentation(info="<html>
<p>This package contains examples that demonstrate the usage of the components of the Electrical.Digital library.</p>
<p>The examples are simple to understand. They will show a typical behavior of the components, and they will give hints to users.</p>
</html>"));

      end Examples;

      package Interfaces "Basic definitions"
        extends Modelica.Icons.InterfacesPackage;

        type Logic = enumeration(
        'U' "U  Uninitialized",
        'X' "X  Forcing Unknown",
        '0' "0  Forcing 0",
        '1' "1  Forcing 1",
        'Z' "Z  High Impedance",
        'W' "W  Weak Unknown",
        'L' "L  Weak 0",
        'H' "H  Weak 1",
        '-' "-  Do not care") "Logic values and their coding according to IEEE 1164 STD_ULOGIC type"
              annotation (Documentation(info="<html>
<p><strong>Code Table:</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Logic value</strong></td>
      <td><strong>Meaning</strong></td>
  </tr>

  <tr><td>'U'</td> <td>Uninitialized</td></tr>
  <tr><td>'X'</td> <td>Forcing Unknown</td></tr>
  <tr><td>'0'</td> <td>Forcing 0</td></tr>
  <tr><td>'1'</td> <td>Forcing 1</td></tr>
  <tr><td>'Z'</td> <td>High Impedance</td></tr>
  <tr><td>'W'</td> <td>Weak Unknown</td></tr>
  <tr><td>'L'</td> <td>Weak 0</td></tr>
  <tr><td>'H'</td> <td>Weak 1</td></tr>
  <tr><td>'-'</td> <td>Do not care</td></tr>
</table>

</html>"));

        type UX01 = enumeration(
        'U' "U  Uninitialized",
        'X' "X  Forcing Unknown",
        '0' "0  Forcing 0",
        '1' "1  Forcing 1") "4-valued subtype of IEEE 1164 STD_ULOGIC type"
          annotation (Documentation(info="<html>
<p><strong>Code Table:</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Logic value</strong></td>
      <td><strong>Meaning</strong></td>
  </tr>

  <tr><td>'U'</td> <td>Uninitialized</td></tr>
  <tr><td>'X'</td> <td>Forcing Unknown</td></tr>
  <tr><td>'0'</td> <td>Forcing 0</td></tr>
  <tr><td>'1'</td> <td>Forcing 1</td></tr>

</table>
</html>"));
        type Strength = enumeration(
        'S_X01' "S_X01  Forcing X, 0 and 1",
        'S_X0H' "S_X0H  Forcing X, 0 and Weak 1",
        'S_XL1' "S_XL1  Forcing X, 1 and Weak 0",
        'S_X0Z' "S_X0Z  Forcing X, 0 and High Impedance",
        'S_XZ1' "S_XZ1  Forcing X, 1 and High Impedance",
        'S_WLH' "S_WLH  Weak X, 0 and 1",
        'S_WLZ' "S_WLZ  Weak X, 0 and High Impedance",
        'S_WZH' "S_WZH  Weak X, 1 and High Impedance",
        'S_W0H' "S_W0H  Weak X, 1 and Forcing 0",
        'S_WL1' "S_WL1  Weak X, 0 and Forcing 1") "Output strengths of registers" annotation (Documentation(info="<html>

<p><strong>Strength Table:</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Strength</strong></td>
      <td><strong>Output conversion to</strong></td>
  </tr>

  <tr><td>'S_X01'</td> <td>Forcing X, 0, 1</td></tr>
  <tr><td>'S_X0H'</td> <td>Forcing X, 0 and Weak 1</td></tr>
  <tr><td>'S_XL1'</td> <td>Forcing X, 1 and Weak 0</td></tr>
  <tr><td>'S_X0Z'</td> <td>Forcing X, 0 and High Impedance</td></tr>
  <tr><td>'S_XZ1'</td> <td>Forcing X, 1 and High Impedance</td></tr>
  <tr><td>'S_WLH'</td> <td>Weak X, 0, 1</td></tr>
  <tr><td>'S_WLZ'</td> <td>Weak X, 0 and High Impedance</td></tr>
  <tr><td>'S_WZH'</td> <td>Weak X, 1 and High Impedance</td></tr>
  <tr><td>'S_W0H'</td> <td>Weak X, 1 and Forcing 0</td></tr>
  <tr><td>'S_WL1'</td> <td>Weak X, 0 and Forcing 1</td></tr>
</table>
</html>"));

        connector DigitalSignal = Logic "Digital port (both input/output possible)"
          annotation (Documentation(info="<html>
<p>DigitalSignal is the basic digital connector definition. A direction (input, output) is not yet defined. DigitalSignal is of type Logic. It can have the logic values (U, X, 0, 1, ...) which are internally coded by integer values by using the enumeration (c.f. the definition of type Logic).</p>
</html>"));

        connector DigitalInput = input DigitalSignal "Input DigitalSignal as connector"
          annotation (defaultComponentName="x",
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Rectangle(
            extent={{-100,-100},{100,100}},
            lineColor={127,0,127},
            fillColor={127,0,127},
            fillPattern=FillPattern.Solid)}),
            Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Text(
            extent={{-150,-100},{150,-160}},
            textColor={127,0,127},
            textString="%name"), Rectangle(
            extent={{-100,-100},{100,100}},
            lineColor={127,0,127},
            fillColor={127,0,127},
            fillPattern=FillPattern.Solid)}),
          Documentation(info="<html>
<p>DigitalInput is the digital input connector definition. DigitalInput is of type Logic. It can have the logic values (U, X, 0, 1, ...) which are internally coded by integer values by using the enumeration (c.f. the definition of type Logic).</p>
</html>"));

        connector DigitalOutput = output DigitalSignal "Output DigitalSignal as connector"
          annotation (defaultComponentName="y", Icon(coordinateSystem(
                preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
          graphics={Polygon(
            points={{-100,100},{100,0},{-100,-100},{-100,100}},
            lineColor={127,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
                                           Diagram(coordinateSystem(
                preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
          graphics={Polygon(
            points={{-100,100},{100,0},{-100,-100},{-100,100}},
            lineColor={127,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid), Text(
            extent={{-150,-100},{150,-160}},
            textColor={127,0,127},
            textString="%name")}),
          Documentation(info=
                         "<html>
<p>DigitalOutput is the digital output connector definition. DigitalOutput is of type Logic. It can have the logic values (U, X, 0, 1, ...) which are internally coded by integer values by using the enumeration (c.f. the definition of type Logic). The arrow shape symbolizes the signal flow direction.</p>
</html>"));

        partial block SISO "Single input, single output"
      import D = Modelica.Electrical.Digital;
          D.Interfaces.DigitalInput x "Connector of Digital input signal"
                       annotation (Placement(transformation(extent={{-70,-10},{-50,
                    10}})));
          D.Interfaces.DigitalOutput y "Connector of Digital output signal"
                        annotation (Placement(transformation(extent={{90,-10},{110,
                    10}})));
          annotation (Icon(
                coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Rectangle(
              extent={{-50,100},{50,-100}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Line(points={{50,0},{92,0}},
                color={127,0,127})}),
            Documentation(info="<html>
<p>SISO is a partial model for the connection pattern with <strong>s</strong>ingle (scalar) digital <strong>i</strong>nput and <strong>s</strong>ingle (scalar) digital <strong>o</strong>utput. Besides the connectors it provides a rectangle for the icon which can be filled in by the component which inherits the SISO model.</p>
</html>"));
        end SISO;

        partial block MISO "Multiple input - single output"
      import D = Modelica.Electrical.Digital;

          parameter Integer n(final min=2) = 2 "Number of inputs";
          D.Interfaces.DigitalInput x[n]
        "Connector of Digital input signal vector"
                                         annotation (Placement(transformation(
                  extent={{-70,-80},{-50,80}})));
          D.Interfaces.DigitalOutput y "Connector of Digital output signal"
                        annotation (Placement(transformation(extent={{90,-10},{110,
                    10}})));
          annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-50,100},{50,-100}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Line(points={{50,0},{90,0}},
                color={127,0,127})}),
            Documentation(info="<html>
<p>MISO is a partial model for the connection pattern with <strong>m</strong>ultiple (vector) digital <strong>i</strong>nput and <strong>s</strong>ingle (scalar) digital <strong>o</strong>utput. Besides the connectors it provides a rectangle for the icon which can be filled in by the component which inherits the MISO model.</p>
</html>"));
        end MISO;

        partial block MIMO "Multiple input - multiple output"
      import D = Modelica.Electrical.Digital;

          parameter Integer n(final min=1) = 1
        "Number of inputs = Number of outputs";
          D.Interfaces.DigitalInput x[n]
        "Connector of Digital input signal vector"
                                         annotation (Placement(transformation(
                  extent={{-70,-80},{-50,80}})));
          D.Interfaces.DigitalOutput y[n]
        "Connector of Digital output signal vector"
                        annotation (Placement(transformation(extent={{90,-10},{110,
                    10}})));
          annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Rectangle(
              extent={{-50,100},{50,-100}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{50,0},{90,0}}, color={127,0,127}),
            Rectangle(
              extent={{50,80},{70,-80}},
              lineColor={127,33,107},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
            Documentation(info="<html>
<p>MIMO is a partial model for the connection pattern with <strong>m</strong>ultiple (vector) digital <strong>i</strong>nput and <strong>m</strong>ultiple  (vector) digital <strong>o</strong>utput. Besides the connectors it provides a rectangle for the icon which can be filled in by the component which inherits the MISO model.</p>
</html>"));
        end MIMO;

        partial model MemoryBase "Base model for memory elements"
              import D = Modelica.Electrical.Digital;
              import L = Modelica.Electrical.Digital.Interfaces.Logic;
              import S = Modelica.Electrical.Digital.Interfaces.Strength;
              import T = Modelica.Electrical.Digital.Tables;

              parameter SI.Time tHL=0 "High->Low delay";
              parameter SI.Time tLH=0 "Low->High delay";
              parameter S strength = S.'S_X01' "Output strength";
              parameter Integer n_addr(min=1) = 2 "Addr width";
              parameter Integer n_data(min=1) = 2 "Data width";
              parameter String fileName = Modelica.Utilities.Files.loadResource("modelica://Modelica/Resources/Data/Electrical/Digital/Memory_Matrix.txt")
                "File where matrix for memory is stored"
                annotation(Dialog(group="Table data definition", loadSelector(filter="Text files (*.txt)", caption="Open file in which table is present")));

              DigitalInput RE "Read enable" annotation (Placement(transformation(
                extent={{-100,-30},{-84,-14}}), iconTransformation(extent={{-100,-30},{-84,-14}})));
              DigitalInput addr[n_addr] "Address" annotation (Placement(transformation(
                extent={{-100,50},{-80,70}}), iconTransformation(extent={{-100,50},{-80,70}})));
              DigitalOutput dataOut[n_data] "Data output" annotation (Placement(transformation(
                extent={{80,10},{100,30}}), iconTransformation(extent={{80,10},{100,30}})));

              function getMemory "Get Memory"
                extends Modelica.Icons.Function;
                input String filename;
                input Integer n_addr "Addr width";
                input Integer n_data "Data width";
                output L m[integer(2^n_addr),n_data] "Memory with data, lowest bit on left side";
                output String data;
                output Integer bit;
              algorithm
                for i in 1:(2^n_addr) loop
                  data := Modelica.Utilities.Streams.readLine(filename, integer(i));
                  for j in 1:n_data loop
                    bit := Modelica.Utilities.Strings.scanInteger(data, (2*j-1));
                    if bit == 1 then
                      m[integer(i),j] := L.'1';
                    elseif bit == 0 then
                      m[integer(i),j] := L.'0';
                    else
                      m[integer(i),j] := L.'X';
                    end if;
                  end for;
                end for;
              end getMemory;

    protected
              L nextstate[n_data](start=fill(L.'U',n_data));
              L mem_word[n_data](start=fill(L.'U',n_data));
              Integer int_addr;
              DigitalOutput yy[n_data](start=fill(L.'U',n_data));
              D.Delay.InertialDelaySensitive inertialDelaySensitive[n_data](each tLH=tLH, each tHL=tHL);

              function address "Compute memory address"
                extends Modelica.Icons.Function;
                input Integer n_addr;
                input L addr[n_addr];
                output Integer int_addr;
      protected
                L addr_bit;
              algorithm
                int_addr := 1;
                for i in 1:n_addr loop
                  addr_bit := T.X01Table[addr[i]];
                  if addr_bit == L.'1' then
                     int_addr := int_addr + integer(2^(i-1));
                  elseif addr_bit == L.'X' then
                     int_addr := 0;
                     break;
                  end if;
                end for;
              end address;

        equation
              for i in 1:n_data loop
                connect(yy[i], inertialDelaySensitive[i].x);
                connect(inertialDelaySensitive[i].y, dataOut[i]);
              end for;

            annotation(Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
              graphics={
                Rectangle(
                  extent={{-60,80},{60,-80}},
                  lineColor={127,0,127},
                  lineThickness=0.5),
                Line(
                  points={{-84,60},{-60,60}},
                  color={127,0,127},
                  thickness=1),
                Line(
                  points={{60,20},{84,20}},
                  color={127,0,127},
                  thickness=1),
                Line(
                  points={{-84,-20},{-60,-20}},
                  color={127,0,127}),
                Line(
                  points={{-60,-10},{-46,-20},{-60,-30}},
                  color={127,0,127}),
                Text(
                  extent={{-41,-5},{-24,-34}},
                  textColor={127,33,107},
                  textString="RE")}));
        end MemoryBase;

        annotation (Documentation(info="<html>
<p>This package contains basic definitions: Type definitions of Logic and Strength, interface definitions (connectors) for digital electrical components, and partial models for connection patterns which are often used.</p>
</html>"));
      end Interfaces;

  package Tables "Truth tables for all components of package Digital"
    extends Modelica.Icons.Package;

    import D = Modelica.Electrical.Digital;
    import L = Modelica.Electrical.Digital.Interfaces.Logic;
    import R = Modelica.Electrical.Digital.Interfaces.UX01;
    import S = Modelica.Electrical.Digital.Interfaces.Strength;

    constant D.Interfaces.Logic AndTable[L, L]=[
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

    constant D.Interfaces.Logic OrTable[L, L]=[
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

    constant D.Interfaces.Logic NotTable[L]={
        L.'U',L.'X',L.'1',L.'0',L.'X',L.'X',L.'1',L.'0',L.'X'}
      "9-value logic for 'not'";

    constant D.Interfaces.Logic XorTable[L, L]=[
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

    constant D.Interfaces.Logic ResolutionTable[L, L]=[
        L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'U', L.'X', L.'0', L.'X', L.'0', L.'0', L.'0', L.'0', L.'X';
        L.'U', L.'X', L.'X', L.'1', L.'1', L.'1', L.'1', L.'1', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'Z', L.'W', L.'L', L.'H', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'W', L.'W', L.'W', L.'W', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'L', L.'W', L.'L', L.'W', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'H', L.'W', L.'W', L.'H', L.'X';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X']
      "9-value logic for 'wiredX'";
    constant D.Interfaces.Logic X01Table[L]={
        L.'X',L.'X',L.'0',L.'1',L.'X',L.'X',L.'0',L.'1',L.'X'};

    constant D.Interfaces.Logic X01ZTable[L]={
        L.'X',L.'X',L.'0',L.'1',L.'Z',L.'X',L.'0',L.'1',L.'Z'};

    constant D.Interfaces.Logic UX01Table[L]={
        L.'U',L.'X',L.'0',L.'1',L.'X',L.'X',L.'0',L.'1',L.'X'};

    constant D.Interfaces.UX01 UX01Conv[L]={
        R.'U',R.'X',R.'0',R.'1',R.'X',R.'X',R.'0',R.'1',R.'X'};

    constant Integer DelayTable[L, L]=[
         0,  0, -1,  1,  0,  0, -1,  1,  0;
         0,  0, -1,  1,  0,  0, -1,  1,  0;
         1,  1,  0,  1,  1,  1,  0,  1,  1;
        -1, -1, -1,  0, -1, -1, -1,  0, -1;
         0,  0, -1,  1,  0,  0, -1,  1,  0;
         0,  0, -1,  1,  0,  0, -1,  1,  0;
         1,  1,  0,  1,  1,  1,  0,  1,  1;
        -1, -1, -1,  0, -1, -1, -1,  0, -1;
         0,  0, -1,  1,  0,  0, -1,  1,  0] "Delay selection for signal change by [old_signal, new_signal] reading:
      -1: High-Low delay |
       0: no delay |
       1: Low-High delay";

    constant Integer ClockMap[L, L]=[
        0, 0, 0, 2, 0, 0, 0, 2, 0;
        0, 0, 0, 2, 0, 0, 0, 2, 0;
        2, 2, 0, 1, 2, 2, 0, 1, 2;
        0, 0, 0, 0, 0, 0, 0, 0, 0;
        0, 0, 0, 2, 0, 0, 0, 2, 0;
        0, 0, 0, 2, 0, 0, 0, 2, 0;
        2, 2, 0, 1, 2, 2, 0, 1, 0;
        0, 0, 0, 0, 0, 0, 0, 0, 0;
        0, 0, 0, 2, 0, 0, 0, 2, 0] "Edge detection by [pre(clock), clock] reading:
    0: 0-Transition |
    1: rising edge  |
    2: X-Transition";

    constant D.Interfaces.Logic StrengthMap[L, S]=
        [L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U';
         L.'X', L.'X', L.'X', L.'X', L.'X', L.'W', L.'W', L.'W', L.'W', L.'W';
         L.'0', L.'0', L.'L', L.'0', L.'Z', L.'L', L.'L', L.'Z', L.'0', L.'L';
         L.'1', L.'H', L.'1', L.'Z', L.'1', L.'H', L.'Z', L.'H', L.'H', L.'1';
         L.'X', L.'X', L.'X', L.'X', L.'X', L.'W', L.'W', L.'W', L.'W', L.'W';
         L.'X', L.'X', L.'X', L.'X', L.'X', L.'W', L.'W', L.'W', L.'W', L.'W';
         L.'0', L.'0', L.'L', L.'0', L.'Z', L.'L', L.'L', L.'Z', L.'0', L.'L';
         L.'1', L.'H', L.'1', L.'Z', L.'1', L.'H', L.'Z', L.'H', L.'H', L.'1';
         L.'X', L.'X', L.'X', L.'X', L.'X', L.'W', L.'W', L.'W', L.'W', L.'W']
      "Output strength conversion by [signal, strength] reading";

    constant D.Interfaces.Logic NXferTable[L, L]=[
        L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z';
        L.'U', L.'X', L.'0', L.'1', L.'Z', L.'W', L.'L', L.'H', L.'X';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z';
        L.'U', L.'X', L.'0', L.'1', L.'Z', L.'W', L.'L', L.'H', L.'X';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X']
      "NX Transfer by [enable, input] reading";

    constant D.Interfaces.Logic NRXferTable[L, L]=[
        L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U';
        L.'U', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W';
        L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z';
        L.'U', L.'W', L.'L', L.'H', L.'Z', L.'W', L.'L', L.'H', L.'W';
        L.'U', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W';
        L.'U', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W';
        L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z';
        L.'U', L.'W', L.'L', L.'H', L.'Z', L.'W', L.'L', L.'H', L.'W';
        L.'U', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W']
      "NRX Transfer by [enable, input] reading";

    constant D.Interfaces.Logic PXferTable[L, L]=[
        L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'Z', L.'W', L.'L', L.'H', L.'X';
        L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'Z', L.'W', L.'L', L.'H', L.'X';
        L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X']
      "PX Transfer by [enable, input] reading";

    constant D.Interfaces.Logic PRXferTable[L, L]=[
        L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U';
        L.'U', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W';
        L.'U', L.'W', L.'L', L.'H', L.'Z', L.'W', L.'L', L.'H', L.'W';
        L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z';
        L.'U', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W';
        L.'U', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W';
        L.'U', L.'W', L.'L', L.'H', L.'Z', L.'W', L.'L', L.'H', L.'W';
        L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z';
        L.'U', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W']
      "PRX Transfer by [enable, input] reading";

    constant D.Interfaces.Logic Buf3sTable[S, R, R]=[
        {{{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'X',L.'X',L.'X'},{L.'Z',L.'Z',L.'Z',L.'Z'},{L.'U',L.'X',L.'0',L.'1'}},
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'X',L.'X',L.'X'},{L.'Z',L.'Z',L.'Z',L.'Z'},{L.'U',L.'X',L.'0',L.'H'}},
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'X',L.'X',L.'X'},{L.'Z',L.'Z',L.'Z',L.'Z'},{L.'U',L.'X',L.'L',L.'1'}},
         {{L.'U',L.'U',L.'U',L.'Z'},{L.'U',L.'X',L.'X',L.'Z'},{L.'Z',L.'Z',L.'Z',L.'Z'},{L.'U',L.'X',L.'0',L.'Z'}},
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'X',L.'X',L.'X'},{L.'Z',L.'Z',L.'Z',L.'Z'},{L.'U',L.'X',L.'Z',L.'1'}},
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'W',L.'W',L.'W'},{L.'Z',L.'Z',L.'Z',L.'Z'},{L.'U',L.'W',L.'L',L.'H'}},
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'W',L.'W',L.'Z'},{L.'Z',L.'Z',L.'Z',L.'Z'},{L.'U',L.'W',L.'L',L.'Z'}},
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'W',L.'W',L.'W'},{L.'Z',L.'Z',L.'Z',L.'Z'},{L.'U',L.'W',L.'Z',L.'H'}},
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'W',L.'W',L.'W'},{L.'Z',L.'Z',L.'Z',L.'Z'},{L.'U',L.'W',L.'0',L.'H'}},
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'W',L.'W',L.'W'},{L.'Z',L.'Z',L.'Z',L.'Z'},{L.'U',L.'W',L.'L',L.'1'}}}]
      "Tristate Table by [strength, enable, input] reading, high-active enable";

    constant D.Interfaces.Logic Buf3slTable[S, R, R]=[
        {{{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'X',L.'X',L.'X'},{L.'U',L.'X',L.'0',L.'1'},{L.'Z',L.'Z',L.'Z',L.'Z'}},
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'X',L.'X',L.'X'},{L.'U',L.'X',L.'0',L.'H'},{L.'Z',L.'Z',L.'Z',L.'Z'}},
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'X',L.'X',L.'X'},{L.'U',L.'X',L.'L',L.'1'},{L.'Z',L.'Z',L.'Z',L.'Z'}},
         {{L.'U',L.'U',L.'U',L.'Z'},{L.'U',L.'X',L.'X',L.'Z'},{L.'U',L.'X',L.'0',L.'Z'},{L.'Z',L.'Z',L.'Z',L.'Z'}},
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'X',L.'X',L.'X'},{L.'U',L.'X',L.'Z',L.'1'},{L.'Z',L.'Z',L.'Z',L.'Z'}},
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'W',L.'W',L.'W'},{L.'U',L.'W',L.'L',L.'H'},{L.'Z',L.'Z',L.'Z',L.'Z'}},
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'W',L.'W',L.'Z'},{L.'U',L.'W',L.'L',L.'Z'},{L.'Z',L.'Z',L.'Z',L.'Z'}},
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'W',L.'W',L.'W'},{L.'U',L.'W',L.'Z',L.'H'},{L.'Z',L.'Z',L.'Z',L.'Z'}},
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'W',L.'W',L.'W'},{L.'U',L.'W',L.'0',L.'H'},{L.'Z',L.'Z',L.'Z',L.'Z'}},
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'W',L.'W',L.'W'},{L.'U',L.'W',L.'L',L.'1'},{L.'Z',L.'Z',L.'Z',L.'Z'}}}]
      "Tristate Table by [strength, enable, input] reading, low-active enable";

    constant D.Interfaces.Logic MUX2x1Table[R, R, R]=[
        {{{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'X',L.'0',L.'1'},{L.'U',L.'U',L.'U',L.'U'}},
         {{L.'U',L.'X',L.'U',L.'U'},{L.'U',L.'X',L.'X',L.'X'},{L.'U',L.'X',L.'0',L.'1'},{L.'X',L.'X',L.'X',L.'X'}},
         {{L.'U',L.'U',L.'0',L.'U'},{L.'U',L.'X',L.'0',L.'X'},{L.'U',L.'X',L.'0',L.'1'},{L.'0',L.'0',L.'0',L.'0'}},
         {{L.'U',L.'U',L.'U',L.'1'},{L.'U',L.'X',L.'X',L.'1'},{L.'U',L.'X',L.'0',L.'1'},{L.'1',L.'1',L.'1',L.'1'}}}]
      "Multiplexer Table by [select, input1, input0] reading";

    annotation (Documentation(info="<html>

</html>"));
  end Tables;

      package Delay "Delay blocks"
        extends Modelica.Icons.Package;

        partial block DelayParams "Definition of delay parameters"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
          parameter SI.Time tLH(start=0) "Rise inertial delay";
          parameter SI.Time tHL(start=0) "Fall inertial delay";
          parameter L y0=L.'U' "Initial value of output";
          annotation (Documentation(info="<html>
<p>DelayParams is a partial model for providing delay times and inertial values. It is used in components of the package Gates which need the same parameters. The partial model does not have any behavior or equations.</p>
</html>"));
        end DelayParams;

        model TransportDelay "Transport delay with initial parameter"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends D.Interfaces.SISO(x(start=L.'U',fixed=true));
          parameter SI.Time delayTime(start=0) "Delay time";
          parameter D.Interfaces.Logic y0=L.'U' "Initial value of output";
          constant D.Interfaces.Logic LogicValues[:]=L.'U':L.'-';
    protected
          D.Interfaces.Logic x_delayed;
          Real xr "Auxiliary variable of type Real to use in delay()";

        equation
          xr = Integer(pre(x));
          x_delayed = LogicValues[integer(delay(xr, delayTime))];
          y = if delayTime > 0 then
                   (if time >= delayTime then x_delayed else y0) else
                     pre(x);
          annotation (Documentation(info="<html>
<p>
Provide the input as output exactly delayed by <em>Tdel</em>.
If time less than <em>Tdel</em> the initial value <em>initout</em> holds.
</p>
</html>", revisions="<html>
<dl>
<dt><em>August 11, 2003</em></dt>
<dd>by Christoph Clauss initially modelled.</dd>
</dl>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-50,100},{50,-100}},
              lineThickness=0.5,
              fillColor={213,170,255},
              fillPattern=FillPattern.Solid),
            Polygon(points={{-6,60},{-16,40},{4,40},{-6,60}}),
            Line(points={{0,60},{20,60}}),
            Line(points={{10,60},{10,40}}),
            Text(
              extent={{-50,-40},{50,-20}},
              textString="Transport"),
            Text(
              extent={{-50,-60},{50,-40}},
              textString="Delay")}));
        end TransportDelay;

        block InertialDelay "Inertial delay with initial parameter"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends D.Interfaces.SISO;
          parameter SI.Time delayTime(start=0)
        "Minimum time to hold value";
          parameter D.Interfaces.Logic y0=L.'U' "Initial value of output y";
    protected
          D.Interfaces.Logic y_auxiliary(start=y0, fixed=true);
          D.Interfaces.Logic x_old(start=y0, fixed=true);
          discrete SI.Time t_next(start=delayTime, fixed=true);

        algorithm
          when delayTime > 0 and change(x) then
            x_old := x;
            t_next := time + delayTime;
          elsewhen time >= t_next then
            y_auxiliary := x;
          end when;
          y := if delayTime > 0 then y_auxiliary else x;
          annotation (
            Documentation(info="<html>
<p>
Provides the input as output delayed by <em>delayTime</em> if the input holds its value for a longer time than <em>delayTime</em>.
If time is less than <em>delayTime</em> the initial value <em>y0</em> holds.
</p>
</html>", revisions="<html>
<dl>
<dt><em>August 12, 2003</em></dt>
<dd>by Christoph Clauss revised</dd>
<dt><em>March 19, 2003</em></dt>
<dd>by Martin Otter initially modelled.</dd>
</dl>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-50,100},{50,-100}},
              lineThickness=0.5,
              fillColor={213,170,255},
              fillPattern=FillPattern.Solid),
            Polygon(points={{-6,60},{-16,40},{4,40},{-6,60}}),
            Line(points={{10,60},{10,40}}),
            Line(points={{0,60},{20,60}}),
            Text(
              extent={{-50,-40},{50,-20}},
              textString="Inertial"),
            Text(
              extent={{-50,-60},{50,-40}},
              textString="Delay")}));
        end InertialDelay;

        model InertialDelaySensitive "Provide the input as output if it holds its value for a specific amount of time"

          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends D.Interfaces.SISO(x(start=L.'U',fixed=true),y(start=y0, fixed=true));
          parameter SI.Time tLH(start=0) "Rise inertial delay";
          parameter SI.Time tHL(start=0) "Fall inertial delay";
          parameter D.Interfaces.Logic y0=L.'U' "Initial value of output";
    protected
          constant Integer delayTable[L,L]=Modelica.Electrical.Digital.Tables.DelayTable
        "Specification of delay according to signal change";
          SI.Time delayTime;
          D.Interfaces.Logic y_auxiliary(start=y0, fixed=true);
          D.Interfaces.Logic y_old(start=y0, fixed=true);
          Integer lh;
          discrete SI.Time t_next;

        algorithm
          when {initial(),(tLH > 0 or tHL > 0) and change(x) and not initial()} then
            y_old := if initial() or pre(y) == L.'U' then y0 else pre(y);
            lh := delayTable[y_old, x];
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
            Documentation(info="<html>
<p>
Provides the input as output delayed by <em>Tdel</em> if the input holds its value for a longer time than <em>Tdel</em>.
If the time is less than <em>Tdel</em> the initial value <em>y0</em> holds.<br>
The delay <em>Tdel</em> depends on the values of the signal change. To calculate <em>Tdel</em>, the DelayTable specified in
Digital.Tables is used. If the corresponding value is 1, then <em>tLH</em> is used, if it is -1, then <em>tHL</em>
is used, if it is zero, the input is not delayed.
</p>
</html>", revisions="<html>
<ul>
<li><em>January 24, 2013</em> Initial value for y set to y0
       by Kristin Majetta and Christoph Clauss<br>
       </li>
<li><em>September 8, 2009</em> pre(y) and x are used to select <em>tHL</em> or <em>tLH</em>
       by Ulrich Donath<br>
       </li>
<li><em>January 13, 2005</em> improved when-conditions and declaration of delayTable
       by Dynasim<br>
       </li>
<li><em>September 15, 2004</em> color changed, names changed
       by Christoph Clauss<br>
       </li>
<li><em>May 12, 2004</em> test <em>if Tdel=0</em> replaced
       by Christoph Clauss<br>
       </li>
<li><em>February 5, 2004</em> handling of <em>tHL=0</em> or <em>tLH=0</em> revised
       by Christoph Clauss<br>
       </li>
<li><em>October 12, 2003</em>
       by Christoph Clauss<br>
       initially modelled</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-50,100},{50,-100}},
              lineThickness=0.5,
              fillColor={213,170,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-50,-40},{50,-20}},
              textString="Inertial"),
            Text(
              extent={{-50,-60},{50,-40}},
              textString="Delay"),
            Text(
              extent={{-50,-80},{50,-60}},
              textString="sensitive"),
            Polygon(points={{-6,60},{-16,40},{4,40},{-6,60}}),
            Line(points={{10,60},{10,40}}),
            Line(points={{0,60},{20,60}})}));
        end InertialDelaySensitive;

        model InertialDelaySensitiveVector "Delay of a vector of digital signals"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      import S = Modelica.Electrical.Digital.Interfaces.Strength;
      import T = Modelica.Electrical.Digital.Tables;
          parameter SI.Time tHL=0 "High->Low delay";
          parameter SI.Time tLH=0 "Low->High delay";
          parameter Integer n(min=1) = 1 "Data width";
          D.Interfaces.DigitalInput x[n]
            annotation (Placement(transformation(extent={{-100,-12},{-76,12}}),
                iconTransformation(extent={{-100,-15},{-72,14}})));
          D.Interfaces.DigitalOutput y[n] annotation (Placement(transformation(
                  extent={{72,-14},{100,14}}), iconTransformation(extent={{72,-14},
                    {100,14}})));
          Digital.Delay.InertialDelaySensitive inertialDelaySensitive[n](each tLH=
                tLH, each tHL=tHL);
        equation
          for i in 1:n loop
            connect(x[i], inertialDelaySensitive[i].x);
            connect(inertialDelaySensitive[i].y, y[i]);
          end for;
          annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Rectangle(
              extent={{-50,54},{48,-54}},
              lineColor={127,0,127},
              lineThickness=0.5,
              fillPattern=FillPattern.Solid,
              fillColor={255,255,255}),
            Line(
              points={{-80,0},{-50,0}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{48,0},{80,0}},
              color={127,0,127},
              thickness=1),
            Text(
              extent={{-40,52},{38,-20}},
              textColor={127,33,107},
              textString="DELAY"),
            Text(
              extent={{-26,12},{18,-32}},
              textColor={127,0,127},
              textString="signal "),
            Text(
              extent={{-32,0},{28,-62}},
              textColor={127,0,127},
              textString="sensitive")}), Documentation(info="<html>

<p>
The delay element <strong>Inertial Delay Sensitive</strong> is applied to a vector of n signals.
The parameters <em>tLH</em> and <em>tHL</em> are valid for each of the n signals.
</p>
</html>", revisions="<html>
<ul>
<li><em>September 11, 2009</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>"));
        end InertialDelaySensitiveVector;
        annotation (Documentation(info="<html>
<p>The Delay package collects the delay blocks which are used in many components. Both transport and inertial delay are offered for scalar connectors. The most advanced component is the sensitive inertial delay the delay time of which is chosen in dependency of the signal values. This component is also available for vector valued input.</p>
</html>"));
      end Delay;

      package Basic "Basic logic blocks without delays"
        extends Modelica.Icons.Package;

        model Not "Not logic component without delay"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends D.Interfaces.SISO;
    protected
          D.Interfaces.Logic auxiliary(start=L.'0', fixed=true);
        equation
          auxiliary =Modelica.Electrical.Digital.Tables.NotTable[x];
          y = pre(auxiliary);
          annotation (
            Documentation(info="<html>
<p>Not component with 1 input value, without delay.</p>
<p>According to the standard logic not table (Tables.NotTable) the output value is calculated.</p>
<p>To avoid loops in the numerical treatment, the pre operator is applied to the output.</p>
</html>", revisions="<html>
<dl>
<dt><em>August 14, 2003</em></dt>
<dd>by Teresa Schlegel initially modelled.</dd>
</dl>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Text(
              extent={{-50,40},{50,80}},
              textString="1"),
            Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name"),
            Ellipse(
              extent={{50,6},{62,-6}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
        end Not;

        model And "And logic component with multiple input and one output"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends D.Interfaces.MISO;
    protected
          D.Interfaces.Logic auxiliary[n](each start=L.'U');
          D.Interfaces.Logic auxiliary_n( start=L.'U', fixed=true);
        equation
          auxiliary[1] = x[1];
          for i in 1:n - 1 loop
            auxiliary[i + 1] =Modelica.Electrical.Digital.Tables.AndTable[
          auxiliary[i], x[i + 1]];
          end for;
          auxiliary_n = auxiliary[n];
          y = pre(auxiliary_n);
          annotation (
            Documentation(info="<html>
<p>And component with multiple input values and one output.</p>
<p>According to the standard logic and table (Tables.AndTable) the output value is calculated.</p>
<p>To avoid loops in the numerical treatment, the pre operator is applied to the output.</p>
</html>", revisions="<html>
<ul>
<li><em>September 15, 2004</em> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><em>October 22, 2003</em>
       by  Teresa Schlegel<br>
       initially modelled.</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Text(
              extent={{-50,40},{50,80}},
              textString="&"), Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name")}));
        end And;

        model Nand "Nand logic component with multiple input and one output"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends D.Interfaces.MISO;
    protected
          D.Interfaces.Logic auxiliary[n](each start=L.'U');
          D.Interfaces.Logic auxiliary_n( start=L.'U', fixed=true);
        equation
          auxiliary[1] = x[1];
          for i in 1:n - 1 loop
            auxiliary[i + 1] =Modelica.Electrical.Digital.Tables.AndTable[
          auxiliary[i], x[i + 1]];
          end for;
          auxiliary_n = Modelica.Electrical.Digital.Tables.NotTable[auxiliary[n]];
          y = pre(auxiliary_n);
          annotation (
            Documentation(info="<html>
<p>Nand component with multiple input values and one output.</p>
<p>According to the standard logic and table (Tables.AndTable) an intermediate value is calculated, to which the not table (Tables.NotTable) is applied.</p>
<p>To avoid loops in the numerical treatment, the pre operator is applied to the output.</p>
</html>", revisions="<html>
<ul>
<li><em>September 15, 2004</em> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><em>October 22, 2003</em>
       by  Teresa Schlegel<br>
       initially modelled.</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Text(
              extent={{-50,40},{50,80}},
              textString="&"),
            Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name"),
            Ellipse(
              extent={{50,6},{62,-6}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
        end Nand;

        model Or "Or logic component with multiple input and one output"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends D.Interfaces.MISO;
    protected
          D.Interfaces.Logic auxiliary[n](each start=L.'U');
          D.Interfaces.Logic auxiliary_n( start=L.'U', fixed=true);
        equation
          auxiliary[1] = x[1];
          for i in 1:n - 1 loop
            auxiliary[i + 1] =Modelica.Electrical.Digital.Tables.OrTable[
          auxiliary[i], x[i + 1]];
          end for;
          auxiliary_n = auxiliary[n];
          y = pre(auxiliary_n);
          annotation (
            Documentation(info="<html>
<p>Or component with multiple input values and one output.</p>
<p>According to the standard logic or table (Tables.OrTable) the output value is calculated.</p>
<p>To avoid loops in the numerical treatment, the pre operator is applied to the output.</p>
</html>", revisions="<html>
<ul>
<li><em>September 15, 2004</em> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><em>October 22, 2003</em>
       by  Teresa Schlegel<br>
       initially modelled.</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Text(
              extent={{-50,40},{50,80}},
              textString=">=1"), Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name")}));
        end Or;

        model Nor "Nor logic component with multiple input and one output"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends D.Interfaces.MISO;
        //  D.Interfaces.Logic auxiliary[n](each start=L.'U', each fixed=true);
    protected
          D.Interfaces.Logic auxiliary[n](each start=L.'U');
          D.Interfaces.Logic auxiliary_n( start=L.'U', fixed=true);
        equation
          auxiliary[1] = x[1];
          for i in 1:n - 1 loop
            auxiliary[i + 1] =Modelica.Electrical.Digital.Tables.OrTable[
          auxiliary[i], x[i + 1]];
          end for;
          auxiliary_n = Modelica.Electrical.Digital.Tables.NotTable[auxiliary[n]];
          y = pre(auxiliary_n);
          annotation (
            Documentation(info="<html>
<p>Nor component with multiple input values and one output.</p>
<p>According to the standard logic or table (Tables.OrTable) an intermediate value is calculated, to which the not table (Tables.NotTable) is applied.</p>
<p>To avoid loops in the numerical treatment, the pre operator is applied to the output.</p>
</html>", revisions="<html>
<ul>
<li><em>September 15, 2004</em> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><em>October 22, 2003</em>
       by Liane Jacobi<br>
       initially modelled.</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Text(
              extent={{-50,40},{50,80}},
              textString=">=1"),
            Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name"),
            Ellipse(
              extent={{50,6},{62,-6}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
        end Nor;

        model Xor "Xor logic component with multiple input and one output"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends D.Interfaces.MISO;
    protected
          D.Interfaces.Logic auxiliary[n](each start=L.'U');
          D.Interfaces.Logic auxiliary_n( start=L.'U', fixed=true);
        equation
          auxiliary[1] = x[1];
          for i in 1:n - 1 loop
            auxiliary[i + 1] =Modelica.Electrical.Digital.Tables.XorTable[
          auxiliary[i], x[i + 1]];
          end for;
          auxiliary_n = auxiliary[n];
          y = pre(auxiliary_n);
          annotation (
            Documentation(info="<html>
<p>Xor component with multiple input values and one output.</p>
<p>According to the standard logic xor table (Tables.XorTable) the output value is calculated.</p>
<p>To avoid loops in the numerical treatment, the pre operator is applied to the output.</p>
</html>", revisions="<html>
<ul>
<li><em>September 15, 2004</em> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><em>October 22, 2003</em>
       by Liane Jacobi<br>
       initially modelled.</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Text(
              extent={{-50,40},{50,80}},
              textString="=1"), Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name")}));
        end Xor;

        model Xnor "Xnor logic component with multiple input and one output"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          extends D.Interfaces.MISO;
    protected
          D.Interfaces.Logic auxiliary[n](each start=L.'U');
          D.Interfaces.Logic auxiliary_n( start=L.'U', fixed=true);
        equation
          auxiliary[1] = x[1];
          for i in 1:n - 1 loop
            auxiliary[i + 1] =Modelica.Electrical.Digital.Tables.XorTable[
          auxiliary[i], x[i + 1]];
          end for;
          auxiliary_n = Modelica.Electrical.Digital.Tables.NotTable[auxiliary[n]];
          y = pre(auxiliary_n);
          annotation (
            Documentation(info="<html>
<p>Xnor component with multiple input values and one output.</p>
<p>According to the standard logic xor table (Tables.XorTable)an intermediate value is calculated, to which the not table (Tables.NotTable) is applied.</p>
<p>To avoid loops in the numerical treatment, the pre operator is applied to the output.</p>
</html>", revisions="<html>
<ul>
<li><em>September 15, 2004</em> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><em>October 22, 2003</em>
       by Liane Jacobi<br>
       initially modelled.</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Text(
              extent={{-50,40},{50,80}},
              textString="="), Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name")}));
        end Xnor;
        annotation (Documentation(info="<html>
<p>Basic contains the basic gates according to standard logic. The components of Basic calculate their results using the corresponding truth tables. They do not contain any delay components.</p>
</html>"));
      end Basic;

      package Gates "Logic gates including delays"
        extends Modelica.Icons.Package;

        model InvGate "InvGate with 1 input value, composed by Not and sensitive inertial delay"
      import D = Modelica.Electrical.Digital;
          extends D.Delay.DelayParams;
          extends D.Interfaces.SISO;
          D.Basic.Not G1 annotation (Placement(transformation(extent={{-60,
                    -20},{-20,20}})));
          D.Delay.InertialDelaySensitive G2(tLH=tLH, tHL=tHL)
            annotation (Placement(transformation(extent={{20,-20},{60,20}})));
        equation
          connect(G2.y, y) annotation (Line(points={{60,0},{
                  100,0}}, color={127,0,127}));
          connect(G1.x, x) annotation (Line(points={{-52,0},{-60,0}}, color={127,
                  0,127}));
          connect(G1.y, G2.x)
            annotation (Line(points={{-20,0},{28,0}}, color={127,0,127}));
          annotation (
            Documentation(info="<html>
<p>The InvGate model has a single valued input, and a single valued output. It is composed by a Basic Not and an InertialDelaySensitive. Its parameters are the delay parameters (rise and fall inertial delay time, and initial value).</p>
</html>", revisions="<html>
<dl>
<dt><em>August 14, 2003</em></dt>
<dd>by Teresa Schlegel initially modelled.</dd>
</dl>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-50,100},{50,-100}},
              lineThickness=0.5,
              fillColor={213,170,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-50,80},{50,40}},
              textString="1"),
            Text(
              extent={{-18,-60},{20,-100}},
              textString="Gate"),
            Ellipse(
              extent={{50,6},{62,-6}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
        end InvGate;

        model AndGate "AndGate with multiple input"
      import D = Modelica.Electrical.Digital;
          extends D.Interfaces.MISO;
          extends D.Delay.DelayParams;
          D.Basic.And G1(final n=n) annotation (Placement(transformation(extent={
                    {-40,-20},{0,20}})));
          D.Delay.InertialDelaySensitive G2(
            tLH=tLH,
            tHL=tHL,
            y0=y0) annotation (Placement(transformation(extent={{20,-20},{60,20}})));
        equation
          connect(x, G1.x)
            annotation (Line(points={{-60,0},{-32,0}}, color={127,0,127}));
          connect(y, G2.y)
            annotation (Line(points={{100,0},{60,0}}, color={127,0,127}));
          connect(G1.y, G2.x)
            annotation (Line(points={{0,0},{28,0}}, color={127,0,127}));
          annotation (
            Documentation(info="<html>
<p>The AndGate model has a multiple valued (n) input vector, and a single valued output. It is composed by a Basic And and an InertialDelaySensitive. Its parameters are the delay parameters (rise and fall inertial delay time, and initial value).</p>
</html>", revisions="<html>
<ul>
<li><em>September 15, 2004</em> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><em>October 22, 2003</em>
       by Teresa Schlegel<br>
       initially modelled.</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-50,100},{50,-100}},
              lineThickness=0.5,
              fillColor={213,170,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-50,80},{50,40}},
              textString="&"),
            Text(
              extent={{-20,-60},{20,-100}},
              textString="Gate")}));
        end AndGate;

        model NandGate "NandGate with multiple input"
      import D = Modelica.Electrical.Digital;
          extends D.Delay.DelayParams;
          extends D.Interfaces.MISO;
          D.Basic.Nand G1(final n=n) annotation (Placement(transformation(extent=
                   {{-40,-20},{0,20}})));
          D.Delay.InertialDelaySensitive G2(
            tLH=tLH,
            tHL=tHL,
            y0=y0) annotation (Placement(transformation(extent={{20,-20},{60,20}})));
        equation
          connect(x, G1.x)
            annotation (Line(points={{-60,0},{-32,0}}, color={127,0,127}));
          connect(G1.y, G2.x)
            annotation (Line(points={{0,0},{28,0}}, color={127,0,127}));
          connect(G2.y, y)
            annotation (Line(points={{60,0},{100,0}}, color={127,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
                             graphics={
            Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-50,100},{50,-100}},
              lineThickness=0.5,
              fillColor={213,170,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-40,40},{40,80}},
              textString="&"),
            Text(
              extent={{-50,-64},{50,-86}},
              textString="Gate"),
            Ellipse(
              extent={{50,6},{62,-6}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
            Documentation(revisions="<html>
<ul>
<li><em>September 15, 2004</em> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><em>October 22, 2003</em>
       by Teresa Schlegel<br>
       initially modelled.</li>
</ul>
</html>",     info="<html>
<p>The NandGate model has a multiple valued (n) input vector, and a single valued output. It is composed by a Basic Nand and an InertialDelaySensitive. Its parameters are the delay parameters (rise and fall inertial delay time, and initial value).</p>
</html>"));
        end NandGate;

        model OrGate "OrGate with multiple input"
      import D = Modelica.Electrical.Digital;
          extends D.Delay.DelayParams;
          extends D.Interfaces.MISO;
          D.Basic.Or G1(final n=n) annotation (Placement(transformation(extent={{
                    -40,-20},{0,20}})));
          D.Delay.InertialDelaySensitive G2(
            tLH=tLH,
            tHL=tHL,
            y0=y0) annotation (Placement(transformation(extent={{20,-20},{60,20}})));
        equation
          connect(G1.y, G2.x)
            annotation (Line(points={{0,0},{28,0}}, color={127,0,127}));
          connect(x,G1. x)
            annotation (Line(points={{-60,0},{-32,0}}, color={127,0,127}));
          connect(y, G2.y)
            annotation (Line(points={{100,0},{60,0}}, color={127,0,127}));
          annotation (
            Documentation(info="<html>
<p>The OrGate model has a multiple valued (n) input vector, and a single valued output. It is composed by a Basic Or and an InertialDelaySensitive. Its parameters are the delay parameters (rise and fall inertial delay time, and initial value).</p>
</html>", revisions="<html>
<ul>
<li><em>September 15, 2004</em> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><em>October 22, 2003</em>
       by Teresa Schlegel<br>
       initially modelled.</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-50,100},{50,-100}},
              lineThickness=0.5,
              fillColor={213,170,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-50,80},{50,40}},
              textString=">=1"),
            Text(
              extent={{-20,-60},{20,-100}},
              textString="Gate")}));
        end OrGate;

        model NorGate "NorGate with multiple input"
      import D = Modelica.Electrical.Digital;
          extends D.Delay.DelayParams;
          extends D.Interfaces.MISO;
          D.Basic.Nor G1(final n=n) annotation (Placement(transformation(extent={
                    {-40,-20},{0,20}})));
          D.Delay.InertialDelaySensitive G2(
            tLH=tLH,
            tHL=tHL,
            y0=y0) annotation (Placement(transformation(extent={{20,-20},{60,20}})));
        equation
          connect(G1.y, G2.x)
            annotation (Line(points={{0,0},{28,0}}, color={127,0,127}));
          connect(x, G1.x)
            annotation (Line(points={{-60,0},{-32,0}}, color={127,0,127}));
          connect(y, G2.y)
            annotation (Line(points={{100,0},{60,0}}, color={127,0,127}));
          annotation (
            Documentation(info="<html>
<p>The NorGate model has a multiple valued (n) input vector, and a single valued output. It is composed by a Basic Nor and an InertialDelaySensitive. Its parameters are the delay parameters (rise and fall inertial delay time, and initial value).</p>
</html>", revisions="<html>
<ul>
<li><em>September 15, 2004</em> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><em>October 22, 2003</em>
       by Liane Jacobi<br>
       initially modelled.</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-50,100},{50,-100}},
              lineThickness=0.5,
              fillColor={213,170,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-50,80},{50,40}},
              textString=">=1"),
            Text(
              extent={{-20,-60},{20,-100}},
              textString="Gate"),
            Ellipse(
              extent={{50,6},{62,-6}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
        end NorGate;

        model XorGate "XorGate with multiple input"
      import D = Modelica.Electrical.Digital;
          extends D.Delay.DelayParams;
          extends D.Interfaces.MISO;
          D.Basic.Xor G1(final n=n) annotation (Placement(transformation(extent={
                    {-40,-20},{0,20}})));
          D.Delay.InertialDelaySensitive G2(
            tLH=tLH,
            tHL=tHL,
            y0=y0) annotation (Placement(transformation(extent={{20,-20},{60,20}})));
        equation
          connect(x, G1.x)
            annotation (Line(points={{-60,0},{-32,0}}, color={127,0,127}));
          connect(G1.y, G2.x)
            annotation (Line(points={{0,0},{28,0}}, color={127,0,127}));
          connect(G2.y, y)
            annotation (Line(points={{60,0},{100,0}}, color={127,0,127}));
          annotation (
            Documentation(info="<html>
<p>The XorGate model has a multiple valued (n) input vector, and a single valued output. It is composed by a Basic Xor and an InertialDelaySensitive. Its parameters are the delay parameters (rise and fall inertial delay time, and initial value).</p>
</html>", revisions="<html>
<ul>
<li><em>September 15, 2004</em> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><em>October 22, 2003</em>
       by Liane Jacobi<br>
       initially modelled.</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-50,100},{50,-100}},
              lineThickness=0.5,
              fillColor={213,170,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-50,80},{50,40}},
              textString="=1"),
            Text(
              extent={{-20,-60},{20,-100}},
              textString="Gate")}));
        end XorGate;

        model XnorGate "XnorGate with multiple input"
      import D = Modelica.Electrical.Digital;
          extends D.Delay.DelayParams;
          extends D.Interfaces.MISO;
          D.Basic.Xnor G1(final n=n) annotation (Placement(transformation(extent=
                   {{-40,-20},{0,20}})));
          D.Delay.InertialDelaySensitive G2(
            tLH=tLH,
            tHL=tHL,
            y0=y0) annotation (Placement(transformation(extent={{20,-20},{60,20}})));
        equation
          connect(x, G1.x)
            annotation (Line(points={{-60,0},{-32,0}}, color={127,0,127}));
          connect(G2.y, y)
            annotation (Line(points={{60,0},{100,0}}, color={127,0,127}));
          connect(G1.y, G2.x)
            annotation (Line(points={{0,0},{28,0}}, color={127,0,127}));
          annotation (
            Documentation(info="<html>
<p>The XnorGate model has a multiple valued (n) input vector, and a single valued output. It is composed by a Basic Xnor and an InertialDelaySensitive. Its parameters are the delay parameters (rise and fall inertial delay time, and initial value).</p>
</html>", revisions="<html>
<ul>
<li><em>September 15, 2004</em> vector approach used for all fixed numbers of inputs
       by Christoph Clauss<br>
       </li>
<li><em>October 22, 2003</em>
       by Liane Jacobi<br>
       initially modelled.</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-50,100},{50,-100}},
              lineThickness=0.5,
              fillColor={213,170,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-40,80},{40,40}},
              textString="="),
            Text(
              extent={{-20,-60},{20,-100}},
              textString="Gate")}));
        end XnorGate;

        model BufGate "BufGate with 1 input value, composed by Not and sensitive inertial delay"
      import D = Modelica.Electrical.Digital;
          extends D.Delay.DelayParams;
          extends D.Interfaces.SISO;
          D.Delay.InertialDelaySensitive G1(tLH=tLH, tHL=tHL)
            annotation (Placement(transformation(extent={{-30,-20},{10,20}})));
        equation
          connect(G1.y, y) annotation (Line(points={{10,0},{
                  100,0}}, color={127,0,127}));
          connect(G1.x, x) annotation (Line(points={{-22,0},{-60,0}}, color={127,0,
                  127}));
          annotation (
            Documentation(info="<html>
<p>The BufGate model has a single valued input, and a single valued output. It consists of an InertialDelaySensitive only. Its parameters are the delay parameters (rise and fall inertial delay time, and initial value).</p>
</html>", revisions="<html>
<dl>
<dt><em>September 21, 2004</em></dt>
<dd>by Andre Schneider initially modelled.</dd>
</dl>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-50,100},{50,-100}},
              lineThickness=0.5,
              fillColor={213,170,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-18,-60},{20,-100}},
              textString="Gate"),
            Text(
              extent={{-50,80},{50,40}},
              textString="1")}));
        end BufGate;
        annotation (Documentation(info="<html>
<p>Gates contains the basic gates according to standard logic as they are provided in the Basic package. Additionally they contain an InertialDelaySensitive component They are composed graphically, not using any equations.</p>
</html>"));
      end Gates;

      package Sources "Time-dependent digital signal sources"
        extends Modelica.Icons.SourcesPackage;

        block Set "Digital Set Source"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          parameter D.Interfaces.Logic x(start=L.'1') "Logic value to be set";
          D.Interfaces.DigitalOutput y
                        annotation (Placement(transformation(extent={{90,-10},{110,
                    10}})));
        algorithm
          y := x;
          annotation (Documentation(info="<html>
<p>
Sets a nine valued digital signal, which is specified by the <em>setval</em> parameter.
</p>
<p>
To specify <em>setval</em>, the integer code has to be used.
</p>
<p><strong>Code Table</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Logic value</strong></td>
      <td><strong>Integer code</strong></td>
      <td><strong>Meaning</strong></td>
  </tr>

  <tr><td>'U'</td> <td>1</td> <td>Uninitialized</td></tr>
  <tr><td>'X'</td> <td>2</td> <td>Forcing Unknown</td></tr>
  <tr><td>'0'</td> <td>3</td> <td>Forcing 0</td></tr>
  <tr><td>'1'</td> <td>4</td> <td>Forcing 1</td></tr>
  <tr><td>'Z'</td> <td>5</td> <td>High Impedance</td></tr>
  <tr><td>'W'</td> <td>6</td> <td>Weak Unknown</td></tr>
  <tr><td>'L'</td> <td>7</td> <td>Weak 0</td></tr>
  <tr><td>'H'</td> <td>8</td> <td>Weak 1</td></tr>
  <tr><td>'-'</td> <td>9</td> <td>Do not care</td></tr>
</table>

<p>
If the logic values are imported by<br><strong>import L = Digital.Interfaces.Logic;</strong><br>
they can be used to specify the parameter, e.g., <strong>L.'0'</strong> for forcing 0.
</p>
</html>", revisions="<html>
<dl>
<dt><em>August 20, 2003</em></dt>
<dd>by Teresa Schlegel initially modelled.</dd>
</dl>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-50,100},{50,-100}},
              lineThickness=0.5,
              fillColor={213,255,170},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-50,40},{50,80}},
              textString="SET"),
            Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name"),
            Line(points={{50,0},{90,0}}, color={127,0,127})}));
        end Set;

        block Step "Digital Step Source"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          parameter D.Interfaces.Logic before(start=L.'0')
        "Logic value before step";
          parameter D.Interfaces.Logic after(start=L.'1')
        "Logic value after step";
          parameter Real stepTime(start=1) "Step time";
          D.Interfaces.DigitalOutput y
                        annotation (Placement(transformation(extent={{90,-10},{110,
                    10}})));
        algorithm
          // assert(before >= L.min and before <= L.max, "Parameter is no logic value");
          // assert(after >= L.min and after <= L.max, "Parameter is no logic value");
          if time >= stepTime then
            y := after;
          else
            y := before;
          end if;
          annotation (
            Documentation(info="<html>
<p>
The step source output signal steps from the value <em>before</em> to the value <em>after</em>
at the time <em>stepTime</em>.
</p>
<p>
To specify the logic value parameters, the integer code has to be used.
</p>
<p><strong>Code Table</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Logic value</strong></td>
      <td><strong>Integer code</strong></td>
      <td><strong>Meaning</strong></td>
  </tr>

  <tr><td>'U'</td> <td>1</td> <td>Uninitialized</td></tr>
  <tr><td>'X'</td> <td>2</td> <td>Forcing Unknown</td></tr>
  <tr><td>'0'</td> <td>3</td> <td>Forcing 0</td></tr>
  <tr><td>'1'</td> <td>4</td> <td>Forcing 1</td></tr>
  <tr><td>'Z'</td> <td>5</td> <td>High Impedance</td></tr>
  <tr><td>'W'</td> <td>6</td> <td>Weak Unknown</td></tr>
  <tr><td>'L'</td> <td>7</td> <td>Weak 0</td></tr>
  <tr><td>'H'</td> <td>8</td> <td>Weak 1</td></tr>
  <tr><td>'-'</td> <td>9</td> <td>Do not care</td></tr>
</table>
<p>
If the logic values are imported by<br><strong>import L = Digital.Interfaces.Logic;</strong><br>
they can be used to specify the parameter, e.g., <strong>L.'0'</strong> for forcing 0.
</p>
</html>", revisions="<html>
<dl>
<dt><em>August 20, 2003</em></dt>
<dd>by Teresa Schlegel initially modelled.</dd>
</dl>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Rectangle(
              extent={{-50,100},{50,-100}},
              lineThickness=0.5,
              fillColor={213,255,170},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name"),
            Line(points={{-30,40},{0,40},{0,80},{30,80}}),
            Line(points={{50,0},{90,0}}, color={127,0,127})}));
        end Step;

        block Table "Digital Tabular Source"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          parameter D.Interfaces.Logic x[:]={L.'1'} "Vector of values";
          parameter Real t[size(x, 1)]={1}
        "Vector of corresponding time points";
          parameter D.Interfaces.Logic y0=L.'U' "Initial output value";
          final parameter Integer n=size(x, 1) "Table size";
          D.Interfaces.DigitalOutput y
                        annotation (Placement(transformation(extent={{90,-10},{110,
                    10}})));
        algorithm
          if initial() then
            // assert(y0 >= L.min and y0 <= L.max, "Parameter y0 is not of type Logic");
            assert(n > 0, "Invalid size of table (n < 1)");
            for i in 1:n loop
              // assert(x[i] >= L.min and x[i] <= L.max, "Table element is not of type Logic");
            end for;
          end if;
          y := y0;
          for i in 1:n loop
            if time >= t[i] then
              y := x[i];
            end if;
          end for;
          annotation (
            Documentation(info="<html>
<p>
The table source output signal <em>y</em> steps to the values of the  <em>x</em> table at the corresponding
timepoints in the <em>t</em> table.<br>The initial value is specified by <em>y0</em>.
</p>
<p>
To specify the logic value parameters, the integer code has to be used.
</p>
<p><strong>Code Table</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Logic value</strong></td>
      <td><strong>Integer code</strong></td>
      <td><strong>Meaning</strong></td>
  </tr>

  <tr><td>'U'</td> <td>1</td> <td>Uninitialized</td></tr>
  <tr><td>'X'</td> <td>2</td> <td>Forcing Unknown</td></tr>
  <tr><td>'0'</td> <td>3</td> <td>Forcing 0</td></tr>
  <tr><td>'1'</td> <td>4</td> <td>Forcing 1</td></tr>
  <tr><td>'Z'</td> <td>5</td> <td>High Impedance</td></tr>
  <tr><td>'W'</td> <td>6</td> <td>Weak Unknown</td></tr>
  <tr><td>'L'</td> <td>7</td> <td>Weak 0</td></tr>
  <tr><td>'H'</td> <td>8</td> <td>Weak 1</td></tr>
  <tr><td>'-'</td> <td>9</td> <td>Do not care</td></tr>
</table>
<p>
If the logic values are imported by<br><strong>import L = Digital.Interfaces.Logic;</strong><br>
they can be used to specify the parameter, e.g., <strong>L.'0'</strong> for forcing 0.
</p>
</html>", revisions="<html>
<dl>
<dt><em>August 20, 2003</em></dt>
<dd>by Teresa Schlegel initially modelled.</dd>
</dl>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Rectangle(
              extent={{-50,100},{50,-100}},
              lineThickness=0.5,
              fillColor={213,255,170},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name"),
            Line(points={{50,0},{90,0}}, color={127,0,127}),
            Rectangle(
              extent={{-30,80},{32,70}},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-30,70},{32,40}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,80},{0,40}}),
            Line(points={{-30,60},{32,60}}),
            Line(points={{-30,50},{32,50}})}));
        end Table;

        model Pulse "Digital Pulse Source"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          parameter Real width(
            final min=Modelica.Constants.small,
            final max=100, start=50) "Widths of pulses in % of periods";
          parameter SI.Time period(final min=Modelica.Constants.small, start=1)
        "Time for one period";
          parameter SI.Time startTime(start=0)
        "Output = quiet for time < startTime";
          parameter D.Interfaces.Logic pulse(start=L.'0') "Pulsed value";
          parameter D.Interfaces.Logic quiet(start=L.'1') "Quiet value";
          SI.Time T0(final start=startTime, fixed=true)
        "Start time of current period";
          parameter Integer nperiod(start=-1)
        "Number of periods (< 0 means infinite number of periods)";
          Integer np(start=0, fixed=true);
          D.Interfaces.DigitalOutput y
                        annotation (Placement(transformation(extent={{90,-10},{110,
                    10}})));
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
          annotation (Documentation(info="<html>
<p>
The pulse source forms pulses between the  <em>quiet</em> value and the <em>pulse</em> value.
The pulse length <em>width</em> is specified in percent of the period length <em>period</em>.
The number of periods is specified by <em>nperiod</em>. If <em>nperiod</em> is less than zero,
the number of periods is unlimited.
</p>
<p>
To specify the logic value parameters, the integer code has to be used.
</p>
<p><strong>Code Table</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Logic value</strong></td>
      <td><strong>Integer code</strong></td>
      <td><strong>Meaning</strong></td>
  </tr>

  <tr><td>'U'</td> <td>1</td> <td>Uninitialized</td></tr>
  <tr><td>'X'</td> <td>2</td> <td>Forcing Unknown</td></tr>
  <tr><td>'0'</td> <td>3</td> <td>Forcing 0</td></tr>
  <tr><td>'1'</td> <td>4</td> <td>Forcing 1</td></tr>
  <tr><td>'Z'</td> <td>5</td> <td>High Impedance</td></tr>
  <tr><td>'W'</td> <td>6</td> <td>Weak Unknown</td></tr>
  <tr><td>'L'</td> <td>7</td> <td>Weak 0</td></tr>
  <tr><td>'H'</td> <td>8</td> <td>Weak 1</td></tr>
  <tr><td>'-'</td> <td>9</td> <td>Do not care</td></tr>
</table>
<p>
If the logic values are imported by<br><strong>import L = Digital.Interfaces.Logic;</strong><br>
they can be used to specify the parameter, e.g., <strong>L.'0'</strong> for forcing 0.
</p>
</html>", revisions="<html>
<dl>
<dt><em>September 2, 2003</em></dt>
<dd>by Christoph Clauss initially modelled.</dd>
</dl>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-50,100},{50,-100}},
              lineThickness=0.5,
              fillColor={213,255,170},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name"),
            Line(points={{50,0},{90,0}}, color={127,0,127}),
            Line(points={{-36,40},{-30,40},{-30,40},{-18,40},{-18,40},{-14,40},
                  {-14,80},{14,80},{14,40},{14,40},{14,40},{28,40},{30,40},{36,
                  40}})}));
        end Pulse;

        model DigitalClock "Digital Clock Source"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          parameter SI.Time startTime(start=0)
        "Output = offset for time < startTime";
          parameter SI.Time period(
            final min=Modelica.Constants.small, start=1) "Time for one period";
          parameter Real width(
            final min=Modelica.Constants.small,
            final max=100, start=50) "Width of pulses in % of period";
          D.Interfaces.DigitalOutput y "Connector of Digital output signal"
                        annotation (Placement(transformation(extent={{90,-10},{110,
                    10}})));
    protected
          SI.Time t_i(final start=startTime, fixed=true)
        "Start time of current period";
          SI.Time t_width=period*width/100;
        equation
          when sample(startTime, period) then
            t_i =  time;
          end when;
          y =  if (not time>=startTime) or time >= t_i + t_width then L.'0' else L.'1';
          annotation (Documentation(info="<html>
<p>
The clock source forms pulses between the <em>'0'</em> value (forcing 0) and the <em>'1'</em> value (forcing 1).
The pulse length <em>width</em> is specified in percent of the period length <em>period</em>.
The number of periods is unlimited. The first pulse starts at startTime.
</p>
<p> The clock source is a special but often used variant of the pulse source.
</p>
</html>", revisions="<html>
<dl>
<dt><em>September 18, 2004</em></dt>
<dd>by Andre Schneider initially modelled.</dd>
</dl>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-50,100},{50,-100}},
              lineThickness=0.5,
              fillColor={213,255,170},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name"),
            Line(points={{50,0},{90,0}}, color={127,0,127}),
            Line(points={{-36,40},{-30,40},{-30,80},{-18,80},{-18,40},{-6,40},{
                  -6,80},{6,80},{6,40},{18,40},{18,80},{30,80},{30,40},{36,40}})}));
        end DigitalClock;
        annotation (Documentation(info="<html>
<p>The sources are not taken from Standard Logic. They were added since they turned out to be quite useful, since such sources are often needed. For a better optical overview the colour green was chosen for the sources.</p>
</html>"));
      end Sources;

      package Converters "Converters between 2-,3-,4- and 9-valued logic"
        extends Modelica.Icons.Package;

        block LogicToX01 "Conversion to X01"
          import D = Modelica.Electrical.Digital;
          import T = Modelica.Electrical.Digital.Tables;
          D.Interfaces.DigitalInput x[n]
                            annotation (Placement(transformation(extent={{-60,-10},
                    {-40,10}})));
          D.Interfaces.DigitalOutput y[n]
                             annotation (Placement(transformation(extent={{40,-10},
                    {60,10}})));
          parameter Integer n(final min=1, start=1) "Signal width";
        algorithm
          for i in 1:n loop
            y[i] := T.X01Table[x[i]];
          end for;
          annotation (
            Documentation(info="<html>
<p>
Conversion of a nine valued digital input into a X01 digital output without
any delay according to IEEE 1164 To_X01 function.
</p>
<p><strong>Conversion Table:</strong></p>
<blockquote><pre>
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
</pre></blockquote>
<p>
If the signal width is greater than 1 this conversion is done for each signal.
</p>
</html>", revisions="<html>
<ul>
<li><em>September 15, 2004</em>
       by Christoph Clauss name converted from cvt_to_x01 into LogicToX01<br>
       </li>
<li><em>November 5, 2003</em>
       by Christoph Clauss<br>
       initially modelled.</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Text(
              extent={{152,-100},{-148,-40}},
              textColor={0,0,255},
              textString="%name"),
            Polygon(
              points={{-40,-40},{-40,40},{40,40},{-40,-40}},
              lineColor={127,0,127},
              fillColor={127,0,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-40,-40},{40,-40},{40,40},{-40,-40}},
              lineColor={127,0,127},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{0,-20},{40,-40}},
              textString="X01"),
            Rectangle(
              extent={{-40,40},{40,-40}},
              lineThickness=0.5)}));
        end LogicToX01;

        block LogicToX01Z "Conversion to X01Z"
          import D = Modelica.Electrical.Digital;
          import T = Modelica.Electrical.Digital.Tables;
          D.Interfaces.DigitalInput x[n]
                            annotation (Placement(transformation(extent={{-60,-10},
                    {-40,10}})));
          D.Interfaces.DigitalOutput y[n]
                             annotation (Placement(transformation(extent={{40,-10},
                    {60,10}})));
          parameter Integer n(final min=1, start=1) "Signal width";
        algorithm
          for i in 1:n loop
            y[i] := T.X01ZTable[x[i]];
          end for;
          annotation (
            Documentation(info="<html>
<p>
Conversion of a nine valued digital input into a X01Z digital output without
any delay according to IEEE 1164 To_X01Z function.
</p>
<p><strong>Conversion Table:</strong></p>
<blockquote><pre>
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
</pre></blockquote>
<p>
If the signal width is greater than 1 this conversion is done for each signal.
</p>
</html>", revisions="<html>
<ul>
<li><em>September 15, 2004</em>
       by Christoph Clauss name converted from cvt_to_x01z into LogicToX01Z<br>
       </li>
<li><em>November 5, 2003</em>
       by Christoph Clauss<br>
       initially modelled.</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Text(
              extent={{152,-100},{-148,-40}},
              textColor={0,0,255},
              textString="%name"),
            Polygon(
              points={{-40,-40},{-40,40},{40,40},{-40,-40}},
              lineColor={127,0,127},
              fillColor={127,0,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-40,-40},{40,-40},{40,40},{-40,-40}},
              lineColor={127,0,127},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{0,-20},{40,-40}},
              textString="X01Z"),
            Rectangle(
              extent={{-40,40},{40,-40}},
              lineThickness=0.5)}));
        end LogicToX01Z;

        block LogicToUX01 "Conversion to UX01"
          import D = Modelica.Electrical.Digital;
          import T = Modelica.Electrical.Digital.Tables;
          D.Interfaces.DigitalInput x[n]
                            annotation (Placement(transformation(extent={{-60,-10},
                    {-40,10}})));
          D.Interfaces.DigitalOutput y[n]
                             annotation (Placement(transformation(extent={{40,-10},
                    {60,10}})));
          parameter Integer n(final min=1, start=1) "Signal width";
        algorithm
          for i in 1:n loop
            y[i] := T.UX01Table[x[i]];
          end for;
          annotation (
            Documentation(info="<html>
<p>
Conversion of a nine valued digital input into a UX01 digital output without
any delay according to IEEE 1164 To_UX01 function.
</p>
<p><strong>Conversion Table:</strong></p>
<blockquote><pre>
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
</pre></blockquote>
<p>
If the signal width is greater than 1 this conversion is done for each signal.
</p>
</html>", revisions="<html>
<ul>
<li><em>September 15, 2004</em>
       by Christoph Clauss name converted from cvt_to_ux01 into LogicToUX01<br>
       </li>
<li><em>November 5, 2003</em>
       by Christoph Clauss<br>
       initially modelled.</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Text(
              extent={{152,-100},{-148,-40}},
              textColor={0,0,255},
              textString="%name"),
            Polygon(
              points={{-40,-40},{-40,40},{40,40},{-40,-40}},
              lineColor={127,0,127},
              fillColor={127,0,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-40,-40},{40,-40},{40,40},{-40,-40}},
              lineColor={127,0,127},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{0,-20},{40,-40}},
              textString="UX01"),
            Rectangle(
              extent={{-40,40},{40,-40}},
              lineThickness=0.5)}));
        end LogicToUX01;

        block BooleanToLogic "Boolean to Logic converter"
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          Modelica.Blocks.Interfaces.BooleanInput x[n]
            annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
          parameter Integer n(final min=1, start=1) "Signal width";
          Modelica.Electrical.Digital.Interfaces.DigitalOutput y[n]
            annotation (Placement(transformation(extent={{40,-10},{60,10}})));
        equation
          for i in 1:n loop
            y[i] = if x[i] then L.'1' else L.'0';
          end for;
          annotation (
            Documentation(info="<html>
<p>
Conversion of a Boolean input into a digital output without any delay according to:
</p>
<blockquote><pre>
input      output
true       '1'  (coded by 4)
false      '0'  (coded by 3)
</pre></blockquote>
<p>
If the signal width is greater than 1 this conversion is done for each signal.
</p>
</html>", revisions="<html>
<ul>
<li><em>September 15, 2004</em>
       by Christoph Clauss colors changed<br>
       </li>
<li><em>November 4, 2003</em>
       by Christoph Clauss<br>
       initially modelled.</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Polygon(
              points={{-40,-40},{40,40},{40,-40},{-40,-40}},
              lineColor={127,0,127},
              fillColor={127,0,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-40,40},{40,40},{-40,-40},{-40,40}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{152,-100},{-148,-40}},
              textColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-40,40},{40,-40}},
              lineThickness=0.5)}));
        end BooleanToLogic;

        block LogicToBoolean "Logic to Boolean converter"
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          Modelica.Electrical.Digital.Interfaces.DigitalInput x[n]
            annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
          Modelica.Blocks.Interfaces.BooleanOutput y[n]
            annotation (Placement(transformation(extent={{40,-10},{60,10}})));
          parameter Integer n(final min=1, start=2) "Signal width";
        equation
          for i in 1:n loop
            y[i] = (x[i] == L.'1' or x[i] == L.'H');
          end for;
          annotation (Documentation(info="<html>
<p>
Conversion of a digital input into a Boolean output without any delay according to:
</p>
<blockquote><pre>
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
</pre></blockquote>
<p>
If the signal width is greater than 1 this conversion is done for each signal.
</p>
</html>", revisions="<html>
<ul>
<li><em>September 15, 2004</em>
       by Christoph Clauss colors changed<br>
       </li>
<li><em>November 4, 2003</em>
       by Christoph Clauss<br>
       initially modelled.</li>
</ul>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Polygon(
              points={{-40,40},{40,40},{-40,-40},{-40,40}},
              lineColor={127,0,127},
              fillColor={127,0,127},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{152,-100},{-148,-40}},
              textColor={0,0,255},
              textString="%name"),
            Polygon(
              points={{-40,-40},{40,-40},{40,40},{-40,-40}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,40},{40,-40}},
              lineThickness=0.5)}));
        end LogicToBoolean;

        block RealToLogic "Real to Logic converter"
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          Modelica.Blocks.Interfaces.RealInput x[n]
            annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
          Digital.Interfaces.DigitalOutput y[n]
            annotation (Placement(transformation(extent={{40,-10},{60,10}})));
          parameter Integer n(final min=1, start=1) "Signal width";
          parameter Real upper_limit(start=1) "Upper limit";
          parameter Real lower_limit(start=0) "Lower limit";
          parameter L upper_value(start=L.'1') "Output if input > upper_limit";
          parameter L lower_value(start=L.'0') "Output if input < lower_limit";
          parameter L middle_value(start=L.'X') "Output else";
        equation
          for i in 1:n loop
            y[i] = if x[i] > upper_limit then upper_value else
              if x[i] < lower_limit then lower_value else middle_value;
          end for;
          annotation (
            Documentation(info="<html>
<p>
Conversion of a real input into a digital output without any delay according to:
</p>
<blockquote><pre>
                           condition            output
first check:               input greater upp    lupp
second check:              input larger low     llow
                           else                 lmid
</pre></blockquote>
<p>
If the signal width is greater than 1 this conversion is done for each signal.
</p>
</html>", revisions="<html>
<ul>
<li><em>September 15, 2004</em>
       by Christoph Clauss colors changed<br>
       </li>
<li><em>November 5, 2003</em>
       by Christoph Clauss<br>
       initially modelled.</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Polygon(
              points={{-40,-40},{40,40},{40,-40},{-40,-40}},
              lineColor={127,0,127},
              fillColor={127,0,127},
              fillPattern=FillPattern.Solid),
            Polygon(points={{-40,40},{40,40},{-40,-40},{-40,40}}, lineColor={0,
                  0,255}),
            Text(
              extent={{148,-100},{-152,-40}},
              textColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-40,40},{40,-40}},
              lineThickness=0.5)}));
        end RealToLogic;

        block LogicToReal "Logic to Real converter"
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          Modelica.Electrical.Digital.Interfaces.DigitalInput x[n]
            annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
          Modelica.Blocks.Interfaces.RealOutput y[n]
            annotation (Placement(transformation(extent={{40,-10},{60,10}})));
          parameter Integer n(final min=1, start=1) "Signal width";
          parameter Real value_U(start=0.5)
        "Value for digital U (uninitialized)";
          parameter Real value_X(start=0.5)
        "Value for digital X (Forcing Unknown)";
          parameter Real value_0(start=0) "Value for digital 0 (Forcing 0)";
          parameter Real value_1(start=1) "Value for digital 1 (Forcing 1)";
          parameter Real value_Z(start=0.5)
        "Value for digital Z (High Impedance)";
          parameter Real value_W(start=0.5)
        "Value for digital W (Weak    Unknown)";
          parameter Real value_L(start=0) "Value for digital L (Weak 0)";
          parameter Real value_H(start=1) "Value for digital H (Weak 1)";
          parameter Real value_m(start=0.5) "Value for digital m (Do not care)";
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
          annotation (Documentation(info="<html>
<p>
Conversion of a digital input into a Real output without any delay according to:
</p>
<blockquote><pre>
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
</pre></blockquote>
<p>
The values val... are given by parameters.</p>
<p>If the signal width is greater than 1 this conversion is done for each signal.
</p>
</html>", revisions="<html>
<ul>
<li><em>September 15, 2004</em>
       by Christoph Clauss colors changed<br>
       </li>
<li><em>November 5, 2003</em>
       by Christoph Clauss<br>
       initially modelled.</li>
</ul>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Polygon(
              points={{-40,40},{40,40},{-40,-40},{-40,40}},
              lineColor={127,0,127},
              fillColor={127,0,127},
              fillPattern=FillPattern.Solid),
            Polygon(points={{-40,-40},{40,-40},{40,40},{-40,-40}}, lineColor={0,
                  0,255}),
            Text(
              extent={{152,-100},{-148,-40}},
              textColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-40,40},{40,-40}},
              lineThickness=0.5)}));
        end LogicToReal;
        annotation (Documentation(info="<html>
<p>The Converter BooleanToLogic, LogicToBoolean, RealToLogic, and LogicTo Real components are not standard logic components. They were designed to easily convert from or to Boolean or Real valued signals. The LogicToX01, LogicToX01Z and LogicTo UX01 converters correspond to standard logic functions. They transform 9-valued logic to 3- or 4-valued logic.</p>
</html>"));
      end Converters;

      package Registers "Registers with N-bit input data and output data"
        extends Modelica.Icons.Package;

        model DFFR "Edge triggered register bank with reset"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          import S = Modelica.Electrical.Digital.Interfaces.Strength;
          import T = Modelica.Electrical.Digital.Tables;
          parameter Integer ResetMap[L] = {1, 4, 3, 2, 4, 4, 3, 2, 4}
        "Function selection, defaults for high active reset";
          parameter D.Interfaces.Strength strength = S.'S_X01'
        "Output strength";
          parameter Integer n(min=1) = 1 "Data width";

          D.Interfaces.DigitalInput reset
            annotation (Placement(transformation(extent={{-10,-100},{10,-80}}),
                iconTransformation(extent={{-10,-100},{10,-80}})));
          D.Interfaces.DigitalInput clock annotation (Placement(transformation(
                  extent={{-90,-30},{-70,-10}}),iconTransformation(extent={{-90,-30},{
                    -70,-10}})));
          D.Interfaces.DigitalInput dataIn[n] annotation (Placement(transformation(
                  extent={{-90,20},{-70,40}}), iconTransformation(extent={{-90,20},{-70,
                    40}})));
          D.Interfaces.DigitalOutput dataOut[n] annotation (Placement(
                transformation(extent={{64,26},{84,46}}),  iconTransformation(
                  extent={{69,20},{89,40}})));
    protected
                  Integer clock_flag(start=0);
                    // 0: 0-Transition
                    // 1: rising edge
                    // 2: X-Transition

                   Integer reset_flag(start=1);
                    // 1: output := U
                    // 2: output := 0
                    // 3: output := -dataInUX
                    // 4: output := U-0X
    protected
                  D.Interfaces.Logic nextstate[n](start=fill(L.'U',n));
                  D.Interfaces.Logic next_assign_val[n](start=fill(L.'U',n));

        algorithm
        if change(clock) or change(reset) then

          if change(clock) then
            if initial() then
              clock_flag := T.ClockMap[L.'U',clock];
            else
              clock_flag := T.ClockMap[pre(clock),clock];
            end if;
          end if;

          reset_flag :=  ResetMap[reset];
          for i in 1:n loop
            if reset_flag == 1 then
              nextstate[i] := L.'U';
            elseif reset_flag == 2 then
              nextstate[i] := T.StrengthMap[L.'0', strength];
            elseif reset_flag == 3 then
              if clock_flag == 0 then
                break;
              elseif clock_flag == 1 then
                nextstate[i] := T.StrengthMap[dataIn[i], strength];
              else
                if (next_assign_val[i] == T.StrengthMap[dataIn[i], strength])
                  or (next_assign_val[i] == L.'U') then
                    break;
                elseif dataIn[i] == L.'U' then
                    nextstate[i] := L.'U';
                else
                    nextstate[i] := T.StrengthMap[L.'X', strength];
                end if;
              end if;
            elseif reset_flag == 4 then
              if (next_assign_val[i] == T.StrengthMap[L.'0', strength])
                and (dataIn[i] == L.'0' or dataIn[i] == L.'L' or clock_flag == 0) then
                  break;
              elseif (dataIn[i] == L.'0' or dataIn[i] == L.'L') and (clock_flag == 1) then
                  nextstate[i] := T.StrengthMap[L.'0', strength];
              elseif ((next_assign_val[i] == L.'U') and not (clock_flag == 1))
                or ((dataIn[i] == L.'U') and not (clock_flag == 0)) then
                  nextstate[i] := L.'U';
              else
                nextstate[i] := T.StrengthMap[L.'X', strength];
              end if;
            end if;
          end for;
        end if;
        next_assign_val := nextstate;
        dataOut := nextstate;
          annotation (Icon(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
            graphics={
            Rectangle(
              extent={{-50,60},{50,-60}},
              lineColor={127,33,107},
              lineThickness=0.5,
              fillPattern=FillPattern.Solid,
              fillColor={255,255,255}),
            Line(
              points={{-70,30},{-50,30}},
              color={127,33,107},
              thickness=1),
            Line(
              points={{50,30},{76,30}},
              color={127,33,107},
              thickness=1),
            Line(
              points={{-80,-20},{-50,-20}},
              color={127,33,107}),
            Line(
              points={{0,-84},{0,-60}},
              color={127,33,107}),
            Line(
              points={{-50,-8},{-34,-20},{-50,-32}},
              color={127,33,107}),
            Text(
              extent={{-30,54},{20,8}},
              textColor={127,33,107},
              textString="DFFR"),
            Text(
              extent={{-32,-14},{-6,-26}},
              textColor={127,33,107},
              textString="clock"),
            Text(
              extent={{-14,-44},{12,-56}},
              textColor={127,33,107},
              textString="reset")}),
            Documentation(info="<html>
<p>Description in VHDL is given by http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities</p>
<p><strong>Truth Table for high active reset:</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Clock</strong></td>
      <td><strong>Reset</strong></td>
      <td><strong>DataOut</strong></td>
      <td>Map</td>
  </tr>

  <tr><td>*</td> <td>*</td> <td>U</td>  <td>U</td> <td>1</td> </tr>
  <tr><td>*</td> <td>*</td> <td>1</td>  <td>0</td> <td>2</td> </tr>
  <tr><td>*</td> <td>0-Trns</td> <td>0</td>  <td>NC</td> <td>3</td> </tr>
  <tr><td>*</td> <td>1-Trns</td> <td>0</td>  <td>DataIn</td> <td>3</td> </tr>
  <tr><td>*</td> <td>X-Trns</td> <td>0</td>  <td>X or U or NC</td> <td>3</td> </tr>
  <tr><td>*</td> <td>*</td> <td>X</td> <td>X or U or 0 or NC</td> <td>4</td> </tr>
</table>

<p><strong>Truth Table for low active reset:</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Clock</strong></td>
      <td><strong>Reset</strong></td>
      <td><strong>DataOut</strong></td>
      <td>Map</td>
  </tr>

  <tr><td>*</td> <td>*</td> <td>U</td>  <td>U</td> <td>1</td> </tr>
  <tr><td>*</td> <td>*</td> <td>0</td>  <td>0</td> <td>2</td> </tr>
  <tr><td>*</td> <td>0-Trns</td> <td>1</td>  <td>NC</td> <td>3</td> </tr>
  <tr><td>*</td> <td>1-Trns</td> <td>1</td>  <td>DataIn</td> <td>3</td> </tr>
  <tr><td>*</td> <td>X-Trns</td> <td>1</td>  <td>X or U or NC</td> <td>3</td> </tr>
  <tr><td>*</td> <td>*</td> <td>X</td> <td>X or U or 0 or NC</td> <td>4</td> </tr>
</table>

<blockquote><pre>
  *  = do not care
  U  = L.'U'
  0  = L.'0' or L.'L'
  1  = L.'1' or L.'H'
  X  = L.'X' or L.'W' or L.'Z' or L.'-'
  NC = no change

Clock transition definitions:
  1-Trns: 0 -> 1
  0-Trns: ~ -> 0 or 1 -> * or X -> X|U or U -> X|U
  X-Trns: 0 -> X|U or X|U -> 1
</pre></blockquote>
</html>", revisions="<html>
<ul>
<li><em>September 11, 2009</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>"));
        end DFFR;

        model DFFREG "Edge triggered register bank with high active reset"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          import S = Modelica.Electrical.Digital.Interfaces.Strength;
          import T = Modelica.Electrical.Digital.Tables;
          parameter SI.Time tHL=0 "High->Low delay";
          parameter SI.Time tLH=0 "Low->High delay";
          parameter D.Interfaces.Strength strength = S.'S_X01'
        "Output strength";
          parameter Integer n(min=1) = 1 "Data width";
    protected
          constant Integer ResetMap[L] = {1, 4, 3, 2, 4, 4, 3, 2, 4};
              // Function selection by [reset] reading
              // 1: output := U
              // 2: output := 0
              // 3: output := -dataInUX
              // 4: output := U-0X

    public
          Modelica.Electrical.Digital.Delay.InertialDelaySensitiveVector delay(
            tHL=tHL,
            tLH=tLH,
            n=n)
            annotation (Placement(transformation(extent={{22,11},{79,69}})));
          D.Interfaces.DigitalInput reset
            annotation (Placement(transformation(extent={{-100,-68},{-84,-52}}),
                iconTransformation(extent={{-100,-68},{-84,-52}})));
          D.Interfaces.DigitalInput clock
            annotation (Placement(transformation(extent={{-100,-28},{-84,-12}})));
          D.Interfaces.DigitalInput dataIn[n]
            annotation (Placement(transformation(extent={{-100,32},{-84,48}})));
          D.Interfaces.DigitalOutput dataOut[n]
            annotation (Placement(transformation(extent={{84,32},{100,48}}),
                iconTransformation(extent={{84,32},{100,48}})));

          D.Registers.DFFR dFFR(n=n,
            ResetMap=ResetMap,
            strength=strength)
            annotation (Placement(transformation(extent={{-78,-23},{18,74}})));
        equation
          connect(delay.y, dataOut) annotation (Line(
              points={{75.01,40},{92,40}},
              color={127,0,127},
              thickness=1));
          connect(dataIn, dFFR.dataIn) annotation (Line(
              points={{-92,40},{-68.4,40},{-68.4,40.05}},
              color={127,0,127},
              thickness=1));
          connect(dFFR.dataOut, delay.x) annotation (Line(
              points={{7.92,40.05},{25.99,39.855}},
              color={127,0,127},
              thickness=1));
          connect(clock, dFFR.clock) annotation (Line(
              points={{-92,-20},{-68.4,-20},{-68.4,15.8}}, color={127,0,127}));
          connect(reset, dFFR.reset) annotation (Line(
              points={{-92,-60},{-30,-60},{-30,-18.15}}, color={127,0,127}));
          annotation (Icon(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
            graphics={
            Rectangle(
              extent={{-50,70},{50,-50}},
              lineColor={127,0,127},
              lineThickness=0.5,
              fillPattern=FillPattern.Solid,
              fillColor={255,255,255}),
            Line(
              points={{-86,40},{-50,40}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{-84,-20},{-50,-20}},
              color={127,0,127}),
            Line(
              points={{-84,-60},{0,-60},{0,-50}},
              color={127,0,127}),
            Line(
              points={{50,40},{84,40}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{-50,-10},{-36,-20},{-50,-30}},
              color={127,0,127}),
            Text(
              extent={{-32,70},{30,10}},
              textColor={127,33,107},
              textString="DFFREG"),
            Text(
              extent={{-14,-34},{12,-46}},
              textColor={127,33,107},
              textString="reset"),
            Text(
              extent={{-28,-14},{-2,-26}},
              textColor={127,33,107},
              textString="clock"),
            Text(
              extent={{-26,44},{26,2}},
              textColor={127,33,107},
              textString="high active")}),
            Documentation(info="<html>
<p>Description in VHDL is given by http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</p>
<p><strong>Truth Table</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Clock</strong></td>
      <td><strong>Reset</strong></td>
      <td><strong>DataOut</strong></td>
  </tr>

  <tr><td>*</td> <td>*</td> <td>U</td>  <td>U</td> </tr>
  <tr><td>*</td> <td>*</td> <td>1</td>  <td>0</td> </tr>
  <tr><td>*</td> <td>0-Trns</td> <td>0</td>  <td>NC</td> </tr>
  <tr><td>*</td> <td>1-Trns</td> <td>0</td>  <td>DataIn</td> </tr>
  <tr><td>*</td> <td>X-Trns</td> <td>0</td>  <td>X or U or NC</td> </tr>
  <tr><td>*</td> <td>*</td> <td>X</td> <td>X or U or 0 or NC</td> </tr>
</table>

<blockquote><pre>
  *  = do not care
  U  = L.'U'
  0  = L.'0' or L.'L'
  1  = L.'1' or L.'H'
  X  = L.'X' or L.'W' or L.'Z' or L.'-'
  NC = no change

Clock transition definitions:
  1-Trns: 0 -> 1
  0-Trns: ~ -> 0 or 1 -> * or X -> X|U or U -> X|U
  X-Trns: 0 -> X|U or X|U -> 1
</pre></blockquote>
</html>", revisions="<html>
<ul>
<li><em>September 11, 2009</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>"));
        end DFFREG;

        model DFFREGL "Edge triggered register bank with low active reset"
          extends DFFREG(final ResetMap = {1, 4, 2, 3, 4, 4, 2, 3, 4});
              // Function selection by [reset] reading
              // 1: output := U
              // 2: output := 0
              // 3: output := -dataInUX
              // 4: output := U-0X;
          annotation (Documentation(info="<html>
<p>Description in VHDL is given by http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</p>
<p><strong>Truth Table</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Clock</strong></td>
      <td><strong>Reset</strong></td>
      <td><strong>DataOut</strong></td>
  </tr>

  <tr><td>*</td> <td>*</td> <td>U</td>  <td>U</td> </tr>
  <tr><td>*</td> <td>*</td> <td>0</td>  <td>0</td> </tr>
  <tr><td>*</td> <td>0-Trns</td> <td>1</td>  <td>NC</td> </tr>
  <tr><td>*</td> <td>1-Trns</td> <td>1</td>  <td>DataIn</td> </tr>
  <tr><td>*</td> <td>X-Trns</td> <td>1</td>  <td>X or U or NC</td> </tr>
  <tr><td>*</td> <td>*</td> <td>X</td> <td>X or U or 0 or NC</td> </tr>
</table>

<blockquote><pre>
  *  = do not care
  U  = L.'U'
  0  = L.'0' or L.'L'
  1  = L.'1' or L.'H'
  X  = L.'X' or L.'W' or L.'Z' or L.'-'
  NC = no change

Clock transition definitions:
  1-Trns: 0 -> 1
  0-Trns: ~ -> 0 or 1 -> * or X -> X|U or U -> X|U
  X-Trns: 0 -> X|U or X|U -> 1
</pre></blockquote>
</html>", revisions="<html>
<ul>
<li><em>September 11, 2009</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>"), Icon(graphics={Rectangle(
              extent={{-30,30},{28,16}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None), Text(
              extent={{-28,48},{24,-1}},
              textColor={127,33,107},
              textString="low active")}));
        end DFFREGL;

        model DFFSR "Edge triggered register bank with set and reset"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          import S = Modelica.Electrical.Digital.Interfaces.Strength;
          import T = Modelica.Electrical.Digital.Tables;
          parameter Integer ResetSetMap[L, L]=[
                     1,  1,  1,  1,  1,  1,  1,  1,  1;
                     1,  4,  7,  2,  4,  4,  7,  2,  4;
                     1,  5,  8,  2,  5,  5,  8,  2,  5;
                     1,  6,  3,  2,  6,  6,  3,  2,  6;
                     1,  4,  7,  2,  4,  4,  7,  2,  4;
                     1,  4,  7,  2,  4,  4,  7,  2,  4;
                     1,  5,  8,  2,  5,  5,  8,  2,  5;
                     1,  6,  3,  2,  6,  6,  3,  2,  6;
                     1,  4,  7,  2,  4,  4,  7,  2,  4]
        "Function selection by [reset, set] reading";
            /* Defaults for set and reset are active high */
          parameter D.Interfaces.Strength strength = S.'S_X01'
        "Output strength";
          parameter Integer n(min=1) = 1 "Data width";

          D.Interfaces.DigitalInput set
            annotation (Placement(transformation(extent={{-10,100},{10,80}})));
          D.Interfaces.DigitalInput reset
            annotation (Placement(transformation(extent={{-10,-100},{10,-80}}),
                iconTransformation(extent={{-10,-100},{10,-80}})));
          D.Interfaces.DigitalInput clock annotation (Placement(transformation(
                  extent={{-90,-20},{-70,0}}),  iconTransformation(extent={{-90,-30},
                    {-70,-10}})));
          D.Interfaces.DigitalInput dataIn[n] annotation (Placement(transformation(
                  extent={{-90,20},{-70,40}}), iconTransformation(extent={{-90,20},
                    {-70,40}})));
          D.Interfaces.DigitalOutput dataOut[n] annotation (Placement(
                transformation(extent={{68,20},{88,40}}),  iconTransformation(
                  extent={{69,20},{89,40}})));

    protected
                  Integer clock_flag(start=0);
                    // 0: 0-Transition
                    // 1: rising edge
                    // 2: X-Transition

                  Integer reset_set_flag(start=1);
                    // 1: output := U
                    // 2: output := 1
                    // 3: output := 0
                    // 4: output := UX
                    // 5: output := -1UX
                    // 6: output := X
                    // 7: output := -0UX
                    // 8: output := -dataInUX

                  D.Interfaces.Logic nextstate[n](start=fill(L.'U',n));
                  D.Interfaces.Logic next_assign_val[n](start=fill(L.'U',n));

        algorithm
        if change(clock) or change(reset) or change(set) then

          if change(clock) then
            if initial() then
              clock_flag := T.ClockMap[L.'U',clock];
            else
              clock_flag := T.ClockMap[pre(clock),clock];
            end if;
          end if;

          reset_set_flag := ResetSetMap[reset, set];
          for i in 1:n loop
            if reset_set_flag == 1 then
                  nextstate[i] := L.'U';
            elseif reset_set_flag == 2 then
                  nextstate[i] := T.StrengthMap[L.'1', strength];
            elseif reset_set_flag == 3 then
                  nextstate[i] := T.StrengthMap[L.'0', strength];
            elseif reset_set_flag == 4 then
              if (next_assign_val[i] == L.'U' and clock_flag <> 1)
                or (dataIn[i] == L.'U' and clock_flag <> 0) then
                  nextstate[i] := L.'U';
              else
                  nextstate[i] := T.StrengthMap[L.'X', strength];
              end if;
            elseif reset_set_flag == 5 then
              if next_assign_val[i] == T.StrengthMap[L.'1', strength]
                and (dataIn[i] == L.'1' or dataIn[i] == L.'H' or clock_flag == 0) then
                  break;
              elseif (dataIn[i] == L.'1' or dataIn[i] == L.'H')  and clock_flag == 1 then
                  nextstate[i] := T.StrengthMap[L.'1', strength];
              elseif (next_assign_val[i] == L.'U' and clock_flag <> 1)
                or (dataIn[i] == L.'U' and clock_flag <> 0) then
                  nextstate[i] := L.'U';
              else
                  nextstate[i] := T.StrengthMap[L.'X', strength];
              end if;
            elseif reset_set_flag == 6 then
                  nextstate[i] := T.StrengthMap[L.'X', strength];
            elseif reset_set_flag == 7 then
              if next_assign_val[i] == T.StrengthMap[L.'0', strength]
                and (dataIn[i] == L.'0' or dataIn[i] == L.'L' or clock_flag == 0) then
                  break;
              elseif (dataIn[i] == L.'0' or dataIn[i] == L.'L') and clock_flag == 1 then
                  nextstate[i] :=  T.StrengthMap[L.'0', strength];
              elseif (next_assign_val[i] == L.'U' and clock_flag <> 1)
                or (dataIn[i] == L.'U' and clock_flag <> 0) then
                  nextstate[i] := L.'U';
              else
                  nextstate[i] := T.StrengthMap[L.'X', strength];
              end if;
            elseif reset_set_flag == 8 then
              if clock_flag == 0 then
                  break;
              elseif clock_flag == 1 then
                  nextstate[i] := T.StrengthMap[dataIn[i], strength];
              else
                if next_assign_val[i] == T.StrengthMap[dataIn[i],strength]
                or next_assign_val[i] == L.'U' then
                    break;
                elseif (dataIn[i] == L.'U') then
                    nextstate[i] := L.'U';
                else
                    nextstate[i] := T.StrengthMap[L.'X', strength];
                end if;
               end if;
              end if;
            end for;
          end if;

        next_assign_val := nextstate;
        dataOut := nextstate;
          annotation (Icon(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
            graphics={
            Rectangle(
              extent={{-50,60},{50,-60}},
              lineColor={127,0,127},
              lineThickness=0.5,
              fillPattern=FillPattern.Solid,
              fillColor={255,255,255}),
            Line(
              points={{-80,30},{-50,30}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{50,30},{80,30}},
              color={127,33,107},
              thickness=1),
            Line(
              points={{-80,-20},{-50,-20}},
              color={127,33,107}),
            Line(
              points={{0,-84},{0,-60}},
              color={127,33,107}),
            Line(
              points={{-50,-8},{-34,-20},{-50,-32}},
              color={127,33,107}),
            Text(
              extent={{-36,66},{34,-8}},
              textColor={127,33,107},
              textString="DFFSR"),
            Text(
              extent={{-28,-14},{-2,-26}},
              textColor={127,33,107},
              textString="clock"),
            Text(
              extent={{-14,-44},{12,-56}},
              textColor={127,33,107},
              textString="reset"),
            Line(
              points={{0,80},{0,60}},
              color={127,0,127}),
            Text(
              extent={{-13,56},{13,44}},
              textColor={127,33,107},
              textString="set")}),
            Documentation(info="<html>
<p>Description in VHDL is given by http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</p>
<p><strong>Truth Table for high active set and reset</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Clock</strong></td>
      <td><strong>Reset</strong></td>
      <td><strong>Set</strong></td>
      <td><strong>DataOut</strong></td>
      <td>Map</td>
  </tr>

  <tr><td>*</td> <td>*</td> <td>*</td>  <td>U</td> <td>U</td> <td>1</td> </tr>
  <tr><td>*</td> <td>*</td> <td>U</td>  <td>*</td> <td>U</td> <td>1</td> </tr>
  <tr><td>*</td> <td>*</td> <td>*</td>  <td>1</td> <td>1</td> <td>2</td> </tr>
  <tr><td>*</td> <td>*</td> <td>1</td>  <td>0</td> <td>0</td> <td>3</td> </tr>
  <tr><td>*</td> <td>*</td> <td>1</td>  <td>X</td> <td>X</td> <td>6</td> </tr>
  <tr><td>*</td> <td>*</td> <td>X</td> <td>X</td> <td>X or U</td> <td>4</td> </tr>
  <tr><td>*</td> <td>*</td> <td>0</td> <td>X</td> <td>X or U or 1 or NC</td> <td>5</td> </tr>
  <tr><td>*</td> <td>*</td> <td>X</td> <td>0</td> <td>X or U or 0 or NC</td> <td>7</td> </tr>
  <tr><td>*</td> <td>X-Trns</td> <td>0</td>  <td>0</td> <td>X or U or NC</td> <td>8</td> </tr>
  <tr><td>*</td> <td>1-Trns</td> <td>0</td>  <td>0</td> <td>DataIn</td> <td>8</td> </tr>
  <tr><td>*</td> <td>0-Trns</td> <td>0</td>  <td>0</td> <td>NC</td> <td>8</td> </tr>

</table>

<p><strong>Truth Table for low active set and reset </strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Clock</strong></td>
      <td><strong>Reset</strong></td>
      <td><strong>Set</strong></td>
      <td><strong>DataOut</strong></td>
      <td>Map</td>
  </tr>

  <tr><td>*</td> <td>*</td> <td>*</td>  <td>U</td> <td>U</td> <td>1</td> </tr>
  <tr><td>*</td> <td>*</td> <td>U</td>  <td>*</td> <td>U</td> <td>1</td> </tr>
  <tr><td>*</td> <td>*</td> <td>*</td>  <td>0</td> <td>1</td> <td>2</td> </tr>
  <tr><td>*</td> <td>*</td> <td>0</td>  <td>1</td> <td>0</td> <td>3</td> </tr>
  <tr><td>*</td> <td>*</td> <td>0</td>  <td>X</td> <td>X</td> <td>6</td> </tr>
  <tr><td>*</td> <td>*</td> <td>X</td> <td>X</td> <td>X or U</td> <td>4</td> </tr>
  <tr><td>*</td> <td>*</td> <td>1</td> <td>X</td> <td>X or U or 1 or NC</td> <td>5</td> </tr>
  <tr><td>*</td> <td>*</td> <td>X</td> <td>1</td> <td>X or U or 0 or NC</td> <td>7</td> </tr>
  <tr><td>*</td> <td>X-Trns</td> <td>1</td>  <td>1</td> <td>X or U or NC</td> <td>8</td> </tr>
  <tr><td>*</td> <td>1-Trns</td> <td>1</td>  <td>1</td> <td>DataIn</td> <td>8</td> </tr>
  <tr><td>*</td> <td>0-Trns</td> <td>1</td>  <td>1</td> <td>NC</td> <td>8</td> </tr>
</table>

<blockquote><pre>
  *  = do not care
  ~  = not equal
  U  = L.'U'
  0  = L.'0' or L.'L'
  1  = L.'1' or L.'H'
  X  = L.'X' or L.'W' or L.'Z' or L.'-'
  NC = no change

Clock transition definitions:
  1-Trns: 0 -> 1
  0-Trns: ~ -> 0 or 1 -> * or X -> X|U or U -> X|U
  X-Trns: 0 -> X|U or X|U -> 1
</pre></blockquote>
</html>", revisions="<html>
<ul>
<li><em>September 11, 2009</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>"));
        end DFFSR;

        model DFFREGSRH "Edge triggered register bank with high active set and reset"
          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          import S = Modelica.Electrical.Digital.Interfaces.Strength;
          import T = Modelica.Electrical.Digital.Tables;
          parameter SI.Time tHL=0 "High->Low delay";
          parameter SI.Time tLH=0 "Low->High delay";
          parameter D.Interfaces.Strength strength = S.'S_X01'
        "Output strength";
          parameter Integer n(min=1) = 1 "Data width";

    protected
          constant Integer ResetSetMap[L, L]=[
                     1,  1,  1,  1,  1,  1,  1,  1,  1;
                     1,  4,  7,  2,  4,  4,  7,  2,  4;
                     1,  5,  8,  2,  5,  5,  8,  2,  5;
                     1,  6,  3,  2,  6,  6,  3,  2,  6;
                     1,  4,  7,  2,  4,  4,  7,  2,  4;
                     1,  4,  7,  2,  4,  4,  7,  2,  4;
                     1,  5,  8,  2,  5,  5,  8,  2,  5;
                     1,  6,  3,  2,  6,  6,  3,  2,  6;
                     1,  4,  7,  2,  4,  4,  7,  2,  4];
                    // Function selection by [reset, set] reading, active high;

    protected
          D.Delay.InertialDelaySensitiveVector delay(
            tHL=tHL,
            tLH=tLH,
            n=n,inertialDelaySensitive(each y(start=L.'U', fixed= true)))
          annotation (Placement(transformation(extent={{23,12},{79,68}})));

          D.Registers.DFFSR dFFSR(
            strength=strength,
            n=n,
            ResetSetMap=ResetSetMap, clock( start=L.'U', fixed=true), reset( start=L.'U', fixed=true), set( start=L.'U', fixed=true))
            annotation (Placement(transformation(extent={{-80,-25},{20,75}})));
    public
          D.Interfaces.DigitalInput set
            annotation (Placement(transformation(extent={{-100,72},{-84,88}})));
          D.Interfaces.DigitalInput reset
            annotation (Placement(transformation(extent={{-100,-68},{-84,-52}})));
          D.Interfaces.DigitalInput clock
            annotation (Placement(transformation(extent={{-100,-28},{-84,-12}})));
          D.Interfaces.DigitalInput dataIn[n]
            annotation (Placement(transformation(extent={{-100,32},{-84,48}})));
          D.Interfaces.DigitalOutput dataOut[n]
            annotation (Placement(transformation(extent={{84,32},{100,48}})));
        equation
          connect(dFFSR.dataOut, delay.x) annotation (Line(
              points={{9.5,40},{26.92,40},{26.92,39.86}},
              color={127,0,127},
              thickness=1));
          connect(set, dFFSR.set) annotation (Line(
              points={{-92,80},{-30,80},{-30,70}}, color={127,0,127}));
          connect(reset, dFFSR.reset) annotation (Line(
              points={{-92,-60},{-30,-60},{-30,-20}}, color={127,0,127}));
          connect(clock, dFFSR.clock) annotation (Line(
              points={{-92,-20},{-70,-20},{-70,15}}, color={127,0,127}));
          connect(dataIn, dFFSR.dataIn) annotation (Line(
              points={{-92,40},{-70,40}},
              color={127,0,127},
              thickness=1));
          connect(delay.y, dataOut) annotation (Line(
              points={{75.08,40},{92,40}},
              color={127,0,127},
              thickness=1));
          annotation (Icon(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
            graphics={
            Rectangle(
              extent={{-50,70},{52,-50}},
              lineColor={127,0,127},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-86,40},{-50,40}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{-84,-20},{-50,-20}},
              color={127,0,127}),
            Line(
              points={{52,40},{84,40}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{-50,-10},{-36,-20},{-50,-30}},
              color={127,0,127}),
            Text(
              extent={{-44,94},{38,-14}},
              textColor={127,33,107},
              textString="DFFREGSR"),
            Text(
              extent={{-14,-32},{12,-44}},
              textColor={127,33,107},
              textString="reset"),
            Text(
              extent={{-33,-13},{-7,-25}},
              textColor={127,33,107},
              textString="clock"),
            Line(
              points={{-84,80},{0,80},{0,70}},
              color={127,0,127}),
            Line(
              points={{-84,-60},{0,-60},{0,-50}},
              color={127,0,127}),
            Text(
              extent={{-14,66},{12,54}},
              textColor={127,33,107},
              textString="set"),
            Text(
              extent={{-32,38},{26,10}},
              textColor={127,0,127},
              textString="high active")}),
            Documentation(info="<html>
<p>Description in VHDL is given by http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</p>
<p><strong>Truth Table</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Clock</strong></td>
      <td><strong>Reset</strong></td>
      <td><strong>Set</strong></td>
      <td><strong>DataOut</strong></td>
  </tr>

  <tr><td>*</td> <td>*</td> <td>*</td>  <td>U</td> <td>U</td> </tr>
  <tr><td>*</td> <td>*</td> <td>U</td>  <td>*</td> <td>U</td> </tr>
  <tr><td>*</td> <td>*</td> <td>*</td>  <td>1</td> <td>1</td> </tr>
  <tr><td>*</td> <td>*</td> <td>1</td>  <td>0</td> <td>0</td> </tr>
  <tr><td>*</td> <td>*</td> <td>1</td>  <td>X</td> <td>X</td> </tr>
  <tr><td>*</td> <td>*</td> <td>X</td> <td>X</td> <td>X or U</td> </tr>
  <tr><td>*</td> <td>*</td> <td>0</td> <td>X</td> <td>X or U or 1 or NC</td> </tr>
  <tr><td>*</td> <td>*</td> <td>X</td> <td>0</td> <td>X or U or 0 or NC</td> </tr>
  <tr><td>*</td> <td>X-Trns</td> <td>0</td>  <td>0</td> <td>X or U or NC</td> </tr>
  <tr><td>*</td> <td>1-Trns</td> <td>0</td>  <td>0</td> <td>DataIn</td> </tr>
  <tr><td>*</td> <td>0-Trns</td> <td>0</td>  <td>0</td> <td>NC</td> </tr>
</table>

<blockquote><pre>
  *  = do not care
  ~  = not equal
  U  = L.'U'
  0  = L.'0' or L.'L'
  1  = L.'1' or L.'H'
  X  = L.'X' or L.'W' or L.'Z' or L.'-'
  NC = no change

Clock transition definitions:
  1-Trns: 0 -> 1
  0-Trns: ~ -> 0 or 1 -> * or X -> X|U or U -> X|U
  X-Trns: 0 -> X|U or X|U -> 1
</pre></blockquote>
</html>", revisions="<html>
<ul>
<li><em>September 11, 2009</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>"));
        end DFFREGSRH;

        model DFFREGSRL "Edge triggered register bank with low active set and reset"
          extends Digital.Registers.DFFREGSRH(final ResetSetMap=[1,1,1,1,1,1,1,1,1;
                1,4,2,7,4,4,2,7,4; 1,6,2,3,6,6,2,3,6; 1,5,2,8,5,5,2,8,5; 1,4,2,7,4,
                4,2,7,4; 1,4,2,7,4,4,2,7,4; 1,6,2,3,6,6,2,3,6; 1,5,2,8,5,5,2,8,5; 1,
                4,2,7,4,4,2,7,4]);
                   // Function selection by [reset, set] reading;
          annotation (Icon(graphics={Rectangle(
              extent={{-36,30},{28,16}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None), Text(
              extent={{-30,38},{24,12}},
              textColor={127,0,127},
              textString="low active")}), Documentation(info="<html>
<p>Description in VHDL is given by http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</p>

<p><strong>Truth Table</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Clock</strong></td>
      <td><strong>Reset</strong></td>
      <td><strong>Set</strong></td>
      <td><strong>DataOut</strong></td>
  </tr>

  <tr><td>*</td> <td>*</td> <td>*</td>  <td>U</td> <td>U</td> </tr>
  <tr><td>*</td> <td>*</td> <td>U</td>  <td>*</td> <td>U</td> </tr>
  <tr><td>*</td> <td>*</td> <td>*</td>  <td>0</td> <td>1</td> </tr>
  <tr><td>*</td> <td>*</td> <td>0</td>  <td>1</td> <td>0</td> </tr>
  <tr><td>*</td> <td>*</td> <td>0</td>  <td>X</td> <td>X</td> </tr>
  <tr><td>*</td> <td>*</td> <td>X</td> <td>X</td> <td>X or U</td> </tr>
  <tr><td>*</td> <td>*</td> <td>1</td> <td>X</td> <td>X or U or 1 or NC</td> </tr>
  <tr><td>*</td> <td>*</td> <td>X</td> <td>1</td> <td>X or U or 0 or NC</td> </tr>
  <tr><td>*</td> <td>X-Trns</td> <td>1</td>  <td>1</td> <td>X or U or NC</td> </tr>
  <tr><td>*</td> <td>1-Trns</td> <td>1</td>  <td>1</td> <td>DataIn</td> </tr>
  <tr><td>*</td> <td>0-Trns</td> <td>1</td>  <td>1</td> <td>NC</td> </tr>
</table>

<blockquote><pre>
  *  = do not care
  ~  = not equal
  U  = L.'U'
  0  = L.'0' or L.'L'
  1  = L.'1' or L.'H'
  X  = L.'X' or L.'W' or L.'Z' or L.'-'
  NC = no change

Clock transition definitions:
  1-Trns: 0 -> 1
  0-Trns: ~ -> 0 or 1 -> * or X -> X|U or U -> X|U
  X-Trns: 0 -> X|U or X|U -> 1
</pre></blockquote>
</html>", revisions="<html>
<ul>
<li><em>September 11, 2009</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>"));
        end DFFREGSRL;

        model DLATR "Level sensitive register bank with reset"

          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          import S = Modelica.Electrical.Digital.Interfaces.Strength;
          import T = Modelica.Electrical.Digital.Tables;
          parameter Integer ResetMap[L] = {1, 4, 3, 2, 4, 4, 3, 2, 4}
        "Function selection, defaults for high active reset";
          parameter D.Interfaces.Strength strength = S.'S_X01'
        "Output strength";
          parameter Integer n(min=1) = 1 "Data width";

          D.Interfaces.DigitalInput reset
            annotation (Placement(transformation(extent={{-10,-100},{10,-80}}),
                iconTransformation(extent={{-10,-100},{10,-80}})));
          D.Interfaces.DigitalInput enable
                                          annotation (Placement(transformation(
                  extent={{-90,-20},{-70,0}}),  iconTransformation(extent={{-90,-30},
                    {-70,-10}})));
          D.Interfaces.DigitalInput dataIn[n] annotation (Placement(transformation(
                  extent={{-90,20},{-70,40}}), iconTransformation(extent={{-90,20},
                    {-70,40}})));
          D.Interfaces.DigitalOutput dataOut[n] annotation (Placement(
                transformation(extent={{66,24},{86,44}}),  iconTransformation(
                  extent={{69,20},{89,40}})));

    protected
                   Integer enable_flag(start=0);
                    // 0: low level
                    // 1: high level
                    // 2: unknown
                    // 3: uninitialized

                   Integer reset_flag(start=1);
                    // 1: output := U
                    // 2: output := 0
                    // 3: output := -UdataIn
                    // 4: output := U-0X

                  D.Interfaces.Logic nextstate[n](start=fill(L.'U',n));
                  D.Interfaces.Logic next_assign_val[n](start=fill(L.'U',n));
        algorithm
          if enable == L.'1' or enable == L.'H' then
            enable_flag := 1;
          elseif enable == L.'0' or enable == L.'L' then
            enable_flag := 0;
          elseif enable == L.'U' then
            enable_flag := 3;
          else
            enable_flag := 2;
          end if;

          reset_flag :=  ResetMap[reset];
          for i in 1:n loop
            if reset_flag == 1 then
                  nextstate[i] := L.'U';
            elseif reset_flag == 2 then
                  nextstate[i] := T.StrengthMap[L.'0', strength];
            elseif reset_flag == 3 then
              if enable_flag == 0 then
                  break;
              elseif enable_flag == 3 then
                  nextstate[i] := L.'U';
              elseif enable_flag == 1 then
                  nextstate[i] := T.StrengthMap[dataIn[i], strength];
              else
                if next_assign_val[i] == T.StrengthMap[dataIn[i],strength]
                or next_assign_val[i] == L.'U' then
                    break;
                elseif dataIn[i] == L.'U' then
                    nextstate[i] := L.'U';
                else
                    nextstate[i] := T.StrengthMap[L.'X', strength];
                end if;
              end if;
            elseif reset_flag == 4 then
             if enable_flag == 3
                or (next_assign_val[i] == L.'U' and enable_flag <> 1)
                or (dataIn[i] == L.'U' and enable_flag <> 0) then
                  nextstate[i] := L.'U';
              elseif next_assign_val[i] == T.StrengthMap[L.'0', strength]
                and (dataIn[i] == L.'0' or dataIn[i] == L.'L' or enable_flag == 0) then
                  break;
              elseif (dataIn[i] == L.'0' or dataIn[i] == L.'L') and enable_flag == 1 then
                  nextstate[i] :=  T.StrengthMap[L.'0', strength];
              else
                  nextstate[i] := T.StrengthMap[L.'X', strength];
              end if;
            end if;
          end for;
          next_assign_val := nextstate;
          dataOut := nextstate;
           annotation (
            Documentation(info="<html>

<p> Description in VHDL is given by <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>
<p><strong>Truth Table for high active reset:</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Enable</strong></td>
      <td><strong>Reset</strong></td>
      <td><strong>DataOut</strong></td>
      <td>Map</td>
  </tr>

  <tr><td>*</td> <td>*</td> <td>U</td>  <td>U</td> <td>1</td> </tr>
  <tr><td>*</td> <td>*</td> <td>1</td>  <td>0</td> <td>2</td> </tr>
  <tr><td>*</td> <td>0</td> <td>0</td>  <td>NC</td> <td>3</td> </tr>
  <tr><td>*</td> <td>1</td> <td>0</td>  <td>DataIn</td> <td>3</td> </tr>
  <tr><td>*</td> <td>X</td> <td>0</td>  <td>X or U or NC</td> <td>3</td> </tr>
  <tr><td>*</td> <td>U</td> <td>~1</td> <td>U</td> <td>4</td> </tr>
  <tr><td>*</td> <td>~U</td> <td>X</td> <td>X or U or 0 or NC</td> <td>4</td> </tr>
</table>

<p><strong>Truth Table for low active reset:</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Enable</strong></td>
      <td><strong>Reset</strong></td>
      <td><strong>DataOut</strong></td>
      <td>Map</td>
  </tr>

  <tr><td>*</td> <td>*</td> <td>U</td> <td>U</td> <td>1</td> </tr>
  <tr><td>*</td> <td>*</td> <td>0</td> <td>0</td> <td>2</td> </tr>
  <tr><td>*</td> <td>0</td> <td>1</td> <td>NC</td> <td>3</td> </tr>
  <tr><td>*</td> <td>1</td> <td>1</td> <td>DataIn</td> <td>3</td> </tr>
  <tr><td>*</td> <td>X</td> <td>1</td> <td>X or U or NC</td> <td>3</td> </tr>
  <tr><td>*</td> <td>U</td> <td>~0</td> <td>U</td> <td>4</td> </tr>
  <tr><td>*</td> <td>~U</td> <td>X</td> <td>X or U or 0 or NC</td> <td>4</td> </tr>
</table>

<blockquote><pre>
*  = do not care
~  = not equal
U  = L.'U'
0  = L.'0' or L.'L'
1  = L.'1' or L.'H'
X  = L.'X' or L.'W' or L.'Z' or L.'-'
NC = no change
</pre></blockquote>
</html>", revisions="<html>
<ul>
<li><em>September 11, 2009</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>"), Icon(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
            graphics={
            Rectangle(
              extent={{-50,60},{50,-60}},
              lineColor={127,0,127},
              lineThickness=0.5,
              fillPattern=FillPattern.Solid,
              fillColor={255,255,255}),
            Line(
              points={{-80,30},{-50,30}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{50,30},{80,30}},
              color={127,33,107},
              thickness=1),
            Line(
              points={{-80,-20},{-50,-20}},
              color={127,33,107}),
            Line(
              points={{0,-84},{0,-60}},
              color={127,33,107}),
            Line(
              points={{-50,-8},{-34,-20},{-50,-32}},
              color={127,33,107}),
            Text(
              extent={{-30,58},{26,2}},
              textColor={127,33,107},
              textString="DLATR"),
            Text(
              extent={{-29,-8},{6,-32}},
              textColor={127,33,107},
              textString="enable"),
            Text(
              extent={{-14,-44},{12,-56}},
              textColor={127,33,107},
              textString="reset")}));
        end DLATR;

        model DLATREG "Level sensitive register bank with reset active high"

          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          import S = Modelica.Electrical.Digital.Interfaces.Strength;
          import T = Modelica.Electrical.Digital.Tables;
          parameter SI.Time tHL=0 "High->Low delay";
          parameter SI.Time tLH=0 "Low->High delay";
          parameter D.Interfaces.Strength strength = S.'S_X01'
        "Output strength";
          parameter Integer n(min=1) = 1 "Data width";

    protected
          constant Integer ResetMap[L] = {1, 4, 3, 2, 4, 4, 3, 2, 4};
              // Function selection by [reset] reading
              // 1: output := U
              // 2: output := 0
              // 3: output := -UdataIn
              // 4: output := U-0X

    public
          D.Delay.InertialDelaySensitiveVector delay(
            tHL=tHL,
            tLH=tLH,
            n=n)
          annotation (Placement(transformation(extent={{20,12},{76,68}})));
          D.Interfaces.DigitalInput reset
            annotation (Placement(transformation(extent={{-100,-68},{-84,-52}})));
          D.Interfaces.DigitalInput enable
            annotation (Placement(transformation(extent={{-100,-28},{-84,-12}})));
          D.Interfaces.DigitalInput dataIn[n]
            annotation (Placement(transformation(extent={{-100,32},{-84,48}})));
          D.Interfaces.DigitalOutput dataOut[n]
            annotation (Placement(transformation(extent={{84,32},{100,48}}),
                iconTransformation(extent={{84,32},{100,48}})));
          D.Registers.DLATR dLATR(n=n,
            strength=strength,
            ResetMap=ResetMap)
            annotation (Placement(transformation(extent={{-78,-23},{18,74}})));
        equation

          connect(delay.y, dataOut) annotation (Line(
              points={{72.08,40},{92,40}},
              color={127,0,127},
              thickness=1));
          connect(dLATR.dataOut, delay.x) annotation (Line(
              points={{7.92,40.05},{15.96,39.86},{23.92,39.86}},
              color={127,0,127},
              thickness=1));
          connect(dataIn, dLATR.dataIn) annotation (Line(
              points={{-92,40},{-80.2,40},{-80.2,40.05},{-68.4,40.05}},
              color={127,0,127},
              thickness=1));
          connect(enable, dLATR.enable) annotation (Line(
              points={{-92,-20},{-68.4,-20},{-68.4,15.8}}, color={127,0,127}));
          connect(reset, dLATR.reset) annotation (Line(
              points={{-92,-60},{-30,-60},{-30,-18.15}}, color={127,0,127}));
           annotation (
            Documentation(info="<html>
<p>Description in VHDL is given by http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</p>
<p><strong>Truth Table</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Enable</strong></td>
      <td><strong>Reset</strong></td>
      <td><strong>DataOut</strong></td>
  </tr>

  <tr><td>*</td> <td>*</td> <td>U</td>  <td>U</td> </tr>
  <tr><td>*</td> <td>*</td> <td>1</td>  <td>0</td> </tr>
  <tr><td>*</td> <td>0</td> <td>0</td>  <td>NC</td> </tr>
  <tr><td>*</td> <td>1</td> <td>0</td>  <td>DataIn</td> </tr>
  <tr><td>*</td> <td>X</td> <td>0</td>  <td>X or U or NC</td> </tr>
  <tr><td>*</td> <td>U</td> <td>~1</td> <td>U</td> </tr>
  <tr><td>*</td> <td>~U</td> <td>X</td> <td>X or U or 0 or NC</td> </tr>
</table>

<blockquote><pre>
*  = do not care
~  = not equal
U  = L.'U'
0  = L.'0' or L.'L'
1  = L.'1' or L.'H'
X  = L.'X' or L.'W' or L.'Z' or L.'-'
NC = no change
</pre></blockquote>
</html>", revisions="<html>
<ul>
<li><em>September 11, 2009</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>"), Icon(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
            graphics={
            Rectangle(
              extent={{-50,70},{52,-50}},
              lineColor={127,0,127},
              lineThickness=0.5,
              fillPattern=FillPattern.Solid,
              fillColor={255,255,255}),
            Line(
              points={{-86,40},{-50,40}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{-84,-20},{-50,-20}},
              color={127,0,127}),
            Line(
              points={{52,40},{84,40}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{-50,-10},{-36,-20},{-50,-30}},
              color={127,0,127}),
            Text(
              extent={{-32,82},{32,-2}},
              textColor={127,0,127},
              textString="DLATREG"),
            Text(
              extent={{-14,-33},{12,-45}},
              textColor={127,33,107},
              textString="reset"),
            Text(
              extent={{-33,-7},{-1,-32}},
              textColor={127,33,107},
              textString="enable"),
            Line(
              points={{-84,-60},{0,-60},{0,-50}},
              color={127,0,127}),
            Text(
              extent={{-26,44},{26,2}},
              textColor={127,33,107},
              textString="high active")}));
        end DLATREG;

        model DLATREGL "Level sensitive register bank with reset active low"

          extends DLATREG(final ResetMap = {1, 4, 2, 3, 4, 4, 2, 3, 4});
              // Function selection by [reset] reading
              // 1: output := U
              // 2: output := 0
              // 3: output := -UdataIn
              // 4: output := U-0X

           annotation (
            Documentation(info="<html>
<p>Description in VHDL is given by http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</p>
<p><strong>Truth Table</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Enable</strong></td>
      <td><strong>Reset</strong></td>
      <td><strong>DataOut</strong></td>
  </tr>

  <tr><td>*</td> <td>*</td> <td>U</td> <td>U</td> </tr>
  <tr><td>*</td> <td>*</td> <td>0</td> <td>0</td> </tr>
  <tr><td>*</td> <td>0</td> <td>1</td> <td>NC</td> </tr>
  <tr><td>*</td> <td>1</td> <td>1</td> <td>DataIn</td> </tr>
  <tr><td>*</td> <td>X</td> <td>1</td> <td>X or U or NC</td> </tr>
  <tr><td>*</td> <td>U</td> <td>~0</td> <td>U</td> </tr>
  <tr><td>*</td> <td>~U</td> <td>X</td> <td>X or U or 0 or NC</td> </tr>
</table>

<blockquote><pre>
*  = do not care
~  = not equal
U  = L.'U'
0  = L.'0' or L.'L'
1  = L.'1' or L.'H'
X  = L.'X' or L.'W' or L.'Z' or L.'-'
NC = no change
</pre></blockquote>
</html>", revisions="<html>
<ul>
<li><em>September 11, 2009</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>"), Icon(graphics={Rectangle(
              extent={{-28,30},{30,18}},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-26,48},{26,-1}},
              textColor={127,33,107},
              textString="low active")}));
        end DLATREGL;

        model DLATSR "Level sensitive register bank with set and reset"

          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          import S = Modelica.Electrical.Digital.Interfaces.Strength;
          import T = Modelica.Electrical.Digital.Tables;
          parameter Integer ResetSetMap[L, L]=[
                     1,  1,  1,  1,  1,  1,  1,  1,  1;
                     1,  4,  7,  2,  4,  4,  7,  2,  4;
                     1,  5,  8,  2,  5,  5,  8,  2,  5;
                     1,  6,  3,  2,  6,  6,  3,  2,  6;
                     1,  4,  7,  2,  4,  4,  7,  2,  4;
                     1,  4,  7,  2,  4,  4,  7,  2,  4;
                     1,  5,  8,  2,  5,  5,  8,  2,  5;
                     1,  6,  3,  2,  6,  6,  3,  2,  6;
                     1,  4,  7,  2,  4,  4,  7,  2,  4]
        "Function selection by [reset, set] reading";
            /* Defaults for set and reset are active high */
          parameter D.Interfaces.Strength strength = S.'S_X01'
        "Output strength";
          parameter Integer n(min=1) = 1 "Data width";

          D.Interfaces.DigitalInput set
            annotation (Placement(transformation(extent={{-10,100},{10,80}})));
          D.Interfaces.DigitalInput reset
            annotation (Placement(transformation(extent={{-10,-100},{10,-80}}),
                iconTransformation(extent={{-10,-100},{10,-80}})));
          D.Interfaces.DigitalInput enable
                                          annotation (Placement(transformation(
                  extent={{-90,-20},{-70,0}}),  iconTransformation(extent={{-90,-30},
                    {-70,-10}})));
          D.Interfaces.DigitalInput dataIn[n] annotation (Placement(transformation(
                  extent={{-90,20},{-70,40}}), iconTransformation(extent={{-90,20},
                    {-70,40}})));
          D.Interfaces.DigitalOutput dataOut[n] annotation (Placement(
                transformation(extent={{68,20},{88,40}}),  iconTransformation(
                  extent={{69,20},{89,40}})));

    protected
                  Integer enable_flag(start=0);
                    // 0: low level
                    // 1: high level
                    // 2: unknown
                    // 3: uninitialized

                  Integer reset_set_flag(start=1);
                    // 1: output := U
                    // 2: output := 1
                    // 3: output := 0
                    // 4: output := UX
                    // 5: output := U-1X
                    // 6: output := X
                    // 7: output := U-0X
                    // 8: output := -UdataInX

                  D.Interfaces.Logic nextstate[n](start=fill(L.'U',n));
                  D.Interfaces.Logic next_assign_val[n](start=fill(L.'U',n));

        algorithm
          if enable == L.'1' or enable == L.'H' then
            enable_flag := 1;
          elseif enable == L.'0' or enable == L.'L' then
            enable_flag := 0;
          elseif enable == L.'U' then
            enable_flag := 3;
          else
            enable_flag := 2;
          end if;

          reset_set_flag :=  ResetSetMap[reset, set];
          for i in 1:n loop
            if reset_set_flag == 1 then
                  nextstate[i] := L.'U';
            elseif reset_set_flag == 2 then
                  nextstate[i] := T.StrengthMap[L.'1', strength];
            elseif reset_set_flag == 3 then
                  nextstate[i] := T.StrengthMap[L.'0', strength];
            elseif reset_set_flag == 4 then
              if enable_flag == 3
                or (next_assign_val[i] == L.'U' and enable_flag <> 1)
                or (dataIn[i] == L.'U' and enable_flag <> 0) then
                  nextstate[i] := L.'U';
              else
                  nextstate[i] := T.StrengthMap[L.'X', strength];
              end if;
            elseif reset_set_flag == 5 then
              if enable_flag == 3
                or (next_assign_val[i] == L.'U' and enable_flag <> 1)
                or (dataIn[i] == L.'U' and enable_flag <> 0) then
                  nextstate[i] := L.'U';
              elseif next_assign_val[i] == T.StrengthMap[L.'1', strength]
                and (dataIn[i] == L.'1' or dataIn[i] == L.'H' or enable_flag == 0) then
                  break;
              elseif (dataIn[i] == L.'1' or dataIn[i] == L.'H')  and enable_flag == 1 then
                  nextstate[i] := T.StrengthMap[L.'1', strength];
              else
                  nextstate[i] := T.StrengthMap[L.'X', strength];
              end if;
            elseif reset_set_flag == 6 then
                  nextstate[i] := T.StrengthMap[L.'X', strength];
            elseif reset_set_flag == 7 then
              if enable_flag == 3
                or (next_assign_val[i] == L.'U' and enable_flag <> 1)
                or (dataIn[i] == L.'U' and enable_flag <> 0) then
                  nextstate[i] := L.'U';
              elseif next_assign_val[i] == T.StrengthMap[L.'0', strength]
                and (dataIn[i] == L.'0' or dataIn[i] == L.'L' or enable_flag == 0) then
                  break;
              elseif (dataIn[i] == L.'0' or dataIn[i] == L.'L') and enable_flag == 1 then
                  nextstate[i] :=  T.StrengthMap[L.'0', strength];
              else
                  nextstate[i] := T.StrengthMap[L.'X', strength];
              end if;
            elseif reset_set_flag == 8 then
              if enable_flag == 0 then
                  break;
              elseif enable_flag == 3 then
                  nextstate[i] := L.'U';
              elseif enable_flag == 1 then
                  nextstate[i] := T.StrengthMap[dataIn[i], strength];
              else
                if next_assign_val[i] == T.StrengthMap[dataIn[i],strength]
                or next_assign_val[i] == L.'U' then
                    break;
                elseif dataIn[i] == L.'U' then
                    nextstate[i] := L.'U';
                else
                    nextstate[i] := T.StrengthMap[L.'X', strength];
                end if;
              end if;
            end if;
          end for;
          next_assign_val := nextstate;
          dataOut := nextstate;
           annotation (
            Documentation(info="<html>
<p>Description in VHDL is given by http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</p>
<p><strong>Truth Table for high active set and reset</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Enable</strong></td>
      <td><strong>Reset</strong></td>
      <td><strong>Set</strong></td>
      <td><strong>DataOut</strong></td>
      <td>Map</td>
  </tr>

  <tr><td>*</td> <td>*</td> <td>*</td>  <td>U</td> <td>U</td> <td>1</td> </tr>
  <tr><td>*</td> <td>*</td> <td>U</td>  <td>~1</td> <td>U</td> <td>1</td> </tr>
  <tr><td>*</td> <td>*</td> <td>*</td>  <td>1</td> <td>1</td> <td>2</td> </tr>
  <tr><td>*</td> <td>*</td> <td>1</td>  <td>0</td> <td>0</td> <td>3</td> </tr>
  <tr><td>*</td> <td>*</td> <td>1</td>  <td>X</td> <td>X</td> <td>6</td> </tr>
  <tr><td>*</td> <td>U</td> <td>~1</td> <td>~1</td> <td>U</td> <td>4,5,7,8</td> </tr>
  <tr><td>*</td> <td>~U</td> <td>X</td> <td>X</td> <td>X or U</td> <td>4</td> </tr>
  <tr><td>*</td> <td>~U</td> <td>0</td> <td>X</td> <td>X or U or 1 or NC</td> <td>5</td> </tr>
  <tr><td>*</td> <td>~U</td> <td>X</td> <td>0</td> <td>X or U or 0 or NC</td> <td>7</td> </tr>
  <tr><td>*</td> <td>X</td> <td>0</td>  <td>0</td> <td>X or U or NC</td> <td>8</td> </tr>
  <tr><td>*</td> <td>1</td> <td>0</td>  <td>0</td> <td>DataIn</td> <td>8</td> </tr>
  <tr><td>*</td> <td>0</td> <td>0</td>  <td>0</td> <td>NC</td> <td>8</td> </tr>

</table>

<p><strong>Truth Table for low active set and reset </strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Enable</strong></td>
      <td><strong>Reset</strong></td>
      <td><strong>Set</strong></td>
      <td><strong>DataOut</strong></td>
      <td>Map</td>
  </tr>

  <tr><td>*</td> <td>*</td> <td>*</td>  <td>U</td> <td>U</td> <td>1</td> </tr>
  <tr><td>*</td> <td>*</td> <td>U</td>  <td>~0</td> <td>U</td> <td>1</td> </tr>
  <tr><td>*</td> <td>*</td> <td>*</td>  <td>0</td> <td>1</td> <td>2</td> </tr>
  <tr><td>*</td> <td>*</td> <td>0</td>  <td>1</td> <td>0</td> <td>3</td> </tr>
  <tr><td>*</td> <td>*</td> <td>0</td>  <td>X</td> <td>X</td> <td>6</td> </tr>
  <tr><td>*</td> <td>U</td> <td>~0</td> <td>~0</td> <td>U</td> <td>4,5,7,8</td> </tr>
  <tr><td>*</td> <td>~U</td> <td>X</td> <td>X</td> <td>X or U</td> <td>4</td> </tr>
  <tr><td>*</td> <td>~U</td> <td>1</td> <td>X</td> <td>X or U or 1 or NC</td> <td>5</td> </tr>
  <tr><td>*</td> <td>~U</td> <td>X</td> <td>1</td> <td>X or U or 0 or NC</td> <td>7</td> </tr>
  <tr><td>*</td> <td>X</td> <td>1</td>  <td>1</td> <td>X or U or NC</td> <td>8</td> </tr>
  <tr><td>*</td> <td>1</td> <td>1</td>  <td>1</td> <td>DataIn</td> <td>8</td> </tr>
  <tr><td>*</td> <td>0</td> <td>1</td>  <td>1</td> <td>NC</td> <td>8</td> </tr>

</table>

<blockquote><pre>
*  = do not care
~  = not equal
U  = L.'U'
0  = L.'0' or L.'L'
1  = L.'1' or L.'H'
X  = L.'X' or L.'W' or L.'Z' or L.'-'
NC = no change
</pre></blockquote>
</html>", revisions="<html>
<ul>
<li><em>September 11, 2009</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>"), Icon(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
            graphics={
            Rectangle(
              extent={{-50,60},{50,-60}},
              lineColor={127,0,127},
              lineThickness=0.5,
              fillPattern=FillPattern.Solid,
              fillColor={255,255,255}),
            Line(
              points={{-80,30},{-50,30}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{50,30},{80,30}},
              color={127,33,107},
              thickness=1),
            Line(
              points={{-80,-20},{-50,-20}},
              color={127,33,107}),
            Line(
              points={{0,-84},{0,-60}},
              color={127,33,107}),
            Line(
              points={{-50,-8},{-34,-20},{-50,-32}},
              color={127,33,107}),
            Text(
              extent={{-34,60},{32,-6}},
              textColor={127,33,107},
              textString="DLATSR"),
            Text(
              extent={{-29,-8},{5,-30}},
              textColor={127,33,107},
              textString="enable"),
            Text(
              extent={{-14,-44},{12,-56}},
              textColor={127,33,107},
              textString="reset"),
            Line(
              points={{0,80},{0,60}},
              color={127,0,127}),
            Text(
              extent={{-13,56},{13,44}},
              textColor={127,33,107},
              textString="set")}));
        end DLATSR;

        model DLATREGSRH "Level sensitive register bank with set and reset, active high"

          import D = Modelica.Electrical.Digital;
          import L = Modelica.Electrical.Digital.Interfaces.Logic;
          import S = Modelica.Electrical.Digital.Interfaces.Strength;
          import T = Modelica.Electrical.Digital.Tables;
          parameter SI.Time tHL=0 "High->Low delay";
          parameter SI.Time tLH=0 "Low->High delay";
          parameter D.Interfaces.Strength strength = S.'S_X01'
        "Output strength";
          parameter Integer n(min=1) = 1 "Data width";

    protected
          constant Integer ResetSetMap[L, L]=[
                     1,  1,  1,  1,  1,  1,  1,  1,  1;
                     1,  4,  7,  2,  4,  4,  7,  2,  4;
                     1,  5,  8,  2,  5,  5,  8,  2,  5;
                     1,  6,  3,  2,  6,  6,  3,  2,  6;
                     1,  4,  7,  2,  4,  4,  7,  2,  4;
                     1,  4,  7,  2,  4,  4,  7,  2,  4;
                     1,  5,  8,  2,  5,  5,  8,  2,  5;
                     1,  6,  3,  2,  6,  6,  3,  2,  6;
                     1,  4,  7,  2,  4,  4,  7,  2,  4];
                    // Function selection by [reset, set] reading, active high;

    public
          D.Delay.InertialDelaySensitiveVector delay(
            tHL=tHL,
            tLH=tLH,
            n=n)
          annotation (Placement(transformation(extent={{20,12},{76,68}})));
          D.Interfaces.DigitalInput set
            annotation (Placement(transformation(extent={{-100,72},{-84,88}})));
          D.Interfaces.DigitalInput reset
            annotation (Placement(transformation(extent={{-100,-68},{-84,-52}})));
          D.Interfaces.DigitalInput enable
            annotation (Placement(transformation(extent={{-100,-28},{-84,-12}})));
          D.Interfaces.DigitalInput dataIn[n]
            annotation (Placement(transformation(extent={{-100,32},{-84,48}})));
          D.Interfaces.DigitalOutput dataOut[n]
            annotation (Placement(transformation(extent={{84,32},{100,48}}),
                iconTransformation(extent={{84,32},{100,48}})));
          D.Registers.DLATSR dLATSR(n=n,
            ResetSetMap=ResetSetMap,
            strength=strength)
            annotation (Placement(transformation(extent={{-78,-23},{18,74}})));
        equation

          connect(delay.y, dataOut) annotation (Line(
              points={{72.08,40},{92,40}},
              color={127,0,127},
              thickness=1));
          connect(set, dLATSR.set) annotation (Line(
              points={{-92,80},{-30,80},{-30,69.15}}, color={127,0,127}));
          connect(reset, dLATSR.reset) annotation (Line(
              points={{-92,-60},{-30,-60},{-30,-18.15}}, color={127,0,127}));
          connect(enable, dLATSR.enable) annotation (Line(
              points={{-92,-20},{-68.4,-20},{-68.4,15.8}}, color={127,0,127}));
          connect(dataIn, dLATSR.dataIn) annotation (Line(
              points={{-92,40},{-80.2,40},{-80.2,40.05},{-68.4,40.05}},
              color={127,0,127},
              thickness=1));
          connect(dLATSR.dataOut, delay.x) annotation (Line(
              points={{7.92,40.05},{23.92,40.05},{23.92,39.86}},
              color={127,0,127},
              thickness=1));
           annotation (
            Documentation(info="<html>
<p>Description in VHDL is given by http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</p>
<p><strong>Truth Table:</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Enable</strong></td>
      <td><strong>Reset</strong></td>
      <td><strong>Set</strong></td>
      <td><strong>DataOut</strong></td>
  </tr>

  <tr><td>*</td> <td>*</td> <td>*</td>  <td>U</td> <td>U</td> </tr>
  <tr><td>*</td> <td>*</td> <td>U</td>  <td>~1</td> <td>U</td> </tr>
  <tr><td>*</td> <td>*</td> <td>*</td>  <td>1</td> <td>1</td> </tr>
  <tr><td>*</td> <td>*</td> <td>1</td>  <td>0</td> <td>0</td> </tr>
  <tr><td>*</td> <td>*</td> <td>1</td>  <td>X</td> <td>X</td> </tr>
  <tr><td>*</td> <td>U</td> <td>~1</td> <td>~1</td> <td>U</td> </tr>
  <tr><td>*</td> <td>~U</td> <td>X</td> <td>X</td> <td>X or U</td> </tr>
  <tr><td>*</td> <td>~U</td> <td>0</td> <td>X</td> <td>X or U or 1 or NC</td> </tr>
  <tr><td>*</td> <td>~U</td> <td>X</td> <td>0</td> <td>X or U or 0 or NC</td> </tr>
  <tr><td>*</td> <td>X</td> <td>0</td>  <td>0</td> <td>X or U or NC</td> </tr>
  <tr><td>*</td> <td>1</td> <td>0</td>  <td>0</td> <td>DataIn</td> </tr>
  <tr><td>*</td> <td>0</td> <td>0</td>  <td>0</td> <td>NC</td> </tr>

</table>

<blockquote><pre>
*  = do not care
~  = not equal
U  = L.'U'
0  = L.'0' or L.'L'
1  = L.'1' or L.'H'
X  = L.'X' or L.'W' or L.'Z' or L.'-'
NC = no change
</pre></blockquote>
</html>", revisions="<html>
<ul>
<li><em>September 11, 2009</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>"), Icon(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
            graphics={
            Rectangle(
              extent={{-50,70},{52,-50}},
              lineColor={127,0,127},
              lineThickness=0.5,
              fillPattern=FillPattern.Solid,
              fillColor={255,255,255}),
            Line(
              points={{-86,40},{-50,40}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{-84,-20},{-50,-20}},
              color={127,0,127}),
            Line(
              points={{52,40},{84,40}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{-50,-10},{-36,-20},{-50,-30}},
              color={127,0,127}),
            Text(
              extent={{-46,96},{46,-18}},
              textColor={127,0,127},
              textString="DLATREGSR"),
            Text(
              extent={{-14,-32},{14,-45}},
              textColor={127,33,107},
              textString="reset"),
            Text(
              extent={{-33,-7},{-1,-32}},
              textColor={127,33,107},
              textString="enable"),
            Line(
              points={{-84,80},{0,80},{0,70}},
              color={127,0,127}),
            Line(
              points={{-84,-60},{0,-60},{0,-50}},
              color={127,0,127}),
            Text(
              extent={{-14,67},{12,53}},
              textColor={127,33,107},
              textString="set"),
            Text(
              extent={{-28,38},{30,10}},
              textColor={127,0,127},
              textString="high active")}));
        end DLATREGSRH;

        model DLATREGSRL "Level sensitive register bank with set and reset, active low"

          extends Digital.Registers.DLATREGSRH(final ResetSetMap=[1,1,1,1,1,1,1,1,1;
                1,4,2,7,4,4,2,7,4; 1,6,2,3,5,5,2,3,6; 1,5,2,8,6,6,2,8,5; 1,4,2,7,4,
                4,2,7,4; 1,4,2,7,4,4,2,7,4; 1,6,2,3,5,5,2,3,6; 1,5,2,8,6,6,2,8,5; 1,
                4,2,7,4,4,2,7,4]);
                   // Function selection by [reset, set] reading;
           annotation (
            Documentation(info="<html>
<p>Description in VHDL is given by http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</p>
<p><strong>Truth Table</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Enable</strong></td>
      <td><strong>Reset</strong></td>
      <td><strong>Set</strong></td>
      <td><strong>DataOut</strong></td>
  </tr>

  <tr><td>*</td> <td>*</td> <td>*</td>  <td>U</td> <td>U</td> </tr>
  <tr><td>*</td> <td>*</td> <td>U</td>  <td>~0</td> <td>U</td> </tr>
  <tr><td>*</td> <td>*</td> <td>*</td>  <td>0</td> <td>1</td> </tr>
  <tr><td>*</td> <td>*</td> <td>0</td>  <td>1</td> <td>0</td> </tr>
  <tr><td>*</td> <td>*</td> <td>0</td>  <td>X</td> <td>X</td> </tr>
  <tr><td>*</td> <td>U</td> <td>~0</td> <td>~0</td> <td>U</td> </tr>
  <tr><td>*</td> <td>~U</td> <td>X</td> <td>X</td> <td>X or U</td> </tr>
  <tr><td>*</td> <td>~U</td> <td>1</td> <td>X</td> <td>X or U or 1 or NC</td> </tr>
  <tr><td>*</td> <td>~U</td> <td>X</td> <td>1</td> <td>X or U or 0 or NC</td> </tr>
  <tr><td>*</td> <td>X</td> <td>1</td>  <td>1</td> <td>X or U or NC</td> </tr>
  <tr><td>*</td> <td>1</td> <td>1</td>  <td>1</td> <td>DataIn</td> </tr>
  <tr><td>*</td> <td>0</td> <td>1</td>  <td>1</td> <td>NC</td> </tr>
</table>

<blockquote><pre>
*  = do not care
~  = not equal
U  = L.'U'
0  = L.'0' or L.'L'
1  = L.'1' or L.'H'
X  = L.'X' or L.'W' or L.'Z' or L.'-'
NC = no change
</pre></blockquote>
</html>", revisions="<html>
<ul>
<li><em>September 11, 2009</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>"), Icon(graphics={Rectangle(
              extent={{-40,30},{40,16}},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-30,30},{30,16}},
              textColor={127,0,127},
              textString="low active")}));
        end DLATREGSRL;

        annotation (Documentation(info=
                                   "<html>
<p>Registers is a collection of flipflops and latches. In the opposite to the Examples.Utilities models the Register models are a series of assignments in the algorithm part of the model. The model text is taken nearly identical from the standard logic text.</p>
</html>"));
      end Registers;

  package Tristates "Transfergates, Buffers, Inverters, and WiredX"
      extends Modelica.Icons.Package;
    import D = Modelica.Electrical.Digital;
    import L = Modelica.Electrical.Digital.Interfaces.Logic;
    import T = Modelica.Electrical.Digital.Tables;
    import S = Modelica.Electrical.Digital.Interfaces.Strength;

    model NXFERGATE "Transfergate with enable active high"
      parameter SI.Time tHL=0 "High->Low delay";
      parameter SI.Time tLH=0 "Low->High delay";
      D.Interfaces.DigitalInput enable
        annotation (Placement(transformation(extent={{-100,60},{-80,80}}),
            iconTransformation(extent={{-100,60},{-80,80}})));
      D.Interfaces.DigitalInput x
        annotation (Placement(transformation(extent={{-100,-20},{-80,0}}),
            iconTransformation(extent={{-100,-20},{-80,0}})));
      D.Interfaces.DigitalOutput y
        annotation (Placement(transformation(extent={{80,-20},{100,0}}),
            iconTransformation(extent={{80,-20},{100,0}})));
    protected
              D.Interfaces.Logic nextstate(start=L.'U');
              D.Interfaces.DigitalOutput yy(start=L.'U');
              D.Delay.InertialDelaySensitive inertialDelaySensitive(tLH=tLH, tHL=tHL,y(start=L.'U', fixed=true));
    algorithm
      nextstate := T.NXferTable[enable, x];
      yy := nextstate;
    equation
      connect(yy, inertialDelaySensitive.x);
      connect(inertialDelaySensitive.y, y);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Rectangle(
              extent={{-60,60},{60,-20}},
              lineColor={127,0,127},
              fillPattern=FillPattern.Solid,
              fillColor={213,170,255},
              lineThickness=0.5),
            Line(
              points={{-33,16},{31,16}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{-80,-10},{-32,-10},{-32,10},{30,10},{30,-10},{80,-10}},
              color={127,0,127},
              thickness=1),
            Text(
              extent={{-7,46},{39,18}},
              textColor={127,0,127},
              textString="N"),
            Line(
              points={{-82,70},{0,70},{0,16}},
              color={127,0,127},
              thickness=1),
            Text(
              extent={{-44,-24},{30,-46}},
              textColor={0,0,255},
              textString="%name")}),
        Documentation(revisions="<html>
<ul>
<li><em>January 15, 2010</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>", info="<html>
<p>Description in VHDL is given by http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</p>
<p><strong>Truth Table</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Enable</strong></td>
      <td><strong>DataOut</strong></td>
  </tr>

  <tr><td>*</td> <td>U</td> <td>U</td></tr>
  <tr><td>*</td> <td>X</td> <td>UX</td></tr>
  <tr><td>*</td> <td>0</td> <td>Z</td></tr>
  <tr><td>*</td> <td>1</td> <td>DataIn</td></tr>
  <tr><td>*</td> <td>Z</td> <td>UX</td></tr>
  <tr><td>*</td> <td>W</td> <td>UX</td></tr>
  <tr><td>*</td> <td>L</td> <td>Z</td></tr>
  <tr><td>*</td> <td>H</td> <td>DataIn</td></tr>
  <tr><td>*</td> <td>-</td> <td>UX</td></tr>
</table>

<blockquote><pre>
UX: if dataIn == U then U else X
</pre></blockquote>
</html>"));
    end NXFERGATE;

    model NRXFERGATE
      "Transfergate with enable active high. Output strength reduced."
      parameter SI.Time tHL=0 "High->Low delay";
      parameter SI.Time tLH=0 "Low->High delay";
      D.Interfaces.DigitalInput enable
        annotation (Placement(transformation(extent={{-100,60},{-80,80}}),
            iconTransformation(extent={{-100,60},{-80,80}})));
      D.Interfaces.DigitalInput x
        annotation (Placement(transformation(extent={{-100,-20},{-80,0}}),
            iconTransformation(extent={{-100,-20},{-80,0}})));
      D.Interfaces.DigitalOutput y
        annotation (Placement(transformation(extent={{80,-20},{100,0}}),
            iconTransformation(extent={{80,-20},{100,0}})));
    protected
              D.Interfaces.Logic nextstate(start=L.'U');
              D.Interfaces.DigitalOutput yy(start=L.'U');
              D.Delay.InertialDelaySensitive inertialDelaySensitive(tLH=tLH, tHL=tHL, y(start=L.'U', fixed=true));
    algorithm
      nextstate := T.NRXferTable[enable, x];
      yy := nextstate;
    equation
      connect(yy, inertialDelaySensitive.x);
      connect(inertialDelaySensitive.y, y);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Rectangle(
              extent={{-60,60},{60,-20}},
              lineColor={127,0,127},
              fillPattern=FillPattern.Solid,
              fillColor={213,170,255},
              lineThickness=0.5),
            Line(
              points={{-33,16},{31,16}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{-80,-10},{-32,-10},{-32,10},{30,10},{30,-10},{80,-10}},
              color={127,0,127},
              thickness=1),
            Text(
              extent={{-2,46},{44,18}},
              textColor={127,0,127},
              textString="NR"),
            Line(
              points={{-82,70},{0,70},{0,16}},
              color={127,0,127},
              thickness=1),
            Text(
              extent={{-36,-24},{38,-46}},
              textColor={0,0,255},
              textString="%name")}),
        Documentation(revisions="<html>
<ul>
<li><em>January 15, 2010</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>", info="<html>
<p>Description in VHDL is given by http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</p>
<p><strong>Truth Table</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Enable</strong></td>
      <td><strong>DataOut</strong></td>
  </tr>

  <tr><td>*</td> <td>U</td> <td>U</td></tr>
  <tr><td>*</td> <td>X</td> <td>UW</td></tr>
  <tr><td>*</td> <td>0</td> <td>Z</td></tr>
  <tr><td>*</td> <td>1</td> <td>DataIn, Strength Reduced</td></tr>
  <tr><td>*</td> <td>Z</td> <td>UW</td></tr>
  <tr><td>*</td> <td>W</td> <td>UW</td></tr>
  <tr><td>*</td> <td>L</td> <td>Z</td></tr>
  <tr><td>*</td> <td>H</td> <td>DataIn, Strength Reduced</td></tr>
  <tr><td>*</td> <td>-</td> <td>UW</td></tr>
</table>

<blockquote><pre>
UW: if dataIn == U then U else W
Strength Reduced: 0 -> L, 1 -> H, X -> W
</pre></blockquote>
</html>"));
    end NRXFERGATE;

    model PXFERGATE "Transfergate with enable active low"
      parameter SI.Time tHL=0 "High->Low delay";
      parameter SI.Time tLH=0 "Low->High delay";
      D.Interfaces.DigitalInput enable
        annotation (Placement(transformation(extent={{-100,60},{-80,80}}),
            iconTransformation(extent={{-100,60},{-80,80}})));
      D.Interfaces.DigitalInput x
        annotation (Placement(transformation(extent={{-100,-20},{-80,0}}),
            iconTransformation(extent={{-100,-20},{-80,0}})));
      D.Interfaces.DigitalOutput y
        annotation (Placement(transformation(extent={{80,-20},{100,0}}),
            iconTransformation(extent={{80,-20},{100,0}})));
    protected
              D.Interfaces.Logic nextstate(start=L.'U');
              D.Interfaces.DigitalOutput yy(start=L.'U');
              D.Delay.InertialDelaySensitive inertialDelaySensitive(tLH=tLH, tHL=tHL);
    algorithm
      nextstate := T.PXferTable[enable, x];
      yy := nextstate;
    equation
      connect(yy, inertialDelaySensitive.x);
      connect(inertialDelaySensitive.y, y);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Rectangle(
              extent={{-60,60},{60,-20}},
              lineColor={127,0,127},
              fillPattern=FillPattern.Solid,
              fillColor={213,170,255},
              lineThickness=0.5),
            Line(
              points={{-33,16},{31,16}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{-80,-10},{-32,-10},{-32,10},{30,10},{30,-10},{80,-10}},
              color={127,0,127},
              thickness=1),
            Text(
              extent={{-7,46},{39,18}},
              textColor={127,0,127},
              textString="P"),
            Line(
              points={{-82,70},{0,70},{0,16}},
              color={127,0,127},
              thickness=1),
            Text(
              extent={{-36,-24},{38,-46}},
              textColor={0,0,255},
              textString="%name")}),
        Documentation(revisions="<html>
<ul>
<li><em>January 15, 2010</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>", info="<html>
<p>Description in VHDL is given by http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</p>
<p><strong>Truth Table</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Enable</strong></td>
      <td><strong>DataOut</strong></td>
  </tr>

  <tr><td>*</td> <td>U</td> <td>U</td></tr>
  <tr><td>*</td> <td>X</td> <td>UX</td></tr>
  <tr><td>*</td> <td>0</td> <td>DataIn</td></tr>
  <tr><td>*</td> <td>1</td> <td>Z</td></tr>
  <tr><td>*</td> <td>Z</td> <td>UX</td></tr>
  <tr><td>*</td> <td>W</td> <td>UX</td></tr>
  <tr><td>*</td> <td>L</td> <td>DataIn</td></tr>
  <tr><td>*</td> <td>H</td> <td>Z</td></tr>
  <tr><td>*</td> <td>-</td> <td>UX</td></tr>
</table>

<blockquote><pre>
UX: if dataIn == U then U else X
</pre></blockquote>
</html>"));
    end PXFERGATE;

    model PRXFERGATE
      "Transfergate with enable active low. Output strength reduced."
      parameter SI.Time tHL=0 "High->Low delay";
      parameter SI.Time tLH=0 "Low->High delay";
      D.Interfaces.DigitalInput enable
        annotation (Placement(transformation(extent={{-100,60},{-80,80}}),
            iconTransformation(extent={{-100,60},{-80,80}})));
      D.Interfaces.DigitalInput x
        annotation (Placement(transformation(extent={{-100,-20},{-80,0}}),
            iconTransformation(extent={{-100,-20},{-80,0}})));
      D.Interfaces.DigitalOutput y
        annotation (Placement(transformation(extent={{80,-20},{100,0}}),
            iconTransformation(extent={{80,-20},{100,0}})));
    protected
              D.Interfaces.Logic nextstate(start=L.'U');
              D.Interfaces.DigitalOutput yy(start=L.'U');
              D.Delay.InertialDelaySensitive inertialDelaySensitive(tLH=tLH, tHL=tHL);
    algorithm
      nextstate := T.PRXferTable[enable, x];
      yy := nextstate;
    equation
      connect(yy, inertialDelaySensitive.x);
      connect(inertialDelaySensitive.y, y);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Rectangle(
              extent={{-60,60},{60,-20}},
              lineColor={127,0,127},
              fillPattern=FillPattern.Solid,
              fillColor={213,170,255},
              lineThickness=0.5),
            Line(
              points={{-33,16},{31,16}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{-80,-10},{-32,-10},{-32,10},{30,10},{30,-10},{80,-10}},
              color={127,0,127},
              thickness=1),
            Text(
              extent={{-2,46},{44,18}},
              textColor={127,0,127},
              textString="PR"),
            Line(
              points={{-82,70},{0,70},{0,16}},
              color={127,0,127},
              thickness=1),
            Text(
              extent={{-40,-24},{34,-46}},
              textColor={0,0,255},
              textString="%name")}),
        Documentation(revisions="<html>
<ul>
<li><em>January 15, 2010</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>", info="<html>
<p>Description in VHDL is given by http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</p>
<p><strong>Truth Table</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Enable</strong></td>
      <td><strong>DataOut</strong></td>
  </tr>

  <tr><td>*</td> <td>U</td> <td>U</td></tr>
  <tr><td>*</td> <td>X</td> <td>UW</td></tr>
  <tr><td>*</td> <td>0</td> <td>DataIn, Strength Reduced</td></tr>
  <tr><td>*</td> <td>1</td> <td>Z</td></tr>
  <tr><td>*</td> <td>Z</td> <td>UW</td></tr>
  <tr><td>*</td> <td>W</td> <td>UW</td></tr>
  <tr><td>*</td> <td>L</td> <td>DataIn, Strength Reduced</td></tr>
  <tr><td>*</td> <td>H</td> <td>Z</td></tr>
  <tr><td>*</td> <td>-</td> <td>UW</td></tr>
</table>
<p>
  UW: if dataIn == U then U else W
  Strength Reduced: 0 -> L, 1 -> H, X -> W
</p>
</html>"));
    end PRXFERGATE;

    model BUF3S "Tristate buffer with enable active high"
      parameter SI.Time tHL=0 "High->Low delay";
      parameter SI.Time tLH=0 "Low->High delay";
      parameter D.Interfaces.Strength strength = S.'S_X01' "Output strength";
      D.Interfaces.DigitalInput enable
        annotation (Placement(transformation(extent={{-100,60},{-80,80}}),
            iconTransformation(extent={{-100,60},{-80,80}})));
      D.Interfaces.DigitalInput x
        annotation (Placement(transformation(extent={{-100,-20},{-80,0}}),
            iconTransformation(extent={{-100,-20},{-80,0}})));
      D.Interfaces.DigitalOutput y
        annotation (Placement(transformation(extent={{80,-20},{100,0}}),
            iconTransformation(extent={{80,-20},{100,0}})));
    protected
              D.Interfaces.Logic nextstate(start=L.'U');
              D.Interfaces.DigitalOutput yy(start=L.'U');
              D.Delay.InertialDelaySensitive inertialDelaySensitive(tLH=tLH, tHL=tHL, y(start=L.'U', fixed=true));
    algorithm
      nextstate := T.Buf3sTable[strength, T.UX01Conv[enable], T.UX01Conv[x]];
      yy := nextstate;
    equation
      connect(yy, inertialDelaySensitive.x);
      connect(inertialDelaySensitive.y, y);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Line(
              points={{-80,70},{0,70},{0,14}},
              color={127,0,127},
              thickness=1),
            Polygon(
              points={{-40,40},{-40,-60},{40,-10},{-40,40}},
              lineColor={127,0,127},
              fillColor={213,170,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-80,-10},{-40,-10}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{40,-10},{82,-10}},
              color={127,0,127},
              thickness=1),
            Text(
              extent={{-54,-62},{20,-84}},
              textColor={0,0,255},
              textString="%name")}),
        Documentation(revisions="<html>
<ul>
<li><em>January 22, 2010</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>", info="<html>
<p>Description in VHDL is given by http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</p>
<p>and for tristate table http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_misc.vhd</p>
<p><strong>Truth Table</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Enable</strong></td>
      <td><strong>DataOut*</strong></td>
  </tr>

  <tr><td>*</td> <td>U</td> <td>U</td></tr>
  <tr><td>*</td> <td>X</td> <td>UX</td></tr>
  <tr><td>*</td> <td>0</td> <td>Z</td></tr>
  <tr><td>*</td> <td>1</td> <td>DataIn</td></tr>
  <tr><td>*</td> <td>Z</td> <td>UX</td></tr>
  <tr><td>*</td> <td>W</td> <td>UX</td></tr>
  <tr><td>*</td> <td>L</td> <td>Z</td></tr>
  <tr><td>*</td> <td>H</td> <td>DataIn</td></tr>
  <tr><td>*</td> <td>-</td> <td>UX</td></tr>
</table>

<blockquote><pre>
UX: if dataIn == U then U else X
DataOut*: Strength map for DataOut according to tristate table Buf3sTable
</pre></blockquote>
</html>"));
    end BUF3S;

    model BUF3SL "Tristate buffer with enable active low"
      parameter SI.Time tHL=0 "High->Low delay";
      parameter SI.Time tLH=0 "Low->High delay";
      parameter D.Interfaces.Strength strength = S.'S_X01' "Output strength";
      D.Interfaces.DigitalInput enable
        annotation (Placement(transformation(extent={{-100,60},{-80,80}}),
            iconTransformation(extent={{-100,60},{-80,80}})));
      D.Interfaces.DigitalInput x
        annotation (Placement(transformation(extent={{-100,-20},{-80,0}}),
            iconTransformation(extent={{-100,-20},{-80,0}})));
      D.Interfaces.DigitalOutput y
        annotation (Placement(transformation(extent={{80,-20},{100,0}}),
            iconTransformation(extent={{80,-20},{100,0}})));
    protected
              D.Interfaces.Logic nextstate(start=L.'U');
              D.Interfaces.DigitalOutput yy(start=L.'U');
              D.Delay.InertialDelaySensitive inertialDelaySensitive(tLH=tLH, tHL=tHL);
    algorithm
      nextstate := T.Buf3slTable[strength, T.UX01Conv[enable], T.UX01Conv[x]];
      yy := nextstate;
    equation
      connect(yy, inertialDelaySensitive.x);
      connect(inertialDelaySensitive.y, y);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Line(
              points={{-80,70},{0,70},{0,14}},
              color={127,0,127},
              thickness=1),
            Polygon(
              points={{-40,40},{-40,-60},{40,-10},{-40,40}},
              lineColor={127,0,127},
              fillColor={213,170,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-80,-10},{-40,-10}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{40,-10},{82,-10}},
              color={127,0,127},
              thickness=1),
            Text(
              extent={{-54,-62},{20,-84}},
              textColor={0,0,255},
              textString="%name")}),
        Documentation(revisions="<html>
<ul>
<li><em>January 22, 2010</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>", info="<html>
<p>Description in VHDL is given by http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</p>
<p>and for tristate table http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_misc.vhd</p>
<p><strong>Truth Table</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Enable</strong></td>
      <td><strong>DataOut*</strong></td>
  </tr>

  <tr><td>*</td> <td>U</td> <td>U</td></tr>
  <tr><td>*</td> <td>X</td> <td>UX</td></tr>
  <tr><td>*</td> <td>0</td> <td>DataIn</td></tr>
  <tr><td>*</td> <td>1</td> <td>Z</td></tr>
  <tr><td>*</td> <td>Z</td> <td>UX</td></tr>
  <tr><td>*</td> <td>W</td> <td>UX</td></tr>
  <tr><td>*</td> <td>L</td> <td>DataIn</td></tr>
  <tr><td>*</td> <td>H</td> <td>Z</td></tr>
  <tr><td>*</td> <td>-</td> <td>UX</td></tr>
</table>

<blockquote><pre>
UX: if dataIn == U then U else X
DataOut*: Strength map for DataOut according to tristate table Buf3slTable
</pre></blockquote>
</html>"));
    end BUF3SL;

    model INV3S "Tristate Inverter with enable active high"
      parameter SI.Time tHL=0 "High->Low delay";
      parameter SI.Time tLH=0 "Low->High delay";
      parameter D.Interfaces.Strength strength = S.'S_X01' "Output strength";
      D.Interfaces.DigitalInput enable
        annotation (Placement(transformation(extent={{-100,60},{-80,80}}),
            iconTransformation(extent={{-100,60},{-80,80}})));
      D.Interfaces.DigitalInput x
        annotation (Placement(transformation(extent={{-100,-20},{-80,0}}),
            iconTransformation(extent={{-100,-20},{-80,0}})));
      D.Interfaces.DigitalOutput y
        annotation (Placement(transformation(extent={{80,-20},{100,0}}),
            iconTransformation(extent={{80,-20},{100,0}})));
    protected
              D.Interfaces.Logic nextstate(start=L.'U');
              D.Interfaces.DigitalOutput yy(start=L.'U');
              D.Delay.InertialDelaySensitive inertialDelaySensitive(tLH=tLH, tHL=tHL, y(start=L.'U',fixed=true));
    algorithm
      nextstate := T.Buf3sTable[strength, T.UX01Conv[enable], T.UX01Conv[T.NotTable[x]]];
      yy := nextstate;
    equation
      connect(yy, inertialDelaySensitive.x);
      connect(inertialDelaySensitive.y, y);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Line(
              points={{-80,70},{0,70},{0,14}},
              color={127,0,127},
              thickness=1),
            Polygon(
              points={{-40,40},{-40,-60},{40,-10},{-40,40}},
              lineColor={127,0,127},
              fillColor={213,170,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-80,-10},{-40,-10}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{40,-10},{82,-10}},
              color={127,0,127},
              thickness=1),
            Ellipse(
              extent={{40,-3},{54,-17}},
              lineColor={127,0,127},
              fillColor={213,170,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-54,-62},{20,-84}},
              textColor={0,0,255},
              textString="%name")}),
        Documentation(revisions="<html>
<ul>
<li><em>January 22, 2010</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>", info="<html>
<p>Description in VHDL is given by http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</p>
<p>and for tristate table http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_misc.vhd</p>
<p><strong>Truth Table</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Enable</strong></td>
      <td><strong>DataOut*</strong></td>
  </tr>

  <tr><td>*</td> <td>U</td> <td>U</td></tr>
  <tr><td>*</td> <td>X</td> <td>UX</td></tr>
  <tr><td>*</td> <td>0</td> <td>Z</td></tr>
  <tr><td>*</td> <td>1</td> <td>Not DataIn</td></tr>
  <tr><td>*</td> <td>Z</td> <td>UX</td></tr>
  <tr><td>*</td> <td>W</td> <td>UX</td></tr>
  <tr><td>*</td> <td>L</td> <td>Z</td></tr>
  <tr><td>*</td> <td>H</td> <td>Not DataIn</td></tr>
  <tr><td>*</td> <td>-</td> <td>UX</td></tr>
</table>

<blockquote><pre>
UX: if dataIn == U then U else X
DataOut*: Strength map for DataOut according to tristate table Buf3sTable
</pre></blockquote>
</html>"));
    end INV3S;

    model INV3SL "Tristate inverter with enable active low"
      parameter SI.Time tHL=0 "High->Low delay";
      parameter SI.Time tLH=0 "Low->High delay";
      parameter D.Interfaces.Strength strength = S.'S_X01' "Output strength";
      D.Interfaces.DigitalInput enable
        annotation (Placement(transformation(extent={{-100,60},{-80,80}}),
            iconTransformation(extent={{-100,60},{-80,80}})));
      D.Interfaces.DigitalInput x
        annotation (Placement(transformation(extent={{-100,-20},{-80,0}}),
            iconTransformation(extent={{-100,-20},{-80,0}})));
      D.Interfaces.DigitalOutput y
        annotation (Placement(transformation(extent={{80,-20},{100,0}}),
            iconTransformation(extent={{80,-20},{100,0}})));
    protected
              D.Interfaces.Logic nextstate(start=L.'U');
              D.Interfaces.DigitalOutput yy(start=L.'U');
              D.Delay.InertialDelaySensitive inertialDelaySensitive(tLH=tLH, tHL=tHL);
    algorithm
      nextstate := T.Buf3sTable[strength, T.UX01Conv[T.NotTable[enable]], T.UX01Conv[T.NotTable[x]]];
      yy := nextstate;
    equation
      connect(yy, inertialDelaySensitive.x);
      connect(inertialDelaySensitive.y, y);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Polygon(
              points={{-40,40},{-40,-60},{40,-10},{-40,40}},
              lineColor={127,0,127},
              fillColor={213,170,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-80,70},{0,70},{0,14}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{-80,-10},{-40,-10}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{40,-10},{82,-10}},
              color={127,0,127},
              thickness=1),
            Ellipse(
              extent={{40,-3},{54,-17}},
              lineColor={127,0,127},
              fillColor={213,170,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-54,-62},{20,-84}},
              textColor={0,0,255},
              textString="%name")}),
        Documentation(revisions="<html>
<ul>
<li><em>January 22, 2010</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>", info="<html>
<p>Description in VHDL is given by http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</p>
<p>and for tristate table http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_misc.vhd</p>
<p><strong>Truth Table</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>DataIn</strong></td>
      <td><strong>Enable</strong></td>
      <td><strong>DataOut*</strong></td>
  </tr>

  <tr><td>*</td> <td>U</td> <td>U</td></tr>
  <tr><td>*</td> <td>X</td> <td>UX</td></tr>
  <tr><td>*</td> <td>0</td> <td>Not DataIn</td></tr>
  <tr><td>*</td> <td>1</td> <td>Z</td></tr>
  <tr><td>*</td> <td>Z</td> <td>UX</td></tr>
  <tr><td>*</td> <td>W</td> <td>UX</td></tr>
  <tr><td>*</td> <td>L</td> <td>Not DataIn</td></tr>
  <tr><td>*</td> <td>H</td> <td>Z</td></tr>
  <tr><td>*</td> <td>-</td> <td>UX</td></tr>
</table>

<blockquote><pre>
UX: if dataIn == U then U else X
DataOut*: Strength map for DataOut according to tristate table Buf3slTable
</pre></blockquote>
</html>"));
    end INV3SL;

    model WiredX "Wired node with multiple input and one output"
      extends D.Interfaces.MISO;
    protected
      D.Interfaces.Logic auxiliary[n](each start=L.'Z', each fixed=true);
    equation
      auxiliary[1] = x[1];
      for i in 1:n - 1 loop
        auxiliary[i + 1] = D.Tables.ResolutionTable[auxiliary[i], x[i + 1]];
      end for;
      y = pre(auxiliary[n]);
      annotation (
        Documentation(info="<html>
<p>
Wires n input signals in one output signal, without delay.
</p>
<p>Resolution table is given by http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_misc.vhd</p>
</html>", revisions="<html>
<ul>
<li><em>January 22, 2010</em> created by Ulrich Donath<br>
       </li>
</ul>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Text(
              extent={{-50,40},{50,80}},
              textString="Wire"), Text(
              extent={{152,-160},{-148,-100}},
              textColor={0,0,255},
              textString="%name")}));
    end WiredX;
  end Tristates;

  package Memories
    extends Modelica.Icons.Package;

    model DLATRAM "Level sensitive Random Access Memory"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      import T = Modelica.Electrical.Digital.Tables;
      extends Interfaces.MemoryBase;

      Interfaces.DigitalInput WE "Write enable" annotation (Placement(transformation(
        extent={{-100,-60},{-84,-44}}), iconTransformation(extent={{-100,-60},{-84,-44}})));
      Interfaces.DigitalInput dataIn[n_data] "Data input" annotation (Placement(transformation(
        extent={{-100,10},{-80,30}}), iconTransformation(extent={{-100,10},{-80,30}})));
      L mem[integer(2^n_addr),n_data](start=fill(L.'U',integer(2^n_addr),n_data)) "Memory with data, lowest bit on left side";

    algorithm
      if initial() then
        mem := getMemory(fileName, n_addr, n_data);
      end if;

      /* write into memory */
      if WE == L.'1' or WE == L.'H' then
        // write data
        int_addr := address(n_addr, addr);
        //assert(int_addr > 0, "Attempted write to bad RAM address");
        if int_addr > 0 then
          for i in 1:n_data loop
            mem_word[i] := T.X01Table[dataIn[i]];
          end for;
          mem[int_addr,1:n_data] := mem_word;
        end if;
      elseif WE == L.'X' or WE == L.'W' or WE == L.'Z' or WE == L.'U' or WE == L.'-' then
        // write X
        int_addr := address(n_addr, addr);
        //assert(int_addr > 0, "Attempted write to bad RAM address");
        if int_addr > 0 then
          mem_word :=fill(L.'X',n_data);
          mem[int_addr,1:n_data] := mem_word;
        end if;
      end if;

      /* read from memory */
      if RE == L.'0' or RE == L.'L' then
        nextstate := fill(L.'Z',n_data);
      elseif RE == L.'1' or RE == L.'H' then
        int_addr := address(n_addr, addr);
        // read data
        if int_addr > 0 then
          mem_word := mem[int_addr,1:n_data];
          for i in 1:n_data loop
            nextstate[i] := T.StrengthMap[mem_word[i], strength];
          end for;
        else
          nextstate := fill(T.StrengthMap[L.'X', strength],n_data);
        end if;
      else
        nextstate := fill(T.StrengthMap[L.'X', strength],n_data);
      end if;
      yy := nextstate;

    annotation(Documentation(info="<html>
<p>
Description in VHDL is given by <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a>
</p>
<p><strong>Truth Table for high active read enable RE:</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>RE</strong></td>
      <td><strong>Addr</strong></td>
      <td><strong>DataOut</strong></td>
  </tr>
  <tr><td>0</td>  <td>*</td>              <td>Z over all</td>  </tr>
  <tr><td>1</td>  <td>  no X in Addr</td> <td>DataOut=m(Addr)</td>     </tr>
  <tr><td>1</td>  <td>X in Addr</td>      <td>X over all</td>  </tr>
  <tr><td>X</td>  <td>*</td>              <td>X over all</td>  </tr>
</table>
<p><strong>Truth Table for high active write enable WE:</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>WE</strong></td>
      <td><strong>Addr</strong></td>
      <td><strong>Memory</strong></td>
  </tr>
  <tr><td>0</td>  <td>*</td>              <td>no write</td>           </tr>
  <tr><td>1</td>  <td>no X in Addr</td>   <td>m(Addr)=DataIn</td>     </tr>
  <tr><td>1</td>  <td>X in Addr</td>      <td>no write</td>  </tr>
  <tr><td>X</td>  <td>no X in Addr</td>   <td>m(Addr)=X over all</td> </tr>
  <tr><td>X</td>  <td>X in Addr</td>      <td>no write</td>  </tr>
</table>

<blockquote><pre>
*  = do not care
0  = L.'0' or L.'L'
1  = L.'1' or L.'H'
X  = L.'X' or L.'W' or L.'Z' or L.'-' or L.'U'
Z  = L.'Z'
</pre></blockquote>

<p><strong>Simultaneous read/write operations are allowed.
Firstly Write is carried out, then Read.</strong></p>
</html>", revisions="<html>
<dl>
<dt><em>November 9, 2010</em></dt>
<dd>created by Ulrich Donath</dd>
</dl>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={
          Text(
            extent={{-50,70},{50,30}},
            textColor={127,33,107},
            textString="DLATRAM"),
          Line(
            points={{-60,-40},{-46,-50},{-60,-60}},
            color={127,0,127}),
          Text(
            extent={{-41,-35},{-24,-62}},
            textColor={127,33,107},
            textString="WE"),
          Line(
            points={{-84,-50},{-60,-50}},
            color={127,0,127}),
          Line(
            points={{-80,20},{-60,20}},
            color={127,0,127},
            thickness=1)}));
    end DLATRAM;

    model DLATROM "Level sensitive Read Only Memory"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      import T = Modelica.Electrical.Digital.Tables;
      extends Interfaces.MemoryBase;

    protected
      L m[integer(2^n_addr),n_data](start=fill(L.'U',integer(2^n_addr),n_data)) "Memory with data, lowest bit on left side";

    algorithm
      if initial() then
        m := getMemory(fileName, n_addr, n_data);
      end if;

      if RE == L.'0' or RE == L.'L' then
        nextstate := fill(L.'Z',n_data);
      elseif RE == L.'1' or RE == L.'H' then
        int_addr := address(n_addr, addr);
        // read data
        if int_addr > 0 then
           mem_word := m[int_addr,1:n_data];
           for i in 1:n_data loop
              nextstate[i] := T.StrengthMap[mem_word[i], strength];
           end for;
        else
           nextstate := fill(T.StrengthMap[L.'X', strength],n_data);
        end if;
      else
        nextstate := fill(T.StrengthMap[L.'X', strength],n_data);
      end if;
      yy := nextstate;

    annotation(Documentation(info="<html>
<p>
Description in VHDL is given by <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a>
</p>
<p><strong>Truth Table for high active read enable RE:</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>RE</strong></td>
      <td><strong>Addr</strong></td>
      <td><strong>DataOut</strong></td>
  </tr>
  <tr><td>0</td> <td>*</td> <td>Z over all</td>  </tr>
  <tr><td>1</td> <td>  no X in Addr</td> <td>DataOut=m(Addr)</td>  </tr>
  <tr><td>1</td> <td>X in Addr</td> <td>X over all</td> </tr>
  <tr><td>X</td> <td>*</td> <td>X over all</td> </tr>
</table>

<blockquote><pre>
*  = do not care
0  = L.'0' or L.'L'
1  = L.'1' or L.'H'
X  = L.'X' or L.'W' or L.'Z' or L.'-' or L.'U'
Z  = L.'Z'
</pre></blockquote>

</html>", revisions="<html>
<dl>
<dt><em>October 19, 2010</em></dt>
<dd>created by Ulrich Donath</dd>
</dl>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={
          Text(
            extent={{-50,70},{50,30}},
            textColor={127,33,107},
            textString="DLATROM")}));
    end DLATROM;
  end Memories;

  package Multiplexers
    extends Modelica.Icons.Package;
    model MUX2x1 "A two inputs MULTIPLEXER for multiple value logic (2 data inputs, 1 select input, 1 output)"

      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      import S = Modelica.Electrical.Digital.Interfaces.Strength;
      import T = Modelica.Electrical.Digital.Tables;
      parameter SI.Time tHL=0 "High->Low delay";
      parameter SI.Time tLH=0 "Low->High delay";
      parameter D.Interfaces.Strength strength = S.'S_X01' "Output strength";
      D.Interfaces.DigitalInput in1 "Data input 1"
        annotation (Placement(transformation(extent={{-100,40},{-80,60}}),
            iconTransformation(extent={{-100,40},{-80,60}})));
      D.Interfaces.DigitalInput in0 "Data input 0"
        annotation (Placement(transformation(extent={{-100,-60},{-80,-40}}),
            iconTransformation(extent={{-100,-60},{-80,-40}})));
      D.Interfaces.DigitalInput sel "Select input"
      annotation (Placement(transformation(extent={{-10,80},{10,100}}),
            iconTransformation(extent={{-10,80},{10,100}})));
      D.Interfaces.DigitalOutput out "Output"
        annotation (Placement(transformation(extent={{80,-10},{100,10}}),
            iconTransformation(extent={{80,-10},{100,10}})));

    protected
              D.Interfaces.Logic nextstate(start=L.'U');
              D.Interfaces.DigitalOutput yy(start=L.'U');
              D.Delay.InertialDelaySensitive inertialDelaySensitive(tLH=tLH, tHL=tHL, y(start=L.'U',fixed=true));

    algorithm
      nextstate := T.MUX2x1Table[T.UX01Conv[in1], T.UX01Conv[sel], T.UX01Conv[in0]];

      nextstate := T.StrengthMap[nextstate, strength];

      yy := nextstate;
    equation
      connect(yy, inertialDelaySensitive.x);
      connect(inertialDelaySensitive.y, out);

      annotation (Icon(graphics={
            Line(
              points={{-80,50},{-40,50}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{-62,-50},{-62,-50}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{-80,-50},{-40,-50}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{0,60},{0,80}},
              color={127,0,127},
              thickness=1),
            Line(
              points={{40,0},{80,0}},
              color={127,0,127},
              thickness=1),
            Polygon(
              points={{-40,80},{-40,-80},{40,-40},{40,40},{-40,80}},
              lineColor={213,170,255},
              lineThickness=1,
              fillColor={213,170,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-36,-70},{38,-92}},
              textColor={0,0,255},
              textString="%name"),
            Text(
              extent={{-38,10},{38,-10}},
              textColor={127,0,127},
              textString="MUX2x1")}),
        Documentation(info="<html>
<p>Description in VHDL is given by <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>
<p>and for Multiplexer table <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_misc.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_misc.vhd</a></p>
<h4>Truth Table</h4>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><h4>DataIn</h4></td>
<td><h4>Select</h4></td>
<td><h4>DataOut</h4></td>
</tr>
<tr>
<td><p>*</p></td>
<td><p>0</p></td>
<td><p>Input0</p></td>
</tr>
<tr>
<td><p>*</p></td>
<td><p>1</p></td>
<td><p>Input1</p></td>
</tr>
<tr>
<td><p>Inputs equal</p></td>
<td><p>U</p></td>
<td><p>Input</p></td>
</tr>
<tr>
<td><p>Inputs not equal</p></td>
<td><p>U</p></td>
<td><p>U</p></td>
</tr>
<tr>
<td><p>U in Input</p></td>
<td><p>X</p></td>
<td><p>U</p></td>
</tr>
<tr>
<td><p>Inputs equal</p></td>
<td><p>X</p></td>
<td><p>Input</p></td>
</tr>
<tr>
<td><p>no U in Input and Inputs not equal</p></td>
<td><p>X</p></td>
<td><p>X</p></td>
</tr>
</table>
<blockquote><pre>
*  = don&#39;t care
0  = L.&#39;0&#39; or L.&#39;L&#39;
1  = L.&#39;1&#39; or L.&#39;H&#39;
X  = L.&#39;X&#39; or L.&#39;W&#39; or L.&#39;Z&#39; or L.&#39;-&#39;
U  = L.&#39;U&#39;
</pre></blockquote>
</html>", revisions="<html>
<dl>
<dt><em>January 24, 2011</em></dt>
<dd>created by Christian G&uuml;nther</dd>
</dl>
</html>"));
    end MUX2x1;
  end Multiplexers;
      annotation (
        Documentation(info="<html>
<p>
This library contains packages for digital electrical components. Both, type system
and models are based on the VHDL standard (IEEE Std 1076-1987 VHDL, IEEE Std 1076-1993 VHDL,
IEEE Std 1164 Multivalue Logic System):
</p>

<ul>
<li>Interfaces: Definition of signals and interfaces</li>
<li>Tables: All truth tables needed</li>
<li>Delay: Transport and inertial delay</li>
<li>Basic: Basic logic without delay</li>
<li>Gates: Basic gates composed by basic components and inertial delay</li>
<li>Tristate: (not yet available)</li>
<li>FlipFlops: D-Flip-Flops</li>
<li>Latches: D-Latches</li>
<li>TransferGates: (not yet available)</li>
<li>Multiplexers (not yet available)</li>
<li>Memory: Ram, Rom, (not yet available)</li>
<li>Sources: Time-dependent signal sources</li>
<li>Converters</li>
<li>Examples</li>
</ul>

<p>
The logic values are coded by integer values. The following code table is necessary
for both setting of input and interpreting the output values.
</p>

<p><strong>Code Table:</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Logic value</strong></td>
      <td><strong>Integer code</strong></td>
      <td><strong>Meaning</strong></td>
  </tr>

  <tr><td>'U'</td> <td>1</td> <td>Uninitialized</td></tr>
  <tr><td>'X'</td> <td>2</td> <td>Forcing Unknown</td></tr>
  <tr><td>'0'</td> <td>3</td> <td>Forcing 0</td></tr>
  <tr><td>'1'</td> <td>4</td> <td>Forcing 1</td></tr>
  <tr><td>'Z'</td> <td>5</td> <td>High Impedance</td></tr>
  <tr><td>'W'</td> <td>6</td> <td>Weak Unknown</td></tr>
  <tr><td>'L'</td> <td>7</td> <td>Weak 0</td></tr>
  <tr><td>'H'</td> <td>8</td> <td>Weak 1</td></tr>
  <tr><td>'-'</td> <td>9</td> <td>Do not care</td></tr>
</table>

<p>
The library will be developed in two main steps. The first step contains the basic components and
the gates. In the next step the more complicated devices will be added. Currently the first step of
the library is implemented and released for public use.
</p>

<p>
Copyright &copy; 1998-2020, Modelica Association and contributors
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false,
                extent={{-100,-100},{100,100}}), graphics={
          Line(
            origin={7,47},
            points={{-84,-6},{-52,-6}}),
          Rectangle(
            origin={59,53},
            fillColor = {255,255,255},
            fillPattern = FillPattern.Solid,
            extent={{-104,-63},{-64,7}}),
          Rectangle(
            origin={146,34},
            fillColor = {255,255,255},
            fillPattern = FillPattern.Solid,
            extent={{-104,-63},{-64,7}}),
          Line(
            origin={7,15},
            points={{-84,-6},{-52,-6}}),
          Line(
            origin={79,30},
            points={{-84,-6},{-37,-6}}),
        Line(
          points={{42,-12},{17,-12},{17,-54},{-71,-54}})}));
end Digital;
