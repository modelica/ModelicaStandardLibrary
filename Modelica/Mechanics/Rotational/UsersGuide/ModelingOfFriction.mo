within Modelica.Mechanics.Rotational.UsersGuide;
class ModelingOfFriction "Modeling of Friction"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<p>
Several elements of this library model <strong>Coulomb friction</strong> with the method proposed in:
</p>

<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):</dt>
<dd><strong>Hybrid Modeling in Modelica based on the Synchronous
    Data Flow Principle</strong>. CACSD'99, Aug. 22.-26, Hawaii.</dd>
</dl>

<p>
The friction equations are defined in base model
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialFriction\">Interfaces.PartialFriction</a>.
In the following, there are given explanations.
</p>

<p>
Assume first the most simplest friction problem: A block sliding on a surface.
The friction force <var>f</var> acts between the block surface and the environment surface and
shall be a linear function of the relative velocity <var>v</var> between the two surfaces.
When the relative velocity becomes zero, the two surfaces are stuck to each other and
the friction force is no longer a function of <var>v</var>. The element starts sliding
again if the friction force becomes larger than the maximum static friction force
<var>f<sub>0</sub></var> (indicated by <code>f0</code> in equations below).
This element could be defined with a parameterized curve description leading
to the following equations:
</p>

<blockquote><pre>
forward  = s &gt;  1;
backward = s &lt; -1;
v = if forward  then s-1 elseif backward then s+1 else 0;
f = if forward  then  f0 + f1*(s-1) elseif
       backward then -f0 + f1*(s+1) else f0*s;
</pre></blockquote>

<p>
This model completely describes the simplified friction element in
a declarative way. Unfortunately, currently it is not known how to transform such
an element description automatically in a form which can be simulated:
</p>

<p>
The block is described by the following equation:
</p>

<blockquote><pre>
m*der(v) = u - f
</pre></blockquote>

<p>
Note, that <var>m</var> is the mass of the block and <var>u(t)</var> is the given driving force.
If the element is in its &quot;forward sliding&quot; mode, that is <var>s</var>&nbsp;&ge;&nbsp;1,
this model is described by:
</p>

<blockquote><pre>
m*der(v) = u - f
       v = s - 1
       f = f_0 + f_1*(s-1)
</pre></blockquote>

<p>
which can be easily transformed into state space form with&nbsp;<var>v</var> as the state.
If the block becomes stuck, that is -1&nbsp;&le;&nbsp;<var>s</var>&nbsp;&le;&nbsp;1,
the equation <var>v</var>&nbsp;=&nbsp;0 becomes
active and therefore&nbsp;<var>v</var> can no longer be a&nbsp;state, that is an index
change takes place. Besides the difficulty to handle the variable state change,
there is a more serious problem:
</p>

<p>
Assume that the block is stuck and that&nbsp;<var>s</var> becomes greater than one.
Before the event occurs, <var>s</var>&nbsp;&le;&nbsp;1 and <var>v</var>&nbsp;=&nbsp;0;
at the event instant <var>s</var>&nbsp;&gt;&nbsp;1 because this relation is the event
triggering condition. The element switches into the forward sliding mode where <var>v</var>
is a state which is initialized with its last value <var>v</var>&nbsp;=&nbsp;0.
Since&nbsp;<var>v</var> is a state, <var>s</var>&nbsp;is computed from&nbsp;<var>v</var>
via <var>s</var>&nbsp;:=&nbsp;<var>v</var>&nbsp;+&nbsp;1, resulting in <var>s</var>&nbsp;=&nbsp;1,
that is the relation <var>s</var>&nbsp;&gt;&nbsp;1 becomes false and the element
switches back into the stuck mode. In other words, it is never possible to switch into
the forward sliding mode. Taking numerical errors into account, the situation is even worse.
</p>

<p>
The key to the solution is the observation that <var>v</var>&nbsp;=&nbsp;0 in the stuck
mode and when forward sliding starts, but der(<var>v</var>)&nbsp;&gt;&nbsp;0 when sliding
starts and der(<var>v</var>)&nbsp;=&nbsp;0 in the stuck mode. Since the friction characteristic
at zero velocity is no functional relationship, again a parameterized curve description
with a new curve parameter <var>s<sub>a</sub></var> (denoted also <code>sa</code> below)
has to be used leading to the following equations (note: at zero velocity):
</p>

<blockquote><pre>
startFor  = sa &gt;  1;
startBack = sa &lt; -1;
        a = der(v);
        a = if startFor then sa-1 elseif startBack then sa+1 else 0;
        f = if startFor then  f0  elseif startBack then  -f0 else f0*sa;
</pre></blockquote>

<p>
At zero velocity, these equations and the equation of the block form a mixed continuous/discrete
set of equations which has to be solved at event instants (e.g. by a fix point iteration),
When switching from sliding to stuck mode, the velocity is small or zero.
Since the derivative of the constraint equation der(<var>v</var>)&nbsp;=&nbsp;0 is fulfilled
in the stuck mode, the velocity remains small even if <var>v</var>&nbsp;=&nbsp;0 is not explicitly
taken into account. The approach to use the acceleration der(<var>v</var>)&nbsp;=&nbsp;0 as
&quot;constraint&quot; instead of <var>v</var>&nbsp;=&nbsp;0, is often used in multi-body software.
The benefit is that the velocity&nbsp;<var>v</var> remains a state in all switching configurations
(there is a small, linear drift, but the friction element would have to stay stuck several days
before the drift becomes too large). Consequently, <var>v</var> is small but may have any sign when
switching from stuck to sliding mode; if the friction element starts to slide, say in the forward
direction, one has to wait until the velocity is really positive, before switching to forward
mode (note, that even for exact calculation without numerical errors a&nbsp;&quot;waiting&quot;
phase is necessary, because <var>v</var>&nbsp;=&nbsp;0 when sliding starts).
Since der(<var>v</var>)&nbsp;&gt;&nbsp;0, this will occur after a&nbsp;small time period.
This &quot;waiting&quot; procedure can be described by a&nbsp;state machine.
Collecting all the pieces together, finally results in the following equations
of a simple friction element:
</p>

<blockquote><pre>
// part of mixed system of equations
startFor  = pre(mode) == Stuck and sa &gt;  1;
startBack = pre(mode) == Stuck and sa &lt; -1;
        a = der(v);
        a = if pre(mode) == Forward  or startFor  then  sa - 1    elseif
               pre(mode) == Backward or startBack then  sa + 1    else 0;
        f = if pre(mode) == Forward or startFor   then  f0 + f1*v elseif
               pre(mode) == Backward or startBack then -f0 + f1*v else f0*sa;

// state machine to determine configuration
mode = if (pre(mode) == Forward  or startFor)  and v&gt;0 then Forward  elseif
          (pre(mode) == Backward or startBack) and v&lt;0 then Backward else Stuck;
</pre></blockquote>


<p>
If the velocity of the friction element is not selected as state
(e. g. if connected to MultiBody elements like a crancshaft), the fix point iteration
will not be able to solve the set of equations when leaving the stuck mode.
In this case the acceleration is overdetermined by the external constrait <var>a</var>&nbsp;&lt;&gt;&nbsp;0 and the
stuck mode equation <var>a</var>&nbsp;=&nbsp;0. Now that we already became comfortable with a
non-zero but extremly small velocity in stuck mode, we can introduce another assumption:
When locked, the block is fixed to a extremely huge mass.
This means it can move in stuck mode, but then implies a huge friction force.
These high values will not enter the integrator, because they only act during fix point
iteration and directly lead to leaving the stuck mode. For better parametrization not the mass
(or the moment of inertia in rotational case) but rather the inverse mass <var>m_inv_fixed</var> will be the input parameter.
By default it is set to zero and implies exactly the same behaviour as the set of equations above.
At fix point iteration problems it can be set to a small value (e. g. 1e-15) meaning a huge mass.
This results in a slightly modified set of equations:
</p>

<blockquote><pre>
// part of mixed system of equations
startFor  = pre(mode) == Stuck and sa &gt;  1;
startBack = pre(mode) == Stuck and sa &lt; -1;
        a = der(v);
        a = if pre(mode) == Forward  or startFor  then  sa - 1    elseif
               pre(mode) == Backward or startBack then  sa + 1    else m_inv*f;
        f = if pre(mode) == Forward or startFor   then  f0 + f1*v elseif
               pre(mode) == Backward or startBack then -f0 + f1*v else f0*sa;

// state machine to determine configuration
mode = if (pre(mode) == Forward  or startFor)  and v&gt;0 then Forward  elseif
          (pre(mode) == Backward or startBack) and v&lt;0 then Backward else Stuck;
</pre></blockquote>

<p>
The above approach to model a simplified friction element is slightly generalized in model
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialFriction\">Interfaces.PartialFriction</a>:
</p>

<ul>
<li> The sliding friction force has a nonlinear characteristic instead a linear one,
     by interpolation in a table of f(v) values.</li>
<li> There may be a jump in the friction force when going from stuck to sliding mode
     (described with parameter peak).</li>
</ul>
</html>"));
end ModelingOfFriction;
