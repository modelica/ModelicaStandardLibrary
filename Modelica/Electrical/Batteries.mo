within Modelica.Electrical;
package Batteries "Simple battery models"
  extends Modelica.Icons.Package;
  package UsersGuide "User's Guide"
    extends Modelica.Icons.Information;
    class Concept "Concept of battery models"
      extends Modelica.Icons.Information;
      annotation (DocumentationClass=true, Documentation(info="<html>
<p>
The core of the battery models is a <a href=\"modelica://Modelica.Electrical.Analog.Sources.SignalVoltage\">signal voltage</a> 
controlled by a look-up table OCV (open circuit voltage) dependent on SOC (state of charge). <br>
However, other dependencies (e.g. on temperature) are not implemented yet.
</p>
<p>
Current flowing to or from the battery is measured and integrated, thus calculating the charge contained in the battery. 
The charge contained in the battery with respect to nominal charge <code>Qnom</code> gives SOC.<br>
The look-up table is parameterized for one cell, therefore input has to be scaled by <code>1/(Np*Qnom)</code>, 
and the output has to be scaled by <code>Ns*OCVmax</code>.
</p>
<p>
To model self-discharge, a conductor in parallel to the signal voltage and the current sensor is implemented. 
If self-discharge is specified as zero, the conductor is omitted.
</p>
<p>
A resistor <code>r0</code> is connected in series to the signal voltage, representing the inner resistance of the battery. 
The resistance can be specified as linearly dependent on temperature.
</p>
<p>
If <a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacks.CellRCStack\">CellRCStack</a> instead of 
<a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacks.CellStack\">CellStack</a> is choosen, 
RC-elements are connected in series to model the transient behaviour of the battery.<br>
Both models can be used for a single cell <code>Ns = Np = 1</code> as well as a stack built from identical cells.<nr>
Note that the total inner resistance <code>Ri</code> is the sum of the resistance of resistor <code>r0</code> and the sum of the resistances of the resistors of the RC-elements.
</p>
<p>
For details of parameterization, see <a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Parameterization\">UsersGuide.Parameterization</a>.
</p>
</html>"));
    end Concept;

    class Parameterization "Parameterization of battery models"
      extends Modelica.Icons.Information;
      annotation (DocumentationClass=true, Documentation(info="<html>
<p>
A <strong>stack</strong> is built from <code>Ns*Np</code> <strong>identical cells</strong>, 
where <code>Np</code> describes the number of parallel connected cells and <code>Ns</code> the number of series connected cells.<p>
The parameters of a stack built from <code>Np*Ns</code> cells are calculated as follows:
</p>
<table>
<tr><td>Description</td>             <td>Cell</td>         <td>Stack</td></tr>
<tr><td>Nominal OCV</td>             <td><code>OCVmax</td> <td><code>OCVmax*Ns</code></td></tr>
<tr><td>End of discharge voltage</td><td><code>OCVmmin</td><td><code>OCVmin*Ns</code></td></tr>
<tr><td>Capacity</td>                <td><code>Qnom</td>   <td><code>Qnom*Np</code></td></tr>
<tr><td>Inner resistance</td>        <td><code>Ri</td>     <td><code>Ri*Ns/Np</code></td></tr>
<tr><td>Short-circuit current</td>   <td><code>Isc</td>    <td><code>Isc*Np</code></td></tr>
</table>
<p>
The parameters of one cell are summarized n the parameter record <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.CellData\">cellData</a>.
</p>
<h4>Cell parameters</h4>
<p>
Dependency of OCV on SOC can be chosen either linear (<code>useLinearSOCDependency=true</code>) or based on a look-up table.<br>
By default, a linear OCV versus SOC characteristic is defined (like a capacitor), i.e. <code>OCV_SOC[:,2]=[SOCmin,OCVmin/OCVmax; SOCmax,1]</code>.<br>
The OCV versus SOC table has to be specified with 1st column = SOC values in ascending order, 2nd column = corresponding OCV values with respect to OCVmax.<br>
Be careful using parameter <code>smoothness</code> for table interpolation, check the resulting characteristic.<br>
Further dependencies of OVC (e.g. on temperature) are not taken into account, this would require a 2-deinemsonal table look-up.
</p>
<p>
Self-discharge is specified as discharge current <code>Idis</code> at <code>SOC = SOCmax</code>. From that values, a self-discharge conductance is calculated.<br>
If self-discharge should be neglected, set <code>Idis=0</code>.
</p>
<p>
The inner resistance <code>Ri</code> is either calculated from short circuit current <code>Isc</code>, or specified explicitely. 
Linear temperature dependency of inner resistance can be specified by reference temperature <code>T_ref</code> and temperature coefficient <code>alpha</code>: <br>
<code>R = R_ref*(1 + alpha*(T - T_ref))</code>.
</p>
<p>
The parameters of optionally used RC-elements are specified by an array of parameter records <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.RCData\">rcData</a>:
</p>
<ul>
<li><code>R</code> .. Resistance of RC-element</li>
<li><code>Tau</code> .. Time constant of RC-element; if <code>C</code> is specified, <code>Tau</code> can be neglected</li>
<li><code>C</code> .. Capacitance of RC-element; either specified explicitely or calculated from <code>tau</code> and <code>R</code></li>
</ul>
<p>
The size of the array of parameter records <code>rcData</code> determines the count of RC-elements instantiated.<br>
The parameters of these RC-elements are results of sophisticated measurements, e.g. cell impedance spectroscopy.<br>
Temperature dependency of the resistors is assumed to be the same as inner resistance <code>Ri</code>.
</p>
<h4>Typical parameters of a Li-Ion cell</h4>
<table>
<tr><td>End of charge voltage</td>   <td><code> </td>      <td>4.2 V</td></tr>
<tr><td>Nominal voltage</td>         <td><code> </td>      <td>3.6 V</td></tr>
<tr><td>End of discharge voltage</td><td><code>OCVmmin</td><td>2.5 V</td></tr>
</table>
<p>
Capacity (i.e. nominal charge) <code>Qnom</code>, inner resistance <code>Ri</code> and short-circuit current <code>Isc</code> depend on the cell size.<br>
Typical (estimated) values for a certain cell size are, as an example:
</p>
<table>
<tr><td>Capacity</td>             <td><code>Qnom</td><td>5 Ah</td></tr>
<tr><td>Inner resistance</td>     <td><code>Ri</td>  <td>3 m&Omega;</td></tr>
<tr><td>Short-circuit current</td><td><code>Isc</td> <td>1.2 kA</td></tr>
</table>
<p>
Self-discharge rate is typically 1%/month.
</p>
</html>"));
    end Parameterization;

    class Contact "Contact"
      extends Modelica.Icons.Contact;
      annotation (Documentation(info="<html>
<h4>Main authors</h4>

<p>
<strong>Anton Haumer</strong><br>
<a href=\"https://www.haumer.at\">Technical Consulting &amp; Electrical Engineering</a><br>
D-93049 Regensburg, Germany<br>
email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
</p>

<p>
<strong>Dr. Christian Kral</strong><br>
<a href=\"https://christiankral.net/\">Electric Machines, Drives and Systems</a><br>
A-1060 Vienna, Austria<br>
email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a>
</p>
</html>"));
    end Contact;

    class ReleaseNotes "Release Notes"
      extends Modelica.Icons.ReleaseNotes;
      annotation (Documentation(info="<html>

<h5>Version 1.1.0, 2019-07-17</h5>
<ul>
<li>Agreement on consistent naming</li>
</ul>

<h5>Version 1.0.0, 2019-07-14</h5>
<ul>
<li>First tagged version</li>
</ul>

</html>"));
    end ReleaseNotes;

    class References "References"
      extends Modelica.Icons.References;
      annotation (Documentation(info="<html>
<h4>References</h4>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <td>[Grimm2019]</td>
      <td>Alexander Grimm and Anton Haumer,
        <a href=\"https://modelica.org/events/modelica2019/proceedings/html/papers/Modelica2019paper2D1.pdf\">
        <em>Parameterization Of A Simplified Physical Battery Model</em></a>,
        13th International Modelica Conference 2019, Regensburg, Germany</td>
    </tr>

    <tr>
      <td>[Keil2012]</td>
      <td>Peter Keil and Andreas Jossen,
        <em>Aufbau und Parametrierung von Batteriemodellen</em></a>,
        19. Design&amp;Eelektronik-Entwicklerforum Batterien &amp; Ladekonzepte 2012, M&uuml;nchen, Germany</td>
    </tr>

    <tr>
      <td>[Einhorn11a]</td>
      <td>M. Einhorn, V. Conte, C, Kral, C. Niklas, H. Popp and J. Fleig,
        <a href=\"https://2011.international.conference.modelica.org/proceedings/pages/papers/17_4_ID_105_a_fv.pdf\">
        <em>A Modelica Library for Simulation of Electric Energy Storages</em></a>,
        8th International Modelica Conference 2011, Dresden, Germany</td>
    </tr>

    <tr>
      <td>[Kurzweil2015]</td>
      <td>Peter Kurzweil and Otto K. Dietlmeier,
        <em>Elektrochemische Speicher</em>, 
        Springer Vieweg 2015, ISBN 978-3-658-10899-1</td>
    </tr>

    <tr>
      <td>[Witzenhausen2017]</td>
      <td>Heiko Witzenhausen,
        <em>Elektrische Batteriespeichermodelle: Modellbildung, Parameteridentifikation und Modellreduktion</em>, 
        PhD thesis, Rheinisch-Westf&auml;lische Technische Hochschule Aachen, 2017</td>
    </tr>

    <tr>
      <td>[Schmidt2013]</td>
      <td>Jan Philipp Schmidt,
        <em>Verfahren zur Charakterisierung und Modellierung von Lithium-Ionen Zellen</em>, 
        PhD thesis, Karlsruher Institut f&uuml; Technologie, 2013</td>
    </tr>
</table>
</html>"));
    end References;
    annotation (DocumentationClass=true, Documentation(info="<html>
<p>
This library provides battery models, based on the electrical behaviour at the terminals.
</p>
<h4>Battery characteristics</h4>
<p>
All battery models rely on existing components like voltage source, resistor and capacitor models provided in the
<a href=\"modelica://Modelica.Electrical.Analog\">Analog</a> package of the Modelica Standard Library.<br>
Explore the <a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Concept\">concept</a> of the battery models as well as
<a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Parameterization\">parameterization</a>. 
Both are based on the <a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.References\">references</a>. 
</p>
<p>
Each battery is equipped with an optional heat port which can be enabled by the parameter <code>useHeatPort</code>; 
the heat flow of the battery heat port is determined by the sum of all heat flows of all resistive elements.<br>
This enables coupling with external thermal models to investigate thermal management issues. 
However, thermal models are not included yet.
</p>
</html>"));
  end UsersGuide;

  package Examples "Collection of battery examples"
    extends Modelica.Icons.ExamplesPackage;
    model BatteryDischargeCharge "Discharge and charge idealized battery"
      extends Modelica.Icons.Example;
      Utilities.PulseSeries pulseSeries(
        n1=7,
        T1=60,
        Tp1=60,
        n2=7,
        Tp=60,
        startTime=60)
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      parameter ParameterRecords.CellData cellData1(
        Qnom=18000,
        OCVmax=4.2,
        OCVmin=2.5,
        Isc=1200) annotation (Placement(transformation(extent={{60,20},{80,40}})));
      BatteryStacks.CellStack battery1(
        Ns=10,
        Np=2,
        cellData=cellData1,
        useHeatPort=false,
        SOC(fixed=true, start=0.95)) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={40,40})));
      Modelica.Electrical.Analog.Basic.Ground ground1
        annotation (Placement(transformation(extent={{10,0},{30,20}})));
      Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent1
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={0,40})));
      Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor1
        annotation (Placement(transformation(extent={{10,70},{30,90}})));
      Modelica.Blocks.Continuous.Integrator energy1(u(unit="W"), y(unit="J"))
        annotation (Placement(transformation(extent={{60,50},{80,70}})));
      parameter ParameterRecords.ExampleData cellData2(
        Qnom=18000,
        useLinearSOCDependency=false,
        Idis=0.1,
        Isc=1200,
        rcData={Batteries.ParameterRecords.RCData(R=0.2*cellData2.Ri, Tau=60),
            Batteries.ParameterRecords.RCData(R=0.1*cellData2.Ri, Tau=10)})
        annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
      BatteryStacks.CellRCStack battery2(
        Ns=10,
        Np=2,
        cellData=cellData2,
        useHeatPort=false,
        SOC(fixed=true, start=0.95)) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={40,-60})));
      Modelica.Electrical.Analog.Basic.Ground ground2
        annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
      Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent2
        annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={0,-60})));
      Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor2
        annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
      Modelica.Blocks.Continuous.Integrator energy2(u(unit="W"), y(unit="J"))
        annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
      Modelica.Blocks.Math.Gain gain(k=75)
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
    equation
      connect(battery1.n, ground1.p)
        annotation (Line(points={{40,30},{40,20},{20,20}}, color={0,0,255}));
      connect(signalCurrent1.n, ground1.p)
        annotation (Line(points={{0,30},{0,20},{20,20}}, color={0,0,255}));
      connect(signalCurrent1.p, powerSensor1.pc)
        annotation (Line(points={{0,50},{0,80},{10,80}}, color={0,0,255}));
      connect(powerSensor1.nc, battery1.p)
        annotation (Line(points={{30,80},{40,80},{40,50}}, color={0,0,255}));
      connect(powerSensor1.nv, ground1.p)
        annotation (Line(points={{20,70},{20,20}}, color={0,0,255}));
      connect(powerSensor1.pc, powerSensor1.pv)
        annotation (Line(points={{10,80},{10,90},{20,90}}, color={0,0,255}));
      connect(powerSensor1.power, energy1.u)
        annotation (Line(points={{10,69},{10,60},{58,60}}, color={0,0,127}));
      connect(battery2.n,ground2. p)
        annotation (Line(points={{40,-70},{40,-80},{20,-80}},color={0,0,255}));
      connect(signalCurrent2.n,ground2. p)
        annotation (Line(points={{0,-70},{0,-80},{20,-80}},    color={0,0,255}));
      connect(signalCurrent2.p,powerSensor2. pc)
        annotation (Line(points={{0,-50},{0,-20},{10,-20}},      color={0,0,255}));
      connect(powerSensor2.nc,battery2. p)
        annotation (Line(points={{30,-20},{40,-20},{40,-50}}, color={0,0,255}));
      connect(powerSensor2.nv,ground2. p)
        annotation (Line(points={{20,-30},{20,-80}},
                                                   color={0,0,255}));
      connect(powerSensor2.pc,powerSensor2. pv)
        annotation (Line(points={{10,-20},{10,-10},{20,-10}},  color={0,0,255}));
      connect(powerSensor2.power,energy2. u)
        annotation (Line(points={{10,-31},{10,-40},{58,-40}},   color={0,0,127}));
      connect(gain.y, signalCurrent1.i) annotation (Line(points={{-29,0},{-20,0},
              {-20,40},{-12,40}}, color={0,0,127}));
      connect(gain.y,signalCurrent2. i) annotation (Line(points={{-29,0},{-20,0},
              {-20,-60},{-12,-60}}, color={0,0,127}));
      connect(pulseSeries.y, gain.u)
        annotation (Line(points={{-59,0},{-52,0}}, color={0,0,127}));
      annotation (experiment(
          StopTime=3600,
          Interval=0.1,
          Tolerance=1e-06),
        Documentation(info="<html>
<p>Two batteries with a nominal charge of 10 Ah starting with an initial SOC = 95 % are compared:</p>
<ul>
<li><code>battery1</code> is a battery OCV linearly dependent on SOC, without self-discharge and not comprising RC-elements.</li>
<li><code>battery2</code> is a battery OCV dependency on SOC is specified by a table, with self-discharge and including RC-elements.</li>
</ul>
<p>
Two <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.CellData\">parameter records</a> <code>cellData1</code> and <code>cellData2</code> are used to parameterize the battery models.
</p>
<p>
First the batteries are discharged with 7 current pulses of 50 A for 1 minute, and breaks between the pulses of 1 minute, ending at SOC = 5 %.<br>
Subsequently, the batteries are charged again with 7 current pulses of 50 A for 1 minute, and breaks between the pulses of 1 minute, ending at SOC = 95 % again.<br>
In the end, the batteries are in no-load condition to reveal self-discharge effects.
Note that self-discharge of <code>battery2</code> is set to an unrealistic high value, to show self-discharge within a rather short time span.<br>
The parameters of the RC-elements of <code>battery2</code> are set to estimated values, just to demonstrate the effects.
</p>
<p>Simulate and plot terminal voltage <code>battery1.v</code> and <code>battery2.v</code> as well as state of charge <code>battery1.SOC</code> and <code>battery2.SOC</code>.<p>
<p>
Plotting <code>energy1.y</code> and <code>energy2.y</code>, it is remarkable that first energy is delivered by the battery, 
but then due to the losses more energy is consumed to recharge the battery.
</p>
</html>"));
    end BatteryDischargeCharge;

    model SuperCapDischargeCharge "Discharge and charge idealized supercap"
      extends Modelica.Icons.Example;
      Utilities.PulseSeries pulseSeries(
        n1=5,
        T1=10,
        Tp1=10,
        n2=5,
        Tp=10,
        startTime=10)
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      BatteryStacks.SuperCap superCap(
        Vnom=48,
        C=500,
        Rs=0.002,
        Idis=0.05,
        useHeatPort=false) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={40,0})));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
      Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={0,0})));
      Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor
        annotation (Placement(transformation(extent={{10,30},{30,50}})));
      Modelica.Blocks.Continuous.Integrator energy(u(unit="W"), y(unit="J"))
        annotation (Placement(transformation(extent={{60,10},{80,30}})));
      Modelica.Blocks.Math.Gain gain(k=300)
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
    equation
      connect(superCap.n, ground.p) annotation (Line(points={{40,-10},{40,-20},
              {20,-20}}, color={0,0,255}));
      connect(signalCurrent.n, ground.p)
        annotation (Line(points={{0,-10},{0,-20},{20,-20}}, color={0,0,255}));
      connect(signalCurrent.p, powerSensor.pc)
        annotation (Line(points={{0,10},{0,40},{10,40}}, color={0,0,255}));
      connect(powerSensor.nc, superCap.p)
        annotation (Line(points={{30,40},{40,40},{40,10}}, color={0,0,255}));
      connect(powerSensor.nv, ground.p)
        annotation (Line(points={{20,30},{20,-20}}, color={0,0,255}));
      connect(powerSensor.pc, powerSensor.pv)
        annotation (Line(points={{10,40},{10,50},{20,50}}, color={0,0,255}));
      connect(powerSensor.power, energy.u)
        annotation (Line(points={{10,29},{10,20},{58,20}}, color={0,0,127}));
      connect(gain.y, signalCurrent.i) annotation (Line(points={{-29,0},{-12,0},
              {-12,6.66134e-16}}, color={0,0,127}));
      connect(pulseSeries.y, gain.u)
        annotation (Line(points={{-59,0},{-52,0}}, color={0,0,127}));
      annotation (experiment(
          StopTime=720,
          Interval=0.01,
          Tolerance=1e-06),
        Documentation(info="<html>
<p>A supercap with a capacitance of 500 F, starting initially at nominal voltage 48 V,
is discharged with 5 current pulses of 240 A for 10 seconds, and breaks between the pulses of 10 seconds.
Subsequently, the supercap is charged again with 5 current pulses of 240 A for 10 seconds, and breaks between the pulses of 10 seconds.
In the end, the supercap is in no-load condition to reveal self-discharge effects.
<p>
Note that self-discharge is set to an unrealistic high value, to show self-discharge within a rather short time span.<br>
The other parameters of the supercap is set to estimated but realistic values:
</p>
<ul>
<li><code>C = 500 F</code></li>
<li><code>Vnom = 48 V</code></li>
<li><code>Qnom = C*Vnom = 24,000 As</code></li>
<li><code>Ri = 2 m&Omega;</code></li>
</ul>
<p>Simulate and plot terminal voltage <code>supercap.v</code>.<p>
<p>
Plotting <code>energy.y</code>, it is remarkable that first energy is delivered by the supercap, 
but then due to the losses more energy is consumed to recharge the supercap.
</p>
</html>"));
    end SuperCapDischargeCharge;

    model CCCVcharging
      "Charge a battery with constant current - constant voltage characteristic"
      extends Modelica.Icons.Example;
      parameter ParameterRecords.ExampleData cellData(
        Qnom=18000,
        useLinearSOCDependency=false,
        Isc=1200,
        Idis=0.001,
        rcData={Batteries.ParameterRecords.RCData(R=0.2*cellData.Ri, Tau=60),
            Batteries.ParameterRecords.RCData(R=0.1*cellData.Ri, Tau=10)})
        annotation (Placement(transformation(extent={{20,-20},{40,0}})));
      BatteryStacks.CellRCStack battery(
        Ns=10,
        Np=2,
        cellData=cellData,
        useHeatPort=false,
        SOC(fixed=true, start=0.1)) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={0,0})));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
      Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor
        annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
      Modelica.Blocks.Continuous.Integrator energy(u(unit="W"), y(unit="J"))
        annotation (Placement(transformation(extent={{20,10},{40,30}})));
      Utilities.CCCVcharger cccvCharger(I=50, Vend=42) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-50,0})));
    equation
      connect(battery.n, ground.p)
        annotation (Line(points={{0,-10},{0,-20},{-20,-20}}, color={0,0,255}));
      connect(powerSensor.nc, battery.p)
        annotation (Line(points={{-10,40},{0,40},{0,10}}, color={0,0,255}));
      connect(powerSensor.nv, ground.p)
        annotation (Line(points={{-20,30},{-20,-20}}, color={0,0,255}));
      connect(powerSensor.pc, powerSensor.pv) annotation (Line(points={{-30,40},
              {-30,50},{-20,50}}, color={0,0,255}));
      connect(powerSensor.power, energy.u)
        annotation (Line(points={{-30,29},{-30,20},{18,20}}, color={0,0,127}));
      connect(powerSensor.pc, cccvCharger.p) annotation (Line(points={{-30,40},
              {-50,40},{-50,10}}, color={0,0,255}));
      connect(ground.p, cccvCharger.n) annotation (Line(points={{-20,-20},{-50,
              -20},{-50,-10}}, color={0,0,255}));
      annotation (experiment(
          StopTime=1200,
          Interval=0.1,
          Tolerance=1e-06),
        Documentation(info="<html>
<p>
A battery depleted to <code>SOC = 0.1</code> is recharged with a CC-CV charger. 
Charging current in CC mode is 5C which means the battery is theoretically nearly fulled charged after <code>0.9*3600 s/5 = 648 s</code> and the charger switches to CV mode.
</p>
</html>"));
    end CCCVcharging;
    annotation (Documentation(info="<html>
<p>
Collection of examples demonstrating the usage of the <a href=\"modelica://Modelica.Electrical.Batteries.SimpleBatteries\">battery models</a>.
</p>
</html>"));
  end Examples;

  package BatteryStacks "Battery stacks built from cells"
    extends Modelica.Icons.Package;
    model CellStack
      "Battery with open-circuit voltage dependent on state of charge, self-discharge and inner resistance"
      extends BaseClasses.BaseCellStack(r0(final R=Ns*cellData.Ri/Np));
    equation
      connect(r0.n, n)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      annotation (Documentation(info="<html>
<p>
The battery is modeled by open-circuit voltage (OCV) dependent on state of charge (SOC), self-discharge and inner resistance, 
as implemented in partial <a href=\"modelica://Modelica.Electrical.Batteries.BaseClasses.BaseCellStack\">BaseCellStack</a>.
</p>
<p>
This model can be used for a single cell <code>Ns = Np = 1</code> as well as a stack built from identical cells.
</p>
<p>
For details, see <a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Concept\">concept</a> and <a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Parameterization\">parameterization</a>.
</p>
<h4>Note:</h4>
<p>
Parameter record array <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.RCData\">rcData</a> contained in 
parameter record <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.CellData\">cellData</a> is neglected.
</p>
</html>"));
    end CellStack;

    model CellRCStack
      "Battery with open-circuit voltage dependent on state of charge, self-discharge, inner resistance and a series of RC-elements"
      extends BaseClasses.BaseCellStack(r0(final R=Ns*cellData.R0/Np));
      Modelica.Electrical.Analog.Basic.Resistor resistor[cellData.nRC](
        final R=Ns*cellData.rcData.R/Np,
        each final T_ref=cellData.T_ref,
        each final alpha=cellData.alpha,
        each final useHeatPort=true)
        annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
      Modelica.Electrical.Analog.Basic.Capacitor capacitor[cellData.nRC](each v(
            fixed=true, each start=0), final C=Np*cellData.rcData.C/Ns)
        annotation (Placement(transformation(extent={{30,30},{50,10}})));
    equation
      assert(cellData.R0 > 0, "Ri has to be greater than sum(rcParameters.R)");
      assert(cellData.rcData[1].C > 0, "Parameters of RC-elements undefined!");
      //connect the RC-elements
      connect(resistor[1].p, r0.n)
        annotation (Line(points={{30,-20},{30,0},{10,0}},color={0,0,255}));
      for k in 1:cellData.nRC loop
        connect(capacitor[k].p, resistor[k].p)
          annotation (Line(points={{30,20},{30,-20}}, color={0,0,255}));
        connect(capacitor[k].n, resistor[k].n)
          annotation (Line(points={{50,20},{50,-20}},          color={0,0,255}));
        connect(internalHeatPort, resistor[k].heatPort)
          annotation (Line(points={{0,-80},{0,-40},{40,-40},{40,-30}}, color={191,0,0}));
        if k < cellData.nRC then
          connect(resistor[k].n, resistor[k + 1].p);
        end if;
      end for;
      connect(resistor[cellData.nRC].n, n)
        annotation (Line(points={{50,-20},{50,0},{100,0}},color={0,0,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Rectangle(
              extent={{-20,-20},{20,-6}},
              lineColor={238,46,47},
              lineThickness=0.5),
            Line(
              points={{-6,0},{-6,20}},
              color={238,46,47},
              thickness=0.5),
            Line(
              points={{6,0},{6,20}},
              color={238,46,47},
              thickness=0.5),
            Line(
              points={{-6,10},{-32,10},{-32,-14},{-20,-14}},
              color={238,46,47},
              thickness=0.5),
            Line(
              points={{6,10},{32,10},{32,-14},{20,-14}},
              color={238,46,47},
              thickness=0.5),
            Line(
              points={{-40,0},{-32,0}},
              color={238,46,47},
              thickness=0.5),
            Line(
              points={{32,0},{40,0}},
              color={238,46,47},
              thickness=0.5)}),
        Documentation(info="<html>
<p>
Extends the model <a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacks.CellStack\">CellStack</a> by a series of RC-elements, describing the transient behaviour of the battery.
</p>
<p>
This model can be used for a single cell <code>Ns = Np = 1</code> as well as a stack built from identical cells.
</p>
<p>
For details, see <a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Concept\">concept</a> and <a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Parameterization\">parameterization</a>.
</p>
<h4>Note:</h4>
<p>
Parameter record array <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.RCData\">rcData</a> contained in 
parameter record <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.CellData\">cellData</a> has to be specified.
</p>
<p>
The total inner resistance is the sum of the resistance of resistor <code>r0</code> and the sum of the resistances of the resistors of the RC-elements.
</p>
</html>"));
    end CellRCStack;

    model SuperCap "Simple model of a supercapacitor"
      extends Modelica.Electrical.Analog.Interfaces.TwoPin;
      Modelica.SIunits.Current i = p.i "Current into the supercap";
      parameter Modelica.SIunits.Voltage Vnom "Nominal voltage";
      parameter Modelica.SIunits.Voltage V0=Vnom "Initial voltage";
      parameter Modelica.SIunits.Capacitance C "Capacitance";
      parameter Modelica.SIunits.ElectricCharge Qnom=C*Vnom "Nominal charge";
      parameter Modelica.SIunits.Resistance Rs "Series resistance";
      parameter Modelica.SIunits.Temperature T_ref=293.15 "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha=0 "Temperature coefficient of resistance";
      parameter Modelica.SIunits.Current Idis=0 "Self-discharge current at nominal voltage"
        annotation(Evaluate=true);
      extends Modelica.Electrical.Analog.Interfaces.PartialConditionalHeatPort;
      Modelica.Electrical.Analog.Basic.Resistor resistor(
        final R=Rs,
        final T_ref=T_ref,
        final alpha=alpha,
        final useHeatPort=true)
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      Modelica.Electrical.Analog.Basic.Conductor conductor(
        final G=Idis/Vnom,
        T_ref=293.15,
        final useHeatPort=true)
        annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
      Modelica.Electrical.Analog.Basic.Capacitor capacitor(v(start=V0, fixed=true), final C=C)
        annotation (Placement(transformation(extent={{30,-10},{50,10}})));
    equation
      connect(p, resistor.p)
        annotation (Line(points={{-100,0},{-50,0}}, color={0,0,255}));
      connect(resistor.n, capacitor.p)
        annotation (Line(points={{-30,0},{30,0}}, color={0,0,255}));
      connect(capacitor.n, n)
        annotation (Line(points={{50,0},{100,0}}, color={0,0,255}));
      connect(capacitor.p, conductor.p)
        annotation (Line(points={{30,0},{30,-30},{30,-30}}, color={0,0,255}));
      connect(capacitor.n, conductor.n)
        annotation (Line(points={{50,0},{50,-30}}, color={0,0,255}));
      connect(internalHeatPort, conductor.heatPort) annotation (Line(points={{0,-80},
              {0,-60},{40,-60},{40,-40}}, color={191,0,0}));
      connect(internalHeatPort, resistor.heatPort) annotation (Line(points={{0,-80},
              {0,-60},{-40,-60},{-40,-10}}, color={191,0,0}));
      annotation (Icon(graphics={
            Text(
              extent={{-150,70},{150,110}},
              textColor={0,0,255},
              textString="%name"),
            Text(
              extent={{-150,-110},{150,-70}},
              textColor={0,0,0},
              textString="%C"),
            Rectangle(
              extent={{-20,60},{-10,-60}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{10,60},{20,-60}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-20,0}}, color={0,0,255}),
            Line(points={{20,0},{90,0}}, color={0,0,255})}), Documentation(info="<html>
<p>
This is a simple model of a supercapacitor, comprising:
</p>
<ul>
<li>an ideal capacitance</li>
<li>a series resistance</li>
<li>a self-discharge conductor</li>
</ul>
<h4>Note:</h4>
<p>
There is no limit included against too high charging and too low discharging or even charging in the opposite direction.
</p>
</html>"));
    end SuperCap;
    annotation (Documentation(info="<html>
<p>Battery models, either used for single cells or for stacks built from identical cells</p>
</html>"), Icon(graphics={
          Rectangle(extent={{-13,20},{13,-20}}, lineColor={95,95,95},
            fillColor={215,215,215},
            fillPattern=FillPattern.HorizontalCylinder,
            origin={0,73},
            rotation=90),
          Rectangle(extent={{-70,50},{70,-50}}, lineColor={95,95,95},
            fillColor={215,215,215},
            fillPattern=FillPattern.HorizontalCylinder,
            origin={-7.10543e-15,-10},
            rotation=90)}));
  end BatteryStacks;

  package ParameterRecords "Parameter records for batteries"
    extends Modelica.Icons.RecordsPackage;
    record CellData "Parameters of a battery cell"
      extends Modelica.Icons.Record;
      parameter Modelica.SIunits.ElectricCharge Qnom(displayUnit="Ah")
        "Nominal (maximum) charge";
      parameter Boolean useLinearSOCDependency=true
        "Use a linear SOC dependent OCV, otherwise table based"
        annotation(Dialog(group="OCV versus SOC"));
      parameter Modelica.SIunits.Voltage OCVmax(final min=0) "OCV at SOC = SOCmax"
        annotation(Dialog(group="OCV versus SOC"));
      parameter Modelica.SIunits.Voltage OCVmin(final min=0, start=0) "OCV at SOC = SOCmin"
        annotation(Dialog(group="OCV versus SOC", enable=useLinearSOCDependency));
      parameter Real SOCmax(final max=1)=1 "Max. state of charge"
        annotation(Dialog(group="OCV versus SOC"));
      parameter Real SOCmin(final min=0)=0 "Min. state of charge"
        annotation(Dialog(group="OCV versus SOC"));
      final parameter Real LinearOCV_SOC[2,2]=[SOCmin,OCVmin/OCVmax; SOCmax,1]
        "Linear SOC dependent OV"
        annotation(Dialog(group="OCV versus SOC"));
      parameter Real OCV_SOC[:,2]=[SOCmin,OCVmin/OCVmax; SOCmax,1] "OCV/OCVmax versus SOC table"
        annotation(Dialog(group="OCV versus SOC", enable=not useLinearSOCDependency));
      parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
        "Smoothness of table interpolation"
        annotation(Dialog(group="OCV versus SOC", enable=not useLinearSOCDependency));
      parameter Modelica.SIunits.Current Isc "Short-circuit current at SOC = SOCmax";
      parameter Modelica.SIunits.Resistance Ri=OCVmax/Isc "Total inner resistance";
      parameter Modelica.SIunits.Temperature T_ref=293.15 "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha=0 "Temperature coefficient of resistance";
      parameter Modelica.SIunits.Current Idis=0 "Self-discharge current at SOC = SOCmax"
        annotation(Evaluate=true);
      parameter RCData rcData[:]={RCData(R=1e-6*Ri,Tau=0)}
        annotation (Dialog(group="Optional RC-elements"),
          Placement(transformation(extent={{-10,0},{10,20}})));
      final parameter Integer nRC=size(rcData, 1) "Number of RC-elements"
        annotation (Dialog(group="Optional RC-elements"), Evaluate=true);
      parameter Modelica.SIunits.Resistance R0=Ri - sum(rcData.R)
        "Inner resistance without parallel C"
        annotation(Dialog(group="Optional RC-elements"));
      annotation(defaultComponentPrefixes="parameter", Documentation(info="<html>
<p>Collects parameters of battery cells:</p>
<ul>
<li>Nominal charge</li>
<li>OCV versus SOC characteristic</li>
<li>Short-circuit current; used to calculate inner resistance, can be neglected if inner resistance is specified explicitely</li>
<li>Inner resistance; either calculated from short circuit current, or specified explicitely</li>
<li>array of records <code>rcData</code> for battery models comprising RC-elements<li>
</ul>
<h4>Note:</h4>
<p>
If <code>useLinearSOCDependency=true</code>, the OCV versus SOC table is built up internally from <code>OCVmax, OCVmin, SOCmax, SOCmin</code>.<br>
Otherwise, the OCV versus SOC table has to be specified: 1st column = SOC values in ascending order, 2nd column = corresponding OCV values with respect to OCVmax.
</p>
<p>
In a battery model not comprising RC-elements, parameter array <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.RCData\">rcData</a> can be ignored; it is set to a default value.<br>
For a battery model including RC-elements, the size of the array <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.RCData\">rcData</a> defines the count of used RC-elements 
as well as the parameters of these.
</p>
<p>
If utilizing the parameter array <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.RCData\">rcData</a>, 
the sum of the resistances <code>rcData.R</code> must not exceed the total inner resistance <cde>Ri</code>.
</p>
</html>"));
    end CellData;

    record ExampleData "Example parameters of a battery cell"
      extends CellData(
        useLinearSOCDependency=false,
        OCVmax=4.2,
        OCVmin=2.5,
        SOCmax=1,
        SOCmin=0,
        OCV_SOC=[
          0.00,0.595; 0.01,0.656; 0.02,0.688; 0.03,0.714; 0.04,0.737; 0.05,0.744;
          0.06,0.750; 0.07,0.754; 0.08,0.756; 0.09,0.758; 0.10,0.761; 0.15,0.774;
          0.20,0.786; 0.25,0.795; 0.30,0.804; 0.35,0.811; 0.40,0.818; 0.45,0.826;
          0.50,0.835; 0.55,0.843; 0.60,0.855; 0.65,0.871; 0.70,0.888; 0.75,0.905;
          0.80,0.926; 0.85,0.943; 0.90,0.964; 0.95,0.980; 1.00,1.00],
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);
      annotation(defaultComponentPrefixes="parameter", Documentation(info="<html>
  <p>This is an example for an OCV versus SOC characteristic</p>
</html>"));
    end ExampleData;

    record RCData "Parameters of RC-elements"
      extends Modelica.Icons.Record;
      parameter Modelica.SIunits.Resistance R "Resistance of RC-element";
      parameter Modelica.SIunits.Time Tau "Time constant of RC-element";
      parameter Modelica.SIunits.Capacitance C=Tau/R "Capacitance of RC-element";
      annotation(defaultComponentPrefixes="parameter", defaultComponentName="rcData",
      Documentation(info="<html>
<p>Parameters for RC-elements of battery models:</p>
<ul>
<li><code>R</code> .. Resistance of RC-element</li>
<li><code>Tau</code> .. Time constant of RC-element; if <code>C</code> is specified, <code>Tau</code> can be neglected</li>
<li><code>C</code> .. Capacitance of RC-element; either specified explicitely or calculated from <code>Tau</code> and <code>R</code></li>
</ul>
</html>"));
    end RCData;
    annotation (Documentation(info="<html>
<p>
Parameter records for batteries
</p>
<h4>Note:</h4>
<p>
The user can easily build up a collection of different battery types by creating individual parameter records extending from the base record <code>CellData</code>. 
Dont't forget to add the <code>annotation(defaultComponentPrefixes=\"parameter\");</code> in each individual parameter record.
</p>
<p>
Record <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.RCData\">RCData</a> is used in record <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.CellData\">CellData</a>.
</p>
</html>"));
  end ParameterRecords;

  package Utilities "Utilities for battery applications"
    extends Modelica.Icons.UtilitiesPackage;
    block PulseSeries "Series of pulses"
      import Modelica.Math.BooleanVectors.oneTrue;
      parameter Real amplitude1= 1 "Amplitude of 1st pulse series";
      parameter Integer n1(min=0)=1 "Number of pulses of 1st series";
      parameter Modelica.SIunits.Time T1 "Length of pulses of 1st series";
      parameter Modelica.SIunits.Time Tp1 "Pause between pulses of 1st series";
      parameter Real amplitude2=-amplitude1 "Amplitude of 2nd pulse series";
      parameter Integer n2(min=0)=1 "Number of pulses of 2nd series";
      parameter Modelica.SIunits.Time T2=T1 "Length of pulses of 2nd series";
      parameter Modelica.SIunits.Time Tp2=Tp1 "Pause between pulses of 1st series";
      parameter Modelica.SIunits.Time Tp "Pause between the two series";
      extends Modelica.Blocks.Interfaces.SignalSource;
    protected
      parameter Modelica.SIunits.Time Tstart1[n1]={startTime + (k-1)*(T1 + Tp1) for k in 1:n1};
      parameter Modelica.SIunits.Time Tstart2[n1]={startTime + n1*(T1 + Tp1) + Tp + (k-1)*(T2 + Tp2) for k in 1:n2};
      Boolean on1, on2;
    equation
      on1 = oneTrue({time >= Tstart1[k] and time < Tstart1[k] + T1 for k in 1:n1});
      on2 = oneTrue({time >= Tstart2[k] and time < Tstart2[k] + T2 for k in 1:n1});
      y= offset + (if on1 then amplitude1 elseif on2 then amplitude2 else 0);
      annotation (Icon(graphics={
            Line(
              points={{-100,0},{-80,0}},
              color={0,0,0},
              pattern=LinePattern.Dash),
            Line(points={{-10,0},{-10,-60},{10,-60},{10,0},{20,0}}, color={0,0,0}),
            Line(points={{-50,0},{-50,60},{-40,60},{-40,0},{-20,0}}, color={0,0,0}),
            Line(
              points={{-20,0},{-10,0}},
              color={0,0,0},
              pattern=LinePattern.Dash),
            Line(points={{-80,0},{-80,60},{-70,60},{-70,0},{-50,0}}, color={0,0,0}),
            Line(points={{20,0},{20,-60},{40,-60},{40,0},{50,0}}, color={0,0,0}),
            Line(points={{50,0},{50,-60},{70,-60},{70,0},{80,0}}, color={0,0,0}),
            Line(
              points={{80,0},{100,0}},
              color={0,0,0},
              pattern=LinePattern.Dash)}), Documentation(info="<html>
<p>
Starting at <code>time = startTime</code>, first a series of <code>n1</code> pulses of <code>amplitude1</code> with length <code>T1</code> and pause after each pulse <code>Tp1</code> is issued.<br>
Then, after a pause <code>Tp</code>, a series of <code>n2</code> pulses of <code>amplitude2</code> with length <code>T2</code> and pause after each pulse <code>Tp2</code> is issued.
</html>"));
    end PulseSeries;

    model CCCVcharger
      "Charger with constant current - constant voltage characteristic"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter Modelica.SIunits.Current I "Constant charge current";
      parameter Modelica.SIunits.Time startTime=0 "Start time of charging";
      parameter Modelica.SIunits.Time rampTime=60 "Ramp up charging current";
      parameter Modelica.SIunits.Voltage Vend "End of charge voltage";
      Boolean CV(start=false, fixed=true) "Indicates CV charging";
    equation
      CV=v>=Vend;
      if CV then
        v=Vend;
      else
        i = -I*(if time<startTime then 0 else min(1,(time - startTime)/rampTime));
      end if;
      annotation (defaultComponentName="cccvCharger",
        Icon(graphics={   Rectangle(
            extent={{-100,-100},{100,100}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid), Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255}),
            Polygon(
              points={{20,80},{-50,-20},{0,-20},{-20,-80},{50,20},{0,20},{20,80}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
Ideal charger switching from constant current to constant voltage characteristic.
</p>
</html>"));
    end CCCVcharger;
    annotation (Documentation(info="<html>
<p>
Collection of utilities that are usefull for battery applications
</p>
</html>"));
  end Utilities;

  package BaseClasses "Base classes for battery models"
    extends Modelica.Icons.BasesPackage;

    partial model BaseCellStack
      "Battery with open-circuit voltage dependent on state of charge, self-discharge and inner resistance"
      import Modelica.Constants.eps;
      parameter Integer Ns=1 "Number of serial connected cells";
      parameter Integer Np=1 "Number of parallel connected cells";
      parameter ParameterRecords.CellData cellData "Cell parameters"
        annotation (Placement(transformation(extent={{-10,60},{10,80}})));
      Modelica.SIunits.Current i = p.i "Current into the battery";
      Modelica.SIunits.Power power = v*i "Power to the battery";
      extends Modelica.Electrical.Analog.Interfaces.TwoPin;
      output Real SOC(start=cellData.SOCmax) = integrator.y "State of charge"
        annotation (Dialog(showStartAttribute=true));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
        annotation (Placement(transformation(extent={{-90,10},{-70,-10}})));
      Modelica.Blocks.Continuous.Integrator integrator(final k=1/(Np*cellData.Qnom),
          final initType=Modelica.Blocks.Types.Init.NoInit) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-80,30})));
      Modelica.Blocks.Tables.CombiTable1Ds ocv_soc(table=if cellData.useLinearSOCDependency
             then cellData.LinearOCV_SOC else cellData.OCV_SOC,
        final smoothness=cellData.smoothness,                   extrapolation=
            Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
        annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
      Modelica.Blocks.Math.Gain gainV(final k=Ns*cellData.OCVmax) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-40,30})));
      Modelica.Electrical.Analog.Sources.SignalVoltage ocv
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      Modelica.Electrical.Analog.Basic.Conductor selfDischarge(final G=Np*
            cellData.Idis/(Ns*cellData.OCVmax),
        T_ref=293.15,
        final useHeatPort=true) if cellData.Idis > 0
        annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
      Modelica.Electrical.Analog.Basic.Resistor r0(
        final T_ref=cellData.T_ref,
        final alpha=cellData.alpha,
        final useHeatPort=true)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      extends Modelica.Electrical.Analog.Interfaces.PartialConditionalHeatPort;
    equation
      assert(cellData.OCVmax > cellData.OCVmin, "Specify 0 <= OCVmin < OCVmax");
      assert(cellData.SOCmax > cellData.SOCmin,
        "Specify 0 <= SOCmin < SOCmax <= 1");
      assert(cellData.OCV_SOC[1, 1] >= 0,
        "Specify OCV(SOC) table with SOCmin >= 0");
      assert(cellData.OCV_SOC[end, 1] <= 1,
        "Specify OCV(SOC) table with SOCmax <= 1");
      assert(cellData.OCV_SOC[1, 2] >= 0,
        "Specify OCV(SOC)/OCVmax table with  OCVmin/OCVmax >= 0");
      assert(cellData.OCV_SOC[end, 2] >= 1,
        "Specify OCV(SOC)/OCVmax table with max.OCV/OCVmax <= 1");
      assert(SOC < cellData.SOCmax + eps, "Battery overcharged!");
      assert(SOC > cellData.SOCmin - eps, "Battery exhausted!");
      connect(gainV.y, ocv.v)
        annotation (Line(points={{-40,19},{-40,12}}, color={0,0,127}));
      connect(ocv_soc.y[1], gainV.u)
        annotation (Line(points={{-49,50},{-40,50},{-40,42}},
                                                          color={0,0,127}));
      connect(integrator.y, ocv_soc.u)
        annotation (Line(points={{-80,41},{-80,50},{-72,50}}, color={0,0,127}));
      connect(currentSensor.n, ocv.p)
        annotation (Line(points={{-70,0},{-50,0}}, color={0,0,255}));
      connect(integrator.u, currentSensor.i)
        annotation (Line(points={{-80,18},{-80,11}}, color={0,0,127}));
      connect(p, currentSensor.p)
        annotation (Line(points={{-100,0},{-90,0}}, color={0,0,255}));
      connect(ocv.n, r0.p)
        annotation (Line(points={{-30,0},{-10,0}}, color={0,0,255}));
      connect(currentSensor.p, selfDischarge.p) annotation (Line(points={{-90,0},{-90,
              -20},{-70,-20}},           color={0,0,255}));
      connect(ocv.n, selfDischarge.n)
        annotation (Line(points={{-30,0},{-30,-20},{-50,-20}}, color={0,0,255}));
      connect(selfDischarge.heatPort, internalHeatPort) annotation (Line(points={{-60,-30},
              {-60,-40},{0,-40},{0,-80}},      color={191,0,0}));
      connect(internalHeatPort, r0.heatPort) annotation (Line(points={{0,-80},{
              0,-10}},              color={191,0,0}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Text(
              extent={{-150,70},{150,110}},
              textColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-90,50},{90,-50}},
              lineColor={0,0,255},
              radius=10),
            Rectangle(
              extent=DynamicSelect({{70,-30},{-70,30}},{{70,-30},{70-140*SOC,30}}),
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-90,30},{-100,30},{-110,10},{-110,-10},{-100,-30},{-90,-30},{
                  -90,30}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
The battery is modeled by open-circuit voltage (OCV) dependent on state of charge (SOC), a self-discharge component and an inner resistance.<br>
Parameters are collected in parameter record <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.CellData\">cellData</a>.<br>
All losses are dissipated to the optional <code>heatPort</code>.
</p>
<p>
For details, see <a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Concept\">concept</a> and <a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Parameterization\">parameterization</a>.
</p>
<h4>Note:</h4>
<p>
SOC &gt; SOCmax and SOC &lt; SOCmin triggers an error.
</p>
</html>"));
    end BaseCellStack;
    annotation (Documentation(info="<html>
<p>Base classes for batteries</p>
</html>"));
  end BaseClasses;
  annotation (Icon(graphics={
        Ellipse(extent={{-10,50},{10,-50}},  lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere,
          origin={0,-80},
          rotation=90),
        Rectangle(extent={{-70,50},{70,-50}}, lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-7.10543e-15,-10},
          rotation=90),
        Ellipse(extent={{-10,50},{10,-50}},lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere,
          origin={0,60},
          rotation=90),
        Ellipse(extent={{-4,20},{4,-20}},    lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere,
          origin={0,60},
          rotation=90),
        Rectangle(extent={{-13,20},{13,-20}}, lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={0,73},
          rotation=90),
        Ellipse(extent={{-4,20},{4,-20}},    lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere,
          origin={0,86},
          rotation=90)}), Documentation(info="<html>
<p>Library offering simple battery models</p>
</html>"));
end Batteries;
