within Modelica.Magnetic.FluxTubes.Utilities;
function getInterval
  extends Modelica.Icons.Function;
  input Real x "Scalar";
  input Real xD[:] "Array";
  output Integer k "Index";
protected
  Integer N=size(xD,1);
algorithm
  if x<xD[1] then
    k:=0;
  else
    k:=1;
    while k<=N-1 loop
      if x>=xD[k] and x<xD[k + 1] then
        break;
      end if;
      k:=k+1;
    end while;
  end if;
  annotation (Documentation(info="<html>
<p>
Determines the interval <code>k</code> that includes the value <code>x</code>: <code>xD[k]&le;x&lt;xD[k+1]</code>.
<code>x&lt;xD[1]</code> returns <code>k=0</code>.
<code>x&gt;xD[N]</code> returns <code>k=N</code> where <code>N=size(xD, 1)</code>.
</p>
</html>"));
end getInterval;
