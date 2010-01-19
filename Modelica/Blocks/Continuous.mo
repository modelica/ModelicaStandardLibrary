within Modelica.Blocks;
package Continuous "Library of continuous control blocks with internal states"

  import Modelica.Blocks.Interfaces;
  import Modelica.SIunits;
  extends Modelica.Icons.Library;

  block Integrator "Output the integral of the input signal"
    import Modelica.Blocks.Types.Init;
    parameter Real k=1 "Integrator gain";

    /* InitialState is the default, because it was the default in Modelica 2.2
     and therefore this setting is backward compatible
  */
    parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
      "Type of initialization (1: no init, 2: steady state, 3,4: initial output)"
                                                                                      annotation(Evaluate=true,
        Dialog(group="Initialization"));
    parameter Real y_start=0 "Initial or guess value of output (= state)"
      annotation (Dialog(group="Initialization"));
    extends Interfaces.SISO(y(start=y_start));

  initial equation
    if initType == Init.SteadyState then
       der(y) = 0;
    elseif initType == Init.InitialState or
           initType == Init.InitialOutput then
      y = y_start;
    end if;
  equation
    der(y) = k*u;
    annotation (
      Documentation(info="<html>
<p>
This blocks computes output <b>y</b> (element-wise) as
<i>integral</i> of the input <b>u</b> multiplied with
the gain <i>k</i>:
</p>
<pre>
         k
     y = - u
         s
</pre>

<p>
It might be difficult to initialize the integrator in steady state.
This is discussed in the description of package
<a href=\"Modelica://Modelica.Blocks.Continuous#info\">Continuous</a>.
</p>

</html>
"),   Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
          Polygon(
            points={{90,-80},{68,-72},{68,-88},{90,-80}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{0,-10},{60,-70}},
            lineColor={192,192,192},
            textString="I"),
          Text(
            extent={{-150,-150},{150,-110}},
            lineColor={0,0,0},
            textString="k=%k"),
          Line(points={{-80,-80},{80,80}}, color={0,0,127})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Line(points={{-100,0},{-60,0}}, color={0,0,255}),
          Line(points={{60,0},{100,0}}, color={0,0,255}),
          Text(
            extent={{-36,60},{32,2}},
            lineColor={0,0,0},
            textString="k"),
          Text(
            extent={{-32,0},{36,-58}},
            lineColor={0,0,0},
            textString="s"),
          Line(points={{-46,0},{46,0}}, color={0,0,0})}));
  end Integrator;

  block LimIntegrator "Integrator with limited value of the output"
    import Modelica.Blocks.Types.Init;
    parameter Real k=1 "Integrator gain";
    parameter Real outMax(start=1) "Upper limit of output";
    parameter Real outMin=-outMax "Lower limit of output";
    parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
      "Type of initialization (1: no init, 2: steady state, 3/4: initial output)"
      annotation(Evaluate=true, Dialog(group="Initialization"));
    parameter Boolean limitsAtInit = true
      "= false, if limits are ignored during initializiation (i.e., der(y)=k*u)"
      annotation(Evaluate=true, Dialog(group="Initialization"));
    parameter Real y_start=0
      "Initial or guess value of output (must be in the limits outMin .. outMax)"
      annotation (Dialog(group="Initialization"));
    extends Interfaces.SISO(y(start=y_start));

  initial equation
    if initType == Init.SteadyState then
       der(y) = 0;
    elseif initType == Init.InitialState or
           initType == Init.InitialOutput then
      y = y_start;
    end if;
  equation
    if initial() and not limitsAtInit then
       der(y) = k*u;
       assert(y >= outMin - 0.01*abs(outMin) and
              y <= outMax + 0.01*abs(outMax),
             "LimIntegrator: During initialization the limits have been ignored.\n"+
             "However, the result is that the output y is not within the required limits:\n"+
             "  y = " + String(y) + ", outMin = " + String(outMin) + ", outMax = " + String(outMax));
    else
       der(y) = if y < outMin and u < 0 or y > outMax and u > 0 then 0 else k*u;
    end if;
    annotation (
      Documentation(info="<html>
<p>
This blocks computes <b>y</b> (element-wise) as <i>integral</i>
of the input <b>u</b> multiplied with the gain <i>k</i>. If the
integral reaches a given upper or lower <i>limit</i> and the
input will drive the integral outside of this bound, the
integration is halted and only restarted if the input drives
the integral away from the bounds.
</p>

<p>
It might be difficult to initialize the integrator in steady state.
This is discussed in the description of package
<a href=\"Modelica://Modelica.Blocks.Continuous#info\">Continuous</a>.
</p>

<p>
If parameter <b>limitAtInit</b> = <b>false</b>, the limits of the
integrator are removed from the initialization problem which
leads to a much simpler equation system. After initialization has been
performed, it is checked via an assert whether the output is in the
defined limits. For backward compatibility reasons
<b>limitAtInit</b> = <b>true</b>. In most cases it is best
to use <b>limitAtInit</b> = <b>false</b>.
</p>
</html>
"),   Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
          Polygon(
            points={{90,-80},{68,-72},{68,-88},{90,-80}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{20,20},{80,20}}, color={0,0,127}),
          Text(
            extent={{0,-10},{60,-70}},
            lineColor={192,192,192},
            textString="I"),
          Text(
            extent={{-150,-150},{150,-110}},
            lineColor={0,0,0},
            textString="k=%k")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Text(
            extent={{-54,46},{-4,-48}},
            lineColor={0,0,0},
            textString="lim"),
          Line(points={{-100,0},{-60,0}}, color={0,0,255}),
          Line(points={{60,0},{100,0}}, color={0,0,255}),
          Text(
            extent={{-8,60},{60,2}},
            lineColor={0,0,0},
            textString="k"),
          Text(
            extent={{-8,-2},{60,-60}},
            lineColor={0,0,0},
            textString="s"),
          Line(points={{4,0},{46,0}}, color={0,0,0})}));
  end LimIntegrator;

  block Derivative "Approximated derivative block"
    import Modelica.Blocks.Types.Init;
    parameter Real k=1 "Gains";
    parameter SIunits.Time T(min=Modelica.Constants.small) = 0.01
      "Time constants (T>0 required; T=0 is ideal derivative block)";
    parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
      "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
                                                                                      annotation(Evaluate=true,
        Dialog(group="Initialization"));
    parameter Real x_start=0 "Initial or guess value of state"
      annotation (Dialog(group="Initialization"));
    parameter Real y_start=0 "Initial value of output (= state)"
      annotation(Dialog(enable=initType == Init.InitialOutput, group=
            "Initialization"));
    extends Interfaces.SISO;

    output Real x(start=x_start) "State of block";

  protected
    parameter Boolean zeroGain = abs(k) < Modelica.Constants.eps;
  initial equation
    if initType == Init.SteadyState then
      der(x) = 0;
    elseif initType == Init.InitialState then
      x = x_start;
    elseif initType == Init.InitialOutput then
      if zeroGain then
         x = u;
      else
         y = y_start;
      end if;
    end if;
  equation
    der(x) = if zeroGain then 0 else (u - x)/T;
    y = if zeroGain then 0 else (k/T)*(u - x);
    annotation (
      Documentation(info="
<HTML>
<p>
This blocks defines the transfer function between the
input u and the output y
(element-wise) as <i>approximated derivative</i>:
</p>
<pre>
             k * s
     y = ------------ * u
            T * s + 1
</pre>
<p>
If you would like to be able to change easily between different
transfer functions (FirstOrder, SecondOrder, ... ) by changing
parameters, use the general block <b>TransferFunction</b> instead
and model a derivative block with parameters<br>
b = {k,0}, a = {T, 1}.
</p>

<p>
If k=0, the block reduces to y=0.
</p>
</HTML>
"),   Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
          Polygon(
            points={{90,-80},{68,-72},{68,-88},{90,-80}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-80,60},{-70,17.95},{-60,-11.46},{-50,-32.05},
                {-40,-46.45},{-30,-56.53},{-20,-63.58},{-10,-68.51},{0,-71.96},
                {10,-74.37},{20,-76.06},{30,-77.25},{40,-78.07},{50,-78.65},{60,
                -79.06}}, color={0,0,127}),
          Text(
            extent={{-30,14},{86,60}},
            lineColor={192,192,192},
            textString="DT1"),
          Text(
            extent={{-150,-150},{150,-110}},
            lineColor={0,0,0},
            textString="k=%k")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Text(
            extent={{-54,52},{50,10}},
            lineColor={0,0,0},
            textString="k s"),
          Text(
            extent={{-54,-6},{52,-52}},
            lineColor={0,0,0},
            textString="T s + 1"),
          Line(points={{-50,0},{50,0}}, color={0,0,0}),
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Line(points={{-100,0},{-60,0}}, color={0,0,255}),
          Line(points={{60,0},{100,0}}, color={0,0,255})}));
  end Derivative;

  block FirstOrder "First order transfer function block (= 1 pole)"
    import Modelica.Blocks.Types.Init;
    parameter Real k=1 "Gain";
    parameter SIunits.Time T(start=1) "Time Constant";
    parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
      "Type of initialization (1: no init, 2: steady state, 3/4: initial output)"
                                                                                      annotation(Evaluate=true,
        Dialog(group="Initialization"));
    parameter Real y_start=0 "Initial or guess value of output (= state)"
      annotation (Dialog(group="Initialization"));

    extends Interfaces.SISO(y(start=y_start));

  initial equation
    if initType == Init.SteadyState then
      der(y) = 0;
    elseif initType == Init.InitialState or initType == Init.InitialOutput then
      y = y_start;
    end if;
  equation
    der(y) = (k*u - y)/T;
    annotation (
      Documentation(info="<HTML>
<p>
This blocks defines the transfer function between the input u
and the output y (element-wise) as <i>first order</i> system:
</p>
<pre>
               k
     y = ------------ * u
            T * s + 1
</pre>
<p>
If you would like to be able to change easily between different
transfer functions (FirstOrder, SecondOrder, ... ) by changing
parameters, use the general block <b>TransferFunction</b> instead
and model a first order SISO system with parameters<br>
b = {k}, a = {T, 1}.
</p>
<pre>
Example:
   parameter: k = 0.3, T = 0.4
   results in:
             0.3
      y = ----------- * u
          0.4 s + 1.0
</pre>

</HTML>
"),   Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,88},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
          Polygon(
            points={{90,-80},{68,-72},{68,-88},{90,-80}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-70,-45.11},{-60,-19.58},{-50,-0.9087},{-40,
                12.75},{-30,22.75},{-20,30.06},{-10,35.41},{0,39.33},{10,42.19},
                {20,44.29},{30,45.82},{40,46.94},{50,47.76},{60,48.36},{70,48.8},
                {80,49.12}}, color={0,0,127}),
          Text(
            extent={{0,0},{60,-60}},
            lineColor={192,192,192},
            textString="PT1"),
          Text(
            extent={{-150,-150},{150,-110}},
            lineColor={0,0,0},
            textString="T=%T")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Text(
            extent={{-48,52},{50,8}},
            lineColor={0,0,0},
            textString="k"),
          Text(
            extent={{-54,-6},{56,-56}},
            lineColor={0,0,0},
            textString="T s + 1"),
          Line(points={{-50,0},{50,0}}, color={0,0,0}),
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Line(points={{-100,0},{-60,0}}, color={0,0,255}),
          Line(points={{60,0},{100,0}}, color={0,0,255})}));
  end FirstOrder;

  block SecondOrder "Second order transfer function block (= 2 poles)"
    import Modelica.Blocks.Types.Init;
    parameter Real k=1 "Gain";
    parameter Real w(start=1) "Angular frequency";
    parameter Real D(start=1) "Damping";
    parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
      "Type of initialization (1: no init, 2: steady state, 3/4: initial output)"
                                                                                      annotation(Evaluate=true,
        Dialog(group="Initialization"));
    parameter Real y_start=0 "Initial or guess value of output (= state)"
      annotation (Dialog(group="Initialization"));
    parameter Real yd_start=0
      "Initial or guess value of derivative of output (= state)"
      annotation (Dialog(group="Initialization"));

    extends Interfaces.SISO(y(start=y_start));
    output Real yd(start=yd_start) "Derivative of y";

  initial equation
    if initType == Init.SteadyState then
      der(y) = 0;
      der(yd) = 0;
    elseif initType == Init.InitialState or initType == Init.InitialOutput then
      y = y_start;
      yd = yd_start;
    end if;
  equation
    der(y) = yd;
    der(yd) = w*(w*(k*u - y) - 2*D*yd);
    annotation (
      Documentation(info="<HTML>
<p>
This blocks defines the transfer function between the input u and
the output y (element-wise) as <i>second order</i> system:
</p>
<pre>
                             k
     y = ---------------------------------------- * u
            ( s / w )^2 + 2*D*( s / w ) + 1
</pre>
<p>
If you would like to be able to change easily between different
transfer functions (FirstOrder, SecondOrder, ... ) by changing
parameters, use the general model class <b>TransferFunction</b>
instead and model a second order SISO system with parameters<br>
b = {k}, a = {1/w^2, 2*D/w, 1}.
</p>
<pre>
Example:

   parameter: k =  0.3,  w = 0.5,  D = 0.4
   results in:
                  0.3
      y = ------------------- * u
          4.0 s^2 + 1.6 s + 1
</pre>

</HTML>
"),   Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,88},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
          Polygon(
            points={{90,-80},{68,-72},{68,-88},{90,-80}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-72,-68.53},{-64,-39.5},{-56,-2.522},{-48,
                32.75},{-40,58.8},{-32,71.51},{-24,70.49},{-16,58.45},{-8,40.06},
                {0,20.55},{8,4.459},{16,-5.271},{24,-7.629},{32,-3.428},{40,
                5.21},{48,15.56},{56,25.03},{64,31.66},{72,34.5},{80,33.61}},
              color={0,0,127}),
          Text(
            extent={{0,-10},{60,-70}},
            lineColor={192,192,192},
            textString="PT2"),
          Text(
            extent={{-150,-150},{150,-110}},
            lineColor={0,0,0},
            textString="w=%w")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Text(
            extent={{-60,60},{60,14}},
            lineColor={0,0,0},
            textString="k"),
          Text(
            extent={{-60,8},{-32,-20}},
            lineColor={0,0,0},
            textString="s"),
          Line(points={{-100,0},{-60,0}}, color={0,0,255}),
          Line(points={{60,0},{100,0}}, color={0,0,255}),
          Line(points={{-50,14},{50,14}}, color={0,0,0}),
          Line(points={{-54,-20},{-38,-20}}, color={0,0,0}),
          Text(
            extent={{-52,-26},{-36,-48}},
            lineColor={0,0,0},
            textString="w"),
          Line(points={{-50,2},{-56,-8},{-56,-28},{-52,-46}}, color={0,0,0}),
          Line(points={{-40,2},{-34,-10},{-34,-30},{-38,-46}}, color={0,0,0}),
          Text(
            extent={{-34,8},{-22,-10}},
            lineColor={0,0,0},
            textString="2"),
          Text(
            extent={{-34,-6},{6,-36}},
            lineColor={0,0,0},
            textString="+2D"),
          Text(
            extent={{2,8},{30,-20}},
            lineColor={0,0,0},
            textString="s"),
          Line(points={{8,-20},{24,-20}}, color={0,0,0}),
          Text(
            extent={{10,-26},{26,-48}},
            lineColor={0,0,0},
            textString="w"),
          Line(points={{12,2},{6,-8},{6,-28},{10,-46}}, color={0,0,0}),
          Line(points={{22,2},{28,-10},{28,-30},{24,-46}}, color={0,0,0}),
          Text(
            extent={{30,2},{58,-42}},
            lineColor={0,0,0},
            textString="+1")}));
  end SecondOrder;

  block PI "Proportional-Integral controller"
    import Modelica.Blocks.Types.Init;
    parameter Real k=1 "Gain";
    parameter SIunits.Time T(start=1,min=Modelica.Constants.small)
      "Time Constant (T>0 required)";
    parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
      "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
                                                                              annotation(Evaluate=true,
        Dialog(group="Initialization"));
    parameter Real x_start=0 "Initial or guess value of state"
      annotation (Dialog(group="Initialization"));
    parameter Real y_start=0 "Initial value of output"
      annotation(Dialog(enable=initType == Init.SteadyState or initType == Init.InitialOutput, group=
            "Initialization"));

    extends Interfaces.SISO;
    output Real x(start=x_start) "State of block";

  initial equation
    if initType == Init.SteadyState then
      der(x) = 0;
    elseif initType == Init.InitialState then
      x = x_start;
    elseif initType == Init.InitialOutput then
      y = y_start;
    end if;
  equation
    der(x) = u/T;
    y = k*(x + u);
    annotation (defaultComponentName="PI",
      Documentation(info="
<HTML>
<p>
This blocks defines the transfer function between the input u and
the output y (element-wise) as <i>PI</i> system:
</p>
<pre>
                 1
   y = k * (1 + ---) * u
                T*s
           T*s + 1
     = k * ------- * u
             T*s
</pre>
<p>
If you would like to be able to change easily between different
transfer functions (FirstOrder, SecondOrder, ... ) by changing
parameters, use the general model class <b>TransferFunction</b>
instead and model a PI SISO system with parameters<br>
b = {k*T, k}, a = {T, 0}.
</p>
<pre>
Example:

   parameter: k = 0.3,  T = 0.4

   results in:
               0.4 s + 1
      y = 0.3 ----------- * u
                 0.4 s
</pre>

<p>
It might be difficult to initialize the PI component in steady state
due to the integrator part.
This is discussed in the description of package
<a href=\"Modelica://Modelica.Blocks.Continuous#info\">Continuous</a>.
</p>

</HTML>
"),   Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,88},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
          Polygon(
            points={{90,-80},{68,-72},{68,-88},{90,-80}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-80,-20},{60,80}}, color={0,0,127}),
          Text(
            extent={{0,6},{60,-56}},
            lineColor={192,192,192},
            textString="PI"),
          Text(
            extent={{-150,-150},{150,-110}},
            lineColor={0,0,0},
            textString="T=%T")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Text(
            extent={{-68,24},{-24,-18}},
            lineColor={0,0,0},
            textString="k"),
          Text(
            extent={{-32,48},{60,0}},
            lineColor={0,0,0},
            textString="T s + 1"),
          Text(
            extent={{-30,-8},{52,-40}},
            lineColor={0,0,0},
            textString="T s"),
          Line(points={{-24,0},{54,0}}, color={0,0,0}),
          Line(points={{-100,0},{-60,0}}, color={0,0,255}),
          Line(points={{62,0},{100,0}}, color={0,0,255})}));
  end PI;

  block PID "PID-controller in additive description form"
    import Modelica.Blocks.Types.InitPID;
    extends Interfaces.SISO;

    parameter Real k=1 "Gain";
    parameter SIunits.Time Ti(min=Modelica.Constants.small, start=0.5)
      "Time Constant of Integrator";
    parameter SIunits.Time Td(min=0, start=0.1)
      "Time Constant of Derivative block";
    parameter Real Nd(min=Modelica.Constants.small) = 10
      "The higher Nd, the more ideal the derivative block";
    parameter Modelica.Blocks.Types.InitPID initType= Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState
      "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
                                       annotation(Evaluate=true,
        Dialog(group="Initialization"));
    parameter Real xi_start=0
      "Initial or guess value value for integrator output (= integrator state)"
      annotation (Dialog(group="Initialization"));
    parameter Real xd_start=0
      "Initial or guess value for state of derivative block"
      annotation (Dialog(group="Initialization"));
    parameter Real y_start=0 "Initial value of output"
      annotation(Dialog(enable=initType == Init.InitialOutput, group=
            "Initialization"));

    Blocks.Math.Gain P(k=1) "Proportional part of PID controller"
      annotation (Placement(transformation(extent={{-60,60},{-20,100}},
            rotation=0)));
    Blocks.Continuous.Integrator I(k=1/Ti, y_start=xi_start,
      initType=if initType==InitPID.SteadyState then
                  InitPID.SteadyState else
               if initType==InitPID.InitialState or
                  initType==InitPID.DoNotUse_InitialIntegratorState then
                  InitPID.InitialState else InitPID.NoInit)
      "Integral part of PID controller"
      annotation (Placement(transformation(extent={{-60,-20},{-20,20}},
            rotation=0)));
    Blocks.Continuous.Derivative D(k=Td, T=max([Td/Nd, 100*Modelica.
          Constants.eps]), x_start=xd_start,
      initType=if initType==InitPID.SteadyState or
                  initType==InitPID.InitialOutput then InitPID.SteadyState else
               if initType==InitPID.InitialState then InitPID.InitialState else
                  InitPID.NoInit) "Derivative part of PID controller"
      annotation (Placement(transformation(extent={{-60,-100},{-20,-60}},
            rotation=0)));
    Blocks.Math.Gain Gain(k=k) "Gain of PID controller"
      annotation (Placement(transformation(extent={{60,-10},{80,10}}, rotation=
              0)));
    Blocks.Math.Add3 Add annotation (Placement(transformation(extent={{20,-10},
              {40,10}}, rotation=0)));
  initial equation
    if initType==InitPID.InitialOutput then
       y = y_start;
    end if;

  equation
    connect(u, P.u) annotation (Line(points={{-120,0},{-80,0},{-80,80},{-64,80}},
          color={0,0,127}));
    connect(u, I.u)
      annotation (Line(points={{-120,0},{-64,0}}, color={0,0,127}));
    connect(u, D.u) annotation (Line(points={{-120,0},{-80,0},{-80,-80},{-64,
            -80}}, color={0,0,127}));
    connect(P.y, Add.u1) annotation (Line(points={{-18,80},{0,80},{0,8},{18,8}},
          color={0,0,127}));
    connect(I.y, Add.u2)
      annotation (Line(points={{-18,0},{18,0}}, color={0,0,127}));
    connect(D.y, Add.u3) annotation (Line(points={{-18,-80},{0,-80},{0,-8},{18,
            -8}}, color={0,0,127}));
    connect(Add.y, Gain.u)
      annotation (Line(points={{41,0},{58,0}}, color={0,0,127}));
    connect(Gain.y, y)
      annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
    annotation (defaultComponentName="PID",
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
          Polygon(
            points={{90,-80},{68,-72},{68,-88},{90,-80}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-80,50},{-80,-20},{60,80}}, color={0,0,127}),

          Text(
            extent={{-20,-20},{80,-60}},
            lineColor={192,192,192},
            textString="PID"),
          Text(
            extent={{-150,-150},{150,-110}},
            lineColor={0,0,0},
            textString="Ti=%Ti")}),
      Documentation(info="<HTML>
<p>
This is the text-book version of a PID-controller.
For a more practically useful PID-controller, use
block LimPID.
</p>

<p>
The PID block can be initialized in different
ways controlled by parameter <b>initType</b>. The possible
values of initType are defined in
<a href=\"Modelica://Modelica.Blocks.Types.InitPID\">Modelica.Blocks.Types.InitPID</a>.
This type is identical to
<a href=\"Modelica://Modelica.Blocks.Types.Init\">Types.Init</a>,
with the only exception that the additional option
<b>DoNotUse_InitialIntegratorState</b> is added for
backward compatibility reasons (= integrator is initialized with
InitialState whereas differential part is initialized with
NoInit which was the initialization in version 2.2 of the Modelica
standard library).
</p>

<p>
Based on the setting of initType, the integrator (I) and derivative (D)
blocks inside the PID controller are initialized according to the following table:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>initType</b></td>
      <td valign=\"top\"><b>I.initType</b></td>
      <td valign=\"top\"><b>D.initType</b></td></tr>

  <tr><td valign=\"top\"><b>NoInit</b></td>
      <td valign=\"top\">NoInit</td>
      <td valign=\"top\">NoInit</td></tr>

  <tr><td valign=\"top\"><b>SteadyState</b></td>
      <td valign=\"top\">SteadyState</td>
      <td valign=\"top\">SteadyState</td></tr>

  <tr><td valign=\"top\"><b>InitialState</b></td>
      <td valign=\"top\">InitialState</td>
      <td valign=\"top\">InitialState</td></tr>

  <tr><td valign=\"top\"><b>InitialOutput</b><br>
          and initial equation: y = y_start</td>
      <td valign=\"top\">NoInit</td>
      <td valign=\"top\">SteadyState</td></tr>

  <tr><td valign=\"top\"><b>DoNotUse_InitialIntegratorState</b></td>
      <td valign=\"top\">InitialState</td>
      <td valign=\"top\">NoInit</td></tr>
</table>

<p>
In many cases, the most useful initial condition is
<b>SteadyState</b> because initial transients are then no longer
present. If initType = InitPID.SteadyState, then in some
cases difficulties might occur. The reason is the
equation of the integrator:
</p>

<pre>
   <b>der</b>(y) = k*u;
</pre>

<p>
The steady state equation \"der(x)=0\" leads to the condition that the input u to the
integrator is zero. If the input u is already (directly or indirectly) defined
by another initial condition, then the initialization problem is <b>singular</b>
(has none or infinitely many solutions). This situation occurs often
for mechanical systems, where, e.g., u = desiredSpeed - measuredSpeed and
since speed is both a state and a derivative, it is natural to
initialize it with zero. As sketched this is, however, not possible.
The solution is to not initialize u or the variable that is used
to compute u by an algebraic equation.
</p>


</HTML>
"),   Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics));
  end PID;

  block LimPID
    "P, PI, PD, and PID controller with limited output, anti-windup compensation and setpoint weighting"
    import Modelica.Blocks.Types.InitPID;
    import Modelica.Blocks.Types.SimpleController;
    extends Interfaces.SVcontrol;
    output Real controlError = u_s - u_m
      "Control error (set point - measurement)";

    parameter Modelica.Blocks.Types.SimpleController controllerType=
           Modelica.Blocks.Types.SimpleController.PID "Type of controller";
    parameter Real k(min=0) = 1 "Gain of controller";
    parameter SIunits.Time Ti(min=Modelica.Constants.small, start=0.5)
      "Time constant of Integrator block"
       annotation(Dialog(enable=controllerType==SimpleController.PI or
                                controllerType==SimpleController.PID));
    parameter SIunits.Time Td(min=0, start= 0.1)
      "Time constant of Derivative block"
         annotation(Dialog(enable=controllerType==SimpleController.PD or
                                  controllerType==SimpleController.PID));
    parameter Real yMax(start=1) "Upper limit of output";
    parameter Real yMin=-yMax "Lower limit of output";
    parameter Real wp(min=0) = 1
      "Set-point weight for Proportional block (0..1)";
    parameter Real wd(min=0) = 0 "Set-point weight for Derivative block (0..1)"
         annotation(Dialog(enable=controllerType==SimpleController.PD or
                                  controllerType==SimpleController.PID));
    parameter Real Ni(min=100*Modelica.Constants.eps) = 0.9
      "Ni*Ti is time constant of anti-windup compensation"
       annotation(Dialog(enable=controllerType==SimpleController.PI or
                                controllerType==SimpleController.PID));
    parameter Real Nd(min=100*Modelica.Constants.eps) = 10
      "The higher Nd, the more ideal the derivative block"
         annotation(Dialog(enable=controllerType==SimpleController.PD or
                                  controllerType==SimpleController.PID));
    parameter Modelica.Blocks.Types.InitPID initType= Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState
      "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
                                       annotation(Evaluate=true,
        Dialog(group="Initialization"));
    parameter Boolean limitsAtInit = true
      "= false, if limits are ignored during initializiation"
      annotation(Evaluate=true, Dialog(group="Initialization",
                         enable=controllerType==SimpleController.PI or
                                controllerType==SimpleController.PID));
    parameter Real xi_start=0
      "Initial or guess value value for integrator output (= integrator state)"
      annotation (Dialog(group="Initialization",
                  enable=controllerType==SimpleController.PI or
                         controllerType==SimpleController.PID));
    parameter Real xd_start=0
      "Initial or guess value for state of derivative block"
      annotation (Dialog(group="Initialization",
                           enable=controllerType==SimpleController.PD or
                                  controllerType==SimpleController.PID));
    parameter Real y_start=0 "Initial value of output"
      annotation(Dialog(enable=initType == InitPID.InitialOutput, group=
            "Initialization"));

    Blocks.Math.Add addP(k1=wp, k2=-1)
      annotation (Placement(transformation(extent={{-80,40},{-60,60}}, rotation=
             0)));
    Blocks.Math.Add addD(k1=wd, k2=-1) if with_D
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}},
            rotation=0)));
    Blocks.Math.Gain P(k=1)
                       annotation (Placement(transformation(extent={{-40,40},{
              -20,60}}, rotation=0)));
    Blocks.Continuous.Integrator I(k=1/Ti, y_start=xi_start,
      initType=if initType==InitPID.SteadyState then
                  InitPID.SteadyState else
               if initType==InitPID.InitialState or
                  initType==InitPID.DoNotUse_InitialIntegratorState then
                  InitPID.InitialState else InitPID.NoInit) if with_I
      annotation (Placement(transformation(extent={{-40,-60},{-20,-40}},
            rotation=0)));
    Blocks.Continuous.Derivative D(k=Td, T=max([Td/Nd, 1.e-14]), x_start=xd_start,
      initType=if initType==InitPID.SteadyState or
                  initType==InitPID.InitialOutput then InitPID.SteadyState else
               if initType==InitPID.InitialState then InitPID.InitialState else
                  InitPID.NoInit) if with_D
      annotation (Placement(transformation(extent={{-40,-10},{-20,10}},
            rotation=0)));
    Blocks.Math.Gain gainPID(k=k) annotation (Placement(transformation(extent={
              {30,-10},{50,10}}, rotation=0)));
    Blocks.Math.Add3 addPID annotation (Placement(transformation(
            extent={{0,-10},{20,10}}, rotation=0)));
    Blocks.Math.Add3 addI(k2=-1) if with_I annotation (Placement(
          transformation(extent={{-80,-60},{-60,-40}}, rotation=0)));
    Blocks.Math.Add addSat(k1=+1, k2=-1) if
                                     with_I
      annotation (Placement(transformation(
          origin={80,-50},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Blocks.Math.Gain gainTrack(k=1/(k*Ni)) if with_I
      annotation (Placement(transformation(extent={{40,-80},{20,-60}}, rotation=
             0)));
    Blocks.Nonlinear.Limiter limiter(uMax=yMax, uMin=yMin, limitsAtInit=limitsAtInit)
      annotation (Placement(transformation(extent={{70,-10},{90,10}}, rotation=
              0)));
  protected
    parameter Boolean with_I = controllerType==SimpleController.PI or
                               controllerType==SimpleController.PID annotation(Evaluate=true, HideResult=true);
    parameter Boolean with_D = controllerType==SimpleController.PD or
                               controllerType==SimpleController.PID annotation(Evaluate=true, HideResult=true);
  public
    Sources.Constant Dzero(k=0) if not with_D
      annotation (Placement(transformation(extent={{-30,20},{-20,30}}, rotation=
             0)));
    Sources.Constant Izero(k=0) if not with_I
      annotation (Placement(transformation(extent={{10,-55},{0,-45}}, rotation=
              0)));
  initial equation
    if initType==InitPID.InitialOutput then
       y = y_start;
    end if;
  equation
    assert(yMax >= yMin, "LimPID: Limits must be consistent. However, yMax (=" + String(yMax) +
                         ") < yMin (=" + String(yMin) + ")");
    if initType == InitPID.InitialOutput and (y_start < yMin or y_start > yMax) then
        Modelica.Utilities.Streams.error("LimPID: Start value y_start (=" + String(y_start) +
           ") is outside of the limits of yMin (=" + String(yMin) +") and yMax (=" + String(yMax) + ")");
    end if;
    assert(limitsAtInit or not limitsAtInit and y >= yMin and y <= yMax,
           "LimPID: During initialization the limits have been switched off.\n" +
           "After initialization, the output y (=" + String(y) +
           ") is outside of the limits of yMin (=" + String(yMin) +") and yMax (=" + String(yMax) + ")");

    connect(u_s, addP.u1) annotation (Line(points={{-120,0},{-96,0},{-96,56},{
            -82,56}}, color={0,0,127}));
    connect(u_s, addD.u1) annotation (Line(points={{-120,0},{-96,0},{-96,6},{
            -82,6}}, color={0,0,127}));
    connect(u_s, addI.u1) annotation (Line(points={{-120,0},{-96,0},{-96,-42},{
            -82,-42}}, color={0,0,127}));
    connect(addP.y, P.u) annotation (Line(points={{-59,50},{-42,50}}, color={0,
            0,127}));
    connect(addD.y, D.u)
      annotation (Line(points={{-59,0},{-42,0}}, color={0,0,127}));
    connect(addI.y, I.u) annotation (Line(points={{-59,-50},{-42,-50}}, color={
            0,0,127}));
    connect(P.y, addPID.u1) annotation (Line(points={{-19,50},{-10,50},{-10,8},
            {-2,8}}, color={0,0,127}));
    connect(D.y, addPID.u2)
      annotation (Line(points={{-19,0},{-2,0}}, color={0,0,127}));
    connect(I.y, addPID.u3) annotation (Line(points={{-19,-50},{-10,-50},{-10,
            -8},{-2,-8}}, color={0,0,127}));
    connect(addPID.y, gainPID.u)
      annotation (Line(points={{21,0},{28,0}}, color={0,0,127}));
    connect(gainPID.y, addSat.u2) annotation (Line(points={{51,0},{60,0},{60,
            -20},{74,-20},{74,-38}}, color={0,0,127}));
    connect(gainPID.y, limiter.u)
      annotation (Line(points={{51,0},{68,0}}, color={0,0,127}));
    connect(limiter.y, addSat.u1) annotation (Line(points={{91,0},{94,0},{94,
            -20},{86,-20},{86,-38}}, color={0,0,127}));
    connect(limiter.y, y)
      annotation (Line(points={{91,0},{110,0}}, color={0,0,127}));
    connect(addSat.y, gainTrack.u) annotation (Line(points={{80,-61},{80,-70},{
            42,-70}}, color={0,0,127}));
    connect(gainTrack.y, addI.u3) annotation (Line(points={{19,-70},{-88,-70},{
            -88,-58},{-82,-58}}, color={0,0,127}));
    connect(u_m, addP.u2) annotation (Line(
        points={{0,-120},{0,-92},{-92,-92},{-92,44},{-82,44}},
        color={0,0,127},
        thickness=0.5));
    connect(u_m, addD.u2) annotation (Line(
        points={{0,-120},{0,-92},{-92,-92},{-92,-6},{-82,-6}},
        color={0,0,127},
        thickness=0.5));
    connect(u_m, addI.u2) annotation (Line(
        points={{0,-120},{0,-92},{-92,-92},{-92,-50},{-82,-50}},
        color={0,0,127},
        thickness=0.5));
    connect(Dzero.y, addPID.u2) annotation (Line(points={{-19.5,25},{-14,25},{
            -14,0},{-2,0}}, color={0,0,127}));
    connect(Izero.y, addPID.u3) annotation (Line(points={{-0.5,-50},{-10,-50},{
            -10,-8},{-2,-8}}, color={0,0,127}));
    annotation (defaultComponentName="PID",
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
          Polygon(
            points={{90,-80},{68,-72},{68,-88},{90,-80}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-80,50},{-80,-20},{30,60},{80,60}}, color={0,
                0,127}),
          Text(
            extent={{-20,-20},{80,-60}},
            lineColor={192,192,192},
            textString="PID")}),
      Documentation(info="<HTML>
<p>
Via parameter <b>controllerType</b> either <b>P</b>, <b>PI</b>, <b>PD</b>,
or <b>PID</b> can be selected. If, e.g., PI is selected, all components belonging to the
D-part are removed from the block (via conditional declarations).
The example model
<a href=\"Modelica://Modelica.Blocks.Examples.PID_Controller\">Modelica.Blocks.Examples.PID_Controller</a>
demonstrates the usage of this controller.
Several practical aspects of PID controller design are incorporated
according to chapter 3 of the book:
</p>

<dl>
<dt>&Aring;str&ouml;m K.J., and H&auml;gglund T.:</dt>
<dd> <b>PID Controllers: Theory, Design, and Tuning</b>.
     Instrument Society of America, 2nd edition, 1995.
</dd>
</dl>

<p>
Besides the additive <b>proportional, integral</b> and <b>derivative</b>
part of this controller, the following features are present:
</p>
<ul>
<li> The output of this controller is limited. If the controller is
     in its limits, anti-windup compensation is activated to drive
     the integrator state to zero. </li>
<li> The high-frequency gain of the derivative part is limited
     to avoid excessive amplification of measurement noise.</li>
<li> Setpoint weighting is present, which allows to weight
     the setpoint in the proportional and the derivative part
     independantly from the measurement. The controller will respond
     to load disturbances and measurement noise independantly of this setting
     (parameters wp, wd). However, setpoint changes will depend on this
     setting. For example, it is useful to set the setpoint weight wd
     for the derivative part to zero, if steps may occur in the
     setpoint signal.</li>
</ul>

<p>
The parameters of the controller can be manually adjusted by performing
simulations of the closed loop system (= controller + plant connected
together) and using the following strategy:
</p>

<ol>
<li> Set very large limits, e.g., yMax = Modelica.Constants.inf</li>
<li> Select a <b>P</b>-controller and manually enlarge parameter <b>k</b>
     (the total gain of the controller) until the closed-loop response
     cannot be improved any more.</li>
<li> Select a <b>PI</b>-controller and manually adjust parameters
     <b>k</b> and <b>Ti</b> (the time constant of the integrator).
     The first value of Ti can be selected, such that it is in the
     order of the time constant of the oscillations occuring with
     the P-controller. If, e.g., vibrations in the order of T=10 ms
     occur in the previous step, start with Ti=0.01 s.</li>
<li> If you want to make the reaction of the control loop faster
     (but probably less robust against disturbances and measurement noise)
     select a <b>PID</b>-Controller and manually adjust parameters
     <b>k</b>, <b>Ti</b>, <b>Td</b> (time constant of derivative block).</li>
<li> Set the limits yMax and yMin according to your specification.</li>
<li> Perform simulations such that the output of the PID controller
     goes in its limits. Tune <b>Ni</b> (Ni*Ti is the time constant of
     the anti-windup compensation) such that the input to the limiter
     block (= limiter.u) goes quickly enough back to its limits.
     If Ni is decreased, this happens faster. If Ni=infinity, the
     anti-windup compensation is switched off and the controller works bad.</li>
</ol>

<p>
<b>Initialization</b>
</p>

<p>
This block can be initialized in different
ways controlled by parameter <b>initType</b>. The possible
values of initType are defined in
<a href=\"Modelica://Modelica.Blocks.Types.InitPID\">Modelica.Blocks.Types.InitPID</a>.
This type is identical to
<a href=\"Modelica://Modelica.Blocks.Types.Init\">Types.Init</a>,
with the only exception that the additional option
<b>DoNotUse_InitialIntegratorState</b> is added for
backward compatibility reasons (= integrator is initialized with
InitialState whereas differential part is initialized with
NoInit which was the initialization in version 2.2 of the Modelica
standard library).
</p>

<p>
Based on the setting of initType, the integrator (I) and derivative (D)
blocks inside the PID controller are initialized according to the following table:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>initType</b></td>
      <td valign=\"top\"><b>I.initType</b></td>
      <td valign=\"top\"><b>D.initType</b></td></tr>

  <tr><td valign=\"top\"><b>NoInit</b></td>
      <td valign=\"top\">NoInit</td>
      <td valign=\"top\">NoInit</td></tr>

  <tr><td valign=\"top\"><b>SteadyState</b></td>
      <td valign=\"top\">SteadyState</td>
      <td valign=\"top\">SteadyState</td></tr>

  <tr><td valign=\"top\"><b>InitialState</b></td>
      <td valign=\"top\">InitialState</td>
      <td valign=\"top\">InitialState</td></tr>

  <tr><td valign=\"top\"><b>InitialOutput</b><br>
          and initial equation: y = y_start</td>
      <td valign=\"top\">NoInit</td>
      <td valign=\"top\">SteadyState</td></tr>

  <tr><td valign=\"top\"><b>DoNotUse_InitialIntegratorState</b></td>
      <td valign=\"top\">InitialState</td>
      <td valign=\"top\">NoInit</td></tr>
</table>

<p>
In many cases, the most useful initial condition is
<b>SteadyState</b> because initial transients are then no longer
present. If initType = InitPID.SteadyState, then in some
cases difficulties might occur. The reason is the
equation of the integrator:
</p>

<pre>
   <b>der</b>(y) = k*u;
</pre>

<p>
The steady state equation \"der(x)=0\" leads to the condition that the input u to the
integrator is zero. If the input u is already (directly or indirectly) defined
by another initial condition, then the initialization problem is <b>singular</b>
(has none or infinitely many solutions). This situation occurs often
for mechanical systems, where, e.g., u = desiredSpeed - measuredSpeed and
since speed is both a state and a derivative, it is natural to
initialize it with zero. As sketched this is, however, not possible.
The solution is to not initialize u_m or the variable that is used
to compute u_m by an algebraic equation.
</p>

<p>
If parameter <b>limitAtInit</b> = <b>false</b>, the limits at the
output of this controller block are removed from the initialization problem which
leads to a much simpler equation system. After initialization has been
performed, it is checked via an assert whether the output is in the
defined limits. For backward compatibility reasons
<b>limitAtInit</b> = <b>true</b>. In most cases it is best
to use <b>limitAtInit</b> = <b>false</b>.
</p>
</HTML>
"),   Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics));
  end LimPID;

  block TransferFunction "Linear transfer function"
    import Modelica.Blocks.Types.Init;
    extends Interfaces.SISO;

    parameter Real b[:]={1} "Numerator coefficients of transfer function"
      annotation(Dialog(group="y = (2*s+3)/(4*s^2+5*s+6)*u is defined as b={2,3}, a={4,5,6}"));
    parameter Real a[:] "Denominator coefficients of transfer function"
      annotation(Dialog(group="y = (2*s+3)/(4*s^2+5*s+6)*u is defined as b={2,3}, a={4,5,6}"));
    parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
      "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
                                       annotation(Evaluate=true, Dialog(group=
            "Initialization"));
    parameter Real x_start[size(a, 1) - 1]=zeros(nx)
      "Initial or guess values of states"
      annotation (Dialog(group="Initialization"));
    parameter Real y_start=0
      "Initial value of output (derivatives of y are zero upto nx-1-th derivative)"
      annotation(Dialog(enable=initType == Init.InitialOutput, group=
            "Initialization"));
    output Real x[size(a, 1) - 1](start=x_start)
      "State of transfer function from controller canonical form";
  protected
    parameter Integer na=size(a, 1) "Size of Denominator of transfer function.";
    parameter Integer nb=size(b, 1) "Size of Numerator of transfer function.";
    parameter Integer nx=size(a, 1) - 1;
    parameter Real bb[:] = vector([zeros(max(0,na-nb),1);b]);
    parameter Real d = bb[1]/a[1];
    parameter Real a_end = if a[end] > 100*Modelica.Constants.eps*sqrt(a*a) then a[end] else 1.0;
    Real x_scaled[size(x,1)] "Scaled vector x";

  initial equation
    if initType == Init.SteadyState then
      der(x_scaled) = zeros(nx);
    elseif initType == Init.InitialState then
      x_scaled = x_start*a_end;
    elseif initType == Init.InitialOutput then
      y = y_start;
      der(x_scaled[2:nx]) = zeros(nx-1);
    end if;
  equation
    assert(size(b,1) <= size(a,1), "Transfer function is not proper");
    if nx == 0 then
       y = d*u;
    else
       der(x_scaled[1])    = (-a[2:na]*x_scaled + a_end*u)/a[1];
       der(x_scaled[2:nx]) = x_scaled[1:nx-1];
       y = ((bb[2:na] - d*a[2:na])*x_scaled)/a_end + d*u;
       x = x_scaled/a_end;
    end if;
    annotation (
      Documentation(info="<html>
<p>
This block defines the transfer function between the input
u and the output y
as (nb = dimension of b, na = dimension of a):
</p>
<pre>
           b[1]*s^[nb-1] + b[2]*s^[nb-2] + ... + b[nb]
   y(s) = --------------------------------------------- * u(s)
           a[1]*s^[na-1] + a[2]*s^[na-2] + ... + a[na]
</pre>
<p>
State variables <b>x</b> are defined according to <b>controller canonical</b>
form. Internally, vector <b>x</b> is scaled to improve the numerics (the states in versions before version 3.0 of the Modelica Standard Library have been not scaled). This scaling is
not visible from the outside of this block because the non-scaled vector <b>x</b>
is provided as output signal and the start value is with respect to the non-scaled
vector <b>x</b>.
Initial values of the states <b>x</b> can be set via parameter <b>x_start</b>.
</p>

<p>
Example:
</p>
<pre>
     TransferFunction g(b = {2,4}, a = {1,3});
</pre>
<p>
results in the following transfer function:
</p>
<pre>
        2*s + 4
   y = --------- * u
         s + 3
</pre>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-80,0},{80,0}}, color={0,0,127}),
          Text(
            extent={{-90,10},{90,90}},
            textString="b(s)",
            lineColor={0,0,127}),
          Text(
            extent={{-90,-10},{90,-90}},
            textString="a(s)",
            lineColor={0,0,127})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{40,0},{-40,0}}, color={0,0,0}),
          Text(
            extent={{-55,55},{55,5}},
            lineColor={0,0,0},
            textString="b(s)"),
          Text(
            extent={{-55,-5},{55,-55}},
            lineColor={0,0,0},
            textString="a(s)"),
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Line(points={{-100,0},{-60,0}}, color={0,0,255}),
          Line(points={{60,0},{100,0}}, color={0,0,255})}));
  end TransferFunction;

  block StateSpace "Linear state space system"
    import Modelica.Blocks.Types.Init;
    parameter Real A[:, size(A, 1)]
      "Matrix A of state space model (e.g. A=[1, 0; 0, 1])";
    parameter Real B[size(A, 1), :]
      "Matrix B of state space model (e.g. B=[1; 1])";
    parameter Real C[:, size(A, 1)]
      "Matrix C of state space model (e.g. C=[1, 1])";
    parameter Real D[size(C, 1), size(B, 2)]=zeros(size(C, 1), size(B, 2))
      "Matrix D of state space model";
    parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
      "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
                                                                                      annotation(Evaluate=true,
        Dialog(group="Initialization"));
    parameter Real x_start[nx]=zeros(nx) "Initial or guess values of states"
      annotation (Dialog(group="Initialization"));
    parameter Real y_start[ny]=zeros(ny)
      "Initial values of outputs (remaining states are in steady state if possible)"
      annotation(Dialog(enable=initType == Init.InitialOutput, group=
            "Initialization"));

    extends Interfaces.MIMO(final nin=size(B, 2), final nout=size(C, 1));
    output Real x[size(A, 1)](start=x_start) "State vector";

  protected
    parameter Integer nx = size(A, 1) "number of states";
    parameter Integer ny = size(C, 1) "number of outputs";
  initial equation
    if initType == Init.SteadyState then
      der(x) = zeros(nx);
    elseif initType == Init.InitialState then
      x = x_start;
    elseif initType == Init.InitialOutput then
      x = Modelica.Math.Matrices.equalityLeastSquares(A, -B*u, C, y_start - D*u);
    end if;
  equation
    der(x) = A*x + B*u;
    y = C*x + D*u;
    annotation (
      Documentation(info="<HTML>
<p>
The State Space block defines the relation
between the input u and the output
y in state space form:
</p>
<pre>

    der(x) = A * x + B * u
        y  = C * x + D * u
</pre>
<p>
The input is a vector of length nu, the output is a vector
of length ny and nx is the number of states. Accordingly
</p>
<pre>
        A has the dimension: A(nx,nx),
        B has the dimension: B(nx,nu),
        C has the dimension: C(ny,nx),
        D has the dimension: D(ny,nu)
</pre>
<p>
Example:
</p>
<pre>
     parameter: A = [0.12, 2;3, 1.5]
     parameter: B = [2, 7;3, 1]
     parameter: C = [0.1, 2]
     parameter: D = zeros(ny,nu)
results in the following equations:
  [der(x[1])]   [0.12  2.00] [x[1]]   [2.0  7.0] [u[1]]
  [         ] = [          ]*[    ] + [        ]*[    ]
  [der(x[2])]   [3.00  1.50] [x[2]]   [0.1  2.0] [u[2]]
                             [x[1]]            [u[1]]
       y[1]   = [0.1  2.0] * [    ] + [0  0] * [    ]
                             [x[2]]            [u[2]]
</pre>
</HTML>
"),   Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Text(
            extent={{-90,10},{-10,90}},
            textString="A",
            lineColor={0,0,127}),
          Text(
            extent={{10,10},{90,90}},
            textString="B",
            lineColor={0,0,127}),
          Text(
            extent={{-90,-10},{-10,-90}},
            textString="C",
            lineColor={0,0,127}),
          Text(
            extent={{10,-10},{90,-90}},
            textString="D",
            lineColor={0,0,127}),
          Line(points={{0,-90},{0,90}}, color={192,192,192}),
          Line(points={{-90,0},{90,0}}, color={192,192,192})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Text(
            extent={{-60,40},{60,0}},
            lineColor={0,0,0},
            textString="sx=Ax+Bu"),
          Text(
            extent={{-60,0},{60,-40}},
            lineColor={0,0,0},
            textString=" y=Cx+Du"),
          Line(points={{-100,0},{-60,0}}, color={0,0,255}),
          Line(points={{60,0},{100,0}}, color={0,0,255})}));
  end StateSpace;

  block Der "Derivative of input (= analytic differentations)"
      extends Interfaces.SISO;

  equation
    y = der(u);
      annotation (defaultComponentName="der1",
   Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
          graphics={Text(
            extent={{-80,76},{80,-82}},
            textString="der()",
            lineColor={0,0,127})}),
          Documentation(info="<HTML>
<p>
Defines that the output y is the <i>derivative</i>
of the input u. Note, that Modelica.Blocks.Continuous.Derivative
computes the derivative in an approximate sense, where as this block computes
the derivative exactly. This requires that the input u is differentiated
by the Modelica translator, if this derivative is not yet present in
the model.
</p>
</HTML>"));
  end Der;

  block LowpassButterworth
    "Output the input signal filtered with a low pass Butterworth filter of any order"

    import Modelica.Math.*;
    import Modelica.Blocks.Types.Init;

    extends Modelica.Blocks.Interfaces.SISO;

    parameter Integer n(min=1) = 2 "Order of filter";
    parameter SI.Frequency f(start=1) "Cut-off frequency";
    parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
      "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
                                                                                      annotation(Evaluate=true,
        Dialog(group="Initialization"));
    parameter Real x1_start[m]=zeros(m)
      "Initial or guess values of states 1 (der(x1)=x2))"
      annotation (Dialog(group="Initialization"));
    parameter Real x2_start[m]=zeros(m) "Initial or guess values of states 2"
      annotation (Dialog(group="Initialization"));
    parameter Real xr_start=0.0
      "Initial or guess value of real pole for uneven order otherwise dummy"
      annotation (Dialog(group="Initialization"));
    parameter Real y_start=0.0
      "Initial value of output (states are initialized in steady state if possible)"
       annotation(Dialog(enable=initType == Init.InitialOutput, group=
            "Initialization"));

    output Real x1[m](start=x1_start)
      "states 1 of second order filters (der(x1) = x2)";
    output Real x2[m](start=x2_start) "states 2 of second order filters";
    output Real xr(start=xr_start)
      "state of real pole for uneven order otherwise dummy";
  protected
    constant Real pi=Modelica.Constants.pi;
    parameter Integer m=integer(n/2);
    parameter Boolean evenOrder = 2*m == n;
    parameter Real w=2*pi*f;
    Real z[m + 1];
    Real polereal[m];
    Real poleimag[m];
    Real realpol;
    Real k2[m];
    Real D[m];
    Real w0[m];
    Real k1;
    Real T;
  initial equation
    if initType == Init.SteadyState then
      der(x1) = zeros(m);
      der(x2) = zeros(m);
      if not evenOrder then
        der(xr) = 0.0;
      end if;
    elseif initType == Init.InitialState then
      x1 = x1_start;
      x2 = x2_start;
      if not evenOrder then
        xr = xr_start;
      end if;
    elseif initType == Init.InitialOutput then
      y = y_start;
      der(x1) = zeros(m);
      if evenOrder then
        if m > 1 then
          der(x2[1:m-1]) = zeros(m-1);
        end if;
      else
        der(x1) = zeros(m);
      end if;
    end if;
  equation
    k2 = ones(m);
    k1 = 1;
    z[1] = u;

    // calculate filter parameters
    for i in 1:m loop
      // poles of prototype lowpass
      polereal[i] = cos(pi/2 + pi/n*(i - 0.5));
      poleimag[i] = sin(pi/2 + pi/n*(i - 0.5));
      // scaling and calculation of secon order filter coefficients
      w0[i] = (polereal[i]^2 + poleimag[i]^2)*w;
      D[i] = -polereal[i]/w0[i]*w;
    end for;
    realpol = 1*w;
    T = 1/realpol;

    // calculate second order filters
    for i in 1:m loop
      der(x1[i]) = x2[i];
      der(x2[i]) = k2[i]*w0[i]^2*z[i] - 2*D[i]*w0[i]*x2[i] - w0[i]^2*x1[i];
      z[i + 1] = x1[i];
    end for;

    // calculate first order filter if necessary
    if evenOrder then
      // even order
      xr = 0;
      y = z[m + 1];
    else
      // uneven order
      der(xr) = (k1*z[m + 1] - xr)/T;
      y = xr;
    end if;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
          Polygon(
            points={{-79.5584,91.817},{-87.5584,69.817},{-71.5584,69.817},{-79.5584,
                89.817},{-79.5584,91.817}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-72,-68.53},{-64,-39.5},{-56,-2.522},{-48,
                32.75},{-40,58.8},{-32,71.51},{-24,70.49},{-16,58.45},{-8,40.06},
                {0,20.55},{8,4.459},{16,-5.271},{24,-7.629},{32,-3.428},{40,
                5.21},{48,15.56},{56,25.03},{64,31.66},{72,34.5},{80,33.61}},
              color={0,0,127}),
          Line(points={{-90.9779,-80.7697},{81.0221,-80.7697}}, color={192,192,
                192}),
          Polygon(
            points={{91.3375,-79.8233},{69.3375,-71.8233},{69.3375,-87.8233},{
                91.3375,-79.8233}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-45.1735,-11.47},{92,-68}},
            lineColor={192,192,192},
            textString="LowpassButterworthFilter"),
          Text(
            extent={{8,-106},{8,-146}},
            lineColor={0,0,0},
            textString="f=%f"),
          Text(
            extent={{-2,94},{94,48}},
            lineColor={192,192,192},
            textString="%n")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
          Line(points={{40,0},{-40,0}}, color={0,0,0}),
          Text(
            extent={{-55,55},{55,5}},
            lineColor={0,0,0},
            textString="1"),
          Text(
            extent={{-55,-5},{55,-55}},
            lineColor={0,0,0},
            textString="a(s)"),
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Line(points={{-100,0},{-60,0}}, color={0,0,255}),
          Line(points={{60,0},{100,0}}, color={0,0,255})}),
      Documentation(info="<html>
<p>
This block defines the transfer function between the input u
and the output y as an n-th order low pass filter with <i>Butterworth</i>
characteristics and cut-off frequency f. It is implemented as
a series of second order filters and a first order filter.
Butterworth filters have the feature that the amplitude at the
cut-off frequency f is 1/sqrt(2) (= 3 dB), i.e., they are
always \"normalized\". Step responses of the Butterworth filter of
different orders are shown in the next figure:
</p>

<p>
<img src=\"../Images/Blocks/Butterworth.png\">
</p>

<p>
If transients at the simulation start shall be avoided, the filter
should be initialized in steady state (e.g., using option
initType=Modelica.Blocks.Types.Init.SteadyState).
</p>


</html>
"));
  end LowpassButterworth;

  block CriticalDamping
    "Output the input signal filtered with an n-th order filter with critical damping"

    import Modelica.Blocks.Types.Init;
    extends Modelica.Blocks.Interfaces.SISO;

    parameter Integer n=2 "Order of filter";
    parameter Modelica.SIunits.Frequency f(start=1) "Cut-off frequency";
    parameter Boolean normalized = true
      "= true, if amplitude at f_cut is 3 dB, otherwise unmodified filter";
    parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
      "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
                                                                                      annotation(Evaluate=true,
        Dialog(group="Initialization"));
    parameter Real x_start[n]=zeros(n) "Initial or guess values of states"
      annotation (Dialog(group="Initialization"));
    parameter Real y_start=0.0
      "Initial value of output (remaining states are in steady state)"
      annotation(Dialog(enable=initType == Init.InitialOutput, group=
            "Initialization"));

    output Real x[n](start=x_start) "Filter states";
  protected
    parameter Real alpha=if normalized then sqrt(2^(1/n) - 1) else 1.0
      "Frequency correction factor for normalized filter";
    parameter Real w=2*Modelica.Constants.pi*f/alpha;
  initial equation
    if initType == Init.SteadyState then
      der(x) = zeros(n);
    elseif initType == Init.InitialState then
      x = x_start;
    elseif initType == Init.InitialOutput then
      y = y_start;
      der(x[1:n-1]) = zeros(n-1);
    end if;
  equation
    der(x[1]) = (u - x[1])*w;
    for i in 2:n loop
      der(x[i]) = (x[i - 1] - x[i])*w;
    end for;
    y = x[n];
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{-80.6897,77.6256},{-80.6897,-90.3744}}, color={192,192,
                192}),
          Polygon(
            points={{-79.7044,90.6305},{-87.7044,68.6305},{-71.7044,68.6305},{-79.7044,
                88.6305},{-79.7044,90.6305}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
          Polygon(
            points={{90,-80},{68,-72},{68,-88},{90,-80}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{0,0},{60,-60}},
            lineColor={192,192,192},
            textString="PTn"),
          Line(points={{-80.7599,-80.5082},{-70.7599,-74.5082},{-56,-60},{-48,-42},
                {-42,-18},{-36,4},{-26,20},{-10.7599,34.9018},{-0.759907,
                38.8218},{9.24009,41.6818},{19.2401,43.7818},{29.2401,45.3118},
                {39.2401,46.4318},{49.2401,47.2518},{59.2401,47.8518},{69.2401,
                48.2918},{79.2401,48.6118}}, color={0,0,127}),
          Text(
            extent={{-70,94},{26,48}},
            lineColor={192,192,192},
            textString="%n"),
          Text(
            extent={{8,-106},{8,-146}},
            lineColor={0,0,0},
            textString="f=%f")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
          Line(points={{40,0},{-40,0}}, color={0,0,0}),
          Text(
            extent={{-55,55},{55,5}},
            lineColor={0,0,0},
            textString="1"),
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Line(points={{-100,0},{-60,0}}, color={0,0,255}),
          Line(points={{60,0},{100,0}}, color={0,0,255}),
          Text(
            extent={{-54,-6},{44,-56}},
            lineColor={0,0,0},
            textString="(s/w + 1)"),
          Text(
            extent={{38,-10},{58,-30}},
            lineColor={0,0,0},
            textString="n")}),
      Documentation(info="<html>
<p>This block defines the transfer function between the
input u and the output y
as an n-th order filter with <i>critical damping</i>
characteristics and cut-off frequency f. It is
implemented as a series of first order filters.
This filter type is especially useful to filter the input of an
inverse model, since the filter does not introduce any transients.
</p>

<p>
If parameter <b>normalized</b> = <b>true</b> (default), the filter
is normalized such that the amplitude of the filter transfer function
at the cut-off frequency f is 1/sqrt(2) (= 3 dB). Otherwise, the filter
is not normalized, i.e., it is unmodified. A normalized filter is usually
much better for applications, since filters of different orders are
\"comparable\", whereas non-normalized filters usually require to adapt the
cut-off frequency, when the order of the filter is changed.
Figures of the filter step responses are shown below.
Note, in versions before version 3.0 of the Modelica Standard library,
the CriticalDamping filter was provided only in non-normalzed form.
</p>

<p>If transients at the simulation start shall be avoided, the filter
should be initialized in steady state (e.g., using option
initType=Modelica.Blocks.Types.Init.SteadyState).
</p>

<p>
The critical damping filter is defined as
</p>

<pre>
    &alpha; = <b>if</b> normalized <b>then</b> <b>sqrt</b>(2^(1/n) - 1) <b>else</b> 1 // frequency correction factor
    &omega; = 2*&pi;*f/&alpha;
              1
    y = ------------- * u
         (s/w + 1)^n

</pre>

<p>
<img src=\"../Images/Blocks/CriticalDampingNormalized.png\">
</p>

<p>
<img src=\"../Images/Blocks/CriticalDampingNonNormalized.png\">
</p>

</html>
"));
  end CriticalDamping;

  annotation (
    Documentation(info="<html>
<p>
This package contains basic <b>continuous</b> input/output blocks
described by differential equations.
</p>

<p>
All blocks of this package can be initialized in different
ways controlled by parameter <b>initType</b>. The possible
values of initType are defined in
<a href=\"Modelica://Modelica.Blocks.Types.Init\">Modelica.Blocks.Types.Init</a>:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Name</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>

  <tr><td valign=\"top\"><b>Init.NoInit</b></td>
      <td valign=\"top\">no initialization (start values are used as guess values with fixed=false)</td></tr>

  <tr><td valign=\"top\"><b>Init.SteadyState</b></td>
      <td valign=\"top\">steady state initialization (derivatives of states are zero)</td></tr>

  <tr><td valign=\"top\"><b>Init.InitialState</b></td>
      <td valign=\"top\">Initialization with initial states</td></tr>

  <tr><td valign=\"top\"><b>Init.InitialOutput</b></td>
      <td valign=\"top\">Initialization with initial outputs (and steady state of the states if possibles)</td></tr>
</table>

<p>
For backward compatibility reasons the default of all blocks is
<b>Init.NoInit</b>, with the exception of Integrator and LimIntegrator
where the default is <b>Init.InitialState</b> (this was the initialization
defined in version 2.2 of the Modelica standard library).
</p>

<p>
In many cases, the most useful initial condition is
<b>Init.SteadyState</b> because initial transients are then no longer
present. The drawback is that in combination with a non-linear
plant, non-linear algebraic equations occur that might be
difficult to solve if appropriate guess values for the
iteration variables are not provided (i.e. start values with fixed=false).
However, it is often already useful to just initialize
the linear blocks from the Continuous blocks library in SteadyState.
This is uncritical, because only linear algebraic equations occur.
If Init.NoInit is set, then the start values for the states are
interpreted as <b>guess</b> values and are propagated to the
states with fixed=<b>false</b>.
</p>

<p>
Note, initialization with Init.SteadyState is usually difficult
for a block that contains an integrator
(Integrator, LimIntegrator, PI, PID, LimPID).
This is due to the basic equation of an integrator:
</p>

<pre>
  <b>initial equation</b>
     <b>der</b>(y) = 0;   // Init.SteadyState
  <b>equation</b>
     <b>der</b>(y) = k*u;
</pre>

<p>
The steady state equation leads to the condition that the input to the
integrator is zero. If the input u is already (directly or indirectly) defined
by another initial condition, then the initialization problem is <b>singular</b>
(has none or infinitely many solutions). This situation occurs often
for mechanical systems, where, e.g., u = desiredSpeed - measuredSpeed and
since speed is both a state and a derivative, it is always defined by
Init.InitialState or Init.SteadyState initializtion.
</p>

<p>
In such a case, <b>Init.NoInit</b> has to be selected for the integrator
and an additional initial equation has to be added to the system
to which the integrator is connected. E.g., useful initial conditions
for a 1-dim. rotational inertia controlled by a PI controller are that
<b>angle</b>, <b>speed</b>, and <b>acceleration</b> of the inertia are zero.
</p>

</html>
"));
end Continuous;
