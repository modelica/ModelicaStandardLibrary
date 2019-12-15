within Modelica.Electrical.Polyphase.Functions;
function factorY2DC "Calculates factor of DC-voltage from RMS Y-voltage"
  extends Modelica.Icons.Function;
  import Modelica.Constants.pi;
  import Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems;
  input Integer m=3 "Number of phases";
  output Real y "Factor Yrms to DC";
protected
  parameter Integer mBasic=integer(m/numberOfSymmetricBaseSystems(m));
algorithm
  if mBasic==2 then
    y := 4/pi;
  else
    y := 2*sin((mBasic - 1)/2*pi/mBasic)*sqrt(2)*sin(pi/(2*m))/(pi/(2*m));
  end if;
end factorY2DC;
