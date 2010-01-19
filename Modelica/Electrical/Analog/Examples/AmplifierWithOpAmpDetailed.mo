within Modelica.Electrical.Analog.Examples;
model AmplifierWithOpAmpDetailed
  "Simple Amplifier circuit which uses OpAmpDetailed"

  Modelica.Electrical.Analog.Basic.OpAmpDetailed opAmp
    annotation (Placement(transformation(extent={{-26,-4},{2,24}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=10000)
    annotation (Placement(transformation(extent={{-74,8},{-56,26}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R=20000)
    annotation (Placement(transformation(extent={{-22,46},{-4,64}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R=10000) annotation (
      Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=270,
        origin={21,-23})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V=12, freqHz=1000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-28})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=15)
    annotation (Placement(transformation(extent={{48,10},{68,30}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V=-15)
    annotation (Placement(transformation(extent={{48,-10},{68,10}})));
equation
  connect(resistor.n, opAmp.m)       annotation (Line(
      points={{-56,17},{-34,17},{-34,17.07},{-26.07,17.07}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(resistor1.n, resistor2.p) annotation (Line(
      points={{-4,55},{10,55},{10,54},{22,54},{22,-14},{21,-14}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(resistor.p, sineVoltage.p) annotation (Line(
      points={{-74,17},{-80,17},{-80,-18}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(resistor1.p, opAmp.m)       annotation (Line(
      points={{-22,55},{-26.07,55},{-26.07,17.07}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sineVoltage.n, ground.p) annotation (Line(
      points={{-80,-38},{-10,-38},{-10,-50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(opAmp.p, ground.p)       annotation (Line(
      points={{-26.07,2.93},{-26.07,-20},{-10,-20},{-10,-50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(resistor2.n, ground.p) annotation (Line(
      points={{21,-32},{20,-32},{20,-40},{-10,-40},{-10,-50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(opAmp.p_supply, constantVoltage.p)       annotation (Line(
      points={{-11.93,20.29},{18.035,20.29},{18.035,20},{48,20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(opAmp.m_supply, constantVoltage1.p)       annotation (Line(
      points={{-12,-0.36},{18,-0.36},{18,0},{48,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(constantVoltage.n, constantVoltage1.n) annotation (Line(
      points={{68,20},{80,20},{80,0},{68,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(constantVoltage1.n, ground.p) annotation (Line(
      points={{68,0},{80,0},{80,-46},{-10,-46},{-10,-50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(opAmp.outp, resistor2.p)       annotation (Line(
      points={{2,10},{21,10},{21,-14}},
      color={0,0,255},
      smooth=Smooth.None));

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics),
    experiment(
      StopTime=0.003,
      NumberOfIntervals=2500,
      Tolerance=2e-007),
    Documentation(revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i>Juni 17, 2009   </i>
       by Susann Wolf<br> realized<br>
       </li>
</ul>
</html>", info="<html>
<p>
With the test circuit AmplifierWithOpAmpDetailed a time domain analysis of the example arrangement with a sinusoidal input voltage (12 V amplitude, frequency 1 kHz) using the operational amplifier model OpAmpDetailed is carried out. The working voltages are 15 V and -15 V.
</p>

</HTML>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-100,-98},{80,52}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Polygon(
          points={{-100,52},{-80,72},{100,72},{80,52},{-100,52}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Polygon(
          points={{100,72},{100,-78},{80,-98},{80,52},{100,72}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Text(
          extent={{-96,5},{77,-47}},
          lineColor={0,0,255},
          textString="Example"),
        Text(
          extent={{-120,134},{120,75}},
          lineColor={255,0,0},
          textString="%name")}));
end AmplifierWithOpAmpDetailed;
