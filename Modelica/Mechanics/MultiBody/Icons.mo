within Modelica.Mechanics.MultiBody;
package Icons "Icons for MultiBody package"
  extends Modelica.Icons.IconsPackage;
  model Surface "Surface icon"
    annotation (Icon(graphics={Polygon(
            points={{-102,40},{-98,92},{28,-8},{96,146},{104,-118},{-18,-34},{-52,
                -130},{-102,40}},
            lineColor={0,0,255},
            smooth=Smooth.Bezier,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,140},{150,100}},
            lineColor={0,0,255},
            textString="%name")}), Documentation(info="<html>
<p>
This icon is designed for a <strong>parametrized surface</strong> model.
</p>
</html>"));
  end Surface;

  partial class MotorIcon "Icon of an electrical motor."

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            lineColor={64,64,64},
            fillColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{30.0,-10.0},{90.0,10.0}}),
          Rectangle(
            lineColor={82,0,2},
            fillColor={252,37,57},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100.0,-50.0},{30.0,50.0}},
            radius=10.0),
          Polygon(
            fillColor={64,64,64},
            fillPattern=FillPattern.Solid,
            points={{-100,-60},{-90,-60},{-60,-20},{-10,-20},{20,-60},{30,-60},{30,-70},{-100,-70},{-100,-60}})}),
      Documentation(info="<html>
<p>
This icon is designed for an <strong>electrical motor</strong> model.
</p>
</html>"));
  end MotorIcon;
  annotation (Documentation(info="<html>
<p>This package contains definitions for the graphical layout of components used in the MultiBody library.
These icons might also be used in other libraries using &quot;extends&quot; or by directly copying the &quot;icon&quot; layer.
</p>
</html>"));
end Icons;
