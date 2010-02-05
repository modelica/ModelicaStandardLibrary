within Modelica.Magnetic.FundamentalWave.Machines.Functions;
function symmetricWindingAngle "Winding angles of symmetric phase winding"

  import Modelica.Constants.pi;

  input Integer m "Number of phases";
  output Modelica.SIunits.Angle windingAngle[m] "Angle of wining axis";

algorithm
  if mod(m,2) == 0 then
    // Even number of phases
    for k in 1:integer(m/2) loop
      windingAngle[k] :=(k - 1)*4*pi/m;
      windingAngle[k+integer(m/2)] := windingAngle[k] + 2*pi/m;
    end for;
  else
    // Odd number of phases
    windingAngle :={(k - 1)*2*pi/m for k in 1:m};
  end if;
annotation (Documentation(info="<html>
<p>  
This function determines the winding angles of a symmetrical winding with <img src=\"../Images/Magnetic/FundamentalWave/m.png\"> phases. For an odd number of phases the difference of the windings angles of two adjacent phases is 
<img src=\"../Images/Magnetic/FundamentalWave/2pi_over_m.png\">. In case of an even number of phases aligned winding angles are not modeled since they do not add any information. Instead the <img src=\"../Images/Magnetic/FundamentalWave/m.png\"> windings are divided into two different groups. The first group refers to the indices <img src=\"../Images/Magnetic/FundamentalWave/k_le_m_over_2.png\">. The second group covers the indices <img src=\"../Images/Magnetic/FundamentalWave/k_gt_m_over_2.png\">. The difference of the windings angles of two adjacent phases - of both the first and the second group, respectively - is <img src=\"../Images/Magnetic/FundamentalWave/4pi_over_m.png\">. The phase shift of the two groups <img src=\"../Images/Magnetic/FundamentalWave/pi_over_2m.png\">.
</p>
</html>"));
end symmetricWindingAngle;
