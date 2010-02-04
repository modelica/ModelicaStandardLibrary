within Modelica.Electrical.QuasiStationary.MultiPhase.Basic;
model VariableInductor "Multiphase variable inductor"
  extends Interfaces.TwoPlug;
  Modelica.Blocks.Interfaces.RealInput L[m]
    annotation (Placement(transformation(
        origin={0,110},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  SinglePhase.Basic.VariableInductor variableInductor[m]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
equation
  connect(variableInductor.pin_p, plugToPins_p.pin_p)
    annotation (Line(points={{-10,0},{-24.5,0},{-24.5,1.22125e-015},{-39,1.22125e-015},
          {-39,0},{-68,0}},
        color={85,170,255}));
  connect(variableInductor.pin_n, plugToPins_n.pin_n)
    annotation (Line(points={{10,0},{39,0},{39,2.44929e-016},{68,2.44929e-016}},
                                            color={85,170,255}));
  connect(variableInductor.L, L)
    annotation (Line(points={{0,10.8},{0,35.6},{1.77636e-015,35.6},{1.77636e-015,
          60.4},{0,60.4},{0,110}},
                              color={0,0,127}));
  annotation (Icon(graphics={
        Text(extent={{100,-80},{-100,-40}}, textString=
                                               "%name"),
        Ellipse(extent={{-60,-15},{-30,15}}),
        Ellipse(extent={{-30,-15},{0,15}}),
        Ellipse(extent={{0,-15},{30,15}}),
        Ellipse(extent={{30,-15},{60,15}}),
        Rectangle(
          extent={{-60,-30},{60,0}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{60,0},{90,0}}),
        Line(points={{-90,0},{-60,0}}),
        Line(points={{0,90},{0,8}}, color={0,0,255}),
        Text(
          extent={{100,40},{-100,80}},
          lineColor={0,0,0},
          textString=
               "m=%m")}),
      Diagram(graphics),
  Documentation(info="<html>
<p>
The linear inductor connects the complex voltages <i><u>v</u></i> with the complex
currents <i><u>i</u></i> by <i><u>i</u>*j*&omega;*L = <u>v</u></i>,
using <i>m</i> <a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>single phase variable Inductors</a>.
The inductances <i>L</i> are given as <i>m</i> input signals.
</p>

<h4>See also</h4>
<p>
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor>Resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor>Conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor>Capacitor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor>Inductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableResistor>Variable resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor>Variable conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor>Variable capacitor</a>
</p>
</html>"));
end VariableInductor;
