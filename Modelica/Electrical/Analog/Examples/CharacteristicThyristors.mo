model CharacteristicThyristors "Characteristic of ideal thyristors" 
  extends Modelica.Icons.Example;
  
  Modelica.Electrical.Analog.Ideal.IdealThyristor IdealThyristor1(
                    Vknee=5) 
                           annotation (extent=[-20, 0; 0, 20]);
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1(V=10,
      offset=0) 
              annotation (extent=[-50, -20; -30, 0], rotation=270);
  Modelica.Electrical.Analog.Basic.Ground Ground1 
  annotation (extent=[-50, -60; -30, -40]);
  Modelica.Electrical.Analog.Basic.Resistor R3(R=1.e-3) 
  annotation (extent=[40, 0; 60, 20]);
  
annotation (Diagram(Text(extent=[-96, 100; 98, 60], string=
          "Characteristic Thyristors")));
  Modelica.Blocks.Sources.BooleanStep BooleanStep1(startValue={false},
      startTime={1.25}) 
                      annotation (extent=[-60, 40; -40, 60]);
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor IdealGTOThyristor1(
                       Vknee=0) 
                              annotation (extent=[-20, -30; 0, -10]);
  Modelica.Electrical.Analog.Basic.Resistor R1(R=1.e-3) 
  annotation (extent=[40, -30; 60, -10]);
  
annotation (Documentation(info="<HTML>
<P>
Two examples of thyristors are shown:<br><br>
the <b>ideal thyristor</b>  <br>
and the <b>ideal GTO thyristor</b>  with <i>Vknee=5</i>  <br><br>
</P>
<P>
Simulate until T=2 s.
</P>
<P>
Plot in separate windows:<br> <br>
IdealThyristor1.i and IdealGTOThyristor1.i <br>
IdealThyristor1.v and IdealGTOThyristor1.v <br>
</P>
<p><b>Release Notes:</b></p>
<ul>
<li><i>Mai 7, 2004   </i>
       by Christoph Clauss<br> realized<br>
       </li>
</ul>
</HTML>
"),
  experiment(
     StopTime=2));
equation 
  connect(IdealThyristor1.n, R3.p) 
  annotation (points=[0, 10; 40, 10], style(color=3));
  connect(Ground1.p, SineVoltage1.n) 
  annotation (points=[-40, -40; -40, -20], style(color=3));
  connect(SineVoltage1.p, IdealThyristor1.p) 
  annotation (points=[-40, 0; -40, 10; -20, 10], style(color=3));
  connect(BooleanStep1.outPort, IdealThyristor1.firePort) 
  annotation (points=[-39,50; -3,50; -3,20],    style(color=5));
  connect(IdealGTOThyristor1.n, R1.p) 
  annotation (points=[0, -20; 40, -20], style(color=3));
  connect(R3.n, R1.n) 
  annotation (points=[60, 10; 60, -20], style(color=3));
  connect(R1.n, Ground1.p) 
  annotation (points=[60, -20; 60, -40; -40, -40], style(color=3));
  connect(IdealGTOThyristor1.p, IdealThyristor1.p) 
  annotation (points=[-20, -20; -20, 10], style(color=3));
  connect(IdealGTOThyristor1.firePort, IdealThyristor1.firePort) 
  annotation (points=[-3,-10; -3,-2.5; -2,-2.5; -2,5; -3,5; -3,20],
                                        style(color=5));
end CharacteristicThyristors;
