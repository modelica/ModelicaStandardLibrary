within Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets;
model GenericHystTellinenSoft
  "Generic flux tube with soft magnetic hysteresis based on the Tellinen model and simple tanh()-functions"
  // Dialog Group Hysteresis
  parameter SI.MagneticFluxDensity Js = 1.8 "Saturation polarization" annotation (Dialog(group="Hysteresis", groupImage="modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HysteresisAndMagnets/GenericHystTellinenSoft/SoftMagneticHysteresis2.png"));
  parameter SI.MagneticFluxDensity Br=0.9 "Remanence" annotation (Dialog(group="Hysteresis"));
  parameter SI.MagneticFieldStrength Hc=120 "Coercitivity" annotation (Dialog(group="Hysteresis"));
  parameter Real K=1 "Slope of hysteresis in the saturation region (K*mu_0)" annotation (Dialog(group="Hysteresis"));

  extends BaseClasses.GenericHysteresisTellinen(      mu0=K*mu_0);

protected
  parameter SI.MagneticFluxDensity eps=Js/1000;
  //parameter Real mu0(final unit="N/A2")=K*mu_0;
  parameter Real H0=0.5*Modelica.Math.log((1 + Br/Js)/(1 - Br/Js));
  parameter Real M=H0/Hc;
  constant SI.MagneticFieldStrength unitH = 1;

equation
  hystR = Js*tanh((M*Hstat - H0)/unitH) + mu0*Hstat - eps/2;
  hystF = Js*tanh((M*Hstat + H0)/unitH) + mu0*Hstat + eps/2;

  annotation (defaultComponentName="core", Documentation(info="<html>
<p>Flux tube element for modeling soft magnetic materials with ferromagnetic and dynamic hysteresis (eddy currents). The ferromagnetic hysteresis behavior is defined by the <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Tellinen\">Tellinen hysteresis model</a>. The shape of the limiting hysteresis loop (see Fig. 1) is described by simple hyperbolic tangent functions with 4 parameters. Therefore, the hysteresis shape variety is limited but the parameterization of the model is very simple and the model is relatively fast and robust. The rising (hyst<sub>R</sub>) and falling (hyst<sub>F</sub>) branches of the limiting hysteresis loop are defined by the following equations.</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><div><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HysteresisAndMagnets/GenericHystTellinenSoft/Eqn_ShapeFunctionsTellinen.png\"/></div><p><br><strong>Fig. 1:</strong> Hyperbolic tangent functions define the shape of the ferromagnetic (static) hysteresis</p><div><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HysteresisAndMagnets/GenericHystTellinenSoft/SoftMagneticHysteresis1.png\"/></div>
<p><br>An overview over of available hysteresis and permanent magnet elements of the package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">HysteresisAndMagnets</a> can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a>.</p>
</td>
</tr>
</table>
</html>"),
     Icon(graphics={Text(
          extent={{40,0},{40,-30}},
          textColor={255,128,0},
          textString="TS")}));
end GenericHystTellinenSoft;
