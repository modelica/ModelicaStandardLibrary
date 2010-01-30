within Modelica.Electrical.QuasiStationary.Examples;
model TestConversionBlock "Test the conversion blocks"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Ramp rms(duration=1, offset=1E-6) 
    annotation (Placement(transformation(extent={{-80,10},{-60,30}}, rotation=0)));
  Modelica.Blocks.Sources.Ramp phi(height=4*Modelica.Constants.pi, duration=1) 
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}}, rotation=
           0)));
  Modelica.ComplexBlocks.ComplexMath.PolarToComplex polarToComplex annotation (Placement(transformation(
          extent={{-40,-10},{-20,10}}, rotation=0)));
  Modelica.ComplexBlocks.ComplexMath.ComplexToReal complexToReal annotation (Placement(transformation(
          extent={{0,-10},{20,10}}, rotation=0)));
equation
  connect(phi.y, polarToComplex.phi) annotation (Line(points={{-59,-20},{-50,
          -20},{-50,-4},{-46,-4},{-46,-6},{-42,-6}},
                                  color={0,0,127}));
  connect(rms.y, polarToComplex.len) annotation (Line(
      points={{-59,20},{-50,20},{-50,6},{-42,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(polarToComplex.y, complexToReal.c) annotation (Line(
      points={{-19,0},{-2,0}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end TestConversionBlock;
