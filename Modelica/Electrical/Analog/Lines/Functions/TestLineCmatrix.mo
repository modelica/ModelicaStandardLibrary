within Modelica.Electrical.Analog.Lines.Functions;
model TestLineCmatrix
  extends Modelica.Icons.Example;
  import Modelica.Utilities.*;

  parameter LineGeometry g(
    n=4,
    x={0,-3.048,3.048,-9.144},
    y={12.192,12.192,12.192,3.048},
    r=1e-3/2*{12.7,12.7,12.7,4.064},
    R1=1e-3*{0.348,0.348,0.348,1.802})
    annotation (Placement(transformation(extent={{-10,-6},{10,14}})));

  String sC;
  Real Ccomp[div(g.n*(g.n + 1), 2)] "Compacted matrix";
protected
  Integer k;
algorithm
  when initial() then
    Ccomp :=LineCmatrix(
      n=g.n,
      x=g.x,
      y=g.y,
      r=g.r);
    Streams.print("\n *****              Using LineCmatrix, RESULTS in nF/km               *****");
    Streams.print(  " *** (one row per matrix row; numbers should be intended right-aligned) ***");
    k:=0;
    for i in 1:g.n loop  //matrix row
      sC := "";
      for j in 1:g.n-i+1 loop  // matrix column
        k:=k+1;
        sC := sC + String(1e12*Ccomp[k]) + "  ";
      end for;
      Streams.print(sC);
    end for;
/*    
    Streams.print("\n *** Vector stream ***");
    for i in 1:div(g.n*(g.n + 1),2) loop 
      Streams.print(String(1e12*Ccomp[i]));
    end for;
*/
    end when;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=
           false, extent={{-60,-40},{60,40}})),
    Documentation(info="<html>
<p>This model tests the C matrix as computed with function LineCmatrix, with the geometry of fig. 4.11 of [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">EmtpTheoryBook</a>]. </p>
<p>The results are given textually in the log and show a good agreement with the reference.</p>
<p>This simulation runs correctly with both Dymola and OpenModelica. Computation result using Dymola 2020:<span style=\"font-family: Courier New;\"> </span></p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\"><pre>*****              Using LineCmatrix, RESULTS in nF/km               *****</pre></span></p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\">     *** (one row per matrix row; numbers should be intended right-aligned) ***</span> </p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\">7.57087&nbsp; -1.62658&nbsp; -1.63038&nbsp; -0.168826&nbsp; </span></p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\">7.30876&nbsp; -0.834876&nbsp; -0.275822&nbsp; </span></p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\">7.29987&nbsp; -0.118934&nbsp; </span></p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\">6.97273&nbsp; </span></p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\">... &quot;TestLineCmatrix.mat&quot; creating (simulation result file)</span> </p>
</html>", revisions="<html>
<li><em>May, 2021</em> 
        Massimo Ceraolo of the University of Pisa <br> 
        originally created</li> 
</html>"),
    experiment(StopTime=0));
end TestLineCmatrix;
