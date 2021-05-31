within Modelica.Electrical.Analog.Lines.Functions;
model TestM_OLineZ
  extends Modelica.Icons.Example;
  import Modelica.Utilities.*;
  parameter Real f=60;

  parameter Test_M_Oline.Functions.LineGeometry g(
    n=4,
    x={0,-3.048,3.048,-9.144},
    y={12.192,12.192,12.192,3.048},
    r=1e-3/2*{12.7,12.7,12.7,4.064},
    R1=1e-3*{0.348,0.348,0.348,1.802},
    k_s=0.7) annotation (Placement(transformation(extent={{-10,-6},{10,14}})));

  String sC;
//  Complex Zcomp[div(g.n*(g.n + 1), 2)] "Compacted matrix";
  Real Rcomp[div(g.n*(g.n + 1), 2)] "Compacted matrix";
  Real Xcomp[div(g.n*(g.n + 1), 2)] "Compacted matrix";

protected
  Integer k;
algorithm
  when initial() then
    (Rcomp,Xcomp) := Test_M_Oline.Functions.M_OLineZ(
      n=g.n,
      x=g.x,
      y=g.y,
      r=g.r,
      R1=g.R1,
      k_s=g.k_s,
      rho=g.rho,
      f=f);

    Streams.print("\n *****                 Using M_OLineZ, RESULTS in ohm/km              *****");
    Streams.print(  " *** (one row per matrix row; numbers should be intended right-aligned) ***");
    k:=0;
    for i in 1:g.n loop  //matrix row
      sC := "";
      for j in 1:g.n-i+1 loop  // matrix column
        k:=k+1;
        sC := sC + String(1000*Rcomp[k]) +"+j"+String(1000*Xcomp[k])+ "   ";
      end for;
      Streams.print(sC);
      end for;
  end when;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=
           false, extent={{-60,-40},{60,40}})),
    Documentation(info="<html>
<p>This model tests the Z matrix as computed with function M_OLineZ, with the geometry of fig. 4.11 of Theory Book. </p>
<p>The results are given textually in the log. They are not totally conform. Better conformity could be obtained using k_s=0.4 inside LineZ, which should be not correct, since [Ceraolo] says this value to be between 0.70 and 0.778.</p>
<p>This simulation runs correctly with Dymola, and OpenModelica. Computation result using Dymola 2020:<span style=\"font-family: Courier New;\"> </span></p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\">*** Using M_OLineZ, RESULTS in ohm/km ***</span> </p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\">*** (one row per matrix row; numbers should be intended right-aligned) ***</span> </p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\">0.405338+j0.918874 0.0573527+j0.427059 0.0573527+j0.427059 0.0588135+j0.396721 </span></p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\">0.405338+j0.918874 0.0573939+j0.376456 0.0587802+j0.403026 </span></p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\">0.405338+j0.918874 0.0588495+j0.391359 </span></p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\">1.86075+j1.00337 </span></p>
<p><span style=\"font-family: Courier New; font-size: 9pt;\">... &quot;TestM_OLineZ.mat&quot; creating (simulation result file)</span> </p>
<p>&nbsp; </p>
</html>"),
    experiment(StopTime=0, __Dymola_Algorithm="Dassl"));
end TestM_OLineZ;
