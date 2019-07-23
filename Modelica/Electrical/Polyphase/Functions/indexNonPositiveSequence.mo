within Modelica.Electrical.Polyphase.Functions;
function indexNonPositiveSequence
  "Determines the indices of all non positive sequences"
  extends Modelica.Icons.Function;
  input Integer m=3 "Number of phases";
  output Integer ind[numberOfSymmetricBaseSystems(m)*(integer(m/
    numberOfSymmetricBaseSystems(m)) - 1)]
    "Indices of non positive sequences";
protected
  Integer nBase=numberOfSymmetricBaseSystems(m) "Number of base systems";
  Integer mBase=integer(m/nBase) "Number of phases of base system";
algorithm
  if mBase == 1 then
    ind := fill(0, 0);
  elseif mBase == 2 then
    for k in 1:nBase loop
      ind[k] := 2 + 2*(k - 1);
    end for;
  else
    for k in 1:nBase loop
      ind[(mBase - 1)*(k - 1) + 1:(mBase - 1)*k] := (2:mBase) + mBase*(k - 1)*ones(mBase - 1);
    end for;
  end if;
  annotation (Documentation(info="<html>
<p>
This function determines the indices of non-positive sequence of the symmetrical winding with m phases.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.PhaseOrientation\">User's guide</a> on symmetrical components and orientation.
</p>
</html>"));
end indexNonPositiveSequence;
