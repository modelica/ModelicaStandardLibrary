within Modelica.Electrical.Analog.Examples.Utilities;
model SwitchedCapacitor "Switched capacitor which can represent a positive or negative resistance"

  parameter Modelica.SIunits.Time clock(start=1) "Clock";
  parameter Modelica.SIunits.Resistance R(start=1) "Resistance";
  Modelica.Blocks.Sources.BooleanPulse BooleanPulse(period=clock) annotation (Placement(transformation(extent={{-8,70},{12,90}})));
  Modelica.Electrical.Analog.Basic.Capacitor Capacitor(C=clock/max(Modelica.Constants.eps*oneOhm,abs(R)))
                                                                  annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Modelica.Electrical.Analog.Ideal.IdealCommutingSwitch IdealCommutingSwitch1
    annotation (Placement(transformation(
          origin={-50,0},
          extent={{-10,10},{10,-10}},
          rotation=180)));
  Modelica.Electrical.Analog.Ideal.IdealCommutingSwitch IdealCommutingSwitch2
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Electrical.Analog.Basic.Ground Ground1
    annotation (Placement(transformation(
          origin={-60,-26},
          extent={{-6,6},{6,-6}},
          rotation=180)));
  Modelica.Electrical.Analog.Basic.Ground Ground2
    annotation (Placement(transformation(extent={{54,-32},{66,-20}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Blocks.Sources.RealExpression Resistance(y=R) annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(extent={{4,34},{-4,42}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch annotation (Placement(transformation(extent={{-20,20},{-40,40}})));
protected
  constant Modelica.SIunits.Resistance oneOhm=1 "Helping constant to satisfy unit check";
equation
  connect(IdealCommutingSwitch1.p, Capacitor.p) annotation (Line(points={{-40,0},{-40,0},{-44,0},{-20,0}}, color={0,0,255}));
  connect(Capacitor.n, IdealCommutingSwitch2.p) annotation (Line(points={{20,0},{25,0},{30,0},{40,0}}, color={0,0,255}));
  connect(IdealCommutingSwitch2.control, BooleanPulse.y) annotation (Line(points={{50,12},{50,22},{20,22},{20,80},{13,80}}, color={255,0,255}));
  connect(Ground1.p, IdealCommutingSwitch1.n2) annotation (Line(points={{-60,-20},{-60,0}},
                      color={0,0,255}));
  connect(Ground2.p, IdealCommutingSwitch2.n2) annotation (Line(points={{60,-20},{60,0}},
                     color={0,0,255}));
  connect(IdealCommutingSwitch1.n1, p) annotation (Line(points={{-60,4},{-80,4},{-80,0},{-102,0}}, color={0,0,255}));
  connect(IdealCommutingSwitch2.n1, n) annotation (Line(points={{60,4},{80,4},{80,0},{100,0}}, color={0,0,255}));
  connect(p, p) annotation (Line(points={{-102,0},{-102,0}}, color={0,0,255}));
  connect(Resistance.y, lessEqualThreshold.u) annotation (Line(points={{-79,60},{-62,60}}, color={0,0,127}));
  connect(logicalSwitch.y, IdealCommutingSwitch1.control) annotation (Line(points={{-41,30},{-50,30},{-50,12}}, color={255,0,255}));
  connect(logicalSwitch.u3, BooleanPulse.y) annotation (Line(points={{-18,22},{20,22},{20,80},{13,80}}, color={255,0,255}));
  connect(logicalSwitch.u1, not1.y) annotation (Line(points={{-18,38},{-4.4,38}}, color={255,0,255}));
  connect(not1.u, BooleanPulse.y) annotation (Line(points={{4.8,38},{20,38},{20,80},{13,80}}, color={255,0,255}));
  connect(lessEqualThreshold.y, logicalSwitch.u2) annotation (Line(points={{-39,60},{-10,60},{-10,30},{-18,30}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Rectangle(
            extent={{-80,30},{80,-32}},
            lineColor={0,0,255}),
          Line(points={{-92,0},{-80,0}}, color={85,85,255}),
          Line(points={{80,0},{92,0}}, color={85,85,255}),
          Text(
            extent={{-150,-32},{150,-92}},
            textString="R=%R"),
          Line(points={{-74,0},{-80,0},{-60,0}}, color={85,255,85}),
          Line(points={{-80,-20},{-60,-20},{-60,-16},{-40,-10},{-4,-10}}, color=
               {85,255,85}),
          Line(points={{4,-10},{40,-10},{60,-16},{60,-20},{80,-20}}, color={85,255,85}),
          Line(points={{80,0},{60,0}}, color={85,255,85}),
          Line(points={{60,0},{60,-4}}, color={85,255,85}),
          Line(points={{-60,0},{-60,-6}}, color={170,255,170}),
          Line(points={{-4,0},{-4,-20}}, color={85,255,85}),
          Line(points={{4,0},{4,-20}}, color={85,255,85}),
          Text(
            extent={{-150,90},{150,50}},
            lineColor={0,0,255},
            textString="%name")}),
      Documentation(info="<html>
<p>This model is a switched capacitor model without thermal behavior which can represent positive and negative resistances.</p>
<p>The clock source is inside the model, its frequency can be chosen by a parameter.
Also the resistance is a parameter which can be positive and negative.
The internal (switched) capacitor is parametrized in such a way that the total resistance is independently from the frequency equal to the resistance parameter.</p>
</html>"));
end SwitchedCapacitor;
