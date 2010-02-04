within Modelica.Electrical.QuasiStationary.MultiPhase.Basic;
model VariableCapacitor "Multiphase variable capacitor"
  extends Interfaces.TwoPlug;
  Modelica.Blocks.Interfaces.RealInput C[m]
    annotation (Placement(transformation(
        origin={0,110},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  SinglePhase.Basic.VariableCapacitor variableCapacitor[m]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
equation
  connect(variableCapacitor.pin_p, plugToPins_p.pin_p)
    annotation (Line(points={{-10,0},{-24.5,0},{-24.5,1.22125e-015},{-39,1.22125e-015},
          {-39,0},{-68,0}},
        color={85,170,255}));
  connect(variableCapacitor.pin_n, plugToPins_n.pin_n)
    annotation (Line(points={{10,0},{39,0},{39,2.44929e-016},{68,2.44929e-016}},
                                            color={85,170,255}));
  connect(C, variableCapacitor.C) annotation (Line(
      points={{0,110},{0,61},{0,61},{0,11}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Icon(graphics={
        Text(extent={{100,-80},{-100,-40}}, textString=
                                               "%name"),
        Line(
          points={{-14,28},{-14,-28}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{14,28},{14,-28}},
          color={0,0,255},
          thickness=0.5),
        Line(points={{-90,0},{-14,0}}),
        Line(points={{14,0},{90,0}}),
        Line(points={{0,90},{0,30}}, color={0,0,255}),
        Text(
          extent={{100,40},{-100,80}},
          lineColor={0,0,0},
          textString=
               "m=%m")}),
      Diagram(graphics),
  Documentation(info="<html>
<p>
The linear capacitor connects the complex currents <i><u>i</u></i> with the complex
voltages <i><u>v</u></i> by <i><u>v</u>*j*&omega;*C = <u>i</u></i>,
using <i>m</i> <a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>single phase variable Capacitors</a>.
The capacitances <i>C</i> are given as <i>m</i> input signals.
</p>

<h4>See also</h4>
<p>
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>VariableCapacitor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor>Resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor>Conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor>Capacitor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor>Inductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableResistor>Variable resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor>Variable conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
end VariableCapacitor;
