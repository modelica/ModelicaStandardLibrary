within Modelica.Electrical.Machines.BasicMachines.Components;
model InductorDC
  "Ideal linear electrical inductor for electrical DC machines"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter SI.Inductance L(start=1) "Inductance";
  parameter Boolean quasiStatic(start=false)
    "No electrical transients if true" annotation (Evaluate=true);
equation
  v = if quasiStatic then 0 else L*der(i);
  annotation (defaultComponentName="inductor",
    Documentation(info="<html>
<p>The linear inductor connects the branch voltage <em>v</em> with the branch current <em>i</em> by <em>v = L * di/dt</em>.
If <code>quasiStatic == false</code>, the electrical transients are neglected, i.e., the voltage drop is zero.</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Ellipse(extent={{-60,-15},{-30,15}},
          lineColor={0,0,255}),Ellipse(extent={{-30,-15},{0,15}},
          lineColor={0,0,255}),Ellipse(extent={{0,-15},{30,15}},
          lineColor={0,0,255}),Ellipse(extent={{30,-15},{60,15}},
          lineColor={0,0,255}),Rectangle(
                extent={{-60,-30},{60,0}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),Line(points={{60,0},{90,0}},
          color={0,0,255}),Line(points={{-90,0},{-60,0}}, color={0,0,255}),
          Text( extent={{-150,-80},{150,-40}},
                textString="L=%L"),Text(
                extent={{-150,50},{150,90}},
                textString="%name",
                textColor={0,0,255}),Rectangle(
                visible=quasiStatic,
                extent={{-70,30},{70,-30}},
                lineColor={0,0,255},
                fillColor={85,170,255},
                fillPattern=FillPattern.Solid)}));
end InductorDC;
