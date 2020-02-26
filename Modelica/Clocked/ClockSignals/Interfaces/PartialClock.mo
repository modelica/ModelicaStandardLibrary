within Modelica.Clocked.ClockSignals.Interfaces;
partial block PartialClock
  "Icon, connector, and solver method of a block that generates a clock"
  parameter Boolean useSolver = false
    "= true, if solverMethod shall be explicitly defined"
    annotation(Evaluate=true, Dialog(tab="Advanced"), choices(checkBox=true));
  parameter ModelicaServices.Types.SolverMethod solverMethod="ExplicitEuler"
    "Integration method used for discretized continuous-time partitions" annotation(Dialog(tab="Advanced",enable=useSolver));
  Clocked.ClockSignals.Interfaces.ClockOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
            100,100}}),
                    graphics={
        Ellipse(
          extent={{-100,100},{100,-100}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={95,95,95}),
        Ellipse(
          extent={{9,-10},{-11,10}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-1,0},{52,50}},  color={95,95,95}),
        Rectangle(
          extent={{80,6},{100,-6}},
          fillPattern=FillPattern.Solid,
          lineColor={95,95,95},
          fillColor={95,95,95}),
        Rectangle(
          extent={{-100,6},{-80,-6}},
          fillPattern=FillPattern.Solid,
          lineColor={95,95,95},
          fillColor={95,95,95}),
        Rectangle(
          extent={{20,58},{40,46}},
          fillPattern=FillPattern.Solid,
          rotation=90,
          origin={52,-120},
          lineColor={95,95,95},
          fillColor={95,95,95}),
        Rectangle(
          extent={{20,58},{40,46}},
          fillPattern=FillPattern.Solid,
          rotation=45,
          origin={80,6},
          lineColor={95,95,95},
          fillColor={95,95,95}),
        Rectangle(
          extent={{20,58},{40,46}},
          fillPattern=FillPattern.Solid,
          rotation=135,
          origin={-6,80},
          lineColor={95,95,95},
          fillColor={95,95,95}),
        Rectangle(
          extent={{20,58},{40,46}},
          fillPattern=FillPattern.Solid,
          rotation=135,
          origin={122,-48},
          lineColor={95,95,95},
          fillColor={95,95,95}),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>

</html>"));
end PartialClock;
