within Modelica.Electrical.Batteries.Interfaces;
expandable connector CellBus "Measurement signal bus for a single cell"
  extends Modelica.Icons.SignalSubBus;
  Modelica.SIunits.Voltage v "Cell voltage";
  Modelica.SIunits.Current i "Cell current";
  Real soc "State of charge of cell";
  Modelica.SIunits.Power p "Cell power";
  Modelica.SIunits.Power losses "Cell losses";
  Modelica.SIunits.Temperature T "Cell temperature";
  annotation (Documentation(info="<html>
<p>
Measurement bus of a single cell.
</p>
</html>"));
end CellBus;
