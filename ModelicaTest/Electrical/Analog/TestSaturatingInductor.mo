within ModelicaTest.Electrical.Analog;
model TestSaturatingInductor
  "Simple demo to show the behaviour of SaturatingInductor component"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Inductance Lzer=10 "Inductance near current=0";
  parameter SI.Inductance Lnom=1 "Nominal inductance at Nominal current";
  parameter SI.Current Inom=1 "Nominal current";
  parameter SI.Inductance Linf=0.1 "Inductance at large currents";
  parameter SI.Current I=sqrt(2) "Source current (peak)";
  Modelica.Electrical.Analog.Sources.RampCurrent   rampCurrent(
    I=2*I,
    duration=1,
    offset=-I)
              annotation (Placement(transformation(
        origin={-20,50},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  Modelica.Electrical.Analog.Basic.SaturatingInductor
                                saturatingInductor(
    Inom=Inom,
    Lnom=Lnom/(2*pi),
    Lzer=Lzer/(2*pi),
    Linf=Linf/(2*pi),
    i(fixed=false)) annotation (Placement(transformation(
        origin={20,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(rampCurrent.p, ground.p)
    annotation (Line(points={{-20,40},{-20,30}},
                                               color={0,0,255}));
  connect(ground.p, saturatingInductor.n)
    annotation (Line(points={{-20,30},{20,30},{20,40}},color={0,0,255}));
  connect(rampCurrent.n, saturatingInductor.p) annotation (Line(points={{-20,60},
          {-20,70},{20,70},{20,60}},    color={0,0,255}));
  annotation (
    experiment(Interval=0.001, Tolerance=1e-05, StopTime=1),
    Documentation(info="<html>
<p>This simple circuit uses the saturating inductor which has an inductance dependent on current.</p>
<p>Plot <code>saturatingInductor.Psi</code> versus <code>saturatingInductor.i</code></p>
</html>"));
end TestSaturatingInductor;
