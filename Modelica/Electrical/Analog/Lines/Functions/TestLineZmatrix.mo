within Modelica.Electrical.Analog.Lines.Functions;
model TestLineZmatrix
  extends Modelica.Icons.Example;
  import Modelica.Utilities.*;
  parameter LineGeometry g(
    n=4,
    x={0,-3.048,3.048,-9.144},
    y={12.192,12.192,12.192,3.048},
    r=1e-3/2*{12.7,12.7,12.7,4.064},
    R1=1e-3*{0.348,0.348,0.348,1.802},
    k_s={0.287,0.287,0.287,0.779},
    f=60)    annotation (Placement(transformation(extent={{-10,-6},{10,14}})));

  String sC;
  Real Rcomp[div(g.n*(g.n + 1), 2)] "Compacted matrix";
  Real Xcomp[div(g.n*(g.n + 1), 2)] "Compacted matrix";

protected
  Integer k;
algorithm
  when initial() then
    (Rcomp,Xcomp) :=LineZmatrix(
      n=g.n,
      x=g.x,
      y=g.y,
      r=g.r,
      R1=g.R1,
      k_s=g.k_s,
      rho=g.rho,
      f=g.f);

    Streams.print("\n *****              Using LineZmatrix, RESULTS in ohm/km              *****");
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
<p>This model tests the Z matrix as computed with function <a href="modelica://Modelica.Electrical.Analog.Lines.Functions.LineZmatrix">LineZmatrix</a>, with the geometry of fig. 4.11 of [<a href="modelica://Modelica.Electrical.Analog.UsersGuide.References">EmtpTheoryBook</a>]. </p>
<p>The results are given textually in the log and show a good agreement with the reference.</p>
<p>This simulation runs correctly with both Dymola and OpenModelica. Computation result using Dymola 2020:</p>
<blockquote><pre>
*****              Using LineZmatrix, RESULTS in ohm/km              *****
*** (one row per matrix row; numbers should be intended right-aligned) ***
0.405445+j0.986077 0.0574443+j0.426468 0.0574443+j0.426468 0.058076+j0.316811 
0.405445+j0.986077 0.0574408+j0.374207 0.0580827+j0.329078 
0.405445+j0.986077 0.0580667+j0.304429 
1.86076+j0.995306 
... &quot;TestLineZmatrix.mat&quot; creating (simulation result file)
</pre></blockquote>
</html>", revisions="<html>
<p><i>July, 2023 </i> </p>
<p>Original implementation by Massimo Ceraolo of the University of Pisa </p>
</html>"),
    experiment(StopTime=0));
end TestLineZmatrix;
