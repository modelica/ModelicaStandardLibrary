within Modelica;
package Icons "Library of icons"

  partial model Info "Icon for an information class"

    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(extent={{-100,80},{80,-90}}, lineColor={0,0,255}),
          Polygon(
            points={{-100,80},{-90,90},{90,90},{80,80},{-100,80}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Polygon(
            points={{80,-90},{90,-80},{90,90},{80,80},{80,-90}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{-80,70},{60,-70}},
            textString="Info",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(extent={{-100,80},{80,-90}}, lineColor={0,0,255}),
          Polygon(
            points={{-100,80},{-90,90},{90,90},{80,80},{-100,80}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Polygon(
            points={{80,-90},{90,-80},{90,90},{80,80},{80,-90}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{-80,70},{60,-70}},
            textString="Info",
            lineColor={0,0,255})}),
      Documentation(info="<html>
<p>
This icon is designed for an <b>information</b> class.
</p>
</html>"));
  end Info;

  partial package Library "Icon for library"

    annotation (             Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-100,-100},{80,50}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Polygon(
            points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Polygon(
            points={{100,70},{100,-80},{80,-100},{80,50},{100,70}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{-85,35},{65,-85}},
            lineColor={0,0,255},
            textString="Library"),
          Text(
            extent={{-120,122},{120,73}},
            lineColor={255,0,0},
            textString="%name")}),
      Documentation(info="<html>
<p>
This icon is designed for a <b>library</b>.
</p>
</html>"));
  end Library;

  partial package Library2
    "Icon for library where additional icon elements shall be added"

    annotation (             Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-100,-100},{80,50}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Polygon(
            points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Polygon(
            points={{100,70},{100,-80},{80,-100},{80,50},{100,70}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{-120,125},{120,70}},
            lineColor={255,0,0},
            textString="%name"),
          Text(
            extent={{-90,40},{70,10}},
            lineColor={160,160,164},
            textString="Library")}),
      Documentation(info="<html>
<p>
This icon is designed for a <b>package</b> where a package
specific graphic is additionally included in the icon.
</p>
</html>"));
  end Library2;

  partial model Example "Icon for an example model"

    annotation (             Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-100,-100},{80,50}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Polygon(
            points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Polygon(
            points={{100,70},{100,-80},{80,-100},{80,50},{100,70}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{-96,3},{77,-49}},
            lineColor={0,0,255},
            textString="Example"),
          Text(
            extent={{-120,132},{120,73}},
            lineColor={255,0,0},
            textString="%name")}),
      Documentation(info="<html>
<p>
This icon is designed for an <b>Example package</b>,
i.e. a package containing executable demo models.
</p>
</html>"));
  end Example;

  partial function Function "Icon for a function"

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={
          Text(
            extent={{-140,162},{136,102}},
            textString="%name",
            lineColor={0,0,255}),
          Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-100,100},{100,-100}},
            lineColor={255,127,0},
            textString="f")}),
                        Documentation(info="<html>
<p>
This icon is designed for a <b>function</b>
</p>
</html>"));
  end Function;

  partial record Record "Icon for a record"

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,50},{100,-100}},
            fillColor={255,255,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{-127,115},{127,55}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-100,-50},{100,-50}}, color={0,0,0}),
          Line(points={{-100,0},{100,0}}, color={0,0,0}),
          Line(points={{0,50},{0,-100}}, color={0,0,0})}),
                                                        Documentation(info="<html>
<p>
This icon is designed for a <b>record</b>
</p>
</html>"));
  end Record;

  type TypeReal "Icon for a Real type"
      extends Real;
      annotation(Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={181,181,181},
            fillPattern=FillPattern.Solid), Text(
            extent={{-94,94},{94,-94}},
            lineColor={0,0,0},
            textString="R")}),
                        Documentation(info="<html>
<p>
This icon is designed for a <b>Real</b> type.
</p>
</html>"));
  end TypeReal;

  type TypeInteger "Icon for an Integer type"
      extends Integer;
      annotation(Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={181,181,181},
            fillPattern=FillPattern.Solid), Text(
            extent={{-94,94},{94,-94}},
            lineColor={0,0,0},
            textString="I")}),
                        Documentation(info="<html>
<p>
This icon is designed for an <b>Integer</b> type.
</p>
</html>"));
  end TypeInteger;

  type TypeBoolean "Icon for a Boolean type"
      extends Boolean;
      annotation(Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={181,181,181},
            fillPattern=FillPattern.Solid), Text(
            extent={{-94,94},{94,-94}},
            lineColor={0,0,0},
            textString="B")}),
                        Documentation(info="<html>
<p>
This icon is designed for a <b>Boolean</b> type.
</p>
</html>"));
  end TypeBoolean;

  type TypeString "Icon for a String type"
      extends String;
      annotation(Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={181,181,181},
            fillPattern=FillPattern.Solid), Text(
            extent={{-94,94},{94,-94}},
            lineColor={0,0,0},
            textString="S")}),
                        Documentation(info="<html>
<p>
This icon is designed for a <b>String</b> type.
</p>
</html>"));
  end TypeString;

  partial model TranslationalSensor
    "Icon representing translational measurement device"

    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-70,-60},{70,20}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{0,-40},{-10,-16},{10,-16},{0,-40}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{0,0},{0,-16}}, color={0,0,0}),
          Line(points={{-70,0},{0,0}}, color={0,0,0}),
          Line(points={{-50,-40},{-50,-60}}, color={0,0,0}),
          Line(points={{-30,-40},{-30,-60}}, color={0,0,0}),
          Line(points={{-10,-40},{-10,-60}}, color={0,0,0}),
          Line(points={{10,-40},{10,-60}}, color={0,0,0}),
          Line(points={{30,-40},{30,-60}}, color={0,0,0}),
          Line(points={{50,-40},{50,-60}}, color={0,0,0})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
      Documentation(info="<html>
<p>
This icon is designed for a <b>translational sensor</b> model.
</p>
</html>"));

  end TranslationalSensor;

  partial model RotationalSensor
    "Icon representing rotational measurement device"

    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Ellipse(
            extent={{-70,70},{70,-70}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{0,70},{0,40}}, color={0,0,0}),
          Line(points={{22.9,32.8},{40.2,57.3}}, color={0,0,0}),
          Line(points={{-22.9,32.8},{-40.2,57.3}}, color={0,0,0}),
          Line(points={{37.6,13.7},{65.8,23.9}}, color={0,0,0}),
          Line(points={{-37.6,13.7},{-65.8,23.9}}, color={0,0,0}),
          Line(points={{0,0},{9.02,28.6}}, color={0,0,0}),
          Polygon(
            points={{-0.48,31.6},{18,26},{18,57.2},{-0.48,31.6}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-5,5},{5,-5}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
      Documentation(info="<html>
<p>
This icon is designed for a <b>rotational sensor</b> model.
</p>
</html>"));

  end RotationalSensor;

  partial model GearIcon "Icon for gearbox"

    annotation (             Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-90,10},{-60,-10}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Polygon(
            points={{-60,10},{-60,20},{-40,40},{-40,-40},{-60,-20},{-60,10}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={128,128,128}),
          Rectangle(
            extent={{-40,60},{40,-60}},
            lineColor={0,0,0},
            pattern=LinePattern.Solid,
            lineThickness=0.25,
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Polygon(
            points={{60,20},{40,40},{40,-40},{60,-20},{60,20}},
            lineColor={128,128,128},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{60,10},{90,-10}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Polygon(
            points={{-60,-90},{-50,-90},{-20,-30},{20,-30},{48,-90},{60,-90},{
                60,-100},{-60,-100},{-60,-90}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>
This icon is designed for a <b>gearbox</b> model.
</p>
</html>"));

  end GearIcon;

  partial model MotorIcon "Icon for electrical motor"

    annotation (             Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-100,50},{30,-50}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={255,0,0}),
          Polygon(
            points={{-100,-90},{-90,-90},{-60,-20},{-10,-20},{20,-90},{30,-90},
                {30,-100},{-100,-100},{-100,-90}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{30,10},{90,-10}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192})}),
      Documentation(info="<html>
<p>
This icon is designed for an <b>electrical motor</b> model.
</p>
</html>"));
  end MotorIcon;

  connector SignalBus "Icon for signal bus"

    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2},
          initialScale=0.2), graphics={
          Rectangle(
            extent={{-20,2},{20,-2}},
            lineColor={255,204,51},
            lineThickness=0.5),
          Polygon(
            points={{-80,50},{80,50},{100,30},{80,-40},{60,-50},{-60,-50},{-80,
                -40},{-100,30},{-80,50}},
            lineColor={0,0,0},
            fillColor={255,204,51},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-65,25},{-55,15}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-5,25},{5,15}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{55,25},{65,15}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-35,-15},{-25,-25}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{25,-15},{35,-25}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2},
          initialScale=0.2), graphics={
          Polygon(
            points={{-40,25},{40,25},{50,15},{40,-20},{30,-25},{-30,-25},{-40,-20},
                {-50,15},{-40,25}},
            lineColor={0,0,0},
            fillColor={255,204,51},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-32.5,7.5},{-27.5,12.5}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-2.5,12.5},{2.5,7.5}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{27.5,12.5},{32.5,7.5}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-17.5,-7.5},{-12.5,-12.5}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{12.5,-7.5},{17.5,-12.5}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,70},{150,40}},
            lineColor={0,0,0},
            textString="%name")}),
      Documentation(info="<html>
<p>
This icon is designed for a <b>signal bus</b> connector.
</p>
</html>"));

  end SignalBus;

  connector SignalSubBus "Icon for signal sub-bus"

    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2},
          initialScale=0.1), graphics={
          Line(
            points={{-16,2},{16,2}},
            color={255,204,51},
            thickness=0.5),
          Rectangle(
            extent={{-10,8},{8,0}},
            lineColor={255,204,51},
            lineThickness=0.5),
          Polygon(
            points={{-80,50},{80,50},{100,30},{80,-40},{60,-50},{-60,-50},{-80,
                -40},{-100,30},{-80,50}},
            lineColor={0,0,0},
            fillColor={255,204,51},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-55,25},{-45,15}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{45,25},{55,15}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-5,-15},{5,-25}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-20,4},{20,0}},
            lineColor={255,204,51},
            lineThickness=0.5)}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2},
          initialScale=0.1), graphics={
          Polygon(
            points={{-40,25},{40,25},{50,15},{40,-20},{30,-25},{-30,-25},{-40,-20},
                {-50,15},{-40,25}},
            lineColor={0,0,0},
            fillColor={255,204,51},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-22.5,7.5},{-17.5,12.5}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{17.5,12.5},{22.5,7.5}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-2.5,-7.5},{2.5,-12.5}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,70},{150,40}},
            lineColor={0,0,0},
            textString="%name")}),
      Documentation(info="<html>
<p>
This icon is designed for a <b>sub-bus</b> in a signal connector.
</p>
</html>"));

  end SignalSubBus;

  partial model ObsoleteModel
    "Icon for an obsolete model (use only for this case)"

    annotation (__Dymola_obsolete="Only used to mark an obsolete model. Do not use otherwise.",
            Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics={Rectangle(
            extent={{-102,102},{102,-102}},
            lineColor={255,0,0},
            pattern=LinePattern.Dash,
            lineThickness=0.5)}),        Documentation(info="<html>
<p>
This partial model is intended to provide a <u>default icon
for an obsolete model</u> that will be removed from the
corresponding library in a future release.
<p>
</html>"));

  end ObsoleteModel;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-100,-100},{80,50}},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Polygon(
          points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Polygon(
          points={{100,70},{100,-80},{80,-100},{80,50},{100,70}},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Text(
          extent={{-120,135},{120,70}},
          lineColor={255,0,0},
          textString="%name"),
        Text(
          extent={{-90,40},{70,10}},
          lineColor={160,160,164},
          textString="Library"),
        Rectangle(
          extent={{-100,-100},{80,50}},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Polygon(
          points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Polygon(
          points={{100,70},{100,-80},{80,-100},{80,50},{100,70}},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Text(
          extent={{-90,40},{70,10}},
          lineColor={160,160,164},
          textString="Library"),
        Polygon(
          points={{-64,-20},{-50,-4},{50,-4},{36,-20},{-64,-20},{-64,-20}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-64,-20},{36,-84}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,-24},{32,-38}},
          lineColor={128,128,128},
          textString="Library"),
        Polygon(
          points={{50,-4},{50,-70},{36,-84},{36,-20},{50,-4}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid)}),
                            Documentation(info="<html>
<p>
This package contains definitions for the graphical layout of
components which may be used in different libraries.
The icons can be utilized by inheriting them in the desired class
using \"extends\" or by directly copying the \"icon\" layer.
</p>

<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum fuer Luft und Raumfahrt e.V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>

<p>
Copyright &copy; 1998-2009, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b>
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a>.</i>
</p><br>
</HTML>
", revisions="<html>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Added new icons <b>Function</b>, <b>Enumerations</b> and <b>Record</b>.</li>
<li><i>June 6, 2000</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Replaced <b>model</b> keyword by <b>package</b> if the main
       usage is for inheriting from a package.<br>
       New icons <b>GearIcon</b> and <b>MotorIcon</b>.</li>
<li><i>Sept. 18, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Renaming package Icon to Icons.
       Model Advanced removed (icon not accepted on the Modelica meeting).
       New model Library2, which is the Library icon with enough place
       to add library specific elements in the icon. Icon also used in diagram
       level for models Info, TranslationalSensor, RotationalSensor.</li>
<li><i>July 15, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Model Caution renamed to Advanced, model Sensor renamed to
       TranslationalSensor, new model RotationalSensor.</li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version.</li>
</ul>
<br>
</html>"));
end Icons;
