within Modelica.Electrical.Polyphase.Basic;
model MutualInductor "Linear mutual inductor"
  extends Polyphase.Interfaces.OnePort;
  parameter Real epsilon=1e-9 "Relative accuracy tolerance of matrix symmetry";
  parameter SI.Inductance L[m, m] "Mutual inductance matrix";
initial equation
  if abs(Modelica.Math.Matrices.det(L)) < epsilon then
    Modelica.Utilities.Streams.print("Warning: mutual inductance matrix singular!");
  end if;
equation
  assert(sum(abs(L - transpose(L))) < epsilon*sum(abs(L)),"Mutual inductance matrix is not symmetric");
  for j in 1:m loop
    v[j] = sum(L[j, k]*der(i[k]) for k in 1:m);
  end for;
  annotation (defaultComponentName="inductor", Documentation(info="<html>
<p>
Model of a polyphase inductor providing a mutual inductance matrix model.
</p>
<h4>Implementation</h4>
<blockquote><pre>
  v[1] = L[1,1]*der(i[1]) + L[1,2]*der(i[2]) + ... + L[1,m]*der(i[m])
  v[2] = L[2,1]*der(i[1]) + L[2,2]*der(i[2]) + ... + L[2,m]*der(i[m])
    :              :                         :                                :
  v[m] = L[m,1]*der(i[1]) + L[m,2]*der(i[2]) + ... + L[m,m]*der(i[m])
</pre></blockquote>

</html>"),
       Icon(graphics={
        Line(points={{-80,20},{-80,-20},{-60,-20}}, color={0,0,255}),
        Line(points={{-80,20},{-60,20}}, color={0,0,255}),
        Line(points={{60,20},{80,20}}, color={0,0,255}),
        Line(points={{80,20},{80,-20},{60,-20}}, color={0,0,255}),
        Line(points={{-90,0},{-80,0}}, color={0,0,255}),
        Line(points={{80,0},{90,0}}, color={0,0,255}),
        Line(
          points={{-60,20},{-59,26},{-52,34},{-38,34},{-31,26},{-30,20}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{-30,20},{-29,26},{-22,34},{-8,34},{-1,26},{0,20}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{0,20},{1,26},{8,34},{22,34},{29,26},{30,20}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{30,20},{31,26},{38,34},{52,34},{59,26},{60,20}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-45,-27},
          rotation=180),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-15,-27},
          rotation=180),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={15,-27},
          rotation=180),
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={45,-27},
          rotation=180),
        Text(
          extent={{-150,50},{150,90}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-80},{150,-40}},
          textString="m=%m")}));
end MutualInductor;
