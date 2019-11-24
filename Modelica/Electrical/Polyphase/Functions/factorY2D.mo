within Modelica.Electrical.Polyphase.Functions;
function factorY2D "Calculates factor Y voltage to polygon (delta) voltage"
  extends Modelica.Icons.Function;
  import Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems;
  import Modelica.Utilities.Streams.print;
  import Modelica.Constants.pi;
  input Integer m=3 "Number of phases";
  input Integer kPolygon=1 "Alternative of polygon";
  output Real y "Factor Y to D";
protected
  parameter Integer mBasic=integer(m/numberOfSymmetricBaseSystems(m));
algorithm
  if mBasic==2 then
    y := sqrt(2);
  else
    if kPolygon<1 or kPolygon>(mBasic - 1)/2 then
      y := 2*sin(pi/mBasic);
      print("factorY2D: kPolygon out of range, evaluating for kPolygon=1");
    else
      y := 2*sin(kPolygon*pi/mBasic);
    end if;
  end if;
end factorY2D;
