within Modelica.Electrical.Batteries.Interfaces;
expandable connector StackBus "Measurement signal bus for a stack"
  extends Modelica.Icons.SignalBus;
  parameter Integer Ns=1 "Number of series connected cells";
  parameter Integer Np=1 "Number of parallel connected cells";
  CellBus cellBus[Ns,Np] "Cell busses";
  annotation (Documentation(info="<html>
<p>
Measurement bus of a stack, containing a <a href=\"modelica://Batteries.Interfaces.CellBus\">cellBus</a> per cell.
</p>
</html>"));
end StackBus;
