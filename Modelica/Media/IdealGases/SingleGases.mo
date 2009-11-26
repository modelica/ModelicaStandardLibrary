within Modelica.Media.IdealGases;
package SingleGases "Media models of ideal gases from NASA tables"
  extends Modelica.Icons.Library;

  package Ar "Ideal gas \"Ar\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
     mediumName="Argon",
     data=Common.SingleGasesData.Ar,
     fluidConstants={Common.FluidData.Ar});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ar.png\"></HTML>"));
  end Ar;

  package CH4 "Ideal gas \"CH4\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Methane",
       data=Common.SingleGasesData.CH4,
       fluidConstants={Common.FluidData.CH4});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH4.png\"></HTML>"));
  end CH4;

  package CH3OH "Ideal gas \"CH3OH\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Methanol",
       data=Common.SingleGasesData.CH3OH,
       fluidConstants={Common.FluidData.CH3OH});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH3OH.png\"></HTML>"));
  end CH3OH;

  package CO "Ideal gas \"CO\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Carbon Monoxide",
       data=Common.SingleGasesData.CO,
       fluidConstants={Common.FluidData.CO});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CO.png\"></HTML>"));
  end CO;

  package CO2 "Ideal gas \"CO2\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Carbon Dioxide",
       data=Common.SingleGasesData.CO2,
       fluidConstants={Common.FluidData.CO2});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CO2.png\"></HTML>"));
  end CO2;

  package C2H2_vinylidene
    "Ideal gas \"C2H2_vinylidene\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Acetylene",
       data=Common.SingleGasesData.C2H2_vinylidene,
       fluidConstants={Common.FluidData.C2H2_vinylidene});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2H2_vinylidene.png\"></HTML>"));
  end C2H2_vinylidene;

  package C2H4 "Ideal gas \"C2H4\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Ethylene",
       data=Common.SingleGasesData.C2H4,
       fluidConstants={Common.FluidData.C2H4});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2H4.png\"></HTML>"));
  end C2H4;

  package C2H5OH "Ideal gas \"C2H5OH\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Ethanol",
       data=Common.SingleGasesData.C2H5OH,
       fluidConstants={Common.FluidData.C2H5OH});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2H5OH.png\"></HTML>"));
  end C2H5OH;

  package C2H6 "Ideal gas \"C2H6\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Ethane",
       data=Common.SingleGasesData.C2H6,
       fluidConstants={Common.FluidData.C2H6});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2H6.png\"></HTML>"));
  end C2H6;

  package C3H6_propylene
    "Ideal gas \"C3H6_propylene\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Propylene",
       data=Common.SingleGasesData.C3H6_propylene,
       fluidConstants={Common.FluidData.C3H6_propylene});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3H6_propylene.png\"></HTML>"));
  end C3H6_propylene;

  package C3H8 "Ideal gas \"C3H8\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Propane",
       data=Common.SingleGasesData.C3H8,
       fluidConstants={Common.FluidData.C3H8});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3H8.png\"></HTML>"));
  end C3H8;

  package C3H8O_1propanol
    "Ideal gas \"C3H8O_1propanol\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="1-Propanol",
       data=Common.SingleGasesData.C3H8O_1propanol,
       fluidConstants={Common.FluidData.C3H7OH});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3H8O_1propanol.png\"></HTML>"));
  end C3H8O_1propanol;

  package C4H8_1_butene
    "Ideal gas \"C4H8_1_butene\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="1-Butene",
       data=Common.SingleGasesData.C4H8_1_butene,
       fluidConstants={Common.FluidData.C4H8_1_butene});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C4H8_1_butene.png\"></HTML>"));
  end C4H8_1_butene;

  package C4H10_n_butane
    "Ideal gas \"C4H10_n_butane\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="N-Butane",
       data=Common.SingleGasesData.C4H10_n_butane,
       fluidConstants={Common.FluidData.C4H10_n_butane});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C4H10_n_butane.png\"></HTML>"));
  end C4H10_n_butane;

  package C5H10_1_pentene
    "Ideal gas \"C5H10_1_pentene\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="1-Pentene",
       data=Common.SingleGasesData.C5H10_1_pentene,
       fluidConstants={Common.FluidData.C5H10_1_pentene});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C5H10_1_pentene.png\"></HTML>"));
  end C5H10_1_pentene;

  package C5H12_n_pentane
    "Ideal gas \"C5H12_n_pentane\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName = "N-Pentane",
       data=Common.SingleGasesData.C5H12_n_pentane,
       fluidConstants={Common.FluidData.C5H12_n_pentane});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C5H12_n_pentane.png\"></HTML>"));
  end C5H12_n_pentane;

  package C6H6 "Ideal gas \"C6H6\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Benzene",
       data=Common.SingleGasesData.C6H6,
       fluidConstants={Common.FluidData.C6H6});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C6H6.png\"></HTML>"));
  end C6H6;

  package C6H12_1_hexene
    "Ideal gas \"C6H12_1_hexene\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="1-Hexene",
       data=Common.SingleGasesData.C6H12_1_hexene,
       fluidConstants={Common.FluidData.C6H12_1_hexene});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C6H12_1_hexene.png\"></HTML>"));
  end C6H12_1_hexene;

  package C6H14_n_hexane
    "Ideal gas \"C6H14_n_hexane\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="N-Hexane",
       data=Common.SingleGasesData.C6H14_n_hexane,
       fluidConstants={Common.FluidData.C6H14_n_hexane});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C6H14_n_hexane.png\"></HTML>"));
  end C6H14_n_hexane;

  package C7H14_1_heptene
    "Ideal gas \"C7H14_1_heptene\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="1-Heptene",
       data=Common.SingleGasesData.C7H14_1_heptene,
       fluidConstants={Common.FluidData.C7H14_1_heptene});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C7H14_1_heptene.png\"></HTML>"));
  end C7H14_1_heptene;

  package C7H16_n_heptane
    "Ideal gas \"C7H16_n_heptane\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="N-Heptane",
       data=Common.SingleGasesData.C7H16_n_heptane,
       fluidConstants={Common.FluidData.C7H16_n_heptane});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C7H16_n_heptane.png\"></HTML>"));
  end C7H16_n_heptane;

  package C8H10_ethylbenz
    "Ideal gas \"C8H10_ethylbenz\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Ethylbenzene",
       data=Common.SingleGasesData.C8H10_ethylbenz,
       fluidConstants={Common.FluidData.C8H10_ethylbenz});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C8H10_ethylbenz.png\"></HTML>"));
  end C8H10_ethylbenz;

  package C8H18_n_octane
    "Ideal gas \"C8H18_n_octane\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="N-Octane",
       data=Common.SingleGasesData.C8H18_n_octane,
       fluidConstants={Common.FluidData.C8H18_n_octane});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C8H18_n_octane.png\"></HTML>"));
  end C8H18_n_octane;

  package CL2 "Ideal gas \"Cl2\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Chlorine",
       data=Common.SingleGasesData.CL2,
       fluidConstants={Common.FluidData.CL2});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CL2.png\"></HTML>"));
  end CL2;

  package F2 "Ideal gas \"F2\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Fluorine",
       data=Common.SingleGasesData.F2,
       fluidConstants={Common.FluidData.F2});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/F2.png\"></HTML>"));
  end F2;

  package H2 "Ideal gas \"H2\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Hydrogen",
       data=Common.SingleGasesData.H2,
       fluidConstants={Common.FluidData.H2});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H2.png\"></HTML>"));
  end H2;

  package H2O "Ideal gas \"H2O\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="IdealGasSteam",
       data=Common.SingleGasesData.H2O,
       fluidConstants={Common.FluidData.H2O});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H2O.png\"></HTML>"));
  end H2O;

  package He "Ideal gas \"He\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Helium",
       data=Common.SingleGasesData.He,
       fluidConstants={Common.FluidData.He});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/He.png\"></HTML>"));
  end He;

  package NH3 "Ideal gas \"NH3\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="IdealGasAmmonia",
       data=Common.SingleGasesData.NH3,
       fluidConstants={Common.FluidData.NH3});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NH3.png\"></HTML>"));
  end NH3;

  package NO "Ideal gas \"NO\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Nitric Oxide",
       data=Common.SingleGasesData.NO,
       fluidConstants={Common.FluidData.NO});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NO.png\"></HTML>"));
  end NO;

  package NO2 "Ideal gas \"NO2\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Nitrogen Dioxide",
       data=Common.SingleGasesData.NO2,
       fluidConstants={Common.FluidData.NO2});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NO2.png\"></HTML>"));
  end NO2;

  package N2 "Ideal gas \"N2\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Nitrogen",
       data=Common.SingleGasesData.N2,
       fluidConstants={Common.FluidData.N2});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/N2.png\"></HTML>"));
  end N2;

  package N2O "Ideal gas \"N2O\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Nitrous Oxide",
       data=Common.SingleGasesData.N2O,
       fluidConstants={Common.FluidData.N2O});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/N2O.png\"></HTML>"));
  end N2O;

  package Ne "Ideal gas \"Ne\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Neon",
       data=Common.SingleGasesData.Ne,
       fluidConstants={Common.FluidData.Ne});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ne.png\"></HTML>"));
  end Ne;

  package O2 "Ideal gas \"O2\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Oxygen",
       data=Common.SingleGasesData.O2,
       fluidConstants={Common.FluidData.O2});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/O2.png\"></HTML>"));
  end O2;

  package SO2 "Ideal gas \"SO2\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Sulfur Dioxide",
       data=Common.SingleGasesData.SO2,
       fluidConstants={Common.FluidData.SO2});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SO2.png\"></HTML>"));
  end SO2;

  package SO3 "Ideal gas \"SO3\" from NASA Glenn coefficients"
    extends Common.SingleGasNasa(
       mediumName="Sulfur Trioxide",
       data=Common.SingleGasesData.SO3,
       fluidConstants={Common.FluidData.SO3});
    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SO3.png\"></HTML>"));
  end SO3;

  annotation ( Documentation(
        info="<HTML>
<p>
This package contains medium
models for the following 37 gases
(see also the description in
<a href=\"Modelica://Modelica.Media.IdealGases\">Modelica.Media.IdealGases</a>):
</p>
<pre>
Argon             Methane          Methanol       Carbon Monoxide  Carbon Dioxide
Acetylene         Ethylene         Ethanol        Ethane           Propylene
Propane           1-Propanol       1-Butene       N-Butane         1-Pentene
N-Pentane         Benzene          1-Hexene       N-Hexane         1-Heptane
N-Heptane         Ethylbenzene     N-Octane       Chlorine         Fluorine
Hydrogen          Steam            Helium         Ammonia          Nitric Oxide
Nitrogen Dioxide  Nitrogen         Nitrous        Oxide            Neon Oxygen
Sulfur Dioxide    Sulfur Trioxide
</pre>
</HTML>"));
end SingleGases;
