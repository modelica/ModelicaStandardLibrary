within Modelica.ComplexBlocks.Examples;
model TestConversionBlock "Test the conversion blocks"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Ramp len(duration=1, offset=1E-6) annotation (
      Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Blocks.Sources.Ramp phi(height=4*Modelica.Constants.pi, duration=
       1) annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Modelica.ComplexBlocks.ComplexMath.PolarToComplex polarToComplex
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToReal complexToReal
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
equation
  connect(phi.y, polarToComplex.phi) annotation (Line(points={{-59,-20},{-50,
          -20},{-50,-6},{-46,-6},{-42,-6}}, color={0,0,127}));
  connect(len.y, polarToComplex.len) annotation (Line(
      points={{-59,20},{-50,20},{-50,6},{-42,6}}, color={0,0,127}));
  connect(polarToComplex.y, complexToReal.u) annotation (Line(
      points={{-19,0},{-2,0}}, color={85,170,255}));
  annotation (Documentation(info="<html>
<p>A Complex signal is defined by its length and angle, both linearly rising with time.
Plotting the imaginary part versus the real part, you will see an Archimedean spiral.</p>
</html>"),
       experiment(StopTime=1.01, Interval=0.001));
end TestConversionBlock;
