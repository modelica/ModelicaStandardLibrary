within Modelica.Electrical.Machines.Interfaces;
connector ThermalPortTransformer "Thermal port of transformers"
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort1[m]
    "Heat port of primary windings"
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort2[m]
    "Heat port of secondary windings"
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortCore
    "Heat port of (optional) core losses"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    annotation (
    Diagram(graphics={Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={191,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid), Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}),
    Icon(graphics={Rectangle(
          extent={{-110,110},{110,-110}},
          lineColor={191,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid), Ellipse(
              extent={{-80,80},{80,-80}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
Thermal port for transformers
</html>"));
end ThermalPortTransformer;
