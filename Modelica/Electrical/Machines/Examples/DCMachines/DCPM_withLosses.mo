within Modelica.Electrical.Machines.Examples.DCMachines;
model DCPM_withLosses
  "Test example: Investigate influence of losses on DCPM motor performance"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Voltage Va=100 "Actual armature voltage";
  parameter SI.Time tStart=0.2
    "Start of armature voltage ramp";
  parameter SI.Time tRamp=0.8 "Armature voltage ramp";
  parameter SI.Torque TLoad1=63.66 "Nominal load torque";
  parameter SI.AngularVelocity wLoad1=1425*2*pi/60
    "Nominal load speed";
  parameter SI.Torque TLoad2=61.30 "Nominal load torque";
  parameter SI.AngularVelocity wLoad2=1417.5*2*pi/60
    "Nominal load speed";
  parameter SI.Inertia JLoad=0.15
    "Load's moment of inertia";
  Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm1(
    VaNominal=dcpmData1.VaNominal,
    IaNominal=dcpmData1.IaNominal,
    wNominal=dcpmData1.wNominal,
    TaNominal=dcpmData1.TaNominal,
    Ra=dcpmData1.Ra,
    TaRef=dcpmData1.TaRef,
    La=dcpmData1.La,
    Jr=dcpmData1.Jr,
    useSupport=false,
    Js=dcpmData1.Js,
    frictionParameters=dcpmData1.frictionParameters,
    coreParameters=dcpmData1.coreParameters,
    strayLoadParameters=dcpmData1.strayLoadParameters,
    brushParameters=dcpmData1.brushParameters,
    TaOperational=293.15,
    alpha20a=dcpmData1.alpha20a,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    ia(fixed=true))
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=tRamp,
    height=Va,
    startTime=tStart) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-70,70})));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-40,70})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-60,30},
        extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia1(J=JLoad)
    annotation (Placement(transformation(extent={{30,0},{50,20}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    loadTorque1(
    useSupport=false,
    tau_nominal=-TLoad1,
    TorqueDirection=false,
    w_nominal=wLoad1) annotation (Placement(transformation(extent={{80,0},
            {60,20}})));
  Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm2(
    VaNominal=dcpmData2.VaNominal,
    IaNominal=dcpmData2.IaNominal,
    wNominal=dcpmData2.wNominal,
    TaNominal=dcpmData2.TaNominal,
    Ra=dcpmData2.Ra,
    TaRef=dcpmData2.TaRef,
    La=dcpmData2.La,
    Jr=dcpmData2.Jr,
    useSupport=false,
    Js=dcpmData2.Js,
    frictionParameters=dcpmData2.frictionParameters,
    coreParameters=dcpmData2.coreParameters,
    strayLoadParameters=dcpmData2.strayLoadParameters,
    brushParameters=dcpmData2.brushParameters,
    alpha20a=dcpmData2.alpha20a,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    ia(fixed=true),
    TaOperational=368.15,
    core(v(start=0)))
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia2(J=JLoad)
    annotation (Placement(transformation(extent={{30,-60},{50,-40}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    loadTorque2(
    useSupport=false,
    tau_nominal=-TLoad2,
    TorqueDirection=false,
    w_nominal=wLoad2) annotation (Placement(transformation(extent={{80,-60},
            {60,-40}})));
  parameter Utilities.ParameterRecords.DcPermanentMagnetData dcpmData1 "Data of DC machine 1"
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  parameter Utilities.ParameterRecords.DcPermanentMagnetData dcpmData2(
    Ra=0.03864,
    alpha20a(displayUnit="1/K")=Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper,
    wNominal=148.44025288212,
    TaNominal=368.15,
    frictionParameters(PRef=100),
    coreParameters(PRef=200),
    strayLoadParameters(PRef=50),
    brushParameters(V=0.5)) "Data of DC machine 2"
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));

equation
  connect(ramp.y, signalVoltage.v)
    annotation (Line(points={{-59,70},{-52,70}}, color={0,0,255}));
  connect(signalVoltage.n, ground.p) annotation (Line(points={{-40,60},{-40,
          60},{-40,40},{-60,40}}, color={0,0,255}));
  connect(loadInertia1.flange_b, loadTorque1.flange)
    annotation (Line(points={{50,10},{60,10}}));
  connect(dcpm1.flange, loadInertia1.flange_a) annotation (Line(
      points={{20,10},{30,10}}));
  connect(loadInertia2.flange_b, loadTorque2.flange)
    annotation (Line(points={{50,-50},{60,-50}}));
  connect(dcpm2.flange, loadInertia2.flange_a) annotation (Line(
      points={{20,-50},{30,-50}}));
  connect(signalVoltage.p, dcpm1.pin_ap) annotation (Line(
      points={{-40,80},{-20,80},{-20,40},{16,40},{16,20}}, color={0,0,255}));
  connect(signalVoltage.p, dcpm2.pin_ap) annotation (Line(
      points={{-40,80},{-20,80},{-20,-20},{16,-20},{16,-40}}, color={0,0,255}));
  connect(signalVoltage.n, dcpm1.pin_an) annotation (Line(
      points={{-40,60},{-40,20},{4,20}}, color={0,0,255}));
  connect(signalVoltage.n, dcpm2.pin_an) annotation (Line(
      points={{-40,60},{-40,-40},{4,-40}}, color={0,0,255}));
  annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6), Documentation(
        info="<html>
<strong>Test example: Investigate influence of losses on DCPM motor performance</strong><br>
Both motors are started with a voltage ramp applied to the armature, causing the DC machines to start,
and accelerating inertias. Both machines are loading with a quadratic speed dependent load torque.<br>
The first machine <code>dcpm1</code> uses default machine parameters of model <em>DC_PermanentMagnet</em>,
the second machine <code>dcpm2</code> is parametrized with additional losses:<br>
<table>
<tr><td>                            </td><td>   dcpm1</td><td>   dcpm2</td><td>     </td></tr>
<tr><td>Armature voltage            </td><td>     100</td><td>     100</td><td>    V</td></tr>
<tr><td>Armature current            </td><td>     100</td><td>     100</td><td>    A</td></tr>
<tr><td>Inner voltage               </td><td>    95.0</td><td>    94.5</td><td>    V</td></tr>
<tr><td>Nominal speed               </td><td>  1425.0</td><td>  1417.5</td><td>  rpm</td></tr>
<tr><td>Armature resistance         </td><td> 0.05000</td><td> 0.03864</td><td>  Ohm</td></tr>
<tr><td>Temperature coefficient     </td><td>     n/a</td><td> 0.00392</td><td>  1/K</td></tr>
<tr><td>Reference temperature       </td><td>     n/a</td><td>      20</td><td> degC</td></tr>
<tr><td>Operation temperature       </td><td>     n/a</td><td>      95</td><td> degC</td></tr>
<tr><td>Brush voltage drop          </td><td>     n/a</td><td>     0.5</td><td>    V</td></tr>
<tr><td>Electrical input            </td><td>  10,000</td><td>  10,000</td><td>    W</td></tr>
<tr><td>Armature copper losses      </td><td>     500</td><td>     500</td><td>    W</td></tr>
<tr><td>Core losses                 </td><td>     n/a</td><td>     200</td><td>    W</td></tr>
<tr><td>Stray load losses           </td><td>     n/a</td><td>      50</td><td>    W</td></tr>
<tr><td>Friction losses             </td><td>     n/a</td><td>     100</td><td>    W</td></tr>
<tr><td>Brush losses                </td><td>     n/a</td><td>      50</td><td>    W</td></tr>
<tr><td>Mechanical output           </td><td>   9,500</td><td>   9,100</td><td>    W</td></tr>
<tr><td>Nominal torque              </td><td>   63,66</td><td>   61,30</td><td>   Nm</td></tr>
</table>
<br>
Note: The reference values (voltage, current, speed) are already propagated to the loss records,
using the nominal operation point.<br>
See:<br>
Anton Haumer, Christian Kral, Hansj&ouml;rg Kapeller, Thomas B&auml;uml, Johannes V. Gragger<br>
<a href=\"https://2009.international.conference.modelica.org/proceedings/pages/papers/0103/0103_FI.pdf\">
The AdvancedMachines Library: Loss Models for Electric Machines</a><br>
Modelica 2009, 7<sup>th</sup> International Modelica Conference
</html>"));
end DCPM_withLosses;
