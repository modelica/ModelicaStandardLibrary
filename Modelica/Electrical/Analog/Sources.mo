within Modelica.Electrical.Analog;
package Sources "Time-dependent and controlled voltage and current sources"

  extends Modelica.Icons.SourcesPackage;

  model SignalVoltage
    "Generic voltage source using the input signal as source voltage"

    Interfaces.PositivePin p annotation (Placement(transformation(extent={{-110,
              -10},{-90,10}})));
    Interfaces.NegativePin n annotation (Placement(transformation(extent={{110,
              -10},{90,10}})));
    Modelica.Blocks.Interfaces.RealInput v(unit="V")
      "Voltage between pin p and n (= p.v - n.v) as input signal" annotation (
        Placement(transformation(
          origin={0,120},
          extent={{-20,-20},{20,20}},
          rotation=270)));
    SI.Current i "Current flowing from pin p to pin n";
  equation
    v = p.v - n.v;
    0 = p.i + n.i;
    i = p.i;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Ellipse(
            extent={{-50,50},{50,-50}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{-50,0}}, color={0,0,255}),
          Line(points={{50,0},{90,0}}, color={0,0,255}),
          Line(points={{-50,0},{50,0}}, color={0,0,255}),
          Text(
            extent={{-150,50},{150,90}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-70,30},{-70,10}}, color={0,0,255}),
          Line(points={{-80,20},{-60,20}}, color={0,0,255}),
          Line(points={{60,20},{80,20}}, color={0,0,255})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{-96,0},{-50,0}},
            color={0,0,255}), Line(points={{-109,20},{-84,
            20}}, color={160,160,164}),Polygon(
              points={{-94,23},{-84,20},{-94,17},{-94,23}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),Line(points={{91,20},{116,20}},
            color={160,160,164}),Text(
              extent={{-109,25},{-89,45}},
              lineColor={160,160,164},
              textString="i"),Polygon(
              points={{106,23},{116,20},{106,17},{106,23}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),Text(
              extent={{91,45},{111,25}},
              lineColor={160,160,164},
              textString="i"),Line(points={{-119,-5},{-119,5}}, color={160,160,164}),
            Line(points={{-124,0},{-114,0}}, color={160,160,164}),Line(
            points={{116,0},{126,0}}, color={160,160,164})}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Martin Otter<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>The signal voltage source is a parameterless converter of real valued signals into a the source voltage. No further effects are modeled. The real valued signal has to be provided by components of the blocks library. It can be regarded as the &quot;Opposite&quot; of a voltage sensor.</p>
</html>"));
  end SignalVoltage;

  model ConstantVoltage "Source for constant voltage"
    parameter SI.Voltage V(start=1) "Value of constant voltage";
    extends Interfaces.OnePort;

  equation
    v = V;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Text(
            extent={{-150,70},{150,110}},
            lineColor={0,0,255},
            textString="%name"),
          Line(points={{-70,30},{-70,10}}, color={0,0,255}),
          Line(points={{-80,20},{-60,20}}, color={0,0,255}),
          Line(points={{60,20},{80,20}}, color={0,0,255}),
          Text(
            extent={{-150,-110},{150,-70}},
            textString="V=%V"),
          Ellipse(
            extent={{-50,50},{50,-50}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-50,0},{50,0}}, color={0,0,255}),
          Line(points={{-90,0},{-50,0}}, color={0,0,255}),
          Line(points={{50,0},{90,0}}, color={0,0,255})}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>The ConstantVoltage source is a simple source for an ideal constant voltage which is provided by a parameter. There is no internal resistance modeled. If it is used instead of a battery model it is not very realistic: This battery will never be unloaded.</p>
</html>"));
  end ConstantVoltage;

  model StepVoltage "Step voltage source"
    parameter SI.Voltage V(start=1) "Height of step";
    extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.Step
        signalSource(final height=V));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-70,-70},{0,-70},{0,70},{69,70}},
              color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,68},{-80,-80}},
            color={192,192,192}),Line(
              points={{-80,-18},{0,-18},{0,50},{80,50}},
              thickness=0.5),Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{70,-80},{94,-100}},
              lineColor={160,160,164},
              textString="time"),Text(
              extent={{-21,-72},{25,-90}},
              lineColor={160,160,164},
              textString="startTime"),Line(
              points={{0,-17},{0,-71}},
              color={192,192,192},
              pattern=LinePattern.Dash),Text(
              extent={{-68,-36},{-22,-54}},
              lineColor={160,160,164},
              textString="offset"),Line(
              points={{-13,50},{-13,-17}},
              color={192,192,192}),Polygon(
              points={{0,50},{-19,50},{0,50}},
              lineColor={192,192,192},
              pattern=LinePattern.Dash),Polygon(
              points={{-13,-17},{-16,-4},{-10,-4},{-13,-17},{-13,-17}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-13,50},{-16,37},{-9,37},{-13,50}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-68,26},{-22,8}},
              lineColor={160,160,164},
              textString="V"),Polygon(
              points={{-13,-69},{-16,-56},{-10,-56},{-13,-69},{-13,-69}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-13,-18},{-13,-70}},
              color={192,192,192}),Polygon(
              points={{-13,-18},{-16,-31},{-9,-31},{-13,-18}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-67,93},{-2,67}},
              lineColor={160,160,164},
              textString="v = p.v - n.v")}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));
  end StepVoltage;

  model RampVoltage "Ramp voltage source"
    parameter SI.Voltage V(start=1) "Height of ramp";
    parameter SI.Time duration(min=Modelica.Constants.small, start=2)
      "Duration of ramp";
    extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.Ramp
        signalSource(final height=V, final duration=duration));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,68},{-80,-80}},
            color={192,192,192}),Line(
              points={{-80,-20},{-20,-20},{50,50}},
              thickness=0.5),Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-40,-20},{-42,-30},{-38,-30},{-40,-20}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-40,-20},{-40,-70}},
              color={192,192,192}),Polygon(
              points={{-40,-70},{-42,-60},{-38,-60},{-40,-70},{-40,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-80,-33},{-41,-49}},
              lineColor={160,160,164},
              textString="offset"),Text(
              extent={{-40,-70},{6,-88}},
              lineColor={160,160,164},
              textString="startTime"),Text(
              extent={{-67,93},{-2,67}},
              lineColor={160,160,164},
              textString="v = p.v - n.v"),Text(
              extent={{70,-80},{94,-100}},
              lineColor={160,160,164},
              textString="time"),Line(
              points={{-20,-20},{-20,-70}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-19,-20},{50,-20}},
              color={192,192,192}),Line(
              points={{50,50},{101,50}},
              thickness=0.5),Line(
              points={{50,50},{50,-20}},
              color={192,192,192}),Polygon(
              points={{50,-20},{42,-18},{42,-22},{50,-20}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-20,-20},{-11,-18},{-11,-22},{-20,-20}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{50,50},{48,40},{52,40},{50,50}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{50,-20},{48,-10},{52,-10},{50,-20},{50,-20}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{53,25},{82,7}},
              lineColor={160,160,164},
              textString="V"),Text(
              extent={{0,-17},{35,-37}},
              lineColor={160,160,164},
              textString="duration")}),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-80,-60},{-50,-60},{50,60},{80,60}},
              color={192,192,192})}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));
  end RampVoltage;

  model SineVoltage "Sine voltage source"
    parameter SI.Voltage V(start=1) "Amplitude of sine wave";
    parameter SI.Angle phase=0 "Phase of sine wave";
    parameter SI.Frequency freqHz(start=1) "Frequency of sine wave";
    extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.Sine
        signalSource(
        final amplitude=V,
        final freqHz=freqHz,
        final phase=phase));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-66,0},{-56.2,29.9},{-49.8,46.5},
                {-44.2,58.1},{-39.3,65.2},{-34.3,69.2},{-29.4,69.8},{-24.5,67},
                {-19.6,61},{-14.6,52},{-9,38.6},{-1.98,18.6},{12.79,-26.9},{
                19.1,-44},{24.8,-56.2},{29.7,-64},{34.6,-68.6},{39.5,-70},{44.5,
                -67.9},{49.4,-62.5},{54.3,-54.1},{59.9,-41.3},{67,-21.7},{74,0}},
              color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{-80,-90},{-80,84}}, color={
            192,192,192}),Polygon(
              points={{-80,100},{-86,84},{-74,84},{-80,100}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-99,-40},{100,-40}},
            color={192,192,192}),Polygon(
              points={{100,-40},{84,-34},{84,-46},{100,-40}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-41,-2},{-32.6,32.2},{-27.1,51.1},{-22.3,64.4},{-18.1,
              72.6},{-13.9,77.1},{-8,78},{-5.42,74.6},{-1.201,67.7},{3.02,57.4},
              {7.84,42.1},{13.9,19.2},{26.5,-32.8},{32,-52.2},{36.8,-66.2},{41,
              -75.1},{45.2,-80.4},{49.5,-82},{53.7,-79.6},{57.9,-73.5},{62.1,-63.9},
              {66.9,-49.2},{73,-26.8},{79,-2}},
              thickness=0.5),Line(
              points={{-41,-2},{-80,-2}},
              thickness=0.5),Text(
              extent={{-106,-11},{-60,-29}},
              lineColor={160,160,164},
              textString="offset"),Line(
              points={{-41,-2},{-41,-40}},
              color={192,192,192},
              pattern=LinePattern.Dash),Text(
              extent={{-60,-43},{-14,-61}},
              lineColor={160,160,164},
              textString="startTime"),Text(
              extent={{76,-52},{100,-72}},
              lineColor={160,160,164},
              textString="time"),Line(
              points={{-8,78},{45,78}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-41,-2},{52,-2}},
              color={192,192,192},
              pattern=LinePattern.Dash),Polygon(
              points={{33,78},{30,65},{37,65},{33,78}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{37,57},{83,39}},
              lineColor={160,160,164},
              textString="V"),Polygon(
              points={{33,-2},{30,11},{36,11},{33,-2},{33,-2}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{33,78},{33,-2}},
              color={192,192,192}),Text(
              extent={{-69,109},{-4,83}},
              lineColor={160,160,164},
              textString="v = p.v - n.v")}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));

  end SineVoltage;

  model CosineVoltage "Cosine voltage source"
    parameter SI.Voltage V(start=1) "Amplitude of cosine wave";
    parameter SI.Angle phase=0 "Phase of cosine wave";
    parameter SI.Frequency freqHz(start=1) "Frequency of cosine wave";
    extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.Cosine
        signalSource(
        final amplitude=V,
        final freqHz=freqHz,
        final phase=phase));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={Line(
            points={{-71,70},{-68.4,69.8},{-63.5,67},{-58.6,61},{-53.6,52},{-48,
                38.6},{-40.98,18.6},{-26.21,-26.9},{-19.9,-44},{-14.2,-56.2},{-9.3,
                -64},{-4.4,-68.6},{0.5,-70},{5.5,-67.9},{10.4,-62.5},{15.3,-54.1},
                {20.9,-41.3},{28,-21.7},{35,0}},
            color={192,192,192},
            smooth=Smooth.Bezier), Line(points={{35,0},{44.8,29.9},{51.2,46.5},
                {56.8,58.1},{61.7,65.2},{66.7,69.2},{71.6,69.8}}, color={192,
                192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{-80,-90},{-80,84}}, color={
            192,192,192}),Polygon(
              points={{-80,100},{-86,84},{-74,84},{-80,100}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-99,-40},{100,-40}},
            color={192,192,192}),Polygon(
              points={{100,-40},{84,-34},{84,-46},{100,-40}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-41,78},{-38,78},{-35.42,74.6},{-31.201,67.7},{-26.98,
              57.4},{-22.16,42.1},{-16.1,19.2},{-3.5,-32.8},{2,-52.2},{6.8,-66.2},
              {11,-75.1},{15.2,-80.4},{19.5,-82},{23.7,-79.6},{27.9,-73.5},{
              32.1,-63.9},{36.9,-49.2},{43,-26.8},{49,-2},{49,-2},{57.4,32.2},{
              62.9,51.1},{67.7,64.4},{71.9,72.6},{76.1,77.1},{80,78}},
              thickness=0.5),Line(
              points={{-41,-2},{-80,-2}},
              thickness=0.5),Text(
              extent={{-106,-11},{-60,-29}},
              lineColor={160,160,164},
              textString="offset"),Line(
              points={{-41,-2},{-41,-40}},
              color={192,192,192},
              pattern=LinePattern.Dash),Text(
              extent={{-60,-43},{-14,-61}},
              lineColor={160,160,164},
              textString="startTime"),Text(
              extent={{76,-52},{100,-72}},
              lineColor={160,160,164},
              textString="time"),Line(
              points={{-8,78},{45,78}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-41,-2},{52,-2}},
              color={192,192,192},
              pattern=LinePattern.Dash),Polygon(
              points={{33,78},{30,65},{37,65},{33,78}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{37,57},{83,39}},
              lineColor={160,160,164},
              textString="V"),Polygon(
              points={{33,-2},{30,11},{36,11},{33,-2},{33,-2}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{33,78},{33,-2}},
              color={192,192,192}),Text(
              extent={{-69,109},{-4,83}},
              lineColor={160,160,164},
              textString="v = p.v - n.v"),Line(
              points={{-41,78},{-41,-2}},
              thickness=0.5)}),
      Documentation(revisions="<html>
<ul>
<li>Initially implemented by Christian Kral on 2013-05-14</li>
</ul>
</html>", info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));

  end CosineVoltage;

  model ExpSineVoltage "Exponentially damped sine voltage source"
    parameter SI.Voltage V(start=1) "Amplitude of sine wave";
    parameter SI.Frequency freqHz(start=2) "Frequency of sine wave";
    parameter SI.Angle phase=0 "Phase of sine wave";
    parameter SI.Damping damping(start=1) "Damping coefficient of sine wave";
    extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.ExpSine
        signalSource(
        final amplitude=V,
        final freqHz=freqHz,
        final phase=phase,
        final damping=damping));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-64,-14},{-59.2,18.3},{-56,36.3},
                {-52.7,50.5},{-49.5,60.2},{-46.3,65.3},{-43.1,65.6},{-39.9,61.3},
                {-36.7,53.1},{-32.6,38.2},{-27,11.8},{-19,-27.9},{-14.2,-47.7},
                {-10.1,-59.9},{-6.1,-67.2},{-2.1,-69.3},{1.9,-66.5},{5.9,-59.3},
                {10.77,-46.1},{24.44,-0.3},{29.3,12.4},{34.1,20.8},{38.1,24},{
                42.9,23.2},{47.8,17.8},{54.2,5.4},{67.1,-24.5},{73.5,-35.2},{
                79.1,-39.9},{84.7,-39.9},{91.2,-34.5},{96,-27.8}}, color={192,
                192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{-80,-90},{-80,84}}, color={
            192,192,192}),Polygon(
              points={{-80,100},{-86,84},{-74,84},{-80,100}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-99,-40},{85,-40}},
            color={192,192,192}),Polygon(
              points={{100,-40},{84,-34},{84,-46},{100,-40}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-50,0},{-46.1,28.2},{-43.5,44},{-40.9,56.4},{-38.2,64.9},
              {-35.6,69.4},{-33,69.6},{-30.4,65.9},{-27.8,58.7},{-24.5,45.7},{-19.9,
              22.5},{-13.4,-12.2},{-9.5,-29.5},{-6.23,-40.1},{-2.96,-46.5},{
              0.302,-48.4},{3.57,-45.9},{6.83,-39.6},{10.8,-28.1},{21.9,12},{
              25.8,23.1},{29.7,30.5},{33,33.3},{36.9,32.5},{40.8,27.8},{46,16.9},
              {56.5,-9.2},{61.7,-18.6},{66.3,-22.7},{70.9,-22.6},{76.1,-18},{80,
              -12.1}},
              thickness=0.5),Text(
              extent={{-78,1},{-55,-19}},
              lineColor={160,160,164},
              textString="offset"),Text(
              extent={{-72,-36},{-26,-54}},
              lineColor={160,160,164},
              textString="startTime"),Text(
              extent={{76,-44},{100,-64}},
              lineColor={160,160,164},
              textString="time"),Line(
              points={{-50,0},{18,0}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-50,0},{-80,0}},
              thickness=0.5),Line(
              points={{-50,77},{-50,0}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{18,0},{18,76}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(points={{18,73},{-50,73}}, color={
            192,192,192}),Text(
              extent={{-42,88},{9,74}},
              lineColor={160,160,164},
              textString="1/freqHz"),Polygon(
              points={{-50,73},{-41,75},{-41,71},{-50,73}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{18,73},{10,75},{10,71},{18,73}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-50,-61},{-19,-61}},
            color={192,192,192}),Polygon(
              points={{-18,-61},{-26,-59},{-26,-63},{-18,-61}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-51,-63},{-27,-75}},
              lineColor={160,160,164},
              textString="t"),Text(
              extent={{-82,-67},{108,-96}},
              lineColor={160,160,164},
              textString="V*exp(-damping*t)*sin(2*pi*freqHz*t+phase)"),Line(
              points={{-50,0},{-50,-40}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-50,-54},{-50,-72}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{18,-76},{-1,-48}},
              color={192,192,192},
              pattern=LinePattern.Dash),Text(
              extent={{-77,105},{-38,92}},
              lineColor={160,160,164},
              textString="v = p.v - n.v")}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));
  end ExpSineVoltage;

  model ExponentialsVoltage "Rising and falling exponential voltage source"
    parameter Real vMax(start=1) "Upper bound for rising edge";
    parameter SI.Time riseTime(min=0, start=0.5) "Rise time";
    parameter SI.Time riseTimeConst(min=Modelica.Constants.small, start=0.1)
      "Rise time constant";
    parameter SI.Time fallTimeConst(min=Modelica.Constants.small, start=
          riseTimeConst) "Fall time constant";
    extends Interfaces.VoltageSource(redeclare
        Modelica.Blocks.Sources.Exponentials signalSource(
        final outMax=vMax,
        final riseTime=riseTime,
        final riseTimeConst=riseTimeConst,
        final fallTimeConst=fallTimeConst));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-76,-59},{-73.2,-44.3},{-70.3,-31.1},
                {-66.8,-16.6},{-63.3,-4},{-59.7,6.92},{-55.5,18.18},{-51.3,27.7},
                {-46.3,37},{-40.6,45.5},{-34.3,53.1},{-27.2,59.6},{-18.7,65.3},
                {-8.1,70.2},{-6,71},{-3.88,58.5},{-1.05,43.7},{1.78,30.8},{
                4.606,19.45},{8.14,7.3},{11.68,-3},{15.9,-13.2},{20.2,-21.6},{
                25.1,-29.5},{30.8,-36.4},{37.1,-42.3},{44.9,-47.5},{54.8,-51.8},
                {64,-54.4}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{-100,-70},{100,-70}}, color={
            192,192,192}),Polygon(
              points={{100,-70},{84,-64},{84,-76},{100,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-40,-30},{-37.2,-15.3},{-34.3,-2.1},{-30.8,12.4},{-27.3,
              25},{-23.7,35.92},{-19.5,47.18},{-15.3,56.7},{-10.3,66},{-4.6,
              74.5},{1.7,82.1},{8.8,88.6},{17.3,94.3},{27.9,99.2},{30,100},{
              32.12,87.5},{34.95,72.7},{37.78,59.8},{40.606,48.45},{44.14,36.3},
              {47.68,26},{51.9,15.8},{56.2,7.4},{61.1,-0.5},{66.8,-7.4},{73.1,-13.3},
              {80.9,-18.5},{90.8,-22.8},{100,-25.4}},
              thickness=0.5),Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,68},{-80,-80}},
            color={192,192,192}),Text(
              extent={{-70,91},{-29,71}},
              lineColor={160,160,164},
              textString="outPort"),Text(
              extent={{-78,-43},{-46,-56}},
              lineColor={160,160,164},
              textString="offset"),Polygon(
              points={{-40,-70},{-42,-60},{-38,-60},{-40,-70},{-40,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-40,-30},{-40,-60}},
              color={192,192,192}),Polygon(
              points={{-40,-30},{-42,-40},{-38,-40},{-40,-30}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-39,-30},{-80,-30}},
              thickness=0.5),Text(
              extent={{-59,-71},{-13,-89}},
              lineColor={160,160,164},
              textString="startTime"),Polygon(
              points={{-40,-30},{-31,-28},{-31,-32},{-40,-30}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-39,-30},{30,-30}},
              color={192,192,192}),Polygon(
              points={{30,-30},{22,-28},{22,-32},{30,-30}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-26,-12},{19,-28}},
              lineColor={160,160,164},
              textString="riseTime"),Text(
              extent={{78,-76},{102,-96}},
              lineColor={160,160,164},
              textString="time"),Line(
              points={{-40,-30},{-37.2,-15.3},{-34.3,-2.1},{-30.8,12.4},{-27.3,
              25},{-23.7,35.92},{-19.5,47.18},{-15.3,56.7},{-10.3,66},{-4.6,
              74.5},{1.7,82.1},{8.8,88.6},{17.3,94.3},{27.9,99.2},{30,100},{
              32.12,87.5},{34.95,72.7},{37.78,59.8},{40.606,48.45},{44.14,36.3},
              {47.68,26},{51.9,15.8},{56.2,7.4},{61.1,-0.5},{66.8,-7.4},{73.1,-13.3},
              {80.9,-18.5},{90.8,-22.8},{100,-25.4}},
              thickness=0.5),Line(
              points={{-40,-30},{-80,-30}},
              thickness=0.5),Line(
              points={{30,100},{30,-34}},
              color={192,192,192},
              pattern=LinePattern.Dash)}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));
  end ExponentialsVoltage;

  model PulseVoltage "Pulse voltage source"
    parameter SI.Voltage V(start=1) "Amplitude of pulse";
    parameter Real width(
      final min=Modelica.Constants.small,
      final max=100,
      start=50) "Width of pulse in % of period";
    parameter SI.Time period(final min=Modelica.Constants.small, start=1)
      "Time for one period";
    extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.Pulse
        signalSource(
        final amplitude=V,
        final width=width,
        final period=period));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-70,-70},{-40,-70},{-40,70},{0,70},
                {0,-70},{40,-70},{40,70},{80,70}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,68},{-80,-80}},
            color={192,192,192}),Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-34,0},{-37,-13},{-31,-13},{-34,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-34,0},{-34,-70}},
              color={192,192,192}),Polygon(
              points={{-34,-70},{-37,-57},{-31,-57},{-34,-70},{-34,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-78,-24},{-35,-36}},
              lineColor={160,160,164},
              textString="offset"),Text(
              extent={{-40,-69},{6,-87}},
              lineColor={160,160,164},
              textString="startTime"),Text(
              extent={{70,-80},{94,-100}},
              lineColor={160,160,164},
              textString="time"),Line(
              points={{-20,0},{-20,-70}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-80,0},{-20,0},{-20,50},{21,50},{21,0},{41,0},{41,50},{
              79,50}},
              thickness=0.5),Line(
              points={{-20,89},{-20,50}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{21,74},{21,50}},
              color={160,160,164},
              pattern=LinePattern.Dash),Line(
              points={{41,88},{41,50}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(points={{-20,83},{41,83}}, color={
            192,192,192}),Line(points={{-20,69},{21,69}}, color={192,192,192}),
            Text(
              extent={{-11,97},{35,85}},
              lineColor={160,160,164},
              textString="period"),Text(
              extent={{-18,81},{21,69}},
              lineColor={160,160,164},
              textString="width"),Line(
              points={{-53,50},{-20,50}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-34,50},{-34,0}},
              color={192,192,192}),Text(
              extent={{-78,34},{-37,20}},
              lineColor={160,160,164},
              textString="V"),Polygon(
              points={{-34,50},{-37,37},{-31,37},{-34,50}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-34,0},{-37,13},{-31,13},{-34,0},{-34,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{79,50},{79,0},{90,0}},
              thickness=0.5),Polygon(
              points={{-20,69},{-11,71},{-11,67},{-20,69}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{21,69},{13,71},{13,67},{21,69}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-20,83},{-11,85},{-11,81},{-20,83}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{41,83},{33,85},{33,81},{41,83}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-78,103},{-24,89}},
              lineColor={160,160,164},
              textString="v = p.v - n.v")}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));
  end PulseVoltage;

  model SawToothVoltage "Saw tooth voltage source"
    parameter SI.Voltage V(start=1) "Amplitude of saw tooth";
    parameter SI.Time period(start=1) "Time for one period";
    extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.SawTooth
        signalSource(final amplitude=V, final period=period));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-85,-70},{-65,-70},{-5,71},{-5,-70},
                {55,71},{55,-70}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,68},{-80,-80}},
            color={192,192,192}),Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-34,-20},{-37,-33},{-31,-33},{-34,-20}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-34,-20},{-34,-70}},
              color={192,192,192}),Polygon(
              points={{-34,-70},{-37,-57},{-31,-57},{-34,-70},{-34,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-78,-24},{-35,-36}},
              lineColor={160,160,164},
              textString="offset"),Text(
              extent={{-31,-69},{15,-87}},
              lineColor={160,160,164},
              textString="startTime"),Text(
              extent={{70,-80},{94,-100}},
              lineColor={160,160,164},
              textString="time"),Line(
              points={{-10,-20},{-10,-70}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-10,88},{-10,-20}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{30,88},{30,59}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(points={{-10,83},{30,83}}, color={
            192,192,192}),Text(
              extent={{-12,97},{34,85}},
              lineColor={160,160,164},
              textString="period"),Line(
              points={{-44,60},{30,60}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-34,47},{-34,-20}},
              color={192,192,192}),Text(
              extent={{-78,34},{-37,20}},
              lineColor={160,160,164},
              textString="V"),Polygon(
              points={{-34,60},{-37,47},{-30,47},{-34,60}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-34,-20},{-37,-7},{-31,-7},{-34,-20},{-34,-20}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-10,83},{-1,85},{-1,81},{-10,83}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{30,83},{22,85},{22,81},{30,83}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-80,-20},{-10,-20},{30,60},{30,-20},{72,60},{72,-20}},
              thickness=0.5),Text(
              extent={{-77,100},{-27,88}},
              lineColor={160,160,164},
              textString="v = p.v - n.v")}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));
  end SawToothVoltage;

  model TrapezoidVoltage "Trapezoidal voltage source"
    parameter SI.Voltage V(start=1) "Amplitude of trapezoid";
    parameter SI.Time rising(final min=0, start=0)
      "Rising duration of trapezoid";
    parameter SI.Time width(final min=0, start=0.5)
      "Width duration of trapezoid";
    parameter SI.Time falling(final min=0, start=0)
      "Falling duration of trapezoid";
    parameter SI.Time period(final min=Modelica.Constants.small, start=1)
      "Time for one period";
    parameter Integer nperiod(start=-1)
      "Number of periods (< 0 means infinite number of periods)";
    extends Interfaces.VoltageSource(redeclare
        Modelica.Blocks.Sources.Trapezoid signalSource(
        final amplitude=V,
        final rising=rising,
        final width=width,
        final falling=falling,
        final period=period,
        final nperiod=nperiod));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-81,-70},{-60,-70},{-30,70},{1,70},
                {30,-70},{51,-70},{80,70}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,68},{-80,-80}},
            color={192,192,192}),Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-45,-30},{-47,-41},{-43,-41},{-45,-30}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-45,-30},{-45,-70}},
              color={192,192,192}),Polygon(
              points={{-45,-70},{-47,-60},{-43,-60},{-45,-70},{-45,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-86,-43},{-43,-55}},
              lineColor={160,160,164},
              textString="offset"),Text(
              extent={{-47,-69},{-1,-87}},
              lineColor={160,160,164},
              textString="startTime"),Text(
              extent={{70,-80},{94,-100}},
              lineColor={160,160,164},
              textString="time"),Line(
              points={{-30,81},{-30,-70}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-10,59},{-10,40}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{20,59},{20,39}},
              color={160,160,164},
              pattern=LinePattern.Dash),Line(
              points={{40,59},{40,-30}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(points={{-30,56},{40,56}}, color={
            192,192,192}),Text(
              extent={{-8,70},{21,60}},
              lineColor={160,160,164},
              textString="width"),Line(
              points={{-42,40},{-10,40}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-39,40},{-39,-30}},
              color={192,192,192}),Text(
              extent={{-71,13},{-34,-1}},
              lineColor={160,160,164},
              textString="V"),Polygon(
              points={{-30,56},{-23,58},{-23,54},{-30,56}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-10,56},{-17,58},{-17,54},{-10,56}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-80,-30},{-30,-30},{-10,40},{20,40},{40,-30},{60,-30},{
              80,46},{100,46}},
              thickness=0.5),Polygon(
              points={{-39,40},{-41,29},{-37,29},{-39,40}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-39,-30},{-41,-20},{-37,-20},{-39,-30},{-39,-30}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{60,81},{60,-30}},
              color={192,192,192},
              pattern=LinePattern.Dash),Polygon(
              points={{40,56},{33,58},{33,54},{40,56}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{20,56},{27,58},{27,54},{20,56}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{20,56},{13,58},{13,54},{20,56}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-10,56},{-3,58},{-3,54},{-10,56}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-34,70},{-5,60}},
              lineColor={160,160,164},
              textString="rising"),Text(
              extent={{16,70},{45,60}},
              lineColor={160,160,164},
              textString="falling"),Text(
              extent={{-77,103},{-23,91}},
              lineColor={160,160,164},
              textString="v = p.v - n.v"),Line(points={{-30,76},{60,76}}, color=
             {192,192,192}),Polygon(
              points={{-30,76},{-21,78},{-21,74},{-30,76}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{60,76},{52,78},{52,74},{60,76}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-2,86},{25,77}},
              lineColor={160,160,164},
              textString="period")}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));
  end TrapezoidVoltage;

  model TableVoltage "Voltage source by linear interpolation in a table"
    parameter Real table[:, :]=[0, 0; 1, 1; 2, 4]
      "Table matrix (time = first column, voltage = second column)";
    extends Interfaces.VoltageSource(redeclare
        Modelica.Blocks.Sources.TimeTable signalSource(final table=table));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-58,-36},{-58,84},{42,84},{42,-36},
                {-58,-36},{-58,-6},{42,-6},{42,24},{-58,24},{-58,54},{42,54},{
                42,84},{-8,84},{-8,-37}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,68},{-80,-80}},
            color={192,192,192}),Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Rectangle(
              extent={{-20,90},{30,-30}},
              lineColor={255,255,255},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-20,-30},{-20,90},{
            80,90},{80,-30},{-20,-30},{-20,0},{80,0},{80,30},{-20,30},{-20,60},
            {80,60},{80,90},{30,90},{30,-31}}),Text(
              extent={{-77,-42},{-38,-58}},
              lineColor={160,160,164},
              textString="offset"),Polygon(
              points={{-31,-30},{-33,-40},{-29,-40},{-31,-30}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-31,-70},{-33,-60},{-29,-60},{-31,-70},{-31,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-31,-30},{-31,-70}},
              color={192,192,192}),Line(
              points={{-20,-20},{-20,-70}},
              color={192,192,192},
              pattern=LinePattern.Dash),Text(
              extent={{-38,-70},{8,-88}},
              lineColor={160,160,164},
              textString="startTime"),Line(
              points={{-20,-30},{-80,-30}},
              color={192,192,192},
              pattern=LinePattern.Dash),Text(
              extent={{66,-81},{91,-93}},
              lineColor={160,160,164},
              textString="time"),Text(
              extent={{-15,83},{24,68}},
              textString="time"),Text(
              extent={{33,83},{76,67}},
              textString="v"),Text(
              extent={{-81,98},{-31,85}},
              lineColor={160,160,164},
              textString="v = p.v - n.v")}),
      Documentation(info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package.  Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p><br>This block generates a voltage source by <strong>linear interpolation</strong> in a table. The time points and voltage values are stored in a matrix <strong>table[i,j]</strong>, where the first column table[:,1] contains the time points and the second column contains the voltage to be interpolated. The table interpolation has the following properties:</p>
<ul>
<li>The time points need to be <strong>monotonically increasing</strong>.</li>
<li><strong>Discontinuities</strong> are allowed, by providing the same time point twice in the table.</li>
<li>Values <strong>outside</strong> of the table range, are computed by <strong>extrapolation</strong> through the last or first two points of the table.</li>
<li>If the table has only <strong>one row</strong>, no interpolation is performed and the voltage value is just returned independently of the actual time instant, i.e., this is a constant voltage source.</li>
<li>Via parameters <strong>startTime</strong> and <strong>offset</strong> the curve defined by the table can be shifted both in time and in the voltage.</li>
<li>The table is implemented in a numerically sound way by generating <strong>time events</strong> at interval boundaries.
    This generates continuously differentiable values for the integrator.</li>
</ul>
<p>Example:</p>
<pre>   table = [0  0
            1  0
            1  1
            2  4
            3  9
            4 16]
If, e.g., time = 1.0, the voltage v =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the voltage v =  2.5,
    e.g., time = 2.0, the voltage v =  4.0,
    e.g., time = 5.0, the voltage v = 23.0 (i.e., extrapolation). </pre>
<p><br>  Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>", revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"));
  end TableVoltage;

  model SignalCurrent
    "Generic current source using the input signal as source current"

    Interfaces.PositivePin p annotation (Placement(transformation(extent={{-110,
              -10},{-90,10}})));
    Interfaces.NegativePin n annotation (Placement(transformation(extent={{110,
              -10},{90,10}})));
    SI.Voltage v "Voltage drop between the two pins (= p.v - n.v)";
    Modelica.Blocks.Interfaces.RealInput i(unit="A")
      "Current flowing from pin p to pin n as input signal" annotation (
        Placement(transformation(
          origin={0,120},
          extent={{-20,-20},{20,20}},
          rotation=270)));
  equation
    v = p.v - n.v;
    0 = p.i + n.i;
    i = p.i;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Ellipse(
            extent={{-50,50},{50,-50}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{-50,0}}, color={0,0,255}),
          Line(points={{50,0},{90,0}}, color={0,0,255}),
          Line(points={{0,-50},{0,50}}, color={0,0,255}),
          Text(
            extent={{-150,50},{150,90}},
            textString="%name",
            lineColor={0,0,255}),
          Polygon(
            points={{90,0},{60,10},{60,-10},{90,0}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid)}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Martin Otter<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>The signal current source is a parameterless converter of real valued signals into a the source current. No further effects are modeled. The real valued signal has to be provided by components of the blocks library. It can be regarded as the &quot;Opposite&quot; of a current sensor.</p>
</html>"));
  end SignalCurrent;

  model ConstantCurrent "Source for constant current"
    parameter SI.Current I(start=1) "Value of constant current";
    extends Interfaces.OnePort;
  equation
    i = I;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Ellipse(
            extent={{-50,50},{50,-50}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{-50,0}}, color={0,0,255}),
          Line(points={{50,0},{90,0}}, color={0,0,255}),
          Line(points={{0,-50},{0,50}}, color={0,0,255}),
          Polygon(
            points={{90,0},{60,10},{60,-10},{90,0}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,60},{150,100}},
            lineColor={0,0,255},
            textString="%name"),
          Text(
            extent={{-150,-100},{150,-60}},
            textString="I=%I")}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>The ConstantCurrent source is a simple source for an ideal constant current which is provided by a parameter. There is no internal resistance modeled. No further effects are modeled. Especially, the current flow will never end.</p>
</html>"));
  end ConstantCurrent;

  model StepCurrent "Step current source"
    parameter SI.Current I(start=1) "Height of step";
    extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.Step
        signalSource(final height=I));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-86,-70},{-14,-70},{-14,70},{57,
                70}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,68},{-80,-80}},
            color={192,192,192}),Line(
              points={{-80,-18},{0,-18},{0,50},{80,50}},
              thickness=0.5),Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{70,-80},{94,-100}},
              lineColor={160,160,164},
              textString="time"),Text(
              extent={{-21,-72},{25,-90}},
              lineColor={160,160,164},
              textString="startTime"),Line(
              points={{0,-17},{0,-70}},
              color={192,192,192},
              pattern=LinePattern.Dash),Text(
              extent={{-68,-36},{-22,-54}},
              lineColor={160,160,164},
              textString="offset"),Line(
              points={{-13,50},{-13,-18}},
              color={192,192,192}),Polygon(
              points={{0,50},{-19,50},{0,50}},
              lineColor={192,192,192},
              pattern=LinePattern.Dash),Polygon(
              points={{-13,-18},{-16,-5},{-10,-5},{-13,-18},{-13,-18}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-13,50},{-16,37},{-9,37},{-13,50}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-68,26},{-22,8}},
              lineColor={160,160,164},
              textString="I"),Polygon(
              points={{-13,-70},{-16,-57},{-10,-57},{-13,-70},{-13,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-13,-18},{-13,-70}},
              color={192,192,192}),Polygon(
              points={{-13,-18},{-16,-31},{-10,-31},{-13,-18}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-73,75},{-53,95}},
              lineColor={192,192,192},
              textString="i")}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));
  end StepCurrent;

  model RampCurrent "Ramp current source"
    parameter SI.Current I(start=1) "Height of ramp";
    parameter SI.Time duration(min=Modelica.Constants.small, start=2)
      "Duration of ramp";
    extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.Ramp
        signalSource(final height=I, final duration=duration));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,68},{-80,-80}},
            color={192,192,192}),Line(
              points={{-80,-20},{-20,-20},{50,50}},
              thickness=0.5),Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-40,-20},{-42,-30},{-38,-30},{-40,-20}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-40,-20},{-40,-70}},
              color={192,192,192}),Polygon(
              points={{-40,-70},{-42,-60},{-38,-60},{-40,-70},{-40,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-80,-33},{-41,-49}},
              lineColor={160,160,164},
              textString="offset"),Text(
              extent={{-40,-70},{6,-88}},
              lineColor={160,160,164},
              textString="startTime"),Text(
              extent={{70,-80},{94,-100}},
              lineColor={160,160,164},
              textString="time"),Line(
              points={{-20,-20},{-20,-70}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-19,-20},{50,-20}},
              color={192,192,192}),Line(
              points={{50,50},{100,50}},
              thickness=0.5),Line(
              points={{50,50},{50,-20}},
              color={192,192,192}),Polygon(
              points={{50,-20},{42,-18},{42,-22},{50,-20}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-20,-20},{-11,-18},{-11,-22},{-20,-20}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{50,50},{48,40},{53,40},{50,50}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{50,-20},{47,-10},{52,-10},{50,-20},{50,-20}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{53,25},{82,7}},
              lineColor={160,160,164},
              textString="I"),Text(
              extent={{0,-17},{35,-37}},
              lineColor={160,160,164},
              textString="duration"),Text(
              extent={{-73,75},{-53,95}},
              lineColor={192,192,192},
              textString="i")}),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-80,-60},{-50,-60},{50,60},{80,60}},
              color={192,192,192})}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));
  end RampCurrent;

  model SineCurrent "Sine current source"
    parameter SI.Current I(start=1) "Amplitude of sine wave";
    parameter SI.Angle phase=0 "Phase of sine wave";
    parameter SI.Frequency freqHz(start=1) "Frequency of sine wave";
    extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.Sine
        signalSource(
        final amplitude=I,
        final freqHz=freqHz,
        final phase=phase));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-70,0},{-60.2,29.9},{-53.8,46.5},
                {-48.2,58.1},{-43.3,65.2},{-38.3,69.2},{-33.4,69.8},{-28.5,67},
                {-23.6,61},{-18.6,52},{-13,38.6},{-5.98,18.6},{8.79,-26.9},{
                15.1,-44},{20.8,-56.2},{25.7,-64},{30.6,-68.6},{35.5,-70},{40.5,
                -67.9},{45.4,-62.5},{50.3,-54.1},{55.9,-41.3},{63,-21.7},{70,0}},
              color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{-80,-90},{-80,84}}, color={
            192,192,192}),Polygon(
              points={{-80,100},{-86,84},{-74,84},{-80,100}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-99,-40},{85,-40}},
            color={192,192,192}),Polygon(
              points={{101,-40},{85,-34},{85,-46},{101,-40}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-41,-2},{-32.6,32.2},{-27.1,51.1},{-22.3,64.4},{-18.1,
              72.6},{-13.9,77.1},{-10,78},{-5.42,74.6},{-1.201,67.7},{3.02,57.4},
              {7.84,42.1},{13.9,19.2},{26.5,-32.8},{32,-52.2},{36.8,-66.2},{41,
              -75.1},{45.2,-80.4},{49.5,-82},{53.7,-79.6},{57.9,-73.5},{62.1,-63.9},
              {66.9,-49.2},{73,-26.8},{79,-2}},
              thickness=0.5),Line(
              points={{-41,-2},{-80,-2}},
              thickness=0.5),Text(
              extent={{-106,-11},{-60,-29}},
              lineColor={160,160,164},
              textString="offset"),Line(
              points={{-41,-2},{-41,-40}},
              color={192,192,192},
              pattern=LinePattern.Dash),Text(
              extent={{-60,-43},{-14,-61}},
              lineColor={160,160,164},
              textString="startTime"),Text(
              extent={{84,-52},{108,-72}},
              lineColor={160,160,164},
              textString="time"),Line(
              points={{-10,78},{42,78}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-41,-2},{5,-2},{5,-2},{51,-2}},
              color={192,192,192},
              pattern=LinePattern.Dash),Polygon(
              points={{33,78},{30,65},{37,65},{33,78}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{37,57},{83,39}},
              lineColor={160,160,164},
              textString="I"),Polygon(
              points={{33,-2},{30,11},{36,11},{33,-2},{33,-2}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{33,78},{33,-2}},
              color={192,192,192}),Text(
              extent={{-73,82},{-53,102}},
              lineColor={192,192,192},
              textString="i")}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));

  end SineCurrent;

  model CosineCurrent "Cosine current source"
    parameter SI.Current I(start=1) "Amplitude of cosine wave";
    parameter SI.Angle phase=0 "Phase of cosine wave";
    parameter SI.Frequency freqHz(start=1) "Frequency of cosine wave";
    extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.Cosine
        signalSource(
        final amplitude=I,
        final freqHz=freqHz,
        final phase=phase));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(
            points={{-71,70},{-68.4,69.8},{-63.5,67},{-58.6,61},{-53.6,52},{-48,
                38.6},{-40.98,18.6},{-26.21,-26.9},{-19.9,-44},{-14.2,-56.2},{-9.3,
                -64},{-4.4,-68.6},{0.5,-70},{5.5,-67.9},{10.4,-62.5},{15.3,-54.1},
                {20.9,-41.3},{28,-21.7},{35,0}},
            color={192,192,192},
            smooth=Smooth.Bezier), Line(points={{35,0},{44.8,29.9},{51.2,46.5},
                {56.8,58.1},{61.7,65.2},{66.7,69.2},{71.6,69.8}}, color={192,
                192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{-80,-90},{-80,84}}, color={
            192,192,192}),Polygon(
              points={{-80,100},{-86,84},{-74,84},{-80,100}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-99,-40},{85,-40}},
            color={192,192,192}),Polygon(
              points={{101,-40},{85,-34},{85,-46},{101,-40}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-41,-2},{-80,-2}},
              thickness=0.5),Text(
              extent={{-106,-11},{-60,-29}},
              lineColor={160,160,164},
              textString="offset"),Line(
              points={{-41,-2},{-41,-40}},
              color={192,192,192},
              pattern=LinePattern.Dash),Text(
              extent={{-60,-43},{-14,-61}},
              lineColor={160,160,164},
              textString="startTime"),Text(
              extent={{84,-52},{108,-72}},
              lineColor={160,160,164},
              textString="time"),Line(
              points={{-10,78},{42,78}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-41,-2},{5,-2},{5,-2},{51,-2}},
              color={192,192,192},
              pattern=LinePattern.Dash),Polygon(
              points={{33,78},{30,65},{37,65},{33,78}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{37,57},{83,39}},
              lineColor={160,160,164},
              textString="I"),Polygon(
              points={{33,-2},{30,11},{36,11},{33,-2},{33,-2}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{33,78},{33,-2}},
              color={192,192,192}),Text(
              extent={{-73,82},{-53,102}},
              lineColor={192,192,192},
              textString="i"),Line(
              points={{-41,78},{-41,-2}},
              thickness=0.5),Line(
              points={{-41,78},{-38,78},{-35.42,74.6},{-31.201,67.7},{-26.98,
              57.4},{-22.16,42.1},{-16.1,19.2},{-3.5,-32.8},{2,-52.2},{6.8,-66.2},
              {11,-75.1},{15.2,-80.4},{19.5,-82},{23.7,-79.6},{27.9,-73.5},{
              32.1,-63.9},{36.9,-49.2},{43,-26.8},{49,-2}},
              thickness=0.5),Line(
              points={{49,-2},{57.4,32.2},{62.9,51.1},{67.7,64.4},{71.9,72.6},{
              76.1,77.1},{80,78}},
              thickness=0.5)}),
      Documentation(revisions="<html>
<ul>
<li>Initially implemented by Christian Kral on 2013-05-14</li>
</ul>
</html>", info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));

  end CosineCurrent;

  model ExpSineCurrent "Exponentially damped sine current source"
    parameter Real I(start=1) "Amplitude of sine wave";
    parameter SI.Frequency freqHz(start=2) "Frequency of sine wave";
    parameter SI.Angle phase=0 "Phase of sine wave";
    parameter SI.Damping damping(start=1) "Damping coefficient of sine wave";
    extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.ExpSine
        signalSource(
        final amplitude=I,
        final freqHz=freqHz,
        final phase=phase,
        final damping=damping));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-80,-14},{-75.2,18.3},{-72,36.3},
                {-68.7,50.5},{-65.5,60.2},{-62.3,65.3},{-59.1,65.6},{-55.9,61.3},
                {-52.7,53.1},{-48.6,38.2},{-43,11.8},{-35,-27.9},{-30.2,-47.7},
                {-26.1,-59.9},{-22.1,-67.2},{-18.1,-69.3},{-14.1,-66.5},{-10.1,
                -59.3},{-5.23,-46.1},{8.44,-0.3},{13.3,12.4},{18.1,20.8},{22.1,
                24},{26.9,23.2},{31.8,17.8},{38.2,5.4},{51.1,-24.5},{57.5,-35.2},
                {63.1,-39.9},{68.7,-39.9},{75.2,-34.5},{80,-27.8}}, color={192,
                192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{-80,-90},{-80,84}}, color={
            192,192,192}),Polygon(
              points={{-80,100},{-86,84},{-74,84},{-80,100}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-99,-40},{100,-40}},
            color={192,192,192}),Polygon(
              points={{100,-40},{84,-34},{84,-46},{100,-40}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-50,0},{-46.1,28.2},{-43.5,44},{-40.9,56.4},{-38.2,64.9},
              {-35.6,69.4},{-33,69.6},{-30.4,65.9},{-27.8,58.7},{-24.5,45.7},{-19.9,
              22.5},{-13.4,-12.2},{-9.5,-29.5},{-6.23,-40.1},{-2.96,-46.5},{
              0.302,-48.4},{3.57,-45.9},{6.83,-39.6},{10.8,-28.1},{21.9,12},{
              25.8,23.1},{29.7,30.5},{33,33.3},{36.9,32.5},{40.8,27.8},{46,16.9},
              {56.5,-9.2},{61.7,-18.6},{66.3,-22.7},{70.9,-22.6},{76.1,-18},{80,
              -12.1}},
              thickness=0.5),Text(
              extent={{-78,1},{-55,-19}},
              lineColor={160,160,164},
              textString="offset"),Text(
              extent={{-72,-36},{-26,-54}},
              lineColor={160,160,164},
              textString="startTime"),Text(
              extent={{76,-44},{100,-64}},
              lineColor={160,160,164},
              textString="time"),Line(
              points={{-50,0},{18,0}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-50,0},{-80,0}},
              thickness=0.5),Line(
              points={{-50,77},{-50,0}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{18,-1},{18,76}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(points={{18,73},{-50,73}}, color={
            192,192,192}),Text(
              extent={{-42,88},{9,74}},
              lineColor={160,160,164},
              textString="1/freqHz"),Polygon(
              points={{-50,73},{-41,75},{-41,71},{-50,73}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{18,73},{10,75},{10,71},{18,73}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-50,-61},{-19,-61}},
            color={192,192,192}),Polygon(
              points={{-18,-61},{-26,-59},{-26,-63},{-18,-61}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-51,-63},{-27,-75}},
              lineColor={160,160,164},
              textString="t"),Text(
              extent={{-82,-67},{108,-96}},
              lineColor={160,160,164},
              textString="I*exp(-damping*t)*sin(2*pi*freqHz*t+phase)"),Line(
              points={{-50,0},{-50,-40}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-50,-54},{-50,-72}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{18,-76},{-1,-48}},
              color={192,192,192},
              pattern=LinePattern.Dash),Text(
              extent={{-74,83},{-54,103}},
              lineColor={192,192,192},
              textString="i")}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));
  end ExpSineCurrent;

  model ExponentialsCurrent "Rising and falling exponential current source"
    parameter Real iMax(start=1) "Upper bound for rising edge";
    parameter SI.Time riseTime(min=0, start=0.5) "Rise time";
    parameter SI.Time riseTimeConst(min=Modelica.Constants.small, start=0.1)
      "Rise time constant";
    parameter SI.Time fallTimeConst(min=Modelica.Constants.small, start=
          riseTimeConst) "Fall time constant";
    extends Interfaces.CurrentSource(redeclare
        Modelica.Blocks.Sources.Exponentials signalSource(
        final outMax=iMax,
        final riseTime=riseTime,
        final riseTimeConst=riseTimeConst,
        final fallTimeConst=fallTimeConst));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-76,-59},{-73.2,-44.3},{-70.3,-31.1},
                {-66.8,-16.6},{-63.3,-4},{-59.7,6.92},{-55.5,18.18},{-51.3,27.7},
                {-46.3,37},{-40.6,45.5},{-34.3,53.1},{-27.2,59.6},{-18.7,65.3},
                {-8.1,70.2},{-6,71},{-3.88,58.5},{-1.05,43.7},{1.78,30.8},{
                4.606,19.45},{8.14,7.3},{11.68,-3},{15.9,-13.2},{20.2,-21.6},{
                25.1,-29.5},{30.8,-36.4},{37.1,-42.3},{44.9,-47.5},{54.8,-51.8},
                {64,-54.4}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Line(points={{-100,-70},{100,-70}}, color={
            192,192,192}),Polygon(
              points={{100,-70},{84,-64},{84,-76},{100,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-40,-30},{-37.2,-15.3},{-34.3,-2.1},{-30.8,12.4},{-27.3,
              25},{-23.7,35.92},{-19.5,47.18},{-15.3,56.7},{-10.3,66},{-4.6,
              74.5},{1.7,82.1},{8.8,88.6},{17.3,94.3},{27.9,99.2},{30,100},{
              32.12,87.5},{34.95,72.7},{37.78,59.8},{40.606,48.45},{44.14,36.3},
              {47.68,26},{51.9,15.8},{56.2,7.4},{61.1,-0.5},{66.8,-7.4},{73.1,-13.3},
              {80.9,-18.5},{90.8,-22.8},{100,-25.4}},
              thickness=0.5),Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,90},{-80,-80}},
            color={192,192,192}),Polygon(
              points={{-40,-70},{-42,-60},{-38,-60},{-40,-70},{-40,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-40,-30},{-40,-60}},
              color={192,192,192}),Polygon(
              points={{-40,-30},{-42,-40},{-38,-40},{-40,-30}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-39,-30},{-80,-30}},
              thickness=0.5),Text(
              extent={{-59,-71},{-13,-89}},
              lineColor={160,160,164},
              textString="startTime"),Polygon(
              points={{-40,-30},{-31,-28},{-31,-32},{-40,-30}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-40,-30},{30,-30}},
              color={192,192,192}),Polygon(
              points={{30,-30},{22,-28},{22,-32},{30,-30}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-26,-12},{19,-28}},
              lineColor={160,160,164},
              textString="riseTime"),Line(
              points={{-40,-30},{-80,-30}},
              thickness=0.5),Line(
              points={{30,100},{30,-34}},
              color={192,192,192},
              pattern=LinePattern.Dash),Text(
              extent={{-73,75},{-53,95}},
              lineColor={192,192,192},
              textString="i")}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));
  end ExponentialsCurrent;

  model PulseCurrent "Pulse current source"
    parameter SI.Current I(start=1) "Amplitude of pulse";
    parameter Real width(
      final min=Modelica.Constants.small,
      final max=100,
      start=50) "Width of pulse in % of period";
    parameter SI.Time period(final min=Modelica.Constants.small, start=1)
      "Time for one period";
    extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.Pulse
        signalSource(
        final amplitude=I,
        final width=width,
        final period=period));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-80,-67},{-50,-67},{-50,73},{-10,
                73},{-10,-67},{30,-67},{30,73},{70,73}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,68},{-80,-80}},
            color={192,192,192}),Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-34,0},{-37,-13},{-31,-13},{-34,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-34,0},{-34,-70}},
              color={192,192,192}),Polygon(
              points={{-34,-70},{-37,-57},{-31,-57},{-34,-70},{-34,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-78,-24},{-35,-36}},
              lineColor={160,160,164},
              textString="offset"),Text(
              extent={{-42,-69},{4,-87}},
              lineColor={160,160,164},
              textString="startTime"),Text(
              extent={{70,-80},{94,-100}},
              lineColor={160,160,164},
              textString="time"),Line(
              points={{-19,0},{-19,-70}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-80,0},{-19,0},{-19,50},{21,50},{21,0},{41,0},{41,51},{
              80,51}},
              thickness=0.5),Line(
              points={{-19,88},{-19,49}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{21,74},{21,50}},
              color={160,160,164},
              pattern=LinePattern.Dash),Line(
              points={{41,88},{41,51}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(points={{-19,83},{41,83}}, color={
            192,192,192}),Line(points={{-19,69},{21,69}}, color={192,192,192}),
            Text(
              extent={{-9,97},{37,85}},
              lineColor={160,160,164},
              textString="period"),Text(
              extent={{-18,81},{21,69}},
              lineColor={160,160,164},
              textString="width"),Line(
              points={{-52,50},{-19,50}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-34,50},{-34,1}},
              color={192,192,192}),Text(
              extent={{-78,34},{-37,20}},
              lineColor={160,160,164},
              textString="I"),Polygon(
              points={{-34,50},{-37,37},{-31,37},{-34,50}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-34,0},{-37,13},{-31,13},{-34,0},{-34,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{80,51},{80,0},{90,0}},
              thickness=0.5),Polygon(
              points={{-19,69},{-10,71},{-10,67},{-19,69}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{21,69},{13,71},{13,67},{21,69}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-19,83},{-10,85},{-10,81},{-19,83}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{41,83},{33,85},{33,81},{41,83}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-73,75},{-53,95}},
              lineColor={192,192,192},
              textString="i")}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));

  end PulseCurrent;

  model SawToothCurrent "Saw tooth current source"
    parameter SI.Current I(start=1) "Amplitude of saw tooth";
    parameter SI.Time period(start=1) "Time for one period";
    extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.SawTooth
        signalSource(final amplitude=I, final period=period));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-70,-71},{-50,-71},{10,70},{10,-71},
                {70,70},{70,-71}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,68},{-80,-80}},
            color={192,192,192}),Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-34,-20},{-37,-33},{-31,-33},{-34,-20}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-34,-20},{-34,-70}},
              color={192,192,192}),Polygon(
              points={{-34,-70},{-37,-57},{-31,-57},{-34,-70},{-34,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-78,-24},{-35,-36}},
              lineColor={160,160,164},
              textString="offset"),Text(
              extent={{-31,-69},{15,-87}},
              lineColor={160,160,164},
              textString="startTime"),Text(
              extent={{70,-80},{94,-100}},
              lineColor={160,160,164},
              textString="time"),Line(
              points={{-10,-20},{-10,-70}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-10,88},{-10,-20}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{30,88},{30,59}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(points={{-10,83},{30,83}}, color={
            192,192,192}),Text(
              extent={{-12,97},{34,85}},
              lineColor={160,160,164},
              textString="period"),Line(
              points={{-44,60},{30,60}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-34,60},{-34,-20}},
              color={192,192,192}),Text(
              extent={{-78,34},{-37,20}},
              lineColor={160,160,164},
              textString="I"),Polygon(
              points={{-34,60},{-37,47},{-31,47},{-34,60}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-34,-20},{-37,-7},{-31,-7},{-34,-20},{-34,-20}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-10,83},{-1,85},{-1,81},{-10,83}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{30,83},{22,85},{22,81},{30,83}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-80,-20},{-10,-20},{30,60},{30,-20},{72,60},{72,-20}},
              thickness=0.5),Text(
              extent={{-73,75},{-53,95}},
              lineColor={192,192,192},
              textString="i")}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));
  end SawToothCurrent;

  model TrapezoidCurrent "Trapezoidal current source"
    parameter SI.Current I(start=1) "Amplitude of trapezoid";
    parameter SI.Time rising(final min=0, start=0)
      "Rising duration of trapezoid";
    parameter SI.Time width(final min=0, start=0.5)
      "Width duration of trapezoid";
    parameter SI.Time falling(final min=0, start=0)
      "Falling duration of trapezoid";
    parameter SI.Time period(final min=Modelica.Constants.small, start=1)
      "Time for one period";
    parameter Integer nperiod(start=-1)
      "Number of periods (< 0 means infinite number of periods)";
    extends Interfaces.CurrentSource(redeclare
        Modelica.Blocks.Sources.Trapezoid signalSource(
        final amplitude=I,
        final rising=rising,
        final width=width,
        final falling=falling,
        final period=period,
        final nperiod=nperiod));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-81,-66},{-60,-66},{-30,74},{1,74},
                {30,-66},{51,-66},{80,74}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,90},{-80,-80}},
            color={192,192,192}),Line(points={{-90,-70},{90,-70}}, color={192,192,192}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-45,-30},{-47,-41},{-43,-41},{-45,-30}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-45,-30},{-45,-70}},
              color={192,192,192}),Polygon(
              points={{-45,-70},{-47,-60},{-43,-60},{-45,-70},{-45,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-86,-43},{-43,-55}},
              lineColor={160,160,164},
              textString="offset"),Text(
              extent={{-47,-69},{-1,-87}},
              lineColor={160,160,164},
              textString="startTime"),Text(
              extent={{70,-80},{94,-100}},
              lineColor={160,160,164},
              textString="time"),Line(
              points={{-30,79},{-30,-70}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-10,59},{-10,40}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{20,59},{20,40}},
              color={160,160,164},
              pattern=LinePattern.Dash),Line(
              points={{40,59},{40,-30}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(points={{-21,75},{60,75}}, color={
            192,192,192}),Line(points={{-30,56},{40,56}}, color={192,192,192}),
            Text(
              extent={{-9,88},{37,76}},
              lineColor={160,160,164},
              textString="period"),Text(
              extent={{-8,70},{21,60}},
              lineColor={160,160,164},
              textString="width"),Line(
              points={{-42,40},{-10,40}},
              color={192,192,192},
              pattern=LinePattern.Dash),Line(
              points={{-39,40},{-39,-30}},
              color={192,192,192}),Text(
              extent={{-77,14},{-40,0}},
              lineColor={160,160,164},
              textString="I"),Polygon(
              points={{-30,56},{-23,58},{-23,54},{-30,56}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-10,56},{-17,58},{-17,54},{-10,56}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-30,75},{-21,77},{-21,73},{-30,75}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{60,75},{52,77},{52,73},{60,75}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-80,-30},{-30,-30},{-10,40},{20,40},{40,-30},{60,-30},{
              80,40},{100,40}},
              thickness=0.5),Polygon(
              points={{-39,40},{-41,30},{-37,30},{-39,40}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-39,-30},{-41,-20},{-37,-20},{-39,-30},{-39,-30}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{60,80},{60,-30}},
              color={192,192,192},
              pattern=LinePattern.Dash),Polygon(
              points={{40,56},{33,58},{33,54},{40,56}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{20,56},{27,58},{27,54},{20,56}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{20,56},{13,58},{13,54},{20,56}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-10,56},{-3,58},{-3,54},{-10,56}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Text(
              extent={{-34,70},{-5,60}},
              lineColor={160,160,164},
              textString="rising"),Text(
              extent={{16,70},{45,60}},
              lineColor={160,160,164},
              textString="falling"),Text(
              extent={{-73,75},{-53,95}},
              lineColor={192,192,192},
              textString="i")}),
      Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));
  end TrapezoidCurrent;

  model TableCurrent "Current source by linear interpolation in a table"
    parameter Real table[:, :]=[0, 0; 1, 1; 2, 4]
      "Table matrix (time = first column, current = second column)";
    extends Interfaces.CurrentSource(redeclare
        Modelica.Blocks.Sources.TimeTable signalSource(final table=table));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Line(points={{-66,-36},{-66,84},{34,84},{34,-36},
                {-66,-36},{-66,-6},{34,-6},{34,24},{-66,24},{-66,54},{34,54},{
                34,84},{-16,84},{-16,-37}}, color={192,192,192})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-80,68},{-80,-80}},
            color={192,192,192}),Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
            Polygon(
              points={{90,-70},{68,-62},{68,-78},{90,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Rectangle(
              extent={{-20,90},{30,-30}},
              lineColor={255,255,255},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(points={{-20,-30},{-20,90},{
            80,90},{80,-30},{-20,-30},{-20,0},{80,0},{80,30},{-20,30},{-20,60},
            {80,60},{80,90},{30,90},{30,-31}}),Text(
              extent={{-77,-42},{-38,-58}},
              lineColor={160,160,164},
              textString="offset"),Polygon(
              points={{-31,-30},{-33,-40},{-28,-40},{-31,-30}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Polygon(
              points={{-30,-70},{-33,-60},{-28,-60},{-30,-70},{-30,-70}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              points={{-31,-31},{-31,-70}},
              color={192,192,192}),Line(
              points={{-20,-20},{-20,-70}},
              color={192,192,192},
              pattern=LinePattern.Dash),Text(
              extent={{-38,-70},{8,-88}},
              lineColor={160,160,164},
              textString="startTime"),Line(
              points={{-20,-30},{-80,-30}},
              color={192,192,192},
              pattern=LinePattern.Dash),Text(
              extent={{66,-81},{91,-93}},
              lineColor={160,160,164},
              textString="time"),Text(
              extent={{-15,83},{24,68}},
              textString="time"),Text(
              extent={{33,83},{76,67}},
              textString="i"),Text(
              extent={{-73,75},{-53,95}},
              lineColor={192,192,192},
              textString="i")}),
      Documentation(info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p><br>This block generates a current source by <strong>linear interpolation</strong> in a table. The time points and current values are stored in a matrix <strong>table[i,j]</strong>, where the first column table[:,1] contains the time points and the second column contains the current to be interpolated. The table interpolation has the following properties:</p>
<ul>
<li>The time points need to be <strong>monotonically increasing</strong>.</li>
<li><strong>Discontinuities</strong> are allowed, by providing the same time point twice in the table.</li>
<li>Values <strong>outside</strong> of the table range, are computed by <strong>extrapolation</strong> through the last or first two points of the table.</li>
<li>If the table has only <strong>one row</strong>, no interpolation is performed and the current value is just returned independently of the actual time instant, i.e., this is a constant current source.</li>
<li>Via parameters <strong>startTime</strong> and <strong>offset</strong> the curve defined by the table can be shifted both in time and in the current.</li>
<li>The table is implemented in a numerically sound way by generating <strong>time events</strong> at interval boundaries.
    This generates continuously differentiable values for the integrator.</li>
</ul>
<p>Example:</p>
<pre>   table = [0  0
            1  0
            1  1
            2  4
            3  9
            4 16]
If, e.g., time = 1.0, the current i =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the current i =  2.5,
    e.g., time = 2.0, the current i =  4.0,
    e.g., time = 5.0, the current i = 23.0 (i.e., extrapolation). </pre>
<p><br> Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>", revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"));
  end TableCurrent;

  model SupplyVoltage "Supply voltage (positive and negative)"
    parameter SI.Voltage Vps=+15 "Positive supply";
    parameter SI.Voltage Vns=-15 "Negative supply";
    Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin ground
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage positiveSupply(final V=
          Vps)
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage negativeSupply(final V=-
          Vns) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  equation
    connect(pin_p, positiveSupply.p) annotation (Line(
        points={{-100,0},{-60,0}}, color={0,0,255}));
    connect(negativeSupply.n, pin_n) annotation (Line(
        points={{60,0},{100,0}}, color={0,0,255}));
    connect(positiveSupply.n, ground) annotation (Line(
        points={{-40,0},{0,0}}, color={0,0,255}));
    connect(ground, negativeSupply.p) annotation (Line(
        points={{0,0},{40,0}}, color={0,0,255}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Line(
            points={{-60,40},{-60,-40}},
            color={0,0,255}),
          Line(
            points={{40,40},{40,-40}},
            color={0,0,255}),
          Line(
            points={{-40,20},{-40,-20}},
            color={0,0,255}),
          Line(
            points={{60,20},{60,-20}},
            color={0,0,255}),
          Line(
            points={{-90,0},{-60,0}},
            color={0,0,255}),
          Line(
            points={{60,0},{90,0}},
            color={0,0,255}),
          Text(
            extent={{-150,110},{150,70}},
            lineColor={0,0,255},
            textString="%name"),
          Line(
            points={{-40,0},{-10,0}},
            color={0,0,255}),
          Line(
            points={{10,0},{40,0}},
            color={0,0,255}),
          Text(
            extent={{-100,40},{-80,20}},
            lineColor={0,0,255},
            textString="+"),
          Text(
            extent={{80,40},{100,20}},
            lineColor={0,0,255},
            textString="-"),
          Text(
            extent={{-10,40},{10,20}},
            lineColor={0,0,255},
            textString="0")}),
      Documentation(info="<html>
                       <p>This is a simple model of a constant supply voltage with positive and negative supply, the potential between positive and negative supply is accessible.</p>
                       </html>"));
  end SupplyVoltage;
  annotation (Documentation(info="<html>
<p>This package contains time-dependent and controlled voltage and current sources. Most of the sources use the behavior modeled in the Modelica.Blocks.Sources package. All sources are ideal in the sense that <strong>no</strong> internal resistances are included.</p>
</html>", revisions="<html>
<dl>
<dt>
<strong>Main Authors:</strong>
</dt>
<dd>
Christoph Clau&szlig;
    &lt;<a href=\"mailto:christoph@clauss-it.com\">christoph@clauss-it.com</a>&gt;<br>
    Andr&eacute; Schneider
    &lt;<a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden
</dd>
<dt>
<strong>Copyright:</strong>
</dt>
<dd>
Copyright &copy; 1998-2018, Modelica Association and Fraunhofer-Gesellschaft.<br>
<em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
under the terms of the <strong>Modelica license</strong>, see the license conditions
and the accompanying <strong>disclaimer</strong> in the documentation of package
Modelica in file \"Modelica/package.mo\".</em>
</dd>
</dl>
</html>"));
end Sources;
