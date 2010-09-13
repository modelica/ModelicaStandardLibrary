within Modelica;
package Icons "Library of icons"
  partial class Information "Icon for general information packages"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,174,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-14,56},{16,38}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-24,10},{16,10},{16,-44},{26,-44},{26,-54},{-14,-54},{-14,
                -2},{-24,-2},{-24,10}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
                              Documentation(info="<html>
<p>This icon indicate classes containing only documentation, intended for general description of e.g., concepts and features of a package.</p>
</html>"));
  end Information;
  extends Icons.Package;

  partial class Contact "Icon for contact information"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,70},{100,-72}},
            lineColor={0,0,0},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-100,-72},{100,-72},{0,20},{-100,-72}},
            lineColor={0,0,0},
            smooth=Smooth.None,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{22,0},{100,70},{100,-72},{22,0}},
            lineColor={0,0,0},
            smooth=Smooth.None,
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-100,70},{100,70},{0,-20},{-100,70}},
            lineColor={0,0,0},
            smooth=Smooth.None,
            fillColor={241,241,241},
            fillPattern=FillPattern.Solid)}),
                              Documentation(info="<html>
<p>This icon shall be used for the contact information of the library developers.</p>
</html>"));
  end Contact;

  partial class ReleaseNotes "Icon for release notes in documentation"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Polygon(
            points={{-80,-100},{-80,100},{0,100},{0,20},{80,20},{80,-100},{-80,
                -100}},
            lineColor={0,0,0},
            fillColor={215,230,240},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{0,100},{80,20},{0,20},{0,100}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Line(points={{2,-12},{50,-12}}, color={0,0,0}),
          Ellipse(
            extent={{-56,2},{-28,-26}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Line(points={{2,-60},{50,-60}}, color={0,0,0}),
          Ellipse(
            extent={{-56,-46},{-28,-74}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid)}),
                              Documentation(info="<html>
<p>This icon indicates release notes and the revision history of a library.</p>
</html>"));
  end ReleaseNotes;

  partial class References "Icon for external references"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Polygon(
            points={{-100,-80},{-100,60},{-80,54},{-80,80},{-40,58},{-40,100},{
                -10,60},{90,60},{100,40},{100,-100},{-20,-100},{-100,-80}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(points={{-20,-100},{-10,-80},{90,-80},{100,-100},{-20,-100}},
              lineColor={0,0,0}),
          Line(points={{90,-80},{90,60},{100,40},{100,-100}}, color={0,0,0}),
          Line(points={{90,60},{-10,60},{-10,-80}}, color={0,0,0}),
          Line(points={{-10,60},{-40,100},{-40,-40},{-10,-80},{-10,60}}, color=
                {0,0,0}),
          Line(points={{-20,-88},{-80,-60},{-80,80},{-40,58}}, color={0,0,0}),
          Line(points={{-20,-100},{-100,-80},{-100,60},{-80,54}}, color={0,0,0}),
          Line(points={{10,30},{72,30}}, color={0,0,0}),
          Line(points={{10,-10},{70,-10}}, color={0,0,0}),
          Line(points={{10,-50},{70,-50}}, color={0,0,0})}),
                              Documentation(info="<html>
<p>This icon indicates a documentation class containing references external documentation and litterature.</p>
</html>"));

  end References;

  partial package ExamplesPackage
    "Icon for packages containing runnable examples"
  //extends Modelica.Icons.Package;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
            extent={{-80,100},{100,-80}},
            lineColor={0,0,0},
            fillColor={215,230,240},
            fillPattern=FillPattern.Solid), Rectangle(
            extent={{-100,80},{80,-100}},
            lineColor={0,0,0},
            fillColor={240,240,240},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-58,46},{42,-14},{-58,-74},{-58,46}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>This icon indicates a package that contains executable examples.</p>
</html>"));
  end ExamplesPackage;

  partial model Example "Icon for runnable examples"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Ellipse(extent={{-100,100},{100,-100}},
              lineColor={95,95,95},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
                                     Polygon(
            points={{-36,60},{64,0},{-36,-60},{-36,60}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>This icon indicates an example. The play button suggests that the example can be executed.</p>
</html>"));
  end Example;

  partial package Package "Icon for standard packages"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
            extent={{-80,100},{100,-80}},
            lineColor={0,0,0},
            fillColor={215,230,240},
            fillPattern=FillPattern.Solid), Rectangle(
            extent={{-100,80},{80,-100}},
            lineColor={0,0,0},
            fillColor={240,240,240},
            fillPattern=FillPattern.Solid)}),
                              Documentation(info="<html>
<p>Standard package icon.</p>
</html>"));
  end Package;

  partial package BasesPackage "Icon for packages containing base classes"
  //extends Modelica.Icons.Package;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
            extent={{-80,100},{100,-80}},
            lineColor={0,0,0},
            fillColor={215,230,240},
            fillPattern=FillPattern.Solid), Rectangle(
            extent={{-100,80},{80,-100}},
            lineColor={0,0,0},
            fillColor={240,240,240},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-30,10},{10,-30}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
                              Documentation(info="<html>
<p>This icon shall be used for a package/library that contains base models and classes, respectively.</p>
</html>"));
  end BasesPackage;

  partial package VariantsPackage "Icon for package containing variants"
  //extends Modelica.Icons.Package;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
              {100,100}}),       graphics={Rectangle(
            extent={{-80,100},{100,-80}},
            lineColor={0,0,0},
            fillColor={215,230,240},
            fillPattern=FillPattern.Solid), Rectangle(
            extent={{-100,80},{80,-100}},
            lineColor={0,0,0},
            fillColor={240,240,240},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-80,-20},{-20,-80}},
            lineColor={0,0,0},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{0,-20},{60,-80}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{0,60},{60,0}},
            lineColor={0,0,0},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-80,60},{-20,0}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
                              Documentation(info="<html>
<p>This icon shall be used for a package/library that contains several variants of one components.</p>
</html>"));
  end VariantsPackage;

  partial package InterfacesPackage "Icon for packages containing interfaces"
  //extends Modelica.Icons.Package;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
            extent={{-80,100},{100,-80}},
            lineColor={0,0,0},
            fillColor={215,230,240},
            fillPattern=FillPattern.Solid), Rectangle(
            extent={{-100,80},{80,-100}},
            lineColor={0,0,0},
            fillColor={240,240,240},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{0,50},{20,50},{50,10},{80,10},{80,-30},{50,-30},{20,-70},{
                0,-70},{0,50}},
            lineColor={0,0,0},
            smooth=Smooth.None,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-100,10},{-70,10},{-40,50},{-20,50},{-20,-70},{-40,-70},{
                -70,-30},{-100,-30},{-100,10}},
            lineColor={0,0,0},
            smooth=Smooth.None,
            fillColor={215,230,240},
            fillPattern=FillPattern.Solid)}),
                              Documentation(info="<html>
<p>This icon indicates packages containing interfaces.</p>
</html>"));
  end InterfacesPackage;

  partial package SourcesPackage "Icon for packages containing sources"
  //extends Modelica.Icons.Package;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
            extent={{-80,100},{100,-80}},
            lineColor={0,0,0},
            fillColor={215,230,240},
            fillPattern=FillPattern.Solid), Rectangle(
            extent={{-100,80},{80,-100}},
            lineColor={0,0,0},
            fillColor={240,240,240},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-28,12},{-28,-40},{36,-14},{-28,12}},
            lineColor={0,0,0},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-28,-14},{-68,-14}},
            color={0,0,0},
            smooth=Smooth.None)}),
                              Documentation(info="<html>
<p>This icon indicates a package which contains sources.</p>
</html>"));
  end SourcesPackage;

  partial package SensorsPackage "Icon for packages containing sensors"
  //extends Modelica.Icons.Package;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
            extent={{-80,100},{100,-80}},
            lineColor={0,0,0},
            fillColor={215,230,240},
            fillPattern=FillPattern.Solid), Rectangle(
            extent={{-100,80},{80,-100}},
            lineColor={0,0,0},
            fillColor={240,240,240},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-70,20},{50,20}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(points={{-10,-70},{38,54}}, color={0,0,0}),
          Ellipse(
            extent={{-15,-65},{-5,-75}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-70,20},{-70,-8}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{50,20},{50,-8}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-10,20},{-10,-8}},
            color={0,0,0},
            smooth=Smooth.None)}),
                              Documentation(info="<html>
<p>This icon indicates a package containing sensors.</p>
</html>"));
  end SensorsPackage;

  partial class RotationalSensor "Icon representing a round measurement device"

    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
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
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
      Documentation(info="<html>
<p>
This icon is designed for a <b>rotational sensor</b> model.
</p>
</html>"));
  end RotationalSensor;

  partial class TranslationalSensor
    "Icon representing a linear measurement device"

    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
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
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
      Documentation(Error, info="<html>
<p>
This icon is designed for a <b>translational sensor</b> model.
</p></html>"));
  end TranslationalSensor;

  partial package MaterialPropertiesPackage
    "Icon for package containing property classes"
  //extends Modelica.Icons.Package;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
            extent={{-80,100},{100,-80}},
            lineColor={0,0,0},
            fillColor={215,230,240},
            fillPattern=FillPattern.Solid), Rectangle(
            extent={{-100,80},{80,-100}},
            lineColor={0,0,0},
            fillColor={240,240,240},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-68,50},{52,-70}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={215,230,240})}),
                              Documentation(info="<html>
<p>This icon indicates a package that contains properties</p>
</html>"));
  end MaterialPropertiesPackage;

  partial class MaterialProperty "Icon for property classes"

    annotation (Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
              {100,100}}),       graphics={
          Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={215,230,240})}),
                              Documentation(info="<html>
<p>This icon indicates a property class.</p>
</html>"));
  end MaterialProperty;

  partial function Function "Icon for functions"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Text(extent={{-140,162},{136,102}}, textString=
                                                 "%name"),
          Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-100,100},{100,-100}},
            lineColor={255,127,0},
            textString=
                 "f")}),Documentation(Error, info="<html>
<p>This icon indicates Modelica functions.</p>
</html>"));
  end Function;

  partial record Record "Icon for records"

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
This icon is indicates a record.
</p>
</html>"));
  end Record;

  record TypeComplex "Icon for Complex types"
    extends Complex;
      annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={215,230,240},
            fillPattern=FillPattern.Solid), Text(
            extent={{-94,94},{94,-94}},
            lineColor={0,0,0},
            fillColor={181,181,181},
            fillPattern=FillPattern.Solid,
            textString="C")}),
                        Documentation(info="<html>
<p>
This icon is designed for a <b>Complex</b> type.
</p>
</html>"));
  end TypeComplex;

  type TypeReal "Icon for Real types"
      extends Real;
      annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={215,230,240},
            fillPattern=FillPattern.Solid), Text(
            extent={{-94,94},{94,-94}},
            lineColor={0,0,0},
            fillColor={181,181,181},
            fillPattern=FillPattern.Solid,
            textString=
                 "R")}),Documentation(info="<html>
<p>
This icon is designed for a <b>Real</b> type.
</p>
</html>"));
  end TypeReal;

  type TypeInteger "Icon for Integer types"
      extends Integer;
      annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={215,230,240},
            fillPattern=FillPattern.Solid), Text(
            extent={{-94,94},{94,-94}},
            lineColor={0,0,0},
            fillColor={181,181,181},
            fillPattern=FillPattern.Solid,
            textString=
                 "I")}),Documentation(info="<html>
<p>
This icon is designed for an <b>Integer</b> type.
</p>
</html>"));
  end TypeInteger;

  type TypeBoolean "Icon for Boolean types"
      extends Boolean;
      annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={215,230,240},
            fillPattern=FillPattern.Solid), Text(
            extent={{-94,94},{94,-94}},
            lineColor={0,0,0},
            fillColor={181,181,181},
            fillPattern=FillPattern.Solid,
            textString=
                 "B")}),Documentation(Error, info="<html>
<p>
This icon is designed for a <b>Boolean</b> type.
</p></html>"));
  end TypeBoolean;

  type TypeString "Icon for String types"
      extends String;
      annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={215,230,240},
            fillPattern=FillPattern.Solid), Text(
            extent={{-94,94},{94,-94}},
            lineColor={0,0,0},
            fillColor={181,181,181},
            fillPattern=FillPattern.Solid,
            textString=
                 "S")}),Documentation(info="<html>
<p>
This icon is designed for a <b>String</b> type.
</p>
</html>"));
  end TypeString;

  connector SignalBus "Icon for signal bus"

    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
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
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2},
          initialScale=0.2), graphics={
          Polygon(
            points={{-40,25},{40,25},{50,15},{40,-20},{30,-25},{-30,-25},{-40,
                -20},{-50,15},{-40,25}},
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
            textString=
                 "%name")}),
      Documentation(Error, info="<html>
This icon is designed for a <b>signal bus</b> connector.
</html>"));
  end SignalBus;

  connector SignalSubBus "Icon for signal sub-bus"

    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
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
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2},
          initialScale=0.1), graphics={
          Polygon(
            points={{-40,25},{40,25},{50,15},{40,-20},{30,-25},{-30,-25},{-40,
                -20},{-50,15},{-40,25}},
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
            textString=
                 "%name")}),
      Documentation(info="<html>
<p>
This icon is designed for a <b>sub-bus</b> in a signal connector.
</p>
</html>"));

  end SignalSubBus;

  partial class UnderConstruction

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Polygon(
            points={{-100,-100},{0,80},{100,-100},{-100,-100}},
            lineColor={255,0,0},
            lineThickness=0.5,
            smooth=Smooth.None)}), Documentation(info="<html>
<p>Library developers can use this icon to indicate that the respective model is under construction.</p>
</html>"));
  end UnderConstruction;

  partial class ObsoleteModel
    "Icon for classes that are obsolete and will be removed in later versions"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
            extent={{-102,102},{102,-102}},
            lineColor={255,0,0},
            pattern=LinePattern.Dash,
            lineThickness=0.5)}), Documentation(info="<html>
<p>
This partial class is intended to provide a <u>default icon
for an obsolete model</u> that will be removed from the
corresponding library in a future release.
<p>
</html>"));
  end ObsoleteModel;

  partial package Library
    "This icon will be removed in future Modelica versions, use Package instead"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
            extent={{-80,100},{100,-80}},
            lineColor={0,0,0},
            fillColor={215,230,240},
            fillPattern=FillPattern.Solid), Rectangle(
            extent={{-100,80},{80,-100}},
            lineColor={0,0,0},
            fillColor={240,240,240},
            fillPattern=FillPattern.Solid)}),
                              Documentation(info="<html>
<p>This icon of a package will be removed in future versions of the library.</p>
<h5>Note</h5>
<p>This icon will be removed in future versions of the Modelica Standard Library. Instead the icon <a href=\"modelica://Modelica.Icons.Package\">Package</a> shall be used.</p>
</html>"));
  end Library;

  partial package Library2
    "This icon will be removed in future Modelica versions, use Package instead"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
            extent={{-80,100},{100,-80}},
            lineColor={0,0,0},
            fillColor={215,230,240},
            fillPattern=FillPattern.Solid), Rectangle(
            extent={{-100,80},{80,-100}},
            lineColor={0,0,0},
            fillColor={240,240,240},
            fillPattern=FillPattern.Solid)}),
                              Documentation(info="<html>
<p>This icon of a package will be removed in future versions of the library.</p>
<h5>Note</h5>
<p>This icon will be removed in future versions of the Modelica Standard Library. Instead the icon <a href=\"modelica://Modelica.Icons.Package\">Package</a> shall be used.</p></html>"));
  end Library2;

  partial class GearIcon
    "This icon will be removed in future Modelica versions"

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
This icon of a <b>gearbox</b> will be removed in future versions of the library. Please use one of the icons of <a href=\"modelica://Modelica.Mechanics.Rotational.Icons\">Mechanics.Rotational.Icons</a> instead.
</p>
</html>"));
  end GearIcon;

  partial class MotorIcon
    "This icon will be removed in future Modelica versions."

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
This icon of an <b>electrical motor</b> model will be removed in future versions of the library. Please use a locally defined icon in your user defined libraries and applications.
</p>
</html>"));
  end MotorIcon;

  partial class Info "Icon for general information packages"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,174,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-14,56},{16,38}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-24,10},{16,10},{16,-44},{26,-44},{26,-54},{-14,-54},{-14,
                -2},{-24,-2},{-24,10}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
                              Documentation(info="<html>
<p>This icon indicate classes containing only documentation, intended for general description of e.g., concepts and features of a package.</p>
<h5>Note</h5>
<p>This icon will be removed in future versions of the Modelica Standard Library. Instead the icon <a href=\"modelica://Modelica.Icons.Informationrmationrmation\">Information</a> shall be used.</p></html>"));
  end Info;
  annotation(Documentation(__Dymola_DocumentationClass=true, info="<html>
<p>This package contains definitions for the graphical layout of components which may be used in different libraries. The icons can be utilized by inheriting them in the desired class using &QUOT;extends&QUOT; or by directly copying the &QUOT;icon&QUOT; layer. </p>
<dl>
<dt><b>Main Authors:</b> </dt>
    <dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a></dd><dd>Deutsches Zentrum fuer Luft und Raumfahrt e.V. (DLR)</dd><dd>Oberpfaffenhofen</dd><dd>Postfach 1116</dd><dd>D-82230 Wessling</dd><dd>email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd><br>
    <dd>Christian Kral</dd><dd><a href=\"http://www.ait.ac.at/\">Austrian Institute of Technology, AIT</a></dd><dd>Mobility Department</dd><dd>Giefinggasse 2</dd><dd>1210 Vienna, Austria</dd><dd>email: <a href=\"mailto:christian.kral@ait.ac.at\">christian.kral@ait.ac.at</a></dd><br>
    <dd align=\"justify\">Johan Andreasson</dd><dd align=\"justify\"><a href=\"http://www.modelon.se/\">Modelon AB</a></dd><dd align=\"justify\">Ideon Science Park</dd><dd align=\"justify\">22370 Lund, Sweden</dd><dd align=\"justify\">email: <a href=\"johan.andreasson@modelon.se\">johan.andreasson@modelon.se</a></dd>
</dl>
<p>Copyright &copy; 1998-2010, Modelica Association, DLR, AIT, and Modelon AB. </p>
<p><i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>, see the license conditions and the accompanying <b>disclaimer</b> in <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a>.</i> </p>
</html>"));
end Icons;
