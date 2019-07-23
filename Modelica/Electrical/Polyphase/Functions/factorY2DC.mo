within Modelica.Electrical.Polyphase.Functions;
function factorY2DC "Calculates factor of DC-voltage from RMS Y-voltage"
  extends Modelica.Icons.Function;
  import Modelica.Constants.pi;
  input Integer m=3 "Number of phases";
  output Real y "Factor Yrms to DC";
protected
  parameter Integer mBasic=integer(m/
      Polyphase.Functions.numberOfSymmetricBaseSystems(
      m));
algorithm
  y := sqrt(2)*2*sin((mBasic - 1)/mBasic*pi/2)*sin(pi/(2*m))/(pi/(2*m));
end factorY2DC;
