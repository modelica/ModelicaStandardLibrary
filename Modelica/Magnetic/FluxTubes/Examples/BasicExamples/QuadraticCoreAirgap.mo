within Modelica.Magnetic.FluxTubes.Examples.BasicExamples;
model QuadraticCoreAirgap "Educational example: iron core with airgap"
  extends Icons.Example;
  parameter Modelica.SIunits.Length l=0.1 "Outer length of iron core";
  parameter Modelica.SIunits.Length a=0.01 "Quadratic cross section";
  parameter Real my_r=1000 "Relative permeability of core";
  parameter Modelica.SIunits.Length delta=0.001 "Length of airgap";
  parameter Integer N=500 "Number of exciting coil turns";
  parameter Modelica.SIunits.Current I=1.5 "Maximum exciting current";
  Basic.ElectroMagneticConverter excitingCoil(N=N)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Shapes.FixedShape.Cuboid leftLeg(
    nonLinearPermeability=false,
    mu_rConst=1000,
    l=l - a,
    a=a,
    b=a)                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,30})));
  Shapes.FixedShape.Cuboid upperYoke(
    nonLinearPermeability=false,
    mu_rConst=1000,
    l=l - a,
    a=a,
    b=a) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,50})));
  Shapes.FixedShape.Cuboid rightLeg(
    nonLinearPermeability=false,
    mu_rConst=1000,
    l=l - a - delta,
    a=a,
    b=a)                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,30})));
  Shapes.FixedShape.Cuboid airGap(
    nonLinearPermeability=false,
    mu_rConst=1,
    l=delta,
    a=a,
    b=a) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-30})));
  Basic.ElectroMagneticConverter measuringCoil(N=1)
    annotation (Placement(transformation(extent={{40,-10},{20,10}})));
  Shapes.FixedShape.Cuboid lowerYoke(
    nonLinearPermeability=false,
    mu_rConst=1000,
    l=l - a,
    a=a,
    b=a) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={0,-50})));
  Basic.Ground magneticGround
    annotation (Placement(transformation(extent={{-30,-70},{-10,-50}})));
  Electrical.Analog.Basic.Ground electricGround1
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Electrical.Analog.Sources.RampCurrent rampCurrent(
    I=I,
    duration=0.015,
    startTime=0.01)                                 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,0})));
  Sensors.MagneticFluxSensor magFluxSensor annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-20,-30})));
  Electrical.Analog.Basic.Ground electricGround2
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={60,0})));
equation
  connect(excitingCoil.port_p, leftLeg.port_p)
    annotation (Line(points={{-20,10},{-20,20}}, color={255,127,0}));
  connect(leftLeg.port_n, upperYoke.port_p)
    annotation (Line(points={{-20,40},{-20,50},{-10,50}}, color={255,127,0}));
  connect(upperYoke.port_n, rightLeg.port_p)
    annotation (Line(points={{10,50},{20,50},{20,40}}, color={255,127,0}));
  connect(rightLeg.port_n, measuringCoil.port_p)
    annotation (Line(points={{20,20},{20,10}}, color={255,127,0}));
  connect(measuringCoil.port_n, airGap.port_p)
    annotation (Line(points={{20,-10},{20,-20}}, color={255,127,0}));
  connect(lowerYoke.port_p, airGap.port_n)
    annotation (Line(points={{10,-50},{20,-50},{20,-40}}, color={255,127,0}));
  connect(lowerYoke.port_n, magneticGround.port)
    annotation (Line(points={{-10,-50},{-20,-50}}, color={255,127,0}));
  connect(electricGround1.p, excitingCoil.n)
    annotation (Line(points={{-50,-10},{-40,-10}}, color={0,0,255}));
  connect(rampCurrent.p, electricGround1.p)
    annotation (Line(points={{-60,-10},{-50,-10}}, color={0,0,255}));
  connect(rampCurrent.n, excitingCoil.p)
    annotation (Line(points={{-60,10},{-40,10}}, color={0,0,255}));
  connect(measuringCoil.n, electricGround2.p)
    annotation (Line(points={{40,-10},{50,-10}}, color={0,0,255}));
  connect(measuringCoil.p, voltageSensor.p)
    annotation (Line(points={{40,10},{60,10}}, color={0,0,255}));
  connect(electricGround2.p, voltageSensor.n)
    annotation (Line(points={{50,-10},{60,-10}}, color={0,0,255}));
  connect(excitingCoil.port_n, magFluxSensor.port_n)
    annotation (Line(points={{-20,-10},{-20,-20}}, color={255,127,0}));
  connect(magFluxSensor.port_p, magneticGround.port)
    annotation (Line(points={{-20,-40},{-20,-50}}, color={255,127,0}));
  annotation (Documentation(info="<html>
<p>
Educational example of a magnetic circuit containing an iron core and an airgap:
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/MagneticCircuit.png\" alt=\"Magnetic circuit with iron core and airgap\">
</p>
<p>
A current ramp is applied in positive electric direction through the exciting coil, causing a rising magnetomotive force (mmf) in positive magnetic direction of the electromagnetic converter.  
The mmf in turn causes a magnetic flux through the circuit in the direction indicated by the flux sensor. 
From that magnetic flux, flux density can be calculated in every element of the magnetic circuit. Flux density is used to derive magnetic field strength.
Magnetic field strength times length of the flux line gives magnetic potential difference of each element. 
The sum of all magnetic potential differences is covered by the mmf of the exciting coil.
</p>
<p>
Using the values shown in section Parameters, the results can be validated easily by analytic calculations:
</p>
<table>
<tr><th>element   </th><th>cross section</th><th>length       </th><th>material          </th><th>B                   </th><th>H                                    </th><th>mmf              </th></tr>
<tr><td>left leg  </td><td>a*a          </td><td>l - a        </td><td>&mu;<sub>r</sub>  </td><td>flux / cross section</td><td>B/(&mu;<sub>r</sub>*&mu;<sub>0</sub>)</td><td>H*length         </td></tr>
<tr><td>upper yoke</td><td>a*a          </td><td>l - a        </td><td>&mu;<sub>r</sub>  </td><td>flux / cross section</td><td>B/(&mu;<sub>r</sub>*&mu;<sub>0</sub>)</td><td>H*length         </td></tr>
<tr><td>right leg </td><td>a*a          </td><td>l - a - delta</td><td>&mu;<sub>r</sub>  </td><td>flux / cross section</td><td>B/(&mu;<sub>r</sub>*&mu;<sub>0</sub>)</td><td>H*length         </td></tr>
<tr><td>airgap    </td><td>a*a          </td><td>delta        </td><td>&mu;<sub>r</sub>=1</td><td>flux / cross section</td><td>B/(&mu;<sub>r</sub>*&mu;<sub>0</sub>)</td><td>H*length         </td></tr>
<tr><td>lower yoke</td><td>a*a          </td><td>l - a        </td><td>&mu;<sub>r</sub>  </td><td>flux / cross section</td><td>B/(&mu;<sub>r</sub>*&mu;<sub>0</sub>)</td><td>H*length         </td></tr>
<tr><td>total     </td><td>             </td><td>             </td><td>                  </td><td>                    </td><td>                                     </td><td>&Sigma; mmf = N*I</td></tr>
</table>
<p>
Note that since no leakage is present, the magnetic flux is the same in every element - they are connected in series. 
For calculation of the length of flux lines, a medium flux line (dashed line) is used.
</p>
<p>
Additionally, a measuring coil is placed in the airgap. 
Due to Faraday's law, the time derivative of flux causes an induced voltage both in the exciting coil (in positive direction) and in the measuring coil (in negative direction). 
Since current and therefore flux are a linear time dependent ramp, induced voltages are constant during that ramp and zero otherwise. 
Note that usage of nonlinear magnetic material would change that result due the nonlinear relationship between magnetic field strength and flux density.
</p>
<p>
Note the proper usage of electric and magnetic grounds to define zero potential.
</p>
</html>"), experiment(StopTime=0.05, Interval=0.0001));
end QuadraticCoreAirgap;
