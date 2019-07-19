within Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces;
partial model TwoPort "Elementary partial two port for textual programming"
  extends Magnetic.QuasiStatic.FundamentalWave.Interfaces.TwoPortExtended;

equation
  // Local flux balance
  port_p.Phi + port_n.Phi = Complex(0, 0);
  annotation (
    Documentation(info="<html>
<p>
The partial two port elementary model extends from the partial two port model and adds one equation considering the balance of flow variables, <code>port_p.Phi + port_n.Phi = Complex(0,0)</code>. Additionally, a variable for magnetic potential difference of the two magnetic ports, <code>V_m</code>, and the flux into the positive port, <code>Phi</code>, are defined.
</p>
</html>"));
end TwoPort;
