within Modelica.Electrical.QuasiStatic.Machines.SpacePhasors.Blocks;
block FromSpacePhasor "Conversion: space phasor -> three-phase"
  extends Modelica.Blocks.Icons.Block;
  import Modelica.ComplexMath.j;
  import Modelica.ComplexMath.exp;
  parameter Integer m(min=1) = 3 "Number of phases" annotation(Evaluate=true);
  Modelica.Blocks.Interfaces.RealInput u[2]
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput y[m]
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  parameter SI.Angle phi[m]=
      Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m);
equation
  y = {Complex(u[1], u[2])*exp(-j*phi[k])/sqrt(2) for k in 1:m};
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
        Line(points={{0,0},{-80,80},{-60,72},{-72,60},{-80,80}}, color={
              85,170,255}),
        Line(points={{0,0},{-80,-80},{-72,-60},{-60,-72},{-80,-80}},
            color={85,170,255}),
        Line(
          points={{0,0},{6.67,10},{13.33,17.32},{20,20},{26.67,17.32},{
              33.33,10},{40,0},{46.67,-10},{53.33,-17.32},{60,-20},{66.67,
              -17.32},{73.33,-10},{80,0}},
          color={85,170,255},
          smooth=Smooth.Bezier),
        Line(
          points={{-10,0},{-3.33,10},{3.33,17.32},{10,20},{16.67,17.32},{
              23.33,10},{30,0},{36.67,-10},{43.33,-17.32},{50,-20},{56.67,
              -17.32},{63.33,-10},{70,0}},
          color={85,170,255},
          smooth=Smooth.Bezier),
        Line(
          points={{10,0},{16.67,10},{23.33,17.32},{30,20},{36.67,17.32},{
              43.33,10},{50,0},{56.67,-10},{63.33,-17.32},{70,-20},{76.67,
              -17.32},{83.33,-10},{90,0}},
          color={85,170,255},
          smooth=Smooth.Bezier),
        Text(
          extent={{-62,-74},{14,-86}},
          textString="zero")}), Documentation(info="<html>
Transformation of space phasor and zero sequence value to quasi-static polyphase values (voltages or currents).
</html>"));
end FromSpacePhasor;
