within Modelica.Electrical.Analog.Examples.Utilities;
model RealSwitch "Ideal switch with resistance"

  Ideal.ControlledIdealCommutingSwitch S(level=2.5) annotation (Placement(
        transformation(extent={{11.3333,-46},{58,0.6667}}, rotation=0)));
  Basic.Resistor R(R=0.01) annotation (Placement(transformation(extent={{-66,-48},
            {-19.3333,-1.3333}}, rotation=0)));
  Interfaces.Pin p annotation (Placement(transformation(extent={{-110,-34},{-90,
            -14}},rotation=0)));
  Interfaces.Pin n1 annotation (Placement(transformation(extent={{90,-14},{110,
            6}},  rotation=0)));
  Interfaces.Pin n2 annotation (Placement(transformation(extent={{90,-60},{110,
            -40}},
          rotation=0)));
  Interfaces.Pin control annotation (Placement(transformation(extent={{24,26},{
            44,46}},  rotation=0)));
equation
  connect(p, R.p) annotation (Line(points={{-100,-24},{-66,-24.6667}}));
  connect(R.n, S.p) annotation (Line(points={{-19.3333,-24.6667},{11.3333,
          -22.6667}}));
  connect(n1, S.n1) annotation (Line(points={{100,-4},{58,-11}}));
  connect(n2, S.n2) annotation (Line(points={{100,-50},{58,-22.6667}}));
  connect(control, S.control) annotation (Line(points={{34,36},{34.6666,0.6667}}));
  annotation (
    Documentation(info="<html>
<p>This component is a special kind of a commuting switch which possesses an additional constant resistance. This resistance was necessary in an example. It is not designed for common use.</p>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-90,86},{28,70}},
          lineColor={0,0,255},
          textString="Real Switch")}));
end RealSwitch;
