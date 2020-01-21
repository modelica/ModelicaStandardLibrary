within Modelica.Electrical.Machines.Sensors;
model MechanicalPowerSensor "Mechanical power = torque x speed"
  extends Modelica.Icons.RoundSensor;
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
  parameter Boolean useSupport=false "Use support or fixed housing"
    annotation (Evaluate=true);
  Modelica.Blocks.Interfaces.RealOutput P(final quantity="Power", final
      unit="W") annotation (Placement(transformation(
        origin={0,110},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Math.Product product annotation (Placement(transformation(
        origin={0,30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.Rotational.Sensors.RelSpeedSensor relSpeedSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-30})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed if (not useSupport)
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a support if useSupport
    "Support at which the reaction torque is acting" annotation (Placement(
        transformation(extent={{-10,-110},{10,-90}})));
equation
  connect(flange_a, torqueSensor.flange_a) annotation (Line(points={{-100,0},
          {-70,0},{-40,0},{20,0}}));
  connect(torqueSensor.flange_b, flange_b)
    annotation (Line(points={{40,0},{100,0}}));
  connect(flange_a, relSpeedSensor.flange_b) annotation (Line(
      points={{-100,0},{-30,0},{-30,-20}}));
  connect(relSpeedSensor.flange_a, fixed.flange) annotation (Line(
      points={{-30,-40},{-30,-90}}));
  connect(relSpeedSensor.flange_a, support) annotation (Line(
      points={{-30,-40},{-30,-80},{0,-80},{0,-100}}));
  connect(relSpeedSensor.w_rel, product.u1) annotation (Line(
      points={{-19,-30},{-6,-30},{-6,18}}, color={0,0,127}));
  connect(torqueSensor.tau, product.u2) annotation (Line(
      points={{22,-11},{22,-20},{6,-20},{6,18}}, color={0,0,127}));
  connect(product.y, P) annotation (Line(
      points={{0,41},{0,110}}, color={0,0,127}));
  annotation (defaultComponentName="powerSensor",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Line(points={{-70,0},{-90,0}}),
          Line(points={{70,0},{90,0}}),Line(points={{0,70},{0,100}}, color=
          {0,0,127}),Rectangle(
              visible=useSupport,
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid,
              extent={{-20,-120},{20,-80}}),Line(visible=not useSupport,
          points={{-20,-100},{20,-100}}),Line(visible=not useSupport,
          points={{-10,-100},{-20,-120}}),Line(visible=not useSupport,
          points={{0,-100},{-10,-120}}),Line(visible=not useSupport, points=
           {{10,-100},{0,-120}}),Line(visible=not useSupport, points={{20,-100},
          {10,-120}}),
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="W")}),         Documentation(info="<html>
Calculates (mechanical) power from torque times angular speed.
</html>"));
end MechanicalPowerSensor;
