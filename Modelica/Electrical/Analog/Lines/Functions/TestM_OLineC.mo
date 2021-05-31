within Modelica.Electrical.Analog.Lines.Functions;
model TestM_OLineC
  extends Modelica.Icons.Example;
  import Modelica.Utilities.*;

  parameter Test_M_Oline.Functions.LineGeometry g(
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
    Ccomp := Test_M_Oline.Functions.M_OLineC(
      n=g.n,
      x=g.x,
      y=g.y,
      r=g.r);
    Streams.print("\n *****               Using M_OLineC, RESULTS in nF/km                 *****");
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
<p>This model tests the C matrix as computed with lineX, with the geometry of fig. 4.11 of &quot;Theory Book&quot;. </p>
<p>The results are given textually in the log, and match very well those from &quot;Theory Book&quot;.</p>
<p>This simulation runs correctly with Both Dymola and OpenModelica. Computation result using Dymola 2020:<span style=\"font-family: Courier New;\"> </span></p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\">*****&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Using M_OLineC, RESULTS in nF/km *****</span> </p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\">*** (one row per matrix row; numbers should be intended right-aligned) ***</span> </p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\">7.57087&nbsp; -1.62658&nbsp; -1.63038&nbsp; -0.168826&nbsp; </span></p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\">7.30876&nbsp; -0.834876&nbsp; -0.275822&nbsp; </span></p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\">7.29987&nbsp; -0.118934&nbsp; </span></p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\">6.97273&nbsp; </span></p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\">... &quot;TestM_OLineC.mat&quot; creating (simulation result file)</span> </p>
</html>"),
    experiment(StopTime=0, __Dymola_Algorithm="Dassl"));
end TestM_OLineC;
