package SingleGases "Media models of ideal gases from NASA tables" 
  extends Modelica.Icons.Library;
  annotation (preferedView="info", Documentation(info="<HTML>
<p>This package contains the data records for the 1241 ideal gases from </p>
<blockquote>
  <p>McBride B.J., Zehe M.J., and Gordon S. (2002): <b>NASA Glenn Coefficients 
  for Calculating Thermodynamic Properties of Individual Species</b>. NASA 
  report TP-2002-211556</p>
</blockquote>
<p>The record entries are defined in <b>IdealGases.DataRecord</b>. Medium
models for the following gases are provided:
</p>

<pre>
 Ag        BaOH+           C2H4O_ethylen_o DF      In2I4    Nb      ScO2   
 Ag+       Ba_OH_2         CH3CHO_ethanal  DOCl    In2I6    Nb+     Sc2O   
 Ag-       BaS             CH3COOH         DO2     In2O     Nb-     Sc2O2  
 Air       Ba2             OHCH2COOH       DO2-    K        NbCl5   Si     
 Al        Be              C2H5            D2      K+       NbO     Si+    
 Al+       Be+             C2H5Br          D2+     K-       NbOCl3  Si-    
 Al-       Be++            C2H6            D2-     KAlF4    NbO2    SiBr   
 AlBr      BeBr            CH3N2CH3        D2O     KBO2     Ne      SiBr2  
 AlBr2     BeBr2           C2H5OH          D2O2    KBr      Ne+     SiBr3  
 AlBr3     BeCl            CH3OCH3         D2S     KCN      Ni      SiBr4  
 AlC       BeCl2           CH3O2CH3        e-      KCl      Ni+     SiC    
 AlC2      BeF             CCN             F       KF       Ni-     SiC2   
 AlCl      BeF2            CNC             F+      KH       NiCl    SiCl   
 AlCl+     BeH             OCCN            F-      KI       NiCl2   SiCl2  
 AlCl2     BeH+            C2N2            FCN     Kli      NiO     SiCl3  
 AlCl3     BeH2            C2O             FCO     KNO2     NiS     SiCl4  
 AlF       BeI             C3              FO      KNO3     O       SiF    
 AlF+      BeI2            C3H3_1_propynl  FO2_FOO KNa      O+      SiFCl  
 AlFCl     BeN             C3H3_2_propynl  FO2_OFO KO       O-      SiF2   
 AlFCl2    BeO             C3H4_allene     F2      KOH      OD      SiF3   
 AlF2      BeOH            C3H4_propyne    F2O     K2       OD-     SiF4   
 AlF2-     BeOH+           C3H4_cyclo      F2O2    K2+      OH      SiH    
 AlF2Cl    Be_OH_2         C3H5_allyl      FS2F    K2Br2    OH+     SiH+   
 AlF3      BeS             C3H6_propylene  Fe      K2CO3    OH-     SiHBr3 
 AlF4-     Be2             C3H6_cyclo      Fe+     K2C2N2   O2      SiHCl  
 AlH       Be2Cl4          C3H6O_propylox  Fe_CO_5 K2Cl2    O2+     SiHCl3 
 AlHCl     Be2F4           C3H6O_acetone   FeCl    K2F2     O2-     SiHF   
 AlHCl2    Be2O            C3H6O_propanal  FeCl2   K2I2     O3      SiHF3  
 AlHF      Be2OF2          C3H7_n_propyl   FeCl3   K2O      P       SiHI3  
 AlHFCl    Be2O2           C3H7_i_propyl   FeO     K2O+     P+      SiH2   
 AlHF2     Be3O3           C3H8            Fe_OH_2 K2O2     P-      SiH2Br2
 AlH2      Be4O4           C3H8O_1propanol Fe2Cl4  K2O2H2   PCl     SiH2Cl2
 AlH2Cl    Br              C3H8O_2propanol Fe2Cl6  K2SO4    PCl2    SiH2F2 
 AlH2F     Br+             CNCOCN          Ga      Kr       PCl2-   SiH2I2 
 AlH3      Br-             C3O2            Ga+     Kr+      PCl3    SiH3   
 AlI       BrCl            C4              GaBr    li       PCl5    SiH3Br 
 AlI2      BrF             C4H2_butadiyne  GaBr2   li+      PF      SiH3Cl 
 AlI3      BrF3            C4H4_1_3-cyclo  GaBr3   li-      PF+     SiH3F  
 AlN       BrF5            C4H6_butadiene  GaCl    liAlF4   PF-     SiH3I  
 AlO       BrO             C4H6_1butyne    GaCl2   liBO2    PFCl    SiH4   
 AlO+      OBrO            C4H6_2butyne    GaCl3   liBr     PFCl-   SiI    
 AlO-      BrOO            C4H6_cyclo      GaF     liCl     PFCl2   SiI2   
 AlOCl     BrO3            C4H8_1_butene   GaF2    liF      PFCl4   SiN    
 AlOCl2    Br2             C4H8_cis2_buten GaF3    liH      PF2     SiO    
 AlOF      BrBrO           C4H8_isobutene  GaH     liI      PF2-    SiO2   
 AlOF2     BrOBr           C4H8_cyclo      GaI     liN      PF2Cl   SiS    
 AlOF2-    C               C4H9_n_butyl    GaI2    liNO2    PF2Cl3  SiS2   
 AlOH      C+              C4H9_i_butyl    GaI3    liNO3    PF3     Si2    
 AlOHCl    C-              C4H9_s_butyl    GaO     liO      PF3Cl2  Si2C   
 AlOHCl2   CBr             C4H9_t_butyl    GaOH    liOF     PF4Cl   Si2F6  
 AlOHF     CBr2            C4H10_n_butane  Ga2Br2  liOH     PF5     Si2N   
 AlOHF2    CBr3            C4H10_isobutane Ga2Br4  liON     PH      Si3    
 AlO2      CBr4            C4N2            Ga2Br6  li2      PH2     Sn     
 AlO2-     CCl             C5              Ga2Cl2  li2+     PH2-    Sn+    
 Al_OH_2   CCl2            C5H6_1_3cyclo   Ga2Cl4  li2Br2   PH3     Sn-    
 Al_OH_2Cl CCl2Br2         C5H8_cyclo      Ga2Cl6  li2F2    PN      SnBr   
 Al_OH_2F  CCl3            C5H10_1_pentene Ga2F2   li2I2    PO      SnBr2  
 Al_OH_3   CCl3Br          C5H10_cyclo     Ga2F4   li2O     PO-     SnBr3  
 AlS       CCl4            C5H11_pentyl    Ga2F6   li2O+    POCl3   SnBr4  
 AlS2      CF              C5H11_t_pentyl  Ga2I2   li2O2    POFCl2  SnCl   
 Al2       CF+             C5H12_n_pentane Ga2I4   li2O2H2  POF2Cl  SnCl2  
 Al2Br6    CFBr3           C5H12_i_pentane Ga2I6   li2SO4   POF3    SnCl3  
 Al2C2     CFCl            CH3C_CH3_2CH3   Ga2O    li3+     PO2     SnCl4  
 Al2Cl6    CFClBr2         C6D5_phenyl     Ge      li3Br3   PO2-    SnF    
 Al2F6     CFCl2           C6D6            Ge+     li3Cl3   PS      SnF2   
 Al2I6     CFCl2Br         C6H2            Ge-     li3F3    P2      SnF3   
 Al2O      CFCl3           C6H5_phenyl     GeBr    li3I3    P2O3    SnF4   
 Al2O+     CF2             C6H5O_phenoxy   GeBr2   Mg       P2O4    SnI    
 Al2O2     CF2+            C6H6            GeBr3   Mg+      P2O5    SnI2   
 Al2O2+    CF2Br2          C6H5OH_phenol   GeBr4   MgBr     P3      SnI3   
 Al2O3     CF2Cl           C6H10_cyclo     GeCl    MgBr2    P3O6    SnI4   
 Al2S      CF2ClBr         C6H12_1_hexene  GeCl2   MgCl     P4      SnO    
 Al2S2     CF2Cl2          C6H12_cyclo     GeCl3   MgCl+    P4O6    SnO2   
 Ar        CF3             C6H13_n_hexyl   GeCl4   MgCl2    P4O7    SnS    
 Ar+       CF3+            C6H14_n_hexane  GeF     MgF      P4O8    SnS2   
 B         CF3Br           C7H7_benzyl     GeF2    MgF+     P4O9    Sn2    
 B+        CF3Cl           C7H8            GeF3    MgF2     P4O10   Sr     
 B-        CF4             C7H8O_cresol_mx GeF4    MgF2+    Pb      Sr+    
 BBr       CH+             C7H14_1_heptene GeH4    MgH      Pb+     SrBr   
 BBr2      CHBr3           C7H15_n_heptyl  GeI     MgI      Pb-     SrBr2  
 BBr3      CHCl            C7H16_n_heptane GeO     MgI2     PbBr    SrCl   
 BC        CHClBr2         C7H16_2_methylh GeO2    MgN      PbBr2   SrCl+  
 BC2       CHCl2           C8H8_styrene    GeS     MgO      PbBr3   SrCl2  
 BCl       CHCl2Br         C8H10_ethylbenz GeS2    MgOH     PbBr4   SrF    
 BCl+      CHCl3           C8H16_1_octene  Ge2     MgOH+    PbCl    SrF+   
 BClOH     CHF             C8H17_n_octyl   H       Mg_OH_2  PbCl2   SrF2   
 BCl_OH_2  CHFBr2          C8H18_n_octane  H+      MgS      PbCl3   SrH    
 BCl2      CHFCl           C8H18_isooctane H-      Mg2      PbCl4   SrI    
 BCl2+     CHFClBr         C9H19_n_nonyl   HAlO    Mg2F4    PbF     SrI2   
 BCl2OH    CHFCl2          C10H8_naphthale HAlO2   Mn       PbF2    SrO    
 BF        CHF2            C10H21_n_decyl  HBO     Mn+      PbF3    SrOH   
 BFCl      CHF2Br          C12H9_o_bipheny HBO+    Mo       PbF4    SrOH+  
 BFCl2     CHF2Cl          C12H10_biphenyl HBO2    Mo+      PbI     Sr_OH_2
 BFOH      CHF3            Ca              HBS     Mo-      PbI2    SrS    
 BF_OH_2   CHI3            Ca+             HBS+    MoO      PbI3    Sr2    
 BF2       CH2             CaBr            HCN     MoO2     PbI4    Ta     
 BF2+      CH2Br2          CaBr2           HCO     MoO3     PbO     Ta+    
 BF2-      CH2Cl           CaCl            HCO+    MoO3-    PbO2    Ta-    
 BF2Cl     CH2ClBr         CaCl+           HCCN    Mo2O6    PbS     TaCl5  
 BF2OH     CH2Cl2          CaCl2           HCCO    Mo3O9    PbS2    TaO    
 BF3       CH2F            CaF             HCl     Mo4O12   Rb      TaO2   
 BF4-      CH2FBr          CaF+            HD      Mo5O15   Rb+     Ti     
 BH        CH2FCl          CaF2            HD+     N        Rb-     Ti+    
 BHCl      CH2F2           CaH             HDO     N+       RbBO2   Ti-    
 BHCl2     CH2I2           CaI             HDO2    N-       RbBr    TiCl   
 BHF       CH3             CaI2            HF      NCO      RbCl    TiCl2  
 BHFCl     CH3Br           CaO             HI      ND       RbF     TiCl3  
 BHF2      CH3Cl           CaO+            HNC     ND2      RbH     TiCl4  
 BH2       CH3F            CaOH            HNCO    ND3      RbI     TiO    
 BH2Cl     CH3I            CaOH+           HNO     NF       RbK     TiO+   
 BH2F      CH2OH           Ca_OH_2         HNO2    NF2      Rbli    TiOCl  
 BH3       CH2OH+          CaS             HNO3    NF3      RbNO2   TiOCl2 
 BH3NH3    CH3O            Ca2             HOCl    NH       RbNO3   TiO2   
 BH4       CH4             Cd              HOF     NH+      RbNa    U      
 BI        CH3OH           Cd+             HO2     NHF      RbO     UF     
 BI2       CH3OOH          Cl              HO2-    NHF2     RbOH    UF+    
 BI3       CI              Cl+             HPO     NH2      Rb2Br2  UF-    
 BN        CI2             Cl-             HSO3F   NH2F     Rb2Cl2  UF2    
 BO        CI3             ClCN            H2      NH3      Rb2F2   UF2+   
 BO-       CI4             ClF             H2+     NH2OH    Rb2I2   UF2-   
 BOCl      CN              ClF3            H2-     NH4+     Rb2O    UF3    
 BOCl2     CN+             ClF5            HBOH    NO       Rb2O2   UF3+   
 BOF       CN-             ClO             HCOOH   NOCl     Rb2O2H2 UF3-   
 BOF2      CNN             ClO2            H2F2    NOF      Rb2SO4  UF4    
 BOH       CO              Cl2             H2O     NOF3     Rn      UF4+   
 BO2       CO+             Cl2O            H2O+    NO2      Rn+     UF4-   
 BO2-      COCl            Co              H2O2    NO2-     S       UF5    
 B_OH_2    COCl2           Co+             H2S     NO2Cl    S+      UF5+   
 BS        COFCl           Co-             H2SO4   NO2F     S-      UF5-   
 BS2       COF2            Cr              H2BOH   NO3      SCl     UF6    
 B2        COHCl           Cr+             HB_OH_2 NO3-     SCl2    UF6-   
 B2C       COHF            Cr-             H3BO3   NO3F     SCl2+   UO     
 B2Cl4     COS             CrN             H3B3O3  N2       SD      UO+    
 B2F4      CO2             CrO             H3B3O6  N2+      SF      UOF    
 B2H       CO2+            CrO2            H3F3    N2-      SF+     UOF2   
 B2H2      COOH            CrO3            H3O+    NCN      SF-     UOF3   
 B2H3      CP              CrO3-           H4F4    N2D2_cis SF2     UOF4   
 B2H3_db   CS              Cs              H5F5    N2F2     SF2+    UO2    
 B2H4      CS2             Cs+             H6F6    N2F4     SF2-    UO2+   
 B2H4_db   C2              Cs-             H7F7    N2H2     SF3     UO2-   
 B2H5      C2+             CsBO2           He      NH2NO2   SF3+    UO2F   
 B2H5_db   C2-             CsBr            He+     N2H4     SF3-    UO2F2  
 B2H6      C2Cl            CsCl            Hg      N2O      SF4     UO3    
 B2O       C2Cl2           CsF             Hg+     N2O+     SF4+    UO3-   
 B2O2      C2Cl3           CsH             HgBr2   N2O3     SF4-    V      
 B2O3      C2Cl4           CsI             I       N2O4     SF5     V+     
 B2_OH_4   C2Cl6           Csli            I+      N2O5     SF5+    V-     
 B2S       C2F             CsNO2           I-      N3       SF5-    VCl4   
 B2S2      C2FCl           CsNO3           IF5     N3H      SF6     VN     
 B2S3      C2FCl3          CsNa            IF7     Na       SF6-    VO     
 B3H7_C2v  C2F2            CsO             I2      Na+      SH      VO2    
 B3H7_Cs   C2F2Cl2         CsOH            In      Na-      SH-     V4O10  
 B3H9      C2F3            CsRb            In+     NaAlF4   SN      W      
 B3N3H6    C2F3Cl          Cs2             InBr    NaBO2    SO      W+     
 B3O3Cl3   C2F4            Cs2Br2          InBr2   NaBr     SO-     W-     
 B3O3FCl2  C2F6            Cs2CO3          InBr3   NaCN     SOF2    WCl6   
 B3O3F2Cl  C2H             Cs2Cl2          InCl    NaCl     SO2     WO     
 B3O3F3    C2HCl           Cs2F2           InCl2   NaF      SO2-    WOCl4  
 B4H4      C2HCl3          Cs2I2           InCl3   NaH      SO2Cl2  WO2    
 B4H10     C2HF            Cs2O            InF     NaI      SO2FCl  WO2Cl2 
 B4H12     C2HFCl2         Cs2O+           InF2    Nali     SO2F2   WO3    
 B5H9      C2HF2Cl         Cs2O2           InF3    NaNO2    SO3     WO3-   
 Ba        C2HF3           Cs2O2H2         InH     NaNO3    S2      Xe     
 Ba+       C2H2_vinylidene Cs2SO4          InI     NaO      S2-     Xe+    
 BaBr      C2H2Cl2         Cu              InI2    NaOH     S2Cl2   Zn     
 BaBr2     C2H2FCl         Cu+             InI3    NaOH+    S2F2    Zn+    
 BaCl      C2H2F2          Cu-             InO     Na2      S2O     Zr     
 BaCl+     CH2CO_ketene    CuCl            InOH    Na2Br2   S3      Zr+    
 BaCl2     O_CH_2O         CuF             In2Br2  Na2Cl2   S4      Zr-    
 BaF       HO_CO_2OH       CuF2            In2Br4  Na2F2    S5      ZrN    
 BaF+      C2H3_vinyl      CuO             In2Br6  Na2I2    S6      ZrO    
 BaF2      CH2Br-COOH      Cu2             In2Cl2  Na2O     S7      ZrO+   
 BaH       C2H3Cl          Cu3Cl3          In2Cl4  Na2O+    S8      ZrO2   
 BaI       CH2Cl-COOH      D               In2Cl6  Na2O2    Sc     
 BaI2      C2H3F           D+              In2F2   Na2O2H2  Sc+    
 BaO       CH3CN           D-              In2F4   Na2SO4   Sc-    
 BaO+      CH3CO_acetyl    DBr             In2F6   Na3Cl3   ScO    
 BaOH      C2H4            DCl             In2I2   Na3F3    ScO+   
</pre>
</HTML>"));
  
  package Ag "Ideal gas \"Ag\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ag);
    annotation (preferedView="info", Documentation(info="<HTML>
<IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ag.png\">
</HTML>"));
  end Ag;
  
  package Agplus "Ideal gas \"Ag+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Agplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Agplus.png\"></HTML>"));
  end Agplus;
  
  package Agminus "Ideal gas \"Ag-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(
       data=Common.SingleGasesData.Agminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Agminus.png\"></HTML>"));
  end Agminus;
  
  package Air "Ideal gas \"Air\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(
       data=Common.SingleGasesData.Air);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Air.png\"></HTML>"));
  end Air;
  
  package AL "Ideal gas \"Al\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.AL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/AL.png\"></HTML>"));
  end AL;
  
  package ALplus "Ideal gas \"Al+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALplus.png\"></HTML>"));
  end ALplus;
  
  package ALminus "Ideal gas \"Al-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALminus.png\"></HTML>"));
  end ALminus;
  
  package ALBr "Ideal gas \"AlBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALBr.png\"></HTML>"));
  end ALBr;
  
  package ALBr2 "Ideal gas \"AlBr2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALBr2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALBr2.png\"></HTML>"));
  end ALBr2;
  
  package ALBr3 "Ideal gas \"AlBr3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALBr3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALBr3.png\"></HTML>"));
  end ALBr3;
  
  package ALC "Ideal gas \"AlC\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALC);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALC.png\"></HTML>"));
  end ALC;
  
  package ALC2 "Ideal gas \"AlC2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALC2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALC2.png\"></HTML>"));
  end ALC2;
  
  package ALCL "Ideal gas \"AlCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALCL.png\"></HTML>"));
  end ALCL;
  
  package ALCLplus "Ideal gas \"AlCl+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALCLplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALCLplus.png\"></HTML>"));
  end ALCLplus;
  
  package ALCL2 "Ideal gas \"AlCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALCL2.png\"></HTML>"));
  end ALCL2;
  
  package ALCL3 "Ideal gas \"AlCl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALCL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALCL3.png\"></HTML>"));
  end ALCL3;
  
  package ALF "Ideal gas \"AlF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALF.png\"></HTML>"));
  end ALF;
  
  package ALFplus "Ideal gas \"AlF+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALFplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALFplus.png\"></HTML>"));
  end ALFplus;
  
  package ALFCL "Ideal gas \"AlFCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALFCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALFCL.png\"></HTML>"));
  end ALFCL;
  
  package ALFCL2 "Ideal gas \"AlFCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALFCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALFCL2.png\"></HTML>"));
  end ALFCL2;
  
  package ALF2 "Ideal gas \"AlF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALF2.png\"></HTML>"));
  end ALF2;
  
  package ALF2minus "Ideal gas \"AlF2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALF2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALF2minus.png\"></HTML>"));
  end ALF2minus;
  
  package ALF2CL "Ideal gas \"AlF2Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALF2CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALF2CL.png\"></HTML>"));
  end ALF2CL;
  
  package ALF3 "Ideal gas \"AlF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALF3.png\"></HTML>"));
  end ALF3;
  
  package ALF4minus "Ideal gas \"AlF4-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALF4minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALF4minus.png\"></HTML>"));
  end ALF4minus;
  
  package ALH "Ideal gas \"AlH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALH.png\"></HTML>"));
  end ALH;
  
  package ALHCL "Ideal gas \"AlHCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALHCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALHCL.png\"></HTML>"));
  end ALHCL;
  
  package ALHCL2 "Ideal gas \"AlHCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALHCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALHCL2.png\"></HTML>"));
  end ALHCL2;
  
  package ALHF "Ideal gas \"AlHF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALHF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALHF.png\"></HTML>"));
  end ALHF;
  
  package ALHFCL "Ideal gas \"AlHFCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALHFCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALHFCL.png\"></HTML>"));
  end ALHFCL;
  
  package ALHF2 "Ideal gas \"AlHF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALHF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALHF2.png\"></HTML>"));
  end ALHF2;
  
  package ALH2 "Ideal gas \"AlH2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALH2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALH2.png\"></HTML>"));
  end ALH2;
  
  package ALH2CL "Ideal gas \"AlH2Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALH2CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALH2CL.png\"></HTML>"));
  end ALH2CL;
  
  package ALH2F "Ideal gas \"AlH2F\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALH2F);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALH2F.png\"></HTML>"));
  end ALH2F;
  
  package ALH3 "Ideal gas \"AlH3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALH3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALH3.png\"></HTML>"));
  end ALH3;
  
  package ALI "Ideal gas \"AlI\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALI);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALI.png\"></HTML>"));
  end ALI;
  
  package ALI2 "Ideal gas \"AlI2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALI2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALI2.png\"></HTML>"));
  end ALI2;
  
  package ALI3 "Ideal gas \"AlI3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALI3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALI3.png\"></HTML>"));
  end ALI3;
  
  package ALN "Ideal gas \"AlN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALN.png\"></HTML>"));
  end ALN;
  
  package ALO "Ideal gas \"AlO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALO.png\"></HTML>"));
  end ALO;
  
  package ALOplus "Ideal gas \"AlO+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALOplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALOplus.png\"></HTML>"));
  end ALOplus;
  
  package ALOminus "Ideal gas \"AlO-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALOminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALOminus.png\"></HTML>"));
  end ALOminus;
  
  package ALOCL "Ideal gas \"AlOCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALOCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALOCL.png\"></HTML>"));
  end ALOCL;
  
  package ALOCL2 "Ideal gas \"AlOCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALOCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALOCL2.png\"></HTML>"));
  end ALOCL2;
  
  package ALOF "Ideal gas \"AlOF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALOF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALOF.png\"></HTML>"));
  end ALOF;
  
  package ALOF2 "Ideal gas \"AlOF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALOF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALOF2.png\"></HTML>"));
  end ALOF2;
  
  package ALOF2minus "Ideal gas \"AlOF2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALOF2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALOF2minus.png\"></HTML>"));
  end ALOF2minus;
  
  package ALOH "Ideal gas \"AlOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALOH.png\"></HTML>"));
  end ALOH;
  
  package ALOHCL "Ideal gas \"AlOHCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALOHCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALOHCL.png\"></HTML>"));
  end ALOHCL;
  
  package ALOHCL2 "Ideal gas \"AlOHCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALOHCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALOHCL2.png\"></HTML>"));
  end ALOHCL2;
  
  package ALOHF "Ideal gas \"AlOHF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALOHF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALOHF.png\"></HTML>"));
  end ALOHF;
  
  package ALOHF2 "Ideal gas \"AlOHF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALOHF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALOHF2.png\"></HTML>"));
  end ALOHF2;
  
  package ALO2 "Ideal gas \"AlO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALO2.png\"></HTML>"));
  end ALO2;
  
  package ALO2minus "Ideal gas \"AlO2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALO2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALO2minus.png\"></HTML>"));
  end ALO2minus;
  
  package AL_OH_2 "Ideal gas \"Al_OH_2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.AL_OH_2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/AL_OH_2.png\"></HTML>"));
  end AL_OH_2;
  
  package AL_OH_2CL "Ideal gas \"Al_OH_2Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.AL_OH_2CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/AL_OH_2CL.png\"></HTML>"));
  end AL_OH_2CL;
  
  package AL_OH_2F "Ideal gas \"Al_OH_2F\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.AL_OH_2F);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/AL_OH_2F.png\"></HTML>"));
  end AL_OH_2F;
  
  package AL_OH_3 "Ideal gas \"Al_OH_3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.AL_OH_3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/AL_OH_3.png\"></HTML>"));
  end AL_OH_3;
  
  package ALS "Ideal gas \"AlS\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALS);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALS.png\"></HTML>"));
  end ALS;
  
  package ALS2 "Ideal gas \"AlS2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ALS2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ALS2.png\"></HTML>"));
  end ALS2;
  
  package AL2 "Ideal gas \"Al2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.AL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/AL2.png\"></HTML>"));
  end AL2;
  
  package AL2Br6 "Ideal gas \"Al2Br6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.AL2Br6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/AL2Br6.png\"></HTML>"));
  end AL2Br6;
  
  package AL2C2 "Ideal gas \"Al2C2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.AL2C2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/AL2C2.png\"></HTML>"));
  end AL2C2;
  
  package AL2CL6 "Ideal gas \"Al2Cl6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.AL2CL6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/AL2CL6.png\"></HTML>"));
  end AL2CL6;
  
  package AL2F6 "Ideal gas \"Al2F6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.AL2F6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/AL2F6.png\"></HTML>"));
  end AL2F6;
  
  package AL2I6 "Ideal gas \"Al2I6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.AL2I6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/AL2I6.png\"></HTML>"));
  end AL2I6;
  
  package AL2O "Ideal gas \"Al2O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.AL2O);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/AL2O.png\"></HTML>"));
  end AL2O;
  
  package AL2Oplus "Ideal gas \"Al2O+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.AL2Oplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/AL2Oplus.png\"></HTML>"));
  end AL2Oplus;
  
  package AL2O2 "Ideal gas \"Al2O2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.AL2O2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/AL2O2.png\"></HTML>"));
  end AL2O2;
  
  package AL2O2plus "Ideal gas \"Al2O2+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.AL2O2plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/AL2O2plus.png\"></HTML>"));
  end AL2O2plus;
  
  package AL2O3 "Ideal gas \"Al2O3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.AL2O3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/AL2O3.png\"></HTML>"));
  end AL2O3;
  
  package AL2S "Ideal gas \"Al2S\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.AL2S);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/AL2S.png\"></HTML>"));
  end AL2S;
  
  package AL2S2 "Ideal gas \"Al2S2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.AL2S2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/AL2S2.png\"></HTML>"));
  end AL2S2;
  
  package Ar "Ideal gas \"Ar\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ar,
     fluidConstants={Common.FluidData.Ar});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ar.png\"></HTML>"));
  end Ar;
  
  package Arplus "Ideal gas \"Ar+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Arplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Arplus.png\"></HTML>"));
  end Arplus;
  
  package B "Ideal gas \"B\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B.png\"></HTML>"));
  end B;
  
  package Bplus "Ideal gas \"B+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Bplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Bplus.png\"></HTML>"));
  end Bplus;
  
  package Bminus "Ideal gas \"B-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Bminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Bminus.png\"></HTML>"));
  end Bminus;
  
  package BBr "Ideal gas \"BBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BBr.png\"></HTML>"));
  end BBr;
  
  package BBr2 "Ideal gas \"BBr2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BBr2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BBr2.png\"></HTML>"));
  end BBr2;
  
  package BBr3 "Ideal gas \"BBr3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BBr3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BBr3.png\"></HTML>"));
  end BBr3;
  
  package BC "Ideal gas \"BC\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BC);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BC.png\"></HTML>"));
  end BC;
  
  package BC2 "Ideal gas \"BC2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BC2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BC2.png\"></HTML>"));
  end BC2;
  
  package BCL "Ideal gas \"BCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BCL.png\"></HTML>"));
  end BCL;
  
  package BCLplus "Ideal gas \"BCl+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BCLplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BCLplus.png\"></HTML>"));
  end BCLplus;
  
  package BCLOH "Ideal gas \"BClOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BCLOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BCLOH.png\"></HTML>"));
  end BCLOH;
  
  package BCL_OH_2 "Ideal gas \"BCl_OH_2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BCL_OH_2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BCL_OH_2.png\"></HTML>"));
  end BCL_OH_2;
  
  package BCL2 "Ideal gas \"BCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BCL2.png\"></HTML>"));
  end BCL2;
  
  package BCL2plus "Ideal gas \"BCl2+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BCL2plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BCL2plus.png\"></HTML>"));
  end BCL2plus;
  
  package BCL2OH "Ideal gas \"BCl2OH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BCL2OH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BCL2OH.png\"></HTML>"));
  end BCL2OH;
  
  package BF "Ideal gas \"BF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BF.png\"></HTML>"));
  end BF;
  
  package BFCL "Ideal gas \"BFCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BFCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BFCL.png\"></HTML>"));
  end BFCL;
  
  package BFCL2 "Ideal gas \"BFCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BFCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BFCL2.png\"></HTML>"));
  end BFCL2;
  
  package BFOH "Ideal gas \"BFOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BFOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BFOH.png\"></HTML>"));
  end BFOH;
  
  package BF_OH_2 "Ideal gas \"BF_OH_2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BF_OH_2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BF_OH_2.png\"></HTML>"));
  end BF_OH_2;
  
  package BF2 "Ideal gas \"BF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BF2.png\"></HTML>"));
  end BF2;
  
  package BF2plus "Ideal gas \"BF2+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BF2plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BF2plus.png\"></HTML>"));
  end BF2plus;
  
  package BF2minus "Ideal gas \"BF2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BF2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BF2minus.png\"></HTML>"));
  end BF2minus;
  
  package BF2CL "Ideal gas \"BF2Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BF2CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BF2CL.png\"></HTML>"));
  end BF2CL;
  
  package BF2OH "Ideal gas \"BF2OH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BF2OH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BF2OH.png\"></HTML>"));
  end BF2OH;
  
  package BF3 "Ideal gas \"BF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BF3.png\"></HTML>"));
  end BF3;
  
  package BF4minus "Ideal gas \"BF4-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BF4minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BF4minus.png\"></HTML>"));
  end BF4minus;
  
  package BH "Ideal gas \"BH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BH.png\"></HTML>"));
  end BH;
  
  package BHCL "Ideal gas \"BHCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BHCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BHCL.png\"></HTML>"));
  end BHCL;
  
  package BHCL2 "Ideal gas \"BHCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BHCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BHCL2.png\"></HTML>"));
  end BHCL2;
  
  package BHF "Ideal gas \"BHF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BHF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BHF.png\"></HTML>"));
  end BHF;
  
  package BHFCL "Ideal gas \"BHFCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BHFCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BHFCL.png\"></HTML>"));
  end BHFCL;
  
  package BHF2 "Ideal gas \"BHF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BHF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BHF2.png\"></HTML>"));
  end BHF2;
  
  package BH2 "Ideal gas \"BH2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BH2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BH2.png\"></HTML>"));
  end BH2;
  
  package BH2CL "Ideal gas \"BH2Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BH2CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BH2CL.png\"></HTML>"));
  end BH2CL;
  
  package BH2F "Ideal gas \"BH2F\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BH2F);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BH2F.png\"></HTML>"));
  end BH2F;
  
  package BH3 "Ideal gas \"BH3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BH3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BH3.png\"></HTML>"));
  end BH3;
  
  package BH3NH3 "Ideal gas \"BH3NH3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BH3NH3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BH3NH3.png\"></HTML>"));
  end BH3NH3;
  
  package BH4 "Ideal gas \"BH4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BH4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BH4.png\"></HTML>"));
  end BH4;
  
  package BI "Ideal gas \"BI\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BI);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BI.png\"></HTML>"));
  end BI;
  
  package BI2 "Ideal gas \"BI2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BI2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BI2.png\"></HTML>"));
  end BI2;
  
  package BI3 "Ideal gas \"BI3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BI3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BI3.png\"></HTML>"));
  end BI3;
  
  package BN "Ideal gas \"BN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BN.png\"></HTML>"));
  end BN;
  
  package BO "Ideal gas \"BO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BO.png\"></HTML>"));
  end BO;
  
  package BOminus "Ideal gas \"BO-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BOminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BOminus.png\"></HTML>"));
  end BOminus;
  
  package BOCL "Ideal gas \"BOCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BOCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BOCL.png\"></HTML>"));
  end BOCL;
  
  package BOCL2 "Ideal gas \"BOCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BOCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BOCL2.png\"></HTML>"));
  end BOCL2;
  
  package BOF "Ideal gas \"BOF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BOF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BOF.png\"></HTML>"));
  end BOF;
  
  package BOF2 "Ideal gas \"BOF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BOF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BOF2.png\"></HTML>"));
  end BOF2;
  
  package BOH "Ideal gas \"BOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BOH.png\"></HTML>"));
  end BOH;
  
  package BO2 "Ideal gas \"BO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BO2.png\"></HTML>"));
  end BO2;
  
  package BO2minus "Ideal gas \"BO2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BO2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BO2minus.png\"></HTML>"));
  end BO2minus;
  
  package B_OH_2 "Ideal gas \"B_OH_2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B_OH_2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B_OH_2.png\"></HTML>"));
  end B_OH_2;
  
  package BS "Ideal gas \"BS\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BS);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BS.png\"></HTML>"));
  end BS;
  
  package BS2 "Ideal gas \"BS2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BS2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BS2.png\"></HTML>"));
  end BS2;
  
  package B2 "Ideal gas \"B2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B2.png\"></HTML>"));
  end B2;
  
  package B2C "Ideal gas \"B2C\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B2C);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B2C.png\"></HTML>"));
  end B2C;
  
  package B2CL4 "Ideal gas \"B2Cl4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B2CL4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B2CL4.png\"></HTML>"));
  end B2CL4;
  
  package B2F4 "Ideal gas \"B2F4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B2F4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B2F4.png\"></HTML>"));
  end B2F4;
  
  package B2H "Ideal gas \"B2H\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B2H);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B2H.png\"></HTML>"));
  end B2H;
  
  package B2H2 "Ideal gas \"B2H2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B2H2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B2H2.png\"></HTML>"));
  end B2H2;
  
  package B2H3 "Ideal gas \"B2H3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B2H3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B2H3.png\"></HTML>"));
  end B2H3;
  
  package B2H3_db "Ideal gas \"B2H3_db\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B2H3_db);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B2H3_db.png\"></HTML>"));
  end B2H3_db;
  
  package B2H4 "Ideal gas \"B2H4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B2H4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B2H4.png\"></HTML>"));
  end B2H4;
  
  package B2H4_db "Ideal gas \"B2H4_db\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B2H4_db);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B2H4_db.png\"></HTML>"));
  end B2H4_db;
  
  package B2H5 "Ideal gas \"B2H5\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B2H5);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B2H5.png\"></HTML>"));
  end B2H5;
  
  package B2H5_db "Ideal gas \"B2H5_db\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B2H5_db);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B2H5_db.png\"></HTML>"));
  end B2H5_db;
  
  package B2H6 "Ideal gas \"B2H6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B2H6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B2H6.png\"></HTML>"));
  end B2H6;
  
  package B2O "Ideal gas \"B2O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B2O);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B2O.png\"></HTML>"));
  end B2O;
  
  package B2O2 "Ideal gas \"B2O2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B2O2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B2O2.png\"></HTML>"));
  end B2O2;
  
  package B2O3 "Ideal gas \"B2O3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B2O3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B2O3.png\"></HTML>"));
  end B2O3;
  
  package B2_OH_4 "Ideal gas \"B2_OH_4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B2_OH_4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B2_OH_4.png\"></HTML>"));
  end B2_OH_4;
  
  package B2S "Ideal gas \"B2S\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B2S);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B2S.png\"></HTML>"));
  end B2S;
  
  package B2S2 "Ideal gas \"B2S2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B2S2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B2S2.png\"></HTML>"));
  end B2S2;
  
  package B2S3 "Ideal gas \"B2S3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B2S3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B2S3.png\"></HTML>"));
  end B2S3;
  
  package B3H7_C2v "Ideal gas \"B3H7_C2v\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B3H7_C2v);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B3H7_C2v.png\"></HTML>"));
  end B3H7_C2v;
  
  package B3H7_Cs "Ideal gas \"B3H7_Cs\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B3H7_Cs);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B3H7_Cs.png\"></HTML>"));
  end B3H7_Cs;
  
  package B3H9 "Ideal gas \"B3H9\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B3H9);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B3H9.png\"></HTML>"));
  end B3H9;
  
  package B3N3H6 "Ideal gas \"B3N3H6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B3N3H6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B3N3H6.png\"></HTML>"));
  end B3N3H6;
  
  package B3O3CL3 "Ideal gas \"B3O3Cl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B3O3CL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B3O3CL3.png\"></HTML>"));
  end B3O3CL3;
  
  package B3O3FCL2 "Ideal gas \"B3O3FCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B3O3FCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B3O3FCL2.png\"></HTML>"));
  end B3O3FCL2;
  
  package B3O3F2CL "Ideal gas \"B3O3F2Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B3O3F2CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B3O3F2CL.png\"></HTML>"));
  end B3O3F2CL;
  
  package B3O3F3 "Ideal gas \"B3O3F3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B3O3F3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B3O3F3.png\"></HTML>"));
  end B3O3F3;
  
  package B4H4 "Ideal gas \"B4H4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B4H4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B4H4.png\"></HTML>"));
  end B4H4;
  
  package B4H10 "Ideal gas \"B4H10\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B4H10);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B4H10.png\"></HTML>"));
  end B4H10;
  
  package B4H12 "Ideal gas \"B4H12\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B4H12);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B4H12.png\"></HTML>"));
  end B4H12;
  
  package B5H9 "Ideal gas \"B5H9\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.B5H9);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/B5H9.png\"></HTML>"));
  end B5H9;
  
  package Ba "Ideal gas \"Ba\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ba);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ba.png\"></HTML>"));
  end Ba;
  
  package Baplus "Ideal gas \"Ba+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Baplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Baplus.png\"></HTML>"));
  end Baplus;
  
  package BaBr "Ideal gas \"BaBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BaBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BaBr.png\"></HTML>"));
  end BaBr;
  
  package BaBr2 "Ideal gas \"BaBr2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BaBr2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BaBr2.png\"></HTML>"));
  end BaBr2;
  
  package BaCL "Ideal gas \"BaCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BaCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BaCL.png\"></HTML>"));
  end BaCL;
  
  package BaCLplus "Ideal gas \"BaCl+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BaCLplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BaCLplus.png\"></HTML>"));
  end BaCLplus;
  
  package BaCL2 "Ideal gas \"BaCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BaCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BaCL2.png\"></HTML>"));
  end BaCL2;
  
  package BaF "Ideal gas \"BaF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BaF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BaF.png\"></HTML>"));
  end BaF;
  
  package BaFplus "Ideal gas \"BaF+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BaFplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BaFplus.png\"></HTML>"));
  end BaFplus;
  
  package BaF2 "Ideal gas \"BaF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BaF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BaF2.png\"></HTML>"));
  end BaF2;
  
  package BaH "Ideal gas \"BaH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BaH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BaH.png\"></HTML>"));
  end BaH;
  
  package BaI "Ideal gas \"BaI\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BaI);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BaI.png\"></HTML>"));
  end BaI;
  
  package BaI2 "Ideal gas \"BaI2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BaI2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BaI2.png\"></HTML>"));
  end BaI2;
  
  package BaO "Ideal gas \"BaO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BaO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BaO.png\"></HTML>"));
  end BaO;
  
  package BaOplus "Ideal gas \"BaO+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BaOplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BaOplus.png\"></HTML>"));
  end BaOplus;
  
  package BaOH "Ideal gas \"BaOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BaOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BaOH.png\"></HTML>"));
  end BaOH;
  
  package BaOHplus "Ideal gas \"BaOH+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BaOHplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BaOHplus.png\"></HTML>"));
  end BaOHplus;
  
  package Ba_OH_2 "Ideal gas \"Ba_OH_2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ba_OH_2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ba_OH_2.png\"></HTML>"));
  end Ba_OH_2;
  
  package BaS "Ideal gas \"BaS\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BaS);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BaS.png\"></HTML>"));
  end BaS;
  
  package Ba2 "Ideal gas \"Ba2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ba2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ba2.png\"></HTML>"));
  end Ba2;
  
  package Be "Ideal gas \"Be\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Be);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Be.png\"></HTML>"));
  end Be;
  
  package Beplus "Ideal gas \"Be+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Beplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Beplus.png\"></HTML>"));
  end Beplus;
  
  package Beplusplus "Ideal gas \"Be++\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Beplusplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Beplusplus.png\"></HTML>"));
  end Beplusplus;
  
  package BeBr "Ideal gas \"BeBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BeBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BeBr.png\"></HTML>"));
  end BeBr;
  
  package BeBr2 "Ideal gas \"BeBr2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BeBr2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BeBr2.png\"></HTML>"));
  end BeBr2;
  
  package BeCL "Ideal gas \"BeCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BeCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BeCL.png\"></HTML>"));
  end BeCL;
  
  package BeCL2 "Ideal gas \"BeCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BeCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BeCL2.png\"></HTML>"));
  end BeCL2;
  
  package BeF "Ideal gas \"BeF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BeF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BeF.png\"></HTML>"));
  end BeF;
  
  package BeF2 "Ideal gas \"BeF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BeF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BeF2.png\"></HTML>"));
  end BeF2;
  
  package BeH "Ideal gas \"BeH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BeH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BeH.png\"></HTML>"));
  end BeH;
  
  package BeHplus "Ideal gas \"BeH+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BeHplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BeHplus.png\"></HTML>"));
  end BeHplus;
  
  package BeH2 "Ideal gas \"BeH2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BeH2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BeH2.png\"></HTML>"));
  end BeH2;
  
  package BeI "Ideal gas \"BeI\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BeI);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BeI.png\"></HTML>"));
  end BeI;
  
  package BeI2 "Ideal gas \"BeI2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BeI2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BeI2.png\"></HTML>"));
  end BeI2;
  
  package BeN "Ideal gas \"BeN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BeN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BeN.png\"></HTML>"));
  end BeN;
  
  package BeO "Ideal gas \"BeO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BeO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BeO.png\"></HTML>"));
  end BeO;
  
  package BeOH "Ideal gas \"BeOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BeOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BeOH.png\"></HTML>"));
  end BeOH;
  
  package BeOHplus "Ideal gas \"BeOH+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BeOHplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BeOHplus.png\"></HTML>"));
  end BeOHplus;
  
  package Be_OH_2 "Ideal gas \"Be_OH_2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Be_OH_2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Be_OH_2.png\"></HTML>"));
  end Be_OH_2;
  
  package BeS "Ideal gas \"BeS\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BeS);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BeS.png\"></HTML>"));
  end BeS;
  
  package Be2 "Ideal gas \"Be2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Be2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Be2.png\"></HTML>"));
  end Be2;
  
  package Be2CL4 "Ideal gas \"Be2Cl4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Be2CL4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Be2CL4.png\"></HTML>"));
  end Be2CL4;
  
  package Be2F4 "Ideal gas \"Be2F4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Be2F4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Be2F4.png\"></HTML>"));
  end Be2F4;
  
  package Be2O "Ideal gas \"Be2O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Be2O);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Be2O.png\"></HTML>"));
  end Be2O;
  
  package Be2OF2 "Ideal gas \"Be2OF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Be2OF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Be2OF2.png\"></HTML>"));
  end Be2OF2;
  
  package Be2O2 "Ideal gas \"Be2O2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Be2O2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Be2O2.png\"></HTML>"));
  end Be2O2;
  
  package Be3O3 "Ideal gas \"Be3O3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Be3O3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Be3O3.png\"></HTML>"));
  end Be3O3;
  
  package Be4O4 "Ideal gas \"Be4O4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Be4O4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Be4O4.png\"></HTML>"));
  end Be4O4;
  
  package Br "Ideal gas \"Br\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Br);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Br.png\"></HTML>"));
  end Br;
  
  package Brplus "Ideal gas \"Br+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Brplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Brplus.png\"></HTML>"));
  end Brplus;
  
  package Brminus "Ideal gas \"Br-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Brminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Brminus.png\"></HTML>"));
  end Brminus;
  
  package BrCL "Ideal gas \"BrCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BrCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BrCL.png\"></HTML>"));
  end BrCL;
  
  package BrF "Ideal gas \"BrF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BrF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BrF.png\"></HTML>"));
  end BrF;
  
  package BrF3 "Ideal gas \"BrF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BrF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BrF3.png\"></HTML>"));
  end BrF3;
  
  package BrF5 "Ideal gas \"BrF5\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BrF5);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BrF5.png\"></HTML>"));
  end BrF5;
  
  package BrO "Ideal gas \"BrO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BrO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BrO.png\"></HTML>"));
  end BrO;
  
  package OBrO "Ideal gas \"OBrO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.OBrO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/OBrO.png\"></HTML>"));
  end OBrO;
  
  package BrOO "Ideal gas \"BrOO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BrOO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BrOO.png\"></HTML>"));
  end BrOO;
  
  package BrO3 "Ideal gas \"BrO3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BrO3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BrO3.png\"></HTML>"));
  end BrO3;
  
  package Br2 "Ideal gas \"Br2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Br2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Br2.png\"></HTML>"));
  end Br2;
  
  package BrBrO "Ideal gas \"BrBrO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BrBrO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BrBrO.png\"></HTML>"));
  end BrBrO;
  
  package BrOBr "Ideal gas \"BrOBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.BrOBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/BrOBr.png\"></HTML>"));
  end BrOBr;
  
  package C "Ideal gas \"C\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C.png\"></HTML>"));
  end C;
  
  package Cplus "Ideal gas \"C+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cplus.png\"></HTML>"));
  end Cplus;
  
  package Cminus "Ideal gas \"C-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cminus.png\"></HTML>"));
  end Cminus;
  
  package CBr "Ideal gas \"CBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CBr.png\"></HTML>"));
  end CBr;
  
  package CBr2 "Ideal gas \"CBr2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CBr2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CBr2.png\"></HTML>"));
  end CBr2;
  
  package CBr3 "Ideal gas \"CBr3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CBr3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CBr3.png\"></HTML>"));
  end CBr3;
  
  package CBr4 "Ideal gas \"CBr4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CBr4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CBr4.png\"></HTML>"));
  end CBr4;
  
  package CCL "Ideal gas \"CCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CCL.png\"></HTML>"));
  end CCL;
  
  package CCL2 "Ideal gas \"CCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CCL2.png\"></HTML>"));
  end CCL2;
  
  package CCL2Br2 "Ideal gas \"CCl2Br2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CCL2Br2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CCL2Br2.png\"></HTML>"));
  end CCL2Br2;
  
  package CCL3 "Ideal gas \"CCl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CCL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CCL3.png\"></HTML>"));
  end CCL3;
  
  package CCL3Br "Ideal gas \"CCl3Br\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CCL3Br);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CCL3Br.png\"></HTML>"));
  end CCL3Br;
  
  package CCL4 "Ideal gas \"CCl4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CCL4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CCL4.png\"></HTML>"));
  end CCL4;
  
  package CF "Ideal gas \"CF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CF.png\"></HTML>"));
  end CF;
  
  package CFplus "Ideal gas \"CF+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CFplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CFplus.png\"></HTML>"));
  end CFplus;
  
  package CFBr3 "Ideal gas \"CFBr3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CFBr3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CFBr3.png\"></HTML>"));
  end CFBr3;
  
  package CFCL "Ideal gas \"CFCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CFCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CFCL.png\"></HTML>"));
  end CFCL;
  
  package CFCLBr2 "Ideal gas \"CFClBr2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CFCLBr2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CFCLBr2.png\"></HTML>"));
  end CFCLBr2;
  
  package CFCL2 "Ideal gas \"CFCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CFCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CFCL2.png\"></HTML>"));
  end CFCL2;
  
  package CFCL2Br "Ideal gas \"CFCl2Br\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CFCL2Br);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CFCL2Br.png\"></HTML>"));
  end CFCL2Br;
  
  package CFCL3 "Ideal gas \"CFCl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CFCL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CFCL3.png\"></HTML>"));
  end CFCL3;
  
  package CF2 "Ideal gas \"CF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CF2.png\"></HTML>"));
  end CF2;
  
  package CF2plus "Ideal gas \"CF2+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CF2plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CF2plus.png\"></HTML>"));
  end CF2plus;
  
  package CF2Br2 "Ideal gas \"CF2Br2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CF2Br2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CF2Br2.png\"></HTML>"));
  end CF2Br2;
  
  package CF2CL "Ideal gas \"CF2Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CF2CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CF2CL.png\"></HTML>"));
  end CF2CL;
  
  package CF2CLBr "Ideal gas \"CF2ClBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CF2CLBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CF2CLBr.png\"></HTML>"));
  end CF2CLBr;
  
  package CF2CL2 "Ideal gas \"CF2Cl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CF2CL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CF2CL2.png\"></HTML>"));
  end CF2CL2;
  
  package CF3 "Ideal gas \"CF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CF3.png\"></HTML>"));
  end CF3;
  
  package CF3plus "Ideal gas \"CF3+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CF3plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CF3plus.png\"></HTML>"));
  end CF3plus;
  
  package CF3Br "Ideal gas \"CF3Br\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CF3Br);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CF3Br.png\"></HTML>"));
  end CF3Br;
  
  package CF3CL "Ideal gas \"CF3Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CF3CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CF3CL.png\"></HTML>"));
  end CF3CL;
  
  package CF4 "Ideal gas \"CF4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CF4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CF4.png\"></HTML>"));
  end CF4;
  
  package CHplus "Ideal gas \"CH+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CHplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CHplus.png\"></HTML>"));
  end CHplus;
  
  package CHBr3 "Ideal gas \"CHBr3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CHBr3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CHBr3.png\"></HTML>"));
  end CHBr3;
  
  package CHCL "Ideal gas \"CHCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CHCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CHCL.png\"></HTML>"));
  end CHCL;
  
  package CHCLBr2 "Ideal gas \"CHClBr2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CHCLBr2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CHCLBr2.png\"></HTML>"));
  end CHCLBr2;
  
  package CHCL2 "Ideal gas \"CHCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CHCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CHCL2.png\"></HTML>"));
  end CHCL2;
  
  package CHCL2Br "Ideal gas \"CHCl2Br\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CHCL2Br);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CHCL2Br.png\"></HTML>"));
  end CHCL2Br;
  
  package CHCL3 "Ideal gas \"CHCl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CHCL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CHCL3.png\"></HTML>"));
  end CHCL3;
  
  package CHF "Ideal gas \"CHF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CHF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CHF.png\"></HTML>"));
  end CHF;
  
  package CHFBr2 "Ideal gas \"CHFBr2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CHFBr2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CHFBr2.png\"></HTML>"));
  end CHFBr2;
  
  package CHFCL "Ideal gas \"CHFCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CHFCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CHFCL.png\"></HTML>"));
  end CHFCL;
  
  package CHFCLBr "Ideal gas \"CHFClBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CHFCLBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CHFCLBr.png\"></HTML>"));
  end CHFCLBr;
  
  package CHFCL2 "Ideal gas \"CHFCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CHFCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CHFCL2.png\"></HTML>"));
  end CHFCL2;
  
  package CHF2 "Ideal gas \"CHF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CHF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CHF2.png\"></HTML>"));
  end CHF2;
  
  package CHF2Br "Ideal gas \"CHF2Br\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CHF2Br);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CHF2Br.png\"></HTML>"));
  end CHF2Br;
  
  package CHF2CL "Ideal gas \"CHF2Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CHF2CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CHF2CL.png\"></HTML>"));
  end CHF2CL;
  
  package CHF3 "Ideal gas \"CHF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CHF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CHF3.png\"></HTML>"));
  end CHF3;
  
  package CHI3 "Ideal gas \"CHI3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CHI3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CHI3.png\"></HTML>"));
  end CHI3;
  
  package CH2 "Ideal gas \"CH2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH2.png\"></HTML>"));
  end CH2;
  
  package CH2Br2 "Ideal gas \"CH2Br2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH2Br2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH2Br2.png\"></HTML>"));
  end CH2Br2;
  
  package CH2CL "Ideal gas \"CH2Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH2CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH2CL.png\"></HTML>"));
  end CH2CL;
  
  package CH2CLBr "Ideal gas \"CH2ClBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH2CLBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH2CLBr.png\"></HTML>"));
  end CH2CLBr;
  
  package CH2CL2 "Ideal gas \"CH2Cl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH2CL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH2CL2.png\"></HTML>"));
  end CH2CL2;
  
  package CH2F "Ideal gas \"CH2F\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH2F);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH2F.png\"></HTML>"));
  end CH2F;
  
  package CH2FBr "Ideal gas \"CH2FBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH2FBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH2FBr.png\"></HTML>"));
  end CH2FBr;
  
  package CH2FCL "Ideal gas \"CH2FCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH2FCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH2FCL.png\"></HTML>"));
  end CH2FCL;
  
  package CH2F2 "Ideal gas \"CH2F2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH2F2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH2F2.png\"></HTML>"));
  end CH2F2;
  
  package CH2I2 "Ideal gas \"CH2I2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH2I2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH2I2.png\"></HTML>"));
  end CH2I2;
  
  package CH3 "Ideal gas \"CH3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH3.png\"></HTML>"));
  end CH3;
  
  package CH3Br "Ideal gas \"CH3Br\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH3Br);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH3Br.png\"></HTML>"));
  end CH3Br;
  
  package CH3CL "Ideal gas \"CH3Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH3CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH3CL.png\"></HTML>"));
  end CH3CL;
  
  package CH3F "Ideal gas \"CH3F\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH3F);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH3F.png\"></HTML>"));
  end CH3F;
  
  package CH3I "Ideal gas \"CH3I\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH3I);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH3I.png\"></HTML>"));
  end CH3I;
  
  package CH2OH "Ideal gas \"CH2OH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH2OH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH2OH.png\"></HTML>"));
  end CH2OH;
  
  package CH2OHplus "Ideal gas \"CH2OH+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH2OHplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH2OHplus.png\"></HTML>"));
  end CH2OHplus;
  
  package CH3O "Ideal gas \"CH3O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH3O);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH3O.png\"></HTML>"));
  end CH3O;
  
  package CH4 "Ideal gas \"CH4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH4,
     fluidConstants={Common.FluidData.CH4});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH4.png\"></HTML>"));
  end CH4;
  
  package CH3OH "Ideal gas \"CH3OH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH3OH,
     fluidConstants={Common.FluidData.CH3OH});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH3OH.png\"></HTML>"));
  end CH3OH;
  
  package CH3OOH "Ideal gas \"CH3OOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH3OOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH3OOH.png\"></HTML>"));
  end CH3OOH;
  
  package CI "Ideal gas \"CI\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CI);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CI.png\"></HTML>"));
  end CI;
  
  package CI2 "Ideal gas \"CI2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CI2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CI2.png\"></HTML>"));
  end CI2;
  
  package CI3 "Ideal gas \"CI3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CI3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CI3.png\"></HTML>"));
  end CI3;
  
  package CI4 "Ideal gas \"CI4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CI4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CI4.png\"></HTML>"));
  end CI4;
  
  package CN "Ideal gas \"CN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CN.png\"></HTML>"));
  end CN;
  
  package CNplus "Ideal gas \"CN+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CNplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CNplus.png\"></HTML>"));
  end CNplus;
  
  package CNminus "Ideal gas \"CN-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CNminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CNminus.png\"></HTML>"));
  end CNminus;
  
  package CNN "Ideal gas \"CNN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CNN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CNN.png\"></HTML>"));
  end CNN;
  
  package CO "Ideal gas \"CO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CO,
     fluidConstants={Common.FluidData.CO});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CO.png\"></HTML>"));
  end CO;
  
  package COplus "Ideal gas \"CO+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.COplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/COplus.png\"></HTML>"));
  end COplus;
  
  package COCL "Ideal gas \"COCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.COCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/COCL.png\"></HTML>"));
  end COCL;
  
  package COCL2 "Ideal gas \"COCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.COCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/COCL2.png\"></HTML>"));
  end COCL2;
  
  package COFCL "Ideal gas \"COFCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.COFCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/COFCL.png\"></HTML>"));
  end COFCL;
  
  package COF2 "Ideal gas \"COF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.COF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/COF2.png\"></HTML>"));
  end COF2;
  
  package COHCL "Ideal gas \"COHCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.COHCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/COHCL.png\"></HTML>"));
  end COHCL;
  
  package COHF "Ideal gas \"COHF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.COHF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/COHF.png\"></HTML>"));
  end COHF;
  
  package COS "Ideal gas \"COS\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.COS);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/COS.png\"></HTML>"));
  end COS;
  
  package CO2 "Ideal gas \"CO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CO2,
     fluidConstants={Common.FluidData.CO2});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CO2.png\"></HTML>"));
  end CO2;
  
  package CO2plus "Ideal gas \"CO2+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CO2plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CO2plus.png\"></HTML>"));
  end CO2plus;
  
  package COOH "Ideal gas \"COOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.COOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/COOH.png\"></HTML>"));
  end COOH;
  
  package CP "Ideal gas \"CP\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CP);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CP.png\"></HTML>"));
  end CP;
  
  package CS "Ideal gas \"CS\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CS);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CS.png\"></HTML>"));
  end CS;
  
  package CS2 "Ideal gas \"CS2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CS2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CS2.png\"></HTML>"));
  end CS2;
  
  package C2 "Ideal gas \"C2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2.png\"></HTML>"));
  end C2;
  
  package C2plus "Ideal gas \"C2+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2plus.png\"></HTML>"));
  end C2plus;
  
  package C2minus "Ideal gas \"C2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2minus.png\"></HTML>"));
  end C2minus;
  
  package C2CL "Ideal gas \"C2Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2CL.png\"></HTML>"));
  end C2CL;
  
  package C2CL2 "Ideal gas \"C2Cl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2CL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2CL2.png\"></HTML>"));
  end C2CL2;
  
  package C2CL3 "Ideal gas \"C2Cl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2CL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2CL3.png\"></HTML>"));
  end C2CL3;
  
  package C2CL4 "Ideal gas \"C2Cl4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2CL4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2CL4.png\"></HTML>"));
  end C2CL4;
  
  package C2CL6 "Ideal gas \"C2Cl6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2CL6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2CL6.png\"></HTML>"));
  end C2CL6;
  
  package C2F "Ideal gas \"C2F\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2F);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2F.png\"></HTML>"));
  end C2F;
  
  package C2FCL "Ideal gas \"C2FCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2FCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2FCL.png\"></HTML>"));
  end C2FCL;
  
  package C2FCL3 "Ideal gas \"C2FCl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2FCL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2FCL3.png\"></HTML>"));
  end C2FCL3;
  
  package C2F2 "Ideal gas \"C2F2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2F2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2F2.png\"></HTML>"));
  end C2F2;
  
  package C2F2CL2 "Ideal gas \"C2F2Cl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2F2CL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2F2CL2.png\"></HTML>"));
  end C2F2CL2;
  
  package C2F3 "Ideal gas \"C2F3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2F3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2F3.png\"></HTML>"));
  end C2F3;
  
  package C2F3CL "Ideal gas \"C2F3Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2F3CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2F3CL.png\"></HTML>"));
  end C2F3CL;
  
  package C2F4 "Ideal gas \"C2F4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2F4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2F4.png\"></HTML>"));
  end C2F4;
  
  package C2F6 "Ideal gas \"C2F6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2F6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2F6.png\"></HTML>"));
  end C2F6;
  
  package C2H "Ideal gas \"C2H\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2H);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2H.png\"></HTML>"));
  end C2H;
  
  package C2HCL "Ideal gas \"C2HCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2HCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2HCL.png\"></HTML>"));
  end C2HCL;
  
  package C2HCL3 "Ideal gas \"C2HCl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2HCL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2HCL3.png\"></HTML>"));
  end C2HCL3;
  
  package C2HF "Ideal gas \"C2HF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2HF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2HF.png\"></HTML>"));
  end C2HF;
  
  package C2HFCL2 "Ideal gas \"C2HFCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2HFCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2HFCL2.png\"></HTML>"));
  end C2HFCL2;
  
  package C2HF2CL "Ideal gas \"C2HF2Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2HF2CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2HF2CL.png\"></HTML>"));
  end C2HF2CL;
  
  package C2HF3 "Ideal gas \"C2HF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2HF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2HF3.png\"></HTML>"));
  end C2HF3;
  
  package C2H2_vinylidene 
    "Ideal gas \"C2H2_vinylidene\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2H2_vinylidene,
     fluidConstants={Common.FluidData.C2H2_vinylidene});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2H2_vinylidene.png\"></HTML>"));
  end C2H2_vinylidene;
  
  package C2H2CL2 "Ideal gas \"C2H2Cl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2H2CL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2H2CL2.png\"></HTML>"));
  end C2H2CL2;
  
  package C2H2FCL "Ideal gas \"C2H2FCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2H2FCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2H2FCL.png\"></HTML>"));
  end C2H2FCL;
  
  package C2H2F2 "Ideal gas \"C2H2F2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2H2F2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2H2F2.png\"></HTML>"));
  end C2H2F2;
  
  package CH2CO_ketene 
    "Ideal gas \"CH2CO_ketene\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH2CO_ketene);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH2CO_ketene.png\"></HTML>"));
  end CH2CO_ketene;
  
  package O_CH_2O "Ideal gas \"O_CH_2O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.O_CH_2O);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/O_CH_2O.png\"></HTML>"));
  end O_CH_2O;
  
  package HO_CO_2OH "Ideal gas \"HO_CO_2OH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HO_CO_2OH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HO_CO_2OH.png\"></HTML>"));
  end HO_CO_2OH;
  
  package C2H3_vinyl "Ideal gas \"C2H3_vinyl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2H3_vinyl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2H3_vinyl.png\"></HTML>"));
  end C2H3_vinyl;
  
  package CH2BrminusCOOH 
    "Ideal gas \"CH2Br-COOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH2BrminusCOOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH2BrminusCOOH.png\"></HTML>"));
  end CH2BrminusCOOH;
  
  package C2H3CL "Ideal gas \"C2H3Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2H3CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2H3CL.png\"></HTML>"));
  end C2H3CL;
  
  package CH2CLminusCOOH 
    "Ideal gas \"CH2Cl-COOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH2CLminusCOOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH2CLminusCOOH.png\"></HTML>"));
  end CH2CLminusCOOH;
  
  package C2H3F "Ideal gas \"C2H3F\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2H3F);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2H3F.png\"></HTML>"));
  end C2H3F;
  
  package CH3CN "Ideal gas \"CH3CN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH3CN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH3CN.png\"></HTML>"));
  end CH3CN;
  
  package CH3CO_acetyl 
    "Ideal gas \"CH3CO_acetyl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH3CO_acetyl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH3CO_acetyl.png\"></HTML>"));
  end CH3CO_acetyl;
  
  package C2H4 "Ideal gas \"C2H4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2H4,
     fluidConstants={Common.FluidData.C2H4});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2H4.png\"></HTML>"));
  end C2H4;
  
  package C2H4O_ethylen_o 
    "Ideal gas \"C2H4O_ethylen_o\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2H4O_ethylen_o);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2H4O_ethylen_o.png\"></HTML>"));
  end C2H4O_ethylen_o;
  
  package CH3CHO_ethanal 
    "Ideal gas \"CH3CHO_ethanal\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH3CHO_ethanal);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH3CHO_ethanal.png\"></HTML>"));
  end CH3CHO_ethanal;
  
  package CH3COOH "Ideal gas \"CH3COOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH3COOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH3COOH.png\"></HTML>"));
  end CH3COOH;
  
  package OHCH2COOH "Ideal gas \"OHCH2COOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.OHCH2COOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/OHCH2COOH.png\"></HTML>"));
  end OHCH2COOH;
  
  package C2H5 "Ideal gas \"C2H5\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2H5);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2H5.png\"></HTML>"));
  end C2H5;
  
  package C2H5Br "Ideal gas \"C2H5Br\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2H5Br);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2H5Br.png\"></HTML>"));
  end C2H5Br;
  
  package C2H6 "Ideal gas \"C2H6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2H6,
     fluidConstants={Common.FluidData.C2H6});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2H6.png\"></HTML>"));
  end C2H6;
  
  package CH3N2CH3 "Ideal gas \"CH3N2CH3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH3N2CH3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH3N2CH3.png\"></HTML>"));
  end CH3N2CH3;
  
  package C2H5OH "Ideal gas \"C2H5OH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2H5OH,
     fluidConstants={Common.FluidData.C2H5OH});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2H5OH.png\"></HTML>"));
  end C2H5OH;
  
  package CH3OCH3 "Ideal gas \"CH3OCH3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH3OCH3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH3OCH3.png\"></HTML>"));
  end CH3OCH3;
  
  package CH3O2CH3 "Ideal gas \"CH3O2CH3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH3O2CH3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH3O2CH3.png\"></HTML>"));
  end CH3O2CH3;
  
  package CCN "Ideal gas \"CCN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CCN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CCN.png\"></HTML>"));
  end CCN;
  
  package CNC "Ideal gas \"CNC\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CNC);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CNC.png\"></HTML>"));
  end CNC;
  
  package OCCN "Ideal gas \"OCCN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.OCCN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/OCCN.png\"></HTML>"));
  end OCCN;
  
  package C2N2 "Ideal gas \"C2N2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2N2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2N2.png\"></HTML>"));
  end C2N2;
  
  package C2O "Ideal gas \"C2O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C2O);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C2O.png\"></HTML>"));
  end C2O;
  
  package C3 "Ideal gas \"C3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3.png\"></HTML>"));
  end C3;
  
  package C3H3_1_propynl 
    "Ideal gas \"C3H3_1_propynl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C3H3_1_propynl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3H3_1_propynl.png\"></HTML>"));
  end C3H3_1_propynl;
  
  package C3H3_2_propynl 
    "Ideal gas \"C3H3_2_propynl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C3H3_2_propynl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3H3_2_propynl.png\"></HTML>"));
  end C3H3_2_propynl;
  
  package C3H4_allene "Ideal gas \"C3H4_allene\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C3H4_allene);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3H4_allene.png\"></HTML>"));
  end C3H4_allene;
  
  package C3H4_propyne 
    "Ideal gas \"C3H4_propyne\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C3H4_propyne);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3H4_propyne.png\"></HTML>"));
  end C3H4_propyne;
  
  package C3H4_cyclo "Ideal gas \"C3H4_cyclo\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C3H4_cyclo);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3H4_cyclo.png\"></HTML>"));
  end C3H4_cyclo;
  
  package C3H5_allyl "Ideal gas \"C3H5_allyl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C3H5_allyl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3H5_allyl.png\"></HTML>"));
  end C3H5_allyl;
  
  package C3H6_propylene 
    "Ideal gas \"C3H6_propylene\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C3H6_propylene,
     fluidConstants={Common.FluidData.C3H6_propylene});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3H6_propylene.png\"></HTML>"));
  end C3H6_propylene;
  
  package C3H6_cyclo "Ideal gas \"C3H6_cyclo\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C3H6_cyclo);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3H6_cyclo.png\"></HTML>"));
  end C3H6_cyclo;
  
  package C3H6O_propylox 
    "Ideal gas \"C3H6O_propylox\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C3H6O_propylox);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3H6O_propylox.png\"></HTML>"));
  end C3H6O_propylox;
  
  package C3H6O_acetone 
    "Ideal gas \"C3H6O_acetone\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C3H6O_acetone);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3H6O_acetone.png\"></HTML>"));
  end C3H6O_acetone;
  
  package C3H6O_propanal 
    "Ideal gas \"C3H6O_propanal\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C3H6O_propanal);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3H6O_propanal.png\"></HTML>"));
  end C3H6O_propanal;
  
  package C3H7_n_propyl 
    "Ideal gas \"C3H7_n_propyl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C3H7_n_propyl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3H7_n_propyl.png\"></HTML>"));
  end C3H7_n_propyl;
  
  package C3H7_i_propyl 
    "Ideal gas \"C3H7_i_propyl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C3H7_i_propyl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3H7_i_propyl.png\"></HTML>"));
  end C3H7_i_propyl;
  
  package C3H8 "Ideal gas \"C3H8\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C3H8,
     fluidConstants={Common.FluidData.C3H8});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3H8.png\"></HTML>"));
  end C3H8;
  
  package C3H8O_1propanol 
    "Ideal gas \"C3H8O_1propanol\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C3H8O_1propanol,
     fluidConstants={Common.FluidData.C3H7OH});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3H8O_1propanol.png\"></HTML>"));
  end C3H8O_1propanol;
  
  package C3H8O_2propanol 
    "Ideal gas \"C3H8O_2propanol\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C3H8O_2propanol);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3H8O_2propanol.png\"></HTML>"));
  end C3H8O_2propanol;
  
  package CNCOCN "Ideal gas \"CNCOCN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CNCOCN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CNCOCN.png\"></HTML>"));
  end CNCOCN;
  
  package C3O2 "Ideal gas \"C3O2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C3O2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C3O2.png\"></HTML>"));
  end C3O2;
  
  package C4 "Ideal gas \"C4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C4.png\"></HTML>"));
  end C4;
  
  package C4H2_butadiyne 
    "Ideal gas \"C4H2_butadiyne\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C4H2_butadiyne);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C4H2_butadiyne.png\"></HTML>"));
  end C4H2_butadiyne;
  
  package C4H4_1_3minuscyclo 
    "Ideal gas \"C4H4_1_3-cyclo\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C4H4_1_3minuscyclo);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C4H4_1_3minuscyclo.png\"></HTML>"));
  end C4H4_1_3minuscyclo;
  
  package C4H6_butadiene 
    "Ideal gas \"C4H6_butadiene\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C4H6_butadiene);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C4H6_butadiene.png\"></HTML>"));
  end C4H6_butadiene;
  
  package C4H6_1butyne 
    "Ideal gas \"C4H6_1butyne\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C4H6_1butyne);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C4H6_1butyne.png\"></HTML>"));
  end C4H6_1butyne;
  
  package C4H6_2butyne 
    "Ideal gas \"C4H6_2butyne\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C4H6_2butyne);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C4H6_2butyne.png\"></HTML>"));
  end C4H6_2butyne;
  
  package C4H6_cyclo "Ideal gas \"C4H6_cyclo\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C4H6_cyclo);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C4H6_cyclo.png\"></HTML>"));
  end C4H6_cyclo;
  
  package C4H8_1_butene 
    "Ideal gas \"C4H8_1_butene\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C4H8_1_butene,
     fluidConstants={Common.FluidData.C4H8_1_butene});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C4H8_1_butene.png\"></HTML>"));
  end C4H8_1_butene;
  
  package C4H8_cis2_buten 
    "Ideal gas \"C4H8_cis2_buten\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C4H8_cis2_buten);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C4H8_cis2_buten.png\"></HTML>"));
  end C4H8_cis2_buten;
  
  package C4H8_isobutene 
    "Ideal gas \"C4H8_isobutene\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C4H8_isobutene);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C4H8_isobutene.png\"></HTML>"));
  end C4H8_isobutene;
  
  package C4H8_cyclo "Ideal gas \"C4H8_cyclo\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C4H8_cyclo);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C4H8_cyclo.png\"></HTML>"));
  end C4H8_cyclo;
  
  package C4H9_n_butyl 
    "Ideal gas \"C4H9_n_butyl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C4H9_n_butyl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C4H9_n_butyl.png\"></HTML>"));
  end C4H9_n_butyl;
  
  package C4H9_i_butyl 
    "Ideal gas \"C4H9_i_butyl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C4H9_i_butyl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C4H9_i_butyl.png\"></HTML>"));
  end C4H9_i_butyl;
  
  package C4H9_s_butyl 
    "Ideal gas \"C4H9_s_butyl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C4H9_s_butyl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C4H9_s_butyl.png\"></HTML>"));
  end C4H9_s_butyl;
  
  package C4H9_t_butyl 
    "Ideal gas \"C4H9_t_butyl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C4H9_t_butyl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C4H9_t_butyl.png\"></HTML>"));
  end C4H9_t_butyl;
  
  package C4H10_n_butane 
    "Ideal gas \"C4H10_n_butane\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C4H10_n_butane,
     fluidConstants={Common.FluidData.C4H10_n_butane});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C4H10_n_butane.png\"></HTML>"));
  end C4H10_n_butane;
  
  package C4H10_isobutane 
    "Ideal gas \"C4H10_isobutane\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C4H10_isobutane);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C4H10_isobutane.png\"></HTML>"));
  end C4H10_isobutane;
  
  package C4N2 "Ideal gas \"C4N2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C4N2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C4N2.png\"></HTML>"));
  end C4N2;
  
  package C5 "Ideal gas \"C5\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C5);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C5.png\"></HTML>"));
  end C5;
  
  package C5H6_1_3cyclo 
    "Ideal gas \"C5H6_1_3cyclo\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C5H6_1_3cyclo);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C5H6_1_3cyclo.png\"></HTML>"));
  end C5H6_1_3cyclo;
  
  package C5H8_cyclo "Ideal gas \"C5H8_cyclo\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C5H8_cyclo);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C5H8_cyclo.png\"></HTML>"));
  end C5H8_cyclo;
  
  package C5H10_1_pentene 
    "Ideal gas \"C5H10_1_pentene\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C5H10_1_pentene,
     fluidConstants={Common.FluidData.C5H10_1_pentene});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C5H10_1_pentene.png\"></HTML>"));
  end C5H10_1_pentene;
  
  package C5H10_cyclo "Ideal gas \"C5H10_cyclo\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C5H10_cyclo);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C5H10_cyclo.png\"></HTML>"));
  end C5H10_cyclo;
  
  package C5H11_pentyl 
    "Ideal gas \"C5H11_pentyl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C5H11_pentyl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C5H11_pentyl.png\"></HTML>"));
  end C5H11_pentyl;
  
  package C5H11_t_pentyl 
    "Ideal gas \"C5H11_t_pentyl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C5H11_t_pentyl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C5H11_t_pentyl.png\"></HTML>"));
  end C5H11_t_pentyl;
  
  package C5H12_n_pentane 
    "Ideal gas \"C5H12_n_pentane\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C5H12_n_pentane,
     fluidConstants={Common.FluidData.C5H12_n_pentane});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C5H12_n_pentane.png\"></HTML>"));
  end C5H12_n_pentane;
  
  package C5H12_i_pentane 
    "Ideal gas \"C5H12_i_pentane\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C5H12_i_pentane);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C5H12_i_pentane.png\"></HTML>"));
  end C5H12_i_pentane;
  
  package CH3C_CH3_2CH3 
    "Ideal gas \"CH3C_CH3_2CH3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CH3C_CH3_2CH3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CH3C_CH3_2CH3.png\"></HTML>"));
  end CH3C_CH3_2CH3;
  
  package C6D5_phenyl "Ideal gas \"C6D5_phenyl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C6D5_phenyl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C6D5_phenyl.png\"></HTML>"));
  end C6D5_phenyl;
  
  package C6D6 "Ideal gas \"C6D6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C6D6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C6D6.png\"></HTML>"));
  end C6D6;
  
  package C6H2 "Ideal gas \"C6H2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C6H2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C6H2.png\"></HTML>"));
  end C6H2;
  
  package C6H5_phenyl "Ideal gas \"C6H5_phenyl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C6H5_phenyl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C6H5_phenyl.png\"></HTML>"));
  end C6H5_phenyl;
  
  package C6H5O_phenoxy 
    "Ideal gas \"C6H5O_phenoxy\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C6H5O_phenoxy);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C6H5O_phenoxy.png\"></HTML>"));
  end C6H5O_phenoxy;
  
  package C6H6 "Ideal gas \"C6H6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C6H6,
     fluidConstants={Common.FluidData.C6H6});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C6H6.png\"></HTML>"));
  end C6H6;
  
  package C6H5OH_phenol 
    "Ideal gas \"C6H5OH_phenol\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C6H5OH_phenol);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C6H5OH_phenol.png\"></HTML>"));
  end C6H5OH_phenol;
  
  package C6H10_cyclo "Ideal gas \"C6H10_cyclo\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C6H10_cyclo);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C6H10_cyclo.png\"></HTML>"));
  end C6H10_cyclo;
  
  package C6H12_1_hexene 
    "Ideal gas \"C6H12_1_hexene\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C6H12_1_hexene,
     fluidConstants={Common.FluidData.C6H12_1_hexene});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C6H12_1_hexene.png\"></HTML>"));
  end C6H12_1_hexene;
  
  package C6H12_cyclo "Ideal gas \"C6H12_cyclo\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C6H12_cyclo);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C6H12_cyclo.png\"></HTML>"));
  end C6H12_cyclo;
  
  package C6H13_n_hexyl 
    "Ideal gas \"C6H13_n_hexyl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C6H13_n_hexyl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C6H13_n_hexyl.png\"></HTML>"));
  end C6H13_n_hexyl;
  
  package C6H14_n_hexane 
    "Ideal gas \"C6H14_n_hexane\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C6H14_n_hexane,
     fluidConstants={Common.FluidData.C6H14_n_hexane});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C6H14_n_hexane.png\"></HTML>"));
  end C6H14_n_hexane;
  
  package C7H7_benzyl "Ideal gas \"C7H7_benzyl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C7H7_benzyl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C7H7_benzyl.png\"></HTML>"));
  end C7H7_benzyl;
  
  package C7H8 "Ideal gas \"C7H8\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C7H8);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C7H8.png\"></HTML>"));
  end C7H8;
  
  package C7H8O_cresol_mx 
    "Ideal gas \"C7H8O_cresol_mx\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C7H8O_cresol_mx);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C7H8O_cresol_mx.png\"></HTML>"));
  end C7H8O_cresol_mx;
  
  package C7H14_1_heptene 
    "Ideal gas \"C7H14_1_heptene\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C7H14_1_heptene,
     fluidConstants={Common.FluidData.C7H14_1_heptene});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C7H14_1_heptene.png\"></HTML>"));
  end C7H14_1_heptene;
  
  package C7H15_n_heptyl 
    "Ideal gas \"C7H15_n_heptyl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C7H15_n_heptyl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C7H15_n_heptyl.png\"></HTML>"));
  end C7H15_n_heptyl;
  
  package C7H16_n_heptane 
    "Ideal gas \"C7H16_n_heptane\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C7H16_n_heptane,
     fluidConstants={Common.FluidData.C7H16_n_heptane});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C7H16_n_heptane.png\"></HTML>"));
  end C7H16_n_heptane;
  
  package C7H16_2_methylh 
    "Ideal gas \"C7H16_2_methylh\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C7H16_2_methylh);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C7H16_2_methylh.png\"></HTML>"));
  end C7H16_2_methylh;
  
  package C8H8_styrene 
    "Ideal gas \"C8H8_styrene\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C8H8_styrene);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C8H8_styrene.png\"></HTML>"));
  end C8H8_styrene;
  
  package C8H10_ethylbenz 
    "Ideal gas \"C8H10_ethylbenz\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C8H10_ethylbenz,
     fluidConstants={Common.FluidData.C8H10_ethylbenz});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C8H10_ethylbenz.png\"></HTML>"));
  end C8H10_ethylbenz;
  
  package C8H16_1_octene 
    "Ideal gas \"C8H16_1_octene\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C8H16_1_octene);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C8H16_1_octene.png\"></HTML>"));
  end C8H16_1_octene;
  
  package C8H17_n_octyl 
    "Ideal gas \"C8H17_n_octyl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C8H17_n_octyl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C8H17_n_octyl.png\"></HTML>"));
  end C8H17_n_octyl;
  
  package C8H18_n_octane 
    "Ideal gas \"C8H18_n_octane\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C8H18_n_octane,
     fluidConstants={Common.FluidData.C8H18_n_octane});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C8H18_n_octane.png\"></HTML>"));
  end C8H18_n_octane;
  
  package C8H18_isooctane 
    "Ideal gas \"C8H18_isooctane\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C8H18_isooctane);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C8H18_isooctane.png\"></HTML>"));
  end C8H18_isooctane;
  
  package C9H19_n_nonyl 
    "Ideal gas \"C9H19_n_nonyl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C9H19_n_nonyl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C9H19_n_nonyl.png\"></HTML>"));
  end C9H19_n_nonyl;
  
  package C10H8_naphthale 
    "Ideal gas \"C10H8_naphthale\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C10H8_naphthale);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C10H8_naphthale.png\"></HTML>"));
  end C10H8_naphthale;
  
  package C10H21_n_decyl 
    "Ideal gas \"C10H21_n_decyl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C10H21_n_decyl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C10H21_n_decyl.png\"></HTML>"));
  end C10H21_n_decyl;
  
  package C12H9_o_bipheny 
    "Ideal gas \"C12H9_o_bipheny\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C12H9_o_bipheny);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C12H9_o_bipheny.png\"></HTML>"));
  end C12H9_o_bipheny;
  
  package C12H10_biphenyl 
    "Ideal gas \"C12H10_biphenyl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.C12H10_biphenyl);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/C12H10_biphenyl.png\"></HTML>"));
  end C12H10_biphenyl;
  
  package Ca "Ideal gas \"Ca\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ca);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ca.png\"></HTML>"));
  end Ca;
  
  package Caplus "Ideal gas \"Ca+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Caplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Caplus.png\"></HTML>"));
  end Caplus;
  
  package CaBr "Ideal gas \"CaBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CaBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CaBr.png\"></HTML>"));
  end CaBr;
  
  package CaBr2 "Ideal gas \"CaBr2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CaBr2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CaBr2.png\"></HTML>"));
  end CaBr2;
  
  package CaCL "Ideal gas \"CaCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CaCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CaCL.png\"></HTML>"));
  end CaCL;
  
  package CaCLplus "Ideal gas \"CaCl+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CaCLplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CaCLplus.png\"></HTML>"));
  end CaCLplus;
  
  package CaCL2 "Ideal gas \"CaCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CaCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CaCL2.png\"></HTML>"));
  end CaCL2;
  
  package CaF "Ideal gas \"CaF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CaF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CaF.png\"></HTML>"));
  end CaF;
  
  package CaFplus "Ideal gas \"CaF+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CaFplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CaFplus.png\"></HTML>"));
  end CaFplus;
  
  package CaF2 "Ideal gas \"CaF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CaF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CaF2.png\"></HTML>"));
  end CaF2;
  
  package CaH "Ideal gas \"CaH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CaH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CaH.png\"></HTML>"));
  end CaH;
  
  package CaI "Ideal gas \"CaI\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CaI);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CaI.png\"></HTML>"));
  end CaI;
  
  package CaI2 "Ideal gas \"CaI2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CaI2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CaI2.png\"></HTML>"));
  end CaI2;
  
  package CaO "Ideal gas \"CaO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CaO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CaO.png\"></HTML>"));
  end CaO;
  
  package CaOplus "Ideal gas \"CaO+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CaOplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CaOplus.png\"></HTML>"));
  end CaOplus;
  
  package CaOH "Ideal gas \"CaOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CaOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CaOH.png\"></HTML>"));
  end CaOH;
  
  package CaOHplus "Ideal gas \"CaOH+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CaOHplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CaOHplus.png\"></HTML>"));
  end CaOHplus;
  
  package Ca_OH_2 "Ideal gas \"Ca_OH_2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ca_OH_2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ca_OH_2.png\"></HTML>"));
  end Ca_OH_2;
  
  package CaS "Ideal gas \"CaS\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CaS);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CaS.png\"></HTML>"));
  end CaS;
  
  package Ca2 "Ideal gas \"Ca2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ca2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ca2.png\"></HTML>"));
  end Ca2;
  
  package Cd "Ideal gas \"Cd\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cd);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cd.png\"></HTML>"));
  end Cd;
  
  package Cdplus "Ideal gas \"Cd+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cdplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cdplus.png\"></HTML>"));
  end Cdplus;
  
  package CL "Ideal gas \"Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CL.png\"></HTML>"));
  end CL;
  
  package CLplus "Ideal gas \"Cl+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CLplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CLplus.png\"></HTML>"));
  end CLplus;
  
  package CLminus "Ideal gas \"Cl-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CLminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CLminus.png\"></HTML>"));
  end CLminus;
  
  package CLCN "Ideal gas \"ClCN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CLCN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CLCN.png\"></HTML>"));
  end CLCN;
  
  package CLF "Ideal gas \"ClF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CLF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CLF.png\"></HTML>"));
  end CLF;
  
  package CLF3 "Ideal gas \"ClF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CLF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CLF3.png\"></HTML>"));
  end CLF3;
  
  package CLF5 "Ideal gas \"ClF5\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CLF5);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CLF5.png\"></HTML>"));
  end CLF5;
  
  package CLO "Ideal gas \"ClO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CLO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CLO.png\"></HTML>"));
  end CLO;
  
  package CLO2 "Ideal gas \"ClO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CLO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CLO2.png\"></HTML>"));
  end CLO2;
  
  package CL2 "Ideal gas \"Cl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CL2,
     fluidConstants={Common.FluidData.CL2});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CL2.png\"></HTML>"));
  end CL2;
  
  package CL2O "Ideal gas \"Cl2O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CL2O);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CL2O.png\"></HTML>"));
  end CL2O;
  
  package Co "Ideal gas \"Co\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Co);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Co.png\"></HTML>"));
  end Co;
  
  package Coplus "Ideal gas \"Co+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Coplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Coplus.png\"></HTML>"));
  end Coplus;
  
  package Cominus "Ideal gas \"Co-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cominus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cominus.png\"></HTML>"));
  end Cominus;
  
  package Cr "Ideal gas \"Cr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cr.png\"></HTML>"));
  end Cr;
  
  package Crplus "Ideal gas \"Cr+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Crplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Crplus.png\"></HTML>"));
  end Crplus;
  
  package Crminus "Ideal gas \"Cr-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Crminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Crminus.png\"></HTML>"));
  end Crminus;
  
  package CrN "Ideal gas \"CrN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CrN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CrN.png\"></HTML>"));
  end CrN;
  
  package CrO "Ideal gas \"CrO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CrO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CrO.png\"></HTML>"));
  end CrO;
  
  package CrO2 "Ideal gas \"CrO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CrO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CrO2.png\"></HTML>"));
  end CrO2;
  
  package CrO3 "Ideal gas \"CrO3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CrO3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CrO3.png\"></HTML>"));
  end CrO3;
  
  package CrO3minus "Ideal gas \"CrO3-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CrO3minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CrO3minus.png\"></HTML>"));
  end CrO3minus;
  
  package Cs "Ideal gas \"Cs\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cs);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cs.png\"></HTML>"));
  end Cs;
  
  package Csplus "Ideal gas \"Cs+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Csplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Csplus.png\"></HTML>"));
  end Csplus;
  
  package Csminus "Ideal gas \"Cs-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Csminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Csminus.png\"></HTML>"));
  end Csminus;
  
  package CsBO2 "Ideal gas \"CsBO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CsBO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CsBO2.png\"></HTML>"));
  end CsBO2;
  
  package CsBr "Ideal gas \"CsBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CsBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CsBr.png\"></HTML>"));
  end CsBr;
  
  package CsCL "Ideal gas \"CsCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CsCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CsCL.png\"></HTML>"));
  end CsCL;
  
  package CsF "Ideal gas \"CsF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CsF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CsF.png\"></HTML>"));
  end CsF;
  
  package CsH "Ideal gas \"CsH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CsH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CsH.png\"></HTML>"));
  end CsH;
  
  package CsI "Ideal gas \"CsI\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CsI);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CsI.png\"></HTML>"));
  end CsI;
  
  package CsLi "Ideal gas \"Csli\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CsLi);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CsLi.png\"></HTML>"));
  end CsLi;
  
  package CsNO2 "Ideal gas \"CsNO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CsNO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CsNO2.png\"></HTML>"));
  end CsNO2;
  
  package CsNO3 "Ideal gas \"CsNO3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CsNO3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CsNO3.png\"></HTML>"));
  end CsNO3;
  
  package CsNa "Ideal gas \"CsNa\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CsNa);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CsNa.png\"></HTML>"));
  end CsNa;
  
  package CsO "Ideal gas \"CsO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CsO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CsO.png\"></HTML>"));
  end CsO;
  
  package CsOH "Ideal gas \"CsOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CsOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CsOH.png\"></HTML>"));
  end CsOH;
  
  package CsRb "Ideal gas \"CsRb\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CsRb);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CsRb.png\"></HTML>"));
  end CsRb;
  
  package Cs2 "Ideal gas \"Cs2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cs2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cs2.png\"></HTML>"));
  end Cs2;
  
  package Cs2Br2 "Ideal gas \"Cs2Br2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cs2Br2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cs2Br2.png\"></HTML>"));
  end Cs2Br2;
  
  package Cs2CO3 "Ideal gas \"Cs2CO3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cs2CO3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cs2CO3.png\"></HTML>"));
  end Cs2CO3;
  
  package Cs2CL2 "Ideal gas \"Cs2Cl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cs2CL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cs2CL2.png\"></HTML>"));
  end Cs2CL2;
  
  package Cs2F2 "Ideal gas \"Cs2F2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cs2F2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cs2F2.png\"></HTML>"));
  end Cs2F2;
  
  package Cs2I2 "Ideal gas \"Cs2I2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cs2I2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cs2I2.png\"></HTML>"));
  end Cs2I2;
  
  package Cs2O "Ideal gas \"Cs2O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cs2O);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cs2O.png\"></HTML>"));
  end Cs2O;
  
  package Cs2Oplus "Ideal gas \"Cs2O+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cs2Oplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cs2Oplus.png\"></HTML>"));
  end Cs2Oplus;
  
  package Cs2O2 "Ideal gas \"Cs2O2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cs2O2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cs2O2.png\"></HTML>"));
  end Cs2O2;
  
  package Cs2O2H2 "Ideal gas \"Cs2O2H2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cs2O2H2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cs2O2H2.png\"></HTML>"));
  end Cs2O2H2;
  
  package Cs2SO4 "Ideal gas \"Cs2SO4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cs2SO4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cs2SO4.png\"></HTML>"));
  end Cs2SO4;
  
  package Cu "Ideal gas \"Cu\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cu);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cu.png\"></HTML>"));
  end Cu;
  
  package Cuplus "Ideal gas \"Cu+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cuplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cuplus.png\"></HTML>"));
  end Cuplus;
  
  package Cuminus "Ideal gas \"Cu-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cuminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cuminus.png\"></HTML>"));
  end Cuminus;
  
  package CuCL "Ideal gas \"CuCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CuCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CuCL.png\"></HTML>"));
  end CuCL;
  
  package CuF "Ideal gas \"CuF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CuF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CuF.png\"></HTML>"));
  end CuF;
  
  package CuF2 "Ideal gas \"CuF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CuF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CuF2.png\"></HTML>"));
  end CuF2;
  
  package CuO "Ideal gas \"CuO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.CuO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/CuO.png\"></HTML>"));
  end CuO;
  
  package Cu2 "Ideal gas \"Cu2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cu2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cu2.png\"></HTML>"));
  end Cu2;
  
  package Cu3CL3 "Ideal gas \"Cu3Cl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Cu3CL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Cu3CL3.png\"></HTML>"));
  end Cu3CL3;
  
  package D "Ideal gas \"D\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.D);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/D.png\"></HTML>"));
  end D;
  
  package Dplus "Ideal gas \"D+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Dplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Dplus.png\"></HTML>"));
  end Dplus;
  
  package Dminus "Ideal gas \"D-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Dminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Dminus.png\"></HTML>"));
  end Dminus;
  
  package DBr "Ideal gas \"DBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.DBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/DBr.png\"></HTML>"));
  end DBr;
  
  package DCL "Ideal gas \"DCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.DCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/DCL.png\"></HTML>"));
  end DCL;
  
  package DF "Ideal gas \"DF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.DF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/DF.png\"></HTML>"));
  end DF;
  
  package DOCL "Ideal gas \"DOCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.DOCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/DOCL.png\"></HTML>"));
  end DOCL;
  
  package DO2 "Ideal gas \"DO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.DO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/DO2.png\"></HTML>"));
  end DO2;
  
  package DO2minus "Ideal gas \"DO2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.DO2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/DO2minus.png\"></HTML>"));
  end DO2minus;
  
  package D2 "Ideal gas \"D2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.D2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/D2.png\"></HTML>"));
  end D2;
  
  package D2plus "Ideal gas \"D2+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.D2plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/D2plus.png\"></HTML>"));
  end D2plus;
  
  package D2minus "Ideal gas \"D2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.D2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/D2minus.png\"></HTML>"));
  end D2minus;
  
  package D2O "Ideal gas \"D2O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.D2O);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/D2O.png\"></HTML>"));
  end D2O;
  
  package D2O2 "Ideal gas \"D2O2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.D2O2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/D2O2.png\"></HTML>"));
  end D2O2;
  
  package D2S "Ideal gas \"D2S\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.D2S);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/D2S.png\"></HTML>"));
  end D2S;
  
  package eminus "Ideal gas \"e-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.eminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/eminus.png\"></HTML>"));
  end eminus;
  
  package F "Ideal gas \"F\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.F);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/F.png\"></HTML>"));
  end F;
  
  package Fplus "Ideal gas \"F+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Fplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Fplus.png\"></HTML>"));
  end Fplus;
  
  package Fminus "Ideal gas \"F-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Fminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Fminus.png\"></HTML>"));
  end Fminus;
  
  package FCN "Ideal gas \"FCN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.FCN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/FCN.png\"></HTML>"));
  end FCN;
  
  package FCO "Ideal gas \"FCO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.FCO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/FCO.png\"></HTML>"));
  end FCO;
  
  package FO "Ideal gas \"FO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.FO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/FO.png\"></HTML>"));
  end FO;
  
  package FO2_FOO "Ideal gas \"FO2_FOO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.FO2_FOO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/FO2_FOO.png\"></HTML>"));
  end FO2_FOO;
  
  package FO2_OFO "Ideal gas \"FO2_OFO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.FO2_OFO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/FO2_OFO.png\"></HTML>"));
  end FO2_OFO;
  
  package F2 "Ideal gas \"F2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.F2,
     fluidConstants={Common.FluidData.F2});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/F2.png\"></HTML>"));
  end F2;
  
  package F2O "Ideal gas \"F2O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.F2O);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/F2O.png\"></HTML>"));
  end F2O;
  
  package F2O2 "Ideal gas \"F2O2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.F2O2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/F2O2.png\"></HTML>"));
  end F2O2;
  
  package FS2F "Ideal gas \"FS2F\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.FS2F);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/FS2F.png\"></HTML>"));
  end FS2F;
  
  package Fe "Ideal gas \"Fe\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Fe);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Fe.png\"></HTML>"));
  end Fe;
  
  package Feplus "Ideal gas \"Fe+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Feplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Feplus.png\"></HTML>"));
  end Feplus;
  
  package Fe_CO_5 "Ideal gas \"Fe_CO_5\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Fe_CO_5);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Fe_CO_5.png\"></HTML>"));
  end Fe_CO_5;
  
  package FeCL "Ideal gas \"FeCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.FeCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/FeCL.png\"></HTML>"));
  end FeCL;
  
  package FeCL2 "Ideal gas \"FeCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.FeCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/FeCL2.png\"></HTML>"));
  end FeCL2;
  
  package FeCL3 "Ideal gas \"FeCl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.FeCL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/FeCL3.png\"></HTML>"));
  end FeCL3;
  
  package FeO "Ideal gas \"FeO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.FeO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/FeO.png\"></HTML>"));
  end FeO;
  
  package Fe_OH_2 "Ideal gas \"Fe_OH_2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Fe_OH_2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Fe_OH_2.png\"></HTML>"));
  end Fe_OH_2;
  
  package Fe2CL4 "Ideal gas \"Fe2Cl4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Fe2CL4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Fe2CL4.png\"></HTML>"));
  end Fe2CL4;
  
  package Fe2CL6 "Ideal gas \"Fe2Cl6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Fe2CL6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Fe2CL6.png\"></HTML>"));
  end Fe2CL6;
  
  package Ga "Ideal gas \"Ga\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ga);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ga.png\"></HTML>"));
  end Ga;
  
  package Gaplus "Ideal gas \"Ga+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Gaplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Gaplus.png\"></HTML>"));
  end Gaplus;
  
  package GaBr "Ideal gas \"GaBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GaBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GaBr.png\"></HTML>"));
  end GaBr;
  
  package GaBr2 "Ideal gas \"GaBr2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GaBr2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GaBr2.png\"></HTML>"));
  end GaBr2;
  
  package GaBr3 "Ideal gas \"GaBr3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GaBr3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GaBr3.png\"></HTML>"));
  end GaBr3;
  
  package GaCL "Ideal gas \"GaCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GaCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GaCL.png\"></HTML>"));
  end GaCL;
  
  package GaCL2 "Ideal gas \"GaCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GaCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GaCL2.png\"></HTML>"));
  end GaCL2;
  
  package GaCL3 "Ideal gas \"GaCl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GaCL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GaCL3.png\"></HTML>"));
  end GaCL3;
  
  package GaF "Ideal gas \"GaF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GaF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GaF.png\"></HTML>"));
  end GaF;
  
  package GaF2 "Ideal gas \"GaF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GaF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GaF2.png\"></HTML>"));
  end GaF2;
  
  package GaF3 "Ideal gas \"GaF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GaF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GaF3.png\"></HTML>"));
  end GaF3;
  
  package GaH "Ideal gas \"GaH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GaH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GaH.png\"></HTML>"));
  end GaH;
  
  package GaI "Ideal gas \"GaI\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GaI);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GaI.png\"></HTML>"));
  end GaI;
  
  package GaI2 "Ideal gas \"GaI2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GaI2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GaI2.png\"></HTML>"));
  end GaI2;
  
  package GaI3 "Ideal gas \"GaI3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GaI3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GaI3.png\"></HTML>"));
  end GaI3;
  
  package GaO "Ideal gas \"GaO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GaO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GaO.png\"></HTML>"));
  end GaO;
  
  package GaOH "Ideal gas \"GaOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GaOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GaOH.png\"></HTML>"));
  end GaOH;
  
  package Ga2Br2 "Ideal gas \"Ga2Br2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ga2Br2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ga2Br2.png\"></HTML>"));
  end Ga2Br2;
  
  package Ga2Br4 "Ideal gas \"Ga2Br4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ga2Br4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ga2Br4.png\"></HTML>"));
  end Ga2Br4;
  
  package Ga2Br6 "Ideal gas \"Ga2Br6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ga2Br6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ga2Br6.png\"></HTML>"));
  end Ga2Br6;
  
  package Ga2CL2 "Ideal gas \"Ga2Cl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ga2CL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ga2CL2.png\"></HTML>"));
  end Ga2CL2;
  
  package Ga2CL4 "Ideal gas \"Ga2Cl4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ga2CL4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ga2CL4.png\"></HTML>"));
  end Ga2CL4;
  
  package Ga2CL6 "Ideal gas \"Ga2Cl6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ga2CL6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ga2CL6.png\"></HTML>"));
  end Ga2CL6;
  
  package Ga2F2 "Ideal gas \"Ga2F2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ga2F2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ga2F2.png\"></HTML>"));
  end Ga2F2;
  
  package Ga2F4 "Ideal gas \"Ga2F4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ga2F4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ga2F4.png\"></HTML>"));
  end Ga2F4;
  
  package Ga2F6 "Ideal gas \"Ga2F6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ga2F6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ga2F6.png\"></HTML>"));
  end Ga2F6;
  
  package Ga2I2 "Ideal gas \"Ga2I2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ga2I2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ga2I2.png\"></HTML>"));
  end Ga2I2;
  
  package Ga2I4 "Ideal gas \"Ga2I4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ga2I4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ga2I4.png\"></HTML>"));
  end Ga2I4;
  
  package Ga2I6 "Ideal gas \"Ga2I6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ga2I6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ga2I6.png\"></HTML>"));
  end Ga2I6;
  
  package Ga2O "Ideal gas \"Ga2O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ga2O);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ga2O.png\"></HTML>"));
  end Ga2O;
  
  package Ge "Ideal gas \"Ge\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ge);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ge.png\"></HTML>"));
  end Ge;
  
  package Geplus "Ideal gas \"Ge+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Geplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Geplus.png\"></HTML>"));
  end Geplus;
  
  package Geminus "Ideal gas \"Ge-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Geminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Geminus.png\"></HTML>"));
  end Geminus;
  
  package GeBr "Ideal gas \"GeBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GeBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GeBr.png\"></HTML>"));
  end GeBr;
  
  package GeBr2 "Ideal gas \"GeBr2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GeBr2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GeBr2.png\"></HTML>"));
  end GeBr2;
  
  package GeBr3 "Ideal gas \"GeBr3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GeBr3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GeBr3.png\"></HTML>"));
  end GeBr3;
  
  package GeBr4 "Ideal gas \"GeBr4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GeBr4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GeBr4.png\"></HTML>"));
  end GeBr4;
  
  package GeCL "Ideal gas \"GeCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GeCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GeCL.png\"></HTML>"));
  end GeCL;
  
  package GeCL2 "Ideal gas \"GeCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GeCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GeCL2.png\"></HTML>"));
  end GeCL2;
  
  package GeCL3 "Ideal gas \"GeCl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GeCL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GeCL3.png\"></HTML>"));
  end GeCL3;
  
  package GeCL4 "Ideal gas \"GeCl4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GeCL4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GeCL4.png\"></HTML>"));
  end GeCL4;
  
  package GeF "Ideal gas \"GeF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GeF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GeF.png\"></HTML>"));
  end GeF;
  
  package GeF2 "Ideal gas \"GeF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GeF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GeF2.png\"></HTML>"));
  end GeF2;
  
  package GeF3 "Ideal gas \"GeF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GeF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GeF3.png\"></HTML>"));
  end GeF3;
  
  package GeF4 "Ideal gas \"GeF4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GeF4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GeF4.png\"></HTML>"));
  end GeF4;
  
  package GeH4 "Ideal gas \"GeH4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GeH4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GeH4.png\"></HTML>"));
  end GeH4;
  
  package GeI "Ideal gas \"GeI\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GeI);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GeI.png\"></HTML>"));
  end GeI;
  
  package GeO "Ideal gas \"GeO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GeO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GeO.png\"></HTML>"));
  end GeO;
  
  package GeO2 "Ideal gas \"GeO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GeO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GeO2.png\"></HTML>"));
  end GeO2;
  
  package GeS "Ideal gas \"GeS\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GeS);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GeS.png\"></HTML>"));
  end GeS;
  
  package GeS2 "Ideal gas \"GeS2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.GeS2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/GeS2.png\"></HTML>"));
  end GeS2;
  
  package Ge2 "Ideal gas \"Ge2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ge2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ge2.png\"></HTML>"));
  end Ge2;
  
  package H "Ideal gas \"H\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.H);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H.png\"></HTML>"));
  end H;
  
  package Hplus "Ideal gas \"H+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Hplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Hplus.png\"></HTML>"));
  end Hplus;
  
  package Hminus "Ideal gas \"H-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Hminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Hminus.png\"></HTML>"));
  end Hminus;
  
  package HALO "Ideal gas \"HAlO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HALO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HALO.png\"></HTML>"));
  end HALO;
  
  package HALO2 "Ideal gas \"HAlO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HALO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HALO2.png\"></HTML>"));
  end HALO2;
  
  package HBO "Ideal gas \"HBO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HBO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HBO.png\"></HTML>"));
  end HBO;
  
  package HBOplus "Ideal gas \"HBO+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HBOplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HBOplus.png\"></HTML>"));
  end HBOplus;
  
  package HBO2 "Ideal gas \"HBO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HBO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HBO2.png\"></HTML>"));
  end HBO2;
  
  package HBS "Ideal gas \"HBS\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HBS);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HBS.png\"></HTML>"));
  end HBS;
  
  package HBSplus "Ideal gas \"HBS+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HBSplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HBSplus.png\"></HTML>"));
  end HBSplus;
  
  package HCN "Ideal gas \"HCN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HCN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HCN.png\"></HTML>"));
  end HCN;
  
  package HCO "Ideal gas \"HCO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HCO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HCO.png\"></HTML>"));
  end HCO;
  
  package HCOplus "Ideal gas \"HCO+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HCOplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HCOplus.png\"></HTML>"));
  end HCOplus;
  
  package HCCN "Ideal gas \"HCCN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HCCN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HCCN.png\"></HTML>"));
  end HCCN;
  
  package HCCO "Ideal gas \"HCCO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HCCO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HCCO.png\"></HTML>"));
  end HCCO;
  
  package HCL "Ideal gas \"HCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HCL.png\"></HTML>"));
  end HCL;
  
  package HD "Ideal gas \"HD\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HD);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HD.png\"></HTML>"));
  end HD;
  
  package HDplus "Ideal gas \"HD+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HDplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HDplus.png\"></HTML>"));
  end HDplus;
  
  package HDO "Ideal gas \"HDO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HDO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HDO.png\"></HTML>"));
  end HDO;
  
  package HDO2 "Ideal gas \"HDO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HDO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HDO2.png\"></HTML>"));
  end HDO2;
  
  package HF "Ideal gas \"HF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HF.png\"></HTML>"));
  end HF;
  
  package HI "Ideal gas \"HI\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HI);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HI.png\"></HTML>"));
  end HI;
  
  package HNC "Ideal gas \"HNC\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HNC);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HNC.png\"></HTML>"));
  end HNC;
  
  package HNCO "Ideal gas \"HNCO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HNCO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HNCO.png\"></HTML>"));
  end HNCO;
  
  package HNO "Ideal gas \"HNO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HNO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HNO.png\"></HTML>"));
  end HNO;
  
  package HNO2 "Ideal gas \"HNO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HNO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HNO2.png\"></HTML>"));
  end HNO2;
  
  package HNO3 "Ideal gas \"HNO3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HNO3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HNO3.png\"></HTML>"));
  end HNO3;
  
  package HOCL "Ideal gas \"HOCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HOCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HOCL.png\"></HTML>"));
  end HOCL;
  
  package HOF "Ideal gas \"HOF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HOF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HOF.png\"></HTML>"));
  end HOF;
  
  package HO2 "Ideal gas \"HO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HO2.png\"></HTML>"));
  end HO2;
  
  package HO2minus "Ideal gas \"HO2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HO2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HO2minus.png\"></HTML>"));
  end HO2minus;
  
  package HPO "Ideal gas \"HPO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HPO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HPO.png\"></HTML>"));
  end HPO;
  
  package HSO3F "Ideal gas \"HSO3F\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HSO3F);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HSO3F.png\"></HTML>"));
  end HSO3F;
  
  package H2 "Ideal gas \"H2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.H2,
     fluidConstants={Common.FluidData.H2});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H2.png\"></HTML>"));
  end H2;
  
  package H2plus "Ideal gas \"H2+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.H2plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H2plus.png\"></HTML>"));
  end H2plus;
  
  package H2minus "Ideal gas \"H2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.H2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H2minus.png\"></HTML>"));
  end H2minus;
  
  package HBOH "Ideal gas \"HBOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HBOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HBOH.png\"></HTML>"));
  end HBOH;
  
  package HCOOH "Ideal gas \"HCOOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HCOOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HCOOH.png\"></HTML>"));
  end HCOOH;
  
  package H2F2 "Ideal gas \"H2F2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.H2F2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H2F2.png\"></HTML>"));
  end H2F2;
  
  package H2O "Ideal gas \"H2O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.H2O,
     fluidConstants={Common.FluidData.H2O});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H2O.png\"></HTML>"));
  end H2O;
  
  package H2Oplus "Ideal gas \"H2O+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.H2Oplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H2Oplus.png\"></HTML>"));
  end H2Oplus;
  
  package H2O2 "Ideal gas \"H2O2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.H2O2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H2O2.png\"></HTML>"));
  end H2O2;
  
  package H2S "Ideal gas \"H2S\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.H2S);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H2S.png\"></HTML>"));
  end H2S;
  
  package H2SO4 "Ideal gas \"H2SO4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.H2SO4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H2SO4.png\"></HTML>"));
  end H2SO4;
  
  package H2BOH "Ideal gas \"H2BOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.H2BOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H2BOH.png\"></HTML>"));
  end H2BOH;
  
  package HB_OH_2 "Ideal gas \"HB_OH_2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HB_OH_2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HB_OH_2.png\"></HTML>"));
  end HB_OH_2;
  
  package H3BO3 "Ideal gas \"H3BO3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.H3BO3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H3BO3.png\"></HTML>"));
  end H3BO3;
  
  package H3B3O3 "Ideal gas \"H3B3O3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.H3B3O3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H3B3O3.png\"></HTML>"));
  end H3B3O3;
  
  package H3B3O6 "Ideal gas \"H3B3O6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.H3B3O6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H3B3O6.png\"></HTML>"));
  end H3B3O6;
  
  package H3F3 "Ideal gas \"H3F3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.H3F3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H3F3.png\"></HTML>"));
  end H3F3;
  
  package H3Oplus "Ideal gas \"H3O+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.H3Oplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H3Oplus.png\"></HTML>"));
  end H3Oplus;
  
  package H4F4 "Ideal gas \"H4F4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.H4F4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H4F4.png\"></HTML>"));
  end H4F4;
  
  package H5F5 "Ideal gas \"H5F5\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.H5F5);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H5F5.png\"></HTML>"));
  end H5F5;
  
  package H6F6 "Ideal gas \"H6F6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.H6F6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H6F6.png\"></HTML>"));
  end H6F6;
  
  package H7F7 "Ideal gas \"H7F7\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.H7F7);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/H7F7.png\"></HTML>"));
  end H7F7;
  
  package He "Ideal gas \"He\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.He,
     fluidConstants={Common.FluidData.He});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/He.png\"></HTML>"));
  end He;
  
  package Heplus "Ideal gas \"He+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Heplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Heplus.png\"></HTML>"));
  end Heplus;
  
  package Hg "Ideal gas \"Hg\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Hg);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Hg.png\"></HTML>"));
  end Hg;
  
  package Hgplus "Ideal gas \"Hg+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Hgplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Hgplus.png\"></HTML>"));
  end Hgplus;
  
  package HgBr2 "Ideal gas \"HgBr2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.HgBr2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/HgBr2.png\"></HTML>"));
  end HgBr2;
  
  package I "Ideal gas \"I\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.I);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/I.png\"></HTML>"));
  end I;
  
  package Iplus "Ideal gas \"I+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Iplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Iplus.png\"></HTML>"));
  end Iplus;
  
  package Iminus "Ideal gas \"I-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Iminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Iminus.png\"></HTML>"));
  end Iminus;
  
  package IF5 "Ideal gas \"IF5\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.IF5);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/IF5.png\"></HTML>"));
  end IF5;
  
  package IF7 "Ideal gas \"IF7\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.IF7);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/IF7.png\"></HTML>"));
  end IF7;
  
  package I2 "Ideal gas \"I2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.I2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/I2.png\"></HTML>"));
  end I2;
  
  package In "Ideal gas \"In\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.In);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/In.png\"></HTML>"));
  end In;
  
  package Inplus "Ideal gas \"In+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Inplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Inplus.png\"></HTML>"));
  end Inplus;
  
  package InBr "Ideal gas \"InBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.InBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/InBr.png\"></HTML>"));
  end InBr;
  
  package InBr2 "Ideal gas \"InBr2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.InBr2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/InBr2.png\"></HTML>"));
  end InBr2;
  
  package InBr3 "Ideal gas \"InBr3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.InBr3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/InBr3.png\"></HTML>"));
  end InBr3;
  
  package InCL "Ideal gas \"InCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.InCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/InCL.png\"></HTML>"));
  end InCL;
  
  package InCL2 "Ideal gas \"InCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.InCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/InCL2.png\"></HTML>"));
  end InCL2;
  
  package InCL3 "Ideal gas \"InCl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.InCL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/InCL3.png\"></HTML>"));
  end InCL3;
  
  package InF "Ideal gas \"InF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.InF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/InF.png\"></HTML>"));
  end InF;
  
  package InF2 "Ideal gas \"InF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.InF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/InF2.png\"></HTML>"));
  end InF2;
  
  package InF3 "Ideal gas \"InF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.InF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/InF3.png\"></HTML>"));
  end InF3;
  
  package InH "Ideal gas \"InH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.InH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/InH.png\"></HTML>"));
  end InH;
  
  package InI "Ideal gas \"InI\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.InI);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/InI.png\"></HTML>"));
  end InI;
  
  package InI2 "Ideal gas \"InI2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.InI2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/InI2.png\"></HTML>"));
  end InI2;
  
  package InI3 "Ideal gas \"InI3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.InI3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/InI3.png\"></HTML>"));
  end InI3;
  
  package InO "Ideal gas \"InO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.InO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/InO.png\"></HTML>"));
  end InO;
  
  package InOH "Ideal gas \"InOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.InOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/InOH.png\"></HTML>"));
  end InOH;
  
  package In2Br2 "Ideal gas \"In2Br2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.In2Br2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/In2Br2.png\"></HTML>"));
  end In2Br2;
  
  package In2Br4 "Ideal gas \"In2Br4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.In2Br4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/In2Br4.png\"></HTML>"));
  end In2Br4;
  
  package In2Br6 "Ideal gas \"In2Br6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.In2Br6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/In2Br6.png\"></HTML>"));
  end In2Br6;
  
  package In2CL2 "Ideal gas \"In2Cl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.In2CL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/In2CL2.png\"></HTML>"));
  end In2CL2;
  
  package In2CL4 "Ideal gas \"In2Cl4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.In2CL4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/In2CL4.png\"></HTML>"));
  end In2CL4;
  
  package In2CL6 "Ideal gas \"In2Cl6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.In2CL6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/In2CL6.png\"></HTML>"));
  end In2CL6;
  
  package In2F2 "Ideal gas \"In2F2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.In2F2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/In2F2.png\"></HTML>"));
  end In2F2;
  
  package In2F4 "Ideal gas \"In2F4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.In2F4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/In2F4.png\"></HTML>"));
  end In2F4;
  
  package In2F6 "Ideal gas \"In2F6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.In2F6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/In2F6.png\"></HTML>"));
  end In2F6;
  
  package In2I2 "Ideal gas \"In2I2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.In2I2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/In2I2.png\"></HTML>"));
  end In2I2;
  
  package In2I4 "Ideal gas \"In2I4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.In2I4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/In2I4.png\"></HTML>"));
  end In2I4;
  
  package In2I6 "Ideal gas \"In2I6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.In2I6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/In2I6.png\"></HTML>"));
  end In2I6;
  
  package In2O "Ideal gas \"In2O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.In2O);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/In2O.png\"></HTML>"));
  end In2O;
  
  package K "Ideal gas \"K\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.K);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/K.png\"></HTML>"));
  end K;
  
  package Kplus "Ideal gas \"K+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Kplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Kplus.png\"></HTML>"));
  end Kplus;
  
  package Kminus "Ideal gas \"K-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Kminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Kminus.png\"></HTML>"));
  end Kminus;
  
  package KALF4 "Ideal gas \"KAlF4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.KALF4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/KALF4.png\"></HTML>"));
  end KALF4;
  
  package KBO2 "Ideal gas \"KBO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.KBO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/KBO2.png\"></HTML>"));
  end KBO2;
  
  package KBr "Ideal gas \"KBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.KBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/KBr.png\"></HTML>"));
  end KBr;
  
  package KCN "Ideal gas \"KCN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.KCN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/KCN.png\"></HTML>"));
  end KCN;
  
  package KCL "Ideal gas \"KCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.KCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/KCL.png\"></HTML>"));
  end KCL;
  
  package KF "Ideal gas \"KF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.KF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/KF.png\"></HTML>"));
  end KF;
  
  package KH "Ideal gas \"KH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.KH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/KH.png\"></HTML>"));
  end KH;
  
  package KI "Ideal gas \"KI\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.KI);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/KI.png\"></HTML>"));
  end KI;
  
  package KLi "Ideal gas \"Kli\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.KLi);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/KLi.png\"></HTML>"));
  end KLi;
  
  package KNO2 "Ideal gas \"KNO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.KNO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/KNO2.png\"></HTML>"));
  end KNO2;
  
  package KNO3 "Ideal gas \"KNO3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.KNO3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/KNO3.png\"></HTML>"));
  end KNO3;
  
  package KNa "Ideal gas \"KNa\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.KNa);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/KNa.png\"></HTML>"));
  end KNa;
  
  package KO "Ideal gas \"KO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.KO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/KO.png\"></HTML>"));
  end KO;
  
  package KOH "Ideal gas \"KOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.KOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/KOH.png\"></HTML>"));
  end KOH;
  
  package K2 "Ideal gas \"K2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.K2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/K2.png\"></HTML>"));
  end K2;
  
  package K2plus "Ideal gas \"K2+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.K2plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/K2plus.png\"></HTML>"));
  end K2plus;
  
  package K2Br2 "Ideal gas \"K2Br2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.K2Br2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/K2Br2.png\"></HTML>"));
  end K2Br2;
  
  package K2CO3 "Ideal gas \"K2CO3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.K2CO3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/K2CO3.png\"></HTML>"));
  end K2CO3;
  
  package K2C2N2 "Ideal gas \"K2C2N2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.K2C2N2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/K2C2N2.png\"></HTML>"));
  end K2C2N2;
  
  package K2CL2 "Ideal gas \"K2Cl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.K2CL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/K2CL2.png\"></HTML>"));
  end K2CL2;
  
  package K2F2 "Ideal gas \"K2F2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.K2F2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/K2F2.png\"></HTML>"));
  end K2F2;
  
  package K2I2 "Ideal gas \"K2I2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.K2I2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/K2I2.png\"></HTML>"));
  end K2I2;
  
  package K2O "Ideal gas \"K2O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.K2O);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/K2O.png\"></HTML>"));
  end K2O;
  
  package K2Oplus "Ideal gas \"K2O+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.K2Oplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/K2Oplus.png\"></HTML>"));
  end K2Oplus;
  
  package K2O2 "Ideal gas \"K2O2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.K2O2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/K2O2.png\"></HTML>"));
  end K2O2;
  
  package K2O2H2 "Ideal gas \"K2O2H2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.K2O2H2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/K2O2H2.png\"></HTML>"));
  end K2O2H2;
  
  package K2SO4 "Ideal gas \"K2SO4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.K2SO4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/K2SO4.png\"></HTML>"));
  end K2SO4;
  
  package Kr "Ideal gas \"Kr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Kr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Kr.png\"></HTML>"));
  end Kr;
  
  package Krplus "Ideal gas \"Kr+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Krplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Krplus.png\"></HTML>"));
  end Krplus;
  
  package Li "Ideal gas \"li\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Li);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Li.png\"></HTML>"));
  end Li;
  
  package Liplus "Ideal gas \"li+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Liplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Liplus.png\"></HTML>"));
  end Liplus;
  
  package Liminus "Ideal gas \"li-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Liminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Liminus.png\"></HTML>"));
  end Liminus;
  
  package LiALF4 "Ideal gas \"liAlF4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.LiALF4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/LiALF4.png\"></HTML>"));
  end LiALF4;
  
  package LiBO2 "Ideal gas \"liBO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.LiBO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/LiBO2.png\"></HTML>"));
  end LiBO2;
  
  package LiBr "Ideal gas \"liBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.LiBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/LiBr.png\"></HTML>"));
  end LiBr;
  
  package LiCL "Ideal gas \"liCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.LiCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/LiCL.png\"></HTML>"));
  end LiCL;
  
  package LiF "Ideal gas \"liF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.LiF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/LiF.png\"></HTML>"));
  end LiF;
  
  package LiH "Ideal gas \"liH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.LiH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/LiH.png\"></HTML>"));
  end LiH;
  
  package LiI "Ideal gas \"liI\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.LiI);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/LiI.png\"></HTML>"));
  end LiI;
  
  package LiN "Ideal gas \"liN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.LiN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/LiN.png\"></HTML>"));
  end LiN;
  
  package LiNO2 "Ideal gas \"liNO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.LiNO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/LiNO2.png\"></HTML>"));
  end LiNO2;
  
  package LiNO3 "Ideal gas \"liNO3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.LiNO3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/LiNO3.png\"></HTML>"));
  end LiNO3;
  
  package LiO "Ideal gas \"liO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.LiO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/LiO.png\"></HTML>"));
  end LiO;
  
  package LiOF "Ideal gas \"liOF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.LiOF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/LiOF.png\"></HTML>"));
  end LiOF;
  
  package LiOH "Ideal gas \"liOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.LiOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/LiOH.png\"></HTML>"));
  end LiOH;
  
  package LiON "Ideal gas \"liON\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.LiON);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/LiON.png\"></HTML>"));
  end LiON;
  
  package Li2 "Ideal gas \"li2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Li2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Li2.png\"></HTML>"));
  end Li2;
  
  package Li2plus "Ideal gas \"li2+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Li2plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Li2plus.png\"></HTML>"));
  end Li2plus;
  
  package Li2Br2 "Ideal gas \"li2Br2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Li2Br2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Li2Br2.png\"></HTML>"));
  end Li2Br2;
  
  package Li2F2 "Ideal gas \"li2F2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Li2F2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Li2F2.png\"></HTML>"));
  end Li2F2;
  
  package Li2I2 "Ideal gas \"li2I2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Li2I2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Li2I2.png\"></HTML>"));
  end Li2I2;
  
  package Li2O "Ideal gas \"li2O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Li2O);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Li2O.png\"></HTML>"));
  end Li2O;
  
  package Li2Oplus "Ideal gas \"li2O+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Li2Oplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Li2Oplus.png\"></HTML>"));
  end Li2Oplus;
  
  package Li2O2 "Ideal gas \"li2O2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Li2O2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Li2O2.png\"></HTML>"));
  end Li2O2;
  
  package Li2O2H2 "Ideal gas \"li2O2H2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Li2O2H2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Li2O2H2.png\"></HTML>"));
  end Li2O2H2;
  
  package Li2SO4 "Ideal gas \"li2SO4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Li2SO4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Li2SO4.png\"></HTML>"));
  end Li2SO4;
  
  package Li3plus "Ideal gas \"li3+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Li3plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Li3plus.png\"></HTML>"));
  end Li3plus;
  
  package Li3Br3 "Ideal gas \"li3Br3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Li3Br3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Li3Br3.png\"></HTML>"));
  end Li3Br3;
  
  package Li3CL3 "Ideal gas \"li3Cl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Li3CL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Li3CL3.png\"></HTML>"));
  end Li3CL3;
  
  package Li3F3 "Ideal gas \"li3F3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Li3F3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Li3F3.png\"></HTML>"));
  end Li3F3;
  
  package Li3I3 "Ideal gas \"li3I3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Li3I3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Li3I3.png\"></HTML>"));
  end Li3I3;
  
  package Mg "Ideal gas \"Mg\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Mg);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Mg.png\"></HTML>"));
  end Mg;
  
  package Mgplus "Ideal gas \"Mg+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Mgplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Mgplus.png\"></HTML>"));
  end Mgplus;
  
  package MgBr "Ideal gas \"MgBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MgBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MgBr.png\"></HTML>"));
  end MgBr;
  
  package MgBr2 "Ideal gas \"MgBr2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MgBr2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MgBr2.png\"></HTML>"));
  end MgBr2;
  
  package MgCL "Ideal gas \"MgCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MgCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MgCL.png\"></HTML>"));
  end MgCL;
  
  package MgCLplus "Ideal gas \"MgCl+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MgCLplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MgCLplus.png\"></HTML>"));
  end MgCLplus;
  
  package MgCL2 "Ideal gas \"MgCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MgCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MgCL2.png\"></HTML>"));
  end MgCL2;
  
  package MgF "Ideal gas \"MgF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MgF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MgF.png\"></HTML>"));
  end MgF;
  
  package MgFplus "Ideal gas \"MgF+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MgFplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MgFplus.png\"></HTML>"));
  end MgFplus;
  
  package MgF2 "Ideal gas \"MgF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MgF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MgF2.png\"></HTML>"));
  end MgF2;
  
  package MgF2plus "Ideal gas \"MgF2+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MgF2plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MgF2plus.png\"></HTML>"));
  end MgF2plus;
  
  package MgH "Ideal gas \"MgH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MgH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MgH.png\"></HTML>"));
  end MgH;
  
  package MgI "Ideal gas \"MgI\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MgI);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MgI.png\"></HTML>"));
  end MgI;
  
  package MgI2 "Ideal gas \"MgI2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MgI2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MgI2.png\"></HTML>"));
  end MgI2;
  
  package MgN "Ideal gas \"MgN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MgN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MgN.png\"></HTML>"));
  end MgN;
  
  package MgO "Ideal gas \"MgO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MgO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MgO.png\"></HTML>"));
  end MgO;
  
  package MgOH "Ideal gas \"MgOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MgOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MgOH.png\"></HTML>"));
  end MgOH;
  
  package MgOHplus "Ideal gas \"MgOH+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MgOHplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MgOHplus.png\"></HTML>"));
  end MgOHplus;
  
  package Mg_OH_2 "Ideal gas \"Mg_OH_2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Mg_OH_2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Mg_OH_2.png\"></HTML>"));
  end Mg_OH_2;
  
  package MgS "Ideal gas \"MgS\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MgS);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MgS.png\"></HTML>"));
  end MgS;
  
  package Mg2 "Ideal gas \"Mg2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Mg2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Mg2.png\"></HTML>"));
  end Mg2;
  
  package Mg2F4 "Ideal gas \"Mg2F4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Mg2F4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Mg2F4.png\"></HTML>"));
  end Mg2F4;
  
  package Mn "Ideal gas \"Mn\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Mn);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Mn.png\"></HTML>"));
  end Mn;
  
  package Mnplus "Ideal gas \"Mn+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Mnplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Mnplus.png\"></HTML>"));
  end Mnplus;
  
  package Mo "Ideal gas \"Mo\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Mo);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Mo.png\"></HTML>"));
  end Mo;
  
  package Moplus "Ideal gas \"Mo+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Moplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Moplus.png\"></HTML>"));
  end Moplus;
  
  package Mominus "Ideal gas \"Mo-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Mominus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Mominus.png\"></HTML>"));
  end Mominus;
  
  package MoO "Ideal gas \"MoO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MoO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MoO.png\"></HTML>"));
  end MoO;
  
  package MoO2 "Ideal gas \"MoO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MoO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MoO2.png\"></HTML>"));
  end MoO2;
  
  package MoO3 "Ideal gas \"MoO3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MoO3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MoO3.png\"></HTML>"));
  end MoO3;
  
  package MoO3minus "Ideal gas \"MoO3-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.MoO3minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/MoO3minus.png\"></HTML>"));
  end MoO3minus;
  
  package Mo2O6 "Ideal gas \"Mo2O6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Mo2O6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Mo2O6.png\"></HTML>"));
  end Mo2O6;
  
  package Mo3O9 "Ideal gas \"Mo3O9\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Mo3O9);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Mo3O9.png\"></HTML>"));
  end Mo3O9;
  
  package Mo4O12 "Ideal gas \"Mo4O12\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Mo4O12);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Mo4O12.png\"></HTML>"));
  end Mo4O12;
  
  package Mo5O15 "Ideal gas \"Mo5O15\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Mo5O15);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Mo5O15.png\"></HTML>"));
  end Mo5O15;
  
  package N "Ideal gas \"N\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.N);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/N.png\"></HTML>"));
  end N;
  
  package Nplus "Ideal gas \"N+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Nplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Nplus.png\"></HTML>"));
  end Nplus;
  
  package Nminus "Ideal gas \"N-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Nminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Nminus.png\"></HTML>"));
  end Nminus;
  
  package NCO "Ideal gas \"NCO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NCO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NCO.png\"></HTML>"));
  end NCO;
  
  package ND "Ideal gas \"ND\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ND);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ND.png\"></HTML>"));
  end ND;
  
  package ND2 "Ideal gas \"ND2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ND2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ND2.png\"></HTML>"));
  end ND2;
  
  package ND3 "Ideal gas \"ND3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ND3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ND3.png\"></HTML>"));
  end ND3;
  
  package NF "Ideal gas \"NF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NF.png\"></HTML>"));
  end NF;
  
  package NF2 "Ideal gas \"NF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NF2.png\"></HTML>"));
  end NF2;
  
  package NF3 "Ideal gas \"NF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NF3.png\"></HTML>"));
  end NF3;
  
  package NH "Ideal gas \"NH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NH.png\"></HTML>"));
  end NH;
  
  package NHplus "Ideal gas \"NH+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NHplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NHplus.png\"></HTML>"));
  end NHplus;
  
  package NHF "Ideal gas \"NHF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NHF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NHF.png\"></HTML>"));
  end NHF;
  
  package NHF2 "Ideal gas \"NHF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NHF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NHF2.png\"></HTML>"));
  end NHF2;
  
  package NH2 "Ideal gas \"NH2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NH2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NH2.png\"></HTML>"));
  end NH2;
  
  package NH2F "Ideal gas \"NH2F\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NH2F);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NH2F.png\"></HTML>"));
  end NH2F;
  
  package NH3 "Ideal gas \"NH3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NH3,
     fluidConstants={Common.FluidData.NH3});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NH3.png\"></HTML>"));
  end NH3;
  
  package NH2OH "Ideal gas \"NH2OH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NH2OH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NH2OH.png\"></HTML>"));
  end NH2OH;
  
  package NH4plus "Ideal gas \"NH4+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NH4plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NH4plus.png\"></HTML>"));
  end NH4plus;
  
  package NO "Ideal gas \"NO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NO,
     fluidConstants={Common.FluidData.NO});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NO.png\"></HTML>"));
  end NO;
  
  package NOCL "Ideal gas \"NOCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NOCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NOCL.png\"></HTML>"));
  end NOCL;
  
  package NOF "Ideal gas \"NOF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NOF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NOF.png\"></HTML>"));
  end NOF;
  
  package NOF3 "Ideal gas \"NOF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NOF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NOF3.png\"></HTML>"));
  end NOF3;
  
  package NO2 "Ideal gas \"NO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NO2,
     fluidConstants={Common.FluidData.NO2});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NO2.png\"></HTML>"));
  end NO2;
  
  package NO2minus "Ideal gas \"NO2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NO2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NO2minus.png\"></HTML>"));
  end NO2minus;
  
  package NO2CL "Ideal gas \"NO2Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NO2CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NO2CL.png\"></HTML>"));
  end NO2CL;
  
  package NO2F "Ideal gas \"NO2F\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NO2F);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NO2F.png\"></HTML>"));
  end NO2F;
  
  package NO3 "Ideal gas \"NO3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NO3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NO3.png\"></HTML>"));
  end NO3;
  
  package NO3minus "Ideal gas \"NO3-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NO3minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NO3minus.png\"></HTML>"));
  end NO3minus;
  
  package NO3F "Ideal gas \"NO3F\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NO3F);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NO3F.png\"></HTML>"));
  end NO3F;
  
  package N2 "Ideal gas \"N2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.N2,
     fluidConstants={Common.FluidData.N2});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/N2.png\"></HTML>"));
  end N2;
  
  package N2plus "Ideal gas \"N2+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.N2plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/N2plus.png\"></HTML>"));
  end N2plus;
  
  package N2minus "Ideal gas \"N2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.N2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/N2minus.png\"></HTML>"));
  end N2minus;
  
  package NCN "Ideal gas \"NCN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NCN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NCN.png\"></HTML>"));
  end NCN;
  
  package N2D2_cis "Ideal gas \"N2D2_cis\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.N2D2_cis);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/N2D2_cis.png\"></HTML>"));
  end N2D2_cis;
  
  package N2F2 "Ideal gas \"N2F2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.N2F2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/N2F2.png\"></HTML>"));
  end N2F2;
  
  package N2F4 "Ideal gas \"N2F4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.N2F4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/N2F4.png\"></HTML>"));
  end N2F4;
  
  package N2H2 "Ideal gas \"N2H2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.N2H2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/N2H2.png\"></HTML>"));
  end N2H2;
  
  package NH2NO2 "Ideal gas \"NH2NO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NH2NO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NH2NO2.png\"></HTML>"));
  end NH2NO2;
  
  package N2H4 "Ideal gas \"N2H4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.N2H4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/N2H4.png\"></HTML>"));
  end N2H4;
  
  package N2O "Ideal gas \"N2O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.N2O,
     fluidConstants={Common.FluidData.N2O});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/N2O.png\"></HTML>"));
  end N2O;
  
  package N2Oplus "Ideal gas \"N2O+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.N2Oplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/N2Oplus.png\"></HTML>"));
  end N2Oplus;
  
  package N2O3 "Ideal gas \"N2O3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.N2O3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/N2O3.png\"></HTML>"));
  end N2O3;
  
  package N2O4 "Ideal gas \"N2O4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.N2O4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/N2O4.png\"></HTML>"));
  end N2O4;
  
  package N2O5 "Ideal gas \"N2O5\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.N2O5);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/N2O5.png\"></HTML>"));
  end N2O5;
  
  package N3 "Ideal gas \"N3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.N3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/N3.png\"></HTML>"));
  end N3;
  
  package N3H "Ideal gas \"N3H\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.N3H);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/N3H.png\"></HTML>"));
  end N3H;
  
  package Na "Ideal gas \"Na\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Na);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Na.png\"></HTML>"));
  end Na;
  
  package Naplus "Ideal gas \"Na+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Naplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Naplus.png\"></HTML>"));
  end Naplus;
  
  package Naminus "Ideal gas \"Na-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Naminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Naminus.png\"></HTML>"));
  end Naminus;
  
  package NaALF4 "Ideal gas \"NaAlF4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NaALF4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NaALF4.png\"></HTML>"));
  end NaALF4;
  
  package NaBO2 "Ideal gas \"NaBO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NaBO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NaBO2.png\"></HTML>"));
  end NaBO2;
  
  package NaBr "Ideal gas \"NaBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NaBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NaBr.png\"></HTML>"));
  end NaBr;
  
  package NaCN "Ideal gas \"NaCN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NaCN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NaCN.png\"></HTML>"));
  end NaCN;
  
  package NaCL "Ideal gas \"NaCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NaCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NaCL.png\"></HTML>"));
  end NaCL;
  
  package NaF "Ideal gas \"NaF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NaF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NaF.png\"></HTML>"));
  end NaF;
  
  package NaH "Ideal gas \"NaH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NaH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NaH.png\"></HTML>"));
  end NaH;
  
  package NaI "Ideal gas \"NaI\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NaI);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NaI.png\"></HTML>"));
  end NaI;
  
  package NaLi "Ideal gas \"Nali\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NaLi);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NaLi.png\"></HTML>"));
  end NaLi;
  
  package NaNO2 "Ideal gas \"NaNO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NaNO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NaNO2.png\"></HTML>"));
  end NaNO2;
  
  package NaNO3 "Ideal gas \"NaNO3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NaNO3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NaNO3.png\"></HTML>"));
  end NaNO3;
  
  package NaO "Ideal gas \"NaO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NaO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NaO.png\"></HTML>"));
  end NaO;
  
  package NaOH "Ideal gas \"NaOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NaOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NaOH.png\"></HTML>"));
  end NaOH;
  
  package NaOHplus "Ideal gas \"NaOH+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NaOHplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NaOHplus.png\"></HTML>"));
  end NaOHplus;
  
  package Na2 "Ideal gas \"Na2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Na2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Na2.png\"></HTML>"));
  end Na2;
  
  package Na2Br2 "Ideal gas \"Na2Br2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Na2Br2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Na2Br2.png\"></HTML>"));
  end Na2Br2;
  
  package Na2CL2 "Ideal gas \"Na2Cl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Na2CL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Na2CL2.png\"></HTML>"));
  end Na2CL2;
  
  package Na2F2 "Ideal gas \"Na2F2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Na2F2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Na2F2.png\"></HTML>"));
  end Na2F2;
  
  package Na2I2 "Ideal gas \"Na2I2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Na2I2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Na2I2.png\"></HTML>"));
  end Na2I2;
  
  package Na2O "Ideal gas \"Na2O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Na2O);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Na2O.png\"></HTML>"));
  end Na2O;
  
  package Na2Oplus "Ideal gas \"Na2O+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Na2Oplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Na2Oplus.png\"></HTML>"));
  end Na2Oplus;
  
  package Na2O2 "Ideal gas \"Na2O2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Na2O2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Na2O2.png\"></HTML>"));
  end Na2O2;
  
  package Na2O2H2 "Ideal gas \"Na2O2H2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Na2O2H2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Na2O2H2.png\"></HTML>"));
  end Na2O2H2;
  
  package Na2SO4 "Ideal gas \"Na2SO4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Na2SO4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Na2SO4.png\"></HTML>"));
  end Na2SO4;
  
  package Na3CL3 "Ideal gas \"Na3Cl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Na3CL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Na3CL3.png\"></HTML>"));
  end Na3CL3;
  
  package Na3F3 "Ideal gas \"Na3F3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Na3F3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Na3F3.png\"></HTML>"));
  end Na3F3;
  
  package Nb "Ideal gas \"Nb\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Nb);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Nb.png\"></HTML>"));
  end Nb;
  
  package Nbplus "Ideal gas \"Nb+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Nbplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Nbplus.png\"></HTML>"));
  end Nbplus;
  
  package Nbminus "Ideal gas \"Nb-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Nbminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Nbminus.png\"></HTML>"));
  end Nbminus;
  
  package NbCL5 "Ideal gas \"NbCl5\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NbCL5);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NbCL5.png\"></HTML>"));
  end NbCL5;
  
  package NbO "Ideal gas \"NbO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NbO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NbO.png\"></HTML>"));
  end NbO;
  
  package NbOCL3 "Ideal gas \"NbOCl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NbOCL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NbOCL3.png\"></HTML>"));
  end NbOCL3;
  
  package NbO2 "Ideal gas \"NbO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NbO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NbO2.png\"></HTML>"));
  end NbO2;
  
  package Ne "Ideal gas \"Ne\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ne,
     fluidConstants={Common.FluidData.Ne});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ne.png\"></HTML>"));
  end Ne;
  
  package Neplus "Ideal gas \"Ne+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Neplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Neplus.png\"></HTML>"));
  end Neplus;
  
  package Ni "Ideal gas \"Ni\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ni);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ni.png\"></HTML>"));
  end Ni;
  
  package Niplus "Ideal gas \"Ni+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Niplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Niplus.png\"></HTML>"));
  end Niplus;
  
  package Niminus "Ideal gas \"Ni-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Niminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Niminus.png\"></HTML>"));
  end Niminus;
  
  package NiCL "Ideal gas \"NiCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NiCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NiCL.png\"></HTML>"));
  end NiCL;
  
  package NiCL2 "Ideal gas \"NiCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NiCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NiCL2.png\"></HTML>"));
  end NiCL2;
  
  package NiO "Ideal gas \"NiO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NiO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NiO.png\"></HTML>"));
  end NiO;
  
  package NiS "Ideal gas \"NiS\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.NiS);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/NiS.png\"></HTML>"));
  end NiS;
  
  package O "Ideal gas \"O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.O);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/O.png\"></HTML>"));
  end O;
  
  package Oplus "Ideal gas \"O+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Oplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Oplus.png\"></HTML>"));
  end Oplus;
  
  package Ominus "Ideal gas \"O-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ominus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ominus.png\"></HTML>"));
  end Ominus;
  
  package OD "Ideal gas \"OD\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.OD);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/OD.png\"></HTML>"));
  end OD;
  
  package ODminus "Ideal gas \"OD-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ODminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ODminus.png\"></HTML>"));
  end ODminus;
  
  package OH "Ideal gas \"OH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.OH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/OH.png\"></HTML>"));
  end OH;
  
  package OHplus "Ideal gas \"OH+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.OHplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/OHplus.png\"></HTML>"));
  end OHplus;
  
  package OHminus "Ideal gas \"OH-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.OHminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/OHminus.png\"></HTML>"));
  end OHminus;
  
  package O2 "Ideal gas \"O2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.O2,
     fluidConstants={Common.FluidData.O2});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/O2.png\"></HTML>"));
  end O2;
  
  package O2plus "Ideal gas \"O2+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.O2plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/O2plus.png\"></HTML>"));
  end O2plus;
  
  package O2minus "Ideal gas \"O2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.O2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/O2minus.png\"></HTML>"));
  end O2minus;
  
  package O3 "Ideal gas \"O3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.O3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/O3.png\"></HTML>"));
  end O3;
  
  package P "Ideal gas \"P\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.P);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/P.png\"></HTML>"));
  end P;
  
  package Pplus "Ideal gas \"P+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Pplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Pplus.png\"></HTML>"));
  end Pplus;
  
  package Pminus "Ideal gas \"P-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Pminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Pminus.png\"></HTML>"));
  end Pminus;
  
  package PCL "Ideal gas \"PCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PCL.png\"></HTML>"));
  end PCL;
  
  package PCL2 "Ideal gas \"PCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PCL2.png\"></HTML>"));
  end PCL2;
  
  package PCL2minus "Ideal gas \"PCl2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PCL2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PCL2minus.png\"></HTML>"));
  end PCL2minus;
  
  package PCL3 "Ideal gas \"PCl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PCL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PCL3.png\"></HTML>"));
  end PCL3;
  
  package PCL5 "Ideal gas \"PCl5\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PCL5);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PCL5.png\"></HTML>"));
  end PCL5;
  
  package PF "Ideal gas \"PF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PF.png\"></HTML>"));
  end PF;
  
  package PFplus "Ideal gas \"PF+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PFplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PFplus.png\"></HTML>"));
  end PFplus;
  
  package PFminus "Ideal gas \"PF-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PFminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PFminus.png\"></HTML>"));
  end PFminus;
  
  package PFCL "Ideal gas \"PFCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PFCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PFCL.png\"></HTML>"));
  end PFCL;
  
  package PFCLminus "Ideal gas \"PFCl-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PFCLminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PFCLminus.png\"></HTML>"));
  end PFCLminus;
  
  package PFCL2 "Ideal gas \"PFCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PFCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PFCL2.png\"></HTML>"));
  end PFCL2;
  
  package PFCL4 "Ideal gas \"PFCl4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PFCL4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PFCL4.png\"></HTML>"));
  end PFCL4;
  
  package PF2 "Ideal gas \"PF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PF2.png\"></HTML>"));
  end PF2;
  
  package PF2minus "Ideal gas \"PF2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PF2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PF2minus.png\"></HTML>"));
  end PF2minus;
  
  package PF2CL "Ideal gas \"PF2Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PF2CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PF2CL.png\"></HTML>"));
  end PF2CL;
  
  package PF2CL3 "Ideal gas \"PF2Cl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PF2CL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PF2CL3.png\"></HTML>"));
  end PF2CL3;
  
  package PF3 "Ideal gas \"PF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PF3.png\"></HTML>"));
  end PF3;
  
  package PF3CL2 "Ideal gas \"PF3Cl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PF3CL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PF3CL2.png\"></HTML>"));
  end PF3CL2;
  
  package PF4CL "Ideal gas \"PF4Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PF4CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PF4CL.png\"></HTML>"));
  end PF4CL;
  
  package PF5 "Ideal gas \"PF5\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PF5);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PF5.png\"></HTML>"));
  end PF5;
  
  package PH "Ideal gas \"PH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PH.png\"></HTML>"));
  end PH;
  
  package PH2 "Ideal gas \"PH2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PH2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PH2.png\"></HTML>"));
  end PH2;
  
  package PH2minus "Ideal gas \"PH2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PH2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PH2minus.png\"></HTML>"));
  end PH2minus;
  
  package PH3 "Ideal gas \"PH3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PH3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PH3.png\"></HTML>"));
  end PH3;
  
  package PN "Ideal gas \"PN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PN.png\"></HTML>"));
  end PN;
  
  package PO "Ideal gas \"PO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PO.png\"></HTML>"));
  end PO;
  
  package POminus "Ideal gas \"PO-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.POminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/POminus.png\"></HTML>"));
  end POminus;
  
  package POCL3 "Ideal gas \"POCl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.POCL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/POCL3.png\"></HTML>"));
  end POCL3;
  
  package POFCL2 "Ideal gas \"POFCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.POFCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/POFCL2.png\"></HTML>"));
  end POFCL2;
  
  package POF2CL "Ideal gas \"POF2Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.POF2CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/POF2CL.png\"></HTML>"));
  end POF2CL;
  
  package POF3 "Ideal gas \"POF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.POF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/POF3.png\"></HTML>"));
  end POF3;
  
  package PO2 "Ideal gas \"PO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PO2.png\"></HTML>"));
  end PO2;
  
  package PO2minus "Ideal gas \"PO2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PO2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PO2minus.png\"></HTML>"));
  end PO2minus;
  
  package PS "Ideal gas \"PS\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PS);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PS.png\"></HTML>"));
  end PS;
  
  package P2 "Ideal gas \"P2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.P2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/P2.png\"></HTML>"));
  end P2;
  
  package P2O3 "Ideal gas \"P2O3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.P2O3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/P2O3.png\"></HTML>"));
  end P2O3;
  
  package P2O4 "Ideal gas \"P2O4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.P2O4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/P2O4.png\"></HTML>"));
  end P2O4;
  
  package P2O5 "Ideal gas \"P2O5\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.P2O5);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/P2O5.png\"></HTML>"));
  end P2O5;
  
  package P3 "Ideal gas \"P3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.P3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/P3.png\"></HTML>"));
  end P3;
  
  package P3O6 "Ideal gas \"P3O6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.P3O6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/P3O6.png\"></HTML>"));
  end P3O6;
  
  package P4 "Ideal gas \"P4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.P4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/P4.png\"></HTML>"));
  end P4;
  
  package P4O6 "Ideal gas \"P4O6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.P4O6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/P4O6.png\"></HTML>"));
  end P4O6;
  
  package P4O7 "Ideal gas \"P4O7\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.P4O7);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/P4O7.png\"></HTML>"));
  end P4O7;
  
  package P4O8 "Ideal gas \"P4O8\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.P4O8);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/P4O8.png\"></HTML>"));
  end P4O8;
  
  package P4O9 "Ideal gas \"P4O9\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.P4O9);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/P4O9.png\"></HTML>"));
  end P4O9;
  
  package P4O10 "Ideal gas \"P4O10\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.P4O10);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/P4O10.png\"></HTML>"));
  end P4O10;
  
  package Pb "Ideal gas \"Pb\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Pb);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Pb.png\"></HTML>"));
  end Pb;
  
  package Pbplus "Ideal gas \"Pb+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Pbplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Pbplus.png\"></HTML>"));
  end Pbplus;
  
  package Pbminus "Ideal gas \"Pb-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Pbminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Pbminus.png\"></HTML>"));
  end Pbminus;
  
  package PbBr "Ideal gas \"PbBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PbBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PbBr.png\"></HTML>"));
  end PbBr;
  
  package PbBr2 "Ideal gas \"PbBr2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PbBr2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PbBr2.png\"></HTML>"));
  end PbBr2;
  
  package PbBr3 "Ideal gas \"PbBr3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PbBr3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PbBr3.png\"></HTML>"));
  end PbBr3;
  
  package PbBr4 "Ideal gas \"PbBr4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PbBr4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PbBr4.png\"></HTML>"));
  end PbBr4;
  
  package PbCL "Ideal gas \"PbCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PbCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PbCL.png\"></HTML>"));
  end PbCL;
  
  package PbCL2 "Ideal gas \"PbCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PbCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PbCL2.png\"></HTML>"));
  end PbCL2;
  
  package PbCL3 "Ideal gas \"PbCl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PbCL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PbCL3.png\"></HTML>"));
  end PbCL3;
  
  package PbCL4 "Ideal gas \"PbCl4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PbCL4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PbCL4.png\"></HTML>"));
  end PbCL4;
  
  package PbF "Ideal gas \"PbF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PbF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PbF.png\"></HTML>"));
  end PbF;
  
  package PbF2 "Ideal gas \"PbF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PbF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PbF2.png\"></HTML>"));
  end PbF2;
  
  package PbF3 "Ideal gas \"PbF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PbF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PbF3.png\"></HTML>"));
  end PbF3;
  
  package PbF4 "Ideal gas \"PbF4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PbF4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PbF4.png\"></HTML>"));
  end PbF4;
  
  package PbI "Ideal gas \"PbI\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PbI);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PbI.png\"></HTML>"));
  end PbI;
  
  package PbI2 "Ideal gas \"PbI2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PbI2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PbI2.png\"></HTML>"));
  end PbI2;
  
  package PbI3 "Ideal gas \"PbI3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PbI3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PbI3.png\"></HTML>"));
  end PbI3;
  
  package PbI4 "Ideal gas \"PbI4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PbI4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PbI4.png\"></HTML>"));
  end PbI4;
  
  package PbO "Ideal gas \"PbO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PbO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PbO.png\"></HTML>"));
  end PbO;
  
  package PbO2 "Ideal gas \"PbO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PbO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PbO2.png\"></HTML>"));
  end PbO2;
  
  package PbS "Ideal gas \"PbS\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PbS);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PbS.png\"></HTML>"));
  end PbS;
  
  package PbS2 "Ideal gas \"PbS2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.PbS2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/PbS2.png\"></HTML>"));
  end PbS2;
  
  package Rb "Ideal gas \"Rb\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Rb);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Rb.png\"></HTML>"));
  end Rb;
  
  package Rbplus "Ideal gas \"Rb+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Rbplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Rbplus.png\"></HTML>"));
  end Rbplus;
  
  package Rbminus "Ideal gas \"Rb-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Rbminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Rbminus.png\"></HTML>"));
  end Rbminus;
  
  package RbBO2 "Ideal gas \"RbBO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.RbBO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/RbBO2.png\"></HTML>"));
  end RbBO2;
  
  package RbBr "Ideal gas \"RbBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.RbBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/RbBr.png\"></HTML>"));
  end RbBr;
  
  package RbCL "Ideal gas \"RbCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.RbCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/RbCL.png\"></HTML>"));
  end RbCL;
  
  package RbF "Ideal gas \"RbF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.RbF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/RbF.png\"></HTML>"));
  end RbF;
  
  package RbH "Ideal gas \"RbH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.RbH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/RbH.png\"></HTML>"));
  end RbH;
  
  package RbI "Ideal gas \"RbI\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.RbI);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/RbI.png\"></HTML>"));
  end RbI;
  
  package RbK "Ideal gas \"RbK\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.RbK);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/RbK.png\"></HTML>"));
  end RbK;
  
  package RbLi "Ideal gas \"Rbli\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.RbLi);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/RbLi.png\"></HTML>"));
  end RbLi;
  
  package RbNO2 "Ideal gas \"RbNO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.RbNO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/RbNO2.png\"></HTML>"));
  end RbNO2;
  
  package RbNO3 "Ideal gas \"RbNO3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.RbNO3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/RbNO3.png\"></HTML>"));
  end RbNO3;
  
  package RbNa "Ideal gas \"RbNa\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.RbNa);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/RbNa.png\"></HTML>"));
  end RbNa;
  
  package RbO "Ideal gas \"RbO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.RbO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/RbO.png\"></HTML>"));
  end RbO;
  
  package RbOH "Ideal gas \"RbOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.RbOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/RbOH.png\"></HTML>"));
  end RbOH;
  
  package Rb2Br2 "Ideal gas \"Rb2Br2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Rb2Br2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Rb2Br2.png\"></HTML>"));
  end Rb2Br2;
  
  package Rb2CL2 "Ideal gas \"Rb2Cl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Rb2CL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Rb2CL2.png\"></HTML>"));
  end Rb2CL2;
  
  package Rb2F2 "Ideal gas \"Rb2F2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Rb2F2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Rb2F2.png\"></HTML>"));
  end Rb2F2;
  
  package Rb2I2 "Ideal gas \"Rb2I2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Rb2I2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Rb2I2.png\"></HTML>"));
  end Rb2I2;
  
  package Rb2O "Ideal gas \"Rb2O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Rb2O);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Rb2O.png\"></HTML>"));
  end Rb2O;
  
  package Rb2O2 "Ideal gas \"Rb2O2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Rb2O2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Rb2O2.png\"></HTML>"));
  end Rb2O2;
  
  package Rb2O2H2 "Ideal gas \"Rb2O2H2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Rb2O2H2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Rb2O2H2.png\"></HTML>"));
  end Rb2O2H2;
  
  package Rb2SO4 "Ideal gas \"Rb2SO4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Rb2SO4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Rb2SO4.png\"></HTML>"));
  end Rb2SO4;
  
  package Rn "Ideal gas \"Rn\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Rn);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Rn.png\"></HTML>"));
  end Rn;
  
  package Rnplus "Ideal gas \"Rn+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Rnplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Rnplus.png\"></HTML>"));
  end Rnplus;
  
  package S "Ideal gas \"S\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.S);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/S.png\"></HTML>"));
  end S;
  
  package Splus "Ideal gas \"S+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Splus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Splus.png\"></HTML>"));
  end Splus;
  
  package Sminus "Ideal gas \"S-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Sminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Sminus.png\"></HTML>"));
  end Sminus;
  
  package SCL "Ideal gas \"SCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SCL.png\"></HTML>"));
  end SCL;
  
  package SCL2 "Ideal gas \"SCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SCL2.png\"></HTML>"));
  end SCL2;
  
  package SCL2plus "Ideal gas \"SCl2+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SCL2plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SCL2plus.png\"></HTML>"));
  end SCL2plus;
  
  package SD "Ideal gas \"SD\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SD);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SD.png\"></HTML>"));
  end SD;
  
  package SF "Ideal gas \"SF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SF.png\"></HTML>"));
  end SF;
  
  package SFplus "Ideal gas \"SF+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SFplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SFplus.png\"></HTML>"));
  end SFplus;
  
  package SFminus "Ideal gas \"SF-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SFminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SFminus.png\"></HTML>"));
  end SFminus;
  
  package SF2 "Ideal gas \"SF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SF2.png\"></HTML>"));
  end SF2;
  
  package SF2plus "Ideal gas \"SF2+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SF2plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SF2plus.png\"></HTML>"));
  end SF2plus;
  
  package SF2minus "Ideal gas \"SF2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SF2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SF2minus.png\"></HTML>"));
  end SF2minus;
  
  package SF3 "Ideal gas \"SF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SF3.png\"></HTML>"));
  end SF3;
  
  package SF3plus "Ideal gas \"SF3+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SF3plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SF3plus.png\"></HTML>"));
  end SF3plus;
  
  package SF3minus "Ideal gas \"SF3-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SF3minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SF3minus.png\"></HTML>"));
  end SF3minus;
  
  package SF4 "Ideal gas \"SF4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SF4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SF4.png\"></HTML>"));
  end SF4;
  
  package SF4plus "Ideal gas \"SF4+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SF4plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SF4plus.png\"></HTML>"));
  end SF4plus;
  
  package SF4minus "Ideal gas \"SF4-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SF4minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SF4minus.png\"></HTML>"));
  end SF4minus;
  
  package SF5 "Ideal gas \"SF5\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SF5);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SF5.png\"></HTML>"));
  end SF5;
  
  package SF5plus "Ideal gas \"SF5+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SF5plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SF5plus.png\"></HTML>"));
  end SF5plus;
  
  package SF5minus "Ideal gas \"SF5-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SF5minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SF5minus.png\"></HTML>"));
  end SF5minus;
  
  package SF6 "Ideal gas \"SF6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SF6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SF6.png\"></HTML>"));
  end SF6;
  
  package SF6minus "Ideal gas \"SF6-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SF6minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SF6minus.png\"></HTML>"));
  end SF6minus;
  
  package SH "Ideal gas \"SH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SH.png\"></HTML>"));
  end SH;
  
  package SHminus "Ideal gas \"SH-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SHminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SHminus.png\"></HTML>"));
  end SHminus;
  
  package SN "Ideal gas \"SN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SN.png\"></HTML>"));
  end SN;
  
  package SO "Ideal gas \"SO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SO.png\"></HTML>"));
  end SO;
  
  package SOminus "Ideal gas \"SO-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SOminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SOminus.png\"></HTML>"));
  end SOminus;
  
  package SOF2 "Ideal gas \"SOF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SOF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SOF2.png\"></HTML>"));
  end SOF2;
  
  package SO2 "Ideal gas \"SO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SO2,
     fluidConstants={Common.FluidData.SO2});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SO2.png\"></HTML>"));
  end SO2;
  
  package SO2minus "Ideal gas \"SO2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SO2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SO2minus.png\"></HTML>"));
  end SO2minus;
  
  package SO2CL2 "Ideal gas \"SO2Cl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SO2CL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SO2CL2.png\"></HTML>"));
  end SO2CL2;
  
  package SO2FCL "Ideal gas \"SO2FCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SO2FCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SO2FCL.png\"></HTML>"));
  end SO2FCL;
  
  package SO2F2 "Ideal gas \"SO2F2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SO2F2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SO2F2.png\"></HTML>"));
  end SO2F2;
  
  package SO3 "Ideal gas \"SO3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SO3,
     fluidConstants={Common.FluidData.SO3});
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SO3.png\"></HTML>"));
  end SO3;
  
  package S2 "Ideal gas \"S2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.S2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/S2.png\"></HTML>"));
  end S2;
  
  package S2minus "Ideal gas \"S2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.S2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/S2minus.png\"></HTML>"));
  end S2minus;
  
  package S2CL2 "Ideal gas \"S2Cl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.S2CL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/S2CL2.png\"></HTML>"));
  end S2CL2;
  
  package S2F2 "Ideal gas \"S2F2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.S2F2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/S2F2.png\"></HTML>"));
  end S2F2;
  
  package S2O "Ideal gas \"S2O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.S2O);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/S2O.png\"></HTML>"));
  end S2O;
  
  package S3 "Ideal gas \"S3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.S3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/S3.png\"></HTML>"));
  end S3;
  
  package S4 "Ideal gas \"S4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.S4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/S4.png\"></HTML>"));
  end S4;
  
  package S5 "Ideal gas \"S5\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.S5);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/S5.png\"></HTML>"));
  end S5;
  
  package S6 "Ideal gas \"S6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.S6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/S6.png\"></HTML>"));
  end S6;
  
  package S7 "Ideal gas \"S7\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.S7);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/S7.png\"></HTML>"));
  end S7;
  
  package S8 "Ideal gas \"S8\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.S8);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/S8.png\"></HTML>"));
  end S8;
  
  package Sc "Ideal gas \"Sc\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Sc);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Sc.png\"></HTML>"));
  end Sc;
  
  package Scplus "Ideal gas \"Sc+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Scplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Scplus.png\"></HTML>"));
  end Scplus;
  
  package Scminus "Ideal gas \"Sc-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Scminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Scminus.png\"></HTML>"));
  end Scminus;
  
  package ScO "Ideal gas \"ScO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ScO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ScO.png\"></HTML>"));
  end ScO;
  
  package ScOplus "Ideal gas \"ScO+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ScOplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ScOplus.png\"></HTML>"));
  end ScOplus;
  
  package ScO2 "Ideal gas \"ScO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ScO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ScO2.png\"></HTML>"));
  end ScO2;
  
  package Sc2O "Ideal gas \"Sc2O\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Sc2O);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Sc2O.png\"></HTML>"));
  end Sc2O;
  
  package Sc2O2 "Ideal gas \"Sc2O2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Sc2O2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Sc2O2.png\"></HTML>"));
  end Sc2O2;
  
  package Si "Ideal gas \"Si\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Si);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Si.png\"></HTML>"));
  end Si;
  
  package Siplus "Ideal gas \"Si+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Siplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Siplus.png\"></HTML>"));
  end Siplus;
  
  package Siminus "Ideal gas \"Si-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Siminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Siminus.png\"></HTML>"));
  end Siminus;
  
  package SiBr "Ideal gas \"SiBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiBr.png\"></HTML>"));
  end SiBr;
  
  package SiBr2 "Ideal gas \"SiBr2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiBr2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiBr2.png\"></HTML>"));
  end SiBr2;
  
  package SiBr3 "Ideal gas \"SiBr3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiBr3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiBr3.png\"></HTML>"));
  end SiBr3;
  
  package SiBr4 "Ideal gas \"SiBr4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiBr4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiBr4.png\"></HTML>"));
  end SiBr4;
  
  package SiC "Ideal gas \"SiC\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiC);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiC.png\"></HTML>"));
  end SiC;
  
  package SiC2 "Ideal gas \"SiC2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiC2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiC2.png\"></HTML>"));
  end SiC2;
  
  package SiCL "Ideal gas \"SiCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiCL.png\"></HTML>"));
  end SiCL;
  
  package SiCL2 "Ideal gas \"SiCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiCL2.png\"></HTML>"));
  end SiCL2;
  
  package SiCL3 "Ideal gas \"SiCl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiCL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiCL3.png\"></HTML>"));
  end SiCL3;
  
  package SiCL4 "Ideal gas \"SiCl4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiCL4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiCL4.png\"></HTML>"));
  end SiCL4;
  
  package SiF "Ideal gas \"SiF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiF.png\"></HTML>"));
  end SiF;
  
  package SiFCL "Ideal gas \"SiFCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiFCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiFCL.png\"></HTML>"));
  end SiFCL;
  
  package SiF2 "Ideal gas \"SiF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiF2.png\"></HTML>"));
  end SiF2;
  
  package SiF3 "Ideal gas \"SiF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiF3.png\"></HTML>"));
  end SiF3;
  
  package SiF4 "Ideal gas \"SiF4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiF4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiF4.png\"></HTML>"));
  end SiF4;
  
  package SiH "Ideal gas \"SiH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiH.png\"></HTML>"));
  end SiH;
  
  package SiHplus "Ideal gas \"SiH+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiHplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiHplus.png\"></HTML>"));
  end SiHplus;
  
  package SiHBr3 "Ideal gas \"SiHBr3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiHBr3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiHBr3.png\"></HTML>"));
  end SiHBr3;
  
  package SiHCL "Ideal gas \"SiHCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiHCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiHCL.png\"></HTML>"));
  end SiHCL;
  
  package SiHCL3 "Ideal gas \"SiHCl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiHCL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiHCL3.png\"></HTML>"));
  end SiHCL3;
  
  package SiHF "Ideal gas \"SiHF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiHF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiHF.png\"></HTML>"));
  end SiHF;
  
  package SiHF3 "Ideal gas \"SiHF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiHF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiHF3.png\"></HTML>"));
  end SiHF3;
  
  package SiHI3 "Ideal gas \"SiHI3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiHI3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiHI3.png\"></HTML>"));
  end SiHI3;
  
  package SiH2 "Ideal gas \"SiH2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiH2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiH2.png\"></HTML>"));
  end SiH2;
  
  package SiH2Br2 "Ideal gas \"SiH2Br2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiH2Br2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiH2Br2.png\"></HTML>"));
  end SiH2Br2;
  
  package SiH2CL2 "Ideal gas \"SiH2Cl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiH2CL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiH2CL2.png\"></HTML>"));
  end SiH2CL2;
  
  package SiH2F2 "Ideal gas \"SiH2F2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiH2F2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiH2F2.png\"></HTML>"));
  end SiH2F2;
  
  package SiH2I2 "Ideal gas \"SiH2I2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiH2I2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiH2I2.png\"></HTML>"));
  end SiH2I2;
  
  package SiH3 "Ideal gas \"SiH3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiH3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiH3.png\"></HTML>"));
  end SiH3;
  
  package SiH3Br "Ideal gas \"SiH3Br\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiH3Br);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiH3Br.png\"></HTML>"));
  end SiH3Br;
  
  package SiH3CL "Ideal gas \"SiH3Cl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiH3CL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiH3CL.png\"></HTML>"));
  end SiH3CL;
  
  package SiH3F "Ideal gas \"SiH3F\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiH3F);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiH3F.png\"></HTML>"));
  end SiH3F;
  
  package SiH3I "Ideal gas \"SiH3I\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiH3I);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiH3I.png\"></HTML>"));
  end SiH3I;
  
  package SiH4 "Ideal gas \"SiH4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiH4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiH4.png\"></HTML>"));
  end SiH4;
  
  package SiI "Ideal gas \"SiI\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiI);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiI.png\"></HTML>"));
  end SiI;
  
  package SiI2 "Ideal gas \"SiI2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiI2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiI2.png\"></HTML>"));
  end SiI2;
  
  package SiN "Ideal gas \"SiN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiN.png\"></HTML>"));
  end SiN;
  
  package SiO "Ideal gas \"SiO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiO.png\"></HTML>"));
  end SiO;
  
  package SiO2 "Ideal gas \"SiO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiO2.png\"></HTML>"));
  end SiO2;
  
  package SiS "Ideal gas \"SiS\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiS);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiS.png\"></HTML>"));
  end SiS;
  
  package SiS2 "Ideal gas \"SiS2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SiS2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SiS2.png\"></HTML>"));
  end SiS2;
  
  package Si2 "Ideal gas \"Si2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Si2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Si2.png\"></HTML>"));
  end Si2;
  
  package Si2C "Ideal gas \"Si2C\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Si2C);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Si2C.png\"></HTML>"));
  end Si2C;
  
  package Si2F6 "Ideal gas \"Si2F6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Si2F6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Si2F6.png\"></HTML>"));
  end Si2F6;
  
  package Si2N "Ideal gas \"Si2N\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Si2N);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Si2N.png\"></HTML>"));
  end Si2N;
  
  package Si3 "Ideal gas \"Si3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Si3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Si3.png\"></HTML>"));
  end Si3;
  
  package Sn "Ideal gas \"Sn\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Sn);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Sn.png\"></HTML>"));
  end Sn;
  
  package Snplus "Ideal gas \"Sn+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Snplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Snplus.png\"></HTML>"));
  end Snplus;
  
  package Snminus "Ideal gas \"Sn-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Snminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Snminus.png\"></HTML>"));
  end Snminus;
  
  package SnBr "Ideal gas \"SnBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SnBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SnBr.png\"></HTML>"));
  end SnBr;
  
  package SnBr2 "Ideal gas \"SnBr2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SnBr2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SnBr2.png\"></HTML>"));
  end SnBr2;
  
  package SnBr3 "Ideal gas \"SnBr3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SnBr3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SnBr3.png\"></HTML>"));
  end SnBr3;
  
  package SnBr4 "Ideal gas \"SnBr4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SnBr4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SnBr4.png\"></HTML>"));
  end SnBr4;
  
  package SnCL "Ideal gas \"SnCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SnCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SnCL.png\"></HTML>"));
  end SnCL;
  
  package SnCL2 "Ideal gas \"SnCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SnCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SnCL2.png\"></HTML>"));
  end SnCL2;
  
  package SnCL3 "Ideal gas \"SnCl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SnCL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SnCL3.png\"></HTML>"));
  end SnCL3;
  
  package SnCL4 "Ideal gas \"SnCl4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SnCL4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SnCL4.png\"></HTML>"));
  end SnCL4;
  
  package SnF "Ideal gas \"SnF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SnF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SnF.png\"></HTML>"));
  end SnF;
  
  package SnF2 "Ideal gas \"SnF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SnF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SnF2.png\"></HTML>"));
  end SnF2;
  
  package SnF3 "Ideal gas \"SnF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SnF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SnF3.png\"></HTML>"));
  end SnF3;
  
  package SnF4 "Ideal gas \"SnF4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SnF4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SnF4.png\"></HTML>"));
  end SnF4;
  
  package SnI "Ideal gas \"SnI\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SnI);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SnI.png\"></HTML>"));
  end SnI;
  
  package SnI2 "Ideal gas \"SnI2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SnI2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SnI2.png\"></HTML>"));
  end SnI2;
  
  package SnI3 "Ideal gas \"SnI3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SnI3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SnI3.png\"></HTML>"));
  end SnI3;
  
  package SnI4 "Ideal gas \"SnI4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SnI4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SnI4.png\"></HTML>"));
  end SnI4;
  
  package SnO "Ideal gas \"SnO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SnO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SnO.png\"></HTML>"));
  end SnO;
  
  package SnO2 "Ideal gas \"SnO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SnO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SnO2.png\"></HTML>"));
  end SnO2;
  
  package SnS "Ideal gas \"SnS\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SnS);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SnS.png\"></HTML>"));
  end SnS;
  
  package SnS2 "Ideal gas \"SnS2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SnS2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SnS2.png\"></HTML>"));
  end SnS2;
  
  package Sn2 "Ideal gas \"Sn2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Sn2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Sn2.png\"></HTML>"));
  end Sn2;
  
  package Sr "Ideal gas \"Sr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Sr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Sr.png\"></HTML>"));
  end Sr;
  
  package Srplus "Ideal gas \"Sr+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Srplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Srplus.png\"></HTML>"));
  end Srplus;
  
  package SrBr "Ideal gas \"SrBr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SrBr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SrBr.png\"></HTML>"));
  end SrBr;
  
  package SrBr2 "Ideal gas \"SrBr2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SrBr2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SrBr2.png\"></HTML>"));
  end SrBr2;
  
  package SrCL "Ideal gas \"SrCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SrCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SrCL.png\"></HTML>"));
  end SrCL;
  
  package SrCLplus "Ideal gas \"SrCl+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SrCLplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SrCLplus.png\"></HTML>"));
  end SrCLplus;
  
  package SrCL2 "Ideal gas \"SrCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SrCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SrCL2.png\"></HTML>"));
  end SrCL2;
  
  package SrF "Ideal gas \"SrF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SrF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SrF.png\"></HTML>"));
  end SrF;
  
  package SrFplus "Ideal gas \"SrF+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SrFplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SrFplus.png\"></HTML>"));
  end SrFplus;
  
  package SrF2 "Ideal gas \"SrF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SrF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SrF2.png\"></HTML>"));
  end SrF2;
  
  package SrH "Ideal gas \"SrH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SrH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SrH.png\"></HTML>"));
  end SrH;
  
  package SrI "Ideal gas \"SrI\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SrI);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SrI.png\"></HTML>"));
  end SrI;
  
  package SrI2 "Ideal gas \"SrI2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SrI2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SrI2.png\"></HTML>"));
  end SrI2;
  
  package SrO "Ideal gas \"SrO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SrO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SrO.png\"></HTML>"));
  end SrO;
  
  package SrOH "Ideal gas \"SrOH\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SrOH);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SrOH.png\"></HTML>"));
  end SrOH;
  
  package SrOHplus "Ideal gas \"SrOH+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SrOHplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SrOHplus.png\"></HTML>"));
  end SrOHplus;
  
  package Sr_OH_2 "Ideal gas \"Sr_OH_2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Sr_OH_2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Sr_OH_2.png\"></HTML>"));
  end Sr_OH_2;
  
  package SrS "Ideal gas \"SrS\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.SrS);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/SrS.png\"></HTML>"));
  end SrS;
  
  package Sr2 "Ideal gas \"Sr2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Sr2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Sr2.png\"></HTML>"));
  end Sr2;
  
  package Ta "Ideal gas \"Ta\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ta);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ta.png\"></HTML>"));
  end Ta;
  
  package Taplus "Ideal gas \"Ta+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Taplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Taplus.png\"></HTML>"));
  end Taplus;
  
  package Taminus "Ideal gas \"Ta-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Taminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Taminus.png\"></HTML>"));
  end Taminus;
  
  package TaCL5 "Ideal gas \"TaCl5\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.TaCL5);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/TaCL5.png\"></HTML>"));
  end TaCL5;
  
  package TaO "Ideal gas \"TaO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.TaO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/TaO.png\"></HTML>"));
  end TaO;
  
  package TaO2 "Ideal gas \"TaO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.TaO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/TaO2.png\"></HTML>"));
  end TaO2;
  
  package Ti "Ideal gas \"Ti\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Ti);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Ti.png\"></HTML>"));
  end Ti;
  
  package Tiplus "Ideal gas \"Ti+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Tiplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Tiplus.png\"></HTML>"));
  end Tiplus;
  
  package Timinus "Ideal gas \"Ti-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Timinus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Timinus.png\"></HTML>"));
  end Timinus;
  
  package TiCL "Ideal gas \"TiCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.TiCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/TiCL.png\"></HTML>"));
  end TiCL;
  
  package TiCL2 "Ideal gas \"TiCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.TiCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/TiCL2.png\"></HTML>"));
  end TiCL2;
  
  package TiCL3 "Ideal gas \"TiCl3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.TiCL3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/TiCL3.png\"></HTML>"));
  end TiCL3;
  
  package TiCL4 "Ideal gas \"TiCl4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.TiCL4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/TiCL4.png\"></HTML>"));
  end TiCL4;
  
  package TiO "Ideal gas \"TiO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.TiO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/TiO.png\"></HTML>"));
  end TiO;
  
  package TiOplus "Ideal gas \"TiO+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.TiOplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/TiOplus.png\"></HTML>"));
  end TiOplus;
  
  package TiOCL "Ideal gas \"TiOCl\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.TiOCL);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/TiOCL.png\"></HTML>"));
  end TiOCL;
  
  package TiOCL2 "Ideal gas \"TiOCl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.TiOCL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/TiOCL2.png\"></HTML>"));
  end TiOCL2;
  
  package TiO2 "Ideal gas \"TiO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.TiO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/TiO2.png\"></HTML>"));
  end TiO2;
  
  package U "Ideal gas \"U\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.U);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/U.png\"></HTML>"));
  end U;
  
  package UF "Ideal gas \"UF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UF.png\"></HTML>"));
  end UF;
  
  package UFplus "Ideal gas \"UF+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UFplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UFplus.png\"></HTML>"));
  end UFplus;
  
  package UFminus "Ideal gas \"UF-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UFminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UFminus.png\"></HTML>"));
  end UFminus;
  
  package UF2 "Ideal gas \"UF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UF2.png\"></HTML>"));
  end UF2;
  
  package UF2plus "Ideal gas \"UF2+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UF2plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UF2plus.png\"></HTML>"));
  end UF2plus;
  
  package UF2minus "Ideal gas \"UF2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UF2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UF2minus.png\"></HTML>"));
  end UF2minus;
  
  package UF3 "Ideal gas \"UF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UF3.png\"></HTML>"));
  end UF3;
  
  package UF3plus "Ideal gas \"UF3+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UF3plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UF3plus.png\"></HTML>"));
  end UF3plus;
  
  package UF3minus "Ideal gas \"UF3-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UF3minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UF3minus.png\"></HTML>"));
  end UF3minus;
  
  package UF4 "Ideal gas \"UF4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UF4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UF4.png\"></HTML>"));
  end UF4;
  
  package UF4plus "Ideal gas \"UF4+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UF4plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UF4plus.png\"></HTML>"));
  end UF4plus;
  
  package UF4minus "Ideal gas \"UF4-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UF4minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UF4minus.png\"></HTML>"));
  end UF4minus;
  
  package UF5 "Ideal gas \"UF5\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UF5);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UF5.png\"></HTML>"));
  end UF5;
  
  package UF5plus "Ideal gas \"UF5+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UF5plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UF5plus.png\"></HTML>"));
  end UF5plus;
  
  package UF5minus "Ideal gas \"UF5-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UF5minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UF5minus.png\"></HTML>"));
  end UF5minus;
  
  package UF6 "Ideal gas \"UF6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UF6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UF6.png\"></HTML>"));
  end UF6;
  
  package UF6minus "Ideal gas \"UF6-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UF6minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UF6minus.png\"></HTML>"));
  end UF6minus;
  
  package UO "Ideal gas \"UO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UO.png\"></HTML>"));
  end UO;
  
  package UOplus "Ideal gas \"UO+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UOplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UOplus.png\"></HTML>"));
  end UOplus;
  
  package UOF "Ideal gas \"UOF\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UOF);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UOF.png\"></HTML>"));
  end UOF;
  
  package UOF2 "Ideal gas \"UOF2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UOF2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UOF2.png\"></HTML>"));
  end UOF2;
  
  package UOF3 "Ideal gas \"UOF3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UOF3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UOF3.png\"></HTML>"));
  end UOF3;
  
  package UOF4 "Ideal gas \"UOF4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UOF4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UOF4.png\"></HTML>"));
  end UOF4;
  
  package UO2 "Ideal gas \"UO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UO2.png\"></HTML>"));
  end UO2;
  
  package UO2plus "Ideal gas \"UO2+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UO2plus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UO2plus.png\"></HTML>"));
  end UO2plus;
  
  package UO2minus "Ideal gas \"UO2-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UO2minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UO2minus.png\"></HTML>"));
  end UO2minus;
  
  package UO2F "Ideal gas \"UO2F\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UO2F);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UO2F.png\"></HTML>"));
  end UO2F;
  
  package UO2F2 "Ideal gas \"UO2F2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UO2F2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UO2F2.png\"></HTML>"));
  end UO2F2;
  
  package UO3 "Ideal gas \"UO3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UO3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UO3.png\"></HTML>"));
  end UO3;
  
  package UO3minus "Ideal gas \"UO3-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.UO3minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/UO3minus.png\"></HTML>"));
  end UO3minus;
  
  package V "Ideal gas \"V\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.V);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/V.png\"></HTML>"));
  end V;
  
  package Vplus "Ideal gas \"V+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Vplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Vplus.png\"></HTML>"));
  end Vplus;
  
  package Vminus "Ideal gas \"V-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Vminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Vminus.png\"></HTML>"));
  end Vminus;
  
  package VCL4 "Ideal gas \"VCl4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.VCL4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/VCL4.png\"></HTML>"));
  end VCL4;
  
  package VN "Ideal gas \"VN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.VN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/VN.png\"></HTML>"));
  end VN;
  
  package VO "Ideal gas \"VO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.VO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/VO.png\"></HTML>"));
  end VO;
  
  package VO2 "Ideal gas \"VO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.VO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/VO2.png\"></HTML>"));
  end VO2;
  
  package V4O10 "Ideal gas \"V4O10\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.V4O10);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/V4O10.png\"></HTML>"));
  end V4O10;
  
  package W "Ideal gas \"W\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.W);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/W.png\"></HTML>"));
  end W;
  
  package Wplus "Ideal gas \"W+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Wplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Wplus.png\"></HTML>"));
  end Wplus;
  
  package Wminus "Ideal gas \"W-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Wminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Wminus.png\"></HTML>"));
  end Wminus;
  
  package WCL6 "Ideal gas \"WCl6\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.WCL6);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/WCL6.png\"></HTML>"));
  end WCL6;
  
  package WO "Ideal gas \"WO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.WO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/WO.png\"></HTML>"));
  end WO;
  
  package WOCL4 "Ideal gas \"WOCl4\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.WOCL4);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/WOCL4.png\"></HTML>"));
  end WOCL4;
  
  package WO2 "Ideal gas \"WO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.WO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/WO2.png\"></HTML>"));
  end WO2;
  
  package WO2CL2 "Ideal gas \"WO2Cl2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.WO2CL2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/WO2CL2.png\"></HTML>"));
  end WO2CL2;
  
  package WO3 "Ideal gas \"WO3\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.WO3);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/WO3.png\"></HTML>"));
  end WO3;
  
  package WO3minus "Ideal gas \"WO3-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.WO3minus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/WO3minus.png\"></HTML>"));
  end WO3minus;
  
  package Xe "Ideal gas \"Xe\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Xe);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Xe.png\"></HTML>"));
  end Xe;
  
  package Xeplus "Ideal gas \"Xe+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Xeplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Xeplus.png\"></HTML>"));
  end Xeplus;
  
  package Zn "Ideal gas \"Zn\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Zn);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Zn.png\"></HTML>"));
  end Zn;
  
  package Znplus "Ideal gas \"Zn+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Znplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Znplus.png\"></HTML>"));
  end Znplus;
  
  package Zr "Ideal gas \"Zr\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Zr);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Zr.png\"></HTML>"));
  end Zr;
  
  package Zrplus "Ideal gas \"Zr+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Zrplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Zrplus.png\"></HTML>"));
  end Zrplus;
  
  package Zrminus "Ideal gas \"Zr-\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.Zrminus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Zrminus.png\"></HTML>"));
  end Zrminus;
  
  package ZrN "Ideal gas \"ZrN\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ZrN);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ZrN.png\"></HTML>"));
  end ZrN;
  
  package ZrO "Ideal gas \"ZrO\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ZrO);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ZrO.png\"></HTML>"));
  end ZrO;
  
  package ZrOplus "Ideal gas \"ZrO+\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ZrOplus);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ZrOplus.png\"></HTML>"));
  end ZrOplus;
  
  package ZrO2 "Ideal gas \"ZrO2\" from NASA Glenn coefficients" 
    extends Common.SingleGasNasa(data=Common.SingleGasesData.ZrO2);
    annotation (preferedView="info", Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/ZrO2.png\"></HTML>"));
  end ZrO2;
  
end SingleGases;
