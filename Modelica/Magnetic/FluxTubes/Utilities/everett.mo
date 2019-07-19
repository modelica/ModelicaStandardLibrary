within Modelica.Magnetic.FluxTubes.Utilities;
function everett "Everett function, see [YUY89]"
  extends Modelica.Icons.Function;
  import Modelica.Constants.pi;
  input SI.MagneticFieldStrength a_;
  input SI.MagneticFieldStrength b_;
  input FluxTubes.Material.HysteresisEverettParameter.BaseData p;
  input Boolean mirror "If true then J(a,b)=-J(b,a) else J(a,b)=0 for a<b";

  output SI.MagneticFluxDensity J "Magnetic polarisation";

protected
  SI.MagneticFieldStrength a;
  SI.MagneticFieldStrength b;
  SI.MagneticFieldStrength h1;
  SI.MagneticFieldStrength h2;
  SI.MagneticFieldStrength h3;
  SI.MagneticFieldStrength h4;
  constant SI.MagneticFluxDensity unitT=1;

algorithm
  if a_>=b_ or mirror then

    a :=if a_ > p.Hsat then p.Hsat elseif a_ < -p.Hsat then -p.Hsat else a_;
    b :=if b_ > p.Hsat then p.Hsat elseif b_ < -p.Hsat then -p.Hsat else b_;

    h1:=-b-p.Hc;
    h2:=a-p.Hc;
    h3:=-a-p.Hc;
    h4:=b-p.Hc;

    J:= unitT*(
        (p.M*p.r*(2/pi*atan(p.q*h1)+1)+(2*p.M*(1-p.r))/(1+1/2*(exp(-p.p1*h1)+exp(-p.p2*h1))))*
        (p.M*p.r*(2/pi*atan(p.q*h2)+1)+(2*p.M*(1-p.r))/(1+1/2*(exp(-p.p1*h2)+exp(-p.p2*h2))))-
        (p.M*p.r*(2/pi*atan(p.q*h3)+1)+(2*p.M*(1-p.r))/(1+1/2*(exp(-p.p1*h3)+exp(-p.p2*h3))))*
        (p.M*p.r*(2/pi*atan(p.q*h4)+1)+(2*p.M*(1-p.r))/(1+1/2*(exp(-p.p1*h4)+exp(-p.p2*h4)))));
  else
    J:=0;
  end if;
  annotation (Documentation(info="<html>
</html>"));
end everett;
