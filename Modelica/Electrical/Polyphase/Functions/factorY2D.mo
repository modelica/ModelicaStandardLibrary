within Modelica.Electrical.Polyphase.Functions;
function factorY2D "Calculates factor Y voltage to polygon (delta) voltage"
  extends Modelica.Icons.Function;
  import Modelica.Constants.pi;
  input Integer m=3 "Number of phases";
  output Real y "Factor Y to D";
protected
  parameter Integer mBasic=integer(m/
      Polyphase.Functions.numberOfSymmetricBaseSystems(
      m));
algorithm
  y := 2*sin(pi/mBasic);
end factorY2D;
