within Modelica.Electrical.QuasiStationary.MultiPhase.Basic;
model Capacitor "Multiphase linear capacitor"
  extends Interfaces.TwoPlug;
  parameter Modelica.SIunits.Capacitance C[m](start=fill(1,m));
  SinglePhase.Basic.Capacitor capacitor[m](final C=C) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
equation
  connect(plugToPins_p.pin_p, capacitor.pin_p) 
    annotation (Line(points={{-68,6.10623e-016},{-53.5,6.10623e-016},{-53.5,
          1.22125e-015},{-39,1.22125e-015},{-39,6.10623e-016},{-10,6.10623e-016}},
        color={85,170,255}));
  connect(capacitor.pin_n, plugToPins_n.pin_n) 
    annotation (Line(points={{10,6.10623e-016},{39,6.10623e-016},{39,
          7.44522e-016},{68,7.44522e-016}}, color={85,170,255}));
  annotation (Icon(graphics={
        Text(extent={{100,60},{-100,100}}, textString=
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
        Text(
          extent={{100,-80},{-100,-40}},
          lineColor={0,0,0},
          textString=
               "m=%m")}),
      Diagram(graphics),
  Documentation(info="<html>
<p>
The linear capacitor connects the complex currents <i><u>i</u></i> with the complex
voltages <i><u>v</u></i> by <i><u>v</u>*j*&omega;*C = <u>i</u></i>, 
using <i>m</i> <a href=Modelica://Modelica_QuasiStationary.SinglePhase.Basic.Capacitor>single phase Capacitors</a>.
</p>

<h4>See also</h4>
<p>
<a href=Modelica://Modelica_QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>, 
<a href=Modelica://Modelica_QuasiStationary.MultiPhase.Basic.Resistor>Resistor</a>, 
<a href=Modelica://Modelica_QuasiStationary.MultiPhase.Basic.Conductor>Conductor</a>, 
<a href=Modelica://Modelica_QuasiStationary.MultiPhase.Basic.Inductor>Inductor</a>, 
<a href=Modelica://Modelica_QuasiStationary.MultiPhase.Basic.VariableResistor>Variable resistor</a>, 
<a href=Modelica://Modelica_QuasiStationary.MultiPhase.Basic.VariableConductor>Variable conductor</a>, 
<a href=Modelica://Modelica_QuasiStationary.MultiPhase.Basic.VariableCapacitor>Variable capacitor</a>, 
<a href=Modelica://Modelica_QuasiStationary.MultiPhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
end Capacitor;
