within Modelica.Electrical.Analog.Basic;
model VariableCapacitor
  "Ideal linear electrical capacitor with variable capacitance"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  Modelica.Blocks.Interfaces.RealInput C(unit="F") annotation (Placement(
        transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  parameter SI.Capacitance Cmin=Modelica.Constants.eps
    "Lower bound for variable capacitance";
  SI.ElectricCharge Q;
  parameter SI.Voltage IC=0 "Initial Value";
  parameter Boolean UIC=false "Decision if initial value IC shall be used";
initial equation
  if UIC then
    v = IC;
  end if;
equation
  assert(C >= 0, "Capacitance C (= " + String(C) + ") has to be >= 0!");
  // protect solver from index change
  Q = noEvent(max(C, Cmin))*v;
  i = der(Q);
  annotation (defaultComponentName="capacitor",
    Documentation(info="<html>
<p>The linear capacitor connects the branch voltage <em>v</em> with the branch current <em>i</em> by
<br><em><strong>i = dQ/dt</strong></em> with <em><strong>Q = C * v</strong></em>.
<br>The capacitance <em>C</em> is given as input signal.
It is required that C &ge; 0, otherwise an assertion is raised. To avoid a variable index system,
C = Cmin, if 0 &le; C &lt; Cmin, where Cmin is a parameter with default value Modelica.Constants.eps.</p>
<p><br>Besides the Cmin parameter the capacitor model has got the two parameters IC and UIC that belong together. With the IC parameter the user can specify an initial value of the voltage over the capacitor, which is defined from positive pin p to negative pin n (v=p.v - n.v).</p>
<p><br>Hence the capacitor is charged at the beginning of the simulation. The other parameter UIC is of type Boolean. If UIC is true, the simulation tool uses</p>
<p><br>the IC value at the initial calculation by adding the equation v= IC. If UIC is false, the IC value can be used (but it does not need to!) to calculate the initial values in order to simplify the numerical algorithms of initial calculation.</p>
</html>",
        revisions="<html>
<ul>
<li><em>June 7, 2004   </em>
       by Christoph Clauss<br>changed, docu added<br>
       </li>
<li><em>April 30, 2004</em>
       by Anton Haumer<br>implemented.
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}),graphics={
        Line(points={{-90,0},{-6,0}}, color={0,0,255}),
        Line(points={{6,0},{90,0}}, color={0,0,255}),
        Line(points={{-6,28},{-6,-28}}, color={0,0,255}),
        Line(points={{6,28},{6,-28}}, color={0,0,255}),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255})}));
end VariableCapacitor;
