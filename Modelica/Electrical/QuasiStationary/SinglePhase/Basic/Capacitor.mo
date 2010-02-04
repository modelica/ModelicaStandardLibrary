within Modelica.Electrical.QuasiStationary.SinglePhase.Basic;
model Capacitor "Singlephase linear capacitor"
  extends Interfaces.OnePort;
  import Modelica.Constants.j;
  parameter Modelica.SIunits.Capacitance C(start=1);
equation
  i = j*omega*C*v;
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
        Text(extent={{100,-80},{-100,-40}}, textString=
                                              "C=%C")}),
                                  Diagram(graphics),
    Documentation(info="<html>

<p>
The linear capacitor connects the voltage <i><u>v</u></i> with the
current <i><u>i</u></i> by <i><u>i</u> = j*&omega;*C*<u>v</u></i>.
The capacitance <i>C</i> is allowed to be positive, zero, or negative.
</p>

<h4>See also</h4>
<p>
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>Resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>Variable resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>Variable conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>Variable capacitor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
end Capacitor;
