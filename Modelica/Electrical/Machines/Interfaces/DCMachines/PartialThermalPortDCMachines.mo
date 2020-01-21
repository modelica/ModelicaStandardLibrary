within Modelica.Electrical.Machines.Interfaces.DCMachines;
connector PartialThermalPortDCMachines
  "Partial thermal port of DC machines"
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortArmature
    "Heat port of armature"
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortCore
    "Heat port of (optional) core losses"
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortStrayLoad
    "Heat port of (optional) stray losses"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortFriction
    "Heat port of (optional) friction losses"
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortBrush
    "Heat port of (optional) brush losses"
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
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
Partial thermal port for DC machines
</html>"));
end PartialThermalPortDCMachines;
