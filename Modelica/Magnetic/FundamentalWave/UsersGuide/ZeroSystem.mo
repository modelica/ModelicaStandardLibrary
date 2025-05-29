within Modelica.Magnetic.FundamentalWave.UsersGuide;
class ZeroSystem "Explanation of the zero system"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<p>
The polyphase winding relates the currents to the magnetic potential phasor of the fundamental wave and the derivative of the magnetic flux phasor of the fundamental wave to the voltages, 
taking the orientation of the phases into account. However, for number of phases <code>m &gt; 2</code> about the zero sequence system has to be decided. This happens in the zero inductance:
</p>
<p>
<code>i0 = sum(i)/m;</code><br>
<code>v0 = Lzero*der(i0);</code><br>
<code>v0</code> is included in all phases with the same phase shift.
</p>
<p>
This is equivalent to the zero inductor used in the 
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicInductionMachine\">machine model of <code>Modelica.Electrical.Machines</code></a> after applying 
space phasor transformation.
</p>
<p>
In some cases it could be desired to suppress the calculation of the zero system. This can be done in both machine models (<code>Modelica.Magnetic.FundamentalWave</code> and 
<code>Modelica.Electrical.Machines</code>) by setting the Boolean parameter <code>useZeroSystem = false</code> (which by default is <code>true</code>). 
This ensures that the zero current is equal to 0 and there is no need to calculate it:<br>
<code>i0 = 0;</code>
</p>
</html>"));
end ZeroSystem;
