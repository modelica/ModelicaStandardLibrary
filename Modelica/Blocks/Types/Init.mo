within Modelica.Blocks.Types;
type Init = enumeration(
    NoInit
    "No initialization (start values are used as guess values with fixed=false)",
    SteadyState
    "Steady state initialization (derivatives of states are zero)",
    InitialState
               "Initialization with initial states",
    InitialOutput
    "Initialization with initial outputs (and steady state of the states if possible)")
"Enumeration defining initialization of a block" annotation (Evaluate=true,
Documentation(info="<html>
  <p>The following initialization alternatives are available:</p>
  <dl>
    <dt><code><strong>NoInit</strong></code></dt>
      <dd>No initialization (start values are used as guess values with <code>fixed=false</code>)</dd>
    <dt><code><strong>SteadyState</strong></code></dt>
      <dd>Steady state initialization (derivatives of states are zero)</dd>
    <dt><code><strong>InitialState</strong></code></dt>
      <dd>Initialization with initial states</dd>
    <dt><code><strong>InitialOutput</strong></code></dt>
      <dd>Initialization with initial outputs (and steady state of the states if possible)</dd>
  </dl>
</html>"));
