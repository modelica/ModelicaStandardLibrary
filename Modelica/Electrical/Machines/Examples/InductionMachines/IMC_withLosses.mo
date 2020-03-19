within Modelica.Electrical.Machines.Examples.InductionMachines;
model IMC_withLosses
  "Test example: InductionMachineSquirrelCage with losses"
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of phases";
  import Modelica.Constants.pi;
  import Modelica.Units.Conversions.from_rpm;
  import Modelica.Units.Conversions.to_rpm;
  import Modelica.Units.Conversions.from_degC;
protected
  parameter SI.Power PNominal=18500 "Nominal output";
  parameter SI.Voltage VNominal=400 "Nominal RMS voltage";
  parameter SI.Current INominal=32.85 "Nominal RMS current";
  parameter Real pfNominal=0.898 "Nominal power factor";
  parameter SI.Power PsNominal=sqrt(3)*VNominal*INominal*pfNominal "Nominal stator power";
  parameter SI.Power lossNominal=PsNominal-PNominal "Nominal losses";
  parameter Real etaNominal=0.9049 "Nominal efficiency";
  parameter SI.Frequency fNominal=50 "Nominal frequency";
  parameter SI.AngularVelocity wNominal=from_rpm(1462.5)
    "Nominal speed";
  parameter SI.Torque TNominal=PNominal/wNominal
    "Nominal torque";
  parameter SI.Temperature TempNominal=from_degC(90)
    "Nominal temperature";
  SI.Power Pel=electricalPowerSensor.P;
  SI.ReactivePower Qel=electricalPowerSensor.Q;
  SI.ApparentPower Sel=sqrt(Pel^2 + Qel^2);
  parameter Real Ptable[:]={1E-6,1845,3549,5325,7521,9372,11010,12930,
      14950,16360,18500,18560,20180,22170};
  parameter Real Itable[:]={11.0,11.20,12.27,13.87,16.41,18.78,21.07,
      23.92,27.05,29.40,32.85,32.95,35.92,39.35};
  parameter Real wtable[:]=from_rpm({1500,1496,1493,1490,1486,1482,1479,1475,1471,
      1467,1462,1462,1458,1453});
  parameter Real ctable[:]={0.085,0.327,0.506,0.636,0.741,0.797,0.831,
      0.857,0.875,0.887,0.896,0.896,0.902,0.906};
  parameter Real etable[:]={0,0.7250,0.8268,0.8698,0.8929,0.9028,0.9064,
      0.9088,0.9089,0.9070,0.9044,0.9043,0.9008,0.8972};
public
  output SI.Power Pmech=powerSensor.power "Mechanical output";
  output SI.Power Ps_sim=sqrt(3)*VNominal*I_sim*pf_sim "Simulated stator power";
  output SI.Power Ps_meas=sqrt(3)*VNominal*I_meas*pf_meas "Simulated stator power";
  output SI.Power loss_sim=Ps_sim-Pmech "Simulated total losses";
  output SI.Power loss_meas=Ps_meas-Pmech "Measured total losses";
  output SI.Current I_sim=currentQuasiRMSSensor.I "Simulated current";
  output SI.Current I_meas=combiTable1Ds.y[1] "Measured current";
  output SI.AngularVelocity w_sim(displayUnit="rev/min")=aimc.wMechanical "Simulated speed";
  output SI.AngularVelocity w_meas(displayUnit="rev/min")=combiTable1Ds.y[2] "Measured speed";
  output Real pf_sim=if noEvent(Sel > Modelica.Constants.small) then Pel/Sel else 0 "Simulated power factor";
  output Real pf_meas=combiTable1Ds.y[3] "Measured power factor";
  output Real eff_sim=if noEvent(abs(Pel) > Modelica.Constants.small) then Pmech/Pel else 0 "Simulated efficiency";
  output Real eff_meas=combiTable1Ds.y[4] "Measured efficiency";
  Machines.BasicMachines.InductionMachines.IM_SquirrelCage aimc(
    p=aimcData.p,
    fsNominal=aimcData.fsNominal,
    Rs=aimcData.Rs,
    TsRef=aimcData.TsRef,
    alpha20s(displayUnit="1/K") = aimcData.alpha20s,
    Lszero=aimcData.Lszero,
    Lssigma=aimcData.Lssigma,
    Jr=aimcData.Jr,
    Js=aimcData.Js,
    frictionParameters=aimcData.frictionParameters,
    phiMechanical(fixed=true),
    statorCoreParameters=aimcData.statorCoreParameters,
    strayLoadParameters=aimcData.strayLoadParameters,
    Lm=aimcData.Lm,
    Lrsigma=aimcData.Lrsigma,
    Rr=aimcData.Rr,
    TrRef=aimcData.TrRef,
    TsOperational=TempNominal,
    TrOperational=TempNominal,
    wMechanical(fixed=true, start=2*pi*aimcData.fsNominal/aimcData.p),
    alpha20r=aimcData.alpha20r)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Machines.Utilities.TerminalBox terminalBox(terminalConnection="D")
    annotation (Placement(transformation(extent={{-40,16},{-20,36}})));
  Machines.Sensors.ElectricalPowerSensor electricalPowerSensor annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,40})));
  Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (
      Placement(transformation(
        origin={-30,70},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m,
    f=fill(fNominal, m),
    V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
        origin={-70,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-70,30})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-70,0},
        extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=aimcData.Jr)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{70,0},{50,20}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{50,-60},{70,-40}})));
  Modelica.Blocks.Continuous.PI PI(
    k=0.01,
    T=0.01,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-10,-40},{10,-60}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1.2*PNominal,
    offset=0,
    startTime=4.5,
    duration=5.5)
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table={{Ptable[j],
        Itable[j],wtable[j],ctable[j],etable[j]} for j in 1:size(Ptable,
        1)}, smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  parameter Utilities.ParameterRecords.IM_SquirrelCageData aimcData(
    statorCoreParameters(PRef=410, VRef=387.9),
    Jr=0.12,
    Rs=0.56,
    alpha20s(displayUnit="1/K")=Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper,
    Lssigma=1.52/(2*pi*fNominal),
    frictionParameters(PRef=180, wRef=wNominal),
    strayLoadParameters(
      PRef=0.005*sqrt(3)*VNominal*INominal*pfNominal,
      IRef=INominal/sqrt(3),
      wRef=wNominal),
    Lm=66.4/(2*pi*fNominal),
    Lrsigma=2.31/(2*pi*fNominal),
    Rr=0.42,
    alpha20r(displayUnit="1/K")=Modelica.Electrical.Machines.Thermal.Constants.alpha20Aluminium)   "Induction machine data"
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));

initial equation
  aimc.i_0_s = 0;
  der(aimc.idq_sr) = zeros(2);
  der(aimc.idq_rr) = zeros(2);
equation
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-70,20},{-70,10}}, color={0,0,255}));
  connect(sineVoltage.plug_n, star.plug_p)
    annotation (Line(points={{-70,60},{-70,40}}, color={0,0,255}));
  connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
      points={{-36,20},{-36,20}},
      color={0,0,255}));
  connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
      points={{-24,20},{-24,20}},
      color={0,0,255}));
  connect(currentQuasiRMSSensor.plug_n, electricalPowerSensor.plug_p)
    annotation (Line(
      points={{-30,60},{-30,57.5},{-30,57.5},{-30,55},{-30,50},{-30,50}},
      color={0,0,255}));

  connect(electricalPowerSensor.plug_nv, star.plug_p) annotation (Line(
      points={{-40,40},{-70,40}},
      color={0,0,255}));
  connect(electricalPowerSensor.plug_ni, terminalBox.plugSupply)
    annotation (Line(
      points={{-30,30},{-30,22}},
      color={0,0,255}));
  connect(aimc.flange, powerSensor.flange_a) annotation (Line(
      points={{-20,10},{-10,10}}));
  connect(powerSensor.flange_b, loadInertia.flange_a) annotation (Line(
      points={{10,10},{20,10}}));
  connect(torque.flange, loadInertia.flange_b) annotation (Line(
      points={{50,10},{40,10}}));
  connect(gain.y, torque.tau) annotation (Line(
      points={{71,-50},{80,-50},{80,10},{72,10}},
      color={0,0,127}));
  connect(sineVoltage.plug_p, currentQuasiRMSSensor.plug_p) annotation (
      Line(
      points={{-70,80},{-30,80}},
      color={0,0,255}));
  connect(powerSensor.power, feedback.u2) annotation (Line(
      points={{-8,-1},{-8,-20},{0,-20},{0,-42}},
      color={0,0,127}));
  connect(feedback.y, PI.u) annotation (Line(
      points={{9,-50},{18,-50}},
      color={0,0,127}));
  connect(PI.y, gain.u) annotation (Line(
      points={{41,-50},{48,-50}},
      color={0,0,127}));
  connect(ramp.y, feedback.u1) annotation (Line(
      points={{-19,-50},{-8,-50}},
      color={0,0,127}));
  connect(powerSensor.power, combiTable1Ds.u) annotation (Line(
      points={{-8,-1},{-8,-20},{18,-20}},
      color={0,0,127}));
  annotation (
    experiment(StopTime=5.0, Interval=1E-4, Tolerance=1e-06),
    Documentation(info="<html>
<ul>
<li>Simulate for 5 seconds: The machine is started at nominal speed, flux is build up in the machine.</li>
<li>Continue the simulation for additional 5 seconds: Subsequently a load ramp is applied.</li>
<li>Compare by plotting versus Pmech:</li>
</ul>
<table>
<tr><td>Current      </td><td>I_sim   </td><td>I_meas  </td></tr>
<tr><td>Speed        </td><td>w_sim   </td><td>w_meas  </td></tr>
<tr><td>Power factor </td><td>pf_sim  </td><td>pf_meas </td></tr>
<tr><td>Efficiency   </td><td>eff_sim </td><td>eff_meas</td></tr>
</table>
<p>Machine parameters are taken from a standard 18.5 kW 400 V 50 Hz motor, simulation results are compared with measurements.</p>
<table>
<tr><td>Nominal stator current            </td><td>     32.85  </td><td>A      </td></tr>
<tr><td>Power factor                      </td><td>      0.898 </td><td>       </td></tr>
<tr><td>Speed                             </td><td>   1462.5   </td><td>rpm    </td></tr>
<tr><td>Electrical input                  </td><td> 20,443.95  </td><td>W      </td></tr>
<tr><td>Stator copper losses              </td><td>    770.13  </td><td>W      </td></tr>
<tr><td>Stator core losses                </td><td>    410.00  </td><td>W      </td></tr>
<tr><td>Rotor  copper losses              </td><td>    481.60  </td><td>W      </td></tr>
<tr><td>Stray load losses                 </td><td>    102.22  </td><td>W      </td></tr>
<tr><td>Friction losses                   </td><td>    180.00  </td><td>W      </td></tr>
<tr><td>Mechanical output                 </td><td> 18,500.00  </td><td>W      </td></tr>
<tr><td>Efficiency                        </td><td>     90.49  </td><td>%      </td></tr>
<tr><td>Nominal torque                    </td><td>    120.79  </td><td>Nm     </td></tr>
</table>
<br>
<table>
<tr><td>Stator resistance per phase       </td><td>  0.56     </td><td>&Omega;</td></tr>
<tr><td>Temperature coefficient           </td><td> copper    </td><td>       </td></tr>
<tr><td>Reference temperature             </td><td> 20        </td><td>&deg;C </td></tr>
<tr><td>Operation temperature             </td><td> 90        </td><td>&deg;C </td></tr>
<tr><td>Stator leakage reactance at 50 Hz </td><td>  1.52     </td><td>&Omega;</td></tr>
<tr><td>Main  field    reactance at 50 Hz </td><td> 66.40     </td><td>&Omega;</td></tr>
<tr><td>Rotor  leakage reactance at 50 Hz </td><td>  2.31     </td><td>&Omega;</td></tr>
<tr><td>Rotor  resistance per phase       </td><td>  0.42     </td><td>&Omega;</td></tr>
<tr><td>Temperature coefficient           </td><td> aluminium </td><td>       </td></tr>
<tr><td>Reference temperature             </td><td> 20        </td><td>&deg;C </td></tr>
<tr><td>Operation temperature             </td><td> 90        </td><td>&deg;C </td></tr>
</table>
<p>See:<br>
Anton Haumer, Christian Kral, Hansj&ouml;rg Kapeller, Thomas B&auml;uml, Johannes V. Gragger<br>
<a href=\"https://2009.international.conference.modelica.org/proceedings/pages/papers/0103/0103_FI.pdf\">
The AdvancedMachines Library: Loss Models for Electric Machines</a><br>
Modelica 2009, 7<sup>th</sup> International Modelica Conference</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Text(
                extent={{-72,100},{68,80}},
                textColor={0,0,255},
                textString=
            "Simulate for 5 seconds for starting the machine."),Text(
                extent={{-100,-80},{100,-100}},
                textColor={0,0,255},
                textString=
            "Continue the simulation for additional 5 seconds: a load ramp is applied.")}));
end IMC_withLosses;
