within Modelica.Electrical.QuasiStatic.Polyphase.Blocks;
block SingleToPolyphase
  "Extends complex phase signal to complex polyphase signals using symmetricOrientation"
  extends Modelica.ComplexBlocks.Interfaces.ComplexSIMO(final nout=m,final useConjugateInput=false);
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
equation
  y = u*Modelica.ComplexMath.fromPolar(fill(1, m), -
    Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m));
  annotation (defaultComponentName="adaptor", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}}), graphics={Line(
              points={{-60,-20},{-60,20},{-56,8},{-64,8},{-60,20}},
              color={0,0,255}),Line(
              points={{40,-20},{40,20},{44,8},{36,8},{40,20}},
              color={0,0,255}),Line(
              points={{40,-20},{40,-20},{76,-40},{64,-38},{68,-30},{76,-40}},
              color={0,0,255}),Line(
              points={{-18,10},{-18,10},{2,-24},{-8,-16},{-2,-10},{2,-24}},
              color={0,0,255},
              origin={30,-38},
              rotation=-90)}), Icon(graphics={
        Line(
          points={{-60,-20},{-60,20},{-56,8},{-64,8},{-60,20}},
          color={85,170,255}),
        Line(
          points={{40,-20},{40,20},{44,6},{36,6},{40,20}},
          color={85,170,255}),
        Line(
          points={{40,-20},{40,-20},{76,-40},{62,-36},{66,-30},{76,-40}},
          color={85,170,255}),
        Line(
          points={{-18,10},{-18,10},{2,-24},{-8,-14},{-2,-10},{2,-24}},
          color={85,170,255},
          origin={30,-38},
          rotation=-90)}),
    Documentation(info="<html>
<p>
This function propagates the input phasor to m output phasors with <a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.PhaseOrientation\">symmetricOrientation</a>.
</p>
</html>"));
end SingleToPolyphase;
