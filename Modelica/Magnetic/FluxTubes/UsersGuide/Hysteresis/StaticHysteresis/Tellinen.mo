within Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis;
class Tellinen "Tellinen Hysteresis Model"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>The Tellinen hysteresis model</h4>

<p>
The Tellinen hysteresis model is described in more detail in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Te98, ZB12]</a>. It is a simple model to describe the static magnetic hysteresis behavior of ferromagnetic materials. It only requires the Upper B<sub>U</sub>(H) and lower B<sub>L</sub>(H) branches of the limiting hysteresis loop for the adaption to a material specific hysteresis shape. Coming from negative magnetic saturation with increasing magnetic field strength H(t) the flux density B(T) travels along the B<sub>L</sub>(H). Coming from positive saturation with a decreasing H(t), B(t) travels along B<sub>U</sub>(H). The Tellinen model is defined by the following equation, which gives a calculation rule for time derivative of the magnetic flux density B(t) with respect to the current value of B(t), H(t) and its slope dH(t)/dt.
</p>

<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\"><tr>
<td><div><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Tellinen/Eqn_Tellinen01.png\"/></div></td>
</tr>
</table>

<p>
Therein, S<sub>U</sub>(H) and S<sub>L</sub>(H) are the derivatives of limiting branches of the hysteresis loop with respect to the magnetic field strength H, as illustrated in Fig 1.
</p>
<p>
<strong>Fig. 1:</strong> Upper B<sub>U</sub>(H) and lower B<sub>L</sub>(H) branches of the hysteresis envelope curve, their corresponding slope functions S<sub>UH</sub>(H) and S<sub>LH</sub>(H) and the actual operating point H(t), B(t).</p>

<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\"><tr>
<td><div><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Tellinen/TellinenDesc1.png\"/></div></td>
</tr>
</table>
</html>"));
end Tellinen;
