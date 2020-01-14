within Modelica.Mechanics.Translational.Sources;
model Force2 "Input signal acting as torque on two flanges"
  extends Translational.Interfaces.PartialTwoFlanges;
  Modelica.Blocks.Interfaces.RealInput f(unit="N")
    "Driving force as input signal" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,60}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,40})));

equation
  flange_a.f = f;
  flange_b.f = -f;
  annotation (defaultComponentName="force",
    Documentation(info="<html>
<p>
The input signal \"f\" in [N] characterizes an <em>external
force</em> which acts (with positive sign) at both flanges,
i.e., the components connected to these flanges are driven by force f.
</p>
<p>
Input signal s can be provided from one of the signal generator
blocks of Modelica.Blocks.Source.
</p>

</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Text(
              extent={{-150,-40},{150,-80}},
              textString="%name",
              textColor={0,0,255}),Polygon(
          points={{90,0},{60,-30},{60,-10},{10,-10},{10,10},{60,10},{60,30},{90,0}},
          lineColor={0,127,0},
          fillColor={160,215,160},
          fillPattern=FillPattern.Solid),    Polygon(
          points={{-90,0},{-60,30},{-60,10},{-10,10},{-10,-10},{-60,-10},{-60,-30},{-90,0}},
          lineColor={0,127,0},
          fillColor={160,215,160},
          fillPattern=FillPattern.Solid)}));
end Force2;
