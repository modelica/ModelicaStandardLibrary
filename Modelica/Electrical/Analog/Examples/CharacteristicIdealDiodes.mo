within Modelica.Electrical.Analog.Examples;
model CharacteristicIdealDiodes "Characteristic of ideal diodes"
  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Ideal.IdealDiode Ideal(
    Ron=0,
    Goff=0,
    Vknee=0)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Electrical.Analog.Ideal.IdealDiode With_Ron_Goff(
    Ron=0.1,
    Goff=0.1,
    Vknee=0)
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Electrical.Analog.Ideal.IdealDiode With_Ron_Goff_Vknee(
    Ron=0.2,
    Goff=0.2,
    Vknee=5) annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1(
    V=10,
    offset=-9,
    f=1) annotation (Placement(transformation(
        origin={-40,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground Ground1 annotation (Placement(
        transformation(extent={{-50,-80},{-30,-60}})));

  Modelica.Electrical.Analog.Basic.Resistor R1(R=1e-3) annotation (Placement(
        transformation(extent={{60,40},{80,60}})));
  Modelica.Electrical.Analog.Basic.Resistor R2(R=1e-3)
    annotation (Placement(transformation(extent={{60,0},{80,20}})));
  Modelica.Electrical.Analog.Basic.Resistor R3(R=1e-3) annotation (Placement(
        transformation(extent={{60,-40},{80,-20}})));
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage2(
    V=10,
    offset=0,
    f=1) annotation (Placement(transformation(
        origin={-60,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage3(
    V=10,
    offset=0,
    f=1) annotation (Placement(transformation(
        origin={-20,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));

equation
  connect(Ground1.p, SineVoltage1.n)
    annotation (Line(points={{-40,-60},{-40,-10}}, color={0,0,255}));
  connect(Ideal.n, R1.p)
    annotation (Line(points={{20,50},{60,50}}, color={0,0,255}));
  connect(With_Ron_Goff.n, R2.p)
    annotation (Line(points={{20,10},{60,10}}, color={0,0,255}));
  connect(With_Ron_Goff_Vknee.n, R3.p)
    annotation (Line(points={{20,-30},{60,-30}}, color={0,0,255}));
  connect(R1.n, R2.n)
    annotation (Line(points={{80,50},{80,10}}, color={0,0,255}));
  connect(R2.n, R3.n)
    annotation (Line(points={{80,10},{80,-30}}, color={0,0,255}));
  connect(R3.n, Ground1.p)
    annotation (Line(points={{80,-30},{80,-60},{-40,-60}}, color={0,0,255}));
  connect(SineVoltage2.p, Ideal.p)
    annotation (Line(points={{-60,50},{0,50}}, color={0,0,255}));
  connect(SineVoltage2.n, Ground1.p)
    annotation (Line(points={{-60,30},{-60,-60},{-40,-60}}, color={0,0,255}));
  connect(SineVoltage1.p, With_Ron_Goff.p)
    annotation (Line(points={{-40,10},{0,10}}, color={0,0,255}));
  connect(With_Ron_Goff_Vknee.p, SineVoltage3.p)
    annotation (Line(points={{0,-30},{-20,-30}}, color={0,0,255}));
  connect(SineVoltage3.n, Ground1.p)
    annotation (Line(points={{-20,-50},{-20,-60},{-40,-60}}, color={0,0,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Text(
          extent={{-88,102},{92,48}},
          textString="Characteristic Ideal Diodes",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>Three examples of ideal diodes are shown:
<br>the <strong>totally ideal diode</strong> (Ideal) with all parameters to be zero,
the <strong>nearly ideal diode</strong> with <em>Ron=0.1</em> and <em>Goff=0.1</em>
 and the nearly ideal but <strong>displaced diode</strong> with <em>Vknee=5</em> and <em>Ron=0.1</em> and <em>Goff=0.1</em>.
The resistance and conductance are chosen atypically high since the slopes should be seen in the graphics.
</p><p>Simulate until T=1 s.
Plot in separate windows:
Ideal.i versus Ideal.v, With_Ron_Goff.i versus With_Ron_Goff.v, With_Ron_Goff_Vknee.i versus With_Ron_Goff_Vknee.v
</p>
</html>", revisions="<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>Mai 7, 2004   </em>
       by Christoph Clauss<br> realized<br>
       </li>
</ul>
</html>"),
    experiment(StopTime=1));
end CharacteristicIdealDiodes;
