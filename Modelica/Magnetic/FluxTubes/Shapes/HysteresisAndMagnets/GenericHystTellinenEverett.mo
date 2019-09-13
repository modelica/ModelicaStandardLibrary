within Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets;
model GenericHystTellinenEverett
  "Generic flux tube with ferromagnetic hysteresis based on the Tellinen model and the Everett function [Ya89])"

  parameter FluxTubes.Material.HysteresisEverettParameter.BaseData mat=
      FluxTubes.Material.HysteresisEverettParameter.BaseData()
    "Material properties"
    annotation (Dialog(group="Material"), choicesAllMatching=true);
  extends BaseClasses.GenericHysteresisTellinen(      mu0=mat.K*mu_0, sigma=mat.sigma);

protected
  parameter SI.MagneticFluxDensity Js = 0.5 * FluxTubes.Utilities.everett(
                                                     mat.Hsat,-mat.Hsat, mat, false)
    "Saturation polarization";
  //final parameter Real mu0 = mat.K * mu_0;
  parameter SI.MagneticFluxDensity eps=mat.M/1000;
  parameter Real P1 = (mat.M*mat.r*(2/pi*atan(mat.q*(mat.Hsat-mat.Hc))+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*(mat.Hsat-mat.Hc))+exp(-mat.p2*(mat.Hsat-mat.Hc)))));
  parameter Real P4 = (mat.M*mat.r*(2/pi*atan(mat.q*(-mat.Hsat-mat.Hc))+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*(-mat.Hsat-mat.Hc))+exp(-mat.p2*(-mat.Hsat-mat.Hc)))));

  SI.MagneticFieldStrength H2;
  SI.MagneticFieldStrength H3;
  Real P2;
  Real P3;
  Real H_lim;
  constant SI.MagneticFluxDensity unitT = 1;

equation
  H_lim = if Hstat<-mat.Hsat then -mat.Hsat elseif Hstat>mat.Hsat then mat.Hsat else Hstat;
  H2 = H_lim-mat.Hc;
  H3 = -H_lim-mat.Hc;

  P2 = (mat.M*mat.r*(2/pi*atan(mat.q*H2)+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*H2)+exp(-mat.p2*H2))));
  P3 = (mat.M*mat.r*(2/pi*atan(mat.q*H3)+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*H3)+exp(-mat.p2*H3))));

  hystR = -Js + unitT*(P1*P2-P3*P4) + mu0*Hstat - eps/2;
  hystF =  Js + unitT*(P4*P2-P3*P1) + mu0*Hstat + eps/2;

  annotation (defaultComponentName="core", Icon(graphics={Text(
          extent={{40,0},{40,-30}},
          textColor={255,128,0},
          textString="TE")}),
    Documentation(info="<html>

<p>
Flux tube element for modeling soft magnetic materials with ferromagnetic and dynamic hysteresis (eddy currents). The ferromagnetic hysteresis behavior is defined by the <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Tellinen\">Tellinen hysteresis model</a>. The Shape of the limiting ferromagnetic hysteresis loop is specified by an analytical description of the Everett function, which is also used to parameterize the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystPreisachEverett\">GenericHystPreisachEverett</a> model. A library of predefined parameter sets can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter\">FluxTubes.Material.HysteresisEverettParameter</a>.
</p>

<p>
An overview of all available hysteresis and permanent magnet elements of the package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">HysteresisAndMagnets</a> can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a>.
</p>

</html>"));
end GenericHystTellinenEverett;
