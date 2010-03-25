within Modelica.Electrical.Analog.Examples;
model AD_DA_conversion "Conversion circuit"
  extends Modelica.Icons.Example;
  parameter Integer N=7 "Digital signal width";
  Modelica.Electrical.Analog.Ideal.AD_Converter aD_Converter(N=N)
    annotation (Placement(transformation(extent={{-14,-10},{12,16}})));
  Modelica.Electrical.Digital.Sources.Pulse pulse(
    pulse=Modelica.Electrical.Digital.Interfaces.Logic.'1',
    quiet=Modelica.Electrical.Digital.Interfaces.Logic.'0',
    nperiod=-1,
    width=1,
    period=0.001,
    startTime=0)
             annotation (Placement(transformation(extent={{-32,32},{-12,52}})));
  Modelica.Electrical.Analog.Ideal.DA_Converter dA_Converter(N=N)
    annotation (Placement(transformation(extent={{18,-10},{44,16}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{44,-40},{64,-20}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(
    V=5,
    freqHz=10,
    offset=5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,4})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=1)
    annotation (Placement(transformation(extent={{-28,68},{-8,88}})));
equation
  connect(pulse.y, aD_Converter.trig) annotation (Line(
      points={{-12,42},{-1,42},{-1,14.7}},
      color={127,0,127},
      smooth=Smooth.None));
  connect(sineVoltage.p, aD_Converter.p) annotation (Line(
      points={{-80,14},{-38.5,14},{-38.5,12.1},{-10.1,12.1}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sineVoltage.n, aD_Converter.n) annotation (Line(
      points={{-80,-6},{-38,-6},{-38,-6.1},{-10.1,-6.1}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ground.p, sineVoltage.n) annotation (Line(
      points={{54,-20},{-80,-20},{-80,-6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sineVoltage.p, resistor.p) annotation (Line(
      points={{-80,14},{-80,78},{-28,78}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(dA_Converter.trig, pulse.y) annotation (Line(
      points={{31,14.7},{31,42},{-12,42}},
      color={127,0,127},
      smooth=Smooth.None));
  connect(aD_Converter.y, dA_Converter.x) annotation (Line(
      points={{8.1,3},{11.55,3},{11.55,3},{15,3},{15,3},{21.9,3}},
      color={127,0,127},
      smooth=Smooth.None));
  connect(dA_Converter.p, resistor.n) annotation (Line(
      points={{40.1,12.1},{40.1,78},{-8,78}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(dA_Converter.n, ground.p) annotation (Line(
      points={{40.1,-6.1},{54,-6.1},{54,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics),
    experiment(StopTime=0.2),
    experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics),
    Documentation(info="<html>
<p>The simple converter circuit converts an analog sine signal into a N-bit (by default a 4 bit) logic signal, which is converted backward into an analog signal.</p>
<p><ul>
<li>Simulate for 0.2 s.</li>
</ul></p>
<p>Compare the input voltage (aD_Converter.p.v) with the output voltage (dA_Converter.p.v). By changeing N the influence of the digital signal width can be studied. Otherwise the trigger frequency pulse.period can be changed to see its influence.</p>
</html>", revisions="<html>
<p><ul>
<li><i>October 13, 2009  </i>by Matthias Franke </li>
</ul></p>
</html>"));
end AD_DA_conversion;
