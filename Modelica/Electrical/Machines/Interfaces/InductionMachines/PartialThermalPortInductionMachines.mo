within Modelica.Electrical.Machines.Interfaces.InductionMachines;
connector PartialThermalPortInductionMachines
  "Partial thermal port of induction machines"
  parameter Integer m=3 "Number of stator phases" annotation(Evaluate=true);
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    heatPortStatorWinding[m] "Heat port of stator windings"
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortStatorCore
    "Heat port of (optional) stator core losses"
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortRotorCore
    "Heat port of (optional) rotor core losses"
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortStrayLoad
    "Heat port of (optional) stray losses"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortFriction
    "Heat port of (optional) friction losses"
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
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
Partial thermal port for induction machines
</html>"));
end PartialThermalPortInductionMachines;
