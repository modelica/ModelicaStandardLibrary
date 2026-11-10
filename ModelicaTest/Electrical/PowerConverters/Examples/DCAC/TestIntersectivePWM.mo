within ModelicaTest.Electrical.PowerConverters.Examples.DCAC;
model TestIntersectivePWM "Test timing of intersectivePWM"
  extends Modelica.Icons.Example;
  parameter Real epsilon=1e-6 "Comparison threshold";
  parameter Modelica.Units.SI.Time tStart=0.1;
  Real carrier[3]=intersectivePWM.switch1.y "Carrier signal";
  Modelica.Electrical.PowerConverters.DCAC.Control.IntersectivePWM
    intersectivePWM(
    f=10,
    startTime=tStart,
    uMax=1,
    refType=Modelica.Electrical.PowerConverters.Types.ReferenceType.Sawtooth3)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Cosine cosine(amplitude=1, f=1)
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=1, f=2)
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
equation
  when time>tStart then
    assert(abs(carrier[1] - 0.0)<epsilon,
      "Timing of ItersectivePWM is wrong");
    assert(abs(carrier[2] + 2/3)<epsilon,
      "Timing of ItersectivePWM is wrong");
    assert(abs(carrier[3] - 2/3)<epsilon,
      "Timing of ItersectivePWM is wrong");
  end when;
  connect(cosine.y, intersectivePWM.u[1]) annotation (Line(points={{-29,20},{-20,
          20},{-20,-0.5},{-12,-0.5}}, color={0,0,127}));
  connect(sine.y, intersectivePWM.u[2]) annotation (Line(points={{-29,-20},{-20,
          -20},{-20,0.5},{-12,0.5}}, color={0,0,127}));
  annotation (experiment(
      StopTime=0.2,
      Interval=0.001,
      Tolerance=1e-06), TestCase(shouldPass = true,
      __ModelicaAssociation(Comparison(timeWindows={TimeWindow(0, 0.2)}))));
end TestIntersectivePWM;
