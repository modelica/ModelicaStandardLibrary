within Modelica.Electrical.Batteries.Interfaces;
expandable connector CellBus "Measurement signal bus for a single cell"
  extends Modelica.Icons.SignalSubBus;
  SI.Voltage v "Cell voltage";
  SI.Current i "Cell current";
  Real soc "State of charge of cell";
  SI.Power power "Cell power";
  SI.Power lossPower "Cell losses";
  SI.Temperature T "Cell temperature";
  annotation (Documentation(info="<html>
<p>
Measurement bus of a single cell.
</p>
</html>"));
end CellBus;
