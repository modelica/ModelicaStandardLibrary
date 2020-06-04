within Modelica.Magnetic.FundamentalWave.UsersGuide;
class Parameters "Parameters of equivalent machines models"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>

<h4>Stator main inductance</h4>

<p>
The stator main inductance
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lm_m.png\">
of an
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/m.png\">
phase induction machine is related with the self inductance of on stator phase,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lss.png\">,
by:</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lm_m_Lss.png\">
</div>

<h4>Parameters of equivalent polyphase induction machines models</h4>

<p>Assume a set parameters,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Rs_3.png\">,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lssigma_3.png\">,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/L0_3.png\">,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lm_3.png\">,
of a three-phase induction machine and a set of parameters,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Rs_m.png\">,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lssigma_m.png\">,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/L0_m.png\">,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lm_m.png\">,
of an
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/m.png\">
phase induction machine. It is also assumed that</p>
<ul>
<li>the nominal phase voltages</li>
<li>the nominal stator frequencies</li>
</ul>
<p>of the three and
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/m.png\">
phase induction machine are equal. In this case the two parameter sets are related by:</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Rs_3m.png\"><br>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lssigma_3m.png\"><br>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/L0_3m.png\"><br>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lm_3m.png\"></div>
<p>
This way the same torque is generated and the machine currents are related by:
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/is_3m.png\">
</div>

<p>
The same applies for the rotor parameters of a
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing\">
slip ring induction machine</a>, where the phase number
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/m.png\">
is simply replaced by
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/mr.png\">
for transforming equivalent three-phase to
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/mr.png\">
phase winding parameters -- at the same nominal rotor voltage and frequency.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines.ComparisonPolyphase.IMC_DOL_Polyphase\">IMC_DOL_Polyphase</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines.ComparisonPolyphase.IMS_Start_Polyphase\">IMS_Start_Polyphase</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines.ComparisonPolyphase.SMPM_Inverter_Polyphase\">SMPM_Inverter_Polyphase</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines.ComparisonPolyphase.SMEE_Generator_Polyphase\">SMEE_Generator_Polyphase</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines.ComparisonPolyphase.SMR_Inverter_Polyphase\">SMR_Inverter_Polyphase</a>
</p>

</html>"));
end Parameters;
