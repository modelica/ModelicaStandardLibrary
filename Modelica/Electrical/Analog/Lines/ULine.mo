within Modelica.Electrical.Analog.Lines;
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
    "Temperature coefficient of resistance (R_actual = R*(1 + alpha*(heatPort.T - T_ref))";
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
protected
   parameter SI.Resistance rm[N + 1]=
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
<br>For all capacitors and resistors the values of each segment are the same except for the first and last resistor, that only has the half of the above calculated value.
</p>
<p>The user has the possibility to enable a conditional heatport. If so, the ULine can be connected to a thermal network. When the parameter alpha is set to a value greater than zero, the ULine becomes temperature sensitive due to their resistors which resistances are calculated by <code>R_actual= R*(1 + alpha*(heatPort.T - T_ref))</code>.</p>
<p>Note, this is different compared with the lumped line model of SPICE.</p>
<p><strong>References:</strong> [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Johnson1991</a>]</p>
</html>",    revisions="<html>
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
          textColor={0,0,255}),
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
