within Modelica.Thermal.HeatTransfer.Interfaces;
partial connector HeatPort "Thermal port for 1-dim. heat transfer"
  SI.Temperature T "Port temperature";
  flow SI.HeatFlowRate Q_flow
    "Heat flow rate (positive if flowing from outside into the component)";
  annotation (Documentation(info="<html>

</html>"));
end HeatPort;
