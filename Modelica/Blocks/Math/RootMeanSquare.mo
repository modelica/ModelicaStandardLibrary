within Modelica.Blocks.Math;
block RootMeanSquare "Calculate root mean square over period 1/f"
  extends Modelica.Blocks.Interfaces.SISO;
  parameter SI.Frequency f(start=50) "Base frequency";
  parameter Real x0=0 "Start value of integrator state";
  MultiProduct product(nu=2)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Mean mean(
    final f=f,
    final yGreaterOrEqualZero=true,
    final x0=x0)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Blocks.Math.Sqrt sqrt1
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
equation

  connect(product.y, mean.u) annotation (Line(
      points={{-18.3,0},{-2,0}}, color={0,0,127}));
  connect(mean.y, sqrt1.u) annotation (Line(
      points={{21,0},{38,0}}, color={0,0,127}));
  connect(sqrt1.y, y) annotation (Line(
      points={{61,0},{110,0}}, color={0,0,127}));
  connect(u, product.u[1]) annotation (Line(
      points={{-120,0},{-60,0},{-60,3.5},{-40,3.5}}, color={0,0,127}));
  connect(u, product.u[2]) annotation (Line(
      points={{-120,0},{-60,0},{-60,-3.5},{-40,-3.5}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
This block calculates the root mean square of the input signal u over the given period 1/f, using the
<a href=\"modelica://Modelica.Blocks.Math.Mean\">mean block</a>.
</p>
<p>
Note: The output is updated after each period defined by 1/f.
</p>
</html>"),
         Icon(graphics={Text(
          extent={{-80,60},{80,20}},
          textString="RMS"), Text(
          extent={{-80,-20},{80,-60}},
          textString="f=%f")}));
end RootMeanSquare;
