within Modelica.Electrical.Batteries.Interfaces;
expandable connector StackBusArrays "Measurement signal bus for a stack, arranged as matrices"
  extends Modelica.Icons.SignalBus;
  parameter Integer Ns(final min = 1) = 1 "Number of series connected cells";
  parameter Integer Np(final min = 1) = 1 "Number of parallel connected cells";
  Modelica.SIunits.Voltage v[Ns, Np] "Cell voltages";
  Modelica.SIunits.Current i[Ns, Np] "Cell currents";
  Real soc[Ns, Np] "States of charge of cells";
  Modelica.SIunits.Power power[Ns, Np] "Cells powers";
  Modelica.SIunits.Power lossPower[Ns, Np] "Cells losses";
  Modelica.SIunits.Temperature T[Ns, Np] "Cells temperatures";
  annotation (Documentation(info="<html>
<p>
Measurement bus of a stack, containing arrays of measured values, arranged in a matrix <code>Ns</code> x <code>Np</code> 
the same way as the stack is built from cells.
</p>
</html>"));
end StackBusArrays;
