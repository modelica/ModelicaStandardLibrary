within Modelica.Electrical.QuasiStatic.Polyphase.Ideal;
model IdealClosingSwitch "Polyphase ideal closer"
  extends QuasiStatic.Polyphase.Interfaces.TwoPlug;
  parameter SI.Resistance Ron[m](final min=zeros(m), start=
        fill(1e-5, m)) "Closed switch resistance";
  parameter SI.Conductance Goff[m](final min=zeros(m), start=
        fill(1e-5, m)) "Opened switch conductance";
  extends Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort(
      final mh=m, final T=fill(293.15, m));
  Modelica.Blocks.Interfaces.BooleanInput control[m]
    "true => p--n connected, false => switch open" annotation (Placement(
        transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  QuasiStatic.SinglePhase.Ideal.IdealClosingSwitch idealClosingSwitch[m](
    final Ron=Ron,
    final Goff=Goff,
    each final useHeatPort=useHeatPort)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(control, idealClosingSwitch.control)
    annotation (Line(points={{0,120},{0,50},{0,12}}, color={255,0,255}));
  connect(idealClosingSwitch.heatPort, heatPort) annotation (Line(
      points={{0,-10},{0,-100}}, color={191,0,0}));
  connect(idealClosingSwitch.pin_p, plugToPins_p.pin_p) annotation (Line(
      points={{-10,0},{-68,0}}, color={85,170,255}));
  connect(idealClosingSwitch.pin_n, plugToPins_n.pin_n) annotation (Line(
      points={{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
  annotation (defaultComponentName="switch", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
                                   Line(points={{-90,0},{-44,0}}, color={85,170,255}),
          Ellipse(extent={{-44,4},{-36,-4}}, lineColor={85,170,
          255}),Line(points={{-37,2},{40,40}}, color={85,170,255}),
                                                      Line(points={{40,0},{
          90,0}}, color={85,170,255}),
        Text(
          extent={{-150,90},{150,50}},
              textString="%name",
          textColor={0,0,255}),
                Text(
              extent={{150,-80},{-150,-40}},
              textString="m=%m")}), Documentation(info="<html>
<p>
Contains m ideal closing switches (Modelica.Electrical.QuasiStatic.SinglePhase.Ideal.IdealClosingSwitch).
</p>
<p>
<strong>Use with care:</strong>
This switch is only intended to be used for structural changes, not fast switching sequences, due to the quasi-static formulation.
</p>
</html>"));
end IdealClosingSwitch;
