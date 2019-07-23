within Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets;
model GenericHystTellinenPermanentMagnet
  "Permanent magnet based on the Tellinen hysteresis model"

  extends BaseClasses.GenericHysteresisTellinen(                mu0=K*
        Modelica.Constants.mu_0, MagRel(start=-1, fixed=true));

  parameter SI.MagneticFluxDensity Br=1.2 "Remanence" annotation (Dialog(group="Hysteresis", groupImage="modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HysteresisAndMagnets/GenericHystTellinenHard/HardMagneticHysteresis.png"));
  parameter SI.MagneticFieldStrength Hc=5e5 "Coercitivity" annotation (Dialog(group="Hysteresis"));
  parameter Real M(final unit="1") = unitH*10/Hc
    "Slope of tanh()-function" annotation (Dialog(group="Hysteresis"));
  parameter Real K(final unit="1")=1 "mu_0 multiplier" annotation (Dialog(group="Hysteresis"));

protected
  constant SI.MagneticFieldStrength unitH = 1;
  parameter SI.MagneticFluxDensity eps= Br/1000;
  parameter SI.MagneticFieldStrength H0= 0.5*log((1+mu0*Hc/Br)/(1-mu0*Hc/Br)) + M*Hc;

equation
  hystR = Br*tanh((M*H - H0)/unitH) + mu0*H - eps/2;
  hystF = Br*tanh((M*H + H0)/unitH) + mu0*H + eps/2;

  annotation (defaultComponentName="pm",
              Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
            -100},{100,100}}), graphics={
        Rectangle(
          extent={{-70,30},{70,-30}},
          lineColor={255,128,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{70,0},{100,0}},
          color={255,128,0}),
        Rectangle(
          extent={{34,20},{60,-20}},
          lineColor={0,127,0},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,13},{20,-13}},
          textStyle={TextStyle.Bold},
          origin={47,0},
          rotation=90,
          textString="S"), Line(
          points={{-38,-20},{-4,-20},{4,-16},{12,0},{20,16},{28,20},{36,
              20}},
          color={255,128,0},
          smooth=Smooth.Bezier), Line(
          points={{-42,-20},{-14,-20},{-6,-16},{2,0},{10,16},{18,20},{28,
              20}},
          color={255,128,0},
          smooth=Smooth.Bezier,
          origin={-6,0},
          rotation=180),
        Line(
          points={{-100,0},{-70,0}},
          color={255,128,0}),
        Rectangle(
          extent={{-60,20},{-34,-20}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,13},{20,-13}},
          textStyle={TextStyle.Bold},
          textString="N",
          origin={-47,0},
          rotation=90),
        Text(
          extent={{22,0},{22,-18}},
          textColor={255,128,0},
          textString="TH")}), Documentation(info="<html>

<p>
Flux tube element for modeling the hard magnetic hysteresis of permanent magnets. The model is similar to <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenHard\">GenericHystTellinenHard</a> but has an initial magnetization preset of -100% and an adapted icon for better readability of the diagram.
</p>

<p>
An overview over all available hysteresis and permanent magnet elements of the package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">HysteresisAndMagnets</a> can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a>.
</p>

</html>"));
end GenericHystTellinenPermanentMagnet;
