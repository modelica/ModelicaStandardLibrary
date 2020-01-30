within Modelica.Electrical.Polyphase.Functions;
function factorY2D "Calculates factor Y voltage to polygon (delta) voltage"
  extends Modelica.Icons.Function;
  import Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems;
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
    else
      y := 2*sin(kPolygon*pi/mBasic);
    end if;
  end if;
  annotation (Documentation(info="<html>
<p>
Calculates line-to-line voltage from line-to-neutral voltage.
</p>
<h4>Note</h4>
<p>
For m&gt;3 phases, more than one variant exists for the choice of the line-to-line voltage.
If input kPolygon is not in the range of 1 &le; kPolygon &le; (mBasic - 1)/2, the function is evaluated for kPolygon = 1.
</p>
</html>"));
end factorY2D;
