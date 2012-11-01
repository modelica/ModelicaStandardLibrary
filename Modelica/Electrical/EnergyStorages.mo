within Modelica.Electrical;
package EnergyStorages "Library for electric energy storages"
extends EnergyStorages.Icons.BatteryPackage;

  package UsersGuide "User's Guide of the EnergyStorages library"

  extends Modelica.Icons.Information;

    model GeneralInformation "General Information"
      extends Modelica.Icons.Information;
      annotation (Documentation(info="<html>
<p>This package contains electric energy storage models and components for modeling these storages.</p>
<p>A rough overview about the EnergyStorages library was presented at the Modelica conference 2011:</p>
<p>web: <a href=\"http://modelica.org/events/modelica2011/Proceedings/pages/papers/17_4_ID_105_a_fv.pdf\">http://modelica.org/events/modelica2011/Proceedings/pages/papers/17_4_ID_105_a_fv.pdf</a></p>
</html>"));

    end GeneralInformation;

  class Contact "Contact"
    extends Modelica.Icons.Contact;

    annotation (Documentation(info="<html>
<dl><dt>The Electric Energy Storages Library was developed by Dr. Markus Einhorn, Dr. Fiorentino Valerio Conte and Dr. Christian Kral from the</dt>
<dd>AIT Austrian Institute of Technology</dd>
<dd>Oesterreichisches Forschungs und Pruefzentrum Arsenal GmbH</dd>
<dd>Giefinggasse 2</dd>
<dd>1220 Vienna, Austria</dd>
<dd>web: <a href=\"http://www.ait.ac.at\">http://www.ait.ac.at</a></dd>
<dd>e-mail: <a href=\"mailto:markus.einhorn@ait.ac.at\">markus.einhorn@ait.ac.at</a></dd>
</dl>
</html>"));

  end Contact;
   annotation (__Dymola_DocumentationClass=true, Documentation(info="<html>
 The Electric Energy Storages Library contains models with different complexity for simulating of electric energy storages like batteries (single cells as well as stacks) interacting with loads, battery
management systems, loads and charging devices.
</html>"));
  end UsersGuide;

  package Examples
    "Examples that demonstrate the usage of the components of the Electric Energy Storage Library "
    extends Modelica.Icons.ExamplesPackage;

    model Impedance
    extends Modelica.Icons.Example;
      output Modelica.SIunits.Current I=currentSensor.i;
      output Modelica.SIunits.Voltage V=voltageSensor.v;
      Modelica.Electrical.Analog.Sources.PulseCurrent pulseCurrent(
        I=10,
        width=50,
        offset=0,
        period=300)
                  annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-60,-20})));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(extent={{50,-60},{70,-40}})));
      Batteries.Components.Impedances.CellImpedance  rCseriesLinear(
        Rs(R0=0.001),
        RC={EnergyStorages.CellRecords.Components.RCelement(
              Rd=EnergyStorages.CellRecords.Components.Resistance(         R0=0.0002),
              Cd=EnergyStorages.CellRecords.Components.Capacitance(         C0=50000)),
            EnergyStorages.CellRecords.Components.RCelement(
              Rd=EnergyStorages.CellRecords.Components.Resistance(         R0=0.0003),
              Cd=EnergyStorages.CellRecords.Components.Capacitance(         C0=60000)),
            EnergyStorages.CellRecords.Components.RCelement(
              Rd=EnergyStorages.CellRecords.Components.Resistance(         R0=0.0004),
              Cd=EnergyStorages.CellRecords.Components.Capacitance(         C0=70000))})
        annotation (Placement(transformation(extent={{0,30},{40,50}})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=298.15)
        annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
      Modelica.Blocks.Sources.Constant const(k=0)
        annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
      Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
        annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-60,20})));
    equation
      connect(pulseCurrent.n, ground.p) annotation (Line(
          points={{-60,-30},{-60,-40},{60,-40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(fixedTemperature.port, rCseriesLinear.heatPort) annotation (Line(
          points={{-20,60},{20,60},{20,50}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(rCseriesLinear.t, rCseriesLinear.SOC) annotation (Line(
          points={{6,31},{6,20},{20,20},{20,31}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(rCseriesLinear.SOC, rCseriesLinear.i) annotation (Line(
          points={{20,31},{20,20},{34,20},{34,31}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(const.y, rCseriesLinear.SOC) annotation (Line(
          points={{-19,10},{20,10},{20,31}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(rCseriesLinear.pin_n, ground.p) annotation (Line(
          points={{40,40},{60,40},{60,-40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(rCseriesLinear.pin_p, voltageSensor.p) annotation (Line(
          points={{0,40},{0,-20},{10,-20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(voltageSensor.n, rCseriesLinear.pin_n) annotation (Line(
          points={{30,-20},{40,-20},{40,40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(currentSensor.p, pulseCurrent.p) annotation (Line(
          points={{-60,10},{-60,-10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(currentSensor.n, rCseriesLinear.pin_p) annotation (Line(
          points={{-60,30},{-60,40},{0,40}},
          color={0,0,255},
          smooth=Smooth.None));
      annotation (experiment(StopTime=2000, Interval=1));
    end Impedance;

    model SimpleCellDrivingCycle
    extends Modelica.Icons.Example;
      output Modelica.SIunits.Current I=currentSensor.i;
      output Modelica.SIunits.Voltage V=voltageSensor.v;
      output Modelica.SIunits.Voltage SOC=batteryCell.calculator.SOC;
      output Modelica.SIunits.Voltage OCV=batteryCell.OCV.v;
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
      EnergyStorages.Batteries.Cells.Basic.StaticResistance batteryCell(
          cellParameters=
            EnergyStorages.CellRecords.StaticResistance.Test1Parameters(),
          SOCini=1)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
          Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={30,0})));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-30,40})));
      Sources.Loads.Cycles.Liberal fTP72_1(Cn=40, C=2)
        annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=2.7)
        annotation (Placement(transformation(extent={{50,-10},{70,10}})));
    equation
      connect(batteryCell.pin_n, ground.p)      annotation (Line(
          points={{0,-10},{0,-40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(voltageSensor.p, batteryCell.pin_p)      annotation (Line(
          points={{30,10},{30,20},{0,20},{0,10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(voltageSensor.n, batteryCell.pin_n)      annotation (Line(
          points={{30,-10},{30,-20},{0,-20},{0,-10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(fTP72_1.pin_n, batteryCell.pin_n)      annotation (Line(
          points={{-60,-10},{-60,-40},{0,-40},{0,-10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(voltageSensor.v, greaterThreshold.u) annotation (Line(
          points={{40,0},{48,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(greaterThreshold.y, fTP72_1.on) annotation (Line(
          points={{71,0},{80,0},{80,60},{-80,60},{-80,0},{-69,0}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(currentSensor.p, batteryCell.pin_p) annotation (Line(
          points={{-20,40},{0,40},{0,10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(fTP72_1.pin_p, currentSensor.n) annotation (Line(
          points={{-60,10},{-60,40},{-40,40}},
          color={0,0,255},
          smooth=Smooth.None));
      annotation (experiment(StopTime=6930, Interval=1));
    end SimpleCellDrivingCycle;

    model AdvancedCellPulseCurrent
    extends Modelica.Icons.Example;
      output Modelica.SIunits.Current I=currentSensor.i;
      output Modelica.SIunits.Voltage V=voltageSensor.v;
      Modelica.Electrical.Analog.Sources.PulseCurrent pulseCurrent(
        I=10,
        period=500,
        width=50,
        offset=0) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-40,0})));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(extent={{10,-60},{30,-40}})));
      Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-10,0})));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-10,40})));
      EnergyStorages.Batteries.Cells.Basic.LinearDynamicImpedance batteryCell(
          cellParameters=
            EnergyStorages.CellRecords.LinearDynamicImpedance.Test1Parameters(),
          SOCini=0.5)
        annotation (Placement(transformation(extent={{10,-10},{30,10}})));
    equation
      connect(pulseCurrent.n, ground.p) annotation (Line(
          points={{-40,-10},{-40,-40},{20,-40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(ground.p, batteryCell.pin_n)            annotation (Line(
          points={{20,-40},{20,-10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(voltageSensor.p, batteryCell.pin_p)            annotation (Line(
          points={{-10,10},{-10,20},{20,20},{20,10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(voltageSensor.n, batteryCell.pin_n)            annotation (Line(
          points={{-10,-10},{-10,-20},{20,-20},{20,-10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(currentSensor.p, batteryCell.pin_p) annotation (Line(
          points={{0,40},{20,40},{20,10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(pulseCurrent.p, currentSensor.n) annotation (Line(
          points={{-40,10},{-40,40},{-20,40}},
          color={0,0,255},
          smooth=Smooth.None));
      annotation (experiment(StopTime=14100, Interval=1), Diagram(graphics));
    end AdvancedCellPulseCurrent;

    model AdvancedCellCycling
    extends Modelica.Icons.Example;
      output Modelica.SIunits.Current I=currentSensor.i;
      output Modelica.SIunits.Voltage V=voltageSensor.v;
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(extent={{50,-60},{70,-40}},
              rotation=0)));
      Modelica.Electrical.Analog.Ideal.IdealCommutingSwitch
        idealCommutingSwitch annotation (Placement(transformation(
            origin={0,60},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Sources.Chargers.CCCV        charger(
        Vmax=4.2,
        Imax=40,
        T=0.000001)                                annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-40,10})));
      Sources.Loads.BooleanConstantCurrent
                                   load(I=40)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=180,
            origin={-80,10})));
      BatteryManagement.VoltageCycling cycler(
        ns=1,
        np=1,
        delayAfterDischarging=100,
        Vmax=4.2,
        delayAfterCharging=500,
        Ifinal=2,
        Vmin=2.7)
        annotation (Placement(transformation(extent={{30,0},{10,20}})));
      Batteries.Cells.WithMeasurement.LinearDynamicImpedance batteryCell(
          cellParameters=
            EnergyStorages.CellRecords.LinearDynamicImpedance.Test1Parameters(),
          SOCini=0.5)
        annotation (Placement(transformation(extent={{50,0},{70,20}})));
      Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
          Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={90,10})));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=180,
            origin={40,60})));
    equation
      connect(cycler.Charging, charger.on)                        annotation (
          Line(
          points={{9,4},{0,4},{0,10},{-31,10}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(load.pin_p, idealCommutingSwitch.n2) annotation (Line(
          points={{-80,20},{-80,60},{-10,60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(load.pin_n, ground.p) annotation (Line(
          points={{-80,0},{-80,-40},{60,-40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(cycler.Discharging, load.on)        annotation (Line(
          points={{9,16},{0,16},{0,40},{-60,40},{-60,10},{-71,10}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(batteryCell.pin_n, ground.p)            annotation (Line(
          points={{60,0},{60,-40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(cycler.singleCellBus[1, 1], batteryCell.singleCellBus)
        annotation (Line(
          points={{29.6,10},{54.8,10}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(charger.pin_p, idealCommutingSwitch.n1) annotation (Line(
          points={{-40,20},{-40,55},{-10,55}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(charger.pin_n, ground.p) annotation (Line(
          points={{-40,0},{-40,-40},{60,-40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(charger.v, cycler.vMax) annotation (Line(
          points={{-31,4},{-20,4},{-20,30},{20,30},{20,21}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(batteryCell.pin_p, voltageSensor.p) annotation (Line(
          points={{60,20},{60,30},{90,30},{90,20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(batteryCell.pin_n, voltageSensor.n) annotation (Line(
          points={{60,0},{60,-10},{90,-10},{90,0}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(currentSensor.p, batteryCell.pin_p) annotation (Line(
          points={{50,60},{60,60},{60,20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(currentSensor.n, idealCommutingSwitch.p) annotation (Line(
          points={{30,60},{10,60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(cycler.Discharging, idealCommutingSwitch.control) annotation (
          Line(
          points={{9,16},{0,16},{0,52}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (experiment(StopTime=20000, Interval=1), Diagram(graphics));
    end AdvancedCellCycling;

    model SimpleStackCycling
    extends Modelica.Icons.Example;
      output Modelica.SIunits.Current Istack=currentSensor.i;
      output Modelica.SIunits.Current Icell=batteryStack.cellBus.i;
      output Modelica.SIunits.Voltage Vstack=voltageSensor.v;
      output Modelica.SIunits.Voltage Vcell=batteryStack.cellBus.v;
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(extent={{50,-60},{70,-40}},
              rotation=0)));
      Modelica.Electrical.Analog.Ideal.IdealCommutingSwitch
        idealCommutingSwitch annotation (Placement(transformation(
            origin={0,60},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Sources.Chargers.CCCV charger(T=0.000001,
        ExternalControl=true,
        Vmax=4.2,
        Imax=40)  annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-40,10})));
      BatteryManagement.VoltageCycling cycler(
        delayAfterDischarging=100,
        Vmax=4.2,
        delayAfterCharging=500,
        ns=1,
        np=1,
        Ifinal=2,
        Vmin=2.7,
        initialDischarging=false)
        annotation (Placement(transformation(extent={{30,0},{10,20}})));
      Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
          Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={90,10})));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=180,
            origin={40,60})));
      EnergyStorages.Batteries.Stacks.WithMeasurement.StaticResistanceScaled batteryStack(
        ns=100,
        np=2,
        SOCini=0.5,
        cellParameters=EnergyStorages.CellRecords.StaticResistance.Test2Parameters())
        annotation (Placement(transformation(extent={{50,0},{70,20}})));
      Sources.Loads.Cycles.FTP72 load(gain=1, table=[0,0; 1,0; 2,0; 3,0; 4,0; 5,0; 6,
            0; 7,0; 8,0; 9,0; 10,0; 11,0; 12,0; 13,0; 14,0; 15,0; 16,0; 17,0; 18,0;
            19,0; 20,7.63E-15; 21,2.656862299; 22,5.066824278; 23,6.919044302; 24,9.92721153;
            25,11.99083842; 26,13.28667893; 27,2.948986157; 28,5.137151842; 29,16.40934905;
            30,7.516868387; 31,5.908250322; 32,2.157048719; 33,-0.995107891; 34,-2.198487625;
            35,-2.161427667; 36,-1.557434624; 37,-2.088169806; 38,-12.35098315; 39,-7.948784273;
            40,0.817499451; 41,2.117771289; 42,2.166091748; 43,3.143999402; 44,6.26306327;
            45,11.87475974; 46,13.19569999; 47,11.72513052; 48,2.855969106; 49,0.277692017;
            50,0.904958197; 51,-6.363589501; 52,-11.0799931; 53,-8.109271371; 54,-4.867712487;
            55,0.886824653; 56,10.46680633; 57,12.8893158; 58,12.3191627; 59,12.00772035;
            60,8.509745343; 61,4.537143881; 62,3.911765052; 63,2.532362225; 64,-0.976453428;
            65,1.0812139; 66,3.177148783; 67,2.500817595; 68,1.101144937; 69,1.091145544;
            70,1.780345304; 71,5.361068592; 72,5.497513442; 73,2.644941662; 74,-0.25017447;
            75,-1.669071408; 76,2.532362225; 77,4.731114217; 78,6.336353546; 79,1.965818968;
            80,-0.235128558; 81,4.904488962; 82,6.551950386; 83,8.343637381; 84,11.16181509;
            85,8.205760078; 86,6.716255706; 87,5.12200457; 88,5.19826403; 89,5.275273722;
            90,2.694977444; 91,0.951372803; 92,1.791488361; 93,1.777192195; 94,3.494876196;
            95,6.164012091; 96,-0.763593295; 97,-1.629908514; 98,-0.813649371; 99,5.046487368;
            100,6.870545952; 101,6.135372417; 102,4.46133192; 103,3.616033726; 104,1.864225701;
            105,-1.615287117; 106,-2.467470057; 107,3.396206249; 108,5.147341381; 109,
            6.995471304; 110,7.153524107; 111,8.236929137; 112,6.573955157; 113,4.818460446;
            114,1.161216183; 115,-1.567435399; 116,-22.49130079; 117,-21.51938172; 118,
            -18.86940338; 119,-16.15374721; 120,-13.38226452; 121,-10.56480711; 122,
            -7.71122688; 123,-4.831375337; 124,-1.935104277; 125,-3.50282E-12; 126,0;
            127,0; 128,0; 129,0; 130,0; 131,0; 132,0; 133,0; 134,0; 135,0; 136,0; 137,
            0; 138,0; 139,0; 140,0; 141,0; 142,0; 143,0; 144,0; 145,0; 146,0; 147,0;
            148,0; 149,0; 150,0; 151,0; 152,0; 153,0; 154,0; 155,0; 156,0; 157,0; 158,
            0; 159,0; 160,0; 161,0; 162,0; 163,0; 164,3.200194369; 165,6.410240389;
            166,9.639989941; 167,12.89929459; 168,16.19800598; 169,19.54597616; 170,
            16.41978194; 171,16.03903701; 172,12.78077258; 173,6.459117883; 174,-3.115198616;
            175,-2.374217206; 176,-0.974859065; 177,3.933174589; 178,3.270190504; 179,
            3.307888855; 180,4.829761684; 181,12.80447373; 182,-3.161607682; 183,-15.10480141;
            184,-6.717964858; 185,-16.73479315; 186,-7.385146225; 187,-1.407686368;
            188,5.644245974; 189,3.731350062; 190,9.104510165; 191,15.17586056; 192,
            17.554767; 193,23.56615648; 194,30.00422086; 195,31.37224334; 196,31.16944854;
            197,15.53427713; 198,26.55164776; 199,18.46231859; 200,24.16384499; 201,
            22.76816223; 202,26.42478909; 203,18.10320226; 204,17.26562624; 205,16.33635994;
            206,7.020957872; 207,4.300084023; 208,5.592980506; 209,4.212060311; 210,
            6.845587556; 211,6.845587556; 212,6.845587556; 213,6.845587556; 214,9.560080973;
            215,9.64156472; 216,13.87348744; 217,15.53422692; 218,15.85777415; 219,13.30255272;
            220,14.95138738; 221,16.68797266; 222,14.05693456; 223,15.75817658; 224,
            19.07038909; 225,24.16331029; 226,23.29511248; 227,17.52724598; 228,14.62976509;
            229,11.60224307; 230,8.477397529; 231,5.289749171; 232,9.878810305; 233,
            13.04036023; 234,14.73844624; 235,16.51252525; 236,13.50761889; 237,16.86267019;
            238,13.82598361; 239,15.57296564; 240,12.45278851; 241,10.86426746; 242,
            7.601665095; 243,10.76750104; 244,10.76750104; 245,10.76750104; 246,10.76750104;
            247,10.76750104; 248,9.13923413; 249,5.860690061; 250,5.743763523; 251,-0.698505663;
            252,2.230374967; 253,3.624743419; 254,6.58373148; 255,4.963409033; 256,7.931230103;
            257,14.09534591; 258,11.12236337; 259,11.16968066; 260,9.654001849; 261,
            4.99907654; 262,3.361220902; 263,3.232982113; 264,3.107067348; 265,1.493270362;
            266,13.32133575; 267,2.92251612; 268,7.254387981; 269,5.729048631; 270,5.658319597;
            271,10.0305283; 272,11.56959204; 273,13.17044223; 274,14.84277344; 275,16.5967319;
            276,16.88346888; 277,17.17387278; 278,23.85831694; 279,18.00680173; 280,
            13.45509413; 281,16.80393012; 282,10.52829073; 283,7.307069946; 284,0.874541781;
            285,-0.854647819; 286,-4.082136394; 287,-7.220020796; 288,-5.884373961;
            289,8.543993067; 290,8.543993067; 291,2.655293037; 292,-6.050005745; 293,
            6.546513201; 294,9.389747977; 295,6.546513202; 296,2.235037797; 297,6.368531676;
            298,7.755335762; 299,7.755335762; 300,2.101797043; 301,0.610331872; 302,
            0.497795072; 303,-4.985954469; 304,-7.669023658; 305,-7.692067385; 306,-8.927306102;
            307,-8.884523638; 308,-7.667847129; 309,-8.755922569; 310,-15.08609668;
            311,-11.5799748; 312,-14.18415221; 313,-9.981393829; 314,-8.814951099; 315,
            -5.988296893; 316,-5.038045778; 317,1.805868249; 318,-1.627149454; 319,-5.713441874;
            320,-9.376638763; 321,-16.9536642; 322,-18.46191898; 323,-6.613828488; 324,
            -4.17854971; 325,-1.993153256; 326,-6.159392554; 327,-5.650441148; 328,-9.857827863;
            329,-4.603227774; 330,-5.894468909; 331,-4.130382136; 332,-1.231614217;
            333,0; 334,0; 335,0; 336,0; 337,0; 338,0; 339,0; 340,0; 341,0; 342,0; 343,
            0; 344,0; 345,0; 346,4.57589E-13; 347,0.324930308; 348,4.171443367; 349,
            7.386419831; 350,10.624085; 351,13.89429084; 352,16.0353751; 353,16.3887344;
            354,17.28582211; 355,9.635959939; 356,12.44831303; 357,12.4827907; 358,14.07930661;
            359,18.5445484; 360,9.615613756; 361,9.937444046; 362,7.443430289; 363,9.511696169;
            364,10.76658307; 365,12.11814552; 366,4.409297334; 367,6.436308902; 368,
            2.506923034; 369,0.51941915; 370,5.405191696; 371,11.58835847; 372,8.784622664;
            373,3.741698266; 374,3.741698266; 375,3.741698266; 376,3.741698266; 377,
            3.741698266; 378,4.775370456; 379,6.89081058; 380,4.87671245; 381,2.811644975;
            382,-0.292641342; 383,-5.304798; 384,-6.216833082; 385,-2.41535046; 386,
            -15.65512214; 387,-17.08803827; 388,-21.83565488; 389,-15.81357266; 390,
            -14.06563098; 391,-12.70045477; 392,-11.39930533; 393,-7.78925633; 394,-7.624294883;
            395,-4.743801088; 396,-1.847186252; 397,0; 398,0; 399,0; 400,0; 401,0; 402,
            2.67029E-12; 403,2.010978954; 404,5.728007677; 405,8.952754472; 406,12.20496661;
            407,15.49449573; 408,18.83119389; 409,22.22491246; 410,20.04251654; 411,
            6.214729453; 412,16.8185521; 413,14.59833713; 414,10.98016173; 415,3.435426484;
            416,1.734800219; 417,0.028983707; 418,-0.823876327; 419,-1.654910703; 420,
            -4.020437795; 421,-19.18022902; 422,-18.6250916; 423,-15.90395297; 424,-13.12788379;
            425,-10.30673543; 426,-7.450359702; 427,-4.568608433; 428,-1.671333197;
            429,0; 430,0; 431,0; 432,0; 433,0; 434,0; 435,0; 436,0; 437,0; 438,0; 439,
            0; 440,0; 441,0; 442,0; 443,0; 444,0; 445,0; 446,0; 447,4.89925E-12; 448,
            3.200194369; 449,6.410240389; 450,9.639989941; 451,12.89929459; 452,16.19800598;
            453,19.54597616; 454,22.95305652; 455,26.42909869; 456,13.12884131; 457,
            13.02585526; 458,24.01710355; 459,16.98582574; 460,8.883891257; 461,15.1814732;
            462,6.495645135; 463,8.640431212; 464,8.820916562; 465,2.733113477; 466,
            4.775370456; 467,4.800557053; 468,1.724528462; 469,0.674892003; 470,6.76745286;
            471,3.741698266; 472,-0.335974304; 473,2.637167573; 474,2.618271221; 475,
            1.594598035; 476,3.566941843; 477,3.566941843; 478,3.566941843; 479,3.566941843;
            480,3.566941843; 481,1.563086101; 482,4.528904576; 483,4.553113637; 484,
            6.615474687; 485,0.608426021; 486,1.563086101; 487,3.524223192; 488,3.524223192;
            489,1.531957519; 490,1.501210757; 491,2.452540212; 492,-6.169527386; 493,
            -10.51952811; 494,-13.43035419; 495,-14.21835171; 496,-15.96234367; 497,
            -17.38428341; 498,-13.73732524; 499,-14.31168689; 500,-11.50845972; 501,
            -7.857888357; 502,-5.914173204; 503,-3.404266842; 504,-0.795719559; 505,
            0; 506,0; 507,0; 508,0; 509,0; 510,2.5503E-12; 511,0.457179488; 512,2.413794392;
            513,3.335360609; 514,2.124297628; 515,5.170959519; 516,3.428271735; 517,
            3.170009555; 518,5.276694851; 519,8.988259393; 520,9.867898699; 521,9.475031174;
            522,8.083119793; 523,7.464335702; 524,6.65736864; 525,7.633966206; 526,8.028253406;
            527,7.014636637; 528,6.572398214; 529,4.609369532; 530,2.532362225; 531,
            1.831956121; 532,1.831956121; 533,1.831956121; 534,1.831956121; 535,1.831956122;
            536,6.214729452; 537,3.384123323; 538,3.422663827; 539,-0.957429853; 540,
            -0.965866084; 541,0.431143758; 542,1.831956121; 543,1.831956121; 544,-2.346632981;
            545,-6.817007417; 546,-17.06565542; 547,-14.31168689; 548,-11.50845972;
            549,-8.665825846; 550,-5.793636748; 551,-2.90174422; 552,0; 553,0; 554,0;
            555,0; 556,0; 557,0; 558,0; 559,0; 560,0; 561,0; 562,0; 563,0; 564,0; 565,
            0; 566,0; 567,0; 568,8.95959E-12; 569,3.200194369; 570,6.410240389; 571,
            9.639989941; 572,11.97231592; 573,7.339731434; 574,7.17833896; 575,5.747512387;
            576,0.984750347; 577,0.984750347; 578,3.478927766; 579,2.036717573; 580,
            1.044942419; 581,0.046937528; 582,-1.39663062; 583,0.502865454; 584,-0.443822877;
            585,2.889855163; 586,1.472284985; 587,0.508474196; 588,-0.908892634; 589,
            0.480891466; 590,0.943159597; 591,1.416455943; 592,2.889855163; 593,3.994715778;
            594,5.781355304; 595,4.947435838; 596,6.939262993; 597,6.069027381; 598,
            1.963986656; 599,1.977391789; 600,3.847049661; 601,3.935821564; 602,4.025558433;
            603,2.157048719; 604,1.526683225; 605,1.526683225; 606,2.821567271; 607,
            8.307989819; 608,11.68993878; 609,8.521620753; 610,5.747558789; 611,5.88900271;
            612,-4.60142366; 613,-19.51822817; 614,-16.81758906; 615,-14.05873551; 616,
            -11.25151887; 617,-8.405790945; 618,-5.53140359; 619,-2.638208358; 620,0;
            621,0; 622,0; 623,0; 624,0; 625,0; 626,0; 627,0; 628,0; 629,0; 630,0; 631,
            0; 632,0; 633,0; 634,0; 635,0; 636,0; 637,0; 638,0; 639,0; 640,0; 641,0;
            642,0; 643,0; 644,0; 645,6.99602E-12; 646,1.210459708; 647,3.357240952;
            648,7.581896952; 649,7.363029504; 650,8.702935779; 651,6.634894622; 652,
            6.420321844; 653,11.81376128; 654,12.752064; 655,9.599074538; 656,8.9562538;
            657,8.800535288; 658,10.00438843; 659,7.541871176; 660,4.063081741; 661,
            4.879508686; 662,2.710816718; 663,2.72746367; 664,1.993438074; 665,3.500602336;
            666,2.777836743; 667,2.035406106; 668,-1.676293098; 669,-1.674057881; 670,
            -10.90648451; 671,-11.78521976; 672,-13.9140663; 673,-8.713817167; 674,-6.930713934;
            675,-8.834571475; 676,-6.649329531; 677,-4.444029625; 678,-2.096821389;
            679,-0.750677585; 680,0; 681,0; 682,0; 683,0; 684,0; 685,0; 686,0; 687,0;
            688,0; 689,0; 690,0; 691,0; 692,0; 693,5.58055E-12; 694,0.611854826; 695,
            1.905843762; 696,1.556655875; 697,4.127459248; 698,7.406257621; 699,7.219541316;
            700,9.036988353; 701,5.294545428; 702,9.205374339; 703,2.363272215; 704,
            0.018623437; 705,0.943159598; 706,9.757613801; 707,6.56117162; 708,6.338082562;
            709,9.848498576; 710,7.830338722; 711,1.526683225; 712,-0.99510789; 713,
            5.365442524; 714,5.536642551; 715,2.960689899; 716,-4.776972272; 717,-4.019912508;
            718,-5.007236666; 719,-11.53584973; 720,-11.78227588; 721,-9.470231203;
            722,-7.128579435; 723,-4.575453951; 724,-1.937829727; 725,-1.125331027;
            726,-0.435167407; 727,-0.201763184; 728,0.022366789; 729,2.565211789; 730,
            6.312726537; 731,8.807391157; 732,10.80415425; 733,6.634894622; 734,9.867898699;
            735,11.15731028; 736,10.00647183; 737,12.86024509; 738,11.95107628; 739,
            11.37718455; 740,9.042156622; 741,9.459711637; 742,6.676752664; 743,6.061181182;
            744,4.584981296; 745,5.472642767; 746,4.751697708; 747,2.347903781; 748,
            -0.077375731; 749,1.495734103; 750,0.686291747; 751,-1.672170762; 752,-3.17781995;
            753,-7.389372165; 754,-11.52370964; 755,-10.63137793; 756,-12.1446105; 757,
            -10.61354225; 758,-5.861573805; 759,-7.756609315; 760,-7.705596946; 761,
            -5.270256885; 762,-2.554159625; 763,-0.563128117; 764,0.067237436; 765,-0.117714446;
            766,-3.02466E-11; 767,2.656862299; 768,6.117751911; 769,9.345303105; 770,
            12.60151373; 771,13.723869; 772,9.362339697; 773,5.747002588; 774,7.220350745;
            775,8.290240589; 776,9.483038458; 777,9.4078126; 778,14.43926724; 779,13.17186432;
            780,9.88453098; 781,6.177476124; 782,4.679783058; 783,7.253326716; 784,2.395309621;
            785,2.395309621; 786,1.572560984; 787,-0.063130045; 788,0.715483978; 789,
            2.301203574; 790,2.301203574; 791,1.495734102; 792,-2.444551408; 793,1.409616266;
            794,2.180063152; 795,2.180063152; 796,2.180063152; 797,2.180063152; 798,
            2.180063152; 799,2.968187482; 800,5.393021113; 801,6.324574338; 802,15.18259872;
            803,11.43256662; 804,11.89346941; 805,12.36314504; 806,3.11778344; 807,8.883891256;
            808,7.126552589; 809,6.260587616; 810,2.399009027; 811,1.411238145; 812,
            3.316342959; 813,2.346321424; 814,0.411778186; 815,-1.49946105; 816,2.193247382;
            817,-1.530727012; 818,-1.55432898; 819,2.016088009; 820,0.198996594; 821,
            1.954309112; 822,-5.038045778; 823,-2.467636778; 824,1.720834662; 825,2.558520362;
            826,2.558520362; 827,2.558520361; 828,0.02086629; 829,1.665788421; 830,2.492267808;
            831,0.817875763; 832,-0.843368564; 833,-3.244614759; 834,-1.670359715; 835,
            -3.18826124; 836,-8.818200775; 837,-10.28359157; 838,-9.007684476; 839,-7.304568942;
            840,-5.810802993; 841,1.182052265; 842,6.338082562; 843,6.036126289; 844,
            4.402567715; 845,5.168536444; 846,5.337128444; 847,5.507951124; 848,7.084066219;
            849,8.836017784; 850,9.250043264; 851,6.520933274; 852,2.049540377; 853,
            3.57969881; 854,3.619686765; 855,3.65997079; 856,6.898027911; 857,4.632228023;
            858,8.027504176; 859,3.204979077; 860,3.223740919; 861,3.242581893; 862,
            1.598798576; 863,-4.814850385; 864,-2.442617648; 865,-1.675383887; 866,-6.735345035;
            867,-3.771293334; 868,-1.664378334; 869,3.890423459; 870,3.954652978; 871,
            4.755670789; 872,3.364959298; 873,5.663566385; 874,7.367841263; 875,6.80274378;
            876,4.561472974; 877,7.09066072; 878,7.286096684; 879,4.07957734; 880,1.612036302;
            881,1.598798576; 882,1.585639984; 883,-0.861593003; 884,-0.87856773; 885,
            1.470746583; 886,2.255201594; 887,-0.898054558; 888,-0.912280767; 889,-2.421852688;
            890,5.132564119; 891,6.032297066; 892,4.561472974; 893,3.824111265; 894,
            0.667214688; 895,3.824111266; 896,2.255201594; 897,2.255201594; 898,-0.118259616;
            899,-0.137672715; 900,-1.675803362; 901,-0.186156239; 902,1.292975637; 903,
            2.035406107; 904,2.035406106; 905,0.533700622; 906,1.259412314; 907,1.993438074;
            908,-0.224745869; 909,-0.240213842; 910,1.91143387; 911,4.128978795; 912,
            1.215665864; 913,-0.24522927; 914,-4.422451765; 915,-5.598273421; 916,-6.592763237;
            917,-2.204459751; 918,1.426445896; 919,2.045295364; 920,7.236630079; 921,
            6.876558219; 922,5.739286348; 923,3.085799867; 924,3.122138334; 925,5.306974167;
            926,3.251445092; 927,2.564180994; 928,2.580193864; 929,3.326842337; 930,
            -0.259856574; 931,0.431143758; 932,1.831956121; 933,1.831956121; 934,-0.282857679;
            935,0.394815764; 936,0.380756633; 937,1.742346251; 938,3.140407998; 939,
            5.333986952; 940,1.831956121; 941,-0.976453427; 942,1.780345303; 943,-1.658610637;
            944,4.513204115; 945,6.064276321; 946,5.497513441; 947,-1.671009479; 948,
            -5.691342471; 949,-10.85675687; 950,-9.429461277; 951,-14.17484623; 952,
            -11.85053979; 953,-9.01215768; 954,-6.143026386; 955,-3.252997453; 956,-0.351922676;
            957,0; 958,0; 959,1.33819E-11; 960,1.210459709; 961,5.143871183; 962,8.364682608;
            963,11.61116833; 964,14.89317987; 965,12.30404555; 966,6.857963144; 967,
            9.104510165; 968,7.875414701; 969,7.017608697; 970,8.028253407; 971,12.06358268;
            972,15.27024653; 973,11.42542458; 974,6.993997756; 975,4.703676541; 976,
            3.130722146; 977,2.332259009; 978,2.332259008; 979,-3.99850995; 980,0.639169552;
            981,-0.150238756; 982,-0.925313752; 983,-0.19188547; 984,-1.676293098; 985,
            -0.235128558; 986,-1.671875438; 987,-6.363732331; 988,-10.85675686; 989,
            -1.596138375; 990,1.415608141; 991,3.280561829; 992,5.939242101; 993,4.806385041;
            994,0.283655184; 995,1.56119606; 996,2.873264051; 997,-0.358276724; 998,
            1.549629644; 999,1.549629645; 1000,6.910980764; 1001,5.066896489; 1002,5.915543247;
            1003,3.195620605; 1004,3.954652978; 1005,4.755670789; 1006,2.62864988; 1007,
            1.183599341; 1008,-1.67007471; 1009,-4.359376875; 1010,-0.987800878; 1011,
            -1.641795109; 1012,-0.351891136; 1013,-0.99477903; 1014,-1.61139533; 1015,
            -0.99415787; 1016,-5.007236667; 1017,-13.68102342; 1018,-12.36253584; 1019,
            -9.530803003; 1020,-6.666529624; 1021,-3.779567525; 1022,-0.879768297; 1023,
            0; 1024,0; 1025,0; 1026,0; 1027,0; 1028,0; 1029,0; 1030,0; 1031,0; 1032,
            0; 1033,0; 1034,0; 1035,0; 1036,0; 1037,0; 1038,0; 1039,0; 1040,0; 1041,
            0; 1042,0; 1043,0; 1044,0; 1045,0; 1046,0; 1047,0; 1048,0; 1049,0; 1050,
            0; 1051,0; 1052,7.45565E-12; 1053,0.457179489; 1054,3.319632439; 1055,7.093359665;
            1056,10.32855526; 1057,13.5953957; 1058,15.74931251; 1059,8.891158636; 1060,
            9.664835174; 1061,12.44187462; 1062,9.317000781; 1063,8.428846089; 1064,
            7.364438044; 1065,7.649161314; 1066,8.717281001; 1067,4.330534154; 1068,
            6.77113378; 1069,6.148287894; 1070,5.472642766; 1071,-0.098163265; 1072,
            -1.672170762; 1073,-1.675383886; 1074,2.106809411; 1075,-3.150435814; 1076,
            -10.58755302; 1077,-11.08062791; 1078,-4.607884892; 1079,-3.873524458; 1080,
            -12.04014224; 1081,-11.78227588; 1082,-8.669090568; 1083,-3.172861505; 1084,
            -0.956389014; 1085,-1.188063542; 1086,-0.866737999; 1087,-0.578389324; 1088,
            -0.555795769; 1089,0.172732015; 1090,0.917777197; 1091,0.940099669; 1092,
            -0.312054445; 1093,0.172732015; 1094,-0.963609432; 1095,-1.632410642; 1096,
            -2.572302701; 1097,-0.750127771; 1098,-1.048395229; 1099,-0.403492108; 1100,
            -2.24303E-12; 1101,0.007273885; 1102,0.110891907; 1103,0.520002539; 1104,
            2.180301241; 1105,6.70289181; 1106,9.177947785; 1107,10.70928487; 1108,5.45821228;
            1109,2.818940023; 1110,7.626598967; 1111,11.72937477; 1112,11.90613496;
            1113,7.245709766; 1114,2.571336297; 1115,1.990855307; 1116,2.004376948;
            1117,3.261200495; 1118,6.569607736; 1119,4.806385042; 1120,7.014636637;
            1121,6.572398214; 1122,5.333986953; 1123,1.121346822; 1124,1.11121173; 1125,
            3.232768485; 1126,4.731114217; 1127,4.829761683; 1128,3.422663828; 1129,
            4.979860027; 1130,3.540004732; 1131,4.353293055; 1132,2.863248004; 1133,
            2.106809412; 1134,2.106809412; 1135,1.338744846; 1136,1.327192445; 1137,
            2.078027956; 1138,-0.19188547; 1139,1.281715469; 1140,-0.947870587; 1141,
            -1.67405788; 1142,-4.422451765; 1143,-5.598273421; 1144,-10.63137793; 1145,
            -7.144913072; 1146,-11.22960184; 1147,-5.821199626; 1148,-7.093066322; 1149,
            -9.358037796; 1150,-6.492108991; 1151,-3.604088396; 1152,-0.703827807; 1153,
            0; 1154,0; 1155,0; 1156,0; 1157,0; 1158,0; 1159,0; 1160,0; 1161,0; 1162,
            0; 1163,0; 1164,0; 1165,0; 1166,0; 1167,0; 1168,3.13906E-12; 1169,1.329856139;
            1170,5.241189342; 1171,8.462634102; 1172,11.71005147; 1173,14.99329342;
            1174,18.32221142; 1175,16.15141402; 1176,13.82761652; 1177,4.935835405;
            1178,-1.637351687; 1179,-1.625144524; 1180,-12.7481624; 1181,-14.48009544;
            1182,-11.67957319; 1183,-8.839047172; 1184,-5.96836885; 1185,-3.077390025;
            1186,-0.175962436; 1187,0; 1188,0; 1189,0; 1190,0; 1191,0; 1192,0; 1193,
            0; 1194,0; 1195,0; 1196,7.11805E-14; 1197,0.020151296; 1198,0.613554256;
            1199,2.119623784; 1200,5.766409694; 1201,9.541734229; 1202,8.011906864;
            1203,3.927683736; 1204,1.045979638; 1205,-0.757123043; 1206,1.385477852;
            1207,1.789613409; 1208,0.688574932; 1209,4.281529939; 1210,7.377113743;
            1211,8.128893355; 1212,9.463474083; 1213,7.301462315; 1214,9.010733279;
            1215,4.427354793; 1216,3.280561829; 1217,1.448299325; 1218,-0.391439742;
            1219,-0.39838598; 1220,3.222656159; 1221,3.280561829; 1222,2.703106683;
            1223,0.84575966; 1224,0.221437734; 1225,0.210909642; 1226,1.415608141; 1227,
            0.805281564; 1228,-6.050701855; 1229,-2.067035049; 1230,-0.431683638; 1231,
            3.417050595; 1232,2.349603763; 1233,2.380610942; 1234,-1.520718288; 1235,
            -8.778180258; 1236,-7.821700264; 1237,-8.423511865; 1238,-7.91196282; 1239,
            -4.101429081; 1240,-3.083747725; 1241,-2.059486996; 1242,-0.938089975; 1243,
            -0.32168353; 1244,-3.78303E-12; 1245,0; 1246,0; 1247,0; 1248,0; 1249,0;
            1250,0; 1251,0; 1252,0.324930308; 1253,0.044767844; 1254,0.044767844; 1255,
            0.044767844; 1256,0.044767844; 1257,0.340698567; 1258,1.312082452; 1259,
            1.302462656; 1260,1.630134324; 1261,2.587704792; 1262,4.191379999; 1263,
            6.096160618; 1264,1.993327234; 1265,-2.197509774; 1266,-1.973183435; 1267,
            -1.556366212; 1268,3.383206902; 1269,7.332688528; 1270,12.5183065; 1271,
            15.27303636; 1272,14.86878613; 1273,10.18741566; 1274,6.334332852; 1275,
            3.980568281; 1276,6.739506031; 1277,5.623101163; 1278,5.093304805; 1279,
            4.513204115; 1280,1.767611881; 1281,-1.65700286; 1282,-1.647982703; 1283,
            1.643926425; 1284,1.643926425; 1285,1.643926425; 1286,1.643926425; 1287,
            1.643926425; 1288,5.066896489; 1289,2.392538567; 1290,4.513204115; 1291,
            3.177148783; 1292,3.933174589; 1293,4.731114217; 1294,3.34586573; 1295,2.644941662;
            1296,4.151086338; 1297,3.461489267; 1298,8.158318824; 1299,8.45573126; 1300,
            6.265502477; 1301,8.098567764; 1302,3.242581894; 1303,1.598798577; 1304,
            -5.589347641; 1305,-21.04289661; 1306,-18.3802443; 1307,-15.65370497; 1308,
            -12.8731304; 1309,-10.04837256; 1310,-7.189282895; 1311,-4.305713201; 1312,
            -1.407515246; 1313,-6.35671E-11; 1314,0; 1315,0; 1316,0; 1317,0; 1318,0;
            1319,0; 1320,0; 1321,0; 1322,0; 1323,0; 1324,0; 1325,0; 1326,0; 1327,0;
            1328,0; 1329,0; 1330,0; 1331,0; 1332,0; 1333,0; 1334,0; 1335,0; 1336,0;
            1337,0; 1338,0.697602998; 1339,4.65749275; 1340,7.87527368; 1341,11.11723606;
            1342,7.352077671; 1343,8.870473291; 1344,8.96941633; 1345,8.78888414; 1346,
            7.766667629; 1347,5.839912393; 1348,7.361569846; 1349,5.140650299; 1350,
            2.719846498; 1351,3.397994564; 1352,-0.995037958; 1353,-0.994157869; 1354,
            -1.582870251; 1355,-2.135571384; 1356,-1.541663615; 1357,-0.975896978; 1358,
            -4.584656071; 1359,-3.875336982; 1360,-3.679521202; 1361,-3.479181935; 1362,
            -5.131929056; 1363,-8.692604712; 1364,-6.342728867; 1365,-3.840186021; 1366,
            -1.778577377; 1367,-2.41891E-10; 1368,0; 1369,0; 1370,0])
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=180,
            origin={-80,10})));
    equation
      connect(cycler.Charging,charger. on)                        annotation (
          Line(
          points={{9,4},{0,4},{0,10},{-31,10}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(charger.pin_p,idealCommutingSwitch. n1) annotation (Line(
          points={{-40,20},{-40,55},{-10,55}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(charger.pin_n,ground. p) annotation (Line(
          points={{-40,0},{-40,-40},{60,-40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(charger.v,cycler. vMax) annotation (Line(
          points={{-31,4},{-20,4},{-20,30},{20,30},{20,21}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(currentSensor.n,idealCommutingSwitch. p) annotation (Line(
          points={{30,60},{10,60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(batteryStack.pin_pStack, currentSensor.p)     annotation (Line(
          points={{60,19.4},{60,60},{50,60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(batteryStack.pin_nStack, ground.p)     annotation (Line(
          points={{60,0.6},{60,-40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(load.pin_p, idealCommutingSwitch.n2) annotation (Line(
          points={{-80,20},{-80,60},{-10,60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(load.pin_n, ground.p) annotation (Line(
          points={{-80,0},{-80,-40},{60,-40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(load.on, cycler.Discharging) annotation (Line(
          points={{-71,10},{-60,10},{-60,40},{0,40},{0,16},{9,16}},
          color={255,0,255},
          smooth=Smooth.None));

      connect(cycler.Discharging, idealCommutingSwitch.control) annotation (Line(
          points={{9,16},{0,16},{0,52}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(voltageSensor.p, batteryStack.pin_pStack)     annotation (Line(
          points={{90,20},{90,30},{60,30},{60,19.4}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(voltageSensor.n, batteryStack.pin_nStack)     annotation (Line(
          points={{90,0},{90,-10},{60,-10},{60,0.6}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(batteryStack.cellBus, cycler.singleCellBus[1, 1])     annotation (
          Line(
          points={{50.4,10},{29.6,10}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (experiment(StopTime=75000, Interval=1), Diagram(graphics));
    end SimpleStackCycling;

    model AdvancedStackCycling
      extends Modelica.Icons.Example;
      parameter
        CellRecords.LinearDynamicImpedance.LinearDynamicImpedanceParameters         cellParameters[:,:]=
        {{CellRecords.LinearDynamicImpedance.Test1Parameters(capacity=EnergyStorages.CellRecords.Components.ChargeCapacity(         C0=35*3600))},
         {CellRecords.LinearDynamicImpedance.Test1Parameters(capacity=EnergyStorages.CellRecords.Components.ChargeCapacity(         C0=40*3600))},
         {CellRecords.LinearDynamicImpedance.Test1Parameters(capacity=EnergyStorages.CellRecords.Components.ChargeCapacity(         C0=45*3600))}}
        annotation (Placement(transformation(extent={{50,-80},{70,-60}})));
      output Modelica.SIunits.Current Istack=currentSensor.i;
      output Modelica.SIunits.Current Icell[:,:]=cycler.singleCellBus.i;
      output Modelica.SIunits.Voltage Vstack=voltageSensor.v;
      output Modelica.SIunits.Voltage Vcell[:,:]=cycler.singleCellBus.v;
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(extent={{50,-60},{70,-40}},
              rotation=0)));
      Modelica.Electrical.Analog.Ideal.IdealCommutingSwitch
        idealCommutingSwitch annotation (Placement(transformation(
            origin={0,60},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Sources.Chargers.CCCV        charger(T=0.000001,
        ExternalControl=true,
        Vmax=4.2,
        Imax=40)                                   annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-40,10})));
      BatteryManagement.VoltageCycling cycler(
        delayAfterDischarging=100,
        Vmax=4.2,
        delayAfterCharging=500,
        Ifinal=2,
        Vmin=2.7,
        initialDischarging=false,
        ns=batteryStack.ns,
        np=batteryStack.np)
        annotation (Placement(transformation(extent={{30,0},{10,20}})));
      Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
          Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={90,10})));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=180,
            origin={40,60})));
      EnergyStorages.Batteries.Stacks.WithMeasurement.LinearDynamicImpedanceMatrix
        batteryStack(cellParameters=cellParameters)
        annotation (Placement(transformation(extent={{50,0},{70,20}})));
      Sources.Loads.BooleanConstantCurrent
                                 load(I=40)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=180,
            origin={-80,10})));
    equation
      connect(cycler.Charging,charger. on)                        annotation (
          Line(
          points={{9,4},{0,4},{0,10},{-31,10}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(charger.pin_p,idealCommutingSwitch. n1) annotation (Line(
          points={{-40,20},{-40,55},{-10,55}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(charger.pin_n,ground. p) annotation (Line(
          points={{-40,0},{-40,-40},{60,-40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(charger.v,cycler. vMax) annotation (Line(
          points={{-31,4},{-20,4},{-20,30},{20,30},{20,21}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(currentSensor.n,idealCommutingSwitch. p) annotation (Line(
          points={{30,60},{10,60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(batteryStack.pin_pStack,currentSensor. p)     annotation (Line(
          points={{60,19.4},{60,60},{50,60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(batteryStack.pin_nStack,ground. p)     annotation (Line(
          points={{60,0.6},{60,-40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(load.pin_p,idealCommutingSwitch. n2) annotation (Line(
          points={{-80,20},{-80,60},{-10,60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(load.pin_n,ground. p) annotation (Line(
          points={{-80,0},{-80,-40},{60,-40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(load.on,cycler. Discharging) annotation (Line(
          points={{-71,10},{-60,10},{-60,40},{0,40},{0,16},{9,16}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(cycler.Discharging,idealCommutingSwitch. control) annotation (Line(
          points={{9,16},{0,16},{0,52}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(voltageSensor.p,batteryStack. pin_pStack)     annotation (Line(
          points={{90,20},{90,30},{60,30},{60,19.4}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(voltageSensor.n,batteryStack. pin_nStack)     annotation (Line(
          points={{90,0},{90,-10},{60,-10},{60,0.6}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(batteryStack.cellBus, cycler.singleCellBus) annotation (Line(
          points={{50.4,10},{29.6,10}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (experiment(StopTime=20000, Interval=1));
    end AdvancedStackCycling;

  end Examples;

  package Batteries "Package for battery cells and battery stacks"
    //extends Modelica.Icons.Package;
    extends Modelica.Icons.Package;
    extends EnergyStorages.Icons.BatteriesPackage;

    package Cells "Package for battery cells"
     //extends Icons.SingleCell;
      package Basic "Package for battery cells without measurement"
         extends EnergyStorages.Icons.SinglePackage;
        model StaticResistance
          "Battery cell model with a static internal impedance"
          extends EnergyStorages.Icons.CellStaticResistance;
          parameter CellRecords.StaticResistance.StaticResistanceParameters
                                               cellParameters
            annotation (__Dymola_choicesAllMatching=true, Placement(transformation(extent={{-100,80},
                    {-80,100}})));
          extends EnergyStorages.Batteries.Components.OperationalParameters;
          parameter Real SOCini(start=0.5) "Initial state of charge"
            annotation (Dialog(group="Initialization"));
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
            "Negative pin"
            annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
                  rotation=0)));
          Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
            "Positive pin (potential p.v > n.v for positive voltage drop v)"
            annotation (Placement(transformation(extent={{-10,90},{10,110}},
                  rotation=0)));
          Modelica.Electrical.Analog.Sources.SignalVoltage OCV
            annotation (Placement(transformation(
                origin={0,-70},
                extent={{-10,10},{10,-10}},
                rotation=270)));
          Modelica.Electrical.Analog.Sensors.CurrentSensor IBatt
            annotation (Placement(transformation(
                origin={0,60},
                extent={{-10,10},{10,-10}},
                rotation=90)));

          Modelica.Blocks.Tables.CombiTable1D sococvTable(
            final smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
            final tableOnFile=cellParameters.SOCOCV.OCVtableOnFile,
            final table=cellParameters.SOCOCV.OCVtable,
            final tableName=cellParameters.SOCOCV.OCVtableName,
            final fileName=cellParameters.SOCOCV.OCVfileName)
                                annotation (Placement(transformation(extent={{-70,-80},
                    {-50,-60}},          rotation=0)));

          Modelica.Electrical.Analog.Basic.HeatingResistor  Rs(
            useHeatPort=true,
            final R_ref=cellParameters.Rs.R0,
            final T_ref=cellParameters.Rs.temperature.Tref,
            final alpha=cellParameters.Rs.temperature.alpha)
                         annotation (Placement(transformation(
                origin={0,0},
                extent={{-10,-10},{10,10}},
                rotation=90)));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort
          annotation (Placement(transformation(extent={{90,-10},{110,10}},
                  rotation=0), iconTransformation(extent={{44,-10},{64,10}})));

          Components.Calculators.CellCalculator calculator(
            final SOCini=SOCini,
            final Z0=cellParameters.Rs.R0,
            final capacity=cellParameters.capacity,
            final SoH=cellParameters.SoH)
                   annotation (Placement(transformation(
                origin={-70,58},
                extent={{-10,10},{10,-10}},
                rotation=180)));

        protected
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalHeatPort
            annotation (Placement(transformation(extent={{76,-4},{84,4}})));

        public
          Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
            fixedTemperature(                                                     final T=TOperational) if  not useHeatPort
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={80,-30})));
          Modelica.Blocks.Sources.Clock clock(final startTime=tini)
            annotation (Placement(transformation(extent={{-4,4},{4,-4}},
                  rotation=180,
                origin={-24,36})));
          Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temp annotation (
              Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=0,
                origin={70,80})));

          Modelica.Blocks.Sources.Constant const(final k=cellParameters.Rs.R0)
                                                         annotation (Placement(
                transformation(
                extent={{4,-4},{-4,4}},
                rotation=0,
                origin={-24,24})));
          final parameter Modelica.SIunits.Time tini(fixed=false)=0
            "Initial time";
        initial equation
          tini=time;

        equation
          connect(OCV.n, pin_n)
                            annotation (Line(points={{0,-80},{0,-100}},
                                                color={0,0,255}));
          connect(Rs.p, OCV.p)
            annotation (Line(points={{0,-10},{0,-10},{0,-60}},
                                             color={0,0,255}));
          connect(sococvTable.y[1], OCV.v)
            annotation (Line(points={{-49,-70},{-49,-70},{-7,-70}},
                                                          color={0,0,127}));
          connect(calculator.SOC, sococvTable.u[1])               annotation (Line(
                points={{-81,64},{-90,64},{-90,-70},{-72,-70}}, color={0,0,127}));
          connect(internalHeatPort, fixedTemperature.port) annotation (Line(
              points={{80,0},{80,-20}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Rs.heatPort, internalHeatPort)  annotation (Line(
              points={{10,0},{80,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(heatPort, internalHeatPort) annotation (Line(
              points={{100,0},{80,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(IBatt.p, Rs.n) annotation (Line(
              points={{0,50},{0,10}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(IBatt.n, pin_p) annotation (Line(
              points={{0,70},{0,100}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(IBatt.i, calculator.i)
                                        annotation (Line(
              points={{-10,60},{-61,60}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(clock.y, calculator.t) annotation (Line(
              points={{-28.4,36},{-40,36},{-40,56},{-61,56}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(internalHeatPort, temp.port) annotation (Line(
              points={{80,0},{80,80}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(calculator.T, temp.T) annotation (Line(
              points={{-61,64},{-40,64},{-40,80},{60,80}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(calculator.Z, const.y) annotation (Line(
              points={{-61,52},{-50,52},{-50,24},{-28.4,24}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (
            Diagram(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                initialScale=0.1), graphics),
            Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                initialScale=0.1), graphics={
                Line(points={{-54,-100},{54,-100},{48,-100}}, color={0,0,0})}));
        end StaticResistance;

        model LinearDynamicImpedance
          "Battery cell model with a linear dependant, dynamic internal impedance and basic aging behavior"
        extends EnergyStorages.Icons.CellLinearDynamicImpedance;
         parameter
            CellRecords.LinearDynamicImpedance.LinearDynamicImpedanceParameters
            cellParameters
            annotation (__Dymola_choicesAllMatching=true, Placement(transformation(extent={{-100,80},
                    {-80,100}})));
          extends EnergyStorages.Batteries.Components.OperationalParameters;
          parameter Real SOCini(start=0.5) "Initial state of charge"
            annotation (Dialog(group="Initialization"));
          final parameter Modelica.SIunits.Resistance Z0=sum(cellParameters.RC.Rd.R0);
          final parameter Modelica.SIunits.Time tini(fixed=false)=0
            "Initial time";
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
            "Negative pin"
            annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
                  rotation=0)));
          Modelica.Electrical.Analog.Sources.SignalVoltage Vo
            annotation (Placement(transformation(
                origin={0,-70},
                extent={{-10,10},{10,-10}},
                rotation=270)));
          Modelica.Electrical.Analog.Sensors.CurrentSensor IBatt_int
            annotation (Placement(transformation(
                origin={0,60},
                extent={{-10,10},{10,-10}},
                rotation=90)));
          Components.Calculators.CellCalculator
            calculator(
            final SOCini=SOCini,
            final capacity=cellParameters.capacity,
            final SoH=cellParameters.SoH,
            final Z0=Z0)
             annotation (Placement(transformation(
                  extent={{-60,48},{-80,68}}, rotation=0)));

          Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
            "Positive pin (potential p.v > n.v for positive voltage drop v)"
            annotation (Placement(transformation(extent={{-10,90},{10,110}},
                  rotation=0)));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort
            annotation (Placement(transformation(extent={{90,-10},{110,10}}),
                iconTransformation(extent={{44,-10},{64,10}})));

        protected
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalHeatPort
            annotation (Placement(transformation(extent={{76,-4},{84,4}})));

        public
          Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(final T=TOperational) if  not useHeatPort
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={80,-30})));
          Modelica.Blocks.Sources.Clock clock(final startTime=tini)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                  rotation=0,
                origin={-70,24})));
          Components.Impedances.CellImpedance cellImpedance(
            final Rs=cellParameters.Rs,
            final RC=cellParameters.RC)                     annotation (
              Placement(transformation(
                extent={{-20,10},{20,-10}},
                rotation=90,
                origin={0,0})));
          Components.SelfDischarge selfDischarge(final Isd=cellParameters.Isd)
            annotation (Placement(transformation(extent={{30,20},{50,40}})));
          Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temp annotation (
              Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=0,
                origin={70,80})));

          Modelica.Blocks.Tables.CombiTable1D sococvTable(smoothness=
                Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
            final tableOnFile=cellParameters.SOCOCV.OCVtableOnFile,
            final table=cellParameters.SOCOCV.OCVtable,
            final tableName=cellParameters.SOCOCV.OCVtableName,
            final fileName=cellParameters.SOCOCV.OCVfileName)
                                annotation (Placement(transformation(extent={{-70,-80},
                    {-50,-60}},          rotation=0)));
        initial equation
          tini=time;

        equation
          connect(Vo.n, pin_n)
                            annotation (Line(points={{0,-80},{0,-100}},
                                                color={0,0,255}));
          connect(pin_p, pin_p)
            annotation (Line(points={{0,100},{0,100}}, color={0,0,255}));
          connect(heatPort, internalHeatPort) annotation (Line(
              points={{100,0},{80,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(fixedTemperature.port, internalHeatPort) annotation (Line(
              points={{80,-20},{80,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(IBatt_int.n, pin_p) annotation (Line(
              points={{0,70},{0,100}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(calculator.i, IBatt_int.i)
                                           annotation (Line(
              points={{-61,60},{-10,60}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(cellImpedance.heatPort, internalHeatPort) annotation (Line(
              points={{10,0},{80,0}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(cellImpedance.i, IBatt_int.i) annotation (Line(
              points={{-9,14},{-20,14},{-20,60},{-10,60}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(cellImpedance.SOC, calculator.SOC) annotation (Line(
              points={{-9,0},{-90,0},{-90,64},{-81,64}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(clock.y, cellImpedance.t) annotation (Line(
              points={{-59,24},{-40,24},{-40,-14},{-9,-14}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(clock.y, selfDischarge.t) annotation (Line(
              points={{-59,24},{31,24}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(IBatt_int.i, selfDischarge.i) annotation (Line(
              points={{-10,60},{-20,60},{-20,36},{31,36}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(clock.y, calculator.t) annotation (Line(
              points={{-59,24},{-40,24},{-40,56},{-61,56}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(temp.port, internalHeatPort) annotation (Line(
              points={{80,80},{80,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(temp.T, calculator.T) annotation (Line(
              points={{60,80},{-40,80},{-40,64},{-61,64}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(cellImpedance.Z, calculator.Z) annotation (Line(
              points={{11,14},{20,14},{20,52},{-61,52}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(cellImpedance.pin_p, Vo.p) annotation (Line(
              points={{0,-20},{0,-60}},
              color={0,0,255},
              smooth=Smooth.None));

          connect(selfDischarge.pin_p, IBatt_int.n) annotation (Line(
              points={{40,40},{40,70},{0,70}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(IBatt_int.p, cellImpedance.pin_n) annotation (Line(
              points={{0,50},{0,20}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(selfDischarge.pin_n, Vo.p) annotation (Line(
              points={{40,20},{40,-60},{0,-60}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(sococvTable.y[1], Vo.v) annotation (Line(
              points={{-49,-70},{-7,-70}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(sococvTable.u[1], calculator.SOC) annotation (Line(
              points={{-72,-70},{-90,-70},{-90,64},{-81,64}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (    Diagram(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                initialScale=0.1), graphics),
            Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                initialScale=0.1), graphics={
                Line(points={{-54,-100},{54,-100},{48,-100}}, color={0,0,0})}));
        end LinearDynamicImpedance;

        annotation (Icon(graphics));
      end Basic;

      package WithMeasurement
        "Package for battery cells with basic cell measurement"
       extends EnergyStorages.Icons.MeasurementPackage;

        model StaticResistance
          "Battery cell model with a static internal impedance and with basic cell measurement"
          extends EnergyStorages.Icons.CellStaticResistance;
          parameter CellRecords.StaticResistance.StaticResistanceParameters
                                               cellParameters
            annotation (__Dymola_choicesAllMatching=true, Placement(transformation(extent={{-100,80},
                    {-80,100}})));
          extends EnergyStorages.Batteries.Components.OperationalParameters;
          parameter Real SOCini(start=0.5) "Initial state of charge"
            annotation (Dialog(group="Initialization"));
          Sensors.CellMeasurement cellMeasurement
            annotation (Placement(transformation(
                origin={0,0},
                extent={{-20,20},{20,-20}},
                rotation=180)));
          Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
            annotation (Placement(transformation(extent={{-10,90},{10,110}},
                  rotation=0)));
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
            "negative pin"
            annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
                  rotation=0)));
          EnergyStorages.Interfaces.SingleCellBus.Bus singleCellBus
            annotation (Placement(transformation(
                origin={-60,0},
                extent={{-10,-10},{10,10}},
                rotation=90), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=270,
                origin={-52,0})));
        protected
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalHeatPort
            annotation (Placement(transformation(extent={{76,-4},{84,4}})));
        public
          Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
            fixedTemperature(final T=TOperational) if  not useHeatPort
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={80,-50})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort
          annotation (Placement(transformation(extent={{86,-10},{106,10}},
                  rotation=0), iconTransformation(extent={{44,-10},{64,10}})));
          EnergyStorages.Batteries.Cells.Basic.StaticResistance staticResistance(
            final cellParameters=cellParameters,
            final useHeatPort=true,
            final TOperational=TOperational,
            final SOCini=SOCini)
            annotation (Placement(transformation(extent={{40,-20},{80,20}})));
        equation
          connect(cellMeasurement.pin_p, pin_p) annotation (Line(points={{0,20},{
                  0,50},{0,100}},                                       color={
                  0,0,255}));
          connect(cellMeasurement.pin_n, pin_n) annotation (Line(points={{0,-20},
                  {0,-50},{0,-100}},                                      color=
                 {0,0,255}));
          connect(cellMeasurement.T, singleCellBus.T)
                                                annotation (
            Text(
              string="%second",
              index=1,
              extent=[6,3; 6,3],
              style(color=0, rgbcolor={0,0,0})), Line(points={{-22,0},{-40,0},{
                  -60,0}},                                              color={
                  0,0,127}));
          connect(internalHeatPort, fixedTemperature.port) annotation (Line(
              points={{80,0},{80,-40}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(cellMeasurement.i, singleCellBus.i) annotation (Line(
              points={{-22,12},{-60,12},{-60,0}},
              color={0,0,127},
              smooth=Smooth.None), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(cellMeasurement.v, singleCellBus.v) annotation (Line(
              points={{-22,-12},{-60,-12},{-60,0}},
              color={0,0,127},
              smooth=Smooth.None), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(internalHeatPort, heatPort) annotation (Line(
              points={{80,0},{96,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(staticResistance.heatPort, internalHeatPort) annotation (Line(
              points={{70.8,0},{80,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(cellMeasurement.heatPort, internalHeatPort) annotation (Line(
              points={{20,0},{30,0},{30,-32},{80,-32},{80,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(cellMeasurement.pinCell_p, staticResistance.pin_p) annotation (Line(
              points={{20,12},{40,12},{40,26},{60,26},{60,20}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(cellMeasurement.pinCell_n, staticResistance.pin_n) annotation (Line(
              points={{20,-12},{40,-12},{40,-26},{60,-26},{60,-20}},
              color={0,0,255},
              smooth=Smooth.None));
          annotation (Diagram(graphics),
                               Icon(graphics={
                Line(points={{-54,-100},{-54,-100},{-20,-100},{-20,-100},{20,
                      -100},{20,-100},{54,-100},{54,-100}}, color={0,0,0})}));
        end StaticResistance;

        model LinearDynamicImpedance
          "Battery cell model with a linear dependant, dynamic internal impedance and with basic cell measurement"
        extends EnergyStorages.Icons.CellLinearDynamicImpedance;
          parameter
            CellRecords.LinearDynamicImpedance.LinearDynamicImpedanceParameters
            cellParameters
            annotation (__Dymola_choicesAllMatching=true, Placement(transformation(extent={{-100,80},{-80,100}})));
          extends EnergyStorages.Batteries.Components.OperationalParameters;
          parameter Real SOCini(start=0.5) "Initial state of charge"
            annotation (Dialog(group="Initialization"));
          final parameter Modelica.SIunits.Time tini(fixed=false)=0
            "Initial time";
          EnergyStorages.Sensors.CellMeasurement cellMeasurement
                            annotation (Placement(transformation(extent={{20,-20},
                    {-20,20}},      rotation=0)));
          Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
            annotation (Placement(transformation(extent={{-10,90},{10,110}},
                  rotation=0)));
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
            "negative pin"
            annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
                  rotation=0)));

          EnergyStorages.Interfaces.SingleCellBus.Bus singleCellBus
            annotation (Placement(transformation(
                origin={-60,0},
                extent={{-10,-10},{10,10}},
                rotation=90), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=270,
                origin={-52,0})));

        protected
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalHeatPort
            annotation (Placement(transformation(extent={{76,-4},{84,4}})));

        public
          Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
            fixedTemperature(final T=TOperational) if  not useHeatPort
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={80,-50})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort
          annotation (Placement(transformation(extent={{86,-10},{106,10}},
                  rotation=0), iconTransformation(extent={{44,-10},{64,10}})));
          EnergyStorages.Batteries.Cells.Basic.LinearDynamicImpedance linearDynamicImpedance(
            final cellParameters=cellParameters,
            TOperational=TOperational,
            final useHeatPort=true,
            final SOCini=SOCini)
            annotation (Placement(transformation(extent={{40,-20},{80,20}})));
        initial equation
          tini=time;

        equation
          connect(cellMeasurement.pin_p, pin_p) annotation (Line(points={{0,20},{
                  0,100}},  color={0,0,255}));
          connect(cellMeasurement.pin_n, pin_n) annotation (Line(points={{0,-20},
                  {0,-58},{0,-100}},
                             color={0,0,255}));
          connect(cellMeasurement.T, singleCellBus.T)
                                                annotation (
            Text(
              string="%second",
              index=1,
              extent=[6,3; 6,3],
              style(color=0, rgbcolor={0,0,0})), Line(points={{-22,0},{-22,0},{
                  -60,0}},
                color={0,0,127}));
          connect(fixedTemperature.port, internalHeatPort) annotation (Line(
              points={{80,-40},{80,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(cellMeasurement.v, singleCellBus.v) annotation (Line(
              points={{-22,-12},{-60,-12},{-60,0}},
              color={0,0,127},
              smooth=Smooth.None), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(cellMeasurement.i, singleCellBus.i) annotation (Line(
              points={{-22,12},{-60,12},{-60,0}},
              color={0,0,127},
              smooth=Smooth.None), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(internalHeatPort, heatPort) annotation (Line(
              points={{80,0},{96,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(linearDynamicImpedance.pin_p, cellMeasurement.pinCell_p) annotation (
              Line(
              points={{60,20},{60,26},{40,26},{40,12},{20,12}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(cellMeasurement.pinCell_n, linearDynamicImpedance.pin_n) annotation (
              Line(
              points={{20,-12},{40,-12},{40,-26},{60,-26},{60,-20}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(linearDynamicImpedance.heatPort, internalHeatPort) annotation (Line(
              points={{70.8,0},{80,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(cellMeasurement.heatPort, internalHeatPort) annotation (Line(
              points={{20,0},{30,0},{30,-32},{80,-32},{80,0}},
              color={191,0,0},
              smooth=Smooth.None));
          annotation (Diagram(graphics),
                               Icon(graphics));
        end LinearDynamicImpedance;
      end WithMeasurement;

    annotation (Icon(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={
            Line(
              points={{-80,-80},{-80,40},{-60,40},{-60,60},{-20,60},{-20,40},{20,40},
                  {20,60},{60,60},{60,40},{80,40},{80,-80},{-80,-80}},
              color={0,0,0},
              smooth=Smooth.None),
            Text(
              extent={{-40,0},{20,-60}},
              lineColor={0,0,0},
              textString="+"),
            Text(
              extent={{20,-8},{80,-68}},
              lineColor={0,0,0},
              textString="-")}));
    end Cells;

    package Stacks "Package for battery stacks"
     extends EnergyStorages.Icons.StackPackage;

      package Basic "Package for battery stacks without measurement"
      extends EnergyStorages.Icons.SinglePackage;
       model StaticResistanceScaled
          "Battery stack model with a static internal impedance"
         extends EnergyStorages.Icons.StackStaticResistance;
         parameter Integer ns(min=1) "number of serial connected cells";
         parameter Integer np(min=1) "number of parallel connected cells";
         parameter CellRecords.StaticResistance.StaticResistanceParameters
                                              cellParameters
           annotation (__Dymola_choicesAllMatching=true, Placement(transformation(extent={{-100,80},
                    {-80,100}})));
         extends EnergyStorages.Batteries.Components.OperationalParameters;
         parameter Real SOCini(start=0.5) "Initial state of charge"
           annotation (Dialog(group="Initialization"));
         Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "Negative pin"
           annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
                 rotation=0), iconTransformation(extent={{-10,-104},{10,-84}})));
         Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
            "Positive pin (potential p.v > n.v for positive voltage drop v)"
           annotation (Placement(transformation(extent={{-10,90},{10,110}},
                 rotation=0), iconTransformation(extent={{-10,84},{10,104}})));
         Modelica.Electrical.Analog.Sources.SignalVoltage Uo
           annotation (Placement(transformation(
               origin={0,-70},
               extent={{-10,10},{10,-10}},
               rotation=270)));
         Modelica.Electrical.Analog.Sensors.CurrentSensor IBatt
           annotation (Placement(transformation(
               origin={0,60},
               extent={{10,-10},{-10,10}},
               rotation=270)));

         Modelica.Electrical.Analog.Basic.HeatingResistor Rs(
           useHeatPort=true,
            final R_ref=cellParameters.Rs.R0*ns/np,
            final T_ref=cellParameters.Rs.temperature.Tref,
            final alpha=cellParameters.Rs.temperature.alpha)
                        annotation (Placement(transformation(
               origin={0,0},
               extent={{-10,-10},{10,10}},
               rotation=90)));
         Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort
         annotation (Placement(transformation(extent={{90,-10},{110,10}},
                 rotation=0), iconTransformation(extent={{84,-10},{104,10}})));

         Modelica.Blocks.Math.Gain gain(final k=ns)
                                              annotation (Placement(
               transformation(extent={{-40,-80},{-20,-60}}, rotation=0)));
         Modelica.Blocks.Math.Gain gain1(final k=1/np)
           annotation (Placement(transformation(
               origin={-30,60},
               extent={{-10,-10},{10,10}},
               rotation=180)));
        protected
         Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalHeatPort
           annotation (Placement(transformation(extent={{76,-4},{84,4}})));

        public
         Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
           fixedTemperature(final T=TOperational) if not useHeatPort
           annotation (Placement(transformation(
               extent={{-10,-10},{10,10}},
               rotation=90,
               origin={80,-30})));

         Modelica.Blocks.Sources.Clock clock(final startTime=tini)
           annotation (Placement(transformation(extent={{-4,4},{4,-4}},
                 rotation=180,
               origin={-24,36})));
         Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temp annotation (
             Placement(transformation(
               extent={{10,-10},{-10,10}},
               rotation=0,
               origin={70,80})));
         Modelica.Blocks.Sources.Constant const(final k=cellParameters.Rs.R0)
                                                        annotation (Placement(
               transformation(
               extent={{4,-4},{-4,4}},
               rotation=0,
               origin={-24,24})));
         Components.Calculators.CellCalculator cellCalculator(
           final SOCini=SOCini,
            final Z0=cellParameters.Rs.R0,
            final capacity=cellParameters.capacity,
            final SoH=cellParameters.SoH)                     annotation (Placement(
               transformation(
               extent={{-10,10},{10,-10}},
               rotation=180,
               origin={-70,58})));
         Modelica.Blocks.Tables.CombiTable1D sococvTable(
           final smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
            final tableOnFile=cellParameters.SOCOCV.OCVtableOnFile,
            final table=cellParameters.SOCOCV.OCVtable,
            final tableName=cellParameters.SOCOCV.OCVtableName,
            final fileName=cellParameters.SOCOCV.OCVfileName)
                               annotation (Placement(transformation(extent={{-70,-80},
                    {-50,-60}},         rotation=0)));
         final parameter Modelica.SIunits.Time tini(fixed=false)=0
            "Initial time";
       initial equation
         tini=time;

       equation
         connect(Uo.n, pin_n)
                           annotation (Line(points={{0,-80},{0,-100}},
                                               color={0,0,255}));
         connect(Rs.p, Uo.p)
           annotation (Line(points={{0,-10},{0,-35},{0,-60}},
                                            color={0,0,255}));
         connect(gain.y, Uo.v) annotation (Line(points={{-19,-70},{-7,-70}},
               color={0,0,127}));
         connect(gain1.u, IBatt.i)
           annotation (Line(points={{-18,60},{-10,60}}, color={0,0,127}));
         connect(Rs.heatPort, internalHeatPort) annotation (Line(
             points={{10,0},{80,0}},
             color={191,0,0},
             smooth=Smooth.None));
         connect(internalHeatPort, fixedTemperature.port) annotation (Line(
             points={{80,0},{80,-20}},
             color={191,0,0},
             smooth=Smooth.None));
         connect(internalHeatPort, heatPort) annotation (Line(
             points={{80,0},{100,0}},
             color={191,0,0},
             smooth=Smooth.None));
         connect(internalHeatPort,temp. port) annotation (Line(
             points={{80,0},{80,80}},
             color={191,0,0},
             smooth=Smooth.None));
         connect(cellCalculator.i, gain1.y) annotation (Line(
             points={{-61,60},{-41,60}},
             color={0,0,127},
             smooth=Smooth.None));
         connect(cellCalculator.T, temp.T) annotation (Line(
             points={{-61,64},{-40,64},{-40,80},{60,80}},
             color={0,0,127},
             smooth=Smooth.None));
         connect(cellCalculator.t, clock.y) annotation (Line(
             points={{-61,56},{-40,56},{-40,36},{-28.4,36}},
             color={0,0,127},
             smooth=Smooth.None));
         connect(const.y, cellCalculator.Z) annotation (Line(
             points={{-28.4,24},{-50,24},{-50,52},{-61,52}},
             color={0,0,127},
             smooth=Smooth.None));
         connect(IBatt.p, Rs.n) annotation (Line(
             points={{0,50},{0,10}},
             color={0,0,255},
             smooth=Smooth.None));
         connect(IBatt.n, pin_p) annotation (Line(
             points={{0,70},{0,100}},
             color={0,0,255},
             smooth=Smooth.None));
          connect(sococvTable.y[1], gain.u) annotation (Line(
              points={{-49,-70},{-42,-70}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(sococvTable.u[1], cellCalculator.SOC) annotation (Line(
              points={{-72,-70},{-90,-70},{-90,64},{-81,64}},
              color={0,0,127},
              smooth=Smooth.None));
           annotation (
           Diagram(coordinateSystem(
               preserveAspectRatio=true,
               extent={{-100,-100},{100,100}},
               initialScale=0.1), graphics),
           Icon(coordinateSystem(
               preserveAspectRatio=true,
               extent={{-100,-100},{100,100}},
               initialScale=0.1), graphics));
       end StaticResistanceScaled;

       model LinearDynamicImpedanceMatrix
          "Array of ns times np LinearDynamicImpedance cells with independent parameters"
         extends EnergyStorages.Icons.StackLinearDynamicImpedance;
         final parameter Integer ns(min=1)=size(cellParameters,1)
            "Number of serial connected cells";
         final parameter Integer np(min=1)=size(cellParameters,2)
            "Number of parallel connected cells";
         parameter Boolean useCellTerminals = true
            "Enable/disable single cell terminals";
         parameter
            CellRecords.LinearDynamicImpedance.LinearDynamicImpedanceParameters
            cellParameters[:,:]
           annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
         extends EnergyStorages.Batteries.Components.OperationalParameters;
         parameter Real SOCini[ns,np](start=fill(0.5,ns,np))
            "Initial state of charge"
           annotation (Dialog(group="Initialization"));
         Modelica.Electrical.Analog.Interfaces.PositivePin pin_pStack
            "Positive pin (potential p.v > n.v for positive voltage drop v)"
           annotation (Placement(transformation(extent={{-10,90},{10,110}},
                 rotation=0), iconTransformation(extent={{-10,84},{10,104}})));
         Modelica.Electrical.Analog.Interfaces.NegativePin pin_nStack
            "Negative pin"
           annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
                 rotation=0), iconTransformation(extent={{-10,-104},{10,-84}})));
         Modelica.Electrical.Analog.Interfaces.PositivePin pin_pCell[ns] if useCellTerminals
            "Positive pin (potential p.v > n.v for positive voltage drop v)"
           annotation (Placement(transformation(extent={{-110,50},{-90,70}},
                 rotation=0), iconTransformation(extent={{-104,50},{-84,70}})));
         Modelica.Electrical.Analog.Interfaces.NegativePin pin_nCell[ns] if useCellTerminals
            "Negative pin"
           annotation (Placement(transformation(extent={{-110,-70},{-90,-50}},
                 rotation=0), iconTransformation(extent={{-104,-70},{-84,-50}})));

         Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort[ns,np] if useHeatPort
           annotation (Placement(transformation(extent={{90,-10},{110,10}},
                 rotation=0), iconTransformation(extent={{84,-10},{104,10}})));
        protected
         Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalHeatPort[ns,np]
           annotation (Placement(transformation(extent={{76,-4},{84,4}})));

        public
         Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
           fixedTemperature[ns,np](final T=
               fill(
               TOperational,
               ns,
               np)) if not useHeatPort
         annotation (Placement(transformation(
               extent={{-10,-10},{10,10}},
               rotation=90,
               origin={80,-50})));

         EnergyStorages.Batteries.Cells.Basic.LinearDynamicImpedance cell[ns,np](
            final useHeatPort=fill(
                       true,
                       ns,
                       np),
            final TOperational=fill(
                       TOperational,
                       ns,
                       np),
            final SOCini=SOCini,
            final cellParameters=cellParameters)
           annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
       equation
         //series connection

         for s in 1:ns-1 loop
             connect(cell[s,1].pin_n,cell[s+1,1].pin_p);
         end for;

       //parallel connection
         for p in 1:np-1 loop
           for s in 1:ns loop
             connect(cell[s,p].pin_p,cell[s,p+1].pin_p);
             connect(cell[s,p].pin_n,cell[s,p+1].pin_n);
           end for;
         end for;

       //connector connection
         for s in 1:ns loop
             connect(cell[s,1].pin_p,pin_pCell[s]);
             connect(cell[s,1].pin_n,pin_nCell[s]);
         end for;

       //top connection
         connect(cell[1, 1].pin_p, pin_pStack);

       //bottom connection
         connect(cell[ns, np].pin_n, pin_nStack);
       //heatPort connection

         connect(internalHeatPort, heatPort) annotation (Line(
             points={{80,0},{100,0}},
             color={191,0,0},
             smooth=Smooth.None));
         connect(internalHeatPort, fixedTemperature.port) annotation (Line(
             points={{80,0},{80,-40}},
             color={191,0,0},
             smooth=Smooth.None));
         connect(cell.heatPort, internalHeatPort) annotation (Line(
             points={{10.8,0},{80,0}},
             color={191,0,0},
             smooth=Smooth.None));
         annotation (Diagram(graphics),
                              Icon(graphics));
       end LinearDynamicImpedanceMatrix;

      end Basic;

      package WithMeasurement "Package for single battery stacks"
       extends EnergyStorages.Icons.MeasurementPackage;
        model StaticResistanceScaled
          "Battery stack model with a static internal impedance and with basic cell measurement"
          extends EnergyStorages.Icons.StackStaticResistance;
          parameter Integer ns(min=1) "number of serial connected cells";
          parameter Integer np(min=1) "number of parallel connected cells";
          parameter CellRecords.StaticResistance.StaticResistanceParameters
                                               cellParameters
            annotation (__Dymola_choicesAllMatching=true, Placement(transformation(extent={{-100,80},{-80,100}})));
          extends EnergyStorages.Batteries.Components.OperationalParameters;
          parameter Real SOCini(start=0.5) "Initial state of charge"
            annotation (Dialog(group="Initialization"));
          Modelica.Electrical.Analog.Interfaces.PositivePin pin_pStack
            "Positive pin (potential p.v > n.v for positive voltage drop v)"
            annotation (Placement(transformation(extent={{-10,90},{10,110}},
                  rotation=0), iconTransformation(extent={{-10,84},{10,104}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_nStack
            "Negative pin"
            annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
                  rotation=0), iconTransformation(extent={{-10,-104},{10,-84}})));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort
            annotation (Placement(transformation(extent={{90,-10},{110,10}},
                  rotation=0), iconTransformation(extent={{84,-10},{104,10}})));

          EnergyStorages.Interfaces.SingleCellBus.Bus cellBus
            annotation (Placement(transformation(
                origin={-86,0},
                extent={{-20,-20},{20,20}},
                rotation=90), iconTransformation(
                extent={{-18,-18},{18,18}},
                rotation=90,
                origin={-96,0})));

        protected
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalHeatPort
            annotation (Placement(transformation(extent={{76,-4},{84,4}})));

        public
          Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
            fixedTemperature(final T=TOperational) if  not useHeatPort
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={80,-50})));

          EnergyStorages.Sensors.CellMeasurement cellMeasurement
                            annotation (Placement(transformation(extent={{0,-20},
                    {-40,20}},      rotation=0)));
          Modelica.Blocks.Math.Gain gainCurrent(final k=1/np)
            annotation (Placement(transformation(
                origin={-70,40},
                extent={{-10,-10},{10,10}},
                rotation=180)));
          Modelica.Blocks.Math.Gain gainVoltage(final k=1/ns)
            annotation (Placement(
                transformation(extent={{-10,-10},{10,10}},   rotation=180,
                origin={-70,-40})));
          EnergyStorages.Batteries.Stacks.Basic.StaticResistanceScaled staticResistance(
            final ns=ns,
            final np=np,
            final useHeatPort=true,
            final TOperational=TOperational,
            final SOCini=SOCini,
            final cellParameters=cellParameters)
            annotation (Placement(transformation(extent={{20,-20},{60,20}})));
        equation
          connect(internalHeatPort, internalHeatPort) annotation (Line(
              points={{80,0},{80,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(pin_pStack, cellMeasurement.pin_p)   annotation (Line(
              points={{0,100},{0,80},{-20,80},{-20,20}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(cellMeasurement.pin_n, pin_nStack)   annotation (Line(
              points={{-20,-20},{-20,-80},{0,-80},{0,-100}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(cellMeasurement.T, cellBus.T) annotation (Line(
              points={{-42,0},{-86,0}},
              color={0,0,127},
              smooth=Smooth.None), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(internalHeatPort, fixedTemperature.port) annotation (Line(
              points={{80,0},{80,-40}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(internalHeatPort, heatPort) annotation (Line(
              points={{80,0},{100,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(cellMeasurement.heatPort, internalHeatPort) annotation (Line(
              points={{0,0},{8,0},{8,60},{80,60},{80,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(gainCurrent.y, cellBus.i) annotation (Line(
              points={{-81,40},{-86,40},{-86,0}},
              color={0,0,127},
              smooth=Smooth.None), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(gainVoltage.y, cellBus.v) annotation (Line(
              points={{-81,-40},{-86,-40},{-86,0}},
              color={0,0,127},
              smooth=Smooth.None), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(gainVoltage.u, cellMeasurement.v) annotation (Line(
              points={{-58,-40},{-48,-40},{-48,-12},{-42,-12}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(cellMeasurement.i, gainCurrent.u) annotation (Line(
              points={{-42,12},{-50,12},{-50,40},{-58,40}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(cellMeasurement.pinCell_p, staticResistance.pin_p)
            annotation (Line(
              points={{0,12},{14,12},{14,32},{40,32},{40,18.8}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(cellMeasurement.pinCell_n, staticResistance.pin_n)
            annotation (Line(
              points={{0,-12},{10,-12},{10,-30},{40,-30},{40,-18.8}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(staticResistance.heatPort, internalHeatPort) annotation (Line(
              points={{58.8,0},{80,0}},
              color={191,0,0},
              smooth=Smooth.None));
          annotation (Diagram(graphics),
                               Icon(graphics));
        end StaticResistanceScaled;

        model LinearDynamicImpedanceMatrix
          "Array of ns times np LinearDynamicImpedance cells with independent parameters and with basic cell measurement"
          extends EnergyStorages.Icons.StackLinearDynamicImpedance;
          final parameter Integer ns(min=1)=size(cellParameters,1)
            "Number of serial connected cells";
          final parameter Integer np(min=1)=size(cellParameters,2)
            "Number of parallel connected cells";
          parameter Boolean useCellTerminals = true
            "Enable/disable single cell terminals";
          parameter
            CellRecords.LinearDynamicImpedance.LinearDynamicImpedanceParameters
             cellParameters[:,:]
            annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
          extends EnergyStorages.Batteries.Components.OperationalParameters;
          parameter Real SOCini[ns,np](start=fill(0.5,ns,np))
            "Initial state of charge"
            annotation (Dialog(group="Initialization"));
          Modelica.Electrical.Analog.Interfaces.PositivePin pin_pStack
            "Positive pin (potential p.v > n.v for positive voltage drop v)"
            annotation (Placement(transformation(extent={{-10,90},{10,110}},
                  rotation=0), iconTransformation(extent={{-10,84},{10,104}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_nStack
            "Negative pin"
            annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
                  rotation=0), iconTransformation(extent={{-10,-104},{10,-84}})));
          Modelica.Electrical.Analog.Interfaces.PositivePin pin_pCell[ns] if useCellTerminals
            "Positive pin (potential p.v > n.v for positive voltage drop v)"
            annotation (Placement(transformation(extent={{-110,50},{-90,70}},
                  rotation=0), iconTransformation(extent={{-104,50},{-84,70}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_nCell[ns] if useCellTerminals
            "Negative pin"
            annotation (Placement(transformation(extent={{-110,-70},{-90,-50}},
                  rotation=0), iconTransformation(extent={{-104,-70},{-84,-50}})));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort[ns,np] if useHeatPort
            annotation (Placement(transformation(extent={{90,-10},{110,10}},
                  rotation=0), iconTransformation(extent={{84,-10},{104,10}})));

          EnergyStorages.Interfaces.SingleCellBus.Bus cellBus[ns,np]
            annotation (Placement(transformation(
                origin={-80,0},
                extent={{-20,-20},{20,20}},
                rotation=90), iconTransformation(
                extent={{-18,-18},{18,18}},
                rotation=90,
                origin={-96,0})));

        protected
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalHeatPort[ns,np]
            annotation (Placement(transformation(extent={{76,-4},{84,4}})));

        public
          Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
            fixedTemperature[                                                     ns,np](final T=
                fill(
                TOperational,
                ns,
                np)) if                                                                                     not useHeatPort
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={80,-50})));

          Cells.WithMeasurement.LinearDynamicImpedance cell[ns,np](
            final useHeatPort=fill(
                true,
                ns,
                np),
            final TOperational=fill(
                TOperational,
                ns,
                np),
            final SOCini=SOCini,
            final cellParameters=cellParameters)
            annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
        equation
         //series connection

          for s in 1:ns-1 loop
              connect(cell[s,1].pin_n,cell[s+1,1].pin_p);
          end for;

        //parallel connection
          for p in 1:np-1 loop
            for s in 1:ns loop
              connect(cell[s,p].pin_p,cell[s,p+1].pin_p);
              connect(cell[s,p].pin_n,cell[s,p+1].pin_n);
            end for;
          end for;

        //connector connection
          for s in 1:ns loop
              connect(cell[s,1].pin_p,pin_pCell[s]);
              connect(cell[s,1].pin_n,pin_nCell[s]);
          end for;

        //top connection
          connect(cell[1, 1].pin_p, pin_pStack);

        //bottom connection
          connect(cell[ns, np].pin_n, pin_nStack);
        //heatPort connection

          connect(internalHeatPort, heatPort) annotation (Line(
              points={{80,0},{100,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(internalHeatPort, fixedTemperature.port) annotation (Line(
              points={{80,0},{80,-40}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(cell.singleCellBus, cellBus) annotation (Line(
              points={{-10.4,0},{-80,0}},
              color={255,204,51},
              thickness=0.5,
              smooth=Smooth.None), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(cell.heatPort, internalHeatPort) annotation (Line(
              points={{10.8,0},{80,0}},
              color={191,0,0},
              smooth=Smooth.None));
        //bus connection

          annotation (Diagram(graphics),
                               Icon(graphics));
        end LinearDynamicImpedanceMatrix;

      end WithMeasurement;

    end Stacks;

    package Components "Components of the cells and stack models"
     extends EnergyStorages.Icons.ComponentPackage;

      package Impedances "Internal impedance models of the battery cell models"
       extends EnergyStorages.Icons.ImpedancePackage;
        partial model BasicImpedance "Basic internal impedance"
          extends Modelica.Electrical.Analog.Interfaces.TwoPin;

          Modelica.Blocks.Interfaces.RealInput t annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-60,-90})));
          Modelica.Blocks.Interfaces.RealInput SOC annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={0,-90})));
          Modelica.Blocks.Interfaces.RealInput i       annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={60,-90})));

          annotation (
            Diagram(graphics),
            Icon(graphics={
                Text(
                  extent={{-80,-60},{-40,-80}},
                  lineColor={0,0,127},
                  fillColor={122,255,107},
                  fillPattern=FillPattern.Solid,
                  textString="t"),
                Text(
                  extent={{-40,-60},{40,-80}},
                  lineColor={0,0,127},
                  fillColor={122,255,107},
                  fillPattern=FillPattern.Solid,
                  textString="SOC"),
                Text(
                  extent={{20,-60},{100,-80}},
                  lineColor={0,0,127},
                  fillColor={122,255,107},
                  fillPattern=FillPattern.Solid,
                  textString="i")}));
        end BasicImpedance;

        model Rlinear "Linear dependent resistance"
          extends BasicImpedance;
          parameter EnergyStorages.CellRecords.Components.Resistance R
            "Resistance parameters";
          Modelica.Blocks.Interfaces.RealOutput Z annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={60,100}), iconTransformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={60,110})));
          Modelica.Electrical.Analog.Basic.VariableResistor Resistor(
              useHeatPort=true,
            T_ref=R.temperature.Tref,
            alpha=R.temperature.alpha)
                                annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=0,
                origin={0,0})));
          Calculators.ImpedanceValue impedanceValue(
            y0=R.R0,
            kSOC=R.SOC.kSOC,
            kQabs=R.aging.kQabs,
            kt=R.aging.kt,
            Qini=R.aging.Qini)
                         annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={0,-30})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
            annotation (Placement(transformation(extent={{-10,90},{10,110}})));
        equation
          connect(n, n) annotation (Line(
              points={{100,4.44089e-16},{100,4.44089e-16}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(Resistor.p, p) annotation (Line(
              points={{-10,0},{-54,0},{-54,4.44089e-16},{-100,4.44089e-16}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(Resistor.n, n) annotation (Line(
              points={{10,0},{56,0},{56,4.44089e-16},{100,4.44089e-16}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(t, impedanceValue.t) annotation (Line(
              points={{-60,-90},{-60,-60},{-6,-60},{-6,-39}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(SOC, impedanceValue.SOC) annotation (Line(
              points={{4.44089e-16,-90},{4.44089e-16,-39},{0,-39}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(impedanceValue.y, Resistor.R) annotation (Line(
              points={{0,-19},{0,-11}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Resistor.heatPort, heatPort) annotation (Line(
              points={{0,10},{0,100}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(impedanceValue.y, Z) annotation (Line(
              points={{0,-19},{0,-16},{60,-16},{60,100}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(impedanceValue.i, i) annotation (Line(
              points={{6,-39},{6,-60},{60,-60},{60,-90}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (
            Diagram(graphics),
            Icon(graphics={
                Line(points={{-100,0},{-80,0}}, color={0,0,255}),
                Rectangle(
                  extent={{-70,30},{70,-30}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(points={{-90,0},{-70,0}}),
                Line(points={{70,0},{90,0}}),
                Text(
                  extent={{-70,30},{70,-30}},
                  lineColor={0,0,255},
                  fillColor={122,255,107},
                  fillPattern=FillPattern.Solid,
                  textString=
                       "%name"),
                Line(points={{0,90},{0,30}}, color={191,0,0}),
                Text(
                  extent={{20,96},{100,76}},
                  lineColor={0,0,127},
                  fillColor={122,255,107},
                  fillPattern=FillPattern.Solid,
                  textString="Z")}));
        end Rlinear;

        model Clinear "Linear dependent capacitance"
         extends BasicImpedance;
         parameter EnergyStorages.CellRecords.Components.Capacitance C
            "Capacitance parameters";

          Calculators.ImpedanceValue impedanceValue(
            kQabs=C.aging.kQabs,
            kt=C.aging.kt,
            y0=C.C0,
            kSOC=C.SOC.kSOC,
            Qini=C.aging.Qini)
                         annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={0,-30})));
          Modelica.Electrical.Analog.Basic.VariableCapacitor variableCapacitor
            annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={0,0})));
        equation
          connect(SOC, impedanceValue.SOC) annotation (Line(
              points={{4.44089e-16,-90},{4.44089e-16,-39},{0,-39}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(t, impedanceValue.t) annotation (Line(
              points={{-60,-90},{-60,-60},{-6,-60},{-6,-39}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(variableCapacitor.p, p) annotation (Line(
              points={{-10,0},{-56,0},{-56,4.44089e-16},{-100,4.44089e-16}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(variableCapacitor.n, n) annotation (Line(
              points={{10,0},{54,0},{54,4.44089e-16},{100,4.44089e-16}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(impedanceValue.y, variableCapacitor.C) annotation (Line(
              points={{0,-19},{0,-11}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(impedanceValue.i, i) annotation (Line(
              points={{6,-39},{6,-60},{60,-60},{60,-90}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (
            Diagram(graphics),
            Icon(graphics={
                Line(points={{-100,0},{-80,0}}, color={0,0,255}),
                Line(points={{-90,0},{-70,0}}),
                Line(points={{70,0},{90,0}}),
                Line(
                  points={{-14,28},{-14,-28}},
                  color={0,0,255},
                  thickness=0.5),
                Line(
                  points={{14,28},{14,-28}},
                  color={0,0,255},
                  thickness=0.5),
                Line(points={{-90,0},{-14,0}}),
                Line(points={{14,0},{90,0}}),
                Text(
                  extent={{-60,100},{80,40}},
                  lineColor={0,0,255},
                  fillColor={122,255,107},
                  fillPattern=FillPattern.Solid,
                  textString="%name")}));
        end Clinear;

        model RClinear
          "Linear dependent resistance and capacitance combination"
          extends BasicImpedance;
          parameter EnergyStorages.CellRecords.Components.RCelement RC
            "Transient response resistance and capacitance parameters";
          Clinear capacitor(final C=RC.Cd)
                               annotation (Placement(transformation(extent={{
                    -10,-30},{10,-10}}, rotation=0)));
          Rlinear resistor(final R=RC.Rd)
                         annotation (Placement(transformation(extent={{-10,10},
                    {10,30}}, rotation=0)));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
            annotation (Placement(transformation(extent={{-10,90},{10,110}},
                  rotation=0)));

          Modelica.Blocks.Interfaces.RealOutput Z annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={60,100}), iconTransformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={60,110})));
        equation
          connect(resistor.p, capacitor.p)
            annotation (Line(points={{-10,20},{-10,0},{-10,-20}},
                                                          color={0,0,255}));
          connect(resistor.n, capacitor.n)
            annotation (Line(points={{10,20},{10,0},{10,-20}},
                                                        color={0,0,255}));
          connect(resistor.heatPort, heatPort)
            annotation (Line(points={{0,30},{0,30},{0,100}},
                                                      color={191,0,0}));
          connect(capacitor.SOC, resistor.SOC)
                                annotation (Line(
              points={{0,-29},{0,11}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(capacitor.t, resistor.t)
                            annotation (Line(
              points={{-6,-29},{-6,-40},{-60,-40},{-60,11},{-6,11}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(resistor.p, p) annotation (Line(
              points={{-10,20},{-10,0},{-100,0}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(resistor.n, n) annotation (Line(
              points={{10,20},{10,0},{100,0}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(SOC, capacitor.SOC) annotation (Line(
              points={{0,-90},{0,-29}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(t, capacitor.t) annotation (Line(
              points={{-60,-90},{-60,-40},{-6,-40},{-6,-29}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(resistor.Z, Z) annotation (Line(
              points={{6,31},{6,60},{60,60},{60,100}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(capacitor.i, i) annotation (Line(
              points={{6,-29},{6,-40},{60,-40},{60,-90}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(i, resistor.i) annotation (Line(
              points={{60,-90},{60,12},{6,12},{6,11}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (Diagram(graphics),
                               Icon(graphics={
                Line(
                  points={{-6,-20},{-6,-60}},
                  color={0,0,255},
                  thickness=0.5),
                Line(
                  points={{6,-20},{6,-60}},
                  color={0,0,255},
                  thickness=0.5),
                Line(points={{-90,0},{-60,0}}),
                Rectangle(
                  extent={{-28,52},{28,28}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(points={{-6,-40},{-60,-40},{-60,40},{-28,40}}, color={0,0,
                      255}),
                Line(points={{6,-40},{60,-40},{60,40},{28,40}}, color={0,0,255}),
                Line(points={{60,0},{90,0}}),
                Text(
                  extent={{0,-14},{40,-34}},
                  lineColor={0,0,255},
                  textString=
                       "Cd"),
                Text(
                  extent={{-28,52},{28,28}},
                  lineColor={0,0,255},
                  textString=
                       "Rd"),
                Text(
                  extent={{-60,20},{60,-20}},
                  lineColor={0,0,255},
                  textString=
                       "%name"),
                Line(points={{0,52},{0,90}}, color={188,0,0}),
                Text(
                  extent={{20,98},{100,78}},
                  lineColor={0,0,127},
                  fillColor={122,255,107},
                  fillPattern=FillPattern.Solid,
                  textString="Z")}));
        end RClinear;

        model RCseriesLinear
          "Series connection of several linear dependent resistance and capacitance combinations"
          extends BasicImpedance;
          parameter EnergyStorages.CellRecords.Components.RCelement RC[:]
            "Transient response resistance and capacitance parameters";
          final parameter Integer num(min=1)=size(RC,1)
            "Number of serial RC elements";

          RClinear rclinear[num](final RC=RC)
             annotation (Placement(transformation(extent={{-20,-20},{20,20}},
                              rotation=0)));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
            annotation (Placement(transformation(extent={{-10,90},{10,110}},
                  rotation=0)));

          Modelica.Blocks.Interfaces.RealOutput Z  annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={60,110})));

          Modelica.Blocks.Math.Sum sum1(final nin=num) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={60,70})));
        equation

        // real connection
        for k in 1:num loop
           connect(rclinear[k].t, t) annotation (Line(
              points={{-12,-18},{-12,-40},{-60,-40},{-60,-90}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(rclinear[k].SOC, SOC) annotation (Line(
              points={{0,-18},{0,-90}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(rclinear[k].i, i) annotation (Line(
              points={{12,-18},{12,-40},{60,-40},{60,-90}},
              color={0,0,127},
              smooth=Smooth.None));
        end for;

        //serial connection
          connect(p, rclinear[1].p) annotation (Line(
              points={{-100,0},{-20,0}},
              color={0,0,255},
              smooth=Smooth.None));
          for k in 1:(num-1) loop
            connect(rclinear[k].n,rclinear[k+1].p);
          end for;
          connect(rclinear[num].n, n) annotation (Line(
              points={{20,0},{100,0}},
              color={0,0,255},
              smooth=Smooth.None));

        //temp connection
          for k in 1:num loop
             connect(heatPort, rclinear[k].heatPort) annotation (Line(points={{0,100},{0,20}},
                             color={191,0,0}));
          end for;
          connect(sum1.y, Z) annotation (Line(
              points={{60,81},{60,110}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(rclinear.Z, sum1.u) annotation (Line(
              points={{12,22},{12,40},{60,40},{60,58}},
              color={0,0,127},
              smooth=Smooth.None));

                                                                                       annotation(Dialog(enable = num>0),
                      Diagram(graphics),
                               Icon(graphics={
                Line(
                  points={{-56,-8},{-56,-48}},
                  color={0,0,255},
                  thickness=0.5),
                Line(
                  points={{-44,-8},{-44,-48}},
                  color={0,0,255},
                  thickness=0.5),
                Line(points={{-90,0},{-80,0}}),
                Rectangle(
                  extent={{-70,40},{-30,20}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(points={{-56,-30},{-80,-30},{-80,30},{-70,30}}, color={0,0,
                      255}),
                Line(points={{-44,-30},{-20,-30},{-20,30},{-30,30}}, color={0,0,
                      255}),
                Line(
                  points={{-20,0},{20,0}},
                  color={0,0,255},
                  pattern=LinePattern.Dot),
                Line(
                  points={{44,-10},{44,-50}},
                  color={0,0,255},
                  pattern=LinePattern.Dot,
                  thickness=0.5),
                Line(
                  points={{56,-10},{56,-50}},
                  color={0,0,255},
                  pattern=LinePattern.Dot,
                  thickness=0.5),
                Rectangle(
                  extent={{30,40},{70,20}},
                  lineColor={0,0,255},
                  pattern=LinePattern.Dot,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{44,-30},{20,-30},{20,30},{30,30}},
                  color={0,0,255},
                  pattern=LinePattern.Dot),
                Line(
                  points={{56,-30},{80,-30},{80,30},{70,30}},
                  color={0,0,255},
                  pattern=LinePattern.Dot),
                Text(
                  extent={{22,-12},{82,14}},
                  lineColor={0,0,255},
                  pattern=LinePattern.Dot,
                  textString=                     "num"),
                Text(extent={{-80,-10},{-20,16}}, textString=
                                                    "1"),
                Line(points={{-20,0},{0,0},{0,0},{0,0}}, color={0,0,255}),
                Line(points={{-50,40},{-50,68},{0,68},{0,90}}, color={188,0,0}),
                Line(
                  points={{50,40},{50,68},{0,68},{0,88}},
                  color={188,0,0},
                  pattern=LinePattern.Dash),
                Text(
                  extent={{20,96},{100,76}},
                  lineColor={0,0,127},
                  fillColor={122,255,107},
                  fillPattern=FillPattern.Solid,
                  textString="Z"),
                Text(
                  extent={{-180,140},{-40,80}},
                  lineColor={0,0,255},
                  fillColor={122,255,107},
                  fillPattern=FillPattern.Solid,
                  textString=
                       "%name")}));
        end RCseriesLinear;

        model CellImpedance "Complete internal impedance of a battery cell"
          parameter EnergyStorages.CellRecords.Components.Resistance Rs
            "Resistance parameters";
          parameter EnergyStorages.CellRecords.Components.RCelement RC[:]
            "Transient response resistance and capacitance parameters";

          Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
            "Positive pin (potential p.v > n.v for positive voltage drop v)"
            annotation (Placement(transformation(extent={{-210,-10},{-190,10}},
                  rotation=0)));
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
            "Negative pin"
            annotation (Placement(transformation(extent={{190,-10},{210,10}},
                  rotation=0)));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
            annotation (Placement(transformation(extent={{-10,90},{10,110}},
                  rotation=0)));
          RCseriesLinear rcseriesLinear(final RC=RC)
            annotation (Placement(transformation(extent={{20,-20},{60,20}})));
          Rlinear rs(final R=Rs)
            annotation (Placement(transformation(extent={{-60,-20},{-20,20}})));
          Modelica.Blocks.Interfaces.RealInput t annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-140,-88}), iconTransformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-140,-90})));
          Modelica.Blocks.Interfaces.RealInput SOC annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={0,-90})));
          Modelica.Blocks.Interfaces.RealInput i annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={140,-90})));

          Modelica.Blocks.Math.Add add
            annotation (Placement(transformation(extent={{80,40},{100,60}})));
          Modelica.Blocks.Interfaces.RealOutput Z
            "Connector of Real output signal"
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={140,110})));

        equation
          connect(pin_p, rs.p)  annotation (Line(
              points={{-200,0},{-60,0}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(rs.n,rcseriesLinear. p)      annotation (Line(
              points={{-20,0},{20,0}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(rcseriesLinear.n, pin_n)
                                       annotation (Line(
              points={{60,0},{200,0}},
              color={0,0,255},
              smooth=Smooth.None));
          connect(rs.heatPort, heatPort) annotation (Line(
              points={{-40,20},{-40,60},{0,60},{0,100}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(rcseriesLinear.heatPort, heatPort) annotation (Line(
              points={{40,20},{40,60},{0,60},{0,100}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(rs.SOC, SOC) annotation (Line(
              points={{-40,-18},{-40,-40},{0,-40},{0,-90}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(rs.i, i) annotation (Line(
              points={{-28,-18},{-28,-32},{140,-32},{140,-90}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(SOC,rcseriesLinear. SOC) annotation (Line(
              points={{0,-90},{0,-40},{40,-40},{40,-18}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(t,rcseriesLinear. t) annotation (Line(
              points={{-140,-88},{-140,-50},{28,-50},{28,-18}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(rs.t, t) annotation (Line(
              points={{-52,-18},{-52,-50},{-140,-50},{-140,-88}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(rs.Z, add.u1) annotation (Line(
              points={{-28,22},{-28,56},{78,56}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(rcseriesLinear.Z, add.u2) annotation (Line(
              points={{52,22},{52,44},{78,44}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(add.y, Z) annotation (Line(
              points={{101,50},{140,50},{140,110}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(rcseriesLinear.i, i) annotation (Line(
              points={{52,-18},{52,-32},{140,-32},{140,-90}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-200,
                    -100},{200,100}}),
                              graphics),
                               Icon(coordinateSystem(preserveAspectRatio=true,
                  extent={{-200,-100},{200,100}}),
                                    graphics={
                Rectangle(
                  extent={{-160,10},{-120,-10}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{80,0},{110,0}},
                  color={0,0,255},
                  pattern=LinePattern.Dot),
                Line(
                  points={{134,-10},{134,-50}},
                  color={0,0,255},
                  pattern=LinePattern.Dot,
                  thickness=0.5),
                Line(
                  points={{146,-10},{146,-50}},
                  color={0,0,255},
                  pattern=LinePattern.Dot,
                  thickness=0.5),
                Rectangle(
                  extent={{120,40},{160,20}},
                  lineColor={0,0,255},
                  pattern=LinePattern.Dot,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{134,-30},{110,-30},{110,30},{120,30}},
                  color={0,0,255},
                  pattern=LinePattern.Dot),
                Line(
                  points={{146,-30},{170,-30},{170,30},{160,30}},
                  color={0,0,255},
                  pattern=LinePattern.Dot),
                Text(
                  extent={{112,-12},{172,14}},
                  lineColor={0,0,255},
                  pattern=LinePattern.Dot,
                  textString=                     "num"),
                Line(
                  points={{140,40},{140,68},{40,68},{40,68}},
                  color={188,0,0},
                  pattern=LinePattern.Dash),
                Line(
                  points={{70,0},{80,0}},
                  color={0,0,255},
                  smooth=Smooth.None),
                Text(
                  extent={{-40,-60},{40,-80}},
                  lineColor={0,0,127},
                  fillColor={122,255,107},
                  fillPattern=FillPattern.Solid,
                  textString="SOC"),
                Text(
                  extent={{100,-60},{180,-80}},
                  lineColor={0,0,127},
                  fillColor={122,255,107},
                  fillPattern=FillPattern.Solid,
                  textString="i"),
                Text(
                  extent={{-170,-38},{-110,-12}},
                  lineColor={0,0,255},
                  pattern=LinePattern.Dot,
                  textString="Rs"),
                Line(
                  points={{170,0},{190,0}},
                  color={0,0,255},
                  pattern=LinePattern.Dot),
                Line(
                  points={{180,0},{190,0}},
                  color={0,0,255},
                  smooth=Smooth.None),
                Line(
                  points={{-66,-8},{-66,-48}},
                  color={0,0,255},
                  thickness=0.5),
                Line(
                  points={{-54,-8},{-54,-48}},
                  color={0,0,255},
                  thickness=0.5),
                Rectangle(
                  extent={{-80,40},{-40,20}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(points={{-66,-30},{-90,-30},{-90,30},{-80,30}}, color={0,0,
                      255}),
                Line(points={{-54,-30},{-30,-30},{-30,30},{-40,30}}, color={0,0,
                      255}),
                Line(points={{-30,0},{-10,0},{-10,0},{10,0}},
                                                         color={0,0,255}),
                Line(points={{-60,40},{-60,68},{0,68},{0,68}}, color={188,0,0}),
                Line(
                  points={{34,-8},{34,-48}},
                  color={0,0,255},
                  thickness=0.5),
                Line(
                  points={{46,-8},{46,-48}},
                  color={0,0,255},
                  thickness=0.5),
                Rectangle(
                  extent={{20,40},{60,20}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(points={{34,-30},{10,-30},{10,30},{20,30}},     color={0,0,
                      255}),
                Line(points={{46,-30},{70,-30},{70,30},{60,30}},     color={0,0,
                      255}),
                Line(points={{0,90},{0,68},{40,68},{40,40}},   color={188,0,0}),
                Line(points={{-120,0},{-100,0},{-100,0},{-90,0}},
                                                         color={0,0,255}),
                Line(points={{-200,0},{-180,0},{-180,0},{-160,0}},
                                                         color={0,0,255}),
                Text(
                  extent={{12,-10},{72,16}},
                  lineColor={0,0,255},
                  pattern=LinePattern.Dot,
                  textString="2"),
                Text(
                  extent={{-90,-8},{-30,18}},
                  lineColor={0,0,255},
                  pattern=LinePattern.Dot,
                  textString="1"),
                Line(points={{-140,10},{-140,68},{0,68},{0,88}},
                                                               color={188,0,0}),
                Text(
                  extent={{-180,-60},{-100,-80}},
                  lineColor={0,0,127},
                  fillColor={122,255,107},
                  fillPattern=FillPattern.Solid,
                  textString="t"),
                Text(
                  extent={{100,98},{180,78}},
                  lineColor={0,0,127},
                  fillColor={122,255,107},
                  fillPattern=FillPattern.Solid,
                  textString="Z"),
                Text(
                  extent={{-200,140},{-60,80}},
                  lineColor={0,0,255},
                  fillColor={122,255,107},
                  fillPattern=FillPattern.Solid,
                  textString=
                       "%name")}));
        end CellImpedance;

      end Impedances;

      package Calculators
        "Calculators for the variables in the cell land stack models"
       extends EnergyStorages.Icons.CalculatorPackage;
        block CellCalculator "Calculator for the capacity, SOC, SOH,..."
          import ElectricEnergyStorages = Modelica.Electrical.EnergyStorages;
         extends Icons.Block;

          Modelica.Blocks.Interfaces.RealInput i
            annotation (Placement(transformation(extent={{-100,10},{-80,30}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealOutput SOC
                                                 annotation (Placement(
                transformation(extent={{100,50},{120,70}}, rotation=0)));

          Modelica.Blocks.Interfaces.RealOutput SOH
                                                 annotation (Placement(
                transformation(extent={{100,-70},{120,-50}}, rotation=0)));
          Modelica.Blocks.Interfaces.RealOutput C
            "Connector of Real output signal" annotation (Placement(
                transformation(extent={{100,-30},{120,-10}}, rotation=0)));

          Modelica.Blocks.Interfaces.RealOutput cycles
            "Connector of Real output signal" annotation (Placement(
                transformation(extent={{100,10},{120,30}}, rotation=0)));
          ElectricEnergyStorages.Batteries.Components.Calculators.SOC sOC(SOCini=SOCini)
                         annotation (Placement(transformation(extent={{70,
                    50},{90,70}}, rotation=0)));
          ElectricEnergyStorages.Batteries.Components.Calculators.Capacity c(capacity=
                capacity)
                     annotation (Placement(transformation(extent={{20,-10},{40,-30}},
                           rotation=0)));
          ElectricEnergyStorages.Batteries.Components.Calculators.SOHSOS sOH(
            C0=capacity.C0,
            Z0=Z0,
            SoH=SoH)                        annotation (Placement(
                transformation(extent={{72,-76},{92,-56}}, rotation=0)));
          ElectricEnergyStorages.Batteries.Components.Calculators.Qabs q(Qini=
                capacity.aging.Qini)
            annotation (Placement(transformation(extent={{-20,0},{0,20}},
                  rotation=0)));
          ElectricEnergyStorages.Batteries.Components.Calculators.Cycles
            EquivalentCycles(C0=capacity.C0, Qini=capacity.aging.Qini)
            annotation (Placement(transformation(extent={{70,10},{90,30}},
                  rotation=0)));

          Modelica.Blocks.Interfaces.RealInput t
            annotation (Placement(transformation(extent={{-100,-30},{-80,-10}},
                  rotation=0)));

          Modelica.Blocks.Interfaces.RealInput T
            annotation (Placement(transformation(extent={{-100,50},{-80,70}},
                  rotation=0)));

          Modelica.Blocks.Interfaces.RealInput Z
            "Connector of Real input signal"
            annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));

          parameter Real SOCini "Initial state of charge";
          parameter Modelica.SIunits.Resistance Z0
            "Sum of all initial ohmic impedances Rs0+Rd0[1]+...+Rd0[ns]";
          parameter EnergyStorages.CellRecords.Components.ChargeCapacity capacity
            "Charge capacity";
          parameter EnergyStorages.CellRecords.Components.SOH SoH
            "State of health relevant parameters";
        equation
          connect(SOC, SOC) annotation (Line(points={{110,60},{110,60}}, color=
                  {0,0,127}));
          connect(C, C)   annotation (Line(points={{110,-20},{110,-20}}, color=
                  {0,0,127}));
          connect(sOC.SOC, SOC) annotation (Line(points={{91,60},{110,60}},
                color={0,0,127}));
          connect(i, q.i) annotation (Line(
              points={{-90,20},{-30,20},{-30,10},{-19,10}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(i, sOC.i) annotation (Line(
              points={{-90,20},{-30,20},{-30,26},{50,26},{50,66},{71,66}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(EquivalentCycles.cycles, cycles) annotation (Line(
              points={{91,20},{110,20}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(q.Qabs, c.Qabs) annotation (Line(
              points={{1,10},{10,10},{10,-14},{21,-14}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(t, c.t) annotation (Line(
              points={{-90,-20},{-70,-20},{-70,-26},{21,-26}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(sOH.SOH, SOH) annotation (Line(
              points={{93,-60},{110,-60}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(i, EquivalentCycles.i) annotation (Line(
              points={{-90,20},{-30,20},{-30,26},{71,26}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(T, c.T) annotation (Line(
              points={{-90,60},{-48,60},{-48,-20},{21,-20}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(sOH.Z, Z) annotation (Line(
              points={{73,-72},{50,-72},{50,-60},{-90,-60}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(c.C, C) annotation (Line(
              points={{41,-20},{110,-20}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(c.C, sOH.C) annotation (Line(
              points={{41,-20},{60,-20},{60,-60},{73,-60}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(c.C, EquivalentCycles.C) annotation (Line(
              points={{41,-20},{60,-20},{60,14},{71,14}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(c.C, sOC.C) annotation (Line(
              points={{41,-20},{60,-20},{60,54},{71,54}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (
            Diagram(graphics),
            Icon(graphics={
                Text(
                  extent={{-86,44},{-46,4}},
                  lineColor={0,0,130},
                  textString="i"),
                Text(
                  extent={{38,0},{90,-40}},
                  lineColor={0,0,130},
                  textString=
                       "C"),
                Text(
                  extent={{6,80},{86,40}},
                  lineColor={0,0,130},
                  textString=
                       "SOC"),
                Text(
                  extent={{-12,44},{90,2}},
                  lineColor={0,0,130},
                  textString="cycles"),
                Text(
                  extent={{0,-38},{96,-78}},
                  lineColor={0,0,130},
                  textString="SOH"),
                Text(
                  extent={{-86,82},{-46,42}},
                  lineColor={0,0,130},
                  textString="T"),
                Text(
                  extent={{-86,6},{-46,-34}},
                  lineColor={0,0,130},
                  textString="t"),
                Text(
                  extent={{-84,-40},{-44,-80}},
                  lineColor={0,0,130},
                  textString="Z")}),
            version="1",
            DymolaStoredErrors);
        end CellCalculator;

        block SOC "State of Charge calculator"
          extends Icons.Block;
          parameter Real SOCini "Initial state of charge";
          Modelica.Blocks.Interfaces.RealInput C
            "Connector of Real input signal"
            annotation (Placement(transformation(extent={{-100,-70},{-80,-50}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealOutput SOC "Output signal connector"
            annotation (Placement(transformation(extent={{100,-10},{120,10}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealInput i
            "Connector of Real input signal"
            annotation (Placement(transformation(extent={{-100,50},{-80,70}},
                  rotation=0)));
          Modelica.Blocks.Continuous.Integrator integrator(                     y_start=
                SOCini, k=-1)
            annotation (Placement(transformation(extent={{0,-10},{20,10}},
                  rotation=0)));
          Modelica.Blocks.Math.Division DivisionNormierung
            annotation (Placement(transformation(extent={{-40,-10},{-20,10}},
                  rotation=0)));
        equation

          connect(i, DivisionNormierung.u1) annotation (Line(points={{-90,60},{
                  -60,60},{-60,6},{-42,6}}, color={0,0,127}));
          connect(C, DivisionNormierung.u2) annotation (Line(points={{-90,-60},
                  {-60,-60},{-60,-6},{-42,-6}}, color={0,0,127}));
          connect(DivisionNormierung.y, integrator.u) annotation (Line(points={
                  {-19,0},{-2,0}}, color={0,0,127}));
          connect(integrator.y, SOC) annotation (Line(points={{21,0},{110,0}},
                color={0,0,127}));
          annotation (Diagram(graphics),
                               Icon(graphics={
                Text(
                  extent={{-80,-40},{-40,-80}},
                  lineColor={0,0,130},
                  textString=
                       "C"),
                Text(
                  extent={{-80,80},{-40,40}},
                  lineColor={0,0,130},
                  textString="i"),
                Text(
                  extent={{10,20},{90,-20}},
                  lineColor={0,0,130},
                  textString=
                       "SOC")}));
        end SOC;

        block Capacity "Capacity calculator"
          extends Icons.Block;
          parameter EnergyStorages.CellRecords.Components.ChargeCapacity capacity
            "Charge capacity";

          Modelica.Blocks.Interfaces.RealInput Qabs
            "Connector of Real input signal"
            annotation (Placement(transformation(extent={{-100,-70},{-80,-50}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealInput T
            "Connector of Real input signal"
            annotation (Placement(transformation(extent={{-100,-10},{-80,10}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealInput t
            "Connector of Real input signal"
            annotation (Placement(transformation(extent={{-100,50},{-80,70}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealOutput C "Output signal connector"
            annotation (Placement(transformation(extent={{100,-10},{120,10}},
                  rotation=0)));
        equation
          C= capacity.C0*(1+capacity.aging.kt*t+capacity.aging.kQabs*Qabs)*(1+capacity.temperature.alpha*(T-capacity.temperature.Tref));
          annotation (Diagram(graphics),
                               Icon(graphics={Text(
                  extent={{-108,82},{-28,42}},
                  lineColor={0,0,130},
                  textString="t"),
                               Text(
                  extent={{40,20},{100,-20}},
                  lineColor={0,0,130},
                  textString=
                       "C"),                  Text(
                  extent={{-106,-36},{-4,-76}},
                  lineColor={0,0,130},
                  textString="|Q|"),          Text(
                  extent={{-106,20},{-26,-20}},
                  lineColor={0,0,130},
                  textString="T")}));
        end Capacity;

        block Qabs "Absolute charge transfer calculator"
            extends Icons.Block;
          Modelica.Blocks.Interfaces.RealOutput Qabs "Output signal connector"
            annotation (Placement(transformation(extent={{100,-10},{120,10}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealInput i
            "Connector of Real input signal"
            annotation (Placement(transformation(extent={{-100,-10},{-80,10}},
                  rotation=0)));
          Modelica.Blocks.Math.Abs abs annotation (Placement(transformation(
                  extent={{-60,-10},{-40,10}}, rotation=0)));
          Modelica.Blocks.Continuous.Integrator absInt(                initType=
                Modelica.Blocks.Types.Init.InitialState,
            k=1,
            y_start=Qini)
            annotation (Placement(transformation(extent={{60,-10},{80,10}},
                  rotation=0)));

          parameter Modelica.SIunits.ElectricCharge Qini(min=0)
            "Initial transferred charge";
        equation
          connect(i, abs.u) annotation (Line(points={{-90,0},{-62,0}}, color={0,
                  0,127}));
          connect(absInt.y, Qabs)
                               annotation (Line(points={{81,0},{110,0}}, color=
                  {0,0,127}));
          connect(abs.y, absInt.u) annotation (Line(points={{-39,0},{58,0}},
                color={0,0,127}));
          annotation (Diagram(graphics),
                               Icon(graphics={Text(
                  extent={{30,20},{90,-20}},
                  lineColor={0,0,130},
                  textString=
                       "|Q|"), Text(
                  extent={{-88,20},{-48,-20}},
                  lineColor={0,0,130},
                  textString="i")}));
        end Qabs;

        block Cycles "Equivalent cycles calculator"
            extends Icons.Block;
          Modelica.Blocks.Interfaces.RealOutput cycles
            "Output signal connector"
            annotation (Placement(transformation(extent={{100,-10},{120,10}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealInput i
            "Connector of Real input signal"
            annotation (Placement(transformation(extent={{-100,50},{-80,70}},
                  rotation=0)));
          Modelica.Blocks.Math.Division DivisionNormierung
            annotation (Placement(transformation(extent={{20,-10},{40,10}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealInput C
            "Connector of Real input signal"
            annotation (Placement(transformation(extent={{-100,-70},{-80,-50}},
                  rotation=0)));
          Modelica.Blocks.Math.Gain gain(k=0.5)
            annotation (Placement(transformation(extent={{-30,50},{-8,70}},
                  rotation=0)));
          Modelica.Blocks.Math.Abs abs1
            annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
          Modelica.Blocks.Continuous.Integrator integrator(y_start=cyclesini)
            annotation (Placement(transformation(extent={{60,-10},{80,10}})));
          parameter Modelica.SIunits.ElectricCharge C0
            "Charge capacity for Qeq=0 and teq=0";
          parameter Modelica.SIunits.ElectricCharge Qini(min=0)
            "Initial transferred charge";
        protected
          parameter Real cyclesini(fixed=false) "Initial cycles";
        initial equation
        cyclesini= Qini/(C0+C);
        equation

          connect(C, DivisionNormierung.u2) annotation (Line(points={{-90,-60},
                  {0,-60},{0,-6},{18,-6}},     color={0,0,127}));
          connect(gain.y, DivisionNormierung.u1) annotation (Line(points={{-6.9,60},
                  {0,60},{0,6},{18,6}},
                                    color={0,0,127}));
          connect(i, abs1.u) annotation (Line(
              points={{-90,60},{-62,60}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(abs1.y, gain.u) annotation (Line(
              points={{-39,60},{-32.2,60}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(DivisionNormierung.y, integrator.u) annotation (Line(
              points={{41,0},{58,0}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(integrator.y, cycles) annotation (Line(
              points={{81,0},{110,0}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (Diagram(graphics),
                               Icon(graphics={
                Text(
                  extent={{-92,78},{-34,40}},
                  lineColor={0,0,130},
                  textString="i"),
                Text(
                  extent={{-80,-40},{-40,-80}},
                  lineColor={0,0,130},
                  textString=
                       "C"),
                Text(
                  extent={{-16,22},{90,-16}},
                  lineColor={0,0,130},
                  textString="cycles")}));
        end Cycles;

        block ImpedanceValue
          "Block modeling linear SOC and SOH dependency of resistance and capacitances"
          extends Icons.Block;
          parameter Real y0=0.0001 "Value for SOC=0, t=0 and Qabs=0";
          parameter Real kSOC=0 "Linear SOC dependency";
          parameter Real kQabs=0 "Linear Qabs dependency";
          parameter Real kt=0 "Linear time dependency";
          Modelica.Blocks.Interfaces.RealInput t
            annotation (Placement(transformation(extent={{-100,50},{-80,70}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealOutput y
            annotation (Placement(transformation(extent={{100,-10},{120,10}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealInput i
            annotation (Placement(transformation(extent={{-100,-70},{-80,-50}},
                  rotation=0)));
          Qabs qabs(Qini=Qini)
            annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
          parameter Modelica.SIunits.ElectricCharge Qini
            "Initial transferred charge";
          Modelica.Blocks.Interfaces.RealInput SOC
            annotation (Placement(transformation(extent={{-100,-10},{-80,10}},
                  rotation=0)));
        equation

        y=y0*(1+kSOC*SOC+kt*t+kQabs*qabs.Qabs)
          annotation (Diagram(graphics),
                               Icon(graphics={
                Text(
                  extent={{-86,82},{-42,44}},
                  lineColor={0,0,130},
                  textString="t"),
                Text(
                  extent={{-84,20},{16,-20}},
                  lineColor={0,0,130},
                  textString="SOC"),
                Text(
                  extent={{-114,-40},{-14,-80}},
                  lineColor={0,0,130},
                  textString="i")}));

          connect(i, qabs.i) annotation (Line(
              points={{-90,-60},{-59,-60}},
              color={0,0,127},
              smooth=Smooth.None));

          annotation (Icon(graphics={
                Text(
                  extent={{-108,80},{-8,40}},
                  lineColor={0,0,130},
                  textString="t"),
                Text(
                  extent={{48,22},{92,-16}},
                  lineColor={0,0,130},
                  textString="y")}));
        end ImpedanceValue;

        block SOHSOS " State of Health and State of Sickness Calculator"
          extends Icons.Block;

          Modelica.Blocks.Interfaces.RealOutput SOH "Output signal connector"
            annotation (Placement(transformation(extent={{100,50},{120,70}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealOutput SOS "Output signal connector"
            annotation (Placement(transformation(extent={{100,-70},{120,-50}},
                  rotation=0)));
          SOHC sOHC(C0=C0, xc=SoH.xc)
                    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
          SOHZ sOHZ(Z0=Z0, xz=SoH.xz)
                    annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
          Modelica.Blocks.Interfaces.RealInput C
            "Connector of Real input signal"
            annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
          Modelica.Blocks.Interfaces.RealInput Z
            "Connector of Real input signal"
            annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
          Modelica.Blocks.Math.Product product
            annotation (Placement(transformation(extent={{40,-10},{60,10}})));
          parameter Modelica.SIunits.ElectricCharge C0
            "Charge capacity for Qeq=0 and teq=0";
          parameter Modelica.SIunits.Resistance Z0
            "Sum of all initial ohmic impedances Rs0+Rd0[1]+...+Rd0[ns]";
          parameter EnergyStorages.CellRecords.Components.SOH SoH
            "State of health relevant parameters";
          Modelica.Blocks.Sources.Constant const(final k=1)
            annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
          Modelica.Blocks.Math.Feedback feedback
            annotation (Placement(transformation(extent={{70,-50},{90,-70}})));
        equation
          connect(sOHC.C, C) annotation (Line(
              points={{-19,60},{-90,60}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(sOHZ.Z, Z) annotation (Line(
              points={{-19,-60},{-90,-60}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(sOHC.SOHc, product.u1) annotation (Line(
              points={{1,60},{20,60},{20,6},{38,6}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(sOHZ.SOHz, product.u2) annotation (Line(
              points={{1,-60},{20,-60},{20,-6},{38,-6}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(product.y, SOH) annotation (Line(
              points={{61,0},{80,0},{80,60},{110,60}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(product.y, feedback.u2) annotation (Line(
              points={{61,0},{80,0},{80,-52}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(const.y, feedback.u1) annotation (Line(
              points={{61,-60},{72,-60}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(feedback.y, SOS) annotation (Line(
              points={{89,-60},{110,-60}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (Diagram(graphics),
                               Icon(graphics={
                Text(
                  extent={{10,80},{90,40}},
                  lineColor={0,0,130},
                  textString=
                       "SOH"),
                Text(
                  extent={{-94,84},{-24,34}},
                  lineColor={0,0,130},
                  textString="C"),
                Text(
                  extent={{-72,-36},{-38,-82}},
                  lineColor={0,0,130},
                  textString="Z"),
                Text(
                  extent={{10,-38},{90,-78}},
                  lineColor={0,0,130},
                  textString="SOS")}));
        end SOHSOS;

        block SOHC "Capacity State of Health calculator"
          extends Icons.Block;
          parameter Modelica.SIunits.ElectricCharge C0
            "Charge capacity for Qeq=0 and teq=0";
           parameter Real xc(min=0, max=1)
            "Factor (0..1) at which value of the charge capacity C SOHc=0";
          Modelica.Blocks.Interfaces.RealInput C
            "Connector of Real input signal"
            annotation (Placement(transformation(extent={{-100,-10},{-80,10}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealOutput SOHc "Output signal connector"
            annotation (Placement(transformation(extent={{100,-10},{120,10}},
                  rotation=0)));
        equation
          assert(xc>0 and xc<1, "SOHC: parameter xc out of range (0..1)");
          SOHc=(C/C0 - xc)/(1 - xc);
          annotation (Diagram(graphics),
                               Icon(graphics={
                Text(
                  extent={{-14,24},{88,-16}},
                  lineColor={0,0,130},
                  textString="SOHc"),
                Text(
                  extent={{-98,20},{-26,-20}},
                  lineColor={0,0,130},
                  textString="C")}));
        end SOHC;

        block SOHZ "Impedance State of Health calculator"
          extends Icons.Block;
          parameter Modelica.SIunits.Resistance Z0
            "Sum of all initial ohmic impedances Rs0+Rd0[1]+...+Rd0[ns]";
           parameter Real xz(min=1)
            "Factor (>1) at which value of the internal ohmic impedance Z SOHz=0";
          Modelica.Blocks.Interfaces.RealInput Z
            "Connector of Real input signal"
            annotation (Placement(transformation(extent={{-100,-10},{-80,10}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealOutput SOHz "Output signal connector"
            annotation (Placement(transformation(extent={{100,-10},{120,10}},
                  rotation=0)));
        equation
          assert(xz>1, "SOHZ: parameter xz out of range (>1)");
          SOHz=(Z/Z0 - xz)/(1 - xz);
          annotation (Diagram(graphics),
                               Icon(graphics={
                Text(
                  extent={{-6,18},{88,-22}},
                  lineColor={0,0,130},
                  textString="SOHz"),
                Text(
                  extent={{-96,18},{-24,-22}},
                  lineColor={0,0,130},
                  textString="Z")}));
        end SOHZ;
      end Calculators;

      model SelfDischarge "Block modeling basic self discharge"
      extends EnergyStorages.Icons.Sink;

        Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent
          annotation (Placement(transformation(
              origin={40,0},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
          annotation (Placement(transformation(extent={{-10,90},{10,110}},
                rotation=0)));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
                rotation=0)));
        Modelica.Blocks.Interfaces.RealInput i
          "Current flowing from pin p to pin n as input signal"
          annotation (Placement(transformation(extent={{-100,50},{-80,70}},
                rotation=0)));

        Modelica.Blocks.Interfaces.RealInput t
          "Current flowing from pin p to pin n as input signal"
          annotation (Placement(transformation(extent={{-100,-70},{-80,-50}},
                rotation=0)));
        Modelica.Blocks.Math.LinearDependency
                                         linearDependency(
          k1=Isd.aging.kQabs,
          k2=Isd.aging.kt,
          y0=Isd.Isd0)
                     annotation (Placement(transformation(extent={{0,-10},{20,
                  10}})));

      parameter EnergyStorages.CellRecords.Components.Selfdischarge Isd
          "Self discharge parameters";

        Calculators.Qabs qabs(Qini=Isd.aging.Qini)
          annotation (Placement(transformation(extent={{-60,50},{-40,70}})));

      equation
        connect(signalCurrent.p, pin_p)
                                     annotation (Line(points={{40,10},{40,80},{
                0,80},{0,100}}, color={0,0,255}));
        connect(signalCurrent.n, pin_n)
                                     annotation (Line(points={{40,-10},{40,-80},
                {0,-80},{0,-100}}, color={0,0,255}));
        connect(t, linearDependency.u2) annotation (Line(
            points={{-90,-60},{-20,-60},{-20,-6},{-2,-6}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(linearDependency.y, signalCurrent.i) annotation (Line(
            points={{21,0},{33,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(i, qabs.i) annotation (Line(
            points={{-90,60},{-59,60}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(qabs.Qabs, linearDependency.u1) annotation (Line(
            points={{-39,60},{-20,60},{-20,6},{-2,6}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(graphics),
                             Icon(graphics={
              Text(
                extent={{-86,90},{-48,30}},
                lineColor={0,0,130},
                textString="i"),
              Text(
                extent={{-84,-28},{-46,-88}},
                lineColor={0,0,130},
                textString="t")}));
      end SelfDischarge;

      partial model OperationalParameters
        parameter Boolean useHeatPort = false "Enable/disable heat port";
        parameter Modelica.SIunits.Temperature TOperational = 293.15
          "Operational Temperature"
          annotation (Dialog(enable = not useHeatPort));
      end OperationalParameters;
    end Components;

  end Batteries;

  package CellRecords "Records for parametrization of cells"
    extends Modelica.Icons.MaterialPropertiesPackage;

    package StaticResistance "Parameter records for StaticResistance models"
      extends Modelica.Icons.MaterialPropertiesPackage;
      record StaticResistanceParameters
        "Basic parameter record for StaticResistance models"
        extends Modelica.Icons.MaterialProperty;
        parameter EnergyStorages.CellRecords.Components.SOCOCV SOCOCV
          "SOC vs OCV curve relevant parameters";
        parameter EnergyStorages.CellRecords.Components.ChargeCapacity capacity
          "Charge capacity";
        parameter EnergyStorages.CellRecords.Components.Resistance Rs
          "Resistance parameters";
        parameter EnergyStorages.CellRecords.Components.SOH SoH
          "State of health relevant parameters";
      annotation(defaultComponentPrefixes="parameter", Icon(graphics={Text(
                extent={{-100,120},{100,100}},
                lineColor={0,0,255},
                textString="%name"),
              Rectangle(
                extent={{-50,-76},{50,76}},
                lineColor={0,170,0},
                fillColor={0,170,0},
                fillPattern=FillPattern.Solid)}));
      end StaticResistanceParameters;

      record Test1Parameters
        extends
          EnergyStorages.CellRecords.StaticResistance.StaticResistanceParameters(
          SOCOCV=EnergyStorages.CellRecords.Components.SOCOCV(OCVtableOnFile=
              false, OCVtable=[0,2.7; 0.0085,3.131; 0.05,3.35; 0.1,3.49; 0.2,
              3.55; 0.4,3.65; 0.6,3.75; 0.75,3.85; 0.9,4; 1,4.2]),
          capacity=EnergyStorages.CellRecords.Components.ChargeCapacity(C0=40*
              3600),
          Rs=EnergyStorages.CellRecords.Components.Resistance(R0=0.001));
      annotation(defaultComponentPrefixes="parameter");
      end Test1Parameters;

      record Test2Parameters
        extends
          EnergyStorages.CellRecords.StaticResistance.StaticResistanceParameters(
          SOCOCV=EnergyStorages.CellRecords.Components.SOCOCV(OCVtableOnFile=
              false, OCVtable=[0,2.7; 0.0085,3.131; 0.05,3.35; 0.1,3.49; 0.2,
              3.55; 0.4,3.65; 0.6,3.75; 0.75,3.85; 0.9,4; 1,4.2]),
          capacity=EnergyStorages.CellRecords.Components.ChargeCapacity(C0=20*
              3600),
          Rs=EnergyStorages.CellRecords.Components.Resistance(R0=0.002));
      annotation(defaultComponentPrefixes="parameter");
      end Test2Parameters;
    end StaticResistance;

    package LinearDynamicImpedance
      "Parameter records for LinearDynamicImpedance models"
      extends Modelica.Icons.MaterialPropertiesPackage;
      record LinearDynamicImpedanceParameters
        "Basic parameter record for LinearDynamicImpedance models"
        extends Modelica.Icons.MaterialProperty;
        parameter EnergyStorages.CellRecords.Components.SOCOCV SOCOCV
          "SOC vs OCV curve relevant parameters";
        parameter EnergyStorages.CellRecords.Components.ChargeCapacity capacity
          "Charge capacity";
        parameter EnergyStorages.CellRecords.Components.Resistance Rs
          "Resistance parameters";
        parameter EnergyStorages.CellRecords.Components.SOH SoH
          "State of health relevant parameters";
        parameter EnergyStorages.CellRecords.Components.Selfdischarge Isd
          "Self discharge parameters"
          annotation(Dialog(group="Advanced"));
        parameter EnergyStorages.CellRecords.Components.RCelement RC[:]
          "Transient response resistance and capacitance parameters"
          annotation (Dialog(group="Advanced"));
      annotation(defaultComponentPrefixes="parameter", Icon(graphics={Text(
                extent={{-100,120},{100,100}},
                lineColor={0,0,255},
                textString="%name"),
              Rectangle(
                extent={{-50,-76},{50,76}},
                lineColor={0,170,0},
                fillColor={0,170,0},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-50,20},{50,40},{50,44},{-50,24},{-50,20}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-50,-40},{50,-20},{50,-16},{-50,-36},{-50,-40}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}));
      end LinearDynamicImpedanceParameters;

      record Test1Parameters
        extends
          EnergyStorages.CellRecords.LinearDynamicImpedance.LinearDynamicImpedanceParameters(
          SOCOCV=EnergyStorages.CellRecords.Components.SOCOCV(OCVtableOnFile=
              false, OCVtable=[0,2.7; 0.0085,3.131; 0.05,3.35; 0.1,3.49; 0.2,
              3.55; 0.4,3.65; 0.6,3.75; 0.75,3.85; 0.9,4; 1,4.2]),
          capacity=EnergyStorages.CellRecords.Components.ChargeCapacity(C0=40*
              3600),
          Rs=EnergyStorages.CellRecords.Components.Resistance(R0=0.0001),
          RC={EnergyStorages.CellRecords.Components.RCelement(Rd=
              EnergyStorages.CellRecords.Components.Resistance(R0=0.0001), Cd=
              EnergyStorages.CellRecords.Components.Capacitance(C0=50000))});
      annotation(defaultComponentPrefixes="parameter", Icon(graphics));
      end Test1Parameters;
    end LinearDynamicImpedance;

    package Components
      "Contains the records for more comfortable parameterization"
     extends EnergyStorages.Icons.ComponentPackage;

      record SOCOCV "Combines SOC vs OCV curve table parameters"
        extends Modelica.Icons.Record;
        parameter Boolean OCVtableOnFile=false
          "true, if OCV table is defined on file or in function usertab";
        parameter Real OCVtable[:,2]=fill(0,0,2)
          "SOC = first column, OCV = second column"
          annotation (Dialog(enable = not OCVtableOnFile));
      //[0,2.7; 0.0085,3.131; 0.05,3.35; 0.1,3.49; 0.2,3.55; 0.4,3.65; 0.6,3.75; 0.75,3.85; 0.9,4; 1,4.2]
        parameter String OCVtableName="NoName"
          "OCV table name on file or in function usertab (see docu)"
          annotation ( Dialog(enable = OCVtableOnFile));
        parameter String OCVfileName="NoName" "file where OCV matrix is stored"
          annotation (Dialog(enable= OCVtableOnFile));
      annotation(defaultComponentPrefixes="parameter");
      end SOCOCV;

      record ChargeCapacity "Combines the property of the charge capacity"
        extends Modelica.Icons.Record;
        parameter Modelica.SIunits.ElectricCharge C0
          "Charge Capacity for SOC=0, t=0 and Qabs=0";
        parameter CellRecords.Components.Aging aging
          "Linear aging coefficients";
        parameter CellRecords.Components.TemperatureDependency temperature
          "Temperature dependency";
      annotation(defaultComponentPrefixes="parameter");
      end ChargeCapacity;

      record TemperatureDependency "Combines temperature relevant properties"
        extends Modelica.Icons.Record;
        parameter Modelica.SIunits.Temperature Tref=293.15
          "Reference temperature";
        parameter Modelica.SIunits.LinearTemperatureCoefficient alpha=0
          "Linear temperature coefficient";
      annotation(defaultComponentPrefixes="parameter");
      end TemperatureDependency;

      record Aging "Combines the aging properties"
        extends Modelica.Icons.Record;
        parameter Modelica.SIunits.ElectricCharge Qini=0
          "Initial transferred charge";
        parameter Modelica.SIunits.ChargeAging                        kQabs = 0
          "Linear charge transfer aging coefficient";
        parameter Modelica.SIunits.TimeAging                        kt = 0
          "Linear calendaric aging coefficient";
      annotation(defaultComponentPrefixes="parameter");
      end Aging;

      record SOCDependency "Combines SOC relevant properties"
        extends Modelica.Icons.Record;
        parameter Real kSOC=0 "Linear SOC coefficient";
      annotation(defaultComponentPrefixes="parameter");
      end SOCDependency;

      record Selfdischarge "Combines the properties of the self discharge"
        extends Modelica.Icons.Record;
        parameter Modelica.SIunits.Current Isd0=0
          "Self discharge current t=0 and Qabs=0";
        parameter CellRecords.Components.Aging aging
          "Linear aging coefficients";
      annotation(defaultComponentPrefixes="parameter");
      end Selfdischarge;

      record Resistance "Combines resistance relevant properties"
        extends Modelica.Icons.Record;
        parameter Modelica.SIunits.Resistance R0
          "Resistance for SOC=0, t=0 and Qabs=0";
        parameter CellRecords.Components.SOCDependency SOC
          "Linear SOC dependency";
        parameter CellRecords.Components.Aging aging
          "Linear aging coefficients";
        parameter CellRecords.Components.TemperatureDependency temperature
          "Temperature dependency";
      annotation(defaultComponentPrefixes="parameter");
      end Resistance;

      record Capacitance "Combines capacitance relevant properties"
        extends Modelica.Icons.Record;
        parameter Modelica.SIunits.Capacitance C0
          "Capacitance for SOC=0, t=0 and Qabs=0";
        parameter CellRecords.Components.SOCDependency SOC
          "Linear SOC dependency";
        parameter CellRecords.Components.Aging aging
          "Linear aging coefficients";
      annotation(defaultComponentPrefixes="parameter");
      end Capacitance;

      record RCelement "Combines the properties of an RC element"
        extends Modelica.Icons.Record;
        parameter CellRecords.Components.Resistance Rd
          "Parameters for the resistance";
        parameter CellRecords.Components.Capacitance Cd
          "Parameters for the capacitance";
      annotation(defaultComponentPrefixes="parameter");
      end RCelement;

      record SOH "Combines SOH relevant properties"
        extends Modelica.Icons.Record;
        parameter Real xc(min=0, max=1)=0.8
          "Factor (0.1) at which value of the charge capacity C SOHc=0";
        parameter Real xz(min=1)=2
          "Factor (>1) at which value of the internal ohmic impedance Z SOHz=0";
      annotation(defaultComponentPrefixes="parameter");
      end SOH;
    end Components;
  end CellRecords;

  package BatteryManagement "Package for battery management models"
   extends Modelica.Icons.Package;
   extends EnergyStorages.Icons.BatteryManagementPackage;

    model VoltageCycling "Cycling of cells/stacks due to their pin voltage"
      extends Icons.Block;
      parameter Integer ns(start=1) "Number of serial cells";
      parameter Integer np(start=1) "Number of parallel cells";
      parameter Modelica.SIunits.Current Ifinal
        "Final switch off charging current";
      parameter Modelica.SIunits.Voltage Vmax "Maximal cell voltage";
      parameter Modelica.SIunits.Voltage Vmin "Minimum cell voltage";
      parameter Modelica.SIunits.Time delayAfterCharging
        "Delay time after charging";
      parameter Modelica.SIunits.Time delayAfterDischarging
        "Delay time after discharging";
      parameter Boolean initialDischarging=true
        "True if start with discharging";

      Modelica.Blocks.Interfaces.BooleanOutput Discharging(start=initialDischarging)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0,
            origin={110,60})));

      Modelica.Blocks.Interfaces.BooleanOutput Charging(start=initialDischarging)
        annotation (Placement(transformation(extent={{100,-70},{120,-50}},
              rotation=0)));
      Components.Cycling cycling(
        Vmax=Vmax,
        Vmin=Vmin,
        initialDischarging=initialDischarging,
        delayAfterCharging=delayAfterCharging,
        delayAfterDischarging=delayAfterDischarging)
        annotation (Placement(transformation(extent={{20,-10},{40,10}})));
      Modelica.Blocks.Math.MinMax
                             minMax(nin=ns)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      Interfaces.SingleCellBus.VOut                     vOut[
                           ns]
        annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));

      Interfaces.SingleCellBus.Bus singleCellBus[ns,np]
        "This bus contains the voltage, the current and the temperature of the cell"
        annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-100,0}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-96,0})));
      Modelica.Blocks.Interfaces.RealOutput vMax
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,110})));
      Components.ChargingFinished                                           chargingFinished(Ifinal=
            Ifinal, Vmax=Vmax)
        annotation (Placement(transformation(extent={{20,-20},{40,-40}})));
      Interfaces.SingleCellBus.IOut                     iOut[
                           np]
        annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
      Modelica.Blocks.Math.Sum sum(nin=np)
        annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));

      Modelica.Blocks.Interfaces.RealOutput vMin annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-110})));

    equation
      connect(cycling.Discharging, Discharging) annotation (Line(
          points={{41,6},{80,6},{80,60},{110,60}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(cycling.Charging, Charging) annotation (Line(
          points={{41,0},{80,0},{80,-60},{110,-60}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(vOut.y, minMax.u) annotation (Line(
          points={{-56,0},{-42,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(minMax.yMax,vMax)  annotation (Line(
          points={{-19,6},{0,6},{0,110}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(chargingFinished.finished, cycling.ChargingFinished) annotation (Line(
          points={{41,-30},{60,-30},{60,-6},{39,-6}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(iOut.y, sum.u) annotation (Line(
          points={{-56,-40},{-42,-40}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(minMax.yMin, vMin) annotation (Line(
          points={{-19,-6},{-6,-6},{-6,-60},{0,-60},{0,-110}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(minMax.yMax, chargingFinished.v) annotation (Line(
          points={{-19,6},{0,6},{0,-24},{21,-24}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(sum.y, chargingFinished.i) annotation (Line(
          points={{-19,-40},{0,-40},{0,-36},{21,-36}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(cycling.vMax, minMax.yMax) annotation (Line(
          points={{21,6},{-19,6}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(cycling.vMin, minMax.yMin) annotation (Line(
          points={{21,-6},{-19,-6}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(singleCellBus[1, :], iOut.controlBus) annotation (Line(
          points={{-100,0},{-100,0},{-80,0},{-80,-40},{-64,-40}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(singleCellBus[:, 1], vOut.controlBus) annotation (Line(
          points={{-100,0},{-64,0}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      annotation (Icon(graphics={
            Text(
              extent={{34,78},{90,48}},
              lineColor={255,0,255},
              textString="dch."),
            Text(
              extent={{34,-42},{90,-72}},
              lineColor={255,0,255},
              textString="ch."),
            Text(
              extent={{-42,-54},{46,-88}},
              lineColor={0,0,127},
              textString="Vmin"),
            Text(
              extent={{-44,80},{38,50}},
              lineColor={0,0,127},
              textString="Vmax")}),      Diagram(graphics));
    end VoltageCycling;

    package Components
      "Package, which contains models for the BatteryManagement models"
     extends EnergyStorages.Icons.ComponentPackage;

      block Cycling "Basic cycling model"
        extends Icons.Block;
        Modelica.Blocks.Logical.RSFlipFlop                 rSFlipFlop(Qini=
              initialDischarging)     annotation (Placement(transformation(extent={{20,-4},
                  {40,16}},             rotation=0)));
        Modelica.Blocks.Logical.LessThreshold lessVinMin(threshold=Vmin - 0.001)
          annotation (Placement(transformation(
              origin={-50,-60},
              extent={{-10,-10},{10,10}},
              rotation=0)));
        Modelica.Blocks.Interfaces.RealInput vMax
          annotation (Placement(transformation(
              origin={-90,60},
              extent={{-10,-10},{10,10}},
              rotation=0)));
        Modelica.Blocks.Interfaces.RealInput vMin
          "Connector of Boolean input signal"
          annotation (Placement(transformation(
              origin={-90,-60},
              extent={{-10,-10},{10,10}},
              rotation=0), iconTransformation(extent={{-100,-70},{-80,-50}})));
        parameter Modelica.SIunits.Voltage Vmax "Maximal cell voltage";
        parameter Modelica.SIunits.Voltage Vmin "Minimum cell voltage";
        parameter Modelica.SIunits.Time delayAfterCharging
          "Delay time after charging";
        parameter Modelica.SIunits.Time delayAfterDischarging
          "Delay time after discharging";
        parameter Boolean initialDischarging=true
          "True if start with discharging";

        Modelica.Blocks.Interfaces.BooleanOutput Discharging(start=
              initialDischarging)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=0,
              origin={110,60})));

        EnergyStorages.BatteryManagement.Components.OnDelay AfterChargingDelay(delayTime=
             delayAfterCharging)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=0,
              origin={70,40})));
        EnergyStorages.BatteryManagement.Components.OnDelay BeforeChargingDelay(delayTime=
             delayAfterDischarging)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=0,
              origin={70,0})));

        Modelica.Blocks.Logical.Edge edge1
          annotation (Placement(transformation(
              origin={30,-80},
              extent={{-10,-10},{10,10}},
              rotation=180)));
        Modelica.Blocks.Interfaces.BooleanInput ChargingFinished(start=
              initialDischarging)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=180,
              origin={90,-60})));
        Modelica.Blocks.Interfaces.BooleanOutput Charging(start=
              initialDischarging)
          annotation (Placement(transformation(extent={{100,-10},{120,10}},
                rotation=0)));
        Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=
              Vmax + 0.001)
                   annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
        Modelica.Blocks.Logical.Or or1
          annotation (Placement(transformation(extent={{10,10},{-10,-10}},
              rotation=180,
              origin={-10,12})));
      equation
        connect(vMin, lessVinMin.u)      annotation (Line(points={{-90,-60},{
                -90,-60},{-62,-60}},
                       color={0,0,127}));
        connect(lessVinMin.y, rSFlipFlop.R)    annotation (Line(points={{-39,-60},
                {0,-60},{10,-60},{10,0},{18,0}},
                            color={255,0,255}));
        connect(ChargingFinished, edge1.u) annotation (Line(
            points={{90,-60},{66,-60},{66,-80},{42,-80}},
            color={255,0,255},
            smooth=Smooth.None));
        connect(vMax, greaterThreshold.u)        annotation (Line(
            points={{-90,60},{-62,60}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(edge1.y, or1.u2) annotation (Line(
            points={{19,-80},{-30,-80},{-30,4},{-22,4}},
            color={255,0,255},
            smooth=Smooth.None));
        connect(or1.y, rSFlipFlop.S) annotation (Line(
            points={{1,12},{11,12},{11,12},{18,12}},
            color={255,0,255},
            smooth=Smooth.None));
        connect(rSFlipFlop.Q, AfterChargingDelay.u) annotation (Line(
            points={{41,12},{50,12},{50,40},{58,40}},
            color={255,0,255},
            smooth=Smooth.None));
        connect(AfterChargingDelay.y, Discharging) annotation (Line(
            points={{81,40},{92,40},{92,60},{110,60}},
            color={255,0,255},
            smooth=Smooth.None));
        connect(rSFlipFlop.QI, BeforeChargingDelay.u) annotation (Line(
            points={{41,0},{58,0}},
            color={255,0,255},
            smooth=Smooth.None));
        connect(BeforeChargingDelay.y, Charging) annotation (Line(
            points={{81,0},{110,0}},
            color={255,0,255},
            smooth=Smooth.None));
        connect(greaterThreshold.y, or1.u1) annotation (Line(
            points={{-39,60},{-30,60},{-30,12},{-22,12}},
            color={255,0,255},
            smooth=Smooth.None));
        annotation (Icon(graphics={
              Text(
                extent={{-90,78},{6,44}},
                lineColor={0,0,127},
                textString="vMax"),
              Text(
                extent={{40,76},{90,46}},
                lineColor={255,0,255},
                textString="dch."),
              Text(
                extent={{-94,-40},{12,-76}},
                lineColor={0,0,127},
                textString="vMin"),
              Text(
                extent={{-22,-44},{104,-72}},
                lineColor={255,0,255},
                textString="ch. fin."),
              Text(
                extent={{40,16},{90,-14}},
                lineColor={255,0,255},
                textString="ch.")}),       Diagram(graphics));
      end Cycling;

      block ChargingFinished
        "Block to determine the end of the charging process"
      extends Icons.Block;
        Modelica.Blocks.Logical.GreaterEqualThreshold GraterEqualVmax(threshold=Vmax)
          annotation (Placement(transformation(extent={{-20,-70},{0,-50}},
                rotation=0)));
        Modelica.Blocks.Logical.LessThreshold lessIfinal(threshold=-Ifinal)
          annotation (Placement(transformation(extent={{-60,50},{-40,70}},
                rotation=0)));
        Modelica.Blocks.Logical.FallingEdge fallingEdge
          annotation (Placement(transformation(extent={{-20,50},{0,70}},
                rotation=0)));
        Modelica.Blocks.Logical.And and1 annotation (Placement(transformation(
                extent={{20,-10},{40,10}},rotation=0)));
        Modelica.Blocks.Interfaces.RealInput i
          "Connector of Boolean input signal"
          annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
        Modelica.Blocks.Interfaces.RealInput v
          "Connector of Boolean input signal"
          annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
        Modelica.Blocks.Interfaces.BooleanOutput finished
          "Connector of Boolean output signal"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        parameter Modelica.SIunits.Current Ifinal "Charging switch off current";
        parameter Modelica.SIunits.Voltage Vmax "Maximal charging voltage";
      equation

        connect(lessIfinal.y, fallingEdge.u)    annotation (Line(points={{-39,60},
                {-26,60},{-22,60}},
                          color={255,0,255}));
        connect(fallingEdge.y,and1. u1) annotation (Line(points={{1,60},{8,60},
                {8,0},{18,0}},    color={255,0,255}));
        connect(GraterEqualVmax.y,and1. u2) annotation (Line(points={{1,-60},{8,
                -60},{8,-8},{18,-8}},    color={255,0,255}));
        connect(lessIfinal.u, i)    annotation (Line(
            points={{-62,60},{-90,60}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(GraterEqualVmax.u,v)  annotation (Line(
            points={{-22,-60},{-90,-60}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(and1.y, finished) annotation (Line(
            points={{41,0},{110,0}},
            color={255,0,255},
            smooth=Smooth.None));
        annotation (Diagram(graphics), Icon(graphics={
              Text(
                extent={{-90,90},{-34,28}},
                lineColor={0,0,127},
                textString="i"),
              Text(
                extent={{-80,-32},{-34,-90}},
                lineColor={0,0,127},
                textString="v"),
              Text(
                extent={{-26,18},{90,-18}},
                lineColor={255,85,255},
                textString="finished")}));
      end ChargingFinished;

      block OnDelay "Delays the boolean true with a defined delay time"
        extends Modelica.Blocks.Interfaces.BooleanSISO;
        Modelica.Blocks.Logical.RSFlipFlop                 rSFlipFlop
                              annotation (Placement(transformation(extent={{40,-10},{60,
                  10}},           rotation=0)));
        Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(
                extent={{-40,-20},{-20,0}},  rotation=0)));
        parameter Modelica.SIunits.Time delayTime
          "Delay time of output with respect to input signal";
        Modelica.Blocks.Logical.Timer timer
          annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
        Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=
              delayTime)
          annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      equation
        connect(not1.y, rSFlipFlop.R) annotation (Line(points={{-19,-10},{20,-10},
                {20,-6},{38,-6}},
                                color={255,0,255}));
        connect(timer.y, greaterThreshold.u) annotation (Line(
            points={{-39,30},{-22,30}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(greaterThreshold.y, rSFlipFlop.S) annotation (Line(
            points={{1,30},{20,30},{20,6},{38,6}},
            color={255,0,255},
            smooth=Smooth.None));
        connect(u, timer.u) annotation (Line(
            points={{-120,0},{-80,0},{-80,30},{-62,30}},
            color={255,0,255},
            smooth=Smooth.None));
        connect(u, not1.u) annotation (Line(
            points={{-120,0},{-80,0},{-80,-10},{-42,-10}},
            color={255,0,255},
            smooth=Smooth.None));
        connect(rSFlipFlop.Q, y) annotation (Line(
            points={{61,6},{80,6},{80,0},{110,0}},
            color={255,0,255},
            smooth=Smooth.None));
        annotation (Diagram(graphics),
                             Icon(graphics={
              Polygon(
                points={{-80,88},{-88,66},{-72,66},{-80,88}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,66},{-80,-82}}, color={0,0,0}),
              Line(points={{-90,-70},{72,-70}}, color={0,0,0}),
              Polygon(
                points={{90,-70},{68,-62},{68,-78},{90,-70}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,-70},{-50,-70},{-50,54},{56,54},{56,-70},{58,
                    -70}}, color={0,0,0}),
              Line(points={{-50,-70},{-30,-70},{-30,54},{56,54},{56,-70},{70,
                    -70},{68,-70}}, color={0,0,0}),
              Text(
                extent={{-90,72},{10,56}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                textString=
                     "Td")}));
      end OnDelay;
    end Components;
  end BatteryManagement;

  package Icons "Package which contains all icons of the used models"
  extends Modelica.Icons.Package;
   extends Icons.IconPackage;

    partial package BatteryPackage "Icon for the EES Library "
    // Copyright:
    //   This program is copyright by the Austrian Institute of Technology, Mobility Department,
    //   Oesterreichisches Forschungs- und Pruefzentrum Arsenal Ges.m.b.H,
    //   Giefinggasse 2, 1210 Vienna, Austria, UID: ATU 46577208
    //   www.ait.ac.at, sed@ait.ac.at
      annotation (Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Polygon(
              points={{-54,-100},{-54,80},{-20,80},{-20,100},{20,100},{20,80},{
                  54,80},{54,-100},{-54,-100}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-20,-59},{21,50}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,170,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-20,14},{21,24},{21,28},{-20,18},{-20,14}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-20,-39},{21,-29},{21,-26},{-20,-36},{-20,-39}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-20,-40},{21,-30},{21,-26},{-20,-36},{-20,-40}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(revisions="<html>
<table border=\"1\" rules=\"groups\">
<thead>
<tr><td>Version</td>  <td>Date</td>  <td>Comment</td></tr>
</thead>
<tbody>
<tr><td>1.0.0</td>  <td>2006-03-13</td>  <td> </td></tr>
</tbody>
</table>
</html>"));

    end BatteryPackage;

    partial package ChargerPackage "Icon for the Chargers package"

      annotation (Icon(graphics={Polygon(
              points={{-10,-20},{-10,-20},{-10,-20},{-34,-86},{44,0},{-6,0},{16,
                  58},{-58,-20},{-10,-20}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
                                     Diagram(graphics));
    end ChargerPackage;

    partial package FolderPackage "Icon for a standard package"
    // Copyright:
    //   This program is copyright by the Austrian Institute of Technology, Mobility Department,
    //   Oesterreichisches Forschungs- und Pruefzentrum Arsenal Ges.m.b.H,
    //   Giefinggasse 2, 1210 Vienna, Austria, UID: ATU 46577208
    //   www.ait.ac.at, sed@ait.ac.at
      annotation (Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{-100,-100},{-100,40},{-88,46},{-80,80},{-40,100},{-24,78},
                  {20,100},{20,-40},{-100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Polygon(
              points={{-100,-100},{-24,20},{100,80},{20,-40},{-100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(revisions="<html>
<table border=\"1\" rules=\"groups\">
<thead>
<tr><td>Version</td>  <td>Date</td>  <td>Comment</td></tr>
</thead>
<tbody>
<tr><td>1.0.0</td>  <td>2006-03-13</td>  <td> </td></tr>
</tbody>
</table>
</html>"));
    end FolderPackage;

    partial package StackPackage "Icon for the Stacks package"

      annotation (Icon(graphics={
            Polygon(
              points={{-52,-92},{-52,28},{-32,28},{-32,48},{8,48},{8,28},{48,28},
                  {48,48},{88,48},{88,28},{108,28},{108,-92},{-52,-92}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-78,-68},{-78,52},{-58,52},{-58,72},{-18,72},{-18,52},{
                  22,52},{22,72},{62,72},{62,52},{82,52},{82,-68},{-78,-68}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-100,-40},{-100,80},{-80,80},{-80,100},{-40,100},{-40,80},
                  {0,80},{0,100},{40,100},{40,80},{60,80},{60,-40},{-100,-40}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-16,84},{76,-2}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString=
                   "-"),
            Text(
              extent={{-74,62},{2,0}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString=
                   "+")}));

    end StackPackage;

    partial package IconPackage "Icon for the Icons package"

      annotation (Icon(graphics={
            Rectangle(
              extent={{-72,12},{8,-68}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-72,12},{-42,42}}, color={0,0,0}),
            Line(points={{-42,42},{38,42}}, color={0,0,0}),
            Line(points={{38,42},{8,12}},  color={0,0,0}),
            Line(points={{38,42},{38,-46}}, color={0,0,0}),
            Line(points={{46,-30},{8,-68}},  color={0,0,0})}), Diagram(graphics={
            Rectangle(
              extent={{-80,0},{0,-80}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,0},{-50,30}},  color={0,0,0}),
            Line(points={{-50,30},{30,30}}, color={0,0,0}),
            Line(points={{30,30},{0,0}},   color={0,0,0}),
            Line(points={{30,30},{30,-58}}, color={0,0,0}),
            Line(points={{30,-50},{0,-80}},  color={0,0,0})}));
    end IconPackage;

    partial package SIunitsPackage "Icon for the SIunits package"

      annotation (Icon(graphics={             Text(
              extent={{-64,42},{58,-68}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString=
                   "SI")}));
    end SIunitsPackage;

    partial package ComponentPackage "Icon for the Components package"

      annotation (Icon(graphics={
            Rectangle(
              extent={{-78,46},{42,-74}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-18,46},{-18,-74}},  color={0,0,0}),
            Line(points={{-78,-14},{42,-14},{42,-14}},  color={0,0,0})}));
    end ComponentPackage;

    partial package CalculatorPackage "Icon for the Calculators package"

      annotation (Icon(graphics={
            Rectangle(extent={{-80,100},{100,-100}}, lineColor={0,0,0}),
            Rectangle(extent={{-56,80},{72,46}}, lineColor={0,0,0}),
            Rectangle(extent={{-30,18},{-20,8}}, lineColor={0,0,0}),
            Rectangle(extent={{10,18},{20,8}}, lineColor={0,0,0}),
            Rectangle(extent={{50,18},{60,8}}, lineColor={0,0,0}),
            Rectangle(extent={{-30,-22},{-20,-32}}, lineColor={0,0,0}),
            Rectangle(extent={{10,-22},{20,-32}}, lineColor={0,0,0}),
            Rectangle(extent={{50,-22},{60,-32}}, lineColor={0,0,0}),
            Rectangle(extent={{-30,-62},{-20,-72}}, lineColor={0,0,0}),
            Rectangle(extent={{10,-62},{20,-72}}, lineColor={0,0,0}),
            Rectangle(extent={{50,-62},{60,-72}}, lineColor={0,0,0})}),
          Diagram(graphics));

    end CalculatorPackage;

    partial package ImpedancePackage "Icon for the Impedance package"

      annotation (Icon(graphics={
            Line(points={{-100,60},{-60,60}}, color={0,0,0}),
            Rectangle(extent={{-60,80},{60,40}}, lineColor={0,0,0}),
            Line(points={{60,60},{100,60}}, color={0,0,0}),
            Line(points={{-100,-50},{-10,-50}}, color={0,0,0}),
            Line(points={{10,-52},{100,-52}}, color={0,0,0}),
            Line(points={{-10,0},{-10,-100},{-10,-100}}, color={0,0,0}),
            Line(points={{10,0},{10,-100},{10,-100}}, color={0,0,0}),
            Line(points={{-100,58},{-100,-42},{-100,-50}}, color={0,0,0}),
            Line(points={{100,60},{100,-40},{100,-52}}, color={0,0,0})}),
                         Diagram(graphics));

    end ImpedancePackage;

    partial package CyclesPackage "Icon for the Cycles package"

      annotation (Icon(graphics={Line(points={{-100,-40},{-80,-40},{-60,0},{-40,
                  -80},{-20,-20},{-10,-52},{20,80},{44,-100},{60,-20},{80,-40},
                  {100,-40}}, color={0,0,0})}));
    end CyclesPackage;

    partial package MeasurementPackage "Icon for the Measurement package"

      annotation (Diagram(graphics),
                           Icon(graphics={
            Rectangle(extent={{-100,30},{100,-30}}, lineColor={0,0,0}),
            Line(points={{-60,30},{-60,-12}},color={0,0,0}),
            Line(points={{-20,30},{-20,-14}},color={0,0,0}),
            Line(points={{20,30},{20,-14}},color={0,0,0}),
            Line(points={{60,30},{60,-16}},color={0,0,0})}));

    end MeasurementPackage;

    partial package SinglePackage "Icon for the Single packages"

      annotation (Icon(graphics={
            Line(points={{0,-70},{0,-10},{-40,-10},{40,-10}}, color={0,0,0}),
            Line(points={{-80,10},{80,10}}, color={0,0,0}),
            Line(points={{0,10},{0,70}}, color={0,0,0})}));
    end SinglePackage;

    partial package BatteriesPackage "Icon for the Batteries package "

    annotation (Icon(graphics={
            Ellipse(
              extent={{-56,-34},{26,-76}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-56,40},{26,-38}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-56,-56},{-56,32},{26,28},{26,-56}}, color={0,0,0}),
            Ellipse(
              extent={{-56,54},{26,4}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-34,52},{0,34}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
    end BatteriesPackage;

    partial package Load "Icon for the Load package"

      annotation (Icon(graphics={
            Ellipse(
              extent={{-70,-26},{-30,-66}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{6,-28},{46,-68}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-68,-20},{-80,-40},{-80,20},{-40,20},{-20,20},{20,20},{52,20},
                  {52,14},{52,-40},{52,-40},{42,-20},{10,-20},{0,-40},{0,-40},{-20,-40},
                  {-32,-20},{-68,-20}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid)}));
    end Load;

    partial package BatteryManagementPackage
      "Icon for the BatteryManagement package"

      annotation (Icon(graphics={
            Polygon(
              points={{-60,-54},{-10,32},{40,-54},{-60,-54}},
              lineColor={95,95,95},
              smooth=Smooth.None,
              fillPattern=FillPattern.Solid,
              fillColor={95,95,95}),
            Ellipse(
              extent={{-30,46},{10,6}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-80,-34},{-40,-74}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{20,-34},{60,-74}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
                           Diagram(graphics));
    end BatteryManagementPackage;

    partial block Block "Icon for a basic block"

      annotation (Icon(graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid), Rectangle(
              extent={{88,-88},{-88,88}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={230,230,230},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{14,134},{176,100}},
              lineColor={0,0,255},
              fillColor={122,255,107},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name")}));
    end Block;

    model ControlBus "Icon for the control bus"

      annotation (Icon(graphics={
            Rectangle(
              extent={{-20,2},{20,-2}},
              lineColor={255,204,51},
              lineThickness=0.5),
            Polygon(
              points={{-80,50},{80,50},{100,30},{80,-40},{60,-50},{-60,-50},{
                  -80,-40},{-100,30},{-80,50}},
              lineColor={0,0,0},
              fillColor={255,204,51},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-65,25},{-55,15}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-5,25},{5,15}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{55,25},{65,15}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-35,-15},{-25,-25}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{25,-15},{35,-25}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-20,2},{22,-2}},
              lineColor={255,204,51},
              lineThickness=0.5)}),
          Diagram(graphics={
            Rectangle(
              extent={{-20,2},{20,-2}},
              lineColor={255,204,51},
              lineThickness=0.5),
            Polygon(
              points={{-80,50},{80,50},{100,30},{80,-40},{60,-50},{-60,-50},{
                  -80,-40},{-100,30},{-80,50}},
              lineColor={0,0,0},
              fillColor={255,204,51},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-65,25},{-55,15}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-5,25},{5,15}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{55,25},{65,15}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-35,-15},{-25,-25}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{25,-15},{35,-25}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-20,2},{22,-2}},
              lineColor={255,204,51},
              lineThickness=0.5)}));
    end ControlBus;

    model CellBus "Icon for the cell bus"

      annotation (Icon(graphics={
            Line(
              points={{-16,2},{16,2}},
              color={255,204,51},
              thickness=0.5),
            Rectangle(
              extent={{-10,8},{8,0}},
              lineColor={255,204,51},
              lineThickness=0.5),
            Polygon(
              points={{-80,50},{80,50},{100,30},{80,-40},{60,-50},{-60,-50},{
                  -80,-40},{-100,30},{-80,50}},
              lineColor={0,0,0},
              fillColor={255,204,51},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-55,25},{-45,15}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{45,25},{55,15}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-5,-15},{5,-25}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-20,4},{20,0}},
              lineColor={255,204,51},
              lineThickness=0.5),
            Rectangle(
              extent={{-14,8},{4,0}},
              lineColor={255,204,51},
              lineThickness=0.5)}),
                              Diagram(graphics={
            Line(
              points={{-16,2},{16,2}},
              color={255,204,51},
              thickness=0.5),
            Rectangle(
              extent={{-10,8},{8,0}},
              lineColor={255,204,51},
              lineThickness=0.5),
            Polygon(
              points={{-80,50},{80,50},{100,30},{80,-40},{60,-50},{-60,-50},{
                  -80,-40},{-100,30},{-80,50}},
              lineColor={0,0,0},
              fillColor={255,204,51},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-55,25},{-45,15}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{45,25},{55,15}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-5,-15},{5,-25}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-20,4},{20,0}},
              lineColor={255,204,51},
              lineThickness=0.5),
            Rectangle(
              extent={{-14,8},{4,0}},
              lineColor={255,204,51},
              lineThickness=0.5)}));
    end CellBus;

    partial model AdaptorOut "Icon for a bus adaptor (read from the bus)"

      annotation (Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{40,10},{40,-10},{40,-20},{10,-20},{-10,-40},{-40,-40},{
                  -40,40},{-10,40},{10,20},{40,20},{40,10}},
              lineColor={0,0,127},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid), Text(
              extent={{-148,81},{152,41}},
              lineColor={0,0,255},
              textString=
                   "%name")}),
        Documentation(revisions="<html>
<table border=\"1\" rules=\"groups\">
<thead>
<tr><td>Version</td>  <td>Date</td>  <td>Comment</td></tr>
</thead>
<tbody>
<tr><td>1.0.0</td>  <td>2006-03-13</td>  <td> </td></tr>
</tbody>
</table>
</html>"));
    end AdaptorOut;

    partial model AdaptorIn "Icon for a bus adaptor (feeding the bus)"

      annotation (Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{-40,20},{-40,-20},{-20,-20},{-10,-20},{10,-40},{40,-40},
                  {40,40},{10,40},{-10,20},{-24,20},{-40,20}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid), Text(
              extent={{-148,81},{152,41}},
              lineColor={0,0,255},
              textString=
                   "%name")}),
        Documentation(revisions="<html>
<table border=\"1\" rules=\"groups\">
<thead>
<tr><td>Version</td>  <td>Date</td>  <td>Comment</td></tr>
</thead>
<tbody>
<tr><td>1.0.0</td>  <td>2006-03-13</td>  <td> </td></tr>
</tbody>
</table>
</html>"));
    end AdaptorIn;

    model CellStaticResistance "Icon for the StaticResistance cell model"

      annotation (Icon(graphics={
            Line(points={{-54,-100},{54,-100},{48,-100}}, color={0,0,0}),
            Line(points={{-54,-100},{-54,80},{-20,80},{-20,100},{20,100},{20,80},
                  {54,80},{54,-100}},        color={0,0,0}),
            Text(
              extent={{-20,100},{20,60}},
              lineColor={0,0,0},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid,
              textString=
                   "+"),
            Rectangle(
              extent={{-50,-96},{50,56}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-54,-60},{54,-100}},
              lineColor={0,0,0},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid,
              textString=
                   "-"),
            Polygon(
              points={{-50,56},{50,76},{50,56},{-50,56}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              lineThickness=0.5,
              fillColor={0,170,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-50,0},{50,20},{50,24},{-50,4},{-50,0}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-50,-60},{50,-40},{50,-36},{-50,-56},{-50,-60}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-50,-96},{50,56}},
              lineColor={0,170,0},
              fillColor={0,170,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-54,-60},{54,-100}},
              lineColor={0,0,0},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid,
              textString=
                   "-"),
            Text(
              extent={{20,118},{182,84}},
              lineColor={0,0,255},
              fillColor={122,255,107},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name")}),Diagram(graphics));
    end CellStaticResistance;

    model CellLinearDynamicImpedance
      "Icon for the LinearDynamicImpedance cell model"

      annotation (Icon(graphics={
            Line(points={{-54,-100},{54,-100},{48,-100}}, color={0,0,0}),
            Line(points={{-54,-100},{-54,80},{-20,80},{-20,100},{20,100},{20,80},
                  {54,80},{54,-100}},        color={0,0,0}),
            Text(
              extent={{-20,100},{20,60}},
              lineColor={0,0,0},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid,
              textString=
                   "+"),
            Rectangle(
              extent={{-50,-96},{50,56}},
              lineColor={0,170,0},
              fillColor={0,170,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-54,-60},{54,-100}},
              lineColor={0,0,0},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid,
              textString=
                   "-"),
            Polygon(
              points={{-50,56},{50,76},{50,56},{-50,56}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              lineThickness=0.5,
              fillColor={0,170,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-50,0},{50,20},{50,24},{-50,4},{-50,0}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-50,-60},{50,-40},{50,-36},{-50,-56},{-50,-60}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-54,-60},{54,-100}},
              lineColor={0,0,0},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid,
              textString=
                   "-"),
            Text(
              extent={{20,118},{182,84}},
              lineColor={0,0,255},
              fillColor={122,255,107},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name")}),Diagram(graphics));
    end CellLinearDynamicImpedance;

    model StackStaticResistance "Icon for the StaticResistance stack model"
    extends Icons.Block;

      annotation (Icon(graphics={
            Rectangle(
              extent={{-70,-20},{-50,8}},
              lineColor={0,170,0},
              fillColor={0,170,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-70,8},{-50,14},{-50,8},{-70,8}},
              lineColor={0,127,0},
              pattern=LinePattern.None,
              fillColor={0,170,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-70,-20},{-70,14},{-64,14},{-64,20},{-56,20},{-56,14},{-50,14},
                  {-50,-20},{-70,-20}},
              color={255,255,255},
              thickness=1),
            Line(
              points={{-70,-20},{-70,14},{-64,14},{-64,20},{-56,20},{-56,14},{-50,14},
                  {-50,-20},{-70,-20}},
              color={0,0,0},
              thickness=0.5),
            Rectangle(
              extent={{12,-54},{68,32}},
              lineColor={0,170,0},
              fillColor={0,170,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{12,32},{68,42},{68,32},{12,32}},
              lineColor={0,127,0},
              pattern=LinePattern.None,
              fillColor={0,170,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{10,-56},{10,44},{30,44},{30,56},{50,56},{50,44},{70,44},{70,-56},
                  {10,-56}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{-60,30},{10,60}},
              color={0,0,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dot),
            Line(
              points={{-60,-30},{10,-60}},
              color={0,0,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dot),
            Line(
              points={{-34,0},{-4,0}},
              color={0,0,0},
              smooth=Smooth.None),
            Polygon(
              points={{-4,0},{-16,4},{-16,-4},{-4,0}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}),
                              Diagram(graphics));
    end StackStaticResistance;

    model StackLinearDynamicImpedance
      "Icon for the LinearDynamicImpedance stack model"
    extends Icons.Block;
      annotation (Icon(graphics={
            Rectangle(
              extent={{-70,40},{-50,54}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-70,54},{-50,60},{-50,54},{-70,54}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-70,40},{-70,74},{-64,74},{-64,80},{-56,80},{-56,74},{
                  -50,74},{-50,40},{-70,40}},
              color={255,255,255},
              thickness=1),
            Line(points={{-60,40},{-60,32},{-60,34}}, color={0,0,0}),
            Line(points={{-60,-8},{-60,-40}}, color={0,0,0}),
            Line(points={{-60,-80},{50,-80}}, color={0,0,0}),
            Line(
              points={{-50,40},{56,-40}},
              color={0,0,0},
              pattern=LinePattern.Dash),
            Line(
              points={{-10,60},{50,60}},
              color={0,0,0},
              pattern=LinePattern.Dash),
            Line(
              points={{-50,-60},{50,-60}},
              color={0,0,0},
              pattern=LinePattern.Dash),
            Line(
              points={{0,40},{60,40}},
              color={0,0,255},
              pattern=LinePattern.Dash),
            Line(points={{-50,40},{50,40}}, color={0,0,0}),
            Line(points={{60,40},{60,-40}}, color={0,0,0}),
            Text(
              extent={{-90,-70},{-68,-90}},
              lineColor={0,0,0},
              textString=
                   "ns"),
            Text(
              extent={{28,80},{50,60}},
              lineColor={0,0,0},
              textString=
                   "np"),
            Line(points={{0,80},{0,90},{0,80}}, color={0,0,0}),
            Line(points={{0,-90},{0,-80},{0,-90}}, color={0,0,0}),
            Line(points={{-60,80},{60,80}}, color={0,0,0}),
            Line(
              points={{-70,40},{-70,74},{-64,74},{-64,80},{-56,80},{-56,74},{
                  -50,74},{-50,40},{-70,40}},
              color={0,0,0},
              thickness=0.5),
            Rectangle(
              extent={{-30,40},{-10,54}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-30,54},{-10,60},{-10,54},{-30,54}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-30,40},{-30,74},{-24,74},{-24,80},{-16,80},{-16,74},{
                  -10,74},{-10,40},{-30,40}},
              color={255,255,255},
              thickness=1),
            Line(
              points={{-30,40},{-30,74},{-24,74},{-24,80},{-16,80},{-16,74},{
                  -10,74},{-10,40},{-30,40}},
              color={0,0,0},
              thickness=0.5),
            Rectangle(
              extent={{50,40},{70,54}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{50,54},{70,60},{70,54},{50,54}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{50,40},{50,74},{56,74},{56,80},{64,80},{64,74},{70,74},{
                  70,40},{50,40}},
              color={255,255,255},
              thickness=1),
            Line(
              points={{50,40},{50,74},{56,74},{56,80},{64,80},{64,74},{70,74},{
                  70,40},{50,40}},
              color={0,0,0},
              thickness=0.5),
            Rectangle(
              extent={{-70,-8},{-50,20}},
              lineColor={0,170,0},
              fillColor={0,170,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-70,20},{-50,26},{-50,20},{-70,20}},
              lineColor={0,127,0},
              pattern=LinePattern.None,
              fillColor={0,170,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-70,-8},{-70,26},{-64,26},{-64,32},{-56,32},{-56,26},{
                  -50,26},{-50,-8},{-70,-8}},
              color={255,255,255},
              thickness=1),
            Line(
              points={{-70,-8},{-70,26},{-64,26},{-64,32},{-56,32},{-56,26},{
                  -50,26},{-50,-8},{-70,-8}},
              color={0,0,0},
              thickness=0.5),
            Rectangle(
              extent={{-70,-80},{-50,-76}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-70,-76},{-50,-70},{-50,-76},{-70,-76}},
              lineColor={0,127,0},
              pattern=LinePattern.None,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-70,-80},{-70,-46},{-64,-46},{-64,-40},{-56,-40},{-56,
                  -46},{-50,-46},{-50,-80},{-70,-80}},
              color={255,255,255},
              thickness=1),
            Line(
              points={{-70,-80},{-70,-46},{-64,-46},{-64,-40},{-56,-40},{-56,
                  -46},{-50,-46},{-50,-80},{-70,-80}},
              color={0,0,0},
              thickness=0.5),
            Rectangle(
              extent={{50,-80},{70,-76}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{50,-76},{70,-70},{70,-76},{50,-76}},
              lineColor={0,127,0},
              pattern=LinePattern.None,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{50,-80},{50,-46},{56,-46},{56,-40},{64,-40},{64,-46},{70,
                  -46},{70,-80},{50,-80}},
              color={255,255,255},
              thickness=1),
            Line(
              points={{50,-80},{50,-46},{56,-46},{56,-40},{64,-40},{64,-46},{70,
                  -46},{70,-80},{50,-80}},
              color={0,0,0},
              thickness=0.5),
            Line(points={{-60,-40},{60,-40}}, color={0,0,0})}),
                              Diagram(graphics));
    end StackLinearDynamicImpedance;

    partial block Source "Icon for a basic block"
    extends EnergyStorages.Icons.Block;
      annotation (Icon(graphics={
            Ellipse(extent={{-40,40},{40,-40}}, lineColor={0,0,0},
              origin={0,2},
              rotation=90),
            Line(points={{0,40},{0,-40}}, color={0,0,0},
              origin={0,2},
              rotation=90),
            Polygon(
              points={{0,-10},{-8,8},{8,8},{0,-10}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              origin={0,60},
              rotation=180),
            Line(
              points={{0,90},{0,42}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              points={{0,-40},{0,-90}},
              color={0,0,0},
              smooth=Smooth.None)}));
    end Source;

    partial block Sink "Icon for a basic block"
    extends EnergyStorages.Icons.Block;
      annotation (Icon(graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid), Rectangle(
              extent={{88,-88},{-88,88}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={230,230,230},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{14,134},{176,100}},
              lineColor={0,0,255},
              fillColor={122,255,107},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name"),
            Ellipse(extent={{-40,40},{40,-40}}, lineColor={0,0,0},
              origin={0,2},
              rotation=90),
            Line(points={{0,40},{0,-40}}, color={0,0,0},
              origin={0,2},
              rotation=90),
            Polygon(
              points={{0,-10},{-8,8},{8,8},{0,-10}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              origin={0,60},
              rotation=360),
            Line(
              points={{0,90},{0,42}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              points={{0,-40},{0,-90}},
              color={0,0,0},
              smooth=Smooth.None)}));
    end Sink;
    annotation (Diagram(graphics), Icon(graphics));
  end Icons;

  package Interfaces
   extends Modelica.Icons.InterfacesPackage;
    package SingleCellBus
    extends Modelica.Icons.Package;
      expandable connector Bus "Bus for single sells"
      // Copyright:
      //   This program is copyright by the Austrian Institute of Technology, Mobility Department,
      //   Oesterreichisches Forschungs- und Pruefzentrum Arsenal Ges.m.b.H,
      //   Giefinggasse 2, 1210 Vienna, Austria, UID: ATU 46577208
      //   www.ait.ac.at, sed@ait.ac.at
        extends Modelica.Icons.SignalSubBus;
        Modelica.SIunits.Voltage v "Cell voltage";
        Modelica.SIunits.Current i "Cell current";
        Modelica.SIunits.Temperature T "Cell temperature";

        annotation (Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={Rectangle(
                extent={{-14,8},{4,0}},
                lineColor={255,204,51},
                lineThickness=0.5)}),
                               defaultComponentName="sedBusAIMC",Documentation(info="<html>
<p>
This bus is used for <a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage\">asynchronous induction machines with squirrel cage rotor</a> (AIMCs) control. Various signals are predefined in the SEDBusAIMC.
</p>

<!-- visible -->


</html>",       revisions="<html>
<table border=\"1\" rules=\"groups\">
<thead>
<tr><td>Version</td>  <td>Date</td>  <td>Comment</td></tr>
</thead>
<tbody>
<tr><td>1.0.0</td>  <td>2006-03-13</td>  <td> </td></tr>
</tbody>
</table>
</html>"));
      end Bus;

      model IOut
        "Adaptor for reading the current of the battery from the SingleCellBus"

      extends Icons.AdaptorOut;

        Modelica.Blocks.Interfaces.RealOutput y
          "Current of the battery (Output)"
          annotation (Placement(transformation(extent={{30,-10},{50,10}},
                rotation=0)));

        EnergyStorages.Interfaces.SingleCellBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={-40,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      equation
        connect(gain.y, y)  annotation (Line(points={{11,0},{17,0},{40,0}},
                                               color={0,0,127}));
        connect(gain.u, controlBus.i) annotation (
          Text(
            string="%second",
            index=1,
            extent=[6,3; 6,3],
            style(color=0, rgbcolor={0,0,0})), Line(points={{-12,0},{-28,0},{
                -40,0}},                            color={0,0,127}));
        annotation (Diagram(graphics));
      end IOut;

      model IIn
        "Adaptor for feeding the current of the battery to the SingleCellBus"
      extends Icons.AdaptorIn;

        EnergyStorages.Interfaces.SingleCellBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={40,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      public
        Modelica.Blocks.Interfaces.RealInput u "Input signal connector"
          annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      equation
        connect(gain.u, u) annotation (Line(
            points={{-12,0},{-40,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(gain.y, controlBus.i) annotation (Line(
            points={{11,0},{40,0}},
            color={0,0,127},
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        annotation (Diagram(graphics), Icon(graphics));
      end IIn;

      model TempOut
        "Adaptor for reading the temperature of the battery from the SingleCellBus"
      extends Icons.AdaptorOut;

        Modelica.Blocks.Interfaces.RealOutput y
          "Temperature of the battery (Output)"
          annotation (Placement(transformation(extent={{30,-10},{50,10}},
                rotation=0)));

        EnergyStorages.Interfaces.SingleCellBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={-40,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      equation
        connect(gain.y, y)  annotation (Line(points={{11,0},{17,0},{40,0}},
                                               color={0,0,127}));
        connect(gain.u, controlBus.T) annotation (
          Text(
            string="%second",
            index=1,
            extent=[6,3; 6,3],
            style(color=0, rgbcolor={0,0,0})), Line(points={{-12,0},{-26,0},{
                -40,0}},                            color={0,0,127}));
        annotation (Diagram(graphics));
      end TempOut;

      model TempIn
        "Adaptor for feeding the temperature of the battery to the SingleCellBus"
      extends Icons.AdaptorIn;

        EnergyStorages.Interfaces.SingleCellBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={40,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={2,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      public
        Modelica.Blocks.Interfaces.RealInput u "Input signal connector"
          annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      equation
        connect(gain.u, u) annotation (Line(
            points={{-10,0},{-40,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(gain.y, controlBus.T) annotation (Line(
            points={{13,0},{40,0}},
            color={0,0,127},
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        annotation (Diagram(graphics), Icon(graphics));
      end TempIn;

      model VOut
        "Adaptor for reading the voltage of the battery from the SingleCellBus"
      extends Icons.AdaptorOut;

        Modelica.Blocks.Interfaces.RealOutput y
          "Voltage of the battery (Output)"
          annotation (Placement(transformation(extent={{30,-10},{50,10}},
                rotation=0)));

        EnergyStorages.Interfaces.SingleCellBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={-40,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      equation
        connect(gain.y, y)  annotation (Line(points={{11,0},{17,0},{40,0}},
                                               color={0,0,127}));
        connect(gain.u, controlBus.v) annotation (
          Text(
            string="%second",
            index=1,
            extent=[6,3; 6,3],
            style(color=0, rgbcolor={0,0,0})), Line(points={{-12,0},{-24,0},{
                -40,0}},                            color={0,0,127}));
        annotation (Diagram(graphics),
                             Icon(graphics));
      end VOut;

      model VIn
        "Adaptor for feeding the voltage of the battery to the SingleCellBus"
      extends Icons.AdaptorIn;

        EnergyStorages.Interfaces.SingleCellBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={40,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      public
        Modelica.Blocks.Interfaces.RealInput u "Input signal connector"
          annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      equation
        connect(gain.u, u) annotation (Line(
            points={{-12,0},{-40,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(gain.y, controlBus.v) annotation (Line(
            points={{11,0},{40,0}},
            color={0,0,127},
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        annotation (Diagram(graphics), Icon(graphics));
      end VIn;
      annotation (Icon(graphics={
            Ellipse(
              extent={{-63,13},{-53,3}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{37,13},{47,3}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-13,-27},{-3,-37}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}));
    end SingleCellBus;

    package ControlBus
    extends Modelica.Icons.Package;

      expandable connector Bus
        "Empty control bus that is adapted to the signals connected to it"
        extends Modelica.Icons.SignalBus;
      //the following variables are required up to the next **END**
        Modelica.SIunits.Voltage v "Cell voltage";
        Modelica.SIunits.Current i "Cell current";
        Modelica.SIunits.Temperature T "Cell temperature";
        Modelica.SIunits.Voltage OCV "Open circuit voltages";
        Real SOC "State of charge";
        Real SOH "State of health";
        Real cycles "Number of cycles";
        Modelica.SIunits.ElectricCharge C "Cell charge capacity";
      //  **END**

        annotation (
          Icon(graphics={Rectangle(
                extent={{-20,2},{22,-2}},
                lineColor={255,204,51},
                lineThickness=0.5)}),
          Diagram(graphics),
          Documentation(info="<html>
<p>
This connector defines the \"expandable connector\" ControlBus that
is used as bus in the
<a href=\"Modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a> example.
Note, this connector is \"empty\". When using it, the actual content is
constructed by the signals connected to this bus.
</p>
</html>"));

      end Bus;

      model VariableSwitch
        "Bus connector switch according to the integer input"
      parameter Integer ns=12 "Number of buses";
        SOCOut sOCOut[ns]
          annotation (Placement(transformation(extent={{-66,46},{-46,66}})));
        SOCIn sOCIn annotation (Placement(transformation(extent={{46,46},{66,66}})));
        EnergyStorages.Interfaces.ControlBus.SOHOut sOHOut[ns]
          annotation (Placement(transformation(extent={{-66,26},{-46,46}})));
        EnergyStorages.Interfaces.ControlBus.SOHIn sOHIn
                    annotation (Placement(transformation(extent={{46,26},{66,46}})));
        COut cOut[ns]
          annotation (Placement(transformation(extent={{-66,6},{-46,26}})));
        CIn cIn annotation (Placement(transformation(extent={{46,6},{66,26}})));
        CyclesOut cyclesOut[ns]
          annotation (Placement(transformation(extent={{-66,66},{-46,86}})));
        CyclesIn cyclesIn
          annotation (Placement(transformation(extent={{46,66},{66,86}})));
        OCVOut oCVOut[ns]
          annotation (Placement(transformation(extent={{-66,-14},{-46,6}})));
        OCVIn oCVIn annotation (Placement(transformation(extent={{46,-14},{66,6}})));
        VOut vOut[ns]
          annotation (Placement(transformation(extent={{-66,-34},{-46,-14}})));
        VIn vIn annotation (Placement(transformation(extent={{46,-34},{66,-14}})));
        IOut iOut[ns]
          annotation (Placement(transformation(extent={{-66,-54},{-46,-34}})));
        IIn iIn annotation (Placement(transformation(extent={{46,-54},{66,-34}})));
        TOut tOut[ns]
          annotation (Placement(transformation(extent={{-66,-74},{-46,-54}})));
        TIn tIn annotation (Placement(transformation(extent={{46,-74},{66,-54}})));
        Bus busA[ns] annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={-94,0})));
        Bus busB annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=270,
              origin={94,0})));
        Modelica.Blocks.Interfaces.IntegerInput i
          annotation (Placement(transformation(
              origin={0,90},
              extent={{-10,-10},{10,10}},
              rotation=270), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={0,90})));
      equation
      tOut[i].y=tIn.u;
      vOut[i].y=vIn.u;
      iOut[i].y=iIn.u;
      cOut[i].y=cIn.u;

      oCVOut[i].y=oCVIn.u;
      sOCOut[i].y=sOCIn.u;

      sOHOut[i].y=sOHIn.u;
      cyclesOut[i].y=cyclesIn.u;

        connect(busA, cyclesOut.controlBus) annotation (Line(
            points={{-94,0},{-80,0},{-80,76},{-60,76}},
            color={255,204,51},
            thickness=0.5,
            smooth=Smooth.None), Text(
            string="%first",
            index=-1,
            extent={{-6,3},{-6,3}}));
        connect(sOCOut.controlBus, busA) annotation (Line(
            points={{-60,56},{-80,56},{-80,0},{-94,0}},
            color={255,204,51},
            thickness=0.5,
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(sOHOut.controlBus, busA) annotation (Line(
            points={{-60,36},{-80,36},{-80,0},{-94,0}},
            color={255,204,51},
            thickness=0.5,
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(cOut.controlBus, busA) annotation (Line(
            points={{-60,16},{-80,16},{-80,0},{-94,0}},
            color={255,204,51},
            thickness=0.5,
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(oCVOut.controlBus, busA) annotation (Line(
            points={{-60,-4},{-80,-4},{-80,0},{-94,0}},
            color={255,204,51},
            thickness=0.5,
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(vOut.controlBus, busA) annotation (Line(
            points={{-60,-24},{-80,-24},{-80,0},{-94,0}},
            color={255,204,51},
            thickness=0.5,
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(iOut.controlBus, busA) annotation (Line(
            points={{-60,-44},{-80,-44},{-80,0},{-94,0}},
            color={255,204,51},
            thickness=0.5,
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(tOut.controlBus, busA) annotation (Line(
            points={{-60,-64},{-80,-64},{-80,0},{-94,0}},
            color={255,204,51},
            thickness=0.5,
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(cyclesIn.controlBus, busB) annotation (Line(
            points={{60.2,76},{80,76},{80,0},{94,0}},
            color={255,204,51},
            thickness=0.5,
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(sOCIn.controlBus, busB) annotation (Line(
            points={{60.2,56},{80,56},{80,0},{94,0}},
            color={255,204,51},
            thickness=0.5,
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(sOHIn.controlBus, busB) annotation (Line(
            points={{60.2,36},{80,36},{80,0},{94,0}},
            color={255,204,51},
            thickness=0.5,
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(cIn.controlBus, busB) annotation (Line(
            points={{60.2,16},{80,16},{80,0},{94,0}},
            color={255,204,51},
            thickness=0.5,
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(oCVIn.controlBus, busB) annotation (Line(
            points={{60.2,-4},{80,-4},{80,0},{94,0}},
            color={255,204,51},
            thickness=0.5,
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(vIn.controlBus, busB) annotation (Line(
            points={{60.2,-24},{80,-24},{80,0},{94,0}},
            color={255,204,51},
            thickness=0.5,
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(iIn.controlBus, busB) annotation (Line(
            points={{60.2,-44},{80,-44},{80,0},{94,0}},
            color={255,204,51},
            thickness=0.5,
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(tIn.controlBus, busB) annotation (Line(
            points={{60.2,-64},{80,-64},{80,0},{94,0}},
            color={255,204,51},
            thickness=0.5,
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        annotation (Diagram(graphics), Icon(graphics={
                                   Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid), Rectangle(
                extent={{88,-88},{-88,88}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={230,230,230},
                fillPattern=FillPattern.Solid),
              Ellipse(extent={{-44,4},{-36,-4}}),
              Line(points={{-90,0},{-44,0}}),
              Line(points={{-37,2},{40,50}}),
              Line(
                points={{0,84},{0,25}},
                color={255,128,0},
                pattern=LinePattern.Dash),
              Text(extent={{-60,-30},{70,-90}}, textString=
                                                   "%name"),
              Line(points={{40,0},{90,0}}),
              Text(
                extent={{10,66},{80,88}},
                lineColor={255,128,0},
                textString=
                     "control")}));
      end VariableSwitch;

      model SOCOut
        "Adaptor for reading the SOC of the battery from the ControlBus"
      extends Icons.AdaptorOut;

        Modelica.Blocks.Interfaces.RealOutput y
          "Current of the battery (Output)"
          annotation (Placement(transformation(extent={{30,-10},{50,10}},
                rotation=0)));

        EnergyStorages.Interfaces.ControlBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={-40,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      equation
        connect(gain.y, y)  annotation (Line(points={{11,0},{17,0},{40,0}},
                                               color={0,0,127}));
        connect(gain.u, controlBus.SOC) annotation (
          Text(
            string="%second",
            index=1,
            extent=[6,3; 6,3],
            style(color=0, rgbcolor={0,0,0})), Line(points={{-12,0},{-26,0},{
                -40,0}},                            color={0,0,127}));
        annotation (Diagram(graphics));
      end SOCOut;

      model SOCIn
        "Adaptor for feeding the SOC of the battery to the ControlBus"
      extends Icons.AdaptorIn;

        EnergyStorages.Interfaces.ControlBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={42,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      public
        Modelica.Blocks.Interfaces.RealInput u "Input signal connector"
          annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      equation
        connect(gain.u, u) annotation (Line(
            points={{-12,0},{-40,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(gain.y, controlBus.SOC) annotation (Line(
            points={{11,0},{42,0}},
            color={0,0,127},
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        annotation (Diagram(graphics));
      end SOCIn;

      model SOHOut
        "Adaptor for reading the SOS of the battery from the ControlBus"
      extends Icons.AdaptorOut;

        Modelica.Blocks.Interfaces.RealOutput y
          "Current of the battery (Output)"
          annotation (Placement(transformation(extent={{30,-10},{50,10}},
                rotation=0)));

        EnergyStorages.Interfaces.ControlBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={-40,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      equation
        connect(gain.y, y)  annotation (Line(points={{11,0},{17,0},{40,0}},
                                               color={0,0,127}));
        connect(gain.u, controlBus.SOH) annotation (Line(
            points={{-12,0},{-40,0}},
            color={0,0,127},
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        annotation (Diagram(graphics));
      end SOHOut;

      model SOHIn
        "Adaptor for feeding the SOS of the battery to the ControlBus"
      extends Icons.AdaptorIn;

        EnergyStorages.Interfaces.ControlBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={42,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      public
        Modelica.Blocks.Interfaces.RealInput u "Input signal connector"
          annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      equation
        connect(gain.u, u) annotation (Line(
            points={{-12,0},{-40,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(gain.y, controlBus.SOH) annotation (Line(
            points={{11,0},{42,0}},
            color={0,0,127},
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        annotation (Diagram(graphics));
      end SOHIn;

      model COut
        "Adaptor for reading the capacity of the battery from the ControlBus"
      extends Icons.AdaptorOut;

        Modelica.Blocks.Interfaces.RealOutput y
          "Charge capacity of the battery (Output)"
          annotation (Placement(transformation(extent={{30,-10},{50,10}},
                rotation=0)));

        EnergyStorages.Interfaces.ControlBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={-40,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      equation
        connect(gain.y, y)  annotation (Line(points={{11,0},{17,0},{40,0}},
                                               color={0,0,127}));
        connect(gain.u, controlBus.C) annotation (
          Text(
            string="%second",
            index=1,
            extent=[6,3; 6,3],
            style(color=0, rgbcolor={0,0,0})), Line(points={{-12,0},{-24,0},{
                -40,0}},                            color={0,0,127}));
        annotation (Diagram(graphics));
      end COut;

      model CIn
        "Adaptor for feeding the capacity of the battery to the ControlBus"
      extends Icons.AdaptorIn;

        EnergyStorages.Interfaces.ControlBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={42,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      public
        Modelica.Blocks.Interfaces.RealInput u "Input signal connector"
          annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      equation
        connect(gain.u, u) annotation (Line(
            points={{-12,0},{-40,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(gain.y, controlBus.C) annotation (Line(
            points={{11,0},{42,0}},
            color={0,0,127},
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        annotation (Diagram(graphics));
      end CIn;

      model CyclesOut
        "Adaptor for reading the cycles of the battery from the ControlBus"
      extends Icons.AdaptorOut;

        Modelica.Blocks.Interfaces.RealOutput y
          "Current of the battery (Output)"
          annotation (Placement(transformation(extent={{30,-10},{50,10}},
                rotation=0)));

        EnergyStorages.Interfaces.ControlBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={-40,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      equation
        connect(gain.y, y)  annotation (Line(points={{11,0},{17,0},{40,0}},
                                               color={0,0,127}));
        connect(gain.u, controlBus.cycles) annotation (Line(
            points={{-12,0},{-40,0}},
            color={0,0,127},
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        annotation (Diagram(graphics));
      end CyclesOut;

      model CyclesIn
        "Adaptor for feeding the cycles of the battery to the ControlBus"
      extends Icons.AdaptorIn;

        EnergyStorages.Interfaces.ControlBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={42,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      public
        Modelica.Blocks.Interfaces.RealInput u "Input signal connector"
          annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      equation
        connect(gain.u, u) annotation (Line(
            points={{-12,0},{-40,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(gain.y, controlBus.cycles) annotation (Line(
            points={{11,0},{42,0}},
            color={0,0,127},
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        annotation (Diagram(graphics));
      end CyclesIn;

      model OCVOut
        "Adaptor for reading the OCV of the battery from the ControlBus"
      extends Icons.AdaptorOut;

        Modelica.Blocks.Interfaces.RealOutput y
          "Current of the battery (Output)"
          annotation (Placement(transformation(extent={{30,-10},{50,10}},
                rotation=0)));

        EnergyStorages.Interfaces.ControlBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={-40,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      equation
        connect(gain.y, y)  annotation (Line(points={{11,0},{17,0},{40,0}},
                                               color={0,0,127}));
        connect(gain.u, controlBus.OCV) annotation (
          Text(
            string="%second",
            index=1,
            extent=[6,3; 6,3],
            style(color=0, rgbcolor={0,0,0})), Line(points={{-12,0},{-26,0},{
                -40,0}},                            color={0,0,127}));
        annotation (Diagram(graphics));
      end OCVOut;

      model OCVIn
        "Adaptor for feeding the OCV of the battery to the ControlBus"
      extends Icons.AdaptorIn;

        EnergyStorages.Interfaces.ControlBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={42,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      public
        Modelica.Blocks.Interfaces.RealInput u "Input signal connector"
          annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      equation
        connect(gain.u, u) annotation (Line(
            points={{-12,0},{-40,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(gain.y, controlBus.OCV) annotation (Line(
            points={{11,0},{42,0}},
            color={0,0,127},
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        annotation (Diagram(graphics));
      end OCVIn;

      model VOut
        "Adaptor for reading the voltage of the battery from the ControlBus"
      extends Icons.AdaptorOut;

        Modelica.Blocks.Interfaces.RealOutput y
          "Current of the battery (Output)"
          annotation (Placement(transformation(extent={{30,-10},{50,10}},
                rotation=0)));

        EnergyStorages.Interfaces.ControlBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={-40,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      equation
        connect(gain.y, y)  annotation (Line(points={{11,0},{17,0},{40,0}},
                                               color={0,0,127}));
        connect(gain.u, controlBus.v) annotation (
          Text(
            string="%second",
            index=1,
            extent=[6,3; 6,3],
            style(color=0, rgbcolor={0,0,0})), Line(points={{-12,0},{-25,0},{
                -40,0}},                            color={0,0,127}));
        annotation (Diagram(graphics));
      end VOut;

      model VIn
        "Adaptor for feeding the voltage of the battery to the ControlBus"
      extends Icons.AdaptorIn;

        EnergyStorages.Interfaces.ControlBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={42,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      public
        Modelica.Blocks.Interfaces.RealInput u "Input signal connector"
          annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      equation
        connect(gain.u, u) annotation (Line(
            points={{-12,0},{-40,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(gain.y, controlBus.v) annotation (Line(
            points={{11,0},{42,0}},
            color={0,0,127},
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        annotation (Diagram(graphics));
      end VIn;

      model IOut
        "Adaptor for reading the current of the battery from the ControlBus"
      extends Icons.AdaptorOut;

        Modelica.Blocks.Interfaces.RealOutput y
          "Current of the battery (Output)"
          annotation (Placement(transformation(extent={{30,-10},{50,10}},
                rotation=0)));

        EnergyStorages.Interfaces.ControlBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={-40,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      equation
        connect(gain.y, y)  annotation (Line(points={{11,0},{17,0},{40,0}},
                                               color={0,0,127}));
        connect(gain.u, controlBus.i) annotation (
          Text(
            string="%second",
            index=1,
            extent=[6,3; 6,3],
            style(color=0, rgbcolor={0,0,0})), Line(points={{-12,0},{-27,0},{
                -40,0}},                            color={0,0,127}));
        annotation (Diagram(graphics));
      end IOut;

      model IIn
        "Adaptor for feeding the current of the battery to the ControlBus"
      extends Icons.AdaptorIn;

        EnergyStorages.Interfaces.ControlBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={42,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      public
        Modelica.Blocks.Interfaces.RealInput u "Input signal connector"
          annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      equation
        connect(gain.u, u) annotation (Line(
            points={{-12,0},{-40,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(gain.y, controlBus.i) annotation (Line(
            points={{11,0},{42,0}},
            color={0,0,127},
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        annotation (Diagram(graphics));
      end IIn;

      model TOut
        "Adaptor for reading the temperature of the battery from the ControlBus"
      extends Icons.AdaptorOut;

        Modelica.Blocks.Interfaces.RealOutput y
          "Current of the battery (Output)"
          annotation (Placement(transformation(extent={{30,-10},{50,10}},
                rotation=0)));

        EnergyStorages.Interfaces.ControlBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={-40,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      equation
        connect(gain.y, y)  annotation (Line(points={{11,0},{17,0},{40,0}},
                                               color={0,0,127}));
        connect(gain.u, controlBus.T) annotation (
          Text(
            string="%second",
            index=1,
            extent=[6,3; 6,3],
            style(color=0, rgbcolor={0,0,0})), Line(points={{-12,0},{-23,0},{
                -40,0}},                            color={0,0,127}));
        annotation (Diagram(graphics));
      end TOut;

      model TIn
        "Adaptor for feeding the temperature of the battery to the ControlBus"
      extends Icons.AdaptorIn;

        EnergyStorages.Interfaces.ControlBus.Bus controlBus
          "This bus contains the voltage, the current and the temperature of the cell"
          annotation (Placement(transformation(
              origin={42,0},
              extent={{-20,20},{20,-20}},
              rotation=270)));
      protected
        Modelica.Blocks.Math.Gain gain
          annotation (Placement(transformation(
              origin={0,0},
              extent={{10,10},{-10,-10}},
              rotation=180)));
      public
        Modelica.Blocks.Interfaces.RealInput u "Input signal connector"
          annotation (Placement(transformation(extent={{-50,-10},{-30,10}}),
              iconTransformation(extent={{-50,-10},{-30,10}})));
      equation
        connect(gain.y, controlBus.T) annotation (Line(
            points={{11,0},{42,0}},
            color={0,0,127},
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(gain.u, u) annotation (Line(
            points={{-12,0},{-40,0}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(graphics), Icon(graphics));
      end TIn;
      annotation (Icon(graphics={
            Ellipse(
              extent={{-77,15},{-67,5}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-17,15},{-7,5}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{43,15},{53,5}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-47,-25},{-37,-35}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{13,-25},{23,-35}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}));
    end ControlBus;

  end Interfaces;

  package Sensors "Charge and energy sensors"
   extends Modelica.Icons.SensorsPackage;

    model ChargeCounter "Senses the transferred charge"
      extends Modelica.Icons.RotationalSensor;
      parameter Modelica.SIunits.ElectricCharge Charge_start=0
        "Initial transferred charge";
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
      Modelica.Electrical.Analog.Interfaces.PositivePin pin_p "positive pin"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
              rotation=0)));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "negative pin"
        annotation (Placement(transformation(extent={{90,-10},{110,10}},
              rotation=0)));
      Modelica.Blocks.Continuous.Integrator integrator(y_start=Charge_start)
        annotation (Placement(transformation(
            origin={0,-50},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.Blocks.Interfaces.RealOutput charge
        "Connector of Real output signal"
        annotation (Placement(transformation(
            origin={0,-110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(currentSensor.p, pin_p)
                                   annotation (Line(points={{-10,0},{-100,0}},
            color={0,0,255}));
      connect(currentSensor.n, pin_n)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(integrator.u, currentSensor.i) annotation (Line(points={{0,-38},{
              0,-24},{0,-10}},                                         color={0,
              0,127}));
      connect(charge, charge)
                          annotation (Line(points={{0,-110},{0,-110}},
            color={0,0,127}));
      connect(integrator.y, charge)
                                  annotation (Line(points={{0,-61},{0,-110}},
                                          color={0,0,127}));
      annotation (Diagram(graphics),
                           Icon(graphics={
            Line(points={{-70,0},{-90,0}}, color={0,0,255}),
            Line(points={{70,0},{90,0}}, color={0,0,255}),
            Line(points={{0,-100},{0,-70}}),
            Text(
              extent={{-30,-14},{32,-68}},
              lineColor={0,0,0},
              textString="Q"),
            Text(
              extent={{-68,140},{72,80}},
              lineColor={0,0,255},
              fillColor={122,255,107},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name")}));
    end ChargeCounter;

    model EnergyCounter "Senses the transferred energy"
      extends Modelica.Icons.RotationalSensor;
      parameter Modelica.SIunits.Energy Energy_start=0
        "Initial transferred energy";
      Modelica.Blocks.Continuous.Integrator integrator(y_start=Energy_start)
        annotation (Placement(transformation(
            origin={-80,-50},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.Blocks.Interfaces.RealOutput energy
        "Connector of Real output signal"
        annotation (Placement(transformation(
            origin={-80,-110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Electrical.Analog.Interfaces.PositivePin pin_pv
        "Positive pin, voltage path"
        annotation (Placement(transformation(extent={{-10,90},{10,110}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_nv
        "Negative pin, voltage path"
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
      Modelica.Electrical.Analog.Interfaces.PositivePin pin_pc
        "Positive pin, current path"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_nc
        "Negative pin, current path"
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    equation
      connect(integrator.y, energy)
                                  annotation (Line(points={{-80,-61},{-80,-62},{
              -80,-110}},                 color={0,0,127}));
      connect(powerSensor.power, integrator.u) annotation (Line(
          points={{-8,-11},{-8,-20},{-80,-20},{-80,-38}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(powerSensor.pv, pin_pv)
                                  annotation (Line(
          points={{0,10},{0,100}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(powerSensor.nv, pin_nv)
                                  annotation (Line(
          points={{0,-10},{0,-100}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(powerSensor.pc, pin_pc)
                                  annotation (Line(
          points={{-10,0},{-100,0}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(powerSensor.nc, pin_nc)
                                  annotation (Line(
          points={{10,0},{100,0}},
          color={0,0,255},
          smooth=Smooth.None));
      annotation (Diagram(graphics),
                           Icon(graphics={
            Line(points={{72,0},{-90,0}},  color={0,0,255}),
            Line(points={{70,0},{90,0}}, color={0,0,255}),
            Line(points={{0,-90},{0,-70}}),
            Line(points={{0,92},{0,70}}, color={0,0,255}),
            Text(
              extent={{-30,-10},{32,-64}},
              lineColor={0,0,0},
              textString="W"),
            Line(points={{-80,0},{-80,-100}},
                                         color={0,0,127}),
            Text(
              extent={{42,128},{182,68}},
              lineColor={0,0,255},
              fillColor={122,255,107},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name")}));
    end EnergyCounter;

    model AbsChargeCounter "Senses the absolute transferred charge"
      extends Modelica.Icons.RotationalSensor;
      parameter Modelica.SIunits.ElectricCharge Charge_start=0
        "Initial transferred charge";
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
      Modelica.Electrical.Analog.Interfaces.PositivePin p "positive pin"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
              rotation=0)));
      Modelica.Electrical.Analog.Interfaces.NegativePin n "negative pin"
        annotation (Placement(transformation(extent={{90,-10},{110,10}},
              rotation=0)));
      Modelica.Blocks.Interfaces.RealOutput absCharge
        "Connector of Real output signal"
        annotation (Placement(transformation(
            origin={0,-90},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Math.Abs abs1
        annotation (Placement(transformation(
            origin={0,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Continuous.Integrator integrator(k=1, y_start=
            Charge_start)
        annotation (Placement(transformation(
            origin={0,-60},
            extent={{10,-10},{-10,10}},
            rotation=90)));
    equation
      connect(currentSensor.p, p)  annotation (Line(points={{-10,0},{-100,0}},
            color={0,0,255}));
      connect(currentSensor.n, n)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(absCharge, absCharge)
                          annotation (Line(points={{0,-90},{0,-90}},
            color={0,0,127}));
      connect(currentSensor.i, abs1.u) annotation (Line(points={{0,-10},{0,-14},
              {0,-18}},                    color={0,0,127}));
      connect(abs1.y, integrator.u) annotation (Line(
          points={{0,-41},{0,-48}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(integrator.y, absCharge)
                               annotation (Line(
          points={{0,-71},{0,-90}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(graphics),
                           Icon(graphics={
            Text(
              extent={{-53,-9},{52,-66}},
              lineColor={0,0,0},
              textString="IQI"),
            Line(points={{-70,0},{-90,0}}, color={0,0,255}),
            Line(points={{70,0},{90,0}}, color={0,0,255}),
            Line(points={{0,-90},{0,-70}}),
            Text(
              extent={{-68,140},{72,80}},
              lineColor={0,0,255},
              fillColor={122,255,107},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name")}));
    end AbsChargeCounter;

    model AbsEnergyCounter "Senses the absolute transferred energy"
      extends Modelica.Icons.RotationalSensor;
      parameter Modelica.SIunits.Energy Energy_start=0
        "Initial transferred energy";
      Modelica.Blocks.Continuous.Integrator integrator(y_start=Energy_start)
        annotation (Placement(transformation(
            origin={-80,-70},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.Blocks.Interfaces.RealOutput energy
        "Connector of Real output signal"
        annotation (Placement(transformation(
            origin={-80,-110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Electrical.Analog.Interfaces.PositivePin pin_pv
        "Positive pin, voltage path"
        annotation (Placement(transformation(extent={{-10,90},{10,110}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_nv
        "Negative pin, voltage path"
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
      Modelica.Electrical.Analog.Interfaces.PositivePin pin_pc
        "Positive pin, current path"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_nc
        "Negative pin, current path"
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Blocks.Math.Abs abs
        annotation (Placement(transformation(
            origin={-80,-38},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(integrator.y, energy)
                                  annotation (Line(points={{-80,-81},{-80,-81},
              {-80,-110}},                color={0,0,127}));
      connect(powerSensor.pv, pin_pv)
                                  annotation (Line(
          points={{0,10},{0,100}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(powerSensor.nv, pin_nv)
                                  annotation (Line(
          points={{0,-10},{0,-100}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(powerSensor.pc, pin_pc)
                                  annotation (Line(
          points={{-10,0},{-100,0}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(powerSensor.nc, pin_nc)
                                  annotation (Line(
          points={{10,0},{100,0}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(abs.y, integrator.u) annotation (Line(
          points={{-80,-49},{-80,-58}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(abs.u, powerSensor.power) annotation (Line(
          points={{-80,-26},{-80,-20},{-8,-20},{-8,-11}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(graphics),
                           Icon(graphics={
            Line(points={{72,0},{-90,0}},  color={0,0,255}),
            Line(points={{70,0},{90,0}}, color={0,0,255}),
            Line(points={{0,-90},{0,-70}}),
            Line(points={{0,92},{0,70}}, color={0,0,255}),
            Text(
              extent={{-30,-10},{32,-64}},
              lineColor={0,0,0},
              textString="W"),
            Line(points={{-80,0},{-80,-100}},
                                         color={0,0,127}),
            Text(
              extent={{30,128},{170,68}},
              lineColor={0,0,255},
              fillColor={122,255,107},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name")}));
    end AbsEnergyCounter;

    model EnergyChargeCounter
      "Senses the transferred energy as well as the transferred charge"
      extends Modelica.Icons.RotationalSensor;
      parameter Modelica.SIunits.ElectricCharge Charge_start=0
        "Initial transferred charge";
      parameter Modelica.SIunits.Energy Energy_start=0
        "Initial transferred energy";
      Modelica.Electrical.Analog.Interfaces.PositivePin pin_pc "positive pin"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
              rotation=0)));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_nc "negative pin"
        annotation (Placement(transformation(extent={{90,-10},{110,10}},
              rotation=0)));
      Modelica.Blocks.Interfaces.RealOutput energy
        "Connector of Real output signal"
        annotation (Placement(transformation(
            origin={-60,-90},
            extent={{-10,-10},{10,10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-80,-90})));
      Modelica.Electrical.Analog.Interfaces.PositivePin pin_pv "positive pin"
        annotation (Placement(transformation(extent={{-10,90},{10,110}},
              rotation=0)));
      Modelica.Blocks.Interfaces.RealOutput charge
        "Connector of Real output signal"
        annotation (Placement(transformation(
            origin={40,-90},
            extent={{-10,-10},{10,10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={80,-90})));
      ChargeCounter chargeCounter(Charge_start=Charge_start)
        annotation (Placement(transformation(extent={{20,-20},{60,20}})));
      EnergyCounter energyCounter(Energy_start=Energy_start)
        annotation (Placement(transformation(extent={{-60,-20},{-20,20}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_nv
        "Negative pin, voltage path"
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    equation
      connect(energy, energy)
                          annotation (Line(points={{-60,-90},{-60,-90}}, color=
              {0,0,127}));
      connect(charge, charge)
                          annotation (Line(points={{40,-90},{40,-90}}, color={0,
              0,127}));

      connect(chargeCounter.charge, charge) annotation (Line(
          points={{40,-22},{40,-90}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(energyCounter.energy, energy) annotation (Line(
          points={{-56,-22},{-60,-22},{-60,-90}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(chargeCounter.pin_n, pin_nc) annotation (Line(
          points={{60,0},{100,0}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(chargeCounter.pin_p, energyCounter.pin_nc) annotation (Line(
          points={{20,0},{-20,0}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(energyCounter.pin_pc, pin_pc) annotation (Line(
          points={{-60,0},{-100,0}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(energyCounter.pin_pv, pin_pv) annotation (Line(
          points={{-40,20},{-20,20},{-20,100},{0,100}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(energyCounter.pin_nv, pin_nv) annotation (Line(
          points={{-40,-20},{-20,-20},{-20,-100},{0,-100}},
          color={0,0,255},
          smooth=Smooth.None));
      annotation (Diagram(graphics),
                           Icon(graphics={
            Line(points={{90,0},{-90,0}},  color={0,0,255}),
            Line(points={{70,0},{90,0}}, color={0,0,0}),
            Line(points={{80,-80},{80,0}}),
            Line(points={{0,92},{0,70}}, color={0,0,0}),
            Text(
              extent={{6,-2},{68,-56}},
              lineColor={0,0,0},
              textString="Q"),
            Line(points={{-80,-80},{-80,0}}),
            Text(
              extent={{-67,-3},{-10,-52}},
              lineColor={0,0,0},
              textString="W"),
            Line(points={{0,-70},{0,-90}},
                                         color={0,0,0}),
            Text(
              extent={{32,138},{172,78}},
              lineColor={0,0,255},
              fillColor={122,255,107},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name")}));
    end EnergyChargeCounter;

    model CellMeasurement
      "Current, voltage and temperature measurement for cells and stacks"
      extends Icons.Block;
      Modelica.Electrical.Analog.Interfaces.PositivePin pinCell_p
        annotation (Placement(transformation(extent={{-110,50},{-90,70}},
              rotation=0)));
      Modelica.Electrical.Analog.Interfaces.NegativePin pinCell_n
        annotation (Placement(transformation(extent={{-110,-70},{-90,-50}},
              rotation=0)));

      Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
        annotation (Placement(transformation(extent={{-10,90},{10,110}},
              rotation=0)));
      Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
        annotation (Placement(transformation(
            origin={-60,-40},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
        annotation (Placement(transformation(
            origin={0,70},
            extent={{10,10},{-10,-10}},
            rotation=270)));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "negative pin"
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
              rotation=0)));
      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor
        TemperatureSensor
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
              rotation=0)));
      Modelica.Blocks.Interfaces.RealOutput i
        "current in the branch from p to n as output signal"
        annotation (Placement(transformation(extent={{100,50},{120,70}},
              rotation=0)));
      Modelica.Blocks.Interfaces.RealOutput T
                                          annotation (Placement(
            transformation(extent={{100,-10},{120,10}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealOutput v
        "Voltage between pin p and n (= p.v - n.v) as output signal"
        annotation (Placement(transformation(extent={{100,-70},{120,-50}},
              rotation=0)));
    equation
      connect(pinCell_p, currentSensor.p)
        annotation (Line(points={{-100,60},{0,60}},             color={0,0,
              255}));
      connect(voltageSensor.n, pinCell_n)
                                      annotation (Line(points={{-60,-50},{-60,
              -60},{-100,-60}},     color={0,0,255}));
      connect(pin_p, currentSensor.n)  annotation (Line(points={{0,100},{0,80}},
                                      color={0,0,255}));
      connect(voltageSensor.p, currentSensor.p) annotation (Line(points={{-60,-30},
              {-60,60},{0,60}},                      color={0,0,255}));
      connect(pinCell_n, pin_n) annotation (Line(points={{-100,-60},{-100,-80},
              {0,-80},{0,-100}},      color={0,0,255}));
      connect(TemperatureSensor.port, heatPort) annotation (Line(points={{-10,0},
              {-100,0}},        color={191,0,0}));
      connect(currentSensor.i,i)  annotation (Line(points={{10,70},{56,70},{56,
              60},{110,60}},     color={0,0,127}));
      connect(TemperatureSensor.T, T) annotation (Line(points={{10,0},{110,0}},
                   color={0,0,127}));
      connect(voltageSensor.v,v)  annotation (Line(points={{-50,-40},{26,-40},{
              26,-60},{110,-60}},       color={0,0,127}));
      connect(i,i)  annotation (Line(points={{110,60},{110,60}}, color={0,0,
              127}));
      annotation (Diagram(graphics),
                           Icon(graphics={
            Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
            Line(points={{0,90},{0,60},{-20,60}}, color={0,0,0}),
            Ellipse(extent={{-60,80},{-20,40}}, lineColor={0,0,0}),
            Text(
              extent={{-60,80},{-20,40}},
              lineColor={0,0,0},
              textString=
                   "A"),
            Line(points={{-90,60},{-60,60}}, color={0,0,0}),
            Line(points={{0,-60},{-90,-60}}, color={0,0,0}),
            Line(points={{0,-20},{0,-90}}, color={0,0,0}),
            Line(points={{0,60},{0,20}}, color={0,0,0}),
            Ellipse(extent={{-20,20},{20,-20}}, lineColor={0,0,0}),
            Text(
              extent={{-20,20},{20,-20}},
              lineColor={0,0,0},
              textString=
                   "V"),
            Ellipse(extent={{-80,20},{-40,-20}}, lineColor={0,0,0}),
            Text(
              extent={{-80,20},{-40,-20}},
              lineColor={0,0,0},
              textString=
                   "T"),
            Line(points={{-80,0},{-90,0}}, color={0,0,0}),
            Text(
              extent={{50,80},{90,40}},
              lineColor={0,0,0},
              textString="i"),
            Text(
              extent={{50,20},{90,-20}},
              lineColor={0,0,0},
              textString=
                   "T"),
            Text(
              extent={{50,-40},{90,-80}},
              lineColor={0,0,0},
              textString="v")}));
    end CellMeasurement;
  end Sensors;

  package Sources "Contains loads and chargers"
    extends Modelica.Icons.SourcesPackage;
    package Loads "Package with different loads"
    extends Modelica.Icons.Package;
     extends EnergyStorages.Icons.Load;

      package Cycles "Standardized cycles"
       extends EnergyStorages.Icons.CyclesPackage;

        model FTP72
          "Federal Test Procedure: Urban Dynamometer Driving Schedule (UDDS)"
        extends EnergyStorages.Icons.Sink;
          Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent
            annotation (Placement(transformation(
                origin={40,10},
                extent={{-10,10},{10,-10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
            annotation (Placement(transformation(extent={{-10,90},{10,110}},
                  rotation=0)));
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
            annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.BooleanInput on
            "Connector of Boolean input signal"
            annotation (Placement(transformation(extent={{-100,-10},{-80,10}},
                  rotation=0)));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
            annotation (Placement(transformation(
                origin={80,-70},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Blocks.Math.Division division annotation (Placement(
                transformation(extent={{-20,0},{0,20}},    rotation=0)));
          parameter Real table[:,2] = [0,0;1,0;2,0;3,0;4,0;5,0;
            6,0;7,0;8,0;9,0;10,0;
            11,0;12,0;13,0;14,0;15,0;
            16,0;17,0;18,0;19,0;20,7.63E-15;
            21,2.656862299;22,5.066824278;23,6.919044302;24,9.92721153;25,11.99083842;
            26,13.28667893;27,2.948986157;28,5.137151842;29,16.40934905;30,7.516868387;
            31,5.908250322;32,2.157048719;33,-0.995107891;34,-2.198487625;35,-2.161427667;
            36,-1.557434624;37,-2.088169806;38,-12.35098315;39,-7.948784273;40,0.817499451;
            41,2.117771289;42,2.166091748;43,3.143999402;44,6.26306327;45,11.87475974;
            46,13.19569999;47,11.72513052;48,2.855969106;49,0.277692017;50,0.904958197;
            51,-6.363589501;52,-11.0799931;53,-8.109271371;54,-4.867712487;55,0.886824653;
            56,10.46680633;57,12.8893158;58,12.3191627;59,12.00772035;60,8.509745343;
            61,4.537143881;62,3.911765052;63,2.532362225;64,-0.976453428;65,1.0812139;
            66,3.177148783;67,2.500817595;68,1.101144937;69,1.091145544;70,1.780345304;
            71,5.361068592;72,5.497513442;73,2.644941662;74,-0.25017447;75,-1.669071408;
            76,2.532362225;77,4.731114217;78,6.336353546;79,1.965818968;80,-0.235128558;
            81,4.904488962;82,6.551950386;83,8.343637381;84,11.16181509;85,8.205760078;
            86,6.716255706;87,5.12200457;88,5.19826403;89,5.275273722;90,2.694977444;
            91,0.951372803;92,1.791488361;93,1.777192195;94,3.494876196;95,6.164012091;
            96,-0.763593295;97,-1.629908514;98,-0.813649371;99,5.046487368;100,6.870545952;
            101,6.135372417;102,4.46133192;103,3.616033726;104,1.864225701;105,-1.615287117;
            106,-2.467470057;107,3.396206249;108,5.147341381;109,6.995471304;110,7.153524107;
            111,8.236929137;112,6.573955157;113,4.818460446;114,1.161216183;115,-1.567435399;
            116,-22.49130079;117,-21.51938172;118,-18.86940338;119,-16.15374721;120,-13.38226452;
            121,-10.56480711;122,-7.71122688;123,-4.831375337;124,-1.935104277;125,-3.50282E-12;
            126,0;127,0;128,0;129,0;130,0;
            131,0;132,0;133,0;134,0;135,0;
            136,0;137,0;138,0;139,0;140,0;
            141,0;142,0;143,0;144,0;145,0;
            146,0;147,0;148,0;149,0;150,0;
            151,0;152,0;153,0;154,0;155,0;
            156,0;157,0;158,0;159,0;160,0;
            161,0;162,0;163,0;164,3.200194369;165,6.410240389;
            166,9.639989941;167,12.89929459;168,16.19800598;169,19.54597616;170,16.41978194;
            171,16.03903701;172,12.78077258;173,6.459117883;174,-3.115198616;175,-2.374217206;
            176,-0.974859065;177,3.933174589;178,3.270190504;179,3.307888855;180,4.829761684;
            181,12.80447373;182,-3.161607682;183,-15.10480141;184,-6.717964858;185,-16.73479315;
            186,-7.385146225;187,-1.407686368;188,5.644245974;189,3.731350062;190,9.104510165;
            191,15.17586056;192,17.554767;193,23.56615648;194,30.00422086;195,31.37224334;
            196,31.16944854;197,15.53427713;198,26.55164776;199,18.46231859;200,24.16384499;
            201,22.76816223;202,26.42478909;203,18.10320226;204,17.26562624;205,16.33635994;
            206,7.020957872;207,4.300084023;208,5.592980506;209,4.212060311;210,6.845587556;
            211,6.845587556;212,6.845587556;213,6.845587556;214,9.560080973;215,9.64156472;
            216,13.87348744;217,15.53422692;218,15.85777415;219,13.30255272;220,14.95138738;
            221,16.68797266;222,14.05693456;223,15.75817658;224,19.07038909;225,24.16331029;
            226,23.29511248;227,17.52724598;228,14.62976509;229,11.60224307;230,8.477397529;
            231,5.289749171;232,9.878810305;233,13.04036023;234,14.73844624;235,16.51252525;
            236,13.50761889;237,16.86267019;238,13.82598361;239,15.57296564;240,12.45278851;
            241,10.86426746;242,7.601665095;243,10.76750104;244,10.76750104;245,10.76750104;
            246,10.76750104;247,10.76750104;248,9.13923413;249,5.860690061;250,5.743763523;
            251,-0.698505663;252,2.230374967;253,3.624743419;254,6.58373148;255,4.963409033;
            256,7.931230103;257,14.09534591;258,11.12236337;259,11.16968066;260,9.654001849;
            261,4.99907654;262,3.361220902;263,3.232982113;264,3.107067348;265,1.493270362;
            266,13.32133575;267,2.92251612;268,7.254387981;269,5.729048631;270,5.658319597;
            271,10.0305283;272,11.56959204;273,13.17044223;274,14.84277344;275,16.5967319;
            276,16.88346888;277,17.17387278;278,23.85831694;279,18.00680173;280,13.45509413;
            281,16.80393012;282,10.52829073;283,7.307069946;284,0.874541781;285,-0.854647819;
            286,-4.082136394;287,-7.220020796;288,-5.884373961;289,8.543993067;290,8.543993067;
            291,2.655293037;292,-6.050005745;293,6.546513201;294,9.389747977;295,6.546513202;
            296,2.235037797;297,6.368531676;298,7.755335762;299,7.755335762;300,2.101797043;
            301,0.610331872;302,0.497795072;303,-4.985954469;304,-7.669023658;305,-7.692067385;
            306,-8.927306102;307,-8.884523638;308,-7.667847129;309,-8.755922569;310,-15.08609668;
            311,-11.5799748;312,-14.18415221;313,-9.981393829;314,-8.814951099;315,-5.988296893;
            316,-5.038045778;317,1.805868249;318,-1.627149454;319,-5.713441874;320,-9.376638763;
            321,-16.9536642;322,-18.46191898;323,-6.613828488;324,-4.17854971;325,-1.993153256;
            326,-6.159392554;327,-5.650441148;328,-9.857827863;329,-4.603227774;330,-5.894468909;
            331,-4.130382136;332,-1.231614217;333,0;334,0;335,0;
            336,0;337,0;338,0;339,0;340,0;
            341,0;342,0;343,0;344,0;345,0;
            346,4.57589E-13;347,0.324930308;348,4.171443367;349,7.386419831;350,10.624085;
            351,13.89429084;352,16.0353751;353,16.3887344;354,17.28582211;355,9.635959939;
            356,12.44831303;357,12.4827907;358,14.07930661;359,18.5445484;360,9.615613756;
            361,9.937444046;362,7.443430289;363,9.511696169;364,10.76658307;365,12.11814552;
            366,4.409297334;367,6.436308902;368,2.506923034;369,0.51941915;370,5.405191696;
            371,11.58835847;372,8.784622664;373,3.741698266;374,3.741698266;375,3.741698266;
            376,3.741698266;377,3.741698266;378,4.775370456;379,6.89081058;380,4.87671245;
            381,2.811644975;382,-0.292641342;383,-5.304798;384,-6.216833082;385,-2.41535046;
            386,-15.65512214;387,-17.08803827;388,-21.83565488;389,-15.81357266;390,-14.06563098;
            391,-12.70045477;392,-11.39930533;393,-7.78925633;394,-7.624294883;395,-4.743801088;
            396,-1.847186252;397,0;398,0;399,0;400,0;
            401,0;402,2.67029E-12;403,2.010978954;404,5.728007677;405,8.952754472;
            406,12.20496661;407,15.49449573;408,18.83119389;409,22.22491246;410,20.04251654;
            411,6.214729453;412,16.8185521;413,14.59833713;414,10.98016173;415,3.435426484;
            416,1.734800219;417,0.028983707;418,-0.823876327;419,-1.654910703;420,-4.020437795;
            421,-19.18022902;422,-18.6250916;423,-15.90395297;424,-13.12788379;425,-10.30673543;
            426,-7.450359702;427,-4.568608433;428,-1.671333197;429,0;430,0;
            431,0;432,0;433,0;434,0;435,0;
            436,0;437,0;438,0;439,0;440,0;
            441,0;442,0;443,0;444,0;445,0;
            446,0;447,4.89925E-12;448,3.200194369;449,6.410240389;450,9.639989941;
            451,12.89929459;452,16.19800598;453,19.54597616;454,22.95305652;455,26.42909869;
            456,13.12884131;457,13.02585526;458,24.01710355;459,16.98582574;460,8.883891257;
            461,15.1814732;462,6.495645135;463,8.640431212;464,8.820916562;465,2.733113477;
            466,4.775370456;467,4.800557053;468,1.724528462;469,0.674892003;470,6.76745286;
            471,3.741698266;472,-0.335974304;473,2.637167573;474,2.618271221;475,1.594598035;
            476,3.566941843;477,3.566941843;478,3.566941843;479,3.566941843;480,3.566941843;
            481,1.563086101;482,4.528904576;483,4.553113637;484,6.615474687;485,0.608426021;
            486,1.563086101;487,3.524223192;488,3.524223192;489,1.531957519;490,1.501210757;
            491,2.452540212;492,-6.169527386;493,-10.51952811;494,-13.43035419;495,-14.21835171;
            496,-15.96234367;497,-17.38428341;498,-13.73732524;499,-14.31168689;500,-11.50845972;
            501,-7.857888357;502,-5.914173204;503,-3.404266842;504,-0.795719559;505,0;
            506,0;507,0;508,0;509,0;510,2.5503E-12;
            511,0.457179488;512,2.413794392;513,3.335360609;514,2.124297628;515,5.170959519;
            516,3.428271735;517,3.170009555;518,5.276694851;519,8.988259393;520,9.867898699;
            521,9.475031174;522,8.083119793;523,7.464335702;524,6.65736864;525,7.633966206;
            526,8.028253406;527,7.014636637;528,6.572398214;529,4.609369532;530,2.532362225;
            531,1.831956121;532,1.831956121;533,1.831956121;534,1.831956121;535,1.831956122;
            536,6.214729452;537,3.384123323;538,3.422663827;539,-0.957429853;540,-0.965866084;
            541,0.431143758;542,1.831956121;543,1.831956121;544,-2.346632981;545,-6.817007417;
            546,-17.06565542;547,-14.31168689;548,-11.50845972;549,-8.665825846;550,-5.793636748;
            551,-2.90174422;552,0;553,0;554,0;555,0;
            556,0;557,0;558,0;559,0;560,0;
            561,0;562,0;563,0;564,0;565,0;566,0;567,0;
            568,8.95959E-12;569,3.200194369;570,6.410240389;
            571,9.639989941;572,11.97231592;573,7.339731434;574,7.17833896;575,5.747512387;
            576,0.984750347;577,0.984750347;578,3.478927766;579,2.036717573;580,1.044942419;
            581,0.046937528;582,-1.39663062;583,0.502865454;584,-0.443822877;585,2.889855163;
            586,1.472284985;587,0.508474196;588,-0.908892634;589,0.480891466;590,0.943159597;
            591,1.416455943;592,2.889855163;593,3.994715778;594,5.781355304;595,4.947435838;
            596,6.939262993;597,6.069027381;598,1.963986656;599,1.977391789;600,3.847049661;
            601,3.935821564;602,4.025558433;603,2.157048719;604,1.526683225;605,1.526683225;
            606,2.821567271;607,8.307989819;608,11.68993878;609,8.521620753;610,5.747558789;
            611,5.88900271;612,-4.60142366;613,-19.51822817;614,-16.81758906;615,-14.05873551;
            616,-11.25151887;617,-8.405790945;618,-5.53140359;619,-2.638208358;620,0;
            621,0;622,0;623,0;624,0;625,0;
            626,0;627,0;628,0;629,0;630,0;
            631,0;632,0;633,0;634,0;635,0;
            636,0;637,0;638,0;639,0;640,0;
            641,0;642,0;643,0;644,0;645,6.99602E-12;
            646,1.210459708;647,3.357240952;648,7.581896952;649,7.363029504;650,8.702935779;
            651,6.634894622;652,6.420321844;653,11.81376128;654,12.752064;655,9.599074538;
            656,8.9562538;657,8.800535288;658,10.00438843;659,7.541871176;660,4.063081741;
            661,4.879508686;662,2.710816718;663,2.72746367;664,1.993438074;665,3.500602336;
            666,2.777836743;667,2.035406106;668,-1.676293098;669,-1.674057881;670,-10.90648451;
            671,-11.78521976;672,-13.9140663;673,-8.713817167;674,-6.930713934;675,-8.834571475;
            676,-6.649329531;677,-4.444029625;678,-2.096821389;679,-0.750677585;680,
            0;681,0;682,0;683,0;684,0;685,0;
            686,0;687,0;688,0;689,0;690,0;
            691,0;692,0;693,5.58055E-12;694,0.611854826;695,1.905843762;
            696,1.556655875;697,4.127459248;698,7.406257621;699,7.219541316;700,9.036988353;
            701,5.294545428;702,9.205374339;703,2.363272215;704,0.018623437;705,0.943159598;
            706,9.757613801;707,6.56117162;708,6.338082562;709,9.848498576;710,7.830338722;
            711,1.526683225;712,-0.99510789;713,5.365442524;714,5.536642551;715,2.960689899;
            716,-4.776972272;717,-4.019912508;718,-5.007236666;719,-11.53584973;720,-11.78227588;
            721,-9.470231203;722,-7.128579435;723,-4.575453951;724,-1.937829727;725,-1.125331027;
            726,-0.435167407;727,-0.201763184;728,0.022366789;729,2.565211789;730,6.312726537;
            731,8.807391157;732,10.80415425;733,6.634894622;734,9.867898699;735,11.15731028;
            736,10.00647183;737,12.86024509;738,11.95107628;739,11.37718455;740,9.042156622;
            741,9.459711637;742,6.676752664;743,6.061181182;744,4.584981296;745,5.472642767;
            746,4.751697708;747,2.347903781;748,-0.077375731;749,1.495734103;750,0.686291747;
            751,-1.672170762;752,-3.17781995;753,-7.389372165;754,-11.52370964;755,-10.63137793;
            756,-12.1446105;757,-10.61354225;758,-5.861573805;759,-7.756609315;760,-7.705596946;
            761,-5.270256885;762,-2.554159625;763,-0.563128117;764,0.067237436;765,-0.117714446;
            766,-3.02466E-11;767,2.656862299;768,6.117751911;769,9.345303105;770,12.60151373;
            771,13.723869;772,9.362339697;773,5.747002588;774,7.220350745;775,8.290240589;
            776,9.483038458;777,9.4078126;778,14.43926724;779,13.17186432;780,9.88453098;
            781,6.177476124;782,4.679783058;783,7.253326716;784,2.395309621;785,2.395309621;
            786,1.572560984;787,-0.063130045;788,0.715483978;789,2.301203574;790,2.301203574;
            791,1.495734102;792,-2.444551408;793,1.409616266;794,2.180063152;795,2.180063152;
            796,2.180063152;797,2.180063152;798,2.180063152;799,2.968187482;800,5.393021113;
            801,6.324574338;802,15.18259872;803,11.43256662;804,11.89346941;805,12.36314504;
            806,3.11778344;807,8.883891256;808,7.126552589;809,6.260587616;810,2.399009027;
            811,1.411238145;812,3.316342959;813,2.346321424;814,0.411778186;815,-1.49946105;
            816,2.193247382;817,-1.530727012;818,-1.55432898;819,2.016088009;820,0.198996594;
            821,1.954309112;822,-5.038045778;823,-2.467636778;824,1.720834662;825,2.558520362;
            826,2.558520362;827,2.558520361;828,0.02086629;829,1.665788421;830,2.492267808;
            831,0.817875763;832,-0.843368564;833,-3.244614759;834,-1.670359715;835,-3.18826124;
            836,-8.818200775;837,-10.28359157;838,-9.007684476;839,-7.304568942;840,-5.810802993;
            841,1.182052265;842,6.338082562;843,6.036126289;844,4.402567715;845,5.168536444;
            846,5.337128444;847,5.507951124;848,7.084066219;849,8.836017784;850,9.250043264;
            851,6.520933274;852,2.049540377;853,3.57969881;854,3.619686765;855,3.65997079;
            856,6.898027911;857,4.632228023;858,8.027504176;859,3.204979077;860,3.223740919;
            861,3.242581893;862,1.598798576;863,-4.814850385;864,-2.442617648;865,-1.675383887;
            866,-6.735345035;867,-3.771293334;868,-1.664378334;869,3.890423459;870,3.954652978;
            871,4.755670789;872,3.364959298;873,5.663566385;874,7.367841263;875,6.80274378;
            876,4.561472974;877,7.09066072;878,7.286096684;879,4.07957734;880,1.612036302;
            881,1.598798576;882,1.585639984;883,-0.861593003;884,-0.87856773;885,1.470746583;
            886,2.255201594;887,-0.898054558;888,-0.912280767;889,-2.421852688;890,5.132564119;
            891,6.032297066;892,4.561472974;893,3.824111265;894,0.667214688;895,3.824111266;
            896,2.255201594;897,2.255201594;898,-0.118259616;899,-0.137672715;900,-1.675803362;
            901,-0.186156239;902,1.292975637;903,2.035406107;904,2.035406106;905,0.533700622;
            906,1.259412314;907,1.993438074;908,-0.224745869;909,-0.240213842;910,1.91143387;
            911,4.128978795;912,1.215665864;913,-0.24522927;914,-4.422451765;915,-5.598273421;
            916,-6.592763237;917,-2.204459751;918,1.426445896;919,2.045295364;920,7.236630079;
            921,6.876558219;922,5.739286348;923,3.085799867;924,3.122138334;925,5.306974167;
            926,3.251445092;927,2.564180994;928,2.580193864;929,3.326842337;930,-0.259856574;
            931,0.431143758;932,1.831956121;933,1.831956121;934,-0.282857679;935,0.394815764;
            936,0.380756633;937,1.742346251;938,3.140407998;939,5.333986952;940,1.831956121;
            941,-0.976453427;942,1.780345303;943,-1.658610637;944,4.513204115;945,6.064276321;
            946,5.497513441;947,-1.671009479;948,-5.691342471;949,-10.85675687;950,-9.429461277;
            951,-14.17484623;952,-11.85053979;953,-9.01215768;954,-6.143026386;955,-3.252997453;
            956,-0.351922676;957,0;958,0;959,1.33819E-11;960,1.210459709;
            961,5.143871183;962,8.364682608;963,11.61116833;964,14.89317987;965,12.30404555;
            966,6.857963144;967,9.104510165;968,7.875414701;969,7.017608697;970,8.028253407;
            971,12.06358268;972,15.27024653;973,11.42542458;974,6.993997756;975,4.703676541;
            976,3.130722146;977,2.332259009;978,2.332259008;979,-3.99850995;980,0.639169552;
            981,-0.150238756;982,-0.925313752;983,-0.19188547;984,-1.676293098;985,-0.235128558;
            986,-1.671875438;987,-6.363732331;988,-10.85675686;989,-1.596138375;990,1.415608141;
            991,3.280561829;992,5.939242101;993,4.806385041;994,0.283655184;995,1.56119606;
            996,2.873264051;997,-0.358276724;998,1.549629644;999,1.549629645;1000,6.910980764;
            1001,5.066896489;1002,5.915543247;1003,3.195620605;1004,3.954652978;1005,4.755670789;
            1006,2.62864988;1007,1.183599341;1008,-1.67007471;1009,-4.359376875;1010,-0.987800878;
            1011,-1.641795109;1012,-0.351891136;1013,-0.99477903;1014,-1.61139533;1015,-0.99415787;
            1016,-5.007236667;1017,-13.68102342;1018,-12.36253584;1019,-9.530803003;1020,-6.666529624;
            1021,-3.779567525;1022,-0.879768297;1023,0;1024,0;1025,0;
            1026,0;1027,0;1028,0;1029,0;1030,0;
            1031,0;1032,0;1033,0;1034,0;1035,0;
            1036,0;1037,0;1038,0;1039,0;1040,0;
            1041,0;1042,0;1043,0;1044,0;1045,0;
            1046,0;1047,0;1048,0;1049,0;1050,0;
            1051,0;1052,7.45565E-12;1053,0.457179489;1054,3.319632439;1055,7.093359665;
            1056,10.32855526;1057,13.5953957;1058,15.74931251;1059,8.891158636;1060,9.664835174;
            1061,12.44187462;1062,9.317000781;1063,8.428846089;1064,7.364438044;1065,7.649161314;
            1066,8.717281001;1067,4.330534154;1068,6.77113378;1069,6.148287894;1070,5.472642766;
            1071,-0.098163265;1072,-1.672170762;1073,-1.675383886;1074,2.106809411;1075,-3.150435814;
            1076,-10.58755302;1077,-11.08062791;1078,-4.607884892;1079,-3.873524458;1080,-12.04014224;
            1081,-11.78227588;1082,-8.669090568;1083,-3.172861505;1084,-0.956389014;1085,-1.188063542;
            1086,-0.866737999;1087,-0.578389324;1088,-0.555795769;1089,0.172732015;1090,0.917777197;
            1091,0.940099669;1092,-0.312054445;1093,0.172732015;1094,-0.963609432;1095,-1.632410642;
            1096,-2.572302701;1097,-0.750127771;1098,-1.048395229;1099,-0.403492108;1100,-2.24303E-12;
            1101,0.007273885;1102,0.110891907;1103,0.520002539;1104,2.180301241;1105,6.70289181;
            1106,9.177947785;1107,10.70928487;1108,5.45821228;1109,2.818940023;1110,7.626598967;
            1111,11.72937477;1112,11.90613496;1113,7.245709766;1114,2.571336297;1115,1.990855307;
            1116,2.004376948;1117,3.261200495;1118,6.569607736;1119,4.806385042;1120,7.014636637;
            1121,6.572398214;1122,5.333986953;1123,1.121346822;1124,1.11121173;1125,3.232768485;
            1126,4.731114217;1127,4.829761683;1128,3.422663828;1129,4.979860027;1130,3.540004732;
            1131,4.353293055;1132,2.863248004;1133,2.106809412;1134,2.106809412;1135,1.338744846;
            1136,1.327192445;1137,2.078027956;1138,-0.19188547;1139,1.281715469;1140,-0.947870587;
            1141,-1.67405788;1142,-4.422451765;1143,-5.598273421;1144,-10.63137793;1145,-7.144913072;
            1146,-11.22960184;1147,-5.821199626;1148,-7.093066322;1149,-9.358037796;1150,-6.492108991;
            1151,-3.604088396;1152,-0.703827807;1153,0;1154,0;1155,0;
            1156,0;1157,0;1158,0;1159,0;1160,0;
            1161,0;1162,0;1163,0;1164,0;1165,0;
            1166,0;1167,0;1168,3.13906E-12;1169,1.329856139;1170,5.241189342;
            1171,8.462634102;1172,11.71005147;1173,14.99329342;1174,18.32221142;1175,16.15141402;
            1176,13.82761652;1177,4.935835405;1178,-1.637351687;1179,-1.625144524;1180,-12.7481624;
            1181,-14.48009544;1182,-11.67957319;1183,-8.839047172;1184,-5.96836885;1185,-3.077390025;
            1186,-0.175962436;1187,0;1188,0;1189,0;1190,0;
            1191,0;1192,0;1193,0;1194,0;1195,0;
            1196,7.11805E-14;1197,0.020151296;1198,0.613554256;1199,2.119623784;1200,5.766409694;
            1201,9.541734229;1202,8.011906864;1203,3.927683736;1204,1.045979638;1205,-0.757123043;
            1206,1.385477852;1207,1.789613409;1208,0.688574932;1209,4.281529939;1210,7.377113743;
            1211,8.128893355;1212,9.463474083;1213,7.301462315;1214,9.010733279;1215,4.427354793;
            1216,3.280561829;1217,1.448299325;1218,-0.391439742;1219,-0.39838598;1220,3.222656159;
            1221,3.280561829;1222,2.703106683;1223,0.84575966;1224,0.221437734;1225,0.210909642;
            1226,1.415608141;1227,0.805281564;1228,-6.050701855;1229,-2.067035049;1230,-0.431683638;
            1231,3.417050595;1232,2.349603763;1233,2.380610942;1234,-1.520718288;1235,-8.778180258;
            1236,-7.821700264;1237,-8.423511865;1238,-7.91196282;1239,-4.101429081;1240,-3.083747725;
            1241,-2.059486996;1242,-0.938089975;1243,-0.32168353;1244,-3.78303E-12;1245,0;
            1246,0;1247,0;1248,0;1249,0;1250,0;
            1251,0;1252,0.324930308;1253,0.044767844;1254,0.044767844;1255,0.044767844;
            1256,0.044767844;1257,0.340698567;1258,1.312082452;1259,1.302462656;1260,1.630134324;
            1261,2.587704792;1262,4.191379999;1263,6.096160618;1264,1.993327234;1265,-2.197509774;
            1266,-1.973183435;1267,-1.556366212;1268,3.383206902;1269,7.332688528;1270,12.5183065;
            1271,15.27303636;1272,14.86878613;1273,10.18741566;1274,6.334332852;1275,3.980568281;
            1276,6.739506031;1277,5.623101163;1278,5.093304805;1279,4.513204115;1280,1.767611881;
            1281,-1.65700286;1282,-1.647982703;1283,1.643926425;1284,1.643926425;1285,1.643926425;
            1286,1.643926425;1287,1.643926425;1288,5.066896489;1289,2.392538567;1290,4.513204115;
            1291,3.177148783;1292,3.933174589;1293,4.731114217;1294,3.34586573;1295,2.644941662;
            1296,4.151086338;1297,3.461489267;1298,8.158318824;1299,8.45573126;1300,6.265502477;
            1301,8.098567764;1302,3.242581894;1303,1.598798577;1304,-5.589347641;1305,-21.04289661;
            1306,-18.3802443;1307,-15.65370497;1308,-12.8731304;1309,-10.04837256;1310,-7.189282895;
            1311,-4.305713201;1312,-1.407515246;1313,-6.35671E-11;1314,0;1315,0;
            1316,0;1317,0;1318,0;1319,0;1320,0;
            1321,0;1322,0;1323,0;1324,0;1325,0;
            1326,0;1327,0;1328,0;1329,0;1330,0;
            1331,0;1332,0;1333,0;1334,0;1335,0;
            1336,0;1337,0;1338,0.697602998;1339,4.65749275;1340,7.87527368;
            1341,11.11723606;1342,7.352077671;1343,8.870473291;1344,8.96941633;1345,8.78888414;
            1346,7.766667629;1347,5.839912393;1348,7.361569846;1349,5.140650299;1350,2.719846498;
            1351,3.397994564;1352,-0.995037958;1353,-0.994157869;1354,-1.582870251;1355,-2.135571384;
            1356,-1.541663615;1357,-0.975896978;1358,-4.584656071;1359,-3.875336982;1360,-3.679521202;
            1361,-3.479181935;1362,-5.131929056;1363,-8.692604712;1364,-6.342728867;1365,-3.840186021;
            1366,-1.778577377;1367,-2.41891E-10;1368,0;1369,0;1370,0]
            "FTP72 power table (time = first column; power in kW= second columns e.g. table=[0,2])";
          Components.FTP72_Power fTP72_Power(gain=gain, table=table)
            annotation (Placement(transformation(extent={{-60,6},{-40,26}})));
          parameter Modelica.Blocks.Interfaces.RealOutput gain=1 "Gain";
        equation
          connect(signalCurrent.p, pin_p)
                                       annotation (Line(points={{40,20},{40,100},{0,100}},
                            color={0,0,255}));
          connect(signalCurrent.n, pin_n)
                                       annotation (Line(points={{40,0},{40,-100},{0,-100}},
                             color={0,0,255}));
          connect(pin_p, voltageSensor.p)
                                       annotation (Line(points={{0,100},{80,100},
                  {80,-60}}, color={0,0,255}));
          connect(voltageSensor.n, pin_n)
                                       annotation (Line(points={{80,-80},{80,-100},
                  {0,-100}}, color={0,0,255}));
          connect(voltageSensor.v, division.u2) annotation (Line(points={{70,-70},{-30,-70},
                  {-30,4},{-22,4}},               color={0,0,127}));
          connect(fTP72_Power.y, division.u1) annotation (Line(
              points={{-39,16},{-22,16}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(on, fTP72_Power.on) annotation (Line(
              points={{-90,0},{-50,0},{-50,7}},
              color={255,0,255},
              smooth=Smooth.None));
          connect(division.y, signalCurrent.i) annotation (Line(
              points={{1,10},{17,10},{17,10},{33,10}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (Icon(graphics={
                Line(points={{0,-40},{0,-90}}, color={0,0,0}),
                Line(points={{0,-90},{0,-40}}, color={0,0,0}),
                Text(
                  extent={{-88,88},{-16,60}},
                  lineColor={0,0,0},
                  textString="FTP72"),
                Text(
                  extent={{-104,18},{-16,-16}},
                  lineColor={255,0,255},
                  textString="on")}),
              Diagram(graphics));
        end FTP72;

        model Liberal "Aging accelerating test cycle"

        extends EnergyStorages.Icons.Sink;
          Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent
            annotation (Placement(transformation(
                origin={40,30},
                extent={{-10,10},{10,-10}},
                rotation=270)));
          Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
            annotation (Placement(transformation(extent={{-10,90},{10,110}},
                  rotation=0)));
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
            annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
                  rotation=0)));
          parameter Modelica.SIunits.ElectricCharge Cn
            "Rated capacity of the battery";
          parameter Real C=2 "Max discharge rate";
          Modelica.Blocks.Math.Product product annotation (Placement(
                transformation(extent={{-20,14},{0,34}}, rotation=0)));
          Modelica.Blocks.Sources.RealExpression realExpression(y=C)
            annotation (Placement(transformation(extent={{-60,-30},{-40,-10}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.BooleanInput on
            "Connector of Boolean input signal"
            annotation (Placement(transformation(extent={{-100,-10},{-80,10}},
                  rotation=0)));
          Components.Liberal liberal1(Cn=Cn)
            annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
        equation
          connect(signalCurrent.p, pin_p)
                                       annotation (Line(points={{40,40},{40,100},
                  {0,100}}, color={0,0,255}));
          connect(signalCurrent.n, pin_n)
                                       annotation (Line(points={{40,20},{40,-100},
                  {0,-100}}, color={0,0,255}));
          connect(product.y, signalCurrent.i) annotation (Line(points={{1,24},{20,
                  24},{20,30},{33,30}}, color={0,0,127}));
          connect(realExpression.y, product.u2) annotation (Line(points={{-39,-20},
                  {-30,-20},{-30,18},{-22,18}}, color={0,0,127}));
          connect(liberal1.y, product.u1) annotation (Line(
              points={{-49,30},{-22,30}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(on, liberal1.on) annotation (Line(
              points={{-90,0},{-60,0},{-60,21}},
              color={255,0,255},
              smooth=Smooth.None));
          annotation (Icon(graphics={
                Text(
                  extent={{-90,90},{-10,60}},
                  lineColor={0,0,0},
                  textString=
                       "Liberal")}),
                               Diagram(graphics));
        end Liberal;

        package Components "Components for the cycles"

          extends EnergyStorages.Icons.ComponentPackage;
          model FTP72_Power "FTP72 cycle definition"
          extends EnergyStorages.Icons.Block;
            Modelica.Blocks.Sources.CombiTimeTable FTP72_Table(
              tableName="tab1",
              fileName="FTP72.txt",
              extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
              smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
              tableOnFile=false,
              table=table)
              annotation (Placement(transformation(extent={{-60,-60},{-40,-40}},
                    rotation=0)));
            Modelica.Blocks.Math.Product product annotation (Placement(
                  transformation(extent={{-20,30},{0,10}}, rotation=0)));
            Modelica.Blocks.Sources.Constant const(k=gain)
              annotation (Placement(transformation(extent={{-60,30},{-40,50}},
                    rotation=0)));
            Modelica.Blocks.Interfaces.BooleanInput on
              "Connector of Boolean input signal"
              annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                    rotation=90,
                  origin={0,-100}), iconTransformation(
                  extent={{-10,-10},{10,10}},
                  rotation=90,
                  origin={0,-90})));
            Modelica.Blocks.Math.BooleanToReal booleanToReal
              annotation (Placement(transformation(extent={{-60,-10},{-40,10}},
                    rotation=0)));
            Modelica.Blocks.Math.Product product1
                                                 annotation (Placement(
                  transformation(extent={{20,10},{40,-10}},rotation=0)));
            Modelica.Blocks.Math.Gain kW_W(k=1000)
              annotation (Placement(transformation(extent={{-22,-60},{-2,-40}},
                    rotation=0)));
            parameter Modelica.Blocks.Interfaces.RealOutput gain=1 "Gain";
            parameter Real table[:,2] = [0,0;1,0;2,0;3,0;4,0;5,0;
              6,0;7,0;8,0;9,0;10,0;
              11,0;12,0;13,0;14,0;15,0;
              16,0;17,0;18,0;19,0;20,7.63E-15;
              21,2.656862299;22,5.066824278;23,6.919044302;24,9.92721153;25,11.99083842;
              26,13.28667893;27,2.948986157;28,5.137151842;29,16.40934905;30,7.516868387;
              31,5.908250322;32,2.157048719;33,-0.995107891;34,-2.198487625;35,-2.161427667;
              36,-1.557434624;37,-2.088169806;38,-12.35098315;39,-7.948784273;40,0.817499451;
              41,2.117771289;42,2.166091748;43,3.143999402;44,6.26306327;45,11.87475974;
              46,13.19569999;47,11.72513052;48,2.855969106;49,0.277692017;50,0.904958197;
              51,-6.363589501;52,-11.0799931;53,-8.109271371;54,-4.867712487;55,0.886824653;
              56,10.46680633;57,12.8893158;58,12.3191627;59,12.00772035;60,8.509745343;
              61,4.537143881;62,3.911765052;63,2.532362225;64,-0.976453428;65,1.0812139;
              66,3.177148783;67,2.500817595;68,1.101144937;69,1.091145544;70,1.780345304;
              71,5.361068592;72,5.497513442;73,2.644941662;74,-0.25017447;75,-1.669071408;
              76,2.532362225;77,4.731114217;78,6.336353546;79,1.965818968;80,-0.235128558;
              81,4.904488962;82,6.551950386;83,8.343637381;84,11.16181509;85,8.205760078;
              86,6.716255706;87,5.12200457;88,5.19826403;89,5.275273722;90,2.694977444;
              91,0.951372803;92,1.791488361;93,1.777192195;94,3.494876196;95,6.164012091;
              96,-0.763593295;97,-1.629908514;98,-0.813649371;99,5.046487368;100,6.870545952;
              101,6.135372417;102,4.46133192;103,3.616033726;104,1.864225701;105,-1.615287117;
              106,-2.467470057;107,3.396206249;108,5.147341381;109,6.995471304;110,7.153524107;
              111,8.236929137;112,6.573955157;113,4.818460446;114,1.161216183;115,-1.567435399;
              116,-22.49130079;117,-21.51938172;118,-18.86940338;119,-16.15374721;120,-13.38226452;
              121,-10.56480711;122,-7.71122688;123,-4.831375337;124,-1.935104277;125,-3.50282E-12;
              126,0;127,0;128,0;129,0;130,0;
              131,0;132,0;133,0;134,0;135,0;
              136,0;137,0;138,0;139,0;140,0;
              141,0;142,0;143,0;144,0;145,0;
              146,0;147,0;148,0;149,0;150,0;
              151,0;152,0;153,0;154,0;155,0;
              156,0;157,0;158,0;159,0;160,0;
              161,0;162,0;163,0;164,3.200194369;165,6.410240389;
              166,9.639989941;167,12.89929459;168,16.19800598;169,19.54597616;170,16.41978194;
              171,16.03903701;172,12.78077258;173,6.459117883;174,-3.115198616;175,-2.374217206;
              176,-0.974859065;177,3.933174589;178,3.270190504;179,3.307888855;180,4.829761684;
              181,12.80447373;182,-3.161607682;183,-15.10480141;184,-6.717964858;185,-16.73479315;
              186,-7.385146225;187,-1.407686368;188,5.644245974;189,3.731350062;190,9.104510165;
              191,15.17586056;192,17.554767;193,23.56615648;194,30.00422086;195,31.37224334;
              196,31.16944854;197,15.53427713;198,26.55164776;199,18.46231859;200,24.16384499;
              201,22.76816223;202,26.42478909;203,18.10320226;204,17.26562624;205,16.33635994;
              206,7.020957872;207,4.300084023;208,5.592980506;209,4.212060311;210,6.845587556;
              211,6.845587556;212,6.845587556;213,6.845587556;214,9.560080973;215,9.64156472;
              216,13.87348744;217,15.53422692;218,15.85777415;219,13.30255272;220,14.95138738;
              221,16.68797266;222,14.05693456;223,15.75817658;224,19.07038909;225,24.16331029;
              226,23.29511248;227,17.52724598;228,14.62976509;229,11.60224307;230,8.477397529;
              231,5.289749171;232,9.878810305;233,13.04036023;234,14.73844624;235,16.51252525;
              236,13.50761889;237,16.86267019;238,13.82598361;239,15.57296564;240,12.45278851;
              241,10.86426746;242,7.601665095;243,10.76750104;244,10.76750104;245,10.76750104;
              246,10.76750104;247,10.76750104;248,9.13923413;249,5.860690061;250,5.743763523;
              251,-0.698505663;252,2.230374967;253,3.624743419;254,6.58373148;255,4.963409033;
              256,7.931230103;257,14.09534591;258,11.12236337;259,11.16968066;260,9.654001849;
              261,4.99907654;262,3.361220902;263,3.232982113;264,3.107067348;265,1.493270362;
              266,13.32133575;267,2.92251612;268,7.254387981;269,5.729048631;270,5.658319597;
              271,10.0305283;272,11.56959204;273,13.17044223;274,14.84277344;275,16.5967319;
              276,16.88346888;277,17.17387278;278,23.85831694;279,18.00680173;280,13.45509413;
              281,16.80393012;282,10.52829073;283,7.307069946;284,0.874541781;285,-0.854647819;
              286,-4.082136394;287,-7.220020796;288,-5.884373961;289,8.543993067;290,8.543993067;
              291,2.655293037;292,-6.050005745;293,6.546513201;294,9.389747977;295,6.546513202;
              296,2.235037797;297,6.368531676;298,7.755335762;299,7.755335762;300,2.101797043;
              301,0.610331872;302,0.497795072;303,-4.985954469;304,-7.669023658;305,-7.692067385;
              306,-8.927306102;307,-8.884523638;308,-7.667847129;309,-8.755922569;310,-15.08609668;
              311,-11.5799748;312,-14.18415221;313,-9.981393829;314,-8.814951099;315,-5.988296893;
              316,-5.038045778;317,1.805868249;318,-1.627149454;319,-5.713441874;320,-9.376638763;
              321,-16.9536642;322,-18.46191898;323,-6.613828488;324,-4.17854971;325,-1.993153256;
              326,-6.159392554;327,-5.650441148;328,-9.857827863;329,-4.603227774;330,-5.894468909;
              331,-4.130382136;332,-1.231614217;333,0;334,0;335,0;
              336,0;337,0;338,0;339,0;340,0;
              341,0;342,0;343,0;344,0;345,0;
              346,4.57589E-13;347,0.324930308;348,4.171443367;349,7.386419831;350,10.624085;
              351,13.89429084;352,16.0353751;353,16.3887344;354,17.28582211;355,9.635959939;
              356,12.44831303;357,12.4827907;358,14.07930661;359,18.5445484;360,9.615613756;
              361,9.937444046;362,7.443430289;363,9.511696169;364,10.76658307;365,12.11814552;
              366,4.409297334;367,6.436308902;368,2.506923034;369,0.51941915;370,5.405191696;
              371,11.58835847;372,8.784622664;373,3.741698266;374,3.741698266;375,3.741698266;
              376,3.741698266;377,3.741698266;378,4.775370456;379,6.89081058;380,4.87671245;
              381,2.811644975;382,-0.292641342;383,-5.304798;384,-6.216833082;385,-2.41535046;
              386,-15.65512214;387,-17.08803827;388,-21.83565488;389,-15.81357266;390,-14.06563098;
              391,-12.70045477;392,-11.39930533;393,-7.78925633;394,-7.624294883;395,-4.743801088;
              396,-1.847186252;397,0;398,0;399,0;400,0;
              401,0;402,2.67029E-12;403,2.010978954;404,5.728007677;405,8.952754472;
              406,12.20496661;407,15.49449573;408,18.83119389;409,22.22491246;410,20.04251654;
              411,6.214729453;412,16.8185521;413,14.59833713;414,10.98016173;415,3.435426484;
              416,1.734800219;417,0.028983707;418,-0.823876327;419,-1.654910703;420,-4.020437795;
              421,-19.18022902;422,-18.6250916;423,-15.90395297;424,-13.12788379;425,-10.30673543;
              426,-7.450359702;427,-4.568608433;428,-1.671333197;429,0;430,0;
              431,0;432,0;433,0;434,0;435,0;
              436,0;437,0;438,0;439,0;440,0;
              441,0;442,0;443,0;444,0;445,0;
              446,0;447,4.89925E-12;448,3.200194369;449,6.410240389;450,9.639989941;
              451,12.89929459;452,16.19800598;453,19.54597616;454,22.95305652;455,26.42909869;
              456,13.12884131;457,13.02585526;458,24.01710355;459,16.98582574;460,8.883891257;
              461,15.1814732;462,6.495645135;463,8.640431212;464,8.820916562;465,2.733113477;
              466,4.775370456;467,4.800557053;468,1.724528462;469,0.674892003;470,6.76745286;
              471,3.741698266;472,-0.335974304;473,2.637167573;474,2.618271221;475,1.594598035;
              476,3.566941843;477,3.566941843;478,3.566941843;479,3.566941843;480,3.566941843;
              481,1.563086101;482,4.528904576;483,4.553113637;484,6.615474687;485,0.608426021;
              486,1.563086101;487,3.524223192;488,3.524223192;489,1.531957519;490,1.501210757;
              491,2.452540212;492,-6.169527386;493,-10.51952811;494,-13.43035419;495,-14.21835171;
              496,-15.96234367;497,-17.38428341;498,-13.73732524;499,-14.31168689;500,-11.50845972;
              501,-7.857888357;502,-5.914173204;503,-3.404266842;504,-0.795719559;505,0;
              506,0;507,0;508,0;509,0;510,2.5503E-12;
              511,0.457179488;512,2.413794392;513,3.335360609;514,2.124297628;515,5.170959519;
              516,3.428271735;517,3.170009555;518,5.276694851;519,8.988259393;520,9.867898699;
              521,9.475031174;522,8.083119793;523,7.464335702;524,6.65736864;525,7.633966206;
              526,8.028253406;527,7.014636637;528,6.572398214;529,4.609369532;530,2.532362225;
              531,1.831956121;532,1.831956121;533,1.831956121;534,1.831956121;535,1.831956122;
              536,6.214729452;537,3.384123323;538,3.422663827;539,-0.957429853;540,-0.965866084;
              541,0.431143758;542,1.831956121;543,1.831956121;544,-2.346632981;545,-6.817007417;
              546,-17.06565542;547,-14.31168689;548,-11.50845972;549,-8.665825846;550,-5.793636748;
              551,-2.90174422;552,0;553,0;554,0;555,0;
              556,0;557,0;558,0;559,0;560,0;
              561,0;562,0;563,0;564,0;565,0;566,0;567,0;
              568,8.95959E-12;569,3.200194369;570,6.410240389;
              571,9.639989941;572,11.97231592;573,7.339731434;574,7.17833896;575,5.747512387;
              576,0.984750347;577,0.984750347;578,3.478927766;579,2.036717573;580,1.044942419;
              581,0.046937528;582,-1.39663062;583,0.502865454;584,-0.443822877;585,2.889855163;
              586,1.472284985;587,0.508474196;588,-0.908892634;589,0.480891466;590,0.943159597;
              591,1.416455943;592,2.889855163;593,3.994715778;594,5.781355304;595,4.947435838;
              596,6.939262993;597,6.069027381;598,1.963986656;599,1.977391789;600,3.847049661;
              601,3.935821564;602,4.025558433;603,2.157048719;604,1.526683225;605,1.526683225;
              606,2.821567271;607,8.307989819;608,11.68993878;609,8.521620753;610,5.747558789;
              611,5.88900271;612,-4.60142366;613,-19.51822817;614,-16.81758906;615,-14.05873551;
              616,-11.25151887;617,-8.405790945;618,-5.53140359;619,-2.638208358;620,0;
              621,0;622,0;623,0;624,0;625,0;
              626,0;627,0;628,0;629,0;630,0;
              631,0;632,0;633,0;634,0;635,0;
              636,0;637,0;638,0;639,0;640,0;
              641,0;642,0;643,0;644,0;645,6.99602E-12;
              646,1.210459708;647,3.357240952;648,7.581896952;649,7.363029504;650,8.702935779;
              651,6.634894622;652,6.420321844;653,11.81376128;654,12.752064;655,9.599074538;
              656,8.9562538;657,8.800535288;658,10.00438843;659,7.541871176;660,4.063081741;
              661,4.879508686;662,2.710816718;663,2.72746367;664,1.993438074;665,3.500602336;
              666,2.777836743;667,2.035406106;668,-1.676293098;669,-1.674057881;670,-10.90648451;
              671,-11.78521976;672,-13.9140663;673,-8.713817167;674,-6.930713934;675,-8.834571475;
              676,-6.649329531;677,-4.444029625;678,-2.096821389;679,-0.750677585;680,
              0;681,0;682,0;683,0;684,0;685,0;
              686,0;687,0;688,0;689,0;690,0;
              691,0;692,0;693,5.58055E-12;694,0.611854826;695,1.905843762;
              696,1.556655875;697,4.127459248;698,7.406257621;699,7.219541316;700,9.036988353;
              701,5.294545428;702,9.205374339;703,2.363272215;704,0.018623437;705,0.943159598;
              706,9.757613801;707,6.56117162;708,6.338082562;709,9.848498576;710,7.830338722;
              711,1.526683225;712,-0.99510789;713,5.365442524;714,5.536642551;715,2.960689899;
              716,-4.776972272;717,-4.019912508;718,-5.007236666;719,-11.53584973;720,-11.78227588;
              721,-9.470231203;722,-7.128579435;723,-4.575453951;724,-1.937829727;725,-1.125331027;
              726,-0.435167407;727,-0.201763184;728,0.022366789;729,2.565211789;730,6.312726537;
              731,8.807391157;732,10.80415425;733,6.634894622;734,9.867898699;735,11.15731028;
              736,10.00647183;737,12.86024509;738,11.95107628;739,11.37718455;740,9.042156622;
              741,9.459711637;742,6.676752664;743,6.061181182;744,4.584981296;745,5.472642767;
              746,4.751697708;747,2.347903781;748,-0.077375731;749,1.495734103;750,0.686291747;
              751,-1.672170762;752,-3.17781995;753,-7.389372165;754,-11.52370964;755,-10.63137793;
              756,-12.1446105;757,-10.61354225;758,-5.861573805;759,-7.756609315;760,-7.705596946;
              761,-5.270256885;762,-2.554159625;763,-0.563128117;764,0.067237436;765,-0.117714446;
              766,-3.02466E-11;767,2.656862299;768,6.117751911;769,9.345303105;770,12.60151373;
              771,13.723869;772,9.362339697;773,5.747002588;774,7.220350745;775,8.290240589;
              776,9.483038458;777,9.4078126;778,14.43926724;779,13.17186432;780,9.88453098;
              781,6.177476124;782,4.679783058;783,7.253326716;784,2.395309621;785,2.395309621;
              786,1.572560984;787,-0.063130045;788,0.715483978;789,2.301203574;790,2.301203574;
              791,1.495734102;792,-2.444551408;793,1.409616266;794,2.180063152;795,2.180063152;
              796,2.180063152;797,2.180063152;798,2.180063152;799,2.968187482;800,5.393021113;
              801,6.324574338;802,15.18259872;803,11.43256662;804,11.89346941;805,12.36314504;
              806,3.11778344;807,8.883891256;808,7.126552589;809,6.260587616;810,2.399009027;
              811,1.411238145;812,3.316342959;813,2.346321424;814,0.411778186;815,-1.49946105;
              816,2.193247382;817,-1.530727012;818,-1.55432898;819,2.016088009;820,0.198996594;
              821,1.954309112;822,-5.038045778;823,-2.467636778;824,1.720834662;825,2.558520362;
              826,2.558520362;827,2.558520361;828,0.02086629;829,1.665788421;830,2.492267808;
              831,0.817875763;832,-0.843368564;833,-3.244614759;834,-1.670359715;835,-3.18826124;
              836,-8.818200775;837,-10.28359157;838,-9.007684476;839,-7.304568942;840,-5.810802993;
              841,1.182052265;842,6.338082562;843,6.036126289;844,4.402567715;845,5.168536444;
              846,5.337128444;847,5.507951124;848,7.084066219;849,8.836017784;850,9.250043264;
              851,6.520933274;852,2.049540377;853,3.57969881;854,3.619686765;855,3.65997079;
              856,6.898027911;857,4.632228023;858,8.027504176;859,3.204979077;860,3.223740919;
              861,3.242581893;862,1.598798576;863,-4.814850385;864,-2.442617648;865,-1.675383887;
              866,-6.735345035;867,-3.771293334;868,-1.664378334;869,3.890423459;870,3.954652978;
              871,4.755670789;872,3.364959298;873,5.663566385;874,7.367841263;875,6.80274378;
              876,4.561472974;877,7.09066072;878,7.286096684;879,4.07957734;880,1.612036302;
              881,1.598798576;882,1.585639984;883,-0.861593003;884,-0.87856773;885,1.470746583;
              886,2.255201594;887,-0.898054558;888,-0.912280767;889,-2.421852688;890,5.132564119;
              891,6.032297066;892,4.561472974;893,3.824111265;894,0.667214688;895,3.824111266;
              896,2.255201594;897,2.255201594;898,-0.118259616;899,-0.137672715;900,-1.675803362;
              901,-0.186156239;902,1.292975637;903,2.035406107;904,2.035406106;905,0.533700622;
              906,1.259412314;907,1.993438074;908,-0.224745869;909,-0.240213842;910,1.91143387;
              911,4.128978795;912,1.215665864;913,-0.24522927;914,-4.422451765;915,-5.598273421;
              916,-6.592763237;917,-2.204459751;918,1.426445896;919,2.045295364;920,7.236630079;
              921,6.876558219;922,5.739286348;923,3.085799867;924,3.122138334;925,5.306974167;
              926,3.251445092;927,2.564180994;928,2.580193864;929,3.326842337;930,-0.259856574;
              931,0.431143758;932,1.831956121;933,1.831956121;934,-0.282857679;935,0.394815764;
              936,0.380756633;937,1.742346251;938,3.140407998;939,5.333986952;940,1.831956121;
              941,-0.976453427;942,1.780345303;943,-1.658610637;944,4.513204115;945,6.064276321;
              946,5.497513441;947,-1.671009479;948,-5.691342471;949,-10.85675687;950,-9.429461277;
              951,-14.17484623;952,-11.85053979;953,-9.01215768;954,-6.143026386;955,-3.252997453;
              956,-0.351922676;957,0;958,0;959,1.33819E-11;960,1.210459709;
              961,5.143871183;962,8.364682608;963,11.61116833;964,14.89317987;965,12.30404555;
              966,6.857963144;967,9.104510165;968,7.875414701;969,7.017608697;970,8.028253407;
              971,12.06358268;972,15.27024653;973,11.42542458;974,6.993997756;975,4.703676541;
              976,3.130722146;977,2.332259009;978,2.332259008;979,-3.99850995;980,0.639169552;
              981,-0.150238756;982,-0.925313752;983,-0.19188547;984,-1.676293098;985,-0.235128558;
              986,-1.671875438;987,-6.363732331;988,-10.85675686;989,-1.596138375;990,1.415608141;
              991,3.280561829;992,5.939242101;993,4.806385041;994,0.283655184;995,1.56119606;
              996,2.873264051;997,-0.358276724;998,1.549629644;999,1.549629645;1000,6.910980764;
              1001,5.066896489;1002,5.915543247;1003,3.195620605;1004,3.954652978;1005,4.755670789;
              1006,2.62864988;1007,1.183599341;1008,-1.67007471;1009,-4.359376875;1010,-0.987800878;
              1011,-1.641795109;1012,-0.351891136;1013,-0.99477903;1014,-1.61139533;1015,-0.99415787;
              1016,-5.007236667;1017,-13.68102342;1018,-12.36253584;1019,-9.530803003;1020,-6.666529624;
              1021,-3.779567525;1022,-0.879768297;1023,0;1024,0;1025,0;
              1026,0;1027,0;1028,0;1029,0;1030,0;
              1031,0;1032,0;1033,0;1034,0;1035,0;
              1036,0;1037,0;1038,0;1039,0;1040,0;
              1041,0;1042,0;1043,0;1044,0;1045,0;
              1046,0;1047,0;1048,0;1049,0;1050,0;
              1051,0;1052,7.45565E-12;1053,0.457179489;1054,3.319632439;1055,7.093359665;
              1056,10.32855526;1057,13.5953957;1058,15.74931251;1059,8.891158636;1060,9.664835174;
              1061,12.44187462;1062,9.317000781;1063,8.428846089;1064,7.364438044;1065,7.649161314;
              1066,8.717281001;1067,4.330534154;1068,6.77113378;1069,6.148287894;1070,5.472642766;
              1071,-0.098163265;1072,-1.672170762;1073,-1.675383886;1074,2.106809411;1075,-3.150435814;
              1076,-10.58755302;1077,-11.08062791;1078,-4.607884892;1079,-3.873524458;1080,-12.04014224;
              1081,-11.78227588;1082,-8.669090568;1083,-3.172861505;1084,-0.956389014;1085,-1.188063542;
              1086,-0.866737999;1087,-0.578389324;1088,-0.555795769;1089,0.172732015;1090,0.917777197;
              1091,0.940099669;1092,-0.312054445;1093,0.172732015;1094,-0.963609432;1095,-1.632410642;
              1096,-2.572302701;1097,-0.750127771;1098,-1.048395229;1099,-0.403492108;1100,-2.24303E-12;
              1101,0.007273885;1102,0.110891907;1103,0.520002539;1104,2.180301241;1105,6.70289181;
              1106,9.177947785;1107,10.70928487;1108,5.45821228;1109,2.818940023;1110,7.626598967;
              1111,11.72937477;1112,11.90613496;1113,7.245709766;1114,2.571336297;1115,1.990855307;
              1116,2.004376948;1117,3.261200495;1118,6.569607736;1119,4.806385042;1120,7.014636637;
              1121,6.572398214;1122,5.333986953;1123,1.121346822;1124,1.11121173;1125,3.232768485;
              1126,4.731114217;1127,4.829761683;1128,3.422663828;1129,4.979860027;1130,3.540004732;
              1131,4.353293055;1132,2.863248004;1133,2.106809412;1134,2.106809412;1135,1.338744846;
              1136,1.327192445;1137,2.078027956;1138,-0.19188547;1139,1.281715469;1140,-0.947870587;
              1141,-1.67405788;1142,-4.422451765;1143,-5.598273421;1144,-10.63137793;1145,-7.144913072;
              1146,-11.22960184;1147,-5.821199626;1148,-7.093066322;1149,-9.358037796;1150,-6.492108991;
              1151,-3.604088396;1152,-0.703827807;1153,0;1154,0;1155,0;
              1156,0;1157,0;1158,0;1159,0;1160,0;
              1161,0;1162,0;1163,0;1164,0;1165,0;
              1166,0;1167,0;1168,3.13906E-12;1169,1.329856139;1170,5.241189342;
              1171,8.462634102;1172,11.71005147;1173,14.99329342;1174,18.32221142;1175,16.15141402;
              1176,13.82761652;1177,4.935835405;1178,-1.637351687;1179,-1.625144524;1180,-12.7481624;
              1181,-14.48009544;1182,-11.67957319;1183,-8.839047172;1184,-5.96836885;1185,-3.077390025;
              1186,-0.175962436;1187,0;1188,0;1189,0;1190,0;
              1191,0;1192,0;1193,0;1194,0;1195,0;
              1196,7.11805E-14;1197,0.020151296;1198,0.613554256;1199,2.119623784;1200,5.766409694;
              1201,9.541734229;1202,8.011906864;1203,3.927683736;1204,1.045979638;1205,-0.757123043;
              1206,1.385477852;1207,1.789613409;1208,0.688574932;1209,4.281529939;1210,7.377113743;
              1211,8.128893355;1212,9.463474083;1213,7.301462315;1214,9.010733279;1215,4.427354793;
              1216,3.280561829;1217,1.448299325;1218,-0.391439742;1219,-0.39838598;1220,3.222656159;
              1221,3.280561829;1222,2.703106683;1223,0.84575966;1224,0.221437734;1225,0.210909642;
              1226,1.415608141;1227,0.805281564;1228,-6.050701855;1229,-2.067035049;1230,-0.431683638;
              1231,3.417050595;1232,2.349603763;1233,2.380610942;1234,-1.520718288;1235,-8.778180258;
              1236,-7.821700264;1237,-8.423511865;1238,-7.91196282;1239,-4.101429081;1240,-3.083747725;
              1241,-2.059486996;1242,-0.938089975;1243,-0.32168353;1244,-3.78303E-12;1245,0;
              1246,0;1247,0;1248,0;1249,0;1250,0;
              1251,0;1252,0.324930308;1253,0.044767844;1254,0.044767844;1255,0.044767844;
              1256,0.044767844;1257,0.340698567;1258,1.312082452;1259,1.302462656;1260,1.630134324;
              1261,2.587704792;1262,4.191379999;1263,6.096160618;1264,1.993327234;1265,-2.197509774;
              1266,-1.973183435;1267,-1.556366212;1268,3.383206902;1269,7.332688528;1270,12.5183065;
              1271,15.27303636;1272,14.86878613;1273,10.18741566;1274,6.334332852;1275,3.980568281;
              1276,6.739506031;1277,5.623101163;1278,5.093304805;1279,4.513204115;1280,1.767611881;
              1281,-1.65700286;1282,-1.647982703;1283,1.643926425;1284,1.643926425;1285,1.643926425;
              1286,1.643926425;1287,1.643926425;1288,5.066896489;1289,2.392538567;1290,4.513204115;
              1291,3.177148783;1292,3.933174589;1293,4.731114217;1294,3.34586573;1295,2.644941662;
              1296,4.151086338;1297,3.461489267;1298,8.158318824;1299,8.45573126;1300,6.265502477;
              1301,8.098567764;1302,3.242581894;1303,1.598798577;1304,-5.589347641;1305,-21.04289661;
              1306,-18.3802443;1307,-15.65370497;1308,-12.8731304;1309,-10.04837256;1310,-7.189282895;
              1311,-4.305713201;1312,-1.407515246;1313,-6.35671E-11;1314,0;1315,0;
              1316,0;1317,0;1318,0;1319,0;1320,0;
              1321,0;1322,0;1323,0;1324,0;1325,0;
              1326,0;1327,0;1328,0;1329,0;1330,0;
              1331,0;1332,0;1333,0;1334,0;1335,0;
              1336,0;1337,0;1338,0.697602998;1339,4.65749275;1340,7.87527368;
              1341,11.11723606;1342,7.352077671;1343,8.870473291;1344,8.96941633;1345,8.78888414;
              1346,7.766667629;1347,5.839912393;1348,7.361569846;1349,5.140650299;1350,2.719846498;
              1351,3.397994564;1352,-0.995037958;1353,-0.994157869;1354,-1.582870251;1355,-2.135571384;
              1356,-1.541663615;1357,-0.975896978;1358,-4.584656071;1359,-3.875336982;1360,-3.679521202;
              1361,-3.479181935;1362,-5.131929056;1363,-8.692604712;1364,-6.342728867;1365,-3.840186021;
              1366,-1.778577377;1367,-2.41891E-10;1368,0;1369,0;1370,0]
              "FTP72 power table (time = first column; power in kW= second columns e.g. table=[0,2])";
            Modelica.Blocks.Interfaces.RealOutput y
              "Connector of Real output signal"
              annotation (Placement(transformation(extent={{100,-10},{120,10}})));
          equation
            connect(const.y, product.u2)          annotation (Line(points={{-39,40},{-32,40},
                    {-32,26},{-22,26}},          color={0,0,127}));
            connect(booleanToReal.y, product.u1) annotation (Line(points={{-39,0},{-32,0},
                    {-32,14},{-22,14}},        color={0,0,127}));
            connect(product.y, product1.u2)
              annotation (Line(points={{1,20},{10,20},{10,6},{18,6}},   color={0,0,
                    127}));
            connect(FTP72_Table.y[1], kW_W.u) annotation (Line(points={{-39,-50},{-40,-50},
                    {-24,-50}},color={0,0,127}));
            connect(kW_W.y, product1.u1) annotation (Line(
                points={{-1,-50},{10,-50},{10,-6},{18,-6}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(product1.y, y) annotation (Line(
                points={{41,0},{110,0}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(on, booleanToReal.u) annotation (Line(
                points={{0,-100},{0,-80},{-80,-80},{-80,0},{-62,0}},
                color={255,0,255},
                smooth=Smooth.None));
            annotation (Icon(graphics={
                  Text(
                    extent={{-82,46},{74,-8}},
                    lineColor={0,0,0},
                    textString="FTP72"),
                  Polygon(
                    points={{-80,80},{-85,58},{-74,58},{-80,80}},
                    lineColor={95,95,95},
                    fillColor={95,95,95},
                    fillPattern=FillPattern.Solid),
                  Line(points={{-80,58},{-80,-90}}, color={95,95,95}),
                  Line(points={{-88,-20},{84,-20}}, color={0,0,0}),
                  Polygon(
                    points={{90,-20},{68,-15},{68,-26},{90,-20}},
                    lineColor={95,95,95},
                    fillColor={95,95,95},
                    fillPattern=FillPattern.Solid),
                  Text(
                    extent={{-80,74},{-47,57}},
                    lineColor={0,0,0},
                    fillColor={95,95,95},
                    fillPattern=FillPattern.Solid,
                    textString=
                         "y"),
                  Text(
                    extent={{68,-31},{89,-41}},
                    lineColor={0,0,0},
                    fillColor={95,95,95},
                    fillPattern=FillPattern.Solid,
                    textString=
                         "time"),
                  Text(
                    extent={{-16,-62},{17,-79}},
                    lineColor={255,0,255},
                    fillColor={255,0,255},
                    fillPattern=FillPattern.Solid,
                    textString=
                         "on"),
                  Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0})}),
                Diagram(graphics));
          end FTP72_Power;

          model Liberal "Liberal cycle definition"
          extends EnergyStorages.Icons.Block;
            Modelica.Blocks.Sources.Pulse polse1C(
              offset=0,
              amplitude=1,
              period=105,
              width=18*100/105)
                           annotation (Placement(transformation(extent={{-80,70},
                      {-60,90}}, rotation=0)));
            Modelica.Blocks.Sources.Pulse pulse0_5C(
              startTime=18,
              offset=0,
              amplitude=0.5,
              width=36*100/105,
              period=105)    annotation (Placement(transformation(extent={{-80,30},
                      {-60,50}}, rotation=0)));
            Modelica.Blocks.Sources.Pulse pulse0_9C(
              offset=0,
              amplitude=-0.9,
              startTime=69,
              width=3*100/105,
              period=105)   annotation (Placement(transformation(extent={{-80,-10},
                      {-60,10}}, rotation=0)));
            Modelica.Blocks.Sources.Pulse pulse0_45C(
              offset=0,
              amplitude=-0.45,
              startTime=72,
              period=105,
              width=6*100/105)
                            annotation (Placement(transformation(extent={{-80,-50},
                      {-60,-30}}, rotation=0)));
            Modelica.Blocks.Sources.Pulse pulse1C1(
              startTime=78,
              offset=0,
              amplitude=-0.3,
              width=12*100/105,
              period=105)     annotation (Placement(transformation(extent={{-80,
                      -90},{-60,-70}}, rotation=0)));
            Modelica.Blocks.Math.Add add annotation (Placement(transformation(
                    extent={{-40,50},{-20,70}}, rotation=0)));
            Modelica.Blocks.Math.Add3 add3_1 annotation (Placement(transformation(
                    extent={{-40,-50},{-20,-30}}, rotation=0)));
            Modelica.Blocks.Math.Add add1 annotation (Placement(transformation(
                    extent={{-8,10},{12,30}}, rotation=0)));
            Modelica.Blocks.Math.Product product annotation (Placement(
                  transformation(extent={{22,4},{42,24}}, rotation=0)));
            Modelica.Blocks.Sources.RealExpression ratedCapacity(y=Cn)
              annotation (Placement(transformation(extent={{-12,-30},{8,-10}},
                    rotation=0)));
            parameter Modelica.SIunits.ElectricCharge  Cn
              "Rated capacity of the battery";
            Modelica.Blocks.Math.Product product1 annotation (Placement(
                  transformation(extent={{60,-10},{80,10}}, rotation=0)));
            Modelica.Blocks.Math.BooleanToReal booleanToReal
              annotation (Placement(transformation(extent={{20,-70},{40,-50}},
                    rotation=0)));
            Modelica.Blocks.Interfaces.BooleanInput on
              "Connector of Boolean input signal"
              annotation (Placement(transformation(
                  origin={0,-90},
                  extent={{-10,-10},{10,10}},
                  rotation=90)));
            Modelica.Blocks.Interfaces.RealOutput y
              "Connector of Real output signal" annotation (Placement(
                  transformation(extent={{100,-10},{120,10}}, rotation=0)));
          equation
            connect(polse1C.y, add.u1) annotation (Line(points={{-59,80},{-50,80},
                    {-50,66},{-42,66}}, color={0,0,127}));
            connect(pulse0_5C.y, add.u2) annotation (Line(points={{-59,40},{-50,
                    40},{-50,54},{-42,54}}, color={0,0,127}));
            connect(pulse0_9C.y, add3_1.u1) annotation (Line(points={{-59,0},{-50,
                    0},{-50,-32},{-42,-32}}, color={0,0,127}));
            connect(pulse0_45C.y, add3_1.u2) annotation (Line(points={{-59,-40},{
                    -42,-40}}, color={0,0,127}));
            connect(pulse1C1.y, add3_1.u3) annotation (Line(points={{-59,-80},{
                    -50,-80},{-50,-48},{-42,-48}}, color={0,0,127}));
            connect(add.y, add1.u1) annotation (Line(points={{-19,60},{-16,60},{
                    -16,26},{-10,26}}, color={0,0,127}));
            connect(add3_1.y, add1.u2) annotation (Line(points={{-19,-40},{-16,
                    -40},{-16,14},{-10,14}}, color={0,0,127}));
            connect(add1.y, product.u1) annotation (Line(points={{13,20},{20,20}},
                  color={0,0,127}));
            connect(ratedCapacity.y, product.u2) annotation (Line(points={{9,-20},
                    {14,-20},{14,8},{20,8}}, color={0,0,127}));
            connect(product.y, product1.u1) annotation (Line(points={{43,14},{46,
                    14},{46,6},{58,6}}, color={0,0,127}));
            connect(booleanToReal.y, product1.u2) annotation (Line(points={{41,
                    -60},{44,-60},{44,-6},{58,-6}}, color={0,0,127}));
            connect(product1.y, y)  annotation (Line(points={{81,0},{110,0}},
                  color={0,0,127}));
            connect(y, y)
              annotation (Line(points={{110,0},{110,0}}, color={0,0,127}));
            connect(on, booleanToReal.u) annotation (Line(points={{0,-90},{0,-60},
                    {18,-60}}, color={255,0,255}));
            annotation (Diagram(graphics),
                                 Icon(graphics={
                  Polygon(
                    points={{-80,80},{-85,58},{-74,58},{-80,80}},
                    lineColor={95,95,95},
                    fillColor={95,95,95},
                    fillPattern=FillPattern.Solid),
                  Line(points={{-80,58},{-80,-90}}, color={95,95,95}),
                  Line(points={{-88,-20},{84,-20}}, color={0,0,0}),
                  Polygon(
                    points={{90,-20},{68,-15},{68,-26},{90,-20}},
                    lineColor={95,95,95},
                    fillColor={95,95,95},
                    fillPattern=FillPattern.Solid),
                  Text(
                    extent={{-84,86},{-51,69}},
                    lineColor={0,0,0},
                    fillColor={95,95,95},
                    fillPattern=FillPattern.Solid,
                    textString=
                         "y"),
                  Text(
                    extent={{68,-31},{89,-41}},
                    lineColor={0,0,0},
                    fillColor={95,95,95},
                    fillPattern=FillPattern.Solid,
                    textString=
                         "time"),
                  Line(
                    points={{-80,-20},{-60,-20},{-60,30},{-40,30},{-40,10},{0,10},
                        {0,-20},{20,-20}},
                    color={0,0,0},
                    thickness=0.5),
                  Line(
                    points={{20,-20},{20,-70},{30,-70}},
                    color={0,0,0},
                    thickness=0.5),
                  Line(
                    points={{30,-70},{30,-40}},
                    color={0,0,0},
                    thickness=0.5),
                  Line(
                    points={{30,-40},{40,-40},{40,-34},{60,-34},{60,-20},{68,-20}},
                    color={0,0,0},
                    thickness=0.5),
                  Text(
                    extent={{-16,-58},{17,-75}},
                    lineColor={255,0,255},
                    fillColor={255,0,255},
                    fillPattern=FillPattern.Solid,
                    textString=
                         "on"),
                  Text(
                    extent={{-88,38},{-55,21}},
                    lineColor={0,0,0},
                    fillColor={95,95,95},
                    fillPattern=FillPattern.Solid,
                    textString=
                         "1"),
                  Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0})}));
          end Liberal;

        end Components;

        annotation (Diagram(graphics));
      end Cycles;

      model CCCV "Constant voltage, constant current discharging device"
      extends EnergyStorages.Icons.Sink;
        parameter Boolean ExternalControl =  true;

        Components.ControlledCurrent                        controlledCurrent(
          Imax=Imax,
          T=T,
          Vref=Vmin)
               annotation (Placement(transformation(extent={{10,10},{-10,-10}},
              rotation=180,
              origin={60,2})));
        parameter Modelica.SIunits.Voltage Vmin "Minimal battery voltage";
        parameter Modelica.SIunits.Current Imax "Maximal discharging current";
        parameter Modelica.SIunits.Time T=0.01 "Controller time constant";
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
          "Positive pin Positive pin (potential p.v > n.v for positive voltage drop v)"
                                                                                                    annotation (Placement(
              transformation(extent={{-10,90},{10,110}},   rotation=0),
              iconTransformation(extent={{-10,90},{10,110}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "Negative pin"
                                     annotation (Placement(transformation(extent={{-10,
                  -110},{10,-90}},   rotation=0), iconTransformation(extent={{-10,
                  -110},{10,-90}})));
        Modelica.Blocks.Interfaces.BooleanInput on annotation (Placement(
              transformation(extent={{-100,-10},{-80,10}}), iconTransformation(
                extent={{-100,-10},{-80,10}})));
        Modelica.Blocks.Interfaces.RealInput v if (ExternalControl==true) annotation (Placement(
              transformation(extent={{-100,-70},{-80,-50}}), iconTransformation(
                extent={{-100,-70},{-80,-50}})));
        Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor if (ExternalControl==false)
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-40,0})));
      protected
        Modelica.Blocks.Interfaces.RealOutput internalNode
          "Voltage between pin p and n (= p.v - n.v) as output signal"
          annotation (Placement(transformation(extent={{10,10},{-10,-10}},
              rotation=180,
              origin={6,0})));
      equation

        connect(voltageSensor.v, internalNode)
                                     annotation (Line(
            points={{-30,0},{6,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(internalNode, controlledCurrent.vControl)
                                                annotation (Line(
            points={{6,0},{20,0},{20,-3.8},{51,-3.8}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(v, internalNode) annotation (Line(
            points={{-90,-60},{-20,-60},{-20,0},{6,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(on, controlledCurrent.on) annotation (Line(
            points={{-90,0},{-60,0},{-60,20},{40,20},{40,7.8},{51,7.8}},
            color={255,0,255},
            smooth=Smooth.None));

        connect(controlledCurrent.pin_p, pin_p) annotation (Line(
            points={{60,12},{60,60},{0,60},{0,100}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(controlledCurrent.pin_n, pin_n) annotation (Line(
            points={{60,-8},{60,-40},{0,-40},{0,-100}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(voltageSensor.p, controlledCurrent.pin_p) annotation (Line(
            points={{-40,10},{-40,40},{60,40},{60,12}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(voltageSensor.n, controlledCurrent.pin_n) annotation (Line(
            points={{-40,-10},{-40,-40},{60,-40},{60,-8}},
            color={0,0,255},
            smooth=Smooth.None));
        annotation (Icon(graphics={
              Text(
                extent={{17,14},{-17,-14}},
                lineColor={255,85,255},
                textString="on",
                origin={-63,2},
                rotation=180),
              Text(
                extent={{27,20},{-27,-20}},
                lineColor={0,0,127},
                textString="v",
                origin={-65,-56},
                rotation=180)}));
      end CCCV;

      model BooleanConstantCurrent "Constant current discharging device"
      extends EnergyStorages.Icons.Sink;
        Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent
          annotation (Placement(transformation(
              origin={40,-10},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
          annotation (Placement(transformation(extent={{-10,90},{10,110}},
                rotation=0)));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
                rotation=0)));
        Modelica.Blocks.Interfaces.BooleanInput on
          "Connector of Boolean input signal"
          annotation (Placement(transformation(extent={{-100,-10},{-80,10}},
                rotation=0)));

        parameter Modelica.SIunits.Current I "Max. discharging current";
        Modelica.Blocks.Math.Product product annotation (Placement(transformation(
                extent={{0,-20},{20,0}}, rotation=0)));
        Modelica.Blocks.Sources.RealExpression realExpression(y=I)
          annotation (Placement(transformation(extent={{-60,-50},{-40,-30}},
                rotation=0)));
        Modelica.Blocks.Math.BooleanToReal booleanToReal
          annotation (Placement(transformation(extent={{-60,-10},{-40,10}},
                rotation=0)));
      equation
        connect(signalCurrent.p, pin_p)
                                     annotation (Line(points={{40,0},{40,100},{
                0,100}},
                       color={0,0,255}));
        connect(signalCurrent.n, pin_n)
                                     annotation (Line(points={{40,-20},{40,-100},
                {0,-100}}, color={0,0,255}));
        connect(product.y, signalCurrent.i) annotation (Line(points={{21,-10},{
                27,-10},{33,-10}},       color={0,0,127}));
        connect(realExpression.y, product.u2) annotation (Line(points={{-39,-40},
                {-20,-40},{-20,-16},{-2,-16}}, color={0,0,127}));
        connect(booleanToReal.u, on)  annotation (Line(points={{-62,0},{-90,0}},
              color={255,0,255}));
        connect(booleanToReal.y, product.u1) annotation (Line(points={{-39,0},{
                -20,0},{-20,-4},{-2,-4}}, color={0,0,127}));
        annotation (Icon(graphics={
              Text(
                extent={{-36,20},{-84,-16}},
                lineColor={255,85,255},
                textString="on")}),
                             Diagram(graphics));
      end BooleanConstantCurrent;

      model BooleanConstantPower "Constant power discharging device"

      extends EnergyStorages.Icons.Sink;
        Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent
          annotation (Placement(transformation(
              origin={40,0},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
          annotation (Placement(transformation(extent={{-10,90},{10,110}},
                rotation=0)));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
                rotation=0)));
        Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
          annotation (Placement(transformation(
              origin={80,0},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Blocks.Math.Product product
          annotation (Placement(transformation(
              origin={10,-40},
              extent={{-10,-10},{10,10}},
              rotation=180)));
        parameter Modelica.SIunits.Time T=1 "Controller time constant";
        parameter Modelica.SIunits.Current Imax
          "Upper current limit of controller";
        EnergyStorages.Sources.Components.LimitedIntegralController limitedController(outMax=
              Imax, T=T)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Blocks.Sources.Constant constantPower(k=power)
          annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
        parameter Modelica.SIunits.Power power "Constant power";
        Modelica.Blocks.Math.Product product1
                                             annotation (Placement(transformation(
                extent={{-40,-10},{-20,10}},
                                         rotation=0)));
        Modelica.Blocks.Math.BooleanToReal booleanToReal
          annotation (Placement(transformation(extent={{-72,-4},{-52,16}},
                rotation=0)));
        Modelica.Blocks.Interfaces.BooleanInput on
          "Connector of Boolean input signal"
          annotation (Placement(transformation(extent={{-100,-10},{-80,10}},
                rotation=0)));
      equation
        connect(signalCurrent.p, pin_p)
                                     annotation (Line(points={{40,10},{40,100},
                {0,100}},
                       color={0,0,255}));
        connect(signalCurrent.n, pin_n)
                                     annotation (Line(points={{40,-10},{40,-100},
                {0,-100}}, color={0,0,255}));
        connect(product.u1, voltageSensor.v) annotation (Line(points={{22,-46},
                {92,-46},{92,0},{90,0}},                  color={0,0,127}));
        connect(voltageSensor.n, signalCurrent.n) annotation (Line(points={{80,-10},
                {80,-20},{40,-20},{40,-10}},      color={0,0,255}));
        connect(voltageSensor.p, signalCurrent.p) annotation (Line(points={{80,10},
                {80,20},{40,20},{40,10}}, color={0,0,255}));
        connect(product.u2, signalCurrent.i) annotation (Line(points={{22,-34},
                {28,-34},{28,0},{33,0}},                      color={0,0,127}));
        connect(limitedController.fb, product.y) annotation (Line(
            points={{-4,-9},{-4,-40},{-1,-40}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(limitedController.y, signalCurrent.i) annotation (Line(
            points={{11,0},{33,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(booleanToReal.u,on)   annotation (Line(points={{-74,6},{-76,6},
                {-76,0},{-90,0}},
              color={255,0,255}));
        connect(product1.y, limitedController.u) annotation (Line(
            points={{-19,0},{-9,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(booleanToReal.y, product1.u1) annotation (Line(
            points={{-51,6},{-42,6}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(constantPower.y, product1.u2)  annotation (Line(
            points={{-59,-40},{-52,-40},{-52,-6},{-42,-6}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Icon(graphics={
              Text(
                extent={{-36,20},{-84,-16}},
                lineColor={255,85,255},
                textString="on")}),
            Diagram(graphics));
      end BooleanConstantPower;

      model SignalPower "Signal power discharging device"
      extends EnergyStorages.Icons.Sink;
        Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent
          annotation (Placement(transformation(
              origin={20,0},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
          annotation (Placement(transformation(extent={{-10,90},{10,110}},
                rotation=0)));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
                rotation=0)));
        Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
          annotation (Placement(transformation(
              origin={60,0},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Blocks.Math.Product product
          annotation (Placement(transformation(
              origin={-30,-50},
              extent={{-10,-10},{10,10}},
              rotation=180)));
        Modelica.Blocks.Interfaces.RealInput power
          annotation (Placement(transformation(extent={{-100,-10},{-80,10}},
                rotation=0)));
        parameter Modelica.SIunits.Time T=1 "Controller time constant";
        parameter Modelica.SIunits.Current Imax
          "Upper current limit of controller";
        EnergyStorages.Sources.Components.LimitedIntegralController limitedController(outMax=
              Imax, T=T)
          annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
      equation
        connect(signalCurrent.p, pin_p)
                                     annotation (Line(points={{20,10},{20,100},
                {0,100}},
                       color={0,0,255}));
        connect(signalCurrent.n, pin_n)
                                     annotation (Line(points={{20,-10},{20,-100},
                {0,-100}}, color={0,0,255}));
        connect(product.u1, voltageSensor.v) annotation (Line(points={{-18,-56},
                {80,-56},{80,0},{70,0}},                  color={0,0,127}));
        connect(voltageSensor.n, signalCurrent.n) annotation (Line(points={{60,-10},
                {60,-20},{20,-20},{20,-10}},      color={0,0,255}));
        connect(voltageSensor.p, signalCurrent.p) annotation (Line(points={{60,10},
                {60,20},{20,20},{20,10}}, color={0,0,255}));
        connect(product.u2, signalCurrent.i) annotation (Line(points={{-18,-44},
                {0,-44},{0,0},{13,0}},                        color={0,0,127}));
        connect(limitedController.y, signalCurrent.i) annotation (Line(
            points={{-39,0},{13,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(power, limitedController.u)
                                        annotation (Line(
            points={{-90,0},{-59,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(limitedController.fb, product.y) annotation (Line(
            points={{-54,-9},{-54,-50},{-41,-50}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Icon(graphics={
              Text(
                extent={{-38,18},{-86,-18}},
                lineColor={0,0,127},
                textString="P")}),
            Diagram(graphics));
      end SignalPower;

      annotation (Diagram(graphics));
    end Loads;

    package Chargers "Charging devices"
     extends Modelica.Icons.Package;
     extends EnergyStorages.Icons.ChargerPackage;

      model CCCV "Constant voltage, constant current charging device"
      extends EnergyStorages.Icons.Source;
        parameter Boolean ExternalControl =  true;

        EnergyStorages.Sources.Components.ControlledCurrent controlledCurrent(
          Imax=Imax,
          T=T,
          Vref=Vmax)
               annotation (Placement(transformation(extent={{10,10},{-10,-10}},
              rotation=180,
              origin={60,0})));
        parameter Modelica.SIunits.Voltage Vmax "Minimal battery voltage";
        parameter Modelica.SIunits.Current Imax "Maximal charging current";
        parameter Modelica.SIunits.Time T=0.01 "Controller time constant";
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
          "Positive pin Positive pin (potential p.v > n.v for positive voltage drop v)"
                                                                                                    annotation (Placement(
              transformation(extent={{-10,90},{10,110}},   rotation=0),
              iconTransformation(extent={{-10,90},{10,110}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "Negative pin"
                                     annotation (Placement(transformation(extent={{-10,
                  -110},{10,-90}},   rotation=0), iconTransformation(extent={{-10,
                  -110},{10,-90}})));
        Modelica.Blocks.Interfaces.BooleanInput on annotation (Placement(
              transformation(extent={{-100,-10},{-80,10}}), iconTransformation(
                extent={{-100,-10},{-80,10}})));
        Modelica.Blocks.Interfaces.RealInput v if (ExternalControl==true) annotation (Placement(
              transformation(extent={{-100,-70},{-80,-50}}), iconTransformation(
                extent={{-100,-70},{-80,-50}})));
        Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor if (ExternalControl==false)
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-40,0})));
      protected
        Modelica.Blocks.Interfaces.RealOutput internalNode
          "Voltage between pin p and n (= p.v - n.v) as output signal"
          annotation (Placement(transformation(extent={{10,10},{-10,-10}},
              rotation=180,
              origin={6,0})));
      equation

        connect(voltageSensor.v, internalNode)
                                     annotation (Line(
            points={{-30,0},{6,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(internalNode, controlledCurrent.vControl)
                                                annotation (Line(
            points={{6,0},{30,0},{30,-5.8},{51,-5.8}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(v, internalNode) annotation (Line(
            points={{-90,-60},{-20,-60},{-20,0},{6,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(on, controlledCurrent.on) annotation (Line(
            points={{-90,0},{-60,0},{-60,20},{44,20},{44,5.8},{51,5.8}},
            color={255,0,255},
            smooth=Smooth.None));

        connect(controlledCurrent.pin_p, pin_p) annotation (Line(
            points={{60,10},{60,40},{0,40},{0,100}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(controlledCurrent.pin_n, pin_n) annotation (Line(
            points={{60,-10},{60,-40},{0,-40},{0,-100}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(voltageSensor.n, controlledCurrent.pin_n) annotation (Line(
            points={{-40,-10},{-40,-40},{60,-40},{60,-10}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(voltageSensor.p, controlledCurrent.pin_p) annotation (Line(
            points={{-40,10},{-40,40},{60,40},{60,10}},
            color={0,0,255},
            smooth=Smooth.None));
        annotation (Icon(graphics={
              Text(
                extent={{17,14},{-17,-14}},
                lineColor={255,85,255},
                textString="on",
                origin={-63,2},
                rotation=180),
              Text(
                extent={{27,20},{-27,-20}},
                lineColor={0,0,127},
                textString="v",
                origin={-65,-56},
                rotation=180)}));
      end CCCV;
    end Chargers;

    package Components "Components for the loads and the charging devices"
     extends EnergyStorages.Icons.ComponentPackage;

      block LimitedIntegralController "Limited output controller"
      extends Icons.Block;

        Modelica.Blocks.Math.Feedback feedback   annotation (Placement(
              transformation(extent={{-50,-10},{-30,10}},  rotation=0)));

        Modelica.Blocks.Continuous.LimIntegrator limIntegrator(     outMax=outMax, k=1/T)
          annotation (Placement(transformation(extent={{20,-10},{40,10}},
                rotation=0)));

        Modelica.Blocks.Interfaces.RealInput u
          annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
        Modelica.Blocks.Interfaces.RealOutput y
          "Connector of Real output signal"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        parameter Modelica.SIunits.Time T "Controller time constant";
        parameter Real outMax "Upper limit of output";
        Modelica.Blocks.Interfaces.RealInput fb annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-40,-90})));
      equation
        connect(feedback.y, limIntegrator.u) annotation (Line(points={{-31,0},{18,
                0}},        color={0,0,127}));
        connect(feedback.u1, u) annotation (Line(
            points={{-48,0},{-90,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(limIntegrator.y, y) annotation (Line(
            points={{41,0},{110,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(feedback.u2, fb) annotation (Line(
            points={{-40,-8},{-40,-90}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(graphics),
                             Icon(graphics={
              Line(
                points={{-80,0},{-54,0}},
                color={0,0,0},
                smooth=Smooth.None),
              Ellipse(
                extent={{-54,14},{-26,-14}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-40,-14},{-40,-80},{-40,-80}},
                color={0,0,0},
                smooth=Smooth.None),
              Rectangle(
                extent={{-2,30},{58,-28}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{6,26},{6,-22},{54,-22}},
                color={0,0,0},
                smooth=Smooth.None),
              Line(
                points={{6,-22},{18,0},{50,0}},
                color={0,0,0},
                smooth=Smooth.None),
              Line(
                points={{58,0},{90,0}},
                color={0,0,0},
                smooth=Smooth.None),
              Line(
                points={{-26,0},{-2,0}},
                color={0,0,0},
                smooth=Smooth.None),
              Text(
                extent={{-58,-4},{-2,-38}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                textString="-"),
              Polygon(
                points={{-40,-14},{-44,-24},{-36,-24},{-40,-14}},
                lineColor={0,0,0},
                smooth=Smooth.None,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-64,2},{-64,-4},{-54,0},{-64,4},{-64,2}},
                lineColor={0,0,0},
                smooth=Smooth.None,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}));
      end LimitedIntegralController;

      model ControlledCurrent "Controls the current according to the inputs"
      extends EnergyStorages.Icons.Source;

        parameter Modelica.SIunits.Voltage Vref "Reference voltage";
        parameter Modelica.SIunits.Current Imax "Maximal current";
        parameter Modelica.SIunits.Time T=0.01 "Controller time constant";

        Modelica.Electrical.Analog.Sources.SignalCurrent CurrentSource
          annotation (Placement(transformation(
              origin={40,0},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Blocks.Sources.RealExpression refVoltage(y=Vref)
          annotation (Placement(transformation(extent={{-80,-20},{-60,0}},
                rotation=0)));

        Modelica.Blocks.Interfaces.BooleanInput on
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=0,
              origin={-100,60}), iconTransformation(extent={{-100,48},{-80,68}})));
        Modelica.Blocks.Math.Product product annotation (Placement(
              transformation(extent={{10,10},{-10,-10}}, rotation=180,
              origin={16,0})));
        Modelica.Blocks.Math.BooleanToReal booleanToReal
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=0,
              origin={-38,30})));

        Modelica.Blocks.Interfaces.RealInput vControl
          annotation (Placement(transformation(
              origin={-100,-60},
              extent={{-10,-10},{10,10}},
              rotation=0), iconTransformation(extent={{-100,-68},{-80,-48}})));
        EnergyStorages.Sources.Components.LimitedIntegralController limitedController(outMax=
              Imax, T=T)
          annotation (Placement(transformation(extent={{-46,-20},{-26,0}})));

        Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
          annotation (Placement(transformation(extent={{-10,90},{10,110}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
      equation
        connect(booleanToReal.y, product.u1)
          annotation (Line(points={{-27,30},{-14,30},{-14,6},{4,6}},     color=
                {0,0,127}));
        connect(booleanToReal.u, on) annotation (Line(points={{-50,30},{-50,28},
                {-58,28},{-80,28},{-80,60},{-100,60}},
              color={255,0,255}));
        connect(product.y, CurrentSource.i) annotation (Line(points={{27,0},{27,
                0},{33,0}},     color={0,0,127}));
        connect(refVoltage.y, limitedController.u) annotation (Line(
            points={{-59,-10},{-45,-10}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(limitedController.fb, vControl)
                                         annotation (Line(
            points={{-40,-19},{-40,-60},{-100,-60}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(limitedController.y, product.u2) annotation (Line(
            points={{-25,-10},{-14,-10},{-14,-6},{4,-6}},
            color={0,0,127},
            smooth=Smooth.None));

        connect(CurrentSource.n, pin_p) annotation (Line(
            points={{40,10},{40,40},{0,40},{0,100}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(CurrentSource.p, pin_n) annotation (Line(
            points={{40,-10},{40,-40},{0,-40},{0,-100}},
            color={0,0,255},
            smooth=Smooth.None));
        annotation (Diagram(graphics),
                             Icon(graphics={
              Ellipse(extent={{-40,40},{40,-40}}, lineColor={0,0,0},
                origin={0,2},
                rotation=90),
              Line(points={{0,40},{0,-40}}, color={0,0,0},
                origin={0,2},
                rotation=90),
              Text(
                extent={{17,14},{-17,-14}},
                lineColor={255,85,255},
                textString="on",
                origin={-59,62},
                rotation=180),
              Polygon(
                points={{0,-10},{-8,8},{8,8},{0,-10}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                origin={0,60},
                rotation=180),
              Line(
                points={{0,88},{0,42}},
                color={0,0,0},
                smooth=Smooth.None),
              Line(
                points={{0,-40},{0,-90}},
                color={0,0,0},
                smooth=Smooth.None)}));
      end ControlledCurrent;
    end Components;
  end Sources;

  annotation (versionDate="2012-06-10");
end EnergyStorages;
