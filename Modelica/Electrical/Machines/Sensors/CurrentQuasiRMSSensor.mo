within Modelica.Electrical.Machines.Sensors;
model CurrentQuasiRMSSensor "Length of space phasor -> RMS current"
  extends Modelica.Icons.RoundSensor;
  constant Integer m(final min=1) = 3 "Number of phases";
  Modelica.Blocks.Interfaces.RealOutput I(final quantity="ElectricCurrent",
      final unit="A") annotation (Placement(transformation(
        origin={0,-110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_p(final m=m)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_n(final m=m)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentSensor CurrentSensor1(
      final m=m) annotation (Placement(transformation(extent={{-10,40},{10,
            60}})));
  Modelica.Blocks.Math.Gain Gain1(final k=1/sqrt(2)) annotation (Placement(
        transformation(
        origin={0,-70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Machines.SpacePhasors.Blocks.ToSpacePhasor ToSpacePhasor1(m=m) annotation (
      Placement(transformation(
        origin={0,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Machines.SpacePhasors.Blocks.ToPolar ToPolar1 annotation (Placement(
        transformation(
        origin={0,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(plug_p, CurrentSensor1.plug_p) annotation (Line(points={{-100,0},
          {-100,50},{-10,50}}, color={0,0,255}));
  connect(CurrentSensor1.plug_n, plug_n)
    annotation (Line(points={{10,50},{100,50},{100,0}}, color={0,0,255}));
  connect(CurrentSensor1.i, ToSpacePhasor1.u) annotation (Line(
      points={{0,39},{0,22}}, color={0,0,127}));
  connect(ToSpacePhasor1.y, ToPolar1.u) annotation (Line(
      points={{0,-1},{0,-18}}, color={0,0,127}));
  connect(ToPolar1.y[1], Gain1.u) annotation (Line(
      points={{-1.9984e-15,-41},{-1.9984e-15,-50.5},{0,-50.5},{0,-58}},
                                                          color={0,0,127}));
  connect(Gain1.y, I) annotation (Line(
      points={{0,-81},{0,-110}}, color={0,0,127}));
  annotation (defaultComponentName="currentRMSSensor",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Line(points={{-90,0},{90,0}},
          color={0,0,255}),
          Line(points={{0,-70},{0,-100}}, color={0,0,127}),
                              Text(
                extent={{-150,120},{150,80}},
                textString="%name",
                textColor={0,0,255}),
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="A")}),         Documentation(info="<html>
Measured three-phase instantaneous currents are transformed to the corresponding space phasor;
output is length of the space phasor divided by sqrt(2), thus giving in sinusoidal stationary state RMS current.
</html>"));
end CurrentQuasiRMSSensor;
