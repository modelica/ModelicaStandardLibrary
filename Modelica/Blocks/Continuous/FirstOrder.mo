within Modelica.Blocks.Continuous;
block FirstOrder "First order transfer function block (= 1 pole)"
  import Modelica.Blocks.Types.Init;
  parameter Real k(unit="1")=1 "Gain";
  parameter SI.Time T(start=1) "Time Constant";
  parameter Init initType=Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3/4: initial output)" annotation(Evaluate=true,
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
    Documentation(info="<html>
<p>
This blocks defines the transfer function between the input u
and the output y as <em>first order</em> system:
</p>
<blockquote><pre>
          k
y = ------------ * u
       T * s + 1
</pre></blockquote>
<p>
If you would like to be able to change easily between different
transfer functions (FirstOrder, SecondOrder, ... ) by changing
parameters, use the general block <strong>TransferFunction</strong> instead
and model a first order SISO system with parameters<br>
b = {k}, a = {T, 1}.
</p>
<blockquote><pre>
Example:
   parameter: k = 0.3, T = 0.4
   results in:
             0.3
      y = ----------- * u
          0.4 s + 1.0
</pre></blockquote>

</html>"),
         Icon(
  coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
    graphics={
  Line(points={{-80.0,78.0},{-80.0,-90.0}},
    color={192,192,192}),
  Polygon(lineColor={192,192,192},
    fillColor={192,192,192},
    fillPattern=FillPattern.Solid,
    points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
  Line(points={{-90.0,-80.0},{82.0,-80.0}},
    color={192,192,192}),
  Polygon(lineColor={192,192,192},
    fillColor={192,192,192},
    fillPattern=FillPattern.Solid,
    points={{90.0,-80.0},{68.0,-72.0},{68.0,-88.0},{90.0,-80.0}}),
  Line(origin = {-26.667,6.667},
      points = {{106.667,43.333},{-13.333,29.333},{-53.333,-86.667}},
      color = {0,0,127},
      smooth = Smooth.Bezier),
  Text(textColor={192,192,192},
    extent={{0.0,-60.0},{60.0,0.0}},
    textString="PT1"),
  Text(extent={{-150.0,-150.0},{150.0,-110.0}},
    textString="T=%T")}));
end FirstOrder;
