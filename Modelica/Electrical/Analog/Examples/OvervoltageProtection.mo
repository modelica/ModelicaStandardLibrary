within Modelica.Electrical.Analog.Examples;
model OvervoltageProtection

 Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(
   offset=0,
   V=10,
   freqHz=5) annotation (Placement(transformation(
       extent={{-10,-10},{10,10}},
       rotation=270,
       origin={-66,6})));
 Modelica.Electrical.Analog.Basic.Resistor Rv(R=20)
   annotation (Placement(transformation(extent={{-56,32},{-36,52}})));
 Modelica.Electrical.Analog.Basic.Resistor RL(R=2000) annotation (Placement(
       transformation(
       extent={{-10,-10},{10,10}},
       rotation=270,
       origin={26,4})));
 Modelica.Electrical.Analog.Semiconductors.ZDiode zDiode_1
                       annotation (Placement(transformation(
       extent={{-10,-10},{10,10}},
       rotation=90,
       origin={-20,-10})));
 Modelica.Electrical.Analog.Semiconductors.ZDiode zDiode_2
                       annotation (Placement(transformation(
       extent={{-10,-10},{10,10}},
       rotation=270,
       origin={-20,22})));
 Modelica.Electrical.Analog.Basic.Ground ground
   annotation (Placement(transformation(extent={{-30,-82},{-10,-62}})));
 Modelica.Electrical.Analog.Basic.Capacitor CL(C=1e-7) annotation (Placement(
       transformation(
       extent={{-10,-10},{10,10}},
       rotation=270,
       origin={62,4})));
equation
 connect(sineVoltage.p, Rv.p) annotation (Line(
     points={{-66,16},{-66,42},{-56,42}},
     color={0,0,255},
     smooth=Smooth.None));
 connect(Rv.n, zDiode_2.p)    annotation (Line(
     points={{-36,42},{-20,42},{-20,32}},
     color={0,0,255},
     smooth=Smooth.None));
 connect(RL.p, zDiode_2.p)    annotation (Line(
     points={{26,14},{26,42},{-20,42},{-20,32}},
     color={0,0,255},
     smooth=Smooth.None));
 connect(RL.n, zDiode_1.p)    annotation (Line(
     points={{26,-6},{26,-40},{-20,-40},{-20,-20}},
     color={0,0,255},
     smooth=Smooth.None));
 connect(zDiode_1.n, zDiode_2.n)       annotation (Line(
     points={{-20,0},{-20,6},{-20,12},{-20,12}},
     color={0,0,255},
     smooth=Smooth.None));
 connect(sineVoltage.n, zDiode_1.p)    annotation (Line(
     points={{-66,-4},{-66,-40},{-20,-40},{-20,-20}},
     color={0,0,255},
     smooth=Smooth.None));
 connect(ground.p, zDiode_1.p)    annotation (Line(
     points={{-20,-62},{-20,-20}},
     color={0,0,255},
     smooth=Smooth.None));
 connect(RL.p, CL.p) annotation (Line(
     points={{26,14},{62,14}},
     color={0,0,255},
     smooth=Smooth.None));
 connect(RL.n, CL.n) annotation (Line(
     points={{26,-6},{62,-6}},
     color={0,0,255},
     smooth=Smooth.None));
 annotation (Diagram(coordinateSystem(
         preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics),
   experiment(StopTime=0.4),
   Documentation(info="<html>
This example is a simple circuit for overvoltage protection. If the voltage zDiode_1.n.v is too high, the Diode zDiode_2 breaks through and the voltage gets down.<br>
The simulation end time should be set to 0.4. To get the typical behaviour please plot sineVoltage.p.v, RL.p.v, zDiode_2.n.v and zDiode_1.n.i.
</html>",revisions="<html>
<ul>
<li><i>February 02, 2009</i>
       by Kristin Majetta<br>
       documentation added</li>
<li><i> January 08, 2009   </i>
        by Matthias Franke <br>initially implemented
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-100,-100},{80,50}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Polygon(
          points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Polygon(
          points={{100,70},{100,-80},{80,-100},{80,50},{100,70}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Text(
          extent={{-96,3},{77,-49}},
          lineColor={0,0,255},
          textString="Example"),
        Text(
          extent={{-120,132},{120,73}},
          lineColor={255,0,0},
          textString="%name")}));
end OvervoltageProtection;
