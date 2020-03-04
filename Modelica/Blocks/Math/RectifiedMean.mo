within Modelica.Blocks.Math;
block RectifiedMean "Calculate rectified mean over period 1/f"
  extends Modelica.Blocks.Interfaces.SISO;
  parameter SI.Frequency f(start=50) "Base frequency";
  parameter Real x0=0 "Start value of integrator state";
  Mean mean(final f=f, final x0=x0)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(u, abs1.u) annotation (Line(
      points={{-120,0},{-62,0}}, color={0,0,127}));
  connect(abs1.y, mean.u) annotation (Line(
      points={{-39,0},{-2,0}}, color={0,0,127}));
  connect(mean.y, y) annotation (Line(
      points={{21,0},{110,0}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
This block calculates the rectified mean of the input signal u over the given period 1/f, using the
<a href=\"modelica://Modelica.Blocks.Math.Mean\">mean block</a>.
</p>
<p>
Note: The output is updated after each period defined by 1/f.
</p>
</html>"),
         Icon(graphics={Text(
          extent={{-80,60},{80,20}},
          textString="RM"), Text(
          extent={{-80,-20},{80,-60}},
          textString="f=%f")}));
end RectifiedMean;
