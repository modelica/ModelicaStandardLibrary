within Modelica.Thermal.FluidHeatFlow.BaseClasses;
partial model TwoPort "Partial model of two port"
  parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
    "Medium in the component" annotation (choicesAllMatching=true);
  parameter SI.Mass m(start=1) "Mass of medium";
  parameter SI.Temperature T0(start=293.15, displayUnit="degC")
    "Initial temperature of medium"
    annotation(Dialog(enable=m>Modelica.Constants.small));
  parameter Boolean T0fixed=false
    "Initial temperature guess value or fixed"
  annotation(choices(checkBox=true),Dialog(enable=m>Modelica.Constants.small));
  parameter Real tapT(final min=0, final max=1)=1
    "Defines temperature of heatPort between inlet and outlet temperature";
  SI.Pressure dp "Pressure drop a->b";
  SI.VolumeFlowRate V_flow(start=0) "Volume flow a->b";
  SI.HeatFlowRate Q_flow "Heat exchange with ambient";
  output SI.Temperature T(start=T0, fixed=T0fixed)
    "Outlet temperature of medium";
  output SI.Temperature T_a "Temperature at flowPort_a";
  output SI.Temperature T_b "Temperature at flowPort_b";
  output SI.TemperatureDifference dT
    "Temperature increase of coolant in flow direction";
  SI.Temperature T_q
    "Temperature relevant for heat exchange with ambient";
protected
  SI.SpecificEnthalpy h(start=medium.cp*T0) "Medium's specific enthalpy";
public
  FluidHeatFlow.Interfaces.FlowPort_a flowPort_a(final medium=medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(final medium=medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  dp=flowPort_a.p - flowPort_b.p;
  V_flow=flowPort_a.m_flow/medium.rho;
  T_a=flowPort_a.h/medium.cp;
  T_b=flowPort_b.h/medium.cp;
  dT=if noEvent(V_flow>=0) then T-T_a else T_b-T;
  h = medium.cp*T;
  T_q = T  - noEvent(sign(V_flow))*(1 - tapT)*dT;
  // mass balance
  flowPort_a.m_flow + flowPort_b.m_flow = 0;
  // energy balance
  if m>Modelica.Constants.small then
    flowPort_a.H_flow + flowPort_b.H_flow + Q_flow = m*medium.cv*der(T);
  else
    flowPort_a.H_flow + flowPort_b.H_flow + Q_flow = 0;
  end if;
  // mass flow a->b mixing rule at a, energy flow at b defined by medium's temperature
  // mass flow b->a mixing rule at b, energy flow at a defined by medium's temperature
  flowPort_a.H_flow = semiLinear(flowPort_a.m_flow,flowPort_a.h,h);
  flowPort_b.H_flow = semiLinear(flowPort_b.m_flow,flowPort_b.h,h);
annotation (Documentation(info="<html>
<p>Partial model with two flowPorts.</p>
<p>Possible heat exchange with the ambient is defined by Q_flow; setting this = 0 means no energy exchange.</p>
<p>
Setting parameter m (mass of medium within pipe) to zero
leads to neglect of temperature transient cv*m*der(T).</p>
<p>Mixing rule is applied.</p>
<p>Parameter 0 &lt; tapT &lt; 1 defines temperature of heatPort between medium's inlet and outlet temperature.</p>
</html>"));
end TwoPort;
