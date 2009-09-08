within Modelica.Electrical.Analog.Examples.Utilities;
model RealSwitch "ideal switch with resistance"

  Ideal.ControlledIdealCommutingSwitch S(level=2.5) annotation (Placement(
        transformation(extent={{11.3333,18},{58,64.6667}}, rotation=0)));
  Basic.Resistor R(R=0.01) annotation (Placement(transformation(extent={{-66,16},
            {-19.3333,62.6667}}, rotation=0)));
  Interfaces.Pin p annotation (Placement(transformation(extent={{-110,30},{-90,
            50}}, rotation=0)));
  Interfaces.Pin n1 annotation (Placement(transformation(extent={{90,50},{110,
            70}}, rotation=0)));
  Interfaces.Pin n2 annotation (Placement(transformation(extent={{90,4},{110,24}},
          rotation=0)));
  Interfaces.Pin control annotation (Placement(transformation(extent={{24,90},{
            44,110}}, rotation=0)));
equation
  connect(p, R.p) annotation (Line(points={{-100,40},{-66,39.3333}}));
  connect(R.n, S.p) annotation (Line(points={{-19.3333,39.3333},{11.3333,
          41.3334}}));
  connect(n1, S.n1) annotation (Line(points={{100,60},{58,53}}));
  connect(n2, S.n2) annotation (Line(points={{100,14},{58,41.3334}}));
  connect(control, S.control) annotation (Line(points={{34,100},{34.6666,
          64.6667}}));
  annotation (
    Documentation(info="<html>

</html>"));
end RealSwitch;
