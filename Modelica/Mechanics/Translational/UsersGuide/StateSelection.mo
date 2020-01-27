within Modelica.Mechanics.Translational.UsersGuide;
class StateSelection "State Selection"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<p>
Only a few components of the Translational library use the der(&hellip;) operator
and are therefore candidates to have states. Most important, component
<a href=\"modelica://Modelica.Mechanics.Translational.Components.Mass\">Mass</a>
defines the absolute position and the absolute velocity of this
component as candidate for states. In the &quot;Advanced&quot; menu the built-in StateSelect
enumeration can be set to define the priority to use these variables as states.
Without further action, in most cases a tool will select these variables as states.
</p>

<p>
For positioning drive trains where the goal is to position a load, the absolute positions of the components are bounded,
and the issue discussed below is not present.
</p>

<p>
For drive trains where the goal is to control the velocity of a load,
the absolute positions of the components are quickly increasing
during operation. This is critical, because then the step size control of time
integrators might no longer work appropriately.
</p>

<p>
Integrators with step size control adjust their time step size automatically
to meet user defined error bounds (&quot;tolerances&quot;).
Typically the local error estimate <var>EST<sub>i</sub></var> is compared with a mixed
bound for absolute and relative errors.
</p>

<blockquote><pre>
EST_i &le; abstol_i + reltol_i*|x_i|
</pre></blockquote>

<p>
Here, <var>abstol<sub>i</sub></var> and <var>reltol<sub>i</sub></var> denote the bounds
for the absolute and relative error of state variable <var>x<sub>i</sub></var>, respectively.
This mixed error bound is used since it is more robust than a pure relative error
based error bound if the nominal value <var>x<sub>i</sub></var>  is (very) close to&nbsp;0.
In a Modelica simulation model, typically the same relative tolerance <var>reltol</var> is used for all
states and the absolute tolerances are computed using the relative tolerance and the
nominal values of the states:
</p>

<blockquote><pre>
reltol_i = reltol
abstol_i = reltol*x_i(nominal)*0.01
</pre></blockquote>

<p>
This error control fails if the state variable <var>x<sub>i</sub></var> grows without
bounds (such as for a drive train), since then the allowed error
also grows without bounds. The effect is that the error control on this variable is practically
switched off. The correct way to handle this would be to set
<var>reltol<sub>i</sub></var>&nbsp;=&nbsp;0 on such a state
variable and only use an absolute tolerance for the step size control.
</p>

<p>
At the time of the library design, there was not yet a possibility to provide this information in Modelica.
In order to reduce this effect, it is advisable to not use absolute positions, but
relative positions as states. A user can define relative variables as states
explicitly with component
<a href=\"modelica://Modelica.Mechanics.Translational.Components.RelativeStates\">RelativeStates</a>.
Furthermore, all compliant components, such as
<a href=\"modelica://Modelica.Mechanics.Translational.Components.SpringDamper\">SpringDamper</a> are
defining the relative position and the relative velocity as preferred states.
Therefore, a tool will select in most cases relative positions as states.
</p>

<p>
The relative positions of compliant components are usually small.
Without further action, the error control would not work properly on variables
that are so small (so often switching the error control off). The remedy is to define
explicitly a nominal value on the relative position. This definition is provided in the
&quot;Advanced&quot; menu of the compliant components with parameter &quot;s_nominal&quot;.
The default value is 1e-4&nbsp;m, to be in the order of a compliant deformation of a
drive.
</p>
</html>"));
end StateSelection;
