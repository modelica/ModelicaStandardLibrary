within Modelica.Electrical.Machines;
package Thermal "Library with models for connecting thermal models"
  extends Modelica.Icons.Package;

  annotation (Icon(graphics={Ellipse(
          extent={{-65,-63},{65,63}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<h4>Thermal concept</h4>
<p>
Each machine model is equipped with a machine-specific conditional <code>thermalPort</code>.
If <code>useThermalPort == false</code>, a machine-specific thermal ambience prescribing constant temperatures is used inside the machine.
If <code>useThermalPort == true</code>, a thermal model or machine-specific thermal ambience prescribing the temperatures has to be connected from outside.
On the other hand, all losses are dissipated to this internal or external thermal ambience.
</p>
<p>
The machine specific thermal connector contains <a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">heatPort</a>s
for all relevant loss sources of the machine type, although some of the loss sources are not yet implemented;
these heatPorts are left unconnected inside the machine, i.e., the HeatFlowRate is zero,
but they have to be connected to a constant temperature source in the internal or external thermal ambience.
Simple machine-specific thermal ambience for constant temperatures (<code>useTemperatureInputs == false</code>)
or temperatures prescribed via signal inputs (<code>useTemperatureInputs == true</code>) are provided in this package.
</p>
<h4>Loss sources</h4>
<p>
Up to now, only Ohmic losses in stator and rotor windings are implemented.
They are modeled as <a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">linearly temperature dependent resistors</a>:
</p>
<blockquote><pre>
ROperational = RRef * (1 + alphaRef * (TOperational - TRef))
</pre></blockquote>
<h5>Parameters</h5>
<ul>
<li>Resistance <code>RRef</code> at reference temperature</li>
<li>Reference temperature <code>TRef</code></li>
<li>Linear temperature coefficient <code>alpha20</code> at 20&deg;C</li>
<li>Operational temperature <code>TOperational</code>
(if <code>useThermalPort == false</code>; otherwise, the operational temperature is provided via the heatPort)</li>
<li>Nominal temperature <code>TNominal</code>
(required for DC machines to calculate the turns ratio)</li>
</ul>
<p>
The linear temperature coefficient <code>alpha20</code> at 20&deg;C = 293.15 K has to be converted to reference temperature <code>TRef</code>:
</p>
<blockquote><pre>
                      alpha20
alphaRef = -------------------------------
            1 + alpha20 * (TRef - 293.15)
</pre></blockquote>
<p>
For this reason, the function <a href=\"modelica://Modelica.Electrical.Machines.Thermal.convertAlpha\">convertAlpha</a> is provided.
In sub-package <a href=\"modelica://Modelica.Electrical.Machines.Thermal.Constants\">Constants</a> linear temperature coefficients at 20&deg;C for commonly used materials are defined.
</p>
<h4>Backwards compatibility</h4>
<ul>
<li>The default / start values of all resistances are left unchanged.</li>
<li>The default / start values of all reference temperatures are set to 20&deg;C.</li>
<li>The default / start values of all linear temperature coefficients are set to 0.</li>
<li>The default / start values of all operational temperatures are set to 20&deg;C.</li>
<li>The default / start values of all nominal temperatures are set to 20&deg;C.</li>
</ul>
<h4>Machine specific thermalPorts</h4>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.InductionMachines.IM_SquirrelCage\">Induction machine with squirrel cage</a></h5>
<ul>
<li><code>heatPortStatorWinding[m]</code>: m=3 heatPorts for the m=3 stator phases</li>
<li><code>heatPortRotorWinding</code>: heatPort for the rotor cage</li>
<li><code>heatPortStatorCore</code>: stator core losses (not yet fully implemented)</li>
<li><code>heatPortRotorCore</code>: rotor core losses (not yet connected/implemented)</li>
<li><code>heatPortStrayLoad</code>: stray load losses</li>
<li><code>heatPortFriction</code>: friction losses</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.InductionMachines.IM_SlipRing\">Induction machine with slipring rotor</a></h5>
<ul>
<li><code>heatPortStatorWinding[m]</code>: m=3 heatPorts for the m=3 stator phases</li>
<li><code>heatPortRotorWinding[m]</code>: m=3 heatPorts for the m=3 rotor phases</li>
<li><code>heatPortBrush</code>: brush losses (not yet connected/implemented)</li>
<li><code>heatPortStatorCore</code>: stator core losses (not yet fully implemented)</li>
<li><code>heatPortRotorCore</code>: rotor core losses (not yet fully implemented)</li>
<li><code>heatPortStrayLoad</code>: stray load losses</li>
<li><code>heatPortFriction</code>: friction losses</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_PermanentMagnet\">Synchronous machine with permanent magnets</a></h5>
<ul>
<li><code>heatPortStatorWinding[m]</code>: m=3 heatPorts for the m=3 stator phases</li>
<li><code>heatPortRotorWinding</code>: conditional (<code>useDamperCage=true/false</code>) heatPort for the damper cage</li>
<li><code>heatPortPermanentMagnet</code>: permanent magnet losses (not yet connected/implemented)</li>
<li><code>heatPortStatorCore</code>: stator core losses (not yet fully implemented)</li>
<li><code>heatPortRotorCore</code>: rotor core losses (not yet connected/implemented)</li>
<li><code>heatPortStrayLoad</code>: stray load losses</li>
<li><code>heatPortFriction</code>: friction losses</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_ElectricalExcited\">Synchronous machine with electrical excitation</a></h5>
<ul>
<li><code>heatPortStatorWinding[m]</code>: m=3 heatPorts for the m=3 stator phases</li>
<li><code>heatPortRotorWinding</code>: conditional (<code>useDamperCage=true/false</code>) heatPort for the damper cage</li>
<li><code>heatPortExcitation</code>: electrical excitation</li>
<li><code>heatPortBrush</code>: brush losses</li>
<li><code>heatPortStatorCore</code>: stator core losses (not yet fully implemented)</li>
<li><code>heatPortRotorCore</code>: rotor core losses (not yet connected/implemented)</li>
<li><code>heatPortStrayLoad</code>: stray load losses</li>
<li><code>heatPortFriction</code>: friction losses</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_ReluctanceRotor\">Synchronous machine with reluctance rotor</a></h5>
<ul>
<li><code>heatPortStatorWinding[m]</code>: m=3 heatPorts for the m=3 stator phases</li>
<li><code>heatPortRotorWinding</code>: conditional (<code>useDamperCage=true/false</code>) heatPort for the damper cage</li>
<li><code>heatPortStatorCore</code>: stator core losses (not yet fully implemented)</li>
<li><code>heatPortRotorCore</code>: rotor core losses (not yet connected/implemented)</li>
<li><code>heatPortStrayLoad</code>: stray load losses</li>
<li><code>heatPortFriction</code>: friction losses</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet\">DC machine with permanent magnets</a></h5>
<ul>
<li><code>heatPortArmature</code>: armature losses</li>
<li><code>heatPortPermanentMagnet</code>: permanent magnet losses (not yet connected/implemented)</li>
<li><code>heatPortBrush</code>: brush losses</li>
<li><code>heatPortCore</code>: armature core losses</li>
<li><code>heatPortStrayLoad</code>: stray load losses</li>
<li><code>heatPortFriction</code>: friction losses</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_ElectricalExcited\">DC machine with electrical (shunt) excitation</a></h5>
<ul>
<li><code>heatPortArmature</code>: armature losses</li>
<li><code>heatPortExcitation</code>: electrical (shunt) excitation</li>
<li><code>heatPortBrush</code>: brush losses</li>
<li><code>heatPortCore</code>: armature core losses</li>
<li><code>heatPortStrayLoad</code>: stray load losses</li>
<li><code>heatPortFriction</code>: friction losses</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_SeriesExcited\">DC machine with serial excitation</a></h5>
<ul>
<li><code>heatPortArmature</code>: armature losses</li>
<li><code>heatPortSeriesExcitation</code>: electrical series excitation</li>
<li><code>heatPortBrush</code>: brush losses</li>
<li><code>heatPortCore</code>: armature core losses</li>
<li><code>heatPortStrayLoad</code>: stray load losses</li>
<li><code>heatPortFriction</code>: friction losses</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.Transformers\">Transformers</a></h5>
<ul>
<li><code>heatPort1[m]</code>: m=3 heatPorts for the m=3 primary phases</li>
<li><code>heatPort2[m]</code>: m=3 heatPorts for the m=3 secondary phases</li>
<li><code>heatPortCore</code>: iron core losses (not yet connected/implemented)</li>
</ul>
</html>",
        revisions="<html>
  <ul>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       first stable release of this subpackage:<br>
       conditional ThermalPort for all machines</li>
  </ul>
</html>"));
end Thermal;
