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
  Real C[g.n,g.n] "Full C matrix";
protected
  Integer k;
algorithm
  when initial() then
    (Ccomp,C):=LineCmatrix(
      n=g.n,
      x=g.x,
      y=g.y,
      r=g.r);
    Streams.print("\n ***** Full C matrix from  LineCmatrix in nF/km *****");
    Streams.print(  " ***       (only half: matrix is symmetric)       ***");
    for i in 1:g.n loop  //matrix row
      sC := "";
      for j in 1:i loop  // matrix column
        sC := sC + String(1e12*C[i,j]) + "  ";
      end for;
      Streams.print(sC);
    end for;
    Streams.print("\n *****        matrix of capacitor capacitances from LineCmatrix in nF/km         *****");
    Streams.print(  " ***   (Cij is capacitance of capacitor between i and j to mime C-matrix behaviour  ***");
    k:=0;
    for i in 1:g.n loop  //matrix row
      sC := "";
      for j in 1:g.n-i+1 loop  // matrix column
        k:=k+1;
        sC := sC + String(1e12*Ccomp[k]) + "  ";
      end for;
      Streams.print(sC);
    end for;

    end when;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=
           false, extent={{-60,-40},{60,40}})),
    Documentation(info="<html>
<p>This model tests the C matrix as computed with function <a href="modelica://Modelica.Electrical.Analog.Lines.Functions.LineCmatrix">LineCmatrix</a>, with the geometry of fig. 4.11 of [<a href="modelica://Modelica.Electrical.Analog.UsersGuide.References">EmtpTheoryBook</a>]. </p>
<p>The results are given textually in the log and show a good agreement with the eresults shown in EmtpTheoryBoos.</p>
<p>This simulation runs correctly with both Dymola and OpenModelica. </p>
<p>The function computes both the C-matrix and the array of phusical capcitances miming C-matrix behaviour (see docu of LineCmatrix for details)</p>
<p>Computation result using Dymola 2020:</p>
<blockquote><pre>
***** Full C matrix from LineCmatrix in nF/km *****
*** (only half: matrix is symmetric) ***
7.57087
-1.62658 7.30876
-1.63038 -0.834876 7.29987
-0.168826 -0.275822 -0.118934 6.97273

***** matrix of capacitor capacitances from LineCmatrix in nF/km *****
*** (Cij is capacitance of capacitor betwen i and j to mime C-matrix behaviour ***
4.14508 1.62658 1.63038 0.168826
4.57148 0.834876 0.275822
4.71569 0.118934
6.40915
</pre></blockquote>
</html>", revisions="<html>
<p><i>July, 2023 </i> </p>
<p>Original implementation by Massimo Ceraolo of the University of Pisa </p>
</html>"),
    experiment(StopTime=0));
end TestLineCmatrix;
