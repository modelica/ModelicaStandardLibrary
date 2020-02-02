within Modelica.Electrical.QuasiStatic.Polyphase.Blocks;
block SymmetricalComponents
  "Creates symmetrical components from signals representing quasi-static phasors"
  extends Modelica.ComplexBlocks.Interfaces.ComplexMIMOs(final n=m,final useConjugateInput=fill(false,m));
  import Modelica.ComplexMath.abs;
  import Modelica.ComplexMath.arg;
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  output Real abs_u[m] = abs(u) "Absolute of input";
  output SI.Angle arg_u[m](each displayUnit="deg") = arg(u)
    "Argument of input";
  output Real abs_y[m] = abs(y) "Absolute of output";
  output SI.Angle arg_y[m](each displayUnit="deg") = arg(y)
    "Argument of output";
protected
  final parameter Complex sTM[m,m]=
    Modelica.Electrical.Polyphase.Functions.symmetricTransformationMatrix(
                                                                 m);
equation
  // Symmetrical components (preferred): y = sTM*u;
  for j in 1:m loop
    y[j] = Complex(sum({sTM[j,k].re*u[k].re - sTM[j,k].im*u[k].im for k in 1:m}),
                   sum({sTM[j,k].re*u[k].im + sTM[j,k].im*u[k].re for k in 1:m}));
  end for;
  annotation (defaultComponentName="symComp", Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Line(
          points={{-44,0},{-44,0},{-8,-20},{-22,-16},{-18,-10},{-8,-20}},
          color={85,170,255}),
        Line(
          points={{-44,0},{-44,40},{-40,26},{-48,26},{-44,40}},
          color={85,170,255}),
        Line(
          points={{-18,10},{-18,10},{2,-24},{-8,-14},{-2,-10},{2,-24}},
          color={85,170,255},
          origin={-54,-18},
          rotation=-90),
        Line(
          points={{42,48},{42,48},{78,28},{64,32},{68,38},{78,28}},
          color={85,170,255}),
        Line(
          points={{42,48},{42,88},{46,74},{38,74},{42,88}},
          color={85,170,255}),
        Line(
          points={{-18,10},{-18,10},{2,-24},{-8,-14},{-2,-10},{2,-24}},
          color={85,170,255},
          origin={32,30},
          rotation=-90),
        Line(
          points={{42,-22},{42,-22},{78,-42},{64,-38},{68,-32},{78,-42}},
          color={85,170,255}),
        Line(
          points={{42,-22},{42,18},{46,4},{38,4},{42,18}},
          color={85,170,255}),
        Line(
          points={{-18,10},{-18,10},{2,-24},{-8,-14},{-2,-10},{2,-24}},
          color={85,170,255},
          origin={32,-40},
          rotation=-90),
        Line(
          points={{42,-88},{42,-48},{46,-62},{38,-62},{42,-48}},
          color={85,170,255}),
        Line(
          points={{52,-88},{52,-48},{56,-62},{48,-62},{52,-48}},
          color={85,170,255}),
        Line(
          points={{32,-88},{32,-48},{36,-62},{28,-62},{32,-48}},
          color={85,170,255})}), Documentation(info="<html>
<p>
Calculates the symmetric components according to Charles L. Fortescue from the time phasors.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.PhaseOrientation\">User's guide</a> on symmetrical components and orientation.
</p>
</html>"));
end SymmetricalComponents;
