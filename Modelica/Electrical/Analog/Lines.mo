within Modelica.Electrical.Analog;
package Lines
  "Lossy and lossless segmented transmission lines, and LC distributed line models"
  extends Modelica.Icons.Package;

  model OLine "Lossy Transmission Line"
    //extends Interfaces.ThreePol;
    Modelica.Electrical.Analog.Interfaces.Pin p1 annotation (Placement(
          transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Electrical.Analog.Interfaces.Pin p2 annotation (Placement(
          transformation(extent={{90,-10},{110,10}})));
    Modelica.Electrical.Analog.Interfaces.Pin p3 annotation (Placement(
          transformation(extent={{-10,-110},{10,-90}})));
    SI.Voltage v13;
    SI.Voltage v23;
    SI.Current i1;
    SI.Current i2;
    parameter Real r(
      final min=Modelica.Constants.small,
      unit="Ohm/m",
      start=1) "Resistance per meter";
    parameter Real l(
      final min=Modelica.Constants.small,
      unit="H/m",
      start=1) "Inductance per meter";
    parameter Real g(
      final min=Modelica.Constants.small,
      unit="S/m",
      start=1) "Conductance per meter";
    parameter Real c(
      final min=Modelica.Constants.small,
      unit="F/m",
      start=1) "Capacitance per meter";
    parameter SI.Length length(final min=Modelica.Constants.small,
        start=1) "Length of line";
    parameter Integer N(final min=1, start=1) "Number of lumped segments";
    parameter SI.LinearTemperatureCoefficient alpha_R=0
      "Temperature coefficient of resistance (R_actual = R*(1 + alpha*(T_heatPort - T_ref))";
    parameter SI.LinearTemperatureCoefficient alpha_G=0
      "Temperature coefficient of conductance (G_actual = G/(1 + alpha*(T_heatPort - T_ref))";
    parameter Boolean useHeatPort=false "=true, if HeatPort is enabled"
      annotation (
      Evaluate=true,
      HideResult=true,
      choices(checkBox=true));
    parameter SI.Temperature T=293.15
      "Fixed device temperature if useHeatPort = false"
      annotation (Dialog(enable=not useHeatPort));
    parameter SI.Temperature T_ref=300.15;
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort
      annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
          iconTransformation(extent={{-110,-110},{-90,-90}})));
  protected
    parameter Modelica.SIunits.Resistance rm[N + 1]=
    {if i==1 or i==N + 1 then r*length/(N*2) else r*length/N for i in 1:N+1};
    Modelica.Electrical.Analog.Basic.Resistor R[N + 1](
      R=rm,
      T_ref=fill(T_ref, N + 1),
      alpha=fill(alpha_R, N + 1),
      useHeatPort=fill(useHeatPort, N + 1),
      T=fill(T, N + 1));
    parameter Modelica.SIunits.Inductance lm[N + 1]=
    {if i==1 or i==N + 1 then l*length/(N*2) else l*length/N for i in 1:N+1};
    Modelica.Electrical.Analog.Basic.Inductor L[N + 1](L=lm);
    Modelica.Electrical.Analog.Basic.Capacitor C[N](C=fill(c*length/(N), N));
    Modelica.Electrical.Analog.Basic.Conductor G[N](
      G=fill(g*length/(N), N),
      T_ref=fill(T_ref, N),
      alpha=fill(alpha_G, N),
      useHeatPort=fill(useHeatPort, N),
      T=fill(T, N));
  equation
    v13 = p1.v - p3.v;
    v23 = p2.v - p3.v;
    i1 = p1.i;
    i2 = p2.i;
    connect(p1, R[1].p);
    for i in 1:N loop
      connect(R[i].n, L[i].p);
      connect(L[i].n, C[i].p);
      connect(L[i].n, G[i].p);
      connect(C[i].n, p3);
      connect(G[i].n, p3);
      connect(L[i].n, R[i + 1].p);
    end for;
    connect(R[N + 1].n, L[N + 1].p);
    connect(L[N + 1].n, p2);
    if useHeatPort then
      for i in 1:N + 1 loop
        connect(heatPort, R[i].heatPort);
      end for;
      for i in 1:N loop
        connect(heatPort, G[i].heatPort);
      end for;
    end if;
    annotation (defaultComponentName="line",
      Documentation(info="<html>
<p>Like in the picture below, the lossy transmission line OLine is a single-conductor lossy transmission line which consists of segments of lumped resistors and inductors in series and conductor and capacitors that are connected with the reference pin p3. The precision of the model depends on the number N of lumped segments.</p>
<p>To get a symmetric line model, the first resistor and inductor are cut into two parts (R1 and R_Nplus1, L1 and L_Nplus1). These two new resistors and inductors have the half of the resistance respectively inductance the original resistor respectively inductor.</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/OLine.png\"
     alt=\"OLine.png\">
</p>

<p>The capacitances are calculated with: C=c*length/N.
<br> The conductances are calculated with: G=g*length/N.
<br> The resistances are calculated with : R=r*length/(N+1).
<br> The inductances are calculated with : L=l*length/(N+1).
<br> For all capacitors, conductors, resistors and inductors the values of each segment are the same except of the first and last resistor and inductor, that only have the half of the above calculated value of the rest.</p>
<p>The user has the possibility to enable a conditional heatport. If so, the OLine can be connected to a thermal network. When the parameter alpha is set to an value greater than zero, the OLine becomes temperature sensitive</p><p>due to their resistors which resistances are calculated by <code>R_actual = R*(1 + alpha*(heatPort.T - T_ref))</code> and conductors calculated by <code> (G_actual = G/(1 + alpha*(T_heatPort - T_ref)).</code></p>
<p>Note, this is different to the lumped line model of SPICE.</p>

<dl><dt><strong>References:</strong> </dt>
<dd>Johnson, B.; Quarles, T.; Newton, A. R.; Pederson, D. O.; Sangiovanni-Vincentelli, A.: SPICE3 Version 3e User&#39;s Manual (April 1, 1991). Department of Electrical Engineering and Computer Sciences, University of California, Berkley p. 12, p. 106 - 107 </dd>
</dl></html>", revisions="<html>
<ul>
<li><em> 2016   </em>
       by Christoph Clauss<br> resistance and inductance calculation revised<br>
       </li>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-80,80},{80,-80}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{0,-80},{0,-90}}, color={0,0,255}),
          Line(points={{80,0},{90,0}}, color={0,0,255}),
          Line(points={{-80,0},{-90,0}}, color={0,0,255}),
          Text(
            extent={{-150,130},{150,90}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{40,30},{-40,30}}),
          Line(points={{-40,40},{-40,20}}),
          Line(points={{40,40},{40,20}})}));
  end OLine;

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
    parameter SI.LinearTemperatureCoefficient alpha_R=0
      "Temperature coefficient of resistance (R_actual = R*(1 + alpha*(T_heatPort - T_ref))";
    parameter SI.LinearTemperatureCoefficient alpha_G=0
      "Temperature coefficient of conductance (G_actual = G/(1 + alpha*(T_heatPort - T_ref))";
    parameter Boolean useHeatPort=false "=true, if HeatPort is enabled"
      annotation (
      Evaluate=true,
      HideResult=true,
      choices(checkBox=true));
    parameter SI.Temperature T=293.15
      "Fixed device temperature if useHeatPort = false"
      annotation (Dialog(enable=not useHeatPort));
    parameter SI.Temperature T_ref=300.15;
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

      parameter Real Cl[dim_vector_lgc]=fill(1, dim_vector_lgc)
        "Capacitance matrix";
      parameter Real Rl[lines]=fill(7, lines) "Resistance matrix";
      parameter Real Ll[dim_vector_lgc]=fill(2, dim_vector_lgc)
        "Inductance matrix";
      parameter Real Gl[dim_vector_lgc]=fill(1, dim_vector_lgc)
        "Conductance matrix";
      parameter SI.LinearTemperatureCoefficient alpha_R
        "Temperature coefficient of resistance (R_actual = R*(1 + alpha*(T_heatPort - T_ref))";
      parameter SI.LinearTemperatureCoefficient alpha_G
        "Temperature coefficient of conductance (G_actual = G/(1 + alpha*(T_heatPort - T_ref))";
      parameter Boolean useHeatPort=false "=true, if HeatPort is enabled"
        annotation (
        Evaluate=true,
        HideResult=true,
        choices(checkBox=true));
      parameter SI.Temperature T=293.15
        "Fixed device temperature if useHeatPort = false"
        annotation (Dialog(enable=not useHeatPort));
      parameter SI.Temperature T_ref;

      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if
        useHeatPort annotation (Placement(transformation(extent={{-10,-110},{10,
                -90}}), iconTransformation(extent={{-110,-110},{-90,-90}})));

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
      Modelica.Electrical.Analog.Basic.Ground M;

    equation
      for j in 1:lines - 1 loop

        connect(R[j].p, p[j]);
        connect(R[j].n, inductance.p[j]);
        connect(inductance.n[j], n[j]);
        connect(inductance.n[j], C[((1 + (j - 1)*lines) - div(((j - 2)*(j - 1)),
          2))].p);
        connect(C[((1 + (j - 1)*lines) - div(((j - 2)*(j - 1)), 2))].n, M.p);
        connect(inductance.n[j], G[((1 + (j - 1)*lines) - div(((j - 2)*(j - 1)),
          2))].p);
        connect(G[((1 + (j - 1)*lines) - div(((j - 2)*(j - 1)), 2))].n, M.p);

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
      connect(C[dim_vector_lgc].n, M.p);
      connect(inductance.n[lines], G[dim_vector_lgc].p);
      connect(G[dim_vector_lgc].n, M.p);

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

      annotation (defaultComponentName="segment", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(extent={{40,-40},{-40,40}},
              lineColor={0,0,255}),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
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
        "Temperature coefficient of resistance (R_actual = R*(1 + alpha*(T_heatPort - T_ref))";
      parameter Boolean useHeatPort=false "=true, if HeatPort is enabled"
        annotation (
        Evaluate=true,
        HideResult=true,
        choices(checkBox=true));
      parameter SI.Temperature T=293.15
        "Fixed device temperature if useHeatPort = false"
        annotation (Dialog(enable=not useHeatPort));
      parameter SI.Temperature T_ref;
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if
        useHeatPort annotation (Placement(transformation(extent={{-10,-110},{10,
                -90}}), iconTransformation(extent={{-110,-110},{-90,-90}})));
      Modelica.Electrical.Analog.Basic.Resistor R[lines](
        R=Rl,
        T_ref=fill(T_ref, lines),
        useHeatPort=fill(useHeatPort, lines),
        T=fill(T, lines));
      Modelica.Electrical.Analog.Basic.M_Transformer inductance(N=lines, L=Ll);
      Modelica.Electrical.Analog.Basic.Ground M;

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
              lineColor={0,0,255})}), Documentation(info="<html>
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

  equation
    connect(p, s_first.p);
    connect(s_first.n, s[1].p);
    for i in 1:N - 2 loop
      connect(s[i].n, s[i + 1].p);
    end for;
    connect(s[N - 1].n, s_last.p);
    connect(s_last.n, n);
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
            lineColor={0,0,255})}), Documentation(info="<html>
<p>The M_OLine is a multi line model which consists of several segments and several single lines. Each segment consists of resistors and inductors that are connected in series in each single line, and of capacitors and conductors both between the lines and to the ground. The inductors are coupled to each other like in the M_Transformer model. The following picture shows the schematic of a segment with four single lines (lines=4):</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/segment.png\"
     alt=\"segment.png\">
</blockquote>

<p>The complete multi line consists of N segments and an auxiliary segment_last:</p>
<p align=\"center\"><code>-- segment_1 -- segment_2 -- ... -- segment_N -- segment_last --</code></p>
<p>In the picture of the segment can be seen, that a single segment is asymmetric. Connecting such asymmetric segments in a series forces also an asymmetric multi line. To get a symmetric model which is useful for coupling and which guaranties the same pin properties, in the segment_1 only half valued resistors and inductors are used. The remaining resistors and inductors are at the other end of the line within the auxiliary segment_last. For the example with 4 lines the schematic of segment_last is like this:</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/segment_last.png\"
     alt=\"segment_last.png\">
</blockquote>

<p>The number of the capacitors and conductors depends on the number of single lines that are used, because each line is connected to every other line by both a capacitor and a conductor. One line consists of <strong>at least two segments</strong>. Inside the model M_OLine the model <em>segment</em> is used. This model represents one segment which is build as described above. For modelling the inductances and their mutual couplings the model M_Transformer is used. To fill the resistance vector, resistance values as many as lines are needed, e.g., if there are four lines, four resistances are needed. For example for a microelectronic line of 0.1m length, a sensible resistance-vector would be R=[4.76e5, 1.72e5, 1.72e5, 1.72e5].</p>
<p>Filling the matrices of the inductances, capacitances and conductances is a bit more complicated, because those components occur also between two lines and not only (like the resistor) in one line. The entries of the matrices are given by the user in form of a vector. The vector length dim_vector_lgc is calculated by <strong>dim_vector_lgc = lines*(lines+1)/2</strong>. Inside the model a symmetric inductance matrix, a symmetric capacitance matrix and a symmetric conductance matrix are built out of the entries of the vectors given by the user. The way of building is the same for each matrix, so the approach for filling one of the matrices will be shown at an example:</p>
<p>The number of lines is assumed to be four. To build the matrix, the model needs the values from the main diagonal and from the positions that are below the main diagonal. To get the following matrix</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Lines/M_OLine-eqMatrix.png\" alt=\"Matrix\"/>
</blockquote>

<p>the vector with dim_vector_lgc=4*5/2=10 has to appear in the following way: vector = [<strong>1</strong>, 0.1, 0.2, 0.4, <strong>2</strong>, 0.3 0.5, <strong>3</strong>, 0.6, <strong>4</strong>]</p>

<p>For the example of a microelectronic line of 0.1m length, which is used as default example for the M_OLine model, a sensible inductance-matrix would be </p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Lines/M_OLine-eqL.png\" alt=\"L\"/>
</blockquote>

<p>For the example of a microelectronic line of 0.1m length, which is used as default example for the M_OLine model, a sensible capacitance-matrix would be:</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Lines/M_OLine-eqC.png\" alt=\"C\"/>
</blockquote>

<p>For the example of a microelectronic line of 0.1m length, which is used as default example for the M_OLine model, a sensible conductance-matrix would be:</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Lines/M_OLine-eqG.png\" alt=\"G\"/>
</blockquote>

<p>The user has the possibility to enable a conditional heatport. If so, the M_OLine can be connected to a thermal network. When the parameter alpha is set to an value greater than zero, the M_OLine becomes temperature sensitive due to their resistors which resistances are calculated by R_actual = R*(1 + alpha*(heatPort.T - T_ref)) and conductors calculated by (G_actual = G/(1 + alpha*(T_heatPort - T_ref)).</p>
</html>", revisions="<html>
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

  model ULine "Lossy RC Line"
    //extends Interfaces.ThreePol;
    Modelica.Electrical.Analog.Interfaces.Pin p1 annotation (Placement(
          transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Electrical.Analog.Interfaces.Pin p2 annotation (Placement(
          transformation(extent={{90,-10},{110,10}})));
    Modelica.Electrical.Analog.Interfaces.Pin p3 annotation (Placement(
          transformation(extent={{-10,-110},{10,-90}}),
          iconTransformation(extent={{-10,-110},{10,-90}})));
    SI.Voltage v13;
    SI.Voltage v23;
    SI.Current i1;
    SI.Current i2;
    parameter Real r(
      final min=Modelica.Constants.small,
      unit="Ohm/m",
      start=1) "Resistance per meter";
    parameter Real c(
      final min=Modelica.Constants.small,
      unit="F/m",
      start=1) "Capacitance per meter";
    parameter SI.Length length(final min=Modelica.Constants.small,
        start=1) "Length of line";
    parameter Integer N(final min=1, start=1) "Number of lumped segments";
    parameter SI.LinearTemperatureCoefficient alpha=0
      "Temperature coefficient of resistance (R_actual = R*(1 + alpha*(T_heatPort - T_ref))";
    parameter Boolean useHeatPort=false "=true, if HeatPort is enabled"
      annotation (
      Evaluate=true,
      HideResult=true,
      choices(checkBox=true));
    parameter SI.Temperature T=293.15
      "Fixed device temperature if useHeatPort = false"
      annotation (Dialog(enable=not useHeatPort));
    parameter SI.Temperature T_ref=300.15;
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort
      annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
          iconTransformation(extent={{-108,-110},{-88,-90}})));
  protected
     parameter Modelica.SIunits.Resistance rm[N + 1]=
    {if i==1 or i==N + 1 then r*length/(N*2) else r*length/N for i in 1:N+1};
    Modelica.Electrical.Analog.Basic.Resistor R[N + 1](
      R=rm,
      T_ref=fill(T_ref, N + 1),
      alpha=fill(alpha, N + 1),
      useHeatPort=fill(useHeatPort, N + 1),
      T=fill(T, N + 1));
    Modelica.Electrical.Analog.Basic.Capacitor C[N](C=fill(c*length/(N), N));
  equation
    v13 = p1.v - p3.v;
    v23 = p2.v - p3.v;
    i1 = p1.i;
    i2 = p2.i;
    connect(p1, R[1].p);
    for i in 1:N loop
      connect(R[i].n, R[i + 1].p);
    end for;
    for i in 1:N loop
      connect(R[i].n, C[i].p);
    end for;
    for i in 1:N loop
      connect(C[i].n, p3);
    end for;
    connect(R[N + 1].n, p2);
    if useHeatPort then
      for i in 1:N + 1 loop
        connect(heatPort, R[i].heatPort);
      end for;
    end if;
    annotation (defaultComponentName="line",
      Documentation(info="<html>
<p>As can be seen in the picture below, the lossy RC line ULine is a single conductor lossy transmission line which consists of segments of lumped series resistors and capacitors that are connected with the reference pin p3. The precision of the model depends on the number N of lumped segments.
<br>To get a symmetric line model, the first resistor is cut into two parts (R1 and R_Nplus1). These two new resistors have the half of the resistance of the original resistor.
</p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/ULine.png\"
     alt=\"ULine.png\">
</blockquote>
<p>
The capacitances are calculated with: C=c*length/N.
<br>The resistances are calculated with: R=r*length/(N+1).
<br>For all capacitors and resistors the values of each segment are the same except for the first and last resistor, that only has the half of the above calculated value.<p>The user has the possibility to enable a conditional heatport. If so, the ULine can be connected to a thermal network. When the parameter alpha is set to an value greater than zero, the ULine becomes temperature sensitive</p>
<p>due to their resistors which resistances are calculated by <code>R_actual= R*(1 + alpha*(heatPort.T - T_ref)).</code></p>
<p>Note, this is different compared with the lumped line model of SPICE.</p>
<p><strong>References</strong></p>
<dl><dt>Johnson, B.; Quarles, T.; Newton, A. R.; Pederson, D. O.; Sangiovanni-Vincentelli, A.</dt>
<dd>SPICE3 Version 3e User&#39;s Manual (April 1, 1991). Department of Electrical Engineering and Computer Sciences, University of California, Berkley p. 22, p. 124 </dd>
</dl></html>", revisions="<html>
<dl>
<dt><em>2016</em></dt>
<dd>by Christoph Clauss resistance calculation revised</dd>
<dt><em>1998</em></dt>
<dd>by Christoph Clauss initially implemented</dd>
</dl>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Text(
            extent={{-150,130},{150,90}},
            textString="%name",
            lineColor={0,0,255}),
          Rectangle(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,255},
            fillPattern=FillPattern.Solid,
            fillColor={255,255,255}),
          Line(points={{80,0},{100,0}}, color={0,0,255}),
          Line(points={{-80,0},{-100,0}}, color={0,0,255}),
          Line(points={{-40,40},{-40,20}}),
          Line(points={{40,30},{-40,30}}),
          Line(points={{40,40},{40,20}}),
          Line(points={{0,-80},{0,-100}}, color={0,0,255}),
          Text(
            extent={{-70,-10},{70,-50}},
            textString="ULine")}));
  end ULine;

  model TLine1
    "Lossless transmission line with characteristic impedance Z0 and transmission delay TD"

    extends Modelica.Electrical.Analog.Interfaces.TwoPort;
    parameter SI.Resistance Z0(start=1)
      "Characteristic impedance";
    parameter SI.Time TD(start=1) "Transmission delay";
  protected
    SI.Voltage er;
    SI.Voltage es;
  equation
    assert(Z0 > 0, "Z0 has to be positive");
    assert(TD > 0, "TD has to be positive");
    i1 = (v1 - es)/Z0;
    i2 = (v2 - er)/Z0;
    es = 2*delay(v2, TD) - delay(er, TD);
    er = 2*delay(v1, TD) - delay(es, TD);
    annotation (defaultComponentName="line",
      Documentation(info="<html>
<p>Lossless transmission line with characteristic impedance Z0 and transmission delay TD The lossless transmission line TLine1 is a two Port. Both port branches consist of a resistor with characteristic impedance Z0 and a controlled voltage source that takes into consideration the transmission delay TD. For further details see Branin&#39;s article below. The model parameters can be derived from inductance and capacitance per length (L&#39; resp. C&#39;), i. e. Z0 = sqrt(L&#39;/C&#39;) and TD = sqrt(L&#39;*C&#39;)*length_of_line. Resistance R&#39; and conductance C&#39; per meter are assumed to be zero.</p>
<p><strong>References:</strong></p>
<dl><dt>Branin Jr., F. H.</dt>
<dd>Transient Analysis of Lossless Transmission Lines. Proceedings of the IEEE 55(1967), 2012 - 2013</dd>
<dt>Hoefer, E. E. E.; Nielinger, H.</dt>
<dd>SPICE : Analyseprogramm fuer elektronische Schaltungen. Springer-Verlag, Berlin, Heidelberg, New York, Tokyo, 1985. </dd>
</dl></html>", revisions="<html>
<ul>
<li><em> 1998   </em>
       by Joachim Haase<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255}),
          Rectangle(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,255},
            fillPattern=FillPattern.Solid,
            fillColor={255,255,255}),
          Line(points={{60,-100},{90,-100}}, color={0,0,255}),
          Line(points={{60,100},{90,100}}, color={0,0,255}),
          Line(points={{-60,100},{-90,100}}, color={0,0,255}),
          Line(points={{-60,-100},{-90,-100}}, color={0,0,255}),
          Text(
            extent={{-70,-10},{70,-50}},
            textString="TLine1"),
          Line(points={{-40,40},{-40,20}}),
          Line(points={{40,30},{-40,30}}),
          Line(points={{40,40},{40,20}}),
          Line(points={{-60,100},{-60,80}}, color={0,0,255}),
          Line(points={{60,100},{60,80}}, color={0,0,255}),
          Line(points={{60,-80},{60,-100}}, color={0,0,255}),
          Line(points={{-60,-80},{-60,-100}}, color={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}),graphics={
                                      Text(
              extent={{-100,100},{100,70}},
              textString="TLine1",
              lineColor={0,0,255})}));
  end TLine1;

  model TLine2
    "Lossless transmission line with characteristic impedance Z0, frequency F and normalized length NL"

    extends Modelica.Electrical.Analog.Interfaces.TwoPort;
    parameter SI.Resistance Z0(start=1)
      "Characteristic impedance";
    parameter SI.Frequency F(start=1) "Frequency";
    parameter Real NL(start=1) "Normalized length";
  protected
    SI.Voltage er;
    SI.Voltage es;
    parameter SI.Time TD=NL/F;
  equation
    assert(Z0 > 0, "Z0 has to be positive");
    assert(NL > 0, "NL has to be positive");
    assert(F > 0, "F has to be positive");
    i1 = (v1 - es)/Z0;
    i2 = (v2 - er)/Z0;
    es = 2*delay(v2, TD) - delay(er, TD);
    er = 2*delay(v1, TD) - delay(es, TD);
    annotation (defaultComponentName="line",
      Documentation(info="<html>
<p>Lossless transmission line with characteristic impedance Z0, frequency F and normalized length NL The lossless transmission line TLine2 is a two Port. Both port branches consist of a resistor with the value of the characteristic impedance Z0 and a controlled voltage source that takes into consideration the transmission delay. For further details see Branin&#39;s article below. Resistance R&#39; and conductance C&#39; per meter are assumed to be zero. The characteristic impedance Z0 can be derived from inductance and capacitance per length (L&#39; resp. C&#39;), i. e. Z0 = sqrt(L&#39;/C&#39;). The normalized length NL is equal to the length of the line divided by the wavelength corresponding to the frequency F, i. e. the transmission delay TD is the quotient of NL and F.</p>
<p><strong>References:</strong></p>
<dl><dt>Branin Jr., F. H.</dt>
<dd>Transient Analysis of Lossless Transmission Lines. Proceedings of the IEEE 55(1967), 2012 - 2013</dd>
<dt>Hoefer, E. E. E.; Nielinger, H.</dt>
<dd>SPICE : Analyseprogramm fuer elektronische Schaltungen. Springer-Verlag, Berlin, Heidelberg, New York, Tokyo, 1985. </dd>
</dl></html>", revisions="<html>
<dl>
<dt><em>1998</em></dt>
<dd>by Joachim Haase initially implemented</dd>
</dl>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255}),
          Rectangle(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,255},
            fillPattern=FillPattern.Solid,
            fillColor={255,255,255}),
          Line(points={{60,-100},{90,-100}}, color={0,0,255}),
          Line(points={{60,100},{90,100}}, color={0,0,255}),
          Line(points={{-60,100},{-90,100}}, color={0,0,255}),
          Line(points={{-60,-100},{-90,-100}}, color={0,0,255}),
          Text(
            extent={{-70,-10},{70,-50}},
            textString="TLine2"),
          Line(points={{-40,40},{-40,20}}),
          Line(points={{40,30},{-40,30}}),
          Line(points={{40,40},{40,20}}),
          Line(points={{-60,100},{-60,80}}, color={0,0,255}),
          Line(points={{60,100},{60,80}}, color={0,0,255}),
          Line(points={{60,-80},{60,-100}}, color={0,0,255}),
          Line(points={{-60,-80},{-60,-100}}, color={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
                                           Text(
              extent={{-100,100},{100,70}},
              textString="TLine2",
              lineColor={0,0,255})}));
  end TLine2;

  model TLine3
    "Lossless transmission line with characteristic impedance Z0 and frequency F"
    extends Modelica.Electrical.Analog.Interfaces.TwoPort;
    parameter SI.Resistance Z0(start=1) "Natural impedance";
    parameter SI.Frequency F(start=1) "Frequency";
  protected
    SI.Voltage er;
    SI.Voltage es;
    parameter SI.Time TD=1/F/4;
  equation
    assert(Z0 > 0, "Z0 has to be positive");
    assert(F > 0, "F has to be positive");
    i1 = (v1 - es)/Z0;
    i2 = (v2 - er)/Z0;
    es = 2*delay(v2, TD) - delay(er, TD);
    er = 2*delay(v1, TD) - delay(es, TD);
    annotation (defaultComponentName="line",
      Documentation(info="<html>
<p>Lossless transmission line with characteristic impedance Z0 and frequency F The lossless transmission line TLine3 is a two Port. Both port branches consist of a resistor with value of the characteristic impedance Z0 and a controlled voltage source that takes into consideration the transmission delay. For further details see Branin&#39;s article below. Resistance R&#39; and conductance C&#39; per meter are assumed to be zero. The characteristic impedance Z0 can be derived from inductance and capacitance per length (L&#39; resp. C&#39;), i. e. Z0 = sqrt(L&#39;/C&#39;). The length of the line is equal to a quarter of the wavelength corresponding to the frequency F, i. e. the transmission delay is the quotient of 4 and F. In this case, the characteristic impedance is called natural impedance.</p>
<p><strong>References:</strong></p>
<dl><dt>Branin Jr., F. H.</dt>
<dd>Transient Analysis of Lossless Transmission Lines. Proceedings of the IEEE 55(1967), 2012 - 2013</dd>
<dt>Hoefer, E. E. E.; Nielinger, H.</dt>
<dd>SPICE : Analyseprogramm fuer elektronische Schaltungen. Springer-Verlag, Berlin, Heidelberg, New York, Tokyo, 1985. </dd>
</dl></html>", revisions="<html>
<ul>
<li><em> 1998   </em>
       by Joachim Haase<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,255},
            fillPattern=FillPattern.Solid,
            fillColor={255,255,255}),
          Line(points={{60,-100},{90,-100}}, color={0,0,255}),
          Line(points={{60,100},{90,100}}, color={0,0,255}),
          Line(points={{-60,100},{-90,100}}, color={0,0,255}),
          Line(points={{-60,-100},{-90,-100}}, color={0,0,255}),
          Text(
            extent={{-70,-10},{70,-50}},
            textString="TLine3"),
          Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-40,40},{-40,20}}),
          Line(points={{40,30},{-40,30}}),
          Line(points={{40,40},{40,20}}),
          Line(points={{-60,100},{-60,80}}, color={0,0,255}),
          Line(points={{60,100},{60,80}}, color={0,0,255}),
          Line(points={{60,-80},{60,-100}}, color={0,0,255}),
          Line(points={{-60,-80},{-60,-100}}, color={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
                                           Text(
              extent={{-100,100},{100,70}},
              textString="TLine3",
              lineColor={0,0,255})}));
  end TLine3;

  annotation (Documentation(info="<html>
<p>This package contains lossy and lossless segmented transmission lines, and LC distributed line models. The line models do not yet possess a conditional heating port.</p>
</html>", revisions="<html>
<dl>
<dt>
<strong>Main Authors:</strong>
</dt>
<dd>
Christoph Clau&szlig;
    &lt;<a href=\"mailto:christoph@clauss-it.com\">christoph@clauss-it.com</a>&gt;<br>
    Joachim Haase;
    &lt;<a href=\"mailto:haase@eas.iis.fhg.de\">haase@eas.iis.fhg.de</a>&gt;<br>
    Andr&eacute; Schneider
    &lt;<a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden
</dd>
<dt>
<strong>Copyright:</strong>
</dt>
<dd>
Copyright &copy; 1998-2018, Modelica Association and Fraunhofer-Gesellschaft.<br>
<em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
under the terms of the <strong>Modelica license</strong>, see the license conditions
and the accompanying <strong>disclaimer</strong> in the documentation of package
Modelica in file \"Modelica/package.mo\".</em>
</dd>
</dl>
</html>"), Icon(graphics={
        Line(points={{-60,50},{-90,50}}),
        Rectangle(
          extent={{-60,60},{60,-60}}),
        Line(points={{-60,-50},{-90,-50}}),
        Line(points={{36,20},{-36,20}}),
        Line(points={{-36,40},{-36,0}}),
        Line(points={{36,40},{36,0}}),
        Line(points={{60,50},{90,50}}),
        Line(points={{60,-50},{90,-50}})}));
end Lines;
