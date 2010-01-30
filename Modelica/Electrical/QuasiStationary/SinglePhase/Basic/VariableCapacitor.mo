within Modelica.Electrical.QuasiStationary.SinglePhase.Basic;
model VariableCapacitor "Singlephase variable capacitor"
  extends Interfaces.OnePort;
  import Modelica.Constants.j;
  Modelica.Blocks.Interfaces.RealInput C 
    annotation (Placement(transformation(
        origin={0,110},
        extent={{-20,-20},{20,20}},
        rotation=270)));
equation
  i = j*omega*C*v;
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
        Line(points={{0,90},{0,30}}, color={0,0,255})}),
      Diagram(graphics),
    Documentation(info="<html>

<p>
The linear capacitor connects the voltage <i><u>v</u></i> with the
current <i><u>i</u></i> by <i><u>i</u> = j*&omega;*C*<u>v</u></i>.
The capacitance <i>C</i> is given as input signal.
</p>

<h4>Note</h4>
<p>
The abstraction of a variable capacitor at quasi stationary operation assumes:<br>
<img src=\"../Images/Electrical/QuasiStationary/SinglePhase/Basic/dc_dt.png\">.
</p>

<h4>See also</h4>
<p>
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>Resistor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>Variable resistor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>Variable conductor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
end VariableCapacitor;
