within Modelica.Electrical.Analog.Examples;
model ShowSaturatingInductor
  "Simple demo to show behaviour of SaturatingInductor component"
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.Inductance Lzer=2 "Inductance near current=0";
  parameter Modelica.SIunits.Inductance Lnom=1
    "Nominal inductance at Nominal current";
  parameter Modelica.SIunits.Current Inom=1 "Nominal current";
  parameter Modelica.SIunits.Inductance Linf=0.5 "Inductance at large currents";
  parameter Modelica.SIunits.Voltage U=1.25 "source voltage (peak)";
  parameter Modelica.SIunits.Frequency f=1/(2*Modelica.Constants.pi)
    "source frequency";
  parameter Modelica.SIunits.Angle phase=Modelica.Constants.pi/2
    "source voltage phase shift";
  output Modelica.SIunits.Voltage v "voltage drop over saturating inductor";
  output Modelica.SIunits.Current i "current across saturating inductor";
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1(
    V=U,
    phase=phase,
    freqHz=f)
    annotation (Placement(transformation(
        origin={-20,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground Ground1
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}}, rotation=
           0)));
  Modelica.Electrical.Analog.Basic.SaturatingInductor SaturatingInductance1(
    Lzer=Lzer,
    Lnom=Lnom,
    Inom=Inom,
    Linf=Linf)
    annotation (Placement(transformation(
        origin={22,6},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  v=SaturatingInductance1.v;
  i=SaturatingInductance1.i;
  connect(SineVoltage1.n, Ground1.p) annotation (Line(points={{-20,-10},{-20,
          -10}}, color={0,0,255}));
  connect(SineVoltage1.n, SaturatingInductance1.n) annotation (Line(points={{-20,-10},
          {22,-10},{22,-4}},          color={0,0,255}));
  connect(SaturatingInductance1.p, SineVoltage1.p) annotation (Line(points={{22,16},
          {22,26},{-20,26},{-20,10}},     color={0,0,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Text(
          extent={{-80,84},{70,38}},
          lineColor={0,0,255},
          textString="Show Saturating Inductor")}),
    experiment(StopTime=6.2832, Interval=0.01),
    Documentation(info="<html>

</html>"));
end ShowSaturatingInductor;
