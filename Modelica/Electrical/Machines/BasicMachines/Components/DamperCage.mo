within Modelica.Electrical.Machines.BasicMachines.Components;
model DamperCage "Squirrel Cage"
  parameter SI.Inductance Lrsigmad
    "Stray inductance in d-axis per phase translated to stator";
  parameter SI.Inductance Lrsigmaq
    "Stray inductance in q-axis per phase translated to stator";
  parameter SI.Resistance Rrd
    "Resistance in d-axis per phase translated to stator at T_ref";
  parameter SI.Resistance Rrq
    "Resistance in q-axis per phase translated to stator at T_ref";
  parameter SI.Temperature T_ref=293.15
    "Reference temperature of both resistances in d- and q-axis";
  parameter SI.LinearTemperatureCoefficient alpha=0
    "Temperature coefficient of both resistances in d- and q-axis at T_ref";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
  SI.Resistance Rrd_actual
    "Actual resistance = Rrd*(1 + alpha*(T_heatPort - T_ref))";
  SI.Resistance Rrq_actual
    "Actual resistance = Rrq*(1 + alpha*(T_heatPort - T_ref))";
  Modelica.Blocks.Interfaces.RealOutput i[2](
    each final quantity="ElectricCurrent",
    each final unit="A") = -spacePhasor_r.i_ "Currents out from damper";
  Modelica.Blocks.Interfaces.RealOutput lossPower(
    final quantity="Power",
    final unit="W") = LossPower "Damper losses";
  Machines.Interfaces.SpacePhasor spacePhasor_r
    annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
equation
  assert((1 + alpha*(T_heatPort - T_ref)) >= Modelica.Constants.eps,
    "Temperature outside scope of model!");
  Rrd_actual = Rrd*(1 + alpha*(T_heatPort - T_ref));
  Rrq_actual = Rrq*(1 + alpha*(T_heatPort - T_ref));
  spacePhasor_r.v_[1] = Rrd_actual*spacePhasor_r.i_[1] + Lrsigmad*der(
    spacePhasor_r.i_[1]);
  spacePhasor_r.v_[2] = Rrq_actual*spacePhasor_r.i_[2] + Lrsigmaq*der(
    spacePhasor_r.i_[2]);
  2/3*LossPower = Rrd_actual*spacePhasor_r.i_[1]*spacePhasor_r.i_[1] +
    Rrq_actual*spacePhasor_r.i_[2]*spacePhasor_r.i_[2];
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{60,60},{100,60}}, color={0,0,255}),
        Line(points={{70,40},{90,40}}, color={0,0,255}),
        Line(points={{66,50},{94,50}}, color={0,0,255}),
        Line(points={{-80,0},{-80,-20}}, color={0,0,255}),
        Rectangle(extent={{20,90},{60,70}}, lineColor={0,0,255}),
        Line(points={{60,80},{80,80},{80,60}}, color={0,0,255}),
        Line(points={{-100,90},{-100,80},{-60,80}}, color={0,0,255}),
        Line(points={{-100,90},{-100,80},{-80,80},{-80,60}}, color={0,0,255}),
        Line(points={{0,80},{20,80}}, color={0,0,255}),
        Rectangle(extent={{-90,-20},{-70,-60}}, lineColor={0,0,255}),
        Line(points={{-100,-80},{-60,-80}}, color={0,0,255}),
        Line(points={{-90,-100},{-70,-100}}, color={0,0,255}),
        Line(points={{-94,-90},{-66,-90}}, color={0,0,255}),
        Line(points={{-80,-60},{-80,-80}}, color={0,0,255}),
        Line(
          points={{-60,80},{-59,85},{-54,90},{-46,90},{-41,85},{-40,80}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{-40,80},{-39,85},{-34,90},{-26,90},{-21,85},{-20,80}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{-20,80},{-19,85},{-14,90},{-6,90},{-1,85},{0,80}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-85,50},
          rotation=90),
        Line(
          points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-85,30},
          rotation=90),
        Line(
          points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-85,10},
          rotation=90),                                     Text(
                extent={{-150,-148},{150,-110}},
                textColor={0,0,255},
                textString="%name")}),
                          Documentation(info="<html>
<p>
Model of an asymmetrical damper cage in two axis.
</p>
<p>
The damper cage has an optional (conditional) HeatPort,
which can be enabled or disabled by the Boolean parameter useHeatPort.
Temperatures of both axis are the same, both losses are added.
Material properties alpha can be set differently for both d- and q-axis,
although reference temperature for both resistances is the same.
</p>
</html>"));
end DamperCage;
