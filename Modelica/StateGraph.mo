within Modelica;
package StateGraph
  "Library of hierarchical state machine components to model discrete event and reactive systems"

extends Modelica.Icons.Package;

package UsersGuide "User's Guide of StateGraph Library"
  extends Modelica.Icons.Information;

  class OverView "Overview of library"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p>
In this section, an overview of the most important features
of this library is given.
</p>
<h4><font color=\"#008000\">Steps and Transitions</font></h4>
<p>
A <b>StateGraph</b> is an enhanced finite state machine.
It is based on the JGraphChart method and
takes advantage of Modelica features for
the \"action\" language. JGraphChart is a further development of
Grafcet to include elements of StateCharts that are not present
in Grafcet/Sequential Function Charts. Therefore, the StateGraph
library has a similar modeling power as StateCharts but avoids
some deficiences of StateCharts.
</p>
<p>
The basic elements of StateGraphs are <b>steps</b> and <b>transitions</b>:
</p>

<img src=\"modelica://Modelica/Resources/Images/StateGraph/UsersGuide/StepAndTransition1.png\">

<p>
<b>Steps</b> represent the possible states a StateGraph can have.
If a step is active the Boolean variable <b>active</b> of
the step is <b>true</b>. If it is deactivated,
<b>active</b> = <b>false</b>. At the initial time, all \"usual\"
steps are deactivated. The <b>InitialStep</b> objects are steps
that are activated at the initial time. They are characterized
by a double box (see figure above).
</p>
<p>
<b>Transitions</b> are used to change the state of a StateGraph.
When the step connected to the input of a transition is active,
the step connected to the output of this transition is deactivated
and the transition condition becomes true, then the
transition fires. This means that the step connected to the input to the
transition is deactivated and the step connected to the output
of the transition is activated.
</p>
<p>
The transition <b>condition</b> is defined via the parameter menu
of the transition object. Clicking on object \"transition1\" in
the above figure, results in the following menu:
</p>

<img src=\"modelica://Modelica/Resources/Images/StateGraph/UsersGuide/StepAndTransition2.png\">

<p>
In the input field \"<b>condition</b>\", any type of time varying
Boolean expression can be given (in Modelica notation, this is
a modification of the time varying variable <b>condition</b>).
Whenever this condition is true, the transition can fire.
Additionally, it is possible to activate a timer, via
<b>enableTimer</b> (see menu above) and provide a
<b>waitTime</b>. In this case the firing of the transition
is delayed according to the provided waitTime. The transition
condition and the waitTime are displayed in the transition icon.
</p>
<p>
In the above example, the simulation starts at <b>initialStep</b>.
After 1 second, <b>transition1</b> fires and <b>step1</b> becomes
active. After another second <b>transition2</b> fires and
<b>initialStep</b> becomes again active. After a further
second <b>step1</b> becomes again active, and so on.
</p>
<p>
In JGrafcharts, Grafcet and Sequential Function Charts, the
network of steps and transitions is drawn from top to bottom.
In StateGraphs, no particular direction is defined, since
steps and transitions are blocks with input and output connectors
that can be arbitrarily placed and connected. Usually, it is
most practical to define the network from left to right,
as in the example above, since then it is easy to read the
labels on the icons.
</p>
<h4><font color=\"#008000\">Conditions and Actions</font></h4>
<p>
With the block <b>TransitionWithSignal</b>, the firing condition
can be provided as Boolean input signal, instead as entry in the
menu of the transition. An example is given in the next
figure:
</p>

<img src=\"modelica://Modelica/Resources/Images/StateGraph/UsersGuide/StepAndTransition3.png\">

<p>
Component \"step\" is an instance of \"StepWithSignal\" that is
a usual step where the active flag is available as Boolean
output signal. To this output, component \"Timer\" from
library \"Modelica.Blocks.Logical\" is connected. It measures the
time from the time instant where the Boolean input (i.e., the
active flag of the step) became true upto the current
time instant. The timer is connected to a comparison
component. The output is true, once the timer reaches
1 second. This signal is used as condition input of the
transition. As a result, \"transition2\" fires, once step
\"step\" has been active for 1 second.
Of course, any other
Modelica block with a Boolean output signal can be
connected to the condition input of such a transition block
as well.
</p>
<p>
Conditions of a transition can either be computed by
a network of logical blocks from the Logical library as
in the figure above, or via the \"SetBoolean\" component
any type of logical expression can be defined in textual
form, as shown in the next figure:
</p>

<img src=\"modelica://Modelica/Resources/Images/StateGraph/UsersGuide/StepAndTransition4.png\">

<p>
With the block \"<b>SetBoolean</b>\", a time varying expression
can be provided as modification to the output signal <b>y</b>
(see block with icon text \"timer.y > 1\" in the figure above).
The output signal can be in turn connected to the condition
input of a TransitionWithSignal block.
</p>
<p>
The \"<b>SetBoolean</b>\" block can also be used to
compute a Boolean signal depending on the active step.
In the figure above, the output of the block with the
icon text \"step.active\" is
true, when \"step\" is active, otherwise it is false
(note, the icon text of \"SetBoolean\" displays the modification
of the output signal \"y\").
This signal can then be used to compute desired <b>actions</b>
in the physical systems model. For example, if a <b>valve</b>
shall be open, when the StateGraph is in \"step1\" or
in \"step4\", a \"SetBoolean\" block may be connected to the
valve model using the following condition:
</p>
<pre>
    valve = step1.active <b>or</b> step2.active
</pre>
<p>
Via the Modelica operators <b>edge</b>(..) and <b>change</b>(..),
conditions depending on rising and falling edges of
Boolean expressions can be used when needed.
</p>
<p>
In JGrafcharts, Grafcet, Sequential Function Charts and StateCharts,
<b>actions</b> are formulated <b>within a step</b>. Such actions are
distinguished as <b>entry</b>, <b>normal</b>, <b>exit</b> and
<b>abort</b> actions. For example, a valve might be opened by
an entry action of a step and might be closed by an exit
action of the same step. In StateGraphs, this is (fortunately)
<b>not possible</b>
due to Modelicas \"single assignment rule\" that requires that every
variable is defined by exactly one equation. Instead, the
approach explained above is used. For example, via the
\"SetBoolean\" component, the valve variable is set to true
when the StateGraph is in particular steps.
</p>
<p>
This feature of a StateGraph is <b>very useful</b>, since it allows
a Modelica translator to <b>guarantee</b> that a given StateGraph
has always <b>deterministic</b> behaviour without conflicts.
In the other methodologies this is much more cumbersome. For example,
if two steps are executed in parallel and both step actions
modify the same variable, the result is either non-deterministic
or non-obvious rules have to be defined which action
takes priority. In a StateGraph, such a situation is detected by
the translator resulting in an error, since there are two equations
to compute one variable. Additional benefits of the StateGraph
approach are:
</p>
<ul>
<li> A JGrafchart or a StateChart need to potentially access
     variables in a step that are defined in
     higher hierarchical levels of a model. Therefore, mostly <b>global
     variables</b> are used in the whole network, even if the
     network is structured hierarchically. In StateGraphs this
     is not necessary, since the physical systems outside
     of a StateGraph might access the step or transition state
     via a hierarchical name. This means that <b>no global variables</b>
     are needed, because the local variables in the StateGraph
     are accessed from local variables outside of the StateGraph.
     </li>
<li> It is simpler for a user to understand the information that
     is provided in the non-graphical definition, since every
     variable is defined at exactly one place. In the other
     methodologies, the setting and re-setting of the same
     variable is cluttered within the whole network.
    </li>
</ul>
<p>
To emphasize this important difference between these methodologies,
consider the case that a state machine has the following
hierarchy:
</p>
<pre>
   stateMachine.superstate1.superstate2.step1
</pre>
<p>
Within \"step1\" a StateChart would, e.g., access variable
\"stateMachine.openValve\", say as \"entry action: openValve = true\".
This typical usage has the severe drawback that it is not possible
to use the hierarchical state \"superstate1\" as component in another
context, because \"step1\" references a particular name outside of this
component.
</p>
<p>
In a StateGraph, there would be typically a \"SetBoolean\" component
in the \"stateMachine\" component stating:
</p>
<pre>
    openValve = superstate1.superstate2.step1.active;
</pre>
<p>
As a result, the \"superstate1\" component can be used in
another context, because it does not depend on the environment
where it is used.
</p>
<h4><font color=\"#008000\">Execution Model</font></h4>
<p>
The execution model of a StateGraph follows from its
Modelica implementation: Given the states of all steps, i.e.,
whether a step is active or not active, the equations of all
steps, transitions, transition conditions, actions etc. are
sorted resulting in an execution sequence to compute
essentially the new values of the steps. If conflicts occur,
e.g., if there are more equations as variables, of if there
are algebraic loops between Boolean variables, an exception
is raised. Once all equations have been processed, the
<b>active</b> variable of all steps are updated to the newly
calculated values. Afterwards, the equations are again
evaluated. The iteration stops, once no step changes
its state anymore, i.e., once no transition fires anymore.
Then, simulation continuous until a new event is triggered,
(when a relation changes its value).
</p>
<p>
With the Modelica \"sampled(..)\" operator, a StateGraph might also
be executed within a discrete controller that is called
at regular time instants. In a future version of the StateGraph
library, this might be more directly supported.
</p>
<h4><font color=\"#008000\">Parallel and Alternative Execution</font></h4>
<p>
Parallel activities can be defined by
component <b>Parallel</b> and alternative activities
can be defined by component <b>Alternative</b>.
An example for both components is given in the next figure.
</p>

<img src=\"modelica://Modelica/Resources/Images/StateGraph/UsersGuide/Parallel1.png\">

<p>
Here, the branch from \"step2\" to \"step5\" is executed in parallel
to \"step1\". A transition connected to the output of a parallel
branch component can only fire if the final steps
in all parallel branches are active simultaneously.
The figure above is a screen-shot from the animation of the
StateGraph: Whenever a step is active or a transition can fire,
the corresponding component is marked in <b>green</b> color.
</p>
<p>
The three branches within \"step2\" to \"step5\" are
executed alternatively, depending which transition condition
of \"transition3\", \"transition4\", \"transition4a\" fires first.
Since all three transitions fire after 1 second, they are all
candidates for the active branch. If two or more transitions
would fire at the same time instant, a priority selection
is made: The alternative and parallel components have a
vector of connectors. Every branch has to be connected to
exactly one entry of the connector vector. The entry with
the lowest number has the highest priority.
</p>
<p>
Parallel, Alternative and Step components have vectors of
connectors. The dimensions of these vectors are set in the
corresponding parameter menu. E.g. in a \"Parallel\" component:
</p>

<img src=\"modelica://Modelica/Resources/Images/StateGraph/UsersGuide/Parallel2.png\">

<p>
Currently in Dymola the following menu pops up, when a branch
is connected to a vector of components in order to define
the vector index to which the component shall be connected:
</p>

<img src=\"modelica://Modelica/Resources/Images/StateGraph/UsersGuide/Parallel3.png\">

<h4><font color=\"#008000\">CompositeSteps, Suspend and Resume Port</font></h4>
<p>
A StateGraph can be hierarchically structured by using a <b>CompositeStep</b>.
This is a component that inherits from <b>PartialCompositeStep</b>.
An example is given in the next figure (from Examples.ControlledTanks):
</p>

<img src=\"modelica://Modelica/Resources/Images/StateGraph/UsersGuide/CompositeStep1.png\">

<p>
The CompositeStep component contains a local StateGraph that is
entered by one or more input transitions and that is left
by one or more output transitions. Also, other needed signals
may enter a CompositeStep. The CompositeStep has similiar properties
as a \"usual\" step: The CompositeStep is <b>active</b> once at least
one step within the CompositeStep is active. Variable <b>active</b>
defines the state of the CompositeStep.
</p>
<p>
Additionally, a CompositeStep has a <b>suspend</b> port. Whenever the
transition connected to this port fires, the CompositeStep is left
at once. When leaving the CompositeStep via the suspend port, the internal
state of the CompositeStep is saved, i.e., the active flags of all
steps within the CompositeStep. The CompositeStep might be entered via
its <b>resume</b> port. In this case the internal state from the
suspend transition is reconstructed and the CompositeStep continues
the execution that it had before the suspend transition fired
(this corresponds to the history ports of StateCharts or JGrafCharts).
</p>
<p>
A CompositeStep may contain other CompositeSteps. At every level,
a CompositeStep and all of its content can be left via its suspend ports
(actually, there
is a vector of suspend connectors, i.e., a CompositeStep might
be aborted due to different transitions).
</p>
</html>
"));
  end OverView;

  class FirstExample "A first example"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p>
A first example will be given here (not yet done).
</p>
</html>
"));
  end FirstExample;

  class ApplicationExample "An application example"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p>
In this section a more realistic, still simple, application example
is given, to demonstrate various features of the StateGraph library.
This example shows the control of a two tank system from the master thesis
of Isolde Dressler
(<a href=\"modelica://Modelica.StateGraph.UsersGuide.Literature\">see literature</a>).
</p>
<p>
In the following figure the top level of the model is shown.
This model is available as StateGraph.Examples.ControlledTanks.
</p>

<img src=\"modelica://Modelica/Resources/Images/StateGraph/Examples/ControlledTanks1.png\">

<p>
In the right part of the figure, two tanks are shown. At the top part,
a large fluid source is present from which fluid can be filled in
<b>tank1</b> when <b>valve1</b> is open. Tank1 can be emptied via
<b>valve2</b> that is located in the bottom of tank2 and
fills a second <b>tank2</b> which in turn is emptied via
<b>valve3</b>. The actual levels of the tanks are measured
and are provided as signals <b>level1</b> and <b>level2</b>
to the <b>tankController</b>.
</p>
<p>
The <b>tankController</b> is controlled by three buttons,
<b>start</b>, <b>stop</b> and <b>shut</b> (for shutdown)
that are mutually exclusive. This means that whenever one button is
pressed (i.e., its state is <b>true</b>) then the other two
buttons are not pressed (i.e., their states are <b>false</b>).
When button <b>start</b> is pressed, the \"normal\" operation
to fill and to empty the two tanks is processed:
</p>
<ol>
<li> Valve 1 is opened and tank 1 is filled.</li>
<li> When tank 1 reaches its fill level limit,
     valve 1 is closed. </li>
<li> After a waiting time, valve 2 is
     opened and the fluid flows from tank 1 into tank 2.</li>
<li> When tank 1 is empty, valve 2 is closed. </li>
<li> After a waiting time, valve 3 is opened and
     the fluid flows out of tank 2</li>
<li> When tank 2 is empty, valve 3 is closed</liI>
</ol>
<p>
The above \"normal\" process can be influenced by the following
buttons:
</p>
<ul>
<li> Button <b>start</b> starts the above process.
     When this button is pressed after a \"stop\" or
     \"shut\" operation, the process operation continues.
     </li>.
<li> Button <b>stop</b> stops the above process by
     closing all valves. Then, the controller waits for
     further input (either \"start\" or \"shut\" operation).</li>
<li> Button <b>shut</b> is used to shutdown the process,
     by emptying at once both tanks. When this is achieved,
     the process goes back to its start configuration.
     Clicking on \"start\", restarts the process.</li>
</ul>
<p>
The implementation of the <b>tankController</b> is shown in
the next figure:
</p>

<img src=\"modelica://Modelica/Resources/Images/StateGraph/Examples/ControlledTanks2.png\">

<p>
When the \"<b>start</b>\" button is pressed, the stateGraph is
within the CompositeStep \"<b>makeProduct</b>\". During normal
operation this CompositeStep is only left, once tank2 is empty.
Afterwards, the CompositeStep is at once re-entered.
</p>
<p>
When the \"<b>stop</b>\" button is pressed, the \"makeProduct\"
CompositeStep is at once terminated via the \"<b>suspend</b>\" port
and the stateGraph waits in step \"<b>s2</b>\" for further
commands. When the \"<b>start</b>\" button is pressed, the CompositeStep
is re-entered via its <b>resume</b> port and the \"normal\"
operation continues at the state where it was aborted by the
suspend transition. If the \"<b>shut</b>\" button is pressed,
the stateGraph waits in the \"<b>emptyTanks</b>\" step, until
both tanks are empty and then waits at the initial step
\"<b>s1</b>\" for further input.
</p>
<p>
The opening and closing of valves is <b>not</b> directly
defined in the stateGraph. Instead via the \"<b>setValveX</b>\"
components, the Boolean state of the valves are computed.
For example, the output y of \"setValve2\" is computed as:
</p>
<pre>
  y = makeProduct.fillTank2.active or emptyTanks.active
</pre>
<p>
i.e., valve2 is open, when step \"makeProduct.fillTank2 or when
step \"emptyTanks\" is active. Otherwise, valve2 is closed.
</p>
</html>
"));
  end ApplicationExample;

  class ComparisonWithStateGraph2 "Comparison with StateGraph2"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p>
There is a much improved library available called \"Modelica_StateGraph2\".
If this library is not yet distributed with your Modelica tool, you can download
it from <a href=\"http://www.modelica.org/libraries/Modelica_StateGraph2\">http://www.modelica.org/libraries/Modelica_StateGraph2</a>.
Find below a comparison with respect to Modelica.StateGraph.
It is not yet clear whether Modelica_StateGraph2 will be included in a
future version of the Modelica package. Another option is to provide
built-in support for state machines in a future Modelica language version
which would allow an even more powerful treatment of state machines in Modelica.
</p>

<p>
The Modelica_StateGraph2 library (called <u>StateGraph2</u> below)
is based on the experience with the current
Modelica.StateGraph library (called <u>StateGraph1</u> below) and is
a significantly further development of StateGraph1. Furthermore, it is heavily
based on the article (Malmheden et. al. 2008), see Literature below,
but uses a different implementation
technique as described in this article. The StateGraph2
library has the following improvements with respect to the StateGraph1
library:
</p>

<ul>
<li> <b>3 Basic Components (Step, Transition, Parallel)</b><br>
     All multiple versions of a component are
     combined in only one version (e.g., one step and not 4 step components).
     This is easier to understand and more convenient to use.
     The \"Parallel\" component is both used as \"composite step\" (so only one branch),
     as well as \"parallel step\" (so several execution branches).<br>&nbsp;</li>

<li> <b>Conveniently connecting components</b><br>
     Connecting components of a state machine in Modelica means to provide
     new vector dimensions and to provide a vector index to connect to.
     In StateGraph2, the new \"connectorSizing\" annotation is used and
     therefore all this is now performed automatically (from a users point
     of view, these actions are hidden; this is not the case in
     StateGraph1 and makes the usage of the StateGraph1 library clumsy).<br>&nbsp;</li>

<li> <b>Safer state machines</b><br>
     It is no longer possible to construct a wrong state machine in the sense that properties
     of the graph are violated (e.g., two initial steps, or branching wrongly out of a parallel
     component). Contrary to StateGraph2, in StateGraph1 such wrong graphs do not lead to an
     error but to unexpected simulation results. Still, other desirable properties
     of a state machine,  such as \"no deadlock\" or \"lifeliness\" or \"every step reachable\",
     are not (yet) guaranteed with the current StateGraph2. <br>&nbsp;</li>

<li> <b>Composite, autonomous, synchronized, preempted subgraphs</b><br>
     Composite steps and parallel steps are described in a much better and more powerful
     way as in StateGraph1: Either by component \"Parallel\" or
     by inheriting from \"PartialParallel\". The first alternative has the advantage that it
     is simple to use (not necessary to construct a new class and instanciating this class, and
     easy variable access since no new hierarchy is constructed), the second alternative
     has the advantage that it introduces a Modelica hierarchy (useful for large subgraphs).
     In both cases, various options are possible, such as
     <ol>
     <li> autonomous subgraphs (branches are executed in parallel autonomously),  </li>
     <li> synchronized subgraphs (branches are executed in parallel and are synchronized
           before leaving the subgraph via the outPort), </li>
     <li> subgraphs with preemption and exception (a parallel step can be interrupted via
          the suspend ports and can continue execution via the resume ports).</li>
     </ol>
     This is achieved by enabling/disabling the different ports.<br>&nbsp;</li>
<li> <b>No infinite looping</b>:<br>
     As in StateGraph1, there are two types of transitions: immediate transitions (during event
     iteration all immediate transitions fire until no transition condition is true anymore) and
     delayed transitions (a transition fires only after a delay). Contrary to StateGraph1,
     in StateGraph2 every loop must have at least one delayed transition. If this is not the case
     a translation error occurs which states that the model contains an algebraic loop
     between Booleans with the name \"checkOneDelayedTransitionPerLoop\".<br>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This property guarantees that an event
     iteration over a StateGraph2 converges after a
     finite number of iterations, provided the modeller does not introduce an unsafe construct
     in the actions associated with a StateGraph2 (e.g., \"i = pre(i) + 1\" in the equation section
     outside of a when-clause will give an event iteration that never stops).<br>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;It is possible to switch off this feature, by setting parameter
     \"loopCheck = <b>false</b>\" in one transition of a loop, instead of using a \"delayed transition\"
     at this place (in cases where immediate transitions are
     important and the transition conditions are in a form that they cannot fire at the
     same time instant).</li>
</ul>

<h4> Literature </h4>

<p>
The Modelica_StateGraph2 library is described in detail in
(Otter et. al. 2009, see below) and is additionally
based on the following references:
</p>

<dl>
<dt>Andr&eacute;, C. (2003):</dt>
<dd><a href=\"http://www.i3s.unice.fr/~map/WEBSPORTS/Documents/2003a2005/SSMsemantics.pdf\">
     Semantics of S.S.M (Safe State Machine).</a>.
     I3S Laboratory, UMR 6070 University of Nice-Sophia Antipolis / CNRS.<br>&nbsp;</dd>

<dt>Arzen K.-E. (2004):</dt>
<dd> <b>JGrafchart User Manual. Version 1.5</b>.
     Department of Automatic Control, Lund Institute of Technology,
     Lund, Sweden, Feb. 13, 2004.<br>&nbsp;</dd>

<dt>Dressler I. (2004):</dt>
<dd> <a href=\"http://www.control.lth.se/documents/2004/5726.pdf\">
     Code Generation From JGrafchart to Modelica.</a>.
     Master thesis, supervisor: Karl-Erik Arzen,
     Department of Automatic Control, Lund Institute of Technology,
     Lund, Sweden, March 30, 2004.<br>&nbsp;</dd>

<dt>Elmqvist H., Mattsson S.E., Otter M. (2001):</dt>
<dd> <b>Object-Oriented and Hybrid Modeling in Modelica</b>.
     Journal Europeen des systemes automatises (JESA),
     Volume 35 - n. 1, 2001.<br>&nbsp;</dd>

<dt>Harel, D. (1987):</dt>
<dd> <a href=\"http://www.inf.ed.ac.uk/teaching/courses/seoc1/2005_2006/resources/statecharts.pdf\">
      A Visual Formalism for Complex Systems</a>.
      Science of Computer Programming 8, 231-274. Department of Applied Mathematics,
      The Weizmann Institute of Science, Rehovot, Israel.<br>&nbsp;</dd>

<dt>Malmheden M. (2007):</dt>
<dd> <a href=\"http://www.control.lth.se/documents/2007/5808.pdf\">
      ModeGraph - A Mode-Automata-Based Modelica Library for Embedded Control</a>.
      Master thesis, Department of Automatic Control, Lund University, Sweden.<br>&nbsp;
     </dd>

<dt>Malmheden M., Elmqvist H., Mattsson S.E., Henrisson D., Otter M. (2008):</dt>
<dd> <a href=\"http://www.modelica.org/events/modelica2008/Proceedings/sessions/session3a3.pdf\">
      ModeGraph - A Modelica Library for Embedded Control based on Mode-Automata</a>.
      Modelica'2008 Conference, March 3-4, 2008.<br>&nbsp;
     </dd>

<dt>Maraninchi F., R&eacute;mond, Y. (2002):</dt>
<dd> <a href=\"http://www-verimag.imag.fr/~maraninx/SCP2002.htm\">Mode-Automata:
     A New Domain-Specific Construct for the Development of Safe Critical Systems</a>.<br>&nbsp;
     </dd>

<dt>Mosterman P., Otter M., Elmqvist H. (1998):</dt>
<dd><a href=\"http://www.modelica.org/publications/papers/scsc98fp.pdf\">
     Modeling Petri Nets as Local Constraint Equations for
     Hybrid Systems using Modelica</a>.
     SCSC'98, Reno, Nevada, USA,
     Society for Computer Simulation International, pp. 314-319, 1998.<br>&nbsp;
     </dd>

<dt>Otter M., Malmheden M., Elmqvist H., Mattsson S.E., Johnsson C. (2009):</dt>
<dd> <a href=\"http://www.modelica.org/events/modelica2009\">
     A New Formalism for Modeling of Reactive and Hybrid Systems</a>.
      Modelica'2009 Conference, Como, Italy, Sept. 20-22, 2009.
     </dd>
</dl>

</html>
"));
  end ComparisonWithStateGraph2;

  class ReleaseNotes "Release notes"
    extends Modelica.Icons.ReleaseNotes;

    annotation (Documentation(info="<html>
<h4>Version 0.87, 2004-06-23</h4>
<ul>
<li> Included in Modelica standard library 2.0 Beta 1 with the new block connectors.
     Changed all the references to the block connectors and the Logical library
     correspondingly.</li>
</ul>
<h4>Version 0.86, 2004-06-20</h4>
<ul>
<li> New components \"Alternative\" and \"Parallel\" for alternative and
     parallel execution paths.</li>
<li> A step has now a vector of input and output connectors in order
     that multiple connections to and from a step are possible</li>
<li> Removed components \"AlternativeSplit\", \"AlternativeJoin\",
     \"ParallelSplit\" and \"ParallelJoin\" since the newly introduced
     components (\"Alternative\", \"Parallel\", vector connectors of steps)
     have the same modeling power but are safer and more convenient.</li>
<li> Removed the timer in a step (attach instead Logical.Timer to
     the \"active\" port of a \"StepWithSignal\" component). Note, that in
     most cases it is more convenient and more efficient to use the
     built-in timer of a transition.</li>
<li> Component \"StepInitial\" renamed to \"InitialStep\".</li>
<li> New component \"Timer\" within sublibrary Logical.</li>
<li> Updated and improved documentation of the library.</li>
</ul>
<h4>Version 0.85, 2004-06-17</h4>
<ul>
<li> Renamed \"MacroStep\" to \"CompositeStep\" and the ports of the MacroStep
     from \"abort\" to \"suspend\" and \"histoy\" to \"resume\".</li>
<li> Nested \"CompositeStep\" components are supported, based on the
     experimental feature of nested inner/outer components
     introduced by Dymola. This means that CompositeSteps can
     be suspended and resumed at every level.</li>
<li> New example \"Examples.ShowExceptions\" to demonstrate the new
     feature of nested CompositeSteps.</li>
<li> New package \"Logical\". It contains all components of
     ModelicaAdditions.Blocks.Logical, but with new block connectors
     and nicer icons. Additionally, logical blocks are also added.</li>
<li> Improved icons for several components of the StateGraph library.</li>
</ul>
<h4>Version 0.83, 2004-05-21</h4>
<ul>
<li> The \"abort\" and \"history\" connectors are no longer visible in the
     diagram layer of a CompositeStep since it is not allowed to connect
     to them in a CompositeStep.</li>
<li> Made the diagram/icon size of a CompositeStep smaller (from 200/-200 to
     150/-150).</li>
<li> Improved icons for \"SetBoolean/SetInteger/SetReal\" components.</li>
<li> Renamed \"ParameterReal\" to \"SetRealParameter\".</li>
</ul>
<h4>Version 0.82, 2004-05-18</h4>
<p>
Implemented a first version that is provided to other people.
</p>
</html>
"));
  end ReleaseNotes;

  class Literature "Literature"
    extends Modelica.Icons.References;

    annotation (Documentation(info="<html>
<p>
The StateGraph library is based on the following references:
</p>
<dl>
<dt>Arzen K.-E. (2004):</dt>
<dd> <b>JGrafchart User Manual. Version 1.5</b>.
     Department of Automatic Control, Lund Institute of Technology,
     Lund, Sweden, Feb. 13<br>&nbsp;</dd>
<dt>Dressler I. (2004):</dt>
<dd> <b>Code Generation From JGrafchart to Modelica</b>.
     Master thesis, supervisor: Karl-Erik Arzen,
     Department of Automatic Control, Lund Institute of Technology,
     Lund, Sweden, March 30<br>&nbsp;</dd>
<dt>Elmqvist H., Mattsson S.E., Otter M. (2001):</dt>
<dd> <b>Object-Oriented and Hybrid Modeling in Modelica</b>.
     Journal Europeen des systemes automatises (JESA),
     Volume 35 - n. 1.<br>&nbsp;</dd>
<dt>Mosterman P., Otter M., Elmqvist H. (1998):</dt>
<dd> <b>Modeling Petri Nets as Local Constraint Equations for
     Hybrid Systems using Modelica</b>.
     SCSC'98, Reno, Nevada, USA,
     Society for Computer Simulation International, pp. 314-319.
     </dd>
</dl>
</html>
"));

  end Literature;

  class Contact "Contact"
    extends Modelica.Icons.Contact;

    annotation (Documentation(info="<html>
<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
    Institut f&uuml;r Robotik und Mechatronik<br>
    Abteilung f&uuml;r Entwurfsorientierte Regelungstechnik<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>
<p><b>Acknowledgements:</b></p>
<ul>
<li> The development of this library was strongly motivated by the
     master thesis of Isolde Dressler
     (<a href=\"modelica://Modelica.StateGraph.UsersGuide.Literature\">see literature</a>),
     in which
     a compiler from JGrafChart to Modelica was designed and
     implemented. This project was supervised by Karl-Erik Arzen
     from Departement of Automatic Control, Lund Institut of
     Technology, Lund, Sweden.</li>
<li> This library profits also from the experience gained
     in the focused research program (Schwerpunktprogramm)
     \"Continuous-Discrete Dynamic Systems\" (KONDISK), sponsored by the
     Deutsche Forschungsgemeinschaft under grants OT174/1-2 and EN152/22-2.
     This support is most gratefully acknowledged.
 </li>
<li> The implementation of the basic components of this library by describing
     finite state machines with equations is based on
     (Elmqvist, Mattsson and Otter, 2001),
     which in turn uses ideas from (Mosterman, Otter and Elmqvist, 1998),
     see <a href=\"modelica://Modelica.StateGraph.UsersGuide.Literature\">literature</a></li>
</ul>
</html>
"));

  end Contact;

  annotation (__Dymola_DocumentationClass=true, Documentation(info="<html>
<p>
Library <b>StateGraph</b> is a <b>free</b> Modelica package providing
components to model <b>discrete event</b> and <b>reactive</b>
systems in a convenient
way. This package contains the <b>User's Guide</b> for
the library and has the following content:
</p>
<ol>
<li><a href=\"modelica://Modelica.StateGraph.UsersGuide.OverView\">Overview of library</a>
     gives an overview of the library.</li>
<li> <a href=\"modelica://Modelica.StateGraph.UsersGuide.FirstExample\">A first example</a>
     demonstrates at hand of a first example how to use this library.</li>
<li> <a href=\"modelica://Modelica.StateGraph.UsersGuide.ApplicationExample\">An
     application example</a> demonstrates varies features at hand of the
     control of a two tank system.</li>
<li> <a href=\"modelica://Modelica.StateGraph.UsersGuide.ComparisonWithStateGraph2\">Comparison
     with StateGraph2</a> compares Modelica.StateGraph with the much improved version
     Modelica_StateGraph2.</li>
<li><a href=\"modelica://Modelica.StateGraph.UsersGuide.ReleaseNotes\">Release Notes</a>
    summarizes the differences between different versions of this library.</li>
<li><a href=\"modelica://Modelica.StateGraph.UsersGuide.Literature\">Literature</a>
    provides references that have been used to design and implement this
    library.</li>
<li><a href=\"modelica://Modelica.StateGraph.UsersGuide.Contact\">Contact</a>
    provides information about the authors of the library as well as
    acknowledgments.</li>
</ol>
</html>"));
end UsersGuide;

package Examples
    "Examples to demonstrate the usage of the components of the StateGraph library"
  extends Modelica.Icons.ExamplesPackage;

  model FirstExample "A first simple StateGraph example"
    extends Modelica.Icons.Example;
    InitialStep initialStep annotation (Placement(transformation(extent={{-48,0},
                {-28,20}}, rotation=0)));
    Transition transition1(enableTimer=true, waitTime=1)
      annotation (Placement(transformation(extent={{-20,0},{0,20}}, rotation=0)));
    Step step annotation (Placement(transformation(extent={{10,0},{30,20}},
              rotation=0)));
    Transition transition2(enableTimer=true, waitTime=1)
      annotation (Placement(transformation(extent={{40,0},{60,20}}, rotation=0)));
      inner StateGraphRoot stateGraphRoot
        annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  equation

    connect(initialStep.outPort[1], transition1.inPort)
      annotation (Line(points={{-27.5,10},{-14,10}}, color={0,0,0}));

    connect(transition1.outPort, step.inPort[1])
      annotation (Line(points={{-8.5,10},{9,10}}, color={0,0,0}));
    connect(step.outPort[1], transition2.inPort)
      annotation (Line(points={{30.5,10},{46,10}}, color={0,0,0}));
    connect(transition2.outPort, initialStep.inPort[1]) annotation (Line(points=
             {{51.5,10},{70,10},{70,32},{-62,32},{-62,10},{-49,10}}, color={0,0,
              0}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}),
              graphics),
      experiment(StopTime=5),
        Documentation(info="<html>

</html>"));
  end FirstExample;

  model FirstExample_Variant2
      "A variant of the first simple StateGraph example"
    extends Modelica.Icons.Example;
    InitialStep initialStep annotation (Placement(transformation(extent={{-70,0},
                {-50,20}}, rotation=0)));
    Transition transition1(enableTimer=true, waitTime=1)
      annotation (Placement(transformation(extent={{-42,0},{-22,20}}, rotation=
                0)));
    StepWithSignal step
              annotation (Placement(transformation(extent={{-14,0},{6,20}},
              rotation=0)));
    TransitionWithSignal transition2
      annotation (Placement(transformation(extent={{52,0},{72,20}}, rotation=0)));
    Modelica.Blocks.Logical.Timer timer annotation (Placement(transformation(
              extent={{6,-40},{26,-20}}, rotation=0)));
    Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqual(threshold=1)
      annotation (Placement(transformation(extent={{36,-40},{56,-20}}, rotation=
               0)));
      inner StateGraphRoot stateGraphRoot
        annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  equation

    connect(initialStep.outPort[1], transition1.inPort)
      annotation (Line(points={{-49.5,10},{-36,10}}, color={0,0,0}));

    connect(transition1.outPort, step.inPort[1])
      annotation (Line(points={{-30.5,10},{-15,10}}, color={0,0,0}));
    connect(step.active, timer.u) annotation (Line(points={{-4,-1},{-4,-30},{4,
              -30}}, color={255,0,255}));
    connect(step.outPort[1], transition2.inPort)
      annotation (Line(points={{6.5,10},{58,10}}, color={0,0,0}));
    connect(timer.y, greaterEqual.u)
      annotation (Line(points={{27,-30},{34,-30}}, color={0,0,255}));
    connect(greaterEqual.y, transition2.condition) annotation (Line(points={{57,
              -30},{62,-30},{62,-2}}, color={255,0,255}));
    connect(transition2.outPort, initialStep.inPort[1]) annotation (Line(points=
             {{63.5,10},{82,10},{82,32},{-80,32},{-80,10},{-71,10}}, color={0,0,
              0}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}),
              graphics),
      experiment(StopTime=5),
        Documentation(info="<html>

</html>"));
  end FirstExample_Variant2;

  model FirstExample_Variant3
      "A variant of the first simple StateGraph example"
    extends Modelica.Icons.Example;
    InitialStep initialStep annotation (Placement(transformation(extent={{-70,0},
                {-50,20}}, rotation=0)));
    Transition transition1(enableTimer=true, waitTime=1)
      annotation (Placement(transformation(extent={{-42,0},{-22,20}}, rotation=
                0)));
    StepWithSignal step
              annotation (Placement(transformation(extent={{-14,0},{6,20}},
              rotation=0)));
    TransitionWithSignal transition2
      annotation (Placement(transformation(extent={{56,0},{76,20}}, rotation=0)));
    Modelica.Blocks.Logical.Timer timer annotation (Placement(transformation(
            origin={-4,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    Modelica.Blocks.Sources.BooleanExpression SetBoolean1(y=timer.y > 1) annotation (Placement(
            transformation(extent={{28,-40},{60,-20}}, rotation=0)));
    Modelica.Blocks.Sources.BooleanExpression SetBoolean2(y=step.active) annotation (Placement(
            transformation(extent={{-68,-40},{-36,-20}}, rotation=0)));
      inner StateGraphRoot stateGraphRoot
        annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  equation

    connect(initialStep.outPort[1], transition1.inPort)
      annotation (Line(points={{-49.5,10},{-36,10}}, color={0,0,0}));

    connect(transition1.outPort, step.inPort[1])
      annotation (Line(points={{-30.5,10},{-15,10}}, color={0,0,0}));
    connect(step.active, timer.u) annotation (Line(points={{-4,-1},{-4,-9.5},{
              -4,-18},{-4,-18}}, color={255,0,255}));
    connect(step.outPort[1], transition2.inPort)
      annotation (Line(points={{6.5,10},{62,10}}, color={0,0,0}));
    connect(transition2.outPort, initialStep.inPort[1]) annotation (Line(points=
             {{67.5,10},{82,10},{82,32},{-80,32},{-80,10},{-71,10}}, color={0,0,
              0}));
    connect(SetBoolean1.y, transition2.condition) annotation (Line(points={{
              61.6,-30},{66,-30},{66,-2}}, color={255,0,255}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}),
              graphics),
      experiment(StopTime=5),
        Documentation(info="<html>

</html>"));
  end FirstExample_Variant3;

  model ExecutionPaths
      "Example to demonstrate parallel and alternative execution paths"

    extends Modelica.Icons.Example;

    InitialStep step0 annotation (
          Placement(transformation(extent={{-140,-100},{-120,-80}}, rotation=0)));
    Transition transition1(enableTimer=true, waitTime=1)
      annotation (                                             Placement(
            transformation(extent={{-100,-100},{-80,-80}}, rotation=0)));
    Step step1 annotation (
          Placement(transformation(extent={{-10,-40},{10,-20}}, rotation=0)));
    Transition transition2(enableTimer=true, waitTime=1)
      annotation (                                           Placement(
            transformation(extent={{90,-100},{110,-80}}, rotation=0)));
    Step step6 annotation (                                           Placement(
            transformation(extent={{120,-100},{140,-80}}, rotation=0)));
    Step step2 annotation (
          Placement(transformation(extent={{-98,40},{-78,60}}, rotation=0)));
    Transition transition3(enableTimer=true, waitTime=1)
      annotation (                                            Placement(
            transformation(extent={{-42,80},{-22,100}}, rotation=0)));
    Transition transition4(enableTimer=true, waitTime=1)
      annotation (                                           Placement(
            transformation(extent={{-42,40},{-22,60}}, rotation=0)));
    Step step3 annotation (                                           Placement(
            transformation(extent={{-8,80},{12,100}}, rotation=0)));
    Step step4 annotation (                                          Placement(
            transformation(extent={{-8,40},{12,60}}, rotation=0)));
    Transition transition5(enableTimer=true, waitTime=1)
      annotation (                                          Placement(
            transformation(extent={{26,80},{46,100}}, rotation=0)));
    Transition transition6(enableTimer=true, waitTime=1)
      annotation (                                         Placement(
            transformation(extent={{26,40},{46,60}}, rotation=0)));
    Step step5 annotation (                                          Placement(
            transformation(extent={{80,40},{100,60}}, rotation=0)));
    Modelica.Blocks.Sources.RealExpression setReal(y=time)
                            annotation (Placement(transformation(extent={{21,
                -160},{41,-140}}, rotation=0)));
    TransitionWithSignal transition7 annotation (Placement(transformation(
              extent={{9,-134},{-11,-114}}, rotation=0)));
    Modelica.Blocks.Sources.BooleanExpression setCondition(y=time > 7)
      annotation (Placement(transformation(extent={{-77,-160},{-19,-140}},
              rotation=0)));
    Transition transition4a(enableTimer=true, waitTime=1)
      annotation (                                          Placement(
            transformation(extent={{-42,0},{-22,20}}, rotation=0)));
    Step step4a annotation (                                         Placement(
            transformation(extent={{-8,0},{12,20}}, rotation=0)));
    Transition transition6a(enableTimer=true, waitTime=2)
      annotation (                                        Placement(
            transformation(extent={{26,0},{46,20}}, rotation=0)));
    StateGraph.Temporary.NumericValue NumericValue1
      annotation (Placement(transformation(extent={{61,-160},{81,-140}},
              rotation=0)));
    Alternative alternative(nBranches=3)  annotation (Placement(transformation(
              extent={{-70,-10},{72,110}}, rotation=0)));
    Parallel Parallel1 annotation (Placement(transformation(extent={{-154,-50},
                {152,120}}, rotation=0)));
      inner StateGraphRoot stateGraphRoot
        annotation (Placement(transformation(extent={{-160,120},{-140,140}})));
  equation
    connect(transition3.outPort, step3.inPort[1])
      annotation (Line(points={{-30.5,90},{-9,90}}, color={0,0,0}));
    connect(step3.outPort[1], transition5.inPort)
      annotation (Line(points={{12.5,90},{32,90}}, color={0,0,0}));
    connect(transition4.outPort, step4.inPort[1])
      annotation (Line(points={{-30.5,50},{-9,50}}, color={0,0,0}));
    connect(step4.outPort[1], transition6.inPort)
      annotation (Line(points={{12.5,50},{32,50}}, color={0,0,0}));
    connect(transition7.outPort, step0.inPort[1]) annotation (Line(points={{
              -2.5,-124},{-149,-124},{-149,-90},{-141,-90}}, color={0,0,0}));
    connect(step6.outPort[1], transition7.inPort) annotation (Line(points={{
              140.5,-90},{150,-90},{150,-124},{3,-124}}, color={0,0,0}));
    connect(transition4a.outPort, step4a.inPort[1])
      annotation (Line(points={{-30.5,10},{-9,10}}, color={0,0,0}));
    connect(step4a.outPort[1], transition6a.inPort)
      annotation (Line(points={{12.5,10},{32,10}}, color={0,0,0}));
    connect(setCondition.y, transition7.condition) annotation (Line(points={{
              -16.1,-150},{-1,-150},{-1,-136}}, color={255,0,255}));
    connect(setReal.y, NumericValue1.Value) annotation (Line(
          points={{42,-150},{59,-150}},
          color={0,0,255}));
    connect(transition3.inPort, alternative.split[1])  annotation (Line(points={{-36,90},
              {-55.09,90}},           color={0,0,0}));
    connect(transition4.inPort, alternative.split[2])  annotation (Line(points={{-36,50},
              {-55.09,50}},           color={0,0,0}));
    connect(transition4a.inPort, alternative.split[3])  annotation (Line(points={{-36,10},
              {-45.0125,10},{-45.0125,10},{-55.09,10}},          color={0,0,0}));
    connect(transition5.outPort, alternative.join[1])  annotation (Line(points={{37.5,90},
              {57.09,90}},            color={0,0,0}));
    connect(transition6.outPort, alternative.join[2])  annotation (Line(points={{37.5,50},
              {57.09,50}},            color={0,0,0}));
    connect(transition6a.outPort, alternative.join[3])  annotation (Line(points={{37.5,10},
              {46.7625,10},{46.7625,10},{57.09,10}},           color={0,0,0}));
    connect(step2.outPort[1], alternative.inPort)  annotation (Line(points={{
              -77.5,50},{-72.13,50}}, color={0,0,0}));
    connect(alternative.outPort, step5.inPort[1])
      annotation (Line(points={{73.42,50},{79,50}}, color={0,0,0}));
    connect(step2.inPort[1], Parallel1.split[1]) annotation (Line(points={{-99,
              50},{-118,50},{-118,78},{-119.575,78},{-119.575,77.5}}, color={0,
              0,0}));
    connect(step1.outPort[1], Parallel1.join[2]) annotation (Line(points={{10.5,
              -30},{118,-30},{118,-7.5},{117.575,-7.5}}, color={0,0,0}));
    connect(step0.outPort[1], transition1.inPort) annotation (Line(points={{
              -119.5,-90},{-94,-90}}, color={0,0,0}));
    connect(transition2.outPort, step6.inPort[1]) annotation (Line(points={{
              101.5,-90},{119,-90}}, color={0,0,0}));
    connect(transition1.outPort, Parallel1.inPort) annotation (Line(points={{
              -88.5,-90},{-70,-90},{-70,-64},{-174,-64},{-174,35},{-158.59,35}},
            color={0,0,0}));
    connect(Parallel1.outPort, transition2.inPort) annotation (Line(points={{
              155.06,35},{168,35},{168,-60},{80,-60},{80,-90},{96,-90}}, color=
              {0,0,0}));
    connect(step5.outPort[1], Parallel1.join[1]) annotation (Line(points={{
              100.5,50},{116,50},{116,77.5},{117.575,77.5}}, color={0,0,0}));
    connect(Parallel1.split[2], step1.inPort[1]) annotation (Line(points={{
              -119.575,-7.5},{-118,-8},{-118,-30},{-11,-30}}, color={0,0,0}));
    annotation (
      Documentation(info="<HTML>
<p>
This is an example to demonstrate in which way <b>parallel</b> activities
can be modelled by a StateGraph. When transition1 fires
(after 1 second), two branches are executed in parallel.
After 6 seconds the two branches are synchronized in order to arrive
at step6.
</p>
<p>
Before simulating the model, try to figure out whether which branch
of the alternative sequence is executed. Note, that alternatives
have priorities according to the port index (alternative.split[1]
has a higher priority to fire as alternative.split[2]).
</p>
</HTML>
"),   Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-160,-160},{160,160}},
            grid={2,2}), graphics),
      experiment(StopTime=15));
  end ExecutionPaths;

  model ShowCompositeStep
      "Example to demonstrate parallel activities described by a StateGraph"

    extends Modelica.Icons.Example;

    Utilities.CompositeStep compositeStep
                                     annotation (Placement(transformation(
              extent={{-10,5},{20,35}}, rotation=0)));
    InitialStep step0 annotation (
          Placement(transformation(extent={{-89,-10},{-69,10}}, rotation=0)));
    Transition transition1(enableTimer=true, waitTime=1)
      annotation (                                             Placement(
            transformation(extent={{-59,-10},{-39,10}}, rotation=0)));
    Step step1 annotation (                                           Placement(
            transformation(extent={{-4,-30},{16,-10}}, rotation=0)));
    Transition transition2(enableTimer=true, waitTime=1)
      annotation (                                           Placement(
            transformation(extent={{45,-10},{65,10}}, rotation=0)));
    Step step6 annotation (                                           Placement(
            transformation(extent={{71,-10},{91,10}}, rotation=0)));
    TransitionWithSignal transition7 annotation (Placement(transformation(
              extent={{10,-70},{-10,-50}}, rotation=0)));
    Parallel Parallel1 annotation (Placement(transformation(extent={{-30,-40},{
                36,40}}, rotation=0)));
    Modelica.Blocks.Sources.BooleanExpression setCondition(y=time > 7)
      annotation (Placement(transformation(extent={{-40,-90},{-10,-70}},
              rotation=0)));
      inner StateGraphRoot stateGraphRoot
        annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
  equation
    connect(step0.outPort[1], transition1.inPort)
      annotation (Line(points={{-68.5,0},{-53,0}}, color={0,0,0}));
    connect(transition7.outPort, step0.inPort[1]) annotation (Line(points={{
              -1.5,-60},{-98,-60},{-98,0},{-90,0}}, color={0,0,0}));
    connect(step6.outPort[1], transition7.inPort) annotation (Line(points={{
              91.5,0},{96,0},{96,-60},{4,-60}}, color={0,0,0}));
    connect(transition2.outPort, step6.inPort[1]) annotation (Line(
          points={{56.5,0},{70,0}},
          color={0,0,0}));
    connect(transition1.outPort, Parallel1.inPort) annotation (Line(points={{-47.5,0},
              {-30.99,0}},          color={0,0,0}));
    connect(Parallel1.outPort, transition2.inPort) annotation (Line(points={{36.66,0},
              {51,0}},          color={0,0,0}));
    connect(compositeStep.inPort, Parallel1.split[1])
                                                 annotation (Line(points={{-11,20},
              {-22.575,20}},     color={0,0,0}));
    connect(compositeStep.outPort, Parallel1.join[1])
                                                 annotation (Line(points={{20.5,20},
              {28.575,20}},     color={0,0,0}));
    connect(step1.inPort[1], Parallel1.split[2]) annotation (Line(points={{-5,-20},
              {-22.575,-20}},      color={0,0,0}));
    connect(step1.outPort[1], Parallel1.join[2]) annotation (Line(points={{16.5,
              -20},{28.575,-20}}, color={0,0,0}));
    connect(setCondition.y, transition7.condition) annotation (Line(points={{
              -8.5,-80},{0,-80},{0,-72}}, color={255,0,255}));
    annotation (
      Documentation(info="<HTML>
<p>
This is the same example as \"ExecutionPaths\". The only difference
is that the alternative paths are included in a \"CompositeStep\".
</p>
</HTML>
"),   Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
      experiment(StopTime=15));
  end ShowCompositeStep;

  model ShowExceptions
      "Example to demonstrate how a hierarchically structured StateGraph can suspend and resume actions on different levels"

    extends Modelica.Icons.Example;

    Utilities.CompositeStep1 compositeStep
                                annotation (Placement(transformation(extent={{
                -20,25},{10,55}}, rotation=0)));
    InitialStep initialStep
                      annotation (
          Placement(transformation(extent={{-80,30},{-60,50}}, rotation=0)));
    Transition transition1(enableTimer=true, waitTime=1)
      annotation (                                             Placement(
            transformation(extent={{-50,30},{-30,50}}, rotation=0)));
    Transition transition2(enableTimer=true, waitTime=1)
      annotation (                                             Placement(
            transformation(extent={{20,30},{40,50}}, rotation=0)));
    Transition transition3(enableTimer=true, waitTime=2)
      annotation (                                             Placement(
            transformation(extent={{-55,-30},{-35,-10}}, rotation=0)));
    Step step1 annotation (Placement(transformation(extent={{-24,-30},{-4,-10}},
              rotation=0)));
    Transition transition4(enableTimer=true, waitTime=1)
      annotation (                                             Placement(
            transformation(extent={{10,-30},{30,-10}}, rotation=0)));
      inner StateGraphRoot stateGraphRoot
        annotation (Placement(transformation(extent={{-90,-80},{-70,-60}})));
  equation

    connect(transition1.outPort, compositeStep.inPort)
      annotation (Line(points={{-38.5,40},{-21,40}}, color={0,0,0}));
    connect(initialStep.outPort[1], transition1.inPort)
      annotation (Line(points={{-59.5,40},{-44,40}}, color={0,0,0}));
    connect(compositeStep.outPort, transition2.inPort)
      annotation (Line(points={{10.5,40},{26,40}}, color={0,0,0}));
    connect(transition2.outPort, initialStep.inPort[1]) annotation (Line(points=
             {{31.5,40},{46,40},{46,80},{-90,80},{-90,40},{-81,40}}, color={0,0,
              0}));
    connect(compositeStep.suspend[1], transition3.inPort)
                                                  annotation (Line(points={{-12.5,
              24.5},{-12.5,10},{-60,10},{-60,-20},{-49,-20}},
                                                            color={0,0,0}));
    connect(transition3.outPort, step1.inPort[1]) annotation (Line(points={{
              -43.5,-20},{-25,-20}}, color={0,0,0}));
    connect(step1.outPort[1], transition4.inPort)
      annotation (Line(points={{-3.5,-20},{16,-20}}, color={0,0,0}));
    connect(transition4.outPort, compositeStep.resume[1])
                                                  annotation (Line(points={{21.5,
              -20},{40,-20},{40,10},{2.5,10},{2.5,24}},  color={0,0,0}));
    annotation (
      Documentation(info="<HTML>
<p>
CompositeStep \"compositeStep\" is a hierarchical StateGraph consisting of
two other subgraphs. Whenever component \"compositeStep\" is suspended,
all steps with in \"compositeStep\" are deactivated. By entering \"compositeStep\"
via its \"resume\" port, all steps within \"compositeStep\" are activated
according to their setting before leaving the \"compositeStep\" via its
\"suspend\" port.
</p>
</HTML>
"),   Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
      experiment(StopTime=20));
  end ShowExceptions;

  model ControlledTanks
      "Demonstrating the controller of a tank filling/emptying system"
    extends Modelica.Icons.Example;
    Utilities.TankController tankController
      annotation (Placement(transformation(extent={{-50,-20},{-10,20}},
              rotation=0)));
    StateGraph.Temporary.RadioButton start(reset={stop.on,shut.on},
        buttonTimeTable={1,13,15,19})
      annotation (Placement(transformation(extent={{-90,20},{-70,40}}, rotation=
               0)));
    StateGraph.Temporary.RadioButton stop(reset={start.on,shut.on},
        buttonTimeTable={13,15,19,21})
      annotation (Placement(transformation(extent={{-90,-10},{-70,10}},
              rotation=0)));
    StateGraph.Temporary.RadioButton shut(reset={start.on,stop.on},
        buttonTimeTable={21,100})
      annotation (Placement(transformation(extent={{-90,-40},{-70,-20}},
              rotation=0)));

    Utilities.Tank tank1 annotation (Placement(transformation(extent={{10,20},{
                60,70}}, rotation=0)));
    Utilities.Tank tank2 annotation (Placement(transformation(extent={{34,-60},
                {84,-10}}, rotation=0)));
    Utilities.valve valve1
      annotation (Placement(transformation(
            origin={22.5,72},
            extent={{-5.5,-5.5},{5.5,5.5}},
            rotation=270)));
    Utilities.Source source annotation (Placement(transformation(extent={{12.5,
                80.5},{32.5,100.5}}, rotation=0)));
    Utilities.valve valve2 annotation (Placement(transformation(
            origin={46.5,13},
            extent={{-7,-8},{7,8}},
            rotation=270)));
    Utilities.valve valve3
      annotation (Placement(transformation(
            origin={73.5,-77},
            extent={{-7,-8},{7,8}},
            rotation=270)));
      inner StateGraphRoot stateGraphRoot
        annotation (Placement(transformation(extent={{-90,75},{-70,95}})));
  equation
    connect(tank1.outflow1, valve2.outflow1) annotation (Line(
          points={{50,33.75},{50,26.875},{46.5,26.875},{46.5,16.5}},
          color={0,0,0},
          thickness=0.5));
    connect(tank2.inflow1, valve2.inflow1) annotation (Line(
          points={{46.5,-18.75},{46.5,9.5}},
          color={0,0,0},
          thickness=0.5));
    connect(tank2.outflow1, valve3.outflow1) annotation (Line(
          points={{74,-46.25},{74,-73.5},{73.5,-73.5}},
          color={0,0,0},
          thickness=0.5));
    connect(tank1.inflow1, valve1.inflow1) annotation (Line(
          points={{22.5,61.25},{22.5,69.25}},
          color={0,0,0},
          thickness=0.5));
    connect(shut.on, tankController.shut) annotation (Line(points={{-69,-30},{
              -62,-30},{-62,-12},{-52,-12}}, color={255,0,255}));
    connect(stop.on, tankController.stop) annotation (Line(points={{-69,0},{-52,
              0}}, color={255,0,255}));
    connect(start.on, tankController.start) annotation (Line(points={{-69,30},{
              -60,30},{-60,12},{-52,12}}, color={255,0,255}));
    connect(tank1.levelSensor, tankController.level1) annotation (Line(points={
              {17.25,40},{-30,40},{-30,60},{-97,60},{-97,-50},{-42,-50},{-42,
              -22}}, color={0,0,255}));
    connect(tank2.levelSensor, tankController.level2) annotation (Line(points={
              {41.25,-40},{-18,-40},{-18,-22}}, color={0,0,255}));
    connect(tankController.valve1, valve1.valveControl) annotation (Line(points=
             {{-9,12},{10,12},{10,72},{18.1,72}}, color={255,0,255}));
    connect(tankController.valve2, valve2.valveControl) annotation (Line(points={{-9,0},{
              30,0},{30,13},{40.1,13}},         color={255,0,255}));
    connect(tankController.valve3, valve3.valveControl) annotation (Line(points=
             {{-9,-12},{23,-12},{23,-77},{67.1,-77}}, color={255,0,255}));

    connect(source.outflow1, valve1.outflow1) annotation (Line(
          points={{22.5,85.5},{22.5,74.75}},
          color={0,0,0},
          thickness=0.5));

    annotation (
      Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={0.5,0.5}), graphics),
      experiment(StopTime=100),
      Documentation(info="<html>
<p>
With this example the controller of a tank filling/emptying system
is demonstrated. This example is from Dressler (2004),
see <a href=\"modelica://Modelica.StateGraph.UsersGuide.Literature\">Literature</a>.
The basic operation is to fill and empty the two tanks:
</p>
<ol>
<li> Valve 1 is opened and tank 1 is filled.</li>
<li> When tank 1 reaches its fill level limit,
     valve 1 is closed. </li>
<li> After a waiting time, valve 2 is
     opened and the fluid flows from tank 1 into tank 2.</li>
<li> When tank 1 is empty, valve 2 is closed. </li>
<li> After a waiting time, valve 3 is opened and
     the fluid flows out of tank 2</li>
<li> When tank 3 is empty, valve 3 is closed</liI>
</ol>
<p>
The above \"normal\" process can be influenced by three
buttons:
</p>
<ul>
<li> Button <b>start</b> starts the above process.
     When this button is pressed after a \"stop\" or
     \"shut\" operation, the process operation continues.
     </li>.
<li> Button <b>stop</b> stops the above process by
     closing all valves. Then, the controller waits for
     further input (either \"start\" or \"shut\" operation).</li>
<li> Button <b>shut</b> is used to shutdown the process,
     by emptying at once both tanks. When this is achieved,
     the process goes back to its start configuration.
     Clicking on \"start\", restarts the process.</li>
</ul>

</html>"));
  end ControlledTanks;

  package Utilities "Utility components for the examples"
    extends Modelica.Icons.Package;

    model TankController "Controller for tank system"
      extends StateGraph.Interfaces.PartialStateGraphIcon;
      parameter Temporary.SetRealParameter limit=0.98 "Limit level of tank 1"
        annotation (Placement(transformation(extent={{-64,76},{-44,96}},
                rotation=0)));
      parameter Temporary.SetRealParameter waitTime=3 "Wait time"
        annotation (Placement(transformation(extent={{-91,76},{-71,96}},
                rotation=0)));

      InitialStep s1(nIn=2)
                     annotation (Placement(transformation(extent={{-72,30},{-52,
                  50}}, rotation=0)));
      MakeProduct makeProduct(limit=limit, waitTime=waitTime)
        annotation (Placement(transformation(extent={{-20,25},{10,55}},
                rotation=0)));
      Transition T1(condition=start) annotation (Placement(transformation(
                extent={{-50,50},{-30,30}}, rotation=0)));
      Transition T2(condition=level2<0.001)
        annotation (Placement(transformation(extent={{27,50},{47,30}}, rotation=
                 0)));
      Transition T3(condition=stop)
        annotation (Placement(transformation(
              origin={-23,-1},
              extent={{-10,-10},{10,10}},
              rotation=270)));
      Step s2(nOut=2)
              annotation (Placement(transformation(extent={{-50,-60},{-30,-40}},
                rotation=0)));
      Transition T4(condition=start)
        annotation (Placement(transformation(
              origin={10,-1},
              extent={{-10,-10},{10,10}},
              rotation=90)));
      Transition T5(condition=shut) annotation (Placement(transformation(extent=
                 {{-6,-60},{14,-40}}, rotation=0)));
      Step emptyTanks annotation (Placement(transformation(extent={{22,-60},{42,
                  -40}}, rotation=0)));
      Transition T6(condition=level1+level2<0.001)
        annotation (Placement(transformation(extent={{45,-60},{65,-40}},
                rotation=0)));
      Modelica.Blocks.Interfaces.BooleanInput start
        annotation (Placement(transformation(extent={{-120,50},{-100,70}},
                rotation=0)));
      Modelica.Blocks.Interfaces.BooleanInput stop
        annotation (Placement(transformation(extent={{-120,-10},{-100,10}},
                rotation=0)));
      Modelica.Blocks.Interfaces.BooleanInput shut
        annotation (Placement(transformation(extent={{-120,-70},{-100,-50}},
                rotation=0)));
      Modelica.Blocks.Interfaces.RealInput level1
        annotation (Placement(transformation(
              origin={-60,-110},
              extent={{-10,-10},{10,10}},
              rotation=90)));
      Modelica.Blocks.Interfaces.RealInput level2
        annotation (Placement(transformation(
              origin={60,-110},
              extent={{-10,-10},{10,10}},
              rotation=90)));
      Modelica.Blocks.Interfaces.BooleanOutput valve1
        annotation (Placement(transformation(extent={{100,55},{110,65}},
                rotation=0)));
      Modelica.Blocks.Interfaces.BooleanOutput valve2
        annotation (Placement(transformation(extent={{100,-5},{110,5}},
                rotation=0)));
      Modelica.Blocks.Interfaces.BooleanOutput valve3
        annotation (Placement(transformation(extent={{100,-65},{110,-55}},
                rotation=0)));
      Modelica.Blocks.Sources.BooleanExpression setValve1(y=makeProduct.fillTank1.active)
        annotation (Placement(transformation(extent={{20,73},{80,92}}, rotation=
                 0)));
      Modelica.Blocks.Sources.BooleanExpression setValve2(y=makeProduct.fillTank2.active or emptyTanks.active)
        annotation (Placement(transformation(extent={{-25,-89},{80,-68}},
                rotation=0)));
      Modelica.Blocks.Sources.BooleanExpression setValve3(y=makeProduct.emptyTank2.active or emptyTanks.active)
        annotation (Placement(transformation(extent={{-26,-100},{80,-80}},
                rotation=0)));
    equation

      connect(s1.outPort[1], T1.inPort)
                                     annotation (Line(
            points={{-51.5,40},{-44,40}},
            color={0,0,0}));
      connect(T1.outPort, makeProduct.inPort) annotation (Line(
            points={{-38.5,40},{-21,40}},
            color={0,0,0}));
      connect(makeProduct.outPort, T2.inPort) annotation (Line(
            points={{10.5,40},{33,40}},
            color={0,0,0}));
      connect(T5.outPort, emptyTanks.inPort[1])
                                             annotation (Line(
            points={{5.5,-50},{21,-50}},
            color={0,0,0}));
      connect(emptyTanks.outPort[1], T6.inPort)
                                             annotation (Line(
            points={{42.5,-50},{51,-50}},
            color={0,0,0}));
      connect(setValve1.y, valve1)
        annotation (Line(points={{83,82.5},{90,82.5},{90,60},{105,60}}, color={
                255,0,255}));
      connect(setValve2.y, valve2)
        annotation (Line(points={{85.25,-78.5},{90,-78.5},{90,0},{105,0}},
              color={255,0,255}));
      connect(setValve3.y, valve3) annotation (Line(points={{85.3,-90},{95,-90},
                {95,-60},{105,-60}}, color={255,0,255}));
      connect(makeProduct.suspend[1], T3.inPort)
                                              annotation (Line(points={{-12.5,
                24.5},{-12.5,12},{-23,12},{-23,3}}, color={0,0,0}));
      connect(T3.outPort, s2.inPort[1])
                                     annotation (Line(points={{-23,-2.5},{-23,
                -20},{-66,-20},{-66,-50},{-51,-50}}, color={0,0,0}));
      connect(T4.outPort, makeProduct.resume[1])
                                              annotation (Line(points={{10,0.5},
                {10,15},{2.5,15},{2.5,24}}, color={0,0,0}));
      connect(level1, makeProduct.level1) annotation (Line(points={{-60,-110},{
                -60,-80},{-80,-80},{-80,20},{-30,20},{-30,28},{-22,28}}, color=
                {0,0,255}));
      connect(s2.outPort[1], T5.inPort) annotation (Line(points={{-29.5,-49.75},
                {-30,-49.75},{-30,-50},{0,-50}}, color={0,0,0}));
      connect(s2.outPort[2], T4.inPort) annotation (Line(points={{-29.5,-50.25},
                {-29,-50},{-8,-50},{-8,-25},{10,-25},{10,-5}}, color={0,0,0}));
      connect(T2.outPort, s1.inPort[1]) annotation (Line(points={{38.5,40},{70,
                40},{70,70},{-84,70},{-84,40},{-73,40},{-73,40.5}}, color={0,0,
                0}));
      connect(T6.outPort, s1.inPort[2]) annotation (Line(points={{56.5,-50},{70,
                -50},{70,70},{-84,70},{-84,40},{-74,40},{-73,39.5}}, color={0,0,
                0}));
      annotation (
        Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={Rectangle(extent={{-100,100},{100,-100}},
                  lineColor={0,0,0})}),
        Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={
              Text(
                extent={{-100,68},{-32,54}},
                lineColor={0,0,0},
                textString="start"),
              Text(
                extent={{-100,6},{-32,-8}},
                lineColor={0,0,0},
                textString="stop"),
              Text(
                extent={{-100,-54},{-32,-68}},
                lineColor={0,0,0},
                textString="shut"),
              Text(
                extent={{-94,-82},{-18,-96}},
                lineColor={0,0,0},
                textString="level1"),
              Text(
                extent={{24,-84},{96,-98}},
                lineColor={0,0,0},
                textString="level2"),
              Text(
                extent={{31,68},{99,54}},
                lineColor={0,0,0},
                textString="valve1"),
              Text(
                extent={{33,9},{101,-5}},
                lineColor={0,0,0},
                textString="valve2"),
              Text(
                extent={{34,-53},{102,-67}},
                lineColor={0,0,0},
                textString="valve3")}));
    end TankController;

    model MakeProduct
        "State machine defining the time instants when to fill or empty a tank"
      extends StateGraph.PartialCompositeStep;
      parameter StateGraph.Temporary.SetRealParameter limit=0.98
          "Limit level of tank 1"
        annotation (Placement(transformation(extent={{-60,40},{-20,60}},
                rotation=0)));
      parameter StateGraph.Temporary.SetRealParameter waitTime=3 "Wait time"
        annotation (Placement(transformation(extent={{-120,40},{-80,60}},
                rotation=0)));

      Modelica.Blocks.Interfaces.RealInput level1
        annotation (Placement(transformation(extent={{-190,-140},{-150,-100}},
                rotation=0)));
      Step fillTank1 annotation (Placement(transformation(extent={{-140,-10},{
                  -120,10}}, rotation=0)));
      Transition T1(condition=level1 > limit)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
                rotation=0)));
      Step fillTank2 annotation (Placement(transformation(extent={{-10,-10},{10,
                  10}}, rotation=0)));
      Transition T3(condition=level1 < 0.001)
        annotation (Placement(transformation(extent={{20,-10},{40,10}},
                rotation=0)));
      Step emptyTank2 annotation (Placement(transformation(extent={{120,-10},{
                  140,10}}, rotation=0)));
      Step wait1 annotation (Placement(transformation(extent={{-80,-10},{-60,10}},
                rotation=0)));
      Transition T2(enableTimer=true, waitTime=waitTime)
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}},
                rotation=0)));
      Step wait2 annotation (Placement(transformation(extent={{54,-10},{74,10}},
                rotation=0)));
      Transition T4(enableTimer=true, waitTime=waitTime)
        annotation (Placement(transformation(extent={{82,-10},{102,10}},
                rotation=0)));
    equation
      connect(fillTank1.inPort[1], inPort)
                                        annotation (Line(
            points={{-141,0},{-160,0}},
            color={0,0,0}));
      connect(fillTank1.outPort[1], T1.inPort)
                                            annotation (Line(
            points={{-119.5,0},{-104,0}},
            color={0,0,0}));
      connect(fillTank2.outPort[1], T3.inPort)
                                            annotation (Line(
            points={{10.5,0},{26,0}},
            color={0,0,0}));
      connect(emptyTank2.outPort[1], outPort)
                                           annotation (Line(
            points={{140.5,0},{155,0}},
            color={0,0,0}));
      connect(wait1.outPort[1], T2.inPort)
                                        annotation (Line(points={{-59.5,0},{-44,
                0}}, color={0,0,0}));
      connect(T2.outPort, fillTank2.inPort[1])
                                            annotation (Line(points={{-38.5,0},
                {-11,0}}, color={0,0,0}));
      connect(T1.outPort, wait1.inPort[1])
                                        annotation (Line(points={{-98.5,0},{-81,
                0}}, color={0,0,0}));
      connect(wait2.outPort[1], T4.inPort)
                                        annotation (Line(points={{74.5,0},{88,0}},
              color={0,0,0}));
      connect(T3.outPort, wait2.inPort[1])
        annotation (Line(points={{31.5,0},{53,0}}, color={0,0,0}));
      connect(T4.outPort,emptyTank2.inPort[1])
                                             annotation (Line(points={{93.5,0},
                {119,0}}, color={0,0,0}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-150,
                  -150},{150,150}}),
                          graphics));
    end MakeProduct;

    connector inflow1
        "Inflow connector (this is a copy from Isolde Dressler's master thesis project)"

      import Units = Modelica.SIunits;

      input Units.VolumeFlowRate Fi "inflow";
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Polygon(
                points={{-100,-100},{0,100},{100,-100},{-100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}));
    end inflow1;

    connector inflow2
        "Inflow connector (this is a copy from Isolde Dressler's master thesis project)"

      import Units = Modelica.SIunits;

      output Units.VolumeFlowRate Fi "inflow";
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Polygon(
                points={{-100,-100},{0,100},{100,-100},{-100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}));
    end inflow2;

    connector outflow1
        "Outflow connector (this is a copy from Isolde Dressler's master thesis project)"

      import Units = Modelica.SIunits;

      output Units.VolumeFlowRate Fo "outflow";
      input Boolean open "valve open";
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Polygon(
                points={{-100,100},{0,-100},{100,100},{-100,100}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}));
    end outflow1;

    connector outflow2
        "Outflow connector (this is a copy from Isolde Dressler's master thesis project)"

      import Units = Modelica.SIunits;

      input Units.VolumeFlowRate Fo "outflow";
      output Boolean open "valve open";
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Polygon(
                points={{-100,100},{0,-100},{100,100},{-100,100}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}));
    end outflow2;

    model valve
        "Simple valve model (this is a copy from Isolde Dressler's master thesis project)"

      Modelica.Blocks.Interfaces.BooleanInput valveControl
        annotation (Placement(transformation(
              origin={0,-80},
              extent={{-20,-20},{20,20}},
              rotation=90)));
      Modelica.StateGraph.Examples.Utilities.inflow2 inflow1
                     annotation (Placement(transformation(
              origin={50,0},
              extent={{-50,-50},{50,50}},
              rotation=90)));
      Modelica.StateGraph.Examples.Utilities.outflow2 outflow1
                       annotation (Placement(transformation(
              origin={-50,0},
              extent={{-50,-50},{50,50}},
              rotation=90)));
    equation
      outflow1.Fo = inflow1.Fi;
      outflow1.open = valveControl;
      annotation (
        Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={Line(points={{0,-60},{0,0}}, color={255,0,
                    255})}),
        Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={
              Line(
                points={{20,20},{20,20}},
                color={0,0,0},
                thickness=0.5),
              Text(
                extent={{-131,125},{136,67}},
                lineColor={0,0,255},
                textString="%name"),
              Line(points={{0,0},{0,-60}}, color={255,0,255})}));
    end valve;

    model Tank
        "Simple tank model (this is a copy from Isolde Dressler's master thesis project)"

      Modelica.Blocks.Interfaces.RealOutput levelSensor
        annotation (Placement(transformation(extent={{-61,-30},{-81,-10}},
                rotation=0)));

      Modelica.StateGraph.Examples.Utilities.inflow1 inflow1
                     annotation (Placement(transformation(extent={{-55,60},{-45,
                  70}}, rotation=0)));
      Modelica.StateGraph.Examples.Utilities.outflow1 outflow1
                       annotation (Placement(transformation(extent={{55,-50},{
                  65,-40}}, rotation=0)));
      Real level "Tank level in % of max height";
      parameter Real A=1 "Ground area of tank in m^2";
      parameter Real a=0.2 "Area of drain hole in m^2";
      parameter Real hmax=1 "Max height of tank in m";
      constant Real g=Modelica.Constants.g_n;
    equation
      der(level) = (inflow1.Fi - outflow1.Fo)/(hmax*A);
      if outflow1.open then
        outflow1.Fo = sqrt(max(0,2*g*hmax*level))*a;
      else
        outflow1.Fo = 0;
      end if;
      levelSensor = level;

      annotation (
        Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics),
        Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={
              Text(
                extent={{-122,-82},{88,-42}},
                textString="%name",
                lineColor={0,0,255}),
              Rectangle(
                extent={{-60,60},{80,-40}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent=DynamicSelect({{-60,-40},{-60,-40}}, {{-60,-40},{80,(-40
                     + level*100)}}),
                lineColor={0,0,0},
                lineThickness=0.5,
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={191,0,95})}));
    end Tank;

    model Source
        "Simple source model (this is a copy from Isolde Dressler's master thesis project)"

      Modelica.StateGraph.Examples.Utilities.outflow1 outflow1
                       annotation (Placement(transformation(extent={{-10,-60},{
                  10,-40}}, rotation=0)));
      parameter Real maxflow=1 "maximal flow out of source";
    equation
      if outflow1.open then
        outflow1.Fo = maxflow;
      else
        outflow1.Fo = 0;
      end if;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Rectangle(
                extent={{-80,40},{80,-40}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid), Text(
                extent={{-144,54},{152,114}},
                textString="%name",
                lineColor={0,0,255})}), Diagram(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics));
    end Source;

    model CompositeStep
        "State machine demonstrating a composite step (used in StateGraph.Examples.ShowCompositeStep)"
      extends StateGraph.PartialCompositeStep;
      Transition transition3(enableTimer=true, waitTime=1)
        annotation (                                            Placement(
              transformation(extent={{-64,50},{-44,70}}, rotation=0)));
      Transition transition4(enableTimer=true, waitTime=1)
        annotation (                                             Placement(
              transformation(extent={{-64,-10},{-44,10}}, rotation=0)));
      Step step3 annotation (
            Placement(transformation(extent={{-10,50},{10,70}}, rotation=0)));
      Step step4 annotation (
            Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
      Transition transition5(enableTimer=true, waitTime=2)
        annotation (                                          Placement(
              transformation(extent={{36,50},{56,70}}, rotation=0)));
      Transition transition6(enableTimer=true, waitTime=2)
        annotation (                                           Placement(
              transformation(extent={{36,-10},{56,10}}, rotation=0)));
      Transition transition4a(enableTimer=true, waitTime=1)
        annotation (                                               Placement(
              transformation(extent={{-64,-70},{-44,-50}}, rotation=0)));
      Step step4a annotation (
            Placement(transformation(extent={{-10,-70},{10,-50}}, rotation=0)));
      Transition transition6a(enableTimer=true, waitTime=2)
        annotation (                                             Placement(
              transformation(extent={{36,-70},{56,-50}}, rotation=0)));
      Step initStep annotation (Placement(transformation(extent={{-140,-10},{
                  -120,10}}, rotation=0)));
      Step exitStep annotation (Placement(transformation(extent={{120,-10},{140,
                  10}}, rotation=0)));
      Alternative Alternative1(nBranches=3) annotation (Placement(
              transformation(extent={{-100,-90},{96,90}}, rotation=0)));
    equation
      connect(transition3.outPort, step3.inPort[1])
        annotation (Line(points={{-52.5,60},{-11,60}}, color={0,0,0}));
      connect(step3.outPort[1], transition5.inPort)
        annotation (Line(points={{10.5,60},{42,60}}, color={0,0,0}));
      connect(transition4.outPort, step4.inPort[1])
        annotation (Line(points={{-52.5,0},{-11,0}}, color={0,0,0}));
      connect(step4.outPort[1], transition6.inPort)
        annotation (Line(points={{10.5,0},{42,0}}, color={0,0,0}));
      connect(transition4a.outPort, step4a.inPort[1])
        annotation (Line(points={{-52.5,-60},{-11,-60}}, color={0,0,0}));
      connect(step4a.outPort[1], transition6a.inPort)
        annotation (Line(points={{10.5,-60},{42,-60}}, color={0,0,0}));
      connect(initStep.inPort[1], inPort)
        annotation (Line(points={{-141,0},{-160,0}}, color={0,0,0}));
      connect(exitStep.outPort[1], outPort)
        annotation (Line(points={{140.5,0},{155,0}}, color={0,0,0}));
      connect(initStep.outPort[1], Alternative1.inPort) annotation (Line(points=
               {{-119.5,0},{-102.94,0}}, color={0,0,0}));
      connect(Alternative1.outPort, exitStep.inPort[1])
        annotation (Line(points={{97.96,0},{119,0}}, color={0,0,0}));
      connect(transition3.inPort, Alternative1.split[1]) annotation (Line(
              points={{-58,60},{-79.42,60}}, color={0,0,0}));
      connect(transition4.inPort, Alternative1.split[2]) annotation (Line(
              points={{-58,0},{-67.975,0},{-67.975,-7.10543e-015},{-79.42,
                -7.10543e-015}}, color={0,0,0}));
      connect(transition4a.inPort, Alternative1.split[3]) annotation (Line(
              points={{-58,-60},{-67.975,-60},{-67.975,-60},{-79.42,-60}},
              color={0,0,0}));
      connect(transition5.outPort, Alternative1.join[1]) annotation (Line(
              points={{47.5,60},{75.42,60}}, color={0,0,0}));
      connect(transition6.outPort, Alternative1.join[2]) annotation (Line(
              points={{47.5,0},{60.725,0},{60.725,-7.10543e-015},{75.42,
                -7.10543e-015}}, color={0,0,0}));
      connect(transition6a.outPort, Alternative1.join[3]) annotation (Line(
              points={{47.5,-60},{60.725,-60},{60.725,-60},{75.42,-60}}, color=
                {0,0,0}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-150,
                  -150},{150,150}}),
                          graphics));
    end CompositeStep;

    model CompositeStep1
        "Composite step used to demonstrate exceptions (in StateGraph.Examples.ShowExceptions)"
      extends PartialCompositeStep;
      Transition transition1(
        enableTimer=false,
        waitTime=0,
        condition=time > 8)
        annotation (                                            Placement(
              transformation(extent={{-60,20},{-40,40}}, rotation=0)));
      Step initStep annotation (Placement(transformation(extent={{-140,-10},{
                  -120,10}}, rotation=0)));
      Step exitStep annotation (Placement(transformation(extent={{110,-10},{130,
                  10}}, rotation=0)));
      CompositeStep2 compositeStep11(waitTime=3)
                                           annotation (Placement(transformation(
                extent={{-20,15},{10,45}}, rotation=0)));
      CompositeStep2 compositeStep12(waitTime=2)
                                           annotation (Placement(transformation(
                extent={{-20,-45},{10,-15}}, rotation=0)));
      Transition transition2(
        condition=time > 4,
        enableTimer=false,
        waitTime=0)
        annotation (                                            Placement(
              transformation(extent={{-61,-40},{-41,-20}}, rotation=0)));
      Transition transition3(enableTimer=false, waitTime=0)
        annotation (                                            Placement(
              transformation(extent={{29,20},{49,40}}, rotation=0)));
      Transition transition4(enableTimer=false, waitTime=0)
        annotation (                                            Placement(
              transformation(extent={{29,-40},{49,-20}}, rotation=0)));
      Alternative Alternative1 annotation (Placement(transformation(extent={{
                  -100,-60},{89,60}}, rotation=0)));
    equation
      connect(exitStep.outPort[1], outPort)
        annotation (Line(points={{130.5,0},{155,0}}, color={0,0,0}));
      connect(initStep.inPort[1], inPort)
        annotation (Line(points={{-141,0},{-160,0}}, color={0,0,0}));
      connect(transition1.outPort, compositeStep11.inPort)
        annotation (Line(points={{-48.5,30},{-21,30}}, color={0,0,0}));
      connect(transition2.outPort, compositeStep12.inPort)
                                                     annotation (Line(points={{
                -49.5,-30},{-21,-30}}, color={0,0,0}));
      connect(compositeStep11.outPort, transition3.inPort)
        annotation (Line(points={{10.5,30},{35,30}}, color={0,0,0}));
      connect(compositeStep12.outPort, transition4.inPort)
                                                     annotation (Line(points={{
                10.5,-30},{35,-30}}, color={0,0,0}));
      connect(initStep.outPort[1], Alternative1.inPort) annotation (Line(points=
               {{-119.5,0},{-102.835,0}}, color={0,0,0}));
      connect(Alternative1.outPort, exitStep.inPort[1])
        annotation (Line(points={{90.89,0},{109,0}}, color={0,0,0}));
      connect(transition1.inPort, Alternative1.split[1]) annotation (Line(
              points={{-54,30},{-80.155,30}},  color={0,0,0}));
      connect(transition2.inPort, Alternative1.split[2]) annotation (Line(
              points={{-55,-30},{-80.155,-30}},  color={0,0,0}));
      connect(transition3.outPort, Alternative1.join[1]) annotation (Line(
              points={{40.5,30},{69.155,30}},  color={0,0,0}));
      connect(transition4.outPort, Alternative1.join[2]) annotation (Line(
              points={{40.5,-30},{69.155,-30}},  color={0,0,0}));
      annotation (            Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-150,-150},{150,150}},
              grid={1,1}), graphics));
    end CompositeStep1;

    model CompositeStep2
        "Composite step used to demonstrate exceptions (in StateGraph.Examples.ShowExceptions)"
      extends PartialCompositeStep;
      Transition transition(enableTimer=true, waitTime=waitTime)
        annotation (                                            Placement(
              transformation(extent={{-30,-10},{-10,10}}, rotation=0)));
      Step initStep annotation (Placement(transformation(extent={{-140,-10},{
                  -120,10}}, rotation=0)));
      Step exitStep annotation (Placement(transformation(extent={{110,-10},{130,
                  10}}, rotation=0)));
      parameter Temporary.SetRealParameter waitTime=2
          "waiting time in this composite step"
                                            annotation (Placement(
              transformation(extent={{-80,30},{-50,50}}, rotation=0)));
    equation
      connect(exitStep.outPort[1], outPort)
        annotation (Line(points={{130.5,0},{155,0}}, color={0,0,0}));
      connect(initStep.inPort[1], inPort)
        annotation (Line(points={{-141,0},{-160,0}}, color={0,0,0}));
      connect(initStep.outPort[1], transition.inPort)
        annotation (Line(points={{-119.5,0},{-24,0}}, color={0,0,0}));
      connect(transition.outPort, exitStep.inPort[1])
        annotation (Line(points={{-18.5,0},{109,0}}, color={0,0,0}));
      annotation (            Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-150,-150},{150,150}},
              grid={1,1}), graphics));
    end CompositeStep2;

  end Utilities;
    annotation (Documentation(info="<html>

</html>"));
end Examples;

package Interfaces "Connectors and partial models"
  extends Modelica.Icons.InterfacesPackage;

  connector Step_in "Input port of a step"
    output Boolean occupied "true, if step is active" annotation (HideResult=true);
    input Boolean set "true, if transition fires and step is activated"
      annotation (HideResult=true);
    annotation (
   Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{-100,100},{100,0},{-100,-100},{-100,100}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}),
                                            Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{0,50},{100,0},{0,-50},{0,50}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid), Text(
              extent={{-141,100},{100,60}},
              lineColor={0,0,0},
              textString="%name")}),
        Documentation(info="<html>

</html>"));
  end Step_in;

  connector Step_out "Output port of a step"
    output Boolean available "true, if step is active" annotation (HideResult=true);

    input Boolean reset "true, if transition fires and step is deactivated"
      annotation (HideResult=true);

    annotation (Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
                              Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Rectangle(
              extent={{-100,50},{0,-50}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-100,100},{186,58}},
              lineColor={0,0,0},
              textString="%name")}),
        Documentation(info="<html>

</html>"));
  end Step_out;

  connector Transition_in "Input port of a transition"
    input Boolean available
        "true, if step connected to the transition input is active"
      annotation (HideResult=true);
    output Boolean reset
        "true, if transition fires and the step connected to the transition input is deactivated"
      annotation (HideResult=true);

    annotation (Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{-100,100},{100,0},{-100,-100},{-100,100}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}),
                                            Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{0,50},{100,0},{0,-50},{0,50}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid), Text(
              extent={{-141,100},{100,60}},
              lineColor={0,0,0},
              textString="%name")}),
        Documentation(info="<html>

</html>"));
  end Transition_in;

  connector Transition_out "Output port of a transition"
    input Boolean occupied
        "true, if step connected to the transition output is active"
      annotation (HideResult=true);
    output Boolean set
        "true, if transition fires and step connected to the transition output becomes active"
      annotation (HideResult=true);

    annotation (Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
                              Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Text(
              extent={{-100,100},{146,60}},
              lineColor={0,0,0},
              textString="%name"), Rectangle(
              extent={{-100,50},{0,-50}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>

</html>"));
  end Transition_out;

  connector CompositeStep_resume
      "Input port of a step (used for resume connector of a CompositeStep)"
    output Boolean occupied "true, if step is active" annotation (HideResult=true);
    input Boolean set "true, if transition fires and step is activated"
      annotation (HideResult=true);
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              points={{-100,100},{100,0},{-100,-100},{-100,100}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}),
                                            Diagram(coordinateSystem(
              preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
            graphics={Rectangle(
              extent={{0,0},{0,0}},
              lineColor={255,255,255},
              pattern=LinePattern.None)}),
        Documentation(info="<html>

</html>"));
  end CompositeStep_resume;

  connector CompositeStep_suspend
      "Output port of a step (used for suspend connector of a CompositeStep)"

    output Boolean available "true, if step is active" annotation (HideResult=true);

    input Boolean reset "true, if transition fires and step is deactived"
      annotation (HideResult=true);

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
                              Diagram(coordinateSystem(preserveAspectRatio=true,
                       extent={{-100,-100},{100,100}}), graphics={Rectangle(
              extent={{0,0},{0,0}},
              lineColor={255,255,255},
              pattern=LinePattern.None)}),
        Documentation(info="<html>

</html>"));
  end CompositeStep_suspend;

  connector CompositeStepStatePort_in
      "Communication port between a CompositeStep and the ordinary steps within the CompositeStep (suspend/resume are inputs)"

    input Boolean suspend
        "= true, if suspend transition of CompositeStep fires";
    input Boolean resume "= true, if resume transition of CompositeStep fires";
    Real activeStepsDummy
        "Dummy variable in order that connector fulfills restriction of connector"
                                                                                annotation(HideResult=true);
    flow Real activeSteps "Number of active steps in the CompositeStep";
    annotation(Documentation(info="<html>

</html>"));
  end CompositeStepStatePort_in;

  connector CompositeStepStatePort_out
      "Communication port between a CompositeStep and the ordinary steps within the CompositeStep (suspend/resume are outputs)"

    output Boolean suspend
        "= true, if suspend transition of CompositeStep fires";
    output Boolean resume "= true, if resume transition of CompositeStep fires";
    Real activeStepsDummy
        "Dummy variable in order that connector fulfills restriction of connector"
                                                                                 annotation(HideResult=true);
    flow Real activeSteps "Number of active steps in the CompositeStep";
    annotation (Documentation(info="<html>

</html>"));
  end CompositeStepStatePort_out;

  partial block PartialStep
      "Partial step with one input and one output transition port"

    parameter Integer nIn(min=0) = 1 "Number of input connections";
    parameter Integer nOut(min=0) = 1 "Number of output connections";

    /* localActive is introduced since component 'Step' has Boolean variable 'active'
     and component 'StepWithSignal' has connector instance 'active' defined
     and both components inherit from PartialStep
  */
    output Boolean localActive
        "= true if step is active, otherwise the step is not active"
      annotation (HideResult=true);
    Interfaces.Step_in inPort[nIn] "Vector of step input connectors"
      annotation (Placement(transformation(extent={{-120,10},{-100,-10}},
              rotation=0)));
    Interfaces.Step_out outPort[nOut] "Vector of step output connectors"
      annotation (Placement(transformation(extent={{100,5},{110,-5}}, rotation=
                0)));
    protected
    outer Interfaces.CompositeStepState stateGraphRoot;
    model OuterStatePort
      CompositeStepStatePort_in subgraphStatePort;
    end OuterStatePort;
    OuterStatePort outerStatePort;

    Boolean newActive "Value of active in the next iteration"
      annotation (HideResult=true);
    Boolean oldActive "Value of active when CompositeStep was aborted";
  initial equation
    pre(newActive) = pre(localActive);
    pre(oldActive) = pre(localActive);
  equation
    connect(outerStatePort.subgraphStatePort, stateGraphRoot.subgraphStatePort);

    // Check that connections to the connector are correct
    for i in 1:nIn loop

    assert(cardinality(inPort[i]) <= 1,
           "Connector is connected to more than one transition (this is not allowed)");
    end for;

    for i in 1:nOut loop

    assert(cardinality(outPort[i]) <= 1,
           "Connector is connected to more than one transition (this is not allowed)");
    end for;

    // set active state
    localActive = pre(newActive);
    newActive = if outerStatePort.subgraphStatePort.resume then
                     oldActive else
                     ( StateGraph.Temporary.anyTrue(inPort.set) or
                          localActive
                       and not StateGraph.Temporary.anyTrue(outPort.reset))
                     and not outerStatePort.subgraphStatePort.suspend;

    // Remember state for suspend action
    when outerStatePort.subgraphStatePort.suspend then
      oldActive = localActive;
    end when;

    // Report state to CompositeStep
    outerStatePort.subgraphStatePort.activeSteps = if localActive then 1.0 else 0.0;

    // Report state to input and output transitions
    for i in 1:nIn loop
      inPort[i].occupied = if i == 1 then localActive else
                                          inPort[i-1].occupied or
                                          inPort[i-1].set;
    end for;

    for i in 1:nOut loop
       outPort[i].available = if i == 1 then localActive else
                                             outPort[i-1].available and not
                                             outPort[i-1].reset;
    end for;

    // Default setting, if an inPort or an outPort is not connected
    for i in 1:nIn loop
      if cardinality(inPort[i]) == 0 then
        inPort[i].set = false;
      end if;
    end for;

    for i in 1:nOut loop
      if cardinality(outPort[i]) == 0 then
        outPort[i].reset = false;
      end if;
    end for;
    annotation(Documentation(info="<html>

</html>"),     Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}),
                       graphics),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}),
           graphics),
      Coordsys(grid=[1,1], component=[20,20]));
  end PartialStep;

  partial block PartialTransition
      "Partial transition with input and output connections"
    input Boolean localCondition "= true, if transition may fire"
      annotation (HideResult=true);
    parameter Boolean enableTimer=false "= true, if timer is enabled"
      annotation (Evaluate=true, Dialog(group="Timer"));
    parameter Modelica.SIunits.Time waitTime(min=0) = 0
        "Wait time before transition fires"
      annotation (Dialog(group="Timer", enable=enableTimer));
    output Modelica.SIunits.Time t
        "= actual waiting time (transition will fire when t > waitTime)";
    output Boolean enableFire "= true, if all firing conditions are true";
    output Boolean fire "= true, if transition fires" annotation (HideResult=true);

    StateGraph.Interfaces.Transition_in inPort
        "Vector of transition input connectors"
      annotation (Placement(transformation(extent={{-50,-10},{-30,10}},
              rotation=0)));
    StateGraph.Interfaces.Transition_out outPort
        "Vector of transition output connectors"
      annotation (Placement(transformation(extent={{10,-5},{20,5}}, rotation=0)));
    protected
    Modelica.SIunits.Time t_start
        "Time instant at which the transition would fire, if waitTime would be zero";
    Real t_dummy;
  initial equation

    pre(enableFire) = false;
  equation
    assert(cardinality(inPort) == 1,
      "Connector inPort is not connected to exactly one other connector");
    assert(cardinality(outPort) == 1,
      "Connector outPort is not connected to exactly one other connector");

    // Handling of Timer
    if enableTimer then
      when enableFire then
        t_start = time;
      end when;
      t_dummy = time - t_start;
      t = if enableFire then t_dummy else 0;
      fire = enableFire and time >= t_start + waitTime;
    else
      t_start = 0;
      t_dummy = 0;
      t = 0;
      fire = enableFire;
    end if;

    // Determine fire setting and report it to the connected step
    enableFire = localCondition and inPort.available and not outPort.occupied;
    inPort.reset = fire;
    outPort.set = fire;
    annotation(Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
      Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
      Documentation(info="<html>

</html>"));
  end PartialTransition;

  partial block PartialStateGraphIcon "Icon for a StateGraph object"

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{160,110},{-160,150}},
              textString="%name",
              lineColor={0,0,255})}),
          Documentation(info="<html>

</html>"));
  end PartialStateGraphIcon;

  model CompositeStepState
      "Communication channel between CompositeSteps and steps in the CompositeStep"

    output Boolean suspend = false;
    output Boolean resume =  false;
    CompositeStepStatePort_out subgraphStatePort;

  /*
    missingInnerMessage="No \"stateGraphRoot\" component is defined on highest level
of the StateGraph. A stateGraphRoot component is automatically introduced.
In order to get rid of this message, drag StateGraph.StateGraphRoot into the
top level your model.");
*/
  equation
    suspend = subgraphStatePort.suspend;
    resume  = subgraphStatePort.resume;
    subgraphStatePort.activeStepsDummy = 0;
    annotation (
      defaultComponentName="stateGraphRoot",
      defaultComponentPrefixes="inner",
      missingInnerMessage="A \"stateGraphRoot\" component was automatically introduced.",
        Documentation(info="<html>

</html>"));
  end CompositeStepState;
    annotation (Documentation(info="<html>

</html>"));
end Interfaces;

block InitialStep "Initial step (= step that is active when simulation starts)"

  output Boolean active
      "= true if step is active, otherwise the step is not active";

  extends Interfaces.PartialStep;

initial equation
  active = true;
equation
  active = localActive;
  annotation (
    Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Text(
            extent={{-200,110},{200,150}},
            textString="%name",
            lineColor={0,0,255}),
          Rectangle(
            extent={{-100,100},{100,-100}},
            fillColor=DynamicSelect({255,255,255}, if active > 0.5 then {0,255,
                0} else {255,255,255}),
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0})}),
    Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={Rectangle(extent={{-100,100},{100,-100}},
              lineColor={0,0,0}), Rectangle(extent={{-80,80},{80,-80}},
              lineColor={0,0,0})}),
      Documentation(info="<html>

</html>"));
end InitialStep;

block InitialStepWithSignal
    "Initial step (= step that is active when simulation starts). Connector 'active' is true when the step is active"

  extends Interfaces.PartialStep;

  Modelica.Blocks.Interfaces.BooleanOutput active
    annotation (Placement(transformation(
          origin={0,-110},
          extent={{-10,-10},{10,10}},
          rotation=270)));
initial equation
  active = true;
equation
  active = localActive;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(extent={{-100,100},{100,-100}},
              lineColor={0,0,0}), Rectangle(extent={{-80,80},{80,-80}},
              lineColor={0,0,0})}),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Text(
            extent={{-200,110},{200,150}},
            textString="%name",
            lineColor={0,0,255}),
          Rectangle(
            extent={{-100,100},{100,-100}},
            fillColor=DynamicSelect({255,255,255}, if active > 0.5 then {0,255,
                0} else {255,255,255}),
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-92,-50},{94,-68}},
            lineColor={0,0,0},
            textString="active"),
          Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0})}),
      Documentation(info="<html>

</html>"));
end InitialStepWithSignal;

block Step "Ordinary step (= step that is not active when simulation starts)"

  output Boolean active
      "= true if step is active, otherwise the step is not active";

  extends Interfaces.PartialStep;

initial equation
  active = false;
equation
  active = localActive;
  annotation (
    Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={Text(
            extent={{-200,110},{200,150}},
            textString="%name",
            lineColor={0,0,255}), Rectangle(
            extent={{-100,100},{100,-100}},
            fillColor=DynamicSelect({255,255,255}, if active > 0.5 then {0,255,
                0} else {255,255,255}),
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={Rectangle(extent={{-100,100},{100,-100}},
              lineColor={0,0,0})}),
      Documentation(info="<html>

</html>"));
end Step;

block StepWithSignal
    "Ordinary step (= step that is not active when simulation starts). Connector 'active' is true when the step is active"

  extends Interfaces.PartialStep;

  Modelica.Blocks.Interfaces.BooleanOutput active
    annotation (Placement(transformation(
          origin={0,-110},
          extent={{-10,-10},{10,10}},
          rotation=270)));
initial equation
  active = false;
equation
  active = localActive;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(extent={{-100,100},{100,-100}},
              lineColor={0,0,0})}),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Text(
            extent={{-200,110},{200,150}},
            textString="%name",
            lineColor={0,0,255}),
          Rectangle(
            extent={{-100,100},{100,-100}},
            fillColor=DynamicSelect({255,255,255}, if active > 0.5 then {0,255,
                0} else {255,255,255}),
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-92,-74},{94,-92}},
            lineColor={0,0,0},
            textString="active")}),
      Documentation(info="<html>

</html>"));
end StepWithSignal;

block Transition
    "Transition where the fire condition is set by a modification of variable condition"

  input Boolean condition=true
      "= true, if transition may fire (time varying expression)"
    annotation (Dialog(group="Fire condition"));

  extends Interfaces.PartialTransition(final localCondition=condition);

  annotation (
    Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-10,100},{10,-100}},
            fillColor=DynamicSelect({0,0,0}, if enableFire > 0.5 then {0,255,0} else
                      {0,0,0}),
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-30,0},{-10,0}}, color={0,0,0}),
          Text(
            extent={{200,110},{-200,150}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{20,20},{200,45}},
            lineColor=DynamicSelect({0,0,0}, if enableTimer < 0.5 then {255,255,
                255} else {0,0,0}),
            textString="%waitTime"),
          Text(
            extent={{-200,-120},{200,-145}},
            lineColor=DynamicSelect({0,0,0}, if condition > 0.5 then {0,255,0} else
                      {0,0,0}),
            textString="%condition")}),
    Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={Line(points={{-31,0},{-11,0}}, color={0,0,0}),
            Rectangle(
            extent={{-10,100},{10,-100}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>

</html>"));

end Transition;

block TransitionWithSignal
    "Transition where the fire condition is set by a Boolean input signal"

  Modelica.Blocks.Interfaces.BooleanInput condition
    annotation (Placement(transformation(
          origin={0,-120},
          extent={{-20,-20},{20,20}},
          rotation=90)));

  extends Interfaces.PartialTransition(final localCondition=condition);

  annotation (
    Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Text(
            extent={{20,20},{200,45}},
            lineColor=DynamicSelect({0,0,0}, if enableTimer < 0.5 then {255,255,
                255} else {0,0,0}),
            textString="%waitTime"),
          Rectangle(
            extent={{-10,100},{10,-100}},
            fillColor=DynamicSelect({0,0,0}, if enableFire > 0.5 then {0,255,0} else
                      {0,0,0}),
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-30,0},{-10,0}}, color={0,0,0}),
          Text(
            extent={{200,110},{-200,150}},
            textString="%name",
            lineColor={0,0,255}),
          Ellipse(
            extent={{7,-81},{-7,-95}},
            lineColor=DynamicSelect({0,0,0}, if condition > 0.5 then {0,255,0} else
                      {0,0,0}),
            fillColor=DynamicSelect({0,0,0}, if condition > 0.5 then {0,255,0} else
                      {0,0,0}),
            fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={Line(points={{-31,0},{-11,0}}, color={0,0,0}),
            Rectangle(
            extent={{-10,100},{10,-100}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>

</html>"));

end TransitionWithSignal;

block Alternative
    "Alternative splitting of execution path (use component between two steps)"

  parameter Integer nBranches(min=1)=2 "Number of alternative branches";
  Interfaces.Transition_in inPort
                            annotation (Placement(transformation(extent={{-106,
              -3},{-100,3}}, rotation=0)));
  Interfaces.Transition_out outPort
                              annotation (Placement(transformation(extent={{100,
              -2},{104,2}}, rotation=0)));
  Step_in_forAlternative join[nBranches]
                                    annotation (Placement(transformation(extent=
             {{78,100},{80,-100}}, rotation=0)));
  Step_out_forAlternative split[nBranches]
                                      annotation (Placement(transformation(
            extent={{-78,100},{-80,-100}}, rotation=0)));

  protected
connector Step_in_forAlternative
      "Input port of a step (has special icon for usage in component 'Alternative')"

  output Boolean occupied "true, if step is active"
    annotation (HideResult=true);
  input Boolean set "true, if transition fires and step is activated"
    annotation (HideResult=true);

  annotation (Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid)}),
                                          Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid)}));
end Step_in_forAlternative;

connector Step_out_forAlternative
      "Output port of a step (has special icon for usage in component 'Alternative')"

  output Boolean available "true, if step is active"
    annotation (HideResult=true);
  input Boolean reset "true, if transition fires and step is deactivated"
    annotation (HideResult=true);

  annotation (Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid)}),
                            Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid)}));
end Step_out_forAlternative;

equation
  // Check connections of connectors

  assert(cardinality(inPort) == 1,
    "Connector inPort is not connected to exactly one other connector");

  assert(cardinality(outPort) == 1,
    "Connector outPort is not connected to exactly one other connector");

  for i in 1:nBranches loop

     assert(cardinality(split[i]) == 1,
       "Connector is not connected to exactly one other connector");

     assert(cardinality(join[i]) == 1,
       "Connector is not connected to exactly one other connector");

  end for;

  // Propagate flags between the connectors

  for i in 1:nBranches loop
     split[i].available = if i==1 then inPort.available else
                                       split[i-1].available and not split[i-1].reset;

  end for;
  join.occupied = fill(outPort.occupied, nBranches);
  inPort.reset  = StateGraph.Temporary.anyTrue(split.reset);
  outPort.set   = StateGraph.Temporary.anyTrue(join.set);
  annotation (
    Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(
            points={{-80,100},{80,100}},
            color={0,0,0},
            pattern=LinePattern.Dot),
          Line(
            points={{-80,-100},{80,-100}},
            color={0,0,0},
            pattern=LinePattern.Dot),
          Line(points={{-100,0},{-80,0}}, color={0,0,0}),
          Line(points={{80,0},{100,0}}, color={0,0,0})}),
    Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={Line(points={{-100,0},{-80,0}}, color={0,0,0}),
            Line(points={{80,0},{100,0}}, color={0,0,0})}),
      Documentation(info="<html>

</html>"));
end Alternative;

block Parallel
    "Parallel splitting of execution path (use component between two transitions)"

  parameter Integer nBranches(min=1)=2
      "Number of parallel branches that are executed in parallel";
  Interfaces.Step_in inPort annotation (Placement(transformation(extent={{-106,
              -3},{-100,3}}, rotation=0)));
  Interfaces.Step_out outPort annotation (Placement(transformation(extent={{100,
              -2},{104,2}}, rotation=0)));
  Transition_in_forParallel join[nBranches]
                                    annotation (Placement(transformation(extent=
             {{75,100},{80,-100}}, rotation=0)));
  Transition_out_forParallel split[nBranches]
                                      annotation (Placement(transformation(
            extent={{-75,100},{-80,-100}}, rotation=0)));

  protected
connector Transition_in_forParallel
      "Input port of a transition (has special icon for usage in component 'Parallel')"

  input Boolean available
        "true, if step connected to the transition input is active"
    annotation (HideResult=true);
  output Boolean reset
        "true, if transition fires and the step connected to the transition input is deactivated"
    annotation (HideResult=true);

  annotation (Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-100,100},{-100,-100}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{100,100},{100,-100}},
              color={0,0,0},
              thickness=0.5)}),             Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-100,100},{-100,-100}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{100,100},{100,-100}},
              color={0,0,0},
              thickness=0.5)}));
end Transition_in_forParallel;

connector Transition_out_forParallel
      "Output port of a transition (has special icon for usage in component 'Parallel')"

  input Boolean occupied
        "true, if step connected to the transition output is active"
    annotation (HideResult=true);
  output Boolean set
        "true, if transition fires and step connected to the transition output becomes active"
    annotation (HideResult=true);

  annotation (Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-100,100},{-100,-100}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{100,100},{100,-100}},
              color={0,0,0},
              thickness=0.5)}),
                            Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-100,100},{-100,-100}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{100,100},{100,-100}},
              color={0,0,0},
              thickness=0.5)}));
end Transition_out_forParallel;

equation
  // Check connections of connectors

  assert(cardinality(inPort) == 1,
    "Connector inPort is not connected to exactly one other connector");

  assert(cardinality(outPort) == 1,
    "Connector outPort is not connected to exactly one other connector");

  for i in 1:nBranches loop

     assert(cardinality(split[i]) == 1,
       "Connector is not connected to exactly one other connector");

     assert(cardinality(join[i]) == 1,
       "Connector is not connected to exactly one other connector");

  end for;

  // Propagate flags between the connectors
  split.set  = fill(inPort.set, nBranches);
  join.reset = fill(outPort.reset, nBranches);
  inPort.occupied   = StateGraph.Temporary.anyTrue(split.occupied);
  outPort.available = StateGraph.Temporary.allTrue(join.available);
  annotation (
    Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-100,0},{-80,0}}, color={0,0,0}),
          Line(points={{80,0},{100,0}}, color={0,0,0}),
          Line(
            points={{-80,100},{80,100}},
            color={0,0,0},
            pattern=LinePattern.Dot),
          Line(
            points={{-80,-100},{80,-100}},
            color={0,0,0},
            pattern=LinePattern.Dot)}),
    Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={Line(points={{-100,0},{-80,0}}, color={0,0,0}),
            Line(points={{80,0},{100,0}}, color={0,0,0})}),
      Documentation(info="<html>

</html>"));
end Parallel;

partial model PartialCompositeStep
    "Superclass of a subgraph, i.e., a composite step that has internally a StateGraph"

  parameter Integer nSuspend = 1 "Number of suspend ports" annotation(Dialog(group="Exception connections"));
  parameter Integer nResume = 1 "Number of resume ports" annotation(Dialog(group="Exception connections"));

  /* The modification of stateGraphRoot is with respect to the "inner"
     definition, i.e., it is reported to all components that are
     within the CompositeStep
  */
  inner outer StateGraph.Interfaces.CompositeStepState stateGraphRoot(
                  suspend = StateGraph.Temporary.anyTrue(suspend.reset) or outerState.subgraphStatePort.suspend,
                  resume =  StateGraph.Temporary.anyTrue(resume.set) or outerState.subgraphStatePort.resume)
      "Communication port between the CompositeStep and the steps within the CompositeStep";
  output Boolean active
      "= true if step is active, otherwise the step is not active";
  StateGraph.Interfaces.Step_in inPort annotation (Placement(transformation(
            extent={{-170,10},{-150,-10}}, rotation=0)));
  StateGraph.Interfaces.Step_out outPort annotation (Placement(transformation(
            extent={{150,5},{160,-5}}, rotation=0)));
  StateGraph.Interfaces.CompositeStep_suspend suspend[nSuspend]
    annotation (Placement(transformation(
          origin={-75,-155},
          extent={{-5,5},{5,-5}},
          rotation=270)));
  StateGraph.Interfaces.CompositeStep_resume resume[nResume]
    annotation (Placement(transformation(
          origin={75,-160},
          extent={{-10,-10},{10,10}},
          rotation=90)));

  model OuterState
      "Block containing the port that is connected to the outer stateGraphRoot"
    Interfaces.CompositeStepStatePort_in subgraphStatePort
        "Port connected to outer stateGraphRoot";
  end OuterState;
  OuterState outerState;

  protected
  model InnerState
    outer Interfaces.CompositeStepState stateGraphRoot;
  end InnerState;
  InnerState innerState;

  Boolean newActive "Value of active in the next iteration"
    annotation (HideResult=true);
  Integer activeSteps "Number of active steps within the CompositeStep";
initial equation

  pre(newActive) = pre(active);
equation
  // connect to outer CompositeStep

  connect(outerState.subgraphStatePort, stateGraphRoot.subgraphStatePort);
  outerState.subgraphStatePort.activeSteps = if active then 1.0 else 0.0;

  // set active flag  of CompositeStep
  activeSteps = -integer(innerState.stateGraphRoot.subgraphStatePort.activeSteps);
  active = pre(newActive);

  /* The CompositeStep is active if
     - at least one step within the CompositeStep is active, and
     - the suspend transition does not fire, and
     - the suspend transition of a higher level CompositeStep does not fire or
     - no step within the CompositeStep is active, and
     - the resume transition fires or the resume transition of
       a higher level CompositeStep fires.
  */
  // newActive = activeSteps > 0 and not suspend.reset or resume.set;
  newActive = activeSteps > 0 and not StateGraph.Temporary.anyTrue(suspend.reset) and not
              outerState.subgraphStatePort.suspend or
              StateGraph.Temporary.anyTrue(resume.set) or outerState.subgraphStatePort.resume;

  // Report state to suspend and resume transitions

  for i in 1:nResume loop
    resume[i].occupied = if i == 1 then active else
                                        resume[i-1].occupied or
                                        resume[i-1].set;

  end for;

  for i in 1:nSuspend loop
     suspend[i].available = if i == 1 then active else
                                           suspend[i-1].available and not
                                           suspend[i-1].reset;

  end for;

  /* Check that connections to the connectors are correct
     and set appropriate defaults if necessary
  */

  for i in 1:nSuspend loop

  assert(cardinality(suspend[i]) <= 1,
"Connector suspend[" + String(i) + "] of the CompositeStep is connected
to more than one transition");

    if cardinality(suspend[i]) == 0 then
      suspend[i].reset = false;

    end if;

  end for;

  for i in 1:nResume loop

  assert(cardinality(resume[i]) <= 1,
"Connector resume[" + String(i) + "] of the CompositeStep is connected
to more than one transition");

    if cardinality(resume[i]) == 0 then
      resume[i].set = false;

    end if;

  end for;

  /* Zero sized connectors are not yet fully supported in
     Dymola. This requires to set the dimension of the connector
     to 1, if it should have a dimension of zero. This requires
     to set the connector variables to a default value in this case
  */

  if cardinality(inPort) < 2 then
    inPort.occupied = false;
    inPort.set = false;

  end if;

  if cardinality(outPort) < 2 then
    outPort.available = false;
    outPort.reset = false;

  end if;

  // Check inPort/outPort connections

  assert(cardinality(inPort) <= 2,
"Connector inPort of the CompositeStep has more than 2 connections.
It should have only one connection from the outside to the
inPort and one connection to a step inside the CompositeStep.");

  assert(cardinality(outPort) <= 2,
"Connector outPort of the CompositeStep has more than 2 connections.
It should have only one connection from the outPort to the
outside to the CompositeStep and one connection from a step
inside the CompositeStep to the outPort connector.");

  annotation (
    Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-150,-150},{150,150}},
          grid={1,1}), graphics={
          Text(
            extent={{-250,160},{250,200}},
            textString="%name",
            lineColor={0,0,255}),
          Rectangle(
            extent={{-150,150},{150,-150}},
            fillColor=DynamicSelect({255,255,255}, if active > 0.5 then {0,255,
                0} else {255,255,255}),
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{4,-115},{145,-130}},
            lineColor={0,0,0},
            textString="resume"),
          Text(
            extent={{-144,-114},{-3,-129}},
            lineColor={0,0,0},
            textString="suspend")}),
    Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-150,-150},{150,150}},
          grid={1,1}), graphics={Rectangle(extent={{-150,150},{150,-150}},
              lineColor={0,0,0})}),
      Documentation(info="<html>

</html>"));
end PartialCompositeStep;

model StateGraphRoot
    "Root of a StateGraph (has to be present on the highest level of a StateGraph)"

  extends StateGraph.Interfaces.CompositeStepState;
  output Integer activeSteps "Number of active steps within the stategraph";

equation
  activeSteps = -integer(subgraphStatePort.activeSteps);
  annotation (
    defaultComponentName="stateGraphRoot",
    defaultComponentPrefixes="inner",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Text(
            extent={{-200,110},{200,150}},
            textString="%name",
            lineColor={0,0,255}),
          Rectangle(
            extent={{-100,100},{100,-100}},
            fillColor=DynamicSelect({255,255,255}, if active > 0.5 then {0,255,
                0} else {255,255,255}),
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-92,78},{96,34}},
            lineColor={0,0,0},
            textString="root"),
          Rectangle(extent={{-82,-6},{-44,-40}}, lineColor={0,0,0}),
          Line(points={{0,10},{0,-60}}, color={0,0,0}),
          Rectangle(extent={{48,-6},{86,-40}}, lineColor={0,0,0}),
          Polygon(
            points={{-12,-16},{0,-22},{-12,-28},{-12,-16}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-44,-22},{-12,-22}}, color={0,0,0}),
          Polygon(
            points={{36,-16},{48,-22},{36,-28},{36,-16}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{0,-22},{36,-22}}, color={0,0,0})}),
    Documentation(info="<html>
<p>
On the highest level of a StateGraph, an instance of StateGraphRoot
has to be present. If it is not within in a model, it is automatically
included by a Modelica translator due to an appropriate annotation.
Practically, this means that it need not be present in a
StateGraph model.
</p>
<p>
The StateGraphRoot object is needed, since all Step objects have
an \"outer\" reference to communicate with the \"nearest\" CompositeStep
(which inherits from PartialCompositeStep), especially to abort
a CompositeStep via the \"suspend\" port. Even if no \"CompositeStep\" is present,
on highest level a corresponding \"inner\" definition is needed
and is provided by the StateGraphRoot object.
</p>
</html>"));
end StateGraphRoot;

package Temporary
    "Components that will be provided by other libraries in the future"
type SetRealParameter = Real "Define Real parameter (GUI not yet satisfactory)"
  annotation (
  Dialog,
  defaultComponentName="name",
  defaultComponentPrefixes="parameter",
  Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-100,40},{100,-40}},
            lineColor={0,0,0},
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Text(extent={{-150,90},{150,50}}, textString="%name ="),
          Text(
            extent={{-96,15},{96,-15}},
            lineColor={0,0,0},
            textString="%value")}),
  Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
  Documentation(info="<html>
<p>
This is an <b>experimental component</b> to define a
<b>Real parameter</b>
in the <b>diagram layer</b>. The idea is to drag the icon from the
package browser into the diagram layer. Then a window pops
up in which the properties of this parameter can be defined
(such as the default value). The name and default value of the
parameter are displayed in the icon of this component. Whenever
clicking on it, the dialog to change parameter settings pops-up.
</p>
<p>
In Dymola, the described property is not fully available.
Currently, when dragging this component in the diagram layer,
a dialog pops up in which the properties of the parameter
can be defined. However, afterwards, the parameter is not
visible in the diagram layer. Making it visible requires to
go into the text layer and add an annotation with the
component size, resulting for example in:
</p>
<pre>
  <b>parameter</b> StateGraph.SetRealParameter name = 2
                       <b>annotation</b>(extent=[-10,-10; 10,10]);
</pre>
<p>
This change makes the parameter icon visible in the
diagram layer. However, clicking on this icon has no
effect. Changing parameter properties, such as the default
value, still requires to go in to the text layer.
</p>
</html>"));

  extends Modelica.Icons.Package;

  function anyTrue
      "Returns true, if at least on element of the Boolean input vector is true"

    extends Modelica.Icons.Function;
    input Boolean b[:];
    output Boolean result;
  algorithm
    result := false;
    for i in 1:size(b,1) loop
       result := result or b[i];
    end for;
      annotation (Documentation(info="<html>

</html>"));
  end anyTrue;

  function allTrue
      "Returns true, if all elements of the Boolean input vector are true"
    extends Modelica.Icons.Function;
    input Boolean b[:];
    output Boolean result;
  algorithm
    result := true;
    for i in 1:size(b,1) loop
       result := result and b[i];
    end for;
      annotation (Documentation(info="<html>

</html>"));
  end allTrue;

  block RadioButton
      "Button that sets its output to true when pressed and is reset when an element of 'reset' becomes true"

    parameter Modelica.SIunits.Time buttonTimeTable[:]={0}
        "Time instants where button is pressend and released";
    input Boolean reset[:]={false}
        "Reset button to false, if an element of reset becomes true"
      annotation (Dialog(group="Time varying expressions"));

    Modelica.Blocks.Interfaces.BooleanOutput on
      annotation (                                            Placement(
            transformation(extent={{100,-10},{120,10}}, rotation=0)));
    protected
    Modelica.Blocks.Sources.BooleanTable table(table=buttonTimeTable);
  algorithm
    on := table.y;
    when pre(reset) then
      on := false;
    end when;
    annotation (Icon(
          coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}),
          graphics={Rectangle(
              extent={{-100,-100},{100,100}},
              fillColor=DynamicSelect({192,192,192}, if on > 0.5 then {0,255,0} else
                        {192,192,192}),
              fillPattern=DynamicSelect(FillPattern.Solid, if on > 0.5 then
                  FillPattern.Solid else FillPattern.Solid),
              lineColor={128,128,128},
              lineThickness=0.5), Text(
              extent={{-80,-40},{80,40}},
              lineColor={0,0,0},
              textString="%name")},
                            interaction={OnMouseDownSetBoolean(
                            on, true)}),
                            Diagram(coordinateSystem(preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}),
                                    graphics),
        Documentation(info="<html>

</html>"));
  end RadioButton;

  model NumericValue "Show value of Real input signal dynamically"
    parameter Integer precision(min=0) = 3
        "Number of significant digits to be shown";
    parameter Boolean hideConnector=false
        "= true, if connector is not shown in the dynamic object diagram";

    Modelica.Blocks.Interfaces.RealInput Value "Real value to be shown in icon"
      annotation (
      Dialog(enable=hideConnector),
      Placement(visible=not boolean(hideConnector), transformation(extent={{-140,-20},{-100,20}}, rotation=0)));

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{100,50},{-100,-50}},
              lineColor={0,0,255},
              fillColor={236,233,216},
              fillPattern=FillPattern.Solid,
              borderPattern=BorderPattern.Raised), Text(
              extent={{-90,-46},{90,34}},
              textString=DynamicSelect(" ", String(
                    Value,
                    minimumLength=1,
                    significantDigits=integer(precision))),
              lineColor={0,0,255})}),
        Documentation(info="<html>

</html>"));

  end NumericValue;

  model IndicatorLamp
      "Dynamically show Boolean input signal (false/true = white/green color)"

    Modelica.Blocks.Interfaces.BooleanInput u
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}},
              rotation=0)));

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Ellipse(
              extent={{-100,-100},{100,100}},
              fillColor=DynamicSelect({235,235,235}, if u > 0.5 then {0,255,0} else
                        {235,235,235}),
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Sphere), Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>

</html>"));

  end IndicatorLamp;

  annotation (Documentation(info="<html>
<p>
This library is just temporarily present. The components of
this library will be present in the future in the Modelica
standard library (with the new block connectors) and in the
UserInteraction library that is currently under development.
</p>
</html>"));

end Temporary;
annotation (
  Documentation(info="<html>
<p>
Note, there is a much improved version of this library called
\"Modelica_StateGraph2\". If this library is not yet distributed with your
Modelica tool, you can download it from
<a href=\"http://www.modelica.org/libraries/Modelica_StateGraph2\">http://www.modelica.org/libraries/Modelica_StateGraph2</a>.
In the
<a href=\"modelica://Modelica.StateGraph.UsersGuide.ComparisonWithStateGraph2\">Users Guide</a>
a detailed comparison is given. It is highly recommended to use Modelica_StateGraph2 instead
of Modelica.StateGraph.
</p>

<p>
Library <b>StateGraph</b> is a <b>free</b> Modelica package providing
components to model <b>discrete event</b> and <b>reactive</b>
systems in a convenient
way. It is based on the JGraphChart method and
takes advantage of Modelica features for
the \"action\" language. JGraphChart is a further development of
Grafcet to include elements of StateCharts that are not present
in Grafcet/Sequential Function Charts. Therefore, the StateGraph
library has a similar modeling power as StateCharts but avoids
some deficiences of StateCharts.
</p>
<p>
For an introduction, have especially a look at:
</p>
<ul>
<li> <a href=\"modelica://Modelica.StateGraph.UsersGuide\">StateGraph.UsersGuide</a>
     discusses the most important aspects how to use this library.</li>
<li> <a href=\"modelica://Modelica.StateGraph.Examples\">StateGraph.Examples</a>
     contains examples that demonstrate the usage of this library.</li>
</ul>
<p>
A typical model generated with this library is shown
in the next figure where on the left hand side a two-tank
system with a tank controller and on the right hand side the
top-level part of the tank controller as a StateGraph is shown:
</p>

<img src=\"modelica://Modelica/Resources/Images/StateGraph/Examples/ControlledTanks1_small.png\">

<img src=\"modelica://Modelica/Resources/Images/StateGraph/Examples/ControlledTanks2_small.png\">

<p>
The unique feature of the StateGraph library with respect to JGraphCharts,
Grafcet, Sequential Function Charts, and StateCharts, is Modelica's
\"single assignment rule\" that requires that every variable is defined
by exactly one equation. This leads to a different \"action\" definition
as in these formalisms. The advantage is that the translator can either
determine a useful evaluation sequence by equation sorting or
reports an error if this is not possible, e.g., because a model
would lead to a non-determinism or to a dead-lock. As a side effect,
this leads also to simpler and more easier to understand models and
global variables are no longer needed (whereas in JGraphCharts,
Grafcet, Sequential Function Charts and StateCharts global variables
are nearly always needed).
</p>

<p>
Copyright &copy; 1998-2010, Modelica Association and DLR
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</HTML>
"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(extent={{-88,-20},{-50,-54}}, lineColor={0,0,0}),
        Line(points={{-50,-38},{-24,-38}}, color={0,0,0}),
        Polygon(
          points={{-24,-32},{-12,-38},{-24,-44},{-24,-32}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-12,-6},{-12,-76}}, color={0,0,0}),
        Line(points={{-12,-38},{14,-38}}, color={0,0,0}),
        Polygon(
          points={{14,-32},{26,-38},{14,-44},{14,-32}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{26,-22},{64,-56}}, lineColor={0,0,0})}));
end StateGraph;
