within ModelicaTest.Electrical.PowerConverters.Examples.DCAC;
model Test_SVPWM "Test sequence of SVPWM"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Real epsilon=1e-6 "Comparison threshold";
  parameter Real amplitude=2/3;
  parameter Real uMax=2/sqrt(3);
  parameter Integer N=6*12;
  parameter Real v0={0,0,0}*{2^0,2^1,2^2};
  parameter Real v1={1,0,0}*{2^0,2^1,2^2};
  parameter Real v2={1,1,0}*{2^0,2^1,2^2};
  parameter Real v3={0,1,0}*{2^0,2^1,2^2};
  parameter Real v4={0,1,1}*{2^0,2^1,2^2};
  parameter Real v5={0,0,1}*{2^0,2^1,2^2};
  parameter Real v6={1,0,1}*{2^0,2^1,2^2};
  parameter Real v7={1,1,1}*{2^0,2^1,2^2};
  parameter Real comparison[N]={
    v0,v1,v1,v2,v2,v7,v7,v2,v2,v1,v1,v0,
    v0,v3,v3,v2,v2,v7,v7,v2,v2,v3,v3,v0,
    v0,v3,v3,v4,v4,v7,v7,v4,v4,v3,v3,v0,
    v0,v5,v5,v4,v4,v7,v7,v4,v4,v5,v5,v0,
    v0,v5,v5,v6,v6,v7,v7,v6,v6,v5,v5,v0,
    v0,v1,v1,v6,v6,v7,v7,v6,v6,v1,v1,v0};
  Modelica.Electrical.PowerConverters.DCAC.Control.SVPWM
    svPWM(f=6, uMax=uMax)
     annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.Cosine cosine(amplitude=amplitude, f=1,
    phase=pi/6)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=amplitude, f=1,
    phase=pi/6)
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal[3]
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Math.Sum sum1(nin=3, k={2^0,2^1,2^2})
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Integer k(start=-1, fixed=true);
algorithm
  when sample(0.5/N, 1./N) then
    k:=mod(pre(k) + 1, N);
    assert(abs(sum1.y - comparison[k + 1])<epsilon, "Switching sequence wrong");
  end when;
equation
  connect(svPWM.fire_p, booleanToReal.u) annotation (Line(points={{-19,6},{-10,6},
          {-10,0},{-2,0}}, color={255,0,255}));
  connect(booleanToReal.y, sum1.u)
    annotation (Line(points={{21,0},{38,0}}, color={0,0,127}));
  connect(cosine.y, svPWM.u[1]) annotation (Line(points={{-59,20},{-50,20},{-50,
          -0.5},{-42,-0.5}}, color={0,0,127}));
  connect(sine.y, svPWM.u[2]) annotation (Line(points={{-59,-20},{-50,-20},{-50,
          0.5},{-42,0.5}}, color={0,0,127}));
  annotation (experiment(
      StopTime=2.0,
      Interval=0.001,
      Tolerance=1e-06), TestCase(shouldPass = true,
    __ModelicaAssociation(Comparison(timeWindows={TimeWindow(0, 1.0)}))),
    preferredView = "info",
    Documentation(info="<html>
<p>
The space phasor rotatets once per seconf, startin at &pi;6, and is sampled 6 times per second, just in the middle of the sextant. 
Converting the positive fire signal to a real (i.e. no.1 with weight 2<sup>o</sup>, no.2 with weight 2<sup>1</sup>, no.3 with weight 2<sup>2</sup>),
 we should get the following sequence:<br>
0-1-3-7-3-1-0<br>
0-2-3-7-3-2-0<br>
0-2-6-7-6-2-0<br>
0-4-6-7-6-4-0<br>
0-4-5-7-5-4-0<br>
0-1-5-7-5-1-0<br>
The exact time spans are deduced from the signal amplitude and the maximum space phasor. 
For maximum space phasor = 2/3 &sdot; signal amplitude &sdot; 2/&radic;3 and the time spans of 
the two active vectors and the zero vectors are nearly equal.
</p>
</html>"));
end Test_SVPWM;
