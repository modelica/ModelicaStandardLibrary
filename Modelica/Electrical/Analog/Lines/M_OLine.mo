within Modelica.Electrical.Analog.Lines;
model M_OLine "Multiple OLine"

  parameter SI.Length length(final min=Modelica.Constants.small)=
       0.1 "Length of line";
  parameter Integer N(final min=2) = 5 "Number of lumped segments";
  parameter Integer lines(final min=2) = 4 "Number of lines";
protected
  parameter Integer dim_vector_lgc=div(lines*(lines + 1), 2);
public
  parameter Real r[lines](
    each final min=Modelica.Constants.small,
    each unit="Ohm/m") = {4.76e5,1.72e5,1.72e5,1.72e5} "Resistance per meter";

  parameter Real l[dim_vector_lgc](
    each final min=Modelica.Constants.small,
    each unit="H/m") = {5.98e-7,4.44e-7,4.39e-7,3.99e-7,5.81e-7,4.09e-7,
    4.23e-7,5.96e-7,4.71e-7,6.06e-7} "Inductance per meter";

  parameter Real g[dim_vector_lgc](
    each final min=Modelica.Constants.small,
    each unit="S/m") = {8.05e-6,3.42e-5,2.91e-5,1.76e-6,9.16e-6,7.12e-6,
    2.43e-5,5.93e-6,4.19e-5,6.64e-6} "Conductance per meter";

  parameter Real c[dim_vector_lgc](
    each final min=Modelica.Constants.small,
    each unit="F/m") = {2.38e-11,1.01e-10,8.56e-11,5.09e-12,2.71e-11,2.09e-11,
    7.16e-11,1.83e-11,1.23e-10,2.07e-11} "Capacitance per meter";
  parameter Boolean useInternalGround=true "= true if internal ground is used, otherwise use reference pin"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.LinearTemperatureCoefficient alpha_R=0
    "Temperature coefficient of resistance (R_actual = R*(1 + alpha*(heatPort.T - T_ref))";
  parameter SI.LinearTemperatureCoefficient alpha_G=0
    "Temperature coefficient of conductance (G_actual = G/(1 + alpha*(heatPort.T - T_ref))";
  parameter Boolean useHeatPort=false "= true, if heatPort is enabled"
    annotation (
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true));
  parameter SI.Temperature T=293.15
    "Fixed device temperature if useHeatPort = false"
    annotation (Dialog(enable=not useHeatPort));
  parameter SI.Temperature T_ref=300.15 "Reference temperature";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}),
        iconTransformation(extent={{-110,-110},{-90,-90}})));
  model segment "Multiple line segment model"

    parameter Integer lines(final min=1) = 3 "Number of lines";
    parameter Integer dim_vector_lgc=div(lines*(lines + 1), 2)
      "Length of the vectors for l, g, c";
    Modelica.Electrical.Analog.Interfaces.PositivePin p[lines] "Positive pin"
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={{-110,-10},{-90,10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin n[lines] "Negative pin"
      annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin refPin
      "Reference pin"
      annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
          iconTransformation(extent={{-10,-110},{10,-90}})));

    parameter Real Cl[dim_vector_lgc]=fill(1, dim_vector_lgc)
      "Capacitance matrix";
    parameter Real Rl[lines]=fill(7, lines) "Resistance matrix";
    parameter Real Ll[dim_vector_lgc]=fill(2, dim_vector_lgc)
      "Inductance matrix";
    parameter Real Gl[dim_vector_lgc]=fill(1, dim_vector_lgc)
      "Conductance matrix";
    parameter SI.LinearTemperatureCoefficient alpha_R
      "Temperature coefficient of resistance (R_actual = R*(1 + alpha*(heatPort.T - T_ref))";
    parameter SI.LinearTemperatureCoefficient alpha_G
      "Temperature coefficient of conductance (G_actual = G/(1 + alpha*(heatPort.T - T_ref))";
    parameter Boolean useHeatPort=false "= true, if heatPort is enabled"
      annotation (
      Evaluate=true,
      HideResult=true,
      choices(checkBox=true));
    parameter SI.Temperature T=293.15
      "Fixed device temperature if useHeatPort = false"
      annotation (Dialog(enable=not useHeatPort));
    parameter SI.Temperature T_ref;

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort
      annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}),
                      iconTransformation(extent={{-110,-110},{-90,-90}})));
    Modelica.Electrical.Analog.Basic.Capacitor C[dim_vector_lgc](C=Cl);
    Modelica.Electrical.Analog.Basic.Resistor R[lines](
      R=Rl,
      T_ref=fill(T_ref, lines),
      alpha=fill(alpha_R, lines),
      useHeatPort=fill(useHeatPort, lines),
      T=fill(T, lines));
    Modelica.Electrical.Analog.Basic.Conductor G[dim_vector_lgc](
      G=Gl,
      T_ref=fill(T_ref, dim_vector_lgc),
      alpha=fill(alpha_G, dim_vector_lgc),
      useHeatPort=fill(useHeatPort, dim_vector_lgc),
      T=fill(T, dim_vector_lgc));
    Modelica.Electrical.Analog.Basic.M_Transformer inductance(N=lines, L=Ll);
    Modelica.Electrical.Analog.Ideal.Short M annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,-70})));
  equation
    for j in 1:lines - 1 loop

      connect(R[j].p, p[j]);
      connect(R[j].n, inductance.p[j]);
      connect(inductance.n[j], n[j]);
      connect(inductance.n[j], C[((1 + (j - 1)*lines) - div(((j - 2)*(j - 1)),
        2))].p);
      connect(C[((1 + (j - 1)*lines) - div(((j - 2)*(j - 1)), 2))].n,M.p);
      connect(inductance.n[j], G[((1 + (j - 1)*lines) - div(((j - 2)*(j - 1)),
        2))].p);
      connect(G[((1 + (j - 1)*lines) - div(((j - 2)*(j - 1)), 2))].n,M.p);

      for i in j + 1:lines loop
        connect(inductance.n[j], C[((1 + (j - 1)*lines) - div(((j - 2)*(j - 1)),
          2)) + 1 + i - (j + 1)].p);
        connect(C[((1 + (j - 1)*lines) - div(((j - 2)*(j - 1)), 2)) + 1 + i
           - (j + 1)].n, inductance.n[i]);
        connect(inductance.n[j], G[((1 + (j - 1)*lines) - div(((j - 2)*(j - 1)),
          2)) + 1 + i - (j + 1)].p);
        connect(G[((1 + (j - 1)*lines) - div(((j - 2)*(j - 1)), 2)) + 1 + i
           - (j + 1)].n, inductance.n[i]);

      end for;
    end for;
    connect(R[lines].p, p[lines]);
    connect(R[lines].n, inductance.p[lines]);
    connect(inductance.n[lines], n[lines]);
    connect(inductance.n[lines], C[dim_vector_lgc].p);
    connect(C[dim_vector_lgc].n,M.p);
    connect(inductance.n[lines], G[dim_vector_lgc].p);
    connect(G[dim_vector_lgc].n,M.p);

    if useHeatPort then

      for j in 1:lines - 1 loop
        connect(heatPort, R[j].heatPort);
        connect(heatPort, G[((1 + (j - 1)*lines) - div(((j - 2)*(j - 1)), 2))].heatPort);
        for i in j + 1:lines loop
          connect(heatPort, G[((1 + (j - 1)*lines) - div(((j - 2)*(j - 1)), 2))
             + 1 + i - (j + 1)].heatPort);
        end for;
      end for;
      connect(heatPort, R[lines].heatPort);
      connect(heatPort, G[dim_vector_lgc].heatPort);
    end if;

    connect(M.n, refPin) annotation (Line(points={{-1.77636e-15,-80},{-1.77636e-15,
            -91},{0,-91},{0,-100}}, color={0,0,255}));
    annotation (defaultComponentName="segment", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(extent={{40,-40},{-40,40}},
            lineColor={0,0,255}),
          Text(
            extent={{-150,90},{150,50}},
            textString="%name",
            textColor={0,0,255})}), Documentation(info="<html>
<p>The segment model is part of the multiple line model. It describes one line segment as outlined in the M_OLine description. Using the loop possibilities of Modelica it is formulated by connecting components the number of which depends on the number of lines.</p>
</html>"));
  end segment;

  model segment_last "Multiple line last segment model"

    Modelica.Electrical.Analog.Interfaces.PositivePin p[lines] "Positive pin"
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={{-110,-10},{-90,10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin n[lines] "Negative pin"
      annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
    parameter Integer lines(final min=1) = 3 "Number of lines";
    parameter Integer dim_vector_lgc=div(lines*(lines + 1), 2)
      "Length of the vectors for l, g, c";
    parameter Real Rl[lines]=fill(1, lines) "Resistance matrix";
    parameter Real Ll[dim_vector_lgc]=fill(1, dim_vector_lgc)
      "Inductance matrix";
    parameter SI.LinearTemperatureCoefficient alpha_R
      "Temperature coefficient of resistance (R_actual = R*(1 + alpha*(heatPort.T - T_ref))";
    parameter Boolean useHeatPort=false "= true, if HeatPort is enabled"
      annotation (
      Evaluate=true,
      HideResult=true,
      choices(checkBox=true));
    parameter SI.Temperature T=293.15
      "Fixed device temperature if useHeatPort = false"
      annotation (Dialog(enable=not useHeatPort));
    parameter SI.Temperature T_ref(start=293.15);
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort
      annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}),
                      iconTransformation(extent={{-110,-110},{-90,-90}})));
    Modelica.Electrical.Analog.Basic.Resistor R[lines](
      R=Rl,
      T_ref=fill(T_ref, lines),
      useHeatPort=fill(useHeatPort, lines),
      T=fill(T, lines));
    Modelica.Electrical.Analog.Basic.M_Transformer inductance(N=lines, L=Ll);

  equation
    for j in 1:lines - 1 loop

      connect(p[j], inductance.p[j]);
      connect(inductance.n[j], R[j].p);
      connect(R[j].n, n[j]);

    end for;
    connect(p[lines], inductance.p[lines]);
    connect(inductance.n[lines], R[lines].p);
    connect(R[lines].n, n[lines]);

    if useHeatPort then
      for j in 1:lines - 1 loop
        connect(heatPort, R[j].heatPort);
      end for;
      connect(heatPort, R[lines].heatPort);
    end if;
    annotation (defaultComponentName="segment", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(extent={{20,-40},{-20,40}},
            lineColor={0,0,255}),
          Text(
            extent={{-150,90},{150,50}},
            textString="%name",
            textColor={0,0,255})}), Documentation(info="<html>
<p>The segment_last model is part of the multiple line model. It describes the special  line segment which is used to get the line symmetrical as outlined in the M_OLine description. Using the loop possibilities of Modelica it is formulated by connecting components the number of which depends on the number of lines.</p>
</html>"));
  end segment_last;

  segment s[N - 1](
    lines=fill(lines, N - 1),
    dim_vector_lgc=fill(dim_vector_lgc, N - 1),
    Rl=fill(r*length/N, N - 1),
    Ll=fill(l*length/N, N - 1),
    Cl=fill(c*length/N, N - 1),
    Gl=fill(g*length/N, N - 1),
    alpha_R=fill(alpha_R, N - 1),
    alpha_G=fill(alpha_G, N - 1),
    T_ref=fill(T_ref, N - 1),
    useHeatPort=fill(useHeatPort, N - 1),
    T=fill(T, N - 1));
  segment s_first(
    lines=lines,
    dim_vector_lgc=dim_vector_lgc,
    Rl=r*length/(2*N),
    Cl=c*length/(N),
    Ll=l*length/(2*N),
    Gl=g*length/(N),
    alpha_R=alpha_R,
    alpha_G=alpha_G,
    T_ref=T_ref,
    useHeatPort=useHeatPort,
    T=T);
  segment_last s_last(
    lines=lines,
    Rl=r*length/(2*N),
    Ll=l*length/(2*N),
    alpha_R=alpha_R,
    T_ref=T_ref,
    useHeatPort=useHeatPort,
    T=T);
  Modelica.Electrical.Analog.Interfaces.PositivePin p[lines] "Positive pin"
    annotation (Placement(transformation(extent={{-110,-60},{-90,60}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n[lines] "Negative pin"
    annotation (Placement(transformation(extent={{90,-60},{110,60}})));

  Modelica.Electrical.Analog.Interfaces.NegativePin refPin if not useInternalGround "Reference pin"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
        iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Electrical.Analog.Basic.Ground ground if useInternalGround
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
equation
  connect(p, s_first.p);
  connect(s_first.n, s[1].p);
  for i in 1:N - 2 loop
    connect(s[i].n, s[i + 1].p);
  end for;
  connect(s[N - 1].n, s_last.p);
  connect(s_last.n, n);
  connect(s_first.refPin, refPin);
  connect(s_first.refPin, ground.p);
  for i in 1:N-1 loop
    connect(s[i].refPin, refPin);
    connect(s[i].refPin, ground.p);
  end for;
  if useHeatPort then
    connect(heatPort, s_first.heatPort);
    for i in 1:N - 1 loop
      connect(heatPort, s[i].heatPort);
    end for;
    connect(heatPort, s_last.heatPort);
  end if;

  annotation (defaultComponentName="line", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Rectangle(
          extent={{80,80},{-80,-80}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
        Line(points={{40,60},{40,40}}),
        Line(points={{40,50},{-40,50}}),
        Line(points={{-40,60},{-40,40}}),
        Line(points={{40,-40},{40,-60}}),
        Line(points={{40,-50},{-40,-50}}),
        Line(points={{-40,-40},{-40,-60}}),
        Line(points={{40,30},{40,10}}),
        Line(points={{40,20},{-40,20}}),
        Line(points={{-40,30},{-40,10}}),
        Line(
          points={{0,6},{0,-34}},
          color={0,0,255},
          pattern=LinePattern.Dot),
        Text(
          extent={{-150,130},{150,90}},
          textString="%name",
          textColor={0,0,255})}), Documentation(info="<html>
<p>The <code>M_OLine</code> is a multi line model which consists of several segments 
and several single lines. Each segment consists of resistors and inductors that 
are connected in series in each single line, and of capacitors and conductors both 
between the lines and to the ground. The inductors are coupled to each other like in the
<a href=\"modelica://Modelica.Electrical.Analog.Basic.M_Transformer\">M_Transformer</a> model. 
The following picture shows the schematic of a segment with four single lines (lines=4):</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Lines/segment.png\"
     alt=\"segment.png\">
</blockquote>

<p>Note that the user can choose whether the optional &quot;refPin&quot; 
is active (so that it can be connected to any other pin), 
otherwise the internal &quot;ground&quot; is used. 
This is done with the checkbox useInternalGround, true by default
 (for compatibility with previous versions).
Obviously the  potential of the internal ground is always zero, 
its current can be accessed for plotting.</p>

<p>The complete multi line consists of N segments and an auxiliary segment_last:</p>

<p align=\"center\"><code>-- segment_1 -- segment_2 -- ... -- segment_N -- segment_last --</code></p>

<p>In the picture of the segment can be seen, that a single segment is asymmetric. 
Connecting such asymmetric segments in a series forces also an asymmetric multi line. 
To get a symmetric model which is useful for coupling and which guaranties the same pin properties, 
in the <code>segment_1</code> only half valued resistors and inductors are used. 
The remaining resistors and inductors are at the other end of the line within 
the auxiliary segment_last. For the example with 4 lines the schematic of 
<code>segment_last</code> is like this:</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Lines/segment_last.png\"
     alt=\"segment_last.png\">
</blockquote>

<p>The number of the capacitors and conductors depends on the number of single lines that are used,
because each line is connected to every other line by both a capacitor and a conductor. 
One line consists of <strong>at least two segments</strong>. 
Inside the model <code>M_OLine</code> the model <code>segment</code> is used. 
This model represents one segment which is build as described above. 
For modelling the inductances and their mutual couplings the model 
<a href=\"modelica://Modelica.Electrical.Analog.Basic.M_Transformer\">M_Transformer</a> is used. 
To fill the resistance vector, resistance values as many as lines are needed, e.g., 
if there are four lines, four resistances are needed. For example for a microelectronic line 
of 0.1m length, a sensible resistance-vector would be R=[4.76e5, 1.72e5, 1.72e5, 1.72e5].</p>

<p>Filling the matrices of the inductances, capacitances and conductances is a bit more complicated,
because those components occur also between two lines and not only (like the resistor) in one line.
The entries of the matrices are given by the user in form of a vector. 
The vector length <code>dim_vector_lgc</code> is calculated by:</p>

<blockquote>
<pre>dim_vector_lgc = lines*(lines+1)/2</pre>
</blockquote>

<p>Inside the model a symmetric inductance matrix, a symmetric capacitance matrix and
a symmetric conductance matrix are built out of the entries of the vectors given by the user. 
The way of building is the same for each matrix, so the approach for filling one of the matrices
will be shown in the the examplebelow.</p>

<h5>Example</h5>

<p>The number of lines is assumed to be four. To build the matrix, the model needs the 
values from the main diagonal and from the positions that are below the main diagonal. 
To get the following matrix</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Lines/M_OLine-eqMatrix.png\" alt=\"Matrix\"/>
</blockquote>

<p>the vector with dim_vector_lgc=4*5/2=10 has to appear in the following way: 
vector = [<strong>1</strong>, 0.1, 0.2, 0.4, <strong>2</strong>, 0.3 0.5, <strong>3</strong>, 0.6, <strong>4</strong>]</p>

<p>For the example of a microelectronic line of 0.1m length, 
which is used as default example for the <code>M_OLine</code> model, 
a sensible inductance-matrix would be:</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Lines/M_OLine-eqL.png\" alt=\"L\"/>
</blockquote>

<p>For the example of a microelectronic line of 0.1m length, which is used as default example 
for the <code>M_OLine</code> model, a sensible capacitance-matrix would be:</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Lines/M_OLine-eqC.png\" alt=\"C\"/>
</blockquote>

<p>For the example of a microelectronic line of 0.1m length, which is used as default example 
for the <code>M_OLine</code> model, a sensible conductance-matrix would be:</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Lines/M_OLine-eqG.png\" alt=\"G\"/>
</blockquote>

<p>The user has the possibility to enable a conditional heatport. If so, the <code>M_OLine</code> 
can be connected to a thermal network. When the parameter <code>alpha</code> is set to a value greater than zero,
the <code>M_OLine</code> becomes temperature sensitive due to their resistors which resistances 
are calculated by</p>

<blockquote>
<pre>R_actual = R*(1 + alpha*(heatPort.T - T_ref))</pre>
</blockquote>

<p>and conductors calculated by</p> 

<blockquote>
<pre>G_actual = G/(1 + alpha*(heatPort.T - T_ref))</pre>
</blockquote>
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
      <td>2007-02-26</td>
      <td>Kristin Majetta</td>
      <td>Initially implemented</td>
    </tr>
</table>
</html>"));
end M_OLine;
