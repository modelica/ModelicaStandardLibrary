within Modelica.Electrical.Analog.Examples;
model ShowSaturatingInductor
  "Simple demo to show behaviour of SaturatingInductor component"
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.Inductance Lzer=2 "Inductance near current=0";
  parameter Modelica.SIunits.Inductance Lnom=1
    "Nominal inductance at Nominal current";
  parameter Modelica.SIunits.Current Inom=1 "Nominal current";
  parameter Modelica.SIunits.Inductance Linf=0.5 "Inductance at large currents";
  parameter Modelica.SIunits.Voltage U=1.25 "Source voltage (peak)";
  parameter Modelica.SIunits.Frequency f=1/(2*Modelica.Constants.pi)
    "Source frequency";
  parameter Modelica.SIunits.Angle phase=Modelica.Constants.pi/2
    "Source voltage phase shift";
  //output Modelica.SIunits.Voltage v "Voltage drop over saturating inductor";
  //output Modelica.SIunits.Current i "Current across saturating inductor";
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1(
    V=U,
    phase=phase,
    freqHz=f)
    annotation (Placement(transformation(
        origin={-60,-6},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground Ground1
    annotation (Placement(transformation(extent={{-70,-36},{-50,-16}}, rotation=
           0)));
  Modelica.Electrical.Analog.Basic.SaturatingInductor SaturatingInductance1(
    Lzer=Lzer,
    Lnom=Lnom,
    Inom=Inom,
    Linf=Linf)
    annotation (Placement(transformation(
        origin={-20,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Basic.Inductor Inductance1(L=Lnom) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,0})));
equation
  //v=SaturatingInductance1.v;
  //i=SaturatingInductance1.i;
  connect(SineVoltage1.n, Ground1.p) annotation (Line(points={{-60,-16},{-60,
          -16}}, color={0,0,255}));
  connect(SineVoltage1.n, SaturatingInductance1.n) annotation (Line(points={{-60,-16},
          {-20,-16},{-20,-10}},       color={0,0,255}));
  connect(SaturatingInductance1.p, SineVoltage1.p) annotation (Line(points={{-20,10},
          {-20,20},{-60,20},{-60,4}},     color={0,0,255}));
  connect(Inductance1.p, SineVoltage1.p) annotation (Line(
      points={{20,10},{20,20},{-60,20},{-60,4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(Inductance1.n, SineVoltage1.n) annotation (Line(
      points={{20,-10},{20,-16},{-60,-16}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Text(
          extent={{-80,84},{70,38}},
          lineColor={0,0,255},
          textString="Show Saturating Inductor")}),
    experiment(StopTime=6.2832, Interval=0.01),
    Documentation(info="<html>
<p>This simple circuit uses the saturating inductor which has a changing inductivity.</p>
<p>This circuit should be simulated until 1 s. Compare <code>SaturatingInductance1.p.i</code> with <code>Inductance1.p.i</code> to see the difference between saturating and ideal inductor.</p>
</html>"));
end ShowSaturatingInductor;
