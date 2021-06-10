within Modelica.Mechanics.MultiBody.UsersGuide;
class Contact "Contact"
  extends Modelica.Icons.Contact;

  annotation (Documentation(info="<html>
<h4>Library officers</h4>

<p>
<strong>Jakub Tobolar</strong> and <a href=\"http://www.robotic.dlr.de/Martin.Otter/\"><strong>Martin Otter</strong></a><br>
Deutsches Zentrum f&uuml;r Luft- und Raumfahrt (DLR)<br>
Institut f&uuml;r Systemdynamik und Regelungstechnik (SR)<br>
M&uuml;nchener Straße 20<br>
D-82234 We&szlig;ling<br>
Germany
</p>

<h4>Acknowledgements</h4>

<ul>
<li> The central idea to handle a certain class of overdetermined, consistent
     set of differential algebraic equations (i.e., there are more equations than
     unknowns) with symbolic transformation algorithms was developed together
     with Hilding Elmqvist and Sven Erik Mattsson, previously at Dassault Syst&egrave;mes AB, Lund, Sweden.
     The MultiBody library is heavily relying on this feature which is a
     prerequisite for a truly \"object-oriented\" multi-body systems library,
     where components can be connected together in any meaningful way.</li>
<li> The Examples.Loops.EngineV6 demo of a six cylinder V6 engine with
     6 planar loops and 1 degree of freedom is from Hilding Elmqvist and
     Sven Erik Mattsson.</li>
<li> Modelica.Mechanics.MultiBody.Forces.LineForceWithMass is based on model
     \"RelativeDistance\" from the Modelica VehicleDynamics library of
     Johan Andreasson from Royal Institute of Technology, Stockholm, Sweden.</li>
<li> The 1-dim. components (Parts.Rotor1D, Parts.BevelGear1D, Mounting1D) and
     Joints.GearConstraints are from Christian Schweiger.</li>
<li> The design of this library is based on work carried out
     in the EU RealSim project (Real-time Simulation for Design of
     Multi-physics Systems) funded by the European Commission within
     the Information Societies Technology (IST) programme under
     contract number IST 1999-11979.
     </li>
</ul>
</html>"));
end Contact;
