within Modelica.Electrical.Analog.Basic;
model M_Transformer "Generic transformer with free number of inductors"

  parameter Integer N(final min=1) = 3 "Number of inductors";
protected
  parameter Integer dimL=div(N*(N + 1), 2);
public
  parameter SI.Inductance L[dimL]={1,0.1,0.2,2,0.3,3}
    "Inductances and coupling inductances";
  Modelica.Electrical.Analog.Interfaces.PositivePin p[N] "Positive pin"
    annotation (Placement(transformation(extent={{-110,-70},{-90,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n[N] "Negative pin"
    annotation (Placement(transformation(extent={{90,-70},{110,70}})));

  SI.Voltage v[N] "Voltage drop over inductors";
  SI.Current i[N](each start=0, each fixed=true)
    "Current through inductors";
  parameter SI.Inductance Lm[N, N](each final fixed=false)
    "Complete symmetric inductance matrix, calculated internally";

initial equation
  for s in 1:N loop
    Lm[s,s] = L[(s - 1)*N - div((s - 1)*s, 2) + s];
    for z in s + 1:N loop
      Lm[s,z] = L[(s - 1)*N - div((s - 1)*s, 2) + z];
      Lm[z,s] = L[(s - 1)*N - div((s - 1)*s, 2) + z];
    end for;
  end for;

equation
  for j in 1:N loop
    v[j] = p[j].v - n[j].v;
    0 = p[j].i + n[j].i;
    i[j] = p[j].i;
  end for;

  v = Lm*der(i);

  annotation (defaultComponentName="transformer", Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor={0,0,255}),
        Text(extent={{-150,-80},{150,-120}}, textString="N=%N"),
        Line(points={{60,-50},{90,-50}},
                                     color={0,0,255}),
        Line(points={{-90,-50},{-60,-50}},
                                       color={0,0,255}),
        Line(
          points={{-60,-50},{-59,-44},{-52,-36},{-38,-36},{-31,-44},{-30,-50}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{-30,-50},{-29,-44},{-22,-36},{-8,-36},{-1,-44},{0,-50}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{0,-50},{1,-44},{8,-36},{22,-36},{29,-44},{30,-50}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{30,-50},{31,-44},{38,-36},{52,-36},{59,-44},{60,-50}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(points={{60,20},{90,20}},
                                     color={0,0,255}),
        Line(points={{-90,20},{-60,20}},
                                       color={0,0,255}),
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
        Line(points={{60,50},{90,50}},
                                     color={0,0,255}),
        Line(points={{-90,50},{-60,50}},
                                       color={0,0,255}),
        Line(
          points={{-60,50},{-59,56},{-52,64},{-38,64},{-31,56},{-30,50}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{-30,50},{-29,56},{-22,64},{-8,64},{-1,56},{0,50}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{0,50},{1,56},{8,64},{22,64},{29,56},{30,50}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{30,50},{31,56},{38,64},{52,64},{59,56},{60,50}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Ellipse(
          extent={{-2,6},{2,2}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-2,-22},{2,-26}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-2,-8},{2,-12}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>The model <em>M_Transformer</em> is a model of a transformer with the possibility to choose the number of inductors. Inside the model, an inductance matrix is built based on the inductance of the inductors and the coupling inductances between the inductors given as a parameter vector from the user of the model.</p>

<p>An example shows that approach:<br>
The user chooses a model with <strong>three</strong> inductors, that means the parameter <em><strong>N</strong></em> has to be <strong>3</strong>. Then he has to specify the inductances of the three inductors and the three coupling inductances. The coupling inductances are no real existing devices, but effects that occur between two inductors. The inductances (main diagonal of the inductance matrix) and the coupling inductances have to be specified in the parameter vector <em>L</em>. The length <em>dimL</em> of the parameter vector is calculated as follows: <em><strong>dimL=(N*(N+1))/2</strong></em></p>

<p>The following example shows how the parameter vector is used to fill in the inductance matrix. To specify the inductance matrix of a three inductances transformer (<em>N=3</em>):
</p>

<div>
<img
 src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Basic/M_Transformer-eq.png\"
 alt=\"L_m\">
</div>

<p>
the user has to allocate the parameter vector <em>L[6] </em>, since <em>Nv=(N*(N+1))/2=(3*(3+1))/2=6</em>. The parameter vector must be filled like this: <em>L=[1,0.1,0.2,2,0.3,3] </em>.</p>
<p>Inside the model, two loops are used to fill the inductance matrix to guarantee that it is filled in a symmetric way.</p>
</html>",
        revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Version</th>
      <th>Revision</th>
      <th>Date</th>
      <th>Author</th>
      <th>Comment</th>
    </tr>
   <tr>
      <td></td>
      <td>4163</td>
      <td>2010-09-11</td>
      <td>Dietmar Winkler</td>
      <td>Documentation corrected according to documentation guidelines.</td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td>2008-11-24</td>
      <td>Kristin Majetta</td>
      <td>Documentation added.</td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td>2008-11-16</td>
      <td>Kristin Majetta</td>
      <td>Initially implemented</td>
    </tr>
</table>
</html>"));
end M_Transformer;
