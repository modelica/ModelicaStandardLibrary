within Modelica.Blocks.Examples;
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
</html>"),
         experiment(StopTime=1.0));
end InverseModel;
