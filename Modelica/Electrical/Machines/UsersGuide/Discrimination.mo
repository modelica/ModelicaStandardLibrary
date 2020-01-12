within Modelica.Electrical.Machines.UsersGuide;
class Discrimination "Discrimination of Machine models"
  extends Modelica.Icons.Information;
  annotation (preferredView="info",Documentation(info="<html>
  <table>
  <thead>
  <tr>
  <th align=\"left\">Machine type</th>
  <th align=\"left\">Transient models</th>
  <th align=\"left\">QuasiStatic models</th>
  </tr>
  </thead>
  <tbody>
  <tr>
  <td>Transformers</td>
  <td><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.Transformers\">Modelica.Electrical.Machines.BasicMachines.Transformers</a></td>
  <td><a href=\"modelica://Modelica.Electrical.QuasiStatic.Machines.BasicMachines.Transformers\">Modelica.Electrical.QuasiStatic.Machines.BasicMachines.Transformers</a></td>
  </tr>
  <tr>
  <td>DC machines</td>
  <td><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines\">Modelica.Electrical.Machines.BasicMachines.DCMachines</a></td>
  <td><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.QuasiStaticDCMachines\">Modelica.Electrical.Machines.BasicMachines.QuasiStaticDCMachines</a></td>
  </tr>
  <tr>
  <td>Induction machines, limited to three phases</td>
  <td><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.InductionMachines\">Modelica.Electrical.Machines.BasicMachines.InductionMachines</a></td>
  <td>n/a</td>
  </tr>
  <tr>
  <td>Synchronous machines, limited to three phases</td>
  <td><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousMachines\">Modelica.Electrical.Machines.BasicMachines.SynchronousMachines</a></td>
  <td>n/a</td>
  </tr>
  <tr>
  <td>Induction machines, arbitrary number of phases</td>
  <td><a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines\">Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines</a></td>
  <td><a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines\">Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines</a></td>
  </tr>
  <tr>
  <td>Synchronous machines, arbitrary number of phases</td>
  <td><a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines\">Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines</a></td>
  <td><a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines\">Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines</a></td>
  </tr>
   </tbody>
  </table>

  <h4>Note</h4>
  <ul>
  <li>Transient and quasiStatic models are parameter compatible.</li>
  <li>Induction machine models limited to three phases and with arbitrary number of phases are parameter compatible.</li>
  <li>Synchronous machine models limited to three phases and with arbitrary number of phases are parameter compatible.</li>
  </ul>
  </html>"));
end Discrimination;
