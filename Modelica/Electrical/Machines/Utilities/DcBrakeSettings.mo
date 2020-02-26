within Modelica.Electrical.Machines.Utilities;
record DcBrakeSettings "Setting for DC current braking"
  parameter SI.Current INominal=100 "Nominal RMS current per phase";
  parameter String layout="Y3" "Braking connection layout"
    annotation (choices(
      choice="Y3" "Y 3 phases",
      choice="Y2" "Y 2 phases",
      choice="D2" "D 2 phases",
      choice="D3" "D 3 phases"));
  parameter String terminalConnection=
    if layout=="Y3" or layout=="Y2" then "Y" else "D" "Terminal connection"
    annotation(Dialog(group="Results", enable=false));
  parameter Boolean connect3=
    layout=="Y3" or layout=="D3" "Connect 3rd terminal"
    annotation(Dialog(group="Results", enable=false));
  parameter SI.Current Idc=
    if     layout=="Y3" then INominal*sqrt(2)
    elseif layout=="Y2" then INominal*sqrt(3/2)
    elseif layout=="D2" then INominal*3/sqrt(2)
    else                     INominal*sqrt(6)
    "DC braking current" annotation(Dialog(group="Results", enable=false));
  parameter SI.Current is[3]=
    if     layout=="Y3" then Idc*{1,-1/2,-1/2}
    elseif layout=="Y2" then Idc*{1,-1,0}
    elseif layout=="D2" then Idc*{2/3,-1/3,-1/3}
    else                     Idc*{1/2,-1/2,0}
    "Phase currents" annotation(Dialog(group="Results", enable=false));
   annotation (defaultComponentPrefixes="parameter",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-50,40},{0,10}},
          textColor={0,0,0},
          lineThickness=0.5,
          textString="Y3"),
        Text(
          extent={{-50,-60},{0,-90}},
          textColor={0,0,0},
          lineThickness=0.5,
          textString="Y2"),
        Text(
          extent={{0,40},{50,10}},
          textColor={0,0,0},
          lineThickness=0.5,
          textString="D2"),
        Text(
          extent={{0,-60},{50,-90}},
          textColor={0,0,0},
          lineThickness=0.5,
          textString="D3"),             Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        textColor={0,0,255}),
        Text(
          extent={{-150,-150},{150,-110}},
          textColor={0,0,0},
          textString="%layout"),
        Line(
          points={{80,80},{80,20}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{0,30},{0,-30}},
          color={0,0,0},
          origin={54,65},
          rotation=120),
        Line(
          points={{0,30},{0,-30}},
          color={0,0,0},
          origin={54,35},
          rotation=240),
        Line(
          points={{80,80},{98,80}},
          color={238,46,47},
          thickness=0.5),
        Line(
          points={{80,20},{98,20}},
          color={238,46,47},
          thickness=0.5),
        Line(
          points={{0,30},{0,-30}},
          color={0,0,0},
          origin={54,-35},
          rotation=120,
          pattern=LinePattern.Dash),
        Line(
          points={{0,30},{0,-30}},
          color={0,0,0},
          thickness=0.5,
          origin={54,-65},
          rotation=240),
        Line(
          points={{80,-20},{80,-80}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{80,-80},{98,-80}},
          color={238,46,47},
          thickness=0.5),
        Line(
          points={{80,-20},{98,-20}},
          color={238,46,47},
          thickness=0.5),
        Line(
          points={{28,-50},{28,-20},{80,-20}},
          color={238,46,47},
          thickness=0.5),
        Line(
          points={{-50,60},{-50,20}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{0,20},{0,-20}},
          color={0,0,0},
          origin={-33,70},
          rotation=120),
        Line(
          points={{0,20},{0,-20}},
          color={0,0,0},
          origin={-67,70},
          rotation=240),
        Line(
          points={{-84,80},{-16,80}},
          color={238,46,47},
          thickness=0.5),
        Line(
          points={{-98,80},{-84,80}},
          color={238,46,47},
          thickness=0.5),
        Line(
          points={{-98,20},{-50,20}},
          color={238,46,47},
          thickness=0.5),
        Line(
          points={{0,20},{0,-20}},
          color={0,0,0},
          thickness=0.5,
          origin={-67,-30},
          rotation=240),
        Line(
          points={{-50,-40},{-50,-80}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{0,20},{0,-20}},
          color={0,0,0},
          origin={-33,-30},
          rotation=120,
          pattern=LinePattern.Dash),
        Line(
          points={{-98,-20},{-84,-20}},
          color={238,46,47},
          thickness=0.5),
        Line(
          points={{-98,-80},{-50,-80}},
          color={238,46,47},
          thickness=0.5),
        Ellipse(
          extent={{-100,82},{-96,78}},
          lineColor={238,46,47},
          lineThickness=0.5),
        Ellipse(
          extent={{-100,22},{-96,18}},
          lineColor={238,46,47},
          lineThickness=0.5),
        Ellipse(
          extent={{-100,-18},{-96,-22}},
          lineColor={238,46,47},
          lineThickness=0.5),
        Ellipse(
          extent={{-100,-78},{-96,-82}},
          lineColor={238,46,47},
          lineThickness=0.5),
        Ellipse(
          extent={{96,-78},{100,-82}},
          lineColor={238,46,47},
          lineThickness=0.5),
        Ellipse(
          extent={{96,-18},{100,-22}},
          lineColor={238,46,47},
          lineThickness=0.5),
        Ellipse(
          extent={{96,22},{100,18}},
          lineColor={238,46,47},
          lineThickness=0.5),
        Ellipse(
          extent={{96,82},{100,78}},
          lineColor={238,46,47},
          lineThickness=0.5)}),
    Documentation(info="<html>
<p>
Lets the user choose the layout, and determines the necessary DC current for DC current braking of an induction machine.
</p>
<p>
The icon shows the four layout variants.
Phases with half the current are depicted with half the line thickness,
phases with zero current are depicted with dashed line.
</p>
</html>"));
end DcBrakeSettings;
