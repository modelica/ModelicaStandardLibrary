within Modelica.Magnetic.FluxTubes.BaseClasses;
partial model GenericHysteresisTellinen "Partial Tellinen hysteresis model"
  extends BaseClasses.GenericHysteresis;

  //Real MagRel(start=0, min=-100, max=100) "Relative magnetization at initialization (-100-100%)";
  output Boolean asc(start=true) "True when der(Hstat)>0";
protected
  SI.MagneticFluxDensity hystR "Rising branch of limiting hysteresis loop";
  SI.MagneticFluxDensity hystF "Falling branch of limiting hysteresis loop";

  SI.MagneticFluxDensity diffHyst
    "Distance between rising and falling limiting hysteresis branch at the current operating point";
  Real dHyst(final quantity="MagneticFluxDensitySlope", final unit="T/s")
    "Slope of the Rising (when der(H)>0) or Falling (when der(H)<0) limiting hysteresis branch at the current operating point";
  Real k;

  parameter Real mu0(final unit="N/A2") = mu_0;

initial equation

  B = (hystR+hystF)/2 + MagRel*diffHyst/2;

equation

  asc = der(Hstat) > 0;

  der(B) = k * dHyst + mu0 * der(Hstat);

  diffHyst = hystF - hystR;

  if initial() then
    k = 0.01;
    dHyst = 0;
  elseif asc then
    dHyst = der(hystR-mu0*Hstat);
    k = max(0.01,(hystF - B)/diffHyst);
  else
    dHyst = der(hystF-mu0*Hstat);
    k = max(0.01, (B - hystR)/diffHyst);
  end if;

  annotation (Documentation(info="<html>
<p>A reluctance with the Tellinen hysteresis model. The major hysteresis loop is defined by the hyperbolic tangent function.</p>
<h4>The Tellinen Hysteresis Model</h4>
<p>The Tellinen hysteresis model is a simple model to describe the magnetic hysteresis behavior of ferromagnetic materials. It only uses the rising (hystR) and falling (hystF) branch of the major hysteresis loop and their derivatives der(hystR) and der(hystF). See Fig. 1 and the following equations for a short description of the Tellinen hysteresis model.</p>
<blockquote><pre>
diffHyst = hystF - hystR;
dhR = hystF - b;
dhF = b - hystR;
</pre></blockquote>
<p>if the magnetic field intensity increases (der(h)&gt;0)</p>
<blockquote><pre>
der(b) = dhR/diffHyst * der(hystR);
</pre></blockquote>
<p>if the magnetic field intensity decreases (der(h)&lt;0)</p>
<blockquote><pre>
der(b) = dhF/diffHyst * der(hystF);
</pre></blockquote>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\"><tr>
<td><div><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Tellinen/TellinenDesc1.png\"/></div></td>
</tr>
</table>
<strong>Fig. 1:</strong> Description of the Tellinen hysteresis model.
</html>"));
end GenericHysteresisTellinen;
