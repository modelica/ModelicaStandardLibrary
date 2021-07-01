within Modelica.Magnetic.FundamentalWave.Components;
model EddyCurrent
  "Constant loss model under sinusoidal magnetic conditions"
  import Modelica.Constants.pi;
  extends Magnetic.FundamentalWave.Interfaces.TwoPort;
  parameter SI.Conductance G(min=0)
    "Equivalent symmetric loss conductance";
  extends
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
      final T=273.15);
equation
  lossPower = (pi/2)*(V_m.re*der(Phi.re) + V_m.im*der(Phi.im));
  if G > 0 then
    (pi/2)*V_m.re = G*der(Phi.re);
    (pi/2)*V_m.im = G*der(Phi.im);
  else
    V_m.re = 0;
    V_m.im = 0;
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),Line(points={{-96,0},{-70,0}},
          color={255,128,0}),Line(points={{70,0},{96,0}}, color={255,128,0}),
                                  Text(
              extent={{0,-40},{0,-80}},
              textString="G=%G"),
          Text(
              extent={{-150,50},{150,90}},
              textColor={0,0,255},
              textString="%name")}),Documentation(info="<html>
<p>
The eddy current loss model with respect to fundamental wave effects is designed in accordance to
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.EddyCurrent\">FluxTubes.Basic.EddyCurrent</a>.
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/eddycurrent.png\"
     alt=\"eddycurrent.png\">
</blockquote>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption>Fig. 1: equivalent models of eddy current losses</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/eddycurrent_electric.png\"
           alt=\"eddycurrent_electric.png\">
    </td>
  </tr>
</table>

<p>Due to the nature of eddy current losses, which can be represented by symmetric
conductors in an equivalent electric circuit (Fig. 1), the respective
number of phases <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\" alt=\"m\"> has to be taken into account.
Assume that the <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\" alt=\"m\"> conductances
of the equivalent circuit are <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/Gc.png\" alt=\"G_c\">,
the conductance for the eddy current loss model is determined by</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/GGc.png\"
     alt=\"GGc\">
</blockquote>

<p>
where <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/N.png\" alt=\"N\"> is the number of turns of the symmetric electromagnetic coupling.
</p>

<p>For such an <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\" alt=\"m\"> phase system
the relationship between the voltage and current <a href=\"https://www.haumer.at/refimg/SpacePhasors.pdf\">space phasors</a>
and the magnetic flux and magnetic potential difference phasor is
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/vPhi.png\" alt=\"vPhi\">,<br>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/iV_m.png\" alt=\"iV_m\">,
</blockquote>

<p>
where <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/v_k.png\" alt=\"v_k\">
and <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/i_k.png\" alt=\"i_k\">
are the phase voltages and currents, respectively.
</p>

<p>
The dissipated loss power
</p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/lossPower.png\" alt=\"lossPower\">
</blockquote>
<p>
can be determined for the <a href=\"https://www.haumer.at/refimg/SpacePhasors.pdf\">space phasor</a>
relationship of the voltage and current space phasor.
</p>
<h4>See also</h4>

<p><a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.EddyCurrent\">FluxTubes.Basic.EddyCurrent</a></p>

</html>"));
end EddyCurrent;
