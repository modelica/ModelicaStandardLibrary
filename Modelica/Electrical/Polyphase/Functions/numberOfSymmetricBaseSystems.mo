within Modelica.Electrical.Polyphase.Functions;
function numberOfSymmetricBaseSystems
  "Determines the number of symmetric base systems of m phase symmetric system"
  extends Modelica.Icons.Function;
  input Integer m=3 "Number of phases";
  output Integer n "Number of symmetric base systems";
algorithm
  // Init number of base systems
  n := 1;
  if mod(m, 2) == 0 then
    // Even number of phases
    if m == 2 then
      // Special case two phase machine
      n := 1;
    else
      n := n*2*numberOfSymmetricBaseSystems(integer(m/2));
    end if;
  else
    // Odd number of phases
    n := 1;
  end if;
  annotation (Documentation(info="<html>
<p>
This function determines the number of base systems of the symmetrical winding with m phases.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.PhaseOrientation\">User's guide</a> on symmetrical components and orientation.
</p>
</html>"));
end numberOfSymmetricBaseSystems;
