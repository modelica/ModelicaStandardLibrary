within Modelica.Electrical.Polyphase.Examples;
model PolyphaseInitialization
  "Demonstrate initialization of inductances in 3 and 4 wire system"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m=3 "Number of phases";
  parameter SI.Voltage V=230 "RMS voltage line to neutral";
  parameter SI.Frequency f=50 "Source frequency";
  parameter SI.Impedance Z=10 "Total impedance";
  parameter SI.Resistance R=Z/sqrt(2) "Resistive component";
  parameter SI.Inductance L=Z/sqrt(2)/(2*pi*f) "Inductive component";
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage11(V=sqrt(2)*V, f=f,
    phase=0)
    annotation (Placement(transformation(extent={{-70,70},{-90,90}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage12(V=sqrt(2)*V, f=f,
    phase=-2*pi/3)
    annotation (Placement(transformation(extent={{-70,50},{-90,70}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage13(V=sqrt(2)*V, f=f,
    phase=-4*pi/3)
    annotation (Placement(transformation(extent={{-70,30},{-90,50}})));
  Modelica.Electrical.Analog.Basic.Ground ground1
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor11(R=R)
    annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor12(R=R)
    annotation (Placement(transformation(extent={{-30,50},{-10,70}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor13(R=R)
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor11(L=L, i(start=0, fixed=true))
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor12(L=L, i(start=0, fixed=true))
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor13(L=L, i(start=0, fixed=false))
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage21(V=sqrt(2)*V, f=f,
    phase=0)
    annotation (Placement(transformation(extent={{-70,-30},{-90,-10}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage22(V=sqrt(2)*V, f=f,
    phase=-2*pi/3)
    annotation (Placement(transformation(extent={{-70,-50},{-90,-30}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage23(V=sqrt(2)*V, f=f,
    phase=-4*pi/3)
    annotation (Placement(transformation(extent={{-70,-70},{-90,-50}})));
  Modelica.Electrical.Analog.Basic.Ground ground2
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor21(R=R)
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor22(R=R)
    annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor23(R=R)
    annotation (Placement(transformation(extent={{-30,-70},{-10,-50}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor21(L=L, i(start=0, fixed=true))
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor22(L=L, i(start=0, fixed=true))
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor23(L=L, i(start=0, fixed=true))
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage3(m=m,
    V=fill(sqrt(2)*V, m), f=fill(f, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
      origin={40,70})));
  Modelica.Electrical.Polyphase.Basic.Star star3S(m=m) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
      origin={40,40})));
  Modelica.Electrical.Analog.Basic.Ground ground3
    annotation (Placement(transformation(extent={{30,0},{50,20}})));
  Modelica.Electrical.Polyphase.Basic.Resistor resistor3(m=m, R=fill(R, m))
    annotation (Placement(transformation(extent={{80,70},{100,90}})));
  Modelica.Electrical.Polyphase.Basic.Inductor
           inductor3(m=m, L=fill(L, m),
    iL(start={0,0,0}, fixed={true,true,false}))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={110,70})));
  Modelica.Electrical.Polyphase.Basic.Star star3L(m=m) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={110,40})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage4(m=m,
    V=fill(sqrt(2)*V, m), f=fill(f, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
      origin={40,-30})));
  Modelica.Electrical.Polyphase.Basic.Star star4S(m=m) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,-60})));
  Modelica.Electrical.Analog.Basic.Ground ground4
    annotation (Placement(transformation(extent={{30,-100},{50,-80}})));
  Modelica.Electrical.Polyphase.Basic.Resistor resistor4(m=m, R=fill(R, m))
    annotation (Placement(transformation(extent={{80,-30},{100,-10}})));
  Modelica.Electrical.Polyphase.Basic.Inductor
           inductor4(m=m, L=fill(L, m),
    iL(start={0,0,0}, fixed={true,true,true}))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={110,-30})));
  Modelica.Electrical.Polyphase.Basic.Star star4L(m=m) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={110,-60})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor i11
    annotation (Placement(transformation(extent={{-58,72},{-42,88}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor i12
    annotation (Placement(transformation(extent={{-58,52},{-42,68}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor i13
    annotation (Placement(transformation(extent={{-58,32},{-42,48}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor i21
    annotation (Placement(transformation(extent={{-58,-28},{-42,-12}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor i22
    annotation (Placement(transformation(extent={{-58,-48},{-42,-32}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor i23
    annotation (Placement(transformation(extent={{-58,-68},{-42,-52}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor i20
    annotation (Placement(transformation(extent={{-42,-88},{-58,-72}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentSensor i3(m=m)
    annotation (Placement(transformation(extent={{50,70},{70,90}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentSensor i4(m=m)
    annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor i40
    annotation (Placement(transformation(extent={{70,-80},{50,-60}})));
equation
  connect(resistor13.n, inductor13.p)
    annotation (Line(points={{-10,40},{0,40}}, color={0,0,255}));
  connect(resistor12.n, inductor12.p)
    annotation (Line(points={{-10,60},{0,60}}, color={0,0,255}));
  connect(resistor11.n, inductor11.p)
    annotation (Line(points={{-10,80},{0,80}}, color={0,0,255}));
  connect(inductor11.n, inductor12.n) annotation (Line(points={{20,80},{20,60}},
                            color={0,0,255}));
  connect(inductor13.n, inductor12.n) annotation (Line(points={{20,40},{20,60}},
                            color={0,0,255}));
  connect(ground1.p, sineVoltage12.n)
    annotation (Line(points={{-90,20},{-90,60}},          color={0,0,255}));
  connect(resistor23.n, inductor23.p)
    annotation (Line(points={{-10,-60},{0,-60}}, color={0,0,255}));
  connect(resistor22.n, inductor22.p)
    annotation (Line(points={{-10,-40},{0,-40}}, color={0,0,255}));
  connect(resistor21.n, inductor21.p)
    annotation (Line(points={{-10,-20},{0,-20}}, color={0,0,255}));
  connect(resistor3.plug_n, inductor3.plug_p)
    annotation (Line(points={{100,80},{110,80}},
                                               color={0,0,255}));
  connect(inductor3.plug_n, star3L.plug_p)
    annotation (Line(points={{110,60},{110,50}}, color={0,0,255}));
  connect(sineVoltage3.plug_n, star3S.plug_p)
    annotation (Line(points={{40,60},{40,50}}, color={0,0,255}));
  connect(star3S.pin_n, ground3.p)
    annotation (Line(points={{40,30},{40,20}}, color={0,0,255}));
  connect(resistor4.plug_n,inductor4. plug_p)
    annotation (Line(points={{100,-20},{110,-20}},
                                               color={0,0,255}));
  connect(inductor4.plug_n, star4L.plug_p)
    annotation (Line(points={{110,-40},{110,-50}}, color={0,0,255}));
  connect(sineVoltage4.plug_n, star4S.plug_p)
    annotation (Line(points={{40,-40},{40,-50}}, color={0,0,255}));
  connect(star4S.pin_n, ground4.p)
    annotation (Line(points={{40,-70},{40,-80}}, color={0,0,255}));
  connect(sineVoltage11.p, i11.p)
    annotation (Line(points={{-70,80},{-58,80}}, color={0,0,255}));
  connect(i11.n, resistor11.p)
    annotation (Line(points={{-42,80},{-30,80}}, color={0,0,255}));
  connect(sineVoltage13.p, i13.p)
    annotation (Line(points={{-70,40},{-58,40}}, color={0,0,255}));
  connect(i13.n, resistor13.p)
    annotation (Line(points={{-42,40},{-30,40}}, color={0,0,255}));
  connect(sineVoltage12.p, i12.p)
    annotation (Line(points={{-70,60},{-58,60}}, color={0,0,255}));
  connect(i12.n, resistor12.p)
    annotation (Line(points={{-42,60},{-30,60}}, color={0,0,255}));
  connect(sineVoltage21.p, i21.p)
    annotation (Line(points={{-70,-20},{-58,-20}}, color={0,0,255}));
  connect(i21.n, resistor21.p)
    annotation (Line(points={{-42,-20},{-30,-20}}, color={0,0,255}));
  connect(sineVoltage22.p, i22.p)
    annotation (Line(points={{-70,-40},{-58,-40}}, color={0,0,255}));
  connect(i22.n, resistor22.p)
    annotation (Line(points={{-42,-40},{-30,-40}}, color={0,0,255}));
  connect(sineVoltage23.p, i23.p)
    annotation (Line(points={{-70,-60},{-58,-60}}, color={0,0,255}));
  connect(i23.n, resistor23.p)
    annotation (Line(points={{-42,-60},{-30,-60}}, color={0,0,255}));
  connect(ground2.p, i20.n)
    annotation (Line(points={{-90,-80},{-58,-80}}, color={0,0,255}));
  connect(i20.p, inductor22.n)
    annotation (Line(points={{-42,-80},{20,-80},{20,-40}}, color={0,0,255}));
  connect(resistor3.plug_p, i3.plug_n)
    annotation (Line(points={{80,80},{70,80}}, color={0,0,255}));
  connect(i3.plug_p, sineVoltage3.plug_p)
    annotation (Line(points={{50,80},{40,80}}, color={0,0,255}));
  connect(resistor4.plug_p, i4.plug_n)
    annotation (Line(points={{80,-20},{70,-20}}, color={0,0,255}));
  connect(i4.plug_p, sineVoltage4.plug_p)
    annotation (Line(points={{50,-20},{40,-20}}, color={0,0,255}));
  connect(star4S.pin_n, i40.n)
    annotation (Line(points={{40,-70},{50,-70}}, color={0,0,255}));
  connect(i40.p, star4L.pin_n)
    annotation (Line(points={{70,-70},{110,-70}}, color={0,0,255}));
  connect(ground1.p, sineVoltage11.n)
    annotation (Line(points={{-90,20},{-90,80}}, color={0,0,255}));
  connect(i20.p, inductor23.n)
    annotation (Line(points={{-42,-80},{20,-80},{20,-60}}, color={0,0,255}));
  connect(i20.p, inductor21.n)
    annotation (Line(points={{-42,-80},{20,-80},{20,-20}}, color={0,0,255}));
  connect(ground2.p, sineVoltage21.n)
    annotation (Line(points={{-90,-80},{-90,-20}}, color={0,0,255}));
  connect(ground2.p, sineVoltage22.n)
    annotation (Line(points={{-90,-80},{-90,-40}}, color={0,0,255}));
  connect(ground2.p, sineVoltage23.n)
    annotation (Line(points={{-90,-80},{-90,-60}}, color={0,0,255}));
  connect(ground1.p, sineVoltage13.n)
    annotation (Line(points={{-90,20},{-90,40}}, color={0,0,255}));
  annotation (preferredView="info",
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(extent={{-100,-100},{125,100}})),
    experiment(
      StopTime=0.1,
      Interval=0.0001),
    Documentation(info="<html>
<p>
Proper initialization of polyphase systems requires an analysis of the circuit, helping to decide 
how many states and which states should be initialized with <code>fixed=true</code> (or <code>fixed=false</code>).
</p>
<p>
This example demonstrates the initialization of three-phase inductances in a 3 wire and a 4 wire system:
</p>
<p>
In the 3 wire system the implicit equation <code>i11 + i12 + i13 = 0</code> has to be taken into account. <br>
Therefore only 2 of the 3 currents may be initialized with <code>fixed=true</code>.
With the polyphase component, the initial values have to be set accordingly. e.g.:<br>
<code>  Inductor inductor(m=3, iL(start={0, 0, 0}, fixed={true, true, false}));</code>
</p>
<p>
In the 4 wire system the implicit equation <code>i21 + i22 + i23 = i20</code> has to be taken into account. <br>
Therefore all 3 currents may be initialized with <code>fixed=true</code>.
With the polyphase component, the initial values have to be set accordingly, e.g.:<br>
<code>  Inductor inductor(m=3, iL(start={0, 0, 0}, fixed={true, true, true }));</code>
</p>
<p>
It depends on the tool whether you have to set the <code>fixed</code> attribute textually, or if it is possible to do it graphically.
</p>
</html>"));
end PolyphaseInitialization;
