within Modelica.ComplexBlocks.Sources;
block ComplexRotatingPhasor
  "Generate a phasor with constant magnitude and constant angular velocity of type Complex"
  parameter Real magnitude=1 "Magnitude of complex phasor";
  parameter Modelica.Units.SI.AngularVelocity w=1
    "Constant angular velocity of complex phasor";
  parameter Modelica.Units.SI.Angle phi0=0
    "Initial angle of complex phasor at time = 0";
  extends Modelica.ComplexBlocks.Interfaces.ComplexSO;
  Modelica.Units.SI.Angle phi "Angle";
equation
  phi = w*time + phi0;
  y = magnitude*Modelica.ComplexMath.exp(Complex(0, phi));
  annotation (defaultComponentName="complexRotating",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={    Line(
              points={{0,0},{60,50}},
              color={85,170,255}),
                             Polygon(
              points={{60,50},{39,41},{48,30},{60,50}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),Line(points={{-37,35},{-30,40},
              {-22,44},{-10,47},{3,46},{15,42},{28,34},{36,23},{41,10}},
                                                                     color={192,192,192},
          smooth=Smooth.Bezier),
                     Polygon(
              points={{-42,29},{-22,36},{-32,47},{-42,29}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{0,-80},{0,68}},
          color={192,192,192}),   Polygon(
              points={{0,90},{-8,68},{8,68},{0,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{68,0}}, color={192,192,192}),Polygon(
              points={{90,0},{68,8},{68,-8},{90,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
The output y is a complex phasor with constant magnitude, spinning with constant angular velocity.
</p>

</html>"));
end ComplexRotatingPhasor;
