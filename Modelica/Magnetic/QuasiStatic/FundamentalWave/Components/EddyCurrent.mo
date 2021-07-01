within Modelica.Magnetic.QuasiStatic.FundamentalWave.Components;
model EddyCurrent
  "Constant loss model under sinusoidal magnetic conditions"
  import Modelica.Constants.pi;
  constant Complex j=Complex(0, 1);
  extends Interfaces.TwoPort;
  parameter SI.Conductance G(min=0)
    "Equivalent symmetric loss conductance";
  extends
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
      final T=273.15);
  SI.AngularVelocity omega=der(port_p.reference.gamma)
    "Angular velocity";
equation
  lossPower = (pi/2)*Modelica.ComplexMath.imag(omega*V_m*
    Modelica.ComplexMath.conj(Phi));
  // Alternative calculation of loss power
  // lossPower = -(pi/2)*Modelica.ComplexMath.real(j*omega*V_m*Modelica.ComplexMath.conj(Phi));
  if G > 0 then
    (pi/2)*V_m = j*omega*G*Phi;
  else
    V_m = Complex(0, 0);
  end if;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={255,170,85},
              fillColor={255,170,85},
              fillPattern=FillPattern.Solid),Line(points={{-96,0},{-70,0}},
          color={255,170,85}),Line(points={{70,0},{96,0}}, color={255,170,85}),
                                  Text(
              extent={{0,-40},{0,-80}},
              textString="G=%G"),
        Text(
          extent={{150,90},{-150,50}},
          textColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html>
<p>
The eddy current loss model with respect to fundamental wave effects is designed in accordance to
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.EddyCurrent\">FluxTubes.Basic.EddyCurrent</a> and
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.EddyCurrent\">FundamentalWave.Components.EddyCurrent</a>.
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/eddycurrent.png\">.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption>Fig. 1: equivalent models of eddy current losses</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/eddycurrent_electric.png\">
    </td>
  </tr>
</table>

<p>Due to the nature of eddy current losses, which can be represented by symmetric
conductors in an equivalent electric circuit (Fig. 1), the respective
number of phases <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\"> has to be taken into account.
Assume that the <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\"> conductances
of the equivalent circuit are <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/Gc.png\">,
the conductance for the eddy current loss model is determined by</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/GGc.png\">
</p>

<p>
where <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/N.png\"> is the number of turns of the symmetric electromagnetic coupling.
</p>

<p>For such an <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\"> phase system
the relationship between the voltage and current <a href=\"https://www.haumer.at/refimg/SpacePhasors.pdf\">space phasors</a>
and the magnetic flux and magnetic potential difference phasor is
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/vPhi.png\">,<br>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/iV_m.png\">,
</p>

<p>
where <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/v_k.png\">
and <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/i_k.png\">
are the phase voltages and currents, respectively.
</p>

<p>
The dissipated loss power
</p>
<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/lossPower.png\">
</p>
<p>
can be determined for the <a href=\"https://www.haumer.at/refimg/SpacePhasors.pdf\">space phasor</a>
relationship of the voltage and current space phasor.
</p>
<h4>See also</h4>

<p><a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.EddyCurrent\">FluxTubes.Basic.EddyCurrent</a></p>
</html>"));
end EddyCurrent;
