within Modelica.Electrical.Analog.Examples.OpAmps.OpAmpCircuits;
model Feedback "Subtracting operational amplifier circuit"
  extends PartialOpAmp;
  SI.Voltage v1_2=p1_2.v - n1.v "Voltage drop of port 1_2 (= p1_2.v - n1.v)";
  SI.Current i1_2=p1_2.i "Current flowing from pos. to neg. pin of port 1_2";
  parameter Real k(final min=0)=1 "Desired amplification";
  parameter SI.Resistance R1=1000 "Resistance at inputs of OpAmp";
  parameter SI.Resistance R3=R1/k "Calculated resistance to reach desired amplification k";
  Basic.Resistor                            r1(final R=R1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        origin={-40,70})));
  Basic.Resistor                            r2(final R=R1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-40,-70})));
  Interfaces.PositivePin p1_2 "Positive electrical pin 1.2" annotation (
      Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  Basic.Resistor                            r3(final R=R3)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        origin={20,70})));
  Basic.Resistor                            r4(final R=R3)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={20,-70})));
equation
  connect(n1, n2)
    annotation (Line(points={{-100,-100},{100,-100}}, color={0,0,255}));
  connect(p1, r1.p) annotation (Line(points={{-100,100},{-80,100},{-80,70},{-50,
          70}}, color={0,0,255}));
  connect(r1.n, opAmp.in_n)
    annotation (Line(points={{-30,70},{-10,70},{-10,6}}, color={0,0,255}));
  connect(r1.n, r3.n)
    annotation (Line(points={{-30,70},{10,70}}, color={0,0,255}));
  connect(opAmp.out, r3.p)
    annotation (Line(points={{10,0},{30,0},{30,70}}, color={0,0,255}));
  connect(opAmp.out, p2) annotation (Line(points={{10,0},{80,0},{80,100},{100,100}},
        color={0,0,255}));
  connect(p1_2, r2.p) annotation (Line(points={{-100,0},{-80,0},{-80,-70},{-50,-70}},
        color={0,0,255}));
  connect(r2.n, opAmp.in_p)
    annotation (Line(points={{-30,-70},{-10,-70},{-10,-6}}, color={0,0,255}));
  connect(opAmp.in_p, r4.p)
    annotation (Line(points={{-10,-6},{-10,-70},{10,-70}}, color={0,0,255}));
  connect(n1, r4.n) annotation (Line(points={{-100,-100},{30,-100},{30,-70}},
        color={0,0,255}));
  annotation (Documentation(info="<html>
<p>Inverting subtracter = feedback, based on the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a> model.</p>
<p><code>vOut = -k*(vIn1 - vIn2)</code></p>
</html>"), Icon(graphics={Text(
          extent={{-40,40},{40,-40}},
          textColor={0,0,255},
          textString="-")}));
end Feedback;
