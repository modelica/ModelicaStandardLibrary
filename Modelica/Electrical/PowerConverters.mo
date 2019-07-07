within Modelica.Electrical;
package PowerConverters "Rectifiers, Inverters, DC/DC and AC/AC converters"
  extends Modelica.Icons.Package;
  package UsersGuide "User's Guide"
    extends Modelica.Icons.Information;
    class ACDCConcept "AC/DC converter concept"
      extends Modelica.Icons.Information;
      annotation (DocumentationClass=true, Documentation(info="<html>

<p>AC/DC converters are also called rectifiers</p>

<h4>Component classification</h4>

<p>Conventional AC/DC converters contain diodes and thyristors. If thyristors are used, the output voltage of the rectifier can be controlled. If only diodes are used, the output voltages is solely dependent on the input voltage and the characteristic of applied diodes.</p>
<ul>
  <li>Diode rectifiers</li>
  <li>Thyristor rectifiers</li>
  <li>Half controlled rectifiers; half of the semiconductors are diodes and the others are thyristors, respectively</li>
</ul>

<h4>Topology classification</h4>

<p>The PowerConverters library provides bridge and center tap rectifiers for single and polyphase supply, see
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC\">AC/DC converters</a>.</p>

<h4>Control</h4>

<p>For each of the provided rectifiers a
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control\">control model</a> is available.
These control models have electrical connectors to be connected with the AC supply.
The firing angle of thyristor rectifiers can either be set by a parameter or a signal input.
</p>

<h4>Examples</h4>

<p>A variety of examples is provided at
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC\">Examples.ACDC</a>.
These examples include different kinds of DC loads. Even the control characteristics
of the rectifiers can be obtained experimentally; the names of these models
contain <code>_Characteristic</code>.
</p>
</html>"));
    end ACDCConcept;

    class DCACConcept "DC/AC converter concept"
      extends Modelica.Icons.Information;
      annotation (DocumentationClass=true, Documentation(info="<html>

<p>There are a single-phase and polyphase DC/AC converter model provided by the PowerConverters library.</p>

<h4>Control</h4>

<p>Currently there are 
<a href=\"modelica://Modelica.Electrical.PowerConverters.DCAC.Control.SVPWM\">space vector PWM</a> and 
<a href=\"modelica://Modelica.Electrical.PowerConverters.DCAC.Control.IntersectivePWM\">intersective PWM</a> models provided. 
However, for operating the single-phase inverter the PWM
<a href=\"modelica://Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM\">controller</a>
can be used.
</p>

<h4>Examples</h4>

<p>Some examples are provided at
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.DCAC\">Examples.DCAC</a>.
</p>
</html>"));
    end DCACConcept;

    class DCDCConcept "DC/DC converter concept"
      extends Modelica.Icons.Information;
      annotation (DocumentationClass=true, Documentation(info="<html>

<p>The following DC/DC converter topologies are currently included in the PowerConverters library.</p>

<ul>
<li>Chopper step down and step up converter</li>
<li>H bridge converter; four quadrant operation</li>
</ul>

<h4>Control</h4>

<p>A pulse width modulation (PWM)
<a href=\"modelica://Modelica.Electrical.PowerConverters.DCDC.Control\">controller</a>
is provided.
</p>

<h4>Examples</h4>

<p>Some examples are provided at
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.DCDC\">Examples.DCDC</a>.
</p>
</html>"));
    end DCDCConcept;

    class ACACConcept "AC/AC converter concept"
      extends Modelica.Icons.Information;
      annotation (DocumentationClass=true, Documentation(info="<html>

<p>The following DC/DC converter topologies are currently included in the PowerConverters library.</p>

<ul>
<li>Single-phase dimmer with <a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.SinglePhaseTriac\">triac</a></li>
<li>Polyphase induction machine soft starter with <a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.PolyPhaseTriac\">triac</a></li>
</ul>

<h4>Control</h4>

<p>To apply firing signals to the triac, the 
<a href=\"modelica://Modelica.Electrical.PowerConverters.DCDC.Control.Signal2mPulse\">Signal2mPulse adaptor</a> is provided.
</p>
<p>
The <a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.Control.VoltageToAngle\">Voltage2Angle block</a> 
calculates phase angle from reference voltage.
</p>
<p>
To control the soft start of an induction machine, 
the <a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.Control.SoftStartControl\">SoftStartControl block</a> 
is provided. It applies a voltage ramp during start, setting the ramp on hold whenever the measured current exceeds the maximum current. 
Furthermore, a ramp down can be applied for stopping the drive.
</p>

<h4>Examples</h4>

<p>Some examples are provided at
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACAC\">Examples.ACAC</a>.
</p>
</html>"));
    end ACACConcept;

    class Contact "Contact"
      extends Modelica.Icons.Contact;
      annotation (Documentation(info="<html>
<h4>Main authors</h4>

<p>
<strong>Dr. Christian Kral</strong><br>
<a href=\"https://christiankral.net/\">Electric Machines, Drives and Systems</a><br>
A-1060 Vienna, Austria<br>
email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a>
</p>

<p>
<strong>Anton Haumer</strong><br>
<a href=\"https://www.haumer.at\">Technical Consulting &amp; Electrical Engineering</a><br>
D-93049 Regensburg, Germany<br>
email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
</p>
</html>"));
    end Contact;

    class ReleaseNotes "Release Notes"
      extends Modelica.Icons.ReleaseNotes;
      annotation (Documentation(info="<html>
<h5>Version 3.2.3, 2019-01-23</h5>
<ul>
<li>Added instantaneous power calculations of DC and AC interface partial models, see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2198\">#2198</a></li>
<li>Replaced Modelica_Electrical_PowerConverters by Modelica.Electrical.PowerConverter, see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2196\">#2196</a></li>
<li>Unified location of PowerConverter connectors in diagram layer, see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2185\">#2185</a></li>
<li>Fixed broken hyper links</li>
<li>Replaced pin declaration by <code>extends</code> according to <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2065\">#2065</a></li>
</ul>

<h5>Version 1.2.0, 2014-04-06</h5>
<ul>
<li>Moved enabling signals from control to inverter models due to consistency reasons</li>
<li>Added partial models for enabling firing signals</li>
</ul>

<h5>Version 1.1.0, 2014-03-24</h5>
<ul>
<li>Removed StepUp converter due to consistency reasons</li>
</ul>

<h5>Version 1.0.0, 2014-03-24</h5>
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
      <td>[Skvarenina01]</td>
      <td>Timothy L. Skvarenina,
        <a href=\"http://www.crcpress.com/product/isbn/9780849373367\">
        <em>The Power Electronics Handbook</em></a>,
        CRC Press 2001, ISBN 9780849373367</td>
    </tr>

    <tr>
      <td>[Luo05]</td>
      <td>Fang Lin Luo, Hong Ye and Muhammad H. Rashid,
        <a href=\"http://store.elsevier.com/product.jsp?isbn=9780120887576&amp;_requestid=1725\"><em>Digital Power Electronics and Applications</em></a>,
        Elsevier Academic Press, 2005, ISBN 978-0120887576</td>
    </tr>

    <tr>
      <td>[Williams2006]</td>
      <td><a href=\"http://www.freescience.info/go.php?pagename=books&amp;id=1732\">
<em>Principles and Elements of Power Electronics: Devices, Drivers, Applications, and Passive Components</em></a>, available at <a href=\"http://www.freescience.info/go.php?pagename=books&amp;id=1732\">FreeScience</a>, ISBN 978-0-9553384-0-3</td>
    </tr>
</table>
</html>"));
    end References;
    annotation (DocumentationClass=true, Documentation(info="<html>
<p>
This library provides power converters for DC and AC single-phase and polyphase electrical systems. The PowerConverters library contains three types of converters.
</p>

<ul>
  <li>AC/DC converters (rectifiers)</li>
  <li>DC/AC converters (inverters)</li>
  <li>DC/DC converters</li>
  <li>AC/AC converters</li>
</ul>

<p>
AC/AC converters currently only provide dimmer and soft starter with triacs.
</p>

<h4>Converter characteristics</h4>

<ul>
  <li>All converter models rely on existing diode, thyristor and switch models provided in the
      <a href=\"modelica://Modelica.Electrical.Analog.Ideal\">Analog.Ideal</a> and the
      <a href=\"modelica://Modelica.Electrical.Polyphase.Ideal\">Polyphase.Ideal</a>
      package of the Modelica Standard Library.</li>
  <li>Switching losses and recovery effects are not considered</li>
  <li>Only conduction losses are taken into account</li>
  <li>The parameters of the semiconductors include
  <ul>
    <li>The on state resistance <code>Ron</code></li>
    <li>The off state conductance <code>Goff</code></li>
    <li>The knee voltage <code>Vknee</code></li>
  </ul></li>
  <li>Each converter is equipped with an optional heat port which can be enabled by the parameter
      <code>useHeatPort</code>; the heat ports of all semiconductors are connected,
      so all temperatures of all semiconductors are equal and the heat flow of the converter heat port
      is determined by the sum of all semiconductor heat flows</li>
  <li>Each converter contains boolean firing inputs provides variables <code>offStart...</code>
      to specify the initial conditions of the off state of each semiconductor</li>
  <li>The boolean firing signals are enabled either by means of the a parameter <code>constantEnable</code> or by a conditional signal input, enabled by <code>useConstantEnable = false</code></li>
  <li>The number of phases of polyphase converters is not restricted to three</li>
</ul>

<h4>Literature</h4>

<p>
General background knowledge on power converters and power electronics can be found in
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.References\">[Skvarenina01]</a> and
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.References\">[Luo05]</a>.
A freely available book is available in
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.References\">[Williams2006]</a>.
</p>
</html>"));
  end UsersGuide;

  package Examples "Examples"
    extends Modelica.Icons.ExamplesPackage;
    package ACDC "AC to DC converter examples"
      extends Modelica.Icons.ExamplesPackage;
      package Rectifier1Pulse "Single pulse rectifier"
        extends Modelica.Icons.ExamplesPackage;
        model Thyristor1Pulse_R
          "One pulse rectifier with resistive load and constant firing angle"
          extends ExampleTemplates.Thyristor1Pulse(pulse2(
              useConstantFiringAngle=true,
              f=f,
              constantFiringAngle=constantFiringAngle));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Angle constantFiringAngle=30*pi/180
            "Firing angle";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(idealthyristor.n, resistor.p) annotation (Line(
              points={{0,40},{30,40}}, color={0,0,255}));
          connect(resistor.n, currentSensor.p) annotation (Line(
              points={{30,20},{30,-40},{10,-40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example demonstrates the operational behavior of a single-phase controlled rectifier with constant firing angle and resistive load.</p>
<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end Thyristor1Pulse_R;

        model Thyristor1Pulse_R_Characteristic
          "Control characteristic of one pulse rectifier with resistive load"
          extends ExampleTemplates.Thyristor1Pulse(pulse2(
                useConstantFiringAngle=false, f=f));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Blocks.Sources.Ramp ramp(height=pi, duration=10) annotation (
             Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=270,
                origin={-40,-70})));
        equation
          connect(resistor.n, currentSensor.p) annotation (Line(
              points={{30,20},{30,-40},{10,-40}}, color={0,0,255}));
          connect(resistor.p, idealthyristor.n) annotation (Line(
              points={{30,40},{0,40}}, color={0,0,255}));
          connect(ramp.y, pulse2.firingAngle) annotation (Line(
              points={{-40,-59},{-40,-12}}, color={0,0,127}));
          annotation (
            experiment(
              StopTime=10,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example demonstrates the operational behavior of a single-phase controlled rectifier with variable firing angle and resistive load. The average load voltage can be controlled by means of the firing angle.</p>
<p><br>Plot average voltage <code>meanVoltage.v</code> versus firingAngle <code>pulse2.firingAngle</code> to see control characteristic of this type of rectifier with resistive load.</p>
</html>"));
        end Thyristor1Pulse_R_Characteristic;
        annotation (Documentation(info="<html>
<p>This package includes examples of single pulse controlled rectifiers.</p>
</html>"));
      end Rectifier1Pulse;

      package RectifierBridge2Pulse "Two pulse Graetz bridge"
        extends Modelica.Icons.ExamplesPackage;
        model DiodeBridge2Pulse
          "Two pulse Graetz diode bridge with resistive load"
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Voltage Vrms=110 "RMS supply voltage";
          parameter Modelica.SIunits.Frequency f=50 "Frequency";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          // parameter Modelica.SIunits.Inductance L = 1 "Load resistance" annotation(Evaluate=true);
          // parameter Modelica.SIunits.Voltage VDC=-120 "DC load offset voltage";
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(
                origin={-80,-50},
                extent={{-10,-10},{10,10}})));
          Modelica.Electrical.Analog.Sources.SineVoltage sinevoltage(V=sqrt(2)*
                Vrms, freqHz=f) annotation (Placement(transformation(
                origin={-80,20},
                extent={{-10,-10},{10,10}},
                rotation=-90)));
          Modelica.Electrical.PowerConverters.ACDC.DiodeBridge2Pulse rectifier(
              useHeatPort=false)
            annotation (Placement(transformation(extent={{-40,24},{-20,44}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
            annotation (Placement(transformation(
                origin={50,10},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Blocks.Math.Mean meanVoltage(f=2*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,40})));
          Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=2*f)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={80,10})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,-40})));
          Modelica.Blocks.Math.Mean meanCurrent(f=2*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,-60})));
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(meanCurrent.u, currentSensor.i) annotation (Line(
              points={{68,-60},{0,-60},{0,-51}}, color={0,0,127}));
          connect(ground.p, sinevoltage.n) annotation (Line(
              points={{-80,-40},{-80,10}}, color={0,0,255}));
          connect(voltagesensor.v, meanVoltage.u) annotation (Line(
              points={{61,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
          connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
              points={{61,10},{68,10}}, color={0,0,127}));
          connect(sinevoltage.p, rectifier.ac_p) annotation (Line(
              points={{-80,30},{-80,40},{-40,40}}, color={0,0,255}));
          connect(sinevoltage.n, rectifier.ac_n) annotation (Line(
              points={{-80,10},{-80,10},{-80,-8},{-50,-8},{-50,28},{-40,28}}, color={0,0,255}));
          connect(rectifier.dc_n, currentSensor.n) annotation (Line(
              points={{-20,28},{-10,28},{-10,-40}}, color={0,0,255}));
          connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
              points={{-20,40},{50,40},{50,20}}, color={0,0,255}));
          connect(voltagesensor.n, currentSensor.p) annotation (Line(
              points={{50,0},{50,-40},{10,-40}}, color={0,0,255}));
          connect(resistor.n, currentSensor.p) annotation (Line(
              points={{30,20},{30,-40},{10,-40}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This examples shows a two pulse uncontrolled bridge example with resistive load.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end DiodeBridge2Pulse;

        model HalfControlledBridge2Pulse
          "Two pulse Graetz half controlled bridge with resistive load"
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Voltage Vrms=110 "RMS supply voltage";
          parameter Modelica.SIunits.Frequency f=50 "Frequency";
          parameter Modelica.SIunits.Angle constantFiringAngle=30*pi/180
            "Firing angle";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";

          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(
                origin={-80,-50},
                extent={{-10,-10},{10,10}})));
          Modelica.Electrical.Analog.Sources.SineVoltage sinevoltage(V=sqrt(2)*
                Vrms, freqHz=f) annotation (Placement(transformation(
                origin={-80,20},
                extent={{-10,-10},{10,10}},
                rotation=-90)));
          Modelica.Electrical.PowerConverters.ACDC.HalfControlledBridge2Pulse
            rectifier(useHeatPort=false, offStart_p1=true)
            annotation (Placement(transformation(extent={{-40,24},{-20,44}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
            annotation (Placement(transformation(
                origin={50,10},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Blocks.Math.Mean meanVoltage(f=2*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,40})));
          Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=2*f)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={80,10})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,-40})));
          Modelica.Blocks.Math.Mean meanCurrent(f=2*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,-60})));
          Modelica.Electrical.PowerConverters.ACDC.Control.VoltageBridge2Pulse
            pulse2(
            f=f,
            useFilter=false,
            constantFiringAngle=constantFiringAngle) annotation (Placement(
                transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-30,-2})));
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(meanCurrent.u, currentSensor.i) annotation (Line(
              points={{68,-60},{0,-60},{0,-51}}, color={0,0,127}));
          connect(ground.p, sinevoltage.n) annotation (Line(
              points={{-80,-40},{-80,10}}, color={0,0,255}));
          connect(voltagesensor.v, meanVoltage.u) annotation (Line(
              points={{61,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
          connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
              points={{61,10},{68,10}}, color={0,0,127}));
          connect(sinevoltage.p, rectifier.ac_p) annotation (Line(
              points={{-80,30},{-80,40},{-40,40}}, color={0,0,255}));
          connect(sinevoltage.n, rectifier.ac_n) annotation (Line(
              points={{-80,10},{-80,10},{-80,-8},{-50,-8},{-50,28},{-40,28}}, color={0,0,255}));
          connect(rectifier.dc_n, currentSensor.n) annotation (Line(
              points={{-20,28},{-10,28},{-10,-40}},   color={0,0,255}));
          connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
              points={{-20,40},{50,40},{50,20}}, color={0,0,255}));
          connect(voltagesensor.n, currentSensor.p) annotation (Line(
              points={{50,0},{50,-40},{10,-40}}, color={0,0,255}));
          connect(pulse2.fire_p, rectifier.fire_p) annotation (Line(
              points={{-36,9},{-36,22}}, color={255,0,255}));
          connect(pulse2.fire_n, rectifier.fire_n) annotation (Line(
              points={{-24,9},{-24,22}}, color={255,0,255}));
          connect(pulse2.ac_p, rectifier.ac_p) annotation (Line(
              points={{-40,4},{-60,4},{-60,40},{-40,40}}, color={0,0,255}));
          connect(rectifier.ac_n, pulse2.ac_n) annotation (Line(
              points={{-40,28},{-50,28},{-50,-8},{-40,-8}}, color={0,0,255}));
          connect(resistor.n, currentSensor.p) annotation (Line(
              points={{30,20},{30,-40},{10,-40}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This examples shows a two pulse half controlled bridge example with resistive load. In case of resistive load the half controlled bridge shows the same output voltage as the
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2Pulse.ThyristorBridge2Pulse_R\">full controlled bridge</a>.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end HalfControlledBridge2Pulse;

        model ThyristorBridge2Pulse_R
          "Two pulse Graetz thyristor bridge rectifier with resistive load"
          extends ExampleTemplates.ThyristorBridge2Pulse(pulse2(
                constantFiringAngle=constantFiringAngle));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Angle constantFiringAngle=30*pi/180
            "Firing angle";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(resistor.n, currentSensor.p) annotation (Line(
              points={{30,20},{30,-40},{10,-40}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This examples shows a two pulse full controlled bridge example with resistive load. In case of resistive load the full controlled bridge shows the same output voltage as the
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2Pulse.HalfControlledBridge2Pulse\">half controlled bridge</a>.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end ThyristorBridge2Pulse_R;

        model ThyristorBridge2Pulse_RL
          "Two pulse Graetz thyristor bridge rectifier with R-L load"
          extends ExampleTemplates.ThyristorBridge2Pulse(pulse2(
                constantFiringAngle=constantFiringAngle));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Angle constantFiringAngle=30*pi/180
            "Firing angle";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          parameter Modelica.SIunits.Inductance L=1 "Load resistance"
            annotation (Evaluate=true);
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(fixed=true,
                start=0)) annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(resistor.n, inductor.p) annotation (Line(
              points={{30,20},{30,10}}, color={0,0,255}));
          connect(inductor.n, currentSensor.p) annotation (Line(
              points={{30,-10},{30,-40},{10,-40}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This examples shows a two pulse full controlled bridge example with R-L load.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end ThyristorBridge2Pulse_RL;

        model ThyristorBridge2Pulse_RLV
          "Two pulse Graetz thyristor bridge rectifier with R-L load and voltage"
          extends ExampleTemplates.ThyristorBridge2Pulse(pulse2(
                constantFiringAngle=constantFiringAngle));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Angle constantFiringAngle=30*pi/180
            "Firing angle";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          parameter Modelica.SIunits.Inductance L=1 "Load resistance"
            annotation (Evaluate=true);
          parameter Modelica.SIunits.Voltage VDC=-120 "DC load offset voltage";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(fixed=true,
                start=0)) annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=
                VDC) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={30,-30})));
        equation
          connect(resistor.n, inductor.p) annotation (Line(
              points={{30,20},{30,10}}, color={0,0,255}));
          connect(inductor.n, constantVoltage.p) annotation (Line(
              points={{30,-10},{30,-20}}, color={0,0,255}));
          connect(constantVoltage.n, currentSensor.p) annotation (Line(
              points={{30,-40},{10,-40}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This examples shows a two pulse full controlled bridge example with R-L load including DC voltage source. The additional DC voltage source in this example enables negative average load voltages.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end ThyristorBridge2Pulse_RLV;

        model ThyristorBridge2Pulse_RLV_Characteristic
          "Characteristic of two pulse Graetz thyristor bridge rectifier with R-L load and voltage"
          extends ExampleTemplates.ThyristorBridge2Pulse(pulse2(
                useConstantFiringAngle=false));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Voltage Vdi0=2/pi*sin(pi/2)*sqrt(2)*Vrms
            "Ideal max. DC voltage";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          parameter Modelica.SIunits.Inductance L=1 "Load resistance"
            annotation (Evaluate=true);
          parameter Modelica.SIunits.Voltage VDC=-120 "DC load offset voltage";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(fixed=true,
                start=0)) annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=
                VDC) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={30,-30})));
          Modelica.Blocks.Sources.Ramp ramp(height=pi, duration=10) annotation (
             Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=270,
                origin={-30,-50})));
        equation
          connect(resistor.n, inductor.p) annotation (Line(
              points={{30,20},{30,10}}, color={0,0,255}));
          connect(inductor.n, constantVoltage.p) annotation (Line(
              points={{30,-10},{30,-20}}, color={0,0,255}));
          connect(constantVoltage.n, currentSensor.p) annotation (Line(
              points={{30,-40},{10,-40}}, color={0,0,255}));
          connect(ramp.y, pulse2.firingAngle) annotation (Line(
              points={{-30,-39},{-30,-39},{-30,-14}}, color={0,0,127}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=10,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>

<p>This examples shows a two pulse full controlled bridge example with R-L load including DC voltage source. The additional DC voltage source in this example enables negative average load voltages.</p>

<p>Plot average voltage <code>meanVoltage.v</code> versus firingAngle <code>pulse2.firingAngle</code> to see control characteristic of this type of rectifier with R-L load including active voltage.</p>
</html>"));
        end ThyristorBridge2Pulse_RLV_Characteristic;

        model ThyristorBridge2Pulse_DC_Drive
          "Two pulse Graetz thyristor bridge feeding a DC drive"
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Voltage Vrms=dcpmData.VaNominal/(2/pi*sin(
              pi/2)*sqrt(2)) "RMS supply voltage";
          parameter Modelica.SIunits.Frequency f=50 "Frequency";
          parameter Modelica.SIunits.ApparentPower SMains=250E3
            "Mains short circuit apparent power";
          parameter Real lamdaMains=0.1 "Mains short circuit power factor";
          final parameter Modelica.SIunits.Impedance ZMains=Vrms^2/SMains
            "Mains short circuit impedance";
          final parameter Modelica.SIunits.Resistance RMains=ZMains*lamdaMains
            "Mains resistance" annotation (Evaluate=true);
          final parameter Modelica.SIunits.Inductance LMains=ZMains*sqrt(1 -
              lamdaMains^2)/(2*pi*f) "Mains inductance"
            annotation (Evaluate=true);
          parameter Modelica.SIunits.Inductance Ld=10*dcpmData.La
            "Smoothing inductance" annotation (Evaluate=true);
          final parameter Modelica.SIunits.Torque tauNominal=dcpmData.ViNominal
              *dcpmData.IaNominal/dcpmData.wNominal "Nominal torque";
          output Modelica.SIunits.AngularVelocity w(displayUnit="rpm") = dcpm.wMechanical;
          output Modelica.SIunits.Torque tau=dcpm.tauShaft;
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(
                origin={-80,-50},
                extent={{-10,-10},{10,10}})));
          Modelica.Electrical.Analog.Sources.SineVoltage sinevoltage(V=sqrt(2)*
                Vrms, freqHz=f) annotation (Placement(transformation(
                origin={-80,0},
                extent={{-10,-10},{10,10}},
                rotation=-90)));
          Modelica.Electrical.PowerConverters.ACDC.ThyristorBridge2Pulse
            rectifier(useHeatPort=false)
            annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
            annotation (Placement(transformation(
                origin={50,10},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Blocks.Math.Mean meanVoltage(f=2*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,40})));
          Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=2*f)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={80,10})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,-40})));
          Modelica.Blocks.Math.Mean meanCurrent(f=2*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,-60})));
          Modelica.Electrical.PowerConverters.ACDC.Control.VoltageBridge2Pulse
            pulse2(useConstantFiringAngle=false, useFilter=true) annotation (
              Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-30,-30})));
          Modelica.Electrical.Analog.Basic.Inductor inductor(L=Ld) annotation (
              Placement(transformation(
                origin={30,-10},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet
            dcpm(
            VaNominal=dcpmData.VaNominal,
            IaNominal=dcpmData.IaNominal,
            wNominal=dcpmData.wNominal,
            TaNominal=dcpmData.TaNominal,
            Ra=dcpmData.Ra,
            TaRef=dcpmData.TaRef,
            La=dcpmData.La,
            Jr=dcpmData.Jr,
            useSupport=false,
            Js=dcpmData.Js,
            frictionParameters=dcpmData.frictionParameters,
            coreParameters=dcpmData.coreParameters,
            strayLoadParameters=dcpmData.strayLoadParameters,
            brushParameters=dcpmData.brushParameters,
            phiMechanical(fixed=true),
            wMechanical(fixed=true, start=dcpmData.wNominal),
            TaOperational=293.15,
            alpha20a=dcpmData.alpha20a,
            ia(start=0, fixed=true)) annotation (Placement(transformation(
                  extent={{10,-90},{30,-70}})));
          parameter
            Modelica.Electrical.Machines.Utilities.ParameterRecords.DcPermanentMagnetData
            dcpmData "Data record of PM excited DC machine"
            annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
          Modelica.Mechanics.Rotational.Sources.Torque torque
            annotation (Placement(transformation(extent={{60,-90},{40,-70}})));
          Modelica.Blocks.Sources.Ramp ramp(
            duration=10,
            startTime=5,
            height=tauNominal,
            offset=-tauNominal)
            annotation (Placement(transformation(extent={{90,-90},{70,-70}})));
          Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(
                transformation(
                extent={{10,-10},{-10,10}},
                rotation=270,
                origin={-30,-60})));
          Modelica.Electrical.Analog.Basic.Resistor rMains(R=RMains)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-80,30})));
          Modelica.Electrical.Analog.Basic.Inductor lMains(L=LMains)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-80,60})));
        initial equation
          lMains.i = 0;


        equation
          connect(meanCurrent.u, currentSensor.i) annotation (Line(
              points={{68,-60},{0,-60},{0,-51}}, color={0,0,127}));
          connect(ground.p, sinevoltage.n) annotation (Line(
              points={{-80,-40},{-80,-10}}, color={0,0,255}));
          connect(voltagesensor.v, meanVoltage.u) annotation (Line(
              points={{61,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
          connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
              points={{61,10},{68,10}}, color={0,0,127}));
          connect(sinevoltage.n, rectifier.ac_n) annotation (Line(
              points={{-80,-10},{-60,-10},{-60,-6},{-40,-6}}, color={0,0,255}));
          connect(rectifier.dc_n, currentSensor.n) annotation (Line(
              points={{-20,-6},{-10,-6},{-10,-40}},   color={0,0,255}));
          connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
              points={{-20,6},{-10,6},{-10,40},{50,40},{50,20}}, color={0,0,255}));
          connect(voltagesensor.n, currentSensor.p) annotation (Line(
              points={{50,0},{50,-40},{10,-40}}, color={0,0,255}));
          connect(pulse2.fire_p, rectifier.fire_p) annotation (Line(
              points={{-36,-19},{-36,-12}}, color={255,0,255}));
          connect(pulse2.fire_n, rectifier.fire_n) annotation (Line(
              points={{-24,-19},{-24,-12}}, color={255,0,255}));
          connect(pulse2.ac_p, rectifier.ac_p) annotation (Line(
              points={{-40,-24},{-54,-24},{-54,6},{-40,6}}, color={0,0,255}));
          connect(rectifier.ac_n, pulse2.ac_n) annotation (Line(
              points={{-40,-6},{-50,-6},{-50,-36},{-40,-36}}, color={0,0,255}));
          connect(inductor.n, dcpm.pin_ap) annotation (Line(
              points={{30,-20},{30,-70},{26,-70}}, color={0,0,255}));
          connect(torque.flange, dcpm.flange) annotation (Line(
              points={{40,-80},{30,-80}}));
          connect(ramp.y, torque.tau) annotation (Line(
              points={{69,-80},{62,-80}}, color={0,0,127}));
          connect(rectifier.dc_p, inductor.p) annotation (Line(
              points={{-20,6},{-10,6},{-10,40},{30,40},{30,0}}, color={0,0,255}));
          connect(currentSensor.p, dcpm.pin_an) annotation (Line(
              points={{10,-40},{10,-70},{14,-70}}, color={0,0,255}));
          connect(const.y, pulse2.firingAngle) annotation (Line(
              points={{-30,-49},{-30,-42}}, color={0,0,127}));
          connect(rMains.n, lMains.p) annotation (Line(
              points={{-80,40},{-80,50}}, color={0,0,255}));
          connect(rMains.p, sinevoltage.p) annotation (Line(
              points={{-80,20},{-80,10}}, color={0,0,255}));
          connect(rectifier.ac_p, lMains.n) annotation (Line(
              points={{-40,6},{-60,6},{-60,70},{-80,70}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=15,
              Interval=0.0002,
              Tolerance=1e-006),
            Documentation(info="<html>
<p>
In this example a PM excited DC machine is started with nominal torque at nominal speed. After 5 seconds, load torque is reduced to zero over a period of additional 10 seconds. At 15 seconds, the machine is operating at no load.
</p>

<p>
Plot torque <code>tau</code>, current <code>currentSensor.i</code> and average current <code>meanCurrent.y</code>. Also plot speed <code>w</code>, voltage <code>voltageSensor.v</code> and the average voltage <code>meanVoltage.y</code>.</p>
</html>"));
        end ThyristorBridge2Pulse_DC_Drive;
        annotation (Documentation(info="<html>
<p>This package includes single-phase two pulse bridge rectifiers. The examples show uncontrolled and controlled rectifiers with constant and variable firing angle.</p>
</html>"));
      end RectifierBridge2Pulse;

      package RectifierCenterTap2Pulse "Center tap rectifier with two pulses"
        extends Modelica.Icons.ExamplesPackage;
        model DiodeCenterTap2Pulse
          "Two pulse diode rectifier with center tap with resistive load"
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Voltage Vrms=110 "RMS supply voltage";
          parameter Modelica.SIunits.Frequency f=50 "Frequency";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";

          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(
                origin={-90,-50},
                extent={{-10,-10},{10,10}})));
          Modelica.Electrical.Analog.Sources.SineVoltage sinevoltage_n(V=sqrt(2)
                *Vrms,freqHz=f) annotation (Placement(transformation(
                origin={-80,-13.9999},
                extent={{-9.999890000000001,-10},{10,10}},
                rotation=-90)));
          Modelica.Electrical.Analog.Sources.SineVoltage sinevoltage_p(V=sqrt(2)
                *Vrms,freqHz=f) annotation (Placement(transformation(
                origin={-80,14},
                extent={{-10,-10},{10,10}},
                rotation=-90)));
          Modelica.Electrical.PowerConverters.ACDC.DiodeCenterTap2Pulse
            rectifier
            annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
            annotation (Placement(transformation(
                origin={50,10},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Blocks.Math.Mean meanVoltage(f=2*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,40})));
          Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=2*f)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={80,10})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,-40})));
          Modelica.Blocks.Math.Mean meanCurrent(f=2*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,-60})));
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(meanCurrent.u, currentSensor.i) annotation (Line(
              points={{68,-60},{0,-60},{0,-51}}, color={0,0,127}));
          connect(voltagesensor.v, meanVoltage.u) annotation (Line(
              points={{61,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
          connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
              points={{61,10},{68,10}}, color={0,0,127}));
          connect(sinevoltage_p.n, sinevoltage_n.p) annotation (Line(
              points={{-80,4},{-80,-4.00001}}, color={0,0,255}));
          connect(ground.p, sinevoltage_p.n) annotation (Line(
              points={{-90,-40},{-90,0},{-80,0},{-80,4}}, color={0,0,255}));
          connect(sinevoltage_p.p, rectifier.ac_p) annotation (Line(
              points={{-80,24},{-80,46},{-40,46}}, color={0,0,255}));
          connect(sinevoltage_n.n, rectifier.ac_n) annotation (Line(
              points={{-80,-23.9999},{-80,-32},{-50,-32},{-50,34},{-40,34}}, color={0,0,255}));
          connect(ground.p, currentSensor.n) annotation (Line(
              points={{-90,-40},{-10,-40}}, color={0,0,255}));
          connect(currentSensor.p, voltagesensor.n) annotation (Line(
              points={{10,-40},{50,-40},{50,0}}, color={0,0,255}));
          connect(voltagesensor.p, rectifier.dc_p) annotation (Line(
              points={{50,20},{50,40},{-20,40}}, color={0,0,255}));
          connect(resistor.n, currentSensor.p) annotation (Line(
              points={{30,20},{30,-40},{10,-40}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows an uncontrolled two pulse center tap diode rectifier with resistive load.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end DiodeCenterTap2Pulse;

        model ThyristorCenterTap2Pulse_R
          "Two pulse thyristor rectifier with center tap and resistive load"
          extends ExampleTemplates.ThyristorCenterTap2Pulse(pulse2(
                constantFiringAngle=constantFiringAngle));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Angle constantFiringAngle=30*pi/180
            "Firing angle";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(resistor.n, currentSensor.p) annotation (Line(
              points={{30,20},{30,-40},{10,-40}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows a controlled center tap two pulse rectifier with resistive load.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end ThyristorCenterTap2Pulse_R;

        model ThyristorCenterTap2Pulse_RL
          "Two pulse thyristor rectifier with center tap and R-L load"
          extends ExampleTemplates.ThyristorCenterTap2Pulse(pulse2(
                constantFiringAngle=constantFiringAngle));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Angle constantFiringAngle=30*pi/180
            "Firing angle";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          parameter Modelica.SIunits.Inductance L=1 "Load resistance"
            annotation (Evaluate=true);
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(fixed=true,
                start=0)) annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(resistor.n, inductor.p) annotation (Line(
              points={{30,20},{30,10}}, color={0,0,255}));
          connect(inductor.n, currentSensor.p) annotation (Line(
              points={{30,-10},{30,-40},{10,-40}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows a controlled center tap two pulse rectifier with R-L load.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end ThyristorCenterTap2Pulse_RL;

        model ThyristorCenterTap2Pulse_RLV
          "Two pulse thyristor rectifier with center tap and R-L load and voltage"
          extends ExampleTemplates.ThyristorCenterTap2Pulse(pulse2(
                constantFiringAngle=constantFiringAngle));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Angle constantFiringAngle=30*pi/180
            "Firing angle";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          parameter Modelica.SIunits.Inductance L=1 "Load resistance"
            annotation (Evaluate=true);
          parameter Modelica.SIunits.Voltage VDC=-120 "DC load offset voltage";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(start=0,
                fixed=true)) annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=
                VDC) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={30,-30})));
        equation
          connect(resistor.n, inductor.p) annotation (Line(
              points={{30,20},{30,10}}, color={0,0,255}));
          connect(inductor.n, constantVoltage.p) annotation (Line(
              points={{30,-10},{30,-20}}, color={0,0,255}));
          connect(constantVoltage.n, currentSensor.p) annotation (Line(
              points={{30,-40},{10,-40}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows a controlled center tap two pulse rectifier with R-L load including DC voltage source. The additional DC voltage source in this example enables negative average load voltages.</p>


<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end ThyristorCenterTap2Pulse_RLV;

        model ThyristorCenterTap2Pulse_RLV_Characteristic
          "Characteristic of two pulse thyristor rectifier with center tap and R-L load and voltage"
          extends ExampleTemplates.ThyristorCenterTap2Pulse(pulse2(
                useConstantFiringAngle=false));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          parameter Modelica.SIunits.Inductance L=1 "Load resistance"
            annotation (Evaluate=true);
          parameter Modelica.SIunits.Voltage VDC=-120 "DC load offset voltage";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(fixed=true,
                start=0)) annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=
                VDC) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={30,-30})));
          Modelica.Blocks.Sources.Ramp ramp(height=pi, duration=10) annotation (
             Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=270,
                origin={-30,-60})));
        equation
          connect(resistor.n, inductor.p) annotation (Line(
              points={{30,20},{30,10}}, color={0,0,255}));
          connect(inductor.n, constantVoltage.p) annotation (Line(
              points={{30,-10},{30,-20}}, color={0,0,255}));
          connect(constantVoltage.n, currentSensor.p) annotation (Line(
              points={{30,-40},{10,-40}}, color={0,0,255}));
          connect(ramp.y, pulse2.firingAngle) annotation (Line(
              points={{-30,-49},{-30,-12}}, color={0,0,127}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=10,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows a controlled center tap two pulse rectifier with R-L load including DC voltage source. The additional DC voltage source in this example enables negative average load voltages.</p>

<p>Plot average voltage <code>meanVoltage.v</code> versus firingAngle <code>pulse2.firingAngle</code> to see control characteristic of this type of rectifier with R-L load including active voltage.</p>
</html>"));
        end ThyristorCenterTap2Pulse_RLV_Characteristic;
        annotation (Documentation(info="<html>
<p>This package includes single-phase two pulse center tap rectifiers. The examples show uncontrolled and controlled rectifiers with constant and variable firing angle.</p>
</html>"));
      end RectifierCenterTap2Pulse;

      package RectifierCenterTapmPulse "m pulse rectifier with center tap"
        extends Modelica.Icons.ExamplesPackage;
        model DiodeCenterTapmPulse
          "2*m pulse diode rectifier with center tap with resistive load"
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Integer m(final min=3) = 3 "Number of phases";
          parameter Modelica.SIunits.Voltage Vrms=110 "RMS supply voltage";
          parameter Modelica.SIunits.Frequency f=50 "Frequency";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";

          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(extent={{-80,-100},{-60,-80}})));
          Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
             Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-70,-30})));
          Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage_p(
            final m=m,
            V=fill(sqrt(2)*Vrms, m),
            phase=-
                Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
            freqHz=fill(f, m)) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-70,10})));
          Modelica.Electrical.PowerConverters.ACDC.DiodeCenterTapmPulse
            rectifier(final m=m)
            annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
            annotation (Placement(transformation(
                origin={50,10},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Blocks.Math.Mean meanVoltage(f=m*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,40})));
          Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=m*f)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={80,10})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,-50})));
          Modelica.Blocks.Math.Mean meanCurrent(f=m*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,-70})));
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(star.pin_n, ground.p) annotation (Line(
              points={{-70,-40},{-70,-80}}, color={0,0,255}));
          connect(meanCurrent.u, currentSensor.i) annotation (Line(
              points={{68,-70},{0,-70},{0,-60}}, color={0,0,127}));
          connect(voltagesensor.v, meanVoltage.u) annotation (Line(
              points={{60,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
          connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
              points={{60,10},{68,10}}, color={0,0,127}));
          connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
              points={{-20,40},{50,40},{50,20}}, color={0,0,255}));
          connect(currentSensor.p, voltagesensor.n) annotation (Line(
              points={{10,-50},{50,-50},{50,0}}, color={0,0,255}));
          connect(star.plug_p, sineVoltage_p.plug_n) annotation (Line(
              points={{-70,-20},{-70,0}}, color={0,0,255}));
          connect(star.pin_n, currentSensor.n) annotation (Line(
              points={{-70,-40},{-70,-50},{-10,-50}}, color={0,0,255}));
          connect(rectifier.ac, sineVoltage_p.plug_p) annotation (Line(
              points={{-40,40},{-70,40},{-70,20}}, color={0,0,255}));
          connect(resistor.n, currentSensor.p) annotation (Line(
              points={{30,20},{30,-50},{10,-50}}, color={0,0,255}));
          connect(rectifier.dc_p, resistor.p) annotation (Line(
              points={{-20,40},{30,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows an uncontrolled <code>m</code> pulse center tap diode rectifier with resistive load, where <code>m</code> is the number of phases.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end DiodeCenterTapmPulse;

        model ThyristorCenterTapmPulse_R
          "2*m pulse thyristor rectifier with center tap and resistive load"
          extends ExampleTemplates.ThyristorCenterTapmPulse(pulsem(
                constantFiringAngle=constantFiringAngle));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Angle constantFiringAngle=30*pi/180
            "Firing angle";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(resistor.n, currentSensor.p) annotation (Line(
              points={{30,20},{30,-50},{10,-50}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows a controlled <code>m</code> pulse center tap rectifier with resistive load, where <code>m</code> is the number of phases.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end ThyristorCenterTapmPulse_R;

        model ThyristorCenterTapmPulse_RL
          "2*m pulse thyristor rectifier with center tap and R-L load"
          extends ExampleTemplates.ThyristorCenterTapmPulse(pulsem(
                constantFiringAngle=constantFiringAngle));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Angle constantFiringAngle=30*pi/180
            "Firing angle";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          parameter Modelica.SIunits.Inductance L=1 "Load resistance"
            annotation (Evaluate=true);
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(fixed=true,
                start=0)) annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(resistor.n, inductor.p) annotation (Line(
              points={{30,20},{30,10}}, color={0,0,255}));
          connect(inductor.n, currentSensor.p) annotation (Line(
              points={{30,-10},{30,-50},{10,-50}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows a controlled <code>m</code> pulse center tap rectifier with R-L load, where <code>m</code> is the number of phases.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end ThyristorCenterTapmPulse_RL;

        model ThyristorCenterTapmPulse_RLV
          "2*m pulse thyristor rectifier with center tap and R-L load and voltage"
          extends ExampleTemplates.ThyristorCenterTapmPulse(pulsem(
                constantFiringAngle=constantFiringAngle));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Angle constantFiringAngle=30*pi/180
            "Firing angle";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          parameter Modelica.SIunits.Inductance L=1 "Load resistance"
            annotation (Evaluate=true);
          parameter Modelica.SIunits.Voltage VDC=-50 "DC load offset voltage";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(fixed=true,
                start=0)) annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=
                VDC) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={30,-30})));
        equation
          connect(resistor.n, inductor.p) annotation (Line(
              points={{30,20},{30,10}}, color={0,0,255}));
          connect(inductor.n, constantVoltage.p) annotation (Line(
              points={{30,-10},{30,-10},{30,-20}}, color={0,0,255}));
          connect(constantVoltage.n, currentSensor.p) annotation (Line(
              points={{30,-40},{30,-40},{30,-48},{30,-48},{30,-50},{10,-50}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows a controlled <code>m</code> pulse center tap rectifier with R-L load including DC voltage source, where <code>m</code> is the number of phases. The additional DC voltage source in this example enables negative average load voltages.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end ThyristorCenterTapmPulse_RLV;

        model ThyristorCenterTapmPulse_RLV_Characteristic
          "Characteristic of 2*m pulse thyristor rectifier with center tap and R-L load and voltage"
          extends ExampleTemplates.ThyristorCenterTapmPulse(pulsem(
                useConstantFiringAngle=false));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          parameter Modelica.SIunits.Inductance L=1 "Load resistance"
            annotation (Evaluate=true);
          parameter Modelica.SIunits.Voltage VDC=-50 "DC load offset voltage";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(fixed=true,
                start=0)) annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=
                VDC) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={30,-30})));
          Modelica.Blocks.Sources.Ramp ramp(height=pi, duration=10) annotation (
             Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=270,
                origin={-30,-70})));
        equation
          connect(resistor.n, inductor.p) annotation (Line(
              points={{30,20},{30,10}}, color={0,0,255}));
          connect(inductor.n, constantVoltage.p) annotation (Line(
              points={{30,-10},{30,-20}}, color={0,0,255}));
          connect(currentSensor.p, constantVoltage.n) annotation (Line(
              points={{10,-50},{30,-50},{30,-40}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
          connect(ramp.y, pulsem.firingAngle) annotation (Line(
              points={{-30,-59},{-30,-12}}, color={0,0,127}));
          annotation (
            experiment(
              StopTime=10,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows a controlled <code>m</code> pulse center tap rectifier with R-L load including DC voltage source, where <code>m</code> is the number of phases. The additional DC voltage source in this example enables negative average load voltages.</p>

<p>Plot average voltage <code>meanVoltage.v</code> versus firingAngle <code>pulsem.firingAngle</code> to see control characteristic of this type of rectifier with R-L load including active voltage.</p>
</html>"));
        end ThyristorCenterTapmPulse_RLV_Characteristic;
        annotation (Documentation(info="<html>
<p>This package includes polyphase center tap rectifiers. The number of phases, <code>m</code>, equals the number of pulses. The examples show uncontrolled and controlled rectifiers with constant and variable firing angle.</p>
</html>"));
      end RectifierCenterTapmPulse;

      package RectifierBridge2mPulse "2*m pulse rectifier bridge"
        extends Modelica.Icons.ExamplesPackage;
        model DiodeBridge2mPulse
          "2*m pulse diode rectifier bridge with resistive load"
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Integer m(final min=3) = 3 "Number of phases";
          parameter Modelica.SIunits.Voltage Vrms=110 "RMS supply voltage";
          parameter Modelica.SIunits.Frequency f=50 "Frequency";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";

          Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
            final m=m,
            V=fill(sqrt(2)*Vrms, m),
            phase=-
                Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
            freqHz=fill(f, m)) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-80,-30})));
          Modelica.Electrical.PowerConverters.ACDC.DiodeBridge2mPulse rectifier(
              final m=m)
            annotation (Placement(transformation(extent={{-40,24},{-20,44}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
            annotation (Placement(transformation(
                origin={50,10},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Blocks.Math.Mean meanVoltage(f=2*m*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,40})));
          Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=2*m*f)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={80,10})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,-40})));
          Modelica.Blocks.Math.Mean meanCurrent(f=2*m*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,-60})));
          Modelica.Electrical.Polyphase.Basic.MultiStarResistance
            multiStarResistance(final m=m) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-80,-60})));
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(extent={{-90,-100},{-70,-80}})));
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(meanCurrent.u, currentSensor.i) annotation (Line(
              points={{68,-60},{0,-60},{0,-50}}, color={0,0,127}));
          connect(voltagesensor.v, meanVoltage.u) annotation (Line(
              points={{60,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
          connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
              points={{60,10},{68,10}}, color={0,0,127}));
          connect(sineVoltage.plug_p, rectifier.ac) annotation (Line(
              points={{-80,-20},{-80,34},{-40,34}}, color={0,0,255}));
          connect(rectifier.dc_n, currentSensor.n) annotation (Line(
              points={{-19.8,28},{-10,28},{-10,-40}}, color={0,0,255}));
          connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
              points={{-20,40},{50,40},{50,20}}, color={0,0,255}));
          connect(currentSensor.p, voltagesensor.n) annotation (Line(
              points={{10,-40},{50,-40},{50,0}}, color={0,0,255}));
          connect(sineVoltage.plug_n, multiStarResistance.plug) annotation (
              Line(
              points={{-80,-40},{-80,-50}}, color={0,0,255}));
          connect(multiStarResistance.pin, ground.p) annotation (Line(
              points={{-80,-70},{-80,-80}}, color={0,0,255}));
          connect(resistor.n, currentSensor.p) annotation (Line(
              points={{30,20},{30,-40},{10,-40}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows an uncontrolled <code>2*m</code> pulse diode bridge rectifier with resistive load, where <code>m</code> is the number of phases.</p>

<p><code>2*m</code> pulse diode bridge example, where <code>m</code> is the number of phases.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end DiodeBridge2mPulse;

        model HalfControlledBridge2mPulse
          "2*m pulse half controlled rectifier bridge with resistive load"
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Integer m(final min=3) = 3 "Number of phases";
          parameter Modelica.SIunits.Voltage Vrms=110 "RMS supply voltage";
          parameter Modelica.SIunits.Frequency f=50 "Frequency";
          parameter Modelica.SIunits.Angle constantFiringAngle=30*pi/180
            "Firing angle";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";

          Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
            final m=m,
            V=fill(sqrt(2)*Vrms, m),
            phase=-
                Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
            freqHz=fill(f, m)) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-80,-30})));
          Modelica.Electrical.PowerConverters.ACDC.HalfControlledBridge2mPulse
            rectifier(final m=m, offStart_p=fill(true, m))
            annotation (Placement(transformation(extent={{-40,24},{-20,44}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
            annotation (Placement(transformation(
                origin={50,10},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Blocks.Math.Mean meanVoltage(f=2*m*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,40})));
          Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=2*m*f)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={80,10})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,-40})));
          Modelica.Blocks.Math.Mean meanCurrent(f=2*m*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,-60})));
          Modelica.Electrical.PowerConverters.ACDC.Control.VoltageBridge2mPulse
            pulse2m(
            m=m,
            f=f,
            useFilter=false,
            constantFiringAngle=constantFiringAngle) annotation (Placement(
                transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-30,0})));
          Modelica.Electrical.Polyphase.Basic.MultiStarResistance
            multiStarResistance(final m=m) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-80,-60})));
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(extent={{-90,-100},{-70,-80}})));
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(meanCurrent.u, currentSensor.i) annotation (Line(
              points={{68,-60},{0,-60},{0,-50}}, color={0,0,127}));
          connect(voltagesensor.v, meanVoltage.u) annotation (Line(
              points={{60,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
          connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
              points={{60,10},{68,10}}, color={0,0,127}));
          connect(sineVoltage.plug_p, rectifier.ac) annotation (Line(
              points={{-80,-20},{-80,34},{-40,34}}, color={0,0,255}));
          connect(rectifier.dc_n, currentSensor.n) annotation (Line(
              points={{-20,28},{-10,28},{-10,-40}}, color={0,0,255}));
          connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
              points={{-20,40},{50,40},{50,20}}, color={0,0,255}));
          connect(currentSensor.p, voltagesensor.n) annotation (Line(
              points={{10,-40},{50,-40},{50,0}}, color={0,0,255}));
          connect(pulse2m.fire_p, rectifier.fire_p) annotation (Line(
              points={{-36,11},{-36,22}}, color={255,0,255}));
          connect(pulse2m.ac, sineVoltage.plug_p) annotation (Line(
              points={{-40,0},{-80,0},{-80,-20}}, color={0,0,255}));
          connect(sineVoltage.plug_n, multiStarResistance.plug) annotation (
              Line(
              points={{-80,-40},{-80,-50}}, color={0,0,255}));
          connect(multiStarResistance.pin, ground.p) annotation (Line(
              points={{-80,-70},{-80,-80}}, color={0,0,255}));
          connect(resistor.n, currentSensor.p) annotation (Line(
              points={{30,20},{30,-40},{10,-40}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows a half controlled <code>2*m</code> pulse bridge rectifier with resistive load, where <code>m</code> is the number of phases. In case of resistive load the half controlled bridge shows the same output voltage as the
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse.ThyristorBridge2mPulse_R\">full controlled bridge</a>.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>

</html>"));
        end HalfControlledBridge2mPulse;

        model ThyristorBridge2mPulse_R
          "2*m pulse thyristor rectifier bridge with resistive load"
          extends ExampleTemplates.ThyristorBridge2mPulse(pulse2m(
                constantFiringAngle=constantFiringAngle));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Angle constantFiringAngle=30*pi/180
            "Firing angle";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(resistor.n, currentSensor.p) annotation (Line(
              points={{30,20},{30,-40},{10,-40}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows a full controlled <code>2*m</code> pulse bridge rectifier with resistive load, where <code>m</code> is the number of phases. In case of resistive load the full controlled bridge shows the same output voltage as the
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse.HalfControlledBridge2mPulse\">half controlled bridge</a>.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end ThyristorBridge2mPulse_R;

        model ThyristorBridge2mPulse_RL
          "2*m pulse thyristor rectifier bridge with R-L load"
          extends ExampleTemplates.ThyristorBridge2mPulse(pulse2m(
                constantFiringAngle=constantFiringAngle), rectifier(offStart_p=
                  fill(true, m), offStart_n=fill(true, m)));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Angle constantFiringAngle=30*pi/180
            "Firing angle";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          parameter Modelica.SIunits.Inductance L=1 "Load resistance"
            annotation (Evaluate=true);
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(start=0,
                fixed=true)) annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(resistor.n, inductor.p) annotation (Line(
              points={{30,20},{30,10}}, color={0,0,255}));
          connect(inductor.n, currentSensor.p) annotation (Line(
              points={{30,-10},{30,-40},{10,-40}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows a full controlled <code>2*m</code> pulse bridge rectifier with R-L load, where <code>m</code> is the number of phases.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end ThyristorBridge2mPulse_RL;

        model ThyristorBridge2mPulse_RLV
          "2*m pulse thyristor rectifier bridge with R-L load and voltage"
          extends ExampleTemplates.ThyristorBridge2mPulse(pulse2m(
                constantFiringAngle=constantFiringAngle));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Angle constantFiringAngle=30*pi/180
            "Firing angle";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          parameter Modelica.SIunits.Inductance L=1 "Load resistance"
            annotation (Evaluate=true);
          parameter Modelica.SIunits.Voltage VDC=-260 "DC load offset voltage";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(start=0,
                fixed=true)) annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=
                VDC) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={30,-30})));
        equation
          connect(resistor.n, inductor.p) annotation (Line(
              points={{30,20},{30,10}}, color={0,0,255}));
          connect(inductor.n, constantVoltage.p) annotation (Line(
              points={{30,-10},{30,-20}}, color={0,0,255}));
          connect(constantVoltage.n, currentSensor.p) annotation (Line(
              points={{30,-40},{10,-40}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows a full controlled <code>2*m</code> pulse bridge rectifier with R-L load including DC voltage source, where <code>m</code> is the number of phases. The additional DC voltage source in this example enables negative average load voltages.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end ThyristorBridge2mPulse_RLV;

        model ThyristorBridge2mPulse_RLV_Characteristic
          "Characteristic of 2*m pulse thyristor rectifier bridge with R-L load and voltage"
          extends ExampleTemplates.ThyristorBridge2mPulse(pulse2m(
                useConstantFiringAngle=false));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Voltage Vdi0=
              Modelica.Electrical.Polyphase.Functions.factorY2DC(m)*Vrms
            "Ideal max. DC voltage";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          parameter Modelica.SIunits.Inductance L=1 "Load resistance"
            annotation (Evaluate=true);
          parameter Modelica.SIunits.Voltage VDC=-260 "DC load offset voltage";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(fixed=true,
                start=0)) annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=
                VDC) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={30,-30})));
          Modelica.Blocks.Sources.Ramp ramp(height=pi, duration=10) annotation (
             Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=270,
                origin={-30,-50})));
        equation
          connect(resistor.n, inductor.p) annotation (Line(
              points={{30,20},{30,10}}, color={0,0,255}));
          connect(inductor.n, constantVoltage.p) annotation (Line(
              points={{30,-10},{30,-20}}, color={0,0,255}));
          connect(currentSensor.p, constantVoltage.n) annotation (Line(
              points={{10,-40},{30,-40}}, color={0,0,255}));
          connect(ramp.y, pulse2m.firingAngle) annotation (Line(
              points={{-30,-39},{-30,-12}}, color={0,0,127}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=10,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows a full controlled <code>2*m</code> pulse bridge rectifier with R-L load including DC voltage source, where <code>m</code> is the number of phases. The additional DC voltage source in this example enables negative average load voltages.</p>

<p>Plot average voltage <code>meanVoltage.v</code> versus firingAngle <code>pulse2m.firingAngle</code> to see control characteristic of this type of rectifier with R-L load including active voltage.</p>
</html>"));
        end ThyristorBridge2mPulse_RLV_Characteristic;

        model ThyristorBridge2mPulse_DC_Drive
          "2*m pulse thyristor bridge feeding a DC drive"
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Integer m(final min=3) = 3 "Number of phases";
          parameter Modelica.SIunits.Voltage Vrms=dcpmData.VaNominal/
              Modelica.Electrical.Polyphase.Functions.factorY2DC(m)
            "RMS supply voltage";
          parameter Modelica.SIunits.Frequency f=50 "Frequency";
          parameter Modelica.SIunits.ApparentPower SMains=250E3
            "Mains short circuit apparent power";
          parameter Real lamdaMains=0.1 "Mains short circuit power factor";
          final parameter Modelica.SIunits.Impedance ZMains=Vrms^2/SMains*m
            "Mains short circuit impedance";
          final parameter Modelica.SIunits.Resistance RMains=ZMains*lamdaMains
            "Mains resistance" annotation (Evaluate=true);
          final parameter Modelica.SIunits.Inductance LMains=ZMains*sqrt(1 -
              lamdaMains^2)/(2*pi*f) "Mains inductance"
            annotation (Evaluate=true);
          parameter Modelica.SIunits.Inductance Ld=3*dcpmData.La
            "Smoothing inductance" annotation (Evaluate=true);
          final parameter Modelica.SIunits.Torque tauNominal=dcpmData.ViNominal
              *dcpmData.IaNominal/dcpmData.wNominal "Nominal torque";
          output Modelica.SIunits.AngularVelocity w(displayUnit="rpm") = dcpm.wMechanical;
          output Modelica.SIunits.Torque tau=dcpm.tauShaft;
          Modelica.Electrical.Polyphase.Sources.SineVoltage sinevoltage(
            m=m,
            each final V=fill(sqrt(2)*Vrms, m),
            each freqHz=fill(f, m)) annotation (Placement(transformation(
                origin={-80,0},
                extent={{-10,-10},{10,10}},
                rotation=-90)));
          Modelica.Electrical.PowerConverters.ACDC.ThyristorBridge2mPulse
            rectifier(useHeatPort=false, m=m)
            annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
            annotation (Placement(transformation(
                origin={50,10},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Blocks.Math.Mean meanVoltage(f=2*m*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,40})));
          Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=2*m*f)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={80,10})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,-40})));
          Modelica.Blocks.Math.Mean meanCurrent(f=2*m*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,-60})));
          Modelica.Electrical.PowerConverters.ACDC.Control.VoltageBridge2mPulse
            pulse2(
            useConstantFiringAngle=false,
            useFilter=true,
            m=m) annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-38,-40})));
          Modelica.Electrical.Analog.Basic.Inductor inductor(L=Ld) annotation (
              Placement(transformation(
                origin={30,-10},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet
            dcpm(
            VaNominal=dcpmData.VaNominal,
            IaNominal=dcpmData.IaNominal,
            wNominal=dcpmData.wNominal,
            TaNominal=dcpmData.TaNominal,
            Ra=dcpmData.Ra,
            TaRef=dcpmData.TaRef,
            La=dcpmData.La,
            Jr=dcpmData.Jr,
            useSupport=false,
            Js=dcpmData.Js,
            frictionParameters=dcpmData.frictionParameters,
            coreParameters=dcpmData.coreParameters,
            strayLoadParameters=dcpmData.strayLoadParameters,
            brushParameters=dcpmData.brushParameters,
            phiMechanical(fixed=true),
            wMechanical(fixed=true, start=dcpmData.wNominal),
            TaOperational=293.15,
            alpha20a=dcpmData.alpha20a,
            ia(start=0, fixed=true)) annotation (Placement(transformation(
                  extent={{10,-90},{30,-70}})));
          parameter
            Modelica.Electrical.Machines.Utilities.ParameterRecords.DcPermanentMagnetData
            dcpmData "Data record of PM excited DC machine"
            annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
          Modelica.Mechanics.Rotational.Sources.Torque torque
            annotation (Placement(transformation(extent={{60,-90},{40,-70}})));
          Modelica.Blocks.Sources.Ramp ramp(
            duration=10,
            startTime=5,
            height=tauNominal,
            offset=-tauNominal)
            annotation (Placement(transformation(extent={{90,-90},{70,-70}})));
          Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(
                transformation(
                extent={{10,-10},{-10,10}},
                rotation=270,
                origin={-38,-70})));
          Modelica.Electrical.Polyphase.Basic.Resistor rMains(m=m, R=fill(
                RMains, m)) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-80,30})));
          Modelica.Electrical.Polyphase.Basic.Inductor lMains(m=m, L=fill(
                LMains, m)) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-80,60})));
          Modelica.Electrical.Polyphase.Basic.MultiStarResistance earthing(m=m)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-80,-30})));
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(extent={{-30,-60},{-10,-40}})));
        initial equation
          lMains.i[1:m - 1] = zeros(m - 1);


        equation
          connect(meanCurrent.u, currentSensor.i) annotation (Line(
              points={{68,-60},{0,-60},{0,-50}}, color={0,0,127}));
          connect(voltagesensor.v, meanVoltage.u) annotation (Line(
              points={{60,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
          connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
              points={{60,10},{68,10}}, color={0,0,127}));
          connect(rectifier.dc_n, currentSensor.n) annotation (Line(
              points={{-28,-6},{-10,-6},{-10,-40}}, color={0,0,255}));
          connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
              points={{-28,6},{-10,6},{-10,40},{50,40},{50,20}}, color={0,0,255}));
          connect(voltagesensor.n, currentSensor.p) annotation (Line(
              points={{50,0},{50,-40},{10,-40}}, color={0,0,255}));
          connect(pulse2.fire_p, rectifier.fire_p) annotation (Line(
              points={{-44,-29},{-44,-12}}, color={255,0,255}));
          connect(pulse2.fire_n, rectifier.fire_n) annotation (Line(
              points={{-32,-29},{-32,-12}}, color={255,0,255}));
          connect(inductor.n, dcpm.pin_ap) annotation (Line(
              points={{30,-20},{30,-70},{26,-70}}, color={0,0,255}));
          connect(torque.flange, dcpm.flange) annotation (Line(
              points={{40,-80},{30,-80}}));
          connect(ramp.y, torque.tau) annotation (Line(
              points={{69,-80},{62,-80}}, color={0,0,127}));
          connect(rectifier.dc_p, inductor.p) annotation (Line(
              points={{-28,6},{-10,6},{-10,40},{30,40},{30,0}}, color={0,0,255}));
          connect(currentSensor.p, dcpm.pin_an) annotation (Line(
              points={{10,-40},{10,-70},{14,-70}}, color={0,0,255}));
          connect(const.y, pulse2.firingAngle) annotation (Line(
              points={{-38,-59},{-38,-52}}, color={0,0,127}));
          connect(rMains.plug_p, sinevoltage.plug_p) annotation (Line(
              points={{-80,20},{-80,10}}, color={0,0,255}));
          connect(lMains.plug_p, rMains.plug_n) annotation (Line(
              points={{-80,50},{-80,40}}, color={0,0,255}));
          connect(lMains.plug_n, rectifier.ac) annotation (Line(
              points={{-80,70},{-60,70},{-60,0},{-48,0}}, color={0,0,255}));
          connect(rectifier.ac, pulse2.ac) annotation (Line(
              points={{-48,0},{-60,0},{-60,-40},{-48,-40}}, color={0,0,255}));
          connect(sinevoltage.plug_n, earthing.plug) annotation (Line(
              points={{-80,-10},{-80,-20}}, color={0,0,255}));
          connect(rectifier.dc_n, ground.p) annotation (Line(
              points={{-28,-6},{-20,-6},{-20,-40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=15,
              Interval=0.0002,
              Tolerance=1e-006),
            Documentation(info="<html>
<p>
In this example a PM excited DC machine is started with nominal torque at nominal speed. After 5 seconds, load torque is reduced to zero over a period of additional 10 seconds. At 15 seconds, the machine is operating at no load.
</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end ThyristorBridge2mPulse_DC_Drive;
        annotation (Documentation(info="<html>
<p>This package includes polyphase bridge rectifiers. The number of phases, <code>m</code>, determines the number of pulses, <code>2*m</code>. The examples show uncontrolled and controlled rectifiers with constant and variable firing angle.</p>
</html>"));
      end RectifierBridge2mPulse;

      package RectifierCenterTap2mPulse "2*m pulse rectifier with center tap"
        extends Modelica.Icons.ExamplesPackage;
        model DiodeCenterTap2mPulse
          "2*m pulse diode center tap rectifier with resistive load"
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Integer m(final min=3) = 3 "Number of phases";
          parameter Modelica.SIunits.Voltage Vrms=110 "RMS supply voltage";
          parameter Modelica.SIunits.Frequency f=50 "Frequency";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";

          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(extent={{-90,-100},{-70,-80}})));
          Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
             Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-100,-10})));
          Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage_p(
            final m=m,
            V=fill(sqrt(2)*Vrms, m),
            phase=-
                Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
            freqHz=fill(f, m)) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-70,10})));
          Modelica.Electrical.PowerConverters.ACDC.DiodeCenterTap2mPulse
            rectifier(final m=m)
            annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
            annotation (Placement(transformation(
                origin={50,10},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Blocks.Math.Mean meanVoltage(f=2*m*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,40})));
          Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=2*m*f)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={80,10})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,-50})));
          Modelica.Blocks.Math.Mean meanCurrent(f=2*m*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,-70})));
          Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage_n(
            final m=m,
            V=fill(sqrt(2)*Vrms, m),
            phase=-
                Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
            freqHz=fill(f, m)) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-70,-20})));
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(star.pin_n, ground.p) annotation (Line(
              points={{-100,-20},{-100,-50},{-80,-50},{-80,-80}}, color={0,0,255}));
          connect(meanCurrent.u, currentSensor.i) annotation (Line(
              points={{68,-70},{0,-70},{0,-60}}, color={0,0,127}));
          connect(voltagesensor.v, meanVoltage.u) annotation (Line(
              points={{60,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
          connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
              points={{60,10},{68,10}}, color={0,0,127}));
          connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
              points={{-20,40},{50,40},{50,20}}, color={0,0,255}));
          connect(currentSensor.p, voltagesensor.n) annotation (Line(
              points={{10,-50},{50,-50},{50,0}}, color={0,0,255}));
          connect(sineVoltage_p.plug_n, sineVoltage_n.plug_p) annotation (Line(
              points={{-70,0},{-70,
                  -10}}, color={0,0,255}));
          connect(sineVoltage_n.plug_n, rectifier.ac_n) annotation (Line(
              points={{-70,-30},{-70,-40},{-50,-40},{-50,34},{-40,34}}, color={0,0,255}));
          connect(sineVoltage_p.plug_p, rectifier.ac_p) annotation (Line(
              points={{-70,20},{-70,46},{-40,46}}, color={0,0,255}));
          connect(star.plug_p, sineVoltage_p.plug_n) annotation (Line(
              points={{-100,0},{-70,0}}, color={0,0,255}));
          connect(star.pin_n, currentSensor.n) annotation (Line(
              points={{-100,-20},{-100,-50},{-10,-50}}, color={0,0,255}));
          connect(resistor.n, currentSensor.p) annotation (Line(
              points={{30,20},{30,-50},{10,-50}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows an uncontrolled <code>2*m</code> pulse center tap diode rectifier with resistive load, where <code>m</code> is the number of phases.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end DiodeCenterTap2mPulse;

        model ThyristorCenterTap2mPulse_R
          "2*m pulse thyristor center tap rectifier with resistive load"
          extends ExampleTemplates.ThyristorCenterTap2mPulse(pulse2m(
                constantFiringAngle=constantFiringAngle));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Angle constantFiringAngle=30*pi/180
            "Firing angle";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(resistor.n, currentSensor.p) annotation (Line(
              points={{30,20},{30,-50},{10,-50}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows a controlled <code>2*m</code> pulse center tap rectifier with resistive load, where <code>m</code> is the number of phases.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end ThyristorCenterTap2mPulse_R;

        model ThyristorCenterTap2mPulse_RL
          "2*m pulse thyristor rectifier with R-L load"
          extends ExampleTemplates.ThyristorCenterTap2mPulse(pulse2m(
                constantFiringAngle=constantFiringAngle));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Angle constantFiringAngle=30*pi/180
            "Firing angle";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          parameter Modelica.SIunits.Inductance L=1 "Load resistance"
            annotation (Evaluate=true);
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(fixed=true,
                start=0)) annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(resistor.n, inductor.p) annotation (Line(
              points={{30,20},{30,10}}, color={0,0,255}));
          connect(inductor.n, currentSensor.p) annotation (Line(
              points={{30,-10},{30,-50},{10,-50}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows a controlled <code>2*m</code> pulse center tap rectifier with R-L load, where <code>m</code> is the number of phases.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end ThyristorCenterTap2mPulse_RL;

        model ThyristorCenterTap2mPulse_RLV
          "2*m pulse thyristor center tap rectifier with R-L load and voltage"
          extends ExampleTemplates.ThyristorCenterTap2mPulse(pulse2m(
                constantFiringAngle=constantFiringAngle));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Angle constantFiringAngle=30*pi/180
            "Firing angle";
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          parameter Modelica.SIunits.Inductance L=1 "Load resistance"
            annotation (Evaluate=true);
          parameter Modelica.SIunits.Voltage VDC=-260 "DC load offset voltage";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(start=0,
                fixed=true)) annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=
                VDC) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={30,-30})));
        equation
          connect(resistor.n, inductor.p) annotation (Line(
              points={{30,20},{30,10}}, color={0,0,255}));
          connect(inductor.n, constantVoltage.p) annotation (Line(
              points={{30,-10},{30,-20}}, color={0,0,255}));
          connect(constantVoltage.n, currentSensor.p) annotation (Line(
              points={{30,-40},{30,-40},{30,-48},{30,-48},{30,-50},{10,-50}}, color={0,0,255}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows a controlled <code>2*m</code> pulse center tap rectifier with R-L load including DC voltage source, where <code>m</code> is the number of phases. The additional DC voltage source in this example enables negative average load voltages.</p>

<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end ThyristorCenterTap2mPulse_RLV;

        model ThyristorCenterTap2mPulse_RLV_Characteristic
          "Characteristic of 2*m pulse center tap thyristor rectifier with R-L load and voltage"
          extends ExampleTemplates.ThyristorCenterTap2mPulse(pulse2m(
                useConstantFiringAngle=false));
          extends Modelica.Icons.Example;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Resistance R=20 "Load resistance";
          parameter Modelica.SIunits.Inductance L=1 "Load resistance"
            annotation (Evaluate=true);
          parameter Modelica.SIunits.Voltage VDC=-260 "DC load offset voltage";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                origin={30,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(start=0,
                fixed=true)) annotation (Placement(transformation(
                origin={30,0},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=
                VDC) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={30,-30})));
          Modelica.Blocks.Sources.Ramp ramp(height=pi, duration=10) annotation (
             Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=270,
                origin={-30,-70})));
        equation
          connect(resistor.n, inductor.p) annotation (Line(
              points={{30,20},{30,10}}, color={0,0,255}));
          connect(inductor.n, constantVoltage.p) annotation (Line(
              points={{30,-10},{30,-20}}, color={0,0,255}));
          connect(currentSensor.p, constantVoltage.n) annotation (Line(
              points={{10,-50},{30,-50},{30,-40}}, color={0,0,255}));
          connect(ramp.y, pulse2m.firingAngle) annotation (Line(
              points={{-30,-59},{-30,-12}}, color={0,0,127}));
          connect(resistor.p, rectifier.dc_p) annotation (Line(
              points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=10,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>This example shows a controlled <code>2*m</code> pulse center tap rectifier with R-L load including DC voltage source, where <code>m</code> is the number of phases. The additional DC voltage source in this example enables negative average load voltages.</p>

<p>Plot average voltage <code>meanVoltage.v</code> versus firingAngle <code>pulsem.firingAngle</code> to see control characteristic of this type of rectifier with R-L load including active voltage.</p>
</html>"));
        end ThyristorCenterTap2mPulse_RLV_Characteristic;
        annotation (Documentation(info="<html>
<p>This package includes polyphase center tap rectifiers. The number of phases, <code>m</code>, determines the number of pulses, <code>2*m</code>. The examples show uncontrolled and controlled rectifiers with constant and variable firing angle.</p>
</html>"));
      end RectifierCenterTap2mPulse;

      package ExampleTemplates "Templates of examples"
        extends Modelica.Icons.Package;
        partial model Thyristor1Pulse "Template of single pulse rectifier"
          extends Icons.ExampleTemplate;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Voltage Vrms=110 "RMS supply voltage";
          parameter Modelica.SIunits.Frequency f=50 "Frequency";

          Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
            annotation (Placement(transformation(
                origin={50,10},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Sources.SineVoltage sinevoltage(V=sqrt(2)*
                Vrms, freqHz=f) annotation (Placement(transformation(
                origin={-80,0},
                extent={{-10,-10},{10,10}},
                rotation=-90)));
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(
                origin={-80,-50},
                extent={{-10,-10},{10,10}})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,-40})));
          Modelica.Blocks.Math.Mean meanVoltage(f=f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,40})));
          Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=f)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={80,10})));
          Modelica.Blocks.Math.Mean meanCurrent(f=f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,-60})));
          Modelica.Electrical.PowerConverters.ACDC.Control.VoltageBridge2Pulse
            pulse2(f=f, useFilter=false) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={-40,0})));
          Modelica.Electrical.Analog.Ideal.IdealThyristor idealthyristor(off(
                fixed=true)) annotation (Placement(transformation(
                origin={-10,40},
                extent={{-10,10},{10,-10}})));
        equation
          connect(meanCurrent.u, currentSensor.i) annotation (Line(
              points={{68,-60},{0,-60},{0,-51}}, color={0,0,127}));
          connect(ground.p, sinevoltage.n) annotation (Line(
              points={{-80,-40},{-80,-10}}, color={0,0,255}));
          connect(voltagesensor.v, meanVoltage.u) annotation (Line(
              points={{61,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
          connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
              points={{61,10},{68,10}}, color={0,0,127}));
          connect(sinevoltage.p, idealthyristor.p) annotation (Line(
              points={{-80,10},{-80,40},{-20,40}}, color={0,0,255}));
          connect(ground.p, currentSensor.n) annotation (Line(
              points={{-80,-40},{-10,-40}}, color={0,0,255}));
          connect(pulse2.fire_p, idealthyristor.fire) annotation (Line(
              points={{-46,11},{-46,20},{0,20},{0,28}},   color={255,0,255}));
          connect(voltagesensor.n, currentSensor.p) annotation (Line(
              points={{50,0},{50,-40},{10,-40}}, color={0,0,255}));
          connect(idealthyristor.n, voltagesensor.p) annotation (Line(
              points={{0,40},{50,40},{50,20}}, color={0,0,255}));
          connect(sinevoltage.p, pulse2.ac_p) annotation (Line(
              points={{-80,10},{-80,10},{-80,20},{-60,20},{-60,6},{-50,6}}, color={0,0,255}));
          connect(sinevoltage.n, pulse2.ac_n) annotation (Line(
              points={{-80,-10},{-80,-10},{-80,-20},{-60,-20},{-60,-6},{-50,-6}}, color={0,0,255}));
          annotation (
            Documentation(info="<html>
<p>Template of
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.Rectifier1Pulse\">
single pulse rectifiers</a>; load is not yet included.</p>
</html>"));
        end Thyristor1Pulse;

        partial model ThyristorBridge2Pulse
          "Template of two pulse Graetz thyristor bridge"
          extends Icons.ExampleTemplate;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Voltage Vrms=110 "RMS supply voltage";
          parameter Modelica.SIunits.Frequency f=50 "Frequency";

          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(
                origin={-80,-50},
                extent={{-10,-10},{10,10}})));
          Modelica.Electrical.Analog.Sources.SineVoltage sinevoltage(V=sqrt(2)*
                Vrms, freqHz=f) annotation (Placement(transformation(
                origin={-80,20},
                extent={{-10,-10},{10,10}},
                rotation=-90)));
          Modelica.Electrical.PowerConverters.ACDC.ThyristorBridge2Pulse
            rectifier(useHeatPort=false, offStart_p1=true)
            annotation (Placement(transformation(extent={{-40,24},{-20,44}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
            annotation (Placement(transformation(
                origin={50,10},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Blocks.Math.Mean meanVoltage(f=2*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,40})));
          Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=2*f)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={80,10})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,-40})));
          Modelica.Blocks.Math.Mean meanCurrent(f=2*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,-60})));
          Modelica.Electrical.PowerConverters.ACDC.Control.VoltageBridge2Pulse
            pulse2(f=f, useFilter=false) annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-30,-2})));
        equation
          connect(meanCurrent.u, currentSensor.i) annotation (Line(
              points={{68,-60},{0,-60},{0,-51}}, color={0,0,127}));
          connect(ground.p, sinevoltage.n) annotation (Line(
              points={{-80,-40},{-80,10}}, color={0,0,255}));
          connect(voltagesensor.v, meanVoltage.u) annotation (Line(
              points={{61,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
          connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
              points={{61,10},{68,10}}, color={0,0,127}));
          connect(sinevoltage.p, rectifier.ac_p) annotation (Line(
              points={{-80,30},{-80,40},{-40,40}}, color={0,0,255}));
          connect(sinevoltage.n, rectifier.ac_n) annotation (Line(
              points={{-80,10},{-80,10},{-80,-8},{-50,-8},{-50,28},{-40,28}}, color={0,0,255}));
          connect(rectifier.dc_n, currentSensor.n) annotation (Line(
              points={{-20,28},{-10,28},{-10,-40}}, color={0,0,255}));
          connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
              points={{-20,40},{50,40},{50,20}}, color={0,0,255}));
          connect(voltagesensor.n, currentSensor.p) annotation (Line(
              points={{50,0},{50,-40},{10,-40}}, color={0,0,255}));
          connect(pulse2.fire_p, rectifier.fire_p) annotation (Line(
              points={{-36,9},{-36,22}}, color={255,0,255}));
          connect(pulse2.fire_n, rectifier.fire_n) annotation (Line(
              points={{-24,9},{-24,22}}, color={255,0,255}));
          connect(pulse2.ac_p, rectifier.ac_p) annotation (Line(
              points={{-40,4},{-60,4},{-60,40},{-40,40}}, color={0,0,255}));
          connect(rectifier.ac_n, pulse2.ac_n) annotation (Line(
              points={{-40,28},{-50,28},{-50,-8},{-40,-8}}, color={0,0,255}));
          annotation (
            Documentation(info="<html>
<p>Template of
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2Pulse\">
two pulse bridge rectifiers</a>; load is not yet included.</p>
</html>"));
        end ThyristorBridge2Pulse;

        partial model ThyristorCenterTap2Pulse
          "Template of two pulse thyristor rectifier with center tap"
          extends Icons.ExampleTemplate;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Voltage Vrms=110 "RMS supply voltage";
          parameter Modelica.SIunits.Frequency f=50 "Frequency";

          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(
                origin={-90,-50},
                extent={{-10,-10},{10,10}})));
          Modelica.Electrical.Analog.Sources.SineVoltage sinevoltage_n(V=sqrt(2)
                *Vrms,freqHz=f) annotation (Placement(transformation(
                origin={-80,-13.9999},
                extent={{-9.999890000000001,-10},{10,10}},
                rotation=-90)));
          Modelica.Electrical.Analog.Sources.SineVoltage sinevoltage_p(V=sqrt(2)
                *Vrms,freqHz=f) annotation (Placement(transformation(
                origin={-80,14},
                extent={{-10,-10},{10,10}},
                rotation=-90)));
          Modelica.Electrical.PowerConverters.ACDC.ThyristorCenterTap2Pulse
            rectifier
            annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
            annotation (Placement(transformation(
                origin={50,10},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Blocks.Math.Mean meanVoltage(f=2*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,40})));
          Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=2*f)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={80,10})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,-40})));
          Modelica.Blocks.Math.Mean meanCurrent(f=2*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,-60})));
          Modelica.Electrical.PowerConverters.ACDC.Control.VoltageBridge2Pulse
            pulse2(f=f, useFilter=false) annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-30,0})));
        equation
          connect(meanCurrent.u, currentSensor.i) annotation (Line(
              points={{68,-60},{0,-60},{0,-51}}, color={0,0,127}));
          connect(voltagesensor.v, meanVoltage.u) annotation (Line(
              points={{61,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
          connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
              points={{61,10},{68,10}}, color={0,0,127}));
          connect(sinevoltage_p.n, sinevoltage_n.p) annotation (Line(
              points={{-80,4},{-80,-4.00001}}, color={0,0,255}));
          connect(ground.p, sinevoltage_p.n) annotation (Line(
              points={{-90,-40},{-90,0},{-80,0},{-80,4}}, color={0,0,255}));
          connect(sinevoltage_p.p, rectifier.ac_p) annotation (Line(
              points={{-80,24},{-80,46},{-40,46}}, color={0,0,255}));
          connect(sinevoltage_n.n, rectifier.ac_n) annotation (Line(
              points={{-80,-23.9999},{-80,-32},{-50,-32},{-50,34},{-40,34}}, color={0,0,255}));
          connect(ground.p, currentSensor.n) annotation (Line(
              points={{-90,-40},{-10,-40}}, color={0,0,255}));
          connect(currentSensor.p, voltagesensor.n) annotation (Line(
              points={{10,-40},{50,-40},{50,0}}, color={0,0,255}));
          connect(voltagesensor.p, rectifier.dc_p) annotation (Line(
              points={{50,20},{50,40},{-20,40}}, color={0,0,255}));
          connect(pulse2.fire_p, rectifier.fire_p) annotation (Line(
              points={{-36,11},{-36,28}}, color={255,0,255}));
          connect(pulse2.fire_n, rectifier.fire_n) annotation (Line(
              points={{-24,11},{-24,28}}, color={255,0,255}));
          connect(rectifier.ac_n, pulse2.ac_n) annotation (Line(
              points={{-40,34},{-50,34},{-50,-6},{-40,-6}}, color={0,0,255}));
          connect(pulse2.ac_p, rectifier.ac_p) annotation (Line(
              points={{-40,6},{-60,6},{-60,46},{-40,46}}, color={0,0,255}));
          annotation (
            Documentation(info="<html>
<p>Template of
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2Pulse\">
center tap two pulse rectifiers</a>; load is not yet included.</p>
</html>"));
        end ThyristorCenterTap2Pulse;

        partial model ThyristorCenterTapmPulse
          "Template of 2*m pulse rectifier with center tap"
          extends Icons.ExampleTemplate;
          import Modelica.Constants.pi;
          parameter Integer m(final min=3) = 3 "Number of phases";
          parameter Modelica.SIunits.Voltage Vrms=110 "RMS supply voltage";
          parameter Modelica.SIunits.Frequency f=50 "Frequency";

          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(extent={{-80,-100},{-60,-80}})));
          Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
             Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-70,-30})));
          Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage_p(
            final m=m,
            V=fill(sqrt(2)*Vrms, m),
            phase=-
                Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
            freqHz=fill(f, m)) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-70,10})));
          Modelica.Electrical.PowerConverters.ACDC.ThyristorCenterTapmPulse
            rectifier(final m=m)
            annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
            annotation (Placement(transformation(
                origin={50,10},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Blocks.Math.Mean meanVoltage(f=m*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,40})));
          Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=m*f)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={80,10})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,-50})));
          Modelica.Blocks.Math.Mean meanCurrent(f=m*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,-70})));
          Modelica.Electrical.PowerConverters.ACDC.Control.VoltageBridge2mPulse
            pulsem(
            m=m,
            f=f,
            useFilter=false) annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-30,0})));
        equation
          connect(star.pin_n, ground.p) annotation (Line(
              points={{-70,-40},{-70,-80}}, color={0,0,255}));
          connect(meanCurrent.u, currentSensor.i) annotation (Line(
              points={{68,-70},{0,-70},{0,-61}}, color={0,0,127}));
          connect(voltagesensor.v, meanVoltage.u) annotation (Line(
              points={{61,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
          connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
              points={{61,10},{68,10}}, color={0,0,127}));
          connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
              points={{-20,40},{50,40},{50,20}}, color={0,0,255}));
          connect(currentSensor.p, voltagesensor.n) annotation (Line(
              points={{10,-50},{50,-50},{50,0}}, color={0,0,255}));
          connect(pulsem.fire_p, rectifier.fire_p) annotation (Line(
              points={{-36,11},{-36,28}}, color={255,0,255}));
          connect(pulsem.ac, sineVoltage_p.plug_p) annotation (Line(
              points={{-40,0},{-50,0},{-50,
                  40},{-70,40},{-70,20}}, color={0,0,255}));
          connect(star.plug_p, sineVoltage_p.plug_n) annotation (Line(
              points={{-70,-20},{-70,0}}, color={0,0,255}));
          connect(star.pin_n, currentSensor.n) annotation (Line(
              points={{-70,-40},{-70,-50},{-10,-50}}, color={0,0,255}));
          connect(rectifier.ac, sineVoltage_p.plug_p) annotation (Line(
              points={{-40,40},{-70,40},{-70,20}}, color={0,0,255}));
          annotation (
            Documentation(info="<html>
<p>Template of
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTapmPulse\">
center tap <code>m</code> pulse rectifiers</a>, where <code>m</code> is the number of phases; load is not yet included.</p>
</html>"));
        end ThyristorCenterTapmPulse;

        partial model ThyristorBridge2mPulse
          "Template of 2*m pulse bridge thyristor rectifier"
          extends Icons.ExampleTemplate;
          import Modelica.Constants.pi;
          parameter Integer m(final min=3) = 3 "Number of phases";
          parameter Modelica.SIunits.Voltage Vrms=110 "RMS supply voltage";
          parameter Modelica.SIunits.Frequency f=50 "Frequency";

          Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
            final m=m,
            V=fill(sqrt(2)*Vrms, m),
            phase=-
                Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
            freqHz=fill(f, m)) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-80,-30})));
          Modelica.Electrical.PowerConverters.ACDC.ThyristorBridge2mPulse
            rectifier(final m=m)
            annotation (Placement(transformation(extent={{-40,24},{-20,44}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
            annotation (Placement(transformation(
                origin={50,10},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Blocks.Math.Mean meanVoltage(f=2*m*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,40})));
          Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=2*m*f)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={80,10})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,-40})));
          Modelica.Blocks.Math.Mean meanCurrent(f=2*m*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,-60})));
          Modelica.Electrical.PowerConverters.ACDC.Control.VoltageBridge2mPulse
            pulse2m(
            m=m,
            f=f,
            useFilter=false) annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-30,0})));
          Modelica.Electrical.Polyphase.Basic.MultiStarResistance
            multiStarResistance(final m=m) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-80,-60})));
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(extent={{-90,-100},{-70,-80}})));
        equation
          connect(meanCurrent.u, currentSensor.i) annotation (Line(
              points={{68,-60},{0,-60},{0,-51}}, color={0,0,127}));
          connect(voltagesensor.v, meanVoltage.u) annotation (Line(
              points={{61,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
          connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
              points={{61,10},{68,10}}, color={0,0,127}));
          connect(sineVoltage.plug_p, rectifier.ac) annotation (Line(
              points={{-80,-20},{-80,34},{-40,34}}, color={0,0,255}));
          connect(rectifier.dc_n, currentSensor.n) annotation (Line(
              points={{-20,28},{-10,28},{-10,-40}}, color={0,0,255}));
          connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
              points={{-20,40},{50,40},{50,20}}, color={0,0,255}));
          connect(currentSensor.p, voltagesensor.n) annotation (Line(
              points={{10,-40},{50,-40},{50,0}}, color={0,0,255}));
          connect(pulse2m.fire_p, rectifier.fire_p) annotation (Line(
              points={{-36,11},{-36,22}}, color={255,0,255}));
          connect(pulse2m.fire_n, rectifier.fire_n) annotation (Line(
              points={{-24,11},{-24,22}}, color={255,0,255}));
          connect(pulse2m.ac, sineVoltage.plug_p) annotation (Line(
              points={{-40,0},{-80,0},{-80,-20}}, color={0,0,255}));
          connect(sineVoltage.plug_n, multiStarResistance.plug) annotation (
              Line(
              points={{-80,-40},{-80,-50}}, color={0,0,255}));
          connect(multiStarResistance.pin, ground.p) annotation (Line(
              points={{-80,-70},{-80,-80}}, color={0,0,255}));
          annotation (
            Documentation(info="<html>
<p>Template of
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse\">
<code>2*m</code> pulse bridge rectifiers</a>, where <code>m</code> is the number of phases; load is not yet included.</p>
</html>"));
        end ThyristorBridge2mPulse;

        partial model ThyristorCenterTap2mPulse
          "Template of 2*m pulse thyristor rectifier with center tap"
          extends Icons.ExampleTemplate;
          import Modelica.Constants.pi;
          parameter Integer m(final min=3) = 3 "Number of phases";
          parameter Modelica.SIunits.Voltage Vrms=110 "RMS supply voltage";
          parameter Modelica.SIunits.Frequency f=50 "Frequency";

          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(extent={{-90,-100},{-70,-80}})));
          Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
             Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-100,-10})));
          Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage_p(
            final m=m,
            V=fill(sqrt(2)*Vrms, m),
            phase=-
                Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
            freqHz=fill(f, m)) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-70,10})));
          Modelica.Electrical.PowerConverters.ACDC.ThyristorCenterTap2mPulse
            rectifier(final m=m)
            annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
            annotation (Placement(transformation(
                origin={50,10},
                extent={{10,-10},{-10,10}},
                rotation=90)));
          Modelica.Blocks.Math.Mean meanVoltage(f=2*m*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,40})));
          Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=2*m*f)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={80,10})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,-50})));
          Modelica.Blocks.Math.Mean meanCurrent(f=2*m*f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={80,-70})));
          Modelica.Electrical.PowerConverters.ACDC.Control.VoltageCenterTap2mPulse
            pulse2m(
            m=m,
            f=f,
            useFilter=false) annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-30,0})));
          Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage_n(
            final m=m,
            V=fill(sqrt(2)*Vrms, m),
            phase=-
                Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
            freqHz=fill(f, m)) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-70,-20})));
        equation
          connect(star.pin_n, ground.p) annotation (Line(
              points={{-100,-20},{-100,-50},{-80,-50},{-80,-80}}, color={0,0,255}));
          connect(meanCurrent.u, currentSensor.i) annotation (Line(
              points={{68,-70},{0,-70},{0,-61}}, color={0,0,127}));
          connect(voltagesensor.v, meanVoltage.u) annotation (Line(
              points={{61,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
          connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
              points={{61,10},{68,10}}, color={0,0,127}));
          connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
              points={{-20,40},{50,40},{50,20}}, color={0,0,255}));
          connect(currentSensor.p, voltagesensor.n) annotation (Line(
              points={{10,-50},{50,-50},{50,0}}, color={0,0,255}));
          connect(pulse2m.fire_p, rectifier.fire_p) annotation (Line(
              points={{-36,11},{-36,28}}, color={255,0,255}));
          connect(pulse2m.ac, sineVoltage_p.plug_p) annotation (Line(
              points={{-40,0},{-46,0},{-46,46},{-70,46},{-70,
                  20}}, color={0,0,255}));
          connect(sineVoltage_p.plug_n, sineVoltage_n.plug_p) annotation (Line(
              points={{-70,0},{-70,
                  -10}}, color={0,0,255}));
          connect(sineVoltage_n.plug_n, rectifier.ac_n) annotation (Line(
              points={{-70,-30},{-70,-40},{-50,-40},{-50,34},{-40,34}}, color={0,0,255}));
          connect(sineVoltage_p.plug_p, rectifier.ac_p) annotation (Line(
              points={{-70,20},{-70,46},{-40,46}}, color={0,0,255}));
          connect(star.plug_p, sineVoltage_p.plug_n) annotation (Line(
              points={{-100,0},{-70,0}}, color={0,0,255}));
          connect(star.pin_n, currentSensor.n) annotation (Line(
              points={{-100,-20},{-100,-50},{-10,-50}}, color={0,0,255}));
          connect(pulse2m.fire_n, rectifier.fire_n) annotation (Line(
              points={{-24,11},{-24,28}}, color={255,0,255}));
          annotation (
            Documentation(info="<html>
<p>Template of
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2mPulse\">
center tap <code>2*m</code> pulse rectifiers</a>, where <code>m</code> is the number of phases; load is not yet included.</p>
</html>"));
        end ThyristorCenterTap2mPulse;
        annotation (Documentation(info="<html>
<p>This package includes templates of the used examples. The templates are partial example models.</p>
</html>"));
      end ExampleTemplates;
    end ACDC;

    package DCAC "DC to AC converter examples"
      extends Modelica.Icons.ExamplesPackage;
      package SinglePhaseTwoLevel "Single-phase two level inverter examples"
        extends Modelica.Icons.ExamplesPackage;
        model SinglePhaseTwoLevel_R
          "Single-phase DC to AC converter with resistive load"
          extends ExampleTemplates.SinglePhaseTwoLevel(sine(
              amplitude=0.5,
              offset=0.5,
              freqHz=f1));
          extends Modelica.Icons.Example;
          parameter Modelica.SIunits.Resistance R=100 "Resistance";
          parameter Modelica.SIunits.Frequency f1=50 "AC frequency";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={40,10})));
        equation
          connect(resistor.p, inverter.ac) annotation (Line(
              points={{40,20},{40,30},{-30,30}}, color={0,0,255}));
          connect(resistor.n, currentSensor.p) annotation (Line(
              points={{40,0},{40,-70},{10,-70}}, color={0,0,255}));
          annotation (
            experiment(
              StartTime=0,
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>. The instantaneous voltage and current directly show the switch pattern of the inverter. The average voltage and average current reveal the fundamental wave of the voltage and current, each of them being basically in phase with the command <code>sine.y</code>.</p>
</html>"));
        end SinglePhaseTwoLevel_R;

        model SinglePhaseTwoLevel_RL
          "Single-phase DC to AC converter with R-L load"
          extends ExampleTemplates.SinglePhaseTwoLevel(sine(
              amplitude=0.5,
              offset=0.5,
              freqHz=f1));
          extends Modelica.Icons.Example;
          parameter Modelica.SIunits.Resistance R=100 "Resistance";
          parameter Modelica.SIunits.Inductance L=1 "Inductance";
          parameter Modelica.SIunits.Frequency f1=50 "AC frequency";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={40,10})));
          Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(fixed=true))
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={40,-22})));
        equation
          connect(resistor.p, inverter.ac) annotation (Line(
              points={{40,20},{40,30},{-30,30}}, color={0,0,255}));
          connect(resistor.n, inductor.p) annotation (Line(
              points={{40,0},{40,-12}}, color={0,0,255}));
          connect(inductor.n, currentSensor.p) annotation (Line(
              points={{40,-32},{40,-70},{10,-70}}, color={0,0,255}));
          annotation (
            experiment(
              StartTime=0,
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.0002),
            Documentation(info="<html>
<p>Plot current <code>currentSensor.i</code>, average current <code>meanCurrent.y</code>, voltage <code>voltageSensor.v</code> and average voltage <code>meanVoltage.v</code>. The instantaneous voltage directly show the switch pattern of the inverter. The current shows a particular ripple determined by the input voltage and the switching frequency. The average voltage is basically in phase with the command <code>sine.y</code>. The average current has a phase shift due to the R-L load.</p>
</html>"));
        end SinglePhaseTwoLevel_RL;
      end SinglePhaseTwoLevel;

      package PolyphaseTwoLevel "Polyphase two level inverter example"
        extends Modelica.Icons.ExamplesPackage;
        model PolyphaseTwoLevel_R "Polyphase DC to AC converter with R load"
          extends Modelica.Icons.Example;
          parameter Integer m=3 "Number of phases";
          parameter Modelica.SIunits.Frequency f=1000 "Switching frequency";
          parameter Modelica.SIunits.Frequency f1=50
            "Fundamental wave AC frequency";
          parameter Modelica.SIunits.Resistance R=100 "Resistance";
          Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage_n(
              V=50) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-70,10})));
          Modelica.Electrical.PowerConverters.DCAC.Polyphase2Level inverter(
              useHeatPort=false, m=m)
            annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
          Modelica.Electrical.Polyphase.Sensors.CurrentSensor currentSensor(m=
                m) annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=90,
                origin={40,-50})));
          Modelica.Electrical.Polyphase.Sensors.VoltageSensor voltageSensor(m=
                m) annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=270,
                origin={70,-10})));
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-90,40})));
          Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM signalPWM[
            m](each useConstantDutyCycle=false, each f=f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={-40,-20})));
          Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage_p(
              V=50) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-70,50})));
          Modelica.Blocks.Sources.Sine sine[m](
            phase=-
                Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
            startTime=zeros(m),
            amplitude=fill(0.5, m),
            offset=fill(0.5, m),
            freqHz=fill(f1, m)) annotation (Placement(transformation(extent={{-30,
                    -64},{-50,-44}})));
          Modelica.Blocks.Math.Harmonic fundamentalWaveCurrent[m](
            each k=1,
            each x0Cos=0,
            each x0Sin=0,
            each f=f1) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={90,-50})));
          Modelica.Blocks.Math.Harmonic fundamentalWaveVoltage[m](
            each k=1,
            each x0Cos=0,
            each x0Sin=0,
            each f=f1) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={90,50})));
          Modelica.Electrical.Polyphase.Basic.Resistor resistor(m=m, R=fill(R,
                m)) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={40,10})));
          Modelica.Electrical.Polyphase.Basic.Star star(m=m) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={40,-90})));
        equation
          connect(constantVoltage_p.n, constantVoltage_n.p) annotation (Line(
              points={{-70,40},{-70,20}}, color={0,0,255}));
          connect(constantVoltage_p.p, inverter.dc_p) annotation (Line(
              points={{-70,60},{-60,60},{-60,36},{-50,36}}, color={0,0,255}));
          connect(constantVoltage_n.n, inverter.dc_n) annotation (Line(
              points={{-70,0},{-60,0},{-60,24},{-54,24},{-50,24}}, color={0,0,255}));
          connect(ground.p, constantVoltage_p.n) annotation (Line(
              points={{-90,30},{-70,30},{-70,40}}, color={0,0,255}));
          connect(sine.y, signalPWM.dutyCycle) annotation (Line(
              points={{-51,-54},{-60,-54},{-60,-20},{-52,-20}}, color={0,0,127}));
          connect(voltageSensor.v, fundamentalWaveVoltage.u) annotation (Line(
              points={{81,-10},{90,-10},{90,38}}, color={0,0,127}));
          connect(fundamentalWaveCurrent.u, currentSensor.i) annotation (Line(
              points={{78,-50},{51,-50}}, color={0,0,127}));
          connect(signalPWM.fire, inverter.fire_p) annotation (Line(
              points={{-46,-9},{-46,18}}, color={255,0,255}));
          connect(signalPWM.notFire, inverter.fire_n) annotation (Line(
              points={{-34,-9},{-34,18}}, color={255,0,255}));
          connect(inverter.ac, resistor.plug_p) annotation (Line(
              points={{-30,30},{40,30},{40,20}}, color={0,0,255}));
          connect(voltageSensor.plug_p, inverter.ac) annotation (Line(
              points={{70,0},{70,30},{-30,30}}, color={0,0,255}));
          connect(voltageSensor.plug_n, currentSensor.plug_n) annotation (Line(
              points={{70,-20},{70,-70},{40,-70},{40,-60}}, color={0,0,255}));
          connect(currentSensor.plug_n, star.plug_p) annotation (Line(
              points={{40,-60},{40,-80}}, color={0,0,255}));
          connect(resistor.plug_n, currentSensor.plug_p) annotation (Line(
              points={{40,0},{40,-40},{40,-40}}, color={0,0,255}));
          annotation (
            experiment(
              StartTime=0,
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.00002),
            Documentation(info="<html>
<p>Plot current <code>currentSensor.i[:]</code>, harmonic current magnitude <code>fundamentalWaveCurrent[:].y_RMS</code>, harmonic voltage magnitude <code>fundamentalWaveVoltage[:].y_RMS</code>. The instantaneous voltages <code>voltageSensor.i[:]</code> and currents <code>currentSensor.i[:]</code> directly show the switching pattern of the inverter. There is not smoothing effect due to an inductance in this example; see <a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.DCAC.PolyphaseTwoLevel.PolyphaseTwoLevel_RL\">PolyphaseTwoLevel_RL</a>.</p>
</html>"));
        end PolyphaseTwoLevel_R;

        model PolyphaseTwoLevel_RL
          "Polyphase DC to AC converter with R-L load"
          extends Modelica.Icons.Example;
          parameter Integer m=6 "Number of phases";
          parameter Modelica.SIunits.Frequency f=1000 "Switching frequency";
          parameter Modelica.SIunits.Frequency f1=50
            "Fundamental wave AC frequency";
          parameter Modelica.SIunits.Resistance R=100 "Resistance";
          parameter Modelica.SIunits.Inductance L=1 "Inductance";
          Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage_n(
              V=50) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-70,10})));
          Modelica.Electrical.PowerConverters.DCAC.Polyphase2Level inverter(
              useHeatPort=false, m=m)
            annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
          Modelica.Electrical.Polyphase.Sensors.CurrentSensor currentSensor(m=
                m) annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=90,
                origin={40,-50})));
          Modelica.Electrical.Polyphase.Sensors.VoltageSensor voltageSensor(m=
                m) annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=270,
                origin={70,-10})));
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-90,40})));
          Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM signalPWM[
            m](each useConstantDutyCycle=false, each f=f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={-40,-20})));
          Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage_p(
              V=50) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-70,50})));
          Modelica.Blocks.Sources.Sine sine[m](
            phase=-
                Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
            startTime=zeros(m),
            amplitude=fill(0.5, m),
            offset=fill(0.5, m),
            freqHz=fill(f1, m)) annotation (Placement(transformation(extent={{-30,
                    -64},{-50,-44}})));
          Modelica.Blocks.Math.Harmonic fundamentalWaveCurrent[m](
            each k=1,
            each x0Cos=0,
            each x0Sin=0,
            each f=f1) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={90,-50})));
          Modelica.Blocks.Math.Harmonic fundamentalWaveVoltage[m](
            each k=1,
            each x0Cos=0,
            each x0Sin=0,
            each f=f1) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={90,50})));
          Modelica.Electrical.Polyphase.Basic.Resistor resistor(m=m, R=fill(R,
                m)) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={40,10})));
          Modelica.Electrical.Polyphase.Basic.Inductor inductor(m=m, L=fill(L,
                m)) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={40,-20})));
          Modelica.Electrical.Polyphase.Basic.Star star(m=m) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={40,-90})));
        initial equation
          inductor.i[1:m - 1] = zeros(m - 1);


        equation
          connect(constantVoltage_p.n, constantVoltage_n.p) annotation (Line(
              points={{-70,40},{-70,20}}, color={0,0,255}));
          connect(constantVoltage_p.p, inverter.dc_p) annotation (Line(
              points={{-70,60},{-60,60},{-60,36},{-50,36},{-50,36}}, color={0,0,255}));
          connect(constantVoltage_n.n, inverter.dc_n) annotation (Line(
              points={{-70,0},{-60,0},{-60,24},{-50,24},{-50,24}}, color={0,0,255}));
          connect(ground.p, constantVoltage_p.n) annotation (Line(
              points={{-90,30},{-70,30},{-70,40}}, color={0,0,255}));
          connect(sine.y, signalPWM.dutyCycle) annotation (Line(
              points={{-51,-54},{-60,-54},{-60,-20},{-52,-20}}, color={0,0,127}));
          connect(voltageSensor.v, fundamentalWaveVoltage.u) annotation (Line(
              points={{81,-10},{90,-10},{90,38}}, color={0,0,127}));
          connect(fundamentalWaveCurrent.u, currentSensor.i) annotation (Line(
              points={{78,-50},{51,-50}}, color={0,0,127}));
          connect(signalPWM.fire, inverter.fire_p) annotation (Line(
              points={{-46,-9},{-46,18}}, color={255,0,255}));
          connect(signalPWM.notFire, inverter.fire_n) annotation (Line(
              points={{-34,-9},{-34,18}}, color={255,0,255}));
          connect(inverter.ac, resistor.plug_p) annotation (Line(
              points={{-30,30},{40,30},{40,20}}, color={0,0,255}));
          connect(resistor.plug_n, inductor.plug_p) annotation (Line(
              points={{40,0},{40,-10}}, color={0,0,255}));
          connect(voltageSensor.plug_p, inverter.ac) annotation (Line(
              points={{70,0},{70,30},{-30,30}}, color={0,0,255}));
          connect(voltageSensor.plug_n, currentSensor.plug_n) annotation (Line(
              points={{70,-20},{70,-70},{40,-70},{40,-60}}, color={0,0,255}));
          connect(currentSensor.plug_p, inductor.plug_n) annotation (Line(
              points={{40,-40},{40,-30}}, color={0,0,255}));
          connect(currentSensor.plug_n, star.plug_p) annotation (Line(
              points={{40,-60},{40,-80}}, color={0,0,255}));
          annotation (
            experiment(
              StartTime=0,
              StopTime=0.1,
              Tolerance=1e-06,
              Interval=0.00002),
            Documentation(info="<html>
<p>Plot current <code>currentSensor.i[:]</code>, harmonic current magnitude <code>fundamentalWaveCurrent[:].y_RMS</code>, harmonic voltage magnitude <code>fundamentalWaveVoltage[:].y_RMS</code>. The instantaneous voltages <code>voltageSensor.i[:]</code> directly show the switching pattern of the inverter.</p>
</html>"));
        end PolyphaseTwoLevel_RL;

        model ThreePhaseTwoLevel_PWM "Test of pulse width modulation methods"
          extends Modelica.Icons.Example;
          import Modelica.Electrical.Polyphase.Functions.factorY2DC;
          import Modelica.Constants.pi;
          parameter Real RMS=1 "Reference RMS Y";
          Modelica.Blocks.Sources.Cosine cosine(freqHz=2,
            phase=0,
            amplitude=RMS*sqrt(2))
            annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
          Modelica.Blocks.Sources.Sine sine(
            amplitude=cosine.amplitude,
            freqHz=cosine.freqHz,
            phase=cosine.phase)
            annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
          Modelica.Electrical.PowerConverters.DCAC.Control.PWM pwm(uMax=sqrt(2*3), f=100)
            annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
          Modelica.Electrical.PowerConverters.DCAC.Polyphase2Level multiPhase2Level
            annotation (Placement(transformation(extent={{-10,40},{10,60}})));
          Modelica.Electrical.Analog.Sources.ConstantVoltage dcPos(V=pwm.uMax/2)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-40,70})));
          Modelica.Electrical.Analog.Sources.ConstantVoltage dcNeg(V=pwm.uMax/2)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-40,30})));
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-50,50})));
          Modelica.Electrical.Polyphase.Sensors.PotentialSensor potentialSensor
            annotation (Placement(transformation(extent={{20,40},{40,60}})));
          Modelica.Blocks.Math.Harmonic harmonic(f=cosine.freqHz, k=1)
            annotation (Placement(transformation(extent={{60,40},{80,60}})));
          Modelica.Electrical.Machines.SpacePhasors.Blocks.ToSpacePhasor toSpacePhasor
            annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
          Modelica.Electrical.Machines.SpacePhasors.Blocks.Rotator rotator
            annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
          Modelica.Blocks.Sources.Constant const(k=cosine.freqHz)
            annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
          Modelica.Blocks.Continuous.Integrator integrator(k=2*pi)
            annotation (Placement(transformation(extent={{-30,-80},{-10,-60}})));
          Modelica.Blocks.Continuous.Filter filter[2](
            each init=Modelica.Blocks.Types.Init.InitialOutput,
            each analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
            y_start={cosine.amplitude,cosine.phase},
            each order=2,
            each f_cut=0.5*cosine.freqHz)
            annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
          Modelica.Electrical.Machines.SpacePhasors.Blocks.ToPolar toPolar
            annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
        equation
          connect(pwm.fire_p, multiPhase2Level.fire_p)
            annotation (Line(points={{-29,6},{-6,6},{-6,38}}, color={255,0,255}));
          connect(pwm.fire_n, multiPhase2Level.fire_n)
            annotation (Line(points={{-29,-6},{6,-6},{6,38}}, color={255,0,255}));
          connect(dcNeg.n, multiPhase2Level.dc_n) annotation (Line(points={{-40,20},
                  {-20,20},{-20,44},{-10,44}},
                                   color={0,0,255}));
          connect(dcPos.p, multiPhase2Level.dc_p) annotation (Line(points={{-40,80},
                  {-20,80},{-20,56},{-10,56}},
                                   color={0,0,255}));
          connect(dcPos.n, ground.p)
            annotation (Line(points={{-40,60},{-40,50}}, color={0,0,255}));
          connect(ground.p, dcNeg.p)
            annotation (Line(points={{-40,50},{-40,40}}, color={0,0,255}));
          connect(cosine.y, pwm.u[1]) annotation (Line(points={{-69,20},{-60,20},{-60,
                  -1},{-52,-1}}, color={0,0,127}));
          connect(sine.y, pwm.u[2]) annotation (Line(points={{-69,-20},{-60,-20},{-60,
                  1},{-52,1}}, color={0,0,127}));
          connect(multiPhase2Level.ac, potentialSensor.plug_p)
            annotation (Line(points={{10,50},{20,50}}, color={0,0,255}));
          connect(toSpacePhasor.y, rotator.u)
            annotation (Line(points={{-9,-40},{-2,-40}},   color={0,0,127}));
          connect(potentialSensor.phi, toSpacePhasor.u) annotation (Line(points={{41,50},
                  {50,50},{50,-20},{-40,-20},{-40,-40},{-32,-40}}, color={0,0,127}));
          connect(const.y, integrator.u)
            annotation (Line(points={{-39,-70},{-32,-70}}, color={0,0,127}));
          connect(integrator.y, rotator.angle)
            annotation (Line(points={{-9,-70},{10,-70},{10,-52}},color={0,0,127}));
          connect(potentialSensor.phi[1], harmonic.u)
            annotation (Line(points={{41,50},{58,50}}, color={0,0,127}));
          connect(rotator.y, filter.u)
            annotation (Line(points={{21,-40},{28,-40}}, color={0,0,127}));
          connect(filter.y, toPolar.u)
            annotation (Line(points={{51,-40},{58,-40}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)),
            experiment(
              StopTime=2,
              Interval=0.001,
              Tolerance=1e-05),
            Documentation(info="<html>
<p>
A reference space vector (formed by real part = cosine and imaginary part = sine) of length &radic;2*RMS and frequency 2 Hz is applied.
The resulting switching patterns are applied to a three-phase twolevel bridge with switching frequency 100 Hz, fed by DC voltage = &radic;2*&radic;3*1
where 1 is the theoretical maximum voltage from terminal to neutral.
The resulting voltages with reference to midpoint of the DC voltage are measured.
</p>
<p>
The RMS of the first harmonic of the first of these voltages is calculated.
Please note that the value of the first harmonic is valid after the first period (i.e. 0.5 s).
</p>
<p>
Furthermore, these three voltages are transformed to the corresponding space phasor.
Note that the zero component is not zero, indicating the shift of the neutral with respect to the midpoint of the DC voltage.
</p>
<p>
The space phasor is rotated to the coordinate system rotating with 2*&pi;*2 Hz.
To suppress the influence of switching, real and imaginary part of the rotated phasor are filtered.
The polar representation of this rotated and filtered phasor are calculated.
</p>
<p>
Please note that the filter has a settle time depending on the filter parameters.
</p>
</html>"));
        end ThreePhaseTwoLevel_PWM;
      end PolyphaseTwoLevel;

      package ExampleTemplates "Templates of examples"
        extends Modelica.Icons.Package;
        partial model SinglePhaseTwoLevel
          "Single-phase two level inverter including control"
          extends Icons.ExampleTemplate;
          parameter Modelica.SIunits.Frequency f=1000 "Switching frequency";
          Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage_n(
              V=50) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-70,10})));
          Modelica.Electrical.PowerConverters.DCAC.SinglePhase2Level inverter(
              useHeatPort=false)
            annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(extent={{10,-80},{-10,-60}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=270,
                origin={70,-10})));
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-90,40})));
          Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM signalPWM(
              useConstantDutyCycle=false, f=f) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                origin={-40,-20})));
          Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage_p(
              V=50) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-70,50})));
          Modelica.Blocks.Sources.Sine sine(freqHz=50) annotation (Placement(
                transformation(extent={{-30,-64},{-50,-44}})));
          Modelica.Blocks.Math.Harmonic fundamentalWaveVoltage(f=f, k=1)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={90,50})));
          Modelica.Blocks.Math.Harmonic fundamentalWaveCurrent(f=f, k=1)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={30,-90})));
        equation
          connect(voltageSensor.n, currentSensor.p) annotation (Line(
              points={{70,-20},{70,-70},{10,-70}}, color={0,0,255}));
          connect(signalPWM.fire, inverter.fire_p) annotation (Line(
              points={{-46,-9},{-46,18}}, color={255,0,255}));
          connect(constantVoltage_p.n, constantVoltage_n.p) annotation (Line(
              points={{-70,40},{-70,20}}, color={0,0,255}));
          connect(constantVoltage_p.p, inverter.dc_p) annotation (Line(
              points={{-70,60},{-60,60},{-60,36},{-50,36},{-50,36}}, color={0,0,255}));
          connect(constantVoltage_n.n, inverter.dc_n) annotation (Line(
              points={{-70,0},{-60,0},{-60,24},{-52,24},{-52,24},{-50,24},{-50,24}}, color={0,0,255}));
          connect(ground.p, constantVoltage_p.n) annotation (Line(
              points={{-90,30},{-70,30},{-70,40}}, color={0,0,255}));
          connect(currentSensor.n, ground.p) annotation (Line(
              points={{-10,-70},{-90,-70},{-90,30}}, color={0,0,255}));
          connect(voltageSensor.p, inverter.ac) annotation (Line(
              points={{70,0},{70,30},{-30,30}}, color={0,0,255}));
          connect(sine.y, signalPWM.dutyCycle) annotation (Line(
              points={{-51,-54},{-60,-54},{-60,-20},{-52,-20}}, color={0,0,127}));
          connect(inverter.fire_n, signalPWM.notFire) annotation (Line(
              points={{-34,18},{-34,-9}}, color={255,0,255}));
          connect(currentSensor.i, fundamentalWaveCurrent.u) annotation (Line(
              points={{0,-81},{0,-90},{18,-90}}, color={0,0,127}));
          connect(voltageSensor.v, fundamentalWaveVoltage.u) annotation (Line(
              points={{81,-10},{90,-10},{90,38}}, color={0,0,127}));
          annotation (Documentation(
                info="<html>
<p>Single-phase two level example template including supply and sensors; load is not yet included.</p>
</html>"));
        end SinglePhaseTwoLevel;
        annotation (Documentation(info="<html>
<p>This package includes templates of the used examples. The templates are partial example models.</p>
</html>"));
      end ExampleTemplates;
      annotation (Documentation(info="<html>
</html>"));
    end DCAC;

    package DCDC "DC to DC converter examples"
      extends Modelica.Icons.ExamplesPackage;
      package ChopperStepDown "Step down chopper"
        extends Modelica.Icons.ExamplesPackage;
        model ChopperStepDown_R "Step down chopper with resistive load"
          extends ExampleTemplates.ChopperStepDown(signalPWM(useConstantDutyCycle=false));
          extends Modelica.Icons.Example;
          Modelica.Electrical.Analog.Basic.Resistor loadResistor(R=RLoad)
            annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={40,40})));
          Modelica.Electrical.PowerConverters.DCDC.Control.Voltage2DutyCycle adaptor(
            reciprocal=false,
            useBipolarVoltage=false,
            VLim=Vsource) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-70,-60})));
          Modelica.Blocks.Sources.Ramp vRef(
            height=V0,
            duration=0.05,
            offset=0,
            startTime=0.025)
            annotation (Placement(transformation(extent={{100,-90},{80,-70}})));
        equation
          connect(loadResistor.n, currentSensor.p)
            annotation (Line(points={{40,30},{40,-10},{30,-10}}, color={0,0,255}));
          connect(loadResistor.p, capacitor.p) annotation (Line(points={{40,50},{40,60},
                  {1.77636e-15,60},{1.77636e-15,10}}, color={0,0,255}));
          connect(adaptor.dutyCycle, signalPWM.dutyCycle)
            annotation (Line(points={{-70,-49},{-70,-40},{-42,-40}}, color={0,0,127}));
          connect(vRef.y, adaptor.v)
            annotation (Line(points={{79,-80},{-70,-80},{-70,-72}}, color={0,0,127}));
          annotation (
            experiment(
              StopTime=0.1,
              Interval=1e-05,
              Tolerance=1e-06),
            Documentation(info="<html>
<p>This example demonstrates the switching on of a resistive load operated by a step down chopper.
DC output voltage is equal to <code>dutyCycle</code> times the input voltage.
Plot current <code>currentSensor.i</code>, averaged current <code>meanCurrent.y</code>, total voltage <code>voltageSensor.v</code> and voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end ChopperStepDown_R;

        model ChopperStepDown_RL "Step down chopper with R-L load"
          extends ExampleTemplates.ChopperStepDown(signalPWM(useConstantDutyCycle=false));
          extends Modelica.Icons.Example;
          parameter Modelica.SIunits.Inductance LLoad=0.025 "Load inductance";
          Modelica.Electrical.Analog.Basic.Resistor loadResistor(R=RLoad)
            annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={40,40})));
          Modelica.Electrical.Analog.Basic.Inductor loadInductor(i(fixed=true, start=0),
            L=LLoad) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={40,10})));
          Modelica.Electrical.PowerConverters.DCDC.Control.Voltage2DutyCycle adaptor(
            reciprocal=false,
            useBipolarVoltage=false,
            VLim=Vsource) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-70,-60})));
          Modelica.Blocks.Sources.Ramp vRef(
            height=V0,
            duration=0.05,
            offset=0,
            startTime=0.025)
            annotation (Placement(transformation(extent={{100,-90},{80,-70}})));
        equation
          connect(loadResistor.p, capacitor.p) annotation (Line(points={{40,50},{40,60},
                  {1.77636e-15,60},{1.77636e-15,10}}, color={0,0,255}));
          connect(loadInductor.n, currentSensor.p)
            annotation (Line(points={{40,0},{40,-10},{30,-10}}, color={0,0,255}));
          connect(loadResistor.n, loadInductor.p)
            annotation (Line(points={{40,30},{40,20}}, color={0,0,255}));
          connect(adaptor.dutyCycle, signalPWM.dutyCycle)
            annotation (Line(points={{-70,-49},{-70,-40},{-42,-40}}, color={0,0,127}));
          connect(adaptor.v, vRef.y)
            annotation (Line(points={{-70,-72},{-70,-80},{79,-80}}, color={0,0,127}));
          annotation (
            experiment(
              StopTime=0.1,
              Interval=1e-05,
              Tolerance=1e-06),
            Documentation(info="<html>
<p>This example demonstrates the switching on of an R-L load operated by a step down chopper.
DC output voltage is equal to <code>dutyCycle</code> times the input voltage.
Plot current <code>currentSensor.i</code>, averaged current <code>meanCurrent.y</code>, total voltage <code>voltageSensor.v</code> and voltage <code>meanVoltage.v</code>. The waveform the average current is determined by the time constant <code>L/R</code> of the load.</p>
</html>"));
        end ChopperStepDown_RL;
      end ChopperStepDown;

      package ChopperStepUp "Step up chopper"
        extends Modelica.Icons.ExamplesPackage;
        model ChopperStepUp_R "Step up chopper with resistive load"
          extends ExampleTemplates.ChopperStepUp(signalPWM(useConstantDutyCycle=false));
          extends Modelica.Icons.Example;
          Modelica.Electrical.Analog.Basic.Resistor loadResistor(R=RLoad)
            annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={40,40})));
          Modelica.Electrical.PowerConverters.DCDC.Control.Voltage2DutyCycle adaptor(
            reciprocal=true,
            useBipolarVoltage=false,
            VLim=Vsource) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-70,-60})));
          Modelica.Blocks.Sources.Ramp vRef(
            height=V0 - Vsource,
            duration=0.05,
            offset=Vsource,
            startTime=0.025)
            annotation (Placement(transformation(extent={{100,-90},{80,-70}})));
        equation
          connect(loadResistor.n, currentSensor.p)
            annotation (Line(points={{40,30},{40,-10},{30,-10}}, color={0,0,255}));
          connect(loadResistor.p, capacitor.p) annotation (Line(points={{40,50},{40,60},
                  {1.77636e-15,60},{1.77636e-15,10}}, color={0,0,255}));
          connect(adaptor.dutyCycle, signalPWM.dutyCycle)
            annotation (Line(points={{-70,-49},{-70,-40},{-42,-40}}, color={0,0,127}));
          connect(vRef.y, adaptor.v)
            annotation (Line(points={{79,-80},{-70,-80},{-70,-72}}, color={0,0,127}));
          annotation (
            experiment(
              StopTime=0.1,
              Interval=1e-05,
              Tolerance=1e-06),
            Documentation(info="<html>
<p>This example demonstrates the switching on of a resistive load operated by a step up chopper.
DC output voltage is equal to <code>1/(1 - dutyCycle)</code> times the input voltage.
Plot current <code>currentSensor.i</code>, averaged current <code>meanCurrent.y</code>, total voltage <code>voltageSensor.v</code> and voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end ChopperStepUp_R;

      end ChopperStepUp;

      package HBridge "H bridge converter"
        extends Modelica.Icons.ExamplesPackage;
        model HBridge_R "H bridge DC/DC converter with resistive load"
          extends ExampleTemplates.HBridge;
          extends Modelica.Icons.Example;
          parameter Modelica.SIunits.Resistance R=100 "Resistance";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={20,50})));
        equation
          connect(resistor.p, hbridge.dc_p2) annotation (Line(
              points={{20,60},{20,70},{-30,70},{-30,6},{-40,6}}, color={0,0,255}));
          connect(resistor.n, currentSensor.p) annotation (Line(
              points={{20,40},{20,-6},{0,-6}}, color={0,0,255}));
          annotation (
            experiment(
              StopTime=0.1,
              Interval=0.0002,
              Tolerance=1e-06),
            Documentation(info="<html>
<p>This example demonstrates the switching on of a resistive load operated by an H bridge.
DC output voltage is equal to <code>2 * (dutyCycle - 0.5)</code> times the input voltage.
Plot current <code>currentSensor.i</code>, averaged current <code>meanCurrent.y</code>, total voltage <code>voltageSensor.v</code> and voltage <code>meanVoltage.v</code>.</p>
</html>"));
        end HBridge_R;

        model HBridge_RL "H bridge DC/DC converter with R-L load"
          extends ExampleTemplates.HBridge;
          extends Modelica.Icons.Example;
          parameter Modelica.SIunits.Resistance R=100 "Resistance";
          parameter Modelica.SIunits.Inductance L=1 "Inductance";
          Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={20,50})));
          Modelica.Electrical.Analog.Basic.Inductor inductor(i(fixed=true,
                start=0), L=L) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={20,10})));
        equation
          connect(resistor.n, inductor.p) annotation (Line(
              points={{20,40},{20,20}}, color={0,0,255}));
          connect(inductor.n, currentSensor.p) annotation (Line(
              points={{20,0},{20,-6},{0,-6}}, color={0,0,255}));
          connect(resistor.p, hbridge.dc_p2) annotation (Line(
              points={{20,60},{20,70},{-30,70},{-30,6},{-40,6}}, color={0,0,255}));
          annotation (
            Documentation(info="<html>
<p>This example demonstrates the switching on of an R-L load operated by an H bridge.
DC output voltage is equal to <code>2 * (dutyCycle - 0.5)</code> times the input voltage.
Plot current <code>currentSensor.i</code>, averaged current <code>meanCurrent.y</code>, total voltage <code>voltageSensor.v</code> and voltage <code>meanVoltage.v</code>. The waveform the average current is determined by the time constant <code>L/R</code> of the load.</p>
</html>"),  experiment(
              StopTime=0.1,
              Interval=0.0002,
              Tolerance=1e-06));
        end HBridge_RL;

        model HBridge_DC_Drive "H bridge DC/DC converter with DC drive"
          extends ExampleTemplates.HBridge(signalPWM(useConstantDutyCycle=false),
              constantVoltage(V=120));
          extends Modelica.Icons.Example;
          parameter Modelica.SIunits.Inductance Ld=3*dcpmData.La
            "Smoothing inductance";
          final parameter Modelica.SIunits.Torque tauNominal=dcpmData.ViNominal
              *dcpmData.IaNominal/dcpmData.wNominal "Nominal torque";
          parameter Real dMin=0.2 "Minimum duty cycle";
          parameter Real dMax=1 - dMin "Maximum duty cycle";
          Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet
            dcpm(
            VaNominal=dcpmData.VaNominal,
            IaNominal=dcpmData.IaNominal,
            wNominal=dcpmData.wNominal,
            TaNominal=dcpmData.TaNominal,
            Ra=dcpmData.Ra,
            TaRef=dcpmData.TaRef,
            La=dcpmData.La,
            Jr=dcpmData.Jr,
            useSupport=false,
            Js=dcpmData.Js,
            frictionParameters=dcpmData.frictionParameters,
            coreParameters=dcpmData.coreParameters,
            strayLoadParameters=dcpmData.strayLoadParameters,
            brushParameters=dcpmData.brushParameters,
            ia(start=0, fixed=true),
            TaOperational=293.15,
            alpha20a=dcpmData.alpha20a,
            phiMechanical(fixed=true, start=0),
            wMechanical(fixed=true, start=0)) annotation (Placement(
                transformation(extent={{20,-80},{40,-60}})));
          parameter
            Modelica.Electrical.Machines.Utilities.ParameterRecords.DcPermanentMagnetData
            dcpmData "Data record of PM excited DC machine"
            annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
          Modelica.Mechanics.Rotational.Sources.Torque torque
            annotation (Placement(transformation(extent={{70,-80},{50,-60}})));
          Modelica.Blocks.Sources.TimeTable torqueTable(table=[0, 0; 6, 0; 7, -
                tauNominal; 9, -tauNominal; 10, +tauNominal; 15, tauNominal; 16,
                -tauNominal; 18, -tauNominal; 19, 0; 24, 0])
            annotation (Placement(transformation(extent={{100,-80},{80,-60}})));
          Modelica.Blocks.Sources.TimeTable dutyCycleTable(table=[0, 0.5; 3,
                0.5; 4, dMax; 12, dMax; 13, dMin; 21, dMin; 22, 0.5; 24, 0.5])
            annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
          Modelica.Electrical.Analog.Basic.Inductor inductor(L=Ld) annotation (
              Placement(transformation(
                origin={40,30},
                extent={{10,-10},{-10,10}},
                rotation=90)));
        equation
          connect(inductor.n, dcpm.pin_ap) annotation (Line(
              points={{40,20},{40,-60},{36,-60}}, color={0,0,255}));
          connect(dcpm.pin_an, currentSensor.p) annotation (Line(
              points={{24,-60},{24,-6},{0,-6}}, color={0,0,255}));
          connect(dcpm.flange, torque.flange) annotation (Line(
              points={{40,-70},{50,-70}}));
          connect(torque.tau, torqueTable.y) annotation (Line(
              points={{72,-70},{79,-70}}, color={0,0,127}));
          connect(inductor.p, hbridge.dc_p2) annotation (Line(
              points={{40,40},{40,70},{-30,70},{-30,6},{-40,6}}, color={0,0,255}));
          connect(dutyCycleTable.y, signalPWM.dutyCycle) annotation (Line(
              points={{-79,-60},{-62,-60}}, color={0,0,127}));
          annotation (
            experiment(
              StopTime=24,
              Interval=0.0002,
              Tolerance=1e-06),
            Documentation(info="<html>
<p>This example of an H bridge with DC drive demonstrates the operation of the DC machine in four quadrants.
The DC output voltage is equal to <code>2 * (dutyCycle - 0.5)</code> times the input voltage.</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <th><strong>start time (s)</strong></th>
    <th><strong>machine speed</strong></th>
    <th><strong>machine torque</strong></th>
    <th><strong>mode</strong></th>
  </tr>
  <tr>
    <td>0</td> <td>zero</td> <td>zero</td> <td></td>
  </tr>
  <tr>
    <td>3</td> <td>positive</td> <td>zero</td> <td></td>
  </tr>
  <tr>
    <td>6</td> <td>positive</td> <td>positive</td> <td>motor</td>
  </tr>
  <tr>
    <td>9.5</td> <td>positive</td> <td>negative</td> <td>generator</td>
  </tr>
  <tr>
    <td>12.5</td> <td>negative</td> <td>negative</td> <td>motor</td>
  </tr>
  <tr>
    <td>15.5</td> <td>negative</td> <td>positive</td> <td>generator</td>
  </tr>
  <tr>
    <td>19</td> <td>negative</td> <td>zero</td> <td></td>
  </tr>
  <tr>
    <td>22</td> <td>zero</td> <td>zero</td> <td></td>
  </tr>
</table>

<p>
Plot machine current <code>dcpm.ia</code>, averaged current <code>meanCurrent.y</code>, machine speed <code>dcpm.wMechanical</code>, averaged machine speed <code>dcpm.va</code> and torque <code>dcpm.tauElectrical</code>.</p>
</html>"));
        end HBridge_DC_Drive;
      end HBridge;

      package ExampleTemplates "Templates of examples"
        extends Modelica.Icons.Package;
        partial model ChopperStepDown "Step down chopper including control"
          extends Icons.ExampleTemplate;
          parameter Modelica.SIunits.Frequency f=1000 "Switching frequency";
          parameter Modelica.SIunits.Voltage Vsource=60 "Source voltage";
          parameter Modelica.SIunits.Inductance L=25e-3 "Source inductance";
          parameter Modelica.SIunits.Capacitance C=20e-6 "Smoothing capacitance";
          parameter Real dutyCycle=0.20 "Duty cycle";
          parameter Modelica.SIunits.Current ILoad=1.2 "Load current";
          parameter Modelica.SIunits.Resistance RLoad=V0/ILoad "Load resistance";
          parameter Modelica.SIunits.Voltage V0=Vsource*dutyCycle "No-load output voltage";
          Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(final V=Vsource)
                     annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=270,
                origin={-80,0})));
          Modelica.Electrical.PowerConverters.DCDC.ChopperStepDown chopperStepDown
            annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(extent={{30,-20},{10,0}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=270,
                origin={60,10})));
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(extent={{-90,-40},{-70,-20}})));
          Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM signalPWM(
            constantDutyCycle=dutyCycle, f=f)
                                           annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={-30,-40})));
          Modelica.Blocks.Math.Mean meanCurrent(f=f, x0=0) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={90,-40})));
          Modelica.Blocks.Math.Mean meanVoltage(f=f, x0=0) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={90,10})));
          Modelica.Electrical.Analog.Basic.Inductor inductor(i(fixed=true, start=0), L=L)
            annotation (Placement(transformation(extent={{-30,0},{-10,20}})));
          Modelica.Electrical.Analog.Basic.Capacitor capacitor(C=C, v(fixed=true, start=V0))
            annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={0,0})));
        equation
          connect(constantVoltage.p, chopperStepDown.dc_p1) annotation (Line(
              points={{-80,10},{-70,10},{-70,6},{-60,6}}, color={0,0,255}));
          connect(constantVoltage.n, chopperStepDown.dc_n1) annotation (Line(
              points={{-80,-10},{-70,-10},{-70,-6},{-60,-6}}, color={0,0,255}));
          connect(voltageSensor.n, currentSensor.p) annotation (Line(
              points={{60,0},{60,-10},{30,-10}},
                                              color={0,0,255}));
          connect(constantVoltage.n, ground.p) annotation (Line(
              points={{-80,-10},{-80,-20}}, color={0,0,255}));
          connect(voltageSensor.v, meanVoltage.u) annotation (Line(
              points={{71,10},{78,10}}, color={0,0,127}));
          connect(currentSensor.i, meanCurrent.u) annotation (Line(
              points={{20,-21},{20,-40},{78,-40}},
                                            color={0,0,127}));
          connect(signalPWM.fire, chopperStepDown.fire_p) annotation (Line(
              points={{-36,-29},{-36,-20},{-56,-20},{-56,-12}},
                                            color={255,0,255}));
          connect(chopperStepDown.dc_p2, inductor.p)
            annotation (Line(points={{-40,6},{-30,6},{-30,10}}, color={0,0,255}));
          connect(inductor.n, capacitor.p)
            annotation (Line(points={{-10,10},{1.77636e-15,10}},
                                                       color={0,0,255}));
          connect(voltageSensor.p, capacitor.p)
            annotation (Line(points={{60,20},{60,60},{1.77636e-15,60},{
                  1.77636e-15,10}},                                  color={0,0,255}));
          connect(chopperStepDown.dc_n2, capacitor.n) annotation (Line(points={
                  {-40,-6},{-20,-6},{-20,-10},{-1.77636e-15,-10}}, color={0,0,
                  255}));
          connect(capacitor.n, currentSensor.n) annotation (Line(points={{
                  -1.77636e-15,-10},{10,-10}}, color={0,0,255}));
          annotation (Documentation(
                info="<html>
<p>Step down chopper example template including supply and sensors; load is not yet included</p>
</html>"));
        end ChopperStepDown;

        partial model ChopperStepUp "Step up chopper including control"
          extends Icons.ExampleTemplate;
          parameter Modelica.SIunits.Frequency f=1000 "Switching frequency";
          parameter Modelica.SIunits.Voltage Vsource=60 "Source voltage";
          parameter Modelica.SIunits.Inductance L=25e-3 "Source inductance";
          parameter Modelica.SIunits.Capacitance C=20e-6 "Smoothing capacitance";
          parameter Real dutyCycle=0.20 "Duty cycle";
          parameter Modelica.SIunits.Current ILoad=1.2 "Load current";
          parameter Modelica.SIunits.Resistance RLoad=V0/ILoad "Load resistance";
          parameter Modelica.SIunits.Voltage V0=Vsource/(1 - dutyCycle) "No-load output voltage";
          Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=Vsource)
                     annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=270,
                origin={-80,0})));
          Modelica.Electrical.PowerConverters.DCDC.ChopperStepUp chopperStepUp
            annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(extent={{30,-20},{10,0}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=270,
                origin={60,10})));
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(extent={{-90,-40},{-70,-20}})));
          Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM signalPWM(
            constantDutyCycle=dutyCycle, f=f)
                                           annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={-30,-40})));
          Modelica.Blocks.Math.Mean meanCurrent(f=f, x0=0) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={90,-40})));
          Modelica.Blocks.Math.Mean meanVoltage(f=f, x0=0) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={90,10})));
          Analog.Basic.Inductor inductor(i(fixed=true, start=0), final L=L)
            annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
          Modelica.Electrical.Analog.Basic.Capacitor capacitor(C=C, v(fixed=true, start=V0))
                                                               annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={0,0})));
        equation
          connect(constantVoltage.n, chopperStepUp.dc_n1) annotation (Line(points={{-80,
                  -10},{-50,-10},{-50,-6},{-40,-6}}, color={0,0,255}));
          connect(voltageSensor.n, currentSensor.p) annotation (Line(
              points={{60,0},{60,-10},{30,-10}},
                                              color={0,0,255}));
          connect(constantVoltage.n, ground.p) annotation (Line(
              points={{-80,-10},{-80,-20}}, color={0,0,255}));
          connect(voltageSensor.v, meanVoltage.u) annotation (Line(
              points={{71,10},{78,10}}, color={0,0,127}));
          connect(currentSensor.i, meanCurrent.u) annotation (Line(
              points={{20,-21},{20,-40},{78,-40}},
                                            color={0,0,127}));
          connect(signalPWM.fire, chopperStepUp.fire_p)
            annotation (Line(points={{-36,-29},{-36,-12}}, color={255,0,255}));
          connect(constantVoltage.p, inductor.p)
            annotation (Line(points={{-80,10},{-70,10}}, color={0,0,255}));
          connect(inductor.n, chopperStepUp.dc_p1) annotation (Line(points={{-50,
                  10},{-50,6},{-40,6}}, color={0,0,255}));
          connect(voltageSensor.p, capacitor.p)
            annotation (Line(points={{60,20},{60,60},{1.77636e-15,60},{
                  1.77636e-15,10}},                                  color={0,0,255}));
          connect(capacitor.p, chopperStepUp.dc_p2) annotation (Line(points={{
                  1.77636e-15,10},{-10,10},{-10,6},{-20,6}},
                                        color={0,0,255}));
          connect(chopperStepUp.dc_n2, capacitor.n) annotation (Line(points={{-20,-6},
                  {-10,-6},{-10,-10},{-1.77636e-15,-10}},
                                          color={0,0,255}));
          connect(capacitor.n, currentSensor.n)
            annotation (Line(points={{-1.77636e-15,-10},{10,-10}},
                                                        color={0,0,255}));
          annotation (Documentation(
                info="<html>
<p>Step up chopper example template including supply and sensors; load is not yet included</p>
</html>"));
        end ChopperStepUp;

        partial model HBridge "H bridge DC/DC converter"
          extends Icons.ExampleTemplate;
          parameter Modelica.SIunits.Frequency f=1000 "Switching frequency";
          Modelica.Electrical.PowerConverters.DCDC.HBridge hbridge(useHeatPort=
                false)
            annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
          Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=
                100) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-80,0})));
          Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM signalPWM(
              constantDutyCycle=0.6, f=f) annotation (Placement(transformation(
                  extent={{-60,-70},{-40,-50}})));
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(extent={{-90,-40},{-70,-20}})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(extent={{0,-16},{-20,4}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=270,
                origin={60,10})));
          Modelica.Blocks.Math.Mean meanCurrent(f=f, x0=0) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-10,-40})));
          Modelica.Blocks.Math.Mean meanVoltage(f=f, x0=0) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={90,10})));
        equation
          connect(hbridge.fire_p, signalPWM.fire) annotation (Line(
              points={{-56,-12},{-56,-49}}, color={255,0,255}));
          connect(ground.p, constantVoltage.n) annotation (Line(
              points={{-80,-20},{-80,-10}}, color={0,0,255}));
          connect(constantVoltage.p, hbridge.dc_p1) annotation (Line(
              points={{-80,10},{-68,10},{-68,6},{-60,6}}, color={0,0,255}));
          connect(constantVoltage.n, hbridge.dc_n1) annotation (Line(
              points={{-80,-10},{-68,-10},{-68,-6},{-60,-6}}, color={0,0,255}));
          connect(voltageSensor.n, currentSensor.p) annotation (Line(
              points={{60,0},{60,-6},{0,-6}}, color={0,0,255}));
          connect(voltageSensor.v, meanVoltage.u) annotation (Line(
              points={{71,10},{78,10}}, color={0,0,127}));
          connect(currentSensor.i, meanCurrent.u) annotation (Line(
              points={{-10,-17},{-10,-28}}, color={0,0,127}));
          connect(hbridge.dc_p2, voltageSensor.p) annotation (Line(
              points={{-40,6},{-30,6},{-30,70},{60,70},{60,20}}, color={0,0,255}));
          connect(currentSensor.n, hbridge.dc_n2) annotation (Line(
              points={{-20,-6},{-40,-6}}, color={0,0,255}));
          connect(signalPWM.notFire, hbridge.fire_n) annotation (Line(
              points={{-44,-49},{-44,-12}}, color={255,0,255}));
          annotation (Documentation(
                info="<html>
<p>H bridge example template including supply and sensors; load is not yet included</p>
</html>"));
        end HBridge;
        annotation (Documentation(info="<html>
<p>This package includes templates of the used examples. The templates are partial example models.</p>
</html>"));
      end ExampleTemplates;
    end DCDC;

    package ACAC "AC to AC converter examples"
      extends Modelica.Icons.ExamplesPackage;
      model Dimmer_R "Dimmer with resistive load"
        extends
          Modelica.Electrical.PowerConverters.Examples.ACAC.ExampleTemplates.Dimmer(powerFactor=1);
        extends Modelica.Icons.Example;
        Analog.Basic.Resistor loadResistor(R=RLoad) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={50,10})));
      equation
        connect(ground.p, loadResistor.n) annotation (Line(points={{-80,-20},{50,-20},
                {50,-3.55271e-15}}, color={0,0,255}));
        connect(loadResistor.p, multiSensor.nc)
          annotation (Line(points={{50,20},{50,40},{30,40}}, color={0,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(
            StopTime=8,
            Interval=0.0001,
            Tolerance=1e-06),
          Documentation(info="<html>
<p>
This model demonstrates the behaviour of a dimmer with phase-angle control with resistive load.
</p>
<p>
The reference voltage is prescribed by a trapezoid between zero and full voltage. 
The <a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.Control.VoltageToAngle\">voltageToAngle block</a> 
calculates the necessary phase angle, which is processed by 
the <a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control.Signal2mPulse\">Signal2mPulse adaptor</a>, 
applying the firing signals to the 
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.SinglePhaseTriac\">triac</a>.
</p>
</html>"));
      end Dimmer_R;

      model Dimmer_RL "Dimmer with resistive-inductive load"
        extends
          Modelica.Electrical.PowerConverters.Examples.ACAC.ExampleTemplates.Dimmer(powerFactor=0.87);
        extends Modelica.Icons.Example;
        Analog.Basic.Resistor loadResistor(R=RLoad) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={50,30})));
        Analog.Basic.Inductor loadInductor(i(start=0, fixed=true), L=LLoad)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={50,-10})));
      equation
        connect(loadResistor.p, multiSensor.nc)
          annotation (Line(points={{50,40},{30,40}},         color={0,0,255}));
        connect(ground.p, loadInductor.n)
          annotation (Line(points={{-80,-20},{50,-20}}, color={0,0,255}));
        connect(loadInductor.p, loadResistor.n)
          annotation (Line(points={{50,0},{50,20}}, color={0,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(
            StopTime=8,
            Interval=0.0001,
            Tolerance=1e-06),
          Documentation(info="<html>
<p>
This model demonstrates the behaviour of a dimmer with phase-angle control with resistive-inductive load. 
Note that due to the inductance the current is not zero at the points in time wehre zero-crossing of the voltage occurs, 
and the triac stays conducting until the current becomes zero.
</p>
<p>
The reference voltage is prescribed by a trapezoid between zero and full voltage. 
The <a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.Control.VoltageToAngle\">voltageToAngle block</a> 
calculates the necessary phase angle, which is processed by 
the <a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control.Signal2mPulse\">Signal2mPulse adaptor</a>, 
applying the firing signals to the 
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.SinglePhaseTriac\">triac</a>.
</p>
</html>"));
      end Dimmer_RL;

      model SoftStarter "Soft start of an induction machine"
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        constant Integer m=3 "Number of phases";
        constant Real y2d=Modelica.Electrical.MultiPhase.Functions.factorY2D(m);
        parameter Modelica.SIunits.Voltage VNominal=100 "Nominal RMS voltage line to line";
        parameter Modelica.SIunits.Current INominal=100*y2d "Nominal RMS current at the terminals";
        parameter Modelica.SIunits.Frequency fNominal=aimcData.fsNominal "Nominal frequency";
        parameter Modelica.SIunits.Inertia JLoad=aimcData.Jr "Load's moment of inertia";
        parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity wLoad(displayUnit="rev/min")=
             1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
          final m=m,
          freqHz=fill(fNominal, m),
          V=sqrt(2)*fill(VNominal, m)/y2d)
          annotation (Placement(transformation(
              origin={-80,0},
              extent={{10,-10},{-10,10}},
              rotation=90)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m)
          annotation (
            Placement(transformation(extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-80,-30})));
        Modelica.Electrical.Analog.Basic.Ground ground
          annotation (Placement(
              transformation(
              origin={-80,-60},
              extent={{-10,-10},{10,10}},
              rotation=0)));
        MultiPhase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor(m=m)
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=270,
              origin={-80,30})));
        Modelica.Electrical.PowerConverters.ACAC.PolyphaseTriac triac(final m=m,
            useHeatPort=false)
          annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
        Modelica.Electrical.MultiPhase.Sensors.VoltageSensor voltageSensor(m=m)
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-60,0})));
        Modelica.Electrical.MultiPhase.Basic.Star star1(m=m)
          annotation (Placement(
              transformation(
              extent={{-10,10},{10,-10}},
              rotation=270,
              origin={-60,-30})));
        Modelica.Electrical.Analog.Basic.Ground ground1
          annotation (Placement(
              transformation(
              origin={-60,-60},
              extent={{-10,-10},{10,10}},
              rotation=0)));
        Modelica.Electrical.PowerConverters.ACDC.Control.Signal2mPulse adaptor(
          m=m,
          useConstantFiringAngle=false,
          useFilter=false,
          f=fNominal)
          annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
        Modelica.Electrical.PowerConverters.ACAC.Control.VoltageToAngle voltageToAngle(
          VNominal=1,
          voltage2Angle=Modelica.Electrical.PowerConverters.Types.Voltage2AngleType.H01)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-30,-30})));
        Modelica.Electrical.MultiPhase.Sensors.MultiSensor multiSensor(m=m)
          annotation (Placement(transformation(extent={{-10,30},{10,50}})));
        Modelica.Electrical.MultiPhase.Basic.Star star2(m=m)
          annotation (Placement(
              transformation(
              extent={{-10,10},{10,-10}},
              rotation=270,
              origin={0,0})));
        Modelica.Electrical.Analog.Basic.Ground ground2
          annotation (Placement(
              transformation(
              origin={0,-30},
              extent={{-10,-10},{10,10}},
              rotation=0)));
        Modelica.Blocks.Math.RootMeanSquare rootMeanSquare(f=fNominal)
          annotation (Placement(transformation(extent={{40,50},{60,70}})));
        Modelica.Blocks.Math.Harmonic harmonic(f=fNominal,k=1)
          annotation (Placement(transformation(extent={{40,20},{60,40}})));
        Machines.Utilities.MultiTerminalBox terminalBox(m=m, terminalConnection="D")
          annotation (Placement(transformation(extent={{10,6},{30,26}})));
        Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
          imc(
          m=m,
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          Rs=aimcData.Rs*m/3,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          effectiveStatorTurns=aimcData.effectiveStatorTurns,
          Lszero=aimcData.Lszero*m/3,
          Lssigma=aimcData.Lssigma*m/3,
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          frictionParameters=aimcData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          Lm=aimcData.Lm*m/3,
          Lrsigma=aimcData.Lrsigma*m/3,
          Rr=aimcData.Rr*m/3,
          TrRef=aimcData.TrRef,
          TsOperational=293.15,
          alpha20r=aimcData.alpha20r,
          TrOperational=293.15)
          annotation (Placement(transformation(extent={{10,-10},{30,10}})));
        parameter Modelica.Electrical.Machines.Utilities.ParameterRecords.AIM_SquirrelCageData aimcData
          annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{40,-10},{60,10}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticLoadTorque(
          w_nominal=wLoad,
          TorqueDirection=false,
          tau_nominal=-TLoad,
          useSupport=false) annotation (Placement(transformation(extent={{90,-10},{70,10}})));
        Modelica.Electrical.PowerConverters.ACAC.Control.SoftStartControl softStartControl(
          tRampUp=4,
          vStart=0.3,
          iMax=2.5,
          iMin=2.4,
          INominal=INominal,
          tRampDown=3,
          vRef(fixed=true)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-30,-60})));
        Modelica.Blocks.Continuous.Filter filter(analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
            f_cut=2*fNominal)
          annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
        Modelica.Blocks.Sources.BooleanTable booleanTable(table={0.1,5.5},
            startTime=0)
          annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
      initial equation
        imc.is[1:3] = zeros(3);
        imc.ir[1:2] = zeros(2);
      equation
        connect(ground.p, star.pin_n)
          annotation (Line(points={{-80,-50},{-80,-40}}, color={0,0,255}));
        connect(sineVoltage.plug_n, star.plug_p)
          annotation (Line(points={{-80,-10},{-80,-20}}, color={0,0,255}));
        connect(imc.flange, loadInertia.flange_a)
          annotation (Line(points={{30,0},{40,0}}, color={0,0,0}));
        connect(triac.plug_n, multiSensor.pc)
          annotation (Line(points={{-20,40},{-10,40}}, color={0,0,255}));
        connect(multiSensor.pc, multiSensor.pv)
          annotation (Line(points={{-10,40},{-10,50},{0,50}}, color={0,0,255}));
        connect(multiSensor.nv,star2. plug_p)
          annotation (Line(points={{0,30},{0,10},{1.77636e-15,10}},
                                                   color={0,0,255}));
        connect(terminalBox.plug_sn, imc.plug_sn)
          annotation (Line(points={{14,10},{14,10}}, color={0,0,255}));
        connect(terminalBox.plug_sp, imc.plug_sp)
          annotation (Line(points={{26,10},{26,10}}, color={0,0,255}));
        connect(triac.fire1, adaptor.fire_p)
          annotation (Line(points={{-36,28},{-36,11}}, color={255,0,255}));
        connect(triac.fire2, adaptor.fire_n)
          annotation (Line(points={{-24,28},{-24,11}}, color={255,0,255}));
        connect(voltageSensor.v, adaptor.v)
          annotation (Line(points={{-49,-8.88178e-16},{-46,-8.88178e-16},{-46,0},{-42,
                0}},                                 color={0,0,127}));
        connect(currentQuasiRMSSensor.plug_p, sineVoltage.plug_p)
          annotation (Line(points={{-80,20},{-80,10}}, color={0,0,255}));
        connect(currentQuasiRMSSensor.plug_n, triac.plug_p)
          annotation (Line(points={{-80,40},{-40,40}}, color={0,0,255}));
        connect(multiSensor.nc, terminalBox.plugSupply)
          annotation (Line(points={{10,40},{20,40},{20,12}}, color={0,0,255}));
        connect(triac.plug_p, voltageSensor.plug_p)
          annotation (Line(points={{-40,40},{-60,40},{-60,10}}, color={0,0,255}));
        connect(voltageSensor.plug_n, star1.plug_p)
          annotation (Line(points={{-60,-10},{-60,-20}}, color={0,0,255}));
        connect(star1.pin_n, ground1.p)
          annotation (Line(points={{-60,-40},{-60,-50}}, color={0,0,255}));
        connect(star2.pin_n, ground2.p)
          annotation (Line(points={{0,-10},{0,-20}}, color={0,0,255}));
        connect(multiSensor.v[1], harmonic.u) annotation (Line(points={{6,29},{6,20},{
                30,20},{30,30},{38,30}},      color={0,0,127}));
        connect(multiSensor.v[1], rootMeanSquare.u) annotation (Line(points={{6,29},{6,
                20},{30,20},{30,60},{38,60}},    color={0,0,127}));
        connect(loadInertia.flange_b, quadraticLoadTorque.flange)
          annotation (Line(points={{60,0},{70,0}}, color={0,0,0}));
        connect(currentQuasiRMSSensor.I, filter.u) annotation (Line(points={{-91,
                30},{-100,30},{-100,-80},{-62,-80}}, color={0,0,127}));
        connect(voltageToAngle.firingAngle, adaptor.firingAngle)
          annotation (Line(points={{-30,-19},{-30,-12}}, color={0,0,127}));
        connect(filter.y, softStartControl.iRMS)
          annotation (Line(points={{-39,-80},{-30,-80},{-30,-72}}, color={0,0,127}));
        connect(voltageToAngle.vRef, softStartControl.vRef)
          annotation (Line(points={{-30,-42},{-30,-49}}, color={0,0,127}));
        connect(booleanTable.y, softStartControl.start)
          annotation (Line(points={{-11,-60},{-18,-60}}, color={255,0,255}));
        annotation (experiment(
            StopTime=10,
            Interval=0.0001,
            Tolerance=1e-06), Documentation(info="<html>
<p>This model demonstrates a soft start of an induction machine: 
Voltage ramp is started at 0.1 s and should ramp up to nominal voltage within 4s, 
but current is limited to 2.5 times nominal current. 
At 5.5 s a voltage ramp down within 3 s is required.
</p>
<p>Reference voltage is controlled by the 
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.Control.SoftStartControl\">softStartControl block</a>, 
reference voltage is converted to firing angle by the
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.Control.VoltageToAngle\">voltageToAngle block</a>. 
Firing angle is processed by the 
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control.Signal2mPulse\">Signal2mPulse adaptor</a> 
to firing signals which are applied to the 
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.MultiPhaseTriac\">triac</a>.
</p>
<p>
Compare starting with firing angle by 
<a href=\"modelica://Modelica.Electrical.Machines.Examples.AsynchronousInductionMachines.AIMC_DOL\">starting direct on line</a>,
<a href=\"modelica://Modelica.Electrical.Machines.Examples.AsynchronousInductionMachines.AIMC_YD\">star-delta starting</a>, and 
<a href=\"modelica://Modelica.Electrical.Machines.Examples.AsynchronousInductionMachines.AIMC_Transformer\">starting via a transformer</a>.
</p>
</html>"));
      end SoftStarter;

      package ExampleTemplates "Templates of examples"
        extends Modelica.Icons.Package;
        partial model Dimmer "Dimmer including control"
          extends Icons.ExampleTemplate;
          import Modelica.Constants.pi;
          parameter Modelica.SIunits.Frequency f=50 "Source frequency";
          parameter Modelica.SIunits.Voltage Vrms=110 "RMS source voltage";
          parameter Modelica.SIunits.ApparentPower S=1000 "Load apparent power";
          parameter Real powerFactor(final min=0, final max=1)=0.87 "Load power factor";
          parameter Modelica.SIunits.Impedance ZLoad=Vrms^2/S "Load impedance";
          parameter Modelica.SIunits.Resistance RLoad=ZLoad*powerFactor "Load resistance";
          parameter Modelica.SIunits.Inductance LLoad=ZLoad*sqrt(1 - powerFactor^2)/(2*pi*f) "Load inductance";
          Analog.Sources.SineVoltage sineVoltage(final V = sqrt(2) * Vrms, freqHz = f)
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=270,
                origin={-80,10})));
          Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
                transformation(extent={{-90,-40},{-70,-20}})));
          Modelica.Electrical.PowerConverters.ACAC.SinglePhaseTriac triac(Ron=1e-9, Goff=1e-9)
            annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
          Analog.Sensors.VoltageSensor voltageSensor annotation (Placement(
                transformation(
                extent={{10,-10},{-10,10}},
                rotation=90,
                origin={-60,10})));
          Modelica.Electrical.PowerConverters.ACDC.Control.Signal2mPulse adaptor(
            m=1,   useConstantFiringAngle=false,
            f=f)
            annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
          Analog.Sensors.MultiSensor multiSensor
            annotation (Placement(transformation(extent={{10,30},{30,50}})));
          Modelica.Electrical.PowerConverters.ACAC.Control.VoltageToAngle
            voltageToAngle(VNominal=1, voltage2Angle=Modelica.Electrical.PowerConverters.Types.Voltage2AngleType.RMS)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-30,-40})));
          Blocks.Sources.Trapezoid trapezoid(
            amplitude=1,
            rising=2,
            width=2,
            falling=2,
            period=8,
            nperiod=1,
            offset=0,
            startTime=1)
            annotation (Placement(transformation(extent={{-70,-80},{-50,-60}})));
          Blocks.Math.Mean meanPower(f=f) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={0,10})));
          Blocks.Math.RootMeanSquare vRMS(f=f)
            annotation (Placement(transformation(extent={{70,-60},{90,-40}})));
          Blocks.Math.Harmonic vH01(f=f, k=1)
            annotation (Placement(transformation(extent={{70,-90},{90,-70}})));
          Blocks.Math.RootMeanSquare iRMS(f=f)
            annotation (Placement(transformation(extent={{30,-60},{50,-40}})));
          Blocks.Math.Harmonic iH01(f=f, k=1)
            annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
        equation
          connect(sineVoltage.n, ground.p)
            annotation (Line(points={{-80,0},{-80,-20}},   color={0,0,255}));
          connect(ground.p, voltageSensor.n) annotation (Line(points={{-80,-20},
                  {-60,-20},{-60,0}}, color={0,0,255}));
          connect(voltageSensor.v, adaptor.v[1])
            annotation (Line(points={{-49,10},{-42,10}}, color={0,0,127}));
          connect(sineVoltage.p, triac.p)
            annotation (Line(points={{-80,20},{-80,40},{-40,40}}, color={0,0,255}));
          connect(triac.p, voltageSensor.p) annotation (Line(points={{-40,40},{
                  -60,40},{-60,20}}, color={0,0,255}));
          connect(adaptor.fire_p[1], triac.fire1)
            annotation (Line(points={{-36,21},{-36,28}}, color={255,0,255}));
          connect(adaptor.fire_n[1], triac.fire2)
            annotation (Line(points={{-24,21},{-24,28}}, color={255,0,255}));
          connect(triac.n, multiSensor.pc)
            annotation (Line(points={{-20,40},{10,40}},  color={0,0,255}));
          connect(multiSensor.pc, multiSensor.pv)
            annotation (Line(points={{10,40},{10,50},{20,50}},  color={0,0,255}));
          connect(voltageToAngle.firingAngle, adaptor.firingAngle)
            annotation (Line(points={{-30,-29},{-30,-2}}, color={0,0,127}));
          connect(trapezoid.y, voltageToAngle.vRef)
            annotation (Line(points={{-49,-70},{-30,-70},{-30,-52}}, color={0,0,127}));
          connect(multiSensor.power, meanPower.u) annotation (Line(points={{9,
                  34},{2.22045e-15,34},{2.22045e-15,22}}, color={0,0,127}));
          connect(ground.p, multiSensor.nv) annotation (Line(points={{-80,-20},
                  {20,-20},{20,30}}, color={0,0,255}));
          connect(multiSensor.i, iRMS.u) annotation (Line(points={{14,29},{14,
                  -50},{28,-50}}, color={0,0,127}));
          connect(multiSensor.i, iH01.u) annotation (Line(points={{14,29},{14,
                  -80},{28,-80}}, color={0,0,127}));
          connect(multiSensor.v, vRMS.u) annotation (Line(points={{26,29},{26,
                  -30},{60,-30},{60,-50},{68,-50}}, color={0,0,127}));
          connect(multiSensor.v, vH01.u) annotation (Line(points={{26,29},{26,
                  -30},{60,-30},{60,-80},{68,-80}}, color={0,0,127}));
          annotation (Documentation(
                info="<html>
<p>Dimmer example template including supply and sensors; load is not yet included</p>
</html>"), experiment(
              StopTime=8,
              Interval=0.0001,
              Tolerance=1e-06));
        end Dimmer;

    annotation (Documentation(info="<html>
<p>This package includes templates of the used examples. The templates are partial example models.</p>
</html>"));
      end ExampleTemplates;
    end ACAC;
    annotation (Documentation(info="<html>
<p>This is a collection of AC/DC, DC/DC and DC/AC converters.</p>
</html>"));
  end Examples;

  package ACDC "AC to DC converters"
    package Control "Control components for rectifiers"
      extends Modelica.Icons.Package;
      block Signal2mPulse "Generic control of 2*m pulse rectifiers"
        import Modelica.Constants.pi;
        extends Modelica.Electrical.PowerConverters.Icons.Control;
        parameter Integer m(final min=1) = 3 "Number of phases";
        parameter Boolean useConstantFiringAngle=true
          "Use constant firing angle instead of signal input";
        parameter Modelica.SIunits.Angle constantFiringAngle=0 "Firing angle"
          annotation (Dialog(enable=useConstantFiringAngle));
        parameter Boolean useFilter=true "Enable use of filter"
          annotation (Dialog(tab="Filter"));
        parameter Modelica.SIunits.Frequency f=50 "Frequency";
        parameter Modelica.SIunits.Frequency fCut=2*f
          "Cut off frequency of filter"
          annotation (Dialog(tab="Filter", enable=useFilter));
        parameter Modelica.SIunits.Voltage vStart[m]=zeros(m)
          "Start voltage of filter output"
          annotation (Dialog(tab="Filter", enable=useFilter));
        Modelica.Blocks.Interfaces.RealInput firingAngle if not
          useConstantFiringAngle "Firing angle (rad)" annotation (Placement(
              transformation(
              extent={{20,-20},{-20,20}},
              rotation=270,
              origin={0,-120})));
        parameter Modelica.SIunits.Angle firingAngleMax(
          final min=0, final max=pi) = Modelica.Constants.pi
          "Maximum firing angle";
        parameter Modelica.SIunits.Angle firingAngleMin(
          final min=0, final max=pi) = 0
          "Minimum firing angle";
        Modelica.Blocks.Sources.Constant constantconstantFiringAngle(final k=
              constantFiringAngle) if useConstantFiringAngle annotation (
            Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={-30,-80})));
        Modelica.Blocks.Logical.GreaterThreshold positiveThreshold[m](threshold=
             zeros(m)) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=270,
              origin={-60,-20})));
        Modelica.Blocks.Logical.LessThreshold negativeThreshold[m](threshold=
              zeros(m)) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=270,
              origin={60,-20})));
        Modelica.Blocks.Logical.Timer timerPositive[m] annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=270,
              origin={-60,10})));
        Modelica.Blocks.Logical.Timer timerNegative[m] annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=270,
              origin={60,10})));
        Modelica.Blocks.Logical.Greater greaterPositive[m] annotation (
            Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=270,
              origin={-60,80})));
        Modelica.Blocks.Logical.Greater greaterNegative[m] annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=270,
              origin={60,80})));
        Modelica.Blocks.Interfaces.BooleanOutput fire_p[m] annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-60,110})));
        Modelica.Blocks.Interfaces.BooleanOutput fire_n[m] annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={60,110})));
        Modelica.Blocks.Math.Gain gain(final k=1/pi)     annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=270,
              origin={0,10})));
        Modelica.Blocks.Routing.Replicator replicator(final nout=m) annotation (
           Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=270,
              origin={0,40})));
        Modelica.Blocks.Nonlinear.Limiter limiter(final uMax=min(firingAngleMax, pi),
            final uMin=max(firingAngleMin, 0))
                                             annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=270,
              origin={0,-20})));
        Modelica.Blocks.Interfaces.RealInput v[m] "Voltages" annotation (
            Placement(transformation(
              extent={{-20,-20},{20,20}},
              origin={-120,0})));
        Filter filter[m](
          each final f=f,
          each final fCut=fCut,
          yStart=vStart) if useFilter annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={-80,-80})));
        Modelica.Blocks.Routing.RealPassThrough realPassThrough[m] if not
          useFilter "Pass through in case filter is off"
          annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));
        Blocks.Math.Gain gainPositive[m](each final k=2*f) annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=270,
              origin={-60,40})));
        Blocks.Math.Gain gainNegative[m](each final k=2*f) annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=270,
              origin={60,40})));
      equation
        assert(firingAngleMax>firingAngleMin,
          "Signal2mPulse: firingAngleMax has to be greater than firingAngleMin");
        connect(positiveThreshold.y, timerPositive.u) annotation (Line(
            points={{-60,-9},{-60,-2}}, color={255,0,255}));
        connect(negativeThreshold.y, timerNegative.u) annotation (Line(
            points={{60,-9},{60,-2}}, color={255,0,255}));
        connect(greaterPositive.y, fire_p) annotation (Line(
            points={{-60,91},{-60,110}}, color={255,0,255}));
        connect(greaterNegative.y, fire_n)
          annotation (Line(points={{60,91},{60,110}}, color={255,0,255}));
        connect(gain.y, replicator.u) annotation (Line(
            points={{0,21},{0,28}}, color={0,0,127}));
        connect(replicator.y, greaterPositive.u2) annotation (Line(
            points={{0,51},{0,60},{-52,60},{-52,68}}, color={0,0,127}));
        connect(replicator.y, greaterNegative.u2)
          annotation (Line(points={{0,51},{0,60},{52,60},{52,68}}, color={0,0,127}));
        connect(limiter.y, gain.u) annotation (Line(
            points={{0,-9},{0,-2}}, color={0,0,127}));
        connect(firingAngle, limiter.u) annotation (Line(
            points={{0,-120},{0,-32}}, color={0,0,127}));
        connect(constantconstantFiringAngle.y, limiter.u) annotation (Line(
            points={{-19,-80},{0,-80},{0,-32}}, color={0,0,127}));
        connect(v, filter.u) annotation (Line(
            points={{-120,0},{-100,0},{-100,-80},{-92,-80}}, color={0,0,127}));
        connect(filter.y, positiveThreshold.u) annotation (Line(
            points={{-69,-80},{-60,-80},{-60,-32}},color={0,0,127}));
        connect(filter.y, negativeThreshold.u) annotation (Line(
            points={{-69,-80},{-60,-80},{-60,-50},{60,-50},{60,-32}},
                          color={0,0,127}));
        connect(realPassThrough.u, v) annotation (Line(
            points={{-92,-50},{-100,-50},{-100,0},{-120,0}}, color={0,0,127}));
        connect(realPassThrough.y, positiveThreshold.u) annotation (Line(
            points={{-69,-50},{-60,-50},{-60,-32}},color={0,0,127}));
        connect(realPassThrough.y, negativeThreshold.u) annotation (Line(
            points={{-69,-50},{60,-50},{60,-32}},                    color={0,0,127}));
        connect(timerPositive.y, gainPositive.u)
          annotation (Line(points={{-60,21},{-60,28}}, color={0,0,127}));
        connect(gainPositive.y, greaterPositive.u1)
          annotation (Line(points={{-60,51},{-60,68}}, color={0,0,127}));
        connect(gainNegative.y, greaterNegative.u1)
          annotation (Line(points={{60,51},{60,68}}, color={0,0,127}));
        connect(timerNegative.y, gainNegative.u)
          annotation (Line(points={{60,21},{60,28}}, color={0,0,127}));
        annotation (defaultComponentName="adaptor",
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}),graphics={Line(
                      points={{-40,-20},{-40,-24},{-20,-24},{-20,-40},{-40,-40},
                  {-40,-60}},
                      color={255,0,255}),Line(
                      points={{20,-20},{20,-44},{40,-44},{40,-60},{20,-60},{20,
                  -60}},
                      color={255,0,255}),Text(
                      extent={{-40,60},{40,0}},
                      textColor={255,0,255},
                      textString="2*%m%")}),
          Documentation(revisions="<html>
</html>", info="<html>

<p>
General information about controllers is summarized in
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control\">Control</a>.
</p>
</html>"));
      end Signal2mPulse;

      model VoltageBridge2Pulse "Control of 2 pulse bridge rectifier"
        import Modelica.Constants.pi;
        extends Icons.Control;
        parameter Modelica.SIunits.Frequency f=50 "Frequency";
        parameter Boolean useConstantFiringAngle=true
          "Use constant firing angle instead of signal input";
        parameter Modelica.SIunits.Angle constantFiringAngle=0 "Firing angle"
          annotation (Dialog(enable=useConstantFiringAngle));
        parameter Modelica.SIunits.Angle firingAngleMax(
          final min=0,
          final max=Modelica.Constants.pi) = Modelica.Constants.pi
          "Maximum firing angle";
        parameter Boolean useFilter=true "Enable use of filter"
          annotation (Dialog(tab="Filter"));
        parameter Modelica.SIunits.Frequency fCut=2*f
          "Cut off frequency of filter"
          annotation (Dialog(tab="Filter", enable=useFilter));
        parameter Modelica.SIunits.Voltage vStart=0
          "Start voltage of filter output"
          annotation (Dialog(tab="Filter", enable=useFilter));
        Modelica.Blocks.Interfaces.RealInput firingAngle if not
          useConstantFiringAngle "Firing angle (rad)" annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-120})));
        Signal2mPulse twoPulse(
          final useConstantFiringAngle=useConstantFiringAngle,
          final f=f,
          final constantFiringAngle=constantFiringAngle,
          final firingAngleMax=firingAngleMax,
          final m=1,
          final useFilter=useFilter,
          final fCut=fCut,
          final vStart=fill(vStart, 1)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}})));
        Modelica.Electrical.Analog.Interfaces.PositivePin ac_p
          annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin ac_n
          annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
        Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
          annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=270,
              origin={-80,0})));
        Modelica.Blocks.Interfaces.BooleanOutput fire_p annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-60,110})));
        Modelica.Blocks.Interfaces.BooleanOutput fire_n annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={60,110})));
      equation
        connect(voltageSensor.v, twoPulse.v[1]) annotation (Line(
            points={{-69,0},{-12,0}},
                     color={0,0,127}));
        connect(voltageSensor.p, ac_p) annotation (Line(
            points={{-80,10},{-80,60},{-100,60}}, color={0,0,255}));
        connect(voltageSensor.n, ac_n) annotation (Line(
            points={{-80,-10},{-80,-60},{-100,-60}}, color={0,0,255}));
        connect(firingAngle, twoPulse.firingAngle) annotation (Line(
            points={{0,-120},{0,-12}}, color={0,0,127}));
        connect(twoPulse.fire_n[1], fire_n) annotation (Line(
            points={{6,11},{6,80},{60,80},{60,110}}, color={255,0,255}));
        connect(twoPulse.fire_p[1], fire_p) annotation (Line(
            points={{-6,11},{-6,80},{-60,80},{-60,110}}, color={255,0,255}));
        annotation (defaultComponentName="adaptor",
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}),graphics={Line(
                      points={{-40,-20},{-40,-24},{-20,-24},{-20,-40},{-40,-40},
                  {-40,-60}},
                      color={255,0,255}),Line(
                      points={{20,-20},{20,-44},{40,-44},{40,-60},{20,-60},{20,
                  -60}},
                      color={255,0,255}),Text(
                      extent={{-40,60},{40,0}},
                      textColor={255,0,255},
                      textString="2")}),
          Documentation(revisions="<html>
</html>", info="<html>

<p>
General information about controllers is summarized in
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control\">Control</a>.
</p>

<p>
This model provides two firing signal for Graetz bridge thyristor and half bridge rectifiers. The boolean
signal <code>fire_p</code> is assigned to the thyristors connected with the positive DC output pin.
The boolean
signal <code>fire_n</code> is assigned to the thyristors connected with the negative DC output pin.
</p>
</html>"));
      end VoltageBridge2Pulse;

      model VoltageBridge2mPulse "Control of 2*m pulse bridge rectifier"
        import Modelica.Constants.pi;
        extends Icons.Control;
        parameter Integer m(final min=3) = 3 "Number of phases";
        parameter Modelica.SIunits.Frequency f=50 "Frequency";
        parameter Boolean useConstantFiringAngle=true
          "Use constant firing angle instead of signal input";
        parameter Modelica.SIunits.Angle constantFiringAngle=0 "Firing angle"
          annotation (Dialog(enable=useConstantFiringAngle));
        parameter Modelica.SIunits.Angle firingAngleMax(
          final min=0,
          final max=Modelica.Constants.pi) = Modelica.Constants.pi
          "Maximum firing angle";
        parameter Boolean useFilter=true "Enable use of filter"
          annotation (Dialog(tab="Filter"));
        parameter Modelica.SIunits.Frequency fCut=2*f
          "Cut off frequency of filter"
          annotation (Dialog(tab="Filter", enable=useFilter));
        parameter Modelica.SIunits.Voltage vStart[m]=zeros(m)
          "Start voltage of filter output"
          annotation (Dialog(tab="Filter", enable=useFilter));
        Modelica.Blocks.Interfaces.RealInput firingAngle if not
          useConstantFiringAngle "Firing angle (rad)" annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-120})));
        Signal2mPulse twomPulse(
          final useConstantFiringAngle=useConstantFiringAngle,
          final f=f,
          final constantFiringAngle=constantFiringAngle,
          final firingAngleMax=firingAngleMax,
          final m=m,
          useFilter=useFilter,
          final fCut=fCut,
          final vStart=vStart) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={0,10})));
        Modelica.Electrical.Polyphase.Interfaces.PositivePlug ac(final m=m)
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Electrical.Polyphase.Basic.MultiDelta delta(final m=m)
          "Delta connection" annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-80,10})));
        Modelica.Electrical.Polyphase.Sensors.VoltageSensor voltageSensor(
            final m=m) "Voltage sensor" annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=270,
              origin={-44,10})));
        Modelica.Blocks.Interfaces.BooleanOutput fire_p[m] annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-60,110})));
        Modelica.Blocks.Interfaces.BooleanOutput fire_n[m] annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={60,110})));
      equation
        connect(ac, voltageSensor.plug_p) annotation (Line(
            points={{-100,0},{-44,0}}, color={0,0,255}));
        connect(voltageSensor.plug_p, delta.plug_n) annotation (Line(
            points={{-44,0},{-80,0}}, color={0,0,255}));
        connect(delta.plug_p, voltageSensor.plug_n) annotation (Line(
            points={{-80,20},{-44,20}}, color={0,0,255}));
        connect(voltageSensor.v, twomPulse.v) annotation (Line(
            points={{-33,10},{-12,10}}, color={0,0,127}));
        connect(firingAngle, twomPulse.firingAngle) annotation (Line(
            points={{0,-120},{0,-2}}, color={0,0,127}));
        connect(twomPulse.fire_n, fire_n) annotation (Line(
            points={{6,21},{6,80},{60,80},{60,110}}, color={255,0,255}));
        connect(twomPulse.fire_p, fire_p) annotation (Line(
            points={{-6,21},{-6,80},{-60,80},{-60,110}}, color={255,0,255}));
        annotation (defaultComponentName="adaptor",
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}),graphics={Line(
                      points={{-40,-20},{-40,-24},{-20,-24},{-20,-40},{-40,-40},
                  {-40,-60}},
                      color={255,0,255}),Line(
                      points={{20,-20},{20,-44},{40,-44},{40,-60},{20,-60},{20,
                  -60}},
                      color={255,0,255}),Text(
                      extent={{-40,60},{40,0}},
                      textColor={255,0,255},
                      textString="2*%m%")}),
          Documentation(info="<html>

<p>
General information about controllers is summarized in
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control\">Control</a>.
</p>

<p>
Half of the semiconductors of the <code>2*m</code> pulse bridge rectifier are connected with the positive DC output pin (firing signal <code>fire_p</code>). The other half of the semiconductors is connected with the negative DC output pin (firing signal <code>fire_n</code>). Parameter <code>m</code> indicates the number of phases.
</p>
</html>", revisions="<html>
</html>"));
      end VoltageBridge2mPulse;

      model VoltageCenterTap2mPulse "Control of 2*m pulse center tap rectifier"
        extends Icons.Control;
        import Modelica.Constants.pi;
        parameter Integer m(final min=3) = 3 "Number of phases";
        parameter Modelica.SIunits.Frequency f=50 "Frequency";
        parameter Boolean useConstantFiringAngle=true
          "Use constant firing angle instead of signal input";
        parameter Modelica.SIunits.Angle constantFiringAngle=0 "Firing angle"
          annotation (Dialog(enable=useConstantFiringAngle));
        parameter Modelica.SIunits.Angle firingAngleMax(
          final min=0,
          final max=Modelica.Constants.pi) = Modelica.Constants.pi
          "Maximum firing angle";
        parameter Boolean useFilter=true "Enable use of filter"
          annotation (Dialog(tab="Filter"));
        parameter Modelica.SIunits.Frequency fCut=2*f
          "Cut off frequency of filter"
          annotation (Dialog(tab="Filter", enable=useFilter));
        parameter Modelica.SIunits.Voltage vStart[m]=zeros(m)
          "Start voltage of filter output"
          annotation (Dialog(tab="Filter", enable=useFilter));
        Modelica.Blocks.Interfaces.RealInput firingAngle if not
          useConstantFiringAngle "Firing angle (rad)" annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-120})));
        Signal2mPulse twomPulse(
          final useConstantFiringAngle=useConstantFiringAngle,
          final f=f,
          final constantFiringAngle=constantFiringAngle,
          final firingAngleMax=firingAngleMax,
          final m=m,
          final useFilter=useFilter,
          final fCut=2*f,
          final vStart=vStart) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={10,0})));
        Modelica.Electrical.Polyphase.Interfaces.PositivePlug ac(final m=m)
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Blocks.Interfaces.BooleanOutput fire_p[m] annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-60,110})));
        Modelica.Blocks.Interfaces.BooleanOutput fire_n[m] annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={60,110})));
        Modelica.Electrical.Polyphase.Basic.MultiDelta delta(final m=m)
          "Delta connection" annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              origin={-80,0})));
        Modelica.Electrical.Polyphase.Sensors.PotentialSensor voltageSensor(
            final m=m) "Voltage sensor"
          annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
        Modelica.Blocks.Math.Gain gain[m](final k=fill(-1, m))
          annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
      equation
        connect(firingAngle, twomPulse.firingAngle) annotation (Line(
            points={{0,-120},{0,-80},{10,-80},{10,-12}}, color={0,0,127}));
        connect(voltageSensor.plug_p, delta.plug_p) annotation (Line(
            points={{-60,0},{-70,0}}, color={0,0,255}));
        connect(ac, delta.plug_n) annotation (Line(
            points={{-100,0},{-90,0}}, color={0,0,255}));
        connect(gain.y, twomPulse.v) annotation (Line(
            points={{-7,0},{-2,0}}, color={0,0,127}));
        connect(voltageSensor.phi, gain.u) annotation (Line(
            points={{-39,0},{-30,0}}, color={0,0,127}));
        connect(twomPulse.fire_n, fire_n) annotation (Line(
            points={{16,11},{16,80},{60,80},{60,110}}, color={255,0,255}));
        connect(twomPulse.fire_p, fire_p) annotation (Line(
            points={{4,11},{4,80},{-60,80},{-60,110}}, color={255,0,255}));
        annotation (defaultComponentName="adaptor",
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}),graphics={Line(
                      points={{-40,-20},{-40,-24},{-20,-24},{-20,-40},{-40,-40},
                  {-40,-60}},
                      color={255,0,255}),Line(
                      points={{20,-20},{20,-44},{40,-44},{40,-60},{20,-60},{20,
                  -60}},
                      color={255,0,255}),Text(
                      extent={{-40,60},{40,0}},
                      textColor={255,0,255},
                      textString="2*%m%")}),
          Documentation(revisions="<html>
</html>", info="<html>

<p>
General information about controllers is summarized in
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control\">Control</a>.
</p>
</html>"));
      end VoltageCenterTap2mPulse;

      block Filter "PT1 + all-pass filter"
        extends Modelica.Blocks.Interfaces.SISO;
        import Modelica.Constants.pi;
        parameter Modelica.SIunits.Frequency f=50 "Mains Frequency";
        parameter Modelica.SIunits.Frequency fCut=2*f "Cut off frequency";
        final parameter Integer na(final min=2) = 2
          "Count of 1st order all-pass";
        final parameter Modelica.SIunits.Frequency fa=f/tan(pi/na - atan(f/fCut)
            /(2*na)) "Characteristic frequency of all-pass filter";
        parameter Real yStart=0 "Start value of output";
        Modelica.Blocks.Continuous.FirstOrder firstOrder(
          final k=1,
          final T=1/(2*pi*fCut),
          initType=Modelica.Blocks.Types.Init.InitialOutput,
          y_start=yStart)
          annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
        Modelica.Blocks.Continuous.TransferFunction transferFunction[na](
          each final b={-1/(2*pi*fa),1},
          each final a={+1/(2*pi*fa),1},
          each initType=Modelica.Blocks.Types.Init.InitialOutput,
          each y_start=yStart)
          annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      equation
        for j in 1:na - 1 loop
          connect(transferFunction[j].y, transferFunction[j + 1].u);
        end for;
        connect(u, firstOrder.u) annotation (Line(
            points={{-120,0},{-62,0}}, color={0,0,127}));
        connect(firstOrder.y, transferFunction[1].u) annotation (Line(
            points={{-39,0},{38,0}}, color={0,0,127}));
        connect(transferFunction[na].y, y) annotation (Line(
            points={{61,0},{110,0}}, color={0,0,127}));
        annotation (
          Documentation(info="<html>
<p>First order filter with cut-off frequency <code>fCut</code>. The phase shift of the filter is compensated by a series of two first order all-pass filters tuned on supply frequency <code>f</code>.</p>
</html>"),Icon(graphics={Polygon(
                      lineColor={192,192,192},
                      fillColor={192,192,192},
                      fillPattern=FillPattern.Solid,
                      points={{-80,90},{-88,68},{-72,68},{-80,90}}),Line(
                      points={{-80,78},{-80,-90}},
                      color={192,192,192}),Polygon(
                      lineColor={192,192,192},
                      fillColor={192,192,192},
                      fillPattern=FillPattern.Solid,
                      points={{90,-80},{68,-72},{68,-88},{90,-80}}),Line(
                      points={{-90,-80},{82,-80}},
                      color={192,192,192}),Rectangle(
                      lineColor={160,160,164},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Backward,
                      extent={{-80,-80},{22,8}}),Line(
                      origin={3.333,-8.667},
                      points={{-83.333,34.667},{24.667,34.667},{42.667,-71.333}},
                      color={0,0,127},
                      smooth=Smooth.Bezier)}));
      end Filter;
      annotation (Documentation(info="<html>
<p>
A generic controller with signal input and <code>2*m</code> firing signals is provided in
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control.Signal2mPulse\">Signal2mPulse</a>,
where <code>m</code> is the arbitrary number of phases.
Additional topology specific controllers with electrical connectors are also included.
</p>

<h4>Filters</h4>

<p>
Each controller is equipped with an optional
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control.Filter\">filter</a>
to filter the input voltages. By default the filter is enabled.
</p>

<p>
Such filter is needed if the electrical grid includes a significant voltage drop across the grid impedance
distorting the input voltage wave form of the rectifier. The filter included in the PowerConverters library is first order filter with additional compensation of the filter specific phase lag.
However, it important to note that the transients of the filters may cause some initial effects which deteriorate after
certain periods.
</p>

<h4>Enable</h4>

<p>
The topology specific controllers allow enabling and disabling of the firing signals. The internal enabling signal of the controllers is either derived from the parameter <code>constantEnable</code>,
if <code>useConstantEnable = true</code>. For if <code>useConstantEnable = false</code> the internal
enabling signal is taken from the optional signal input <code>enable</code>.
</p>
</html>"));
    end Control;
    extends Modelica.Icons.Package;
    model DiodeBridge2Pulse "Two pulse Graetz diode rectifier bridge"
      extends Icons.Converter;
      import Modelica.Constants.pi;
      parameter Modelica.SIunits.Resistance RonDiode(final min=0) = 1e-05
        "Closed diode resistance";
      parameter Modelica.SIunits.Conductance GoffDiode(final min=0) = 1e-05
        "Opened diode conductance";
      parameter Modelica.SIunits.Voltage VkneeDiode(final min=0) = 0
        "Diode forward threshold voltage";
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.ACtwoPin;
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.DCtwoPin;
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
           293.15);
      Modelica.Electrical.Analog.Ideal.IdealDiode diode_p1(
        final Goff=GoffDiode,
        final Vknee=VkneeDiode,
        final useHeatPort=useHeatPort,
        final Ron=RonDiode)
        "Diode connecting the positive AC input pin with positive DC output"
        annotation (Placement(transformation(
            origin={10,50},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Electrical.Analog.Ideal.IdealDiode diode_p2(
        final Ron=RonDiode,
        final Goff=GoffDiode,
        final Vknee=VkneeDiode,
        final useHeatPort=useHeatPort)
        "Diode connecting the negative AC input pin with positive DC output"
        annotation (Placement(transformation(
            origin={40,50},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Electrical.Analog.Ideal.IdealDiode diode_n1(
        final Ron=RonDiode,
        final Goff=GoffDiode,
        final Vknee=VkneeDiode,
        final useHeatPort=useHeatPort)
        "Diode connecting the positive AC input pin with negative DC output"
        annotation (Placement(transformation(
            origin={10,-50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Electrical.Analog.Ideal.IdealDiode diode_n2(
        final Ron=RonDiode,
        final Goff=GoffDiode,
        final Vknee=VkneeDiode,
        final useHeatPort=useHeatPort)
        "Diode connecting the negative AC input pin with negative DC output"
        annotation (Placement(transformation(
            origin={40,-50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
    equation
      if not useHeatPort then
        LossPower = diode_p1.LossPower + diode_p2.LossPower + diode_n1.LossPower
           + diode_n2.LossPower;
      end if;
      connect(diode_p2.n, diode_p1.n) annotation (Line(
          points={{40,60},{10,60}}, color={0,0,255}));
      connect(diode_n1.p, diode_n2.p) annotation (Line(
          points={{10,-60},{40,-60}}, color={0,0,255}));
      connect(diode_n2.n, diode_p2.p) annotation (Line(
          points={{40,-40},{40,40}}, color={0,0,255}));
      connect(diode_p1.p, diode_n1.n) annotation (Line(
          points={{10,40},{10,-40}}, color={0,0,255}));
      connect(diode_p1.n, dc_p) annotation (Line(
          points={{10,60},{100,60}}, color={0,0,255}));
      connect(diode_n1.p, dc_n) annotation (Line(
          points={{10,-60},{100,-60}}, color={0,0,255}));
      connect(diode_n1.heatPort, heatPort) annotation (Line(
          points={{20,-50},{20,-100},{0,-100}}, color={191,0,0}));
      connect(diode_n2.heatPort, heatPort) annotation (Line(
          points={{50,-50},{50,-100},{0,-100}}, color={191,0,0}));
      connect(diode_p1.heatPort, heatPort) annotation (Line(
          points={{0,50},{-50,50},{-50,-100},{0,-100}}, color={191,0,0}));
      connect(diode_p2.heatPort, heatPort) annotation (Line(
          points={{30,50},{30,30},{-50,30},{-50,-100},{0,-100}}, color={191,0,0}));
      connect(ac_p, diode_p1.p) annotation (Line(
          points={{-100,60},{-60,60},{-60,20},{10,20},{10,40}}, color={0,0,255}));
      connect(ac_n, diode_p2.p) annotation (Line(
          points={{-100,-60},{-60,-60},{-60,-20},{40,-20},{40,40}}, color={0,0,255}));
      annotation (defaultComponentName="rectifier",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-100,70},{0,50}},
              textColor={0,0,127},
              textString="AC"),
            Text(
              extent={{0,-50},{100,-70}},
              textColor={0,0,127},
              textString="DC"),
            Rectangle(
              extent={{-40,24},{40,-24}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-40,0},{40,0}},
              color={0,0,255}),
            Line(
              points={{20,24},{20,-24}},
              color={0,0,255}),
            Line(
              points={{20,0},{-20,24},{-20,-24},{20,0}},
              color={0,0,255})}),
        Documentation(info="<html>
<p>
General information about AC/DC converters can be found at the
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">AC/DC converter concept</a>
</p>

<p>
This is a two pulse Graetz diode rectifier bridge. The circuit topology is the same as in
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2Pulse\">Examples.ACDC.RectifierCenterTap2Pulse</a>.
</p>
</html>"));
    end DiodeBridge2Pulse;

    model ThyristorBridge2Pulse "Two pulse Graetz thyristor rectifier bridge"
      extends Icons.Converter;
      import Modelica.Constants.pi;
      parameter Modelica.SIunits.Resistance RonThyristor(final min=0) = 1e-05
        "Closed thyristor resistance";
      parameter Modelica.SIunits.Conductance GoffThyristor(final min=0) = 1e-05
        "Opened thyristor conductance";
      parameter Modelica.SIunits.Voltage VkneeThyristor(final min=0) = 0
        "Thyristor forward threshold voltage";
      parameter Boolean offStart_p1=true
        "Boolean start value of variable thyristor_p1.off"
        annotation (choices(checkBox=true));
      parameter Boolean offStart_p2=true
        "Boolean start value of variable thyristor_p2.off"
        annotation (choices(checkBox=true));
      parameter Boolean offStart_n1=true
        "Boolean start value of variable thyristor_n1.off"
        annotation (choices(checkBox=true));
      parameter Boolean offStart_n2=true
        "Boolean start value of variable thyristor_n2.off"
        annotation (choices(checkBox=true));
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.ACtwoPin;
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.DCtwoPin;
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
           293.15);
      extends Interfaces.Enable.Enable2;
      Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor_p1(
        final Ron=RonThyristor,
        final Goff=GoffThyristor,
        final Vknee=VkneeThyristor,
        final useHeatPort=useHeatPort,
        final off(start=offStart_p1, fixed=true))
        "Thyristor connecting the positive AC input pin with positive DC output"
        annotation (Placement(transformation(
            origin={-20,50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor_p2(
        final Ron=RonThyristor,
        final Goff=GoffThyristor,
        final Vknee=VkneeThyristor,
        final useHeatPort=useHeatPort,
        final off(start=offStart_p2, fixed=true))
        "Thyristor connecting the negative AC input pin with positive DC output"
        annotation (Placement(transformation(
            origin={20,50},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor_n1(
        final Ron=RonThyristor,
        final Goff=GoffThyristor,
        final Vknee=VkneeThyristor,
        final useHeatPort=useHeatPort,
        final off(start=offStart_n1, fixed=true))
        "Thyristor connecting the positive AC input with negative DC output"
        annotation (Placement(transformation(
            origin={-20,-50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor_n2(
        final Ron=RonThyristor,
        final Goff=GoffThyristor,
        final Vknee=VkneeThyristor,
        final useHeatPort=useHeatPort,
        final off(start=offStart_n2, fixed=true))
        "Thyristor connecting the negative AC input with negative DC output"
        annotation (Placement(transformation(
            origin={20,-50},
            extent={{-10,10},{10,-10}},
            rotation=90)));
    equation
      if not useHeatPort then
        LossPower = thyristor_p1.LossPower + thyristor_p2.LossPower +
          thyristor_n1.LossPower + thyristor_n2.LossPower;
      end if;
      connect(thyristor_p2.n, thyristor_p1.n) annotation (Line(
          points={{20,60},{-20,60}}, color={0,0,255}));
      connect(thyristor_n1.p, thyristor_n2.p) annotation (Line(
          points={{-20,-60},{20,-60}}, color={0,0,255}));
      connect(thyristor_n2.n, thyristor_p2.p) annotation (Line(
          points={{20,-40},{20,40}}, color={0,0,255}));
      connect(thyristor_p1.p, thyristor_n1.n) annotation (Line(
          points={{-20,40},{-20,-40}}, color={0,0,255}));
      connect(thyristor_p1.n, dc_p) annotation (Line(
          points={{-20,60},{100,60}}, color={0,0,255}));
      connect(thyristor_n1.p, dc_n) annotation (Line(
          points={{-20,-60},{100,-60}}, color={0,0,255}));
      connect(thyristor_n1.heatPort, heatPort) annotation (Line(
          points={{-10,-50},{0,-50},{0,-100}}, color={191,0,0}));
      connect(thyristor_n2.heatPort, heatPort) annotation (Line(
          points={{10,-50},{0,-50},{0,-100}}, color={191,0,0}));
      connect(thyristor_p1.heatPort, heatPort) annotation (Line(
          points={{-10,50},{0,50},{0,-100}}, color={191,0,0}));
      connect(thyristor_p2.heatPort, heatPort) annotation (Line(
          points={{10,50},{0,50},{0,-100}}, color={191,0,0}));
      connect(ac_p, thyristor_p1.p) annotation (Line(
          points={{-100,60},{-100,20},{-20,20},{-20,40}}, color={0,0,255}));
      connect(ac_n, thyristor_n2.n) annotation (Line(
          points={{-100,-60},{-100,-20},{20,-20},{20,-40}}, color={0,0,255}));
      connect(andCondition_p.y, thyristor_p1.fire) annotation (Line(
          points={{-60,-69},{-60,60},{-32,60}}, color={255,0,255}));
      connect(andCondition_p.y, thyristor_n2.fire) annotation (Line(
          points={{-60,-69},{-60,-30},{40,-30},{40,-40},{32,-40}}, color={255,0,255}));
      connect(andCondition_n.y, thyristor_p2.fire) annotation (Line(
          points={{60,-69},{60,60},{32,60}}, color={255,0,255}));
      connect(andCondition_n.y, thyristor_n1.fire) annotation (Line(
          points={{60,-69},{60,-66},{-40,-66},{-40,-40},{-32,-40}}, color={255,0,255}));
      annotation (defaultComponentName="rectifier",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-100,70},{0,50}},
              textColor={0,0,127},
              textString="AC"),
            Text(
              extent={{0,-50},{100,-70}},
              textColor={0,0,127},
              textString="DC"),
            Rectangle(
              extent={{-40,24},{40,-24}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-40,0},{40,0}},
              color={0,0,255}),
            Line(
              points={{20,24},{20,-24}},
              color={0,0,255}),
            Line(
              points={{20,0},{-20,24},{-20,-24},{20,0}},
              color={0,0,255}),
            Line(
              points={{0,12},{0,28}},
              color={0,0,255})}),
        Documentation(info="<html>
<p>
General information about AC/DC converters can be found at the
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">AC/DC converter concept</a>
</p>

<p>
This is a two pulse Graetz thyristor rectifier bridge. The firing signal <code>fire_p</code> are connected
with thyristor <code>thyristor_p1</code> and <code>thyristor_n2</code>.
The firing signal <code>fire_n</code> are connected
with thyristor <code>thyristor_p2</code> and <code>thyristor_n1</code>. See example
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2Pulse\">Examples.ACDC.RectifierCenterTap2Pulse</a>.
</p>
</html>"));
    end ThyristorBridge2Pulse;

    model HalfControlledBridge2Pulse
      "Two pulse Graetz half controlled rectifier bridge"
      import Modelica.Constants.pi;
      extends Icons.Converter;
      parameter Modelica.SIunits.Resistance RonDiode(final min=0) = 1e-05
        "Closed diode resistance";
      parameter Modelica.SIunits.Conductance GoffDiode(final min=0) = 1e-05
        "Opened diode conductance";
      parameter Modelica.SIunits.Voltage VkneeDiode(final min=0) = 0
        "Diode forward threshold voltage";
      parameter Modelica.SIunits.Resistance RonThyristor(final min=0) = 1e-05
        "Closed thyristor resistance";
      parameter Modelica.SIunits.Conductance GoffThyristor(final min=0) = 1e-05
        "Opened thyristor conductance";
      parameter Modelica.SIunits.Voltage VkneeThyristor(final min=0) = 0
        "Thyristor forward threshold voltage";
      parameter Boolean offStart_p1=true
        "Boolean start value of variable thyristor_p1.off"
        annotation (choices(checkBox=true));
      parameter Boolean offStart_p2=true
        "Boolean start value of variable thyristor_p2.off"
        annotation (choices(checkBox=true));
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.ACtwoPin;
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.DCtwoPin;
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
           293.15);
      extends Interfaces.Enable.Enable2;
      Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor_p1(
        final Ron=RonThyristor,
        final Goff=GoffThyristor,
        final Vknee=VkneeThyristor,
        final useHeatPort=useHeatPort,
        final off(start=offStart_p1, fixed=true)) annotation (Placement(transformation(
            origin={-20,50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor_p2(
        final Ron=RonThyristor,
        final Goff=GoffThyristor,
        final Vknee=VkneeThyristor,
        final useHeatPort=useHeatPort,
        final off(start=offStart_p2, fixed=true)) annotation (Placement(transformation(
            origin={20,50},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Electrical.Analog.Ideal.IdealDiode diode_n1(
        final Ron=RonDiode,
        final Goff=GoffDiode,
        final Vknee=VkneeDiode,
        final useHeatPort=useHeatPort)
        "Diode connected to negative DC potential" annotation (Placement(
            transformation(
            origin={-20,-50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Electrical.Analog.Ideal.IdealDiode diode_n2(
        final Ron=RonDiode,
        final Goff=GoffDiode,
        final Vknee=VkneeDiode,
        final useHeatPort=useHeatPort)
        "Diode connected to negative DC potential" annotation (Placement(
            transformation(
            origin={20,-50},
            extent={{-10,10},{10,-10}},
            rotation=90)));
    equation
      if not useHeatPort then
        LossPower = thyristor_p1.LossPower + thyristor_p2.LossPower + diode_n1.LossPower
           + diode_n2.LossPower;
      end if;
      connect(thyristor_p2.n, thyristor_p1.n) annotation (Line(
          points={{20,60},{-20,60}}, color={0,0,255}));
      connect(diode_n1.p, diode_n2.p) annotation (Line(
          points={{-20,-60},{20,-60}}, color={0,0,255}));
      connect(diode_n2.n, thyristor_p2.p) annotation (Line(
          points={{20,-40},{20,40}}, color={0,0,255}));
      connect(thyristor_p1.p, diode_n1.n) annotation (Line(
          points={{-20,40},{-20,-40}}, color={0,0,255}));
      connect(thyristor_p1.n, dc_p) annotation (Line(
          points={{-20,60},{100,60}}, color={0,0,255}));
      connect(diode_n1.p, dc_n) annotation (Line(
          points={{-20,-60},{100,-60}}, color={0,0,255}));
      connect(diode_n1.heatPort, heatPort) annotation (Line(
          points={{-10,-50},{0,-50},{0,-100}}, color={191,0,0}));
      connect(diode_n2.heatPort, heatPort) annotation (Line(
          points={{10,-50},{0,-50},{0,-100}}, color={191,0,0}));
      connect(thyristor_p1.heatPort, heatPort) annotation (Line(
          points={{-10,50},{0,50},{0,-100}}, color={191,0,0}));
      connect(thyristor_p2.heatPort, heatPort) annotation (Line(
          points={{10,50},{0,50},{0,-100}}, color={191,0,0}));
      connect(ac_p, thyristor_p1.p) annotation (Line(
          points={{-100,60},{-100,20},{-20,20},{-20,40}}, color={0,0,255}));
      connect(ac_n, diode_n2.n) annotation (Line(
          points={{-100,-60},{-100,-20},{20,-20},{20,-40}}, color={0,0,255}));
      connect(andCondition_p.y, thyristor_p1.fire) annotation (Line(
          points={{-60,-69},{-60,60},{-32,60}}, color={255,0,255}));
      connect(andCondition_n.y, thyristor_p2.fire) annotation (Line(
          points={{60,-69},{60,60},{32,60}}, color={255,0,255}));
      annotation (defaultComponentName="rectifier",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-100,70},{0,50}},
              textColor={0,0,127},
              textString="AC"),
            Text(
              extent={{0,-50},{100,-70}},
              textColor={0,0,127},
              textString="DC"),
            Rectangle(
              extent={{-44,50},{36,2}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-44,26},{36,26}},
              color={0,0,255}),
            Line(
              points={{16,50},{16,2}},
              color={0,0,255}),
            Line(
              points={{16,26},{-24,50},{-24,2},{16,26}},
              color={0,0,255}),
            Rectangle(
              extent={{-44,2},{36,-54}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-44,-30},{36,-30}},
              color={0,0,255}),
            Line(
              points={{16,-6},{16,-54}},
              color={0,0,255}),
            Line(
              points={{16,-30},{-24,-6},{-24,-54},{16,-30}},
              color={0,0,255}),
            Line(
              points={{-4,-18},{-4,-2}},
              color={0,0,255})}),
        Documentation(info="<html>
<p>
General information about AC/DC converters can be found at the
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">AC/DC converter concept</a>
</p>

<p>
This is a two pulse Graetz half controlled rectifier bridge. The firing signal <code>fire_p</code> is connected
with thyristor <code>thyristor_p1</code>.
The firing signal <code>fire_n</code> is connected
with thyristor <code>thyristor_p2</code>.
The circuit topology is the same as in
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2Pulse\">Examples.ACDC.RectifierCenterTap2Pulse</a>.
</p>
</html>"));
    end HalfControlledBridge2Pulse;

    model DiodeCenterTap2Pulse "Two pulse diode rectifier with center tap"
      extends Icons.Converter;
      import Modelica.Constants.pi;
      parameter Modelica.SIunits.Resistance RonDiode(final min=0) = 1e-05
        "Closed diode resistance";
      parameter Modelica.SIunits.Conductance GoffDiode(final min=0) = 1e-05
        "Opened diode conductance";
      parameter Modelica.SIunits.Voltage VkneeDiode(final min=0) = 0
        "Diode forward threshold voltage";
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.ACtwoPin;
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.DCpin;
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
           293.15);
      Modelica.Electrical.Analog.Ideal.IdealDiode diode_p(
        final Ron=RonDiode,
        final Goff=GoffDiode,
        final Vknee=VkneeDiode,
        final useHeatPort=useHeatPort)
        "Diodes conducting positive pin AC potentials" annotation (Placement(
            transformation(
            origin={0,60},
            extent={{-10,-10},{10,10}})));
      Modelica.Electrical.Analog.Ideal.IdealDiode diode_n(
        final Ron=RonDiode,
        final Goff=GoffDiode,
        final Vknee=VkneeDiode,
        final useHeatPort=useHeatPort)
        "Diodes conducting negative pin AC potentials" annotation (Placement(
            transformation(
            origin={0,-60},
            extent={{-10,-10},{10,10}})));
    equation
      if not useHeatPort then
        LossPower = diode_p.LossPower + diode_n.LossPower;
      end if;
      connect(ac_p, diode_p.p) annotation (Line(
          points={{-100,60},{-10,60}}, color={0,0,255}));
      connect(ac_n, diode_n.p) annotation (Line(
          points={{-100,-60},{-10,-60}}, color={0,0,255}));
      connect(diode_p.n, dc_p) annotation (Line(
          points={{10,60},{100,60},{100,0}}, color={0,0,255}));
      connect(diode_n.n, dc_p) annotation (Line(
          points={{10,-60},{100,-60},{100,0}}, color={0,0,255}));
      connect(diode_n.heatPort, heatPort) annotation (Line(
          points={{0,-70},{0,-100}}, color={191,0,0}));
      connect(diode_p.heatPort, heatPort) annotation (Line(
          points={{0,50},{0,40},{20,40},{20,-100},{
              0,-100}}, color={191,0,0}));
      annotation (defaultComponentName="rectifier",
        Icon(coordinateSystem(
            extent={{-100,-100},{100,100}},
            preserveAspectRatio=true,
            grid={2,2}), graphics={
            Text(
              extent={{-100,70},{0,50}},
              textColor={0,0,127},
              textString="AC"),
            Text(
              extent={{0,-50},{100,-70}},
              textColor={0,0,127},
              textString="DC"),
            Rectangle(
              extent={{-40,24},{40,-24}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-40,0},{40,0}},
              color={0,0,255}),
            Line(
              points={{20,24},{20,-24}},
              color={0,0,255}),
            Line(
              points={{20,0},{-20,24},{-20,-24},{20,0}},
              color={0,0,255})}),
        Documentation(info="<html>
<p>
General information about AC/DC converters can be found at the
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">AC/DC converter concept</a>
</p>

<p>
This is a two pulse diode rectifier with center tap. In order to operate this rectifier a voltage with center tap is required. The center tap has to be connected with the negative pin of the load. The circuit topology is the same as in
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2Pulse\">Examples.ACDC.RectifierCenterTap2Pulse</a>.
</p>
</html>"));
    end DiodeCenterTap2Pulse;

    model ThyristorCenterTap2Pulse
      "Two pulse thyristor rectifier with center tap"
      extends Icons.Converter;
      import Modelica.Constants.pi;
      parameter Modelica.SIunits.Resistance RonThyristor(final min=0) = 1e-05
        "Closed thyristor resistance";
      parameter Modelica.SIunits.Conductance GoffThyristor(final min=0) = 1e-05
        "Opened thyristor conductance";
      parameter Modelica.SIunits.Voltage VkneeThyristor(final min=0) = 0
        "Thyristor forward threshold voltage";
      parameter Boolean offStart_p=true
        "Boolean start value of variable thyristor_p.off"
        annotation (choices(checkBox=true));
      parameter Boolean offStart_n=true
        "Boolean start value of variable thyristor_n.off"
        annotation (choices(checkBox=true));
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.ACtwoPin;
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.DCpin;
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
           293.15);
      extends Interfaces.Enable.Enable2;
      Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor_p(
        final Ron=RonThyristor,
        final Goff=GoffThyristor,
        final Vknee=VkneeThyristor,
        final useHeatPort=useHeatPort,
        final off(start=offStart_p, fixed=true))
        "Thyristors conducting positive pin AC potentials" annotation (
          Placement(transformation(
            origin={0,60},
            extent={{-10,-10},{10,10}})));
      Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor_n(
        final Ron=RonThyristor,
        final Goff=GoffThyristor,
        final Vknee=VkneeThyristor,
        final useHeatPort=useHeatPort,
        final off(start=offStart_n, fixed=true))
        "Thyristors conducting negative pin AC potentials" annotation (
          Placement(transformation(
            origin={0,-60},
            extent={{-10,-10},{10,10}})));
    equation
      if not useHeatPort then
        LossPower = thyristor_p.LossPower + thyristor_n.LossPower;
      end if;
      connect(ac_p, thyristor_p.p) annotation (Line(
          points={{-100,60},{-10,60}}, color={0,0,255}));
      connect(ac_n, thyristor_n.p) annotation (Line(
          points={{-100,-60},{-10,-60}}, color={0,0,255}));
      connect(thyristor_p.n, dc_p) annotation (Line(
          points={{10,60},{100,60},{100,0}}, color={0,0,255}));
      connect(thyristor_n.n, dc_p) annotation (Line(
          points={{10,-60},{100,-60},{100,0}}, color={0,0,255}));
      connect(thyristor_n.heatPort, heatPort) annotation (Line(
          points={{0,-70},{0,-100}}, color={191,0,0}));
      connect(thyristor_p.heatPort, heatPort) annotation (Line(
          points={{0,50},{0,40},{20,40},{20,-100},{
              0,-100}}, color={191,0,0}));
      connect(andCondition_p.y, thyristor_p.fire) annotation (Line(
          points={{-60,-69},{-60,80},{10,80},{10,72}},
                                                     color={255,0,255}));
      connect(andCondition_n.y, thyristor_n.fire) annotation (Line(
          points={{60,-69},{60,-40},{10,-40},{10,-48}},
                                                      color={255,0,255}));
      annotation (defaultComponentName="rectifier",
        Icon(coordinateSystem(
            extent={{-100,-100},{100,100}},
            preserveAspectRatio=true,
            grid={2,2}), graphics={
            Text(
              extent={{-100,70},{0,50}},
              textColor={0,0,127},
              textString="AC"),
            Text(
              extent={{0,-50},{100,-70}},
              textColor={0,0,127},
              textString="DC"),
            Rectangle(
              extent={{-40,24},{40,-24}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-40,0},{40,0}},
              color={0,0,255}),
            Line(
              points={{20,24},{20,-24}},
              color={0,0,255}),
            Line(
              points={{20,0},{-20,24},{-20,-24},{20,0}},
              color={0,0,255}),
            Line(
              points={{0,12},{0,28}},
              color={0,0,255})}),
        Documentation(info="<html>
<p>
General information about AC/DC converters can be found at the
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">AC/DC converter concept</a>
</p>

<p>This a two pulse thyristor rectifier with center tap. In order to operate this rectifier a voltage with center tap is required. The center tap has to be connected with the negative pin of the load. The circuit topology is the same as in
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2Pulse\">Examples.ACDC.RectifierCenterTap2Pulse</a>.
</p>
</html>"));
    end ThyristorCenterTap2Pulse;

    model DiodeCenterTapmPulse "m pulse diode rectifier with center tap"
      import Modelica.Constants.pi;
      extends Icons.Converter;
      parameter Integer m(final min=3) = 3 "Number of phases";
      parameter Modelica.SIunits.Resistance RonDiode(final min=0) = 1e-05
        "Closed diode resistance";
      parameter Modelica.SIunits.Conductance GoffDiode(final min=0) = 1e-05
        "Opened diode conductance";
      parameter Modelica.SIunits.Voltage VkneeDiode(final min=0) = 0
        "Diode forward threshold voltage";
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.ACplug;
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.DCpin;
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
           293.15);
      Modelica.Electrical.Polyphase.Ideal.IdealDiode diode(
        final m=m,
        final Ron=fill(RonDiode, m),
        final Goff=fill(GoffDiode, m),
        final Vknee=fill(VkneeDiode, m),
        each final useHeatPort=useHeatPort)
        "Diodes connected to positive DC potential" annotation (Placement(
            transformation(
            origin={-10,0},
            extent={{10,10},{-10,-10}},
            rotation=180)));
      Modelica.Electrical.Polyphase.Basic.Star star(final m=m)
        annotation (Placement(transformation(extent={{70,10},{90,-10}})));
      Modelica.Thermal.HeatTransfer.Components.ThermalCollector
        thermalCollector(final m=m) if useHeatPort
        annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
    equation
      assert(mod(m, 2) == 1,
        "DiodeCenterTapmPulse: only odd phase numbers are allowed");
      if not useHeatPort then
        LossPower = sum(diode.idealDiode.LossPower);
      end if;
      connect(diode.plug_n, star.plug_p) annotation (Line(
          points={{0,0},{70,0}}, color={0,0,255}));
      connect(star.pin_n, dc_p) annotation (Line(
          points={{90,0},{100,0}}, color={0,0,255}));
      connect(heatPort, thermalCollector.port_b) annotation (Line(
          points={{0,-100},{30,-100}}, color={191,0,0}));
      connect(diode.heatPort, thermalCollector.port_a) annotation (Line(
          points={{-10,-10},{-10,-20},{30,-20},{30,-80}}, color={191,0,0}));
      connect(ac, diode.plug_p) annotation (Line(
          points={{-100,0},{-20,0}}, color={0,0,255}));
      annotation (defaultComponentName="rectifier",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-100,70},{0,50}},
              textColor={0,0,127},
              textString="AC"),
            Text(
              extent={{0,-50},{100,-70}},
              textColor={0,0,127},
              textString="DC"),
            Rectangle(
              extent={{-40,24},{40,-24}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-40,0},{40,0}},
              color={0,0,255}),
            Line(
              points={{20,24},{20,-24}},
              color={0,0,255}),
            Line(
              points={{20,0},{-20,24},{-20,-24},{20,0}},
              color={0,0,255})}),
        Documentation(info="<html>
<p>
General information about AC/DC converters can be found at the
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">AC/DC converter concept</a>.
</p>

<p>
This is a m pulse diode rectifier with center tap. All voltage sources must have one interconnected plug (tap). This rectifiers works only with odd number of phases due the symmetry constrains of even phase numbers implemented in
<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">symmetricOrientation</a>.
The circuit topology is the same as in
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTapmPulse\">Examples.ACDC.RectifierCenterTapmPulse</a>.
</p>
</html>"));
    end DiodeCenterTapmPulse;

    model ThyristorCenterTapmPulse
      "m pulse thyristor rectifier with center tap"
      extends Icons.Converter;
      import Modelica.Constants.pi;
      // parameter Integer m(final min=3) = 3 "Number of phases";
      parameter Modelica.SIunits.Resistance RonThyristor(final min=0) = 1e-05
        "Closed thyristor resistance";
      parameter Modelica.SIunits.Conductance GoffThyristor(final min=0) = 1e-05
        "Opened thyristor conductance";
      parameter Modelica.SIunits.Voltage VkneeThyristor(final min=0) = 0
        "Thyristor forward threshold voltage";
      parameter Boolean offStart[m]=fill(true, m)
        "Boolean start value of variable thyristor_p[:].off"
        annotation (choices(checkBox=true));
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.ACplug;
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.DCpin;
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
           293.15);
      extends Interfaces.Enable.Enable1m;
      Modelica.Electrical.Polyphase.Ideal.IdealThyristor thyristor(
        final m=m,
        final Ron=fill(RonThyristor, m),
        final Goff=fill(GoffThyristor, m),
        final Vknee=fill(VkneeThyristor, m),
        each final useHeatPort=useHeatPort,
        final idealThyristor(off(start=offStart, fixed=fill(true, m))))
        "Thyristors conducting AC potentials" annotation (Placement(transformation(
            origin={-10,0},
            extent={{10,10},{-10,-10}},
            rotation=180)));
      Modelica.Electrical.Polyphase.Basic.Star star(final m=m)
        annotation (Placement(transformation(extent={{70,10},{90,-10}})));
      Modelica.Thermal.HeatTransfer.Components.ThermalCollector
        thermalCollector(final m=m) if useHeatPort
        annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
    equation
      assert(mod(m, 2) == 1,
        "ThyristorCenterTapmPulse: only odd phase numbers are allowed");
      if not useHeatPort then
        LossPower = sum(thyristor.idealThyristor.LossPower);
      end if;
      connect(thyristor.plug_n, star.plug_p) annotation (Line(
          points={{0,0},{70,0}}, color={0,0,255}));
      connect(star.pin_n, dc_p) annotation (Line(
          points={{90,0},{100,0}}, color={0,0,255}));
      connect(heatPort, thermalCollector.port_b) annotation (Line(
          points={{0,-100},{30,-100}}, color={191,0,0}));
      connect(thyristor.heatPort, thermalCollector.port_a) annotation (Line(
          points={{-10,-10},{-10,-20},{30,-20},{30,-80}}, color={191,0,0}));
      connect(ac, thyristor.plug_p) annotation (Line(
          points={{-100,0},{-20,0}}, color={0,0,255}));
      connect(andCondition_p.y, thyristor.fire) annotation (Line(
          points={{-60,-69},{-60,20},{1.77636e-15,20},{1.77636e-15,11.8}},
                                                       color={255,0,255}));
      annotation (defaultComponentName="rectifier",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-100,70},{0,50}},
              textColor={0,0,127},
              textString="AC"),
            Text(
              extent={{0,-50},{100,-70}},
              textColor={0,0,127},
              textString="DC"),
            Rectangle(
              extent={{-40,24},{40,-24}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-40,0},{40,0}},
              color={0,0,255}),
            Line(
              points={{20,24},{20,-24}},
              color={0,0,255}),
            Line(
              points={{20,0},{-20,24},{-20,-24},{20,0}},
              color={0,0,255}),
            Line(
              points={{0,12},{0,28}},
              color={0,0,255})}),
        Documentation(info="<html>
<p>
General information about AC/DC converters can be found at the
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">AC/DC converter concept</a>
</p>

<p>
This is a m pulse thyristor rectifier with center tap. All voltage sources must have one interconnected plug (tap). This rectifiers works only with odd number of phases due the symmetry constrains of even phase numbers implemented in
<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">symmetricOrientation</a>.
See example
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTapmPulse\">Examples.ACDC.RectifierCenterTapmPulse</a>.
</p>
</html>"));
    end ThyristorCenterTapmPulse;

    model DiodeBridge2mPulse "2*m pulse diode rectifier bridge"
      extends Icons.Converter;
      import Modelica.Constants.pi;
      parameter Integer m(final min=3) = 3 "Number of phases";
      parameter Modelica.SIunits.Resistance RonDiode(final min=0) = 1e-05
        "Closed diode resistance";
      parameter Modelica.SIunits.Conductance GoffDiode(final min=0) = 1e-05
        "Opened diode conductance";
      parameter Modelica.SIunits.Voltage VkneeDiode(final min=0) = 0
        "Diode forward threshold voltage";
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.ACplug;
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.DCtwoPin;
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
           293.15);
      Modelica.Electrical.Polyphase.Ideal.IdealDiode diode_p(
        final m=m,
        final Ron=fill(RonDiode, m),
        final Goff=fill(GoffDiode, m),
        final Vknee=fill(VkneeDiode, m),
        each final useHeatPort=useHeatPort)
        "Diodes connected to positive DC potential" annotation (Placement(
            transformation(
            origin={0,40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Electrical.Polyphase.Ideal.IdealDiode diode_n(
        final m=m,
        final Ron=fill(RonDiode, m),
        final Goff=fill(GoffDiode, m),
        final Vknee=fill(VkneeDiode, m),
        each final useHeatPort=useHeatPort)
        "Diodes connected to negative DC potential" annotation (Placement(
            transformation(
            origin={0,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Electrical.Polyphase.Basic.Star star_p(final m=m)
        annotation (Placement(transformation(extent={{70,70},{90,50}})));
      Modelica.Electrical.Polyphase.Basic.Star star_n(final m=m)
        annotation (Placement(transformation(extent={{70,-50},{90,-70}})));
      Modelica.Thermal.HeatTransfer.Components.ThermalCollector
        thermalCollector(final m=m) if useHeatPort
        annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
    equation
      if not useHeatPort then
        LossPower = sum(diode_p.idealDiode.LossPower) + sum(diode_n.idealDiode.LossPower);
      end if;
      connect(ac, diode_p.plug_p) annotation (Line(
          points={{-100,0},{-100,0},{0,0},{0,30}}, color={0,0,255}));
      connect(diode_p.plug_p, diode_n.plug_n) annotation (Line(
          points={{0,30},{0,-30}}, color={0,0,255}));
      connect(diode_p.plug_n, star_p.plug_p) annotation (Line(
          points={{0,50},{0,60},{70,60}}, color={0,0,255}));
      connect(star_p.pin_n, dc_p) annotation (Line(
          points={{90,60},{100,60}}, color={0,0,255}));
      connect(diode_n.plug_p, star_n.plug_p) annotation (Line(
          points={{0,-50},{0,-60},{70,-60}}, color={0,0,255}));
      connect(star_n.pin_n, dc_n) annotation (Line(
          points={{90,-60},{100,-60}}, color={0,0,255}));
      connect(thermalCollector.port_a, diode_n.heatPort) annotation (Line(
          points={{20,-80},{20,-40},{10,-40}}, color={191,0,0}));
      connect(thermalCollector.port_b, heatPort) annotation (Line(
          points={{20,-100},{0,-100}}, color={191,0,0}));
      connect(diode_p.heatPort, thermalCollector.port_a) annotation (Line(
          points={{10,40},{20,40},{20,-80}}, color={191,0,0}));
      annotation (defaultComponentName="rectifier",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-100,70},{0,50}},
              textColor={0,0,127},
              textString="AC"),
            Text(
              extent={{0,-50},{100,-70}},
              textColor={0,0,127},
              textString="DC"),
            Rectangle(
              extent={{-40,24},{40,-24}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-40,0},{40,0}},
              color={0,0,255}),
            Line(
              points={{20,24},{20,-24}},
              color={0,0,255}),
            Line(
              points={{20,0},{-20,24},{-20,-24},{20,0}},
              color={0,0,255})}),
        Documentation(info="<html>
<p>
General information about AC/DC converters can be found at the
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">AC/DC converter concept</a>
</p>

<p>
This is a 2*m pulse diode rectifier bridge. In order to operate this rectifier a voltage source with center tap is required. The circuit topology is the same as in
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse\">Examples.ACDC.RectifierBridge2mPulse</a>. It is important to note that for polyphase circuits with even phase numbers greater than three the
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MultiStarResistance\">MultiStarResistance</a> shall be used for grounding the voltage sources.
</p>
</html>"));
    end DiodeBridge2mPulse;

    model ThyristorBridge2mPulse "2*m pulse thyristor rectifier bridge"
      extends Icons.Converter;
      import Modelica.Constants.pi;
      // parameter Integer m(final min=3) = 3 "Number of phases";
      parameter Modelica.SIunits.Resistance RonThyristor(final min=0) = 1e-05
        "Closed thyristor resistance";
      parameter Modelica.SIunits.Conductance GoffThyristor(final min=0) = 1e-05
        "Opened thyristor conductance";
      parameter Modelica.SIunits.Voltage VkneeThyristor(final min=0) = 0
        "Thyristor forward threshold voltage";
      parameter Boolean offStart_p[m]=fill(true, m)
        "Boolean start value of variable thyristor_p[:].off"
        annotation (choices(checkBox=true));
      parameter Boolean offStart_n[m]=fill(true, m)
        "Boolean start value of variable thyristor_n[:].off"
        annotation (choices(checkBox=true));
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.ACplug;
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.DCtwoPin;
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
      extends Interfaces.Enable.Enable2m;
      Modelica.Electrical.Polyphase.Ideal.IdealThyristor thyristor_p(
        final m=m,
        final Ron=fill(RonThyristor, m),
        final Goff=fill(GoffThyristor, m),
        final Vknee=fill(VkneeThyristor, m),
        each final useHeatPort=useHeatPort,
        final idealThyristor(off(start=offStart_p, fixed=fill(true, m))))
        "Thyristors connected to positive DC potential" annotation (Placement(
            transformation(
            origin={0,40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Electrical.Polyphase.Ideal.IdealThyristor thyristor_n(
        final m=m,
        final Ron=fill(RonThyristor, m),
        final Goff=fill(GoffThyristor, m),
        final Vknee=fill(VkneeThyristor, m),
        each final useHeatPort=useHeatPort,
        final idealThyristor(off(start=offStart_n, fixed=fill(true, m))))
        "Thyristors connected to negative DC potential" annotation (Placement(
            transformation(
            origin={0,-10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Electrical.Polyphase.Basic.Star star_p(final m=m)
        annotation (Placement(transformation(extent={{70,70},{90,50}})));
      Modelica.Electrical.Polyphase.Basic.Star star_n(final m=m)
        annotation (Placement(transformation(extent={{70,-20},{90,-40}})));
      Modelica.Thermal.HeatTransfer.Components.ThermalCollector
        thermalConnector(final m=m) if useHeatPort
        annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
      Blocks.Logical.Pre pre_p[m] annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-60,-36})));
      Blocks.Logical.Pre pre_n[m] annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-20,-36})));
    equation
      if not useHeatPort then
        LossPower = sum(thyristor_p.idealThyristor.LossPower) + sum(thyristor_n.idealThyristor.LossPower);
      end if;
      connect(ac, thyristor_p.plug_p) annotation (Line(
          points={{-100,0},{0,0},{0,30}}, color={0,0,255}));
      connect(thyristor_p.plug_p, thyristor_n.plug_n) annotation (Line(
          points={{0,30},{0,0}}, color={0,0,255}));
      connect(thyristor_p.plug_n, star_p.plug_p) annotation (Line(
          points={{0,50},{0,60},{70,60}}, color={0,0,255}));
      connect(star_p.pin_n, dc_p) annotation (Line(
          points={{90,60},{100,60}}, color={0,0,255}));
      connect(thyristor_n.plug_p, star_n.plug_p) annotation (Line(
          points={{0,-20},{0,-30},{70,-30}}, color={0,0,255}));
      connect(star_n.pin_n, dc_n) annotation (Line(
          points={{90,-30},{100,-30},{100,-60},{100,-60}}, color={0,0,255}));
      connect(heatPort, thermalConnector.port_b) annotation (Line(
          points={{0,-100},{20,-100}}, color={191,0,0}));
      connect(thermalConnector.port_a, thyristor_n.heatPort) annotation (Line(
          points={{20,-80},{20,-10},{10,-10}}, color={191,0,0}));
      connect(thyristor_p.heatPort, thermalConnector.port_a) annotation (Line(
          points={{10,40},{20,40},{20,-80}}, color={191,0,0}));
      connect(andCondition_p.y, pre_p.u)
        annotation (Line(points={{-60,-69},{-60,-48}}, color={255,0,255}));
      connect(pre_p.y, thyristor_p.fire) annotation (Line(points={{-60,-25},{-60,-25},{-60,46},{-60,50},{-11.8,50}},
                                                    color={255,0,255}));
      connect(pre_n.y, thyristor_n.fire) annotation (Line(points={{-20,-25},{-20,0},{-11.8,0}},
                                 color={255,0,255}));
      connect(andCondition_n.y, pre_n.u) annotation (Line(points={{60,-69},{60,
              -60},{-20,-60},{-20,-48}}, color={255,0,255}));
      annotation (defaultComponentName="rectifier",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-100,70},{0,50}},
              textColor={0,0,127},
              textString="AC"),
            Text(
              extent={{0,-50},{100,-70}},
              textColor={0,0,127},
              textString="DC"),
            Rectangle(
              extent={{-40,24},{40,-24}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-40,0},{40,0}},
              color={0,0,255}),
            Line(
              points={{20,24},{20,-24}},
              color={0,0,255}),
            Line(
              points={{20,0},{-20,24},{-20,-24},{20,0}},
              color={0,0,255}),
            Line(
              points={{0,12},{0,28}},
              color={0,0,255})}),
        Documentation(info="<html>
<p>
General information about AC/DC converters can be found at the
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">AC/DC converter concept</a>
</p>

<p>
This is a 2*m pulse thyristor rectifier bridge. In order to operate this rectifier a voltage source with center tap is required. It is important to note that for polyphase circuits with phase even phase numbers greater than three the
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MultiStarResistance\">MultiStarResistance</a> shall be used for grounding the voltage sources.
See example
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse\">Examples.ACDC.RectifierBridge2mPulse</a>.
</p>
</html>"));
    end ThyristorBridge2mPulse;

    model HalfControlledBridge2mPulse
      "2*m pulse half controlled rectifier bridge"
      extends Icons.Converter;
      import Modelica.Constants.pi;
      // parameter Integer m(final min=3) = 3 "Number of phases";
      parameter Modelica.SIunits.Resistance RonDiode(final min=0) = 1e-05
        "Closed diode resistance";
      parameter Modelica.SIunits.Conductance GoffDiode(final min=0) = 1e-05
        "Opened diode conductance";
      parameter Modelica.SIunits.Voltage VkneeDiode(final min=0) = 0
        "Diode forward threshold voltage";
      parameter Modelica.SIunits.Resistance RonThyristor(final min=0) = 1e-05
        "Closed thyristor resistance";
      parameter Modelica.SIunits.Conductance GoffThyristor(final min=0) = 1e-05
        "Opened thyristor conductance";
      parameter Modelica.SIunits.Voltage VkneeThyristor(final min=0) = 0
        "Thyristor forward threshold voltage";
      parameter Boolean offStart_p[m]=fill(true, m)
        "Boolean start value of variable thyristor_p[:].off"
        annotation (choices(checkBox=true));
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.ACplug;
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.DCtwoPin;
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
           293.15);
      extends Interfaces.Enable.Enable1m;
      Modelica.Electrical.Polyphase.Basic.Star star_p(final m=m)
        annotation (Placement(transformation(extent={{70,70},{90,50}})));
      Modelica.Electrical.Polyphase.Basic.Star star_n(final m=m)
        annotation (Placement(transformation(extent={{70,-50},{90,-70}})));
      Modelica.Electrical.Polyphase.Ideal.IdealThyristor thyristor_p(
        final m=m,
        final Ron=fill(RonThyristor, m),
        final Goff=fill(GoffThyristor, m),
        final Vknee=fill(VkneeThyristor, m),
        each final useHeatPort=useHeatPort,
        final idealThyristor(off(start=offStart_p, fixed=fill(true, m))))
        "Thyristors connected to positive DC potential" annotation (Placement(
            transformation(
            origin={0,40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Electrical.Polyphase.Ideal.IdealDiode diode_n(
        final m=m,
        final Ron=fill(RonDiode, m),
        final Goff=fill(GoffDiode, m),
        final Vknee=fill(VkneeDiode, m),
        each final useHeatPort=useHeatPort)
        "Diodes connected to negative DC potential" annotation (Placement(
            transformation(
            origin={0,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Thermal.HeatTransfer.Components.ThermalCollector
        thermalCollector(final m=m) if useHeatPort
        annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
      Blocks.Logical.Pre pre[m] annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-60,-46})));
    equation
      if not useHeatPort then
        LossPower = sum(thyristor_p.idealThyristor.LossPower) + sum(diode_n.idealDiode.LossPower);
      end if;
      connect(ac, thyristor_p.plug_p) annotation (Line(
          points={{-100,0},{0,0},{0,30}}, color={0,0,255}));
      connect(thyristor_p.plug_p, diode_n.plug_n) annotation (Line(
          points={{0,30},{0,-30}}, color={0,0,255}));
      connect(thyristor_p.plug_n, star_p.plug_p) annotation (Line(
          points={{0,50},{0,60},{70,60}}, color={0,0,255}));
      connect(star_p.pin_n, dc_p) annotation (Line(
          points={{90,60},{100,60}}, color={0,0,255}));
      connect(diode_n.plug_p, star_n.plug_p) annotation (Line(
          points={{0,-50},{0,-50},{0,-50},{0,-60},{70,-60}}, color={0,0,255}));
      connect(star_n.pin_n, dc_n) annotation (Line(
          points={{90,-60},{100,-60}}, color={0,0,255}));
      connect(heatPort, thermalCollector.port_b) annotation (Line(
          points={{0,-100},{20,-100}}, color={191,0,0}));
      connect(thermalCollector.port_a, diode_n.heatPort) annotation (Line(
          points={{20,-80},{20,-40},{10,-40}}, color={191,0,0}));
      connect(thyristor_p.heatPort, thermalCollector.port_a) annotation (Line(
          points={{10,40},{20,40},{20,-80}}, color={191,0,0}));
      connect(andCondition_p.y, pre.u)
        annotation (Line(points={{-60,-69},{-60,-58}}, color={255,0,255}));
      connect(pre.y, thyristor_p.fire) annotation (Line(points={{-60,-35},{-60,-35},{-60,48},{-60,50},{-11.8,50}},
                                                color={255,0,255}));
      annotation (defaultComponentName="rectifier",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-100,70},{0,50}},
              textColor={0,0,127},
              textString="AC"),
            Text(
              extent={{0,-50},{100,-70}},
              textColor={0,0,127},
              textString="DC"),
            Rectangle(
              extent={{-46,52},{34,4}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-46,28},{34,28}},
              color={0,0,255}),
            Line(
              points={{14,52},{14,4}},
              color={0,0,255}),
            Line(
              points={{14,28},{-26,52},{-26,4},{14,28}},
              color={0,0,255}),
            Rectangle(
              extent={{-46,4},{34,-52}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-46,-28},{34,-28}},
              color={0,0,255}),
            Line(
              points={{14,-4},{14,-52}},
              color={0,0,255}),
            Line(
              points={{14,-28},{-26,-4},{-26,-52},{14,-28}},
              color={0,0,255}),
            Line(
              points={{-6,-16},{-6,0}},
              color={0,0,255})}),
        Documentation(info="<html>
<p>
General information about AC/DC converters can be found at the
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">AC/DC converter concept</a>
</p>


<p>
This is a 2*m pulse half controlled rectifier bridge. In order to operate this rectifier a voltage source with center tap is required. The circuit topology is the same as in
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse\">Examples.ACDC.RectifierBridge2mPulse</a>. It is important to note that for polyphase circuits with even phase numbers greater than three the
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MultiStarResistance\">MultiStarResistance</a> shall be used for grounding the voltage sources.
</p>
</html>"));
    end HalfControlledBridge2mPulse;

    model DiodeCenterTap2mPulse "2*m pulse diode rectifier with center tap"
      extends Icons.Converter;
      import Modelica.Constants.pi;
      parameter Integer m(final min=3) = 3 "Number of phases";
      parameter Modelica.SIunits.Resistance RonDiode(final min=0) = 1e-05
        "Closed diode resistance";
      parameter Modelica.SIunits.Conductance GoffDiode(final min=0) = 1e-05
        "Opened diode conductance";
      parameter Modelica.SIunits.Voltage VkneeDiode(final min=0) = 0
        "Diode forward threshold voltage";
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.ACtwoPlug;
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.DCpin;
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
           293.15);
      Modelica.Electrical.Polyphase.Ideal.IdealDiode diode_p(
        final m=m,
        final Ron=fill(RonDiode, m),
        final Goff=fill(GoffDiode, m),
        final Vknee=fill(VkneeDiode, m),
        each final useHeatPort=useHeatPort)
        "Diodes connected to positive DC potential" annotation (Placement(
            transformation(
            origin={-10,60},
            extent={{10,10},{-10,-10}},
            rotation=180)));
      Modelica.Electrical.Polyphase.Ideal.IdealDiode diode_n(
        final m=m,
        final Ron=fill(RonDiode, m),
        final Goff=fill(GoffDiode, m),
        final Vknee=fill(VkneeDiode, m),
        each final useHeatPort=useHeatPort)
        "Diodes connected to negative DC potential" annotation (Placement(
            transformation(
            origin={-10,-60},
            extent={{10,10},{-10,-10}},
            rotation=180)));
      Modelica.Electrical.Polyphase.Basic.Star star_p(final m=m)
        annotation (Placement(transformation(extent={{70,70},{90,50}})));
      Modelica.Electrical.Polyphase.Basic.Star star_n(final m=m)
        annotation (Placement(transformation(extent={{72,-50},{92,-70}})));
      Modelica.Thermal.HeatTransfer.Components.ThermalCollector
        thermalCollector(final m=m) if useHeatPort
        annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
    equation
      if not useHeatPort then
        LossPower = sum(diode_p.idealDiode.LossPower) + sum(diode_n.idealDiode.LossPower);
      end if;
      connect(diode_p.plug_n, star_p.plug_p) annotation (Line(
          points={{0,60},{70,60}}, color={0,0,255}));
      connect(star_p.pin_n, dc_p) annotation (Line(
          points={{90,60},{100,60},{100,0}}, color={0,0,255}));
      connect(heatPort, thermalCollector.port_b) annotation (Line(
          points={{0,-100},{30,-100}}, color={191,0,0}));
      connect(thermalCollector.port_a, diode_n.heatPort) annotation (Line(
          points={{30,-80},{-10,-80},{-10,-70}}, color={191,0,0}));
      connect(diode_p.heatPort, thermalCollector.port_a) annotation (Line(
          points={{-10,50},{-10,40},{30,40},{30,-80}}, color={191,0,0}));
      connect(ac_p, diode_p.plug_p) annotation (Line(
          points={{-100,60},{-20,60}}, color={0,0,255}));
      connect(star_n.pin_n, dc_p) annotation (Line(
          points={{92,-60},{100,-60},{100,0}}, color={0,0,255}));
      connect(diode_n.plug_p, ac_n) annotation (Line(
          points={{-20,-60},{-100,-60}}, color={0,0,255}));
      connect(diode_n.plug_n, star_n.plug_p) annotation (Line(
          points={{0,-60},{72,-60}}, color={0,0,255}));
      annotation (defaultComponentName="rectifier",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-100,70},{0,50}},
              textColor={0,0,127},
              textString="AC"),
            Text(
              extent={{0,-50},{100,-70}},
              textColor={0,0,127},
              textString="DC"),
            Rectangle(
              extent={{-40,24},{40,-24}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-40,0},{40,0}},
              color={0,0,255}),
            Line(
              points={{20,24},{20,-24}},
              color={0,0,255}),
            Line(
              points={{20,0},{-20,24},{-20,-24},{20,0}},
              color={0,0,255})}),
        Documentation(info="<html>
<p>
General information about AC/DC converters can be found at the
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">AC/DC converter concept</a>
</p>

<p>
This is a 2*m pulse diode rectifier with center tap. In order to operate this rectifier a voltage source with center tap is required. The center tap has to be connected with the negative pin of the load. The circuit topology is the same as in
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2mPulse\">Examples.ACDC.RectifierCenterTap2mPulse</a>.
</p>
</html>"));
    end DiodeCenterTap2mPulse;

    model ThyristorCenterTap2mPulse
      "2*m pulse thyristor rectifier with center tap"
      extends Icons.Converter;
      import Modelica.Constants.pi;
      // parameter Integer m(final min=3) = 3 "Number of phases";
      parameter Modelica.SIunits.Resistance RonThyristor(final min=0) = 1e-05
        "Closed thyristor resistance";
      parameter Modelica.SIunits.Conductance GoffThyristor(final min=0) = 1e-05
        "Opened thyristor conductance";
      parameter Modelica.SIunits.Voltage VkneeThyristor(final min=0) = 0
        "Thyristor forward threshold voltage";
      parameter Boolean offStart_p[m]=fill(true, m)
        "Boolean start value of variable thyristor_p[:].off"
        annotation (choices(checkBox=true));
      parameter Boolean offStart_n[m]=fill(true, m)
        "Boolean start value of variable thyristor_n[:].off"
        annotation (choices(checkBox=true));
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.ACtwoPlug;
      extends Modelica.Electrical.PowerConverters.Interfaces.ACDC.DCpin;
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
           293.15);
      extends Interfaces.Enable.Enable2m;
      Modelica.Electrical.Polyphase.Ideal.IdealThyristor thyristor_p(
        final m=m,
        final Ron=fill(RonThyristor, m),
        final Goff=fill(GoffThyristor, m),
        final Vknee=fill(VkneeThyristor, m),
        each final useHeatPort=useHeatPort,
        final idealThyristor(off(start=offStart_p, fixed=fill(true, m))))
        "Thyristors conducting positive plug AC potentials" annotation (
          Placement(transformation(
            origin={-10,60},
            extent={{10,10},{-10,-10}},
            rotation=180)));
      Modelica.Electrical.Polyphase.Ideal.IdealThyristor thyristor_n(
        final m=m,
        final Ron=fill(RonThyristor, m),
        final Goff=fill(GoffThyristor, m),
        final Vknee=fill(VkneeThyristor, m),
        each final useHeatPort=useHeatPort,
        final idealThyristor(off(start=offStart_n, fixed=fill(true, m))))
        "Thyristors conducting negative plug AC potentials" annotation (
          Placement(transformation(
            origin={-10,-60},
            extent={{10,10},{-10,-10}},
            rotation=180)));
      Modelica.Electrical.Polyphase.Basic.Star star_p(final m=m)
        annotation (Placement(transformation(extent={{70,70},{90,50}})));
      Modelica.Electrical.Polyphase.Basic.Star star_n(final m=m)
        annotation (Placement(transformation(extent={{72,-50},{92,-70}})));
      Modelica.Thermal.HeatTransfer.Components.ThermalCollector
        thermalCollector(final m=m) if useHeatPort
        annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
    equation
      if not useHeatPort then
        LossPower = sum(thyristor_p.idealThyristor.LossPower) + sum(thyristor_n.idealThyristor.LossPower);
      end if;
      connect(thyristor_p.plug_n, star_p.plug_p) annotation (Line(
          points={{0,60},{70,60}}, color={0,0,255}));
      connect(star_p.pin_n, dc_p) annotation (Line(
          points={{90,60},{100,60},{100,0}}, color={0,0,255}));
      connect(heatPort, thermalCollector.port_b) annotation (Line(
          points={{0,-100},{30,-100}}, color={191,0,0}));
      connect(thermalCollector.port_a, thyristor_n.heatPort) annotation (Line(
          points={{30,-80},{-10,-80},{-10,-70}}, color={191,0,0}));
      connect(thyristor_p.heatPort, thermalCollector.port_a) annotation (Line(
          points={{-10,50},{-10,40},{30,40},{30,-80}}, color={191,0,0}));
      connect(ac_p, thyristor_p.plug_p) annotation (Line(
          points={{-100,60},{-20,60}}, color={0,0,255}));
      connect(star_n.pin_n, dc_p) annotation (Line(
          points={{92,-60},{100,-60},{100,0}}, color={0,0,255}));
      connect(thyristor_n.plug_p, ac_n) annotation (Line(
          points={{-20,-60},{-100,-60}}, color={0,0,255}));
      connect(thyristor_n.plug_n, star_n.plug_p) annotation (Line(
          points={{0,-60},{72,-60}}, color={0,0,255}));
      connect(andCondition_p.y, thyristor_p.fire) annotation (Line(
          points={{-60,-69},{-60,80},{1.77636e-15,80},{1.77636e-15,71.8}},
                                                       color={255,0,255}));
      connect(andCondition_n.y, thyristor_n.fire) annotation (Line(
          points={{60,-69},{60,-40},{1.77636e-15,-40},{1.77636e-15,-48.2}},
                                                        color={255,0,255}));
      annotation (defaultComponentName="rectifier",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-100,70},{0,50}},
              textColor={0,0,127},
              textString="AC"),
            Text(
              extent={{0,-50},{100,-70}},
              textColor={0,0,127},
              textString="DC"),
            Rectangle(
              extent={{-40,24},{40,-24}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-40,0},{40,0}},
              color={0,0,255}),
            Line(
              points={{20,24},{20,-24}},
              color={0,0,255}),
            Line(
              points={{20,0},{-20,24},{-20,-24},{20,0}},
              color={0,0,255}),
            Line(
              points={{0,12},{0,28}},
              color={0,0,255})}),
        Documentation(info="<html>
<p>
General information about AC/DC converters can be found at the
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">AC/DC converter concept</a>
</p>

<p>
This is a 2*m pulse thyristor rectifier with center tap. In order to operate this rectifier a voltage source with center tap is required. The center tap has to be connected with the negative pin of the load. See example
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2mPulse\">Examples.ACDC.RectifierCenterTap2mPulse</a>.
</p>
</html>"));
    end ThyristorCenterTap2mPulse;
    annotation (Documentation(info="<html>
<p>
General information about AC/DC converters can be found at the
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">AC/DC converter concept</a>
</p>
</html>"));
  end ACDC;

  package DCAC "DC to AC converters"
    extends Modelica.Icons.Package;
    package Control "Control components for DC to AC converters"
      extends Modelica.Icons.Package;

      block PWM "PulseWidthModulation"
        extends Modelica.Blocks.Icons.Block;
        constant Integer m=3 "Number of phases";
        parameter Modelica.Electrical.PowerConverters.Types.PWMType pwmType=
            Modelica.Electrical.PowerConverters.Types.PWMType.SVPWM "PWM Type"
          annotation (Evaluate=true);
        parameter Modelica.SIunits.Frequency f "Switching frequency";
        parameter Modelica.SIunits.Time startTime=0 "Start time of PWM";
        parameter Real uMax "Maximum amplitude of signal";
        parameter Modelica.Electrical.PowerConverters.Types.ReferenceType
          refType=Modelica.Electrical.PowerConverters.Types.ReferenceType.Triangle3
          "Type of reference signal" annotation (Evaluate=true, Dialog(enable=
                pwmType == Modelica.Electrical.PowerConverters.Types.PWMType.Intersective));
        Modelica.Blocks.Interfaces.RealInput u[2] "Reference space phasor"
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.BooleanOutput fire_p[m] "positive fire signal"
          annotation (Placement(transformation(extent={{100,50},{120,70}})));
        Modelica.Blocks.Interfaces.BooleanOutput fire_n[m] "negative fire signal"
          annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
        Modelica.Electrical.PowerConverters.DCAC.Control.SVPWM svPWM(
          f=f,
          startTime=startTime,
          uMax=uMax) if pwmType == Modelica.Electrical.PowerConverters.Types.PWMType.SVPWM
          annotation (Placement(transformation(extent={{-10,30},{10,50}})));
        Modelica.Electrical.PowerConverters.DCAC.Control.IntersectivePWM
          intersectivePWM(
          f=f,
          startTime=startTime,
          uMax=uMax,
          refType=refType) if pwmType == Modelica.Electrical.PowerConverters.Types.PWMType.Intersective
          annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
      equation
        connect(u, svPWM.u) annotation (Line(points={{-120,0},{-60,0},{-60,40},{-12,40}},
              color={0,0,127}));
        connect(u, intersectivePWM.u) annotation (Line(points={{-120,0},{-60,0},{-60,-40},
                {-12,-40}}, color={0,0,127}));
        connect(svPWM.fire_p, fire_p) annotation (Line(points={{11,46},{40,46},{40,60},
                {110,60}}, color={255,0,255}));
        connect(intersectivePWM.fire_p, fire_p) annotation (Line(points={{11,-34},{40,
                -34},{40,60},{110,60}}, color={255,0,255}));
        connect(svPWM.fire_n, fire_n) annotation (Line(points={{11,34},{60,34},{60,-60},
                {110,-60}}, color={255,0,255}));
        connect(intersectivePWM.fire_n, fire_n) annotation (Line(points={{11,-46},{60,
                -46},{60,-60},{110,-60}}, color={255,0,255}));
        annotation (defaultComponentName="pwm", Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
                extent={{-70,80},{70,40}},
                textString="P W M"), Text(
                extent={{-70,-40},{70,-80}},
                textString="f=%f"), Text(
                extent={{-70,20},{70,-20}},
                textString="%pwmType")}), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>
Let the user choose the PWM type from:
</p>
<ul>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.DCAC.Control.SVPWM\">Space Vector pulse width modulation</a></li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.DCAC.Control.IntersectivePWM\">Intersective pulse width modulation</a></li>
</ul>
</html>"));
      end PWM;

      block SVPWM "SpaceVector Pulse Width Modulation"
        parameter Modelica.SIunits.Frequency f "Switching frequency";
        extends Modelica.Blocks.Interfaces.DiscreteBlock(final samplePeriod=1/f);
        import Modelica.Constants.small;
        import Modelica.Constants.eps;
        import Modelica.Constants.pi;
        import Modelica.Math.atan2;
        constant Integer m=3 "Number of phases";
        parameter Real uMax "Maximum length of space vector = half diagonal of hexagon";
        constant Boolean fire[6,m]=[true, false,false;
                                    true, true, false;
                                    false,true, false;
                                    false,true, true;
                                    false,false,true;
                                    true, false,true] "Switching patterns";
        Modelica.Blocks.Interfaces.RealInput u[2] "Reference space phasor"
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.BooleanOutput fire_p[m] "positive fire signal"
          annotation (Placement(transformation(extent={{100,50},{120,70}})));
        Modelica.Blocks.Interfaces.BooleanOutput fire_n[m] "negative fire signal"
          annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
      protected
        discrete Real uRef(start=0, fixed=true) "length of reference vector";
        discrete Modelica.SIunits.Angle phiRef(start=0, fixed=true) "Angle of reference vector within (-pi, +pi]";
        discrete Modelica.SIunits.Angle phiPos(start=0, fixed=true) "Angle of reference vector within [0, 2*pi)";
        Integer ka(start=0, fixed=true), kb(start=0, fixed=true) "Switching patterns limiting the sector";
        discrete Modelica.SIunits.Angle phiSec(start=0, fixed=true) "Angle of reference vector within sector within [0, pi/m)";
        discrete Real ta(start=0, fixed=true), tb(start=0, fixed=true), t0(start=samplePeriod, fixed=true) "Relative time spans of vectors a, b, and 0";
        discrete Modelica.SIunits.Time T0(start=startTime, fixed=true) "Start time of switching interval";
      algorithm
        when sampleTrigger then
          //Limited relative reference signal
          uRef:=min(sqrt(u[1]^2 + u[2]^2)/(2/3*uMax), cos(pi/6));
          //Determine angle of reference signal within (-pi, +pi]
          phiRef:=if noEvent(uRef < small) then 0 else atan2(u[2], u[1]);
          //Shift angle to [0, 2*pi)
          phiPos:=max(phiRef + (if phiRef < -eps then 2*pi else 0), 0);
          //Determine sector and neighbour sector
          ka:=integer(phiPos/(pi/m));
          kb:=if noEvent(ka >= 5) then 0 else ka + 1;
          //Determine angle within sector in the range of [0, pi/m)
          phiSec:=phiPos - ka*pi/m;
          //Determine limited relative time spans
          //uRef*cos(phiSec)=tb*cos(pi/m) + ta;
          //uRef*sin(phiSec)=tb*sin(pi/m);
          tb:=min(uRef*sin(phiSec)/sin(pi/m), 1);
          ta:=min(uRef*cos(phiSec) - tb*cos(pi/m), 1);
          t0:=max(1 - ta - tb, 0);
          //Remember start time of switching interval
          T0:=time;
        end when;
      equation
        //Distribute switching patterns t0/4 + ta/2 + tb/2 + t0/2 + tb/2 + t2/2 + t0/4
        if time<startTime then
          fire_p= fill(true, m);
        elseif (time - T0)/samplePeriod < (t0/4) then
          fire_p= fill(false, m);
        elseif (time - T0)/samplePeriod < (t0/4 + ta/2) then
          fire_p= fire[ka + 1, :];
        elseif (time - T0)/samplePeriod < (t0/4 + ta/2 + tb/2) then
          fire_p= fire[kb + 1, :];
        elseif (time - T0)/samplePeriod < (t0/4 + ta/2 + tb/2 + t0/4) then
          fire_p= fill(true, m);
        elseif (time - T0)/samplePeriod < (t0/4 + ta/2 + tb/2 + t0/4 + tb/2) then
          fire_p= fire[kb + 1, :];
        elseif (time - T0)/samplePeriod < (t0/4 + ta/2 + tb/2 + t0/4 + tb/2 + ta/2) then
          fire_p= fire[ka + 1, :];
        else
          fire_p= fill(false, m);
        end if;
        fire_n= not fire_p;
        annotation (defaultComponentName="svPWM", Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Line(points={{-80,30},{-36,30},{-36,50},{-10,50},{-10,30},{10,30},{10,50},
                    {36,50},{36,30},{80,30}}, color={255,0,0}),
              Line(points={{-80,-10},{-70,-10},{-70,10},{-36,10},{-36,-10},{36,-10},{36,
                    10},{70,10},{70,-10},{80,-10}}, color={0,0,255}),
              Line(points={{-80,-50},{-80,-30},{-70,-30},{-70,-50},{-10,-50},{-10,-30},
                    {10,-30},{10,-50},{70,-50},{70,-30},{80,-30},{80,-50}}, color={0,0,
                    0})}),                                             Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>
For a three-phase system, 8 space vectors are available according to the following switching patterns:
</p>
<ul>
<li>0 [0,0,0] length 0</li>
<li>1 [1,0,0] 000&deg;</li>
<li>2 [1,1,0] 060&deg;</li>
<li>3 [0,1,0] 120&deg;</li>
<li>4 [0,1,1] 180&deg;</li>
<li>5 [0,0,1] 240&deg;</li>
<li>6 [1,0,1] 300&deg;</li>
<li>7 [1,1,1] length 0</li>
</ul>
<p>
Vector 1..6 form a hexagon, vector 0 and 7 are of length 0.
</p>
<p>
First, the space vector is limited,
and the sector of the hexagon is determined where the input space vector <u>u</u> is located;
then the angle of the space vector within this sector 0&le;&phi;&lt;60&deg; is calculated.
</p>
<p>
The input space vector is averaged by <u>u</u> = t<sub>a</sub>*<u>u</u><sub>a</sub> + t<sub>b</sub>*<u>u</u><sub>b</sub> + t<sub>0</sub>*0,
where <u>u</u><sub>a</sub> is the space vector at the left border of the sector
and <u>u</u><sub>b</sub> is the space vector at the right border of the sector.
If necessary, a zero length vector is applied additionally.
</p>
<p>
The relative time spans for averaging over one switching period are determined by the following equations:
</p>
<ul>
<li>Real part: <u>u</u>*cos(&phi;) = <u>u</u><sub>b</sub>*t<sub>b</sub>*cos(60&deg;) + <u>u</u><sub>a</sub>*t<sub>a</sub>*1</li>
<li>Imag.part: <u>u</u>*sin(&phi;) = <u>u</u><sub>b</sub>*t<sub>b</sub>*sin(60&deg;)</li>
<li>t<sub>a</sub> + t<sub>b</sub> + t<sub>0</sub> = 1</li>
</ul>
<p>
To obtain the positive fire signal, the switching time spans are distributed symmetrically:
t<sub>0</sub>/4 + t<sub>a</sub>/2 + t<sub>b</sub>/2 +t<sub>0</sub>/2 + t<sub>b</sub>/2 + t<sub>a</sub>/2 + t<sub>0</sub>/4
</p>
<p>
The switching pattern of the negative fire signal is just the inverse of the positive fire signal.
</p>
</html>"));
      end SVPWM;

      block IntersectivePWM "Intersective PWM"
        extends Modelica.Blocks.Icons.Block;
        import Modelica.Electrical.PowerConverters.Types.ReferenceType;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Frequency f "Switching frequency";
        parameter Modelica.SIunits.Time startTime=0 "Start time of PWM";
        parameter Real uMax "Maximum amplitude of signal";
        parameter Modelica.Electrical.PowerConverters.Types.ReferenceType
          refType=Modelica.Electrical.PowerConverters.Types.ReferenceType.Triangle3
          "Type of reference signal" annotation (Evaluate=true);
        Modelica.Blocks.Interfaces.RealInput u[2] "Reference space phasor"
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.BooleanOutput fire_p[m] "positive fire signal"
          annotation (Placement(transformation(extent={{100,50},{120,70}})));
        Modelica.Blocks.Interfaces.BooleanOutput fire_n[m] "negative fire signal"
          annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
        Modelica.Electrical.Machines.SpacePhasors.Blocks.FromSpacePhasor
          fromSpacePhasor
          annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
        Modelica.Blocks.Sources.Constant zero(k=0) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-70,30})));
        Modelica.Blocks.Sources.SawTooth sawTooth[m](
          each nperiod=-1,
          each amplitude=uMax,
          each offset=-uMax/2,
          each period=1/f,
          startTime={startTime - 1.5 + (if refType == ReferenceType.Sawtooth1
               then 0 else k)/m for k in 0:m - 1}/f) if
             (refType==ReferenceType.Sawtooth1 or refType==ReferenceType.Sawtooth3)
          annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
        Modelica.Blocks.Sources.Trapezoid trapezoid[3](
          each amplitude=uMax,
          each width=0,
          each nperiod=-1,
          each offset=-uMax/2,
          each rising=0.5/f,
          each falling=0.5/f,
          each period=1/f,
          startTime={startTime - 1.25 + (if refType == ReferenceType.Triangle1
               then 0 else k)/m for k in 0:m - 1}/f) if
             (refType==ReferenceType.Triangle1 or refType==ReferenceType.Triangle3)
           annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
        Modelica.Blocks.Logical.GreaterEqual greaterEqual[m]
          annotation (Placement(transformation(extent={{30,50},{50,70}})));
        Modelica.Blocks.Logical.Not negation[m]
          annotation (Placement(transformation(extent={{72,-70},{92,-50}})));
        Modelica.Blocks.Logical.Switch switch1[m]
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Blocks.Sources.Constant const[m](each k=-uMax) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,-30})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=time >=
              startTime)
          annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));
        Modelica.Blocks.Routing.BooleanReplicator booleanReplicator(nout=m)
          annotation (Placement(transformation(extent={{-70,-90},{-50,-70}})));
      equation
        connect(u, fromSpacePhasor.u) annotation (Line(points={{-120,0},{-90,0},{-90,60},
                {-62,60}}, color={0,0,127}));
        connect(zero.y, fromSpacePhasor.zero)
          annotation (Line(points={{-70,41},{-70,52},{-62,52}}, color={0,0,127}));
        connect(fromSpacePhasor.y, greaterEqual.u1)
          annotation (Line(points={{-39,60},{28,60}}, color={0,0,127}));
        connect(greaterEqual.y, fire_p)
          annotation (Line(points={{51,60},{110,60}}, color={255,0,255}));
        connect(negation.y, fire_n)
          annotation (Line(points={{93,-60},{110,-60}}, color={255,0,255}));
        connect(greaterEqual.y, negation.u) annotation (Line(points={{51,60},{60,60},{
                60,-60},{70,-60}}, color={255,0,255}));
        connect(switch1.y, greaterEqual.u2)
          annotation (Line(points={{11,0},{20,0},{20,52},{28,52}}, color={0,0,127}));
        connect(sawTooth.y, switch1.u1) annotation (Line(points={{-59,-20},{-50,-20},{
                -50,8},{-12,8}}, color={0,0,127}));
        connect(trapezoid.y, switch1.u1) annotation (Line(points={{-59,-50},{-50,-50},
                {-50,8},{-12,8}}, color={0,0,127}));
        connect(const.y, switch1.u3)
          annotation (Line(points={{-20,-19},{-20,-8},{-12,-8}}, color={0,0,127}));
        connect(booleanReplicator.y, switch1.u2) annotation (Line(points={{-49,-80},{-40,
                -80},{-40,0},{-12,0}}, color={255,0,255}));
        connect(booleanExpression.y, booleanReplicator.u)
          annotation (Line(points={{-79,-80},{-72,-80}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Line(
                points={{-60,0},{-51.6,34.2},{-46.1,53.1},{-41.3,66.4},{-37.1,74.6},{-32.9,
                    79.1},{-28.64,79.8},{-24.42,76.6},{-20.201,69.7},{-15.98,59.4},{-11.16,
                    44.1},{-5.1,21.2},{7.5,-30.8},{13,-50.2},{17.8,-64.2},{22,-73.1},{
                    26.2,-78.4},{30.5,-80},{34.7,-77.6},{38.9,-71.5},{43.1,-61.9},{47.9,
                    -47.2},{54,-24.8},{60,0}},
                color={0,0,255},
                thickness=0.5,
                smooth=Smooth.Bezier), Line(points={{-60,-80},{-48,80},{-40,-80},{-30,
                    80},{-20,-80},{-10,80},{0,-80},{10,80},{20,-78},{30,80},{40,-80},{
                    50,80},{60,-80}}, color={238,46,47})}),            Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>
The intersective PWM transforms the input space phasor <u>u</u> to the three-phase voltages,
and compares them with the reference signals.
As long as the phase voltage is greater than the corresponding reference signal, the corresponding fire signal is true.
The switching pattern of the negative fire signal is just the inverse of the positive fire signal.
</p>
<p>
The user can choose from 4 different reference signals:
</p>
<ul>
<li>Sawtooth1: sawtooth signal, same phase in all three phases</li>
<li>Sawtooth3: sawtooth signal, phase shift between the three phases = period/3</li>
<li>Triangle1: triangle signal, same phase in all three phases</li>
<li>Triangle3: triangle signal, phase shift between the three phases = period/3</li>
</ul>
</html>"));
      end IntersectivePWM;
      annotation (Documentation(info="<html>
<p>
Currently there are only three-phase PWM implemented (not polyphase).
</p>
</html>"));
    end Control;

    model SinglePhase2Level "Single-phase DC to AC converter"
      extends Modelica.Blocks.Icons.Block;
      parameter Modelica.SIunits.Resistance RonTransistor=1e-05
        "Transistor closed resistance";
      parameter Modelica.SIunits.Conductance GoffTransistor=1e-05
        "Transistor opened conductance";
      parameter Modelica.SIunits.Voltage VkneeTransistor=0
        "Transistor threshold voltage";
      parameter Modelica.SIunits.Resistance RonDiode=1e-05
        "Diode closed resistance";
      parameter Modelica.SIunits.Conductance GoffDiode=1e-05
        "Diode opened conductance";
      parameter Modelica.SIunits.Voltage VkneeDiode=0 "Diode threshold voltage";
      // parameter Boolean useEnable "Enables enable signal connector";
      extends Modelica.Electrical.PowerConverters.Interfaces.DCAC.DCtwoPin;
      extends Modelica.Electrical.PowerConverters.Interfaces.DCAC.ACpin;
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
           293.15);
      extends Interfaces.Enable.Enable2;
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor transistor_p(
        final Ron=RonTransistor,
        final Goff=GoffTransistor,
        final Vknee=VkneeTransistor,
        final useHeatPort=useHeatPort) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={30,20})));
      Modelica.Electrical.Analog.Ideal.IdealDiode diode_p(
        final Ron=RonDiode,
        final Goff=GoffDiode,
        final Vknee=VkneeDiode,
        final useHeatPort=useHeatPort) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,20})));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor transistor_n(
        final Ron=RonTransistor,
        final Goff=GoffTransistor,
        final Vknee=VkneeTransistor,
        final useHeatPort=useHeatPort) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={30,-20})));
      Modelica.Electrical.Analog.Ideal.IdealDiode diode_n(
        final Ron=RonDiode,
        final Goff=GoffDiode,
        final Vknee=VkneeDiode,
        final useHeatPort=useHeatPort) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,-20})));
    equation
      if not useHeatPort then
        LossPower = transistor_p.LossPower + diode_n.LossPower + transistor_n.LossPower
           + diode_n.LossPower;
      end if;
      connect(transistor_p.p, dc_p) annotation (Line(
          points={{30,30},{50,30},{50,60},{-100,60},{-100,60}}, color={0,0,255}));
      connect(transistor_n.n, dc_n) annotation (Line(
          points={{30,-30},{50,-30},{50,-60},{-100,-60},{-100,-60}}, color={0,0,255}));
      connect(transistor_p.p, diode_p.n) annotation (Line(
          points={{30,30},{70,30}}, color={0,0,255}));
      connect(transistor_p.n, diode_p.p) annotation (Line(
          points={{30,10},{70,10}}, color={0,0,255}));
      connect(transistor_n.p, diode_n.n) annotation (Line(
          points={{30,-10},{70,-10}}, color={0,0,255}));
      connect(transistor_n.n, diode_n.p) annotation (Line(
          points={{30,-30},{70,-30}}, color={0,0,255}));
      connect(transistor_p.n, transistor_n.p) annotation (Line(
          points={{30,10},{50,10},{50,-10},{30,-10}}, color={0,0,255}));
      connect(ac, transistor_p.n) annotation (Line(
          points={{100,0},{50,0},{50,10},{30,10}}, color={0,0,255}));
      connect(transistor_p.heatPort, heatPort) annotation (Line(
          points={{40,20},{40,0},{0,0},{0,-100}}, color={191,0,0}));
      connect(transistor_n.heatPort, heatPort) annotation (Line(
          points={{40,-20},{40,-40},{0,-40},{0,-100}}, color={191,0,0}));
      connect(diode_p.heatPort, heatPort) annotation (Line(
          points={{80,20},{80,-40},{0,-40},{0,-100}}, color={191,0,0}));
      connect(diode_n.heatPort, heatPort) annotation (Line(
          points={{80,-20},{80,-40},{0,-40},{0,-100}}, color={191,0,0}));
      connect(andCondition_p.y, transistor_p.fire) annotation (Line(
          points={{-60,-69},{-60,10},{18,10}}, color={255,0,255}));
      connect(andCondition_n.y, transistor_n.fire) annotation (Line(
          points={{60,-69},{60,-50},{10,-50},{10,-30},{18,-30}}, color={255,0,255}));
      annotation (defaultComponentName="inverter",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(
              points={{-100,-100},{100,100}},
              color={0,0,127}),
            Rectangle(
              extent={{-40,40},{40,-40}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-20,20},{-20,-20}},
              color={0,0,255}),
            Line(
              points={{-28,20},{-28,-20}},
              color={0,0,255}),
            Line(
              points={{-40,0},{-28,0}},
              color={0,0,255}),
            Line(
              points={{-20,4},{0,24},{0,40}},
              color={0,0,255}),
            Line(
              points={{-20,-4},{0,-24},{0,-40}},
              color={0,0,255}),
            Line(
              points={{-4,-20},{-10,-8},{-16,-14},{-4,-20}},
              color={0,0,255}),
            Line(
              points={{0,-24},{10,-24},{10,24},{0,24}},
              color={0,0,255}),
            Line(
              points={{0,8},{20,8}},
              color={0,0,255}),
            Line(
              points={{10,8},{0,-8},{20,-8},{10,8}},
              color={0,0,255}),
            Text(
              extent={{-100,70},{0,50}},
              textColor={0,0,127},
              textString="DC"),
            Text(
              extent={{0,-50},{100,-70}},
              textColor={0,0,127},
              textString="AC")}),
        Documentation(info="<html>
<p>
This is a single-phase two level inverter. The boolean signals <code>fire_p</code> and <code>fire_n</code> shall not be <code>true</code> at the same time to avoid DC bus short circuits. The inverter consists of two transistors and two anti parallel free wheeling diodes.
</p>

<p>
An example of a single-phase inverter with PWM voltage control is included in
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.DCAC.SinglePhaseTwoLevel\">Examples.DCAC.SinglePhaseTwoLevel</a>.
</p>
</html>"));
    end SinglePhase2Level;

    model Polyphase2Level "Polyphase DC to AC converter"
      extends Modelica.Blocks.Icons.Block;
      extends Interfaces.Enable.Enable2m;
      parameter Modelica.SIunits.Resistance RonTransistor=1e-05
        "Transistor closed resistance";
      parameter Modelica.SIunits.Conductance GoffTransistor=1e-05
        "Transistor opened conductance";
      parameter Modelica.SIunits.Voltage VkneeTransistor=0
        "Transistor threshold voltage";
      parameter Modelica.SIunits.Resistance RonDiode=1e-05
        "Diode closed resistance";
      parameter Modelica.SIunits.Conductance GoffDiode=1e-05
        "Diode opened conductance";
      parameter Modelica.SIunits.Voltage VkneeDiode=0 "Diode threshold voltage";
      // parameter Boolean useEnable "Enables enable signal connector";
      extends Modelica.Electrical.PowerConverters.Interfaces.DCAC.DCtwoPin;
      extends Modelica.Electrical.PowerConverters.Interfaces.DCAC.ACplug;
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
           293.15);
      Modelica.Electrical.Polyphase.Ideal.IdealGTOThyristor transistor_p(
        final m=m,
        final Ron=fill(RonTransistor, m),
        final Goff=fill(GoffTransistor, m),
        final Vknee=fill(VkneeTransistor, m),
        final useHeatPort=useHeatPort) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={30,20})));
      Modelica.Electrical.Polyphase.Ideal.IdealDiode diode_p(
        final m=m,
        final Ron=fill(RonDiode, m),
        final Goff=fill(GoffDiode, m),
        final Vknee=fill(VkneeDiode, m),
        final useHeatPort=useHeatPort) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,20})));
      Modelica.Electrical.Polyphase.Basic.Star star_p(final m=m) annotation (
          Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={50,50})));
      Modelica.Electrical.Polyphase.Ideal.IdealGTOThyristor transistor_n(
        final m=m,
        final Ron=fill(RonTransistor, m),
        final Goff=fill(GoffTransistor, m),
        final Vknee=fill(VkneeTransistor, m),
        final useHeatPort=useHeatPort) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={30,-20})));
      Modelica.Electrical.Polyphase.Ideal.IdealDiode diode_n(
        final m=m,
        final Ron=fill(RonDiode, m),
        final Goff=fill(GoffDiode, m),
        final Vknee=fill(VkneeDiode, m),
        final useHeatPort=useHeatPort) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,-20})));
      Modelica.Electrical.Polyphase.Basic.Star star_n(final m=m) annotation (
          Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={50,-50})));
      Modelica.Thermal.HeatTransfer.Components.ThermalCollector
        thermalCollector(final m=m) if useHeatPort
        annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
    equation
      if not useHeatPort then
        LossPower = sum(transistor_p.idealGTOThyristor.LossPower) + sum(diode_n.idealDiode.LossPower)
           + sum(transistor_n.idealGTOThyristor.LossPower) + sum(diode_n.idealDiode.LossPower);
      end if;
      connect(transistor_p.plug_p, star_p.plug_p) annotation (Line(
          points={{30,30},{50,30},{50,40}}, color={0,0,255}));
      connect(star_p.plug_p, diode_p.plug_n) annotation (Line(
          points={{50,40},{50,30},{70,30}}, color={0,0,255}));
      connect(transistor_n.plug_n, star_n.plug_p) annotation (Line(
          points={{30,-30},{50,-30},{50,-40}}, color={0,0,255}));
      connect(star_n.plug_p, diode_n.plug_p) annotation (Line(
          points={{50,-40},{50,-30},{70,-30}}, color={0,0,255}));
      connect(transistor_p.plug_n, diode_p.plug_p) annotation (Line(
          points={{30,10},{70,10}}, color={0,0,255}));
      connect(transistor_n.plug_p, diode_n.plug_n) annotation (Line(
          points={{30,-10},{70,-10}}, color={0,0,255}));
      connect(star_n.pin_n, dc_n) annotation (Line(
          points={{50,-60},{50,-66},{-100,-66},{-100,-60}},  color={0,0,255}));
      connect(dc_p, star_p.pin_n) annotation (Line(
          points={{-100,60},{-100,70},{50,70},{50,60}},  color={0,0,255}));
      connect(transistor_p.plug_n, ac) annotation (Line(
          points={{30,10},{50,10},{50,0},{100,0}}, color={0,0,255}));
      connect(transistor_n.plug_p, ac) annotation (Line(
          points={{30,-10},{50,-10},{50,0},{100,0}}, color={0,0,255}));
      connect(heatPort, thermalCollector.port_b) annotation (Line(
          points={{0,-100},{0,-60}}, color={191,0,0}));
      connect(thermalCollector.port_a, transistor_n.heatPort) annotation (Line(
          points={{0,-40},{0,-36},{40,-36},{40,-20}}, color={191,0,0}));
      connect(diode_n.heatPort, thermalCollector.port_a) annotation (Line(
          points={{80,-20},{80,-36},{0,-36},{0,-40}}, color={191,0,0}));
      connect(transistor_p.heatPort, thermalCollector.port_a) annotation (Line(
          points={{40,20},{40,4},{0,4},{0,-40}}, color={191,0,0}));
      connect(diode_p.heatPort, thermalCollector.port_a) annotation (Line(
          points={{80,20},{80,4},{0,4},{0,-40}}, color={191,0,0}));
      connect(andCondition_p.y, transistor_p.fire) annotation (Line(
          points={{-60,-69},{-60,10},{18,10}}, color={255,0,255}));
      connect(andCondition_n.y, transistor_n.fire) annotation (Line(
          points={{60,-69},{60,-64},{16,-64},{16,-30},{18,-30}}, color={255,0,255}));
      annotation (defaultComponentName="inverter",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(
              points={{-100,-100},{100,100}},
              color={0,0,127}),
            Rectangle(
              extent={{-40,40},{40,-40}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-20,20},{-20,-20}},
              color={0,0,255}),
            Line(
              points={{-28,20},{-28,-20}},
              color={0,0,255}),
            Line(
              points={{-40,0},{-28,0}},
              color={0,0,255}),
            Line(
              points={{-20,4},{0,24},{0,40}},
              color={0,0,255}),
            Line(
              points={{-20,-4},{0,-24},{0,-40}},
              color={0,0,255}),
            Line(
              points={{-4,-20},{-10,-8},{-16,-14},{-4,-20}},
              color={0,0,255}),
            Line(
              points={{0,-24},{10,-24},{10,24},{0,24}},
              color={0,0,255}),
            Line(
              points={{0,8},{20,8}},
              color={0,0,255}),
            Line(
              points={{10,8},{0,-8},{20,-8},{10,8}},
              color={0,0,255}),
            Text(
              extent={{-100,70},{0,50}},
              textColor={0,0,127},
              textString="DC"),
            Text(
              extent={{0,-50},{100,-70}},
              textColor={0,0,127},
              textString="AC")}),
        Documentation(info="<html>
<p>
This is a polyphase two level inverter. The boolean signals <code>fire_p[k]</code> and <code>fire_n[k]</code> for any phase <code>k</code> shall not be <code>true</code> at the same time to avoid DC bus short circuits. The inverter consists of <code>2*m</code> transistors and two anti parallel free wheeling diodes, respectively, where <code>m</code> is the number of phases.
</p>
</html>"));
    end Polyphase2Level;
    annotation (Documentation(info="<html>
<p>
General information about DC/AC converters can be found at the
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.DCACConcept\">DC/AC converter concept</a>
</p>
</html>"));
  end DCAC;

  package DCDC "DC to DC converters"
    extends Modelica.Icons.Package;
    package Control "Control components for DC to DC converters"
      extends Modelica.Icons.Package;
      model SignalPWM
        "Generates a pulse width modulated (PWM) boolean fire signal"
        extends Icons.Control;
        parameter Boolean useConstantDutyCycle=true
          "Enables constant duty cycle";
        parameter Real constantDutyCycle=0 "Constant duty cycle"
          annotation (Dialog(enable=useConstantDutyCycle));
        parameter Modelica.SIunits.Frequency f=1000 "Switching frequency";
        parameter Modelica.SIunits.Time startTime=0 "Start time";
        Modelica.Blocks.Interfaces.RealInput dutyCycle if not
          useConstantDutyCycle "Duty cycle"
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.BooleanOutput fire "Firing PWM signal"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-60,110})));
        Modelica.Blocks.Interfaces.BooleanOutput notFire "Firing PWM signal"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={60,110})));
        Modelica.Blocks.Sources.Constant const(final k=constantDutyCycle) if
          useConstantDutyCycle
          annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
        Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0)
          annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
        Modelica.Blocks.Logical.Less greaterEqual annotation (Placement(
              transformation(
              extent={{-10,10},{10,-10}},
              origin={22,-8})));
        Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold(final startTime=
              startTime, final samplePeriod=1/f)
          annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
        Modelica.Blocks.Sources.SawTooth sawtooth(
          final period=1/f,
          final amplitude=1,
          final nperiod=-1,
          final offset=0,
          final startTime=startTime) annotation (Placement(transformation(
              origin={-50,-50},
              extent={{-10,-10},{10,10}})));
        Modelica.Blocks.Logical.Not inverse annotation (Placement(
              transformation(
              extent={{-10,10},{10,-10}},
              rotation=90,
              origin={52,20})));
      equation
        connect(const.y, limiter.u) annotation (Line(
            points={{-79,-50},{-70,-50},{-70,0},{-62,0}}, color={0,0,127}));
        connect(dutyCycle, limiter.u) annotation (Line(
            points={{-120,0},{-62,0}}, color={0,0,127}));
        connect(limiter.y, zeroOrderHold.u) annotation (Line(
            points={{-39,0},{-32,0}}, color={0,0,127}));
        connect(zeroOrderHold.y, greaterEqual.u2) annotation (Line(
            points={{-9,0},{10,0}}, color={0,0,127}));
        connect(sawtooth.y, greaterEqual.u1) annotation (Line(
            points={{-39,-50},{0,-50},{0,-8},{10,-8}}, color={0,0,127}));
        connect(greaterEqual.y, inverse.u) annotation (Line(
            points={{33,-8},{52,-8},{52,8}}, color={255,0,255}));
        connect(greaterEqual.y, fire) annotation (Line(
            points={{33,-8},{36,-8},{36,80},{-60,80},{-60,110}}, color={255,0,255}));
        connect(inverse.y, notFire) annotation (Line(
            points={{52,31},{52,80},{60,80},{60,110}}, color={255,0,255}));
        annotation (defaultComponentName="pwm",
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}),graphics={Line(
                      points={{-100,0},{-98,0},{12,0}},
                      color={0,0,255}),Line(
                      points={{-60,-22},{-60,-64},{44,-64},{44,-36}},
                      color={0,0,255}),Line(
                      points={{-80,-16},{-80,-20},{-40,20},{-40,-20},{-36,-16}},
                      color={0,0,255}),Line(
                      points={{-62,0},{-76,4},{-76,-4},{-62,0}},
                      color={0,0,255}),Line(
                      points={{44,-36},{44,-36},{40,-50},{44,-50},{48,-50},{44,
                  -36}},
                      color={0,0,255}),Line(
                      points={{20,-20},{22,-20},{24,-20},{24,20},{44,20},{44,-20},
                  {64,-20},{64,-16}},
                      color={255,0,255}),Line(
                      points={{-40,-16},{-40,-20},{0,20},{0,-20},{4,-16}},
                      color={0,0,255}),Line(
                      points={{60,-20},{62,-20},{64,-20},{64,20},{84,20},{84,-20},
                  {84,-20},{88,-20}},
                      color={255,0,255})}),
          Documentation(info="<html>
<p>
This controller can be used both for DC/DC and AC/DC converters.
The signal input of the PWM controller is the duty cycle; the duty cycle is the ratio of the on time
to the switching period. The output firing signal is strictly determined by the actual duty cycle, indicated as <code>d</code> in Fig.&nbsp;1.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1:</strong> Firing (<code>fire</code>) and inverse firing (<code>notFire</code>) signal of PWM control; <code>d</code> = duty cycle; <code>f</code> = switching frequency </caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/PowerConverters/dutyCycle.png\">
    </td>
  </tr>
</table>

<p>
The firing signal is generated by comparing the sampled duty cycle input with a periodic saw tooth signal [<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.References\">Williams2006</a>].
</p>
</html>"));
      end SignalPWM;

      block Voltage2DutyCycle "Linearly transforms voltage to duty cycle"
        parameter Boolean reciprocal = false
          "Enables reciprocal formula between voltage and duty cycle";
        parameter Boolean useBipolarVoltage = true
          "Enables bipolar input voltage range"
          annotation(Dialog(enable=not reciprocal));
        parameter Boolean useConstantVoltageLimit=true
          "Enables constant voltage limit";
        parameter Modelica.SIunits.Voltage VLim(final min=Modelica.Constants.small)
          "Voltage range limit mapped to dutyCycle = 1 resp. 0"
          annotation(Dialog(enable=useConstantVoltageLimit));
        Modelica.Blocks.Interfaces.RealInput v(unit = "V") "Voltage" annotation (Placement(
              transformation(extent={{-140,-20},{-100,20}}), iconTransformation(
                extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.RealOutput dutyCycle "Duty cycle" annotation (
            Placement(transformation(extent={{100,-10},{120,10}}), iconTransformation(
                extent={{100,-10},{120,10}})));
        Modelica.Blocks.Interfaces.RealInput vLim(unit = "V") if not useConstantVoltageLimit
          "Voltage limit" annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=270,
              origin={0,120}), iconTransformation(
              extent={{-20,-20},{20,20}},
              rotation=270,
              origin={0,120})));
        Modelica.Blocks.Sources.Constant vLimConst(final k=VLim) if useConstantVoltageLimit
          "Constant voltage limit"
          annotation (Placement(transformation(extent={{40,70},{20,90}})));
      protected
        Modelica.Blocks.Interfaces.RealInput vLimInt "Internal voltage limit"
          annotation (Placement(transformation(
              extent={{-4,-4},{4,4}},
              rotation=180,
              origin={0,80})));
      equation
        if not reciprocal then
          if not useBipolarVoltage then
            dutyCycle =max(min(v, vLimInt), 0)/vLimInt;
          else
            dutyCycle =(max(min(v, vLimInt), -vLimInt)/vLimInt + 1)/2;
          end if;
        else
          dutyCycle =1 - vLimInt/max(v, vLimInt);
        end if;
        connect(vLim, vLimInt) annotation (Line(points={{0,120},{0,80},{4.44089e-16,
                80}}, color={0,0,127}));
        connect(vLimInt, vLimConst.y) annotation (Line(points={{4.44089e-16,80},
                {19,80}}, color={0,0,127}));
        annotation (defaultComponentName="adaptor", Icon(graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{0,-60},{60,60}},
                pattern=LinePattern.Dash),
              Line(
                points={{-60,-60},{60,60}}),
              Polygon(
                points={{-78,-60},{-76,-60},{62,-60},{62,-54},{82,-60},{62,-66},{62,-60},
                    {62,-60},{-78,-60}},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{0,-80},{0,60},{-6,60},{0,80},{6,60},{0,60},{0,-80}},
                fillPattern=FillPattern.Solid), Text(extent={{
                    -150,-120},{150,-160}}, textString = "%name", textColor = {0, 0, 255})}),
          Documentation(info="<html>
<p>
Transforms the input voltage signal into a duty cycle:
<ul>
<li><code>reciprocal = false and useBipolarVoltage = false: v/VLim = dutyCycle</code></li>
<li><code>reciprocal = false and useBipolarVoltage = true : v/VLim = 2*dutyCycle - 1</code></li>
<li><code>reciprocal = true:                                v/VLim = 1/(1 - dutyCycle)</code></li>
</ul>
</p>
</html>"));
      end Voltage2DutyCycle;
      annotation (Documentation(info="<html>
<p>
Currently there is only one PWM method provided in this library.
</p>
</html>"));
    end Control;

    model ChopperStepDown "Step down chopper"
      import Modelica.Constants.pi;
      extends Icons.Converter;
      parameter Modelica.SIunits.Resistance RonTransistor=1e-05
        "Transistor closed resistance";
      parameter Modelica.SIunits.Conductance GoffTransistor=1e-05
        "Transistor opened conductance";
      parameter Modelica.SIunits.Voltage VkneeTransistor=0
        "Transistor threshold voltage";
      parameter Modelica.SIunits.Resistance RonDiode(final min=0) = 1e-05
        "Closed diode resistance";
      parameter Modelica.SIunits.Conductance GoffDiode(final min=0) = 1e-05
        "Opened diode conductance";
      parameter Modelica.SIunits.Voltage VkneeDiode(final min=0) = 0
        "Diode forward threshold voltage";
      extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin1;
      extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin2;
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
           293.15);
      extends Interfaces.Enable.Enable1;
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor transistor(
        useHeatPort=useHeatPort,
        Ron=RonTransistor,
        Goff=GoffTransistor,
        Vknee=VkneeTransistor) "Switching transistor" annotation (Placement(
            transformation(
            origin={0,60},
            extent={{-10,-10},{10,10}})));
      Modelica.Electrical.Analog.Ideal.IdealDiode diode(
        Ron=RonDiode,
        Goff=GoffDiode,
        Vknee=VkneeDiode,
        useHeatPort=useHeatPort) "Free wheeling diode" annotation (Placement(
            transformation(
            origin={40,0},
            extent={{-10,10},{10,-10}},
            rotation=90)));
    equation
      if not useHeatPort then
        LossPower = diode.LossPower + transistor.LossPower;
      end if;
      connect(diode.n, transistor.n) annotation (Line(
          points={{40,10},{40,60},{10,60}}, color={0,0,255}));
      connect(transistor.n, dc_p2) annotation (Line(
          points={{10,60},{100,60}}, color={0,0,255}));
      connect(transistor.heatPort, heatPort) annotation (Line(
          points={{0,50},{0,-100}}, color={191,0,0}));
      connect(diode.heatPort, heatPort) annotation (Line(
          points={{30,0},{0,0},{0,-100}}, color={191,0,0}));
      connect(dc_p1, transistor.p) annotation (Line(
          points={{-100,60},{-10,60}}, color={0,0,255}));
      connect(dc_n1, diode.p) annotation (Line(
          points={{-100,-60},{40,-60},{40,-10}}, color={0,0,255}));
      connect(dc_n1, dc_n2) annotation (Line(
          points={{-100,-60},{100,-60}}, color={0,0,255}));
      connect(andCondition_p.y, transistor.fire) annotation (Line(
          points={{-60,-69},{-60,80},{10,80},{10,72}},
                                                     color={255,0,255}));
      annotation (defaultComponentName="dcdc",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-100,70},{0,50}},
              textColor={0,0,127},
              textString="DC in"),
            Text(
              extent={{0,-50},{100,-70}},
              textColor={0,0,127},
              textString="DC out"),
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              textColor={0,0,255}),
            Rectangle(
              extent={{-40,40},{40,-40}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-30,20},{-30,0}}, color={217,67,180}),
            Line(points={{-40,30},{-30,20},{-20,30}}, color={0,0,255}),
            Polygon(
              points={{-20,30},{-26,26},{-24,24},{-20,30}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Polygon(points={{20,10},{10,-10},{30,-10},{20,10}}, lineColor={0,0,
                  255}),
            Line(points={{10,10},{30,10}}, color={0,0,255}),
            Line(points={{-20,30},{60,30}}, color={0,0,255}),
            Line(points={{-60,30},{-40,30}}, color={0,0,255}),
            Line(points={{-60,-30},{60,-30}}, color={0,0,255}),
            Line(points={{20,30},{20,-30}}, color={0,0,255}),
            Ellipse(extent={{-62,32},{-58,28}}, lineColor={0,0,255}),
            Ellipse(extent={{-62,-28},{-58,-32}}, lineColor={0,0,255}),
            Ellipse(extent={{18,-28},{22,-32}}, lineColor={0,0,255}),
            Ellipse(extent={{58,-28},{62,-32}}, lineColor={0,0,255}),
            Ellipse(extent={{58,32},{62,28}}, lineColor={0,0,255}),
            Ellipse(extent={{18,32},{22,28}}, lineColor={0,0,255}),
            Ellipse(extent={{-44,40},{-16,12}}, lineColor={0,0,255}),
            Line(points={{-40,20},{-20,20}}, color={0,0,255})}),
        Documentation(info="<html>
<p>
This is a conventional step down chopper (buck converter) model. It consists of a transistor and free wheeling diode.
</p>
</html>"));
    end ChopperStepDown;

    model ChopperStepUp "Step up chopper"
      import Modelica.Constants.pi;
      extends Icons.Converter;
      parameter Modelica.SIunits.Resistance RonTransistor=1e-05
        "Transistor closed resistance";
      parameter Modelica.SIunits.Conductance GoffTransistor=1e-05
        "Transistor opened conductance";
      parameter Modelica.SIunits.Voltage VkneeTransistor=0
        "Transistor threshold voltage";
      parameter Modelica.SIunits.Resistance RonDiode(final min=0) = 1e-05
        "Closed diode resistance";
      parameter Modelica.SIunits.Conductance GoffDiode(final min=0) = 1e-05
        "Opened diode conductance";
      parameter Modelica.SIunits.Voltage VkneeDiode(final min=0) = 0
        "Diode forward threshold voltage";
      extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin1;
      extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin2;
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
           293.15);
      extends Interfaces.Enable.Enable1;
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor transistor(
        useHeatPort=useHeatPort,
        Ron=RonTransistor,
        Goff=GoffTransistor,
        Vknee=VkneeTransistor) "Switching transistor" annotation (Placement(
            transformation(
            origin={-40,0},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.Electrical.Analog.Ideal.IdealDiode diode(
        Ron=RonDiode,
        Goff=GoffDiode,
        Vknee=VkneeDiode,
        useHeatPort=useHeatPort) "Free wheeling diode" annotation (Placement(
            transformation(
            origin={0,60},
            extent={{-10,-10},{10,10}})));
    equation
      if not useHeatPort then
        LossPower = diode.LossPower + transistor.LossPower;
      end if;
      connect(andCondition_p.y, transistor.fire) annotation (Line(points={{-60,
              -69},{-60,-10},{-52,-10}}, color={255,0,255}));
      connect(dc_p1, transistor.p) annotation (Line(points={{-100,60},{-40,60},
              {-40,10}}, color={0,0,255}));
      connect(dc_n1, transistor.n) annotation (Line(points={{-100,-60},{-40,-60},
              {-40,-10}}, color={0,0,255}));
      connect(dc_p1, diode.p)
        annotation (Line(points={{-100,60},{-10,60}}, color={0,0,255}));
      connect(diode.n, dc_p2)
        annotation (Line(points={{10,60},{100,60}}, color={0,0,255}));
      connect(dc_n1, dc_n2)
        annotation (Line(points={{-100,-60},{100,-60}}, color={0,0,255}));
      connect(transistor.heatPort, heatPort) annotation (Line(points={{-30,
              -4.44089e-16},{-16,-4.44089e-16},{-16,0},{0,0},{0,-100}}, color={
              191,0,0}));
      connect(heatPort, diode.heatPort)
        annotation (Line(points={{0,-100},{0,50}}, color={191,0,0}));
      annotation (defaultComponentName="dcdc",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-100,70},{0,50}},
              textColor={0,0,127},
              textString="DC in"),
            Text(
              extent={{0,-50},{100,-70}},
              textColor={0,0,127},
              textString="DC out"),
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              textColor={0,0,255}),
            Rectangle(
              extent={{-40,40},{40,-40}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(extent={{-62,32},{-58,28}}, lineColor={0,0,255}),
            Ellipse(extent={{-38,14},{-10,-14}},lineColor={0,0,255}),
            Line(points={{-60,30},{60,30}}, color={0,0,255}),
            Ellipse(extent={{-22,32},{-18,28}},
                                              lineColor={0,0,255}),
            Line(points={{0,10},{0,-10}},   color={217,67,180},
              origin={-40,0},
              rotation=90),
            Line(points={{-20,30},{-20,10}},color={0,0,255}),
            Line(points={{-10,0},{10,0}},  color={0,0,255},
              origin={30,30},
              rotation=270),
            Polygon(points={{0,10},{-10,-10},{10,-10},{0,10}},  lineColor={0,0,
                  255},
              origin={20,30},
              rotation=270),
            Ellipse(extent={{58,-28},{62,-32}}, lineColor={0,0,255}),
            Line(points={{-60,-30},{60,-30}}, color={0,0,255}),
            Ellipse(extent={{58,32},{62,28}}, lineColor={0,0,255}),
            Ellipse(extent={{-22,-28},{-18,-32}},
                                                lineColor={0,0,255}),
            Ellipse(extent={{-62,-28},{-58,-32}}, lineColor={0,0,255}),
            Polygon(
              points={{3,3},{-3,-1},{-1,-3},{3,3}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              origin={-23,-7},
              rotation=270),
            Line(points={{-10,0},{10,0}},    color={0,0,255},
              origin={-30,0},
              rotation=90),
            Line(points={{-20,10},{-30,0},{-20,-10}}, color={28,108,200}),
            Line(points={{-20,-10},{-20,-30}},
                                            color={0,0,255})}),
        Documentation(info="<html>
<p>
This is a conventional step up chopper (boost converter) model. It consists of a transistor and free wheeling diode.
</p>
</html>"));
    end ChopperStepUp;

    model HBridge "H bridge (four quadrant converter)"
      extends Icons.Converter;
      extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin1;
      extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin2;
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
           293.15);
      parameter Modelica.SIunits.Resistance RonTransistor=1e-05
        "Transistor closed resistance";
      parameter Modelica.SIunits.Conductance GoffTransistor=1e-05
        "Transistor opened conductance";
      parameter Modelica.SIunits.Voltage VkneeTransistor=0
        "Transistor threshold voltage";
      parameter Modelica.SIunits.Resistance RonDiode=1e-05
        "Diode closed resistance";
      parameter Modelica.SIunits.Conductance GoffDiode=1e-05
        "Diode opened conductance";
      parameter Modelica.SIunits.Voltage VkneeDiode=0 "Diode threshold voltage";
      extends Interfaces.Enable.Enable2;
      DCAC.SinglePhase2Level inverter_p(
        final RonTransistor=RonTransistor,
        final GoffTransistor=GoffTransistor,
        final VkneeTransistor=VkneeTransistor,
        final RonDiode=RonDiode,
        final GoffDiode=GoffDiode,
        final VkneeDiode=VkneeDiode,
        final useHeatPort=useHeatPort)
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      DCAC.SinglePhase2Level inverter_n(
        final RonTransistor=RonTransistor,
        final GoffTransistor=GoffTransistor,
        final VkneeTransistor=VkneeTransistor,
        final RonDiode=RonDiode,
        final GoffDiode=GoffDiode,
        final VkneeDiode=VkneeDiode,
        final useHeatPort=useHeatPort)
        annotation (Placement(transformation(extent={{-58,-40},{-38,-20}})));
      Modelica.Blocks.Interfaces.BooleanInput fire_p
        "Firing signals of positive potential leg" annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-60,-120})));
      Modelica.Blocks.Interfaces.BooleanInput fire_n
        "Firing signals of negative potential leg" annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={60,-120})));
    equation
      if not useHeatPort then
        LossPower = inverter_p.LossPower + inverter_n.LossPower;
      end if;
      connect(inverter_n.heatPort, heatPort) annotation (Line(
          points={{-48,-40},{-48,-70},{-10,-70},{-10,-100},{0,-100}}, color={191,0,0}));
      connect(inverter_p.heatPort, heatPort) annotation (Line(
          points={{-10,20},{-10,-100},{0,-100}}, color={191,0,0}));
      connect(dc_p1, inverter_p.dc_p) annotation (Line(
          points={{-100,60},{-70,60},{-70,36},{-20,36}}, color={0,0,255}));
      connect(dc_p1, inverter_n.dc_p) annotation (Line(
          points={{-100,60},{-70,60},{-70,-24},{-58,-24}}, color={0,0,255}));
      connect(dc_n1, inverter_n.dc_n) annotation (Line(
          points={{-100,-60},{-80,-60},{-80,-36},{-58,-36}}, color={0,0,255}));
      connect(dc_n1, inverter_p.dc_n) annotation (Line(
          points={{-100,-60},{-80,-60},{-80,24},{-20,24}}, color={0,0,255}));
      connect(inverter_p.ac, dc_p2) annotation (Line(
          points={{0,30},{100,30},{100,60}}, color={0,0,255}));
      connect(inverter_n.ac, dc_n2) annotation (Line(
          points={{-38,-30},{100,-30},{100,-60}}, color={0,0,255}));
      connect(andCondition_n.y, inverter_p.fire_n) annotation (Line(
          points={{60,-69},{60,-50},{-4,-50},{-4,18}}, color={255,0,255}));
      connect(andCondition_n.y, inverter_n.fire_p) annotation (Line(
          points={{60,-69},{60,-50},{-54,-50},{-54,-42}}, color={255,0,255}));
      connect(andCondition_p.y, inverter_n.fire_n) annotation (Line(
          points={{-60,-69},{-60,-60},{-42,-60},{-42,-42}}, color={255,0,255}));
      connect(andCondition_p.y, inverter_p.fire_p) annotation (Line(
          points={{-60,-69},{-60,-60},{-16,-60},{-16,18}}, color={255,0,255}));
      annotation (defaultComponentName="dcdc",
        Icon(graphics={
            Rectangle(
              extent={{-40,40},{40,-40}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{0,-50},{100,-70}},
              textColor={0,0,127},
              textString="DC out"),
            Text(
              extent={{-100,70},{0,50}},
              textColor={0,0,127},
              textString="DC in"),
            Line(
              points={{-40,0},{-28,0}},
              color={0,0,255}),
            Line(
              points={{-28,20},{-28,-20}},
              color={0,0,255}),
            Line(
              points={{-20,20},{-20,-20}},
              color={0,0,255}),
            Line(
              points={{-20,4},{0,24},{0,40}},
              color={0,0,255}),
            Line(
              points={{-20,-4},{0,-24},{0,-40}},
              color={0,0,255}),
            Line(
              points={{-4,-20},{-10,-8},{-16,-14},{-4,-20}},
              color={0,0,255}),
            Line(
              points={{0,-24},{10,-24},{10,24},{0,24}},
              color={0,0,255}),
            Line(
              points={{0,8},{20,8}},
              color={0,0,255}),
            Line(
              points={{10,8},{0,-8},{20,-8},{10,8}},
              color={0,0,255})}),
        Documentation(info="<html>
<p>
The H bridge is a four quadrant DC/DC converter. It consists of two single-phase DC/AC converters which are controlled differently; see Fig.&nbsp;1.</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1:</strong> H bridge</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/PowerConverters/Hbridge.png\">
    </td>
  </tr>
</table>

<p>If the firing inputs <code>fire_p</code> and <code>fire_n</code> are inverse, the two legs are controlled symmetrically so that full positive or negative output voltage can be generated. See examples
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.DCDC.HBridge\">DCDC.HBridge</a>.
</p>
</html>"));
    end HBridge;
    annotation (Documentation(info="<html>
<p>
General information about DC/DC converters can be found at the
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.DCDCConcept\">DC/DC converter concept</a>
</p>
</html>"));
  end DCDC;

  package ACAC "AC to AC converters"
    extends Modelica.Icons.Package;

    package Control "Control components for AC to AC converters"
      extends Modelica.Icons.Package;
      block VoltageToAngle "Reference voltage to firing angle converter"
        extends Modelica.Blocks.Icons.Block;
        import Modelica.Constants.pi;
        parameter Modelica.SIunits.Voltage VNominal "Nominal voltage";
        parameter Modelica.Electrical.PowerConverters.Types.Voltage2AngleType voltage2Angle=
            Modelica.Electrical.PowerConverters.Types.Voltage2AngleType.Lin
          "Select type of calculation";
        Modelica.Blocks.Interfaces.RealInput vRef "Reference voltage"
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.RealOutput firingAngle(
          unit="rad",
          displayUnit="deg",
          min=0,
          max=pi,
          start=pi) "Firing angle"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Math.Gain gain_v(final k=1/VNominal)
          annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
        Modelica.Blocks.Nonlinear.Limiter limiter(final uMax=1, final uMin=0)
          annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
        Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(final table=
          if voltage2Angle == Modelica.Electrical.PowerConverters.Types.Voltage2AngleType.Lin then Lin
          elseif voltage2Angle == Modelica.Electrical.PowerConverters.Types.Voltage2AngleType.H01 then H01
          else RMS, final extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
          annotation (Placement(transformation(extent={{0,-10},{20,10}})));
        Modelica.Blocks.Math.Gain gain_alpha(final k=pi)
          annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      protected
        constant Real Lin[:,2]=[0,1; 1,0];
        constant Real H01[:,2]=[0,1;
          7.85377E-05,0.995; 0.000314125,0.99; 0.000706684,0.985; 0.001256086,0.98;
          0.00196215,0.975; 0.007832473,0.95; 0.017562721,0.925; 0.031072921,0.9;
          0.048252035,0.875; 0.068958879,0.85; 0.093023287,0.825; 0.120247535,0.8;
          0.150407987,0.775; 0.183256979,0.75; 0.218524917,0.725; 0.255922582,0.7;
          0.295143624,0.675; 0.33586724,0.65; 0.377761016,0.625; 0.420483922,0.6;
          0.463689446,0.575; 0.507028849,0.55; 0.550154538,0.525; 0.592723531,0.5;
          0.634401018,0.475; 0.674864,0.45; 0.713804992,0.425; 0.750935807,0.4;
          0.785991389,0.375; 0.818733724,0.35; 0.848955796,0.325; 0.87648563,0.3;
          0.901190381,0.275; 0.922980502,0.25; 0.941813955,0.225; 0.957700455,0.2;
          0.97070568,0.175; 0.980955368,0.15; 0.988639134,0.125; 0.994013774,0.1;
          0.997405692,0.075; 0.999211945,0.05; 0.999899238,0.025; 0.999948191,0.02;
          0.999978053,0.015; 0.999993471,0.01; 0.999999181,0.005; 1,0];
        constant Real RMS[:,2]=[0,1;
          0.000906877,0.995; 0.002564847,0.99; 0.004711343,0.985; 0.007252334,0.98;
          0.010133194,0.975; 0.028608003,0.95; 0.052394349,0.925; 0.080318563,0.9;
          0.111626433,0.875; 0.14574274,0.85; 0.182186463,0.825; 0.22053266,0.8;
          0.260393008,0.775; 0.301405137,0.75; 0.343226628,0.725; 0.385531651,0.7;
          0.428009237,0.675; 0.470362569,0.65; 0.51230895,0.625; 0.553580231,0.6;
          0.593923537,0.575; 0.633102218,0.55; 0.670896923,0.525; 0.707106781,0.5;
          0.741550618,0.475; 0.774068203,0.45; 0.804521493,0.425; 0.83279585,0.4;
          0.858801222,0.375; 0.882473259,0.35; 0.903774359,0.325; 0.922694611,0.3;
          0.939252619,0.275; 0.953496168,0.25; 0.965502709,0.225; 0.975379591,0.2;
          0.983263999,0.175; 0.989322523,0.15; 0.99375024,0.125; 0.996769245,0.1;
          0.998626473,0.075; 0.999590707,0.05; 0.999948658,0.025; 0.999973701,0.02;
          0.999988902,0.015; 0.999996711,0.01; 0.999999589,0.005; 1,0];
      equation
        connect(limiter.y, combiTable1Ds.u)
          annotation (Line(points={{-19,0},{-2,0}}, color={0,0,127}));
        connect(vRef, gain_v.u)
          annotation (Line(points={{-120,0},{-82,0}}, color={0,0,127}));
        connect(gain_alpha.y, firingAngle)
          annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
        connect(combiTable1Ds.y[1], gain_alpha.u)
          annotation (Line(points={{21,0},{38,0}}, color={0,0,127}));
        connect(gain_v.y, limiter.u)
          annotation (Line(points={{-59,0},{-42,0}}, color={0,0,127}));
        annotation (Documentation(info="<html>
<p>
This block calculates firing angle from desired voltage, 
choosing either a linear (<code>Lin</code>) relationship or prescribing the first harmonic (<code>H01</code>)  or the root mean square (<code>RMS</code>) . 
Since calculating the firing angle from both the H01 and the RMS involves a nonlinear equation, 
both relationships have been precalculated and are interpolated from a table.
</p>
</html>"),       Icon(coordinateSystem(grid={2,2}),
                      graphics={
              Line(points={{-55.1,66.4},{-49.4,74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,
                    76.6},{-26.9,69.7},{-21.3,59.4},{-14.9,44.1},{-6.83,21.2},{0,0}},
                                                                  smooth = Smooth.Bezier),
              Line(points={{-80,0},{80,0}}, color={28,108,200}),
              Line(points={{-55,66},{-55,0},{-80,0}}, color={0,0,0}),
              Line(points={{26,-68},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},{57.5,
                    -61.9},{63.9,-47.2},{72,-24.8},{80,0}},       smooth = Smooth.Bezier),
              Line(points={{0,0},{26,0},{26,-68}}, color={0,0,0})}),
          Diagram(coordinateSystem(grid={2,2})));
      end VoltageToAngle;

      block SoftStartControl
        extends Modelica.Blocks.Icons.Block;
        import ModeOfOperation =
          Modelica.Electrical.PowerConverters.Types.SoftStarterModeOfOperation;
        parameter Modelica.SIunits.Time tRampUp "Start ramp duration";
        parameter Real vStart=0 "Start voltage / nominal voltage";
        parameter Real iMax "Maximum current / Nominal current";
        parameter Real iMin=0.9*iMax "Lower threshold of current control";
        parameter Modelica.SIunits.Current INominal "Nominal current";
      parameter Modelica.SIunits.Time tRampDown "Stop ramp duration";
        Modelica.Blocks.Interfaces.RealInput iRMS(unit="A") "Measured RMS current"
          annotation (Placement(
              transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.RealOutput vRef(min=0, max=1, start=0) "Reference voltage"
          annotation (Placement(
              transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Interfaces.BooleanInput start annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-120})));
      protected
        Modelica.Electrical.PowerConverters.Types.SoftStarterModeOfOperation modeOfOperation;
        Real i=iRMS/INominal "Measured current";
        Boolean limit "Indicates current limitation";
      initial equation
        if start then
          if vRef<1 then
            modeOfOperation=ModeOfOperation.Up;
          else
            modeOfOperation=ModeOfOperation.On;
          end if;
        else
          if vRef>0 then
            modeOfOperation=ModeOfOperation.Down;
          else
            modeOfOperation=ModeOfOperation.Off;
          end if;
        end if;
        limit = i>=iMax;
      equation
        assert(iMax>iMin, "iMax has to be greater than iMin");
        when start then
          modeOfOperation = ModeOfOperation.Up;
        elsewhen vRef>=1 then
          modeOfOperation = ModeOfOperation.On;
        elsewhen not start then
          modeOfOperation = ModeOfOperation.Down;
        elsewhen vRef<=0 then
          modeOfOperation = ModeOfOperation.Off;
        end when;
        when start and vRef<vStart then
          reinit(vRef, vStart);
        end when;
        when i>=iMax then
          limit=true;
        elsewhen i<=iMin then
          limit=false;
        end when;
        if modeOfOperation==ModeOfOperation.Up and not limit then
          der(vRef) = (1 - vStart)/tRampUp;
        elseif modeOfOperation==ModeOfOperation.Down  and not limit then
          der(vRef) = -1/tRampDown;
        else
          der(vRef) = 0;
        end if;
        annotation (Documentation(info="<html>
<p>
This block models the functionality of a soft starter controller, controlling the output <code>vRef</code> in the range [0,1] with respect to nominal voltage.
</p>
<p>
Boolean input <code>start = true</code> causes the output <code>vRef</code> to be risen according to a ramp: <code>vRef = vStart + (1 - vStart)*(time - t0)/tRampUp</code>.
</p>
<p> 
In case the current exceeds the specified maximum current <code>iMax</code> during the starting ramp, the ramp is stopped. 
When the current falls below the lower threshold of current control <code>iMin &lt; iMax</code>, the ramp is continued. 
</p>
<p>
Note: It is recommended to filter the measured current, e.g. using <a href=\"modelica://Modelica.Blocks.Continuous.Filter\">Modelica.Blocks.Continuous.Filter</a>
</p>
<p>
Boolean input <code>start = false</code> causes the output <code>vRef</code> to be lowered according to a ramp: <code>vRef = -(time - t0)/tRampDown</code>. 
</p>
</html>"),       Icon(graphics={
              Polygon(
                points={{-12,20},{-12,-4},{12,8},{-12,20}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-12,20},{-12,-20}}, color={0,0,255}),
              Line(points={{12,20},{12,-20}}, color={0,0,255}),
              Polygon(
                points={{-12,12},{-12,-12},{12,0},{-12,12}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                origin={0,-8},
                rotation=180),
              Line(points={{-40,0},{-12,0}}, color={0,0,255}),
              Line(points={{12,0},{40,0}}, color={0,0,255}),
              Polygon(
                points={{-12,80},{-12,56},{12,68},{-12,80}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-12,80},{-12,40}}, color={0,0,255}),
              Line(points={{12,80},{12,40}}, color={0,0,255}),
              Polygon(
                points={{-12,12},{-12,-12},{12,0},{-12,12}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                origin={0,52},
                rotation=180),
              Line(points={{-40,60},{-12,60}}, color={0,0,255}),
              Line(points={{12,60},{40,60}}, color={0,0,255}),
              Polygon(
                points={{-12,-40},{-12,-64},{12,-52},{-12,-40}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-12,-40},{-12,-80}}, color={0,0,255}),
              Line(points={{12,-40},{12,-80}}, color={0,0,255}),
              Polygon(
                points={{-12,12},{-12,-12},{12,0},{-12,12}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                origin={0,-68},
                rotation=180),
              Line(points={{-40,-60},{-12,-60}}, color={0,0,255}),
              Line(points={{12,-60},{40,-60}}, color={0,0,255})}));
      end SoftStartControl;
    end Control;

    model SinglePhaseTriac "Triode for alternating current"
      extends Modelica.Electrical.Analog.Interfaces.TwoPin;
      Modelica.SIunits.Current i=p.i "Current flowing from pin p to pin n";
      parameter Modelica.SIunits.Resistance Ron(final min=0)=1e-5
        "Forward state-on differential resistance (closed resistance)";
      parameter Modelica.SIunits.Conductance Goff(final min=0)=1e-5
        "Backward state-off conductance (opened conductance)";
      parameter Modelica.SIunits.Voltage Vknee(final min=0)=0 "Forward threshold voltage";
      parameter Boolean useHeatPort = false "= true, if heatPort is enabled"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Modelica.SIunits.Temperature T=293.15
        "Fixed device temperature if useHeatPort = false"
        annotation(Dialog(enable=not useHeatPort));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort
        "Conditional heat port"
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
            iconTransformation(extent={{-10,-110},{10,-90}})));
      Modelica.Blocks.Interfaces.BooleanInput fire1 annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-60,-120})));
      Modelica.Blocks.Interfaces.BooleanInput fire2 annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={60,-120})));
      Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor1(
        final Ron=Ron,
        final Goff=Goff,
        final Vknee=Vknee,
        final useHeatPort=useHeatPort,
        final T=T,
        off(fixed=true))
        annotation (Placement(transformation(extent={{-10,30},{10,50}})));
      Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor2(
        final Ron=Ron,
        final Goff=Goff,
        final Vknee=Vknee,
        final useHeatPort=useHeatPort,
        final T=T,
        off(fixed=true)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={0,-40})));
    equation
      connect(fire1, thyristor1.fire) annotation (Line(points={{-60,-120},{-60,60},{
              10,60},{10,52}}, color={255,0,255}));
      connect(fire2, thyristor2.fire) annotation (Line(points={{60,-120},{60,-60},{-10,
              -60},{-10,-52}}, color={255,0,255}));
      connect(thyristor1.heatPort, heatPort) annotation (Line(points={{0,30},{-20,30},
              {-20,-80},{0,-80},{0,-100}}, color={191,0,0}));
      connect(heatPort, thyristor2.heatPort) annotation (Line(points={{0,-100},{0,-80},
              {20,-80},{20,-30},{0,-30}}, color={191,0,0}));
      connect(p, thyristor1.p)
        annotation (Line(points={{-100,0},{-10,0},{-10,40}}, color={0,0,255}));
      connect(p, thyristor2.n)
        annotation (Line(points={{-100,0},{-10,0},{-10,-40}}, color={0,0,255}));
      connect(n, thyristor1.n)
        annotation (Line(points={{100,0},{10,0},{10,40}}, color={0,0,255}));
      connect(n, thyristor2.p)
        annotation (Line(points={{100,0},{10,0},{10,-40}}, color={0,0,255}));
      annotation (defaultComponentName="triac",
        Icon(graphics={
            Text(
              extent={{-150,110},{150,70}},
              textString="%name",
              textColor={0,0,255}),
            Line(points={{-40,70},{-40,-70}}, color={0,0,255}),
            Line(points={{40,70},{40,-72}}, color={0,0,255}),
            Polygon(points={{-40,70},{40,30},{-40,-10},{-40,70}},lineColor={0,0,
                  255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(points={{40,8},{-40,-32},{40,-72},{40,8}},   lineColor={0,0,
                  255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-40,0},{-90,0}}, color={0,0,255}),
            Line(points={{90,0},{40,0}}, color={0,0,255}),
            Line(points={{-60,-100},{-60,-10},{-40,0}}, color={0,0,255}),
            Line(points={{60,-100},{60,-10},{40,0}}, color={0,0,255}),
            Line(
              points={{-10,-5},{10,5},{10,5}},
              color={0,0,255},
              origin={50,-3},
              rotation=180),
            Line(
              points={{-10,-5},{10,5},{10,5}},
              color={0,0,255},
              origin={50,-7},
              rotation=180),
            Line(
              points={{-10,5},{10,-5},{10,-5}},
              color={0,0,255},
              origin={-50,-7},
              rotation=180),
            Line(
              points={{-10,5},{10,-5},{10,-5}},
              color={0,0,255},
              origin={-50,-3},
              rotation=180)}),
          Documentation(info="<html>
<p>
Simplified model of a triode for alternating current, built from two antiparallel thyristors. 
<code>thyristor1</code> has to be fired during the positive halfwave of the voltage. 
<code>thyristor2</code> has to be fired during the negative halfwave of the voltage. 
</p>
<p>
Note: A real triac is fired in positive direction (<code>thyristor1</code>) by a positive gate current and in negative direction (<code>thyristor2</code>) by a negative gate current. 
The triac goes in blocking condition when the current falls to zero. 
</p>
<p>
This behaviour is simulated by the two firing gates <code>fire1</code> and <code>fire2</code>:
<ul>
<li><code>fire1=false</code> and <code>fire2=false</code>: gate current = 0, stay in blocking condition</li>
<li><code>fire1=true </code> and <code>fire2=false</code>: gate current &gt; 0, fire <code>thyristor1</code></li>
<li><code>fire1=false</code> and <code>fire2=true </code>: gate current &lt; 0, fire <code>thyristor2</code></li>
<li><code>fire1=true </code> and <code>fire2=true </code>: forbidden</li>
</ul>
</p>
</p>
</html>"));
    end SinglePhaseTriac;

    model PolyphaseTriac "Triodes for alternating current"
      extends Modelica.Electrical.MultiPhase.Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Ron(final min=0)=1e-5
        "Forward state-on differential resistance (closed resistance)";
      parameter Modelica.SIunits.Conductance Goff(final min=0)=1e-5
        "Backward state-off conductance (opened conductance)";
      parameter Modelica.SIunits.Voltage Vknee(final min=0)=0 "Forward threshold voltage";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m);
      Modelica.Blocks.Interfaces.BooleanInput fire1[m] annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-60,-120})));
      Modelica.Blocks.Interfaces.BooleanInput fire2[m] annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={60,-120})));
      Modelica.Electrical.MultiPhase.Basic.PlugToPins_p plugToPins_p(final m=m)
        annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
      Modelica.Electrical.MultiPhase.Basic.PlugToPins_n plugToPins_n(final m=m)
        annotation (Placement(transformation(extent={{90,-10},{70,10}})));
      SinglePhaseTriac triac[m](each useHeatPort=useHeatPort)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(plug_p, plugToPins_p.plug_p)
        annotation (Line(points={{-100,0},{-82,0}}, color={0,0,255}));
      connect(plugToPins_n.plug_n, plug_n)
        annotation (Line(points={{82,0},{100,0}},               color={0,0,255}));
      connect(triac.heatPort, heatPort)
        annotation (Line(points={{0,-10},{0,-100}}, color={191,0,0}));
      connect(fire1, triac.fire1) annotation (Line(points={{-60,-120},{-60,-20},{-6,
              -20},{-6,-12}}, color={255,0,255}));
      connect(fire2, triac.fire2) annotation (Line(points={{60,-120},{60,-20},{6,-20},
              {6,-12}}, color={255,0,255}));
      connect(plugToPins_p.pin_p, triac.p)
        annotation (Line(points={{-78,0},{-10,0}}, color={0,0,255}));
      connect(triac.n, plugToPins_n.pin_n)
        annotation (Line(points={{10,0},{78,0}}, color={0,0,255}));
      annotation (defaultComponentName="triac",
        Icon(graphics={
            Text(
              extent={{-150,110},{150,70}},
              textString="%name",
              textColor={0,0,255}),
            Line(points={{-40,70},{-40,-70}}, color={0,0,255}),
            Line(points={{40,70},{40,-72}}, color={0,0,255}),
            Polygon(points={{-40,70},{40,30},{-40,-10},{-40,70}},lineColor={0,0,
                  255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(points={{40,8},{-40,-32},{40,-72},{40,8}},   lineColor={0,0,
                  255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-40,0},{-90,0}}, color={0,0,255}),
            Line(points={{90,0},{40,0}}, color={0,0,255}),
            Line(points={{-60,-100},{-60,-10},{-40,0}}, color={0,0,255}),
            Line(points={{60,-100},{60,-10},{40,0}}, color={0,0,255}),
            Line(
              points={{-10,-5},{10,5},{10,5}},
              color={0,0,255},
              origin={50,-3},
              rotation=180),
            Line(
              points={{-10,-5},{10,5},{10,5}},
              color={0,0,255},
              origin={50,-7},
              rotation=180),
            Line(
              points={{-10,5},{10,-5},{10,-5}},
              color={0,0,255},
              origin={-50,-7},
              rotation=180),
            Line(
              points={{-10,5},{10,-5},{10,-5}},
              color={0,0,255},
              origin={-50,-3},
              rotation=180)}),
          Documentation(info="<html>
<p>
Simplified model of <code>m</code> 
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.SinglePhaseTriac\">triodes for alternating current</a>, each built from two antiparallel thyristors. 
<code>thyristor1</code> has to be fired during the positive halfwave of the voltage. 
<code>thyristor2</code> has to be fired during the negative halfwave of the voltage. 
</p>
<p>
Note: A real triac is fired in positive direction (<code>thyristor1</code>) by a positive gate current and in negative direction (<code>thyristor2</code>) by a negative gate current. 
The triac goes in blocking condition when the current falls to zero. 
</p>
<p>
This behaviour is simulated by the two firing gates <code>fire1</code> and <code>fire2</code>:
<ul>
<li><code>fire1=false</code> and <code>fire2=false</code>: gate current = 0, stay in blocking condition</li>
<li><code>fire1=true </code> and <code>fire2=false</code>: gate current &gt; 0, fire <code>thyristor1</code></li>
<li><code>fire1=false</code> and <code>fire2=true</code>: gate current &lt; 0, fire <code>thyristor2</code></li>
<li><code>fire1=true </code> and <code>fire2=true</code>: forbidden</li>
</ul>
</p>
</p>
</html>"));
    end PolyphaseTriac;
  end ACAC;

  package Enable "Enabling models"
    extends Modelica.Icons.Package;
    model EnableLogic
      "Partial model providing enable parameter and optional enable input"
      parameter Boolean useConstantEnable=true
        "Disable boolean input and use constantEnable, if true";
      parameter Boolean constantEnable=true
        "Constant enabling of firing signals"
        annotation (Dialog(enable=useConstantEnable));
      parameter Integer m(final min=1) = 3 "Number of phases";
      Modelica.Blocks.Sources.BooleanConstant enableConstantSource(final k=
            constantEnable) if useConstantEnable
        "Constant enable signal of fire and notFire" annotation (Placement(
            transformation(
            extent={{-10,10.5},{10,-10.5}},
            rotation=180,
            origin={69.5,0})));
      Modelica.Blocks.Interfaces.BooleanInput enable if not useConstantEnable
        "Enables fire and notFire" annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={100,-120})));
      Modelica.Blocks.Routing.BooleanReplicator booleanReplicator(final nout=m)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}})));
      Modelica.Blocks.Interfaces.BooleanOutput internalEnable[m]
        "m replicated enable signals" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-110,0})));
    equation
      connect(internalEnable, booleanReplicator.y) annotation (Line(
          points={{-110,0},{-11,0}}, color={255,0,255}));
      connect(enable, booleanReplicator.u) annotation (Line(
          points={{100,-120},{100,-80},{40,-80},{40,-40},{40,0},{26,
              0},{12,0}}, color={255,0,255}));
      connect(enableConstantSource.y, booleanReplicator.u) annotation (Line(
          points={{58.5,0},{12,0}}, color={255,0,255}));
      annotation (defaultComponentName="enable",
        Documentation(info="<html>
<p>This model provides an internal enable signal derived either from a parameter or an optional signal input.
For <code>useConstantEnable = true</code> the internal signal <code>internalEnable</code> is equal to the parameter <code>constantEnable</code>.
For <code>useConstantEnable = false</code> the internal signal
<code>internalEnable</code> is equal to the external signal input <code>enable</code>.</p>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-58,60},{58,-60}},
              textColor={255,0,255},
              textString="enable")}));
    end EnableLogic;
  end Enable;

  package Interfaces "Interfaces"
    extends Modelica.Icons.InterfacesPackage;
    package ACDC "AC to DC converter interfaces"
      partial model ACtwoPin "Positive and negative AC pin"

        Modelica.Electrical.Analog.Interfaces.PositivePin ac_p
          "Positive AC input"
          annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin ac_n
          "Negative AC input"
          annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
        Modelica.SIunits.Voltage vAC=ac_p.v - ac_n.v "AC voltages";
        Modelica.SIunits.Current iAC=ac_p.i "AC currents";
        Modelica.SIunits.Power powerAC=vAC*iAC "AC power";
      end ACtwoPin;
      extends Modelica.Icons.InterfacesPackage;
      partial model ACplug "AC polyphase plug"
        parameter Integer m(final min=3) = 3 "Number of phases";
        Modelica.Electrical.Polyphase.Interfaces.PositivePlug ac(final m=m)
          "AC input"
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.SIunits.Voltage vAC[m]=ac.pin[:].v "AC potentials";
        Modelica.SIunits.Current iAC[m]=ac.pin[:].i "AC currents";
        Modelica.SIunits.Power powerAC[m]=vAC.*iAC "AC power";
        Modelica.SIunits.Power powerTotalAC=sum(powerAC) "AC total power";
      end ACplug;

      partial model ACtwoPlug "Two AC polyphase plugs"
        parameter Integer m(final min=3) = 3 "Number of phases";
        Modelica.Electrical.Polyphase.Interfaces.PositivePlug ac_p(final m=m)
          "Positive potential AC input"
          annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
        Modelica.Electrical.Polyphase.Interfaces.NegativePlug ac_n(final m=m)
          "Negative potential AC input"
          annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
        Modelica.SIunits.Voltage vAC[m]=ac_p.pin[:].v - ac_n.pin[:].v "AC voltages";
        Modelica.SIunits.Current iAC[m]=ac_p.pin[:].i "AC currents";
        Modelica.SIunits.Power powerAC[m]=vAC.*iAC "AC power";
        Modelica.SIunits.Power powerTotalAC=sum(powerAC) "AC total power";
      end ACtwoPlug;

      partial model DCtwoPin "Positive and negative DC pins"

        Modelica.Electrical.Analog.Interfaces.PositivePin dc_p
          "Positive DC output"
          annotation (Placement(transformation(extent={{90,50},{110,70}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin dc_n
          "Negative DC output"
          annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
        Modelica.SIunits.Voltage vDC=dc_p.v-dc_n.v "DC voltage";
        Modelica.SIunits.Current iDC=dc_p.i "DC current";
        Modelica.SIunits.Power powerDC=vDC*iDC "DC power";
      end DCtwoPin;

      partial model DCpin "Single DC pin"

        Modelica.Electrical.Analog.Interfaces.PositivePin dc_p
          "Positive DC output"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.SIunits.Voltage vDC=dc_p.v "DC potential";
        Modelica.SIunits.Current iDC=dc_p.i "DC current";
        Modelica.SIunits.Power powerDC=vDC*iDC "DC power";
      end DCpin;
    end ACDC;

    package DCAC "DC to AC converter interfaces"
      partial model DCtwoPin "Positive and negative DC pins"

        Modelica.Electrical.Analog.Interfaces.PositivePin dc_p
          "Positive DC input"
          annotation (Placement(transformation(extent={{-110,70},{-90,50}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin dc_n
          "Negative DC input"
          annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
        Modelica.SIunits.Voltage vDC=dc_p.v - dc_n.v "DC voltage";
        Modelica.SIunits.Current iDC=dc_p.i "DC current";
        Modelica.SIunits.Power powerDC=vDC*iDC "DC power";
      end DCtwoPin;
      extends Modelica.Icons.InterfacesPackage;
      partial model ACpin "Single AC pin"

        Modelica.Electrical.Analog.Interfaces.PositivePin ac "AC output"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.SIunits.Voltage vAC=ac.v "AC potential";
        Modelica.SIunits.Current iAC=ac.i "AC current";
        Modelica.SIunits.Power powerAC=vAC*iAC "AC power";
      end ACpin;

      partial model ACplug "AC polyphase plug"
        parameter Integer m(final min=3) = 3 "Number of phases";
        Modelica.Electrical.Polyphase.Interfaces.PositivePlug ac(final m=m)
          "AC output"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.SIunits.Voltage vAC[m]=ac.pin[:].v "AC potential";
        Modelica.SIunits.Current iAC[m]=ac.pin[:].i "AC current";
        Modelica.SIunits.Power powerAC[m]=vAC.*iAC "AC power";
        Modelica.SIunits.Power powerTotalAC=sum(powerAC) "AC total power";
      end ACplug;
    end DCAC;

    package DCDC "DC to DC converter interfaces"
      partial model DCtwoPin1 "Positive and negative pins of side 1"

        Modelica.Electrical.Analog.Interfaces.PositivePin dc_p1
          "Positive DC input"
          annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin dc_n1
          "Negative DC input"
          annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
        Modelica.SIunits.Voltage vDC1=dc_p1.v - dc_n1.v "DC voltage side 1";
        Modelica.SIunits.Current iDC1=dc_p1.i "DC current side 1";
        Modelica.SIunits.Power powerDC1=vDC1*iDC1 "DC power side 1";
      end DCtwoPin1;
      extends Modelica.Icons.InterfacesPackage;
      partial model DCtwoPin2 "Positive and negative pins of side 2"

        Modelica.Electrical.Analog.Interfaces.PositivePin dc_p2
          "Positive DC output"
          annotation (Placement(transformation(extent={{90,50},{110,70}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin dc_n2
          "Negative DC output"
          annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
        Modelica.SIunits.Voltage vDC2=dc_p2.v - dc_n2.v "DC voltages side 2";
        Modelica.SIunits.Current iDC2=dc_p2.i "DC current side 2";
        Modelica.SIunits.Power powerDC2=vDC2*iDC2 "DC power side 2";
      end DCtwoPin2;
    end DCDC;

    package Enable "Enabling interfaces"
      extends Modelica.Icons.InterfacesPackage;
      partial model Enable
        "Partial model providing enable parameter and optional enable input"
        parameter Boolean useConstantEnable=true
          "Disable boolean input and use constantEnable, if true"
          annotation (Dialog(tab="Enable"));
        parameter Boolean constantEnable=true
          "Constant enabling of firing signals"
          annotation (Dialog(tab="Enable", enable=useConstantEnable));
        parameter Integer m(final min=1) = 3 "Number of phases";
        Modelica.Electrical.PowerConverters.Enable.EnableLogic enableLogic(
          final useConstantEnable=useConstantEnable,
          final constantEnable=constantEnable,
          final m=m) "Enabling logic"
          annotation (Placement(transformation(extent={{80,-90},{100,-70}})));
        Modelica.Blocks.Interfaces.BooleanInput enable if not useConstantEnable
          "Enables fire and notFire" annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={100,-120})));
      equation
        connect(enableLogic.enable, enable) annotation (Line(
            points={{100,-92},{100,-120}}, color={255,0,255}));
        annotation (Documentation(info="<html>
<p>
This partial model provides parameters and the conditional input signal for the enabling models:</p>
<ul>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.Interfaces.Enable.Enable1\">Enable1</a></li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.Interfaces.Enable.Enable2\">Enable2</a></li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.Interfaces.Enable.Enable1m\">Enable1m</a></li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.Interfaces.Enable.Enable2m\">Enable2m</a></li>
</ul>
</html>"));
      end Enable;

      partial model Enable1
        "Partial model providing enable parameter and optional enable input for one firing signal"
        extends Modelica.Electrical.PowerConverters.Interfaces.Enable.Enable(
            final m=1);
        Modelica.Blocks.Logical.And andCondition_p
          "And condition for positive firing signal" annotation (Placement(
              transformation(
              extent={{10,10},{-10,-10}},
              rotation=270,
              origin={-60,-80})));
        Modelica.Blocks.Interfaces.BooleanInput fire_p
          "Firing signal of positive potential transistor" annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={-60,-120})));
      equation
        connect(andCondition_p.u1, fire_p) annotation (Line(
            points={{-60,-92},{-60,-120}}, color={255,0,255}));
        connect(enableLogic.enable, enable) annotation (Line(
            points={{100,-92},{100,-120}}, color={255,0,255}));
        connect(enableLogic.internalEnable[1], andCondition_p.u2) annotation (
            Line(
            points={{79,-80},{76,-80},{76,-96},{40,-96},{40,-76},{-40,-76},{-40,-100},
                {-52,-100},{-52,-92}}, color={255,0,255}));
        annotation (Documentation(info="<html>
<p>This partial model provides the enabling logic for one firing signal.</p>
</html>"));
      end Enable1;

      partial model Enable1m
        "Partial model providing enable parameter and optional enable input for m firing signals"
        parameter Boolean useConstantEnable=true
          "Disable boolean input and use constantEnable, if true"
          annotation (Dialog(tab="Enable"));
        parameter Boolean constantEnable=true
          "Constant enabling of firing signals"
          annotation (Dialog(tab="Enable", enable=useConstantEnable));
        parameter Integer m(final min=3) = 3 "Number of phases";
        Modelica.Blocks.Logical.And andCondition_p[m]
          "And condition for m positive firing signals" annotation (Placement(
              transformation(
              extent={{10,10},{-10,-10}},
              rotation=270,
              origin={-60,-80})));
        Modelica.Blocks.Interfaces.BooleanInput fire_p[m]
          "Firing signals of positive potential transistors" annotation (
            Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={-60,-120})));
        Modelica.Electrical.PowerConverters.Enable.EnableLogic enableLogic(
          final useConstantEnable=useConstantEnable,
          final constantEnable=constantEnable,
          final m=m) "Enabling logic"
          annotation (Placement(transformation(extent={{80,-90},{100,-70}})));
        Modelica.Blocks.Interfaces.BooleanInput enable if not useConstantEnable
          "Enables fire and notFire" annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={100,-120})));
      equation
        connect(andCondition_p.u1, fire_p) annotation (Line(
            points={{-60,-92},{-60,-120}}, color={255,0,255}));
        connect(enableLogic.enable, enable) annotation (Line(
            points={{100,-92},{100,-120}}, color={255,0,255}));
        connect(enableLogic.internalEnable, andCondition_p.u2) annotation (Line(
            points={{79,-80},{76,-80},{76,-96},{40,-96},{40,-76},{-40,-76},{-40,-100},
                {-52,-100},{-52,-92}}, color={255,0,255}));
        annotation (Documentation(info="<html>
<p>This partial model provides the enabling logic for <code>m</code> firing signal.</p>
</html>"));
      end Enable1m;

      partial model Enable2
        "Partial model providing enable parameter and optional enable input for two firing signals"
        extends Modelica.Electrical.PowerConverters.Interfaces.Enable.Enable1;
        Modelica.Blocks.Logical.And andCondition_n
          "And condition for negative firing signal" annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=270,
              origin={60,-80})));
        Modelica.Blocks.Interfaces.BooleanInput fire_n
          "Firing signal of negative potential transistor" annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={60,-120})));
      equation
        connect(fire_n, andCondition_n.u1) annotation (Line(
            points={{60,-120},{60,-92}}, color={255,0,255}));
        connect(enableLogic.internalEnable[1], andCondition_n.u2) annotation (
            Line(
            points={{79,-80},{76,-80},{76,-96},{52,-96},{52,-92}}, color={255,0,255}));
        annotation (Documentation(info="<html>
<p>This partial model provides the enabling logic for two firing signal.</p>
</html>"));
      end Enable2;

      partial model Enable2m
        "Partial model providing enable parameter and optional enable input for 2*m firing signals"
        extends Interfaces.Enable.Enable1m;
        Modelica.Blocks.Logical.And andCondition_n[m]
          "And condition for m negative firing signals" annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=270,
              origin={60,-80})));
        Modelica.Blocks.Interfaces.BooleanInput fire_n[m]
          "Firing signals of negative potential transistors" annotation (
            Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={60,-120})));
      equation
        connect(fire_n, andCondition_n.u1) annotation (Line(
            points={{60,-120},{60,-92}}, color={255,0,255}));
        connect(enableLogic.internalEnable, andCondition_n.u2) annotation (Line(
            points={{79,-80},{76,-80},{76,-96},{52,-96},{52,-92}}, color={255,0,255}));
        annotation (Documentation(info="<html>
<p>This partial model provides the enabling logic for <code>2*m</code> firing signal.</p>
</html>"));
      end Enable2m;
    end Enable;
  end Interfaces;

  package Icons "Icons"
    extends Modelica.Icons.Package;
    partial model ExampleTemplate "Example template"

      annotation (Icon(graphics={Ellipse(
                  extent={{-100,100},{100,-100}},
                  lineColor={175,175,175},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-36,-60},{-36,60},{64,0},{-36,-60}},
                  lineColor={175,175,175},
                  fillColor={175,175,175},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{-4,46},{14,-44}},
                  lineColor={255,255,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}));
    end ExampleTemplate;

    partial model Converter "Converter icon"

      annotation (Icon(graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-100,-100},{100,100}},
              color={0,0,127}),
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              textColor={0,0,255})}));
    end Converter;

    partial block Control "Control icon"

      annotation (Icon(graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-150,-140},{150,-180}},
                  textString="%name",
                  textColor={0,0,255})}));
    end Control;
  end Icons;

  package Types "Type definitions for PowerConverters"
    extends Modelica.Icons.TypesPackage;
  type PWMType = enumeration(
        SVPWM "SpaceVector PWM",
        Intersective "Intersective PWM")
    "Enumeration defining the PWM type";
    type ReferenceType = enumeration(
        Sawtooth1 "Sawtooth signal single-phase",
        Sawtooth3 "Sawtooth signal three-phase",
        Triangle1 "Triangle signal single-phase",
        Triangle3 "Triangle signal three-phase")
      "Enumeration defining the type of reference signal";
    type Voltage2AngleType = enumeration(
        Lin "Linear",
        H01 "First harmonic",
        RMS "Root mean square")
      "Enumeration defining the type of voltage to angle conversion";
    type SoftStarterModeOfOperation = enumeration(
        Off "v = 0",
        Up "v = 0 -> 1",
        On "v = 1",
        Down "v = 1 -> 0")
      "Enumeration defining the internal mode of operation of the soft start controller";
  end Types;
  annotation (
    preferredView="info",
    Documentation(info="<html>
<p>
This library provides power converters for DC and AC single-phase and polyphase electrical systems. The PowerConverters library contains four types of converters.
</p>

<ul>
  <li>AC/DC converters (rectifiers)</li>
  <li>DC/AC converters (inverters)</li>
  <li>DC/DC converters</li>
  <li>AC/AC converters</li>
</ul>

<p>
Copyright &copy; 2013-2019, Modelica Association and contributors
</p>
</html>"),
    Icon(graphics={
        Line(
          points={{-78,0},{80,0}},
          color={95,95,95}),
        Line(
          points={{36,50},{36,-52}},
          color={95,95,95}),
        Polygon(points={{36,0},{-34,50},{-34,-50},{36,0}}, lineColor={95,95,95})}));
end PowerConverters;
