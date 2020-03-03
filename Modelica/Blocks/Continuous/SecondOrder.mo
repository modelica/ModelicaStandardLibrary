within Modelica.Blocks.Continuous;
block SecondOrder "Second order transfer function block (= 2 poles)"
  import Modelica.Blocks.Types.Init;
  parameter Real k(unit="1")=1 "Gain";
  parameter Real w(start=1) "Angular frequency";
  parameter Real D(start=1) "Damping";
  parameter Init initType=Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3/4: initial output)" annotation(Evaluate=true,
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
    Documentation(info="<html>
<p>
This blocks defines the transfer function between the input u and
the output y as <em>second order</em> system:
</p>
<blockquote><pre>
                    k
y = --------------------------------- * u
     ( s / w )^2 + 2*D*( s / w ) + 1
</pre></blockquote>
<p>
If you would like to be able to change easily between different
transfer functions (FirstOrder, SecondOrder, ... ) by changing
parameters, use the general model class <strong>TransferFunction</strong>
instead and model a second order SISO system with parameters<br>
b = {k}, a = {1/w^2, 2*D/w, 1}.
</p>
<blockquote><pre>
Example:

   parameter: k =  0.3,  w = 0.5,  D = 0.4
   results in:
                  0.3
      y = ------------------- * u
          4.0 s^2 + 1.6 s + 1
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
    Line(origin = {-1.939,-1.816},
        points = {{81.939,36.056},{65.362,36.056},{14.39,-26.199},{-29.966,113.485},{-65.374,-61.217},{-78.061,-78.184}},
        color = {0,0,127},
        smooth = Smooth.Bezier),
    Text(textColor={192,192,192},
        extent={{0.0,-70.0},{60.0,-10.0}},
        textString="PT2"),
    Text(extent={{-150.0,-150.0},{150.0,-110.0}},
        textString="w=%w")}));
end SecondOrder;
