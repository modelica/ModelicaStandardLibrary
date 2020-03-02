within Modelica.Electrical.Polyphase.Examples;
model PolyphaseRectifier "Demonstrate a polyphase diode rectifier"
  extends Icons.Example;
  parameter Utilities.PolyphaseRectifierData data
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  Sources.SineVoltage sineVoltage(
    m=data.m,
    V=sqrt(2)*fill(data.VrmsY, data.m),
    f=fill(data.f, data.m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,-60})));
  Basic.MultiStarResistance multiStar(m=data.m, R=data.RGnd)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-60,-90})));
  Analog.Basic.Resistor resistor2ground(R=data.RGnd)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-30,-90})));
  Analog.Basic.Ground groundAC
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-90})));
  Utilities.AnalysatorAC analysatorAC(m=data.m, f=data.f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,-30})));
  Basic.SplitToSubsystems splitToSubsystems(m=data.m)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Ideal.IdealDiode diode1[data.mSystems](
    each m=data.mBasic,
    each Ron=fill(1e-6, data.mBasic),
    each Goff=fill(1e-6, data.mBasic),
    each Vknee=fill(0, data.mBasic)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,20})));
  Ideal.IdealDiode diode2[data.mSystems](
    each m=data.mBasic,
    each Ron=fill(1e-6, data.mBasic),
    each Goff=fill(1e-6, data.mBasic),
    each Vknee=fill(0, data.mBasic)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-20})));
  Basic.Star star1[data.mSystems](each m=data.mBasic) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,50})));
  Basic.Star star2[data.mSystems](each m=data.mBasic) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,-50})));
  Analog.Basic.Resistor resistorDC1[data.mSystems](each R=data.RDC/2)
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Analog.Basic.Inductor inductorDC1[data.mSystems](each i(fixed=true, start=0),
      each L=data.LDC/2)
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Utilities.AnalysatorDC analysatorDC[data.mSystems](each f=data.f)
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Analog.Basic.Resistor resistorDC2[data.mSystems](each R=data.RDC/2) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-60})));
  Analog.Basic.Inductor inductorDC2[data.mSystems](each i(fixed=true, start=0),
      each L=data.LDC/2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,-60})));
  Utilities.AnalysatorDC analysatorDCload(f=data.f)
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Analog.Basic.Resistor loadResistor1(R=data.RLoad/2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,30})));
  Analog.Basic.Resistor loadResistor2(R=data.RLoad/2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,-30})));
  Analog.Basic.Ground groundDC annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,0})));
equation
  for p in 1:data.Par loop
    for s in 1:data.Ser - 1 loop
      connect(inductorDC2[(p - 1)*data.Ser + s].p, inductorDC1[(p - 1)*data.Ser + s + 1].n);
    end for;
    connect(inductorDC1[(p - 1)*data.Ser + 1].n, analysatorDCload.p);
    connect(loadResistor2.n, inductorDC2[p*data.Ser].p);
  end for;
  connect(sineVoltage.plug_n, multiStar.plug)
    annotation (Line(points={{-90,-70},{-90,-90},{-70,-90}},
                                                   color={0,0,255}));
  connect(star1.plug_p, diode1.plug_n)
    annotation (Line(points={{-50,40},{-50,30}},          color={0,0,255}));
  connect(diode2.plug_p, star2.plug_p)
    annotation (Line(points={{-50,-30},{-50,-40}}, color={0,0,255}));
  connect(loadResistor1.n, groundDC.p)
    annotation (Line(points={{90,20},{90,0}}, color={0,0,255}));
  connect(groundDC.p, loadResistor2.p)
    annotation (Line(points={{90,0},{90,-20}}, color={0,0,255}));
  connect(multiStar.pin, resistor2ground.p)
    annotation (Line(points={{-50,-90},{-40,-90}}, color={0,0,255}));
  connect(resistor2ground.n, groundAC.p)
    annotation (Line(points={{-20,-90},{-10,-90}}, color={0,0,255}));
  connect(diode1.plug_p, diode2.plug_n)
    annotation (Line(points={{-50,10},{-50,-10}}, color={0,0,255}));
  connect(analysatorAC.plug_p, sineVoltage.plug_p)
    annotation (Line(points={{-90,-40},{-90,-50}}, color={0,0,255}));
  connect(analysatorAC.plug_nv, multiStar.plug)
    annotation (Line(points={{-80,-30},{-70,-30},{-70,-90}}, color={0,0,255}));
  connect(analysatorDCload.n, loadResistor1.p)
    annotation (Line(points={{80,60},{90,60},{90,40}}, color={0,0,255}));
  connect(loadResistor2.n, analysatorDCload.nv) annotation (Line(points={{90,-40},
          {90,-60},{70,-60},{70,50}}, color={0,0,255}));
  connect(analysatorAC.plug_n, splitToSubsystems.plug_p)
    annotation (Line(points={{-90,-20},{-90,0}}, color={0,0,255}));
  connect(splitToSubsystems.plugs_n, diode1.plug_p)
    annotation (Line(points={{-70,0},{-50,0},{-50,10}}, color={0,0,255}));
  connect(star1.pin_n, analysatorDC.p)
    annotation (Line(points={{-50,60},{-40,60}}, color={0,0,255}));
  connect(analysatorDC.n, resistorDC1.p)
    annotation (Line(points={{-20,60},{-10,60}}, color={0,0,255}));
  connect(resistorDC1.n, inductorDC1.p)
    annotation (Line(points={{10,60},{20,60}}, color={0,0,255}));
  connect(star2.pin_n, resistorDC2.n)
    annotation (Line(points={{-50,-60},{-10,-60}}, color={0,0,255}));
  connect(resistorDC2.p, inductorDC2.n)
    annotation (Line(points={{10,-60},{20,-60}}, color={0,0,255}));
  connect(star2.pin_n, analysatorDC.nv)
    annotation (Line(points={{-50,-60},{-30,-60},{-30,50}}, color={0,0,255}));
  annotation (experiment(StopTime=0.2, Interval=5e-05),  Documentation(info="<html>
<p>
This example demonstrates a polyphase system with a rectifier per subsystem.
</p>
<p>
Note that the interaction between the subsystems is damped by the DC resistors and inductors.
</p>
<p>
You may try different number of phases 2 &le; <code>m</code>, as well as connect the rectifiers with different number of parallel branches, and investigate AC values:
</p>
<ul>
<li>AC power <code>analysatorAC.pTotal</code> (sum of all phases)</li>
<li>AC current <code>analysatorAC.iFeed[m]</code> (1st harmonic rms)</li>
<li>AC voltage <code>analysatorAC.vLN[m]</code> (1st harmonic rms, line to neutral)</li>
<li>AC voltage <code>analysatorAC.vLL[m]</code> (1st harmonic rms, line to line)</li>
</ul>
<p>
as well as DC values per subsystem (rectifier) and total (load):
</p>
<ul>
<li>DC power   total <code>analysatorAC.pDC</code> (mean)</li>
<li>DC current total <code>analysatorAC.iDC</code> (mean)</li>
<li>DC voltage total <code>analysatorAC.vDC</code> (mean)</li>
</ul>
</html>"),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
          extent={{-62,72},{42,-70}},
          lineColor={175,175,175},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          radius=5),                      Text(
          extent={{-24,10},{36,-10}},
          textColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.None,
          textString="rectifiers[mSystems]"),
        Text(
          extent={{-58,10},{58,-10}},
          textColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={50,0},
          rotation=90,
          textString="connected in series / in parallel"),
        Line(
          points={{60,60},{40,60}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(points={{70,-60},{40,-60}}, color={0,0,0},
          pattern=LinePattern.Dot)}));
end PolyphaseRectifier;
