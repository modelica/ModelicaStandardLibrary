within Modelica.Clocked.Examples.Systems;
model ControlledMixingUnit
  "Simple example of a mixing unit where a (discretized) nonlinear inverse plant model is used as feedforward controller"
   extends Modelica.Icons.Example;

  parameter SI.Frequency freq = 1/300 "Critical frequency of filter";
  parameter Real c0(unit="mol/l") = 0.848 "Nominal concentration";
  parameter SI.Temperature T0 = 308.5 "Nominal temperature";
  parameter Real a1_inv =  0.2674 "Process parameter of inverse plant model (see references in help)";
  parameter Real a21_inv = 1.815 "Process parameter of inverse plant model (see references in help)";
  parameter Real a22_inv = 0.4682 "Process parameter of inverse plant model (see references in help)";
  parameter Real b_inv =   1.5476 "Process parameter of inverse plant model (see references in help)";
  parameter Real k0_inv =  1.05e14 "Process parameter of inverse plant model (see references in help)";
  parameter Real eps = 34.2894 "Process parameter (see references in help)";
  parameter Real x10 = 0.42 "Relative offset between nominal concentration and initial concentration";
  parameter Real x20 = 0.01 "Relative offset between nominal temperature and initial temperature";
  parameter Real u0 = -0.0224 "Relative offset between initial cooling temperature and nominal temperature";
  final parameter Real c_start(unit="mol/l") = c0*(1-x10) "Initial concentration";
  final parameter SI.Temperature T_start = T0*(1+x20) "Initial temperature";
  final parameter Real c_high_start(unit="mol/l") = c0*(1-0.72) "Reference concentration";
  final parameter Real T_c_start = T0*(1+u0) "Initial cooling temperature";
  parameter Real pro=1.5 "Deviations of plant to inverse plant parameters";
  final parameter Real a1=a1_inv*pro "Process parameter of plant model (see references in help)";
  final parameter Real a21=a21_inv*pro "Process parameter of plant model (see references in help)";
  final parameter Real a22=a22_inv*pro "Process parameter of plant model (see references in help)";
  final parameter Real b=b_inv*pro "Process parameter of plant model (see references in help)";
  final parameter Real k0=k0_inv*pro "Process parameter of plant model (see references in help)";
  Clocked.Examples.Systems.Utilities.ComponentsMixingUnit.MixingUnit invMixingUnit(
    c0=c0,
    T0=T0,
    a1=a1_inv,
    a21=a21_inv,
    a22=a22_inv,
    b=b_inv,
    k0=k0_inv,
    eps=eps,
    c(start=c_start, fixed=true),
    T(start=T_start,
      fixed=true,
      stateSelect=StateSelect.always),
    T_c(start=T_c_start))
    annotation (Placement(transformation(extent={{-12,14},{-32,34}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{40,-18},{56,-2}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints
    annotation (Placement(transformation(extent={{-54,8},{-2,40}})));
  Clocked.Examples.Systems.Utilities.ComponentsMixingUnit.MixingUnit mixingUnit(
    c(start=c_start, fixed=true),
    T(start=T_start, fixed=true),
    c0=c0,
    T0=T0,
    a1=a1,
    a21=a21,
    a22=a22,
    b=b,
    k0=k0,
    eps=eps)
    annotation (Placement(transformation(extent={{88,-20},{108,0}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-24,-20},{-4,0}})));
  Modelica.Blocks.Math.Gain gain(k=20) annotation (Placement(transformation(
          extent={{4,-20},{24,0}})));

  Utilities.ComponentsMixingUnit.CriticalDamping filter(
    n=3,
    f=freq,
    x(start={0.49,0.49,0.49}, fixed={true,false,false}))
    annotation (Placement(transformation(extent={{-86,14},{-66,34}})));
  Clocked.RealSignals.Sampler.Hold hold1(y_start=0)
    annotation (Placement(transformation(extent={{66,-16},{78,-4}})));
  Clocked.RealSignals.Sampler.Sample sample1
    annotation (Placement(transformation(extent={{80,-40},{68,-28}})));
  Clocked.ClockSignals.Clocks.PeriodicRealClock periodicClock1(
    useSolver=true,
    period=1,
    solverMethod="ExplicitEuler")
    annotation (Placement(transformation(extent={{-134,-26},{-122,-14}})));
  Modelica.Blocks.Sources.Step step(height=c_high_start - c_start, offset=
        c_start)
    annotation (Placement(transformation(extent={{-136,14},{-116,34}})));
  RealSignals.Sampler.SampleClocked  sample2
    annotation (Placement(transformation(extent={{-108,18},{-96,30}})));
equation
  connect(feedback.y, gain.u) annotation (Line(points={{-5,-10},{-5,-10},
          {2,-10}},
        color={0,0,127}));
  connect(gain.y, add.u2) annotation (Line(
      points={{25,-10},{32,-10},{32,-14.8},{38.4,-14.8}},
      color={0,0,127}));
  connect(inverseBlockConstraints.y2, invMixingUnit.T_c) annotation (Line(
      points={{-5.9,24},{-10,24}},
      color={0,0,127}));
  connect(invMixingUnit.c, inverseBlockConstraints.u2) annotation (Line(
      points={{-34,30},{-38,30},{-38,24},{-48.8,24}},
      color={0,0,127}));
  connect(invMixingUnit.T, feedback.u1) annotation (Line(
      points={{-34,18},{-46,18},{-46,-10},{-22,-10}},
      color={0,0,127}));
  connect(filter.y, inverseBlockConstraints.u1) annotation (Line(
      points={{-65,24},{-56.6,24}},
      color={0,0,127}));
  connect(hold1.y, mixingUnit.T_c) annotation (Line(
      points={{78.6,-10},{86,-10}},
      color={0,0,127}));
  connect(add.y, hold1.u) annotation (Line(
      points={{56.8,-10},{64.8,-10}},
      color={0,0,127}));
  connect(sample1.u, mixingUnit.T) annotation (Line(
      points={{81.2,-34},{116,-34},{116,-16},{110,-16}},
      color={0,0,127}));
  connect(sample1.y, feedback.u2) annotation (Line(
      points={{67.4,-34},{-14,-34},{-14,-18}},
      color={0,0,127}));
  connect(inverseBlockConstraints.y1, add.u1) annotation (Line(
      points={{-0.7,24},{30,24},{30,-5.2},{38.4,-5.2}},
      color={0,0,127}));
  connect(sample2.u,step. y) annotation (Line(
      points={{-109.2,24},{-115,24}},
      color={0,0,127}));
  connect(filter.u, sample2.y) annotation (Line(
      points={{-88,24},{-95.4,24}},
      color={0,0,127}));
  connect(periodicClock1.y, sample2.clock) annotation (Line(
      points={{-121.4,-20},{-102,-20},{-102,16.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -100},{120,100}}),      graphics={Rectangle(extent={{-90,44},
            {60,-44}}, lineColor={255,0,0}), Text(
        extent={{12,42},{58,34}},
        textColor={255,0,0},
        fillColor={0,0,255},
        fillPattern=FillPattern.Solid,
        textString="controller")}),
    experiment(StopTime=300),
    Documentation(info="<html>
<p>
Since a long time, Modelica is used to model advanced nonlinear control systems.
Especially, Modelica allows a semi-automatic treatment of inverse nonlinear
plant models. In the fundamental article (Looye et.al. 2005, see
<a href=\"modelica://Modelica.Clocked.UsersGuide.Literature\">Literature</a> or
<a href=\"https://www.modelica.org/events/Conference2005/online_proceedings/Session3/Session3c3.pdf\">Download</a>)
this approach is described and several controller structures are presented to
utilize an inverse plant model in the controller. This approach is attractive
because it results in a systematic procedure to design a controller for the
whole operating range of a plant. This is in contrast to standard controller
design techniques that usually design a linear controller for a plant model
that is linearized at a specific operating point. Therefore the operating range of such controllers is inherently limited.
</p>

<p>
Up to Modelica 3.2, controllers with inverse plant models can only be
defined as continuous-time systems. Via the export mechanism of a Modelica tool
they could be exported with solvers embedded in the code and then used as
sampled data system in other environments. However, it is not possible
to re-import the sampled data system to Modelica.
</p>

<p>
The synchronous features of Modelica 3.3 together with the
Modelica.Clocked library offer now completely new possibilities,
so that the inverse model can be designed and evaluated as sampled data
system within Modelica and a Modelica simulation environment.
This approach is shown at hand of a simple example using
a nonlinear plant model of a
mixing unit (F&ouml;llinger O. (1998): Nichtlineare Regelungen I,
Oldenbourg Verlag, 8. Auflage, page 279) and utilizing this plant
model as nonlinear feed-forward controller according to (Looye et.al. 2005):
</p>

<p>
A substance A is flowing continuously into a mixing reactor.
Due to a catalyst, the substance reacts and splits into several base
substances that are continuously removed. The reaction generates
energy and therefore the reactor is cooled with a cooling medium.
The cooling temperature T_c(t) in [K] is the primary actuation signal.
Substance A is described by its concentration c(t) in [mol/l] and
its temperature T(t) in [K].
The concentration c(t) is the signal to be primarily controlled
and the temperature T(t) is the signal that is measured.
These equations are collected together in input/output block
<a href=\"modelica://Modelica.Clocked.Examples.Systems.Utilities.ComponentsMixingUnit.MixingUnit\">Utilities.ComponentsMixingUnit.MixingUnit</a>.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/ControlledMixingUnit_PlantModel.png\" alt=\"ControlledMixingUnit_PlantModel.png\">
</div>

<p>
The design of the control system proceeds now in the following steps:
</p>

<h4>Pre-Filter</h4>
<p>
Inverting a model usually means that equations need to be symbolically
differentiated and that higher derivatives of the inputs are needed
(that are usually not available). One approach is to filter the inputs,
so that a Modelica tool can determine the derivatives of the filtered
input from the filter states. The minimum needed filter order is determined
by first inverting the continuous-time plant model from the variable
to be primarily controlled (here: \"c\") to the actuator input
(here: \"T_c\"). This is performed with the help of block
<a href=\"modelica://Modelica.Blocks.Math.InverseBlockConstraints\">Modelica.Blocks.Math.InverseBlockConstraints</a>
that allows connecting an external input to an output
in the pre-filter design block
<a href=\"modelica://Modelica.Clocked.Examples.Systems.Utilities.ComponentsMixingUnit.FilterOrder\">Utilities.ComponentsMixingUnit.FilterOrder</a>:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/ControlledMixingUnit_FilterDesign.png\" alt=\"ControlledMixingUnit_FilterDesign.png\">
</div>

<p>
Translating this
model will generate the continuous-time inverse plant model.
However, a Modelica tool will give an error message that it
has to differentiate the model, but this requires the
<strong>second derivative</strong> of the external input c_ref and this derivative
is not available. The conclusion is that a low pass filter of at
least second order has to be connected between c_ref and c, for example
<a href=\"modelica://Modelica.Blocks.Continuous.Filter\">Modelica.Blocks.Continuous.Filter</a>. Only filter types should be used that do not have \"vibrations\" in the time domain for
a step input. Therefore, parameter <strong>analogFilter</strong> of the component should be
selected as <strong>CriticalDamping</strong> (= only real poles), or
<strong>Bessel</strong> (= nearly no vibrations, but steeper frequency response as
CriticalDamping). The cut-off frequency <strong>f_cut</strong> is manually
selected by simulations of the closed loop system. In the example,
a CriticalDamping filter of third order (the third order is selected to
get smoother signals) and a cut-off frequency of 1/300 Hz is used.
</p>

<h4>Design of Controller</h4>
<p>
The controller for the mixing unit is shown in the diagram layer of block
at hand, as
well as in the following figure:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/ControlledMixingUnit_Controller.png\" alt=\"ControlledMixingUnit_Controller.png\">
</div>

<p>
It consists of the filter discussed above. The input to the filter is the reference
concentration which is filtered by the low pass filter. The output of the filter
is used as input to the concentration c in the inverse plant model.
This model computes the desired cooling temperature T_c (which is used
as desired cooling temperature at the output of the controller)
and the desired temperature T (which is used as desired value for
the feedback controller). This part of the control system is the
\"feed-forward\" part that computes the desired actuator signal.
As feedback controller a simple P-Controller with one gain is used.
</p>

<p>
This controller could be defined as continuous-time system in previous Modelica
versions. However, with Modelica 3.3 it is now also possible to define the
controller as sampled data system. For this, the two inputs are sampled
(sample1 and sample2) and the actuator output is hold (hold1).
The controller partition is then associated with a periodic clock
(via sample2) that has a sample period of 1 s and a
solverMethod = \"ExplicitEuler\". Since the controller partition is a
continuous-time system, it is discretized and solved with an explicit
Euler method at every clock tick (by integrating from the previous to
the actual time instant of the clock).
</p>

<h4>Simulation Results</h4>
<p>
The controller works perfectly if the same parameters for the plant
and the inverse plant model are used (follows perfectly the filtered reference
concentration). Changing all parameters of the inverse plant model by 50 %
(with exception of parameter <strong>e</strong> since the plant is very sensitive to it)
still results in a reasonable control behavior as shown in the next two figures:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/ControlledMixingUnit_Result.png\" alt=\"ControlledMixingUnit_Result.png\">
</div>

<p>
The green curve in the upper window is the (clocked) output of the filter,
that is, it is the desired concentration. The red curve in the upper window is the
concentration of model mixingUnit, which is the concentration in the plant.
Obviously, the concentration follows reasonably well the desired one. By using a more involved feedback controller, the control error could be substantially reduced.
</p>
</html>"));
end ControlledMixingUnit;
