within Modelica.Electrical.Analog.Examples.OpAmps.OpAmpCircuits;
model Der "Differentiating operational amplifier circuit"
  extends PartialOpAmp;
  import Modelica.Constants.pi;
  parameter Real k(final min=0)=1 "Desired amplification at frequency f";
  parameter SI.Frequency f "Frequency";
  parameter SI.Resistance R=1000 "Resistance at output of OpAmp";
  parameter SI.Capacitance C=k/(2*pi*f*R) "Calculated capacitance to reach desired amplification k";
  SI.Voltage v(start=0)=c.v "Capacitor voltage = state";
  Basic.Capacitor                            c(final C=C)
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Basic.Resistor                            r(final R=R)
    annotation (Placement(transformation(extent={{30,20},{10,40}})));
equation
  connect(n1, n2)
    annotation (Line(points={{-100,-100},{100,-100}}, color={0,0,255}));
  connect(opAmp.out, p2) annotation (Line(points={{10,0},{80,0},{80,100},{100,100}},
        color={0,0,255}));
  connect(c.n, opAmp.in_n)
    annotation (Line(points={{-30,30},{-10,30},{-10,6}}, color={0,0,255}));
  connect(opAmp.in_n, r.n)
    annotation (Line(points={{-10,6},{-10,30},{10,30}}, color={0,0,255}));
  connect(opAmp.out, r.p)
    annotation (Line(points={{10,0},{30,0},{30,30}}, color={0,0,255}));
  connect(c.p, p1) annotation (Line(points={{-50,30},{-80,30},{-80,100},{
          -100,100}}, color={0,0,255}));
  connect(n1, opAmp.in_p) annotation (Line(points={{-100,-100},{-10,-100},{
          -10,-6}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>Inverting differentiator = der, based on the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a> model.</p>
<p><code>vOut = -k*der(vIn)</code></p>
</html>"), Icon(graphics={Text(
          extent={{-60,40},{20,-40}},
          textColor={0,0,255},
          textString="der")}));
end Der;
