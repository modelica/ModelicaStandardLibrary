within Modelica.Thermal.FluidHeatFlow.BaseClasses;
partial model SinglePortBottom "Partial model of a single port at the bottom"
  parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
    "Medium" annotation (choicesAllMatching=true);
  parameter SI.Temperature T0(start=293.15, displayUnit="degC")
    "Initial temperature of medium";
  parameter Boolean T0fixed=false
    "Initial temperature guess value or fixed"
  annotation(choices(checkBox=true));
  output SI.Temperature T_port "Temperature at flowPort_a";
  output SI.Temperature T(start=T0, fixed=T0fixed) "Outlet temperature of medium";
  FluidHeatFlow.Interfaces.FlowPort_a flowPort(final medium=medium)
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
protected
  constant Boolean Exchange=true "Exchange of medium via flowport"
    annotation(HideResult=true);
  SI.SpecificEnthalpy h "Specific enthalpy in the volume";
equation
  T_port=flowPort.h/medium.cp;
  T=h/medium.cp;
  // mass flow -> ambient: mixing rule
  // mass flow <- ambient: energy flow defined by ambient's temperature
  if Exchange then
    flowPort.H_flow = semiLinear(flowPort.m_flow,flowPort.h,h);
  else
    h=flowPort.h;
  end if;
annotation (Documentation(info="<html>
<p>
Partial model of single port at the bottom, defining the medium and the temperature at the port.
</p>
</html>"),
     Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={       Text(
          extent={{-150,140},{150,100}},
          textColor={0,0,255},
          textString="%name")}));
end SinglePortBottom;
