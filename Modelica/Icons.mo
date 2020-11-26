within Modelica;
package Icons "Library of icons"
  partial class Information "Icon for general information packages"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Ellipse(
            lineColor={75,138,73},
            fillColor={75,138,73},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-100.0,-100.0},{100.0,100.0}}),
          Polygon(origin={-4.167,-15.0},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,-50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}},
            smooth=Smooth.Bezier),
          Ellipse(origin={7.5,56.5},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-12.5,-12.5},{12.5,12.5}})}),
                              Documentation(info="<html>
<p>This icon indicates classes containing only documentation, intended for general description of, e.g., concepts and features of a package.</p>
</html>"));
  end Information;
  extends Icons.Package;

  partial class Contact "Icon for contact information"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,70},{100,-72}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-100,-72},{100,-72},{0,20},{-100,-72}},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{22,0},{100,70},{100,-72},{22,0}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-100,70},{100,70},{0,-20},{-100,70}},
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
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{0,100},{80,20},{0,20},{0,100}},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Line(points={{2,-12},{50,-12}}),
          Ellipse(
            extent={{-56,2},{-28,-26}},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Line(points={{2,-60},{50,-60}}),
          Ellipse(
            extent={{-56,-46},{-28,-74}},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid)}), Documentation(info="<html>
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
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid),
          Polygon(points={{-20,-100},{-10,-80},{90,-80},{100,-100},{-20,-100}}),
          Line(points={{90,-80},{90,60},{100,40},{100,-100}}),
          Line(points={{90,60},{-10,60},{-10,-80}}),
          Line(points={{-10,60},{-40,100},{-40,-40},{-10,-80},{-10,60}}),
          Line(points={{-20,-88},{-80,-60},{-80,80},{-40,58}}),
          Line(points={{-20,-100},{-100,-80},{-100,60},{-80,54}}),
          Line(points={{10,30},{72,30}}),
          Line(points={{10,-10},{70,-10}}),
          Line(points={{10,-50},{70,-50}})}), Documentation(info=
           "<html>
<p>This icon indicates a documentation class containing references to external documentation and literature.</p>
</html>"));

  end References;

  partial package ExamplesPackage
    "Icon for packages containing runnable examples"
    extends Modelica.Icons.Package;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Polygon(
            origin={8.0,14.0},
            lineColor={78,138,73},
            fillColor={78,138,73},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}), Documentation(info="<html>
<p>This icon indicates a package that contains executable examples.</p>
</html>"));
  end ExamplesPackage;

  partial model Example "Icon for runnable examples"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent = {{-100,-100},{100,100}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points = {{-36,60},{64,0},{-36,-60},{-36,60}})}), Documentation(info="<html>
<p>This icon indicates an example. The play button suggests that the example can be executed.</p>
</html>"));
  end Example;

  partial package Package "Icon for standard packages"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            lineColor={200,200,200},
            fillColor={248,248,248},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100.0,-100.0},{100.0,100.0}},
            radius=25.0),
          Rectangle(
            lineColor={128,128,128},
            extent={{-100.0,-100.0},{100.0,100.0}},
            radius=25.0)}), Documentation(info="<html>
<p>Standard package icon.</p>
</html>"));
  end Package;

  partial package BasesPackage "Icon for packages containing base classes"
    extends Modelica.Icons.Package;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Ellipse(
            extent={{-30.0,-30.0},{30.0,30.0}},
            lineColor={128,128,128},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
                              Documentation(info="<html>
<p>This icon shall be used for a package/library that contains base models and classes, respectively.</p>
</html>"));
  end BasesPackage;

  partial package VariantsPackage "Icon for package containing variants"
    extends Modelica.Icons.Package;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,100}}),
        graphics={
          Ellipse(
            extent={{-70.0,-70.0},{-10.0,-10.0}},
            lineColor={76,76,76},
            fillColor={76,76,76},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{70.0,-70.0},{10.0,-10.0}},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{70.0,70.0},{10.0,10.0}},
            lineColor={128,128,128},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-70.0,70.0},{-10.0,10.0}},
            lineColor={128,128,128},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>This icon shall be used for a package/library that contains several variants of one component.</p>
</html>"));
  end VariantsPackage;

  partial package InterfacesPackage "Icon for packages containing interfaces"
    extends Modelica.Icons.Package;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
          Polygon(
            lineColor={64,64,64},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            points={{10,70},{30,70},{60,20},{100,20},{100,-20},{60,-20},{30,-70},{10,-70}}),
          Polygon(
            lineColor={102,102,102},
            fillColor={102,102,102},
            fillPattern=FillPattern.Solid,
            points={{-100,20},{-60,20},{-30,70},{-10,70},{-10,-70},{-30,-70},{-60,-20},{-100,-20}})}),
      Documentation(info="<html>
<p>This icon indicates packages containing interfaces.</p>
</html>"));
  end InterfacesPackage;

  partial package SourcesPackage "Icon for packages containing sources"
    extends Modelica.Icons.Package;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Polygon(origin={23.3333,0.0},
            fillColor={128,128,128},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-23.333,30.0},{46.667,0.0},{-23.333,-30.0}}),
          Rectangle(
            fillColor = {128,128,128},
            pattern = LinePattern.None,
            fillPattern = FillPattern.Solid,
            extent = {{-70,-4.5},{0,4.5}})}),
                              Documentation(info="<html>
<p>This icon indicates a package which contains sources.</p>
</html>"));
  end SourcesPackage;

  partial package SensorsPackage "Icon for packages containing sensors"
    extends Modelica.Icons.Package;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Ellipse(origin={0.0,-30.0},
            fillColor={255,255,255},
            extent={{-90.0,-90.0},{90.0,90.0}},
            startAngle=20.0,
            endAngle=160.0),
          Ellipse(origin={0.0,-30.0},
            fillColor={128,128,128},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-20.0,-20.0},{20.0,20.0}}),
          Line(origin={0.0,-30.0},
            points={{0.0,60.0},{0.0,90.0}}),
          Ellipse(origin={-0.0,-30.0},
            fillColor={64,64,64},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-10.0,-10.0},{10.0,10.0}}),
          Polygon(
            origin={-0.0,-30.0},
            rotation=-35.0,
            fillColor={64,64,64},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-7.0,0.0},{-3.0,85.0},{0.0,90.0},{3.0,85.0},{7.0,0.0}})}),
                              Documentation(info="<html>
<p>This icon indicates a package containing sensors.</p>
</html>"));
  end SensorsPackage;

  partial package UtilitiesPackage "Icon for utility packages"
    extends Modelica.Icons.Package;
     annotation (Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
    Polygon(
      origin={1.3835,-4.1418},
      rotation=45.0,
      fillColor={64,64,64},
      pattern=LinePattern.None,
      fillPattern=FillPattern.Solid,
      points={{-15.0,93.333},{-15.0,68.333},{0.0,58.333},{15.0,68.333},{15.0,93.333},{20.0,93.333},{25.0,83.333},{25.0,58.333},{10.0,43.333},{10.0,-41.667},{25.0,-56.667},{25.0,-76.667},{10.0,-91.667},{0.0,-91.667},{0.0,-81.667},{5.0,-81.667},{15.0,-71.667},{15.0,-61.667},{5.0,-51.667},{-5.0,-51.667},{-15.0,-61.667},{-15.0,-71.667},{-5.0,-81.667},{0.0,-81.667},{0.0,-91.667},{-10.0,-91.667},{-25.0,-76.667},{-25.0,-56.667},{-10.0,-41.667},{-10.0,43.333},{-25.0,58.333},{-25.0,83.333},{-20.0,93.333}}),
    Polygon(
      origin={10.1018,5.218},
      rotation=-45.0,
      fillColor={255,255,255},
      fillPattern=FillPattern.Solid,
      points={{-15.0,87.273},{15.0,87.273},{20.0,82.273},{20.0,27.273},{10.0,17.273},{10.0,7.273},{20.0,2.273},{20.0,-2.727},{5.0,-2.727},{5.0,-77.727},{10.0,-87.727},{5.0,-112.727},{-5.0,-112.727},{-10.0,-87.727},{-5.0,-77.727},{-5.0,-2.727},{-20.0,-2.727},{-20.0,2.273},{-10.0,7.273},{-10.0,17.273},{-20.0,27.273},{-20.0,82.273}})}),
    Documentation(info="<html>
<p>This icon indicates a package containing utility classes.</p>
</html>"));
  end UtilitiesPackage;

  partial package TypesPackage "Icon for packages containing type definitions"
    extends Modelica.Icons.Package;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Polygon(
            origin={-12.167,-23},
            fillColor={128,128,128},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{12.167,65},{14.167,93},{36.167,89},{24.167,20},{4.167,-30},
                {14.167,-30},{24.167,-30},{24.167,-40},{-5.833,-50},{-15.833,
                -30},{4.167,20},{12.167,65}},
            smooth=Smooth.Bezier), Polygon(
            origin={2.7403,1.6673},
            fillColor={128,128,128},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{49.2597,22.3327},{31.2597,24.3327},{7.2597,18.3327},{-26.7403,
              10.3327},{-46.7403,14.3327},{-48.7403,6.3327},{-32.7403,0.3327},{-6.7403,
              4.3327},{33.2597,14.3327},{49.2597,14.3327},{49.2597,22.3327}},
            smooth=Smooth.Bezier)}));
  end TypesPackage;

  partial package FunctionsPackage "Icon for packages containing functions"
    extends Modelica.Icons.Package;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
            Text(
              textColor={128,128,128},
              extent={{-90,-90},{90,90}},
              textString="f")}));
  end FunctionsPackage;

  partial package IconsPackage "Icon for packages containing icons"
    extends Modelica.Icons.Package;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Polygon(
            origin={-8.167,-17},
            fillColor={128,128,128},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{
                4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,
                -50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}},
            smooth=Smooth.Bezier), Ellipse(
            origin={-0.5,56.5},
            fillColor={128,128,128},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-12.5,-12.5},{12.5,12.5}})}));
  end IconsPackage;

  partial package InternalPackage
    "Icon for an internal package (indicating that the package should not be directly utilized by user)"

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          lineColor={215,215,215},
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100,-100},{100,100}},
          radius=25),
        Rectangle(
          lineColor={215,215,215},
          extent={{-100,-100},{100,100}},
          radius=25),
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={215,215,215},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-55,55},{55,-55}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,14},{60,-14}},
          lineColor={215,215,215},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          rotation=45)}),
    Documentation(info="<html>

<p>
This icon shall be used for a package that contains internal classes not to be
directly utilized by a user.
</p>
</html>"));
  end InternalPackage;

  partial package MaterialPropertiesPackage
    "Icon for package containing property classes"
    extends Modelica.Icons.Package;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Ellipse(
            lineColor={102,102,102},
            fillColor={204,204,204},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Sphere,
            extent={{-60.0,-60.0},{60.0,60.0}})}),
                              Documentation(info="<html>
<p>This icon indicates a package that contains properties</p>
</html>"));
  end MaterialPropertiesPackage;

  partial package RecordsPackage "Icon for package containing records"
    extends Modelica.Icons.Package;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Rectangle(
            origin={0,-20},
            lineColor={64,64,64},
            fillColor={255,215,136},
            fillPattern=FillPattern.Solid,
            extent={{-80,-60},{80,60}},
            radius=25.0),
          Line(
            points={{-80,0},{80,0}},
            color={64,64,64}),
          Line(
            origin={0,-40},
            points={{-80,0},{80,0}},
            color={64,64,64}),
          Line(
            origin={0,-5},
            points={{0,45},{0,-75}},
            color={64,64,64})}),
                              Documentation(info="<html>
<p>This icon indicates a package that contains records</p>
</html>"));
  end RecordsPackage;

  partial class MaterialProperty "Icon for property classes"

    annotation (Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,100}}), graphics={
          Ellipse(lineColor={102,102,102},
            fillColor={204,204,204},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Sphere,
            extent={{-100.0,-100.0},{100.0,100.0}})}),
                              Documentation(info="<html>
<p>This icon indicates a property class.</p>
</html>"));
  end MaterialProperty;

  partial class RoundSensor "Icon representing a round measurement device"

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Ellipse(
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            extent={{-70.0,-70.0},{70.0,70.0}}),
          Line(points={{0.0,70.0},{0.0,40.0}}),
          Line(points={{22.9,32.8},{40.2,57.3}}),
          Line(points={{-22.9,32.8},{-40.2,57.3}}),
          Line(points={{37.6,13.7},{65.8,23.9}}),
          Line(points={{-37.6,13.7},{-65.8,23.9}}),
          Ellipse(
            lineColor={64,64,64},
            fillColor={255,255,255},
            extent={{-12.0,-12.0},{12.0,12.0}}),
          Polygon(
            rotation=-17.5,
            fillColor={64,64,64},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-5.0,0.0},{-2.0,60.0},{0.0,65.0},{2.0,60.0},{5.0,0.0}}),
          Ellipse(
            fillColor={64,64,64},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-7.0,-7.0},{7.0,7.0}})}),
      Documentation(info="<html>
<p>
This icon is designed for a <strong>rotational sensor</strong> model.
</p>
</html>"));
  end RoundSensor;

  partial class RectangularSensor
    "Icon representing a linear measurement device"

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            extent={{-70.0,-60.0},{70.0,20.0}}),
          Polygon(
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-40,-40},{-50,-16},{-30,-16},{-40,-40}}),
          Line(points={{-40,0},{-40,-16}}),
          Line(points={{-70,0},{-40,0}}),
          Line(points={{-50.0,-40.0},{-50.0,-60.0}}),
          Line(points={{-30.0,-40.0},{-30.0,-60.0}}),
          Line(points={{-10.0,-40.0},{-10.0,-60.0}}),
          Line(points={{10.0,-40.0},{10.0,-60.0}}),
          Line(points={{30.0,-40.0},{30.0,-60.0}}),
          Line(points={{50.0,-40.0},{50.0,-60.0}})}),
      Documentation(info="<html>
<p>
This icon is designed for a <strong>translational sensor</strong> model.
</p></html>"));
  end RectangularSensor;

  partial function Function "Icon for functions"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Text(
            textColor={0,0,255},
            extent={{-150,105},{150,145}},
            textString="%name"),
          Ellipse(
            lineColor = {108,88,49},
            fillColor = {255,215,136},
            fillPattern = FillPattern.Solid,
            extent = {{-100,-100},{100,100}}),
          Text(
            textColor={108,88,49},
            extent={{-90.0,-90.0},{90.0,90.0}},
            textString="f")}),
  Documentation(info="<html>
<p>This icon indicates Modelica functions.</p>
</html>"));
  end Function;

  partial record Record "Icon for records"

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
          Text(
            textColor={0,0,255},
            extent={{-150,60},{150,100}},
            textString="%name"),
          Rectangle(
            origin={0.0,-25.0},
            lineColor={64,64,64},
            fillColor={255,215,136},
            fillPattern=FillPattern.Solid,
            extent={{-100.0,-75.0},{100.0,75.0}},
            radius=25.0),
          Line(
            points={{-100.0,0.0},{100.0,0.0}},
            color={64,64,64}),
          Line(
            origin={0.0,-50.0},
            points={{-100.0,0.0},{100.0,0.0}},
            color={64,64,64}),
          Line(
            origin={0.0,-25.0},
            points={{0.0,75.0},{0.0,-75.0}},
            color={64,64,64})}), Documentation(info="<html>
<p>
This icon is indicates a record.
</p>
</html>"));
  end Record;

  type TypeReal "Icon for Real types"
      extends Real;
      annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid,
              extent={{-100.0,-100.0},{100.0,100.0}},
              radius=25.0),
            Text(
              textColor={255,255,255},
              extent={{-90.0,-50.0},{90.0,50.0}},
              textString="R")}),Documentation(info="<html>
<p>
This icon is designed for a <strong>Real</strong> type.
</p>
</html>"));
  end TypeReal;

  type TypeInteger "Icon for Integer types"
      extends Integer;
      annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid,
              extent={{-100.0,-100.0},{100.0,100.0}},
              radius=25.0),
            Text(
              textColor={255,255,255},
              extent={{-90.0,-50.0},{90.0,50.0}},
              textString="I")}),Documentation(info="<html>
<p>
This icon is designed for an <strong>Integer</strong> type.
</p>
</html>"));
  end TypeInteger;

  type TypeBoolean "Icon for Boolean types"
      extends Boolean;
      annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid,
              extent={{-100.0,-100.0},{100.0,100.0}},
              radius=25.0),
            Text(
              textColor={255,255,255},
              extent={{-90.0,-50.0},{90.0,50.0}},
              textString="B")}),
   Documentation(info="<html>
<p>
This icon is designed for a <strong>Boolean</strong> type.
</p></html>"));
  end TypeBoolean;

  type TypeString "Icon for String types"
      extends String;
      annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid,
              extent={{-100.0,-100.0},{100.0,100.0}},
              radius=25.0),
            Text(
              textColor={255,255,255},
              extent={{-90.0,-50.0},{90.0,50.0}},
              textString="S")}),Documentation(info="<html>
<p>
This icon is designed for a <strong>String</strong> type.
</p>
</html>"));
  end TypeString;

  expandable connector SignalBus "Icon for signal bus"

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}, initialScale=0.2), graphics={
            Rectangle(
              lineColor={255,204,51},
              lineThickness=0.5,
              extent={{-20.0,-2.0},{20.0,2.0}}),
            Polygon(
              fillColor={255,215,136},
              fillPattern=FillPattern.Solid,
              points={{-80.0,50.0},{80.0,50.0},{100.0,30.0},{80.0,-40.0},{60.0,-50.0},{-60.0,-50.0},{-80.0,-40.0},{-100.0,30.0}},
              smooth=Smooth.Bezier),
            Ellipse(
              fillPattern=FillPattern.Solid,
              extent={{-65.0,15.0},{-55.0,25.0}}),
            Ellipse(
              fillPattern=FillPattern.Solid,
              extent={{-5.0,15.0},{5.0,25.0}}),
            Ellipse(
              fillPattern=FillPattern.Solid,
              extent={{55.0,15.0},{65.0,25.0}}),
            Ellipse(
              fillPattern=FillPattern.Solid,
              extent={{-35.0,-25.0},{-25.0,-15.0}}),
            Ellipse(
              fillPattern=FillPattern.Solid,
              extent={{25.0,-25.0},{35.0,-15.0}})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          initialScale=0.2), graphics={
          Polygon(
            points={{-40,25},{40,25},{50,15},{40,-20},{30,-25},{-30,-25},{-40,-20},{-50,15}},
            fillColor={255,204,51},
            fillPattern=FillPattern.Solid,
            smooth=Smooth.Bezier),
          Ellipse(
            extent={{-32.5,7.5},{-27.5,12.5}},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-2.5,12.5},{2.5,7.5}},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{27.5,12.5},{32.5,7.5}},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-17.5,-7.5},{-12.5,-12.5}},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{12.5,-7.5},{17.5,-12.5}},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,70},{150,40}},
            textString="%name")}),
      Documentation(info="<html>
This icon is designed for a <strong>signal bus</strong> connector.
</html>"));
  end SignalBus;

  expandable connector SignalSubBus "Icon for signal sub-bus"

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Line(
              points={{-16.0,2.0},{16.0,2.0}},
              color={255,204,51},
              thickness=0.5),
            Rectangle(
              lineColor={255,204,51},
              lineThickness=0.5,
              extent={{-10.0,0.0},{8.0,8.0}}),
            Polygon(
              fillColor={255,215,136},
              fillPattern=FillPattern.Solid,
              points={{-80.0,50.0},{80.0,50.0},{100.0,30.0},{80.0,-40.0},{60.0,-50.0},{-60.0,-50.0},{-80.0,-40.0},{-100.0,30.0}},
              smooth=Smooth.Bezier),
            Ellipse(
              fillPattern=FillPattern.Solid,
              extent={{-55.0,15.0},{-45.0,25.0}}),
            Ellipse(
              fillPattern=FillPattern.Solid,
              extent={{45.0,15.0},{55.0,25.0}}),
            Ellipse(
              fillPattern=FillPattern.Solid,
              extent={{-5.0,-25.0},{5.0,-15.0}}),
            Rectangle(
              lineColor={255,215,136},
              lineThickness=0.5,
              extent={{-20.0,0.0},{20.0,4.0}})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Polygon(
            points={{-40,25},{40,25},{50,15},{40,-20},{30,-25},{-30,-25},{-40,-20},{-50,15}},
            fillColor={255,204,51},
            fillPattern=FillPattern.Solid,
            smooth=Smooth.Bezier),
          Ellipse(
            extent={{-22.5,7.5},{-17.5,12.5}},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{17.5,12.5},{22.5,7.5}},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-2.5,-7.5},{2.5,-12.5}},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,70},{150,40}},
            textString=
                 "%name")}),
      Documentation(info="<html>
<p>
This icon is designed for a <strong>sub-bus</strong> in a signal connector.
</p>
</html>"));

  end SignalSubBus;

  partial class UnderConstruction
    "Icon for classes that are still under construction"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Polygon(points={{-100,-100},{0,80},{100,-100},{-100,-100}},
            lineColor={255,0,0},
            lineThickness=0.5)}), Documentation(info="<html>
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
</p>
</html>"));
  end ObsoleteModel;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Polygon(
            origin={-8.167,-17},
            fillColor={128,128,128},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{
                4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,
                -50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}},
            smooth=Smooth.Bezier), Ellipse(
            origin={-0.5,56.5},
            fillColor={128,128,128},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-12.5,-12.5},{12.5,12.5}})}), Documentation(info="<html>
<p>This package contains definitions for the graphical layout of components which may be used in different libraries. The icons can be utilized by inheriting them in the desired class using &quot;extends&quot; or by directly copying the &quot;icon&quot; layer.</p>

<h4>Main Authors</h4>

<dl>
<dt><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a></dt>
    <dd>Deutsches Zentrum f&uuml;r Luft- und Raumfahrt (DLR)</dd>
    <dd>Institut f&uuml;r Systemdynamik und Regelungstechnik (SR)</dd>
    <dd>M&uuml;nchener Straße 20</dd>
    <dd>D-82234 We&szlig;ling</dd>
    <dd>Germany</dd>
    <dd>email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a><br></dd>
<dt>Christian Kral</dt>
    <dd><a href=\"https://christiankral.net/\">Electric Machines, Drives and Systems</a></dd>
    <dd>1060 Vienna, Austria</dd>
    <dd>email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a><br></dd>
<dt>Johan Andreasson</dt>
    <dd><a href=\"https://www.modelon.com/\">Modelon AB</a></dd>
    <dd>Ideon Science Park</dd>
    <dd>22370 Lund, Sweden</dd>
    <dd>email: <a href=\"mailto:johan.andreasson@modelon.se\">johan.andreasson@modelon.se</a></dd>
</dl>

<p>
Copyright &copy; 1998-2020, Modelica Association and contributors
</p>
</html>"));
end Icons;
