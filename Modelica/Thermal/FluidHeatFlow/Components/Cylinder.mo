within Modelica.Thermal.FluidHeatFlow.Components;
model Cylinder "Simple model of a piston in a cylinder"
  import Modelica.Constants.small;
  extends FluidHeatFlow.BaseClasses.SinglePortLeft(final Exchange=true);

  parameter SI.Area A "Cross section of cylinder/piston";
  parameter SI.Length L "Length of cylinder";
  extends
    Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2
    (s(start=small));
  SI.Force f=flange.f "Force at piston";
protected
  SI.Mass m "Mass of medium";
  SI.Enthalpy H "Enthalpy of medium";
equation
  assert(s>=small, getInstanceName()+": Piston hit bottom of cylinder!");
  assert(s<=L, getInstanceName()+":Piston hit top of cylinder!");
  flowPort.p*A = -f;
  m = medium.rho*A*s;
  der(m) = flowPort.m_flow;
  H = m*h;
  der(H)=flowPort.H_flow;
  annotation (Documentation(info="<html>
<p>This is a simple model of a piston in a cylinder:</p>
<p>The translational flange is connected to the piston, the cylinder has a flowPort at the bottom.</p>
<p>
The position of the piston within the cylinder goes from 0 at the bottom to L (length of the cylinder) at the top of the cylinder.
If the piston leaves the cylinder, an assertion is triggered.
</p>
<ul>
<li>A movement of the piston is coupled with volume flow through the flowPort.</li>
<li>The force at the piston is equal to pressure of the fluid times A (cross section of the piston).</li>
</ul>
<p>
The piston is considered without mass.
</p>
<p>
Note: Take care of the initial conditions. The position of the piston (relative to the support) should be in the range (0, L).
The position of the flange (as well as of the support, if useSupport=true) is influenced by connected components.
</p>
</html>"),
     Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={       Text(
          extent={{-150,140},{150,100}},
          textColor={0,0,255},
          textString="%name"),
        Polygon(
          points={{-90,10},{-70,10},{-70,60},{70,60},{70,-60},{-70,-60},{-70,-10},
              {-90,-10},{-90,10}},
          lineColor={255,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Rectangle(
          extent={{-14,58},{68,-58}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-24,58},{-14,-58}},
          lineThickness=0.5,
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-14,10},{90,-10}},
          lineThickness=0.5,
          lineColor={0,127,0},
          fillColor={160,215,160},
          fillPattern=FillPattern.HorizontalCylinder),
        Line(points={{-10,-72},{70,-72}}),
        Polygon(
          points={{-40,-72},{-10,-62},{-10,-82},{-40,-72}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid)}));
end Cylinder;
