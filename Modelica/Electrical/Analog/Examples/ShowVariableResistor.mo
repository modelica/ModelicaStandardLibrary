within Modelica.Electrical.Analog.Examples;
model ShowVariableResistor "Simple demo of a VariableResistor model"
   extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Basic.VariableResistor VariableResistor
                    annotation (Placement(transformation(extent={{-20,-20},{0,0}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground Ground1
  annotation (Placement(transformation(extent={{-100,-80},{-80,-60}}, rotation=
            0)));
  Modelica.Electrical.Analog.Basic.Ground Ground2
  annotation (Placement(transformation(extent={{60,-40},{80,-20}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor R1
  annotation (Placement(transformation(extent={{-60,40},{-40,60}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor R2
  annotation (Placement(transformation(extent={{-20,40},{0,60}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor R3
  annotation (Placement(transformation(extent={{20,40},{40,60}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor R4
  annotation (Placement(transformation(extent={{-60,-20},{-40,0}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor R5
  annotation (Placement(transformation(extent={{20,-20},{40,0}}, rotation=0)));

  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1
  annotation (Placement(transformation(
        origin={-90,-30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.Ramp Ramp1(height=5, offset=2)
  annotation (Placement(transformation(
        origin={-10,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(R1.n, R2.p)             annotation (Line(points={{-40,50},{-20,50}},
        color={0,0,255}));
  connect(R2.n, R3.p)             annotation (Line(points={{5.55112e-16,50},{20,
          50}},
        color={0,0,255}));
  connect(R4.n, VariableResistor.p)       annotation (Line(points={{-40,-10},{
          -20,-10}}, color={0,0,255}));
  connect(VariableResistor.n, R5.p)       annotation (Line(points={{5.55112e-16,
          -10},{20,-10}},
                 color={0,0,255}));
  connect(R3.n, Ground2.p)      annotation (Line(points={{40,50},{70,50},{70,
          -20}}, color={0,0,255}));
  connect(Ground2.p, R5.n)      annotation (Line(points={{70,-20},{70,-10},{40,
          -10}}, color={0,0,255}));
  connect(SineVoltage1.p, Ground1.p)
                                   annotation (Line(points={{-90,-40},{-90,-60}},
        color={0,0,255}));
  connect(SineVoltage1.n, R1.p)      annotation (Line(points={{-90,-20},{-90,50},
          {-60,50}}, color={0,0,255}));
  connect(SineVoltage1.n, R4.p)      annotation (Line(points={{-90,-20},{-90,
          -10},{-60,-10}}, color={0,0,255}));
  connect(Ramp1.y, VariableResistor.R)           annotation (Line(points={{-10,9},
          {-10,4.5},{-10,1},{-10,1}},    color={0,0,255}));
annotation (Documentation(info="<html>
<p>It is a simple test circuit for the VariableResistor. The VariableResistor sould be compared with R2.</p>
<p>Simulate until T=1 s.</p>
</html>",
   revisions="<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>Mai 6, 2004   </i>
       by Teresa Schlegel<br> realized<br>
       </li>
</ul>
</html>"),
  experiment(StopTime=1),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Text(
          extent={{-100,112},{80,40}},
          lineColor={0,0,255},
          textString="Example VariableResistor")}),
           Diagram);
end ShowVariableResistor;
