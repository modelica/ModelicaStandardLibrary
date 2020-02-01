within Modelica.Electrical.Polyphase.Ideal;
model CloserWithArc "Polyphase closer with arc"
  extends Interfaces.TwoPlug;
  parameter SI.Resistance Ron[m](final min=zeros(m), start=
        fill(1e-5, m)) "Closed switch resistance";
  parameter SI.Conductance Goff[m](final min=zeros(m), start=
        fill(1e-5, m)) "Opened switch conductance";
  parameter SI.Voltage V0[m](start=fill(30, m))
    "Initial arc voltage";
  parameter SI.VoltageSlope dVdt[m](start=fill(10E3, m))
    "Arc voltage slope";
  parameter SI.Voltage Vmax[m](start=fill(60, m))
    "Max. arc voltage";
  extends Polyphase.Interfaces.ConditionalHeatPort(final mh=m, final T=fill(
        293.15, m));
  Modelica.Blocks.Interfaces.BooleanInput control[m]
    "true => switch open, false => p--n connected" annotation (Placement(
        transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.Electrical.Analog.Ideal.CloserWithArc closerWithArc[m](
    final Ron=Ron,
    final Goff=Goff,
    final V0=V0,
    final dVdt=dVdt,
    final Vmax=Vmax,
    each final useHeatPort=useHeatPort) annotation (Placement(
        transformation(extent={{-10,-10},{10,10}})));
equation
  connect(plug_p.pin, closerWithArc.p)
    annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
  connect(closerWithArc.n, plug_n.pin)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  connect(control, closerWithArc.control)
    annotation (Line(points={{0,120},{0,42},{0,11}}, color={255,0,255}));
  connect(closerWithArc.heatPort, heatPort) annotation (Line(
      points={{0,-10},{0,-100}}, color={191,0,0}));
  annotation (defaultComponentName="switch", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Line(points={{-90,0},{-44,0}}, color={0,0,255}),
        Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}),
        Line(points={{-37,2},{40,40}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Line(points={{40,40},{32,16},{48,24},{40,0}}, color={255,0,0}),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-80},{150,-40}},
          textString="m=%m")}),
      Documentation(info="<html>
<p>Contains m closing switches with arc (Modelica.Electrical.Analog.Ideal.CloserWithArc).</p>
</html>"));
end CloserWithArc;
