model ShowVariableResistor "Simple demo of a VariableResistor model" 
   extends Modelica.Icons.Example;
  
  Modelica.Electrical.Analog.Basic.VariableResistor VariableResistor 
                    annotation(extent=[-20,-20; 0,0], rotation=0);
  Modelica.Electrical.Analog.Basic.Ground Ground1 
  annotation(extent=[-100,-80; -80,-60]);
  Modelica.Electrical.Analog.Basic.Ground Ground2 
  annotation(extent=[60,-40; 80,-20]);
  Modelica.Electrical.Analog.Basic.Resistor R1 
  annotation(extent=[-60,40; -40,60]);
  Modelica.Electrical.Analog.Basic.Resistor R2 
  annotation(extent=[-20,40; 0,60]);
  Modelica.Electrical.Analog.Basic.Resistor R3 
  annotation(extent=[20,40; 40,60]);
  Modelica.Electrical.Analog.Basic.Resistor R4 
  annotation(extent=[-60,-20; -40,0]);
  Modelica.Electrical.Analog.Basic.Resistor R5 
  annotation(extent=[20,-20; 40,0]);
  
annotation (Documentation(info="<HTML>
<P>
It is a simple test circuit for the VariableResistor. The VariableResistor
sould be compared with R2.
</P>
<P>
Simulate until T=1 s.
</P>
<P>

<p><b>Release Notes:</b></p>
<ul>
<li><i>Mai 6, 2004   </i>
       by Teresa Schlegel<br> realized<br>
       </li>
</ul>
</HTML>
"),
  experiment(
     StopTime=1),
    Diagram(Text(
        extent=[-100,112; 80,40],
        style(color=3, rgbcolor={0,0,255}),
        string="Example VariableResistor")));
  
annotation(Diagram);
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1 
  annotation(extent=[-100,-40; -80,-20], rotation=90);
  Modelica.Blocks.Sources.Ramp Ramp1(height={5}, offset={2}) 
  annotation(extent=[-20,10; 0,30], rotation=270);
equation 
  connect(R1.n, R2.p)             annotation(points=[-40,50; -20,50],
    style(color=3, rgbcolor={0,0,255}));
  connect(R2.n, R3.p)             annotation(points=[0,50; 20,50],
    style(color=3, rgbcolor={0,0,255}));
  connect(R4.n, VariableResistor.p)       annotation(points=[-40,-10;
      -20,-10], style(color=3, rgbcolor={0,0,255}));
  connect(VariableResistor.n, R5.p)       annotation(points=[0,-10;
      20,-10], style(color=3, rgbcolor={0,0,255}));
  connect(R3.n, Ground2.p)      annotation(points=[40,50; 70,50; 70,
      -20], style(color=3, rgbcolor={0,0,255}));
  connect(Ground2.p, R5.n)      annotation(points=[70,-20; 70,-10; 40,
      -10], style(color=3, rgbcolor={0,0,255}));
  connect(SineVoltage1.p, Ground1.p) 
                                   annotation(points=[-90,-40; -90,
      -60], style(color=3, rgbcolor={0,0,255}));
  connect(SineVoltage1.n, R1.p)      annotation(points=[-90,-20; -90,
      50; -60,50], style(color=3, rgbcolor={0,0,255}));
  connect(SineVoltage1.n, R4.p)      annotation(points=[-90,-20; -90,-10; -60,
        -10],                 style(color=3, rgbcolor={0,0,255}));
  connect(Ramp1.outPort, VariableResistor.R_Port) 
                                                 annotation(points=[-10,9; -10,
        4.5; -10,4.5; -10,0],          style(color=3, rgbcolor={0,0,
        255}));
end ShowVariableResistor;
