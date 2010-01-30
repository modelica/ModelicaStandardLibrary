within Modelica.Electrical.QuasiStationary.SinglePhase.Basic;
model Inductor "Singlephase linear inductor"
  extends Interfaces.OnePort;
  import Modelica.Constants.j;
  parameter Modelica.SIunits.Inductance L(start=1);
equation
  v = j*omega*L*i;
  annotation (Icon(graphics={
        Text(extent={{100,60},{-100,100}}, textString=
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
        Text(extent={{100,-80},{-100,-40}}, textString=
                                              "L=%L")}),
                                    Diagram(graphics),
    Documentation(info="<html>
 
<p>
The linear inductor connects the voltage <i><u>v</u></i> with the
current <i><u>i</u></i> by  <i><u>v</u> = j*&omega;*L*<u>i</u></i>.
The Inductance <i>L</i> is allowed to be positive, zero, or negative.
</p>
 
<h4>See also</h4>
<p>
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>Resistor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>Variable resistor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>Variable conductor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>Variable capacitor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
end Inductor;
