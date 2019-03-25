within Modelica.Electrical.Analog.Examples;
model GenerationOfFMUs
  "Example to demonstrate variants to generate FMUs (Functional Mock-up Units)"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine sine12(freqHz=2, amplitude=1)
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
  Modelica.Electrical.Analog.Examples.Utilities.DirectCapacitor
    directCapacitor1(C=1e-3)
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
  Modelica.Electrical.Analog.Examples.Utilities.InverseCapacitor
    inverseCapacitor1(C=2e-3)
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Modelica.Electrical.Analog.Examples.Utilities.Resistor resistor2(R=10)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor2a(v(start=0, fixed=true), C=1e-3)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,40})));
  Modelica.Electrical.Analog.Sources.SignalCurrent current2 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,40})));
  Modelica.Electrical.Analog.Basic.GeneralCurrentToVoltageAdaptor currentToVoltage2a(
      use_pder=false, use_fder=false)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor2b(v(fixed=true, start=0), C=2e-3)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,40})));
  Modelica.Electrical.Analog.Basic.GeneralCurrentToVoltageAdaptor currentToVoltage2b(
      use_pder=false, use_fder=false)
    annotation (Placement(transformation(extent={{70,30},{50,50}})));
  Modelica.Electrical.Analog.Basic.Ground ground2a
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Electrical.Analog.Basic.Ground ground3b
    annotation (Placement(transformation(extent={{60,10},{80,30}})));
  Modelica.Blocks.Sources.Sine sine34(freqHz=2, amplitude=1)
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Modelica.Electrical.Analog.Examples.Utilities.DirectInductor directInductor3(
      L=1e-3) annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
  Modelica.Electrical.Analog.Examples.Utilities.InverseInductor
    inverseInductor3(L=2e-3)
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage voltage4 annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-50,-60})));
  Modelica.Electrical.Analog.Basic.Ground ground4a annotation (
      Placement(transformation(extent={{-40,-90},{-20,-70}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor4a(i(fixed=true, start=0), L=1e-3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-30,-50})));
  Modelica.Electrical.Analog.Basic.GeneralVoltageToCurrentAdaptor voltageToCurrent4a(
      use_pder=false, use_fder=false)
    annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
  Modelica.Electrical.Analog.Examples.Utilities.Conductor conductor4(G=10)
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Modelica.Electrical.Analog.Basic.GeneralVoltageToCurrentAdaptor voltageToCurrent4b(
      use_pder=false, use_fder=false)
    annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor4b(i(fixed=true, start=0), L=2e-3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,-60})));
  Modelica.Electrical.Analog.Basic.Ground ground4b
    annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
equation
  connect(sine12.y, directCapacitor1.iDrive)
    annotation (Line(points={{-79,80},{-2,80}}, color={0,0,127}));
  connect(directCapacitor1.v, inverseCapacitor1.v)
    annotation (Line(points={{21,88},{38,88}}, color={0,0,127}));
  connect(directCapacitor1.dv, inverseCapacitor1.dv)
    annotation (Line(points={{21,83},{38,83}}, color={0,0,127}));
  connect(directCapacitor1.i, inverseCapacitor1.i)
    annotation (Line(points={{22,72},{39,72}}, color={0,0,127}));
  connect(sine12.y, current2.i) annotation (Line(points={{-79,80},{-70,
          80},{-70,40},{-62,40}}, color={0,0,127}));
  connect(current2.n, capacitor2a.p)
    annotation (Line(points={{-50,50},{-20,50}}, color={0,0,255}));
  connect(capacitor2a.p, currentToVoltage2a.pin_p) annotation (Line(points={{-20,
          50},{-10,50},{-10,48},{-2,48}}, color={0,0,255}));
  connect(capacitor2a.n, currentToVoltage2a.pin_n) annotation (Line(points={{-20,
          30},{-12,30},{-12,32},{-2,32}}, color={0,0,255}));
  connect(currentToVoltage2a.p,resistor2. v1)
    annotation (Line(points={{3,48},{18,48}}, color={0,0,127}));
  connect(currentToVoltage2a.f,resistor2. i1)
    annotation (Line(points={{3,32},{19,32}}, color={0,0,127}));
  connect(resistor2.v2, currentToVoltage2b.p)
    annotation (Line(points={{42,48},{57,48}}, color={0,0,127}));
  connect(resistor2.i2, currentToVoltage2b.f)
    annotation (Line(points={{41,32},{57,32}}, color={0,0,127}));
  connect(currentToVoltage2b.pin_p, capacitor2b.p) annotation (Line(points={{62,
          48},{70,48},{70,50},{80,50}}, color={0,0,255}));
  connect(current2.p, ground2a.p)
    annotation (Line(points={{-50,30},{-30,30}}, color={0,0,255}));
  connect(ground2a.p, capacitor2a.n)
    annotation (Line(points={{-30,30},{-20,30}}, color={0,0,255}));
  connect(currentToVoltage2b.pin_n, ground3b.p)
    annotation (Line(points={{62,32},{70,32},{70,30}}, color={0,0,255}));
  connect(ground3b.p, capacitor2b.n)
    annotation (Line(points={{70,30},{80,30}}, color={0,0,255}));
  connect(sine34.y, directInductor3.vDrive)
    annotation (Line(points={{-79,-20},{-2,-20}}, color={0,0,127}));
  connect(directInductor3.v, inverseInductor3.v)
    annotation (Line(points={{22,-12},{39,-12}}, color={0,0,127}));
  connect(directInductor3.di, inverseInductor3.di) annotation (Line(
        points={{21,-23},{30.5,-23},{30.5,-23},{38,-23}}, color={0,0,
          127}));
  connect(directInductor3.i, inverseInductor3.i)
    annotation (Line(points={{21,-28},{38,-28}}, color={0,0,127}));
  connect(inductor4a.n, voltageToCurrent4a.pin_p) annotation (Line(
        points={{-20,-50},{-10,-50},{-10,-52},{-2,-52}}, color={0,0,255}));
  connect(ground4a.p, voltageToCurrent4a.pin_n) annotation (Line(points=
         {{-30,-70},{-10,-70},{-10,-68},{-2,-68}}, color={0,0,255}));
  connect(voltageToCurrent4b.pin_p, inductor4b.p) annotation (Line(
        points={{62,-52},{70,-52},{70,-50},{80,-50}}, color={0,0,255}));
  connect(voltageToCurrent4b.pin_n, ground4b.p) annotation (Line(points=
         {{62,-68},{70,-68},{70,-70}}, color={0,0,255}));
  connect(ground4b.p, inductor4b.n) annotation (Line(points={{70,-70},{
          76,-70},{76,-70},{80,-70}}, color={0,0,255}));
  connect(sine34.y, voltage4.v) annotation (Line(points={{-79,-20},{-70,
          -20},{-70,-60},{-62,-60}}, color={0,0,127}));
  connect(voltageToCurrent4a.f, conductor4.i1)
    annotation (Line(points={{3,-68},{18,-68}}, color={0,0,127}));
  connect(voltageToCurrent4a.p, conductor4.v1)
    annotation (Line(points={{3,-52},{19,-52}}, color={0,0,127}));
  connect(conductor4.v2, voltageToCurrent4b.p)
    annotation (Line(points={{41,-52},{57,-52}}, color={0,0,127}));
  connect(conductor4.i2, voltageToCurrent4b.f)
    annotation (Line(points={{42,-68},{57,-68}}, color={0,0,127}));
  connect(voltage4.p, inductor4a.p)
    annotation (Line(points={{-50,-50},{-40,-50}}, color={0,0,255}));
  connect(ground4a.p, voltage4.n)
    annotation (Line(points={{-30,-70},{-50,-70}}, color={0,0,255}));
  annotation (experiment(StopTime=1, Interval=0.001), Documentation(info="<html>
<p>
This example demonstrates how to generate an input/output block (e.g. in form of an
FMU - <a href=\"https://www.fmi-standard.org\">Functional Mock-up Unit</a>) from various Electrical components.
The goal is to export such an input/output block from Modelica and import
it in another modeling environment. The essential issue is that before
exporting it must be known in which way the component is utilized in the
target environment. Depending on the target usage, different connector variables
need to be in the interface with either input or output causality.
Note, this example model can be used to test the FMU export/import of a Modelica tool.
Just export the components marked in the icons as \"toFMU\" as FMUs and import
them back. The models should then still work and give the same results as a
pure Modelica model.
</p>

<p>
<strong>Connecting two capacitors</strong><br>
The first part (DirectCapacitor, InverseCapacitor)
demonstrates how to export two capacitors and connect them
together in a target system. This requires that one of the capacitors
(here: DirectCapacitor)
is defined to have states and the voltage and
derivative of voltage are provided in the interface.
The other capacitor (here: InverseCapacitor) requires current according
to the provided input voltage and derivative of voltage.
</p>

<p>
<strong>Connecting a resistance element between two capacitors</strong><br>
The second part (Resistor2) demonstrates how to export a resistance element
that needs only voltages for its resistance law and connect this
resistance law in a target system between two capacitors.
</p>

<p>
<strong>Connecting two inductors</strong><br>
The third part (DirectInductor, InverseInductor)
demonstrates how to export two inductors and connect them
together in a target system. This requires that one of the inductors
(here: DirectInductor)
is defined to have states and the current and
derivative of current are provided in the interface.
The other inductor (here: InverseInductor) requires voltage according
to the provided input current and derivative of current.
</p>

<p>
<strong>Connecting a conductance element between two inductors</strong><br>
The fourth part (Conductor4) demonstrates how to export a conductance element
that needs only currents for its conductance law and connect this
conductance law in a target system between two inductors.
</p>
<p>
Bear in mind that separating physical components and connecting them via adaptor signals requires to place appropriate
<a href=\"modelica://Modelica.Electrical.Analog.Basic.Ground\">ground components</a> to define electric potential within the subcircuits.
</p>
</html>"));
end GenerationOfFMUs;
