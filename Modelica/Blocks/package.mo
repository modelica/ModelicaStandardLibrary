within Modelica;
package Blocks "Library of basic input/output control blocks (continuous, discrete, logical, table blocks)"

  extends Modelica.Icons.Package;
  import Modelica.Units.SI;

package Examples
  "Library of examples to demonstrate the usage of package Blocks"

  extends Modelica.Icons.ExamplesPackage;

  model PID_Controller
    "Demonstrates the usage of a Continuous.LimPID controller"
    extends Modelica.Icons.Example;
    parameter SI.Angle driveAngle=1.570796326794897
      "Reference distance to move";
    Modelica.Blocks.Continuous.LimPID PI(
      k=100,
      Ti=0.1,
      yMax=12,
      Ni=0.1,
      initType=Modelica.Blocks.Types.Init.SteadyState,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      limiter(u(start = 0)),
      Td=0.1) annotation (Placement(transformation(extent={{-56,-20},{-36,0}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(
      phi(fixed=true, start=0),
      J=1,
      a(fixed=true, start=0)) annotation (Placement(transformation(extent={{2,-20},
              {22,0}})));

    Modelica.Mechanics.Rotational.Sources.Torque torque annotation (Placement(
          transformation(extent={{-25,-20},{-5,0}})));
    Modelica.Mechanics.Rotational.Components.SpringDamper spring(
      c=1e4,
      d=100,
      stateSelect=StateSelect.prefer,
      w_rel(fixed=true)) annotation (Placement(transformation(extent={{32,-20},
              {52,0}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia2(J=2) annotation (
        Placement(transformation(extent={{60,-20},{80,0}})));
    Modelica.Blocks.Sources.KinematicPTP kinematicPTP(
      startTime=0.5,
      deltaq={driveAngle},
      qd_max={1},
      qdd_max={1}) annotation (Placement(transformation(extent={{-92,20},{-72,
              40}})));
    Modelica.Blocks.Continuous.Integrator integrator(initType=Modelica.Blocks.Types.Init.InitialState)
      annotation (Placement(transformation(extent={{-63,20},{-43,40}})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
        Placement(transformation(extent={{22,-50},{2,-30}})));
    Modelica.Mechanics.Rotational.Sources.ConstantTorque loadTorque(
        tau_constant=10, useSupport=false) annotation (Placement(transformation(
            extent={{98,-15},{88,-5}})));
  initial equation
    der(spring.w_rel) = 0;

  equation
    connect(spring.flange_b, inertia2.flange_a)
      annotation (Line(points={{52,-10},{60,-10}}));
    connect(inertia1.flange_b, spring.flange_a)
      annotation (Line(points={{22,-10},{32,-10}}));
    connect(torque.flange, inertia1.flange_a)
      annotation (Line(points={{-5,-10},{2,-10}}));
    connect(kinematicPTP.y[1], integrator.u)
      annotation (Line(points={{-71,30},{-65,30}}, color={0,0,127}));
    connect(speedSensor.flange, inertia1.flange_b)
      annotation (Line(points={{22,-40},{22,-10}}));
    connect(loadTorque.flange, inertia2.flange_b)
      annotation (Line(points={{88,-10},{80,-10}}));
    connect(PI.y, torque.tau)
      annotation (Line(points={{-35,-10},{-27,-10}}, color={0,0,127}));
    connect(speedSensor.w, PI.u_m)
      annotation (Line(points={{1,-40},{-46,-40},{-46,-22}}, color={0,0,127}));
    connect(integrator.y, PI.u_s) annotation (Line(points={{-42,30},{-37,30},{-37,
            11},{-67,11},{-67,-10},{-58,-10}}, color={0,0,127}));
    annotation (
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(extent={{-99,48},{-32,8}}, lineColor={255,0,0}),
          Text(
            extent={{-98,59},{-31,51}},
            textColor={255,0,0},
            textString="reference speed generation"),
          Text(
            extent={{-98,-46},{-60,-52}},
            textColor={255,0,0},
            textString="PI controller"),
          Line(
            points={{-76,-44},{-57,-23}},
            color={255,0,0},
            arrow={Arrow.None,Arrow.Filled}),
          Rectangle(extent={{-25,6},{99,-50}}, lineColor={255,0,0}),
          Text(
            extent={{4,14},{71,7}},
            textColor={255,0,0},
            textString="plant (simple drive train)")}),
      experiment(StopTime=4),
      Documentation(info="<html>

<p>
This is a simple drive train controlled by a PID controller:
</p>

<ul>
<li> The two blocks \"kinematic_PTP\" and \"integrator\" are used to generate
     the reference speed (= constant acceleration phase, constant speed phase,
     constant deceleration phase until inertia is at rest). To check
     whether the system starts in steady state, the reference speed is
     zero until time = 0.5 s and then follows the sketched trajectory.</li>

<li> The block \"PI\" is an instance of \"Blocks.Continuous.LimPID\" which is
     a PID controller where several practical important aspects, such as
     anti-windup-compensation has been added. In this case, the control block
     is used as PI controller.</li>

<li> The output of the controller is a torque that drives a motor inertia
     \"inertia1\". Via a compliant spring/damper component, the load
     inertia \"inertia2\" is attached. A constant external torque of 10 Nm
     is acting on the load inertia.</li>
</ul>

<p>
The PI controller is initialized in steady state (initType=SteadyState)
and the drive shall also be initialized in steady state.
However, it is not possible to initialize \"inertia1\" in SteadyState, because
\"der(inertia1.phi)=inertia1.w=0\" is an input to the PI controller that
defines that the derivative of the integrator state is zero (= the same
condition that was already defined by option SteadyState of the PI controller).
Furthermore, one initial condition is missing, because the absolute position
of inertia1 or inertia2 is not defined. The solution shown in this examples is
to initialize the angle and the angular acceleration of \"inertia1\".
</p>

<p>
In the following figure, results of a typical simulation are shown:
</p>

<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/PID_controller.png\"
     alt=\"PID_controller.png\"><br>

<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/PID_controller2.png\"
     alt=\"PID_controller2.png\">

<p>
In the upper figure the reference speed (= integrator.y) and
the actual speed (= inertia1.w) are shown. As can be seen,
the system initializes in steady state, since no transients
are present. The inertia follows the reference speed quite good
until the end of the constant speed phase. Then there is a deviation.
In the lower figure the reason can be seen: The output of the
controller (PI.y) is in its limits. The anti-windup compensation
works reasonably, since the input to the limiter (PI.limiter.u)
is forced back to its limit after a transient phase.
</p>

</html>"));
  end PID_Controller;

  model Filter "Demonstrates the Continuous.Filter block with various options"
    extends Modelica.Icons.Example;
    parameter Integer order=3 "Number of order of filter";
    parameter SI.Frequency f_cut=2 "Cut-off frequency";
    parameter Modelica.Blocks.Types.FilterType filterType=Modelica.Blocks.Types.FilterType.LowPass
      "Type of filter (LowPass/HighPass)";
    parameter Modelica.Blocks.Types.Init init=Modelica.Blocks.Types.Init.SteadyState
      "Type of initialization (no init/steady state/initial state/initial output)";
    parameter Boolean normalized=true "= true, if amplitude at f_cut = -3db, otherwise unmodified filter";

    Modelica.Blocks.Sources.Step step(startTime=0.1, offset=0.1)
      annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
    Modelica.Blocks.Continuous.Filter CriticalDamping(
      analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
      normalized=normalized,
      init=init,
      filterType=filterType,
      order=order,
      f_cut=f_cut,
      f_min=0.8*f_cut)
      annotation (Placement(transformation(extent={{-20,40},{0,60}})));
    Modelica.Blocks.Continuous.Filter Bessel(
      normalized=normalized,
      analogFilter=Modelica.Blocks.Types.AnalogFilter.Bessel,
      init=init,
      filterType=filterType,
      order=order,
      f_cut=f_cut,
      f_min=0.8*f_cut)
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    Modelica.Blocks.Continuous.Filter Butterworth(
      normalized=normalized,
      analogFilter=Modelica.Blocks.Types.AnalogFilter.Butterworth,
      init=init,
      filterType=filterType,
      order=order,
      f_cut=f_cut,
      f_min=0.8*f_cut)
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
    Modelica.Blocks.Continuous.Filter ChebyshevI(
      normalized=normalized,
      analogFilter=Modelica.Blocks.Types.AnalogFilter.ChebyshevI,
      init=init,
      filterType=filterType,
      order=order,
      f_cut=f_cut,
      f_min=0.8*f_cut)
      annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));

  equation
    connect(step.y, CriticalDamping.u) annotation (Line(
        points={{-39,50},{-22,50}}, color={0,0,127}));
    connect(step.y, Bessel.u) annotation (Line(
        points={{-39,50},{-32,50},{-32,10},{-22,10}}, color={0,0,127}));
    connect(Butterworth.u, step.y) annotation (Line(
        points={{-22,-30},{-32,-30},{-32,50},{-39,50}}, color={0,0,127}));
    connect(ChebyshevI.u, step.y) annotation (Line(
        points={{-22,-70},{-32,-70},{-32,50},{-39,50}}, color={0,0,127}));
    annotation (
      experiment(StopTime=0.9),
      Documentation(info="<html>

<p>
This example demonstrates various options of the
<a href=\"modelica://Modelica.Blocks.Continuous.Filter\">Filter</a> block.
A step input starts at 0.1 s with an offset of 0.1, in order to demonstrate
the initialization options. This step input drives 4 filter blocks that
have identical parameters, with the only exception of the used analog filter type
(CriticalDamping, Bessel, Butterworth, Chebyshev of type I). All the main options
can be set via parameters and are then applied to all the 4 filters.
The default setting uses low pass filters of order 3 with a cut-off frequency of
2 Hz resulting in the following outputs:
</p>

<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Filter1.png\"
     alt=\"Filter1.png\">
</html>"));
  end Filter;

  model FilterWithDifferentiation
    "Demonstrates the use of low pass filters to determine derivatives of filters"
    extends Modelica.Icons.Example;
    parameter SI.Frequency f_cut=2 "Cut-off frequency";

    Modelica.Blocks.Sources.Step step(startTime=0.1, offset=0.1)
      annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
    Modelica.Blocks.Continuous.Filter Bessel(
      f_cut=f_cut,
      filterType=Modelica.Blocks.Types.FilterType.LowPass,
      order=3,
      analogFilter=Modelica.Blocks.Types.AnalogFilter.Bessel)
      annotation (Placement(transformation(extent={{-40,40},{-20,60}})));

    Continuous.Der der1
      annotation (Placement(transformation(extent={{-6,40},{14,60}})));
    Continuous.Der der2
      annotation (Placement(transformation(extent={{30,40},{50,60}})));
    Continuous.Der der3
      annotation (Placement(transformation(extent={{62,40},{82,60}})));
  equation
    connect(step.y, Bessel.u) annotation (Line(
        points={{-59,50},{-42,50}}, color={0,0,127}));
    connect(Bessel.y, der1.u) annotation (Line(
        points={{-19,50},{-8,50}}, color={0,0,127}));
    connect(der1.y, der2.u) annotation (Line(
        points={{15,50},{28,50}}, color={0,0,127}));
    connect(der2.y, der3.u) annotation (Line(
        points={{51,50},{60,50}}, color={0,0,127}));
    annotation (
      experiment(StopTime=0.9),
      Documentation(info="<html>

<p>
This example demonstrates that the output of the
<a href=\"modelica://Modelica.Blocks.Continuous.Filter\">Filter</a> block
can be differentiated up to the order of the filter. This feature can be
used in order to make an inverse model realizable or to \"smooth\" a potential
discontinuous control signal.
</p>

</html>"));
  end FilterWithDifferentiation;

  model FilterWithRiseTime
    "Demonstrates to use the rise time instead of the cut-off frequency to define a filter"
    import Modelica.Constants.pi;
    extends Modelica.Icons.Example;
    parameter Integer order=2 "Filter order";
    parameter SI.Time riseTime=2 "Time to reach the step input";

    Continuous.Filter filter_fac5(f_cut=5/(2*pi*riseTime), order=order)
      annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
    Sources.Step step(startTime=1)
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    Continuous.Filter filter_fac4(f_cut=4/(2*pi*riseTime), order=order)
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));
    Continuous.Filter filter_fac3(f_cut=3/(2*pi*riseTime), order=order)
      annotation (Placement(transformation(extent={{-20,62},{0,82}})));
  equation
    connect(step.y, filter_fac5.u) annotation (Line(
        points={{-39,30},{-30,30},{-30,-10},{-22,-10}}, color={0,0,127}));
    connect(step.y, filter_fac4.u) annotation (Line(
        points={{-39,30},{-22,30}}, color={0,0,127}));
    connect(step.y, filter_fac3.u) annotation (Line(
        points={{-39,30},{-30,30},{-30,72},{-22,72}}, color={0,0,127}));
    annotation (experiment(StopTime=4), Documentation(info="<html>
<p>
Filters are usually parameterized with the cut-off frequency.
Sometimes, it is more meaningful to parameterize a filter with its
rise time, i.e., the time it needs until the output reaches the end value
of a step input. This is performed with the formula:
</p>

<blockquote><pre>
f_cut = fac/(2*pi*riseTime);
</pre></blockquote>

<p>
where \"fac\" is typically 3, 4, or 5. The following image shows
the results of a simulation of this example model
(riseTime = 2 s, fac=3, 4, and 5):
</p>

<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/FilterWithRiseTime.png\"
     alt=\"FilterWithRiseTime.png\">

<p>
Since the step starts at 1 s, and the rise time is 2 s, the filter output y
shall reach the value of 1 after 1+2=3 s. Depending on the factor \"fac\" this is
reached with different precisions. This is summarized in the following table:
</p>

<blockquote><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr>
   <td>Filter order</td>
   <td>Factor fac</td>
   <td>Percentage of step value reached after rise time</td>
</tr>
<tr>
   <td align=\"center\">1</td>
   <td align=\"center\">3</td>
   <td align=\"center\">95.1 %</td>
</tr>
<tr>
   <td align=\"center\">1</td>
   <td align=\"center\">4</td>
   <td align=\"center\">98.2 %</td>
</tr>
<tr>
   <td align=\"center\">1</td>
   <td align=\"center\">5</td>
   <td align=\"center\">99.3 %</td>
</tr>

<tr>
   <td align=\"center\">2</td>
   <td align=\"center\">3</td>
   <td align=\"center\">94.7 %</td>
</tr>
<tr>
   <td align=\"center\">2</td>
   <td align=\"center\">4</td>
   <td align=\"center\">98.6 %</td>
</tr>
<tr>
   <td align=\"center\">2</td>
   <td align=\"center\">5</td>
   <td align=\"center\">99.6 %</td>
</tr>
</table></blockquote>

</html>"));
  end FilterWithRiseTime;

  model SlewRateLimiter
    "Demonstrate usage of Nonlinear.SlewRateLimiter"
    extends Modelica.Icons.Example;
    parameter SI.Velocity vMax=2 "Max. velocity";
    parameter SI.Acceleration aMax=20 "Max. acceleration";
    SI.Position s=positionStep.y "Reference position";
    SI.Position sSmoothed=positionSmoothed.y "Smoothed position";
    SI.Velocity vLimited=limit_a.y "Limited velocity";
    SI.Acceleration aLimited=a.y "Limited acceleration";
    Modelica.Blocks.Sources.Step positionStep(startTime=0.1)
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    Modelica.Blocks.Nonlinear.SlewRateLimiter limit_v(
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      Rising=vMax,
      y_start=positionStep.offset,
      Td=0.0001)
      annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
    Modelica.Blocks.Continuous.Der v
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
    Modelica.Blocks.Nonlinear.SlewRateLimiter limit_a(
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0,
      Rising=20,
      Td=0.0001)
                annotation (Placement(transformation(extent={{10,-10},{30,10}})));
    Modelica.Blocks.Continuous.Integrator positionSmoothed(
      k=1,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=positionStep.offset)
      annotation (Placement(transformation(extent={{50,-10},{70,10}})));
    Modelica.Blocks.Continuous.Der a
      annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  equation
    connect(positionStep.y, limit_v.u)
      annotation (Line(points={{-59,0},{-52,0}}, color={0,0,127}));
    connect(limit_v.y, v.u)
      annotation (Line(points={{-29,0},{-22,0}}, color={0,0,127}));
    connect(v.y, limit_a.u)
      annotation (Line(points={{1,0},{8,0}}, color={0,0,127}));
    connect(limit_a.y, positionSmoothed.u)
      annotation (Line(points={{31,0},{39.5,0},{48,0}}, color={0,0,127}));
    connect(limit_a.y, a.u) annotation (Line(points={{31,0},{40,0},{40,-30},{48,-30}},
          color={0,0,127}));

    annotation (experiment(StopTime=1.0, Interval=0.001), Documentation(info="<html>
<p>
This example demonstrates how to use the Nonlinear.SlewRateLimiter block to limit a position step with regards to velocity and acceleration:
</p>
<ul>
<li> The Sources.Step block <code>positionStep</code> demands an unphysical position step.</li>
<li> The first SlewRateLimiter block  <code>limit_v</code> limits velocity.</li>
<li> The first Der block <code>v</code> calculates velocity from the smoothed position signal.</li>
<li> The second SlewRateLimiter block <code>limit_a</code> limits acceleration of the smoothed velocity signal.</li>
<li> The second Der block <code>a</code> calculates acceleration from the smoothed velocity signal.</li>
<li> The Integrator block <code>positionSmoothed</code> calculates smoothed position from the smoothed velocity signal.</li>
</ul>
<p>
A position controlled drive with limited velocity and limited acceleration (i.e. torque) is able to follow the smoothed reference position.
</p>
</html>"));
  end SlewRateLimiter;

  model InverseModel "Demonstrates the construction of an inverse model"
    extends Modelica.Icons.Example;

    Continuous.FirstOrder firstOrder1(
      k=1,
      T=0.3,
      initType=Modelica.Blocks.Types.Init.SteadyState)
      annotation (Placement(transformation(extent={{20,20},{0,40}})));
    Sources.Sine sine(
      f=2,
      offset=1,
      startTime=0.2)
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Math.InverseBlockConstraints inverseBlockConstraints
      annotation (Placement(transformation(extent={{-10,20},{30,40}})));
    Continuous.FirstOrder firstOrder2(
      k=1,
      T=0.3,
      initType=Modelica.Blocks.Types.Init.SteadyState)
      annotation (Placement(transformation(extent={{20,-20},{0,0}})));
    Math.Feedback feedback
      annotation (Placement(transformation(extent={{-40,0},{-60,-20}})));
    Continuous.CriticalDamping criticalDamping(n=1, f=50*sine.f)
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  equation
    connect(firstOrder1.y, inverseBlockConstraints.u2) annotation (Line(
        points={{-1,30},{-6,30}}, color={0,0,127}));
    connect(inverseBlockConstraints.y2, firstOrder1.u) annotation (Line(
        points={{27,30},{22,30}}, color={0,0,127}));
    connect(firstOrder2.y, feedback.u1) annotation (Line(
        points={{-1,-10},{-42,-10}}, color={0,0,127}));
    connect(sine.y, criticalDamping.u) annotation (Line(
        points={{-59,30},{-42,30}}, color={0,0,127}));
    connect(criticalDamping.y, inverseBlockConstraints.u1) annotation (Line(
        points={{-19,30},{-12,30}}, color={0,0,127}));
    connect(sine.y, feedback.u2) annotation (Line(
        points={{-59,30},{-50,30},{-50,-2}}, color={0,0,127}));
    connect(inverseBlockConstraints.y1, firstOrder2.u) annotation (Line(
        points={{31,30},{40,30},{40,-10},{22,-10}}, color={0,0,127}));
    annotation (Documentation(info="<html>
<p>
This example demonstrates how to construct an inverse model in Modelica
(for more details see <a href=\"https://www.modelica.org/events/Conference2005/online_proceedings/Session3/Session3c3.pdf\">Looye, Th&uuml;mmel, Kurze, Otter, Bals: Nonlinear Inverse Models for Control</a>).
</p>

<p>
For a linear, single input, single output system
</p>

<blockquote><pre>
y = n(s)/d(s) * u   // plant model
</pre></blockquote>

<p>
the inverse model is derived by simply exchanging the numerator and
the denominator polynomial:
</p>

<blockquote><pre>
u = d(s)/n(s) * y   // inverse plant model
</pre></blockquote>

<p>
If the denominator polynomial d(s) has a higher degree as the
numerator polynomial n(s) (which is usually the case for plant models),
then the inverse model is no longer proper, i.e., it is not causal.
To avoid this, an approximate inverse model is constructed by adding
a sufficient number of poles to the denominator of the inverse model.
This can be interpreted as filtering the desired output signal y:
</p>

<blockquote><pre>
u = d(s)/(n(s)*f(s)) * y  // inverse plant model with filtered y
</pre></blockquote>

<p>
With Modelica it is in principal possible to construct inverse models not only
for linear but also for non-linear models and in particular for every
Modelica model. The basic construction mechanism is explained at hand
of this example:
</p>

<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/InverseModelSchematic.png\"
     alt=\"InverseModelSchematic.png\">

<p>
Here the first order block \"firstOrder1\" shall be inverted. This is performed
by connecting its inputs and outputs with an instance of block
Modelica.Blocks.Math.<strong>InverseBlockConstraints</strong>. By this connection,
the inputs and outputs are exchanged. The goal is to compute the input of the
\"firstOrder1\" block so that its output follows a given sine signal.
For this, the sine signal \"sin\" is first filtered with a \"CriticalDamping\"
filter of order 1 and then the output of this filter is connected to the output
of the \"firstOrder1\" block (via the InverseBlockConstraints block, since
2 outputs cannot be connected directly together in a block diagram).
</p>

<p>
In order to check the inversion, the computed input of \"firstOrder1\" is used
as input in an identical block \"firstOrder2\". The output of \"firstOrder2\" should
be the given \"sine\" function. The difference is constructed with the \"feedback\"
block. Since the \"sine\" function is filtered, one cannot expect that this difference
is zero. The higher the cut-off frequency of the filter, the closer is the
agreement. A typical simulation result is shown in the next figure:
</p>

<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/InverseModel.png\"
     alt=\"InverseModel.png\">
</html>"), experiment(StopTime=1.0));
  end InverseModel;

  model ShowLogicalSources
    "Demonstrates the usage of logical sources together with their diagram animation"
    extends Modelica.Icons.Example;
    Sources.BooleanTable table(table={2,4,6,8}) annotation (Placement(
          transformation(extent={{-60,-100},{-40,-80}})));
    Sources.BooleanConstant const annotation (Placement(transformation(extent={
              {-60,60},{-40,80}})));
    Sources.BooleanStep step(startTime=4) annotation (Placement(transformation(
            extent={{-60,20},{-40,40}})));
    Sources.BooleanPulse pulse(period=1.5) annotation (Placement(transformation(
            extent={{-60,-20},{-40,0}})));

    Sources.SampleTrigger sample(period=0.5) annotation (Placement(
          transformation(extent={{-60,-60},{-40,-40}})));
    Sources.BooleanExpression booleanExpression(y=pulse.y and step.y)
      annotation (Placement(transformation(extent={{20,20},{80,40}})));
    annotation (experiment(StopTime=10), Documentation(info="<html>
<p>
This simple example demonstrates the logical sources in
<a href=\"modelica://Modelica.Blocks.Sources\">Modelica.Blocks.Sources</a> and demonstrate
their diagram animation (see \"small circle\" close to the output connector).
The \"booleanExpression\" source shows how a logical expression can be defined
in its parameter menu referring to variables available on this level of the
model.
</p>

</html>"));
  end ShowLogicalSources;

  model LogicalNetwork1 "Demonstrates the usage of logical blocks"

    extends Modelica.Icons.Example;
    Sources.BooleanTable table2(table={1,3,5,7}) annotation (Placement(
          transformation(extent={{-80,-20},{-60,0}})));
    Sources.BooleanTable table1(table={2,4,6,8}) annotation (Placement(
          transformation(extent={{-80,20},{-60,40}})));
    Logical.Not Not1 annotation (Placement(transformation(extent={{-40,-20},{-20,
              0}})));

    Logical.And And1 annotation (Placement(transformation(extent={{0,-20},{20,0}})));
    Logical.Or Or1 annotation (Placement(transformation(extent={{40,20},{60,40}})));
    Logical.Pre Pre1 annotation (Placement(transformation(extent={{-40,-60},{-20,
              -40}})));
  equation

    connect(table2.y, Not1.u)
      annotation (Line(points={{-59,-10},{-42,-10}}, color={255,0,255}));
    connect(And1.y, Or1.u2) annotation (Line(points={{21,-10},{28,-10},{28,22},
            {38,22}}, color={255,0,255}));
    connect(table1.y, Or1.u1)
      annotation (Line(points={{-59,30},{38,30}}, color={255,0,255}));
    connect(Not1.y, And1.u1)
      annotation (Line(points={{-19,-10},{-2,-10}}, color={255,0,255}));
    connect(Pre1.y, And1.u2) annotation (Line(points={{-19,-50},{-10,-50},{-10,
            -18},{-2,-18}}, color={255,0,255}));
    connect(Or1.y, Pre1.u) annotation (Line(points={{61,30},{68,30},{68,-70},{-60,
            -70},{-60,-50},{-42,-50}}, color={255,0,255}));

    annotation (experiment(StopTime=10), Documentation(info="<html>
<p>
This example demonstrates a network of logical blocks. Note, that
the Boolean values of the input and output signals are visualized
in the diagram animation, by the small \"circles\" close to the connectors.
If a \"circle\" is \"white\", the signal is <strong>false</strong>. It a
\"circle\" is \"green\", the signal is <strong>true</strong>.
</p>
</html>"));
  end LogicalNetwork1;

model RealNetwork1 "Demonstrates the usage of blocks from Modelica.Blocks.Math"

  extends Modelica.Icons.Example;

  Modelica.Blocks.Math.MultiSum add(nu=2)
    annotation (Placement(transformation(extent={{-14,64},{-2,76}})));
  Sources.Sine sine(amplitude=3, f=0.1)
    annotation (Placement(transformation(extent={{-96,60},{-76,80}})));
  Sources.Step integerStep(height=3, startTime=2)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Sources.Constant integerConstant(k=1)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Interaction.Show.RealValue showValue
    annotation (Placement(transformation(extent={{66,60},{86,80}})));
  Math.MultiProduct product(nu=2)
    annotation (Placement(transformation(extent={{6,24},{18,36}})));
  Modelica.Blocks.Interaction.Show.RealValue showValue1(significantDigits=2)
    annotation (Placement(transformation(extent={{64,20},{84,40}})));
  Sources.BooleanPulse booleanPulse1(period=1)
    annotation (Placement(transformation(extent={{-12,-30},{8,-10}})));
  Math.MultiSwitch multiSwitch(
    nu=2,
    expr={4,6},
    y_default=2)
    annotation (Placement(transformation(extent={{28,-60},{68,-40}})));
  Sources.BooleanPulse booleanPulse2(period=2, width=80)
    annotation (Placement(transformation(extent={{-12,-70},{8,-50}})));
  Modelica.Blocks.Interaction.Show.RealValue showValue3(
    use_numberPort=false,
    number=multiSwitch.y,
    significantDigits=1)
    annotation (Placement(transformation(extent={{40,-84},{60,-64}})));
  Math.LinearDependency linearDependency1(
    y0=1,
    k1=2,
    k2=3) annotation (Placement(transformation(extent={{40,80},{60,100}})));
  Math.MinMax minMax(nu=2)
    annotation (Placement(transformation(extent={{58,-16},{78,4}})));
equation
  connect(booleanPulse1.y, multiSwitch.u[1]) annotation (Line(
      points={{9,-20},{18,-20},{18,-48},{28,-48},{28,-48.5}}, color={255,0,255}));
  connect(booleanPulse2.y, multiSwitch.u[2]) annotation (Line(
      points={{9,-60},{18,-60},{18,-52},{28,-52},{28,-51.5}}, color={255,0,255}));
  connect(sine.y, add.u[1]) annotation (Line(
      points={{-75,70},{-46.5,70},{-46.5,72.1},{-14,72.1}}, color={0,0,127}));
  connect(integerStep.y, add.u[2]) annotation (Line(
      points={{-39,40},{-28,40},{-28,67.9},{-14,67.9}}, color={0,0,127}));
  connect(add.y, showValue.numberPort) annotation (Line(
      points={{-0.98,70},{64.5,70}}, color={0,0,127}));
  connect(integerStep.y, product.u[1]) annotation (Line(
      points={{-39,40},{-20,40},{-20,32.1},{6,32.1}}, color={0,0,127}));
  connect(integerConstant.y, product.u[2]) annotation (Line(
      points={{-39,0},{-20,0},{-20,27.9},{6,27.9}}, color={0,0,127}));
  connect(product.y, showValue1.numberPort) annotation (Line(
      points={{19.02,30},{62.5,30}}, color={0,0,127}));
  connect(add.y, linearDependency1.u1) annotation (Line(
      points={{-0.98,70},{20,70},{20,96},{38,96}}, color={0,0,127}));
  connect(product.y, linearDependency1.u2) annotation (Line(
      points={{19.02,30},{30,30},{30,84},{38,84}}, color={0,0,127}));
  connect(add.y, minMax.u[1]) annotation (Line(
      points={{-0.98,70},{48,70},{48,-2.5},{58,-2.5}}, color={0,0,127}));
  connect(product.y, minMax.u[2]) annotation (Line(
      points={{19.02,30},{40,30},{40,-9.5},{58,-9.5}}, color={0,0,127}));
  annotation (
    experiment(StopTime=10),
    Documentation(info="<html>
<p>
This example demonstrates a network of mathematical Real blocks.
from package <a href=\"modelica://Modelica.Blocks.Math\">Modelica.Blocks.Math</a>.
Note, that
</p>

<ul>
<li> at the right side of the model, several Math.ShowValue blocks
     are present, that visualize the actual value of the respective Real
     signal in a diagram animation.</li>

<li> the Boolean values of the input and output signals are visualized
     in the diagram animation, by the small \"circles\" close to the connectors.
     If a \"circle\" is \"white\", the signal is <strong>false</strong>. If a
     \"circle\" is \"green\", the signal is <strong>true</strong>.</li>
</ul>

</html>"));
end RealNetwork1;

  model IntegerNetwork1
    "Demonstrates the usage of blocks from Modelica.Blocks.MathInteger"

    extends Modelica.Icons.Example;

    MathInteger.Sum sum(nu=3)
      annotation (Placement(transformation(extent={{-14,64},{-2,76}})));
    Sources.Sine sine(amplitude=3, f=0.1)
      annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
    Math.RealToInteger realToInteger
      annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
    Sources.IntegerStep integerStep(height=3, startTime=2)
      annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
    Sources.IntegerConstant integerConstant(k=1)
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    Modelica.Blocks.Interaction.Show.IntegerValue showValue
      annotation (Placement(transformation(extent={{40,60},{60,80}})));
    MathInteger.Product product(nu=2)
      annotation (Placement(transformation(extent={{16,24},{28,36}})));
    Modelica.Blocks.Interaction.Show.IntegerValue showValue1
      annotation (Placement(transformation(extent={{40,20},{60,40}})));
    MathInteger.TriggeredAdd triggeredAdd(use_reset=false, use_set=false)
      annotation (Placement(transformation(extent={{16,-6},{28,6}})));
    Sources.BooleanPulse booleanPulse1(period=1)
      annotation (Placement(transformation(extent={{-12,-30},{8,-10}})));
    Modelica.Blocks.Interaction.Show.IntegerValue showValue2
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    MathInteger.MultiSwitch multiSwitch1(
      nu=2,
      expr={4,6},
      y_default=2,
      use_pre_as_default=false)
      annotation (Placement(transformation(extent={{28,-60},{68,-40}})));
    Sources.BooleanPulse booleanPulse2(period=2, width=80)
      annotation (Placement(transformation(extent={{-12,-70},{8,-50}})));
    Modelica.Blocks.Interaction.Show.IntegerValue showValue3(use_numberPort=
          false, number=multiSwitch1.y)
      annotation (Placement(transformation(extent={{40,-84},{60,-64}})));
  equation
    connect(sine.y, realToInteger.u) annotation (Line(
        points={{-79,70},{-62,70}}, color={0,0,127}));
    connect(realToInteger.y, sum.u[1]) annotation (Line(
        points={{-39,70},{-32,70},{-32,72},{-14,72},{-14,72.8}}, color={255,127,0}));
    connect(integerStep.y, sum.u[2]) annotation (Line(
        points={{-39,40},{-28,40},{-28,70},{-14,70}}, color={255,127,0}));
    connect(integerConstant.y, sum.u[3]) annotation (Line(
        points={{-39,0},{-22,0},{-22,67.2},{-14,67.2}}, color={255,127,0}));
    connect(sum.y, showValue.numberPort) annotation (Line(
        points={{-1.1,70},{38.5,70}}, color={255,127,0}));
    connect(sum.y, product.u[1]) annotation (Line(
        points={{-1.1,70},{4,70},{4,32.1},{16,32.1}}, color={255,127,0}));
    connect(integerStep.y, product.u[2]) annotation (Line(
        points={{-39,40},{-8,40},{-8,27.9},{16,27.9}}, color={255,127,0}));
    connect(product.y, showValue1.numberPort) annotation (Line(
        points={{28.9,30},{38.5,30}}, color={255,127,0}));
    connect(integerConstant.y, triggeredAdd.u) annotation (Line(
        points={{-39,0},{13.6,0}}, color={255,127,0}));
    connect(booleanPulse1.y, triggeredAdd.trigger) annotation (Line(
        points={{9,-20},{18.4,-20},{18.4,-7.2}}, color={255,0,255}));
    connect(triggeredAdd.y, showValue2.numberPort) annotation (Line(
        points={{29.2,0},{38.5,0}}, color={255,127,0}));
    connect(booleanPulse1.y, multiSwitch1.u[1]) annotation (Line(
        points={{9,-20},{18,-20},{18,-48},{28,-48},{28,-48.5}}, color={255,0,255}));
    connect(booleanPulse2.y, multiSwitch1.u[2]) annotation (Line(
        points={{9,-60},{18,-60},{18,-52},{28,-52},{28,-51.5}}, color={255,0,255}));
    annotation (experiment(StopTime=10), Documentation(info="<html>
<p>
This example demonstrates a network of Integer blocks.
from package <a href=\"modelica://Modelica.Blocks.MathInteger\">Modelica.Blocks.MathInteger</a>.
Note, that
</p>

<ul>
<li> at the right side of the model, several MathInteger.ShowValue blocks
     are present, that visualize the actual value of the respective Integer
     signal in a diagram animation.</li>

<li> the Boolean values of the input and output signals are visualized
     in the diagram animation, by the small \"circles\" close to the connectors.
     If a \"circle\" is \"white\", the signal is <strong>false</strong>. If a
     \"circle\" is \"green\", the signal is <strong>true</strong>.</li>

</ul>

</html>"));
  end IntegerNetwork1;

  model BooleanNetwork1
    "Demonstrates the usage of blocks from Modelica.Blocks.MathBoolean"

    extends Modelica.Icons.Example;

    Modelica.Blocks.Interaction.Show.BooleanValue showValue
      annotation (Placement(transformation(extent={{-36,74},{-16,94}})));
    MathBoolean.And and1(nu=3)
      annotation (Placement(transformation(extent={{-58,64},{-46,76}})));
    Sources.BooleanPulse booleanPulse1(width=20, period=1)
      annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
    Sources.BooleanPulse booleanPulse2(period=1, width=80)
      annotation (Placement(transformation(extent={{-100,-4},{-80,16}})));
    Sources.BooleanStep booleanStep(startTime=1.5)
      annotation (Placement(transformation(extent={{-100,28},{-80,48}})));
    MathBoolean.Or or1(nu=2)
      annotation (Placement(transformation(extent={{-28,62},{-16,74}})));
    MathBoolean.Xor xor1(nu=2)
      annotation (Placement(transformation(extent={{-2,60},{10,72}})));
    Modelica.Blocks.Interaction.Show.BooleanValue showValue2
      annotation (Placement(transformation(extent={{-2,74},{18,94}})));
    Modelica.Blocks.Interaction.Show.BooleanValue showValue3
      annotation (Placement(transformation(extent={{24,56},{44,76}})));
    MathBoolean.Nand nand1(nu=2)
      annotation (Placement(transformation(extent={{22,40},{34,52}})));
    MathBoolean.Nor or2(nu=2)
      annotation (Placement(transformation(extent={{46,38},{58,50}})));
    Modelica.Blocks.Interaction.Show.BooleanValue showValue4
      annotation (Placement(transformation(extent={{90,34},{110,54}})));
    MathBoolean.Not nor1
      annotation (Placement(transformation(extent={{68,40},{76,48}})));
    MathBoolean.OnDelay onDelay(delayTime=1)
      annotation (Placement(transformation(extent={{-56,-94},{-48,-86}})));
    MathBoolean.RisingEdge rising
      annotation (Placement(transformation(extent={{-56,-15},{-48,-7}})));
    MathBoolean.MultiSwitch set1(nu=2, expr={false,true})
      annotation (Placement(transformation(extent={{-30,-23},{10,-3}})));
    MathBoolean.FallingEdge falling
      annotation (Placement(transformation(extent={{-56,-32},{-48,-24}})));
    Sources.BooleanTable booleanTable(table={2,4,6,6.5,7,9,11})
      annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
    MathBoolean.ChangingEdge changing
      annotation (Placement(transformation(extent={{-56,-59},{-48,-51}})));
    MathInteger.TriggeredAdd triggeredAdd
      annotation (Placement(transformation(extent={{14,-56},{26,-44}})));
    Sources.IntegerConstant integerConstant(k=2)
      annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
    Modelica.Blocks.Interaction.Show.IntegerValue showValue1
      annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
    Modelica.Blocks.Interaction.Show.BooleanValue showValue5
      annotation (Placement(transformation(extent={{24,-23},{44,-3}})));
    Modelica.Blocks.Interaction.Show.BooleanValue showValue6
      annotation (Placement(transformation(extent={{-32,-100},{-12,-80}})));
    Logical.RSFlipFlop rSFlipFlop
      annotation (Placement(transformation(extent={{70,-90},{90,-70}})));
    Sources.SampleTrigger sampleTriggerSet(period=0.5, startTime=0)
      annotation (Placement(transformation(extent={{40,-76},{54,-62}})));
    Sources.SampleTrigger sampleTriggerReset(period=0.5, startTime=0.3)
      annotation (Placement(transformation(extent={{40,-98},{54,-84}})));
  equation
    connect(booleanPulse1.y, and1.u[1]) annotation (Line(
        points={{-79,70},{-68,70},{-68,72.8},{-58,72.8}}, color={255,0,255}));
    connect(booleanStep.y, and1.u[2]) annotation (Line(
        points={{-79,38},{-64,38},{-64,70},{-58,70}}, color={255,0,255}));
    connect(booleanPulse2.y, and1.u[3]) annotation (Line(
        points={{-79,6},{-62,6},{-62,67.2},{-58,67.2}}, color={255,0,255}));
    connect(and1.y, or1.u[1]) annotation (Line(
        points={{-45.1,70},{-36.4,70},{-36.4,70.1},{-28,70.1}}, color={255,0,255}));
    connect(booleanPulse2.y, or1.u[2]) annotation (Line(
        points={{-79,6},{-40,6},{-40,65.9},{-28,65.9}}, color={255,0,255}));
    connect(or1.y, xor1.u[1]) annotation (Line(
        points={{-15.1,68},{-8,68},{-8,68.1},{-2,68.1}}, color={255,0,255}));
    connect(booleanPulse2.y, xor1.u[2]) annotation (Line(
        points={{-79,6},{-12,6},{-12,63.9},{-2,63.9}}, color={255,0,255}));
    connect(and1.y, showValue.activePort) annotation (Line(
        points={{-45.1,70},{-42,70},{-42,84},{-37.5,84}}, color={255,0,255}));
    connect(or1.y, showValue2.activePort) annotation (Line(
        points={{-15.1,68},{-12,68},{-12,84},{-3.5,84}}, color={255,0,255}));
    connect(xor1.y, showValue3.activePort) annotation (Line(
        points={{10.9,66},{22.5,66}}, color={255,0,255}));
    connect(xor1.y, nand1.u[1]) annotation (Line(
        points={{10.9,66},{16,66},{16,48.1},{22,48.1}}, color={255,0,255}));
    connect(booleanPulse2.y, nand1.u[2]) annotation (Line(
        points={{-79,6},{16,6},{16,44},{22,44},{22,43.9}}, color={255,0,255}));
    connect(nand1.y, or2.u[1]) annotation (Line(
        points={{34.9,46},{46,46},{46,46.1}}, color={255,0,255}));
    connect(booleanPulse2.y, or2.u[2]) annotation (Line(
        points={{-79,6},{42,6},{42,41.9},{46,41.9}}, color={255,0,255}));
    connect(or2.y, nor1.u) annotation (Line(
        points={{58.9,44},{66.4,44}}, color={255,0,255}));
    connect(nor1.y, showValue4.activePort) annotation (Line(
        points={{76.8,44},{88.5,44}}, color={255,0,255}));
    connect(booleanPulse2.y, rising.u) annotation (Line(
        points={{-79,6},{-62,6},{-62,-11},{-57.6,-11}}, color={255,0,255}));
    connect(rising.y, set1.u[1]) annotation (Line(
        points={{-47.2,-11},{-38.6,-11},{-38.6,-11.5},{-30,-11.5}}, color={255,0,255}));
    connect(falling.y, set1.u[2]) annotation (Line(
        points={{-47.2,-28},{-40,-28},{-40,-14.5},{-30,-14.5}}, color={255,0,255}));
    connect(booleanPulse2.y, falling.u) annotation (Line(
        points={{-79,6},{-62,6},{-62,-28},{-57.6,-28}}, color={255,0,255}));
    connect(booleanTable.y, onDelay.u) annotation (Line(
        points={{-79,-90},{-57.6,-90}}, color={255,0,255}));
    connect(booleanPulse2.y, changing.u) annotation (Line(
        points={{-79,6},{-62,6},{-62,-55},{-57.6,-55}}, color={255,0,255}));
    connect(integerConstant.y, triggeredAdd.u) annotation (Line(
        points={{1,-50},{11.6,-50}}, color={255,127,0}));
    connect(changing.y, triggeredAdd.trigger) annotation (Line(
        points={{-47.2,-55},{-30,-55},{-30,-74},{16.4,-74},{16.4,-57.2}}, color={255,0,255}));
    connect(triggeredAdd.y, showValue1.numberPort) annotation (Line(
        points={{27.2,-50},{38.5,-50}}, color={255,127,0}));
    connect(set1.y, showValue5.activePort) annotation (Line(
        points={{11,-13},{22.5,-13}}, color={255,0,255}));
    connect(onDelay.y, showValue6.activePort) annotation (Line(
        points={{-47.2,-90},{-33.5,-90}}, color={255,0,255}));
    connect(sampleTriggerSet.y, rSFlipFlop.S) annotation (Line(
        points={{54.7,-69},{60,-69},{60,-74},{68,-74}}, color={255,0,255}));
    connect(sampleTriggerReset.y, rSFlipFlop.R) annotation (Line(
        points={{54.7,-91},{60,-91},{60,-86},{68,-86}}, color={255,0,255}));
    annotation (experiment(StopTime=10), Documentation(info="<html>
<p>
This example demonstrates a network of Boolean blocks
from package <a href=\"modelica://Modelica.Blocks.MathBoolean\">Modelica.Blocks.MathBoolean</a>.
Note, that
</p>

<ul>
<li> at the right side of the model, several MathBoolean.ShowValue blocks
     are present, that visualize the actual value of the respective Boolean
     signal in a diagram animation (\"green\" means \"true\").</li>

<li> the Boolean values of the input and output signals are visualized
     in the diagram animation, by the small \"circles\" close to the connectors.
     If a \"circle\" is \"white\", the signal is <strong>false</strong>. If a
     \"circle\" is \"green\", the signal is <strong>true</strong>.</li>

</ul>

</html>"));
  end BooleanNetwork1;

  model Interaction1
    "Demonstrates the usage of blocks from Modelica.Blocks.Interaction.Show"

    extends Modelica.Icons.Example;

    Interaction.Show.IntegerValue integerValue
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    Sources.IntegerTable integerTable(table=[0, 0; 1, 2; 2, 4; 3, 6; 4, 4; 6, 2])
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Sources.TimeTable timeTable(table=[0, 0; 1, 2.1; 2, 4.2; 3, 6.3; 4, 4.2; 6,
          2.1; 6, 2.1])
      annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
    Interaction.Show.RealValue realValue
      annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
    Sources.BooleanTable booleanTable(table={1,2,3,4,5,6,7,8,9})
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
    Interaction.Show.BooleanValue booleanValue
      annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
    Sources.RadioButtonSource start(buttonTimeTable={1,3}, reset={stop.on})
      annotation (Placement(transformation(extent={{24,64},{36,76}})));
    Sources.RadioButtonSource stop(buttonTimeTable={2,4}, reset={start.on})
      annotation (Placement(transformation(extent={{48,64},{60,76}})));
  equation
    connect(integerTable.y, integerValue.numberPort) annotation (Line(
        points={{-59,30},{-41.5,30}}, color={255,127,0}));
    connect(timeTable.y, realValue.numberPort) annotation (Line(
        points={{-59,70},{-41.5,70}}, color={0,0,127}));
    connect(booleanTable.y, booleanValue.activePort) annotation (Line(
        points={{-59,-10},{-41.5,-10}}, color={255,0,255}));
    annotation (experiment(StopTime=10), Documentation(info="<html>
<p>
This example demonstrates a network of blocks
from package <a href=\"modelica://Modelica.Blocks.Interaction\">Modelica.Blocks.Interaction</a>
to show how diagram animations can be constructed.
</p>

</html>"));
  end Interaction1;

  model BusUsage "Demonstrates the usage of a signal bus"
    extends Modelica.Icons.Example;

  public
    Modelica.Blocks.Sources.IntegerStep integerStep(
      height=1,
      offset=2,
      startTime=0.5) annotation (Placement(transformation(extent={{-60,-40},{-40,
              -20}})));
    Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=0.5) annotation (
        Placement(transformation(extent={{-58,0},{-38,20}})));
    Modelica.Blocks.Sources.Sine sine(f=1) annotation (Placement(
          transformation(extent={{-60,40},{-40,60}})));

    Modelica.Blocks.Examples.BusUsage_Utilities.Part part annotation (Placement(
          transformation(extent={{-60,-80},{-40,-60}})));
    Modelica.Blocks.Math.Gain gain(k=1) annotation (Placement(transformation(
            extent={{-40,70},{-60,90}})));
  protected
    BusUsage_Utilities.Interfaces.ControlBus controlBus annotation (Placement(
          transformation(
          origin={30,10},
          extent={{-20,20},{20,-20}},
          rotation=90)));
  equation

    connect(sine.y, controlBus.realSignal1) annotation (Line(
        points={{-39,50},{12,50},{12,14},{30,14},{30,10}}, color={0,0,127}));
    connect(booleanStep.y, controlBus.booleanSignal) annotation (Line(
        points={{-37,10},{30,10}}, color={255,0,255}));
    connect(integerStep.y, controlBus.integerSignal) annotation (Line(
        points={{-39,-30},{0,-30},{0,6},{32,6},{32,10},{30,10}}, color={255,127,0}));
    connect(part.subControlBus, controlBus.subControlBus) annotation (Line(
        points={{-40,-70},{30,-70},{30,10}},
        color={255,204,51},
        thickness=0.5));
    connect(gain.u, controlBus.realSignal1) annotation (Line(
        points={{-38,80},{20,80},{20,18},{32,18},{32,10},{30,10}}, color={0,0,127}));
    annotation (Documentation(info="<html>
<p><strong>Signal bus concept</strong></p>
<p>
In technical systems, such as vehicles, robots or satellites, many signals
are exchanged between components. In a simulation system, these signals
are usually modelled by signal connections of input/output blocks.
Unfortunately, the signal connection structure may become very complicated,
especially for hierarchical models.
</p>

<p>
The same is also true for real technical systems. To reduce complexity
and get higher flexibility, many technical systems use data buses to
exchange data between components. For the same reasons, it is often better
to use a \"signal bus\" concept also in a Modelica model. This is demonstrated
at hand of this model (Modelica.Blocks.Examples.BusUsage):
</p>

<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/BusUsage.png\"
     alt=\"BusUsage.png\">

<ul>
<li> Connector instance \"controlBus\" is a hierarchical connector that is
     used to exchange signals between different components. It is
     defined as \"expandable connector\" in order that <strong>no</strong> central definition
     of the connector is needed but is automatically constructed by the
     signals connected to it (see also <a href=\"https://specification.modelica.org/v3.4/Ch9.html#expandable-connectors\">Section 9.1.3 (Expandable Connectors) of the Modelica 3.4 specification</a>).</li>
<li> Input/output signals can be directly connected to the \"controlBus\".</li>
<li> A component, such as \"part\", can be directly connected to the \"controlBus\",
     provided it has also a bus connector, or the \"part\" connector is a
     sub-connector contained in the \"controlBus\".</li>
</ul>

<p>
The control and sub-control bus icons are provided within Modelica.Icons.
In <a href=\"modelica://Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces\">Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces</a>
the buses for this example are defined. Both the \"ControlBus\" and the \"SubControlBus\" are
<strong>expandable</strong> connectors that do not define any variable. For example,
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus#text\">Interfaces.ControlBus</a>
is defined as:
</p>
<blockquote><pre>
<strong>expandable connector</strong> ControlBus
    <strong>extends</strong> Modelica.Icons.ControlBus;
    <strong>annotation</strong> ();
<strong>end</strong> ControlBus;
</pre></blockquote>
<p>
Note, the \"annotation\" in the connector is important since the color
and thickness of a connector line are taken from the first
line element in the icon annotation of a connector class. Above, a small rectangle in the
color of the bus is defined (and therefore this rectangle is not
visible). As a result, when connecting from an instance of this
connector to another connector instance, the connecting line has
the color of the \"ControlBus\" with double width (due to \"thickness=0.5\").
</p>

<p>
An <strong>expandable</strong> connector is a connector where the content of the connector
is constructed by the variables connected to instances of this connector.
For example, if \"sine.y\" is connected to the \"controlBus\", a pop-up menu may appear:
</p>

<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/BusUsage2.png\"
     alt=\"BusUsage2.png\">

<p>
The \"Add variable/New name\" field allows the user to define the name of the signal on
the \"controlBus\". When typing \"realSignal1\" as \"New name\", a connection of the form:
</p>

<blockquote><pre>
<strong>connect</strong>(sine.y, controlBus.realSignal1)
</pre></blockquote>

<p>
is generated and the \"controlBus\" contains the new signal \"realSignal1\". Modelica tools
may give more support in order to list potential signals for a connection. Therefore, in
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces\">BusUsage_Utilities.Interfaces</a>
the expected implementation of the \"ControlBus\" and of the \"SubControlBus\" are given.
For example \"Internal.ControlBus\" is defined as:
</p>

<blockquote><pre>
<strong>expandable connector</strong> StandardControlBus
  <strong>extends</strong> BusUsage_Utilities.Interfaces.ControlBus;

  <strong>import</strong> Modelica.Units.SI;
  SI.AngularVelocity    realSignal1   \"First Real signal\";
  SI.Velocity           realSignal2   \"Second Real signal\";
  Integer               integerSignal \"Integer signal\";
  Boolean               booleanSignal \"Boolean signal\";
  StandardSubControlBus subControlBus \"Combined signal\";
<strong>end</strong> StandardControlBus;
</pre></blockquote>

<p>
Consequently, when connecting now from \"sine.y\" to \"controlBus\", the menu
looks differently:
</p>

<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/BusUsage3.png\"
     alt=\"BusUsage3.png\">

<p>
Note, even if the signals from \"Internal.StandardControlBus\" are listed, these are
just potential signals. The user might still add different signal names.
</p>

</html>"), experiment(StopTime=2));
  end BusUsage;

  model Rectifier6pulseFFT "Example of FFT block"
    extends Modelica.Electrical.Machines.Examples.Transformers.Rectifier6pulse;
    Modelica.Blocks.Math.RealFFT realFFT(
      startTime=0.04,
      f_max=2000,
      f_res=5,
      resultFileName="rectifier6pulseFFTresult.mat")
    annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          origin={-40,-20})));
  equation
    connect(currentSensor.i[1], realFFT.u)
      annotation (Line(points={{-70,-11},{-70,-20},{-52,-20}},
                                                     color={0,0,127}));
    annotation (experiment(StopTime=0.25, Interval=0.0001),
      Documentation(info="<html>
<p>
This example is based on a&nbsp;<a href=\"modelica://Modelica.Electrical.Machines.Examples.Transformers.Rectifier6pulse\">6-pulse rectifier example</a>,
calculating the harmonics with the <a href=\"modelica://Modelica.Blocks.Math.RealFFT\">FFT block</a>.
</p>
<p>
Sampling starts after the initial transients are settled - waiting for
<code>2&nbsp;periods&nbsp;= 2/f&nbsp;= 0.04&nbsp;s&nbsp;= realFFT.startTime</code>.
Choosing a&nbsp;maximum frequency <code>f_max&nbsp;=&nbsp;2000&nbsp;Hz</code>,
a&nbsp;frequency resolution <code>f_res&nbsp;=&nbsp;5&nbsp;Hz</code>
(both given in the block <code>realFFT</code>) and
the default oversampling factor <code>f_max_factor&nbsp;=&nbsp;5</code>,
we have to acquire <code>n&nbsp;= 2*f_max/f_res*f_max_factor&nbsp;=&nbsp;4000</code>
sampling intervals.
The resulting sampling interval is <code>samplePeriod&nbsp;=&nbsp;1/(n*f_res)&nbsp;=&nbsp;0.05&nbsp;ms</code>.
Thus, we have to sample for a&nbsp;period of <code>n*samplePeriod&nbsp;=&nbsp;1/f_res&nbsp;=&nbsp;0.2&nbsp;s</code>.
</p>
<p>
The result file &quot;rectifier6pulseFFTresult.mat&quot; can be used to plot
amplitudes versus frequencies.
Note that for each frequency three rows exit: one with amplitude zero,
one with the calculated amplitude, one with amplitude zero.
Thus, the second column (amplitude) can be easily plotted versus the first column (frequency).
As expected, one can see the 5<sup>th</sup>, 7<sup>th</sup>, 11<sup>th</sup>,
13<sup>th</sup>, 17<sup>th</sup>, 19<sup>th</sup>, 23<sup>th</sup>, 25<sup>th</sup>,
&hellip; harmonic in the result.
</p>
</html>"));
  end Rectifier6pulseFFT;

  model Rectifier12pulseFFT "Example of FFT block"
    extends Modelica.Electrical.Machines.Examples.Transformers.Rectifier12pulse;
    Modelica.Blocks.Math.RealFFT realFFT(
      startTime=0.04,
      f_max=2000,
      f_res=5,
      resultFileName="rectifier12pulseFFTresult.mat")
                                                annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          origin={-40,-20})));
  equation
    connect(currentSensor.i[1], realFFT.u) annotation (Line(points={{-70,-11},{-70,-20},{-52,-20}},
                                   color={0,0,127}));
    annotation (experiment(StopTime=0.25, Interval=0.0001),
      Documentation(info="<html>
<p>
This example is based on a&nbsp;<a href=\"modelica://Modelica.Electrical.Machines.Examples.Transformers.Rectifier12pulse\">12-pulse rectifier example</a>,
calculating the harmonics with the <a href=\"modelica://Modelica.Blocks.Math.RealFFT\">FFT block</a>.
</p>
<p>
Sampling starts after the initial transients are settled - waiting for
<code>2&nbsp;periods&nbsp;= 2/f&nbsp;= 0.04&nbsp;s&nbsp;= realFFT.startTime</code>.
Choosing a&nbsp;maximum frequency <code>f_max&nbsp;=&nbsp;2000&nbsp;Hz</code>,
a&nbsp;frequency resolution <code>f_res&nbsp;=&nbsp;5&nbsp;Hz</code>
(both given in the block <code>realFFT</code>) and
the default oversampling factor <code>f_max_factor&nbsp;=&nbsp;5</code>,
we have to acquire <code>n&nbsp;= 2*f_max/f_res*f_max_factor&nbsp;=&nbsp;4000</code>
sampling intervals.
The resulting sampling interval is <code>samplePeriod&nbsp;=&nbsp;1/(n*f_res)&nbsp;=&nbsp;0.05&nbsp;ms</code>.
Thus, we have to sample for a&nbsp;period of <code>n*samplePeriod = 1/f_res = 0.2 s</code>.
</p>
<p>
The resultfile &quot;rectifier12pulseFFTresult.mat&quot; can be used to plot amplitudes versus frequencies.
Note that for each frequency three rows exit: one with amplitude zero,
one with the calculated amplitude, one with amplitude zero.
Thus, the second column (amplitude) can be easily plotted versus the first column (frequency).
As expected, one can see the 11<sup>th</sup>, 13<sup>th</sup>, 23<sup>th</sup>, 25<sup>th</sup>,
&hellip; harmonic in the result.
</p>
</html>"));
  end Rectifier12pulseFFT;

  model TotalHarmonicDistortion "Calculation of total harmonic distortion of voltage"
    extends Modelica.Icons.Example;
    parameter SI.Frequency f1 = 50 "Fundamental wave frequency";
    parameter SI.Voltage V1 = 100 "Fundamental wave RMS voltage";
    parameter SI.Voltage V3 = 20 "Third harmonic wave RMS voltage";
    final parameter Real THD1 = V3/V1 "Theoretically obtained THD with respect to fundamental wave";
    final parameter Real THDrms = V3/sqrt(V1^2+V3^2) "Theoretically obtained THD with respect to RMS";
    Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage3(V=sqrt(2)*V3, f=3*f1,
      startTime=0.02)                                           annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,10})));
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage1(V=sqrt(2)*V1, f=f1,
      startTime=0.02)                                           annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,-20})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270)));
    Modelica.Blocks.Math.TotalHarmonicDistortion thd1(f=f1) annotation (Placement(transformation(extent={{30,10},{50,30}})));
    Modelica.Blocks.Math.TotalHarmonicDistortion thdRMS(f=f1, useFirstHarmonic=false) annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
  equation
    connect(voltageSensor.p, sineVoltage3.p) annotation (Line(points={{0,10},{0,30},{-40,30},{-40,20}}, color={0,0,255}));
    connect(sineVoltage3.n, sineVoltage1.p) annotation (Line(points={{-40,0},{-40,-10}}, color={0,0,255}));
    connect(sineVoltage1.n, ground.p) annotation (Line(points={{-40,-30},{-40,-40}}, color={0,0,255}));
    connect(ground.p, voltageSensor.n) annotation (Line(points={{-40,-40},{-40,-30},{0,-30},{0,-10}}, color={0,0,255}));
    connect(thd1.u, voltageSensor.v) annotation (Line(points={{28,20},{20,20},{20,0},{11,0}}, color={0,0,127}));
    connect(voltageSensor.v, thdRMS.u) annotation (Line(points={{11,0},{20,0},{20,-20},{28,-20}}, color={0,0,127}));
    annotation (experiment(
        StopTime=0.1,
        Interval=0.0001,
        Tolerance=1e-06), Documentation(info="<html>
<p>This example compares the result of the
<a href=\"modelica://Modelica.Blocks.Math.TotalHarmonicDistortion\">total harmonic distortion (THD)</a>
with respect to the fundamental wave and with respect to the total root mean square (RMS).
In this simulation model a non-sinusoidal voltage
wave form is created by the superposition two voltage waves:</p>

<ul>
<li>Fundamental wave with RMS voltage <code>V1</code> and frequency <code>f1</code></li>
<li>Third harmonic wave with RMS voltage <code>V3</code> and frequency <code>3*f1</code></li>
</ul>

<p>This simulation model compares numerically determined THD values with results, obtained by
theoretical calculations:</p>

<ul>
<li>Compare the numerically determined THD value <code>thd1.y</code> and the theoretical value <code>THD1</code>,
    both with respect to the fundamental wave; also plot <code>thd1.valid</code></li>
<li>Compare the numerically determined THD value <code>thdRMS.y</code> and the theoretical value <code>THDrms</code>,
    both with respect to the RMS value; also plot <code>thdRMS.valid</code></li>
</ul>
</html>"));
  end TotalHarmonicDistortion;

  model Modulation "Demonstrate amplitude modulation an frequency modulation"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.SineVariableFrequencyAndAmplitude sine(
      useConstantAmplitude=true,
      useConstantFrequency=true,
      constantFrequency=100,
      phi(fixed=true))
      annotation (Placement(transformation(extent={{-10,60},{10,80}})));
    Modelica.Blocks.Sources.Sine amplitude(
      amplitude=0.5,
      f=2,
      offset=1)
      annotation (Placement(transformation(extent={{-52,20},{-32,40}})));
    Modelica.Blocks.Sources.SineVariableFrequencyAndAmplitude sinAM(
      useConstantAmplitude=false,
      useConstantFrequency=true,
      constantFrequency=100,
      phi(fixed=true))
      annotation (Placement(transformation(extent={{-10,20},{10,40}})));
    Sources.CosineVariableFrequencyAndAmplitude cosAM(
      useConstantAmplitude=false,
      useConstantFrequency=true,
      constantFrequency=100,
      phi(fixed=true))
      annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
    Modelica.Blocks.Sources.Sine frequency(
      amplitude=50,
      f=2,
      offset=100)
      annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
    Modelica.Blocks.Sources.SineVariableFrequencyAndAmplitude sinFM(
      useConstantAmplitude=true,
      useConstantFrequency=false,
      constantFrequency=100,
      phi(fixed=true))
      annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
    Sources.CosineVariableFrequencyAndAmplitude cosFM(
      useConstantAmplitude=true,
      useConstantFrequency=false,
      constantFrequency=100,
      phi(fixed=true))
      annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  equation
    connect(amplitude.y, sinAM.amplitude) annotation (Line(points={{-31,30},{-20,30},
            {-20,36},{-12,36}}, color={0,0,127}));
    connect(frequency.y, sinFM.f) annotation (Line(points={{-29,-40},{-20,-40},{-20,
            -46},{-12,-46}}, color={0,0,127}));
    connect(amplitude.y, cosAM.amplitude) annotation (Line(points={{-31,30},{-20,30},
            {-20,4},{-12,4}}, color={0,0,127}));
    connect(frequency.y, cosFM.f) annotation (Line(points={{-29,-40},{-20,-40},{-20,
            -76},{-12,-76}}, color={0,0,127}));
    annotation (experiment(StopTime=1.0, Interval=0.0001), Documentation(info="<html>
<p>
This example demonstrates amplitude modulation (AM) and frequency modulation (FM).
</p>
</html>"));
  end Modulation;

  model SinCosEncoder "Evaluation of a sinusoidal encoder"
    extends Modelica.Icons.Example;
    import Modelica.Constants.pi;
    SI.AngularVelocity w=2*pi*ramp.y "2*pi*f";
    Sources.Ramp ramp(
      height=100,
      duration=1,
      offset=0,
      startTime=0)
      annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
    Sources.CosineVariableFrequencyAndAmplitude
                                              cosB(
      useConstantAmplitude=true,
      offset=1.5,
      phi(fixed=true))
      annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
    Sources.CosineVariableFrequencyAndAmplitude
                                              cosBminus(
      useConstantAmplitude=true,
      constantAmplitude=-1,
      offset=1.5,
      phi(fixed=true))
      annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
    Sources.SineVariableFrequencyAndAmplitude sinA(
      useConstantAmplitude=true,
      offset=1.5,
      phi(fixed=true))
      annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
    Sources.SineVariableFrequencyAndAmplitude sinAminus(
      useConstantAmplitude=true,
      constantAmplitude=-1,
      offset=1.5,
      phi(fixed=true))
      annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
    Math.Feedback feedbackCos
      annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
    Math.Feedback feedbackSin
      annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
    Electrical.Machines.SpacePhasors.Blocks.Rotator rotator
      annotation (Placement(transformation(extent={{10,-10},{30,10}})));
    Continuous.Integrator integrator(k=1e6)
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    Continuous.Der der1
      annotation (Placement(transformation(extent={{80,-10},{100,10}})));
    Math.WrapAngle wrapAngle(positiveRange=false)
      annotation (Placement(transformation(extent={{80,20},{100,40}})));
    Electrical.Machines.SpacePhasors.Blocks.ToPolar toPolar
      annotation (Placement(transformation(extent={{10,20},{30,40}})));
  equation
    connect(ramp.y, sinA.f) annotation (Line(points={{-79,0},{-70,0},{-70,-26},{-62,
            -26}},color={0,0,127}));
    connect(ramp.y, sinAminus.f) annotation (Line(points={{-79,0},{-70,0},{-70,-56},
            {-62,-56}}, color={0,0,127}));
    connect(ramp.y, cosBminus.f) annotation (Line(points={{-79,0},{-70,0},{-70,14},
            {-62,14}}, color={0,0,127}));
    connect(ramp.y, cosB.f) annotation (Line(points={{-79,0},{-70,0},{-70,44},{-62,
            44}}, color={0,0,127}));
    connect(cosBminus.y, feedbackCos.u2)
      annotation (Line(points={{-39,20},{-20,20},{-20,42}}, color={0,0,127}));
    connect(cosB.y, feedbackCos.u1)
      annotation (Line(points={{-39,50},{-28,50}}, color={0,0,127}));
    connect(sinA.y, feedbackSin.u1)
      annotation (Line(points={{-39,-20},{-28,-20}}, color={0,0,127}));
    connect(sinAminus.y, feedbackSin.u2)
      annotation (Line(points={{-39,-50},{-20,-50},{-20,-28}}, color={0,0,127}));
    connect(feedbackCos.y, rotator.u[1])
      annotation (Line(points={{-11,50},{0,50},{0,0},{8,0}}, color={0,0,127}));
    connect(feedbackSin.y, rotator.u[2])
      annotation (Line(points={{-11,-20},{0,-20},{0,0},{8,0}}, color={0,0,127}));
    connect(rotator.y[2], integrator.u)
      annotation (Line(points={{31,0},{38,0}}, color={0,0,127}));
    connect(integrator.y, rotator.angle) annotation (Line(points={{61,0},{70,0},{70,
            -20},{20,-20},{20,-12}}, color={0,0,127}));
    connect(integrator.y, der1.u)
      annotation (Line(points={{61,0},{78,0}}, color={0,0,127}));
    connect(integrator.y, wrapAngle.u)
      annotation (Line(points={{61,0},{70,0},{70,30},{78,30}}, color={0,0,127}));
    connect(feedbackCos.y, toPolar.u[1])
      annotation (Line(points={{-11,50},{0,50},{0,30},{8,30}}, color={0,0,127}));
    connect(feedbackSin.y, toPolar.u[2]) annotation (Line(points={{-11,-20},{0,-20},
            {0,30},{8,30}}, color={0,0,127}));
    annotation (experiment(StopTime=1.0, Interval=5e-05, Tolerance=1e-05), Documentation(info="<html>
<p>
This examples demonstrates robust evaluation of a sin-cos-encoder.
</p>
<p>
The sin-cos-encoder provides four tracks:
</p>
<ul>
<li>cosine</li>
<li>minus sine</li>
<li>sine</li>
<li>minus cosine</li>
</ul>
<p>
All four tracks have the same amplitude and the same offset &gt; amplitude. Offset is used to detect loss of a track.
To remove offset, (minus sine) is subtracted from (sine) and (minus cosine) from (cosine),
resulting in a cosine and a sine signal with doubled amplitude but without offset.
</p>
<p>
Interpreting cosine and sine as real and imaginary part of a phasor, one could calculate the angle of the phasor (i.e. transform rectangular coordinates to polar coordinates).
This is not very robust if the signals are superimposed with some noise.
Therefore the phasor is rotated by an angle that is obtained by a controller. The controller aims at imaginary part equal to zero.
The resulting angle is continuous, i.e. differentiating the angle results in 2*&pi;*frequency.
If desired, the angle can be wrapped to the interval [-&pi;, +&pi;].
</p>
</html>"));
  end SinCosEncoder;

  model CompareSincExpSine "Compare sinc and exponential sine signal"
    extends Modelica.Icons.Example;
    Sources.Sinc sinc(f=5)
      annotation (Placement(transformation(extent={{-10,20},{10,40}})));
    Sources.ExpSine expSine1(f=5, damping=5)
      annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
    Sources.ExpSine expSine2(
      f=5,
      phase=Modelica.Constants.pi/2,
      damping=5)
      annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
    annotation (experiment(StopTime=1.0, Interval=0.0001), Documentation(info="<html>
<p>
Compare the sinc signal and an exponentially damped sine.
</p>
</html>"));
  end CompareSincExpSine;

  package Noise "Library of examples to demonstrate the usage of package Blocks.Noise"
    extends Modelica.Icons.ExamplesPackage;

    model UniformNoise
      "Demonstrates the most simple usage of the UniformNoise block"
      extends Modelica.Icons.Example;
      output Real uniformNoise2_y = uniformNoise2.y;

      inner Modelica.Blocks.Noise.GlobalSeed globalSeed
        annotation (Placement(transformation(extent={{-20,40},{0,60}})));
      Modelica.Blocks.Noise.UniformNoise uniformNoise1(
        samplePeriod=0.02,
        y_min=-1,
        y_max=3) annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      Modelica.Blocks.Noise.UniformNoise uniformNoise2(
        samplePeriod=0.02, y_min=-1, y_max=3,
        useAutomaticLocalSeed=false,
        fixedLocalSeed=10)
        annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
     annotation (experiment(StopTime=2), Documentation(info="<html>
<p>
This example demonstrates the most simple usage of the
<a href=\"modelica://Modelica.Blocks.Noise.UniformNoise\">Noise.UniformNoise</a>
block:
</p>

<ul>
<li> <strong>globalSeed</strong> is the <a href=\"modelica://Modelica.Blocks.Noise.GlobalSeed\">Noise.GlobalSeed</a>
     block with default options (just dragged from sublibrary Noise).</li>
<li> <strong>uniformNoise1</strong> is an instance of
     <a href=\"modelica://Modelica.Blocks.Noise.UniformNoise\">Noise.UniformNoise</a> with
     samplePeriod = 0.02 s and a Uniform distribution with limits y_min=-1, y_max=3.</li>
<li> <strong>uniformNoise2</strong> is identical to uniformNoise1 with the exception that
      useAutomaticLocalSeed=false and fixedLocalSeed=10.</li>
</ul>

<p>
At every 0.02 seconds a time event occurs and a uniform random number in the band between
-1 ... 3 is drawn. This random number is held constant until the next sample instant.
The result of a simulation is shown in the next diagram:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/UniformNoise.png\">
</blockquote>
</html>",     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end UniformNoise;

    model AutomaticSeed
      "Demonstrates noise with startTime and automatic local seed for UniformNoise"
       extends Modelica.Icons.Example;
       parameter SI.Time startTime = 0.5 "Start time of noise";
       parameter Real y_off = -1.0 "Output of block before startTime";

       output Real manualSeed1_y = manualSeed1.y;
       output Real manualSeed2_y = manualSeed2.y;
       output Real manualSeed3_y = manualSeed3.y;

      inner Modelica.Blocks.Noise.GlobalSeed globalSeed(useAutomaticSeed=false, enableNoise=true)
        annotation (Placement(transformation(extent={{60,60},{80,80}})));

      Modelica.Blocks.Noise.UniformNoise automaticSeed1(
        samplePeriod=0.01,
        startTime=startTime,
        y_off=y_off,
        y_min=-1, y_max=3)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      Modelica.Blocks.Noise.UniformNoise automaticSeed2(
        samplePeriod=0.01,
        startTime=startTime,
        y_off=y_off,y_min=-1, y_max=3)
        annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
      Modelica.Blocks.Noise.UniformNoise automaticSeed3(
        samplePeriod=0.01,
        startTime=startTime,
        y_off=y_off, y_min=-1, y_max=3)
        annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
      Modelica.Blocks.Noise.UniformNoise manualSeed1(
        samplePeriod=0.01,
        startTime=startTime,
        y_off=y_off,
        useAutomaticLocalSeed=false,
        fixedLocalSeed=1,y_min=-1, y_max=3,
        enableNoise=true)
        annotation (Placement(transformation(extent={{0,20},{20,40}})));
      Modelica.Blocks.Noise.UniformNoise manualSeed2(
        samplePeriod=0.01,
        startTime=startTime,
        y_off=y_off,
        useAutomaticLocalSeed=false,
        fixedLocalSeed=2,y_min=-1, y_max=3)
        annotation (Placement(transformation(extent={{0,-20},{20,0}})));
      Modelica.Blocks.Noise.UniformNoise manualSeed3(
        samplePeriod=0.01,
        startTime=startTime,
        y_off=y_off,
        useAutomaticLocalSeed=false,y_min=-1, y_max=3,
        fixedLocalSeed=3)
        annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
     annotation (experiment(StopTime=2), Documentation(info="<html>
<p>
This example demonstrates manual and automatic seed selection of
<a href=\"modelica://Modelica.Blocks.Noise.UniformNoise\">UniformNoise</a> blocks, as well
as starting the noise at startTime = 0.5 s with an output value of y = -1 before this
time. All noise blocks in this example generate uniform noise in the
band y_min=-1 .. y_max=3 with samplePeriod = 0.01 s.
</p>

<p>
The blocks automaticSeed1, automaticSeed2, automaticSeed3 use the default
option to automatically initialize the pseudo random number generators
of the respective block. As a result, different noise is generated, see next
diagram:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/AutomaticSeed1.png\">
</blockquote>

<p>
The blocks manualSeed1, manualSeed2, manualSeed3 use manual selection of the local seed
(useAutomaticLocalSeed = false). They use a fixedLocalSeed of 1, 2, and 3 respectively.
Again, different noise is generated, see next diagram:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/AutomaticSeed2.png\">
</blockquote>

<p>
Try to set fixedLocalSeed = 1 in block manualSeed2. As a result, the blocks manualSeed1 and
manualSeed2 will produce exactly the same noise.
</p>
</html>",     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end AutomaticSeed;

    model Distributions
      "Demonstrates noise with different types of distributions"
      extends Modelica.Icons.Example;
      parameter SI.Period samplePeriod=0.02
        "Sample period of all blocks";
      parameter Real y_min = -1 "Minimum value of band for random values";
      parameter Real y_max = 3 "Maximum value of band for random values";
      inner Modelica.Blocks.Noise.GlobalSeed globalSeed(useAutomaticSeed=
            false)
        annotation (Placement(transformation(extent={{40,60},{60,80}})));
      output Real uniformNoise_y =         uniformNoise.y;
      output Real truncatedNormalNoise_y = truncatedNormalNoise.y;

      Integer n=if time < 0.5 then 12 else 2;

      Modelica.Blocks.Noise.UniformNoise uniformNoise(
        useAutomaticLocalSeed=false,
        fixedLocalSeed=1,
        samplePeriod=samplePeriod,
        y_min=y_min,
        y_max=y_max)
        annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
      Modelica.Blocks.Noise.TruncatedNormalNoise truncatedNormalNoise(
        useAutomaticLocalSeed=false,
        fixedLocalSeed=1,
        samplePeriod=samplePeriod,
        y_min=y_min,
        y_max=y_max)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
     annotation (experiment(StopTime=2), Documentation(info="<html>
<p>
This example demonstrates different noise distributions methods that can be selected
for a Noise block. Both noise blocks use samplePeriod = 0.02 s, y_min=-1, y_max=3, and have
identical fixedLocalSeed. This means that the same random numbers are drawn for the blocks.
However, the random numbers are differently transformed according to the selected distributions
(uniform and truncated normal distribution), and therefore the blocks have different output values.
Simulation results are shown in the next diagram:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/Distributions.png\">
</blockquote>

<p>
As can be seen, uniform noise is distributed evenly between -1 and 3, and
truncated normal distribution has more values centered around the mean value 1.
</p>
</html>",     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end Distributions;

    model UniformNoiseProperties
      "Demonstrates the computation of properties for uniformly distributed noise"
      extends Modelica.Icons.Example;
      parameter Real y_min = 0 "Minimum value of band";
      parameter Real y_max = 6 "Maximum value of band";
      parameter Real pMean = (y_min + y_max)/2
        "Theoretical mean value of uniform distribution";
      parameter Real var =  (y_max - y_min)^2/12
        "Theoretical variance of uniform distribution";
      parameter Real std =  sqrt(var)
        "Theoretical standard deviation of uniform distribution";
      inner Modelica.Blocks.Noise.GlobalSeed globalSeed
        annotation (Placement(transformation(extent={{80,60},{100,80}})));
      output Real meanError_y = meanError.y;
      output Real sigmaError_y = sigmaError.y;

      Modelica.Blocks.Noise.UniformNoise noise(
        samplePeriod=0.001,
        y_min=y_min,
        y_max=y_max,
        useAutomaticLocalSeed=false)
        annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
      Modelica.Blocks.Math.ContinuousMean mean
        annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
      Modelica.Blocks.Math.Variance variance
        annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
      Modelica.Blocks.Math.MultiProduct theoreticalVariance(nu=2)
        annotation (Placement(transformation(extent={{28,-36},{40,-24}})));
      Modelica.Blocks.Math.Feedback meanError
        annotation (Placement(transformation(extent={{40,60},{60,80}})));
      Modelica.Blocks.Sources.Constant theoreticalMean(k=pMean)
        annotation (Placement(transformation(extent={{-10,40},{10,60}})));
      Modelica.Blocks.Math.Feedback varianceError
        annotation (Placement(transformation(extent={{40,0},{60,20}})));
      Modelica.Blocks.Sources.Constant theoreticalSigma(k=std)
        annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
      Modelica.Blocks.Math.StandardDeviation standardDeviation
        annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
      Modelica.Blocks.Math.Feedback sigmaError
        annotation (Placement(transformation(extent={{40,-60},{60,-80}})));
    equation
      connect(noise.y, mean.u) annotation (Line(
          points={{-59,70},{-42,70}}, color={0,0,127}));
      connect(noise.y, variance.u) annotation (Line(
          points={{-59,70},{-52,70},{-52,10},{-42,10}}, color={0,0,127}));
      connect(mean.y, meanError.u1) annotation (Line(
          points={{-19,70},{42,70}}, color={0,0,127}));
      connect(theoreticalMean.y, meanError.u2) annotation (Line(
          points={{11,50},{50,50},{50,62}}, color={0,0,127}));
      connect(theoreticalSigma.y, theoreticalVariance.u[1]) annotation (Line(
          points={{11,-30},{24,-30},{24,-27.9},{28,-27.9}}, color={0,0,127}));
      connect(theoreticalSigma.y, theoreticalVariance.u[2]) annotation (Line(
          points={{11,-30},{24,-30},{24,-32.1},{28,-32.1}}, color={0,0,127}));
      connect(variance.y, varianceError.u1) annotation (Line(
          points={{-19,10},{42,10}}, color={0,0,127}));
      connect(theoreticalVariance.y, varianceError.u2) annotation (Line(
          points={{41.02,-30},{50,-30},{50,2}}, color={0,0,127}));
      connect(noise.y, standardDeviation.u) annotation (Line(
          points={{-59,70},{-52,70},{-52,-70},{-42,-70}}, color={0,0,127}));
      connect(standardDeviation.y, sigmaError.u1) annotation (Line(
          points={{-19,-70},{42,-70}}, color={0,0,127}));
      connect(theoreticalSigma.y, sigmaError.u2) annotation (Line(
          points={{11,-30},{18,-30},{18,-42},{50,-42},{50,-62}}, color={0,0,127}));
     annotation (experiment(StopTime=20, Interval=0.4e-2, Tolerance=1e-009),
        Documentation(info="<html>
<p>
This example demonstrates statistical properties of the
<a href=\"modelica://Modelica.Blocks.Noise.UniformNoise\">Blocks.Noise.UniformNoise</a> block
using a <strong>uniform</strong> random number distribution.
Block &quot;noise&quot; defines a band of 0 .. 6 and from the generated noise the mean and the variance
is computed with blocks of package <a href=\"modelica://Modelica.Blocks.Math\">Blocks.Math</a>.
Simulation results are shown in the next diagram:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/UniformNoiseProperties1.png\"/>
</blockquote>

<p>
The mean value of a uniform noise in the range 0 .. 6 is 3 and its variance is
3 as well. The simulation results above show good agreement (after a short initial phase).
This demonstrates that the random number generator and the mapping to a uniform
distribution have good statistical properties.
</p>
</html>",     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end UniformNoiseProperties;

    model NormalNoiseProperties
      "Demonstrates the computation of properties for normally distributed noise"
      extends Modelica.Icons.Example;
      parameter Real mu = 3 "Mean value for normal distribution";
      parameter Real sigma = 1 "Standard deviation for normal distribution";
      parameter Real pMean = mu "Theoretical mean value of normal distribution";
      parameter Real var =  sigma^2
        "Theoretical variance of uniform distribution";
      parameter Real std =  sigma
        "Theoretical standard deviation of normal distribution";
      inner Modelica.Blocks.Noise.GlobalSeed globalSeed
        annotation (Placement(transformation(extent={{80,60},{100,80}})));
      output Real meanError_y = meanError.y;
      output Real sigmaError_y = sigmaError.y;

      Modelica.Blocks.Noise.NormalNoise noise(
        samplePeriod=0.001,
        mu=mu,
        sigma=sigma,
        useAutomaticLocalSeed=false)
        annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
      Modelica.Blocks.Math.ContinuousMean mean
        annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
      Modelica.Blocks.Math.Variance variance
        annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
      Modelica.Blocks.Math.MultiProduct theoreticalVariance(nu=2)
        annotation (Placement(transformation(extent={{28,-36},{40,-24}})));
      Modelica.Blocks.Math.Feedback meanError
        annotation (Placement(transformation(extent={{40,60},{60,80}})));
      Modelica.Blocks.Sources.Constant theoreticalMean(k=pMean)
        annotation (Placement(transformation(extent={{-10,40},{10,60}})));
      Modelica.Blocks.Math.Feedback varianceError
        annotation (Placement(transformation(extent={{40,0},{60,20}})));
      Modelica.Blocks.Sources.Constant theoreticalSigma(k=std)
        annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
      Modelica.Blocks.Math.StandardDeviation standardDeviation
        annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
      Modelica.Blocks.Math.Feedback sigmaError
        annotation (Placement(transformation(extent={{40,-60},{60,-80}})));
    equation
      connect(noise.y, mean.u) annotation (Line(
          points={{-59,70},{-42,70}}, color={0,0,127}));
      connect(noise.y, variance.u) annotation (Line(
          points={{-59,70},{-52,70},{-52,10},{-42,10}}, color={0,0,127}));
      connect(mean.y, meanError.u1) annotation (Line(
          points={{-19,70},{42,70}}, color={0,0,127}));
      connect(theoreticalMean.y, meanError.u2) annotation (Line(
          points={{11,50},{50,50},{50,62}}, color={0,0,127}));
      connect(theoreticalSigma.y, theoreticalVariance.u[1]) annotation (Line(
          points={{11,-30},{24,-30},{24,-27.9},{28,-27.9}}, color={0,0,127}));
      connect(theoreticalSigma.y, theoreticalVariance.u[2]) annotation (Line(
          points={{11,-30},{24,-30},{24,-32.1},{28,-32.1}}, color={0,0,127}));
      connect(variance.y, varianceError.u1) annotation (Line(
          points={{-19,10},{42,10}}, color={0,0,127}));
      connect(theoreticalVariance.y, varianceError.u2) annotation (Line(
          points={{41.02,-30},{50,-30},{50,2}}, color={0,0,127}));
      connect(noise.y, standardDeviation.u) annotation (Line(
          points={{-59,70},{-52,70},{-52,-70},{-42,-70}}, color={0,0,127}));
      connect(standardDeviation.y, sigmaError.u1) annotation (Line(
          points={{-19,-70},{42,-70}}, color={0,0,127}));
      connect(theoreticalSigma.y, sigmaError.u2) annotation (Line(
          points={{11,-30},{18,-30},{18,-42},{50,-42},{50,-62}}, color={0,0,127}));
     annotation (experiment(StopTime=20, Interval=0.4e-2, Tolerance=1e-009),
    Documentation(info="<html>
<p>
This example demonstrates statistical properties of the
<a href=\"modelica://Modelica.Blocks.Noise.NormalNoise\">Blocks.Noise.NormalNoise</a> block
using a <strong>normal</strong> random number distribution with mu=3, sigma=1.
From the generated noise the mean and the variance
is computed with blocks of package <a href=\"modelica://Modelica.Blocks.Math\">Blocks.Math</a>.
Simulation results are shown in the next diagram:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/NormalNoiseProperties1.png\">
</blockquote>

<p>
The mean value of a normal noise with mu=3 is 3 and the variance of normal noise
is sigma^2, so 1. The simulation results above show good agreement (after a short initial phase).
This demonstrates that the random number generator and the mapping to a normal
distribution have good statistical properties.
</p>
</html>",     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end NormalNoiseProperties;

    model Densities
      "Demonstrates how to compute distribution densities (= Probability Density Function)"
      extends Modelica.Icons.Example;
      output Real uniformDensity_y = uniformDensity.y;
      output Real normalDensity_y = normalDensity.y;
      output Real weibullDensity_y = weibullDensity.y;

      Utilities.UniformDensity
                        uniformDensity(u_min=-4, u_max=4)
        annotation (Placement(transformation(extent={{10,20},{30,40}})));
      Modelica.Blocks.Sources.ContinuousClock clock
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
      Modelica.Blocks.Sources.Constant const(k=-10)
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
      Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-46,-10},{-26,10}})));
      Utilities.NormalDensity
                        normalDensity(mu=0, sigma=2)
        annotation (Placement(transformation(extent={{10,-10},{30,10}})));
      Utilities.WeibullDensity
                        weibullDensity(lambda=3, k=1.5)
        annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
    equation
      connect(clock.y, add.u1) annotation (Line(
      points={{-59,20},{-53.5,20},{-53.5,6},{-48,6}}, color={0,0,127}));
      connect(const.y, add.u2) annotation (Line(
      points={{-59,-20},{-54,-20},{-54,-6},{-48,-6}}, color={0,0,127}));
      connect(add.y, uniformDensity.u) annotation (Line(
      points={{-25,0},{-14,0},{-14,30},{8,30}}, color={0,0,127}));
      connect(add.y, normalDensity.u) annotation (Line(
      points={{-25,0},{8,0}}, color={0,0,127}));
      connect(add.y, weibullDensity.u) annotation (Line(
      points={{-25,0},{-14,0},{-14,-30},{8,-30}}, color={0,0,127}));
     annotation (experiment(StopTime=20, Interval=2e-2),
        Documentation(info="<html>
<p>
This example demonstrates how to compute the probability density functions (pdfs) of
various distributions.
In the following diagram simulations results for the uniform, normal, and Weibull distribution
are shown. The outputs of the blocks are the pdfs that are plotted over one of the
inputs:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/Densities.png\">
</blockquote>
</html>",     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end Densities;

    model ImpureGenerator
      "Demonstrates the usage of the impure random number generator"
      extends Modelica.Icons.Example;
      output Real impureRandom_y = impureRandom.y;

      inner Modelica.Blocks.Noise.GlobalSeed globalSeed(useAutomaticSeed=
            false) annotation (Placement(transformation(extent={{20,40},{40,60}})));

      Utilities.ImpureRandom impureRandom(samplePeriod=0.01)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
     annotation (experiment(StopTime=2), Documentation(info="<html>
<p>
This example demonstrates how to use the
<a href=\"modelica://Modelica.Math.Random.Utilities.impureRandom\">impureRandom(..)</a> function
to generate random values at event instants. Typically, this approach is only
used when implementing an own, specialized block that needs a random number
generator. Simulation results are shown in the next figure:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/ImpureGenerator.png\">
</blockquote>
</html>",     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end ImpureGenerator;

    model ActuatorWithNoise
      "Demonstrates how to model measurement noise in an actuator"
    extends Modelica.Icons.Example;
      Utilities.Parts.MotorWithCurrentControl motor
        annotation (Placement(transformation(extent={{-86,-10},{-66,10}})));
      Utilities.Parts.Controller controller
        annotation (Placement(transformation(extent={{-60,40},{-80,60}})));
      Modelica.Blocks.Sources.Step speed(startTime=0.5, height=50)
        annotation (Placement(transformation(extent={{20,40},{0,60}})));
      Modelica.Mechanics.Rotational.Components.Gearbox gearbox(
        lossTable=[0,0.85,0.8,0.1,0.1],
        c=1e6,
        d=1e4,
        ratio=10,
        w_rel(fixed=true),
        b=0.0017453292519943,
        phi_rel(fixed=true))
        annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
      Modelica.Mechanics.Translational.Components.IdealGearR2T idealGearR2T(ratio=
            300) annotation (Placement(transformation(extent={{-32,-10},{-12,10}})));
      Modelica.Mechanics.Translational.Components.Mass mass(m=100)
        annotation (Placement(transformation(extent={{50,-10},{70,10}})));
      Modelica.Mechanics.Translational.Sources.ConstantForce constantForce(
          f_constant=10000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            origin={86,0})));
      Modelica.Blocks.Nonlinear.SlewRateLimiter slewRateLimiter(Rising=50)
        annotation (Placement(transformation(extent={{-20,40},{-40,60}})));
      Modelica.Mechanics.Translational.Components.Mass rodMass(m=3)
        annotation (Placement(transformation(extent={{-4,-10},{16,10}})));
      Modelica.Mechanics.Translational.Components.SpringDamper elastoGap(c=1e8, d=
            1e5,
        v_rel(fixed=true),
        s_rel(fixed=true))
                 annotation (Placement(transformation(extent={{22,-10},{42,10}})));
      inner .Modelica.Blocks.Noise.GlobalSeed globalSeed(enableNoise=true) annotation (Placement(transformation(extent={{60,60},{80,80}})));
    equation
      connect(controller.y1, motor.iq_rms1) annotation (Line(
          points={{-81,50},{-94,50},{-94,6},{-88,6}}, color={0,0,127}));
      connect(motor.phi, controller.positionMeasured) annotation (Line(
          points={{-71,8},{-66,8},{-66,20},{-50,20},{-50,44},{-58,44}}, color={0,0,127}));
      connect(motor.flange, gearbox.flange_a) annotation (Line(
          points={{-66,0},{-60,0}}));
      connect(gearbox.flange_b, idealGearR2T.flangeR) annotation (Line(
          points={{-40,0},{-32,0}}));
      connect(constantForce.flange, mass.flange_b) annotation (Line(
          points={{76,0},{70,0}}, color={0,127,0}));
      connect(speed.y, slewRateLimiter.u) annotation (Line(
          points={{-1,50},{-18,50}}, color={0,0,127}));
      connect(slewRateLimiter.y, controller.positionReference) annotation (Line(
          points={{-41,50},{-50,50},{-50,56},{-58,56}}, color={0,0,127}));
      connect(rodMass.flange_a, idealGearR2T.flangeT) annotation (Line(
          points={{-4,0},{-12,0}}, color={0,127,0}));
      connect(rodMass.flange_b, elastoGap.flange_a) annotation (Line(
          points={{16,0},{22,0}}, color={0,127,0}));
      connect(elastoGap.flange_b, mass.flange_a) annotation (Line(
          points={{42,0},{50,0}}, color={0,127,0}));
      annotation (
        experiment(StopTime=8, Interval = 0.01, Tolerance=1e-005),
        Documentation(info="<html>
<p>
This example models an actuator with a noisy sensor (which is in the motor component):
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/ActuatorNoiseDiagram.png\"/>
</div>

<p>
The drive train consists of a synchronous motor with a current controller (= motor) and a gear box.
The gearbox drives a rod through a linear translation model. Softly attached to the rod is
another mass representing the actual actuator (= mass). The actuator is loaded with a constant force.
</p>

<p>
The whole drive is steered by a rate limited speed step command through a controller model.
In the motor the shaft angle is measured and this measurement signal is modelled by adding
additive noise to the motor angle.
</p>

<p>
In the following figure, the position of the actuator and the motor output torque are
shown with and without noise. The noise is not very strong, such that it has no visible effect
on the position of the actuator. The effect of the noise can be seen in the motor torque.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/ActuatorNoise.png\"/>
</div>

<p>
Note, the noise in all components can be easily switched off by setting parameter
enableNoise = false in the globalSeed component.
</p>
</html>",     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end ActuatorWithNoise;

    model DrydenContinuousTurbulence
      "Demonstrates how to model wind turbulence for aircraft with the BandLimitedWhiteNoise block (a simple model of vertical Dryden gust speed at low altitudes < 1000 ft)"
      extends Modelica.Icons.Example;

      import Modelica.Constants.pi;

      parameter SI.Velocity V =            140 * 0.5144
        "Airspeed of aircraft (typically 140kts during approach)";
      parameter SI.Velocity sigma = 0.1 *   30 * 0.5144
        "Turbulence intensity (=0.1 * wind at 20 ft, typically 30 kt)";
      parameter SI.Length   L =            600 * 0.3048
        "Scale length (= flight altitude)";

      Modelica.Blocks.Continuous.TransferFunction Hw(b=sigma*sqrt(L/pi/V)*{sqrt(3)*
            L/V,1}, a={L^2/V^2,2*L/V,1},
        initType=Modelica.Blocks.Types.Init.InitialState)
        "Transfer function of vertical turbulence speed according to MIL-F-8785C"
        annotation (Placement(transformation(extent={{-10,0},{10,20}})));
      Modelica.Blocks.Noise.BandLimitedWhiteNoise whiteNoise(samplePeriod=
           0.005)
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      constant SI.Velocity unitVelocity = 1 annotation(HideResult=true);
      Modelica.Blocks.Math.Gain compareToSpeed(k=unitVelocity/V)
        annotation (Placement(transformation(extent={{40,0},{60,20}})));
      inner Modelica.Blocks.Noise.GlobalSeed globalSeed
        annotation (Placement(transformation(extent={{40,60},{60,80}})));
    equation
      connect(whiteNoise.y, Hw.u) annotation (Line(
          points={{-39,10},{-12,10}}, color={0,0,127}));
      connect(Hw.y, compareToSpeed.u) annotation (Line(
          points={{11,10},{38,10}}, color={0,0,127}));
      annotation (experiment(StopTime=100),
     Documentation(info="<html>
<p>
This example shows how to use the
<a href=\"modelica://Modelica.Blocks.Noise.BandLimitedWhiteNoise\">BandLimitedWhiteNoise</a>
to feed a Dryden continuous turbulence model. This model is used to describe turbulent wind at low altitudes
that varies randomly in space
(see also <a href=\"https://en.wikipedia.org/wiki/Continuous_gusts\">wikipedia</a>).
</p>

<h4>Turbulence model for vertical gust speed at low altitudes</h4>

<p>
The turbulence model of the Dryden form is defined by the power spectral density of the vertical turbulent velocity:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/equation-erVWhiWU.png\" alt=\"Phi_w(Omega)=sigma^2*L_w/pi*((1+3*(L_w*Omega)^2)/(1+(L_w*Omega)^2)^2)\"/>
</div>

<p>
The spectrum is parametrized with the following parameters:
</p>

<ul>
<li> Lw is the turbulence scale.<br>In low altitudes, it is equal to the flight altitude.</li>
<li> sigma is the turbulence intensity.<br>In low altitudes, it is equal to 1/10 of the
     wind speed at 20 ft altitude, which is 30 kts for medium turbulence.</li>
<li> Omega is the spatial frequency.<br> The turbulence model is thus defined in space and the aircraft experiences turbulence as it flies through the defined wind field.</li>
<li> Omega = s/V will be used to transform the spatial definition into a temporal definition, which can be realized as a state space system.</li>
<li> V is the airspeed of the aircraft.<br>It is approximately 150 kts during the approach (i.e. at low altitudes).</li>
</ul>

<p>
Using spectral factorization and a fixed airspeed V of the aircraft, a concrete forming filter for the vertical turbulence can be found as
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/equation-W0zl2Gay.png\" alt=\"H_w(s) = sigma*sqrt(L_w/(pi*V)) * ((1 + sqrt(3)*L_w/V*s) / (1+L_w/V*s)^2)\"/>,
</div>

<p>
for which V * (H_w(i Omega/V) * H_w(-i Omega/V) = Phi_w(Omega).
</p>

<h4>The input to the filter</h4>

<p>
The input to the filter is white noise with a normal distribution, zero mean, and a power spectral density of 1.
That means, for a sampling time of 1s, it is parameterized with mean=0 and variance=1.
However, in order to account for the change of noise power due to sampling, the noise must be scaled with sqrt(samplePeriod).
This is done automatically in the
<a href=\"modelica://Modelica.Blocks.Noise.BandLimitedWhiteNoise\">BandLimitedWhiteNoise</a> block.
</p>

<h4>Example output</h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/DrydenContinuousTurbulence.png\"/>
</div>

<h4>Reference</h4>

<ol>
<li>Dryden Wind Turbulence model in US military standard
    <a href=\"http://everyspec.com/MIL-SPECS/MIL-SPECS-MIL-F/MIL-F-8785C_5295/\">MIL-F-8785</a>.</li>
</ol>
</html>"));
    end DrydenContinuousTurbulence;

    package Utilities "Library of utility models used in the examples"
      extends Modelica.Icons.UtilitiesPackage;

      block UniformDensity "Calculates the density of a uniform distribution"
        import distribution = Modelica.Math.Distributions.Uniform.density;
        extends Modelica.Blocks.Icons.Block;

        parameter Real u_min "Lower limit of u";
        parameter Real u_max "Upper limit of u";

        Modelica.Blocks.Interfaces.RealInput u "Real input signal" annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.RealOutput y
          "Density of the input signal according to the uniform probability density function"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      equation
        y = distribution(u, u_min, u_max);

        annotation (Icon(graphics={
              Polygon(
                points={{0,94},{-8,72},{8,72},{0,94}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{0,76},{0,-72}}, color={192,192,192}),
              Line(points={{-86,-82},{72,-82}},
                                            color={192,192,192}),
              Polygon(
                points={{92,-82},{70,-74},{70,-90},{92,-82}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
          Line( points={{-70,-75.953},{-66.5,-75.8975},{-63,-75.7852},{-59.5,
                -75.5674},{-56,-75.1631},{-52.5,-74.4442},{-49,-73.2213},{
                -45.5,-71.2318},{-42,-68.1385},{-38.5,-63.5468},{-35,-57.0467},
                {-31.5,-48.2849},{-28,-37.0617},{-24.5,-23.4388},{-21,-7.8318},
                {-17.5,8.9428},{-14,25.695},{-10.5,40.9771},{-7,53.2797},{
                -3.5,61.2739},{0,64.047},{3.5,61.2739},{7,53.2797},{10.5,
                40.9771},{14,25.695},{17.5,8.9428},{21,-7.8318},{24.5,
                -23.4388},{28,-37.0617},{31.5,-48.2849},{35,-57.0467},{38.5,
                -63.5468},{42,-68.1385},{45.5,-71.2318},{49,-73.2213},{52.5,
                -74.4442},{56,-75.1631},{59.5,-75.5674},{63,-75.7852},{66.5,
                -75.8975},{70,-75.953}},
                smooth=Smooth.Bezier)}), Documentation(info="<html>
<p>
This block determines the probability density y of a uniform distribution for the given input signal u
(for details of this density function see
<a href=\"modelica://Modelica.Math.Distributions.Uniform.density\">Math.Distributions.Uniform.density</a>).
</p>

<p>
This block is demonstrated in the example
<a href=\"modelica://Modelica.Blocks.Examples.Noise.Densities\">Examples.Noise.Densities</a> .
</p>
</html>",       revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
      end UniformDensity;

      block NormalDensity "Calculates the density of a normal distribution"
        import distribution = Modelica.Math.Distributions.Normal.density;
        extends Modelica.Blocks.Icons.Block;

        parameter Real mu "Expectation (mean) value of the normal distribution";
        parameter Real sigma "Standard deviation of the normal distribution";

        Modelica.Blocks.Interfaces.RealInput u "Real input signal" annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.RealOutput y
          "Density of the input signal according to the normal probability density function"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      equation
        y = distribution(u, mu, sigma);

        annotation (Icon(graphics={
              Polygon(
                points={{0,94},{-8,72},{8,72},{0,94}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{0,76},{0,-72}}, color={192,192,192}),
              Line(points={{-86,-82},{72,-82}},
                                            color={192,192,192}),
              Polygon(
                points={{92,-82},{70,-74},{70,-90},{92,-82}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
          Line( points={{-70,-75.953},{-66.5,-75.8975},{-63,-75.7852},{-59.5,
                -75.5674},{-56,-75.1631},{-52.5,-74.4442},{-49,-73.2213},{
                -45.5,-71.2318},{-42,-68.1385},{-38.5,-63.5468},{-35,-57.0467},
                {-31.5,-48.2849},{-28,-37.0617},{-24.5,-23.4388},{-21,-7.8318},
                {-17.5,8.9428},{-14,25.695},{-10.5,40.9771},{-7,53.2797},{
                -3.5,61.2739},{0,64.047},{3.5,61.2739},{7,53.2797},{10.5,
                40.9771},{14,25.695},{17.5,8.9428},{21,-7.8318},{24.5,
                -23.4388},{28,-37.0617},{31.5,-48.2849},{35,-57.0467},{38.5,
                -63.5468},{42,-68.1385},{45.5,-71.2318},{49,-73.2213},{52.5,
                -74.4442},{56,-75.1631},{59.5,-75.5674},{63,-75.7852},{66.5,
                -75.8975},{70,-75.953}},
                smooth=Smooth.Bezier)}), Documentation(info="<html>
<p>
This block determines the probability density y of a normal distribution for the given input signal u
(for details of this density function see
<a href=\"modelica://Modelica.Math.Distributions.Normal.density\">Math.Distributions.Normal.density</a>).
</p>

<p>
This block is demonstrated in the example
<a href=\"modelica://Modelica.Blocks.Examples.Noise.Densities\">Examples.Noise.Densities</a> .
</p>
</html>",       revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
      end NormalDensity;

      block WeibullDensity "Calculates the density of a Weibull distribution"
        import distribution = Modelica.Math.Distributions.Weibull.density;
        extends Modelica.Blocks.Icons.Block;

        parameter Real lambda(min=0)
          "Scale parameter of the Weibull distribution";
        parameter Real k(min=0) "Shape parameter of the Weibull distribution";

        Modelica.Blocks.Interfaces.RealInput u "Real input signal" annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.RealOutput y
          "Density of the input signal according to the Weibull probability density function"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      equation
        y = distribution(u, lambda, k);

        annotation (Icon(graphics={
              Polygon(
                points={{0,94},{-8,72},{8,72},{0,94}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{0,76},{0,-72}}, color={192,192,192}),
              Line(points={{-86,-82},{72,-82}},
                                            color={192,192,192}),
              Polygon(
                points={{92,-82},{70,-74},{70,-90},{92,-82}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
          Line( points={{-70,-75.953},{-66.5,-75.8975},{-63,-75.7852},{-59.5,
                -75.5674},{-56,-75.1631},{-52.5,-74.4442},{-49,-73.2213},{
                -45.5,-71.2318},{-42,-68.1385},{-38.5,-63.5468},{-35,-57.0467},
                {-31.5,-48.2849},{-28,-37.0617},{-24.5,-23.4388},{-21,-7.8318},
                {-17.5,8.9428},{-14,25.695},{-10.5,40.9771},{-7,53.2797},{
                -3.5,61.2739},{0,64.047},{3.5,61.2739},{7,53.2797},{10.5,
                40.9771},{14,25.695},{17.5,8.9428},{21,-7.8318},{24.5,
                -23.4388},{28,-37.0617},{31.5,-48.2849},{35,-57.0467},{38.5,
                -63.5468},{42,-68.1385},{45.5,-71.2318},{49,-73.2213},{52.5,
                -74.4442},{56,-75.1631},{59.5,-75.5674},{63,-75.7852},{66.5,
                -75.8975},{70,-75.953}},
                smooth=Smooth.Bezier)}), Documentation(info="<html>
<p>
This block determines the probability density y of a Weibull distribution for the given input signal u
(for details of this density function see
<a href=\"modelica://Modelica.Math.Distributions.Weibull.density\">Math.Distributions.Weibull.density</a>).
</p>

<p>
This block is demonstrated in the example
<a href=\"modelica://Modelica.Blocks.Examples.Noise.Densities\">Examples.Noise.Densities</a> .
</p>
</html>",       revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
      end WeibullDensity;

      block ImpureRandom
        "Block generating random numbers with the impure random number generator"
        extends Modelica.Blocks.Interfaces.SO;

        parameter SI.Period samplePeriod
          "Sample period for random number generation";

      protected
         outer Modelica.Blocks.Noise.GlobalSeed globalSeed;

      equation
         when {initial(), sample(samplePeriod,samplePeriod)} then
            y = Modelica.Math.Random.Utilities.impureRandom(globalSeed.id_impure);
         end when;
        annotation (Documentation(info="<html>
<p>
This block demonstrates how to implement a block using the impure
random number generator. This block is used in the example
<a href=\"modelica://Modelica.Blocks.Examples.Noise.ImpureGenerator\">Examples.Noise.ImpureGenerator</a>.
</p>
</html>",       revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
      end ImpureRandom;

      package Parts "Parts for use in the ActuatorWithNoise examples"
        extends Modelica.Icons.Package;

        model MotorWithCurrentControl
          "Synchronous machine with current controller and measurement noise"
          extends Modelica.Electrical.Machines.Icons.TransientMachine;
          constant Integer m=3 "Number of phases";
          parameter SI.Voltage VNominal=100
            "Nominal RMS voltage per phase";
          parameter SI.Frequency fNominal=50 "Nominal frequency";
          parameter SI.Frequency f=50 "Actual frequency";
          parameter SI.Time tRamp=1 "Frequency ramp";
          parameter SI.Torque TLoad=181.4 "Nominal load torque";
          parameter SI.Time tStep=1.2 "Time of load torque step";
          parameter SI.Inertia JLoad=0.29 "Load's moment of inertia";

          Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_PermanentMagnet
            smpm(
            p=smpmData.p,
            fsNominal=smpmData.fsNominal,
            Rs=smpmData.Rs,
            TsRef=smpmData.TsRef,
            Lszero=smpmData.Lszero,
            Lssigma=smpmData.Lssigma,
            Jr=smpmData.Jr,    Js=smpmData.Js,
            frictionParameters=smpmData.frictionParameters,
            wMechanical(fixed=true),
            statorCoreParameters=smpmData.statorCoreParameters,
            strayLoadParameters=smpmData.strayLoadParameters,
            VsOpenCircuit=smpmData.VsOpenCircuit,
            Lmd=smpmData.Lmd,
            Lmq=smpmData.Lmq,
            useDamperCage=smpmData.useDamperCage,
            Lrsigmad=smpmData.Lrsigmad,
            Lrsigmaq=smpmData.Lrsigmaq,
            Rrd=smpmData.Rrd,
            Rrq=smpmData.Rrq,
            TrRef=smpmData.TrRef,
            permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
            phiMechanical(fixed=true),
            TsOperational=293.15,
            alpha20s=smpmData.alpha20s,
            TrOperational=293.15,
            alpha20r=smpmData.alpha20r)
            annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
          Modelica.Electrical.Polyphase.Sources.SignalCurrent signalCurrent(final m=m)
            annotation (Placement(transformation(
                origin={-10,50},
                extent={{-10,10},{10,-10}},
                rotation=270)));
          Modelica.Electrical.Polyphase.Basic.Star star(final m=m)
            annotation (Placement(transformation(extent={{-10,80},{-30,100}})));
          Modelica.Electrical.Analog.Basic.Ground ground
            annotation (Placement(transformation(
                origin={-50,90},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Machines.Utilities.DQToThreePhase dqToThreePhase(
              p=smpm.p)
            annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
          Modelica.Electrical.Polyphase.Basic.Star starM(final m=m) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-60,-10})));
          Modelica.Electrical.Analog.Basic.Ground groundM
            annotation (Placement(transformation(
                origin={-80,-28},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
              terminalConnection="Y") annotation (Placement(transformation(extent={{-20,-30},
                    {0,-10}})));
          Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smpm.p)
            annotation (Placement(transformation(
                origin={20,-40},
                extent={{-10,10},{10,-10}},
                rotation=270)));
          Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={10,0})));
          Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor annotation (
              Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={50,-40})));
          Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={30,0})));
          Modelica.Electrical.Machines.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={-30,-10})));
          Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
            annotation (Placement(transformation(
                origin={-10,0},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(J=0.29)
            annotation (Placement(transformation(extent={{70,-50},{90,-30}})));
          parameter
            Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
            smpmData(useDamperCage=false) "Data for motor"
            annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
          Modelica.Blocks.Sources.Constant id(k=0)
            annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
          Modelica.Blocks.Interfaces.RealInput iq_rms1 annotation (Placement(
                transformation(extent={{-140,40},{-100,80}}),iconTransformation(extent={{-140,40},
                    {-100,80}})));
          Modelica.Mechanics.Rotational.Interfaces.Flange_b flange
            "Right flange of shaft"
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));
          Modelica.Blocks.Interfaces.RealOutput phi(unit="rad")
            "Absolute angle of flange as output signal" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={110,80}), iconTransformation(extent={{40,70},{60,90}})));
          output Real phi_motor(unit="rad", displayUnit="deg")=angleSensor.phi
            "Rotational position";
          output Real w(unit="rad/s")=speedSensor.w "Rotational speed";
          Modelica.Blocks.Math.Add addNoise
            annotation (Placement(transformation(extent={{60,70},{80,90}})));
          .Modelica.Blocks.Noise.UniformNoise uniformNoise(
            samplePeriod=1/200,
            y_min=-0.01,
            y_max=0.01) annotation (Placement(transformation(extent={{26,76},{46,96}})));
        equation
          connect(star.pin_n, ground.p) annotation (Line(points={{-30,90},{-40,90}}, color={0,0,255}));
          connect(rotorDisplacementAngle.plug_n, smpm.plug_sn) annotation (Line(
                points={{26,-30},{26,-20},{-16,-20},{-16,-30}}, color={0,0,255}));
          connect(rotorDisplacementAngle.plug_p, smpm.plug_sp) annotation (Line(
                points={{14,-30},{6,-30},{-4,-30}}, color={0,0,255}));
          connect(terminalBox.plug_sn, smpm.plug_sn) annotation (Line(
              points={{-16,-26},{-16,-30}}, color={0,0,255}));
          connect(terminalBox.plug_sp, smpm.plug_sp) annotation (Line(
              points={{-4,-26},{-4,-30}}, color={0,0,255}));
          connect(smpm.flange, rotorDisplacementAngle.flange) annotation (Line(
              points={{0,-40},{6,-40},{10,-40}}));
          connect(signalCurrent.plug_p, star.plug_p) annotation (Line(
              points={{-10,60},{-10,90}}, color={0,0,255}));
          connect(angleSensor.flange, rotorDisplacementAngle.flange) annotation (Line(
              points={{10,-10},{10,-40}}));
          connect(angleSensor.phi, dqToThreePhase.phi) annotation (Line(points={{10,11},
                  {10,30},{-40,30},{-40,38}},          color={0,0,127}));
          connect(groundM.p, terminalBox.starpoint) annotation (Line(
              points={{-70,-28},{-20,-28},{-20,-24}}, color={0,0,255}));
          connect(smpm.flange, torqueSensor.flange_a) annotation (Line(
              points={{0,-40},{40,-40}}));
          connect(voltageQuasiRMSSensor.plug_p, terminalBox.plugSupply) annotation (
              Line(
              points={{-20,-10},{-10,-10},{-10,-24}}, color={0,0,255}));
          connect(starM.plug_p, voltageQuasiRMSSensor.plug_n) annotation (Line(
              points={{-50,-10},{-40,-10}}, color={0,0,255}));
          connect(starM.pin_n, groundM.p) annotation (Line(
              points={{-70,-10},{-70,-28}}, color={0,0,255}));
          connect(dqToThreePhase.y, signalCurrent.i) annotation (Line(points={{
                  -29,50},{-22,50},{-22,50}}, color={0,0,127}));
          connect(speedSensor.flange, smpm.flange) annotation (Line(
              points={{30,-10},{30,-40},{0,-40}}));
          connect(torqueSensor.flange_b, inertiaLoad.flange_a) annotation (Line(
              points={{60,-40},{60,-40},{70,-40}}));
          connect(signalCurrent.plug_n, currentQuasiRMSSensor.plug_p) annotation (
             Line(
              points={{-10,40},{-10,10}}, color={0,0,255}));
          connect(currentQuasiRMSSensor.plug_n, voltageQuasiRMSSensor.plug_p)
            annotation (Line(
              points={{-10,-10},{-20,-10}}, color={0,0,255}));
          connect(inertiaLoad.flange_b, flange) annotation (Line(
              points={{90,-40},{90,-40},{90,0},{100,0}}));
          connect(angleSensor.phi, addNoise.u2) annotation (Line(
              points={{10,11},{10,30},{50,30},{50,74},{58,74}}, color={0,0,127}));
          connect(addNoise.y, phi) annotation (Line(
              points={{81,80},{110,80}}, color={0,0,127}));
          connect(uniformNoise.y, addNoise.u1) annotation (Line(
              points={{47,86},{58,86}}, color={0,0,127}));
          connect(id.y, dqToThreePhase.d) annotation (Line(points={{-69,70},{-60,
                  70},{-60,56},{-52,56}}, color={0,0,127}));
          connect(iq_rms1, dqToThreePhase.q) annotation (Line(points={{-120,60},
                  {-100,60},{-100,44},{-52,44}}, color={0,0,127}));
          annotation (
            Documentation(info="<html>
<p>
A synchronous machine with permanent magnets, current controller and
measurement noise of &plusmn;0.01 rad accelerates a quadratic speed dependent load from standstill.
The rms values of d- and q-current in rotor fixed coordinate system are converted to three-phase currents,
and fed to the machine. The result shows that the torque is influenced by the q-current,
whereas the stator voltage is influenced by the d-current.
</p>

<p>
Default machine parameters of model
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_PermanentMagnet\">SM_PermanentMagnet</a>
are used.
</p>

<p>
This motor is used in the
<a href=\"modelica://Modelica.Blocks.Examples.Noise.ActuatorWithNoise\">Examples.Noise.ActuatorWithNoise</a>
actuator example
</p>
</html>",         revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                    100}}), graphics={Rectangle(
                  extent={{40,50},{-100,100}},
                  fillColor={255,170,85},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None), Text(
                extent={{-150,150},{150,110}},
                textString="%name",
                textColor={0,0,255})}));
        end MotorWithCurrentControl;

        model Controller "Simple position controller for actuator"
          extends Modelica.Blocks.Icons.Block;

          Modelica.Blocks.Continuous.PI speed_PI(k=10, T=5e-2,
            initType=Modelica.Blocks.Types.Init.InitialOutput)
            annotation (Placement(transformation(extent={{38,-10},{58,10}})));
          Modelica.Blocks.Math.Feedback speedFeedback
            annotation (Placement(transformation(extent={{10,-10},{30,10}})));
          Modelica.Blocks.Continuous.Derivative positionToSpeed(initType=Modelica.Blocks.Types.Init.InitialOutput,
              T=0.01)
            annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
          Modelica.Blocks.Interfaces.RealInput positionMeasured
            "Position signal of motor"
            annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
          Modelica.Blocks.Interfaces.RealInput positionReference
            "Reference position"
            annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
          Modelica.Blocks.Interfaces.RealOutput y1
            "Connector of Real output signal"
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
          Modelica.Blocks.Continuous.PI position_PI(T=5e-1, k=3,
            initType=Modelica.Blocks.Types.Init.InitialState)
            annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
          Modelica.Blocks.Math.Feedback positionFeedback
            annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
          Modelica.Blocks.Continuous.FirstOrder busdelay(T=1e-3, initType=Modelica.Blocks.Types.Init.InitialOutput)
            annotation (Placement(transformation(extent={{68,-10},{88,10}})));
        equation
          connect(speedFeedback.y, speed_PI.u) annotation (Line(
              points={{29,0},{36,0}}, color={0,0,127}));
          connect(positionFeedback.u2, positionToSpeed.u) annotation (Line(
              points={{-80,52},{-80,-60},{-62,-60}}, color={0,0,127}));
          connect(positionReference, positionFeedback.u1) annotation (Line(
              points={{-120,60},{-88,60}}, color={0,0,127}));
          connect(positionFeedback.y, position_PI.u) annotation (Line(
              points={{-71,60},{-62,60}}, color={0,0,127}));
          connect(position_PI.y, speedFeedback.u1) annotation (Line(
              points={{-39,60},{0,60},{0,0},{12,0}}, color={0,0,127}));
          connect(speed_PI.y, busdelay.u) annotation (Line(
              points={{59,0},{66,0}}, color={0,0,127}));
          connect(y1, busdelay.y) annotation (Line(
              points={{110,0},{89,0}}, color={0,0,127}));
          connect(positionMeasured, positionToSpeed.u) annotation (Line(
              points={{-120,-60},{-62,-60}}, color={0,0,127}));
          connect(positionToSpeed.y, speedFeedback.u2) annotation (Line(
              points={{-39,-60},{20,-60},{20,-8}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                Text(
                  extent={{-40,50},{40,-30}},
                  textColor={0,0,255},
                  textString="PI")}),
            Documentation(revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>",         info="<html>
<p>
A simple position controller for a drive system.
This controller is used in the
<a href=\"modelica://Modelica.Blocks.Examples.Noise.ActuatorWithNoise\">Examples.Noise.ActuatorWithNoise</a>
actuator example
</p>
</html>"));
        end Controller;
      annotation (Documentation(revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>",       info="<html>
<p>
Parts used in the
<a href=\"modelica://Modelica.Blocks.Examples.Noise.ActuatorWithNoise\">Examples.Noise.ActuatorWithNoise</a>
actuator example
</p>
</html>"));
      end Parts;
    annotation (Documentation(info="<html>
<p>
This package contains utility models that are used for the examples.
</p>
</html>",     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end Utilities;
  annotation (Documentation(info="<html>
<p>
This package contains various example models that demonstrates how
to utilize the blocks from sublibrary
<a href=\"modelica://Modelica.Blocks.Noise\">Blocks.Noise</a>.
</p>
</html>",   revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end Noise;

  package BusUsage_Utilities
    "Utility models and connectors for example Modelica.Blocks.Examples.BusUsage"
    extends Modelica.Icons.UtilitiesPackage;
    package Interfaces "Interfaces specialised for this example"
      extends Modelica.Icons.InterfacesPackage;

      expandable connector ControlBus
        "Control bus that is adapted to the signals connected to it"
        extends Modelica.Icons.SignalBus;

        SI.AngularVelocity realSignal1 "First Real signal (angular velocity)"
          annotation (HideResult=false);
        SI.Velocity realSignal2 "Second Real signal"
          annotation (HideResult=false);
        Integer integerSignal "Integer signal" annotation (HideResult=false);
        Boolean booleanSignal "Boolean signal" annotation (HideResult=false);
        SubControlBus subControlBus "Combined signal"
          annotation (HideResult=false);
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Rectangle(
                        extent={{-20,2},{22,-2}},
                        lineColor={255,204,51},
                        lineThickness=0.5)}), Documentation(info="<html>
<p>
This connector defines the \"expandable connector\" ControlBus that
is used as bus in the
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a> example.
Note, this connector contains \"default\" signals that might be utilized
in a connection (the input/output causalities of the signals
are determined from the connections to this bus).
</p>
</html>"));

      end ControlBus;

      expandable connector SubControlBus
        "Sub-control bus that is adapted to the signals connected to it"
        extends Modelica.Icons.SignalSubBus;
        Real myRealSignal annotation (HideResult=false);
        Boolean myBooleanSignal annotation (HideResult=false);
        annotation (
          defaultComponentPrefixes="protected",
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Rectangle(
                        extent={{-20,2},{22,-2}},
                        lineColor={255,204,51},
                        lineThickness=0.5)}),
          Documentation(info="<html>
<p>
This connector defines the \"expandable connector\" SubControlBus that
is used as sub-bus in the
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a> example.
Note, this is an expandable connector which has a \"default\" set of
signals (the input/output causalities of the signals are
determined from the connections to this bus).
</p>
</html>"));

      end SubControlBus;

      annotation (Documentation(info="<html>
<p>
This package contains the bus definitions needed for the
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a> example.
</p>
</html>"));
    end Interfaces;

    model Part "Component with sub-control bus"

      Interfaces.SubControlBus subControlBus annotation (Placement(
            transformation(
            origin={100,0},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Sources.RealExpression realExpression(y=time) annotation (Placement(
            transformation(extent={{-6,0},{20,20}})));
      Sources.BooleanExpression booleanExpression(y=time >= 0.5) annotation (
          Placement(transformation(extent={{-6,-30},{20,-10}})));
    equation
      connect(realExpression.y, subControlBus.myRealSignal) annotation (Line(
          points={{21.3,10},{88,10},{88,6},{98,6},{98,0},{100,0}}, color={0,0,127}));
      connect(booleanExpression.y, subControlBus.myBooleanSignal) annotation (
          Line(
          points={{21.3,-20},{60,-20},{60,0},{100,0}}, color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-100,60},{100,-60}},
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,127}), Text(
              extent={{-106,124},{114,68}},
              textString="%name",
              textColor={0,0,255})}), Documentation(info="<html>
<p>
This model is used to demonstrate the bus usage in example
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a>.
</p>
</html>"));
    end Part;

    annotation (Documentation(info="<html>
<p>
This package contains utility models and bus definitions needed for the
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a> example.
</p>
</html>"));
  end BusUsage_Utilities;
  annotation (Documentation(info="<html>
<p>
This package contains example models to demonstrate the
usage of package blocks.
</p>
</html>"));
end Examples;

annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
      Rectangle(
        origin={0.0,35.1488},
        fillColor={255,255,255},
        extent={{-30.0,-20.1488},{30.0,20.1488}}),
      Rectangle(
        origin={0.0,-34.8512},
        fillColor={255,255,255},
        extent={{-30.0,-20.1488},{30.0,20.1488}}),
      Line(
        origin={-51.25,0.0},
        points={{21.25,-35.0},{-13.75,-35.0},{-13.75,35.0},{6.25,35.0}}),
      Polygon(
        origin={-40.0,35.0},
        pattern=LinePattern.None,
        fillPattern=FillPattern.Solid,
        points={{10.0,0.0},{-5.0,5.0},{-5.0,-5.0}}),
      Line(
        origin={51.25,0.0},
        points={{-21.25,35.0},{13.75,35.0},{13.75,-35.0},{-6.25,-35.0}}),
      Polygon(
        origin={40.0,-35.0},
        pattern=LinePattern.None,
        fillPattern=FillPattern.Solid,
        points={{-10.0,0.0},{5.0,5.0},{5.0,-5.0}})}), Documentation(info="<html>
<p>
This library contains input/output blocks to build up block diagrams.
</p>

<dl>
<dt><strong>Main Author:</strong></dt>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e. V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a><br></dd>
</dl>
<p>
Copyright &copy; 1998-2020, Modelica Association and contributors
</p>
</html>", revisions="<html>
<ul>
<li><em>June 23, 2004</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Introduced new block connectors and adapted all blocks to the new connectors.
       Included subpackages Continuous, Discrete, Logical, Nonlinear from
       package ModelicaAdditions.Blocks.
       Included subpackage ModelicaAdditions.Table in Modelica.Blocks.Sources
       and in the new package Modelica.Blocks.Tables.
       Added new blocks to Blocks.Sources and Blocks.Logical.
       </li>
<li><em>October 21, 2002</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and Christian Schweiger:<br>
       New subpackage Examples, additional components.
       </li>
<li><em>June 20, 2000</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and
       Michael Tiller:<br>
       Introduced a replaceable signal type into
       Blocks.Interfaces.RealInput/RealOutput:
<blockquote><pre>
replaceable type SignalType = Real
</pre></blockquote>
       in order that the type of the signal of an input/output block
       can be changed to a physical type, for example:
<blockquote><pre>
Sine sin1(outPort(redeclare type SignalType=Modelica.Units.SI.Torque))
</pre></blockquote>
      </li>
<li><em>Sept. 18, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Renamed to Blocks. New subpackages Math, Nonlinear.
       Additional components in subpackages Interfaces, Continuous
       and Sources.</li>
<li><em>June 30, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>"));
end Blocks;
