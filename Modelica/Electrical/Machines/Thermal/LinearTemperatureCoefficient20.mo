within Modelica.Electrical.Machines.Thermal;
type LinearTemperatureCoefficient20 =
    SI.LinearTemperatureCoefficient
  "Linear temperature coefficient with choices" annotation (choices(
    choice=Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero
      "Not temperature dependent",
    choice=Modelica.Electrical.Machines.Thermal.Constants.alpha20Aluminium
      "Aluminium",
    choice=Modelica.Electrical.Machines.Thermal.Constants.alpha20Brass "Brass",
    choice=Modelica.Electrical.Machines.Thermal.Constants.alpha20Bronze "Bronze",
    choice=Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper "Copper"));
