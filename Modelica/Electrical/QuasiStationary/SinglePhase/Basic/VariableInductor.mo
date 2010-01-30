within Modelica.Electrical.QuasiStationary.SinglePhase.Basic;
model VariableInductor "Singlephase variable inductor"
  extends Interfaces.OnePort;
  import Modelica.Constants.j;
  Modelica.Blocks.Interfaces.RealInput L 
    annotation (Placement(transformation(
        origin={0,108},
        extent={{-20,-20},{20,20}},
        rotation=270)));
equation
  v = j*omega*L*i;
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
        Line(points={{0,90},{0,8}}, color={0,0,255})}),
      Diagram(graphics),
    Documentation(info="<html>

<p>
The linear inductor connects the branch voltage <i><u>v</u></i> with the
branch current <i><u>i</u></i> by <i><u>v</u> = j*&omega;*L*<u>i</u></i>. The inductance <i>L</i> is given as input signal.
</p>

<h4>Note</h4>
<p>
The abstraction of a variable inductor at quasi stationary operation assumes:<br>
<img src=\"../Images/Electrical/QuasiStationary/SinglePhase/Basic/dl_dt.png\">
</p>

<h4>See also</h4>
<p>
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>Resistor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>Variable resistor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>Variable conductor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>Variable capacitor</a>
</p>
</html>"));
end VariableInductor;
