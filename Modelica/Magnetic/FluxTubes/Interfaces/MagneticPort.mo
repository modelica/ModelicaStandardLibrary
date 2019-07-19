within Modelica.Magnetic.FluxTubes.Interfaces;
connector MagneticPort "Generic magnetic port"
  SI.MagneticPotential V_m "Magnetic potential at the port";
  flow SI.MagneticFlux Phi "Magnetic flux flowing into the port";

  annotation (defaultComponentName="mag");
end MagneticPort;
