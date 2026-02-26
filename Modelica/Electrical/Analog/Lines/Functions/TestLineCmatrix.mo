within Modelica.Electrical.Analog.Lines.Functions;
model TestLineCmatrix
  extends Modelica.Icons.Example;
  import Modelica.Utilities.Streams.print;

  parameter LineGeometry g(
    n=4,
    x={0,-3.048,3.048,-9.144},
    y={12.192,12.192,12.192,3.048},
    r=1e-3/2*{12.7,12.7,12.7,4.064},
    R1=1e-3*{0.348,0.348,0.348,1.802})
    annotation (Placement(transformation(extent={{-10,-6},{10,14}})));

  String sC;
  Modelica.Units.SI.CapacitancePerUnitLength Ccomp[div(g.n*(g.n + 1), 2)] "Compacted matrix";
  Modelica.Units.SI.CapacitancePerUnitLength C[g.n,g.n] "Full C matrix";
protected
  Integer k;
algorithm
  when initial() then
    (Ccomp,C):=lineCmatrix(
      n=g.n,
      x=g.x,
      y=g.y,
      r=g.r);
    print("\n ***** Full C matrix from  lineCmatrix in nF/km *****");
    print(  " ***       (only half: matrix is symmetric)       ***");
    for i in 1:g.n loop  //matrix row
      sC := "";
      for j in 1:i loop  // matrix column
        sC := sC + String(1e12*C[i,j]) + "  ";
      end for;
      print(sC);
    end for;
    print("\n *****        matrix of capacitor capacitances from lineCmatrix in nF/km         *****");
    print(  " ***  (Cij is capacitance of capacitor between i and j to mime C-matrix behaviour  ***");
    k:=0;
    for i in 1:g.n loop  //matrix row
      sC := "";
      for j in 1:g.n-i+1 loop  // matrix column
        k:=k+1;
        sC := sC + String(1e12*Ccomp[k]) + "  ";
      end for;
      print(sC);
    end for;

    end when;
  annotation (
    Documentation(info="<html>
<p>This model tests the C matrix as computed with function lineCmatrix, with the geometry of fig. 4.11 of [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Theory Book</a>]. </p>
<p>The results are given textually in the log and show a good agreement with the results shown in [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Theory Book</a>].</p>
<p>The function computes both the C-matrix and the array of physical capacitances miming C-matrix behaviour (see documentation of lineCmatrix for details)</p>
<p>Expected output:</p>
<pre>
***** Full C matrix from lineCmatrix in nF/km *****
***     (only half: matrix is symmetric)        ***
7.57087
-1.62658 7.30876
-1.63038 -0.834876 7.29987
-0.168826 -0.275822 -0.118934 6.97273

*****       matrix of capacitor capacitances from lineCmatrix in nF/km        *****
*** (Cij is capacitance of capacitor between i and j to mime C-matrix behaviour ***
4.14508 1.62658 1.63038 0.168826
4.57148 0.834876 0.275822
4.71569 0.118934
6.40915
</pre>
</html>", revisions="<html>
<p><em>July, 2023</em> </p>
<p>Original implementation by Massimo Ceraolo of the University of Pisa </p>
</html>"),
    experiment(
      StopTime=0,
      __Dymola_Algorithm="Dassl"));
end TestLineCmatrix;
