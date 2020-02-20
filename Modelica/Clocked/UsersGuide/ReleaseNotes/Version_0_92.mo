within Modelica.Clocked.UsersGuide.ReleaseNotes;
class Version_0_92 "Version 0.92 (Sept. 19, 2013)"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
<p>
Version 0.92 is backward compatible to version 0.91
</p>

<p>
Changes with respect to version 0.91:
</p>

<ul>
<li> The library uses the latest Modelica Standard Library (MSL) version 3.2.1 (but still works with version 3.2). </li>
<li> Added a couple of convenience source blocks for Real, Integer, and Boolean signals that are similar to the blocks
     found in the MSL, but have as output a clocked signal.</li>
<li> Added a couple of source blocks that are parametrized in terms of clock ticks rather than simulation time.</li>
<li> All new blocks are utilized in at least one test.</li>
</ul>
</html>"));
end Version_0_92;
