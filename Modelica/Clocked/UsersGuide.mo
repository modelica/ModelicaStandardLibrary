within Modelica.Clocked;
package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;
  package GettingStarted "Getting started"
    extends Modelica.Icons.Information;
    annotation (Documentation(info="<html>
<p>
In this section, a first introduction to the Modelica_Synchronous
library is given at hand of several examples.
<br>
(needs still to be provided).
</p>
</html>"));
  end GettingStarted;

  class Clocks "Clocks"
    extends Modelica.Icons.Information;
    annotation (Documentation(info="<html>
<p>
A central element of the Modelica_Synchronous library is a <b>clock</b>.
Below, the most important information for clocks is summarized.
For more details, see the Modelica Language Specification,
Chapter 16 (for Modelica Language Version &ge; 3.3).
</p>

<p>
A <b>Clock</b> type is a base data type (introduced in Modelica 3.3, additionally to Real, Integer, Boolean, String) that defines when a particular partition consisting of a set of equations is active. Starting with Modelica Language Version 3.3, every variable and every equation is either continuous-time or is associated exactly to one clock. This feature is visualized in the figure below where c(ti) is a clock that is active at particular time instants ti and r(ti) is a variable that is associated to this clock. A clocked variable has only a value when the corresponding clock is active:
</p>

<p>
<img src=\"modelica://Modelica_Synchronous/Resources/Images/Clocks/clockSignals.png\">
</p>

<p>
Similarly to RealInput, RealOutput etc., clock input and output connectors, called ClockInput and ClockOutput, are defined in sublibrary
<a href=\"modelica://Modelica_Synchronous.ClockSignals.Interfaces\">ClockSignal.Interfaces</a>
in order to propagate clocks via connections. A clock signal can be generated with
one of the blocks of sublibrary
<a href=\"modelica://Modelica_Synchronous.ClockSignals.Clocks\">ClockSignals.Clocks</a>:
</p>

<p>
<img src=\"modelica://Modelica_Synchronous/Resources/Images/Clocks/clocks.png\">
</p>

<p>
The output signals of the blocks in the above figure are clock signals,
by default visualized with dotted grey lines.
</p>

<p>
With the blocks of sublibrary
<a href=\"modelica://Modelica_Synchronous.ClockSignals.Sampler\">ClockSignals.Sampler</a>
a clock signal can be sub-sampled, super-sampled, or shift-sampled to generate
a new clock signal. For example, with the following model, a periodic clock signal of 0.1 s
is sub-sampled with a factor 3 and therefore a clock signal with a period of 0.3 s
is generated:
</p>

<p>
<img src=\"modelica://Modelica_Synchronous/Resources/Images/Clocks/subSampledClockExample.png\"><br>
<img src=\"modelica://Modelica_Synchronous/Resources/Images/Clocks/subSampledClockResult.png\">
</p>

<p>
As usual in synchronous languages, a clock is represented by a <b>true</b> value
when the clock is active. The relationship between such derived
clocks is <b>exact</b>, so it is guaranteed that at every 3rd tick of clock
\"periodicRealClock.y\", the clock \"subSample.y\" is active.
</p>

<p>
If a clock is associated to a clocked continuous-time partition, then an <b>integrator</b>
has to be defined that is used to integrate the partition from the previous
to the current clock tick. This is performed by setting parameter <b>useSolver</b>
= <b>true</b> and defining the integration method as String with
parameter <b>solver</b>. Both parameters are in tab <b>Advanced</b>
of one of the clock signal generating blocks.
The possible integration methods are tool dependent. It is expected that
at least the solvers \"External\" (= use the integrator selected in the
simulation environment) and \"ExplicitEuler\" (= explicit Euler method)
are supported by every tool. For an example, see
<a href=\"modelica://Modelica_Synchronous.Examples.Systems.ControlledMixingUnit\">Examples.Systems.ControlledMixingUnit</a>.
</p>

<p>
A clocked partition is a set of equations that depend
on each other and where the boundary variables are marked
with sample and hold operators.
If a clocked partition contains no operator <b>der</b>, <b>delay</b>,
<b>spatialDistribution</b>, no event related operators (with exception of <b>noEvent</b>(..)),
and no <b>when</b>-clause with a Boolean condition, it is a <b>clocked discrete-time</b>
partition, that is, it is a standard sampled data system that is described by difference equations.
If a clocked partition is <b>not</b> a <b>clocked discrete-time</b> partition and
it contains neither operator <b>previous</b> nor operator
<b>interval</b>, it is a
<b>clocked discretized continuous-time</b> partition.
Such a partition has to be solved with a <b>solver</b> method.
It is an error, if none of the two properties hold, e.g., if operators
<b>previous</b> and <b>der</b> are both used in the same partition.
In a clocked discrete-time partition all event generating mechanisms
do no longer apply. Especially neither relations, nor one of the built-in event
triggering operators will trigger an event.
</p>
</html>"));
  end Clocks;

  class Literature "Literature"
    extends Modelica.Icons.Information;
    annotation (Documentation(info="<html>
<p>
<i>This library is based on the following references:</i>
</p>

<dl>
<dt>Astr&ouml;m K.J., Wittenmark B. (1997):</dt>
<dd> <b>Computer Controlled Systems: Theory and Design</b>.
     Prentice Hall. 3rd edition.<br>&nbsp;</dd>

<dt>Elmqvist H., Otter M., and Mattsson S.E. (2012):</dt>
<dd><b>Fundamentals of Synchronous Control in Modelica.</b>
    Proceedings of 9th International Modelica Conference, Munich,
    Germany, Sep. 3-5.<br>&nbsp;</dd>

<dt>Otter M., Thiele B., and Elmqvist H. (2012):</dt>
<dd> <b>A Library for Synchronous Control Systems in Modelica.</b>
     Proceedings of 9th International Modelica Conference, Munich,
     Germany, September 3-5.<br>&nbsp;</dd>

<dt>Walther N. (2002):</dt>
<dd> <b>Praxisgerechte Modelica-Bibliothek f&uuml;r Abtastregler</b>.
     Diplomarbeit, HTWK Leipzig, Fachbereich Elektro- und
     Informationstechnik, supervised by Prof. M&uuml;ller (HTWK)
     and Prof. Martin Otter (DLR), 12 Nov. 2002.<br>&nbsp;</dd>
</dl>

<p>
<i>
The synchronous Modelica language elements allow for the first
time to utilize a continuous-time, nonlinear, inverse model in
a Modelica sampled-data system, by automatically discretizing
this model and providing it as a clocked partition. This allows
a convenient definition of certain nonlinear control systems,
see example
<a href=\"modelica://Modelica_Synchronous.Examples.Systems.ControlledMixingUnit\">Examples.Systems.ControlledMixingUnit</a>.
Several practical details to use nonlinear inverse plant models in
a control system are discussed in the following reference:</i>
</p>

<dl>
<dt>Looye G., Th&uuml;mmel M., Kurze M., Otter M., and Bals J. (2005):</dt>
<dd> <b>Nonlinear Inverse Models for Control</b>.
     Proceedings of 4th International Modelica Conference, ed. G. Schmitz,
     Hamburg, March 7-8.
     <a href=\"https://www.modelica.org/events/Conference2005/online_proceedings/Session3/Session3c3.pdf\">Download</a>.
     <br>&nbsp;</dd>
</dl>

<p>
<i>
The synchronous Modelica language elements used in this library
are based on the clock calculus and inference system proposed by (Colaco and
Pouzet 2003) and implemented in Lucid Synchrone version 2 and 3 (Pouzet 2006).
However, the Modelica approach also uses multi-rate periodic clocks based on
rational arithmetic introduced by (Forget et. al. 2008), as an extension of
the Lucid Synchrone semantics. These approaches belong to the class of
synchronous languages (Benveniste et. al. 2002):</i>
</p>

<dl>
<dt>Benveniste A., Caspi P., Edwards S.A., Halbwachs N., Le Guernic P., and Simone R. (2003):</dt>
<dd> <b>The Synchronous Languages Twelve Years Later</b>.
     Proceedings of the IEEE, Vol., 91, No. 1.
     <a href=\"http://www.irisa.fr/distribcom/benveniste/pub/synch_ProcIEEE_2002.pdf\">Download</a>.
     <br>&nbsp;</dd>

<dt>Colaco J.-L., and Pouzet M. (2003):</dt>
<dd><b>Clocks as First Class Abstract Types.</b>
    In Third International Conference on
    Embedded Software (EMSOFT'03), Philadelphia, Pennsylvania, USA, October 2003.
     <a href=\"http://www.di.ens.fr/~pouzet/lucid-synchrone/papers/emsoft03.ps.gz\">Download</a>.
    <br>&nbsp;</dd>

<dt>Forget J., F. Boniol, D. Lesens, C. Pagetti (2008):</dt>
<dd> <b>A Multi-Periodic Synchronous Data-Flow Language.</b>
     In 11th IEEE High Assurance Systems Engineering Symposium (HASE'08),
     Dec. 3-5 2008, Nanjing, China, pp. 251-260.
     <a href=\"http://ieeexplore.ieee.org/xpl/articleDetails.jsp?reload=true&arnumber=4708883&contentType=Conference+Publications\">Download</a>.
     <br>&nbsp;</dd>

<dt>Pouzet M. (2006):</dt>
<dd> <b>Lucid Synchrone, Version 3.0, Tutorial and Reference Manual</b>.
     <a href=\"http://www.di.ens.fr/~pouzet/lucid-synchrone/\">Download</a>.
    <br>&nbsp;</dd>
</dl>
</html>"));
  end Literature;

  package ReleaseNotes "Release notes"
    class Version_0_93_0 "Version 0.93.0 (April 10, 2019)"
      extends Modelica.Icons.Information;
      annotation (Documentation(info="<html>
<p>
Version 0.93.0 is backward compatible to version 0.92.1
</p>

<p>Enhancements:</p>
<ul>
<li>Uses latest version of Modelica Standard Library (v3.2.3) (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/37\">#37</a>).</li>
<li>New blocks for event clocks that generate a clock tick each time an observed input angle changed (subpackage <a href=\"modelica://Modelica_Synchronous.ClockSignals.Clocks.Rotational\">ClockSignals.Clocks.Rotational</a>) (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/34\">#34</a>, <a href=\"https://github.com/modelica/Modelica_Synchronous/issues/36\">#36</a>).</li>
<li>Improved engine-throttle control example using the new rotational event clocks  (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/34\">#32</a>, <a href=\"https://github.com/modelica/Modelica_Synchronous/issues/36\">#33</a>).</li>
<li>Utilizing `SolverMethod` from the (tool-specific) ModelicaServices library (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/20\">#20</a>).</li>
<li>Improved icons.</li>
</ul>
<p>Bug fixes:</p>
<ul>
<li>Added tolerance for numeric comparisons <a href=\"modelica://Modelica_Synchronous.BooleanSignals.TimeBasedSources.Pulse\">BooleanSignals.TimeBasedSources.Pulse</a> (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/9\">#9</a>).</li>
<li>Fixed overconstrained initial systems for several examples (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/10\">#10</a>, <a href=\"https://github.com/modelica/Modelica_Synchronous/issues/11\">#11</a>).</li>
<li>Fixed comparison against Real in <a href=\"modelica://Modelica_Synchronous.BooleanSignals.TickBasedSources.Pulse\">BooleanSignals.TickBasedSources.Pulse</a> (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/12\">#12</a>).</li>
<li>Fixed too slow sampling in <a href=\"modelica://Modelica_Synchronous.Examples.CascadeControlledDrive\">CascadeControlledDrive</a> examples (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/30\">#30</a>).</li>
</ul>

<p>Other (minor) fixes and improvements.</p>
</html>"));
    end Version_0_93_0;

    class Version_0_92_1 "Version 0.92.1 (March 11, 2016)"
      extends Modelica.Icons.Information;
      annotation (Documentation(info="<html>
<p>
Version 0.92.1 is backward compatible to version 0.92
</p>

<p>
This version uses package Modelica 3.2.2.
</p>

<p>
Changes with respect to version 0.92:
</p>

<ul>
<li> RealSignals.Sampler: Removed wrong double declaration of u and y
    (was present due to extends and due to explicit declaration)</li>
<li> Invalid links in documentation fixed (#1341)</li>
<li> BooleanSignals.TickBasedSources.Pulse wrong unit fixed (#1889)</li>
<li> Missing useClock parameter in RealSignals.Sampler.AssignClock fixed (#1919)</li>
<li> Set Evaluate=true to clock parameters of {Real,Integer,Boolean}Signals.Sampler.{Shift,Back}Sample(OpenModelica Ticket 3717)</li>
</ul>
</html>"));
    end Version_0_92_1;

    class Version_0_92 "Version 0.92 (Sept. 19, 2013)"
      extends Modelica.Icons.Information;
      annotation (Documentation(info="<html>
<p>
Version 0.92 is backward compatible to version 0.91
</p>

<p>
Changes with respect to version 0.91:
</p>

<ul>
<li> The library uses the latest Modelica Standard Libary (MSL) version 3.2.1 (but still works with version 3.2). </li>
<li> Added a couple of convenience source blocks for Real, Integer, and Boolean signals that are similar to the blocks
     found in the MSL, but have as output a clocked signal.</li>
<li> Added a couple of source blocks that are parametrized in terms of clock ticks rather than simulation time.</li>
<li> All new blocks are utilized in at least one test.</li>
</ul>
</html>"));
    end Version_0_92;
    extends Modelica.Icons.Information;

    class Version_0_91 "Version 0.91 (Sept. 20, 2012)"
      extends Modelica.Icons.Information;
      annotation (Documentation(info="<html>
<p>
First version of the library provided on the Modelica web page.
Changes with respect to version 0.9:
</p>

<ul>
<li> The library has been slightly restructured. </li>
<li> Documentation has been significantly enhanced
     (nearly all elements of the library are documented now).</li>
<li> Simple examples have been added for many
     blocks of the library in the new package
     <a href=\"modelica://Modelica_Synchronous.Examples.Elementary\">Examples.Elementary</a>.
     These blocks have been used to generate the figures in the documentation of
     many blocks. Furthermore, they are used for testing these blocks.</li>
</ul>

<p>
The library has been tested with Dymola 2013 FD01:
</p>

<ul>
<li> \"Check\" with \"Pedantic = true\" is successful (so the library should be completly compatible
     to the Modelica 3.3 specification).</li>
<li> \"Check with Simulation\" is successful.</li>
<li> The tests have a class coverage of 100 %
     (that is every class of the library is utilized in at least
     one test).</li>
<li> The results of the test models have been either manually checked,
     or compared with results of the Modelica_LinearSystems.Controller or
     the Modelica.Blocks.Discrete library.</li>
</ul>

<p>
The library has also been tested with the MapleSim Standalone Modelica parser
(so also another Modelica tool deduces that the library is fully conformant to
Modelica).
</p>
</html>"));
    end Version_0_91;

    class Version_0_9 "Version 0.9 (Aug. 28, 2012)"
      extends Modelica.Icons.Information;
      annotation (Documentation(info="<html>
<p>
This library version has been used
by the participants of a tutorial at the 9th
Modelica Conference 2012.
</p>
</html>"));
    end Version_0_9;
    annotation (Documentation(info="<html>
<p>
This section summarizes the changes that have been performed
on the Modelica_Synchronous library.
</p>
</html>"));
  end ReleaseNotes;

  class Requirements "Requirements"
    extends Modelica.Icons.Information;
    annotation (Documentation(info="<html>
<p>
This library is basically a graphical user interface to conveniently
operate with the Modelica 3.3 language elements of Chapter 16
\"Synchronous Language Elements\" of the Modelica Language Specification 3.3.
Every tool that supports these language
elements, as well as basic language elements of Modelica 3.1, should be
able to support this library.
</p>
</html>"));
  end Requirements;

  class Contact "Contact"
    extends Modelica.Icons.Information;
    annotation (Documentation(info="<html>
<dl>
<dt><b>Main Authors:</b></dt>
<dd>Martin Otter and Bernhard Thiele<br>
    German Aerospace Center (DLR)<br>
    Robotics and Mechatronics Center<br>
    Institute of System Dynamics and Control<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
    email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A>, <a href=\"mailto:Bernhard.Thiele@dlr.de\">Bernhard.Thiele@dlr.de</A><br></dd>
</dl>
<p><b>Acknowledgements:</b></p>
<ul>
<li> The design of the library has been performed in close cooperation and discussion
     with Hilding Elmqvist from Dassault Syst&egrave;mes Lund.</li>

<li> Sven Erik Mattsson from Dassault Syst&egrave;mes Lund developed the first
     Dymola prototype supporting the synchronous features of Modelica 3.3.
     Without this prototype,
     it would not have been possible to develop the Modelica_Synchronous library.</li>
</ul>
</html>"));
  end Contact;
  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
Library <b>Modelica_Synchronous</b> is a Modelica package
to precisely define and synchronize sampled data systems with different sampling rates. This package contains the <b>user's guide</b> for
the library and has the following content:
</p>
<ol>
<li><a href=\"modelica://Modelica_Synchronous.UsersGuide.GettingStarted\">Getting started</a>
    contains an introduction to the most important features and how
    to use them at hand of examples.</li>
<li><a href=\"modelica://Modelica_Synchronous.UsersGuide.Literature\">Literature</a>
    provides references that have been used to design and implement this
    library.</li>
<li><a href=\"modelica://Modelica_Synchronous.UsersGuide.ReleaseNotes\">Release Notes</a>
    summarizes the differences between different versions of this library.</li>
<li><a href=\"modelica://Modelica_Synchronous.UsersGuide.Requirements\">Requirements</a>
    sketches the requirements on a Modelica tool, in order that this library
    can be utilized.</li>
<li><a href=\"modelica://Modelica_Synchronous.UsersGuide.Contact\">Contact</a>
    provides information about the authors of the library as well as
    acknowledgments.</li>
</ol>
</html>"));
end UsersGuide;
