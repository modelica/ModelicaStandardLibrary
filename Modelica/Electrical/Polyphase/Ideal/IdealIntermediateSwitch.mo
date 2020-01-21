within Modelica.Electrical.Polyphase.Ideal;
model IdealIntermediateSwitch "Polyphase ideal intermediate switch"
  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Resistance Ron[m](final min=zeros(m), start=
        fill(1e-5, m)) "Closed switch resistance";
  parameter SI.Conductance Goff[m](final min=zeros(m), start=
        fill(1e-5, m)) "Opened switch conductance";
  extends Polyphase.Interfaces.ConditionalHeatPort(final mh=m, final T=fill(
        293.15, m));
  Modelica.Blocks.Interfaces.BooleanInput control[m]
    "true => p1--n2, p2--n1 connected, otherwise p1--n1, p2--n2 connected"
    annotation (Placement(transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Interfaces.PositivePlug plug_p1(final m=m) annotation (Placement(
        transformation(extent={{-110,30},{-90,50}}), iconTransformation(extent={{-110,30},{-90,50}})));
  Interfaces.PositivePlug plug_p2(final m=m) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePlug plug_n2(final m=m) annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Interfaces.NegativePlug plug_n1(final m=m) annotation (Placement(
        transformation(extent={{90,30},{110,50}}), iconTransformation(extent={{90,30},{110,50}})));
  Modelica.Electrical.Analog.Ideal.IdealIntermediateSwitch idealIntermediateSwitch[m](
    final Ron=Ron,
    final Goff=Goff,
    each final useHeatPort=useHeatPort) annotation (Placement(
        transformation(extent={{-10,-10},{10,10}})));
equation
  connect(plug_p2.pin, idealIntermediateSwitch.p2)
    annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
  connect(idealIntermediateSwitch.n2, plug_n2.pin)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  connect(idealIntermediateSwitch.p1, plug_p1.pin) annotation (Line(points={{-10,4},{-10,40},{-100,40}}, color={0,0,255}));
  connect(idealIntermediateSwitch.n1, plug_n1.pin)
    annotation (Line(points={{10,4},{10,40},{100,40}}, color={0,0,255}));
  connect(control, idealIntermediateSwitch.control)
    annotation (Line(points={{0,120},{0,64},{0,12}}, color={255,0,255}));
  connect(idealIntermediateSwitch.heatPort, heatPort) annotation (Line(
      points={{0,-10},{0,-100}}, color={191,0,0}));
  annotation (defaultComponentName="switch", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Ellipse(extent={{-4,24},{4,16}}, lineColor={0,0,255}),
        Line(points={{-90,0},{-40,0}}, color={0,0,255}),
        Line(points={{-90,40},{-40,40}}, color={0,0,255}),
        Line(points={{-40,0},{40,40}}, color={0,0,255}),
        Line(points={{-40,40},{40,0}}, color={0,0,255}),
        Line(points={{40,40},{90,40}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-80},{150,-40}},
          textString="m=%m")}), Documentation(info=
         "<html>
<p>
Contains m ideal intermediate switches (Modelica.Electrical.Analog.Ideal.IdealIntermediateSwitch).
</p>
</html>"));
end IdealIntermediateSwitch;
