within ModelicaTest.Electrical.PowerConverters.Examples.DCAC;
model Test_SVPWM "Test sequence of SVPWM"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Real epsilon=1e-6 "Comparison threshold";
  parameter Integer comparison[24]=
    {1,3,3,1, 2,3,3,2, 2,6,6,2, 4,6,6,4, 4,5,5,4, 1,5,5,1};
  Modelica.Electrical.PowerConverters.DCAC.Control.SVPWM
    svPWM(f=6, uMax=0.999*2/sqrt(3))
     annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.Cosine cosine(amplitude=1, f=1,
    phase=pi/6)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=1, f=1,
    phase=pi/6)
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal[3]
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Math.Sum sum1(nin=3, k={1,2,4})
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Integer k(start=0, fixed=true);
algorithm
  when sample(0.5/24., 1./24.) then
    k:=pre(k) + 1;
    assert(abs(sum1.y - comparison[k])<epsilon, "Switching sequence wrong");
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
      StopTime=1.0,
      Interval=0.001,
      Tolerance=1e-06), TestCase(shouldPass = true,
    __ModelicaAssociation(Comparison(timeWindows={TimeWindow(0, 1.0)}))),
    preferredView = "info",
    Documentation(info="<html>
<p>
The space phasor rotatets once per seconf, startin at &pi;6, and is sampled 6 times per second, just in the middle of the sextant. 
Converting the positive fire signal to a real (.e. no.1 with weight <sup>o</sup>, no.2 with weight 2<sup>1</sup>, no.3 with weight 2<sup>2</sup>),
 we should get the following sequence:<br>
0-1-3-7-3-1-0<br>
0-2-3-7-3-2-0<br>
0-2-6-7-6-2-0<br>
0-4-6-7-6-4-0<br>
0-4-5-7-5-4-0<br>
0-1-5-7-5-1-0<br>
The exact time spans are deduced from the signal amplitude and the maximum space phasor. 
For maximum space phasor = signal amplitude &sdot; 2/&radic;3 the zero vectors (0 and 7) are omitted completely,
and the time spans for the two active vectors are equal. Note that the time spans are segmented into 2 equal parts, 
in the middle of each sequence the two parts of the second active vector falls together due to the missing zero vector,
</p>
</html>"));
end Test_SVPWM;
