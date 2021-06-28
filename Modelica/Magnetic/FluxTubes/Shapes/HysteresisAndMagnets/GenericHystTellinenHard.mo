within Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets;
model GenericHystTellinenHard
  "Generic flux tube with hard magnetic hysteresis based on the Tellinen model and simple tanh()-functions"

  extends BaseClasses.GenericHysteresisTellinen(      mu0=K*mu_0);

  //Hysteresis parameter
  parameter SI.MagneticFluxDensity Br=1.2 "Remanence" annotation (Dialog(group="Hysteresis", groupImage="modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HysteresisAndMagnets/GenericHystTellinenHard/HardMagneticHysteresis.png"));
  parameter SI.MagneticFieldStrength Hc=5e5 "Coercitivity" annotation (Dialog(group="Hysteresis"));
  parameter Real M = 10/Hc "Slope of tanh()-function" annotation (Dialog(group="Hysteresis"));
  parameter Real K=1 "Slope of hysteresis in the saturation region (K*mu_0)" annotation (Dialog(group="Hysteresis"));

protected
  final parameter SI.MagneticFluxDensity eps = Br/1000;
  //final parameter Real mu0(final unit="N/A2") = K*mu_0;
  final parameter SI.MagneticFieldStrength H0= 0.5*log((1+mu0*Hc/Br)/(1-mu0*Hc/Br)) + M*Hc;
  constant SI.MagneticFieldStrength unitH = 1;

  Real tanhR;
  Real tanhF;

equation
  tanhR = tanh((M*H - H0)/unitH);
  tanhF = tanh((M*H + H0)/unitH);
  hystR = Br*tanhR + mu0*H - eps/2;
  hystF = Br*tanhF + mu0*H + eps/2;

 annotation (defaultComponentName="core", Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
            -100},{100,100}}), graphics={
        Rectangle(
          extent={{-70,32},{70,-30}},
          lineColor={255,128,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{70,0},{100,0}},
          color={255,128,0}),
        Line(
          points={{-90,0},{-70,0}},
          color={255,128,0}), Line(
          points={{-30,-20},{-14,-20},{-6,-16},{2,0},{10,16},{18,20},{26,20}},
          color={255,128,0},
          smooth=Smooth.Bezier,
          origin={-14,0},
          rotation=180), Line(
          points={{-18,-20},{-2,-20},{6,-16},{14,0},{22,16},{30,20},{38,
              20}},
          color={255,128,0},
          smooth=Smooth.Bezier),
        Line(
          points={{-18,-20},{-42,-20}},
          color={255,128,0}),
        Line(
          points={{16,20},{40,20}},
          color={255,128,0}),
        Text(
          extent={{40,-2},{40,-30}},
          textColor={255,128,0},
          textString="TH")}), Documentation(info="<html>
<p>
  Flux tube element for modeling the ferromagnetic (static) hysteresis of hard magnetic materials. The ferromagnetic hysteresis behavior is defined by the <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Tellinen\">Tellinen hysteresis model</a>. The shape of the limiting hysteresis loop is described by simple hyperbolic tangent functions with 4 parameters.
</p>

<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <caption><strong>Fig. 1:</strong> Hyperbolic tangent functions define the shape of the ferromagnetic (static) hysteresis</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HysteresisAndMagnets/GenericHystTellinenHard/HardMagneticHysteresis.png\">
   </td>
  </tr>
</table>

<p>
An overview of all available hysteresis and permanent magnet elements of the package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">HysteresisAndMagnets</a> can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a>.
</p>
</html>"));
end GenericHystTellinenHard;
