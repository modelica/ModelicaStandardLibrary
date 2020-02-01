within Modelica.Electrical.Polyphase.Functions;
function symmetricOrientation
  "Orientations of the resulting fundamental wave field phasors"
  extends Modelica.Icons.Function;
  input Integer m "Number of phases";
  output SI.Angle orientation[m]
    "Orientation of the resulting fundamental wave field phasors";
  import Modelica.Constants.pi;
algorithm
  if mod(m, 2) == 0 then
    // Even number of phases
    if m == 2 then
      // Special case two phase machine
      orientation[1] := 0;
      orientation[2] := +pi/2;
    else
      orientation[1:integer(m/2)] := symmetricOrientation(integer(m/2));
      orientation[integer(m/2) + 1:m] := symmetricOrientation(integer(m/2))
         - fill(pi/m, integer(m/2));
    end if;
  else
    // Odd number of phases
    orientation := {(k - 1)*2*pi/m for k in 1:m};
  end if;
  annotation (Documentation(info="<html>
<p>
This function determines the orientation angles of the symmetrical winding with m phases.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.PhaseOrientation\">User's guide</a> on symmetrical components and orientation.
</p>
</html>"));
end symmetricOrientation;
