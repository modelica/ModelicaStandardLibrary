within Modelica.Electrical.Polyphase.Functions;
function indexPositiveSequence
  "Determines the indices of all positive sequences"
  extends Modelica.Icons.Function;
  input Integer m=3 "Number of phases";
  output Integer ind[numberOfSymmetricBaseSystems(m)]
    "Number of symmetric base systems";
protected
  Integer n=numberOfSymmetricBaseSystems(m);
algorithm
  if n == 1 then
    ind[1] := 1;
  else
    ind := (0:n - 1)*integer(m/n) + ones(n);
  end if;
  annotation (Documentation(info="<html>
<p>
This function determines the indices of positive sequence of the symmetrical winding with m phases.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.PhaseOrientation\">User's guide</a> on symmetrical components and orientation.
</p>
</html>"));
end indexPositiveSequence;
