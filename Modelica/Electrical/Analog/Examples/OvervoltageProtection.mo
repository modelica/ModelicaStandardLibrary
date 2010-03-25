within Modelica.Electrical.Analog.Examples;
model OvervoltageProtection "Example for Zener diodes"
  extends Modelica.Icons.Example;

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
 Modelica.Electrical.Analog.Basic.Ground ground
   annotation (Placement(transformation(extent={{-30,-82},{-10,-62}})));
 Modelica.Electrical.Analog.Basic.Capacitor CL(C=1e-7) annotation (Placement(
       transformation(
       extent={{-10,-10},{10,10}},
       rotation=270,
       origin={62,4})));
  Semiconductors.ZDiode zDiode annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-20})));
  Semiconductors.ZDiode zDiode1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,22})));
equation
 connect(sineVoltage.p, Rv.p) annotation (Line(
     points={{-66,16},{-66,42},{-56,42}},
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
  connect(sineVoltage.n, zDiode.p) annotation (Line(
      points={{-66,-4},{-66,-30},{-20,-30}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(zDiode.p, ground.p) annotation (Line(
      points={{-20,-30},{-20,-62}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(zDiode.p, RL.n) annotation (Line(
      points={{-20,-30},{26,-30},{26,-6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(zDiode1.p, Rv.n) annotation (Line(
      points={{-20,32},{-20,42},{-36,42}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(RL.p, Rv.n) annotation (Line(
      points={{26,14},{26,42},{-36,42}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(zDiode1.n, zDiode.n) annotation (Line(
      points={{-20,12},{-20,1},{-20,1},{-20,-10}},
      color={0,0,255},
      smooth=Smooth.None));
 annotation (Diagram(coordinateSystem(
         preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics),
   experiment(StopTime=0.4),
   Documentation(info="<html>
<p>This example is a simple circuit for overvoltage protection. If the voltage zDiode_1.n.v is too high, the Diode zDiode_2 breaks through and the voltage gets down.</p><p>The simulation end time should be set to 0.4. To get the typical behaviour please plot sineVoltage.p.v, RL.p.v, zDiode_2.n.v and zDiode_1.n.i.</p>
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
            100}}), graphics));
end OvervoltageProtection;
